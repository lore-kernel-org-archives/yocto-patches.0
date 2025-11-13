Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91A1CD8C82
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23141.1763038637547082669
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=btAPWsNe;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-2025111312571582e5ca9b8a00020755-pt3qxk@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025111312571582e5ca9b8a00020755
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=d+w0ehYQa8s/W9lrCdsTHHMlkoZQzw3MLFGgG+DZwsY=;
 b=btAPWsNeHeV9AfCbHQC8X3MM1MeisxnCwbs5Evd49CIKzqao/+PLxcvAZ9HWRNNpBjV4QC
 IThrnOBu1gbcXQeldOrQo7hXzZvdZu8IyiNOTDb9NMX8+g2zAwxbE3lsLG7euTzXjt9C/nSg
 YFzmgYBf0/Z9pmm6nAXFONjDyek5frguxzDBV1kBCgt1HeerAKUGr3FWzaMVz/yboVAO7RO4
 jCzLHFdFcH21xRLCcPBOz57cc2CYCNG75g1RDEB94M6oQ2HjoTjS2nMjjIOXgm1MYGlDVz6B
 hdMxvWe7W5fn12OfNpJ3IqMy7pg0xGbmScdSMaRDV7MVOR+kNPwg730A==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 30/34] go: upgrade 1.25.0 -> 1.25.1
Date: Thu, 13 Nov 2025 13:57:08 +0100
Message-Id: <20251113125712.18914-31-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2506

Upgrade to latest 1.25.x release [1]:

$ git --no-pager log --oneline go1.25.0..go1.25.1
56ebf80e57 (tag: go1.25.1) [release-branch.go1.25] go1.25.1
b1959cf6f7 [release-branch.go1.25] net/http: require exact match for CrossSiteProtection bypass patterns
cdd8cf4988 [release-branch.go1.25] net: fix WriteMsgUDPAddrPort addr handling on IPv4 sockets
8995e84ac6 [release-branch.go1.25] internal/poll: set the correct file offset in FD.Seek for Windows overlapped handles
749dff880a [release-branch.go1.25] runtime: make all synctest bubble violations fatal panics
21ac81c1e1 [release-branch.go1.25] os/exec: fix incorrect expansion of ".." in LookPath on plan9
c72fcab6d6 [release-branch.go1.25] cmd/go/internal/gover: fix ModIsPrerelease for toolchain versions

Fixes CVE-2025-47910 [2].

[1] https://github.com/golang/go/compare/go1.25.0...go1.25.1
[2] https://groups.google.com/g/golang-announce/c/PtW9VW21NPs

(From OE-Core rev: 34d34fdac49e2a3035e6a1aa3d5e8d1090e91c9f)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.25.0.inc => go-1.25.1.inc}        | 2 +-
 ...o-binary-native_1.25.0.bb => go-binary-native_1.25.1.bb} | 6 +++---
 ...cross-canadian_1.25.0.bb => go-cross-canadian_1.25.1.bb} | 0
 .../go/{go-cross_1.25.0.bb => go-cross_1.25.1.bb}           | 0
 .../go/{go-crosssdk_1.25.0.bb => go-crosssdk_1.25.1.bb}     | 0
 .../go/{go-runtime_1.25.0.bb => go-runtime_1.25.1.bb}       | 0
 recipes-devtools/go/{go_1.25.0.bb => go_1.25.1.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.25.0.inc => go-1.25.1.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.25.0.bb => go-binary-native_1.25.1.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.25.0.bb => go-cross-canadian_1.25.1.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.25.0.bb => go-cross_1.25.1.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.25.0.bb => go-crosssdk_1.25.1.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.25.0.bb => go-runtime_1.25.1.bb} (100%)
 rename recipes-devtools/go/{go_1.25.0.bb => go_1.25.1.bb} (100%)

diff --git a/recipes-devtools/go/go-1.25.0.inc b/recipes-devtools/go/go-1.25.1.inc
similarity index 91%
rename from recipes-devtools/go/go-1.25.0.inc
rename to recipes-devtools/go/go-1.25.1.inc
index 1558b46..ca36cae 100644
--- a/recipes-devtools/go/go-1.25.0.inc
+++ b/recipes-devtools/go/go-1.25.1.inc
@@ -18,4 +18,4 @@ SRC_URI += "\
     file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch \
     file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch \
 "
-SRC_URI[main.sha256sum] = "4bd01e91297207bfa450ea40d4d5a93b1b531a5e438473b2a06e18e077227225"
+SRC_URI[main.sha256sum] = "d010c109cee94d80efe681eab46bdea491ac906bf46583c32e9f0dbb0bd1a594"
diff --git a/recipes-devtools/go/go-binary-native_1.25.0.bb b/recipes-devtools/go/go-binary-native_1.25.1.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.25.0.bb
rename to recipes-devtools/go/go-binary-native_1.25.1.bb
index 8e61787..5288a1e 100644
--- a/recipes-devtools/go/go-binary-native_1.25.0.bb
+++ b/recipes-devtools/go/go-binary-native_1.25.1.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "2852af0cb20a13139b3448992e69b868e50ed0f8a1e5940ee1de9e19a123b613"
-SRC_URI[go_linux_arm64.sha256sum] = "05de75d6994a2783699815ee553bd5a9327d8b79991de36e38b66862782f54ae"
-SRC_URI[go_linux_ppc64le.sha256sum] = "0f18a89e7576cf2c5fa0b487a1635d9bcbf843df5f110e9982c64df52a983ad0"
+SRC_URI[go_linux_amd64.sha256sum] = "7716a0d940a0f6ae8e1f3b3f4f36299dc53e31b16840dbd171254312c41ca12e"
+SRC_URI[go_linux_arm64.sha256sum] = "65a3e34fb2126f55b34e1edfc709121660e1be2dee6bdf405fc399a63a95a87d"
+SRC_URI[go_linux_ppc64le.sha256sum] = "8b0c8d3ee5b1b5c28b6bd63dc4438792012e01d03b4bf7a61d985c87edab7d1f"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.25.0.bb b/recipes-devtools/go/go-cross-canadian_1.25.1.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.25.0.bb
rename to recipes-devtools/go/go-cross-canadian_1.25.1.bb
diff --git a/recipes-devtools/go/go-cross_1.25.0.bb b/recipes-devtools/go/go-cross_1.25.1.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.25.0.bb
rename to recipes-devtools/go/go-cross_1.25.1.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.25.0.bb b/recipes-devtools/go/go-crosssdk_1.25.1.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.25.0.bb
rename to recipes-devtools/go/go-crosssdk_1.25.1.bb
diff --git a/recipes-devtools/go/go-runtime_1.25.0.bb b/recipes-devtools/go/go-runtime_1.25.1.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.25.0.bb
rename to recipes-devtools/go/go-runtime_1.25.1.bb
diff --git a/recipes-devtools/go/go_1.25.0.bb b/recipes-devtools/go/go_1.25.1.bb
similarity index 100%
rename from recipes-devtools/go/go_1.25.0.bb
rename to recipes-devtools/go/go_1.25.1.bb

