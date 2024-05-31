Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9896CC41513
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 12:48:36 +0000 (UTC)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
 by mx.groups.io with SMTP id smtpd.web11.10945.1717159706648876661
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 May 2024 05:48:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.14, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VrNG10j1bzVbb;
	Fri, 31 May 2024 14:48:25 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VrNG02x7CzLqM;
	Fri, 31 May 2024 14:48:24 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 31 May 2024 14:48:15 +0200
Subject: [PATCH meta-rockchip 2/2] mesa: build panfrost for RK3568 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-mesa-panfrost-v1-2-84e23ae9a600@cherry.de>
References: <20240531-mesa-panfrost-v1-0-84e23ae9a600@cherry.de>
In-Reply-To: <20240531-mesa-panfrost-v1-0-84e23ae9a600@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 May 2024 12:48:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/270

From: Quentin Schulz <quentin.schulz@cherry.de>

The RK356x SoC family (of which we currently only support RK3568) has a
Bifrost GPU that is supported by open-source Panfrost Linux kernel and
Mesa drivers, therefore let's build mesa with Panfrost support for
RK3568.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-graphics/mesa/mesa_%.bbappend | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa_%.bbappend
index a31d99b..2d9ec2e 100644
--- a/recipes-graphics/mesa/mesa_%.bbappend
+++ b/recipes-graphics/mesa/mesa_%.bbappend
@@ -1,4 +1,5 @@
 PACKAGECONFIG:append:rk3288 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3328 = " kmsro lima"
 PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
+PACKAGECONFIG:append:rk3568 = " kmsro panfrost"
 PACKAGECONFIG:append:px30 = " kmsro panfrost"

-- 
2.45.1


