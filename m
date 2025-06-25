Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0C7C7EE33
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 12:07:29 +0000 (UTC)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
 by mx.groups.io with SMTP id smtpd.web11.13811.1750853245899964017
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 05:07:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.173, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bS0th3y0mzLtc;
	Wed, 25 Jun 2025 14:07:24 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bS0th1RZfzv55;
	Wed, 25 Jun 2025 14:07:24 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 25 Jun 2025 14:07:13 +0200
Subject: [meta-rockchip PATCH 1/2] bsp: rkbin: fix build since S =
 "${WORKDIR}/git" is implied by OE-Core
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-s-unpackdir-v1-1-6f45466478d8@cherry.de>
References: <20250625-s-unpackdir-v1-0-6f45466478d8@cherry.de>
In-Reply-To: <20250625-s-unpackdir-v1-0-6f45466478d8@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 12:07:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1687

From: Quentin Schulz <quentin.schulz@cherry.de>

S = "${WORKDIR}/git" is now implied when using the git fetcher and since
commit 46480a5e6674 ("insane/do_qa_unpack: add checks that ensure S is
set correctly") the build fails if it is set to such a value.

Therefore, let's remove the line in rkbin to make the build of those
recipes successful again.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rk3308-rkbin_git.bb | 2 --
 recipes-bsp/rkbin/rockchip-rkbin.inc  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/recipes-bsp/rkbin/rk3308-rkbin_git.bb b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
index eaf2ce1f5f0323cc4a6d18bf6c4624f446ccd08c..ab2c70f02f92f7dfbfe19069c3333bebffe8a511 100644
--- a/recipes-bsp/rkbin/rk3308-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
@@ -13,8 +13,6 @@ PROVIDES += "optee-os"
 
 inherit bin_package deploy
 
-S = "${WORKDIR}/git"
-
 COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:rk3308 = "rk3308"
 
diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
index 79149c5bebc3c59e337b303f24274ed1925da5ce..25ec58c73e97b3190fd144ca09fca555d25d7f51 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -7,8 +7,6 @@ inherit bin_package deploy
 
 INHIBIT_DEFAULT_DEPS = "1"
 
-S = "${WORKDIR}/git"
-
 COMPATIBLE_MACHINE = "^$"
 COMPATIBLE_MACHINE:rk3308 = "rk3308"
 COMPATIBLE_MACHINE:rk3566 = "rk3566"

-- 
2.49.0


