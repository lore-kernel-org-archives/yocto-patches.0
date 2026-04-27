Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2E4FF886A
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 17:56:58 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2121.1777312614934456692
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 10:56:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63RHugAo876837;
	Mon, 27 Apr 2026 12:56:46 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Cc: dburgener@linux.microsoft.com, peter.kjellerstedt@axis.com
Subject: [pseudo][PATCH 11/11] Makefile.in: Bump version to 1.9.6
Date: Mon, 27 Apr 2026 12:56:41 -0500
Message-Id: <1777312601-1393-12-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 17:56:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3858

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 Makefile.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.in b/Makefile.in
index 74d3492..b4f5f03 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -34,7 +34,7 @@ BITS=@BITS@
 ARCH_FLAGS=@ARCH_FLAGS@
 MARK64=@MARK64@
 RPATH=@RPATH@
-VERSION=1.9.5
+VERSION=1.9.6
 
 LIB=@LIB@
 BIN=bin
-- 
1.8.3.1


