Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE61D6911F
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 15:59:08 +0000 (UTC)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
 by mx.groups.io with SMTP id smtpd.web11.98583.1732809538218448083
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Nov 2024 07:58:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.15, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XzgwJ4Sn5zYfk;
	Thu, 28 Nov 2024 16:58:56 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XzgwJ27JDzTt1;
	Thu, 28 Nov 2024 16:58:56 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 28 Nov 2024 16:58:50 +0100
Subject: [meta-rockchip PATCH v2 2/2] bsp: rkbin: bump to latest commit in
 master branch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-rkbin-bump-v2-2-a194385aad7a@cherry.de>
References: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
In-Reply-To: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Nov 2024 15:59:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/858

From: Quentin Schulz <quentin.schulz@cherry.de>

This seems to be fixing random RCU stalls, system hangs or resets while
running upstream Linux kernel on RK3588 boards.

License-Update: Fixing typos c.f. 385bf9f1700c ("license: typo fix")

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 8 ++++----
 recipes-bsp/rkbin/rockchip-rkbin.inc        | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
index a5cba9a61f3226def00bd8ab0a777d79ac5de3a1..3227a53db22ba5906355e6925399aafe08813c9f 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
@@ -2,7 +2,7 @@ DESCRIPTION = "Rockchip Firmware for DDR init (TPL in U-Boot terms)"
 
 require rockchip-rkbin.inc
 
-DDRBIN_VERS:rk3308 ?= "v2.07"
+DDRBIN_VERS:rk3308 ?= "v2.10"
 DDRBIN_FILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${DDRBIN_VERS}.bin"
 
 do_deploy:rk3308() {
@@ -10,7 +10,7 @@ do_deploy:rk3308() {
 	install -m 644 ${S}/bin/rk33/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin
 }
 
-DDRBIN_VERS:rk3566 ?= "v1.21"
+DDRBIN_VERS:rk3566 ?= "v1.23"
 DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
 
 do_deploy:rk3566() {
@@ -18,7 +18,7 @@ do_deploy:rk3566() {
 	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3566.bin
 }
 
-DDRBIN_VERS:rk3568 ?= "v1.21"
+DDRBIN_VERS:rk3568 ?= "v1.23"
 DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
 
 do_deploy:rk3568() {
@@ -26,7 +26,7 @@ do_deploy:rk3568() {
 	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3568.bin
 }
 
-DDRBIN_VERS:rk3588s ?= "v1.16"
+DDRBIN_VERS:rk3588s ?= "v1.18"
 DDRBIN_FILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VERS}.bin"
 
 do_deploy:rk3588s() {
diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
index d70a5551c8171188af93dddf4b3b1dc960f27a83..9264db9048e31b7dae650bdc8e31009f7f4cf404 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -1,7 +1,7 @@
 SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
-SRCREV = "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
+SRCREV = "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
 LICENSE = "Proprietary"
-LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
 
 inherit bin_package deploy
 

-- 
2.47.0


