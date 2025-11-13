Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565C5CD6E6A
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23161.1763038637499248427
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=BM5FjUvE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20251113125715681db1554f000207f5-_9z2bq@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251113125715681db1554f000207f5
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rU1QuEuHB4+G5jjzoEPLCx3wOSQovaNvDPePJ7DHOVs=;
 b=BM5FjUvE/dNrJLfugO0fRLBkLCT3qYM5LAC4Qe7pmWuz6wKigGUfMa45fxL1olhjo/+Lvb
 sBPIjUUaogUuHJXfLVTNcnrtxANO/mUoioASdA3/JfOyKvjcWGYFOT0K2iXKICKdvVYj00+p
 lLbGJ+PNAPfl7fKyQwA3Nc8DYwiEMOZvw0RsPWpIAtIoeeVUN054z51vUk5MpRctcu8C9LRW
 x5yWzVmRsYjSqSfFvI6ROwrWTUtVuNqfVIJTdhH4u+xg3hLCEcCoUykR1bGWM6PKXEEkNIvV
 3DZfMkeR4MM+GSE+24Y4dqtTz94md1MMbDIB++eoRh55j0qLIiD+3lHQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 15/34] go: remove support for GOROOT_FINAL
Date: Thu, 13 Nov 2025 13:56:53 +0100
Message-Id: <20251113125712.18914-16-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2530

From: Hongxu Jia <hongxu.jia@windriver.com>

After upstream go applied commit [cmd: remove support for
GOROOT_FINAL][1], GOROOT_FINAL variable is dropped and use
option -trimpath to instead [2]

The option -trimpath has already been added to GOBUILDFLAGS
in go.bbclass

[1] https://github.com/golang/go/commit/507d1b22f4b58ac68841582d0c2c0ab6b20e5a98
[2] https://github.com/golang/go/issues/62047

(From OE-Core rev: 791ab77ac05f658ecd61525a3d9b1afaf8ac6e06)

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-common.inc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-devtools/go/go-common.inc b/recipes-devtools/go/go-common.inc
index db16579..ca8469d 100644
--- a/recipes-devtools/go/go-common.inc
+++ b/recipes-devtools/go/go-common.inc
@@ -38,7 +38,6 @@ export GOARCH ?= "${TARGET_GOARCH}"
 export GOARM ?= "${TARGET_GOARM}"
 export GO386 ?= "${TARGET_GO386}"
 export GOMIPS ?= "${TARGET_GOMIPS}"
-export GOROOT_FINAL ?= "${libdir}/go"
 
 export GODEBUG = "gocachehash=1"
 

