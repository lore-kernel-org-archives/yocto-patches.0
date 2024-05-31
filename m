Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3E8C27C65
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 09:25:54 +0000 (UTC)
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
 by mx.groups.io with SMTP id smtpd.web10.7571.1717147544430224485
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 May 2024 02:25:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.175, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VrHm66wrrzqm2;
	Fri, 31 May 2024 11:25:42 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VrHm64TGrzVC0;
	Fri, 31 May 2024 11:25:42 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 31 May 2024 11:25:10 +0200
Subject: [PATCH meta-rockchip master scarthgap v3 03/16] rk3188: fix
 MACHINEOVERRIDES order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-rk3588-family-v3-3-629586621c5d@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/254

From: Quentin Schulz <quentin.schulz@cherry.de>

The SOC_FAMILY OVERRIDES should come after the TUNE one, so it needs to
be defined before.

before:
MACHINEOVERRIDES="rk3188:armv7a:radxarock"
after:
MACHINEOVERRIDES="armv7a:rk3188:radxarock"

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3188.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/machine/include/rk3188.inc b/conf/machine/include/rk3188.inc
index 830f908..c85710d 100644
--- a/conf/machine/include/rk3188.inc
+++ b/conf/machine/include/rk3188.inc
@@ -3,8 +3,8 @@
 
 SOC_FAMILY  = "rk3188"
 
-require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 require conf/machine/include/soc-family.inc
+require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 require conf/machine/include/rockchip-defaults.inc
 
 SERIAL_CONSOLES = "115200;ttyFIQ0"

-- 
2.45.1


