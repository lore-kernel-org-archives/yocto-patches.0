Return-Path: <louis.rannou@semalibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162B9CDE03F
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 08:30:08 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13574.1763109005153858108
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 00:30:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: no key for signature: lookup dkim._domainkey.semalibre.com on 100.100.100.100:53: no such host" header.i=@semalibre.com header.s=dkim header.b=WKU+EdYN;
 spf=pass (domain: semalibre.com, ip: 185.246.84.56, mailfrom: louis.rannou@semalibre.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CB7B81A1A9E;
	Fri, 14 Nov 2025 08:30:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A14CD6060E;
	Fri, 14 Nov 2025 08:30:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A0F8102F29CE;
	Fri, 14 Nov 2025 09:30:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=semalibre.com;
	s=dkim; t=1763109003;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=O9/TS9nIjwbVOFEfkdMLTNGK6t/KkLRNZO5ovuAotwk=;
	b=WKU+EdYNDfB05QsFNhC9IZNdxc6Z4YKrHce4qQDzrLpwChvztdZtuYQhonK5tlrGsBzvks
	4B81hfuHZ9f/b6RmM0Hm1mEhi/gl7giltz1tesh2EPDb6h2JqbJgJo4FQobBOkj+NowfV4
	EtSi4yxyifxabxp80laHGykqq+111CotMePkfmxKjqTN29zNVeId1B7D4L4ditmOqTt11U
	9yf1+Rej/S5WPpYPrWPgcoOkOiCUG0g29gvCz86OQ224UrNQVdA1mJe6lfDb/JFyKs3uf/
	tHNr+L3hw+h3QfGgqA4wYJ+OPJsIFpiZILeNfaWnI7pRnGA/WJLQNz2GDkQfHA==
From: Louis Rannou <louis.rannou@semalibre.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com,
	rybczynska@gmail.com,
	pascal.eberhard@non.se.com,
	yi.zhao@windriver.com,
	Louis Rannou <louis.rannou@non.se.com>
Subject: [meta-security][PATCH 1/4] openscap: update to 1.4.2
Date: Fri, 14 Nov 2025 09:29:47 +0100
Message-ID: <20251114-openscap_bump-v1-1-1c8169b8e332@non.se.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
References: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 08:30:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2554

From: Louis Rannou <louis.rannou@non.se.com>

SRC_URI is based on the github release instead of the SHA for more effici=
ency.

Extra fix:
  - typo in the RDEPENDS class-target override ('-' instead of ':')
  - typo SUMARRY -> SUMMARY

New in 1.4.2 (2025-04-06):
  https://github.com/OpenSCAP/openscap/releases/tag/1.4.2

  - Maintenance, bug fix
    - Fix thread synchronization bugs
    - Fix textfilecontent54_probe behaviour for negative instance numbers
    - Fix signature obtaining in rpm_info probe

Signed-off-by: Louis Rannou <louis.rannou@non.se.com>

fix
---
 .../openscap/{openscap_1.4.1.bb =3D> openscap_1.4.2.bb}       | 13 +++++=
++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/recipes-compliance/openscap/openscap_1.4.1.bb b/recipes-comp=
liance/openscap/openscap_1.4.2.bb
similarity index 87%
rename from recipes-compliance/openscap/openscap_1.4.1.bb
rename to recipes-compliance/openscap/openscap_1.4.2.bb
index 3e5f00a..f7c7aec 100644
--- a/recipes-compliance/openscap/openscap_1.4.1.bb
+++ b/recipes-compliance/openscap/openscap_1.4.2.bb
@@ -1,7 +1,7 @@
 # Copyright (C) 2017  - 2023 Armin Kuster  <akuster808@gmail.com>
 # Released under the MIT license (see COPYING.MIT for the terms)
=20
-SUMARRY =3D "NIST Certified SCAP 1.2 toolkit"
+SUMMARY =3D "NIST Certified SCAP 1.2 toolkit"
 HOME_URL =3D "https://www.open-scap.org/tools/openscap-base/"
 LIC_FILES_CHKSUM =3D "file://COPYING;md5=3Dfbc093901857fcd118f065f900982=
c24"
 LICENSE =3D "LGPL-2.1-only"
@@ -9,11 +9,12 @@ LICENSE =3D "LGPL-2.1-only"
 DEPENDS =3D "dbus acl bzip2 pkgconfig gconf procps curl libxml2 libxslt =
libcap swig libpcre  xmlsec1"
 DEPENDS:class-native =3D "pkgconfig-native swig-native curl-native libxm=
l2-native libxslt-native libcap-native libpcre-native xmlsec1-native"
=20
-SRC_URI =3D "git://github.com/OpenSCAP/openscap.git;branch=3Dmain;protoc=
ol=3Dhttps \
-           file://0001-CMakeLists.txt-fix-installation-directory-for-sys=
tem.patch \
-          "
+SRC_URI =3D " \
+    https://github.com/OpenSCAP/openscap/releases/download/1.4.2/opensca=
p-${PV}.tar.gz \
+    file://0001-CMakeLists.txt-fix-installation-directory-for-system.pat=
ch \
+"
=20
-SRCREV =3D "23a8ea3de3c4fd6017db4067675a81287177166e"
+SRC_URI[sha512sum] =3D "126b88d028fafe9c2af882ae7b90ad59a7a429899b45cfa0=
f4fea188f32b0f9c51615d69a172e9bd4c0a6663aaf40e8fd85c8563575fce00099f3d58d=
572cbda"
=20
 inherit cmake pkgconfig python3native python3targetconfig perlnative sys=
temd
=20
@@ -64,5 +65,5 @@ FILES:${PN} +=3D "${PYTHON_SITEPACKAGES_DIR}"
=20
=20
 RDEPENDS:${PN} =3D "libxml2 python3-core libgcc bash"
-RDEPENDS:${PN}-class-target =3D "libxml2 python3-core libgcc bash os-rel=
ease"
+RDEPENDS:${PN}:class-target =3D "libxml2 python3-core libgcc bash os-rel=
ease"
 BBCLASSEXTEND =3D "native"

--=20
2.43.0

