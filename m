Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2ACCD6E6C
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23132.1763038637349418038
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=kgdYC4Oe;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-20251113125714f2845512ea00020760-ek8whf@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251113125714f2845512ea00020760
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=l2qPCTVRhRC1fnU9fhK0WrtlzzojVcjIkGsszTuFlvI=;
 b=kgdYC4Oe2VXiKwaqOEpJvmt0jNUthje491QZtaFZsXaVW0w63F2OqzLJQnGPxvcoxlWbv8
 kqJ5FYWqOvCWyJp1spGe34Nyjmm1GykYlg/N+SBDPWwV9c5vqDPR6PKEmw/LdpaDUA6iX7sO
 7O/Lw7o5vBUSxwZqahF6si0WUupmrB98vp34mNUY1bWg4nKmX1oRZKwfaKyxL4AF5p6vIHhQ
 Pa4D9rtwcQ4Z7RvRPzEOePbupW3fsNHEcKNKVLcwvV5U+BiPPLO2qb+tCKSN9YEzyOHQfmM0
 bPX0xaKwL/JcyowUctGnQWbCS4d5Lm7ZyhcckDZSb2zYJYcqBbIOoOPA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 04/34] go-helloworld: update to latest revision
Date: Thu, 13 Nov 2025 13:56:42 +0100
Message-Id: <20251113125712.18914-5-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2513

From: Alexander Kanavin <alex.kanavin@gmail.com>

(From OE-Core rev: ed7d5a9e0ea2c970b3c101876dc3e3b8b5ae2ade)

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-extended/go-examples/go-helloworld_0.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
index 98cd4d8..74f3520 100644
--- a/recipes-extended/go-examples/go-helloworld_0.1.bb
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -6,7 +6,7 @@ LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
 
 SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https"
-SRCREV = "d9923f6970e9ba7e0d23aa9448ead71ea57235ae"
+SRCREV = "32022caedd6a177a7717aa8680cbe179e1045935"
 UPSTREAM_CHECK_COMMITS = "1"
 
 GO_IMPORT = "golang.org/x/example"

