Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203A7C18E7C
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 14:27:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.8945.1740493616653265792
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Feb 2025 06:26:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 858581BCB;
	Tue, 25 Feb 2025 06:27:12 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B1A3C3F6A8;
	Tue, 25 Feb 2025 06:26:55 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH] libiconv: tell autoreconf where to find supplementary macros
Date: Tue, 25 Feb 2025 14:26:51 +0000
Message-ID: <20250225142651.703926-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Feb 2025 14:27:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1131

The libiconv build is non-idiomatic, and most importantly doesn't use
automake so there's no way to tell aclocal where to find macros.

Currently that isn't an issue because our autotools class explicitly
specifies any directories it can find containing macros but that will
be removed shortly, so tell autoreconf where to find the macros as the
upstream Makefile.devel does.

Note that we need to pass absolute paths here because libiconv has a
nested configure script which fails when autoreconf is used with
relative paths.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 recipes-support/libiconv/libiconv_1.15.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-support/libiconv/libiconv_1.15.bb b/recipes-support/=
libiconv/libiconv_1.15.bb
index b58abb4..2f2b473 100644
--- a/recipes-support/libiconv/libiconv_1.15.bb
+++ b/recipes-support/libiconv/libiconv_1.15.bb
@@ -19,6 +19,9 @@ S =3D "${WORKDIR}/libiconv-${PV}"
=20
 inherit autotools pkgconfig gettext
=20
+# Need to use absolute paths as autoreconf will recurse into libchardet
+EXTRA_AUTORECONF +=3D "-I ${S}/m4 -I ${S}/srcm4"
+
 python __anonymous() {
     if d.getVar("TARGET_OS") !=3D "linux":
         return
--=20
2.43.0


