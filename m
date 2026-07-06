Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C8BC43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 08:52:43 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.146953.1783327953874879935
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 01:52:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=qEmxA8H5;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=B+VFcpyT;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 607A51D0006E
	for <yocto-patches@lists.yoctoproject.org>; Mon,  6 Jul 2026 04:52:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 04:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783327953; x=1783414353; bh=bP6hqYwWLI
	t6d/V0tqM90LszrBqE9SoYjXCX8TfCQxE=; b=qEmxA8H5GmdCfqZYo+aHVzsEMB
	QgCO/gh5ifcWdzTgAg6SP2/cyJ6SWf/E2c2AfB/SpbmTjt1eEuActGJqHJqgcIzs
	XKp7u1tSgdzGQFQeVuUoTc796IBR1YCUezpv4R0I73UWs7kCUBNFOSsnu4Uz0fF6
	nFmYS7jwgVtVFjZ3k121ErGep/E8Z281F/tfyanDNBiXK1aEvLL7OcbUmokvR9TM
	xzL4/J/ewVo/PVJAIZBGlfI48KxFce3ldn74/71S1/fR8kHTxSmf2btzbyH1QnF3
	vjszCdC4l45/uAN9oS3CwMV7PzsXYYKpUnv6eh30Q1bTg9PtDA6gdnztpNOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783327953; x=1783414353; bh=bP6hqYwWLIt6d/V0tqM90LszrBqE9SoYjXC
	X8TfCQxE=; b=B+VFcpyTGLYsEh202DPsxSfimP2oXaRvfs6ddJJ82/XApALMdou
	9+FJvBT89T/VedKHquf9/7uw1XDj2Et6APmoRIlJAqnGVLgXijNvk1In5HCmORZL
	1ia+xAF6QS/Kd0pVl7PP2TzuUpQNG8g6atNYRHEWyphxovmwFylBe44DfaRGUoor
	7ia1J8jGJ2oiFyHTz7SvpEYD/j+6QcnNV9j90yzlMRvTTGrgvkjaM7VzrhSP/ZlH
	7omSMTJKwg8vRa7ij50Q8wet8F/n3uXmKYfxnZYkLvTDAIZBFrEwmK5QvZDoltO9
	embyH5KZdIspu4XC81Jj81aJI/DB4/zygIA==
X-ME-Sender: <xms:0WxLai9gldYWdLS1ATtE8Ey1Nzh1HghFJc8-4B0fBgiZeRoVPA5mgQ>
    <xme:0WxLappC-KUDUY-PP_gFFQmMC6BykfoI3JY9SipBoY0sa9CTJWKmjbYZqQpypOOpN
    j8j9UPVzWoiSR9dovsYHnpLtTFf20iz6NxiUSRzyF4W3GbAL7ZOn2R7>
X-ME-Received: <xmr:0WxLatoipSTG3OzAzsID7oUifsMzUUHaSnF_CK_Lwdz2Ob1bZiAayYP2uqNLanrJvC8xLe4d3QgCQGhGDRd24JsgyYUqO554t_tX7-4PvDjS>
X-ME-Proxy-Cause: dmFkZTE9YjwRtxWLDF1nrplCaBDWtn0flcfcI+ABe4rK5n4JFRBXhiV0FAfj4b8yYBiKle
    aPwchaz8c24L85Y34NZ/lZaGzAJ69v1YQwKpzOvlKzTfsPMAz3AkHexkU0QwkPSoaeYgNH
    tbMVBo3wRcLVUOI32XpSXqOnjb0Sf2HpDzAehdM1kChBtQ5WWkayi0kYd0bFWBmS68TIhH
    SWKSms2JkqNYPC9/YJfRCVdtC6vz8SAoNEQo/Lj4SZPb722GX6Qh5n7REI0fFwEPy0npqJ
    blUqfrfes4wo6QbV+SZhiE4TFUkt4NbiLj4u+RNL6HPP89babjp9J3QgnUDw7H509clIZ9
    MzAFjBqI4XQ+z2jk2hOIhIupB+lQeMW+SsOqT8UdrgehJJfcJMGKCB81v01GxiK2yuT0Yc
    toWR2KXlOcLVV+nQmR/ilXIy8v6TOVkfQzQXaZz1numk1KyqMSsHiPuh4reujJc2TJM+rO
    7YOVw39lCnnVxhOJ4SBZIx6sk+8/9RMv7ZXXZ8KZ516vv8diyVhKkgZU3wLtvWw0yhdJdE
    bUubWgnm8bQEDSroSjCWRULQAX6lVmc76WDBpGWMQjc6WOYIphN0ZVpekL41KshV0Lk6ct
    tw6+z/JBKVAdKYOsV6M3esOi9JEWRTRCwr/nhMZJUsfBc9Fygg+NNs/zuIog
X-ME-Proxy: <xmx:0WxLavkzDY1nhk9SOBYj4v8reERF91Riph5KGlmSEoVkSGEUthZ-ug>
    <xmx:0WxLanHMAWQtk-N6dR_m6iRt_fnSabP4YrzR6CLcc30WceRnbeBykA>
    <xmx:0WxLagp_SGoLrlxuqriHMQaY0BsP95Uu2Wwpga5vri34uzXoyTfjQg>
    <xmx:0WxLar4cODthm2rQ17suL-hXXjvT3vGfhvJ9OakvV4piHTfstcO8gg>
    <xmx:0WxLal-oBT6RKXMZfSf44ic1GneR6jz2CdrnfkwNXw00XVSwiHqy9ELL>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Mon,
 6 Jul 2026 04:52:32 -0400 (EDT)
Message-ID: <ffce31c5a7d7bc0ddd1a738f2e0aefe4081bc148.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v3 07/10] tests/docs: add the
 test-authoring guide
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 06 Jul 2026 09:52:30 +0100
In-Reply-To: <20260701074030.1090807-8-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
	 <20260701074030.1090807-8-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-/1eVdLjaWWUaKEhcvQX8"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 08:52:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4426


--=-/1eVdLjaWWUaKEhcvQX8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 03:40 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> A suite is only as good as the tests added to it over time, so it needs
> a guide that says where a new test goes, what one looks like, and how
> to choose its inputs and assertions. This commit adds
> tests/docs/authoring.md.
>=20
> The guide covers:
>=20
>   - where a test goes: one test_<area>.py per wic module under
>     tests/unit/, extending an existing file or starting a new one;
>=20
>   - the shape of a test: a small worked example, a preference for
>     parametrize over in-test loops so each input/output pair is its own
>     named case, and use of the tmp_path fixture for scratch files;
>=20
>   - asserting the correct behaviour rather than whatever wic currently
>     does, so a test never bakes in a bug; when a test exposes a defect,
>     the source fix lands in the same change so the test passes;
>=20
>   - probing the boundaries: a checklist of input classes worth covering
>     for numbers, strings, paths, types/shape, and state, each asserting
>     a specific value or exception rather than merely "it did not
>     crash";
>=20
>   - keeping the assertion strong: never weaken an assertion to get
>     green;
>=20
>   - how to run just the test you wrote, with and without coverage.
>=20
> AI-Generated: codex/claude-opus 4.7 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Is this here to help human test authors, or to help Claude? A lot of it
seems very generic, e.g. suggesting which boundaries to test is not
specific to wic.

If it's to guide the AI agent, then say that explicitly and reference it
from a top-level AGENTS.md file. I'm not a big fan of this stuff
littering repositories, but if you're going to be using AI code
generation heavily then if may be needed.

> ---
> changes in v3:
> - no change in this revision.
> changes in v2:
> - v1 submitted the entire test suite as a single commit; v2 breaks
>   the work into a reviewable series, and this patch is one step of it.
> ---
>  tests/docs/authoring.md | 124 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 tests/docs/authoring.md
>=20
> diff --git a/tests/docs/authoring.md b/tests/docs/authoring.md
> new file mode 100644
> index 000000000000..c60cceb2d32d
> --- /dev/null
> +++ b/tests/docs/authoring.md
> @@ -0,0 +1,124 @@
> +# Authoring a unit test
> +
> +Unit tests live under `tests/unit/`, one module per area of wic, named
> +`test_<area>.py`. They import the wic module under test directly and
> +run in-process, so they need no host tools and no build environment.
> +
> +## Contents
> +
> +- [Where a test goes](#where-a-test-goes)
> +- [Shape of a test](#shape-of-a-test)
> +- [Assert the correct behaviour](#assert-the-correct-behaviour)
> +- [Probe the boundaries](#probe-the-boundaries)
> +- [Keep the assertion strong](#keep-the-assertion-strong)
> +- [Running what you wrote](#running-what-you-wrote)
> +
> +## Where a test goes
> +
> +Group tests by the wic module they exercise, one `test_<area>.py` per
> +module. Start a new file when you begin covering a module that has no
> +file yet; otherwise extend the existing one.
> +
> +## Shape of a test
> +
> +```python
> +import pytest
> +
> +from wic.ksparser import sizetype
> +
> +
> +class TestSizetype:
> +    # sizetype(default, size_in_bytes=3DFalse) returns a parser f(arg);
> +    # with default "M", a bare number is read as mebibytes-in-KiB.
> +    def test_plain_value_uses_default_unit(self):
> +        parse =3D sizetype("M")
> +        assert parse("100") =3D=3D 100 * 1024
> +
> +    @pytest.mark.parametrize("arg,expected", [
> +        ("1K", 1),
> +        ("1G", 1 * 1024 * 1024),
> +        ("0", 0),
> +    ])
> +    def test_suffixes(self, arg, expected):
> +        assert sizetype("M")(arg) =3D=3D expected
> +```
> +
> +Prefer `@pytest.mark.parametrize` to express each input/output pair as
> +its own case rather than looping inside one test, so a single bad
> +value shows up as one named failure.
> +
> +Use `pytest`'s `tmp_path` fixture for any scratch files; a passing
> +test's scratch directory is removed automatically (see the retention
> +policy in `pyproject.toml`), and a failing one is kept for inspection.
> +
> +## Assert the correct behaviour
> +
> +Every assertion states the behaviour wic is *expected* to provide,
> +never the behaviour it currently happens to have. A test that locks in
> +a wrong result is worse than no test: it gives false confidence and it
> +turns red exactly when someone repairs the code.
> +
> +When a test exposes a defect, the fix to the wic source lands in the
> +same change as the test, so the test asserts the correct behaviour and
> +passes. Do not commit a test that asserts a known-wrong result.
> +
> +Wrong -- bakes in the bug:
> +
> +```python
> +# value lost its comma; asserting the broken output
> +assert result["file"] =3D=3D "s3://bucket/a"
> +```
> +
> +Right -- asserts the correct output (and the fix lands with it):
> +
> +```python
> +assert result["file"] =3D=3D "s3://bucket/a,b.img"
> +```
> +
> +## Probe the boundaries
> +
> +For a parameter, probe the boundary and just past it rather than only
> +the comfortable middle of its range. The classes worth covering:
> +
> +- numbers: empty, zero, negative, the maximum and one beyond it,
> +  non-power-of-two and non-multiple-of-1024/1000 values, primes,
> +  fractional values where an integer is assumed, `0` versus `0.0`
> +  versus `"0"`, off-by-one at a block or sector boundary, and very
> +  large magnitudes near `2**31` and `2**63`
> +- strings: the empty string, whitespace only, embedded spaces, tabs,
> +  newlines and CRLF endings, non-ASCII characters, shell
> +  metacharacters in a value that becomes part of a command line,
> +  leading-dash values that look like options, over-delimited or
> +  malformed forms (stray commas, doubled or missing separators), and
> +  very long values
> +- paths: traversal (`../`), doubled slashes, a trailing slash or its
> +  absence, `.` and `..` components, broken or looping symlinks, and a
> +  non-existent path
> +- types and shape: each wrong type the parameter might receive (a
> +  string where an integer is expected, a list where a string is
> +  expected, `None`, and so on), the wrong argument count, and
> +  duplicate keys or entries
> +- state: a second call that must not see stale cached data, a
> +  `cache=3DFalse` path that must evict, calling an operation twice, and
> +  finalising a half-constructed object
> +
> +Each case asserts a specific outcome -- an exact value, or a specific
> +exception -- rather than merely "it did not crash." A test that only
> +checks for the absence of an exception will pass against badly wrong
> +output.
> +
> +## Keep the assertion strong
> +
> +If a test is hard to make pass, the answer is in the code or in
> +understanding the correct behaviour, never in weakening the assertion
> +to something vague enough to pass. Loosening an assertion to get green
> +is how a suite quietly stops catching regressions.
> +
> +## Running what you wrote
> +
> +```bash
> +tests/run-tests.sh tests/unit/test_<area>.py -v
> +tests/run-tests.sh --coverage tests/unit/test_<area>.py
> +```
> +
> +A new test should leave the suite green, with zero failures.

--=20
Paul Barker


--=-/1eVdLjaWWUaKEhcvQX8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaktszhEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bsxyAQDrPdoiGs4+mxO1TPFALuUDDDVUOb0AqYau
UCXyqCa9RAEAqpIvyd050z0vivNm95C3DybvxpQyhmt+AV+0k4QgugY=
=wNrb
-----END PGP SIGNATURE-----

--=-/1eVdLjaWWUaKEhcvQX8--

