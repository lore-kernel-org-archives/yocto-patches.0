Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A7BC77B7F
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 14:19:27 +0000 (UTC)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
 by mx.groups.io with SMTP id smtpd.web11.14936.1751033963025491108
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 07:19:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.8, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bTHk13HFdzpHd;
	Fri, 27 Jun 2025 16:19:21 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bTHk073vyz4MP;
	Fri, 27 Jun 2025 16:19:20 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 27 Jun 2025 16:19:12 +0200
Subject: [meta-rockchip PATCH v3 1/6] mesa: remove kmsro from PACKAGECONFIG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-mesa-panthor-v3-1-798c24a9eef3@cherry.de>
References: <20250627-mesa-panthor-v3-0-798c24a9eef3@cherry.de>
In-Reply-To: <20250627-mesa-panthor-v3-0-798c24a9eef3@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 14:19:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1713

From: Quentin Schulz <quentin.schulz@cherry.de>

Mesa has dropped[1] support for a separate kmsro option to the
gallium-drivers.

It is therefore not necessary to pass it to PACKAGECONFIG anymore,
especially since the kmsro PACKAGECONFIG doesn't exit in the mesa recipe
anymore[2].

[1] https://gitlab.freedesktop.org/mesa/mesa/-/commit/89863a050bea429d9574a307bc28953bb60accaf
[2] https://git.openembedded.org/openembedded-core/commit/?id=3d9ec347e651e05d0246a8723ca4038bb1f5b765
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-graphics/mesa/mesa.bbappend | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
index 00cc15c6221c9bce0a1299fc81b63996744a2279..e0b38ce4d0cea913ea1ecafd43d42bb909a312fa 100644
--- a/recipes-graphics/mesa/mesa.bbappend
+++ b/recipes-graphics/mesa/mesa.bbappend
@@ -1,6 +1,6 @@
-PACKAGECONFIG:append:rk3288 = " kmsro panfrost"
-PACKAGECONFIG:append:rk3328 = " kmsro lima"
-PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
-PACKAGECONFIG:append:rk3566 = " kmsro panfrost"
-PACKAGECONFIG:append:rk3568 = " kmsro panfrost"
-PACKAGECONFIG:append:px30 = " kmsro panfrost"
+PACKAGECONFIG:append:rk3288 = " panfrost"
+PACKAGECONFIG:append:rk3328 = " lima"
+PACKAGECONFIG:append:rk3399 = " panfrost"
+PACKAGECONFIG:append:rk3566 = " panfrost"
+PACKAGECONFIG:append:rk3568 = " panfrost"
+PACKAGECONFIG:append:px30 = " panfrost"

-- 
2.50.0


