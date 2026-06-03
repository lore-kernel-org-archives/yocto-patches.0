Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFF5CD6E6B
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 20:39:21 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30003.1780519152627849019
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 13:39:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 653Kd9V12263173;
	Wed, 3 Jun 2026 15:39:10 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 3/6] tests: Add test that returned stat is correct
Date: Wed,  3 Jun 2026 15:39:05 -0500
Message-Id: <1780519148-30836-4-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1780519148-30836-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1780519148-30836-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 20:39:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4127

From: Mark Hatle <mark.hatle@amd.com>

There are concerns that if PSEUDO_FS_MODE and PSEUDO_DB_MODE get out of
sync with each other that invalid modules could be returned in some
cases.

AI-Generated: Implemented with the assistance of github CoPilot (Claude Opus 4.6)

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 test/test-db-mode.c  | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++
 test/test-db-mode.sh |  10 +++++
 2 files changed, 127 insertions(+)
 create mode 100644 test/test-db-mode.c
 create mode 100755 test/test-db-mode.sh

diff --git a/test/test-db-mode.c b/test/test-db-mode.c
new file mode 100644
index 0000000..1e470c2
--- /dev/null
+++ b/test/test-db-mode.c
@@ -0,0 +1,117 @@
+/*
+ * Test that PSEUDO_DB_MODE correctly reconstructs permissions at file
+ * creation time. PSEUDO_DB_MODE is used when a file is created (open
+ * with O_CREAT, mkdir, etc.) to recover the intended mode from the
+ * filesystem mode (which has been mangled by PSEUDO_FS_MODE).
+ *
+ * If PSEUDO_DB_MODE is broken, the mode stored in the database at
+ * creation time will be wrong, which we detect by stat'ing immediately
+ * after creation (before any chmod).
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ */
+
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+static int test_creat_mode(mode_t mode) {
+    const char *path = "test-db-mode-tmp";
+    struct stat st;
+
+    /* Remove any prior file */
+    unlink(path);
+
+    /* Clear umask so it doesn't interfere */
+    mode_t old_umask = umask(0);
+
+    int fd = open(path, O_CREAT | O_WRONLY | O_EXCL, mode);
+    if (fd < 0) {
+        perror("open");
+        umask(old_umask);
+        return 1;
+    }
+    close(fd);
+
+    if (stat(path, &st) != 0) {
+        perror("stat");
+        unlink(path);
+        umask(old_umask);
+        return 1;
+    }
+
+    mode_t got = st.st_mode & 07777;
+    unlink(path);
+    umask(old_umask);
+
+    if (got != mode) {
+        fprintf(stderr, "FAIL: open(O_CREAT, 0%04o) -> stat 0%04o\n", mode, got);
+        return 1;
+    }
+    return 0;
+}
+
+static int test_mkdir_mode(mode_t mode) {
+    const char *path = "test-db-mode-dir-tmp";
+    struct stat st;
+
+    rmdir(path);
+
+    mode_t old_umask = umask(0);
+
+    if (mkdir(path, mode) != 0) {
+        perror("mkdir");
+        umask(old_umask);
+        return 1;
+    }
+
+    if (stat(path, &st) != 0) {
+        perror("stat");
+        rmdir(path);
+        umask(old_umask);
+        return 1;
+    }
+
+    mode_t got = st.st_mode & 07777;
+    rmdir(path);
+    umask(old_umask);
+
+    if (got != mode) {
+        fprintf(stderr, "FAIL: mkdir(0%04o) -> stat 0%04o\n", mode, got);
+        return 1;
+    }
+    return 0;
+}
+
+int main(void) {
+    int failures = 0;
+    int total = 0;
+
+    /* Test all octet values simultaneously: 00000, 01111, 02222, ..., 07777 */
+    mode_t modes[] = {
+        00000, 01111, 02222, 03333, 04444, 05555, 06666, 07777,
+    };
+    int num_modes = sizeof(modes) / sizeof(modes[0]);
+
+    for (int i = 0; i < num_modes; i++) {
+        total++;
+        if (test_creat_mode(modes[i]) != 0)
+            failures++;
+    }
+
+    for (int i = 0; i < num_modes; i++) {
+        total++;
+        if (test_mkdir_mode(modes[i]) != 0)
+            failures++;
+    }
+
+    if (failures > 0) {
+        fprintf(stderr, "%d/%d mode tests failed\n", failures, total);
+        return 2;
+    }
+    return 0;
+}
diff --git a/test/test-db-mode.sh b/test/test-db-mode.sh
new file mode 100755
index 0000000..b3e97ad
--- /dev/null
+++ b/test/test-db-mode.sh
@@ -0,0 +1,10 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# Test that PSEUDO_DB_MODE correctly reconstructs permission bits
+# at file/directory creation time.
+
+trap "rm -rf test-db-mode-tmp test-db-mode-dir-tmp" EXIT
+
+./test/test-db-mode
-- 
1.8.3.1


