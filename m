Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB15C5321E
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 12:56:51 +0000 (UTC)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
 by mx.groups.io with SMTP id smtpd.web10.18517.1724158610456373777
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Aug 2024 05:56:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.8, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wp8cJ6H2szFPD;
	Tue, 20 Aug 2024 14:56:48 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wp8cJ4FNBzvG9;
	Tue, 20 Aug 2024 14:56:48 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 20 Aug 2024 14:56:25 +0200
Subject: [meta-rockchip PATCH 2/9] px30: enable gstreamer v4l2codecs
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-gst-hantro-v1-2-335c4eaf8e8b@cherry.de>
References: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
In-Reply-To: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 Aug 2024 12:56:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/524

From: Quentin Schulz <quentin.schulz@cherry.de>

PX30 has a Hantro VPU, so let's set HAS_HANTRO so that gstreamer
v4l2codecs plugin can be built.

This was tested with weston on a PX30 Ringneck with Haikou+Haikou Video
Demo adapter:

$ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slh264dec ! waylandsink

with FILE storing the path to any h264 file, e.g.
https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_720p_h264.mov
https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_1080p_h264.mov

Needed packages are:
- weston
- gstreamer1.0-plugins-bad (for waylandsink and v4l2slh264dec)
- gstreamer1.0-plugins-base (for parsebin)

CPU load was ~3% according to top for both 720p and 1080p file (see
above), a few frames are dropped every other second for 1080p but
otherwise smooth.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/px30.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
index d78409e..ef325c3 100644
--- a/conf/machine/include/px30.inc
+++ b/conf/machine/include/px30.inc
@@ -19,3 +19,5 @@ TFA_BUILD_TARGET = "bl31"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+HAS_HANTRO = "1"

-- 
2.46.0


