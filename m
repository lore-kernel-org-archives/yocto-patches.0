Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE00CF34DA
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:57 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9153.1763564756992869693
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=cEnTVFao;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20251119150554cdcb567b490002073b-l1kqga@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251119150554cdcb567b490002073b
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EYr7hb5CTWgqyzs48T0RYe8TaKXwzTwMdNLxOU0evKE=;
 b=cEnTVFao/gpfqYFw0Pf9UR7z90xG+dqv0LzqMihZflS9Q+WRteqJ0Er/KN6fql73o4xiAx
 NFLakFauBQx+XetcupA2yTdnJG09F1buqNko4mkuUtPAQ6SCFSZted2k7thjsc3sKZPauDIC
 YoAOLKuodZtkOpFg+FoMi21zQWIB+g4rPJ+56HAQZ0C3sXOviQ9dI71qkA0rOpFs5v5kEXOu
 8MeJAsRT5Oh19d6UOKZaeplB83fNgn/vyvQKfr5Ns7dYwxSt6m3hDi9VsOMRBKxhTyxN8N1m
 QSKdQkSrH9d//fMeC8A6bY253uhogdOGF7KVAlXM6vhRLXTo0xbem3tQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 09/35] meta/meta-selftest: Fix variable assignment whitespace
Date: Wed, 19 Nov 2025 16:04:56 +0100
Message-Id: <20251119150522.15477-10-peter.marko@siemens.com>
In-Reply-To: <20251119150522.15477-1-peter.marko@siemens.com>
References: <20251119150522.15477-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 15:05:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2595

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
 

