Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD37C71136
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 14:42:32 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web11.12093.1749825750326262755
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Jun 2025 07:42:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FWpoGP/N;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a5ae2fdf4eso36310781cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749825749; x=1750430549; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzR+oNX2oASlIkEd9MD3fwcfKG8WmjMofsDOBlfA+dY=;
        b=FWpoGP/Nyz/OPEeIsrZCwDJa2b4Jw5NMYOf2eN3O0IkVhuV0x0sGPfkDHinXjoPbgC
         9sCeFFPBRbHMVmZwe3gjAYn2Kz0lI+rx55I+A0fn2YjuJ+55j440itVOsbzY57GL0HTp
         zYblIkD72TxeTbZ66w+IDDbcJY9ldUAm8CPTm0XYdZuDJFxtaB1fjV171sOmCibAF1tJ
         4T5U9FwZRRS5E1y0pTbmf8J3RaJSomEb3bIOTBd4OB4gzmDBv4Lo67rxvy1WQ8zo5KNm
         AiDWh9snhJA6YVnt8iA0IIee0BpGKTInvUmBiRR4dtRd8l6IuYb4z57YBN8Bnt8j5C0Y
         IrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749825749; x=1750430549;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzR+oNX2oASlIkEd9MD3fwcfKG8WmjMofsDOBlfA+dY=;
        b=qagwfuHVL6z58avo6KckubzVDrHQ6725edm6Gr4KBZCd0q9XwNQsQ1Ay6OrYJ8n/5C
         MGSILdDOtlFjfEOwoejLmKFMnhW2qd89B+Lri6tY1O8Hz5UsMEeCJRIZUbSiYbdelnb5
         nPqVMF+CV0fgaloAwQ/npiOvW536drATV+K1fuJybhyoB33B3ApZKduRwjRgkiQu1SJW
         rBNK5vX18S0oIt2czYzLM9dZYxR5zZe8N6JOg0pKlSqC7p73e+DDuwI3bSvSPkY8oYsR
         7t3LOB5RXfQnUgqD7E46vLDf3J842lhmxs2c1c5zEThtreWw18zZt3nHyEwgRhapmgL+
         FOpw==
X-Gm-Message-State: AOJu0YziNxXwLvA+1yY8uSb8kJsqyeiXeBwfZtwGzehWy8yqIiT3JMFZ
	dXNQkIMjBcYHaIqTT8EqB3n6GbYCcsVQjSQKB/w+o3s+52kAy37H4diG0qMw6ArQ
X-Gm-Gg: ASbGncsb8Pa+CTk8y8X8ftnbsJC6smacC2+iIbXw9Ge67bumm/at78yOrEy6j/X8O24
	fMX7jSrGhMI7Dpze9HZd4reyPeSz4upb+/WyUmn0hk0LwYAunW3O3cOEP+PhIAm79Gz3Uczfvr6
	wLBjxzsi1Gbeh2Ota7lHHGrPVUsGcI9bgL7rVuPc0sW2ZXPWlD1/yuCo1az+tT/JLmok84BD4Du
	xZ1Kwea9GvcOsO+SiqRzwJz+g34/IHHLMeKEuy+S7MAA1u9doYKJwHCSLV3t+8IjkISB8e26wAq
	d+z2aX1t1xl0HWa80gI/NCltpqifxFCSmfeLuMX9J2/W1ZWTAJlN03nQWb7ML/SBlmJzxGmeXby
	ntf5duA3GjG/DAw==
X-Google-Smtp-Source: AGHT+IE8yuME/yJntjdqn4WY//87BV8S4GaIZvBpeLb/5BZt6JYoZpYTtrFa05ulCWJwPBxELUMldg==
X-Received: by 2002:a05:622a:3cb:b0:494:7076:3422 with SMTP id d75a77b69052e-4a739136489mr18042711cf.21.1749825748465;
        Fri, 13 Jun 2025 07:42:28 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a2c07b3sm17968771cf.9.2025.06.13.07.42.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:42:27 -0700 (PDT)
Date: Fri, 13 Jun 2025 10:42:25 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 2/2] fitimage rework
Message-ID: <20250613144224.GA6216@localhost>
References: <20250613102357.1539-1-twoerner@gmail.com>
 <20250613102357.1539-2-twoerner@gmail.com>
 <10a6a94d-2433-4517-9af5-5e78febfda79@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10a6a94d-2433-4517-9af5-5e78febfda79@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 14:42:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1641

On Fri 2025-06-13 @ 02:32:01 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/13/25 12:23 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > oe-core has completely re-written the fitImage support starting roughly at
> > commit [1], update meta-rockchip to match.
> > 
> 
> Thanks for looking into that!
> 
> > Most of the MACHINEs in meta-rockchip use a fitImage, but some don't. Create
> > a boolean variable (RK_FITIMAGE), enabled by default, to keep track of which
> > ones do and which ones don't. Use this variable to decide how to configure
> > various image-related fields.
> > 
> > Run tested on the following with RAUC configured:
> > 	- nanopi-m4b
> > 	- nanopi-r2s
> > 	- radxa-zero-3e
> > 	- rock-pi-4b
> > 	- rock-pi-e
> > 	- rock-pi-s
> > 
> > Run tested on the following without RAUC:
> > 	- radxa-zero-3e
> > 	- rock-pi-e
> > 	- rock-pi-s
> > 
> > [1] oe-core: 3442d9297dca ("oe-selftest: fitimage: test external dtb")
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   conf/machine/include/px30.inc              | 3 +--
> >   conf/machine/include/rk3066.inc            | 1 +
> >   conf/machine/include/rk3188.inc            | 1 +
> >   conf/machine/include/rk3288.inc            | 1 +
> >   conf/machine/include/rk3308.inc            | 3 +--
> >   conf/machine/include/rk3328.inc            | 3 +--
> >   conf/machine/include/rk3399.inc            | 3 +--
> >   conf/machine/include/rk3566.inc            | 3 +--
> >   conf/machine/include/rk3568.inc            | 3 +--
> >   conf/machine/include/rk3588s.inc           | 3 +--
> >   conf/machine/include/rockchip-defaults.inc | 2 ++
> >   conf/machine/include/rockchip-extlinux.inc | 8 ++++----
> >   conf/machine/include/rockchip-fitimage.inc | 4 ++++
> 
> Missing info in the top README about this new variable I believe?
> 
> >   13 files changed, 20 insertions(+), 18 deletions(-)
> >   create mode 100644 conf/machine/include/rockchip-fitimage.inc
> > 
> > diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
> > index 8173cb19be2c..825c1fae76d7 100644
> > --- a/conf/machine/include/px30.inc
> > +++ b/conf/machine/include/px30.inc
> > @@ -11,8 +11,7 @@ require conf/machine/include/arm/armv8a/tune-cortexa35.inc
> >   require conf/machine/include/rockchip-wic.inc
> >   KBUILD_DEFCONFIG ?= "defconfig"
> > -KERNEL_CLASSES = "kernel-fitimage"
> > -KERNEL_IMAGETYPE ?= "fitImage"
> > +require conf/machine/include/rockchip-fitimage.inc
> 
> question: should this be only included when RK_FITIMAGE = "True"?
>
> some sort of inherit_defer but for require? Or maybe we should set the
> variables in rockchip-fitimage only if RK_FITIMAGE = "True" and leave them
> as is if False?
> 
> It seems like SoCs with RK_FITIMAGE = "False" should not inherit
> rockchip-fitimage.inc and those with True should? What happens if you have a
> board outside of meta-rockchip with px30 which you don't want to support
> fitImage by default (that's my case, so I guess I'll need to build this to
> figure it out :) ).

Yes, exactly. I would have preferred to have it setup such that
conf/machine/include/rockchip-fitimage.inc is either:
	1) required conditionally
	2) would include some sort of if/else logic to only apply fit-related
	   options when RK_FITIMAGE is true
but I couldn't find some mechanism to do that.

I could think about it some more, I haven't looked into inherit_defer.

> >   TFA_PLATFORM = "px30"
> >   TFA_BUILD_TARGET = "bl31"
> > diff --git a/conf/machine/include/rk3066.inc b/conf/machine/include/rk3066.inc
> > index a898309bbf88..dc0c7734812c 100644
> > --- a/conf/machine/include/rk3066.inc
> > +++ b/conf/machine/include/rk3066.inc
> > @@ -9,6 +9,7 @@ require conf/machine/include/arm/armv7a/tune-cortexa9.inc
> >   SERIAL_CONSOLES = "115200;ttyS2"
> > +RK_FITIMAGE = "False"
> >   KBUILD_DEFCONFIG = "multi_v7_defconfig"
> >   KERNEL_FEATURES:append:rk3066 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> >   KERNEL_IMAGETYPE ?= "zImage"
> > diff --git a/conf/machine/include/rk3188.inc b/conf/machine/include/rk3188.inc
> > index 554d4f1c904d..3e1fc7e70822 100644
> > --- a/conf/machine/include/rk3188.inc
> > +++ b/conf/machine/include/rk3188.inc
> > @@ -9,6 +9,7 @@ require conf/machine/include/arm/armv7a/tune-cortexa9.inc
> >   SERIAL_CONSOLES = "115200;ttyFIQ0"
> > +RK_FITIMAGE = "False"
> >   KBUILD_DEFCONFIG = "multi_v7_defconfig"
> >   KERNEL_FEATURES:append:rk3188 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> >   KERNEL_IMAGETYPE ?= "zImage"
> > diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
> > index 06fda69a3eb7..5cc117e633fc 100644
> > --- a/conf/machine/include/rk3288.inc
> > +++ b/conf/machine/include/rk3288.inc
> > @@ -9,6 +9,7 @@ require conf/machine/include/arm/armv7a/tune-cortexa17.inc
> >   SERIAL_CONSOLES = "115200;ttyS2"
> > +RK_FITIMAGE = "False"
> >   KBUILD_DEFCONFIG ?= "multi_v7_defconfig"
> >   KERNEL_FEATURES:append:rk3288 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> >   KERNEL_IMAGETYPE ?= "zImage"
> > diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
> > index d30901f15b4f..ce1cebee1aac 100644
> > --- a/conf/machine/include/rk3308.inc
> > +++ b/conf/machine/include/rk3308.inc
> > @@ -13,8 +13,7 @@ SERIAL_CONSOLES = "1500000;ttyS0"
> >   KBUILD_DEFCONFIG ?= "defconfig"
> >   KERNEL_FEATURES:append:rk3308 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> > -KERNEL_CLASSES = "kernel-fitimage"
> > -KERNEL_IMAGETYPE ?= "fitImage"
> > +require conf/machine/include/rockchip-fitimage.inc
> >   UBOOT_SUFFIX ?= "itb"
> >   UBOOT_ENTRYPOINT ?= "0x06000000"
> > diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
> > index e6f810dcd2ca..4924b06f030a 100644
> > --- a/conf/machine/include/rk3328.inc
> > +++ b/conf/machine/include/rk3328.inc
> > @@ -12,8 +12,7 @@ require conf/machine/include/rockchip-wic.inc
> >   KBUILD_DEFCONFIG ?= "defconfig"
> >   KERNEL_FEATURES:append:rk3328 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> > -KERNEL_CLASSES = "kernel-fitimage"
> > -KERNEL_IMAGETYPE ?= "fitImage"
> > +require conf/machine/include/rockchip-fitimage.inc
> >   TFA_PLATFORM = "rk3328"
> >   TFA_BUILD_TARGET = "bl31"
> > diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
> > index cd1be49064ed..eb23f49370fc 100644
> > --- a/conf/machine/include/rk3399.inc
> > +++ b/conf/machine/include/rk3399.inc
> > @@ -12,8 +12,7 @@ require conf/machine/include/rockchip-wic.inc
> >   KBUILD_DEFCONFIG ?= "defconfig"
> >   KERNEL_FEATURES:append:rk3399 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> > -KERNEL_CLASSES = "kernel-fitimage"
> > -KERNEL_IMAGETYPE ?= "fitImage"
> > +require conf/machine/include/rockchip-fitimage.inc
> >   TFA_PLATFORM = "rk3399"
> >   TFA_BUILD_TARGET = "bl31"
> > diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
> > index 6386ec7eb51c..c9647a66aa42 100644
> > --- a/conf/machine/include/rk3566.inc
> > +++ b/conf/machine/include/rk3566.inc
> > @@ -11,8 +11,7 @@ require conf/machine/include/rockchip-wic.inc
> >   KBUILD_DEFCONFIG ?= "defconfig"
> >   KERNEL_FEATURES:append:rk3566 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> > -KERNEL_CLASSES = "kernel-fitimage"
> > -KERNEL_IMAGETYPE ?= "fitImage"
> > +require conf/machine/include/rockchip-fitimage.inc
> >   PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
> >   PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> > diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
> > index bcf9dd8b0f44..e89aa388951a 100644
> > --- a/conf/machine/include/rk3568.inc
> > +++ b/conf/machine/include/rk3568.inc
> > @@ -11,8 +11,7 @@ require conf/machine/include/rockchip-wic.inc
> >   KBUILD_DEFCONFIG ?= "defconfig"
> >   KERNEL_FEATURES:append:rk3568 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> > -KERNEL_CLASSES = "kernel-fitimage"
> > -KERNEL_IMAGETYPE ?= "fitImage"
> > +require conf/machine/include/rockchip-fitimage.inc
> >   PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
> >   PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> > diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
> > index 6ec344abae5b..265244753b5a 100644
> > --- a/conf/machine/include/rk3588s.inc
> > +++ b/conf/machine/include/rk3588s.inc
> > @@ -10,8 +10,7 @@ require conf/machine/include/rockchip-wic.inc
> >   KBUILD_DEFCONFIG ?= "defconfig"
> >   KERNEL_FEATURES:append:rk3588s = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> > -KERNEL_CLASSES = "kernel-fitimage"
> > -KERNEL_IMAGETYPE ?= "fitImage"
> > +require conf/machine/include/rockchip-fitimage.inc
> >   PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
> >   PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> > diff --git a/conf/machine/include/rockchip-defaults.inc b/conf/machine/include/rockchip-defaults.inc
> > index 85ec7b944d1d..3835408ed8d2 100644
> > --- a/conf/machine/include/rockchip-defaults.inc
> > +++ b/conf/machine/include/rockchip-defaults.inc
> > @@ -1,7 +1,9 @@
> >   # meta-rockchip default settings
> >   MACHINEOVERRIDES =. "${@bb.utils.contains('ROCKCHIP_CLOSED_TPL', '1', 'closed-tpl:', '', d)}"
> >   MACHINEOVERRIDES =. "rockchip:"
> > +
> >   # kernel
> > +RK_FITIMAGE ?= "True"
> 
> What about using a more typical 0/1 like we do for other variables?
> ENABLE_STATELESS_VPU_GST or RKBIN_DDR_RECONFIGURE for example?

lol, the last time i used a 0/1 you said: a boolean would be more appropriate
;-)

> 
> >   PREFERRED_PROVIDER_virtual/kernel ?= "linux-yocto"
> >   KCONFIG_MODE ?= "alldefconfig"
> > diff --git a/conf/machine/include/rockchip-extlinux.inc b/conf/machine/include/rockchip-extlinux.inc
> > index fddab735bbf7..95a38d4dad0c 100644
> > --- a/conf/machine/include/rockchip-extlinux.inc
> > +++ b/conf/machine/include/rockchip-extlinux.inc
> > @@ -13,13 +13,13 @@ NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split()[0].split('/')[1]}"
> >   UBOOT_EXTLINUX ?= "1"
> >   UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=rootfsA"
> > -UBOOT_EXTLINUX_FDTDIR ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"
> > -UBOOT_EXTLINUX_FDT ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot/${NONFITDT}', d)}"
> > +UBOOT_EXTLINUX_FDTDIR ?= "${@ '' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE'),False) else '/boot'}"
> > +UBOOT_EXTLINUX_FDT ?= "${@ '' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE'),False) else '/boot/${NONFITDT}'}"
> 
> I guess you can avoid the ,False part as the default is None, which should
> fail your if condition. Just a matter of taste though.

If that works, great! I dislike the silly ",False" part.

> >   UBOOT_EXTLINUX_CONSOLE ?= "earlycon console=tty1 console=${RK_CONSOLE_DEVICE},${RK_CONSOLE_BAUD}n8"
> >   UBOOT_EXTLINUX_KERNEL_ARGS ?= "rootwait rw rootfstype=ext4"
> > -UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${KERNEL_IMAGETYPE}"
> > +UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${@ 'fitImage' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE'),False) else '${KERNEL_IMAGETYPE}'}"
> 
> Ditto.
> 
> >   UBOOT_EXTLINUX_LABELS ?= "default"
> >   UBOOT_EXTLINUX_MENU_DESCRIPTION:default ?= "${MACHINE}"
> >   MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "u-boot-extlinux"
> > -MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "kernel-image ${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', 'kernel-devicetree', d)}"
> > +MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "${@ 'linux-yocto-fitimage' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE'),False) else 'kernel-devicetree'}"
> > diff --git a/conf/machine/include/rockchip-fitimage.inc b/conf/machine/include/rockchip-fitimage.inc
> > new file mode 100644
> > index 000000000000..e275faf70349
> > --- /dev/null
> > +++ b/conf/machine/include/rockchip-fitimage.inc
> > @@ -0,0 +1,4 @@
> > +KERNEL_CLASSES += "kernel-fit-extra-artifacts"
> > +KERNEL_IMAGETYPE = "Image"
> > +RRECOMMENDS:${KERNEL_PACKAGE_NAME}-base = ""
> > +KERNEL_DEPLOY_DEPEND = "linux-yocto-fitimage:do_deploy"
> 
> Should this be a ?= so that we can easily override/change it?

Sounds good, probably the KERNEL_IMAGETYPE too?


> Looks ok to me otherwise, I have px30, rk3399 and rk3588 boards which do not
> use fit images so I'll try to check this next week. Considering
> meta-rockchip doesn't build at all anymore, I guess you may want to fix this
> ASAP your way and I can figure out a way to fix it up "further" for
> non-fitimages scenario?).

I agree. But i think there are some v2 things i could do now.

> 
> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1640): https://lists.yoctoproject.org/g/yocto-patches/message/1640
> Mute This Topic: https://lists.yoctoproject.org/mt/113621966/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

