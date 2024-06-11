Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D14CC27C77
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 15:03:57 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.11891.1718118231549018134
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 08:03:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VMazDQ5+;
 spf=pass (domain: gmail.com, ip: 209.85.216.49, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c2c6277ef3so3432833a91.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718118231; x=1718723031; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRx5LtqVncXqbOFac446Y602k6exCJjlcrlSrGFqvBk=;
        b=VMazDQ5+XBG5GyAxiofOx/zAGSl+BHjxrPLFeRi/YziSH+yCQ2NPkd/CEVoIs/E3CN
         450NXY/f5/sQcCXmkIlW580b9TneQ3YgpblyxPxbLjTqoUQLjRkjW8QTsnI3L+C6/osI
         L0+4EDeyi8mVhSOv3oSW+ACkF/W0tCqYV+QbzpZivgjI0MFPYTZh8KMjKakfvXxylGob
         AD/f3d0XrKB9FU7gBhi54Lktz4ZGeYf2CwKD4Dcyh38cfS3XyX1VxqOtKyDwvBNkUgVn
         TV+4JKm7xKDMrJ5AaLzKjLXdHTK6O2L7PyaeDXR3ZKwmLe3IdnE+/mxh6PY2agdvKhvj
         jyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718118231; x=1718723031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRx5LtqVncXqbOFac446Y602k6exCJjlcrlSrGFqvBk=;
        b=KUDZ1Naiid27Qv5qXFxYblNayg6crILlibK0rH0iP30xW3cyxu+Eu9anYV17q8bEf4
         aO0Kph1ImVUtZFV3AMDGLpfHkkuzMZwPxIABiWitg+5nID9PLioIt7Psi+LAs5wgBSGB
         KwJgk1YU5rfItEeMN1v4fXzfSucsZsFH7IcElSAZoGfEfOEHqwErKfNHmc8bBqZ3kRQw
         qsQfTjuC+HPL5bX/H/WnewmbwmrE8cIS/Vtce9HQqfCcfVCAZgw0b2XNkz0D/VW8NiGV
         6LIGAN/Y6Oc6ihonDVTFx2P4RX9ZQhrQDYBZjbbMBSzG89iUpNxW4f6gVf5081Uri9/b
         1urg==
X-Gm-Message-State: AOJu0Yz2EWQzbd2GOd3XwVrt18JRwZmO6kG1Umqde69ElmNqek//m7pp
	39cQTSzk+3pApzMpviIMD846Mv9JMO0EA1rfJo6Bm7R8eFcDrne6Y7jkAb9LoZ2G4gqAaqZpSHD
	UtLZGCxy7J1vkj+pnQBG65HWKInA=
X-Google-Smtp-Source: AGHT+IEhusfYLAUTEQC+IjyoCAJHSP/MqnDj6eUaJJsNKcBuHLLJhfADz/xX2YuA0ovlMp+kRLWa7jGw81obVdTAiC0=
X-Received: by 2002:a17:90a:5b0b:b0:2c3:278b:1af with SMTP id
 98e67ed59e1d1-2c3278b04ccmr3100176a91.7.1718118230728; Tue, 11 Jun 2024
 08:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240611140607.2719-1-twoerner@gmail.com> <7c50adeb-c82b-4a7d-b663-8f73a63ae5b3@cherry.de>
 <20240611145656.GA7654@localhost>
In-Reply-To: <20240611145656.GA7654@localhost>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Tue, 11 Jun 2024 11:03:40 -0400
Message-ID: <CADkTA4Pk_Q01YNSAC04UG3g1WEeL+ZFL=GH=_avTkQu7=-6+Qg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-yocto-dev: fix build
To: Trevor Woerner <twoerner@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 15:03:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/304

On Tue, Jun 11, 2024 at 10:57=E2=80=AFAM Trevor Woerner <twoerner@gmail.com=
> wrote:
>
> On Tue 2024-06-11 @ 04:29:35 PM, Quentin Schulz via lists.yoctoproject.or=
g wrote:
> > Hi Trevor,
> >
> > On 6/11/24 4:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > The linux-yocto-dev build was failing with:
> > >     | ERROR: modpost: vmlinux: local symbol 'security_path_rmdir' was=
 exported
> > >
> > > Disabling some filesystem-related security options fixes the build.
> > >
> >
> > Is this the case for every board, including non-Rockchip ones?
>
> This builds fine with qemuarm64, for example. Comparing the .config from =
the
> qemuarm64 build vs the rockchip build is what led me to the patch that I'=
ve
> presented. The qemuarm64 build doesn't try to build the file that causes =
the
> error since its .config doesn't ask it to. We're using the in-kernel
> defconfig for the rockchip build so:
> 1) it's strange nobody else has seen/fixed this
> 2) why doesn't the qemuarm64 build use the in-kernel defconfig (or if it =
does,
> why are these options not set in its .config)?

Hah. Let's not start the in-tree defconfig bikeshed debate.

There's a yocto reference configuration, it will not, and does not
strictly follow anything in-tree. If someone does see things in a
defconfig they want represented in the machine or base configuration,
they are free to propose them as patches and they'll be considered
on individual merit.

>
> > Is Bruce aware of those issues? Shouldn't this rather be fixed in oe-co=
re
> > instead?
>
> I guess I could give him a poke.

See my reply from just a few minutes ago.

Bruce

>
> > > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > > ---
> > >   recipes-kernel/linux/linux-yocto-dev.bbappend                | 1 +
> > >   .../linux/linux-yocto-dev/disable-some-fs-security.cfg       | 5 ++=
+++
> > >   2 files changed, 6 insertions(+)
> > >   create mode 100644 recipes-kernel/linux/linux-yocto-dev/disable-som=
e-fs-security.cfg
> > >
> > > diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-=
kernel/linux/linux-yocto-dev.bbappend
> > > index b6a63d7b7b29..94bf737c63bd 100644
> > > --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
> > > +++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
> > > @@ -2,4 +2,5 @@ FILESEXTRAPATHS:prepend :=3D "${THISDIR}/${PN}:"
> > >   COMPATIBLE_MACHINE:orangepi-5-plus =3D "orangepi-5-plus"
> > > +SRC_URI:append =3D " file://disable-some-fs-security.cfg"
> >
> > If it is Rockchip-specific, I would suggest using SRC_URI:append:rockch=
ip
> > here, to make sure we do not modify other machines from other layers
> > whenever meta-rockchip is included?
>
> Oh right, thanks. I don't think of that use-case often enough.



--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

