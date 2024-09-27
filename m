Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75573CDD1A8
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 12:59:24 +0000 (UTC)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
 by mx.groups.io with SMTP id smtpd.web10.68250.1727441959840083087
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Sep 2024 05:59:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XFVsf2xtfzr0c;
	Fri, 27 Sep 2024 14:59:18 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XFVsf0cyPz3P4;
	Fri, 27 Sep 2024 14:59:18 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 27 Sep 2024 14:59:03 +0200
Subject: [meta-rockchip PATCH 1/2] rk356x: add support for upstream TF-A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-rk35-upstream-tf-a-v1-1-e3911342113f@cherry.de>
References: <20240927-rk35-upstream-tf-a-v1-0-e3911342113f@cherry.de>
In-Reply-To: <20240927-rk35-upstream-tf-a-v1-0-e3911342113f@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Sep 2024 12:59:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/683

From: Quentin Schulz <quentin.schulz@cherry.de>

Upstream TF-A > 2.11 (no release available yet) has initial support for
the RK3566 and RK3568. They both share the same code base.

This was not tested as I do not own RK356x boards.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3566.inc                        |  3 +++
 conf/machine/include/rk3568.inc                        |  3 +++
 .../trusted-firmware-a/trusted-firmware-a_%.bbappend   | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
index 2522851..9454dba 100644
--- a/conf/machine/include/rk3566.inc
+++ b/conf/machine/include/rk3566.inc
@@ -20,4 +20,7 @@ PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
 
+TFA_PLATFORM = "rk3568"
+TFA_BUILD_TARGET = "bl31"
+
 ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
index db188a3..a29546c 100644
--- a/conf/machine/include/rk3568.inc
+++ b/conf/machine/include/rk3568.inc
@@ -20,4 +20,7 @@ PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
 
+TFA_PLATFORM = "rk3568"
+TFA_BUILD_TARGET = "bl31"
+
 ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
index c9ad84c..7e155d7 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
@@ -5,6 +5,8 @@ DEPENDS:append:rk3399 = " gcc-arm-none-eabi-native"
 COMPATIBLE_MACHINE:append:rk3399 = "|rk3399"
 COMPATIBLE_MACHINE:append:rk3328 = "|rk3328"
 COMPATIBLE_MACHINE:append:px30 = "|px30"
+COMPATIBLE_MACHINE:append:rk3566 = "|rk3566"
+COMPATIBLE_MACHINE:append:rk3568 = "|rk3568"
 
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 SRC_URI += "\
@@ -31,4 +33,20 @@ fixup_baudrate:px30() {
 	sed -i "s/#define PX30_BAUDRATE\s\+.*/#define PX30_BAUDRATE ${RK_CONSOLE_BAUD}/" ${S}/plat/rockchip/px30/px30_def.h
 }
 
+# This is not a typo, rk3566 and rk3568 are supported by the same code base.
+fixup_baudrate:rk3566() {
+	sed -i "s/#define FPGA_BAUDRATE\s\+.*/#define FPGA_BAUDRATE ${RK_CONSOLE_BAUD}/" ${S}/plat/rockchip/rk3568/rk3568_def.h
+}
+
+fixup_baudrate:rk3568() {
+	sed -i "s/#define FPGA_BAUDRATE\s\+.*/#define FPGA_BAUDRATE ${RK_CONSOLE_BAUD}/" ${S}/plat/rockchip/rk3568/rk3568_def.h
+}
+
+# Only required for U-Boot configuration for which SPL_ATF_NO_PLATFORM_PARAM
+# symbol is enabled. This symbol is required for TF-A < 2.4-rc0, which is
+# unfortunately what Rockchip is using for their blob.
+# With upstream TF-A and SPL_ATF_NO_PLATFORM_PARAM disabled in U-Boot, TF-A will
+# get which console to use and at which baudrate from U-Boot directly.
+# If you use upstream U-Boot with SPL_ATF_NO_PLATFORM_PARAM disabled, you can
+# simply override this function to do nothing.
 do_patch[postfuncs] += "fixup_baudrate"

-- 
2.46.1


