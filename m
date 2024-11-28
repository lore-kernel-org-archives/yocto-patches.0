Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D71AD6911E
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 15:58:58 +0000 (UTC)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
 by mx.groups.io with SMTP id smtpd.web11.98582.1732809537865258590
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Nov 2024 07:58:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.9, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XzgwJ07pVzYff;
	Thu, 28 Nov 2024 16:58:56 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XzgwH3lwmzSWQ;
	Thu, 28 Nov 2024 16:58:55 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [meta-rockchip PATCH v2 0/2] bsp: rkbin: bump to latest commit in
 master
Date: Thu, 28 Nov 2024 16:58:48 +0100
Message-Id: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADiTSGcC/22NzQrCMBCEX0X27EoSg7aefA/pIUk3Zin9YVOLp
 fTdDT17/JiZbzbIJEwZHqcNhBbOPA4FzPkEIbnhTchtYTDKWK3NHaXzPKD/9BPa0EZvrs7ZOkI
 ZTEKRv4fsBT3NDmUMXUg8QVPixHkeZT2uFn2U/lkXjQp9rfwtKOuqKj5DIpH10hI0+77/AEp+J
 Q6zAAAA
X-Change-ID: 20241127-rkbin-bump-4cdfb23aa49f
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Nov 2024 15:58:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/857

We've been hit by random RCU stalls, system hangs or resets on some (not
all) of our RK3588-based products running some old BL31/DDR init
binaries.

Upgrading to latest commit in master branch seems to mitigate those
issues, so let's do that.

Only build tested.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- use version and filename variables instead of using glob pattern for
  path matching the DDR init binaries,
- Link to v1: https://lore.kernel.org/r/20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de

---
Quentin Schulz (2):
      bsp: rkbin: rkbin-ddr: use version and file variables for path matching
      bsp: rkbin: bump to latest commit in master branch

 README                                      | 15 +++++++++++++++
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 20 ++++++++++++++++----
 recipes-bsp/rkbin/rockchip-rkbin.inc        |  4 ++--
 3 files changed, 33 insertions(+), 6 deletions(-)
---
base-commit: 3a8be31581651ced6c27f5bad1333064e513a8f0
change-id: 20241127-rkbin-bump-4cdfb23aa49f

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


