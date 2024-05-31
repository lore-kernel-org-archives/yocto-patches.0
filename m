Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE189C27C5E
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 09:25:54 +0000 (UTC)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
 by mx.groups.io with SMTP id smtpd.web10.7574.1717147546508498113
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 May 2024 02:25:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.172, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VrHm86Jmnzr9y;
	Fri, 31 May 2024 11:25:44 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VrHm80tX2zWGR;
	Fri, 31 May 2024 11:25:44 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 31 May 2024 11:25:15 +0200
Subject: [PATCH meta-rockchip master scarthgap v3 08/16] rk3308: move
 rockchip-rkbin selection to SoC conf file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-rk3588-family-v3-8-629586621c5d@cherry.de>
References: <20240531-rk3588-family-v3-0-629586621c5d@cherry.de>
In-Reply-To: <20240531-rk3588-family-v3-0-629586621c5d@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 May 2024 09:25:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/259

From: Quentin Schulz <quentin.schulz@cherry.de>

The mechanism remains the same, except that everything that requires
rockchip-rkbin doesn't need to know that rk3308 boards would prefer the
rk3308-rkbin instead, it's abstracted by the PREFERRED_PROVIDER
mechanism by BitBake.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3308.inc      | 2 ++
 recipes-bsp/u-boot/u-boot_%.bbappend | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
index 2802d4e..94ce8e1 100644
--- a/conf/machine/include/rk3308.inc
+++ b/conf/machine/include/rk3308.inc
@@ -16,3 +16,5 @@ KERNEL_IMAGETYPE ?= "fitImage"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+PREFERRED_PROVIDER_rockchip-rkbin = "${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin', 'rk3308-rkbin', d)}"
diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index c78c86f..79314f7 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -19,7 +19,7 @@ EXTRA_OEMAKE:append:rk3588s = " ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3588.bin"
 
 INIT_FIRMWARE_DEPENDS ??= ""
 INIT_FIRMWARE_DEPENDS:px30 = " trusted-firmware-a:do_deploy"
-INIT_FIRMWARE_DEPENDS:rk3308 = " ${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin', 'rk3308-rkbin', d)}:do_deploy"
+INIT_FIRMWARE_DEPENDS:rk3308 = " rockchip-rkbin:do_deploy"
 INIT_FIRMWARE_DEPENDS:rk3328 = " trusted-firmware-a:do_deploy"
 INIT_FIRMWARE_DEPENDS:rk3399 = " trusted-firmware-a:do_deploy"
 INIT_FIRMWARE_DEPENDS:rk3568 = " rockchip-rkbin:do_deploy"

-- 
2.45.1


