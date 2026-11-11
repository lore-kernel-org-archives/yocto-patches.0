Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2491.1794370872143418442
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3m12428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:06 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 15/34] pseudo_server: Drop an idle client when out of file descriptors
Date: Tue, 10 Nov 2026 22:20:43 -0600
Message-Id: <1794370862-30908-16-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5293
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

When accept() failed with EMFILE, the epoll loop only logged it.  The
listening socket stays readable while the connection is pending, so
epoll_wait() returned immediately again, and the server spun until a
client went away.

Like the select() loop does, drop one client to make room: one that had
no event in the current batch, so it can't have one pending in it
either.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo_server.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/pseudo_server.c b/pseudo_server.c
index fc5c2c1..77d1c39 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -626,6 +626,7 @@ static void pseudo_server_loop_epoll(void)
 	struct sigaction eat_usr2 = {
 		.sa_handler = set_do_list_clients
 	};
+	int hitmaxfiles = 0;
 
 	clients = malloc(16 * sizeof(*clients));
 	if (!clients) {
@@ -724,8 +725,8 @@ static void pseudo_server_loop_epoll(void)
 								exit(PSEUDO_EXIT_EPOLL_CTL);
 							}
 						} else if (errno == EMFILE) {
-							// select() loop would drop a client here, we do nothing (for now)
-							pseudo_debug(PDBGF_SERVER, "Hit max open files.\n");
+							hitmaxfiles = 1;
+							pseudo_debug(PDBGF_SERVER, "Hit max open files, dropping a client.\n");
 						}
 					}
 				} else if (clients[client_id].fd != -1) {
@@ -742,6 +743,27 @@ static void pseudo_server_loop_epoll(void)
 				if (die_forcefully)
 					break;
 			}
+			/* The listening socket stays readable while accept()
+			 * fails, so make room by dropping one client that had
+			 * no event in this batch, and so can't have one pending
+			 * in it either.
+			 */
+			if (hitmaxfiles && !die_forcefully) {
+				hitmaxfiles = 0;
+				for (i = 1; i <= highest_client; ++i) {
+					int j;
+					if (clients[i].fd == -1)
+						continue;
+					for (j = 0; j < rc; ++j) {
+						if ((int) events[j].data.u64 == i)
+							break;
+					}
+					if (j == rc) {
+						close_client(i);
+						break;
+					}
+				}
+			}
 			pseudo_debug(PDBGF_SERVER, "server loop complete [%d clients left]\n", active_clients);
 		} else {
 			pseudo_error("epoll_wait failed: %s\n", strerror(errno));
-- 
1.8.3.1

