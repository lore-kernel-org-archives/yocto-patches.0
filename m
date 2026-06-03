Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D6BCD6E71
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 20:39:21 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29655.1780519152835833287
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 13:39:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 653Kd9V32263173;
	Wed, 3 Jun 2026 15:39:11 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 5/6] tests: Add setuid permission check
Date: Wed,  3 Jun 2026 15:39:07 -0500
Message-Id: <1780519148-30836-6-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1780519148-30836-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1780519148-30836-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 20:39:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4128

From: Mark Hatle <mark.hatle@amd.com>

Verify that +s permissions are not leaking into real filesystem.

AI-Generated: Implemented with the assistance of github CoPilot (Claude Opus 4.6)

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 test/test-setuid-permissions.sh | 58 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100755 test/test-setuid-permissions.sh

diff --git a/test/test-setuid-permissions.sh b/test/test-setuid-permissions.sh
new file mode 100755
index 0000000..b6fafde
--- /dev/null
+++ b/test/test-setuid-permissions.sh
@@ -0,0 +1,58 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+set -e
+
+# Verify that setuid/setgid bits tracked by pseudo do not
+# bleed into the real filesystem.
+#
+# Return vals:
+#
+#                 2 - Setuid/setgid bits found on real file
+#                 1 - Unexpected command error
+#                 0 - Pass
+
+mode() {
+	stat -c "%a" "$1"
+}
+
+trap "rm -f testfile" EXIT
+
+test_mode() {
+	local octal_mode="$1"
+	local expected_pseudo="$2"
+	local expected_real="$3"
+
+	chmod $octal_mode testfile
+
+	# Under pseudo, verify mode is as requested
+	local pseudo_mode=$(mode testfile)
+	if [ "$pseudo_mode" != "$expected_pseudo" ]; then
+		echo "FAIL: pseudo mode $pseudo_mode != expected $expected_pseudo (chmod $octal_mode)"
+		exit 1
+	fi
+
+	# Check without pseudo - real file must NOT have setuid/setgid
+	local real_mode=$(PSEUDO_DISABLED=1 stat -c "%a" testfile)
+	if [ "$real_mode" != "$expected_real" ]; then
+		echo "FAIL: real mode $real_mode != expected $expected_real (chmod $octal_mode)"
+		exit 2
+	fi
+}
+
+touch testfile
+
+# Test setuid only (4755)
+test_mode 4755 4755 755
+
+# Test setgid only (2755)
+test_mode 2755 2755 755
+
+# Test setuid + setgid (6755)
+test_mode 6755 6755 755
+
+# Test setuid + setgid + other base perms (6644)
+test_mode 6644 6644 644
+
+exit 0
-- 
1.8.3.1


