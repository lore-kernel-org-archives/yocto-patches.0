Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B83CF34D0
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:57 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9144.1763564756649951482
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=gDOKvdjA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-20251119150554600c600e20000207a6-aykrsf@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251119150554600c600e20000207a6
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QK0SGDZSV8y4NHhAC83g+A4Co3deYvBGGcJPRD3dgKc=;
 b=gDOKvdjA3lQPkRl98FLvk74eV1VA+drHvl3ypkEOn66onXo3k8fTQG7hX8kX9umXWi3b4N
 n9EwvM25tZCXc2YmxQXMZ/CKEdqtMNE0DNTOFz6TMaQIxMpgYcGTKV919G+5ZYVB5I2SUwQu
 stcVDdwlVy8pMiihJoYBt95yYXS0rsik4p+3Kb29C+h0p88EVL3V6SWHXOuQQf7xJtsADHmi
 QqYsh5STw+pznWtpfXs/Xx6Ix+UfqEXMSGqSwGTXi0xyCMghe2iY2kYDsqjJulzxU8NNR4kK
 hN8UqFUR2cURiBGs+qqCuDUh99HIl4eqDNv3gETIGVI3T3TO9GTefvIA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 10/35] go-helloworld: update to latest revision
Date: Wed, 19 Nov 2025 16:04:57 +0100
Message-Id: <20251119150522.15477-11-peter.marko@siemens.com>
In-Reply-To: <20251119150522.15477-1-peter.marko@siemens.com>
References: <20251119150522.15477-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 15:05:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2586

From: Gyorgy Sarvari <skandigraun@gmail.com>

Shortlog:
- go.mod: update golang.org/x dependencies
- weave: fix %include parsing, add highlighting
- example/slog-handler-guide: run `make`
- example/weave: update TOC anchors to remove **, _, and `
- slog-handler-guide: remove doubled word
- slog-handler-guide: warn against embedding
- slog-handler-guide: fix typo, tweak phrasing

(From OE-Core rev: cfc6da6d0226d9d2ba1d59ecb1c86358be5daab2)

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
index cafcb2c..586f45b 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -6,7 +6,7 @@ LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
 
 SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https;destsuffix=${GO_SRCURI_DESTSUFFIX}"
-SRCREV = "d7b0ac1278591aea848a99258ccfdee8e4d454c1"
+SRCREV = "8b405629c4a5215871be932097e099c05ec5cb2e"
 UPSTREAM_CHECK_COMMITS = "1"
 
 # drop the 'destsuffix' so we make the oe-core backports easier without conflits

