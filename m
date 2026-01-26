Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F1D13C27
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 14:48:57 +0000 (UTC)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21689.1769438927377993933
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 06:48:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.170, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f0BHd59HLzbP0;
	Mon, 26 Jan 2026 15:48:45 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f0BHd2BKvzrt5;
	Mon, 26 Jan 2026 15:48:45 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 26 Jan 2026 15:48:29 +0100
Subject: [PATCH meta-rockchip 1/2] bsp: rkbin: optee-os: sync destination
 and name with upstream OP-TEE OS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-optee-os-v1-1-874261a77dad@cherry.de>
References: <20260126-optee-os-v1-0-874261a77dad@cherry.de>
In-Reply-To: <20260126-optee-os-v1-0-874261a77dad@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 14:48:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3083

From: Quentin Schulz <quentin.schulz@cherry.de>

Upstream OP-TEE OS deploys a tee.bin (and other binaries) to an optee
subdirectory in the DEPLOY_DIR_IMAGE.

Let's make sure we align with the same name and location for rkbin blob.

Since this now deploys in a subdirectory, we need to make sure it is
created first, by adding -D to the install command.

Note that this hasn't been tested at all. The only combination I've ever
done is upstream U-Boot + upstream TF-A + upstream OP-TEE OS. But if it
works, this commit will make it possible to interchange OP-TEE OS blob
with OP-TEE OS upstream transparently for U-Boot recipe (OP-TEE OS
support will be added in the next commit) by making sure the names
match.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rk3308-rkbin_git.bb            | 2 +-
 recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb | 8 ++++----
 recipes-bsp/rkbin/rockchip-rkbin.inc             | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/recipes-bsp/rkbin/rk3308-rkbin_git.bb b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
index ab2c70f..7e816d7 100644
--- a/recipes-bsp/rkbin/rk3308-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
@@ -30,7 +30,7 @@ do_deploy:rk3308() {
 	# Prebuilt TF-A
 	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3308.elf
 	# Prebuilt OPTEE-OS
-	install -m 644 ${S}/bin/rk33/rk3308_bl32_v*.bin ${DEPLOYDIR}/tee-rk3308.bin
+	install -D -m 644 ${S}/bin/rk33/rk3308_bl32_v*.bin ${DEPLOYDIR}/optee/tee.bin
 	# Prebuilt U-Boot TPL (DDR init)
 	install -m 644 ${S}/bin/rk33/rk3308_ddr_589MHz_uart0_m0_v*.bin ${DEPLOYDIR}/ddr-rk3308.bin
 }
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
index 0f3c927..372307d 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
@@ -4,21 +4,21 @@ require rockchip-rkbin.inc
 
 PROVIDES += "optee-os"
 
+# Must match the naming and path used in
+# meta-arm/recipes-security/optee/optee-os.inc
+RKBIN_DEPLOY_FILENAME = "optee/tee.bin"
+
 RKBIN_BINVERS:rk3308 ?= "v2.09"
 RKBIN_BINFILE:rk3308 ?= "rk3308_bl32_${RKBIN_BINVERS}.bin"
-RKBIN_DEPLOY_FILENAME:rk3308 ?= "tee-rk3308.bin"
 
 RKBIN_BINVERS_RK356x ?= "v2.15"
 RKBIN_BINVERS:rk3566 ?= "${RKBIN_BINVERS_RK356x}"
 # NOTE: the following are not typos
 #       the rk3566 uses the same bl32 as the rk3568
 RKBIN_BINFILE:rk3566 ?= "rk3568_bl32_${RKBIN_BINVERS}.bin"
-RKBIN_DEPLOY_FILENAME:rk3566 ?= "tee-rk3566.bin"
 
 RKBIN_BINVERS:rk3568 ?= "${RKBIN_BINVERS_RK356x}"
 RKBIN_BINFILE:rk3568 ?= "rk3568_bl32_${RKBIN_BINVERS}.bin"
-RKBIN_DEPLOY_FILENAME:rk3568 ?= "tee-rk3568.bin"
 
 RKBIN_BINVERS:rk3588s ?= "v1.19"
 RKBIN_BINFILE:rk3588s ?= "rk3588_bl32_${RKBIN_BINVERS}.bin"
-RKBIN_DEPLOY_FILENAME:rk3588s ?= "tee-rk3588.bin"
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

-- 
2.52.0


