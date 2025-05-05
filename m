Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9512C3ABBD
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 14:20:57 +0000 (UTC)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
 by mx.groups.io with SMTP id smtpd.web11.51617.1746454854025309435
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 07:20:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.10, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZrkGD58hDzDCZ;
	Mon,  5 May 2025 16:20:52 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZrkGD23n6zqpk;
	Mon,  5 May 2025 16:20:52 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 05 May 2025 16:20:41 +0200
Subject: [meta-rockchip PATCH v3 5/9] bsp: rkbin: ddr: factor out do_deploy
 to be SoC-agnostic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-ddrbin-custom-v3-5-577b94c72035@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1506

From: Quentin Schulz <quentin.schulz@cherry.de>

The do_deploy task is essentially the same for all SoCs, install a file
from a specific path to another one.

No magic involved, so let's rather have one generic do_deploy task. For
this to work nicely, we check that all necessary variables are set and
notify the developer otherwise. This may be useful whenever a new SoC
will be supported by this recipe.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 70 ++++++++++++++---------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
index c368d3f59a39e73cb95ac0018ea93c013d1ebb3d..5b049f9a2b77a77d8ea44268a1f47c60659e16d1 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
@@ -2,48 +2,46 @@ DESCRIPTION = "Rockchip Firmware for DDR init (TPL in U-Boot terms)"
 
 require rockchip-rkbin.inc
 
-DDRBIN_DIR:rk3308 ?= "bin/rk33/"
-DDRBIN_VERS:rk3308 ?= "v2.10"
-DDRBIN_FILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${DDRBIN_VERS}.bin"
-DDRBIN_DEPLOY_FILENAME:rk3308 ?= "ddr-rk3308.bin"
-DDRBIN_TOOL_SOC:rk3308 ?= "rk3308"
+RKBIN_BINDIR:rk3308 ?= "bin/rk33/"
+RKBIN_BINVERS:rk3308 ?= "v2.10"
+RKBIN_BINFILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${RKBIN_BINVERS}.bin"
+RKBIN_DEPLOY_FILENAME:rk3308 ?= "ddr-rk3308.bin"
 
-do_deploy:rk3308() {
-	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
-}
+RKBIN_BINDIR:rk3566 ?= "bin/rk35/"
+RKBIN_BINVERS:rk3566 ?= "v1.23"
+RKBIN_BINFILE:rk3566 ?= "rk3566_ddr_1056MHz_${RKBIN_BINVERS}.bin"
+RKBIN_DEPLOY_FILENAME:rk3566 ?= "ddr-rk3566.bin"
 
-DDRBIN_DIR:rk3566 ?= "bin/rk35/"
-DDRBIN_VERS:rk3566 ?= "v1.23"
-DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
-DDRBIN_DEPLOY_FILENAME:rk3566 ?= "ddr-rk3566.bin"
-DDRBIN_TOOL_SOC:rk3566 ?= "rk356x"
+RKBIN_BINDIR:rk3568 ?= "bin/rk35/"
+RKBIN_BINVERS:rk3568 ?= "v1.23"
+RKBIN_BINFILE:rk3568 ?= "rk3568_ddr_1560MHz_${RKBIN_BINVERS}.bin"
+RKBIN_DEPLOY_FILENAME:rk3568 ?= "ddr-rk3568.bin"
 
-do_deploy:rk3566() {
-	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
-}
+RKBIN_BINDIR:rk3588s ?= "bin/rk35/"
+RKBIN_BINVERS:rk3588s ?= "v1.18"
+RKBIN_BINFILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${RKBIN_BINVERS}.bin"
+RKBIN_DEPLOY_FILENAME:rk3588s ?= "ddr-rk3588.bin"
 
-DDRBIN_DIR:rk3568 ?= "bin/rk35/"
-DDRBIN_VERS:rk3568 ?= "v1.23"
-DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
-DDRBIN_DEPLOY_FILENAME:rk3568 ?= "ddr-rk3568.bin"
 DDRBIN_TOOL_SOC:rk3568 ?= "rk356x"
-
-do_deploy:rk3568() {
-	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
-}
-
-DDRBIN_DIR:rk3588s ?= "bin/rk35/"
-DDRBIN_VERS:rk3588s ?= "v1.18"
-DDRBIN_FILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VERS}.bin"
-DDRBIN_DEPLOY_FILENAME:rk3588s ?= "ddr-rk3588.bin"
+DDRBIN_TOOL_SOC:rk3308 ?= "rk3308"
+DDRBIN_TOOL_SOC:rk3566 ?= "rk356x"
 DDRBIN_TOOL_SOC:rk3588s ?= "rk3588"
 
-do_deploy:rk3588s() {
+do_deploy() {
+	if [ -z "${RKBIN_BINDIR}" ]; then
+		bbfatal "Non-empty RKBIN_BINDIR:<MACHINE> required!"
+	fi
+
+	if [ -z "${RKBIN_BINFILE}" ]; then
+		bbfatal "Non-empty RKBIN_BINFILE:<MACHINE> required!"
+	fi
+
+	if [ -z "${RKBIN_DEPLOY_FILENAME}" ]; then
+		bbfatal "Non-empty RKBIN_DEPLOY_FILENAME:<MACHINE> required!"
+	fi
+
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
+	install -m 644 ${S}/${RKBIN_BINDIR}${RKBIN_BINFILE} ${DEPLOYDIR}/${RKBIN_DEPLOY_FILENAME}
 }
 
 # The following is only required if DDR bin blob needs to be modified
@@ -75,13 +73,13 @@ do_configure() {
 		# This is bad for reproducibility and hashequiv usage, so use the commit author
 		# date of the last change made to the DDR bin.
 		# DATE must be max 17-character long!
-		RKBIN_DDR_DATE=$(git log --pretty=format:"%ad" --date=format:"%Y%m%d-%H:%M:%S" -1 -- ${S}/${DDRBIN_DIR}${DDRBIN_FILE})
+		RKBIN_DDR_DATE=$(git log --pretty=format:"%ad" --date=format:"%Y%m%d-%H:%M:%S" -1 -- ${S}/${RKBIN_BINDIR}${RKBIN_BINFILE})
 		# DDRBIN_TOOL_SOC is mostly useless except for rk3528 for now. It needs to match one string in the global
 		# chip_list array in ddrbin_tool.py.
 		if [ -z "${DDRBIN_TOOL_SOC}" ]; then
 			bbfatal "Non-empty DDRBIN_TOOL_SOC:<MACHINE> required!"
 		fi
 		# Modify blob with appropriate settings stored in ddrbin_params.txt
-		ddrbin_tool.py ${DDRBIN_TOOL_SOC} ${UNPACKDIR}/ddrbin_param.txt ${S}/${DDRBIN_DIR}${DDRBIN_FILE} --verinfo_editable "${RKBIN_DDR_DATE}"
+		ddrbin_tool.py ${DDRBIN_TOOL_SOC} ${UNPACKDIR}/ddrbin_param.txt ${S}/${RKBIN_BINDIR}${RKBIN_BINFILE} --verinfo_editable "${RKBIN_DDR_DATE}"
 	fi
 }

-- 
2.49.0


