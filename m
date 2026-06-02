Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA64CD6E57
	for <webhook@archiver.kernel.org>; Tue,  2 Jun 2026 11:02:26 +0000 (UTC)
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22180.1780398138773699715
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Jun 2026 04:02:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=sOahPuhi;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=j/ldPCUk;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC51C140023B
	for <yocto-patches@lists.yoctoproject.org>; Tue,  2 Jun 2026 07:02:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 02 Jun 2026 07:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780398137; x=1780484537; bh=cAM8zmc7jc
	DDI3V2P79zo4scaGyZYwlG5FIEo6Rof8E=; b=sOahPuhiUCflK9ehkUtoHFq+qw
	z9K/KbLr9xI+foccqg7tmKUPtHwjshORYCwj6M9zVigoEjhpUIKwhGCxaDBEMM7Y
	yApUR85PvizcSEom/+ZWbwvpGVonmX9JATvW6BZERwhSzAwoPWeOSydb5KYD8CqU
	MpLM9vhrqZT48Okt7RYrhN+ejxRUL1F0UxmG2g9wm5bUvUGwFt/QwbnM601W/6vn
	aPfOYSrDnmuaWzqA7hyTBJPdlofh26DYTRvHKxLKbGXe85dgXCntuydiJYFmfO89
	kmtodUeUupN26Sdj1JqCl8Yhr6H/vMVD0a6j5AsWSao1ZI4nZZx943tKJyxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780398137; x=1780484537; bh=cAM8zmc7jcDDI3V2P79zo4scaGyZYwlG5FI
	Eo6Rof8E=; b=j/ldPCUkNn+ML2uordddOX0G568m7r6RsXnoigzsc7Qr8YlFcSd
	H2frI4I8PnkDkxt5/REgz0kzOqnQETczQa9n0JV7D2Rsl89dWqS/eW5XYx9vL0Ap
	A3H2YvQAu1sYXH6bgqkzGV45OldXcb54h/OA8YKOaiJ4OBWcfKzLnWb9oOkiKqSi
	6h8HF6lSKiP2w4BVrCAErooCsfYr9Aif9UMoThdXp/ZF6QCWjKhgTZsAMRoILXA9
	hm0Wzv8TZ6TS+ZrAQKjLzMyB1HX9HW8Tw1zMdHuoLRFGxfU6s81YWAJDygAtGFpq
	ptSMZg7BWY7sH32WJqsh3i/H4hC0AGPfnkw==
X-ME-Sender: <xms:ObgeahjpCzHDaU-QvLY7Y_IFzgfA2yOcFSvTRgTfPLaS2srMlw48Zw>
    <xme:Obgeas_jPe4OlV5V7ufG9phvrMf4NGPhugOt9IZjIof1E1he3eEhC0b_viF0411f-
    YRny5WWO0C3RR27J0Miv_y42c2Tm0luLoSwS4WRYIe5jCWUfCrjeave>
X-ME-Received: <xmr:Obgeamtk_AtVWjAcZr1y8OZdWT8o6WEBqrZvLbhHnhH9tb3qaDK2pUneUP_bPO2SSILjpeUvgEQZ_zJY4E3MDO2Xx1IP99cUcDoXtFEBuAlzZSP7d5L6YkYdaVTKM-Zt>
X-ME-Proxy-Cause: dmFkZTFicGkzKS2f8j/GK/Y6239vhW6zaD3juuZTzP1JvCCco7Rqdgo0/yypZT9Z1/lzHN
    BS42GQzmpv2HAxcmT4feMr1RhHOSUE8CSEg6IN/MHBB92rX6CNHlk6vFe8cJNrwWL3AYBs
    9Vw1GTBdl/iizZ7Xzvt9Fefn58dtOCaTCz71RecMMZexAmxgnddxH1ZGl8NQCXpkCRo8ee
    YM+sRtYR1wUnpXNe5F1A84Zn9ct9kmGVGK2Jft+SEsYxBiSzReHa1oJNBrWV7yP0X8Yh0x
    9jOaAGyTodBiakJh98RlUc+1b1WiSB3s5twSXq4iFZ1D093ld35uEDCXkz+ndgC45xc5bu
    FE1HSIvBDg3+C7Xh9YpTZHMCUUgMTF7IX31DM0NBpzdG7gQZC48F1KO09FEkdFIGafYcfq
    JBWuRBJezmdYMFBZSEk5HipQqDlF+9Aw4jQ9wC903awYaAUq2ahQkTom2y4ME/2KQin7vR
    pBRXHB623N4vMss3NYEC0BFAwtP9b6tEz9Aqn0jaj6rmZhPGGtZK9ovB3oGaJDB1H6oTU9
    StM8Acoj8CKhmyl/jEz2pAA3z9rS2gsGovdCDFKwQbZnFWjCI7jVed0WpUCtUvipDGq/eN
    QUcGRy8dQod32QvobbJZHtRrfBbcrHg6C5qKAmmAPC3Dr8I3wJ5aQXlMUvIQ
X-ME-Proxy: <xmx:ObgearZkyKEXOkC8aJVjrhI7XirjosDLgG1BFt52zjRj-nysuhFdgA>
    <xmx:ObgeaupauznlB5zCHbQi0zq45vB94CNsTjFiIk5TBgTz5B0aLU941Q>
    <xmx:Obgeao_e1mU_-vTj6YQFVLXTBsREL8mQCJdokndyn8P-X6jQv56SvA>
    <xmx:Obgeal9GRKWLv5cMGh_T9y8I_WpEVf-2C8V_kfwr-7-1I0Z3R3QbMg>
    <xmx:ObgeaiwFwT2lTW3bjYYSrxrh42WnUK0hfJwCHG8LraGOfSRkB2kvRx1n>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Tue,
 2 Jun 2026 07:02:17 -0400 (EDT)
Message-ID: <a79b6c395adcfaf933968401655642f018d53676.camel@pbarker.dev>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v2 10/10]
 config.json: add 'containers-library' build job
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Tue, 02 Jun 2026 12:02:14 +0100
In-Reply-To: <aff1838ffcfb3e4c2aa1fe455dc0f74f87effdf6.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
	 <aff1838ffcfb3e4c2aa1fe455dc0f74f87effdf6.1780354513.git.tim.orling@konsulko.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-mJGhAE6nwmEpYyk8uynG"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jun 2026 11:02:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4112


--=-mJGhAE6nwmEpYyk8uynG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 16:18 -0700, Tim Orling via lists.yoctoproject.org
wrote:
> From: Tim Orling <tim.orling@konsulko.com>
>=20
> Add 'containers-library' build job that build container images on top
> of the vcontainer-tarball SDK:
>=20
>   * original container images from the intial "container-cross-install"
>     branch of  meta-virtualization
>     - container-base
>     - app-container-curl
>   * additional images modelled after docker.io/library/*
>     - app-container-python
>     - app-container-mosquitto
>     - app-container-valkey
>     - app-container-nginx
>   * Tag containers with versions based on the recipe to which they are
>     mapped, e.g. python:3, python:3.14, python:3.14.5.

These version tags may exist in docker library/hardened images, but are
they actually appropriate for the images we create?

I would expect python:master, python:blacksail, etc tags which track our
branches.

Best regards,

--=20
Paul Barker


--=-mJGhAE6nwmEpYyk8uynG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCah64NhEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bi68AQD2iXYcME0SAy5lvook61NDGu3dhbWbmiBw
LZFAeQ1lFQD+KIMPPMNCPu1kTnSDX8OhFUFgnmJnIz//kXoF5XXT6wo=
=fQrC
-----END PGP SIGNATURE-----

--=-mJGhAE6nwmEpYyk8uynG--

