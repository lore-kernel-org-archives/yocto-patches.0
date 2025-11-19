Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615E2CF3955
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9145.1763564756691608539
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=NlRhpI8D;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-20251119150555aa6156dd6500020747-a_f_bb@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251119150555aa6156dd6500020747
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ig3Oa3dluqNTGgD231y33yMI3NO4Ykq4rfnSXCr+878=;
 b=NlRhpI8Di599Qug2V6ReqNP2lzWupmhHLORWdTYJ6RsCE3pSYQXQRFeXlPFsWVK1Lt1slo
 mJT/xXRF73shelpqwYd8ZHw03D402+93r/ODhwtwCTbGepDCu96Fiil9p4b18MbruJ5xnOMP
 5VMY6VY5igtHmyI7dzh8lUmYPS8TEdrd/CQrIsAbbhJcPSX8DbnP8GpWfuPi5+uYy+gOxCTW
 laY3wwGyntEAiWCZ6qqEhknWAo1vqO6aNcs/GW65aHKkEKuPDVVbxGTg4F0J9uioW3RvdTfU
 uL46ZmMTgMjgMw4z3e1N/O8g6PC/vjVzg2TMTw8UhOVR2u11H6VAwaig==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 32/35] go: upgrade 1.25.2 -> 1.25.3
Date: Wed, 19 Nov 2025 16:05:19 +0100
Message-Id: <20251119150522.15477-33-peter.marko@siemens.com>
In-Reply-To: <20251119150522.15477-1-peter.marko@siemens.com>
References: <20251119150522.15477-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 15:05:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2607

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.25.x release [1]:

$ git --no-pager log --oneline go1.25.2..go1.25.3
28622c1959 (tag: go1.25.3) [release-branch.go1.25] go1.25.3
e05b2c92d9 [release-branch.go1.25] crypto/x509: rework fix for CVE-2025-58187
79ec0c94f3 [release-branch.go1.25] spec: update spec date to match release date

This release addresses breakage caused by a security patch included in Go 1.25.2
and 1.24.8, which enforced overly restrictive validation on the parsing of X.509
certificates. We've removed those restrictions while maintaining the security
fix that the initial release addressed [2].

[1] https://github.com/golang/go/compare/go1.25.2...go1.25.3
[2] https://groups.google.com/g/golang-announce/c/YEyj6FUNbik

(From OE-Core rev: d5f281bf13995117d98af809a2caea91e241713e)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.25.2.inc => go-1.25.3.inc}        | 2 +-
 ...o-binary-native_1.25.2.bb => go-binary-native_1.25.3.bb} | 6 +++---
 ...cross-canadian_1.25.2.bb => go-cross-canadian_1.25.3.bb} | 0
 .../go/{go-cross_1.25.2.bb => go-cross_1.25.3.bb}           | 0
 .../go/{go-crosssdk_1.25.2.bb => go-crosssdk_1.25.3.bb}     | 0
 .../go/{go-runtime_1.25.2.bb => go-runtime_1.25.3.bb}       | 0
 recipes-devtools/go/{go_1.25.2.bb => go_1.25.3.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.25.2.inc => go-1.25.3.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.25.2.bb => go-binary-native_1.25.3.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.25.2.bb => go-cross-canadian_1.25.3.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.25.2.bb => go-cross_1.25.3.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.25.2.bb => go-crosssdk_1.25.3.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.25.2.bb => go-runtime_1.25.3.bb} (100%)
 rename recipes-devtools/go/{go_1.25.2.bb => go_1.25.3.bb} (100%)

diff --git a/recipes-devtools/go/go-1.25.2.inc b/recipes-devtools/go/go-1.25.3.inc
similarity index 91%
rename from recipes-devtools/go/go-1.25.2.inc
rename to recipes-devtools/go/go-1.25.3.inc
index 9d1cf69..c29f4d6 100644
--- a/recipes-devtools/go/go-1.25.2.inc
+++ b/recipes-devtools/go/go-1.25.3.inc
@@ -18,4 +18,4 @@ SRC_URI += "\
     file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch \
     file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch \
 "
-SRC_URI[main.sha256sum] = "3711140cfb87fce8f7a13f7cd860df041e6c12f7610f40cac6ec6fa2b65e96e4"
+SRC_URI[main.sha256sum] = "a81a4ba593d0015e10c51e267de3ff07c7ac914dfca037d9517d029517097795"
diff --git a/recipes-devtools/go/go-binary-native_1.25.2.bb b/recipes-devtools/go/go-binary-native_1.25.3.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.25.2.bb
rename to recipes-devtools/go/go-binary-native_1.25.3.bb
index 2e5abbe..3f939ca 100644
--- a/recipes-devtools/go/go-binary-native_1.25.2.bb
+++ b/recipes-devtools/go/go-binary-native_1.25.3.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "d7fa7f8fbd16263aa2501d681b11f972a5fd8e811f7b10cb9b26d031a3d7454b"
-SRC_URI[go_linux_arm64.sha256sum] = "9aaeb044bf8dbf50ca2fbf0edc5ebc98b90d5bda8c6b2911526df76f61232919"
-SRC_URI[go_linux_ppc64le.sha256sum] = "91dd35ac3f33baa642d9bac22b626bdb5ee0372cf80e7d782994337f81f34417"
+SRC_URI[go_linux_amd64.sha256sum] = "0335f314b6e7bfe08c3d0cfaa7c19db961b7b99fb20be62b0a826c992ad14e0f"
+SRC_URI[go_linux_arm64.sha256sum] = "1d42ebc84999b5e2069f5e31b67d6fc5d67308adad3e178d5a2ee2c9ff2001f5"
+SRC_URI[go_linux_ppc64le.sha256sum] = "68d1a08bf3567f330717d821b266a0be1c5080bd05dc238b5a43a24ca0c47d7c"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.25.2.bb b/recipes-devtools/go/go-cross-canadian_1.25.3.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.25.2.bb
rename to recipes-devtools/go/go-cross-canadian_1.25.3.bb
diff --git a/recipes-devtools/go/go-cross_1.25.2.bb b/recipes-devtools/go/go-cross_1.25.3.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.25.2.bb
rename to recipes-devtools/go/go-cross_1.25.3.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.25.2.bb b/recipes-devtools/go/go-crosssdk_1.25.3.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.25.2.bb
rename to recipes-devtools/go/go-crosssdk_1.25.3.bb
diff --git a/recipes-devtools/go/go-runtime_1.25.2.bb b/recipes-devtools/go/go-runtime_1.25.3.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.25.2.bb
rename to recipes-devtools/go/go-runtime_1.25.3.bb
diff --git a/recipes-devtools/go/go_1.25.2.bb b/recipes-devtools/go/go_1.25.3.bb
similarity index 100%
rename from recipes-devtools/go/go_1.25.2.bb
rename to recipes-devtools/go/go_1.25.3.bb

