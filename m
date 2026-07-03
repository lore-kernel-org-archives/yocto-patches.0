Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8799AC44517
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:34 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83541.1783039584603730815
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ12069650;
	Thu, 2 Jul 2026 19:46:20 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 03/23] pseudo: Add new logging macros
Date: Thu,  2 Jul 2026 19:45:58 -0500
Message-Id: <1783039578-31531-4-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4369

From: Dmitry Sakhonchik <frezidok1@gmail.com>

They are designed to replace various direct pseudo_diag()
call across the program and add new "smart" logging functionality.
CRITICAL and ERROR messages are shown no matter what,
INFO and WARNING only if the corresponding flag is set.

The patch is based on: [pseudo,v2] pseudo_util: Add log severity flags
and implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 enums/sev.in |  2 +-
 pseudo.h     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/enums/sev.in b/enums/sev.in
index 24c2c6e..44dffde 100644
--- a/enums/sev.in
+++ b/enums/sev.in
@@ -1,4 +1,4 @@
-sev: SEVERITY
+sev: SEVERITY; FLAGS
 debug
 info
 warn
diff --git a/pseudo.h b/pseudo.h
index e48d38a..d214ba2 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -41,6 +41,23 @@ extern int pseudo_evlog_internal(char *, ...) __attribute__ ((format (printf, 1,
 } while (0) 
 extern void pseudo_evlog_dump(void);
 #ifndef NDEBUG
+#define pseudo_critical(fmt, ...) do { \
+	pseudo_diag("CRITICAL: " fmt, ##__VA_ARGS__); \
+	abort(); \
+} while (0)
+#define pseudo_error(fmt, ...) do { \
+	pseudo_diag("ERROR: " fmt, ##__VA_ARGS__); \
+} while (0)
+#define pseudo_warning(fmt, ...) do { \
+	if (pseudo_util_severity_flags & SEVERITYF_WARN) { \
+		pseudo_diag("WARNING: " fmt, ##__VA_ARGS__); \
+	} \
+} while (0)
+#define pseudo_info(fmt, ...) do { \
+	if (pseudo_util_severity_flags & SEVERITYF_INFO) { \
+		pseudo_diag("INFO: " fmt, ##__VA_ARGS__); \
+	} \
+} while (0)
 #define pseudo_debug(x, ...) do { \
 	if ((x) & PDBGF_VERBOSE) { \
 		if ((pseudo_util_debug_flags & PDBGF_VERBOSE) && (pseudo_util_debug_flags & ((x) & ~PDBGF_VERBOSE))) { pseudo_diag(__VA_ARGS__); } \
-- 
2.53.0


