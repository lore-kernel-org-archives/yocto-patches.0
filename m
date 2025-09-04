Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9CFCA1012
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 19:45:41 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web10.3930.1757015135119351453
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 12:45:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l/JYLD+d;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b5d5b1bfa3so15402301cf.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757015133; x=1757619933; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U69GZU4tQaIWowD3tjZS66pY0/8e8Nfsp/EjGpXkwdA=;
        b=l/JYLD+dZsD738HrzCdkgWmq9zu9+u85FEq7AOZOK9L2O/NMzi0BBPCOeiyfy+RFf/
         Uq8R77/e9zp8f9JaEaZTs5rj8ij+lxbPuvNuYvCcO+Lq71gyxdRjIXXu0UaPjogbYy06
         0jOuxMrG8VmxsUmS6kAH+F3oBb5RWrs8eJFLgL+ozlfU/AzLwC4AHs+2sgk1603R8bmk
         WEfgBYd3xpt6GJtPfcHQdCKG6FqCGfHF9HXdCYuPTDz7m3uqBqvrIsz4AxOl36mJI8yo
         rvtGxAf6fwknjuI0mhSGbTCsumISAa+jPXzTiDqh/Wvh9OoqSyBz+I2Tdn16OsdT+raQ
         dFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015133; x=1757619933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U69GZU4tQaIWowD3tjZS66pY0/8e8Nfsp/EjGpXkwdA=;
        b=YYEOAcf7zeS8Eo4ldAFFACsc4gjJrdve3vgs44NVfF9yg1FRwiTZdM7pkM6ryDd33+
         zrzUKLj8R2wg3S8BtDJhg2FKya/gLV4HH7CkcYkUE3+NoI07E81I2vy9Ze4MGedngmZU
         fJ8sFfUTrnscDAIIWOkp9dx0HxmCKo5R0LMcW97VzrH3SKWQdxYC+PwVzfU8taf7ynZb
         XMLZ7yQtbRvbwtRvX0DYnb4VmDUlzsA41Uv39ebhgpggJXYlXsfXtdTkEmt49xpC0Olr
         iJzZpRCIWhDI0IIpW7Ul5wFFFeYRSQBOyUXTNFEBHoSG+IqvEGIvZ+KkT6FR3QNqlEht
         9/MQ==
X-Gm-Message-State: AOJu0Yy8zMSiVa/CsbfmPBU73SGaWsWvSD2z7Ubt+X4+/jFQSaoXru8b
	if1RAwydzgAsGUa4hZwg5bm8ZPG0P0IjZ72TstE5znH7scKR3o6AZuqfErHZaA==
X-Gm-Gg: ASbGncsfW3VeMrv2gZRpsJbbkdPn+85lOSW3CauvWAsBRivOuuwlb7X0aR/49vhUWVS
	nU1PyJDdp0qTOwtucaljrQ8k6Zx782IJFQyRF5Br/GeAnzpdQdF0OZkJzyiJ9qQerGIFlZO6L3P
	LMLdD7hVaFQlhBSDDouSsElbRzgcEtcURQ8b4T2T31B+TdxdYzwMy4ecNUp8USJEcNiMGGdhpMM
	wL683JXXAUcEUoG4PQUZdxdt817MQzsq+uvk+BSbpn8dHKl4vOi03vJklblnpf0gwMvwuYNzv6M
	uuZZU0pH/64UD69BDRskBOWGpqOl/5LasX8HBeNaDBuTqhsT9hfCq1VzuQkWOYHMEI6H2xXHJ7u
	CP5SOE+wdguz/PdAoX8JYPP4xXonv5lEpZTq9/B4yLoGHxmAJcGmeTyvYbNa5HFUIUA==
X-Google-Smtp-Source: AGHT+IGy3M75E6R7s6XKmWrkEzvA5oNa1gTwlicYojdV4mhqJBY4c7AOKe4OtdaXzMYscy9Ssn4Qqw==
X-Received: by 2002:a05:622a:244f:b0:4b3:755:3c7c with SMTP id d75a77b69052e-4b31db65d6fmr292951421cf.55.1757015132729;
        Thu, 04 Sep 2025 12:45:32 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f760fa9sm33525141cf.26.2025.09.04.12.45.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 12:45:32 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 1/2] nanopi-r4s: remove 2nd eth work-around
Date: Thu,  4 Sep 2025 15:45:28 -0400
Message-ID: <20250904194529.22656-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 19:45:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2136

Pre-6.16.y linux kernels needed a kludge in order for the second ethernet the
work out of the box. With the update to the 6.16.y kernel the kludge no longer
applies. Fixing up the kludge so that it does apply does not seem to bring up
the second interface. However with the kludge removed altogether, the second
interface comes up without issue.

    # lspci
    00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3399 PCI Express Root Port
    01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../linux/linux-yocto/nanopi-r4s.scc          |  6 ---
 ...anopi-r4s.dts-enable-second-ethernet.patch | 41 -------------------
 recipes-kernel/linux/linux-yocto_%.bbappend   |  1 -
 3 files changed, 48 deletions(-)
 delete mode 100644 recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
 delete mode 100644 recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch

diff --git a/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc b/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
deleted file mode 100644
index 266b77c63fe5..000000000000
--- a/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
+++ /dev/null
@@ -1,6 +0,0 @@
-define KFEATURE_DESCRIPTION "tweaks for the nanopi-r4s"
-define KMACHINE nanopi-r4s
-define KTYPE standard
-define KARCH arm64
-
-include bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch
diff --git a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch b/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch
deleted file mode 100644
index e1f2b92665dd..000000000000
--- a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch
+++ /dev/null
@@ -1,41 +0,0 @@
-From 4c867907b68b417da0711cabdde30a969e368596 Mon Sep 17 00:00:00 2001
-From: Trevor Woerner <twoerner@gmail.com>
-Date: Sun, 17 Sep 2023 17:30:43 -0400
-Subject: [PATCH] rk3399-nanopi-r4s.dts: enable second ethernet
-
-# lspci
-00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3399 PCI Express Root Port
-01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ether)
-
-Link: https://github.com/armbian/build/pull/2415
-Upstream-Status: Submitted [by someone else]
-Signed-off-by: Trevor Woerner <twoerner@gmail.com>
----
- arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 11 +++++++++++
- 1 file changed, 11 insertions(+)
-
-diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
-index fe5b52610010..771615722358 100644
---- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
-+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
-@@ -76,6 +76,17 @@ &pcie0 {
- 	max-link-speed = <1>;
- 	num-lanes = <1>;
- 	vpcie3v3-supply = <&vcc3v3_sys>;
-+
-+	pcie@0 {
-+		reg = <0x00000000 0 0 0 0>;
-+		#address-cells = <3>;
-+		#size-cells = <2>;
-+
-+		r8169: pcie@0,0 {
-+			reg = <0x000000 0 0 0 0>;
-+			local-mac-address = [ 00 00 00 00 00 00 ];
-+		};
-+	};
- };
- 
- &pinctrl {
--- 
-2.41.0.327.gaa9166bcc0ba
-
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index 75de6110c228..5d68c7d56e2b 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -31,4 +31,3 @@ COMPATIBLE_MACHINE:rock64 = "rock64"
 COMPATIBLE_MACHINE:soquartz = "soquartz"
 
 SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
-SRC_URI:append:nanopi-r4s = " file://nanopi-r4s.scc"
-- 
2.44.0.501.g19981daefd7c


