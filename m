Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF38C43602
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 08:17:43 +0000 (UTC)
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.146503.1783325858874284111
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 01:17:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=Jw8+h2IF;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=V10M2WjG;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F06417A0060
	for <yocto-patches@lists.yoctoproject.org>; Mon,  6 Jul 2026 04:17:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 04:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783325857; x=1783412257; bh=Ghe99QYa3n
	E8UNKeRi9GmlGdN5Lpp4BpdR2soDBC1aQ=; b=Jw8+h2IF46sAH3+VP+DLxEGiJl
	3p3tKCUFopFi+Z0WCWiDGhZ6LnEl1MTx8rciBLiS5mTKqOEgo3jxHvAqlxNgG6jZ
	llj+66056XEjCBTC+b+9mLypEVesFm+5n5PlDuTu1RV1DnEkILzk4H8ek8pC5Rm4
	ng3W3MlLmUmx3zfhvQHHTf8QRPCYHY1JcOnjpHKcfc9TslPzlffyATwN/0Jkn9Ck
	mmtISGshJpB+jsKezUgsmjpsT8ys4TelonkZf5iyrVYJUDjy8rEfXqN39TyyI7pv
	G3IKj93ji6ii9cLoAPWB9SksaXCM/SnwNrj8KvN8V5yPWZWXYpmF+H0wxKjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783325857; x=1783412257; bh=Ghe99QYa3nE8UNKeRi9GmlGdN5Lpp4BpdR2
	soDBC1aQ=; b=V10M2WjGKvNs/aVqQfVG364uTJ1HS03uexC5qkqeZdElD8HTtF8
	AOpZhtxhanLxdAi7tSaUbMGAI7N96fU8MeW4zc35ZFbJDp0y2fvZLFEX4WOg9UXy
	ZLLoYcMx/Pt0L+HFcrk/jOOrZnfL2qo0Vocrd6qRbxdlMtHATRJqeDpRmmYFBnmB
	udVQ4oCnDpvdkZkDQrcVIJ4AM6uRMk9hlwUTQj4HPlMfpZo2hzfRVX9ft6QFHuR9
	tBeNztZn5jNWOagoQJkzrSBrlDQ0gl/r6j4xN06nqHWPR+mfa8pG2yQruuEjfGAN
	eahlmofMpP+nJpSWj2ptrv7AC5PSsyvtLOg==
X-ME-Sender: <xms:oWRLarHaqfw3XAzQcPibEWHqLeeB87hg2e5WF2JjWyrNSb6pm9A3kA>
    <xme:oWRLavQ3me5rh2CnKjMPqXu-DOip_ikehWAa6wh7MTCxh1mvSO8xCDVqafq5A1sez
    m8Ne63d9v5GPRBVF7zvU2Ll0Gq5r-SsPdIX1-jQGSGVKQqFdPiXtf8>
X-ME-Received: <xmr:oWRLaix2lOj8XtP6_oJQFXBaBcRgCi5Sm8Jd0Pn8vne5iqHduo5syJw_dwFyeu8U9tkX7EyHcHFBkfWXU5S281XOSBN60gAXiPKhpPH_DiJX>
X-ME-Proxy-Cause: dmFkZTEIndQ1jc4epZAX651TVrmSJZHF905WctdYmFbloEbNGGrq0wc7H8dYy4K5t92Skz
    b923ul6ImzJpE//yjzj2OERO+KX+g+jM6wP76ZOo1rOtm96/oct97rB0wjHb5NVyZjJUnM
    Cg05nMkox8zeUu/D/2klGbWuCGrZa4Ap0KVaihAdRjrPfMAjrjDE0aNb8rtzaHuigB7NtR
    s6mqdKXIgXYJBOq7acXPYecS1pCZ5kiq11TwW7RhDPK2i5dj5fSW9X0x29gWoUmM06bXyo
    B6Ae8d9IqlY5g1aWiQVhlClvHFbuEqY/y2tYiFAauSpZ6PxhgVQhsWRD3SQOg+bvM5c+Xz
    U9SPaLi/oMlhT4ogGeE6zmSTpxSrR1xXxDdfnpShvTNZ+a+2PwC6ab8C3GzxObw5MXvofa
    /D8CpXwhai18/7lP69EcYFuPTJ9nVqiwrSiwf3BII3CVVdDAbq2kTGCDQa6/4mZxeVcP01
    BvvYoOeEQDa0us7xdZhbz0+gz+OydiDkuPUnuPgq8nQ9kfafKaJkCR2RPvMy//bmw8Nees
    2ltPhifS0cMpl/3EN6ruOToNgaoskaNyWUUAEpyRhtdDSF+4ieRbPsOkO882IAWyNS0r7R
    WPSGlB6e95kZwFfa4W/a7iopXXW4sPtQfj5G6X8ucrxvRzvrLWPhN2NlRsEw
X-ME-Proxy: <xmx:oWRLauNZZ-qjM5TyJuBQ4ydahYKQ7Lwxeqv8jAUtiu-4l-cY4ulalA>
    <xmx:oWRLahMtLAFa3QsctYwgXQyaYF9uopAUhp04apTTXwXkzVcE6QonpA>
    <xmx:oWRLagQwffnIuLfHmimzO8nsDg9SuWPluKwMdkjyENk1DDbz35awTw>
    <xmx:oWRLajATIH4SbjH3NHAodrAzQNG_xWdAZTsokGBYM1FVDcCtjOG-AQ>
    <xmx:oWRLajNbzVRxIMoOtCD7oiAWgQeY1QND0dyLtOFGnaOLlBzfL5oZZUrI>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Mon,
 6 Jul 2026 04:17:37 -0400 (EDT)
Message-ID: <8d16f51f15daa021b245bb903eb7a0c01eb70f16.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v3 02/10] tests: add a session
 banner via conftest.py
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 06 Jul 2026 09:17:31 +0100
In-Reply-To: <20260701074030.1090807-3-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
	 <20260701074030.1090807-3-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Vh60DL/ELQLLPqlTqlcp"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 08:17:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4420


--=-Vh60DL/ELQLLPqlTqlcp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 03:40 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> When a test run starts it is useful to see, at a glance, exactly what
> is being tested: which host the run is on, which Python and pytest are
> in use, and -- most importantly -- which wic the suite imported and
> what version it reports. Without that, a passing or failing run is
> hard to attribute, especially when more than one wic checkout or
> virtualenv is in play.
>=20
> pytest looks for a file named conftest.py and, among other things,
> calls its pytest_report_header() hook to print extra lines in the
> session header before collection begins. This commit adds that file
> with a single hook that prints a short banner:
>=20
>   - the host node name, operating system, and machine type;
>   - the running Python version and the pytest version;
>   - the version wic reports and the filesystem path the wic module was
>     imported from.
>=20
> The wic lookup is defensive: if wic cannot be imported (for example
> the test extras were not installed, or the suite is being run outside
> the checkout) the banner says so rather than aborting the run, so the
> failure is visible in the header instead of as an opaque collection
> error.
>=20
> The file name conftest.py is mandatory; pytest discovers it by name,
> so it cannot be called anything else.
>=20
> AI-Generated: codex/claude-opus 4.7 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Claude is over-enthusiastic about writing explanations as usual - we
don't need to explain how conftest.py works. We don't need to explain an
obvious try/except around an import that may fail.

Othewise though, this looks good.

Reviewed-by: Paul Barker <paul@pbarker.dev>

Best regards,

--=20
Paul Barker


--=-Vh60DL/ELQLLPqlTqlcp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaktkmxEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0btkAAQCx0fTBVvvXS36AWkC1vYmz4tMFoQJnv2jn
poFuEfuVpAD+L0PC23zGzBkBfs1rGpwrZ8p5HW5Xz6hprx/STk9IrAs=
=GO2j
-----END PGP SIGNATURE-----

--=-Vh60DL/ELQLLPqlTqlcp--

