Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BAFC3ABB8
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 14:20:57 +0000 (UTC)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
 by mx.groups.io with SMTP id smtpd.web10.51251.1746454856773703828
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 07:20:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZrkGH3YxNzDVS;
	Mon,  5 May 2025 16:20:55 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZrkGG6zdmzslT;
	Mon,  5 May 2025 16:20:54 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 05 May 2025 16:20:45 +0200
Subject: [meta-rockchip PATCH v3 9/9] bsp: rkbin: bump to latest commit in
 master branch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-ddrbin-custom-v3-9-577b94c72035@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1510

From: Quentin Schulz <quentin.schulz@cherry.de>

This bumps rkbin to be using the last public blobs.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb | 6 +++---
 recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb     | 2 +-
 recipes-bsp/rkbin/rockchip-rkbin.inc             | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
index b534e6359645cd7082c9ac69036de15ce8813b3a..0f3c9277a61ec9798f78107fb2f402b8a792f81d 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
@@ -4,11 +4,11 @@ require rockchip-rkbin.inc
 
 PROVIDES += "optee-os"
 
-RKBIN_BINVERS:rk3308 ?= "v2.08"
+RKBIN_BINVERS:rk3308 ?= "v2.09"
 RKBIN_BINFILE:rk3308 ?= "rk3308_bl32_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3308 ?= "tee-rk3308.bin"
 
-RKBIN_BINVERS_RK356x ?= "v2.14"
+RKBIN_BINVERS_RK356x ?= "v2.15"
 RKBIN_BINVERS:rk3566 ?= "${RKBIN_BINVERS_RK356x}"
 # NOTE: the following are not typos
 #       the rk3566 uses the same bl32 as the rk3568
@@ -19,6 +19,6 @@ RKBIN_BINVERS:rk3568 ?= "${RKBIN_BINVERS_RK356x}"
 RKBIN_BINFILE:rk3568 ?= "rk3568_bl32_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3568 ?= "tee-rk3568.bin"
 
-RKBIN_BINVERS:rk3588s ?= "v1.17"
+RKBIN_BINVERS:rk3588s ?= "v1.19"
 RKBIN_BINFILE:rk3588s ?= "rk3588_bl32_${RKBIN_BINVERS}.bin"
 RKBIN_DEPLOY_FILENAME:rk3588s ?= "tee-rk3588.bin"
diff --git a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
index 3ad0f7cffa077cfbc88b08a319c181e8a8c5a7c1..f51d9e934ab52b5ee7f356e7c3c5120513c2f0f1 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
@@ -19,6 +19,6 @@ RKBIN_BINVERS:rk3568 ?= "${RKBIN_BINVERS_RK356x}"
 RKBIN_BINFILE:rk3568 ?= "rk3568_bl31_${RKBIN_BINVERS}.elf"
 RKBIN_DEPLOY_FILENAME:rk3568 ?= "bl31-rk3568.elf"
 
-RKBIN_BINVERS:rk3588s ?= "v1.47"
+RKBIN_BINVERS:rk3588s ?= "v1.48"
 RKBIN_BINFILE:rk3588s ?= "rk3588_bl31_${RKBIN_BINVERS}.elf"
 RKBIN_DEPLOY_FILENAME:rk3588s ?= "bl31-rk3588.elf"
diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
index 8a6a9f44ce908934dd58fc3c37d338a43aa00bff..79149c5bebc3c59e337b303f24274ed1925da5ce 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -1,5 +1,5 @@
 SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
-SRCREV = "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
+SRCREV = "f43a462e7a1429a9d407ae52b4745033034a6cf9"
 LICENSE = "Proprietary"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
 

-- 
2.49.0


