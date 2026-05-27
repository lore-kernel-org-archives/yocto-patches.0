Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75320CD5BD0
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 12:08:35 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18997.1779883707947797740
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 05:08:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=mZIFRjrO;
 spf=pass (domain: gmail.com, ip: 209.85.167.49, mailfrom: frezidok1@gmail.com)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a87782588cso5324380e87.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779883706; x=1780488506; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHTOQ4suV6NNySuR0ocPbPr0xmG3h61DRMpN0s+hIO8=;
        b=mZIFRjrOSEUmFL+fWEKFEY0b6Dzh9ojRSHeq+ZibjDfQaCcHXaSvjFUvJ31QNeflTG
         VO1q30MuxjxnEYYojTN/s4aLeJ7xMtV/Ls2ctw2ZtuGdp7wlykYuAsozj5knotKLOUex
         19cwVfKOFxpLX1X1XuPkne11OblSXtFjOO8Oddiw6HTMMOEtE6cUM61hLVjnlM6f1epp
         oAcmuUICSOnaSrYQg0u1PlwPeXXaLMk2saKIkFhPzOsrgmX6YEA2ULszQ/Jtae6SQa+8
         Ap47lF/Ptov00re6242CE1vA2OocuO9PLUYqULRQXQ4jd5xva3bF0Q4RAx/S8dZ6ngsV
         GG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779883706; x=1780488506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHTOQ4suV6NNySuR0ocPbPr0xmG3h61DRMpN0s+hIO8=;
        b=KF/YxC8xjIh53yC9p8eCW1pedyTpT85tozh4WuLT9rCV3UaCnpWGDX05y02J1zBL+D
         3/IrRsr1fjUrsTXHI+NXLl6a+pgOoi+rpXny2VV6cT61Uj6ahf0Z8Le/JVbQoirxvEYN
         YAPdkUv9YcP/JVM7LtbMuc87n3eNVbegYhfHkRf74b0j1FkH4EYHviS1/az5sA3OYPYV
         UGGlGkqStepKi9y/ARYIjmwd1ySodHRC4pw6moOUI03H908/J0xA8nqP+UCYOUlnGYod
         uxV6yL2G6dtGXX0dAxeJRPCTr9W75866iVZ1AFWZTR4SzUWs/uvuEcow2bDBEy7p5Hc6
         gX4Q==
X-Gm-Message-State: AOJu0YwfuqACjk8vQozvsCZMd5vWwR4hJOI1aslXEyiXugY1JHvTBDqr
	B8tgXHtuUJZBfshP2nWDNDdWA6kwYeQISx9xSabn5aAo7W4DJV6rZAy4siG8LwrbaT8=
X-Gm-Gg: Acq92OH10WwOYrsL9C3vuPdalnP3tFUAkj/vihc2dJe7rwqQB+SrXy4DMxnqjcRMbGq
	+FUKlPsU1m1FWAXwTnz2QVBQE+depd6L6c4+Du/tAuZa5cxJnEXB8IKEiy0Q4cveeRjAlAFz3rx
	NA+8D3IaOmS3AihDkb9ZeEDCJH/T367rW5fkxVpzN8bsHrBnoqD8Y/O+nEVXCHiHBkzICA5/ZuY
	IwNlYIcsbgE4d3CevjHRX43BcCRCrt3qwax9Al+gTZIlcC8m7PaSxHCT0SlSN2tPOtx6y3qDzM7
	smKl9zxhbhMTXqeGgKJE78iANpnZ6GzGMgKUZxgO/q5R5EH+ofV0tPgkDID0xfP+HEyNVfZ8ziu
	uwxft0Nq7MQUZXZPYJStJLNAmt/Eot8KfNJgxAVOC3YG8gQFImWaiXvqUe8htZnBSW0vVECqqxP
	9N56UUtjN5FXbBK5SS
X-Received: by 2002:a05:6512:24c2:10b0:5a8:97d7:8c45 with SMTP id 2adb3069b0e04-5aa323a358fmr4975717e87.36.1779883705813;
        Wed, 27 May 2026 05:08:25 -0700 (PDT)
Received: from ubuntu1.. ([89.255.88.34])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc2f502sm32959511fa.35.2026.05.27.05.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:08:24 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH] pseudo_util: Add log severity flags
Date: Wed, 27 May 2026 15:08:20 +0300
Message-ID: <20260527120820.237469-1-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 12:08:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4074

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Create an infrastructure to make use of severity flags from pseudo_tables.
After that it is now possible to set severity flags from env (PSEUDO_SEVERITY) and from terminal via optargs.

[YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 pseudo.c      |  8 +++++++-
 pseudo.h      |  3 +++
 pseudo_util.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/pseudo.c b/pseudo.c
index 25711b6..8a05d82 100644
--- a/pseudo.c
+++ b/pseudo.c
@@ -134,7 +134,10 @@ main(int argc, char *argv[]) {
 	 * wrong.  The + suppresses this annoying behavior, but may not
 	 * be compatible with sane option libraries.
 	 */
-	while ((o = getopt(argc, argv, "+BCdfhi:lm:M:p:P:r:R:St:vVx:")) != -1) {
+	while ((o = getopt(argc, argv, "+BCdfhi:lm:M:p:P:r:R:St:vVx:k:")) != -1) {
+		/*                                                               ^^^^^    */
+		/* 						which letter to choose for severity is a topic for discussion */
+		/*						I've chosen 'k' simply because it was not used yet 	*/
 		switch (o) {
 		case 'B': /* rebuild database */
 			opt_B = 1;
@@ -231,6 +234,9 @@ main(int argc, char *argv[]) {
 			printf("Set PSEUDO_PREFIX to run with a different prefix.\n");
 			exit(0);
 			break;
+		case 'k': /* debug severity */
+			pseudo_severity_set(optarg);
+			break;
 		case 'x': /* debug flags */
 			pseudo_debug_set(optarg);
 			break;
diff --git a/pseudo.h b/pseudo.h
index b6c13f2..e48d38a 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -26,8 +26,11 @@ extern void pseudo_debug_terse(void);
 extern void pseudo_debug_set(char *);
 extern void pseudo_debug_clear(char *);
 extern void pseudo_debug_flags_finalize(void);
+extern void pseudo_severity_set(char *);
+extern void pseudo_severity_flags_finalize(void);
 extern unsigned long pseudo_util_debug_flags;
 extern unsigned long pseudo_util_evlog_flags;
+extern unsigned long pseudo_util_severity_flags;
 extern int pseudo_util_debug_fd;
 extern int pseudo_disabled;
 extern int pseudo_allow_fsync;
diff --git a/pseudo_util.c b/pseudo_util.c
index 2b0cc04..f8f2a2f 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -63,6 +63,7 @@ static struct pseudo_variables pseudo_env[] = {
 #endif
 	{ "PSEUDO_EVLOG", 12, NULL },
 	{ "PSEUDO_EVLOG_FILE", 17, NULL },
+	{ "PSEUDO_SEVERITY", 15, NULL },
 	{ NULL, 0, NULL } /* Magic terminator */
 };
 
@@ -90,6 +91,7 @@ static int pseudo_evlog_next_entry = 0;
 static void pseudo_evlog_set(char *);
 static void pseudo_evlog_flags_finalize(void);
 static unsigned long pseudo_debug_flags_in(char *);
+static unsigned long pseudo_severity_flags_in(char *);
 
 /* -1 - init hasn't been run yet
  * 0 - init has been run
@@ -247,10 +249,17 @@ pseudo_init_util(void) {
 		pseudo_evlog_flags_finalize();
 	}
 	free(env);
+	env = pseudo_get_value("PSEUDO_SEVERITY");
+	if (env) {
+		pseudo_severity_set(env);
+		pseudo_severity_flags_finalize();
+	}
+	free(env);
 }
 
 unsigned long pseudo_util_debug_flags = 0;
 unsigned long pseudo_util_evlog_flags = 0;
+unsigned long pseudo_util_severity_flags = 0;
 int pseudo_util_debug_fd = 2;
 int pseudo_util_evlog_fd = 2;
 static int debugged_newline = 1;
@@ -433,6 +442,11 @@ pseudo_evlog_set(char *s) {
 	pseudo_util_evlog_flags = pseudo_debug_flags_in(s);
 }
 
+void
+pseudo_severity_set(char *s) {
+	pseudo_util_severity_flags = pseudo_severity_flags_in(s);
+}
+
 /* This exists because we don't want to allocate a bunch of strings
  * and free them immediately if you have several flags set.
  */
@@ -457,6 +471,11 @@ pseudo_evlog_flags_finalize(void) {
 	pseudo_flags_finalize(pseudo_util_evlog_flags, "PSEUDO_EVLOG");
 }
 
+void
+pseudo_severity_flags_finalize(void) {
+	pseudo_flags_finalize(pseudo_util_severity_flags, "PSEUDO_SEVERITY");
+}
+
 static unsigned long
 pseudo_debug_flags_in(char *s) {
 	unsigned long flags = 0;
@@ -471,6 +490,31 @@ pseudo_debug_flags_in(char *s) {
 	return flags;
 }
 
+static unsigned long
+pseudo_severity_flags_in(char *s) {
+	unsigned long flags = 0;
+	char *token = NULL;
+	char *saveptr = NULL;
+	char *s_copy = NULL;
+
+	if (!s)
+		return flags;
+
+	s_copy = strdup(s);
+
+	token = strtok_r(s_copy, " ,;", &saveptr);
+	while (token != NULL) {
+		pseudo_sev_t id = pseudo_sev_id(token);
+		if (id > SEVERITY_NONE && id < SEVERITY_MAX) {
+				flags |= (1UL << id);
+			}
+		token = strtok_r(NULL, " ,;", &saveptr);
+	}
+
+	free(s_copy);
+	return flags;	
+}
+
 void
 pseudo_debug_clear(char *s) {
 	if (!s)

