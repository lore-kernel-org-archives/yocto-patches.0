Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B2AC5AC7A
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 21:42:36 +0000 (UTC)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30687.1786052549386510988
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Aug 2026 14:42:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@on-the-web.ch header.s=protonmail2 header.b=IOkQ+n2T;
 spf=pass (domain: on-the-web.ch, ip: 185.70.43.17, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1786052547; x=1786311747;
	bh=TrtpzojvHVIhtzT7yacBdPTwkj1uY/eVq5B/ZE7MEHE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IOkQ+n2TMxDaIxd0OjirUZ5Y9q3rHyTh1bVCbT1umG3fUWjxi22uxpXSgNY5IjpLG
	 LJSNOwHiHXYrttJ7zrX8uA5+hj47vBw9BQOdV+OvyNDJug0cXvjqPfwhShgxFLAAcv
	 f5hMXif37U3uPdSQksZIZBHGjlN0alNXJgn4I952WhjJUO+3ZcGreyj3yEAOEUO87k
	 GQnLriq9AzmF2dyRuTGU1D/4qCmBFlBMBNGSjUKhCGTtoNO3ezfPRtCy6vL6llsjgT
	 PdxifOHw1XrjhXHrNPn/4bGOBkvA28EbKAkj/QeUFurZ4Wb+0fAjnUido5oMLx9uTj
	 KCGOnSBNEJp3w==
Date: Thu, 06 Aug 2026 21:42:21 +0000
To: yocto-patches@lists.yoctoproject.org
From: sputnik@on-the-web.ch
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][PATCH v2 2/3] bsp: rkbin-native: use SPDX LicenseRef for Rockchip proprietary firmware
Message-ID: <20260806214149.714963-3-sputnik@on-the-web.ch>
In-Reply-To: <20260805121327.3946788-1-sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 33a9fac61ccc809ec04475bc55af168ee667cec8
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------abe611e8f80d32ba4a5d7f2aea0344bd562922f8dac31ae14f4690016f522acf"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Aug 2026 21:42:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4646

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------abe611e8f80d32ba4a5d7f2aea0344bd562922f8dac31ae14f4690016f522acf
Content-Type: text/plain; charset=UTF-8
From: sputnik@on-the-web.ch
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>,
	Martin Herren <sputnik@on-the-web.ch>,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][PATCH v2 2/3] bsp: rkbin-native: use SPDX LicenseRef for Rockchip proprietary firmware
Date: Thu,  6 Aug 2026 23:41:48 +0200
Message-ID: <20260806214149.714963-3-sputnik@on-the-web.ch>
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

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
AI-Generated: Z.ai:GLM-5.2 OpenCode Go
Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---
Changes in v2:
- Added Reviewed-by tag
- Added AI-Generated tag

 recipes-bsp/rkbin/rockchip-rkbin-native_git.bb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb b/recipes-bsp=
/rkbin/rockchip-rkbin-native_git.bb
index 71d4246..d470a3d 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb
+++ b/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb
@@ -2,8 +2,9 @@ DESCRIPTION =3D "Rockchip native tools related to their r=
kbin
 blobs, e.g. ddrbin_t
=20
 SRC_URI =3D "git://github.com/rockchip-linux/rkbin;protocol=3Dhttps;bran=
ch=3Dmaster"
 SRCREV =3D "f43a462e7a1429a9d407ae52b4745033034a6cf9"
-LICENSE =3D "Proprietary"
+LICENSE =3D "LicenseRef-Rockchip-rkbin"
 LIC_FILES_CHKSUM =3D "file://../LICENSE;md5=3D11e3673115959bf596feaaa6ea=
7ce9a5"
+NO_GENERIC_LICENSE[Rockchip-rkbin] =3D "../LICENSE"
=20
 inherit native
=20

--------abe611e8f80d32ba4a5d7f2aea0344bd562922f8dac31ae14f4690016f522acf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmp0/7wJEIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcQOz/IlzU1IYCPiPqJn8xpFiEEJgeVlthQxcLg
gu1biK762GoqUA8AACi0AQCRalN8FMTzah3VDXwF+8ed10Tz7stlU0VYZaZ8
SLhcaQD/cEt3EY2gK7s5IiEsvIbMirpmpRyqW0nXF6hDW3/P2AU=
=rNrj
-----END PGP SIGNATURE-----


--------abe611e8f80d32ba4a5d7f2aea0344bd562922f8dac31ae14f4690016f522acf--


