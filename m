Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40019.1795606020998158277
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 03:27:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=FxQOQlTK;
 spf=pass (domain: gmail.com, ip: 74.125.82.178, mailfrom: deepakdas.linux@gmail.com)
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3866a784546so7523979eec.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 03:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795606020; x=1796210820; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8bwX6uTYMqV/YinmWFg2qxMOQR9QiGwz5PXugtWkIp4=;
        b=FxQOQlTKPELnXtbUl6EvSOtxzBvi/r4zw+SWR82ExembDxZ4Q9ETUSxdiAUZoCdswo
         Aucbn9bhaYVZ7q661BdZzaBSTBSh2RvYPTJMcMIQyKuP8/C9DfY5Ci2th0gHIiqMvSYT
         54mobfggIxOjRK2rU8lA8OihGr/CY5JzxGinnGU46SuBxdI3Eulyp0OKSa9cXgm8LkGQ
         F1CuCZxifByyCsdHO7xBJW/M3z4O7luuOTFYGDXAPvncUxhlE4a1VYFLRdbYKGfD8CNX
         fGOQR1LdP9g7xzqioZm41GzbFcxtmcywFqYF1bZGl7DtKVjMIXBkgUcYKGmdUKW4k2n8
         DKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606020; x=1796210820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8bwX6uTYMqV/YinmWFg2qxMOQR9QiGwz5PXugtWkIp4=;
        b=LW2e415s5NeuFsHa94rxTZkQE/UH5V1zFxJqu1rWYcwbUs82QIIaKLFDB0YMWt2hIk
         eTGG0DhUnKnFZhRok/8VA3S808Z65RQ+798thSD4Rb2c5ayOu/+z0GQbXWke2SxptwVc
         rboRBXVpzpbHyheBG0oSg/9anS+m7nagwtA1ugF7h8FhGPCz1TTZY3l5RrUEsoLRMlyQ
         wMmLgywbBXkgEUGqvUaTOmFXtw5JMYpwNB5+3kL3WEnDJbqROz+9X98avYDT8f3s9Vrs
         ujHE5koeJ4dDAQltS9w8I4sYCeB6H36bC/+0l/zfDyFYYdV4BNdjqFJ+OEhuG0XuxWOw
         WRLA==
X-Gm-Message-State: APuU4Z8qNmEL/KjkRsDV/56yzu0M8eqKhNxIxShdviEG9YHWpfbcTG9S
	8+0poqc+a4IUv2a3Ip0qHbcP6xwMOwa/lkQnB5El32tuPZBp7noJsRINYo4JGtrL
X-Gm-Gg: AZFdTZf6GkFsR3lHbxjPVAQ/4uK2/+LkRZA0y/3hfH70RofFMgFObxruMFj2VS5np0s
	5sB3TJD7pMjGKXdwCXKI06llZ9TEHj8bAiqTsbPMEiSO3nXdQmPR8kksTKm/OF7FhPoqkR2EKSZ
	8+zS4WIFuMxlHjtQmyumoa8TNrp1FxO8XOIoHgmtD7Y9HMV0HK7A6CiJvokjgHGrF+Wgj5qUXYA
	wRK8VVokfUKx5pi7POcCJHjo/kNL6z8O0F/KNr222OmhMPNKZspmAt/WHJycbu4iYFs+5t/HGI8
	L25HlCHTsJeDjVkubZInG323ZxXxE/HOcWyeZPU5iI/f4cyY77SD7C65DiboHZfu5c5z6SzTEgi
	3ifzVvGnDGHaVUtUvv6qdlPDimSXLDEWc3Rm189Pq8KA2N5HUxwood4Vw4bWx6pIogWtqebfVfh
	boISWG/2ax1oWVQFcfBIbtmBIPRiWHDYuoPX/NIJzUgY41701INWjTG8kFqWnqG9fqJFRyReFvy
	LL0PpeVelyFEE643EecthGMNGsLWhxn7a3ETQ78Aw8WViIk6KxN6PYIdtzpyoIDYBCjRnIL2fTK
	ke2EJPBqG+msyaRWeMBu3ICQIt19k57RiSnIOUFK3dEXi7qHRDAa3BSIkw==
X-Received: by 2002:a05:7301:730c:b0:381:2114:99d0 with SMTP id 5a478bee46e88-38571415bdemr17022438eec.39.1795606020222;
        Wed, 25 Nov 2026 03:27:00 -0800 (PST)
Return-Path: <deepakdas.linux@gmail.com>
Received: from ddas-VirtualBox.. ([49.36.144.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm47695535eec.20.2026.11.25.03.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:59 -0800 (PST)
From: Deepak Das <deepakdas.linux@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: quentin.schulz@cherry.de,
	twoerner@gmail.com,
	Deepak Das <deepakdas.linux@gmail.com>
Subject: [meta-rockchip][PATCH v2] nanopc-t4: add
Date: Wed, 25 Nov 2026 16:56:31 +0530
Message-ID: <20261125112632.3177-1-deepakdas.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124052240.1121147-1-deepakdas.linux@gmail.com>
References: <20261124052240.1121147-1-deepakdas.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 11:27:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5514
Content-Type: text/plain; charset="utf-8"

The FriendlyElec NanoPC-T4 is an RK3399 SBC with 4GB LPDDR3 RAM and
16GB onboard eMMC.

Documentation page:
https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T4

Specs:
- Rockchip RK3399
- Dual-Core Arm Cortex-A72 + Quad-Core Arm Cortex-A53
- Arm Mali T860MP4 GPU
- 4GB LPDDR3 RAM
- 16GB eMMC
- 1x Micro SD Card Slot
- 1x M.2 M-Key (4-lane PCIe 2.1)
- 1x Gigabit Ethernet
- 802.11ac WiFi and Bluetooth
- 1x USB3 Type-C, 2x USB3 HOST, 1x USB2 HOST
- 1x HDMI 2.0, 1x eDP, 1x MIPI DSI, 2x MIPI CSI
- 40-pin GPIO header
- Debug UART at 1500000 baud
- 12V DC input

Upstream U-Boot (nanopc-t4-rk3399_defconfig) and the upstream kernel
device tree (rk3399-nanopc-t4.dts) are used.

Tested by building core-image-base on master and booting the wic
image from the SD card to a login prompt.

AI-Generated: Claude Code, Opus 5.5
Signed-off-by: Deepak Das <deepakdas.linux@gmail.com>
---
Changes in v2:
- add MACHINE_EXTRA_RRECOMMENDS += "kernel-modules", like the other
  RK3399 machines; Ethernet (dwmac-rk), PCIe and brcmfmac are modules
  in defconfig (Quentin)
- re-tested: core-image-base built and booted on master

 README                                  |  1 +
 conf/machine/nanopc-t4.conf             | 12 ++++++++++++
 recipes-kernel/linux/linux-rockchip.inc |  1 +
 3 files changed, 14 insertions(+)
 create mode 100644 conf/machine/nanopc-t4.conf

diff --git a/README b/README
index c2697d1..3d8c568 100644
--- a/README
+++ b/README
@@ -25,6 +25,7 @@ Status of supported boards:
 			vyasa-rk3288
 
 		64-bit:
+			nanopc-t4
 			nanopc-t6
 			nanopi-m4
 			nanopi-m4-2gb
diff --git a/conf/machine/nanopc-t4.conf b/conf/machine/nanopc-t4.conf
new file mode 100644
index 0000000..5560a6e
--- /dev/null
+++ b/conf/machine/nanopc-t4.conf
@@ -0,0 +1,12 @@
+#@TYPE: Machine
+#@NAME: NanoPC-T4
+#@DESCRIPTION: NanoPC-T4 RK3399 board from FriendlyElec, 4GB LPDDR3
+#https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T4
+
+require conf/machine/include/rk3399.inc
+
+MACHINE_FEATURES += "usbhost serial"
+MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
+
+KERNEL_DEVICETREE = "rockchip/rk3399-nanopc-t4.dtb"
+UBOOT_MACHINE = "nanopc-t4-rk3399_defconfig"
diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
index b87cb7a..7ca12b1 100644
--- a/recipes-kernel/linux/linux-rockchip.inc
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -10,6 +10,7 @@ COMPATIBLE_MACHINE:tinker-board-s = "tinker-board-s"
 COMPATIBLE_MACHINE:vyasa-rk3288 = "vyasa-rk3288"
 
 # 64-bit devices
+COMPATIBLE_MACHINE:nanopc-t4 = "nanopc-t4"
 COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
 COMPATIBLE_MACHINE:nanopi-m4 = "nanopi-m4"
 COMPATIBLE_MACHINE:nanopi-m4-2gb = "nanopi-m4-2gb"
-- 
2.43.0

