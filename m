Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681E0C35FF3
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 11:26:50 +0000 (UTC)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
 by mx.groups.io with SMTP id smtpd.web11.6695.1741692404166061725
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Mar 2025 04:26:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.14, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZBs0f3N6Bz1lf;
	Tue, 11 Mar 2025 12:26:42 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZBs0f17Vmz503;
	Tue, 11 Mar 2025 12:26:42 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 11 Mar 2025 12:26:31 +0100
Subject: [meta-rockchip PATCH 2/6] bsp: rkbin: ddr: make deployed name
 configurable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-ddrbin-custom-v1-2-e5c994ac25e1@cherry.de>
References: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
In-Reply-To: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 11:26:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1184

From: Quentin Schulz <quentin.schulz@cherry.de>

This will also allow us to generate an SoC-agnostic do_deploy instead of
duplicating it for each SoC.

Additionally, it allows users to pick a different name for the deployed
binary.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
index a88cfc10bb4404634671c7f193b4255405da6b21..546560cf58b0480efd0f89ff21639c7b78f70530 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
@@ -5,35 +5,39 @@ require rockchip-rkbin.inc
 DDRBIN_DIR:rk3308 ?= "bin/rk33/"
 DDRBIN_VERS:rk3308 ?= "v2.10"
 DDRBIN_FILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${DDRBIN_VERS}.bin"
+DDRBIN_DEPLOY_FILENAME:rk3308 ?= "ddr-rk3308.bin"
 
 do_deploy:rk3308() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin
+	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
 }
 
 DDRBIN_DIR:rk3566 ?= "bin/rk35/"
 DDRBIN_VERS:rk3566 ?= "v1.23"
 DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
+DDRBIN_DEPLOY_FILENAME:rk3566 ?= "ddr-rk3566.bin"
 
 do_deploy:rk3566() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3566.bin
+	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
 }
 
 DDRBIN_DIR:rk3568 ?= "bin/rk35/"
 DDRBIN_VERS:rk3568 ?= "v1.23"
 DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
+DDRBIN_DEPLOY_FILENAME:rk3568 ?= "ddr-rk3568.bin"
 
 do_deploy:rk3568() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3568.bin
+	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
 }
 
 DDRBIN_DIR:rk3588s ?= "bin/rk35/"
 DDRBIN_VERS:rk3588s ?= "v1.18"
 DDRBIN_FILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VERS}.bin"
+DDRBIN_DEPLOY_FILENAME:rk3588s ?= "ddr-rk3588.bin"
 
 do_deploy:rk3588s() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3588.bin
+	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
 }

-- 
2.48.1


