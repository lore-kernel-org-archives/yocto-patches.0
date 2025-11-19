Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6720FCF3957
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9149.1763564757396547010
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=TAts58kG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-20251119150555158840761c000207dd-vnvpqi@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251119150555158840761c000207dd
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pk5vWdT1BZJvyk4CabL1vY/nx1rPe73oIqhZQEqR4A0=;
 b=TAts58kGDPR/XA6xOXqM4j6oD0a2OGfGlqKI9u3YI/6Bd+kIqu/kQM7E+ZCLtFf2+IlwDV
 Vz2DNigCzbmInqOEGDpd8seNWKq7dDOxMoQUzE/agdOz+Ru71NLcFZk7CIMkTCXR7JK8IVa1
 RIigpg9231L5Z9qa1flDS4gX1ek6IMA+Sc+ntP97x9Iqsrf4YSMFX2bNO2+Luzjj7roX3wqR
 GsB0FAhjPoB2E8fZ7pNMY8S+jg5xS1SfjEO1Eeke4+rvthO0lCssQcQeUSz3nAZukVgZiWbl
 xX/e6TigwYkj76ndqd9UHOa1MXuGcYhUxOePxMfxdB+RItNsVtDI0yHQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 23/35] go: upgrade 1.24.4 -> 1.24.5
Date: Wed, 19 Nov 2025 16:05:10 +0100
Message-Id: <20251119150522.15477-24-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2608

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.24.x release [1]:

$ git --no-pager log --oneline go1.24.4..go1.24.5
9d828e80fa (tag: go1.24.5) [release-branch.go1.24] go1.24.5
825eeee3f7 [release-branch.go1.24] cmd/go: disable support for multiple vcs in one module
dbf30d88f3 [release-branch.go1.24] cmd/link: permit a larger size BSS reference to a smaller DATA symbol
6b51660c8c [release-branch.go1.24] runtime: set mspan limit field early and eagerly
cc604130c8 [release-branch.go1.24] runtime: prevent mutual deadlock between GC stopTheWorld and suspendG
21b488bb60 [release-branch.go1.24] runtime: handle system goroutines later in goroutine profiling
e038690847 [release-branch.go1.24] cmd/go/internal/fips140: ignore GOEXPERIMENT on error
1575127ef8 [release-branch.go1.24] runtime: add missing unlock in sysReserveAlignedSbrk
7d08a16fba [release-branch.go1.24] cmd/compile/internal/ssa: fix PPC64 merging of (AND (S[RL]Dconst ...)
5f2cbe1f64 [release-branch.go1.24] cmd/compile: do nil check before calling duff functions, on arm64 and amd64

Fixes CVE-2025-4674 [2].

[1] https://github.com/golang/go/compare/go1.24.4...go1.24.5
[2] https://groups.google.com/g/golang-announce/c/gTNJnDXmn34

(From OE-Core rev: a3cc5038ea10a4857627e6f4de25bdc43023a349)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.24.4.inc => go-1.24.5.inc}        | 2 +-
 ...o-binary-native_1.24.4.bb => go-binary-native_1.24.5.bb} | 6 +++---
 ...cross-canadian_1.24.4.bb => go-cross-canadian_1.24.5.bb} | 0
 .../go/{go-cross_1.24.4.bb => go-cross_1.24.5.bb}           | 0
 .../go/{go-crosssdk_1.24.4.bb => go-crosssdk_1.24.5.bb}     | 0
 .../go/{go-runtime_1.24.4.bb => go-runtime_1.24.5.bb}       | 0
 recipes-devtools/go/{go_1.24.4.bb => go_1.24.5.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.24.4.inc => go-1.24.5.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.24.4.bb => go-binary-native_1.24.5.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.24.4.bb => go-cross-canadian_1.24.5.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.24.4.bb => go-cross_1.24.5.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.24.4.bb => go-crosssdk_1.24.5.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.24.4.bb => go-runtime_1.24.5.bb} (100%)
 rename recipes-devtools/go/{go_1.24.4.bb => go_1.24.5.bb} (100%)

diff --git a/recipes-devtools/go/go-1.24.4.inc b/recipes-devtools/go/go-1.24.5.inc
similarity index 91%
rename from recipes-devtools/go/go-1.24.4.inc
rename to recipes-devtools/go/go-1.24.5.inc
index eff3f2f..fae0d3f 100644
--- a/recipes-devtools/go/go-1.24.4.inc
+++ b/recipes-devtools/go/go-1.24.5.inc
@@ -17,4 +17,4 @@ SRC_URI += "\
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
 "
-SRC_URI[main.sha256sum] = "5a86a83a31f9fa81490b8c5420ac384fd3d95a3e71fba665c7b3f95d1dfef2b4"
+SRC_URI[main.sha256sum] = "74fdb09f2352e2b25b7943e56836c9b47363d28dec1c8b56c4a9570f30b8f59f"
diff --git a/recipes-devtools/go/go-binary-native_1.24.4.bb b/recipes-devtools/go/go-binary-native_1.24.5.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.24.4.bb
rename to recipes-devtools/go/go-binary-native_1.24.5.bb
index a5324d0..3de6306 100644
--- a/recipes-devtools/go/go-binary-native_1.24.4.bb
+++ b/recipes-devtools/go/go-binary-native_1.24.5.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "77e5da33bb72aeaef1ba4418b6fe511bc4d041873cbf82e5aa6318740df98717"
-SRC_URI[go_linux_arm64.sha256sum] = "d5501ee5aca0f258d5fe9bfaed401958445014495dc115f202d43d5210b45241"
-SRC_URI[go_linux_ppc64le.sha256sum] = "9ca4afef813a2578c23843b640ae0290aa54b2e3c950a6cc4c99e16a57dec2ec"
+SRC_URI[go_linux_amd64.sha256sum] = "10ad9e86233e74c0f6590fe5426895de6bf388964210eac34a6d83f38918ecdc"
+SRC_URI[go_linux_arm64.sha256sum] = "0df02e6aeb3d3c06c95ff201d575907c736d6c62cfa4b6934c11203f1d600ffa"
+SRC_URI[go_linux_ppc64le.sha256sum] = "00bdfb16d1094e78473b681d2d09d42c19c886d4dfed743853769f1665c7a552"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.24.4.bb b/recipes-devtools/go/go-cross-canadian_1.24.5.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.24.4.bb
rename to recipes-devtools/go/go-cross-canadian_1.24.5.bb
diff --git a/recipes-devtools/go/go-cross_1.24.4.bb b/recipes-devtools/go/go-cross_1.24.5.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.24.4.bb
rename to recipes-devtools/go/go-cross_1.24.5.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.24.4.bb b/recipes-devtools/go/go-crosssdk_1.24.5.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.24.4.bb
rename to recipes-devtools/go/go-crosssdk_1.24.5.bb
diff --git a/recipes-devtools/go/go-runtime_1.24.4.bb b/recipes-devtools/go/go-runtime_1.24.5.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.24.4.bb
rename to recipes-devtools/go/go-runtime_1.24.5.bb
diff --git a/recipes-devtools/go/go_1.24.4.bb b/recipes-devtools/go/go_1.24.5.bb
similarity index 100%
rename from recipes-devtools/go/go_1.24.4.bb
rename to recipes-devtools/go/go_1.24.5.bb

