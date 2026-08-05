Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F207C55174
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 12:14:31 +0000 (UTC)
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38991.1785932066206972240
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Aug 2026 05:14:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@on-the-web.ch header.s=protonmail2 header.b=iL4993vB;
 spf=pass (domain: on-the-web.ch, ip: 185.70.43.96, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1785932063; x=1786191263;
	bh=S8djXvzRMNeScZUig4Njv/n1pW5wSbk49U3K5j/mERQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iL4993vB+MI8MJrM5cbz7vLZ3c/jozVjQ4ZeD0kTjlStaH3aiCWpM6pfSNWSIC4Dw
	 dHXMfxXMZiVHBbKstJ0URBockeY2tWQYBiNLLSH9AnXQ8w2PyDYae3bt6O8iSnDNvO
	 dts/wNlEsVSjSu2auL4ajxHUC2a0qLexGJ+dhLQ6ZndWwTXYG1K7Y3ko+zX8mmJbkq
	 FEZiTWJz7ZtibY4KpRlutkPekITMWgrEC49wYKeqwMznBvn+ifFqkdhl0/u8gf2C5F
	 SXLU6Hm0zH/SQsdpdI45H49JnrQJ0ne6tPtkjDBxT/7fTHVH3tYIVnsMyIe9YtO6ZK
	 FXcrXgE4xbpzQ==
Date: Wed, 05 Aug 2026 12:14:20 +0000
To: yocto-patches@lists.yoctoproject.org
From: sputnik@on-the-web.ch
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
Subject: [meta-rockchip][PATCH 1/3] bsp: rkbin: use SPDX LicenseRef for Rockchip proprietary firmware
Message-ID: <20260805121327.3946788-2-sputnik@on-the-web.ch>
In-Reply-To: <20260805121327.3946788-1-sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 094e0a1f8a06f3a19d74361e01314adb2d31ae9c
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------34f92f0b860adc60a7323f15c5639210b290dbdc25701ae9b2fd5483d5bfa229"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 12:14:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4632

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------34f92f0b860adc60a7323f15c5639210b290dbdc25701ae9b2fd5483d5bfa229
Content-Type: text/plain; charset=UTF-8
From: sputnik@on-the-web.ch
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>,
	Martin Herren <sputnik@on-the-web.ch>
Subject: [meta-rockchip][PATCH 1/3] bsp: rkbin: use SPDX LicenseRef for Rockchip proprietary firmware
Date: Wed,  5 Aug 2026 14:13:25 +0200
Message-ID: <20260805121327.3946788-2-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805121327.3946788-1-sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Herren <sputnik@on-the-web.ch>

OE-Core now parses LICENSE as an SPDX expression and warns on legacy
non-SPDX names such as "Proprietary".

Switch the rkbin family (rockchip-rkbin.inc, used by -ddr, -optee-os and
-tf-a) to a recipe-specific LicenseRef backed by NO_GENERIC_LICENSE, so
the SPDX manifest references the real Rockchip LICENSE at the repo root.

References: oe-core e9d424738d6f ("classes/conf/lib: Parse LICENSE as SPD=
X Expression")

Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---
 recipes-bsp/rkbin/rockchip-rkbin.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/roc=
kchip-rkbin.inc
index 9ddd54f..d715b44 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
@@ -1,7 +1,8 @@
 SRC_URI =3D "git://github.com/rockchip-linux/rkbin;protocol=3Dhttps;bran=
ch=3Dmaster"
 SRCREV =3D "f43a462e7a1429a9d407ae52b4745033034a6cf9"
-LICENSE =3D
 "Proprietary"
+LICENSE =3D "LicenseRef-Rockchip-rkbin"
 LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D11e3673115959bf596feaaa6ea7ce=
9a5"
+NO_GENERIC_LICENSE[Rockchip-rkbin] =3D "LICENSE"
=20
 inherit bin_package deploy
=20

--------34f92f0b860adc60a7323f15c5639210b290dbdc25701ae9b2fd5483d5bfa229
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmpzKRwJEIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdU2RWzIVRAbSpmLEGm/KiAFiEEJgeVlthQxcLg
gu1biK762GoqUA8AAOTZAQDyhUIyYD6CH/H+hm2CH1b+7x5ecf31phGWGfIY
q8pYAAEAk+JaON5FWQ3kSQEetOGCUMhmTcJIRO6SEKdBqlajNwQ=
=1srq
-----END PGP SIGNATURE-----


--------34f92f0b860adc60a7323f15c5639210b290dbdc25701ae9b2fd5483d5bfa229--


