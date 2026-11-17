Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1883.1794933337749927275
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Nov 2026 08:35:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=IlAHQ7SO;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-94999a08973so2078785a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Nov 2026 08:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794933337; x=1795538137; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IguoPgpmguD7sHLRjwuW5ZYFKq7bw8GfU23C9L9ia2I=;
        b=IlAHQ7SOtZ+yDGmHMiUudnZ4EwaOrXaMTTJL0sNMZdcAFnHE6wPZbFpiUD/N8a4wg+
         IJTg6DmEHPiJ8EgvpDeOiWrwEbtnCHKf1XxENNuWFcTJWbBPOzzVBgnP9mw92IKJ8Boh
         037Xg/ogW9PLI6pmQO8FVyhSDjPOiCHG3X1R3RPBBz7uAsTwOAK3IvRWwlRCUxlDw/Sq
         CVxZ8kk32PhPVtnzWpnJu9LQcmWccucxRVT1R/AIi28R2BdvgR4v6LXq9bHjQYhASg7X
         ZfuJh5rpfJFSQjAINck7U+mMto31TKEbRjAg/aPbqVPxwZkmxJTV/Lfju47aLfc6XApL
         Xtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933337; x=1795538137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IguoPgpmguD7sHLRjwuW5ZYFKq7bw8GfU23C9L9ia2I=;
        b=2F3s5/uqLSbstvuO5A7DCJl3t2dkHAV+XaQpPJeAwJ4E34hiors2Vw/e3B9oICzCRe
         CtnQVS6c9VUX+EvHouxy0xCPsCwXGh6Q8VRoh8XtacQj/E9f7i46VJVxfayuNh98zsJ4
         n+vwKD1on2RJ/eVOY+u70uXnregPzFDeVz2Ap5EwOzuoqFMamt/LhHXfgGpyiF47Lv3i
         1L7eHTOMw28/ew8HRsq430drtIve+0MM5FpiBGm2D1pJ6SHlHSs74OreFP0W3y4AMW4u
         nbyaDpR/54gZBAcQD6UgD1xu3jecWt3LZ9hiPBYr/prSXZlKc8yB+PH4lEX5NPuDMCwv
         G7Pw==
X-Gm-Message-State: APuU4Z9efwuSV94HqajM9WaNMKnAiYj3X7fk5/d1X/3QUiJxgEbEOltN
	JpFWf+Lh6qn+n7WCq3rWFPqZDoJqGJ2JNKtmXgEgezqB5YdFFkTv/W1uL+mCBQ==
X-Gm-Gg: AYBFou26maQioNPmefNfaeAStdCzsrTggnz/dptlbK/0+GXttqYNXJzhHFl4PdeZ3WK
	/8YuWxpllFcRI5G6sW+ildkVDSSaSmnq1Q2Uzz8STSozHbSUgArxIbG4kqi0D83bPkQtQIZDe7q
	lqh2VlWkE7GbrLiWuRsgzyyUmSHYoXlPznBioyNhoD5iIl0hXPTYJT7ES1cKanvnpGxpxld3Tdr
	p5rVyioiDuZaG7kka79fNz824MC6FsaXx209c1vG8HdewBV3GaQtU+IDO2UYVplQkYej43IkAiF
	xiwUlWRlCpZORnpUwer4vMntnL4O80Ib4cNTIrYOLGRz+LGijGsOHYtpRFS4B+LiuqATOpGEvP5
	M0z7Mjjnhb/HwECV6WpNq0xNUYw9x4a/7O28uemHalIoo2lbhoWXvCehcPJhBpt5EaM9DpwGtnI
	IRxl78T/l+FhUngssNhsgWi9riMzHlccGGXN3iLB+fyj3Fzb0b5RHABGe4sh7kMLw+cAOCs0HdG
	3bSA58BG50FZO1wNLHWV0ttxTRNziOnyyYg8rBloOqfQFhYv9ZIA6QGFX+Hi9j+9ZshHA88dDty
	yHw6T+qrbvkLjmn5ZOnjYx0BfaOU0bXSL06SwXj5ta8rP+NaeYXtOPg7iRQi97+4BaZM2vnI86v
	gJOSZKhd/ipfunLxkpTugyUG+e8NfG+aXBpwBbDQ3pE/X7GWShCWV
X-Received: by 2002:a05:620a:1a2a:b0:93f:322b:2209 with SMTP id af79cd13be357-949996e2f68mr26110685a.28.1794933335476;
        Tue, 17 Nov 2026 08:35:35 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c803fb4sm1118006585a.9.2026.11.17.08.35.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:35:34 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] kernel: restore the CPU errata the 32-bit arch removal drops
Date: Tue, 17 Nov 2026 11:35:28 -0500
Message-ID: <20261117163528.688188-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Nov 2026 16:35:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5463
Content-Type: text/plain; charset="utf-8"

The fragment that puts back the options multi_v7_defconfig only gets
through "select" from other vendors' platforms does not cover the CPU
errata workarounds those platforms also select. Of the eight the removal
drops, six apply to cores this layer ships: five Cortex-A9 errata for
rk3066 and rk3188, and one Cortex-A7 erratum for rk3036, rk3128 and
rk322x. The remaining two are Cortex-A8 and Cortex-A15 and are not
relevant here.

Found by emptying remove-non-rockchip-arch-arm.scc and diffing the
resulting configuration against the one the layer builds today.

AI-Generated: codex/claude-opus 5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
Applies on top of Andrea Ricchi's "kernel: restore options the 32-bit
arch removal drops", message-id
20261104130230.236614-1-andrea.ricchi@amarulasolutions.com
---
 .../bsp/rockchip/restore-arm-selected-options.cfg        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg
index ababaf6c911e..df3c6ddd4790 100644
--- a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg
@@ -24,3 +24,12 @@ CONFIG_HIGHMEM=y
 CONFIG_REALTEK_PHY=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
+
+# errata workarounds the removed platforms used to select; Cortex-A9
+# covers rk3066 and rk3188, Cortex-A7 covers rk3036, rk3128 and rk322x
+CONFIG_ARM_ERRATA_720789=y
+CONFIG_ARM_ERRATA_754322=y
+CONFIG_ARM_ERRATA_754327=y
+CONFIG_ARM_ERRATA_764369=y
+CONFIG_ARM_ERRATA_775420=y
+CONFIG_ARM_ERRATA_814220=y
-- 
2.50.0.173.g8b6f19ccfc3a

