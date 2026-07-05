Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA2DC44500
	for <webhook@archiver.kernel.org>; Sun,  5 Jul 2026 22:30:04 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.139873.1783290599079688309
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 05 Jul 2026 15:29:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=RztniXio;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8eec5dfdb65so8247136d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 05 Jul 2026 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783290598; x=1783895398; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bwg3VXrLvaYKMXlX3FPGXczh3fC6eazqMg6JctMLUo=;
        b=RztniXiondNCjpd3cDDynN9beB1I3c/sEOrRW2O9Az9Ex2Ueu5+bey3DC+DBLjIEMc
         OlnJakfKL8K9Tnls5BCzUnjwasefKyIoIrZeR03WhwbXi1gwyh0r/4Yflh9tgS7T/Tfw
         LMv1abp07uc4XnF2bgMQRXM+HbvLytA1kMVKmaNCF3qjQsQNOzU2CtqfJ8Aq7XRe8mXF
         jxV1yNWCvJKVMvOP1KspEDYxv5Lnkl9VwV4bW/k0ZnwMcOc1R9f36C+ZyHUWZ1B85hsr
         9CB+yLwjkMeGGxpVYgb6p/0uHIixvM2jYpiFKx7BApjK0sFI3WjVdkPRYqDtgiPqQVzY
         fI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783290598; x=1783895398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bwg3VXrLvaYKMXlX3FPGXczh3fC6eazqMg6JctMLUo=;
        b=Ccj0W6EkNr81EUMafRvdym/sUT5US+aKv0t0yHGnFBbOPOekCPazIknoLcGcfVcbIn
         sxm3u6bjjwXuvCBo20bHYQW7/+EUoyvidLzBOaU6vyNwO1PIX/Lu+URvV/s9ZL6A7aqI
         51fWd2Kv40MP/SAs9ABXsZV5YKKLQ9R407bheJ6V56r4S0pgKZlxK+Tmmk56KDaNBQm/
         o061teVPbnlZuc/yC+OQk2nuFaK0iLfbpiGn4/6zvZwTvMGMbAaOmgCy2zOVGQ0Je7pW
         l+ETACccL7irQLRLGhGPHxc/kuhppi0tIzCcAgfX02YorNyX4U2TqJf8PkUO1pwa9gdB
         9zOw==
X-Gm-Message-State: AOJu0Yy4ZWVHiFrWwjexkIbLlzjZR1tfzAwf70aWJswC8z4NnBc//4J1
	pyJYdfwhZpN/rMUxynVR6D+dZoAVi0dxAiBEyMv7OBQfP+EdC0xHghBuwGrTpA==
X-Gm-Gg: AfdE7clRNFUGr2oZk0K2dFQ6/eWhsLn+xWwAMutHKA/ckpVqPqbNh1MbGqVTgs6A6H1
	/P0+w3g0Kk+6dGNiKjc4tqw9vtXgKKEoXiM2WUjHoYfMsNU8xN+Z+fBalc9dJEN8LOGgp5ancRv
	fv8NHZa1gqFJHtt2a5IHuuvpxrbmWDsA1J63R4JSg8vAumfhw6OUyFkNfsLbJf1n88iZM0zePYo
	LL4I6APBvyendytz06eRl9OWNub09GtY+MXNWSp6h+4O4erkxFAK+v4Gw42CCKKYekjB0f0KgN1
	aXrWPf3XbdK3eWAL293Nc/4Bj/WLLcwPuGyfWok8zCp4AcHd3cmp7HR2TdOaRiuvO0+AViT2v3S
	pr41p4D0wj09zExzOH40VgCYffwFUgtOSvpNbvaF2PjWuH4gWDyfhKflyYRqdM88NdIsDvEawxk
	gp0BK8U0EcNF99VH15EJopivUuvnjyYXwNWtmiHZCH
X-Received: by 2002:a05:6214:488f:b0:8ea:bcf7:b153 with SMTP id 6a1803df08f44-8f74bc91093mr128718946d6.34.1783290597808;
        Sun, 05 Jul 2026 15:29:57 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d526sm126051276d6.4.2026.07.05.15.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 15:29:56 -0700 (PDT)
Date: Sun, 5 Jul 2026 18:29:54 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: quentin.schulz=cherry.de@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH meta-rockchip 2/2] add support for baking
 OP-TEE OS into U-Boot proper binary
Message-ID: <akra4jhkqxfTYgq9@localhost.localdomain>
References: <20260126-optee-os-v1-0-874261a77dad@cherry.de>
 <20260126-optee-os-v1-2-874261a77dad@cherry.de>
 <ahcOBJWhevGNqPyF@localhost.localdomain>
 <1226166b-a604-4a40-95d1-68d8d5c64d05@cherry.de>
 <18B5F81EDB16A25D.1007@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18B5F81EDB16A25D.1007@lists.yoctoproject.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 05 Jul 2026 22:30:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4419

It looks like I forgot to add you, Quentin, to the "to:" or "cc:" for
this reply. Are you working on a v2?

On Thu 2026-06-04 @ 03:40:35 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Thu 2026-05-28 @ 10:48:24 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> > Hi Trevor,
> > 
> > On 5/27/26 5:30 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > Hi Quentin,
> > > 
> > > Thanks for this patch series!
> > > 
> > 
> > Thanks for the review!
> > 
> > > I believe there was a little fuzz required to apply patch 1 (around the
> > > -D), perhaps a v2 against the current to clean that up?
> > > 
> > 
> > I'm assuming due to commit 9fb264d42a20 ("bsp: fix upstream TF-A deploy
> > desync") already being merged.
> 
> Yes, I think so.
> 
> > > On Mon 2026-01-26 @ 03:48:30 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> > [...]
> > > > diff --git a/README b/README
> > > > index c2697d1..f49fdb5 100644
> > > > --- a/README
> > > > +++ b/README
> > > > @@ -222,6 +222,48 @@ Notes:
> > > >   	NOTE: this variable must be set before any include/require in the
> > > >   	      machine configuration file
> > > > +  OP-TEE
> > > > +
> > > > +	PX30, RK3399 and RK3588 are all supported by upstream OP-TEE OS. By
> > > > +	default, OP-TEE OS is not baked into U-Boot.
> > > > +
> > > > +	You can bake OP-TEE OS in U-Boot by setting:
> > > > +
> > > > +		RK_UBOOT_TEE = "1"
> > > 
> > > Is it worth pointing out this is a boolean so any of
> > > "1"/"y"/"yes"/"true" or "0"/"n"/"no"/"false" will work?
> > > 
> > 
> > Not sure it's worth the added complexity? We also don't say that for
> > RK_IMAGE_INCLUDES_UBOOT_ENV, RK_RAUC_DEMO, RK_KERNEL_FITIMAGE,
> > RK_OVERLAY_DEMO but we word it differently for them.
> > 
> > Would,
> > 
> > You can bake OP-TEE OS in U-Boot by enabling the RK_UBOOT_TEE variable
> > boolean.
> > 
> > work for you?
> 
> Sounds great!
> 
> > [...]
> > > > diff --git a/recipes-security/optee/optee-os_%.bbappend b/recipes-security/optee/optee-os_%.bbappend
> > > > new file mode 100644
> > > > index 0000000..2a5ec8b
> > > > --- /dev/null
> > > > +++ b/recipes-security/optee/optee-os_%.bbappend
> > > > @@ -0,0 +1,19 @@
> > > > +# Increase size for FDT in OP-TEE OS to the one in TF-A since v2.13 to avoid
> > > > +# panics on 64+KiB FDT passed by U-Boot to TF-A to OP-TEE OS.
> > > > +# Can be removed once https://github.com/OP-TEE/optee_os/pull/7687 is merged.
> > > > +EXTRA_OEMAKE:append:rockchip:aarch64 = " CFG_DTB_MAX_SIZE=0x60000"
> > > > +
> > > > +# Disable early console by default to avoid OP-TEE OS panicking on boards with
> > > > +# their UART console different from OP-TEE OS default (UART2 for rk322x, rk3399
> > > > +# and rk3588(s)).
> > > > +# In-tree default changes if https://github.com/OP-TEE/optee_os/pull/7688 merged
> > > > +OPTEE_OS_EARLY_CONSOLE ?= "n"
> > > > +EXTRA_OEMAKE:append:rockchip = " CFG_EARLY_CONSOLE=${OPTEE_OS_EARLY_CONSOLE}"
> > > > +
> > > > +# Enable hardware acceleration using Arm Cryptography Extensions on PX30.
> > > > +# Can be removed once https://github.com/OP-TEE/optee_os/pull/7689 is merged.
> > > 
> > > Have these 3 merges occurred yet?
> > > 
> > 
> > Yes.
> > 
> > b6c7291c246b ("plat-rockchip: increase FDT max size to 384KiB on all Aarch64
> > supported SoCs")
> > 763be3b08c16 ("plat-rockchip: disable early console by default")
> > 74eb4d9ed3ac ("plat-rockchip: px30: set CFG_CRYPTO_WITH_CE ?= y")
> > 
> > All available in 4.10.0. However, meta-arm currently is still at 4.9.0. I
> > don't see patches on their ML
> > (https://lore.kernel.org/yocto-meta-arm/?q=op-tee) for a version bump so we
> > need to keep those in for now.
> > 
> > I guess I can change the comment to say we need to keep this until 4.10.0?
> 
> Please do.
> 
> > At the same time, it shouldn't hurt keeping them in even in 4.10.0 or later.
> 
> Okay.
> 
> > Cheers,
> > Quentin
> > 
> > 
> > 
> > 
> > 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4142): https://lists.yoctoproject.org/g/yocto-patches/message/4142
> Mute This Topic: https://lists.yoctoproject.org/mt/117469183/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

