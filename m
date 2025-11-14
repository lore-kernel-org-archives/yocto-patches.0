Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B208CE8D4A
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 15:49:55 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1404.1763135386360685067
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 07:49:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dQv+ruqm;
 spf=pass (domain: gmail.com, ip: 209.85.214.172, mailfrom: twoerner@gmail.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2956d816c10so23024965ad.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763135386; x=1763740186; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V6i19IatvPEmFKt+bcrK5TIoSGTQ8kbI3xg6eaZkJ0=;
        b=dQv+ruqmwJhtBES4JwVlRaOQhvHa6BKQTejQM3ouO90iXxnYEuJHmjSQPpTA9s+R0X
         S87IzSk6/84nuqLZIDUXAvZCtYnAcB2ySZ8A1AuG0PrLw/I2KbQjZEWgyvamI8QHFCx9
         Ux9RWNU2M2g9mPCFnou8nhHDVc7/4UZ4+E71Sb9T2cmkWma0glzARE/RwYAuVGhUmSve
         P95M0MTKiccSBe4mjVqvmu0bY1rsER4tta6zXgyDl8T1n+V64d6We17MELCVabbKgKyw
         YniAXZ9dx4AY/x5wZ/JE8ETMtOHT1nZ820yVxiVBn4qPFjF+9Mgak2qKeNeDZuYWtws0
         X78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135386; x=1763740186;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6V6i19IatvPEmFKt+bcrK5TIoSGTQ8kbI3xg6eaZkJ0=;
        b=RL32Ladt+xY7Q76uLZ/yUq7aOyUcxA6gmCJtav9aKMAOu6oEo6FFs9NXtKIn2LzZ0M
         Ec11zBpHQm4f6CmDGYONw0/GugkHcaYhbWMzpISFc+c/nXEDmdPEcY92wUovW9hkNfhm
         UTBYoUJc6pYxXf9I6SLB+BNHI+jFp1IMFzZFGoNvLzPCkQUkFSwGP9SSwIC9nna4wIW1
         el8/sdkF6w/52KBQD89YSMU5FH1D90etpxjmtuqygCbrBYPn6khtenP75IR4qBgfxyw5
         PSJcJztxvhRBTTOQzx+KsU+ANDg9ZDupAFfGF20SxPhbH8FaexmroHZq/iXqKwTRhSLN
         ahbA==
X-Gm-Message-State: AOJu0YzF9y23RhCPiOdCTyX1+FV+H0bUNRsv83K+7ZC7cRmgMrPPOSNW
	yHGM8qRlr54TkIyxrtZeGxLqXKCuU63EfrgZlCAeRwLTjd+fFSWryi6vrp/s5w==
X-Gm-Gg: ASbGncsQxrElVWBbmX4hxj+yPk8K8WxND4mu6PVcZ3g2Bk1zCY3z7bNDm6OeyryFxvl
	Am4kZtpaYvYw5sEDsICFm06PDAVIa3ilqBFmOhNTxotBcAdWWN9gb/qQQ0Ww7nunYVfUo7Hceyx
	nqiMTzpm6oKhlEXoP1xRdNoVclcFjwyvpWY/q477gN8W+zM3mp8mY9Z64m7MOZ6CEyLoo9D78z9
	+McaSuFLh6KTbEkRWHDBTq8GgpYZ9cw7dRAz02kfk3g2+i90WnKKFzSG5FN5BLZpK1sAIQ1R5Ro
	RNyGQsPwgYz5mazZtl8Wjxuu8yiQNd2QKNczeNgHVKdaYuWwnIuyLuz3+GB6hqIeHkJAJ1qXUux
	yQa2juZLcIDuteSVGSYkn8MLmzo8xtUu/VlPheON1WbbVWSHyj6geKtWigBHUQK0gHsIZWLxJxj
	KD1fTrYQhc5U2kS9c5syXXnVXJGo8=
X-Google-Smtp-Source: AGHT+IF4QUkX+KfzG0WzQ7pjnQRVUErzqZfoI3QnocjUS76UNmHFm1lp2hG8QqSUkrX1apTard4Mdg==
X-Received: by 2002:a05:620a:28cd:b0:8a2:bff5:40d9 with SMTP id af79cd13be357-8b2c3144e55mr401892985a.16.1763131991007;
        Fri, 14 Nov 2025 06:53:11 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aef2f9f4sm346365985a.27.2025.11.14.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 06:53:10 -0800 (PST)
Date: Fri, 14 Nov 2025 09:53:08 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Peter Shkenev <mustela@erminea.space>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip] [PATCH v3] rk3288: use u-boot.img as bootloader
 image
Message-ID: <20251114145308.GA22027@localhost>
References: <20251108225641.171832-1-mustela@erminea.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251108225641.171832-1-mustela@erminea.space>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 15:49:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2569

My build testing shows that this patch fails for the rock2-square
MACHINE. Are others seeing this as well? In the v1 patch Quentin noticed
this and mentioned building for all rk3288 devices, was this tested?

On Sun 2025-11-09 @ 01:56:41 AM, Peter Shkenev wrote:
> Currently, u-boot.bin is used for supported rk3288-based boards. But on
> some boards, such as tinker-board, it can not be loaded, since
> u-boot.bin is raw and those boards have raw image support
> (CONFIG_SPL_RAW_IMAGE_SUPPORT) disabled in favour of FIT images.
> 
> Use u-boot.img which is FIT when FIT support is enabled, and raw
> otherwise.
> 
> Also add a note that u-boot.itb should be used if one wantes to utilize
> OP-TEE.
> 
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Signed-off-by: Peter Shkenev <mustela@erminea.space>
> ---
>  conf/machine/include/rk3288.inc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
> index a648b44..00cc04b 100644
> --- a/conf/machine/include/rk3288.inc
> +++ b/conf/machine/include/rk3288.inc
> @@ -13,6 +13,7 @@ SERIAL_CONSOLES = "115200;ttyS2"
>  KBUILD_DEFCONFIG ?= "multi_v7_defconfig"
>  KERNEL_FEATURES:append:rk3288 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
>  
> -UBOOT_SUFFIX ?= "bin"
> +# Set UBOOT_SUFFIX to "itb" if you are going to use OP-TEE
> +UBOOT_SUFFIX ?= "img"
>  
>  ENABLE_STATELESS_VPU_GST ?= "1"
> -- 
> 2.51.1
> 

