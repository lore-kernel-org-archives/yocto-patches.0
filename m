Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4662C27C78
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 02:01:35 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.web10.1582.1718157685854884157
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 19:01:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DK/uRsfo;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43fdbe0f072so32012071cf.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 19:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718157684; x=1718762484; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxwchRDuRUxzVzwOkVlt337TC3Hxr9myRoZxYQWz6NQ=;
        b=DK/uRsfonN1PGvnCQKmRDh8yLam/Cnzf6O6O4YKrVq99QfBkP2TWNTb3vNDXq4AwXd
         6Tk1tqr+JFKrRkJC28y3iECW5ipiCSqKlifp6v9lCwJMepSDbjC6jdH8zIljajYlzVvC
         3hrME4sHvzhAyVG7qq6mS/s2e5FT61lhuWCMyX9/iquL+qqBT8fm1hD5fUeKMkhBu/YW
         YYNBSU06c0bR/S0OmI6AFl3RcUZ1IgWGe+DuzttscCUdLKwr1+s4zlnEVfOD0b+wAXW5
         gdeAsmTkFQDwNEOd4qdcDZWr0pyNVpuiq/Wqn+405PJTw4Gfmgy3BuTzt0EefrkuCqdX
         o2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718157684; x=1718762484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxwchRDuRUxzVzwOkVlt337TC3Hxr9myRoZxYQWz6NQ=;
        b=BWJxnyz0f+XVmi5x6p/xO3wVfLl3GSrty2lLcKy6MA4j5LwAER7cs4yAbstheVbKPs
         yqnG/exDl59AM53/EOwMt0mR3O4spgyGYE0kYZmdnmv8ifW+8ZSKROPx21MLKprNn06Q
         bz/UoQqq35n/1NXi1s3lr8YuwatBe2zpu5zEkbEOHvC4Yr9ZylVLIQ0q3Q0LD49pra4n
         Ch1hkdd0QHdX7FokFI0q+7rtXQJznRpwWTSiMHbR4/HBK4D8l9euf4Gct6NbRlEsHmI3
         0umN7RwDJu0zWCQLzUEbjTumoAH9e3hFpRbnhPqQP5g9T4OhHlFbnwYlC4SnTQNjTJpX
         /SXw==
X-Gm-Message-State: AOJu0Yyd7m7l2UcoPMMPY0g5UVf79aXdzcCdsns+Q+B3Uq0pcQrxoQhU
	bVyjCjfvKnFzTnMqMQRJk5bSw8+iLiQ8UVQeMQam47tRctrqd1O9Urbf6w==
X-Google-Smtp-Source: AGHT+IG2QJquV3rhJKpy0sKviDXtPxgkibD1EUSKJ0nkouV9S4LMpzj8hOirg78VX6gCiKibu0gt1g==
X-Received: by 2002:ac8:7d43:0:b0:441:5481:9838 with SMTP id d75a77b69052e-4415ac65abamr4431541cf.57.1718157683173;
        Tue, 11 Jun 2024 19:01:23 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44120f7a67esm16622581cf.86.2024.06.11.19.01.21
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 19:01:22 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] radxa-zero-3e: add
Date: Tue, 11 Jun 2024 22:01:16 -0400
Message-ID: <20240612020116.40600-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Jun 2024 02:01:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/312

The Radxa ZERO 3e is an ultra-small, high-performance single board computer
based on the Rockchip RK3566, with a compact form factor, and rich interfaces.

	http://radxa.com/products/zeros/zero3e/

tech specs:
- Rockchip RK3566 (4x Arm Cortex-A55 @ 1.6GHz)
- Arm Mali-G52-2EE (OpenGL ES 1.1/2.0/3.0/3.1/3.2, Vulkan 1.1, OpenCL 2.0)
- LPDDR4 RAM (1/2/3/8 GB)
- µSD
- GbE
- 1x USB 2.0 Type C OTG, 1x USB 3.0 Type C Host
- 1x µHDMI (1080p @ 60fps)
- 1x MIPI CSI camera port
- colour-coded 40-pin GPIO (uart, spi, i2c, pcm/i2s, pwm, gpio)
- 72mm x 30mm

NOTE: currently support for this board requires a U-Boot fork for the
bootloader, and linux-next for the kernel. Support will probably come in linux
kernel 6.11-ish, at which point U-Boot will then use that kernel's device tree
which means U-Boot support will come after the release of whichever kernel
includes support for this board.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 README                                        |  1 +
 conf/machine/include/rk3566.inc               | 21 ++++++++++++++++++
 conf/machine/radxa-zero-3e.conf               | 12 ++++++++++
 recipes-bsp/rkbin/rockchip-rkbin_git.bb       | 11 ++++++++++
 recipes-bsp/u-boot/u-boot-rockchip.inc        |  2 ++
 recipes-bsp/u-boot/u-boot_%.bbappend          |  5 +++++
 .../linux/linux-torvalds-next_git.bb          | 22 +++++++++++++++++++
 7 files changed, 74 insertions(+)
 create mode 100644 conf/machine/include/rk3566.inc
 create mode 100644 conf/machine/radxa-zero-3e.conf
 create mode 100644 recipes-kernel/linux/linux-torvalds-next_git.bb

diff --git a/README b/README
index b21e92360dcc..a9a040a4308d 100644
--- a/README
+++ b/README
@@ -40,6 +40,7 @@ Status of supported boards:
 		orangepi-5-plus
 		rock-3a
 		rock-4c-plus
+		radxa-zero-3e
 	builds:
 		marsboard-rk3066
 		radxarock
diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
new file mode 100644
index 000000000000..41d0a227a988
--- /dev/null
+++ b/conf/machine/include/rk3566.inc
@@ -0,0 +1,21 @@
+SOC_FAMILY = "rk3566"
+
+DEFAULTTUNE ?= "cortexa55"
+
+ROCKCHIP_CLOSED_TPL ?= "1"
+
+require conf/machine/include/soc-family.inc
+require conf/machine/include/rockchip-defaults.inc
+require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
+require conf/machine/include/rockchip-wic.inc
+
+KBUILD_DEFCONFIG ?= "defconfig"
+#KERNEL_FEATURES:append:rk3566 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
+KERNEL_CLASSES = "kernel-fitimage"
+KERNEL_IMAGETYPE ?= "fitImage"
+
+PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin"
+PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
+
+UBOOT_SUFFIX ?= "itb"
+UBOOT_ENTRYPOINT ?= "0x06000000"
diff --git a/conf/machine/radxa-zero-3e.conf b/conf/machine/radxa-zero-3e.conf
new file mode 100644
index 000000000000..3a39d6c12a1f
--- /dev/null
+++ b/conf/machine/radxa-zero-3e.conf
@@ -0,0 +1,12 @@
+#@TYPE: Machine
+#@NAME: Radxa Zero 3E
+#@DESCRIPTION: The Radxa ZERO 3e is an ultra-small, high-performance single board computer based on the Rockchip RK3566, with a compact form factor, and rich interfaces.
+#http://radxa.com/products/zeros/zero3e/
+
+require conf/machine/include/rk3566.inc
+
+PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
+KERNEL_DEVICETREE = "rockchip/rk3566-radxa-zero-3e.dtb"
+MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
+
+UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
index 7929c6ac3a10..6894558ef70c 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
@@ -4,6 +4,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
 
 SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
 SRCREV = "b4558da0860ca48bf1a571dd33ccba580b9abe23"
+SRCREV:radxa-zero-3e = "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
 
 PROVIDES += "trusted-firmware-a"
 PROVIDES += "optee-os"
@@ -15,6 +16,7 @@ S = "${WORKDIR}/git"
 COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:rk3308 = "rk3308"
 COMPATIBLE_MACHINE:rk3568 = "rk3568"
+COMPATIBLE_MACHINE:rk3566 = "rk3566"
 COMPATIBLE_MACHINE:rk3588s = "rk3588s"
 
 PACKAGE_ARCH = "${MACHINE_ARCH}"
@@ -36,6 +38,15 @@ do_deploy:rk3308() {
 	install -m 644 ${S}/bin/rk33/rk3308_ddr_589MHz_uart?_m0_v*.bin ${DEPLOYDIR}/ddr-rk3308.bin
 }
 
+do_deploy:rk3566() {
+	# Prebuilt TF-A
+	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3568.elf
+	# Prebuilt OPTEE-OS
+	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3568.bin
+	# Prebuilt U-Boot TPL (DDR init)
+	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3566.bin
+}
+
 do_deploy:rk3568() {
 	# Prebuilt TF-A
 	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3568.elf
diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc b/recipes-bsp/u-boot/u-boot-rockchip.inc
index d2267cc53a92..113190635bb5 100644
--- a/recipes-bsp/u-boot/u-boot-rockchip.inc
+++ b/recipes-bsp/u-boot/u-boot-rockchip.inc
@@ -1,6 +1,8 @@
 BL31:rockchip:aarch64 = "${DEPLOY_DIR_IMAGE}/bl31-${SOC_FAMILY}.elf"
 # SOC_FAMILY for RK3588S is rk3588s but it should use the binaries from rk3588
 BL31:rk3588s = "${DEPLOY_DIR_IMAGE}/bl31-rk3588.elf"
+# rk3566 uses the rk3568 bl31
+BL31:rk3566 = "${DEPLOY_DIR_IMAGE}/bl31-rk3568.elf"
 EXTRA_OEMAKE:append:rockchip:aarch64 = " BL31=${BL31}"
 
 TFA_DEPENDS ??= ""
diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index 1f5f63459627..dca43d2a4de0 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -2,6 +2,11 @@ require u-boot-rockchip.inc
 
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 
+SRC_URI:radxa-zero-3e = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
+SRC_URI[Kwiboo.sha256sum] = "5d102a658262f6d2d4ea0664fe58b77db4a9eb1ebc89dbd8d6f5e75c9e563810"
+SRCREV:radxa-zero-3e = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
+SRCREV:radxa-zero-3e:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
+
 SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
 SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
 
diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
new file mode 100644
index 000000000000..bbe4689922a7
--- /dev/null
+++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
@@ -0,0 +1,22 @@
+inherit kernel
+inherit kernel-yocto
+require recipes-kernel/linux/linux-yocto.inc
+
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+
+DESCRIPTION = "Linux Kernel"
+SECTION = "kernel"
+LICENSE = "GPLv2"
+LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
+
+
+LINUX_VERSION = "6.10"
+KERNEL_VERSION_SANITY_SKIP = "1"
+SRCREV = "next-20240611"
+PV = "${LINUX_VERSION}+git${SRCPV}"
+SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;branch=master"
+SRC_URI[sha256sum] = "3a1c433c4ceffa52f8c3df3aab8c379ff91ca658021d409a528825e5e24580f4"
+
+do_compile:append() {
+	touch ${B}/Module.symvers
+}
-- 
2.44.0.478.g7774cfed6261


