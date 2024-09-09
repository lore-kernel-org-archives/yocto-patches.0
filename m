Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7EBECE57E
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 14:55:54 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
 by mx.groups.io with SMTP id smtpd.web11.55128.1725893753835570250
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 07:55:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H5HRXjjW;
 spf=pass (domain: gmail.com, ip: 209.85.219.175, mailfrom: twoerner@gmail.com)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso4075005276.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725893752; x=1726498552; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIJF8Ruw03yC7krYwOuKQGOwtvzuZqFoudgosJZ3PMU=;
        b=H5HRXjjWUe3BqgoAoyNt0c0KoOorqktl7za8R1Kxc70I+CucyGbAWlq2t+Oe6AHNl8
         v3JVW3xM7WRZWnFRjIfSgJzeK97PMuLY0oKq/aPiWB/YNjfhYzMpBXbpS+qg2t/CSBq7
         xLN6o6F6tPjIY5Ei0yJDFmBpq8qr78E/6xKchy04c+GnqmulhGJZzIQoFAo1ZadFSBad
         v9pH3P4R+MQAYd1bsCrGaV0CFOdJEr7Mbj4t+eZsP8mD0IW3sLge8l0uEzfTC/BY6mZX
         +QdnPtNsD/mBOMJtXDiL0UFx33T0NhnbyqETub01l2/qtwlOi4MYYob2lzUqrVEDhIMd
         aEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893752; x=1726498552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIJF8Ruw03yC7krYwOuKQGOwtvzuZqFoudgosJZ3PMU=;
        b=FIzcqmFhdgB9cpg8h9HIAEJ4qVIsQ2BwQNMnQB05VfUx2/ESIHMi7y1JPjsq/sZ35J
         CbSzFttaXbyowoIC1pxmd4aw/w8xBQdYE5Sbw20uOEzwf2db36nzIg86s6GlaD28b+C6
         rDtybt5sF2ObSVY3hu7WbH0aee2i3czTAQNvj/ZbNNJQbly4tHov4+xGXNlRldKYgB5k
         01i6i3aVMfZMMQbjS1wnsK+sRDt7NUAiUgHNVVPmNBBzk2ufXANp0/6XV5OmEhKtr+kP
         CxOXqxAbcivRiw21JZBhChsAUH2CVZOir4PHkqrRDRxx4SclZ4GEx2OkxTaGC9x0FI7T
         Fi0A==
X-Gm-Message-State: AOJu0Yzj7cjIrLRftTFf1ozF9t2UI7Xz0/wcr5OIjcdXDdSfNt9cQi0r
	GUVR3VOgobq6BYf6xhSlpk6pzgxMHx8Km7mjcY744foazruYVazcStlusXvb
X-Google-Smtp-Source: AGHT+IGxLDmKcyB0yqY+ZFkSh3YME0G0QBgHzkvEcYAnnnatJSP4gLPvSelvk7fNh6emHw8tJk8gqg==
X-Received: by 2002:a25:d809:0:b0:e1d:3cf9:f1ea with SMTP id 3f1490d57ef6-e1d3cfa0afbmr7892269276.34.1725893752180;
        Mon, 09 Sep 2024 07:55:52 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e772a2sm21050231cf.27.2024.09.09.07.55.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:55:50 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][scarthgap][PATCH 05/10] radxa-zero-3{e|w}: add
Date: Mon,  9 Sep 2024 10:55:25 -0400
Message-ID: <20240909145530.25301-6-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240909145530.25301-1-twoerner@gmail.com>
References: <20240909145530.25301-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 14:55:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/631

The Radxa ZERO 3{e|w} are ultra-small, high-performance single board computers
based on the Rockchip RK3566, with a compact form factor, and rich interfaces.

	http://radxa.com/products/zeros/zero3e/
	http://radxa.com/products/zeros/zero3w/

common tech specs:
- Rockchip RK3566 (4x Arm Cortex-A55 @ 1.6GHz)
- Arm Mali-G52-2EE (OpenGL ES 1.1/2.0/3.0/3.1/3.2, Vulkan 1.1, OpenCL 2.0)
- LPDDR4 RAM (1/2/3/8 GB)
- µSD
- 1x USB 2.0 Type C OTG, 1x USB 3.0 Type C Host
- 1x µHDMI (1080p @ 60fps)
- 1x MIPI CSI camera port
- colour-coded 40-pin GPIO (uart, spi, i2c, pcm/i2s, pwm, gpio)
- 72mm x 30mm

Radxa ZERO 3e specific tech specs:
- GbE

Radxa ZERO 3w specific tech specs:
- optional onboard eMMC (8/16/32/64 GB)
- IEEE 802.11 b/g/n/ac/ax(WiFi6), BT5.4 with BLE

NOTE: currently support for this board requires a U-Boot fork for the
bootloader, and linux-next for the kernel. Support will probably come in linux
kernel 6.11-ish, at which point U-Boot will then use that kernel's device tree
which means U-Boot support will come after the release of whichever kernel
includes support for this board.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 README                                        |  2 ++
 conf/machine/include/radxa-zero-3.inc         |  8 ++++++
 conf/machine/include/rk3566.inc               | 21 ++++++++++++++++
 conf/machine/radxa-zero-3e.conf               |  7 ++++++
 conf/machine/radxa-zero-3w.conf               |  7 ++++++
 recipes-bsp/rkbin/rockchip-rkbin_git.bb       | 12 +++++++++
 recipes-bsp/u-boot/u-boot_%.bbappend          |  4 +++
 .../linux/linux-torvalds-next_git.bb          | 25 +++++++++++++++++++
 8 files changed, 86 insertions(+)
 create mode 100644 conf/machine/include/radxa-zero-3.inc
 create mode 100644 conf/machine/include/rk3566.inc
 create mode 100644 conf/machine/radxa-zero-3e.conf
 create mode 100644 conf/machine/radxa-zero-3w.conf
 create mode 100644 recipes-kernel/linux/linux-torvalds-next_git.bb

diff --git a/README b/README
index b21e92360dcc..909840de2c0d 100644
--- a/README
+++ b/README
@@ -40,6 +40,8 @@ Status of supported boards:
 		orangepi-5-plus
 		rock-3a
 		rock-4c-plus
+		radxa-zero-3e
+		radxa-zero-3w
 	builds:
 		marsboard-rk3066
 		radxarock
diff --git a/conf/machine/include/radxa-zero-3.inc b/conf/machine/include/radxa-zero-3.inc
new file mode 100644
index 000000000000..1c6f972c1e31
--- /dev/null
+++ b/conf/machine/include/radxa-zero-3.inc
@@ -0,0 +1,8 @@
+MACHINEOVERRIDES =. "radxa-zero-3:"
+
+require conf/machine/include/rk3566.inc
+
+PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
+MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
+
+UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
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
index 000000000000..37792cbf36a5
--- /dev/null
+++ b/conf/machine/radxa-zero-3e.conf
@@ -0,0 +1,7 @@
+#@TYPE: Machine
+#@NAME: Radxa Zero 3E
+#@DESCRIPTION: The Radxa ZERO 3e is an ultra-small, high-performance single board computer based on the Rockchip RK3566, with a compact form factor, and rich interfaces.
+#http://radxa.com/products/zeros/zero3e/
+
+require conf/machine/include/radxa-zero-3.inc
+KERNEL_DEVICETREE = "rockchip/rk3566-radxa-zero-3e.dtb"
diff --git a/conf/machine/radxa-zero-3w.conf b/conf/machine/radxa-zero-3w.conf
new file mode 100644
index 000000000000..5193d45e1f69
--- /dev/null
+++ b/conf/machine/radxa-zero-3w.conf
@@ -0,0 +1,7 @@
+#@TYPE: Machine
+#@NAME: Radxa Zero 3W
+#@DESCRIPTION: The Radxa ZERO 3w is an ultra-small, high-performance single board computer based on the Rockchip RK3566, with a compact form factor, and rich interfaces.
+#http://radxa.com/products/zeros/zero3w/
+
+require conf/machine/include/radxa-zero-3.inc
+KERNEL_DEVICETREE = "rockchip/rk3566-radxa-zero-3w.dtb"
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
index 862ca1377692..c939a487d294 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -2,6 +2,10 @@ require u-boot-rockchip.inc
 
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 
+SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
+SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
+SRCREV:radxa-zero-3:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
+
 SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
 SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
 
diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
new file mode 100644
index 000000000000..6f3db7c61bdf
--- /dev/null
+++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
@@ -0,0 +1,25 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto-dev:"
+
+DESCRIPTION = "Linux Kernel"
+SECTION = "kernel"
+LICENSE = "GPL-2.0-only"
+LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
+
+ERROR_QA:remove = "buildpaths"
+DEFAULT_PREFERENCE = "-1"
+COMPATIBLE_MACHINE = "^$"
+COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
+
+LINUX_VERSION = "6.10-rc3"
+KERNEL_VERSION_SANITY_SKIP = "1"
+PV = "${LINUX_VERSION}+git${SRCPV}"
+SRC_URI = " \
+	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1 \
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


