Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0398C5AC67
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 21:42:36 +0000 (UTC)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30690.1786052554301691703
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Aug 2026 14:42:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@on-the-web.ch header.s=protonmail2 header.b=dmsHti+C;
 spf=pass (domain: on-the-web.ch, ip: 185.70.43.17, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1786052552; x=1786311752;
	bh=AsTtVZyWmsF9YmDbZp0FX0gLbXr1EoMjpQBu0KSHTL0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dmsHti+C3Bc5+Wv8R67bxBZEeGfEcsdbiTKTVjJVYLKoozFj3XEIq0Bu7C6l9mBa0
	 p1mgNucN0toKbCljhlN48mY49GcSzwUkvCjOdCFQ4hmFqTLD1l50ACPUMZz07mHd9x
	 1WGYsAelonWVDp3eILDizX1mbCTuuVxFbfbzC5Sejd6VGh9ZNIrGKJANEGJX2UEJCQ
	 ZI/wCFFzB1EjRt3nyL932Rhg0QeBKUp5k4y4iyx9v//vLrpZZBWZOEIpO/qOFMAhuj
	 L4CArNZNM4208mQL9pp0xx1gDuOWwiVvcG43gJdRCt4e2GGbksZ+1ys5Yq5gYY7E+f
	 3JGqqdAfEnNEQ==
Date: Thu, 06 Aug 2026 21:42:28 +0000
To: yocto-patches@lists.yoctoproject.org
From: sputnik@on-the-web.ch
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][PATCH v2 3/3] bsp: rkbin: rk3308-rkbin: replace deprecated CLOSED license with a LicenseRef
Message-ID: <20260806214149.714963-4-sputnik@on-the-web.ch>
In-Reply-To: <20260805121327.3946788-1-sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 0bf8bbca6c75a71fc54676b69367dfc5918d10c0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------a9caff7d803e43c9586fab937a16519f2c579145848df014e8d63ea5b623953b"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Aug 2026 21:42:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4647

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------a9caff7d803e43c9586fab937a16519f2c579145848df014e8d63ea5b623953b
Content-Type: text/plain; charset=UTF-8
From: sputnik@on-the-web.ch
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>,
	Martin Herren <sputnik@on-the-web.ch>,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][PATCH v2 3/3] bsp: rkbin: rk3308-rkbin: replace deprecated CLOSED license with a LicenseRef
Date: Thu,  6 Aug 2026 23:41:49 +0200
Message-ID: <20260806214149.714963-4-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805121327.3946788-1-sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Herren <sputnik@on-the-web.ch>

OE-Core now deprecates `LICENSE =3D "CLOSED"` in favour of a LicenseRef
backed by NO_GENERIC_LICENSE.

This recipe pins an older rkbin revision whose tree ships no LICENSE
file, which is probably why it historically used CLOSED as well as
pointing its LIC_FILES_CHKSUM at the README.

References: oe-core e9d424738d6f ("classes/conf/lib: Parse LICENSE as SPD=
X Expression")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
AI-Generated: Z.ai:GLM-5.2 OpenCode Go
Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---
Changes in v2:
- Added Reviewed-by tag
- Added AI-Generated tag

 recipes-bsp/rkbin/rk3308-rkbin_git.bb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/rkbin/rk3308-rkbin_git.bb b/recipes-bsp/rkbin/rk=
3308-rkbin_git.bb
index 7307e66..2ee173c 100644
--- a/recipes-bsp/rkbin/rk3308-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
@@ -1,6 +1,7 @@
 DESCRIPTION =3D "Roc
kchip Firmware and Tool Binaries"
-LICENSE =3D "CLOSED"
+LICENSE =3D "LicenseRef-rk3308-rkbin-CLOSED"
 LIC_FILES_CHKSUM:rk3308 =3D "file://README;md5=3D39cc9df955478b8df26158d=
489fdcc95"
+NO_GENERIC_LICENSE[rk3308-rkbin-CLOSED] =3D "README"
=20
 SRC_URI =3D "git://github.com/rockchip-linux/rkbin;protocol=3Dhttps;bran=
ch=3Dmaster"
 SRCREV =3D "e65b97b511f1349156702db40694454c141d8fe2"

--------a9caff7d803e43c9586fab937a16519f2c579145848df014e8d63ea5b623953b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmp0/8MJEIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfrLRFmjqtBcZX3F5z9EdtrFiEEJgeVlthQxcLg
gu1biK762GoqUA8AAA7xAQDFMXmEwJO0rX9omIVKNKfx5CGshuPVVqYsH5Rv
E6mR5gEAylKp1i6lkVfVAs9xnS4qFjUqIYAQTv1+jR9wbKY01Qs=
=gAAX
-----END PGP SIGNATURE-----


--------a9caff7d803e43c9586fab937a16519f2c579145848df014e8d63ea5b623953b--


