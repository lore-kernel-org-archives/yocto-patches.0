Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AB1C27C41
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 16:03:24 +0000 (UTC)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
 by mx.groups.io with SMTP id smtpd.web10.20591.1715789003477807604
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 09:03:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.9, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VfdLL08rgzZNV;
	Wed, 15 May 2024 18:03:22 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VfdLK4Y4yzZSK;
	Wed, 15 May 2024 18:03:21 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 15 May 2024 18:03:04 +0200
Subject: [PATCH meta-rockchip v2 10/16] bsp: u-boot: remove duplicate
 trusted-firmware-a dependency for SoCs with open DDR init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-rk3588-family-v2-10-f81897a3ac50@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/150

From: Quentin Schulz <quentin.schulz@cherry.de>

For SoCs with open DDR init in U-Boot, there's no need for anything but
the BL31 from TF-A (maybe OP-TEE as well but that's off-topic) in
U-Boot. This is already handled by the TFA_DEPENDS variable outside of
this git context, so there's no need to duplicate it here.

By keeping the rockchip-rkbin dependency in INIT_FIRMWARE_DEPENDS and
use the PREFERRED_PROVIDER mechanism for selecting rockchip-rkbin as
provider for trusted-firmware-a as passed to TFA_DEPENDS, we make
explicit the dependency on two different pieces of software, though
currently provided by the same recipe.

The point being that this should prepare us and at the very least break
the build if we forget, for when open BL31 TF-A (so coming from
trusted-firmware-a recipe and not rockchip-rkbin) is released and we can
have rockchip-rkbin provide only the DDR bin and upstream TF-A provide
BL31 TF-A and still have a proper dependency scheme.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/u-boot/u-boot_%.bbappend | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index 3b3e0ba..5502e31 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -18,10 +18,7 @@ EXTRA_OEMAKE:append:rk3568 = " ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3568.bin"
 EXTRA_OEMAKE:append:rk3588s = " ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3588.bin"
 
 INIT_FIRMWARE_DEPENDS ??= ""
-INIT_FIRMWARE_DEPENDS:px30 = " trusted-firmware-a:do_deploy"
 INIT_FIRMWARE_DEPENDS:rk3308 = " rockchip-rkbin:do_deploy"
-INIT_FIRMWARE_DEPENDS:rk3328 = " trusted-firmware-a:do_deploy"
-INIT_FIRMWARE_DEPENDS:rk3399 = " trusted-firmware-a:do_deploy"
 INIT_FIRMWARE_DEPENDS:rk3568 = " rockchip-rkbin:do_deploy"
 INIT_FIRMWARE_DEPENDS:rk3588s = " rockchip-rkbin:do_deploy"
 do_compile[depends] .= "${INIT_FIRMWARE_DEPENDS}"

-- 
2.45.0


