Return-Path: <charles.embedded@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BADEEF06F8
	for <webhook@archiver.kernel.org>; Sun,  8 Feb 2026 21:45:32 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34795.1770587123125635614
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Feb 2026 13:45:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JL+O4Rph;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: charles.embedded@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7963af509f0so7042197b3.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 13:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587122; x=1771191922; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK5wTcJEkU3X15myrd9kNQVu6Y6TIquJzDgnfzrJbuc=;
        b=JL+O4RphWNpzOk9h08QppMoJDw99EgKkKOeUAzRmd2BE+ApnjaexkhLXVrTF5TdzQ2
         mf539gevG8g8Baik+H7XLrKRi+lTKVmSrN5pdYMNGbqp4azif8hfJuxPoJdEtfyaj5+4
         BeJFDsdu2H+k1+0WxO2JLPGAU1TIZ4JXEWjQX6C5u8OMVGw+3z8k7k471CNujk6bC7Fp
         EAj9F2NKiodyykMxrzJz32Y0nV87qABuNj78sIrM2dSjl9cb4cq7slMfIEfWbnLjaGoN
         SzoX2djG607bGk2qJ430CSvsKvMmBj0gHaiUqusGdrbX7RjiFaj7gWjC4LR+DiYtMBCy
         8HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587122; x=1771191922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sK5wTcJEkU3X15myrd9kNQVu6Y6TIquJzDgnfzrJbuc=;
        b=cB9JYchkA6DX72bz9T2LTHeRaZRrjLDns4Fh0EK4aicSETcG7gSYstBTtPbGrhMxML
         mB5PWCE9UQ6WnfvvIYMPaE2xBArfXetdauwIqPXdsMMlq6nScmjzsnOdwLQg242X1Qlw
         f8sc+nQEd/nfXmdqoSfBksa0HRQOQhoImSibWa5DiLrjAig1LLfZ4L3u2++A8Q8HAqGE
         c8C1LKrX8NuoVlC1LdZ5xIdLP9GEAZPghN2ryanJzEEyBVjc361rTgPOYns2aqmPzcCp
         o5UeOZvWnElJah3oY0hhu034uD8eiTiuLTS3TXSTH8ABIVLswq6+WMblySJQ6z0RRF+1
         1hdg==
X-Gm-Message-State: AOJu0YxfUQ10ElBqZuMO2jYH46Hv+Gr/xzcaZ45lvzuzhwAGJuj0aiU0
	+0WdVzFlPIgvU9kPBUqLQTKRl17T1Di74Ej3CpXTut43cbbXoBJyZziuNUgKxg==
X-Gm-Gg: AZuq6aJFJR21R1pPyHHmNL1X6iqDlovvuaTSiwEKAShTgyX753EZXjs3Ib6Q9ETkaRs
	XJdivcPPofFQB9V6h4ABV23t20RVmmCEDUtXJvpTlAXg2YnNhdRMzg2G9n5SWMFcPiZVDzvyqQK
	Xd8uoU+kTHuGLWSaHFwrlIhoCCsTyS8wPwUM1Ndcz9Od/hA8H9JCfK5af4pkSffdGBA7V70CRko
	2DoJJQhAbTVA8ROu0ZgyG9c9IivDjRq31iSABYaIgRNxhesoZSN9xgWooD2Sid2QM37i5ZVYkEX
	FoNDKPlsKh6S3eI/yL9HRsKWSuJ4/S8WejyDBju9lgA+4WozpfUbA+BvKeuR8F7NdT5M28hNh2m
	OG7qCTB3HP7DhpIUCjkCfxOip6TCWmFfIE6we26XeD4qrR0xqhG3v8wSaNMyKcS9GX4D9FXeETr
	DwAcK6AJB1nM4aNkeLSmSTgA==
X-Received: by 2002:a05:690c:4c0f:b0:796:2fde:5dfa with SMTP id 00721157ae682-7962fde67f0mr59459687b3.50.1770587121845;
        Sun, 08 Feb 2026 13:45:21 -0800 (PST)
Received: from charlesdias.. ([191.22.19.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-796335b9d29sm38549047b3.37.2026.02.08.13.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:45:21 -0800 (PST)
From: charles.embedded@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: chee.yang.lee@intel.com,
	sandeep.gundlupet-raju@amd.com,
	Charles Dias <charlesdias.cd@outlook.com>
Subject: [meta-zephyr][master][PATCH 3/5] machine: mps2/mps3: add missing QEMU and Zephyr board settings
Date: Sun,  8 Feb 2026 18:44:28 -0300
Message-ID: <20260208214430.1048640-4-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260208214430.1048640-1-charles.embedded@gmail.com>
References: <20260208214430.1048640-1-charles.embedded@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 08 Feb 2026 21:45:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3203

From: Charles Dias <charlesdias.cd@outlook.com>

Update MPS2 and MPS3 machine configurations:

- Add ZEPHYR_BOARD with the current Zephyr board identifiers
  (mps2/an385, mps2/an521/cpu0, mps3/corstone300/an547).
- Add QB_RNG = "" to disable virtio-rng, which is unsupported on
  these machines.
- Add QB_MEM to explicitly set memory (16 MB for mps2-an385,
  2048 MB for mps3-an547; mps2-an521 already had it).

Signed-off-by: Charles Dias <charlesdias.cd@outlook.com>
---
 meta-zephyr-bsp/conf/machine/mps2-an385.conf | 3 +++
 meta-zephyr-bsp/conf/machine/mps2-an521.conf | 2 ++
 meta-zephyr-bsp/conf/machine/mps3-an547.conf | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/meta-zephyr-bsp/conf/machine/mps2-an385.conf b/meta-zephyr-bsp/conf/machine/mps2-an385.conf
index 081c6dd..173acce 100644
--- a/meta-zephyr-bsp/conf/machine/mps2-an385.conf
+++ b/meta-zephyr-bsp/conf/machine/mps2-an385.conf
@@ -11,8 +11,11 @@ TCLIBC = "newlib"
 QB_SYSTEM_NAME = "qemu-system-arm"
 QB_MACHINE = "-machine mps2-an385"
 QB_CPU = "-cpu cortex-m3"
+QB_MEM = "-m 16"
 QB_GRAPHICS = "-vga none"
 QB_OPT_APPEND = "-icount shift=7,align=off,sleep=off -rtc clock=vm"
+QB_RNG = ""
 
 # Zephyr RTOS settings
+ZEPHYR_BOARD = "mps2/an385"
 ZEPHYR_INHERIT_CLASSES += "zephyr-qemuboot"
diff --git a/meta-zephyr-bsp/conf/machine/mps2-an521.conf b/meta-zephyr-bsp/conf/machine/mps2-an521.conf
index ebf8256..138ae01 100644
--- a/meta-zephyr-bsp/conf/machine/mps2-an521.conf
+++ b/meta-zephyr-bsp/conf/machine/mps2-an521.conf
@@ -15,6 +15,8 @@ QB_CPU = "-cpu cortex-m33"
 QB_MEM = "-m 16"
 QB_GRAPHICS = "-vga none"
 QB_OPT_APPEND = "-icount shift=7,align=off,sleep=off -rtc clock=vm"
+QB_RNG = ""
 
 # Zephyr RTOS settings
+ZEPHYR_BOARD = "mps2/an521/cpu0"
 ZEPHYR_INHERIT_CLASSES += "zephyr-qemuboot"
diff --git a/meta-zephyr-bsp/conf/machine/mps3-an547.conf b/meta-zephyr-bsp/conf/machine/mps3-an547.conf
index ad8c687..64f91c6 100644
--- a/meta-zephyr-bsp/conf/machine/mps3-an547.conf
+++ b/meta-zephyr-bsp/conf/machine/mps3-an547.conf
@@ -12,8 +12,11 @@ TCLIBC = "newlib"
 QB_SYSTEM_NAME = "qemu-system-arm"
 QB_MACHINE = "-machine mps3-an547"
 QB_CPU = "-cpu cortex-m55"
+QB_MEM = "-m 2048"
 QB_GRAPHICS = "-vga none"
 QB_OPT_APPEND = "-icount shift=7,align=off,sleep=off -rtc clock=vm"
+QB_RNG = ""
 
 # Zephyr RTOS settings
+ZEPHYR_BOARD = "mps3/corstone300/an547"
 ZEPHYR_INHERIT_CLASSES += "zephyr-qemuboot"

