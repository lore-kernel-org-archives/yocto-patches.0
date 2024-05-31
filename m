Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C981EC27C5F
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 09:25:54 +0000 (UTC)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
 by mx.groups.io with SMTP id smtpd.web10.7572.1717147545008050821
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 May 2024 02:25:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.14, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VrHm72557zpF4;
	Fri, 31 May 2024 11:25:43 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VrHm66hLDzTlw;
	Fri, 31 May 2024 11:25:42 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 31 May 2024 11:25:11 +0200
Subject: [PATCH meta-rockchip master scarthgap v3 04/16] rk3288: fix
 MACHINEOVERRIDES order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-rk3588-family-v3-4-629586621c5d@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/255

From: Quentin Schulz <quentin.schulz@cherry.de>

The SOC_FAMILY OVERRIDES should come after the TUNE one, so it needs to
be defined before.

before:
MACHINEOVERRIDES="rk3288:armv7ve:vyasa-rk3288"
after:
MACHINEOVERRIDES="armv7ve:rk3288:vyasa-rk3288"

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3288.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
index e682c0b..e0dbd6c 100644
--- a/conf/machine/include/rk3288.inc
+++ b/conf/machine/include/rk3288.inc
@@ -3,8 +3,8 @@
 
 SOC_FAMILY = "rk3288"
 
-require conf/machine/include/arm/armv7a/tune-cortexa17.inc
 require conf/machine/include/soc-family.inc
+require conf/machine/include/arm/armv7a/tune-cortexa17.inc
 require conf/machine/include/rockchip-defaults.inc
 
 SERIAL_CONSOLES = "115200;ttyS2"

-- 
2.45.1


