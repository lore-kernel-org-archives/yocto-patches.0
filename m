Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F7DFD88CF
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 23:24:39 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8618.1773185071001841863
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 16:24:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=GoXjVIRi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20260310232429c2cc499e790002071c-g0cucy@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260310232429c2cc499e790002071c
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 11 Mar 2026 00:24:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=BpD6wGianTSfXKbXDN8xqQhyFdu4kf1Y39QhjALwp+8=;
 b=GoXjVIRixTbEOZE1jjf5xASG3s92D4JNVkyxRv6jZui1Nw8rmILtLykMwenQIahDo6c79F
 Q8PeytLdvE+HZ/r5VmKIIXNEWKTv1ZYgxLq+AK60EQEHqxHb1G7Bq2mOJ1J83CMjMaN/vRkZ
 zwmqZhi7gXYhw+ymVP3WQ9128hjFToadSWQDBtaR8TC3/lrx1W0rJv4ZD2uSHyvtsHf1SN/A
 4WiijN5ZamxcpT/CS3BUav/0DnCnVq1Hpawm8WmMG1DadvGeil7rCJyPyfZlrHN4ynGGCS3X
 qNn/2luuFj/itGKrECszHpybJpbgIrSL6Lln/4xMU0jEgc0xRMFgBWGg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.26.0 -> 1.26.1
Date: Wed, 11 Mar 2026 00:24:25 +0100
Message-Id: <20260310232425.1471790-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 23:24:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3399

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.26.x release [1]:

$ git --no-pager log --oneline go1.26.0..go1.26.1
e87b10ea2a (tag: go1.26.1) [release-branch.go1.26] go1.26.1
e792d6aa95 [release-branch.go1.26] crypto/x509: fix name constraint checking panic
a761c9ff70 [release-branch.go1.26] crypto/x509: fix full email constraint matching
994692847a [release-branch.go1.26] html/template: properly escape URLs in meta content attributes
65c7d7a9fb [release-branch.go1.26] net/url: reject IPv6 literal not at start of host
e28ac674af [release-branch.go1.26] cmd/go: revert update default go directive in mod or work init
4d1051fdc9 [release-branch.go1.26] cmd: re-vendor x/tools for Go 1.26.1
8cce3ab20c [release-branch.go1.26] os: avoid escape from Root via ReadDir or Readdir
ef041913a8 [release-branch.go1.26] cmd/compile: ensure StructMake/ArrayMake1 of direct interfaces are unwrapped
155c25e249 [release-branch.go1.26] cmd/compile: pointer-shaped types are SSAable even if lots of 0-sized fields
c5723195a6 [release-branch.go1.26] net/smtp: prevent test failures due to expired test certificate
f67a1f4c76 [release-branch.go1.26] cmd/go: fix pkg-config flag sanitization
4659d630da [release-branch.go1.26] cmd/compile: avoid folding 64-bit integers into 32-bit constants
6fb3df88d4 [release-branch.go1.26] go/analysis/passes/modernize: add vendored code
85050c90ee [release-branch.go1.26] cmd/compile: fix mis-compilation for static array initialization
12c0690eeb [release-branch.go1.26] cmd/compile: don't drop same register twice
e8df1a6697 [release-branch.go1.26] reflect: use &zeroVal[0] instead of nil for data field for zero-sized payloads
167ef716ba [release-branch.go1.26] cmd/compile: rewriteFixedLoad: ensure AuxInt is sign-extended
495e6c6b09 [release-branch.go1.26] internal/syscall/windows: correct some enums and syscall signatures
29618c4439 [release-branch.go1.26] cmd/link: don't pass -Wl,-S on illumos
c283d1f762 [release-branch.go1.26] os: support deleting inaccessible files in RemoveAll

Fixes CVE-2026-27137, CVE-2026-27138, CVE-2026-27142, CVE-2026-25679 and
      CVE-2026-27139.

Release information: [2]

[1] https://github.com/golang/go/compare/go1.26.0...go1.26.1
[2] https://groups.google.com/g/golang-announce/c/EdhZqrQ98hk

(From OE-Core rev: 124a43b74b7a8494dd13dac1294a237fb8a02e6c)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.26.0.inc => go-1.26.1.inc}        | 2 +-
 ...o-binary-native_1.26.0.bb => go-binary-native_1.26.1.bb} | 6 +++---
 ...cross-canadian_1.26.0.bb => go-cross-canadian_1.26.1.bb} | 0
 .../go/{go-cross_1.26.0.bb => go-cross_1.26.1.bb}           | 0
 .../go/{go-crosssdk_1.26.0.bb => go-crosssdk_1.26.1.bb}     | 0
 .../go/{go-runtime_1.26.0.bb => go-runtime_1.26.1.bb}       | 0
 recipes-devtools/go/{go_1.26.0.bb => go_1.26.1.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.26.0.inc => go-1.26.1.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.26.0.bb => go-binary-native_1.26.1.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.26.0.bb => go-cross-canadian_1.26.1.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.26.0.bb => go-cross_1.26.1.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.26.0.bb => go-crosssdk_1.26.1.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.26.0.bb => go-runtime_1.26.1.bb} (100%)
 rename recipes-devtools/go/{go_1.26.0.bb => go_1.26.1.bb} (100%)

diff --git a/recipes-devtools/go/go-1.26.0.inc b/recipes-devtools/go/go-1.26.1.inc
similarity index 91%
rename from recipes-devtools/go/go-1.26.0.inc
rename to recipes-devtools/go/go-1.26.1.inc
index 7d8a68e..2e3464e 100644
--- a/recipes-devtools/go/go-1.26.0.inc
+++ b/recipes-devtools/go/go-1.26.1.inc
@@ -17,4 +17,4 @@ SRC_URI += "\
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch \
 "
-SRC_URI[main.sha256sum] = "c9132a8a1f6bd2aa4aad1d74b8231d95274950483a4950657ee6c56e6e817790"
+SRC_URI[main.sha256sum] = "3172293d04b209dc1144698e7ba13f0477f6ba8c5ffd0be66c20fdbc9785dfbb"
diff --git a/recipes-devtools/go/go-binary-native_1.26.0.bb b/recipes-devtools/go/go-binary-native_1.26.1.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.26.0.bb
rename to recipes-devtools/go/go-binary-native_1.26.1.bb
index 9eb84fa..a21b415 100644
--- a/recipes-devtools/go/go-binary-native_1.26.0.bb
+++ b/recipes-devtools/go/go-binary-native_1.26.1.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "aac1b08a0fb0c4e0a7c1555beb7b59180b05dfc5a3d62e40e9de90cd42f88235"
-SRC_URI[go_linux_arm64.sha256sum] = "bd03b743eb6eb4193ea3c3fd3956546bf0e3ca5b7076c8226334afe6b75704cd"
-SRC_URI[go_linux_ppc64le.sha256sum] = "3066b2284b554da76cf664d217490792ba6f292ec0fc20bf9615e173cc0d2800"
+SRC_URI[go_linux_amd64.sha256sum] = "031f088e5d955bab8657ede27ad4e3bc5b7c1ba281f05f245bcc304f327c987a"
+SRC_URI[go_linux_arm64.sha256sum] = "a290581cfe4fe28ddd737dde3095f3dbeb7f2e4065cab4eae44dfc53b760c2f7"
+SRC_URI[go_linux_ppc64le.sha256sum] = "f56eed002998f5f51fa07fd4ed0c5de5e02d51cec7a4007f771c7576620d9d45"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.26.0.bb b/recipes-devtools/go/go-cross-canadian_1.26.1.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.26.0.bb
rename to recipes-devtools/go/go-cross-canadian_1.26.1.bb
diff --git a/recipes-devtools/go/go-cross_1.26.0.bb b/recipes-devtools/go/go-cross_1.26.1.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.26.0.bb
rename to recipes-devtools/go/go-cross_1.26.1.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.26.0.bb b/recipes-devtools/go/go-crosssdk_1.26.1.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.26.0.bb
rename to recipes-devtools/go/go-crosssdk_1.26.1.bb
diff --git a/recipes-devtools/go/go-runtime_1.26.0.bb b/recipes-devtools/go/go-runtime_1.26.1.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.26.0.bb
rename to recipes-devtools/go/go-runtime_1.26.1.bb
diff --git a/recipes-devtools/go/go_1.26.0.bb b/recipes-devtools/go/go_1.26.1.bb
similarity index 100%
rename from recipes-devtools/go/go_1.26.0.bb
rename to recipes-devtools/go/go_1.26.1.bb

