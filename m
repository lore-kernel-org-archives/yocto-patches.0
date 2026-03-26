Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB09C10AB832
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 23:36:07 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.61202.1774568158015862052
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Mar 2026 16:35:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dix/sLbz;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89cc797547fso16918726d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 16:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568156; x=1775172956; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtfZCHu8O3MhpiWXppKw63VTAXEmImP05UcOm6JO5fs=;
        b=dix/sLbzXGRvy2t0Ox28Aj+VrhjipZLB8UrCgWBPChT82avXB1y+aPkTbAq3bCiHnJ
         vm9XLG7Tj6+pvY+9baa8WzCgCcNMWYBSLPwlJ4dKIxvCzeXFpWUjMC9TvhxWXNlKYosP
         2SEx9fMXcU2RTMplkQANMqJ2xsjwoT1js+fq4bt7sAuHBgyrkQgomJaQoC8k8ElAhMqM
         D8w0Ppyhyf16tiTgF9cn0Wczc/Fl/eIN1WRWS68GfxzolkurmBJQ6iAesq7CaIyUrMiA
         LAh00/H/0dHZdIw1msf34lB7TzcdlzKQsmHjRlN5Wf3S2uU8R4COhCVCzO7GadRRV002
         eXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568156; x=1775172956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtfZCHu8O3MhpiWXppKw63VTAXEmImP05UcOm6JO5fs=;
        b=SuSjw2iHYTstlWx0A8GxtV9hct36Bbndzu6lLGaWJM4mMhI6lElFRZHeaZ62SQ7sgK
         E1J6WF1HY89qE3WLF5kKBzpM+C+elQP5rAKYCdTQsZTAoHR/y150aBhfLo/0Z+EeSYtW
         LyUX6o4a62829PKLnf2+Gp5bardxzQ8SnG9MyzWW82Ydnlvq9eszPgZnwnsLrbG5Zj9Y
         dVTBftQkYzyjZXoHiDR5e1i9m9CBD8YMnlGihRjDfWXq/F+P4yTYegrhx4fDbeFU1SWM
         NfnRvzNIr5Gj0BKq3xScdNee8qX0WMLVoLPJXnpTzGB3EIvlGypqzaB81w0RIkZoWdO7
         r0pQ==
X-Gm-Message-State: AOJu0YxezghBtqMaj0s5Fgsakm6spFO0MSArU8bJ/nl9j8aZqpRqQdW4
	PgG5+eBTGCe9GPhpKKjYDFLbdWSkL9u9MH8RfqKKQfSn6k9f+pG04WOw6MEi/w==
X-Gm-Gg: ATEYQzxJoBlzLioJzCa5FWuE71mhAsX9a7XB5UCniDf9GV2EMepOrceskI5ULt2jbHO
	LjCNEGxGUdXtKqCZ5Pisdy8eYMRMA+16VEiEaC7XPAnhB6dk10XGyV1irwOo7DVQ8n4kT1Z4vr2
	2tLMIaq+zXhf+k5+plA5ALaIZu1cS5LqpnkktKtCELmOJxkrt7OiwScha9tPlDCy2iTlYy/aJEP
	a0uX0PCSbcBiQJMblw6TcZZL+tOTG0SzdnHMMM+oXDOlSL0XvMzSnzLJkscij2vtXBrv8TPWJ2W
	DTY1Kb9Nwq9VBCY3GikTU53UUWGFQE3CbKT27Dv4yFvAPqjAypf3m1uqdWIchkqKHEV+J8J/m8p
	BE6ktFfCzTZoNcYaBkp7wfQWJ+hohB/yxWgUUlllJ+1c34qlpuPP6rwxVYHWmSXWGIYp1102d5I
	R+Y7P/xMpR+KNAT191JaMBMnH9glBsLIER1b+qJVKnmVpEzJtzY+zXB5ZaOIqWO7WNOw==
X-Received: by 2002:a05:6214:1d29:b0:89c:8b08:75cc with SMTP id 6a1803df08f44-89ce8d9bfa4mr4366616d6.25.1774568156486;
        Thu, 26 Mar 2026 16:35:56 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5aa36f5sm34284286d6.46.2026.03.26.16.35.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:35:54 -0700 (PDT)
Date: Thu, 26 Mar 2026 19:35:53 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] add kprobes for 32-bit
 kernels
Message-ID: <acXC2URDoReamW1S@localhost.localdomain>
References: <20260326130653.478746-1-twoerner@gmail.com>
 <c653ec1d-4cfa-493d-9a12-37910a9e4937@cherry.de>
 <CADkTA4OA8=8WU8uNWBt0cQoXH6qrKfJ_XGTszgG3BoqZ6jq=yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkTA4OA8=8WU8uNWBt0cQoXH6qrKfJ_XGTszgG3BoqZ6jq=yw@mail.gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 23:36:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3561

On Thu 2026-03-26 @ 04:08:16 PM, Bruce Ashfield via lists.yoctoproject.org wrote:
> On Thu, Mar 26, 2026 at 10:08 AM Quentin Schulz via lists.yoctoproject.org
> <quentin.schulz=cherry.de@lists.yoctoproject.org> wrote:
> 
> > Hi Trevor,
> >
> > On 3/26/26 2:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > While building the modules for linux-yocto for 32-bit machines, the
> > > following error occurs:
> > >
> > >       | probes/Kbuild:236: CONFIG_KALLSYMS_ALL is disabled, therefore
> > probe "writeback" is disabled. Rebuild your kernel with this configuration
> > option enabled in order to trace this subsystem.
> > >       | wrapper/kallsyms.c:20:3: error: #error "LTTng-modules requires
> > CONFIG_KPROBES on kernels >= 5.7.0"
> > >       |    20 | # error "LTTng-modules requires CONFIG_KPROBES on
> > kernels >= 5.7.0"
> > >
> > > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > > ---
> > >   recipes-kernel/linux/linux-rockchip.inc | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/recipes-kernel/linux/linux-rockchip.inc
> > b/recipes-kernel/linux/linux-rockchip.inc
> > > index 6c62e849834c..4e67ff14f6e6 100644
> > > --- a/recipes-kernel/linux/linux-rockchip.inc
> > > +++ b/recipes-kernel/linux/linux-rockchip.inc
> > > @@ -34,5 +34,8 @@ COMPATIBLE_MACHINE:soquartz = "soquartz"
> > >   SRC_URI:append:rockchip = "
> > file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
> > >   SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
> > >
> > > -KERNEL_FEATURES:append:rockchip:arm = "
> > bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> > > +KERNEL_FEATURES:append:rockchip:arm = " \
> > > +    bsp/rockchip/remove-non-rockchip-arch-arm.scc \
> > > +    features/kprobes/kprobes.scc \
> >
> > This is coming from the yocto-kernel-cache as far as I could tell. It's
> > only available if the recipe actually points to it and only linux-yocto
> > recipes do that. linux-mainline and linux-stable from
> > meta-linux-mainline which you've said in the past you're using sometimes
> > do not support that from a cursory look.
> >
> > What happens if there's a KERNEL_FEATURES that isn't found?
> >
> > Maybe we should have this in some linux-yocto bbappend instead? Or
> > import this fragment into meta-rockchip (the downside being we need to
> > maintain this on our own then, but it's been updated only once, 8.5y ago
> > so not too much risk for this one I guess.
> >
> 
> or just do what meta-virtualization does. See the yocto-cfg-fragments
> recipe.
> It makes the fragments available to anything using linux-yocto
> infrastructure,
> but for whatever reason doesn't have meta on it's SRC_URI

I get the feeling this isn't a rockchip-specific issue necessarily. Are
linux-yocto kernel builds for other 32-bit (probably Arm) machines
seeing the same thing? Is this something I should be looking to solve
more broadly?

> 
> Bruce
> 
> 
> 
> >
> > Cheers,
> > Quentin
> >
> >
> > 
> >
> >
> >
> 
> -- 
> - Thou shalt not follow the NULL pointer, for chaos and madness await thee
> at its end
> - "Use the force Harry" - Gandalf, Star Trek II
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3560): https://lists.yoctoproject.org/g/yocto-patches/message/3560
> Mute This Topic: https://lists.yoctoproject.org/mt/118517725/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

