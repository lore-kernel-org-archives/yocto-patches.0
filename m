Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAAAE7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 16:11:03 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web10.38035.1734279062288985355
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 08:11:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XvAzEykN;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46772a0f8fbso30254641cf.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 08:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734279061; x=1734883861; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJj3Lf4m21AhDCcga/L3oSG5SyWfxceNwoY7rjJxozE=;
        b=XvAzEykNbu/WPKb+4+XbWxQdiqTtnRtRJMUGHHCquZce13tqdAgLUH2l1MkYTEeeL5
         rk2ktYfc80mc+DpDdefE6xKubPBB11S6wz9DsOVoJdwptqw/aIlipz7xC4K7N/bBNYWV
         9UiLcYFWBbqYySlgIF/KY+xeBQ44yc09UUsnNHcUdr6bNJzExf4zWvHP+i6O/q0yeNLy
         gsIWuJruk1ws4LjeGe64aFxqkkSpEfTAD+ug4PApt07PnJcEyGCHIkODMNla2zkQw3mz
         ba40XgZvVBZ93DfAtHpSFFORLd5+00AW5ymRSQVO48XZ8iHosi2xP/t7shl1EkILP77U
         Tkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734279061; x=1734883861;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJj3Lf4m21AhDCcga/L3oSG5SyWfxceNwoY7rjJxozE=;
        b=C0Q7ZLXIgmiT+GP+ShYcBFCSxu/wpFGY2AJvCQVhKA1qy/niBDRKqqc+5OfEfMz147
         LQjUbDrmHfUXiNtlIclM2sN6a4v/ja3YvtyETGzrGREk8c3DOzhDOQl5j17myLJGQmnU
         AqWsCBnnNdbKGWfiCq6bERXRVd4i7pNOPfwMHZshWWwRtbBUQl3JTx9MP7DJKKd/DxnC
         IuOGGSS5Ks0IPAqKg2T70/QcLVmEEv3CdlGHYweIvshBlAaUDPm3oRoXE7uFjwAiOT7U
         Ult6a+dF92uLVRGkqO13G8jVKxJaYYpRxc96CWEpZ97R/XB/7M48Rmj9zYZYeKvX39rZ
         y/zQ==
X-Gm-Message-State: AOJu0YwXe5RAbvAwbQmrOKx4yMRFxryebCjXy2YpItVs8Hih1x5BWCyQ
	b7337Ayw3qyUthvprI7VMisC479Opnf07JIRyxmC15CF0ZyTCzC6
X-Gm-Gg: ASbGncujPnPfeo4f0yT8N44FFJ6tT7XWLBicaJYNXuCAQJoyC//CgJttToRsqPNscUC
	MXFXkK156TiqmBpRVPB2xQ8bUpcgNcIS6eFn4wo1G40PhBZO5//UKJqGBarGMl8grDvSVzc0B1i
	CvYVeR14dmTbdL5Y1HpN0WAHSzV9cBSLjVEdgd3uu1XuwboW7Mh2pouUe7dbPRrOwejJmgzZVPm
	LuydlWi4cCj/50FgJjH6nd/3c4Cu04qkR7z9BteUq9Zs8r2yBd9RpsoU0C4KYRzyKBsHWB9b+1N
	3jb3D0nD
X-Google-Smtp-Source: AGHT+IFYg0QMF9m8hPA2ddyZAXGVRPdJRoOQH/iTKAZexLkwQrO836BCmQH08rzhXcmSg0lNkl5VIw==
X-Received: by 2002:a05:622a:1187:b0:466:9bc4:578 with SMTP id d75a77b69052e-467a5793512mr165886541cf.22.1734279061207;
        Sun, 15 Dec 2024 08:11:01 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2a8447asm18379171cf.0.2024.12.15.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:10:59 -0800 (PST)
Date: Sun, 15 Dec 2024 11:10:56 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Oleksii Kurochko <oleksii.kurochko@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [PATCH 3/3] radxa-zero-3: switch to yocto-dev kernel
Message-ID: <20241215161056.GA2613@localhost>
References: <20241212195718.25203-1-twoerner@gmail.com>
 <20241212195718.25203-3-twoerner@gmail.com>
 <ef1b59d8-a018-44fc-8f0c-e58db58380d9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef1b59d8-a018-44fc-8f0c-e58db58380d9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 16:11:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/913

Is this also a styhead-specific issue?

On Sun 2024-12-15 @ 04:10:51 PM, Oleksii Kurochko wrote:
> Hello Trevor,
> 
> On 12/12/24 8:57 PM, Trevor Woerner wrote:
> > The radxa-zero-3{e|w} devices are not supported in the current yocto kernel,
> > but they are supported in the yocto-dev kernel. Switch to yocto-dev until
> > support is available in the yocto kernel.
> > 
> > Reported-by: Oleksii Kurochko<oleksii.kurochko@gmail.com>
> > Signed-off-by: Trevor Woerner<twoerner@gmail.com>
> > ---
> >   conf/machine/include/radxa-zero-3.inc         |  2 +-
> >   ...xt_%.bbappend => linux-yocto-dev.bbappend} |  0
> >   .../linux/linux-torvalds-next_git.bb          | 25 -------------------
> >   recipes-kernel/linux/linux-yocto-dev.bbappend |  2 ++
> >   4 files changed, 3 insertions(+), 26 deletions(-)
> >   rename dynamic-layers/rk-rauc-demo/recipes-kernel/linux/{linux-torvalds-next_%.bbappend => linux-yocto-dev.bbappend} (100%)
> >   delete mode 100644 recipes-kernel/linux/linux-torvalds-next_git.bb
> > 
> > diff --git a/conf/machine/include/radxa-zero-3.inc b/conf/machine/include/radxa-zero-3.inc
> > index 1c6f972c1e31..b351afae8c0f 100644
> > --- a/conf/machine/include/radxa-zero-3.inc
> > +++ b/conf/machine/include/radxa-zero-3.inc
> > @@ -2,7 +2,7 @@ MACHINEOVERRIDES =. "radxa-zero-3:"
> >   require conf/machine/include/rk3566.inc
> > -PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
> > +PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-dev"
> >   MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
> >   UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
> > diff --git a/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-yocto-dev.bbappend
> > similarity index 100%
> > rename from dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend
> > rename to dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-yocto-dev.bbappend
> > diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
> > deleted file mode 100644
> > index b961b1408f09..000000000000
> > --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
> > +++ /dev/null
> > @@ -1,25 +0,0 @@
> > -FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto-dev:"
> > -
> > -DESCRIPTION = "Linux Kernel"
> > -SECTION = "kernel"
> > -LICENSE = "GPL-2.0-only"
> > -LIC_FILES_CHKSUM ="file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
> > -
> > -ERROR_QA:remove = "buildpaths"
> > -DEFAULT_PREFERENCE = "-1"
> > -COMPATIBLE_MACHINE = "^$"
> > -COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
> > -
> > -LINUX_VERSION = "6.11-rc6"
> > -KERNEL_VERSION_SANITY_SKIP = "1"
> > -PV = "${LINUX_VERSION}+git${SRCPV}"
> > -SRC_URI = " \
> > -	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1 \
> > -	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
> > -	"
> > -# this is tag 'next-20240904'
> > -SRCREV = "fdadd93817f124fd0ea6ef251d4a1068b7feceba"
> > -
> > -inherit kernel
> > -inherit kernel-yocto
> > -require recipes-kernel/linux/linux-yocto.inc
> > diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
> > index b6a63d7b7b29..f738d1357d6c 100644
> > --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
> > +++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
> > @@ -1,5 +1,7 @@
> >   FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
> >   COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
> > +COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
> >      SRC_URI:append:orangepi-5-plus =" file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
> > +SRC_URI:append:radxa-zero-3 = "file://rockchip-kmeta;ty
> After applying of this patch series I see the following compilation issue
> for kernel:
>     | ERROR: modpost: vmlinux: local symbol 'security_path_rmdir' was
> exported
>     | make[2]: *** [/home/ok/Projects/yocto/build/tmp/work-shared/radxa-zero-3e/kernel-source/scripts/Makefile.modpost:145:
> vmlinux.symvers] Error 1
>     | make[1]: *** [/home/ok/Projects/yocto/build/tmp/work-shared/radxa-zero-3e/kernel-source/Makefile:1871:
> modpost] Error 2
> 
>     | make: *** [/home/ok/Projects/yocto/build/tmp/work-shared/radxa-zero-3e/kernel-source/Makefile:240:
> __sub-make] Error 2
> 
> 
> Should I apply something except the patches from these patch series?
> Otherwise I think we should disable some security things ( as a workaround
> ):
> 
> CONFIG_SECURITYFS=n CONFIG_SECURITY_NETWORK=y CONFIG_SECURITY_NETWORK_XFRM=n
> CONFIG_SECURITY_PATH=y CONFIG_SECURITY_LANDLOCK=y
> 
> Best regards,
> 
>  Oleksii
> 
> 
> > pe=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"

