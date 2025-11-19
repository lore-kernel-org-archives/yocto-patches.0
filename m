Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300A5CF394B
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9148.1763564756602974363
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=Hpf8fY0E;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-20251119150554a90c71c4f000020730-ceovu5@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251119150554a90c71c4f000020730
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Qo8WWwq7ekjbYtUnfSDa52ObsMUGIJsxckzjtt5J4yw=;
 b=Hpf8fY0EIeCqmNyGiPBLKd07gKCRkDYuZsFR1owS+IEJglvYm32f/hAaw8n2zqJnaPwAuc
 ZKx3vefCI+vY3siH5vu3GUM1AD5otrKfIGIs+aqYaCDIf0vVSJT1YWb3F+OhjUDpAHbJtcPj
 Nn1rxKz8de2GJDKN2MFr1XpVB7uQkE664D8ho7OdBqtBK9N/X4CO1uaUC+/szIbzGdnhYPUA
 bP3zeFAiiFBJ7yZM7hmrb1Gt3G9ZdlPdMR4u7GmHtGVQpSgpsNgDaC3ZOgDscoolhUKrZ+yM
 vNitFJPez8xJktq0dK3Ct2F8piLXT0dUGSmUrIodhOpxM4PUCupQ7HiA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 07/35] go-helloworld: update to latest revision
Date: Wed, 19 Nov 2025 16:04:54 +0100
Message-Id: <20251119150522.15477-8-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2593

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

