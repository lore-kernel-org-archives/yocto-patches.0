Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDC1F5A8A5
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 17:28:12 +0000 (UTC)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25120.1776706083405854166
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Apr 2026 10:28:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@on-the-web.ch header.s=protonmail header.b=G5J3jAV/;
 spf=pass (domain: on-the-web.ch, ip: 79.135.106.25, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail; t=1776706080; x=1776965280;
	bh=DQrE9NzLMpQyuP1EsV1vYqChG0MAQtjCayZ/ssb2ZUM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=G5J3jAV/qPnii70xdZUU3W7vfkevMg0tosk3yL2mP7i5twMgCZ/loYNdQiVBiO7jq
	 JT/e0yGJOmh5AgUxEAmBJDZ0oJzgcRSarQ3c7BpG891G2b5MIdjvNRFklYFP67YW+f
	 v6eTnWknQSjCzQY9pIlBVdHjmz8YJRy/vQT6TLtAACgBrWJCBy0xw25OhfxdBDcRpg
	 /P7cctt2wKdJNMboCu0/Xv02l6LJIahCMc1AESPn2/4b2M4jbvw9Vyf1bgcWfQw/M9
	 PBVNvHlLNJgWBNX4ItR9v/TQKmLuj4ZJEOLJTefyp8a6zg1kwJDgnnr2YMJ9bHVrEM
	 Wc4EcpYTub4JA==
Date: Mon, 20 Apr 2026 17:27:55 +0000
To: yocto-patches@lists.yoctoproject.org
From: Martin Herren <sputnik@on-the-web.ch>
Cc: Trevor Woerner <twoerner@gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip] Backport patches to Whinlatter
Message-ID: <D_T0vfLiZ7iT-Zdru_yLBe3ZScLI_weV-fDDAFnDD4aJybbieGUfMXTEA-X5vakiZbsQeTAZ3DjRdyJRCZjM2FxdcR1WwxO4rk1cUUCTg7w=@on-the-web.ch>
In-Reply-To: <f458ad76-2eda-41f2-b6a5-1f6bba342752@cherry.de>
References: <5bj70loXmt_k9cZvIDWvVux-3no88K7lhbMDcRw9jh3ylLLz-YDZhyOr6fM8PeXSnC88wg6wk34A9A3uz8ljvNTE_nEurXpatMj2VxFsw8c=@on-the-web.ch> <f458ad76-2eda-41f2-b6a5-1f6bba342752@cherry.de>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 940d1f6b1d71f20fb776209edea332abcc7ec6f4
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------724b5e7d5496b63cd401d265a29eb25b9f8b06e16d85c2177cbea10776159511"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 17:28:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3739

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------724b5e7d5496b63cd401d265a29eb25b9f8b06e16d85c2177cbea10776159511
Content-Type: multipart/mixed;boundary=---------------------c1aa07346800f1b3689368ef1f3cddac

-----------------------c1aa07346800f1b3689368ef1f3cddac
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hej,

> Hi Martin, Trevor,
> =


> On 4/20/26 12:14 PM, Martin Herren wrote:
> > Dear maintainers,
> >
> > May I suggest the following 2 patches from meta-rockchip master to be =
back ported to the Whinlatter branch ?
> >
> > fitimage rework: fe7cfa748bb132cfbe322c1c6d586f09557dbeb2
> >
> =


> This one is tricky. We shouldn't break existing users but this is a
> patch that isn't backward compatible as we would require users to set
> the RK_KERNEL_FITIMAGE variable to match the modifications they made to
> KERNEL_IMAGETYPE/KERNEL_CLASSES in their own machine configuration file
> based on the SoC machine include file. Can you tell us more about what
> is broken before this is backported? Maybe there's another way to
> implement a fix without breaking backward compatibility.

Doing a `bitbake core-image-base` for `MACHINE =3D "rock-5b"` on current w=
hinlatter (including all other layers also on whinlatter) without this pat=
ch leads to:

```
=E2=9D=AF bitbake core-image-base
Loading cache: 100% |#####################################################=
##########################################################################=
########################| Time: 0:00:00
Loaded 0 entries from dependency cache.
ERROR: ParseError at /home/martin/dev/yocto/rockchip/layers/openembedded-c=
ore/meta/classes-recipe/kernel.bbclass:188: Could not inherit file classes=
/kernel-fitimage.bbclass| ETA:  0:00:17
ERROR: Parsing halted due to errors, see error messages above

Summary: There were 2 ERROR messages, returning a non-zero exit code.
```

Applying this patch goes further:

```
ERROR: rockchip-rkbin-tf-a-git-r0 do_unpack: Recipes that set S =3D "${WOR=
KDIR}/git" or S =3D "${UNPACKDIR}/git" should remove that assignment, as S=
 set by bitbake.conf in oe-core now works.
ERROR: Logfile of failure stored in: /home/martin/dev/yocto/rockchip/layer=
s/build/tmp/work/rock_5b-oe-linux/rockchip-rkbin-tf-a/git/temp/log.do_unpa=
ck.34439
ERROR: Task (/home/martin/dev/yocto/rockchip/layers/meta-rockchip/recipes-=
bsp/rkbin/rockchip-rkbin-tf-a_git.bb:do_unpack) failed with exit code '1'
ERROR: rockchip-rkbin-ddr-git-r0 do_unpack: Recipes that set S =3D "${WORK=
DIR}/git" or S =3D "${UNPACKDIR}/git" should remove that assignment, as S =
set by bitbake.conf in oe-core now works.
ERROR: Logfile of failure stored in: /home/martin/dev/yocto/rockchip/layer=
s/build/tmp/work/rock_5b-oe-linux/rockchip-rkbin-ddr/git/temp/log.do_unpac=
k.34438
ERROR: Task (/home/martin/dev/yocto/rockchip/layers/meta-rockchip/recipes-=
bsp/rkbin/rockchip-rkbin-ddr_git.bb:do_unpack) failed with exit code '1'
```

Thus the 2nd suggested backport.

> > bsp: rkbin: fix build since S =3D "${WORKDIR}/git" is implied by OE-Co=
re: e59f6fcb66091ea5efe33f3f3d8be09b1f65bbfb
> >
> =


> git tag --contains 46480a5e6674
> (the commit listed in the commit log) returns the first whinlatter tag,
> so should be fine to backport.
> =


> > I understand Whinlatter to soon enter EOL, it would make sense to have=
 it enter EOL in a buildable state.
> >
> =


> Yes, but not by potentially breaking existing users, so special care
> needs to be taken. This is not a worry when we're working on the master.

Yes, didn't think about that it could break other custom board bsp layers =
based upon this one.

/Martin


-----------------------c1aa07346800f1b3689368ef1f3cddac--

--------724b5e7d5496b63cd401d265a29eb25b9f8b06e16d85c2177cbea10776159511
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmnmYgsJEIiu+thqKlAPRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdLq7URRdZD7DKYRLTZEKFfbSN9EiL6vH0rM0Sk
t99B5xYhBCYHlZbYUMXC4ILtW4iu+thqKlAPAACFuwD/bSfvwOwYck1DO5na
fM8RNIYk0x27KZGbVB9cf7qFIYYA/2EcBCE/IGW+gjHpbk68C4NAh3YacjId
pdV8MEsVwigG
=Jhgr
-----END PGP SIGNATURE-----


--------724b5e7d5496b63cd401d265a29eb25b9f8b06e16d85c2177cbea10776159511--


