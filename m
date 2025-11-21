Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB36CFA74E
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 08:35:44 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7564.1763714139422675369
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Nov 2025 00:35:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=DbbFS7//;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-256628-20251121083535ba196a3017000207c6-ccczxn@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20251121083535ba196a3017000207c6
        for <yocto-patches@lists.yoctoproject.org>;
        Fri, 21 Nov 2025 09:35:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xV3IVoZXQAtXyV4JsV3cUdhLRK8DsV8NSC9JsAK5lww=;
 b=DbbFS7//ewA14t3SqK1ZLH3wTkrFTttXzH8ihOETdTBeCSOwEID+p5PA+aPAcrN+lcgy8T
 dYlu9PgXYJhcnGY85IXlH87PPceIRbOWO77KXtdIO8tYk4qym9btHCaqwimMtAGsTMhMxWCK
 WUGGDcrWWWWDC5XmJDzJpmm+5Io/KEon4OjtSxmfCCxU00QsSCXhRj9HvkOrXZIOQhr4XOHL
 Usng116DTK3ot07Bq2pV3xkg3BZTtqM84oD52Nps4sCMPX0Lkyyi4WSzRaz+k09avBE21Im5
 Wts0KtmsW9aX1wbI00041wxODF3ydP6n+Xzk7knfuwsSUT7c93QQK3ew==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.25.3 -> 1.25.4
Date: Fri, 21 Nov 2025 09:35:31 +0100
Message-Id: <20251121083531.864699-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 08:35:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2642

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.25.x release [1]:

$ git --no-pager log --oneline go1.25.3..go1.25.4
f2cd93aa05 (tag: go1.25.4) [release-branch.go1.25] go1.25.4
83885f3c22 [release-branch.go1.25] encoding/pem: properly calculate end indexes
5ba37a3677 [release-branch.go1.25] cmd/compile: don't optimize away a panicing interface comparison
8097b1915f [release-branch.go1.25] os: support deleting read-only files in RemoveAll on older Windows versions
4942c74d04 [release-branch.go1.25] Revert "crypto/internal/fips140/subtle: add assembly implementation of xorBytes for mips64x"
cd21a7b31b [release-branch.go1.25] Revert "crypto/internal/fips140/subtle: add assembly implementation of xorBytes for mipsx"
bf95b76739 [release-branch.go1.25] runtime: use one more address bit for tagged pointers
bbb7627123 [release-branch.go1.25] cmd/compile: prevent shapifying of pointer shape type
7e049e5c31 [release-branch.go1.25] encoding/pem: properly decode strange PEM data
f6db7350e1 [release-branch.go1.25] net/url: allow IP-literals with IPv4-mapped IPv6 addresses

Release information: [2]

[1] https://github.com/golang/go/compare/go1.25.3...go1.25.4
[2] https://groups.google.com/g/golang-announce/c/tVVHm9gnwl8

(From OE-Core rev: 116d7fc8dd940c781d5ee0801d3ddfb79a82d357)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.25.3.inc => go-1.25.4.inc}        | 2 +-
 ...o-binary-native_1.25.3.bb => go-binary-native_1.25.4.bb} | 6 +++---
 ...cross-canadian_1.25.3.bb => go-cross-canadian_1.25.4.bb} | 0
 .../go/{go-cross_1.25.3.bb => go-cross_1.25.4.bb}           | 0
 .../go/{go-crosssdk_1.25.3.bb => go-crosssdk_1.25.4.bb}     | 0
 .../go/{go-runtime_1.25.3.bb => go-runtime_1.25.4.bb}       | 0
 recipes-devtools/go/{go_1.25.3.bb => go_1.25.4.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.25.3.inc => go-1.25.4.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.25.3.bb => go-binary-native_1.25.4.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.25.3.bb => go-cross-canadian_1.25.4.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.25.3.bb => go-cross_1.25.4.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.25.3.bb => go-crosssdk_1.25.4.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.25.3.bb => go-runtime_1.25.4.bb} (100%)
 rename recipes-devtools/go/{go_1.25.3.bb => go_1.25.4.bb} (100%)

diff --git a/recipes-devtools/go/go-1.25.3.inc b/recipes-devtools/go/go-1.25.4.inc
similarity index 91%
rename from recipes-devtools/go/go-1.25.3.inc
rename to recipes-devtools/go/go-1.25.4.inc
index c29f4d6..f88d7fe 100644
--- a/recipes-devtools/go/go-1.25.3.inc
+++ b/recipes-devtools/go/go-1.25.4.inc
@@ -18,4 +18,4 @@ SRC_URI += "\
     file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch \
     file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch \
 "
-SRC_URI[main.sha256sum] = "a81a4ba593d0015e10c51e267de3ff07c7ac914dfca037d9517d029517097795"
+SRC_URI[main.sha256sum] = "160043b7f17b6d60b50369436917fda8d5034640ba39ae2431c6b95a889cc98c"
diff --git a/recipes-devtools/go/go-binary-native_1.25.3.bb b/recipes-devtools/go/go-binary-native_1.25.4.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.25.3.bb
rename to recipes-devtools/go/go-binary-native_1.25.4.bb
index 79a0f5c..997c4bd 100644
--- a/recipes-devtools/go/go-binary-native_1.25.3.bb
+++ b/recipes-devtools/go/go-binary-native_1.25.4.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "0335f314b6e7bfe08c3d0cfaa7c19db961b7b99fb20be62b0a826c992ad14e0f"
-SRC_URI[go_linux_arm64.sha256sum] = "1d42ebc84999b5e2069f5e31b67d6fc5d67308adad3e178d5a2ee2c9ff2001f5"
-SRC_URI[go_linux_ppc64le.sha256sum] = "68d1a08bf3567f330717d821b266a0be1c5080bd05dc238b5a43a24ca0c47d7c"
+SRC_URI[go_linux_amd64.sha256sum] = "9fa5ffeda4170de60f67f3aa0f824e426421ba724c21e133c1e35d6159ca1bec"
+SRC_URI[go_linux_arm64.sha256sum] = "a68e86d4b72c2c2fecf7dfed667680b6c2a071221bbdb6913cf83ce3f80d9ff0"
+SRC_URI[go_linux_ppc64le.sha256sum] = "38c8ac8463537c99fbc1ef368f243b626144446c09db71b1d20634a4237c966d"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.25.3.bb b/recipes-devtools/go/go-cross-canadian_1.25.4.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.25.3.bb
rename to recipes-devtools/go/go-cross-canadian_1.25.4.bb
diff --git a/recipes-devtools/go/go-cross_1.25.3.bb b/recipes-devtools/go/go-cross_1.25.4.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.25.3.bb
rename to recipes-devtools/go/go-cross_1.25.4.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.25.3.bb b/recipes-devtools/go/go-crosssdk_1.25.4.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.25.3.bb
rename to recipes-devtools/go/go-crosssdk_1.25.4.bb
diff --git a/recipes-devtools/go/go-runtime_1.25.3.bb b/recipes-devtools/go/go-runtime_1.25.4.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.25.3.bb
rename to recipes-devtools/go/go-runtime_1.25.4.bb
diff --git a/recipes-devtools/go/go_1.25.3.bb b/recipes-devtools/go/go_1.25.4.bb
similarity index 100%
rename from recipes-devtools/go/go_1.25.3.bb
rename to recipes-devtools/go/go_1.25.4.bb

