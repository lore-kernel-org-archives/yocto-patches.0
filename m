Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0878EC25B77
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 16:03:24 +0000 (UTC)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
 by mx.groups.io with SMTP id smtpd.web10.20584.1715789001348282109
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 09:03:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.13, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VfdLJ05xCzck9;
	Wed, 15 May 2024 18:03:20 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VfdLH4htRzZKK;
	Wed, 15 May 2024 18:03:19 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 15 May 2024 18:02:59 +0200
Subject: [PATCH meta-rockchip v2 05/16] add rockchip MACHINEOVERRIDES
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-rk3588-family-v2-5-f81897a3ac50@cherry.de>
References: <20240515-rk3588-family-v2-0-f81897a3ac50@cherry.de>
In-Reply-To: <20240515-rk3588-family-v2-0-f81897a3ac50@cherry.de>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 yocto-patches@lists.yoctoproject.org
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 May 2024 16:03:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/145

From: Quentin Schulz <quentin.schulz@cherry.de>

Add "rockchip" to the MACHINEOVERRIDES so that it can be used to easily
identify things that apply only to Rockchip-based devices and keeping
other devices untouched.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/px30.inc              | 2 +-
 conf/machine/include/rk3066.inc            | 2 +-
 conf/machine/include/rk3188.inc            | 2 +-
 conf/machine/include/rk3288.inc            | 2 +-
 conf/machine/include/rk3308.inc            | 2 +-
 conf/machine/include/rk3328.inc            | 2 +-
 conf/machine/include/rk3399.inc            | 2 +-
 conf/machine/include/rk3568.inc            | 2 +-
 conf/machine/include/rk3588s.inc           | 2 +-
 conf/machine/include/rockchip-defaults.inc | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
index badcbcd..d78409e 100644
--- a/conf/machine/include/px30.inc
+++ b/conf/machine/include/px30.inc
@@ -6,8 +6,8 @@ SOC_FAMILY = "px30"
 DEFAULTTUNE ?= "cortexa35-crypto"
 
 require conf/machine/include/soc-family.inc
-require conf/machine/include/arm/armv8a/tune-cortexa35.inc
 require conf/machine/include/rockchip-defaults.inc
+require conf/machine/include/arm/armv8a/tune-cortexa35.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
diff --git a/conf/machine/include/rk3066.inc b/conf/machine/include/rk3066.inc
index a2685af..026d5b5 100644
--- a/conf/machine/include/rk3066.inc
+++ b/conf/machine/include/rk3066.inc
@@ -4,8 +4,8 @@
 SOC_FAMILY = "rk3066"
 
 require conf/machine/include/soc-family.inc
-require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 require conf/machine/include/rockchip-defaults.inc
+require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 
 SERIAL_CONSOLES = "115200;ttyS2"
 
diff --git a/conf/machine/include/rk3188.inc b/conf/machine/include/rk3188.inc
index c85710d..0120e2f 100644
--- a/conf/machine/include/rk3188.inc
+++ b/conf/machine/include/rk3188.inc
@@ -4,8 +4,8 @@
 SOC_FAMILY  = "rk3188"
 
 require conf/machine/include/soc-family.inc
-require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 require conf/machine/include/rockchip-defaults.inc
+require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 
 SERIAL_CONSOLES = "115200;ttyFIQ0"
 
diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
index e0dbd6c..684e864 100644
--- a/conf/machine/include/rk3288.inc
+++ b/conf/machine/include/rk3288.inc
@@ -4,8 +4,8 @@
 SOC_FAMILY = "rk3288"
 
 require conf/machine/include/soc-family.inc
-require conf/machine/include/arm/armv7a/tune-cortexa17.inc
 require conf/machine/include/rockchip-defaults.inc
+require conf/machine/include/arm/armv7a/tune-cortexa17.inc
 
 SERIAL_CONSOLES = "115200;ttyS2"
 
diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
index 5a5dafd..2802d4e 100644
--- a/conf/machine/include/rk3308.inc
+++ b/conf/machine/include/rk3308.inc
@@ -3,8 +3,8 @@ SOC_FAMILY = "rk3308"
 DEFAULTTUNE ?= "cortexa35-crypto"
 
 require conf/machine/include/soc-family.inc
-require conf/machine/include/arm/armv8a/tune-cortexa35.inc
 require conf/machine/include/rockchip-defaults.inc
+require conf/machine/include/arm/armv8a/tune-cortexa35.inc
 require conf/machine/include/rockchip-wic.inc
 
 SERIAL_CONSOLES = "1500000;ttyS0"
diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
index 6be777c..4ecd681 100644
--- a/conf/machine/include/rk3328.inc
+++ b/conf/machine/include/rk3328.inc
@@ -6,8 +6,8 @@ SOC_FAMILY = "rk3328"
 DEFAULTTUNE ?= "cortexa53-crypto"
 
 require conf/machine/include/soc-family.inc
-require conf/machine/include/arm/armv8a/tune-cortexa53.inc
 require conf/machine/include/rockchip-defaults.inc
+require conf/machine/include/arm/armv8a/tune-cortexa53.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
index 5a3f439..47f0560 100644
--- a/conf/machine/include/rk3399.inc
+++ b/conf/machine/include/rk3399.inc
@@ -6,8 +6,8 @@ SOC_FAMILY = "rk3399"
 DEFAULTTUNE ?= "cortexa72-cortexa53-crypto"
 
 require conf/machine/include/soc-family.inc
-require conf/machine/include/arm/armv8a/tune-cortexa72-cortexa53.inc
 require conf/machine/include/rockchip-defaults.inc
+require conf/machine/include/arm/armv8a/tune-cortexa72-cortexa53.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
index 3c227dc..92d9d6d 100644
--- a/conf/machine/include/rk3568.inc
+++ b/conf/machine/include/rk3568.inc
@@ -3,8 +3,8 @@ SOC_FAMILY = "rk3568"
 DEFAULTTUNE ?= "cortexa55"
 
 require conf/machine/include/soc-family.inc
-require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
 require conf/machine/include/rockchip-defaults.inc
+require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index 6e700d8..6e01ede 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -2,8 +2,8 @@ SOC_FAMILY ?= "rk3588s"
 MACHINEOVERRIDES =. "rk3588s:"
 DEFAULTTUNE ?= "cortexa76-cortexa55-crypto"
 
-require conf/machine/include/arm/armv8-2a/tune-cortexa76-cortexa55.inc
 require conf/machine/include/rockchip-defaults.inc
+require conf/machine/include/arm/armv8-2a/tune-cortexa76-cortexa55.inc
 require conf/machine/include/rockchip-wic.inc
 
 KBUILD_DEFCONFIG ?= "defconfig"
diff --git a/conf/machine/include/rockchip-defaults.inc b/conf/machine/include/rockchip-defaults.inc
index 2387eb9..b15725d 100644
--- a/conf/machine/include/rockchip-defaults.inc
+++ b/conf/machine/include/rockchip-defaults.inc
@@ -1,5 +1,5 @@
 # meta-rockchip default settings
-
+MACHINEOVERRIDES =. "rockchip:"
 # kernel
 PREFERRED_PROVIDER_virtual/kernel ?= "linux-yocto"
 KCONFIG_MODE ?= "alldefconfig"

-- 
2.45.0


