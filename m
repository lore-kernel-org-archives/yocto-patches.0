Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA3EC71148
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 16:21:26 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web11.1311.1749831682454734730
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Jun 2025 09:21:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iRSdARy9;
 spf=pass (domain: gmail.com, ip: 209.85.222.178, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c5675dec99so271086285a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749831681; x=1750436481; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DEU3p/VVd4YG0BnMR1ubCA4ZFz3bo4jyo/P+M5Z/wXo=;
        b=iRSdARy9eGKB6LcA6rZRXIUkJTEu5xE7fUaLwroRVLzgflJRpnY+D2du7H8Cb9oEnw
         5yhGEwv3lEqsxLvdZ+NkOXmV9DdCXdEM0Nwdo8GnvotQTb1vcEw81c/QadL/AfahDpnj
         7cuNDO6IEANRoyr3uRDNZbU65D9YZ5qhXobJD4PR8tSxP/nNpnVtfYOJwCozj2n2litx
         fYaNlUN1BD4j8Rp7mW7F3Au+xKEWvh2Qc+txVnEAH+WpfxgF27tyYShBalWTBh/1F4y2
         QVi6fzaNGr5WysLN8d6rLeY3W1OQnWqoFOCpUq61qCBBhN8aD/GXxY8GudlV8+At9+qJ
         Z04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749831681; x=1750436481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEU3p/VVd4YG0BnMR1ubCA4ZFz3bo4jyo/P+M5Z/wXo=;
        b=KAbmKVghp9bwfvRmJ2sG3W6LAZAmYuB8WdRJHmvne9czPBQOi7CZ8OGP9ghPhSe2tQ
         zR/XewBz+gz7hKxce+C9PkFa4A14FL51YvcQ2txBaapUG3gUXA6Q+sSaxfcH0Kn7VNJU
         EyTuZWvMlq+Vu/qQLlkGubnTbEb9QVtryVCKxC2HWf+0nmkfm3Wo/kA5rgwwIiQuKH+Y
         tQ6K7AxF6R9fJF6WHl8bwSiYgLdvai6svfya7BJ0Tn0IO4ItjFdl8so5axFWcywRQXgJ
         JnAeRf1wofmBqycchWk/WSO5LuJLvU4V7UQ2qdO7tvg+Ro6Je0OQFt35p0QJ+fuGnDZw
         eBVQ==
X-Gm-Message-State: AOJu0YwpkdPhmVdF0v2exefkzXYMYfHgdFgC8ocl1xJCXzr2ab1ULo+J
	snLk1pIMifIHrpUzzwZ/f/nSxiWd5wza6nc+3EQzAP5oHfR3yr2VnXHVvPWly41E
X-Gm-Gg: ASbGnctsAufnq/s0mbb8vWWlb0vUUwKQ+KcEMvwqz3btvwwoaDwl6o2N6i4jYksbo97
	sjnWqREcBsjzncQMMauMbSsN1xnLrbnhU9RFT0vGJ8D0UPzqzBZet7k9JXjqyqqELnPSbllcsJh
	6jW3hvN493XnPtVroVG8MQ8kkVANlcS36bpRD6ysvW6E86hIhlnz+YQV2PuOlVg9apxQ3f8rkso
	GnpbLJEXJxJf07+wFAGmNH0y1IOHlvOjvCy+ZiyJJpOZxkgARKu91Bx/Fpm6fyYta06Gq1GXSE4
	myBUt+NleMSUCtdQpjLWsFjWVH5BlHcLrpeXby3FeZ0vnXnw8dalMiqiyVq8aopdSRLOoQ4JD5o
	ZKaqNUIRrA+6j/0SAj3q0iNKPNwG8nQ==
X-Google-Smtp-Source: AGHT+IE+gzPssL3fx3ew5A96DVAYazL7LrH0HW91lkMNXHjZcq5dC2uDVQIsVniQ4cyx0hhaCyQSAg==
X-Received: by 2002:a05:620a:4512:b0:7c7:bb07:af07 with SMTP id af79cd13be357-7d3c6c1ab2fmr11834485a.22.1749831680499;
        Fri, 13 Jun 2025 09:21:20 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dca1b2sm189594685a.11.2025.06.13.09.21.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 09:21:19 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2] fitimage rework
Date: Fri, 13 Jun 2025 12:21:00 -0400
Message-ID: <20250613162100.23912-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 16:21:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1644

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
 conf/machine/include/rockchip-extlinux.inc   | 8 ++++----
 conf/machine/include/rockchip-fitimage.inc   | 4 ++++
 conf/machine/include/rockchip-unfitimage.inc | 1 +
 15 files changed, 22 insertions(+), 21 deletions(-)
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
index fddab735bbf7..2e5b1b523c3c 100644
--- a/conf/machine/include/rockchip-extlinux.inc
+++ b/conf/machine/include/rockchip-extlinux.inc
@@ -13,13 +13,13 @@ NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split()[0].split('/')[1]}"
 
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
+MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "${@ 'linux-yocto-fitimage' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE')) else 'kernel-devicetree'}"
diff --git a/conf/machine/include/rockchip-fitimage.inc b/conf/machine/include/rockchip-fitimage.inc
new file mode 100644
index 000000000000..2777e1bed555
--- /dev/null
+++ b/conf/machine/include/rockchip-fitimage.inc
@@ -0,0 +1,4 @@
+KERNEL_CLASSES += "kernel-fit-extra-artifacts"
+KERNEL_IMAGETYPE ?= "Image"
+RRECOMMENDS:${KERNEL_PACKAGE_NAME}-base = ""
+KERNEL_DEPLOY_DEPEND ?= "linux-yocto-fitimage:do_deploy"
diff --git a/conf/machine/include/rockchip-unfitimage.inc b/conf/machine/include/rockchip-unfitimage.inc
new file mode 100644
index 000000000000..1f0c5ec1285e
--- /dev/null
+++ b/conf/machine/include/rockchip-unfitimage.inc
@@ -0,0 +1 @@
+KERNEL_IMAGETYPE ?= "zImage"
-- 
2.44.0.501.g19981daefd7c


