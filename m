Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32EAC5AC7A
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 21:42:26 +0000 (UTC)
Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30683.1786052536719559503
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Aug 2026 14:42:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@on-the-web.ch header.s=protonmail2 header.b=A3Z9V/29;
 spf=pass (domain: on-the-web.ch, ip: 185.70.43.98, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1786052533; x=1786311733;
	bh=ciorjZKT1SN0Q1wQWvenxzRSlXfFbwy1x3VzDAka6tc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=A3Z9V/29DJT00LKQueaHLx0GD5C+pNN5sw7C8pVnSgZ6W6jK7zkTlTvbIF8KwpdEd
	 1yB4kfF/RUlu0BRlEr8TffaNzJiKIXoqDl7Qmk1Ao9dkYIBjs8Gu/uRCjX6JcJf0Du
	 W322vvqEYseZ8HOmOPzCtLEtlkrOQfT5AnsNE1GYDgRHTgAKtSxBMOTLfH+PQNSZ6p
	 wdovR5XT6lDltBc/5oPJIONAGrjBfptIobSGC8LMNe7PV6BQ4eunWTlt/D/sYTe7sN
	 Jwxl4f01Kuh2kgTkCmRQPumOoyNhlYe5U7aLbIVKhmabR+YcSfJaO8crRbHXEToGGo
	 7NWhTsrNF7p9g==
Date: Thu, 06 Aug 2026 21:42:08 +0000
To: yocto-patches@lists.yoctoproject.org
From: sputnik@on-the-web.ch
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
Subject: [meta-rockchip][PATCH v2 0/3] rkbin: convert LICENSE to SPDX expressions
Message-ID: <20260806214149.714963-1-sputnik@on-the-web.ch>
In-Reply-To: <20260805121327.3946788-1-sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: b89f3df72289bc47c967662827928855fa13515e
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------2b8a5037c47e97520160f1f5810a68d836dd2efceeebd7b646d08787745adafd"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Aug 2026 21:42:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4644

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------2b8a5037c47e97520160f1f5810a68d836dd2efceeebd7b646d08787745adafd
Content-Type: text/plain; charset=UTF-8
From: sputnik@on-the-web.ch
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>,
	Martin Herren <sputnik@on-the-web.ch>
Subject: [meta-rockchip][PATCH v2 0/3] rkbin: convert LICENSE to SPDX expressions
Date: Thu,  6 Aug 2026 23:41:46 +0200
Message-ID: <20260806214149.714963-1-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805121327.3946788-1-sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Herren <sputnik@on-the-web.ch>

Hej,

This series fixes the legacy/CLOSED LICENSE warnings coming from the
rkbin recipes by OE-Core commit e9d424738d6f ("classes/conf/lib: Parse
LICENSE as SPDX Expression"):

  https://git.openembedded.org/openembedded-core/commit/?id=3De9d424738d6=
f8411d4e745b7d872a00e10bb14ac

Patches 1 and 2 switch the rkbin family (rockchip-rkbin.inc, used by
-ddr, -optee-os and -tf-a) and its native variant from "Proprietary" to
a recipe-specific LicenseRef-Rockchip-rkbin backed by NO_GENERIC_LICENSE,
so the SPDX manifest references the real Rockchip LICENSE rather than
the generic one-line stub.

Patch 3 switches rk3308-rkbin from "CLOSED" to
"LicenseRef-rk3308-rkbin-CLOSED" + NO_GENERIC_LICENSE[...]=3DREADME.

rk3308-rkbin pins an older rkbin revision whose tree ships no LICENSE
file, which is why it used CLOSED and only pointed to the README.

A potential cleaner fix could be to reuse the current repo's LICENSE.
The rk3308-rkbin S
RCREV dates back to 2019-10-15 while the initial
LICENSE was only added 2023-07-26, which beside a typo and a
trailing newline is identical to the one used for the other rkbins
(updated 2024-10-17).
So that's an almost 4 year gap between the used SRCREV and where the
LICENSE was introduced.
So this would probably require legal validation from Rockchip's side
whether it applies retroactively as well.
This option would require adding a static LICENSE file to the recipe.

What changed since v1:
- Added Reviewed-by tag
- Added AI-Generated tag

Cheers,

Martin

Martin Herren (3):
  bsp: rkbin: use SPDX LicenseRef for Rockchip proprietary firmware
  bsp: rkbin-native: use SPDX LicenseRef for Rockchip proprietary
    firmware
  bsp: rkbin: rk3308-rkbin: replace deprecated CLOSED license with a
    LicenseRef

 recipes-bsp/rkbin/rk3308-rkbin_git.bb          | 3 ++-
 recipes-bsp/rkbin/rockchip-rkbin-native_git.bb | 3 ++-
 recipes-bsp/rkbin/rockchip-rkbin.inc        =20
  | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)


--------2b8a5037c47e97520160f1f5810a68d836dd2efceeebd7b646d08787745adafd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmp0/68JEIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdGwiVhPqeIwstFYYl/BOo6FiEEJgeVlthQxcLg
gu1biK762GoqUA8AAJp7AQCLHqb0E8V2HtaItOb5bpg+Dett930kDwxZhI9R
ziaDOQD/WfKSg+PhGCtNHX5f7cgv3TTvyL+2qP1mik9tPMoSpQ8=
=83W6
-----END PGP SIGNATURE-----


--------2b8a5037c47e97520160f1f5810a68d836dd2efceeebd7b646d08787745adafd--


