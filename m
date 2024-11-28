Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26926D6D250
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 00:55:34 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web10.85555.1732755332243974894
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 Nov 2024 16:55:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aa1bQ45x;
 spf=pass (domain: gmail.com, ip: 209.85.160.172, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46684744070so2304881cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 27 Nov 2024 16:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732755330; x=1733360130; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zw40lkw5ohyaSgDgpI8krORu5d0dlWBS+nvAHRrdBVs=;
        b=aa1bQ45xJn2U6uKxqmc4HQ/3uOpriWECUYmpdhCTuGzKUgnP094Mzif8apwTJPqZQl
         D4DdJdJhr33V3bFCnMEZS/Mp4uO/N6+AMqGbEPZbkc7NNdxyqXGtCpNo3Ws5lZHaFCBw
         eRaIBXyGBvbkEc0ljN3MxYT/+HPaydL0KK2b1IimbKMdHygqi0UwfOqTVVD4IOW6ZIdU
         9AaGI6wRpSnemknf1y9yQ1J6U4mMtm6hc4A+/JNRNkigX0n4m2ZhnJHljCw9Mrt4PQM0
         7O8VgiKKYohv9fqTcmiruN6RFjNgIt4UUk/wfp1jZXI3V3qBhwkVO9BHL4smpejUK74s
         Lw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755330; x=1733360130;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw40lkw5ohyaSgDgpI8krORu5d0dlWBS+nvAHRrdBVs=;
        b=t58uLQrQGxFCYHAFBH4RIRDQBEKWMI8WsiIFdlzwY/DI0EdyBiTz7/psfVa2R2Nfz2
         4lIwQUodA0joySYYwFZQdn30atrCIzfhKGqPcYk6LKYlC9+omHa/Qcyn+r/1m+krMmVJ
         DoxNk6Xs8tEw/dFbQ0KzFYbnodcy/6NmgOy7emFoHxCPWUYmDfvxd5LCDJpqIzO774hi
         f0AezMZJaz/AonhEkXH61pI2WcyI/dcdQ2SkARODW0TNpMesfZulsFkdFw+PMTcCkxz7
         peoCcWGJk2rMJxhOwz6x5ji73O5iLJ6FK43mWi4ygWG08Ksg+mzkvHIQXTk0kzhNRiYt
         Kacg==
X-Gm-Message-State: AOJu0Yy+JmK9t/cjl9SiEV/d4SEESe/N2Ib+rgsLcYiZVPOlzcRd3Hdf
	5voq8yG6MeVgTi744RMNkIY5eI05bdgzNdUECpJYO4ojZDBnanBA2BjUuPsX
X-Gm-Gg: ASbGncuc2P+Oa5KaWSCA2XG1zU6zI1gh/WgygVigb2+O1SkIwGY2qsH9/Z367FSDb6W
	f3+cmghtBp0tKlmBZIqIBb/gynfpGMP8mEfxAOzP5W+yTGlt3ZkTHzJdcYsWYi+7LJK/ARbZhAX
	GgcI5VNyFSDMIqPsSqg7mEumlFiaCYYVdIAisWFLdRMcVRv7M+q+fWx7riNUN5mxSDxwJQm3v5T
	6THXD6M55I0PUv5JT80/elvvzVuEJXQ2dxeN9AjU+lKJy+lgoO8plTEpSHjJavk4OAKBLWk82Vs
	sw==
X-Google-Smtp-Source: AGHT+IE5iYQJtXI1uh/iGqZ5NXoPdDGmpa2E8gKgW9Uy0zphXwk7j6ucawwW5ll4K1xlDBRQ50dRuQ==
X-Received: by 2002:a05:6214:21a9:b0:6cb:fa74:bafb with SMTP id 6a1803df08f44-6d864dccbb4mr56078446d6.31.1732755330453;
        Wed, 27 Nov 2024 16:55:30 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d87516342fsm1349376d6.26.2024.11.27.16.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 16:55:29 -0800 (PST)
Date: Wed, 27 Nov 2024 19:55:26 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH 1/2] bsp: rkbin: rkbin-ddr:
 use glob pattern for finding DDR init
Message-ID: <20241128005526.GA17984@localhost>
References: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
 <20241127-rkbin-bump-v1-1-b90b6c04a88f@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241127-rkbin-bump-v1-1-b90b6c04a88f@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Nov 2024 00:55:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/849

On Wed 2024-11-27 @ 04:12:58 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> To avoid both having to modify this file every time the
> rockchip-rbin.inc SRCREV is bumped and also having to override it were
> a user to have to mix and match versions for different products, let's
> just use a glob pattern.
> 
> Note that the glob pattern should only match one path, which is the case
> right now.

I'm not overly fond of the glob method. It was only back in June of this
year that I pushed a patch to move away from globs to using full filenames
explicitly. The savings seem pretty thin compared to the potential surprise
factor when, one day, multiple files might be selected.

Do you feel strongly about switching back to the glob?

> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> index 0ff71320de8cfeee259a820a07375f490d1086d6..a22c7e12c32b5e1988e8e6b870b94cf9438f23ae 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> +++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> @@ -9,15 +9,15 @@ do_deploy:rk3308() {
>  
>  do_deploy:rk3566() {
>  	# Prebuilt U-Boot TPL (DDR init)
> -	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3566.bin
> +	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v*.bin ${DEPLOYDIR}/ddr-rk3566.bin
>  }
>  
>  do_deploy:rk3568() {
>  	# Prebuilt U-Boot TPL (DDR init)
> -	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3568.bin
> +	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v*.bin ${DEPLOYDIR}/ddr-rk3568.bin
>  }
>  
>  do_deploy:rk3588s() {
>  	# Prebuilt U-Boot TPL (DDR init)
> -	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin ${DEPLOYDIR}/ddr-rk3588.bin
> +	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin ${DEPLOYDIR}/ddr-rk3588.bin
>  }
> 
> -- 
> 2.47.0
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#844): https://lists.yoctoproject.org/g/yocto-patches/message/844
> Mute This Topic: https://lists.yoctoproject.org/mt/109807515/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

