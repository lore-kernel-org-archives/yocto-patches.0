Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAABC54F54
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 15:56:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.624.1785513371861848662
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 08:56:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=Nq2FmyvS;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 492B4204C;
	Fri, 31 Jul 2026 08:56:07 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D60B53F66F;
	Fri, 31 Jul 2026 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785513371; bh=q+uy1sYZK7mIQmRRruVj4vUHhPqNALz4MxZpQ/ue0rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nq2FmyvSCexUrlVy3N9oZ+Pv9sA3gvQzsmRFOeKUw/vzjMu72lfDW4ogonYOhyc6j
	 XfPwOD/WpvYzPXEmPR+kpWxBKfzk30vbMr2k+KXkGCukBgo7VTUZomheDt/GYkA7FF
	 O/NGULvlSjMCY+dHH//GHehubN99gZKkD5F4Z1JU=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH 3/3] mingw-w64: re-enable parallel builds
Date: Fri, 31 Jul 2026 16:56:04 +0100
Message-ID: <20260731155604.1486464-3-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731155604.1486464-1-ross.burton@arm.com>
References: <20260731155604.1486464-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 15:56:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4614

The build race that caused this to be disabled in 2022[1] appears to
have been resolved, and the improvement is significant:

  nativesdk-mingw-w64-runtime        do_compile    -362.1s   -97.9%     3=
69.9s -> 7.8s
  nativesdk-mingw-w64-winpthreads    do_compile     -22.4s   -97.9%      =
22.9s -> 0.5s

[1] meta-mingw 5ef7460 ("mingw-w64: Disable parallel build")

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 recipes-devtools/mingw-w64/mingw-w64.inc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc b/recipes-devtools/=
mingw-w64/mingw-w64.inc
index d45fea7..d271f21 100644
--- a/recipes-devtools/mingw-w64/mingw-w64.inc
+++ b/recipes-devtools/mingw-w64/mingw-w64.inc
@@ -8,7 +8,3 @@ SRC_URI[sha256sum] =3D "6eaf921d9eb987d3820b364ea9775bc19=
b965ec81490b6fdd716526c28
=20
 UPSTREAM_CHECK_URI =3D "http://sourceforge.net/projects/mingw-w64/files/=
mingw-w64/mingw-w64-release/"
 UPSTREAM_CHECK_REGEX =3D "mingw-w64-v(?P<pver>(\d+[\.\-_]*)+)\.tar"
-#| Assembler messages:
-#| i686-w64-mingw32-dlltool --as-flags=3D--32 -m i386 -k --as=3Di686-w64=
-mingw32-as  --output-lib lib32/libd3dcompiler_41.a  --input-def ../mingw=
-w64-v9.0.0/mingw-w64-crt/lib32/d3dcompiler_41.def
-#| i686-w64-mingw32-dlltool: failed to open temporary tail file: D3DComp=
iler_dll_t.o: No such file or directory
-PARALLEL_MAKE =3D ""
--=20
2.43.0


