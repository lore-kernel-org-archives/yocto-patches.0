Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E79C44503
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 18:41:11 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.98547.1783104063359066409
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jul 2026 11:41:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 663IeuaH237103;
	Fri, 3 Jul 2026 13:41:01 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH v2 18/23] pseudo_util: Avoid a memory leak in pseudo_dropenv()
Date: Fri,  3 Jul 2026 13:40:50 -0500
Message-Id: <1783104055-19005-19-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783104055-19005-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783104055-19005-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 18:41:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4413

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20260701131336.3578279-4-richard.purdie@linuxfoundation.org>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo_util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pseudo_util.c b/pseudo_util.c
index 5095e5b..10274b8 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1045,6 +1045,7 @@ void pseudo_dropenv() {
 		} else {
 			SETENV(PRELINK_LIBRARIES, "", 1);
 		}
+		free(ld_preload);
 	}
 }
 
-- 
1.8.3.1


