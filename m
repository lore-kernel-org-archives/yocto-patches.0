Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBBEE7717D
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 15:48:53 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web10.18941.1734104933109901902
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 07:48:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=idYnONFT;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d888c38841so15260796d6.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 07:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734104931; x=1734709731; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpB0FaIvfgCK44sV2ZVkZJ5vNigqy6RiqTuT1aA+IE0=;
        b=idYnONFTqC3Ap9j8M+ubJuhVzbdofBaw7z0O16lV9k75WRDZFgueUdARUMNnvcsfHF
         zKN4MAJX7F2RTSXw+NDnk2qZrAPioGJSnTkCzgaRxVSt+aVNkkX5a8jzVazXJM7wqP3w
         Io/oIWrvGDRGA6LkW9zLVp5zE6udgEIKg1Kr7vUALi+YI1J83qHqWcVpSlsI7LFXOoB2
         u6zh3BCAWz4G4Vrjmk9ScG4KzqM+yAHgyTBvoLckubKYUsKGPgvVzskt9Sj+CYqM67E2
         mMgLxpTlxWB5o0MoFNuTfUbfakr15SArrPznfPx0z9tgVd0xUjGok8mwhb3YPJX4gPDb
         sXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734104931; x=1734709731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpB0FaIvfgCK44sV2ZVkZJ5vNigqy6RiqTuT1aA+IE0=;
        b=hB1MV4d8iwZvpQj7wQSu0kmxe2fMsYdcYRgpegXQy7mJL/Ld3dPiVO51wyfS18zxMr
         wpMZZCc1IXkRpvTl+lpmx3NKtpvBgnPWh299m/88EeTaNtM6426Rtk0sSDphmgwmbWQb
         5wcrdTQGQMCFiSe1C1h0Vh3wK08Gh4x+s1jfO2BlGTh2qGfMXUU0Lcl3TMCA51IB7n0Y
         gCa9sb8BgEL3a2Oi4IZV0v0ELQOwtAgKD+9zZhYtvv2s9JLY6CgQi9x8Q3X8bv/OXC0G
         j5BWKOTl9Ycb2KOtrghiaZ56UmF2GAzFpRk/1ZQ/XN3ONqMsHuOiM1Ehlz5X9jyROh/H
         SaTQ==
X-Gm-Message-State: AOJu0YyLK/HGOxrWlUn3zPU8S89bC8ZdvkxiNg1aQwzlC/r2OcwipBVV
	EgCqbzsnrZQZopuFBwjzVqzdiuBWoJjbfEDtJZPWF/RJNe+AJyJ8yOxvLQ==
X-Gm-Gg: ASbGncuNloLC4wb74qZWClKm4RYhIxolELjVlw045lUX5z0AnP+LRvv2N56cFhEjVG/
	UiRPYqXRb8FPZmhcbVrRD2fjllKz/TLvX0nZTqdmJrGM9XEk7Ppt+/abHMl8iOULoDfAlTlLcfO
	0DMOGZWRt+SA/Q3boARiUplUdWCPRDLtvUqGlZn+emRUQDLJ/qpNRp/ExCPmyDnvij8jabnq193
	6YQz2uyaPnjYtuhvpHeyb1rUN3Yp8UfF+pOiOIwm1AvJG+btJueLswyoJv7Hf/6QgQWJiweL5Sy
	G78splVlltvGSfiB5kfdjVxc
X-Google-Smtp-Source: AGHT+IFM8bz68c+3hG/T6bPY+e3Dd6qwGPS05iNpFGT+g9uCkKRGC4Vp1BbdWiAeN3tCZ9Iop8w16g==
X-Received: by 2002:ad4:5d47:0:b0:6d8:a1fe:72a2 with SMTP id 6a1803df08f44-6dc96878ab1mr63236966d6.44.1734104930847;
        Fri, 13 Dec 2024 07:48:50 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6b2291sm92221816d6.58.2024.12.13.07.48.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:48:49 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 2/4] u-boot: use upstream for radxa-zero-3{e|w}
Date: Fri, 13 Dec 2024 10:48:41 -0500
Message-ID: <20241213154843.27592-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20241213154843.27592-1-twoerner@gmail.com>
References: <20241213154843.27592-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 15:48:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/900

Upstream U-Boot 2024.10 (the latest release supported by Yocto) has support
for radxa-zero-3{e|w}. Therefore switch away from the fork where the initial
U-Boot development for this board had been added.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes from v1:
- add [meta-rockchip] to subject
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


