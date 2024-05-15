Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EE3C25B7B
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 16:03:34 +0000 (UTC)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
 by mx.groups.io with SMTP id smtpd.web10.20593.1715789005323833029
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 09:03:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VfdLM4s9HzNKs;
	Wed, 15 May 2024 18:03:23 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VfdLM2kGkzZSL;
	Wed, 15 May 2024 18:03:23 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 15 May 2024 18:03:08 +0200
Subject: [PATCH meta-rockchip v2 14/16] machine: rk3568: mark all machines
 as to be using the closed TPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-rk3588-family-v2-14-f81897a3ac50@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/154

From: Quentin Schulz <quentin.schulz@cherry.de>

This will be useful once we migrate the U-Boot recipe to use this new
override.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3568.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
index 92d9d6d..1da212a 100644
--- a/conf/machine/include/rk3568.inc
+++ b/conf/machine/include/rk3568.inc
@@ -2,6 +2,8 @@ SOC_FAMILY = "rk3568"
 
 DEFAULTTUNE ?= "cortexa55"
 
+ROCKCHIP_CLOSED_TPL ?= "1"
+
 require conf/machine/include/soc-family.inc
 require conf/machine/include/rockchip-defaults.inc
 require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc

-- 
2.45.0


