Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C0ECE8D46
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 15:30:15 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.731.1763134211641623873
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 07:30:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VkbPalbV;
 spf=pass (domain: gmail.com, ip: 209.85.221.175, mailfrom: twoerner@gmail.com)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-55986ed1e50so1146138e0c.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 07:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763134211; x=1763739011; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdJgEhXAnCAHrxwaXrXNYZUjgSz4P+1ZpZtoEkN11sk=;
        b=VkbPalbVTFCw21nVLk/frwjEWFGwDVAZMyIUQHRJfS7NGtVFhMd0IOn6h0JGlTs/Sx
         dR/iJHZG4VxvBcS1qup+0X2zg/pJdACtfwrum13pu5p0KF0Q10CDunQqzdHIfnv+mZXZ
         C2m9WtahDytpMb4EyJTuGcYmuUEU9B9SohKua6JOr2RJ6LwlgKGMHUkM4iFb3SPTnzpe
         NQiCHYAqwkI0OZtVkvyGmFIPss14ttGXErlE44ThcfxyHghTzPNJAG+oKlTwXwSecfX4
         Py6R4EolEwuTHld2vtQX9r6GisWGeT8PgVapd21BfXkiJ043Q0NTjT7isPLUgH5GJGoE
         9OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763134211; x=1763739011;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LdJgEhXAnCAHrxwaXrXNYZUjgSz4P+1ZpZtoEkN11sk=;
        b=Wg2k6HUgXFe5m/nQk/QyB28IjN/ZZn0ta11gO/IPmQ9LW1459P4ZuwNA8D1VJu9dex
         0h3CNnkeFDTfhCTHMk85+NS3N/OGnhIogI3TpzNVcxVv2VUPPE9di6s4A74XVi62u/3N
         3sdbEp+VJ2SEsN+3FR4NkiE9p4BWH421rPB6RHzhcLhgyob1wvQ7+uVMTfc6V/dgNJlE
         XneewuhARKyPH2ftL839yxUFw8qvhM8CuxBunTDouSsSBWnmPVx0mdKheikioRTf62RW
         f141bie8omNAhwyUDEH3BxHaOn5Kb/pOjJ4rApLkWDvxgDmmfx1rIf8eW3iPJFWp9CRJ
         S/0Q==
X-Gm-Message-State: AOJu0YzlAk6vnTSXL7PBQqOq61e/Dx5dUceY3Z3i0ko007H7vESgHdco
	jbI+wtHN+MEQ69JHuPJWFmqAI6gF8nie8Trd9Ic0ncDeYANmyJ+CNomISUjong==
X-Gm-Gg: ASbGncvJuihpey216wQR1SMrWmkSqSHA3z2aj53WVsaonSvzMkmLOhpC+s7Vih/E4LY
	uMr/lLUzZkweJGgRHIvBtsffbQmsx2OBQmxFdRX47te/WHc4Zz7skjhCI9bxdlR6Z0SwlT3/1f7
	mIBUo3k4r0/qDP3zmZi9YvaHAyaspPd7Y36oUTtYIbH1s7NOO96/tv2xr2sAK3VXqZctcf8Kpu8
	NT5/gjGoen43TWGXKM4ApOAs29MvhUpD3iX01ZUoF6ID3cC5GgD0uJYM7AlyLVG320pcc/CmGgy
	AnSzkqw1rCZoIBDua0ldFqMpDd8+gYiTj9+3MEx4CUM+7C972x88wwPRQLLqbbE2PAd3Yt5OLsE
	9MyRXWRrb3o6lFVbMjSlF1dlj7Mzp/xVLkTdlcGSOsfjMgNXKug6sMOBv0gSZ/5AZcxMKhZujx0
	UknvwUXxmJCJrn3JsnOxOX176nMc8=
X-Google-Smtp-Source: AGHT+IGVok4YMx21fp3vLWQ4/X/LdjH5ZdQ6RBKi0powhYN3BZ48gB0pYkCIwaP8JiWNgRRgps56fg==
X-Received: by 2002:a05:6214:268f:b0:880:4695:464a with SMTP id 6a1803df08f44-882925c54f7mr43830536d6.24.1763132477249;
        Fri, 14 Nov 2025 07:01:17 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882865342b9sm32183986d6.31.2025.11.14.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:01:16 -0800 (PST)
Date: Fri, 14 Nov 2025 10:01:14 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Peter Shkenev <mustela@erminea.space>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip] [PATCH v3] rk3288: use u-boot.img as bootloader
 image
Message-ID: <20251114150114.GA26364@localhost>
References: <20251108225641.171832-1-mustela@erminea.space>
 <20251114145308.GA22027@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251114145308.GA22027@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 15:30:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2566

On Fri 2025-11-14 @ 09:53:08 AM, Trevor Woerner wrote:
> My build testing shows that this patch fails for the rock2-square
> MACHINE. Are others seeing this as well? In the v1 patch Quentin noticed
> this and mentioned building for all rk3288 devices, was this tested?

Actually, never mind, the fix is so small and obvious, I'll just roll it
into the patch and commit it.

> On Sun 2025-11-09 @ 01:56:41 AM, Peter Shkenev wrote:
> > Currently, u-boot.bin is used for supported rk3288-based boards. But on
> > some boards, such as tinker-board, it can not be loaded, since
> > u-boot.bin is raw and those boards have raw image support
> > (CONFIG_SPL_RAW_IMAGE_SUPPORT) disabled in favour of FIT images.
> > 
> > Use u-boot.img which is FIT when FIT support is enabled, and raw
> > otherwise.
> > 
> > Also add a note that u-boot.itb should be used if one wantes to utilize
> > OP-TEE.
> > 
> > Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
> > 
> > Signed-off-by: Peter Shkenev <mustela@erminea.space>
> > ---
> >  conf/machine/include/rk3288.inc | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
> > index a648b44..00cc04b 100644
> > --- a/conf/machine/include/rk3288.inc
> > +++ b/conf/machine/include/rk3288.inc
> > @@ -13,6 +13,7 @@ SERIAL_CONSOLES = "115200;ttyS2"
> >  KBUILD_DEFCONFIG ?= "multi_v7_defconfig"
> >  KERNEL_FEATURES:append:rk3288 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> >  
> > -UBOOT_SUFFIX ?= "bin"
> > +# Set UBOOT_SUFFIX to "itb" if you are going to use OP-TEE
> > +UBOOT_SUFFIX ?= "img"
> >  
> >  ENABLE_STATELESS_VPU_GST ?= "1"
> > -- 
> > 2.51.1
> > 

