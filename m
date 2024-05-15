Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A30C25B7F
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 16:03:24 +0000 (UTC)
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
 by mx.groups.io with SMTP id smtpd.web10.20580.1715789000638293413
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 09:03:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.175, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VfdLH1txDzbt5;
	Wed, 15 May 2024 18:03:19 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VfdLG6gtkzXWX;
	Wed, 15 May 2024 18:03:18 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 15 May 2024 18:02:57 +0200
Subject: [PATCH meta-rockchip v2 03/16] rk3188: fix MACHINEOVERRIDES order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-rk3588-family-v2-3-f81897a3ac50@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/143

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
2.45.0


