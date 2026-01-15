Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55543D47CAB
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.763.1768520625001704106
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjp2408772;
	Thu, 15 Jan 2026 17:43:43 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 20/20] Makefile.in: Bump version to 1.9.3
Date: Thu, 15 Jan 2026 17:43:36 -0600
Message-Id: <1768520616-7289-21-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2988

Update the ChangeLog.txt to indicate it's obsolete.

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ChangeLog.txt | 4 ++++
 Makefile.in   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/ChangeLog.txt b/ChangeLog.txt
index f681596..38e2cbf 100644
--- a/ChangeLog.txt
+++ b/ChangeLog.txt
@@ -1,3 +1,7 @@
+This changelog is obsolete, it stopped being updated as of commit
+097ca3e245200c4a4333964af59a106c42ff3bca.  See the git log for up to
+date changes.
+
 2019-08-02:
 	* (seebs) Pass flags & O_NOFOLLOW, also use that to influence
 	  stat types. Note. &. Not |.
diff --git a/Makefile.in b/Makefile.in
index 3b60cf8..8bf3f48 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -34,7 +34,7 @@ BITS=@BITS@
 ARCH_FLAGS=@ARCH_FLAGS@
 MARK64=@MARK64@
 RPATH=@RPATH@
-VERSION=1.9.2
+VERSION=1.9.3
 
 LIB=@LIB@
 BIN=bin
-- 
2.43.0


