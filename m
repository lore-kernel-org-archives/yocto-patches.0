Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E735C27C55
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 17:23:54 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web11.20732.1717694624519825919
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Jun 2024 10:23:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BUi0uSsx;
 spf=pass (domain: gmail.com, ip: 209.85.222.178, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79524f6693dso87070285a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Jun 2024 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694623; x=1718299423; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nLKXl2MuE55LHqBFAEc30F+oyv++FIimd3kiUweKG4=;
        b=BUi0uSsxsm/hEmnkXyxxNhfm04wgFEaA0G7dGR/TSDqRG4geQmyUK6fQ5Nzjwd0BsF
         HhdYn8i+cnCgM11UKgzcGpQEos//XqkblkNKIHuMU6VItrlyqEwZMjXLIqyJxh/DHMRb
         R2n5k2cRw0uVaZFgLzHmvG+6MmmCgScP48gtOnG/uG1jSWfNx2qiGUnTqEfJR3hfgYbG
         6DwzCWzAGMS03PqRULnGfn6ICQikAC2sD5jRql6V41GpriiJH4SESgql/jjSq2HPDSex
         QXlgQotYOVdda6+nvZXmJ3bxpLaX1g24X5fGjVJyh8mYVtaS0ggGvR8fUMqnNfK9iHa1
         1Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694623; x=1718299423;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nLKXl2MuE55LHqBFAEc30F+oyv++FIimd3kiUweKG4=;
        b=azu10fK9odiq+EYAEdbFDWWG+kwKuiy1iLhv5PpsCpG1G7iCNLa1S6jrEfLtCZIlgZ
         4aJan/QwWAP/sZiq2CYvsc8pOm/iRtRQ5Q/+btTJ5eRwcv0a2d7FMhiUcG38ZuDKkXR8
         +MQm6ObJKYc3gytOkZFAze0HPDBuhV4VawORp8TPGxyQsM2eIo6h8FS3svkDwL9uTwn4
         OFwp3ZbE7uUdhKijl8kv8YX28N5RQr5kqugOzGRjlD4Q9It4d6WAdB7XhHFL41iewP6c
         J+GwyNlSV3nUzIvWC1PXVdyRx+FTKMwEQt937V0Jsy/DLmXc4HijdU2ZOoiRm/bdqc/5
         z7Fw==
X-Gm-Message-State: AOJu0YzTbiUBJ4GjZjym2iXW/Uc1epWnyh7Po8m7iOLzJ6Tukf97HIGD
	hWt8oLn1evpxu4hE11at7QX8mSLCtlVQg5htBSWUpKjzLHhqBuof
X-Google-Smtp-Source: AGHT+IHk16bkn1J8RJ/+wo33XtyHdkJO+FaAMwPpirtoi8NJwqhwRBUeTn+vFQXaolvVqDZVDKl3Ww==
X-Received: by 2002:a05:620a:1a1f:b0:792:957f:b17f with SMTP id af79cd13be357-79523fe1587mr787804685a.72.1717694623425;
        Thu, 06 Jun 2024 10:23:43 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795328139fdsm79773185a.23.2024.06.06.10.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:23:42 -0700 (PDT)
Date: Thu, 6 Jun 2024 13:23:40 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [PATCH meta-rockchip master scarthgap v3 00/16]
 various reworks around u-boot and rkbin + fixes for MACHINEOVERRIDES
Message-ID: <20240606172340.GA21374@localhost>
References: <20240531-rk3588-family-v3-0-629586621c5d@cherry.de>
 <20240605172312.GA11530@localhost>
 <8835bd6d-80a5-43d1-93be-ec5d1cfc477d@cherry.de>
 <20240606114959.GA30114@localhost>
 <0759df07-2e28-45fb-a838-10763309a463@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0759df07-2e28-45fb-a838-10763309a463@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Jun 2024 17:23:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/282

On Thu 2024-06-06 @ 03:02:42 PM, Quentin Schulz wrote:
> Hi Trevor,
> 
> On 6/6/24 1:49 PM, Trevor Woerner wrote:
> > On Thu 2024-06-06 @ 10:17:17 AM, Quentin Schulz wrote:
> > > Hi Trevor,
> > > 
> > > On 6/5/24 7:23 PM, Trevor Woerner wrote:
> > > > On Fri 2024-05-31 @ 11:25:07 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > > > This does a few reworks of how we handle TF-A and DDR bin blob
> > > > > dependencies, hopefully in a way that makes it much easier to add
> > > > > support for new SoCs without having to touch too many files.
> > > > > 
> > > > > While at it, add an SOC_FAMILY entry for rk3588s/rk3588 boards.
> > > > > 
> > > > > Additionally, make rk3308 use the PREFERRED_PROVIDER mechanism to select
> > > > > rk3308-rkbin instead of rockchip-rkbin.
> > > > > 
> > > > > Finally, fix a few MACHINEOVERRIDES ordering issues.
> > > > 
> > > > Here are the new MACHINEOVERRIDES (with these patches applied) for all the
> > > > MACHINEs we support (with rk-u-boot-env enabled):
> > > > 
> > > > 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:firefly-rk3288:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="armv7a:rockchip:rk3066:marsboard-rk3066"
> > > > 	MACHINEOVERRIDES="armv7a:rockchip:rk3188:radxarock"
> > > > 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:rock2-square"
> > > > 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:tinker-board:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:tinker-board-s:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:vyasa-rk3288:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4:nanopi-m4:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4:nanopi-m4-2gb:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4b:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:nanopi-r2s:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-r4s:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rk3588:orangepi-5-plus:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3308:roc-rk3308-cc:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:roc-rk3328-cc:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3568:rock-3a:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-4c-plus:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rock-5a:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rk3588:rock-5b:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4a:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4b:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4c:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:rock-pi-e:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3308:rock-pi-s:rk-u-boot-env"
> > > > 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:rock64:rk-u-boot-env"
> > > > 
> > > > For uniformity, would it be nicer to have all MACHINEs include the SoC
> > > > OVERRIDE?
> > > > 
> > > 
> > > I'm not sure to follow here
> > 
> > Sorry, what I mean is the "cortexa72-cortexa53" parts, which I guess is the
> > CPU? I don't know that I've seen those overrides being used often, but I would
> > rather either see all of them have this override, or none of them, as part of
> > any MACHINEOVERRIDE cleaning patches.
> 
> Ahah, this isn't something to fix in meta-rockchip (or as a temporary
> work-around if you prefer, or for non-master branches) but rather in
> openembedded-core :)
> 
> c.f. https://git.openembedded.org/openembedded-core/tree/meta/conf/machine/include/arm/armv8-2a/tune-cortexa76-cortexa55.inc#n7
> for RK3588(s).

Ah okay. Well in that case let's just leave it as-is. Like I said, I don't
know that I've seen much of anything use those overrides, and it's not
something we're using. I was just going for uniformity for what I thought was
our cleanup.

Applied to meta-rockchip, master and scrathgap branches. Thanks!

