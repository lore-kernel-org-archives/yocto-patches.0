Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6137EC5B543
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 17:22:59 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web11.988.1748625769457783712
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 May 2025 10:22:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q7uCsqrA;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fab467aad1so27196556d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 30 May 2025 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748625768; x=1749230568; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2+I8ddCiFjrB8xJs9w+tqJSvPLrU6OzWs2betag0YA=;
        b=Q7uCsqrAmraYDDgfEcOgySAZNk1qBH7iQ1sbTUMdwTODUn/u2JBtAhW755vSoJHaVl
         Bi/IDRNqzHrBMa8c6ZW2RJP6EwIxPb8VPIAHOqUUVBum7m1H2OvZTeqaDdDpsqv8JSjD
         OcOOhqAfalXLJyoqOo9UQp+R+NXMAmgFFVGz4phC1PX5ITFBW5iiDZ/dbb2bCmcsR4Gy
         V4dojbk/19EjvjUkkPlmJbc0JmlKUWyS4R7q4M0DJ2NBktcTtMOUQXGTlyqdncxt4f3j
         7EgvSmeUncF4wBjzXtAvOZNra1mjRoxhEHs2uxi7AGlrMRygDbjC+BLL//1Soe65pX92
         yu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748625768; x=1749230568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2+I8ddCiFjrB8xJs9w+tqJSvPLrU6OzWs2betag0YA=;
        b=Dhbmv80PNLOyj8ZxZwn8HvDTKRdhAn+Pyisp8LOqK8+veIarwrrQiAdAW65d0DAT8x
         pWHW+peeCEyhGnks/5iU7s45Sm4Ig+Zk7KNaURlmeUhJNl1hkNcv/Rz6UP+ul/VMxe2Y
         4QgcwjfgbwOhjcEIEjL3zNFC8zksZ49a8jYL4kz2MCv/R450vgp0B46SQ6YdYIqXFdsu
         d7L6G1SpNByH13p+Zj6+RK5taANySfxc8DpeRSjPV2WXvTJEwKm96aiacQwktqdRFQuB
         zri2J9tlFrdxfzMVYgH0D4Fi680pq/VlKbZ+kxr8rau16Ky/pe7wPp/095F9bTGWQx+l
         CteA==
X-Gm-Message-State: AOJu0Ywtc8HH58f6Lw28S0JJ6RmFeEEeaZz95Ca3bQFKGvpw/YRwPo/F
	wxElC5CHxWRXLum6qnkFn8zaX/xGl3dWTnX64ZPkkr6K7XcEkq31XF4jPH8hrw==
X-Gm-Gg: ASbGncsbcRQe9rMnrZe8gpsC5ank58U1HnD1q4xJ7nFZyv0sbgd8DWSoYP2WSjai2uC
	eqza2MwKGpuh1tmUQSDYoiansyZfehIJ6LBumzyK8kP6WAJBEzCETE6UpI1wIUOBkPGFFvowjMJ
	BA4OjAdDj5swJxYPO14fSgkJQON3zvp7lV+vAsR9ZXznqH3bxxJ1kvMR7tHVqWe05fJ2CQx6ksQ
	fmqm02qT+SnYCBxdi23Z+1gGo1ScS99h5uR7/ROHjRzaVaK4OcWWAZMc5XND0ICOuW2xG9bidPs
	x5mEkuOyFseSDz4xISWg8GbPNHeWGTXlyNZbf1bEX1c5f3xNgXQv8iYmxmhcUjoDi+qCDJ2yztR
	Pxmqf0FbW+V3NdeLTGWQnSzRpaKoP4w==
X-Google-Smtp-Source: AGHT+IGzRM5Cq4grlYiu+UXr8Mk/bobDZtibjinUc/+N6Ctqh2uBVKXd+i1YlOczgqywYykSuQsmoA==
X-Received: by 2002:a05:6214:5281:b0:6fa:c5be:dac3 with SMTP id 6a1803df08f44-6fad19119f7mr41460146d6.3.1748625767689;
        Fri, 30 May 2025 10:22:47 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e2fc45sm26027936d6.122.2025.05.30.10.22.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 10:22:46 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][scarthgap][PATCH 2/2] remove radxa-zero-3{e|w}
Date: Fri, 30 May 2025 13:22:34 -0400
Message-ID: <20250530172234.7393-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20250530172234.7393-1-twoerner@gmail.com>
References: <20250530172234.7393-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 May 2025 17:22:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1604

Remove these devices from the scarthgap branch. In the scarthgap era they were
only supported using non-upstream forks and branches of the kernel and u-boot,
branches that continuously move, change names, and disappear.

Branches after scrathgap have upstream support for these devices and are a
better choice.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 conf/machine/include/radxa-zero-3.inc   |  8 --------
 conf/machine/include/rk3566.inc         | 23 -----------------------
 conf/machine/radxa-zero-3e.conf         |  7 -------
 conf/machine/radxa-zero-3w.conf         |  7 -------
 recipes-bsp/rkbin/rockchip-rkbin_git.bb | 15 ---------------
 recipes-graphics/mesa/mesa_%.bbappend   |  1 -
 6 files changed, 61 deletions(-)
 delete mode 100644 conf/machine/include/radxa-zero-3.inc
 delete mode 100644 conf/machine/include/rk3566.inc
 delete mode 100644 conf/machine/radxa-zero-3e.conf
 delete mode 100644 conf/machine/radxa-zero-3w.conf

diff --git a/conf/machine/include/radxa-zero-3.inc b/conf/machine/include/radxa-zero-3.inc
deleted file mode 100644
index 1c6f972c1e31..000000000000
--- a/conf/machine/include/radxa-zero-3.inc
+++ /dev/null
@@ -1,8 +0,0 @@
-MACHINEOVERRIDES =. "radxa-zero-3:"
-
-require conf/machine/include/rk3566.inc
-
-PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
-MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
-
-UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
deleted file mode 100644
index 2522851fa392..000000000000
--- a/conf/machine/include/rk3566.inc
+++ /dev/null
@@ -1,23 +0,0 @@
-SOC_FAMILY = "rk3566"
-
-DEFAULTTUNE ?= "cortexa55"
-
-ROCKCHIP_CLOSED_TPL ?= "1"
-
-require conf/machine/include/soc-family.inc
-require conf/machine/include/rockchip-defaults.inc
-require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
-require conf/machine/include/rockchip-wic.inc
-
-KBUILD_DEFCONFIG ?= "defconfig"
-KERNEL_FEATURES:append:rk3566 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_CLASSES = "kernel-fitimage"
-KERNEL_IMAGETYPE ?= "fitImage"
-
-PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin"
-PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
-
-UBOOT_SUFFIX ?= "itb"
-UBOOT_ENTRYPOINT ?= "0x06000000"
-
-ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/radxa-zero-3e.conf b/conf/machine/radxa-zero-3e.conf
deleted file mode 100644
index 37792cbf36a5..000000000000
--- a/conf/machine/radxa-zero-3e.conf
+++ /dev/null
@@ -1,7 +0,0 @@
-#@TYPE: Machine
-#@NAME: Radxa Zero 3E
-#@DESCRIPTION: The Radxa ZERO 3e is an ultra-small, high-performance single board computer based on the Rockchip RK3566, with a compact form factor, and rich interfaces.
-#http://radxa.com/products/zeros/zero3e/
-
-require conf/machine/include/radxa-zero-3.inc
-KERNEL_DEVICETREE = "rockchip/rk3566-radxa-zero-3e.dtb"
diff --git a/conf/machine/radxa-zero-3w.conf b/conf/machine/radxa-zero-3w.conf
deleted file mode 100644
index 5193d45e1f69..000000000000
--- a/conf/machine/radxa-zero-3w.conf
+++ /dev/null
@@ -1,7 +0,0 @@
-#@TYPE: Machine
-#@NAME: Radxa Zero 3W
-#@DESCRIPTION: The Radxa ZERO 3w is an ultra-small, high-performance single board computer based on the Rockchip RK3566, with a compact form factor, and rich interfaces.
-#http://radxa.com/products/zeros/zero3w/
-
-require conf/machine/include/radxa-zero-3.inc
-KERNEL_DEVICETREE = "rockchip/rk3566-radxa-zero-3w.dtb"
diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
index e555dcdac355..7e0bf813d27a 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
@@ -16,7 +16,6 @@ S = "${WORKDIR}/git"
 
 COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:rk3308 = "rk3308"
-COMPATIBLE_MACHINE:rk3566 = "rk3566"
 COMPATIBLE_MACHINE:rk3568 = "rk3568"
 COMPATIBLE_MACHINE:rk3588s = "rk3588s"
 
@@ -42,20 +41,6 @@ do_deploy:rk3308() {
 	install -m 644 ${S}/bin/rk33/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin
 }
 
-DDRBIN_VERS:rk3566 ?= "v1.23"
-DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
-
-# NOTE: the following are not typos
-#       the rk3566 uses the same bl31/2 as the rk3568
-do_deploy:rk3566() {
-	# Prebuilt TF-A
-	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3566.elf
-	# Prebuilt OPTEE-OS
-	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3566.bin
-	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3566.bin
-}
-
 DDRBIN_VERS:rk3568 ?= "v1.23"
 DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
 
diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa_%.bbappend
index 00cc15c6221c..2d9ec2e676f7 100644
--- a/recipes-graphics/mesa/mesa_%.bbappend
+++ b/recipes-graphics/mesa/mesa_%.bbappend
@@ -1,6 +1,5 @@
 PACKAGECONFIG:append:rk3288 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3328 = " kmsro lima"
 PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
-PACKAGECONFIG:append:rk3566 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3568 = " kmsro panfrost"
 PACKAGECONFIG:append:px30 = " kmsro panfrost"
-- 
2.44.0.478.g7774cfed6261


