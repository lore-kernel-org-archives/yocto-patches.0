Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59245C531DF
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 12:57:01 +0000 (UTC)
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
 by mx.groups.io with SMTP id smtpd.web10.18518.1724158611057769765
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Aug 2024 05:56:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.172, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wp8cK3hvgzDfn;
	Tue, 20 Aug 2024 14:56:49 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wp8cK0x0VzstR;
	Tue, 20 Aug 2024 14:56:49 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 20 Aug 2024 14:56:27 +0200
Subject: [meta-rockchip PATCH 4/9] rk3066: enable gstreamer v4l2codecs
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-gst-hantro-v1-4-335c4eaf8e8b@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/527

From: Quentin Schulz <quentin.schulz@cherry.de>

RK3066 has a Hantro VPU, so let's set HAS_HANTRO so that gstreamer
v4l2codecs plugin can be built.

This was not tested.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3066.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/include/rk3066.inc b/conf/machine/include/rk3066.inc
index 026d5b5..d865fec 100644
--- a/conf/machine/include/rk3066.inc
+++ b/conf/machine/include/rk3066.inc
@@ -12,3 +12,5 @@ SERIAL_CONSOLES = "115200;ttyS2"
 KBUILD_DEFCONFIG = "multi_v7_defconfig"
 KERNEL_FEATURES:append:rk3066 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_IMAGETYPE ?= "zImage"
+
+HAS_HANTRO = "1"

-- 
2.46.0


