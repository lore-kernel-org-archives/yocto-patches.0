Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0629C5AE59
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 15:46:39 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web11.15150.1748965592840319136
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Jun 2025 08:46:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Jt9JJOJ7;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f0ad744811so42557406d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Jun 2025 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748965591; x=1749570391; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6U19Rtr9Vi43EYFDgUTmP3KsLRkDDnUCuHOq1E07wY=;
        b=Jt9JJOJ7kty0pReAYtD5MZVCFuQnUki/TdayhnV8NZOBHlLBGNJ4i8auYctTFyJD1h
         tbcD5QhBiLJBdA1zecRXEhPJI0B0rHw51wuK4MnRQKgK4ghxHSx7X8zF0zpLwZiwXuUv
         jzoLejHBdarNYE1tvNsQs3S4uzkzQBITMCgYmRPHanv4pRGPlNiwY2VBxF6R/zMAkkLQ
         1H86JVMoNWfg4J1+yh9kNt0QfN6W24docL8M5Yg+MG2kWSEzGxMSymTd6veuRLbx0VHU
         UASz70YGuRekmKnFXbRQmyijkXoY50tW4IZynli1gZ592lG6ZprnPEJkr79PNy1VmKgJ
         rNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748965591; x=1749570391;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6U19Rtr9Vi43EYFDgUTmP3KsLRkDDnUCuHOq1E07wY=;
        b=RHGnmKf4mDR11EYMvgLKBYQZRfiEgSSI1XkuabKTHRBBpbMv7hF7A3rQZar1fg+Sjd
         ZDC1WNWWqeyrGHmOkavm4OMx8h9cCjoYJcu1p5hcpNka6KaTMRqyy3mjAk1w+lN1vO4Y
         tD0VV68WoufHTY5W3fr11cn8C7jaDDfFBBh9TZzu6bJRFH9tOUckYQOqIOtSM995P1Zg
         LJCUN9EHh0SYWp7dHSdGo9g1PEHdxZGKB3GsmkW4zYrcVrwf+gk9Ng7ixY981VQEF0Dp
         i5AhSNcs1mXHmHPFRKkbGfsiO4kA2FS4Fj+JlsYqZ8yogEHJc21AQlWXxDhpKDbFhNHq
         tC/A==
X-Gm-Message-State: AOJu0Yy0BRaaSFl6FFPs4naH08O0QRpjnHvbKS/idqa/mqDzpyYybZw6
	wiK45cIOftCW3NkuvimrDVlsGz9uYF3zH4BGSMAiw6TNg9QL+0kDazHwP/RsLcUr
X-Gm-Gg: ASbGncvoMENJBZ4nOeyzH8+RHi0qefGYFx0zym0hOCJf653doj1xfbZURhKQPpZEl6A
	0NLa2BmGX87sDsYqxIEdg38tA5ImRSBt06PR6k+XIcG/c0iwsuInX+ztJ5+WW9d4owcmeNDcGpP
	HwtljHwt2dSyYh8Mg11wG4plCqZu2STPPa5q3ed1zQfYAmZt4DJBMVvlSVIX/Aau+hTQ9QD2e1N
	6m3CtbaeAhwW7ca3lAQlV7k5JjRb6uQBAtAGUNyFIsYYKCafUhjGTUpYIHn3qjMNHR4Q2Aa3Xlp
	Oh30VHOVfBcR929HdPUUxEL09HbIE8fUZIA9dctdN8Zym9z4LChnd4KxrcXxCoZNopADMlC7JMD
	Gb+RV9amJ0YexDA==
X-Google-Smtp-Source: AGHT+IEGYh0VTv4bMBtuyaHJzQ/2GAGednCuC21YoWrjA/HHFr8Z9et+LK68fytqOqZ+Yuc4SQ9t6A==
X-Received: by 2002:ad4:5ca4:0:b0:6fa:cdc9:8b03 with SMTP id 6a1803df08f44-6fad90abaecmr226175776d6.16.1748965590754;
        Tue, 03 Jun 2025 08:46:30 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e00ca9sm81734616d6.78.2025.06.03.08.46.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 08:46:29 -0700 (PDT)
Date: Tue, 3 Jun 2025 11:46:27 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH 1/3] refactor mesa packageconfig
Message-ID: <20250603154627.GA31087@localhost>
References: <20250530172156.7199-1-twoerner@gmail.com>
 <2c631d6e-9296-4c4e-bcf8-13add7ee8ddf@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c631d6e-9296-4c4e-bcf8-13add7ee8ddf@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Jun 2025 15:46:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1610

On Mon 2025-06-02 @ 02:39:58 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> 
> Missing [meta-rockchip] in the subject :)
:-O

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
> 
> It seems like this is based on my Panthor patch series but it isn't
> explicitly listed in the dependency of this patch series?

True; what's the easiest way to express this?

> I'm fine if you
> want to take over my patch series, but I guess it'd make sense to have the
> patches (even reworked/squashed/fixed up) as part of this patch series now?

I was just going to add this update (whatever form it takes) immediately after
applying your patches. Your patches worked at the time they were submitted, so
I'm okay applying your patches on their own, then adding something else as a
separate commit.

