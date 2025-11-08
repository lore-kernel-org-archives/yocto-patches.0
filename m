Return-Path: <mustela@erminea.space>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CB9CCFA13
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 22:56:51 +0000 (UTC)
Received: from erminea.space (erminea.space [51.250.125.203])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15561.1762642607310419977
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 14:56:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: erminea.space, ip: 51.250.125.203, mailfrom: mustela@erminea.space)
Received: from eternity (unknown [37.204.49.201])
	by erminea.space (Postfix) with ESMTPSA id C2F73CB8;
	Sun, 09 Nov 2025 01:56:44 +0300 (MSK)
From: Peter Shkenev <mustela@erminea.space>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Peter Shkenev <mustela@erminea.space>
Subject: [meta-rockchip] [PATCH v3] rk3288: use u-boot.img as bootloader image
Date: Sun,  9 Nov 2025 01:56:41 +0300
Message-ID: <20251108225641.171832-1-mustela@erminea.space>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 22:56:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2462

Currently, u-boot.bin is used for supported rk3288-based boards. But on
some boards, such as tinker-board, it can not be loaded, since
u-boot.bin is raw and those boards have raw image support
(CONFIG_SPL_RAW_IMAGE_SUPPORT) disabled in favour of FIT images.

Use u-boot.img which is FIT when FIT support is enabled, and raw
otherwise.

Also add a note that u-boot.itb should be used if one wantes to utilize
OP-TEE.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>

Signed-off-by: Peter Shkenev <mustela@erminea.space>
---
 conf/machine/include/rk3288.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk328=
8.inc
index a648b44..00cc04b 100644
--- a/conf/machine/include/rk3288.inc
+++ b/conf/machine/include/rk3288.inc
@@ -13,6 +13,7 @@ SERIAL_CONSOLES =3D "115200;ttyS2"
 KBUILD_DEFCONFIG ?=3D "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3288 =3D " bsp/rockchip/remove-non-rockchip-arc=
h-arm.scc"
=20
-UBOOT_SUFFIX ?=3D "bin"
+# Set UBOOT_SUFFIX to "itb" if you are going to use OP-TEE
+UBOOT_SUFFIX ?=3D "img"
=20
 ENABLE_STATELESS_VPU_GST ?=3D "1"
--=20
2.51.1


