Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8DFE77184
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 15:20:39 +0000 (UTC)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
 by mx.groups.io with SMTP id smtpd.web11.84328.1734448829884033970
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Dec 2024 07:20:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.13, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YCL980BqbzvmC;
	Tue, 17 Dec 2024 16:20:28 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YCL9750VyzM8y;
	Tue, 17 Dec 2024 16:20:27 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Tue, 17 Dec 2024 16:20:18 +0100
Subject: [meta-rockchip PATCH] bsp: trusted-firmware-a: remove already
 merged patch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-tf-a-2-12-v1-1-3c9073a3f773@cherry.de>
X-B4-Tracking: v=1; b=H4sIALGWYWcC/yWNywqDMBBFf0Vm7UAyiKX+iriIyViHUh+TWArBf
 zfU5eEezs0QWYUjdFUG5a9EWZcCtq7Az255MUooDGSosWQfmCZ0SGgJiZ+hNS6Y1o9Q/E15kt+
 /1cOHk0Nd/dvPssFwz8r7UR7S7QzneQHznd4KfwAAAA==
X-Change-ID: 20241217-tf-a-2-12-2e9d60ad06cb
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Dec 2024 15:20:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/932

From: Quentin Schulz <quentin.schulz@cherry.de>

2.12.0 already has this patch, see 52cdebbcc5d1 ("fix(rockchip): fix
"unexpected token" error with clang"), so let's remove it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Prepare for 2.12.0 upgrade, when
https://lore.kernel.org/yocto-meta-arm/20241217-tf-a-2-12-v1-1-cca762965260@cherry.de/
is merged. meta-rockchip will then break building because it'll try to
apply an already-applied patch.

ONLY TO BE APPLIED AFTER
https://lore.kernel.org/yocto-meta-arm/20241217-tf-a-2-12-v1-1-cca762965260@cherry.de/
IS MERGED!!!!
---
 ...ros.S-Use-compatible-.asciz-asm-directive.patch | 31 ----------------------
 .../trusted-firmware-a_%.bbappend                  |  1 -
 2 files changed, 32 deletions(-)

diff --git a/recipes-bsp/trusted-firmware-a/files/0001-plat_macros.S-Use-compatible-.asciz-asm-directive.patch b/recipes-bsp/trusted-firmware-a/files/0001-plat_macros.S-Use-compatible-.asciz-asm-directive.patch
deleted file mode 100644
index 8807fcaabc0598d9c92b038fa6b443d2d1063945..0000000000000000000000000000000000000000
--- a/recipes-bsp/trusted-firmware-a/files/0001-plat_macros.S-Use-compatible-.asciz-asm-directive.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-From 5f78ce7eb9ab6bf5af682a715a9264d2a5ee7666 Mon Sep 17 00:00:00 2001
-From: Khem Raj <raj.khem@gmail.com>
-Date: Tue, 11 May 2021 12:06:34 -0700
-Subject: [PATCH] plat_macros.S: Use compatible .asciz asm directive
-
-clang asm does not like two strings to .asciz therefore make it single
-string which works on clang too.
-
-Upstream-Status: Pending
-Signed-off-by: Khem Raj <raj.khem@gmail.com>
----
- plat/rockchip/common/include/plat_macros.S | 3 +--
- 1 file changed, 1 insertion(+), 2 deletions(-)
-
-diff --git a/plat/rockchip/common/include/plat_macros.S b/plat/rockchip/common/include/plat_macros.S
-index 691beeb44..c07be9ca9 100644
---- a/plat/rockchip/common/include/plat_macros.S
-+++ b/plat/rockchip/common/include/plat_macros.S
-@@ -23,8 +23,7 @@ icc_regs:
- 
- /* Registers common to both GICv2 and GICv3 */
- gicd_pend_reg:
--	.asciz "gicd_ispendr regs (Offsets 0x200 - 0x278)\n"	\
--		" Offset:\t\t\tvalue\n"
-+	.asciz "gicd_ispendr regs (Offsets 0x200 - 0x278)\n Offset:\t\t\tvalue\n"
- newline:
- 	.asciz "\n"
- spacer:
--- 
-2.31.1
-
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
index ecd6cb33c48b74c5523907986afc28cf14de1e8f..f2b666c127aed2747908fccea068bda5e6ac7def 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
@@ -12,7 +12,6 @@ COMPATIBLE_MACHINE:append:rk3588s = "|rk3588s"
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 SRC_URI += "\
     file://0001-dram-Fix-build-with-gcc-11.patch \
-    file://0001-plat_macros.S-Use-compatible-.asciz-asm-directive.patch \
     file://0001-pmu-Do-not-mark-already-defined-functions-as-weak.patch \
 "
 

---
base-commit: 1cdcb496037474cffd7b6a716eefc2814f1e105c
change-id: 20241217-tf-a-2-12-2e9d60ad06cb

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


