Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18520C27C6E
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 17:02:05 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web11.14070.1718298122087303810
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Jun 2024 10:02:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c3fS8XYN;
 spf=pass (domain: gmail.com, ip: 209.85.222.174, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7955ddc6516so75792685a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718298120; x=1718902920; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9jRO2fDl0X7O41t4oNP83kDFkFkgMzW/2FyNnDNV0w=;
        b=c3fS8XYNEdgpyNSKU17k/Q9efzkvxHdsexve0RVghYEry2lydIlp67wZbFShb7xkD1
         IegJvKNeE1tTlZyXj7lKQ/DLSX+2FQGv3OWxPylf7RoGBpkS/ydaaYdqrCyyJqAOrlC0
         0b6BY1jLNeAPiCYGTSIWr5URQVgYC5uyFo7wbIpdCbYrAOnxRLhVFokPUGA5qx9EaHMo
         mybP16yh9vrLWDJXTb4KTSu81JLwzMYGN07qFWLmaz5mP5cyq7+AMuWdsIJy8Hxo5Bed
         oqFNMHoqxw/aXA9zltTD2ytIQbp2rCPSGvc/uAbgEUpEaIFlOaFqw0PSfM5samw6KHr6
         qCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298120; x=1718902920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9jRO2fDl0X7O41t4oNP83kDFkFkgMzW/2FyNnDNV0w=;
        b=IhMXwS16tVHvzohL7Siof1FUdA9/yH0ngh9KGDqqtcZ5cEDQdcywzJ7mOgn0MAM2Pi
         pgEkm6NNBK9Pq9SNxL61NjhCo5edNKh5Vy+PT3iNmyjA6hyc+ItornaFFANhP8IcDWov
         X3kwGf2ZxL0m8qttHH+mM0zMX1M2d5kFyhE5HgqhihHL161wwOH4AyoxzEXRdffjyNmy
         mKnmyfCkfBIU/VS/eOJJGN/FlP1ufbguNaQ98sTTSUPpwYX+3rHbZf8zHZUgc3X6nqU4
         FO2sdMsmFKGr9F+K5WqGovIaAI3QmX8RLjuNN++udQQZmhSv9c6NcNnsrMFP1mqq5lY+
         eM3A==
X-Gm-Message-State: AOJu0Yx1RR1QVjOrKaV90R7dI/Temab3NN6x2Jtpkrt+yYW04hIr+w+9
	ZYrolHAnY7WABBzHWCKIrpt4X7mliwKfIW/leR80H+K5pJGnfikQ4LS71Q==
X-Google-Smtp-Source: AGHT+IFTyCmWJnuDI6TLk1HTZAXKtZhyVwbM1xnb4MpUHkfgEYptKST3QdhoEKlbe2f86IkHU1C4tw==
X-Received: by 2002:ad4:4e68:0:b0:6b0:8fab:d8db with SMTP id 6a1803df08f44-6b2afcb1a1amr1574336d6.27.1718298119669;
        Thu, 13 Jun 2024 10:01:59 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c18209sm8588676d6.42.2024.06.13.10.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:01:58 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][PATCH v3 1/4] rockchip-rkbin: bump SRCREV
Date: Thu, 13 Jun 2024 13:01:51 -0400
Message-ID: <20240613170154.6441-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 17:02:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/324

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
v3 changes:
- greatly improve the commit message

v2 changes:
- added
- break out the SRCREV bump and make it applicable to all builds/boards
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


