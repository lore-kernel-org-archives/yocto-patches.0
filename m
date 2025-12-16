Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF63D5E120
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 10:35:55 +0000 (UTC)
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19288.1765881352665381557
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Dec 2025 02:35:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=Ad1++/rG;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=dlCZ9+HN;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.156, mailfrom: paul@pbarker.dev)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C0FC9140024A;
	Tue, 16 Dec 2025 05:35:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 16 Dec 2025 05:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765881351; x=1765967751; bh=cMdaxqC8B3
	1023+756sBI4gqU1gAcMq7VyXsnMWQjek=; b=Ad1++/rGV1etHGfyBbd59LxNaT
	KQoRoKAcs1GxEYrOpCUmjID4EIIlPyiI/l2w+PXGUzl/aJzaGtyYvu8OoIKVn1fR
	2kwjEfz+FEYN85Kneddf4uloLzXvvz852OH8uyMtHp6Qp8mQl6zIGqL/rckrj55l
	OnpBeyXkudOxbg2xhTfpfz9wBRiUy98okvRnXKoj6aU1Yo3LAdCAUirFLe5ZaQat
	ze93HIstaUjxkBjg1MuhpbARn1CHsaq34wPsfdh/On673BkxPPIIGcVxusb5qo4D
	wgx2ZfJA8v3tNofo02ZDOtOJuvcb5Zzf6/kbQFT5QfbZK2RIEIyPm2BrCOhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765881351; x=1765967751; bh=cMdaxqC8B31023+756sBI4gqU1gAcMq7VyX
	snMWQjek=; b=dlCZ9+HN06dkznSRdgTCtXlCXjXE2If1w9y8i1yd91b+tPgAKI6
	d6hLfc0+4M3Eh2lvoI10b45BuGRLPXTr7zad1/iyg2j7MNJWAYLvbAu1x3y3N+pJ
	iUPpzc9FEUVxx1yeIEvQKRkSI+t9QynqpxLti9JStgiS26lSGYqL2ry6rml7OyHj
	bGxrosSI1NkmMQz8Lr5ybjf0mxwBWSon8NjbLHVsaH6CrWsEg7sW5tQlTjO5qcMi
	HGYjzGLU0UKF+yAtGA+GSJ99ri10xOpyzwqSTdPuhEx08g49OlUszexIoVJCju0V
	L9rc3GwDiumwycF8QJBMUI9VwipIMG+N25A==
X-ME-Sender: <xms:BzZBaY0YYsES75GUt7HhXQDgklUq3SwqWs9IRt12fGjyg0qkgJQasg>
    <xme:BzZBaTOjYGvw2eo8O3dCQwxROLd1GN3b69NgSesXzhj6eQGt16QhlWkSbz-1ZKsdh
    r8Ex93s3mHtoXSu6gJLXhvnLDmsN6wo5K52N_uDVlAxpmEW0kgjeQ>
X-ME-Received: <xmr:BzZBaY1YnKW3FVndmvHWsKxlHyKFB_jp3ssrM50PtkdzP8o5uZFnEW1CsrdVHb91QQZZL5H4RWMqXqf4WuibNP9BUEG3lTLTNbPzDnEUubtb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefleeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    ejudefvdfhheevtdduledvleejieehieevffelhefffedtgfduvdevjeekheffhfenucff
    ohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghv
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihoh
    gtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdp
    rhgtphhtthhopegrnhhujhdrmhhithhtrghlsehoshhsrdhquhgrlhgtohhmmhdrtghomh
    dprhgtphhtthhopehnihgtohhlrghsrdguvggthhgvshhnvgesohhsshdrqhhurghltgho
    mhhmrdgtohhm
X-ME-Proxy: <xmx:BzZBaaEiS0bJ_qRH7tOlxvOu8Q78KxeWWbRZyjTKCUtTlTGTJ1SqMg>
    <xmx:BzZBaV5ycGcxV5l2vGTxbnBHP9PWxdXkJ_3qZLtvSxz2r158I7y2ZQ>
    <xmx:BzZBaQs0ad0vKDj5vJiY8N87afdyKsQWZkPcUy_53HJtVOANOhZ--A>
    <xmx:BzZBaW5A8vt2TkT48cxmL9J4NDz9vCvHPsTXuUIQSuNsW2xDome2Mw>
    <xmx:BzZBaZUfLwHSyxlqpYRnnNuh91HCe-R7JlTftl7sR1TOKHg4SGo_JItX>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 05:35:50 -0500 (EST)
Message-ID: <a59d61cd0637cbc09b44cdaf2044b15ca550ad3d.camel@pbarker.dev>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] config.py: add
 meta-qcom to layers to be built
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org, Anuj Mittal
	 <anuj.mittal@oss.qualcomm.com>
Cc: nicolas.dechesne@oss.qualcomm.com
Date: Tue, 16 Dec 2025 10:35:44 +0000
In-Reply-To: <20251210024150.379272-1-anuj.mittal@oss.qualcomm.com>
References: <20251210024150.379272-1-anuj.mittal@oss.qualcomm.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ZgTKhhF4M+kUZ74n5dSM"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 10:35:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2799


--=-ZgTKhhF4M+kUZ74n5dSM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-12-10 at 08:11 +0530, Anuj Mittal via
lists.yoctoproject.org wrote:
> From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
>=20
> Add builder for Qualcomm BSP layer meta-qcom and include it in a-full.
>=20
> Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
> ---
>  config.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/config.py b/config.py
> index 2408602..07cf403 100644
> --- a/config.py
> +++ b/config.py
> @@ -8,7 +8,7 @@ baserepos =3D ["bitbake", "oecore", "meta-yocto", "yocto-=
docs", "poky"]
>  # Repositories used by each builder
>  buildertorepos =3D {
>      "a-quick": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2"],
> -    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2", "me=
ta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization"=
, "meta-clang"],
> +    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2", "me=
ta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization"=
, "meta-clang", "meta-qcom"],
>      "non-gpl3": baserepos + ["meta-gplv2"],
>      "meta-mingw": baserepos + ["meta-mingw"],
>      "meta-oe": baserepos + ["meta-openembedded"],
> @@ -18,6 +18,7 @@ buildertorepos =3D {
>      "meta-arm": baserepos + ["meta-arm"],
>      "meta-agl-core": baserepos + ["meta-agl"],
>      "meta-aws": baserepos + ["meta-aws", "meta-openembedded"],
> +    "meta-qcom": baserepos + ["meta-qcom"],
>      "meta-clang": baserepos + ["meta-clang"],
>      "buildtools-docs": baserepos + ["meta-openembedded"],
>      "qemuarm-oecore": ["oecore", "bitbake"],
> @@ -100,7 +101,7 @@ trigger_builders_wait_full =3D trigger_builders_wait_=
shared + [
>      "oe-selftest-debian", "oe-selftest-fedora",
>      "qemux86-64-ptest", "qemux86-64-ltp", "qemuarm64-ptest", "qemuarm64-=
ltp",
>      "meta-intel", "meta-arm", "meta-aws", "meta-agl-core", "meta-virt", =
"qemuarmv5",
> -    "qemuarm-tc", "qemuarm64-tc", "qemux86-tc", "qemux86-64-tc"
> +    "qemuarm-tc", "qemuarm64-tc", "qemux86-tc", "qemux86-64-tc", "meta-q=
com"
>  ]
> =20
>  trigger_builders_wait_quick_releases =3D {
> @@ -147,7 +148,8 @@ builders_others =3D [
>      "edgerouter", "edgerouter-alt",
>      "oe-selftest-ubuntu", "oe-selftest-centos", "oe-selftest-opensuse",
>      "non-gpl3",
> -    "meta-webosose"
> +    "meta-webosose",
> +    "meta-qcom"
>  ] + old_arch_full + riscv
> =20
>  subbuilders =3D list(set(trigger_builders_wait_quick + trigger_builders_=
wait_full + trigger_builders_wait_perf + builders_others))
> @@ -283,6 +285,7 @@ builder_tags =3D {
>      "meta-aws": ["layers"],
>      "meta-agl-core": ["layers"],
>      "meta-virt": ["layers"],
> +    "meta-qcom": ["layers"],
> =20
>      "musl-qemux86": ["musl"],
>      "musl-qemux86-64": ["musl"],

Hi Anuj,

This patch was discussed in the TSC call yesterday. We need to make this
change in two stages:

1) Add meta-qcom as an individually triggered build.

2) Once this is confirmed working, add it to the a-full build set with a
   follow up patch.

Could you re-send just the changes for (1)? So, no changes to
buildertorepos["a-full"] or trigger_builders_wait_full yet.

Best regards,

--=20
Paul Barker


--=-ZgTKhhF4M+kUZ74n5dSM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaUE2ABEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0briDAQCmoMp7kxvIxdW9oJLtlEZRx4+BAruDfPbc
Fadfg120QgD/Z2GgXYOMtBFvsrZuRJwNbGOdLZ9NV8SaB1dh5OTjUA4=
=TY4+
-----END PGP SIGNATURE-----

--=-ZgTKhhF4M+kUZ74n5dSM--

