Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F1CC43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 09:06:34 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.147093.1783328788044996532
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 02:06:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=lJazozfo;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=AnRCg0M4;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 545A81D000E9
	for <yocto-patches@lists.yoctoproject.org>; Mon,  6 Jul 2026 05:06:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 05:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783328787; x=1783415187; bh=WM0SrC/4pA
	yRWlI4fgZYdMgc1d1g13S1ng4dP5HxxTM=; b=lJazozfo6GlwJXlmPxPgMUg6p5
	7/E4pDblS7HDLB8TK3l4PdgiqPIlOv81uFUtNAAU6hR1JEVfgPVXpICKypFtS1y9
	sZqxoNZ4ORLkwlQxCPsNq1N+/teYp4lk4IjYM6RMzgal9ok9WtrlmRgyXEbuPfLh
	sWl7bBxyihJVYyoP3bFAjzMQ8A59bXmcfkKUyfsEIB0YBw2H8fa937tCwbdUIzBg
	uF2GJ6UPBQlvRI7fbxuzgyVcioTPtPE7+MnfHn0gkulSGq4TL+t3jk2je5gZic8V
	ciWx4OlOTPQ+8xQhZzQYnu0ntsb9EsA4hfgdJ8peY62vk9VvYjVYx34uF2wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783328787; x=1783415187; bh=WM0SrC/4pAyRWlI4fgZYdMgc1d1g13S1ng4
	dP5HxxTM=; b=AnRCg0M40Cd/jD27oBZyuINC3J4VQmFuJ4//LkAtEZlISue9kYe
	sw1ZkUrKvXK0vY41fZqNSWWsMlILFCmjpcQ0n4jjeODe9FJAr/SQZRx8xUDlD9qj
	+9Qc5xpBxbgtzMBtSRiPnLxojGT1Qz3OFQy71oweRAvR5Syf0MIiOb7fSk7nSYrc
	o2hf5EjPAeD3S81K7FTZI0XLslhZDFMU5nuTFwYheXP7x4anZFoZ0sHYs0PqUnXI
	PMX1EcBoZmsZQ9r6eIQZ8vQOjg0vP/vrE2bX2F2LgYALENT8tzYPpNQXW2N4FWxm
	Mz9OPTHTLsiHZMyD+8tFipeDpvU5LIIXH9Q==
X-ME-Sender: <xms:EnBLah-8M23So9njrNC8uFWPgXeG66GcEO7H_RJc5vcUyQp_pfxPAQ>
    <xme:EnBLasoHP-9tn9mPgt1G059Bs6bbZTupSEGxr3vt8pGUY5eY_ErixFr3BYttR9Tl_
    zZ_MQx5IXKlEYe5-g5O2FH9k-g8-zXg8mHxeAaYwZDoNXUNbBKWq8I>
X-ME-Received: <xmr:EnBLako4MFVSVdJBtiqZ4ms9SWj8EpoHgFA8IDOZdxbvKXEgCGdI2e_Oi6LIlSlQYBG1xbxtcHNWzxHex_jlLb2ir5faq_lOciObvKmqk_FD>
X-ME-Proxy-Cause: dmFkZTE3Cs/hbpm7XiM9p4K56JxQRUN6ZUjQoq0YVJ5HpZx5YikR/LQsTU2lq2bXmKvqUU
    vW2yTIOdOx0KSHTwWMMdAaQRVhYLKICoq2O7dD+pxLb2GyWVw66LadyGtGU2KVvBKeWqWf
    DRYwWV+LlDqNhVC+J7Gz5SXONZ9Gcl2GaW2fjOBU6b6+Gg2h0yGpRn5Om0zisXEJlX1IQ1
    K/qH8L1+gFSUbrRa0QKCnLQGmZLSPhQS7jlCkUoK4yJZwTZQgkBJvu/ITc6BaiEh8eKC2E
    WTIO8EuzTx6mFngKBW/83r/2UcEpFJCmK4yt+eY1evz+SJRWmgjM1B0jxfqFQWGh82a0M1
    BVO5onL0lgfnMGAX5wj3fvdW13cNQKE0He4ku10vqaJkRKz/hu5Oiv0FNFaQcHRsFsmjg0
    hDiiY6sxzt+7WO6zMU6ArSje/+2b9o8HJDbJR6IGHqr4vQ0mhlb8aKBaZCnOSh5kIZSYf7
    yg/fSigEBnvJR6YJptmjwEJd9BrpzZUXXJBplcxOGve7gKhuFy0YDpvtk8WDGDsvB4zmX7
    eEBLavcWa5r+EGBpZP9vmVzKQVaLEAplSr2pxzi2HsswypKptXIdxAzJdnratshfi58BdP
    Xu7LeE1HhY4lqJvIPU/C9+o5jFojxiP7s9i+K99IytDkGd8AH3cwvxjkc8PQ
X-ME-Proxy: <xmx:EnBLaqn0xxB0leWAlkmxh_A46nQFYFz-cSl-8xKEZ24GnMgJ9f8c4Q>
    <xmx:EnBLamH344UDxHMuZp6I4d84StO9VkTApI6DDsX72ajxvJDlXzMwNw>
    <xmx:EnBLajpnaL8Qom5Hif2vYC0Fnrc8oMogCYJ_SA_Ap0YoRmncg4UOpw>
    <xmx:EnBLai4ZqdD3XR6sxl_MnE0xqCyiqJJOpDzSxO6QnPiUVHFe-MXVPA>
    <xmx:E3BLag8QLN8om2-N7YlLgeupO8QffK3Vy_hvfVWKvpmsWMEZqa4RpV3p>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Mon,
 6 Jul 2026 05:06:26 -0400 (EDT)
Message-ID: <a7ec7fe1de84a6159506b6ead5b99497e497bb24.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v3 09/10] tests/unit/test_bb_utils:
 test mkdirhier() and fix its missing errno import
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 06 Jul 2026 10:06:23 +0100
In-Reply-To: <20260701074030.1090807-10-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
	 <20260701074030.1090807-10-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-S6BrXksz3ZPQ3hY3KUf4"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 09:06:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4428


--=-S6BrXksz3ZPQ3hY3KUf4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 03:40 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> mkdirhier() wraps os.makedirs() and, on OSError, re-checks the error to
> decide whether to swallow a benign "already exists" race or re-raise:
>=20
>     except OSError as e:
>         if e.errno !=3D errno.EEXIST or not os.path.isdir(directory):
>             raise e
>=20
> but the module never imports errno. The reference to errno.EEXIST is
> only evaluated when os.makedirs() actually raises, so the defect is
> invisible on the happy path and on the unexpanded-${} guard. The moment
> a real OSError occurs -- a parent component that is a file, a permission
> error, anything -- the handler itself raises NameError: name 'errno' is
> not defined, masking the original error with a misleading one.
>=20
> The fix is a one-line import. With errno available the handler behaves
> as intended: an EEXIST on an existing directory is swallowed, while any
> other OSError (and an EEXIST whose path is not a directory) propagates
> unchanged.
>=20
> This commit adds tests/unit/test_bb_utils.py, covering mkdirhier() end
> to end:
>=20
>   - the happy path (nested, single-level, idempotent, existing dir);
>   - the unexpanded-${} guard (rejected, nothing created, and that a
>     bare brace without a dollar is allowed);
>   - the OSError handler: a real mkdir under a file component surfaces an
>     OSError, an arbitrary OSError propagates with its errno intact, an
>     EEXIST on an existing directory is swallowed, and an EEXIST on a
>     regular file propagates.
>=20
> The error-path tests fail with NameError without the import and pass
> with it, so the test and the fix belong together in this one change.
>=20
> AI-Generated: codex/claude-opus 4.8 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes in v3:
> - switch the tests from tempfile.mkdtemp() to pytest's tmp_path
>   fixture so each test's scratch directory is cleaned up instead of
>   leaking under /tmp; no change to what is tested.
> changes in v2:
> - v1 recorded this bug with an xfail marker in one large commit;
>   v2 drops the xfail, asserts the correct behaviour directly, and
>   lands the one-line errno-import fix in this same commit so the
>   test passes green.
> ---
>  src/wic/bb/utils.py         |   1 +
>  tests/unit/test_bb_utils.py | 116 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+)
>  create mode 100644 tests/unit/test_bb_utils.py
>=20
> diff --git a/src/wic/bb/utils.py b/src/wic/bb/utils.py
> index 3750056ba563..0b40dd0c1d59 100644
> --- a/src/wic/bb/utils.py
> +++ b/src/wic/bb/utils.py
> @@ -1,6 +1,7 @@
>  """
>  Minimal subset of BitBake's bb.utils used by standalone wic.
>  """
> +import errno
>  import os
> =20
>  # from bitbake/lib/bb/utils.py

Nitpick: It's better to fix the bug in a separate commit before the test
is added.

> diff --git a/tests/unit/test_bb_utils.py b/tests/unit/test_bb_utils.py
> new file mode 100644
> index 000000000000..aeca054109ff
> --- /dev/null
> +++ b/tests/unit/test_bb_utils.py
> @@ -0,0 +1,116 @@
> +r"""
> +Unit tests for wic.bb.utils -- a small standalone subset of BitBake's
> +bb.utils. mkdirhier() is a mkdir -p wrapper with two guards: an
> +unexpanded-${} check and an OSError handler that re-checks EEXIST.
> +"""

This doesn't need to be a raw string.

> +import errno
> +import os
> +import sys
> +import unittest.mock as mock
> +from pathlib import Path
> +
> +import pytest
> +
> +_SRC =3D Path(__file__).resolve().parent.parent.parent / "src"
> +if str(_SRC) not in sys.path:
> +    sys.path.insert(0, str(_SRC))
> +
> +from wic.bb.utils import mkdirhier
> +
> +
> +# ----------------------------------------------------------------------=
-----
> +# Happy path
> +# ----------------------------------------------------------------------=
-----
> +
> +class TestMkdirhierHappyPath:
> +    def test_creates_nested_directory(self, tmp_path):
> +        target =3D os.path.join(str(tmp_path), "a", "b", "c")
> +        mkdirhier(target)
> +        assert os.path.isdir(target)
> +
> +    def test_idempotent_on_existing_directory(self, tmp_path):
> +        target =3D os.path.join(str(tmp_path), "x")
> +        mkdirhier(target)
> +        # Second call must not raise (exist_ok=3DTrue).
> +        mkdirhier(target)
> +        assert os.path.isdir(target)
> +
> +    def test_single_level(self, tmp_path):
> +        target =3D os.path.join(str(tmp_path), "single")
> +        mkdirhier(target)
> +        assert os.path.isdir(target)
> +
> +    def test_existing_root_directory(self, tmp_path):
> +        # An already-existing directory (the tmpdir itself) is a no-op.
> +        mkdirhier(str(tmp_path))
> +        assert os.path.isdir(str(tmp_path))

Are we testing mkdirhier() or testing Python's os.makedirs()
implementation?

There's no need to re-test Python's standard library. We only need to
test the functionality we add in mkdirhier(), and probably a single
basic "can it create a directory" test.

> +
> +
> +# ----------------------------------------------------------------------=
-----
> +# Unexpanded bitbake-variable guard
> +# ----------------------------------------------------------------------=
-----
> +
> +class TestMkdirhierUnexpandedVar:
> +    def test_unexpanded_var_rejected(self):
> +        with pytest.raises(Exception) as ei:
> +            mkdirhier("/tmp/${WORKDIR}/x")
> +        assert "unexpanded bitbake variable" in str(ei.value)
> +
> +    def test_unexpanded_var_not_created(self, tmp_path):
> +        bad =3D os.path.join(str(tmp_path), "${VAR}", "sub")
> +        with pytest.raises(Exception):
> +            mkdirhier(bad)
> +        # Nothing should have been created.
> +        assert not os.path.exists(os.path.join(str(tmp_path), "${VAR}"))

This assert could be merged into the previous test.

> +
> +    def test_brace_without_dollar_is_allowed(self, tmp_path):
> +        # Only the literal '${' marker triggers the guard; a bare '{' is=
 a
> +        # legal (if unusual) directory name.
> +        target =3D os.path.join(str(tmp_path), "plain{brace")
> +        mkdirhier(target)
> +        assert os.path.isdir(target)
> +
> +
> +# ----------------------------------------------------------------------=
-----
> +# OSError handler
> +# ----------------------------------------------------------------------=
-----
> +
> +class TestMkdirhierErrorPath:
> +    def test_oserror_under_a_file_component(self, tmp_path):
> +        # Create a regular file, then try to mkdir a subdir *under* it. =
On
> +        # Linux os.makedirs raises NotADirectoryError (an OSError subcla=
ss);
> +        # the handler must let it surface rather than swallow it.
> +        f =3D os.path.join(str(tmp_path), "afile")
> +        Path(f).write_text("x")
> +        target =3D os.path.join(f, "sub")
> +        with pytest.raises(OSError):
> +            mkdirhier(target)
> +
> +    def test_generic_oserror_propagates(self):
> +        # An arbitrary OSError (EACCES !=3D EEXIST) must propagate uncha=
nged.
> +        err =3D OSError()
> +        err.errno =3D errno.EACCES
> +        with mock.patch("wic.bb.utils.os.makedirs", side_effect=3Derr):
> +            with pytest.raises(OSError) as ei:
> +                mkdirhier("/whatever/path")
> +        assert ei.value.errno =3D=3D errno.EACCES
> +
> +    def test_eexist_on_existing_dir_is_swallowed(self, tmp_path):
> +        # An EEXIST OSError on a path that is already a directory is the
> +        # benign race the handler exists to absorb; it must not propagat=
e.
> +        err =3D OSError()
> +        err.errno =3D errno.EEXIST
> +        with mock.patch("wic.bb.utils.os.makedirs", side_effect=3Derr):
> +            mkdirhier(str(tmp_path))  # exists and is a dir -> swallowed=
, no raise
> +
> +    def test_eexist_on_existing_file_propagates(self, tmp_path):
> +        # EEXIST but the path is a regular file, not a directory: the
> +        # handler's isdir() re-check fails, so the error must propagate.
> +        f =3D os.path.join(str(tmp_path), "afile")
> +        Path(f).write_text("x")
> +        err =3D OSError()
> +        err.errno =3D errno.EEXIST
> +        with mock.patch("wic.bb.utils.os.makedirs", side_effect=3Derr):
> +            with pytest.raises(OSError) as ei:
> +                mkdirhier(f)
> +        assert ei.value.errno =3D=3D errno.EEXIST

Claude loves to write test cases like this, that test specific little
details of the current implementation. This needs to be re-framed, test
the expected behaviour not the implementation details.

And to take a step back - if mkdirhier() is imported from bitbake, why
add test cases here anyway? If bitbake is missing test coverage then
it's better to add it there and plan to keep src/wic/bb in sync with
any future changes in bitbake.

Best regards,

--=20
Paul Barker


--=-S6BrXksz3ZPQ3hY3KUf4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaktwEBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0br3GAP4+oWrXz16/z9FOmhfeUgSG+DpTfqSA4rhs
aU41buyvMAEA2yqCpUaAavEbDc+L2nNvO9s/f4zaU+fb+x0SX2B22QY=
=GMOb
-----END PGP SIGNATURE-----

--=-S6BrXksz3ZPQ3hY3KUf4--

