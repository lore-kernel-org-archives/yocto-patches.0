Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB1CC7EE31
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 14:19:27 +0000 (UTC)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
 by mx.groups.io with SMTP id smtpd.web10.14916.1751033964985466308
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 07:19:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.172, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bTHk33khbz3bR;
	Fri, 27 Jun 2025 16:19:23 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bTHk311X6z2NC;
	Fri, 27 Jun 2025 16:19:23 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 27 Jun 2025 16:19:16 +0200
Subject: [meta-rockchip PATCH v3 5/6] mesa: rework bbappend to default to
 panfrost
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-mesa-panthor-v3-5-798c24a9eef3@cherry.de>
References: <20250627-mesa-panthor-v3-0-798c24a9eef3@cherry.de>
In-Reply-To: <20250627-mesa-panthor-v3-0-798c24a9eef3@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 14:19:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1717

From: Quentin Schulz <quentin.schulz@cherry.de>

Let's assume most Rockchip SoCs to come will be based on an Arm Mali GPU
supported by Panfrost so let's always add panfrost drivers to mesa.

Make the Mali-400/450 SoC such as RK3066, RK3188 and RK3328 use lima
instead.

Finally, do not add any mesa mali (panfrost or lima) driver for GPU-less
SoC like RK3308.

This will allow to not need to touch this recipe every time we add
support for a new SoC with GPU supported by Mesa Panfrost.

This also **almost** brings support for the GPU found on RK3588.

Note that some GPUs (gen10; Valhall; Panthor; like on RK3588) still
require additional firmware (CSFFW).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-graphics/mesa/mesa.bbappend | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
index 1057e114b7569cc9ac841cd0c6818ac7f6c3827c..50d62b8ac50afe1712dfa03f479d120acc3e4199 100644
--- a/recipes-graphics/mesa/mesa.bbappend
+++ b/recipes-graphics/mesa/mesa.bbappend
@@ -1,8 +1,11 @@
-PACKAGECONFIG:append:rk3066 = " lima"
-PACKAGECONFIG:append:rk3188 = " lima"
-PACKAGECONFIG:append:rk3288 = " libclc panfrost"
-PACKAGECONFIG:append:rk3328 = " lima"
-PACKAGECONFIG:append:rk3399 = " libclc panfrost"
-PACKAGECONFIG:append:rk3566 = " libclc panfrost"
-PACKAGECONFIG:append:rk3568 = " libclc panfrost"
-PACKAGECONFIG:append:px30 = " libclc panfrost"
+MALI_DRIVER = "panfrost"
+# MALI 400
+MALI_DRIVER:rk3066 = "lima"
+MALI_DRIVER:rk3188 = "lima"
+# MALI 450
+MALI_DRIVER:rk3328 = "lima"
+# No GPU
+MALI_DRIVER:rk3308 = ""
+
+PACKAGECONFIG:append:rockchip = " ${@bb.utils.filter('MALI_DRIVER', 'lima panfrost', d)}"
+PACKAGECONFIG:append:rockchip = "${@bb.utils.contains('MALI_DRIVER', 'panfrost', ' libclc', '', d)}"

-- 
2.50.0


