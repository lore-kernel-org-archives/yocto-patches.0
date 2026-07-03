Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201ACC44516
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 18:41:13 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.99265.1783104060299414539
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jul 2026 11:41:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 663Ieua1237103;
	Fri, 3 Jul 2026 13:40:57 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH v2 02/23] pseudo_util: Add log severity flags
Date: Fri,  3 Jul 2026 13:40:34 -0500
Message-Id: <1783104055-19005-3-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783104055-19005-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783104055-19005-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 18:41:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4398

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Create an infrastructure to make use of severity flags from pseudo_tables.
After that it is now possible to set severity flags from env (PSEUDO_SEVERITY) and from terminal via optargs.

[YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo.c      |  5 ++++-
 pseudo.h      |  3 +++
 pseudo_util.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/pseudo.c b/pseudo.c
index 25711b6..e5fe5cf 100644
--- a/pseudo.c
+++ b/pseudo.c
@@ -134,7 +134,7 @@ main(int argc, char *argv[]) {
 	 * wrong.  The + suppresses this annoying behavior, but may not
 	 * be compatible with sane option libraries.
 	 */
-	while ((o = getopt(argc, argv, "+BCdfhi:lm:M:p:P:r:R:St:vVx:")) != -1) {
+	while ((o = getopt(argc, argv, "+BCdfhi:klm:M:p:P:r:R:St:vVx:")) != -1) {
 		switch (o) {
 		case 'B': /* rebuild database */
 			opt_B = 1;
@@ -231,6 +231,9 @@ main(int argc, char *argv[]) {
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
-- 
1.8.3.1


