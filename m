Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED710A62CB
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 13:07:06 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46937.1774530423126760475
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Mar 2026 06:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=kTxokkm6;
 spf=pass (domain: gmail.com, ip: 209.85.217.48, mailfrom: twoerner@gmail.com)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-60319f32a59so229693137.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 06:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774530421; x=1775135221; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZRv1RYoUZ8ORxnAmPkVM8KVY0S1HlChOm+fMgBkC8Y=;
        b=kTxokkm6hhaKMR9CjBV8g4MQCL2rCY4rihnB+Y14AJDb4vCu1059YDgNi/06L1swok
         Q7djcnwDrwzUAKqzfNRU3hL0a+IKw3aPxgT/ITELHKqIcA5DZnmfCP5ObdvFN7rKGp6q
         h4quoiFw613fi0rUOyoqE2+LrwpEUt3c3N5mzL6iE+8Iq+cd5aQSxKW82Uv6fDXgcXvG
         5ftFA6b1fvixUVU+wZYmQ0HQIs2qMEmAILffry/90TtONcVPLhtwPR8KsbJs3dXslyrd
         dJM6a+i/HZOLxaivPb1nDs09pC4vbkqfLxvX6V6PiVEQ4gz4+l8QPjtiB60H04eVxP2r
         E+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774530421; x=1775135221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZRv1RYoUZ8ORxnAmPkVM8KVY0S1HlChOm+fMgBkC8Y=;
        b=BRrG3tAmORa310sXQ1dWMPAqltia6b0tv2f06jyq0DQ/ZfSZWaHANpVXgbgKy6YsAA
         3dTt+fUSDAelMasYuDzVNB1jHwn5oi3hvgSDpNM0hkf2n5F6pqn7SB8U2rwBQAWvRykI
         WG6T7xl96VblRq+xS7pahJbwfE7JnxFvyH+acwPN2n3cX89y4mBUDA/bDdn0sN9MPx/z
         mA2m3XWQkB4BVx1RbX1/N49XZLoV5bUMF0WDBoIK3RkfdOcpAkQIIGnJMCQTW7ffkvQy
         4haoJ/jZq/PA0lC2WqLO1DvcCxcIaLox/w/kRogpF+rHxzmJs/Z+Nwp6GF8xd0fe0bKQ
         fmxg==
X-Gm-Message-State: AOJu0YyiOi9UoKIWDwQS8zn61ilUdM/0SYK7+ko0Ep3n8rfo8d2688CA
	haWqo7ts5LMoF64x0NHyXjxDH7j44BakYh+D6RUk+KyG3qwD+pAH/8u0louN3g==
X-Gm-Gg: ATEYQzzqWdvDKaPllwX4cscdlPUNEa0eHETcnR4yb7ktUy6yMN89ZsYDxicJ3Z9R15K
	Zgc0hvZxDBUX9GNgpiYIB5GNdrHDp8ffVMoWgHDqfLVOm0bolKPljFEbCCOnRel4TzWDd3yvZo2
	Tp7NVmDliqomK2nM68JzHaHXEHnv7AKpVeMcGnurAVUm4dFYvsOGd4bWAUMzIEVrrVDziYoxM+O
	zTCaRgE7iyyAIPkq+Hhb6wjKmuNoj+xeZwTeQEwC7m0G/NNXDkmILC81jyIC21FnRgkTK/YEynu
	I8KlE3uTjMtihTibKk/yMYQqO4S4FiWgP2M8bz+fUZcFKr6wGoBQmDI3h3zUQMOE/AUugcE8XnA
	n8zn9u2Vra8a5vtgXccvu9TtrjsGd/Vkm1Fg1/3afPvmC82YV8NGsJgf3fhmrbgw3shjswUvSC8
	xaCsB1sjUrDwpMJdvtJF3VZUPGjum0+tHGweGIeNQv48nngVTtcUASadi4sWgTDYCf9Q==
X-Received: by 2002:a05:6102:b:b0:5f8:f6f3:84d7 with SMTP id ada2fe7eead31-60379042dafmr2601501137.13.1774530421382;
        Thu, 26 Mar 2026 06:07:01 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a24fd9sm23563706d6.25.2026.03.26.06.07.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 06:07:00 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] add kprobes for 32-bit kernels
Date: Thu, 26 Mar 2026 09:06:53 -0400
Message-ID: <20260326130653.478746-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 13:07:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3555

While building the modules for linux-yocto for 32-bit machines, the
following error occurs:

	| probes/Kbuild:236: CONFIG_KALLSYMS_ALL is disabled, therefore probe "writeback" is disabled. Rebuild your kernel with this configuration option enabled in order to trace this subsystem.
	| wrapper/kallsyms.c:20:3: error: #error "LTTng-modules requires CONFIG_KPROBES on kernels >= 5.7.0"
	|    20 | # error "LTTng-modules requires CONFIG_KPROBES on kernels >= 5.7.0"

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-rockchip.inc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
index 6c62e849834c..4e67ff14f6e6 100644
--- a/recipes-kernel/linux/linux-rockchip.inc
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -34,5 +34,8 @@ COMPATIBLE_MACHINE:soquartz = "soquartz"
 SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
 SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
 
-KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
+KERNEL_FEATURES:append:rockchip:arm = " \
+    bsp/rockchip/remove-non-rockchip-arch-arm.scc \
+    features/kprobes/kprobes.scc \
+    "
 KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-- 
2.51.0


