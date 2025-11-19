Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A4BCF34D5
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:57 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9145.1763564756691608539
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=I7OXDI7e;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-202511191505544ef8586d17000207d5-eawbvx@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202511191505544ef8586d17000207d5
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jfirrN/TavmEII76NWdWUzLgM7kcUwpYqho9Pp+gThk=;
 b=I7OXDI7eA6RY2hrllh5b/dsJ/9nICY62EaKZvZnVvyj5X4BG3Gsl5mBx3Plj4uJnfgnfFU
 nGWvepSwgQx8G9sG5YJUQphdWGoUFKQk3EKvImjPZblwZH+MtSXr2GybbuDf2TCQ2mVhkr0X
 IjyoUCcWKhIbB8F0jwn3dmlnmBz/3mOajAUROCdSvzpVwkTfF6ycIn0I8B2TkGvBuvPTXSXY
 UbR87DnDV+ciCfGE30fRzUYjTwyUwAzcR4uDnEF5tvhVwoDDj4/l1jZnV0k6/wR3wU81lVhc
 mrdah6qAXe3GAGigbFpyhBNUR3tBB+izuGjZjFQs8wOC81gSd8ae7QAQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 06/35] Revert "go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX"
Date: Wed, 19 Nov 2025 16:04:53 +0100
Message-Id: <20251119150522.15477-7-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2587

From: Jose Quaresma <jose.quaresma@foundries.io>

This reverts commit f3bb48cea8c9794ff9e4d9eb13309c4651a7a226.

This drop the 'destsuffix' overriding the SRC_URI
so we make the oe-core backports easier without conflits.

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
index 575ee81..4f9e60d 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -9,6 +9,9 @@ SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https;destsu
 SRCREV = "32022caedd6a177a7717aa8680cbe179e1045935"
 UPSTREAM_CHECK_COMMITS = "1"
 
+# drop the 'destsuffix' so we make the oe-core backports easier without conflits
+SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https"
+
 GO_IMPORT = "golang.org/x/example"
 GO_INSTALL = "${GO_IMPORT}/hello"
 

