Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B21D4336B
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 04:57:31 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6024.1765515442782235941
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Dec 2025 20:57:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GYw+ugnb;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2958db8ae4fso8350115ad.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Dec 2025 20:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765515442; x=1766120242; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XjjPgZubXujw7KKEu2KjHGssLh41RQ3iuHUgluIQ4k=;
        b=GYw+ugnbydL9ksYDQOU6S8keRL2LlnYSbcteR3VGwyYfX4JARXE0CWyVDEZdbcpqWJ
         t8YXhmFbJSHFPEi5d+B/UVryeMAdWZbrjwa4bTt69w88LQk+1GtZxYGF146fmvwpfjJG
         nSchJk+syJqmA8BC3eLSHKoH3ACLEiPECWNhJAUrd3HRyN15EzyC33GpUh4+j8SkGl2N
         ODyRxuWuzgtT+7rXaikXuFSvpFSJdKdwcPqAjiq3GBqIo4+xxrkxXjFvjR/6VHp5eygd
         8CKapzTkY6yNuzGdQxwODhgOOa7ia28MDersfN+TQpnBmMcnZOCAea6wvLSd8XJJTDdq
         zC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765515442; x=1766120242;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6XjjPgZubXujw7KKEu2KjHGssLh41RQ3iuHUgluIQ4k=;
        b=Y7j3oMkucLK0bIbwghMVvzXuDlX5JzNtecRyJh5IrkoNcGLVZGZcD9rFpmXA3wdWBn
         1S16S/2cyz1SY6lE+ZjAwepr312ejIC7yQFCEZAk5x3NzthHyicJEsjpF7iR7t1YbNKe
         lfGcsskEs80Kn7MBQyrpSkq449oyCeN3Ag0WQQytU2ozN8emLUs2fga8A4MgmQeuAxJ9
         MyTf9a7nVpus/OUPhoVH4GaAXkMk3LsxV/WwOVKgCyscNfyjYjRC9RCSE7fCeovl7Y20
         NWeKW+n7KjIBU6q0T6r6LIhTwU4rDUHL5c+ugYd63wBivVxF3qsTGsvqQ/hfpO8niWEp
         3IAQ==
X-Gm-Message-State: AOJu0Yw3NiF4gYXMHHeu1ymM9DK5Ng4lJw4M44Uh2jaH6TYXLbiCWrnm
	zy/BpSa7EEod7bbBRerok86J3UFFQbtLEb3VEeNUV/3nBQU52TXivRjlgXtTOuhQVQs7n4ppEtj
	3QPk4mu/R6JnYut3O4exhrsl9w1wseW6NojjLoXk=
X-Gm-Gg: AY/fxX5tlWguAW6kXKDhLAu9IJpuZnXcEyMetVWjy3EDB2AHKEi9iyG+SwiKfCG3VvB
	DahLSnj7VhTUvLPJhJesLgJrPvpCWkFxjAi6Xd+cDA806tSHh91JIOWlRl1ZdekQtURpQlsi2Y6
	tMDTrBLfCGBWqY8v+PM95MTHmeUTNwY0DUByhBO7W2eEyH8MUvRC1sNWh44yn0L1dkyr8Llh/h3
	3d7HdWzHJq1RffV+3MJZypLnlfdJt5X1aJCsuFltPY/U9BUXbJ4UK6MCskYcHTSjvxI/MeF
X-Google-Smtp-Source: AGHT+IH+4x3U7gctXK0vC+t16yxZzdrsmP2VtHKoFOmqpTvB+yjzHgsfTEiFy3QCMlGsYxhkhu2JdPWi3VVnVVOxv7A=
X-Received: by 2002:a17:903:1510:b0:295:70b1:edcf with SMTP id
 d9443c01a7336-29f24034d17mr10105535ad.36.1765515441605; Thu, 11 Dec 2025
 20:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20251208193551.2426-1-twoerner@gmail.com> <e2a21a1f-050a-49da-b368-73f1c03f9157@cherry.de>
 <20251211202213.GA35676@localhost>
In-Reply-To: <20251211202213.GA35676@localhost>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Thu, 11 Dec 2025 23:57:09 -0500
X-Gm-Features: AQt7F2psFkVKP967m9LnVaCb3SoFGTg5oPKnlIYfLyqIAxvWSMcpTQgd-UQI_BQ
Message-ID: <CADkTA4OTV2jjm453h5VhhLsjC1nbEfnxgCMgPxQyB2XpBbB4XQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 1/2] make rockchip
 kernel tweaks easier to use
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 04:57:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2770

On Thu, Dec 11, 2025 at 3:22=E2=80=AFPM Trevor Woerner via
lists.yoctoproject.org <twoerner=3Dgmail.com@lists.yoctoproject.org>
wrote:
>
> On Thu 2025-12-11 @ 03:13:50 PM, Quentin Schulz via lists.yoctoproject.or=
g wrote:
> > Hi Trevor,
> >
> > On 12/8/25 8:35 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > If the machines defined in this layer are used, they will want to pul=
l
> > > in the kmeta data that is also provided in this layer when configurin=
g
> > > the Linux kernel. This all works automatically if linux-yocto or
> > > linux-yocto-dev are used. But it causes build failures if a kernel
> > > recipe is used or defined that is not one of these two.
> > >
> >
> > The issue is that we have machine configuration files settting the
> > KERNEL_FEATURES variable in a conf file instead of having it in the ker=
nel
> > recipe.
>
> As far as I am aware, there is no rule saying that KERNEL_FEATURES can
> only appear in kernel recipes; in fact I think that's the wrong way to
> think about them. The kernel provides many things, and each of these
> things can be configured in the kernel.

While there's no rule, it is just a variable and the variables follow the
standard scoping rules of bitbake. It isn't used like a configuration /
global scope variable, so it does get scoped to recipes.

It's the same way that you can't have recipe-a directly manipulating
the variables of recipe-b (or the classes used by those recipes).

You are also binding / coupling the kernel knowledge through different
parts of the system and that can cause issues. You can't have all
sorts of recipes making kernel configuration tweaks, as you will run
into conflicts and recipe-a and recipe-c will inevitably want conflicting
options, or will try and enable things that the hardware doesn't support.

I'm not describing that very well, I can try to explain it a different way
if that doesn't make sense.

What we've done in cases like this in the past, is just like any other
part of the system where you need coordination. Set a machine, distro
or image feature, use that variable to ensure that the kernel recipes
select the right KERNEL_FEATURES (and hence the right kernel
configuration options.

I'm not exactly what the error is that you are seeing and trying to
solve, but I'd suggest looking at meta-virtualization. I've solved
what I think you are encountering and describing, in that meta-virtualizati=
on
works with linux-yocto, works with non-linux yocto kernels, works with
specific versions and also maps virtualization packages/features to
specific KERNEL_FEATURES to ensure that any number of kernels
a user might want are configured in a way to support the stacks.

Cheers,

Bruce

>
> For example the kernel provides filesystem types. If you developed
> an application that, say, provided a fancy dashboard or status or
> configuration or debug interface to a particular filesystem, then
> I strongly feel the relevant KERNEL_FEATURES additions should be
> contained in the Yocto Project recipe for that application. Perhaps
> your application needs the CONFIG_*_FS_DEBUG flag enabled in the kernel
> in order to work correctly or fully, in that case the KERNEL_FEATURES
> should be specified in the recipe. There's no point having a user
> include your app in their image if the kernel doesn't provide the
> interface or data it needs to work correctly. I would even go a step
> further than that: ideally all Yocto Project recipes would include the
> KERNEL_FEATURES on which they depend, regardless of whether or not that
> feature is present by default via, say, the in-kernel defconfig. For
> example, a user might not be relying on some defconfig (regardless from
> where it comes, whether it be in-kernel or from a BSP). In that case,
> the recipe should work "out-of-the-box" for a user who is including
> it in their image. My guess is that currently throughout oe-core and
> meta-oe there are probably some recipes that have an implicit dependency
> on some kernel feature being enabled; I think those should be make
> explicit via KERNEL_FEATURES.
>
> Another thing a kernel provides is architecture- and SoC-specific
> code. In the same way as my user-space application example above,
> architecture- and SoC-specific KERNEL_FEATURES should be specified in
> machine configurations, not kernel recipes. Somebody building an image
> for a Rockchip-based device does not need (for example) Qualcomm support
> (and associated Qualcomm-specific drivers and features) in their kernel.
> In meta-rockchip, using one of the meta-rockchip-defined MACHINES
> disables Qualcomm (and others) support. This saves you in image size,
> it saves you in runtime RAM usage, and it shrinks the attack surface
> somewhat. You're suggesting meta-rockchip should have bbappends for
> various known kernel recipes in order to provide the user with the same
> kernel configuration adjustments, but this doesn't help a Rockchip user
> if/when they define their own kernel recipe, or use, say, linux-stable
> or linux-mainline from some of the kernel-specific Yocto Project layers
> that exist. In that case they will get no error or warnings, they just
> won't have any Rockchip-specific KERNEL_FEATURES enabled.
>
> In an ideal world kernels would be configured starting with nothing,
> from the ground up, by using KERNEL_FEATURES. BSP layers would add
> KERNEL_FEATURES based on which SoC/board you are using which would come
> into your build depending on which MACHINE you chose, software layers
> would add KERNEL_FEATURES based on what software you're including. A
> basic set of KERNEL_FEATURES would be available that most people would
> want, but it could be overridden or tweaked as the user sees fit for
> their purposes.
>
> I feel the correct location for Rockchip-specific KERNEL_FEATURES is in
> Rockchip MACHINE definitions, and I discovered they can be cumbersome to
> use when they are only available for specific kernel recipes. Moving the
> core of these files into an *.inc makes them available for all kernel
> recipes.
>
> > kernel-yocto.bbclass is the one reading the variable and expecting to f=
ind
> > an associated file defining what to do based on that variable.
> >
> > So, by setting KERNEL_FEATURES in the machine conf file but only adding=
 the
> > necessary files to linux-yocto and linux-yocto-dev, any other recipe wh=
ich
> > inherits kernel-yocto.bbclass will fail to find the file associated wit=
h
> > KERNEL_FEATURES (as the former is missing, currently only added in loca=
l
> > bbappens and the latter is set from a conf file so always set essential=
ly).
> >
> > > Putting this layer-specific metadata into an *.inc file (then
> > > referencing it in the kernel bbappends provided in this layer) makes
> > > that metadata available to any other kernel recipe through the "requi=
re"
> > > or "include" mechanism. Any other kernel recipe that is created can p=
ull
> > > in this metadata using either of these lines in the kernel recipe:
> > >
> > >     require recipes-kernel/linux/linux-rockchip.inc
> > >     include recipes-kernel/linux/linux-rockchip.inc
> > >
> >
> > That's an okay work-around but why not move KERNEL_FEATURES into the
> > recipe/bbappend so we don't break by default recipes which inherits
> > kernel-yocto? You can still have this into a .inc file so it's easier t=
o
> > include for other kernel-yocto-inheriting recipes.
> >
> > See meta-arm, oe-core with linux-yocto. I don't understand why we have
> > KERNEL_FEATURES:append:pn-linux-yocto and
> > KERNEL_FEATURES:append:pn-linux-yocto-rt in
> > meta/conf/machine/include/qemu.inc though. I'm assuming we can move tha=
t to
> > linux-yocto and linux-yocto-rt recipes.
> >
> > Cheers,
> > Quentin
> >
> >
> >
> >
> >
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2768): https://lists.yoctoproject.org/g/yocto-patches=
/message/2768
> Mute This Topic: https://lists.yoctoproject.org/mt/116682100/1050810
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1317149=
3/1050810/607820704/xyzzy [bruce.ashfield@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>


--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II

