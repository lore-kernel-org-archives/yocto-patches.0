Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620ACC4450A
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 18:41:12 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.98542.1783104061923126707
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jul 2026 11:41:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 663IeuaB237103;
	Fri, 3 Jul 2026 13:40:59 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH v2 12/23] pseudo_util: Add default log severity values
Date: Fri,  3 Jul 2026 13:40:44 -0500
Message-Id: <1783104055-19005-13-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783104055-19005-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783104055-19005-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 18:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4407

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Default values are "show everything". If the user wants to see
only certain categories, they should explicitely set
PSEUDO_SEVERITY env var or use -k option.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo.h      | 2 ++
 pseudo_util.c | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/pseudo.h b/pseudo.h
index 92ae71e..66aa70e 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -130,6 +130,8 @@ extern char *pseudo_version;
 #define PSEUDO_PIDFILE "pseudo.pid"
 #define PSEUDO_SOCKET "pseudo.socket"
 
+#define PSEUDO_SEVERITY_DEFAULT "info,warn,error"
+
 /* some systems might not have *at().  We like to define operations in
  * terms of each other, and for instance, open(...) is the same as
  * openat(AT_FDCWD, ...).  If no AT_FDCWD is provided, any value that can't
diff --git a/pseudo_util.c b/pseudo_util.c
index 893a25b..4c05394 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -250,10 +250,11 @@ pseudo_init_util(void) {
 	}
 	free(env);
 	env = pseudo_get_value("PSEUDO_SEVERITY");
-	if (env) {
-		pseudo_severity_set(env);
-		pseudo_severity_flags_finalize();
+	if (!env) {
+		env = strdup(PSEUDO_SEVERITY_DEFAULT);
 	}
+	pseudo_severity_set(env);
+	pseudo_severity_flags_finalize();
 	free(env);
 }
 
-- 
1.8.3.1


