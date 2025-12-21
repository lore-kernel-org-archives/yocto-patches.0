Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE8CE67495
	for <webhook@archiver.kernel.org>; Sun, 21 Dec 2025 00:49:00 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51312.1766278131002944800
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 20 Dec 2025 16:48:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KTNI44NT;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-888310b91c5so34017746d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 20 Dec 2025 16:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766278129; x=1766882929; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=da+vCF+pqdBXBDQWII5F4MlcLfZ+w64zKK/Sjyx8cJo=;
        b=KTNI44NT7IY485urxX7ENCV1cFq47nLMq8A4h6eEtWmz+TQZxLXOozcd7BtG1v+pn0
         pXu0d/tkMOkrJqSCTnJIdEjYClOoFG8umxCVbkK24iTHX2JyVi1MyFrSpTeWWoMKqNkG
         E0/GCZDrFXomhoqGAOzydJ53SvyHa0IiILJyN7mNljNMa6pa8sKwsFPKzo+VtpcXzaP2
         HfihbtU1Rv53d/otlOMs3ePZW3ifRpn6ADvsPofP/MRonVjms2yi/u+J2Rjm9/LP7YTP
         GFKVvinWUqcPuGLmyHcfIulw3SmM+xPt0u0cO3JiXo3QcPxnAOFw2B4RowyP8LGJybA4
         xqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766278129; x=1766882929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=da+vCF+pqdBXBDQWII5F4MlcLfZ+w64zKK/Sjyx8cJo=;
        b=IEpbX+ajg5saCxa4jeE8KKaLP4sguf34EKYbzeuV5y9JrWavrnGYGnK+hE935J0zAo
         ohGBalb4e7ThNlSIrTQ3x8OGbScvidbMcav2Ilj7SbpUBBjmqn7oHkoHGZDzxEEejhLV
         tyBKRb3K5dbwjI3nKZv4fF/xNIm4wib882/foI3rSr1kA1I8oy/nC3NA5zFtk9FNZ5JJ
         yAz6jmuYRouiLLYbFWCaBmDeYxRXlHUAbLTQsXMd2mAf4S3JYVTmqeVFr+Fv5Uod8X7o
         I5u8nKQrTEkmoOLKXXD5CWIYUlyjx7pCXp/9+N6FrBeVn/Ea+U2Jbg8OxdG6GYryagvM
         /SZw==
X-Gm-Message-State: AOJu0YwnEWuMXUsZDCil7doGE5ctO6FA+gYRNwnReg1HsM98xVM0LTMM
	OZSnQiigdtPfP5T0188QxOin2kVWfz9sW3Z+BBn1NM6aSze/UoE6NbCM8yUWEg==
X-Gm-Gg: AY/fxX7iir+8TmlqoNKNUoauTU4qrNW+cfTuQ/2n9/KOeLR+P7XqBA28HHkbW03pxb0
	Ci8EdMy6+aPLV4I3mOW/qNeULzk1tdUOH6Go4d4s4BhQUJvNkgxvEpB1iCUFa67ewGf/QvVAEyW
	zVQByxCgGhY43/CEFRGiHREIgU/Z2mQrryoRylIXTQotb8MeRXfDJeqL9q1vJ1irUwHaHu3zTqq
	mKkvi4mbMWAt3e/NNNzbYCQhIQkbufmyMw/RFtKCVYap3t0394sh9r/9MaoTwAYTn/3tCMEJnbP
	W7klel5ZsjuvZ27U3b3WGJtlYkCB3a+u1dT/GeeNoG2WW3cZhE23wjvv/wnpS8Xd6aoMtdFY3PM
	lBn3JhWP3LhJSW0QE5fdGtw7JoKovoK2YZ0p4LRkfaqYSOhTV/ZcaMSOaZ8h2nrv5lB+rUS6+kb
	tyFUnZ6uQHc5U9SWaLUii0M4N7UekmQa1Gzg2dtfkP5ANYyhRu
X-Google-Smtp-Source: AGHT+IGpqNk6I+pE95b7jLPFoCy+/vkoGFPVfV2kiAZj4Hydnbli7KJ7gvUhTypv4SjCa67hSbfEww==
X-Received: by 2002:a05:620a:4096:b0:8a2:d235:8136 with SMTP id af79cd13be357-8c090029d3emr1063253385a.25.1766278129015;
        Sat, 20 Dec 2025 16:48:49 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f0807sm511867385a.41.2025.12.20.16.48.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 16:48:47 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 3/5] move KERNEL_FEATURES
Date: Sat, 20 Dec 2025 19:48:41 -0500
Message-ID: <20251221004843.31946-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
In-Reply-To: <20251221004843.31946-1-twoerner@gmail.com>
References: <20251221004843.31946-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 21 Dec 2025 00:49:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2839

Move KERNEL_FEATURES from SoC configurations to linux kernel recipes.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes since v1:
- none
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


