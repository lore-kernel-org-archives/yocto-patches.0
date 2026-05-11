Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401C7CD37AC
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 08:48:25 +0000 (UTC)
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46024.1778489295365439408
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 May 2026 01:48:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=BWP2Cw5F;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=CVl8W5yz;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.155, mailfrom: paul@pbarker.dev)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F2027A00C1;
	Mon, 11 May 2026 04:48:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 11 May 2026 04:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1778489294; x=1778575694; bh=LSHLq1LHR2
	ht67Q4xfckSOmNorQ6v+9xLHrl0eleejk=; b=BWP2Cw5FJLrI2bLCVoz09g9G2o
	wk3h4c2bnmhsKq8sUEfyiBg67guLUGsD0UesVi7TnDdHV6bEdSX28kmRF3cChM77
	ebwBnGQD7iseDXQc4oIMcixVAjsfizdiqeeJfkxqYZtRT5A3vBZFSTTG8zbjjqnq
	oYIopinWP5OHLq/obk+3s8exvzQ75+/jrKMhVitF4b8h5ZS5mtB5fTjRZNxrRIOG
	dh0m7sdN+pQEr5LW9gzIALeXYQHo1uthphJOFAo2SEp9wfJCdDjQ5Kk84PNF7JFp
	ydjBp/YLoJ/z1vHfLF6lkSLP8ohNkUsFrYl+oGYDWNK40swRvXZLuNjrbIFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778489294; x=1778575694; bh=LSHLq1LHR2ht67Q4xfckSOmNorQ6v+9xLHr
	l0eleejk=; b=CVl8W5yzkwKAWY4UBtCs615U8OVtwdYLNHldTAKt/0fbyIFUkgk
	fFXnBM5dgyTTtwwKvWW3XF9akQVFSNB8u7N9Be338efn1Z5axGONyGsfW9aOe3d4
	d/fK1Dwl/PeqGtlcbGiMcVf8ojvJUSh16A0er3hzbTuiBWlOeg8jHUOssRKBBk/7
	1HoIcdKUM4ytQQQ283sasW/H6c1oYyNvKjlovBRn9uoFtg4jjpRAlHG29SVZDRmo
	jb3lUvW4TDkw9Gj8uflHzmbkYdhMjcm8EuSPniuB4SW/zQOiCX0XJ3O51/ZiL8yV
	JxHAjAI3f+DlrMNJd2cYCXlIk0WHVsGkzpA==
X-ME-Sender: <xms:zpcBaqNlqo02SWAqZ5zwZKMxhQrIsvjmqhA44fekNaIvNRycf4p3Lw>
    <xme:zpcBags87F3Sqrnn1mJJ4KdVTan8kHZqtXPu1MTcRUZEau_Riyv4vUdv3okP8sKtF
    eNq_m3_ljIR8BmAhVvuvuVgNd7gRf88erx2wkZmqbK7sUu6xHM3BgI>
X-ME-Received: <xmr:zpcBakXuDIpFcYoANL56VY_i2DpMFBuqAYHKhdiNhwzwIHCgkaU0_W1j1d6LFjsfkASx5idbP80ZavplvZsSmvGeYsw-wkViJ2oQLxUGb5oN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggesghdtreertd
    erjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhepfeeileehudffvdeljedvgfetieeugfetteekfe
    dtgeeggfevtddutddvheegfeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtth
    hopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtihhmrdhorhhlihhnghes
    khhonhhsuhhlkhhordgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslh
    hishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohephihotghtohes
    lhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-ME-Proxy: <xmx:zpcBaovywO1MGxOqG0_AwrKWd_ID1dgSf9WOMpw3kFUlV6-jCQQ73g>
    <xmx:zpcBagUxByXQObcFPaLQYB5pCr2La_kQvXHnMvOtKtBKyUYW_WQBkA>
    <xmx:zpcBarkd5SOVYdLXTd3ts3dUOc0Ai-ICBs0ultjpbesEFBQEL18oUA>
    <xmx:zpcBapbrt2MwVpusDHUyyBekv5T8Hm8zDuc7h0JJqQSNZjHuI_cHRw>
    <xmx:zpcBapu6j4h1eWVBl3-5ZBdJAZ3zd4EbDKMqZbm_irQO_AFkKHbu80CB>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 04:48:13 -0400 (EDT)
Message-ID: <5356ea1df2a3b640943fed7fd3a358402b9ab644.camel@pbarker.dev>
Subject: Re: [yocto-autobuilder-helper][PATCH 06/11] config.json: add
 vcontainer-tarball build target
From: Paul Barker <paul@pbarker.dev>
To: tim.orling@konsulko.com, yocto-patches@lists.yoctoproject.org, 
	yocto@lists.yoctoproject.org
Date: Mon, 11 May 2026 09:48:10 +0100
In-Reply-To: <f76cfa3158594d6abef88eaea589b9e135158e9f.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
	 <f76cfa3158594d6abef88eaea589b9e135158e9f.1778202125.git.tim.orling@konsulko.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-n3Fq6JmbwTwfcgPQoi+E"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 08:48:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3964


--=-n3Fq6JmbwTwfcgPQoi+E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-05-07 at 18:25 -0700, tim.orling@konsulko.com wrote:
> From: Tim Orling <tim.orling@konsulko.com>
>=20
> Add the vcontainer-tarball build target which produces the
> meta-virtualization SDK used by downstream container build/test
> jobs. Modelled after the buildtools-tarball target.
>=20
> The target uses EXTRACMDS to reset BBMULTICONFIG for the worker
> shell, places the extravars in the per-step config, and includes
> a publish-artefacts step so the resulting SDK tarball is staged
> for reuse by container-tests and other consumers.
>=20
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---
>  config.json | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/config.json b/config.json
> index ab0ad7c..9e6898d 100644
> --- a/config.json
> +++ b/config.json
> @@ -1869,6 +1869,32 @@
>          },
>          "toaster" : {
>              "EXTRACMDS" : ["${SCRIPTSDIR}/run-toaster-tests ${HELPERBUIL=
DDIR} ${HELPERBUILDDIR}/../layers/bitbake"]
> +        },
> +        "vcontainer-tarball": {
> +            "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-virtual=
ization"],
> +            "ADDLAYER" : [
> +                "${BUILDDIR}/../meta-openembedded/meta-oe",
> +                "${BUILDDIR}/../meta-openembedded/meta-python",
> +                "${BUILDDIR}/../meta-openembedded/meta-networking",
> +                "${BUILDDIR}/../meta-openembedded/meta-filesystems",
> +                "${BUILDDIR}/../meta-virtualization"
> +            ],
> +            "step1" : {
> +                "shortname" : "Build vcontainer-tarballs",
> +                "BBTARGETS" : "vcontainer-tarball",
> +                "extravars" : [
> +                    "DISTRO_FEATURES:append =3D ' virtualization vcontai=
ner'",
> +                    "BBMULTICONFIG =3D 'vruntime-aarch64 vruntime-x86-64=
'",
> +                    "INIT_MANAGER =3D 'systemd'"
> +                ],
> +                "EXTRACMDS" : ["sed -i '/vruntime-aarch64 vruntime-x86-6=
4/d' ${HELPERBUILDDIR}/conf/auto.conf"]

What does this sed command achieve? EXTRACMDS run after building
BBTARGETS.

Best regards,

--=20
Paul Barker


--=-n3Fq6JmbwTwfcgPQoi+E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCagGXyhEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bpYYAQDpJ9raayzlLeTIwdWlxEcrQz231OlCpUAI
PmUGp8ii5AEA1BgTLARXYafWeu1VqwoJGAN+YOK9RIfWFFlCVmpT6QE=
=RcpM
-----END PGP SIGNATURE-----

--=-n3Fq6JmbwTwfcgPQoi+E--

