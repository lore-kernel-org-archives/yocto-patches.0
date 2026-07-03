Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16496C43327
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:32 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83551.1783039588586923062
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ1D069650;
	Thu, 2 Jul 2026 19:46:23 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 14/23] test/test-openat2-func.c: Remove unusuaed saved_errno
Date: Thu,  2 Jul 2026 19:46:09 -0500
Message-Id: <1783039578-31531-15-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4386

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 test/test-openat2-func.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/test/test-openat2-func.c b/test/test-openat2-func.c
index 00c3e12..619a656 100644
--- a/test/test-openat2-func.c
+++ b/test/test-openat2-func.c
@@ -109,7 +109,6 @@ int main(void) {
 	int dirfd = -1;
 	int fd = -1;
 	int rc = 1;
-	int saved_errno;
 	struct open_how how;
 	char cwd_save[PATH_MAX];
 	int cwd_saved = 0;
-- 
2.53.0


