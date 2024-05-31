Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F01EC25B75
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 15:30:47 +0000 (UTC)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
 by mx.groups.io with SMTP id smtpd.web10.15537.1717169446022257503
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 May 2024 08:30:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VrRsH63NXzxLP;
	Fri, 31 May 2024 17:30:43 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VrRsH2hCgzG7;
	Fri, 31 May 2024 17:30:43 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH meta-rockchip RFC 0/2] add support for Panthor
Date: Fri, 31 May 2024 17:30:24 +0200
Message-Id: <20240531-mesa-panthor-v1-0-8cfb4d17ad3a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABDtWWYC/x2MQQrCQAwAv1JyNtB060Gvgg/wKh5CTN0g3V2yR
 YTSv3f1OAwzK1R10wrnbgXXj1XLqQEdOpDI6aVoz8Yw9MPYHwPhrJWxcFpidjxJIGFiDjRBS4r
 rZN//7g6zLoye5S3Rys/erhd4bNsOmLvmoXQAAAA=
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 May 2024 15:30:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/272

Panthor is the open-source implementation for the Arm GPU Valhall series
both in the Linux kernel and Mesa userspace. In the latter, the panfrost
"driver" is actually handling this version of the Arm GPU. One therefore
needs to enable kmsro and panfrost in PACKAGECONFIG to be able to use
this open-source implementation.

The open-source implementation still requires a proprietary blob which
is running on the GPU: mali_csffw.bin. Note that the closed-source
implementation (libmali and vendor kernel drivers) also require this
blob.

Right now, we're still missing a linux-yocto v6.10+ to be able to test
this with everything upstream in Yocto/OE, but I was able to
successfully test this with kmscube on a downstream kernel (6.6 +
backported patches for GPU and custom patches for DSI support) on an
RK3588 Tiger.

Additionally, the following patch series is required from OE-Core:
https://lore.kernel.org/openembedded-core/20240531-panthor-v1-0-1a76fd752c1b@cherry.de/T/#t

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      mesa: enable Panfrost support for RK3588(S)
      mesa: recommend mali csffw firmware package for mesa-megadriver for RK3588s

 recipes-graphics/mesa/mesa_%.bbappend | 3 +++
 1 file changed, 3 insertions(+)
---
base-commit: 3381d6af6eabfb532da16863b785a95abba6b9e8
change-id: 20240531-mesa-panthor-9c31ca1aa31f

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


