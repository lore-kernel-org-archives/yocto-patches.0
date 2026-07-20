Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F688C44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 08:27:32 +0000 (UTC)
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4459.1784536047212697542
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jul 2026 01:27:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=Eb67zda7;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=KCXTYk7q;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.153, mailfrom: paul@pbarker.dev)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2912F1400127
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 04:27:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 20 Jul 2026 04:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784536046; x=1784622446; bh=MH1AJbjpJ1
	dGOHADR/vUv+nrSXBsvrgRkybeSJTaPZ4=; b=Eb67zda7FO3qx0UKb6s8yyPTYX
	4vCt3lNmn5xDDIO31wNF6X2ZY2J8poSygZpHjMKHpv25qU71vDoiUfu3Rus9+rIB
	TTJV1Bn105L5EDvOhs+bhTCGdk4blOopMoYtw6i1oz2ccPWVZzsRH7/B7TuotgbE
	hp9I9oK0eZO8W2Bh9D1kFIU9qpYXsMhSITl/L79lKRxcq1LwwrWGwwgQLRSvepKe
	kv0E8dKfni7/mXELwdJ0lQHlVEmunjoQ9RWfDm+rUHcn4y8r4vsK5AoLkKrc+LGo
	4XUAk+0Rp9Ta7FEwsZip4drdnYvURZZ4jv/kxitMHSjdhSYQWQsQN6yd1jug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784536046; x=1784622446; bh=MH1AJbjpJ1dGOHADR/vUv+nrSXBsvrgRkyb
	eSJTaPZ4=; b=KCXTYk7qDsH0rZ4p3GeTd2uX4hC/VEH9U/gLzZpJkYc48QSPnng
	qiEfwRGxLwXO3XM1n2o1TlwsBtL2MNIsjPiGXJ83n/XNkkbB2Dk9r03b32M116hF
	eDH6AyEz5+vC7bJHRm3KssraJn8OPXFb8k5/BCvMplohvAjiNsEceC2yFsU0Am1R
	J49JbdIIxS0AOZUFik+vziJdd4E1vTu8JrMg1Yo5F8IwyyScVeGAewgnQtH8WWEB
	ePQ97RSlZZ/21Q9B95kjACNZN/kYAlyOKisxGmx8ETrF8FgURvN69EUXUtwDdRGP
	HQUw7wnWEaBSQ/BNaKZEDDVCUyPgm6tBGGQ==
X-ME-Sender: <xms:7dtdatnJZtaUM3WSMoK39-bN7cDkDvz5roWpW7X3A_cbWJQh7NzYGQ>
    <xme:7dtdavz7yItyy389q4CxJ_w2hSzxApSHhfeMqYRnRg4J56fEgZPSPXE9YauWwPqdR
    AdHjA-J3HVbjBOysWtS-ng8w0Ef4smPMTOW64qBY1C3XYl6HA0De28>
X-ME-Received: <xmr:7dtdapQdamdyj565mtCfh-W0r1JsPaYq4-QRosm5tsWa-Rk_SdkLbGLQ3WYvXKbWk-d40M86FIreKzE2RIqykrlOSFEQGiav5UcNm_6NxCUF>
X-ME-Proxy-Cause: dmFkZTGDvw/6HS7NYz5/evmQOKZFHLG7FahSZD+tvik/Q+K237QqplSemkV52MskBfzF7S
    pFxxyK0jYTGsCK+4KFzClzK6SShXT4X+eRlUe8OViWBwTFvKcpIBTV1J2jOQdukyYCBVHh
    ybtnecE+22Dj26b5qtwlqOGWVa1HdrVwz6uyGmFW3XNttggVSC+DqZSpJ/nLSIB5NTfPLx
    UgnkdCIIf35e9OF12fFSM5ne+rS7/KXfdFsVj0h/1hIX41v6RT9OJLTO7t6F7mlf9qnW72
    ZDwa5u8TINH+V9orqWXOp1Mn2lDj3Y74mxbDrGGvx6VUw0af3Mh+atrqEjJulftmeYx8L+
    38FQTsjwIx9eyk3XGdszn6cfpe/37wiTKIxGaN9AYZOnGX3tmFgMoyJTcQBvTfqN1GGtT3
    +0JU4yWxkqJX0079qoWdjUi6JXwl3wKopcYfDrwDa3yeNO6KiPyVEGHjOiMI3bICIfkf8M
    TFJRWFlqB8kRKW/bzNp4lYMFTQKCaE37WY5tTopN3Ru8vKnoy6qtXyPpKITHt3YRScOiI7
    Rs74hnYiCv8Gr9LyKEy6TjwaYz0rE3wu2l29swQl3eTiwXbhUmFaTiiSyOIh1eY64vhOUr
    T2CCYW1v03k+cF+sz2dbqpw9ArtMuLmrGqFB6Qbv3XFwgvg11BhBMHeBBDxA
X-ME-Proxy: <xmx:7dtdaisRp2NplyuyhncyK-3F2Mi9paRv_nSQ6_gcxCZDavHjb8ieVQ>
    <xmx:7dtdarvmV0afCM0zpXvVFZJHI-jMw8omY2_2NUQ9PsGZngH7B70Gcw>
    <xmx:7dtdaowsyIwN5pGnPjY5MFchhYGcfECue0ZoPzKPSGtxSxpgjFsuRg>
    <xmx:7dtdahjJT1EyGUsnxemi3eF4UctLWvyA7pSs8NvRcDFC0luTueLqzw>
    <xmx:7ttdajEf35qsnO3ksz9ZT47W4IDbbiDMnjR5nqNczq4Adja2DZ-8JQt->
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Mon,
 20 Jul 2026 04:27:25 -0400 (EDT)
Message-ID: <f521a495ed0c8fda8918d0a4cd2be4fd5829f8ac.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH 0/2]
 tests/unit/test_ksparser_parse: parse the .wks file, fix a diskid crash
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 20 Jul 2026 09:27:22 +0100
In-Reply-To: <20260717183507.3539287-1-twoerner@gmail.com>
References: <20260717183507.3539287-1-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-6GGZUKwr+Wc6vrkyW9XO"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 08:27:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4515


--=-6GGZUKwr+Wc6vrkyW9XO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-17 at 14:35 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> This continues the standalone unit-test work, moving up from ksparser's
> argparse types to the KickStart parser that drives a whole .wks file.
> It keeps the shape the suite settled on: the source fix is its own
> standalone commit, and the green test module lands last, so the suite
> passes at every commit.
>=20
> The fix: a bootloader line with --ptable msdos and a non-integer
> --diskid builds its error message with "... % self.ptable". self is the
> KickStart instance, which has no ptable attribute, so the interpolation
> raises AttributeError before the intended KickStartError. The user gets
> an opaque traceback instead of a described error. Interpolate the
> offending value instead (matching the gpt branch just below), and fix
> the "--ptbale" typo in the same message.
>=20
> The test module adds end-to-end coverage for KickStart(): happy-path
> part/bootloader lines, degenerate files (empty, comment-only, CRLF,
> unknown directive), mutually-exclusive and invalid option combinations,
> multiple-bootloader rejection, diskid parsing for both ptables, and
> include handling. get_bitbake_var() is neutralised so the parser runs
> with no BitBake and no host tools. Backing the fix out turns the two
> msdos --diskid cases red.

Both patches LGTM.

Reviewed-by: Paul Barker <paul@pbarker.dev>

Best regards,

--=20
Paul Barker


--=-6GGZUKwr+Wc6vrkyW9XO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCal3b6hEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bkVkAQDk2oRNqinstSvrc3ioAVx9eGx+Bf1hjdZR
XDUe9QIxtQD9Fn9aQSHeCEyBYgw/t1OfGAQV5nVE95D1nTkyzh4kYQI=
=GtUS
-----END PGP SIGNATURE-----

--=-6GGZUKwr+Wc6vrkyW9XO--

