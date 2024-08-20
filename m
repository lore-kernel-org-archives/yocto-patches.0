Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59207C3DA4A
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 12:57:01 +0000 (UTC)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
 by mx.groups.io with SMTP id smtpd.web11.18670.1724158612609580320
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Aug 2024 05:56:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.171, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wp8cM255qzkLJ;
	Tue, 20 Aug 2024 14:56:51 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wp8cL5crszvbW;
	Tue, 20 Aug 2024 14:56:50 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 20 Aug 2024 14:56:32 +0200
Subject: [meta-rockchip PATCH 9/9] rk3588(s): enable gstreamer v4l2codecs
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-gst-hantro-v1-9-335c4eaf8e8b@cherry.de>
References: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
In-Reply-To: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 Aug 2024 12:57:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/532

From: Quentin Schulz <quentin.schulz@cherry.de>

RK3588/RK3588s have a Hantro VPU, so let's set HAS_HANTRO so that
gstreamer v4l2codecs plugin can be built.

This was tested on a RK3588 Tiger with Haikou+Haikou Video Demo adapter
- on a downstream v6.6 (upstream-based, not
Rockchip BSP-based) with DSI patches - :

$ gst-launch-1.0 filesrc location=$FILE ! parsebin ! v4l2slav1dec ! fakesink

with FILE storing the path to any AV1 file, e.g.
http://download.opencontent.netflix.com.s3.amazonaws.com/AV1/cmaf/spark-8b-59.94fps/spark_606kbps_432p.mp4
https://woolyss.com/f/av1-nosound-chimera.mp4
https://woolyss.com/f/av1-opus-sita.webm

Needed packages are:
- gstreamer1.0-plugins-bad (for fakesink and v4l2slav1dec)
- gstreamer1.0-plugins-base (for parsebin)

CPU load was 0% according to top for all of the aforementioned files.
For some reason though, waylandsink is very choppy. Combining
fpsdisplaysink with fakesink shows a ~60fps when decoding the 432p file,
~24fps for the two others.
Note that 10b-depth isn't supported (at least in my setup).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3588s.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index cd84461..c96f8f5 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -18,3 +18,5 @@ PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
 
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
+
+HAS_HANTRO = "1"

-- 
2.46.0


