Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2577.1794370867827556146
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3m42428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:07 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 18/34] pseudo_server: Lower highest_client when the highest client closes
Date: Tue, 10 Nov 2026 22:20:46 -0600
Message-Id: <1794370862-30908-19-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5277
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

close_client() is meant to move highest_client down past closed slots
when the highest client goes away, but the loop condition was inverted:
it stopped at the first closed slot, which is always the one just
closed, so highest_client never went down.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo_server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pseudo_server.c b/pseudo_server.c
index c54c0d2..edcb23e 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -441,7 +441,7 @@ close_client(int client) {
 	clients[client].program = NULL;
 	--active_clients;
 	if (client == highest_client)
-		while (clients[highest_client].fd != -1 && highest_client > 0)
+		while (clients[highest_client].fd == -1 && highest_client > 0)
 			--highest_client;
 }
 
-- 
1.8.3.1

