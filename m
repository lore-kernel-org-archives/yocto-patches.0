Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12D0EEA845
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 19:26:06 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.54019.1770924363961017086
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Feb 2026 11:26:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=WWfHydsE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-20260212192601fda8b86152000207a3-m19k9l@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260212192601fda8b86152000207a3
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 12 Feb 2026 20:26:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=S67IGHQeG6gOr7NNJ25A8c+029P6iuNADVlalkfE8fw=;
 b=WWfHydsEk+P/VvuRkEYCRlx9/TmktWOnOX7oCbQ5SYj2gj4abKkbyyAVvVCh0HXk2HyBA2
 lCDNw9HSzV8ov99srehzD4vOl+l/P8Y9yg1b9tcJegcjunBN3t9OOpsG3tdXE1R1/u0W9cC0
 /vE9GO16GfcNCyYXcO0Sg9po4ynoOhlCJAQ2jrbVdy/AVvsT+i0dH9VUD/tvtR6ge0EP4d83
 uQQ2Q513/EJGdKmOQajvExQuLX6QRya1XfaeTf51WgxRbRRp1MACEzmGCZwhEwauLmUGcs1M
 c5RPe5MD8h1zxIzLYt8h62uUc3hc+pa+oCGRa/LNk6bL6VtmANDXNdUg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com
Subject: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.25.6 -> 1.25.7
Date: Thu, 12 Feb 2026 20:25:58 +0100
Message-Id: <20260212192558.1634958-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 19:26:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3231

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.25.x release [1]:

$ git --no-pager log --oneline go1.25.6..go1.25.7
eaf3bc799a (tag: go1.25.7) [release-branch.go1.25] go1.25.7
c7d189e65c [release-branch.go1.25] crypto/tls: document resumption behavior across Configs
4512014530 [release-branch.go1.25] crypto/tls: revalidate whole chain on resumption on Windows and macOS
d5987bff8a [release-branch.go1.25] crypto/tls: check verifiedChains roots when resuming sessions
c2d04c0994 [release-branch.go1.25] crypto/tls: add verifiedChains expiration checking during resumption
6b1110a40f [release-branch.go1.25] Revert "crypto/tls: don't copy auto-rotated session ticket keys in Config.Clone"
0765a9d624 [release-branch.go1.25] crypto/x509: fix single label excluded name constraints handling
b19100991a [release-branch.go1.25] cmd/go: remove user-content from doc strings in cgo ASTs.
738bc3a33c [release-branch.go1.25] cmd/compile: during regalloc, fixedreg values are always available

Fixes CVE-2025-61732 and CVE-2025-68121.

Release information: [2]

[1] https://github.com/golang/go/compare/go1.25.6...go1.25.7
[2] https://groups.google.com/g/golang-announce/c/K09ubi9FQFk

(From OE-Core rev: 7a5237b7ae557136eee9ff3f98e2b0a74f39ebb7)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.25.6.inc => go-1.25.7.inc}        | 2 +-
 ...o-binary-native_1.25.6.bb => go-binary-native_1.25.7.bb} | 6 +++---
 ...cross-canadian_1.25.6.bb => go-cross-canadian_1.25.7.bb} | 0
 .../go/{go-cross_1.25.6.bb => go-cross_1.25.7.bb}           | 0
 .../go/{go-crosssdk_1.25.6.bb => go-crosssdk_1.25.7.bb}     | 0
 .../go/{go-runtime_1.25.6.bb => go-runtime_1.25.7.bb}       | 0
 recipes-devtools/go/{go_1.25.6.bb => go_1.25.7.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.25.6.inc => go-1.25.7.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.25.6.bb => go-binary-native_1.25.7.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.25.6.bb => go-cross-canadian_1.25.7.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.25.6.bb => go-cross_1.25.7.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.25.6.bb => go-crosssdk_1.25.7.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.25.6.bb => go-runtime_1.25.7.bb} (100%)
 rename recipes-devtools/go/{go_1.25.6.bb => go_1.25.7.bb} (100%)

diff --git a/recipes-devtools/go/go-1.25.6.inc b/recipes-devtools/go/go-1.25.7.inc
similarity index 91%
rename from recipes-devtools/go/go-1.25.6.inc
rename to recipes-devtools/go/go-1.25.7.inc
index 2c31c4a..ab58f71 100644
--- a/recipes-devtools/go/go-1.25.6.inc
+++ b/recipes-devtools/go/go-1.25.7.inc
@@ -18,4 +18,4 @@ SRC_URI += "\
     file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch \
     file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch \
 "
-SRC_URI[main.sha256sum] = "58cbf771e44d76de6f56d19e33b77d745a1e489340922875e46585b975c2b059"
+SRC_URI[main.sha256sum] = "178f2832820274b43e177d32f06a3ebb0129e427dd20a5e4c88df2c1763cf10a"
diff --git a/recipes-devtools/go/go-binary-native_1.25.6.bb b/recipes-devtools/go/go-binary-native_1.25.7.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.25.6.bb
rename to recipes-devtools/go/go-binary-native_1.25.7.bb
index 261f7dc..ec6fa10 100644
--- a/recipes-devtools/go/go-binary-native_1.25.6.bb
+++ b/recipes-devtools/go/go-binary-native_1.25.7.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "f022b6aad78e362bcba9b0b94d09ad58c5a70c6ba3b7582905fababf5fe0181a"
-SRC_URI[go_linux_arm64.sha256sum] = "738ef87d79c34272424ccdf83302b7b0300b8b096ed443896089306117943dd5"
-SRC_URI[go_linux_ppc64le.sha256sum] = "bee02dbe034b12b839ae7807a85a61c13bee09ee38f2eeba2074bd26c0c0ab73"
+SRC_URI[go_linux_amd64.sha256sum] = "12e6d6a191091ae27dc31f6efc630e3a3b8ba409baf3573d955b196fdf086005"
+SRC_URI[go_linux_arm64.sha256sum] = "ba611a53534135a81067240eff9508cd7e256c560edd5d8c2fef54f083c07129"
+SRC_URI[go_linux_ppc64le.sha256sum] = "42124c0edc92464e2b37b2d7fcd3658f0c47ebd6a098732415a522be8cb88e3f"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.25.6.bb b/recipes-devtools/go/go-cross-canadian_1.25.7.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.25.6.bb
rename to recipes-devtools/go/go-cross-canadian_1.25.7.bb
diff --git a/recipes-devtools/go/go-cross_1.25.6.bb b/recipes-devtools/go/go-cross_1.25.7.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.25.6.bb
rename to recipes-devtools/go/go-cross_1.25.7.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.25.6.bb b/recipes-devtools/go/go-crosssdk_1.25.7.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.25.6.bb
rename to recipes-devtools/go/go-crosssdk_1.25.7.bb
diff --git a/recipes-devtools/go/go-runtime_1.25.6.bb b/recipes-devtools/go/go-runtime_1.25.7.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.25.6.bb
rename to recipes-devtools/go/go-runtime_1.25.7.bb
diff --git a/recipes-devtools/go/go_1.25.6.bb b/recipes-devtools/go/go_1.25.7.bb
similarity index 100%
rename from recipes-devtools/go/go_1.25.6.bb
rename to recipes-devtools/go/go_1.25.7.bb

