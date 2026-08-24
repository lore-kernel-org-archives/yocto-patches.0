Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9B7C5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 18:03:33 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3793.1787594604989471242
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Aug 2026 11:03:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=l/iKsmv2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20260824180321183f84ffb200020781-tj774x@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260824180321183f84ffb200020781
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 24 Aug 2026 20:03:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=t0Pfy7WkSfxMR6s1OpWK5CZ+VIHg7lRl82LUF91Gn1A=;
 b=l/iKsmv2E7RuMwlNs6YeYDPhy2UJhFK6KsYkp3E4n9j19HfQzSCbWlavDGyH+O1OzEURD8
 qCIeLsoO3MSnvGMiY02aKECy/MKTbb32yPysNNIHw+8AbDY2mk1SwGClYRCOu8RbqAy03+4m
 909n41qMFD/t1rZ/JPrwhsCLXviDldd7UW51KSd+dvZHg6SpYnSoQkI4OHPYkoUQ4G+qi3iQ
 RGVxL7JA3KWxowTUNrsB4RYwc1+TkW8F6T68/Z+vNT2VAZhjaW3fFgw/uVb8NsN8p5JrJ5aN
 JpL3/nKb5I0RalzJsjiQiu+gB/xlORdX30eD8HUKwssN5E272dn6qCZA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.6 -> 1.26.7
Date: Mon, 24 Aug 2026 20:00:49 +0200
Message-ID: <20260824180049.27719-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Aug 2026 18:03:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4684

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.26.x release [1]:

$ git --no-pager log --oneline go1.26.6..go1.26.7
e3336a22ad (tag: go1.26.7) [release-branch.go1.26] go1.26.7
50e5b59e9c [release-branch.go1.26] net/http: clear ReadHeaderTimeout after accepting an unencrypted h2 conn
98e6631a5a [release-branch.go1.26] cmd/internal/moddeps: restore tests

This minor release includes a fix to address a breakage affecting
unencrypted HTTP/2 (h2c) connections caused by a security patch
included in last week’s release. See go.dev/issue/80876 for details.

Release information: [2]

[1] https://github.com/golang/go/compare/go1.26.6...go1.26.7
[2] https://groups.google.com/g/golang-announce/c/qA6Vpj2UA-4

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: e6739374b865cae8d6f105c7a600a52736579c25)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/{go-1.26.6.inc => go-1.26.7.inc}        | 2 +-
 ...o-binary-native_1.26.6.bb => go-binary-native_1.26.7.bb} | 6 +++---
 ...cross-canadian_1.26.6.bb => go-cross-canadian_1.26.7.bb} | 0
 .../go/{go-cross_1.26.6.bb => go-cross_1.26.7.bb}           | 0
 .../go/{go-crosssdk_1.26.6.bb => go-crosssdk_1.26.7.bb}     | 0
 .../go/{go-runtime_1.26.6.bb => go-runtime_1.26.7.bb}       | 0
 recipes-devtools/go/{go_1.26.6.bb => go_1.26.7.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.26.6.inc => go-1.26.7.inc} (90%)
 rename recipes-devtools/go/{go-binary-native_1.26.6.bb => go-binary-native_1.26.7.bb} (80%)
 rename recipes-devtools/go/{go-cross-canadian_1.26.6.bb => go-cross-canadian_1.26.7.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.26.6.bb => go-cross_1.26.7.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.26.6.bb => go-crosssdk_1.26.7.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.26.6.bb => go-runtime_1.26.7.bb} (100%)
 rename recipes-devtools/go/{go_1.26.6.bb => go_1.26.7.bb} (100%)

diff --git a/recipes-devtools/go/go-1.26.6.inc b/recipes-devtools/go/go-1.26.7.inc
similarity index 90%
rename from recipes-devtools/go/go-1.26.6.inc
rename to recipes-devtools/go/go-1.26.7.inc
index fa6b0a5..fed8701 100644
--- a/recipes-devtools/go/go-1.26.6.inc
+++ b/recipes-devtools/go/go-1.26.7.inc
@@ -16,4 +16,4 @@ SRC_URI += "\
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
 "
-SRC_URI[main.sha256sum] = "a0721c54c688901448d77ad9b3ec7ea7c474730755ff891382e92ecb93ff2cb1"
+SRC_URI[main.sha256sum] = "0ed24eac755105085b89fe9cabc2742b91a0ad7b94b59d3ad364918ebc8956ad"
diff --git a/recipes-devtools/go/go-binary-native_1.26.6.bb b/recipes-devtools/go/go-binary-native_1.26.7.bb
similarity index 80%
rename from recipes-devtools/go/go-binary-native_1.26.6.bb
rename to recipes-devtools/go/go-binary-native_1.26.7.bb
index c3e9eb1..380b446 100644
--- a/recipes-devtools/go/go-binary-native_1.26.6.bb
+++ b/recipes-devtools/go/go-binary-native_1.26.7.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "708effb774be8237570d0add163225abbdfaf4fca28b2611df167beba4feef89"
-SRC_URI[go_linux_arm64.sha256sum] = "d0507e9e9d7fe012aae570108cbd76c15de879e17130ab8cb90d4d7445cb1f2e"
-SRC_URI[go_linux_ppc64le.sha256sum] = "232b65543a42eda95df6a63f76235c1795bb535eba5c74e509faec71bc648388"
+SRC_URI[go_linux_amd64.sha256sum] = "ffb5f8de10c62550dfddab66b36b57030721e0a44a3218e9e1181d7b59f121ca"
+SRC_URI[go_linux_arm64.sha256sum] = "5a4ec883379d51ee9ce1040d5e87f8d35e20387574dd8c947feb01eabc3c1b37"
+SRC_URI[go_linux_ppc64le.sha256sum] = "22d3b362d557175fd16b79651cab0cad64f8aaaedca745f66d16f44d56bc5de1"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.26.6.bb b/recipes-devtools/go/go-cross-canadian_1.26.7.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.26.6.bb
rename to recipes-devtools/go/go-cross-canadian_1.26.7.bb
diff --git a/recipes-devtools/go/go-cross_1.26.6.bb b/recipes-devtools/go/go-cross_1.26.7.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.26.6.bb
rename to recipes-devtools/go/go-cross_1.26.7.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.26.6.bb b/recipes-devtools/go/go-crosssdk_1.26.7.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.26.6.bb
rename to recipes-devtools/go/go-crosssdk_1.26.7.bb
diff --git a/recipes-devtools/go/go-runtime_1.26.6.bb b/recipes-devtools/go/go-runtime_1.26.7.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.26.6.bb
rename to recipes-devtools/go/go-runtime_1.26.7.bb
diff --git a/recipes-devtools/go/go_1.26.6.bb b/recipes-devtools/go/go_1.26.7.bb
similarity index 100%
rename from recipes-devtools/go/go_1.26.6.bb
rename to recipes-devtools/go/go_1.26.7.bb

