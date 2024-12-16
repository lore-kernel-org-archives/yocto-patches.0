Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CA0E77183
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 13:40:40 +0000 (UTC)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
 by mx.groups.io with SMTP id smtpd.web11.56571.1734356431765113290
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Dec 2024 05:40:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.171, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YBh0F0qN5zq5X;
	Mon, 16 Dec 2024 14:40:29 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YBh0D4pH7zMtZ;
	Mon, 16 Dec 2024 14:40:28 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [meta-rockchip PATCH scarthgap 0/3] bsp: rkbin: bump to latest
 commit in master
Date: Mon, 16 Dec 2024 14:39:46 +0100
Message-Id: <20241216-rkbin-bump-scarthgap-v1-0-9057e03351ad@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKItYGcC/z2MywrCMBAAf6Xs2YW8FPFXxEOarskixrCpUgj59
 wYPPQ7MTINKwlThNjUQ+nHlTx6gTxOE5HMk5GUwGGWcNvqC8po54/x9F6zBy5qiL6gsaX+1zip
 1hpEWoSdv/+0dDg0eve8xtSuLcQAAAA==
X-Change-ID: 20241216-rkbin-bump-scarthgap-03e1a8343005
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Trevor Woerner <twoerner@gmail.com>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Dec 2024 13:40:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/928

Backport patches from master to scarthgap branch.

A choice was made to not backport the splitting of op-tee, tf-a and
ddr-bin in their own recipes as it would break users of meta-rockchip if
they bbappend the recipe. This will make backporting increasingly more
difficult so maybe we could revisit this decision at some point.

Build and run tested on RK3588 Jaguar.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      bsp: rkbin: do not add default DEPENDS dependencies
      bsp: rkbin: use version and file variables for path matching the DDR init binary
      bsp: rkbin: bump to latest commit in master branch

 README                                  | 15 +++++++++++++++
 recipes-bsp/rkbin/rockchip-rkbin_git.bb | 26 ++++++++++++++++++++------
 2 files changed, 35 insertions(+), 6 deletions(-)
---
base-commit: e641dba980efa885df7e992ac5c8783270aa375d
change-id: 20241216-rkbin-bump-scarthgap-03e1a8343005

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


