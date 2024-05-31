Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BBCC27C50
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 09:25:54 +0000 (UTC)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
 by mx.groups.io with SMTP id smtpd.web11.7558.1717147547292964038
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 May 2024 02:25:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.13, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VrHmB0177znCw;
	Fri, 31 May 2024 11:25:46 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VrHm950s3zTp5;
	Fri, 31 May 2024 11:25:45 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 31 May 2024 11:25:19 +0200
Subject: [PATCH meta-rockchip master scarthgap v3 12/16] machine:
 rockchip-defaults: conditionally add closed-tpl MACHINEOVERRIDES
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-rk3588-family-v3-12-629586621c5d@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/263

From: Quentin Schulz <quentin.schulz@cherry.de>

This adds closed-tpl to MACHINEOVERRIDES if ROCKCHIP_CLOSED_TPL is set
to 1. This is a way to tell U-Boot that it needs to fetch the TPL from
some place instead of building it. This will allow us to have a common
logic in U-Boot, and also avoid touching the U-Boot recipe to add
support for a new SoC.

As there may be a transition phase during which we still have closed TPL
by default but an open-source implementation exists, let's make it a
weak assignment so it can be overridden from higher configuration files.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rockchip-defaults.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/conf/machine/include/rockchip-defaults.inc b/conf/machine/include/rockchip-defaults.inc
index e1634e2..85ec7b9 100644
--- a/conf/machine/include/rockchip-defaults.inc
+++ b/conf/machine/include/rockchip-defaults.inc
@@ -1,4 +1,5 @@
 # meta-rockchip default settings
+MACHINEOVERRIDES =. "${@bb.utils.contains('ROCKCHIP_CLOSED_TPL', '1', 'closed-tpl:', '', d)}"
 MACHINEOVERRIDES =. "rockchip:"
 # kernel
 PREFERRED_PROVIDER_virtual/kernel ?= "linux-yocto"

-- 
2.45.1


