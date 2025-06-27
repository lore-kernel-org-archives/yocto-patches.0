Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0878EC83013
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 14:19:28 +0000 (UTC)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
 by mx.groups.io with SMTP id smtpd.web11.14939.1751033964097477781
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 07:19:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.10, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bTHk23krTzy8;
	Fri, 27 Jun 2025 16:19:22 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bTHk20trXz3C7;
	Fri, 27 Jun 2025 16:19:22 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 27 Jun 2025 16:19:14 +0200
Subject: [meta-rockchip PATCH v3 3/6] mesa: enable lima for RK3066 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-mesa-panthor-v3-3-798c24a9eef3@cherry.de>
References: <20250627-mesa-panthor-v3-0-798c24a9eef3@cherry.de>
In-Reply-To: <20250627-mesa-panthor-v3-0-798c24a9eef3@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 14:19:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1715

From: Quentin Schulz <quentin.schulz@cherry.de>

lima is the the open-source implementation for the GPU found on RK3066,
the Mali 400, so let's enable it for RK3066 boards by default.

Not tested.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-graphics/mesa/mesa.bbappend | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
index 507e2fae98e9d98cc6999586564d68af5abd4c0d..19f0072b61178d71642da4afc9e56880b102069e 100644
--- a/recipes-graphics/mesa/mesa.bbappend
+++ b/recipes-graphics/mesa/mesa.bbappend
@@ -1,3 +1,4 @@
+PACKAGECONFIG:append:rk3066 = " lima"
 PACKAGECONFIG:append:rk3288 = " libclc panfrost"
 PACKAGECONFIG:append:rk3328 = " lima"
 PACKAGECONFIG:append:rk3399 = " libclc panfrost"

-- 
2.50.0


