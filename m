Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC09BC636DF
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 16:24:53 +0000 (UTC)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
 by mx.groups.io with SMTP id smtpd.web10.697.1724862285715895248
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 09:24:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wv8rW4mh4zZXN;
	Wed, 28 Aug 2024 18:24:43 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wv8rW1Jjcz2Ys;
	Wed, 28 Aug 2024 18:24:42 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 28 Aug 2024 18:23:59 +0200
Subject: [meta-rockchip PATCH v2] enable HW VPU decoding for SoCs that have
 stateless VPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-gst-hantro-v2-1-a85ed037e5c1@cherry.de>
X-B4-Tracking: v=1; b=H4sIAB5Pz2YC/02NwQ6CMBBEf4Xs2TWlxVg9+R+GQykL3Rgp2TZEQ
 vh3G7x4nLyZNxskEqYE92oDoYUTx6kEfarABzeNhNyXDFrpRtna4JgyFpAlYkdXp13XW3MboAx
 moYE/h+wJb8oOJfqXDzxDW3DglKOsx9VSH6WfVat/61KjQmMuviE3WLLdwwcSWc89Qbvv+xfMw
 +1fswAAAA==
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 16:24:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/566

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

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
(Most) Rockchip SoCs have a VPU that can be used with v4l2codecs plugin
from gstreamer. In the kernel this VPU is supported by the Hantro,
RKVDEC or RKVDECv2 drivers which do both stateless HW video encoding and
decoding, however gstreamer only supports decoding for now, see [1] for
encoding support.

All Rockchip SoCs supported in this layer to the exception of the RK3308
have at least one stateless VPU according to the compatible list in the
Linux kernel, so all SoC includes (except the one for the RK3308) now
set ENABLE_STATELESS_VPU_GST value to enable VPU decoding via gstreamer.

Note that RK3588 upstream Linux kernel only supports AV1 decoding right
now. Also, there's currently no video output support, so this was tested
on a private downstream branch supporting DSI on RK3588 Tiger with
Haikou + Haikou Video Demo adapter).

Note that Gstreamer v4l2codecs only added support for av1 decoding in
1.23.1, so the RK3588 part of this series doesn't necessarily make sense
to be backported right now to other branches (e.g. scarthgap or
kirkstone), at the very least until more than AV1 decoding is supported
(which will probably land this year or the next).

[1] https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5676
---
Changes in v2:
- rename HAS_HANTRO to ENABLE_STATELESS_VPU_GST
- add documentation in README
- squash all commits
- mention rkvdec/rkvdecv2 as well
- Link to v1: https://lore.kernel.org/r/20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de
---
 README                                             | 22 ++++++++++++++++++++++
 conf/machine/include/px30.inc                      |  2 ++
 conf/machine/include/rk3066.inc                    |  2 ++
 conf/machine/include/rk3188.inc                    |  2 ++
 conf/machine/include/rk3288.inc                    |  2 ++
 conf/machine/include/rk3328.inc                    |  2 ++
 conf/machine/include/rk3399.inc                    |  2 ++
 conf/machine/include/rk3566.inc                    |  2 ++
 conf/machine/include/rk3568.inc                    |  2 ++
 conf/machine/include/rk3588s.inc                   |  2 ++
 .../gstreamer/gstreamer1.0-plugins-bad_%.bbappend  |  1 +
 11 files changed, 41 insertions(+)

diff --git a/README b/README
index 8ff006e..09f8691 100644
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
index d78409e..8173cb1 100644
--- a/conf/machine/include/px30.inc
+++ b/conf/machine/include/px30.inc
@@ -19,3 +19,5 @@ TFA_BUILD_TARGET = "bl31"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3066.inc b/conf/machine/include/rk3066.inc
index 026d5b5..a898309 100644
--- a/conf/machine/include/rk3066.inc
+++ b/conf/machine/include/rk3066.inc
@@ -12,3 +12,5 @@ SERIAL_CONSOLES = "115200;ttyS2"
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3066 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_IMAGETYPE ?= "zImage"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3188.inc b/conf/machine/include/rk3188.inc
index 0120e2f..554d4f1 100644
--- a/conf/machine/include/rk3188.inc
+++ b/conf/machine/include/rk3188.inc
@@ -12,3 +12,5 @@ SERIAL_CONSOLES = "115200;ttyFIQ0"
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3188 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_IMAGETYPE ?= "zImage"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
index 684e864..06fda69 100644
--- a/conf/machine/include/rk3288.inc
+++ b/conf/machine/include/rk3288.inc
@@ -14,3 +14,5 @@ KERNEL_FEATURES:append:rk3288 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_IMAGETYPE ?= "zImage"
 
 UBOOT_SUFFIX ?= "bin"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
index 4ecd681..e6f810d 100644
--- a/conf/machine/include/rk3328.inc
+++ b/conf/machine/include/rk3328.inc
@@ -20,3 +20,5 @@ TFA_BUILD_TARGET = "bl31"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
index 47f0560..cd1be49 100644
--- a/conf/machine/include/rk3399.inc
+++ b/conf/machine/include/rk3399.inc
@@ -20,3 +20,5 @@ TFA_BUILD_TARGET = "bl31"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
index 586d688..2522851 100644
--- a/conf/machine/include/rk3566.inc
+++ b/conf/machine/include/rk3566.inc
@@ -19,3 +19,5 @@ PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
index 1da212a..db188a3 100644
--- a/conf/machine/include/rk3568.inc
+++ b/conf/machine/include/rk3568.inc
@@ -19,3 +19,5 @@ PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index cd84461..d349108 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -18,3 +18,5 @@ PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+ENABLE_STATELESS_VPU_GST ?= "1"
diff --git a/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend b/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend
new file mode 100644
index 0000000..2762304
--- /dev/null
+++ b/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend
@@ -0,0 +1 @@
+PACKAGECONFIG:append:rockchip = "${@' v4l2codecs' if bb.utils.to_boolean(d.getVar('ENABLE_STATELESS_VPU_GST'), False) else ''}"

---
base-commit: e6789604ab4de0fa3db90b597237be38e424c1fc
change-id: 20240813-gst-hantro-be7a2abd839f

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


