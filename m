Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82337C52D6F
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 04:44:31 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.12899.1724215466808740198
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Aug 2024 21:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=k+P5TJVs;
 spf=pass (domain: gmail.com, ip: 209.85.166.48, mailfrom: twoerner@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81f86fd9305so332370139f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Aug 2024 21:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724215465; x=1724820265; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2KwI+qI/9Tn58mMLvfB7dyVcOLGR3HPQEW+Lz8D0+k=;
        b=k+P5TJVsCMyjpkpFVl1Ky4UxvD0rdQQlqqCUvLm15ktgfJNEMRyjvd5llbO9MbUD/W
         vd4UW7OJ+RrTeGhyurXE79O49ZjAJ4WeEF/Exjqqap7wGVS6vU2RAqiQryfDqnmruf5D
         Q+ekWLdE672nYFe/NahxjQuxvFC/gATf0EjZ7PmJrtlVMC6qeJQc+SMomirHtqdnIB4I
         u18/MHnh/82KcLjj9PdBg9FszxiBUJ+yucrq7zsSDH/wMovjRgnd1aANe842DEfl3qLb
         J4LkaomO9MZuWLmQQRV6+RxkSEm7YU/xIxnJGPlUoSnJY3fTo3/kA/ePNEWSxeFXO2h9
         xr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724215465; x=1724820265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2KwI+qI/9Tn58mMLvfB7dyVcOLGR3HPQEW+Lz8D0+k=;
        b=rM5lpUkuE2NVheBqs+pqN5ttsB9MFupEGM7abOM4yiTPaTKFCcn5AXanx2jIPLZ0ta
         fDpeaR5axeTNZGbk4h58dpjooR1iXSI0oik5iYyvfNxRfUH4O4plevUGw8VZG4tk5aUy
         e8U+4VU+fBUGK9JDvyIp9PjXfsK5btkQG4jFFs5dsZVqvEe+GvvzKy8fvnElLzf+Xf7a
         BSnx7fJQbkWc+dImtQ+L9iRn5WwxHlO6JKFXYimO8/fkk3cxJG3MijylT26LNxymiKsf
         32VfPjGfmnFJeNw81gIdBGKZDJaYINUbqpYgN2ZcWwBlP3vOFQYPGQTrnzzVeaCvG6JS
         N67w==
X-Gm-Message-State: AOJu0YwzqB6eX5dNXo+3T5UR5MmOTxGqhBT+ifn/PKlNA+Jb8unM2bRg
	8gRJPjrjh82tIBCFEJncWejXHkmOxU9W7gWNppUz8ssju9y9R8nHJYLbj0z0
X-Google-Smtp-Source: AGHT+IGtumWaaoEpmPvD3wQNn+5a+LaKH1zOjL6qr1q+p1Mp3mg3F/qRqOcMNbTrrMAAIFiLVEKDiA==
X-Received: by 2002:a05:6602:3402:b0:7f6:82b2:909e with SMTP id ca18e2360f4ac-8252f3033c8mr183253139f.2.1724215465102;
        Tue, 20 Aug 2024 21:44:25 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6f7b3ecsm4258575173.153.2024.08.20.21.44.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 21:44:24 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] rk3328: fix SPI
Date: Wed, 21 Aug 2024 00:44:19 -0400
Message-ID: <20240821044419.2792-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 04:44:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/537

The latest linux-yocto broke SPI for RK3328 devices. Add the submitted fix.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 ...-correct-RK3328-iomux-width-flag-for.patch | 50 +++++++++++++++++++
 recipes-kernel/linux/linux-yocto_%.bbappend   |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch

diff --git a/recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch b/recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch
new file mode 100644
index 000000000000..36071511c2a8
--- /dev/null
+++ b/recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch
@@ -0,0 +1,50 @@
+From ed875ae5b8ca511c11d227c0d9c6d2d13a2e6c15 Mon Sep 17 00:00:00 2001
+From: Huang-Huang Bao <i@eh5.me>
+Date: Tue,  9 Jul 2024 18:54:28 +0800
+Subject: [PATCH] pinctrl: rockchip: correct RK3328 iomux width flag for
+ GPIO2-B pins
+
+The base iomux offsets for each GPIO pin line are accumulatively
+calculated based off iomux width flag in rockchip_pinctrl_get_soc_data.
+If the iomux width flag is one of IOMUX_WIDTH_4BIT, IOMUX_WIDTH_3BIT or
+IOMUX_WIDTH_2BIT, the base offset for next pin line would increase by 8
+bytes, otherwise it would increase by 4 bytes.
+
+Despite most of GPIO2-B iomux have 2-bit data width, which can be fit
+into 4 bytes space with write mask, it actually take 8 bytes width for
+whole GPIO2-B line.
+
+Commit e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328
+GPIO2-B pins") wrongly set iomux width flag to 0, causing all base
+iomux offset for line after GPIO2-B to be calculated wrong. Fix the
+iomux width flag to IOMUX_WIDTH_2BIT so the offset after GPIO2-B is
+correctly increased by 8, matching the actual width of GPIO2-B iomux.
+
+Upstream-Status: Submitted
+Fixes: e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2-B pins")
+Cc: stable@vger.kernel.org
+Reported-by: Richard Kojedzinszky <richard@kojedz.in>
+Closes: https://lore.kernel.org/linux-rockchip/4f29b743202397d60edfb3c725537415@kojedz.in/
+Tested-By: Trevor Woerner <twoerner@gmail.com>
+Tested-by: Richard Kojedzinszky <richard@kojedz.in>
+Signed-off-by: Huang-Huang Bao <i@eh5.me>
+---
+ drivers/pinctrl/pinctrl-rockchip.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
+index 6a7461978630..7b7b8601d01a 100644
+--- a/drivers/pinctrl/pinctrl-rockchip.c
++++ b/drivers/pinctrl/pinctrl-rockchip.c
+@@ -3800,7 +3800,7 @@ static struct rockchip_pin_bank rk3328_pin_banks[] = {
+ 	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", 0, 0, 0, 0),
+ 	PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", 0, 0, 0, 0),
+ 	PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", 0,
+-			     0,
++			     IOMUX_WIDTH_2BIT,
+ 			     IOMUX_WIDTH_3BIT,
+ 			     0),
+ 	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3",
+-- 
+2.44.0.478.g7774cfed6261
+
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index 5528bab0d17c..509138034082 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -25,3 +25,4 @@ COMPATIBLE_MACHINE:rock-5b = "rock-5b"
 
 SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
 SRC_URI:append:nanopi-r4s = " file://nanopi-r4s.scc"
+SRC_URI:append:rk3328 = " file://0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch"
-- 
2.44.0.478.g7774cfed6261


