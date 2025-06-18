Return-Path: <lepotoman@msn.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6A4C7115A
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 09:56:15 +0000 (UTC)
Subject: Re: [meta-lts-mixins][kirkstone/rust][Build error] Rust 1.80.0
To: yocto-patches@lists.yoctoproject.org
From: lepotoman@msn.com
X-Originating-Location: Osaka, JP (160.86.248.152)
X-Originating-Platform: Linux Firefox 139
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 18 Jun 2025 02:56:06 -0700
References: <9960.1750237305887246239@lists.yoctoproject.org>
In-Reply-To: <9960.1750237305887246239@lists.yoctoproject.org>
Message-ID: <26140.1750240566839940014@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="UQ7S9XZTe2jS3DLCpCSh"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 09:56:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1658

--UQ7S9XZTe2jS3DLCpCSh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

About the ownership, with Rust 1.77 tar.xz, the ownership on file inside th=
e rust-std-nightly-x86_64-unknown-linux-gnu.tar.xz tarball is 1000/1000.
In 1.85.1, it's 0/0 (root).
I think this is what it produce my bug about the unzip step.

Maxime.

--UQ7S9XZTe2jS3DLCpCSh
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>About the ownership, with Rust 1.77 tar.xz, the ownership on file insi=
de the rust-std-nightly-x86_64-unknown-linux-gnu.tar.xz tarball is 1000/100=
0.<br />In 1.85.1, it's 0/0 (root).<br />I think this is what it produce my=
 bug about the unzip step.</div>
<div>&nbsp;</div>
<div>Maxime.</div>

--UQ7S9XZTe2jS3DLCpCSh--

