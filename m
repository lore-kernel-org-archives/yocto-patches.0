Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1839.1794933241026191301
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Nov 2026 08:34:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=XysvfMeh;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f2049ea7aso2196885a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Nov 2026 08:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794933240; x=1795538040; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oac06sbkuhs1zy4x9UWgZALOWB6H+515G6NCRBz4bTo=;
        b=XysvfMehNJF75IYP50a6G+C1s4VXMBbCaDvTE0p/6lQbmNm4U6DPGjn0QRkBo44wQr
         6WnaMx5D0TVKtxb0HB225Z2XdNjB77NuvF43j1UB63UQ2bvDi34nfDqI5z1+hCOZsZAF
         EuqdbpsZHQU1IU2jMCsea3Zvye1I+5qEe22g5WtECFbZ5tFmUcr1pNVLPOl0q2tB+dwO
         R4VSU773qr0TD3q8K1SH4QKGPVEPJ1NiRtzq1GRWcBL4BfuzdGh5H1vn46TbqwHSEZdO
         tZNC2g1JP+pRAgTTkhpUagRdPmpwSWSLxmwJUA6SkHwXdOKS/ksC9CUGe2MLbBOUrNE0
         BP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933240; x=1795538040;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oac06sbkuhs1zy4x9UWgZALOWB6H+515G6NCRBz4bTo=;
        b=M4x0NxQP39kkfWZYf+yjyEW8g7YsnzHAnWCefBKJCId9HZLWNo0LxQs2XhgQZmokEE
         525VmQbOp8j5DmTMNaJ3E+nMTJTl21OUrStz5qx5JHDP+qMQ+MYuYlx/uEOUfw6USbKx
         KVnRBoS6yOeGJiouizZHa2t+gSpzbE11kvHFB3BHcvDvd2cJ6IDkj5Np3u3RoQpb0YsY
         a0nidJ7gFfXi/Ji/5TRtFdgw1TmkMa3xonRSzxbjdzH0wdNgTV0nNHRYaO0+mzmde+f1
         0s2czKvEJde+GvhrCM4Y+8nkwWl9nPSySLnS+C8ttoEW/XahYrPZ7qqRq0YN7tY11Kfn
         iIaQ==
X-Gm-Message-State: APuU4Z85BqU54KJljs6VGvG5EKPQqW+I1BX7h3vvvieR0wtHJNv/ynEc
	j3x8LE/jEThzYXnKRYM+BfFMMwJ0f5NjdfILkVoSXJYynUK0MPHntK1AjMrHjg==
X-Gm-Gg: AYBFou2T+UVLKXoIjesDESoGoaD52IijNDAL80TAd6P2qUvDsH3v5amLNiUVqDIeMD8
	W5NWWPUY0RgJLdQ4z8HhKvflB4g2/Z+em6hg33AmNCO+AsWIE8HVTVn59bvJZ8clrBYScaS7Y8+
	1hRtZgMXnxcrvQPLCkjMud0Uk239EbWVa5eHSsRz5V9q1nozgW3A5gkl6PqayBQfGIHoXpHxA5O
	ZcdvaSwUTjoomvCsS6A328o9JpBe3nl6JfnwFhb0ad1+lM7G6dXsn40r1Z1DmolTUarbWZ5W8va
	XxUtqLMlDSqRKmdEAE6F5+L13MW3/i2Q4UvPiM9FMeYfOvCIkHqSstghatSDUBYvEPyTGqPZnxV
	WEcHqXTWCD0jKUWDcLrbNbAxI+6OAJFZfw2Y4MMFS+A6g0jacMaFPhSzp99U4q+bHWFGyWCflv0
	tNE/c8TwRIOVY96oYBhs8NvBF7Vaw4OxDR7C1czeOJr/c3jxqVAmFvS3YGQO2QDD4GFx1rGGlK8
	++VLV6sWpOt4VUpye19IDh0e9EzAjO5788iZ3bsQDUwicvIWsR+Xj2GiEIO1AqCwOlHHTFUKdZG
	O0xDcwxb6/koKRa4hvQdVzrU9II6cXU62LGFRjc4l2XUffUd/ZhGjMi6VKEmiY20cGPIkoeOXpL
	g3EkGvu5iK8cFip1jdOxpb9CINdUzdJs=
X-Received: by 2002:a05:620a:1d09:b0:949:7311:a698 with SMTP id af79cd13be357-94999558378mr34305685a.8.1794933239744;
        Tue, 17 Nov 2026 08:33:59 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8b889csm1135903285a.32.2026.11.17.08.33.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:33:58 -0800 (PST)
Date: Tue, 17 Nov 2026 11:33:57 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v1] kernel: refresh the
 non-rockchip architecture removal fragments
Message-ID: <avyB9bhjKwKihsT7@localhost.localdomain>
References: <18E4822F9934F85F.190157@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18E4822F9934F85F.190157@lists.yoctoproject.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Nov 2026 16:34:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5462

On Tue 2026-11-03 @ 05:27:59 AM, Trevor Woerner via yocto-patches wrote:
> Several Arm platforms have been added upstream since these lists were
> written, so a kernel built from an in-tree defconfig was again carrying
> support for machines this layer does not target. On arm64 the
> defconfig re-enabled Aspeed, Black Sesame and Microchip; on arm the
> TI SoC driver menu came back.
> 
> Add the platform symbols arm64 has gained, along with the Renesas and
> Tegra per-SoC options that arrived with them, and the TI menu on arm.
> Nothing has been removed: every symbol these fragments already carry
> still exists in the kernel.
> 
> AI-Generated: codex/claude-opus 5 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  .../rockchip/remove-non-rockchip-arch-arm.cfg |  1 +
>  .../remove-non-rockchip-arch-arm64.cfg        | 20 +++++++++++++++++++
>  2 files changed, 21 insertions(+)

Applied to meta-rockchip, master branch.

> 
> diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
> index fdd3e6964053..7651c5b05a76 100644
> --- a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
> +++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm.cfg
> @@ -48,6 +48,7 @@ CONFIG_SOC_OMAP5=n
>  CONFIG_SOC_AM33XX=n
>  CONFIG_SOC_AM43XX=n
>  CONFIG_SOC_DRA7XX=n
> +CONFIG_SOC_TI=n
>  CONFIG_ARCH_QCOM=n
>  CONFIG_ARCH_R7S72100=n
>  CONFIG_ARCH_R7S9210=n
> diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
> index 12fde404d64a..09fb5810c1cf 100644
> --- a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
> +++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/remove-non-rockchip-arch-arm64.cfg
> @@ -2,14 +2,18 @@ CONFIG_ARCH_ACTIONS=n
>  CONFIG_ARCH_AIROHA=n
>  CONFIG_ARCH_ALPINE=n
>  CONFIG_ARCH_APPLE=n
> +CONFIG_ARCH_ARTPEC=n
> +CONFIG_ARCH_ASPEED=n
>  CONFIG_ARCH_AXIADO=n
>  CONFIG_ARCH_BCM2835=n
>  CONFIG_ARCH_BCM=n
>  CONFIG_ARCH_BCMBCA=n
>  CONFIG_ARCH_BCM_IPROC=n
>  CONFIG_ARCH_BERLIN=n
> +CONFIG_ARCH_BITMAIN=n
>  CONFIG_ARCH_BLAIZE=n
>  CONFIG_ARCH_BRCMSTB=n
> +CONFIG_ARCH_BST=n
>  CONFIG_ARCH_CIX=n
>  CONFIG_ARCH_EXYNOS=n
>  CONFIG_ARCH_SPARX5=n
> @@ -17,15 +21,19 @@ CONFIG_ARCH_HISI=n
>  CONFIG_ARCH_INTEL_SOCFPGA=n
>  CONFIG_ARCH_K3=n
>  CONFIG_ARCH_KEEMBAY=n
> +CONFIG_ARCH_LAN969X=n
>  CONFIG_ARCH_LAYERSCAPE=n
>  CONFIG_ARCH_LG1K=n
>  CONFIG_ARCH_MEDIATEK=n
>  CONFIG_ARCH_MESON=n
> +CONFIG_ARCH_MICROCHIP=n
> +CONFIG_ARCH_MMP=n
>  CONFIG_ARCH_MVEBU=n
>  CONFIG_ARCH_MXC=n
>  CONFIG_ARCH_NPCM=n
>  CONFIG_ARCH_NXP=n
>  CONFIG_ARCH_MA35=n
> +CONFIG_ARCH_PENSANDO=n
>  CONFIG_ARCH_QCOM=n
>  CONFIG_ARCH_REALTEK=n
>  CONFIG_ARCH_R8A774A1=n
> @@ -43,10 +51,19 @@ CONFIG_ARCH_R8A77995=n
>  CONFIG_ARCH_R8A779A0=n
>  CONFIG_ARCH_R8A779F0=n
>  CONFIG_ARCH_R8A779G0=n
> +CONFIG_ARCH_R8A779H0=n
> +CONFIG_ARCH_R8A78000=n
>  CONFIG_ARCH_R9A07G043=n
>  CONFIG_ARCH_R9A07G044=n
>  CONFIG_ARCH_R9A07G054=n
> +CONFIG_ARCH_R9A08G045=n
> +CONFIG_ARCH_R9A08G046=n
>  CONFIG_ARCH_R9A09G011=n
> +CONFIG_ARCH_R9A09G047=n
> +CONFIG_ARCH_R9A09G056=n
> +CONFIG_ARCH_R9A09G057=n
> +CONFIG_ARCH_R9A09G077=n
> +CONFIG_ARCH_R9A09G087=n
>  CONFIG_ARCH_RENESAS=n
>  CONFIG_ARCH_S32=n
>  CONFIG_ARCH_SEATTLE=n
> @@ -61,6 +78,9 @@ CONFIG_ARCH_TEGRA_186_SOC=n
>  CONFIG_ARCH_TEGRA_194_SOC=n
>  CONFIG_ARCH_TEGRA_210_SOC=n
>  CONFIG_ARCH_TEGRA_234_SOC=n
> +CONFIG_ARCH_TEGRA_238_SOC=n
> +CONFIG_ARCH_TEGRA_241_SOC=n
> +CONFIG_ARCH_TEGRA_264_SOC=n
>  CONFIG_ARCH_TESLA_FSD=n
>  CONFIG_ARCH_THUNDER2=n
>  CONFIG_ARCH_THUNDER=n
> -- 
> 2.50.0.173.g8b6f19ccfc3a
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5217): https://lists.yoctoproject.org/g/yocto-patches/message/5217
> Mute This Topic: https://lists.yoctoproject.org/mt/122073724/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 
