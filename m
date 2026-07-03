Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7C4C43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:44:18 +0000 (UTC)
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89795.1783075456236029260
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jul 2026 03:44:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=PuoJWRRg;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=NIQPQoET;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.147, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E66F1D0001A;
	Fri,  3 Jul 2026 06:44:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 06:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783075455; x=1783161855; bh=wkdxo9MG5x
	DA50Zg2JzupSBPoqVbcYW2uCsTlxtkDJU=; b=PuoJWRRgvioVBMXkZBDj1pvTZm
	RZBe2VtpxjO9x106UAGPIEiakP97MpL4NGQ9cpRllzTylpTInmx846f+CtSfazwk
	TbR0kmOp0UQXNNTzZzBTQH8KqrExgVxPcZaa8Y+US/BvXbNd1FZxbzPwnFa7WXLL
	Az2DC+Yi/cpG24blX52RUR8BwqzEzEbJju6WEhkHwzwrngxvQ1f/3Z6OjN376Cdy
	BdDQSPF/FPqwYk+CZeIBZsdbLyASyii/0SA28f3EXaruEgVh/BHyoJWgVJ20AzMw
	S/SnWHzOZ/7jF7J7YE6PXRx+wh0jwrr+ogm5VToa3pqE9P25xoRVDJ/yaMuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783075455; x=1783161855; bh=wkdxo9MG5xDA50Zg2JzupSBPoqVbcYW2uCs
	TlxtkDJU=; b=NIQPQoET7HFfGN3HKZnL4aBjqDXlZnHG8Y2WIzXo1wOaWdNdeNw
	EwODpmmcMeUPzwk2J+j3OlFxhskfBYWqY/GB0ZQNpOi6VbipqhkpeYc/DHVQcmTk
	4i7x9TsiNIRSgPi7Ldb5H0ytGci1yNgB14J7K3xkuYoLr83Zhg2TOtAP+3kzEfN9
	Uk2EG7C96dd/w92grzptMXN22kAwvL6cTP/rMo8O0GuzXtnMMN6Hp7/U1wieILJS
	KLg41uQQDtCoRmLIcVuSoEfAj/IaAPEhvkUZchctiBFu53aLhx09aKbT09vr2JAE
	5/ra7VNKq6p+K1BFaKztLZG/3HGoE1Cz9dw==
X-ME-Sender: <xms:fpJHavtYpqmspmKVUX3h2JyycBBYJF6yuTQk8e6em5pkbMSg49N-oA>
    <xme:fpJHan5c-xI5ZTOfhBfqEAhVf8Q82rnQvwves_szpQ3oghWnoqF0A8KvHANkQianR
    Yl37U-EaLYl3ChCWa69J5J-ES2zzMvKaZX0bUN2sn8MRjsp98if-A>
X-ME-Received: <xmr:fpJHagKexabSv39f2-PwrGKG08OOAECYQ1NcRXW2mx2v3jV_yqGYVhw5cGyb8_knRv5av7U7ZE9A0Eg6O6QLbSgHco4zr_mibJRQ9i0xu44r>
X-ME-Proxy-Cause: dmFkZTGfy1VuNxYz73oD30EXpvDqvontWx9IC+Rm8IcalxEEOSHXH43wk09v3AQ34s7I1t
    QbCNRiQycgTqt5HGtv0eJjq1g6OqQEK9/UQYm4dtwWR6Mu9uT0Hcxl2RKjFY1RX8M7QLla
    NIDTmnwlQfYqkuJoGapnRCPJauUn4kw7zNkaMd55S1jAymI3y/WJf9T6JOe7gc5mYZg4EF
    4t2Wp0eUtuHB6e34tKX+iOVUhTWcDJ5+a6d6S4f8xPmNWahL7BJsZFhooncbEuTXf/UpfN
    ddUor+/J/48k/ifEnHsUsYtvYyurMFdD8+swSAQP6+mRR/b139Y1uzCpO8eYk82vq0FEZl
    nmL5WL+//93EUz63xU/m6yvxAzdubsEy5VoYsLnZOzkBZ1rvc8qlKoqu5dl4veKJL4D6JM
    ecR+cjR1QJYRWX7LOqCPqVWEu5/0pQsPkqt/vSe7YcYl7CUzNgKU88v22Q9yeEax1U/OTJ
    AC2VSgAidYM5xLTo2PtyhE09ui8ATyEsEbungNdv2GOlD+o1IS69bwzFvnsHcWn/VHEPtn
    yXbIB8UYZ9VZdsWMQwcrEoW0UQog+RWfgqUCPx9K/DvHpNQRj83zbEGIgitWKtnf0W8OXq
    Rpou1RBDVyJh3IUh2Fr1Tl5vjQldrfTauxPbRwlXmU3Be8rZLLVtDWpFoAIQ
X-ME-Proxy: <xmx:fpJHan6WvNzL1w2t2A7z4zsvGfDyf_ADzuiWiD6KYRdh2X-nKL3iUg>
    <xmx:fpJHajzDCta5wKFKoogQxRmiBnVulB7I_el0aJJ_n8GHxZbyO4Nzlw>
    <xmx:fpJHaraJ3tuzRV58hfXpS9XUY0jBUnBN2BOHsrylgH0UCe9OIQuKZQ>
    <xmx:fpJHalQwFcMcDnIgBI5vUE7GuVqFi9nilRAUa8cIjKrv1iomGy5zgA>
    <xmx:f5JHalu8hoaexygxRiVIXg4varnZn1uOXfL2Z5IAmd9gLLHyRf6alb-z>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 06:44:14 -0400 (EDT)
Message-ID: <2a3a5f89dd6ff36f5d6fa1b5b53200ac5fe372ec.camel@pbarker.dev>
Subject: Re: [yocto-patches] [pseudo][PATCH 14/23] test/test-openat2-func.c:
 Remove unusuaed saved_errno
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Date: Fri, 03 Jul 2026 11:44:12 +0100
In-Reply-To: <1783039578-31531-15-git-send-email-mark.hatle@kernel.crashing.org>
References: 
	<1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
	 <1783039578-31531-15-git-send-email-mark.hatle@kernel.crashing.org>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-U49u5CdNTUIZnWkLIDMf"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 10:44:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4391


--=-U49u5CdNTUIZnWkLIDMf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-07-02 at 19:46 -0500, Mark Hatle wrote:
> Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>

Typo in commit summary: unusuaed.

Best regards,

--=20
Paul Barker


--=-U49u5CdNTUIZnWkLIDMf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCakeSfBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bjSJAQDZlfp0PzVdIXzjK5RPHILkwjLkNowad5XG
kGfcXyRSBQEAyiz0KmBm4/VG/QBvrMDERJFX4dpOTXYamTDCazcgaAc=
=L3Ml
-----END PGP SIGNATURE-----

--=-U49u5CdNTUIZnWkLIDMf--

