Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22751C04FFE
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 07:37:10 +0000 (UTC)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
 by mx.groups.io with SMTP id smtpd.web10.9515.1715671610011743147
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 May 2024 00:26:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vdnwm1gR5zcJF;
	Tue, 14 May 2024 09:26:48 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vdnwl5knDzvmk;
	Tue, 14 May 2024 09:26:47 +0200 (CEST)
From: "Quentin Schulz" <foss@0leil.net>
Date: Tue, 14 May 2024 09:26:33 +0200
Subject: [PATCH meta-rockchip] rk3588/rk3588s: add SOC_FAMILY
MIME-Version: 1.0
Message-Id: <20240514-rk3588-family-v1-1-5366b1534a10@cherry.de>
X-B4-Tracking: v=1; b=H4sIACgSQ2YC/x3MSQqEMBBA0atIrS3I2IhXERchVrSwHaiI2Ih37
 +DyLf6/IZMwZWirG4ROzrytBbquIE5hHQl5KAajjFNeO5TZ+qbBFBb+/vCTrDGDT1pZB6XZhRJ
 f76+DhY6AssU5TrxD/zx/Y/t7/24AAAA=
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 May 2024 07:37:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/134

From: Quentin Schulz <quentin.schulz@cherry.de>

The RK3588S is a stripped down version of the RK3588 but all prebuilt
binaries and most documentation from Rockchip use "RK3588" as an
identifier for both, so let's make this the SOC_FAMILY for both RK3588S
and RK3588.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3588s.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index 878f7a8..b570d46 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -1,3 +1,5 @@
+SOC_FAMILY = "rk3588"
+
 MACHINEOVERRIDES =. "rk3588s:"
 DEFAULTTUNE ?= "cortexa76-cortexa55-crypto"
 

---
base-commit: 88f2064ca2b83b42a7c8a59616ab80b763ef2485
change-id: 20240514-rk3588-family-6f322d5f1034

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


