Return-Path: <charles.embedded@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A38EF06F6
	for <webhook@archiver.kernel.org>; Sun,  8 Feb 2026 21:45:22 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34793.1770587119393077434
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Feb 2026 13:45:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=il11b0go;
 spf=pass (domain: gmail.com, ip: 209.85.128.170, mailfrom: charles.embedded@gmail.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79274e0e56bso33970727b3.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 13:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587118; x=1771191918; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4VSC7V5GJhvGU6tos2XXdSdfdHt6oTgI56c3Z346GY=;
        b=il11b0goGrJbwiLC/dduEWU6cduS74YJ2Y7i0PuOQyTg4+SWxsGviFoTh+daiZcDia
         EXNmDLgO160AqweWq7tM6mli0J7Z+T9Rt3/Opm515ZhlbesNq0hRVUTgJCNOcAKWNNTS
         SDE5qwSXahHnYvnDEbtZJrum4LO/HxHiVDpLQb9R5cXfUZsmdLCct1YHLp5VZXLxz2I9
         ZQScqWZ78obntaGU67J1MxExSWONCTAz0sVrB67IsBM31YsGCCqtiR4y1ECGAsZn4/Zj
         AN9SdsbvEQxPVKVxMnQIfqcNv+oaAI5xv5Aa+OIt509ajncFA4Pv5raOMM8VlV8J03Yg
         2gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587118; x=1771191918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4VSC7V5GJhvGU6tos2XXdSdfdHt6oTgI56c3Z346GY=;
        b=tIrmhZWyL8N2hO5EhgyPhHGc2r83XNhgKhtdApPp3P3Dh28zLWEe8ylWChrtcZThqz
         DBE8Ipk6sL6UMApbwTZ7lCKVgu7CYo8H10FKpvjtPdIB5+rTckdSMziSZP7OlcoGB2h1
         fG6WgjRaSIvNG4ZJiOfkhMKdzYOm2KelIJ1PUjv3w2pSlHmUfvlS9MOxwP+LeEHcGJum
         Y1sW5EQMm5T4T0nblk3cshxw/BSolvtp7twUkdKo6jCqPuY8bNwGjEi/f8COpbnm8roN
         lNcXSKzrQNz313nNJrXmfuaIK3b5lNwZVZzkAkXSB29X1Jxp84u/Cccm2oatNj7b+r6f
         4rSA==
X-Gm-Message-State: AOJu0YyuHbx5wF5trkkgbw5jXzHZ7AZxUyPTkupxD1PKbNuFMAeTjFmT
	7PzKpHSVcU3nMYw2QrhrPJNWMZvxhYvOH2MNAmalDjsXWu5zhF6j+S3aKIxPeg==
X-Gm-Gg: AZuq6aLdA/QkVBVlvSzgOg2Lvqzjc4o6pQ97DVRM7TBBB82freVUgxq+RMYpM6Vhq+j
	JK4j+i8aeiwwiOs52xF6uNkllxSenhoekI2A0sbVdJnrR1QtsOYXqSf51lvm8LWPpFvNyFBELQC
	AcevRLeDX1Vy/hBCpgxjxX2jhpyC7Zm+eKT92UdVnUV/fT85F5Va4hrgcyUE2urIZAuLBEq/A19
	/QJrFecjJnEJNQlun5S3rjrRQkVHvsnN5u/nQ+akbbsS26tbRtg7xdkeZnWpRiJD8HabGEABumA
	sJS/IcIeMmo4P+cQ3rbJxo+JPUdjxNdFhUWEFMt7M7RXGZiqau5qO5IjBQOf+76VCxYxWpGk1PU
	LZnknH+nt8QKf7aCsvY2TsYxa2PzSkoRwh9zHqVQ/1OVBO27ovX8po/93BG+eyfbH4qDSfzqs8P
	ciUJn9AQFM1ZIU77GXCfs1MA==
X-Received: by 2002:a05:690c:808:b0:795:905:c042 with SMTP id 00721157ae682-7952ab06eccmr67452697b3.40.1770587118087;
        Sun, 08 Feb 2026 13:45:18 -0800 (PST)
Received: from charlesdias.. ([191.22.19.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-796335b9d29sm38549047b3.37.2026.02.08.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:45:17 -0800 (PST)
From: charles.embedded@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: chee.yang.lee@intel.com,
	sandeep.gundlupet-raju@amd.com,
	Charles Dias <charlesdias.cd@outlook.com>
Subject: [meta-zephyr][master][PATCH 2/5] machine: remove -nographic from QB_GRAPHICS
Date: Sun,  8 Feb 2026 18:44:27 -0300
Message-ID: <20260208214430.1048640-3-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260208214430.1048640-1-charles.embedded@gmail.com>
References: <20260208214430.1048640-1-charles.embedded@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 21:45:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3202

From: Charles Dias <charlesdias.cd@outlook.com>

-nographic is not a graphics setting. Drop it from QB_GRAPHICS and let
users request headless mode via `runqemu nographic` when needed.

Signed-off-by: Charles Dias <charlesdias.cd@outlook.com>
---
 meta-zephyr-bsp/conf/machine/mps2-an385.conf      | 2 +-
 meta-zephyr-bsp/conf/machine/mps2-an521.conf      | 2 +-
 meta-zephyr-bsp/conf/machine/mps3-an547.conf      | 2 +-
 meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf | 2 +-
 meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf  | 2 +-
 meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf  | 2 +-
 meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf  | 2 +-
 meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf  | 2 +-
 meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf    | 2 +-
 meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf    | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/meta-zephyr-bsp/conf/machine/mps2-an385.conf b/meta-zephyr-bsp/conf/machine/mps2-an385.conf
index bb67972..081c6dd 100644
--- a/meta-zephyr-bsp/conf/machine/mps2-an385.conf
+++ b/meta-zephyr-bsp/conf/machine/mps2-an385.conf
@@ -11,7 +11,7 @@ TCLIBC = "newlib"
 QB_SYSTEM_NAME = "qemu-system-arm"
 QB_MACHINE = "-machine mps2-an385"
 QB_CPU = "-cpu cortex-m3"
-QB_GRAPHICS = "-nographic -vga none"
+QB_GRAPHICS = "-vga none"
 QB_OPT_APPEND = "-icount shift=7,align=off,sleep=off -rtc clock=vm"
 
 # Zephyr RTOS settings
diff --git a/meta-zephyr-bsp/conf/machine/mps2-an521.conf b/meta-zephyr-bsp/conf/machine/mps2-an521.conf
index fb763ea..ebf8256 100644
--- a/meta-zephyr-bsp/conf/machine/mps2-an521.conf
+++ b/meta-zephyr-bsp/conf/machine/mps2-an521.conf
@@ -13,7 +13,7 @@ QB_SYSTEM_NAME = "qemu-system-arm"
 QB_MACHINE = "-machine mps2-an521"
 QB_CPU = "-cpu cortex-m33"
 QB_MEM = "-m 16"
-QB_GRAPHICS = "-nographic -vga none"
+QB_GRAPHICS = "-vga none"
 QB_OPT_APPEND = "-icount shift=7,align=off,sleep=off -rtc clock=vm"
 
 # Zephyr RTOS settings
diff --git a/meta-zephyr-bsp/conf/machine/mps3-an547.conf b/meta-zephyr-bsp/conf/machine/mps3-an547.conf
index c3ebd2c..ad8c687 100644
--- a/meta-zephyr-bsp/conf/machine/mps3-an547.conf
+++ b/meta-zephyr-bsp/conf/machine/mps3-an547.conf
@@ -12,7 +12,7 @@ TCLIBC = "newlib"
 QB_SYSTEM_NAME = "qemu-system-arm"
 QB_MACHINE = "-machine mps3-an547"
 QB_CPU = "-cpu cortex-m55"
-QB_GRAPHICS = "-nographic -vga none"
+QB_GRAPHICS = "-vga none"
 QB_OPT_APPEND = "-icount shift=7,align=off,sleep=off -rtc clock=vm"
 
 # Zephyr RTOS settings
diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf b/meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf
index 4a511f9..6b097d2 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf
@@ -11,7 +11,7 @@ TCLIBC = "newlib"
 QB_SYSTEM_NAME = "qemu-system-aarch64"
 QB_MACHINE = "-machine virt,secure=on,gic-version=3"
 QB_CPU = "-cpu cortex-a53"
-QB_GRAPHICS = "-nographic -vga none"
+QB_GRAPHICS = "-vga none"
 QB_OPT_APPEND = "-icount shift=4,align=off,sleep=on -rtc clock=vm"
 
 # Zephyr RTOS settings
diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
index e0f6ade..4e42695 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
@@ -12,7 +12,7 @@ TCLIBC = "newlib"
 QB_SYSTEM_NAME = "qemu-system-arm"
 QB_MACHINE = "-machine xilinx-zynq-a9"
 QB_CPU = "-cpu cortex-a9"
-QB_GRAPHICS = "-nographic -vga none"
+QB_GRAPHICS = "-vga none"
 QB_OPT_APPEND = "-icount shift=3,align=off,sleep=off -rtc clock=vm"
 QB_RNG = ""
 
diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf b/meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf
index 9a01efd..59c9305 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf
@@ -14,7 +14,7 @@ TCLIBC = "newlib"
 QB_SYSTEM_NAME = "qemu-system-arm"
 QB_MACHINE = "-machine microbit"
 QB_CPU = "-cpu cortex-m0"
-QB_GRAPHICS = "-nographic -vga none"
+QB_GRAPHICS = "-vga none"
 QB_RNG = ""
 QB_OPT_APPEND = "-icount shift=6,align=off,sleep=off -rtc clock=vm"
 
diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf b/meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf
index 2314dc5..57ec4c3 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf
@@ -10,7 +10,7 @@ ZEPHYR_INHERIT_CLASSES += "zephyr-qemuboot"
 # For runqemu
 QB_SYSTEM_NAME = "qemu-system-arm"
 QB_MACHINE = "-machine lm3s6965evb"
-QB_GRAPHICS = "-nographic -vga none"
+QB_GRAPHICS = "-vga none"
 QB_CPU = "-cpu cortex-m3"
 QB_RNG = ""
 QB_OPT_APPEND = "-icount shift=6,align=off,sleep=off -rtc clock=vm"
diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf b/meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf
index e85a42c..b8917b0 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf
@@ -13,7 +13,7 @@ QB_SYSTEM_NAME = "qemu-system-aarch64"
 QB_MACHINE = "-machine xlnx-zcu102"
 QB_CPU = "-cpu cortex-r5"
 QB_MEM = "-m 64k"
-QB_GRAPHICS = "-nographic -vga none"
+QB_GRAPHICS = "-vga none"
 QB_RNG = ""
 
 # Zephyr RTOS settings
diff --git a/meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf b/meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf
index af5ae5e..8d332be 100644
--- a/meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf
+++ b/meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf
@@ -16,7 +16,7 @@ IMAGE_CLASSES += "qemuboot"
 QB_SYSTEM_NAME = "qemu-system-arm"
 QB_MACHINE = "-machine musca-b1"
 QB_CPU = "-cpu cortex-m33"
-QB_GRAPHICS = "-nographic -vga none"
+QB_GRAPHICS = "-vga none"
 QB_MEM = "512k"
 
 # Zephyr RTOS settings
diff --git a/meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf b/meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf
index be7a42b..072f81f 100644
--- a/meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf
+++ b/meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf
@@ -15,7 +15,7 @@ IMAGE_CLASSES += "qemuboot"
 QB_SYSTEM_NAME = "qemu-system-arm"
 QB_MACHINE = "-machine musca-s1"
 QB_CPU = "-cpu cortex-m33"
-QB_GRAPHICS = "-nographic -vga none"
+QB_GRAPHICS = "-vga none"
 QB_MEM = "512k"
 
 # Zephyr RTOS settings

