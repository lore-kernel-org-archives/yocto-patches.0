Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F3C27C6E
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 14:23:10 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web10.12969.1718374986863763000
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Jun 2024 07:23:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FjnfrykE;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44055ca3103so11821571cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Jun 2024 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718374985; x=1718979785; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vkoamnttYB7EsC6KWLGKs3k+XX6EMmGt6+V2K2WMHAI=;
        b=FjnfrykE0SVwcKJ58Ut80aILpzPzN4RKdW86uc0XgsR0lOvRHYhVY0iZM0NQd3IlgU
         0qKIqD9p3+l9Dixi60cmywoOUNjaLbf71J4oh7J7moMGCYw40mtW9NaeKQz3rwUKKsKY
         8faCVpZU7qIt8Rm18ikVOzW1ra0ydsQ8V0MiiWXCNvogviXV1NxBGuynjdrsU0GcwZH9
         hebv+wZG3yOnwEPepcIN9G2o4NIvYKf5jPS0Aez463Buo+FkW3c/SLGGTe/UOXfKMYS+
         J3pOEhs3hiCM7oLe9KnlMhD5uHhw74LrpMfA1HxJJehCOFMFl5lmiLZjLKJ6UNaJkPYD
         e0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374985; x=1718979785;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkoamnttYB7EsC6KWLGKs3k+XX6EMmGt6+V2K2WMHAI=;
        b=gvuPsEK/093qRWEWBQ5t/q23Fn5xqwIxuJOFc8Ci2IbBY2fMUADo0fkSZTQ8W6ElEZ
         QaFcojTEZvAdNUlPlX7Vgq/usyM5IDiye+VTjlThtMxNYqLLIA3Knirb+8TTz0ZsqSf4
         2yr5jpNqzr01RqWiKcDTgbfescgLCDKuEe/yKg5DwoRIETBQ/h9f8XHBMxh8e4pRXaMK
         uWAvfJ86hmkdAp9ESetfH1ml8K67ge5c4hgf6fLss6tA1m5OLzU62eAIkXy4W/4edgjv
         kR037sjrIn2hpljx1ETflHaI9uWOOGWUCALWO631KbkEEV37IDSp0y5YZtz7w74agWqi
         xSNg==
X-Gm-Message-State: AOJu0YxbFgG2/zxzCQL7AoRUVi4WeTw1+roFHTGRM2rKv7hUX03u5auf
	8kZXypQYiiRwhjjpKls9DSWY1RvaKZcUDxEAuOeNfUELyE0681O39EZACw==
X-Google-Smtp-Source: AGHT+IFfan5RNo2YOEAQ3kie5ZUPYVAfkx3OEK+BA+WSBLsd+yyPM4Zhf4PRP3pwKHU2hz2LsT1L9Q==
X-Received: by 2002:ac8:7dd3:0:b0:440:5e34:c011 with SMTP id d75a77b69052e-44216b4517emr40669001cf.60.1718374985026;
        Fri, 14 Jun 2024 07:23:05 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4420f96efbbsm14886341cf.54.2024.06.14.07.23.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:23:04 -0700 (PDT)
Date: Fri, 14 Jun 2024 10:23:02 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v3 3/4] radxa-zero-3w: add
Message-ID: <20240614142302.GA8715@localhost>
References: <20240613170154.6441-1-twoerner@gmail.com>
 <20240613170154.6441-3-twoerner@gmail.com>
 <7753f6f6-209c-44fa-91b9-9e8ff2be7b8f@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7753f6f6-209c-44fa-91b9-9e8ff2be7b8f@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Jun 2024 14:23:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/331

On Fri 2024-06-14 @ 10:58:41 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/13/24 7:01 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > The Radxa ZERO 3e is an ultra-small, high-performance single board computer
> > based on the Rockchip RK3566, with a compact form factor, and rich interfaces.
> > 
> > 	http://radxa.com/products/zeros/zero3w/
> > 
> > tech specs:
> > - Rockchip RK3566 (4x Arm Cortex-A55 @ 1.6GHz)
> > - Arm Mali-G52-2EE (OpenGL ES 1.1/2.0/3.0/3.1/3.2, Vulkan 1.1, OpenCL 2.0)
> > - LPDDR4 RAM (1/2/3/8 GB)
> > - µSD
> > - optional onboard eMMC (8/16/32/64 GB)
> > - IEEE 802.11 b/g/n/ac/ax(WiFi6), BT5.4 with BLE
> > - 1x USB 2.0 Type C OTG, 1x USB 3.0 Type C Host
> > - 1x µHDMI (1080p @ 60fps)
> > - 1x MIPI CSI camera port
> > - colour-coded 40-pin GPIO (uart, spi, i2c, pcm/i2s, pwm, gpio)
> > - 72mm x 30mm
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> > v3 changes:
> > - new
> > ---
> >   README                                          | 1 +
> >   conf/machine/include/radxa-zero-3.inc           | 6 ++++++
> >   conf/machine/include/rk3566.inc                 | 1 +
> >   conf/machine/radxa-zero-3e.conf                 | 7 +------
> >   conf/machine/radxa-zero-3w.conf                 | 7 +++++++
> >   recipes-bsp/u-boot/u-boot_%.bbappend            | 6 +++---
> >   recipes-kernel/linux/linux-torvalds-next_git.bb | 2 +-
> >   7 files changed, 20 insertions(+), 10 deletions(-)
> >   create mode 100644 conf/machine/include/radxa-zero-3.inc
> >   create mode 100644 conf/machine/radxa-zero-3w.conf
> > 
> > diff --git a/README b/README
> > index a9a040a4308d..909840de2c0d 100644
> > --- a/README
> > +++ b/README
> > @@ -41,6 +41,7 @@ Status of supported boards:
> >   		rock-3a
> >   		rock-4c-plus
> >   		radxa-zero-3e
> > +		radxa-zero-3w
> >   	builds:
> >   		marsboard-rk3066
> >   		radxarock
> > diff --git a/conf/machine/include/radxa-zero-3.inc b/conf/machine/include/radxa-zero-3.inc
> > new file mode 100644
> > index 000000000000..1cdcaa2214fa
> > --- /dev/null
> > +++ b/conf/machine/include/radxa-zero-3.inc
> > @@ -0,0 +1,6 @@
> > +require conf/machine/include/rk3566.inc
> > +
> > +PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
> > +MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
> > +
> > +UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
> > diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
> > index 586d68806df6..64d47c004a1f 100644
> > --- a/conf/machine/include/rk3566.inc
> > +++ b/conf/machine/include/rk3566.inc
> > @@ -5,6 +5,7 @@ DEFAULTTUNE ?= "cortexa55"
> >   ROCKCHIP_CLOSED_TPL ?= "1"
> >   require conf/machine/include/soc-family.inc
> > +MACHINEOVERRIDES .= "${@bb.utils.contains_any('MACHINE', 'radxa-zero-3e radxa-zero-3w', ':radxa-zero-3', '', d)}"
> 
> No need to pollute the rk3566 with this, I assume you could simply add:
> 
> MACHINEOVERRIDES =. "radxa-zero-3:"
> 
> in conf/machine/include/radxa-zero-3.inc
> 
> similarly to what's done in https://git.yoctoproject.org/meta-rockchip/tree/conf/machine/include/rock-pi-4.inc
> ?
> 
> Or is this somehow messing up with the MACHINEOVERRIDES order?

For some reason i wanted:

	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3566:radxa-zero-3e:radxa-zero-3:rk-u-boot-env"

but you're right, it should be:

	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3566:radxa-zero-3:radxa-zero-3e:rk-u-boot-env"

I adjusted it and pushed the whole series to the master branch.
Thanks!

