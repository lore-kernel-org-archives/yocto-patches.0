Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C39AC27C78
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 17:02:05 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web11.14072.1718298124012289721
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Jun 2024 10:02:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ImStFFsu;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b06b78e716so8302976d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718298122; x=1718902922; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IN3Q5taSNJkkorRCCA/ZAwcDJXpTTaNlv9Ih6jtOkfY=;
        b=ImStFFsu9giKFDnF4ytMY+DGQ93NgLoX46wkEEfwo7V0EGHisRdyhsS5Vxi/ANngSp
         iITIiX2nGvq/gYzepxRVmpqaqGP5Wa9niTg6JNIU4G1kWk+S2Q43RxrsBziE7fFolY9R
         LwEktO8dANgkO03F1NAO//GoDYtcbBKlFcU+8FYLYe4TR+Kg6ZeEvAf1p48GgzxXt9hy
         mcQls5Hyo7K4MltocuGzgoEZ/88vGd2Cu26TWg2/jjO7jPuYr5sYz9Wt8VNeJfAjza7h
         f/vjkP60FTQIZ0ceSgx6UhEH3eOwi4IIcJ+HRomin5ireL5vF2mTVzKZGf7hzpiEQcJz
         xkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298122; x=1718902922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IN3Q5taSNJkkorRCCA/ZAwcDJXpTTaNlv9Ih6jtOkfY=;
        b=mj8ergyiiwCdU6u2nJ8awlLoC0BW7I5TPbbq5beyddL/01B6A0FGlwbIswMldAKDLp
         /FQFwsE9BuN9UuOXPjveBKmaC38ihcTeKUAZK8YQ+iQSj9TkAVrLXrJuS5cOQfjRm1il
         dvtLR47arQVl7cx0i6aFfC4c438zzehmKLNc+0yeCuACWod3Lvl25ZsV4tz8ne99dszU
         tI0wtfIAkmEnZl7KoISGM/vX96x/DjmknAisvYhpEPtRnrBFbBv8wkktT9Qs4T0YAEsx
         rv3NGmhDpxJvz/yj3t+muIDQalGuXyLAhqxtx0nIwqGCP/l6n5K6bsgmhD6yE9fdJVOv
         DKew==
X-Gm-Message-State: AOJu0YyLmSkAofo7sBro/0ji9h2pEs6rmOzrkE/0JnGMyR23DMyzj65S
	2jS9AV+jj0XdzuiSbQyJhsBiby5fp53QM7nG0m3fPKPYpRycHZ8aM+Apvg==
X-Google-Smtp-Source: AGHT+IHpY2/+d78GhtfvWSmvHyZ/IHH9i6VGZBGdzkR9kpLT+uyVHSXqGcFfEpXv8smDLeY9LPfT3Q==
X-Received: by 2002:ad4:4f8f:0:b0:6b0:7d9a:79f1 with SMTP id 6a1803df08f44-6b2afd6158bmr1295686d6.42.1718298121967;
        Thu, 13 Jun 2024 10:02:01 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c18209sm8588676d6.42.2024.06.13.10.02.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:02:01 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v3 3/4] radxa-zero-3w: add
Date: Thu, 13 Jun 2024 13:01:53 -0400
Message-ID: <20240613170154.6441-3-twoerner@gmail.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/326

The Radxa ZERO 3e is an ultra-small, high-performance single board computer
based on the Rockchip RK3566, with a compact form factor, and rich interfaces.

	http://radxa.com/products/zeros/zero3w/

tech specs:
- Rockchip RK3566 (4x Arm Cortex-A55 @ 1.6GHz)
- Arm Mali-G52-2EE (OpenGL ES 1.1/2.0/3.0/3.1/3.2, Vulkan 1.1, OpenCL 2.0)
- LPDDR4 RAM (1/2/3/8 GB)
- µSD
- optional onboard eMMC (8/16/32/64 GB)
- IEEE 802.11 b/g/n/ac/ax(WiFi6), BT5.4 with BLE
- 1x USB 2.0 Type C OTG, 1x USB 3.0 Type C Host
- 1x µHDMI (1080p @ 60fps)
- 1x MIPI CSI camera port
- colour-coded 40-pin GPIO (uart, spi, i2c, pcm/i2s, pwm, gpio)
- 72mm x 30mm

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
v3 changes:
- new
---
 README                                          | 1 +
 conf/machine/include/radxa-zero-3.inc           | 6 ++++++
 conf/machine/include/rk3566.inc                 | 1 +
 conf/machine/radxa-zero-3e.conf                 | 7 +------
 conf/machine/radxa-zero-3w.conf                 | 7 +++++++
 recipes-bsp/u-boot/u-boot_%.bbappend            | 6 +++---
 recipes-kernel/linux/linux-torvalds-next_git.bb | 2 +-
 7 files changed, 20 insertions(+), 10 deletions(-)
 create mode 100644 conf/machine/include/radxa-zero-3.inc
 create mode 100644 conf/machine/radxa-zero-3w.conf

diff --git a/README b/README
index a9a040a4308d..909840de2c0d 100644
--- a/README
+++ b/README
@@ -41,6 +41,7 @@ Status of supported boards:
 		rock-3a
 		rock-4c-plus
 		radxa-zero-3e
+		radxa-zero-3w
 	builds:
 		marsboard-rk3066
 		radxarock
diff --git a/conf/machine/include/radxa-zero-3.inc b/conf/machine/include/radxa-zero-3.inc
new file mode 100644
index 000000000000..1cdcaa2214fa
--- /dev/null
+++ b/conf/machine/include/radxa-zero-3.inc
@@ -0,0 +1,6 @@
+require conf/machine/include/rk3566.inc
+
+PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
+MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
+
+UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
index 586d68806df6..64d47c004a1f 100644
--- a/conf/machine/include/rk3566.inc
+++ b/conf/machine/include/rk3566.inc
@@ -5,6 +5,7 @@ DEFAULTTUNE ?= "cortexa55"
 ROCKCHIP_CLOSED_TPL ?= "1"
 
 require conf/machine/include/soc-family.inc
+MACHINEOVERRIDES .= "${@bb.utils.contains_any('MACHINE', 'radxa-zero-3e radxa-zero-3w', ':radxa-zero-3', '', d)}"
 require conf/machine/include/rockchip-defaults.inc
 require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
 require conf/machine/include/rockchip-wic.inc
diff --git a/conf/machine/radxa-zero-3e.conf b/conf/machine/radxa-zero-3e.conf
index 3a39d6c12a1f..37792cbf36a5 100644
--- a/conf/machine/radxa-zero-3e.conf
+++ b/conf/machine/radxa-zero-3e.conf
@@ -3,10 +3,5 @@
 #@DESCRIPTION: The Radxa ZERO 3e is an ultra-small, high-performance single board computer based on the Rockchip RK3566, with a compact form factor, and rich interfaces.
 #http://radxa.com/products/zeros/zero3e/
 
-require conf/machine/include/rk3566.inc
-
-PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
+require conf/machine/include/radxa-zero-3.inc
 KERNEL_DEVICETREE = "rockchip/rk3566-radxa-zero-3e.dtb"
-MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
-
-UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
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
diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index e1ee17ef6905..de7024545841 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -2,9 +2,9 @@ require u-boot-rockchip.inc
 
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 
-SRC_URI:radxa-zero-3e = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
-SRCREV:radxa-zero-3e = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
-SRCREV:radxa-zero-3e:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
+SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
+SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
+SRCREV:radxa-zero-3:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
 
 SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
 SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
index a932f5397771..9a95eb5bc4d8 100644
--- a/recipes-kernel/linux/linux-torvalds-next_git.bb
+++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
@@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
 
 DEFAULT_PREFERENCE = "-1"
 COMPATIBLE_MACHINE = "^$"
-COMPATIBLE_MACHINE:radxa-zero-3e = "radxa-zero-3e"
+COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
 
 LINUX_VERSION = "6.10-rc3"
 PV = "${LINUX_VERSION}+git${SRCPV}"
-- 
2.44.0.478.g7774cfed6261


