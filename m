Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323EBC369B4
	for <webhook@archiver.kernel.org>; Tue, 15 Apr 2025 11:24:23 +0000 (UTC)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
 by mx.groups.io with SMTP id smtpd.web10.17651.1744716257588604647
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Apr 2025 04:24:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.11, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZcMHh1wbPzgKs;
	Tue, 15 Apr 2025 13:24:16 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZcMHg5y3Vz8H7;
	Tue, 15 Apr 2025 13:24:15 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 15 Apr 2025 13:24:04 +0200
Subject: [meta-rockchip PATCH v2 1/3] mesa: enable Panfrost support for
 RK3588(S)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-mesa-panthor-v2-1-a7850d0091fe@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1368

From: Quentin Schulz <quentin.schulz@cherry.de>

Panthor is the open-source implementation for the Arm GPU Valhall series
found in the RK3588(S).
Panthor is supported via Panfrost in Mesa, so let's enable this
PACKAGECONFIG.

Note that a blob is still required. It is mali_csffw.bin and provided by
a package from linux-firmware.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-graphics/mesa/mesa.bbappend | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
index 00cc15c6221c9bce0a1299fc81b63996744a2279..b0977649a0e86f73636d91b84a2cc9e6c12875bb 100644
--- a/recipes-graphics/mesa/mesa.bbappend
+++ b/recipes-graphics/mesa/mesa.bbappend
@@ -3,4 +3,5 @@ PACKAGECONFIG:append:rk3328 = " kmsro lima"
 PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3566 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3568 = " kmsro panfrost"
+PACKAGECONFIG:append:rk3588s = " kmsro panfrost"
 PACKAGECONFIG:append:px30 = " kmsro panfrost"

-- 
2.49.0


