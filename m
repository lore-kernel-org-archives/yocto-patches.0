Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0D1C44500
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 08:33:33 +0000 (UTC)
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.145765.1783326808421429396
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 01:33:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=BpUbF3cy;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=QLCAshVg;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A03D77A0009
	for <yocto-patches@lists.yoctoproject.org>; Mon,  6 Jul 2026 04:33:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 04:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783326807; x=1783413207; bh=RhZq6pygxg
	++fdzUSS413VPrxN2OaFYmdU5kOCe7mMw=; b=BpUbF3cyy6eq/VqhAVQA8P7jE5
	Vo5Pkuwm4eAZHCFUPlUhuxKnyi2jxWTgY7b4j9rjZlJrQlcQWMstRg0we9EW1Rlr
	8CY1FzwpwiPO34nt+OS8TWVO+AAg3tp2Zdoz74YG6LS5ytfy2RXtln5CKXJUFKsC
	rFOdirqISSRLBFSWzCStvUvlUVyIAqEU44rzmMnAfpMcT2JDUQ+nrsYdQkkBuhqx
	PDkxYPDsjNvmLtya0zKnFH/jJCAMpVvu6YInLkG/8vwOIU31YYZIBt+9Le7bly+J
	KOwDWoPkuWoZ4F/SsPan0l/gayDBjsnjLu+YPXjTIB3gsh1bfegn/H0IPIAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783326807; x=1783413207; bh=RhZq6pygxg++fdzUSS413VPrxN2OaFYmdU5
	kOCe7mMw=; b=QLCAshVgTS4Tp8rya7HRXoByjr/zyq+Xg0SthvJl7/Pb8b3D9uP
	VeMAwF9Xpry/ICSzrvOBWDF0rtUWd5VJktmloIHqZvJ3CYxmSUbPfxFDfdMG6WUo
	XKzfiMllJfk7P95+XQauy5DVnX03oTwncvtqEK3A+dXZuAwK+Q98L5jBI/I8iCEf
	SC30FB9zke+mUkgRxvKAk3K00UViMBlM+g+tuZlrPgHVGkT5VNVVIQHlIHd3oSaV
	sEAykhB8eeDdtPam/I+esUAy0zI1k+NF2NglPaJOrh7LvE0O6oHZ2uC9i3SM4kyG
	Ry4UbF+Ut3gbZDLKu5/V1gKh2HXFAQTaMjw==
X-ME-Sender: <xms:V2hLasvW9Ip6PnlsgNfTNwnaBgt1C9KT3H1brfYX5cX2xM7dDTDTIg>
    <xme:V2hLagbr_dbfuAEWQ0t3Wp3MW2oPcVYflu34LP_66nrwD9rCtnIlm2iY1T5knkTdd
    Y1ldaNJ3-lzWHDKJlrR7KKj5zxvKYgx_dEjYsVCVkK5yxR0jxAnSdE>
X-ME-Received: <xmr:V2hLatbg7gTKpkT5DfemrdSvMPw5xebt7P4lo98_rcA_RA-F0P_0gceQuCONC_Ack3_RsTcbs4wn8Lj8hRRNhJzX4W1aWitSjJ2Dn2KwEC9F>
X-ME-Proxy-Cause: dmFkZTFs6uRcQVju9zBkjqMG0XBhIfF52kFTapzBjFQp0NPjy2dYYQNwWCFNUXIwr//Tw/
    O/DKoWE63eoKjkBzX5vfFqGsqwyfn1jBAj068QJsHuUk8BBUl6X/zwQB9D7FXqRsu4nCgI
    G3SeMKouE3rJGGH7DTKWZ/isiaY9GrfaApnMQMLGLq2AhNQNPTXrXlRL2qaNoCKZmK+0NF
    SXMYoiAq9CVD3pYTD5d0YeqDiGw+j55F69Mre0WG1GJhbIEF86osteHzjTh4N1N2o94jzA
    KBj9rSBIpw1dLeqK8JJQonr/a3H96GQ8qJ6DKXzJ9X7nK6or/WnCbJnkp9Oeha90UTHFbm
    gvwCHcWQc9LNzBNDpE/V9/KFmGUldQp9vehPhX5LIwweWWrsFvIeTrnOQqoE4gcHObAcF5
    q6qf5cYcj5v5InyNX18pKIaqaOQLPNx+rfhjHwcd9Uv9ghWBJL4KCmICj1M/YidQlVu4Ml
    UVstyYFVl/ypOOjKCupP35JLdjrrbwlV467cXqVUCuDts3K4CJ3nZ3zQt08I6jtUsXf1W6
    FzhpZerCehhEjOA/AbfaCn0fPV0HNynKKl1GcZUX2Q7Amvig4fQero+XyNfe7TaJdr770B
    emUozqVtWnE9glYW/8wW67F8auNXNFPMNpDeUWffDUyoKPEyGjF+ma4uHM8g
X-ME-Proxy: <xmx:V2hLakWAc_mSmIrz68rWn8rsvgwD0KavKbJNGtzJJ43tFzmwU0viQg>
    <xmx:V2hLas2QLLIdRvwRxrpXfDjIUANJ98Y05TUyONllco_WXQ02T9oBjA>
    <xmx:V2hLajbCuOuGeletfU2tv_HfBvPuimlDOUF8pfOISWxKiI7yCAJ9EA>
    <xmx:V2hLano-7kjOr6lmUWjFXmLmauZQdS7_eLw7k25K_p3Z35NOp0rFXg>
    <xmx:V2hLamtI_IJp_8K2c8Mj8SE1iAGaEJHXbUGu_GfjLGDEsUIlWmmWfAvh>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Mon,
 6 Jul 2026 04:33:26 -0400 (EDT)
Message-ID: <e450e25f5d0b9f31564d9b559fbc03d034e83274.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v3 04/10] tests: add optional
 coverage reporting to run-tests.sh
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 06 Jul 2026 09:33:24 +0100
In-Reply-To: <20260701074030.1090807-5-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
	 <20260701074030.1090807-5-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-9gH+Yvax4Mga4Ud81g+1"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 08:33:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4423


--=-9gH+Yvax4Mga4Ud81g+1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 03:40 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> Knowing which lines a test run actually exercised is the difference
> between "the suite is green" and "the suite is green and we know what
> it touched". This commit wires branch coverage of the wic source into
> the runner, kept entirely opt-in so a plain run stays fast and quiet.
>=20
> pyproject.toml gains coverage and pytest-cov in the tests extra, so
> "pip install -e .[tests]" pulls in what the new flags need.
>=20
> run-tests.sh gains two options:
>=20
>   - --coverage measures branch coverage of src/wic during the run and
>     prints a terminal report listing the lines that were missed;
>=20
>   - --html [DIR] additionally writes a browsable HTML report (default
>     htmlcov/, or DIR if given) and implies --coverage.
>=20
> If --coverage is requested but pytest-cov is not installed the runner
> fails loudly with the install command rather than running without the
> measurement it was asked for.
>=20
> The coverage data file and the HTML report directory are build
> artifacts, so .gitignore learns to ignore .coverage and htmlcov/.
>=20
> AI-Generated: codex/claude-opus 4.7 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Ok, now the run-tests.sh script starts to make sense.

Have you considered something like `just`
(https://github.com/casey/just) as a command runner? It's much simpler
to maintain a `justfile` than a shell script.

Using claude (opus 4.8) to convert run-tests.sh (as it is at the end of
this series of patches) to a much simpler justfile, I get:

    # List the available recipes.
    default:
        @just --list

    # Run the test suite. Extra args pass through to pytest (e.g. `just tes=
t -k filemap`).
    test *args=3D"tests":
        pytest {{args}}

    # Run the suite with a terminal branch-coverage report for wic.
    coverage *args=3D"tests":
        pytest {{args}} --cov=3Dwic --cov-branch --cov-report=3Dterm-missin=
g

    # Run the suite with an HTML coverage report (default dir: htmlcov/).
    coverage-html dir=3D"htmlcov" *args=3D"tests":
        pytest {{args}} --cov=3Dwic --cov-branch --cov-report=3Dterm-missin=
g --cov-report=3Dhtml:{{dir}}

    # Lint the test suite; held to a clean bar, so this must report nothing=
.
    lint-tests:
        ruff check tests

    # Lint src/ (not yet ruff-clean, so this is a preview report, not a gat=
e).
    lint: lint-tests
        ruff check src

Feel free to keep the shell script if you want to, but I think the above
is easier to maintain :)

Best regards,

--=20
Paul Barker


--=-9gH+Yvax4Mga4Ud81g+1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaktoVBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bhBHAP9J/bmhRK0sQhwkoTnOwFXzc/n7l2aKWSJg
Wv3IcwZiwwD9EfnG33QgjOQMulMjhfPC1rsB3AeCkm8C9RdSDWZIfAo=
=+84/
-----END PGP SIGNATURE-----

--=-9gH+Yvax4Mga4Ud81g+1--

