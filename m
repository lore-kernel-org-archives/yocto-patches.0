Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE87ECF3963
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9161.1763564757829004920
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=YQl8RKVj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-20251119150555cb361ece4e000207ec-zxfuut@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251119150555cb361ece4e000207ec
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EoQd1ZxAWPnxjbBxd8U+AZgL/Of034FoFqWODs+GcT8=;
 b=YQl8RKVjJZVqIRRIh/mLmR9OK3TXVKTxwqEq8401Y+AP/IwFhAA5fzPZxuNL4xSWAaChf3
 4/vrPPl0AV/UCuWoABXu3lXKQ9BA9BvDzGLOP/cA1XLs5kKPPyIL42RYFGqS0XJtdaXboq3W
 b5nNSGGqr/xrIkMsR/2XoiGlSQM3cOFkDMYEkbVCB6LdpaGRGcK1Depqe1zSZ70+2Vb0C+jC
 rvVh0PPMY4HmttNAgSz9M2N5m1WS2CR2a38IoV+mYI5lB7rYy0pVU6HQZQwhzjGikWQXCfrx
 MhkX4rWQrjZtcLesDdHDCyUhHOysEPbH5DKHezYMd3f1YB+O1z6AptvA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 28/35] conf/layer: switch to golang 1.25
Date: Wed, 19 Nov 2025 16:05:15 +0100
Message-Id: <20251119150522.15477-29-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2613

From: Peter Marko <peter.marko@siemens.com>

This is extra config for mixin layer not needed on master anymore
because there this variable was dropped.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index f6f17a7..d4c6506 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -14,4 +14,4 @@ LAYERDEPENDS_lts-go-mixin = " \
     core \
 "
 
-GOVERSION = "1.24%"
+GOVERSION = "1.25%"

