Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08456C55173
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 15:56:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.622.1785513370384045333
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 08:56:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=nBlgNVDy;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A54B0204C;
	Fri, 31 Jul 2026 08:56:05 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 419033F66F;
	Fri, 31 Jul 2026 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785513369; bh=+Qfqz3oc9142vA/WpSLjHIj7NEgglOmW5v9dKqSQlak=;
	h=From:To:Cc:Subject:Date:From;
	b=nBlgNVDyVghjycvuk5ot1KVckjfGE+/bemlPTVBkIERWX6Fy3bpMwewCRsZWmNuVv
	 aWPXF0kvFzGF7k9hhZDWz4WWBNVh/FK9kNvNT20XV9HqnZBJdYffL5zCOMcM/ysght
	 Z47/pwb1TiTtecQI02wsK8LiziaFn9Vaq0RIfvQ0=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH 1/3] mingw-w64: upgrade 12.0.0 -> 13.0.0
Date: Fri, 31 Jul 2026 16:56:02 +0100
Message-ID: <20260731155604.1486464-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 15:56:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4612

Notable changes:

- Added import libraries for msvcr40d.dll, msvcrtd.dll, msvcr70d.dll,
  msvcr71d.dll, msvcr80d.dll, msvcr100d.dll, msvcr110d.dll.
- Better CRT API consistency between UCRT and MSVCRT, making many APIs
  available to earlier versions of the MSVCR* runtime as well.
- CRTDLL stat API fixes.
- Updated Hyper-V headers.
- Synchronized with Wine headers (from Wine 10.9).
- Many other new win32 APIs.
- Fix _atexit call differing between DLLs and EXEs.
- Basic support for ARM64EC targets (arm64ec-w64-mingw32).
- Make it possible to build winpthreads with MSVC and clang-cl.
- Many small fixes for gendef, genidl and genpeimg.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 recipes-devtools/mingw-w64/mingw-w64.inc                        | 2 +-
 ...-headers_12.0.0.bb =3D> nativesdk-mingw-w64-headers_13.0.0.bb} | 0
 ...-runtime_12.0.0.bb =3D> nativesdk-mingw-w64-runtime_13.0.0.bb} | 0
 ...eads_12.0.0.bb =3D> nativesdk-mingw-w64-winpthreads_13.0.0.bb} | 0
 4 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-devtools/mingw-w64/{nativesdk-mingw-w64-headers_12.0.0.bb=
 =3D> nativesdk-mingw-w64-headers_13.0.0.bb} (100%)
 rename recipes-devtools/mingw-w64/{nativesdk-mingw-w64-runtime_12.0.0.bb=
 =3D> nativesdk-mingw-w64-runtime_13.0.0.bb} (100%)
 rename recipes-devtools/mingw-w64/{nativesdk-mingw-w64-winpthreads_12.0.=
0.bb =3D> nativesdk-mingw-w64-winpthreads_13.0.0.bb} (100%)

diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc b/recipes-devtools/=
mingw-w64/mingw-w64.inc
index a24e96c..46d28af 100644
--- a/recipes-devtools/mingw-w64/mingw-w64.inc
+++ b/recipes-devtools/mingw-w64/mingw-w64.inc
@@ -4,7 +4,7 @@ LIC_FILES_CHKSUM =3D "file://${UNPACKDIR}/mingw-w64-v${PV=
}/COPYING;md5=3Dbb936f0e04d
 COMPATIBLE_HOST =3D ".*-mingw.*"
=20
 SRC_URI =3D "${SOURCEFORGE_MIRROR}/project/mingw-w64/mingw-w64/mingw-w64=
-release/mingw-w64-v${PV}.tar.bz2"
-SRC_URI[sha256sum] =3D "cc41898aac4b6e8dd5cffd7331b9d9515b912df4420a3a61=
2b5ea2955bbeed2f"
+SRC_URI[sha256sum] =3D "5afe822af5c4edbf67daaf45eec61d538f49eef6b19524de=
64897c6b95828caf"
=20
 UPSTREAM_CHECK_URI =3D "http://sourceforge.net/projects/mingw-w64/files/=
mingw-w64/mingw-w64-release/"
 UPSTREAM_CHECK_REGEX =3D "mingw-w64-v(?P<pver>(\d+[\.\-_]*)+)\.tar"
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_12.0.=
0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_13.0.0.bb
similarity index 100%
rename from recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_12.0.0=
.bb
rename to recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_13.0.0.b=
b
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_12.0.=
0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_13.0.0.bb
similarity index 100%
rename from recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_12.0.0=
.bb
rename to recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_13.0.0.b=
b
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_1=
2.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_13.=
0.0.bb
similarity index 100%
rename from recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_12=
.0.0.bb
rename to recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_13.0=
.0.bb
--=20
2.43.0


