Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E74D6ACE5
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 15:13:40 +0000 (UTC)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
 by mx.groups.io with SMTP id smtpd.web10.73872.1732720416103453145
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 Nov 2024 07:13:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.173, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xz2yQ2KmjzKCB;
	Wed, 27 Nov 2024 16:13:34 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xz2yP5XNMzFkm;
	Wed, 27 Nov 2024 16:13:33 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [meta-rockchip PATCH 0/2] bsp: rkbin: bump to latest commit in
 master
Date: Wed, 27 Nov 2024 16:12:57 +0100
Message-Id: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPk2R2cC/x3MwQqEIBCA4VeJOTeQrhD1KtFBbdyGyGSsCKR3X
 9njd/j/ApmEKcPYFBC6OfMRK1TbgF9t/BLyUg2600Yp3aNsjiO6a09o/BKc/lhrhgA1SEKBn/9
 sgp1Oi3L4za+cYH7fH4O9BVtrAAAA
X-Change-ID: 20241127-rkbin-bump-4cdfb23aa49f
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 Nov 2024 15:13:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/845

We've been hit by a lot of random RCU stalls, system hangs or resets on
some (not all) of our RK3588-based products running some old BL31/DDR
init binaries.

Upgrading to latest commit in master branch seems to mitigate those
issues, so let's do that.

Only build tested.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      bsp: rkbin: rkbin-ddr: use glob pattern for finding DDR init
      bsp: rkbin: bump to latest commit in master branch

 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 6 +++---
 recipes-bsp/rkbin/rockchip-rkbin.inc        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 3a8be31581651ced6c27f5bad1333064e513a8f0
change-id: 20241127-rkbin-bump-4cdfb23aa49f

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


