Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21569.1793831053526227088
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 14:24:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=K0A8rH//;
 spf=pass (domain: gmail.com, ip: 209.85.221.180, mailfrom: twoerner@gmail.com)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ead4026fe6so456527e0c.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 14:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793831052; x=1794435852; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CSCDqca8OCv6saqwxifQaCmZK3nSvdaQ3kSOcyLO3h8=;
        b=K0A8rH//b/jOYV+bmpmZmvoL5n/HhF6qrQqvIh71gx7+X6pk4zlR4o8HsMOEjY5uEv
         3wmN1yZ5qrW9M8CdEspTvX1ySY4+SFWYVtJ9ZW7e9AHAT+a2H0p4we1vY8HgfE66iGpL
         HoGRZTML52TjUSqFtqC3ipY7yis2OFQngdNTI5ANPJjYWwtu6/Jm5Pd/DZmbybpfleKL
         gWzqqVWbrRyMF7fL0oL+8nuz/VJFrf+oMr7zjEgjXIzJQldTk2wY+XCt2Tu7jBo87Jou
         fSgvNO8u9EVT6FQ2nmNuubD7kVhRWZCnowPbtshz40RygcL+dttp3F2QfyfO9qUGHbHj
         gt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831052; x=1794435852;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSCDqca8OCv6saqwxifQaCmZK3nSvdaQ3kSOcyLO3h8=;
        b=R7sPNuO+BDUcZvnvic0xP13Qs2BbmDw2zL0IwIv3dKAtPn6sFXI7YdulCVqwaf8mhN
         0JSZXb0JjJGufqWCYpHwZLbu4iWRMBGZJWkZjPu1FnHKKru4kJJcZZfKt4qWMNQ3S9mo
         nTHG8lWqie8oWqQ1Ba4uaPUWeMzqvnx+PJCpaP9suX4mgJB/1uog1QUTmQhv7CGdIvSj
         bHqXvgrldLsKPIOuOtSNTFn35ttX8c0mrQGih0ihs9+GCS1cl4QyU6ixzy8B3Nl02Pzr
         XWMvWDUSbM6c2TI0/mZZ6KF/+XJNwH5I/abCqltS8Bk4jMul8BH8/m+CJuTh3pNlVvfz
         +Z5w==
X-Gm-Message-State: APuU4Z+eKZy7DmdO4vNS1dKSfUDXUzKljCO8nVgd4hggdZJYFPAaM1nr
	uVqMmhglPDk7Q2VTCHWIRsb0IMftMEp6AYMum5+HxIpYYegGHJC8DQHH
X-Gm-Gg: AYBFou0/3QAXYDRXCNzDgRLDA1aDSH4b4UaaozWaeKdmnpAaQmDdVaB65TY57lKHmdz
	0zEG6rWkur+6xbmlP0xWQaXBolXVIZdOfMgjw7s8MoeM1vCV/b7yoovGeeqQWBU4vYL7ZmKxAAb
	qKWipvJFJchEaRU91ypySVIHdbLtybEuOgLhKKhdpH6Op2oxQ0Rq72dAQNstlN7l/poru7F9scT
	keR9bsmXzk48ranMVT2DOpIKrUw5SGPxRueNUdZHNOVhvHSE9Wl34KtUKlIMXE/c+hbp/hauWL4
	l+4K/g9Q850QQ2mhnJN8BhdbwO2uerauV9yfeJprd4sm1vkTUdq/F4dGfX2D2R90IFtYsTzIZ5F
	lTXIaULIIjLr+0CZfPcdG+k/popYVMH3kHgQ2xRc8vfZaDgXHfD5ArTv1fy3gk4XGqaWnR1dNvT
	vECNNccjocbpxmzQGfNZBwQa6SHE4xIPleUNbNTqx93aC9Kct3hcJ5bz/fiA+n7T6hbnuvNP3E8
	ihOHM2OYMy/iFjFTnNxuVh8aQcyX89urTUdewEgZ2D86FjUgnhQhyokXoAE1xJdvKCvCtXUWT40
	5MIKB78maXLyrpxMEDsWfcL4ydPTGgbZWeRM95filGrwGXWSzbjiVIGGQFiGx1eepIRdH4PdnLR
	fHRNR16rK9efdIEbAMnlRmzmm+BHrhQ==
X-Received: by 2002:a05:6122:1795:b0:5e9:6d96:aa38 with SMTP id 71dfb90a1353d-5ec6883a598mr7596394e0c.9.1793831052303;
        Wed, 04 Nov 2026 14:24:12 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8dbb17bsm2741537e0c.11.2026.11.04.14.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:24:11 -0800 (PST)
Date: Wed, 4 Nov 2026 17:24:09 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH v2] kernel: restore options the 32-bit
 arch removal drops
Message-ID: <auuwicmJxjEY0QS7@localhost.localdomain>
References: <20261104130230.236614-1-andrea.ricchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104130230.236614-1-andrea.ricchi@amarulasolutions.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 22:24:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5237

Hi Andrea,

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

Out of curiosity, is this happening with or without the patch I recently
sent for review?

https://lists.yoctoproject.org/g/yocto-patches/topic/meta_rockchip_patch_v1/122073724

I don't expect the above patch to fix this if it was happening before,
but I'm curious if it only started after trying the above patch (if you
have tried both with and without it).

> Signed-off-by: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
> ---
> v2: add the layer tag to the subject, the patch itself is unchanged.

Thanks for adding the "meta-rockchip", that's how I filter (and notice)
them.

> 
>  .../rockchip/remove-non-rockchip-arch-arm.scc |  1 +
>  .../rockchip/restore-arm-selected-options.cfg | 26 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/restore-arm-selected-options.cfg
> 
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
