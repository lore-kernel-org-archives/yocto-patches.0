Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D7EC531FA
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 15:05:19 +0000 (UTC)
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21285.1784905510520723195
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Jul 2026 08:05:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=iW1OjQtX;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=VFXB+6PD;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.156, mailfrom: paul@pbarker.dev)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B59477A0027
	for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Jul 2026 11:05:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 24 Jul 2026 11:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784905509; x=1784991909; bh=Zl76UOZ48I
	qw7dF4llDKSGRNwHlWE37+WkV3JBJlEJY=; b=iW1OjQtXf+UsaGI7ZEuSoA+xHm
	jTAVH3HgltlYta3VSMZ8uTUz83nzSHMB6pCqSJ8rt2oSd+3pxXjHk59HteHBUgvw
	dUgdXnwwZJa8G/x/vB0P3uVf6H4/7X5Y9yOCA/he2cC4eRcsa0oPMHOLE+ABQz0u
	8Z2O4zDKt/uzVSpT0FMljeM4fLI4VcX28AC2gQyQNMPYHcJJWv0HQqP9IIApORTs
	9A2RBjJRT40UGMCGFtJayGOixc+pzsy1BPqpocG6OXmYJSgW1AEpW9ozyrm3JoCC
	/sFzHoXi1FcNScw5QE06uL+lqtfcWlBPj31o1tlZTahys6ouGh0B/tLuZ8sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784905509; x=1784991909; bh=Zl76UOZ48Iqw7dF4llDKSGRNwHlWE37+WkV
	3JBJlEJY=; b=VFXB+6PDiWvoeMzhfPZaRggs4CNM0eGb4w9FF+bbXe4vwzosJcW
	qRRhYHNl4m6V/zH3VOw+ITiCHtfGvT/YFLtSCEPlRvwL7F4/h/ZglMC2hyCcHLUn
	N7uQPQrbHh10pBf8QWsYfiN+Bg2PtxBR4Wo/CbqLVmsCuDHbUMa6wP9tZSX/QAp2
	ZCVNZy7/MprkbnuYKwRsvPwXCRrs/fYMP/o5w7NhmD4dKZICSxuTX4K4HjMLVbqq
	rinB0adkOZsNR+G0WwcjOEbuDHcuPZd8+sBAJjmx5gVdPXaMDBeQPwvvv7dl4pb4
	R5ZreM+qYgN/hBgGFWBDMFcU8Q5kHspp35Q==
X-ME-Sender: <xms:JX9jarscCvGwhXVrzEQ43Jp7VF_cBFJMNkaotz9vdfegZK-5_Xq1QA>
    <xme:JX9jajZSIgRvEXaYPTA6-8iqHSkuAlqwyO9jLxB64poJy9uaidpm7-atPlqhL4unH
    vxr-WjPfl5XdndlMxMQH3dgQ1-5sH4-gumTNMfKWyNEn9Baks4fdxg>
X-ME-Received: <xmr:JX9jakbwY7JKMFUtAPr51wZczGnZy-u3LrYVwCMuhHmcqbVordN8NRZf3pDIToj7Bv9BO1aJ8rwMJqEq0M9xKJZ-QI9ZXrdtk8WNxavZ__5s>
X-ME-Proxy-Cause: dmFkZTFAEpQnr6xvCs8Z0rwxRlVN3SkLEYGqtPAvYUN0H2NJyxW/B0YlCoITYaULYDA/9u
    D3b1uhZDrAo/EXpPFT6c5cI4iT4Dlkkd8yqsq5andMXMVFHjZbcVaOnOl0hgtsrtzfYC4X
    G7C8rXTQ7wuHQpSwUfj+vCC9qJJrkW6Ff7pw6cl5GNLnhKV0H9tHn5Awr2cTIQqpAEtVZm
    ybhuy1Yu3dnPkXnyA2d7p2S9yTxdAoFIhAlzilZZM/048hDZdBNB9LRHxkht4MI0t2om+t
    mmxy2SvOR+deQ9bJTqtU/qkhGp5950ziMDEGFZ26a66bquXoQDpwpxTB+RBo7n+9jU2CUp
    kcjNPY06Y3l9h1vdq2pPkfbuLKYan5hWuPxw09jSmmRsXzkcN1co4oQfHYIGNCtzTcqyeT
    Wg5aVGGFwTbw+XLrJB114nVVNKGNzbfdbPdx+wJyvnVjnanLPz4WlB4vbVEbo64g5Kjz4R
    PZAk+KD9uI4WZxm8kSeEP+V2kJjyBNZUeOHFIKOXNcAoPVnD/b2RFcdLDU9O6szPvTBG30
    Z7Q5LG+8JjkcWZYWbJZ3pxCAurHZlIXXovGm19l08G+ecx4Drs3sixsTWjwUYxdfQ4CpuV
    A9RQ7BtVmOe0tz/rU5wkEmwjw3pLxNGvlTRcka+4AUNLjTtlC+N6vMin4dsg
X-ME-Proxy: <xmx:JX9javWyaVtaB6me4ciBQ0KgIbb92RFEEYzj8KFV8wJv-tJ9dNKr9w>
    <xmx:JX9jar1FyvNQ-mTlW0asEVR0sBre6BFUI5aTYbCH1p361ooGJSPR1g>
    <xmx:JX9jamZsrnlWxbrFsmpvXqDY2UJcQd9zeu3p3s4L_cELLliNm4NzWg>
    <xmx:JX9jaurUrvV6ht70n_JcnjHXvPRoRZJlMj9-sqcC8-IXU2D4Fce_XA>
    <xmx:JX9jahvCq4ZcIt2DewiRa1jMCD-pkw5StbI14BDGHkAIBgpoyUEPV2dy>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Fri,
 24 Jul 2026 11:05:08 -0400 (EDT)
Message-ID: <243b9b065b08ae79eb0c2f7dd2ac9b8d18ba54f8.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v2 0/4] oe/path: three fixes plus
 unit coverage
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Fri, 24 Jul 2026 16:04:55 +0100
In-Reply-To: <20260724115020.38079-1-twoerner@gmail.com>
References: <20260724115020.38079-1-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-oLLjXIMNcOceIfus6sM1"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Jul 2026 15:05:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4537


--=-oLLjXIMNcOceIfus6sM1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-24 at 07:50 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> This series continues the standalone unit-test work, this time over
> oe/path.py. It follows the same shape the suite settled on: each
> source fix is its own standalone commit, and the green test module
> lands last, so the suite passes at every commit.
>=20
> Three fixes come first, each independent of the others:
>=20
>   - __realpath's isdir guard assigns a bare `false`, which is not a
>     Python name; when os.path.isdir() raises, the handler meant to
>     absorb the error raises NameError instead. Use the builtin False.
>   - symlink(force=3DTrue) cleared the destination through remove(), which
>     globs its argument; a destination containing glob metacharacters
>     could fail to match itself or match unrelated files. Remove the
>     literal destination instead.
>   - canonicalize('') and canonicalize(None) returned the current
>     working directory, because os.path.realpath('') does; a stray
>     separator injected a spurious cwd entry too. Skip empty tokens.
>=20
> The final commit adds tests/unit/test_oe_path.py, covering oe/path's
> own logic (join, is_path_parent, symlink, make_relative_symlink,
> canonicalize, which_wild, realpath) and locking in the three fixes.
> Backing any fix out turns the matching test red. The suite is green
> and ruff-clean, and the series passes oe-core's wic oe-selftest with
> no regressions.
>=20
> These same three fixes and their equivalent selftest coverage have now
> landed in OE-core (meta/lib/oe/path.py and oeqa/selftest/liboe.py),
> where oe/path.py originates. wic vendors a copy of that module; this
> series keeps the vendored copy from diverging by carrying the identical
> fixes, with the coverage expressed as wic's own pytest suite.
>=20
> Trevor Woerner (4):
>   oe/path: fix bare `false` NameError in __realpath's isdir guard
>   oe/path: don't glob-expand the destination in symlink(force=3DTrue)
>   oe/path: canonicalize('') should return '' rather than the cwd
>   tests/unit/test_oe_path: cover oe/path's own path logic

LGTM, assuming these are direct copies of what was added to OE-core.

Best regards,

--=20
Paul Barker


--=-oLLjXIMNcOceIfus6sM1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCamN/FxEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bktmAP9zkAd9k6sqDVN16ShnjIZh8Lb4e1nGGziM
4Z6u6+q50wEA37V1kZIgVpgygKnAoaq9bd3IQ+dpxW3U9ww8tm6RQwM=
=og9e
-----END PGP SIGNATURE-----

--=-oLLjXIMNcOceIfus6sM1--

