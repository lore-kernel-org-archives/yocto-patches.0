Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3D1E9A04C
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 19:46:52 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2826.1771443999746325681
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Feb 2026 11:46:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=ZCpbPStZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-202602181946426b8454bb30000207cb-sngfb8@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202602181946426b8454bb30000207cb
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 18 Feb 2026 20:46:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kq1Swo3Xjy7TiEEvQcnSex00+Y9OBKkGMKhJa7l9b6A=;
 b=ZCpbPStZYfdex61epr8AnWCn00UGMhMjM2NHJwD/SsY2f8NeqHh87q7ZxVH/px+mFvvR2D
 06b0uS82wX+yN+yvU+n/q8QsGOVCRJGpJyNAM1075Pd1nkEtXGCHtOjjcDuhu6e8Nn5AjJkU
 UJqbMipj4PzKZHwG567XOgKkHdJ4qomt4pH0bqVEy3Q+wcPWNjQy4jaTdv6qYWhCPKgbxwWh
 KAAOcAYcqDqmQ9w+D9La9jED/Etg4PqcTSeS0CroSLLGiEf3jYSXPhVW9zbcwFGC2FJf3rTv
 XKSL46JxJbyva4s+fFVX2uZQEOFCZIc1fMnOz51ClGUbWouRg90rDQjA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][kirkstone/go][PATCH 2/2] conf/layer: switch to golang 1.26
Date: Wed, 18 Feb 2026 20:46:35 +0100
Message-Id: <20260218194635.4136702-2-peter.marko@siemens.com>
In-Reply-To: <20260218194635.4136702-1-peter.marko@siemens.com>
References: <20260218194635.4136702-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Feb 2026 19:46:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3260

From: Peter Marko <peter.marko@siemens.com>

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 6c1738b..1aa72e9 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -14,7 +14,7 @@ LAYERDEPENDS_lts-go-mixin = " \
     core \
 "
 
-GOVERSION = "1.25%"
+GOVERSION = "1.26%"
 
 # Since go-1.21 GOPROXY needs to be set explicitly, otherwise it fails with:
 # GOPROXY list is not the empty string, but contains no entries

