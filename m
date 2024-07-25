Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C0FC3DA49
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 19:23:49 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.44555.1721935422956025210
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 12:23:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 46PJMa4n009002;
	Thu, 25 Jul 2024 14:22:37 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: mark.hatle@amd.com, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH] Bugfix for Linux open(O_CREAT|O_EXCL)
Date: Thu, 25 Jul 2024 14:22:36 -0500
Message-Id: <1721935356-14126-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 19:23:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/479

From: Simon Lindholm <simon.lindholm@volvocars.com>

In Linux, when calling open(path, O_CREAT|O_EXCL) it implies O_NOFOLLOW.
If the path exists and is a symlink, the link shouldn't be resolved but
rather just fail directly with EEXIST. Resolving the symlink causes
problems with e.g. extracting files with GNU tar where strange errors
ensue when it tries to overwrite an existing symlink.

Fix the bug by not resolving symlinks for open (and the related
functions) if O_EXCL is set.

For original patch from Simon Lindholm see:
See: https://bugzilla.yoctoproject.org/show_bug.cgi?id=15559

Original submission was modified to specifically check for BOTH
O_CREAT|O_EXCL, as this matches the behavior in the Linux kernel:

   fs/open.c: build_open_flags(...)

        if (flags & O_CREAT) {
                op->intent |= LOOKUP_CREATE;
                if (flags & O_EXCL) {
                        op->intent |= LOOKUP_EXCL;
                        flags |= O_NOFOLLOW;
                }
        }

If the kernel sees O_CREAT and O_EXCL, it assumes O_NOFOLLOW, we need to
duplicate the same behavior.  Note, this behavior is likely Linux specific
thus implemented in the ports/linu/wrapfuncs.in.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 makewrappers               |  5 +-
 ports/linux/wrapfuncs.in   | 12 ++---
 test/test-open-symlinks.c  | 99 ++++++++++++++++++++++++++++++++++++++
 test/test-open-symlinks.sh | 18 +++++++
 4 files changed, 126 insertions(+), 8 deletions(-)
 create mode 100644 test/test-open-symlinks.c
 create mode 100755 test/test-open-symlinks.sh

diff --git a/makewrappers b/makewrappers
index 1e80e30..1f7ddce 100755
--- a/makewrappers
+++ b/makewrappers
@@ -291,15 +291,16 @@ class Function:
 
         # handle special comments, such as flags=AT_SYMLINK_NOFOLLOW
         if self.comments:
+            comments = self.comments.replace('==','<equals>')
             # Build a dictionary of key=value, key=value pairs
-            modifiers = dict(mod.split("=") for mod in self.comments.split(','))
+            modifiers = dict(mod.split("=") for mod in comments.split(','))
             # Strip all leading/trailing whitespace
             modifiers = {k.strip():v.strip() for k, v in modifiers.items()}
 
             arch = "-" + platform.machine()
             # Sorted so that versions-foo appear after versions, so overrides are easy
             for key in sorted(modifiers):
-                value = modifiers[key]
+                value = modifiers[key].replace('<equals>', '==')
                 # If the key is version-arm64 and we're on arm64 then rename this to version
                 if key.endswith(arch):
                     key = key.replace(arch, "")
diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
index 97b16c2..60ce5f5 100644
--- a/ports/linux/wrapfuncs.in
+++ b/ports/linux/wrapfuncs.in
@@ -1,4 +1,4 @@
-int open(const char *path, int flags, ...{mode_t mode}); /* flags=flags&O_NOFOLLOW, noignore_path=1 */
+int open(const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 char *get_current_dir_name(void);
 int __xstat(int ver, const char *path, struct stat *buf);
 int __lxstat(int ver, const char *path, struct stat *buf); /* flags=AT_SYMLINK_NOFOLLOW */
@@ -6,8 +6,8 @@ int __fxstat(int ver, int fd, struct stat *buf);
 int lchmod(const char *path, mode_t mode); /* flags=AT_SYMLINK_NOFOLLOW */
 int lchown(const char *path, uid_t owner, gid_t group); /* flags=AT_SYMLINK_NOFOLLOW */
 int __fxstatat(int ver, int dirfd, const char *path, struct stat *buf, int flags);
-int openat(int dirfd, const char *path, int flags, ...{mode_t mode}); /* flags=flags&O_NOFOLLOW, noignore_path=1 */
-int __openat_2(int dirfd, const char *path, int flags); /* flags=flags&O_NOFOLLOW, noignore_path=1 */
+int openat(int dirfd, const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
+int __openat_2(int dirfd, const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int mknod(const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknod */
 int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknodat */
 int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW */
@@ -17,9 +17,9 @@ int fcntl64(int fd, int cmd, ...{struct flock *lock});  /* noignore_path=1 */
 # just so we know the inums of symlinks
 char *canonicalize_file_name(const char *filename);
 int eaccess(const char *path, int mode);
-int open64(const char *path, int flags, ...{mode_t mode}); /* flags=flags&O_NOFOLLOW, noignore_path=1 */
-int openat64(int dirfd, const char *path, int flags, ...{mode_t mode}); /* flags=flags&O_NOFOLLOW, noignore_path=1 */
-int __openat64_2(int dirfd, const char *path, int flags); /* flags=flags&O_NOFOLLOW, noignore_path=1 */
+int open64(const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
+int openat64(int dirfd, const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
+int __openat64_2(int dirfd, const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int creat64(const char *path, mode_t mode);
 int stat(const char *path, struct stat *buf); /* real_func=pseudo_stat */
 int lstat(const char *path, struct stat *buf); /* real_func=pseudo_lstat, flags=AT_SYMLINK_NOFOLLOW */
diff --git a/test/test-open-symlinks.c b/test/test-open-symlinks.c
new file mode 100644
index 0000000..4bb5a87
--- /dev/null
+++ b/test/test-open-symlinks.c
@@ -0,0 +1,99 @@
+#include <stdio.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+
+
+struct testcase {
+    const char * pathname;
+    int flags;
+    mode_t mode;
+    int expected_errno;
+};
+
+/*
+* List of test cases to run. The files (given by 'pathname') are expected to be
+* setup by test-open-symlinks.sh.
+*/
+static const struct testcase testcases[] = {
+    { "a", O_WRONLY|O_CREAT|O_EXCL, 0644, EEXIST },
+    { "a", O_RDWR|O_CREAT|O_EXCL, 0644, EEXIST },
+    { "b", O_WRONLY|O_CREAT|O_EXCL, 0644, EEXIST },
+    { "b", O_RDWR|O_CREAT|O_EXCL, 0644, EEXIST },
+    { NULL }
+};
+
+static bool run_testcase(const char * progname,
+                         const struct testcase * testcase);
+
+static int try_open(const char * pathname, int flags, mode_t mode);
+
+/*
+* Given a directory (which is expected to be setup containing some files by
+* test-open-symlinks.sh), loop through the test cases listed above and check
+* that when calling open(pathname, flags, mode), errno is set to the expected
+* value.
+*/
+int main(int argc, char *argv[]) {
+    const char * progname = argv[0];
+
+    if (argc != 2) {
+        fprintf(stderr, "usage: %s <dir>\n", progname);
+        return 1;
+    }
+
+    const char * dirname = argv[1];
+    if (chdir(dirname) != 0) {
+        perror(dirname);
+        return 1;
+    }
+
+    bool ok = true;
+
+    for (int i = 0; testcases[i].pathname; i++) {
+        ok &= run_testcase(progname, &testcases[i]);
+    }
+
+    return ok ? 0 : 1;
+}
+
+/*
+* Given a test case of (pathname, flags, mode, expected_errno), open the file
+* with the given arguments and return true if the actual errno matches the
+* expected one, or otherwise false.
+*/
+static bool run_testcase(const char * progname,
+                         const struct testcase * testcase) {
+
+    int actual_errno = try_open(testcase->pathname,
+                                testcase->flags,
+                                testcase->mode);
+
+    if (actual_errno != testcase->expected_errno) {
+        fprintf(stderr, "%s: open(%s, 0x%x, %o) -> %s (expected: %s)\n",
+               progname, testcase->pathname, testcase->flags, testcase->mode,
+               strerror(actual_errno), strerror(testcase->expected_errno));
+        return false;
+    }
+
+    return true;
+}
+
+/*
+* open() a file with the given flags and mode and return errno (or 0, if the
+* file was successfully opened).
+*/
+static int try_open(const char * pathname, int flags, mode_t mode) {
+    int fd = open(pathname, flags, mode);
+
+    if (fd >= 0) {
+        close(fd);
+        return 0;
+    }
+
+    return errno;
+}
diff --git a/test/test-open-symlinks.sh b/test/test-open-symlinks.sh
new file mode 100755
index 0000000..b58c75c
--- /dev/null
+++ b/test/test-open-symlinks.sh
@@ -0,0 +1,18 @@
+#! /bin/sh
+
+# * Create a temporary directory
+# * Create some symlinks in the directory
+# * Run test/test-open-symlinks, which will call open(O_CREAT|O_EXCL) on the
+#   symlinks in the directory and check that errno is EEXIST.
+
+tmpdir="$(mktemp -d -p "$PWD")"
+trap "rm -rf '$tmpdir'" EXIT TERM INT
+
+# 'a' is a symlink to a file that doesn't exist
+ln -s noexist.txt "$tmpdir/a"
+
+# 'b' is a symlink to a file that doesn't exist and where we also don't have
+# write permissions to the parent directory (of the target).
+ln -s /root/noexist.txt "$tmpdir/b"
+
+./test/test-open-symlinks "$tmpdir"
-- 
2.34.1


