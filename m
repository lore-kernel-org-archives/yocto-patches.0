Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFDFC88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:14:32 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5868.1789413262584726876
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 12:14:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=d5wZ3Alh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20260914191420b37d5290c500020721-2knfvz@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260914191420b37d5290c500020721
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 14 Sep 2026 21:14:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=t6aptl2aSUJl4ppa0qf60bNVPYj+EjSCK/DcruwukoY=;
 b=d5wZ3Alhq+SUll/ltC5eC+7eixT4W4p+oY2q1kxqtoUVpli42bXLlyqoeCgG/bkfIT44v2
 nEFo20rLVPHR5huFMK8SSnHOE684kaZ5XTlRR2TLqGUMQw8HpVz2OtNWd/lSL5PqTOYlrd2m
 XE6jEJXw0UirswQkqznRUmui376m1lgeYNu0uGcwQ5UIaYUSW3W1klC+d7b/2KBO6gZ1azW7
 3EjBjIHN+RmlaIgEsSwf7/zwTzQavOyPySe8raTJHl3u38cGMtqob5nw7ac2f9DtzNvKBUof
 2dKiZlc15/IHxegmpPm7giUwEvwJp4mr64XDtwUdEn6j7rwKEUZwUO7A==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][wrynose/go][PATCH 09/11] go: upgrade 1.26.7 -> 1.27.0
Date: Mon, 14 Sep 2026 21:12:38 +0200
Message-ID: <20260914191240.1066469-9-peter.marko@siemens.com>
In-Reply-To: <20260914191240.1066469-1-peter.marko@siemens.com>
References: <20260914191240.1066469-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 19:14:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4836

From: Yash Shinde <Yash.Shinde.oss.dev@gmail.com>

Release information:

https://groups.google.com/g/golang-announce/c/8gcPInd8SQE
https://go.dev/doc/go1.27

Signed-off-by: Yash Shinde <Yash.Shinde.oss.dev@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
(From OE-Core rev: a0723b756582036eb0ce9a52ef0edc002c864cc9)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/{go-1.26.7.inc => go-1.27.0.inc}        | 2 +-
 ...o-binary-native_1.26.7.bb => go-binary-native_1.27.0.bb} | 6 +++---
 ...cross-canadian_1.26.7.bb => go-cross-canadian_1.27.0.bb} | 0
 .../go/{go-cross_1.26.7.bb => go-cross_1.27.0.bb}           | 0
 .../go/{go-crosssdk_1.26.7.bb => go-crosssdk_1.27.0.bb}     | 0
 .../go/{go-runtime_1.26.7.bb => go-runtime_1.27.0.bb}       | 0
 recipes-devtools/go/{go_1.26.7.bb => go_1.27.0.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.26.7.inc => go-1.27.0.inc} (90%)
 rename recipes-devtools/go/{go-binary-native_1.26.7.bb => go-binary-native_1.27.0.bb} (80%)
 rename recipes-devtools/go/{go-cross-canadian_1.26.7.bb => go-cross-canadian_1.27.0.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.26.7.bb => go-cross_1.27.0.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.26.7.bb => go-crosssdk_1.27.0.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.26.7.bb => go-runtime_1.27.0.bb} (100%)
 rename recipes-devtools/go/{go_1.26.7.bb => go_1.27.0.bb} (100%)

diff --git a/recipes-devtools/go/go-1.26.7.inc b/recipes-devtools/go/go-1.27.0.inc
similarity index 90%
rename from recipes-devtools/go/go-1.26.7.inc
rename to recipes-devtools/go/go-1.27.0.inc
index fed8701..4162a2b 100644
--- a/recipes-devtools/go/go-1.26.7.inc
+++ b/recipes-devtools/go/go-1.27.0.inc
@@ -16,4 +16,4 @@ SRC_URI += "\
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
 "
-SRC_URI[main.sha256sum] = "0ed24eac755105085b89fe9cabc2742b91a0ad7b94b59d3ad364918ebc8956ad"
+SRC_URI[main.sha256sum] = "7002403d7cc44529ef6d26f69a44818263395ead7c16c05a5808ae047ebeb0e5"
diff --git a/recipes-devtools/go/go-binary-native_1.26.7.bb b/recipes-devtools/go/go-binary-native_1.27.0.bb
similarity index 80%
rename from recipes-devtools/go/go-binary-native_1.26.7.bb
rename to recipes-devtools/go/go-binary-native_1.27.0.bb
index 034c051..0f6c3bc 100644
--- a/recipes-devtools/go/go-binary-native_1.26.7.bb
+++ b/recipes-devtools/go/go-binary-native_1.27.0.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "ffb5f8de10c62550dfddab66b36b57030721e0a44a3218e9e1181d7b59f121ca"
-SRC_URI[go_linux_arm64.sha256sum] = "5a4ec883379d51ee9ce1040d5e87f8d35e20387574dd8c947feb01eabc3c1b37"
-SRC_URI[go_linux_ppc64le.sha256sum] = "22d3b362d557175fd16b79651cab0cad64f8aaaedca745f66d16f44d56bc5de1"
+SRC_URI[go_linux_amd64.sha256sum] = "675c26c449cbb18fc24b74650de1eabbae6e16f64326fd85a283fb3b58280685"
+SRC_URI[go_linux_arm64.sha256sum] = "51798d2c42d0e1c6ed7fd9f48728b4193abac9e8aad6dbac2fe96a81f5909bda"
+SRC_URI[go_linux_ppc64le.sha256sum] = "068085e257a6014c036c723ca62943edbf48fd168b8d00a6d39527d10b656255"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.26.7.bb b/recipes-devtools/go/go-cross-canadian_1.27.0.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.26.7.bb
rename to recipes-devtools/go/go-cross-canadian_1.27.0.bb
diff --git a/recipes-devtools/go/go-cross_1.26.7.bb b/recipes-devtools/go/go-cross_1.27.0.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.26.7.bb
rename to recipes-devtools/go/go-cross_1.27.0.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.26.7.bb b/recipes-devtools/go/go-crosssdk_1.27.0.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.26.7.bb
rename to recipes-devtools/go/go-crosssdk_1.27.0.bb
diff --git a/recipes-devtools/go/go-runtime_1.26.7.bb b/recipes-devtools/go/go-runtime_1.27.0.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.26.7.bb
rename to recipes-devtools/go/go-runtime_1.27.0.bb
diff --git a/recipes-devtools/go/go_1.26.7.bb b/recipes-devtools/go/go_1.27.0.bb
similarity index 100%
rename from recipes-devtools/go/go_1.26.7.bb
rename to recipes-devtools/go/go_1.27.0.bb

