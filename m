Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F052FCF3973
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9148.1763564756602974363
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=EQC/LdkX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-202511191505554feeff595e0002070f-v6jzga@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202511191505554feeff595e0002070f
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oXKWMTgSYq7IfWEqcORRP2X7I8VdJJNrOwcyqcssqkw=;
 b=EQC/LdkXsNhJJ77KlPCjbFBjfnhMZU2dN9UdpmbrF/tckhasWfrZea5A7e9k1lSNsQ2zOa
 Y0oRtRqEDesB3lrNrPl34Wmq1PVk8z/bOr7BKL8kQb3oHRLtdYa4xCIAQcl42lx1CWcC6NPz
 BRPn6iDv0rngs5nqJjO/3KzRsOyuhkFq0QKWORAOZGuCp8C3nmJU0/wqOjrUYth7FCKjxG+6
 SLF/MZkfqc1OI36a1Cu7lH7/Ezvdr9TycH7gwQWSbcoUneqvBKwkrjkEYfYHNVAKAe07CNkc
 cg2m5SJ/1vQ6GWaA28+18Emw0u2z8YeO96JP/GF+RyFFaFXl++JTxsrQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 25/35] go-cross: Disable build with ccache
Date: Wed, 19 Nov 2025 16:05:12 +0100
Message-Id: <20251119150522.15477-26-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2616

From: Khem Raj <raj.khem@gmail.com>

go compiler does not work reliably with ccache
gcc: fatal error: no input files

(From OE-Core rev: 136743fe72591b90794ec30b9a3fbb41fe6a66aa)

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-cross.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/go/go-cross.inc b/recipes-devtools/go/go-cross.inc
index a0fbdbe..ebee2e5 100644
--- a/recipes-devtools/go/go-cross.inc
+++ b/recipes-devtools/go/go-cross.inc
@@ -5,6 +5,8 @@ DEPENDS = "go-native"
 
 PN = "go-cross-${TUNE_PKGARCH}"
 
+CCACHE_DISABLE = "1"
+
 export GOCACHE = "${B}/.cache"
 CC = "${@d.getVar('BUILD_CC').strip()}"
 

