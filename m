Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FF1C43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 14:28:11 +0000 (UTC)
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10034.1783520888464010866
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Jul 2026 07:28:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=lyYYrNIi;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ksdXsArL;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.156, mailfrom: paul@pbarker.dev)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7FD81140006C
	for <yocto-patches@lists.yoctoproject.org>; Wed,  8 Jul 2026 10:28:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 08 Jul 2026 10:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783520887; x=1783607287; bh=ctXz6JnGxu
	BtX++Ab+D2w+2X0QFRXgSSKsIxHoYgP+8=; b=lyYYrNIi19UfKdzqwqNX6X/6dt
	Uz1XDfEla4E20SXPIXTHahuPOT7nfLttCCdLqRDqR5o5ebqjx1twpyx3NGzgV5qS
	vLzorBSs6P2B9boLt8ZcR3QqJ8HjMy7UfOTEua+TGT5Rrw7qKL2HpXY1a47/h3Rc
	de9pcmgb3zU09dA9IhnV72Ellsakk8Z6wXWQxk536aZMx0seVjI9Wjt3G/dkGyYY
	xcaklGQDs6HqJipQEBd7791EHgz6rOsxlIbdpjtNPf73O0B1P49jSNlMnWm+I9iT
	31w8GCIkzzMVthITmmy2ueTbRUdpYvIwCze95kV0ZLJclJnMvoavZyAN0R6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783520887; x=1783607287; bh=ctXz6JnGxuBtX++Ab+D2w+2X0QFRXgSSKsI
	xHoYgP+8=; b=ksdXsArLMbtlpv2I9sYJrT2r5VeG/4X9VQAlzKyS/A7t2dYIQhl
	cqNpmAI7IAzkQs7r/HsPamK/SubQQy0SHdB2k9rafXoSpEybM3jnAw+GPR4YrmS9
	8tKG51bqok8EioEHI/ht//R3iZe4Ybc6YyWDZXae10yGqH0+SiSoUgFF6ZeAD9hR
	/k/mbvRpFQWbSlgliVYbUy0SgIUro5niOuPqs2weEdWCcRVgGXGZlK6PQmH0fVsZ
	61QNYlKOcl6n3B7ovxcZbDpDziLQRKgH/Km9rjKvUAn6+g8anSzVUwtmH+1IK7Bs
	KUjC7Aowmn4PINyiNASHKdPLUrWfPCFlQJg==
X-ME-Sender: <xms:d15Oah5dSbLr3ejG3tu338pHxFzz8IUk8svG6J3MK8BoIx7H_ukRfQ>
    <xme:d15Oal2uLVWHPV_hwTv_chua8o5HX1gZsXNOciqcR4YVxx_arQi-xgcfHO-n0ywN-
    zCeF5xwrmCMK6AgSjBLI8efF7ZmXB-tup4IYzOl3MV8P-QCxc0d>
X-ME-Received: <xmr:d15OauE2-S5Z2Ku1J0RTPBo9cjHgfKgP3xFAZ-y-e_ps2EQwpowI95IoyUZ2L8yFIt49UZsspvJ0li_xMzCRifOGE1MfByf9a_8LGQ>
X-ME-Proxy-Cause: dmFkZTE6sr7QGopEuOwrblp5O5q3gJR/8/gdHkq1bD0quvmUTLoU59q5sTQLHfdNZh5VDD
    Tp9t9hCrUeWc45Woh0ePlwaqx4jOGYP/HxMm07Tq55toet3Cq4Q5vsT2RBQP9J3sx+9iTh
    bv9Uq+LFxul17G5Cjclsul9xnCgCXCirP3On6buz+oXzqghvOoTbWBCKNFrBV/va9XSzT7
    hbj3coteT9DJwVQWC0K5aenWSUzUdjZLmoFH27YrRDVlfyv6E6N9fgYubx00JDImYBHGDV
    nIXicwyu52i4tq4g8Gw6JvI2B0ut2dUgn85cbjeXB/0BSh3wAMnvn27t5Exi0Y7VfunNLN
    TnLC7m3nAnbIHp06SXI5VJKLX4kBnxi5CUWbd1jHzGI/XrzXo7wYf8XorMxUmgdWB0s/vN
    KNukGG3wH3OyKt2bMlphDq1z/iijxJxz89BjLg9oilmpSfu+RRwkIWrAKs0MMmhtr1c93G
    wEjbvfEO9pDHrl+VjRYhhvxx40vGf0egTs+zHm5Rxr1NZ4/r3E/zI20NVgI+8vulCG02YD
    XtOTK24k7jIuMboIpMM23AQYdRezxhWN3+UskTUEyEC/cRpxn0fNKi4TIl7je502VP08rq
    j9tNT6Dsx4R4uqn5qLZguVGwW6iP7vXLSL+yBbW6yEHYDOqpUoiZxhpoGepQ
X-ME-Proxy: <xmx:d15OavQETAWxFFLaE_nPhk8R_ssOWbVhBhMqICKFMbwZr9FOZDkZqQ>
    <xmx:d15OalBJ5lf-mccHoDEyElG5USAl4hzHOxp14mG2-wh-W5A93badMw>
    <xmx:d15Oav0DVgqX6QTcaxmOpXJtnp5XmUlaxkdGWLF1QLJaaze3WT4bYQ>
    <xmx:d15OajUKcNB_rCx-SRjgZwx4sFiq-Vlibx50_oh3UtoOJj2K_7tUIg>
    <xmx:d15Oaspuq4RxtnW1geahOtrEI8gZhjtuvw1M379UnAuh-fzgYgGC4H-1>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Wed,
 8 Jul 2026 10:28:06 -0400 (EDT)
Message-ID: <b9026649ff8dc1c9d1eb56ac3ef33b84e91573fc.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v4 0/6] tests: standalone
 test-suite framework plus the first unit test
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Wed, 08 Jul 2026 15:27:59 +0100
In-Reply-To: <20260706222904.664863-1-twoerner@gmail.com>
References: <20260706222904.664863-1-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-8u3aLCyLG+ZIsg6i9Zcl"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Jul 2026 14:28:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4453


--=-8u3aLCyLG+ZIsg6i9Zcl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-07-06 at 18:28 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> wic has no test mechanism of its own; it relies on the oe-selftest from
> oe-core, which needs a full bitbake build to exercise even pure-Python
> logic. This series starts a small standalone suite that runs from a
> plain checkout, framework first, then the first fix, and its test.
>=20
>   - the suite skeleton (pyproject test extra, pytest config, layout,
>     a justfile command runner, and a README Testing section);
>   - a conftest that imports wic once up front (stopping the session with
>     a clear message if that fails) and prints a session banner;
>   - optional coverage and ruff linting, each exposed as just recipes;
>   - a one-line fix to wic.bb.utils (import errno) so mkdirhier's OSError
>     handler works, as its own commit;
>   - unit tests for mkdirhier() that pin its behaviour and catch that
>     bug.
>=20
> The suite is green at every commit and the test tree is ruff-clean.

All LGTM now!

Reviewed-by: Paul Barker <paul@pbarker.dev>

Best regards,

--=20
Paul Barker


--=-8u3aLCyLG+ZIsg6i9Zcl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCak5ebxEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bhtbAQDU47J5fmubqOyW4Kw2Q0/w7n47TBgWCXL2
5QItEdUbrwEAwt9moPKjm7eRv+fCK5AnFxzfIfzbF3gbjsAnVZ3EFwI=
=Sts+
-----END PGP SIGNATURE-----

--=-8u3aLCyLG+ZIsg6i9Zcl--

