Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E1FC3DA4A
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 11:26:50 +0000 (UTC)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
 by mx.groups.io with SMTP id smtpd.web10.6514.1741692405312769069
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Mar 2025 04:26:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZBs0g5TYYz1Bj;
	Tue, 11 Mar 2025 12:26:43 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZBs0g30Z9z3cS;
	Tue, 11 Mar 2025 12:26:43 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 11 Mar 2025 12:26:35 +0100
Subject: [meta-rockchip PATCH 6/6] bsp: rkbin: bump to latest commit in
 master branch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-ddrbin-custom-v1-6-e5c994ac25e1@cherry.de>
References: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
In-Reply-To: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 11:26:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1188

From: Quentin Schulz <quentin.schulz@cherry.de>

This bumps rkbin to be using the last public blobs.

Among RK356x and RK3588, the following changes are noteworthy:
- OP-TEE OS (bl32) bump for RK356x and RK3588
- TF-A (bl31) bump for RK3588

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
index 9264db9048e31b7dae650bdc8e31009f7f4cf404..468779ac7e9b939c4f7a5d19aecb7ce0f0fb2d09 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -1,5 +1,5 @@
 SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
-SRCREV = "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
+SRCREV = "f43a462e7a1429a9d407ae52b4745033034a6cf9"
 LICENSE = "Proprietary"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
 

-- 
2.48.1


