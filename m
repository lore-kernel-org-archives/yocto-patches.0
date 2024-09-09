Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3EFECE57A
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 14:55:54 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web10.55090.1725893751808404907
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 07:55:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FsLAqzlQ;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-456954d0396so25163111cf.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725893750; x=1726498550; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPcnU7Dxl2Sxxoi8FieL3tZGd6JlC7wVLN9S+JbKShs=;
        b=FsLAqzlQiOfUh6vvBuem43S3XmzMUQSqoIkwWNURI+tYdXWLDosfQRLluACF23/WZc
         6laWhXfJ0i0Ue0hKmoBIkfEicnXrGqhNOWc+9SzSHy6Dld6gIxxEfZW8cbkwT0tscuy+
         QDrjBH6mHedR3C2SdPVi3YaADw5dj5HZMiIYR0cbsINBd6RxHfxf2UDlVZftLxUhySfb
         9IzNzyHmHbQASUy9eGBkD63oXvjEWi/F/WVAZZuUg0MKHvhojPb5O5gs90Aof658aKdm
         4p9U3ILMiHSBaomoK4wd8PjLJbQK0F99DxU4Ds7cTZYNRd4NgLnLq9h7a469811gVsWW
         k27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893750; x=1726498550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPcnU7Dxl2Sxxoi8FieL3tZGd6JlC7wVLN9S+JbKShs=;
        b=rhlmK5K7pjn5gmNRvrN9GKcx/TUHUwGkL4u8ywDrnFSIK4Hyxtcw0Mu+L+1aT19m/y
         Ntdwle9/lyzLdRE3nJuXIcvyfKPjU9a31oR7hoLtu7KWmjnZEQ99R4EWII+crKObwZXM
         b4DBF46VvhZn+upATmDdkBD/1aDdjmAAV6rl1OnYYHIE8Nc9F5foDbI+ZKXbh2pknjbf
         Ld+8JgQ/wgvOlgLlzVT82A48YADGRG1B5y+ioe28Cj5CHAgNco8I7m1liclxlyDBFo4W
         voX0w48MwqT9T9kLgWSwnnRUTck34iUqtyQ//2JZ+6C44x4/TKti8ELIuWlXW/Gwnqc7
         HvEw==
X-Gm-Message-State: AOJu0Yz5BSs68bEg6gFo65a4CbMkh2grdI71jZM0qK+PnlMJ2Lk4CZFb
	5TwqlBlGyfnGjUdEJFnwitjviE7Za2LS6F9SWZWhtgwfZqhqvgWDUmGlHPom
X-Google-Smtp-Source: AGHT+IH8bcMGlHk3hZxw4xM29f7OjgW1qKeQUTi9VVV+1JU6kLagxBE2k/uQmMPfXPEkk60+jzQzpw==
X-Received: by 2002:a05:622a:13d3:b0:43f:edde:7a55 with SMTP id d75a77b69052e-4580c6e1f22mr167220061cf.28.1725893749993;
        Mon, 09 Sep 2024 07:55:49 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e772a2sm21050231cf.27.2024.09.09.07.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:55:47 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][scarthgap][PATCH 04/10] rockchip-rkbin: bump SRCREV
Date: Mon,  9 Sep 2024 10:55:24 -0400
Message-ID: <20240909145530.25301-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240909145530.25301-1-twoerner@gmail.com>
References: <20240909145530.25301-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 14:55:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/630

Update to a newer release.

rk3568:
- update DDR init from version 1.18 → 1.21

rk3588/s:
- the name of the DDR init changed due to upstream adjusting
  the frequency of the LPDDR5 to 2400MHz to "improve stability" [1]
- reference an exact version instead of using an '*'
- update DDR init from version 1.12 → 1.16

Boot tested on:
- rock-3a
- rock-5a
- rock-5b

Link [1]: https://github.com/rockchip-linux/rkbin/commit/f02d10e468d8c783c45137d230ff33d42ca670b4
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Tested-by: Quentin Schulz <quentin.schulz@cherry.de> #RK3588 Jaguar, manual U-Boot compilation
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-bsp/rkbin/rockchip-rkbin_git.bb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
index 7929c6ac3a10..f9724ddd5cd5 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
@@ -3,7 +3,7 @@ LICENSE = "Proprietary"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
 
 SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
-SRCREV = "b4558da0860ca48bf1a571dd33ccba580b9abe23"
+SRCREV = "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
 
 PROVIDES += "trusted-firmware-a"
 PROVIDES += "optee-os"
@@ -42,7 +42,7 @@ do_deploy:rk3568() {
 	# Prebuilt OPTEE-OS
 	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3568.bin
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v1.18.bin ${DEPLOYDIR}/ddr-rk3568.bin
+	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3568.bin
 }
 
 do_deploy:rk3588s() {
@@ -51,7 +51,7 @@ do_deploy:rk3588s() {
 	# Prebuilt OPTEE-OS
 	install -m 644 ${S}/bin/rk35/rk3588_bl32_v*.bin ${DEPLOYDIR}/tee-rk3588.bin
 	# Prebuilt U-Boot TPL (DDR init)
-	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v*.bin ${DEPLOYDIR}/ddr-rk3588.bin
+	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin ${DEPLOYDIR}/ddr-rk3588.bin
 }
 
 do_deploy() {
-- 
2.44.0.478.g7774cfed6261


