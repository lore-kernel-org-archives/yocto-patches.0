Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F18DD6911F
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 15:58:58 +0000 (UTC)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
 by mx.groups.io with SMTP id smtpd.web10.97899.1732809537741659897
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Nov 2024 07:58:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.11, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XzgwJ2FMqzVkS;
	Thu, 28 Nov 2024 16:58:56 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XzgwJ02JwzSDl;
	Thu, 28 Nov 2024 16:58:55 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 28 Nov 2024 16:58:49 +0100
Subject: [meta-rockchip PATCH v2 1/2] bsp: rkbin: rkbin-ddr: use version
 and file variables for path matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-rkbin-bump-v2-1-a194385aad7a@cherry.de>
References: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
In-Reply-To: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Nov 2024 15:58:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/856

From: Quentin Schulz <quentin.schulz@cherry.de>

By using variables to give the path where to find the file to install,
it is easier for users to have a different SRCREV for their own machine.

Additionally, because glob patterns are now not used by default, it is
guaranteed only to match a single file.

The glob pattern for rk3308 has been hardcoded with the only file that
matches in the rkbin git repository at the currently used commit.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 README                                      | 15 +++++++++++++++
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 20 ++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 85ab2ec560ff27c0197965f6a6cd26d404723694..6bceba0c9cf09cc0fc881c855fabeeb68aeb55fb 100644
--- a/README
+++ b/README
@@ -55,6 +55,21 @@ Status of supported boards:
 
 Notes:
 -----
+  Custom DDR rkbin version:
+	If you wish to use a different version of DDR binary provided by
+	rockchip-rkbin-ddr recipe than the one in this layer, you can create a
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
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
index 0ff71320de8cfeee259a820a07375f490d1086d6..a5cba9a61f3226def00bd8ab0a777d79ac5de3a1 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
@@ -2,22 +2,34 @@ DESCRIPTION = "Rockchip Firmware for DDR init (TPL in U-Boot terms)"
 
 require rockchip-rkbin.inc
 
+DDRBIN_VERS:rk3308 ?= "v2.07"
+DDRBIN_FILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${DDRBIN_VERS}.bin"
+
 do_deploy:rk3308() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk33/rk3308_ddr_589MHz_uart?_m0_v*.bin ${DEPLOYDIR}/ddr-rk3308.bin
+	install -m 644 ${S}/bin/rk33/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin
 }
 
+DDRBIN_VERS:rk3566 ?= "v1.21"
+DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
+
 do_deploy:rk3566() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3566.bin
+	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3566.bin
 }
 
+DDRBIN_VERS:rk3568 ?= "v1.21"
+DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
+
 do_deploy:rk3568() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3568.bin
+	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3568.bin
 }
 
+DDRBIN_VERS:rk3588s ?= "v1.16"
+DDRBIN_FILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VERS}.bin"
+
 do_deploy:rk3588s() {
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin ${DEPLOYDIR}/ddr-rk3588.bin
+	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3588.bin
 }

-- 
2.47.0


