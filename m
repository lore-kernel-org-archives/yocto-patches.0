Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6293.1794232228886927883
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Nov 2026 05:50:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=rGad7aEb;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: patrick.oetken@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c40f29667e6so131414066b.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Nov 2026 05:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794232227; x=1794837027; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7cT9uFVe5qDX5CnnnAo2XyYmoUsdffk7c6QpHK/+U0A=;
        b=rGad7aEbP4NjiJWfXy2yFjwS4xCc28dLhgmCsI99H/Sw1d4gq9U3vIGucowdGxb9KI
         6ZM/W6EaylCPoy5pTWC7oHpfmR/1N5FAUYskB7uN/LvrgvxfHmvhyMqIlkPWCqhv8VFQ
         l8R8qkuRjvuDjubqoe3jWxnOfyQjcIppOWjDWbaryoINO7u3BbXg/DJgco+nSBJZDf7+
         UMwloVoma+jMufDJGDGw4pVCw2LonOniQusOQEmiriUwglb7JWppeTvGwIEJxWvCqGBm
         MtL5ElQX9ZwskAw3FHG0By1lLl6Ntc5VTw1lXj4QVGNZGi5w39SqhmkaolNN2hy2nlWi
         /voA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232227; x=1794837027;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7cT9uFVe5qDX5CnnnAo2XyYmoUsdffk7c6QpHK/+U0A=;
        b=W1J8Re18Z3EgVZlGgHGwfvFqGU4JDN7zskd9aALTYgcwUmz7LE12spmJMgqrk+OrwW
         P2YZK2njQQFepuhPC+q0YvX1VbNQwqezfVVAQLMR6XeSJ/X5ocg9h8pgyox2SLk3nq3I
         6gE09QuUMuZTK7wau6LoXzOLdWJYMPGE7Qxg+RuBEZaaQP6N/NDs9H55ilRXL+QTnzyG
         N1v2BUutl1VjanDD+6yjtiMJGdYw5xu4SxIxe5ovSYuoHRlGbVZa1IUNaUKByLvEBfHv
         87YqK6UzpQRtQFTgHqDamP1iOflQFUp8cWx6dtoHmjRIKu16GYgYBRdkkvHO8vH/Lpcz
         EsPQ==
X-Gm-Message-State: APuU4Z+fXlBOW3psyZcKAdJdaY0RTxJlF3O7qmY21rvPszywvWd+SpmW
	68+NFV2aNvv6iG44lS655Vs0UuGk90bqfQCPTcPjdWEw7O/ewtVtK/l+eXEH4+Wz
X-Gm-Gg: AYBFou2MRjt+OPfL69pxWQAgOdK9C6HAZnux0jTvMH8Gy7ZzPvyUKdGYQd8SphuYiv7
	BrTDntGxGkcGK4iAlKN7sggYdx3Pk3wgrl0XO61kxFR2XJeQ1N+TlhFnE3sV6NehEL6fLPoF2sW
	eQmpVk8rK4gDifwquy5LKAUzIXUCdo1bqoQEoqupuMDDM1kpf/zQwD9rYtjU6CaOkxLZv+VWRDb
	hYnOe0blpbXA5DhvMrD8ryImCt8sVEE6Wm8DWdWtS0T6t6jpelLvblW1ZY4mBOu5518aYRQxbaf
	mLLY3FZ0wlEZ86AuV+1JJWoEm6fuB86I8t/Okyr9WI/7FFEiW4edbYWwpSFyWpTb1ajcXsreo3x
	OjTLqcrUgeDXHledy3ujezN7GajoL+XFQC6l/lq+iKpSPDgviHcsuIPFf8fFzQYxWDvrGBViIaC
	ARbuHZyZ5ktajnsU4l8zT0CO7+0PR51AZMYYepuMreRcMKyLcO3h6pLciAd45T48cMX7d7WZBMO
	/Qwsac89YdvAon7VK0c1Ov65MgHidnMqVbIQ9w39rCwoxIg7izZ5/nPITK2PpW0SsLfJOP1rAiv
	JZQfaJVzIDnzmJmJmPJdmWlI//RdLJgEYgMy2Hgw7AY8tpn/8VncOtmYzASBCGPihCMVnLhookj
	OwkfcG1wo9xIigKhAuSw=
X-Received: by 2002:a17:906:4795:b0:c46:ba0d:3728 with SMTP id a640c23a62f3a-c4d6d4f2dcfmr309450166b.18.1794232226956;
        Mon, 09 Nov 2026 05:50:26 -0800 (PST)
Return-Path: <patrick.oetken@gmail.com>
Received: from ws-24.. ([91.26.133.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d68d52cf9sm173476066b.2.2026.11.09.05.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:50:26 -0800 (PST)
From: Patrick Oetken <patrick.oetken@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Patrick Oetken <patrick.oetken@gmail.com>,
	Tim Orling <tim.orling@konsulko.com>,
	Tom Rini <tom.rini@konsulko.com>
Subject: [meta-lts-mixins][scarthgap/u-boot][PATCH] u-boot: backport fix for the bcm2712 non-removable check
Date: Mon,  9 Nov 2026 14:50:21 +0100
Message-ID: <20261109135021.4184031-1-patrick.oetken@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Nov 2026 13:50:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5253
Content-Type: text/plain; charset="utf-8"

sdhci_brcmstb_init_2712() tests host->mmc->host_caps, which is still zero
when sdhci_bcmstb_probe() calls it; mmc_of_parse() has put the device-tree
capabilities into plat->cfg.host_caps instead. Every BCM2712 SDHCI instance
therefore takes the removable-card branch and programs SDIO_CFG_SD_PIN_SEL
to SD mode, including the soldered eMMC on a Compute Module 5.

That register survives into Linux and makes the first MMC_POWER_UP fail to
latch POWER_ON. On a CM5 booting from eMMC through U-Boot 2025.04 this cost
a fixed ~134 s inside "Waiting for root device /dev/mmcblk0pN..." on 6 of
9 boots; with this backport applied, 0 of 19 boots stalled and boot time
went from 2 min 23 s to ~13 s.

The bug is present from v2024.04 up to v2026.04 and is fixed upstream in
v2026.07 by 8de24e226d74 ("mmc: bcmstb: Fix non-removable check in bcm2712
init"), so oe-core master (2026.10) already has it. The patch applies to
2025.04 without fuzz. Only the bcm2712 init hook changes.

Signed-off-by: Patrick Oetken <patrick.oetken@gmail.com>
---
 ...-non-removable-check-in-bcm2712-init.patch | 69 +++++++++++++++++++
 recipes-bsp/u-boot/u-boot-common.inc          |  1 +
 2 files changed, 70 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/0001-mmc-bcmstb-Fix-non-removable-check-in-bcm2712-init.patch

diff --git a/recipes-bsp/u-boot/files/0001-mmc-bcmstb-Fix-non-removable-check-in-bcm2712-init.patch b/recipes-bsp/u-boot/files/0001-mmc-bcmstb-Fix-non-removable-check-in-bcm2712-init.patch
new file mode 100644
index 0000000..459fbcd
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0001-mmc-bcmstb-Fix-non-removable-check-in-bcm2712-init.patch
@@ -0,0 +1,69 @@
+From 8de24e226d745c59972b1898df5cceacf0a7ad47 Mon Sep 17 00:00:00 2001
+From: =?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>
+Date: Tue, 12 May 2026 14:24:35 +0200
+Subject: [PATCH] mmc: bcmstb: Fix non-removable check in bcm2712 init
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+sdhci_brcmstb_init_2712() reads host->mmc->host_caps to decide whether
+to force card-detect for a non-removable eMMC, or to route the CD signal
+for a removable SD card. At the time this function runs from
+sdhci_bcmstb_probe(), however, host->mmc->host_caps is still zero, that
+field is only populated later by the MMC uclass, after the driver's
+probe returns. mmc_of_parse() has already filled plat->cfg.host_caps
+from the device tree by this point, so check that field instead.
+
+Without the fix, every BCM2712 SDHCI instance takes the else branch and
+writes SDIO_CFG_SD_PIN_SEL = SDIO_CFG_SD_PIN_SEL_CARD (0x02), including
+the non-removable eMMC on boards such as CM5 on Home Assistant Yellow.
+The SDIO_CFG block lies outside the SDHCI core's reset scope, so this
+value persists across SDHCI_RESET_ALL into the next stage. On the
+BCM2712, having SD_PIN_SEL set to "SD" when the Linux kernel performs
+its first set_power(MMC_POWER_UP) write racily prevents the SDHCI
+POWER_ON bit from latching (see [1] for the whole backstory) - the
+voltage bits stick but POWER_ON drops - which wedges the first CMD0 the
+full 10 s software timeout. On Home Assistant Yellow this manifested as
+a ~20 s eMMC probe delay on roughly one in two Linux boots when U-Boot
+was the previous stage. Booting directly from the Pi firmware (no U-Boot
+in between) left SD_PIN_SEL at its default and did not exhibit the race.
+
+Reading plat->cfg.host_caps lets init_2712 see the "non-removable"
+property and take the correct branch, leaving SD_PIN_SEL untouched for
+the eMMC.
+
+[1] https://github.com/home-assistant/operating-system/pull/3700#issuecomment-4430229511
+
+Fixes: 10127cdbab64 ("mmc: bcmstb: Add support for bcm2712 SD controller")
+Signed-off-by: Jan Čermák <sairon@sairon.cz>
+Reviewed-by: Ivan T. Ivanov <iivanov@suse.de>
+Upstream-Status: Backport [https://source.denx.de/u-boot/u-boot/-/commit/8de24e226d745c59972b1898df5cceacf0a7ad47]
+Signed-off-by: Patrick Oetken <patrick.oetken@gmail.com>
+---
+ drivers/mmc/bcmstb_sdhci.c | 6 +++---
+ 1 file changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/drivers/mmc/bcmstb_sdhci.c b/drivers/mmc/bcmstb_sdhci.c
+index 7bddbebb1622..f27b84a6ee43 100644
+--- a/drivers/mmc/bcmstb_sdhci.c
++++ b/drivers/mmc/bcmstb_sdhci.c
+@@ -56,7 +56,7 @@ struct sdhci_brcmstb_dev_priv {
+ 
+ static int sdhci_brcmstb_init_2712(struct udevice *dev)
+ {
+-	struct sdhci_host *host = dev_get_priv(dev);
++	struct sdhci_bcmstb_plat *plat = dev_get_plat(dev);
+ 	void *cfg_regs;
+ 	u32 reg;
+ 
+@@ -65,8 +65,8 @@ static int sdhci_brcmstb_init_2712(struct udevice *dev)
+ 	if (!cfg_regs)
+ 		return -ENOENT;
+ 
+-	if ((host->mmc->host_caps & MMC_CAP_NONREMOVABLE) ||
+-	    (host->mmc->host_caps & MMC_CAP_NEEDS_POLL)) {
++	if ((plat->cfg.host_caps & MMC_CAP_NONREMOVABLE) ||
++	    (plat->cfg.host_caps & MMC_CAP_NEEDS_POLL)) {
+ 		/* Force presence */
+ 		reg = readl(cfg_regs + SDIO_CFG_CTRL);
+ 		reg &= ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
index b0ea013..9ea05e5 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common.inc
@@ -15,6 +15,7 @@ PE = "1"
 SRCREV = "34820924edbc4ec7803eb89d9852f4b870fa760a"
 
 SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master"
+SRC_URI += "file://0001-mmc-bcmstb-Fix-non-removable-check-in-bcm2712-init.patch"
 
 S = "${WORKDIR}/git"
 B = "${WORKDIR}/build"
-- 
2.43.0

