Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21E1C44506
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:32 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83547.1783039587467962341
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ1E069650;
	Thu, 2 Jul 2026 19:46:23 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 15/23] pseudo.h: Avoid accessing unallocated memory
Date: Thu,  2 Jul 2026 19:46:10 -0500
Message-Id: <1783039578-31531-16-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4382

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We can call STARTSWITH in cases where the item being searched for is longer
than the string itself. Switch from memcmp to strncmp to avoid accessing
unassigned memory.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pseudo.h b/pseudo.h
index 66aa70e..ae1fe0d 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -119,7 +119,7 @@ extern char *pseudo_version;
  #define PSEUDO_LIBDIR "lib"
 #endif
 
-#define STARTSWITH(x, y) (!memcmp((x), (y), sizeof(y) - 1))
+#define STARTSWITH(x, y) (strncmp(y, x, strlen(y)) == 0)
 
 #ifndef PSEUDO_LOCALSTATEDIR
  #define PSEUDO_LOCALSTATEDIR "var/pseudo"
-- 
2.53.0


