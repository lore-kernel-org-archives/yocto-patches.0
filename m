Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B07CD6E6E
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23165.1763038637506209674
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=oi6Uqm02;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-202511131257151c788ec338000207c8-kyr2nh@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202511131257151c788ec338000207c8
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Nvbr7vIeqeCcpSX+jDnrqkUVIW3TSq1oO+PCGTpPDEM=;
 b=oi6Uqm02ygrkCgIso2D9gOP1grsOhESdSh0hNYeB+9XOyUSb2XNngIflzSK0y8U802g8H2
 no34XeZk1HUqM0C//V6VcZMHFHYXJwMrYBJJk6+MYD2wA4u3wlFpUdJemtDEbLqZPvh9rMm2
 QRyJpdTfuMYceHfdyHWaT4Jc7EAldYhPIGTJmI9LjT4RftvzCJoLD8kH/qDvRPo3TYxOnpFy
 tbMy83NzyyJgOQ069dpnurzdbH3s+u/1wq1875A/XLKMBy1kvl4u8rNW2xqhiGbYQuZYNRX+
 O6C+cSNJhpGPQTsfJuwFaq8T1/TsN3HAAecjD6mu/MOaozt8fyDM4ioA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 28/34] conf/layer: switch to golang 1.25
Date: Thu, 13 Nov 2025 13:57:06 +0100
Message-Id: <20251113125712.18914-29-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2514

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

