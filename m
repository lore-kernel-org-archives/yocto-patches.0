Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEF2CDD1A2
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 12:37:14 +0000 (UTC)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
 by mx.groups.io with SMTP id smtpd.web11.67984.1727440625050571231
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Sep 2024 05:37:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XFVMz3pTqzd2G;
	Fri, 27 Sep 2024 14:37:03 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XFVMz1HkRzhn0;
	Fri, 27 Sep 2024 14:37:03 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 27 Sep 2024 14:36:52 +0200
Subject: [meta-rockchip PATCH 2/3] bsp: rkbin: split optee-os, tf-a and ddr
 init from rkbin into separate recipes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-rkbin-split-recipes-v1-2-0f4a9b0cbf56@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/680

From: Quentin Schulz <quentin.schulz@cherry.de>

Having one common recipe for optee-os, TF-A and DDR init blobs coming
from rkbin is nice for maintenance but it doesn't allow for having e.g.
TF-A come from another recipe and optee-os and DDR init from this one.

Now that upstream TF-A has initial support for RK356x and RK3588, but
there's still no open OP-TEE OS or DDR init, it'd be nice to allow users
to have upstream TF-A.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3308.inc                  |  4 ++-
 conf/machine/include/rk3566.inc                  |  4 +--
 conf/machine/include/rk3568.inc                  |  4 +--
 conf/machine/include/rk3588s.inc                 |  4 +--
 recipes-bsp/rkbin/rk3308-rkbin_git.bb            |  4 ++-
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb      | 23 +++++++++++++
 recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb | 27 +++++++++++++++
 recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb     | 27 +++++++++++++++
 recipes-bsp/rkbin/rockchip-rkbin_git.bb          | 44 ------------------------
 recipes-bsp/u-boot/u-boot-rockchip.inc           |  2 +-
 10 files changed, 90 insertions(+), 53 deletions(-)

diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
index 5abdd06..1ecf085 100644
--- a/conf/machine/include/rk3308.inc
+++ b/conf/machine/include/rk3308.inc
@@ -19,4 +19,6 @@ KERNEL_IMAGETYPE ?= "fitImage"
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
 
-PREFERRED_PROVIDER_rockchip-rkbin = "${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin', 'rk3308-rkbin', d)}"
+PREFERRED_PROVIDER_rockchip-rkbin-ddr = "${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin-ddr', 'rk3308-rkbin', d)}"
+PREFERRED_PROVIDER_rockchip-rkbin-tf-a = "${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin-tf-a', 'rk3308-rkbin', d)}"
+PREFERRED_PROVIDER_rockchip-rkbin-optee-os = "${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin-optee-os', 'rk3308-rkbin', d)}"
diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
index 2522851..bb03cce 100644
--- a/conf/machine/include/rk3566.inc
+++ b/conf/machine/include/rk3566.inc
@@ -14,8 +14,8 @@ KERNEL_FEATURES:append:rk3566 = " bsp/rockchip/remove-non-rockchip-arch-arm64.sc
 KERNEL_CLASSES = "kernel-fitimage"
 KERNEL_IMAGETYPE ?= "fitImage"
 
-PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin"
-PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
+PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
+PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
index db188a3..b7e3fe6 100644
--- a/conf/machine/include/rk3568.inc
+++ b/conf/machine/include/rk3568.inc
@@ -14,8 +14,8 @@ KERNEL_FEATURES:append:rk3568 = " bsp/rockchip/remove-non-rockchip-arch-arm64.sc
 KERNEL_CLASSES = "kernel-fitimage"
 KERNEL_IMAGETYPE ?= "fitImage"
 
-PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin"
-PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
+PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
+PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index d349108..7ea944c 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -13,8 +13,8 @@ KERNEL_FEATURES:append:rk3588s = " bsp/rockchip/remove-non-rockchip-arch-arm64.s
 KERNEL_CLASSES = "kernel-fitimage"
 KERNEL_IMAGETYPE ?= "fitImage"
 
-PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin"
-PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
+PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
+PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
diff --git a/recipes-bsp/rkbin/rk3308-rkbin_git.bb b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
index f32b57a..eaf2ce1 100644
--- a/recipes-bsp/rkbin/rk3308-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
@@ -6,7 +6,9 @@ SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
 SRCREV = "e65b97b511f1349156702db40694454c141d8fe2"
 
 PROVIDES += "trusted-firmware-a"
-PROVIDES += "rockchip-rkbin"
+PROVIDES += "rockchip-rkbin-ddr"
+PROVIDES += "rockchip-rkbin-tf-a"
+PROVIDES += "rockchip-rkbin-optee-os"
 PROVIDES += "optee-os"
 
 inherit bin_package deploy
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
new file mode 100644
index 0000000..0ff7132
--- /dev/null
+++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
@@ -0,0 +1,23 @@
+DESCRIPTION = "Rockchip Firmware for DDR init (TPL in U-Boot terms)"
+
+require rockchip-rkbin.inc
+
+do_deploy:rk3308() {
+	# Prebuilt U-Boot TPL (DDR init)
+	install -m 644 ${S}/bin/rk33/rk3308_ddr_589MHz_uart?_m0_v*.bin ${DEPLOYDIR}/ddr-rk3308.bin
+}
+
+do_deploy:rk3566() {
+	# Prebuilt U-Boot TPL (DDR init)
+	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3566.bin
+}
+
+do_deploy:rk3568() {
+	# Prebuilt U-Boot TPL (DDR init)
+	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3568.bin
+}
+
+do_deploy:rk3588s() {
+	# Prebuilt U-Boot TPL (DDR init)
+	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin ${DEPLOYDIR}/ddr-rk3588.bin
+}
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
new file mode 100644
index 0000000..6d25368
--- /dev/null
+++ b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
@@ -0,0 +1,27 @@
+DESCRIPTION = "Rockchip OP-TEE OS (BL32) blob"
+
+require rockchip-rkbin.inc
+
+PROVIDES += "optee-os"
+
+do_deploy:rk3308() {
+	# Prebuilt OPTEE-OS
+	install -m 644 ${S}/bin/rk33/rk3308_bl32_v*.bin ${DEPLOYDIR}/tee-rk3308.bin
+}
+
+# NOTE: the following are not typos
+#       the rk3566 uses the same bl32 as the rk3568
+do_deploy:rk3566() {
+	# Prebuilt OPTEE-OS
+	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3566.bin
+}
+
+do_deploy:rk3568() {
+	# Prebuilt OPTEE-OS
+	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3568.bin
+}
+
+do_deploy:rk3588s() {
+	# Prebuilt OPTEE-OS
+	install -m 644 ${S}/bin/rk35/rk3588_bl32_v*.bin ${DEPLOYDIR}/tee-rk3588.bin
+}
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
new file mode 100644
index 0000000..0ed28a2
--- /dev/null
+++ b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
@@ -0,0 +1,27 @@
+DESCRIPTION = "Rockchip Trusted-Firmware-A (BL31) blob"
+
+require rockchip-rkbin.inc
+
+PROVIDES += "trusted-firmware-a"
+
+do_deploy:rk3308() {
+	# Prebuilt TF-A
+	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3308.elf
+}
+
+# NOTE: the following are not typos
+#       the rk3566 uses the same bl31 as the rk3568
+do_deploy:rk3566() {
+	# Prebuilt TF-A
+	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3566.elf
+}
+
+do_deploy:rk3568() {
+	# Prebuilt TF-A
+	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3568.elf
+}
+
+do_deploy:rk3588s() {
+	# Prebuilt TF-A
+	install -m 644 ${S}/bin/rk35/rk3588_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3588.elf
+}
diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
deleted file mode 100644
index a841c2e..0000000
--- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
+++ /dev/null
@@ -1,44 +0,0 @@
-DESCRIPTION = "Rockchip Firmware and Tool Binaries"
-
-require rockchip-rkbin.inc
-
-PROVIDES += "trusted-firmware-a"
-PROVIDES += "optee-os"
-
-do_deploy:rk3308() {
-	# Prebuilt TF-A
-	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3308.elf
-	# Prebuilt OPTEE-OS
-	install -m 644 ${S}/bin/rk33/rk3308_bl32_v*.bin ${DEPLOYDIR}/tee-rk3308.bin
-	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk33/rk3308_ddr_589MHz_uart?_m0_v*.bin ${DEPLOYDIR}/ddr-rk3308.bin
-}
-
-# NOTE: the following are not typos
-#       the rk3566 uses the same bl31/2 as the rk3568
-do_deploy:rk3566() {
-	# Prebuilt TF-A
-	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3566.elf
-	# Prebuilt OPTEE-OS
-	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3566.bin
-	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3566.bin
-}
-
-do_deploy:rk3568() {
-	# Prebuilt TF-A
-	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3568.elf
-	# Prebuilt OPTEE-OS
-	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3568.bin
-	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3568.bin
-}
-
-do_deploy:rk3588s() {
-	# Prebuilt TF-A
-	install -m 644 ${S}/bin/rk35/rk3588_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3588.elf
-	# Prebuilt OPTEE-OS
-	install -m 644 ${S}/bin/rk35/rk3588_bl32_v*.bin ${DEPLOYDIR}/tee-rk3588.bin
-	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin ${DEPLOYDIR}/ddr-rk3588.bin
-}
diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc b/recipes-bsp/u-boot/u-boot-rockchip.inc
index d2267cc..2b5bbd7 100644
--- a/recipes-bsp/u-boot/u-boot-rockchip.inc
+++ b/recipes-bsp/u-boot/u-boot-rockchip.inc
@@ -14,5 +14,5 @@ ROCKCHIP_TPL:closed-tpl:rk3588s = "${DEPLOY_DIR_IMAGE}/ddr-rk3588.bin"
 EXTRA_OEMAKE:append:closed-tpl = " ROCKCHIP_TPL=${ROCKCHIP_TPL}"
 
 INIT_FIRMWARE_DEPENDS ??= ""
-INIT_FIRMWARE_DEPENDS:closed-tpl = " rockchip-rkbin:do_deploy"
+INIT_FIRMWARE_DEPENDS:closed-tpl = " rockchip-rkbin-ddr:do_deploy"
 do_compile[depends] .= "${INIT_FIRMWARE_DEPENDS}"

-- 
2.46.1


