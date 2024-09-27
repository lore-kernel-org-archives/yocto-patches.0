Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C47CDD1A4
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 12:59:24 +0000 (UTC)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
 by mx.groups.io with SMTP id smtpd.web11.68402.1727441960255820797
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Sep 2024 05:59:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.10, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XFVsf5HL5ztbJ;
	Fri, 27 Sep 2024 14:59:18 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XFVsf2r2Qz4K7;
	Fri, 27 Sep 2024 14:59:18 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 27 Sep 2024 14:59:04 +0200
Subject: [meta-rockchip PATCH 2/2] rk3588(s): add support for upstream TF-A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-rk35-upstream-tf-a-v1-2-e3911342113f@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/684

From: Quentin Schulz <quentin.schulz@cherry.de>

Upstream TF-A > 2.11 (no release available yet) has initial support for
the RK3588 (and thus RK3588S).

This was boot tested on an RK3588 Jaguar, the modified baudrate is taken
into account as well.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3588s.inc                             | 3 +++
 recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index d349108..07cde03 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -19,4 +19,7 @@ PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
 
+TFA_PLATFORM = "rk3588"
+TFA_BUILD_TARGET = "bl31"
+
 ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
index 7e155d7..ecd6cb3 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
@@ -7,6 +7,7 @@ COMPATIBLE_MACHINE:append:rk3328 = "|rk3328"
 COMPATIBLE_MACHINE:append:px30 = "|px30"
 COMPATIBLE_MACHINE:append:rk3566 = "|rk3566"
 COMPATIBLE_MACHINE:append:rk3568 = "|rk3568"
+COMPATIBLE_MACHINE:append:rk3588s = "|rk3588s"
 
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 SRC_URI += "\
@@ -42,6 +43,10 @@ fixup_baudrate:rk3568() {
 	sed -i "s/#define FPGA_BAUDRATE\s\+.*/#define FPGA_BAUDRATE ${RK_CONSOLE_BAUD}/" ${S}/plat/rockchip/rk3568/rk3568_def.h
 }
 
+fixup_baudrate:rk3588s() {
+	sed -i "s/#define RK_DBG_UART_BAUDRATE\s\+.*/#define RK_DBG_UART_BAUDRATE ${RK_CONSOLE_BAUD}/" ${S}/plat/rockchip/rk3588/rk3588_def.h
+}
+
 # Only required for U-Boot configuration for which SPL_ATF_NO_PLATFORM_PARAM
 # symbol is enabled. This symbol is required for TF-A < 2.4-rc0, which is
 # unfortunately what Rockchip is using for their blob.

-- 
2.46.1


