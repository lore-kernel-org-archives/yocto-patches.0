Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78128C25B75
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 11:50:12 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web11.12288.1717674603609765637
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Jun 2024 04:50:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Gk5B3qSz;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ae259b1c87so15995966d6.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Jun 2024 04:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717674603; x=1718279403; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zOXfPAxGrdDpuM9FurqmxART4MEF3MH1MLZGejYuLs=;
        b=Gk5B3qSz2OhojCOXl09vdudLv937IKqw7LLBGgj+ADa0fBehQpQsaSrx3OkH/pWhrQ
         vGTx4QnPccUP7mzj0Of79/Fms3m8vIFSBAHyEULahBosvMxkykF8IeNGlIdXfQHKsHe0
         cF+ssUKBxI0NuNKEfoaT0WOjJWOCiOgoeKuN9YT9zQfm62tdDyLxOYjJRonGADkvIWo2
         OhhMSfsdeQQsOjJ+osL8Wt8fj8CjjrFdmnSZ7bYcaDOHK6oE+NQWZ2u+K379fq03hLAM
         ZTybdvfw+e4k+wKjSaKE0OdvZAwvVzAhzDrBxTp4mdzbbN+aPvDfX5bKfpBK49rczV/p
         QfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717674603; x=1718279403;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zOXfPAxGrdDpuM9FurqmxART4MEF3MH1MLZGejYuLs=;
        b=OwLjRHlyqYQvlDqTP6oymzB90QO0sG24+Wjr/EeT9olrg0PpUXx+6/kvhZvtBmMGh7
         HPcIyynJ8vD+kEL74j4icJv8B+si9fWMC2zr8R/eZ/MWEg6LjsJs94SB2uidYDreWuKu
         ny7BVX0I/Jr47HUoOBA99PQ8aRSN34bj0+4AGYIYV841IrazgB9fVovghe+ibYPOhXCr
         OZBOXOLZE615Pufk1Vas0XkXAvei0phKFvURDWpanHFvhp/XM5lBQUnootA4iE+/LCmY
         MKrZTe+zW539yUS7hdVIoYHkDDhQyrVFUa94sP8u1VwHrYf3H/xDR0mtjsi/HxpmaPup
         DAsw==
X-Gm-Message-State: AOJu0YwsuMMlX3hQy09p5wHsfjOe5m4z4AhmxfRJn/LQBRqq0sZ4g5Wd
	m/negwIsEVnT5TCasybGFMzzlYIAqqU0MVgDuKSAXz7sdW5SmA80kvsnfA==
X-Google-Smtp-Source: AGHT+IEHKkzPkiezxrl0zHG6XQd78fqrG2xiDm2YT+FODTh+T+ck5wLNRV1agdLyXRhFPi7c57I7fA==
X-Received: by 2002:a05:6214:3d8c:b0:6af:3d00:bbfd with SMTP id 6a1803df08f44-6b04c08a788mr40360196d6.27.1717674602331;
        Thu, 06 Jun 2024 04:50:02 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f718fb7sm5364666d6.62.2024.06.06.04.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 04:50:01 -0700 (PDT)
Date: Thu, 6 Jun 2024 07:49:59 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH meta-rockchip master scarthgap v3 00/16]
 various reworks around u-boot and rkbin + fixes for MACHINEOVERRIDES
Message-ID: <20240606114959.GA30114@localhost>
References: <20240531-rk3588-family-v3-0-629586621c5d@cherry.de>
 <20240605172312.GA11530@localhost>
 <8835bd6d-80a5-43d1-93be-ec5d1cfc477d@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8835bd6d-80a5-43d1-93be-ec5d1cfc477d@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Jun 2024 11:50:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/280

On Thu 2024-06-06 @ 10:17:17 AM, Quentin Schulz wrote:
> Hi Trevor,
> 
> On 6/5/24 7:23 PM, Trevor Woerner wrote:
> > On Fri 2024-05-31 @ 11:25:07 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > This does a few reworks of how we handle TF-A and DDR bin blob
> > > dependencies, hopefully in a way that makes it much easier to add
> > > support for new SoCs without having to touch too many files.
> > > 
> > > While at it, add an SOC_FAMILY entry for rk3588s/rk3588 boards.
> > > 
> > > Additionally, make rk3308 use the PREFERRED_PROVIDER mechanism to select
> > > rk3308-rkbin instead of rockchip-rkbin.
> > > 
> > > Finally, fix a few MACHINEOVERRIDES ordering issues.
> > 
> > Here are the new MACHINEOVERRIDES (with these patches applied) for all the
> > MACHINEs we support (with rk-u-boot-env enabled):
> > 
> > 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:firefly-rk3288:rk-u-boot-env"
> > 	MACHINEOVERRIDES="armv7a:rockchip:rk3066:marsboard-rk3066"
> > 	MACHINEOVERRIDES="armv7a:rockchip:rk3188:radxarock"
> > 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:rock2-square"
> > 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:tinker-board:rk-u-boot-env"
> > 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:tinker-board-s:rk-u-boot-env"
> > 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:vyasa-rk3288:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4:nanopi-m4:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4:nanopi-m4-2gb:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4b:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:nanopi-r2s:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-r4s:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rk3588:orangepi-5-plus:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3308:roc-rk3308-cc:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:roc-rk3328-cc:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3568:rock-3a:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-4c-plus:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rock-5a:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rk3588:rock-5b:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4a:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4b:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4c:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:rock-pi-e:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3308:rock-pi-s:rk-u-boot-env"
> > 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:rock64:rk-u-boot-env"
> > 
> > For uniformity, would it be nicer to have all MACHINEs include the SoC
> > OVERRIDE?
> > 
> 
> I'm not sure to follow here

Sorry, what I mean is the "cortexa72-cortexa53" parts, which I guess is the
CPU? I don't know that I've seen those overrides being used often, but I would
rather either see all of them have this override, or none of them, as part of
any MACHINEOVERRIDE cleaning patches.

