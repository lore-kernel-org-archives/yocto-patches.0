Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8B3C5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 15:53:09 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web10.15260.1748965988191698085
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Jun 2025 08:53:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l7DwFdJm;
 spf=pass (domain: gmail.com, ip: 209.85.210.47, mailfrom: twoerner@gmail.com)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7353779b10dso3434612a34.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Jun 2025 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748965987; x=1749570787; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QipDUThJrwlENqqpotVjy8q/7SgponuZiyo8kg7fkck=;
        b=l7DwFdJm1a0f/BvGAFZplwhFwoMWdLgW8ONbgb9IWxI6Q/7eqa3vgKArN5oB/cG8c9
         nYNtyo1/534to8uqOXTsj4YD+AAyBaAlWyQ+/TJeOjV3Gl/bCbfSIHLBkHs958HR9aTs
         4tbgUOu0DwHoAym/AyxZaqhia/bTvcV2Nmq4g0MBK3MH/tqOSifiteNSMqRQ0Kbokwah
         48ZJw6ZRu9TyXRz03HJXWfKWnGN8hAHaOe8jlZAmDEE4ROavyP/0ErzRvSK1FbTiDzTX
         yYPR5J3sXGWHxOwllx3R7tT/7KlTm7dx8igzhhyEA+GOFLgzvqSjKYA2xScfShEFzyyg
         1JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748965987; x=1749570787;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QipDUThJrwlENqqpotVjy8q/7SgponuZiyo8kg7fkck=;
        b=T+XswJCylV9hhHyyVCH5FCRpYDSpwJTQlV3TxXhJagK7U6Y12AnLJ8n8DnCJ6vv9bh
         4FBZmLmmUUmqgwvl+SFpfZkkZ4pZe1Q0RTGk5j0DdoA7qckiJynouK3CXl130Tgm0fsj
         ss/Ys+1jp0mlT+0ds3m7C2y/SmPMCvKgSnrFxeO1YAXTH5t3TLEV+I3GJv85JcWUUYkD
         cNM9IJOqliQkXnHF7wCY38szZr2jD5Yow4o3FEaLEhERjiUvjxb1CkIXFB7vK7ErFv10
         I3ytM00zd13n2H9OXQR8de3c2fSr/TGyxhhTnGnLCMMr6QDdUc/dQKNlooziZQieqi19
         zkQQ==
X-Gm-Message-State: AOJu0YwW2gyfTK15VD1MilfeU7YPiey1J00kgTfR2rPfLaMIlLr3C5Dy
	vSx0D02rEOkVPrkr3vHzcoo99GGeN2YkkPsCvim8qC1y5h/gGqhWQFp7M0wrwphO
X-Gm-Gg: ASbGnct+9WqLaTV9v2lPoRkM7tEwJ/q4n1Tc3IPd8ngz5KuT1Z4Es9FzjFqRBYY7LPF
	XAXS3pw+UXY255iyLw7rxnDPZwvAQsNKw1CJuEpMKVwAWTNsMkn+kHamh3CMBbX8DbGjiYDf8b0
	+cNlbaO/GqeGXyQareZfDfjriMWs+3066Zn5cEgx14BWnWggf6LJEGMhZPPUJx80fSuzYIw8u4n
	Ihr9a3pbNufb2qwjMjSEsS4uiEf7OZPC3DBRAur4QHSsY6hRWpcnES3n09PvqUlQrQjz7ugIP6W
	Kzx9V6YsLwCTVWBgMY/YG3ep1RmmMpuiaXYo/xsI9Qkli14xVighCvnN3d+nqL0GNrwOxqUvggD
	PE2Q=
X-Google-Smtp-Source: AGHT+IEQZtlK5gSXxUJDa6lo5L6KtJws5OLB4k4SHjWk3quQeiyARfxqqpj3fgyaOgxjSSFt2+iCBA==
X-Received: by 2002:a05:6214:d02:b0:6fa:c5be:dac7 with SMTP id 6a1803df08f44-6facebcf4bdmr340773586d6.18.1748965976317;
        Tue, 03 Jun 2025 08:52:56 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d5b4eesm82499756d6.56.2025.06.03.08.52.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 08:52:55 -0700 (PDT)
Date: Tue, 3 Jun 2025 11:52:53 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH 1/3] refactor mesa packageconfig
Message-ID: <20250603155253.GB31087@localhost>
References: <20250530172156.7199-1-twoerner@gmail.com>
 <8db48afc-fe3e-46fc-a733-1673548bb749@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8db48afc-fe3e-46fc-a733-1673548bb749@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Jun 2025 15:53:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1612

On Mon 2025-06-02 @ 02:22:12 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 5/30/25 7:21 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Add a new variable, RK_MESA_DRIVER, to allow the user to choose which mesa
> > "driver" they want to use for their mesa backend. By default set it to either
> > "panfrost" or "lima" depending on the SoC family being used.
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   README                              | 5 +++++
> >   conf/machine/include/px30.inc       | 1 +
> >   conf/machine/include/rk3288.inc     | 1 +
> >   conf/machine/include/rk3328.inc     | 1 +
> >   conf/machine/include/rk3399.inc     | 1 +
> >   conf/machine/include/rk3566.inc     | 1 +
> >   conf/machine/include/rk3568.inc     | 1 +
> >   conf/machine/include/rk3588s.inc    | 1 +
> >   recipes-graphics/mesa/mesa.bbappend | 9 ++-------
> >   9 files changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/README b/README
> > index 9672c6ab8d5b..97d06eaefd63 100644
> > --- a/README
> > +++ b/README
> > @@ -159,6 +159,11 @@ Notes:
> >   	compatible (see Rockchip Media Process Platform (MPP) and
> >   	downstream gstreamer-rockchip plugin for those kernels).
> > +  mesa backend
> > +	Use the variable RK_MESA_DRIVER to select which mesa backend to use
> > +	for mesa. By default it is set to either "panfrost" or "lima"
> > +	depending on SoC.
> > +
> 
> I don't think it makes sense to make it user modifiable. You cannot pick
> which driver you want to use as lima will only work with a specific family
> and panfrost with another one, they don't intersect.

Right, but what if someone wants to use mali? That's the use-case I had in
mind for making this user-modifiable.

> So I wouldn't actually document that at all.
> 
> >   U-Boot Environment:
> >   ------------------
> >   	In order to configure U-Boot to be able to store its environment into the
> > diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
> > index 8173cb19be2c..4918ee45d1ab 100644
> > --- a/conf/machine/include/px30.inc
> > +++ b/conf/machine/include/px30.inc
> > @@ -21,3 +21,4 @@ UBOOT_SUFFIX ?= "itb"
> >   UBOOT_ENTRYPOINT ?= "0x06000000"
> >   ENABLE_STATELESS_VPU_GST ?= "1"
> > +RK_MESA_DRIVER ?= "panfrost"
> 
> I would also make it = instead of ?= as there's no reason to override it?
> (and you could anyway if you wanted from a confi machine file including this
> SoC .inc file.
> 
> > diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
> > index 06fda69a3eb7..0fccae7896aa 100644
> > --- a/conf/machine/include/rk3288.inc
> > +++ b/conf/machine/include/rk3288.inc
> > @@ -16,3 +16,4 @@ KERNEL_IMAGETYPE ?= "zImage"
> >   UBOOT_SUFFIX ?= "bin"
> >   ENABLE_STATELESS_VPU_GST ?= "1"
> > +RK_MESA_DRIVER ?= "panfrost"
> > diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
> > index e6f810dcd2ca..cdc2e2df2703 100644
> > --- a/conf/machine/include/rk3328.inc
> > +++ b/conf/machine/include/rk3328.inc
> > @@ -22,3 +22,4 @@ UBOOT_SUFFIX ?= "itb"
> >   UBOOT_ENTRYPOINT ?= "0x06000000"
> >   ENABLE_STATELESS_VPU_GST ?= "1"
> > +RK_MESA_DRIVER ?= "lima"
> > diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
> > index cd1be49064ed..06326946f1e3 100644
> > --- a/conf/machine/include/rk3399.inc
> > +++ b/conf/machine/include/rk3399.inc
> > @@ -22,3 +22,4 @@ UBOOT_SUFFIX ?= "itb"
> >   UBOOT_ENTRYPOINT ?= "0x06000000"
> >   ENABLE_STATELESS_VPU_GST ?= "1"
> > +RK_MESA_DRIVER ?= "panfrost"
> > diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
> > index 6386ec7eb51c..4d84bf8a11a2 100644
> > --- a/conf/machine/include/rk3566.inc
> > +++ b/conf/machine/include/rk3566.inc
> > @@ -24,3 +24,4 @@ TFA_PLATFORM = "rk3568"
> >   TFA_BUILD_TARGET = "bl31"
> >   ENABLE_STATELESS_VPU_GST ?= "1"
> > +RK_MESA_DRIVER ?= "panfrost"
> > diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
> > index bcf9dd8b0f44..dedda3b8f47e 100644
> > --- a/conf/machine/include/rk3568.inc
> > +++ b/conf/machine/include/rk3568.inc
> > @@ -24,3 +24,4 @@ TFA_PLATFORM = "rk3568"
> >   TFA_BUILD_TARGET = "bl31"
> >   ENABLE_STATELESS_VPU_GST ?= "1"
> > +RK_MESA_DRIVER ?= "panfrost"
> > diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
> > index 6ec344abae5b..5a085ab29ebc 100644
> > --- a/conf/machine/include/rk3588s.inc
> > +++ b/conf/machine/include/rk3588s.inc
> > @@ -23,3 +23,4 @@ TFA_PLATFORM = "rk3588"
> >   TFA_BUILD_TARGET = "bl31"
> >   ENABLE_STATELESS_VPU_GST ?= "1"
> > +RK_MESA_DRIVER ?= "panfrost"
> > diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
> > index f22280754a14..9e9bf9afc4a0 100644
> > --- a/recipes-graphics/mesa/mesa.bbappend
> > +++ b/recipes-graphics/mesa/mesa.bbappend
> > @@ -1,9 +1,4 @@
> > -PACKAGECONFIG:append:rk3288 = " panfrost"
> > -PACKAGECONFIG:append:rk3328 = " lima"
> > -PACKAGECONFIG:append:rk3399 = " panfrost"
> > -PACKAGECONFIG:append:rk3566 = " panfrost"
> > -PACKAGECONFIG:append:rk3568 = " panfrost"
> > -PACKAGECONFIG:append:rk3588s = " panfrost"
> > -PACKAGECONFIG:append:px30 = " panfrost"
> > +PACKAGECONFIG:append:rockchip = " ${@bb.utils.contains('RK_MESA_DRIVER', 'panfrost', 'panfrost', '', d)}"
> > +PACKAGECONFIG:append:rockchip = " ${@bb.utils.contains('RK_MESA_DRIVER', 'lima', 'lima', '', d)}"
> 
> This is fine though :)
> 
> I'm wondering if we shouldn't simply make panfrost the default for all SoCs
> and only override it to lima for older SoCs (and I believe some have some
> Imagination GPUs too (like the RK3368?)). I guess for GPU-less systems we
> would need to unset the variable. Not sure what's best here :)

I agree that within the Yocto/OE community, the idiom is normally to set a
default then override it where needed. I tend to prefer listing/setting each
one explicitly, but that's just my preference.

