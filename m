Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A2BC88E6F
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:14:22 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5612.1789413255544851488
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 12:14:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=qZmbFaOY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-202609141914139b1dbb0fd300020758-o4cc7x@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202609141914139b1dbb0fd300020758
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 14 Sep 2026 21:14:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=v1DNYaUbdLUUDz2ahCqJ2PkZw7kN/AMJVzIEI2eX3YY=;
 b=qZmbFaOYNB3mzqUD00T/BfnfEibGQ5DgfDke9DD6XKeOduQ34+1AXIrznJL7vHBT7x7krW
 nCwAYQxiVkyPBn+fPO2ftyFeQbiSanJZPAfD/R9N/eEeeN+CllIdI0r0Q/PqFsre5a7Qxmy7
 J4jNT9oem3CA2D6WBf00RB92YTDHUYx1xbBNbEN/C6M+HpsftAbhmuub/AIal12ub9+MEyi0
 H+G9axaDDxvNdUjeIJQZ0aKUoM+r3SprDmwpmSfcFvNCc4W5d4KFx8E7FHZgixS5PgLKPmIW
 x8RMKYj7cKHB+edQkMWEloWVXon7MtjBANXPJbKRjQi0VXjVkbR3ywuA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][wrynose/go][PATCH 08/11] golang: fix homepage
Date: Mon, 14 Sep 2026 21:12:37 +0200
Message-ID: <20260914191240.1066469-8-peter.marko@siemens.com>
In-Reply-To: <20260914191240.1066469-1-peter.marko@siemens.com>
References: <20260914191240.1066469-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 19:14:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4835

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
index 753f1b1..034c051 100644
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
index 5d0177b..a96e676 100644
--- a/recipes-devtools/go/go-common.inc
+++ b/recipes-devtools/go/go-common.inc
@@ -9,7 +9,7 @@ DESCRIPTION = " The Go programming language is an open source project to make \
  fast, statically typed, compiled language that feels like a\
  dynamically typed, interpreted language."
 
-HOMEPAGE = " http://golang.org/"
+HOMEPAGE = "http://golang.org/"
 LICENSE = "BSD-3-Clause"
 
 inherit goarch

