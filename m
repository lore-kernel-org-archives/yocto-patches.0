Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A2AE7717D
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 15:17:23 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web11.17748.1734103038437386791
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 07:17:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iDxA3HU5;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6f1b54dc3so243488285a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 07:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734103037; x=1734707837; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXsJHreyHq6VVKyjxEAtgF+FS9WFsC0WTx3LlLEDlu0=;
        b=iDxA3HU5nPzAtr4JcsVaQ5XuxwstItW/2fObLcYJrHMEJ8P7F7I6tsSYFUCr2mWu8L
         a0uuwgQCVQWJF4gjEIEcJaXeXUdrsLN3lT2788leWxj3IO7ZQcc2FW0IdMh12m3hqgox
         fWClO3lhLqV2JCE7BMA7KKlQL2806SnFCtYwnIT+e4b5c4oKwmgNb+JZS3agCM3o6iMa
         0rDAqywmE6xGO7G4o6eLP2D1eDgLnnEXhLdIghc8RQTyerNrxMSGI+jL8w/pAbTa106r
         pDo6Xf0jWpjnsT6loDUbtEjvi91lKl+PEVcIUQ+MgzSzKBEE0EIp2+v89dWRZeAB7io/
         DlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734103037; x=1734707837;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXsJHreyHq6VVKyjxEAtgF+FS9WFsC0WTx3LlLEDlu0=;
        b=Mt5MzRAJQi5aS99nZ3qorFp8E/FOMdozHWqzo3XzprZkyWXu0nWRiHH3V2dp8gEp0e
         quHhEjN2uvHDhC4/84DQJaHbcSzogWFqRRrCJrsqqEXKmcJ2DpuPSgEracaOB9GBou9/
         oF5tiIqc6bFF5nfdA3YV+M/3skCsTQRJOm/bZcOiScUnYE07m1ClHkcy9gw7OmAS6LEF
         T0rpfa+CT8ere7jx8tffi7Q3FA4xHfV/mGuWSu4EOJwsWjcNIEz4+MBrwMgXkpAr9oCE
         NYzDCQmoeKTNOJ5MzzEMFmXbqvx9Y6TXqEqydgiblEVvYAkyWzBPlwX1KYRYFyKSg8sn
         SLEA==
X-Gm-Message-State: AOJu0YxT3o8Bu8BDBlRLVeLg00vTWrCFFQgbdQguv4I615lKiQdPfgfT
	pLCnKnukJ0cMgFnnNvNqJu8w6Uo4zoC7gdpxPBaewPgcpcpLRtib6M/qww==
X-Gm-Gg: ASbGncvq7EEMWC0iSqiNZ69Rf+NXN6S3LOvgv4QqLCEurqq+Qra/sO9TVgWS/t1tWHH
	3VQQ5Cy+mXSmfUfG6opNiT12Hk8vbhWGvA1W4cMfIYw09Kyd8413TvmSoCF/kzhaybtBUxLl15E
	22WZki93j4QhPJl9gT5QqfKE328F1z1c0BQREsWaEEGOnFBlg6SIPreY0eRhePMDV1X+GJznx1P
	o5B61Si8HvUQJ940DMbrJnJ9MyYOgAqM1WhMKRvQX54N3q/so0ok+8h2hU/x7DMu9l7MutmcPbr
	9NdtbD2V
X-Google-Smtp-Source: AGHT+IHHnEaASfpQc7w+huMJIYfJW8QtSDRqunoMdYHc9QSQUkgSDxpYjUvp4hNGyeEq1hCatcBHrA==
X-Received: by 2002:a05:620a:2901:b0:79f:67b:4fdc with SMTP id af79cd13be357-7b6fbecc66bmr359147885a.2.1734103036548;
        Fri, 13 Dec 2024 07:17:16 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6f2c9287esm182494785a.12.2024.12.13.07.17.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:17:15 -0800 (PST)
Date: Fri, 13 Dec 2024 10:17:13 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2 0/2] bsp: rkbin: bump to
 latest commit in master
Message-ID: <20241213151713.GA19938@localhost>
References: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
 <20241212201137.GA26940@localhost>
 <7933e42e-32aa-47f3-a45e-497bf2f3aa40@cherry.de>
 <20241213132509.GA37306@localhost>
 <28a92ad1-8855-4f9d-97a6-97bd8b512da2@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28a92ad1-8855-4f9d-97a6-97bd8b512da2@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 15:17:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/898

On Fri 2024-12-13 @ 02:46:15 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> On 12/13/24 2:25 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > On Fri 2024-12-13 @ 11:10:31 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > Hi Trevor,
> > > 
> > > On 12/12/24 9:11 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > > > On Thu 2024-11-28 @ 04:58:48 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> > > > > We've been hit by random RCU stalls, system hangs or resets on some (not
> > > > > all) of our RK3588-based products running some old BL31/DDR init
> > > > > binaries.
> > > > > 
> > > > > Upgrading to latest commit in master branch seems to mitigate those
> > > > > issues, so let's do that.
> > > > > 
> > > > > Only build tested.
> > > > 
> > > > I have finally gotten around to testing before and after images of your
> > > > patchset. This was complicated by the fact that the u-boot and kernel for the
> > > > radxa-zero-3 stopped working recently, so I needed updates for that in order
> > > > to test everything.
> > > > 
> > > > I was able to confirm all of the changes work on hardware except for the
> > > > rk3308.
> > > > 
> > > > 	in order to test		i have a
> > > > 	^^^^^^^^^^^^^^^^		^^^^^^^^
> > > > 	rk3308				rock-pi-s
> > > > 	rk3566				radxa-zero-3e
> > > > 	rk3568				rock-3a
> > > > 	rk3588s				rock-5a
> > > > 	rk3588				rock-5b
> > > > 
> > > > In all cases but the rk3308 I have nice before and after captures, clearly
> > > > showing the old version numbers then the new version numbers.
> > > > 
> > > > In the case of the rk3308 this patch set is moving from v2.07 to v2.10, but
> > > > here's what the before looks like on the rock-pi-s:
> > > > 
> > > > 
> > > > 	DDR Version V1.26
> > > > 	REGFB: 0x00000032, 0x00000032
> > > > 	In
> > > > 	589MHz
> > > > 	DDR3
> > > > 	 Col=10 Bank=8 Row=14 Size=256MB
> > > > 	msch:1
> > > > 	Returning to boot ROM...
> > > > 
> > > > 	U-Boot SPL 2024.04 (Apr 03 2024 - 02:37:23 +0000)
> > > > 	Trying to boot from MMC2
> > > > 
> > > > 
> > > > 	U-Boot 2024.04 (Apr 03 2024 - 02:37:23 +0000)
> > > > 
> > > > 	Model: Radxa ROCK Pi S
> > > > 	DRAM:  256 MiB (effective 254 MiB)
> > > > 	Core:  281 devices, 21 uclasses, devicetree: separate
> > > > 	MMC:   mmc@ff480000: 1, mmc@ff490000: 0, mmc@ff4a0000: 2
> > > > 	Loading Environment from MMC... OK
> > > > 
> > > > and the after:
> > > > 
> > > > 
> > > > 	DDR Version V1.26
> > > > 	REGFB: 0x00000032, 0x00000033
> > > > 	In
> > > > 	589MHz
> > > > 	DDR3
> > > > 	 Col=10 Bank=8 Row=14 Size=256MB
> > > > 	msch:1
> > > > 	Returning to boot ROM...
> > > > 
> > > > 	U-Boot SPL 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000)
> > > > 	Trying to boot from MMC2
> > > > 	## Checking hash(es) for config config-1 ... OK
> > > > 	## Checking hash(es) for Image atf-1 ... sha256+ OK
> > > > 	## Checking hash(es) for Image u-boot ... sha256+ OK
> > > > 	## Checking hash(es) for Image fdt-1 ... sha256+ OK
> > > > 	## Checking hash(es) for Image atf-2 ... sha256+ OK
> > > > 
> > > > 
> > > > 	U-Boot 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000)
> > > > 
> > > > 	Model: Radxa ROCK Pi S
> > > > 	DRAM:  256 MiB (effective 254 MiB)
> > > > 	Core:  293 devices, 30 uclasses, devicetree: separate
> > > > 	MMC:   mmc@ff480000: 1, mmc@ff490000: 0, mmc@ff4a0000: 2
> > > > 	Loading Environment from MMC... Reading from MMC(1)... OK
> > > > 
> > > > So I'm not sure what's going on here. But I'm happy with the patchset
> > > > otherwise.
> > > > 
> > > 
> > > What's going on is that we have an rkbin recipe specifically for the rk3308
> > > which is selected by default :)
> > > 
> > > I have not updated it as it was specifically done because the UART
> > > console/mux for one of your devices didn't exist in newer versions of rkbin,
> > > so I assume this is still the case?
> > > 
> > > If you were to set RKBIN_RK3308_LATEST to 1, this should work (albeit
> > > nothing on the UART anymore).
> > > 
> > > Does reality match my expectations?
> > 
> > Enabling RKBIN_RK3308_LATEST causes the build to fail. But it's not failing
> > because of your recent patches, something prior already broke it.
> > 
> 
> Probably the switch to separate recipes for ddrbin, op-tee and tf-a.
> 
> Do you have the logs somewhere I could have a look at?

I think I have a fix, I just need a bit more testing.

I'll resend my recent patches with this one added (and add the [meta-rockchip]
label as I should have for v1 ;-) )

> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#896): https://lists.yoctoproject.org/g/yocto-patches/message/896
> Mute This Topic: https://lists.yoctoproject.org/mt/109823578/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

