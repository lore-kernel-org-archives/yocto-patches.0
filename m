Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED9C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 22:08:03 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web11.98.1741644475073392946
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Mar 2025 15:07:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TY+Dc6ur;
 spf=pass (domain: gmail.com, ip: 209.85.167.182, mailfrom: raj.khem@gmail.com)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3fa1e694706so276978b6e.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Mar 2025 15:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741644474; x=1742249274; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH9NpdZ90DryDfljDhbFNId/uq9WS5V8iTqAwxUVl8E=;
        b=TY+Dc6urXnfwPpUeMhGapnKLEuKJFfDBXodN+MtCL2C33RBCXi0G0OVMTGsCnjJtNc
         4E9k2qEAsMwTyJH7y9hJ2Gbahb4xldg66MxBrwV4YeRmEwFVbR+ZBD7gvC2cNQfj/nCb
         gl6tVprEOZmebbd5dr3ivSucGrsGPc6sxtNGoxeZVfDMpFCgDz8cqkm29l/wnurIeKaB
         mqsMEbkeJGBiJ+Ex43IEiTmisU80B1SASYcQbriiQOxOXqpmg4ig+24QXm8vwggxtnBI
         +k8i04qny1hGfLHs+dmkOMFQyZX6XdaOtPWxcVMFGUq+OHdVh8ja4SY7tHxIzXfn94Di
         B48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741644474; x=1742249274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH9NpdZ90DryDfljDhbFNId/uq9WS5V8iTqAwxUVl8E=;
        b=D9c5Wn/rY/UE0SCFuHVIs2jFMzbR/KwLpiMRyQNavLr27Pw2fy92h7NuCL9Dl8Jm0i
         gpgY0WBLlPSwGcXgW0bUkalpvPPtaElEaWuRGVoFT1wKoodPSLPz7UyNWP6x1JxiKnDn
         OIRbFT2QupHOr33wLZQmYYb1z5klDLVZwe+xNKWAkIWQDo0n36v2CsF7iJa6+b+R33ob
         0q2QCWKWafjMUqSMyylPJZyd7YCSAl7cRB3rDDDnquoX4V/AzAHb9vLFVHdDKJVcuwnD
         Cp2o/W355gZcMY+uW5oZhMDEAw9JeyhNjeHVB/5dDHa3OKaZLiYC3HpjcyvVq653clPu
         RkWg==
X-Gm-Message-State: AOJu0YylBwbGJ6ihNHkZ1oNDeWsqpb1Q1wSL4xWNA63TdQ7l2M9p3asw
	7Z/WqOejI69bQ63XKYGQfujiksS8Oyn9EnSD87P2V/QHPpMAvM6JUeF+o0BCFGFJzIV8TZ+1eRC
	IDAsrRTtYIPB5LAbpAB/e14VxSLwesy8b
X-Gm-Gg: ASbGncvzf/DYAOMdUB7KgsTQ2rAaeyHpEdmQ3K/K1hy52Zirlf7Cv2+HiNcBf/w3fJo
	19FDbYJZr2uF7kPQWyZLsPuOemWfeqj+aoR0y99O+RjU3SpEoT/J/IWAU9A5Ev208Pgl/a49fBk
	/NJ4WB9x4rjr0Lz/YW8FzPvH3Vd8aPE5Hp2Rno9BjZOax714iUWmiacfI=
X-Google-Smtp-Source: AGHT+IFdc5PZ3GAnRcU0at/2OIbHNr+rcdduDRPs1TLPItnwptEf156/8jgOymmeWUumDZY3Rb4xGIPEJBf8HGEJh2Q=
X-Received: by 2002:a05:6808:4491:b0:3fa:7328:b9a8 with SMTP id
 5614622812f47-3fa7328bbe9mr39672b6e.18.1741644474123; Mon, 10 Mar 2025
 15:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAGNQujsSc1TpF3ZpmoQKpa0cBeqTdnY3tpKFZh9udwaA0ZQomw@mail.gmail.com>
 <20250310154725.GA34977@localhost>
In-Reply-To: <20250310154725.GA34977@localhost>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 10 Mar 2025 15:07:28 -0700
X-Gm-Features: AQ5f1JqfAa29yT7sTP2PIMK6WpGkhzxonwbbCWIR3llUMKVgE3yYAreZti8gqnQ
Message-ID: <CAMKF1sps7Ui3SiER6Ck9S5FjYJfwi0UD3Jpp5hvPC8jRsceSqA@mail.gmail.com>
Subject: Re: [yocto-patches] Kernel and u-boot version selection in meta-rockchip
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?B?5YiY6Zm254S2?= <ltrsunny@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Mar 2025 22:08:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1175

On Mon, Mar 10, 2025 at 8:47=E2=80=AFAM Trevor Woerner via
lists.yoctoproject.org <twoerner=3Dgmail.com@lists.yoctoproject.org>
wrote:
>
> Hi Taoran,
>
> On Mon 2025-03-10 @ 11:10:31 AM, =E5=88=98=E9=99=B6=E7=84=B6 wrote:
> > Hi Trevor,
> > I'm trying to build the scarthgap branch for meta-rockchip and got erro=
rs
> > in kernel and u-boot.
> > I noticed it is because of the receipts in the branch. Just like
> > https://git.yoctoproject.org/meta-rockchip/tree/recipes-kernel/linux/li=
nux-torvalds-next_git.bb?h=3Dscarthgap
> >
> > it's using next-20240904 from linux-torvalds-next
> > <https://git.yoctoproject.org/meta-rockchip/tree/recipes-kernel/linux/l=
inux-torvalds-next_git.bb?h=3Dscarthgap>,
> > but the branches in this repository are expired very frequently.
> >
> > For the LTS version like scarthgap, when the version is frozen, it shou=
ld
> > be set to stable(better to be LTS) versions of kernel and u-boot, isn't=
 it?
>
> Yes it should, and it does... when it can.
>
> Yocto scarthgap is based on linux-6.6.y. All of the machines in
> meta-rockchip's scarthgap branch use oe-core's linux-yocto_6.6, except th=
e
> radxa zero 3 machines and the orangepi-5-plus. The reason for this is bec=
ause
> linux-6.6.y does not support these devices.
>
> oe-core scarthgap also provides a linux-yocto-dev kernel based on linux-6=
.9.y.
> This supports the orangepi-5-plus machine (so this machine uses that kern=
el in
> scarthgap) but linux-6.9.y still does not have support for the radxa zero=
 3
> devices.
>
> Yocto master currently supports linux-6.12.y with linux-yocto and linux-6=
.14.y
> with linux-yocto-dev. linux-6.12.y supports both the radxa zero 3 devices=
 and
> the orangepi-5-plus (which reminds me, I should update those machines sin=
ce
> they're still using linux-yocto-dev).
>
> So I assume you're probably using scarthgap to build for a radxa zero 3
> device since your comments are only true for that device. During the
> time-frame of scarthgap I was eager to be able to build for the radxa zer=
o 3
> since I had one and wanted to use it for a project. So I had to pull in w=
hat
> was (at that time) very experimental code to get it to work.

I think it would be nice to mark which machines are stable/mature vs
experimental
at the time this could convey the message, as the releases are frozen
in time this
problem is bound to happen.

>
> I could back-port oe-core master's linux-yocto to scarthgap in order to
> support the radxa zero 3 in a more stable way. But perhaps a better solut=
ion
> would be to remove radxa zero 3 support from scarthgap and simply ask tha=
t
> master be used for this device.
>
> Thoughts?

If you want to stay close to stable policies then yes, but BSP layers have =
taken
kernel roadmap as it fits the given family of SOCs so I would not discourag=
e you
from considering backport if there is a need for it in the given BSP
layer community.

>
> Best regards,
>         Trevor
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1173): https://lists.yoctoproject.org/g/yocto-patches=
/message/1173
> Mute This Topic: https://lists.yoctoproject.org/mt/111621524/1997914
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1334078=
6/1997914/645821814/xyzzy [raj.khem@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

