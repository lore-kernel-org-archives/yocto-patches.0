Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB35C83026
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 14:19:28 +0000 (UTC)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
 by mx.groups.io with SMTP id smtpd.web11.14937.1751033963145558479
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 07:19:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.170, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bTHk06fj7z31r;
	Fri, 27 Jun 2025 16:19:20 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bTHk021WDz2YV;
	Fri, 27 Jun 2025 16:19:20 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [meta-rockchip PATCH v3 0/6] mesa: build fixes, refactoring and
 adding support for RK3588(s), RK3066, RK3188
Date: Fri, 27 Jun 2025 16:19:11 +0200
Message-Id: <20250627-mesa-panthor-v3-0-798c24a9eef3@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+oXmgC/3XMQQrDIBCF4asE17U4GknSVe5RupjqWF00CRqkI
 eTuNYFCKXT5Hnz/yhLFQIldqpVFyiGFcShDnSpmPA4P4sGWzaSQtdAK+JMS8gmH2Y+Rd0aBQUB
 U4FghUyQXXkfueivbhzSPcTnqGfb3TygDF7w17l5baNAq7I2nGJezJbaHsvxgLWrQP1gWjE2rh
 RWiA0ffeNu2N5FKkZDlAAAA
X-Change-ID: 20240531-mesa-panthor-9c31ca1aa31f
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Trevor Woerner <twoerner@gmail.com>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 14:19:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1712

This removes now unneeded kmsro PACKAGECONFIG as mesa dropped it (as
well as OE-Core's recipe).

The Panfrost drivers currently do not compile anymore due to a missing
libclc PACKAGECONFIG dependency so this adds the libclc to the
Panfrost-supported SoCs.

This refactors a bit the bbappend to hopefully require a bit less
maintenance with newer SoCs with most assumed to be supported by
Panfrost mesa drivers.

This enables (untested) support for lima mesa driver on RK3066 and
RK3188.

Finally, this enables Panthor support for RK3588(S).

Panthor is the open-source implementation for the Arm GPU Valhall series
both in the Linux kernel and Mesa userspace. In the latter, the panfrost
"driver" is actually handling this version of the Arm GPU. One therefore
needs to enable panfrost in PACKAGECONFIG to be able to use this
open-source implementation.

The open-source implementation still requires a proprietary blob which
is running on the GPU: mali_csffw.bin. Note that the closed-source
implementation (libmali and vendor kernel drivers) also requires this
blob.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- added now-required libclc dependency for panfrost,
- added support for RK3066 and RK3188 (though untested)
- refactored bbappend to default to panfrost unless specified otherwise,
- Link to v2: https://lore.kernel.org/r/20250415-mesa-panthor-v2-0-a7850d0091fe@cherry.de

Changes in v2:
- rebased on top of master with mesa 25.0 update merged
- added patch 3 which removes kmsro from PACKAGECONFIG as it's now
  unnecessary,
- Link to v1: https://lore.kernel.org/r/20240531-mesa-panthor-v1-0-8cfb4d17ad3a@cherry.de

---
Quentin Schulz (6):
      mesa: remove kmsro from PACKAGECONFIG
      mesa: add libclc to PACKAGECONFIG for Panfrost-supported SoCs
      mesa: enable lima for RK3066 boards
      mesa: enable lima for RK3188 boards
      mesa: rework bbappend to default to panfrost
      mesa: add support for RK3588(S)

 recipes-graphics/mesa/mesa.bbappend | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)
---
base-commit: d01077165243de983e2d12c9e75e9818bdbb5a4d
change-id: 20240531-mesa-panthor-9c31ca1aa31f

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


