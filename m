Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0AEC43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 08:48:03 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.145941.1783327680667867783
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 01:48:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=k7JzCD9j;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=FPG9ojla;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D0B801D00109
	for <yocto-patches@lists.yoctoproject.org>; Mon,  6 Jul 2026 04:47:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 04:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783327679; x=1783414079; bh=LKU86n0epM
	6gdi53AEGRZdUWrlVMx0VcuOocEPWnpu0=; b=k7JzCD9jA+SsErs0YY8Hm+ECFz
	dHGizkQe7AaFIRw6qYaSX3aIdaF5lol3+o/pkN6GvRybthC0D2xpraawJnvzHPDK
	yVKEmJ25BVEbmlczDfZDFVRfp/RwHOMN5O1mWR4wY1PV/qxdCXV326Hij6i52gPK
	apMGh1MPiGSfA6Oip1XyrYF3ToRC4tXBm3XGCW1mScvKFQRtG4ElD5VNs1JEFyX1
	kO2p7Sk7fq2b+ksSXbTAynFfBlh0H1WSnn4hOEPAcYkB9eY5k94hQsCiy6OsAvGa
	TaoJylobnFQq4YqoKs9+0csasgSyIVZJ0X3AUplx4UWNlK5mofRJg6vTFOzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783327679; x=1783414079; bh=LKU86n0epM6gdi53AEGRZdUWrlVMx0VcuOo
	cEPWnpu0=; b=FPG9ojlaCnUrpYG0YWdSJVBuf7xC/q5gnQpd2CaX2c8UZRys9F0
	ttnR60UkTbNJvpnEGKqQDJiQXGt8Gvk9tr1VMhj2YRGYT9jYr5GcnZa4cJ+8r9Wm
	Rg54iWnZ6XJcALL14nFMET12d4880z4v7Nmqr+tIbKkU/62Dzt/HdqUv6Yj6ar93
	5IKkZyKyQI4EK7YBXPJnQxy55R8W2HGCSCccqM8g7dUGYklMr435oriNpvufZDSe
	8IOh0qcy+ssuGLD/qYIxUiwvzuG//hmeD/Nz6PmDwnPP8Qo08NCdoNbQZDUruMFg
	/SCO9KMWBSp6EHCoomvRyQ+7ucNjLCgPrnQ==
X-ME-Sender: <xms:v2tLavYTr5gE-7WLVvakuO3GumaWfRU3VVMHPtM7l8ZnMTX1mCbcug>
    <xme:v2tLalWY4q_FoxqF_0aacv9S2bsC5EHv-wkv57vOuYzyneCKee2Ctpnxwt-8JLhVc
    R3-ud_eq46WM4DfQGeGY-lyJF0cerNkA45Ft08oV0HxDCivwee1bfI>
X-ME-Received: <xmr:v2tLanml1RhGOrLQRDkMlhCCcq_mqaTnqzJpuuGeb67llIg6uQOmvg1HWNpNG7CQaeN4RLAdrnvXgZQwDkdl2vcX2KXuNPAYbmhP85Db14xG>
X-ME-Proxy-Cause: dmFkZTGzMRK75/pBMFU3s0mCyWbW6Cvd+qy5l/kVgxIIRR8mhsfCONS1/WP2gpkt9Eh2vn
    gQdmVT0+SEEFdr+nhZT7wLuDq6DKkFwOb3O1ycEBtNzctWMAAmGIpORsdDuJfMcn9mspag
    cj3PchZWM2gMGrjEK9d1ycylIIkKTeRjhPvo6cEneV6ZTTtkyvbzpV/loxdWntw5//1vBv
    QF6KbpDvPj6SCb80r286ZkcHcZfTcIYn+0+tf/VAP4z1k8Hz61kNDi28mWNSLqARpEu50W
    rYisD3SfgNb1DYvjbzXxFOuOvE4cjWpaQ0yLpQVeu9zRDn2lwSIM82/22qHr8fqTgg5Ij2
    1NTBRa92tPVucEn4ieXGh7lNC0t8SOPGoo0gm31AbnB8mkIIyB07VCDVSY3hbUkC/XoDsl
    JGjWECNdp/hMJW4kdZLpTQe4XvN97A2lly/O5pFI0JU4E1JIiKWZz4j30XQMUW2lXA+lo+
    WS5q+dmL+HguClC0pKC6fA5DCvxrZ5WE60mnLR4hsD6qgzKVl64Gdc7OeAYBQ2GaG5DVbP
    d2tx/Pek9F9ZJb5t09RAg4CWUhQtccS2n++awBiYrW7tzqnuoNYuIBvYYbX8kadMjOi7a1
    fnDJvuDZ7lzOh3YFZBskCtIz2AXDhQcgUC/SRN0Th+g4gXDyQgEnW8MxCKLQ
X-ME-Proxy: <xmx:v2tLaqyro2dgPessW6UtmVS3tsvZxSC6K-FH6I_qN0pomEVeQMkPeA>
    <xmx:v2tLaqiVoTi9PidnmHzmz6ZnlC27OOSaOjKwk0pj1pigrduoe5Ozkw>
    <xmx:v2tLanWVzLHDmxGngTzwSmc-ZtQrqchYGGyWp7WJFZI8lFIGejlbug>
    <xmx:v2tLak3KPc8a5Nq09hkWqfeUQX8LbLDTCq_mZFw6rOFJMsIkm8LbMw>
    <xmx:v2tLagLHJtkRxV0vuZsglN_KhPh7FFXTLR0v87SjDONHW7IN9-f5zQjB>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Mon,
 6 Jul 2026 04:47:59 -0400 (EDT)
Message-ID: <a316bc47ab2995baded805031b72366f2adcc66e.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v3 06/10] tests/docs: add the suite
 overview README
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 06 Jul 2026 09:47:56 +0100
In-Reply-To: <20260701074030.1090807-7-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
	 <20260701074030.1090807-7-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-qG0jjxwA67hHKtKfkxS1"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 08:48:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4425


--=-qG0jjxwA67hHKtKfkxS1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 03:40 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> The test suite needs a front door: a short document that says what the
> suite is, how it is laid out, and how to run it. This commit adds
> tests/docs/README.md to be that overview.
>=20
> The README covers:
>=20
>   - the layout of tests/, file by file;
>   - that the suite is unit-only and needs no host tools or build
>     environment, so it runs from a plain checkout;
>   - how to install the test extras and invoke run-tests.sh, pointing at
>     run-tests.sh --help as the authoritative, always-current list of
>     options rather than duplicating them here where they would drift;
>   - that anything run-tests.sh does not recognise is passed through to
>     pytest;
>   - a pointer to linting.md for how ruff is applied;
>   - a small table of the other documents under tests/docs/.
>=20
> It deliberately does not enumerate every run-tests.sh option, since the
> runner is expected to grow more of them; the table and the --help
> output stay the source of truth.
>=20
> AI-Generated: codex/claude-opus 4.7 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes in v3:
> - document the standard pytest scratch-directory mechanisms
>   (TMPDIR and --basetemp) in the suite README, so there is no need
>   for a custom temporary-directory variable.
> changes in v2:
> - v1 submitted the entire test suite as a single commit; v2 breaks
>   the work into a reviewable series, and this patch is one step of it.
> ---
>  tests/docs/README.md | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 tests/docs/README.md
>=20
> diff --git a/tests/docs/README.md b/tests/docs/README.md
> new file mode 100644
> index 000000000000..ba7bd5e192a3
> --- /dev/null
> +++ b/tests/docs/README.md
> @@ -0,0 +1,82 @@
> +# wic test suite
> +
> +A standalone test suite for the wic source tree. It runs from a plain
> +checkout with nothing but `pytest` -- no bitbake, no OpenEmbedded
> +build, and no target image -- so wic's logic can be exercised and kept
> +stable as the code changes.
> +
> +## Contents
> +
> +- [Layout](#layout)
> +- [Running](#running)
> +- [Linting](#linting)
> +- [Documentation](#documentation)

A table of contents like this will easily fall out of sync with the rest
of the file. Claude likes to generate them, but it doesn't always
remember to update them. I don't think it's needed for such a small
file. If you think it's worth keeping, use something like md-toc
(https://github.com/frnmst/md-toc) and integrate it with pre-commit.

> +
> +## Layout
> +
> +```
> +tests/
> +  conftest.py        session banner describing the run
> +  run-tests.sh       wrapper for running the suite
> +  unit/              unit tests that import wic modules directly
> +  docs/              this documentation
> +```
> +
> +The suite is unit-only: every test under `tests/unit/` imports a wic
> +module in-process and asserts on its behaviour, so none of it needs
> +host tools or a build environment.
> +
> +## Running
> +
> +Install wic with its test extras, then run the suite:
> +
> +```bash
> +pip install -e ".[tests]"
> +tests/run-tests.sh
> +```
> +
> +`run-tests.sh` works from anywhere in the checkout. It can also report
> +branch coverage of the wic source; run `tests/run-tests.sh --help` for
> +the current list of options.
> +
> +Anything `run-tests.sh` does not recognise is handed straight to
> +pytest, so the whole pytest command line is available:
> +
> +```bash
> +tests/run-tests.sh -k filemap -v          # one area, verbose
> +tests/run-tests.sh tests/unit             # a single tier or file
> +```
> +
> +## Scratch files
> +
> +Tests that need scratch space use pytest's `tmp_path` fixture, so there
> +is no wic-specific temporary-directory setting. Scratch directories are
> +created under pytest's base temporary directory and cleaned up according
> +to the retention policy in `pyproject.toml` (a passing test's directory
> +is removed, a failing one is kept).
> +
> +By default pytest roots that base directory at the system temporary
> +directory (usually `/tmp`). If that fills up, or you want the scratch
> +files somewhere else, use the standard pytest mechanisms rather than a
> +custom variable. Both are passed straight through by `run-tests.sh`:
> +
> +```bash
> +TMPDIR=3D/path/to/scratch tests/run-tests.sh   # honoured by pytest
> +tests/run-tests.sh --basetemp=3D/path/to/scratch
> +```
> +
> +`--basetemp` puts everything under the given directory and clears it at
> +the start of each run; `TMPDIR` keeps the last few sessions there.

Claude loves to write! You can just say that pytest's tmp_path fixture
is used and link to its docs
(https://docs.pytest.org/en/stable/how-to/tmp_path.html#the-tmp-path-fixtur=
e).

> +
> +## Linting
> +
> +The test suite is linted with ruff and is held to a clean bar. See
> +[linting.md](linting.md) for the lint modes and how the source tree is
> +treated.
> +
> +## Documentation
> +
> +| File | Content |
> +|------|---------|
> +| [authoring.md](authoring.md) | How to add a unit test to the suite |
> +| [linting.md](linting.md)     | How ruff is used on the suite |

Tables like this add very little value and fall out-of-sync quickly.

Best regards,

--=20
Paul Barker


--=-qG0jjxwA67hHKtKfkxS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaktrvBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bkKHAQCi/9Ua7CnIJtZzJLqaeIQZJP9yuM6dR2yx
8OuVWgJbyAD/X8QrFFW/DTDpOhi6s3MbMtKDF1CvD4/5NrC2h8d+aAk=
=xlDM
-----END PGP SIGNATURE-----

--=-qG0jjxwA67hHKtKfkxS1--

