Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8F2D3CC99
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 01:10:19 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26076.1768439409413596760
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Jan 2026 17:10:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60F1A4H82303376;
	Wed, 14 Jan 2026 19:10:05 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 1/4] test-syscall: Remove build warning
Date: Wed, 14 Jan 2026 19:10:00 -0600
Message-Id: <1768439403-23665-2-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768439403-23665-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768439403-23665-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 01:10:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2960

From: "mark.hatle" <mark.hatle@kernel.crashing.org>

Compiler is warning about argc and argv not being used.

Signed-off-by: mark.hatle <mark.hatle@kernel.crashing.org>
---
 test/test-syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/test-syscall.c b/test/test-syscall.c
index 1e21525..9031766 100644
--- a/test/test-syscall.c
+++ b/test/test-syscall.c
@@ -11,7 +11,7 @@
 #include <string.h>
 #include <errno.h>
 
-int main(int argc, char *argv[]) {
+int main() {
     long rc = 0;
 
 #ifdef SYS_renameat2
-- 
1.8.3.1


