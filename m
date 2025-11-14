Return-Path: <hemant.jadhav@emerson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F16CEACD2
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 20:30:37 +0000 (UTC)
Subject: Re: [meta-security][PATCH v4 1/2] clamav: Add recipe for version 1.4.3
To: yocto-patches@lists.yoctoproject.org
From: "Hemant Jadhav" <hemant.jadhav@emerson.com>
X-Originating-Location: US (69.41.68.7)
X-Originating-Platform: Windows Edge 142
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 14 Nov 2025 12:30:33 -0800
References: <20251114154052.3651845-1-hemant.jadhav@emerson.com> <58f6364a-0faf-9296-588e-1798cb52653c@konsulko.com>
In-Reply-To: <58f6364a-0faf-9296-588e-1798cb52653c@konsulko.com>
Message-ID: <465076.1763152233932443580@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="1WFwxjOKZESeQzrbwPdZ"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 20:30:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2576

--1WFwxjOKZESeQzrbwPdZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 12:05 PM, Scott Murray wrote:

>=20
> This is a non-starter, as it:
> - breaks build reproducibility, which is even more important for a
> security tool.
> - opens the door to build breakage if any higher-order dependency
> crates increase their required Rust version (I've seen this happen
> multiple times in the past few years).
>=20
> The recipe needs to use the regular cargo.bbclass and an include file
> for the crates generated with cargo-update-recipe-crates.bbclass.
>=20
> Scott

Thank you, Scott, for pointing this out!

I didn't realize while implementing this that network access would be a non=
-starter for reproducibility.
I incorrectly borrowed the CARGO_DISABLE_BITBAKE_VENDORING approach from th=
e Rust compiler recipe (meta/recipes-devtools/rust/rust_1.90.0.bb), which u=
ses it because the Rust compiler comes with its own pre-vendored sources. T=
his pattern is not appropriate for regular applications.

I am reworking the recipe to use the proper cargo vendoring approach. I've =
looked at the Suricata recipe in meta-security, which uses cargo + cargo-up=
date-recipe-crates classes. I can rewrite the code.

Is this vendoring approach acceptable, or would you prefer a different solu=
tion for handling the Rust dependencies?
In case if this works, do you want me to start a new thread or continue wit=
h next version.

--1WFwxjOKZESeQzrbwPdZ
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Fri, Nov 14, 2025 at 12:05 PM, Scott Murray wrote:</div>
<div>
<blockquote>This is a non-starter, as it:<br />- breaks build reproducibili=
ty, which is even more important for a<br />security tool.<br />- opens the=
 door to build breakage if any higher-order dependency<br />crates increase=
 their required Rust version (I've seen this happen<br />multiple times in =
the past few years).<br /><br />The recipe needs to use the regular cargo.b=
bclass and an include file<br />for the crates generated with cargo-update-=
recipe-crates.bbclass.<br /><br />Scott</blockquote>
<br />
<div>Thank you, Scott, for pointing this out!<br /><br /></div>
<div>I didn't realize while implementing this that network access would be =
a non-starter for reproducibility. <br />I incorrectly borrowed the CARGO_D=
ISABLE_BITBAKE_VENDORING approach from the Rust compiler recipe (meta/recip=
es-devtools/rust/rust_1.90.0.bb), which uses it because the Rust compiler c=
omes with its own pre-vendored sources. This pattern is not appropriate for=
 regular applications.<br /><br /></div>
<div>I am reworking the recipe to use the proper cargo vendoring approach. =
I've looked at the Suricata recipe in meta-security, which uses cargo + car=
go-update-recipe-crates classes. I can rewrite the code.</div>
<div><br />Is this vendoring approach acceptable, or would you prefer a dif=
ferent solution for handling the Rust dependencies?</div>
<div>In case if this works, do you want me to start a new thread or continu=
e with next version.</div>
</div>

--1WFwxjOKZESeQzrbwPdZ--

