Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26090CF3943
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9149.1763564756735047863
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=OeGsPgns;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-2025111915055496d020b8460002071e-4whtr8@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025111915055496d020b8460002071e
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zkcmSROVmAjcK9gd4s+wdqiDWwbF3BVmK7sD1HCU38g=;
 b=OeGsPgnsuRg2a6HFu/AZw5QbYX6HsVUCw/otrvE7wbVMWPYLludFJKrA5XHWHED2m/T+j2
 AMeOe8qV3Hsu8B6wSlqBxPIQn1YgwPpg/9aYOI8zvu4R4n/H3hDrOiq3MdTnUrwhgUjYjs9S
 Wzs/ctNQMvNepc+cIYpKqSBPGHfgskYoOYMYLNZfwdZ6NmHMKSC628E11te7DzMgnNjDquHJ
 /vwVHxHDkjQcoYVmCy8tELIHoBXnl9mvbDWq9k0R4uQxM3h2UU9wdOVTYap1cUDY1Q2KBO5N
 jWxa+Qd2wt9Ynim9qql35fFiKqKJDhwED5YW0nIUlP69Tfl6/gjHyE2g==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 08/35] go-helloworld: update to latest revision
Date: Wed, 19 Nov 2025 16:04:55 +0100
Message-Id: <20251119150522.15477-9-peter.marko@siemens.com>
In-Reply-To: <20251119150522.15477-1-peter.marko@siemens.com>
References: <20251119150522.15477-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 15:05:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2592

From: Alexander Kanavin <alex@linutronix.de>

(From OE-Core rev: b14bd8f189d967155159161ce65ea5aac52a3322)

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
index 31d8a0c..65a79ab 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -6,7 +6,7 @@ LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
 
 SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https;destsuffix=${GO_SRCURI_DESTSUFFIX}"
-SRCREV = "39e772fc26705bb170db248e5372a81ed5ffd67f"
+SRCREV = "d7b0ac1278591aea848a99258ccfdee8e4d454c1"
 UPSTREAM_CHECK_COMMITS = "1"
 
 # drop the 'destsuffix' so we make the oe-core backports easier without conflits
@@ -23,3 +23,6 @@ inherit go
 do_install:append() {
     mv ${D}${bindir}/hello ${D}${bindir}/${BPN}
 }
+
+# /usr/lib/go/src/golang.org/x/example/ragserver/tests/weaviate-show-all.sh is requiring bash
+RDEPENDS:${PN}-dev += "bash"

