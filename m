Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E301CD4F21
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 22:20:53 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.620.1778624448603217141
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 May 2026 15:20:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 64CMKiF21619785;
	Tue, 12 May 2026 17:20:46 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev,
        changqing.li@windriver.com
Cc: richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 5/5] Makefile.in: Bump version to 1.9.7
Date: Tue, 12 May 2026 17:20:43 -0500
Message-Id: <1778624443-20857-6-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1778624443-20857-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1778624443-20857-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 May 2026 22:20:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3977

From: Mark Hatle <mark.hatle@amd.com>

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 Makefile.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.in b/Makefile.in
index b4f5f03..8719ddd 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -34,7 +34,7 @@ BITS=@BITS@
 ARCH_FLAGS=@ARCH_FLAGS@
 MARK64=@MARK64@
 RPATH=@RPATH@
-VERSION=1.9.6
+VERSION=1.9.7
 
 LIB=@LIB@
 BIN=bin
-- 
1.8.3.1


