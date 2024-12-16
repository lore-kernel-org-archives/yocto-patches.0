Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0203DE77180
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 13:40:40 +0000 (UTC)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
 by mx.groups.io with SMTP id smtpd.web10.56749.1734356431689421458
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Dec 2024 05:40:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.173, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YBh0F5N3wzqZ6;
	Mon, 16 Dec 2024 14:40:29 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YBh0F2qwFzPCB;
	Mon, 16 Dec 2024 14:40:29 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 16 Dec 2024 14:39:48 +0100
Subject: [meta-rockchip PATCH scarthgap 2/3] bsp: rkbin: use version and
 file variables for path matching the DDR init binary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-rkbin-bump-scarthgap-v1-2-9057e03351ad@cherry.de>
References: <20241216-rkbin-bump-scarthgap-v1-0-9057e03351ad@cherry.de>
In-Reply-To: <20241216-rkbin-bump-scarthgap-v1-0-9057e03351ad@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Trevor Woerner <twoerner@gmail.com>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Dec 2024 13:40:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/929

From: Quentin Schulz <quentin.schulz@cherry.de>

By using variables to give the path where to find the file to install,
it is easier for users to have a different SRCREV for their own machine.

Additionally, because glob patterns are now not used by default, it is
guaranteed only to match a single file.

The glob pattern for rk3308 has been hardcoded with the only file that
matches in the rkbin git repository at the currently used commit.

Reviewed-by: Trevor Woerner <twoerner@gmail.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
(cherry picked from commit ca38f7cea5a6dc50cba46459741564961f55485f)
[apply to rockchip-rkbin_git.bb instead of rockchip-rkbin.inc]
[reword commit title]
[reword README]
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 README                                  | 15 +++++++++++++++
 recipes-bsp/rkbin/rockchip-rkbin_git.bb | 20 ++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 09f8691300f4385342022c0de4d0fa10b121a494..6f5866bdf1f503ddc06fcc31d16275fe68986959 100644
--- a/README
+++ b/README
@@ -54,6 +54,21 @@ Status of supported boards:
 
 Notes:
 -----
+  Custom rkbin version:
+	If you wish to use a different version of DDR binary provided by
+	rockchip-rkbin recipe than the one in this layer, you can create a
+	.bbappend in your own layer, and accordingly set SRCREV (possibly
+	LIC_FILES_CHKSUM too) and the version for path matching stored in
+	DDRBIN_VERS variable. Do so in your .bbappend with:
+
+		DDRBIN_VERS:my-machine = "v2.07"
+
+	If somehow the filename differs from the one provided in this layer, you
+	can override it from your bbappend with the DDRBIN_FILE variable:
+
+		DDRBIN_VERS:my-machine = "v2.07"
+		DDRBIN_FILE:my-machine = "rk3308_ddr_451MHz_uart4_m0_${DDRBIN_VERS}.bin"
+
   rk3308 rkbin:
 	The latest ddr initializer for the rk3308 platform does not output
 	diagnostic messages to uart0. This causes a bunch of gibberish to
diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
index 6e87507e3983710fa1e0a2db5d83e9e2a20d9ced..f13c134604a10384793c92632e150eb0aaa4cd8e 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
@@ -30,15 +30,21 @@ do_install() {
 PACKAGES = "${PN}"
 ALLOW_EMPTY:${PN} = "1"
 
+DDRBIN_VERS:rk3308 ?= "v2.07"
+DDRBIN_FILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${DDRBIN_VERS}.bin"
+
 do_deploy:rk3308() {
 	# Prebuilt TF-A
 	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3308.elf
 	# Prebuilt OPTEE-OS
 	install -m 644 ${S}/bin/rk33/rk3308_bl32_v*.bin ${DEPLOYDIR}/tee-rk3308.bin
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk33/rk3308_ddr_589MHz_uart?_m0_v*.bin ${DEPLOYDIR}/ddr-rk3308.bin
+	install -m 644 ${S}/bin/rk33/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin
 }
 
+DDRBIN_VERS:rk3566 ?= "v1.21"
+DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
+
 # NOTE: the following are not typos
 #       the rk3566 uses the same bl31/2 as the rk3568
 do_deploy:rk3566() {
@@ -47,25 +53,31 @@ do_deploy:rk3566() {
 	# Prebuilt OPTEE-OS
 	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3566.bin
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3566.bin
+	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3566.bin
 }
 
+DDRBIN_VERS:rk3568 ?= "v1.21"
+DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
+
 do_deploy:rk3568() {
 	# Prebuilt TF-A
 	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3568.elf
 	# Prebuilt OPTEE-OS
 	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3568.bin
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3568.bin
+	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3568.bin
 }
 
+DDRBIN_VERS:rk3588s ?= "v1.16"
+DDRBIN_FILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VERS}.bin"
+
 do_deploy:rk3588s() {
 	# Prebuilt TF-A
 	install -m 644 ${S}/bin/rk35/rk3588_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3588.elf
 	# Prebuilt OPTEE-OS
 	install -m 644 ${S}/bin/rk35/rk3588_bl32_v*.bin ${DEPLOYDIR}/tee-rk3588.bin
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin ${DEPLOYDIR}/ddr-rk3588.bin
+	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3588.bin
 }
 
 do_deploy() {

-- 
2.47.1


