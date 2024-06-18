Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F4C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 12:11:13 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web10.84951.1718712669823330101
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Jun 2024 05:11:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c3rKfnBy;
 spf=pass (domain: gmail.com, ip: 209.85.210.44, mailfrom: twoerner@gmail.com)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6fc36865561so1390942a34.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 05:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718712668; x=1719317468; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP1pp4c7dtvRgd0+huHCByyPSRwz4sCx8IldbAK6Ubo=;
        b=c3rKfnByCrZVjqbLZdKBddVjOXhNXvVoxyTaxE3z+Vau0CGjaxY/7qxrfxIcyPVyhT
         9bIk1Um/4l379sCiAhXxwoO3ojuzh9+Gehm7MrA0Wy4L20kYaKBbGozB7bQ4ZbreAvyf
         PXjQ4Nigmb7sqy8bvvcWg3Mrqlt/6hXrjHRkYkGzpLsjTs3PqFYiYMwG6ICeFQHVSM8E
         cMqbLMj6QgDFDwrHAcUeYn8pwGngz5imnaggihFjwKMdO6iPqpoKNcYcMGGY7wYnYwSO
         cHdS7V7oZGVCuxsgd55JTh2ZVQ3+Fo23ACmTv6tdt0DgEeuHcWLpASMoZXoIzyOoXde9
         JCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718712668; x=1719317468;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dP1pp4c7dtvRgd0+huHCByyPSRwz4sCx8IldbAK6Ubo=;
        b=j1wvKJZbxls2yxhCb/fPGv/d4gZrf5IuBtOOsxaPtHAlfWaY/vtCm4BbqZvZM19ec8
         4BZ0aHCLBxMm+ZdJ1ANkh2Jj8QVvB2xsH+J2g9aMcBIN+zZpGF8Ey0KlNxyvoW8uOYbG
         BEHetnhXrJrGBS8gL819c8qP2O2b9PnFuwPjPIOrVurCebj7DTok70lYSNi0E1xVM7P6
         Ryqde7yp2/Np18KD3sjZxpShBC98OXGOKo3h1QzOPQGnEs4lFGuY3ykyJuIa1zsycRWH
         SdBUgFccetRA2yVGpIopLRiRLA5vENf8fMP7L3wLrNeGYNIOGI0tuh8pYQVtxovdXHRx
         N4QA==
X-Gm-Message-State: AOJu0YyC+BYT+C3K6qCDwrXhB8lwoV2be7P+Ctp5Lvt5XNc/BCGrF9Ji
	s/2VTmsW7I/IVvUm3ZYsXSYgHAgwdkgUhoEozvnEiCnTgQfq6cQt6Spwew==
X-Google-Smtp-Source: AGHT+IFFM9GD/Y+D7S6l4wgxCw9zQGjTlVgYnEkN4il2i2b/fP8n37PfJGDpTtA/dOZ18BqKveDn4g==
X-Received: by 2002:a9d:6558:0:b0:6fb:8411:2f16 with SMTP id 46e09a7af769-6fb93b37036mr12885973a34.31.1718712668332;
        Tue, 18 Jun 2024 05:11:08 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c1ff4fsm66084036d6.47.2024.06.18.05.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 05:11:07 -0700 (PDT)
Date: Tue, 18 Jun 2024 08:11:05 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: mbober1@gmail.com
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] mesa: build panfrost for
 RK3566 boards
Message-ID: <20240618121105.GA7341@localhost>
References: <20240617200024.389206-1-mbober1@gmail.com>
 <0e12a001-4564-4272-b5d4-af42fe80da1b@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e12a001-4564-4272-b5d4-af42fe80da1b@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 12:11:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/339

On Tue 2024-06-18 @ 11:48:26 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Marcin,
> 
> On 6/17/24 10:00 PM, Marcin Bober via lists.yoctoproject.org wrote:
> > [You don't often get email from mbober1=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > The RK356x SoC family (of which we currently only support RK3568) has a
> > Bifrost GPU that is supported by open-source Panfrost Linux kernel and
> > Mesa drivers, therefore let's build mesa with Panfrost support for
> > RK3566.
> > 
> > Signed-off-by: Marcin Bober <mbober1@gmail.com>
> > ---
> >   recipes-graphics/mesa/mesa_%.bbappend | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa_%.bbappend
> > index 2d9ec2e..ca1ad70 100644
> > --- a/recipes-graphics/mesa/mesa_%.bbappend
> > +++ b/recipes-graphics/mesa/mesa_%.bbappend
> > @@ -2,4 +2,5 @@ PACKAGECONFIG:append:rk3288 = " kmsro panfrost"
> >   PACKAGECONFIG:append:rk3328 = " kmsro lima"
> >   PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
> >   PACKAGECONFIG:append:rk3568 = " kmsro panfrost"
> > +PACKAGECONFIG:append:rk3566 = " kmsro panfrost"
> 
> Maybe re-order alphabetically :) ?

I can re-order when I apply.

> Otherwise looking good to me,
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#336): https://lists.yoctoproject.org/g/yocto-patches/message/336
> Mute This Topic: https://lists.yoctoproject.org/mt/106728240/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

