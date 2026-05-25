Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AF8CD5BC9
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 16:16:29 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19073.1779725783749422006
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 09:16:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PzNGpysb;
 spf=pass (domain: gmail.com, ip: 209.85.222.178, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-911449d9d03so1127564085a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779725783; x=1780330583; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFVFYCcvfEAge/aDj25BkHA1X+bKKp5MA2mEhBeO/l0=;
        b=PzNGpysbJZOrAbT31bu1R5icPhzAY+L2yB225xHsnyLd/7k0IoXDHGoZPuf/p2H1CE
         7HOFFmze2J0R1Nnksjy8ts3eSxrLBCK4/xQDqS1nF0ShTqcp0Y6qLA9Bip63vU/3sqST
         HyfPS42FH4jzdvwFDkdg60Ll1bmEsX3s/Ds5vVzaK/FQoH94tLICwMX/S6EZ50wqJCZt
         Re5Keh1+WqGboOrN7Sn5XISHQ99F+M03misLk7tebAOgZITeWawe2mEaDHRinMERRdUs
         1LuMWm3XxXdDNe/58xw65htz/iDGelWVMLTKPGWQQR+YETuuyomyeHpgbPent2VJMo11
         lRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779725783; x=1780330583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFVFYCcvfEAge/aDj25BkHA1X+bKKp5MA2mEhBeO/l0=;
        b=tPVsWHavHj2iGGMSS3QJ2CCuiJB9qLu9lMBpXjAkfGfiu1eNzz+rd3XGB3xzQV4oXc
         ov4wKm01Mz8Pm7RpcjFqYByPLtOAdGST5RlkjhGcN7Q5X1Lk7eUa6iXgf2WuyTQGG2Pe
         5rIa/1AXwl+OxjUj6cR0jgil9ihfs2TlAdiUeEr//UgHPfyhz02MC5Vzt+wtuRb+mG5m
         YHy/C2xhxspOwFM7bRKOzfl2Q/siR70HuuR66BGQCdEDJcZ7epElgtVQCPNUZrNIg+rS
         MF/iV4OrrluoOpiesGDfudT/s45uvncoFcFwQv76iJkpmyeZYGE7ARggBWA+UEF2ztDQ
         r6cw==
X-Gm-Message-State: AOJu0Ywg9nxTHx451X6PIc/AmXg5kVeAdbk02bEODYPX2uky10pmzgVZ
	9bpBYNqETHS/JsV9J1w9XXAFm+UkxU7LnPa4hUdswVC3RenUzWRUUC3m
X-Gm-Gg: Acq92OFGN1c9902igIkkS6A2SyLRX6ozOGYNwaP9QvAXThKwOiHaQOkxly0MKrRbf2V
	HDP3sKC1CoHdoIa1Tu1AeGQUj6SWfePIBDvRMdSo3WdXK/ebtoB4ERUIl1e6V6KlSgrSSvGh6/u
	twU9DtXfqMch3YwMhstB5pJ8WaSiy9cr8pJ1MjAF1yYgmhxIgROcrcdBtnng0t7KeYZ7JTg5D/6
	1HVAZ+I3lz+lvU9wXJtmIXX7VroS5wzXlGfrwClIAhtHh0vxHg9Wtp5uy95Wt4vZP38lYFKi61A
	nSi+ayM89v2JEH54US4/++2MjOqQ6D0q3uL4OlLiwF2crnR3gH3px3lcGdnt/1yrMv8KSxjcTB1
	NnI2sdEQ4qekfqU0EdnV5VSlWg6AuWb2MSGyPunYAjayuyu80XqfrT+4ddE95vEfZdxsiEchXiX
	SDH+a5m/U5PBC9K+fQQggQv0/Pyz/i+l28RSRz+1Dcf3UlCNZfI1Q6HvwZJ5EmYPYWnWSzS8mjA
	ZVC
X-Received: by 2002:a05:6214:4346:b0:8ca:fd54:c5c6 with SMTP id 6a1803df08f44-8cc7b5dbb98mr253822176d6.45.1779725782474;
        Mon, 25 May 2026 09:16:22 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8132c625sm111509586d6.48.2026.05.25.09.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 09:16:21 -0700 (PDT)
Date: Mon, 25 May 2026 12:16:19 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Aleksandar Nikolic <aleksandar.nikolic010@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org,
	Aleksandar Nikolic <aleksandar.nikolic@zeiss.com>
Subject: Re: [wic][PATCH] wic: Fix updating fstab for nvme devices
Message-ID: <ahR1028l_g_-z7PH@localhost.localdomain>
References: <20260522113400.192786-1-aleksandar.nikolic22@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522113400.192786-1-aleksandar.nikolic22@pm.me>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 16:16:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4045

Hi,

Thanks for the patch, but there is a second case that needs the same
treatment.

On Fri 2026-05-22 @ 01:34:00 PM, Aleksandar Nikolic wrote:
> From: Aleksandar Nikolic <aleksandar.nikolic@zeiss.com>
> 
> In case wks file references nvme, update_fstab() function will not add
> prefix 'p' before the partition number, as the if condition only takes
> mmcblk into consideration.
> 
> In case of nvme0n1 this leads that following entries are added to fstab:
> 
>     /dev/nvme0n11
>     /dev/nvme0n13
> 
> instead of:
> 
>     /dev/nvme0n1p1
>     /dev/nvme0n1p3
> 
> The patch fixes this as it extends the if condition and adds prefix 'p' for
> both mmcblk and nvme.
> 
> Signed-off-by: Aleksandar Nikolic <aleksandar.nikolic@zeiss.com>
> ---
>  src/wic/plugins/imager/direct.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/wic/plugins/imager/direct.py b/src/wic/plugins/imager/direct.py
> index 832d0e6..38a675e 100644
> --- a/src/wic/plugins/imager/direct.py
> +++ b/src/wic/plugins/imager/direct.py
> @@ -134,8 +134,8 @@ class DirectPlugin(ImagerPlugin):
>              elif part.use_label:
>                  device_name = "LABEL=%s" % part.label
>              else:
> -                # mmc device partitions are named mmcblk0p1, mmcblk0p2..
> -                prefix = 'p' if  part.disk.startswith('mmcblk') else ''
please remove the double-spaces   ^^

> +                # mmc and nvme device partitions start with prefix 'p'
> +                prefix = 'p' if  part.disk.startswith(('mmcblk', 'nvme')) else ''
please remove the double-spaces   ^^

>                  device_name = "/dev/%s%s%d" % (part.disk, prefix, part.realnum)
>  
>              opts = part.fsopts if part.fsopts else "defaults"

The double-spaces pre-date your change, but since you're editing them
already...

There is a second site with the same hard-coded `mmcblk` test, a few
lines below in `DirectPlugin.rootdev`:

    src/wic/plugins/imager/direct.py:272
        suffix = 'p' if part.disk.startswith('mmcblk') else ''
        return "/dev/%s%s%-d" % (part.disk, suffix, part.realnum)

That property builds the kernel command-line `root=` argument, so with
the current code an NVMe rootfs boots with `root=/dev/nvme0n11`, which
doesn't exist. Could you give it the same `('mmcblk', 'nvme')` treatment
in v2?


> -- 
> 2.43.0
> 

