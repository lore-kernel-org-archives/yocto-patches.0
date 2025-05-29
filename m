Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B63C5B552
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 02:42:13 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.12373.1748486525392667092
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 19:42:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Rgre8Ton;
 spf=pass (domain: konsulko.com, ip: 209.85.214.170, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e16234307so4344215ad.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 19:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748486524; x=1749091324; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gky7hq0hMD2rSCMS84DYtN2E+ae7KB2HBXN4sYS0RK8=;
        b=Rgre8TonBweqcM/Ekg0aq9+eEEDScjgxOoJdVaSEg+Mq99M15hGIE4gH6V6Zgvww0J
         PJTvkKfAl1sHl72U7l7z9MLnFOWT9aGoL8yst6rgFO4LJ5k9IuKhH58kxEUz2r2NmltN
         i23Glyuu4inYstrPXSYB467wdgQtx5NA++v+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748486524; x=1749091324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gky7hq0hMD2rSCMS84DYtN2E+ae7KB2HBXN4sYS0RK8=;
        b=i92zK/aRRcN6ppI9JkCVwHCCb8VrWT6BZrQg3cdz5HFNuGa8oV9/WvVvokgz+y1JIl
         jJ7AD1mb0n2/CM0IerCzBOpi/1H1XhXH+niEYPsA4cJZHa1sz7dPoBp8gEG8zu3wDyq7
         AR/yB2TcZlBCcHxp34y7SrAfhA3g95HGNmKy/q8otW2aPjwA/kC+PdX26cpisNZfNGEp
         6mThIvARTCiavvjSObhXG4fd0QgF1ggO+V9LGcQs9KVZiFFpZOxKmtv6IcVUjePA0Tj4
         ym6lE8Vlk36Grc9oBQ3+8f5+3cDO3yNdM1aQIa0KT3DcNUsV/634KdUiGXjYIoSjDssy
         Qjuw==
X-Gm-Message-State: AOJu0YwIwrmd7DicqF4ltdSZ77mtlBtRoToSqxINsMSpNhz6jE3T5oi6
	leMf5xJJqlrr2RxgSBYSLoIoGVJhkYOy3vByB2YA6BuCTjowmVgc26Axcc8ZIEyQ+VLULR8Z3AA
	uBQiHM8IPig==
X-Gm-Gg: ASbGnct/OvjIVoPSfvofD+/mhzvQhguupb8/gNCKocCet+bPV+4yvKekmqWr64ZilKW
	/9QY/AafR8LvT3LTZRQvXKDOv837LE0hmKWl6o07eptn+JpMkfHn03s3u/zd/egLRpBlDrRvnYi
	C6nPu+o9DuoWuo03ONZKIpibbBwRry5qvHIh+5VIbod6GXyjv4vLcyW8ZSSwOIBn6J0HLtFjPWo
	nS3DCxXhjNGMncR4vFFcMBvv42MZXBbMUoUVYAMYGGYJ7sILQczotdi8fgaSkyaHmfzkkIjcOYl
	PizvAv9Uoubd90TIthmVU6BfsJbuUq2Byc7LYUjLqbI8prZN+pgkLQizSMt9C0/I8kIOg3Akdkq
	RU5LxWOXccmP0BTE=
X-Google-Smtp-Source: AGHT+IF4iG4EKwrDpbFWmYCnhbXJCcxuMeLFjq/9suotXTdFW2g0YFjcVy35juuTcyj00+YPVfwMWA==
X-Received: by 2002:a17:902:d50d:b0:233:d3e7:6fd6 with SMTP id d9443c01a7336-234f6a08ad2mr29560745ad.19.1748486524052;
        Wed, 28 May 2025 19:42:04 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc8880sm2876045ad.22.2025.05.28.19.42.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:42:03 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 04/11] u-boot: Ensure we use BFD as linker even if using GCC for it
Date: Wed, 28 May 2025 19:41:31 -0700
Message-ID: <11e70fb42b3ad26b582a17291458a26adc7c7bb6.1748486276.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
References: <cover.1748486276.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 02:42:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1588

From: Otavio Salvador <otavio@ossystems.com.br>

If we are using 'ld-is-gold' as DISTRO_FEATURE, the U-Boot Makefile has
mechanisms to ensure that we use BFD as linker. However, this does not
work for the GCC when it is used as linking tool.

To support that, we added explicit BFD use whenever we have the
DISTRO_FEATURE feature enabled.

(From OE-Core rev: d36ee7a87c0d89b2820eea4bfcdae342adc75019)

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 recipes-bsp/u-boot/u-boot.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/u-boot/u-boot.inc b/recipes-bsp/u-boot/u-boot.inc
index 6f1170f..9b612e1 100644
--- a/recipes-bsp/u-boot/u-boot.inc
+++ b/recipes-bsp/u-boot/u-boot.inc
@@ -9,7 +9,8 @@ inherit uboot-config uboot-extlinux-config uboot-sign deploy python3native kerne
 
 DEPENDS += "swig-native"
 
-EXTRA_OEMAKE = 'CROSS_COMPILE=${TARGET_PREFIX} CC="${TARGET_PREFIX}gcc ${TOOLCHAIN_OPTIONS} ${DEBUG_PREFIX_MAP}" V=1'
+EXTRA_OEMAKE = 'CROSS_COMPILE=${TARGET_PREFIX} V=1'
+EXTRA_OEMAKE += 'CC="${TARGET_PREFIX}gcc ${TOOLCHAIN_OPTIONS} ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', ' -fuse-ld=bfd ', '', d)} ${DEBUG_PREFIX_MAP}"'
 EXTRA_OEMAKE += 'HOSTCC="${BUILD_CC} ${BUILD_CFLAGS} ${BUILD_LDFLAGS}"'
 EXTRA_OEMAKE += 'STAGING_INCDIR=${STAGING_INCDIR_NATIVE} STAGING_LIBDIR=${STAGING_LIBDIR_NATIVE}'
 
-- 
2.43.0


