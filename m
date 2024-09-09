Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE4ECE579
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 14:56:04 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web10.55095.1725893761764224392
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 07:56:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WvWl2SLg;
 spf=pass (domain: gmail.com, ip: 209.85.210.54, mailfrom: twoerner@gmail.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710daaadd9bso700880a34.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725893760; x=1726498560; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9FklKfJXoFE3ZTBwXHiyMcSbF1pYZIhhqlDXbUPtWg=;
        b=WvWl2SLgcuzGqui2sMUbm8QndSvyc4xY3voHdAStb+npm5yndp7R6UJgvlN7L/GXTc
         n3ljgAi78BCgfLiSc878Llu3Rl7kKQ+mfJ1WawUgUQbXTsfBQjLID4pRnDzg6sS69IyW
         JxHbTbYOo93ZxhrTrrfRpP1RTctgkapdrau8+lOfAN9HlaDD2By9bdTpJ/LveBtlBdrL
         E1oK82nxRy4Z8vn3WgGac8Yp28Pjn27pBDlmFrbjSSluMGEXVtXIazeUTvJFNklubpNY
         9eeZjHcEPxbv71mtefhnsmIJ4RimYmNYBCkLS3oMqnd4b3J+mrmg9RO4gZCjM5FQMdfS
         0zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893760; x=1726498560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9FklKfJXoFE3ZTBwXHiyMcSbF1pYZIhhqlDXbUPtWg=;
        b=cE6iRUDMDP+MCpgHD2xivXin03ne6pPYVvDepVcxuG1ycvWZwEvi032tm6mmknqOLO
         LnngXNcjQIEqPj6vIjiuqEwZp6W+kLCTSAdV2WOLLIg3HTfLM9tR+GtpNNaRaH2+JdpI
         XAX0B/MQLj5Q7OA1c4EzvUfDOhpyyF06xJiLoUnLQvZpuNnAIyMTKGqGP+ERrwG1KHGN
         cEe0nmWiLm1J1YhPaWndyPQ+Huqve/94zrBkWOSJqkuUjmKIURnDh7iCYLogBMHBmpFG
         93rhp/i0c0eG2Pq0om+GsUcIt0Y/VGBeDxc9hJaRdQizGk5WTI6LQIdrfCz99NmVDoOJ
         wS7g==
X-Gm-Message-State: AOJu0YxQJu7KtUk1BxsnxEfShertwcY5GCJezakMd8VJCRcsCSsMGOPC
	Oj1uETdET8Wo+pLMOSjGPgNXYPZXr0tGflp/WYl7ECv6cYtvnESfrlKD9pr/
X-Google-Smtp-Source: AGHT+IFzzHg41NyPDWzpuD9Fod8mKL4PdGjx8nEVrTN8sH8RuR9rAnZ/gIZRdg7MqMmlJiWyIW6J0g==
X-Received: by 2002:a05:6830:2b11:b0:703:5fbe:e0ca with SMTP id 46e09a7af769-710d838ac0fmr4509563a34.4.1725893760188;
        Mon, 09 Sep 2024 07:56:00 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e772a2sm21050231cf.27.2024.09.09.07.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:55:59 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][scarthgap][PATCH 09/10] enable HW VPU decoding for SoCs that have stateless VPUs
Date: Mon,  9 Sep 2024 10:55:29 -0400
Message-ID: <20240909145530.25301-10-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240909145530.25301-1-twoerner@gmail.com>
References: <20240909145530.25301-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 14:56:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/635

From: Quentin Schulz <quentin.schulz@cherry.de>

v4l2codecs is the gstreamer plugin for V4L2 stateless video hardware
decoding. The Rockchip SoCs that have a VPU all seems to be based on
Hantro, RKVDEC or RKVDECv2, all stateless encoding/decoding VPUs.

Therefore, let's enable VPU decoding in Gstreamer whenever possible,
when the SoC supports it.

PX30, RK3066, RK3188, RK3288, RK3328, RK3399, RK356x and RK3588(s) all
have at least one Hantro VPU.

RK3328, RK3399, RK356x and RK3588(s) all have at least one
RKVDEC/RKVDECv2 VPU (though not necessarily supported in the upstream
kernel just yet).

=== PX30
Tested on PX30 Ringneck with with Haikou+Haikou Video Demo adapter:

$ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! waylandsink

with FILE storing the path to any h264 file, e.g.
https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_720p_h264.mov
https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov

Needed packages are:
- weston
- gstreamer1.0-plugins-bad (for waylandsink and v4l2slh264dec)
- gstreamer1.0-plugins-base (for parsebin)

A few frames are dropped every other second for 1080p but otherwise
smooth.

=== RK3399
Tested on RK3399 Puma with Haikou:

$ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! waylandsink

with FILE storing the path to any h264 file, e.g.
https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
https://download.blender.org/demo/movies/BBB/bbb_sunflower_2160p_30fps_normal.mp4.zip

Needed packages are:
- weston
- gstreamer1.0-plugins-bad (for waylandsink and v4l2codecs)
- gstreamer1.0-plugins-base (for parsebin)

=== RK3588

Tested on a RK3588 Tiger with Haikou+Haikou Video Demo adapter - on a
downstream v6.6 (upstream-based, not Rockchip BSP-based) with DSI
patches - :

$ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slav1dec ! fakesink

with FILE storing the path to any AV1 file, e.g.
http://download.opencontent.netflix.com.s3.amazonaws.com/AV1/cmaf/spark-8b-59.94fps/spark_606kbps_432p.mp4
https://woolyss.com/f/av1-nosound-chimera.mp4
https://woolyss.com/f/av1-opus-sita.webm

Needed packages are:
- gstreamer1.0-plugins-bad (for fakesink and v4l2slav1dec)
- gstreamer1.0-plugins-base (for parsebin)

For some reason though, waylandsink is very choppy. Combining
fpsdisplaysink with fakesink shows a ~60fps when decoding the 432p file,
~24fps for the two others.
Note that 10b-depth isn't supported (at least in my setup).

Reviewed-by: Trevor Woerner <twoerner@gmail.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 README                                        | 22 +++++++++++++++++++
 conf/machine/include/px30.inc                 |  2 ++
 conf/machine/include/rk3066.inc               |  2 ++
 conf/machine/include/rk3188.inc               |  2 ++
 conf/machine/include/rk3288.inc               |  2 ++
 conf/machine/include/rk3328.inc               |  2 ++
 conf/machine/include/rk3399.inc               |  2 ++
 conf/machine/include/rk3566.inc               |  2 ++
 conf/machine/include/rk3568.inc               |  2 ++
 conf/machine/include/rk3588s.inc              |  2 ++
 .../gstreamer1.0-plugins-bad_%.bbappend       |  1 +
 11 files changed, 41 insertions(+)
 create mode 100644 recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend

diff --git a/README b/README
index 8ff006e942b9..09f8691300f4 100644
--- a/README
+++ b/README
@@ -103,6 +103,28 @@ Notes:
 	this layer, perform the same steps as above except for the step enabling
 	RK_RAUC_DEMO.
 
+  HW video decoding with gstreamer
+
+	Most Rockchip SoCs have some integrated VPU, either Hantro, RKVDEC or
+	RKVDECv2. Those are called stateless VPUs and they require tools to be
+	adapted so they can be used. Upstream ffmpeg doesn't support them (yet)
+	but gstreamer does, via the v4l2sl* plugins. However, by default those
+	aren't built in OE-Core. This layer enables these plugins by default for
+	all SoCs that have at least one VPU (at the time of writing, all SoCs
+	supported by this layer to the exception of RK3308).
+
+	If you wish to NOT build those plugins anymore, you can set
+
+		ENABLE_STATELESS_VPU_GST = "0"
+
+	in any appropriate conf file (or in a
+	gstreamer1.0-plugins-bad_%.bbappend in your own layer).
+
+	Note that this is only relevant for upstream-based Linux kernels as
+	Rockchip have developed their own ABI for their own kernel that isn't
+	compatible (see Rockchip Media Process Platform (MPP) and
+	downstream gstreamer-rockchip plugin for those kernels).
+
 U-Boot Environment:
 ------------------
 	In order to configure U-Boot to be able to store its environment into the
diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
index d78409ee5c7e..8173cb19be2c 100644
--- a/conf/machine/include/px30.inc
+++ b/conf/machine/include/px30.inc
@@ -19,3 +19,5 @@ TFA_BUILD_TARGET = "bl31"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3066.inc b/conf/machine/include/rk3066.inc
index 026d5b556db7..a898309bbf88 100644
--- a/conf/machine/include/rk3066.inc
+++ b/conf/machine/include/rk3066.inc
@@ -12,3 +12,5 @@ SERIAL_CONSOLES = "115200;ttyS2"
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3066 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_IMAGETYPE ?= "zImage"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3188.inc b/conf/machine/include/rk3188.inc
index 0120e2fd585f..554d4f1c904d 100644
--- a/conf/machine/include/rk3188.inc
+++ b/conf/machine/include/rk3188.inc
@@ -12,3 +12,5 @@ SERIAL_CONSOLES = "115200;ttyFIQ0"
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3188 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_IMAGETYPE ?= "zImage"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
index 684e8645d176..06fda69a3eb7 100644
--- a/conf/machine/include/rk3288.inc
+++ b/conf/machine/include/rk3288.inc
@@ -14,3 +14,5 @@ KERNEL_FEATURES:append:rk3288 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_IMAGETYPE ?= "zImage"
 
 UBOOT_SUFFIX ?= "bin"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
index 4ecd6814f9ba..e6f810dcd2ca 100644
--- a/conf/machine/include/rk3328.inc
+++ b/conf/machine/include/rk3328.inc
@@ -20,3 +20,5 @@ TFA_BUILD_TARGET = "bl31"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
index 47f0560d1578..cd1be49064ed 100644
--- a/conf/machine/include/rk3399.inc
+++ b/conf/machine/include/rk3399.inc
@@ -20,3 +20,5 @@ TFA_BUILD_TARGET = "bl31"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
index 586d68806df6..2522851fa392 100644
--- a/conf/machine/include/rk3566.inc
+++ b/conf/machine/include/rk3566.inc
@@ -19,3 +19,5 @@ PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
index 1da212a1530c..db188a311297 100644
--- a/conf/machine/include/rk3568.inc
+++ b/conf/machine/include/rk3568.inc
@@ -19,3 +19,5 @@ PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index cd84461dab41..d349108fb973 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -18,3 +18,5 @@ PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend b/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend
new file mode 100644
index 000000000000..276230411e9c
--- /dev/null
+++ b/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend
@@ -0,0 +1 @@
+PACKAGECONFIG:append:rockchip = "${@' v4l2codecs' if bb.utils.to_boolean(d.getVar('ENABLE_STATELESS_VPU_GST'), False) else ''}"
-- 
2.44.0.478.g7774cfed6261


