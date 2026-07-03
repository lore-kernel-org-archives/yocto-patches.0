Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F8FC44500
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:43:18 +0000 (UTC)
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90596.1783075395462325011
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jul 2026 03:43:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=pikyz34S;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=A6OIsOJT;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.157, mailfrom: paul@pbarker.dev)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 349F37A00F6;
	Fri,  3 Jul 2026 06:43:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jul 2026 06:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783075394; x=1783161794; bh=n6lc1VZuIp
	dJHq8ycsAz8K0sgTwMkreVoAcosiB3iHI=; b=pikyz34S8mUNLBs2VFx9nzk0XN
	XBEhmAnOIiIhI3ERBbGPj93XAaVhQvnm7Nc1CA0u0eoZOTf50LIrtpF8ODNPt2bw
	9t8J9hQeAUGuyAU6d9nd8mNNOBG9notuE2NP57kkljEMbGrHIGJa6ui1RO7N/9aR
	vVQB5CtDbFo7x2iRC276SOmN8p9s+gI7DjnsUEZ8O5C0MgdATqU8T1X6aVedFYVF
	aUNKQerx7pZpNN2UbSPmeXAmRN5rKG+3GMEIjIiTSwxosO4UduhMnkdN2HiO0qel
	af4/60MeZlrmTl/Q98AfgOY8cwH27Sl1DpUV/mSGSHwAyGbvNsspJFOCbCfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783075394; x=1783161794; bh=n6lc1VZuIpdJHq8ycsAz8K0sgTwMkreVoAc
	osiB3iHI=; b=A6OIsOJTm32AEBEjLH4CQWN39qbV7QzCw8d3OY70dGRX6HJpMq6
	dEeXa1rGgBvUF/hpSR9ayop0SJQuMNZQOqm+5HgPTQldlBdmTL9IKBgtFNGfxXCi
	1tO5IEDnXCOQW39A28kcQIJ6QsWM5sV8/CxYTcJlVJFsyGfVKjr6hHgP8HWvUEbY
	c6mCuKB6IdVMysLP1lUk7F306eeD3jpML8QYZHoeSokksStbSYqRJMPJDm6vEBus
	fY3vRJIW+sBRcdc5PgEffTOl66ftessU6dHMghIstWKHIbwdWQXOJxm2Jn2k6C+8
	28k1rXM8YcqkpLpwIvJ/rzURIJFEitLk65g==
X-ME-Sender: <xms:QZJHauqRIIaI5SZbaFSsQ3SFx5I-ZW1_0AJFo2LsnZuTdB02kNUpfQ>
    <xme:QZJHakFUgID2DtrqjyAH6teoK4zj2OTML3HnFyPPaykCPjHbWgOoLI51MiF4WtPoU
    8AotP4m5Y5iQKFbeUBtHU81XSAnF1T2cTNre3C4FYwul6dFlbHvhe8>
X-ME-Received: <xmr:QZJHaglOwECk7LCaKa-tN3vAZEtRB5rU0xaYuIOLW1gn22Ja9pi9F8L4piHqoffbMTV6W9AnT4_bpQM65oPLme311TZY_1hO8hzNFlg_2mxb>
X-ME-Proxy-Cause: dmFkZTGfy1VuNxYz73oD30EXpvDqvontWx9IC+Rm8IcalxEEOSHXH43wk09v3AQ34s7I1t
    QbCNRiQycgTqt5HGtv0eJjq1g6OqQEK9/UQYm4dtwWR6Mu9uT0Hcxl2RKjFY1RX8M7QLla
    NIDTmnwlQfYqkuJoGapnRCPJauUn4kw7zNkaMd55S1jAymI3y/WJf9T6JOe7gc5mYZg4EF
    4t2Wp0eUtuHB6e34tKX+iOVUhTWcDJ5+a6d6S4f8xPmNWahL7BJsZFhooncbEuTXf/UpfN
    ddUor+/J/48k/ifEnHsUsYtvYyurMFdD8+swSAQP6+mRR/b139Y1uzCpO8eYk82vq0FEA4
    hcFTgvgYu6f3ifagsz1Sdmw4t+jcGkVKaQ+m+UXGquuAU3hqqw1sW6O4XhvxXyAAozAbOi
    ZfErN8PHaaqz2wiKWnQgpiaChxV8dR6+q4MlncgthY3UEO59yV8qZEYDCPSR798vz+oGGM
    yrae70n17PWjpfQC4CnDge6L9sS5w+awlJ33xzhGtaVGs1ADhoMLS9/Zn/kWujaH81Ra6O
    kU9X0nNXcKyvevBqGMvRhd5xgE2MqYThQXXMKVM5+VP0GJ2lzxpfm2SA/OjGKYFYBAsG+Q
    ICiUKPvFernyGq2T4aCZFTeUGV6nyoidZUexsuDreIFX5HyrHcQbfC8dlebQ
X-ME-Proxy: <xmx:QZJHannTE__92yzvqpyiMFzycgNrxucQRQv7kGC4NAukVz03QJ23mg>
    <xmx:QZJHahs8XbdRw9ARj2dL8jY39rNo3_QnN7D_Gj3gfom7iCNEAUWjVA>
    <xmx:QZJHaqlaKLQzhMgBik3oU3zqimy19r2WGr5274lwIqg2CFUKwCNwfw>
    <xmx:QZJHast5QYZ6scYcOGOKV299kBUo4SgE6AECbv29PHxRo096pY0ynQ>
    <xmx:QpJHaqB-MV00mX1dGTVc0Q8rl7JFqrzJKgQK6qTtdgT7qAxjxQJf4cEA>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 06:43:13 -0400 (EDT)
Message-ID: <bc1f156be43b3c476a853e93321db726de900b50.camel@pbarker.dev>
Subject: Re: [yocto-patches] [pseudo][PATCH 12/23] pseudo_util: Add default
 log severity values
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Date: Fri, 03 Jul 2026 11:43:10 +0100
In-Reply-To: <1783039578-31531-13-git-send-email-mark.hatle@kernel.crashing.org>
References: 
	<1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
	 <1783039578-31531-13-git-send-email-mark.hatle@kernel.crashing.org>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-dNI6tpIOjgIToOsxhN3X"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 10:43:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4390


--=-dNI6tpIOjgIToOsxhN3X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-07-02 at 19:46 -0500, Mark Hatle wrote:
> From: Dmitry Sakhonchik <frezidok1@gmail.com>
>=20
> Default values are "show everything". If the user wants to see
> only certain categories, they should explicitely set
> PSEUDO_SEVERITY env var or use -k option.
>=20
> Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
> Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
> ---
>  pseudo.h      | 2 ++
>  pseudo_util.c | 7 ++++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/pseudo.h b/pseudo.h
> index 92ae71e..66aa70e 100644
> --- a/pseudo.h
> +++ b/pseudo.h
> @@ -130,6 +130,8 @@ extern char *pseudo_version;
>  #define PSEUDO_PIDFILE "pseudo.pid"
>  #define PSEUDO_SOCKET "pseudo.socket"
> =20
> +#define PSEUDO_SEVERITY_DEFAULT "info,warn,error"

This default is confusing. pseudo_error() doesn't check
pseudo_util_severity_flags, so errors are always printed.

This also isn't "show everything" as pseudo_debug() messages are not
shown with this default severity level. They are instead controlled by
pseudo_util_debug_flags, and having two separate sets of flags is
another level of confusion to me.

If we're overhauling the logging for v2.0, I think it would be much
better to merge the log/debug handling into one ordered list of severity
levels and control what is printed by specifying the minimum severity
level to output.

Best regards,

--=20
Paul Barker


--=-dNI6tpIOjgIToOsxhN3X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCakeSPhEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bi/2AP98pln1sJratVvR72vRts8jcMX22EWq4jMN
qH7xs+dJuAEAnJOgtV2MpWAN7FYxcA9FHxDPJ7sj8yCodvmfE5d+tQQ=
=4dLj
-----END PGP SIGNATURE-----

--=-dNI6tpIOjgIToOsxhN3X--

