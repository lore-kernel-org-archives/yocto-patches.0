Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679DFC88E63
	for <webhook@archiver.kernel.org>; Sun, 13 Sep 2026 15:51:19 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1431.1789314669469675681
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 13 Sep 2026 08:51:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=lIFbrN8x;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-2026091315510686e8c8b1f6000207f6-6y1sna@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026091315510686e8c8b1f6000207f6
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 13 Sep 2026 17:51:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ATAL1fUc9NjftA1lHO32bqGmz4N4FigpOMVe9SNKCgk=;
 b=lIFbrN8xsTeH6Phg5E6tUg82YeDtO1IJln9yOg2DL+2BHFBE6sZqti3hzd4441fE5/IcqV
 ecrioqH5DD7WyF/uCjRY/HuLAg2UdonKti7pdAHOtg8MDu3JSga5bRcjmusqc7ugmcI0M1kp
 cSMsFaTrgBFiRJ3wvz2ixqdrzEAg3wK/iN8aQlaQBhyniG9D4RRT5a8eRokHxGjTnlVZnIWt
 KZfvMKRpccO0bmN77KUjh1cmLh16hlqDoxc3RdK3VEU2GOmHts3GkSqoZtvIHRqSrs2SxtQr
 aKp8Zpl0UIK1D+XtFehf+cCbSi/iXVDWziNCM+UAWwbNqVk8AC18kg9A==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH] golang: fix homepage
Date: Sun, 13 Sep 2026 17:49:16 +0200
Message-ID: <20260913154916.3207747-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 13 Sep 2026 15:51:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4824

From: Peter Marko <peter.marko@siemens.com>

Leading space leads to SPDX document validation errors in some tools.

Example:
SchemaError: \" http://golang.org/\" is not valid under any of the
schemas listed in the 'anyOf' keyword
(components -> ... -> externalReferences -> 0 -> url)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: cbf36f436b477d81b58ff605846a2482308aefa4)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-binary-native_1.26.7.bb | 2 +-
 recipes-devtools/go/go-common.inc              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/go/go-binary-native_1.26.7.bb b/recipes-devtools/go/go-binary-native_1.26.7.bb
index 380b446..b2c4927 100644
--- a/recipes-devtools/go/go-binary-native_1.26.7.bb
+++ b/recipes-devtools/go/go-binary-native_1.26.7.bb
@@ -1,7 +1,7 @@
 # This recipe is for bootstrapping our go-cross from a prebuilt binary of Go from golang.org.
 
 SUMMARY = "Go programming language compiler (upstream binary for bootstrap)"
-HOMEPAGE = " http://golang.org/"
+HOMEPAGE = "http://golang.org/"
 LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=7998cb338f82d15c0eff93b7004d272a"
 
diff --git a/recipes-devtools/go/go-common.inc b/recipes-devtools/go/go-common.inc
index 2d617bd..df98f15 100644
--- a/recipes-devtools/go/go-common.inc
+++ b/recipes-devtools/go/go-common.inc
@@ -9,7 +9,7 @@ DESCRIPTION = " The Go programming language is an open source project to make \
  fast, statically typed, compiled language that feels like a\
  dynamically typed, interpreted language."
 
-HOMEPAGE = " http://golang.org/"
+HOMEPAGE = "http://golang.org/"
 LICENSE = "BSD-3-Clause"
 
 inherit goarch

