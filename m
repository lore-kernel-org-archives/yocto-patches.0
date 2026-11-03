Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1923.1793669446338888573
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Nov 2026 17:30:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wCnOt3TOOlqYLgBAA--.8812S3;
	Tue, 03 Nov 2026 09:28:52 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABH2Gh_OOlqOAgrAA--.28414S2;
	Tue, 03 Nov 2026 09:27:27 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org,
	richard.purdie@linuxfoundation.org,
	mark.hatle@kernel.crashing.org
Cc: chen_q07@163.com
Subject: [pseudo][PATCH V2 1/2] pseudo_client: resolve /proc/<pid>/fd/<n> to the descriptor
Date: Tue,  3 Nov 2026 09:30:27 +0800
Message-ID: <20261103013028.3295799-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABH2Gh_OOlqOAgrAA--.28414S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYACmrokZQITwAAsO
X-CM-DELIVERINFO: =?B?m8FPT6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOP9Uj60Bown3/XUUl7ZP32Jc9uTDcTmMt94+s6G7DhR58HmPHlNHSznCxtqUQknS/JJ7
	w1+hj+Ge76+3hMcHFnCUA8NEZv24jrx7kQenjGgKNq9/JwQgJOuK+8cf2lWfaQ==
X-Coremail-Antispam: 1Uk129KBj9fXoW3ZF48AFWxJFy5Jr48GrW8KrX_yoW8Jw48Go
	WIgr1vvw10qr4Duryv93Zrtw1UWF1xur1UXw4rCryDGFnYqrWrWrZ3Zr4rX343Wr4rKrW5
	Aw1Sg3s3AF48t3s3l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn5xqx4xG64xvF2IEw4CE5I8CrVC2j2Wlc2xSY4AK67AK6w7v73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r126r1DMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jUuc_UUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 01:30:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5214
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

Paths such as /proc/self/fd/<n> and /dev/fd/<n> denote the open file: the
kernel resolves them to the descriptor, so an O_PATH|O_NOFOLLOW descriptor
on a symlink addresses the symlink itself.

Path canonicalization expands them with readlink(2) and follows the
result, which changes that meaning.  For a descriptor on a symlink an
xattr set through it lands on the link target instead of the link, and for
a dangling symlink the call fails with ENOENT.  Once expanded, the path no
longer looks like something pseudo tracks either, so the operation is
passed straight through to the real syscall.

libselinux 3.11 labels the rootfs through such descriptors, so setfiles
could not label any symlink and do_image fell back to a first boot
relabel:

  setfiles: Could not set context for .../etc/mtab:  No such file or directory
  setfiles: Could not set context for .../etc/systemd/system/default.target:  Operation not permitted

Rewrite the reference to the path pseudo recorded for the descriptor,
which keeps the operation under pseudo's control.  The descriptor itself
identifies the inode, so the final component is followed only when
following it is what reproduces that inode, i.e. for a descriptor obtained
through a symlink.  When the caller passes AT_SYMLINK_NOFOLLOW the
reference itself is what is being asked about (readlink, lstat, l*xattr),
so it is left alone for the kernel to resolve.

Adds test/test-proc-fd.sh covering both descriptor flavours.

Assisted-by: Codewhale:deepseek-v4-flash
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 pseudo_client.c      | 110 +++++++++++++++++++++++++++
 pseudo_client.h      |   2 +
 pseudo_util.c        |   2 +
 pseudo_wrappers.c    |   2 +
 test/test-proc-fd.c  | 174 +++++++++++++++++++++++++++++++++++++++++++
 test/test-proc-fd.sh |  17 +++++
 6 files changed, 307 insertions(+)
 create mode 100644 test/test-proc-fd.c
 create mode 100755 test/test-proc-fd.sh

diff --git a/pseudo_client.c b/pseudo_client.c
index 302ef21..c8247e8 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -1451,12 +1451,112 @@ pseudo_client_shutdown(int wait_on_socket) {
 	return 0;
 }
 
+/* /proc/self/fd/<n>, /proc/<pid>/fd/<n> and /dev/fd/<n> denote the open file,
+ * not the path the magic link prints.  Canonicalization resolves symlinks with
+ * readlink(2), which changes the meaning of such a path: the kernel resolves it
+ * to the descriptor, so an O_PATH|O_NOFOLLOW descriptor on a symlink addresses
+ * the symlink itself, whereas the expansion yields the link target and then
+ * follows it.  That labels the wrong inode, or fails when the target does not
+ * resolve.
+ *
+ * Rewrite the reference to the path pseudo recorded for the descriptor, which
+ * also puts the operation under pseudo's control instead of passing it through.
+ * The descriptor itself identifies the inode, so the final component is only
+ * followed when following it is what reproduces that inode, i.e. for a
+ * descriptor obtained through a symlink.  Returns NULL to leave the path alone.
+ */
+static char *
+rewrite_proc_fd_ref(const char *path, int *leave_last) {
+	const char *p;
+	const char *digits;
+	const char *recpath;
+	char *out;
+	PSEUDO_STATBUF fbuf, pbuf;
+	int fd = 0;
+
+	if (!path || path[0] != '/')
+		return NULL;
+
+	if (!strncmp(path, "/dev/fd/", 8)) {
+		p = path + 8;
+	} else if (!strncmp(path, "/proc/", 6)) {
+		p = path + 6;
+		if (!strncmp(p, "self/fd/", 8)) {
+			p += 8;
+		} else if (!strncmp(p, "thread-self/fd/", 15)) {
+			p += 15;
+		} else {
+			const char *q = p;
+
+			while (*q >= '0' && *q <= '9')
+				++q;
+			if (q == p || strncmp(q, "/fd/", 4))
+				return NULL;
+			p = q + 4;
+		}
+	} else {
+		return NULL;
+	}
+
+	digits = p;
+	while (*p >= '0' && *p <= '9') {
+		if (fd > (0x7fffffff - 9) / 10)
+			return NULL;
+		fd = fd * 10 + (*p - '0');
+		++p;
+	}
+	if (p == digits || (*p != '\0' && *p != '/'))
+		return NULL;
+
+	recpath = fd_path(fd);
+	if (!recpath || recpath[0] != '/')
+		return NULL;
+
+	/* Within a chroot the recorded path carries the chroot prefix, while
+	 * base_path() adds that prefix to absolute paths.  Strip it, or give up
+	 * if the descriptor is not inside the chroot.
+	 */
+	if (pseudo_chroot_len) {
+		if (strncmp(recpath, pseudo_chroot, pseudo_chroot_len) ||
+		    (recpath[pseudo_chroot_len] != '\0' && recpath[pseudo_chroot_len] != '/'))
+			return NULL;
+		recpath += pseudo_chroot_len;
+		if (*recpath == '\0')
+			recpath = "/";
+	}
+
+	if (*p != '\0') {
+		size_t len = strlen(recpath) + strlen(p) + 1;
+
+		out = malloc(len);
+		if (!out)
+			return NULL;
+		snprintf(out, len, "%s%s", recpath, p);
+		return out;
+	}
+
+	if (!pseudo_real_fstat || !pseudo_real_lstat)
+		return NULL;
+	if (pseudo_real_fstat(fd, &fbuf) == -1)
+		return NULL;
+	if (pseudo_real_lstat(recpath, &pbuf) == 0 &&
+	    pbuf.st_dev == fbuf.st_dev && pbuf.st_ino == fbuf.st_ino) {
+		*leave_last = 1;
+	} else if (pseudo_real_stat == NULL || pseudo_real_stat(recpath, &pbuf) == -1 ||
+		   pbuf.st_dev != fbuf.st_dev || pbuf.st_ino != fbuf.st_ino) {
+		/* The recorded path no longer describes this descriptor. */
+		return NULL;
+	}
+	return strdup(recpath);
+}
+
 static char *
 base_path(int dirfd, const char *path, int leave_last) {
 	char *basepath = 0;
 	size_t baselen = 0;
 	size_t minlen = 0;
 	char *newpath;
+	char *rewritten;
 
 	if (!path)
 		return NULL;
@@ -1501,7 +1601,17 @@ base_path(int dirfd, const char *path, int leave_last) {
 		minlen = pseudo_chroot_len;
 	}
 
+	/* Only when the caller follows the final component.  With
+	 * AT_SYMLINK_NOFOLLOW the reference itself is what the caller asks
+	 * about (readlink, lstat, l*xattr), so it must be left for the kernel
+	 * to resolve.
+	 */
+	rewritten = leave_last ? NULL : rewrite_proc_fd_ref(path, &leave_last);
+	if (rewritten)
+		path = rewritten;
+
 	newpath = pseudo_fix_path(basepath, path, minlen, baselen, NULL, leave_last);
+	free(rewritten);
 	pseudo_debug(PDBGF_PATH, "base_path[%s]: %s</>%s => %s\n",
 		leave_last ? "nofollow" : "follow",
 		basepath ? basepath : "<nil>",
diff --git a/pseudo_client.h b/pseudo_client.h
index 9b9f86a..b3f9f49 100644
--- a/pseudo_client.h
+++ b/pseudo_client.h
@@ -51,6 +51,8 @@ extern FILE *pseudo_grp;
 
 /* pseudo_wrappers will try to initialize these */
 extern int (*pseudo_real_lstat)(const char *path, PSEUDO_STATBUF *buf);
+extern int (*pseudo_real_fstat)(int fd, PSEUDO_STATBUF *buf);
+extern int (*pseudo_real_stat)(const char *path, PSEUDO_STATBUF *buf);
 extern int (*pseudo_real_fork)(void);
 extern int (*pseudo_real_execv)(const char *, char * const *);
 
diff --git a/pseudo_util.c b/pseudo_util.c
index 6e7c465..12718a5 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -99,6 +99,8 @@ static int pseudo_util_initted = -1;  /* Not yet run */
 
 /* bypass wrapper logic on path computations */
 int (*pseudo_real_lstat)(const char *path, PSEUDO_STATBUF *buf) = NULL;
+int (*pseudo_real_fstat)(int fd, PSEUDO_STATBUF *buf) = NULL;
+int (*pseudo_real_stat)(const char *path, PSEUDO_STATBUF *buf) = NULL;
 /* bash workaround */
 int (*pseudo_real_unsetenv)(const char *) = unsetenv;
 char * (*pseudo_real_getenv)(const char *) = getenv;
diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
index 16a451a..d073b1e 100644
--- a/pseudo_wrappers.c
+++ b/pseudo_wrappers.c
@@ -174,6 +174,8 @@ pseudo_init_wrappers(void) {
 	pseudo_real_fsetxattr = real_fsetxattr;
 #endif
 	pseudo_real_lstat = base_lstat;
+	pseudo_real_fstat = base_fstat;
+	pseudo_real_stat = base_stat;
 	/* and these are used so the client's server spawn can bypass
 	 * wrappers.
 	 */
diff --git a/test/test-proc-fd.c b/test/test-proc-fd.c
new file mode 100644
index 0000000..9550809
--- /dev/null
+++ b/test/test-proc-fd.c
@@ -0,0 +1,174 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * Check that xattr operations on /proc/self/fd/<n> address the file the
+ * descriptor refers to, and not the path the magic link prints.
+ *
+ * A descriptor opened with O_PATH|O_NOFOLLOW on a symlink denotes the
+ * symlink itself, so a context set through it must land on the link and
+ * leave the target alone.  A descriptor opened by following a symlink
+ * denotes the target, so the context must land there instead.
+ *
+ * Exit status: 0 all checks passed, 1 a check failed, 255 skipped because
+ * the platform has no xattr support.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/xattr.h>
+
+#define CTX "security.selinux"
+
+static int failures;
+
+static void
+fail(const char *what, const char *detail)
+{
+	printf("  FAIL  %-52s %s\n", what, detail);
+	++failures;
+}
+
+static void
+pass(const char *what)
+{
+	printf("  PASS  %s\n", what);
+}
+
+/* Read the context of path itself, without following a final symlink.
+ * Returns NULL when there is none.
+ */
+static const char *
+get_ctx(const char *path, char *buf, size_t buflen)
+{
+	ssize_t n = lgetxattr(path, CTX, buf, buflen - 1);
+
+	if (n < 0)
+		return NULL;
+	buf[n] = '\0';
+	return buf;
+}
+
+static void
+expect_ctx(const char *what, const char *path, const char *want)
+{
+	char buf[256];
+	const char *got = get_ctx(path, buf, sizeof buf);
+
+	if (!want) {
+		if (got)
+			fail(what, got);
+		else
+			pass(what);
+		return;
+	}
+	if (got && strcmp(got, want) == 0)
+		pass(what);
+	else
+		fail(what, got ? got : "<no context>");
+}
+
+/* Set the context through the descriptor, the same way libselinux does when
+ * it pins a file: path-based call, no extra flags.
+ */
+static int
+set_via_fd(int fd, const char *value)
+{
+	char path[64];
+
+	snprintf(path, sizeof path, "/proc/self/fd/%d", fd);
+	return setxattr(path, CTX, value, strlen(value) + 1, 0);
+}
+
+int
+main(int argc, char **argv)
+{
+	const char *dir = argc > 1 ? argv[1] : ".";
+	char path[512];
+	int fd;
+
+	snprintf(path, sizeof path, "%s/file", dir);
+	if (close(open(path, O_CREAT | O_WRONLY, 0644)) == -1) {
+		perror(path);
+		return 1;
+	}
+	snprintf(path, sizeof path, "%s/link", dir);
+	if (symlink("file", path) == -1) {
+		perror(path);
+		return 1;
+	}
+	snprintf(path, sizeof path, "%s/dangling", dir);
+	if (symlink("/nonexistent/xyz", path) == -1) {
+		perror(path);
+		return 1;
+	}
+
+	/* 1. O_PATH|O_NOFOLLOW on a symlink: label the link, not its target. */
+	snprintf(path, sizeof path, "%s/link", dir);
+	fd = open(path, O_PATH | O_NOFOLLOW);
+	if (fd == -1) {
+		perror(path);
+		return 1;
+	}
+	if (set_via_fd(fd, "onlink") == -1 && errno == ENOTSUP) {
+		printf("  SKIP  xattr support unavailable\n");
+		return 255;
+	}
+	close(fd);
+
+	snprintf(path, sizeof path, "%s/link", dir);
+	expect_ctx("context landed on the symlink", path, "onlink");
+	snprintf(path, sizeof path, "%s/file", dir);
+	expect_ctx("context did not land on the target", path, NULL);
+
+	/* 2. A dangling symlink must not make the operation fail. */
+	snprintf(path, sizeof path, "%s/dangling", dir);
+	fd = open(path, O_PATH | O_NOFOLLOW);
+	if (fd == -1) {
+		perror(path);
+		return 1;
+	}
+	if (set_via_fd(fd, "ondangling") == -1) {
+		fail("context set on a dangling symlink", strerror(errno));
+	} else {
+		pass("context set on a dangling symlink");
+	}
+	close(fd);
+	expect_ctx("context landed on the dangling link", path, "ondangling");
+
+	/* 3. A descriptor obtained by following a symlink denotes the target. */
+	snprintf(path, sizeof path, "%s/target", dir);
+	if (close(open(path, O_CREAT | O_WRONLY, 0644)) == -1) {
+		perror(path);
+		return 1;
+	}
+	snprintf(path, sizeof path, "%s/link2", dir);
+	if (symlink("target", path) == -1) {
+		perror(path);
+		return 1;
+	}
+	fd = open(path, O_RDONLY);
+	if (fd == -1) {
+		perror(path);
+		return 1;
+	}
+	if (set_via_fd(fd, "ontarget") == -1) {
+		fail("context set through a followed descriptor", strerror(errno));
+	} else {
+		pass("context set through a followed descriptor");
+	}
+	close(fd);
+
+	snprintf(path, sizeof path, "%s/target", dir);
+	expect_ctx("context landed on the target", path, "ontarget");
+	snprintf(path, sizeof path, "%s/link2", dir);
+	expect_ctx("context did not land on the link", path, NULL);
+
+	printf("%s: %d check(s) failed\n", failures ? "FAIL" : "OK", failures);
+	return failures ? 1 : 0;
+}
diff --git a/test/test-proc-fd.sh b/test/test-proc-fd.sh
new file mode 100755
index 0000000..4a7f8ba
--- /dev/null
+++ b/test/test-proc-fd.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# Regressions guarded here: an xattr call on /proc/self/fd/<n> must address
+# the file the descriptor refers to.  Path canonicalization used to expand the
+# magic link with readlink(2) and then follow the result, so a context set
+# through an O_PATH|O_NOFOLLOW descriptor on a symlink landed on the link
+# target, and a dangling link made the call fail with ENOENT.  libselinux 3.11
+# labels the rootfs that way, which left every symlink in the image unlabelled.
+#
+# The temporary tree has to live below $PWD so that pseudo tracks it.
+
+tmpdir="$(mktemp -d -p "$PWD" proc_fd_XXXXXX)"
+trap "rm -rf '$tmpdir'" EXIT TERM INT
+
+./test/test-proc-fd "$tmpdir"
-- 
2.43.0

