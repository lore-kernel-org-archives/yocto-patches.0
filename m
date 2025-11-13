Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7444FCD6E71
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23129.1763038637282339971
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=VynLHWl+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-202511131257153f68e32fa200020787-btyv06@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202511131257153f68e32fa200020787
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vvSRKHqCLK/ZXE2/D4rFCn07U3v7U3fwcH8ztBQlPMI=;
 b=VynLHWl+vhvOJagxutf74jzYZv/zziI4eKq+yAONBtzNG15IIsGvfQsOcom5+4hRHlBOvx
 vuaM9FX/3CCpiubqorzvhMtfledpjlG0GEluTT+D5JjuHixcEYf9x3Jks4ryUsHGuGKc5wb6
 tOVhll0A9EHeieXJ/HToCImjvcQZnXPU+51dzPzGkdKYmD7WU9xrJL1rLc70XHXqCCN6+J7+
 vaw1XQDJJAmVTmf8hL4KtmINaQSYnQZh77YYDvmDXhWegPxilyPjoExox6XKJ7K9YJS1RLxC
 tRlyBCbcF7+sdubqDqocSpvx+nxOD+AsLaUDDfzPZPXBaHyVKpyldPWg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 19/34] go: upgrade 1.24.2 -> 1.24.3
Date: Thu, 13 Nov 2025 13:56:57 +0100
Message-Id: <20251113125712.18914-20-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2526

Upgrade to latest 1.24.x release [1]:

$ git --no-pager log --oneline go1.24.2..go1.24.3
34c8b14ca9 (release-branch.go1.24) [release-branch.go1.24] go1.24.3
8947f3395e [release-branch.go1.24] os: avoid escape from Root via paths ending in ../
06fd2f115b [release-branch.go1.24] cmd/compile: remove no-longer-necessary recursive inlining checks
f66ab6521c [release-branch.go1.24] cmd/internal/obj/wasm: use i64 for large return addr
c1f9c2c7b0 [release-branch.go1.24] cmd/go/internal/load: join incompatible and dirty build specifiers with .
0ab64e2caa [release-branch.go1.24] runtime: cleanup M vgetrandom state before dropping P
56eb99859d [release-branch.go1.24] internal/runtime/maps: pass proper func PC to race.WritePC/race.ReadPC
43130aff52 [release-branch.go1.24] runtime: fix 9-arg syscall on darwin/amd64
b2c005e7b2 [release-branch.go1.24] crypto/tls: fix ECH compatibility
a9d9b55709 [release-branch.go1.24] cmd/link: choose one with larger size for duplicated BSS symbols
fa7217f74d [release-branch.go1.24] os: avoid panic in Root when symlink references the root

Fixes CVE-2025-22873

[1] https://github.com/golang/go/compare/go1.24.2...go1.24.3

(From OE-Core rev: b317570acf1e25a4cfaa0c66a2630d082b4d0bae)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.24.2.inc => go-1.24.3.inc}        | 2 +-
 ...o-binary-native_1.24.2.bb => go-binary-native_1.24.3.bb} | 6 +++---
 ...cross-canadian_1.24.2.bb => go-cross-canadian_1.24.3.bb} | 0
 .../go/{go-cross_1.24.2.bb => go-cross_1.24.3.bb}           | 0
 .../go/{go-crosssdk_1.24.2.bb => go-crosssdk_1.24.3.bb}     | 0
 .../go/{go-runtime_1.24.2.bb => go-runtime_1.24.3.bb}       | 0
 recipes-devtools/go/{go_1.24.2.bb => go_1.24.3.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.24.2.inc => go-1.24.3.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.24.2.bb => go-binary-native_1.24.3.bb} (78%)
 rename recipes-devtools/go/{go-cross-canadian_1.24.2.bb => go-cross-canadian_1.24.3.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.24.2.bb => go-cross_1.24.3.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.24.2.bb => go-crosssdk_1.24.3.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.24.2.bb => go-runtime_1.24.3.bb} (100%)
 rename recipes-devtools/go/{go_1.24.2.bb => go_1.24.3.bb} (100%)

diff --git a/recipes-devtools/go/go-1.24.2.inc b/recipes-devtools/go/go-1.24.3.inc
similarity index 91%
rename from recipes-devtools/go/go-1.24.2.inc
rename to recipes-devtools/go/go-1.24.3.inc
index cb4ae9e..78e2614 100644
--- a/recipes-devtools/go/go-1.24.2.inc
+++ b/recipes-devtools/go/go-1.24.3.inc
@@ -17,4 +17,4 @@ SRC_URI += "\
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
 "
-SRC_URI[main.sha256sum] = "9dc77ffadc16d837a1bf32d99c624cb4df0647cee7b119edd9e7b1bcc05f2e00"
+SRC_URI[main.sha256sum] = "229c08b600b1446798109fae1f569228102c8473caba8104b6418cb5bc032878"
diff --git a/recipes-devtools/go/go-binary-native_1.24.2.bb b/recipes-devtools/go/go-binary-native_1.24.3.bb
similarity index 78%
rename from recipes-devtools/go/go-binary-native_1.24.2.bb
rename to recipes-devtools/go/go-binary-native_1.24.3.bb
index 690b854..af56dc9 100644
--- a/recipes-devtools/go/go-binary-native_1.24.2.bb
+++ b/recipes-devtools/go/go-binary-native_1.24.3.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "68097bd680839cbc9d464a0edce4f7c333975e27a90246890e9f1078c7e702ad"
-SRC_URI[go_linux_arm64.sha256sum] = "756274ea4b68fa5535eb9fe2559889287d725a8da63c6aae4d5f23778c229f4b"
-SRC_URI[go_linux_ppc64le.sha256sum] = "5fff857791d541c71d8ea0171c73f6f99770d15ff7e2ad979104856d01f36563"
+SRC_URI[go_linux_amd64.sha256sum] = "3333f6ea53afa971e9078895eaa4ac7204a8c6b5c68c10e6bc9a33e8e391bdd8"
+SRC_URI[go_linux_arm64.sha256sum] = "a463cb59382bd7ae7d8f4c68846e73c4d589f223c589ac76871b66811ded7836"
+SRC_URI[go_linux_ppc64le.sha256sum] = "341a749d168f47b1d4dad25e32cae70849b7ceed7c290823b853c9e6b0df0856"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.24.2.bb b/recipes-devtools/go/go-cross-canadian_1.24.3.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.24.2.bb
rename to recipes-devtools/go/go-cross-canadian_1.24.3.bb
diff --git a/recipes-devtools/go/go-cross_1.24.2.bb b/recipes-devtools/go/go-cross_1.24.3.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.24.2.bb
rename to recipes-devtools/go/go-cross_1.24.3.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.24.2.bb b/recipes-devtools/go/go-crosssdk_1.24.3.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.24.2.bb
rename to recipes-devtools/go/go-crosssdk_1.24.3.bb
diff --git a/recipes-devtools/go/go-runtime_1.24.2.bb b/recipes-devtools/go/go-runtime_1.24.3.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.24.2.bb
rename to recipes-devtools/go/go-runtime_1.24.3.bb
diff --git a/recipes-devtools/go/go_1.24.2.bb b/recipes-devtools/go/go_1.24.3.bb
similarity index 100%
rename from recipes-devtools/go/go_1.24.2.bb
rename to recipes-devtools/go/go_1.24.3.bb

