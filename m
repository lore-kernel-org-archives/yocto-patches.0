Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5298E7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 20:07:25 +0000 (UTC)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
 by mx.groups.io with SMTP id smtpd.web11.4131.1733947641704930939
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Dec 2024 12:07:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Dk0juLhv;
 spf=pass (domain: gmail.com, ip: 209.85.166.170, mailfrom: twoerner@gmail.com)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a9cdcec53fso28810595ab.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Dec 2024 12:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733947641; x=1734552441; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MND3QxDwC4JVfzii8WbMaMBSX8Zt/SAtOMEWtelw1kg=;
        b=Dk0juLhvEqc1jLD6+/ev8cDYtfLLZghVp7BAC3niOvGRndxxWhedu0gRS6931CbDia
         twgw2iGYMbgeESK4b0AZartviJ32az42liDUGwM8/+LJsUc0iWzY1olcz9rdbsnIvGKF
         B0igQFz8kRaCW7EKh40X1mvjx1Tcw450j6HG2qhTWBVMLZHvAltbFaVTCPi9ELH498Dl
         H7v4OvVOfZRwBFOvjoWX8M9XXcNpSfcyDKcRyeE/xoSH5KawS3i2vn8EToehH3bwwe2+
         GxPjsHwwDVl00pcxN1wT6XKYOVWUyTLLIBclp80ELR40GUXLJjsNFUzkFKUG1mV/SgWT
         DUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733947641; x=1734552441;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MND3QxDwC4JVfzii8WbMaMBSX8Zt/SAtOMEWtelw1kg=;
        b=K3aZeOiOWgpW+TQku7SP7dF0knSFspBBHb9jFTvCUPWfUaI4tcnLD9zgZoiw5qGZW2
         lutgJaJdxhz5I/MLCqo3AUbEoKbzduSHzk5SsKAYV30uRH9mtHm960jLi2QTWytElbxW
         DkMBQb+AA56ERZhFHfVNUrkFzIa899znpVlyWoFz49T6yLzPilwTkZ9TeY8NOsoArxMO
         D8cOQHsjN5FHRiYrTppI6sx6J6UwAleXu+hlmklZ3iIH/JfYzQhGhHBu/2RukV0S6Cqg
         FCDFYkqkzwqP9ZJQFbJu5Mq/96lwvAl7sYmmXuaSH1uT094/lQ7wKAB4soHm5twwjI57
         m1vQ==
X-Gm-Message-State: AOJu0YxKdxzIHOGmP8W7qxM3qY6MRLFSQIxOmwOTcvumGax0Hcv4qdo7
	1AUigpIW965aIvRSQpTSeEe1Daxyotz/bQwXL8GcYfKSQamKmXZb
X-Gm-Gg: ASbGncvNt3KWn+oac8+/VVyTi3bq1PC0YUMdy1rrbqvT1i/wlzod+XjYIFMcOoDTXBA
	4tPDdx3DHeFlfoJ0RjsiQ8w+GDcJDkWhdUw3TNEkhZEO7cnu2NtlMBUuZMUujvEsL4yRMwtwuPR
	IkmWqemXMbEwNb6wP/cRtV9HP+2Wcxs9vWVleNGemeGZRGxuUMGtFEZBlSy5QVYrcZgnmnn2yJj
	5gxzQaNgOeHujHNb2tE4wrd8y6sV+wyTxR9RSpoAPTrYINktdh2mSzTte+lnX0ZOusG/NKHKCxU
	aMf8NA==
X-Google-Smtp-Source: AGHT+IGgFMAQFYLos2Lejywqj7b2iL5hmKU2aHCLqcjHdArSCP6tgkfGTkJaN8n91i9g9pEKQ2O/yw==
X-Received: by 2002:a05:6e02:1a2f:b0:3a7:81a4:a557 with SMTP id e9e14a558f8ab-3ac4bfc1543mr9391085ab.24.1733947640911;
        Wed, 11 Dec 2024 12:07:20 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a817752b3dsm31043045ab.66.2024.12.11.12.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:07:18 -0800 (PST)
Date: Wed, 11 Dec 2024 15:07:15 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org,
	Oleksii Kurochko <oleksii.kurochko@gmail.com>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] u-boot: Update SRCREV for
 radxa-zero-3
Message-ID: <20241211200715.GA12655@localhost>
References: <20241207162339.10677-1-oleksii.kurochko@gmail.com>
 <4e53cd8a-0607-4816-830b-ae2ed81e5875@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e53cd8a-0607-4816-830b-ae2ed81e5875@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Dec 2024 20:07:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/886

On Mon 2024-12-09 @ 04:22:47 PM, Quentin Schulz wrote:
> Hi Oleksii,
> 
> On 12/7/24 5:23 PM, Oleksii Kurochko via lists.yoctoproject.org wrote:
> > [You don't often get email from oleksii.kurochko=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > During the fetch stage of u-boot for radxa-zero-3, the following issue occurs:
> >    Unable to find revision 8cdf606e616baa36751f3b4adcfaefc781126c8c in branch
> >    rk3xxx-2024.07 even from upstream
> > 
> > This happens because the hash of the head commit for the rk3xxx-2024.07 branch
> > is different from the one specified in the recipe.
> > This can be verified by running the following command in
> > <yocto>/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git:
> >    $ git rev-list -n 1 rk3xxx-2024.07
> >      2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead
> > 
> > Update the SRCREV to the hash of the current head commit corresponding to
> > the rk3xxx-2024.07 branch.
> > 
> > Fixes: e0b13fe834b5("radxa-zero-3{e|w}: add")
> > Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
> > ---
> >   recipes-bsp/u-boot/u-boot_%.bbappend | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> > index c939a48..9432e2b 100644
> > --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> > +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> > @@ -3,8 +3,8 @@ require u-boot-rockchip.inc
> >   FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> > 
> >   SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
> > -SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> > -SRCREV:radxa-zero-3:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> > +SRCREV:radxa-zero-3 = "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
> > +SRCREV:radxa-zero-3:rk-u-boot-env = "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
> > 
> 
> Master poky now has v2024.10 and at a glance it seems the Zero 3E/W is
> supported, so maybe we could simply ditch those overrides for master branch
> in meta-rockchip?

Yes, and it looks like it's time to also ditch the overrides for rk-u-boot-env
as well. When I added that recipe from Jonas, he warned me at that time that
switching to upstream would be a better option, but it worked, so I left it
for the time-being.

> Other release branches should probably get a fix similar to the one in this
> patch though. Or ideally just download the patches from that tree and apply
> them on top of v2024.07 for styhead (we would need a new release branch for
> that though). Scarthgap has v2024.01 so that's a bit too old to apply
> patches destined to 2024.07. But we could maybe point to v2024.07
> upstream+patches instead of pointing to Jonas (Kwiboo)'s personal git repo.
> 
> What do you think? Trevor, an opinion here?
> 
> Cheers,
> Quentin

