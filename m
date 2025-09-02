Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A057CA0FFE
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 12:20:58 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web11.75936.1756815651221876269
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 05:20:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=b6AJ43Cv;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b326b6c189so30295961cf.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756815649; x=1757420449; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qI3VjqWWrE7bsp95Jn54tkHTdUtbGExPqX4AVe/doW4=;
        b=b6AJ43CvqXK3Yytpcko0hhaWAliSWLFjLvYZsEJHIet8YD6P6pC0cvtG5FkKXR9Yox
         PeS4TiAhrv2NFc32UvL7LhDXzfeqjHlMIJj7rTOkAE405rorsBch7gwa74lCHKZuhLSo
         W9Ob+Ema7He/3tw13GcoCJD62rYgCZ5moVkN6uUwgts6WXsuHeMppXUGKPaLfRtovBe9
         qgOUXnBbmtBMYrAJK6D70otoCz9gI6c9gI7/0s5gWk0yplEgmbiKqN3EYs2JIO3KRrpZ
         69CjFDA0ZCT+EoPWGPXZ2g25gKWy2tReXMDETWn7RUD/iOawHDYaIOoW3iyw455cy96q
         02ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815649; x=1757420449;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI3VjqWWrE7bsp95Jn54tkHTdUtbGExPqX4AVe/doW4=;
        b=PlCBXRklOfazSBwnBy4jae/lTYXLLk9HPXphoNCS0IoTgstClYZmmGD9UIBmProZ9Q
         BvME+831Bj3So12J6xpVEGL5bdab2t5YoxQwZ6q89opcEMD9hEDMjQ7FHQ3Dr3S+xASm
         Qt/+zl4wD7KBx/4IexJUAPOaQt6n0mJt5uUULnuHKEGObJezvpq5dyy3DOE+u4H89YjA
         TGFwKUc3N4KTMRhvJhUvYjw6H5J6LlLRLorGa7Pyha8PAJqItsNThl91oPKiomY/k7Zc
         Hty0AInPKxFcHq5nNRvrnCYt6/n10kfRIXehxee0dp8MdQ1oVpszS4n2o6M2BQR6bZCA
         yLFQ==
X-Gm-Message-State: AOJu0Yw/WRVftshzJCZFtv8ayY3AUSTe6O50kWUVmrLIEYw0EshZDky9
	yYJ9rla/LkbB28hPBPoJeoai4zRm6hC5dTK26Hg09SlERF9nP+NEp64YiTWRwg==
X-Gm-Gg: ASbGncuUHfekKbagtdK6sBLzJxfxzfnyDVWJuAPpzB22cmn8YCTeCE5GdzUQqmYUDtq
	iM//NvTHbns1xq9cx09rLX9k4MMeG/tsfmWuLL+Od96lDR617xhMoIvnM42UIodvVF0PNPyd9VK
	5eJ1E2wdwww58JbT1zR40xDcGsLU0//3x+Tlvg/Ncc5D3SSrSwEDt/Ub66CMXqxVpIu6QQzK6a2
	gSm9/1t92dttmKCJBSPtP6o0gkXV8Imc1VR+o+KO+nnJnQdmCb7em0IutxhHF4lsnqXR07/UNTJ
	UX7QXhKrF+E3DhVtY9hrhDFZf+Lb5crWjWCyYFyLxOMSekGhQU0Y7IgB5Dr7L6fuWovTN57rE+l
	0SKAjdmShmPBe7qH3Oq/6TnrJ01CQiT1qKLIFDF37WJVPDGuq4QTWCdY/E+735maK4V9jNf8=
X-Google-Smtp-Source: AGHT+IEsy0d0+Yt8dXwOK2CgvKhw0iDbh5qxdB4Jqm6d9+mslpr6KobSgPcPtSNpL65i28VkuaEwQQ==
X-Received: by 2002:a05:622a:1353:b0:4a9:c8e3:a38 with SMTP id d75a77b69052e-4b31da0222emr110158981cf.30.1756815649083;
        Tue, 02 Sep 2025 05:20:49 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b346323447sm10879711cf.47.2025.09.02.05.20.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:20:48 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:20:46 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 4/4] nanopc-t6: use non
 -dev kernel
Message-ID: <20250902122046.GA35430@localhost>
References: <20250831114105.27494-1-twoerner@gmail.com>
 <20250831114105.27494-4-twoerner@gmail.com>
 <46735879-98bb-482c-b3d4-7e1532cfa271@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46735879-98bb-482c-b3d4-7e1532cfa271@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 12:20:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2107

On Mon 2025-09-01 @ 01:49:24 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 8/31/25 1:41 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Now that 6.16.y is the preferred version of the linux-yocto kernel, the
> > nanopc-t6 machine that had been using the linux-yocto-dev kernel can be
> > switched to using the linux-yocto kernel instead.
> > 
> > NOTE: keep the various pieces of linux-yocto-dev infrastructure in place
> >        so it can be used more easily again should it be needed
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   conf/machine/nanopc-t6.conf                   | 1 -
> >   recipes-kernel/linux/linux-yocto-dev.bbappend | 4 +---
> >   recipes-kernel/linux/linux-yocto_%.bbappend   | 1 +
> >   3 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/conf/machine/nanopc-t6.conf b/conf/machine/nanopc-t6.conf
> > index 5ed413d1c0e5..8d524bd764f6 100644
> > --- a/conf/machine/nanopc-t6.conf
> > +++ b/conf/machine/nanopc-t6.conf
> > @@ -5,7 +5,6 @@
> >   require conf/machine/include/rk3588.inc
> > -PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-dev"
> >   KERNEL_DEVICETREE = " \
> >       rockchip/rk3588-nanopc-t6.dtb \
> >       rockchip/rk3588-nanopc-t6-lts.dtb \
> > diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
> > index 6f4981fe29e6..e06c8a4f717d 100644
> > --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
> > +++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
> > @@ -1,5 +1,3 @@
> >   FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
> > -COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
> > -
> > -SRC_URI:append:nanopc-t6 = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
> > +SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
> 
> Shouldn't we have SRC_URI:append:rockchip here instead to avoid adding it
> when building non-Rockchip boards while having meta-rockchip layer included
> in bblayers.conf?
> 
> Same remark for the existing SRC_URI:append in linux-yocto_%.bbappend.

Okay, I'll send a new series for this shortly.

> Otherwise looks ok to me!

Hmm... you have not provided any sign-off tag. Did you want to?

> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2101): https://lists.yoctoproject.org/g/yocto-patches/message/2101
> Mute This Topic: https://lists.yoctoproject.org/mt/114989087/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

