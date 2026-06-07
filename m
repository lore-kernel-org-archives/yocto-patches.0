Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBBCCD8C8C
	for <webhook@archiver.kernel.org>; Sun,  7 Jun 2026 19:30:49 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39330.1780860641535823634
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 07 Jun 2026 12:30:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=J8jwKkEE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-20260607193039b68d76791a000207b0-7n_cwh@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260607193039b68d76791a000207b0
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 07 Jun 2026 21:30:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=08PTsmFHbWGfE79KWTBEZsaA0LuzRHPOKLNMkKRrQu8=;
 b=J8jwKkEEk4nLJrmZ3uKxZde4nXcIzv218LKKghu0LtwfINodi+UrcEFLe/EcQLhGT3IqQW
 K5ZmunbEchtRr0IXBDcN1O0lbCsgV6QABNrL6B+Cm2ONHHOcVEEItFqFyO3Eedl8beYZJuMd
 mQmoWtPcxQjSUPJumzylO5RRXmdwuLt4vH4ShImHSPszoTj5dIFK9AQmEsCDIanUJHgLrMuQ
 2Efti6SaSAmPnv4JGOFu72pLWbZsHgqcmcQWVw3ivh+RyNAReKSwq0vSMVBuR+0osHFvf0W1
 tJG+LocbCrGHCjefDeXsCider4eFp8nyO/adTGZSJxX81vzWvC9LX37A==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 4/4] go: upgrade 1.26.3 -> 1.26.4
Date: Sun,  7 Jun 2026 21:29:34 +0200
Message-ID: <20260607192934.156036-4-peter.marko@siemens.com>
In-Reply-To: <20260607192934.156036-1-peter.marko@siemens.com>
References: <20260607192934.156036-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 07 Jun 2026 19:30:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4173

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.26.x release [1]:

$ git --no-pager log --oneline go1.26.3..go1.26.4
a9ce111d58 (tag: go1.26.4) [release-branch.go1.26] go1.26.4
babc19e1ad [release-branch.go1.26] cmd/compile: do not misscompile x+x << 63 to x << 0 on amd64
7d24489b2b [release-branch.go1.26] runtime/race: build race detector linux/arm64 syso with no-outline-atomics
ce5a3e718c [release-branch.go1.26] crypto/x509: split candidate hostname only once
ec1c380418 [release-branch.go1.26] net/textproto: escape arbitrary input when including them in errors
7f24db453a [release-branch.go1.26] mime: avoid quadratic complexity in WordDecoder.DecodeHeader
ccffd99f3c [release-branch.go1.26] cmd/fix: pull in CL 783960
26c2ac5f94 [release-branch.go1.26] crypto/internal/fips140/drbg: fix Wasm stub

Fixes CVE-2026-42504, CVE-2026-42507 and CVE-2026-27145.

Release information: [2]

[1] https://github.com/golang/go/compare/go1.26.3...go1.26.4
[2] https://groups.google.com/g/golang-announce/c/tKs3rmcBcKw

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/{go-1.26.3.inc => go-1.26.4.inc}        | 2 +-
 ...o-binary-native_1.26.3.bb => go-binary-native_1.26.4.bb} | 6 +++---
 ...cross-canadian_1.26.3.bb => go-cross-canadian_1.26.4.bb} | 0
 .../go/{go-cross_1.26.3.bb => go-cross_1.26.4.bb}           | 0
 .../go/{go-crosssdk_1.26.3.bb => go-crosssdk_1.26.4.bb}     | 0
 .../go/{go-runtime_1.26.3.bb => go-runtime_1.26.4.bb}       | 0
 recipes-devtools/go/{go_1.26.3.bb => go_1.26.4.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.26.3.inc => go-1.26.4.inc} (90%)
 rename recipes-devtools/go/{go-binary-native_1.26.3.bb => go-binary-native_1.26.4.bb} (80%)
 rename recipes-devtools/go/{go-cross-canadian_1.26.3.bb => go-cross-canadian_1.26.4.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.26.3.bb => go-cross_1.26.4.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.26.3.bb => go-crosssdk_1.26.4.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.26.3.bb => go-runtime_1.26.4.bb} (100%)
 rename recipes-devtools/go/{go_1.26.3.bb => go_1.26.4.bb} (100%)

diff --git a/recipes-devtools/go/go-1.26.3.inc b/recipes-devtools/go/go-1.26.4.inc
similarity index 90%
rename from recipes-devtools/go/go-1.26.3.inc
rename to recipes-devtools/go/go-1.26.4.inc
index db7b18e..8bc6f4d 100644
--- a/recipes-devtools/go/go-1.26.3.inc
+++ b/recipes-devtools/go/go-1.26.4.inc
@@ -16,4 +16,4 @@ SRC_URI += "\
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
 "
-SRC_URI[main.sha256sum] = "1c646875d0aa8799133184ed57cf79ff24bdefe8c8820470602a9d3d6d9192b8"
+SRC_URI[main.sha256sum] = "4f668a32fbfc1132e6a881fb968c2f1dada631492a339211735fbb255a42602d"
diff --git a/recipes-devtools/go/go-binary-native_1.26.3.bb b/recipes-devtools/go/go-binary-native_1.26.4.bb
similarity index 80%
rename from recipes-devtools/go/go-binary-native_1.26.3.bb
rename to recipes-devtools/go/go-binary-native_1.26.4.bb
index 8c51339..489ea0c 100644
--- a/recipes-devtools/go/go-binary-native_1.26.3.bb
+++ b/recipes-devtools/go/go-binary-native_1.26.4.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "2b2cfc7148493da5e73981bffbf3353af381d5f93e789c82c79aff64962eb556"
-SRC_URI[go_linux_arm64.sha256sum] = "9d89a3ea57d141c2b22d70083f2c8459ba3890f2d9e818e7e933b75614936565"
-SRC_URI[go_linux_ppc64le.sha256sum] = "dbd82b50530ead2beb1fd72215117380df3cb16332b51467116dc35b3691dd75"
+SRC_URI[go_linux_amd64.sha256sum] = "1153d3d50e0ac764b447adfe05c2bcf08e889d42a02e0fe0259bd47f6733ad7f"
+SRC_URI[go_linux_arm64.sha256sum] = "ef758ae7c6cf9267c9c0ef080b8965f453d89ab2d25d9eb22de4405925238768"
+SRC_URI[go_linux_ppc64le.sha256sum] = "53f49b8c7eace2d30389327b4a516b13321f90377fdf5929a6b63174609bc22e"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.26.3.bb b/recipes-devtools/go/go-cross-canadian_1.26.4.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.26.3.bb
rename to recipes-devtools/go/go-cross-canadian_1.26.4.bb
diff --git a/recipes-devtools/go/go-cross_1.26.3.bb b/recipes-devtools/go/go-cross_1.26.4.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.26.3.bb
rename to recipes-devtools/go/go-cross_1.26.4.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.26.3.bb b/recipes-devtools/go/go-crosssdk_1.26.4.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.26.3.bb
rename to recipes-devtools/go/go-crosssdk_1.26.4.bb
diff --git a/recipes-devtools/go/go-runtime_1.26.3.bb b/recipes-devtools/go/go-runtime_1.26.4.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.26.3.bb
rename to recipes-devtools/go/go-runtime_1.26.4.bb
diff --git a/recipes-devtools/go/go_1.26.3.bb b/recipes-devtools/go/go_1.26.4.bb
similarity index 100%
rename from recipes-devtools/go/go_1.26.3.bb
rename to recipes-devtools/go/go_1.26.4.bb

