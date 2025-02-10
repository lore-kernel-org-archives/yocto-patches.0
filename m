Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF1CC02198
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 18:13:31 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.59175.1739211207313636474
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Feb 2025 10:13:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=T7W8Kul/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-202502101813246e61f1feaa7a2b0e4e-5abgaf@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202502101813246e61f1feaa7a2b0e4e
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 10 Feb 2025 19:13:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9fEHbzh71E1pKc4z6HUcvu1O+w12a6CA4MD5lIkilSE=;
 b=T7W8Kul/3e3YtXDOvcp1/eH595VL4+DtgyDGm3zTA9h1bNpy7jvTr3ivnuXoYqYVLTr6Xx
 IEKnhXecb4CUMUg135aJX/yzH5a1XzrjY10P2oHWUh/ho4+D3a7BbIE2bBO8D1bV9GAoJMe/
 d9fY5FzoAyBAS1BbHcIssVPl+sfUiuFRLEFgfts/lVOEiQg0qw5ypl7u6sd5Gj0XS2wTghyK
 Qlx4C0hBUvJEg3L0TY5NsAAf4umZjR3krFEg6gp/06K6Iizc22iUK2G7EUZ2vnsmc7ns3zYe
 6FPZKU03dldEdo5hYi7v6J9UUZXWPmQAFeUvh3F9hyPXXprWbp16I29g==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.22.11 -> 1.22.12
Date: Mon, 10 Feb 2025 19:12:38 +0100
Message-Id: <20250210181238.2350415-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Feb 2025 18:13:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1050

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.22.x release [1]:

$ git --no-pager log --oneline go1.22.11..go1.22.12
5817e65094 (tag: go1.22.12) [release-branch.go1.22] go1.22.12
0cc45e7ca6 [release-branch.go1.22] crypto/internal/fips140/nistec: make p256NegCond constant time on ppc64le
c3c6a50095 [release-branch.go1.22] cmd/go/internal/modfetch: do not trust server to send all tags in shallow fetch
e0a01acd04 [release-branch.go1.22] cmd/compile: fix write barrier coalescing

Fixes CVE-2025-22866

[1] https://github.com/golang/go/compare/go1.22.11...go1.22.12

(From OE-Core rev: 423ad5a67768738dac454b1e2aa27746f74511c5)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.22.11.inc => go-1.22.12.inc}      | 2 +-
 ...binary-native_1.22.11.bb => go-binary-native_1.22.12.bb} | 6 +++---
 ...oss-canadian_1.22.11.bb => go-cross-canadian_1.22.12.bb} | 0
 .../go/{go-cross_1.22.11.bb => go-cross_1.22.12.bb}         | 0
 .../go/{go-crosssdk_1.22.11.bb => go-crosssdk_1.22.12.bb}   | 0
 .../go/{go-runtime_1.22.11.bb => go-runtime_1.22.12.bb}     | 0
 recipes-devtools/go/{go_1.22.11.bb => go_1.22.12.bb}        | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.22.11.inc => go-1.22.12.inc} (89%)
 rename recipes-devtools/go/{go-binary-native_1.22.11.bb => go-binary-native_1.22.12.bb} (78%)
 rename recipes-devtools/go/{go-cross-canadian_1.22.11.bb => go-cross-canadian_1.22.12.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.22.11.bb => go-cross_1.22.12.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.22.11.bb => go-crosssdk_1.22.12.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.22.11.bb => go-runtime_1.22.12.bb} (100%)
 rename recipes-devtools/go/{go_1.22.11.bb => go_1.22.12.bb} (100%)

diff --git a/recipes-devtools/go/go-1.22.11.inc b/recipes-devtools/go/go-1.22.12.inc
similarity index 89%
rename from recipes-devtools/go/go-1.22.11.inc
rename to recipes-devtools/go/go-1.22.12.inc
index 21222be..05aa3a9 100644
--- a/recipes-devtools/go/go-1.22.11.inc
+++ b/recipes-devtools/go/go-1.22.12.inc
@@ -15,4 +15,4 @@ SRC_URI += "\
     file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
 "
-SRC_URI[main.sha256sum] = "a60c23dec95d10a2576265ce580f57869d5ac2471c4f4aca805addc9ea0fc9fe"
+SRC_URI[main.sha256sum] = "012a7e1f37f362c0918c1dfa3334458ac2da1628c4b9cf4d9ca02db986e17d71"
diff --git a/recipes-devtools/go/go-binary-native_1.22.11.bb b/recipes-devtools/go/go-binary-native_1.22.12.bb
similarity index 78%
rename from recipes-devtools/go/go-binary-native_1.22.11.bb
rename to recipes-devtools/go/go-binary-native_1.22.12.bb
index a526cc8..747737f 100644
--- a/recipes-devtools/go/go-binary-native_1.22.11.bb
+++ b/recipes-devtools/go/go-binary-native_1.22.12.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "0fc88d966d33896384fbde56e9a8d80a305dc17a9f48f1832e061724b1719991"
-SRC_URI[go_linux_arm64.sha256sum] = "9ebfcab26801fa4cf0627c6439db7a4da4d3c6766142a3dd83508240e4f21031"
-SRC_URI[go_linux_ppc64le.sha256sum] = "963a0ec973640b23ee8bb7a462cc415276fd8436111a03df8c34eb3b1ae29f12"
+SRC_URI[go_linux_amd64.sha256sum] = "4fa4f869b0f7fc6bb1eb2660e74657fbf04cdd290b5aef905585c86051b34d43"
+SRC_URI[go_linux_arm64.sha256sum] = "fd017e647ec28525e86ae8203236e0653242722a7436929b1f775744e26278e7"
+SRC_URI[go_linux_ppc64le.sha256sum] = "9573d30003b0796717a99d9e2e96c48fddd4fc0f29d840f212c503b03d7de112"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.22.11.bb b/recipes-devtools/go/go-cross-canadian_1.22.12.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.22.11.bb
rename to recipes-devtools/go/go-cross-canadian_1.22.12.bb
diff --git a/recipes-devtools/go/go-cross_1.22.11.bb b/recipes-devtools/go/go-cross_1.22.12.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.22.11.bb
rename to recipes-devtools/go/go-cross_1.22.12.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.22.11.bb b/recipes-devtools/go/go-crosssdk_1.22.12.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.22.11.bb
rename to recipes-devtools/go/go-crosssdk_1.22.12.bb
diff --git a/recipes-devtools/go/go-runtime_1.22.11.bb b/recipes-devtools/go/go-runtime_1.22.12.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.22.11.bb
rename to recipes-devtools/go/go-runtime_1.22.12.bb
diff --git a/recipes-devtools/go/go_1.22.11.bb b/recipes-devtools/go/go_1.22.12.bb
similarity index 100%
rename from recipes-devtools/go/go_1.22.11.bb
rename to recipes-devtools/go/go_1.22.12.bb

