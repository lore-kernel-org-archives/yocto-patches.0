Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A33FC25B7E
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 16:03:24 +0000 (UTC)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
 by mx.groups.io with SMTP id smtpd.web10.20579.1715789000363682094
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 09:03:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.169, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VfdLG635GzZmt;
	Wed, 15 May 2024 18:03:18 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VfdLG3mPHzZ4m;
	Wed, 15 May 2024 18:03:18 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 15 May 2024 18:02:56 +0200
Subject: [PATCH meta-rockchip v2 02/16] rk3066: fix MACHINEOVERRIDES order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-rk3588-family-v2-2-f81897a3ac50@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/142

From: Quentin Schulz <quentin.schulz@cherry.de>

The SOC_FAMILY OVERRIDES should come after the TUNE one, so it needs to
be defined before.

before:
MACHINEOVERRIDES="rk3066:armv7a:marsboard-rk3066"
after:
MACHINEOVERRIDES="armv7a:rk3066:marsboard-rk3066"

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3066.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/machine/include/rk3066.inc b/conf/machine/include/rk3066.inc
index 3510df2..a2685af 100644
--- a/conf/machine/include/rk3066.inc
+++ b/conf/machine/include/rk3066.inc
@@ -3,8 +3,8 @@
 
 SOC_FAMILY = "rk3066"
 
-require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 require conf/machine/include/soc-family.inc
+require conf/machine/include/arm/armv7a/tune-cortexa9.inc
 require conf/machine/include/rockchip-defaults.inc
 
 SERIAL_CONSOLES = "115200;ttyS2"

-- 
2.45.0


