Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014C5D3E77B
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 20:41:35 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6402.1765399288477251970
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Dec 2025 12:41:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=j8B6jlKM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-20251210204126ed793989260002073f-3_kn9w@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251210204126ed793989260002073f
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 10 Dec 2025 21:41:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=cJeue7Zjn4lxtAMsNF1QcwGd5H/mjsw2mPul2wp4K2Y=;
 b=j8B6jlKMYj4ioilMqyJ1McMAi97VruIX857CRQQTSh3dLsXGQyRoW99u8Bl43lsIH7IJZm
 wdDPSLK9/i6p0x8Ao3j4EbHOu39P+oAQ6D4SxItUWnjlgiG6FvlTOfe9HSyQjuTtBNI5FzTe
 nSPf6DS8//0fs1V6GsFyuvFxTWyppbjxIARqeQqbYkVV43fSxBADcttFGCYhvGXVdzW6zvcb
 PRxE01odRWPjH0yMQxlNHURgCUbrgEZoGwNkkgVXIk8NBd0Y82+nFC2pBXBotXfTLOKwtyCl
 psVRgITBZ7xORRUyRHGvb2ww92pjQGORqlG128J2cBe7guGypuZcK6uw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.25.4 -> 1.25.5
Date: Wed, 10 Dec 2025 21:41:25 +0100
Message-Id: <20251210204125.10132-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Dec 2025 20:41:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2764

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.25.x release [1]:

$ git --no-pager log --oneline go1.25.4..go1.25.5
fefb02adf4 (tag: go1.25.5) [release-branch.go1.25] go1.25.5
f7bce4bd6f [release-branch.go1.25] crypto/x509: prevent HostnameError.Error() from consuming excessive resource
287017aceb [release-branch.go1.25] crypto/x509: excluded subdomain constraints preclude wildcard SANs
e1ce1bfa7f [release-branch.go1.25] mime: parse media types that contain braces
433c01e94e [release-branch.go1.25] internal/syscall/windows: fix ReOpenFile sentinel error value

Fixes CVE-2025-61729 and CVE-2025-61727.

Release information: [2]

[1] https://github.com/golang/go/compare/go1.25.4...go1.25.5
[2] https://groups.google.com/g/golang-announce/c/8FJoBkPddm4

(From OE-Core rev: 91c007b0f5fff728cc7803a56a4df8438f20bdea)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.25.4.inc => go-1.25.5.inc}        | 2 +-
 ...o-binary-native_1.25.4.bb => go-binary-native_1.25.5.bb} | 6 +++---
 ...cross-canadian_1.25.4.bb => go-cross-canadian_1.25.5.bb} | 0
 .../go/{go-cross_1.25.4.bb => go-cross_1.25.5.bb}           | 0
 .../go/{go-crosssdk_1.25.4.bb => go-crosssdk_1.25.5.bb}     | 0
 .../go/{go-runtime_1.25.4.bb => go-runtime_1.25.5.bb}       | 0
 recipes-devtools/go/{go_1.25.4.bb => go_1.25.5.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.25.4.inc => go-1.25.5.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.25.4.bb => go-binary-native_1.25.5.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.25.4.bb => go-cross-canadian_1.25.5.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.25.4.bb => go-cross_1.25.5.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.25.4.bb => go-crosssdk_1.25.5.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.25.4.bb => go-runtime_1.25.5.bb} (100%)
 rename recipes-devtools/go/{go_1.25.4.bb => go_1.25.5.bb} (100%)

diff --git a/recipes-devtools/go/go-1.25.4.inc b/recipes-devtools/go/go-1.25.5.inc
similarity index 91%
rename from recipes-devtools/go/go-1.25.4.inc
rename to recipes-devtools/go/go-1.25.5.inc
index f88d7fe..47d5c39 100644
--- a/recipes-devtools/go/go-1.25.4.inc
+++ b/recipes-devtools/go/go-1.25.5.inc
@@ -18,4 +18,4 @@ SRC_URI += "\
     file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch \
     file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch \
 "
-SRC_URI[main.sha256sum] = "160043b7f17b6d60b50369436917fda8d5034640ba39ae2431c6b95a889cc98c"
+SRC_URI[main.sha256sum] = "22a5fd0a91efcd28a1b0537106b9959b2804b61f59c3758b51e8e5429c1a954f"
diff --git a/recipes-devtools/go/go-binary-native_1.25.4.bb b/recipes-devtools/go/go-binary-native_1.25.5.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.25.4.bb
rename to recipes-devtools/go/go-binary-native_1.25.5.bb
index 997c4bd..94de9ce 100644
--- a/recipes-devtools/go/go-binary-native_1.25.4.bb
+++ b/recipes-devtools/go/go-binary-native_1.25.5.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "9fa5ffeda4170de60f67f3aa0f824e426421ba724c21e133c1e35d6159ca1bec"
-SRC_URI[go_linux_arm64.sha256sum] = "a68e86d4b72c2c2fecf7dfed667680b6c2a071221bbdb6913cf83ce3f80d9ff0"
-SRC_URI[go_linux_ppc64le.sha256sum] = "38c8ac8463537c99fbc1ef368f243b626144446c09db71b1d20634a4237c966d"
+SRC_URI[go_linux_amd64.sha256sum] = "9e9b755d63b36acf30c12a9a3fc379243714c1c6d3dd72861da637f336ebb35b"
+SRC_URI[go_linux_arm64.sha256sum] = "b00b694903d126c588c378e72d3545549935d3982635ba3f7a964c9fa23fe3b9"
+SRC_URI[go_linux_ppc64le.sha256sum] = "f0904b647b5b8561efc5d48bb59a34f2b7996afab83ccd41c93b1aeb2c0067e4"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.25.4.bb b/recipes-devtools/go/go-cross-canadian_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.25.4.bb
rename to recipes-devtools/go/go-cross-canadian_1.25.5.bb
diff --git a/recipes-devtools/go/go-cross_1.25.4.bb b/recipes-devtools/go/go-cross_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.25.4.bb
rename to recipes-devtools/go/go-cross_1.25.5.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.25.4.bb b/recipes-devtools/go/go-crosssdk_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.25.4.bb
rename to recipes-devtools/go/go-crosssdk_1.25.5.bb
diff --git a/recipes-devtools/go/go-runtime_1.25.4.bb b/recipes-devtools/go/go-runtime_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.25.4.bb
rename to recipes-devtools/go/go-runtime_1.25.5.bb
diff --git a/recipes-devtools/go/go_1.25.4.bb b/recipes-devtools/go/go_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go_1.25.4.bb
rename to recipes-devtools/go/go_1.25.5.bb

