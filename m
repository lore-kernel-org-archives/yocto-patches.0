Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C99C27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 18:55:55 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web11.29216.1718823350383459040
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Jun 2024 11:55:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KaIbY6FM;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: raj.khem@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f8d0a00a35so68163a34.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718823349; x=1719428149; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6t52BnrQn+Ky/leNoc+aG+bL+1c1wBkraIaDwPYb5w=;
        b=KaIbY6FMghAucZ3Tcz+XaORYgqX5ZHGbNDmh2w7jpavLz6iv0cC6FW2KkcazP4lHIM
         AHQULf89XN8Ed3mpNRtwu9vBAuOgnxlBP9UoxULHcNxQMWnAT0hr2PjRs+f/Y0Pdv4Ra
         EmThm99cO6DK9SQ5IDmP5ttUyIPkP4qwAXnt4qmmgDK23LmMBLdObeKafxu2mufe/xzh
         5d6Z+WN3dnXYNSpCFBoLcmHstQNVVYA1hdT15srUKV/jdulpI52wNbxZ+nXgEmz3Eduf
         4uEWpi4VzlTFdSCA1SS1hpInpdUkiVmduAHPqkMMyDHwCh0mHahntcKhlGi7l7tj2SOJ
         2cgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718823349; x=1719428149;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6t52BnrQn+Ky/leNoc+aG+bL+1c1wBkraIaDwPYb5w=;
        b=pgvS1+6iXuM/m+LujAuix7BCpyn8gq9gOBU4dtTFBBp/DpIIxzwPhAAdCtDmWFYE+0
         94uL6Z0iYg/6N0cSwqgWPp3dtjeueRq3U5L2FEXyBe1EtExF68/aUdfaPgk5LyzmgjFc
         zXr+MJ8DOMFaeP5MqFAogL32pnrPlxEYC1fVWBwYatJXiEOxtCO5gydku/otAioRBGNv
         ASZW2AAJoRS5hkWPQC5kHiljFxAExU3ZNyssMFyqjo6erOijiUnJdHGJWRZirJJ86GQF
         X5qeirTZP0N6WOFO5qrZQgjLW16xdawxGOO+NMEB788qzUSf9oYVQv7CUet1X8XsNOQ4
         ipdw==
X-Gm-Message-State: AOJu0YxefzYmOT9fpqtSIICK8zH4OaWPCwXzJ3zg66GyUYziwiMBqEdn
	5jqTibtDkf4WGyxHGMA4R5f1IvMqzZ0qw0kxUnUTfhkWClpgHtPJjII0C0ZTyUzrxVH0lg7gOVO
	3PCqKStXFPObgSjOfSebqzBYET5lESQ==
X-Google-Smtp-Source: AGHT+IEbL+1bRL36qP4VjGHz0pxtiWGLDegs4Evgqb9jZtgM+cAHZ26Lb0tDw3UlvC6p/wogSyV4oOQMH92jIQN8qZw=
X-Received: by 2002:a05:6871:71e:b0:24f:c892:d02b with SMTP id
 586e51a60fabf-25c9440bb32mr3815682fac.0.1718823349210; Wed, 19 Jun 2024
 11:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240618171619.9303-1-twoerner@gmail.com> <d7838e2a-85e8-4308-82cc-36f9eb2b69c6@cherry.de>
In-Reply-To: <d7838e2a-85e8-4308-82cc-36f9eb2b69c6@cherry.de>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 19 Jun 2024 11:55:23 -0700
Message-ID: <CAMKF1spJwo=h+0wWnLwpyAmaSWSDiYs5EgLgjrgFK35ktfh89g@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2] linux-torvalds-next:
 use tag
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 18:55:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/356

Why use tags ? they are floating SHA1 and bitbake will need n/w access
all the time.

On Wed, Jun 19, 2024 at 1:59=E2=80=AFAM Quentin Schulz via
lists.yoctoproject.org
<quentin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:
>
> Hi Trevor,
>
> On 6/18/24 7:16 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Use the tag name specifically; note that it is no longer reachable from=
 any
> > branch.
> >
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   recipes-kernel/linux/linux-torvalds-next_git.bb | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-=
kernel/linux/linux-torvalds-next_git.bb
> > index 9a95eb5bc4d8..1369ba1d707f 100644
> > --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
> > +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
> > @@ -10,13 +10,12 @@ COMPATIBLE_MACHINE =3D "^$"
> >   COMPATIBLE_MACHINE:radxa-zero-3 =3D "radxa-zero-3"
> >
> >   LINUX_VERSION =3D "6.10-rc3"
> > +KERNEL_VERSION_SANITY_SKIP =3D "1"
> >   PV =3D "${LINUX_VERSION}+git${SRCPV}"
> >   SRC_URI =3D " \
> > -     git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
;protocol=3Dhttps;branch=3Dmaster \
> > +     git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
;protocol=3Dhttps;nobranch=3D1;tag=3Dnext-20240611 \
> >       file://rockchip-kmeta;type=3Dkmeta;name=3Drockchip-kmeta;destsuff=
ix=3Drockchip-kmeta \
> >       "
> > -# this is tag 'next-20240611'
> > -SRCREV =3D "a957267fa7e9159d3d2ee1421359ebf228570c68"
> >
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Thanks!
> Quentin
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#348): https://lists.yoctoproject.org/g/yocto-patches/=
message/348
> Mute This Topic: https://lists.yoctoproject.org/mt/106745214/1997914
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1334078=
6/1997914/645821814/xyzzy [raj.khem@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

