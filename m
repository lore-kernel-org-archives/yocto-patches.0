Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B72C41513
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 17:02:05 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web10.13880.1718298123474176046
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Jun 2024 10:02:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=d82OYQOT;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43fdbe0f072so6960941cf.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718298122; x=1718902922; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cy52W59C1H2T0wy9nUbeNRTCHcONmkHdGq7FoSfUuQA=;
        b=d82OYQOTD0s8+0jogMo+XfLoev80apNPHIOgF8CPn1Rf4xnUrH0BA1Q4+FfiPpgGoy
         POlkbZD5hD3/byd528KJXqMJZvDUEC2Stm0C6kp/fZj7pf4unS9RoJlTvGwfUr6isJfx
         jzekOYXOh3XSZJSEnUUDrMi7rh0/1iwXEZJ0kXBMEl0DPnaWsnVe4b3h06aWIuaHqSkt
         n3OA5PIusoQKDU+u2CUb90y+RqO8iCJN4qQ/hSZW9/NO7kdLI5o2cW6NAh5R3wZbDnas
         9VnqZNY4ARz1YDInrnI4lcgOdTzmljp0rCufSE4mUjhOV2SHImqGfXr+D3x6cfIhHaY/
         BLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298122; x=1718902922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cy52W59C1H2T0wy9nUbeNRTCHcONmkHdGq7FoSfUuQA=;
        b=NoJWc7OZRYxEr/BP7/0KccZSLWsDwhrU8plKXnowvodqJGAdWD9+DYLv0ccdaQNkKW
         2COlkguH4l+3H+BF83RvO1HbWMgA4dxwUxjI+1XkrDShdQsKAnlGxcgmmP59Xe1V8uym
         3YATY7Rll/TP+umRKydPbSn8zvOgHUJ4oaDh2r+ECbYBLCOa22/rzlntaRDF0gOluULS
         JY0dWpLZf1chfqgpyJmy306amxxgHALS6ei6zofLhQwjNOjBuFNu9MaDgvgsG3K/XUpX
         xJvEF1mj0V+U4pv9bBIb2JmKKyYa87UUf1KWRbXV4czfT4mqkPXlBWLpLq5B1MjzvG1G
         4uOg==
X-Gm-Message-State: AOJu0YyBH/99cV9Y85Ynx1bXw3U4flkRobHpiEVCZDsD4IHwSgWJTnqI
	qlobfvWiKvDwZ/uPtkurchUUg5JhMcDW0XdRBZUt/8cDRQ3A9NQIlTq+xg==
X-Google-Smtp-Source: AGHT+IFfJ8vaHxu3BbUj00xUiqNd2CbvdCHo2zMfdGlMccoeHoxq7Q+MDAGOJFcu65M5cMS0M71LmA==
X-Received: by 2002:ac8:7dcd:0:b0:441:5994:fd41 with SMTP id d75a77b69052e-442168c0974mr1769171cf.35.1718298120792;
        Thu, 13 Jun 2024 10:02:00 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c18209sm8588676d6.42.2024.06.13.10.01.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:02:00 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v3 2/4] radxa-zero-3e: add
Date: Thu, 13 Jun 2024 13:01:52 -0400
Message-ID: <20240613170154.6441-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240613170154.6441-1-twoerner@gmail.com>
References: <20240613170154.6441-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 17:02:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/325

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
v3 changes:
- remove sha256sum from u-boot bbappend
- linux-torvalds-next:
  - fix COMPATIBLE_MACHINE
  - add comment on SRCREV indicating the tag name

v2 changes:
- copy the rk3568-based bl31/bl32 pieces to have rk3566-based names so the
  rest of the infrastructure works without tweaks
- uncomment/implement the "remove-non-rockchip-arch" kernel scc
- order/sort items
- cleanup/fixup the linux-torvalds-next kernel recipe:
  - sort oe items based on the style guide
  - remove vestigial bits
  - use a commit id instead of a tag name
  - update license string
  - add DEFAULT_PREFERENCE=-1
  - add COMPATIBLE_MACHINE
---
 README                                        |  1 +
 conf/machine/include/rk3566.inc               | 21 +++++++++++++++++
 conf/machine/radxa-zero-3e.conf               | 12 ++++++++++
 recipes-bsp/rkbin/rockchip-rkbin_git.bb       | 12 ++++++++++
 recipes-bsp/u-boot/u-boot_%.bbappend          |  4 ++++
 .../linux/linux-torvalds-next_git.bb          | 23 +++++++++++++++++++
 6 files changed, 73 insertions(+)
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
index 000000000000..586d68806df6
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
+KERNEL_FEATURES:append:rk3566 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
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
index f9724ddd5cd5..1b71414e27ca 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
@@ -14,6 +14,7 @@ S = "${WORKDIR}/git"
 
 COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:rk3308 = "rk3308"
+COMPATIBLE_MACHINE:rk3566 = "rk3566"
 COMPATIBLE_MACHINE:rk3568 = "rk3568"
 COMPATIBLE_MACHINE:rk3588s = "rk3588s"
 
@@ -36,6 +37,17 @@ do_deploy:rk3308() {
 	install -m 644 ${S}/bin/rk33/rk3308_ddr_589MHz_uart?_m0_v*.bin ${DEPLOYDIR}/ddr-rk3308.bin
 }
 
+# NOTE: the following are not typos
+#       the rk3566 uses the same bl31/2 as the rk3568
+do_deploy:rk3566() {
+	# Prebuilt TF-A
+	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3566.elf
+	# Prebuilt OPTEE-OS
+	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3566.bin
+	# Prebuilt U-Boot TPL (DDR init)
+	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3566.bin
+}
+
 do_deploy:rk3568() {
 	# Prebuilt TF-A
 	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3568.elf
diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index 1f5f63459627..e1ee17ef6905 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -2,6 +2,10 @@ require u-boot-rockchip.inc
 
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 
+SRC_URI:radxa-zero-3e = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
+SRCREV:radxa-zero-3e = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
+SRCREV:radxa-zero-3e:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
+
 SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
 SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
 
diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
new file mode 100644
index 000000000000..a932f5397771
--- /dev/null
+++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
@@ -0,0 +1,23 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto-dev:"
+
+DESCRIPTION = "Linux Kernel"
+SECTION = "kernel"
+LICENSE = "GPL-2.0-only"
+LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
+
+DEFAULT_PREFERENCE = "-1"
+COMPATIBLE_MACHINE = "^$"
+COMPATIBLE_MACHINE:radxa-zero-3e = "radxa-zero-3e"
+
+LINUX_VERSION = "6.10-rc3"
+PV = "${LINUX_VERSION}+git${SRCPV}"
+SRC_URI = " \
+	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;branch=master \
+	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
+	"
+# this is tag 'next-20240611'
+SRCREV = "a957267fa7e9159d3d2ee1421359ebf228570c68"
+
+inherit kernel
+inherit kernel-yocto
+require recipes-kernel/linux/linux-yocto.inc
-- 
2.44.0.478.g7774cfed6261


