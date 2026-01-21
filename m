Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F452C44508
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 17:07:13 +0000 (UTC)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16627.1769015229805724805
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 09:07:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.9, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dx9bb5XqFzH0Z;
	Wed, 21 Jan 2026 18:07:07 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dx9bb18ZnzpyZ;
	Wed, 21 Jan 2026 18:07:07 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 21 Jan 2026 18:06:56 +0100
Subject: [PATCH meta-rockchip] bsp: fix upstream TF-A deploy desync
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-tf-a-fix-v1-1-02f7b61db7f8@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAAryL73YKK9LpK9GG65RKVaEQQ3T3pc
 4ZhHsiUmDL04oFEF2c+9gKqEuCC3RdC9oVBS11LpTSeM1qc+Ubnm86YybfGKCh5TFT0vxpgo9N
 iOtzqAkcY3/cD5AfYpGkAAAA=
X-Change-ID: 20260112-tf-a-fix-cd7944bd8441
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>, Peter Hoyes <peter.hoyes@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 17:07:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3044

From: Quentin Schulz <quentin.schulz@cherry.de>

Since commit 7bce36a2c64b ("arm/trusted-firmware-a: Use
firmware.bbclass") in meta-arm, the BL31 firmware is deployed in a
subdirectory named trusted-firmware-a and the binary is simply called
bl31.elf without any other string.

This differs from what it used to be by the use of the subdirectory and
the name of the file itself. This is an issue for us because the U-Boot
recipe is given the path to the BL31 binary in deploy directory and that
now was wrong.

The second issue is that we want rockchip-rkbin-tf-a to be a drop-in
replacement for the upstream recipe and have nothing to change in other
recipes dependent on *an* implementation of TF-A (such as the U-Boot
recipe).

We can either fixup the path like was done in 2a13a49da4af ("fix u-boot
for tf-a firmware") but we'll need to do that for all current and future
SoCs (and also wasn't a complete fix as for example px30 didn't have the
fixup applied). Or we can simply adapt the rockchip-rkbin-tf-a recipe to
deploy the same way that the upstream trusted-firmware-a recipe does by
installing in a trusted-firmware-a subdirectory, simply name the binary
bl31.elf and update the BL31 environment variable in the U-Boot recipe
to use the new path.

Because RKBIN_DEPLOY_FILENAME now contains a directory in it, we need to
make sure the directory is created (with install -D).

This was tested with upstream+downstream TF-A for RK3588, upstream TF-A
for RK3399 and PX30.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
This is a follow-up to
https://lore.kernel.org/yocto-meta-arm/28377373-a3e8-4416-aa7f-488cdfdbcf55@cherry.de/T/#m76f7d4b56849cc28fe80a76953f4e6e61ff0f7cc
and
https://lore.kernel.org/yocto-patches/dd990ccd-a418-45bc-b708-d3b1fc763ea5@cherry.de/
---
 recipes-bsp/rkbin/rk3308-rkbin_git.bb                        |  2 +-
 recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb                 |  9 +++++----
 recipes-bsp/rkbin/rockchip-rkbin.inc                         |  2 +-
 recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend | 11 -----------
 recipes-bsp/u-boot/u-boot-rockchip.inc                       |  4 +---
 5 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/recipes-bsp/rkbin/rk3308-rkbin_git.bb b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
index ab2c70f..0661fc4 100644
--- a/recipes-bsp/rkbin/rk3308-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
@@ -28,7 +28,7 @@ ALLOW_EMPTY:${PN} = "1"
 
 do_deploy:rk3308() {
 	# Prebuilt TF-A
-	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3308.elf
+	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/trusted-firmware-a/bl31.elf
 	# Prebuilt OPTEE-OS
 	install -m 644 ${S}/bin/rk33/rk3308_bl32_v*.bin ${DEPLOYDIR}/tee-rk3308.bin
 	# Prebuilt U-Boot TPL (DDR init)
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
index f51d9e9..ece5faa 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
@@ -4,21 +4,22 @@ require rockchip-rkbin.inc
 
 PROVIDES += "trusted-firmware-a"
 
+# Must match the naming and path used in
+# meta-arm/recipes-bsp/trusted-firmware-a/ trusted-firmware-a recipes (see also
+# do_deploy() in meta-arm/classes-recipes/firmware.bbclass)
+RKBIN_DEPLOY_FILENAME = "trusted-firmware-a/bl31.elf"
+
 RKBIN_BINVERS:rk3308 ?= "v2.26"
 RKBIN_BINFILE:rk3308 ?= "rk3308_bl31_${RKBIN_BINVERS}.elf"
-RKBIN_DEPLOY_FILENAME:rk3308 ?= "bl31-rk3308.elf"
 
 RKBIN_BINVERS_RK356x ?= "v1.44"
 RKBIN_BINVERS:rk3566 ?= "${RKBIN_BINVERS_RK356x}"
 # NOTE: the following are not typos
 #       the rk3566 uses the same bl31 as the rk3568
 RKBIN_BINFILE:rk3566 ?= "rk3568_bl31_${RKBIN_BINVERS}.elf"
-RKBIN_DEPLOY_FILENAME:rk3566 ?= "bl31-rk3566.elf"
 
 RKBIN_BINVERS:rk3568 ?= "${RKBIN_BINVERS_RK356x}"
 RKBIN_BINFILE:rk3568 ?= "rk3568_bl31_${RKBIN_BINVERS}.elf"
-RKBIN_DEPLOY_FILENAME:rk3568 ?= "bl31-rk3568.elf"
 
 RKBIN_BINVERS:rk3588s ?= "v1.48"
 RKBIN_BINFILE:rk3588s ?= "rk3588_bl31_${RKBIN_BINVERS}.elf"
-RKBIN_DEPLOY_FILENAME:rk3588s ?= "bl31-rk3588.elf"
diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
index 25ec58c..9ddd54f 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -41,7 +41,7 @@ do_deploy() {
 		bbfatal "Non-empty RKBIN_DEPLOY_FILENAME:<MACHINE> required!"
 	fi
 
-	install -m 644 ${S}/${RKBIN_BINDIR}${RKBIN_BINFILE} ${DEPLOYDIR}/${RKBIN_DEPLOY_FILENAME}
+	install -D -m 644 ${S}/${RKBIN_BINDIR}${RKBIN_BINFILE} ${DEPLOYDIR}/${RKBIN_DEPLOY_FILENAME}
 }
 
 addtask deploy after do_install
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
index 7c94b64..4c7fc3c 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
@@ -47,14 +47,3 @@ fixup_baudrate:rk3588s() {
 # If you use upstream U-Boot with SPL_ATF_NO_PLATFORM_PARAM disabled, you can
 # simply override this function to do nothing.
 do_patch[postfuncs] += "fixup_baudrate"
-
-do_deploy() {
-    :
-}
-do_deploy:rk3328() {
-    cp -rf ${D}/firmware/trusted-firmware-a/bl31.elf ${DEPLOYDIR}/bl31-rk3328.elf
-}
-do_deploy:rk3399() {
-    cp -rf ${D}/firmware/trusted-firmware-a/bl31.elf ${DEPLOYDIR}/bl31-rk3399.elf
-}
-addtask deploy after do_install
diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc b/recipes-bsp/u-boot/u-boot-rockchip.inc
index 2b5bbd7..69aaf03 100644
--- a/recipes-bsp/u-boot/u-boot-rockchip.inc
+++ b/recipes-bsp/u-boot/u-boot-rockchip.inc
@@ -1,6 +1,4 @@
-BL31:rockchip:aarch64 = "${DEPLOY_DIR_IMAGE}/bl31-${SOC_FAMILY}.elf"
-# SOC_FAMILY for RK3588S is rk3588s but it should use the binaries from rk3588
-BL31:rk3588s = "${DEPLOY_DIR_IMAGE}/bl31-rk3588.elf"
+BL31:rockchip:aarch64 = "${DEPLOY_DIR_IMAGE}/trusted-firmware-a/bl31.elf"
 EXTRA_OEMAKE:append:rockchip:aarch64 = " BL31=${BL31}"
 
 TFA_DEPENDS ??= ""

---
base-commit: 2a13a49da4af4487ee71db6aff19364220da694a
change-id: 20260112-tf-a-fix-cd7944bd8441

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


