Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF4CCD4F3E
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 17:10:26 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2446.1778692224850853352
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 May 2026 10:10:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=V3V0wZ7k;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-20260513171022eecde3ce09000207f7-ur7sm8@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260513171022eecde3ce09000207f7
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 13 May 2026 19:10:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LoP/mi3EnJp6JEcPGONBcJfEpT/NFngqbRxjUhxihpE=;
 b=V3V0wZ7kkNx+bqXX7k1SOM724ZRocsZ5YQUGQ+pQ5LKrkCpo74Q6jwprvoKMfjpZbCVE8w
 X/uBP4r9v08APfiVXM3dYwRyC6P99AygAEbsbMhE3xTFWnSOaZnzuQB2/4andKj6WI4jI4g2
 MWOeB4WSZGHUN3l68UQAk9cgCRXFQsRBSkg0s6SXK8Ru6GWd1J0+uXW8pwLnX1nUSUOO4rFN
 Q792QBjwtPtq1XLzWh/vuLWExCHYhvjoykA3z4jtwK5mISuPkjoN/kpppJ9nxYKcI0E02Dfp
 q8OYQCyGUL9Uc2QsIktwjKe4XK2ayZPCh2OHBamdNlO9NrT2EXXl6YEw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 2/7] go: set status for CVE-2024-24786
Date: Wed, 13 May 2026 19:08:56 +0200
Message-ID: <20260513170902.2468061-2-peter.marko@siemens.com>
In-Reply-To: <20260513170902.2468061-1-peter.marko@siemens.com>
References: <20260513170902.2468061-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 May 2026 17:10:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3984

From: Peter Marko <peter.marko@siemens.com>

cvelistV5 has wrong CPE:
* "cpe:2.3:a:golang:go:*:*:*:*:*:*:*:*"

The CVE is actually for golang-google-protobuf as links in the CVE
report prove:
* https://pkg.go.dev/vuln/GO-2024-2611

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: be622a8da624b8cf04e4bfbbf6d751825ec37f9a)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-binary-native_1.26.2.bb | 1 +
 recipes-devtools/go/go-common.inc              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/recipes-devtools/go/go-binary-native_1.26.2.bb b/recipes-devtools/go/go-binary-native_1.26.2.bb
index 3c76a67..f36606b 100644
--- a/recipes-devtools/go/go-binary-native_1.26.2.bb
+++ b/recipes-devtools/go/go-binary-native_1.26.2.bb
@@ -18,6 +18,7 @@ UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
 
 CVE_PRODUCT = "golang:go"
 CVE_STATUS[CVE-2024-3566] = "not-applicable-platform: Issue only applies on Windows"
+CVE_STATUS[CVE-2024-24786] = "cpe-incorrect: this CVE is for golang-google-protobuf"
 
 S = "${WORKDIR}/go"
 
diff --git a/recipes-devtools/go/go-common.inc b/recipes-devtools/go/go-common.inc
index a79c90f..2d617bd 100644
--- a/recipes-devtools/go/go-common.inc
+++ b/recipes-devtools/go/go-common.inc
@@ -22,6 +22,7 @@ UPSTREAM_CHECK_REGEX = "(?P<pver>\d+(\.\d+)+)\.src\.tar"
 # all recipe variants are created from the same product
 CVE_PRODUCT = "golang:go"
 CVE_STATUS[CVE-2024-3566] = "not-applicable-platform: Issue only applies on Windows"
+CVE_STATUS[CVE-2024-24786] = "cpe-incorrect: this CVE is for golang-google-protobuf"
 
 INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
 SSTATE_SCAN_CMD = "true"

