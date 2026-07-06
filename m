Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AFCC43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 08:55:13 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.146015.1783328106881710685
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 01:55:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=mhThZ3+p;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=B3iLr+3L;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 3BE661D0010B
	for <yocto-patches@lists.yoctoproject.org>; Mon,  6 Jul 2026 04:55:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 06 Jul 2026 04:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783328106; x=1783414506; bh=yP/utq1Rqc
	ZphSt1gdYZoFl9pnmaZ7da5C0oMF/ZQ6U=; b=mhThZ3+pmlUXMKowMGMXk6yPvP
	uwrS7L9/6DBWS4urCIlA7GNkJSiz5EE8lCftSISi+iadW4nc68pLBpBemA9BI6zQ
	cxxHh6b2QLii5qYAp7KXKicFbipiDzzyQhpZceUzG2ffka+zC3Rv4XpK4bqoY3nM
	0AydhSe0/xwHuDCc3CLN1dfusgVqyZGuQjuyfvCu2wOpMcfQFL6pgQkR3tHJDkGN
	vbnkgldykyEJ43jYWCUcmPp+fOEiGqmIAVJ/gF+hCBrFFcat8AIEhdu/bhNYa2W1
	aBMrkygAlRG+CPCmPd40KbcBGS05szPEeGn5xJfPyYg6+yNoslI7NHQOoFIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783328106; x=1783414506; bh=yP/utq1RqcZphSt1gdYZoFl9pnmaZ7da5C0
	oMF/ZQ6U=; b=B3iLr+3LTpTp6M+hOVTibxEsjB7eoO8xIT+HBY21bZ7stQpCAmP
	fXWZ0g8OmDMW1Q7LflWMZsQ/2gEypVIFs402OSOmTYZinPutcI6JwKGbCRQ8WbZX
	/4qhbbzI0nYkk/or176cm9iTCK9LF/0s5AD3HcyiJG4cy/CC2qd0JuAPB9ZTPsS2
	e2ynZJtLQaMnk5gTwgH+Bbqn+EguO+QSztrvQW6GwhtqkYxrloin7U2ZhbP7gE73
	tzEQwxMdRwSmHHSI/nNdcb5OiOGrYSBLocdzZDlQMgXZGXT7p8g96AngpV3zMUXm
	JZu7Lcu85thQ9LCfG0UbmiybxxF+al9eydg==
X-ME-Sender: <xms:aW1LajusQGUt4Yp0P4ksMCr6O4SbmTjtFydW28hVakyGOsBhMiZ0ug>
    <xme:aW1LarZrSs7H8d3a4jMCJYCEtlaozO3OwSvqE8iZ6gfB2w4iMB8CniZ1Hw4e0wHHh
    yInMr8q7PNcY48C-vW0FY312Tro7bnJ-omNAYJyteHR3rkhCFpHLUk>
X-ME-Received: <xmr:aW1LasbLX040FzbQVpkEx2z6vwSV3dKznTJhOXkjcYkqXzV9Rr0ILMqykc4TE_h4n8Ip-ij9nXGUZRrpmhpsFr480ClMAGZVJTSFjbtJit9t>
X-ME-Proxy-Cause: dmFkZTGlRvFVDLOL6UJdtRxuJP8ldbb/dUjmj1te4vvFcCY4aZgAWmj7QdJtJ+yz2lV+d3
    u0SqqQGWUIM4L1Nvki4baK5A151r9nDZd0Y+/9NalmWspc3cZOXKoN9KQPcwyOo+7rXWCL
    g/JDqTOo9GkAFfqWS0sPsjXpYrwsn+oE7qIgBvfHIhIxPA4j5Il3uYPsrvZ7PdphB/0PEt
    VNoXjkugl/TFQdai2VEddg6xRfZPS3jPu+cPIJ3LB9to0F2kRB8pHgG5zagfkg3PY9YgQv
    msEzl3PeKmtamwn6zFFjr5gZeIUGAeVihAe/KcUMytKUK3Ah4Zwc9bW67xVEgsYObPdtfG
    xF67Nvrwrwhu8vuKfgthwtcZaU/2fWL7JuTw//thXT/x7X07K55gbNVXrIpSFPwymV5VU7
    +/cJ/8EWm5/IJa4W9GXw+KQrCBwSRnFYvdcFqISTUd5ij+uWfjltaUugp4vhlPcvOQIAW7
    MpFHHy7xVG00/f8ULTYlUps0GHbPk8VfS+tTGt1MzDq+iYadOc3dZ9F+TNbpfunmDbRl4e
    vsOsK8bN8On7j+IzrLdYDApZ2TNqR9Gac2XQ069AO/uLaYaP4217113rYka/CmOJURH0Sa
    egOHO9mAtF/z/20JqITntwiqV6Y6pbho6dvLhkZ+asjQCg+QY8bNFq+/e5kg
X-ME-Proxy: <xmx:aW1LanUo22YszM0VOuMe58Y9MNIHBLpRwfYAdSoHTmT866Ga3nAU3g>
    <xmx:am1Laj1NqhTPpi_CC2H_x5FYFb5tJssesPzaoqMN-WKc3KlnK3x79w>
    <xmx:am1Lauadzqneoi3d4advxfzOdWQEEUgyCM0X52rwId5kr288JP49VA>
    <xmx:am1Lamro3AHZ6R8CmQmeivAGWng87_mMBKF9aQAkKtMQnzkX0BctkQ>
    <xmx:am1LaptvPUOMNvTpahzQQUlT1V6FdRAVCLrtZ5MIOhQ1zRkp3KnZXokx>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Mon,
 6 Jul 2026 04:55:05 -0400 (EDT)
Message-ID: <997b69f88a8fd258b424f014e9b4e14679f1b618.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v3 08/10] tests: ignore E402 in the
 test tree for the sys.path bootstrap
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 06 Jul 2026 09:55:00 +0100
In-Reply-To: <20260701074030.1090807-9-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
	 <20260701074030.1090807-9-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-V1Q4qjU90ThNEZXnJ/gp"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 08:55:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4427


--=-V1Q4qjU90ThNEZXnJ/gp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 03:40 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> The unit tests that follow run against a plain checkout that has not
> been installed. To do that, each test module prepends the in-tree src/
> directory to sys.path and only then imports wic:
>=20
>     _SRC =3D Path(__file__).resolve().parent.parent.parent / "src"
>     if str(_SRC) not in sys.path:
>         sys.path.insert(0, str(_SRC))
>=20
>     from wic.bb.utils import mkdirhier
>=20
> That bootstrap necessarily runs before the wic imports, which trips
> ruff's E402 (module-level import not at top of file). The ordering is
> required, not accidental: the import would fail without the sys.path
> adjustment ahead of it.
>=20
> Rather than scatter per-line noqa comments through every test module,
> this commit relaxes E402 for the test tree once, via a
> [tool.ruff.lint.per-file-ignores] entry scoped to tests/**. It is the
> only rule relaxed for tests/; the suite is otherwise held to a clean
> bar by --lint-tests.
>=20
> tests/docs/linting.md gains a section describing this single exception
> and why it exists.
>=20
> AI-Generated: codex/claude-opus 4.7 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes in v3:
> - no change in this revision.
> changes in v2:
> - v1 submitted the entire test suite as a single commit; v2 breaks
>   the work into a reviewable series, and this patch is one step of it.
> ---
>  pyproject.toml        |  8 ++++++++
>  tests/docs/linting.md | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/pyproject.toml b/pyproject.toml
> index 656adcd4930a..fb42fe6dd135 100644
> --- a/pyproject.toml
> +++ b/pyproject.toml
> @@ -58,3 +58,11 @@ tmp_path_retention_count  =3D 1
>  # not yet ruff-clean and is left out until its findings are fixed (see
>  # tests/docs/linting.md). --lint-src can still be run to preview the
>  # source findings, but it is reported, not enforced.
> +
> +[tool.ruff.lint.per-file-ignores]
> +# Test modules prepend the in-tree src/ directory to sys.path before
> +# importing wic, so the suite runs against a checkout that has not been
> +# installed. That bootstrap necessarily runs before the wic imports,
> +# which trips E402 (module-level import not at top of file). The
> +# ordering is deliberate; ignore E402 for the test tree only.
> +"tests/**" =3D ["E402"]

LTGM.

> diff --git a/tests/docs/linting.md b/tests/docs/linting.md
> index 71b4de21c100..1c1bfcc06f82 100644
> --- a/tests/docs/linting.md
> +++ b/tests/docs/linting.md
> @@ -4,6 +4,7 @@
> =20
>  - [Running the linter](#running-the-linter)
>  - [tests/ must be clean](#tests-must-be-clean)
> +- [The one intentional exception in tests/](#the-one-intentional-excepti=
on-in-tests)
>  - [src/ is not linted yet](#src-is-not-linted-yet)
> =20
>  The test suite is linted with [ruff](https://docs.astral.sh/ruff/). It
> @@ -28,6 +29,25 @@ Our own test code is held to a clean bar: `tests/run-t=
ests.sh
>  --lint-tests` reports nothing. If you add a test that trips a rule, fix
>  the test before the change lands.
> =20
> +## The one intentional exception in tests/
> +
> +Test modules prepend the in-tree `src/` directory to `sys.path` before
> +importing `wic`, so the suite runs against a plain checkout that has not
> +been installed:
> +
> +```python
> +_SRC =3D Path(__file__).resolve().parent.parent.parent / "src"
> +if str(_SRC) not in sys.path:
> +    sys.path.insert(0, str(_SRC))
> +
> +from wic.bb.utils import mkdirhier
> +```
> +
> +That bootstrap necessarily runs before the `wic` imports, which trips
> +`E402` (module-level import not at top of file). The ordering is
> +required, so `E402` is ignored for the test tree via `per-file-ignores`
> +in `pyproject.toml`. This is the only rule relaxed for `tests/`.
> +
>  ## src/ is not linted yet
> =20
>  `--lint-src` runs ruff over the wic source, but the source is **not**

Argh! Claude! No!

This is well documented by the comment in pyproject.toml, it doesn't
need detailed explanation in a documentation file.

Best regards,

--=20
Paul Barker


--=-V1Q4qjU90ThNEZXnJ/gp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCakttZBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bpN9AP4kDK9T9MM0rsYz9RALeEIKJP15iPqS01rb
8puwrswMKAD/eo0Y7dzG4Ok5O4yVXxf4U6fFzrhK/8ybskNoFfI6wAo=
=6fF+
-----END PGP SIGNATURE-----

--=-V1Q4qjU90ThNEZXnJ/gp--

