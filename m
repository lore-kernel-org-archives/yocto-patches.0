Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E1CC44507
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 18:41:12 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.98544.1783104062423521341
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jul 2026 11:41:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 663IeuaD237103;
	Fri, 3 Jul 2026 13:41:00 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH v2 14/23] test/test-openat2-func.c: Remove unusuaed saved_errno
Date: Fri,  3 Jul 2026 13:40:46 -0500
Message-Id: <1783104055-19005-15-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783104055-19005-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783104055-19005-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 18:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4409

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
1.8.3.1


