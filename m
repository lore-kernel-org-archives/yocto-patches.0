Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D41073C97
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 10:56:04 +0000 (UTC)
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.103721.1775645757440220104
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Apr 2026 03:55:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=dt/+aSPz;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=lgnoIZd1;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.148, mailfrom: paul@pbarker.dev)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E569EC0477;
	Wed,  8 Apr 2026 06:55:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 08 Apr 2026 06:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1775645756; x=1775732156; bh=TYfIcYXqWM
	mkxJyjACvDSjuqjP5Z/k5RbtIU8zCg5jc=; b=dt/+aSPzUfV1skuQs7VAcUaTop
	yYiXUVRNnM4yr/dgGdPCq2tZCOTFiITk7o94ZNNlFfW+ltNaVwhQmpzTugal8Y4u
	LnTDZrHtc8gTD9VA/U8k5spi4Df9BzKh311lGkD8wRoE+wKgMcMp7uSMBB0S5NUu
	PVOC51oNJZr+smfB61ZB6UxS3VDwVIIsvRSGXx1pIXVl1BXTiqmfZ6r27ZthHy3R
	Ejx37phuU3qc0lJWpbhFLTY2tuXRLNE6/rmrX7O7bAgK2vYTHeLNzIHNZSdSerWF
	nriVg7rkH0jozLBkzEvPOSAwsYtptUsND10+o4vowin9PmhOBp/xr4d4SEhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775645756; x=1775732156; bh=TYfIcYXqWMmkxJyjACvDSjuqjP5Z/k5RbtI
	U8zCg5jc=; b=lgnoIZd12UkA+6xO1sLNKgJ6dv2ejDyctY0dmgV9Y/zYQw1MpZF
	83sLJ1uw9V2Edxc3dev6P75jwgGKlSVZej2av3QAROhFUlX/Q7Y4QYNJQgpVCBzj
	h/Kj2d7hkmmx+HT6is0kJ8ms+p+ox3GoRt7QNp5hv48wzCVG0m8eEjgLEzH65P/m
	C6WfLdrsA/Tz3kfkooikIiwYyzdeVax3B9ixUpWBazrkNYK31LblOovvICNoJb4j
	Qp1gtqWZ/3t9TOG2rjw5ItisjtVoE7BguGKlKmVVDVTjfi6S8UEkgDtRUmtZ5kJa
	JE80C9RyJ2UUG0NsjfpYM/cyNvlvriM/o/Q==
X-ME-Sender: <xms:PDTWaV_QuZynBJNiiP4qivQa5j8MFgqf6VPjWxtPHDDomZz0WPsIBQ>
    <xme:PDTWafuxev6F1pWDfxNT9BITovNay08-nj6CQop3caWXKGMYrwmMspO8Q5IpI9eOy
    B9YuEJ_aVRb0GXbMvq079y7-POdR7dGXH-baGwzrLO049kLou2pjoQV>
X-ME-Received: <xmr:PDTWaQpA0ofa--JfQj2Y7xoxNfoZpK1hjn0DRGnTB4Cgzxkc27wM-YOP4Ihstk7fbh9emp0ogWzHQqNGcXPwz_Ba_65nKbACUG_YyRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    eghfelieelteetiefhgfektdevffeltdevteeileeggffgudeggeffhfektddvgeenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdihohgtthhophhrohhjvggtthdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhes
    phgsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhp
    rhhojhgvtghtrdhorhhgpdhrtghpthhtoheprhhitghhrghrugdrphhurhguihgvsehlih
    hnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:PDTWaUmJIJdp7i5MsTraPTZMhMPQT8zOqtGJOyIGdahxuwANizTC1g>
    <xmx:PDTWacyHRFusEZbvvhuU6DXSuVEB1jNUj2g3uH8ct0Se6TnytaFTJw>
    <xmx:PDTWaUkF1yPQPIV5Skk2wM79mwA6LKRWto5XhfoUs7n4KlGa5Czc6w>
    <xmx:PDTWadeILXqIfkG63G3UQH9RN74oQZK3Xck768d-yjXsCTEQ7lUU-g>
    <xmx:PDTWafiMXl6p3URnX4pGfeUTalR50GmXdCylcB_dG5DUcyHoTi7q9WgQ>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 06:55:55 -0400 (EDT)
Message-ID: <ebaa03ba045a0b6174943fb95c4b920733ab3197.camel@pbarker.dev>
Subject: Re: [PATCH yocto-autobuilder-helper 0/2] Extend and fix check-layer
 job
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Wed, 08 Apr 2026 11:55:52 +0100
In-Reply-To: <20260328-checklayer-v1-0-36bb1873751b@pbarker.dev>
References: <20260328-checklayer-v1-0-36bb1873751b@pbarker.dev>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-D4o2+1vdR7V0FLabnCA7"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Apr 2026 10:56:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3663


--=-D4o2+1vdR7V0FLabnCA7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-03-28 at 10:02 +0000, Paul Barker wrote:
> Extend the check-layer job to cover openembedded-core and to test all
> supported MACHINEs. Also fix testing of meta-poky and meta-yocto-bsp.
>=20
> This series should be applied after changes to openembedded-core [1],
> [2], and meta-yocto [3], otherwise failures are expected.
>=20
> [1]: https://lore.kernel.org/openembedded-core/20260328-default-features-=
v1-0-90790864d734@pbarker.dev/T/
> [2]: https://lore.kernel.org/openembedded-core/20260328-fix-checklayer-3-=
v1-0-53da29ef5c35@pbarker.dev/T/
> [3]: https://lore.kernel.org/poky/20260328-default-features-v1-0-549331cc=
fab0@pbarker.dev/T/
>=20
> ---
> Paul Barker (2):
>       config.json: check-layer: Fix testing of core layers
>       config.json: check-layer: Test with supported machines from core la=
yers
>=20
>  config.json | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

I've re-tested these changes on the autobuilder [1] and they pass with
current master branches, so I think they're ready to merge.

[1]: https://autobuilder.yoctoproject.org/valkyrie/#/builders/27/builds/360=
6

Best regards,

--=20
Paul Barker


--=-D4o2+1vdR7V0FLabnCA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCadY0OBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bgvZAP9qCIpCJiwUeXJa0+0oiNyizSF+NHq2gtMa
d+OC6hmwTgEAoc+snwwrd9T7Hyhud4l2wR3M3RKiyOJ1L3NgDCqlzQQ=
=rSIa
-----END PGP SIGNATURE-----

--=-D4o2+1vdR7V0FLabnCA7--

