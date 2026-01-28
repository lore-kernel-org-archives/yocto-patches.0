Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1522ED3F08E
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 16:04:32 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.850.1769616262403851411
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Jan 2026 08:04:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q6bEjIdv;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8947ddce09fso64499496d6.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769616261; x=1770221061; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bf6InT3b4LQNgw8mcMy+6CdF3+UGkZyLpQlocL7yHAE=;
        b=Q6bEjIdvYupDqlLRM6QdyqL7BkezK5n1iAcxxcGBAHYOwbbmWxhbcb4L92aC6IVgxw
         ASThRcW5IfJHaYMmc8/O8jePZ/OGz4tu228FeOgz5iJbJFDE6UJZWJLk5F65P0ZPmS6Y
         /poUvNV0t1dVBT7tMjcdAKRWr99/h3fCYkyN+vMKGHra6jFARJghmhzH8baz7wgxDL20
         6dIt2O8tQeBIx7/zsiMFx4S2Hj8rMMy/S+huxeHqtfdh+4Z/zGIbP+K/qWSzTXzjLjcq
         C4BKvv4OEz83n99brL1/UmlWc4a9aYIWzqTaXnGJg7UwJCmWH/fheFnK8RJrGA8Ac8Zw
         K2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616261; x=1770221061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bf6InT3b4LQNgw8mcMy+6CdF3+UGkZyLpQlocL7yHAE=;
        b=mei4xsFGriM12FxluKsXrIVlhaMA805+7glvFM8hZkL74Fn8d89mNECFRjrhUw36Df
         /kygHIcpvdcE5Xps2BlHGr2YyTAlc10srhbO7a/bEzTjghk/0Gp6vVcsOrKVUvnpIo0F
         unVLiaP4+Iyjc1CSmmuhttQqPNKnyriI3yeiM3UZsSX0wMszpCIfW7+CnEuKJZGJ0YBC
         jcp8DJEw0Ku6HmK49s+gJhu+IAMVp3xFAL5iBUyXJujevpreR4Zv875rCvEG7vL9+9zY
         Krhm9jJDqPtd2H2kc4jbz/u4wWrDw4AeYZGHqkPcL3hT91kRAMCQlJ+GFufKFrJ8ycVd
         yvwg==
X-Gm-Message-State: AOJu0YzYOxHyfhZ6v3Fv+VhXWTZywrWTMSB45yPjnBHedGYqWIGAtd6n
	b+YMt4QMAjxls6Us0XjOf9E8F89LD09jzyXN4gI5IwapFzNSi849PTiRIgqhzc2E
X-Gm-Gg: AZuq6aI/dDW9hNUtEBObkRfiKEGFmBCQ8PZmQQ57WpootYZb+oR/wHEP7jAdyWaiXbo
	YHfrbHfTvBJ7k9D8XbkGjsQO1Gdzvz0QbOUzGV2f7vAdWYDMtSznCPmxE/BcaXaS8jVOlmJ8QZ+
	Yw9oLpO6HT3GFcyVH/jJeAQoGPboJt70R5Uyhi1amTxdsmllPrCZIwAjPMsQ8VkE1WMwYFEtb17
	6uI9Pk6LfxCatVl7UyhfVAgp2Ra6ACFHWr8tiF3mcNktN+uyIfHylhe6TQ4pL4wBvH6gqXN3ro1
	YGYgWuKA9/CWbU5UAoEJvC22dSC1MeKYsNJ5F78fDLku6Sootvc/9OEw5of/SJctWxLVTvJel8U
	ZCkbr75ZbprZiGM1XpJVLFCCXEwdmis5IHHzljqjo8I3wSwSeJU3qzV35YlBgsKL7SkXeYhsFLn
	+RqBBmTLhmhKFPPTHxmbG0/wjg/zg3YDEFp8eFFzU9y+//8bjUs/bJZuXB/zbqra9q
X-Received: by 2002:ad4:5d44:0:b0:894:cc3b:95a9 with SMTP id 6a1803df08f44-894cc84d81cmr85852546d6.29.1769616254664;
        Wed, 28 Jan 2026 08:04:14 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c2413sm19546706d6.15.2026.01.28.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:04:13 -0800 (PST)
Date: Wed, 28 Jan 2026 11:04:11 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: mbober1@gmail.com
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] luckfox-lyra-plus: add
Message-ID: <aXozeyfMePnaUB8c@localhost.localdomain>
References: <20260127205141.26089-1-mbober1@gmail.com>
 <2bf93914-dd8a-4e3c-9c97-74acb1c975ab@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bf93914-dd8a-4e3c-9c97-74acb1c975ab@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 16:04:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3136

Thank you, Quentin, for your thorough review!

On Wed 2026-01-28 @ 11:35:17 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Marcin,
> 
> On 1/27/26 9:51 PM, Marcin Bober via lists.yoctoproject.org wrote:
> > [You don't often get email from mbober1=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > The Luckfox Lyra Plus is ultra-small, tri-core single board computer
> > based on the Rockchip RK3506G2, with a very compact form factor.
> > 
> > Signed-off-by: Marcin Bober <mbober1@gmail.com>
> > ---
> >   README                                        |  1 +
> >   conf/machine/include/rk3506.inc               | 20 +++++++++++++
> >   conf/machine/include/rk3568.inc               |  1 -
> >   conf/machine/include/rk3588s.inc              |  1 -
> >   conf/machine/luckfox-lyra-plus.conf           | 27 +++++++++++++++++
> >   recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb   |  9 ++++++
> >   .../rkbin/rockchip-rkbin-optee-os_git.bb      |  5 ++++
> >   recipes-bsp/rkbin/rockchip-rkbin.inc          |  1 +
> >   recipes-bsp/u-boot/u-boot-rockchip.inc        |  2 ++
> >   recipes-bsp/u-boot/u-boot_%.bbappend          |  4 +++
> >   recipes-kernel/linux/linux-armbian_git.bb     | 29 +++++++++++++++++++
> >   11 files changed, 98 insertions(+), 2 deletions(-)
> >   create mode 100644 conf/machine/include/rk3506.inc
> >   create mode 100644 conf/machine/luckfox-lyra-plus.conf
> >   create mode 100644 recipes-kernel/linux/linux-armbian_git.bb
> > 
> > diff --git a/README b/README
> > index 6bceba0..3991415 100644
> > --- a/README
> > +++ b/README
> > @@ -23,6 +23,7 @@ Status of supported boards:
> >                          tinker-board
> >                          tinker-board-s
> >                          vyasa-rk3288
> > +                       luckfox-lyra-plus
> 
> Please keep the list ordered alphabetically.
> 
> > 
> >                  64-bit:
> >                          nanopi-m4
> > diff --git a/conf/machine/include/rk3506.inc b/conf/machine/include/rk3506.inc
> > new file mode 100644
> > index 0000000..e204283
> > --- /dev/null
> > +++ b/conf/machine/include/rk3506.inc
> > @@ -0,0 +1,20 @@
> > +MACHINEOVERRIDES =. "rk3506:"
> > +SOC_FAMILY = "rk3506"
> > +DEFAULTTUNE = "cortexa7thf-neon-vfpv4"
> > +
> > +ROCKCHIP_CLOSED_TPL ?= "1"
> > +
> > +require conf/machine/include/soc-family.inc
> > +require conf/machine/include/rockchip-defaults.inc
> > +require conf/machine/include/arm/armv7a/tune-cortexa7.inc
> > +require conf/machine/include/rockchip-wic.inc
> > +
> > +PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> > +
> 
> Ooooh, I believe this would mean OP-TEE OS blob from Rockchip can be used
> with upstream U-Boot? Have you actually tried? This would be interesting for
> me for https://lore.kernel.org/yocto-patches/20260126-optee-os-v1-0-874261a77dad@cherry.de/
> to check if I got it right for rockchip-rkbin-optee-os as well.
> 
> Is OP-TEE OS *required* on rk3506 to be able to boot? Do you know?
> 
> Essentially, with the patch series listed above applied, you would need to
> set RK_UBOOT_TEE = "1" and then U-Boot would automatically add the necessary
> dependency and add the correct filepath to the TEE environment variable.
> 
> > +KBUILD_DEFCONFIG ?= "rk3506_defconfig"
> 
> Usually we would rather have multi_v7_defconfig and if needed apply
> .scc+.cfg config fragments (see what's been done for nanopi-r4s).
> 
> > +KERNEL_CLASSES = "kernel-fitimage"
> > +KERNEL_IMAGETYPE ?= "fitImage"
> > +
> 
> Isn't a FIT image the default when you include rockchip-defaults? See
> RK_KERNEL_FITIMAGE variable.
> 
> > +UBOOT_SUFFIX ?= "itb"
> > +UBOOT_ENTRYPOINT ?= "0x02800000"
> > +UBOOT_EXTLINUX_FDT = "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"
> 
> isn't that already handled with RK_KERNEL_FITIMAGE from within
> conf/machine/include/rockchip-extlinux.inc (you may then want to require
> this file).
> 
> > diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
> > index bcf9dd8..12f0ba2 100644
> > --- a/conf/machine/include/rk3568.inc
> > +++ b/conf/machine/include/rk3568.inc
> > @@ -10,7 +10,6 @@ require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
> >   require conf/machine/include/rockchip-wic.inc
> > 
> >   KBUILD_DEFCONFIG ?= "defconfig"
> > -KERNEL_FEATURES:append:rk3568 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> 
> This has nothing to do with adding support for this new device no?
> 
> >   KERNEL_CLASSES = "kernel-fitimage"
> >   KERNEL_IMAGETYPE ?= "fitImage"
> > 
> > diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
> > index 6ec344a..d0654c1 100644
> > --- a/conf/machine/include/rk3588s.inc
> > +++ b/conf/machine/include/rk3588s.inc
> > @@ -9,7 +9,6 @@ require conf/machine/include/arm/armv8-2a/tune-cortexa76-cortexa55.inc
> >   require conf/machine/include/rockchip-wic.inc
> > 
> >   KBUILD_DEFCONFIG ?= "defconfig"
> > -KERNEL_FEATURES:append:rk3588s = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> 
> This has nothing to do with adding support for this new device no?
> 
> >   KERNEL_CLASSES = "kernel-fitimage"
> >   KERNEL_IMAGETYPE ?= "fitImage"
> > 
> > diff --git a/conf/machine/luckfox-lyra-plus.conf b/conf/machine/luckfox-lyra-plus.conf
> > new file mode 100644
> > index 0000000..529a472
> > --- /dev/null
> > +++ b/conf/machine/luckfox-lyra-plus.conf
> > @@ -0,0 +1,27 @@
> > +#@TYPE: Machine
> > +#@NAME: Luckfox Lyra Plus
> > +#@DESCRIPTION: RK3506G2 based Linux Micro Development Board
> > +#https://www.luckfox.com/Luckfox-Lyra-Plus

Usually I would be excited about a tiny rockchip-based SBC with
hardwired ethernet. But a new SoC based on CortexA7 (i.e. 32-bit)??
And no SDcard?

Hopefully someone comes out with something new to replace the zero-3e
which appears to be out of production.

> > +
> > +require conf/machine/include/rk3506.inc
> > +
> > +KERNEL_DEVICETREE ?= "rk3506g-luckfox-lyra-plus-sd.dtb"
> > +MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
> > +PREFERRED_PROVIDER_virtual/kernel = "linux-armbian"
> 
> I believe we only take boards which are supported by linux-yocto or
> linux-yocto-dev from the master branch of OE-Core. I don't even see patches
> on the linux-rockchip mailing list
> 
> > +EXTERNAL_KERNEL_DEVICETREE = "${DEPLOY_DIR_IMAGE}/devicetree"
> > +
> > +UBOOT_MACHINE = "luckfox-lyra-rk3506_defconfig"
> > +
> > +MACHINE_FEATURES = " \
> > +  rtc \
> > +  screen \
> > +  serial \
> > +  usbgadget \
> > +  usbhost \
> > +  vfat \
> > +"
> > +
> > +KERNEL_FEATURES += " \
> > +  cfg/fs/ext4.scc \
> > +  features/cgroups/cgroups.scc \
> > +"
> 
> KERNEL_FEATURES must be listed in the kernel recipe not in the machine.
> 
> > diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> > index 3227a53..7f654ff 100644
> > --- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> > +++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> > @@ -10,6 +10,15 @@ do_deploy:rk3308() {
> >          install -m 644 ${S}/bin/rk33/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin
> >   }
> > 
> 
> Wait.... This doesn't exist anymore. Against which branch did you develop
> this patch?
> 
> The master branch has a completely different mechanism which is much more
> automatic than what's needed below.
> 
> > +DDRBIN_VERS:rk3506 ?= "v1.02"
> > +DDRBIN_FILE:rk3506 ?= "rk3506_ddr_750MHz_${DDRBIN_VERS}.bin"
> > +
> > +do_deploy:rk3506() {
> > +       # Prebuilt U-Boot TPL (DDR init)
> > +       install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3506.bin
> > +       install -m 644 ${S}/bin/rk35/rk3506_tee_v1.23.bin ${DEPLOYDIR}/tee-rk3506.bin
> 
> This is TEE, not DRAM init blob so shouldn't be deployed in this recipe.
> 
> > +}
> > +>   DDRBIN_VERS:rk3566 ?= "v1.23"
> >   DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
> > 
> > diff --git a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> > index 6d25368..cbd376c 100644
> > --- a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> > +++ b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> > @@ -9,6 +9,11 @@ do_deploy:rk3308() {
> >          install -m 644 ${S}/bin/rk33/rk3308_bl32_v*.bin ${DEPLOYDIR}/tee-rk3308.bin
> >   }
> > 
> > +do_deploy:rk3506() {
> > +       # Prebuilt OPTEE-OS
> > +       install -m 644 ${S}/bin/rk35/rk3506_tee_v*.bin ${DEPLOYDIR}/tee-rk3506.bin
> > +}
> > +
> >   # NOTE: the following are not typos
> >   #       the rk3566 uses the same bl32 as the rk3568
> >   do_deploy:rk3566() {
> > diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
> > index 9264db9..8dfdc09 100644
> > --- a/recipes-bsp/rkbin/rockchip-rkbin.inc
> > +++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
> > @@ -11,6 +11,7 @@ S = "${WORKDIR}/git"
> > 
> >   COMPATIBLE_MACHINE = "^$"
> >   COMPATIBLE_MACHINE:rk3308 = "rk3308"
> > +COMPATIBLE_MACHINE:rk3506 = "rk3506"
> >   COMPATIBLE_MACHINE:rk3566 = "rk3566"
> >   COMPATIBLE_MACHINE:rk3568 = "rk3568"
> >   COMPATIBLE_MACHINE:rk3588s = "rk3588s"
> > diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc b/recipes-bsp/u-boot/u-boot-rockchip.inc
> > index 2b5bbd7..67c4418 100644
> > --- a/recipes-bsp/u-boot/u-boot-rockchip.inc
> > +++ b/recipes-bsp/u-boot/u-boot-rockchip.inc
> > @@ -11,7 +11,9 @@ do_compile[depends] .= "${TFA_DEPENDS}"
> >   ROCKCHIP_TPL:closed-tpl = "${DEPLOY_DIR_IMAGE}/ddr-${SOC_FAMILY}.bin"
> >   # SOC_FAMILY for RK3588S is rk3588s but it should use the binaries from rk3588
> >   ROCKCHIP_TPL:closed-tpl:rk3588s = "${DEPLOY_DIR_IMAGE}/ddr-rk3588.bin"
> > +ROCKCHIP_TEE:closed-tpl:rk3506 = "${DEPLOY_DIR_IMAGE}/tee-rk3506.bin"
> >   EXTRA_OEMAKE:append:closed-tpl = " ROCKCHIP_TPL=${ROCKCHIP_TPL}"
> > +EXTRA_OEMAKE:append:closed-tpl:rk3506 = " TEE=${ROCKCHIP_TEE}"
> > 
> 
> I think you only want
> 
> ROCKCHIP_TEE:rk3506
> 
> and
> 
> EXTRA_OEMAKE:append:rk3506
> 
> as I believe TEE has nothing to do with whether we're using a DRAM init
> blob?
> 
> Also, this isn't working because you forgot to add the dependency on
> optee-os (see do_compile[depends] .= "${TFA_DEPENDS}" for how we have the
> dependency for trsuted-firmware-a on Aarch64).
> 
> >   INIT_FIRMWARE_DEPENDS ??= ""
> >   INIT_FIRMWARE_DEPENDS:closed-tpl = " rockchip-rkbin-ddr:do_deploy"
> > diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> > index 08e1730..fc6a36e 100644
> > --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> > +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> > @@ -8,6 +8,10 @@ DEPENDS:append:rk3308 = " u-boot-tools-native"
> >   DEPENDS:append:rock-pi-4 = " gnutls-native"
> >   DEPENDS:append:rk-u-boot-env = " u-boot-mkenvimage-native"
> > 
> > +BRANCH:luckfox-lyra-plus = "rk3506"
> > +SRC_URI:luckfox-lyra-plus = "git://source.denx.de/u-boot/contributors/kwiboo/u-boot.git;protocol=https;branch=${BRANCH}"
> > +SRCREV:luckfox-lyra-plus = "c6782a37feee4a8aee08d321c01b4ca0b0562f0b"
> > +
> 
> That's a BIG no-no.
> 
> Have a separate recipe for this.
> 
> Knowing Jonas, there are chances this branch will get rebased, so I don't
> think we want this at all.
> 
> I see patches on the U-Boot mailing list for RK3506 support in U-Boot, see
> https://lore.kernel.org/u-boot/20260109005008.101506-1-jonas@kwiboo.se/ and
> Jonas "promised" a v2. Maybe work with him on getting the v2 sent upstream?
> 
> >   do_compile:append:rock2-square () {
> >          # copy to default search path
> >          if [ "${SPL_BINARY}" = "u-boot-spl-dtb.bin" ]; then
> > diff --git a/recipes-kernel/linux/linux-armbian_git.bb b/recipes-kernel/linux/linux-armbian_git.bb
> > new file mode 100644
> > index 0000000..42dad4f
> > --- /dev/null
> > +++ b/recipes-kernel/linux/linux-armbian_git.bb
> 
> I'll let Trevor speak his mind here but I don't think Armbian Linux kernel
> is something we're interested in supporting. Work with upstream to get the
> board supported in upstream Linux and then we can have it here.

I agree with Quentin's assessment. If rockchip were a platform that had
little or no upstream support then we would need to have all sorts of
recipes for bootloaders and kernels from wherever we could find them.
But with rockchip, upstream support is usually just a matter of time.
I'll take new machines if they're in linux-yocto-dev, but would rather
stay away from vendor kernels.

If a board is wildly popular and will never have upstream support then I
would consider it. But if Jonas is already working on it, then we will
probably see upstream support shortly.

> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3129): https://lists.yoctoproject.org/g/yocto-patches/message/3129
> Mute This Topic: https://lists.yoctoproject.org/mt/117496463/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

