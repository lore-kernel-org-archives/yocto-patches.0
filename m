Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2487.1794370868990953199
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3mB2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:08 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 25/34] pseudo: List -p in the usage message
Date: Tue, 10 Nov 2026 22:20:53 -0600
Message-Id: <1794370862-30908-26-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5281
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pseudo.c b/pseudo.c
index 4cd0993..26c7a36 100644
--- a/pseudo.c
+++ b/pseudo.c
@@ -47,7 +47,7 @@ static int pseudo_db_check(int fix);
 void
 usage(int status) {
 	FILE *f = status ? stderr : stdout;
-	fputs("Usage: pseudo [-dflv] [-x flags] [-k severities] [-P prefix] [-rR root] [-t timeout] [command]\n", f);
+	fputs("Usage: pseudo [-dflv] [-x flags] [-k severities] [-p path] [-P prefix] [-rR root] [-t timeout] [command]\n", f);
 	fputs("       pseudo -h\n", f);
 	fputs("       pseudo [-dflv] [-x flags] [-P prefix] [-BC] -i path\n", f);
 	fputs("       pseudo [-dflv] [-x flags] [-P prefix] [-BC] -m from -M to\n", f);
-- 
1.8.3.1

