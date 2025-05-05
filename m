Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB1CC3ABBC
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 14:20:57 +0000 (UTC)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
 by mx.groups.io with SMTP id smtpd.web11.51614.1746454852000012382
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 07:20:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.10, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZrkGB1zm0zDFx;
	Mon,  5 May 2025 16:20:50 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZrkG9669Tzt8Q;
	Mon,  5 May 2025 16:20:49 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 05 May 2025 16:20:37 +0200
Subject: [meta-rockchip PATCH v3 1/9] bsp: rkbin: ddr: store directory path
 for the DDR bin blob in a variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-ddrbin-custom-v3-1-577b94c72035@cherry.de>
References: <20250505-ddrbin-custom-v3-0-577b94c72035@cherry.de>
In-Reply-To: <20250505-ddrbin-custom-v3-0-577b94c72035@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 14:20:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1503

From: Quentin Schulz <quentin.schulz@cherry.de>

This will be used in a later commit when an SoC-agnostic do_configure will
call ddrbin_tool.py with the DDR bin blob as input.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
index 3227a53db22ba5906355e6925399aafe08813c9f..a88cfc10bb4404634671c7f193b4255405da6b21 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
@@ -2,34 +2,38 @@ DESCRIPTION = "Rockchip Firmware for DDR init (TPL in U-Boot terms)"
 
 require rockchip-rkbin.inc
 
+DDRBIN_DIR:rk3308 ?= "bin/rk33/"
 DDRBIN_VERS:rk3308 ?= "v2.10"
 DDRBIN_FILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${DDRBIN_VERS}.bin"
 
 do_deploy:rk3308() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk33/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin
+	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin
 }
 
+DDRBIN_DIR:rk3566 ?= "bin/rk35/"
 DDRBIN_VERS:rk3566 ?= "v1.23"
 DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
 
 do_deploy:rk3566() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3566.bin
+	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3566.bin
 }
 
+DDRBIN_DIR:rk3568 ?= "bin/rk35/"
 DDRBIN_VERS:rk3568 ?= "v1.23"
 DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
 
 do_deploy:rk3568() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3568.bin
+	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3568.bin
 }
 
+DDRBIN_DIR:rk3588s ?= "bin/rk35/"
 DDRBIN_VERS:rk3588s ?= "v1.18"
 DDRBIN_FILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VERS}.bin"
 
 do_deploy:rk3588s() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3588.bin
+	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3588.bin
 }

-- 
2.49.0


