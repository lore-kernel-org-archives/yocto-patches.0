Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE497C7EE30
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 12:07:29 +0000 (UTC)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
 by mx.groups.io with SMTP id smtpd.web10.13578.1750853245841819335
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 05:07:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.11, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bS0th1VsfzLj0;
	Wed, 25 Jun 2025 14:07:24 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bS0tg5nG2ztbW;
	Wed, 25 Jun 2025 14:07:23 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [meta-rockchip PATCH 0/2] bsp: rkbin: fix build issues around S
 and WORKDIR
Date: Wed, 25 Jun 2025 14:07:12 +0200
Message-Id: <20250625-s-unpackdir-v1-0-6f45466478d8@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHmW2gC/x3MSwqAMAwA0atI1gZq8X8VcVHaqEGsJVURxLtbX
 L7FzAORhClCnz0gdHHk3ScUeQZ2MX4mZJcMWulK1brCiKcPxq6OBduJqClV17VOQSqC0MT3fxt
 go8Og7Ha1CwcY3/cDlFp6EmwAAAA=
X-Change-ID: 20250625-s-unpackdir-8fee740998d0
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 12:07:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1686

Since commit 46480a5e6674 ("insane/do_qa_unpack: add checks that ensure
S is set correctly"), three recipes fail to build because they either:

- set S to WORKDIR/git which isn't allowed anymore for git-fetched
  recipes,
- have WORKDIR in S which isn't allowed anymore, UNPACKDIR should be
  used instead,

This fixes the build issues seen on master.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      bsp: rkbin: fix build since S = "${WORKDIR}/git" is implied by OE-Core
      bsp: rkbin-native: fix build since ${WORKDIR} isn't allowed in S anymore

 recipes-bsp/rkbin/rk3308-rkbin_git.bb          | 2 --
 recipes-bsp/rkbin/rockchip-rkbin-native_git.bb | 2 +-
 recipes-bsp/rkbin/rockchip-rkbin.inc           | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)
---
base-commit: 961768ccd13630a4b98701f5821372a9ede86e85
change-id: 20250625-s-unpackdir-8fee740998d0

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


