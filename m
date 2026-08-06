Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2365C5AC67
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 21:42:26 +0000 (UTC)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30684.1786052543417942442
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Aug 2026 14:42:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@on-the-web.ch header.s=protonmail2 header.b=FSo03ESO;
 spf=pass (domain: on-the-web.ch, ip: 185.70.43.23, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1786052539; x=1786311739;
	bh=7WEykqcqqkAu6zHFAAEB//0kyqRgUCQoq2xqFb7CVgQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FSo03ESOm8m9s4Gk13u/XG2Yr6Q+fUN7UmsnUbUdbbfv+frO5k9XFIjNOImxt7ORT
	 V35Eg/SrdelSWlVVSwI1Vg9q4Q8GfrazwXT5Bmqcx/g8e0ZeUATbUi0d7B13tX39Sq
	 MJV4yp6sAl54+gBU5jOOzPLjnDZyvAyZoKcNgfl8Od03dbRD6zJx5fW0DCqSJDp/ZC
	 7dqK2AbMWuOaFgq9YJijPzRYrDkja9s0Y+8DCMBaOvljHrT6NmxJoisoREc0/wYCvL
	 4lTfAF9KteFNsfUTkXt+9ZqU6dg2bnFyg188Q4FIc1/5N8X+O9BGhHG6ynDQNY05ts
	 UzWrHDm7yfIoA==
Date: Thu, 06 Aug 2026 21:42:15 +0000
To: yocto-patches@lists.yoctoproject.org
From: sputnik@on-the-web.ch
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][PATCH v2 1/3] bsp: rkbin: use SPDX LicenseRef for Rockchip proprietary firmware
Message-ID: <20260806214149.714963-2-sputnik@on-the-web.ch>
In-Reply-To: <20260805121327.3946788-1-sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 2b07fa0ea774624bee847901b62014b8d2cd28a2
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------0d44532361641af78612bd2782acfceddc35a1d02509f8cf625501e7eb0f89db"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Aug 2026 21:42:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4645

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------0d44532361641af78612bd2782acfceddc35a1d02509f8cf625501e7eb0f89db
Content-Type: text/plain; charset=UTF-8
From: sputnik@on-the-web.ch
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>,
	Martin Herren <sputnik@on-the-web.ch>,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][PATCH v2 1/3] bsp: rkbin: use SPDX LicenseRef for Rockchip proprietary firmware
Date: Thu,  6 Aug 2026 23:41:47 +0200
Message-ID: <20260806214149.714963-2-sputnik@on-the-web.ch>
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

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
AI-Generated: Z.ai:GLM-5.2 OpenCode Go
Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---
Changes in v2:
- Added Reviewed-by tag
- Added AI-Generated tag

 recipes-bsp/rkbin/rockchip-rkbin.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/roc=
kchip-rkbin.inc
index 9ddd54f..d715b44 100644
--- a/recipes-bsp/rkbin/rockchip-rkbin.inc
+++ b/recipes-bsp/rkbin/rockchip-rkbin.in
c
@@ -1,7 +1,8 @@
 SRC_URI =3D "git://github.com/rockchip-linux/rkbin;protocol=3Dhttps;bran=
ch=3Dmaster"
 SRCREV =3D "f43a462e7a1429a9d407ae52b4745033034a6cf9"
-LICENSE =3D "Proprietary"
+LICENSE =3D "LicenseRef-Rockchip-rkbin"
 LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D11e3673115959bf596feaaa6ea7ce=
9a5"
+NO_GENERIC_LICENSE[Rockchip-rkbin] =3D "LICENSE"
=20
 inherit bin_package deploy
=20

--------0d44532361641af78612bd2782acfceddc35a1d02509f8cf625501e7eb0f89db
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmp0/7YJEIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcfwOrQ92m1IxxFKb8df9TYFiEEJgeVlthQxcLg
gu1biK762GoqUA8AAOhBAQDXqvYWVehdlJA63g1ISGnlbRnAN1P7/OASvZji
SzJngwEAiBJiV7aT0xhEa9MCn4upAmWQcdF0WCmV4Twu8anrMQY=
=m9JN
-----END PGP SIGNATURE-----


--------0d44532361641af78612bd2782acfceddc35a1d02509f8cf625501e7eb0f89db--


