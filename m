Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8365.1793797040035596311
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 04:57:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=VfrDrd2I;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.221.53, mailfrom: andrea.ricchi@amarulasolutions.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4649b35bso580751f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 04:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793797038; x=1794401838; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W1kum1dpdXE3WtfmoD8p+R66ptoYNgCehsfbyi98qas=;
        b=VfrDrd2IYZn2hKNN6cDhzAJCCdKbTahZhXkNQHSY0zBC/L1a6wt9nT2jJCuja3gB97
         psGsHzNIMB/z89Kglo4uuE/3yXlCfJkNYVMJLh0qqGES5QOPfkGLp5hAo2RNoy+7NFCG
         EPYyFscRrRiUtaeVLD9ELrjrbB3R6Kd8DD86I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793797038; x=1794401838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W1kum1dpdXE3WtfmoD8p+R66ptoYNgCehsfbyi98qas=;
        b=e/XqNLY7EC+ZmdRPLTrO0dDi4TEaeFByGso5D+CmpT/wwTPSFX370zvRvyEYx5oVFT
         VGdYucxuw17OOBFeBbLvaW6IZBRPbBznZ1rh+qfqO2YvVCQsqc8uhHzNE1MT5Gg+ANGo
         b3PV3bbLMV46FHc51aLYHsMU3q2xDdhYpYFUgm0sKXp8tjUiFT9onc7YyisTJmCboMzx
         UuOCVOfofXlBuFtq67lHJuV31qxHXxy66LapXkh7C5urKYZOfd19DQ0+BOJo2U6ajzXO
         rAahQ8nZzgG1hrkf8hK+2gJzU06PjZV9cPhVNaqVLpy/X3CuFhwB3qIit65H1wAUgliQ
         9WTQ==
X-Gm-Message-State: APuU4Z9FvIpgnHA4ZmpMm1GH8jbbqAJWIyO7ee65ROQs8ABs0OugUeHh
	UglHTbhsNKDPqvgMt90a2jvsySOSjHS8+GqFm5Zdv0Bc+GauTuAy+4vL2PzKgc4VCOrKpIMq4St
	HsRFv
X-Gm-Gg: AYBFou06kO1XzegrFCfFNc2cL4sW7H9U7x/Qcer4V9brBUhZ75cGYrenOdLiAZ2YrrF
	9jYRoLagQa7ZvSZVZTuUzW2JurwI0oqW9sJgdRpZQBRJScyYRt4lliYmXHx3lyWgWf3jOjG0b8C
	Mpru1YMLLvACRWVsNWyKksfcwZj5DsdVmYeAPEevNAjeSwb9+zlEJApYh0YwiYXjogtbGNxXlWR
	16x85b1Z4yujqusCrjAD9GuPrTsrr7cEj5kWqDAuR46tMSCjqdSbgJrGzbiJZnmM+mFrFTpmjXk
	5bRWScOstaXwaJIV3sVCq2bAXB9ykSHHOmuN401iDKx5BmtgvQAGIL6RCMkdv22Oat4jCON6v6X
	qxW2r/f8J8mFm/UQNpkzLqVniMs7IVRBYR0We1uBeTZabNN0WfgFkO+0AehPdoHX7Th+64BId+1
	Kad7xNoKT0ZOg/IXI/7W0FYZCECSk06JHpVO8OozL23YKRsx+75qvxb4+Yyz313TPn079gWUqRt
	j60PAn+1dVsZRWYBQ8QCqldhB2s+NLc5T14MUnRpaqCfGKU/41AvJyiNXo4g15neptXj3gwfQH6
	CgAhJhOVMvQ91lsRYMeDxeDubawoLGc2luG3uFa4UOvssfafdTZtkJ6PCLOAf2p1WNR8jgJjqnC
	Ji2GFIjorLkU2RbknJl+VpzfrBs1Sh8RhyJ3au65m+XSefiPgcYNnYhUqOfG6GWUavznTuS701X
	reol0vWwvR1I5JGrNLQ0OllcTaJU16kY50ztY5iLLHaSi4hgehckGxjRPTzRTraxr0zEleRxXfW
	MvqJXd7
X-Received: by 2002:a05:6000:200e:b0:48c:466e:9d08 with SMTP id ffacd0b85a97d-48e6e50ab18mr34637003f8f.43.1793797038144;
        Wed, 04 Nov 2026 04:57:18 -0800 (PST)
Return-Path: <andrea.ricchi@amarulasolutions.com>
Received: from rcc-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-55-40-40.retail.telecomitalia.it. [79.55.40.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece998absm4091917f8f.22.2026.11.04.04.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:57:17 -0800 (PST)
From: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Subject: [PATCH] kernel: restore options the 32-bit arch removal drops
Date: Wed,  4 Nov 2026 13:57:13 +0100
Message-ID: <20261104125713.234969-1-andrea.ricchi@amarulasolutions.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 12:57:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5232
Content-Type: text/plain; charset="utf-8"

multi_v7_defconfig does not list several options the Rockchip boards
rely on; it gets them through "select" from platforms that
remove-non-rockchip-arch-arm.cfg switches off (ARCH_OMAP2PLUS,
ARCH_VEXPRESS, ARCH_VIRT, ARCH_U8500, ...). Removing those platforms
therefore also removes:

  REGULATOR_FIXED_VOLTAGE   parent supply of the PMIC regulators
  VFP, VFPv3, NEON, KERNEL_MODE_NEON
  ARM_PSCI                  HAVE_ARM_SMCCC_DISCOVERY, which
                            ROCKCHIP_PM_DOMAINS depends on
  ROCKCHIP_PM_DOMAINS
  HIGHMEM
  REALTEK_PHY
  USB_EHCI_HCD_PLATFORM, USB_OHCI_HCD_PLATFORM

On tinker-board-s with linux-yocto 6.18 the kernel stops at "Waiting
for root device": the RK808 regulators have no parent supply, so the
SD host never gets vmmc. With the root mounted, every hard-float
binary would fail and the VOPs would never probe for lack of power
domains.

Add the options back in a fragment pulled in by the same scc, so the
removal no longer takes them along. Found by diffing the expanded
multi_v7_defconfig against the built .config.

Signed-off-by: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
---
 .../rockchip/remove-non-rockchip-arch-arm.scc |  1 +
 .../rockchip/restore-arm-selected-options.cfg | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg

diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
index ce77704..da5c12e 100644
--- a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
@@ -1 +1,2 @@
 kconf hardware remove-non-rockchip-arch-arm.cfg
+kconf hardware restore-arm-selected-options.cfg
diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg
new file mode 100644
index 0000000..ababaf6
--- /dev/null
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg
@@ -0,0 +1,26 @@
+# multi_v7_defconfig does not list these options; it gets them through
+# "select" from platforms that remove-non-rockchip-arch-arm.cfg switches
+# off (ARCH_OMAP2PLUS, ARCH_VEXPRESS, ARCH_VIRT, ARCH_U8500, ...). Set them
+# explicitly so removing those platforms does not remove them too.
+
+# regulator-fixed: parent supply of the PMIC regulators on most boards
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+
+# hard-float userspace
+CONFIG_VFP=y
+CONFIG_VFPv3=y
+CONFIG_NEON=y
+CONFIG_KERNEL_MODE_NEON=y
+
+# ROCKCHIP_PM_DOMAINS depends on HAVE_ARM_SMCCC_DISCOVERY, provided by
+# ARM_PSCI; without the power domains the VOPs, HDMI and IOMMUs never probe
+CONFIG_ARM_PSCI=y
+CONFIG_ROCKCHIP_PM_DOMAINS=y
+
+# boards with more than 768 MB
+CONFIG_HIGHMEM=y
+
+# Realtek PHYs on most boards, generic-ehci/generic-ohci in rk3288.dtsi
+CONFIG_REALTEK_PHY=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
-- 
2.53.0

