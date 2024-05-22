Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5487C25B7A
	for <webhook@archiver.kernel.org>; Wed, 22 May 2024 18:27:06 +0000 (UTC)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
 by mx.groups.io with SMTP id smtpd.web11.2131.1716402419449679706
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 May 2024 11:26:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vl0Bp07jXzVPw;
	Wed, 22 May 2024 20:26:58 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vl0Bn4vndzLqx;
	Wed, 22 May 2024 20:26:57 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 22 May 2024 20:26:44 +0200
Subject: [PATCH meta-rockchip 2/2] rockchip-extlinux.inc: add kernel and
 dtb packages to the image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-nonfitdt-multi-dt-v1-2-c75dffd3aa7c@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/166

From: Quentin Schulz <quentin.schulz@cherry.de>

If an image doesn't include kernel-modules, the kernel-image package
won't be installed by default. This means that no
kernel-image-${KERNEL_IMAGETYPE} package will be pulled in, resulting in
neither fitImage nor Image (or uImage, or zImage, or...) making it to
the filesystem, rendering the image non-bootable.

For non-fitImage scenarios, we currently expect DTB-less kernel images
(no bundle, like in uImage) so we also need to pull in the DTB via the
kernel-devicetree package.

Those packages used to be pulled in by the wic plugin through the
IMAGE_BOOT_FILES variable.

Fixes: 3b51866f2251 ("remove /boot partition")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rockchip-extlinux.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/conf/machine/include/rockchip-extlinux.inc b/conf/machine/include/rockchip-extlinux.inc
index 10bb190..d6de680 100644
--- a/conf/machine/include/rockchip-extlinux.inc
+++ b/conf/machine/include/rockchip-extlinux.inc
@@ -22,3 +22,4 @@ UBOOT_EXTLINUX_LABELS ?= "default"
 UBOOT_EXTLINUX_MENU_DESCRIPTION:default ?= "${MACHINE}"
 
 MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "u-boot-extlinux"
+MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "kernel-image ${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', 'kernel-devicetree', d)}"

-- 
2.45.1


