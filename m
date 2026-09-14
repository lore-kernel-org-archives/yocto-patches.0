Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88BAC88E6F
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:14:52 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5875.1789413287866440029
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 12:14:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=b5pPTLIP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-20260914191445466ce05f1e0002072f-pv6qee@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260914191445466ce05f1e0002072f
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 14 Sep 2026 21:14:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oe+pQZbQ7ZIwZp86vKAa69XiPgiensKJHyxLcoqiaKI=;
 b=b5pPTLIPgjCGj7wtMML8LkiJmyyNe/lStnigkoae+s+RYQOsS4KvP9vvre3GZRtSaw63lq
 /p5UxlGC0OTfZi53TCS6DhaTmRGoNoCKs7Mc+4akq7QyeUvjaF+R4ql3FgJRb7sxEzVjjiKc
 e3lzKhfKASSMZGthBRG4emTiEiXu++beLZP3KXR8PxDF2L48WcDwUnydZQqZT+RoIklK2vNk
 0FXthEoiR1c/x3peHT1/Yc0n0GeLhtaAWO6HhLW9gX0tBqv/rMUxekMMSmtJe42NpFeKZTHR
 MLe1/vGmhy4aysMMIdLPeD4qf5fG2Dxn/24MhG99XHFlHOoWN0N4I+MA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][wrynose/go][PATCH 11/11] go-binary-native: upgrade 1.27.0 -> 1.27.1
Date: Mon, 14 Sep 2026 21:12:40 +0200
Message-ID: <20260914191240.1066469-11-peter.marko@siemens.com>
In-Reply-To: <20260914191240.1066469-1-peter.marko@siemens.com>
References: <20260914191240.1066469-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 19:14:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4838

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
(From OE-Core rev: 7443260986a9bb25c1a1c188fd3d1e78ccd0f445)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 ...o-binary-native_1.27.0.bb => go-binary-native_1.27.1.bb} | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename recipes-devtools/go/{go-binary-native_1.27.0.bb => go-binary-native_1.27.1.bb} (80%)

diff --git a/recipes-devtools/go/go-binary-native_1.27.0.bb b/recipes-devtools/go/go-binary-native_1.27.1.bb
similarity index 80%
rename from recipes-devtools/go/go-binary-native_1.27.0.bb
rename to recipes-devtools/go/go-binary-native_1.27.1.bb
index 0f6c3bc..f909581 100644
--- a/recipes-devtools/go/go-binary-native_1.27.0.bb
+++ b/recipes-devtools/go/go-binary-native_1.27.1.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "675c26c449cbb18fc24b74650de1eabbae6e16f64326fd85a283fb3b58280685"
-SRC_URI[go_linux_arm64.sha256sum] = "51798d2c42d0e1c6ed7fd9f48728b4193abac9e8aad6dbac2fe96a81f5909bda"
-SRC_URI[go_linux_ppc64le.sha256sum] = "068085e257a6014c036c723ca62943edbf48fd168b8d00a6d39527d10b656255"
+SRC_URI[go_linux_amd64.sha256sum] = "63d339f0da5ab53635a56f2490a7984dfe12dfcff22ad749f63edaf590168445"
+SRC_URI[go_linux_arm64.sha256sum] = "3450b45a3f9ee8568792736a5c5e70a1f2e9b36c35a8f74958c03e51d7d92bec"
+SRC_URI[go_linux_ppc64le.sha256sum] = "ad1ff83c24f783c2d4a025852b928a05c199e8742a14a5482d88de0293d2bd0d"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"

