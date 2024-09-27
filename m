Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BDDFC619D
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 12:37:14 +0000 (UTC)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
 by mx.groups.io with SMTP id smtpd.web10.67860.1727440625215310936
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Sep 2024 05:37:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XFVMz66ClzVXk;
	Fri, 27 Sep 2024 14:37:03 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XFVMz3gWpzjcN;
	Fri, 27 Sep 2024 14:37:03 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 27 Sep 2024 14:36:53 +0200
Subject: [meta-rockchip PATCH 3/3] bsp: rkbin: do not add default DEPENDS
 dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-rkbin-split-recipes-v1-3-0f4a9b0cbf56@cherry.de>
References: <20240927-rkbin-split-recipes-v1-0-0f4a9b0cbf56@cherry.de>
In-Reply-To: <20240927-rkbin-split-recipes-v1-0-0f4a9b0cbf56@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Sep 2024 12:37:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/681

From: Quentin Schulz <quentin.schulz@cherry.de>

Nothing needs to be done for rkbin recipes except taking a file and
putting in do_deploy, therefore there's no need for the default typical
DEPENDS dependencies to be pulled in. As such, set INHIBIT_DEFAULT_DEPS
to avoid having them pulled in.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
index abd2e30..d70a555 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -5,6 +5,8 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
 
 inherit bin_package deploy
 
+INHIBIT_DEFAULT_DEPS = "1"
+
 S = "${WORKDIR}/git"
 
 COMPATIBLE_MACHINE = "^$"

-- 
2.46.1


