Return-Path: <vince_chang@aspeedtech.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1CAE7717F
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 07:52:57 +0000 (UTC)
Received: from TWMBX01.aspeed.com (TWMBX01.aspeed.com [211.20.114.72])
 by mx.groups.io with SMTP id smtpd.web11.5220.1733817174561147616
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Dec 2024 23:52:55 -0800
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
Subject: [PATCH v1 1/1] zephyr-sdk: Upgrade to version 0.16.9
Date: Tue, 10 Dec 2024 15:52:52 +0800
Message-ID: <20241210075252.1843799-2-vince_chang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241210075252.1843799-1-vince_chang@aspeedtech.com>
References: <20241210075252.1843799-1-vince_chang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 07:52:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/875

Signed-off-by: Vince Chang <vince_chang@aspeedtech.com>
---
 .../{zephyr-sdk_0.16.5-1.bb =3D> zephyr-sdk_0.16.9.bb}          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename meta-zephyr-core/recipes-devtools/zephyr-sdk/{zephyr-sdk_0.16.5-1.b=
b =3D> zephyr-sdk_0.16.9.bb} (83%)

diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5=
-1.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
similarity index 83%
rename from meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5-=
1.bb
rename to meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
index 5f49e37..57fe777 100644
--- a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5-1.bb
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
@@ -14,8 +14,8 @@ SDK_ARCHIVE =3D "zephyr-sdk-${PV}_linux-${BUILD_ARCH}.tar=
.xz"
 SDK_NAME =3D "${BUILD_ARCH}"
 SRC_URI =3D "https://github.com/zephyrproject-rtos/sdk-ng/releases/downloa=
d/v${PV}/${SDK_ARCHIVE};name=3D${SDK_NAME}"
=20
-SRC_URI[x86_64.sha256sum] =3D "01f942146d2fc6d6afd5afe6f4b5c315525d2c937c7=
e613d3312b0992b33bc68"
-SRC_URI[aarch64.sha256sum] =3D "1749b6891a6a6e70b013d8b31ff067c5a94891f651=
985a6da9a20367b2deb6c7"
+SRC_URI[x86_64.sha256sum] =3D "9b4b96f8df594801a84fce1aa112a84cdfcd430efc2=
a74229907b6421fb859a8"
+SRC_URI[aarch64.sha256sum] =3D "a8c1731ad602553304e539a7ade9cdb34caabc1850=
d581585cbba0372a7493b2"
=20
 S =3D "${WORKDIR}/sources"
 UNPACKDIR =3D "${S}"
--=20
2.25.1


