Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6422C7115A
	for <webhook@archiver.kernel.org>; Thu, 19 Jun 2025 21:32:46 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.430.1750368765179161964
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Jun 2025 14:32:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=slxg6Vtc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-202506192132408a17b210dac986c453-0qma7i@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202506192132408a17b210dac986c453
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 19 Jun 2025 23:32:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=bLwrJObV67pdkc4KKgSOTi7739K5lHM1wQ1656jw4u8=;
 b=slxg6VtcOPpkORUQEZk4Hv2fiDSz/aH0Jl5htVuj3Q4Z6JunC1za3wCCfhMCqAQAYaWPls
 DF35T2JDrvlHtM0ei3pIsp2qbVAdr7B0NS1ZZAImu+0Gdo2+wVAzC2AVPvmUeQdETk5LiEhF
 HJHTyEhwxnf/JgTneQed8gWBGfFfLj0lcqmwVVAOnXIBIMjhi0/CDvH3enHnICY1Au9sIA0x
 3ZKYi3GpV/3chrl/pXfE2P1UjSYxcf0OcZxcEr9hjWCaGsZXXeiAGY+d6cd+LV2v+9Qzukrv
 bfEX9YWJI1FbaqF9MJQsH7at+zPIz8buBOfKMAot45brMVLykgY3lVuA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][kirkstone/go][PATCH] go: set status of CVE-2024-3566
Date: Thu, 19 Jun 2025 23:31:54 +0200
Message-Id: <20250619213154.16580-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Jun 2025 21:32:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1664

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

Switched CVE_SDTATUS to CVE_CHECK_IGNORE syntax.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-binary-native_1.24.4.bb | 3 +++
 recipes-devtools/go/go-common.inc              | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/recipes-devtools/go/go-binary-native_1.24.4.bb b/recipes-devtools/go/go-binary-native_1.24.4.bb
index 9f78853..d1f8fc6 100644
--- a/recipes-devtools/go/go-binary-native_1.24.4.bb
+++ b/recipes-devtools/go/go-binary-native_1.24.4.bb
@@ -18,6 +18,9 @@ UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
 
 CVE_PRODUCT = "golang:go"
 
+# not-applicable-platform: Issue only applies on Windows
+CVE_CHECK_IGNORE += "CVE-2024-3566"
+
 S = "${WORKDIR}/go"
 
 inherit goarch native
diff --git a/recipes-devtools/go/go-common.inc b/recipes-devtools/go/go-common.inc
index ca8469d..e90aab8 100644
--- a/recipes-devtools/go/go-common.inc
+++ b/recipes-devtools/go/go-common.inc
@@ -22,6 +22,9 @@ UPSTREAM_CHECK_REGEX = "(?P<pver>\d+(\.\d+)+)\.src\.tar"
 # all recipe variants are created from the same product
 CVE_PRODUCT = "golang:go"
 
+# not-applicable-platform: Issue only applies on Windows
+CVE_CHECK_IGNORE += "CVE-2024-3566"
+
 INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
 SSTATE_SCAN_CMD = "true"
 

