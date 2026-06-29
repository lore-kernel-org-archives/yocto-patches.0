Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF69C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 08:06:54 +0000 (UTC)
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87436.1782720413497671975
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jun 2026 01:06:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=i0lAl3zE;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=QINGRH9Q;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E3137A0097;
	Mon, 29 Jun 2026 04:06:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 04:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782720412; x=1782806812; bh=fEdyNangHF
	j4W+D5kll5z9iaSxScWgF72KaZqa0TqZ8=; b=i0lAl3zEBQomgJPR9JCsvhvry9
	JUo5FfR56ExrBMdg3qOqSMqqRUKvVwfhc7X4ud/fQAj2FCEQwtlp8Rn+cuyq7URG
	XNTVN6e6p0+gDMjgdHUnCk4EUO6lQ6Graj67aEmIOew5gmTDf8OsP48FZliUj7LC
	oUzd01TyqEiSrEaAMW2mjC3ssqD4F1nb9kx/6QSoNlgN/ivd1dKrFqEvXQWQ9L27
	l2xLxFFLdGC5GYQCe6QMvY7NKe5D5WRMPlXbRNkFmnMChVyf6e+T7ne+adCSX4Rv
	GrvoQV8BIN/86gdW0b7hOPPeU4r3r8s/UhWXSyz5BeTg+87lHEec1KvNmxSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782720412; x=1782806812; bh=fEdyNangHFj4W+D5kll5z9iaSxScWgF72Ka
	Zqa0TqZ8=; b=QINGRH9Q2LZozrnEtk5ECA6B0brCS3cvCXnfHioVJ3Vxc7rTgMe
	PWBpAyRvmYriom/AakIAzODLFNFxzNSi90UFmg8BjC7HO9uXfyGcnwxPc4c9FFw2
	rzQbY7MF0kP3OwGpy/bE7pTXzWQeDEL7VDJoRcTnOMFS4KChMolzaXckfIU7V8go
	gw1TX6E/8ilYo8J7Ai0e7n96ZPNjkXG6ciPrPC7APU+IbBmVbS18bWgz6Xr/XCHf
	o6ZWM+DQB/6u35IqzIAwDXJBM2pcuICMW33inD6OcFioogi8GZ0rFK0sIWBVkNwB
	Npja0MNgKQRyzFu4MJh3Y3WzZisJfcGyEuw==
X-ME-Sender: <xms:nCdCarlpvI6HCpbXk1Y8FbqzO0rLr1UUwr5NoUO-sQGzNa5CtmE5Jw>
    <xme:nCdCak3ZVMr1bBq-LbcG5vjZXdAqjf-dRn-axdSRWxnq4O4H4i8x_pPkGM2Jc_HN6
    Cmvbz-Y0kKz18zoX16C5EzCkyrX52ByUi8KPINPW6de3hv2qeJqBRU>
X-ME-Received: <xmr:nCdCavSpoK7R7eWVlPN-tBU5VoRzlEu-2YbS_YIT7fcA5BxBfO9CpK62nZZl6mUmXfwt-1vVv0ekMRy4H5mUlvzc0tC9rlEmS8Og_nI>
X-ME-Proxy-Cause: dmFkZTEwz/fukhkmbcEBwp9qr/ZLPg/G84HfvdJ2v3U/9mmt4nxchPbt+nVkNryT2rWH/Z
    8/RZHU4LV/GGBWbFZicQ+cfg/Hhqvc6ouNWmvDptnnoIrQ0UDowL+sMZAfNgWAAIzJLen+
    Sp7/AXNxkn6sZwBc4o5B4imHKFNWw6502WQYSmj1cuDafqD42ezlXKu6TUsLA88wPYVl6H
    sJ2FjK9J5WnrO0navkb2q8RJ6PtRyRGqSSCtPZh21sfKKnljtMSKBHViRnsHioHruslW/I
    UvAD0jGaMAGYrvBVyVnwk7W5oMw974nmZ8nZUxGSy9YhEKmXY4+BZm3GQVWxanUZLg2pKs
    +V41MeGYRO9lGr5r/Ub4SFj4+03uZzaKWgo8Co1+rstWG/YFnpfsSWNVi84tNYCYCnNld0
    y91TJlXb2g2qfm1XJbHhxZu93WahAhw0rR5iZIqB9v+a048w6+P69t3JeoTuJokc14KWnT
    Gpt+bSdKWP5Jxkqjbp/+/6W+dPUuiypz8rpg9tsUYfpju8b/QE+ch234qj8aQyJ8iT5YnP
    o3LZLOpEclN8pdJKsD8ssp+JSAsBss0MIqWp1YcSMre5NLsPk0yg5I13RW4ZjWhbmYUVzh
    MIMHXzuuX5WlrZHlqhDovrt1SX9jt4/vuNhzJTXOk5gWjR1yJi7YcNUAK2OA
X-ME-Proxy: <xmx:nCdCauvd4x8TichBRGE0lh5jD1bgSTXKiX_sUCx0Yjgi2tVmOPX78g>
    <xmx:nCdCasYc0ZXBr-D_x7us65jZnP8Wb0nmKt2r-xbef9Lc3YF22juWmA>
    <xmx:nCdCarsPA4IatdGJw5jWM63a5JDCA78jK8IH__TPpf3KawAW7LPUDQ>
    <xmx:nCdCamFnaKHPaXblIPGGVK0zfCiB2eoFvwdzSLfLZluTAf8aT_m43w>
    <xmx:nCdCak2a94v1IkOFqV2jzkBhLtWvJ8v_9JcOtuivISV9GrmoRVlarUH0>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 04:06:51 -0400 (EDT)
Message-ID: <5c49955557d2dfaa2ebaa68a264e6745f3728eb3.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH] tests: add a standalone unit-test
 suite for wic's pure-Python logic
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com
Date: Mon, 29 Jun 2026 09:06:48 +0100
In-Reply-To: <20260626184533.417479-1-twoerner@gmail.com>
References: <20260626184533.417479-1-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=mQINBGC756sBEADXL6cawsZRrDvICz9Y1SG0/lW1me4xpq36obh7a0IGAzp3ywNRb/4MO
 DTqP4+DD0cIFuDY41/N17g0sNlp8z+/k/IIDmNPtYQOTVmAkrkdDU4BP8dD3Cp1PUw6nrbInfujAJ
 NrVM0IVDkwKTbL2Nu1P+xns4MIpF9Kj4XN5celYJ9vEJ2n0Bo0nO5T5vg46dihIaDl+24iNIHSsHq
 YyEdMBfY8kY2RulpaAyFOuaaHdIeDkejVvO5xLSiYLjB5qrRhgH134lJXsuLOsFQ64ybGECuOasnb
 auevsPBAaroQW0pqVb9FneGrWHxMCLlQHJRqQJRdVa6bsUdp6NWra8/0msPawSrFwGQdfJBTA3aXJ
 C2CG1JxEgj6QQjEQA49DSjgzdhInbiIK8Vbp/zedM4aVue7qJnwPMTFQM9lYx63b7wLN4Tu8B9YZ0
 UFdSwMCJuqmYGsYRUYdwM3ArjS0VO6WpU+HBKvzLK5GQfUTSM8KaZ5eA2Uo2ain8SSZb+WptUYKpx
 F9jbtCPbjpZKzGuX4iHFl9eT75TM9iXJNGAjB5xigkADLwVfPoJ5E53S+KdNVuOWHugyLMPNAQHOw
 pw5Rey+0zxyzPd4wphutc93UIU5g/029ngAc7DuKCq12jl7fhkjqFlFtYPIc1k7nd+RSezmH/qRes
 bMErHSX1MBSZQARAQABtB5QYXVsIEJhcmtlciA8cGF1bEBwYmFya2VyLmRldj6JAlcEEwEIAEECGw
 EFCwkIBwIGFQoJCAsCBBYCAwECHgECF4ACGQEWIQSYsqrBAKw/grtdVGd0l1yBt+ZrrAUCaWoNAgU
 JCxiQFgAKCRB0l1yBt+ZrrLhdD/sH+qTaxCDUg47eW329yJWCDZmO+iuYzNSyHMs1x0DHKNIQQ8zN
 pA2S/de4jElQuPHjw/IS8B3VmM62Wuq5vHuxNlFv9IMwrwqi6zhCDui8+nCN/AQGGXousJI/SeZjm
 Y5gS9cqh4vNY+huqEEfdTFXIfTBRkmnvYozSO2uDB3EMuiWgBlw2uLrtmkvPLn/m/GvEouLNox6wv
 tcJcIbL59a0+3jv/m7pnWoZXOkWmKQnfFWikqjuKCISNU0gzBSL4UOj8gtQ2z+vu7ffi29b6SV5IL
 m1yzdbkigEn4HL44lz3N+oHZ3wWsRqqeyGSX5fCfx3tGWg6scZQrpsjT5yq+LiffiXVNpjeJ9KzQw
 0cbAZ/9uhk1sWBroP+/gMhsWjlbFYXVlRvkNKGPI22eZtOEz4jF6OrOONyOoY3i26niJUyIgdBpca
 H0hKUSVQ8VnG7qVTNrQk9BbeoSszqRwViN7lfyVtK9b1TCFuGewOETGn0TPvSzruYCtD3CLm7mjuX
 AMBpIGoRUiCFVmF1hlOgqDyH4F6zRTHhKLpfmNzfQcg+Uo147Q2IHpoh0mJsL4FEZEI8hFyecX1Pq
 7HqnvxGD2OhCof1Z6LDxptX0wbgocnYFNxN5S1owcXZUQOFnzYLlLugrcEjlGCm4Gn7k4SiFERSBj
 UFsQgIhw/7lVVn4o4rQjUGF1bCBCYXJrZXIgPHBhdWxAcGF1bGJhcmtlci5tZS51az6JAlQEEwEIA
 D4CGwEFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSYsqrBAKw/grtdVGd0l1yBt+ZrrAUCaWoNAw
 UJCxiQFgAKCRB0l1yBt+ZrrHy+EADNMt+ewz8H7BUKpEMMhpaA1VxyXO5IqlKXS0gElMgHYXl7L7C
 0/qLfRH96vwVD33zM+f0Vl9aWWkom/k8s42tLyPvX7D5zTrj3r5muJ+d9dXWGwBFXxXlE9YjSP26K
 bYfRusmRHbbEPlLPSnrr9KYS2FGVD6ViRNhhVguflgPv2i18+fNBE3YyByfNCiQgO/SgaSdh172Ql
 tuYE1Chk6FD45tCUv3dI9lO2PlVwrciiVYvIv/jiTDEwZOISOClTE/Ha18pxDJfLhS8QQnLWuBNX6
 HUkLi78fVmVYbcWIkTuSHjfNoGTMaFijMg9Wl6poFrY++Pl0S40681zEIrwZhW5pKoqXoaElt29Yf
 OwVo6BIsSOLEqKiWsdP7PJTaJYU1ovnshBcOmuXMgc13AjQ4AhEGqI1TaEJ/E1jEDDyTQFeWgrfew
 YaWdqpgiDmRMTj/tIGVj9iy7qZQICUUtlfm0QK6w6M7qq0GdO2o+S3uVF6y2AxQo8l9LSHiW9O35I
 juR37zeqv72puYyOteVYJsJaw999HUmhXc/X/J9FQFw8twxPKDLLu+w8MqDo9bhllzR93Zy/OShuG
 yGybcX3DKO2R+AQ90tXLbxKmHLtrnG/zyDPhLv/LGD480v5hEoT+IS0u9wPD2vP5q36a5DtzqXA/7
 t9PCamLoCvZLleg7GY7QbUGF1bCBCYXJrZXIgPHBhdWxAcGJya3IudWs+iQJeBDABCgBIFiEEmLKq
 wQCsP4K7XVRndJdcgbfma6wFAmlqDRwqHSBwYnJrci51ayBkb21haW4gd2lsbCBiZSBhbGxvd2VkI
 HRvIGxhcHNlAAoJEHSXXIG35muspk0P/1G08N6zGSdw2p8+8f/1HhaYEb9KdQHT1JmQfZUrIHIpD2
 ELNb91Z6Pz197d/igGpox1dzYOwE0WolWo44ZHX2yw+p9V+HJAUKRe0SPc1iNLkTzaAZ7oYJ1DnFh
 aaqZi4VtKKabKeorJjcDvl2apMwT0agRuDklU97n++ZUuXIEo1Z9uRqEvXz0iTSY7wPxwfoVOQsgf
 dN1cBLd9OpoOtJRdDJzQUYqjNoQi+5M6KRfBxPLZkmYb4uCGlp1H4AV50eC61j84LBg1ItvU2u+Fx
 X2JB7lHTswubprD2ZsSwp1VziU6pUj3vtslMWKpBGslpLtnaO561dihGyElayMd4VFg7VR/TsglJv
 A10EDs2DMhoYPfRQWvwlr5+jPP6s9H8KSTCGFvQt438rP/gk0lcEZUJK0iE2/yq5gQfaCNI5FLN7C
 q8LVr00oS4doXfmFFxMq6z1rs5SXZorWssjG7v5DILnPxLqYloQK/ebM5Ixbzm0Lq/8vWL7sw7yOH
 JVYCHCApGzKNii6rYyHdi0K8UwvpD++GCWLyvbgP/H3l5FqL63gAN0Rw1CO5r22+SmG7aOmekJH3N
 ChZPI3NMLnKZPJC8ZQZ4S8yb5oA3rqTA2DMODvsrEVlaB2cQ6IWHSa/mvBwA8Ias3771cp4fZS7W7
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-lG2wQ2ZQwma9XpNz6gth"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 08:06:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4317


--=-lG2wQ2ZQwma9XpNz6gth
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-06-26 at 14:45 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> wic currently has no test mechanism of its own; it relies on the
> oe-selftest from oe-core for all its testing, which means a full
> bitbake build is needed to exercise even pure-Python logic. Add a
> small standalone suite that runs from a plain checkout with nothing
> but pytest (and ruff for linting), so that logic can be pinned down
> and kept stable as the code evolves.
>=20
> What this adds:
>=20
>   - tests/conftest.py: a session banner identifying what the run is
>     tested against.
>   - tests/run-tests.sh: a small wrapper that runs the suite from
>     anywhere in the checkout.
>   - tests/unit/: in-process unit suites for wic's pure-Python
>     modules.
>   - tests/docs/: how to run the suite and the conventions it follows.
>   - pyproject.toml: a [tests] optional-dependency group and the
>     pytest and ruff configuration.
>   - README.md: a Testing section pointing at the suite and its docs.
>   - .gitignore: ignore the coverage data file.
>=20
> Install and run with:
>=20
>     pip install -e ".[tests]"
>     tests/run-tests.sh
>=20
> The suite follows a test-driven style: each test states the
> behaviour wic is expected to provide. Where a behaviour is not yet
> in place, the test is written ahead of the implementation and
> marked xfail, so the specification is captured in the test itself.
> The test code itself is kept ruff-clean (see tests/docs/linting.md).
>=20
> AI-Generated: codex/claude-opus 4.7 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  .gitignore                        |    6 +
>  README.md                         |   28 +
>  pyproject.toml                    |   30 +
>  tests/conftest.py                 |   38 +
>  tests/docs/README.md              |   77 +
>  tests/docs/authoring.md           |   97 ++
>  tests/docs/linting.md             |   50 +
>  tests/docs/philosophy.md          |   84 ++
>  tests/run-tests.sh                |  135 ++
>  tests/unit/test_bb_utils.py       |  133 ++
>  tests/unit/test_bootfiles.py      |  188 +++
>  tests/unit/test_cli_types.py      |  288 ++++
>  tests/unit/test_engine.py         |  282 ++++
>  tests/unit/test_filemap.py        | 2317 +++++++++++++++++++++++++++++
>  tests/unit/test_help.py           |  118 ++
>  tests/unit/test_ksparser_parse.py |  209 +++
>  tests/unit/test_ksparser_types.py |  400 +++++
>  tests/unit/test_misc.py           |  128 ++
>  tests/unit/test_misc_vars.py      |  182 +++
>  tests/unit/test_oe_path.py        |  465 ++++++
>  tests/unit/test_partition.py      |  598 ++++++++
>  tests/unit/test_pluginbase.py     |   93 ++
>  tests/unit/test_update_fstab.py   |  265 ++++
>  23 files changed, 6211 insertions(+)

Hi Trevor,

Thanks for sending this, I think it's important to add a standalone test
suite to wic. 6211 new lines in one patch isn't reviewable though.
Please separate this into a logical series of smaller changes.

I also recommend fixing issues in the wic code as you go instead of
capturing them in xfail conditions. That is much easier if you take this
one step at a time.

An initial series could add the test framework, add one test module and
fix the errors along the way (e.g. in mkdirhier()).

Best regards,

--=20
Paul Barker


--=-lG2wQ2ZQwma9XpNz6gth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCakInmBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bvgIAP4qCfDmBL4J3DPIUTT2Z7KCeqByWfvctKKW
zxTorq8iOwD/Z3CNMZQCzBsdGi2+hGDwCKs2ho6mDA0vsSy855NLaAk=
=zl/d
-----END PGP SIGNATURE-----

--=-lG2wQ2ZQwma9XpNz6gth--

