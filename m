Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FD8E77182
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 19:57:38 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web11.362.1734033453646260649
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Dec 2024 11:57:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MLRzuhEN;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6d63ab374so62473285a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Dec 2024 11:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734033452; x=1734638252; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KzjdsRqPNEggxleqL3KH1oXoXOsqqkTYH2bQzWkZ88c=;
        b=MLRzuhEN2RwnDHDt42w6Qiv3vq17YYhzbiuTD6eXGNfhb7MBAEehmBBQwUyR0VMZww
         ghIv8+Pr/TvMowcA1SUgMuPApIfjiXh8G+ueNOKylqHExdH7dpl35We+AfW+Yeb8U1we
         re+ctfernh/PLKXZV1DAEnaO93mBvuUAfh37r9Lj0C+bTdbnOXxIiU6n3iYTRMzWa5rq
         qh4+e6kxrBoj3uzBHY3ZLu0/JYvB/5YKnwdkNQBumJLxV6O9wrEPsYBK7IzqI5gM+BNR
         +lbKxm2nKv85TI0UvDapYtKQ8es/0Bkn7vIV4uiptJY9ueCpP1MSuFWeFyElGiDFPkI7
         rr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734033452; x=1734638252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzjdsRqPNEggxleqL3KH1oXoXOsqqkTYH2bQzWkZ88c=;
        b=RnxvO3yeERjtHfyOJ6H7/DZTBJD6GnR1lPQYx2L6yCoyGilMulKSmJ4P4OdRWap+L4
         1pubrirp3fooB441BgxY8w+kxtczjd1xMYXBxC3QiBaJNm1kCsjnsTAKaUHxkx/fqEWN
         2CcyV3Cgf1IDZDuaL0DfwRTjzDWPUHzAwMoleXU+5MPcpzHe4Kp82sJiq680/GW45t/0
         +ZstUc1J0u1yG73doH/RQ40JxwhnGSeEZqhDDyoTKUSj9exXO3HrdSXzjQrf+PCJlQVk
         cajx2n0OHCvgmZAhRyszfJL0AU7wtlUD0U+xfbloy1thZEf+00bSHMrFwxzNAk3evTNB
         r1CQ==
X-Gm-Message-State: AOJu0Yzyu/vpD6uJ+Y1vybUfDTZ/hDwsN7cACy2do2TR6hWvdP2b3Q/B
	zjQuoCKOohLRXNhm7QJdV2h+LFIxmxOtouiT5QvXCQA7BCBMgp7kXqXt2A==
X-Gm-Gg: ASbGncs9PN0xg3h2WuVDsTGqJLD1KM0JD7va6U5axh3zr1xuCGo4rs3ULG9e1BVFq1s
	VFe8HrI2xKzPFXpdtW9ntO0LVQTtqAXTWCf32genKyVv0bX+HYhdCy+MqlPxipcF8Ig67D/BtUG
	Yod8+BCdpJF03LgzKquwQI/sZHrxuNz3IQC4n0jiTMY9cAJHiubdCBiAx6jnIqsmyVkZDjAvX3D
	lLn/t0WwoaRrqI87WmGHRU4Ylo7PlcBWf20Sqz4EcBddietRijZRkv1zYQUQRB7ygNCBqgv0yNV
	1HYR2/+nc722xhtn3gmpPc4r
X-Google-Smtp-Source: AGHT+IFS3AUoO3QOQFtRwopXrTPXkEeKROmR/ljeMBOZ5c5FwE7eZBXz40acHxug+hLtn8HfbcSamg==
X-Received: by 2002:a05:620a:2451:b0:7a3:51ed:38b5 with SMTP id af79cd13be357-7b6f87cb04emr284337285a.0.1734033451984;
        Thu, 12 Dec 2024 11:57:31 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6f16ead8fsm133406185a.39.2024.12.12.11.57.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:57:30 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 1/3] u-boot: switch to upstream SRCREV for rk-u-boot-env
Date: Thu, 12 Dec 2024 14:57:16 -0500
Message-ID: <20241212195718.25203-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Dec 2024 19:57:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/888

When the rk-u-boot-env feature was implemented, in order for it to work the
build needed a version of U-Boot that was slightly newer than 2024.04 (the
current release supported by Yocto at that time). Now that 2024.10 is out,
remove the SRCREV pin since the necessary code is now part of this release.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-bsp/u-boot/u-boot_%.bbappend | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index de7024545841..06ba6d54de8e 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -7,7 +7,6 @@ SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
 SRCREV:radxa-zero-3:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
 
 SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
-SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
 
 DEPENDS:append:rk3308 = " u-boot-tools-native"
 DEPENDS:append:rock-pi-4 = " gnutls-native"
-- 
2.44.0.478.g7774cfed6261


