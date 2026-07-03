Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4DDC4450A
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:33 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.82810.1783039586934531213
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ1A069650;
	Thu, 2 Jul 2026 19:46:22 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 11/23] pseudo: Change pseudo_diag() name to pseudo_log()
Date: Thu,  2 Jul 2026 19:46:06 -0500
Message-Id: <1783039578-31531-12-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4377

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo.h      | 14 +++++++-------
 pseudo_util.c |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/pseudo.h b/pseudo.h
index d214ba2..92ae71e 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -34,7 +34,7 @@ extern unsigned long pseudo_util_severity_flags;
 extern int pseudo_util_debug_fd;
 extern int pseudo_disabled;
 extern int pseudo_allow_fsync;
-extern int pseudo_diag(char *, ...) __attribute__ ((format (printf, 1, 2)));
+extern int pseudo_log(char *, ...) __attribute__ ((format (printf, 1, 2)));
 extern int pseudo_evlog_internal(char *, ...) __attribute__ ((format (printf, 1, 2)));
 #define pseudo_evlog(x, ...) do { \
 	if (pseudo_util_evlog_flags & (x)) { pseudo_evlog_internal(__VA_ARGS__); } \
@@ -42,27 +42,27 @@ extern int pseudo_evlog_internal(char *, ...) __attribute__ ((format (printf, 1,
 extern void pseudo_evlog_dump(void);
 #ifndef NDEBUG
 #define pseudo_critical(fmt, ...) do { \
-	pseudo_diag("CRITICAL: " fmt, ##__VA_ARGS__); \
+	pseudo_log("CRITICAL: " fmt, ##__VA_ARGS__); \
 	abort(); \
 } while (0)
 #define pseudo_error(fmt, ...) do { \
-	pseudo_diag("ERROR: " fmt, ##__VA_ARGS__); \
+	pseudo_log("ERROR: " fmt, ##__VA_ARGS__); \
 } while (0)
 #define pseudo_warning(fmt, ...) do { \
 	if (pseudo_util_severity_flags & SEVERITYF_WARN) { \
-		pseudo_diag("WARNING: " fmt, ##__VA_ARGS__); \
+		pseudo_log("WARNING: " fmt, ##__VA_ARGS__); \
 	} \
 } while (0)
 #define pseudo_info(fmt, ...) do { \
 	if (pseudo_util_severity_flags & SEVERITYF_INFO) { \
-		pseudo_diag("INFO: " fmt, ##__VA_ARGS__); \
+		pseudo_log("INFO: " fmt, ##__VA_ARGS__); \
 	} \
 } while (0)
 #define pseudo_debug(x, ...) do { \
 	if ((x) & PDBGF_VERBOSE) { \
-		if ((pseudo_util_debug_flags & PDBGF_VERBOSE) && (pseudo_util_debug_flags & ((x) & ~PDBGF_VERBOSE))) { pseudo_diag(__VA_ARGS__); } \
+		if ((pseudo_util_debug_flags & PDBGF_VERBOSE) && (pseudo_util_debug_flags & ((x) & ~PDBGF_VERBOSE))) { pseudo_log(__VA_ARGS__); } \
 	} else { \
-		if ((pseudo_util_debug_flags & (x)) || ((x) == 0)) { pseudo_diag(__VA_ARGS__); } \
+		if ((pseudo_util_debug_flags & (x)) || ((x) == 0)) { pseudo_log(__VA_ARGS__); } \
 	} \
 } while (0) 
 #define pseudo_debug_call(x, fn, ...) do { \
diff --git a/pseudo_util.c b/pseudo_util.c
index dbd979e..893a25b 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -528,7 +528,7 @@ pseudo_debug_clear(char *s) {
 }
 
 int
-pseudo_diag(char *fmt, ...) {
+pseudo_log(char *fmt, ...) {
 	va_list ap;
 	char debuff[8192];
 	int len;
-- 
2.53.0


