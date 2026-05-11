Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78512CD37B9
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 09:00:35 +0000 (UTC)
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45779.1778490033017250517
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 May 2026 02:00:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=L652DmTW;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=eO84v8JB;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.155, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 449147A00F9;
	Mon, 11 May 2026 05:00:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 11 May 2026 05:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1778490032; x=1778576432; bh=vdPNU6+cEQ
	ryonMYOVWpdZP3Y09folnd6ivL1XbCOOI=; b=L652DmTWkFBSS1rHg7iHn60FWz
	ByaKD5NzttCgLjbgrxKOMNEZ6A74py64x4BiU7tVRQ7/iW4PtjqCUdaX8iZe1wLm
	LUsaSoWJci97PetYfSOizsUjV/6t5iAy0U3v88SuNNwtekleQyK9SH3KllMyr+mJ
	tRrLUDUu7BLDPZkH1Z2obrGLnO2hk7ytohcBPKL90zZw3wt8dskMjFU2QAGxS+G7
	UdN4q6PiUws1w3CK+EWWwLZpw+P6tmh1qT0v5NLkAS1znXfFA3YRJBJlYCZZ18Be
	oDTJPAwbaiqCBWBbWQ08NKlufaYLlNm0y/lOtLZGL1Q9WKglyXXVJj4DngMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778490032; x=1778576432; bh=vdPNU6+cEQryonMYOVWpdZP3Y09folnd6iv
	L1XbCOOI=; b=eO84v8JB0NURysKwUrTjGUbYKzdXzbodQRFKmeYrOYXEOaUXfPv
	FKIPVQIC085gFaNBPW+jqxejfDo1wqsEJY3W6QqkC1ZdInNwdzjmCRbX2lUUEn5t
	3ctrSW6/AKnjqpUOefCIsVxVofKAwD5qUVEhJgZMvXDNf0BZiNVRKEQcTwEIYiwC
	9TfqRL70poogaGoZSNuyHA/9/D/BuWHV5FK10hlnoY2uQraq8cySCzUarZBU5zbu
	A25QAL5jhuCmbUG+4k8XPUspwfGXeEgFXuRmCE2orqWEl9u8jOPJFI9CADebbSMT
	NFo5DwZCTdkme3xojbxf/GHJzmZ4kTvgW8w==
X-ME-Sender: <xms:r5oBau7D41aWcWTfKOu5AYA5O1u3LXTfO0ZiowjBFfkQZKP3NzhJZg>
    <xme:r5oBavrDNI3X2id-dtL2hu1TCOkbDJ57wMxKR2nMMy1ZDBy9sgxiRnUn8vUZ2C3Oz
    T03GN1kBJ_Ih7eyS_LeXTnoCj5dapF9vni-_t0pMQe36b6wwo5CHxA>
X-ME-Received: <xmr:r5oBagiJY2hb9Kv7joAZxgUgNRuvStdt7YKodB_7KDhpTbMzquOabnHw2sbHNnhh4SikP3t90wyl5Hicx1eiczXpAwOmJGmLJI6LBq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekheegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:r5oBapIJcC385bXLqEpNDbZoEUFPSRHpt1DKhXa0oOdyhX23b763eA>
    <xmx:r5oBagBJuN0TewmHTg3kROPAok6EUnpfZYjxW-AohvTfOut0jDahuQ>
    <xmx:r5oBapjVO6jTY1r0U1ZEMgroWt66639bBGNp7trqQX42ZYxeoeeSdA>
    <xmx:r5oBaomPaonAfpk5-rXJS24rzS0kUiq6ugju00Nplwdsffu631YtVA>
    <xmx:sJoBaopJOxOvh1mX0Kg3hJgbzuIko_3pjQGfBrmydDPxRi-Q9Juq0Jms>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 05:00:31 -0400 (EDT)
Message-ID: <a12dbd29263557679eeeb5dbaabeac9266fcabe3.camel@pbarker.dev>
Subject: Re: [yocto-autobuilder-helper][PATCH 11/11] config.json:
 containers-library: add mosquitto and valkey demos
From: Paul Barker <paul@pbarker.dev>
To: tim.orling@konsulko.com, yocto-patches@lists.yoctoproject.org, 
	yocto@lists.yoctoproject.org
Date: Mon, 11 May 2026 10:00:28 +0100
In-Reply-To: <601c281165450b2be14de46bb9601e82229ca5f6.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
	 <601c281165450b2be14de46bb9601e82229ca5f6.1778202125.git.tim.orling@konsulko.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-lXwOW81+IiPGPfQ2nbk2"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 09:00:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3967


--=-lXwOW81+IiPGPfQ2nbk2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-05-07 at 18:25 -0700, tim.orling@konsulko.com wrote:
> From: Tim Orling <tim.orling@konsulko.com>
>=20
> Extend containers-library with two additional demo images sourced
> from meta-yocto-containers-demo:
>=20
>   * app-container-mosquitto: the Eclipse Mosquitto MQTT broker.
>   * app-container-valkey: Valkey (Redis-compatible) key/value datastore.
>=20
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---
>  config.json | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/config.json b/config.json
> index 7cdf91a..a9a2e9c 100644
> --- a/config.json
> +++ b/config.json
> @@ -1950,6 +1950,18 @@
>                  "BBTARGETS" : "app-container-python",
>                  "CONTAINER_IMAGES" : {"app-container-python": "python"},
>                  "CONTAINER_VERSION_RECIPE" : "python3"
> +            },
> +            "step2" : {
> +                "shortname" : "Build 'mosquitto' container",
> +                "BBTARGETS" : "app-container-mosquitto",
> +                "CONTAINER_IMAGES" : {"app-container-mosquitto": "mosqui=
tto"},
> +                "CONTAINER_VERSION_RECIPE" : "mosquitto"
> +            },
> +            "step3" : {
> +                "shortname" : "Build 'valkey' container",
> +                "BBTARGETS" : "app-container-valkey",
> +                "CONTAINER_IMAGES" : {"app-container-valkey": "valkey"},
> +                "CONTAINER_VERSION_RECIPE" : "valkey"

This makes me wonder: can we build multiple app container images with
one bitbake command? If so, can we combine these into one step?

Best regards,

--=20
Paul Barker


--=-lXwOW81+IiPGPfQ2nbk2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCagGarBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bnDjAQDz2CI7f2PAueFy/ReDezcMxK2JAjIXxAly
go8n1y5JPQEAmGfLTv2WJ0z8AbkygimbmyJHIHCYNk/8H1aUFZFbSgc=
=gTyw
-----END PGP SIGNATURE-----

--=-lXwOW81+IiPGPfQ2nbk2--

