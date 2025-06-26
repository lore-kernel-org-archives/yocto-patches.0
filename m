Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFC0C7EE2A
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 03:18:19 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web10.144.1750907895759592312
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 20:18:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gYU0e7sX;
 spf=pass (domain: gmail.com, ip: 209.85.160.172, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a58d95ea53so7044661cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 20:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750907894; x=1751512694; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bAISz4HLRJZqMHexz8kY8cqbnSbi1i4plISjOwvfnBQ=;
        b=gYU0e7sX4baJX0AF2JgvCI1toZhcfo1Cvm4cE3kCdFS1O8PwCl3QYddeRlUGNVA2DK
         i6twBQmEttkea0FeWBOmHuwn5hosG7Mx322vCR/ffzT2H14uANeXXWOZKc3WB2zJip/V
         tm7GVFr/91DO5tHPbxy3S74ZOJwuUAo6FZcd4a7+mGrdBG8PP9PCtIcCVhjXiabfiL02
         bnhOSc3mLXLjX52wc6KGXJIi7Zcb91e9k/LXBECKsSSh/xAvppLa8z9QMGoJVEUR1W7F
         N8vOJWdEChdC/y11ppzXSFIfYJTzoVcHktl5jb2KtLHlBTbrKXo3HtD8KKSJJOX2+2M5
         dHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750907894; x=1751512694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAISz4HLRJZqMHexz8kY8cqbnSbi1i4plISjOwvfnBQ=;
        b=pM8jXWYwJijKOaLmGgiLI7OXV3xZ10ny813l+ZiB6haNCgbuJ8a8ih+ML5trou9RXl
         NOqHubEBfK9qEnUPq7unfYEPCndUIyE9fcIchc7SgWCFdY1Ai7rq7/yaJzgwdnXRoss1
         aIcNCMYuBk3J33QV9zcyBs2jYIoNAkBBvgbN/idSLQsz7M+7JAfi9DAyZTCKFRB0P13h
         RaMS23z2bpfyTWSMc2alwi8rV5sYxQOSMtO6bBBepwdcHvul6MugEicusdPIPpJ0sFol
         xzBfQH3A06txMdD9/JzTcL/NnKLnKDAvTSz+GDDly5zp44LomYuXRy76GJ0CSkZu1/9Q
         CrsQ==
X-Gm-Message-State: AOJu0Yz/qoEq43HjgKJ1o3kquD609rLHjehbcKTZFS0infU7OJafVm+7
	28QOgF6KqUndZO7GEq/I6ymGCfkArvBUaoWCMi4ngwSEiljHzjyuJCwKnj0kt/Rd
X-Gm-Gg: ASbGncvERjIv6OE9yWid1+LYnBnBUagWBaZdAom00Ee+B9WkKhXpBTPdSRyq6Cd4Z3v
	IMB222mk24MfdDAQS0CvEc/Ay7JwvWC+1zwotV0SYNvTbRcotYDZlN5g8g9qFWNGXcXd08ubjqm
	aOH6QJAXfQlgDZLpWDhD25MOMDL2UfZaf7LDor0+NWTCVmpDgRkCxDDgFD02i7VX98HUvvWwqad
	IaBgUG05Vv6yMB3rzADBvDdBGkYssCBVDswJRSz9pEvVcOBUJB05nQT9MSkWCHeJbptCY60rSfn
	w5qp+hq06tHuj9FKLwIqePIxOGWnXWWxxGGS9Jp9eL1abK18z8wrY8ONeIeqF/y21u2IJc1cp9z
	tlGUXafNXYtVniv+eENrfXdEbEVzZpxYboMCj01U4
X-Google-Smtp-Source: AGHT+IE0cb35OfDMbeE9shknNYTbMDCSQN2KB4yF5OXBMHw7fO5P631wt0Bk9ApGPHl2dENiXYM2vA==
X-Received: by 2002:a05:622a:2586:b0:4a7:944:9af6 with SMTP id d75a77b69052e-4a7f2db5f6bmr29292601cf.3.1750907893849;
        Wed, 25 Jun 2025 20:18:13 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779d66e81sm67170561cf.26.2025.06.25.20.18.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 20:18:13 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v4] fitimage rework
Date: Wed, 25 Jun 2025 23:18:10 -0400
Message-ID: <20250626031810.35828-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 03:18:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1695

oe-core has completely re-written the fitImage support starting roughly at
commit [1], update meta-rockchip to match.

Most of the MACHINEs in meta-rockchip use a fitImage for the kernel, but
some don't. Create a boolean variable (RK_KERNEL_FITIMAGE), enabled by
default, to keep track of which ones do and which ones don't. Use this
variable to decide how to configure various image-related fields.

Build tested with all meta-rockchip MACHINEs both with and without RAUC.

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
changes in v4:
- rename the variable to RK_KERNEL_FITIMAGE
- update the README, variable name, and comments to emphasize the fitImage
  is kernel-related (and does not pertain to other fit-able components)
- use ?= so the RK_KERNEL_FITIMAGE value can be changed by the user
- the location of the RK_KERNEL_FITIMAGE variable is not arbitrary (as
  it may be for other variables) add a comment to this effect
- re-organize the fit and non-fit values to do away with adding two new
  files (rockchip-fitimage.inc and rockchip-unfitimage.inc) so as to add
  only one (rockchip-fitimage.inc); set all non-fit values as defaults
  to be over-ridden in the rockchip-fitimage.inc file as required

changes in v3:
- remove the 2nd MACHINE_ESSENTIAL_EXTRA_RDEPENDS from the
  rockchip-extlinux.inc file and place the relevant portions into either
  the rockchip-fitimage.inc or rockchip-unfitimage.inc files as
  appropriate

changes in v2:
- remove the ",False" from the bb.utils.to_boolean() calls
- add information on new param (RK_FITIMAGE) to README
- re-structure the fitimage require so it is less invasive in
  MACHINE.conf files
---
 README                                     | 10 ++++++++++
 conf/machine/include/px30.inc              |  2 --
 conf/machine/include/rk3066.inc            |  2 +-
 conf/machine/include/rk3188.inc            |  2 +-
 conf/machine/include/rk3288.inc            |  2 +-
 conf/machine/include/rk3308.inc            |  2 --
 conf/machine/include/rk3328.inc            |  2 --
 conf/machine/include/rk3399.inc            |  2 --
 conf/machine/include/rk3566.inc            |  2 --
 conf/machine/include/rk3568.inc            |  2 --
 conf/machine/include/rk3588s.inc           |  2 --
 conf/machine/include/rockchip-defaults.inc |  7 +++++++
 conf/machine/include/rockchip-extlinux.inc |  7 +++----
 conf/machine/include/rockchip-fitimage.inc |  5 +++++
 14 files changed, 28 insertions(+), 21 deletions(-)
 create mode 100644 conf/machine/include/rockchip-fitimage.inc

diff --git a/README b/README
index 9672c6ab8d5b..985101b1b5c3 100644
--- a/README
+++ b/README
@@ -159,6 +159,16 @@ Notes:
 	compatible (see Rockchip Media Process Platform (MPP) and
 	downstream gstreamer-rockchip plugin for those kernels).
 
+  RK_KERNEL_FITIMAGE
+
+	When generating an image, the BSP code needs to know whether or not to
+	package the kernel pieces as a fitImage or not. By default it is assumed
+	most MACHINEs will use the fitImage format. Otherwise disable the
+	RK_KERNEL_FITIMAGE variable boolean to indicate otherwise.
+
+	NOTE: this variable must be set before any include/require in the
+	      machine configuration file
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
index a898309bbf88..2829a68431a8 100644
--- a/conf/machine/include/rk3066.inc
+++ b/conf/machine/include/rk3066.inc
@@ -2,6 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SOC_FAMILY = "rk3066"
+RK_KERNEL_FITIMAGE ?= "False"
 
 require conf/machine/include/soc-family.inc
 require conf/machine/include/rockchip-defaults.inc
@@ -11,6 +12,5 @@ SERIAL_CONSOLES = "115200;ttyS2"
 
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3066 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
-KERNEL_IMAGETYPE ?= "zImage"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3188.inc b/conf/machine/include/rk3188.inc
index 554d4f1c904d..1af745524bfa 100644
--- a/conf/machine/include/rk3188.inc
+++ b/conf/machine/include/rk3188.inc
@@ -2,6 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SOC_FAMILY  = "rk3188"
+RK_KERNEL_FITIMAGE ?= "False"
 
 require conf/machine/include/soc-family.inc
 require conf/machine/include/rockchip-defaults.inc
@@ -11,6 +12,5 @@ SERIAL_CONSOLES = "115200;ttyFIQ0"
 
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3188 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
-KERNEL_IMAGETYPE ?= "zImage"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
index 06fda69a3eb7..a648b440105f 100644
--- a/conf/machine/include/rk3288.inc
+++ b/conf/machine/include/rk3288.inc
@@ -2,6 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SOC_FAMILY = "rk3288"
+RK_KERNEL_FITIMAGE ?= "False"
 
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
index 85ec7b944d1d..fc8930635fbe 100644
--- a/conf/machine/include/rockchip-defaults.inc
+++ b/conf/machine/include/rockchip-defaults.inc
@@ -1,9 +1,16 @@
 # meta-rockchip default settings
 MACHINEOVERRIDES =. "${@bb.utils.contains('ROCKCHIP_CLOSED_TPL', '1', 'closed-tpl:', '', d)}"
 MACHINEOVERRIDES =. "rockchip:"
+
 # kernel
+# RK_KERNEL_FITIMAGE needs to be set before the next "require ..."
+RK_KERNEL_FITIMAGE ?= "True"
 PREFERRED_PROVIDER_virtual/kernel ?= "linux-yocto"
 KCONFIG_MODE ?= "alldefconfig"
+KERNEL_IMAGETYPE ??= "zImage"
+MACHINE_ESSENTIAL_EXTRA_RDEPENDS_KERNEL += "kernel-devicetree"
+MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "${MACHINE_ESSENTIAL_EXTRA_RDEPENDS_KERNEL}"
+require ${@ 'conf/machine/include/rockchip-fitimage.inc' if bb.utils.to_boolean(d.getVar('RK_KERNEL_FITIMAGE')) else ''}
 
 # xserver
 XSERVER = " \
diff --git a/conf/machine/include/rockchip-extlinux.inc b/conf/machine/include/rockchip-extlinux.inc
index fddab735bbf7..20f339675483 100644
--- a/conf/machine/include/rockchip-extlinux.inc
+++ b/conf/machine/include/rockchip-extlinux.inc
@@ -13,13 +13,12 @@ NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split()[0].split('/')[1]}"
 
 UBOOT_EXTLINUX ?= "1"
 UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=rootfsA"
-UBOOT_EXTLINUX_FDTDIR ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"
-UBOOT_EXTLINUX_FDT ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot/${NONFITDT}', d)}"
+UBOOT_EXTLINUX_FDTDIR ?= "${@ '' if bb.utils.to_boolean(d.getVar('RK_KERNEL_FITIMAGE')) else '/boot'}"
+UBOOT_EXTLINUX_FDT ?= "${@ '' if bb.utils.to_boolean(d.getVar('RK_KERNEL_FITIMAGE')) else '/boot/${NONFITDT}'}"
 UBOOT_EXTLINUX_CONSOLE ?= "earlycon console=tty1 console=${RK_CONSOLE_DEVICE},${RK_CONSOLE_BAUD}n8"
 UBOOT_EXTLINUX_KERNEL_ARGS ?= "rootwait rw rootfstype=ext4"
-UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${KERNEL_IMAGETYPE}"
+UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${@ 'fitImage' if bb.utils.to_boolean(d.getVar('RK_KERNEL_FITIMAGE')) else '${KERNEL_IMAGETYPE}'}"
 UBOOT_EXTLINUX_LABELS ?= "default"
 UBOOT_EXTLINUX_MENU_DESCRIPTION:default ?= "${MACHINE}"
 
 MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "u-boot-extlinux"
-MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "kernel-image ${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', 'kernel-devicetree', d)}"
diff --git a/conf/machine/include/rockchip-fitimage.inc b/conf/machine/include/rockchip-fitimage.inc
new file mode 100644
index 000000000000..b09a9fe40825
--- /dev/null
+++ b/conf/machine/include/rockchip-fitimage.inc
@@ -0,0 +1,5 @@
+KERNEL_CLASSES += "kernel-fit-extra-artifacts"
+KERNEL_IMAGETYPE ?= "Image"
+RRECOMMENDS:${KERNEL_PACKAGE_NAME}-base = ""
+KERNEL_DEPLOY_DEPEND ?= "linux-yocto-fitimage:do_deploy"
+MACHINE_ESSENTIAL_EXTRA_RDEPENDS_KERNEL = "linux-yocto-fitimage"
-- 
2.44.0.501.g19981daefd7c


