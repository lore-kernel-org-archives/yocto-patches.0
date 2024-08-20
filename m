Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC63C531DF
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 12:56:51 +0000 (UTC)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
 by mx.groups.io with SMTP id smtpd.web11.18664.1724158610576076212
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Aug 2024 05:56:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.8, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wp8cJ4K1Vz4tQ;
	Tue, 20 Aug 2024 14:56:48 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wp8cJ2LGpzvXr;
	Tue, 20 Aug 2024 14:56:48 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 20 Aug 2024 14:56:24 +0200
Subject: [meta-rockchip PATCH 1/9] gstreamer-plugins-bad: build v4l2codecs
 if SoC has a VPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-gst-hantro-v1-1-335c4eaf8e8b@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/525

From: Quentin Schulz <quentin.schulz@cherry.de>

v4l2codecs is the gstreamer plugin for V4L2 stateless video hardware
decoding. The Rockchip SoCs that have a VPU all seems to be based on
Hantro, a stateless encoding/decoding VPU.

Therefore, let's enable VPU decoding in Gstreamer whenever possible,
when the SoC supports it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend b/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend
new file mode 100644
index 0000000..a9f40eb
--- /dev/null
+++ b/recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend
@@ -0,0 +1 @@
+PACKAGECONFIG:append:rockchip = "${@' v4l2codecs' if bb.utils.to_boolean(d.getVar('HAS_HANTRO'), False) else ''}"

-- 
2.46.0


