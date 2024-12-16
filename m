Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04040C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 13:40:40 +0000 (UTC)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
 by mx.groups.io with SMTP id smtpd.web10.56750.1734356431697508626
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Dec 2024 05:40:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.13, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YBh0F2vJlzrPl;
	Mon, 16 Dec 2024 14:40:29 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YBh0F0kjwzNHM;
	Mon, 16 Dec 2024 14:40:29 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 16 Dec 2024 14:39:47 +0100
Subject: [meta-rockchip PATCH scarthgap 1/3] bsp: rkbin: do not add default
 DEPENDS dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-rkbin-bump-scarthgap-v1-1-9057e03351ad@cherry.de>
References: <20241216-rkbin-bump-scarthgap-v1-0-9057e03351ad@cherry.de>
In-Reply-To: <20241216-rkbin-bump-scarthgap-v1-0-9057e03351ad@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Dec 2024 13:40:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/927

From: Quentin Schulz <quentin.schulz@cherry.de>

Nothing needs to be done for rkbin recipes except taking a file and
putting in do_deploy, therefore there's no need for the default typical
DEPENDS dependencies to be pulled in. As such, set INHIBIT_DEFAULT_DEPS
to avoid having them pulled in.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
(cherry picked from commit 60354969f0c621f1dc775e7fcd2ad0f3fe8975f8)
[apply on rockchip-rkbin_git.bb instead of rockchip-rkbin.inc]
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin_git.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
index 1b71414e27ca781d9a8a551a9272fb596debb34d..6e87507e3983710fa1e0a2db5d83e9e2a20d9ced 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
@@ -10,6 +10,8 @@ PROVIDES += "optee-os"
 
 inherit bin_package deploy
 
+INHIBIT_DEFAULT_DEPS = "1"
+
 S = "${WORKDIR}/git"
 
 COMPATIBLE_MACHINE = "^$"

-- 
2.47.1


