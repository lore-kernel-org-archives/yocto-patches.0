Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B00C5AD49
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 17:22:09 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web11.971.1748625728567705798
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 May 2025 10:22:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dVyegQlk;
 spf=pass (domain: gmail.com, ip: 209.85.222.178, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c597760323so230249985a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 30 May 2025 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748625726; x=1749230526; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TNz44d9oFJcagg5i2TBwIVUe59vt4gBKcbYXohVgkU0=;
        b=dVyegQlkRG6cV9ryhKh5RQWsKIwLKv5/6YKQn7zFLTolcPoz2NSw745iK/q+H80S5Z
         Mc0e6Dnd8QpKK7yhUQNqQOEOhcbiJ9IYbhuhMMjDy3lhftFdyu2mSzr7ebdJKvx+iuLk
         ejURpRBM/3z97na8dZ/D05ckspa4b7C4UOK0zF/2pkUSfoOdpaCyq791kMWmc1LjME8T
         b5l/QT6b2l0+IQ1iNe4rwLz3RthuDYD4p3sjz6FQP1hGGWsK+771YxeeiXwGevUNBGri
         jMPbL7/eTKVVKlluLRLZ9cTkurksw2U1ykh4aLvFlvzT5o993af2cdRDutcOYXarCm6c
         0BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748625726; x=1749230526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNz44d9oFJcagg5i2TBwIVUe59vt4gBKcbYXohVgkU0=;
        b=ga298aB7D8MyS1UunqzH/50Zfvo+nPOu/WVw4ba2Sadkrk7qhQI6Hv/qhkz8Fi8SWS
         wVseXEJsHpN51i32eSLai0kPdgHwRRsGhO/r454L5j7vTEifpdB9mHE1FdhyvR1lcHML
         8L2SvrxPxJix9ewS4egBu4SIEXxGf8dfeaZRy7gRDMqlJex6HPMb12UTUjhOCAhLDC6g
         p3VUt5zeYHqLRwI0L9AarEpsOokvuGTerqrEwrXbCqNut/42ZjT2tius2n3S3Xl6QGfc
         fZyHvGxHGfYG6/fG3kX/tDSa/opIUAmjbChFH9pcYxL4NdBz2ODGDlC4hSujrm+3sIQe
         SFeQ==
X-Gm-Message-State: AOJu0YxQ0z4OMM3xDtlotMCan74R4IhklAC4VcxTuh0GbVfCr7tVKLAn
	45STGxDkcUwAG5LRv4H7ti1UCskvdB0yepA84K+/NVSge8+iQwIzJ7Q9eGaoVA==
X-Gm-Gg: ASbGncsUTcUIbzw6Bir77CKIvY6Dk26NZVGYdCk7j+QenxEQgF/2EwydmV92qzIN5f0
	UdbuUkT7NZSLi9syeCQJzFcIL3UCYbGj7Dp68XrB9uXXKX7S3Lkb1jo0kflsUkJCtqG3nrICNuF
	9EZjqoP6qz0Qaf6P53SP+rDv3bS/tW1b9QWRtVZ6iXb195tEeffCBM6Svu20MZD25l7axNzY8gs
	N0GVyIB43XFWprRzncJNHTJZQkJhdEvreKtMiSn6uJz7j2kphH42JxyH8iX6WvkwERDr7jTXalI
	5Faeya/i+hN1kWj4ukxbCKShDJgs566ZeYI9EMy9zT901YzYYTL+cl4tx42VETMROcvNIrYJx4t
	cLHZ7djsXWv4F9pVXyOk=
X-Google-Smtp-Source: AGHT+IGmkxNeCubah3CEspdQd8swDFx6VSB9qJrK2gPRBOWUphfr9ymEQm4pyoMlCmGhtrqDJCwYYw==
X-Received: by 2002:a05:620a:3954:b0:7cd:3b13:c5b4 with SMTP id af79cd13be357-7d0a1fb7580mr640950885a.24.1748625726351;
        Fri, 30 May 2025 10:22:06 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a195d7dsm264984385a.78.2025.05.30.10.22.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 10:22:05 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 1/3] refactor mesa packageconfig
Date: Fri, 30 May 2025 13:21:54 -0400
Message-ID: <20250530172156.7199-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 May 2025 17:22:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1600

Add a new variable, RK_MESA_DRIVER, to allow the user to choose which mesa
"driver" they want to use for their mesa backend. By default set it to either
"panfrost" or "lima" depending on the SoC family being used.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 README                              | 5 +++++
 conf/machine/include/px30.inc       | 1 +
 conf/machine/include/rk3288.inc     | 1 +
 conf/machine/include/rk3328.inc     | 1 +
 conf/machine/include/rk3399.inc     | 1 +
 conf/machine/include/rk3566.inc     | 1 +
 conf/machine/include/rk3568.inc     | 1 +
 conf/machine/include/rk3588s.inc    | 1 +
 recipes-graphics/mesa/mesa.bbappend | 9 ++-------
 9 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/README b/README
index 9672c6ab8d5b..97d06eaefd63 100644
--- a/README
+++ b/README
@@ -159,6 +159,11 @@ Notes:
 	compatible (see Rockchip Media Process Platform (MPP) and
 	downstream gstreamer-rockchip plugin for those kernels).
 
+  mesa backend
+	Use the variable RK_MESA_DRIVER to select which mesa backend to use
+	for mesa. By default it is set to either "panfrost" or "lima"
+	depending on SoC.
+
 U-Boot Environment:
 ------------------
 	In order to configure U-Boot to be able to store its environment into the
diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
index 8173cb19be2c..4918ee45d1ab 100644
--- a/conf/machine/include/px30.inc
+++ b/conf/machine/include/px30.inc
@@ -21,3 +21,4 @@ UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
+RK_MESA_DRIVER ?= "panfrost"
diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
index 06fda69a3eb7..0fccae7896aa 100644
--- a/conf/machine/include/rk3288.inc
+++ b/conf/machine/include/rk3288.inc
@@ -16,3 +16,4 @@ KERNEL_IMAGETYPE ?= "zImage"
 UBOOT_SUFFIX ?= "bin"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
+RK_MESA_DRIVER ?= "panfrost"
diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
index e6f810dcd2ca..cdc2e2df2703 100644
--- a/conf/machine/include/rk3328.inc
+++ b/conf/machine/include/rk3328.inc
@@ -22,3 +22,4 @@ UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
+RK_MESA_DRIVER ?= "lima"
diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
index cd1be49064ed..06326946f1e3 100644
--- a/conf/machine/include/rk3399.inc
+++ b/conf/machine/include/rk3399.inc
@@ -22,3 +22,4 @@ UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
+RK_MESA_DRIVER ?= "panfrost"
diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
index 6386ec7eb51c..4d84bf8a11a2 100644
--- a/conf/machine/include/rk3566.inc
+++ b/conf/machine/include/rk3566.inc
@@ -24,3 +24,4 @@ TFA_PLATFORM = "rk3568"
 TFA_BUILD_TARGET = "bl31"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
+RK_MESA_DRIVER ?= "panfrost"
diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
index bcf9dd8b0f44..dedda3b8f47e 100644
--- a/conf/machine/include/rk3568.inc
+++ b/conf/machine/include/rk3568.inc
@@ -24,3 +24,4 @@ TFA_PLATFORM = "rk3568"
 TFA_BUILD_TARGET = "bl31"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
+RK_MESA_DRIVER ?= "panfrost"
diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index 6ec344abae5b..5a085ab29ebc 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -23,3 +23,4 @@ TFA_PLATFORM = "rk3588"
 TFA_BUILD_TARGET = "bl31"
 
 ENABLE_STATELESS_VPU_GST ?= "1"
+RK_MESA_DRIVER ?= "panfrost"
diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
index f22280754a14..9e9bf9afc4a0 100644
--- a/recipes-graphics/mesa/mesa.bbappend
+++ b/recipes-graphics/mesa/mesa.bbappend
@@ -1,9 +1,4 @@
-PACKAGECONFIG:append:rk3288 = " panfrost"
-PACKAGECONFIG:append:rk3328 = " lima"
-PACKAGECONFIG:append:rk3399 = " panfrost"
-PACKAGECONFIG:append:rk3566 = " panfrost"
-PACKAGECONFIG:append:rk3568 = " panfrost"
-PACKAGECONFIG:append:rk3588s = " panfrost"
-PACKAGECONFIG:append:px30 = " panfrost"
+PACKAGECONFIG:append:rockchip = " ${@bb.utils.contains('RK_MESA_DRIVER', 'panfrost', 'panfrost', '', d)}"
+PACKAGECONFIG:append:rockchip = " ${@bb.utils.contains('RK_MESA_DRIVER', 'lima', 'lima', '', d)}"
 
 RRECOMMENDS:mesa-megadriver:append:rk3588s = " linux-firmware-mali-csffw-arch108"
-- 
2.44.0.478.g7774cfed6261


