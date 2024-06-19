Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDCFC27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 12:22:33 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web11.19344.1718799747700168716
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Jun 2024 05:22:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YVktZn4h;
 spf=pass (domain: gmail.com, ip: 209.85.167.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cc10b5978so2885033e87.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718799746; x=1719404546; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rrt1UU/DTSidEEjSXdbW5rN6D8Qa49P3oPsHZQaRrIE=;
        b=YVktZn4hdRo47QQ/8LtAV9QZWaDTX6RzDlHzH/zHDvKrvnF/0z4Ewg3TMhzGRHn3mN
         vpGDjMZTr36L7BIqLTnFdKn7gCxwBn6aNDek87cS2FxFPH8XdS9C3RJ245euPEDTYSrB
         MzHysq8+NXD9EoPfQA7V8nel1Jt2WD9qISxDcdmpn4PGDwC1Z6YDJHy2u8XkUXdNQGsO
         6frWXmNBaQ7ic26P4DznQcI7PsW2sOPp+Xz7oZ2lcngbnnIANVZ1Civ8CtS9DLQxzhwJ
         QaXNuKO67Ph80y8AH4IVml7tJNofL5/twgHBWCHIsHfALc3ZYoWul6DE57QyZq4oOo/A
         FtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718799746; x=1719404546;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rrt1UU/DTSidEEjSXdbW5rN6D8Qa49P3oPsHZQaRrIE=;
        b=htklGz5xam/l8xs37i+llH2petrB/T47q88Zb0PPfbAY+v8hQqMtPYPS1r/BiWm4k6
         +5+mG4K+JJuEUkUn5PLfDuOXEv6je+XAOWHiSeA6gW/1I6ZaGp6iypf7lMXFmKfeFK2A
         NTJJFIkk7HCRgAIm1ig+HP8eMwH3iHLfWaITv1vCZdIbZ6hLR4hvL4mrH0YAv4174fOU
         EOEXlo/f3rHRJfRgisqRFYVdiwZ5EKjSWtDdzOw2SXGuG9yyabjzbhmw0Ckpg/g0m9OK
         zCPY6mlvgF8tGZ1PLCKZ8q9Fcj09I+fWxIy94GNjukSLzfy06ICrUPn3lmb9pgCVENZ3
         1F+Q==
X-Gm-Message-State: AOJu0YxpPhmkuXhz+LlxnkIvi3/RPOk7IXMa04ypddRsoiR84KEH/GYS
	H1XiFeMlBp5lu54BxbMZcUVlqFjffsuxa5+JjDFB9KQ3X+RGOCJAmj5G4rlGI9RC0x+wwmbe0VZ
	710QhpQSA410YLiEUQl89pSP1BTTqJQ==
X-Google-Smtp-Source: AGHT+IFeLIPYto5alx9c223yD60yml5bCVMX3oqgLGuoJLCPY7l+4me10Nk4NwshJppd/OUlmUbnD2Ez2YwYilIMbWA=
X-Received: by 2002:a05:6512:124a:b0:52c:8a37:6cf4 with SMTP id
 2adb3069b0e04-52ccaa5576fmr1802892e87.14.1718799745394; Wed, 19 Jun 2024
 05:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240618171619.9303-1-twoerner@gmail.com> <d7838e2a-85e8-4308-82cc-36f9eb2b69c6@cherry.de>
 <CA+chaQeUfaxfeuqSZEqxYVm6EcH8S9QqGe=1F=b2UgpmNaUPBg@mail.gmail.com> <20240619121738.GA16113@localhost>
In-Reply-To: <20240619121738.GA16113@localhost>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 19 Jun 2024 14:22:02 +0200
Message-ID: <CA+chaQc1CL0O0WAuReDaPs=8bk=RJ=r0pCp9FGBpJcHf-PiqDg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2] linux-torvalds-next:
 use tag
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 12:22:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/354

On Wed, Jun 19, 2024 at 2:17=E2=80=AFPM Trevor Woerner via
lists.yoctoproject.org <twoerner=3Dgmail.com@lists.yoctoproject.org>
wrote:
>
> On Wed 2024-06-19 @ 01:56:14 PM, Martin Jansa via lists.yoctoproject.org =
wrote:
> > Why is this better?
>
> Because in a repository like linux-next
> a957267fa7e9159d3d2ee1421359ebf228570c68 could be rebased out of existenc=
e?

Really? It shouldn't disappear while the tag is still referencing it
and if the tag is deleted than this change won't help you as well
after first gc in upstream repo.

> Although now that makes we wonder what would happen to the tag in this
> situation.
>
> Three days ago this hash was reachable from master, now it is not. That's=
 a
> lot of churn.
>
> > Now bitbake will always run git ls-remote to
> > covert next-20240611 into a957267fa7e9159d3d2ee1421359ebf228570c68 and
> > break parsing this recipe without network access.
>
> Is that how you're building with meta-rockchip?

I don't even use meta-rockchip, but I'm a bit allergic to ls-remote
while parsing recipes I'm not using (and random build failures caused
by that when there is a network glitch or something during re-parsing
of the recipes), especially when I notice a change like this which
IMHO made it worse.

Regards,

> > On Wed, Jun 19, 2024 at 10:59=E2=80=AFAM Quentin Schulz via
> > lists.yoctoproject.org
> > <quentin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:
> > >
> > > Hi Trevor,
> > >
> > > On 6/18/24 7:16 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > > Use the tag name specifically; note that it is no longer reachable =
from any
> > > > branch.
> > > >
> > > > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > > > ---
> > > >   recipes-kernel/linux/linux-torvalds-next_git.bb | 5 ++---
> > > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/reci=
pes-kernel/linux/linux-torvalds-next_git.bb
> > > > index 9a95eb5bc4d8..1369ba1d707f 100644
> > > > --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
> > > > +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
> > > > @@ -10,13 +10,12 @@ COMPATIBLE_MACHINE =3D "^$"
> > > >   COMPATIBLE_MACHINE:radxa-zero-3 =3D "radxa-zero-3"
> > > >
> > > >   LINUX_VERSION =3D "6.10-rc3"
> > > > +KERNEL_VERSION_SANITY_SKIP =3D "1"
> > > >   PV =3D "${LINUX_VERSION}+git${SRCPV}"
> > > >   SRC_URI =3D " \
> > > > -     git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git;protocol=3Dhttps;branch=3Dmaster \
> > > > +     git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git;protocol=3Dhttps;nobranch=3D1;tag=3Dnext-20240611 \
> > > >       file://rockchip-kmeta;type=3Dkmeta;name=3Drockchip-kmeta;dest=
suffix=3Drockchip-kmeta \
> > > >       "
> > > > -# this is tag 'next-20240611'
> > > > -SRCREV =3D "a957267fa7e9159d3d2ee1421359ebf228570c68"
> > > >
> > >
> > > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > >
> > > Thanks!
> > > Quentin
> > >
> > >
> > >
> > >
> > >
> >
> >
> >
> >
> >
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#352): https://lists.yoctoproject.org/g/yocto-patches/=
message/352
> Mute This Topic: https://lists.yoctoproject.org/mt/106745214/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

