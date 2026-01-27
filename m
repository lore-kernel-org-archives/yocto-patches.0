Return-Path: <mbober1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55BDD2FEE3
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 20:52:02 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22358.1769547116159554688
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 12:51:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Pj8/xJ3q;
 spf=pass (domain: gmail.com, ip: 209.85.208.42, mailfrom: mbober1@gmail.com)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so9171002a12.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 12:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769547114; x=1770151914; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYoYtgTWllXTfROBqEyAaPc/BS6Li+4t7IPMzTe1GyU=;
        b=Pj8/xJ3qn3xyh+8RE+ouDShsVusMAvCvlo5t44GqlPlt7nN3FuwBF+mvRhqO5fJl4c
         mqSwMK6elrq1pMtoD5zAIAunXESXRwyRMoW9UWU/qXOPYGgW/3E7fBcKanNMLJpHRRT0
         bFgZVDmWR3Xu53pWAjEArW3adgVJVaCpEmn9nH63BJjKdfjjTRA7Vgmn4i789/qcMAll
         LPN5XxDfoC3HefIRSXwPyu+y35NkBPflanXyukahk3RqFtK8KdwbUoCt12Myrx+FQFCz
         H03cW4PMJH226f1sCt3NSBj9zLu/USi+F7YgV3BNc7e+p+FVN7olYAyNETaJ+WnTsj8r
         UUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769547114; x=1770151914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYoYtgTWllXTfROBqEyAaPc/BS6Li+4t7IPMzTe1GyU=;
        b=lG5nd2maO94f3lt3CZpNrlt7vBoZ7Rcmi3uE0wfAD1/DBd8i78nWFFipIbtN4ABeKn
         RrpQ5z6NeaekvQktmkBzc17Hbs6WnU5OCWR92hM0JOJVsKPguVnDbqtsQ3kUVDt5aap3
         2vgXBsDLEhESX6usxmW+stia9k13gVEOLV9RwOEdwxLaFa6zlRaeYYFRPsKNPDJjPYdy
         SlwENEVJH24nhErp3ZfA3HLEiNrvUjSjPEt7aFClXWZ64fmAd1v+9hGr0WsbMNK7AbPc
         Nm9Fpj7Ujr45+2lSuH/nOkan7l+4Yny/GQc9jWjzIJCWj3hlkkJthc4BE0/UBzrYNhh0
         3scQ==
X-Gm-Message-State: AOJu0YzldQrDa2HAv0RNfHRC269Ps8QyH1+4Fz80AwTPo3M76DOfI8kN
	KfvELwkeAkX836DPhHZaRwYshS+773lq8GtK3ET0Y5KOCLW4e2mnFkAjZmE4pA==
X-Gm-Gg: AZuq6aKsjScSxEHV1YqKncPzP+FvjY/zOu4bMg6CFRRUKgOQLiUPyR1QuZvCKQRXZjD
	1jbEnsS1XX1+geV701UBAvRIS6WLANLRPOlNZDmUzatyFWUcYyeg79R9NV1qC7uUvRVUUluBTVv
	qLNJquEstJyUAhoGMvElBdTCO/nUkW+2H6kMiG5vCYpOmU4d/Xa5VbRW/6N0EL278OaQMnHJ76J
	IO4OHdOxwGJhCR4ieGW7CiHM0aDWRChqcs0BDtMVN+0c7dhHcszZbojI93Yo3oV+YWLRgsri43h
	AD0LgUxtm1taWbAY1CgVh7Yw2kAo09EghrDLXo9QkmpTM7SJp1hzhyqDoWb2mbHkSLidhU5Dm4v
	BRZAcdxbpJvlbp4Npqe/LaPcKpVOGBGvUMFAhJ2nSNnOEE+eMdf+Wt8Hs2ClDCOa6aukoKubz6g
	NS0pV5W+JNsm5zeqLioKIdAJKDLtZcI+jejJEWEsdievpakkedDA2tc8Xa+XVHJKBDB4JnJl+Ma
	4H4MnkJvM8=
X-Received: by 2002:a17:907:3e90:b0:b86:f194:9ee9 with SMTP id a640c23a62f3a-b8dab2e793bmr217818566b.19.1769547113958;
        Tue, 27 Jan 2026 12:51:53 -0800 (PST)
Received: from fedora (87-205-19-211.static.ip.netia.com.pl. [87.205.19.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbeffe6edsm29561066b.30.2026.01.27.12.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 12:51:53 -0800 (PST)
From: Marcin Bober <mbober1@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: mbober1@gmail.com
Subject: [meta-rockchip][PATCH] luckfox-lyra-plus: add
Date: Tue, 27 Jan 2026 21:51:41 +0100
Message-ID: <20260127205141.26089-1-mbober1@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 20:52:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3119

The Luckfox Lyra Plus is ultra-small, tri-core single board computer
based on the Rockchip RK3506G2, with a very compact form factor.

Signed-off-by: Marcin Bober <mbober1@gmail.com>
---
 README                                        |  1 +
 conf/machine/include/rk3506.inc               | 20 +++++++++++++
 conf/machine/include/rk3568.inc               |  1 -
 conf/machine/include/rk3588s.inc              |  1 -
 conf/machine/luckfox-lyra-plus.conf           | 27 +++++++++++++++++
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb   |  9 ++++++
 .../rkbin/rockchip-rkbin-optee-os_git.bb      |  5 ++++
 recipes-bsp/rkbin/rockchip-rkbin.inc          |  1 +
 recipes-bsp/u-boot/u-boot-rockchip.inc        |  2 ++
 recipes-bsp/u-boot/u-boot_%.bbappend          |  4 +++
 recipes-kernel/linux/linux-armbian_git.bb     | 29 +++++++++++++++++++
 11 files changed, 98 insertions(+), 2 deletions(-)
 create mode 100644 conf/machine/include/rk3506.inc
 create mode 100644 conf/machine/luckfox-lyra-plus.conf
 create mode 100644 recipes-kernel/linux/linux-armbian_git.bb

diff --git a/README b/README
index 6bceba0..3991415 100644
--- a/README
+++ b/README
@@ -23,6 +23,7 @@ Status of supported boards:
 			tinker-board
 			tinker-board-s
 			vyasa-rk3288
+			luckfox-lyra-plus
 
 		64-bit:
 			nanopi-m4
diff --git a/conf/machine/include/rk3506.inc b/conf/machine/include/rk3506.inc
new file mode 100644
index 0000000..e204283
--- /dev/null
+++ b/conf/machine/include/rk3506.inc
@@ -0,0 +1,20 @@
+MACHINEOVERRIDES =. "rk3506:"
+SOC_FAMILY = "rk3506"
+DEFAULTTUNE = "cortexa7thf-neon-vfpv4"
+
+ROCKCHIP_CLOSED_TPL ?= "1"
+
+require conf/machine/include/soc-family.inc
+require conf/machine/include/rockchip-defaults.inc
+require conf/machine/include/arm/armv7a/tune-cortexa7.inc
+require conf/machine/include/rockchip-wic.inc
+
+PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
+
+KBUILD_DEFCONFIG ?= "rk3506_defconfig"
+KERNEL_CLASSES = "kernel-fitimage"
+KERNEL_IMAGETYPE ?= "fitImage"
+
+UBOOT_SUFFIX ?= "itb"
+UBOOT_ENTRYPOINT ?= "0x02800000"
+UBOOT_EXTLINUX_FDT = "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"
diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
index bcf9dd8..12f0ba2 100644
--- a/conf/machine/include/rk3568.inc
+++ b/conf/machine/include/rk3568.inc
@@ -10,7 +10,6 @@ require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
-KERNEL_FEATURES:append:rk3568 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
 KERNEL_CLASSES = "kernel-fitimage"
 KERNEL_IMAGETYPE ?= "fitImage"
 
diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index 6ec344a..d0654c1 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -9,7 +9,6 @@ require conf/machine/include/arm/armv8-2a/tune-cortexa76-cortexa55.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
-KERNEL_FEATURES:append:rk3588s = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
 KERNEL_CLASSES = "kernel-fitimage"
 KERNEL_IMAGETYPE ?= "fitImage"
 
diff --git a/conf/machine/luckfox-lyra-plus.conf b/conf/machine/luckfox-lyra-plus.conf
new file mode 100644
index 0000000..529a472
--- /dev/null
+++ b/conf/machine/luckfox-lyra-plus.conf
@@ -0,0 +1,27 @@
+#@TYPE: Machine
+#@NAME: Luckfox Lyra Plus
+#@DESCRIPTION: RK3506G2 based Linux Micro Development Board
+#https://www.luckfox.com/Luckfox-Lyra-Plus
+
+require conf/machine/include/rk3506.inc
+
+KERNEL_DEVICETREE ?= "rk3506g-luckfox-lyra-plus-sd.dtb"
+MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
+PREFERRED_PROVIDER_virtual/kernel = "linux-armbian"
+EXTERNAL_KERNEL_DEVICETREE = "${DEPLOY_DIR_IMAGE}/devicetree"
+
+UBOOT_MACHINE = "luckfox-lyra-rk3506_defconfig"
+
+MACHINE_FEATURES = " \
+  rtc \
+  screen \
+  serial \
+  usbgadget \
+  usbhost \
+  vfat \
+"
+
+KERNEL_FEATURES += " \
+  cfg/fs/ext4.scc \
+  features/cgroups/cgroups.scc \
+"
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
index 3227a53..7f654ff 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
@@ -10,6 +10,15 @@ do_deploy:rk3308() {
 	install -m 644 ${S}/bin/rk33/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin
 }
 
+DDRBIN_VERS:rk3506 ?= "v1.02"
+DDRBIN_FILE:rk3506 ?= "rk3506_ddr_750MHz_${DDRBIN_VERS}.bin"
+
+do_deploy:rk3506() {
+	# Prebuilt U-Boot TPL (DDR init)
+	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3506.bin
+	install -m 644 ${S}/bin/rk35/rk3506_tee_v1.23.bin ${DEPLOYDIR}/tee-rk3506.bin
+}
+
 DDRBIN_VERS:rk3566 ?= "v1.23"
 DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
 
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
index 6d25368..cbd376c 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
@@ -9,6 +9,11 @@ do_deploy:rk3308() {
 	install -m 644 ${S}/bin/rk33/rk3308_bl32_v*.bin ${DEPLOYDIR}/tee-rk3308.bin
 }
 
+do_deploy:rk3506() {
+	# Prebuilt OPTEE-OS
+	install -m 644 ${S}/bin/rk35/rk3506_tee_v*.bin ${DEPLOYDIR}/tee-rk3506.bin
+}
+
 # NOTE: the following are not typos
 #       the rk3566 uses the same bl32 as the rk3568
 do_deploy:rk3566() {
diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
index 9264db9..8dfdc09 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -11,6 +11,7 @@ S = "${WORKDIR}/git"
 
 COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:rk3308 = "rk3308"
+COMPATIBLE_MACHINE:rk3506 = "rk3506"
 COMPATIBLE_MACHINE:rk3566 = "rk3566"
 COMPATIBLE_MACHINE:rk3568 = "rk3568"
 COMPATIBLE_MACHINE:rk3588s = "rk3588s"
diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc b/recipes-bsp/u-boot/u-boot-rockchip.inc
index 2b5bbd7..67c4418 100644
--- a/recipes-bsp/u-boot/u-boot-rockchip.inc
+++ b/recipes-bsp/u-boot/u-boot-rockchip.inc
@@ -11,7 +11,9 @@ do_compile[depends] .= "${TFA_DEPENDS}"
 ROCKCHIP_TPL:closed-tpl = "${DEPLOY_DIR_IMAGE}/ddr-${SOC_FAMILY}.bin"
 # SOC_FAMILY for RK3588S is rk3588s but it should use the binaries from rk3588
 ROCKCHIP_TPL:closed-tpl:rk3588s = "${DEPLOY_DIR_IMAGE}/ddr-rk3588.bin"
+ROCKCHIP_TEE:closed-tpl:rk3506 = "${DEPLOY_DIR_IMAGE}/tee-rk3506.bin"
 EXTRA_OEMAKE:append:closed-tpl = " ROCKCHIP_TPL=${ROCKCHIP_TPL}"
+EXTRA_OEMAKE:append:closed-tpl:rk3506 = " TEE=${ROCKCHIP_TEE}"
 
 INIT_FIRMWARE_DEPENDS ??= ""
 INIT_FIRMWARE_DEPENDS:closed-tpl = " rockchip-rkbin-ddr:do_deploy"
diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index 08e1730..fc6a36e 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -8,6 +8,10 @@ DEPENDS:append:rk3308 = " u-boot-tools-native"
 DEPENDS:append:rock-pi-4 = " gnutls-native"
 DEPENDS:append:rk-u-boot-env = " u-boot-mkenvimage-native"
 
+BRANCH:luckfox-lyra-plus = "rk3506"
+SRC_URI:luckfox-lyra-plus = "git://source.denx.de/u-boot/contributors/kwiboo/u-boot.git;protocol=https;branch=${BRANCH}"
+SRCREV:luckfox-lyra-plus = "c6782a37feee4a8aee08d321c01b4ca0b0562f0b"
+
 do_compile:append:rock2-square () {
 	# copy to default search path
 	if [ "${SPL_BINARY}" = "u-boot-spl-dtb.bin" ]; then
diff --git a/recipes-kernel/linux/linux-armbian_git.bb b/recipes-kernel/linux/linux-armbian_git.bb
new file mode 100644
index 0000000..42dad4f
--- /dev/null
+++ b/recipes-kernel/linux/linux-armbian_git.bb
@@ -0,0 +1,29 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+
+DESCRIPTION = "Linux Kernel"
+SECTION = "kernel"
+LICENSE = "GPL-2.0-only"
+LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
+
+LINUX_VERSION = "6.1.115"
+KBRANCH = "rk-6.1-rkr5.1"
+SRCREV_kernel = "b908c7339f51eddcfe8402cd15d1e1f8f4e67c29"
+SRCREV_yocto-meta = "7545dc5bc77560f4b1b6efc47b56e953dc86572d"
+PV = "${LINUX_VERSION}"
+
+SRC_URI = " \
+	git://github.com/armbian/linux-rockchip.git;name=kernel;protocol=https;branch=${KBRANCH} \
+	git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=yocto-meta;branch=yocto-6.1;destsuffix=kernel-meta;protocol=https \
+"
+
+DEPENDS += "lzop-native"
+FIT_KERNEL_COMP_ALG ?= "lzo"
+FIT_KERNEL_COMP_ALG_EXTENSION ?= ".lzo"
+
+COMPATIBLE_MACHINE:luckfox-lyra-plus = "luckfox-lyra-plus"
+
+inherit kernel
+inherit kernel-yocto
+require recipes-kernel/linux/linux-yocto.inc
+
+INSANE_SKIP:${PN}-src += "buildpaths"

