Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604A9C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 15:23:49 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web10.40991.1721057027067144372
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Jul 2024 08:23:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lxh2G+aY;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5f3348f05so27400116d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jul 2024 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721057025; x=1721661825; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bi/ccGiU7HRGUmlD5Co+hH2+ml1wbkuhx3i1b4IcZPk=;
        b=lxh2G+aY3QmqBd08hm1MQkxtLzvNzs858V1olLDGLmGn/NrJp5nUiKoYnGZomMGvmI
         5hd3ppcwTGSoFDo9vVP6hKeFt/Jh9+WSzGbmr/DxqU62uixfw6EQ5mp4w7eVwE0OAbAm
         72DgcMlGR1ZRjI37Cgvyd3UBzAHlbeA8nEGXKWVPYcdsX4m0w0pzv8xBY/zZ8hZCMAKC
         MJ8+mJ+8p8fQ8ewkfa5bmEbthftw/hOxVLyda+TZuEPBuwLwEeP0XA0T8PoctIzpAlxN
         ZxFavjaVxj3VnTNDCmFLAaxIW4JiIbBR1Yicrevr2UB828Kp6E7eCdqrLdHXkVNUZjvK
         jHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721057025; x=1721661825;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bi/ccGiU7HRGUmlD5Co+hH2+ml1wbkuhx3i1b4IcZPk=;
        b=vTA9lA7Sn2w5XBQ1wcLLGJH7v4MOTjsq7v788AXCZrw+CC24cbYXVtLYMzubSlGMU0
         SPoFMWXtYLslGRxQNm/eO+9bU94AwiaUrkrymQnI+ZtplALFbEqVMEAe+yey19HmsA5h
         xTe1Cnxlumvb+Un0C0Vu89QeREyhXVEQrlgWSPRW1chGgJHewIrtCcQhDuDp/kU1hGlN
         SxadOktCJIvGyI1XGgRUHGH/kU1LU/YnhP4bT6WUxUrnPkkjlm43bytS4Dp6X3FHHKo0
         KPT+jMCLGcZe9uUHGZ5RlW/6e2cZvrhNVUbh8UrKd4JPGJR2puXR1AXaWtVmSrLi2HIH
         awYA==
X-Gm-Message-State: AOJu0YwLgWtPHHlAA2cReSk6kGiSYzzPTO6OvGk2Y8S49N4N36Hcp1qB
	2XhCHLmSoyvQcMt1P6DBHkIIAc73JHMb98ZdO0S2L92gBl4FWxW+Zev7Sg==
X-Google-Smtp-Source: AGHT+IGXP5+D2Mstq0xh63nWhyfA0piB+2CxEmFvEBSwWFG8o8FTY68GxVS3UJ7LqK1q1/kz7uWtRw==
X-Received: by 2002:a05:6214:c22:b0:6b5:d45d:84bd with SMTP id 6a1803df08f44-6b61bc7f0a0mr329657286d6.8.1721057025213;
        Mon, 15 Jul 2024 08:23:45 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7619a724esm22091576d6.72.2024.07.15.08.23.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 08:23:44 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:23:42 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-torvalds-next:
 ignore TMPDIR issues
Message-ID: <20240715152342.GA10926@localhost>
References: <20240715143149.16336-1-twoerner@gmail.com>
 <5afa76ad9a887b364e4a4640959de3332330bd5a.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5afa76ad9a887b364e4a4640959de3332330bd5a.camel@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jul 2024 15:23:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/431

On Mon 2024-07-15 @ 03:47:11 PM, Richard Purdie via lists.yoctoproject.org wrote:
> On Mon, 2024-07-15 at 10:31 -0400, Trevor Woerner via
> lists.yoctoproject.org wrote:
> > oe-core has raised the status of some checks from warnings to errors.
> > Ignore
> > the "...contains references to TMPDIR..." error when building the
> > torvalds-next kernel.
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >  recipes-kernel/linux/linux-torvalds-next_git.bb | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb
> > b/recipes-kernel/linux/linux-torvalds-next_git.bb
> > index c0ac1de22005..6f3db7c61bdf 100644
> > --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
> > +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
> > @@ -5,6 +5,7 @@ SECTION = "kernel"
> >  LICENSE = "GPL-2.0-only"
> >  LIC_FILES_CHKSUM =
> > "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
> >  
> > +ERROR_QA:remove = "buildpaths"
> >  DEFAULT_PREFERENCE = "-1"
> >  COMPATIBLE_MACHINE = "^$"
> >  COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
> 
> You may want to add that to WARN_QA so you remember to at least look at
> them a some point. They're a sign of non-reproducible builds for a
> start and break hash equivalence sstate reuse.

When I added support for these two MACHINEs in meta-rockchip
(radxa-zero-3{e|w}), support wasn't even yet available in linux-yocto-dev, I
had to use Linus' -next tree to get support (which is why I created a
linux-torvalds-next recipe). In time support will hopefully
trickle down into linux-yocto-dev, then linux-yocto, at which points I will
discard linux-torvalds-next for fully upstream oe-core support.

I could add a WARN for this, but I'm probably not going to get around to
looking into it and fixing it, I doubt anyone else will (since it's a recipe
specific to meta-rockchip), and fixing it won't be required once we switch to
something from oe-core.

> 
> Cheers,
> 
> Richard
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#430): https://lists.yoctoproject.org/g/yocto-patches/message/430
> Mute This Topic: https://lists.yoctoproject.org/mt/107232153/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

