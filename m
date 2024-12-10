Return-Path: <vince_chang@aspeedtech.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5C8E77180
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 07:52:57 +0000 (UTC)
Received: from TWMBX01.aspeed.com (TWMBX01.aspeed.com [211.20.114.72])
 by mx.groups.io with SMTP id smtpd.web11.5220.1733817174561147616
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Dec 2024 23:52:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: aspeedtech.com, ip: 211.20.114.72, mailfrom: vince_chang@aspeedtech.com)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 10 Dec
 2024 15:52:52 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 10 Dec 2024 15:52:52 +0800
From: Vince Chang <vince_chang@aspeedtech.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [meta-zephyr][PATCH v1 0/1] zephyr-sdk: Upgrade to version 0.16.9
Date: Tue, 10 Dec 2024 15:52:51 +0800
Message-ID: <20241210075252.1843799-1-vince_chang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 07:52:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/874

Upgrade zephyr-sdk.

Vince Chang (1):
  zephyr-sdk: Upgrade to version 0.16.9

 .../{zephyr-sdk_0.16.5-1.bb =3D> zephyr-sdk_0.16.9.bb}          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename meta-zephyr-core/recipes-devtools/zephyr-sdk/{zephyr-sdk_0.16.5-1.b=
b =3D> zephyr-sdk_0.16.9.bb} (83%)

--=20
2.25.1


