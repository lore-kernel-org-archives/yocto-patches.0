Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF96C71135
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:24:10 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.web10.7226.1749810245166434750
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Jun 2025 03:24:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bvFWdRc+;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a6f6d52af7so21471001cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 03:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749810243; x=1750415043; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHITbBw0W+/l5I4U3ygU/ldhMq3mm/H1vFX2SWgxYJQ=;
        b=bvFWdRc+JoEwhWHi2sfwIW+yAouGzpgmNOW98Uyc/6+0eCJtkpQy8upv1iTD8dvaLx
         lX4TshbuDf8Fd51az/XJQcU+0kKmeb2UnM5rTFvv2gMxSMNfsgfvUdZtRRZHZNvnLh0w
         SAjB1e4cm3u2SC0q6rGWyiXiVnco/UWGs4ABhCljs/4UgQftpD1jr4ahQBLZvxdwfudU
         dbYpRxEBrda7h63SE29o77n6RB55M6GkutV5jnOm8OifYVQSiVVA49xi/r83EWQ2fhCZ
         ZiNJJAbinuMHWCEQsC8I9JjuobzOMQDh74/ymKEM6lYnS3BbbawtIZbSXx/5vbPXQ6qh
         7wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749810243; x=1750415043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHITbBw0W+/l5I4U3ygU/ldhMq3mm/H1vFX2SWgxYJQ=;
        b=DPFL5kC+4Sl2qSVO6YV259qDjxkeLs+m/UW+xiuaTc1k7aOQJDhh3QNG8C4n145Iqe
         joDW72IuHenDVfalqlPEESQW/o6A6kPLXNjD2gt8XWAAXMQwN+LAnxBOOJ92Oeio191Z
         ja79Ah/JBDW9gnFWInnuX0g5kA0iPK5OIcmLI8l7St/3/d3zzaiXFJd1Mpp7Z8EKAjPQ
         69MmJIHZJ+Vwq+QwlwxrQzg6JP5vXJW8KBUxMhHbH/SM17tRsTsEXvPpImuh/BfFh2L0
         naSkxNVDLFuz61MN//eksppp7mykb5/MCdacgCgNihfsQnXpKYVgXufayoKIiOuU7FtH
         9E5g==
X-Gm-Message-State: AOJu0YynOEvHbv3w+LYdhn9O1S1P+oSFRbEj4DkiTDhDOhXW8UhYWD4i
	LLRja/IVRxh7ECr65I9x+/tLsZ9pbMxhSiesfbeglLDMcuw8yX7EqdUYj/b6qdoz
X-Gm-Gg: ASbGnctSHiw5dq/7Ez3DCji8YGKCCpR3duqHi3a5niKISki5kAaRsMCb8ThwhzO7/K3
	mrPVViWzPUJa7tkPI7fNLbmmCCADsKmJpihej30ZT5cGOLOcu/VC58mTGMi+RtKqSCIMOY8VNDP
	q2+8xOTszbyAS1jZGyw7m5Php9Uwf5ykynIBni57sNd7zf0Wko7HWEF2TWsiLl2itxlB8vKVlHO
	E873NmkU7kaIcuWPZyx2GnmB3/Riqh70Ia5m3UKgS7Lt+4KPZTapHmQbe7vZET5ML6TQPDuRAkJ
	OsMJMtVK8OTevte1Awkx6zhs/vDBrTpZwws88PXGEELnd7z6wAhcLnbfk9369PwbuNCebwSCrFR
	5aaEAbbscCfh3ANwzyAIcVl2otpXEBFm2XIOC2hU8
X-Google-Smtp-Source: AGHT+IESSX8qsS4P9jIAXAUQDuFW348XNaY+DqxOIggI3HbODDf8rDP2lbXFuYeB++RC1Bq/SYo8GA==
X-Received: by 2002:a05:622a:40c6:b0:4a6:f5a8:3832 with SMTP id d75a77b69052e-4a72ff16c48mr37765921cf.42.1749810243194;
        Fri, 13 Jun 2025 03:24:03 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a2c068esm15502631cf.1.2025.06.13.03.24.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:24:02 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 2/2] fitimage rework
Date: Fri, 13 Jun 2025 06:23:57 -0400
Message-ID: <20250613102357.1539-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20250613102357.1539-1-twoerner@gmail.com>
References: <20250613102357.1539-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 10:24:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1637

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
 conf/machine/include/px30.inc              | 3 +--
 conf/machine/include/rk3066.inc            | 1 +
 conf/machine/include/rk3188.inc            | 1 +
 conf/machine/include/rk3288.inc            | 1 +
 conf/machine/include/rk3308.inc            | 3 +--
 conf/machine/include/rk3328.inc            | 3 +--
 conf/machine/include/rk3399.inc            | 3 +--
 conf/machine/include/rk3566.inc            | 3 +--
 conf/machine/include/rk3568.inc            | 3 +--
 conf/machine/include/rk3588s.inc           | 3 +--
 conf/machine/include/rockchip-defaults.inc | 2 ++
 conf/machine/include/rockchip-extlinux.inc | 8 ++++----
 conf/machine/include/rockchip-fitimage.inc | 4 ++++
 13 files changed, 20 insertions(+), 18 deletions(-)
 create mode 100644 conf/machine/include/rockchip-fitimage.inc

diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
index 8173cb19be2c..825c1fae76d7 100644
--- a/conf/machine/include/px30.inc
+++ b/conf/machine/include/px30.inc
@@ -11,8 +11,7 @@ require conf/machine/include/arm/armv8a/tune-cortexa35.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
+require conf/machine/include/rockchip-fitimage.inc
 
 TFA_PLATFORM = "px30"
 TFA_BUILD_TARGET = "bl31"
diff --git a/conf/machine/include/rk3066.inc b/conf/machine/include/rk3066.inc
index a898309bbf88..dc0c7734812c 100644
--- a/conf/machine/include/rk3066.inc
+++ b/conf/machine/include/rk3066.inc
@@ -9,6 +9,7 @@ require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 
 SERIAL_CONSOLES = "115200;ttyS2"
 
+RK_FITIMAGE = "False"
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3066 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_IMAGETYPE ?= "zImage"
diff --git a/conf/machine/include/rk3188.inc b/conf/machine/include/rk3188.inc
index 554d4f1c904d..3e1fc7e70822 100644
--- a/conf/machine/include/rk3188.inc
+++ b/conf/machine/include/rk3188.inc
@@ -9,6 +9,7 @@ require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 
 SERIAL_CONSOLES = "115200;ttyFIQ0"
 
+RK_FITIMAGE = "False"
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3188 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_IMAGETYPE ?= "zImage"
diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
index 06fda69a3eb7..5cc117e633fc 100644
--- a/conf/machine/include/rk3288.inc
+++ b/conf/machine/include/rk3288.inc
@@ -9,6 +9,7 @@ require conf/machine/include/arm/armv7a/tune-cortexa17.inc
 
 SERIAL_CONSOLES = "115200;ttyS2"
 
+RK_FITIMAGE = "False"
 KBUILD_DEFCONFIG ?= "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3288 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_IMAGETYPE ?= "zImage"
diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
index d30901f15b4f..ce1cebee1aac 100644
--- a/conf/machine/include/rk3308.inc
+++ b/conf/machine/include/rk3308.inc
@@ -13,8 +13,7 @@ SERIAL_CONSOLES = "1500000;ttyS0"
 
 KBUILD_DEFCONFIG ?= "defconfig"
 KERNEL_FEATURES:append:rk3308 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
+require conf/machine/include/rockchip-fitimage.inc
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
index e6f810dcd2ca..4924b06f030a 100644
--- a/conf/machine/include/rk3328.inc
+++ b/conf/machine/include/rk3328.inc
@@ -12,8 +12,7 @@ require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
 KERNEL_FEATURES:append:rk3328 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
+require conf/machine/include/rockchip-fitimage.inc
 
 TFA_PLATFORM = "rk3328"
 TFA_BUILD_TARGET = "bl31"
diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
index cd1be49064ed..eb23f49370fc 100644
--- a/conf/machine/include/rk3399.inc
+++ b/conf/machine/include/rk3399.inc
@@ -12,8 +12,7 @@ require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
 KERNEL_FEATURES:append:rk3399 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
+require conf/machine/include/rockchip-fitimage.inc
 
 TFA_PLATFORM = "rk3399"
 TFA_BUILD_TARGET = "bl31"
diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
index 6386ec7eb51c..c9647a66aa42 100644
--- a/conf/machine/include/rk3566.inc
+++ b/conf/machine/include/rk3566.inc
@@ -11,8 +11,7 @@ require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
 KERNEL_FEATURES:append:rk3566 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
+require conf/machine/include/rockchip-fitimage.inc
 
 PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
 PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
index bcf9dd8b0f44..e89aa388951a 100644
--- a/conf/machine/include/rk3568.inc
+++ b/conf/machine/include/rk3568.inc
@@ -11,8 +11,7 @@ require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
 KERNEL_FEATURES:append:rk3568 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
+require conf/machine/include/rockchip-fitimage.inc
 
 PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
 PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index 6ec344abae5b..265244753b5a 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -10,8 +10,7 @@ require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
 KERNEL_FEATURES:append:rk3588s = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
+require conf/machine/include/rockchip-fitimage.inc
 
 PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
 PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
diff --git a/conf/machine/include/rockchip-defaults.inc b/conf/machine/include/rockchip-defaults.inc
index 85ec7b944d1d..3835408ed8d2 100644
--- a/conf/machine/include/rockchip-defaults.inc
+++ b/conf/machine/include/rockchip-defaults.inc
@@ -1,7 +1,9 @@
 # meta-rockchip default settings
 MACHINEOVERRIDES =. "${@bb.utils.contains('ROCKCHIP_CLOSED_TPL', '1', 'closed-tpl:', '', d)}"
 MACHINEOVERRIDES =. "rockchip:"
+
 # kernel
+RK_FITIMAGE ?= "True"
 PREFERRED_PROVIDER_virtual/kernel ?= "linux-yocto"
 KCONFIG_MODE ?= "alldefconfig"
 
diff --git a/conf/machine/include/rockchip-extlinux.inc b/conf/machine/include/rockchip-extlinux.inc
index fddab735bbf7..95a38d4dad0c 100644
--- a/conf/machine/include/rockchip-extlinux.inc
+++ b/conf/machine/include/rockchip-extlinux.inc
@@ -13,13 +13,13 @@ NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split()[0].split('/')[1]}"
 
 UBOOT_EXTLINUX ?= "1"
 UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=rootfsA"
-UBOOT_EXTLINUX_FDTDIR ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"
-UBOOT_EXTLINUX_FDT ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot/${NONFITDT}', d)}"
+UBOOT_EXTLINUX_FDTDIR ?= "${@ '' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE'),False) else '/boot'}"
+UBOOT_EXTLINUX_FDT ?= "${@ '' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE'),False) else '/boot/${NONFITDT}'}"
 UBOOT_EXTLINUX_CONSOLE ?= "earlycon console=tty1 console=${RK_CONSOLE_DEVICE},${RK_CONSOLE_BAUD}n8"
 UBOOT_EXTLINUX_KERNEL_ARGS ?= "rootwait rw rootfstype=ext4"
-UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${KERNEL_IMAGETYPE}"
+UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${@ 'fitImage' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE'),False) else '${KERNEL_IMAGETYPE}'}"
 UBOOT_EXTLINUX_LABELS ?= "default"
 UBOOT_EXTLINUX_MENU_DESCRIPTION:default ?= "${MACHINE}"
 
 MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "u-boot-extlinux"
-MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "kernel-image ${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', 'kernel-devicetree', d)}"
+MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "${@ 'linux-yocto-fitimage' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE'),False) else 'kernel-devicetree'}"
diff --git a/conf/machine/include/rockchip-fitimage.inc b/conf/machine/include/rockchip-fitimage.inc
new file mode 100644
index 000000000000..e275faf70349
--- /dev/null
+++ b/conf/machine/include/rockchip-fitimage.inc
@@ -0,0 +1,4 @@
+KERNEL_CLASSES += "kernel-fit-extra-artifacts"
+KERNEL_IMAGETYPE = "Image"
+RRECOMMENDS:${KERNEL_PACKAGE_NAME}-base = ""
+KERNEL_DEPLOY_DEPEND = "linux-yocto-fitimage:do_deploy"
-- 
2.44.0.501.g19981daefd7c


