Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14298FF886F
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 17:56:59 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2117.1777312611324752135
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 10:56:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63RHugAj876837;
	Mon, 27 Apr 2026 12:56:44 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Cc: dburgener@linux.microsoft.com, peter.kjellerstedt@axis.com
Subject: [pseudo][PATCH 06/11] ports/unix: fts_open: Fix chroot behavior
Date: Mon, 27 Apr 2026 12:56:36 -0500
Message-Id: <1777312601-1393-7-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1777312601-1393-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 17:56:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3851

From: Mark Hatle <mark.hatle@amd.com>

The fts_open wrapper was resolving paths via PSEUDO_ROOT_PATH into
rpath_argv, but then used path_argv in the real_fts_open call.
Switch this to using the pseudo processed root paths.

AI-Generated: AI was used to identify the source of the issue - github copilot (claude opus 4.6)

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ports/unix/guts/fts_open.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ports/unix/guts/fts_open.c b/ports/unix/guts/fts_open.c
index ccc9322..6acdf9b 100644
--- a/ports/unix/guts/fts_open.c
+++ b/ports/unix/guts/fts_open.c
@@ -42,7 +42,8 @@
 		errno = ENOMEM;
 		rc = NULL;
 	} else {
-		rc = real_fts_open(path_argv, options, compar);
+		rpath_argv[args] = NULL;
+		rc = real_fts_open(rpath_argv, options, compar);
 	}
 	for (i = 0; i < args; ++i)
 		free(rpath_argv[i]);
-- 
1.8.3.1


