Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D363C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 13:48:43 +0000 (UTC)
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
 by mx.groups.io with SMTP id smtpd.web10.28219.1716817719329542039
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 06:48:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.174, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VnxnK2WrMzHW5;
	Mon, 27 May 2024 15:48:37 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VnxnJ6zTlzkfT;
	Mon, 27 May 2024 15:48:36 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 27 May 2024 15:48:24 +0200
Subject: [PATCH meta-rockchip] rockchip-extlinux.inc: fix non-fit
 KERNEL_IMAGETYPE image boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-non-fit-fdt-boot-v1-1-72bf2530547d@cherry.de>
X-B4-Tracking: v=1; b=H4sIACePVGYC/x2MywqEMAwAf0Vy3oBWRdZfkT30kWqQbaQtIhT/3
 eJlYA4zBRJFpgRzUyDSyYklVOk+DdhNh5WQXXVQrRraUU0YJKDnjN5lNCIVevz2nbOGzAQ1OyJ
 5vt7lAn/KGqPY3W58wO++Hww8SZpxAAAA
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 13:48:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/211

From: Quentin Schulz <quentin.schulz@cherry.de>

On systems where KERNEL_IMAGETYPE is not set to fitImage, one needs to
either pass an DTB or a path to a directory where DTBs are located on
the rootfs.

When FDT property in extlinux is provided, FDTDIR isn't used (and
actually u-boot-extlinux-config doesn't even write it to the
configuration file).

When relative paths are used, they are relative to the directory where
extlinux.conf is stored[1]. Since the DTBs are stored in /boot, just
providing the filename of the DTB won't work because extlinux in U-Boot
will search for it in /boot/extlinux. We should therefore either use ../
prefix for relative paths or use /boot to make it absolute. /boot is
more explicit and easily parseable, so let's use the latter.

[1] https://wiki.syslinux.org/wiki/index.php?title=Config#Working_directory

Fixes: d80fa46c42f2 ("rockchip-extlinux.inc: handle multiple DTs in KERNEL_DEVICETREE")
Fixes: 3b51866f2251 ("remove /boot partition")
Fixes: 13316b796814 ("KERNEL_DEVICETREE: 32-bit re-org")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rockchip-extlinux.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/machine/include/rockchip-extlinux.inc b/conf/machine/include/rockchip-extlinux.inc
index 1f036c4..fddab73 100644
--- a/conf/machine/include/rockchip-extlinux.inc
+++ b/conf/machine/include/rockchip-extlinux.inc
@@ -14,7 +14,7 @@ NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split()[0].split('/')[1]}"
 UBOOT_EXTLINUX ?= "1"
 UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=rootfsA"
 UBOOT_EXTLINUX_FDTDIR ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"
-UBOOT_EXTLINUX_FDT ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '${NONFITDT}', d)}"
+UBOOT_EXTLINUX_FDT ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot/${NONFITDT}', d)}"
 UBOOT_EXTLINUX_CONSOLE ?= "earlycon console=tty1 console=${RK_CONSOLE_DEVICE},${RK_CONSOLE_BAUD}n8"
 UBOOT_EXTLINUX_KERNEL_ARGS ?= "rootwait rw rootfstype=ext4"
 UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${KERNEL_IMAGETYPE}"

---
base-commit: bf9ade59abc15a5f6fb5450265c214450f35857f
change-id: 20240527-non-fit-fdt-boot-ba5931dcbeb7

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


