Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC0BC369B8
	for <webhook@archiver.kernel.org>; Tue, 15 Apr 2025 11:24:23 +0000 (UTC)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
 by mx.groups.io with SMTP id smtpd.web11.17552.1744716258427561952
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Apr 2025 04:24:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.171, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZcMHj06Vszg61;
	Tue, 15 Apr 2025 13:24:17 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZcMHh4mtSz7Rf;
	Tue, 15 Apr 2025 13:24:16 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 15 Apr 2025 13:24:06 +0200
Subject: [meta-rockchip PATCH v2 3/3] mesa: remove kmsro from PACKAGECONFIG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-mesa-panthor-v2-3-a7850d0091fe@cherry.de>
References: <20250415-mesa-panthor-v2-0-a7850d0091fe@cherry.de>
In-Reply-To: <20250415-mesa-panthor-v2-0-a7850d0091fe@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Apr 2025 11:24:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1370

From: Quentin Schulz <quentin.schulz@cherry.de>

Mesa has dropped support for a separate kmsro option to the
gallium-drivers.

It is therefore not necessary to pass it to PACKAGECONFIG anymore.

This is in anticipation to
https://lore.kernel.org/openembedded-core/0214a9e5-0242-448b-b078-9ba202685943@oss.qualcomm.com/T/#u
being merged.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-graphics/mesa/mesa.bbappend | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
index 113cda71d290f28570c3020e0bfb8e241355c512..f22280754a149068b7192ca471a80ed59af38fdd 100644
--- a/recipes-graphics/mesa/mesa.bbappend
+++ b/recipes-graphics/mesa/mesa.bbappend
@@ -1,9 +1,9 @@
-PACKAGECONFIG:append:rk3288 = " kmsro panfrost"
-PACKAGECONFIG:append:rk3328 = " kmsro lima"
-PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
-PACKAGECONFIG:append:rk3566 = " kmsro panfrost"
-PACKAGECONFIG:append:rk3568 = " kmsro panfrost"
-PACKAGECONFIG:append:rk3588s = " kmsro panfrost"
-PACKAGECONFIG:append:px30 = " kmsro panfrost"
+PACKAGECONFIG:append:rk3288 = " panfrost"
+PACKAGECONFIG:append:rk3328 = " lima"
+PACKAGECONFIG:append:rk3399 = " panfrost"
+PACKAGECONFIG:append:rk3566 = " panfrost"
+PACKAGECONFIG:append:rk3568 = " panfrost"
+PACKAGECONFIG:append:rk3588s = " panfrost"
+PACKAGECONFIG:append:px30 = " panfrost"
 
 RRECOMMENDS:mesa-megadriver:append:rk3588s = " linux-firmware-mali-csffw-arch108"

-- 
2.49.0


