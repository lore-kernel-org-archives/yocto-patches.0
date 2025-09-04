Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1701CA1015
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 13:27:30 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web11.39243.1756992447027909868
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 06:27:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HoI65IOH;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7221ce7e814so7435596d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756992445; x=1757597245; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aknLou8RFlFpiEhx2W/gcYRHqi+quwR5pxVF4dB0q4Y=;
        b=HoI65IOHZQZ/zN4Y+clkwEr+hxXliQFTFuj3LWKW1GTh8Z24l7psfgEj896U+xSSim
         LhcZBJZzyntDuaJdj/dCXLvJqRqpcM8qka8vgEGfcxW3CuJhihvszTuh9Bp/HyT7S7z4
         hNWTElVZX4m/AbpiET8jTyPETkPOmMM6BvHmPwhnRBS6BUI25SZkf9mEMtygL6Q9eLpW
         hFV6cTwPfBX5e5hS631R+KDHRybl+9MkYvqvH71kM4r3A9os39AijX1v1nZiRFf0VzZ8
         tUZEkxaTPEh6cFOGpC4E4THO3kGrx56OP9MXyrYW82e6qGXhfuPM42WMFOYGS7Fr4Vec
         Kh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992445; x=1757597245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aknLou8RFlFpiEhx2W/gcYRHqi+quwR5pxVF4dB0q4Y=;
        b=pJwArDivYYkAbJDzYDlQsgeNs/Xl/mwTtQJjRUFCJeGcAQJUzut1GesP6SW2soUsH9
         NYn/YVW2uiFcS6BsUUnoZ6i2vfBYQXfPjlNiVUiiStUa+YYIi6qjzZxS61IZIjxm7yj+
         iCkXe+WrTCgNf9kQcdhtaVcT0fvnD539mphxPTcmw9/hvuk+jqqXoSv2iBElu/yOARHk
         +BTKJ3SQU+jjk0yVUw5/hVh9Np3zXl3kVmpqGOWXOdd03wx1IfKQCZwKbVrsDUiHBLo0
         FtPyoU4OD/mGZHsxtVZ387Xdwl/EVS8fV3nPJk1iMjSmGThcOL3JyAo5Kbptg7JIpxm7
         gfGg==
X-Gm-Message-State: AOJu0Ywz5wblpEv06HH00by/5Y5o2Zd6CDort3livmmsSh/oi6JX/298
	rqCgt9Si9Gyoq5ptGLVCnh5GqFVCzV14jAv40Mwq0uBSPILmrEcvvi0Fcwd9gw==
X-Gm-Gg: ASbGnctmWtcbCrko0hUZnDN9Hf2JBMq+4BkIsncIRhIS8eaTTnJjOZoQjPb+f/b810G
	ipKj5JhMbbbmeW/h/r9BCW19pFGh7mZWwogWUJ79zuQZ7z54F3Z3erief1PwOYDMEpvUQJiE1gk
	N5udKs/5O9cRU7rL9yV0hlBV6Aqw8TyFZL3DLKhv4Aj7NvmZ9AXdAxTh77NAqod3HTcLMQVnCue
	A96ZsDWs/93MzO9qOSfwqxj2voJrJjsRXfHIF7qM3+QCHi6ihaBP+PJnUhU9tP6tQSz+FU5eP4/
	gGaJt6jEo6HWL/CdhBXermieLlD4+MFKlB7MkSZpZWQvyt+YYd7fUxgFOmCXPfSupsjaSx1Tdc/
	E3nPXNqBmt8B9A0JHTTL3Cc0IC+yVD+gKF+VTymmLLJxI7hT+g7ABw1U2Qx860XZ0D0elpshwG1
	CJ
X-Google-Smtp-Source: AGHT+IHKVH9UaWOebe9YUYp6r8/SHm3T/u0S1BU4Cu53aQVyC0prV4/AKEW4Aw/+C17FHGF9kzLPzw==
X-Received: by 2002:a05:6214:2249:b0:70d:ee9b:9cdf with SMTP id 6a1803df08f44-70fac744c25mr236144496d6.18.1756992445097;
        Thu, 04 Sep 2025 06:27:25 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac262a4fsm46322916d6.11.2025.09.04.06.27.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:27:24 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] nanopi-r4s: refresh device-tree patch for linux-6.16.y
Date: Thu,  4 Sep 2025 09:27:17 -0400
Message-ID: <20250904132717.8973-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 13:27:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2126

The device-tree organization of the nanopi-r4s device changed slightly in
the linux-6.16.y release, therefore refresh the nanopi-r4s device-tree
patch to match.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../linux/linux-yocto/nanopi-r4s.scc          |  2 +-
 ...opi-r4s.dtsi-enable-second-ethernet.patch} | 21 +++++++++----------
 2 files changed, 11 insertions(+), 12 deletions(-)
 rename recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/{0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch => 0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch} (56%)

diff --git a/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc b/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
index 266b77c63fe5..3d1601e28d13 100644
--- a/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
+++ b/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
@@ -3,4 +3,4 @@ define KMACHINE nanopi-r4s
 define KTYPE standard
 define KARCH arm64
 
-include bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch
+include bsp/rockchip/0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch
diff --git a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch b/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch
similarity index 56%
rename from recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch
rename to recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch
index e1f2b92665dd..a3dc23afae7e 100644
--- a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch
+++ b/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch
@@ -1,9 +1,8 @@
-From 4c867907b68b417da0711cabdde30a969e368596 Mon Sep 17 00:00:00 2001
+From de2c28076a50e94659ea9693f9d0a307ef475132 Mon Sep 17 00:00:00 2001
 From: Trevor Woerner <twoerner@gmail.com>
-Date: Sun, 17 Sep 2023 17:30:43 -0400
-Subject: [PATCH] rk3399-nanopi-r4s.dts: enable second ethernet
+Date: Thu, 4 Sep 2025 09:11:33 -0400
+Subject: [PATCH] rk3399-nanopi-r4s.dtsi: enable second ethernet
 
-# lspci
 00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3399 PCI Express Root Port
 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ether)
 
@@ -11,14 +10,14 @@ Link: https://github.com/armbian/build/pull/2415
 Upstream-Status: Submitted [by someone else]
 Signed-off-by: Trevor Woerner <twoerner@gmail.com>
 ---
- arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 11 +++++++++++
+ arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi | 11 +++++++++++
  1 file changed, 11 insertions(+)
 
-diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
-index fe5b52610010..771615722358 100644
---- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
-+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
-@@ -76,6 +76,17 @@ &pcie0 {
+diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
+index 8d94d9f91a5c..d6dca18e772c 100644
+--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
++++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
+@@ -74,6 +74,17 @@ &pcie0 {
  	max-link-speed = <1>;
  	num-lanes = <1>;
  	vpcie3v3-supply = <&vcc3v3_sys>;
@@ -37,5 +36,5 @@ index fe5b52610010..771615722358 100644
  
  &pinctrl {
 -- 
-2.41.0.327.gaa9166bcc0ba
+2.44.0.501.g19981daefd7c
 
-- 
2.44.0.501.g19981daefd7c


