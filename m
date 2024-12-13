Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479BCE77180
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 17:11:18 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web10.586.1734109867974659409
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 09:11:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DR4NYWxq;
 spf=pass (domain: gmail.com, ip: 209.85.222.174, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6edb82f85so244049085a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 09:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734109866; x=1734714666; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=450Go0kJhUjnuZ6ig0BPqFowsr/C3PX4vAOjpb2+YEo=;
        b=DR4NYWxqnE9eFbmaUbmmIOkCivkABUNhheJgAGyRYjAvfrx0ACb28+n7bjktsEdXk+
         baEgTBf5pCB6IJpbWCaPTwLVC+SZm5/jQP55b1/Yo4LU1ZTEy26yeIcPz+fV2RJI0C2o
         FiHZ1/EnzJngXJkUloAt9LmjVVNvPanAF+/KJ0ARzPSSnQgz2xWUi69KCIYYZoATM1xK
         +NEKG3RsHS8lxVmKODR3QoFK8nk8ydgHWFg2IR2lnA9mNR3cod28w6MKYyJdA4iZn17c
         gGCtwCSSjg3daivBuFHTllbHWIQbJ9MGl/aw+LapPY67BmXle7SX58zl7HGt4jVJLo7H
         Gcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734109866; x=1734714666;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=450Go0kJhUjnuZ6ig0BPqFowsr/C3PX4vAOjpb2+YEo=;
        b=Kenedg3ml2iT4wG9Fhm4tjjaaXd6QrWhg15D0bqk7KGmmGJWyAUGzIXVz8cCQYRx1m
         Q08U01GRZgP2pjZO9khdlUZ86odurzL7pBegRa0+MZscF/cUWIxfPc/xKS1jYRSTcSEb
         x54hELUPTG0nUm3RytcXtmZA7V5EnK2AgxN3PM/+nZON15yj8/dJlLNyclWy9lAH62Cw
         wseFA608ivVuyfXBptNcSL0cUHPkXxzasOntkLTdr257BCpBYK8ZGeOJ3U61UfEYUd5G
         2eDoUF8tbg/bUiOaM1HSRQ+aBEwUgUpipX4xHeTGKsz0WTzQ78IgAWILfGfos/a5e4Yv
         vL6w==
X-Gm-Message-State: AOJu0YwFRAqWfxoai+OgAFYNmmixokovo7sQEPA3PfwyrGrP/G1za/Uj
	Q4EZlGpLoHPtSZQNBFPh9S7gGq/LakTx/8+VF5uj9NUugkNlsrPslR/ZGw==
X-Gm-Gg: ASbGncuwmCG3PfOUoYNY+xlhviy1CvWntSg3pR9pgzFy6eX5aqKRJU7ZQoKfuG2XPTN
	D3iXciHKUq89tg145Jq9zHG0utdwxhhKGC8tA+Fyr+NFOuEIxkjY5JotSh+VvY0kBdTvzivff7W
	WfNxSPJarn3AFMPG/eu5RFiBJDvphK8WdFyu+g4U9JFX2dCHJ/RctrYPYzzzQWxkC+g1YmC2tDr
	t1rNpM1Hr0ggLX2lNaFNH3ObdsbvRD2EYRPzzwfiaI6nnjJ8Bg60jhrmAUxkXfXI9miY++YyrPO
	5gLroOGI
X-Google-Smtp-Source: AGHT+IEfj7dTEqtUrDja/DPSrWkITJLLXJDWLXnpVSxHwSiebK8kIbjLJ/qKqmIzhmhtORRhkbBsZw==
X-Received: by 2002:a05:620a:7186:b0:7b6:d1f6:3e0 with SMTP id af79cd13be357-7b6fbee8984mr437089585a.22.1734109864797;
        Fri, 13 Dec 2024 09:11:04 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6f9046e3esm112292785a.90.2024.12.13.09.11.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 09:11:03 -0800 (PST)
Date: Fri, 13 Dec 2024 12:11:02 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 4/4] rk3308: add
 provider for trusted firmware-a
Message-ID: <20241213171101.GA1423@localhost>
References: <20241213154843.27592-1-twoerner@gmail.com>
 <20241213154843.27592-4-twoerner@gmail.com>
 <ed3585bd-ad2b-4473-987a-3d366aa3946d@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed3585bd-ad2b-4473-987a-3d366aa3946d@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 17:11:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/906

On Fri 2024-12-13 @ 05:28:40 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 12/13/24 4:48 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > A PREFERRED_PROVIDER entry was missed for rk3308 builds:
> > 
> > 	NOTE: Multiple providers are available for trusted-firmware-a (rk3308-rkbin, rockchip-rkbin-tf-a)
> > 	Consider defining a PREFERRED_PROVIDER entry to match trusted-firmware-a
> > 
> > This allows the RKBIN_RK3308_LATEST knob to work in all cases again.
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> > changes from v1
> > - added
> > ---
> >   conf/machine/include/rk3308.inc | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
> > index 1ecf085cd5de..d30901f15b4f 100644
> > --- a/conf/machine/include/rk3308.inc
> > +++ b/conf/machine/include/rk3308.inc
> > @@ -19,6 +19,7 @@ KERNEL_IMAGETYPE ?= "fitImage"
> >   UBOOT_SUFFIX ?= "itb"
> >   UBOOT_ENTRYPOINT ?= "0x06000000"
> > +PREFERRED_PROVIDER_trusted-firmware-a = "${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin-tf-a', 'rk3308-rkbin', d)}"
> 
> PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
> 
> Should be enough I believe, and it would be consistent with rk3566, rk3568
> and rk3588s where we already have that.

This fails when RKBIN_RK3308_LATEST is not defined:

	ERROR: Multiple .bb files are due to be built which each provide rockchip-rkbin-tf-a
	  /scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
	  /scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb
	A list of tasks depending on these providers is shown and may help explain where the dependency comes from.
	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb has unique dependees:

	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb has unique dependees:

	It could be that one recipe provides something the other doesn't and should. The following provider and runtime provider differences may be helpful.
	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb has unique provides:

	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb has unique rprovides:
	  ^rockchip-rkbin-tf-a-locale-.*
	  rockchip-rkbin-tf-a
	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb has unique provides:
	  rockchip-rkbin-optee-os
	  rk3308-rkbin
	  rockchip-rkbin-ddr
	  optee-os
	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb has unique rprovides:
	  rk3308-rkbin
	  ^rk3308-rkbin-locale-.*
	ERROR: Multiple .bb files are due to be built which each provide trusted-firmware-a:
	  /scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
	  /scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb
	A list of tasks depending on these providers is shown and may help explain where the dependency comes from.
	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb has unique dependees:

	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb has unique dependees:

	It could be that one recipe provides something the other doesn't and should. The following provider and runtime provider differences may be helpful.
	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb has unique provides:

	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb has unique rprovides:
	  ^rockchip-rkbin-tf-a-locale-.*
	  rockchip-rkbin-tf-a
	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb has unique provides:
	  rockchip-rkbin-optee-os
	  rk3308-rkbin
	  rockchip-rkbin-ddr
	  optee-os
	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb has unique rprovides:
	  rk3308-rkbin
	  ^rk3308-rkbin-locale-.*


The way I suggested builds in all cases, and runs fine both ways too.

> Anyone requesting trusted-firmware-a would get rockchip-rkbin-tf-a. When
> that happens, BitBake will check PREFERRED_PROVIDER_rockchip-rkbin-tf-a and
> pick what it should.
> 
> By having the suggested implementation, it would technically be possible to
> have someone request trusted-firmware-a to be rk3308-rkbin and
> rockchip-rkbin-tf-a (the provider) be rockchip-rkbin-tf-a (the recipe).
> Basically, we use a knob where there's no need to.
> 
> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#905): https://lists.yoctoproject.org/g/yocto-patches/message/905
> Mute This Topic: https://lists.yoctoproject.org/mt/110099069/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

