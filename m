Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A416EA3F08
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 05:37:02 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13825.1770701821239885421
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Feb 2026 21:37:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kfI4OnH7;
 spf=pass (domain: gmail.com, ip: 209.85.222.180, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c5349ba802so520096385a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Feb 2026 21:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770701820; x=1771306620; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aaBuQHJGrKwAyhE8TeUdLT48G06z3qIitTV86hGv4PQ=;
        b=kfI4OnH7qe9xOG6CaQH5iSRo/KHyrTJU02Z6PXUrnCpbD4Ho499F5ORQFeGMno74A8
         b5kNWcui6zoeJwQY6BGHBTd1vfms64GHEO0zn/WQWzOiDTzVP2y91/ZDSG3jxddRrMnv
         rxZNVRHEfSku//eKPqNffIj+cdEyGtR7ebeQDVHWq6mwUdv99UGBEOwup+ga7AIBdhgs
         y0DER9o2ykURzExDOUNuFs1bJIG4bYJnGxRNOjw+csyHATaXTg/clVvMcLWF6iHTNlOl
         RqRHhHG3LceR8p7icSK49kBRl++N/JoUQTCrCipNkPM41STjS6SQdpGeIb1Xbsq/Vl5t
         0/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770701820; x=1771306620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaBuQHJGrKwAyhE8TeUdLT48G06z3qIitTV86hGv4PQ=;
        b=fIl/fUpdmebp2uUMN+rM4VgwhsanX6CmrKO0g0CazdQTODeBPSybjuq53CId1QmkPU
         i7hApSmiZC3Ac0tQjWExbWghMA3QLRtnDDAkmejgISzNj0Npe6ebZ0mPzazkb65inA0d
         T3eH2eIl4aAkch6+nq8le8agntRWyKPhu5Yj3dD9CUdAaNkrPc2a78GKLA8sOTuiHUmk
         UBQ3ByvUw4Ra5A3PUfotSb7LWvDh2x44heP3dgaEzy4NY8EC1eITPRW0D4wTMN+SHhzc
         8rE3r+OWYYlJZkcYaKiod1sBX4WGDsbY/GeEOneGJdu0Lif3S8WDXkR0NUk0uQFPPdgp
         Os7Q==
X-Gm-Message-State: AOJu0YyLzIEyvETPiBtYmmCQYlEo2Ep504r6CR5HNlfdHea/t2LWYOCB
	jXpaJ5p5HMvttBMhEFsIjFOOYbvPBSL2Fn7kGj+jTkENytbyW7Va3j4G
X-Gm-Gg: AZuq6aJZOOMAHPO2azotiZNlvWHDhJO6IsVcEqXvO91q1Fw4D0zmyOiWdem3jrfx/2q
	W8+7vOzAPtM3ynouOALIYNxh9lGWBeADOSzS78j1TnUlrDlZsX+qxJCmriG+nWp92aCdKvtuLc2
	s7xi125KBBtT2e/fvnJ++w8TvvSanT+8KI2h6TErjQZFfcgWpNULeRjAEBTYzkxHvt05ov1q/al
	ilKr6rLxQYFe3IE0HrsIlPBg4nUreI1jBam953mgErJxKjed4YfEfKqwO8RD/IrMFE+nRMVl2d+
	d236b4xrBWLD+tOGi5HDd7mYv1ufTC8jOl2X19vXnoIwXU30BlK8hn7R1mmHGQyqbDAlSpYrOz1
	bInyvX74UM1VPfjUXOW34OdJ0j58RKQaqcCh47KjVncNjnCft5NySQs/umnQXtogCxVC4DrAycc
	BIEpkZGsZwaIZG0hHm1dbykgXVREYybLYMl5GmUBi8CGtl9aVCXX34DUXpiVvy0/KGew==
X-Received: by 2002:a05:620a:4055:b0:8b2:dcde:b668 with SMTP id af79cd13be357-8caf057f2b2mr1824721685a.62.1770701820182;
        Mon, 09 Feb 2026 21:37:00 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7aeed7dsm926865585a.18.2026.02.09.21.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 21:36:59 -0800 (PST)
Date: Tue, 10 Feb 2026 00:36:56 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <foss+yocto@0leil.net>
Cc: yocto-patches@lists.yoctoproject.org, Peter Hoyes <peter.hoyes@arm.com>,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH meta-rockchip] bsp: fix upstream TF-A deploy desync
Message-ID: <aYrD-LsfeSn64ckx@localhost.localdomain>
References: <20260121-tf-a-fix-v1-1-02f7b61db7f8@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-tf-a-fix-v1-1-02f7b61db7f8@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Feb 2026 05:37:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3209

On Wed 2026-01-21 @ 06:06:56 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Since commit 7bce36a2c64b ("arm/trusted-firmware-a: Use
> firmware.bbclass") in meta-arm, the BL31 firmware is deployed in a
> subdirectory named trusted-firmware-a and the binary is simply called
> bl31.elf without any other string.
> 
> This differs from what it used to be by the use of the subdirectory and
> the name of the file itself. This is an issue for us because the U-Boot
> recipe is given the path to the BL31 binary in deploy directory and that
> now was wrong.
> 
> The second issue is that we want rockchip-rkbin-tf-a to be a drop-in
> replacement for the upstream recipe and have nothing to change in other
> recipes dependent on *an* implementation of TF-A (such as the U-Boot
> recipe).
> 
> We can either fixup the path like was done in 2a13a49da4af ("fix u-boot
> for tf-a firmware") but we'll need to do that for all current and future
> SoCs (and also wasn't a complete fix as for example px30 didn't have the
> fixup applied). Or we can simply adapt the rockchip-rkbin-tf-a recipe to
> deploy the same way that the upstream trusted-firmware-a recipe does by
> installing in a trusted-firmware-a subdirectory, simply name the binary
> bl31.elf and update the BL31 environment variable in the U-Boot recipe
> to use the new path.
> 
> Because RKBIN_DEPLOY_FILENAME now contains a directory in it, we need to
> make sure the directory is created (with install -D).
> 
> This was tested with upstream+downstream TF-A for RK3588, upstream TF-A
> for RK3399 and PX30.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> This is a follow-up to
> https://lore.kernel.org/yocto-meta-arm/28377373-a3e8-4416-aa7f-488cdfdbcf55@cherry.de/T/#m76f7d4b56849cc28fe80a76953f4e6e61ff0f7cc
> and
> https://lore.kernel.org/yocto-patches/dd990ccd-a418-45bc-b708-d3b1fc763ea5@cherry.de/
> ---
>  recipes-bsp/rkbin/rk3308-rkbin_git.bb                        |  2 +-
>  recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb                 |  9 +++++----
>  recipes-bsp/rkbin/rockchip-rkbin.inc                         |  2 +-
>  recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend | 11 -----------
>  recipes-bsp/u-boot/u-boot-rockchip.inc                       |  4 +---
>  5 files changed, 8 insertions(+), 20 deletions(-)

Applied to meta-rockchip master branch (with added -D), thanks!

