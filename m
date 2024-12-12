Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3805AE77183
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 19:57:38 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web10.388.1734033456021141516
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Dec 2024 11:57:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LdE/uTQA;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6e9db19c8so72323085a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Dec 2024 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734033454; x=1734638254; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkaY4vBtfgpFjhQhx/XAnOMGccedhw5LqbY0u21gccc=;
        b=LdE/uTQAe6daGQj8Okc6pmI/kX/378Vqn84doLav+QnvASI6hypI/QR4hA5vhHd4XR
         voHcaiEnULeF0gkgZWpkB9J9GLE4p2tBdTv9TD9dEhab9X8UbeCnJtHBCzA3E3+L1UI+
         YFJ8GaYndyqa1CjpuRWK4ZNbzSJfgCOQmGyyHeLVTJq+rJfiKCehyz2pecWTPcPDxqHk
         Ov8zgRtjuBmIPJi9rI3F22hXmvyf3JKBtoOBLKfsk8XoNeMnWUhn3UTt755acoK8X+qi
         2d+eA7g9ZpD0e02kK13ozX9t6sE2PqFRn2UWqBqZn5CBfcq6KHce3JOv+museDgcu8sK
         C0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734033454; x=1734638254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkaY4vBtfgpFjhQhx/XAnOMGccedhw5LqbY0u21gccc=;
        b=d1YqfVRCnuJrcXh+cyHKngYZgjuQQjWdECWgnbheqeqXDQOrdSNb9Cz74gHWwZqTFt
         ox3PWIUcncKc5J7taVsbFfie8pM2RpVZ5fDhWo37GmrughHBYtTDGLOzJ0Y45fX8G8QQ
         yYDYz6pbEHEBAM+kGFOuFyGZc8/qDPjWNaqGytvE+711oQZsu487Yp8RjWM3bl4O+S4W
         jVz7fTv4wbZDo7TkHQPMC2EcKLzMUBjG7NXUN85qLznA35RCFYaIQRf3Q26nQ7isAvY2
         MMML3WFr0N6cGVnqedwkDhCAvgcgWXUA++fUAvkcHX7dcXDDCbaf0E+Meuel3H8kmrMi
         kcLg==
X-Gm-Message-State: AOJu0Yzfg8B7Dpl+FVEx1VWvhtmlEKVjxk/Cvl0FMQjUjn/XkUg2SdN4
	Y9G11RplbbF8TQu8MPMkS2W1+aDi1FSlGb17Wz9z/OJu9cD3wQl9++wr3Q==
X-Gm-Gg: ASbGncsqHS6kuDFCSb2j3cIE6QkggQ8Y0cfEkJog59o2O4lDrNnFOMdYbdBDLyd9Tzp
	q4iDJH+f4lyoCm+1FonpaLokQf6nqRr22XCPYFKCrLngO89RLNeIWVblOAiMrBU5qokAajAyBkP
	kcdrxyGhRZaBChfPKsaLAF8j+UB2q0qrBi02VeLtefI1VDaxuGmQ4YZPxnBUaLi1EqZP3qw9xFm
	v+J0d4P/K7PzT27CGdO+ju8Kzt7Ujh9LIisJ12pZLbBUN5rRP7fueUYRG9usW/1cfDbkPqJe0ul
	Po0mqI6sZQvbKukCLQ3bxtms
X-Google-Smtp-Source: AGHT+IECnDHLIKJu3InBvXEVEXEndPKMwHWjqtm3YddtSP1uPnl0i6pO4eA2q0lPvXAcO6CdIkr6FQ==
X-Received: by 2002:a05:620a:1998:b0:7b1:12f5:7af5 with SMTP id af79cd13be357-7b6f88c3a4emr229622985a.3.1734033454271;
        Thu, 12 Dec 2024 11:57:34 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6f16ead8fsm133406185a.39.2024.12.12.11.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:57:33 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Oleksii Kurochko <oleksii.kurochko@gmail.com>
Subject: [PATCH 2/3] u-boot: use upstream for radxa-zero-3{e|w}
Date: Thu, 12 Dec 2024 14:57:17 -0500
Message-ID: <20241212195718.25203-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20241212195718.25203-1-twoerner@gmail.com>
References: <20241212195718.25203-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Dec 2024 19:57:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/889

Upstream U-Boot 2024.10 (the latest release supported by Yocto) has support
for radxa-zero-3{e|w}. Therefore switch away from the fork where the initial
U-Boot development for this board had been added.

Reported-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-bsp/u-boot/u-boot_%.bbappend | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index 06ba6d54de8e..08e1730b5d3d 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -2,10 +2,6 @@ require u-boot-rockchip.inc
 
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 
-SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
-SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
-SRCREV:radxa-zero-3:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
-
 SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
 
 DEPENDS:append:rk3308 = " u-boot-tools-native"
-- 
2.44.0.478.g7774cfed6261


