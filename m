Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2485.1794370868169617101
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3m62428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:07 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 20/34] pseudo_util: Store PSEUDO_SEVERITY as severity names
Date: Tue, 10 Nov 2026 22:20:48 -0600
Message-Id: <1794370862-30908-21-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5278
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

Store the flags as a comma-separated list of severity names.

pseudo_severity_flags_finalize() stored the severity flags in
PSEUDO_SEVERITY using pseudo_flags_finalize(), which writes debug type
letters.  The default "info,warn,error" became "foP", which
pseudo_severity_flags_in() doesn't understand, so every process started
under pseudo, including a server started by a client, ran with no
severity flags: pseudo_info() and pseudo_warning() messages were
silently dropped.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo_util.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index 351cd09..631c3e9 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -443,7 +443,18 @@ pseudo_evlog_flags_finalize(void) {
 
 void
 pseudo_severity_flags_finalize(void) {
-	pseudo_flags_finalize(pseudo_util_severity_flags, "PSEUDO_SEVERITY");
+	/* PSEUDO_SEVERITY holds severity names, not debug type letters */
+	char buf[128] = "";
+	size_t len = 0;
+
+	for (int i = SEVERITY_NONE + 1; i < SEVERITY_MAX; ++i) {
+		if (pseudo_util_severity_flags & (1UL << i)) {
+			snprintf(buf + len, sizeof(buf) - len, "%s%s",
+				len ? "," : "", pseudo_sev_name(i));
+			len = strlen(buf);
+		}
+	}
+	pseudo_set_value("PSEUDO_SEVERITY", buf);
 }
 
 static unsigned long
-- 
1.8.3.1

