Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD09FD13C24
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 14:48:57 +0000 (UTC)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21690.1769438927489689190
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 06:48:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f0BHd25T6zcQ1;
	Mon, 26 Jan 2026 15:48:45 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f0BHb4xldzsKW;
	Mon, 26 Jan 2026 15:48:43 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH meta-rockchip 0/2] add support for (upstream) OP-TEE OS
Date: Mon, 26 Jan 2026 15:48:28 +0100
Message-Id: <20260126-optee-os-v1-0-874261a77dad@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MUQqFIBBG4a3EPDegFkJtJXpI+6shStG4XIj2n
 vT4weHclJEEmfrqpoSfZAlnga4r8tt0rmCZi8koY5U2lkO8AA6ZLZR2aDo411LJY8Ii/2810IF
 r4hT87jeJND7PC92jJCRpAAAA
X-Change-ID: 20260126-optee-os-6e01be39ebb4
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 14:48:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3084

This adds support for baking upstream OP-TEE OS into U-Boot.

There's a patch for syncing rkbin blobs naming and paths with the
upstream recipe but note this hasn't been tested at all (and if I
remember correctly, one cannot use the blobs with upstream U-Boot).

This is using the debug private key from OP-TEE OS git tree, this is
**UNSECURE**!!! How to provide your own private key hasn't been
researched for now, patches welcome!

This was tested on PX30 Ringneck, RK3399 Puma and RK3588 Tiger on a
downstream layer by generating a core-image-minimal with

  PREFERRED_PROVIDER_optee-os = "optee-os"
  RK_UBOOT_TEE ?= "1"

in a conf file and

  IMAGE_INSTALL += "optee-test"

in a recipes-core/images/core-image-minimal.bbappend, then boot the
image and run `xtest`. It'll take a few minutes to complete.

Note that currently, meta-arm has v4.7.0 recipe only and two tests are
failing on RK3588. There are patches[1] on the meta-arm mailing list for
bumping to v4.9.0 where those tests aren't failing anymore.

RK356x support is being worked on upstream as far as I've been told but
nothing merged or even ready yet, see
https://github.com/OP-TEE/optee_os/pull/6954 for possibly where things
are going to happen (not guaranteed).

[1] https://lore.kernel.org/yocto-meta-arm/20260121140356.16818-1-hugues.kambampiana@arm.com/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      bsp: rkbin: optee-os: sync destination and name with upstream OP-TEE OS
      add support for baking OP-TEE OS into U-Boot proper binary

 README                                             | 42 ++++++++++++++++++++++
 conf/machine/include/px30.inc                      |  7 ++++
 conf/machine/include/rk3399.inc                    |  7 ++++
 conf/machine/include/rk3588s.inc                   |  7 ++++
 recipes-bsp/rkbin/rk3308-rkbin_git.bb              |  2 +-
 recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb   |  8 ++---
 recipes-bsp/rkbin/rockchip-rkbin.inc               |  2 +-
 recipes-bsp/u-boot/u-boot-rockchip.inc             |  6 ++++
 .../optee/optee-os-tadevkit_%.bbappend             |  3 ++
 recipes-security/optee/optee-os_%.bbappend         | 19 ++++++++++
 recipes-security/optee/optee-test_%.bbappend       |  3 ++
 11 files changed, 100 insertions(+), 6 deletions(-)
---
base-commit: 2a13a49da4af4487ee71db6aff19364220da694a
change-id: 20260126-optee-os-6e01be39ebb4

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


