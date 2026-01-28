Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9346ED35698
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 09:49:21 +0000 (UTC)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9587.1769593759146042726
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Jan 2026 01:49:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.170, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f1HY85yfWz5xV;
	Wed, 28 Jan 2026 10:49:16 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f1HY8102Pz4g0;
	Wed, 28 Jan 2026 10:49:16 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 28 Jan 2026 10:49:02 +0100
Subject: [PATCH meta-rockchip] add support for upstream RKNPU/RKNN/Rocket
 HW AI accelerator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-rknn-v1-1-363d7ef2c16c@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBNMo6KrRAvTqQbJYowIxLsnL
 R98foKITBhhrBIwPhTpDAVNXYHdTdhQkCsGJVUnG9UJ9iEIqQantXFtv2go6cW40vtvJjjwNoJ
 P6+1OF8w5f8JJDgBlAAAA
X-Change-ID: 20260126-rknn-028d33ad47b3
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 09:49:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3128

From: Quentin Schulz <quentin.schulz@cherry.de>

This adds support for the NPU (Neural Processing Unit) found on the
RK3588(S).

The NPU is supported by a kernel driver (CONFIG_DRM_ACCEL_ROCKET; built
as a module because probe order with the power domain/regulator may
otherwise generate Oopses on v6.18[1][2][3]), Device Tree nodes (so not
all RK3588 devices supported upstream necessarily have the NPU declared
properly!) and a userspace driver in mesa (teflon delegate with rocket
gallium driver).

This adds a config fragment for linux-rockchip kernels such that the
disabled-by-default Rocket driver is built and enables the Rocket
gallium mesa driver with the teflon delegate, but only when the user
requests its support.

This was tested by running the following:

"""
wget https://gitlab.freedesktop.org/mesa/mesa/-/raw/main/src/gallium/frontends/teflon/tests/classification.py

TEFLON_DEBUG=verbose python3 classification.py \
	     -i /usr/share/label_image/grace_hopper.bmp \
	     -m /usr/share/lib/label_image/mobilenet_v1_1_224_quant.tflite \
	     -l /usr/share/lib/label_image/labels_mobilenet_quant_v1_224.txt \
	     -e /usr/lib/libteflon.so
"""

from an image built with meta-tensorflow's tensorflow-lite and mesa's
libteflon packages.

Note that tensorflow-lite currently can only be compiled for Python up
to 3.13 included. This excludes 3.14 we currently have in master, so to
be able to test this you'll need to have OE-Core checked out at commit
bb4e0f4ae390 ("orc: upgrade 0.4.41 -> 0.4.42") or before until
tensorflow adds support for Python 3.14.

Note that the Aarch64 RK35xx SoCs all have an NPU, but only RK3588's is
currently supported in the kernel.

[1] https://lore.kernel.org/linux-rockchip/0b20d760-ad4f-41c0-b733-39db10d6cc41@cherry.de/
[2] https://lore.kernel.org/linux-rockchip/20251215-rocket-error-path-v1-0-eec3bf29dc3b@cherry.de/
[3] https://lore.kernel.org/linux-rockchip/20251216055247.13150-1-rmxpzlb@gmail.com/
    Note that building as a module isn't necessarily preventing the
    Oopses since the power domain/regulator drivers may also be compiled
    as modules.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Unsure about making the driver built as module as sole work-around for
hoping to fix Oopses. We could also try to backport the fixes (at least
one patch (pmdomain) is necessary, the ones I sent are for the Oopses to
not happen but then the NPU driver might not probe or not all cores).

This was tested on RK3588 Tiger with linux-yocto 6.18 +
https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v6.20-armsoc/dts64&id=8fd18d9b7b74bbd5ee5c562c2b94fdb7a356867e

NanoPi R6C/R6S, OrangePi 5/5B, Rock 5B/5B+/5T and QuartzPro64 all seem
to have the required DT nodes in v6.18.
---
 README                                                 | 18 ++++++++++++++++++
 recipes-graphics/mesa/mesa.bbappend                    |  4 ++++
 recipes-kernel/linux/linux-rockchip.inc                |  1 +
 .../rockchip-kmeta/bsp/rockchip/rocket-npu.cfg         |  2 ++
 .../rockchip-kmeta/bsp/rockchip/rocket-npu.scc         |  1 +
 5 files changed, 26 insertions(+)

diff --git a/README b/README
index c2697d1..4c4699a 100644
--- a/README
+++ b/README
@@ -222,6 +222,24 @@ Notes:
 	NOTE: this variable must be set before any include/require in the
 	      machine configuration file
 
+  Neural Processing Unit (NPU)
+
+	The Aarch64 RK35xx SoCs have a Neural Processing Unit (NPU) available.
+	It is typically named by Rockchip as RKNPU/RKNN but upstream has decided
+	to use Rocket instead. At the time of writing (Linux kernel v6.19), only
+	RK3588's NPU is	supported upstream.
+
+	This NPU is an AI hardware-accelerator. You can enable its support by
+	setting:
+
+		ENABLE_UPSTREAM_RKNPU = "1"
+
+	This requires a kernel driver (CONFIG_DRM_ACCEL_ROCKET, v6.18+),
+	RKNN Device Tree nodes
+	(e.g. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=640366d644b1e282771a09c72be37162b6eda438)
+	and a userspace driver (selected by setting teflon delegate meson option
+	and rocket gallium driver).
+
 U-Boot Environment:
 ------------------
 	In order to configure U-Boot to be able to store its environment into the
diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
index d9e7c08..362eced 100644
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
index 6c62e84..a6930f0 100644
--- a/recipes-kernel/linux/linux-rockchip.inc
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -36,3 +36,4 @@ SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
 
 KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
+KERNEL_FEATURES:append:rockchip = "${@' bsp/rockchip/rocket-npu.scc' if bb.utils.to_boolean(d.getVar('ENABLE_UPSTREAM_RKNPU'), False) else ''}"
diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg
new file mode 100644
index 0000000..18dcdc4
--- /dev/null
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg
@@ -0,0 +1,2 @@
+CONFIG_DRM_ACCEL=y
+CONFIG_DRM_ACCEL_ROCKET=m
diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc
new file mode 100644
index 0000000..a8b4277
--- /dev/null
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.scc
@@ -0,0 +1 @@
+kconf hardware rocket-npu.cfg

---
base-commit: 3f590586ca97e9a14903e16dfdfb15dbe78490ad
change-id: 20260126-rknn-028d33ad47b3

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


