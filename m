Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED06CDD1A1
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 12:37:14 +0000 (UTC)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
 by mx.groups.io with SMTP id smtpd.web10.67859.1727440624851777569
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Sep 2024 05:37:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XFVMz1QKfzg4j;
	Fri, 27 Sep 2024 14:37:03 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XFVMy6RGLzlMC;
	Fri, 27 Sep 2024 14:37:02 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 27 Sep 2024 14:36:51 +0200
Subject: [meta-rockchip PATCH 1/3] bsp: rkbin: add .inc for factoring out
 reusable pieces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-rkbin-split-recipes-v1-1-0f4a9b0cbf56@cherry.de>
References: <20240927-rkbin-split-recipes-v1-0-0f4a9b0cbf56@cherry.de>
In-Reply-To: <20240927-rkbin-split-recipes-v1-0-0f4a9b0cbf56@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Sep 2024 12:37:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/679

From: Quentin Schulz <quentin.schulz@cherry.de>

In future commits, the rkbin recipe will be split into multiple ones:
- one for TPL DRAM init
- one for TF-A blob (BL31)
- one for OP-TEE OS blob (BL32)

Since in most cases those three blobs will be coming from the exact same
commit hash and repo, let's have a .inc so some duplication can be
avoided.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin.inc    | 30 ++++++++++++++++++++++++++++++
 recipes-bsp/rkbin/rockchip-rkbin_git.bb | 31 +------------------------------
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
new file mode 100644
index 0000000..abd2e30
--- /dev/null
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -0,0 +1,30 @@
+SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
+SRCREV = "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
+LICENSE = "Proprietary"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
+
+inherit bin_package deploy
+
+S = "${WORKDIR}/git"
+
+COMPATIBLE_MACHINE = "^$"
+COMPATIBLE_MACHINE:rk3308 = "rk3308"
+COMPATIBLE_MACHINE:rk3566 = "rk3566"
+COMPATIBLE_MACHINE:rk3568 = "rk3568"
+COMPATIBLE_MACHINE:rk3588s = "rk3588s"
+
+PACKAGE_ARCH = "${MACHINE_ARCH}"
+
+do_install() {
+	# Nothing in this recipe is useful in a filesystem
+	:
+}
+
+PACKAGES = "${PN}"
+ALLOW_EMPTY:${PN} = "1"
+
+do_deploy() {
+	bbfatal "COMPATIBLE_MACHINE requires a corresponding do_deploy:<MACHINE>() override"
+}
+
+addtask deploy after do_install
diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
index 1b71414..a841c2e 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
@@ -1,33 +1,10 @@
 DESCRIPTION = "Rockchip Firmware and Tool Binaries"
-LICENSE = "Proprietary"
-LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
 
-SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
-SRCREV = "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
+require rockchip-rkbin.inc
 
 PROVIDES += "trusted-firmware-a"
 PROVIDES += "optee-os"
 
-inherit bin_package deploy
-
-S = "${WORKDIR}/git"
-
-COMPATIBLE_MACHINE = "^$"
-COMPATIBLE_MACHINE:rk3308 = "rk3308"
-COMPATIBLE_MACHINE:rk3566 = "rk3566"
-COMPATIBLE_MACHINE:rk3568 = "rk3568"
-COMPATIBLE_MACHINE:rk3588s = "rk3588s"
-
-PACKAGE_ARCH = "${MACHINE_ARCH}"
-
-do_install() {
-	# Nothing in this recipe is useful in a filesystem
-	:
-}
-
-PACKAGES = "${PN}"
-ALLOW_EMPTY:${PN} = "1"
-
 do_deploy:rk3308() {
 	# Prebuilt TF-A
 	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3308.elf
@@ -65,9 +42,3 @@ do_deploy:rk3588s() {
 	# Prebuilt U-Boot TPL (DDR init)
 	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin ${DEPLOYDIR}/ddr-rk3588.bin
 }
-
-do_deploy() {
-	bbfatal "COMPATIBLE_MACHINE requires a corresponding do_deploy:<MACHINE>() override"
-}
-
-addtask deploy after do_install

-- 
2.46.1


