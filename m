Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34C9C25B74
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 14:11:56 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web11.9887.1717078309772568853
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 30 May 2024 07:11:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TsM2CHDn;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7948b50225bso65196085a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 30 May 2024 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717078308; x=1717683108; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqTygrSol1YywUYNVuHAplwjnhGXzCX9wFeLU7ILzb8=;
        b=TsM2CHDnJsSaPyP1CTPHhdjsPZ0k5h1hJp868ilJ9N2v3dkZRJrP0k5MTxnXyq2E2b
         PdNySIlrpVFuD0K1xJHpvKxGXpEK3q0C7/0DKLm5lqPtau8ieX7bySsPt1KBO1RVTpDd
         ViRaJqBswr7v+DZ7EbhvDpqtQYPyrPKXUWohz3y+2Jgg0vm/vkgETT8ZbL8yvEsWCia5
         8HQEroDAZaD2R0YqXqHj8rpJXjYNvcvdvYRwglP2RjHy/vij+5qW/iEIRKNC30zZ4gJG
         5QkecellU4afXlm9CQ9dQeNsCiTdKlNDK/jOd1Dl/kk6va+/eaQWkoWMBvYS4/AWXiCl
         qH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717078308; x=1717683108;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqTygrSol1YywUYNVuHAplwjnhGXzCX9wFeLU7ILzb8=;
        b=QI4gGlOIYBsculd6nDK203dbWZPACEPWztvQyED4wdDbNs+3igpta0L2g4QLrQZhW4
         BWx5mVY05LvGskKBXaIDnGtYi9m3cxIBFQboEn3TmzTLyiAlm0OhdSs7hD3PUAw5L7cl
         cafCZfGixCiDXxeT3DmnuhdFiqdZYbFWmWWGyD268qLw3YSdWmS7wvpiVXkvpbQ++Ywf
         1LdRieblqHs3xczybkU/4bPcvFaBPhS5lwNzqeYlqf+ElD+gNbM3MEw/uI5VL1F+K+bi
         D+Qk1ivskz6yWv5N70s4L/4l4llkQY1zE3E6gXOFWwKIBcal5/WjqM79wko9UF6JUk6Y
         G+ig==
X-Gm-Message-State: AOJu0Yw8yCQtvhkVt7XHAbmRsNW4Sy1CWI1H2yk9/5CpztJAX1BIPjyC
	jL3rgqBe311cYNva7SwV6Wcqytx+C27O3LI3nw3xPyE6uU4T59td3BDkrQ==
X-Google-Smtp-Source: AGHT+IHowyaPPa1uTRqpOtdsiByWVyM0d4LRVWXfNkRqbbBWugPoqLlvS1YwcG2icT7Nbzb92h6Blw==
X-Received: by 2002:a05:620a:190f:b0:794:9ab7:7ef9 with SMTP id af79cd13be357-794edc7b181mr136048785a.20.1717078307753;
        Thu, 30 May 2024 07:11:47 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca7f80sm559574485a.21.2024.05.30.07.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:11:46 -0700 (PDT)
Date: Thu, 30 May 2024 10:11:44 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [PATCH meta-rockchip] rockchip-extlinux.inc: fix
 non-fit KERNEL_IMAGETYPE image boot
Message-ID: <20240530141144.GA23102@localhost>
References: <20240527-non-fit-fdt-boot-v1-1-72bf2530547d@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240527-non-fit-fdt-boot-v1-1-72bf2530547d@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 May 2024 14:11:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/248

On Mon 2024-05-27 @ 03:48:24 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> On systems where KERNEL_IMAGETYPE is not set to fitImage, one needs to
> either pass an DTB or a path to a directory where DTBs are located on
> the rootfs.
> 
> When FDT property in extlinux is provided, FDTDIR isn't used (and
> actually u-boot-extlinux-config doesn't even write it to the
> configuration file).
> 
> When relative paths are used, they are relative to the directory where
> extlinux.conf is stored[1]. Since the DTBs are stored in /boot, just
> providing the filename of the DTB won't work because extlinux in U-Boot
> will search for it in /boot/extlinux. We should therefore either use ../
> prefix for relative paths or use /boot to make it absolute. /boot is
> more explicit and easily parseable, so let's use the latter.
> 
> [1] https://wiki.syslinux.org/wiki/index.php?title=Config#Working_directory
> 
> Fixes: d80fa46c42f2 ("rockchip-extlinux.inc: handle multiple DTs in KERNEL_DEVICETREE")
> Fixes: 3b51866f2251 ("remove /boot partition")
> Fixes: 13316b796814 ("KERNEL_DEVICETREE: 32-bit re-org")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  conf/machine/include/rockchip-extlinux.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Trevor Woerner <twoerner@gmail.com>
Applied to meta-rockchip, master branch. Thanks!

