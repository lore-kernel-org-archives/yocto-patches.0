Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001E9C87FCB
	for <webhook@archiver.kernel.org>; Sun,  3 Aug 2025 17:24:48 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web11.304.1754241888492468457
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 03 Aug 2025 10:24:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rV8SGAm4;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e7f9bba93fso62011985a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 03 Aug 2025 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1754241887; x=1754846687; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C73ZcU6rm2HXXkel/94q4F8X+dx0oCtlO3ClhnnWFRc=;
        b=rV8SGAm4XkL2jfasf+ErTb7gdLajOW/EriW/sfhXe7ZjVpS1KFsYFNkUQ45IIlwRJY
         12ZliUwGZasFXxQ9bGWdsK7gI6Ri84CD3VgSjJPe9IWbl3osOCb/TnugSc8632mavCVY
         6Ya3rVHrnMZZsnElheOvB5RXoX38OLL3MMeFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754241887; x=1754846687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C73ZcU6rm2HXXkel/94q4F8X+dx0oCtlO3ClhnnWFRc=;
        b=pMX+xO/pQ14GiXVEx7HuXOFLke0REH9XhASrymp83VKGktGKKe1X4rMf5AVypEQj8/
         La6BnqrcfYmyuoquo8dkXTgoAZ3+M/vxBofKAkTBnju5eNwPjVh15rg1/kTq9nxcnnik
         0lkzYlCjMSUpQTnG8RleofzsOyK3cy30/PZJDc6XPMJNxplTz2YbllHFfHdgHYO+8eZg
         EH3oc8RY2Bwk51wb2Ac9plWOqpji0X+rBZA53CRxXEylq7ilqzllGgIp1vVsU8joU3Kn
         2T9ZqvK1nMwXygUUB45zSezTlOE6KdOjTESraR5x8D+zaZPmdbBhnjIQ3zNkAie8r0+T
         hr8g==
X-Gm-Message-State: AOJu0YwLfRS9hYcJy3i7xQO9aBA5uIrxuwx/frbtYcb4i3xDmMhux5k7
	2HyvHZRli6Got2P5z5FSvgD5/HkWeAGeZeCgRon+qFFNAIxX34RtjKAazJ1Tl5fgFg8yjDLPduw
	Nq2ta
X-Gm-Gg: ASbGncsZwjS4MztfgRVYeCRmBQKAB639T7V6NBlnO8W5Z/wdtaRxhALFZNKbxHuY75s
	crJNmioJ2uN2GmfV3pNn1WuPVqslmZs2nAScnWJZJoSwJl4T5ROnxWAfIcDbtcfh/Ixe5nScgah
	5rB/n2lSNxKtnzz3rMO0rGUHGzF3ke/Ar1VEFJPtsjmB7emNvAebEEMlkmTLa9+RyCAuzgP10Jo
	1ZtFaE22Uk1rThMPDT3FUtZSXj1PGglIK0koAjFlTXbydxEi7z6qwZoz3SeAl2uVnWAd+atvh1h
	IF/H8pcQEj6MwjKRew6brzkiX1o3ixtRfgCTf0zLETtftSr1sylsvgPQ+lcPwq6IiwuvfxhlgHi
	aDJJth5nKm3lXX2WQ9cE+vB5Ez0SEGrW9RsO60I4Iwl1uptvUKeak1UVOqiVeikDTECpM0cSDMw
	==
X-Google-Smtp-Source: AGHT+IH0ivb9wLdS3M/oBPlO3muPsSra6fzAckXJCCQEGKJ3aV42Yq5Pc2pnM/SYAQrQoGkf6toZzg==
X-Received: by 2002:ae9:e50c:0:b0:7e3:2c8e:a22d with SMTP id af79cd13be357-7e69627b09fmr922504685a.13.1754241887220;
        Sun, 03 Aug 2025 10:24:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f7064b0sm454847785a.54.2025.08.03.10.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 10:24:46 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com
Subject: [meta-rockchip][PATCH] nanopc-t6: add
Date: Sun,  3 Aug 2025 13:24:32 -0400
Message-ID: <20250803172432.1341178-1-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 03 Aug 2025 17:24:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1882

The FriendlyElec NanoPC-T6 is a one-for-all high performance open
source platform for edge computing, designed and developed by the
FriendlyElec team.

Website:
    https://www.friendlyelec.com/index.php?route=product/product&path=69&product_id=292

Wiki:
    https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T6

Specs:
- Rockchip RK3588 (4x ARM Cortex-A76 + 4x Cortex-A55)
- ARM Mali-G610 MP4 (OpenGLES 1.1, 2.0, and 3.2, OpenCL up to 2.2 and Vulkan 1.2)
- 4GB/8GB/16GB LPDDR4X
- µSD
- 32GB/64GB/256GB eMMC
- 32MB SPI NOR Flash
- 2x PCIe 2.5G Ethernet
- 1x USB 3.0 Type A, 1x USB Type C
- 2x USB 2.0 Type A (LTS model)
- 1x HDMI (4Kp60) in
- 2x HDMI (HDMI2.1, HDMI2.0, and HDMI1.4, 1x 8Kp60, 1x 4Kp60) out
- 2x 4-lane MIPI-CSI
- 2x 4-lane MIPI-DSI
- 1x M.2 M-Key connector with PCIe 3.0 x4
- 1x M.2 E-key connector with PCIe 2.1 x1 and USB2.0 Host
- 1x Mini PCIe for 3G/4G module (non-LTS model)
- 40-pin 2.54mm header (up to 2x SPIs, 6x UARTs, 1x I2Cs, 8x PWMs, 2x I2Ss, 28x GPIO)
- 110 x 80 mm

Upstream kernel support for the T6 has matured enough to be usable, so
add a machine configuration to allow people to migrate off of the older
bits in the Rockchip BSP layer.  Note that there are two variants of
the board, original and a newer "LTS" version that drops the MiniPCIe
slot for a modem for two extra USB 2.0 ports and adds a USB-C connector
for the debug UART.  Devicetrees for both are shipped.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/machine/nanopc-t6.conf                   | 15 +++++++++++++++
 recipes-kernel/linux/linux-yocto-dev.bbappend |  2 ++
 2 files changed, 17 insertions(+)
 create mode 100644 conf/machine/nanopc-t6.conf

diff --git a/conf/machine/nanopc-t6.conf b/conf/machine/nanopc-t6.conf
new file mode 100644
index 0000000..5ed413d
--- /dev/null
+++ b/conf/machine/nanopc-t6.conf
@@ -0,0 +1,15 @@
+#@TYPE: Machine
+#@NAME: NanoPC-T6
+#@DESCRIPTION: NanoPC-T6 from FriendlyElec
+#https://www.friendlyelec.com/index.php?route=product/product&path=69&product_id=292
+
+require conf/machine/include/rk3588.inc
+
+PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-dev"
+KERNEL_DEVICETREE = " \
+    rockchip/rk3588-nanopc-t6.dtb \
+    rockchip/rk3588-nanopc-t6-lts.dtb \
+"
+MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
+
+UBOOT_MACHINE = "nanopc-t6-rk3588_defconfig"
diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
index f738d13..f49768b 100644
--- a/recipes-kernel/linux/linux-yocto-dev.bbappend
+++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
@@ -2,6 +2,8 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
 COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
 COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
+COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
 
 SRC_URI:append:orangepi-5-plus = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
 SRC_URI:append:radxa-zero-3 = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
+SRC_URI:append:nanopc-t6 = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
-- 
2.50.1


