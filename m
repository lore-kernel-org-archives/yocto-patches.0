Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2573.1794370866072427250
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3lu2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:05 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 10/34] Replace #if 0 strerror() debug messages with a comment
Date: Tue, 10 Nov 2026 22:20:38 -0600
Message-Id: <1794370862-30908-11-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5270
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

The wrapper template and popen() kept a disabled debug message using
strerror(), with a comment that strerror() can hang on systems using
locale data for it.  Keep the explanation, as a comment by the message
that prints errno as a number, and drop the disabled code.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/unix/pseudo_wrappers.c | 7 +------
 templates/wrapfuncs.c        | 7 +------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/ports/unix/pseudo_wrappers.c b/ports/unix/pseudo_wrappers.c
index 41398e4..b0faca8 100644
--- a/ports/unix/pseudo_wrappers.c
+++ b/ports/unix/pseudo_wrappers.c
@@ -30,12 +30,7 @@ popen(const char *command, const char *mode) {
 	save_errno = errno;
 	pseudo_droplock();
 	sigprocmask(SIG_SETMASK, &saved, NULL);
-#if 0
-/* This can cause hangs on some recentish systems which use locale
- * stuff for strerror...
- */
-	pseudo_debug(PDBGF_WRAPPER, "completed: popen (maybe: %s)\n", strerror(save_errno));
-#endif
+	/* not strerror(), which can hang on systems using locale data for it */
 	pseudo_debug(PDBGF_WRAPPER, "completed: popen (errno: %d)\n", save_errno);
 	errno = save_errno;
 	return rc;
diff --git a/templates/wrapfuncs.c b/templates/wrapfuncs.c
index a57c997..d7fb548 100644
--- a/templates/wrapfuncs.c
+++ b/templates/wrapfuncs.c
@@ -78,12 +78,7 @@ quick_exit:
 	pseudo_droplock();
 	sigprocmask(SIG_SETMASK, &saved, NULL);
 	pseudo_debug(PDBGF_WRAPPER | PDBGF_VERBOSE, "${name} - yielded lock, restored signals\n");
-#if 0
-/* This can cause hangs on some recentish systems which use locale
- * stuff for strerror...
- */
-	pseudo_debug(PDBGF_WRAPPER, "wrapper completed: ${name} returns ${rc_format} (errno: %s)\n", ${rc_value}, strerror(save_errno));
-#endif
+	/* not strerror(), which can hang on systems using locale data for it */
 	pseudo_debug(PDBGF_WRAPPER, "wrapper completed: ${name} returns ${rc_format} (errno: %d)\n", ${rc_value}, save_errno);
 	errno = save_errno;
 	PROFILE_DONE;
-- 
1.8.3.1

