Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F983C25B7E
	for <webhook@archiver.kernel.org>; Wed, 22 May 2024 23:08:27 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web10.2939.1716419300762474563
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 May 2024 16:08:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HBcvNH1Q;
 spf=pass (domain: gmail.com, ip: 209.85.128.176, mailfrom: twoerner@gmail.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-622f5a0badcso61404937b3.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 May 2024 16:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716419299; x=1717024099; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmpwtWyenmFuHWCL32BFhZ9+MfVY4WDq5iib8a33QWs=;
        b=HBcvNH1Qio5sA9UEu0B3huJGLkJqOX+1w/SYJ81vEQHPot5gbA5MWHrnB85hMHVg0m
         IrvQfF2gZgXj9j7XJ9X+W5809xUPSZaN1WDj44I0EumP6STs9SzGarycEMDsOWZmU2zp
         uznYgf7foI2iwSazUXKPEND94yneKR/ZgiELxjZiKgjlTEqA54KxnLhmtQCwGq3dglcE
         B+QHdEilHR3oEfFXZcD1i1fYKLuYWwQJEU89dWM5uEkJTwiIXxLyvr/8w5/f01+UwkSr
         8xoqkq93E07Tcdo2p+vNl0xq0ye1qQAa88HpGB5kB+CBES2BHaOchRle7a9L8ApEfNtF
         22CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716419299; x=1717024099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmpwtWyenmFuHWCL32BFhZ9+MfVY4WDq5iib8a33QWs=;
        b=bzvKCu0OomSq1IGl//cZ/4nnqvV0xrwPLJlZ3MFWVo7jQSPuPX7Hkx2LGR/9Hiw+MG
         fkT8o4tdDQWrQw28i3iRdrSw3OnnDAcK/9P/MK12GPqcxl+XVJ1bIk0yAFavZ8nIpTou
         FRyGbLawnWhw2aX293/TbbcM8MHLi8gln9uopcVHiXyWH/YJ0gevdFSvavqX6JAKw2WD
         XyZweb06Ld6bFq8/UNJhNmgdAk2/dP0cdAbUnoGwy0Bosg+Wds8bJdQ9WE0XvaDsMYK6
         miepReujFh3JuAVFP6OgPfUgGNMPxPCCq5UeEcP5CUo89SLsPM4vIogSaKNgE5tNIcbL
         CHrw==
X-Gm-Message-State: AOJu0YxdynDkpOEJD5IBwmOQjCTDU1JRcjJr9Ec0Nr59MnAuQ8+Fpt2p
	dfxiueHoiRiqL+psXfZStfdX960CPkSGjqkHmyvmPdsUQ8Kdj6JeSXFzVA==
X-Google-Smtp-Source: AGHT+IHsyFGwRQgoG195OaFKdBnW/ClG5JEDlRcVdxVKig1ehWS/5ggh9tF1AOUyYy6eSNQW+N3mEg==
X-Received: by 2002:a81:ab4b:0:b0:618:8e3e:8675 with SMTP id 00721157ae682-627e46d4287mr37374577b3.22.1716419299245;
        Wed, 22 May 2024 16:08:19 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab908a01b7sm743886d6.11.2024.05.22.16.08.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:08:17 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 3/4] u-boot: remove upstreamed dependency
Date: Wed, 22 May 2024 19:08:07 -0400
Message-ID: <20240522230808.14409-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240522230808.14409-1-twoerner@gmail.com>
References: <20240522230808.14409-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 May 2024 23:08:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/170

The dependency on pyelftools is now in upstream oe-core making this one
redundant.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-bsp/u-boot/u-boot_%.bbappend | 2 --
 1 file changed, 2 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index 33b521021a1c..5c9e442cca8d 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -3,8 +3,6 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
 SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
 
-# various machines require the pyelftools library for parsing dtb files
-DEPENDS:append = " python3-pyelftools-native"
 DEPENDS:append:rk3308 = " u-boot-tools-native"
 DEPENDS:append:rock-pi-4 = " gnutls-native"
 DEPENDS:append:rk-u-boot-env = " u-boot-mkenvimage-native"
-- 
2.44.0.478.g7774cfed6261


