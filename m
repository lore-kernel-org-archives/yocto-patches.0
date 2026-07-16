Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B216C44501
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 07:38:14 +0000 (UTC)
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7540.1784187485385868127
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Jul 2026 00:38:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=VyiupFIU;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=l/X61ehp;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F5C514000B7
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 03:38:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 16 Jul 2026 03:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784187484; x=1784273884; bh=5Qv+Qf+XyR
	jKcnG0GlIVtXmT8zWmsRpVxv6QJTTbTPg=; b=VyiupFIUtfbD597Ax9FN4ekFm0
	iUQOcZQKE5ItSMk7EuKG36rjMdoh8bJpZclWtSp/PIcvC9iMXYpZ1MPtQ8e/nTzK
	EDX2/hTgQGJahtoPXZI/49+nn/OaY5OQ7+DRgPCebwwsPVg0d+GZtR8IG3Opua2O
	SWOBUcAmGXWiXX7RDANp+jexYOMRdYiUToEYO9+vPHyWP7Dw92cYH5DS52JBXGmd
	56TiBZNGUGs5GYDY4F2QYjS+jKCFYaUsrrcind4cyzRQLB1Z4G7geDX7RffEjrzf
	QSUS2HADS9jgWDBhwiJ1ptIh2L+AQfpYNZSGeO9OKDt39xA3EqqlTNikaB9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784187484; x=1784273884; bh=5Qv+Qf+XyRjKcnG0GlIVtXmT8zWmsRpVxv6
	QJTTbTPg=; b=l/X61ehpXf81UtCDoizcNQxN9UfMiaiN1PRw/AYgYuki+t/ot8t
	jmcN5M0kJc8aVUHftctWZam12aWTqJ8KLNX7I3bGjYWwbACZyijA4J1YVthWqHt9
	KXpx1u6XZg1+/jle1U/F58JW7h0HWxOq/9iZCJB5xDJWY8r8NhyBcW1Fdy+2cqJw
	9gpext+MPb0q74dJ5+dDbPgY8GfgsIlpz6f05kIDdm9cutGpGeg+/CbfyP6itQ5x
	vmuXcixm8lmBtBgw6sNFV4VxiKVYurKAZM8Ungc5myeuvpJyt/hCesDmuu0d+eb5
	8/bFcTu7VvYVydSslrq3D+rdYjJdCwgUZQg==
X-ME-Sender: <xms:XIpYaow5Qe--g8yGXA_TP7xCRclzHOk1DObJ_9eBro3UfmuoblUeDw>
    <xme:XIpYajNdKZRfZ5FMnnx9mk7GsoT8FQ6ye8xrvkFyOO0CMtxGdjLI2vLn_0YT0P7QL
    cNWrHat-CliCGl6mL0-IrxmhtyJfuou4nDNMh28yJdprhAE5GqCtqU>
X-ME-Received: <xmr:XIpYav_rfuBA6KVpvXaEnLnUvTXa6THSFB4dz1vAFed-xWz123gI29lbWAjvoJYPyQrQaTGaFG1ZiJ2XZdBKRIzMLL46-b4SlHZRNgDqwG5d>
X-ME-Proxy-Cause: dmFkZTECKhgSrQOw7Q8RLVmAPLtemvlVoWGRp4UpjmXdXV8d/yXaXGtiZDHvBDLNKBfedM
    XutzD5A5iy7PJH9cetq2gRDtdxLKgZ9V+SaqJKugAJYCpys9Tv9BzGogjrIUm4zYeTvbU5
    Qe0GLkBF5jEp5wMzhJp3U3bD0jx/GqjmM8hB4vtN/qJnKKKRE3qS+PwPfWrZKlJXkPK47l
    T7/m3UEgWk7H3mzbHKFmFDgC6Xs1R3D76dxsX5tyKv/cFQ7zzf9dW8t51rfp4f1YBpvgSf
    EuYJWuvquA6FfiCxoWa1Mt26b7pi5/AU4wbkkymPzxJ3Ie46BH4jaZueTv+m0Z3bb9FSoa
    HXkkO6ptRtCC8GdaIBMSn5kUxuH9qjaEfMEsk+/4n82Q2QWgDO0JZgDPiwb0ZuizNxbnHn
    Uhi18qZWjiFKe94nO38Q8fIJ6M8P2Z4qlj4V2J2/GMnq9pIIfdMnqgx1C3poF8IRSBzWZv
    UfcQorHEg4VyILGU+GmUuJq1mMQqNROO1wAraQbWxGp/5FidT83J/b0ojZJTc04iCacW8j
    K/bypbMLVsRPsGWRcVBZU4XVVW5domghAiqCC45pXZJraP3oyESlbcmBXKKFYayGCpfV0L
    7MqCvXcin070Cu0vRC23Od4Qs2LQv3DwVGNMC/rgc1vTZjT6yAIaSqI1eIGA
X-ME-Proxy: <xmx:XIpYaroWm7eWkaM8FdMDm860XXaFAm2kMdzx9PsCPNmruMHmSZH4zg>
    <xmx:XIpYap6-EGQEPkb_wY5bpTyd1T0H2MA5TPzXZ6PAkPgUgOTdaDsbtQ>
    <xmx:XIpYajMKtiUNDdKOdlh1ymq6zDAl5Iof1GiODB2-UK2ymAArgRCSMQ>
    <xmx:XIpYajMzr0sLXycPW4hzD3sYccOgx14-IWGaTBMOGQptm42ZtTPOhg>
    <xmx:XIpYanBsPraRq8ZQdWRrYyEzlW-WVB7k-LyMI14gbP44aKwTzfOnAlzh>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Thu,
 16 Jul 2026 03:38:03 -0400 (EDT)
Message-ID: <49870a1432520f1e91fbffa168cad8d876ed4bd4.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH 0/5] ksparser: four argparse-type
 fixes plus unit coverage
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Thu, 16 Jul 2026 08:37:57 +0100
In-Reply-To: <20260715223226.3371498-1-twoerner@gmail.com>
References: <20260715223226.3371498-1-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-VYn1ZFYwCeJyVhpsMT78"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 07:38:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4493


--=-VYn1ZFYwCeJyVhpsMT78
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-15 at 18:32 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> This series continues the standalone unit-test work, this time over the
> custom argparse types in ksparser.py: sizetype(), overheadtype(), and
> systemidtype(). It keeps the shape the suite settled on: each source fix
> is its own standalone commit, and the green test module lands last, so
> the suite passes at every commit.
>=20
> Four fixes come first, each independent of the others:
>=20
>   - sizetype() accepted a leading minus, so "-1M" returned -1024 and
>     "-5" returned -5120. A negative size is meaningless for every
>     consumer (--size, --fixed-size, --offset, --extra-*-space, the empty
>     source plugin's size=3D/bs=3D); reject it.
>   - overheadtype()'s below-1.0 error path did "...message..." % arg with
>     no %-placeholder, so every out-of-range value crashed with an opaque
>     TypeError instead of the intended ArgumentTypeError. Add the missing
>     placeholder.
>   - overheadtype() let float('nan') and float('inf') slip past the < 1.0
>     guard, which then multiplied the rootfs size by nan/inf downstream.
>     Reject any non-finite factor up front.
>   - systemidtype() converted with int(arg, 16), which also accepts a
>     bare "82" (hex 130) and a signed "+0x82", contradicting its
>     documented "hex between 0x1 and 0xFF" contract. Require an explicit
>     0x prefix.
>=20
> The final commit adds tests/unit/test_ksparser_types.py, covering the
> three types' accepted forms, boundaries, and rejected inputs, and
> locking in the four fixes. Backing any fix out turns the matching test
> red. The suite is green at every commit and ruff-clean.
>=20
> Trevor Woerner (5):
>   ksparser: reject negative sizes in sizetype()
>   ksparser: fix crash on out-of-range overhead factor
>   ksparser: reject non-finite overhead factors
>   ksparser: require an explicit 0x prefix for --system-id
>   tests/unit/test_ksparser_types: cover ksparser's argparse types
>=20
>  src/wic/ksparser.py               |  15 +-
>  tests/unit/test_ksparser_types.py | 226 ++++++++++++++++++++++++++++++
>  2 files changed, 236 insertions(+), 5 deletions(-)
>  create mode 100644 tests/unit/test_ksparser_types.py

Hi Trevor,

This all looks good to me!

Reviewed-by: Paul Barker <paul@pbarker.dev>

Best regards,

--=20
Paul Barker


--=-VYn1ZFYwCeJyVhpsMT78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaliKVREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bukyAQDI8nX9+EyezMJSHbUcUsF4V3iABIKsf8oE
mzkc/0hCbAEA4XeDbWaOji97Y0nBVRIgNCXipZJ+1hxLaM3AKzie5wQ=
=93Th
-----END PGP SIGNATURE-----

--=-VYn1ZFYwCeJyVhpsMT78--

