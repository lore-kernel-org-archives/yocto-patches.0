Return-Path: <mbober1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CACD61033
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 17:08:21 +0000 (UTC)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19910.1769706494214330964
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Jan 2026 09:08:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c2nAqIjG;
 spf=pass (domain: gmail.com, ip: 74.125.224.48, mailfrom: mbober1@gmail.com)
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-649523df010so1241683d50.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 09:08:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769706493; cv=none;
        d=google.com; s=arc-20240605;
        b=G7Qp5CSDcShUfUNiLafbzF1iZpanKKvwqGm/h4HVh2Zj7UI5LzBILxFEx7Kvo/Gq7J
         uN7tsVHADI1p35npkJMO+nGRbJIacx/1a8zBuwq9MSypxmpla/NMqw5q6BRaFueV/YZn
         pcfOda4AyJEjrsqemSP9mx3Kp5plhT4uGNjNEUE0Wci9Bht6YXB95cvD2971NRySSMpU
         0eQIbC7HbBS7w2fYvXXUNQLP1LAsDgU8bXRV/30Nc+ipRoOcu38GT2tdKiytAFguC8ZH
         UOz3aw10pv/5E9os+efn/mSKCLTUpssw/AcYvGUKvC9k4bsphYb1JVNP1Sd4rf+gEEjJ
         5ZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sPu/jK+buaoiBx1qLE7+F/fXuAFvURCMAF6Haq7RwE8=;
        fh=yeqac1wQBVrW59sm2UpLfiPPRNe9rgwhr9UKLMWAhy4=;
        b=WWaYpatV5EMb027RDqdWwaMISbEYBCK5XoRcGUbMAnDPbjzgAWZ6K8p49AuQdrkpD2
         B81ux8FlkgHkJUVZOVr4PNkCf9kDBr0to5jkzgrQvqEuTxzz6A/CifmVyVDHq468ucAL
         xcSqQKSCrIhOswdfOVUnNj0HzOoHdGAOKsEb/ItiBCegsx2j8ILDEAEIzs3LfJIyjbWj
         pMuyVnNO4D8Egy5YfRvue1Wds//XOWFBm/ToNHPRia4+Cwbm9JbDbX9jMaCTA3aSjqPd
         mHIi3wH0ywIubiirbJ3hB/QIOZknFDx+iHKxW/S86mnUSpEZSN3vh3FVRq14/mp+4itY
         y0sg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769706493; x=1770311293; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPu/jK+buaoiBx1qLE7+F/fXuAFvURCMAF6Haq7RwE8=;
        b=c2nAqIjGkwiU/HWxLYKsfk0rBi+lUhAS0H7G8hWZVSv0ULvFqFUkwSf4s+Sh9TM3E8
         TSuzDF+H9R2SXNK5q4c7Ubx+w6pAGtP2vDMU+icVF4MJE1UIUlfJD+v0FgAp+QyhNyd3
         BYKNWVb5Hm5WuHvXl8G2WQhc4+3Mxd14r8k5/Q3AlH2V3L8e1D+QOX/5NmVtVS3nhSBU
         JH3rCMs/epE0DdwL+m/1vVi8Q1dBnhX0EbaWcVB+jKvi+a5sGNlxwEhiIg7oie2wnzjO
         hgTYZ8j52Czk5vv6gwDFcKhoWu/kSDES7qdcGlhQ5L+n4vVSNxLsc7UKGSgXrfiLHrBG
         pGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769706493; x=1770311293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPu/jK+buaoiBx1qLE7+F/fXuAFvURCMAF6Haq7RwE8=;
        b=jn8IESH6vqId4R/YgXtbthSmSqTXazE9D8fMwPBMv4WMYN4wN5c/bnexQSH09YR81C
         ldpgh3XcMO12yqK6RgzKk2Db8B2zfpE5CzHjm6/dqHDglXwQcO3q+2tY0Vsn2CpdkRl9
         q7zpnawVVRk7b+AOcBHUzKvnjs/1Eo/w9Wa294300Tb7CRV8FLKyjnYOGb5DJzWcv/EU
         GUD65h9PjFPtpRAuh3tRflnsfAyF/ZtuqEcdLY00AeEzeBjeFOjmmcOFZWEreOI8XFoq
         gXNrarHTn52HEj/UPyRrJcn3UATw4QWJbQe8B15/C6U3CHYqpbbr8yeBU3yJ8lcanse0
         pmHw==
X-Gm-Message-State: AOJu0YzBgusdxX3EcNZQsE2BGDBFd83Ghvqx28JSq1hrUxq5ucNya9E4
	QXwvUqV78Or58PbEF4WARdZ1D48Vc1mOngkzAYpc6on57BSpmV6jeikkijkbgz9uq1WAEEzznTU
	R5rrdYKEyBvc3kr5aafnIMlwZEGat3jc=
X-Gm-Gg: AZuq6aJzobil7klMAYJ3N6+gqd30yaSNjzr5A5AkicuqiZ/4cldJ28jxZPz0PqGQLbB
	352q6Yoe5JYc4wMre/5X8Igedng2OZLVOOkTDTP/MeN5J2Ei0+BSvEchEIUoEht71athIJzCyXw
	MABWoJ7i9R8tScdc1ZmPFrtHp9oPbhEhXu862G6JR1vqvGKTeqvf/2kwwpnpDG9nzDwqbvTTJ1t
	GbWUGLwyNxf6IE16JriNuZBig1Hv+6LRkPEcEnZ88cHQf9bjbgDarAI2yGnoGQkvGIzJscKfOqF
	BbegNgOV3Mw3jSaL86RT5jCSetw=
X-Received: by 2002:a05:690e:18c:b0:649:1463:c983 with SMTP id
 956f58d0204a3-649a851f9f4mr48570d50.62.1769706493084; Thu, 29 Jan 2026
 09:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20260127205141.26089-1-mbober1@gmail.com> <2bf93914-dd8a-4e3c-9c97-74acb1c975ab@cherry.de>
 <188EF09D72814872.4037790@lists.yoctoproject.org> <aXo0RyTmTEkU2k06@localhost.localdomain>
In-Reply-To: <aXo0RyTmTEkU2k06@localhost.localdomain>
From: Marcin Bober <mbober1@gmail.com>
Date: Thu, 29 Jan 2026 18:08:03 +0100
X-Gm-Features: AZwV_QiCR9srJJj2I3v1_E_Bsvvic5REV4Z5dWg-hFSLjjqHOArQLooUcimGXys
Message-ID: <CAP0e+LNYqiRqarSzd-NFuV0Wt0_re3wyW3kRLh9_WBpxq9jvJg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] luckfox-lyra-plus: add
To: Trevor Woerner <twoerner@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000e086a7064989e6a0"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 17:08:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3145

--000000000000e086a7064989e6a0
Content-Type: text/plain; charset="UTF-8"

ok

On Wed, Jan 28, 2026, 17:07 Trevor Woerner <twoerner@gmail.com> wrote:

> On Wed 2026-01-28 @ 11:04:11 AM, Trevor Woerner via lists.yoctoproject.org
> wrote:
> > Thank you, Quentin, for your thorough review!
> >
> > On Wed 2026-01-28 @ 11:35:17 AM, Quentin Schulz via
> lists.yoctoproject.org wrote:
> > > Hi Marcin,
> > >
> > > On 1/27/26 9:51 PM, Marcin Bober via lists.yoctoproject.org wrote:
> > > > [You don't often get email from mbober1=
> gmail.com@lists.yoctoproject.org. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > The Luckfox Lyra Plus is ultra-small, tri-core single board computer
> > > > based on the Rockchip RK3506G2, with a very compact form factor.
> > > >
> > > > Signed-off-by: Marcin Bober <mbober1@gmail.com>
> > > > ---
> > > >   README                                        |  1 +
> > > >   conf/machine/include/rk3506.inc               | 20 +++++++++++++
> > > >   conf/machine/include/rk3568.inc               |  1 -
> > > >   conf/machine/include/rk3588s.inc              |  1 -
> > > >   conf/machine/luckfox-lyra-plus.conf           | 27
> +++++++++++++++++
> > > >   recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb   |  9 ++++++
> > > >   .../rkbin/rockchip-rkbin-optee-os_git.bb      |  5 ++++
> > > >   recipes-bsp/rkbin/rockchip-rkbin.inc          |  1 +
> > > >   recipes-bsp/u-boot/u-boot-rockchip.inc        |  2 ++
> > > >   recipes-bsp/u-boot/u-boot_%.bbappend          |  4 +++
> > > >   recipes-kernel/linux/linux-armbian_git.bb     | 29
> +++++++++++++++++++
> > > >   11 files changed, 98 insertions(+), 2 deletions(-)
> > > >   create mode 100644 conf/machine/include/rk3506.inc
> > > >   create mode 100644 conf/machine/luckfox-lyra-plus.conf
> > > >   create mode 100644 recipes-kernel/linux/linux-armbian_git.bb
> > > >
> > > > diff --git a/README b/README
> > > > index 6bceba0..3991415 100644
> > > > --- a/README
> > > > +++ b/README
> > > > @@ -23,6 +23,7 @@ Status of supported boards:
> > > >                          tinker-board
> > > >                          tinker-board-s
> > > >                          vyasa-rk3288
> > > > +                       luckfox-lyra-plus
> > >
> > > Please keep the list ordered alphabetically.
> > >
> > > >
> > > >                  64-bit:
> > > >                          nanopi-m4
> > > > diff --git a/conf/machine/include/rk3506.inc
> b/conf/machine/include/rk3506.inc
> > > > new file mode 100644
> > > > index 0000000..e204283
> > > > --- /dev/null
> > > > +++ b/conf/machine/include/rk3506.inc
> > > > @@ -0,0 +1,20 @@
> > > > +MACHINEOVERRIDES =. "rk3506:"
> > > > +SOC_FAMILY = "rk3506"
> > > > +DEFAULTTUNE = "cortexa7thf-neon-vfpv4"
> > > > +
> > > > +ROCKCHIP_CLOSED_TPL ?= "1"
> > > > +
> > > > +require conf/machine/include/soc-family.inc
> > > > +require conf/machine/include/rockchip-defaults.inc
> > > > +require conf/machine/include/arm/armv7a/tune-cortexa7.inc
> > > > +require conf/machine/include/rockchip-wic.inc
> > > > +
> > > > +PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> > > > +
> > >
> > > Ooooh, I believe this would mean OP-TEE OS blob from Rockchip can be
> used
> > > with upstream U-Boot? Have you actually tried? This would be
> interesting for
> > > me for
> https://lore.kernel.org/yocto-patches/20260126-optee-os-v1-0-874261a77dad@cherry.de/
> > > to check if I got it right for rockchip-rkbin-optee-os as well.
> > >
> > > Is OP-TEE OS *required* on rk3506 to be able to boot? Do you know?
> > >
> > > Essentially, with the patch series listed above applied, you would
> need to
> > > set RK_UBOOT_TEE = "1" and then U-Boot would automatically add the
> necessary
> > > dependency and add the correct filepath to the TEE environment
> variable.
> > >
> > > > +KBUILD_DEFCONFIG ?= "rk3506_defconfig"
> > >
> > > Usually we would rather have multi_v7_defconfig and if needed apply
> > > .scc+.cfg config fragments (see what's been done for nanopi-r4s).
> > >
> > > > +KERNEL_CLASSES = "kernel-fitimage"
> > > > +KERNEL_IMAGETYPE ?= "fitImage"
> > > > +
> > >
> > > Isn't a FIT image the default when you include rockchip-defaults? See
> > > RK_KERNEL_FITIMAGE variable.
> > >
> > > > +UBOOT_SUFFIX ?= "itb"
> > > > +UBOOT_ENTRYPOINT ?= "0x02800000"
> > > > +UBOOT_EXTLINUX_FDT = "${@bb.utils.contains('KERNEL_IMAGETYPE',
> 'fitImage', '', '/boot', d)}"
> > >
> > > isn't that already handled with RK_KERNEL_FITIMAGE from within
> > > conf/machine/include/rockchip-extlinux.inc (you may then want to
> require
> > > this file).
> > >
> > > > diff --git a/conf/machine/include/rk3568.inc
> b/conf/machine/include/rk3568.inc
> > > > index bcf9dd8..12f0ba2 100644
> > > > --- a/conf/machine/include/rk3568.inc
> > > > +++ b/conf/machine/include/rk3568.inc
> > > > @@ -10,7 +10,6 @@ require
> conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
> > > >   require conf/machine/include/rockchip-wic.inc
> > > >
> > > >   KBUILD_DEFCONFIG ?= "defconfig"
> > > > -KERNEL_FEATURES:append:rk3568 = "
> bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> > >
> > > This has nothing to do with adding support for this new device no?
> > >
> > > >   KERNEL_CLASSES = "kernel-fitimage"
> > > >   KERNEL_IMAGETYPE ?= "fitImage"
> > > >
> > > > diff --git a/conf/machine/include/rk3588s.inc
> b/conf/machine/include/rk3588s.inc
> > > > index 6ec344a..d0654c1 100644
> > > > --- a/conf/machine/include/rk3588s.inc
> > > > +++ b/conf/machine/include/rk3588s.inc
> > > > @@ -9,7 +9,6 @@ require
> conf/machine/include/arm/armv8-2a/tune-cortexa76-cortexa55.inc
> > > >   require conf/machine/include/rockchip-wic.inc
> > > >
> > > >   KBUILD_DEFCONFIG ?= "defconfig"
> > > > -KERNEL_FEATURES:append:rk3588s = "
> bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> > >
> > > This has nothing to do with adding support for this new device no?
> > >
> > > >   KERNEL_CLASSES = "kernel-fitimage"
> > > >   KERNEL_IMAGETYPE ?= "fitImage"
> > > >
> > > > diff --git a/conf/machine/luckfox-lyra-plus.conf
> b/conf/machine/luckfox-lyra-plus.conf
> > > > new file mode 100644
> > > > index 0000000..529a472
> > > > --- /dev/null
> > > > +++ b/conf/machine/luckfox-lyra-plus.conf
> > > > @@ -0,0 +1,27 @@
> > > > +#@TYPE: Machine
> > > > +#@NAME: Luckfox Lyra Plus
> > > > +#@DESCRIPTION: RK3506G2 based Linux Micro Development Board
> > > > +#https://www.luckfox.com/Luckfox-Lyra-Plus
> >
> > Usually I would be excited about a tiny rockchip-based SBC with
> > hardwired ethernet. But a new SoC based on CortexA7 (i.e. 32-bit)??
> > And no SDcard?
>
> Oops, my mistake. There is an SDcard slot.
> (hadn't scrolled down far enough)
>
> >
> > Hopefully someone comes out with something new to replace the zero-3e
> > which appears to be out of production.
> >
> > > > +
> > > > +require conf/machine/include/rk3506.inc
> > > > +
> > > > +KERNEL_DEVICETREE ?= "rk3506g-luckfox-lyra-plus-sd.dtb"
> > > > +MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
> > > > +PREFERRED_PROVIDER_virtual/kernel = "linux-armbian"
> > >
> > > I believe we only take boards which are supported by linux-yocto or
> > > linux-yocto-dev from the master branch of OE-Core. I don't even see
> patches
> > > on the linux-rockchip mailing list
> > >
> > > > +EXTERNAL_KERNEL_DEVICETREE = "${DEPLOY_DIR_IMAGE}/devicetree"
> > > > +
> > > > +UBOOT_MACHINE = "luckfox-lyra-rk3506_defconfig"
> > > > +
> > > > +MACHINE_FEATURES = " \
> > > > +  rtc \
> > > > +  screen \
> > > > +  serial \
> > > > +  usbgadget \
> > > > +  usbhost \
> > > > +  vfat \
> > > > +"
> > > > +
> > > > +KERNEL_FEATURES += " \
> > > > +  cfg/fs/ext4.scc \
> > > > +  features/cgroups/cgroups.scc \
> > > > +"
> > >
> > > KERNEL_FEATURES must be listed in the kernel recipe not in the machine.
> > >
> > > > diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> > > > index 3227a53..7f654ff 100644
> > > > --- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> > > > +++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> > > > @@ -10,6 +10,15 @@ do_deploy:rk3308() {
> > > >          install -m 644 ${S}/bin/rk33/${DDRBIN_FILE}
> ${DEPLOYDIR}/ddr-rk3308.bin
> > > >   }
> > > >
> > >
> > > Wait.... This doesn't exist anymore. Against which branch did you
> develop
> > > this patch?
> > >
> > > The master branch has a completely different mechanism which is much
> more
> > > automatic than what's needed below.
> > >
> > > > +DDRBIN_VERS:rk3506 ?= "v1.02"
> > > > +DDRBIN_FILE:rk3506 ?= "rk3506_ddr_750MHz_${DDRBIN_VERS}.bin"
> > > > +
> > > > +do_deploy:rk3506() {
> > > > +       # Prebuilt U-Boot TPL (DDR init)
> > > > +       install -m 644 ${S}/bin/rk35/${DDRBIN_FILE}
> ${DEPLOYDIR}/ddr-rk3506.bin
> > > > +       install -m 644 ${S}/bin/rk35/rk3506_tee_v1.23.bin
> ${DEPLOYDIR}/tee-rk3506.bin
> > >
> > > This is TEE, not DRAM init blob so shouldn't be deployed in this
> recipe.
> > >
> > > > +}
> > > > +>   DDRBIN_VERS:rk3566 ?= "v1.23"
> > > >   DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
> > > >
> > > > diff --git a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> > > > index 6d25368..cbd376c 100644
> > > > --- a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> > > > +++ b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> > > > @@ -9,6 +9,11 @@ do_deploy:rk3308() {
> > > >          install -m 644 ${S}/bin/rk33/rk3308_bl32_v*.bin
> ${DEPLOYDIR}/tee-rk3308.bin
> > > >   }
> > > >
> > > > +do_deploy:rk3506() {
> > > > +       # Prebuilt OPTEE-OS
> > > > +       install -m 644 ${S}/bin/rk35/rk3506_tee_v*.bin
> ${DEPLOYDIR}/tee-rk3506.bin
> > > > +}
> > > > +
> > > >   # NOTE: the following are not typos
> > > >   #       the rk3566 uses the same bl32 as the rk3568
> > > >   do_deploy:rk3566() {
> > > > diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc
> b/recipes-bsp/rkbin/rockchip-rkbin.inc
> > > > index 9264db9..8dfdc09 100644
> > > > --- a/recipes-bsp/rkbin/rockchip-rkbin.inc
> > > > +++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
> > > > @@ -11,6 +11,7 @@ S = "${WORKDIR}/git"
> > > >
> > > >   COMPATIBLE_MACHINE = "^$"
> > > >   COMPATIBLE_MACHINE:rk3308 = "rk3308"
> > > > +COMPATIBLE_MACHINE:rk3506 = "rk3506"
> > > >   COMPATIBLE_MACHINE:rk3566 = "rk3566"
> > > >   COMPATIBLE_MACHINE:rk3568 = "rk3568"
> > > >   COMPATIBLE_MACHINE:rk3588s = "rk3588s"
> > > > diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc
> b/recipes-bsp/u-boot/u-boot-rockchip.inc
> > > > index 2b5bbd7..67c4418 100644
> > > > --- a/recipes-bsp/u-boot/u-boot-rockchip.inc
> > > > +++ b/recipes-bsp/u-boot/u-boot-rockchip.inc
> > > > @@ -11,7 +11,9 @@ do_compile[depends] .= "${TFA_DEPENDS}"
> > > >   ROCKCHIP_TPL:closed-tpl =
> "${DEPLOY_DIR_IMAGE}/ddr-${SOC_FAMILY}.bin"
> > > >   # SOC_FAMILY for RK3588S is rk3588s but it should use the binaries
> from rk3588
> > > >   ROCKCHIP_TPL:closed-tpl:rk3588s =
> "${DEPLOY_DIR_IMAGE}/ddr-rk3588.bin"
> > > > +ROCKCHIP_TEE:closed-tpl:rk3506 =
> "${DEPLOY_DIR_IMAGE}/tee-rk3506.bin"
> > > >   EXTRA_OEMAKE:append:closed-tpl = " ROCKCHIP_TPL=${ROCKCHIP_TPL}"
> > > > +EXTRA_OEMAKE:append:closed-tpl:rk3506 = " TEE=${ROCKCHIP_TEE}"
> > > >
> > >
> > > I think you only want
> > >
> > > ROCKCHIP_TEE:rk3506
> > >
> > > and
> > >
> > > EXTRA_OEMAKE:append:rk3506
> > >
> > > as I believe TEE has nothing to do with whether we're using a DRAM init
> > > blob?
> > >
> > > Also, this isn't working because you forgot to add the dependency on
> > > optee-os (see do_compile[depends] .= "${TFA_DEPENDS}" for how we have
> the
> > > dependency for trsuted-firmware-a on Aarch64).
> > >
> > > >   INIT_FIRMWARE_DEPENDS ??= ""
> > > >   INIT_FIRMWARE_DEPENDS:closed-tpl = " rockchip-rkbin-ddr:do_deploy"
> > > > diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend
> b/recipes-bsp/u-boot/u-boot_%.bbappend
> > > > index 08e1730..fc6a36e 100644
> > > > --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> > > > +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> > > > @@ -8,6 +8,10 @@ DEPENDS:append:rk3308 = " u-boot-tools-native"
> > > >   DEPENDS:append:rock-pi-4 = " gnutls-native"
> > > >   DEPENDS:append:rk-u-boot-env = " u-boot-mkenvimage-native"
> > > >
> > > > +BRANCH:luckfox-lyra-plus = "rk3506"
> > > > +SRC_URI:luckfox-lyra-plus = "git://
> source.denx.de/u-boot/contributors/kwiboo/u-boot.git;protocol=https;branch=${BRANCH}
> <http://source.denx.de/u-boot/contributors/kwiboo/u-boot.git;protocol=https;branch=$%7BBRANCH%7D>
> "
> > > > +SRCREV:luckfox-lyra-plus =
> "c6782a37feee4a8aee08d321c01b4ca0b0562f0b"
> > > > +
> > >
> > > That's a BIG no-no.
> > >
> > > Have a separate recipe for this.
> > >
> > > Knowing Jonas, there are chances this branch will get rebased, so I
> don't
> > > think we want this at all.
> > >
> > > I see patches on the U-Boot mailing list for RK3506 support in U-Boot,
> see
> > >
> https://lore.kernel.org/u-boot/20260109005008.101506-1-jonas@kwiboo.se/
> and
> > > Jonas "promised" a v2. Maybe work with him on getting the v2 sent
> upstream?
> > >
> > > >   do_compile:append:rock2-square () {
> > > >          # copy to default search path
> > > >          if [ "${SPL_BINARY}" = "u-boot-spl-dtb.bin" ]; then
> > > > diff --git a/recipes-kernel/linux/linux-armbian_git.bb
> b/recipes-kernel/linux/linux-armbian_git.bb
> > > > new file mode 100644
> > > > index 0000000..42dad4f
> > > > --- /dev/null
> > > > +++ b/recipes-kernel/linux/linux-armbian_git.bb
> > >
> > > I'll let Trevor speak his mind here but I don't think Armbian Linux
> kernel
> > > is something we're interested in supporting. Work with upstream to get
> the
> > > board supported in upstream Linux and then we can have it here.
> >
> > I agree with Quentin's assessment. If rockchip were a platform that had
> > little or no upstream support then we would need to have all sorts of
> > recipes for bootloaders and kernels from wherever we could find them.
> > But with rockchip, upstream support is usually just a matter of time.
> > I'll take new machines if they're in linux-yocto-dev, but would rather
> > stay away from vendor kernels.
> >
> > If a board is wildly popular and will never have upstream support then I
> > would consider it. But if Jonas is already working on it, then we will
> > probably see upstream support shortly.
> >
> > > Cheers,
> > > Quentin
> > >
> > >
> > >
> > >
> > >
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#3136):
> https://lists.yoctoproject.org/g/yocto-patches/message/3136
> > Mute This Topic: https://lists.yoctoproject.org/mt/117496463/900817
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy
> [twoerner@gmail.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
> >
>

--000000000000e086a7064989e6a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>ok</div></div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 28, 2026, =
17:07 Trevor Woerner &lt;<a href=3D"mailto:twoerner@gmail.com">twoerner@gma=
il.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Wed 2026-0=
1-28 @ 11:04:11 AM, Trevor Woerner via <a href=3D"http://lists.yoctoproject=
.org" rel=3D"noreferrer noreferrer" target=3D"_blank">lists.yoctoproject.or=
g</a> wrote:<br>
&gt; Thank you, Quentin, for your thorough review!<br>
&gt; <br>
&gt; On Wed 2026-01-28 @ 11:35:17 AM, Quentin Schulz via <a href=3D"http://=
lists.yoctoproject.org" rel=3D"noreferrer noreferrer" target=3D"_blank">lis=
ts.yoctoproject.org</a> wrote:<br>
&gt; &gt; Hi Marcin,<br>
&gt; &gt; <br>
&gt; &gt; On 1/27/26 9:51 PM, Marcin Bober via <a href=3D"http://lists.yoct=
oproject.org" rel=3D"noreferrer noreferrer" target=3D"_blank">lists.yoctopr=
oject.org</a> wrote:<br>
&gt; &gt; &gt; [You don&#39;t often get email from mbober1=3D<a href=3D"mai=
lto:gmail.com@lists.yoctoproject.org" target=3D"_blank" rel=3D"noreferrer">=
gmail.com@lists.yoctoproject.org</a>. Learn why this is important at <a hre=
f=3D"https://aka.ms/LearnAboutSenderIdentification" rel=3D"noreferrer noref=
errer" target=3D"_blank">https://aka.ms/LearnAboutSenderIdentification</a> =
]<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The Luckfox Lyra Plus is ultra-small, tri-core single board =
computer<br>
&gt; &gt; &gt; based on the Rockchip RK3506G2, with a very compact form fac=
tor.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Signed-off-by: Marcin Bober &lt;<a href=3D"mailto:mbober1@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">mbober1@gmail.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 =C2=A0README=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0conf/machine/include/rk3506.inc=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 20 +++++++++++++<br>
&gt; &gt; &gt;=C2=A0 =C2=A0conf/machine/include/rk3568.inc=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
&gt; &gt; &gt;=C2=A0 =C2=A0conf/machine/include/rk3588s.inc=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 -<br>
&gt; &gt; &gt;=C2=A0 =C2=A0conf/machine/luckfox-lyra-plus.conf=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 27 +++++++++++++++++<br>
&gt; &gt; &gt;=C2=A0 =C2=A0recipes-bsp/rkbin/<a href=3D"http://rockchip-rkb=
in-ddr_git.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">rockchip-rkb=
in-ddr_git.bb</a>=C2=A0 =C2=A0|=C2=A0 9 ++++++<br>
&gt; &gt; &gt;=C2=A0 =C2=A0.../rkbin/<a href=3D"http://rockchip-rkbin-optee=
-os_git.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">rockchip-rkbin-=
optee-os_git.bb</a>=C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 ++++<br>
&gt; &gt; &gt;=C2=A0 =C2=A0recipes-bsp/rkbin/rockchip-rkbin.inc=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0recipes-bsp/u-boot/u-boot-rockchip.inc=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
&gt; &gt; &gt;=C2=A0 =C2=A0recipes-bsp/u-boot/u-boot_%.bbappend=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++<br>
&gt; &gt; &gt;=C2=A0 =C2=A0recipes-kernel/linux/<a href=3D"http://linux-arm=
bian_git.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">linux-armbian_=
git.bb</a>=C2=A0 =C2=A0 =C2=A0| 29 +++++++++++++++++++<br>
&gt; &gt; &gt;=C2=A0 =C2=A011 files changed, 98 insertions(+), 2 deletions(=
-)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0create mode 100644 conf/machine/include/rk3506.i=
nc<br>
&gt; &gt; &gt;=C2=A0 =C2=A0create mode 100644 conf/machine/luckfox-lyra-plu=
s.conf<br>
&gt; &gt; &gt;=C2=A0 =C2=A0create mode 100644 recipes-kernel/linux/<a href=
=3D"http://linux-armbian_git.bb" rel=3D"noreferrer noreferrer" target=3D"_b=
lank">linux-armbian_git.bb</a><br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; diff --git a/README b/README<br>
&gt; &gt; &gt; index 6bceba0..3991415 100644<br>
&gt; &gt; &gt; --- a/README<br>
&gt; &gt; &gt; +++ b/README<br>
&gt; &gt; &gt; @@ -23,6 +23,7 @@ Status of supported boards:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tinker-board<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tinker-board-s<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vyasa-rk3288<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0luckfox-lyra-plus<br>
&gt; &gt; <br>
&gt; &gt; Please keep the list ordered alphabetically.<br>
&gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 64-bit:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nanopi-m4<br>
&gt; &gt; &gt; diff --git a/conf/machine/include/rk3506.inc b/conf/machine/=
include/rk3506.inc<br>
&gt; &gt; &gt; new file mode 100644<br>
&gt; &gt; &gt; index 0000000..e204283<br>
&gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; +++ b/conf/machine/include/rk3506.inc<br>
&gt; &gt; &gt; @@ -0,0 +1,20 @@<br>
&gt; &gt; &gt; +MACHINEOVERRIDES =3D. &quot;rk3506:&quot;<br>
&gt; &gt; &gt; +SOC_FAMILY =3D &quot;rk3506&quot;<br>
&gt; &gt; &gt; +DEFAULTTUNE =3D &quot;cortexa7thf-neon-vfpv4&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +ROCKCHIP_CLOSED_TPL ?=3D &quot;1&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +require conf/machine/include/soc-family.inc<br>
&gt; &gt; &gt; +require conf/machine/include/rockchip-defaults.inc<br>
&gt; &gt; &gt; +require conf/machine/include/arm/armv7a/tune-cortexa7.inc<b=
r>
&gt; &gt; &gt; +require conf/machine/include/rockchip-wic.inc<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +PREFERRED_PROVIDER_optee-os =3D &quot;rockchip-rkbin-optee-=
os&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; <br>
&gt; &gt; Ooooh, I believe this would mean OP-TEE OS blob from Rockchip can=
 be used<br>
&gt; &gt; with upstream U-Boot? Have you actually tried? This would be inte=
resting for<br>
&gt; &gt; me for <a href=3D"https://lore.kernel.org/yocto-patches/20260126-=
optee-os-v1-0-874261a77dad@cherry.de/" rel=3D"noreferrer noreferrer" target=
=3D"_blank">https://lore.kernel.org/yocto-patches/20260126-optee-os-v1-0-87=
4261a77dad@cherry.de/</a><br>
&gt; &gt; to check if I got it right for rockchip-rkbin-optee-os as well.<b=
r>
&gt; &gt; <br>
&gt; &gt; Is OP-TEE OS *required* on rk3506 to be able to boot? Do you know=
?<br>
&gt; &gt; <br>
&gt; &gt; Essentially, with the patch series listed above applied, you woul=
d need to<br>
&gt; &gt; set RK_UBOOT_TEE =3D &quot;1&quot; and then U-Boot would automati=
cally add the necessary<br>
&gt; &gt; dependency and add the correct filepath to the TEE environment va=
riable.<br>
&gt; &gt; <br>
&gt; &gt; &gt; +KBUILD_DEFCONFIG ?=3D &quot;rk3506_defconfig&quot;<br>
&gt; &gt; <br>
&gt; &gt; Usually we would rather have multi_v7_defconfig and if needed app=
ly<br>
&gt; &gt; .scc+.cfg config fragments (see what&#39;s been done for nanopi-r=
4s).<br>
&gt; &gt; <br>
&gt; &gt; &gt; +KERNEL_CLASSES =3D &quot;kernel-fitimage&quot;<br>
&gt; &gt; &gt; +KERNEL_IMAGETYPE ?=3D &quot;fitImage&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; <br>
&gt; &gt; Isn&#39;t a FIT image the default when you include rockchip-defau=
lts? See<br>
&gt; &gt; RK_KERNEL_FITIMAGE variable.<br>
&gt; &gt; <br>
&gt; &gt; &gt; +UBOOT_SUFFIX ?=3D &quot;itb&quot;<br>
&gt; &gt; &gt; +UBOOT_ENTRYPOINT ?=3D &quot;0x02800000&quot;<br>
&gt; &gt; &gt; +UBOOT_EXTLINUX_FDT =3D &quot;${@bb.utils.contains(&#39;KERN=
EL_IMAGETYPE&#39;, &#39;fitImage&#39;, &#39;&#39;, &#39;/boot&#39;, d)}&quo=
t;<br>
&gt; &gt; <br>
&gt; &gt; isn&#39;t that already handled with RK_KERNEL_FITIMAGE from withi=
n<br>
&gt; &gt; conf/machine/include/rockchip-extlinux.inc (you may then want to =
require<br>
&gt; &gt; this file).<br>
&gt; &gt; <br>
&gt; &gt; &gt; diff --git a/conf/machine/include/rk3568.inc b/conf/machine/=
include/rk3568.inc<br>
&gt; &gt; &gt; index bcf9dd8..12f0ba2 100644<br>
&gt; &gt; &gt; --- a/conf/machine/include/rk3568.inc<br>
&gt; &gt; &gt; +++ b/conf/machine/include/rk3568.inc<br>
&gt; &gt; &gt; @@ -10,7 +10,6 @@ require conf/machine/include/arm/armv8-2a/=
tune-cortexa55.inc<br>
&gt; &gt; &gt;=C2=A0 =C2=A0require conf/machine/include/rockchip-wic.inc<br=
>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0KBUILD_DEFCONFIG ?=3D &quot;defconfig&quot;<br>
&gt; &gt; &gt; -KERNEL_FEATURES:append:rk3568 =3D &quot; bsp/rockchip/remov=
e-non-rockchip-arch-arm64.scc&quot;<br>
&gt; &gt; <br>
&gt; &gt; This has nothing to do with adding support for this new device no=
?<br>
&gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0KERNEL_CLASSES =3D &quot;kernel-fitimage&quot;<b=
r>
&gt; &gt; &gt;=C2=A0 =C2=A0KERNEL_IMAGETYPE ?=3D &quot;fitImage&quot;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; diff --git a/conf/machine/include/rk3588s.inc b/conf/machine=
/include/rk3588s.inc<br>
&gt; &gt; &gt; index 6ec344a..d0654c1 100644<br>
&gt; &gt; &gt; --- a/conf/machine/include/rk3588s.inc<br>
&gt; &gt; &gt; +++ b/conf/machine/include/rk3588s.inc<br>
&gt; &gt; &gt; @@ -9,7 +9,6 @@ require conf/machine/include/arm/armv8-2a/tu=
ne-cortexa76-cortexa55.inc<br>
&gt; &gt; &gt;=C2=A0 =C2=A0require conf/machine/include/rockchip-wic.inc<br=
>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0KBUILD_DEFCONFIG ?=3D &quot;defconfig&quot;<br>
&gt; &gt; &gt; -KERNEL_FEATURES:append:rk3588s =3D &quot; bsp/rockchip/remo=
ve-non-rockchip-arch-arm64.scc&quot;<br>
&gt; &gt; <br>
&gt; &gt; This has nothing to do with adding support for this new device no=
?<br>
&gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0KERNEL_CLASSES =3D &quot;kernel-fitimage&quot;<b=
r>
&gt; &gt; &gt;=C2=A0 =C2=A0KERNEL_IMAGETYPE ?=3D &quot;fitImage&quot;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; diff --git a/conf/machine/luckfox-lyra-plus.conf b/conf/mach=
ine/luckfox-lyra-plus.conf<br>
&gt; &gt; &gt; new file mode 100644<br>
&gt; &gt; &gt; index 0000000..529a472<br>
&gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; +++ b/conf/machine/luckfox-lyra-plus.conf<br>
&gt; &gt; &gt; @@ -0,0 +1,27 @@<br>
&gt; &gt; &gt; +#@TYPE: Machine<br>
&gt; &gt; &gt; +#@NAME: Luckfox Lyra Plus<br>
&gt; &gt; &gt; +#@DESCRIPTION: RK3506G2 based Linux Micro Development Board=
<br>
&gt; &gt; &gt; +#<a href=3D"https://www.luckfox.com/Luckfox-Lyra-Plus" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://www.luckfox.com/Luckfo=
x-Lyra-Plus</a><br>
&gt; <br>
&gt; Usually I would be excited about a tiny rockchip-based SBC with<br>
&gt; hardwired ethernet. But a new SoC based on CortexA7 (i.e. 32-bit)??<br=
>
&gt; And no SDcard?<br>
<br>
Oops, my mistake. There is an SDcard slot.<br>
(hadn&#39;t scrolled down far enough)<br>
<br>
&gt; <br>
&gt; Hopefully someone comes out with something new to replace the zero-3e<=
br>
&gt; which appears to be out of production.<br>
&gt; <br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +require conf/machine/include/rk3506.inc<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +KERNEL_DEVICETREE ?=3D &quot;rk3506g-luckfox-lyra-plus-sd.d=
tb&quot;<br>
&gt; &gt; &gt; +MACHINE_EXTRA_RRECOMMENDS +=3D &quot;kernel-modules&quot;<b=
r>
&gt; &gt; &gt; +PREFERRED_PROVIDER_virtual/kernel =3D &quot;linux-armbian&q=
uot;<br>
&gt; &gt; <br>
&gt; &gt; I believe we only take boards which are supported by linux-yocto =
or<br>
&gt; &gt; linux-yocto-dev from the master branch of OE-Core. I don&#39;t ev=
en see patches<br>
&gt; &gt; on the linux-rockchip mailing list<br>
&gt; &gt; <br>
&gt; &gt; &gt; +EXTERNAL_KERNEL_DEVICETREE =3D &quot;${DEPLOY_DIR_IMAGE}/de=
vicetree&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +UBOOT_MACHINE =3D &quot;luckfox-lyra-rk3506_defconfig&quot;=
<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +MACHINE_FEATURES =3D &quot; \<br>
&gt; &gt; &gt; +=C2=A0 rtc \<br>
&gt; &gt; &gt; +=C2=A0 screen \<br>
&gt; &gt; &gt; +=C2=A0 serial \<br>
&gt; &gt; &gt; +=C2=A0 usbgadget \<br>
&gt; &gt; &gt; +=C2=A0 usbhost \<br>
&gt; &gt; &gt; +=C2=A0 vfat \<br>
&gt; &gt; &gt; +&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +KERNEL_FEATURES +=3D &quot; \<br>
&gt; &gt; &gt; +=C2=A0 cfg/fs/ext4.scc \<br>
&gt; &gt; &gt; +=C2=A0 features/cgroups/cgroups.scc \<br>
&gt; &gt; &gt; +&quot;<br>
&gt; &gt; <br>
&gt; &gt; KERNEL_FEATURES must be listed in the kernel recipe not in the ma=
chine.<br>
&gt; &gt; <br>
&gt; &gt; &gt; diff --git a/recipes-bsp/rkbin/<a href=3D"http://rockchip-rk=
bin-ddr_git.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">rockchip-rk=
bin-ddr_git.bb</a> b/recipes-bsp/rkbin/<a href=3D"http://rockchip-rkbin-ddr=
_git.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">rockchip-rkbin-ddr=
_git.bb</a><br>
&gt; &gt; &gt; index 3227a53..7f654ff 100644<br>
&gt; &gt; &gt; --- a/recipes-bsp/rkbin/<a href=3D"http://rockchip-rkbin-ddr=
_git.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">rockchip-rkbin-ddr=
_git.bb</a><br>
&gt; &gt; &gt; +++ b/recipes-bsp/rkbin/<a href=3D"http://rockchip-rkbin-ddr=
_git.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">rockchip-rkbin-ddr=
_git.bb</a><br>
&gt; &gt; &gt; @@ -10,6 +10,15 @@ do_deploy:rk3308() {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 install -m 644 ${S}/bin/rk=
33/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin<br>
&gt; &gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Wait.... This doesn&#39;t exist anymore. Against which branch did=
 you develop<br>
&gt; &gt; this patch?<br>
&gt; &gt; <br>
&gt; &gt; The master branch has a completely different mechanism which is m=
uch more<br>
&gt; &gt; automatic than what&#39;s needed below.<br>
&gt; &gt; <br>
&gt; &gt; &gt; +DDRBIN_VERS:rk3506 ?=3D &quot;v1.02&quot;<br>
&gt; &gt; &gt; +DDRBIN_FILE:rk3506 ?=3D &quot;rk3506_ddr_750MHz_${DDRBIN_VE=
RS}.bin&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +do_deploy:rk3506() {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0# Prebuilt U-Boot TPL (DDR init)=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0install -m 644 ${S}/bin/rk35/${D=
DRBIN_FILE} ${DEPLOYDIR}/ddr-rk3506.bin<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0install -m 644 ${S}/bin/rk35/rk3=
506_tee_v1.23.bin ${DEPLOYDIR}/tee-rk3506.bin<br>
&gt; &gt; <br>
&gt; &gt; This is TEE, not DRAM init blob so shouldn&#39;t be deployed in t=
his recipe.<br>
&gt; &gt; <br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +&gt;=C2=A0 =C2=A0DDRBIN_VERS:rk3566 ?=3D &quot;v1.23&quot;<=
br>
&gt; &gt; &gt;=C2=A0 =C2=A0DDRBIN_FILE:rk3566 ?=3D &quot;rk3566_ddr_1056MHz=
_${DDRBIN_VERS}.bin&quot;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; diff --git a/recipes-bsp/rkbin/<a href=3D"http://rockchip-rk=
bin-optee-os_git.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">rockch=
ip-rkbin-optee-os_git.bb</a> b/recipes-bsp/rkbin/<a href=3D"http://rockchip=
-rkbin-optee-os_git.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">roc=
kchip-rkbin-optee-os_git.bb</a><br>
&gt; &gt; &gt; index 6d25368..cbd376c 100644<br>
&gt; &gt; &gt; --- a/recipes-bsp/rkbin/<a href=3D"http://rockchip-rkbin-opt=
ee-os_git.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">rockchip-rkbi=
n-optee-os_git.bb</a><br>
&gt; &gt; &gt; +++ b/recipes-bsp/rkbin/<a href=3D"http://rockchip-rkbin-opt=
ee-os_git.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">rockchip-rkbi=
n-optee-os_git.bb</a><br>
&gt; &gt; &gt; @@ -9,6 +9,11 @@ do_deploy:rk3308() {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 install -m 644 ${S}/bin/rk=
33/rk3308_bl32_v*.bin ${DEPLOYDIR}/tee-rk3308.bin<br>
&gt; &gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; +do_deploy:rk3506() {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0# Prebuilt OPTEE-OS<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0install -m 644 ${S}/bin/rk35/rk3=
506_tee_v*.bin ${DEPLOYDIR}/tee-rk3506.bin<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0# NOTE: the following are not typos<br>
&gt; &gt; &gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0the rk3566 uses the =
same bl32 as the rk3568<br>
&gt; &gt; &gt;=C2=A0 =C2=A0do_deploy:rk3566() {<br>
&gt; &gt; &gt; diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-=
bsp/rkbin/rockchip-rkbin.inc<br>
&gt; &gt; &gt; index 9264db9..8dfdc09 100644<br>
&gt; &gt; &gt; --- a/recipes-bsp/rkbin/rockchip-rkbin.inc<br>
&gt; &gt; &gt; +++ b/recipes-bsp/rkbin/rockchip-rkbin.inc<br>
&gt; &gt; &gt; @@ -11,6 +11,7 @@ S =3D &quot;${WORKDIR}/git&quot;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0COMPATIBLE_MACHINE =3D &quot;^$&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0COMPATIBLE_MACHINE:rk3308 =3D &quot;rk3308&quot;=
<br>
&gt; &gt; &gt; +COMPATIBLE_MACHINE:rk3506 =3D &quot;rk3506&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0COMPATIBLE_MACHINE:rk3566 =3D &quot;rk3566&quot;=
<br>
&gt; &gt; &gt;=C2=A0 =C2=A0COMPATIBLE_MACHINE:rk3568 =3D &quot;rk3568&quot;=
<br>
&gt; &gt; &gt;=C2=A0 =C2=A0COMPATIBLE_MACHINE:rk3588s =3D &quot;rk3588s&quo=
t;<br>
&gt; &gt; &gt; diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc b/recipe=
s-bsp/u-boot/u-boot-rockchip.inc<br>
&gt; &gt; &gt; index 2b5bbd7..67c4418 100644<br>
&gt; &gt; &gt; --- a/recipes-bsp/u-boot/u-boot-rockchip.inc<br>
&gt; &gt; &gt; +++ b/recipes-bsp/u-boot/u-boot-rockchip.inc<br>
&gt; &gt; &gt; @@ -11,7 +11,9 @@ do_compile[depends] .=3D &quot;${TFA_DEPEN=
DS}&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0ROCKCHIP_TPL:closed-tpl =3D &quot;${DEPLOY_DIR_I=
MAGE}/ddr-${SOC_FAMILY}.bin&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0# SOC_FAMILY for RK3588S is rk3588s but it shoul=
d use the binaries from rk3588<br>
&gt; &gt; &gt;=C2=A0 =C2=A0ROCKCHIP_TPL:closed-tpl:rk3588s =3D &quot;${DEPL=
OY_DIR_IMAGE}/ddr-rk3588.bin&quot;<br>
&gt; &gt; &gt; +ROCKCHIP_TEE:closed-tpl:rk3506 =3D &quot;${DEPLOY_DIR_IMAGE=
}/tee-rk3506.bin&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0EXTRA_OEMAKE:append:closed-tpl =3D &quot; ROCKCH=
IP_TPL=3D${ROCKCHIP_TPL}&quot;<br>
&gt; &gt; &gt; +EXTRA_OEMAKE:append:closed-tpl:rk3506 =3D &quot; TEE=3D${RO=
CKCHIP_TEE}&quot;<br>
&gt; &gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; I think you only want<br>
&gt; &gt; <br>
&gt; &gt; ROCKCHIP_TEE:rk3506<br>
&gt; &gt; <br>
&gt; &gt; and<br>
&gt; &gt; <br>
&gt; &gt; EXTRA_OEMAKE:append:rk3506<br>
&gt; &gt; <br>
&gt; &gt; as I believe TEE has nothing to do with whether we&#39;re using a=
 DRAM init<br>
&gt; &gt; blob?<br>
&gt; &gt; <br>
&gt; &gt; Also, this isn&#39;t working because you forgot to add the depend=
ency on<br>
&gt; &gt; optee-os (see do_compile[depends] .=3D &quot;${TFA_DEPENDS}&quot;=
 for how we have the<br>
&gt; &gt; dependency for trsuted-firmware-a on Aarch64).<br>
&gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0INIT_FIRMWARE_DEPENDS ??=3D &quot;&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0INIT_FIRMWARE_DEPENDS:closed-tpl =3D &quot; rock=
chip-rkbin-ddr:do_deploy&quot;<br>
&gt; &gt; &gt; diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-=
bsp/u-boot/u-boot_%.bbappend<br>
&gt; &gt; &gt; index 08e1730..fc6a36e 100644<br>
&gt; &gt; &gt; --- a/recipes-bsp/u-boot/u-boot_%.bbappend<br>
&gt; &gt; &gt; +++ b/recipes-bsp/u-boot/u-boot_%.bbappend<br>
&gt; &gt; &gt; @@ -8,6 +8,10 @@ DEPENDS:append:rk3308 =3D &quot; u-boot-too=
ls-native&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0DEPENDS:append:rock-pi-4 =3D &quot; gnutls-nativ=
e&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0DEPENDS:append:rk-u-boot-env =3D &quot; u-boot-m=
kenvimage-native&quot;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; +BRANCH:luckfox-lyra-plus =3D &quot;rk3506&quot;<br>
&gt; &gt; &gt; +SRC_URI:luckfox-lyra-plus =3D &quot;git://<a href=3D"http:/=
/source.denx.de/u-boot/contributors/kwiboo/u-boot.git;protocol=3Dhttps;bran=
ch=3D$%7BBRANCH%7D" rel=3D"noreferrer noreferrer" target=3D"_blank">source.=
denx.de/u-boot/contributors/kwiboo/u-boot.git;protocol=3Dhttps;branch=3D${B=
RANCH}</a>&quot;<br>
&gt; &gt; &gt; +SRCREV:luckfox-lyra-plus =3D &quot;c6782a37feee4a8aee08d321=
c01b4ca0b0562f0b&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; <br>
&gt; &gt; That&#39;s a BIG no-no.<br>
&gt; &gt; <br>
&gt; &gt; Have a separate recipe for this.<br>
&gt; &gt; <br>
&gt; &gt; Knowing Jonas, there are chances this branch will get rebased, so=
 I don&#39;t<br>
&gt; &gt; think we want this at all.<br>
&gt; &gt; <br>
&gt; &gt; I see patches on the U-Boot mailing list for RK3506 support in U-=
Boot, see<br>
&gt; &gt; <a href=3D"https://lore.kernel.org/u-boot/20260109005008.101506-1=
-jonas@kwiboo.se/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
lore.kernel.org/u-boot/20260109005008.101506-1-jonas@kwiboo.se/</a> and<br>
&gt; &gt; Jonas &quot;promised&quot; a v2. Maybe work with him on getting t=
he v2 sent upstream?<br>
&gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0do_compile:append:rock2-square () {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # copy to default search p=
ath<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;${SPL_BINARY}&q=
uot; =3D &quot;u-boot-spl-dtb.bin&quot; ]; then<br>
&gt; &gt; &gt; diff --git a/recipes-kernel/linux/<a href=3D"http://linux-ar=
mbian_git.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">linux-armbian=
_git.bb</a> b/recipes-kernel/linux/<a href=3D"http://linux-armbian_git.bb" =
rel=3D"noreferrer noreferrer" target=3D"_blank">linux-armbian_git.bb</a><br=
>
&gt; &gt; &gt; new file mode 100644<br>
&gt; &gt; &gt; index 0000000..42dad4f<br>
&gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; +++ b/recipes-kernel/linux/<a href=3D"http://linux-armbian_g=
it.bb" rel=3D"noreferrer noreferrer" target=3D"_blank">linux-armbian_git.bb=
</a><br>
&gt; &gt; <br>
&gt; &gt; I&#39;ll let Trevor speak his mind here but I don&#39;t think Arm=
bian Linux kernel<br>
&gt; &gt; is something we&#39;re interested in supporting. Work with upstre=
am to get the<br>
&gt; &gt; board supported in upstream Linux and then we can have it here.<b=
r>
&gt; <br>
&gt; I agree with Quentin&#39;s assessment. If rockchip were a platform tha=
t had<br>
&gt; little or no upstream support then we would need to have all sorts of<=
br>
&gt; recipes for bootloaders and kernels from wherever we could find them.<=
br>
&gt; But with rockchip, upstream support is usually just a matter of time.<=
br>
&gt; I&#39;ll take new machines if they&#39;re in linux-yocto-dev, but woul=
d rather<br>
&gt; stay away from vendor kernels.<br>
&gt; <br>
&gt; If a board is wildly popular and will never have upstream support then=
 I<br>
&gt; would consider it. But if Jonas is already working on it, then we will=
<br>
&gt; probably see upstream support shortly.<br>
&gt; <br>
&gt; &gt; Cheers,<br>
&gt; &gt; Quentin<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; <br>
&gt; <br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#3136): <a href=3D"https://lists.yoctoproject.org/g=
/yocto-patches/message/3136" rel=3D"noreferrer noreferrer" target=3D"_blank=
">https://lists.yoctoproject.org/g/yocto-patches/message/3136</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/11749646=
3/900817" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.yoc=
toproject.org/mt/117496463/900817</a><br>
&gt; Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoprojec=
t.org" target=3D"_blank" rel=3D"noreferrer">yocto-patches+owner@lists.yocto=
project.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches=
/leave/13168745/900817/63955952/xyzzy" rel=3D"noreferrer noreferrer" target=
=3D"_blank">https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/9=
00817/63955952/xyzzy</a> [<a href=3D"mailto:twoerner@gmail.com" target=3D"_=
blank" rel=3D"noreferrer">twoerner@gmail.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; <br>
&gt; <br>
</blockquote></div>

--000000000000e086a7064989e6a0--

