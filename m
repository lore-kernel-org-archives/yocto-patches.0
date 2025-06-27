Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1592EC83010
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 14:19:28 +0000 (UTC)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
 by mx.groups.io with SMTP id smtpd.web11.14941.1751033965490238427
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 07:19:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bTHk36r3Rz34S;
	Fri, 27 Jun 2025 16:19:23 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bTHk33yMpz4Cw;
	Fri, 27 Jun 2025 16:19:23 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 27 Jun 2025 16:19:17 +0200
Subject: [meta-rockchip PATCH v3 6/6] mesa: add support for RK3588(S)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-mesa-panthor-v3-6-798c24a9eef3@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1718

From: Quentin Schulz <quentin.schulz@cherry.de>

The Mali G610 found in the RK3588(S) SoC still requires a blob coming
from a linux-firmware package to work.
Therefore, recommend that package when building mesa for rk3588(s).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-graphics/mesa/mesa.bbappend | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
index 50d62b8ac50afe1712dfa03f479d120acc3e4199..d9e7c082fc6be6812b3376496434c4ee823b6f65 100644
--- a/recipes-graphics/mesa/mesa.bbappend
+++ b/recipes-graphics/mesa/mesa.bbappend
@@ -9,3 +9,6 @@ MALI_DRIVER:rk3308 = ""
 
 PACKAGECONFIG:append:rockchip = " ${@bb.utils.filter('MALI_DRIVER', 'lima panfrost', d)}"
 PACKAGECONFIG:append:rockchip = "${@bb.utils.contains('MALI_DRIVER', 'panfrost', ' libclc', '', d)}"
+
+# Mali Gen10 (Valhall, supported by Panthor) requires a firmware blob
+RRECOMMENDS:mesa-megadriver:append:rk3588s = " linux-firmware-mali-csffw-arch108"

-- 
2.50.0


