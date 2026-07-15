Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179EBC44508
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 18:01:37 +0000 (UTC)
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.230.1784138490854478155
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 11:01:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=TfmMCsnS;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Ut+uVwCY;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.151, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 072F01D00081
	for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 14:01:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 14:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1784138489; x=1784224889; bh=owy3f0EkbT
	KyZiaArtjvXcCzriJW3uLl8ttHwJdCUp8=; b=TfmMCsnS34D1tYHh/V1ahW9Dl0
	F4ZGt/KSN0vh+2QHqrpuTCJmy81itW51ltMa2bNa0fH4pKprkCe3BRsa4tVmdpQe
	IY/9AV/7T4NSzlq6+wl6Bky0/fH22+3BW1m7Jp8/EG/KmdwZpyKCQpwkjmmUdbMs
	CmL+tHk036rhfOMB1YrFDGAXf4QcuwUjG4ydlk/9lpVK3gKg1tahEMlIDURbzJz+
	AfXt3DKBS3FEWmzoBpgoGWJ9RsT4HVisvk+QIP1/Ejq8vye/d0wzYgFx7HWbsOVt
	hvAA+DjgUubIDmi/V1UkurcPCmiVCFhYHTZUzwn1ggB9fNMHQQyJoaw40NQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784138489; x=1784224889; bh=owy3f0EkbTKyZiaArtjvXcCzriJW3uLl8tt
	HwJdCUp8=; b=Ut+uVwCYIc6U+h8JjE0JrX3c3RM8R4YO7xRBMZ6kJiCY7sLKWdX
	L7fZLIcTzl02GNwVMIZdEBoIoEnKFcA1I712Y71SMnS5rxoC8hzqtygQsFyuS1zs
	YF+iWI3HrYEDqVGE2TOGuDxUH+8NBm9bgG2z2tWWLV+AKnngQTl4raP8VNG/pAtF
	Ik+nwNxKT2XxwEk6G8MiFlinGRcCGodtMQHazHuP7hl9Wnq54B/FdcEmJ6a5bf/Y
	5wtEdWJj9t3GZCcr9RjxU6hqetDD9wqhTF8xLpIm6dae2cBmgisU6HhocjK6Gg+D
	W+nlJ66oU3FcJSSVdwIY/2VXmkP/NsYBllQ==
X-ME-Sender: <xms:-cpXaknOgeHpQyR8ZEGFJQVfaR7lYUYAXLife3IEK9mYhMYiUA7OJQ>
    <xme:-cpXaqx_hsOkfz-Ids_f6f9oHBIyxWeF7tGcF1xCI3xBr30PIRNDFsORB5XeL95lU
    QWE6bBotP5TCCkGJDbPdW9VtyrCpDIw-TAzyhzOlZLRiGSyZXrgl5o>
X-ME-Received: <xmr:-cpXaoRPq23x7ZSJsvRgY17TeMkxNlTRJzzReftkbB4qNWUhiHnQcfkB541I0izsZN3O_jU-IaTQrknCfnibhuNKO_pTVConOA1iW6lPYZO3>
X-ME-Proxy-Cause: dmFkZTEVIiMcHz0pZbT1sys+vvyZ7nzRgey007dALy28Ef1XV9UqQF6EU1cS6wQ8x7caOg
    mrmRdxsaNW9kx1D0LvigQTo7avRwYL3GAAW649uRzvNb/WqLbhhlPqFKbvi96PjSN0dFa9
    R4LNYOMOABut1S+hQK7K5sAn2n3r42v/ltlUFeRefezPvPkoxHAPwv0DxIvrZQHqc3Pa7s
    zaRm2IERSeBcMWTA4/biSAEO8aCYGHYE9uBUWR5sA7Kz3lWZrRT2pgwKsYgVrgnz2ylHCA
    DtBqQoRlo4XhyXytvNKWZ61sp5hToW1u2RBo55MEbwOnazS9TNcs7qaL3RILqp02BMKEmK
    RKawIe1ypGcJbwkr27cTTvetJ20T2b1vD1pHxUb+T2kEoAXY492jypH6RG7MU08dh8iG9B
    BbfVpe1AoHDbu9GZBq+m91mGOM2QtB9HwEZ4iRarrfhz3PS6ELeQCA0GheTIMhyfeXkBTH
    hUUExGhWRBUteRjRCV3w8NK+6UQrcqFds8AmpPjvWzI1e9zKXhNCFE1tsefQYVcg1vxSJi
    BEErQH47YUKY33FtO9ySjKcmG8o/8l9bZlXuGw/GjLnGhWplQYtsSVE4QA/aLoICrPa1jB
    NK29b37nFZH/sQXKGmFv6W51hEUlUHhH0IgkXhNY45zc4o4YS8yWuicZbYHQ
X-ME-Proxy: <xmx:-cpXalv0hskceh361cyagc4v8ii_gpQWoMuE86A3JPgZneDEurHz6g>
    <xmx:-cpXaivCCN19leT2bOTSLcchhLX5rqWc2uWn-0By-wCfOl1RCW9hmw>
    <xmx:-cpXajw7fAai7yfY6Bn9uqFBz0LDmKKMs4UUnzl7MzKieEoCGGwcOg>
    <xmx:-cpXaggqbBKLaV8ZGAuuQcExwEjwIUL39bGxEZ9qlDKAtJkGK8lEpQ>
    <xmx:-cpXamHxEVOFgcUN_1XnNmVyW_jmZdAJd5NeK8p6cnV4eJ2fLd9fAqLN>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Wed,
 15 Jul 2026 14:01:29 -0400 (EDT)
Message-ID: <237352d6f13f1081afcbe97da4f67bd94cee9b92.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH 0/4] oe/path: three fixes plus unit
 coverage
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Wed, 15 Jul 2026 19:01:25 +0100
In-Reply-To: <20260709205227.3470712-1-twoerner@gmail.com>
References: <20260709205227.3470712-1-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-9pL30SvRhtkkJCyKq2G2"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 18:01:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4480


--=-9pL30SvRhtkkJCyKq2G2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-07-09 at 16:52 -0400, Trevor Woerner via
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
> Trevor Woerner (4):
>   oe/path: fix bare `false` NameError in __realpath's isdir guard
>   oe/path: don't glob-expand the destination in symlink(force=3DTrue)
>   oe/path: canonicalize('') should return '' rather than the cwd
>   tests/unit/test_oe_path: cover oe/path's own path logic
>=20
>  src/wic/oe/path.py         |  21 ++-
>  tests/unit/test_oe_path.py | 298 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 316 insertions(+), 3 deletions(-)
>  create mode 100644 tests/unit/test_oe_path.py

Hi Trevor,

As src/wic/oe/path.py is a copy of meta/lib/oe/path.py from OE-core, I
you should propose the fixes on the OE-core mailing list so that the
rest of the project can benefit from them. The fix for bb/utils.py in
the previous series was not applicable in bitbake itself, but the fixes
here are definitely applicable in OE-core.

It would also be better for unit tests covering these functions to live
in the OE-core selftest suite if possible. Tests in wic are better than
no tests though!

What we should avoid though is the library functions copied in from
bitbake & OE-core diverging in wic, as that just complicates
maintenance.

Best regards,

--=20
Paul Barker


--=-9pL30SvRhtkkJCyKq2G2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCalfK9REccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bkO6AQCpfOoyOvB3FXt4z2qTphT4q+QbEkYwl/Iv
/8aCCHh6FgEA6LUF0qMFmC6+a07QIJzigc6g/xBRAHW1YbcHTSfKbw4=
=Ca5J
-----END PGP SIGNATURE-----

--=-9pL30SvRhtkkJCyKq2G2--

