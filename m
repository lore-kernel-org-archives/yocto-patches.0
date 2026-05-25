Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531FCCD5BC9
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 15:47:29 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18423.1779724048627518829
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 08:47:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Ye+f3SmG;
 spf=pass (domain: gmail.com, ip: 209.85.222.174, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-913cc4d7c71so1057279885a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779724048; x=1780328848; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CdUA6m43pDKO8SRbC7nKJ0RnlPnXeDC/iaPY2TSsDI=;
        b=Ye+f3SmGWq+doygASmk6GBgc+DDleWzgjN/FfjhRM65E9rLG851ykLw12cQuAn79nO
         QIjGVB6ruXdEgZqNL5ppXEvNZaWfUWyeX/BKXRVb4p2AKFVFTu9HuqJb0XZAWptTtlF2
         jSoCh8GCxz3U7lXPaVAtvKmhdFJJt9mfhFoFiU3U96S92gMwtYGxZfZce5F/fu8Wzi18
         WIsX5m3Z/OphlPkiATgxzjFMsFk7IO+IBtHubKb1uL3kAMfG+RdPanoetYkUWUKzWb9F
         QfgjYYdvckG9oLtIS4NAMG69oCu2mOMx+BSuxVjhWZ3Naw6W/PQKI0EwHEjSfCjSDjy1
         yM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779724048; x=1780328848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CdUA6m43pDKO8SRbC7nKJ0RnlPnXeDC/iaPY2TSsDI=;
        b=nbO/tkmUrp3hUqrUAy0fQkWWzZA69YSv95GVDaX+GId0wWKykQNFFgBoWeLfHUXas0
         uRLocNt5QUO3bmhykb2JiOFtBMeE6SSuV/4CH5guHHQ2NhXGqPvX2dszoE/Eq0J7gbpk
         YtREJmGh4hPd1zHbgMuCS5B7rnh/9lJw230v14Mv4vwzno7YqDSX11JnbBF3Uxc+zpKL
         OjLHVqmn2/49eXokMoiA4tHcH8YISZq2vJ2a57sY4FpY++bWKJZtgxqaeGQWh/sndBvB
         TZW4378OfvanTfuhul03b3MNSb6E4uI1aOzdq4NJPowBmTUkBQrGHAASNPzfEV33JgSj
         IxUA==
X-Gm-Message-State: AOJu0YwW9EZ86loEbNeU0PAwKP6Bq8YVjyQAv0HAl/nA58/3YxuH/k9E
	HaRn1s03UQA2wL+7QD6yE0Db3zvQUed/zxI3fE0NV7a+2SJim1Nh7kzA
X-Gm-Gg: Acq92OFMG1T8vpxwux1LMQN0O5T2Cx/D+h6S27BRXxjP8vXAf3xuKGjEpxXdD3yY+RZ
	NYwjP0TSzqmHeR7PfPu0aMflEtgDFLuplP61dxHwG981EBfItTWm3JUmVQvarfpR0Mks+QD3tDK
	B2NV9orZGzChsNQNDddlGN+70AnmVTUGCC5PVJG12v4khcAxO8WWQezMTepyBfx2uo9vwOOvJh+
	QXN0KPj024kEOJI1SP0thFV0dkHSLPzCoFQEui5WireS/nF393OX6++q9qHd0HIzeUrtQHGk1Ik
	V5KQCux0KuEoMnpU/q3R8XPJeteLs+VePKouycK+ncK6yLkIKQiYxZCWq1ksr2FLUgZc7l1x8WH
	rasdsd71VSnvMt2QFiqbW/IS8QADFacVnyznEgvSfAa8XOuUluFv3LBAyrvg+pd/yfxpjF/f/YP
	nAlM8O9PAyZ9nN+KkaJXTZ8untHhXQXwhr0KoyopH/rNEJdI5lmrGjbINBXycspyNFeQLtI464r
	yt2KaHWZOgagus=
X-Received: by 2002:a05:620a:40cd:b0:911:9e67:44cb with SMTP id af79cd13be357-914b49b93f1mr2074337485a.38.1779724047642;
        Mon, 25 May 2026 08:47:27 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8e9ea6sm1045788085a.12.2026.05.25.08.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:47:26 -0700 (PDT)
Date: Mon, 25 May 2026 11:47:24 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Gourav Singh <gouravsingh@siemens.com>
Cc: yocto-patches@lists.yoctoproject.org, cedric.hombourger@siemens.com
Subject: Re: [wic][PATCH] wic/plugins: gate root= with creator.rootdev for
 efi and pcbios
Message-ID: <ahRvDD2Aj-wi3h-0@localhost.localdomain>
References: <20260424102743.4182065-1-gouravsingh@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260424102743.4182065-1-gouravsingh@siemens.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 15:47:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4042

Hi,

Thanks for the patch and the ping. The motivation is clear and the
change is in the right direction, but I would like to see an update
before merging:

1. extlinux has the same pattern and needs the same fix
   src/wic/plugins/source/bootimg_partition.py:121 currently has

   	extlinux_conf += "append root=%s rootwait %s\n" \
			% (cr.rootdev, bootloader.append if bootloader.append else '')

   With cr.rootdev == None on a DPS layout this produces
   "append root=None rootwait ..."

2. All the surrounding code uses %-formatted strings, please use the
   same style

On Fri 2026-04-24 @ 03:57:42 PM, Gourav Singh wrote:
> Checks for creator.rootdev not being None were missing and would cause
> the kernel command line to read "root=None". When using the Discoverable
> Partitions Specification, we really want no root= parameter on the
> kernel command line (and root=None is anyhow not a valid option).
> 
> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
> Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
> ---
>  src/wic/plugins/source/bootimg_efi.py    | 5 +++--
>  src/wic/plugins/source/bootimg_pcbios.py | 6 ++++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/src/wic/plugins/source/bootimg_efi.py b/src/wic/plugins/source/bootimg_efi.py
> index 69aa38b..7d2175d 100644
> --- a/src/wic/plugins/source/bootimg_efi.py
> +++ b/src/wic/plugins/source/bootimg_efi.py
> @@ -97,7 +97,7 @@ class BootimgEFIPlugin(SourcePlugin):
>                          (get_bitbake_var("KERNEL_IMAGETYPE"), get_bitbake_var("INITRAMFS_LINK_NAME"))
> 
>              label = source_params.get('label')
> -            label_conf = "root=%s" % creator.rootdev
> +            label_conf = f"root={creator.rootdev}" if creator.rootdev else ""
>              if label:
>                  label_conf = "LABEL=%s" % label
> 
> @@ -186,7 +186,8 @@ class BootimgEFIPlugin(SourcePlugin):
>              boot_conf += "linux /%s\n" % kernel
> 
>              label = source_params.get('label')
> -            label_conf = "LABEL=Boot root=%s" % creator.rootdev
> +            label_conf = "LABEL=Boot"
> +            label_conf += f" root={creator.rootdev}" if creator.rootdev else ""
>              if label:
>                  label_conf = "LABEL=%s" % label
> 
> diff --git a/src/wic/plugins/source/bootimg_pcbios.py b/src/wic/plugins/source/bootimg_pcbios.py
> index 1e5ec3a..b49d48d 100644
> --- a/src/wic/plugins/source/bootimg_pcbios.py
> +++ b/src/wic/plugins/source/bootimg_pcbios.py
> @@ -231,8 +231,10 @@ class BootimgPcbiosPlugin(SourcePlugin):
>              kernel = "/" + get_bitbake_var("KERNEL_IMAGETYPE")
>              syslinux_conf += "KERNEL " + kernel + "\n"
> 
> -            syslinux_conf += "APPEND label=boot root=%s %s\n" % \
> -                             (creator.rootdev, bootloader.append)
> +            # Check if rootdev exists
> +            root_param = f"root={creator.rootdev}" if creator.rootdev else ""
> +
> +            syslinux_conf += f"APPEND label=boot {root_param} {bootloader.append}\n"

3. This change leaves a double space when rootdev is None. Build the
   line from only the populated tokens (e.g. " ".join(parts)) so the
   line looks the same whether or no root= is present

> 
>          logger.debug("Writing syslinux config %s/syslinux.cfg", hdddir)
>          cfg = open("%s/hdd/boot/syslinux.cfg" % cr_workdir, "w")
> --
> 2.39.5
> 

