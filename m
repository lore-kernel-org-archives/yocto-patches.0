Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8105.1793701692341459469
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Nov 2026 02:28:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=xQ0cxvIW;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5351d76e1baso5925331cf.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 02:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701691; x=1794306491; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TeACnPw7ovtsNmEkZnRM9XwkmKMU05byweQi/1+WWQs=;
        b=xQ0cxvIWxQgS7kobiHT6IEzY0BlTL0D0s1rREx3N2YPD6e2OrAKp0M0t+JIPuLoBa6
         36S/WUJ6x1h52qw1dMiiDsVSASaZgCdt3m7o03CJklFLhLRTOImLXH7xJxphgPPxoqZS
         BnJ5ooN544d4kuEvCwtCFVAz+j+1Qm6tpORKKxcsrsvQng0adIYSxnmZ3NDp46Shm+h1
         LrTfowsPfXoCUNsrfVOLT0lka5zjIh5bYqCnJ9nskqoqbWmdpSIGyGAs2Iy8k2d/n3dk
         UkM9BcQ8ms/dFRQ3FyOzoY1lcbpvuyAd/ZjdqSSXgcLGHWnON4xruIxQSm98LaP8Ntfc
         WRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701691; x=1794306491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TeACnPw7ovtsNmEkZnRM9XwkmKMU05byweQi/1+WWQs=;
        b=eU3n57FKrdIgEIjXJCDiiUt0yd+pgeJQVTg3wxKhHrgI9i2toeglg9pDv9qu8UZ2+n
         qQLtVOoyL7sEkknXJfY37T8/0KwPQzq06roCL7VSK46cJZhsxWY91QiyCIfHtz36Zvgw
         NNpw5JciEl+gbwYHnmo4F0XoF2zh0RmJxSduB/oqC8RL2e5fLKU1Y9UU7ash3omQgJfw
         5d0cxD3aRhmJl+iKfoKCnoh5lqTZyFmG03DYgGOum73IMen6IoGzBPqU2l+o0j2Ft4b7
         0UnSFwIcUke56vZVsPjBn7mmVUtcuYgcuyHsIOHSqyqIMFC3lHyEZzCinPtHeGrRPplw
         PghQ==
X-Gm-Message-State: APuU4Z9/LAEfBEjKPN1a8QJnguY1krxeOrm7mR3ToNsJ0qZCho+Y9nyo
	vQaUt/qhpeJCtB+qPnGBFgtp6rgyvcvSxrfAbsKalUXa8GGPasoWygrlbQXwRQ==
X-Gm-Gg: AYBFou1chAjS5Y6F7haMJIgJqUnFLigsjmdYoR5o7645H9WAFXEKotyBdWOJbWsY3Bm
	1ORhmoHIJINIOPSBzquMEf9Pj/DOvGpknTOnwzUOytVmYgO9vts2pIjmIk8hG5y0cBAcAfPlPQj
	cjncH/Gh3gvG1HbtAfhWIzZQFo7SjBB9z40DbKQunFJe6+MXLIXImnGGZ0/g8qnl/AdQ34a8JJ+
	kw+9sxagEmDEHOP7SJ60yCeX0p6HChQuTA4iiKwU8ykVmEhXj6QK55mVtMFxuU1s2jq29ox8bTA
	VtSxSKOvHMUY0udpL36S3IdY7IyoNkv3T+lXjZsYojSBIBAQLIiKenbEm/Do6Hq7dFonTXXuoR5
	wh9FWIkVk9M5v5BHLeFFRJTkSjShcaxuCH9QG0X7SVki3SQadl2O9fg9Hoiot+6KoI/qH+2CUm0
	xcGKqLr5m+m2uFfNyOXb1Rt0MEcY2xRXGoZ3w74wQbGB8bSLYc2PpLwSfbTkVvE5Mk9HScK2tDd
	H+KJS3IoxHFB2vxJF2gKl4oKAitEYfOcxynX83p49q/bhOGJl0JyE5e6MPD9dxAs0Lf/7H+gsOt
	ozq6DqNvkdalZSwQsOSsrpP3cc3Kknot30XVXrygqXjYoL4PjMv/6zwUUeziahdtTYjZGohIWtB
	lidopMbNrHTXPMpx9HbNQeJefe/P1b02DQv3GpfmVT+li8+svYx7U
X-Received: by 2002:a05:622a:2b46:b0:53f:98b5:4317 with SMTP id d75a77b69052e-542b88d2cd5mr180975961cf.34.1793701690946;
        Tue, 03 Nov 2026 02:28:10 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49da50sm22512171cf.9.2026.11.03.02.28.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:28:10 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v1] kernel: refresh the non-rockchip architecture removal fragments
Date: Tue,  3 Nov 2026 05:27:59 -0500
Message-ID: <20261103102759.1507386-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 10:28:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5217
Content-Type: text/plain; charset="utf-8"

Several Arm platforms have been added upstream since these lists were
written, so a kernel built from an in-tree defconfig was again carrying
support for machines this layer does not target. On arm64 the
defconfig re-enabled Aspeed, Black Sesame and Microchip; on arm the
TI SoC driver menu came back.

Add the platform symbols arm64 has gained, along with the Renesas and
Tegra per-SoC options that arrived with them, and the TI menu on arm.
Nothing has been removed: every symbol these fragments already carry
still exists in the kernel.

AI-Generated: codex/claude-opus 5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../rockchip/remove-non-rockchip-arch-arm.cfg |  1 +
 .../remove-non-rockchip-arch-arm64.cfg        | 20 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
index fdd3e6964053..7651c5b05a76 100644
--- a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
@@ -48,6 +48,7 @@ CONFIG_SOC_OMAP5=n
 CONFIG_SOC_AM33XX=n
 CONFIG_SOC_AM43XX=n
 CONFIG_SOC_DRA7XX=n
+CONFIG_SOC_TI=n
 CONFIG_ARCH_QCOM=n
 CONFIG_ARCH_R7S72100=n
 CONFIG_ARCH_R7S9210=n
diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
index 12fde404d64a..09fb5810c1cf 100644
--- a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
@@ -2,14 +2,18 @@ CONFIG_ARCH_ACTIONS=n
 CONFIG_ARCH_AIROHA=n
 CONFIG_ARCH_ALPINE=n
 CONFIG_ARCH_APPLE=n
+CONFIG_ARCH_ARTPEC=n
+CONFIG_ARCH_ASPEED=n
 CONFIG_ARCH_AXIADO=n
 CONFIG_ARCH_BCM2835=n
 CONFIG_ARCH_BCM=n
 CONFIG_ARCH_BCMBCA=n
 CONFIG_ARCH_BCM_IPROC=n
 CONFIG_ARCH_BERLIN=n
+CONFIG_ARCH_BITMAIN=n
 CONFIG_ARCH_BLAIZE=n
 CONFIG_ARCH_BRCMSTB=n
+CONFIG_ARCH_BST=n
 CONFIG_ARCH_CIX=n
 CONFIG_ARCH_EXYNOS=n
 CONFIG_ARCH_SPARX5=n
@@ -17,15 +21,19 @@ CONFIG_ARCH_HISI=n
 CONFIG_ARCH_INTEL_SOCFPGA=n
 CONFIG_ARCH_K3=n
 CONFIG_ARCH_KEEMBAY=n
+CONFIG_ARCH_LAN969X=n
 CONFIG_ARCH_LAYERSCAPE=n
 CONFIG_ARCH_LG1K=n
 CONFIG_ARCH_MEDIATEK=n
 CONFIG_ARCH_MESON=n
+CONFIG_ARCH_MICROCHIP=n
+CONFIG_ARCH_MMP=n
 CONFIG_ARCH_MVEBU=n
 CONFIG_ARCH_MXC=n
 CONFIG_ARCH_NPCM=n
 CONFIG_ARCH_NXP=n
 CONFIG_ARCH_MA35=n
+CONFIG_ARCH_PENSANDO=n
 CONFIG_ARCH_QCOM=n
 CONFIG_ARCH_REALTEK=n
 CONFIG_ARCH_R8A774A1=n
@@ -43,10 +51,19 @@ CONFIG_ARCH_R8A77995=n
 CONFIG_ARCH_R8A779A0=n
 CONFIG_ARCH_R8A779F0=n
 CONFIG_ARCH_R8A779G0=n
+CONFIG_ARCH_R8A779H0=n
+CONFIG_ARCH_R8A78000=n
 CONFIG_ARCH_R9A07G043=n
 CONFIG_ARCH_R9A07G044=n
 CONFIG_ARCH_R9A07G054=n
+CONFIG_ARCH_R9A08G045=n
+CONFIG_ARCH_R9A08G046=n
 CONFIG_ARCH_R9A09G011=n
+CONFIG_ARCH_R9A09G047=n
+CONFIG_ARCH_R9A09G056=n
+CONFIG_ARCH_R9A09G057=n
+CONFIG_ARCH_R9A09G077=n
+CONFIG_ARCH_R9A09G087=n
 CONFIG_ARCH_RENESAS=n
 CONFIG_ARCH_S32=n
 CONFIG_ARCH_SEATTLE=n
@@ -61,6 +78,9 @@ CONFIG_ARCH_TEGRA_186_SOC=n
 CONFIG_ARCH_TEGRA_194_SOC=n
 CONFIG_ARCH_TEGRA_210_SOC=n
 CONFIG_ARCH_TEGRA_234_SOC=n
+CONFIG_ARCH_TEGRA_238_SOC=n
+CONFIG_ARCH_TEGRA_241_SOC=n
+CONFIG_ARCH_TEGRA_264_SOC=n
 CONFIG_ARCH_TESLA_FSD=n
 CONFIG_ARCH_THUNDER2=n
 CONFIG_ARCH_THUNDER=n
-- 
2.50.0.173.g8b6f19ccfc3a

