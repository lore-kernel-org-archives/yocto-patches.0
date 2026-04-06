Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68845EF4EC8
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 08:49:22 +0000 (UTC)
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51182.1775465354099530489
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Apr 2026 01:49:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=kFBnY0Sd;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=iPMSfaUh;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.153, mailfrom: paul@pbarker.dev)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3892C7A01A6;
	Mon,  6 Apr 2026 04:49:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 06 Apr 2026 04:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1775465353; x=1775551753; bh=dPF4ZomUma
	+Tv+ccVxxFuguJNnSLd1h3GH4b8oRPagU=; b=kFBnY0SdzC4NSNvsIxPp8nT59u
	6XKXywq06m/RCkIc0CgkmJbSLLoq3zYb+2+JdNQEcba/P4B5g9wPdPISKSeVQLGQ
	m42V5ik8s+IPo1C0eZ0pWkF+jFalCiqpZBVWd0m/LTRu+FyCPBbuohixuTB405YD
	gtX1xc7hltgRLaxmgXDKVsq+7LUVDf9O1Hm1/nIKvchPHdAsUpbQDHR98cx0OatZ
	JzJxwX8jwZw0V3+zRL+tJz1IOFwx7N9dZEOAIglawAhVtyszWpitPmgOWqp4l6pG
	/HtSAu5W8qSXvt8MluXonosuQoX4UCLq8/77YZ1ldBAKlCz5mQTl57+cKzcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775465353; x=1775551753; bh=dPF4ZomUma+Tv+ccVxxFuguJNnSLd1h3GH4
	b8oRPagU=; b=iPMSfaUhRbA2ypx3NQaPy/Q6CbIPgdxcDDt9L/KcMaFUh4whVFo
	Mw+EWiZbeHPZTMbfOC0A5UifGPSWfZ/9PmHBGo56/mOLYh17tJtMn+HycWbOqkNC
	+xHiA41177EwG2Z9Q3OlyMfxCXt2xR35Cik18zLEj77C+N6YcwUKYQ5CMqmJmLxU
	C9Z5L1Yu9TOylZt5Eeto1gIhNbbpcoYIV7p3eXq3SRSjPC/letyGscq5G0jjcbWJ
	BakwskCpnscYcEDj/E06ghEK36jNQj4i5vwQq1ttAetOW3pI+ULKwvMrDg6uODNB
	F2pA1qw0j4q9vXyKj7IIj0LJmg2dZAhdAKA==
X-ME-Sender: <xms:iHPTaQoY-7S3q8xpT5KfmrtIs_6ro88ok0qdKkpNbymZzLCfKNQwGg>
    <xme:iHPTadr46N4UHubswch0zJ5y3_yFe444Zn0SS83WEDNHZwTTImSCT6tuZ7CuLdNbc
    zXOm5DblAVyvP4frxtWMq9vYhFcUfjb7d_Xk8hXlcgiFcEHaSTSw_c>
X-ME-Received: <xmr:iHPTaaPepxvm8XohLC3HuodFj424FpqWjkLPZESXGrB5XEg4GK1PVTOadMg3zrqtgzHr1zK_Gk45WOZcxHKgnO5BkKKqzZHSTxrldfJqsWGa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddujedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    fhgeeuteekgfektdffueetleeuueeifeefvefhhfeuveegtdfgudeffeevgedvffenucff
    ohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdhkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhes
    phgsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhp
    rhhojhgvtghtrdhorhhgpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsoh
    hothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegs
    ohhothhlihhnrdgtohhmpdhrtghpthhtohephihorghnnhdrtghonhhgrghlsehsmhhilh
    gvrdhfrh
X-ME-Proxy: <xmx:iHPTaWxL5Aku9s16Lye2S7_fu5P8ddXlyVdPG-yGNvjJLt5MO6225w>
    <xmx:iHPTabtayC7b9lj1IJ4VOg4ld5e6oAVBwSVosUeABRwFQC8E4-SuTQ>
    <xmx:iHPTaX7xzAmqNn6XATrnxfsJMF8DUs_k56bBNXJhldkCvuJXqHlpZw>
    <xmx:iHPTaSQaTbn9jVn_l5QI23Oh_6eglFihsMFeIoDdu0YhB0GSxXRRMA>
    <xmx:iXPTaSH8j0GILUgLcFp0Bl-dz9AAqUrBlEkQD3U49YY5ZMBXFws4vQgU>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 04:49:12 -0400 (EDT)
Message-ID: <054abea2ac9beedac71d4142a14f0bdf8fccec21.camel@pbarker.dev>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 scripts/yocto-supported-distros: fix an incorrect regular expression for
 stream
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org, Antonin Godard
	 <antonin.godard@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Yoann Congal
	 <yoann.congal@smile.fr>
Date: Mon, 06 Apr 2026 09:49:08 +0100
In-Reply-To: <20260326-ysd-fix-centos-regexp-v1-1-e41c6cbe1a18@bootlin.com>
References: <20260326-ysd-fix-centos-regexp-v1-1-e41c6cbe1a18@bootlin.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-udMRow7AZV3kAVK5WNBu"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Apr 2026 08:49:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3644


--=-udMRow7AZV3kAVK5WNBu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-03-26 at 17:22 +0100, Antonin Godard via
lists.yoctoproject.org wrote:
> The lsb string for CentOS Stream is actually centosstream-*, not
> centos-*. It was thus not detecting centosstream entries in
> SANITY_TESTED_DISTROS.
>=20
> This was preventing the script from outputting the docs-formatted CentOS
> strings.
>=20
> Reported-by: Yoann Congal <yoann.congal@smile.fr>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>  scripts/yocto-supported-distros | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-di=
stros
> index 11b05b7..f1dac04 100755
> --- a/scripts/yocto-supported-distros
> +++ b/scripts/yocto-supported-distros
> @@ -83,7 +83,7 @@ INPUT_REGEXES =3D {
>      },
>      "centosstream": {
>          "ab": re.compile(r"^stream(\d+)"),
> -        "lsb": re.compile(r"^stream-(\d+)"),
> +        "lsb": re.compile(r"^centosstream-(\d+)"),

Hi Antonin,

Where do you see centosstream-* reported?

On the stream9-vk-1 autobuilder worker and on a local centos stream 9
instance I see "centos-9":

    $ ( source /etc/os-release && echo $ID-$VERSION_ID )
    centos-9

We currently have "centosstream-9" listed as a supported distro, but if
I build on stream9-vk-1 I see:

    WARNING: Host distribution "centos-9" has not been validated with
    this version of the build system; you may possibly experience
    unexpected failures. It is recommended that you use a tested
    distribution.

So, I sent a patch for meta-yocto [1]. We should try to resolve which
one is correct.

[1]: https://lore.kernel.org/poky/20260403-centos-9-v1-1-e5324bd74ea3@pbark=
er.dev/T/

Best regards,

--=20
Paul Barker


--=-udMRow7AZV3kAVK5WNBu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCadNzhBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bjjrAP40Y9fBraTiQAc+Lhgoe8ul/kg9Zn/lqqRs
oEYy5CWleQD+JK9zX3rFadlw/e9FRYJjbEx4Va/c+2MFBSnICVxaswc=
=HroL
-----END PGP SIGNATURE-----

--=-udMRow7AZV3kAVK5WNBu--

