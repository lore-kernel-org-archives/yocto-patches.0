Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15C2C3ABBB
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 14:20:57 +0000 (UTC)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
 by mx.groups.io with SMTP id smtpd.web10.51248.1746454855189247529
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 07:20:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZrkGF51Gtz8jw;
	Mon,  5 May 2025 16:20:53 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZrkGD60NSzs2F;
	Mon,  5 May 2025 16:20:52 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 05 May 2025 16:20:42 +0200
Subject: [meta-rockchip PATCH v3 6/9] bsp: rkbin: optee-os: factor out
 do_deploy to be SoC-agnostic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-ddrbin-custom-v3-6-577b94c72035@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1507

From: Quentin Schulz <quentin.schulz@cherry.de>

The do_deploy task is essentially the same for all SoCs, install a file
from a specific path to another one.

No magic involved, so let's rather have one generic do_deploy task. For
this to work nicely, we check that all necessary variables are set and
notify the developer otherwise. This may be useful whenever a new SoC
will be supported by this recipe.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb | 46 ++++++++++++++++--------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
index 6d25368d3392c29438d5ff34c621552633885f1b..7858688b23679d67df5ac2739312ef83b677af6b 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
@@ -4,24 +4,42 @@ require rockchip-rkbin.inc
 
 PROVIDES += "optee-os"
 
-do_deploy:rk3308() {
-	# Prebuilt OPTEE-OS
-	install -m 644 ${S}/bin/rk33/rk3308_bl32_v*.bin ${DEPLOYDIR}/tee-rk3308.bin
-}
+RKBIN_BINDIR:rk3308 ?= "bin/rk33/"
+RKBIN_BINVERS:rk3308 ?= "v2.08"
+RKBIN_BINFILE:rk3308 ?= "rk3308_bl32_${RKBIN_BINVERS}.bin"
+RKBIN_DEPLOY_FILENAME:rk3308 ?= "tee-rk3308.bin"
 
+RKBIN_BINVERS_RK356x ?= "v2.14"
+RKBIN_BINDIR:rk3566 ?= "bin/rk35/"
+RKBIN_BINVERS:rk3566 ?= "${RKBIN_BINVERS_RK356x}"
 # NOTE: the following are not typos
 #       the rk3566 uses the same bl32 as the rk3568
-do_deploy:rk3566() {
-	# Prebuilt OPTEE-OS
-	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3566.bin
-}
+RKBIN_BINFILE:rk3566 ?= "rk3568_bl32_${RKBIN_BINVERS}.bin"
+RKBIN_DEPLOY_FILENAME:rk3566 ?= "tee-rk3566.bin"
 
-do_deploy:rk3568() {
-	# Prebuilt OPTEE-OS
-	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3568.bin
-}
+RKBIN_BINDIR:rk3568 ?= "bin/rk35/"
+RKBIN_BINVERS:rk3568 ?= "${RKBIN_BINVERS_RK356x}"
+RKBIN_BINFILE:rk3568 ?= "rk3568_bl32_${RKBIN_BINVERS}.bin"
+RKBIN_DEPLOY_FILENAME:rk3568 ?= "tee-rk3568.bin"
+
+RKBIN_BINDIR:rk3588s ?= "bin/rk35/"
+RKBIN_BINVERS:rk3588s ?= "v1.17"
+RKBIN_BINFILE:rk3588s ?= "rk3588_bl32_${RKBIN_BINVERS}.bin"
+RKBIN_DEPLOY_FILENAME:rk3588s ?= "tee-rk3588.bin"
+
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
 
-do_deploy:rk3588s() {
 	# Prebuilt OPTEE-OS
-	install -m 644 ${S}/bin/rk35/rk3588_bl32_v*.bin ${DEPLOYDIR}/tee-rk3588.bin
+	install -m 644 ${S}/${RKBIN_BINDIR}${RKBIN_BINFILE} ${DEPLOYDIR}/${RKBIN_DEPLOY_FILENAME}
 }

-- 
2.49.0


