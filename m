Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BC9F327C0
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 08:22:57 +0000 (UTC)
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16692.1776759771669227120
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Apr 2026 01:22:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=Y8Q36qZw;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=nD1WUmms;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EE6FEC0211;
	Tue, 21 Apr 2026 04:22:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 21 Apr 2026 04:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776759770; x=1776846170; bh=W6S7az8DuY
	ujYdpH6yZRojb32SteqYAwZuefpEK0Mbg=; b=Y8Q36qZwheTnNsprmK0HesmLYw
	6fSA5L82tdTkyWHcM1d+mqeY9saLrD/dOotPa2giCrkkwYQs/laHSc0h1eSqMD3f
	z8Xzfj3zxsbaAsJW+Y7WVHdX4IuOjuFTnXXgYqBR2u/bZl7/CgylVNhMhdoRqy11
	3EAWzMB59sNVapA/qFdrhkenNpkC3PJ7+gUqoTCoZqXGG/3MY1mBq0pqa9uzt4Fu
	8YNpxIHglakUqMvmsT0M3Ou5cqn0a8YOXphXYv+Fb1UhhjQrGNa2i4TE5AH1v28K
	iazBkZF7K8lo9mB4p8FmtfoyW+g8jipQRhHh4enRb9AlvdFknYo3HnVHBDPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776759770; x=1776846170; bh=W6S7az8DuYujYdpH6yZRojb32SteqYAwZue
	fpEK0Mbg=; b=nD1WUmmshU38ANepnzsV4nzU0qmnTduUzFZzL0sdrjfLGwx5uNR
	yd/SwCSO+LTeavRq9W8fkP7ksu5fXXYGNPpNLp3VCGhXiY5K3cbHP6P/+BSjC4hu
	o3s37zSh7BOwcXFvYDiFyf7u8GEVg3rx1XzHw+v/rbhy2ZOB67uWW8IiIpR9Ey4H
	wGTVaYQsHliXuX2rDkJ/i2m7dkBfe6LGmfquDwX0KpjyVFXZ8D4UW8N6bmTIlGhV
	wePunlggUqKiCKJ6+BDGUA6U1V06fJIVck4ypXlccQub5P5L+TvbHw9hLer/WJlT
	N2oAK/WAujKqeS1BkwC9roi8R1xSxIOpKew==
X-ME-Sender: <xms:2jPnacJT3AfcN7jP51Zwhjr39QOTGH8npv01mu-Tu1qP0_r9S_LznQ>
    <xme:2jPnaSKVe5dItxmkgi_rKuBn1s6mKXVeSlvGUF62FEIWs40buYoMC9MpwifoQuF4l
    V6_pd4GwLk0vq6xkpftfoYVQPLOpLI3tz-A3IxAB4HUiwrYbBu_I4Cw>
X-ME-Received: <xmr:2jPnaaUBPLOdFYI4BpukFFVfiBIDN2lMpIF_GASTe3F8j6_hJgu0plM9jb7R7psWKrX7w5J1LNFFRbhBtq-fN36l8ShEGjKLcINYtrlwZyHF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    ekffevgeekgfetuddvtdejhfeglefffffgieevieekvefgheevjefhkeffieegleenucff
    ohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdhgihhtlhgrsgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhes
    phgsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhp
    rhhojhgvtghtrdhorhhgpdhrtghpthhtohepmhgrrhhtrgdrrhihsggtiiihnhhskhgrse
    ihghhrvghkhidrtghomh
X-ME-Proxy: <xmx:2jPnaUg6_ftO0ks_40JJ3BVEVL7j4HplvDRDnhcAkQNRpeIR3C1cMw>
    <xmx:2jPnaV_-VOGh1FgTy3afhtc72odAkO8FAeiMix3hV00z2qVjfGAtRw>
    <xmx:2jPnaeCT5czLASFx3GmsCVIh5FNxl002U8v6P74fCyx5Th_BsvV5fA>
    <xmx:2jPnaSLpr-7YSr4soTLwk6xnpAzX2D7pyidr8jIA_WG9-__l7W_R-w>
    <xmx:2jPnaWJWxFJ8JeaiHW4PkVvBrdqWWAGK1TUldn5EY-VpksEAd-eB3nda>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 04:22:49 -0400 (EDT)
Message-ID: <7139e91d403b6f917f3fe48c2e734ec00adc1801.camel@pbarker.dev>
Subject: Re: [yocto-patches] [meta-security][PATCH] README: update CI links
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Date: Tue, 21 Apr 2026 09:22:43 +0100
In-Reply-To: <20260421054133.16448-1-marta.rybczynska@ygreky.com>
References: <20260421054133.16448-1-marta.rybczynska@ygreky.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-DZqZcRUevE6sobBL1Y9C"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 08:22:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3747


--=-DZqZcRUevE6sobBL1Y9C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-04-21 at 07:41 +0200, Marta Rybczynska via
lists.yoctoproject.org wrote:
> Update CI links for meta-security
>=20
> Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
> ---
>  README.md | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/README.md b/README.md
> index dae5aad..c92d3f2 100644
> --- a/README.md
> +++ b/README.md
> @@ -1,7 +1,5 @@
> -Master-next:=20
> -[![pipeline status](https://gitlab.com/akuster/meta-security/badges/mast=
er-next/pipeline.svg)](https://gitlab.com/akuster/meta-security/-/commits/m=
aster-next)
> -
> -Master: [![pipeline status](https://gitlab.com/akuster/meta-security/bad=
ges/master/pipeline.svg)](https://gitlab.com/akuster/meta-security/-/commit=
s/master)
> +Master-next: [pipeline status](https://gitlab.com/ygreky/meta-security/-=
/pipelines)
> +Master: [pipeline status](https://gitlab.com/ygreky/meta-security/-/pipe=
lines)

Hi Marta,

Is https://gitlab.com/ygreky/meta-security public? The new links don't
work for me.

Best regards,

--=20
Paul Barker


--=-DZqZcRUevE6sobBL1Y9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaecz0xEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bmoKAP4tFDpXclJk4sH/jpEpOZ5bnFn6n3E9zI68
wV3Dq8UVWwD+OaJe335zNZ4PFUjURfP4lrgBtstIw/8aIOkF4eSNnwI=
=mZIs
-----END PGP SIGNATURE-----

--=-DZqZcRUevE6sobBL1Y9C--

