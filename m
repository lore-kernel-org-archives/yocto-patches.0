Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B419AC25B78
	for <webhook@archiver.kernel.org>; Wed, 22 May 2024 18:27:06 +0000 (UTC)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
 by mx.groups.io with SMTP id smtpd.web11.2130.1716402419269220814
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 May 2024 11:26:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.173, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vl0Bn4fGvzk62;
	Wed, 22 May 2024 20:26:57 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vl0Bn2J5wzL25;
	Wed, 22 May 2024 20:26:57 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 22 May 2024 20:26:43 +0200
Subject: [PATCH meta-rockchip 1/2] rockchip-extlinux.inc: handle multiple
 DTs in KERNEL_DEVICETREE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-nonfitdt-multi-dt-v1-1-c75dffd3aa7c@cherry.de>
References: <20240522-nonfitdt-multi-dt-v1-0-c75dffd3aa7c@cherry.de>
In-Reply-To: <20240522-nonfitdt-multi-dt-v1-0-c75dffd3aa7c@cherry.de>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 yocto-patches@lists.yoctoproject.org
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 May 2024 18:27:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/165

From: Quentin Schulz <quentin.schulz@cherry.de>

KERNEL_DEVICETREE may contain more than one DTB, the first one being the
default one. Therefore, let's split on space first, to get the first DTB
before stripping the directory name from it.

This doesn't add support for creating multiple labels for each DTB in
KERNEL_DEVICETREE.

Fixes: 3b51866f2251 ("remove /boot partition")
Fixes: 13316b796814 ("KERNEL_DEVICETREE: 32-bit re-org")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rockchip-extlinux.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/machine/include/rockchip-extlinux.inc b/conf/machine/include/rockchip-extlinux.inc
index ca33f4c..10bb190 100644
--- a/conf/machine/include/rockchip-extlinux.inc
+++ b/conf/machine/include/rockchip-extlinux.inc
@@ -9,7 +9,7 @@
 # $UBOOT_EXTLINUX_FDTDIR/rockchip/$KERNEL_DEVICETREE but rather at
 # $UBOOT_EXTLINUX_FDTDIR/$KERNEL_DEVICETREE therefore we need to strip off
 # the 'rockchip/' part for extlinux non-fitImage builds
-NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split('/')[1]}"
+NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split()[0].split('/')[1]}"
 
 UBOOT_EXTLINUX ?= "1"
 UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=root"

-- 
2.45.1


