Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C812CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 15:23:52 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.104213.1755098625416699955
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Aug 2025 08:23:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=VaHjjWjE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-2025081315233812c072e1f6caedbb54-yomwwd@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025081315233812c072e1f6caedbb54
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 13 Aug 2025 17:23:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=UUZG2VQ0W3mLWzoLlyN2KU9c172t6WSV75QdN4JFjYM=;
 b=VaHjjWjEx7qwk9X3QFnzeVkYNaKAKP0o7FBd97HohhTeY3E8tY0N3ELDR59Hkvhe1xNQma
 /xWzRoNkBRQtQCQqZYUuk/Vzjcr7uSHYYU7d8Bmg7Ivn3z7EXltxoeoPasJ68Ca/ZaBnB/HW
 hbVzmD06ncFntFUGSHArdGBIEq91HFp3i4w961TtrUIPFCuoLOzqL42uhOpCFn1xFGPeOUbr
 YTSLdWvCG/BDjp6qYMmTH7jhbcWcM5SkDZxzzgY6pb9Up705cgynMGh7dq+C9LH5pKrhMXJ6
 zZDBJHTIfE7fQjlYM9GugD8TicycGc7Jkq1dN0o2S+B4FRaG2pkrugfw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][kirkstone/go][PATCH 1/2] go: upgrade 1.24.5 -> 1.24.6
Date: Wed, 13 Aug 2025 17:22:52 +0200
Message-Id: <20250813152253.10940-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Aug 2025 15:23:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1982

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.24.x release [1]:

$ git --no-pager log --oneline go1.24.5..go1.24.6
7f36edc26d [release-branch.go1.24] go1.24.6
83b4a5db24 [release-branch.go1.24] database/sql: avoid closing Rows while scan is in progress
0f5133b742 [release-branch.go1.24] os/exec: fix incorrect expansion of "", "." and ".." in LookPath
6e1c4529e4 [release-branch.go1.24] cmd/compile: for arm64 epilog, do SP increment with a single instruction
731de13dc3 [release-branch.go1.24] os/user: user random name for the test user account
390ffce7d6 [release-branch.go1.24] runtime: prevent unnecessary zeroing of large objects with pointers
b454859a8a [release-branch.go1.24] runtime: stash allpSnapshot on the M

Fixes CVE-2025-47906 and CVE-2025-47907 [2].

[1] https://github.com/golang/go/compare/go1.24.5...go1.24.6
[2] https://groups.google.com/g/golang-announce/c/x5MKroML2yM

(From OE-Core rev: f3072c210ac0a1e4d8046d920c3ebc29f9916b72)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.24.5.inc => go-1.24.6.inc}        | 2 +-
 ...o-binary-native_1.24.5.bb => go-binary-native_1.24.6.bb} | 6 +++---
 ...cross-canadian_1.24.5.bb => go-cross-canadian_1.24.6.bb} | 0
 .../go/{go-cross_1.24.5.bb => go-cross_1.24.6.bb}           | 0
 .../go/{go-crosssdk_1.24.5.bb => go-crosssdk_1.24.6.bb}     | 0
 .../go/{go-runtime_1.24.5.bb => go-runtime_1.24.6.bb}       | 0
 recipes-devtools/go/{go_1.24.5.bb => go_1.24.6.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.24.5.inc => go-1.24.6.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.24.5.bb => go-binary-native_1.24.6.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.24.5.bb => go-cross-canadian_1.24.6.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.24.5.bb => go-cross_1.24.6.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.24.5.bb => go-crosssdk_1.24.6.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.24.5.bb => go-runtime_1.24.6.bb} (100%)
 rename recipes-devtools/go/{go_1.24.5.bb => go_1.24.6.bb} (100%)

diff --git a/recipes-devtools/go/go-1.24.5.inc b/recipes-devtools/go/go-1.24.6.inc
similarity index 91%
rename from recipes-devtools/go/go-1.24.5.inc
rename to recipes-devtools/go/go-1.24.6.inc
index fae0d3f..a3933c2 100644
--- a/recipes-devtools/go/go-1.24.5.inc
+++ b/recipes-devtools/go/go-1.24.6.inc
@@ -17,4 +17,4 @@ SRC_URI += "\
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
 "
-SRC_URI[main.sha256sum] = "74fdb09f2352e2b25b7943e56836c9b47363d28dec1c8b56c4a9570f30b8f59f"
+SRC_URI[main.sha256sum] = "e1cb5582aab588668bc04c07de18688070f6b8c9b2aaf361f821e19bd47cfdbd"
diff --git a/recipes-devtools/go/go-binary-native_1.24.5.bb b/recipes-devtools/go/go-binary-native_1.24.6.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.24.5.bb
rename to recipes-devtools/go/go-binary-native_1.24.6.bb
index 5002686..6d7ad3a 100644
--- a/recipes-devtools/go/go-binary-native_1.24.5.bb
+++ b/recipes-devtools/go/go-binary-native_1.24.6.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "10ad9e86233e74c0f6590fe5426895de6bf388964210eac34a6d83f38918ecdc"
-SRC_URI[go_linux_arm64.sha256sum] = "0df02e6aeb3d3c06c95ff201d575907c736d6c62cfa4b6934c11203f1d600ffa"
-SRC_URI[go_linux_ppc64le.sha256sum] = "00bdfb16d1094e78473b681d2d09d42c19c886d4dfed743853769f1665c7a552"
+SRC_URI[go_linux_amd64.sha256sum] = "bbca37cc395c974ffa4893ee35819ad23ebb27426df87af92e93a9ec66ef8712"
+SRC_URI[go_linux_arm64.sha256sum] = "124ea6033a8bf98aa9fbab53e58d134905262d45a022af3a90b73320f3c3afd5"
+SRC_URI[go_linux_ppc64le.sha256sum] = "63fc9559a3d6dfd63aa902f714375b879bbc848466181c035c122489b9646e27"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.24.5.bb b/recipes-devtools/go/go-cross-canadian_1.24.6.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.24.5.bb
rename to recipes-devtools/go/go-cross-canadian_1.24.6.bb
diff --git a/recipes-devtools/go/go-cross_1.24.5.bb b/recipes-devtools/go/go-cross_1.24.6.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.24.5.bb
rename to recipes-devtools/go/go-cross_1.24.6.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.24.5.bb b/recipes-devtools/go/go-crosssdk_1.24.6.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.24.5.bb
rename to recipes-devtools/go/go-crosssdk_1.24.6.bb
diff --git a/recipes-devtools/go/go-runtime_1.24.5.bb b/recipes-devtools/go/go-runtime_1.24.6.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.24.5.bb
rename to recipes-devtools/go/go-runtime_1.24.6.bb
diff --git a/recipes-devtools/go/go_1.24.5.bb b/recipes-devtools/go/go_1.24.6.bb
similarity index 100%
rename from recipes-devtools/go/go_1.24.5.bb
rename to recipes-devtools/go/go_1.24.6.bb

