Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99135D47CBD
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.756.1768520621954725084
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjb2408772;
	Thu, 15 Jan 2026 17:43:40 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 06/20] test/test-statx: Add uutils test case
Date: Thu, 15 Jan 2026 17:43:22 -0600
Message-Id: <1768520616-7289-7-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2978

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 test/test-statx.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/test/test-statx.sh b/test/test-statx.sh
index 045f6ff..feef8e6 100755
--- a/test/test-statx.sh
+++ b/test/test-statx.sh
@@ -3,6 +3,7 @@
 # SPDX-License-Identifier: LGPL-2.1-only
 #
 
+printf "statx null path: "
 tmplog="$(mktemp pseudo.log.XXXXXXXX)"
 ./test/test-statx >${tmplog} 2>&1
 rc=$?
@@ -10,9 +11,33 @@ rc=$?
 if grep -q "couldn't allocate absolute path for 'null'." ${tmplog} ; then
     echo "Unexpected message: \"couldn't allocate absolute path for 'null'.\" found."
     rc=1
+else
+    echo "passed"
 fi
 
 cat ${tmplog}
 
 rm $tmplog
+
+printf "uutils date: "
+# Try to figure out if we're using rust corutils
+if $(date --version 2>&1 | grep -q "uutils") ; then
+    tmplog="$(mktemp pseudo.log.XXXXXXXX)"
+    date >${tmplog} 2>&1
+    rc=$?
+
+    if grep -q "couldn't allocate absolute path for 'null'." ${tmplog} ; then
+        echo "Unexpected message: \"couldn't allocate absolute path for 'null'.\" found."
+        rc=1
+    else
+        echo passed
+    fi
+
+    cat ${tmplog}
+
+    rm $tmplog
+else
+    echo skipped
+fi
+
 exit $rc
-- 
2.43.0


