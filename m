Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357EEC43602
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:32 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.82814.1783039589017550940
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ1F069650;
	Thu, 2 Jul 2026 19:46:23 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 16/23] pseudo_util: Avoid accidental free calls for without_libpseudo()
Date: Thu,  2 Jul 2026 19:46:11 -0500
Message-Id: <1783039578-31531-17-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4385

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We need to return list after the strdup otherwise the caller doesn't
know whether to free the return value or not.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20260701131336.3578279-2-richard.purdie@linuxfoundation.org>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo_util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index 3eaa9e6..66afe25 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -346,13 +346,13 @@ without_libpseudo(char *list) {
 	if (list[0] == '=' || list[0] == PSEUDO_LINKPATH_SEPARATOR[0])
 		skip_start = 1;
 
-	if ((*real_regexec)(&libpseudo_regex, list, 1, pmatch, 0)) {
-		return list;
-	}
 	list = strdup(list);
 	if (!list) {
 		pseudo_error("Couldn't allocate memory to remove libpseudo from environment.\n");
 	}
+	if ((*real_regexec)(&libpseudo_regex, list, 1, pmatch, 0)) {
+		return list;
+	}
 	while (list && !(*real_regexec)(&libpseudo_regex, list, 1, pmatch, 0)) {
 		char *start = list + pmatch[0].rm_so;
 		char *end = list + pmatch[0].rm_eo;
-- 
2.53.0


