Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2483.1794370867075099635
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3m02428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:06 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 14/34] pseudo_server: Skip events for clients closed earlier in the batch
Date: Tue, 10 Nov 2026 22:20:42 -0600
Message-Id: <1794370862-30908-15-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5274
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

The epoll loop handles up to EPOLL_MAX_EVENTS events per wakeup.  If a
client's slot was already closed earlier in the same batch, its event
was treated as an empty read, and close_client() was called again,
decrementing active_clients a second time.  The server starts its idle
shutdown when active_clients reaches 1, so it could exit while clients
were still connected.

Skip events for slots that are no longer in use, as the select() loop
does.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo_server.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/pseudo_server.c b/pseudo_server.c
index b983121..fc5c2c1 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -728,7 +728,9 @@ static void pseudo_server_loop_epoll(void)
 							pseudo_debug(PDBGF_SERVER, "Hit max open files.\n");
 						}
 					}
-				} else {
+				} else if (clients[client_id].fd != -1) {
+					/* the client may have been closed earlier in
+					 * this batch of events */
 					int n = 0;
 					ioctl(clients[client_id].fd, FIONREAD, &n);
 					if (n == 0) {
-- 
1.8.3.1

