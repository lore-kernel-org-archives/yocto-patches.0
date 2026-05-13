Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BFECD4F3D
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 17:10:26 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2433.1778692218205967163
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 May 2026 10:10:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=mK6I6xn8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-2026051317101696fd5e73000002078f-9dl4uq@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026051317101696fd5e73000002078f
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 13 May 2026 19:10:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=6GKNTaf48yKHIu4i5ZMjJaPnkHkPEZ04VxuULHWz7Vo=;
 b=mK6I6xn8+SS9awUjftnICSM95fbADY0h/Wakv4hmE7cFR6l4PXvqdWiSUWrMQRGgsVHU1I
 5r7c8PNzm/eo3U3EHIa1rpx56HRcZ8h98YCLfJoifA/rroGuTU7/0M8ub0Trc3NIunBimxvg
 Fjs23sF1uS8Y8Bl8cYZrAEGdyGYiAWmVfjOqxWWBVjUZkZY1TdqZIpiA9ee6HikOKRxq69yr
 lWF/tXNnA2T59zL54605RaUwlr/yOBBucia7YmNdAJQ0aL2FaRZUaRLVuy6QDgkO9E9CR6oD
 UzZ0HLRPAEgjWBmJ8BmCaNEUTpzpv6XH0VDxWrN+4H4ebkztYzdAEWPA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 1/7] go-helloworld: upgrade to latest revision
Date: Wed, 13 May 2026 19:08:55 +0200
Message-ID: <20260513170902.2468061-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 May 2026 17:10:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3983

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: 7f05d217867b2af52b0a28c6d1c91df97e1b5b39)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
index 3ffe64b..c8401c9 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -6,7 +6,7 @@ LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a"
 
 SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https;destsuffix=${GO_SRCURI_DESTSUFFIX}"
-SRCREV = "8b405629c4a5215871be932097e099c05ec5cb2e"
+SRCREV = "7f05d217867b2af52b0a28c6d1c91df97e1b5b39"
 UPSTREAM_CHECK_COMMITS = "1"
 
 # drop the 'destsuffix' so we make the oe-core backports easier without conflits

