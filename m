Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B0DC4450F
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:33 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.82808.1783039586112818528
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ1G069650;
	Thu, 2 Jul 2026 19:46:23 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 17/23] pseudo_util: Ensure pseudo_setupenvp handles memory consistently
Date: Thu,  2 Jul 2026 19:46:12 -0500
Message-Id: <1783039578-31531-18-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4374

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Most of the new environment values added to the new environment array
returned by setupenvp are already freshly allocated memory. Ensure all
the returned values are so the data can be handled consistently and
correctly freed (for a later patch).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20260701131336.3578279-3-richard.purdie@linuxfoundation.org>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index 66afe25..5095e5b 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1242,7 +1242,7 @@ pseudo_setupenvp(char * const *envp) {
 		}
 	} else {
 		/* keep old value */
-		new_envp[j++] = ld_library_path;
+		new_envp[j++] = strdup(ld_library_path);
 	}
 
 	if (ld_preload) {
@@ -1273,7 +1273,7 @@ pseudo_setupenvp(char * const *envp) {
 	for (i = 0; envp && envp[i]; ++i) {
 		if (STARTSWITH(envp[i], PRELINK_LIBRARIES "=")) continue;
 		if (STARTSWITH(envp[i], PRELINK_PATH "=")) continue;
-		new_envp[j++] = envp[i];
+		new_envp[j++] = strdup(envp[i]);
 	}
 
 	for (i = 0; pseudo_env[i].key; i++) {
-- 
2.53.0


