Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD54CD8C8F
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23156.1763038637368816286
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=L2dBNoyU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-20251113125714d2d92a13b500020788-ckj_mn@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251113125714d2d92a13b500020788
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Qo8WWwq7ekjbYtUnfSDa52ObsMUGIJsxckzjtt5J4yw=;
 b=L2dBNoyUD8A5EWowYlScnm6H1Rvmcn6bX9iu2oPlVvYD7thaHHFW7tOJZJBEuLZyj7q/rR
 yCeOu8OYASbRoL0QNrNTFtwkNctynone9sXiexy/Umugfg1L1Kk9tWrhfZamE2PK8vHwwLyh
 Y3gk2civ63lVgYtPxGNtaJkfhFanwpHjFB/MnSy5F/1xxV8HLraJy8Ue+jvWwtrkHXNQBUq1
 Y2oBuKLoyt/EHdhnFiu87fjVSCgb4lTK2e5RAbBSjGG5FK8XLbbPGe3wU/l+m3+NE3YHHSzl
 ztgB+r7Vt/U68Q+qerwAs+5TfYjobCDvG2EktFGFasyQ0EPFB4CyoBhA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 07/34] go-helloworld: update to latest revision
Date: Thu, 13 Nov 2025 13:56:45 +0100
Message-Id: <20251113125712.18914-8-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2511

From: Alexander Kanavin <alex@linutronix.de>

(From OE-Core rev: 62b8005e6df13fed7754d504d7aa37614d318008)

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
index 4f9e60d..31d8a0c 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -6,7 +6,7 @@ LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
 
 SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https;destsuffix=${GO_SRCURI_DESTSUFFIX}"
-SRCREV = "32022caedd6a177a7717aa8680cbe179e1045935"
+SRCREV = "39e772fc26705bb170db248e5372a81ed5ffd67f"
 UPSTREAM_CHECK_COMMITS = "1"
 
 # drop the 'destsuffix' so we make the oe-core backports easier without conflits

