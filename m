Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA527ECE564
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 04:42:59 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web10.15731.1725943379266087114
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 21:42:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lk644RGx;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4583083d05eso10963841cf.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 21:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725943378; x=1726548178; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5yoaWlCSkZGYNjhZjU/g1C2dttmxi893u0wBc0rOx0=;
        b=lk644RGxKPa4QPASHVSZJPuAJAvhJvdoVVskGMdqjuUiRXM64cPD52plZPXkZsVIby
         2HciWVYYo3JgBtBd2Q8+3TbSg6WQsBWOlODfeUHrNqyaCb4fWUY/lBhw4TDkTWy/7HN3
         2NupSK0Qv/lbDH9ErZvaRkFKzeV8x7Ow55Rh3YuD8e62cU9ALi68KeUtlQvNN9K0y6Re
         vgRWRmrmGG/HiYt1k4RefS8C0aTCV5ZQ0M+H+pm/GSgxBV4qXffuhjBoWBmhOcuaVk+8
         1DIfKpihdCjpsolIxdVpGPyL+CJAGqpMY9nYfHLdtJGhlD4NpvLId1c+perb/Z8T72rj
         sW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725943378; x=1726548178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5yoaWlCSkZGYNjhZjU/g1C2dttmxi893u0wBc0rOx0=;
        b=b/ZSGVhGu5GEVcth5Lh7ncrwFdFpCuqDOjPQmS6ze3ed/arhFxMf4vGpopK/sT+dQu
         urzsvwU3L159jM7XYTr2c9EqWD5yHXVs81fF5s62X7+WyASKb0FdN1viUpYdZ5zx4Le2
         nsDUqXaphOR8vTgEioVFFgHOqIAaOvQ+lMNhweveyvYOBkysi1xw9AGcAexZXMeAknJZ
         q/3duttWCFvWgKUQpYU4nAWnHZcaVJdyUfuhIVi21OZldZa5j/IeO7QYqjW5RzLMUNF+
         jfVIQfZorRDiQDu7wVTKFf+XarlYHfvaxVu7qmwvSdjyNVLV+iPvbwnt/6G1YIzBkz6D
         Mqwg==
X-Gm-Message-State: AOJu0YypQrmZb6MNP1zzOO0+SrQjaC7eLqqFuGYCL4BQ7iLhAP+CiH5a
	W9CTKvFoNRQ51Dsai8VxqGzL8B0Xf/0cesPIjaGETLDn9p6QRVBGSYA2fw==
X-Google-Smtp-Source: AGHT+IFMZ7EMtqh7JjJiTYTaC/PlY4XsqlRrhLSpy0+9dR5OHGrpzVLsFMOGPwYJ8evZpGd1Hn6OjQ==
X-Received: by 2002:a05:622a:1984:b0:458:3eb3:7485 with SMTP id d75a77b69052e-4583eb37766mr21228611cf.45.1725943377437;
        Mon, 09 Sep 2024 21:42:57 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f94546sm26206911cf.84.2024.09.09.21.42.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:42:56 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] remove upstreamed rk3328 patch
Date: Tue, 10 Sep 2024 00:42:47 -0400
Message-ID: <20240910044247.31838-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Sep 2024 04:42:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/638

oe-core recently bumped linux-yocto to v6.10.8 which already contains this
patch to fix the pinctrl driver for the rk3328-based Rockchip SoCs (which
enables SPI to work again).

oe-core: 48ac41fdc02c ("linux-yocto/6.10: update to v6.10.8")
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 ...-correct-RK3328-iomux-width-flag-for.patch | 51 -------------------
 recipes-kernel/linux/linux-yocto_%.bbappend   |  1 -
 2 files changed, 52 deletions(-)
 delete mode 100644 recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch

diff --git a/recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch b/recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch
deleted file mode 100644
index 08f218ec6c6a..000000000000
--- a/recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch
+++ /dev/null
@@ -1,51 +0,0 @@
-From ed875ae5b8ca511c11d227c0d9c6d2d13a2e6c15 Mon Sep 17 00:00:00 2001
-From: Huang-Huang Bao <i@eh5.me>
-Date: Tue,  9 Jul 2024 18:54:28 +0800
-Subject: [PATCH] pinctrl: rockchip: correct RK3328 iomux width flag for
- GPIO2-B pins
-
-The base iomux offsets for each GPIO pin line are accumulatively
-calculated based off iomux width flag in rockchip_pinctrl_get_soc_data.
-If the iomux width flag is one of IOMUX_WIDTH_4BIT, IOMUX_WIDTH_3BIT or
-IOMUX_WIDTH_2BIT, the base offset for next pin line would increase by 8
-bytes, otherwise it would increase by 4 bytes.
-
-Despite most of GPIO2-B iomux have 2-bit data width, which can be fit
-into 4 bytes space with write mask, it actually take 8 bytes width for
-whole GPIO2-B line.
-
-Commit e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328
-GPIO2-B pins") wrongly set iomux width flag to 0, causing all base
-iomux offset for line after GPIO2-B to be calculated wrong. Fix the
-iomux width flag to IOMUX_WIDTH_2BIT so the offset after GPIO2-B is
-correctly increased by 8, matching the actual width of GPIO2-B iomux.
-
-Fixes: e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2-B pins")
-Cc: stable@vger.kernel.org
-Reported-by: Richard Kojedzinszky <richard@kojedz.in>
-Closes: https://lore.kernel.org/linux-rockchip/4f29b743202397d60edfb3c725537415@kojedz.in/
-Tested-By: Trevor Woerner <twoerner@gmail.com>
-Tested-by: Richard Kojedzinszky <richard@kojedz.in>
-Signed-off-by: Huang-Huang Bao <i@eh5.me>
-
-Upstream-Status: Submitted
----
- drivers/pinctrl/pinctrl-rockchip.c | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
-index 6a7461978630..7b7b8601d01a 100644
---- a/drivers/pinctrl/pinctrl-rockchip.c
-+++ b/drivers/pinctrl/pinctrl-rockchip.c
-@@ -3800,7 +3800,7 @@ static struct rockchip_pin_bank rk3328_pin_banks[] = {
- 	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", 0, 0, 0, 0),
- 	PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", 0, 0, 0, 0),
- 	PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", 0,
--			     0,
-+			     IOMUX_WIDTH_2BIT,
- 			     IOMUX_WIDTH_3BIT,
- 			     0),
- 	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3",
--- 
-2.44.0.478.g7774cfed6261
-
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index 509138034082..5528bab0d17c 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -25,4 +25,3 @@ COMPATIBLE_MACHINE:rock-5b = "rock-5b"
 
 SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
 SRC_URI:append:nanopi-r4s = " file://nanopi-r4s.scc"
-SRC_URI:append:rk3328 = " file://0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch"
-- 
2.44.0.501.g19981daefd7c


