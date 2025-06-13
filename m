Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74A2C71148
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 16:41:16 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web11.1833.1749832869045803901
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Jun 2025 09:41:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=O/zcAJoY;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5675dec99so273295385a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 09:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749832867; x=1750437667; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=41ARKh9oF38mRrZH11oFSLCYhm4h1EuGUkMCXbw4nbM=;
        b=O/zcAJoY8o7xNkMRUFy9GmBAX6v/lhkIfn3amQiCiUKZtcXNrYC+abxXP3zk4u5X6N
         ZL+ei2kCPxIjK3FkXCCV2h4DMTQh2yvb6avdu9ldf1mVyd1M13rY2B3jfyljGzs6arkR
         YBJZehOxr+GQxjdjvfTdZQHoIH9zxCxPP0CFj8cnMHZ2b0770js1qmcRaCqOJ+DrRHkl
         pQhoJRq3BxfeDKzg9NkMAkHT0P5AoOPIUn36Lx6LIDDhOedde0lrim1pPt4cNpzvOMmV
         kr4z8UuCFfpW7G+gTqxgO9oLtLRHcbW8V/xIDKClte9pDkyNVFtBd49QLce/Ih6jtf5n
         1w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749832867; x=1750437667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41ARKh9oF38mRrZH11oFSLCYhm4h1EuGUkMCXbw4nbM=;
        b=wZcvIBoo3J+FBU4JXT7DGyf+uIZ2sieYPmDfVr3QMuC0oNbY/32oR2MghmVGSZ43mq
         +khqfFoSb6zJHap+JAL4yZw94OTEic2eS5Im1rPcvYIm4He9JjQUecB2OIBl3nsG7WJZ
         J9gImEVR++zHW2XfcBCap8D6yijQpV7iQ8cXMoBmAb8B+z4sI/fwdERat3ss2qreUlIR
         CvwpTZ2tvDUMPIyH8CGZO/mZObhKMoX9jKyoaRySi0oaVK6suI6W/d70R8kyoUCDVM+S
         UB6P9i1NJhiUAhO+CNaikTSBzXAkMJdDpslN6U988oZIcV/rF+2FeR4uU1L78k7J3bGW
         2Phg==
X-Gm-Message-State: AOJu0Yx7NsItmXqSCzclcb+iQupA4uI4BVipNTs/GITbwuUjGgvqxLQp
	xXE2utuTRC6JhW1VARDJlxn2PnGIa+j0Pt+/C/EbTLP4u6QXw3QQJvqJCeW7umYB
X-Gm-Gg: ASbGncuFudS2osiv7XnqXmtTPvIcQamQ0SkLqqUHTQcG4qAlB/d7HCt5uBG2ZEa1I6e
	ezJUvX54qHhKNispoR2c8pjxcK8VbsS4S25oRZ6ZTsVXk1UvJtfaD4LVYAoRBJdC1o6X5i1Ncvq
	NrsiCwHlCRwKgRPjEvU91EnshVl++Ue+Iqcw8pLuMJc0jZ4lrsE3GBR343dRY29q5zgWLev5Iuj
	deDYwVD4wXspS9+O+ku+EbY8TyMELP6inQBpOjJHbSm4OjI/3jJWSiABqKK1oeCm2h5WpSlvALj
	qnhlt9tz0YchbILT7wHzLVHBBfjuyNc98pmPKC2qiEu5ix2s1A9w0nqXl/HaNrKE963pqj1bW8e
	55OCLaB2hVhv21v2I/KOB5NVfyN9QRof6YgWsvZsK
X-Google-Smtp-Source: AGHT+IHPKOivjuU//I1ur8z91qUjSHV/9/MtxSwmOZkszt5ZT/VRfyEJwoKW/bxKBoXKLgfAoeDwLg==
X-Received: by 2002:a05:620a:63c8:b0:7d3:8f6a:1276 with SMTP id af79cd13be357-7d3c6c1931dmr22393285a.19.1749832867115;
        Fri, 13 Jun 2025 09:41:07 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8ecf9d0sm190214885a.82.2025.06.13.09.41.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 09:41:06 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v3] fitimage rework
Date: Fri, 13 Jun 2025 12:41:01 -0400
Message-ID: <20250613164101.20700-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 16:41:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1645

oe-core has completely re-written the fitImage support starting roughly at
commit [1], update meta-rockchip to match.

Most of the MACHINEs in meta-rockchip use a fitImage, but some don't. Create
a boolean variable (RK_FITIMAGE), enabled by default, to keep track of which
ones do and which ones don't. Use this variable to decide how to configure
various image-related fields.

Run tested on the following with RAUC configured:
	- nanopi-m4b
	- nanopi-r2s
	- radxa-zero-3e
	- rock-pi-4b
	- rock-pi-e
	- rock-pi-s

Run tested on the following without RAUC:
	- radxa-zero-3e
	- rock-pi-e
	- rock-pi-s

[1] oe-core: 3442d9297dca ("oe-selftest: fitimage: test external dtb")
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v3:
- remove the 2nd MACHINE_ESSENTIAL_EXTRA_RDEPENDS from the
  rockchip-extlinux.inc file and place the relevant portions into either
  the rockchip-fitimage.inc or rockchip-unfitimage.inc files as
  appropriate

changes in v2:
- remove the ",False" from the bb.utils.to_boolean() calls
- add informaton on new param (RK_FITIMAGE) to README
- re-structure the fitimage require so it is less invasive in
  MACHINE.conf files
---
 README                                       | 7 +++++++
 conf/machine/include/px30.inc                | 2 --
 conf/machine/include/rk3066.inc              | 2 +-
 conf/machine/include/rk3188.inc              | 2 +-
 conf/machine/include/rk3288.inc              | 2 +-
 conf/machine/include/rk3308.inc              | 2 --
 conf/machine/include/rk3328.inc              | 2 --
 conf/machine/include/rk3399.inc              | 2 --
 conf/machine/include/rk3566.inc              | 2 --
 conf/machine/include/rk3568.inc              | 2 --
 conf/machine/include/rk3588s.inc             | 2 --
 conf/machine/include/rockchip-defaults.inc   | 3 +++
 conf/machine/include/rockchip-extlinux.inc   | 7 +++----
 conf/machine/include/rockchip-fitimage.inc   | 5 +++++
 conf/machine/include/rockchip-unfitimage.inc | 2 ++
 15 files changed, 23 insertions(+), 21 deletions(-)
 create mode 100644 conf/machine/include/rockchip-fitimage.inc
 create mode 100644 conf/machine/include/rockchip-unfitimage.inc

diff --git a/README b/README
index 9672c6ab8d5b..5a12f6118fae 100644
--- a/README
+++ b/README
@@ -159,6 +159,13 @@ Notes:
 	compatible (see Rockchip Media Process Platform (MPP) and
 	downstream gstreamer-rockchip plugin for those kernels).
 
+  RK_FITIMAGE
+
+	When generating an image, the BSP code needs to know whether or not to
+	package the pieces as a fitImage or not. By default it is assumed most
+	MACHINEs will use the fitImage format. Otherwise disable the RK_FITIMAGE
+	variable boolean to indicate otherwise.
+
 U-Boot Environment:
 ------------------
 	In order to configure U-Boot to be able to store its environment into the
diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
index 8173cb19be2c..1997f6fe6a9d 100644
--- a/conf/machine/include/px30.inc
+++ b/conf/machine/include/px30.inc
@@ -11,8 +11,6 @@ require conf/machine/include/arm/armv8a/tune-cortexa35.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
 
 TFA_PLATFORM = "px30"
 TFA_BUILD_TARGET = "bl31"
diff --git a/conf/machine/include/rk3066.inc b/conf/machine/include/rk3066.inc
index a898309bbf88..90cadd82fbf2 100644
--- a/conf/machine/include/rk3066.inc
+++ b/conf/machine/include/rk3066.inc
@@ -2,6 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SOC_FAMILY = "rk3066"
+RK_FITIMAGE = "False"
 
 require conf/machine/include/soc-family.inc
 require conf/machine/include/rockchip-defaults.inc
@@ -11,6 +12,5 @@ SERIAL_CONSOLES = "115200;ttyS2"
 
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3066 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
-KERNEL_IMAGETYPE ?= "zImage"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3188.inc b/conf/machine/include/rk3188.inc
index 554d4f1c904d..23c2a806b3c4 100644
--- a/conf/machine/include/rk3188.inc
+++ b/conf/machine/include/rk3188.inc
@@ -2,6 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SOC_FAMILY  = "rk3188"
+RK_FITIMAGE = "False"
 
 require conf/machine/include/soc-family.inc
 require conf/machine/include/rockchip-defaults.inc
@@ -11,6 +12,5 @@ SERIAL_CONSOLES = "115200;ttyFIQ0"
 
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3188 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
-KERNEL_IMAGETYPE ?= "zImage"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
index 06fda69a3eb7..793a80a72430 100644
--- a/conf/machine/include/rk3288.inc
+++ b/conf/machine/include/rk3288.inc
@@ -2,6 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SOC_FAMILY = "rk3288"
+RK_FITIMAGE = "False"
 
 require conf/machine/include/soc-family.inc
 require conf/machine/include/rockchip-defaults.inc
@@ -11,7 +12,6 @@ SERIAL_CONSOLES = "115200;ttyS2"
 
 KBUILD_DEFCONFIG ?= "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3288 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
-KERNEL_IMAGETYPE ?= "zImage"
 
 UBOOT_SUFFIX ?= "bin"
 
diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
index d30901f15b4f..6876564fbcb2 100644
--- a/conf/machine/include/rk3308.inc
+++ b/conf/machine/include/rk3308.inc
@@ -13,8 +13,6 @@ SERIAL_CONSOLES = "1500000;ttyS0"
 
 KBUILD_DEFCONFIG ?= "defconfig"
 KERNEL_FEATURES:append:rk3308 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
index e6f810dcd2ca..2fe2710399b1 100644
--- a/conf/machine/include/rk3328.inc
+++ b/conf/machine/include/rk3328.inc
@@ -12,8 +12,6 @@ require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
 KERNEL_FEATURES:append:rk3328 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
 
 TFA_PLATFORM = "rk3328"
 TFA_BUILD_TARGET = "bl31"
diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
index cd1be49064ed..8d30cf7e460b 100644
--- a/conf/machine/include/rk3399.inc
+++ b/conf/machine/include/rk3399.inc
@@ -12,8 +12,6 @@ require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
 KERNEL_FEATURES:append:rk3399 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
 
 TFA_PLATFORM = "rk3399"
 TFA_BUILD_TARGET = "bl31"
diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
index 6386ec7eb51c..5b65ad7d4a47 100644
--- a/conf/machine/include/rk3566.inc
+++ b/conf/machine/include/rk3566.inc
@@ -11,8 +11,6 @@ require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
 KERNEL_FEATURES:append:rk3566 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
 
 PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
 PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
index bcf9dd8b0f44..ad3952de074c 100644
--- a/conf/machine/include/rk3568.inc
+++ b/conf/machine/include/rk3568.inc
@@ -11,8 +11,6 @@ require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
 KERNEL_FEATURES:append:rk3568 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
 
 PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
 PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index 6ec344abae5b..203b97c6353c 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -10,8 +10,6 @@ require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
 KERNEL_FEATURES:append:rk3588s = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
 
 PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
 PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
diff --git a/conf/machine/include/rockchip-defaults.inc b/conf/machine/include/rockchip-defaults.inc
index 85ec7b944d1d..4e77a6291657 100644
--- a/conf/machine/include/rockchip-defaults.inc
+++ b/conf/machine/include/rockchip-defaults.inc
@@ -1,9 +1,12 @@
 # meta-rockchip default settings
 MACHINEOVERRIDES =. "${@bb.utils.contains('ROCKCHIP_CLOSED_TPL', '1', 'closed-tpl:', '', d)}"
 MACHINEOVERRIDES =. "rockchip:"
+
 # kernel
+RK_FITIMAGE ?= "True"
 PREFERRED_PROVIDER_virtual/kernel ?= "linux-yocto"
 KCONFIG_MODE ?= "alldefconfig"
+require conf/machine/include/rockchip-${@ 'fitimage' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE')) else 'unfitimage'}.inc
 
 # xserver
 XSERVER = " \
diff --git a/conf/machine/include/rockchip-extlinux.inc b/conf/machine/include/rockchip-extlinux.inc
index fddab735bbf7..5753d062579f 100644
--- a/conf/machine/include/rockchip-extlinux.inc
+++ b/conf/machine/include/rockchip-extlinux.inc
@@ -13,13 +13,12 @@ NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split()[0].split('/')[1]}"
 
 UBOOT_EXTLINUX ?= "1"
 UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=rootfsA"
-UBOOT_EXTLINUX_FDTDIR ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"
-UBOOT_EXTLINUX_FDT ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot/${NONFITDT}', d)}"
+UBOOT_EXTLINUX_FDTDIR ?= "${@ '' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE')) else '/boot'}"
+UBOOT_EXTLINUX_FDT ?= "${@ '' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE')) else '/boot/${NONFITDT}'}"
 UBOOT_EXTLINUX_CONSOLE ?= "earlycon console=tty1 console=${RK_CONSOLE_DEVICE},${RK_CONSOLE_BAUD}n8"
 UBOOT_EXTLINUX_KERNEL_ARGS ?= "rootwait rw rootfstype=ext4"
-UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${KERNEL_IMAGETYPE}"
+UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${@ 'fitImage' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE')) else '${KERNEL_IMAGETYPE}'}"
 UBOOT_EXTLINUX_LABELS ?= "default"
 UBOOT_EXTLINUX_MENU_DESCRIPTION:default ?= "${MACHINE}"
 
 MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "u-boot-extlinux"
-MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "kernel-image ${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', 'kernel-devicetree', d)}"
diff --git a/conf/machine/include/rockchip-fitimage.inc b/conf/machine/include/rockchip-fitimage.inc
new file mode 100644
index 000000000000..87c1334c7060
--- /dev/null
+++ b/conf/machine/include/rockchip-fitimage.inc
@@ -0,0 +1,5 @@
+KERNEL_CLASSES += "kernel-fit-extra-artifacts"
+KERNEL_IMAGETYPE ?= "Image"
+RRECOMMENDS:${KERNEL_PACKAGE_NAME}-base = ""
+KERNEL_DEPLOY_DEPEND ?= "linux-yocto-fitimage:do_deploy"
+MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "linux-yocto-fitimage"
diff --git a/conf/machine/include/rockchip-unfitimage.inc b/conf/machine/include/rockchip-unfitimage.inc
new file mode 100644
index 000000000000..6d4f23c67a65
--- /dev/null
+++ b/conf/machine/include/rockchip-unfitimage.inc
@@ -0,0 +1,2 @@
+KERNEL_IMAGETYPE ?= "zImage"
+MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "kernel-devicetree"
-- 
2.44.0.501.g19981daefd7c


