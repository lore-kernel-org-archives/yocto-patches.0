Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA16C02194
	for <webhook@archiver.kernel.org>; Tue, 28 Jan 2025 18:49:19 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.4928.1738090157671645190
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Jan 2025 10:49:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=T7QkZzAV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-256628-202501281849149f0bc3a85bcc30bace-xgwlvb@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202501281849149f0bc3a85bcc30bace
        for <yocto-patches@lists.yoctoproject.org>;
        Tue, 28 Jan 2025 19:49:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=vTev749S3iudF9sSK+IN+GfTXNdrEkrh3FnqMhp5IuY=;
 b=T7QkZzAVsSQpQQ6RcX+IwU61yQj40hTHOWZC2YK2rzDddO6UIcq/hHB9qT1EfqUtwTSEyF
 MlAzI/SzRmjkwKFXGRKoq70CP6i+kZm/ZUFdXH1oacNc9qo8cAeNyK3G+oTWwbW97Jr6g3ff
 LO97FLOj+Kq9I1+xhXIzhGMG5zZLCBXEeh2is7sLLhmvBmRItdVVPDvN0bH8uvlfw9cI/8HI
 Q67JvyIguTLfPozJkFtFTvj4PO8djhWTWObkWGARrJ9Nl/ip/ZDEuKH+pZV3QB1HS58BPlY2
 udYrQQvc+Yr7gs7cAddUJpXugbnWK9E6dPTg2S8exEKBOhQf79FUiMHg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][kirkstone/go 1/3] go: upgrade 1.22.8 -> 1.22.9
Date: Tue, 28 Jan 2025 19:48:24 +0100
Message-Id: <20250128184826.1334984-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jan 2025 18:49:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1009

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.22.x release [1]:

$ git --no-pager log --oneline go1.22.8..go1.22.9
8af39d30a4 (tag: go1.22.9) [release-branch.go1.22] go1.22.9
c19e5887f4 [release-branch.go1.22] cmd/cgo/internal/testcarchive: remove 1-minute timeout
e3fd4ba7f9 [release-branch.go1.22] cmd/link: generate Mach-O UUID when -B flag is specified
29252e4c5a [release-branch.go1.22] runtime: fix TestGdbAutotmpTypes on gdb version 15

[1] https://github.com/golang/go/compare/go1.22.8...go1.22.9

(From OE-Core rev: 4f2f202506bcefb4d6c46a11738e159e261a4a4b)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.22.8.inc => go-1.22.9.inc}        | 2 +-
 ...o-binary-native_1.22.8.bb => go-binary-native_1.22.9.bb} | 6 +++---
 ...cross-canadian_1.22.8.bb => go-cross-canadian_1.22.9.bb} | 0
 .../go/{go-cross_1.22.8.bb => go-cross_1.22.9.bb}           | 0
 .../go/{go-crosssdk_1.22.8.bb => go-crosssdk_1.22.9.bb}     | 0
 .../go/{go-runtime_1.22.8.bb => go-runtime_1.22.9.bb}       | 0
 recipes-devtools/go/{go_1.22.8.bb => go_1.22.9.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.22.8.inc => go-1.22.9.inc} (89%)
 rename recipes-devtools/go/{go-binary-native_1.22.8.bb => go-binary-native_1.22.9.bb} (78%)
 rename recipes-devtools/go/{go-cross-canadian_1.22.8.bb => go-cross-canadian_1.22.9.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.22.8.bb => go-cross_1.22.9.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.22.8.bb => go-crosssdk_1.22.9.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.22.8.bb => go-runtime_1.22.9.bb} (100%)
 rename recipes-devtools/go/{go_1.22.8.bb => go_1.22.9.bb} (100%)

diff --git a/recipes-devtools/go/go-1.22.8.inc b/recipes-devtools/go/go-1.22.9.inc
similarity index 89%
rename from recipes-devtools/go/go-1.22.8.inc
rename to recipes-devtools/go/go-1.22.9.inc
index 542519b..8fe2a8e 100644
--- a/recipes-devtools/go/go-1.22.8.inc
+++ b/recipes-devtools/go/go-1.22.9.inc
@@ -15,4 +15,4 @@ SRC_URI += "\
     file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
 "
-SRC_URI[main.sha256sum] = "df12c23ebf19dea0f4bf46a22cbeda4a3eca6f474f318390ce774974278440b8"
+SRC_URI[main.sha256sum] = "e81a362f51aee2125722b018e46714e6a055a1954283414c0f937e737013db22"
diff --git a/recipes-devtools/go/go-binary-native_1.22.8.bb b/recipes-devtools/go/go-binary-native_1.22.9.bb
similarity index 78%
rename from recipes-devtools/go/go-binary-native_1.22.8.bb
rename to recipes-devtools/go/go-binary-native_1.22.9.bb
index 98799eb..040091b 100644
--- a/recipes-devtools/go/go-binary-native_1.22.8.bb
+++ b/recipes-devtools/go/go-binary-native_1.22.9.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "5f467d29fc67c7ae6468cb6ad5b047a274bae8180cac5e0b7ddbfeba3e47e18f"
-SRC_URI[go_linux_arm64.sha256sum] = "5c616b32dab04bb8c4c8700478381daea0174dc70083e4026321163879278a4a"
-SRC_URI[go_linux_ppc64le.sha256sum] = "c546f27866510bf8e54e86fe6f58c705af0e894341e5572c91f197a734152c27"
+SRC_URI[go_linux_amd64.sha256sum] = "84a8f05b7b969d8acfcaf194ce9298ad5d3ddbfc7034930c280006b5c85a574c"
+SRC_URI[go_linux_arm64.sha256sum] = "5beec5ef9f019e1779727ef0d9643fa8bf2495e7222014d2fc4fbfce5999bf01"
+SRC_URI[go_linux_ppc64le.sha256sum] = "dcee55b402eaf46e7ffb2018b9e30b27ae5e821367697d8f8ff1ed1cecfd7948"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.22.8.bb b/recipes-devtools/go/go-cross-canadian_1.22.9.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.22.8.bb
rename to recipes-devtools/go/go-cross-canadian_1.22.9.bb
diff --git a/recipes-devtools/go/go-cross_1.22.8.bb b/recipes-devtools/go/go-cross_1.22.9.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.22.8.bb
rename to recipes-devtools/go/go-cross_1.22.9.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.22.8.bb b/recipes-devtools/go/go-crosssdk_1.22.9.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.22.8.bb
rename to recipes-devtools/go/go-crosssdk_1.22.9.bb
diff --git a/recipes-devtools/go/go-runtime_1.22.8.bb b/recipes-devtools/go/go-runtime_1.22.9.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.22.8.bb
rename to recipes-devtools/go/go-runtime_1.22.9.bb
diff --git a/recipes-devtools/go/go_1.22.8.bb b/recipes-devtools/go/go_1.22.9.bb
similarity index 100%
rename from recipes-devtools/go/go_1.22.8.bb
rename to recipes-devtools/go/go_1.22.9.bb

