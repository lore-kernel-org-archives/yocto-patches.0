Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A35C41513
	for <webhook@archiver.kernel.org>; Wed, 22 May 2024 18:27:06 +0000 (UTC)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
 by mx.groups.io with SMTP id smtpd.web10.2124.1716402419103582384
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 May 2024 11:26:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.169, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vl0Bn29dHzq3B;
	Wed, 22 May 2024 20:26:57 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vl0Bm5nVnzMB6;
	Wed, 22 May 2024 20:26:56 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH meta-rockchip 0/2] fix 2+ DTB in KERNEL_DEVICETREE and
 empty /boot without kernel-modules
Date: Wed, 22 May 2024 20:26:42 +0200
Message-Id: <20240522-nonfitdt-multi-dt-v1-0-c75dffd3aa7c@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOI4TmYC/x2MQQqAIBAAvxJ7biGXpOgr0UFsq6XSUIsg+nvSb
 eYw80DkIByhKx4IfEkU77KosgC7GDczypgdqKK60kTovJskjQn3c0uCGQy1ZLVqG60U5O4IPMn
 9P3vYORkM3q52kQOG9/0AAx0rXnIAAAA=
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 yocto-patches@lists.yoctoproject.org
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 May 2024 18:27:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/164

This fixes NONFITDT/UBOOT_EXTLINUX_FDT when KERNEL_DEVICETREE contains
more than one DTB (which is a valid use-case).

This also fixes an empty /boot directly when no kernel-modules are
installed in the image, by explicitly adding kernel-image and
kernel-devicetree packages (the latter only if building !fitImage).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      rockchip-extlinux.inc: handle multiple DTs in KERNEL_DEVICETREE
      rockchip-extlinux.inc: add kernel and dtb packages to the image

 conf/machine/include/rockchip-extlinux.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 88f2064ca2b83b42a7c8a59616ab80b763ef2485
change-id: 20240522-nonfitdt-multi-dt-a282c5187511

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


