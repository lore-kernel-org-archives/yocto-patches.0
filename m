Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D774AC3064D
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 15:00:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.27030.1719932416147842092
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Jul 2024 08:00:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B3B5339
	for <yocto-patches@lists.yoctoproject.org>; Tue,  2 Jul 2024 08:00:40 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F4A03F766
	for <yocto-patches@lists.yoctoproject.org>; Tue,  2 Jul 2024 08:00:15 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder2] config.py: meta-webosose now depends on meta-security
Date: Tue,  2 Jul 2024 16:00:10 +0100
Message-Id: <20240702150010.1003898-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jul 2024 15:00:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/410

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index d25747c..6b23cda 100644
--- a/config.py
+++ b/config.py
@@ -33,7 +33,7 @@ buildertorepos =3D {
     "auh":  ["poky", "auto-upgrade-helper"],
     "auh-meta-oe":  ["poky", "meta-openembedded", "auto-upgrade-helper"]=
,
     "metrics":  ["poky", "meta-openembedded"],
-    "meta-webosose":  ["poky", "meta-clang", "meta-openembedded", "meta-=
qt6", "meta-webosose"],
+    "meta-webosose":  ["poky", "meta-clang", "meta-openembedded", "meta-=
qt6", "meta-webosose", "meta-security"],
     "default": ["poky"]
 }
=20
--=20
2.34.1


