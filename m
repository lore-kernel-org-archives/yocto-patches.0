Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EC8C27C44
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 09:25:54 +0000 (UTC)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
 by mx.groups.io with SMTP id smtpd.web10.7578.1717147548272312716
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 May 2024 02:25:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.11, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VrHmB5gfGznD0;
	Fri, 31 May 2024 11:25:46 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VrHmB3cMqzTxR;
	Fri, 31 May 2024 11:25:46 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 31 May 2024 11:25:22 +0200
Subject: [PATCH meta-rockchip master scarthgap v3 15/16] machine:
 rk3588/rk3588s: mark all machines as to be using the closed TPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-rk3588-family-v3-15-629586621c5d@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/266

From: Quentin Schulz <quentin.schulz@cherry.de>

This will be useful once we migrate the U-Boot recipe to use this new
override.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3588s.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index 6e01ede..cd84461 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -2,6 +2,8 @@ SOC_FAMILY ?= "rk3588s"
 MACHINEOVERRIDES =. "rk3588s:"
 DEFAULTTUNE ?= "cortexa76-cortexa55-crypto"
 
+ROCKCHIP_CLOSED_TPL ?= "1"
+
 require conf/machine/include/rockchip-defaults.inc
 require conf/machine/include/arm/armv8-2a/tune-cortexa76-cortexa55.inc
 require conf/machine/include/rockchip-wic.inc

-- 
2.45.1


