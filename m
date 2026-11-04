Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8469.1793797354935331527
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 05:02:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=KWaGeWSE;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.128.53, mailfrom: andrea.ricchi@amarulasolutions.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so6096975e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 05:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793797353; x=1794402153; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1aLhXxDFy5Pf3t6ORezcYz+pxbkBvQiwBRSKWrqj6nk=;
        b=KWaGeWSEh2q1X2Hj5HQ3Lp9gm8xpFvvdSBChhETnsjDTKxN6DRFeJWzR/brv1FeUI0
         sy7MXFORV80YLFwXufZFItoGh5xxp9ZcLUN6P35hPM+/l8ubuIn6axrFu5gxOF7fqzqb
         SCT1rQdzbMTl/C9mrYqNp6DV3aPkYZio5uttE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793797353; x=1794402153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1aLhXxDFy5Pf3t6ORezcYz+pxbkBvQiwBRSKWrqj6nk=;
        b=B6e+I3qOaOw+JTD54SGexOlfeoivmY79BSVjjp6wk8QPFZHbYLfXGR3Zpee1obccAB
         95ZrZHwIUWlkHe9uAczN3IUcXz9cFID9XynsCQe+/KGizOcrWAXqRAXujuB4nqvU6DLK
         uHIHjDn5F7jGOwlY+YIOcmm9R5TpjMmzgn2HQZxQoM8DKyxbKC+5DX765sS+v4LyFKFf
         Y0UxfzSojMINArrYgdrkuLAv8PCKwcWVGoZBE+MztjSHqw7bXORmP/doogM6fOE2NyaQ
         ldgYSY4P7T0+akYH7TqHDEsAcT2i/aa3q7GZ+DPGh0kkYpHoDORpShaYFye3Wdd5oMtC
         cZAw==
X-Gm-Message-State: APuU4Z+luwPxuDFtIqHPOtt3dIekcgtEZwczwnDv75tzwgiu+JVtwHBP
	kUEgpxfqPFkAfBI5Tre/yt2zh0LAX5iS7RS4WCGdLmjJQKDz9IPxSgK91AwlDtzMkBze2l5dXfq
	T6BWV
X-Gm-Gg: AYBFou1HWkvHCoa14WVuJ/Jg/tQxPNc4EBpIBsI4evyS5LUvi+dvatMNnZwp2D8SIvX
	NIWPwnQKOjK0r/lUoNxc3qWo0bzXnZIq4psv2zj6Rx8USs42A6r0U3GQOTlU3B/jxPy8+SMZDCD
	/4dM9rPqwk0S+RJ5UDeqVCBbh3bLr26SSX0aQDGgfz1/GmLU8WSgcGf60e1OU1/INEVuA+uzB12
	w8lESdWKgEnbjyvYm/q2vAIkFzilRWjT3VVL/mu4P4Uvn5+8XvBE7JtnXPDPMHcGI1O3Dm+pZvz
	qHDRrNi/F5pqIDttVuSKupgR0B6fusTmPIZYfXD2uvvsCP09VtgKlQTU5Y771QngXBrv0Q5tE45
	FA44uNu9c01wfrN5NRKjbgjJ5quYGvcK9WJyx0fiutVmLsmijfByuTRaueuP339p31ceD9A9CFp
	QdBAreEwarKpL7xlFr+Mi91bKZkGBsv08GUTIDueyq7lY7+2A2ljTDXCz+c5t4ve/iA3dLCSI/e
	Z1bwEDhApRwnrn91syCPvJc8qqB0Cy7Fj8790HgwN2ZDiSqIE19g07cRIo4GPqiTpaLbGiJ3JQd
	guJJkzkU2k4RLSat7VU7qaE//E9QkY3MesiYSOQBo3kxZmyPVVyw0U7lm9Z9pZP3hH5L5l0vHan
	2DUnKZZDooYldnRu3GEz2CH1ncyf6CFLMuIIoWOSwLhqMU0fc7PjyCC/tkKt0HOfHwO35BQdyjk
	ZvAMCgx5ORn8o6fM5HTvfSSXxlawWsocWb32LfgFHR+GYQscCgykvFXBfho+DkSP2kee4kbzzS6
	hYGYtUY7yylSHH26/5aPGdv4bm3Vg==
X-Received: by 2002:a05:600d:1a:b0:4a1:d49e:9ce with SMTP id 5b1f17b1804b1-4aa86e16223mr435582045e9.2.1793797353123;
        Wed, 04 Nov 2026 05:02:33 -0800 (PST)
Return-Path: <andrea.ricchi@amarulasolutions.com>
Received: from rcc-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-55-40-40.retail.telecomitalia.it. [79.55.40.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece998absm4119196f8f.22.2026.11.04.05.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:02:32 -0800 (PST)
From: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Subject: [meta-rockchip][PATCH v2] kernel: restore options the 32-bit arch removal drops
Date: Wed,  4 Nov 2026 14:02:29 +0100
Message-ID: <20261104130230.236614-1-andrea.ricchi@amarulasolutions.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 13:02:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5233
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
v2: add the layer tag to the subject, the patch itself is unchanged.

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

