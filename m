Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78397D7495F
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 07:01:37 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11970.1766127695336425641
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Dec 2025 23:01:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JO2jMDt1;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a3d2f3299so17215836d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 23:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766127694; x=1766732494; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OuHV5j8SmTJEj2aKpw3ufc5AU/VDpnSepzGn1FzEhYk=;
        b=JO2jMDt1iz0BFP3FkaymKqcAC+PX6x6mitwvpZzq/gbcyGY9F2IPkhNkaNouEONVKb
         BbgZXGUbACcJ37rtWbRN+1zqXpxc4JGSZaWe0OHAfxrXHz2k8oLVCZTHA0otRQEcy3lp
         zEXeFF1SVpDxD7Ljp6I7e9A9PoKtyCB10mdica3vbOYChFSZitbgericQJEylFD0EaY1
         LE2RT1LBBul/qKfHO6I4yLXToHEbutJf3dheAID9NCuA63SME4CiNjjX5WNv4oo5SHHX
         uSn0IXgPzvMMFqyxqelBw9PsAF6RHBd9oT9U43S7PJBTMJmr97RPFA0N3+C41nP+WerU
         rVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766127694; x=1766732494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuHV5j8SmTJEj2aKpw3ufc5AU/VDpnSepzGn1FzEhYk=;
        b=BcG1YD++X04wsLfFqqLnDEnRu82QDTToQtRYc54luOwoCF12QiNXtMRlpIog/a790i
         uRmdqzwNIAOwylbhdcmFjl6TENnxmabmGEfTTN2q1Bi1x7sSIp3U/TYzVcXn6vmDGvNE
         2U/iQ4O6u0c7bYGq7Fvli2ZHwFaBKyo5GEHB/FQ19DoMZYYV6dBdMTuBNLD/gBIuu+Jv
         F5Yg63n8xNHSoirc/cO+l5/tsN+YeLf/Yhmgw52QToFSf5RRxCr15ynJFHCttPmZG+uu
         B6/+X6kPLb3b9FEc+U9EcWUYRhiu5xZlASt7FrvMhh1CKbJd3l2DrBnaXkA9HRxQX619
         t0xQ==
X-Gm-Message-State: AOJu0YxxC7UN/YN32BUusmj8Bs4G/dTHtDQGunSLD2ecZ3Sbifl7kv07
	MmCpmRbV8d4tllyUQxCAdsDGlGZrrMJ4E3Q2XGaYJXU+xqFqP+S95FAZpHkMAg==
X-Gm-Gg: AY/fxX6QE2u7pNntfh2CYS6aDPhUoUBLQNeB8vIIiUqEqtWkPT3H2cn027NDIU0bpPs
	EM9+Mx7We70Eg63p9GeRVz6dK0dJjKaulAzif7shCZjNAX/V0L1AacocJW1DFN++f6hfDCZC5gw
	IxpsxuSxj5W8hWKw4qsosIi6Rkr7s46HfYix5WHP5YowLeOnmVqgzOMePBmG19vE8jxVZeJuQnr
	GBIl1Hv3I+owXFiZr8b9w8epW5A7uGtzZHCjczCAOA9fbgWFYsSdgAz1J/DYDktMBwe+XY73lo0
	+QrbrL0vMJIJqJp/e0va2/ASK44wIhXVN7LlU9Iztr6NkQckJYUtHfrr4lz4wiKlyl5pVvEDI3x
	C/Rk8x4d1fRppr6v5FegJVy4d0+3FmYOwsZ6fZ9ty1zOBW4817+9YLWL2YWDrYo1MKBxCFVHlTn
	8aw0FxagnCncVyGfVKxEeyTg/frqgugYE0fhMoJA==
X-Google-Smtp-Source: AGHT+IEuTrjHETZf8+T7Ywn67tM3v9/uvU3btnAOwpa0iA7iGcplqT0ByMf1pJS5KHrfbAmQ/GGW1Q==
X-Received: by 2002:a0c:cdc2:0:b0:882:44cc:f587 with SMTP id 6a1803df08f44-88d8452893fmr25376206d6.1.1766127692974;
        Thu, 18 Dec 2025 23:01:32 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7d5f4sm13570166d6.40.2025.12.18.23.01.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 23:01:32 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 1/5] kmeta reorganization
Date: Fri, 19 Dec 2025 02:00:10 -0500
Message-ID: <20251219070014.39432-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 07:01:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2823

Reorganize the rockchip kmeta data so linux-yocto and linux-yocto-dev
share the same files.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../realtek-r8169.cfg                         |  0
 .../rockchip/remove-non-rockchip-arch-arm.cfg |  0
 .../rockchip/remove-non-rockchip-arch-arm.scc |  0
 .../remove-non-rockchip-arch-arm64.cfg        |  0
 .../remove-non-rockchip-arch-arm64.scc        |  0
 recipes-kernel/linux/linux-yocto-dev.bbappend |  2 +-
 .../rockchip/remove-non-rockchip-arch-arm.cfg | 85 -------------------
 .../rockchip/remove-non-rockchip-arch-arm.scc |  1 -
 .../remove-non-rockchip-arch-arm64.cfg        | 62 --------------
 .../remove-non-rockchip-arch-arm64.scc        |  1 -
 recipes-kernel/linux/linux-yocto_%.bbappend   |  2 +-
 11 files changed, 2 insertions(+), 151 deletions(-)
 rename recipes-kernel/linux/{linux-yocto => linux-rockchip}/realtek-r8169.cfg (100%)
 rename recipes-kernel/linux/{linux-yocto-dev => linux-rockchip}/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg (100%)
 rename recipes-kernel/linux/{linux-yocto-dev => linux-rockchip}/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc (100%)
 rename recipes-kernel/linux/{linux-yocto-dev => linux-rockchip}/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg (100%)
 rename recipes-kernel/linux/{linux-yocto-dev => linux-rockchip}/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc (100%)
 delete mode 100644 recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
 delete mode 100644 recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
 delete mode 100644 recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
 delete mode 100644 recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc

diff --git a/recipes-kernel/linux/linux-yocto/realtek-r8169.cfg b/recipes-kernel/linux/linux-rockchip/realtek-r8169.cfg
similarity index 100%
rename from recipes-kernel/linux/linux-yocto/realtek-r8169.cfg
rename to recipes-kernel/linux/linux-rockchip/realtek-r8169.cfg
diff --git a/recipes-kernel/linux/linux-yocto-dev/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
similarity index 100%
rename from recipes-kernel/linux/linux-yocto-dev/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
rename to recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
diff --git a/recipes-kernel/linux/linux-yocto-dev/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
similarity index 100%
rename from recipes-kernel/linux/linux-yocto-dev/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
rename to recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
diff --git a/recipes-kernel/linux/linux-yocto-dev/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
similarity index 100%
rename from recipes-kernel/linux/linux-yocto-dev/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
rename to recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
diff --git a/recipes-kernel/linux/linux-yocto-dev/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc
similarity index 100%
rename from recipes-kernel/linux/linux-yocto-dev/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc
rename to recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc
diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
index 67a16b4d67ff..81d2b6d693c4 100644
--- a/recipes-kernel/linux/linux-yocto-dev.bbappend
+++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
@@ -1,3 +1,3 @@
-FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
+FILESEXTRAPATHS:prepend := "${THISDIR}/linux-rockchip:"
 
 SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
diff --git a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg b/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
deleted file mode 100644
index e9443f17895c..000000000000
--- a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
+++ /dev/null
@@ -1,85 +0,0 @@
-CONFIG_ARCH_ACTIONS=n
-CONFIG_ARCH_AIROHA=n
-CONFIG_ARCH_ALPINE=n
-CONFIG_ARCH_ARTPEC=n
-CONFIG_ARCH_ASPEED=n
-CONFIG_ARCH_AT91=n
-CONFIG_ARCH_BCM2835=n
-CONFIG_ARCH_BCM=n
-CONFIG_ARCH_BCMBCA=n
-CONFIG_ARCH_BCMBCA_BRAHMAB15=n
-CONFIG_ARCH_BCMBCA_CORTEXA7=n
-CONFIG_ARCH_BCMBCA_CORTEXA9=n
-CONFIG_ARCH_BCM_21664=n
-CONFIG_ARCH_BCM_23550=n
-CONFIG_ARCH_BCM_281XX=n
-CONFIG_ARCH_BCM_5301X=n
-CONFIG_ARCH_BCM_53573=n
-CONFIG_ARCH_BCM_CYGNUS=n
-CONFIG_ARCH_BCM_HR2=n
-CONFIG_ARCH_BCM_NSP=n
-CONFIG_ARCH_BERLIN=n
-CONFIG_ARCH_BRCMSTB=n
-CONFIG_ARCH_DIGICOLOR=n
-CONFIG_ARCH_EMEV2=n
-CONFIG_ARCH_EXYNOS=n
-CONFIG_ARCH_HI3xxx=n
-CONFIG_ARCH_HIGHBANK=n
-CONFIG_ARCH_HIP01=n
-CONFIG_ARCH_HIP04=n
-CONFIG_ARCH_HISI=n
-CONFIG_ARCH_HIX5HD2=n
-CONFIG_ARCH_HPE=n
-CONFIG_ARCH_HPE_GXP=n
-CONFIG_ARCH_INTEL_SOCFPGA=n
-CONFIG_ARCH_KEYSTONE=n
-CONFIG_ARCH_MEDIATEK=n
-CONFIG_ARCH_MESON=n
-CONFIG_ARCH_MILBEAUT=n
-CONFIG_ARCH_MILBEAUT_M10V=n
-CONFIG_ARCH_MMP=n
-CONFIG_ARCH_MSM8916=n
-CONFIG_ARCH_MSM8960=n
-CONFIG_ARCH_MSM8974=n
-CONFIG_ARCH_MSM8X60=n
-CONFIG_ARCH_MVEBU=n
-CONFIG_ARCH_MXC=n
-CONFIG_ARCH_OMAP3=n
-CONFIG_ARCH_OMAP4=n
-CONFIG_ARCH_QCOM=n
-CONFIG_ARCH_R7S72100=n
-CONFIG_ARCH_R7S9210=n
-CONFIG_ARCH_R8A73A4=n
-CONFIG_ARCH_R8A7740=n
-CONFIG_ARCH_R8A7742=n
-CONFIG_ARCH_R8A7743=n
-CONFIG_ARCH_R8A7744=n
-CONFIG_ARCH_R8A7745=n
-CONFIG_ARCH_R8A77470=n
-CONFIG_ARCH_R8A7778=n
-CONFIG_ARCH_R8A7779=n
-CONFIG_ARCH_R8A7790=n
-CONFIG_ARCH_R8A7791=n
-CONFIG_ARCH_R8A7792=n
-CONFIG_ARCH_R8A7793=n
-CONFIG_ARCH_R8A7794=n
-CONFIG_ARCH_R9A06G032=n
-CONFIG_ARCH_RENESAS=n
-CONFIG_ARCH_SH73A0=n
-CONFIG_ARCH_SPEAR13XX=n
-CONFIG_ARCH_STI=n
-CONFIG_ARCH_STM32=n
-CONFIG_ARCH_SUNPLUS=n
-CONFIG_ARCH_SUNXI=n
-CONFIG_ARCH_TEGRA=n
-CONFIG_ARCH_TEGRA_114_SOC=n
-CONFIG_ARCH_TEGRA_124_SOC=n
-CONFIG_ARCH_TEGRA_2x_SOC=n
-CONFIG_ARCH_TEGRA_3x_SOC=n
-CONFIG_ARCH_U8500=n
-CONFIG_ARCH_UNIPHIER=n
-CONFIG_ARCH_VEXPRESS=n
-CONFIG_ARCH_VEXPRESS_TC2_PM=n
-CONFIG_ARCH_VIRT=n
-CONFIG_ARCH_WM8850=n
-CONFIG_ARCH_ZYNQ=n
diff --git a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc b/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
deleted file mode 100644
index ce7770456ea4..000000000000
--- a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
+++ /dev/null
@@ -1 +0,0 @@
-kconf hardware remove-non-rockchip-arch-arm.cfg
diff --git a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg b/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
deleted file mode 100644
index 597d47a424d2..000000000000
--- a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
+++ /dev/null
@@ -1,62 +0,0 @@
-CONFIG_ARCH_ACTIONS=n
-CONFIG_ARCH_ALPINE=n
-CONFIG_ARCH_APPLE=n
-CONFIG_ARCH_BCM2835=n
-CONFIG_ARCH_BCM=n
-CONFIG_ARCH_BCMBCA=n
-CONFIG_ARCH_BCM_IPROC=n
-CONFIG_ARCH_BERLIN=n
-CONFIG_ARCH_BRCMSTB=n
-CONFIG_ARCH_EXYNOS=n
-CONFIG_ARCH_HISI=n
-CONFIG_ARCH_INTEL_SOCFPGA=n
-CONFIG_ARCH_K3=n
-CONFIG_ARCH_KEEMBAY=n
-CONFIG_ARCH_LAYERSCAPE=n
-CONFIG_ARCH_LG1K=n
-CONFIG_ARCH_MEDIATEK=n
-CONFIG_ARCH_MESON=n
-CONFIG_ARCH_MVEBU=n
-CONFIG_ARCH_MXC=n
-CONFIG_ARCH_NPCM=n
-CONFIG_ARCH_NXP=n
-CONFIG_ARCH_QCOM=n
-CONFIG_ARCH_R8A774A1=n
-CONFIG_ARCH_R8A774B1=n
-CONFIG_ARCH_R8A774C0=n
-CONFIG_ARCH_R8A774E1=n
-CONFIG_ARCH_R8A77951=n
-CONFIG_ARCH_R8A77960=n
-CONFIG_ARCH_R8A77961=n
-CONFIG_ARCH_R8A77965=n
-CONFIG_ARCH_R8A77970=n
-CONFIG_ARCH_R8A77980=n
-CONFIG_ARCH_R8A77990=n
-CONFIG_ARCH_R8A77995=n
-CONFIG_ARCH_R8A779A0=n
-CONFIG_ARCH_R8A779F0=n
-CONFIG_ARCH_R8A779G0=n
-CONFIG_ARCH_R9A07G043=n
-CONFIG_ARCH_R9A07G044=n
-CONFIG_ARCH_R9A07G054=n
-CONFIG_ARCH_R9A09G011=n
-CONFIG_ARCH_RENESAS=n
-CONFIG_ARCH_S32=n
-CONFIG_ARCH_SEATTLE=n
-CONFIG_ARCH_SPRD=n
-CONFIG_ARCH_SUNXI=n
-CONFIG_ARCH_SYNQUACER=n
-CONFIG_ARCH_TEGRA=n
-CONFIG_ARCH_TEGRA_132_SOC=n
-CONFIG_ARCH_TEGRA_186_SOC=n
-CONFIG_ARCH_TEGRA_194_SOC=n
-CONFIG_ARCH_TEGRA_210_SOC=n
-CONFIG_ARCH_TEGRA_234_SOC=n
-CONFIG_ARCH_TESLA_FSD=n
-CONFIG_ARCH_THUNDER2=n
-CONFIG_ARCH_THUNDER=n
-CONFIG_ARCH_UNIPHIER=n
-CONFIG_ARCH_VEXPRESS=n
-CONFIG_ARCH_VISCONTI=n
-CONFIG_ARCH_XGENE=n
-CONFIG_ARCH_ZYNQMP=n
diff --git a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc b/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc
deleted file mode 100644
index e169240f5067..000000000000
--- a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc
+++ /dev/null
@@ -1 +0,0 @@
-kconf hardware remove-non-rockchip-arch-arm64.cfg
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index 2dba3d70a3ca..a648ecb20679 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -1,4 +1,4 @@
-FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
+FILESEXTRAPATHS:prepend := "${THISDIR}/linux-rockchip:"
 
 # 32-bit devices
 COMPATIBLE_MACHINE:firefly-rk3288 = "firefly-rk3288"
-- 
2.50.0.173.g8b6f19ccfc3a


