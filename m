Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A9BCD6E72
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 20:39:21 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30001.1780519152382188437
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 13:39:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 653Kd9Ux2263173;
	Wed, 3 Jun 2026 15:39:10 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 1/6] Makefile.in: Add pseudo_client.h as a dependency
Date: Wed,  3 Jun 2026 15:39:03 -0500
Message-Id: <1780519148-30836-2-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1780519148-30836-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1780519148-30836-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 20:39:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4125

From: Mark Hatle <mark.hatle@amd.com>

Updating parts of the .h did not trigger a rebuild.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 Makefile.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.in b/Makefile.in
index 8719ddd..2bc259f 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -158,7 +158,7 @@ pseudo_tables.o: pseudo_tables.c
 	$(CC) $(CFLAGS) $(CFLAGS_PSEUDO) -c -o pseudo_tables.o pseudo_tables.c
 
 # no-strict-aliasing is needed for the function pointer trickery.
-pseudo_wrappers.o: $(GUTS) pseudo_wrappers.c pseudo_wrapfuncs.c pseudo_wrapfuncs.h pseudo_tables.h
+pseudo_wrappers.o: $(GUTS) pseudo_wrappers.c pseudo_wrapfuncs.c pseudo_wrapfuncs.h pseudo_tables.h pseudo_client.h
 	$(CC) -fno-strict-aliasing $(CFLAGS) $(CFLAGS_PSEUDO) -D_GNU_SOURCE -c -o pseudo_wrappers.o pseudo_wrappers.c
 
 offsets32:
-- 
1.8.3.1


