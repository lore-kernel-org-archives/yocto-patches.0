Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43091C55ABA
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 12:14:41 +0000 (UTC)
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch [79.135.106.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38993.1785932073135776901
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Aug 2026 05:14:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@on-the-web.ch header.s=protonmail2 header.b=YbK8+dO3;
 spf=pass (domain: on-the-web.ch, ip: 79.135.106.116, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1785932071; x=1786191271;
	bh=CJ7gbdZE414owJSNR8+ROn9lM98i/4jYsjFobeOzMHE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YbK8+dO30i3ec0+0GNWjLuuLyhiPk+PQ2rMr5xL9JvNhvkw4SWja+/0ouZ3zqzzKh
	 6/ExBoso1KRfBUCDKIf37Oejtr2uOhoDjUSueUDKUUxpMO+QyA4Sz1NoIMt7ZVxuZ1
	 6/jB3lt3No9FMltI7VEr6YjGPrLGpWWFW5fHjVamFYitqBa/lz7zx8uCCCvEf2NrRV
	 L4Ndd32VcA/GWfKEm6dLRuyVRxuHRQ/qdvdIvAg2TzCNmklT2D1YTWL0H9PxJDsuw5
	 GzOijSjkFp0mL/vOnIsWC+uCBllvnB3HBGpuphAJT2wOU9oHc54Vq11rsfD7bveG6j
	 M7DaMIl6RX6XQ==
Date: Wed, 05 Aug 2026 12:14:24 +0000
To: yocto-patches@lists.yoctoproject.org
From: sputnik@on-the-web.ch
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
Subject: [meta-rockchip][PATCH 2/3] bsp: rkbin-native: use SPDX LicenseRef for Rockchip proprietary firmware
Message-ID: <20260805121327.3946788-3-sputnik@on-the-web.ch>
In-Reply-To: <20260805121327.3946788-1-sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 0cac3ee480324b6f818ba4b2034e8ded24434b22
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------331537f7c39fbb8942511db77c75f39af7cf324a18b30eb4f382918449051e4c"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 12:14:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4633

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------331537f7c39fbb8942511db77c75f39af7cf324a18b30eb4f382918449051e4c
Content-Type: text/plain; charset=UTF-8
From: sputnik@on-the-web.ch
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>,
	Martin Herren <sputnik@on-the-web.ch>
Subject: [meta-rockchip][PATCH 2/3] bsp: rkbin-native: use SPDX LicenseRef for Rockchip proprietary firmware
Date: Wed,  5 Aug 2026 14:13:26 +0200
Message-ID: <20260805121327.3946788-3-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805121327.3946788-1-sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Herren <sputnik@on-the-web.ch>

OE-Core now parses LICENSE as an SPDX expression and warns on legacy
non-SPDX names such as "Proprietary".

Switch rockchip-rkbin-native to a recipe-specific LicenseRef backed by
NO_GENERIC_LICENSE.

References: oe-core e9d424738d6f ("classes/conf/lib: Parse LICENSE as SPD=
X Expression")

Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---
 recipes-bsp/rkbin/rockchip-rkbin-native_git.bb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb b/recipes-bsp=
/rkbin/rockchip-rkbin-native_git.bb
index 71d4246..d470a3d 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb
@@ -2,8 +2,9 @@ DESCRIPTION =3D "Rockchip native tools related to their r=
kbin blobs, e.g. ddrbin_t
=20
 SRC_URI =3D "git://github.com/rockchip-linux/rkbin;protocol=3Dhttps;bran=
ch=3Dmaster"
 SRCREV =3D "f43a462e7a1429a9d407ae52b4745033034a6cf9"
-LIC
ENSE =3D "Proprietary"
+LICENSE =3D "LicenseRef-Rockchip-rkbin"
 LIC_FILES_CHKSUM =3D "file://../LICENSE;md5=3D11e3673115959bf596feaaa6ea=
7ce9a5"
+NO_GENERIC_LICENSE[Rockchip-rkbin] =3D "../LICENSE"
=20
 inherit native
=20

--------331537f7c39fbb8942511db77c75f39af7cf324a18b30eb4f382918449051e4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmpzKSAJEIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeDr1UpBtJdvC747ZalrIHHFiEEJgeVlthQxcLg
gu1biK762GoqUA8AAEOeAQCbrIJth0NQWiTx9a6/siG+J7KIJF+yr2zdqlef
2IDG8QD/WoH0olgsJNEWIrYz6DPTBqCWVdsGmtKfPwo+uodUwQc=
=5Koi
-----END PGP SIGNATURE-----


--------331537f7c39fbb8942511db77c75f39af7cf324a18b30eb4f382918449051e4c--


