Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73539D47CB4
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.758.1768520622128155955
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjc2408772;
	Thu, 15 Jan 2026 17:43:40 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 07/20] test/test-nftw: Avoid compile warnings
Date: Thu, 15 Jan 2026 17:43:23 -0600
Message-Id: <1768520616-7289-8-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2983

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 test/nftw-test-impl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/nftw-test-impl.c b/test/nftw-test-impl.c
index 714da76..8d4c1a8 100644
--- a/test/nftw-test-impl.c
+++ b/test/nftw-test-impl.c
@@ -41,6 +41,8 @@ char* get_absolute_path(const char* fpath) {
 }
 
 static int callback(const char* fpath, const struct NFTW_STAT_STRUCT *sb, int typeflag, struct FTW *ftwbuf){
+    (void) ftwbuf;
+
     if (print_filename) {
         char* filepath = get_absolute_path(fpath);
         printf("%s\n", filepath);
-- 
2.43.0


