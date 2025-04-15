Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E31C369BC
	for <webhook@archiver.kernel.org>; Tue, 15 Apr 2025 11:24:23 +0000 (UTC)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
 by mx.groups.io with SMTP id smtpd.web10.17652.1744716258109128979
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Apr 2025 04:24:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.173, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZcMHh4sNWzf2D;
	Tue, 15 Apr 2025 13:24:16 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZcMHh24JMz98F;
	Tue, 15 Apr 2025 13:24:16 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 15 Apr 2025 13:24:05 +0200
Subject: [meta-rockchip PATCH v2 2/3] mesa: recommend mali csffw firmware
 package for mesa-megadriver for RK3588s
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-mesa-panthor-v2-2-a7850d0091fe@cherry.de>
References: <20250415-mesa-panthor-v2-0-a7850d0091fe@cherry.de>
In-Reply-To: <20250415-mesa-panthor-v2-0-a7850d0091fe@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Apr 2025 11:24:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1369

From: Quentin Schulz <quentin.schulz@cherry.de>

Panthor still requires a blob coming from a linux-firmware package to be
able to use the Arm GPU in its Valhall version series. Therefore,
recommend that package when building mesa for rk3588s.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-graphics/mesa/mesa.bbappend | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
index b0977649a0e86f73636d91b84a2cc9e6c12875bb..113cda71d290f28570c3020e0bfb8e241355c512 100644
--- a/recipes-graphics/mesa/mesa.bbappend
+++ b/recipes-graphics/mesa/mesa.bbappend
@@ -5,3 +5,5 @@ PACKAGECONFIG:append:rk3566 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3568 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3588s = " kmsro panfrost"
 PACKAGECONFIG:append:px30 = " kmsro panfrost"
+
+RRECOMMENDS:mesa-megadriver:append:rk3588s = " linux-firmware-mali-csffw-arch108"

-- 
2.49.0


