Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8A9C5516F
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 15:56:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.623.1785513371046146007
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 08:56:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=WLApRS6h;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7583522C7;
	Fri, 31 Jul 2026 08:56:06 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11C4C3F66F;
	Fri, 31 Jul 2026 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785513370; bh=0zcxELzsVeBrDxdAFA6llaPGiOY5tvy64zAjJaOvbwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLApRS6ha7OzXjtSBT3Iqxp6aMT/RuuQGpJA41cmhRGakLjMGHBmcym7kMPKZPRkG
	 OxMv9RyBSa+WnglgiRlJJKby9/8tDH83xWxrskpMj6q7fF4f2xTHp8u5QvuDxO5WCM
	 oguNKp7+oHfVyAsoauQvaWuOB06tJATJn1DwvoRQ=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH 2/3] mingw-w64: upgrade 13.0.0 -> 14.0.0
Date: Fri, 31 Jul 2026 16:56:03 +0100
Message-ID: <20260731155604.1486464-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731155604.1486464-1-ross.burton@arm.com>
References: <20260731155604.1486464-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 15:56:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4613

Notable changes:

- Various fixes to stat() family
- Various fixes to mbstowcs/wcstomb
- Added C23 binary mingw_pformat specifiers %b and %B
- Add support for mingw_pformat %ws, %wS, %wc and %wC
- Added C23 half-revolution trigonometric math functions
- Sync against Wine version 11.5
- gendef: Print --kill-at information only for i386
- Initial support for arm64ec-w64-mingw32
- Fix stack guard function when built with GCC -fstack-protector-strong
- Removed the armv7 experimental softmath code
- Removed MINGW_HAS_SECURE_API, secure APIs are always provided
- Removed MINGW_HAS_DDK_H

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 recipes-devtools/mingw-w64/mingw-w64.inc                        | 2 +-
 ...-headers_13.0.0.bb =3D> nativesdk-mingw-w64-headers_14.0.0.bb} | 0
 ...-runtime_13.0.0.bb =3D> nativesdk-mingw-w64-runtime_14.0.0.bb} | 0
 ...eads_13.0.0.bb =3D> nativesdk-mingw-w64-winpthreads_14.0.0.bb} | 0
 4 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-devtools/mingw-w64/{nativesdk-mingw-w64-headers_13.0.0.bb=
 =3D> nativesdk-mingw-w64-headers_14.0.0.bb} (100%)
 rename recipes-devtools/mingw-w64/{nativesdk-mingw-w64-runtime_13.0.0.bb=
 =3D> nativesdk-mingw-w64-runtime_14.0.0.bb} (100%)
 rename recipes-devtools/mingw-w64/{nativesdk-mingw-w64-winpthreads_13.0.=
0.bb =3D> nativesdk-mingw-w64-winpthreads_14.0.0.bb} (100%)

diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc b/recipes-devtools/=
mingw-w64/mingw-w64.inc
index 46d28af..d45fea7 100644
--- a/recipes-devtools/mingw-w64/mingw-w64.inc
+++ b/recipes-devtools/mingw-w64/mingw-w64.inc
@@ -4,7 +4,7 @@ LIC_FILES_CHKSUM =3D "file://${UNPACKDIR}/mingw-w64-v${PV=
}/COPYING;md5=3Dbb936f0e04d
 COMPATIBLE_HOST =3D ".*-mingw.*"
=20
 SRC_URI =3D "${SOURCEFORGE_MIRROR}/project/mingw-w64/mingw-w64/mingw-w64=
-release/mingw-w64-v${PV}.tar.bz2"
-SRC_URI[sha256sum] =3D "5afe822af5c4edbf67daaf45eec61d538f49eef6b19524de=
64897c6b95828caf"
+SRC_URI[sha256sum] =3D "6eaf921d9eb987d3820b364ea9775bc19b965ec81490b6fd=
d716526c28e1995c"
=20
 UPSTREAM_CHECK_URI =3D "http://sourceforge.net/projects/mingw-w64/files/=
mingw-w64/mingw-w64-release/"
 UPSTREAM_CHECK_REGEX =3D "mingw-w64-v(?P<pver>(\d+[\.\-_]*)+)\.tar"
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_13.0.=
0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_14.0.0.bb
similarity index 100%
rename from recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_13.0.0=
.bb
rename to recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_14.0.0.b=
b
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_13.0.=
0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_14.0.0.bb
similarity index 100%
rename from recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_13.0.0=
.bb
rename to recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_14.0.0.b=
b
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_1=
3.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_14.=
0.0.bb
similarity index 100%
rename from recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_13=
.0.0.bb
rename to recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_14.0=
.0.bb
--=20
2.43.0


