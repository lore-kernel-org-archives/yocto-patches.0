Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.561.1794413715285642733
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 08:15:15 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6ABGFDdg2529923
	for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 10:15:14 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][pseudo-1.9]PATCH 01/10] test: Skip open_tree tests when the function or syscall is unavailable
Date: Wed, 11 Nov 2026 10:15:03 -0600
Message-Id: <1794413712-18072-2-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 16:15:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

test-open_tree failed to build on systems where glibc does not provide
open_tree() (added in glibc 2.36), e.g. Ubuntu 22.04, breaking 'make test'.

Declare open_tree() weak so the test links, and skip the test if the
symbol is not resolved or the call returns ENOSYS. Under pseudo the
symbol always resolves to libpseudo's wrapper, which returns ENOSYS
when libc lacks open_tree().

test-open_tree_attr-syscall failed on kernels older than 6.15 which do
not implement the open_tree_attr syscall. Probe the syscall first and
skip the test if it returns ENOSYS.

Both tests return 77 to indicate a skip, which the shell wrappers convert
to 255 so run_tests.sh reports them as skipped, matching the existing
openat2 tests.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
(cherry picked from commit ef3fadb80ea4822fd6ddbdd6fd21dd6a358f010f)
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 test/test-open_tree.c               | 25 +++++++++++++++++++++++++
 test/test-open_tree.sh              | 15 +++++++++++++--
 test/test-open_tree_attr-syscall.c  | 11 +++++++++++
 test/test-open_tree_attr-syscall.sh | 15 +++++++++++++--
 4 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/test/test-open_tree.c b/test/test-open_tree.c
index 9570f11..3b1b7ea 100644
--- a/test/test-open_tree.c
+++ b/test/test-open_tree.c
@@ -10,6 +10,14 @@
 #define TEST_DIR "test-open-tree-dir"
 #define TEST_FILE "test-open-tree-file"
 
+/*
+ * Older glibc versions (< 2.36) do not provide open_tree().  Declare it
+ * weak so the test still links; at runtime it resolves to glibc's or
+ * libpseudo's open_tree if either provides it, otherwise it is NULL and
+ * the test is skipped.
+ */
+extern int open_tree(int dirfd, const char *path, unsigned int flags) __attribute__((weak));
+
 static int test_no_flags(void) {
     int treefd = -1;
     int fd = -1;
@@ -124,6 +132,23 @@ static void cleanup(void) {
 }
 
 int main(void) {
+    int probefd;
+
+    if (!open_tree) {
+        fprintf(stderr, "open_tree() not available, skipping.\n");
+        return 77;
+    }
+
+    /* pseudo exports open_tree() but returns ENOSYS if libc lacks it */
+    probefd = open_tree(AT_FDCWD, ".", 0);
+    if (probefd == -1 && errno == ENOSYS) {
+        fprintf(stderr, "open_tree() returned ENOSYS, skipping.\n");
+        return 77;
+    }
+    if (probefd != -1) {
+        close(probefd);
+    }
+
     cleanup();
 
     if (mkdir(TEST_DIR, 0777) == -1) {
diff --git a/test/test-open_tree.sh b/test/test-open_tree.sh
index 427d550..274c654 100755
--- a/test/test-open_tree.sh
+++ b/test/test-open_tree.sh
@@ -1,9 +1,20 @@
 #!/bin/sh
 
-./test/test-open_tree
+# rc 77 indicates open_tree() is not available, so report skipped (255).
+# This usually indicates that glibc does not have the open_tree function.
+run_test() {
+	"$@"
+	rc=$?
+	if [ "$rc" -eq 77 ]; then
+		exit 255
+	fi
+	return "$rc"
+}
+
+run_test ./test/test-open_tree
 rc1=$?
 
-PSEUDO_IGNORE_PATHS=/ ./test/test-open_tree
+run_test env PSEUDO_IGNORE_PATHS=/ ./test/test-open_tree
 rc2=$?
 
 exit $((rc1 | rc2))
diff --git a/test/test-open_tree_attr-syscall.c b/test/test-open_tree_attr-syscall.c
index cc38c5f..e4e652e 100644
--- a/test/test-open_tree_attr-syscall.c
+++ b/test/test-open_tree_attr-syscall.c
@@ -150,6 +150,17 @@ static void cleanup(void) {
 }
 
 int main(void) {
+    int probefd;
+
+    probefd = do_open_tree_attr_syscall(AT_FDCWD, ".", 0);
+    if (probefd == -1 && errno == ENOSYS) {
+        fprintf(stderr, "open_tree_attr syscall not supported, skipping.\n");
+        return 77;
+    }
+    if (probefd != -1) {
+        close(probefd);
+    }
+
     cleanup();
 
     if (mkdir(TEST_DIR, 0777) == -1) {
diff --git a/test/test-open_tree_attr-syscall.sh b/test/test-open_tree_attr-syscall.sh
index f6e51f4..d87043e 100755
--- a/test/test-open_tree_attr-syscall.sh
+++ b/test/test-open_tree_attr-syscall.sh
@@ -1,9 +1,20 @@
 #!/bin/sh
 
-./test/test-open_tree_attr-syscall
+# rc 77 indicates the open_tree_attr syscall is not supported (ENOSYS),
+# so report skipped (255).  This usually indicates an older kernel.
+run_test() {
+	"$@"
+	rc=$?
+	if [ "$rc" -eq 77 ]; then
+		exit 255
+	fi
+	return "$rc"
+}
+
+run_test ./test/test-open_tree_attr-syscall
 rc1=$?
 
-PSEUDO_IGNORE_PATHS=/ ./test/test-open_tree_attr-syscall
+run_test env PSEUDO_IGNORE_PATHS=/ ./test/test-open_tree_attr-syscall
 rc2=$?
 
 exit $((rc1 | rc2))
-- 
1.8.3.1

