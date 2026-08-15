Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0012DC5DF6A
	for <webhook@archiver.kernel.org>; Sat, 15 Aug 2026 12:47:16 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8182.1786798034739966994
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 15 Aug 2026 05:47:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=ZXu/MvB7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-202608151247106c7be77caa000207f3-r6ckq4@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202608151247106c7be77caa000207f3
        for <yocto-patches@lists.yoctoproject.org>;
        Sat, 15 Aug 2026 14:47:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=zt+sOFLp3oDPHI/9u0oh8ReV8Xk6y2kvqKfd0a5p60I=;
 b=ZXu/MvB7JBcsUUf9qRwmH/rwHBXvNULKK1cupWA1nmL94i3mjJno2KHJvKNETH5YYyLD26
 /UMLPi9kYmT8nfuB2CYc2saCbsGDv/RsM/1Cfbfk5kLb0syfsgwfAzmkl7BOpWuXXSgLnNpt
 z0EFqBwRmsun6X4BaN6SBFOr2oJHeUhIGF5zSOyDomn3XVt7JQNUhP2s0ayVBXoWvz97VXnl
 TPRNXH4NvhSYSBV6do0+PAz4bVsskMdH9l6NP36NQDDXCNeU9a4kUpST+EGAV7LmvHjTOOoj
 MEhwRh955FlZkMofpsVEnXpRsYsrUjjTzRbcLx/aDKdhVk8vO9BeTP4w==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.5 -> 1.26.6
Date: Sat, 15 Aug 2026 14:46:58 +0200
Message-ID: <20260815124658.1003592-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 15 Aug 2026 12:47:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4668

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.26.x release [1]:

$ git --no-pager log --oneline go1.26.5..go1.26.6
1ea5a71ad8 (tag: go1.26.6) [release-branch.go1.26] go1.26.6
115eb476aa [release-branch.go1.26] cmd/vendor: fix CVE-2026-56865 in x/mod
9f6980fd5c [release-branch.go1.26] cmd/vendor: fix CVE-2026-56864 in x/mod
6ec908dd24 [release-branch.go1.26] encoding/asn1: enforce maximum recursion depth
9918f26ab3 [release-branch.go1.26] encoding/xml: fix depth processing in (*Decoder).unmarshal
33ecb966ca [release-branch.go1.26] html/template: fix JavaScript regexp tracking
128893dbf9 [release-branch.go1.26] net/url: avoid quadratic complexity in resolvePath
13c194062c [release-branch.go1.26] cmd/compile: do not elide riscv64 sign extension of unsigned values
52e5e2f22a [release-branch.go1.26] cmd/compile: fix time traveling proofs in prove
db38ee7121 [release-branch.go1.26] cmd/compile: fix prove to generate Const64 for 64bits slicemasks
f5bf46f361 [release-branch.go1.26] cmd/compile: fix mips64le bigger than 32bits pointer offsets
f8d4fa6213 [release-branch.go1.26] runtime: fix frame pointer adjustment around injected calls
efc79671b1 [release-branch.go1.26] cmd/compile: do not home mul/div results in HI/LO
605fd48711 [release-branch.go1.26] crypto/tls: add fips140ems GODEBUG setting to disable EMS enforcement
100fb8f023 [release-branch.go1.26] cmd/link: quote PE .def library name
4d522f275f [release-branch.go1.26] cmd/compile: tighten mergelocals address use analysis
0e8a244fe5 [release-branch.go1.26] all: update x/net
019fcb0152 [release-branch.go1.26] cmd/compile: don't require Heapaddr for heap vars in dead code
b6432317a1 [release-branch.go1.26] crypto/tls: do not count handshake messages as state-advancing post-handshake
ae63e27897 [release-branch.go1.26] runtime: fix uninitialized 7th argument in mach_vm_region_trampoline
88bf57924f [release-branch.go1.26] runtime: don't emit write barrier for code pointers in itabInit
4238449188 [release-branch.go1.26] os: strip trailing slashes in RemoveAll on Plan 9
28f27d64cf [release-branch.go1.26] os: properly handle trailing / in Root.MkdirAll
cc312256f8 [release-branch.go1.26] runtime: be sure to scan small frame introduced by (*sigctxt).pushCall
07a0bbba1b [release-branch.go1.26] os: don't expect an error from Root.ReadFile from a directory on NetBSD
a42fec40ab [release-branch.go1.26] all: update x/net
5bbd22ff78 [release-branch.go1.26] net/http: apply header timeout to server's unencrypted HTTP/2 check

Fixes CVE-2026-56865, CVE-2026-56864, CVE-2026-56859, CVE-2026-56853,
      CVE-2026-56860, CVE-2026-46600, CVE-2026-56862, CVE-2026-56858,
      CVE-2026-39821 and CVE-2026-33818.

Release information: [2]

[1] https://github.com/golang/go/compare/go1.26.5...go1.26.6
[2] https://groups.google.com/g/golang-announce/c/94pEornpRlI

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: cae8a33abfda172e65166811eeb1bc7ad2d129a3)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/{go-1.26.5.inc => go-1.26.6.inc}        | 2 +-
 ...o-binary-native_1.26.5.bb => go-binary-native_1.26.6.bb} | 6 +++---
 ...cross-canadian_1.26.5.bb => go-cross-canadian_1.26.6.bb} | 0
 .../go/{go-cross_1.26.5.bb => go-cross_1.26.6.bb}           | 0
 .../go/{go-crosssdk_1.26.5.bb => go-crosssdk_1.26.6.bb}     | 0
 .../go/{go-runtime_1.26.5.bb => go-runtime_1.26.6.bb}       | 0
 recipes-devtools/go/{go_1.26.5.bb => go_1.26.6.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.26.5.inc => go-1.26.6.inc} (90%)
 rename recipes-devtools/go/{go-binary-native_1.26.5.bb => go-binary-native_1.26.6.bb} (80%)
 rename recipes-devtools/go/{go-cross-canadian_1.26.5.bb => go-cross-canadian_1.26.6.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.26.5.bb => go-cross_1.26.6.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.26.5.bb => go-crosssdk_1.26.6.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.26.5.bb => go-runtime_1.26.6.bb} (100%)
 rename recipes-devtools/go/{go_1.26.5.bb => go_1.26.6.bb} (100%)

diff --git a/recipes-devtools/go/go-1.26.5.inc b/recipes-devtools/go/go-1.26.6.inc
similarity index 90%
rename from recipes-devtools/go/go-1.26.5.inc
rename to recipes-devtools/go/go-1.26.6.inc
index a4302b2..fa6b0a5 100644
--- a/recipes-devtools/go/go-1.26.5.inc
+++ b/recipes-devtools/go/go-1.26.6.inc
@@ -16,4 +16,4 @@ SRC_URI += "\
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
 "
-SRC_URI[main.sha256sum] = "495be4bc87176ac567392e5b4116abd98466d33d7b49d41e764ccc6976b2dc42"
+SRC_URI[main.sha256sum] = "a0721c54c688901448d77ad9b3ec7ea7c474730755ff891382e92ecb93ff2cb1"
diff --git a/recipes-devtools/go/go-binary-native_1.26.5.bb b/recipes-devtools/go/go-binary-native_1.26.6.bb
similarity index 80%
rename from recipes-devtools/go/go-binary-native_1.26.5.bb
rename to recipes-devtools/go/go-binary-native_1.26.6.bb
index 8ba9dd4..c3e9eb1 100644
--- a/recipes-devtools/go/go-binary-native_1.26.5.bb
+++ b/recipes-devtools/go/go-binary-native_1.26.6.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "5c2c3b16caefa1d968a94c1daca04a7ca301a496d9b086e17ad77bb81393f053"
-SRC_URI[go_linux_arm64.sha256sum] = "fe4789e92b1f33358680864bbe8704289e7bb5fc207d80623c308935bd696d49"
-SRC_URI[go_linux_ppc64le.sha256sum] = "c5d60e2b303bb612f20cd82786594b64874e73b35134025e27d3390bf284ae43"
+SRC_URI[go_linux_amd64.sha256sum] = "708effb774be8237570d0add163225abbdfaf4fca28b2611df167beba4feef89"
+SRC_URI[go_linux_arm64.sha256sum] = "d0507e9e9d7fe012aae570108cbd76c15de879e17130ab8cb90d4d7445cb1f2e"
+SRC_URI[go_linux_ppc64le.sha256sum] = "232b65543a42eda95df6a63f76235c1795bb535eba5c74e509faec71bc648388"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.26.5.bb b/recipes-devtools/go/go-cross-canadian_1.26.6.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.26.5.bb
rename to recipes-devtools/go/go-cross-canadian_1.26.6.bb
diff --git a/recipes-devtools/go/go-cross_1.26.5.bb b/recipes-devtools/go/go-cross_1.26.6.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.26.5.bb
rename to recipes-devtools/go/go-cross_1.26.6.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.26.5.bb b/recipes-devtools/go/go-crosssdk_1.26.6.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.26.5.bb
rename to recipes-devtools/go/go-crosssdk_1.26.6.bb
diff --git a/recipes-devtools/go/go-runtime_1.26.5.bb b/recipes-devtools/go/go-runtime_1.26.6.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.26.5.bb
rename to recipes-devtools/go/go-runtime_1.26.6.bb
diff --git a/recipes-devtools/go/go_1.26.5.bb b/recipes-devtools/go/go_1.26.6.bb
similarity index 100%
rename from recipes-devtools/go/go_1.26.5.bb
rename to recipes-devtools/go/go_1.26.6.bb

