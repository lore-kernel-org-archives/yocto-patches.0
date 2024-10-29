Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57764D3A692
	for <webhook@archiver.kernel.org>; Tue, 29 Oct 2024 19:17:44 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.2438.1730229459907045252
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Oct 2024 12:17:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=b+ZwZVLS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-202410291917361d6b2c63e1c71cf5dc-j30vlk@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202410291917361d6b2c63e1c71cf5dc
        for <yocto-patches@lists.yoctoproject.org>;
        Tue, 29 Oct 2024 20:17:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=d3LMJ1KM2vzKFg99l+aL3ga+UYuR5aTTbvrYoham8Os=;
 b=b+ZwZVLSP9ilf2H/rRtQY/DvwNhBFegZKGSUvQVL49/Ihf3axJRg6B82nTIeDmdJC2Nbcj
 ac39UbWQxXcNrOVxTjWmoHSHBIcAeO3DKQFhwxosTy0v/xAoLmLlhQ2t6DfpQUvMc25M43lh
 7mlD9hde5Jfp92FkGGCclcyqjhGSbx3lf6dBC9TZsjFltLKsj9LJjkqMm9nJxLZyUYb0yKPh
 ewgADY4hfekjOFqzR1h3CPC8nOKPb4eDHgNx1AHCBV9Hjz+pG/EwgzE0BV2OXoXsN4QEtYh/
 o+PjUpkkspU5DGrl2G2VVQot85FMeqL67MYR1KUBD8ymoW1cy/RIsCfg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [meta-lts-mixins][kirkstone/go][PATCH 1/2] go: upgrade 1.22.6 -> 1.22.7
Date: Tue, 29 Oct 2024 20:16:41 +0100
Message-Id: <20241029191642.38027-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Oct 2024 19:17:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/770

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.22.x release [1]:

$ git --no-pager log --oneline go1.22.6..go1.22.7
7529d09a11 (tag: go1.22.7) [release-branch.go1.22] go1.22.7
d4c53812e6 [release-branch.go1.22] go/build/constraint: add parsing limits
2092294f2b [release-branch.go1.22] encoding/gob: cover missed cases when checking ignore depth
b232596139 [release-branch.go1.22] go/parser: track depth in nested element lists
e87be9833e [release-branch.go1.22] runtime: on AIX, fix call to _cgo_sys_thread_create in _rt0_ppc64_aix_lib
676d6100d8 [release-branch.go1.22] cmd/fix: support go versions with patch release
0a525a3ed0 [release-branch.go1.22] os: fix Chtimes test flakes

Fixes CVE-2024-34155, CVE-2024-34156 and CVE-2024-34158

[1] https://github.com/golang/go/compare/go1.22.6...go1.22.7

(From OE-Core rev: 92d609c49c0870ca10fcc39d52a801109d65a98b)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/{go-1.22.6.inc => go-1.22.7.inc}        | 2 +-
 ...o-binary-native_1.22.6.bb => go-binary-native_1.22.7.bb} | 6 +++---
 ...cross-canadian_1.22.6.bb => go-cross-canadian_1.22.7.bb} | 0
 .../go/{go-cross_1.22.6.bb => go-cross_1.22.7.bb}           | 0
 .../go/{go-crosssdk_1.22.6.bb => go-crosssdk_1.22.7.bb}     | 0
 .../go/{go-runtime_1.22.6.bb => go-runtime_1.22.7.bb}       | 0
 recipes-devtools/go/{go_1.22.6.bb => go_1.22.7.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.22.6.inc => go-1.22.7.inc} (89%)
 rename recipes-devtools/go/{go-binary-native_1.22.6.bb => go-binary-native_1.22.7.bb} (78%)
 rename recipes-devtools/go/{go-cross-canadian_1.22.6.bb => go-cross-canadian_1.22.7.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.22.6.bb => go-cross_1.22.7.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.22.6.bb => go-crosssdk_1.22.7.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.22.6.bb => go-runtime_1.22.7.bb} (100%)
 rename recipes-devtools/go/{go_1.22.6.bb => go_1.22.7.bb} (100%)

diff --git a/recipes-devtools/go/go-1.22.6.inc b/recipes-devtools/go/go-1.22.7.inc
similarity index 89%
rename from recipes-devtools/go/go-1.22.6.inc
rename to recipes-devtools/go/go-1.22.7.inc
index 834deba..e54a902 100644
--- a/recipes-devtools/go/go-1.22.6.inc
+++ b/recipes-devtools/go/go-1.22.7.inc
@@ -15,4 +15,4 @@ SRC_URI += "\
     file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
 "
-SRC_URI[main.sha256sum] = "9e48d99d519882579917d8189c17e98c373ce25abaebb98772e2927088992a51"
+SRC_URI[main.sha256sum] = "66432d87d85e0cfac3edffe637d5930fc4ddf5793313fe11e4a0f333023c879f"
diff --git a/recipes-devtools/go/go-binary-native_1.22.6.bb b/recipes-devtools/go/go-binary-native_1.22.7.bb
similarity index 78%
rename from recipes-devtools/go/go-binary-native_1.22.6.bb
rename to recipes-devtools/go/go-binary-native_1.22.7.bb
index ea4577f..aba317f 100644
--- a/recipes-devtools/go/go-binary-native_1.22.6.bb
+++ b/recipes-devtools/go/go-binary-native_1.22.7.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "999805bed7d9039ec3da1a53bfbcafc13e367da52aa823cb60b68ba22d44c616"
-SRC_URI[go_linux_arm64.sha256sum] = "c15fa895341b8eaf7f219fada25c36a610eb042985dc1a912410c1c90098eaf2"
-SRC_URI[go_linux_ppc64le.sha256sum] = "9d99fce3f6f72a76630fe91ec0884dfe3db828def4713368424900fa98bb2bd6"
+SRC_URI[go_linux_amd64.sha256sum] = "fc5d49b7a5035f1f1b265c17aa86e9819e6dc9af8260ad61430ee7fbe27881bb"
+SRC_URI[go_linux_arm64.sha256sum] = "ed695684438facbd7e0f286c30b7bc2411cfc605516d8127dc25c62fe5b03885"
+SRC_URI[go_linux_ppc64le.sha256sum] = "a6441d5da40a961039ec22b0aadbc8b513f52b31bb8919c359a7e2c3c5bcf26a"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.22.6.bb b/recipes-devtools/go/go-cross-canadian_1.22.7.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.22.6.bb
rename to recipes-devtools/go/go-cross-canadian_1.22.7.bb
diff --git a/recipes-devtools/go/go-cross_1.22.6.bb b/recipes-devtools/go/go-cross_1.22.7.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.22.6.bb
rename to recipes-devtools/go/go-cross_1.22.7.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.22.6.bb b/recipes-devtools/go/go-crosssdk_1.22.7.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.22.6.bb
rename to recipes-devtools/go/go-crosssdk_1.22.7.bb
diff --git a/recipes-devtools/go/go-runtime_1.22.6.bb b/recipes-devtools/go/go-runtime_1.22.7.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.22.6.bb
rename to recipes-devtools/go/go-runtime_1.22.7.bb
diff --git a/recipes-devtools/go/go_1.22.6.bb b/recipes-devtools/go/go_1.22.7.bb
similarity index 100%
rename from recipes-devtools/go/go_1.22.6.bb
rename to recipes-devtools/go/go_1.22.7.bb
-- 
2.30.2


