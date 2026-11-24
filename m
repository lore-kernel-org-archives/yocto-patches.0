Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12087.1795497775702241708
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Nov 2026 21:22:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=FDrfHcMc;
 spf=pass (domain: gmail.com, ip: 74.125.82.48, mailfrom: deepakdas.linux@gmail.com)
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15dd124bbe7so3779118c88.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Nov 2026 21:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795497775; x=1796102575; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gh8pe9NLSUCa2wMvD+nqR0CYFDNVnc/lP94tuT2cjHM=;
        b=FDrfHcMc65vMJc/7xCpvg5eJPuaYoZm3dREaH/qi6OTZDJc8flM9deJh6W6UEkK3AX
         gokBk71kxuB0Jv6WhlZSDhlJAeIb9bxwK7jauqfQJD5UWHWTqCuGBJAdARDdBV2FwVPT
         9icvBkLGQSclIq0VGUS/2+1ZCK/AZeyTAdHcPCI8Y9g/kBI+riGWm7ll9Zo/I3g7K92I
         wfvHZL+Bp4Tg8fXszNnIudoBY+pj9Jr7z5Kumz6Ag4PmkEpq8qJlG7hwKOFlBib1wOXt
         CnW8aTusM77WOhx9HqEE2TXEJkjGlg60Y2/QKCtqOfnBav9rWElJ9VoPgog9mIQMuUw2
         T0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795497775; x=1796102575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gh8pe9NLSUCa2wMvD+nqR0CYFDNVnc/lP94tuT2cjHM=;
        b=GYZ3w6ZbW8pZt9Pi0Sz66hZEAiDL1xP2njnX/URAtkSbkqjCg1NDieDfvbolu0t9ea
         IOhyRilEL0uC80lWXQ+LSrzw55BuHtucOyCIZ4LuvIeboyuQkayz5bM1tBNMoMRcihr2
         G330ZCgsOVwbnPWEG0EWYCgiDf08+V6jdxzcWVfDxw11RaQcYfLyoO8q2KlEvL46aQb+
         1L3lDWvS0jL/AwmLDMEigf1035trJ5de0sishg/Ttb3q3ENiizvfaYd/cxTg7chBKdFf
         dEE99XCxzWwGCNHUhqQn909fEK4ztU8q3j7mX1z7O/hDGIzj/LueBt6K9M6w5mrqV/tZ
         Sw5w==
X-Gm-Message-State: APuU4Z9oifBMeU7QM6fwnhdgGn+XQVWHIQAu1MnNH2Www6AOdKuz/lV0
	+lPs+crl/F/ANGiNE6qen4zSEU7hc0Mht4OO0c1YjMsmmQ+BT2MxHx4KIkYi2jjU
X-Gm-Gg: AZFdTZc8dp2ZVuc3P2wnffvGtIg2EPNigzNH56ZpASIafDQ7MYcf8qM+NJ8E//4KOeG
	wAc4atDp0th5EWhHeCu8JkpNKSQy7Gsgztjees6R45hsf8peuWAihzZgz1p1RfK0THoVlGw6/6i
	sfz199K5a0kKJAHuyF4LAEwnVZDPjnRvTOQZNt4W+fuH5aqmlHMkAjvzUOQ0GSBUgroVk0cpMtg
	jP8zxAxGEd/u8ESGyBf3qy7XXKjBZFlwFpcPMGaijoL5kgjMAIm2NVPYEQ8ISLk9mBLl5H8Negv
	pOpGBAYoRfa5TtS/NvIcuuFX/MzGNuhVKoDgNqCpn4yQgjCGvMPsn1wRCKe6ikRepg4aSZTzCq+
	vmFBNKEL78tke59Ixvb6ypWL8PL/ha8Bpy9+QeDtQv4gSdsFc/g0GmuMzXpU3d2ihhveY/ZjoDE
	TkdGbtOvoiZqwTVLdxJg0VYRZUVikUgRf16YJB4BSIu77tQ5mK0Z9KtCC8Cs9AdGMFqflN6t7/y
	/ZSHlXCaytQjL7K0nucoG7ViVLA8YMIys8r94kfBwClE37VaVSnQeYFI9Rh3Xe2K3WqziIL6o3j
	9hu3cfx56OmARwwhe0oWaHdyJt6c+zfOGj+ovY9a+PzHgpBTYQN51y9uog==
X-Received: by 2002:a05:701a:cc88:20b0:13e:5a50:1e17 with SMTP id a92af1059eb24-1b556823ad5mr14305727c88.3.1795497774804;
        Mon, 23 Nov 2026 21:22:54 -0800 (PST)
Return-Path: <deepakdas.linux@gmail.com>
Received: from ddas-VirtualBox.. ([49.36.144.249])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm31600835c88.15.2026.11.23.21.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 21:22:54 -0800 (PST)
From: Deepak Das <deepakdas.linux@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com
Subject: [meta-rockchip][PATCH] nanopc-t4: add
Date: Tue, 24 Nov 2026 10:52:40 +0530
Message-ID: <20261124052240.1121147-1-deepakdas.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 05:23:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5500
Content-Type: text/plain; charset="utf-8"

The FriendlyElec NanoPC-T4 is an RK3399 SBC with 4GB LPDDR3 RAM and
16GB onboard eMMC.

Documentation page:
https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T4

Specs:
- Rockchip RK3399
- Dual-Core Arm Cortex-A72 + Quad-Core Arm Cortex-A53
- Arm Mali T860MP4 GPU
- 4GB LPDDR3 RAM
- 16GB eMMC
- 1x Micro SD Card Slot
- 1x M.2 M-Key (4-lane PCIe 2.1)
- 1x Gigabit Ethernet
- 802.11ac WiFi and Bluetooth
- 1x USB3 Type-C, 2x USB3 HOST, 1x USB2 HOST
- 1x HDMI 2.0, 1x eDP, 1x MIPI DSI, 2x MIPI CSI
- 40-pin GPIO header
- Debug UART at 1500000 baud
- 12V DC input

Upstream U-Boot (nanopc-t4-rk3399_defconfig) and the upstream kernel
device tree (rk3399-nanopc-t4.dts) are used.

Tested on scarthgap by building core-image-base and booting the wic
image from the SD card to a login prompt. On master, u-boot and
linux-yocto build successfully for this machine.

AI-Generated: Claude Code, Opus 5.5
Signed-off-by: Deepak Das <deepakdas.linux@gmail.com>
---
 README                                  |  1 +
 conf/machine/nanopc-t4.conf             | 11 +++++++++++
 recipes-kernel/linux/linux-rockchip.inc |  1 +
 3 files changed, 13 insertions(+)
 create mode 100644 conf/machine/nanopc-t4.conf

diff --git a/README b/README
index c2697d1..3d8c568 100644
--- a/README
+++ b/README
@@ -25,6 +25,7 @@ Status of supported boards:
 			vyasa-rk3288
 
 		64-bit:
+			nanopc-t4
 			nanopc-t6
 			nanopi-m4
 			nanopi-m4-2gb
diff --git a/conf/machine/nanopc-t4.conf b/conf/machine/nanopc-t4.conf
new file mode 100644
index 0000000..20c47d3
--- /dev/null
+++ b/conf/machine/nanopc-t4.conf
@@ -0,0 +1,11 @@
+#@TYPE: Machine
+#@NAME: NanoPC-T4
+#@DESCRIPTION: NanoPC-T4 RK3399 board from FriendlyElec, 4GB LPDDR3
+#https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T4
+
+require conf/machine/include/rk3399.inc
+
+MACHINE_FEATURES += "usbhost serial"
+
+KERNEL_DEVICETREE = "rockchip/rk3399-nanopc-t4.dtb"
+UBOOT_MACHINE = "nanopc-t4-rk3399_defconfig"
diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
index b87cb7a..7ca12b1 100644
--- a/recipes-kernel/linux/linux-rockchip.inc
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -10,6 +10,7 @@ COMPATIBLE_MACHINE:tinker-board-s = "tinker-board-s"
 COMPATIBLE_MACHINE:vyasa-rk3288 = "vyasa-rk3288"
 
 # 64-bit devices
+COMPATIBLE_MACHINE:nanopc-t4 = "nanopc-t4"
 COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
 COMPATIBLE_MACHINE:nanopi-m4 = "nanopi-m4"
 COMPATIBLE_MACHINE:nanopi-m4-2gb = "nanopi-m4-2gb"
-- 
2.43.0

