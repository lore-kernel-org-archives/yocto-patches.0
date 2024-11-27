Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C877AD6ACE9
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 15:13:40 +0000 (UTC)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
 by mx.groups.io with SMTP id smtpd.web10.73873.1732720416139362112
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 Nov 2024 07:13:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.171, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xz2yQ6HkwzLqr;
	Wed, 27 Nov 2024 16:13:34 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xz2yQ38QxzGjG;
	Wed, 27 Nov 2024 16:13:34 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 27 Nov 2024 16:12:58 +0100
Subject: [meta-rockchip PATCH 1/2] bsp: rkbin: rkbin-ddr: use glob pattern
 for finding DDR init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-rkbin-bump-v1-1-b90b6c04a88f@cherry.de>
References: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
In-Reply-To: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 Nov 2024 15:13:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/844

From: Quentin Schulz <quentin.schulz@cherry.de>

To avoid both having to modify this file every time the
rockchip-rbin.inc SRCREV is bumped and also having to override it were
a user to have to mix and match versions for different products, let's
just use a glob pattern.

Note that the glob pattern should only match one path, which is the case
right now.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
index 0ff71320de8cfeee259a820a07375f490d1086d6..a22c7e12c32b5e1988e8e6b870b94cf9438f23ae 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
@@ -9,15 +9,15 @@ do_deploy:rk3308() {
 
 do_deploy:rk3566() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3566.bin
+	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v*.bin ${DEPLOYDIR}/ddr-rk3566.bin
 }
 
 do_deploy:rk3568() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3568.bin
+	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v*.bin ${DEPLOYDIR}/ddr-rk3568.bin
 }
 
 do_deploy:rk3588s() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin ${DEPLOYDIR}/ddr-rk3588.bin
+	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin ${DEPLOYDIR}/ddr-rk3588.bin
 }

-- 
2.47.0


