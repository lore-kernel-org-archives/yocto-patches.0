Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EAAC27C75
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 15:17:47 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web11.12222.1718119063438833204
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 08:17:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cPuC1JF6;
 spf=pass (domain: gmail.com, ip: 209.85.215.175, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6c4f3e0e3d2so4417186a12.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 08:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718119062; x=1718723862; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgIEDrHIKcdvtczLjDA5UUBcCc7AldmbWdEoEB5YIFM=;
        b=cPuC1JF6t9IQ6dKx7OHvS1zikpgg86fqJv1A6/FnnsQAEM9PSIZTLy4y9Jvpwza2eD
         E7Cc2uqQ98SnlUoLVQKxZJUiogoXNW7JetqCp5SI1ZeNVgH/paiAOmA4BdY3Pb9mVW+A
         CbVSfCTWlF/RS6rWBkY7Phd7V3F4UVr2hTE1VlnCnvEh0BGi7EOgs97JYIL0I2e4YEcf
         iPVoS/2kdLEogXIG46kU3vK55a83TzAh+/hMCib6jovLm27fdvaU0jl+i7lZ5Pkxpror
         xx4TZ+3761L0vmrimEhzsWRV4CkNpC5lgMoOys4nNF8qkkY4xos33Gh8cPCLI8e96QEj
         NgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119062; x=1718723862;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgIEDrHIKcdvtczLjDA5UUBcCc7AldmbWdEoEB5YIFM=;
        b=vlITWbciCd4JYG2gnJRhYcf07EmhK4b/QKfGhXjbvwIWThyjxj/+Bl5gLePV+F9qeI
         /rH5oG5VsWOrFsed2tL2YEVllB6rgrhOIFHVyRU6GBrFYXeGSwQV4U3gutfmdeMTnpc2
         ArwWH8tenRRku7FfnepjwhV72lwSOrmKKXNuM90xNwcZwGtmIGIIgNyx+bhh8efCGU1B
         TSCsQ0hgBCpHKpHUZ8nPGDsyShRh1C4+7FfaWw3Ro5pGAVCAb3gqR0r554+RdvuAue+8
         xKV1/Rq3sjploTN7qX2N1XQOabM2hnBw0mZ7/mmIuoydGi4UEFk9sqpcxQdvsPXOWwIW
         GsLQ==
X-Gm-Message-State: AOJu0YyqPUChqkywEcAlieCGLwvnrqTAwKTfJ6dOg410zxTwHyXFwR7C
	FdmfPIiXiIuZVb5nmsynXP6YGvHuK8otx+xsL8iuzlTzSQLG9YIbQEWgRHAPcoc2jTG7mnL+BcW
	WUaohN7nxn6teZbL1wlzJH77tg4iYhai3
X-Google-Smtp-Source: AGHT+IElh/kxcZrHTKAav3sAPgfxgsUrCysy2YyJdralz+SwVFKqgOTqTvTWimHg0OGj+o08ShDZdwfr5Gdua/Ad5Dw=
X-Received: by 2002:a17:90b:1049:b0:2c2:cce9:2578 with SMTP id
 98e67ed59e1d1-2c2cce92bd7mr9808203a91.17.1718119062244; Tue, 11 Jun 2024
 08:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240611140607.2719-1-twoerner@gmail.com> <7c50adeb-c82b-4a7d-b663-8f73a63ae5b3@cherry.de>
 <CADkTA4N6vr-CwmAGX9JATaiCZ+OxprTYp=t=cjG8iX4roiFYQA@mail.gmail.com>
In-Reply-To: <CADkTA4N6vr-CwmAGX9JATaiCZ+OxprTYp=t=cjG8iX4roiFYQA@mail.gmail.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Tue, 11 Jun 2024 11:17:31 -0400
Message-ID: <CADkTA4OV-gAFN+=Af1XDUwczqLTJWPKcdJs3wBwyUP2HaKjBWA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-yocto-dev: fix build
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 15:17:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/306

On Tue, Jun 11, 2024 at 11:01=E2=80=AFAM Bruce Ashfield
<bruce.ashfield@gmail.com> wrote:
>
> On Tue, Jun 11, 2024 at 10:29=E2=80=AFAM Quentin Schulz via
> lists.yoctoproject.org
> <quentin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:
> >
> > Hi Trevor,
> >
> > On 6/11/24 4:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > The linux-yocto-dev build was failing with:
> > >       | ERROR: modpost: vmlinux: local symbol 'security_path_rmdir' w=
as exported
> > >
> > > Disabling some filesystem-related security options fixes the build.
> > >
> >
> > Is this the case for every board, including non-Rockchip ones?
> >
> > Is Bruce aware of those issues? Shouldn't this rather be fixed in
> > oe-core instead?
>
> Ross had mentioned something like this a week or so ago,
> but I haven't seen it locally yet.
>
> It's an aufs6 export that is causing the issue, I'm looking into
> it now.

I see the issue with the exports. One slipped outside of an ifdef
and is causing issues.

It should all be fixed shortly.

Bruce

>
> Preferably I need to reproduce it on the qemuarm machines,
> so I can be sure of the fix.
>
> Bruce
>
> >
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
> > >
> > >   COMPATIBLE_MACHINE:orangepi-5-plus =3D "orangepi-5-plus"
> > >
> > > +SRC_URI:append =3D " file://disable-some-fs-security.cfg"
> >
> > If it is Rockchip-specific, I would suggest using
> > SRC_URI:append:rockchip here, to make sure we do not modify other
> > machines from other layers whenever meta-rockchip is included?
> >
> > Cheers,
> > Quentin
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#300): https://lists.yoctoproject.org/g/yocto-patche=
s/message/300
> > Mute This Topic: https://lists.yoctoproject.org/mt/106613842/1050810
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13171=
493/1050810/607820704/xyzzy [bruce.ashfield@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> >
>
>
> --
> - Thou shalt not follow the NULL pointer, for chaos and madness await
> thee at its end
> - "Use the force Harry" - Gandalf, Star Trek II



--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

