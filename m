Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2778C7EE3A
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 14:19:27 +0000 (UTC)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
 by mx.groups.io with SMTP id smtpd.web11.14938.1751033963590423486
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 07:19:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.8, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bTHk172lYz5b6;
	Fri, 27 Jun 2025 16:19:21 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bTHk13YyCz3JC;
	Fri, 27 Jun 2025 16:19:21 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 27 Jun 2025 16:19:13 +0200
Subject: [meta-rockchip PATCH v3 2/6] mesa: add libclc to PACKAGECONFIG for
 Panfrost-supported SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-mesa-panthor-v3-2-798c24a9eef3@cherry.de>
References: <20250627-mesa-panthor-v3-0-798c24a9eef3@cherry.de>
In-Reply-To: <20250627-mesa-panthor-v3-0-798c24a9eef3@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Trevor Woerner <twoerner@gmail.com>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 14:19:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1714

From: Quentin Schulz <quentin.schulz@cherry.de>

Panfrost mesa drivers do not compile without libclc support anymore, I
assume since commit 20970bcd9652 ("panfrost: Add base of OpenCL C
infrastructure") merged in 25.1.0.

So this adds the missing libclc PACKAGECONFIG to Panfrost-supported
SoCs.

Note that mesa recipe in OE-Core will be updated to not build panfrost
if libclc PACKAGECONFIG is missing.

Reported-by: Trevor Woerner <twoerner@gmail.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-graphics/mesa/mesa.bbappend | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
index e0b38ce4d0cea913ea1ecafd43d42bb909a312fa..507e2fae98e9d98cc6999586564d68af5abd4c0d 100644
--- a/recipes-graphics/mesa/mesa.bbappend
+++ b/recipes-graphics/mesa/mesa.bbappend
@@ -1,6 +1,6 @@
-PACKAGECONFIG:append:rk3288 = " panfrost"
+PACKAGECONFIG:append:rk3288 = " libclc panfrost"
 PACKAGECONFIG:append:rk3328 = " lima"
-PACKAGECONFIG:append:rk3399 = " panfrost"
-PACKAGECONFIG:append:rk3566 = " panfrost"
-PACKAGECONFIG:append:rk3568 = " panfrost"
-PACKAGECONFIG:append:px30 = " panfrost"
+PACKAGECONFIG:append:rk3399 = " libclc panfrost"
+PACKAGECONFIG:append:rk3566 = " libclc panfrost"
+PACKAGECONFIG:append:rk3568 = " libclc panfrost"
+PACKAGECONFIG:append:px30 = " libclc panfrost"

-- 
2.50.0


