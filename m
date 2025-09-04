Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE18CA1013
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 16:58:50 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web10.1981.1757005125954101741
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 09:58:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fZnp82g8;
 spf=pass (domain: gmail.com, ip: 209.85.160.172, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b326b6c189so15301461cf.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757005124; x=1757609924; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvODj+DIfQGq/55g1h1fb8plJ1N+0R2xHUVkvSgDC3I=;
        b=fZnp82g8U0fSEHRaPmNMwo3nPlvYIs89mzoRuqxZS5g6dbJzxMxT38qLluAW0EnSBI
         F12Qe65paZH3v8DMBBi+dq6kWpF7Gi3/ZgKPvACgYaZwPnP63DpcohF7w2tDIMGNfA+2
         rNKDT04I22ku8Et3ud0wnalX/s5ZNOXPrMYXn4olXCE04SGU3cqeMUtPeG3PA2UgeI+h
         8Ey+gglFGPuxw/OIJaHW9lLBrSd/dru+nNfSi1leH0v8wEWX4MJLHf+8u4dZwwyYXknx
         Y4UyCjqnei6oMpAyCR3y4xby6Q0/5RBqDwdu+SbSzU1Yuwoh6tfDVIsT1WgnI0/3Sunq
         QN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757005124; x=1757609924;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvODj+DIfQGq/55g1h1fb8plJ1N+0R2xHUVkvSgDC3I=;
        b=Fy+nAl9TSpA+VTEOWX6ciJjGpoJCUfFVlto9QRT5HQKi4O/zvHWCIolhruGHLUbK3F
         DHfdAU1V6UXgul0bHPnEiiJ2uycZKm37yNJLyE0DFWWrHjeG6YyuuD6lbkDYqFCxn/Bb
         /ct3LXFs/ze8WbA+2ZFb1uhGs37bld6obCmLNLtj/hpBn5hzMSBbVX/F3pb0+K/PUav+
         lFooV2wNlkLCMMt6tqNNZJ9kjfhIUFPS8YpdNBPgVoJqKl7ZY5BJFCHF492X4bXUfEOw
         nmyV2BWXc/A9zGXBdYZO/C9ies44dDITXaaQsVc5EhKUGbWae1INd2Ri057U8t6aPxW9
         E5Dg==
X-Gm-Message-State: AOJu0YzQyPS9/rcpX0rkeiT9qmD2S2daYBQppEmm4FskBqLcUt5nCe2g
	CRsKkfcCZP5srPo47nz0VLl5t9c9EAUs0dfHHBziDFXEcsKxRc0Dp6w2CkNHTQ==
X-Gm-Gg: ASbGnctVMhClDfaZhY8E2Bj8Ze8TzYNVWIGFdUdxeUUR5gx61jm9INSDKes9+bXBG+W
	oyEZUmvyPQfE0gHKb2Qmq9Jo0U0Yesu5H9YW6rfLD4nFrYCrkhT58eC8heinmjLqRvtNPOTTebP
	jN26ZgoG/u1JQIlpNqTs4gX6uGSZJq7xCKwFAKiGNDpeogKnCaFfP0HBcs4gGe6MXmCfhpkxKoJ
	BWrOShGkEmeTG8CxbWrZ8/6gHZ4oF0sgtf7mGKHYl7oNhFwVmZzb7jWeNL4AeiXndwuexToBCtn
	y37i+3CTO1cTmaowpr2CAGi5xwUbUGDjvA9yoB00ePJZxk6xhQhFU3ihSaMgJW19x/vWm8dkqST
	RrvbYje4u+p96E+wdzSlhHBXQltt3hWPkh6MTYqGfL8AmfMUuxcf4hQefvwpx
X-Google-Smtp-Source: AGHT+IGA4pIhMnz0Rgp/8TgJcyBVlFzGW1Q19hA4wM5zaxquQs0z2kMmbxwwOlms5znuPZFOanhEgA==
X-Received: by 2002:a05:622a:3d1:b0:4b3:b4e:1c9a with SMTP id d75a77b69052e-4b31d89da12mr255406081cf.7.1757005124171;
        Thu, 04 Sep 2025 09:58:44 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b5d57c6e0asm17523451cf.51.2025.09.04.09.58.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:58:43 -0700 (PDT)
Date: Thu, 4 Sep 2025 12:58:41 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] nanopi-r4s: refresh
 device-tree patch for linux-6.16.y
Message-ID: <20250904165841.GA26854@localhost>
References: <20250904132717.8973-1-twoerner@gmail.com>
 <f968f8e3-b138-48c6-9fff-43276c5ab03d@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f968f8e3-b138-48c6-9fff-43276c5ab03d@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 16:58:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2135

On Thu 2025-09-04 @ 03:43:45 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 9/4/25 3:27 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > The device-tree organization of the nanopi-r4s device changed slightly in
> > the linux-6.16.y release, therefore refresh the nanopi-r4s device-tree
> > patch to match.
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   .../linux/linux-yocto/nanopi-r4s.scc          |  2 +-
> >   ...opi-r4s.dtsi-enable-second-ethernet.patch} | 21 +++++++++----------
> >   2 files changed, 11 insertions(+), 12 deletions(-)
> >   rename recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/{0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch => 0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch} (56%)
> > 
> > diff --git a/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc b/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
> > index 266b77c63fe5..3d1601e28d13 100644
> > --- a/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
> > +++ b/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
> > @@ -3,4 +3,4 @@ define KMACHINE nanopi-r4s
> >   define KTYPE standard
> >   define KARCH arm64
> > -include bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch
> > +include bsp/rockchip/0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch
> > diff --git a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch b/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch
> > similarity index 56%
> > rename from recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch
> > rename to recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch
> > index e1f2b92665dd..a3dc23afae7e 100644
> > --- a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch
> > +++ b/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch
> > @@ -1,9 +1,8 @@
> > -From 4c867907b68b417da0711cabdde30a969e368596 Mon Sep 17 00:00:00 2001
> > +From de2c28076a50e94659ea9693f9d0a307ef475132 Mon Sep 17 00:00:00 2001
> >   From: Trevor Woerner <twoerner@gmail.com>
> > -Date: Sun, 17 Sep 2023 17:30:43 -0400
> > -Subject: [PATCH] rk3399-nanopi-r4s.dts: enable second ethernet
> > +Date: Thu, 4 Sep 2025 09:11:33 -0400
> > +Subject: [PATCH] rk3399-nanopi-r4s.dtsi: enable second ethernet
> > -# lspci
> 
> I think this isn't supposed to have disappeared from the commit log.
> 
> >   00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3399 PCI Express Root Port
> >   01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ether)
> > @@ -11,14 +10,14 @@ Link: https://github.com/armbian/build/pull/2415
> >   Upstream-Status: Submitted [by someone else]
> 
> Where was it submitted? I cannot see it on linux-rockchip mailing list
> archive the little I searched for it?
> 
> It'd be nice to have this upstreamed so you don't have to carry it around?
> 
> It does seem odd that every address and range is 0 though...

Yea, it's a kludge of some sort.

> The change does look reasonable though :)

I just tried this "trick" on real hardware using the latest 6.16.2 linux-yocto
kernel and it does not seem to work anymore. That's unfortunate. So I'll send
a new patch to remove this kludge for now.

