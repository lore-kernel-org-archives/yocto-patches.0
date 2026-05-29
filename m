Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFEACD4F54
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 21:25:50 +0000 (UTC)
Received: from MacBookPro.local (MacBookPro.local [188.232.64.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1744.1780089943992108634
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 29 May 2026 14:25:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=none, err=permanent DNS error (domain: macbookpro.local, ip: 188.232.64.11, mailfrom: frezidok@macbookpro.local)
Received: by MacBookPro.local (Postfix, from userid 501)
	id 2802A22B12E2; Sat, 30 May 2026 00:25:40 +0300 (MSK)
From: Dmitry Sakhonchik <frezidok1@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo,v2] [PATCH] pseudo_util: Add log severity flags
Date: Sat, 30 May 2026 00:25:13 +0300
Message-ID: <20260529212513.35103-1-frezidok1@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 29 May 2026 21:25:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4087

Create an infrastructure to make use of severity flags from pseudo_tables=
.
After that it is now possible to set severity flags from env (PSEUDO_SEVE=
RITY) and from terminal via optargs.

[YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
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
-	while ((o =3D getopt(argc, argv, "+BCdfhi:lm:M:p:P:r:R:St:vVx:")) !=3D =
-1) {
+	while ((o =3D getopt(argc, argv, "+BCdfhi:klm:M:p:P:r:R:St:vVx:")) !=3D=
 -1) {
 		switch (o) {
 		case 'B': /* rebuild database */
 			opt_B =3D 1;
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
@@ -63,6 +63,7 @@ static struct pseudo_variables pseudo_env[] =3D {
 #endif
 	{ "PSEUDO_EVLOG", 12, NULL },
 	{ "PSEUDO_EVLOG_FILE", 17, NULL },
+	{ "PSEUDO_SEVERITY", 15, NULL },
 	{ NULL, 0, NULL } /* Magic terminator */
 };
=20
@@ -90,6 +91,7 @@ static int pseudo_evlog_next_entry =3D 0;
 static void pseudo_evlog_set(char *);
 static void pseudo_evlog_flags_finalize(void);
 static unsigned long pseudo_debug_flags_in(char *);
+static unsigned long pseudo_severity_flags_in(char *);
=20
 /* -1 - init hasn't been run yet
  * 0 - init has been run
@@ -247,10 +249,17 @@ pseudo_init_util(void) {
 		pseudo_evlog_flags_finalize();
 	}
 	free(env);
+	env =3D pseudo_get_value("PSEUDO_SEVERITY");
+	if (env) {
+		pseudo_severity_set(env);
+		pseudo_severity_flags_finalize();
+	}
+	free(env);
 }
=20
 unsigned long pseudo_util_debug_flags =3D 0;
 unsigned long pseudo_util_evlog_flags =3D 0;
+unsigned long pseudo_util_severity_flags =3D 0;
 int pseudo_util_debug_fd =3D 2;
 int pseudo_util_evlog_fd =3D 2;
 static int debugged_newline =3D 1;
@@ -433,6 +442,11 @@ pseudo_evlog_set(char *s) {
 	pseudo_util_evlog_flags =3D pseudo_debug_flags_in(s);
 }
=20
+void
+pseudo_severity_set(char *s) {
+	pseudo_util_severity_flags =3D pseudo_severity_flags_in(s);
+}
+
 /* This exists because we don't want to allocate a bunch of strings
  * and free them immediately if you have several flags set.
  */
@@ -457,6 +471,11 @@ pseudo_evlog_flags_finalize(void) {
 	pseudo_flags_finalize(pseudo_util_evlog_flags, "PSEUDO_EVLOG");
 }
=20
+void
+pseudo_severity_flags_finalize(void) {
+	pseudo_flags_finalize(pseudo_util_severity_flags, "PSEUDO_SEVERITY");
+}
+
 static unsigned long
 pseudo_debug_flags_in(char *s) {
 	unsigned long flags =3D 0;
@@ -471,6 +490,31 @@ pseudo_debug_flags_in(char *s) {
 	return flags;
 }
=20
+static unsigned long
+pseudo_severity_flags_in(char *s) {
+	unsigned long flags =3D 0;
+	char *token =3D NULL;
+	char *saveptr =3D NULL;
+	char *s_copy =3D NULL;
+
+	if (!s)
+		return flags;
+
+	s_copy =3D strdup(s);
+
+	token =3D strtok_r(s_copy, " ,;", &saveptr);
+	while (token !=3D NULL) {
+		pseudo_sev_t id =3D pseudo_sev_id(token);
+		if (id > SEVERITY_NONE && id < SEVERITY_MAX) {
+				flags |=3D (1UL << id);
+			}
+		token =3D strtok_r(NULL, " ,;", &saveptr);
+	}
+
+	free(s_copy);
+	return flags;=09
+}
+
 void
 pseudo_debug_clear(char *s) {
 	if (!s)

