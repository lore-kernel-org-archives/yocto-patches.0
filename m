Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6607DC27C4F
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 09:25:54 +0000 (UTC)
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
 by mx.groups.io with SMTP id smtpd.web10.7569.1717147543582436313
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 May 2024 02:25:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.174, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VrHm559ZwzqJX;
	Fri, 31 May 2024 11:25:41 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VrHm51nMDzTSt;
	Fri, 31 May 2024 11:25:41 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH meta-rockchip master scarthgap v3 00/16] various reworks
 around u-boot and rkbin + fixes for MACHINEOVERRIDES
Date: Fri, 31 May 2024 11:25:07 +0200
Message-Id: <20240531-rk3588-family-v3-0-629586621c5d@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHOXWWYC/3WOyw6CMBBFf4V07Zg+KKIr/8O4GMuUNoiQKSESw
 78LrNTE3ZzcnHvnJRJxpCRO2UswjTHF7rGA2WXCBXzUBLFaWGipc2lVDtwYW5bgsY33CQpvtK6
 sV9LkYnF6Jh+fW99FtDQgcOcaF2K/pi2mgXi9kkMeQo29uC4UYho6nrYnRrW5f/ZGBQqsKYqbs
 iZHJc8uEPO0r2hrGvWnbX9tDRJ8qcrjAQ06+2XP8/wG5EVBPA4BAAA=
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 May 2024 09:25:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/251

This does a few reworks of how we handle TF-A and DDR bin blob
dependencies, hopefully in a way that makes it much easier to add
support for new SoCs without having to touch too many files.

While at it, add an SOC_FAMILY entry for rk3588s/rk3588 boards.

Additionally, make rk3308 use the PREFERRED_PROVIDER mechanism to select
rk3308-rkbin instead of rockchip-rkbin.

Finally, fix a few MACHINEOVERRIDES ordering issues.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- rebased on top of master
  - fix merge conflict when moving common code to the .inc file, I
    decided to keep the rk-u-boot-env logic only for upstream u-boot
    recipe and not put it into the .inc as the config fragment is
    probably specific to some version, we could however split it into
    its own separate .inc file so other uy-boot recipes in other layers
    could replicate the rk-u-boot-env logic with their recipe,
- Link to v2: https://lore.kernel.org/r/20240515-rk3588-family-v2-0-f81897a3ac50@cherry.de

Changes in v2:
- nothing in common with v1 except that rk3588s/rk3588 gains an
  SOC_FAMILY variable :)
- Link to v1: https://lore.kernel.org/r/20240514-rk3588-family-v1-1-5366b1534a10@cherry.de

---
Quentin Schulz (16):
      rk3588/rk3588s: add SOC_FAMILY
      rk3066: fix MACHINEOVERRIDES order
      rk3188: fix MACHINEOVERRIDES order
      rk3288: fix MACHINEOVERRIDES order
      add rockchip MACHINEOVERRIDES
      bsp: u-boot: rework BL31 in EXTRA_OEMAKE
      bsp: rkbin: rk3308-rkbin: PROVIDES rockchip-rkbin
      rk3308: move rockchip-rkbin selection to SoC conf file
      bsp: u-boot: explicit dependency on trusted-firware-a
      bsp: u-boot: remove duplicate trusted-firmware-a dependency for SoCs with open DDR init
      bsp: u-boot: split things that can apply to any U-Boot into a .inc file
      machine: rockchip-defaults: conditionally add closed-tpl MACHINEOVERRIDES
      machine: rk3308: mark all machines as to be using the closed TPL
      machine: rk3568: mark all machines as to be using the closed TPL
      machine: rk3588/rk3588s: mark all machines as to be using the closed TPL
      bsp: u-boot-rockchip.inc: rework ROCKCHIP_TPL to use closed-tpl OVERRIDES

 conf/machine/include/px30.inc              |  2 +-
 conf/machine/include/rk3066.inc            |  2 +-
 conf/machine/include/rk3188.inc            |  2 +-
 conf/machine/include/rk3288.inc            |  2 +-
 conf/machine/include/rk3308.inc            |  6 +++++-
 conf/machine/include/rk3328.inc            |  2 +-
 conf/machine/include/rk3399.inc            |  2 +-
 conf/machine/include/rk3568.inc            |  4 +++-
 conf/machine/include/rk3588.inc            |  1 +
 conf/machine/include/rk3588s.inc           |  5 ++++-
 conf/machine/include/rockchip-defaults.inc |  3 ++-
 recipes-bsp/rkbin/rk3308-rkbin_git.bb      |  1 +
 recipes-bsp/u-boot/u-boot-rockchip.inc     | 18 ++++++++++++++++++
 recipes-bsp/u-boot/u-boot_%.bbappend       | 27 ++-------------------------
 14 files changed, 42 insertions(+), 35 deletions(-)
---
base-commit: 3381d6af6eabfb532da16863b785a95abba6b9e8
change-id: 20240514-rk3588-family-6f322d5f1034

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


