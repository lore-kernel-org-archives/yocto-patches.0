Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B8FCD4F3D
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 17:10:56 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2460.1778692254955543783
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 May 2026 10:10:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=h0ZD2b2E;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-202605131710536bc91fc57d00020784-gspajj@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202605131710536bc91fc57d00020784
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 13 May 2026 19:10:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bmGzDhTkTnbxDCPR7k7k5AE0nPlxA4KlZ10+SvwP44s=;
 b=h0ZD2b2E3i8n/et1kpGKvkRKz44iWf0jwjjJGvxZBMV0n03p5L+7myPFDxF7ABRxMXw0eO
 EQoRgS0na+zNGC/eDicFYwOSTScR0evBaNYvDv+AQptVWerpGQDutpZraWf+HwnJF7AmgJJX
 mvaglehZuPVtMKE3UBQh5TEyr8Vds2dYrvxaDuCIR4IInxQxJ3Fs0DrBkDFPcY8D/w26KolQ
 3Oti5xHlemiix34y5qmw32NS93ERM6LbQ1bIBwEYlvOs2PiYq3QIPI6j+7NxBZewPu37u2Fb
 GFSRz0z518XoCumXJFQvkwlem9iggA7fpi165bhoY4M8eHNvDHlmow7g==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 6/7] readme: add go-ptest to testing
Date: Wed, 13 May 2026 19:09:00 +0200
Message-ID: <20260513170902.2468061-6-peter.marko@siemens.com>
In-Reply-To: <20260513170902.2468061-1-peter.marko@siemens.com>
References: <20260513170902.2468061-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 May 2026 17:10:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3988

From: Peter Marko <peter.marko@siemens.com>

Ptest support was added for go recipe, so add it to acceptance tests.

Switch to core-image-ptest-go, which automatically installs go-ptest.
It installs openssh, so dropbear would conflict with it.
TEST_SUITES are alreary se there, so just append go, not overwrite.
QB_MEM is set there already to 4096, so drop our setting which would
cause a decrease and thus break it.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 README.md | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/README.md b/README.md
index 080cbfe..28d43f0 100644
--- a/README.md
+++ b/README.md
@@ -54,14 +54,13 @@ Automated tests to verify go toolchain functionality are being executed with fol
 * OEQA runtime
 
     ```
-    IMAGE_INSTALL:append = " packagegroup-core-ssh-dropbear go-helloworld packagegroup-go-sdk-target"
+    IMAGE_INSTALL:append = " go-helloworld packagegroup-go-sdk-target"
     IMAGE_CLASSES += "testimage"
-    TEST_SUITES = "ping ssh go"
-    QB_MEM = "-m 2048"
+    TEST_SUITES:append = " go"
     ```
 
     ```
-    bitbake core-image-minimal && bitbake core-image-minimal:do_testimage
+    bitbake core-image-ptest-go && bitbake core-image-ptest-go:do_testimage
     ```
 
 * OEQA SDK

