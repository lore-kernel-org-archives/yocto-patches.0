Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8863AC27C4F
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 12:48:36 +0000 (UTC)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
 by mx.groups.io with SMTP id smtpd.web10.10916.1717159705711258584
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 May 2024 05:48:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.169, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VrNG00wqSzTCC;
	Fri, 31 May 2024 14:48:24 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VrNFz4fPFzL8d;
	Fri, 31 May 2024 14:48:23 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH meta-rockchip 0/2] enable Panfrost on RK3328 and RK3568
Date: Fri, 31 May 2024 14:48:13 +0200
Message-Id: <20240531-mesa-panfrost-v1-0-84e23ae9a600@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3HWWYC/x3MQQqDMBBA0avIrB0w0bToVcRFTCd1KCZhRkpBv
 Luhy7f4/wQlYVKYmhOEvqycU4VpGwibT29CflWD7ezQud7gTuqx+BQl64FxfLporDPrI0BtilD
 k3/83w06HR8nhEzYusFzXDXqsE+1uAAAA
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 May 2024 12:48:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/269

Note: I do not have access to any RK3328 or RK3568 device so I could
not test those patches.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      mesa: enable lima on all rk3328 boards
      mesa: build panfrost for RK3568 boards

 recipes-graphics/mesa/mesa_%.bbappend | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 3381d6af6eabfb532da16863b785a95abba6b9e8
change-id: 20240531-mesa-panfrost-f975f1251b6c

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


