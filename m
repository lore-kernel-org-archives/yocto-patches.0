Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402CAC25B75
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 16:03:34 +0000 (UTC)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
 by mx.groups.io with SMTP id smtpd.web11.20278.1715789004044357602
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 09:03:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VfdLL2v0NzKr1;
	Wed, 15 May 2024 18:03:22 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VfdLL0D0YzZ4n;
	Wed, 15 May 2024 18:03:22 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 15 May 2024 18:03:05 +0200
Subject: [PATCH meta-rockchip v2 11/16] bsp: u-boot: split things that can
 apply to any U-Boot into a .inc file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-rk3588-family-v2-11-f81897a3ac50@cherry.de>
References: <20240515-rk3588-family-v2-0-f81897a3ac50@cherry.de>
In-Reply-To: <20240515-rk3588-family-v2-0-f81897a3ac50@cherry.de>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 yocto-patches@lists.yoctoproject.org
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 May 2024 16:03:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/151

From: Quentin Schulz <quentin.schulz@cherry.de>

Anyone writing their own U-Boot recipe for their Rockchip-based board
will need to repeat the same as currently done in a bbappend that only
applies to the upstream u-boot recipe from OE-Core. This is both
error-prone and more difficult to maintain as well as lowering the
number of people actually using the code in meta-rockchip (thus
increasing maintainer load by having less people debug the code).

Move everything that is Rockchip-specific but reusable in an .inc file
that can be included by other layers.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/u-boot/u-boot-rockchip.inc | 19 +++++++++++++++++++
 recipes-bsp/u-boot/u-boot_%.bbappend   | 22 ++--------------------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc b/recipes-bsp/u-boot/u-boot-rockchip.inc
new file mode 100644
index 0000000..0a634fc
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot-rockchip.inc
@@ -0,0 +1,19 @@
+BL31:rockchip:aarch64 = "${DEPLOY_DIR_IMAGE}/bl31-${SOC_FAMILY}.elf"
+# SOC_FAMILY for RK3588S is rk3588s but it should use the binaries from rk3588
+BL31:rk3588s = "${DEPLOY_DIR_IMAGE}/bl31-rk3588.elf"
+EXTRA_OEMAKE:append:rockchip:aarch64 = " BL31=${BL31}"
+
+TFA_DEPENDS ??= ""
+TFA_DEPENDS:rockchip:aarch64 = " trusted-firmware-a:do_deploy"
+do_compile[depends] .= "${TFA_DEPENDS}"
+
+# No open-source TPL (yet)
+EXTRA_OEMAKE:append:rk3308 = " ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3308.bin"
+EXTRA_OEMAKE:append:rk3568 = " ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3568.bin"
+EXTRA_OEMAKE:append:rk3588s = " ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3588.bin"
+
+INIT_FIRMWARE_DEPENDS ??= ""
+INIT_FIRMWARE_DEPENDS:rk3308 = " rockchip-rkbin:do_deploy"
+INIT_FIRMWARE_DEPENDS:rk3568 = " rockchip-rkbin:do_deploy"
+INIT_FIRMWARE_DEPENDS:rk3588s = " rockchip-rkbin:do_deploy"
+do_compile[depends] .= "${INIT_FIRMWARE_DEPENDS}"
diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index 5502e31..088a52c 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -1,28 +1,10 @@
+require u-boot-rockchip.inc
+
 # various machines require the pyelftools library for parsing dtb files
 DEPENDS:append = " python3-pyelftools-native"
 DEPENDS:append:rk3308 = " u-boot-tools-native"
 DEPENDS:append:rock-pi-4 = " gnutls-native"
 
-BL31:rockchip:aarch64 = "${DEPLOY_DIR_IMAGE}/bl31-${SOC_FAMILY}.elf"
-# SOC_FAMILY for RK3588S is rk3588s but it should use the binaries from rk3588
-BL31:rk3588s = "${DEPLOY_DIR_IMAGE}/bl31-rk3588.elf"
-EXTRA_OEMAKE:append:rockchip:aarch64 = " BL31=${BL31}"
-
-TFA_DEPENDS ??= ""
-TFA_DEPENDS:rockchip:aarch64 = " trusted-firmware-a:do_deploy"
-do_compile[depends] .= "${TFA_DEPENDS}"
-
-# No open-source TPL (yet)
-EXTRA_OEMAKE:append:rk3308 = " ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3308.bin"
-EXTRA_OEMAKE:append:rk3568 = " ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3568.bin"
-EXTRA_OEMAKE:append:rk3588s = " ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3588.bin"
-
-INIT_FIRMWARE_DEPENDS ??= ""
-INIT_FIRMWARE_DEPENDS:rk3308 = " rockchip-rkbin:do_deploy"
-INIT_FIRMWARE_DEPENDS:rk3568 = " rockchip-rkbin:do_deploy"
-INIT_FIRMWARE_DEPENDS:rk3588s = " rockchip-rkbin:do_deploy"
-do_compile[depends] .= "${INIT_FIRMWARE_DEPENDS}"
-
 do_compile:append:rock2-square () {
 	# copy to default search path
 	if [ "${SPL_BINARY}" = "u-boot-spl-dtb.bin" ]; then

-- 
2.45.0


