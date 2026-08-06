Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E9FC56208
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 16:17:40 +0000 (UTC)
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23649.1786033054959779584
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Aug 2026 09:17:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@on-the-web.ch header.s=protonmail2 header.b=GMdQOkac;
 spf=pass (domain: on-the-web.ch, ip: 185.70.43.18, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail2; t=1786033051; x=1786292251;
	bh=KopW0yD8WYMIJuV8w9eRQWvmiDjpXVMZgQ76YqvJas8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GMdQOkacQeLhYYbBXq4SENg/aHmFrQs/JQaqmvR+wDxYtGUICnIBnTgE/QMhZhcJx
	 xrlVScZeZxjMl7tbFXv3SJ8zDHRG2qvBac90hPrbOU2Is0aJQUJuTnIW5HktSqaGPI
	 78vZnWYSOv5ENbrErZPdeVGbdzDV6ztxHB0H2csQqLt7apGZUHkEHjelNgJyGVGzta
	 Bv2DdC7gtQLrWo41oXwWPdNU6W5QNl1n/0bb7Y7gxbs7Z/lR0W4Wwu2ZquP/67CYsr
	 FXzcub35M65ac3Qz8sSA0tUe4H+bjFIflgS8UPPphLF4XBh4siVy6AGbdCQgIjPJZ9
	 DPQh/ensIgP6Q==
Date: Thu, 06 Aug 2026 16:17:27 +0000
To: yocto-patches@lists.yoctoproject.org
From: Martin Herren <sputnik@on-the-web.ch>
Cc: Trevor Woerner <twoerner@gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 1/3] bsp: rkbin: use SPDX LicenseRef for Rockchip proprietary firmware
Message-ID: <HnJPmFEHitLKNbXFeLhQCEtIGsFThk5oPdA7qjn69O8BjZyGrcrIDfHNp7-snZp3WSowzhUjEb7hl5MENSOnAGfz1vShN7bDaZvl5SQXAEM=@on-the-web.ch>
In-Reply-To: <6c58262c-06bb-43ac-a72c-e930056f71bd@cherry.de>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch> <20260805121327.3946788-2-sputnik@on-the-web.ch> <6c58262c-06bb-43ac-a72c-e930056f71bd@cherry.de>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: 75efbf9ffaf48568c509c6e68bbc87ca44d767b8
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------cbbee5b3307d5d8bc6de37abca5327520df275bb6cca42840a7672a3be4f9ecb"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Aug 2026 16:17:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4643

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------cbbee5b3307d5d8bc6de37abca5327520df275bb6cca42840a7672a3be4f9ecb
Content-Type: multipart/mixed;boundary=---------------------152df92fdb6578efe2b280166c57a224

-----------------------152df92fdb6578efe2b280166c57a224
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi Quentin,

Thanks for your review.

On Thursday, August 6th, 2026 at 2:42 PM, Quentin Schulz via lists.yoctopr=
oject.org <quentin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:

> Hi Martin,
> =


> I've read on LinkedIn you used AI/LLM for some stuff related to Rockchip
> and was wondering if maybe this series got some of it developed by/with
> AI/LLM. OE-Core and BitBake require to add an
> =


> AI-Generated: <AI/LLM used>
> =


> in the commit log and I think it could be nice to see it stated for
> meta-rockchip as well. Ultimately, it's up to Trevor to define or
> "enforce" this as he's the sole maintainer of meta-rockchip at the
> moment. See the "Acceptance of AI Generated Code" section in the
> contributor guide (I'm traveling so cannot provide you with a link right
> now) if you want to know more.

True, some AI was used in thi patch, I was aware about the 'Assisted-By: '=
 tag used in Zephyr, not about the 'AI-Generated: ' used as convention her=
e. Missed that part of the doc although it is clearly and well documented.

Will submit a v2 with that fixed.

> On 8/5/26 2:14 PM, Martin Herren via lists.yoctoproject.org wrote:
> > From: Martin Herren <sputnik@on-the-web.ch>
> >
> > OE-Core now parses LICENSE as an SPDX expression and warns on legacy
> > non-SPDX names such as "Proprietary".
> >
> > Switch the rkbin family (rockchip-rkbin.inc, used by -ddr, -optee-os a=
nd
> > -tf-a) to a recipe-specific LicenseRef backed by NO_GENERIC_LICENSE, s=
o
> > the SPDX manifest references the real Rockchip LICENSE at the repo roo=
t.
> >
> > References: oe-core e9d424738d6f ("classes/conf/lib: Parse LICENSE as =
SPDX Expression")
> >
> > Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
> > ---
> >   recipes-bsp/rkbin/rockchip-rkbin.inc | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/=
rockchip-rkbin.inc
> > index 9ddd54f..d715b44 100644
> > --- a/recipes-bsp/rkbin/rockchip-rkbin.inc
> > +++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
> > @@ -1,7 +1,8 @@
> >   SRC_URI =3D "git://github.com/rockchip-linux/rkbin;protocol=3Dhttps;=
branch=3Dmaster"
> >   SRCREV =3D "f43a462e7a1429a9d407ae52b4745033034a6cf9"
> > -LICENSE =3D
> >   "Proprietary"
> > +LICENSE =3D "LicenseRef-Rockchip-rkbin"
> >   LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D11e3673115959bf596feaaa6e=
a7ce9a5"
> > +NO_GENERIC_LICENSE[Rockchip-rkbin] =3D "LICENSE"
> >
> =


> This seems to follow what we've done for
> meta/recipes-kernel/linux-firmware/linux-firmware_*.bb so looks good to

Yes, the goal was to follow as much as possible with how it is done elsewh=
ere in other layers.

Thanks again and a v2 will follow shorty !

/Martin

> me, thus:
> =


> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> =


> Thanks!
> Quentin
> =


> =


> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4639): https://lists.yoctoproject.org/g/yocto-patche=
s/message/4639
> Mute This Topic: https://lists.yoctoproject.org/mt/120608960/10317775
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/150570=
71/10317775/2038727303/xyzzy [sputnik@on-the-web.ch]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> =


> =


> =


-----------------------152df92fdb6578efe2b280166c57a224--

--------cbbee5b3307d5d8bc6de37abca5327520df275bb6cca42840a7672a3be4f9ecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmp0s4cJEIiu+thqKlAPRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcxVsvn4cdEPhYLqEr5mc29o6oMjjqtj+YvbiH0
PFYEMBYhBCYHlZbYUMXC4ILtW4iu+thqKlAPAAAYXgEA265AtK1qU3Gep9wZ
HRYcPNrf+PhAqB/cze3v9CBBO0YBAKKbOFWpYvft7/sWByksTT8Ty2uNjR9g
V/FTHHZV3ysI
=XyCu
-----END PGP SIGNATURE-----


--------cbbee5b3307d5d8bc6de37abca5327520df275bb6cca42840a7672a3be4f9ecb--


