Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFBACD6E55
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23133.1763038637367351346
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=h+XzlNNT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-20251113125714f134cddc1f00020737-cu0zic@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251113125714f134cddc1f00020737
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EYr7hb5CTWgqyzs48T0RYe8TaKXwzTwMdNLxOU0evKE=;
 b=h+XzlNNTlGL86dK0EKussEmpB+p0J0wx5RGeOhdb31BrZt1WHc4Q+3AUAxAGvv57MILXHe
 o2VpxQXd+qDTOYH3Rc1smSddRx2NuKkLdZTVQVH+7fPYmhu0HmrTJFToPlw8IJVyHHpxQyU0
 6JjdWAHw9BC6QNEH63MQvXKk93L/VrzVUXZAmMCctHRmKnBBTYumrA5ss8QtwelgJy1WnJL6
 pUyEOgnkJhZHWzvyzdAhlakjIKqWs+UIcvRMt+mRXl4caY6HjoXugpNvCV6Y77KD7oEUtnk3
 XVaEvgjEa4tKjmvE9aR7zyhK8oh1vGRJpmXD8759lAI19cNa58HAB+Fg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 09/34] meta/meta-selftest: Fix variable assignment whitespace
Date: Thu, 13 Nov 2025 13:56:47 +0100
Message-Id: <20251113125712.18914-10-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2512

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Recipes are much more readable with whitespace around the assignment operators.
Fix various assignments in OE-Core to show this is definitely the preferred
formatting.

(From OE-Core rev: 30ea609d3357fb3de911f2f6a5e6856c151b976a)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
index 65a79ab..cafcb2c 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -15,7 +15,7 @@ SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https"
 GO_IMPORT = "golang.org/x/example"
 GO_INSTALL = "${GO_IMPORT}/hello"
 
-export GO111MODULE="off"
+export GO111MODULE = "off"
 
 inherit go
 

