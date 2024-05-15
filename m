Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2B7C25B79
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 16:03:34 +0000 (UTC)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
 by mx.groups.io with SMTP id smtpd.web11.20283.1715789005928622381
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 09:03:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VfdLN33vNzMGH;
	Wed, 15 May 2024 18:03:24 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VfdLN0SmZzZ03;
	Wed, 15 May 2024 18:03:24 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 15 May 2024 18:03:10 +0200
Subject: [PATCH meta-rockchip v2 16/16] bsp: u-boot-rockchip.inc: rework
 ROCKCHIP_TPL to use closed-tpl OVERRIDES
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-rk3588-family-v2-16-f81897a3ac50@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/156

From: Quentin Schulz <quentin.schulz@cherry.de>

Since closed-tpl OVERRIDES allows us to have a common logic for all
boards using ROCKCHIP_TPL in U-Boot for specifying external TPL blobs as
DDR init, let's make use of it.

This also allows us now to not have to care about the U-Boot recipe
whenever a new SoC will be supported.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/u-boot/u-boot-rockchip.inc | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc b/recipes-bsp/u-boot/u-boot-rockchip.inc
index 0a634fc..d2267cc 100644
--- a/recipes-bsp/u-boot/u-boot-rockchip.inc
+++ b/recipes-bsp/u-boot/u-boot-rockchip.inc
@@ -8,12 +8,11 @@ TFA_DEPENDS:rockchip:aarch64 = " trusted-firmware-a:do_deploy"
 do_compile[depends] .= "${TFA_DEPENDS}"
 
 # No open-source TPL (yet)
-EXTRA_OEMAKE:append:rk3308 = " ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3308.bin"
-EXTRA_OEMAKE:append:rk3568 = " ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3568.bin"
-EXTRA_OEMAKE:append:rk3588s = " ROCKCHIP_TPL=${DEPLOY_DIR_IMAGE}/ddr-rk3588.bin"
+ROCKCHIP_TPL:closed-tpl = "${DEPLOY_DIR_IMAGE}/ddr-${SOC_FAMILY}.bin"
+# SOC_FAMILY for RK3588S is rk3588s but it should use the binaries from rk3588
+ROCKCHIP_TPL:closed-tpl:rk3588s = "${DEPLOY_DIR_IMAGE}/ddr-rk3588.bin"
+EXTRA_OEMAKE:append:closed-tpl = " ROCKCHIP_TPL=${ROCKCHIP_TPL}"
 
 INIT_FIRMWARE_DEPENDS ??= ""
-INIT_FIRMWARE_DEPENDS:rk3308 = " rockchip-rkbin:do_deploy"
-INIT_FIRMWARE_DEPENDS:rk3568 = " rockchip-rkbin:do_deploy"
-INIT_FIRMWARE_DEPENDS:rk3588s = " rockchip-rkbin:do_deploy"
+INIT_FIRMWARE_DEPENDS:closed-tpl = " rockchip-rkbin:do_deploy"
 do_compile[depends] .= "${INIT_FIRMWARE_DEPENDS}"

-- 
2.45.0


