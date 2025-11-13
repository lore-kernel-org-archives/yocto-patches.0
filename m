Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F1ECD6E7E
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23138.1763038637498253632
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=h1R/AFXw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-2025111312571527619bd529000207f2-qma8di@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025111312571527619bd529000207f2
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8rwFCxVRcYby+xysu4aJfOflaEIRDNcoxr4Sted8Igc=;
 b=h1R/AFXwskUACqlIhD2Ska9VeaZZl6nUtpNq5W2L2p4dX7dQV7nY/OqwwAuc/v+WJpFRVv
 BKPwiL0jEEzWmMJyUF6rN9gjs8O7I3Wgo3PB/rRuOmoSEvoYe/rkax/fCclloz96iVTlsTr6
 3hwXWFa/BM/Pd32+wQ/tOf7X/tV+6/B3oPxJSZZ937qqhIMH94IGWmdDsOgHxOvpAAtx260S
 M2OKGs5ri8QTu8tiQG+71vAujAvbqbVeIg+yNYfd2b5f97NeTtWfjsc2LvQTYg5SJzX+tEFc
 xxj/2sLZRfj2ZKI0s6g8smIfHn/ZBQyqCZyJgEmACBLk09TPQPnzf3wg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 21/34] go: set status of CVE-2024-3566
Date: Thu, 13 Nov 2025 13:56:59 +0100
Message-Id: <20251113125712.18914-22-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2521

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

