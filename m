Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58371C4345F
	for <webhook@archiver.kernel.org>; Sat,  4 May 2024 12:49:15 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.web10.12671.1714826949896291503
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 04 May 2024 05:49:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TEuPQrBV;
 spf=pass (domain: gmail.com, ip: 209.85.128.181, mailfrom: twoerner@gmail.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61bee45d035so5242167b3.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 04 May 2024 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714826948; x=1715431748; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8VJzLHeVuxFAYnnPqS2HDI+ZqczRm2OFYODNP4EnKoE=;
        b=TEuPQrBVkw4CSHcvM74RVSZnBOicFB9vDSMrGOsvBadVdxRn5xkQnpF+BoLmrNlIGa
         shad+e6UlTuIfhddSOE4qxt/2pGSXZffoXfeuC5yQeCApBbEsDouhXgfcSvJbLlrlRpK
         qkBIXD78H1/hrABZBN+1vfKEXl/YC2XZNUnFAAba06Gi1a2XrgB6yokFmy6xZPlbP09f
         BH3qpDdVESQGyUsXbDniUmmzkFb3pNbs5Z6FsQNfUGMNn3LOyHyT8RMALzViDMsAug/l
         V5aYLbUgavY7xo5ywvtTfalgGGE0JJ7dJ30DWYEY1hKlpoFl6jvsO0zqlNa+XmGXFglm
         nYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714826948; x=1715431748;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VJzLHeVuxFAYnnPqS2HDI+ZqczRm2OFYODNP4EnKoE=;
        b=c8a49B/mYgV/YzwRkhKKqnTcdS9vjz4jEi2TnwWrVGKGPY8PEHm5jt8D9PlIZGJ2GE
         4fjGam//Oybh0R1SYaRKwgPJutZmdK1+9KBWC1uu4WLnARUVH6FbgWqYanFeXIVUPRid
         3b5j/QREfOWmauKBj/oL0uXFPT9bXhyxAdG7sqxvMB6AFpD9UUN2/2R6SqJj/2rnDErd
         WtiZOqcRQgHJdcRiRbn+sQgo9jae+lRkrYz7X58lVDSpTR4rR/pYbQnXvwVeikKag+i6
         k4WDY5OKFBqiJsOIeTq3kK12haUlyLHVCNtsSSIHLvzTqYZa+wX84XWf51ePtWmKJwlx
         ipEQ==
X-Gm-Message-State: AOJu0YwRLe14AyVu1KEEIoGjoCrQHftCyHNm11B/CYTZP3ykvfR8ubbu
	Y2/wkIMPWWe1f5SPngsS5xIJBFDlYRQAUABqGtNddcFCU774PgnYJ7SDcA==
X-Google-Smtp-Source: AGHT+IHFpVXFVSSWDOEvmXSR/+o1gTCOfyT6tkF0CUOVyVAKIkE5EzjLO9609pH+xq1gA8mAtTMBEQ==
X-Received: by 2002:a0d:cb13:0:b0:61b:91e3:f954 with SMTP id n19-20020a0dcb13000000b0061b91e3f954mr5257059ywd.8.1714826948204;
        Sat, 04 May 2024 05:49:08 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id bv18-20020a05622a0a1200b00439bb9c454bsm2779022qtb.56.2024.05.04.05.49.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 05:49:07 -0700 (PDT)
Date: Sat, 4 May 2024 08:49:05 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v4] enable stored U-Boot
 environment
Message-ID: <20240504124905.GA40711@localhost>
References: <20240430202359.12771-1-twoerner@gmail.com>
 <933c30f5-f6ee-4e8f-a976-70a06e083fcb@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <933c30f5-f6ee-4e8f-a976-70a06e083fcb@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 04 May 2024 12:49:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/83

On Fri 2024-05-03 @ 03:22:54 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 4/30/24 10:23 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > U-Boot has the ability to store its environment variables to a permanent
> > storage device. Whether or not it does so for any one specific device
> > depends on whatever settings are enabled in that specific device's
> > defconfig. In order to definitively configure U-Boot to be able to store
> > its environment into the device from which it boots, for any device
> > supported in this BSP, simply add the following to MACHINE_FEATURES:
> > 
> > 	rk-u-boot-env
> > 
> > If enabled, there is now a second choice to make: should the build also
> > include the U-Boot environment in the image or not? The default environment,
> > as generated by U-Boot, can be included in the generated wic image. If it
> > is included, then flashing the image will also flash the default U-Boot
> > environment variables and settings, wiping out anything that might have been
> > there already. If it is not included then your device will either continue
> > using whatever environment happens to be there (if valid), or will not use any
> > stored environment if the stored environment has not been set or is invalid.
> > The variable which governs this behaviour is:
> > 
> > 	RK_IMAGE_INCLUDES_UBOOT_ENV
> > 
> > By default this is set to "0", meaning that by default the image does not
> > contain the U-Boot environment. To enable this behaviour, enable this
> > variable. This variable only takes effect if rk-u-boot-env is listed in
> > MACHINE_FEATURES, and has no effect otherwise.
> > 
> > The script:
> > 
> > 	scripts/dump-uboot-env-from-yocto-image.sh
> > 
> > can be used on a rockchip wic image to see the contents of the U-Boot
> > environment partition at build time.
> > 
> > Tested by booting the same image on both eMMC and SDcard with the following
> > devices, verifying the ability to read and write the U-Boot environment in
> > both U-Boot and Linux user-space, and that changes made in one are seen in the
> > other:
> > 	rock-3a
> > 	rock-5a
> > 	rock-5b
> > 	rock-pi-4b
> > 	rock-pi-e
> > 	rock64
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> > v4 changes:
> > - sort WICVARS alphabetically
> > - tweak dump-uboot-env-from-yocto-image.sh script to not just check for
> >    the existence of the user-supplied parameter, but that it is a file
> >    specifically
> > - u-boot bbappend:
> >    - use a do_compile[postfuncs] for generating the fw_env.config instead of
> >      a do_compile:append
> >    - move the conversion of the U-Boot text-based environment to the
> >      require binary representation from a do_deploy:append to the newly-created
> >      do_compile[postfuncs] created above, this will allow the user to inject
> >      any extra U-Boot environment variables they might wish as part of a
> >      do_compile:append and have that occur before the binary is generated
> >      so that those additional user-supplied values are included
> >    - add a lot of extra checking (instead of assuming various resources exist)
> >      before making use of said resources
> > 
> > v3 changes:
> > - switch from using a bbclass so the `rk-u-boot-env` override can be used
> >    directly
> > - add SPDX header to script
> > - drop `inherit deploy` in U-Boot bbappend
> > 
> > v2 changes:
> > - re-word the commit message and README for clarity
> > - use bash's built-in math handling instead of depending on `bc`
> > - in anticipation of the upcoming feature in U-Boot whereby rockchip
> >    devices can automatically select the environment storage device to be
> >    the same as the boot device, use a more recent SRCREV for builds that do
> >    environment handling, instead of hardcoding the environment storage device
> >    by SoC family
> > - handle RK_IMAGE_INCLUDES_UBOOT_ENV as a boolean
> > ---
> >   README                                        | 20 ++++++++++
> >   conf/machine/include/rockchip-wic.inc         | 11 +++++
> >   .../rockchip-enable-environment-mmc.cfg       |  6 +++
> >   recipes-bsp/u-boot/u-boot_%.bbappend          | 40 +++++++++++++++++++
> >   scripts/dump-uboot-env-from-yocto-image.sh    | 29 ++++++++++++++
> >   wic/rockchip.wks                              |  2 +-
> >   6 files changed, 107 insertions(+), 1 deletion(-)
> >   create mode 100644 recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
> >   create mode 100755 scripts/dump-uboot-env-from-yocto-image.sh
> > 
> > diff --git a/README b/README
> > index c76fc9131276..605773d4ecd3 100644
> > --- a/README
> > +++ b/README
> > @@ -67,6 +67,26 @@ Notes:
> >   	
> >   	in the configuration (e.g. conf/local.conf).
> > +U-Boot Environment:
> > +------------------
> > +	In order to configure U-Boot to be able to store its environment into the
> > +	device from which it was booted, for any device supported in this BSP,
> > +	simply add the following to MACHINE_FEATURES:
> > +
> > +		rk-u-boot-env
> > +
> > +	If enabled, to additionally have the U-Boot environment generated and
> > +	stored in the image, also enable the following variable (default: off):
> > +
> > +		RK_IMAGE_INCLUDES_UBOOT_ENV
> > +
> > +	The script:
> > +
> > +		scripts/dump-uboot-env-from-yocto-image.sh
> > +
> > +	can be used on a rockchip wic image to see the contents of the U-Boot
> > +	environment partition at build time.
> > +
> >   Maintenance:
> >   -----------
> >   	Please send pull requests, patches, comments, or questions to the
> > diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
> > index 147a36685d7d..92749b514499 100644
> > --- a/conf/machine/include/rockchip-wic.inc
> > +++ b/conf/machine/include/rockchip-wic.inc
> > @@ -2,6 +2,11 @@
> >   require conf/machine/include/rockchip-extlinux.inc
> > +# 'rk-u-boot-env' indicates the user wants to be able to save their U-Boot
> > +# environment back to the drive from which the device was booted
> > +MACHINEOVERRIDES .= "${@bb.utils.contains('MACHINE_FEATURES', 'rk-u-boot-env', ':rk-u-boot-env', '', d)}"
> > +IMAGE_INSTALL:append:rk-u-boot-env = " u-boot-fw-utils u-boot-env"
> > +
> >   SPL_BINARY ?= "idbloader.img"
> >   IMAGE_FSTYPES += "wic wic.bmap"
> > @@ -11,7 +16,13 @@ WKS_FILE_DEPENDS ?= " \
> >   	virtual/bootloader \
> >   	"
> > +RK_IMAGE_INCLUDES_UBOOT_ENV ?= "no"
> > +RK_UBOOT_ENV = " "
> > +RK_UBOOT_ENV:rk-u-boot-env = "${@ '--source rawcopy --sourceparams=file=u-boot.env' if \
> > +	bb.utils.to_boolean(d.getVar('RK_IMAGE_INCLUDES_UBOOT_ENV'), False) else ' '}"
> > +
> >   WICVARS:append = " \
> > +	RK_UBOOT_ENV \
> >   	SPL_BINARY \
> >   	UBOOT_SUFFIX \
> >   	"
> > diff --git a/recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg b/recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
> > new file mode 100644
> > index 000000000000..778772d27767
> > --- /dev/null
> > +++ b/recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
> > @@ -0,0 +1,6 @@
> > +CONFIG_ENV_SIZE=0x8000
> > +CONFIG_ENV_OFFSET=0x3f8000
> > +# CONFIG_ENV_IS_NOWHERE is not set
> > +CONFIG_ENV_IS_IN_MMC=y
> > +CONFIG_DM_SEQ_ALIAS=y
> > +CONFIG_SPL_DM_SEQ_ALIAS=y
> > diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> > index a83179a9f007..3dd7f08732c5 100644
> > --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> > +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> > @@ -1,7 +1,13 @@
> > +FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> > +
> > +SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
> > +SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
> > +
> >   # various machines require the pyelftools library for parsing dtb files
> >   DEPENDS:append = " python3-pyelftools-native"
> >   DEPENDS:append:rk3308 = " u-boot-tools-native"
> >   DEPENDS:append:rock-pi-4 = " gnutls-native"
> > +DEPENDS:append:rk-u-boot-env = " u-boot-mkenvimage-native"
> >   EXTRA_OEMAKE:append:px30 = " BL31=${DEPLOY_DIR_IMAGE}/bl31-px30.elf"
> >   EXTRA_OEMAKE:append:rk3308 = " \
> > @@ -34,3 +40,37 @@ do_compile:append:rock2-square () {
> >   		cp ${B}/spl/${SPL_BINARY} ${B}
> >   	fi
> >   }
> > +
> > +rk_generate_env() {
> > +	if [ ! -f "${B}/.config" ]; then
> > +		echo "U-Boot .config not found, can't determine environment size"
> > +		return 1
> > +	fi
> > +	cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" > /dev/null
> > +	if [ $? -ne 0 ]; then
> > +		echo "can not find CONFIG_ENV_SIZE value in U-Boot .config"
> > +		return 1
> > +	fi
> > +
> > +	UBOOT_ENV_SIZE="$(cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" | cut -d'=' -f2)"
> > +
> > +	# linux user-space U-Boot env config file
> > +	echo "/dev/disk/by-partlabel/uboot_env 0x0000 ${UBOOT_ENV_SIZE}" > ${WORKDIR}/fw_env.config
> > +
> > +	# convert text-based environment to binary suitable for image
> > +	if ${@bb.utils.to_boolean(d.getVar('RK_IMAGE_INCLUDES_UBOOT_ENV'), False)}; then
> > +		if [ ! -f ${B}/u-boot-initial-env ]; then
> > +			echo "initial, text-formatted U-Boot environment file \"${B}/u-boot-initial-env\" not found"
> > +			return 1
> > +		fi
> > +		mkenvimage -s ${UBOOT_ENV_SIZE} ${B}/u-boot-initial-env -o ${WORKDIR}/u-boot.env
> 
> Could be put into ${B} instead of ${WORKDIR}, since we generate it? I guess
> since other files we generate are put into WORKDIR, it'd be up to you here.
> 
> > +	fi
> > +}
> > +do_compile[postfuncs] += "${@bb.utils.contains('MACHINE_FEATURES', 'rk-u-boot-env', 'rk_generate_env', '', d)}"
> 
> I can suggest:
> 
> """
> rk_generate_env() {
>     :
> }
> 
> rk_generate_env:rk-u-boot-env() {
>    [...]
> }
> 
> do_compile[postfuncs] += "rk_generate_env;"
> """
> 
> Which is a bit more readable for the do_compile[postfuncs] part. Up to you.

I actually did try making this change and in this case I don't think it looks
more readable. Given that we only are handling 1 case, it looked messy to me
having 1 empty function and 1 function to cover the 1 case we're interested
in. If we had a set of cases then I'd agree that it would look much nicer to
always include the postfunc; for which in 1/N cases it's empty (where N is >
2).

> > +
> > +do_deploy:append:rk-u-boot-env() {
> > +	if [ -f ${WORKDIR}/u-boot.env ]; then
> 
> This is an issue. If one builds with RK_IMAGE_INCLUDES_UBOOT_ENV = 1 and
> then RK_IMAGE_INCLUDES_UBOOT_ENV = 0, the file will still be in WORKDIR
> (because it is never cleaned). I suggest to test for
> RK_IMAGE_INCLUDES_UBOOT_ENV = true/1/yes/whatever instead (or in addition).

Sounds good.

Also the handling of that variable in the postfuncs had a bug in it. I built
and built and built that code over and over with various configurations and it
always built fine on my build machine. For fun I tried that patch on a
completely different machine and it failed. I'll be sure to do more clean
builds. So fixing that bug and adding this check are similar.

> I am not entirely sure the migration to UNPACKDIR would fix this (haven't
> read anything about the consequences of it, e.g. I'm not sure it's cleaned
> by any task). I'm also a bit puzzled by master still having some bits using
> WORKDIR in the u-boot recipe. Not sure what's going on here.
> 
> > +		install -d ${DEPLOYDIR}
> > +		install -m 0644 ${WORKDIR}/u-boot.env ${DEPLOYDIR}
> > +	fi
> > +}
> 
> We probably need to adapt this now that master uses UNPACKDIR instead of
> WORKDIR. This will require us to fork a branch for scarthgap now, which
> still uses WORKDIR but for the master branch, we need to use UNPACKDIR here.

Nice! I look forward to the UNPACKDIR functionality. My understanding is that
for the time-being UNPACKDIR is set to WORKDIR, so there are no visible
changes quite yet.

In any case I would prefer to get this patch in with WORKDIR, then perform a
WORKDIR → UNPACKDIR cleanup as a separate patch for the entire layer, rather
than half switching to UNPACKDIR for this patch then cleaning up the rest
sometime later.

> Outside from the blocker in do_deploy, and the questions around
> UNPACKDIR/WORKDIR, I think it's looking good right now?
> 
> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#81): https://lists.yoctoproject.org/g/yocto-patches/message/81
> Mute This Topic: https://lists.yoctoproject.org/mt/105829012/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

