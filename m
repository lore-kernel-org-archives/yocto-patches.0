Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48335FF885C
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 23:02:34 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1797.1777071745414275353
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 16:02:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63ON2Dbx287175;
	Fri, 24 Apr 2026 18:02:15 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, dburgener@linux.microsoft.com,
        peter.kjellerstedt@axis.com
Subject: [yocto-patches][pseudo][PATCH 3/3] test: Add test for linkat chroot path stripping
Date: Fri, 24 Apr 2026 18:02:13 -0500
Message-Id: <1777071733-25858-4-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1777071733-25858-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1777071733-25858-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 23:02:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3813

From: Mark Hatle <mark.hatle@amd.com>

A bug in linkat's chroot path stripping logic used strncmp() without
negation, causing it to strip the chroot prefix when the path did NOT
match.  Also it accessed memory out of bounds when the path was shorter
than pseudo_chroot_len. This was fixed in the previous commit.

Add a test that exercises this scenario by creating a chroot with a
long directory path, then calling link() on short paths (/a -> /b)
inside the chroot. The paths are placed at the end of a mapped memory
page (via mmap) with the next page unmapped, so the out-of-bounds read
at oldpath[pseudo_chroot_len] reliably causes a segfault rather than
silently reading adjacent mapped memory.

AI-Generated: Test code written by Claude Opus 4.6.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 test/test-linkat-chroot.c  | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 test/test-linkat-chroot.sh | 19 +++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 test/test-linkat-chroot.c
 create mode 100755 test/test-linkat-chroot.sh

diff --git a/test/test-linkat-chroot.c b/test/test-linkat-chroot.c
new file mode 100644
index 0000000..e02989e
--- /dev/null
+++ b/test/test-linkat-chroot.c
@@ -0,0 +1,69 @@
+/*
+ * Test that link/linkat inside a chroot does not segfault
+ * when the path is shorter than the chroot path.
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * The bug was that linkat's chroot path stripping used strncmp()
+ * without negation, causing an out-of-bounds read at
+ * oldpath[pseudo_chroot_len] when the path was shorter than the
+ * chroot path. To reliably trigger this, we place the path string
+ * at the end of a mapped page with the next page unmapped, so any
+ * out-of-bounds access will SIGSEGV.
+ */
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+
+/* Place str at the end of a page with the next page unmapped.
+ * Any read past the string will hit unmapped memory and SIGSEGV. */
+static char *guarded_string(const char *str) {
+    long pagesize = sysconf(_SC_PAGESIZE);
+    size_t len = strlen(str) + 1;
+    char *pages = mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
+                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (pages == MAP_FAILED) {
+        perror("mmap");
+        return NULL;
+    }
+    if (munmap(pages + pagesize, pagesize) == -1) {
+        perror("munmap");
+        return NULL;
+    }
+    char *dest = pages + pagesize - len;
+    memcpy(dest, str, len);
+    return dest;
+}
+
+int main(int argc, char *argv[]) {
+    if (argc != 2) {
+        fprintf(stderr, "usage: %s <chrootdir>\n", argv[0]);
+        return 2;
+    }
+    if (chroot(argv[1]) == -1) {
+        perror("chroot");
+        return 1;
+    }
+    if (chdir("/") == -1) {
+        perror("chdir");
+        return 1;
+    }
+
+    char *oldpath = guarded_string("/a");
+    char *newpath = guarded_string("/b");
+    if (!oldpath || !newpath)
+        return 1;
+
+    /* link() calls linkat() internally. The short paths are placed
+     * at page boundaries so that the buggy out-of-bounds read at
+     * oldpath[pseudo_chroot_len] will SIGSEGV instead of silently
+     * reading adjacent memory. */
+    if (link(oldpath, newpath) == -1) {
+        perror("link");
+        return 1;
+    }
+    return 0;
+}
diff --git a/test/test-linkat-chroot.sh b/test/test-linkat-chroot.sh
new file mode 100755
index 0000000..247a6d7
--- /dev/null
+++ b/test/test-linkat-chroot.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+#
+# Test that link/linkat inside a chroot does not segfault
+# when the path is shorter than the chroot path.
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+
+set -e
+
+# Create a chroot directory with a deeply nested path
+# so pseudo_chroot_len is longer than the filenames used inside
+CHROOTDIR=$(pwd)/linkat_chroot_test/deep/nested/path/to/make/it/long
+mkdir -p "$CHROOTDIR"
+touch "$CHROOTDIR/a"
+trap "rm -rf $(pwd)/linkat_chroot_test test-linkat-chroot" 0
+
+gcc -o test-linkat-chroot test/test-linkat-chroot.c
+
+./test-linkat-chroot "$CHROOTDIR"
-- 
1.8.3.1


