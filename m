Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C1ACF3941
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9147.1763564756377070090
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=lvSb7wNi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-20251119150554604687991b000207f8-gbyz0d@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251119150554604687991b000207f8
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=do8NVNy/83VS54TS9AF8Tv6kmnFkrjHe/tTmAytWXIQ=;
 b=lvSb7wNi5OGAH/7dZ8nnbti9kUnUp9V+WSv39YRHyWpzPcmkKscE5/nbVxMmnp9D7XaMXe
 AhEZ5C8/x4gzyQzt+u7yDaYL/IfHJDlBbXMaje6DsmyaOMxw7q94jNkeM5XddTdzyMvcu5hz
 L/g+8aV2nNrURa2+p6AANHGM5VGjuyO3nBE77Ytk4FH2K7KiS8urNbu8RGKTAquRz32gAoK4
 /HA8Dcw/KpT+j+8QV599CsgKNAlh6ude64HqjiKqQYi6ocBmvTRXYxbe7ISTqW5eTScuiEEW
 xQe/fV8oARjS9CTgjH+6aZ8gVULZp86c8DoEJrm0YBFOS6Uxo6JKBUaQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 05/35] go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX
Date: Wed, 19 Nov 2025 16:04:52 +0100
Message-Id: <20251119150522.15477-6-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2600

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The go class has its own fork of the base unpack code. At the time I was
told this was fine, it now isn't as that code is changing.

Rather than have a fork, put the path magic into a variable and then go
recipes can just set SRC_URI appropriately, e.g.:

git://go.googlesource.com/example;branch=master;protocol=https;destsuffix=${GO_SRCURI_DESTSUFFIX}

This avoids having special case hacks in the class and makes everything
a little more obvious.

(From OE-Core rev: cc4ec43a2b657fb4c58429ab14f1edc2473c1327)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
index 74f3520..575ee81 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -5,7 +5,7 @@ HOMEPAGE = "https://golang.org/"
 LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
 
-SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https"
+SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https;destsuffix=${GO_SRCURI_DESTSUFFIX}"
 SRCREV = "32022caedd6a177a7717aa8680cbe179e1045935"
 UPSTREAM_CHECK_COMMITS = "1"
 

