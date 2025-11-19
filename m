Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA47CF3958
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9143.1763564756309508392
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=fRctMrcD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-20251119150555238fd3632600020725-ss1bc9@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251119150555238fd3632600020725
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QJahyFmI8n2AjUqWvHZopK9GJFAH5AXSzxmA8ZnMflU=;
 b=fRctMrcDppyYxm7pANgTEAYl78S4eZVRKXsFcDWJ/IMboSqgfuupYN1CXrvoS2uyatyD8l
 h2yqCpT7v5q3dZGOEThxEl52fj5S5F1ivChj9Pk9jEbQiYABOYL1PPkJ1/rpSvEuSwPK+wNy
 5gtA4iCAgo/tz205DGQZCzkNT3l1pUqf+y1zae6hUZXMGlt3duLf+JLUzKfZpuM2JMCcZpBz
 8tfiXXesFoIlcl1nriNbfT561I+SQwyaavHolYeTbeXkDFF3l2dFZg9Ajjr3Fw7yrffLaX5G
 kIKsoURImIvPo4c5w3yZDbCGJ8vTnKr2Y/x47hqgi6mpSGxRl6/hFyCw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 16/35] tcmode-default: bump GOVERSION to 1.24.0
Date: Wed, 19 Nov 2025 16:05:03 +0100
Message-Id: <20251119150522.15477-17-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2610

From: Hongxu Jia <hongxu.jia@windriver.com>

Due to we have upgraded go to 1.24.0, we should also bump GOVERSION
to fix preferred version warning
...
WARNING: preferred version 1.22% of go not available (for item go)
WARNING: versions of go available: 1.24.0
...

(From OE-Core rev: 939449cfcb4a920132145d2ad1212bac3acb1baa)

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 conf/layer.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/layer.conf b/conf/layer.conf
index 41bc938..f6f17a7 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -13,3 +13,5 @@ LAYERSERIES_COMPAT_lts-go-mixin = "scarthgap"
 LAYERDEPENDS_lts-go-mixin = " \
     core \
 "
+
+GOVERSION = "1.24%"

