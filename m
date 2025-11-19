Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C384ACF34D3
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:57 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9146.1763564756742824217
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=TMv4iWHX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-20251119150554e2baf6d0c500020725-nxn4c0@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20251119150554e2baf6d0c500020725
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rU1QuEuHB4+G5jjzoEPLCx3wOSQovaNvDPePJ7DHOVs=;
 b=TMv4iWHXn6szbqk+0MRcDNtbf0Db6m0nhrIQhrkheZdop81pSRmxEE36dQuyAEpW77aOwh
 4Pmkcy5YprMKhO7bcl4rvRzJrkh3FmL4Vkt5483G+q1XkhQr0NPMu5Oe7BL9163eFVPxO9gy
 47D8+7T4QKbkQgGlMsMpY1Kmv5pX66EqCU/I8kEXz3BmTTsqb3zwA8RRQZAV3Wz5MLvS52mQ
 MqJc8YMXjSBh6LaBbN0EvseRqHPno1DXt7DWa6WtDA66zwPiroBbuxLHMLVjiX5Keu2vmnEk
 LbfrlvAlGPwXUbQ56RezQHctzesnWU1MEYMYASmdUFixTtXWX97aho0Q==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 15/35] go: remove support for GOROOT_FINAL
Date: Wed, 19 Nov 2025 16:05:02 +0100
Message-Id: <20251119150522.15477-16-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2588

From: Hongxu Jia <hongxu.jia@windriver.com>

After upstream go applied commit [cmd: remove support for
GOROOT_FINAL][1], GOROOT_FINAL variable is dropped and use
option -trimpath to instead [2]

The option -trimpath has already been added to GOBUILDFLAGS
in go.bbclass

[1] https://github.com/golang/go/commit/507d1b22f4b58ac68841582d0c2c0ab6b20e5a98
[2] https://github.com/golang/go/issues/62047

(From OE-Core rev: 791ab77ac05f658ecd61525a3d9b1afaf8ac6e06)

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-common.inc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-devtools/go/go-common.inc b/recipes-devtools/go/go-common.inc
index db16579..ca8469d 100644
--- a/recipes-devtools/go/go-common.inc
+++ b/recipes-devtools/go/go-common.inc
@@ -38,7 +38,6 @@ export GOARCH ?= "${TARGET_GOARCH}"
 export GOARM ?= "${TARGET_GOARM}"
 export GO386 ?= "${TARGET_GO386}"
 export GOMIPS ?= "${TARGET_GOMIPS}"
-export GOROOT_FINAL ?= "${libdir}/go"
 
 export GODEBUG = "gocachehash=1"
 

