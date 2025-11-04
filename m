Return-Path: <mustela@erminea.space>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342A6CCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 14:19:53 +0000 (UTC)
Received: from erminea.space (erminea.space [51.250.125.203])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18907.1762265984819096832
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Nov 2025 06:19:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: erminea.space, ip: 51.250.125.203, mailfrom: mustela@erminea.space)
Received: from eternity (unknown [37.204.49.201])
	by erminea.space (Postfix) with ESMTPSA id 10E46217;
	Tue, 04 Nov 2025 17:19:42 +0300 (MSK)
From: Peter Shkenev <mustela@erminea.space>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Peter Shkenev <mustela@erminea.space>
Subject: [meta-rockchip] [PATCH v2] rk3288: use u-boot.img as bootloader image
Date: Tue,  4 Nov 2025 17:19:35 +0300
Message-ID: <20251104141935.2011578-1-mustela@erminea.space>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Nov 2025 14:19:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2416

Currently, u-boot.bin is used for supported rk3288-based boards. But, as
U-Boot for those boards gets built without OP-TEE, u-boot.bin is a raw
image, and, since raw images support for those boards is disabled as
well, u-boot will fail to boot.

Fix this by using u-boot.img for supported rk3288 boards, which is a FIT
image.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>

Signed-off-by: Peter Shkenev <mustela@erminea.space>
---
 conf/machine/include/rk3288.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk328=
8.inc
index a648b44..70d554f 100644
--- a/conf/machine/include/rk3288.inc
+++ b/conf/machine/include/rk3288.inc
@@ -13,6 +13,6 @@ SERIAL_CONSOLES =3D "115200;ttyS2"
 KBUILD_DEFCONFIG ?=3D "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3288 =3D " bsp/rockchip/remove-non-rockchip-arc=
h-arm.scc"
=20
-UBOOT_SUFFIX ?=3D "bin"
+UBOOT_SUFFIX ?=3D "img"
=20
 ENABLE_STATELESS_VPU_GST ?=3D "1"
--=20
2.51.1


