Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9383C27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 15:36:24 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
 by mx.groups.io with SMTP id smtpd.web11.11913.1718292974655568470
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Jun 2024 08:36:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l0qdtm4n;
 spf=pass (domain: gmail.com, ip: 209.85.160.41, mailfrom: twoerner@gmail.com)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2547e1c7bbeso566316fac.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718292973; x=1718897773; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wpz3SVjBzTakyyClECvTNqTKIlqlTW9XrYRuGnscqjw=;
        b=l0qdtm4nGmgljf7YQtRNJBqntD1FEX0Xg1qLOpjfZs049t6et0C2DtYqJOjGZyMJdG
         xnhx4/2hr9LuBzs6fg5BYk0ymlbo6XGIj5e8rlQCqQxEx+wkULLTSsH6DYgYEbOQc+SH
         xTmuA1tFX8vzvRBoxoe8cWzoJwmjDFpC3gJ50T/R4Ovmo4/5qDNlNyN/FEu6TeUSdqyU
         JcZ1bLV4r8sFo18r8EobNlN5ZGapVTu7iC8pbHNNwYlBUyKi9k4s002BT5eNZSLQ8UK+
         wFfiPYlECiXryqnGm1iKrG+agg40is8z6Fyj0B+Eob1geVQxxmsxI2/WQTIscFJYoNzV
         C7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292973; x=1718897773;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wpz3SVjBzTakyyClECvTNqTKIlqlTW9XrYRuGnscqjw=;
        b=w3pGcxaSDi34wFTRe0vh05e2nkmdVmSvPH5KayAr6lvck9OqLa94HIXncvdmQHtJPp
         cmeqNNzZx+6KOQB6WabJkmX/0TRbNzHuVASgDelwoi5CrYF+svWAoRiCj/pAxRI3gS+6
         /2KgR4MA6qnv3bxGfCnyVYsNo5O5HwCF0BN0AxaWptbzZhb89VWAiiSDUjjDN2R9uRf9
         FCsCrL8ZS+z45RkecptC2HveR4OKHhqFz+rz8UD9MqMO3R8OGYq44p2sCht5kQ+LfRHI
         IGEBG4AXiTjCku4VdPXqtr9OyHuKGFUhgmu4lL6GW3o8rI9s6aCFCsAMNB9reV8uRVlp
         IRkQ==
X-Gm-Message-State: AOJu0YxZdLsfsiIM6+TncaFshH1kVJ/KrD4BGrB1B9b9mUXBOZdPHcFn
	nDOiYTGnyiewNqvaUjnn3X/+kiF2WvPOhJgediRmsEKZOzYD6qt0PidDDg==
X-Google-Smtp-Source: AGHT+IFWoLJAW2pwVyJvB4E8k2byRsEa/bVzFiWI2cptRfjB4xdVY06Ehzv9fOUfB9nOzQgGAmNxrA==
X-Received: by 2002:a05:6870:1655:b0:258:39f1:96f1 with SMTP id 586e51a60fabf-25839f1a4f5mr1402720fac.25.1718292972965;
        Thu, 13 Jun 2024 08:36:12 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaee5f08sm61337385a.36.2024.06.13.08.36.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:36:12 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:36:10 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 1/2] rockchip-rkbin:
 bump SRCREV
Message-ID: <20240613153610.GA33883@localhost>
References: <20240613133544.21164-1-twoerner@gmail.com>
 <2983eb83-61b6-4ac3-b20e-41660885796d@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2983eb83-61b6-4ac3-b20e-41660885796d@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 15:36:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/322

On Thu 2024-06-13 @ 04:03:31 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/13/24 3:35 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Update to a newer release.
> > 
> > Boot tested on:
> > - rock-3a
> > - rock-5a
> > - rock-5b
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> > v2 changes:
> > - added
> > - break out the SRCREV bump and make it applicable to all builds/boards
> > ---
> >   recipes-bsp/rkbin/rockchip-rkbin_git.bb | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> > index 7929c6ac3a10..f9724ddd5cd5 100644
> > --- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> > +++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> > @@ -3,7 +3,7 @@ LICENSE = "Proprietary"
> >   LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
> >   SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
> > -SRCREV = "b4558da0860ca48bf1a571dd33ccba580b9abe23"
> > +SRCREV = "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
> >   PROVIDES += "trusted-firmware-a"
> >   PROVIDES += "optee-os"
> > @@ -42,7 +42,7 @@ do_deploy:rk3568() {
> >   	# Prebuilt OPTEE-OS
> >   	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3568.bin
> >   	# Prebuilt U-Boot TPL (DDR init)
> > -	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v1.18.bin ${DEPLOYDIR}/ddr-rk3568.bin
> > +	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3568.bin
> 
> What about using '*' like the others? e.g.
> 
> install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v*.bin
> ${DEPLOYDIR}/ddr-rk3568.bin

Wasn't it just yesterday you were advocating strongly *against* using tags for
this exact same reason? (i.e. they can move)

These components won't change unless we do a SRCREV bump, and if we do a
SRCREV bump I'd prefer to see which ones, specifically, change so they can be
explicitly tested.

> >   }
> >   do_deploy:rk3588s() {
> > @@ -51,7 +51,7 @@ do_deploy:rk3588s() {
> >   	# Prebuilt OPTEE-OS
> >   	install -m 644 ${S}/bin/rk35/rk3588_bl32_v*.bin ${DEPLOYDIR}/tee-rk3588.bin
> >   	# Prebuilt U-Boot TPL (DDR init)
> > -	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v*.bin ${DEPLOYDIR}/ddr-rk3588.bin
> > +	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin ${DEPLOYDIR}/ddr-rk3588.bin
> 
> Same here, maybe we want to keep '*' in there?
> 
> It'd be nice to put in the commit log that the binary prefix changed in
> commit https://github.com/rockchip-linux/rkbin/commit/f02d10e468d8c783c45137d230ff33d42ca670b4
> where they changed the frequency of LPDDR5 to 2400MHz to "improve stability"
> as justification in the commit log.

Good idea.

> Otherwise, looks good to me.
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Tested myself with master U-Boot on RK3588 Jaguar, compiled by hand outside
> of Yocto.
> 
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de> #RK3588 Jaguar, manual
> U-Boot compilation
> 
> Thanks!
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#320): https://lists.yoctoproject.org/g/yocto-patches/message/320
> Mute This Topic: https://lists.yoctoproject.org/mt/106651708/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

