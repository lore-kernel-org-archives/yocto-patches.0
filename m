Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web10.4878.1713327026597091310
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Apr 2024 21:10:26 -0700
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78edc3e7cd9so221791585a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Apr 2024 21:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713327024; x=1713931824; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Z9hoaMgKb6VCsPts3+bxBZxq3BCDcWzvjwudGGHsdM=;
        b=hqdT+BgLyHzXIhe3bw2I4iYoRJHatWKmsi/jkAdYm9jObCCV5U4BDz9r6xJYBVsxYV
         DxMyh7c78yfZB4CfwatR0tQUDamERA5xgOEnsJK0LzwlHkt4PvcH8F2AYBsmkBPN+RCb
         m9M7LZkn1dys8MJXBi9CqahPlyYx79q18t6+NSmai+GZUDAXAkV76qZz0ZRE3aBrz+66
         t4GCHHpeTa4sQFU6TDq4RMxCE9ZRn2WJk7j2/NC98USuKCqZfwvi1RSJ9rrU/Nx/h4Xo
         nIbbRPNtoPJUThMcrbEP5Taf4hulsaCqgiGoJiSSUn6hdeEv3nxZkVWltV80NhFLriAO
         eRng==
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id f5-20020a0cf3c5000000b00698d06df322sm7964707qvm.122.2024.04.16.21.10.23
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 21:10:23 -0700 (PDT)
From: "Trevor Woerner" <twoerner@gmail.com>
Subject: [meta-rockchip][PATCH] u-boot: remove now-upstreamed rock-pi-e patches
Date: Wed, 17 Apr 2024 00:10:13 -0400
Message-ID: <20240417041013.13341-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

These patches were back-ported from upstream to fix an issue with automatically
handling different ethernet PHY chips on different spins of the rock-pi-e
board. Now that the version of U-Boot has been updated in oe-core master,
these pack-ports are no longer required to be applied explicitly.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 ...are_Reset_eth_phy_before_phy_connect.patch | 83 -------------------
 ...-e_Enable_DM_ETH_PHY_and_PHY_REALTEK.patch | 65 ---------------
 recipes-bsp/u-boot/u-boot_%.bbappend          |  6 --
 3 files changed, 154 deletions(-)
 delete mode 100644 recipes-bsp/u-boot/files/PATCH_1-2_net_designware_Reset_eth_phy_before_phy_connect.patch
 delete mode 100644 recipes-bsp/u-boot/files/PATCH_2-2_rockchip_rk3328-rock-pi-e_Enable_DM_ETH_PHY_and_PHY_REALTEK.patch

diff --git a/recipes-bsp/u-boot/files/PATCH_1-2_net_designware_Reset_eth_phy_before_phy_connect.patch b/recipes-bsp/u-boot/files/PATCH_1-2_net_designware_Reset_eth_phy_before_phy_connect.patch
deleted file mode 100644
index 4910b9803611..000000000000
--- a/recipes-bsp/u-boot/files/PATCH_1-2_net_designware_Reset_eth_phy_before_phy_connect.patch
+++ /dev/null
@@ -1,83 +0,0 @@
-From: Jonas Karlman <jonas@kwiboo.se>
-To: Kever Yang <kever.yang@rock-chips.com>, Ramon Fried
- <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Simon
- Glass <sjg@chromium.org>, Banglang Huang <banglang.huang@foxmail.com>
-Cc: Trevor Woerner <twoerner@gmail.com>, u-boot@lists.denx.de, Jonas
- Karlman <jonas@kwiboo.se>
-Subject: [PATCH 1/2] net: designware: Reset eth phy before phy connect
-Date: Thu, 18 Jan 2024 07:19:45 +0000
-Message-ID: <20240118071949.927089-2-jonas@kwiboo.se>
-X-Mailer: git-send-email 2.43.0
-In-Reply-To: <20240118071949.927089-1-jonas@kwiboo.se>
-References: <20240118071949.927089-1-jonas@kwiboo.se>
-MIME-Version: 1.0
-Content-Transfer-Encoding: 8bit
-X-Report-Abuse-To: abuse@forwardemail.net
-X-Report-Abuse: abuse@forwardemail.net
-X-Complaints-To: abuse@forwardemail.net
-X-ForwardEmail-Version: 0.4.40
-X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
- 149.28.215.223
-X-ForwardEmail-ID: 65a8d11ed66eecd94fbb691a
-
-Some ethernet PHY require being reset before a phy-id can be read back
-on the MDIO bus. This can result in the following message being show
-on e.g. a Radxa ROCK Pi E v1.21 with a RTL8211F ethernet PHY.
-
-  Could not get PHY for ethernet@ff540000: addr -1
-
-Add support to designware ethernet driver to reset eth phy by calling
-the eth phy uclass function eth_phy_set_mdio_bus(). The call use NULL
-as bus parameter to not set a shared mdio bus reference that would be
-freed when probe fails. Also add a eth_phy_get_addr() call to try and
-get the phy addr from DT when DM_MDIO is disabled.
-
-This help fix ethernet on Radxa ROCK Pi E v1.21:
-
-  => mdio list
-  ethernet@ff540000:
-  1 - RealTek RTL8211F <--> ethernet@ff540000
-
-Upstream-Status: Submitted
-Reported-by: Trevor Woerner <twoerner@gmail.com>
-Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
----
- drivers/net/designware.c | 7 +++++++
- 1 file changed, 7 insertions(+)
-
-diff --git a/drivers/net/designware.c b/drivers/net/designware.c
-index a174344b3ef5..9aa5d8a1409e 100644
---- a/drivers/net/designware.c
-+++ b/drivers/net/designware.c
-@@ -13,6 +13,7 @@
- #include <cpu_func.h>
- #include <dm.h>
- #include <errno.h>
-+#include <eth_phy.h>
- #include <log.h>
- #include <miiphy.h>
- #include <malloc.h>
-@@ -576,6 +577,9 @@ static int dw_phy_init(struct dw_eth_dev *priv, void *dev)
- 	struct phy_device *phydev;
- 	int ret;
- 
-+	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
-+		eth_phy_set_mdio_bus(dev, NULL);
-+
- #if IS_ENABLED(CONFIG_DM_MDIO)
- 	phydev = dm_eth_phy_connect(dev);
- 	if (!phydev)
-@@ -583,6 +587,9 @@ static int dw_phy_init(struct dw_eth_dev *priv, void *dev)
- #else
- 	int phy_addr = -1;
- 
-+	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
-+		phy_addr = eth_phy_get_addr(dev);
-+
- #ifdef CONFIG_PHY_ADDR
- 	phy_addr = CONFIG_PHY_ADDR;
- #endif
--- 
-2.43.0
-
-
diff --git a/recipes-bsp/u-boot/files/PATCH_2-2_rockchip_rk3328-rock-pi-e_Enable_DM_ETH_PHY_and_PHY_REALTEK.patch b/recipes-bsp/u-boot/files/PATCH_2-2_rockchip_rk3328-rock-pi-e_Enable_DM_ETH_PHY_and_PHY_REALTEK.patch
deleted file mode 100644
index c4afce401655..000000000000
--- a/recipes-bsp/u-boot/files/PATCH_2-2_rockchip_rk3328-rock-pi-e_Enable_DM_ETH_PHY_and_PHY_REALTEK.patch
+++ /dev/null
@@ -1,65 +0,0 @@
-From: Jonas Karlman <jonas@kwiboo.se>
-To: Kever Yang <kever.yang@rock-chips.com>, Ramon Fried
- <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Simon
- Glass <sjg@chromium.org>, Banglang Huang <banglang.huang@foxmail.com>
-Cc: Trevor Woerner <twoerner@gmail.com>, u-boot@lists.denx.de, Jonas
- Karlman <jonas@kwiboo.se>
-Subject: [PATCH 2/2] rockchip: rk3328-rock-pi-e: Enable DM_ETH_PHY and PHY_REALTEK
-Date: Thu, 18 Jan 2024 07:19:46 +0000
-Message-ID: <20240118071949.927089-3-jonas@kwiboo.se>
-X-Mailer: git-send-email 2.43.0
-In-Reply-To: <20240118071949.927089-1-jonas@kwiboo.se>
-References: <20240118071949.927089-1-jonas@kwiboo.se>
-MIME-Version: 1.0
-Content-Transfer-Encoding: 8bit
-X-Report-Abuse-To: abuse@forwardemail.net
-X-Report-Abuse: abuse@forwardemail.net
-X-Complaints-To: abuse@forwardemail.net
-X-ForwardEmail-Version: 0.4.40
-X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
- 149.28.215.223
-X-ForwardEmail-ID: 65a8d121d66eecd94fbb6928
-
-Enable the DM_ETH_PHY and PHY_REALTEK now that the designware ethernet
-driver call eth_phy_set_mdio_bus() to assist with resetting the eth PHY
-during probe.
-
-Fixes ethernet on the v1.21 hw revision of Radxa ROCK Pi E:
-
-  => mdio list
-  ethernet@ff540000:
-  1 - RealTek RTL8211F <--> ethernet@ff540000
-  => net list
-  eth0 : ethernet@ff540000 86:e0:c0:ea:fa:a9 active
-  eth1 : ethernet@ff550000 86:e0:c0:ea:fa:a8
-  => dhcp
-  Speed: 1000, full duplex
-  BOOTP broadcast 1
-  BOOTP broadcast 2
-  BOOTP broadcast 3
-  DHCP client bound to address 192.168.1.114 (1004 ms)
-
-Upstream-Status: Submitted
-Reported-by: Trevor Woerner <twoerner@gmail.com>
-Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
----
- configs/rock-pi-e-rk3328_defconfig | 2 ++
- 1 file changed, 2 insertions(+)
-
-diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
-index c0375beffec3..6dda900a9b42 100644
---- a/configs/rock-pi-e-rk3328_defconfig
-+++ b/configs/rock-pi-e-rk3328_defconfig
-@@ -76,6 +76,8 @@ CONFIG_SYS_I2C_ROCKCHIP=y
- CONFIG_MISC=y
- CONFIG_MMC_DW=y
- CONFIG_MMC_DW_ROCKCHIP=y
-+CONFIG_PHY_REALTEK=y
-+CONFIG_DM_ETH_PHY=y
- CONFIG_ETH_DESIGNWARE=y
- CONFIG_GMAC_ROCKCHIP=y
- CONFIG_PHY_ROCKCHIP_INNO_USB2=y
--- 
-2.43.0
-
-
diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index f8378d91ce68..a83179a9f007 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -1,9 +1,3 @@
-FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
-SRC_URI:append:rock-pi-e = " \
-	file://PATCH_1-2_net_designware_Reset_eth_phy_before_phy_connect.patch \
-	file://PATCH_2-2_rockchip_rk3328-rock-pi-e_Enable_DM_ETH_PHY_and_PHY_REALTEK.patch \
-	"
-
 # various machines require the pyelftools library for parsing dtb files
 DEPENDS:append = " python3-pyelftools-native"
 DEPENDS:append:rk3308 = " u-boot-tools-native"
-- 
2.44.0.478.g7774cfed6261

