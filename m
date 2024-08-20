Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDC7C531DC
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 12:56:51 +0000 (UTC)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
 by mx.groups.io with SMTP id smtpd.web10.18516.1724158610052864465
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Aug 2024 05:56:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.10, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wp8cJ2RGjz9xH;
	Tue, 20 Aug 2024 14:56:48 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wp8cH5tcSzx5s;
	Tue, 20 Aug 2024 14:56:47 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [meta-rockchip PATCH 0/9] enable v4l2codecs gstreamer plugin for
 VPU decoding
Date: Tue, 20 Aug 2024 14:56:23 +0200
Message-Id: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHeSxGYC/x2MWwqAIBAArxL73UJZ0OMq0YfpVkuUsUoE4t2TP
 odhJoInYfIwFhGEHvbsrgx1WYDZ9bURss0MqlJt1dcNbj5gFkEcLtRppRfbN8MKObiFVn7/2QQ
 nBY3izGF2vmFO6QNbgiwzawAAAA==
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 Aug 2024 12:56:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/523

(Most) Rockchip SoCs have a VPU that can be used with v4l2codecs plugin
from gstreamer. In the kernel this VPU is supported by the Hantro driver
which does both stateless HW video encoding and decoding, however
gstreamer only supports decoding for now, see [1] for encoding support.

All Rockchip SoCs supported in this layer to the exception of the RK3308
have a Hantro VPU according to the compatible list in the Linux kernel,
so all SoC includes (except the one for the RK3308) now set HAS_HANTRO
value to enable VPU decoding via gstreamer.

This was only tested on RK3399 Puma and PX30 Ringneck with Haikou (+
Haikou Video Demo adapter for Ringneck) on Scarthgap 5.0.2.

Note that RK3588 upstream Linux kernel only supports AV1 decoding right
now. Also, there's currently no video output support, so this was tested
on a private downstream branch supporting DSI on RK3588 Tiger with
Haikou + Haikou Video Demo adapter).

Note that Gstreamer v4l2codecs only added support for av1 decoding in
1.23.1, so RK3588 commit doesn't necessarily make sense to be backported
right now to other branches (e.g. scarthgap or kirkstone), at the very
least until more than AV1 decoding is supported (which will probably
land this year or the next).

[1] https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5676

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (9):
      gstreamer-plugins-bad: build v4l2codecs if SoC has a VPU
      px30: enable gstreamer v4l2codecs support
      rk3399: enable gstreamer v4l2codecs support
      rk3066: enable gstreamer v4l2codecs support
      rk3188: enable gstreamer v4l2codecs support
      rk3288: enable gstreamer v4l2codecs support
      rk3328: enable gstreamer v4l2codecs support
      rk356x: enable gstreamer v4l2codecs support
      rk3588(s): enable gstreamer v4l2codecs support

 conf/machine/include/px30.inc                                    | 2 ++
 conf/machine/include/rk3066.inc                                  | 2 ++
 conf/machine/include/rk3188.inc                                  | 2 ++
 conf/machine/include/rk3288.inc                                  | 2 ++
 conf/machine/include/rk3328.inc                                  | 2 ++
 conf/machine/include/rk3399.inc                                  | 2 ++
 conf/machine/include/rk3566.inc                                  | 2 ++
 conf/machine/include/rk3568.inc                                  | 2 ++
 conf/machine/include/rk3588s.inc                                 | 2 ++
 recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend | 1 +
 10 files changed, 19 insertions(+)
---
base-commit: d9566c54b72fd83f1a953fb691ad61f1144544a6
change-id: 20240813-gst-hantro-be7a2abd839f

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


