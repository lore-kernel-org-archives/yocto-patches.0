Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9348D6ACEA
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 15:13:40 +0000 (UTC)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
 by mx.groups.io with SMTP id smtpd.web11.73984.1732720416914999240
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 Nov 2024 07:13:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.169, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xz2yR3gGqzKYl;
	Wed, 27 Nov 2024 16:13:35 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xz2yR0Cr0zHBy;
	Wed, 27 Nov 2024 16:13:34 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 27 Nov 2024 16:12:59 +0100
Subject: [meta-rockchip PATCH 2/2] bsp: rkbin: bump to latest commit in
 master branch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-rkbin-bump-v1-2-b90b6c04a88f@cherry.de>
References: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
In-Reply-To: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 Nov 2024 15:13:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/846

From: Quentin Schulz <quentin.schulz@cherry.de>

This seems to be fixing random RCU stalls, system hangs or resets while
running upstream Linux kernel on RK3588 boards.

License-Update: Fixing typos c.f. 385bf9f1700c ("license: typo fix")

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
index d70a5551c8171188af93dddf4b3b1dc960f27a83..9264db9048e31b7dae650bdc8e31009f7f4cf404 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -1,7 +1,7 @@
 SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
-SRCREV = "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
+SRCREV = "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
 LICENSE = "Proprietary"
-LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
 
 inherit bin_package deploy
 

-- 
2.47.0


