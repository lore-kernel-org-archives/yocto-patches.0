Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475A3CD6E65
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23134.1763038637367572578
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=gxOn0ZN8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-20251113125715a3f8fdc3f100020748-tpqaxv@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251113125715a3f8fdc3f100020748
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EBMB2z5k/2fJE/o8O/kpwbDehnID10diD4nT+nz+UN0=;
 b=gxOn0ZN8oJ8FCqW7Zzb/DQCLfjIJRfuKADmWD/I+AqHl/tQ6YiGE0AFpuZ7KjQu7Ew/EMR
 UKYIMAL2qHUHXv5TT8QZyUY1afDSSau1XfEwH6rzOZ3MP2mW9SuV9RNJMSMMrDk8pGXaAFpH
 qHCfag4N4I4XltIR/WoP705ZodLN8iNyp5AoRSjFHEp1FnWI6/v5Soln4MHUEHP9l2c0xJn/
 JG/VQz+qFRLeL15B34Ed84xoRCV4QBdBoz9x1rLbL4DjLry194j6BwOqf5sQpdWMF+xAoaOk
 +y8MmFJiai1zXF8xr9zkhW/IA/eVwhXlLuQrvx/PV/d9A6lklqosKk0w==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 11/34] go-helloworld: fix license
Date: Thu, 13 Nov 2025 13:56:49 +0100
Message-Id: <20251113125712.18914-12-peter.marko@siemens.com>
In-Reply-To: <20251113125712.18914-1-peter.marko@siemens.com>
References: <20251113125712.18914-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:57:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2529

The example repo doesn't seem to have ever been under MIT.
It started with Apache-2.0, later changed to standard go license BSD-3.

The license file exists in the sources, so use that one instead of
taking it from the OE-Core license directory.

Note that this was already fixed in scarthgap and kirkstone, but the
patch was not merged into master. Also the old releases still had
Apache-2 license, so this patch is different now with new version of
the component.

License-Update: Fix license declaration.

Reported-By: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
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

