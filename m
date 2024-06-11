Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CD0C27C75
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 17:17:45 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web11.2263.1718126263985013090
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 10:17:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=f2d/mG8f;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-440952018fbso13246031cf.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718126262; x=1718731062; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9b+7D8pfwMqhzRvpDWxPAKZoSJqJfc2y24aE3ZsEMG4=;
        b=f2d/mG8fRGPzN33kEXbkjVuRJJAQyd0jWuc172+GVRr1q7WdWcXSRoc7oB5UCl1TV+
         pWkhsr5YNegfnDjB0SNXWh6KlhhevlWB1VW6o1hcU8OmiH5fMjkHq2QqJovQ2KmVMGDP
         3MrubB6ROsWHhza/mPBRKYaf1TH3DUPE3g14nQohBtwKbrFOLtBZxi9UJ2pO7aHSIuRT
         vHV8MkdbBY5zVct76mZUwoz+EfLjLS3KrNwwRZI/VljFQoUMCOnOgtZFjxl9KnYzcIFf
         fvw5GSX1kQ6e758uU9YwdrCRzZ9UBnTWgABFrH+bgdCuCTtLr0BOVKcyrjFAbajX3BmG
         PHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718126262; x=1718731062;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9b+7D8pfwMqhzRvpDWxPAKZoSJqJfc2y24aE3ZsEMG4=;
        b=RyvKyh/9gLKDuju4yjynJtcRd5mNRdNQUKkJYYSC1TbdreaR5NPgF9dv4D/4TW2YAo
         trIy7d/55LqooYbkO6vfWRTMBgaE9cnJRrTXxLc7roPOQ8mRPuj0n5lUcQMlbvlJ2/DL
         ubxsSUyIcSr6efs+ZsMbbCmFtD7oKLfIRDdBgB+TxH9Ruy6z/fL1/C+K5dJ6BpKpXdEJ
         MnSvDlyqb65EFF07PCSSys822FNWLcSqZ1nanDDC1ETl9rmLjyvJY8IVktu74XnxDXeL
         gTmOkxDCyyFtDWb4MbGLVlrPhh9sqkhpF7Iwv22y+me2ccx63Jup4lj5hnAmGxj43DPm
         +5ng==
X-Gm-Message-State: AOJu0Yw08ITNbsDzBlJAabryCAusO2mp8dYIMwwZ8eCESymq6K+c18kP
	U+9EH9MV5UQyFyBpXjGV44UyNVsprx+bpYGQpohIzGgyzq8FX+hIBz5aTw==
X-Google-Smtp-Source: AGHT+IGAUwELE0ka4GstsIDrqG2tsVX1tox6kwkkOXxDWWeacEYi1sbflpHt272mB5ql1HJR3fkVCg==
X-Received: by 2002:ac8:7f09:0:b0:440:5434:d59e with SMTP id d75a77b69052e-4405434d643mr130557491cf.26.1718126262126;
        Tue, 11 Jun 2024 10:17:42 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038a8c29fsm47043201cf.40.2024.06.11.10.17.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:17:41 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:17:39 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] user-selectable wic format
Message-ID: <20240611171739.GA34413@localhost>
References: <20240611141540.4209-1-twoerner@gmail.com>
 <61fc0c47-d17b-4254-832a-83c4c9d37c97@cherry.de>
 <20240611151313.GB7654@localhost>
 <c1540463-c436-480d-a71c-58b6a3125a69@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1540463-c436-480d-a71c-58b6a3125a69@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 17:17:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/308

On Tue 2024-06-11 @ 05:28:42 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/11/24 5:13 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > On Tue 2024-06-11 @ 04:31:26 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > Hi Trevor,
> > > 
> > > On 6/11/24 4:15 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > > Allow the user to choose their preferred wic image format.
> > > > 
> > > 
> > > Can you provide some use case for this?
> > 
> > In order to build a wic.xz image the build has to first create a wic image,
> > then compress it as an extra step. On a slow machine this extra step takes
> > a noticeable amount of time.
> > 
> > On my local, slow build machine I prefer wic images since it saves build time
> > not having to do the compression and since everything is local, there's no
> > over-the-internet xfer time to consider.
> > 
> > When I build using some remote, fast build machine, the extra time spent doing
> > the extra step of compressing is recuperated by the savings in transfer time
> > retrieving the image from the remote. Therefore I prefer to make wic.xz
> > images. Building wic images on remote machines would lead to very long xfer
> > times to download the image artifact.
> > 
> > If I simply do:
> > 
> > 	IMAGE_FSTYPES += "wic.xz"
> > 
> > in my conf/local.conf then MACHINEs that don't normally build wic images will
> > fail. So the only way to build wic.xz images on remote builds is to tweak the
> > meta-rockchip:conf/machine/include/rockchip-wic.inc file. So I'm always
> > carrying this tweak for every remote build that I do.
> > 
> > So I could simply modify conf/machine/includes/rockchip-wic.inc to set it to
> > wic.xz but that wouldn't suit my use-case since I could then have to tweak it
> > again for any local builds. Besides, I could never guess what preferred wic
> > version others would prefer and I don't want to be changing it every other
> > week.
> > 
> > So this patch maintains the existing behaviour completely, and when I do a
> > build on a remote machine I can simply set
> > 
> > 	WIC_FSTYPE = "wic.xz"
> > 
> > in my conf/local.conf without having to tweak the layer.
> > 
> > And if others want compression but would prefer bz2 or gzip (or whatever) then
> > then can specify it however they wish.
> > 
> > > > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > > > ---
> > > >    conf/machine/include/rockchip-wic.inc | 3 ++-
> > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
> > > > index dab61d83ed2c..eb895cd0b4ad 100644
> > > > --- a/conf/machine/include/rockchip-wic.inc
> > > > +++ b/conf/machine/include/rockchip-wic.inc
> > > > @@ -5,7 +5,8 @@ require conf/machine/include/rockchip-rk-u-boot-env.inc
> > > >    SPL_BINARY ?= "idbloader.img"
> > > > -IMAGE_FSTYPES += "wic wic.bmap"
> > > > +WIC_FSTYPE ?= "wic"
> > > > +IMAGE_FSTYPES += "${WIC_FSTYPE} wic.bmap"
> > > 
> > > Would this be a way to NOT have wic in IMAGE_FSTYPES? What are we trying to
> > > achieve here?
> > > 
> > > If so, shouldn't we also not build wic.bmap there?
> > 
> > The goal isn't to not build a wic image, the point is to allow the user to
> > specify which type of wic image (i.e. with or without compression and if with
> > compression, which one?).
> > 
> > I guess I could do:
> > 
> > 	WIC_COMPRESSION ?= ""
> > 	IMAGE_FSTYPES += "wic${WIC_COMPRESSION} wic.bmap"
> > 
> > And then specify:
> > 
> > 	WIC_COMPRESSION = ".xz"
> > 
> > in my conf/local.conf?
> > 
> 
> Thanks for taking the time to explain your use case :)
> 
> I was about to suggest this :)
> 
> Should we allow multiple values in WIC_COMPRESSION?
> 
> Also maybe it should be named "EXTENSION" instead since we have the dot in
> there?

Sounds good.

> Additionally, I don't see wic.xz in IMAGE_TYPES in https://git.openembedded.org/openembedded-core/tree/meta/classes-recipe/image_types.bbclass,
> is xz really working?

I have been using "wic.xz" in IMAGE_FSTYPES for years. Works with bmaptool
too.

> If so, why do we need to specify wic.gz and all the
> others in IMAGE_TYPES? Maybe we do not?

I guess that's for others to answer/investigate.

