Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87026C2BA15
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 12:20:53 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web10.19552.1718799649425115379
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Jun 2024 05:20:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XapELzLY;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44056295c8cso31033511cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718799648; x=1719404448; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LwO5FTk9GSbActXjUX4qGgFU/NwFA9PMmBKNuW/Uaw=;
        b=XapELzLYPLvSty1MwG0+M7TKGFfiUKUf6pugivT7VE6rc7xo7fF8d/1u8uWYljuMRx
         uPruhEbL0FXzAXQD539WhCvhSeb1u9YR92/hsqpscJrET6NtNNZq8LdV/8Lhy8EOb81c
         bis0XDbBXykxXHqFQ3vD+Kz/V2T1IvNZtUHD8hyjfhtaPVUuk4wIQ0UNQLJrzf2kU22w
         ofCxG6WunFQKShaKM9pq1KqGHSiPatH6S68sxCLqUWieHq8GrGMp2MiPZ0hmXmBq1mwa
         DPfLdfxa6Ua1wiIf/FKRJUMN5E4vfL9zf9ytwW1A2vlOAz8vqwESaD5jt0fZKQWUx2RS
         XSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718799648; x=1719404448;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LwO5FTk9GSbActXjUX4qGgFU/NwFA9PMmBKNuW/Uaw=;
        b=mH36173qIWx5hurMjqgtXNZjHIprQIECxA9qv6+Xrwf258ZPEQkGBvZp+umwWjtLJD
         niecvmUtm2w9miSNOE9ucxNa6AcnGiSI9HfWrOQbX3cHtBt1Heb5jft5vfE9fYv5lS09
         eE4Rzc94OskcAyFsa0gckT+ih2EsDDZbox1eWyfnUyiC0cxqiLEcttCRCjQKXBhkfsXA
         FFMxdYTP0fPHbhqTDG7SXOijONr7+RamfXMhRo2UxOabJHwpb8PHP3w4bNBAJR6slq9F
         ikMyoLxgWglIqbmDZ3Oa4RRj/4Ba/t+jTUNd2qwD6YKJB+20f3lqY4hRFv1o15LeRdiQ
         EJdA==
X-Gm-Message-State: AOJu0YxeH3/uGga4RW5qXzrWI2es73cGhsuMBOKxt4IpOHL8TNdnuvL9
	piDojK20SphQNlkmGOg2ZYQ50/29f2GAxUisIKf9QcHPJ877VfHgYKhljA==
X-Google-Smtp-Source: AGHT+IEhDUMw6rgxmNi31d+QCsOQu2dCbJTvBo87dvIY0NLoYmlO7m/5f8p71u+uiFQfWPi1rb0Yrw==
X-Received: by 2002:ac8:5dd0:0:b0:43a:f1c7:4491 with SMTP id d75a77b69052e-444a7a6e01amr25272211cf.61.1718799647619;
        Wed, 19 Jun 2024 05:20:47 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fcc2a2sm65272801cf.72.2024.06.19.05.20.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:20:46 -0700 (PDT)
Date: Wed, 19 Jun 2024 08:20:45 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 4/4] rauc demo: add
Message-ID: <20240619122044.GA18676@localhost>
References: <20240522230808.14409-1-twoerner@gmail.com>
 <20240522230808.14409-4-twoerner@gmail.com>
 <87a55431-aad6-44e5-a897-2b98f9bc77d2@cherry.de>
 <20240619045259.GA6665@localhost>
 <f08a3f8d-2928-4a00-8671-09f991ab55f0@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f08a3f8d-2928-4a00-8671-09f991ab55f0@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 12:20:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/353

On Wed 2024-06-19 @ 01:55:59 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/19/24 6:52 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> [...]
> > > > diff --git a/classes-recipe/rk-rauc-demo.bbclass b/classes-recipe/rk-rauc-demo.bbclass
> > > > new file mode 100644
> > > > index 000000000000..25e105b53d09
> > > > --- /dev/null
> > > > +++ b/classes-recipe/rk-rauc-demo.bbclass
> > > > @@ -0,0 +1,8 @@
> > > > +inherit features_check
> > > > +
> > > > +REQUIRED_DISTRO_FEATURES += "systemd rauc"
> > > > +REQUIRED_MACHINE_FEATURES += "rk-u-boot-env"
> > > > +
> > > > +# 'RK_RAUC_DEMO' indicates the user wants to use the
> > > > +# rauc demo configuration from this layer
> > > > +OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"
> > > 
> > > This very much smells like we should have a DISTRO for this instead no? What
> > > made you decide to go for a class?
> > > 
> > > Also, why is here and also in the global class just below? This should be in
> > > the global class only to apply to all recipes?
> > 
> > I want the build to fail if the user doesn't enable "rk-u-boot-env" in
> > MACHINE_FEATURES; you can't do RAUC if you can't save the U-Boot environment.
> > Second I want the build to fail if the user doesn't specify "rauc" in
> > DISTRO_FEATURES; the RAUC layer doens't work unless this is enabled. Therefore
> > I want to do a features_check somewhere, and the way features_check is
> > implemented means you need a class (?), specifically you need a classes-recipe
> > bbclass.
> > 
> > If you do a features_check in classes/ it will fail because feature_check is
> > is oe-core's classes-recipe and it won't be found from a bbclass in classes/.
> > Perhaps I did it wrong, but this is what I found.
> > 
> > Secondly if you look in meta-rauc you see that they're using a similar class
> > mechanism for the "rauc" override, is that not a common idiom? I'm simply
> > following that example with meta-rockchip's "rk-rauc-demo" override. If
> > there's a better way I'm happy to try it.
> > 
> 
> Can you point at some files? git grep OVERRIDES and git grep features_check
> returns nothing in the master branch of meta-rauc, so I probably am not
> looking in the right places or with the right terms.

Oops, I meant meta-rauc-community, and I was referring to just the overrides
thing, not the features_check thing:

https://github.com/rauc/meta-rauc-community/blob/master/meta-rauc-raspberrypi/classes/rauc-integration.bbclass

> [...]
> > On the other hand, if you're trying to understand what the partitions are and
> > what's available where and with what options, isn't /etc/fstab the first thing
> > you look at?
> > 
> 
> I run `mount` on my running target :)
> 
> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#350): https://lists.yoctoproject.org/g/yocto-patches/message/350
> Mute This Topic: https://lists.yoctoproject.org/mt/106253218/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

