Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69535C27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 11:56:43 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web11.18815.1718798197940818213
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Jun 2024 04:56:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=K0FPueiH;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52c525257feso8155953e87.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718798196; x=1719402996; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5GAfwL1Lse6GXB1RaBMK0O/nESoFVWWNzdsH7mtIdE=;
        b=K0FPueiHUcvj0iiu0A2iaZozHPilmOLaonuEKTh5zz6ASsZTQCprMaVQVUf1UiZQbw
         ib9dQvJvJLxgU8poyKowMPAi+md5UQCaj/Cf+Hyef6ED2iBKHEl9nF1mAvfoTs9mKXKu
         /hA2VN/GIsNJLlE/OctYpkiJNYScscrtNtOR/6+wEg28lfBkWpekU64k/83J0+c+H/m8
         xhGgwvXsSRaGfKe6PRICBf8FoOM8K/poVmdc2At5ofKd4XRojke4rObf46M0v3NjhRYm
         2iuIZMWRhy1J+KBfdKpL0AlhQTJTh68phKdSGW7SlX6s7lZzwsAv197r3s4c2e8v2xo3
         JcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798196; x=1719402996;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5GAfwL1Lse6GXB1RaBMK0O/nESoFVWWNzdsH7mtIdE=;
        b=e8Mwtg5G/bwGEc3HCQUInj19rswXaImpaNoFaVQCa/gtVhMphfqZZ7q90ssBsEba66
         iZYI6mAViuFunjS+2FyzmvdtZXK79TWzuvZ7ufWQCElQRFoJ09u4IJGniSxiafuvTamg
         rxL8fZeCXxAtoXn/Tj0qgumg6r0V7LPKBa7NS8vd30gG0mDA5ab07A4UjHAshvawPAJq
         7PLmQZg3524cJNqCiNEwusm1PerdoE0fPmcb0uXpBI8vgM7fi6WHb5PfXsGbFjcMmmp1
         1LA+U/8XBli6qVS3BVt6k5hmgee6NNdnRILYeDzMulKWEg1YPs1QEFwzOPF8f1/wkAlB
         l9mA==
X-Gm-Message-State: AOJu0YxXEcERSfoqaULtZf+Skia9CUW++tpO5jpokicWp+d16t7XwkN4
	8oxWMndz/r2SzNsh0vsCymjt0IFaUnre6pL7GEiiYBDco2NNlS8MpY7Dxsb1oNMZCy35Uzq49wI
	odSKcGWQO79Huq3OotJXDnU1Nqn8F3JuU
X-Google-Smtp-Source: AGHT+IHinqVIyP9Xq+Pqcc3x/4lIkNZX9BK4PKwJmBNkp/XIIpNqfBOuOZL6hX+GH0dTRIXiIYAddfJ92PT7ds+/OHU=
X-Received: by 2002:a05:6512:1247:b0:52c:84bf:d1f9 with SMTP id
 2adb3069b0e04-52ccaa2a879mr1493893e87.8.1718798195542; Wed, 19 Jun 2024
 04:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240618171619.9303-1-twoerner@gmail.com> <d7838e2a-85e8-4308-82cc-36f9eb2b69c6@cherry.de>
In-Reply-To: <d7838e2a-85e8-4308-82cc-36f9eb2b69c6@cherry.de>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 19 Jun 2024 13:56:14 +0200
Message-ID: <CA+chaQeUfaxfeuqSZEqxYVm6EcH8S9QqGe=1F=b2UgpmNaUPBg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2] linux-torvalds-next:
 use tag
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 11:56:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/351

Why is this better? Now bitbake will always run git ls-remote to
covert next-20240611 into a957267fa7e9159d3d2ee1421359ebf228570c68 and
break parsing this recipe without network access.

On Wed, Jun 19, 2024 at 10:59=E2=80=AFAM Quentin Schulz via
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
> Mute This Topic: https://lists.yoctoproject.org/mt/106745214/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

