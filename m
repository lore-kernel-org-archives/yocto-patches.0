Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AABD47CA3
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.755.1768520621953833623
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjd2408772;
	Thu, 15 Jan 2026 17:43:40 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 08/20] test-tclsh-fork: Skip test if tclsh is not available
Date: Thu, 15 Jan 2026 17:43:24 -0600
Message-Id: <1768520616-7289-9-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2979

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 test/test-tclsh-fork.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/test/test-tclsh-fork.sh b/test/test-tclsh-fork.sh
index e06f36b..cb63a55 100755
--- a/test/test-tclsh-fork.sh
+++ b/test/test-tclsh-fork.sh
@@ -3,6 +3,11 @@
 # SPDX-License-Identifier: LGPL-2.1-only
 #
 
+which tclsh >/dev/null 2>&1
+if [ $? -ne 0 ]; then
+	exit 255
+fi
+
 # Check that tclsh doesn't hang.  Note that the timeout is not needed to
 # reproduce the hang in tclsh, it's only there to ensure that this test script
 # doesn't hang in case of a failing test.
-- 
2.43.0


