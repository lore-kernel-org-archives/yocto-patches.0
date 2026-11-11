Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2586.1794370872144807707
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3m52428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:07 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 19/34] pseudo_server: Set highest_client to the new client when growing
Date: Tue, 10 Nov 2026 22:20:47 -0600
Message-Id: <1794370862-30908-20-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5287
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

When open_client() grows the client table, the new client goes in slot
max_clients, but highest_client was set to max_clients + 1, one past
it.  This was harmless, as that slot exists and is unused, but the
server scanned it needlessly.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo_server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pseudo_server.c b/pseudo_server.c
index edcb23e..13caced 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -407,7 +407,7 @@ open_client(int fd) {
 		clients[max_clients].pid = 0;
 		clients[max_clients].tag = NULL;
 		clients[max_clients].program = NULL;
-		highest_client = max_clients + 1;
+		highest_client = max_clients;
 
 		max_clients += 16;
 		++active_clients;
-- 
1.8.3.1

