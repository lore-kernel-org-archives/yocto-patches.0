Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7652.1795666205008063702
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 20:10:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=HOkm4k0J;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9215934a14cso41878556d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 20:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795666204; x=1796271004; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0EJhXvQMqGJK+iFFR0lwK8ah0qQcygxoEiwdi9VRJm0=;
        b=HOkm4k0JcWAoiaofO2AmXqdv2zrLE9YMy4Ee2ntiQ9HWivol9J4WeSsk0HvBhIcnFa
         Es6F01gLICZ4E8nkg7e4IUOIetTiR7a5XhpvPTw5k3uSQcU3mSCjBQ806Hh7+Sl/d+w4
         QyUc008ocOt3ugQJTP8FodOO7gEI5CZcQTRx+FS+VvQQGZuezs45BVedy1OKBykgL/AN
         HVjce2xp0aObsY3K3JAcp3MHO7DthJxaxOKVRW9dIAy1l9kUn+fllxVc/KrdcVC6XwbN
         +uEw8BYM1BD3JSsIR/5Kpr6ZmpHz2oJMvxhF6MRyVYZI+KyrzDJJUM7X4BXE2SkUbMKP
         mm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795666204; x=1796271004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0EJhXvQMqGJK+iFFR0lwK8ah0qQcygxoEiwdi9VRJm0=;
        b=TdSsN95njphn3Hn/UDGXfIoSxNY4NFZzWCBH/qt0xhlxJdiV2gFgGIqG/v5VTidjtW
         9o/B7BAmhj/O/VLYbZc99o3fnJdG4xF7gmQKvk+V0+jtt/RAdJV/fNAaMU7WrexzvEK6
         8r/40X594jFjLDxXeH2s5ek0cRae8DStZ0fASw08dm78pALYLQYHA/0Zfrp4fDiVWPVg
         b1bMKqPEe//HpGTO7cX6Cza1MhCtDoVCUhnbqyRHeH7P3A2Xrm7RjDtUPLdtKhmCU/bX
         MjEuKfxiED+2KEwsWOR/AipZf/cxHpyj/nFF6sPtI/PAJmBJseBLDHROiNIMpZy4TokM
         B6ig==
X-Gm-Message-State: APuU4Z9DHFMifXpuVqDuy+oBwiTzLQMbNfnfQNw3UpKOCh4IaCTsB47r
	eujb0K0YRRMmFPdBetrHi4dmQFzn4Atu+BrmxZRJPXnkEif5IotB7NxKbdMpJw==
X-Gm-Gg: AZFdTZfE8BK2iTjgFzgRezHa9adSZ5XitD0WqzE/bHYjmWlW1h5Z+x6E5FCN6VZ+lGb
	2JnCS2lOegAFLx2Zxs45ZP12gTC5YDblCUMkbFf0RmJG3UziFcraCl/bvoEtl1tEE0JV4eGYXRb
	8G2aTLaD0L2sPfKDu7A/hfLwkC5T92PAbZxyIG3Pvq/i9gBBUzbOJ5EiKhGxrCSmQgQmsfHuvSV
	B0h2lIMPGOTiTOh+eS894ezDlXe8IVPHucrjAg7m00vomsnaz9HeLHus1K1U5Jb0bJZ21ZN//Hu
	5L6OyKTuRAmfXBHzd00p+mAfAnD+oAetgyrKkG5x3loVTH+DQZNPDDVDUq6HjUTq/tMWZprDcCP
	kggXUSBgLF1uoqgIQcYwLgKKlCXtedEpKKxMPtQKGtWM0w6tnG/0DO4uWeMtHrfiqcoLX+fs5YG
	F7KnAGjur4WS1/R4ox/TGAgx60+YzAs7nVxw83Mf1DQKbCiOYml5wcUS/NEWrH33tUURagSwWH/
	tyQ6AmyqwrczZbnzKK83cAaCDPFrnzbQNKLl34NrN3VkavZqiNqTQyTjsAmVcfuiT17WEjSEMDD
	v4VKZadLu0XL5D+eh6DVJq2szj8xXRSgdbbUgb09r9v215WRARikn0kFEUqvq3UDiD/Jp3bPCCv
	2LhJFozprX2sra/mGedKmdru6KRLASiI=
X-Received: by 2002:a05:6214:8001:b0:921:1ba6:1601 with SMTP id 6a1803df08f44-92134af7403mr325763796d6.55.1795666203792;
        Wed, 25 Nov 2026 20:10:03 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921366d853esm172822016d6.27.2026.11.25.20.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:10:02 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][PATCH v3] add support for upstream RKNPU/RKNN/Rocket HW AI accelerator
Date: Wed, 25 Nov 2026 23:09:56 -0500
Message-ID: <20261126040956.3591113-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Nov 2026 04:10:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5539
Content-Type: text/plain; charset="utf-8"

From: Quentin Schulz <quentin.schulz@cherry.de>

This adds support for the NPU (Neural Processing Unit) found on the
RK3588(S).

The NPU is supported by a kernel driver (CONFIG_DRM_ACCEL_ROCKET),
Device Tree nodes (so not all RK3588 devices supported upstream
necessarily have the NPU declared properly!) and a userspace driver in
mesa (teflon delegate with rocket gallium driver).

This adds a config fragment for linux-rockchip kernels such that the
disabled-by-default Rocket driver is built and enables the Rocket
gallium mesa driver with the teflon delegate, but only when the user
requests its support.

This was tested by running the following:

"""
wget https://gitlab.freedesktop.org/mesa/mesa/-/raw/main/src/gallium/frontends/teflon/tests/classification.py

TEFLON_DEBUG=verbose python3 classification.py \
	     -i /usr/share/label_image/grace_hopper.bmp \
	     -m /usr/share/label_image/mobilenet_v1_1.0_224_quant.tflite \
	     -l /usr/share/label_image/labels_mobilenet_quant_v1_224.txt \
	     -e /usr/lib/libteflon.so
"""

from an image built with meta-tensorflow's tensorflow-lite, mesa's
libteflon, meta-openembedded's python3-pillow and OE-Core's
python3-numpy packages.

Note that the Aarch64 RK35xx SoCs all have an NPU, but only RK3588's is
currently supported in the kernel.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
AI-Generated: codex/claude-opus 5.5 (max)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v3:
- rebase onto current master; it needed git am --3way against the kernel
  config fragment list
- gate the fragment and the mesa PACKAGECONFIG with
  bb.utils.to_boolean(d.getVar(...)) rather than oe.utils.vartrue().
  vartrue() passes the variable name as a string literal, which
  bitbake's code parser does not track, so the do_kernel_configme
  signature did not change when ENABLE_UPSTREAM_RKNPU was toggled and
  nothing rebuilt in either direction. This idiom is tracked and matches
  the other knobs in the layer
- drop the kernel version from the README note, which said v7.0 while
  the layer builds 7.2
---
 README                                        | 20 +++++++++++++++++++
 recipes-graphics/mesa/mesa.bbappend           |  4 ++++
 recipes-kernel/linux/linux-rockchip.inc       |  1 +
 .../bsp/rockchip/rocket-npu.cfg               |  2 ++
 .../bsp/rockchip/rocket-npu.scc               |  1 +
 5 files changed, 28 insertions(+)
 create mode 100644 recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg
 create mode 100644 recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc

diff --git a/README b/README
index c2697d1b9070..f94e92a80e7e 100644
--- a/README
+++ b/README
@@ -222,6 +222,26 @@ Notes:
 	NOTE: this variable must be set before any include/require in the
 	      machine configuration file
 
+  Neural Processing Unit (NPU)
+
+	The Aarch64 RK35xx SoCs have a Neural Processing Unit (NPU) available.
+	It is typically named by Rockchip as RKNPU/RKNN but upstream has decided
+	to use Rocket instead. At the time of writing, only RK3588's NPU is
+	supported upstream.
+
+	This NPU is an AI hardware-accelerator. You can enable its support by
+	setting:
+
+		ENABLE_UPSTREAM_RKNPU = "1"
+
+	This requires a kernel driver (CONFIG_DRM_ACCEL_ROCKET, v6.18+) and
+	RKNN Device Tree nodes
+	(e.g. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=640366d644b1e282771a09c72be37162b6eda438).
+	The mesa userspace driver (rocket gallium driver) and teflon delegate
+	are automatically compiled when this option is enabled. You need to add
+	the libteflon package to your image to be able to use the teflon
+	delegate.
+
 U-Boot Environment:
 ------------------
 	In order to configure U-Boot to be able to store its environment into the
diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
index d9e7c082fc6b..362eced535f9 100644
--- a/recipes-graphics/mesa/mesa.bbappend
+++ b/recipes-graphics/mesa/mesa.bbappend
@@ -10,5 +10,9 @@ MALI_DRIVER:rk3308 = ""
 PACKAGECONFIG:append:rockchip = " ${@bb.utils.filter('MALI_DRIVER', 'lima panfrost', d)}"
 PACKAGECONFIG:append:rockchip = "${@bb.utils.contains('MALI_DRIVER', 'panfrost', ' libclc', '', d)}"
 
+# Enable teflon for upstream RKNPU/rocket support
+# Requires CONFIG_DRM_ACCEL_ROCKET in Linux kernel to actually work
+PACKAGECONFIG:append:rk3588s = "${@' teflon rocket' if bb.utils.to_boolean(d.getVar('ENABLE_UPSTREAM_RKNPU'), False) else ''}"
+
 # Mali Gen10 (Valhall, supported by Panthor) requires a firmware blob
 RRECOMMENDS:mesa-megadriver:append:rk3588s = " linux-firmware-mali-csffw-arch108"
diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
index b87cb7a14bf8..f91492ee7968 100644
--- a/recipes-kernel/linux/linux-rockchip.inc
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -37,3 +37,4 @@ SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
 KERNEL_FEATURES:append:rockchip = " bsp/rockchip/lttng.scc"
 KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
+KERNEL_FEATURES:append:rockchip = "${@' bsp/rockchip/rocket-npu.scc' if bb.utils.to_boolean(d.getVar('ENABLE_UPSTREAM_RKNPU'), False) else ''}"
diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg
new file mode 100644
index 000000000000..9f6af63928c6
--- /dev/null
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg
@@ -0,0 +1,2 @@
+CONFIG_DRM_ACCEL=y
+CONFIG_DRM_ACCEL_ROCKET=y
diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc
new file mode 100644
index 000000000000..a8b42778aa22
--- /dev/null
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc
@@ -0,0 +1 @@
+kconf hardware rocket-npu.cfg
-- 
2.50.0.173.g8b6f19ccfc3a

