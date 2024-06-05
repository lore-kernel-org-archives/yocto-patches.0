Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1724C27C52
	for <webhook@archiver.kernel.org>; Wed,  5 Jun 2024 17:23:18 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.web10.21852.1717608196366233364
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Jun 2024 10:23:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=afga8VHB;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4402c88390dso14061cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Jun 2024 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608195; x=1718212995; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6+MAbflPzCDFAOK3FmJrKVC6Dbw7kTc/FFMjhFsrhw=;
        b=afga8VHB9mYinG9k/L+I9Cng/DbhgnYRMfEIz5aeV97MB/wQkvaMm57I5nvVe7H0n0
         +mKiHCGLrD8yhjQKxzKgj1Uk3HreQ3SgqWjq0jY3EdqKrx+v+YYPP9z90D4MpNctMvHN
         5DplaN0eBJSk3bdk0LcCpEf/lsYRE76pyuxJ4+I9tNuZOTbYu0HJWnAHzrm2cpwxf2wi
         qHb0F758qA79wgGHWtU7wHZZnldLhWgOa/m55pSlxFhky9EJpDHiW9ncx6gU4h9N/Oh0
         QQjBzWilqYe31N23vPCX6MimtwbeEF/Mxd8C7KsbdxEWw1BKoAIfjfJzWKo66v1j4Cmv
         QCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608195; x=1718212995;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6+MAbflPzCDFAOK3FmJrKVC6Dbw7kTc/FFMjhFsrhw=;
        b=V5NHMeEewCLVdx1RxngAg/SwWam0m2MztsN34WMWWU8fI2dnsG3isdindX0qw/y5vG
         hF4+RVYC0WHXRxv5/1pmIsE6Uyom5OfL9LLkozCgxI3wuEdUWDbSOMYznMALpddJnV3P
         uiVMLSbtSjcwdc9Lx3hs49RgrEfCyA44lqcy1jdwWWaFOtYdMiHNi+sVa2zprcwUtbSn
         MGzjj4T7CpzP20p8rlWpv2BJr06lk2HUC6IFOkZyDx5qVx+zQN3EZM2CvmIKdJwirpf+
         Ac3nazzoClxQdUqyPVS7s3KOrdasRpG1NIUr2mIl3yhW3uyt1SElrW7LjzRLL6Cw1Xcd
         jBhA==
X-Gm-Message-State: AOJu0YzEDnQJdOQiLbDn4Ae2BN1M8unNfxqa03XJU4jJieQHSzzvtwdH
	nZwws5ezzTbEX1F5uOF2VODfxwMnt15fwKfXerrXrxoWYnzsa2A8AaLKcQ==
X-Google-Smtp-Source: AGHT+IFJWqvYQP0CT9vIXhAilRcsmpJuWluOtMAjPB1M230pfVAibU437jHQseZ+mB/NR0Jzhna9XA==
X-Received: by 2002:a05:622a:24f:b0:43a:cfc5:f0a0 with SMTP id d75a77b69052e-4402b462cbbmr32438931cf.13.1717608194653;
        Wed, 05 Jun 2024 10:23:14 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440076218acsm43362231cf.34.2024.06.05.10.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:23:13 -0700 (PDT)
Date: Wed, 5 Jun 2024 13:23:12 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [PATCH meta-rockchip master scarthgap v3 00/16]
 various reworks around u-boot and rkbin + fixes for MACHINEOVERRIDES
Message-ID: <20240605172312.GA11530@localhost>
References: <20240531-rk3588-family-v3-0-629586621c5d@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531-rk3588-family-v3-0-629586621c5d@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Jun 2024 17:23:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/276

On Fri 2024-05-31 @ 11:25:07 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> This does a few reworks of how we handle TF-A and DDR bin blob
> dependencies, hopefully in a way that makes it much easier to add
> support for new SoCs without having to touch too many files.
> 
> While at it, add an SOC_FAMILY entry for rk3588s/rk3588 boards.
> 
> Additionally, make rk3308 use the PREFERRED_PROVIDER mechanism to select
> rk3308-rkbin instead of rockchip-rkbin.
> 
> Finally, fix a few MACHINEOVERRIDES ordering issues.

Here are the new MACHINEOVERRIDES (with these patches applied) for all the
MACHINEs we support (with rk-u-boot-env enabled):

	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:firefly-rk3288:rk-u-boot-env"
	MACHINEOVERRIDES="armv7a:rockchip:rk3066:marsboard-rk3066"
	MACHINEOVERRIDES="armv7a:rockchip:rk3188:radxarock"
	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:rock2-square"
	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:tinker-board:rk-u-boot-env"
	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:tinker-board-s:rk-u-boot-env"
	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:vyasa-rk3288:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4:nanopi-m4:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4:nanopi-m4-2gb:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4b:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:rockchip:rk3328:nanopi-r2s:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-r4s:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rk3588:orangepi-5-plus:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3308:roc-rk3308-cc:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:rockchip:rk3328:roc-rk3328-cc:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3568:rock-3a:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-4c-plus:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rock-5a:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rk3588:rock-5b:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4a:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4b:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4c:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:rockchip:rk3328:rock-pi-e:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3308:rock-pi-s:rk-u-boot-env"
	MACHINEOVERRIDES="aarch64:rockchip:rk3328:rock64:rk-u-boot-env"

For uniformity, would it be nicer to have all MACHINEs include the SoC
OVERRIDE?

Other than that this patch set looks great!

I'm not overly fond of the name "u-boot-rockchip.inc" since it sounds like
it's an inc file for building the rockchip vendor fork of u-boot, but I can't
really think of anything that is obviously nicer.

