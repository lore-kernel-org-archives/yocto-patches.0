Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0525BC5AE59
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 15:55:20 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web10.15321.1748966112754867414
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Jun 2025 08:55:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VmvA3D7B;
 spf=pass (domain: gmail.com, ip: 209.85.222.173, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7cadc92771dso552747585a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Jun 2025 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748966110; x=1749570910; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtcrJpSnHCccFcOcWZ67zAeGy5WrzAXgNSXBhw71B5M=;
        b=VmvA3D7Blp3WOMcxgIh/7vN0lt6ruHv8R1LdwacICOSUl5jjSCIag12fpkIbz0yGnA
         /sOEPSroHFXQg8mAg8oik5JhCJ0SzMF7MPmqUBX2FdMN9xt+yuP4f61jfJUjyPggB7dK
         2Oxa/7l9VgHg/1QUwg5okCv4PX9Blxm2Q+O3Y9IgqPrDqWFwtWDKVg0LpVX4QDlDjGpb
         eqo7j06SL411KO1YqrCUI/J6g6g9lRHtC7PweJmN7MpF8VxK3FyCkYK7irzqLcA9yquP
         L8UyDIXnorsdlwvaly1jf/0FPEA3NRQikxQKvyB7Jv1A72MrtuM9SJpc85yoG/f6e1wk
         7M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748966110; x=1749570910;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtcrJpSnHCccFcOcWZ67zAeGy5WrzAXgNSXBhw71B5M=;
        b=chYXOePu4ap4OyBcU4hCsQUOEJnV+uEG/7iNWBiaKM3AnI+DfwmYVqi7Db5MOvstKX
         rK3rN+pGqJzs6oyU/8g/yHV3NBdO9r64dnVDZ5QaecMC4QgjXyYdUy9g/dvrL8+1roMK
         yaydhT2KKvRSLXFv+0QNKZwKX/C5+B4QTBQRK/PUeOoub8BNU0xVXQHggtRXSvo9VvgX
         36uGQulxdEUbZQbzrrgnjd4b3swX24EugFMpawJ927ba09YpkJJX9+zOTwyB9htWlKkB
         /1aleyvg2Pnmsxd1555cHr519b04g+tx1bUYScGLJYsZ598jE9AW2u1MztwSQyGuAV+9
         T08w==
X-Gm-Message-State: AOJu0YyhRioh/ALQJ0zyzFiSZvSAOVHR6xWMsshtMLTJLEzHculjf8/K
	TCC/Z3PE60IuSfPvsoK8noXtsG6zGMDjAVRer39eMkaPKTjyhyuRd45T86W2mE6n
X-Gm-Gg: ASbGncu/5NIKBBrqU2ofTGILzZ5LjRvUqtHkCuboIuHoVKQpHGtfaxt33f/7DM/Ppr1
	D/VXBMh/zT6sEwjYbmjoDvxOcWqsLr3t5YURXwIctOQDcI0SAofpEy7YHiksEvtfasJqQpsDYyM
	Lqtluj1fl5FmaRcoOt4HoimYWBXv/HfM3tB28oHCx/rjZgIrHJP8tsBQdDsSiG0Fb6kZMxlMCrF
	s4JuCb4E07F0o8WIi+CnOadHzkttpEUyv2bWTG2TDB4YxmaBtdH6v7+b7JsNv4aDbvfc+mTKbDF
	uGGvFK6veGzUaPMx5V5AKYW8iWwmzUnyud92qeRYpVeOL2QbWSMNm10Yj481M3uQwcGz8T6f7AF
	JorsQpRfdFf8IgvYiL8Y018ah
X-Google-Smtp-Source: AGHT+IFr6Mg69ww64nnMoh1ifYdMhJpkyYQ1X6fS020F8duxE++zQZFeHlEC5KLiQug9gjqvTH5XLQ==
X-Received: by 2002:a05:620a:1a8d:b0:7c7:a538:490 with SMTP id af79cd13be357-7d0a1f980bcmr2387369285a.2.1748966110397;
        Tue, 03 Jun 2025 08:55:10 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a385cdsm76256991cf.64.2025.06.03.08.55.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 08:55:09 -0700 (PDT)
Date: Tue, 3 Jun 2025 11:55:07 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH 1/3] refactor mesa packageconfig
Message-ID: <20250603155507.GC31087@localhost>
References: <20250530172156.7199-1-twoerner@gmail.com>
 <2c631d6e-9296-4c4e-bcf8-13add7ee8ddf@cherry.de>
 <20250603154627.GA31087@localhost>
 <1f601696-1ac4-44e3-9ab1-ada5ebb453d0@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f601696-1ac4-44e3-9ab1-ada5ebb453d0@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Jun 2025 15:55:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1613

On Tue 2025-06-03 @ 05:51:59 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/3/25 5:46 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > On Mon 2025-06-02 @ 02:39:58 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> [...]
> > > On 5/30/25 7:21 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> [...]
> > > > diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
> > > > index f22280754a14..9e9bf9afc4a0 100644
> > > > --- a/recipes-graphics/mesa/mesa.bbappend
> > > > +++ b/recipes-graphics/mesa/mesa.bbappend
> > > > @@ -1,9 +1,4 @@
> > > > -PACKAGECONFIG:append:rk3288 = " panfrost"
> > > > -PACKAGECONFIG:append:rk3328 = " lima"
> > > > -PACKAGECONFIG:append:rk3399 = " panfrost"
> > > > -PACKAGECONFIG:append:rk3566 = " panfrost"
> > > > -PACKAGECONFIG:append:rk3568 = " panfrost"
> > > > -PACKAGECONFIG:append:rk3588s = " panfrost"
> > > 
> > > It seems like this is based on my Panthor patch series but it isn't
> > > explicitly listed in the dependency of this patch series?
> > 
> > True; what's the easiest way to express this?
> > 
> 
> If you use b4, https://b4.docs.kernel.org/en/latest/contributor/prep.html#working-with-series-dependencies
> 
> Otherwise just in the cover-letter say that it depends on another series and
> then provide the link on lore.kernel.org or patchwork or wherever someone
> can get the patches :)
> 
> > > I'm fine if you
> > > want to take over my patch series, but I guess it'd make sense to have the
> > > patches (even reworked/squashed/fixed up) as part of this patch series now?
> > 
> > I was just going to add this update (whatever form it takes) immediately after
> > applying your patches. Your patches worked at the time they were submitted, so
> > I'm okay applying your patches on their own, then adding something else as a
> > separate commit.
> > 
> 
> Meh, they don't work at all anymore, so the pedantic me doesn't like merging
> patches we know are broken :) (but I'm not the one hitting the merge button,
> so that isn't something I need to worry about :) ).

I'm okay with squashing them. I'll keep your SoB line (of course).

