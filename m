Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302F3E7717D
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 13:25:23 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web11.15166.1734096316129655195
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 05:25:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VKkY/M5o;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46753242ef1so25775401cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 05:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734096313; x=1734701113; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFaJEJCATIofSallbqw9was2c0byA3rK52jEPBw4VDM=;
        b=VKkY/M5oYRX1M7gZv5rG+f9GtYJPFC0WVShaeaaFVxV62iv5aNrPjNR/Fkc6PCECRx
         CR0D2V19M0cbhSGaSO7GhEqUHbOWhicRNKm+952zvAugvlOsnZ6BdEhWb9LubApfBjLA
         LN8wheBYNMHneZMC4bH2J0Ent0rlzzEGu+WiqjieecEoc8oCwc9IQ/0HajbGBk9fD0Td
         M11giini+PKnD6JREftJzFqkwCpH6Ua1M3k7PKM8/gycs9RAyW8f3ST2drA57R7Kg4WH
         ZgLthwht/6sqw9gZomqZyWUQCkLu/Je7v/FszR5NAeNL7c78r4IC8UcJoh3EgnpMGUJL
         2J5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734096313; x=1734701113;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFaJEJCATIofSallbqw9was2c0byA3rK52jEPBw4VDM=;
        b=qw8mzbnZSG3VNwj0Mnkc9lLaXlBtqO52PMhvxfZ7GWNQJB4Co7L08C11qjPk5+RmmZ
         q30D4X/4POJjHT9cMK58AEJ03HCjiMwrazavGTSWsEODVOu54NmZ1iBNwXefF8XKCx3+
         XuzlFUNPwKrC3PC2cpt+hdlmH3dcP5uFUHF42EzrxzWvUHJecQZ/um4FJ/JlygSDMwag
         VE5KN0CKBALU6a6la19A3LU6NOLK4lMizDBEU3CojnppM5ORnHRUFRVIglm4MBtURBzZ
         lfXiS7Z36ngj15Johsrfsdsnqts3ec/6mAieXdOY0QlXU6jpLHuYc++c2887Vwqx+445
         9OBQ==
X-Gm-Message-State: AOJu0YzBsY4F9Tv/UO/uLrgxqtsFD+h+1yHv/hqU/wxR1kXln4IWygUo
	abCsFDb01/8GepH7otWWppa5AJ56J0e38Y2AbosqzfNLEvdc6Xf5AycaRg==
X-Gm-Gg: ASbGncttdVGqmA9geOB9r2CkQqjnS31wMFWQxknAj+OwTEKu6//uZMrOQgvrZhLgk9y
	UjkTKTGQHReTXWTqIjquBaHG5JWmG1wpOwLAZkagVmnGe+uGLfFNylPT5NoNnuRGvBBDUiaxslR
	Z1KYTTGmgghCWMQxm7ZM4O97UHSXXLetrKPFtph9nXUMSOewtec//pWfoaWjL23VLjoF3ZSSqJ5
	rJ/6YDdhDHyAvO2HRYFkRN+njp5vdcDIBaSXC4jbfjfGF7DponEcwfZ6p5FBABCNdtzneK9y7nZ
	CGBOjRXP
X-Google-Smtp-Source: AGHT+IERlV1eJFgg3qUob1jnBZZs/kuecbfY4SOF5xElB/pCNVrERZzTlW1mbzutkYtXlyPYHv840A==
X-Received: by 2002:ac8:7f54:0:b0:467:6901:758b with SMTP id d75a77b69052e-467a570ec4fmr46004781cf.2.1734096313458;
        Fri, 13 Dec 2024 05:25:13 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46759b837aasm62177471cf.83.2024.12.13.05.25.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:25:12 -0800 (PST)
Date: Fri, 13 Dec 2024 08:25:10 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2 0/2] bsp: rkbin: bump to
 latest commit in master
Message-ID: <20241213132509.GA37306@localhost>
References: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
 <20241212201137.GA26940@localhost>
 <7933e42e-32aa-47f3-a45e-497bf2f3aa40@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7933e42e-32aa-47f3-a45e-497bf2f3aa40@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 13:25:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/895

On Fri 2024-12-13 @ 11:10:31 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 12/12/24 9:11 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > On Thu 2024-11-28 @ 04:58:48 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > We've been hit by random RCU stalls, system hangs or resets on some (not
> > > all) of our RK3588-based products running some old BL31/DDR init
> > > binaries.
> > > 
> > > Upgrading to latest commit in master branch seems to mitigate those
> > > issues, so let's do that.
> > > 
> > > Only build tested.
> > 
> > I have finally gotten around to testing before and after images of your
> > patchset. This was complicated by the fact that the u-boot and kernel for the
> > radxa-zero-3 stopped working recently, so I needed updates for that in order
> > to test everything.
> > 
> > I was able to confirm all of the changes work on hardware except for the
> > rk3308.
> > 
> > 	in order to test		i have a
> > 	^^^^^^^^^^^^^^^^		^^^^^^^^
> > 	rk3308				rock-pi-s
> > 	rk3566				radxa-zero-3e
> > 	rk3568				rock-3a
> > 	rk3588s				rock-5a
> > 	rk3588				rock-5b
> > 
> > In all cases but the rk3308 I have nice before and after captures, clearly
> > showing the old version numbers then the new version numbers.
> > 
> > In the case of the rk3308 this patch set is moving from v2.07 to v2.10, but
> > here's what the before looks like on the rock-pi-s:
> > 
> > 
> > 	DDR Version V1.26
> > 	REGFB: 0x00000032, 0x00000032
> > 	In
> > 	589MHz
> > 	DDR3
> > 	 Col=10 Bank=8 Row=14 Size=256MB
> > 	msch:1
> > 	Returning to boot ROM...
> > 
> > 	U-Boot SPL 2024.04 (Apr 03 2024 - 02:37:23 +0000)
> > 	Trying to boot from MMC2
> > 
> > 
> > 	U-Boot 2024.04 (Apr 03 2024 - 02:37:23 +0000)
> > 
> > 	Model: Radxa ROCK Pi S
> > 	DRAM:  256 MiB (effective 254 MiB)
> > 	Core:  281 devices, 21 uclasses, devicetree: separate
> > 	MMC:   mmc@ff480000: 1, mmc@ff490000: 0, mmc@ff4a0000: 2
> > 	Loading Environment from MMC... OK
> > 
> > and the after:
> > 
> > 
> > 	DDR Version V1.26
> > 	REGFB: 0x00000032, 0x00000033
> > 	In
> > 	589MHz
> > 	DDR3
> > 	 Col=10 Bank=8 Row=14 Size=256MB
> > 	msch:1
> > 	Returning to boot ROM...
> > 
> > 	U-Boot SPL 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000)
> > 	Trying to boot from MMC2
> > 	## Checking hash(es) for config config-1 ... OK
> > 	## Checking hash(es) for Image atf-1 ... sha256+ OK
> > 	## Checking hash(es) for Image u-boot ... sha256+ OK
> > 	## Checking hash(es) for Image fdt-1 ... sha256+ OK
> > 	## Checking hash(es) for Image atf-2 ... sha256+ OK
> > 
> > 
> > 	U-Boot 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000)
> > 
> > 	Model: Radxa ROCK Pi S
> > 	DRAM:  256 MiB (effective 254 MiB)
> > 	Core:  293 devices, 30 uclasses, devicetree: separate
> > 	MMC:   mmc@ff480000: 1, mmc@ff490000: 0, mmc@ff4a0000: 2
> > 	Loading Environment from MMC... Reading from MMC(1)... OK
> > 
> > So I'm not sure what's going on here. But I'm happy with the patchset
> > otherwise.
> > 
> 
> What's going on is that we have an rkbin recipe specifically for the rk3308
> which is selected by default :)
> 
> I have not updated it as it was specifically done because the UART
> console/mux for one of your devices didn't exist in newer versions of rkbin,
> so I assume this is still the case?
> 
> If you were to set RKBIN_RK3308_LATEST to 1, this should work (albeit
> nothing on the UART anymore).
> 
> Does reality match my expectations?

Enabling RKBIN_RK3308_LATEST causes the build to fail. But it's not failing
because of your recent patches, something prior already broke it.

> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#893): https://lists.yoctoproject.org/g/yocto-patches/message/893
> Mute This Topic: https://lists.yoctoproject.org/mt/109823578/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

