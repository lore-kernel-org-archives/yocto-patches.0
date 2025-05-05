Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAD8C3ABAA
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 14:20:57 +0000 (UTC)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
 by mx.groups.io with SMTP id smtpd.web11.51618.1746454855514731812
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 07:20:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZrkGG1ZgqzBnw;
	Mon,  5 May 2025 16:20:54 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZrkGF5J8jzsQ6;
	Mon,  5 May 2025 16:20:53 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 05 May 2025 16:20:43 +0200
Subject: [meta-rockchip PATCH v3 7/9] bsp: rkbin: tf-a: factor out
 do_deploy to be SoC-agnostic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-ddrbin-custom-v3-7-577b94c72035@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1508

From: Quentin Schulz <quentin.schulz@cherry.de>

The do_deploy task is essentially the same for all SoCs, install a file
from a specific path to another one.

No magic involved, so let's rather have one generic do_deploy task. For
this to work nicely, we check that all necessary variables are set and
notify the developer otherwise. This may be useful whenever a new SoC
will be supported by this recipe.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb | 46 +++++++++++++++++++---------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
index 0ed28a2f18daae280fe38e6939f1b4742b29a778..a515cf8cc01967b0bf23369edebf2061a3c0f877 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
@@ -4,24 +4,42 @@ require rockchip-rkbin.inc
 
 PROVIDES += "trusted-firmware-a"
 
-do_deploy:rk3308() {
-	# Prebuilt TF-A
-	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3308.elf
-}
+RKBIN_BINDIR:rk3308 ?= "bin/rk33/"
+RKBIN_BINVERS:rk3308 ?= "v2.26"
+RKBIN_BINFILE:rk3308 ?= "rk3308_bl31_${RKBIN_BINVERS}.elf"
+RKBIN_DEPLOY_FILENAME:rk3308 ?= "bl31-rk3308.elf"
 
+RKBIN_BINVERS_RK356x ?= "v1.44"
+RKBIN_BINDIR:rk3566 ?= "bin/rk35/"
+RKBIN_BINVERS:rk3566 ?= "${RKBIN_BINVERS_RK356x}"
 # NOTE: the following are not typos
 #       the rk3566 uses the same bl31 as the rk3568
-do_deploy:rk3566() {
-	# Prebuilt TF-A
-	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3566.elf
-}
+RKBIN_BINFILE:rk3566 ?= "rk3568_bl31_${RKBIN_BINVERS}.elf"
+RKBIN_DEPLOY_FILENAME:rk3566 ?= "bl31-rk3566.elf"
 
-do_deploy:rk3568() {
-	# Prebuilt TF-A
-	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3568.elf
-}
+RKBIN_BINDIR:rk3568 ?= "bin/rk35/"
+RKBIN_BINVERS:rk3568 ?= "${RKBIN_BINVERS_RK356x}"
+RKBIN_BINFILE:rk3568 ?= "rk3568_bl31_${RKBIN_BINVERS}.elf"
+RKBIN_DEPLOY_FILENAME:rk3568 ?= "bl31-rk3568.elf"
+
+RKBIN_BINDIR:rk3588s ?= "bin/rk35/"
+RKBIN_BINVERS:rk3588s ?= "v1.47"
+RKBIN_BINFILE:rk3588s ?= "rk3588_bl31_${RKBIN_BINVERS}.elf"
+RKBIN_DEPLOY_FILENAME:rk3588s ?= "bl31-rk3588.elf"
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
 	# Prebuilt TF-A
-	install -m 644 ${S}/bin/rk35/rk3588_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3588.elf
+	install -m 644 ${S}/${RKBIN_BINDIR}${RKBIN_BINFILE} ${DEPLOYDIR}/${RKBIN_DEPLOY_FILENAME}
 }

-- 
2.49.0


