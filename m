Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBC8CCD190
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 19:36:49 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.5212.1760470605743726789
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Oct 2025 12:36:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=bgc/J0ou;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-202510141936436663efedec000207a4-3ogxfo@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202510141936436663efedec000207a4
        for <yocto-patches@lists.yoctoproject.org>;
        Tue, 14 Oct 2025 21:36:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SRzG3B9BK1a3zQTWV+sRdgKHW/m5XzlhmWsYnak1WW8=;
 b=bgc/J0ouNuQMbMaMAuVGu4nK2uTDs/poiY8+2jaWVzCwax5DgmiudGkqCDJAdcBDMapTX3
 am1/EIxxOT0Lv4C3Rz9xn6rxjetH9gkq8uj3lCJQjKQjrlRU/bVTU2iqfZZDQ3uOuyKUtcry
 3pVxu/Io2FASLQuskQHNHGkejPH+sZa40er8U+Ouj9hIzuLILZvcJQ4U0Q2dR1BWS2WtvSVv
 d+dHB+5C9wYtwXmF3dlcPgKTarz7FkEgwc7TftFY4ZofqYynbXZSkJreRLCCS10IVwXvfrzF
 BxlcMVADp1mSuC7zV7syb78YZmXG0x+XczglVvJ9/2XZ7ukrWNuk7Z5A==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	peter.marko@siemens.com
Subject: [meta-lts-mixins][kirkstone/go][PATCH 3/3] go: upgrade 1.25.1 -> 1.25.2
Date: Tue, 14 Oct 2025 21:36:33 +0200
Message-Id: <20251014193633.583798-3-peter.marko@siemens.com>
In-Reply-To: <20251014193633.583798-1-peter.marko@siemens.com>
References: <20251014193633.583798-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 19:36:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2307

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.25.x release [1]:

$ git --no-pager log --oneline go1.25.1..go1.25.2
bed6c81c2d (tag: go1.25.2) [release-branch.go1.25] go1.25.2
2612dcfd3c [release-branch.go1.25] archive/tar: set a limit on the size of GNU sparse file 1.0 regions
90f72bd500 [release-branch.go1.25] encoding/pem: make Decode complexity linear
e0f655bf3f [release-branch.go1.25] encoding/asn1: prevent memory exhaustion when parsing using internal/saferio
100c5a6680 [release-branch.go1.25] net/http: add httpcookiemaxnum GODEBUG option to limit number of cookies parsed
f0c69db15a [release-branch.go1.25] crypto/x509: improve domain name verification
9fd3ac8a10 [release-branch.go1.25] net/url: enforce stricter parsing of bracketed IPv6 hostnames
5d7a787aa2 [release-branch.go1.25] net/textproto: avoid quadratic complexity in Reader.ReadResponse
930ce220d0 [release-branch.go1.25] crypto/x509: mitigate DoS vector when intermediate certificate contains DSA public key
6a057327cf [release-branch.go1.25] net/mail: avoid quadratic behavior in mail address parsing
66f6feaa53 [release-branch.go1.25] spec: revert "update spec date to match release date"
d6f2741248 [release-branch.go1.25] spec: update spec date to match release date
28ac8d2104 [release-branch.go1.25] net/http: avoid connCount underflow race
06993c7721 [release-branch.go1.25] context: don't return a non-nil from Err before Done is closed
0b53e410f8 [release-branch.go1.25] debug/pe: permit symbols with no name
7735dc90ed [release-branch.go1.25] cmd/compile: don't rely on loop info when there are irreducible loops
205d086595 [release-branch.go1.25] crypto/tls: quote protocols in ALPN error message
16fdaac4b1 [release-branch.go1.25] sync/atomic: correct Uintptr.Or return doc
f3dc4aac0b [release-branch.go1.25] runtime: initialise debug settings much earlier in startup process
79c3081b4b [release-branch.go1.25] internal/poll: don't call Seek for overlapped Windows handles
b816c79658 [release-branch.go1.25] lib/fips140: re-seal v1.0.0
90de3b3399 [release-branch.go1.25] crypto/internal/fips140: remove key import PCTs, make keygen PCTs fatal
bec452a3a2 [release-branch.go1.25] crypto/internal/fips140: update frozen module version to "v1.0.0"
57bd28ab7f [release-branch.go1.25] crypto/internal/fips140/ecdsa: make TestingOnlyNewDRBG generic
f75bcffa4a [release-branch.go1.25] os: set full name for Roots created with Root.OpenRoot
7d570090a9 [release-branch.go1.25] os: fix Root.MkdirAll to handle race of directory creation
be61132165 [release-branch.go1.25] cmd/compile: export to DWARF types only referenced through interfaces
a86792b169 [release-branch.go1.25] net: skip TestIPv4WriteMsgUDPAddrPort on plan9
879e3cb5f7 [release-branch.go1.25] runtime: lock mheap_.speciallock when allocating synctest specials

Fixes CVE-2025-61725, CVE-2025-58187, CVE-2025-58189, CVE-2025-61723,
      CVE-2025-47912, CVE-2025-58185, CVE-2025-58186, CVE-2025-58188,
      CVE-2025-58183 and CVE-2025-61724 [2].

[1] https://github.com/golang/go/compare/go1.25.1...go1.25.2
[2] https://groups.google.com/g/golang-announce/c/4Emdl2iQ_bI

(From OE-Core rev: b46e8fdfc23a575ee8c69c136c7815e366a7e904)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.25.1.inc => go-1.25.2.inc}        | 2 +-
 ...o-binary-native_1.25.1.bb => go-binary-native_1.25.2.bb} | 6 +++---
 ...cross-canadian_1.25.1.bb => go-cross-canadian_1.25.2.bb} | 0
 .../go/{go-cross_1.25.1.bb => go-cross_1.25.2.bb}           | 0
 .../go/{go-crosssdk_1.25.1.bb => go-crosssdk_1.25.2.bb}     | 0
 .../go/{go-runtime_1.25.1.bb => go-runtime_1.25.2.bb}       | 0
 recipes-devtools/go/{go_1.25.1.bb => go_1.25.2.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.25.1.inc => go-1.25.2.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.25.1.bb => go-binary-native_1.25.2.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.25.1.bb => go-cross-canadian_1.25.2.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.25.1.bb => go-cross_1.25.2.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.25.1.bb => go-crosssdk_1.25.2.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.25.1.bb => go-runtime_1.25.2.bb} (100%)
 rename recipes-devtools/go/{go_1.25.1.bb => go_1.25.2.bb} (100%)

diff --git a/recipes-devtools/go/go-1.25.1.inc b/recipes-devtools/go/go-1.25.2.inc
similarity index 91%
rename from recipes-devtools/go/go-1.25.1.inc
rename to recipes-devtools/go/go-1.25.2.inc
index ca36cae..9d1cf69 100644
--- a/recipes-devtools/go/go-1.25.1.inc
+++ b/recipes-devtools/go/go-1.25.2.inc
@@ -18,4 +18,4 @@ SRC_URI += "\
     file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch \
     file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch \
 "
-SRC_URI[main.sha256sum] = "d010c109cee94d80efe681eab46bdea491ac906bf46583c32e9f0dbb0bd1a594"
+SRC_URI[main.sha256sum] = "3711140cfb87fce8f7a13f7cd860df041e6c12f7610f40cac6ec6fa2b65e96e4"
diff --git a/recipes-devtools/go/go-binary-native_1.25.1.bb b/recipes-devtools/go/go-binary-native_1.25.2.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.25.1.bb
rename to recipes-devtools/go/go-binary-native_1.25.2.bb
index 80d8c8a..2320731 100644
--- a/recipes-devtools/go/go-binary-native_1.25.1.bb
+++ b/recipes-devtools/go/go-binary-native_1.25.2.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "7716a0d940a0f6ae8e1f3b3f4f36299dc53e31b16840dbd171254312c41ca12e"
-SRC_URI[go_linux_arm64.sha256sum] = "65a3e34fb2126f55b34e1edfc709121660e1be2dee6bdf405fc399a63a95a87d"
-SRC_URI[go_linux_ppc64le.sha256sum] = "8b0c8d3ee5b1b5c28b6bd63dc4438792012e01d03b4bf7a61d985c87edab7d1f"
+SRC_URI[go_linux_amd64.sha256sum] = "d7fa7f8fbd16263aa2501d681b11f972a5fd8e811f7b10cb9b26d031a3d7454b"
+SRC_URI[go_linux_arm64.sha256sum] = "9aaeb044bf8dbf50ca2fbf0edc5ebc98b90d5bda8c6b2911526df76f61232919"
+SRC_URI[go_linux_ppc64le.sha256sum] = "91dd35ac3f33baa642d9bac22b626bdb5ee0372cf80e7d782994337f81f34417"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.25.1.bb b/recipes-devtools/go/go-cross-canadian_1.25.2.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.25.1.bb
rename to recipes-devtools/go/go-cross-canadian_1.25.2.bb
diff --git a/recipes-devtools/go/go-cross_1.25.1.bb b/recipes-devtools/go/go-cross_1.25.2.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.25.1.bb
rename to recipes-devtools/go/go-cross_1.25.2.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.25.1.bb b/recipes-devtools/go/go-crosssdk_1.25.2.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.25.1.bb
rename to recipes-devtools/go/go-crosssdk_1.25.2.bb
diff --git a/recipes-devtools/go/go-runtime_1.25.1.bb b/recipes-devtools/go/go-runtime_1.25.2.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.25.1.bb
rename to recipes-devtools/go/go-runtime_1.25.2.bb
diff --git a/recipes-devtools/go/go_1.25.1.bb b/recipes-devtools/go/go_1.25.2.bb
similarity index 100%
rename from recipes-devtools/go/go_1.25.1.bb
rename to recipes-devtools/go/go_1.25.2.bb

