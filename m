Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F886C87FCF
	for <webhook@archiver.kernel.org>; Mon,  4 Aug 2025 20:59:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.7047.1754341153220512830
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 04 Aug 2025 13:59:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 966011E4D;
	Mon,  4 Aug 2025 13:59:04 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1BC4B3F673;
	Mon,  4 Aug 2025 13:59:11 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH 1/2] core-image-mingw-sdktest: depend on nativedk-dbus-tools, not -dbus
Date: Mon,  4 Aug 2025 21:59:05 +0100
Message-ID: <20250804205906.301610-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 Aug 2025 20:59:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1884

The dbus package is the bus daemon itself, which doesn't make a lot of
sense in the context of the host component of a SDK. From "dbus: add
message-bus PACKAGECONFIG" in oe-core, nativesdk builds of dbus won't
build the bus at all.

Instead, change the dependency in this recipe to nativedk-dbus-tools,
which are marginally more useful in a SDK context and still exercise
the building of the recipe.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 recipes-core/images/core-image-mingw-sdktest.bb | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/recipes-core/images/core-image-mingw-sdktest.bb b/recipes-co=
re/images/core-image-mingw-sdktest.bb
index 9060c3d..d734031 100644
--- a/recipes-core/images/core-image-mingw-sdktest.bb
+++ b/recipes-core/images/core-image-mingw-sdktest.bb
@@ -7,11 +7,10 @@ require ${COREBASE}/meta/recipes-core/images/core-image=
-minimal.bb
 # to include them
 TOOLCHAIN_HOST_TASK +=3D "\
     nativesdk-curl \
-    nativesdk-dbus \
+    nativesdk-dbus-tools \
     nativesdk-dtc \
     nativesdk-libarchive \
     nativesdk-ninja \
     nativesdk-swig \
     nativesdk-wayland \
     "
-
--=20
2.43.0


