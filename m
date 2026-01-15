Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16672D3CCB0
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.848.1768520625174329076
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjh2408772;
	Thu, 15 Jan 2026 17:43:41 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 12/20] ports/unix/guts/realpath.c: Fix indents
Date: Thu, 15 Jan 2026 17:43:28 -0600
Message-Id: <1768520616-7289-13-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2995

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ports/unix/guts/realpath.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/ports/unix/guts/realpath.c b/ports/unix/guts/realpath.c
index c13eb93..62a92b2 100644
--- a/ports/unix/guts/realpath.c
+++ b/ports/unix/guts/realpath.c
@@ -23,14 +23,14 @@
 		return NULL;
 	}
 
-		len = strlen(rname);
-		char *ep = rname + len - 1;
-		while (ep > rname && *ep == '/') {
-			--len;
-			*(ep--) = '\0';
-		}
+	len = strlen(rname);
+	char *ep = rname + len - 1;
+	while (ep > rname && *ep == '/') {
+		--len;
+		*(ep--) = '\0';
+	}
 
-		if (len >= pseudo_sys_path_max()) {
+	if (len >= pseudo_sys_path_max()) {
 		errno = ENAMETOOLONG;
 		return NULL;
 	}
-- 
2.43.0


