Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E11C41513
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 16:03:34 +0000 (UTC)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
 by mx.groups.io with SMTP id smtpd.web11.20281.1715789005403832283
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 09:03:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.171, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VfdLN001FzbQ6;
	Wed, 15 May 2024 18:03:23 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VfdLM4wxyzb32;
	Wed, 15 May 2024 18:03:23 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 15 May 2024 18:03:09 +0200
Subject: [PATCH meta-rockchip v2 15/16] machine: rk3588/rk3588s: mark all
 machines as to be using the closed TPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-rk3588-family-v2-15-f81897a3ac50@cherry.de>
References: <20240515-rk3588-family-v2-0-f81897a3ac50@cherry.de>
In-Reply-To: <20240515-rk3588-family-v2-0-f81897a3ac50@cherry.de>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 yocto-patches@lists.yoctoproject.org
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 May 2024 16:03:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/155

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
2.45.0


