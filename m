Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92CEC7115C
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 12:07:29 +0000 (UTC)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
 by mx.groups.io with SMTP id smtpd.web10.13579.1750853246329975933
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 05:07:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.169, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bS0th6blDzMyN;
	Wed, 25 Jun 2025 14:07:24 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bS0th4Cx4zsyF;
	Wed, 25 Jun 2025 14:07:24 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 25 Jun 2025 14:07:14 +0200
Subject: [meta-rockchip PATCH 2/2] bsp: rkbin-native: fix build since
 ${WORKDIR} isn't allowed in S anymore
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-s-unpackdir-v1-2-6f45466478d8@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1688

From: Quentin Schulz <quentin.schulz@cherry.de>

Since commit 46480a5e6674 ("insane/do_qa_unpack: add checks that ensure
S is set correctly") it is not allowed to have S refer to WORKDIR
directly and we should instead use UNPACKDIR.

The default path of S is ${UNPACKDIR}/${BP} which is where the git
fetcher will unpack the sources. However, we want to go into the tools/
directory, hence S being ${UNPACKDIR}/${BP}/tools now.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin-native_git.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb
index 2adccdd59bbf454bd5264d503d6d5883b94c472d..71d4246028102563fc2a3c23744eea1411770735 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb
@@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://../LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
 
 inherit native
 
-S = "${WORKDIR}/git/tools"
+S = "${UNPACKDIR}/${BP}/tools"
 
 # ddrbin_tool.py only uses python and core modules.
 # Yocto depends on a host python anyway so we can simply ignore that dependency

-- 
2.49.0


