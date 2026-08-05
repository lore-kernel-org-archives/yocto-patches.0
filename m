Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DB8C55174
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 12:14:01 +0000 (UTC)
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38880.1785932029166085432
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Aug 2026 05:13:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@on-the-web.ch header.s=protonmail2 header.b=jLRMLNy8;
 spf=pass (domain: on-the-web.ch, ip: 79.135.106.27, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1785932026; x=1786191226;
	bh=mM41DWHM+788Ju+FwvYF+E/G8gFd+/gjqPfHuF/d93M=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jLRMLNy83yPYe9vp/qED9UX4I9FNZc3p9ByBI+eCsDBpTjaFZ649W+p3v4p0JRO5N
	 z8benm/f8MwaCSp5CAjn1f3aIBsmagnrsmKgnXY5hyfMDdfINU4sYdtG9PLTMDAj2I
	 NcQvVgrOE84kZdeaSKm0BBCQy5xtnb1b+c4GvmO7zhhnDKzGteMCF2OtC3q5gfkrHN
	 fc/x29gVhdR01Ccc5uZdS4eQ2Lycxq8I4aRhJS0Ckgqn3aueJV2aXoRLZT2l5p7uLu
	 bh9NlsdtpeVWTHLE1SoK/9IntVANaBejpfIohYbiY72fH6gb9X47SBIkChzOtvhC5t
	 4dRgJJJzyqhbA==
Date: Wed, 05 Aug 2026 12:13:39 +0000
To: yocto-patches@lists.yoctoproject.org
From: sputnik@on-the-web.ch
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
Subject: [meta-rockchip][PATCH 0/3] rkbin: convert LICENSE to SPDX expressions
Message-ID: <20260805121327.3946788-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 094b208fd5f24662321d6f717913c5cea1363074
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------76fe4b33da3334a33bc0b478ad5dc9710c7d458c0c7a71b7760f03128acd87bc"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 12:14:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4631

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------76fe4b33da3334a33bc0b478ad5dc9710c7d458c0c7a71b7760f03128acd87bc
Content-Type: text/plain; charset=UTF-8
From: sputnik@on-the-web.ch
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>,
	Martin Herren <sputnik@on-the-web.ch>
Subject: [meta-rockchip][PATCH 0/3] rkbin: convert LICENSE to SPDX expressions
Date: Wed,  5 Aug 2026 14:13:24 +0200
Message-ID: <20260805121327.3946788-1-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Herren <sputnik@on-the-web.ch>

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
The rk3308-rkbin SRCREV da
tes back to 2019-10-15 while the initial
LICENSE was only added 2023-07-26, which beside a typo and a
trailing newline is identical to the one used for the other rkbins
(updated 2024-10-17).
So that's an almost 4 year gap between the used SRCREV and where the
LICENSE was introduced.
So this would probably require legal validation from Rochchip's side
whether it applies retroactively as well.
This option would require adding a static LICENSE file to the recipe.

Martin Herren (3):
  bsp: rkbin: use SPDX LicenseRef for Rockchip proprietary firmware
  bsp: rkbin-native: use SPDX LicenseRef for Rockchip proprietary
    firmware
  bsp: rkbin: rk3308-rkbin: replace deprecated CLOSED license with a
    LicenseRef

 recipes-bsp/rkbin/rk3308-rkbin_git.bb          | 3 ++-
 recipes-bsp/rkbin/rockchip-rkbin-native_git.bb | 3 ++-
 recipes-bsp/rkbin/rockchip-rkbin.inc           | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)


--------76fe4b33da3334a33bc0b478ad5dc9710c7d458c0c7a71b7760f03128acd87bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmpzKPIJEIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcme8iq46wHmhNHH+NddSxrNkFiEEJgeVlthQxcLg
gu1biK762GoqUA8AAGlXAQCH+VW2YPWGBipLLvZwBG2Y+CmihbeRXMG5r8TS
qQ8GKgD/R6AVtks9aGOXF1HS8S2THYmU7rhZcChoqahMezRkcAU=
=ekI6
-----END PGP SIGNATURE-----


--------76fe4b33da3334a33bc0b478ad5dc9710c7d458c0c7a71b7760f03128acd87bc--


