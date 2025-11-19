Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496BCCF3951
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9148.1763564757192064944
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=S73+afJa;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20251119150555f47a2e2fcc00020797-apyuzh@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251119150555f47a2e2fcc00020797
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2/qIuCbkRN7YIghOb4XIkLTKLcupCpIG2YZCkqmy6ho=;
 b=S73+afJa0c7c0C1509zdfF4HzCmQpNTqrYeAvcUfQfuQy7HfKbwiGi/0javXjK0VcCwguQ
 tXN6VsQuYtgTyZ3RYl/yD3I4x57bFgubBW/l3XTi250p/tVg1vVzCsumUiIeRopNi7EGBWEJ
 Oh5NZ9UMMjEmTBZOuE2RSFK3ZSZ1w24alFpU08NObgfsym/lemIkAxROD75a+ZsV+YvdKo62
 v1ZBHpzPLJg8TTsncZ3rYRnToib0Xq5jX6omr5CMiIx1LtHTEGGdV7IDjrTratCn+v05eefC
 jyeP177SzXzcsi+AbovFowO4LiImgNUsnXl2XWfPS0czacxYnPt0cHSQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 20/35] go: upgrade 1.24.3 -> 1.24.4
Date: Wed, 19 Nov 2025 16:05:07 +0100
Message-Id: <20251119150522.15477-21-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2605

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.24.x release [1]:

$ git --no-pager log --oneline go1.24.3..go1.24.4
6796ebb2cb [release-branch.go1.24] go1.24.4
85897ca220 [release-branch.go1.24] net/http: strip sensitive proxy headers from redirect requests
9f9cf28f8f [release-branch.go1.24] os: don't follow symlinks on Windows when O_CREATE|O_EXCL
a31c931adf [release-branch.go1.24] cmd/link: allow linkname reference to a TEXT symbol regardless of size
03811ab1b3 [release-branch.go1.24] crypto/x509: decouple key usage and policy validation
04a9473847 [release-branch.go1.24] lib/fips140: set inprocess.txt to v1.0.0
db8f1dc948 [release-branch.go1.24] hash/maphash: hash channels in purego version of maphash.Comparable
664cf832ec [release-branch.go1.24] runtime/debug: document DefaultGODEBUG as a BuildSetting
431f75a0b9 [release-branch.go1.24] os: fix Root.Mkdir permission bits on OpenBSD

Fixes CVE-2025-4673, CVE-2025-0913 and CVE-2025-22874 [2].

[1] https://github.com/golang/go/compare/go1.24.3...go1.24.4
[2] https://groups.google.com/g/golang-announce/c/ufZ8WpEsA3A

(From OE-Core rev: 25aed3ec02c22857380957783e2926bf3368398c)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.24.3.inc => go-1.24.4.inc}        | 2 +-
 ...o-binary-native_1.24.3.bb => go-binary-native_1.24.4.bb} | 6 +++---
 ...cross-canadian_1.24.3.bb => go-cross-canadian_1.24.4.bb} | 0
 .../go/{go-cross_1.24.3.bb => go-cross_1.24.4.bb}           | 0
 .../go/{go-crosssdk_1.24.3.bb => go-crosssdk_1.24.4.bb}     | 0
 .../go/{go-runtime_1.24.3.bb => go-runtime_1.24.4.bb}       | 0
 recipes-devtools/go/{go_1.24.3.bb => go_1.24.4.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.24.3.inc => go-1.24.4.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.24.3.bb => go-binary-native_1.24.4.bb} (78%)
 rename recipes-devtools/go/{go-cross-canadian_1.24.3.bb => go-cross-canadian_1.24.4.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.24.3.bb => go-cross_1.24.4.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.24.3.bb => go-crosssdk_1.24.4.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.24.3.bb => go-runtime_1.24.4.bb} (100%)
 rename recipes-devtools/go/{go_1.24.3.bb => go_1.24.4.bb} (100%)

diff --git a/recipes-devtools/go/go-1.24.3.inc b/recipes-devtools/go/go-1.24.4.inc
similarity index 91%
rename from recipes-devtools/go/go-1.24.3.inc
rename to recipes-devtools/go/go-1.24.4.inc
index 78e2614..eff3f2f 100644
--- a/recipes-devtools/go/go-1.24.3.inc
+++ b/recipes-devtools/go/go-1.24.4.inc
@@ -17,4 +17,4 @@ SRC_URI += "\
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
 "
-SRC_URI[main.sha256sum] = "229c08b600b1446798109fae1f569228102c8473caba8104b6418cb5bc032878"
+SRC_URI[main.sha256sum] = "5a86a83a31f9fa81490b8c5420ac384fd3d95a3e71fba665c7b3f95d1dfef2b4"
diff --git a/recipes-devtools/go/go-binary-native_1.24.3.bb b/recipes-devtools/go/go-binary-native_1.24.4.bb
similarity index 78%
rename from recipes-devtools/go/go-binary-native_1.24.3.bb
rename to recipes-devtools/go/go-binary-native_1.24.4.bb
index af56dc9..9f78853 100644
--- a/recipes-devtools/go/go-binary-native_1.24.3.bb
+++ b/recipes-devtools/go/go-binary-native_1.24.4.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "3333f6ea53afa971e9078895eaa4ac7204a8c6b5c68c10e6bc9a33e8e391bdd8"
-SRC_URI[go_linux_arm64.sha256sum] = "a463cb59382bd7ae7d8f4c68846e73c4d589f223c589ac76871b66811ded7836"
-SRC_URI[go_linux_ppc64le.sha256sum] = "341a749d168f47b1d4dad25e32cae70849b7ceed7c290823b853c9e6b0df0856"
+SRC_URI[go_linux_amd64.sha256sum] = "77e5da33bb72aeaef1ba4418b6fe511bc4d041873cbf82e5aa6318740df98717"
+SRC_URI[go_linux_arm64.sha256sum] = "d5501ee5aca0f258d5fe9bfaed401958445014495dc115f202d43d5210b45241"
+SRC_URI[go_linux_ppc64le.sha256sum] = "9ca4afef813a2578c23843b640ae0290aa54b2e3c950a6cc4c99e16a57dec2ec"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.24.3.bb b/recipes-devtools/go/go-cross-canadian_1.24.4.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.24.3.bb
rename to recipes-devtools/go/go-cross-canadian_1.24.4.bb
diff --git a/recipes-devtools/go/go-cross_1.24.3.bb b/recipes-devtools/go/go-cross_1.24.4.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.24.3.bb
rename to recipes-devtools/go/go-cross_1.24.4.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.24.3.bb b/recipes-devtools/go/go-crosssdk_1.24.4.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.24.3.bb
rename to recipes-devtools/go/go-crosssdk_1.24.4.bb
diff --git a/recipes-devtools/go/go-runtime_1.24.3.bb b/recipes-devtools/go/go-runtime_1.24.4.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.24.3.bb
rename to recipes-devtools/go/go-runtime_1.24.4.bb
diff --git a/recipes-devtools/go/go_1.24.3.bb b/recipes-devtools/go/go_1.24.4.bb
similarity index 100%
rename from recipes-devtools/go/go_1.24.3.bb
rename to recipes-devtools/go/go_1.24.4.bb

