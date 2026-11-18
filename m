Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11152.1795003877771394649
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Nov 2026 04:11:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=iKHRWrp3;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55d30c054dfso9698711cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 04:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795003877; x=1795608677; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T4H8WmHHjCTAalaVUkla0KC6M9daKk/aySWai9+8I/0=;
        b=iKHRWrp3JltXSzTSnXmkPMaZAwN4iNtAYchg+k2bnwCiAoC8Funh6rzRKaTD7d3K7Y
         9ZvvYpNZ0ksBj+ldo4VZYzrg/6Xh0JSscqpy8Ienp9tg31UhpWEO+7YVVjPjPBXhZqQH
         RcPq2X7y/M8sUoP3WrgJmI5Zx7yoaJq9kLyqItPWKt2LvGCsSJwe8VJUEHprC0VP07fq
         tNE8JmvH/YmN4/WqkBD3kktsJhonGBK7cE92LPwkefKIZRSCbfL9PHMA5HgFkS1xyBQw
         Y48LKd9Oq33uE0A85EgmjMeslFBp8zVxqERNIa2autJEGeYYwaW+SSA3xoGVU3gzSlkG
         mzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003877; x=1795608677;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T4H8WmHHjCTAalaVUkla0KC6M9daKk/aySWai9+8I/0=;
        b=wnD3LkTVBKSqIPU5CZGoA6K9H8yaK5S+wjVuABfMsd2/2ijYC3pL7xWsnatj6z7wKG
         gGh6Qefg0aqJ0DRNFW7XJfEAMEmo/rvaz/NbcNc7JeI9/Hwu+AJzzG7AMU3P9rOZ6Ya5
         icJcmomXCRmOZGd1QkeN2BqH9TvHY7y0fPyb9iMm2IH7kTKW38fEK+Eve09IV3Vjnssw
         yh8+pCX+3z9n8lizdYy04bjVmLhqxS0qPqdBVoKGDxDHb/AtbCtqTZfmK2sHVoiC/dnw
         VZZc2UvAbvREbSldIWaut4lmKcUyb7fmW9PwghqOOmug8MKcEaSW1UwHPOz+RIvUySMI
         9+jQ==
X-Gm-Message-State: APuU4Z9TAE7xgZfIWwxDRFDB76HME02lpOe60tt3KFlAjmDomErqLFYd
	TAsampq26fwJes13UbRYmSKPs124g0zxb0gpnnjPRbHdex5CV09ZBtNi
X-Gm-Gg: AYBFou0voXzuXK9tUXiVVguU+XCw4cYtSo6bBI9P4gUh4yJ/ap++B+mg3YNoYgj1Wbq
	LOCXKcaBMtPvO0KJsb//fhCHATh9UnVTs6yQRpM9wU8WXPBcqpnxaqT5z5AP6kEAPYXo2XnK7eD
	OvwlMKOzvMJZOdahJKaJUij6QmK93k2ZM6pveH8Ho/xjKhkFcPZVqwQ3RQc0/bmEKfW7bONPbIt
	XoXd1VJGeFl3uP/35v097s6lXS08QgjQ1cD+GO1LddSXOADDo19F1Sz4YKLuH7mzKDyuSMFRYt/
	Pc232e3fHCqaiSY98HD08xooNA8Pp3CTU3vqXP/cNP/OYE/TjFj2xxqcy/E2cNR7jSlntB35yF0
	zvIEWv9KckITi77EQgVkhBJ2zyODneq19yYTl9FCnuIheANakHN2QSssAkX0V5/yx3M4qDMS+l9
	gyLtXZ5f56RHrFDhoBX+cBM58em5pTutHJ45d/E1MVOM2QVHLMzq/reprN04ErQt7+g0dQSHheJ
	rSTOP6EJQIq8BQ7lbmR3+F+mitV+oZ/OhOTbuyCH+3yO/lyhq0UOKCYM++8rvZhNYY2kc77CjwU
	gIwWd0dv7GZF8FssQmBJudaJ5Ep+2SWPUs9Y/QfNSk+OOLUrj+87les4PaM92S2rpTW3KjxtXx0
	pVxV7mwlMq8/KUHqdkKZS50ltKxXP9VI=
X-Received: by 2002:ac8:6f0c:0:b0:536:719d:7974 with SMTP id d75a77b69052e-55d5a6dfce8mr33632091cf.55.1795003876424;
        Wed, 18 Nov 2026 04:11:16 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58ff0065sm21201081cf.5.2026.11.18.04.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:11:15 -0800 (PST)
Date: Wed, 18 Nov 2026 07:11:13 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH v2] kernel: restore options the 32-bit
 arch removal drops
Message-ID: <av2V4TqDeMg67bZV@localhost.localdomain>
References: <20261104130230.236614-1-andrea.ricchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104130230.236614-1-andrea.ricchi@amarulasolutions.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 12:11:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5469

On Wed 2026-11-04 @ 02:02:29 PM, Andrea Ricchi wrote:
> multi_v7_defconfig does not list several options the Rockchip boards
> rely on; it gets them through "select" from platforms that
> remove-non-rockchip-arch-arm.cfg switches off (ARCH_OMAP2PLUS,
> ARCH_VEXPRESS, ARCH_VIRT, ARCH_U8500, ...). Removing those platforms
> therefore also removes:
> 
>   REGULATOR_FIXED_VOLTAGE   parent supply of the PMIC regulators
>   VFP, VFPv3, NEON, KERNEL_MODE_NEON
>   ARM_PSCI                  HAVE_ARM_SMCCC_DISCOVERY, which
>                             ROCKCHIP_PM_DOMAINS depends on
>   ROCKCHIP_PM_DOMAINS
>   HIGHMEM
>   REALTEK_PHY
>   USB_EHCI_HCD_PLATFORM, USB_OHCI_HCD_PLATFORM
> 
> On tinker-board-s with linux-yocto 6.18 the kernel stops at "Waiting
> for root device": the RK808 regulators have no parent supply, so the
> SD host never gets vmmc. With the root mounted, every hard-float
> binary would fail and the VOPs would never probe for lack of power
> domains.
> 
> Add the options back in a fragment pulled in by the same scc, so the
> removal no longer takes them along. Found by diffing the expanded
> multi_v7_defconfig against the built .config.
> 
> Signed-off-by: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
> ---
> v2: add the layer tag to the subject, the patch itself is unchanged.
> 
>  .../rockchip/remove-non-rockchip-arch-arm.scc |  1 +
>  .../rockchip/restore-arm-selected-options.cfg | 26 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg

Added to meta-rockchip, master branch. Thanks!

The kernel config mechanism has a funny way of working.

ARCH_ROCKCHIP, and several others, do not select VFP, NEON, and
REGULATOR_FIXED_VOLTAGE, even though they rely on these settings.
ARCH_OMAP2PLUS_TYPICAL does, and turning off ARCH_OMAP2PLUS takes it,
and those settings, with it.

But there are more. The same removal also drops eight CPU errata
workarounds, six of which apply to cores this layer ships: five
Cortex-A9 ones for rk3066 and rk3188, and ARM_ERRATA_814220 for the
Cortex-A7 parts. I recently sent this second patch to the list for
review. Both are needed; the errata patch applies on top of this one,
and will be applied at the same time.

> diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
> index ce77704..da5c12e 100644
> --- a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
> +++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.scc
> @@ -1 +1,2 @@
>  kconf hardware remove-non-rockchip-arch-arm.cfg
> +kconf hardware restore-arm-selected-options.cfg
> diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg
> new file mode 100644
> index 0000000..ababaf6
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg
> @@ -0,0 +1,26 @@
> +# multi_v7_defconfig does not list these options; it gets them through
> +# "select" from platforms that remove-non-rockchip-arch-arm.cfg switches
> +# off (ARCH_OMAP2PLUS, ARCH_VEXPRESS, ARCH_VIRT, ARCH_U8500, ...). Set them
> +# explicitly so removing those platforms does not remove them too.
> +
> +# regulator-fixed: parent supply of the PMIC regulators on most boards
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +
> +# hard-float userspace
> +CONFIG_VFP=y
> +CONFIG_VFPv3=y
> +CONFIG_NEON=y
> +CONFIG_KERNEL_MODE_NEON=y
> +
> +# ROCKCHIP_PM_DOMAINS depends on HAVE_ARM_SMCCC_DISCOVERY, provided by
> +# ARM_PSCI; without the power domains the VOPs, HDMI and IOMMUs never probe
> +CONFIG_ARM_PSCI=y
> +CONFIG_ROCKCHIP_PM_DOMAINS=y
> +
> +# boards with more than 768 MB
> +CONFIG_HIGHMEM=y
> +
> +# Realtek PHYs on most boards, generic-ehci/generic-ohci in rk3288.dtsi
> +CONFIG_REALTEK_PHY=y
> +CONFIG_USB_EHCI_HCD_PLATFORM=y
> +CONFIG_USB_OHCI_HCD_PLATFORM=y
> -- 
> 2.53.0
> 
