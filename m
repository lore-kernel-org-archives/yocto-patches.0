Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7250C369C9
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 10:14:46 +0000 (UTC)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
 by mx.groups.io with SMTP id smtpd.web10.12341.1727259277247681289
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Sep 2024 03:14:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.15, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XDCJW1N7ZzKlr;
	Wed, 25 Sep 2024 12:14:35 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XDCJV1hmtzGcf;
	Wed, 25 Sep 2024 12:14:34 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 25 Sep 2024 12:13:51 +0200
Subject: [meta-rockchip PATCH scarthgap] enable HW VPU decoding for SoCs
 that have stateless VPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-gst-stateless-scarthga-v1-1-7b78e4575e26@cherry.de>
X-B4-Tracking: v=1; b=H4sIAF7i82YC/zWMywrCQAwAf6XkbGC7+KD+iniIadwNartsQhFK/
 91V8DgMMyuYVBWDc7dClUVN56lBv+uAM01JUMfGEEPchyEeMJmjObk8xQyNqXpOhD0fB6EwCt9
 O0OJS5a7v3/gCL3HCOvODs5av/WcFrtv2ASRjziuEAAAA
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Trevor Woerner <twoerner@gmail.com>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Sep 2024 10:14:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/672

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

$ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! fakesink

with FILE storing the path to any h264 file, e.g.
https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_720p_h264.mov
https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov

Needed packages are:
- gstreamer1.0-plugins-bad (for fakesink and v4l2slh264dec)
- gstreamer1.0-plugins-base (for parsebin)

waylandsink isn't used with weston because of rendering glitches, c.f.
https://gitlab.freedesktop.org/wayland/weston/-/issues/839. While the
link specifies it is for RK3399, PX30 is also impacted, albeit
differently since a different kind of glitch can be seen (like seeing
the image through a negative filter).
This is fixed in Styhead.

=== RK3399
Tested on RK3399 Puma with Haikou:

$ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! fakesink

with FILE storing the path to any h264 file, e.g.
https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov
https://download.blender.org/demo/movies/BBB/bbb_sunflower_2160p_30fps_normal.mp4.zip

Needed packages are:
- gstreamer1.0-plugins-bad (for fakesink and v4l2codecs)
- gstreamer1.0-plugins-base (for parsebin)

waylandsink isn't used with weston because of rendering glitches, c.f.
https://gitlab.freedesktop.org/wayland/weston/-/issues/839.
This is fixed in Styhead.

=== RK3588

Tested on a RK3588 Jaguar with HDMI - on a downstream v6.11-rc6
(upstream-based, not Rockchip BSP-based) with a bunch of patches - :

$ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! fakesink

with FILE storing the path to any h264 file, e.g.
https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov

$ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slmpeg2dec ! fakesink

with FILE storing the path to any MPEG2 file, e.g.
https://drive.google.com/file/d/0BwxFVkl63-lETXlOa3hEMmVyZGM/view?resourcekey=0-FG5JbjCsd8QduRhkZ2aT8A

$ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slvp8dec ! fakesink

with FILE storing the path to any VP8 file, e.g.
https://test-videos.co.uk/vids/bigbuckbunny/webm/vp8/1080/Big_Buck_Bunny_1080_10s_30MB.webm

Needed packages are:
- gstreamer1.0-plugins-bad (for fakesink and v4l2codecs)
- gstreamer1.0-plugins-base (for parsebin)

waylandsink isn't used with weston because starting gst-launch makes
weston segfault.

(cherry picked from commit 91a694e250a050ac77acab94521a80faac822aa1)
[adapt commit log to Scarthgap]
[replace waylandsink with fakesink as weston has glitches or segfaults]
[no av1 decoding in gst 1.22 in Scarthgap]
[rk3588 has gained h264, mpeg2 and vp8 decoding, added to the commit log]
[update setup for RK3588]
[note: only RK3588 was tested for this commit in Scarthgap]
[note: use fpsdisplaysink gst plugin with gst-launch in verbose mode for
 more information on on-going decoding session:
 $ gst-launch-1.0 -v filesrc location=$FILE ! parsebin ! v4l2slvp8dec ! fpsdisplaysink signal-fps-measurements=true text-overlay=false video-sink=fakesink
 /GstPipeline:pipeline0/GstFPSDisplaySink:fpsdisplaysink0: last-message = rendered: 287, dropped: 0, current: 30.02, average: 30.17
]

Reviewed-by: Trevor Woerner <twoerner@gmail.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
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
base-commit: 6adc7a5bfec3ec7dca6418719bb9cb74fb2f8427
change-id: 20240925-gst-stateless-scarthga-1c69ea0decb7

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


