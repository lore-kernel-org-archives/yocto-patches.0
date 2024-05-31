Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF6BC41513
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 15:30:47 +0000 (UTC)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
 by mx.groups.io with SMTP id smtpd.web10.15536.1717169445756325047
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 May 2024 08:30:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.173, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VrRsJ18tszrXP;
	Fri, 31 May 2024 17:30:44 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VrRsH60rSzy1k;
	Fri, 31 May 2024 17:30:43 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 31 May 2024 17:30:25 +0200
Subject: [PATCH meta-rockchip RFC 1/2] mesa: enable Panfrost support for
 RK3588(S)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-mesa-panthor-v1-1-8cfb4d17ad3a@cherry.de>
References: <20240531-mesa-panthor-v1-0-8cfb4d17ad3a@cherry.de>
In-Reply-To: <20240531-mesa-panthor-v1-0-8cfb4d17ad3a@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 May 2024 15:30:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/271

From: Quentin Schulz <quentin.schulz@cherry.de>

Panthor is the open-source implementation for the Arm GPU Valhall series
found in the RK3588(S).
Panthor is supported via Panfrost in Mesa, so let's enable this
PACKAGECONFIG.

Note that a blob is still required. It is mali_csffw.bin and provided by
a package from linux-firmware.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-graphics/mesa/mesa_%.bbappend | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa_%.bbappend
index 58c25e7..87ca1b3 100644
--- a/recipes-graphics/mesa/mesa_%.bbappend
+++ b/recipes-graphics/mesa/mesa_%.bbappend
@@ -1,4 +1,5 @@
 PACKAGECONFIG:append:rk3288 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
+PACKAGECONFIG:append:rk3588s = " kmsro panfrost"
 PACKAGECONFIG:append:rock64 = " kmsro lima"
 PACKAGECONFIG:append:px30 = " kmsro panfrost"

-- 
2.45.1


