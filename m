Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD98FE77180
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 15:48:53 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.18939.1734104930674088544
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 07:48:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HVeO1DKA;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d8fd060e27so16065606d6.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 07:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734104929; x=1734709729; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9pBAST7trGuS2Nhmr6GqO4ruk4zFs+Km4T/f2C0koA=;
        b=HVeO1DKAKY9b4RhX+M9e4+2+wFHHBLW0XUD01mLZLEamA/NWanq/2bAsbSWQgHBtIY
         wNNmlImBlVVKYt6+EnxvH6HNR4KTSvqODcHfQrPm1g4DhLfs5W+2xirP0n6coHFr2ZOD
         1sGYym4Ib6uWOFeEPEgz6D2WMgwqqcik3RX0NwS+eKxvtj159DLBDOY92yHG+1OudfW7
         U1etLozf3kIDaU7uZErB+zX3Nbk+rIzJic8kvwR81FmmIFcEzLZIB98NYnBo3MYL6Q7A
         xLnNeJIyNdiBzIJN87jTYXMXoAwxbZBG5UMprRFlNnqnwE4hsftFPn3YfcVXdqCZNTrQ
         BjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734104929; x=1734709729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9pBAST7trGuS2Nhmr6GqO4ruk4zFs+Km4T/f2C0koA=;
        b=jSZsyU7GzkbxkZDnAmXubkMrY4LS/gxWF6YaIYgk4w9UFo70ETyalzC+Aea20ay9iV
         Uiv0aOb2ONS+izTTd7IJw3yZuS/NZtAGhwBaxgJmQZjPHLm41YMdSQhKkZwoZpOyI/mH
         knQS+eEWVk+cLuTl08ULxe30kbq/Rm2P5b5A/euixJIBiKVudniaiLCy+4IaVWUHDxUl
         7ouaFgxz/LP5ZDpx7qu5Q+eFTy9XDJT6VnCc1t2m98tZC/wMSI6HWmnU4fgU1+W60IVK
         czePryYrQ2vwDnFEbqvBdjJMh1AqNFX92js+NJhszmuSS3IbWAQCs/7TZw1YYyejMXQl
         ihLg==
X-Gm-Message-State: AOJu0Yyh/bM8vNOZzEA+yApqf0whgwHSmqUHExW91gE/WnuxqWEZu4IQ
	BisQwDXRoTcRyu0Yuq/b1fmDkuhcf1rbMmjvJX8+EpZBmixfTPlaC6e3eg==
X-Gm-Gg: ASbGncvPHeRF3maC84EOylc++jOpGfF2Qcyk84b85e63wyNbi96zhYWjpdIcEUzsLPt
	yQEcEDsI+kv8qgb/xj2N7wJ4b9tU9nQeYw6ISqL0Mr/ek3+OGD4n1lqZImG1Wux7UWgtzlX3lFO
	otfvyigoqcLwqEhUBTqtVWDK+bHdAgK2Pakt6JwwCcd2FvVVPUO79hiwowOaOBNjVWc1hXYCtIs
	mH4+IOAbaMZCssDEOWzobgvYbvLsLMNLREYUmeLbQDjiG8QghB6RTVCAXtw5HPJl7jN5i8nhg5F
	3ruZKLSUGGde0fdyz947F+7V
X-Google-Smtp-Source: AGHT+IElmiaFeM9Am6Vrq+YNrgTTuQKGQfPzTiuq4RHB14+h0E7GoOrGR2tVvbwfYZWJalgvW9Bczw==
X-Received: by 2002:a05:6214:dc2:b0:6d8:f611:3af0 with SMTP id 6a1803df08f44-6dc968722afmr52233346d6.48.1734104929046;
        Fri, 13 Dec 2024 07:48:49 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6b2291sm92221816d6.58.2024.12.13.07.48.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:48:48 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 1/4] u-boot: switch to upstream SRCREV for rk-u-boot-env
Date: Fri, 13 Dec 2024 10:48:40 -0500
Message-ID: <20241213154843.27592-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 15:48:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/899

When the rk-u-boot-env feature was implemented, in order for it to work the
build needed a version of U-Boot that was slightly newer than 2024.04 (the
current release supported by Yocto at that time). Now that 2024.10 is out,
remove the SRCREV pin since the necessary code is now part of this release.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes from v1:
- add [meta-rockchip] to subject
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


