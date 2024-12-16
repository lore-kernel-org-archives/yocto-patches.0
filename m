Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E73E7717F
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 13:40:40 +0000 (UTC)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
 by mx.groups.io with SMTP id smtpd.web11.56572.1734356432157660532
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Dec 2024 05:40:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.169, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YBh0G1NYPzrbP;
	Mon, 16 Dec 2024 14:40:30 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YBh0F5HMVzPtF;
	Mon, 16 Dec 2024 14:40:29 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 16 Dec 2024 14:39:49 +0100
Subject: [meta-rockchip PATCH scarthgap 3/3] bsp: rkbin: bump to latest
 commit in master branch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-rkbin-bump-scarthgap-v1-3-9057e03351ad@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/930

From: Quentin Schulz <quentin.schulz@cherry.de>

This seems to be fixing random RCU stalls, system hangs or resets while
running upstream Linux kernel on RK3588 boards.

License-Update: Fixing typos c.f. 385bf9f1700c ("license: typo fix")

Before and after run-tested on:
	rk3308  rock-pi-s (with and without RKBIN_RK3308_LATEST)
	rk3566  radxa-zero-3e
	rk3568  rock-3a
	rk3588  rock-5a
	rk3588s rock-5b

Run-tested-by: Trevor Woerner <twoerner@gmail.com>

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
(cherry picked from commit 80d4039b1b275471148e83627df25700fd6758bd)
[apply to rockchip-rkbin_git.bb instead of rockchip-rkbin.inc]
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin_git.bb | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
index f13c134604a10384793c92632e150eb0aaa4cd8e..e555dcdac355ca862e6421b5b26f2f7c5c92ee14 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
@@ -1,9 +1,9 @@
 DESCRIPTION = "Rockchip Firmware and Tool Binaries"
 LICENSE = "Proprietary"
-LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
 
 SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
-SRCREV = "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
+SRCREV = "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
 
 PROVIDES += "trusted-firmware-a"
 PROVIDES += "optee-os"
@@ -30,7 +30,7 @@ do_install() {
 PACKAGES = "${PN}"
 ALLOW_EMPTY:${PN} = "1"
 
-DDRBIN_VERS:rk3308 ?= "v2.07"
+DDRBIN_VERS:rk3308 ?= "v2.10"
 DDRBIN_FILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${DDRBIN_VERS}.bin"
 
 do_deploy:rk3308() {
@@ -42,7 +42,7 @@ do_deploy:rk3308() {
 	install -m 644 ${S}/bin/rk33/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin
 }
 
-DDRBIN_VERS:rk3566 ?= "v1.21"
+DDRBIN_VERS:rk3566 ?= "v1.23"
 DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
 
 # NOTE: the following are not typos
@@ -56,7 +56,7 @@ do_deploy:rk3566() {
 	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3566.bin
 }
 
-DDRBIN_VERS:rk3568 ?= "v1.21"
+DDRBIN_VERS:rk3568 ?= "v1.23"
 DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
 
 do_deploy:rk3568() {
@@ -68,7 +68,7 @@ do_deploy:rk3568() {
 	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3568.bin
 }
 
-DDRBIN_VERS:rk3588s ?= "v1.16"
+DDRBIN_VERS:rk3588s ?= "v1.18"
 DDRBIN_FILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VERS}.bin"
 
 do_deploy:rk3588s() {

-- 
2.47.1


