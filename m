Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D76AC27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 13:36:13 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web10.8774.1718285764720813360
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Jun 2024 06:36:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kyEsnm+h;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7971a9947e6so54290985a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718285763; x=1718890563; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=13AnSvZpg0mUrWbNTmXrUf+oRtAgYQBbMiNFSqDz2eo=;
        b=kyEsnm+hS+BsskcqE0fAW9MtTnV8fygq9A1/O60QrwpZDqA6e6UwFI14o8A5I9I7FH
         LVYFtFjrEB33YHjIWJhGqb7KdhsWoHRKVKzgBTTZ03d928biT9phwDR1uvrg6G4dYh4F
         j1w6lEqsx+kEPfiazWCd9CCzZYroGsIqfLT8blDvHMsvW+mAk+YDw7/01nZwoLxYZMlg
         J2mwYsAafiMd5Aya+O+7i8LWOIvEeKNccJpCzzC2YVTJ9jufe9zN9Mf0XGGnvKAeGna1
         Iqbvo6Wzpf8mD3BTocqk4XBamvmPssmTXdy98msDQlBbAIBj9I3cs2NKH4ziL1umOIw3
         oRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285763; x=1718890563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13AnSvZpg0mUrWbNTmXrUf+oRtAgYQBbMiNFSqDz2eo=;
        b=uZgoe3snajSgEusdx0aAvMhYGQyptAUcvN9O+E9bnr2YfVigXuRdytfFDQcpmaLXRp
         Q8iOK8/7wSYZ61t0/VQ5QdSxu6QBRPjrh9yZHgITGdDdWkiQ+RUt9CoCItsuVsn3n5qL
         d4olNLRi/lptT07kstz6QbItmfbZxjCqcK8KfKH/WxhI07GoVYCE0jpRhYt9fgEZ5ONd
         ktk+zOWy2qs9P9w4g5d7lTpV1fwVK12yG2p8xTA9y6FD1IR1ordtdBOW9PuPBnwZLh3H
         ufNpMpU9OzDH7tlh1kNQgLjBsBvrKdPc5SbbdStgIMOG4lZWZwoJ8DQ6XiGm0EyF2Xwn
         G7JQ==
X-Gm-Message-State: AOJu0Yzh7VKNdWVroGcqGrAKdBVEQCF3w3sjJKZ23yE3Ny9gDXVuMMJH
	qMQYUqw3t1lGxhISgk/k7xGZg4OzPVK+sMg2KSt9/knzKngMSLXDaK+dMQ==
X-Google-Smtp-Source: AGHT+IHJQ5BFuhwAgMaw2V/jFCd1e3G3J6JayPNar8vq2+EEf+LfNm3qPfQQfii4jgqoG+1CA+T5ew==
X-Received: by 2002:a05:620a:4094:b0:790:b658:b924 with SMTP id af79cd13be357-797f61729f8mr536361485a.51.1718285762710;
        Thu, 13 Jun 2024 06:36:02 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aacb20d2sm52611085a.9.2024.06.13.06.36.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:36:01 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 1/2] rockchip-rkbin: bump SRCREV
Date: Thu, 13 Jun 2024 09:35:43 -0400
Message-ID: <20240613133544.21164-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 13:36:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/318

Update to a newer release.

Boot tested on:
- rock-3a
- rock-5a
- rock-5b

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
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


