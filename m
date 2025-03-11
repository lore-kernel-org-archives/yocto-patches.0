Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BFEC35FF2
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 11:26:50 +0000 (UTC)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
 by mx.groups.io with SMTP id smtpd.web10.6513.1741692404819663191
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Mar 2025 04:26:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.14, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZBs0g35Grz2nr;
	Tue, 11 Mar 2025 12:26:43 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZBs0g0tfYz4hK;
	Tue, 11 Mar 2025 12:26:43 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 11 Mar 2025 12:26:34 +0100
Subject: [meta-rockchip PATCH 5/6] bsp: rkbin: ddr: factor out do_deploy to
 be SoC-agnostic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-ddrbin-custom-v1-5-e5c994ac25e1@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1187

From: Quentin Schulz <quentin.schulz@cherry.de>

The do_deploy task is essentially the same for all SoCs, install a file
from a specific path to another one.

No magic involved, so let's rather have one generic do_deploy task. For
this to work nicely, we check that all necessary variables are set and
notify the developer otherwise. This may be useful whenever a new SoC
will be supported by this recipe.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 33 +++++++++++++++--------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
index 193d0f00a6868f050a0ff4531278b3296d3eae94..17131b6d5a6b443409eacb5806e0613b292852d7 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
@@ -8,40 +8,41 @@ DDRBIN_FILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${DDRBIN_VERS}.bin"
 DDRBIN_DEPLOY_FILENAME:rk3308 ?= "ddr-rk3308.bin"
 DDRBIN_TOOL_SOC:rk3308 ?= "rk3308"
 
-do_deploy:rk3308() {
-	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
-}
-
 DDRBIN_DIR:rk3566 ?= "bin/rk35/"
 DDRBIN_VERS:rk3566 ?= "v1.23"
 DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
 DDRBIN_DEPLOY_FILENAME:rk3566 ?= "ddr-rk3566.bin"
 DDRBIN_TOOL_SOC:rk3566 ?= "rk356x"
 
-do_deploy:rk3566() {
-	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
-}
-
 DDRBIN_DIR:rk3568 ?= "bin/rk35/"
 DDRBIN_VERS:rk3568 ?= "v1.23"
 DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
 DDRBIN_DEPLOY_FILENAME:rk3568 ?= "ddr-rk3568.bin"
 DDRBIN_TOOL_SOC:rk3568 ?= "rk356x"
 
-do_deploy:rk3568() {
-	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
-}
-
 DDRBIN_DIR:rk3588s ?= "bin/rk35/"
 DDRBIN_VERS:rk3588s ?= "v1.18"
 DDRBIN_FILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VERS}.bin"
 DDRBIN_DEPLOY_FILENAME:rk3588s ?= "ddr-rk3588.bin"
 DDRBIN_TOOL_SOC:rk3588s ?= "rk3588"
 
-do_deploy:rk3588s() {
+do_deploy() {
+	if [ -z "${DDRBIN_DIR}" ]; then
+		bbfatal "Non-empty DDRBIN_DIR:<MACHINE> required!"
+	fi
+
+	if [ -z "${DDRBIN_VERS}" ]; then
+		bbfatal "Non-empty DDRBIN_VERS:<MACHINE> required!"
+	fi
+
+	if [ -z "${DDRBIN_FILE}" ]; then
+		bbfatal "Non-empty DDRBIN_FILE:<MACHINE> required!"
+	fi
+
+	if [ -z "${DDRBIN_DEPLOY_FILENAME}" ]; then
+		bbfatal "Non-empty DDRBIN_DEPLOY_FILENAME:<MACHINE> required!"
+	fi
+
 	# Prebuilt U-Boot TPL (DDR init)
 	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
 }

-- 
2.48.1


