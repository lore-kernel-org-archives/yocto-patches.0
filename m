Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2486.1794370868799045034
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3mA2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:08 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 24/34] pseudo_util: Fix the date format in the event log dump
Date: Tue, 10 Nov 2026 22:20:52 -0600
Message-Id: <1794370862-30908-25-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5280
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

pseudo_evlog_dump() formatted the first and last entry times with
"%Y-%M-%D", which prints the minutes and a date in place of the
month and day.  Use "%Y-%m-%d" instead.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index 1eb90d5..e0d7306 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -560,8 +560,8 @@ pseudo_evlog_dump(void) {
 	}
 	localtime_r(&first, &first_tm);
 	localtime_r(&last, &last_tm);
-	strftime(firstdate, 64, "%Y-%M-%D %H:%M:%S", &first_tm);
-	strftime(lastdate, 64, "%Y-%M-%D %H:%M:%S", &last_tm);
+	strftime(firstdate, 64, "%Y-%m-%d %H:%M:%S", &first_tm);
+	strftime(lastdate, 64, "%Y-%m-%d %H:%M:%S", &last_tm);
 
 	len = snprintf(scratch, 256, "event log for pid %d [%d entries]\n",
 		getpid(), entries);
-- 
1.8.3.1

