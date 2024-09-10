Return-Path: <anusmita.duttamazumder@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700FAECE582
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 08:11:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.18017.1725955872843043277
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Sep 2024 01:11:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=softfail (domain: linaro.org, ip: 217.140.110.172, mailfrom: anusmita.duttamazumder@linaro.org)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 461C2113E;
	Tue, 10 Sep 2024 01:11:41 -0700 (PDT)
Received: from PW04GXMM.arm.com (PW04GXMM.arm.com [10.1.38.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC6E03F64C;
	Tue, 10 Sep 2024 01:11:11 -0700 (PDT)
From: anusmita.duttamazumder@linaro.org
To: yocto-patches@lists.yoctoproject.org
Cc: Anusmita Dutta Mazumder <anusmita.duttamazumder@linaro.org>
Subject: [meta-parsec][PATCH] Add styhead LAYERSERIES_COMPAT
Date: Tue, 10 Sep 2024 09:11:04 +0100
Message-Id: <20240910081104.243290-1-anusmita.duttamazumder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Sep 2024 08:11:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/640

From: Anusmita Dutta Mazumder <anusmita.duttamazumder@linaro.org>

oe-core has switched to styhead only.
Add layer compatibility to meta-parsec
for styhead.

Signed-off-by: Anusmita Dutta Mazumder <anusmita.duttamazumder@linaro.org=
>
---
 meta-parsec/conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-parsec/conf/layer.conf b/meta-parsec/conf/layer.conf
index e9d0230..e59b60c 100644
--- a/meta-parsec/conf/layer.conf
+++ b/meta-parsec/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS +=3D "parsec-layer"
 BBFILE_PATTERN_parsec-layer =3D "^${LAYERDIR}/"
 BBFILE_PRIORITY_parsec-layer =3D "5"
=20
-LAYERSERIES_COMPAT_parsec-layer =3D "nanbield scarthgap"
+LAYERSERIES_COMPAT_parsec-layer =3D "styhead nanbield scarthgap"
=20
 LAYERDEPENDS_parsec-layer =3D "core clang-layer"
 BBLAYERS_LAYERINDEX_NAME_parsec-layer =3D "meta-parsec"
--=20
2.34.1


