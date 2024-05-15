Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A6DC41513
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 16:03:23 +0000 (UTC)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
 by mx.groups.io with SMTP id smtpd.web10.20587.1715789002329836311
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 09:03:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.10, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VfdLJ4tWqzJj9;
	Wed, 15 May 2024 18:03:20 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VfdLJ2f95zYh4;
	Wed, 15 May 2024 18:03:20 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 15 May 2024 18:03:01 +0200
Subject: [PATCH meta-rockchip v2 07/16] bsp: rkbin: rk3308-rkbin: PROVIDES
 rockchip-rkbin
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-rk3588-family-v2-7-f81897a3ac50@cherry.de>
References: <20240515-rk3588-family-v2-0-f81897a3ac50@cherry.de>
In-Reply-To: <20240515-rk3588-family-v2-0-f81897a3ac50@cherry.de>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 yocto-patches@lists.yoctoproject.org
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 May 2024 16:03:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/147

From: Quentin Schulz <quentin.schulz@cherry.de>

This makes it possible to select rk3308-rkbin as a PREFERRED_PROVIDER
for rockchip-rkbin, which makes it much easier to handle "flavors" in
recipes where this dependency exists.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rk3308-rkbin_git.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-bsp/rkbin/rk3308-rkbin_git.bb b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
index c6b05b2..f32b57a 100644
--- a/recipes-bsp/rkbin/rk3308-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
@@ -6,6 +6,7 @@ SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
 SRCREV = "e65b97b511f1349156702db40694454c141d8fe2"
 
 PROVIDES += "trusted-firmware-a"
+PROVIDES += "rockchip-rkbin"
 PROVIDES += "optee-os"
 
 inherit bin_package deploy

-- 
2.45.0


