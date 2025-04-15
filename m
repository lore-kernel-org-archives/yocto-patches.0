Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E117C369AB
	for <webhook@archiver.kernel.org>; Tue, 15 Apr 2025 11:24:23 +0000 (UTC)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
 by mx.groups.io with SMTP id smtpd.web10.17650.1744716257496299757
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Apr 2025 04:24:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.13, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZcMHg5tk5zgjY;
	Tue, 15 Apr 2025 13:24:15 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZcMHg2vP4z9TY;
	Tue, 15 Apr 2025 13:24:15 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [meta-rockchip PATCH v2 0/3] add support for Panthor
Date: Tue, 15 Apr 2025 13:24:03 +0200
Message-Id: <20250415-mesa-panthor-v2-0-a7850d0091fe@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANNB/mcC/3XMuw7CMAyF4VepPGNUJ0VcJt4DdTCJSzKQVE5VU
 VV9d0J3xv9I51uhiEYpcGtWUJljiTnVMIcGXOD0Eoy+NpjWdO3JEr6lMI6cppAVr86SY2K2NEC
 9jCpD/Ozco68dYpmyLrs+02/9A82ELV7c8Ow8ndlbvrsgqsvRC/Tbtn0BQKpHS6gAAAA=
X-Change-ID: 20240531-mesa-panthor-9c31ca1aa31f
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Apr 2025 11:24:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1367

Panthor is the open-source implementation for the Arm GPU Valhall series
both in the Linux kernel and Mesa userspace. In the latter, the panfrost
"driver" is actually handling this version of the Arm GPU. One therefore
needs to enable kmsro and panfrost in PACKAGECONFIG to be able to use
this open-source implementation.

The open-source implementation still requires a proprietary blob which
is running on the GPU: mali_csffw.bin. Note that the closed-source
implementation (libmali and vendor kernel drivers) also require this
blob.

In anticipation of the kmsro PACKAGECONFIG for gallium-drivers
disappearing soon[1], the latter commit removes the PACKAGECONFIG option
as well.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- rebased on top of master with mesa 25.0 update merged
- added patch 3 which removes kmsro from PACKAGECONFIG as it's now
  unnecessary,
- Link to v1: https://lore.kernel.org/r/20240531-mesa-panthor-v1-0-8cfb4d17ad3a@cherry.de

---
Quentin Schulz (3):
      mesa: enable Panfrost support for RK3588(S)
      mesa: recommend mali csffw firmware package for mesa-megadriver for RK3588s
      mesa: remove kmsro from PACKAGECONFIG

 recipes-graphics/mesa/mesa.bbappend | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)
---
base-commit: 0aba79e47951b049bcdd39e07f660c665e257393
change-id: 20240531-mesa-panthor-9c31ca1aa31f

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


