Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF7AD6D251
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 01:01:14 +0000 (UTC)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
 by mx.groups.io with SMTP id smtpd.web11.86037.1732755667948426766
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 Nov 2024 17:01:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fdgwWFJe;
 spf=pass (domain: gmail.com, ip: 209.85.166.170, mailfrom: twoerner@gmail.com)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a752be9f4bso1158565ab.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 27 Nov 2024 17:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732755666; x=1733360466; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdwfcOKAntXrWD1ckjX2+DR7nFmBnqZLvbLRfx+6EYw=;
        b=fdgwWFJe0jCkiLtYRsWq9VUZ8VeArgv662jZCw++AzILzJeHOFyUjza+bYF3iU30E9
         SVEBkf7crV/Dz+L88HdjCuHIMMTLRkiuz7hwQXBDGADHxUIihdgRF1Dn+2xKDIuNA2eZ
         U+1dbsepwMuqDQu/A5vjVuM7/UUCyy8IPQkwoQ544h2JXbwTap8rHusFvJoC7VmlXsjo
         jsL5qhEj+QRSwjs3U5rJr3IhcHeWIB49JFsHImalqWiQXWIklnn5gB72S025vCkjwLOQ
         bQg0M2vZSK53FksDbRZ9iR/FRPoDXtqtV1K33pAraG5jPKRSsB9aBUvg1hPmXntpWFyK
         eQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755666; x=1733360466;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdwfcOKAntXrWD1ckjX2+DR7nFmBnqZLvbLRfx+6EYw=;
        b=RA+cCbiwaJBMS18rx8EELH2W9WkYtb3IjjJiNFf+J96IHOmSHfpaR6ED8bERC72mAh
         Ip5KSnWCDPdEg62W+z377jRAIFnMhlnIHTFjxJIB0cCo3jyunUUO6FlE5iqrn1Ifn/NN
         3fB9vu3DFxw+nqmSXIIlsRt6HnQusFPaA/1Y4CNNGvE27ysuTaK1JtcAHNxiJ91c2Hkw
         h6FJdBfU8sTq92841z9uWSWowxWrAa8l4AETArf1XXi3gXuX40lfvjlX+uuciGjTkC8J
         lSEYjhIzhAnBGTR4pNyhaKDMrAYUrfM0jb9G/U+TBWEftfExrXcBtJEiujq7I7GHQC0m
         nZXg==
X-Gm-Message-State: AOJu0Yw3QkQJnHa/nywDFdQhkx/BeSX8RgAX8NBmE2MInsnDGM6NObYk
	4QhUJsnFC4OQ6b8l1hX9qmPaU8Rf433ao8J6FFWfZ3bSol/5BDycFfu1VK6L
X-Gm-Gg: ASbGncvJsGJrkNPblP9CyCSKLnvOEEv9VmmW/G1Hg7ZSfMVIMlcHxsvx2ctezFWr8pj
	yPkQtnRvN9AqaTVbaX0GE+27HF6EEP3Y3TNk3rLxz3dDRh1rkjYAcAzvy7PpUqIYVxbBJckxHiq
	u5OcKKlEfb0TE3VC068VncSpbzVtRxNV1aCCgR4FPXvXbc2qZskJWuWZae+6Rg1HvxuEqGGuuZz
	x5M1jlQOYx2lvW1X6O2ZFAuFqsFJv8LVrjKZt4ZfD7fEKHxjR/wn4SxVKp603zaapuwfcZ4kQdJ
	oA==
X-Google-Smtp-Source: AGHT+IGhBJ/4bX5nXaO+O0/istTmRnRxMzI1bMMLUBN/MbJSN7O+FpkBjjrT5vassFVS5ER+7DoqYg==
X-Received: by 2002:a05:6e02:1547:b0:3a7:6e59:33ad with SMTP id e9e14a558f8ab-3a7c55cfc2cmr49137525ab.17.1732755665558;
        Wed, 27 Nov 2024 17:01:05 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d875195b25sm1364216d6.63.2024.11.27.17.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 17:01:03 -0800 (PST)
Date: Wed, 27 Nov 2024 20:01:01 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH 2/2] bsp: rkbin: bump to
 latest commit in master branch
Message-ID: <20241128010101.GB17984@localhost>
References: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
 <20241127-rkbin-bump-v1-2-b90b6c04a88f@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241127-rkbin-bump-v1-2-b90b6c04a88f@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Nov 2024 01:01:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/850

On Wed 2024-11-27 @ 04:12:59 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This seems to be fixing random RCU stalls, system hangs or resets while
> running upstream Linux kernel on RK3588 boards.

Very interesting! I have a number of boards that I'm actively using in the
rk3566 (radxa-zero3e), rk3568 (rock-3a), and rk3588 (rock-5a/b) families.

I'm build testing and will try running them once I have images.

Thanks!

> License-Update: Fixing typos c.f. 385bf9f1700c ("license: typo fix")
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  recipes-bsp/rkbin/rockchip-rkbin.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
> index d70a5551c8171188af93dddf4b3b1dc960f27a83..9264db9048e31b7dae650bdc8e31009f7f4cf404 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin.inc
> +++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
> @@ -1,7 +1,7 @@
>  SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
> -SRCREV = "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
> +SRCREV = "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
>  LICENSE = "Proprietary"
> -LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
> +LIC_FILES_CHKSUM = "file://LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
>  
>  inherit bin_package deploy
>  
> 
> -- 
> 2.47.0
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#846): https://lists.yoctoproject.org/g/yocto-patches/message/846
> Mute This Topic: https://lists.yoctoproject.org/mt/109807517/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

