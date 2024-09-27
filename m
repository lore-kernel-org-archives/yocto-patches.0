Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B03ECDD1A0
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 12:37:14 +0000 (UTC)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
 by mx.groups.io with SMTP id smtpd.web11.67983.1727440624903410800
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Sep 2024 05:37:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.11, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XFVMy6X4gzq8J;
	Fri, 27 Sep 2024 14:37:02 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XFVMy3sJQzlPn;
	Fri, 27 Sep 2024 14:37:02 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [meta-rockchip PATCH 0/3] bsp: rkbin: split rkbin into separate
 recipes for DDR init, TF-A and OP-TEE OS
Date: Fri, 27 Sep 2024 14:36:50 +0200
Message-Id: <20240927-rkbin-split-recipes-v1-0-0f4a9b0cbf56@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOOm9mYC/x3MQQ6CMBBG4auQWTtJqQrqVYiLUgf5g5ZmhhASw
 t1tXH6L93YyUYjRo9pJZYVhTgX1qaI4hvQWxquYvPMXd/ct69QjseUPFlaJyGLc1Fd3Hlx7C31
 DpcwqA7b/taOvLIF1jlMckel5HD80epFUdAAAAA==
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Sep 2024 12:37:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/678

This is in preparation for being able to use upstream TF-A while still
having DDR init and OP-TEE OS come from rkbin.

This is necessary because the do_deploy task applies on the recipe level
and not package level, so if we have two recipes deploying the same file
(e.g. rkbin and trusted-firmware-a for bl31.elf), the order in which
those recipes' do_deploy task will be run will decide which binary will
be used. This is terrible, so instead the binaries provided by rkbin are
split into multiple recipes so that only what we're interested in will
be deployed.

Note that the rk3308 rkbin recipe wasn't changed but I assume we could
migrate it to this new "layout" too, I just don't have a board to test I
didn't make mistakes.

This was tested on master (styhead) branch from yesterday, plus
https://lore.kernel.org/yocto-meta-arm/20240927-tf-a-master-v1-1-733c925c80e4@cherry.de/T/#u
for meta-arm on an RK3588 Jaguar board, plus some patches that will be
sent as a separate patch series since it depends on the patch from
meta-arm to be usable.

Nothing else was build tested, but since RK356x is now supported in
upstream TF-A too, I added support for it as well.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      bsp: rkbin: add .inc for factoring out reusable pieces
      bsp: rkbin: split optee-os, tf-a and ddr init from rkbin into separate recipes
      bsp: rkbin: do not add default DEPENDS dependencies

 conf/machine/include/rk3308.inc                  |  4 +-
 conf/machine/include/rk3566.inc                  |  4 +-
 conf/machine/include/rk3568.inc                  |  4 +-
 conf/machine/include/rk3588s.inc                 |  4 +-
 recipes-bsp/rkbin/rk3308-rkbin_git.bb            |  4 +-
 recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb      | 23 ++++++++
 recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb | 27 +++++++++
 recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb     | 27 +++++++++
 recipes-bsp/rkbin/rockchip-rkbin.inc             | 32 +++++++++++
 recipes-bsp/rkbin/rockchip-rkbin_git.bb          | 73 ------------------------
 recipes-bsp/u-boot/u-boot-rockchip.inc           |  2 +-
 11 files changed, 122 insertions(+), 82 deletions(-)
---
base-commit: 24a411a17f389650c4cea38bef1f9279117fab8e
change-id: 20240927-rkbin-split-recipes-61503f078ab6

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


