Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EB6C25B7C
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 16:03:24 +0000 (UTC)
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
 by mx.groups.io with SMTP id smtpd.web10.20578.1715788999959489505
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 May 2024 09:03:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.175, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VfdLG38FSzbMZ;
	Wed, 15 May 2024 18:03:18 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VfdLG07c7zXpZ;
	Wed, 15 May 2024 18:03:17 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 15 May 2024 18:02:55 +0200
Subject: [PATCH meta-rockchip v2 01/16] rk3588/rk3588s: add SOC_FAMILY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-rk3588-family-v2-1-f81897a3ac50@cherry.de>
References: <20240515-rk3588-family-v2-0-f81897a3ac50@cherry.de>
In-Reply-To: <20240515-rk3588-family-v2-0-f81897a3ac50@cherry.de>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 yocto-patches@lists.yoctoproject.org
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 May 2024 16:03:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/141

From: Quentin Schulz <quentin.schulz@cherry.de>

This adds an SOC_FAMILY for rk3588 and rk3588s.

Note that we are NOT "require"'ing conf/machine/include/soc-family.inc
so SOC_FAMILY is just another BitBake variable. If we were to require
this file, it would break the MACHINEOVERRIDES order, so some more
changes would be required to handle those properly.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 conf/machine/include/rk3588.inc  | 1 +
 conf/machine/include/rk3588s.inc | 1 +
 2 files changed, 2 insertions(+)

diff --git a/conf/machine/include/rk3588.inc b/conf/machine/include/rk3588.inc
index 34f0627..958efb2 100644
--- a/conf/machine/include/rk3588.inc
+++ b/conf/machine/include/rk3588.inc
@@ -1,4 +1,5 @@
 MACHINEOVERRIDES =. "rk3588:"
+SOC_FAMILY = "rk3588"
 
 # the rk3588s is a "stripped-down" version of the rk3588
 # in the kernel's device-tree the rk3588 builds on top of the rk3588s
diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
index 878f7a8..6e700d8 100644
--- a/conf/machine/include/rk3588s.inc
+++ b/conf/machine/include/rk3588s.inc
@@ -1,3 +1,4 @@
+SOC_FAMILY ?= "rk3588s"
 MACHINEOVERRIDES =. "rk3588s:"
 DEFAULTTUNE ?= "cortexa76-cortexa55-crypto"
 

-- 
2.45.0


