Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9486BCD6E75
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 19:40:47 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3848.1780602038906608371
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jun 2026 12:40:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XFjnFntj;
 spf=pass (domain: gmail.com, ip: 209.85.160.170, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51788280e71so11299391cf.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780602038; x=1781206838; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BiLILD5xOxuSCmccOkZvvjXPGDopfSw9x7HvkTUekTg=;
        b=XFjnFntj18z64lHbEGWtz+OzAdu70TrRvO5mYtTw6Ybvircq5ZF0HDRWRn1wvaWyAf
         CYNLQ9IPMsm6G7tQ9pm75QRJMINytEt64qY0QQjRJMrGhnMTUdx3Q9ouuA8eJ9nUyVia
         0bEdAm6i5cdhN/Plc06CgR22cUWu5BBJyZam+v4Uhox1mq5iaziUc//WoNaoZ9Azi33t
         8/2geEe+qEFGiZvCs6CW6H4MHAKCKbPAy8lxTj2IuX8dSJNq+O8j+WxJwLD47j3+vl2U
         HUuZ8b977vw5ATm/BZ5V5LnooXWzd+PMrfY9zGAAN8GRTL/2YML7kvkMH43IBH5ri/nc
         iP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602038; x=1781206838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BiLILD5xOxuSCmccOkZvvjXPGDopfSw9x7HvkTUekTg=;
        b=OPDEC8Mk+qqKHBhU9S7EliYmhM5QodBI3W78EWfBuCch3VUtQCbQi+KrzkbeMm5Otl
         bvTBqjCoJZ7E4rfhWZRQGOM3JGuH8WxZaaCjzyWCrNUjxqzM29WF0c23CURUg+sDNIJj
         21kh9hO2FTSCt/V2R+dG3cQhgLqgYl6PFB1jrEW06P/1GGI5v0OJbAoDHtp+esIhM/Yi
         fVp/4il0iUaqHr49pHzqpR1HOgmFGbs9sU21qyMB0DMaA2stVl7RSmk49CH1iNJXFBhN
         jOoNkzlK/F8lqQqQOvNdQLGw+g+Pbx47SlWl6PVefNwGTZVG84NxCm3tYoVLe+BBSb7+
         Q4CA==
X-Gm-Message-State: AOJu0Yyw6dYlekX56tgbIfP17wRwwVJQWul9AOVfrdT9dxt7yveuoJQg
	o7DpwZQPzBMW+KvztIFkZj12zCpUxz30dD5SZGTy3ZatGW1vajOm+E7YeUC04w==
X-Gm-Gg: Acq92OEgeEMHpbgjA+UAgRuELOzOAHqsHNlBk2rdjEzO6SPnJeCCAsNHxLncVCc2hIo
	P9pgcDcHm5SQmd5QwBpsrEg1Mv+WddLaUjLhNIPqx9pAjDGndobA/2ZAC13wmK9ulZE0/l0E2wD
	J/n/fZnIqGrM+jOa4dHtdTYbB+wsF23qXmNnAzDy9sujWndmJtcfMdDQE27lPhVHI7Hf4Ud2XRj
	qBc62Bgxas2KhQ4Y4ieXjUeOlsNxXU2y/73TAqxIivufqYsgRlpXGy1uLTftB0+yFgUlI/mt4pH
	ymI8NF+AlpJ/c6RFWgl4oJnk40xLMxi6LexWjkD14mHUxKsy/JlYj9Od+m/zPA1e1gID5hVodba
	Qhpu5O7p5FMPRiFtn4vkD0p1aO0fjwg6Psv+T78JHal11r/mVynEvRgGvyh6EMWl+JBWEoOzCSX
	UlCydfzLdm5zWGj72NJKMEzDPFqcts4M+jDKWJX77N4IU+iq1fyeJYVU1yG+o3NwPrMekMgN7Tk
	CJoyKrrNquIKWo=
X-Received: by 2002:a05:622a:4c13:b0:517:8f2e:5d9e with SMTP id d75a77b69052e-51795a71833mr4360311cf.7.1780602037800;
        Thu, 04 Jun 2026 12:40:37 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd2629cesm58758916d6.41.2026.06.04.12.40.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:40:37 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:40:35 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH meta-rockchip 2/2] add support for baking
 OP-TEE OS into U-Boot proper binary
Message-ID: <aiHUs_ETeYUg9weN@localhost.localdomain>
References: <20260126-optee-os-v1-0-874261a77dad@cherry.de>
 <20260126-optee-os-v1-2-874261a77dad@cherry.de>
 <ahcOBJWhevGNqPyF@localhost.localdomain>
 <1226166b-a604-4a40-95d1-68d8d5c64d05@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1226166b-a604-4a40-95d1-68d8d5c64d05@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 19:40:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4142

On Thu 2026-05-28 @ 10:48:24 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 5/27/26 5:30 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Hi Quentin,
> > 
> > Thanks for this patch series!
> > 
> 
> Thanks for the review!
> 
> > I believe there was a little fuzz required to apply patch 1 (around the
> > -D), perhaps a v2 against the current to clean that up?
> > 
> 
> I'm assuming due to commit 9fb264d42a20 ("bsp: fix upstream TF-A deploy
> desync") already being merged.

Yes, I think so.

> > On Mon 2026-01-26 @ 03:48:30 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> [...]
> > > diff --git a/README b/README
> > > index c2697d1..f49fdb5 100644
> > > --- a/README
> > > +++ b/README
> > > @@ -222,6 +222,48 @@ Notes:
> > >   	NOTE: this variable must be set before any include/require in the
> > >   	      machine configuration file
> > > +  OP-TEE
> > > +
> > > +	PX30, RK3399 and RK3588 are all supported by upstream OP-TEE OS. By
> > > +	default, OP-TEE OS is not baked into U-Boot.
> > > +
> > > +	You can bake OP-TEE OS in U-Boot by setting:
> > > +
> > > +		RK_UBOOT_TEE = "1"
> > 
> > Is it worth pointing out this is a boolean so any of
> > "1"/"y"/"yes"/"true" or "0"/"n"/"no"/"false" will work?
> > 
> 
> Not sure it's worth the added complexity? We also don't say that for
> RK_IMAGE_INCLUDES_UBOOT_ENV, RK_RAUC_DEMO, RK_KERNEL_FITIMAGE,
> RK_OVERLAY_DEMO but we word it differently for them.
> 
> Would,
> 
> You can bake OP-TEE OS in U-Boot by enabling the RK_UBOOT_TEE variable
> boolean.
> 
> work for you?

Sounds great!

> [...]
> > > diff --git a/recipes-security/optee/optee-os_%.bbappend b/recipes-security/optee/optee-os_%.bbappend
> > > new file mode 100644
> > > index 0000000..2a5ec8b
> > > --- /dev/null
> > > +++ b/recipes-security/optee/optee-os_%.bbappend
> > > @@ -0,0 +1,19 @@
> > > +# Increase size for FDT in OP-TEE OS to the one in TF-A since v2.13 to avoid
> > > +# panics on 64+KiB FDT passed by U-Boot to TF-A to OP-TEE OS.
> > > +# Can be removed once https://github.com/OP-TEE/optee_os/pull/7687 is merged.
> > > +EXTRA_OEMAKE:append:rockchip:aarch64 = " CFG_DTB_MAX_SIZE=0x60000"
> > > +
> > > +# Disable early console by default to avoid OP-TEE OS panicking on boards with
> > > +# their UART console different from OP-TEE OS default (UART2 for rk322x, rk3399
> > > +# and rk3588(s)).
> > > +# In-tree default changes if https://github.com/OP-TEE/optee_os/pull/7688 merged
> > > +OPTEE_OS_EARLY_CONSOLE ?= "n"
> > > +EXTRA_OEMAKE:append:rockchip = " CFG_EARLY_CONSOLE=${OPTEE_OS_EARLY_CONSOLE}"
> > > +
> > > +# Enable hardware acceleration using Arm Cryptography Extensions on PX30.
> > > +# Can be removed once https://github.com/OP-TEE/optee_os/pull/7689 is merged.
> > 
> > Have these 3 merges occurred yet?
> > 
> 
> Yes.
> 
> b6c7291c246b ("plat-rockchip: increase FDT max size to 384KiB on all Aarch64
> supported SoCs")
> 763be3b08c16 ("plat-rockchip: disable early console by default")
> 74eb4d9ed3ac ("plat-rockchip: px30: set CFG_CRYPTO_WITH_CE ?= y")
> 
> All available in 4.10.0. However, meta-arm currently is still at 4.9.0. I
> don't see patches on their ML
> (https://lore.kernel.org/yocto-meta-arm/?q=op-tee) for a version bump so we
> need to keep those in for now.
> 
> I guess I can change the comment to say we need to keep this until 4.10.0?

Please do.

> At the same time, it shouldn't hurt keeping them in even in 4.10.0 or later.

Okay.

> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4082): https://lists.yoctoproject.org/g/yocto-patches/message/4082
> Mute This Topic: https://lists.yoctoproject.org/mt/117469183/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

