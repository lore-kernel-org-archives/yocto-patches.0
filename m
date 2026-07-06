Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D06BC43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 08:21:33 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.146554.1783326088443673936
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 01:21:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=ZYE49yvW;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=EDQSn9XK;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C9CAB1D000E0
	for <yocto-patches@lists.yoctoproject.org>; Mon,  6 Jul 2026 04:21:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jul 2026 04:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783326087; x=1783412487; bh=d+nDCzCJre
	w1wJZ+CVUikzPe3N6P4Uj2U3YX5QsP5zA=; b=ZYE49yvWiTDpopYbIax9mxEosR
	/YNRaFQDNeBu0X5fnByMzQ+R1y40LlwvNzHL3wJ0LZav2OZmWj/0MOgAr+IBNPQW
	76+p2+buh6xB1rHfljwaRfODV4ad8qX6uOSM8gtElwtipclHF6XUlluwn7MbRV4e
	qLpKmdpZca17iimwRfnwwGAKfSvClBzSHIWXzFUVujZyh02B+YXNIMkRU2KvrSKy
	YGLst/QcmQY+WsRkLrzJyXy1k/2TcJDZmlD5G8GfLd8ZSx1pMZfVzL0R4IgIIAuH
	ehY/jC1OMEZaarkBORRBflPntoH9TxTbvaRmOd9lXU6MumhIGNVsxcDpwYHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783326087; x=1783412487; bh=d+nDCzCJrew1wJZ+CVUikzPe3N6P4Uj2U3Y
	X5QsP5zA=; b=EDQSn9XKgUYj36LlmTf71ppDQW1cBOSqNETgINbT8YayZoNlyuX
	zhqEvstwJc7ZC1taEYP0crz6sEPERX1ktlgjEQbcJX7wJLVQCsUuZD1zEIXD+7Be
	FHE0aYlzamokrUZ0t7wAFXRLwCxQbHSfLu+sgeJGWbuQguS9H37y6bMazJ2g0zio
	JLoDvEqf5wq3Kq/8N1oHcWPitCLZAlmrOCtPVxcr/KgOzutSBV2MLEI+Hf+wIRPW
	J9rwWHFrrQLUdlMHRoSiPnIDMbZ2ILBtjRJ7l0p8Xe/WoO4/JCEHVS+9upo+IJGI
	6Jt3a7801BjodGaQZjFS4nhewGL/+mp+UsQ==
X-ME-Sender: <xms:h2VLas38RwP1g3H87udk_QL3Tmem6HWPYjJWJudtkNHHGVMY_RnhrQ>
    <xme:h2VLauDlYoxkgceR5wCcy8h8zcadSEn3cVz0yWjUESbJ11-0_QAIpUG5YGw8FnQiM
    hmWL9_L3TACuckKG21MNGlmxybAkHUR8TJLob43DVuQSFmF-f-w9OY>
X-ME-Received: <xmr:h2VLaqiLRUdkilxrkaxyZyfZy7xTvIDaH42w36iCjKPBhW5NhzGVHEm9p1wkJANmXoRg4Fa3KNV__egfrHe9QSTunRJxMNkTOMAlqS9e9U81>
X-ME-Proxy-Cause: dmFkZTEIndQ1jc4epZAX651TVrmSJZHF905WctdYmFbloEbNGGrq0wc7H8dYy4K5t92Skz
    b923ul6ImzJpE//yjzj2OERO+KX+g+jM6wP76ZOo1rOtm96/oct97rB0wjHb5NVyZjJUnM
    Cg05nMkox8zeUu/D/2klGbWuCGrZa4Ap0KVaihAdRjrPfMAjrjDE0aNb8rtzaHuigB7NtR
    s6mqdKXIgXYJBOq7acXPYecS1pCZ5kiq11TwW7RhDPK2i5dj5fSW9X0x29gWoUmM06bXyo
    B6Ae8d9IqlY5g1aWiQVhlClvHFbuEqY/y2tYiFAauSpZ6PxhgVQhsWRD3SQOg+bvM5c+rz
    APSEPUHaq1XkE3zoalkcJUFxuMCN1T19L0+BT67Z36GHvWaAn0nDaku2hXsv9D0FzLBGBc
    LxYL/EsYjQo1qubinj7X+LY5EL/rvmWrU4jEpE+jhqxrg5/fm4Y+YJ5M12SocefIsmawL0
    +D3NHg+auJT/kiQUPigf73O+DRn/3sRnVun8Eunok6KZ20cBdbNVeb0D3dJ3ohLwijLUns
    FhizR71vuWAprcTZGNF/FGZ7ilLHWU3Hwpn5kfrbvSthb9sYg6UJ5v7bIryBSCaF/Ns+LD
    8oNX+KcebmsMkcBSxu5Q+RE+0RhQgK5KKycr/+Gkw1TiKW01AGUCG5eCr60Q
X-ME-Proxy: <xmx:h2VLaq_naqvuqcbgEd_VcyJ4f6xt52RSFsVGkdMDHWSWtt9xXRGVfQ>
    <xmx:h2VLau_UJAFrpmlEGgDvpQ6M7dfp7V5Fdchfgti50a404gWtJzXqAQ>
    <xmx:h2VLarBQ_ONOq1UGWhBBcoPWVRORXNQjo7HxB6gJH_P6tw0xz9JZFw>
    <xmx:h2VLamyEK9QEfk3ehTq8M6s_L4WVTGYbGYAvMIA22Ggpnrl_siHIIw>
    <xmx:h2VLavWSf9IThdVMtIOo-qnLKG8ZCq5rTyeJxKLAzGFaSBvAqcUJTo1v>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Mon,
 6 Jul 2026 04:21:27 -0400 (EDT)
Message-ID: <5b7fb2ff371f113fc9e3f0278ff23fea6ae56af3.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v3 03/10] tests: add the
 run-tests.sh wrapper
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 06 Jul 2026 09:21:24 +0100
In-Reply-To: <20260701074030.1090807-4-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
	 <20260701074030.1090807-4-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-JI7K0H9GS5K/UBuF+ZpU"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 08:21:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4422


--=-JI7K0H9GS5K/UBuF+ZpU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 03:40 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> The suite is run with pytest, but invoking pytest directly has two
> sharp edges: it must be run from the right directory for the pyproject
> configuration to apply, and it happily runs against whatever Python
> happens to be first on PATH, even one that cannot import wic. A run
> against the wrong interpreter produces a misleading banner and, worse,
> can silently exercise a different wic than the one in the checkout.
>=20
> This commit adds tests/run-tests.sh, a thin wrapper that removes both
> hazards:
>=20
>   - it locates the repository root from its own path and changes there
>     before running, so it works regardless of the caller's directory;
>=20
>   - it checks that the interpreter can import wic before handing off to
>     pytest, and fails loudly with the install command if it cannot;
>=20
>   - with no arguments it runs the whole suite under tests/; any
>     argument it does not recognise (a path, -k EXPR, -v, ...) is passed
>     straight through to pytest, and an explicit -- forwards everything
>     after it.
>=20
> The interpreter can be overridden with the PYTHON environment variable
> (default python3). -h/--help prints usage and exits.
>=20
> The README Testing section gains the run-tests.sh invocation alongside
> the install step.
>=20
> AI-Generated: codex/claude-opus 4.7 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

I don't think this is needed, since we already attempt to import wic in
conftest.py, we can call pytest.exit() from there if the import fails.

Best regards,

--=20
Paul Barker


--=-JI7K0H9GS5K/UBuF+ZpU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaktlhBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0blHTAP9bHkU1/qDEljj1D3HBCRp08gcYFHbstAUV
Cy2zKUCVLgEAmuH//MJnvjCekLHwoUidViQk6bjhaIucniYTeOvGQgo=
=IK4e
-----END PGP SIGNATURE-----

--=-JI7K0H9GS5K/UBuF+ZpU--

