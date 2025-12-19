Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B2D74960
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 07:01:47 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11972.1766127697625378647
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Dec 2025 23:01:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nXY2tM4a;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88a2fe9e200so11717336d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 23:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766127696; x=1766732496; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9B8rq6Gy+B8QaIxdkejj/ZTr+3rsaxwAn2im5fV8vyI=;
        b=nXY2tM4aAXLiN64QDLxDPtflFkeRXwn6Y3zkfBQIKXXYrOcitBheSP+8cItZXPgMYd
         G0gdUrj4D5qoMt/WqYX2GBZ8Cr8QIzuypPWrR2SfIKeMV/VyNLtAsIfUyejlZeKUeugO
         sLOZsIilhIF2oX/oHp9u03WPB5YOwTouyjnxykhQvM23/FEosUeKX5OiaU4TF0D28YWb
         SrRUCxEC/g0CiGbBa8UtmGyQGVyMrDGD4+YoIa0q7oooetAzDORoNwVz/sKshJhPdBdU
         xa2jMRH1fHP/lHF/knJvJ0C7C3+UUb8p0Y8isEyzIoN7qvGHHmZyDeXiOSQUq8+ylp2+
         lAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766127696; x=1766732496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9B8rq6Gy+B8QaIxdkejj/ZTr+3rsaxwAn2im5fV8vyI=;
        b=jEUbyEyl+vOvYhGQGoDiaTd+Cr/UdjJbVBhbTos2E3526Z83sZqoLhQmdqnlRX01uf
         4vRjQJADuoRMM2POr7KI4+XxgiTxhL/e7iDzR9n46WRTZX6x1dlGK8HoI5azc2AqFvAq
         U+bud2evTrkw4LAEU0FKlklX9w4bn2Yp1L6GmK9tAPLSaD+krmvvsHWdzgRtjbTJE53d
         bpMH4BQhzInL32uLmeBCaRMMA1fnQh3LCqTpehAXJiUDet9glSspCuKi20CJDPzxRxD7
         qOSFXp4/lgjxnVYZ/Bu6MsKAUkpcHRrPX8kBE4Ck8xFn2JjTVTmFu2nsSdqqu0bwgn00
         40OA==
X-Gm-Message-State: AOJu0YzBLPHmP9Yf39LhomB+Vn+5gq2W+aXg5wOfSrGh2fkLAqZF3qm0
	dFwrdAwurrzmKwsZ9WdsEDYj9i8u95x44tMQVWJ5ZHaftLnd6MTR0ghl7RbZxw==
X-Gm-Gg: AY/fxX72m0hXd++ROqcSdXUyMI+ehJeNwE1DkrWIUQzj63VRbFOqCKxkGz2fvtLkf82
	MXKLNdKVzXwY3cI1Lg4ez6Udg8TOpwj/0168ovUrvEDl8Tt6u5KEgegV0GtdtFnuadDYsLHpPK1
	G6Ei1A77rLPdyUuqzsME9jy9Q02rXna+IAHeoDJ+6pGq0x6L5faqNwA8q8c7vmA168vu+NDB9qe
	/GWmgSUmw79xDW03tpzMTFIXnZkCvCwg5Pu7qXoR//opHgpQc105YOmRkg6Qf7eRPMmdyD+5Zlr
	gmO52YYsUmDDnxf92WA5B4loTQwKnxMhZCBibD1089pfc9KYhIqCU55HtFmsloeOsGBUiTywuA7
	szVC5yC61d6fPlfi/JU0QhNA7x20bCO2rZm70efB65Kk+tnt5tqJpmITZ9F7l8G9rieOBRjjdoJ
	XNAsUOVVP4Y5kN/O+oIui37RLoU+aT+QaDhFqQIg==
X-Google-Smtp-Source: AGHT+IGu1wMkY90XaQnH/LbwsUFRK5OHlzFONW7TwnRIZvZ88hjORrftACFPfJ0QlCk+eZkW15hYHw==
X-Received: by 2002:a05:6214:540f:b0:882:401c:e391 with SMTP id 6a1803df08f44-88d83f53531mr35743126d6.57.1766127695657;
        Thu, 18 Dec 2025 23:01:35 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7d5f4sm13570166d6.40.2025.12.18.23.01.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 23:01:34 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 3/5] move KERNEL_FEATURES
Date: Fri, 19 Dec 2025 02:00:12 -0500
Message-ID: <20251219070014.39432-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
In-Reply-To: <20251219070014.39432-1-twoerner@gmail.com>
References: <20251219070014.39432-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 07:01:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2825

Move KERNEL_FEATURES from SoC configurations to linux kernel recipes.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 conf/machine/include/rk3066.inc         | 1 -
 conf/machine/include/rk3188.inc         | 1 -
 conf/machine/include/rk3288.inc         | 1 -
 conf/machine/include/rk3308.inc         | 1 -
 conf/machine/include/rk3328.inc         | 1 -
 conf/machine/include/rk3399.inc         | 1 -
 conf/machine/include/rk3566.inc         | 1 -
 conf/machine/include/rk3568.inc         | 1 -
 conf/machine/include/rk3588s.inc        | 1 -
 recipes-kernel/linux/linux-rockchip.inc | 3 +++
 10 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/conf/machine/include/rk3066.inc b/conf/machine/include/rk3066.inc
index 2829a68431a8..fdca5770cc60 100644
--- a/conf/machine/include/rk3066.inc
+++ b/conf/machine/include/rk3066.inc
@@ -11,6 +11,5 @@ require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 SERIAL_CONSOLES = "115200;ttyS2"
 
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
-KERNEL_FEATURES:append:rk3066 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3188.inc b/conf/machine/include/rk3188.inc
index 1af745524bfa..102726f59e28 100644
--- a/conf/machine/include/rk3188.inc
+++ b/conf/machine/include/rk3188.inc
@@ -11,6 +11,5 @@ require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 SERIAL_CONSOLES = "115200;ttyFIQ0"
 
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
-KERNEL_FEATURES:append:rk3188 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
index 00cc04bc6378..8886beafaa4b 100644
--- a/conf/machine/include/rk3288.inc
+++ b/conf/machine/include/rk3288.inc
@@ -11,7 +11,6 @@ require conf/machine/include/arm/armv7a/tune-cortexa17.inc
 SERIAL_CONSOLES = "115200;ttyS2"
 
 KBUILD_DEFCONFIG ?= "multi_v7_defconfig"
-KERNEL_FEATURES:append:rk3288 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 
 # Set UBOOT_SUFFIX to "itb" if you are going to use OP-TEE
 UBOOT_SUFFIX ?= "img"
diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
index 6876564fbcb2..59007ceb0f8d 100644
--- a/conf/machine/include/rk3308.inc
+++ b/conf/machine/include/rk3308.inc
@@ -12,7 +12,6 @@ require conf/machine/include/rockchip-wic.inc
 SERIAL_CONSOLES = "1500000;ttyS0"
 
 KBUILD_DEFCONFIG ?= "defconfig"
-KERNEL_FEATURES:append:rk3308 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
index 2fe2710399b1..34a61096cb3c 100644
--- a/conf/machine/include/rk3328.inc
+++ b/conf/machine/include/rk3328.inc
@@ -11,7 +11,6 @@ require conf/machine/include/arm/armv8a/tune-cortexa53.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
-KERNEL_FEATURES:append:rk3328 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
 
 TFA_PLATFORM = "rk3328"
 TFA_BUILD_TARGET = "bl31"
diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
index 8d30cf7e460b..166db7b80059 100644
--- a/conf/machine/include/rk3399.inc
+++ b/conf/machine/include/rk3399.inc
@@ -11,7 +11,6 @@ require conf/machine/include/arm/armv8a/tune-cortexa72-cortexa53.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
-KERNEL_FEATURES:append:rk3399 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
 
 TFA_PLATFORM = "rk3399"
 TFA_BUILD_TARGET = "bl31"
diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
index 5b65ad7d4a47..f6bf5c37d60e 100644
--- a/conf/machine/include/rk3566.inc
+++ b/conf/machine/include/rk3566.inc
@@ -10,7 +10,6 @@ require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
-KERNEL_FEATURES:append:rk3566 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
 
 PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
 PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
index ad3952de074c..050110892f46 100644
--- a/conf/machine/include/rk3568.inc
+++ b/conf/machine/include/rk3568.inc
@@ -10,7 +10,6 @@ require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
-KERNEL_FEATURES:append:rk3568 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
 
 PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
 PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index 203b97c6353c..18c2fb2ecef8 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -9,7 +9,6 @@ require conf/machine/include/arm/armv8-2a/tune-cortexa76-cortexa55.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
-KERNEL_FEATURES:append:rk3588s = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
 
 PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
 PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
index a648ecb20679..6c62e849834c 100644
--- a/recipes-kernel/linux/linux-rockchip.inc
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -33,3 +33,6 @@ COMPATIBLE_MACHINE:soquartz = "soquartz"
 
 SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
 SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
+
+KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
+KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-- 
2.50.0.173.g8b6f19ccfc3a


