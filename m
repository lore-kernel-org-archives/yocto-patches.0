Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F595CF34C9
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:57 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9143.1763564756309508392
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=n6F+GVN5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-20251119150555d54a63cc01000207ea-hjvuul@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251119150555d54a63cc01000207ea
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4WSEcCsAyiKzlAdiS/5kbM/AkfGQ7NeFRSFBxz2ueUI=;
 b=n6F+GVN5PxDOggYUORahZTDp4VpVCvSvnHx8uBosflRHXo94598TgLbacBiW38/Xa9n9y6
 hOL4wTRMkABgmZ55rjPQy2kLxCvw8kK/b8M8UTgqLsxoY4uyyoAVnD/U2Y0kd5qxWZtxG/x4
 zJ2v51sKwABRtpGp9S/xg+gV6YY/F10y7XdgoZhbgRSFGHkpVjXStnlQyuDDcQiK9VgQhhtR
 WaP38m7wU6DrOWnuvMQLRcf45eqMy0bfGRDaEb3rBFm3kGEscQH2Y1Yo0LhdvOzfYifRzuRp
 Wly7rTebykruxgJ0j2dEA7YcofOY9kG7RPX6mHX6VbD3Geb8HZsAduyA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 21/35] go: set status of CVE-2024-3566
Date: Wed, 19 Nov 2025 16:05:08 +0100
Message-Id: <20251119150522.15477-22-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2590

From: Peter Marko <peter.marko@siemens.com>

NVD ([1]) tracks this as:
cpe:2.3:a:golang:go:*:*:*:*:*:*:*:*
Running on/with
  cpe:2.3:o:microsoft:windows:-:*:*:*:*:*:*:*

Yocto cve-check ignores the "Running on/with", so it needs to be ignored
explicitly.

[1] https://nvd.nist.gov/vuln/detail/CVE-2024-3566

(From OE-Core rev: c8ce6710d864d237fdf67d2c3d3aa0f0970a2a05)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/go-binary-native_1.24.4.bb | 1 +
 recipes-devtools/go/go-common.inc              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/recipes-devtools/go/go-binary-native_1.24.4.bb b/recipes-devtools/go/go-binary-native_1.24.4.bb
index 9f78853..a5324d0 100644
--- a/recipes-devtools/go/go-binary-native_1.24.4.bb
+++ b/recipes-devtools/go/go-binary-native_1.24.4.bb
@@ -17,6 +17,7 @@ UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
 
 CVE_PRODUCT = "golang:go"
+CVE_STATUS[CVE-2024-3566] = "not-applicable-platform: Issue only applies on Windows"
 
 S = "${WORKDIR}/go"
 
diff --git a/recipes-devtools/go/go-common.inc b/recipes-devtools/go/go-common.inc
index ca8469d..a79c90f 100644
--- a/recipes-devtools/go/go-common.inc
+++ b/recipes-devtools/go/go-common.inc
@@ -21,6 +21,7 @@ UPSTREAM_CHECK_REGEX = "(?P<pver>\d+(\.\d+)+)\.src\.tar"
 
 # all recipe variants are created from the same product
 CVE_PRODUCT = "golang:go"
+CVE_STATUS[CVE-2024-3566] = "not-applicable-platform: Issue only applies on Windows"
 
 INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
 SSTATE_SCAN_CMD = "true"

