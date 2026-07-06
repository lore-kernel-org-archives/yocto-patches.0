Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB203C43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 08:41:03 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.145828.1783327256856861161
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 01:40:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=nUGqmBPJ;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ULLFTtSI;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1FF5B1D0010B
	for <yocto-patches@lists.yoctoproject.org>; Mon,  6 Jul 2026 04:40:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 04:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783327255; x=1783413655; bh=TRnw6A8hof
	Z72gvYn02tLcQWZmXhpW6a4m/dXPVkkPc=; b=nUGqmBPJEu/HNWLTPtD8P/wTcc
	iwWiyrICMZCW/+CgjxsGiHp4r5qW/HG5yKqNi0a/0SzQGCrlD5WyjJsWajmu7Jie
	RyAeX+xrVYJ7+Kf63HQIoo0DOb+kjz1w6wvV9RT7fjxdNZWsNYwsjVnjTQzZJsjJ
	YVYn3ZOqMAEJVpmDhgR68LXexoZKwUvqwSz7Swnoc9JIOrHV1B7vQDw8Yd9JA7cH
	Y+CcTCRImIyIpZIUrgXIJl0lsZ+4fDNi60uat3w8zt8cjhVSmpo2jGeP8//rf94s
	UsY6FPzqqEh2VMc/dgewXwuLKMf/wsGBHMeueZiN30YA58P6srwIZw6LZaZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783327255; x=1783413655; bh=TRnw6A8hofZ72gvYn02tLcQWZmXhpW6a4m/
	dXPVkkPc=; b=ULLFTtSI74nnzeqtoENnARZFz7kGmC1i3H26dMXsgSIXS7CHcRd
	p+7tc81CVK/0aO02D5dtDX357diYjqV3PR8gvtaXaw4k1jTsxWLegaOfdVJOOFD1
	SLiJ7TaK3Cc12WUcYk+mAdYrAbpMAWBFS9VM1djAiZpfTn6Nl4IPtRl4y2GjenMH
	WTbjDie086GnYKZKZmZc5Yc00b18WVUXExz3T8knGUlf6rw02NdYPpHX5SYdh9TV
	t7fWyzQ/rR24g9gYfEeYnIjpL5vTRRYlvvnOrFJcrdP5TPz4rFIqMzeLk7jPIcRi
	IzyyE3LmAAmFfnOJQkDCz+GheN+TgTP8a2g==
X-ME-Sender: <xms:F2pLaoKftRyIj1N4iN4NGPGOh_qZCjLCmmXjslyuR4TPHIicNibVsw>
    <xme:F2pLavHKG9XwUx8PrTGoepukQ5Ep0bd5OqANIBbjY7UaQudEsmh41iC-G0cnPkvbK
    _PksyXxFs-4Gv7Ne_MyLEx9uMkI4u6pKCGTyoNd3JzZPwSBRMSLOjc>
X-ME-Received: <xmr:F2pLauVZeEUudV5KuBz4jT01nekEl9E0mCm4Mlybdx2cmL_u4TqOHi9t6ntY352fDW-aCqxgRz6ycAw55b2xxWvT1IgN4AiXnM1qrzmT7I81>
X-ME-Proxy-Cause: dmFkZTE+q3J0DaudaqaLjtNFVTY5E+0nfLFtj6r23KQx84sLuMAN9Qu8wH0WtaPLxdki3o
    OZGUqR5tf1AjGe+CaGWZ92/cNm40scNL8CGjbGKKBwlDvCg7QkxwJUMAMHn2WzdrJsFVbY
    UoZtV+eM0Ee+uyeL+xXG64s8T5GUYp40d8ZiRkD+E/tHcROiF+mDQsqlciMOKr+o3gMK0s
    LtBl24Y5HVSRP8fTHbpOG0NS2pBhvkdJgHquEli1Pd5mNU4h3WzrPywW41Bn+aPt4tppnK
    dsmT1/a7GoRY/YESap+mtXgz3PcY6zhbbfMNxmicxAMHjFaGL5yqbPT8lOpLX+0Jq8iFSH
    bpXdDGiSzlPFCG/UGdTKG/RYJF54ocn4zHx1iRjd/90gL4ZO5nxN2ERxy86IEaQRxvbdkD
    R6b4h8YntN0/wTeXnxUQa376P7iigSD/b0HVTbORxGqyF+s4NhKCPXA0XEMyy6Zr0pD9qY
    0yh+E6kSbYaXPxvJc/KWh2mIxciuSUVSaVEmyw0h9X5X94O3ty/43/atrD1BJ1MZ16pgXE
    ec92fAYwOEV+Rk2iGsPqm3CSeujBXEQjwqaSpvHvQCMiHV+qg6VvIkGTRkuq9Ogz8hyElU
    HNWIs888IaMUIcg2Gk37kCF47Juku/V7Jynzp7sejXO8sPEsiLZV64SMPg9A
X-ME-Proxy: <xmx:F2pLaqiFk5Kdyhr08588p-YTLPn9OhLhPFBwMHg_ERwulT0EZxRSyA>
    <xmx:F2pLavTN6Xq5pFnlGQcLO2BVEoMs_9TsL0mNJNDyR_FdPdDoQ0LxZQ>
    <xmx:F2pLatHVMJsjW8YF3zq3TevMemB0t7f4PJc09zeTMmHugnn-vOKUFw>
    <xmx:F2pLannZj13_wo2TNva0Yf1n6paIpZ26E2pHi6LAFlZLEytX6VgeIg>
    <xmx:F2pLar6r89U75NYB5PsYX0oJIfEF0v8AYXUNrPIdzmvz-_MYvc8P9s63>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Mon,
 6 Jul 2026 04:40:55 -0400 (EDT)
Message-ID: <4d187efe2887fa9b53725309bb1fd8638d72e141.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v3 05/10] tests: add ruff linting
 to run-tests.sh
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 06 Jul 2026 09:40:52 +0100
In-Reply-To: <20260701074030.1090807-6-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
	 <20260701074030.1090807-6-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-EOy7wrT9ru0/DPy6PQQ7"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 08:41:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4424


--=-EOy7wrT9ru0/DPy6PQQ7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 03:40 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> A test suite is only trustworthy if its own code is clean, so this
> commit brings ruff into the runner and holds the test tree to a clean
> bar. It also makes it easy to preview what ruff thinks of the wic
> source, without yet enforcing it.
>=20
> pyproject.toml gains ruff in the tests extra and a [tool.ruff] section.
> The configuration is deliberately minimal for now: the test suite is
> the only tree under an enforced clean bar; the wic source under src/ is
> not yet ruff-clean and is reported, not gated.
>=20
> run-tests.sh gains two lint modes, each used on its own:
>=20
>   - --lint-tests runs ruff over tests/ and exits. The test suite must
>     report nothing; a finding here is a bug in our own test code and is
>     expected to be fixed.
>=20
>   - --lint-src runs ruff over src/ and exits. The source is not yet
>     ruff-clean, so this is a preview: the runner prints ruff's findings
>     and exits with its status, but nothing in the suite asserts on
>     them. Keeping the two trees on separate flags means cleaning up the
>     source later does not disturb the test-tree gate.
>=20
> A lint mode cannot be combined with coverage, with the other lint mode,
> or with pytest arguments; the runner rejects such combinations loudly
> rather than silently dropping the extras. If ruff is not installed it
> fails with the install command.
>=20
> tests/docs/linting.md documents the two modes and why src/ is held back
> for now. That file replaces the tests/docs/.gitkeep placeholder, which
> is no longer needed now that the directory has real content.
>=20
> .gitignore learns to ignore ruff's .ruff_cache/ directory.
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
>  .gitignore            |  3 +++
>  pyproject.toml        |  8 ++++++++
>  tests/docs/.gitkeep   |  0
>  tests/docs/linting.md | 39 +++++++++++++++++++++++++++++++++++
>  tests/run-tests.sh    | 47 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 97 insertions(+)
>  delete mode 100644 tests/docs/.gitkeep
>  create mode 100644 tests/docs/linting.md
>=20
> diff --git a/.gitignore b/.gitignore
> index 534c49538091..3c3cfb328fb0 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -6,3 +6,6 @@
>  # coverage data and reports
>  /.coverage
>  /htmlcov/
> +
> +# ruff cache
> +/.ruff_cache/
> diff --git a/pyproject.toml b/pyproject.toml
> index ece2757bb686..656adcd4930a 100644
> --- a/pyproject.toml
> +++ b/pyproject.toml
> @@ -26,6 +26,7 @@ tests =3D [
>      "pytest >=3D 7.0",
>      "coverage >=3D 7.0",
>      "pytest-cov >=3D 4.0",
> +    "ruff >=3D 0.5",

The latest ruff version is 0.15.20, it's had lots of breaking changes
since v0.5 in 2024. Be careful with Claude filling in dependency
versions, it often picks outdated or inappropriate versions to depend
on, always check them by hand.

>  ]
> =20
>  [project.scripts]
> @@ -50,3 +51,10 @@ path =3D "src/wic/cli.py"
>  # leftover files under the pytest base temp directory.
>  tmp_path_retention_policy =3D "failed"
>  tmp_path_retention_count  =3D 1
> +
> +[tool.ruff]
> +# For now only the test suite is actually linted (run-tests.sh
> +# --lint-tests passes the tests/ path); the wic source under src/ is
> +# not yet ruff-clean and is left out until its findings are fixed (see
> +# tests/docs/linting.md). --lint-src can still be run to preview the
> +# source findings, but it is reported, not enforced.
> diff --git a/tests/docs/.gitkeep b/tests/docs/.gitkeep
> deleted file mode 100644
> index e69de29bb2d1..000000000000
> diff --git a/tests/docs/linting.md b/tests/docs/linting.md
> new file mode 100644
> index 000000000000..71b4de21c100
> --- /dev/null
> +++ b/tests/docs/linting.md
> @@ -0,0 +1,39 @@
> +# Linting
> +
> +## Contents
> +
> +- [Running the linter](#running-the-linter)
> +- [tests/ must be clean](#tests-must-be-clean)
> +- [src/ is not linted yet](#src-is-not-linted-yet)
> +
> +The test suite is linted with [ruff](https://docs.astral.sh/ruff/). It
> +is configured in `pyproject.toml` (`[tool.ruff]`).
> +
> +## Running the linter
> +
> +The runner exposes ruff through two separate modes, each used on its
> +own:
> +
> +```bash
> +tests/run-tests.sh --lint-tests   # ruff over tests/
> +tests/run-tests.sh --lint-src     # ruff over src/ (preview only)
> +```
> +
> +A lint mode cannot be combined with coverage, with the other lint
> +mode, or with pytest arguments; the runner rejects such combinations.
> +
> +## tests/ must be clean
> +
> +Our own test code is held to a clean bar: `tests/run-tests.sh
> +--lint-tests` reports nothing. If you add a test that trips a rule, fix
> +the test before the change lands.
> +
> +## src/ is not linted yet
> +
> +`--lint-src` runs ruff over the wic source, but the source is **not**
> +yet ruff-clean, so its findings are a preview report rather than a
> +gate: the runner prints them and exits with ruff's status, but nothing
> +in the suite asserts on them. Treating `src/` findings as a hard
> +failure now would block every run on fixes that have not landed. Once
> +the source is cleaned up, `src/` can be promoted to the same clean bar
> +as `tests/`.

I am a bit concerned about a test suite needing its own docs directory.
Claude likes to write output I guess. But this level of detail is
unnecessary and is a pain to keep up-to-date with any changes in the
test suite.

You probably just need a top level TESTING.md file or something, with a
stripped down set of docs on running and authoring tests, any
assumptions that aren't documented in the test code, etc.

If you want to enforce that tests is kept clean of linter errors,
perhaps use pre-commit (https://pre-commit.com) to run the linter before
committing. This pairs well with using Claude for development as it
forces the AI agent to fix the errors before making a commit. If it's
automated, it also doesn't need documenting so much, just point at how
to enable pre-commit.

Best regards,

--=20
Paul Barker



--=-EOy7wrT9ru0/DPy6PQQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaktqFREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bhfRAP9hALeaA8EHrcs5lfsQ33OqpDBpGG59jubj
0kfomxjAJwD/TP4lLRkwG3iErtwh5NmFjumvnR9qDG+mgJUUjkpeOg8=
=G22M
-----END PGP SIGNATURE-----

--=-EOy7wrT9ru0/DPy6PQQ7--

