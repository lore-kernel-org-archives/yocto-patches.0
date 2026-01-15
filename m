Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68779D47CAF
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.759.1768520622329678687
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjf2408772;
	Thu, 15 Jan 2026 17:43:40 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 10/20] test/test-proc-pipe.sh: Add test case for proc pipes
Date: Thu, 15 Jan 2026 17:43:26 -0600
Message-Id: <1768520616-7289-11-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2985

From: Mark Hatle <mark.hatle@amd.com>

See: Yocto Project bugzilla 16028, comment #23.

This is related to both statx and realpath behavior.

Gauthier HADERER (see comment 23) reported an issue where realpath like
behavior of pseudo_fix_path function resulted in a failure of the rust
based tail command.

It was determined that the behavior could be emulated by doing:

echo "test" | tail /dev/fd/0

(tail, cat or any other similar command would result in the same failure)

This results in:
  /dev/fd/0 -> /proc/self/fd/0
  /proc/self/fd/0 -> /proc/1475524/fd/0
  /proc/1475524/fd/0 -> /proc/1475524/fd/pipe:[1177004485]

with an eventual failure of unable to open /proc/1475524/fd/pipe:[1177004485]

Reported-by: Gauthier HADERER <ghaderer@wyplay.com>

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 test/test-proc-pipe.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100755 test/test-proc-pipe.sh

diff --git a/test/test-proc-pipe.sh b/test/test-proc-pipe.sh
new file mode 100755
index 0000000..30b6880
--- /dev/null
+++ b/test/test-proc-pipe.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# See Yocto Project bugzilla 16028
+#
+# It was determined that a utility that use /dev/fd may fail when run under
+# pseudo, while working properly outside.
+#
+# For example: echo "test" | cat /dev/fd/0
+
+# Tests
+result=$(echo "test" | cat 2>&1)
+rc=$?
+if [ $rc -ne 0 -o "$result" != "test" ]; then
+    echo Failed simple echo pipe test - $rc:
+    echo $result
+    exit 1
+fi
+
+result=$(echo "test" | cat /dev/fd/0 2>&1)
+rc=$?
+if [ $rc -ne 0 -o "$result" != "test" ]; then
+    echo Failed /dev/fd/0 echo pipe test - $rc:
+    echo $result
+    exit 1
+fi
-- 
2.43.0


