Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387BFC55174
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 12:14:41 +0000 (UTC)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38892.1785932074462579689
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Aug 2026 05:14:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@on-the-web.ch header.s=protonmail2 header.b=fS1Z+BGT;
 spf=pass (domain: on-the-web.ch, ip: 185.70.43.23, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1785932072; x=1786191272;
	bh=sHSIfk2xMfVCZHcbY7KUBPNFqDccHbsINSRyQWp1IPE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fS1Z+BGTafEa/NYktwNrNcv1VmyZQaKOgrULp5HN4lWOtpSbmCQ8JZQyl6+rAgluo
	 1rnTVsdjQZ17rEKOCeZjwDZmTyOhQSDS/Ikd/7EA+/N4MR7nDB8zsmT4vTP73jmnPk
	 Has84/DbPoCwJV4BAUT5m8VXrfWDX5aNhyB73p0OUPJevIZd6YzTVZEPcBWclN6mrr
	 RA/ZN2lKsph8lPn4TkYB/TpQ6zA5sqwVGexIj87gQmN8eQ3Kj9ONJsCCrzPVSL1q54
	 mfJW/5ux7q1r4Ngmg7hasETK4yKQOeq6TskLdYolwd5drfqd3Gb3qqXapIR8tMOgiH
	 vHGfuHJl3v7Ug==
Date: Wed, 05 Aug 2026 12:14:28 +0000
To: yocto-patches@lists.yoctoproject.org
From: sputnik@on-the-web.ch
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
Subject: [meta-rockchip][PATCH 3/3] bsp: rkbin: rk3308-rkbin: replace deprecated CLOSED license with a LicenseRef
Message-ID: <20260805121327.3946788-4-sputnik@on-the-web.ch>
In-Reply-To: <20260805121327.3946788-1-sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 12a65d639269b6c8c484a03545a837d3858434e7
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------6942ef86e8d4131bb23f2482d766f4e110e588708e942be901b1594e42209dbf"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 12:14:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4634

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------6942ef86e8d4131bb23f2482d766f4e110e588708e942be901b1594e42209dbf
Content-Type: text/plain; charset=UTF-8
From: sputnik@on-the-web.ch
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>,
	Martin Herren <sputnik@on-the-web.ch>
Subject: [meta-rockchip][PATCH 3/3] bsp: rkbin: rk3308-rkbin: replace deprecated CLOSED license with a LicenseRef
Date: Wed,  5 Aug 2026 14:13:27 +0200
Message-ID: <20260805121327.3946788-4-sputnik@on-the-web.ch>
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

Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---
 recipes-bsp/rkbin/rk3308-rkbin_git.bb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/rkbin/rk3308-rkbin_git.bb b/recipes-bsp/rkbin/rk=
3308-rkbin_git.bb
index 7307e66..2ee173c 100644
--- a/recipes-bsp/rkbin/rk3308-rkbin_git.bb
+++ b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
@@ -1,6 +1,7 @@
 DESCRIPTION =3D "Rockchip Firmware and Tool Binaries"
-LICENSE =3D "CLOSED"
+LICENSE =3D "LicenseRef-rk3308-rkbin-CLOSED"
 LIC_FILES_CHKSUM:rk3308 =3D "file://README;md5=3D39cc9df955478b8df2
6158d489fdcc95"
+NO_GENERIC_LICENSE[rk3308-rkbin-CLOSED] =3D "README"
=20
 SRC_URI =3D "git://github.com/rockchip-linux/rkbin;protocol=3Dhttps;bran=
ch=3Dmaster"
 SRCREV =3D "e65b97b511f1349156702db40694454c141d8fe2"

--------6942ef86e8d4131bb23f2482d766f4e110e588708e942be901b1594e42209dbf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmpzKSQJEIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdBaZXWt96HcP5+NLnoloNkFiEEJgeVlthQxcLg
gu1biK762GoqUA8AAD6eAP9wxELG/JYBoOB9hQioRWvkcSk5J+p9r2T6U4Rw
C9qZ8AEA8HNUzjRP3IhSU6ExHsOpOabfMB0gW0YyL+Non7qAHQg=
=kmEF
-----END PGP SIGNATURE-----


--------6942ef86e8d4131bb23f2482d766f4e110e588708e942be901b1594e42209dbf--


