Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2492.1794370872144412714
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3m72428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:07 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 21/34] pseudo: Fix the -k severity option
Date: Tue, 10 Nov 2026 22:20:49 -0600
Message-Id: <1794370862-30908-22-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5291
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

-k was declared to getopt() without an argument, so the severities that
followed it were taken as the command to run, and the flags were set
from a NULL string, turning off pseudo_info() and pseudo_warning().
It was also never stored in PSEUDO_SEVERITY, so programs started by
pseudo didn't inherit it, unlike -x and PSEUDO_DEBUG.

Make -k take an argument, store the result in PSEUDO_SEVERITY after
the options are processed, and list it in the usage message.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/pseudo.c b/pseudo.c
index 11112dd..4cd0993 100644
--- a/pseudo.c
+++ b/pseudo.c
@@ -47,7 +47,7 @@ static int pseudo_db_check(int fix);
 void
 usage(int status) {
 	FILE *f = status ? stderr : stdout;
-	fputs("Usage: pseudo [-dflv] [-x flags] [-P prefix] [-rR root] [-t timeout] [command]\n", f);
+	fputs("Usage: pseudo [-dflv] [-x flags] [-k severities] [-P prefix] [-rR root] [-t timeout] [command]\n", f);
 	fputs("       pseudo -h\n", f);
 	fputs("       pseudo [-dflv] [-x flags] [-P prefix] [-BC] -i path\n", f);
 	fputs("       pseudo [-dflv] [-x flags] [-P prefix] [-BC] -m from -M to\n", f);
@@ -134,7 +134,7 @@ main(int argc, char *argv[]) {
 	 * wrong.  The + suppresses this annoying behavior, but may not
 	 * be compatible with sane option libraries.
 	 */
-	while ((o = getopt(argc, argv, "+BCdfhi:klm:M:p:P:r:R:St:vVx:")) != -1) {
+	while ((o = getopt(argc, argv, "+BCdfhi:k:lm:M:p:P:r:R:St:vVx:")) != -1) {
 		switch (o) {
 		case 'B': /* rebuild database */
 			opt_B = 1;
@@ -245,6 +245,7 @@ main(int argc, char *argv[]) {
 		}
 	}
 	pseudo_debug_flags_finalize();
+	pseudo_severity_flags_finalize();
 	/* Options are processed, preserve them... */
 	pseudo_set_value("PSEUDO_OPTS", opts);
 
-- 
1.8.3.1

