Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A67CD6E73
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 20:39:21 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29653.1780519152381457299
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 13:39:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 653Kd9V02263173;
	Wed, 3 Jun 2026 15:39:10 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 2/6] pseudo_client.h: Make it clear both macros must be updated together
Date: Wed,  3 Jun 2026 15:39:04 -0500
Message-Id: <1780519148-30836-3-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1780519148-30836-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1780519148-30836-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 20:39:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4124

From: Mark Hatle <mark.hatle@amd.com>

Both PSEUDO_FS_MODE and PSEUDO_DB_MODE must be updated together. The
first defined the masking for the mode on the disk, while the second
filters the masking so we know which modes from the disk can be
trusted.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo_client.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/pseudo_client.h b/pseudo_client.h
index e963d95..b5ec204 100644
--- a/pseudo_client.h
+++ b/pseudo_client.h
@@ -87,7 +87,10 @@ extern int read_pidfile(FILE *, int *);
  * When doing anything which actually writes to the filesystem, we add in
  * the user read/write/execute bits.  When storing to the database, though,
  * we mask out any such bits which weren't in the original mode.
+ *
+ * Note: PSEUDO_DB_MODE must be kept in sync with PSEUDO_FS_MODE, as the
+ * former defined which filesystem mode bits must be loaded from the DB.
  */
 #define PSEUDO_FS_MODE(mode, isdir) (((mode) | S_IRUSR | S_IWUSR | ((isdir) ? S_IXUSR : 0)) & ~(S_IWGRP | S_IWOTH))
-#define PSEUDO_DB_MODE(fs_mode, user_mode) (((fs_mode) & ~0722) | ((user_mode & 0722)))
+#define PSEUDO_DB_MODE(fs_mode, user_mode) (((fs_mode) & ~(S_IRUSR | S_IWUSR | S_IXUSR | S_IWGRP | S_IWOTH)) | ((user_mode) & (S_IRUSR | S_IWUSR | S_IXUSR | S_IWGRP | S_IWOTH)))
 
-- 
1.8.3.1


