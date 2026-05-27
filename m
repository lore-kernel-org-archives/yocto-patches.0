Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18A2CD5BDE
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 15:30:28 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23315.1779895825727637186
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 08:30:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=tHRs1sts;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so213906296d6.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779895824; x=1780500624; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IpCncgddmdwfbXJljZUvb0ZFHdW+OJ4Eqv2wyWvtXfA=;
        b=tHRs1stsHW4LNp+DGbFiBvxw7HSHdpnknc7jq/S4fxOGCG8iNvwGp+XXweC64h7fQR
         xqyYcAWyzaWwLIkIRR6L2HN37F/UNmK6moJGWkUlCQbN0sfrE7ldCzB32Vv666jPZYeZ
         3rRBTpegAZcfnxFny7Nkwf9O/hrrkjficADC/etK3dtsjlUGqt0Aufa4larstLIpXz2y
         2waqiedw6PfeCDPYY44YrThEri6DkB+a1aCMHEflNr9HwLSyWrRu3jLZk3aK6RjzgrEr
         hZVTgg+fh0nnnGWG0B2jUQI0A+ZqgXCBfIMNAGYqJWYw6n1HlFFcSRPRtGYjLGhvgeGr
         vRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779895824; x=1780500624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpCncgddmdwfbXJljZUvb0ZFHdW+OJ4Eqv2wyWvtXfA=;
        b=Dezwx4+nLnqoarTxaVAuscQTXgo/W75Z/ayz+EJaI6I5hIJYzvD5it79r+DXKKZBdY
         wRUsvAM236PxiwMxAoJMSnItsj1/6MkhWwppVCfDz6p6a6mBoRxXBBWuM1pl1KeucGUT
         Fmv2v41Cm26/7FINOvY7jGpymVE4LvmCkntTwbvlKMDv2axzOYoE21O2f6onynfl4Xyu
         v5EICpkU2ash8r40FC6ZzNFYRlxBnP0k3xvD21LHuZ1QG2Rym1eS1t1KlgsAGZvMqrJu
         axWUi993zDXLfh/DYXYwrsEDt1RTgU2CLm/jxqeaY3TrFEZZXLgQOi1H9BPHRrI/S32j
         8UTQ==
X-Gm-Message-State: AOJu0YxWayw7NFyIAmnhsMacqErShX9ZRohQYfp1zaxTeNCsmWwPmSfO
	ziNMzEAjNE9JfzVDnU5+iGT0MK/C4Cks8nir0vWtKksBc8308O4UiGjJIx4q7w==
X-Gm-Gg: Acq92OFNgLwZC2CWyaEkFe4hBN0zizFMrHfoutvF/ZawsYNhW5/FmJHu9YFO4artj+5
	nJyWu6A8XoXNi5j7qW32ISd5/ngzcku6td+dLxkgo3StFTjejjO6TkrFjn0QWy4vA0V8hUb0TYl
	/Eggbvb9EddwXyqVa3CNbn47B8vNqgO44HxVdsUMEluYiK9JqwNHQ+puhyFoecMMRjPbdXhIJJ0
	G715Aegt9YCBcuA0jk2RQKIWVyLTIR3FBlF4M3mWaURMEqFL4JmsOf5GTZecmeqnvLGv7ZAW70c
	81m3RW+Xri9gxVjZldAo6Vt6q2uiyYX4QrxASJLR1pY5FHssBBMc/mJmDYCbErkiOAJsRSo6OaD
	ZDlS2CgrVc7kFpB1ZgDhUPTowfjpG0HLv82qWIC6Q0Sts5Q20vI/3JSQchl9saZHLgz0WtQyulE
	lIPo2O2gSJ7x/aq2EKuEUN9NX8bQEq3w1iBh0wHZ0fGPHcqKeplLNEpC2K5sfbxXVgqA==
X-Received: by 2002:a05:620a:4686:b0:90e:6dd4:5d6d with SMTP id af79cd13be357-914b46b998amr3504301585a.10.1779895816320;
        Wed, 27 May 2026 08:30:16 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f881b620sm502530685a.42.2026.05.27.08.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:30:14 -0700 (PDT)
Date: Wed, 27 May 2026 11:30:12 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [PATCH meta-rockchip 2/2] add support for baking
 OP-TEE OS into U-Boot proper binary
Message-ID: <ahcOBJWhevGNqPyF@localhost.localdomain>
References: <20260126-optee-os-v1-0-874261a77dad@cherry.de>
 <20260126-optee-os-v1-2-874261a77dad@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126-optee-os-v1-2-874261a77dad@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 15:30:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4076

Hi Quentin,

Thanks for this patch series!

I believe there was a little fuzz required to apply patch 1 (around the
-D), perhaps a v2 against the current to clean that up?

On Mon 2026-01-26 @ 03:48:30 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> TF-A has support for loading OP-TEE OS as BL32 which allows us to have
> the following boot flow on supported Rockchip SoCs:
> 
> BootROM -> U-Boot TPL/SPL -> TF-A (BL31) -> OP-TEE OS (BL32) -> U-Boot
> proper -> Linux kernel
> 
> TF-A must be built with support for the opteed payload via the SPD
> variable. It can always be set, the downside is that if it's set and no
> OP-TEE OS is available to load, it'll complain with
> 
>   ERROR:   Error initializing runtime service opteed_fast
> 
> but will still continue the boot flow.
> 
> U-Boot proper must be built with OPTEE_LIB enabled (forced enabled on
> U-Boot v2026.01 when a TEE environment variable is set) otherwise random
> crashes may happen while in Linux as the memory marked as secure for
> OP-TEE OS isn't reserved and the kernel may use it and trigger a
> security exception.
> 
> This has only been tested with `xtest` on PX30, RK3399 and RK3588
> platforms, all tests pass. Note that this is unsecure by default as it's
> using the default development key in OP-TEE OS tree which isn't secret
> at all. I have not looked into how to provide your own key pair.
> 
> Note that xtest has two fails on RK3588 with OP-TEE OS v4.7.0. They are
> fixed since v4.8.0 (v4.9.0 series for meta-arm has been posted
> already[1]).
> 
> We also pass a few variables to make such that we avoid panics when an
> FDT is passed by TF-A (happens when SPL_ATF_NO_PLATFORM_PARAM is not
> set) due to the memory area to store the FDT being too small, also avoid
> panics when the device is using a different console than the default in
> OP-TEE OS by simply disabling the early console (thus relying on FDT to
> find which one to write to) and enable Arm Cryptographic Extensions on
> PX30 for faster crypto (xtest in 3m11s vs 3min32s).
> 
> [1] https://lore.kernel.org/yocto-meta-arm/20260121140356.16818-1-hugues.kambampiana@arm.com/
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  README                                             | 42 ++++++++++++++++++++++
>  conf/machine/include/px30.inc                      |  7 ++++
>  conf/machine/include/rk3399.inc                    |  7 ++++
>  conf/machine/include/rk3588s.inc                   |  7 ++++
>  recipes-bsp/u-boot/u-boot-rockchip.inc             |  6 ++++
>  .../optee/optee-os-tadevkit_%.bbappend             |  3 ++
>  recipes-security/optee/optee-os_%.bbappend         | 19 ++++++++++
>  recipes-security/optee/optee-test_%.bbappend       |  3 ++
>  8 files changed, 94 insertions(+)
> 
> diff --git a/README b/README
> index c2697d1..f49fdb5 100644
> --- a/README
> +++ b/README
> @@ -222,6 +222,48 @@ Notes:
>  	NOTE: this variable must be set before any include/require in the
>  	      machine configuration file
>  
> +  OP-TEE
> +
> +	PX30, RK3399 and RK3588 are all supported by upstream OP-TEE OS. By
> +	default, OP-TEE OS is not baked into U-Boot.
> +
> +	You can bake OP-TEE OS in U-Boot by setting:
> +
> +		RK_UBOOT_TEE = "1"

Is it worth pointing out this is a boolean so any of
"1"/"y"/"yes"/"true" or "0"/"n"/"no"/"false" will work?

> +
> +	in a configuration file.
> +
> +	Your U-Boot defconfig must enable CONFIG_OPTEE_LIB otherwise random
> +	crashes in Linux will occur. It is force-enabled since v2026.01 so you
> +	may omit this if running that or a more recent version.
> +
> +	Note that this has only been tested with upstream OP-TEE OS and upstream
> +	TF-A. Please consider disabling CONFIG_SPL_ATF_NO_PLATFORM_PARAM in your
> +	U-Boot's defconfig such that both upstream TF-A and OP-TEE OS are passed
> +	the FDT (useful for debugging since it specifies the serial console).
> +
> +	Note that this is only adding OP-TEE OS to the U-Boot proper
> +	(u-boot.itb) binary. It is *NOT* secure by default as it'll use
> +	development keys contained in-tree, see
> +	https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html#trusted-application-private-public-keypair.
> +	How to properly specify the private/public key pair is left to the user
> +	for now.
> +
> +	By default, early console is disabled because a misconfiguration of the
> +	serial console will silently crash your device. You may enable it again
> +	by setting:
> +
> +		OPTEE_OS_EARLY_CONSOLE = "y"
> +
> +	This only controls early console, before OP-TEE OS finds the FDT and
> +	parse it to know which UART controller to use.
> +	If you are not using the default serial controller (UART2), you must
> +	change CFG_EARLY_CONSOLE_BASE to the appropriate UART controller base
> +	address. You may have to set CFG_EARLY_CONSOLE_SIZE if it isn't set by
> +	default.
> +	CFG_EARLY_CONSOLE_* variables must be passed directly via EXTRA_OEMAKE
> +	BitBake variable.
> +
>  U-Boot Environment:
>  ------------------
>  	In order to configure U-Boot to be able to store its environment into the
> diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
> index 1997f6f..689a745 100644
> --- a/conf/machine/include/px30.inc
> +++ b/conf/machine/include/px30.inc
> @@ -14,6 +14,13 @@ KBUILD_DEFCONFIG ?= "defconfig"
>  
>  TFA_PLATFORM = "px30"
>  TFA_BUILD_TARGET = "bl31"
> +# Allow TF-A to load OP-TEE OS
> +# If no OP-TEE OS, it'll simply print
> +#  ERROR:   Error initializing runtime service opteed_fast
> +# and the boot process will continue.
> +TFA_SPD ?= "opteed"
> +
> +OPTEEMACHINE = "rockchip-px30"
>  
>  UBOOT_SUFFIX ?= "itb"
>  UBOOT_ENTRYPOINT ?= "0x06000000"
> diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
> index 166db7b..93594bc 100644
> --- a/conf/machine/include/rk3399.inc
> +++ b/conf/machine/include/rk3399.inc
> @@ -14,6 +14,13 @@ KBUILD_DEFCONFIG ?= "defconfig"
>  
>  TFA_PLATFORM = "rk3399"
>  TFA_BUILD_TARGET = "bl31"
> +# Allow TF-A to load OP-TEE OS
> +# If no OP-TEE OS, it'll simply print
> +#  ERROR:   Error initializing runtime service opteed_fast
> +# and the boot process will continue.
> +TFA_SPD ?= "opteed"
> +
> +OPTEEMACHINE = "rockchip-rk3399"
>  
>  UBOOT_SUFFIX ?= "itb"
>  UBOOT_ENTRYPOINT ?= "0x06000000"
> diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
> index 18c2fb2..ab16e1a 100644
> --- a/conf/machine/include/rk3588s.inc
> +++ b/conf/machine/include/rk3588s.inc
> @@ -18,5 +18,12 @@ UBOOT_ENTRYPOINT ?= "0x06000000"
>  
>  TFA_PLATFORM = "rk3588"
>  TFA_BUILD_TARGET = "bl31"
> +# Allow TF-A to load OP-TEE OS
> +# If no OP-TEE OS, it'll simply print
> +#  ERROR:   Error initializing runtime service opteed_fast
> +# and the boot process will continue.
> +TFA_SPD ?= "opteed"
> +
> +OPTEEMACHINE = "rockchip-rk3588"
>  
>  ENABLE_STATELESS_VPU_GST ?= "1"
> diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc b/recipes-bsp/u-boot/u-boot-rockchip.inc
> index 2b5bbd7..19f7c8a 100644
> --- a/recipes-bsp/u-boot/u-boot-rockchip.inc
> +++ b/recipes-bsp/u-boot/u-boot-rockchip.inc
> @@ -7,6 +7,12 @@ TFA_DEPENDS ??= ""
>  TFA_DEPENDS:rockchip:aarch64 = " trusted-firmware-a:do_deploy"
>  do_compile[depends] .= "${TFA_DEPENDS}"
>  
> +EXTRA_OEMAKE:append:rockchip = "${@' TEE=${DEPLOY_DIR_IMAGE}/optee/tee.bin' if bb.utils.to_boolean(d.getVar('RK_UBOOT_TEE'), False) else ''}"
> +
> +TEE_DEPENDS ??= ""
> +TEE_DEPENDS:rockchip = "${@' optee-os:do_deploy' if bb.utils.to_boolean(d.getVar('RK_UBOOT_TEE'), False) else ''}"
> +do_compile[depends] .= "${TEE_DEPENDS}"
> +
>  # No open-source TPL (yet)
>  ROCKCHIP_TPL:closed-tpl = "${DEPLOY_DIR_IMAGE}/ddr-${SOC_FAMILY}.bin"
>  # SOC_FAMILY for RK3588S is rk3588s but it should use the binaries from rk3588
> diff --git a/recipes-security/optee/optee-os-tadevkit_%.bbappend b/recipes-security/optee/optee-os-tadevkit_%.bbappend
> new file mode 100644
> index 0000000..e4fc87b
> --- /dev/null
> +++ b/recipes-security/optee/optee-os-tadevkit_%.bbappend
> @@ -0,0 +1,3 @@
> +COMPATIBLE_MACHINE:px30 = "px30"
> +COMPATIBLE_MACHINE:rk3399 = "rk3399"
> +COMPATIBLE_MACHINE:rk3588s = "rk3588s"
> diff --git a/recipes-security/optee/optee-os_%.bbappend b/recipes-security/optee/optee-os_%.bbappend
> new file mode 100644
> index 0000000..2a5ec8b
> --- /dev/null
> +++ b/recipes-security/optee/optee-os_%.bbappend
> @@ -0,0 +1,19 @@
> +# Increase size for FDT in OP-TEE OS to the one in TF-A since v2.13 to avoid
> +# panics on 64+KiB FDT passed by U-Boot to TF-A to OP-TEE OS.
> +# Can be removed once https://github.com/OP-TEE/optee_os/pull/7687 is merged.
> +EXTRA_OEMAKE:append:rockchip:aarch64 = " CFG_DTB_MAX_SIZE=0x60000"
> +
> +# Disable early console by default to avoid OP-TEE OS panicking on boards with
> +# their UART console different from OP-TEE OS default (UART2 for rk322x, rk3399
> +# and rk3588(s)).
> +# In-tree default changes if https://github.com/OP-TEE/optee_os/pull/7688 merged
> +OPTEE_OS_EARLY_CONSOLE ?= "n"
> +EXTRA_OEMAKE:append:rockchip = " CFG_EARLY_CONSOLE=${OPTEE_OS_EARLY_CONSOLE}"
> +
> +# Enable hardware acceleration using Arm Cryptography Extensions on PX30.
> +# Can be removed once https://github.com/OP-TEE/optee_os/pull/7689 is merged.

Have these 3 merges occurred yet?

> +EXTRA_OEMAKE:append:px30 = " CFG_CRYPTO_WITH_CE=y"
> +
> +COMPATIBLE_MACHINE:px30 = "px30"
> +COMPATIBLE_MACHINE:rk3399 = "rk3399"
> +COMPATIBLE_MACHINE:rk3588s = "rk3588s"
> diff --git a/recipes-security/optee/optee-test_%.bbappend b/recipes-security/optee/optee-test_%.bbappend
> new file mode 100644
> index 0000000..e4fc87b
> --- /dev/null
> +++ b/recipes-security/optee/optee-test_%.bbappend
> @@ -0,0 +1,3 @@
> +COMPATIBLE_MACHINE:px30 = "px30"
> +COMPATIBLE_MACHINE:rk3399 = "rk3399"
> +COMPATIBLE_MACHINE:rk3588s = "rk3588s"
> 
> -- 
> 2.52.0
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3085): https://lists.yoctoproject.org/g/yocto-patches/message/3085
> Mute This Topic: https://lists.yoctoproject.org/mt/117469183/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

