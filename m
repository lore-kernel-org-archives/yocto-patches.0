Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5FAC369D1
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 14:50:50 +0000 (UTC)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
 by mx.groups.io with SMTP id smtpd.web11.13633.1744987848591134267
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Apr 2025 07:50:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZfHkb1VNdz2Xt;
	Fri, 18 Apr 2025 16:50:47 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZfHkZ2K6Cz1Ly;
	Fri, 18 Apr 2025 16:50:46 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 18 Apr 2025 16:50:20 +0200
Subject: [meta-rockchip PATCH v2 8/9] bsp: rkbin: factor out do_deploy and
 RKBIN_BINDIR variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-ddrbin-custom-v2-8-700828527faf@cherry.de>
References: <20250418-ddrbin-custom-v2-0-700828527faf@cherry.de>
In-Reply-To: <20250418-ddrbin-custom-v2-0-700828527faf@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 14:50:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1395

From: Quentin Schulz <quentin.schulz@cherry.de>

do_deploy is now identical for all recipes including rockchip-rkbin.inc
so let's simply move it to the .inc file to avoid duplication.

While at it, RKBIN_BINDIR is also identical so can also be moved to the
.inc, so do it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb      | 21 ---------------------
 recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb | 21 ---------------------
 recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb     | 21 ---------------------
 recipes-bsp/rkbin/rockchip-rkbin.inc             | 19 ++++++++++++++++++-
 4 files changed, 18 insertions(+), 64 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
index 5b049f9a2b77a77d8ea44268a1f47c60659e16d1..7f1e82081ed2925f386a1cee46ab62c549f8b5fa 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
@@ -2,22 +2,18 @@ DESCRIPTION = "Rockchip Firmware for DDR init (TPL in U-Boot terms)"
 
 require rockchip-rkbin.inc
 
-RKBIN_BINDIR:rk3308 ?= "bin/rk33/"
 RKBIN_BINVERS:rk3308 ?= "v2.10"
 RKBIN_BINFILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3308 ?= "ddr-rk3308.bin"
 
-RKBIN_BINDIR:rk3566 ?= "bin/rk35/"
 RKBIN_BINVERS:rk3566 ?= "v1.23"
 RKBIN_BINFILE:rk3566 ?= "rk3566_ddr_1056MHz_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3566 ?= "ddr-rk3566.bin"
 
-RKBIN_BINDIR:rk3568 ?= "bin/rk35/"
 RKBIN_BINVERS:rk3568 ?= "v1.23"
 RKBIN_BINFILE:rk3568 ?= "rk3568_ddr_1560MHz_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3568 ?= "ddr-rk3568.bin"
 
-RKBIN_BINDIR:rk3588s ?= "bin/rk35/"
 RKBIN_BINVERS:rk3588s ?= "v1.18"
 RKBIN_BINFILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3588s ?= "ddr-rk3588.bin"
@@ -27,23 +23,6 @@ DDRBIN_TOOL_SOC:rk3308 ?= "rk3308"
 DDRBIN_TOOL_SOC:rk3566 ?= "rk356x"
 DDRBIN_TOOL_SOC:rk3588s ?= "rk3588"
 
-do_deploy() {
-	if [ -z "${RKBIN_BINDIR}" ]; then
-		bbfatal "Non-empty RKBIN_BINDIR:<MACHINE> required!"
-	fi
-
-	if [ -z "${RKBIN_BINFILE}" ]; then
-		bbfatal "Non-empty RKBIN_BINFILE:<MACHINE> required!"
-	fi
-
-	if [ -z "${RKBIN_DEPLOY_FILENAME}" ]; then
-		bbfatal "Non-empty RKBIN_DEPLOY_FILENAME:<MACHINE> required!"
-	fi
-
-	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/${RKBIN_BINDIR}${RKBIN_BINFILE} ${DEPLOYDIR}/${RKBIN_DEPLOY_FILENAME}
-}
-
 # The following is only required if DDR bin blob needs to be modified
 # (e.g. different UART controller, UART mux, or baudrate)
 # RKBIN_DDR_RECONFIGURE = "1" if it needs to be modified, all below logic needs to
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
index 7858688b23679d67df5ac2739312ef83b677af6b..b534e6359645cd7082c9ac69036de15ce8813b3a 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
@@ -4,42 +4,21 @@ require rockchip-rkbin.inc
 
 PROVIDES += "optee-os"
 
-RKBIN_BINDIR:rk3308 ?= "bin/rk33/"
 RKBIN_BINVERS:rk3308 ?= "v2.08"
 RKBIN_BINFILE:rk3308 ?= "rk3308_bl32_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3308 ?= "tee-rk3308.bin"
 
 RKBIN_BINVERS_RK356x ?= "v2.14"
-RKBIN_BINDIR:rk3566 ?= "bin/rk35/"
 RKBIN_BINVERS:rk3566 ?= "${RKBIN_BINVERS_RK356x}"
 # NOTE: the following are not typos
 #       the rk3566 uses the same bl32 as the rk3568
 RKBIN_BINFILE:rk3566 ?= "rk3568_bl32_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3566 ?= "tee-rk3566.bin"
 
-RKBIN_BINDIR:rk3568 ?= "bin/rk35/"
 RKBIN_BINVERS:rk3568 ?= "${RKBIN_BINVERS_RK356x}"
 RKBIN_BINFILE:rk3568 ?= "rk3568_bl32_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3568 ?= "tee-rk3568.bin"
 
-RKBIN_BINDIR:rk3588s ?= "bin/rk35/"
 RKBIN_BINVERS:rk3588s ?= "v1.17"
 RKBIN_BINFILE:rk3588s ?= "rk3588_bl32_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3588s ?= "tee-rk3588.bin"
-
-do_deploy() {
-	if [ -z "${RKBIN_BINDIR}" ]; then
-		bbfatal "Non-empty RKBIN_BINDIR:<MACHINE> required!"
-	fi
-
-	if [ -z "${RKBIN_BINFILE}" ]; then
-		bbfatal "Non-empty RKBIN_BINFILE:<MACHINE> required!"
-	fi
-
-	if [ -z "${RKBIN_DEPLOY_FILENAME}" ]; then
-		bbfatal "Non-empty RKBIN_DEPLOY_FILENAME:<MACHINE> required!"
-	fi
-
-	# Prebuilt OPTEE-OS
-	install -m 644 ${S}/${RKBIN_BINDIR}${RKBIN_BINFILE} ${DEPLOYDIR}/${RKBIN_DEPLOY_FILENAME}
-}
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
index e6c3199c9fc06aa88173aaa42f2bc8cd365551a8..94dfd229c3b92613d9e5313bb8d3296f74cee6d1 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
@@ -4,42 +4,21 @@ require rockchip-rkbin.inc
 
 PROVIDES += "trusted-firmware-a"
 
-RKBIN_BINDIR:rk3308 ?= "bin/rk33/"
 RKBIN_BINVERS:rk3308 ?= "v2.26"
 RKBIN_BINFILE:rk3308 ?= "rk3308_bl31_${RKBIN_BINVERS}.elf"
 RKBIN_DEPLOY_FILENAME:rk3308 ?= "tee-rk3308.elf"
 
 RKBIN_BINVERS_RK356x ?= "v1.44"
-RKBIN_BINDIR:rk3566 ?= "bin/rk35/"
 RKBIN_BINVERS:rk3566 ?= "${RKBIN_BINVERS_RK356x}"
 # NOTE: the following are not typos
 #       the rk3566 uses the same bl31 as the rk3568
 RKBIN_BINFILE:rk3566 ?= "rk3568_bl31_${RKBIN_BINVERS}.elf"
 RKBIN_DEPLOY_FILENAME:rk3566 ?= "tee-rk3566.elf"
 
-RKBIN_BINDIR:rk3568 ?= "bin/rk35/"
 RKBIN_BINVERS:rk3568 ?= "${RKBIN_BINVERS_RK356x}"
 RKBIN_BINFILE:rk3568 ?= "rk3568_bl31_${RKBIN_BINVERS}.elf"
 RKBIN_DEPLOY_FILENAME:rk3568 ?= "tee-rk3568.elf"
 
-RKBIN_BINDIR:rk3588s ?= "bin/rk35/"
 RKBIN_BINVERS:rk3588s ?= "v1.47"
 RKBIN_BINFILE:rk3588s ?= "rk3588_bl31_${RKBIN_BINVERS}.elf"
 RKBIN_DEPLOY_FILENAME:rk3588s ?= "tee-rk3588.elf"
-
-do_deploy() {
-	if [ -z "${RKBIN_BINDIR}" ]; then
-		bbfatal "Non-empty RKBIN_BINDIR:<MACHINE> required!"
-	fi
-
-	if [ -z "${RKBIN_BINFILE}" ]; then
-		bbfatal "Non-empty RKBIN_BINFILE:<MACHINE> required!"
-	fi
-
-	if [ -z "${RKBIN_DEPLOY_FILENAME}" ]; then
-		bbfatal "Non-empty RKBIN_DEPLOY_FILENAME:<MACHINE> required!"
-	fi
-
-	# Prebuilt TF-A
-	install -m 644 ${S}/${RKBIN_BINDIR}${RKBIN_BINFILE} ${DEPLOYDIR}/${RKBIN_DEPLOY_FILENAME}
-}
diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
index 9264db9048e31b7dae650bdc8e31009f7f4cf404..8a6a9f44ce908934dd58fc3c37d338a43aa00bff 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -25,8 +25,25 @@ do_install() {
 PACKAGES = "${PN}"
 ALLOW_EMPTY:${PN} = "1"
 
+RKBIN_BINDIR:rk3308 ?= "bin/rk33/"
+RKBIN_BINDIR:rk3566 ?= "bin/rk35/"
+RKBIN_BINDIR:rk3568 ?= "bin/rk35/"
+RKBIN_BINDIR:rk3588s ?= "bin/rk35/"
+
 do_deploy() {
-	bbfatal "COMPATIBLE_MACHINE requires a corresponding do_deploy:<MACHINE>() override"
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
+	install -m 644 ${S}/${RKBIN_BINDIR}${RKBIN_BINFILE} ${DEPLOYDIR}/${RKBIN_DEPLOY_FILENAME}
 }
 
 addtask deploy after do_install

-- 
2.49.0


