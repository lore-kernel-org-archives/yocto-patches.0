Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E10C44508
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 19:51:27 +0000 (UTC)
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2634.1784145080459548225
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 12:51:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=Z+IuObfW;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=aFgCTbWH;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.153, mailfrom: paul@pbarker.dev)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67BB77A00F6;
	Wed, 15 Jul 2026 15:51:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 15 Jul 2026 15:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1784145079; x=1784231479; bh=Ghbg2Bli2A
	WTBcZnJWkRmehUBwSS4qsKbNuZqDFvRcg=; b=Z+IuObfW8+jZaDzS90KATFl80a
	GmqpFCZYmq01/DrqcPfurqzDQZzm5F+25KnmVd+NAAYJUS8c/OBw0j9toXhz7N7K
	Wn0InT0NfdAmHvN4j3rTFNcfkf9S5MPamFo2Ixmehlwk3oJUpFBDCsemEXA1vvir
	3IeAT1v1h9MPOFgCSOzxnRDrRUxnErFB4Vi7ylcXngvT5Olo26Dm7qcqUM/LJjGd
	2Bcw4P1Lm+wa64m8i7fgWTi5lNPU5BGRlN0ArgyPhYI40jrq230cjfeEXlfM8YQE
	soyNXPYOl6v6T2OsEBDvO49YesGl1qXdrobFyHDNMpBP7oWOFK5SVymsho9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784145079; x=1784231479; bh=Ghbg2Bli2AWTBcZnJWkRmehUBwSS4qsKbNu
	ZqDFvRcg=; b=aFgCTbWH7H05/BdYUa9lwio94MgfEh/34EvyJuwxc5MioqOrEtZ
	RaJNozBNy2ETeNB9STtK7/k7Kr20drEEGaBStiqo2qtdhwr+4CQJLPj1MXyT9rii
	bLljQxyhoNR5bRlkv6lgknxbEfpdKszULeV2sXmibZZRWNfw2qNb+GPr7jkNI7XH
	s+yoZyOz4elqhm5C4jh9mgwGT4mOfWpZKPTYYFQ96MCJ/qlUrHJ96gsWh9D6Nz+3
	/SHRgTH5XC4B1knOwiAA4ZNV758FEE4bvLK/W0c9VeIxcDeFgtv5eSBO2mk5BzTY
	+l7P0PQi+Wtqc7W+fk9XJVWqDX2RJsyfVxw==
X-ME-Sender: <xms:tuRXajmOpJajMeYBwc60A1DTWswo-Loef-xj2bFPmfigHEU07lc_Uw>
    <xme:tuRXaqgF1X2K-vERIc-23lXYbAksuIO0DGiTDaZlFj4GQYP75BJIjNEtvIY7GOU24
    -6VS03Rg85pYgb5xIxEUmfhu2D3FOmG4_EpOi61sEz7NuROQcWQ2R4>
X-ME-Received: <xmr:tuRXajezayYDRYJQ44_4wS9YBjB_0F1jDlFpjD9ChHLu_PR4aQJ6t8FSnrUMtZ6P9qHyX9Nmrp3NV4efJ43VK1vl1dFDnNb5kQ7ZeKEyu2jh>
X-ME-Proxy-Cause: dmFkZTEkg3kK7C43jwe1xbQebO+v/i8jWau9LyoSD9gjqr42zeTErCD0alrMmCQIdEKCXF
    acvFbChA9YYTxmekxwOm8DFjyRGWej37VfzB9wTcog/gO1lKz79Kn2nsMKlI2BxFYCcZ7b
    grBNiylMkKVFoc0yRpWjKIC6H09yJSnmElkd2beMdPtfBQRBhZMCvGs40H7VA9Ym0CI990
    1llP8lr9uRqdCbvPVG6JYKWxG6UwkmQYewWN1R55k4ZdrCsrPvB0FA1Wv+XHV8yzrp/mly
    qPc/AVLYflpe120zIdFkOlujLqhY3TUKjVTcGPkzyEtR/pPjOpWOt6wxiEb6lkLyuqnSpl
    07E/XZVe6vWNNAvwLBimw+r7cEmaQSz+p7631/VjATxz8u1l5ItFF1UjOZOXPYmF9YOUPA
    LsbEGWn3O9FVJ4J2qcLj+chX3GTqtQgf0NyLSnAx5SyuAdGlaN+PgCAjEPWm68FrQ3Iglj
    Suk4pwc2X/4+ySrFD1th+8BG2WH5U1DGpgZdrNziclsobwKhZuo4G1z3pQ/aRpZf9/fqbw
    Rfc1tvd1ayNnVmUv5r0AGbP/qS3ndIPvoGDppW9ulWAsUzjxqFUnfNOr/PPIfSNi/jyg5w
    narQyAzuwEHyZ9cuPRQoKUg3hJw45sDFtHRFuoq5w5l2ZMOumm4F59HLiWdA
X-ME-Proxy: <xmx:tuRXaigogOuAudXs9u0quvJTZCUxonVNwuTAdAVPuL30FruO7UfvCg>
    <xmx:tuRXajzY-oRWZSC1pACYmquOHWh_3OD-xDcqe-fLkxuMjF_YG27JXg>
    <xmx:tuRXamMYlOvrIzK12PGdZ0Y4LU6cLMUAke9w78I-Iywvu3CtqWx0gw>
    <xmx:tuRXasXKQ7-tTA5p6xgmrpDU1wBrHsOH4Ynn0HfgWWGAmtGNzEFEwQ>
    <xmx:t-RXamIQopOK_IwMv7-E8mhniEEhz6Cr7zPVpvafunqkt3kvvQjQVjZd>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 15:51:17 -0400 (EDT)
Message-ID: <141bd1af085daf5d68bd44413196957f7522cecc.camel@pbarker.dev>
Subject: Re: [yocto-patches] [pseudo] [PATCH 1/2] ports/linux/guts:
 Implement close_range() instead of returning ENOSYS
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Mark Hatle
 <mark.hatle@amd.com>, Randy MacLeod <randy.macleod@windriver.com>, Vincent
 Haupert <mail@vincent-haupert.de>, Babanpreet Singh
 <bbnpreetsingh@gmail.com>
Date: Wed, 15 Jul 2026 20:51:11 +0100
In-Reply-To: <20260715054142.7-2-bbnpreetsingh@gmail.com>
References: <20260715054142.7-1-bbnpreetsingh@gmail.com>
	 <20260715054142.7-2-bbnpreetsingh@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-6Ztm3h3x6JeA4NngAbEJ"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 19:51:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4482


--=-6Ztm3h3x6JeA4NngAbEJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-15 at 05:41 +0000, Baban via lists.yoctoproject.org
wrote:
> close_range() has been wrapped since 35433e6 ("ports/linux/guts: Add
> close_range wrapper for glibc 2.34"), but the wrapper only sets ENOSYS,
> on the grounds that callers have to handle that anyway. That was true
> when it was written. It no longer is: systemd's close_all_fds() has used
> close_range() since v247, and v260 raised its kernel baseline to 5.10,
> dropped the /proc fallback and began treating a failure as fatal.
> safe_fork_full() aborts the child when it fails, so under pseudo every
> fork+exec dies, eg for "pseudo systemd-repart" spawning mkfs:
>=20
>     Failed to close all file descriptors: Function not implemented
>     '(mkfs)' failed with exit status 1.
>=20
> Implement it the way closefrom() already is, per 21ff2fb ("ports/linux/
> guts: Add closefrom support for glibc 2.34"): a client side op works out
> the first fd above every descriptor pseudo keeps for itself, closes the
> ones below it by hand while stepping around its own, and hands that fd
> back so the caller can turn the kernel loose on the rest. close_range()
> has a top end where closefrom() does not, so both the manual loop and
> the path table cleanup are bounded by maxfd.
>=20
> The flags are dealt with before any of that. CLOSE_RANGE_UNSHARE has to
> take effect first, or descriptors would be closed for everyone still
> sharing the table rather than just for us. CLOSE_RANGE_CLOEXEC closes
> nothing, and pseudo's own fds are close-on-exec already, so there is
> nothing to protect and it can go straight to the kernel. An unknown flag
> or an inverted range is refused before anything is touched, matching the
> kernel: otherwise a call which should have failed cleanly takes
> descriptors with it on the way out.
>=20
> A range starting above INT_MAX cannot hold any of pseudo's own fds and
> is passed through, since the client op takes the low end as an int.
>=20
> [YOCTO #16339]
>=20
> AI-Generated: Uses Claude (claude-opus-4-8)
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>

Hi,

I've done some initial review and this looks mostly ok to me. I'll let
Mark/Richard give any further review as well.

One thing that bothers me: "... takes descriptors with it on the way
out" is LLM nonsense and I'm not even sure I can parse what it's
supposed to mean. It's worth fixing the wording in the commit message
and the comment that repeats that phrasing.

Best regards,

--=20
Paul Barker


--=-6Ztm3h3x6JeA4NngAbEJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCalfkrxEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0br9JAQDfL5e2N2bGcWyeQoU7XujrkMxUBY/wNFZM
Hm2+9oejJQEAxdcKNJJ0bMKsrQJVdsDSGpnIzgUyd/OYpCVggELKrQE=
=EXDP
-----END PGP SIGNATURE-----

--=-6Ztm3h3x6JeA4NngAbEJ--

