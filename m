Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8667CF34D9
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:57 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9150.1763564756770038152
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=EzPoXHgb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-2025111915055470fda668170002078f-iwcwe6@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025111915055470fda668170002078f
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0afVVTJc6rvr21It2wITI/i3Zftusw25WTxBZDrTHKM=;
 b=EzPoXHgbKGBLB6NUoqW1gjkF5iIswCRpCG0UzNJJ9U7kd2Mtzu8RYfR2NQ/bLNIMKGy8jA
 pFOfjikEBOAOFOdugNsCkSzEHk62kNYemobHsMbkrmcDheadtHvUw6fVp/GOOF2ESkgg3qUF
 wgm2xZr/ZzNEc6zyC60L2WB80wqiPiLIW06xBIeJpOiTs0Q6LGZrXZP7lZ8hjCszlD9vAwhj
 ZCFnnH5cxOnAF9Tob+bsp6EjzSidWBK6P339qe6CfTDvumZHjjayo4Kp0Sgv38lEmH6Bx6Oo
 rQKVDaCbHCKnKEDWe7ozITFwvLeuIwHlo3TFitsoJypv4fWwM8FcPdlA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 11/35] go-helloworld: fix license
Date: Wed, 19 Nov 2025 16:04:58 +0100
Message-Id: <20251119150522.15477-12-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2596

From: Peter Marko <peter.marko@siemens.com>

The example repo doesn't seem to have ever been under MIT.
It started with Apache-2.0, later changed to standard go license BSD-3.

The license file exists in the sources, so use that one instead of
taking it from the OE-Core license directory.

Note that this was already fixed in scarthgap and kirkstone, but it was
not submitted to master. Also the old releases still had Apache, so this
patch is different now with new versioni of thie component.

License-Update: Fix license declaration.

(From OE-Core rev: a192ce88b8b374fb50210e0c06d5801fe83d6d9e)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
index 586f45b..3ffe64b 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -2,8 +2,8 @@ SUMMARY = "This is a simple example recipe that cross-compiles a Go program."
 SECTION = "examples"
 HOMEPAGE = "https://golang.org/"
 
-LICENSE = "MIT"
-LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
+LICENSE = "BSD-3-Clause"
+LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a"
 
 SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https;destsuffix=${GO_SRCURI_DESTSUFFIX}"
 SRCREV = "8b405629c4a5215871be932097e099c05ec5cb2e"

