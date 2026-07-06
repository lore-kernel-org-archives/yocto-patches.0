Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C84AC43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 08:18:13 +0000 (UTC)
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.145549.1783325884683423357
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 01:18:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=nTGnZOlh;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=fqOWH4Bs;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B8E07A0113
	for <yocto-patches@lists.yoctoproject.org>; Mon,  6 Jul 2026 04:18:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 04:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783325884; x=1783412284; bh=eVb3NBIO8E
	bcDq2/KCOk7zfXDUJbkDdJyZR++0YGetU=; b=nTGnZOlhFxOgH3xZFza1pcO5Hc
	AyNCVO0Uzh+Qmu1Sy0t1T0Ed2JT0gDxo4BBk/Bb231W1MIGFKbUeSXxgj2l7FM/E
	0qKAmnbj+KjFm5uaK8CW1WtB88425/6CxrZSc6AQejoJSEWWnuPEtz9hkvTeSmF0
	Nyspj/4O6CoyPeS8TKctNnd9yRujndcNKAU2yEYPERJ89NpOhamEn+inRLQx2vEc
	x7kxKGbUk6z2zQHPlQ3Uxq6hErv12Aiw6P7XKYRwRmlGl1b+qk36UmxzV9qJcNsa
	51o6qQa5Zk5H5uRoMyl8RJ6mPThJAHegEEVMCoQiH5r65CJPtEjaZ+Qp3D3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783325884; x=1783412284; bh=eVb3NBIO8EbcDq2/KCOk7zfXDUJbkDdJyZR
	++0YGetU=; b=fqOWH4BskG5+w5mkoIYSvZz61yaOyRzbVALTn3dqtwZADx0I2QN
	nAfafoMP0YLCJLbplRM4IIb5ZGM0QVHsH6GbngllJd4ChqdRoeOQ91B0NYD5MBXQ
	E37NjnjUukSlSw73adn3/z/Cp3rZfvS5rbNSnvibENKCa4vhYkHwShO91aAxPmN2
	4jLdIQCEkPvXC4axHxr/UQMC25HLbk75BQtfrkKb8Wr/j3mXn6YB9h4Msz9c76O6
	RYLRXXTsHdyCHrMomG5K3i46Vjd4dPW1FAqkVydEytkHxyRkyUOm4VFNapxalDsO
	w4qj039emoFTogWQZp9nSAn2FspTULJ8kgA==
X-ME-Sender: <xms:vGRLajTNJdd-sbtv2X08obLxB5tKWUA5HFTb7g0Ei_2s-Y3S3Esjiw>
    <xme:vGRLarsrBXyuuzg5AQBqyB527DMWXs0vXo8BA1X8_PtpHuqUpvGTsBp3HKvd75O7u
    upacSfPhL9fhM9XNJmgkcbsjlFjgg2LhxDLZ-Jf9F16kHpeAJm6Umja>
X-ME-Received: <xmr:vGRLaucLBGpOVv4sTshx25Ip2BtbQOSb_XBwcThjwb0jYlf51OQaepy_t1wH_wO4FsFwWGdHIr4xMJf3We-Vdfm_IzYjso6AxZug99-KAcB1>
X-ME-Proxy-Cause: dmFkZTEIndQ1jc4epZAX651TVrmSJZHF905WctdYmFbloEbNGGrq0wc7H8dYy4K5t92Skz
    b923ul6ImzJpE//yjzj2OERO+KX+g+jM6wP76ZOo1rOtm96/oct97rB0wjHb5NVyZjJUnM
    Cg05nMkox8zeUu/D/2klGbWuCGrZa4Ap0KVaihAdRjrPfMAjrjDE0aNb8rtzaHuigB7NtR
    s6mqdKXIgXYJBOq7acXPYecS1pCZ5kiq11TwW7RhDPK2i5dj5fSW9X0x29gWoUmM06bXyo
    B6Ae8d9IqlY5g1aWiQVhlClvHFbuEqY/y2tYiFAauSpZ6PxhgVQhsWRD3SQOg+bvM5c+c6
    2WBnYCYLqe7EEcstvzYbzIrhGXKuQISBihufswZLSt9sToWfEfVoyNf+Ccmqkov07/E4tR
    FPP8AcGGHIvZE9eoxquSMd3KRKgpx5D6wGohvUF2PjjrxOnPN3f0wzSfm1INtN3RoDtGMz
    bD+jM6wST3ssJt2gTCmbWh8cA7d9m2n5ygoDfG2HocaBvwb6xlrbd4CBRY26cYZdiqY2vI
    mdFcKznMW12rs0kEe3le4b7yNytYS3SR9uKcCHEBMSlkT6DlKOYjXi4W9hFytKC+qhOiup
    /rfkNWWpxsyAv6FLQi/fxZURfpUdD16DTLB/DkrOVUwH2DMIsdeAjnfMoklA
X-ME-Proxy: <xmx:vGRLaoIc1Hn27ZQ77ITV5U0cRfGYiwxIO-55A5BJG0iCSoAShmWjyw>
    <xmx:vGRLasbk6RUy36y2lD_TxuzunpZf7zarS5pQjkl217wJ4Dq-S5-fVQ>
    <xmx:vGRLajs5U9RWD7AzyckSZU4xBKRyxRE2UhG6u-hVhlP3O2krAi0xOQ>
    <xmx:vGRLaptpPSh1k5gaRYqbAfBPY0ewy9neJm5tVOKMUh0j72vdw0Vccw>
    <xmx:vGRLargoCJX4lNBjIKVWWNOjPt18PxLhegWIFB4FcnkuTYEzE31nmWxh>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Mon,
 6 Jul 2026 04:18:03 -0400 (EDT)
Message-ID: <f6308243d1f6726ac0e03375224f06e90f293d5c.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v3 01/10] tests: add the standalone
 test-suite skeleton
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 06 Jul 2026 09:18:00 +0100
In-Reply-To: <20260701074030.1090807-2-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
	 <20260701074030.1090807-2-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-/bF8jlqUtcSVxvQ24kVN"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 08:18:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4421


--=-/bF8jlqUtcSVxvQ24kVN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 03:40 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> wic currently has no test mechanism of its own; it relies on the
> oe-selftest from oe-core for all its testing, which means a full
> bitbake build is needed to exercise even pure-Python logic. This
> commit lays the groundwork for a small standalone suite that runs
> from a plain checkout with nothing but pytest, so that logic can be
> pinned down and kept stable as the code evolves.
>=20
> This commit adds the skeleton only; it does not add any tests.
>=20
> What this adds:
>=20
>   - pyproject.toml: a "tests" optional-dependency group (pytest only)
>     so that "pip install -e .[tests]" pulls in what the suite needs,
>     plus a [tool.pytest.ini_options] section. The pytest options keep
>     a test's scratch directory only when that test fails, so repeated
>     runs do not accumulate leftover files.
>=20
>   - tests/unit/ and tests/docs/: the directories that hold the
>     in-process unit suites and the suite documentation. Git cannot
>     track an empty directory, so a placeholder .gitkeep is committed
>     in each to create it. The .gitkeep files have no content and are
>     removed once real files land in those directories.
>=20
>   - .gitignore: ignore the .pytest_cache/ directory that pytest
>     writes at the top of the checkout.
>=20
>   - README.md: a Testing section pointing at the suite and at
>     tests/docs/, and a tests/* entry in the project layout list.
>=20
> AI-Generated: codex/claude-opus 4.7 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Reviewed-by: Paul Barker <paul@pbarker.dev>

Best regards,

--=20
Paul Barker


--=-/bF8jlqUtcSVxvQ24kVN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaktkuBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0buyNAQDQwr+GfesBgRKjQIOepTFHzcyKaCbiZzzr
myPmLt+6+QEAwRaVv7LY9pIitB1zxntSD/ZUTBNtAdpPeg6Xrn+IIQE=
=LMgC
-----END PGP SIGNATURE-----

--=-/bF8jlqUtcSVxvQ24kVN--

