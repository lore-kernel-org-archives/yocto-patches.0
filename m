Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD85C27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 12:17:53 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web10.19494.1718799464542912325
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Jun 2024 05:17:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hg80DGFq;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-795502843ccso355843885a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 05:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718799462; x=1719404262; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFfn8Tpt2TK7LgPaajG861qFY8YwOa1Wz3fkg9BkctY=;
        b=hg80DGFqkDiDtxlH9K5y30psqbx1fsMGCm+87shC6wAE4HE8opxBImYFLuhbvlLCRa
         0yUpPPjTAsDfJI09n/p98thzzo3UDghZ2zrBbDsVXOR+LPQupaRKjCcvgArzSq67wuSt
         Lqk8+FUrtU9/hovZ+2zx1zhvxdcWptJq9PIDJZ7xdrtNOBngjU38Al1luXyy3ebl1TWq
         uygQ7NVsCwXntC+plfdsXENPmdiH2GsK/EvDliRm9fIULwuEORUj8iNw1WgT9lh2Ck4P
         znebmUVk0ptEOeoCbGH3dNJqQKK/bidPeZRnfaEwahlvXayEoVj1OdPE6U6Jx3yL3z9P
         HjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718799462; x=1719404262;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFfn8Tpt2TK7LgPaajG861qFY8YwOa1Wz3fkg9BkctY=;
        b=ZWBZ8F2mxecI3lXIwgwn/efFPUuz/jzI5FkT0YAq2OIA4uOAWkDBRXYraTG3fSzR7m
         Ed9LCd0M1eFpi79AZte+F8P4hrGfGEcdGrQWc3RfK5Gc2VmWITvz4d4U6XVtt1+atbJK
         mxA+2cqjA+mcvISrVnQH6aC2/S2idxebEpkw4kNLAT5ycrzfsibC9DYdROfnr4ai3YSk
         lrB/JF706eg+0bUmg7eMlMV7mTdvdwyGO0D04kas6MKriUPvoMUpwT+SnoK2P2oGqkXf
         v2xKt+wTGDMZ0ahFOIYUAD4OOrtxad35AyaMxElxWwmKTiyf7VIxvo2bNV/smyRwwFEs
         Zang==
X-Gm-Message-State: AOJu0YzEe6sD498rhNn7BiDA1khPHjyUClyhzgB/ydNIS+KCi+Ydn1ri
	qSxAYG+IBG8WD9LDtTpE4EbMekJx3kSqVn9Socrdn+0TDMDh/e/a+zKMdw==
X-Google-Smtp-Source: AGHT+IHdxAmNLi9D+RZTV9IjgxWB42O5fyCcQoFrCzEg8VlQqQVbV231QQAuUBt5J7/K8D3XKmpxjw==
X-Received: by 2002:a0c:f005:0:b0:6b0:91a4:ece7 with SMTP id 6a1803df08f44-6b501ea349cmr28633296d6.46.1718799461648;
        Wed, 19 Jun 2024 05:17:41 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb49a8sm77081566d6.90.2024.06.19.05.17.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:17:40 -0700 (PDT)
Date: Wed, 19 Jun 2024 08:17:39 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2] linux-torvalds-next:
 use tag
Message-ID: <20240619121738.GA16113@localhost>
References: <20240618171619.9303-1-twoerner@gmail.com>
 <d7838e2a-85e8-4308-82cc-36f9eb2b69c6@cherry.de>
 <CA+chaQeUfaxfeuqSZEqxYVm6EcH8S9QqGe=1F=b2UgpmNaUPBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+chaQeUfaxfeuqSZEqxYVm6EcH8S9QqGe=1F=b2UgpmNaUPBg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 12:17:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/352

On Wed 2024-06-19 @ 01:56:14 PM, Martin Jansa via lists.yoctoproject.org wrote:
> Why is this better?

Because in a repository like linux-next
a957267fa7e9159d3d2ee1421359ebf228570c68 could be rebased out of existence?
Although now that makes we wonder what would happen to the tag in this
situation.

Three days ago this hash was reachable from master, now it is not. That's a
lot of churn.

> Now bitbake will always run git ls-remote to
> covert next-20240611 into a957267fa7e9159d3d2ee1421359ebf228570c68 and
> break parsing this recipe without network access.

Is that how you're building with meta-rockchip?

> On Wed, Jun 19, 2024 at 10:59 AM Quentin Schulz via
> lists.yoctoproject.org
> <quentin.schulz=cherry.de@lists.yoctoproject.org> wrote:
> >
> > Hi Trevor,
> >
> > On 6/18/24 7:16 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > Use the tag name specifically; note that it is no longer reachable from any
> > > branch.
> > >
> > > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > > ---
> > >   recipes-kernel/linux/linux-torvalds-next_git.bb | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
> > > index 9a95eb5bc4d8..1369ba1d707f 100644
> > > --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
> > > +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
> > > @@ -10,13 +10,12 @@ COMPATIBLE_MACHINE = "^$"
> > >   COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
> > >
> > >   LINUX_VERSION = "6.10-rc3"
> > > +KERNEL_VERSION_SANITY_SKIP = "1"
> > >   PV = "${LINUX_VERSION}+git${SRCPV}"
> > >   SRC_URI = " \
> > > -     git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;branch=master \
> > > +     git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1;tag=next-20240611 \
> > >       file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
> > >       "
> > > -# this is tag 'next-20240611'
> > > -SRCREV = "a957267fa7e9159d3d2ee1421359ebf228570c68"
> > >
> >
> > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> >
> > Thanks!
> > Quentin
> >
> >
> > 
> >
> >
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#351): https://lists.yoctoproject.org/g/yocto-patches/message/351
> Mute This Topic: https://lists.yoctoproject.org/mt/106745214/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

