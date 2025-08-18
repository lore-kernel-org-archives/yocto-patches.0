Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A19CA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:51:48 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.470.1755557504299487820
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:51:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=QWsNftWY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-202508182251385cf8a1df4551e21720-dvodsj@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202508182251385cf8a1df4551e21720
        for <yocto-patches@lists.yoctoproject.org>;
        Tue, 19 Aug 2025 00:51:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=QysXQh3fVhGY/7HFxu9L2W69w0LaFtx70wuyBif/FdE=;
 b=QWsNftWYmpkN9bAME840AkLuutXqsoF8zhs7tYackRubyKxtk8kxCYc5JLx5230L/Baosy
 qpsM1KxnfKJ6W+hXpw/WBOXogzCx4kw1YGXYcib5FVeHmZU+Fsiz0Ge3hlLqOT5lgYm8VCxj
 HUoTMEFLGZX0wuxipiKwMyrtCaSaY9IE2guC1StbC7blFZ0QCxNGdxZFT3HrOTedopjkW5jx
 BUeUni7a+9my/jnP6/dciZ7JZfSey045DjqDeJCM8+ofGFu6yGwmzHxc6fI8qV47152PtM2B
 7iERrxClE6LQz8RLhPJImFLrUiuTrHLM8zFDIBuVeYp5LWrqkJMqGuWg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][kirkstone/go][PATCH] conf/layer: switch to golang 1.25
Date: Tue, 19 Aug 2025 00:50:46 +0200
Message-Id: <20250818225046.55311-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:51:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2051

From: Peter Marko <peter.marko@siemens.com>

No other changes seem to be needed.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 5d1b19f..6c1738b 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -14,7 +14,7 @@ LAYERDEPENDS_lts-go-mixin = " \
     core \
 "
 
-GOVERSION = "1.24%"
+GOVERSION = "1.25%"
 
 # Since go-1.21 GOPROXY needs to be set explicitly, otherwise it fails with:
 # GOPROXY list is not the empty string, but contains no entries

