Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC0FC43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 09:08:44 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.147126.1783328923671307781
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 02:08:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=g+I3QIbR;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=qo5Rs3EG;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E5CB11D00105
	for <yocto-patches@lists.yoctoproject.org>; Mon,  6 Jul 2026 05:08:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jul 2026 05:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783328922; x=1783415322; bh=Hp3nbzAlEw
	Zx8fL11V6S8azsGT/7xg0N1sC+X1IM/NU=; b=g+I3QIbRtZfu+KOStAPSNpV36y
	eFTVe9d1uur/3uJt11RE+K1B+dI4YY4CkEI8aIGRg78OwFk/HESBUggaZuQEp4DK
	CGCmYmpNu11FYA1OvoFDpEBil1MWaN2dGidvT4Ji+mFiNY78HwDgfTR+olTYGcl/
	m+r2o3nAoFqBElDejkPy3WOPgTAl94hgNZ0w/bxCmXXubZBKfrKkqdy/KN5+QwrE
	vkY5RxOF7iOQU4Nn7Pw6y33HsQo5FPS0+X+ypntrLJ05ecIdcMNpl0D8icjRTlB2
	DPl3yij5U+xny2DXKtAA5m4Q289pxzCCTYMWk7+Cr2tjgD5wfxBj1fOeTb0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783328922; x=1783415322; bh=Hp3nbzAlEwZx8fL11V6S8azsGT/7xg0N1sC
	+X1IM/NU=; b=qo5Rs3EGWJfN7NQIK2C4rOnSW4LWjsJSzOBxgEdQVHibAZ0AOrE
	sdYWl+axR8Ijt2Ys4jzeF5Rr9HSu+qTLJ0nvupOSYr/maBCXDKLbCgi38CcqJ1F6
	YsbIYdqoCcLPQciGkv5WUM729I5Ir+DjXyVAs8RXhG4XHJOGl+Xkv6oD5WmfnVFF
	KSE4z72952/ligRMUCYy7nT6COJhTUzx4V0vsSBsRI/feJE/HjP0T3px1/Jw9UFu
	jupyYBdB02FUnkEU/8AvbNjCp70/C6hmRbQdWa25+SGz267Wt42h67jRapF48QI5
	i20WZQ6VIKQeihmLnYvQBy1cILvPQh4hfdg==
X-ME-Sender: <xms:mnBLajvrs_YZgE0O6-sKkhSCoNXyIYyo5rXgEa6ZlMtSPz7kY3PN4A>
    <xme:mnBLarY-9lqblsG1EwwzB_ie_0XHACHYnvSEsirS7kfE4hkwC0jolOwUvURJWFJEy
    G70l1Z96RwzJXI7LDnDagZyDGQ3Nw3aLIviq7pgkOH-VcD5d2JHH8D1>
X-ME-Received: <xmr:mnBLasaiGheETk3rfCAUiBXbMqgDvRyDfyZTspfYdTFreeKg0AKdry6iENlIql2b0WsDPXW4dyJcdC3sYdvW91ZjW0yKLnQ7KwtGjTjCQ5CZ>
X-ME-Proxy-Cause: dmFkZTE3Cs/hbpm7XiM9p4K56JxQRUN6ZUjQoq0YVJ5HpZx5YikR/LQsTU2lq2bXmKvqUU
    vW2yTIOdOx0KSHTwWMMdAaQRVhYLKICoq2O7dD+pxLb2GyWVw66LadyGtGU2KVvBKeWqWf
    DRYwWV+LlDqNhVC+J7Gz5SXONZ9Gcl2GaW2fjOBU6b6+Gg2h0yGpRn5Om0zisXEJlX1IQ1
    K/qH8L1+gFSUbrRa0QKCnLQGmZLSPhQS7jlCkUoK4yJZwTZQgkBJvu/ITc6BaiEh8eKC2E
    WTIO8EuzTx6mFngKBW/83r/2UcEpFJCmK4yt+eY1evz+SJRWmgjM1B0jxfqFQWGh82a0rb
    RYbeov2NHbsNlVK075Z5CHRcGDXHHQeuEv9IABB9gSuGEtrk0M6CMd72N+kJUkWHy25+XZ
    swz+TrS8XeuPX/6OoFNJQ8EtZwMensBoPril+cg214FRAqTugVQ/qDLbl2voDi3WnC0CE1
    7CyAylVwe7/4DAb9M7NW7kna0U/gn85+M73RWKvpoDZsojzfxO6DObcszefHWL3S/2PzAV
    qRiWxiYEIVNYOOHaOT6k7cgMMc6IV57Ul8/wQPeG/kFLpv/lAQgDEe2u4apEd4F9pIHEiH
    ICcVs5axXE/mbeNf8p5lK28N9KH8pxEo1shTVV8KKtV8NF+wLwfMYemlahLQ
X-ME-Proxy: <xmx:mnBLanWzku8tA9ZnI6Emh-0NmpAN6yMSiaxPykWjUniA8e6_wapaGA>
    <xmx:mnBLaj18slVQXsSDn-pFVPD6S2uXGyDVZlZnzs8GG-t_IKzj3V07XA>
    <xmx:mnBLauaghAigQRo6WY6hoZJxXH0H77evOyRDkqr2b3GXxkt4Uj1T5A>
    <xmx:mnBLamovDqCK5qp7_kFZAS2S7YWpvlIRZY5oZ4pKhoxrHt2Z9JOYPg>
    <xmx:mnBLaptqx8-XwqqlJ4PQAk0dn-4UmDLPX5rZFUaKy_9x228DtUIGiWfK>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Mon,
 6 Jul 2026 05:08:42 -0400 (EDT)
Message-ID: <bdd168bebb399a7600cd9e424f3faac3e7f3887a.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v3 10/10] tests/docs: add the
 review rubric
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 06 Jul 2026 10:08:39 +0100
In-Reply-To: <20260701074030.1090807-11-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
	 <20260701074030.1090807-11-twoerner@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-R7EXs0hCUdlvmo2RLov1"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 09:08:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4429


--=-R7EXs0hCUdlvmo2RLov1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 03:40 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> The suite already documents how to write a test (authoring.md) and how
> it is linted (linting.md), but not how a test change is judged. This
> adds tests/docs/reviewing.md, the review-time companion to authoring.md,
> so the standard a change is held to is written down where both
> reviewers and contributors can see it.
>=20
> The rubric records the conventions the suite is built on:
>=20
>   - one function per commit, with the subject keyed to the test file;
>   - a test asserts the correct behaviour, and when it exposes a defect
>     the source fix lands in the same commit rather than as an xfail or a
>     test that bakes in the wrong result;
>   - a fix must be proven to matter by backing it out and watching the
>     test go red;
>   - the suite is green and lint-clean at every commit, not only at the
>     tip of a series;
>   - assertions are specific, boundaries are probed, and an assertion is
>     never weakened to force a pass;
>   - coverage is read as a guide to untested branches, not a score;
>   - each commit message stands alone and references no other commit.
>=20
> It closes with a short reviewer checklist that collects those points,
> and is linked from the docs table in the suite README.
>=20
> AI-Generated: codex/claude-opus 4.8 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

The comments I've made earlier in the series apply here as well. Is this
for the AI agent? Does it need to explain such generic ideas as
one change per commit?

Best regards,

--=20
Paul Barker


--=-R7EXs0hCUdlvmo2RLov1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaktwlxEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bhKXAQCXQAHvmq1N2lG6SVgJD+0XgDl9Ujy+86Se
a9z4RV050wEA/OmqYfB1fSUEaEJFXeu+rd8mCk2DtBydW7DchCefkg4=
=tJba
-----END PGP SIGNATURE-----

--=-R7EXs0hCUdlvmo2RLov1--

