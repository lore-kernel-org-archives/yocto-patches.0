Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2482.1794370866468141084
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3lw2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:05 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 12/34] ports/common/subports: Show the unknown OS name in the error
Date: Tue, 10 Nov 2026 22:20:40 -0600
Message-Id: <1794370862-30908-13-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5272
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

The error for an unsupported host used %(uname -s) instead of
$(uname -s), so it printed that text instead of the name of the OS.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/common/subports | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ports/common/subports b/ports/common/subports
index d5f9292..486c7a2 100755
--- a/ports/common/subports
+++ b/ports/common/subports
@@ -5,7 +5,7 @@
 
 case $(uname -s) in
 Linux)	echo "linux";;
-*)	echo >&2 "Unknown result from uname -s: %(uname -s). Aborting."
+*)	echo >&2 "Unknown result from uname -s: $(uname -s). Aborting."
 	exit 1
 	;;
 esac
-- 
1.8.3.1

