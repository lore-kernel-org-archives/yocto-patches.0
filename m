Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7CFCD37AC
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 08:57:55 +0000 (UTC)
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46161.1778489870207443204
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 May 2026 01:57:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=fC8E0vkm;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=iGIAJLb6;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.151, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 69BF11D000FE;
	Mon, 11 May 2026 04:57:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 11 May 2026 04:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1778489869; x=1778576269; bh=lbHJalSqCS
	3m9eN9XutZpCFNrSIar7GAvH2WwaLEzpk=; b=fC8E0vkm6Ah3ExNuWZbgeXDXEo
	9p5452AVy7KOXf3RhXXn34jdjxo+IYYbNWjo4gtjsTc+Zb7Nuomt3eLT8WNDIEwp
	5mDzBGe48uV5tnuSxAmx6etqltCPM//LeyR9E2plsSmWbZ+JcImriLmqI775FiOY
	AmM+Gk/C8zIcuEgPLa1Uq7eG4I+No9diGefJYiaINu5wC/jbwprwD9S8AGg6VseD
	UjN09eFp5mQs5J/dePQqaMhNluYa9faTEmWx4t1BhE4OyV+tdWOcVfSq9boM2ytd
	1MUybJM3R/UL/ln/cfmIKv4JuzyU3RMZ2BzARpd6vQGpWTEj5I9KUWFle4ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778489869; x=1778576269; bh=lbHJalSqCS3m9eN9XutZpCFNrSIar7GAvH2
	WwaLEzpk=; b=iGIAJLb6I/q99mYZgb9BVO4o3Guhnbn8MUZwYr5yPIHHiXE4/Mg
	bCVt8hKa4g9K6GYJ/EmKaNHnd4MPnHG2ibYAjUgT8li0wYoVA5CWXgEoIJMOf+Kb
	CK0xr8f3ZgNsvm27nun1KS9xu2RadpBXjiY89EXU+9U5PgZ8C9uUgFcGCvi18QvU
	OnqzRW9AEpQfynww9T2dz7SJhLb8DmcIga1e0A++3SMhUJUszWMDneQyCDclX10l
	oPNxtADn/qSGnfU2HjFRYwjeKqgOdV7IYL6Wh/i5h1+G9mCBOI+OyLmiqIFJ5vQr
	Q6IIF+Z3pyHOQLvw0rnrWRXBjsUJDeRetLw==
X-ME-Sender: <xms:DZoBammjQA_O1cvQbRnsdBI7W0m3j3vLurZPbkYKBsvWbR9c6mcePA>
    <xme:DZoBallt7CyAMdewjHLEdpUN0x4KcQRDdZ_b3V3M_LLlNaWIRhCjlCRg2-fm8zStr
    qzPsmfbXJdpSvZH-lLO1vGLMYR03P0ZMbT5aKqDTJP1IIwbzqOElIM>
X-ME-Received: <xmr:DZoBansAVvFKZiikZdtLNPX4IvrkXiUgg2H0ObHttOG0gfRERk_zxc6VGhXRMGG-_VG_SgulSyr-4qrOS1oV2AU1fR25BXTEpHFibEIah3Ds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggesghdtreertd
    erjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhepfeeileehudffvdeljedvgfetieeugfetteekfe
    dtgeeggfevtddutddvheegfeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtth
    hopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtihhmrdhorhhlihhnghes
    khhonhhsuhhlkhhordgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslh
    hishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohephihotghtohes
    lhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-ME-Proxy: <xmx:DZoBaok3AiyiSxoqr8ea_Kqh6lmECRDV0dmJYyF-2JD8blv-WMKbWg>
    <xmx:DZoBaivF9ShXo6LH66iJUEpjbkQqF6YpDyO9vj1njwMuW7rdDAPzRA>
    <xmx:DZoBaudVnLBsSRfcZnr99VSQzteQiqpOkuFcO-oUsnw2erOX52RkCw>
    <xmx:DZoBaiwrnJgmnQnan9vha2TGCTM77clmGiSoZ9vTGhBCDa3oYKTVkw>
    <xmx:DZoBaunpLFggyGtrGUqn9eNd4XsH3u4ju-FcuXpaum4GqQbXqVRjInYn>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 04:57:48 -0400 (EDT)
Message-ID: <5a9794c0ec3ebf9340f7b8d062db48822a5821f2.camel@pbarker.dev>
Subject: Re: [yocto-autobuilder-helper][PATCH 09/11] config.json: add
 vcontainer-tests, vdkr-tests, vpdmn-tests jobs
From: Paul Barker <paul@pbarker.dev>
To: tim.orling@konsulko.com, yocto-patches@lists.yoctoproject.org, 
	yocto@lists.yoctoproject.org
Date: Mon, 11 May 2026 09:57:46 +0100
In-Reply-To: <fedb9a114f294f1d1dc80d1df086a41e3419b490.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
	 <fedb9a114f294f1d1dc80d1df086a41e3419b490.1778202125.git.tim.orling@konsulko.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-FbKY+Xin6Ho3QvHKye7p"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 08:57:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3966


--=-FbKY+Xin6Ho3QvHKye7p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-05-07 at 18:25 -0700, tim.orling@konsulko.com wrote:
> From: Tim Orling <tim.orling@konsulko.com>
>=20
> Add three pytest job overrides that run the meta-virtualization test
> suites against the vcontainer standalone SDK published by the
> vcontainer-tarball builder.

I think this would be better as one job with three steps.

>=20
> Each job runs the new scripts/run-vcontainer-tests helper via
> EXTRACMDS (we need BUILDDIR variable so EXTRAPLAINCMDS is not
> sufficient) with both NOBUILDTOOLS and NOVCONTAINER set, so the
> workers don't spend time setting up either tarball: the test runner
> gets the published SDK installer through VCONTAINER_SDK and manages
> its own pytest venv.
>=20
> vcontainer-tests covers the broader bbclass/tooling tests (and so
> brings in meta-openembedded layers it transitively exercises);
> vdkr-tests and vpdmn-tests cover their respective CLI harnesses.
>=20
> AI-Generated: Claude Cowork Opus 4.7
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---
>  config.json                  | 42 +++++++++++++++++++++++++++++++++++-
>  scripts/run-vcontainer-tests |  7 +++---
>  2 files changed, 44 insertions(+), 5 deletions(-)
>=20
> diff --git a/config.json b/config.json
> index 86c1ffb..dda5b12 100644
> --- a/config.json
> +++ b/config.json
> @@ -1891,7 +1891,7 @@
>              },
>              "step2" : {
>                  "shortname" : "Publish vcontainer SDK for test reuse",
> -                "EXTRAPLAINCMDS" : [
> +                "EXTRACMDS" : [

This fixup should be squashed into the earlier patch in this series that
added this line.

[snip]

> diff --git a/scripts/run-vcontainer-tests b/scripts/run-vcontainer-tests
> index cbb5544..1394c7c 100755
> --- a/scripts/run-vcontainer-tests
> +++ b/scripts/run-vcontainer-tests
> @@ -3,7 +3,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
>  # Run meta-virtualization pytest test suites against the vcontainer
> -# standalone SDK (vdkr/vpdmn) that was built by the previous bitbake
> +# standalone SDK (vdkr/vpdmn) that was built in a previous bitbake
>  # step.
>  #
>  # Arguments:
> @@ -21,9 +21,8 @@
>  #
>  # The script is intentionally conservative: any pytest tests that cannot=
 run
>  # in the CI environment (those marked "slow", "network", "boot") are ski=
pped
> -# are skipped so that the autobuilder step completes without needing net=
work
> -# access. Those can be re-enabled by exporting META_VIRT_PYTEST_MARKERS
> -# before invocation.
> +# so that the autobuilder step completes without needing network access.=
 Those
> +# can be re-enabled by exporting META_VIRT_PYTEST_MARKERS before invocat=
ion.
>  #
>  # It is assumed that /dev/kvm is writable by the CI user running the tes=
ts,
>  # since the performance is significantly faster with 'memres'.

As above, these fixups need squashing into the patch that added
run-vcontainer-tests.

Best regards,

--=20
Paul Barker


--=-FbKY+Xin6Ho3QvHKye7p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCagGaChEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bpZ+AP9+Qp9tgv/DFh2UXlCuXqdfmlSuMuF4QF7g
wzNIRBpNswD/ab6DAlUAOF+4havlOgNZSXeXsWVxso7Gnf+nOLtsGw0=
=l2AY
-----END PGP SIGNATURE-----

--=-FbKY+Xin6Ho3QvHKye7p--

