Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445A1E77180
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 20:11:48 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web10.712.1734034302991309945
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Dec 2024 12:11:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BPTydADn;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46772a0f8fbso8905191cf.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Dec 2024 12:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734034301; x=1734639101; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgsMSr1sPvSQdNaROaSv9c9Kn7hgBxyA3sqBI4C/Shw=;
        b=BPTydADnkMsOwAUWui7n+rTCzHnxhll9kiz6Dii8flrRRIK5nN9Zz2xskhNfes+61O
         WJxfgR6oxGTgjFCSLbjOh8j6N0xqnuy+zVa4MyXaCqz3Z3wKmnOauMZExJgcInTKwGjl
         p/uBppaJY8RPR+DqxhbkrOCABbBwVu/y3YgRk2t42/i09+kaH+DuLnU8QbwKzJH2LIVE
         K3AGy/KdhsvI7EGlyNrO/5qEmyw8xhMW5feCiA8a5eKsqsAAtjyDpBn2yUDuqvDUCbc7
         dAl98HQiIsHsFK6MFFV5djX9/fMXzFaEIKGoHEILFhlija9DJ/87zK9eQvZSuqZJ3eSq
         1jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734034301; x=1734639101;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgsMSr1sPvSQdNaROaSv9c9Kn7hgBxyA3sqBI4C/Shw=;
        b=N293DzJARr5B2FOR8t6cZk711UPuro+Tmrupo9FXP1bTyToRjvs31L+j6azXktptOm
         SEIL4apQo/ooLVnUmU7L0YTMBqIkgeYP34lHhNQ5QjvvV9G1bmy7h0fGURPFn2kZqPmr
         PyO2HV3OcKz/RkWupT/76CJ/JsuUswg0k9/F+Ht41giKNvWQAwQIE/C53/l+AA4SYwv2
         C6s34OBhZH6y4ZLR/fe751hSXNuHWjoOT+j9e6GmJCV/F33pCptHXPZ3mq+vHH7P1qSm
         b1tX2svB4p2WFeZ7B5MZuweGAxr43Fm/1Bizk12DkrOqM0BQg+zUEwPSKXBPW6WV2qlF
         BV5w==
X-Gm-Message-State: AOJu0YwCpHvz9B80YCqC/5ESUDHQfTeDHEkviMt1sY3iglxgtIDYXqFt
	Ilv27Yv/yrzdSi3npmCMfAvra1lvmugvdFkpMadjhUtZnFkwy+OfgyrZUw==
X-Gm-Gg: ASbGncuhmxJD3AwUnxzV4RmdDx724SuUbh7D53qLPYVmfBeJzH2cVqWB86CJRqvEtuK
	S9mFK9AR2nz3uupmTq8EKXp4MBxA8UEgH4geUPR3HPhmnuUcPdIIlDQv4F5x54kruH80ysHi+Ax
	FiGeMzD56DP2+yhW/eNZMYD4HQNGpw4eZ4UV8wrp/KVZgSzF+4XqrMgS13M5wSc62IiaghXdkEB
	mRauEnRc7A3/r0KDWEZBnGwg5XbXJKc730ESSV4VVkdntbeHqs+a4xK8jJcTj6rsWcacCmYT7Ml
	dVpLgl9R
X-Google-Smtp-Source: AGHT+IE4WnJZ5syp4F5tPnz5mJuHS7FZGP5iWCiwxlDRcU0ElOlsZZwRk4x1fnCw5azvkL9mbee3Ow==
X-Received: by 2002:a05:6214:509e:b0:6cb:d1ae:27a6 with SMTP id 6a1803df08f44-6db0f789448mr24652296d6.24.1734034300736;
        Thu, 12 Dec 2024 12:11:40 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d931956e66sm26089916d6.12.2024.12.12.12.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:11:39 -0800 (PST)
Date: Thu, 12 Dec 2024 15:11:37 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2 0/2] bsp: rkbin: bump to
 latest commit in master
Message-ID: <20241212201137.GA26940@localhost>
References: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Dec 2024 20:11:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/891

On Thu 2024-11-28 @ 04:58:48 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> We've been hit by random RCU stalls, system hangs or resets on some (not
> all) of our RK3588-based products running some old BL31/DDR init
> binaries.
> 
> Upgrading to latest commit in master branch seems to mitigate those
> issues, so let's do that.
> 
> Only build tested.

I have finally gotten around to testing before and after images of your
patchset. This was complicated by the fact that the u-boot and kernel for the
radxa-zero-3 stopped working recently, so I needed updates for that in order
to test everything.

I was able to confirm all of the changes work on hardware except for the
rk3308.

	in order to test		i have a
	^^^^^^^^^^^^^^^^		^^^^^^^^
	rk3308				rock-pi-s
	rk3566				radxa-zero-3e
	rk3568				rock-3a
	rk3588s				rock-5a
	rk3588				rock-5b

In all cases but the rk3308 I have nice before and after captures, clearly
showing the old version numbers then the new version numbers.

In the case of the rk3308 this patch set is moving from v2.07 to v2.10, but
here's what the before looks like on the rock-pi-s:


	DDR Version V1.26
	REGFB: 0x00000032, 0x00000032
	In
	589MHz
	DDR3
	 Col=10 Bank=8 Row=14 Size=256MB
	msch:1
	Returning to boot ROM...

	U-Boot SPL 2024.04 (Apr 03 2024 - 02:37:23 +0000)
	Trying to boot from MMC2


	U-Boot 2024.04 (Apr 03 2024 - 02:37:23 +0000)

	Model: Radxa ROCK Pi S
	DRAM:  256 MiB (effective 254 MiB)
	Core:  281 devices, 21 uclasses, devicetree: separate
	MMC:   mmc@ff480000: 1, mmc@ff490000: 0, mmc@ff4a0000: 2
	Loading Environment from MMC... OK

and the after:


	DDR Version V1.26
	REGFB: 0x00000032, 0x00000033
	In
	589MHz
	DDR3
	 Col=10 Bank=8 Row=14 Size=256MB
	msch:1
	Returning to boot ROM...

	U-Boot SPL 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000)
	Trying to boot from MMC2
	## Checking hash(es) for config config-1 ... OK
	## Checking hash(es) for Image atf-1 ... sha256+ OK
	## Checking hash(es) for Image u-boot ... sha256+ OK
	## Checking hash(es) for Image fdt-1 ... sha256+ OK
	## Checking hash(es) for Image atf-2 ... sha256+ OK


	U-Boot 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000)

	Model: Radxa ROCK Pi S
	DRAM:  256 MiB (effective 254 MiB)
	Core:  293 devices, 30 uclasses, devicetree: separate
	MMC:   mmc@ff480000: 1, mmc@ff490000: 0, mmc@ff4a0000: 2
	Loading Environment from MMC... Reading from MMC(1)... OK

So I'm not sure what's going on here. But I'm happy with the patchset
otherwise.

> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Changes in v2:
> - use version and filename variables instead of using glob pattern for
>   path matching the DDR init binaries,
> - Link to v1: https://lore.kernel.org/r/20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de
> 
> ---
> Quentin Schulz (2):
>       bsp: rkbin: rkbin-ddr: use version and file variables for path matching
>       bsp: rkbin: bump to latest commit in master branch
> 
>  README                                      | 15 +++++++++++++++
>  recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 20 ++++++++++++++++----
>  recipes-bsp/rkbin/rockchip-rkbin.inc        |  4 ++--
>  3 files changed, 33 insertions(+), 6 deletions(-)
> ---
> base-commit: 3a8be31581651ced6c27f5bad1333064e513a8f0
> change-id: 20241127-rkbin-bump-4cdfb23aa49f
> 
> Best regards,
> -- 
> Quentin Schulz <quentin.schulz@cherry.de>
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#857): https://lists.yoctoproject.org/g/yocto-patches/message/857
> Mute This Topic: https://lists.yoctoproject.org/mt/109823578/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

