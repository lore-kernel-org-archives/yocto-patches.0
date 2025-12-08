Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12424D3B7ED
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 19:36:08 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1527.1765222560379527987
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Dec 2025 11:36:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CWUYUJwf;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2d32b9777so661879285a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 08 Dec 2025 11:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765222558; x=1765827358; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sd4VdgIhbDjPX1QhDK+18sqoobSxg2zG4Ap+n7q+nbw=;
        b=CWUYUJwfolHLHr2YsObBoBYZrR2lVY22gXmsOlHqp24F88TqxS5yftYzcn+3S1hXBr
         dEV2Dr3CwmoLn4DQXL02lOGDqj+rRSrhzzET1x87KQTmGBkuADnx/LCsXD3rP6WFH57f
         NGqYmMK/I0Mxg3ABD4Dsd7Y5trIwqfKHQ7MzZzBKu8mTznFczbd2iEo6ccZNGBi+tr3h
         35BuSLGY/8RIpO1SL1y56dIJVnMLYyBT7rhPYkXFQMsIu/5jRtwteJrOSrbwVc7HqjLU
         OAmfb06hReLpJ/SQWBp6BfLtkXPm7pkGDNHMYSa9ES0bjfYIOJ7AA8ShN1KvdwYl1E2q
         MSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765222558; x=1765827358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sd4VdgIhbDjPX1QhDK+18sqoobSxg2zG4Ap+n7q+nbw=;
        b=TUabxHbol594PEvk4qEzE/gD6HNO8lPG2lofSuGdkNq0daSu2xRrG6AYngXR2F6eHH
         Dq3tPg1OZ4OTbqYMkKHFqRqMUyarY/b8wx0csWPFQ2tdca+hks29FFf5uNHp3aIY7/3G
         m9RtLGMZKszH4S0v52VXMiSsgyy/GpSRNJ7LQ3oMRQzqaCvedzmTeuYHHMBofsFGvVEc
         t9GakABAC5LBe3NBCaCujtc2LnM/3XCEXGXpeO+TA/uxhFECiv9OQej8ab/MsLjyrLRP
         SDMbZDPu7hmoR2Tl1KXr+bngqshoyU53APNgnm2YQVIDZE6EAwmtTB5OtHvJDU9LPfkM
         Rn7w==
X-Gm-Message-State: AOJu0Yya/7xSqhruSBFkFifSZCXu9s3F6cqStN+SDfyR2IXdDjZ5s3zl
	/Of217rn+ByJJ06+sXz6VyMyaVpHZK3l1uyvBNDVw5J3IVV5yoLi18lOUY2XAw==
X-Gm-Gg: ASbGnctkMSdSvlUJNLZ67NMBRIMRvRA1NfWAAq/yAkJ2DQUZEj+x/UzVH8/akkFGTPP
	egGSCA5ZFkt6GpYAWG7s5b3baehzub0fk+a3PzKy2IHwX32S4KaTbDNPF0V7rZxnB9SKB+npj6b
	1CGMZN91RAgcKUx6ZGPqVtDEl6ZIKSUIo5lKlZpR4obouP3cHCjkMmQty8meDW3RphOoR+6ZbsO
	aft/HezE1f3EqYWV0hQnFYaVKud638q0I0YTyxazsnIE2fNuLlOypJ6AuyAWLHMONYfyrRvTL+U
	wUSR6dZhOgcjZ3BlYvcL0yBIR3VXqSMhXfl1Wn33PPhxVYF9e+vl/OiUhdL6H5x0i0FDrgbEiV7
	JU/1k58I+CKZJyBmkAOfIClEc/IxHn0DHEf0J+1SBmmJtHCAgKZkvr1ykd/aEZ7d51Rvi2sFS/k
	RPhOhPGkeb9h6UZ8XkIdGlwDAL+EkiK3+sxMWapA7M+D1Z9hzr
X-Google-Smtp-Source: AGHT+IFiANmZtam0CFSheUyhVDB4Ch2Bv+Zooy9In8F3soysRH+HumGSNGrTH1dFCUQczBC+0GgBqA==
X-Received: by 2002:a05:620a:191f:b0:8a3:b6a9:d3c2 with SMTP id af79cd13be357-8b6a256a5fdmr1216012685a.44.1765222558160;
        Mon, 08 Dec 2025 11:35:58 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b6252a01fbsm1120043485a.7.2025.12.08.11.35.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 11:35:57 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 1/2] make rockchip kernel tweaks easier to use
Date: Mon,  8 Dec 2025 14:35:50 -0500
Message-ID: <20251208193551.2426-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Dec 2025 19:36:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2749

If the machines defined in this layer are used, they will want to pull
in the kmeta data that is also provided in this layer when configuring
the Linux kernel. This all works automatically if linux-yocto or
linux-yocto-dev are used. But it causes build failures if a kernel
recipe is used or defined that is not one of these two.

Putting this layer-specific metadata into an *.inc file (then
referencing it in the kernel bbappends provided in this layer) makes
that metadata available to any other kernel recipe through the "require"
or "include" mechanism. Any other kernel recipe that is created can pull
in this metadata using either of these lines in the kernel recipe:

	require recipes-kernel/linux/linux-rockchip.inc
	include recipes-kernel/linux/linux-rockchip.inc

This layer can not guess or assume what other kernel recipes might be
used with its machine definitions, and providing random, potentially
dangling, bbappends is not a solution either. Therefore splitting this
layer's information into an *.inc file makes it available to recipes
outside this layer.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes from v1:
- updated the commit message after discussions with Quentin
- hopefully this version provides a clearer explanation and reasoning
  for the change
---
 recipes-kernel/linux/linux-rockchip.inc       | 35 ++++++++++++++++++
 .../realtek-r8169.cfg                         |  0
 .../rockchip/remove-non-rockchip-arch-arm.cfg |  0
 .../rockchip/remove-non-rockchip-arch-arm.scc |  0
 .../remove-non-rockchip-arch-arm64.cfg        |  0
 .../remove-non-rockchip-arch-arm64.scc        |  0
 recipes-kernel/linux/linux-yocto_%.bbappend   | 36 +------------------
 7 files changed, 36 insertions(+), 35 deletions(-)
 create mode 100644 recipes-kernel/linux/linux-rockchip.inc
 rename recipes-kernel/linux/{linux-yocto => linux-rockchip}/realtek-r8169.cfg (100%)
 rename recipes-kernel/linux/{linux-yocto => linux-rockchip}/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg (100%)
 rename recipes-kernel/linux/{linux-yocto => linux-rockchip}/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc (100%)
 rename recipes-kernel/linux/{linux-yocto => linux-rockchip}/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg (100%)
 rename recipes-kernel/linux/{linux-yocto => linux-rockchip}/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc (100%)

diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
new file mode 100644
index 000000000000..a648ecb20679
--- /dev/null
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -0,0 +1,35 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/linux-rockchip:"
+
+# 32-bit devices
+COMPATIBLE_MACHINE:firefly-rk3288 = "firefly-rk3288"
+COMPATIBLE_MACHINE:marsboard-rk3066 = "marsboard-rk3066"
+COMPATIBLE_MACHINE:radxarock = "radxarock"
+COMPATIBLE_MACHINE:rock2-square = "rock2-square"
+COMPATIBLE_MACHINE:tinker-board = "tinker-board"
+COMPATIBLE_MACHINE:tinker-board-s = "tinker-board-s"
+COMPATIBLE_MACHINE:vyasa-rk3288 = "vyasa-rk3288"
+
+# 64-bit devices
+COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
+COMPATIBLE_MACHINE:nanopi-m4 = "nanopi-m4"
+COMPATIBLE_MACHINE:nanopi-m4-2gb = "nanopi-m4-2gb"
+COMPATIBLE_MACHINE:nanopi-m4b = "nanopi-m4b"
+COMPATIBLE_MACHINE:nanopi-r2s = "nanopi-r2s"
+COMPATIBLE_MACHINE:nanopi-r4s = "nanopi-r4s"
+COMPATIBLE_MACHINE:orangepi-3b = "orangepi-3b"
+COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
+COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
+COMPATIBLE_MACHINE:roc-rk3308-cc = "roc-rk3308-cc"
+COMPATIBLE_MACHINE:roc-rk3328-cc = "roc-rk3328-cc"
+COMPATIBLE_MACHINE:rock-3a = "rock-3a"
+COMPATIBLE_MACHINE:rock-4c-plus = "rock-4c-plus"
+COMPATIBLE_MACHINE:rock-5a = "rock-5a"
+COMPATIBLE_MACHINE:rock-5b = "rock-5b"
+COMPATIBLE_MACHINE:rock-pi-4 = "rock-pi-4"
+COMPATIBLE_MACHINE:rock-pi-e = "rock-pi-e"
+COMPATIBLE_MACHINE:rock-pi-s = "rock-pi-s"
+COMPATIBLE_MACHINE:rock64 = "rock64"
+COMPATIBLE_MACHINE:soquartz = "soquartz"
+
+SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
+SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
diff --git a/recipes-kernel/linux/linux-yocto/realtek-r8169.cfg b/recipes-kernel/linux/linux-rockchip/realtek-r8169.cfg
similarity index 100%
rename from recipes-kernel/linux/linux-yocto/realtek-r8169.cfg
rename to recipes-kernel/linux/linux-rockchip/realtek-r8169.cfg
diff --git a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
similarity index 100%
rename from recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
rename to recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
diff --git a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
similarity index 100%
rename from recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
rename to recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
diff --git a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
similarity index 100%
rename from recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
rename to recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
diff --git a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc
similarity index 100%
rename from recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc
rename to recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.scc
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index 2dba3d70a3ca..34bf335d0b10 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -1,35 +1 @@
-FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
-
-# 32-bit devices
-COMPATIBLE_MACHINE:firefly-rk3288 = "firefly-rk3288"
-COMPATIBLE_MACHINE:marsboard-rk3066 = "marsboard-rk3066"
-COMPATIBLE_MACHINE:radxarock = "radxarock"
-COMPATIBLE_MACHINE:rock2-square = "rock2-square"
-COMPATIBLE_MACHINE:tinker-board = "tinker-board"
-COMPATIBLE_MACHINE:tinker-board-s = "tinker-board-s"
-COMPATIBLE_MACHINE:vyasa-rk3288 = "vyasa-rk3288"
-
-# 64-bit devices
-COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
-COMPATIBLE_MACHINE:nanopi-m4 = "nanopi-m4"
-COMPATIBLE_MACHINE:nanopi-m4-2gb = "nanopi-m4-2gb"
-COMPATIBLE_MACHINE:nanopi-m4b = "nanopi-m4b"
-COMPATIBLE_MACHINE:nanopi-r2s = "nanopi-r2s"
-COMPATIBLE_MACHINE:nanopi-r4s = "nanopi-r4s"
-COMPATIBLE_MACHINE:orangepi-3b = "orangepi-3b"
-COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
-COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
-COMPATIBLE_MACHINE:roc-rk3308-cc = "roc-rk3308-cc"
-COMPATIBLE_MACHINE:roc-rk3328-cc = "roc-rk3328-cc"
-COMPATIBLE_MACHINE:rock-3a = "rock-3a"
-COMPATIBLE_MACHINE:rock-4c-plus = "rock-4c-plus"
-COMPATIBLE_MACHINE:rock-5a = "rock-5a"
-COMPATIBLE_MACHINE:rock-5b = "rock-5b"
-COMPATIBLE_MACHINE:rock-pi-4 = "rock-pi-4"
-COMPATIBLE_MACHINE:rock-pi-e = "rock-pi-e"
-COMPATIBLE_MACHINE:rock-pi-s = "rock-pi-s"
-COMPATIBLE_MACHINE:rock64 = "rock64"
-COMPATIBLE_MACHINE:soquartz = "soquartz"
-
-SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
-SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
+require linux-rockchip.inc
-- 
2.51.0.193.g4975ec3473b4


