Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49591D3ABFC
	for <webhook@archiver.kernel.org>; Sat,  6 Dec 2025 08:34:20 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2479.1765010053908545246
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 06 Dec 2025 00:34:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mbT/cM75;
 spf=pass (domain: gmail.com, ip: 209.85.222.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2dcdde698so434452585a.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 06 Dec 2025 00:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765010053; x=1765614853; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DFW7zN3ETgUZ2i5ZuJYDiZ5LUF4rH09Aeigx/pvo4U=;
        b=mbT/cM7526sRDcdOEp5nP7EHLw2aXZKfjiglqMdKl6pAju+SkiI/wFmIO1o+DSh77t
         SqVvLKDMC9XNJ9iAu41y/bKggTFY+0SH18gJrAGqVzV2LvzhT/0PQZgaHmFP+Sk1Nyub
         VOzVYkOORqomBuXQcpn7Ib19zLwpP1kmUuGm+MmGJGCA4fl7n5wNgCyH6BHvu0T4W3I+
         +E9jh++ncaIAcWs8073rB14Cy/vFcrO5vcOPqictF058XxhgYz9y6USJ9GN56AdaeKG6
         7mL6Af9AT7rtdsrTju4A6ac700333kuinqFTtTHN+3KOXeNQjLyFgC3o1PVlCltMv8rc
         kWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765010053; x=1765614853;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DFW7zN3ETgUZ2i5ZuJYDiZ5LUF4rH09Aeigx/pvo4U=;
        b=X66xh86ciN2ir9vj9o8hZoNFSx5DpEXYTUQMgL/fclrbzKxDw4VGMIIrDaf+lZsJfE
         4fGjEuvNOZuRzwra4Zzv1PyJGawoDOsUyWAEdAiT1v6bJusQ3wOPvyKsJVio6a/+wZL2
         ZvRc4/+3OHa22/p9v2FX/QmvLwsEzyQVHRWdcz4IVyL+Qak+ijiOb+uNS+qHDE/S3p7T
         svqNChWjm1uhdUml/ZflpF8dKjtM18KTzV0he8ZaW8oHozemrPPeTO3u4ydg9pqdHzTc
         i4haVL99qy4rZJIZhVFzrTC3Jz2GcUdAlhR38rnqHtPqoFuKX3R5TqPcLQQtfQsR6AcJ
         kPkg==
X-Gm-Message-State: AOJu0Yx47RW+YDcC6NIrEA0o4KOL/bFKOBM5wYjUYfjxeMM9i5QvuOrT
	1f1q5G+F6Eg0c10tFMTE8soSKIir+l5vL5DU1qAIJl8105Mf4TiNyT3q/Gzw+hT2pWNXCUB/B9o
	m1j5qUBEGsOeUZVXc+PNCIVEdZEOU9kIwAQ==
X-Gm-Gg: ASbGncsHnaGtAJsJgBCabcMgy3OxuUgb3v969L6Mxl+ND5gAzg7vYcgq/G0jQfoRrbt
	FYJjSjUXvwVxclY2aBymNGHPD9L0b3bNJt3VqQxM2fAhEAJIbgQKlYOu1wdZ0BbMxlgbLErqk5m
	eMrCzueSSimKt1FRHMunCeGlk2fhG2DLZDRQq1BFD4c1KLA/AICN4ly72VVGUhoQtZvbNnjb3N8
	Sd853x4w/tDBa8GjJ8IRcTfnYbUmrMMPGZffh8HnhRVLxyscKh1RIEdWkTwZ5JYUwJeJ6a3ql8q
	jc+jyr57vY8qAt14W4sc5/vez0Siyw==
X-Google-Smtp-Source: AGHT+IFWzAvY3p2YPf4GefN7DFZ3289yNdDamP0aqV/MEzaFg3kuvbleLKA1JYTJ6AoTefJpHnE15qE90vIR6PCSu0w=
X-Received: by 2002:a05:620a:4411:b0:8b2:1ee9:dd03 with SMTP id
 af79cd13be357-8b6a23472bfmr264908185a.1.1765010052670; Sat, 06 Dec 2025
 00:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20251206070923.2254134-1-chee.yang.lee@intel.com>
In-Reply-To: <20251206070923.2254134-1-chee.yang.lee@intel.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sat, 6 Dec 2025 09:34:01 +0100
X-Gm-Features: AQt7F2qbJqiGN6Yq_-io5lTj3t7tIedgS3vcMK-YmSTWcy7J3epJIMXK6Aetv4s
Message-ID: <CANNYZj8i7_nR1x+eAt_zXmiYvTvRRNV96YjADJBE87ZDkNSkuw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-zephyr][PATCH] README: drop reference to poky
To: yocto-patches@lists.yoctoproject.org, 
	Lee Chee Yang <chee.yang.lee@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Dec 2025 08:34:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2748

On Sat, 6 Dec 2025 at 09:20, Lee Chee Yang via lists.yoctoproject.org
<chee.yang.lee=intel.com@lists.yoctoproject.org> wrote:
> @@ -23,17 +26,19 @@ https://wiki.yoctoproject.org/wiki/TipsAndTricks/BuildingZephyrImages
>  > **Pre-requisites:**
>  1. Refer [Yocto Project Quick Build]( https://docs.yoctoproject.org/dev/singleindex.html#yocto-project-quick-build) documentation.
>
> -2. Clone and add following layers to BBLAYERS
> +2. Clone required repo, refer to [Yocto Release](https://wiki.yoctoproject.org/wiki/Releases) for compatible branch name and bitbake branch.
> +    * bitbake
> +    * openembedded-core
>      * meta-openembedded/meta-oe
>      * meta-openembedded/meta-python
>      * meta-zephyr-core
>      * meta-zephyr-bsp
>  ```
> -    $ mkdir sources
> -    $ git clone -b <release-branch> https://git.yoctoproject.org/poky
> +    $ git clone -b <bitbake-branch> https://git.openembedded.org/bitbake
> +    $ git clone -b <branch-name> https://git.openembedded.org/openembedded-core
>      $ git clone -b <branch-name> https://git.openembedded.org/meta-openembedded
>      $ git clone -b <branch-name> https://git.yoctoproject.org/meta-zephyr
> -    $ source poky/oe-init-build-env
> +    $ source openembedded-core/oe-init-build-env
>      $ bitbake-layers add-layer ../meta-openembedded/meta-oe
>      $ bitbake-layers add-layer ../meta-openembedded/meta-python
>      $ bitbake-layers add-layer ../meta-zephyr/meta-zephyr-core

This looks like a nice opportunity to add a bitbake-setup config into
meta-zephyr that would do these with a single command :)

Alex

