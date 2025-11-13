Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F814CD6E74
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23135.1763038637367686829
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=Rt/JyJ4Z;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-20251113125715c7996d029b0002076a-wxcfq1@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251113125715c7996d029b0002076a
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QJahyFmI8n2AjUqWvHZopK9GJFAH5AXSzxmA8ZnMflU=;
 b=Rt/JyJ4ZLVMlgsnekharY2UcP5ayqcfIAXlw0C1095xq28P44mR5xvmA+BF6FDAvkxosp4
 3FH7VMpZJZtIXasZN8maED798r2qjtXNn77Wo/KQ+1OCbqhGktYQFqUv76KwuKAvHvVu63ye
 XFbYS9MkccnbRpLqXq/dG3pOUIJ8M1Kh+OLWVZk8YAmFpiw92G0suzm+8D6wmqQDytO5PUs0
 kikm2MDnf6ucpErU3xDcNQ1ALodYFqc576x4OcPmSSEFCUStNVeMGW80sDpCDeIUomUARO7r
 wtDpkAIiW+0jk3QiRnDBx67Y8QHCLEn79bMqRZkQcpVzDCgUjCJezomw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 16/34] tcmode-default: bump GOVERSION to 1.24.0
Date: Thu, 13 Nov 2025 13:56:54 +0100
Message-Id: <20251113125712.18914-17-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2525

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

