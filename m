Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2574.1794370866270942627
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3lv2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:05 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 11/34] pseudo_util: Remove stale with_libpseudo() comment
Date: Tue, 10 Nov 2026 22:20:39 -0600
Message-Id: <1794370862-30908-12-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5271
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

pseudo_setupenv() kept libdir_path until the end "because
with_libpseudo might need it".  That was only true for the Darwin port,
which passed it to with_libpseudo(); the parameter was removed with the
port.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo_util.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index 78c2e1b..351cd09 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1123,9 +1123,6 @@ pseudo_setupenv() {
 		}
 	}
 
-	/* we kept libdir path until now because with_libpseudo might
-	 * need it
-	 */
 	free(libdir_path);
 }
 
-- 
1.8.3.1

