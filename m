Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FC0C27C53
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 13:33:21 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web10.11491.1718199191373357277
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Jun 2024 06:33:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dE/8uUi2;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7961fb2d1cfso234823085a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Jun 2024 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718199190; x=1718803990; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jE3MvDVusvm1MKrnbhMX93zLdaWrtoteZkvv49KIpHo=;
        b=dE/8uUi2dPLTNJjjcuLB4HQYzeI62wYLP5GK/twPmsVmeQ97JLsCab2u9YFitVBUXB
         BhbVAN1IOoYxYnOuAQ+FihefU0x1fD/+QmAjShCfyi3CoBGA+hUxz3BSvbicEo6twY8w
         jDUx8zEhI44soGHatbsPQjUoUhgjy3Mcayu4zncdVpJ0XIHxujwdVzJazoygdKT650Sa
         2ghs1FxHZMz9JxWZ5Iptq477KSV3QAwJ1lexuYfyMdpsNGa/cofYsA8H3r5igVGb44dI
         xSRgWdSOWklX2TSbR18WTo9jVzTeJv380PSnhb59DWmkeQENsRASxC2SttqDmHg054yT
         HLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718199190; x=1718803990;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jE3MvDVusvm1MKrnbhMX93zLdaWrtoteZkvv49KIpHo=;
        b=wRUt6ZnjHgRkT+R4wQbkhif1WvdFrvGTXMe4CtZoKT4SUYmbL6CZnWWM9B3dIkQVmg
         15fs8fY5XH4x1fLeYbvHnUNsZNE6Hfi4/naql48Y9glciqez4cU2fv09o2CVYsw95iPh
         VfF8cr/6SGvRGt1JFmGu2H2FRsKv5jtCSQ1XQMD2U96983loXK0qFMTdIT9CGgG4uIf5
         z3sKkuiWSFIuWnqYXlKzJY2+QVv3IX/d+xqm0J07J23OQk5eiFkzbg9y00yOM5L1/bSz
         fXq9RUcBj6GL9hUkUlnQpm/r6YLH7IbVm83tJgcL7DIk0YAmiEmeZqHDrSxW3csy24uT
         akDA==
X-Gm-Message-State: AOJu0YxeWztRe5YTl5REE+Z6x6hZRueU33ycBX/PUwfT39Aipt/zQXlC
	4hkCo5mnSGM2Urutlsy+wVs273ARSmYt/HZeWk9Sd1dUW5erhwHQfeBPug==
X-Google-Smtp-Source: AGHT+IGj37ojswazF8yqzWYgoGmsfTf0dOcluaZSNi56Hbdp98DTR8DocS8R2Y1f3mNlmXcuPb9VEQ==
X-Received: by 2002:a05:620a:2913:b0:795:813b:fa5b with SMTP id af79cd13be357-797f61336f3mr221275885a.30.1718199189484;
        Wed, 12 Jun 2024 06:33:09 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795c59df67bsm286172085a.19.2024.06.12.06.33.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:33:08 -0700 (PDT)
Date: Wed, 12 Jun 2024 09:33:06 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] radxa-zero-3e: add
Message-ID: <20240612133306.GB25815@localhost>
References: <20240612020116.40600-1-twoerner@gmail.com>
 <533c2092-1a89-4355-a679-1ade8a9555aa@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <533c2092-1a89-4355-a679-1ade8a9555aa@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Jun 2024 13:33:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/316

On Wed 2024-06-12 @ 11:03:13 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/12/24 4:01 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> > The Radxa ZERO 3e is an ultra-small, high-performance single board computer
> > based on the Rockchip RK3566, with a compact form factor, and rich interfaces.
> > 
> > 	http://radxa.com/products/zeros/zero3e/
> > 
> > tech specs:
> > - Rockchip RK3566 (4x Arm Cortex-A55 @ 1.6GHz)
> > - Arm Mali-G52-2EE (OpenGL ES 1.1/2.0/3.0/3.1/3.2, Vulkan 1.1, OpenCL 2.0)
> > - LPDDR4 RAM (1/2/3/8 GB)
> > - µSD
> > - GbE
> > - 1x USB 2.0 Type C OTG, 1x USB 3.0 Type C Host
> > - 1x µHDMI (1080p @ 60fps)
> > - 1x MIPI CSI camera port
> > - colour-coded 40-pin GPIO (uart, spi, i2c, pcm/i2s, pwm, gpio)
> > - 72mm x 30mm
> > 
> > NOTE: currently support for this board requires a U-Boot fork for the
> > bootloader, and linux-next for the kernel. Support will probably come in linux
> > kernel 6.11-ish, at which point U-Boot will then use that kernel's device tree
> > which means U-Boot support will come after the release of whichever kernel
> > includes support for this board.
> > 
> 
> Jonas has added support for generic builds for some Rockchip SoCs, maybe you
> could use that if it provides enough features for now and allows to reach
> Linux userspace?
> 
> The target is probably generic-rk3568_defconfig for this board for example.

Sounds interesting, I'll take a look.

> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   README                                        |  1 +
> >   conf/machine/include/rk3566.inc               | 21 ++++++++++++++++++
> >   conf/machine/radxa-zero-3e.conf               | 12 ++++++++++
> >   recipes-bsp/rkbin/rockchip-rkbin_git.bb       | 11 ++++++++++
> >   recipes-bsp/u-boot/u-boot-rockchip.inc        |  2 ++
> >   recipes-bsp/u-boot/u-boot_%.bbappend          |  5 +++++
> >   .../linux/linux-torvalds-next_git.bb          | 22 +++++++++++++++++++
> >   7 files changed, 74 insertions(+)
> >   create mode 100644 conf/machine/include/rk3566.inc
> >   create mode 100644 conf/machine/radxa-zero-3e.conf
> >   create mode 100644 recipes-kernel/linux/linux-torvalds-next_git.bb
> > 
> > diff --git a/README b/README
> > index b21e92360dcc..a9a040a4308d 100644
> > --- a/README
> > +++ b/README
> > @@ -40,6 +40,7 @@ Status of supported boards:
> >   		orangepi-5-plus
> >   		rock-3a
> >   		rock-4c-plus
> > +		radxa-zero-3e
> >   	builds:
> >   		marsboard-rk3066
> >   		radxarock
> > diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
> > new file mode 100644
> > index 000000000000..41d0a227a988
> > --- /dev/null
> > +++ b/conf/machine/include/rk3566.inc > @@ -0,0 +1,21 @@
> > +SOC_FAMILY = "rk3566"
> > +
> > +DEFAULTTUNE ?= "cortexa55"
> > +
> > +ROCKCHIP_CLOSED_TPL ?= "1"
> > +
> > +require conf/machine/include/soc-family.inc
> 
> I think the RK3566 is a stripped down version of the RK3568 and the common
> parts are handled by rk356x.dtsi for example.
> 
> I'm wondering if we should have the same trick we have for rk3588s and
> rk3588 to have a common override to not have to maintain variable/function
> overrides for both SoCs?
> 
> EDIT: seems like there's a different DDR bin for RK3566 and RK3568, make it
> make sense. Probably because the RK3568 seems to be able to support ECC on
> DDR4?
> 
> > +require conf/machine/include/rockchip-defaults.inc
> > +require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
> > +require conf/machine/include/rockchip-wic.inc
> > +
> > +KBUILD_DEFCONFIG ?= "defconfig"
> > +#KERNEL_FEATURES:append:rk3566 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> 
> Did you mean to keep this comment here?

I was so excited about it working I wasn't very careful. I actually want to
uncomment the line and add the required bits to make this work.

> > +KERNEL_CLASSES = "kernel-fitimage"
> > +KERNEL_IMAGETYPE ?= "fitImage"
> > +
> > +PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin"
> > +PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
> > +
> > +UBOOT_SUFFIX ?= "itb"
> > +UBOOT_ENTRYPOINT ?= "0x06000000"
> > diff --git a/conf/machine/radxa-zero-3e.conf b/conf/machine/radxa-zero-3e.conf
> > new file mode 100644
> > index 000000000000..3a39d6c12a1f
> > --- /dev/null
> > +++ b/conf/machine/radxa-zero-3e.conf
> > @@ -0,0 +1,12 @@
> > +#@TYPE: Machine
> > +#@NAME: Radxa Zero 3E
> > +#@DESCRIPTION: The Radxa ZERO 3e is an ultra-small, high-performance single board computer based on the Rockchip RK3566, with a compact form factor, and rich interfaces.
> > +#http://radxa.com/products/zeros/zero3e/
> > +
> > +require conf/machine/include/rk3566.inc
> > +
> > +PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
> > +KERNEL_DEVICETREE = "rockchip/rk3566-radxa-zero-3e.dtb"
> > +MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
> > +
> > +UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
> > diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> > index 7929c6ac3a10..6894558ef70c 100644
> > --- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> > +++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> > @@ -4,6 +4,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
> >   SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
> >   SRCREV = "b4558da0860ca48bf1a571dd33ccba580b9abe23"
> > +SRCREV:radxa-zero-3e = "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
> 
> Why not bump the whole rockchip-rkbin recipe? Also is there a reason for
> bumping it? I already see rk3566 blobs in the current git commit. Not
> against bumping it, would be nice to explain if there's a reason for it
> other than "newer is better" (which I am a proponent of :) ).

We've seen cases where newer wasn't better. The newer blobs for rk3308, for
example, took away the ability to read the console during this phase. Playing
it safe I decided to just bump it for the new device and leave the rest the
same.

I'll bump it for all, but I'll have to test on all the ones I care about
before submitting.

> >   PROVIDES += "trusted-firmware-a"
> >   PROVIDES += "optee-os"
> > @@ -15,6 +16,7 @@ S = "${WORKDIR}/git"
> >   COMPATIBLE_MACHINE = "^$"
> >   COMPATIBLE_MACHINE:rk3308 = "rk3308"
> >   COMPATIBLE_MACHINE:rk3568 = "rk3568"
> > +COMPATIBLE_MACHINE:rk3566 = "rk3566"
> 
> Maybe order alphabetically here?

Oops, yes.

> >   COMPATIBLE_MACHINE:rk3588s = "rk3588s"
> >   PACKAGE_ARCH = "${MACHINE_ARCH}"
> > @@ -36,6 +38,15 @@ do_deploy:rk3308() {
> >   	install -m 644 ${S}/bin/rk33/rk3308_ddr_589MHz_uart?_m0_v*.bin ${DEPLOYDIR}/ddr-rk3308.bin
> >   }
> > +do_deploy:rk3566() {
> > +	# Prebuilt TF-A
> > +	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3568.elf
> > +	# Prebuilt OPTEE-OS
> > +	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3568.bin
> > +	# Prebuilt U-Boot TPL (DDR init)
> > +	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3566.bin
> 
> Sigh... Rockchip, almost the same SoC but different DRAM init.
> 
> You could also decide to rename the bl31 and tee to use rk3566 in there to
> avoid adding custom handling in other recipes. Not sure this obfuscation is
> good though.

I'll look at that.

> > +}
> > +
> >   do_deploy:rk3568() {
> >   	# Prebuilt TF-A
> >   	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3568.elf
> > diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc b/recipes-bsp/u-boot/u-boot-rockchip.inc
> > index d2267cc53a92..113190635bb5 100644
> > --- a/recipes-bsp/u-boot/u-boot-rockchip.inc
> > +++ b/recipes-bsp/u-boot/u-boot-rockchip.inc
> > @@ -1,6 +1,8 @@
> >   BL31:rockchip:aarch64 = "${DEPLOY_DIR_IMAGE}/bl31-${SOC_FAMILY}.elf"
> >   # SOC_FAMILY for RK3588S is rk3588s but it should use the binaries from rk3588
> >   BL31:rk3588s = "${DEPLOY_DIR_IMAGE}/bl31-rk3588.elf"
> > +# rk3566 uses the rk3568 bl31
> > +BL31:rk3566 = "${DEPLOY_DIR_IMAGE}/bl31-rk3568.elf"
> 
> Order alphabetically maybe here?

Oops.

> >   EXTRA_OEMAKE:append:rockchip:aarch64 = " BL31=${BL31}"
> >   TFA_DEPENDS ??= ""
> > diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> > index 1f5f63459627..dca43d2a4de0 100644
> > --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> > +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> > @@ -2,6 +2,11 @@ require u-boot-rockchip.inc
> >   FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> > +SRC_URI:radxa-zero-3e = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
> > +SRC_URI[Kwiboo.sha256sum] = "5d102a658262f6d2d4ea0664fe58b77db4a9eb1ebc89dbd8d6f5e75c9e563810"
> > +SRCREV:radxa-zero-3e = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> > +SRCREV:radxa-zero-3e:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> > +
> 
> I think a separate recipe here is wiser? They are essentially different
> sources from a different repo. Although, maybe the generic target is good
> enough in which case we wouldn't need that at all?

I tried that originally, but the build requires u-boot-extlinux, which can't
be satisfied with a new u-boot-kwiboo (?) recipe. I figured the loops to jump
through to provide u-boot-extlinux with a new recipe wasn't worth the effort
(unless there's some trick I haven't seen before).

> >   SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
> >   SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
> > diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
> > new file mode 100644
> > index 000000000000..bbe4689922a7
> > --- /dev/null
> > +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
> > @@ -0,0 +1,22 @@
> > +inherit kernel
> > +inherit kernel-yocto
> > +require recipes-kernel/linux/linux-yocto.inc
> > +
> > +FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> > +
> > +DESCRIPTION = "Linux Kernel"
> > +SECTION = "kernel"
> > +LICENSE = "GPLv2"
> 
> Deprecated, should be
> GPL-2.0-only
> 
> > +LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
> > +
> 
> This is usually at the top of the recipe?
> 
> > +
> > +LINUX_VERSION = "6.10"
> 
> Isn't it supposed to be 6.11?

It's actually 6.10-rc3, according to the Makefile.

> I would recommend putting
> DEFAULT_PREFERENCE = "-1"
> 
> to make sure it isn't mistakenly pulled implicitly.
> 
> Maybe even add a COMPATIBLE_MACHINE only for this new board?
> 
> > +KERNEL_VERSION_SANITY_SKIP = "1"
> > +SRCREV = "next-20240611"
> 
> Please use commit hashes and not tags

I know that's the convention, but is there an explanation for why? A commit
hash tells me nothing, but a tag that says "next-20240611" gives me several
pieces of information. If it works and it provides useful information, why
not use the tag?

> > +PV = "${LINUX_VERSION}+git${SRCPV}"
> > +SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;branch=master"
> > +SRC_URI[sha256sum] = "3a1c433c4ceffa52f8c3df3aab8c379ff91ca658021d409a528825e5e24580f4"
> > +
> 
> Is this actually used by Bitbake? It's fetching code through HTTPS via git
> and git should handle all the integrity there?
> 
> > +do_compile:append() {
> > +	touch ${B}/Module.symvers
> > +}
> 
> That seems odd, can you add a comment on why this is required?

This entire kernel recipe comes from an ancient template I had lying around
for cases like this. It's entirely done by copying it in and adjusting until
it works. I'll give it a more careful pass for #2.

