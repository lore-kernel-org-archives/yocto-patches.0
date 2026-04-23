Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85121FDEE25
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 16:19:54 +0000 (UTC)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1607.1776961189425820024
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Apr 2026 09:19:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=kaYY7zGQ;
 spf=pass (domain: 0leil.net, ip: 84.16.66.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g1hBW1GgRzjcn;
	Thu, 23 Apr 2026 18:19:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1776961187;
	bh=ZaHRhQRNrSpXSox620LRxn4iSb2WBpumbt310WKUPB4=;
	h=From:Date:Subject:To:Cc:From;
	b=kaYY7zGQEuU4Tvd50yyKYnjZcZpeS2ktZXPsOFEkD2NgOVg7tYNDilDUlDVTCTTlb
	 e8ijDjRMpC9zx1XnD3LlHK0EwKFpFyNLi14L0263h+8USXD/fQ62MljqfavObMv1iM
	 0iS5JSInivDygJkz2CQ+tCk9L/LDKaVdjOZjv4MkvFKYm5M17geZn3Pl9IeCf8orp8
	 O1Dj3MJNq/tSlRE/GGIUrM4ew9dF9fT9V4TR9LhZjWKox6iaXXrkfmuzNaInOJvD8B
	 BqBTbBXtbn8YQ5J36FRwsV4bgB6NNjJ6nFIFWOEJtq2FkwYgq3/0LnO5HacrKjp1Yy
	 9ZzpIPBN9huuA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4g1hBV2RjszWyP;
	Thu, 23 Apr 2026 18:19:46 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 23 Apr 2026 18:19:37 +0200
Subject: [meta-rockchip PATCH v2] add support for upstream
 RKNPU/RKNN/Rocket HW AI accelerator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-rknn-v2-1-b9457a38c140@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQqDMBAFf0Xe2YBkpdj+SvEQt6tupVE2thTEf
 2+qx2GG2ZDEVBJuxQaTjyadYwZfFuAxxEGcPjLDV/5S1Z6cTTE6CnSt+0DcNYScLia9fo/NHS9
 Zg7OZJx51QXvq9O6ewut/hX3/AaI1eyF3AAAA
X-Change-ID: 20260423-rknn-3a394fa3cb83
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 16:19:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3780

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
---
This was tested on RK3588 Jaguar with linux-yocto 6.18 +
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=843b912c7241ed0259f6234243da05e10ce67c0f

Note this (lightly) depends on
https://lore.kernel.org/yocto-patches/20260423-python3-14-tflite-v1-3-68bca178a550@cherry.de/
being merged in meta-tensorflow. Another option is to simply add
"tensorflow" to DISTRO_FEATURES to pass the (useless) check.
---
Changes in v2:
- switched to oe.utils.vartrue from bb.utils.to_boolean
- driver now built-in instead of as module since the necessary patches
  have been backported to the 6.18 stable kernel version currently in
  OE-Core via linux-yocto_6.18,
- updated commit log now that meta-tensorflow is usable without hacks,
  and filepaths for input files to classification.py have changed with
  newer tflite,
- reworded README to specify libteflon needs to be installed in the
  image manually but the mesa rocket driver and teflon delegate are
  automatically built if the variable is properly set,
- Link to v1: https://lore.kernel.org/yocto-patches/20260128-rknn-v1-1-363d7ef2c16c@cherry.de/
---
 README                                               | 20 ++++++++++++++++++++
 recipes-graphics/mesa/mesa.bbappend                  |  4 ++++
 recipes-kernel/linux/linux-rockchip.inc              |  1 +
 .../rockchip-kmeta/bsp/rockchip/rocket-npu.cfg       |  2 ++
 .../rockchip-kmeta/bsp/rockchip/rocket-npu.scc       |  1 +
 5 files changed, 28 insertions(+)

diff --git a/README b/README
index c2697d1..6d9db9b 100644
--- a/README
+++ b/README
@@ -222,6 +222,26 @@ Notes:
 	NOTE: this variable must be set before any include/require in the
 	      machine configuration file
 
+  Neural Processing Unit (NPU)
+
+	The Aarch64 RK35xx SoCs have a Neural Processing Unit (NPU) available.
+	It is typically named by Rockchip as RKNPU/RKNN but upstream has decided
+	to use Rocket instead. At the time of writing (Linux kernel v7.0), only
+	RK3588's NPU is supported upstream.
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
index d9e7c08..69a210f 100644
--- a/recipes-graphics/mesa/mesa.bbappend
+++ b/recipes-graphics/mesa/mesa.bbappend
@@ -10,5 +10,9 @@ MALI_DRIVER:rk3308 = ""
 PACKAGECONFIG:append:rockchip = " ${@bb.utils.filter('MALI_DRIVER', 'lima panfrost', d)}"
 PACKAGECONFIG:append:rockchip = "${@bb.utils.contains('MALI_DRIVER', 'panfrost', ' libclc', '', d)}"
 
+# Enable teflon for upstream RKNPU/rocket support
+# Requires CONFIG_DRM_ACCEL_ROCKET in Linux kernel to actually work
+PACKAGECONFIG:append:rk3588s = "${@oe.utils.vartrue('ENABLE_UPSTREAM_RKNPU', ' teflon rocket', '', d)}"
+
 # Mali Gen10 (Valhall, supported by Panthor) requires a firmware blob
 RRECOMMENDS:mesa-megadriver:append:rk3588s = " linux-firmware-mali-csffw-arch108"
diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
index 6c62e84..dc30327 100644
--- a/recipes-kernel/linux/linux-rockchip.inc
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -36,3 +36,4 @@ SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
 
 KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
+KERNEL_FEATURES:append:rockchip = "${@oe.utils.vartrue('ENABLE_UPSTREAM_RKNPU', ' bsp/rockchip/rocket-npu.scc', '', d)}"
diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg
new file mode 100644
index 0000000..9f6af63
--- /dev/null
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg
@@ -0,0 +1,2 @@
+CONFIG_DRM_ACCEL=y
+CONFIG_DRM_ACCEL_ROCKET=y
diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc
new file mode 100644
index 0000000..a8b4277
--- /dev/null
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc
@@ -0,0 +1 @@
+kconf hardware rocket-npu.cfg

---
base-commit: 7bc349061e8ac3f03b5646f2ae1d3958ce53c460
change-id: 20260423-rknn-3a394fa3cb83

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


