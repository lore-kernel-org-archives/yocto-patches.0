Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7875ECF3959
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9157.1763564757518852636
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=ZP6jhIgf;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-20251119150555c9d8145b9a00020734-y_4pod@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251119150555c9d8145b9a00020734
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CajeAvwnZ1HESoifoemtQaKGc23Mjsqs5LkOE4Vbksg=;
 b=ZP6jhIgf9OLgihe+ockRPOSK4sz6uQREWIpPxIqjAAU2DqW3fSuCMtx6C+ZIoAZhY260zT
 +kqwNJJ2NP/0/Pcibx/5Y2yyUQfElTldGWs7TSA6ZN5E6nHpj5TD5EGbFfDfmXSAotD/3SdV
 lXcU5j5byux1BBxYZxGLgAXUm+PO5jTUUoRN+Ebgy2kNDOey32ooioCZWTzCVgcJ8fzj03yW
 5emh6SvPU0HaZqX0X3DhckukyiMtFqjohkfQDZ3/u2Y/3nGJcBD7Tp/Q7v3echKSO2L19K54
 9/hoRbqvkUA03B+z+DhYOAA1cFQkqoH8LCffVbICeQzAYtZRDM0DGnKA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 18/35] go: upgrade 1.24.1 -> 1.24.2
Date: Wed, 19 Nov 2025 16:05:05 +0100
Message-Id: <20251119150522.15477-19-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2609

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.24.x release [1]:

$ git --no-pager log --oneline go1.24.0..go1.24.1
339c903a75 (tag: go1.24.1) [release-branch.go1.24] go1.24.1
334de7982f [release-branch.go1.24] all: updated vendored x/net with security fix
5d6920842b [release-branch.go1.24] runtime/cgo: avoid errors from -Wdeclaration-after-statement
949eae84df [release-branch.go1.24] cmd/compile: don't pull constant offsets out of pointer arithmetic
0bfde51e0d [release-branch.go1.24] runtime: document that cleanups can run concurrently with each other
45a52718e3 [release-branch.go1.24] runtime/cgo: avoid errors from -Wdeclaration-after-statement
7f375e2c22 [release-branch.go1.24] reflect: let Value.Seq return the iteration value correct type
4070531920 [release-branch.go1.24] syscall: disable O_DIRECTORY on Windows for js/wasm
5ffdb9c88b [release-branch.go1.24] reflect: correctly handle method values in Seq
becc17ebcd [release-branch.go1.24] runtime: use WCLONE when waiting on pidfd test child
d418e224ae [release-branch.go1.24] syscall: don't send child signal when testing pidfd
456eaf5c29 [release-branch.go1.24] cmd/compile: don't report newLimit discovered when unsat happens multiple times
e4ef83383e [release-branch.go1.24] debug/buildinfo: base64-encode test binaries
4e6d3468cc [release-branch.go1.24] cmd/compile: ensure we don't reuse temporary register
f5c388313f [release-branch.go1.24] internal/godebugs: add fips140 as an opaque godebug setting
af236716b2 [release-branch.go1.24] cmd/compile, runtime: use deferreturn as target PC for recover from deferrangefunc
0f7b7600fb [release-branch.go1.24] doc/godebug: mention GODEBUG=fips140
eb58df7dbf [release-branch.go1.24] cmd/compile: avoid infinite recursion when inlining closures
30f4d9e117 [release-branch.go1.24] syscall: don't truncate newly created files on Windows
bb0e5c2045 [release-branch.go1.24] runtime: fix usleep on s390x/linux
cd0e528d3d [release-branch.go1.24] runtime: add some linknames back for `github.com/bytedance/sonic`
80e2e474b8 [release-branch.go1.24] cmd/go: initialize req.Header when loading git credential

Fixes CVE-2025-22871

[1] https://github.com/golang/go/compare/go1.24.1...go1.24.2

(From OE-Core rev: c83927d94bc0afe2205324a976e9495d6df00caf)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.24.1.inc => go-1.24.2.inc}        | 2 +-
 ...o-binary-native_1.24.1.bb => go-binary-native_1.24.2.bb} | 6 +++---
 ...cross-canadian_1.24.1.bb => go-cross-canadian_1.24.2.bb} | 0
 .../go/{go-cross_1.24.1.bb => go-cross_1.24.2.bb}           | 0
 .../go/{go-crosssdk_1.24.1.bb => go-crosssdk_1.24.2.bb}     | 0
 .../go/{go-runtime_1.24.1.bb => go-runtime_1.24.2.bb}       | 0
 recipes-devtools/go/{go_1.24.1.bb => go_1.24.2.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.24.1.inc => go-1.24.2.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.24.1.bb => go-binary-native_1.24.2.bb} (78%)
 rename recipes-devtools/go/{go-cross-canadian_1.24.1.bb => go-cross-canadian_1.24.2.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.24.1.bb => go-cross_1.24.2.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.24.1.bb => go-crosssdk_1.24.2.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.24.1.bb => go-runtime_1.24.2.bb} (100%)
 rename recipes-devtools/go/{go_1.24.1.bb => go_1.24.2.bb} (100%)

diff --git a/recipes-devtools/go/go-1.24.1.inc b/recipes-devtools/go/go-1.24.2.inc
similarity index 91%
rename from recipes-devtools/go/go-1.24.1.inc
rename to recipes-devtools/go/go-1.24.2.inc
index 4cf66e7..cb4ae9e 100644
--- a/recipes-devtools/go/go-1.24.1.inc
+++ b/recipes-devtools/go/go-1.24.2.inc
@@ -17,4 +17,4 @@ SRC_URI += "\
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
 "
-SRC_URI[main.sha256sum] = "8244ebf46c65607db10222b5806aeb31c1fcf8979c1b6b12f60c677e9a3c0656"
+SRC_URI[main.sha256sum] = "9dc77ffadc16d837a1bf32d99c624cb4df0647cee7b119edd9e7b1bcc05f2e00"
diff --git a/recipes-devtools/go/go-binary-native_1.24.1.bb b/recipes-devtools/go/go-binary-native_1.24.2.bb
similarity index 78%
rename from recipes-devtools/go/go-binary-native_1.24.1.bb
rename to recipes-devtools/go/go-binary-native_1.24.2.bb
index ffe3d50..690b854 100644
--- a/recipes-devtools/go/go-binary-native_1.24.1.bb
+++ b/recipes-devtools/go/go-binary-native_1.24.2.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "cb2396bae64183cdccf81a9a6df0aea3bce9511fc21469fb89a0c00470088073"
-SRC_URI[go_linux_arm64.sha256sum] = "8df5750ffc0281017fb6070fba450f5d22b600a02081dceef47966ffaf36a3af"
-SRC_URI[go_linux_ppc64le.sha256sum] = "0fb522efcefabae6e37e69bdc444094e75bfe824ea6d4cc3cbc70c7ae1b16858"
+SRC_URI[go_linux_amd64.sha256sum] = "68097bd680839cbc9d464a0edce4f7c333975e27a90246890e9f1078c7e702ad"
+SRC_URI[go_linux_arm64.sha256sum] = "756274ea4b68fa5535eb9fe2559889287d725a8da63c6aae4d5f23778c229f4b"
+SRC_URI[go_linux_ppc64le.sha256sum] = "5fff857791d541c71d8ea0171c73f6f99770d15ff7e2ad979104856d01f36563"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.24.1.bb b/recipes-devtools/go/go-cross-canadian_1.24.2.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.24.1.bb
rename to recipes-devtools/go/go-cross-canadian_1.24.2.bb
diff --git a/recipes-devtools/go/go-cross_1.24.1.bb b/recipes-devtools/go/go-cross_1.24.2.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.24.1.bb
rename to recipes-devtools/go/go-cross_1.24.2.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.24.1.bb b/recipes-devtools/go/go-crosssdk_1.24.2.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.24.1.bb
rename to recipes-devtools/go/go-crosssdk_1.24.2.bb
diff --git a/recipes-devtools/go/go-runtime_1.24.1.bb b/recipes-devtools/go/go-runtime_1.24.2.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.24.1.bb
rename to recipes-devtools/go/go-runtime_1.24.2.bb
diff --git a/recipes-devtools/go/go_1.24.1.bb b/recipes-devtools/go/go_1.24.2.bb
similarity index 100%
rename from recipes-devtools/go/go_1.24.1.bb
rename to recipes-devtools/go/go_1.24.2.bb

