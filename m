Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BC3C021A6
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 19:05:23 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.2213.1739473516744614755
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Feb 2025 11:05:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=NTwCSNGw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-202502131905133594e9070e0a761a1e-swscka@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202502131905133594e9070e0a761a1e
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Feb 2025 20:05:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=snBpNViz2y3eozShcdUQL40qaRSmZs3yoRZJh2gm12Q=;
 b=NTwCSNGwYZY38rolh4LDAAwahbRnLoNYlyaWSZkR/0M1o0d/HWT94DRGAAxiOhv/o4ahN1
 QhJ/PmyX9Iic1UZhAmsjY6fd0Ho+XY/BLRaT0GK8SuoXr4p2mgg1UjlUIo1BQpbm9f/TvcpY
 6oWSdXxi3hpHoKwQ1G1MlrFDrrddh62j9avis9S/c9dSplVNioeAkMHf+tFEKW68FPvdz7kT
 QbeLeJabXHZFbTBJkUhm+UjrtObWVrkNA/zbQ5+ornd33cjn8XovqOoyGgfBuP3bR8Q6T/il
 h6iEGpLmCfxnoZY7SYZOP24Hxc23WCyQBAyy6PYTEJzPqtTlpJhshaWQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [meta-mingw][PATCH] grpc: remove obsolete removal of libnsl2 dependency
Date: Thu, 13 Feb 2025 20:04:24 +0100
Message-Id: <20250213190424.1873927-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Feb 2025 19:05:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1081

From: Peter Marko <peter.marko@siemens.com>

This was removed in
https://git.openembedded.org/meta-openembedded/commit/?id=83c6dfcce6c334d9e699858614e902f2a5a41e20

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 .../openembedded-layers/recipes-devtools/grpc/grpc_%.bbappend  | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/dynamic-layers/openembedded-layers/recipes-devtools/grpc/grpc_%.bbappend b/dynamic-layers/openembedded-layers/recipes-devtools/grpc/grpc_%.bbappend
index dc0ea42..a72496d 100644
--- a/dynamic-layers/openembedded-layers/recipes-devtools/grpc/grpc_%.bbappend
+++ b/dynamic-layers/openembedded-layers/recipes-devtools/grpc/grpc_%.bbappend
@@ -1,5 +1,2 @@
-# doesn't build and not required
-DEPENDS:remove:mingw32 = "libnsl2"
-
 EXTRA_OECMAKE:remove:mingw32 = "-DBUILD_SHARED_LIBS=ON"
 EXTRA_OECMAKE:append:mingw32 = " -DBUILD_SHARED_LIBS=OFF"

