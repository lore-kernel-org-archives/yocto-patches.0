Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2A0C369AB
	for <webhook@archiver.kernel.org>; Tue, 15 Apr 2025 18:07:17 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web11.1108.1744740434407806246
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Apr 2025 11:07:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BbEfR9aC;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476b4c9faa2so72591911cf.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 15 Apr 2025 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740433; x=1745345233; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7HMb0TnAxrshBkqrZly2jGJgnJE4vwHhRCRKKJ3m1o=;
        b=BbEfR9aCFaY9u/n8/YAa45iMmgp6vDXyLNA1AfxAMa+Ypd7o0+qxSg1GQ2TWY7mt2/
         SNgEgkrexZspijEPxfr4z9t2ydcWohOOYDy2O9UimtuS+rPll0Ho9aAZGcRK03bOZz5G
         2f/Jpp8doIIIR+HN4dgp3tY+1nX1hzKiamVAKaV4SuKam67UTJBSxaMItnTccTOu/CUI
         AD1QcJGVSaN7ecH+fbvWyAHfGd7y8pTZta2wnj8RiZYcLDeQVMddBtm/RmocY1tqv7H3
         uV6F5tTJqNN2QyPLQT6fGeQIwYFeM0h2OLdtReIIZYeBFcNbs6ZbsBm+C3BD/KeaosAb
         Y3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740433; x=1745345233;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7HMb0TnAxrshBkqrZly2jGJgnJE4vwHhRCRKKJ3m1o=;
        b=A7077YCwdbPrDppAWxJFff2KqZHGLQhTnwV4lCFUWVjSqDSuWhJ6jVPVKxmVhBCsrc
         nNuV9C1ylJNGIwhgu+nLAZd1oDL5t+tlJGsCY86jZz75PBNFvjK08IZupn/kJVlaXj/x
         JivVak6l/+OVzjLrDC5QWV5J8szrRGtk//7H4IBpKPg9+dMYHg606i+NbQFxHEuS4r8d
         UgH7Cr0P1sSLHHKRwJnVoBxnLBQSHcp9TgAUZ2ShqkWr6Jo2V0JymMSrRDOxFgYKho+5
         J5owG52C0Neck50VS44gPp2EnlkpKP9gJnE2He0p/HZkjqyVcEpjsNFUtC7AASFu75vv
         CZXg==
X-Gm-Message-State: AOJu0YySQq8WipLyZYstd8mkeLrNUsPlZ1ZSTLZBmwR06IyC1TdcUElD
	3BKuj3cQA9tb936NZR2ffcI05z4vIW2R8BllH4VaTbzNCVWEfv8CPK6x+cte
X-Gm-Gg: ASbGnctLdZvMTwXKXlNxKmW9wf3dbmA4rRn33lViPO493RIHfyCQy8rcCfLy6tU7QAK
	FxMKmwxaHozgAWt1HIibbOXQA7ow2wbtOOQDY0DU9HLgjgEy6VsP+ymUgEKQrPqEatm2+VY4SV8
	ToiydFtZCgijf5jkJwEbllZqpvPnSLYc4JvD1LLSTFqFHPM2lFm2FAb6Y8xeBYGfQQyckAX+MqB
	AukPI6BWSK866thGh5hu+jyFKAhrWjMxzpJZy9bnG0YPwk2AjqqurpFtm0o38zrPJrnYUo1MmmJ
	iNLPU4dJCtzfUvrxfrqqWgG7nDDjD8eSFLo/Dix3tc8JqeEnMqizFqUTNDeIqk5j5hsb
X-Google-Smtp-Source: AGHT+IHU0oCezD3ahve75AxxGziu0ZhrMpQGvPAH64TlOycCqTKG78APMKGM2Zog9R8yTBN4/Tw3Wg==
X-Received: by 2002:a05:622a:346:b0:47a:cc04:aabc with SMTP id d75a77b69052e-47ad3a27022mr5131811cf.21.1744740432545;
        Tue, 15 Apr 2025 11:07:12 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796ed9cbddsm95550001cf.54.2025.04.15.11.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:07:11 -0700 (PDT)
Date: Tue, 15 Apr 2025 14:07:09 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH 5/6] bsp: rkbin: ddr:
 factor out do_deploy to be SoC-agnostic
Message-ID: <20250415180709.GA9633@localhost>
References: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
 <20250311-ddrbin-custom-v1-5-e5c994ac25e1@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311-ddrbin-custom-v1-5-e5c994ac25e1@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Apr 2025 18:07:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1371

On Tue 2025-03-11 @ 12:26:34 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The do_deploy task is essentially the same for all SoCs, install a file
> from a specific path to another one.
> 
> No magic involved, so let's rather have one generic do_deploy task. For
> this to work nicely, we check that all necessary variables are set and
> notify the developer otherwise. This may be useful whenever a new SoC
> will be supported by this recipe.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 33 +++++++++++++++--------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> index 193d0f00a6868f050a0ff4531278b3296d3eae94..17131b6d5a6b443409eacb5806e0613b292852d7 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> +++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> @@ -8,40 +8,41 @@ DDRBIN_FILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${DDRBIN_VERS}.bin"
>  DDRBIN_DEPLOY_FILENAME:rk3308 ?= "ddr-rk3308.bin"
>  DDRBIN_TOOL_SOC:rk3308 ?= "rk3308"
>  
> -do_deploy:rk3308() {
> -	# Prebuilt U-Boot TPL (DDR init)
> -	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
> -}
> -
>  DDRBIN_DIR:rk3566 ?= "bin/rk35/"
>  DDRBIN_VERS:rk3566 ?= "v1.23"
>  DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
>  DDRBIN_DEPLOY_FILENAME:rk3566 ?= "ddr-rk3566.bin"
>  DDRBIN_TOOL_SOC:rk3566 ?= "rk356x"
>  
> -do_deploy:rk3566() {
> -	# Prebuilt U-Boot TPL (DDR init)
> -	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
> -}
> -
>  DDRBIN_DIR:rk3568 ?= "bin/rk35/"
>  DDRBIN_VERS:rk3568 ?= "v1.23"
>  DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
>  DDRBIN_DEPLOY_FILENAME:rk3568 ?= "ddr-rk3568.bin"
>  DDRBIN_TOOL_SOC:rk3568 ?= "rk356x"
>  
> -do_deploy:rk3568() {
> -	# Prebuilt U-Boot TPL (DDR init)
> -	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
> -}
> -
>  DDRBIN_DIR:rk3588s ?= "bin/rk35/"
>  DDRBIN_VERS:rk3588s ?= "v1.18"
>  DDRBIN_FILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VERS}.bin"
>  DDRBIN_DEPLOY_FILENAME:rk3588s ?= "ddr-rk3588.bin"
>  DDRBIN_TOOL_SOC:rk3588s ?= "rk3588"
>  
> -do_deploy:rk3588s() {
> +do_deploy() {
> +	if [ -z "${DDRBIN_DIR}" ]; then
> +		bbfatal "Non-empty DDRBIN_DIR:<MACHINE> required!"
> +	fi
> +
> +	if [ -z "${DDRBIN_VERS}" ]; then
> +		bbfatal "Non-empty DDRBIN_VERS:<MACHINE> required!"
> +	fi
> +
> +	if [ -z "${DDRBIN_FILE}" ]; then
> +		bbfatal "Non-empty DDRBIN_FILE:<MACHINE> required!"
> +	fi
> +
> +	if [ -z "${DDRBIN_DEPLOY_FILENAME}" ]; then
> +		bbfatal "Non-empty DDRBIN_DEPLOY_FILENAME:<MACHINE> required!"
> +	fi
> +
>  	# Prebuilt U-Boot TPL (DDR init)
>  	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
>  }

This is nice, but the problem with this patch is that the rkbin handling
involves 4 files:
	- rockchip-rkbin.inc
	- rockchip-rkbin-ddr_git.bb
	- rockchip-rkbin-optee-os_git.bb
	- rockchip-rkbin-tf-a_git.bb

In the *inc file it says:

	 28 do_deploy() {
	 29         bbfatal "COMPATIBLE_MACHINE requires a corresponding do_deploy:<MACHINE>() override"
	 30 }

These machine-specific overrides are found in both:
	- rockchip-rkbin-optee-os_git.bb and -
	rockchip-rkbin-tf-a_git.bb
but, with this patch, not in rockchip-rkbin-ddr_git.bb.

I like what you've done, but I would prefer they all follow the same
"template". Either:
	1) modify rockchip-rkbin-optee-os_git.bb and
	rockchip-rkbin-tf-a_git.bb to match and update the bbfatal in
	rockchip-rkbin.inc so it makes sense, or

	2) skip this patch

I don't have a strong preference either way, but I do have a strong desire
that they all match.

