Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44647D2CE1B
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 03:37:32 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.62474.1764905845409408746
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Dec 2025 19:37:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BWty8oQo;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88267973e5cso8922866d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Dec 2025 19:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764905843; x=1765510643; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbNLzV+hhxnLXYZ0hs6/4ZI1dtEZbrjzhUGeJKhsgRw=;
        b=BWty8oQoN72Y6YixfBZeBQAgoC4S26Y3mJjOZwVM+3NQI4UYZpSw+nm0O+/9EkUQCm
         imoD78sK73LoLjSm5JBfid7E9CRrmktnOMzoxvQ4UcexZls6chSqbWL/B5o8bmVs7sms
         0TDK2mA/gk0JfvpTJOM/ZBOuJk72J74fufKfANwr6RnLN4b9HAwy04Btqi/YFQPU2BDN
         Ssroq1QzZWCX5o6tqjjMaycfr0/85JT6YAbbh+xO1zPSJflXKQDrXsDV3oR2W15pTMLi
         /rM5CFqZmrl99exRIztQRL/g47aHTM/HCXMnG0Rn3aeCCuLDGzLoAAMFgsXaeuEvnFZY
         s8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764905843; x=1765510643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbNLzV+hhxnLXYZ0hs6/4ZI1dtEZbrjzhUGeJKhsgRw=;
        b=to80w6wn8jV0MUONukWumKQSeod8qaWmb2Gfzg5sKkIoYry08sDeA3ZWI6uzb9wgXf
         mOkPAvvj++6D/LtRSygrSDJ7BCRIz4VysMzhb/fr2EfmgmWeaMuILNJb66zAYjLsrM3H
         ijmLD5Jbch5VW3IB54cn7BUOPhOCBiIw7T76izeHjhHtr8mWiviRimWMxcxkhsqGI7gI
         3OCCCt8R6mUUJ0/a7ORB7M/5FFXkL3/oGQkDl6TsyfDEeX0RwHlIBbD+TCTtAjyNl5Tr
         kV7XKVsE22bsJaGUPATF039cgBe1arvCGL3Y60qdBh/JUAgyA2hEw90+nbuRFiaJZHuw
         vjBQ==
X-Gm-Message-State: AOJu0YznEZ+fvE0E2glBqDh5W9n9rX98WgYDlw1wVD6+6ozIC86DOdCm
	+1+DccoJzISGM++BKY/B0Ddnv3q45OjODIirls1nR/wgvKWcraZVbespf/sbXg==
X-Gm-Gg: ASbGncsBnZp4lJlHc6brHK0VYVvCzSUu6I+cxS3w7fh1sGpQsG8F3yRs6whEY+lAuiz
	XdSla5WzcnNbOJ8qrZhrt/ziN/cGyQeRwNw0T8BmdmLwMnZZyHGOZc5PDyDrOItAQ8xhKhcnbU1
	7DRoPNTLoqD5e+tMkPi3dSpx0qjUvf5C6lJ6ZwmWfQj+ElZEtY3pYHRjmZd1gLdKt0QfjLGbgi3
	Kw2pPzscpzmoM6p3ca2uAr6jIl2ZexkuNUnY5nLGTY+QUTJSYltcqtELFtyiWS5KDZ7NQ7MovKX
	xq8MsxOhMeOcx0BxuvQwV+DCos9d+mjYa9GVSn8LwCMcPJfvYP7I2E14L2HbkpvuyzSqOwJo978
	ieR33V2ToO/5/uoQtjFY1DP6VO1gwPUc4yGYdykpxi3UG52HTdjUf4rJ3dnwUXIT/45yFPyeENO
	Orr2eXdrpcczfvsCO8mCSwqZXjTeRpF0AaMu8V1A==
X-Google-Smtp-Source: AGHT+IGjCMfC9AUsulukVLHdRZXc4R/Nd7bFU0xm+W1I5j7A9V8Wt/7G+zdreMSwTB1xXWV1AmAnhg==
X-Received: by 2002:ad4:5d41:0:b0:882:44cc:f58e with SMTP id 6a1803df08f44-8882481ddb8mr92395206d6.2.1764905843396;
        Thu, 04 Dec 2025 19:37:23 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88827f335dbsm26050246d6.8.2025.12.04.19.37.22
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 19:37:22 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 1/2] make rockchip kernel tweaks easier to use
Date: Thu,  4 Dec 2025 22:37:14 -0500
Message-ID: <20251205033715.8852-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Dec 2025 03:37:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2736

If linux-yocto is used with this layer, these rockchip tweaks are
available automatically. However, if the user wishes to use their own
linux kernel recipe, these rockchip tweaks are cumbersome since the
MACHINE definition wants to include them. Reorganize how these tweaks
are provided to make them easier to work with when using custom recipes.

Nothing needs to be changed when using linux-yocto. Otherwise simply
provide the following line (or something similar which has the same
effect) in any custom linux kernel recipe:

	require recipes-kernel/linux/linux-rockchip.inc

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
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


