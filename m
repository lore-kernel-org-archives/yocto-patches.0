Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web11.18282.1713791942809990241
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Apr 2024 06:19:02 -0700
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-790605809cbso192189485a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Apr 2024 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713791941; x=1714396741; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkAqtOlnDCOdOmpoHkoLycVoW/T7a6/H9JXalLfGJes=;
        b=RUp2q2o7P7tFfoP/zJ/zYtmfe5+yRacNamj1qxYhCpTzw9Ltp/zeRk2xluhR8Eqs8U
         nG+x0GbaBMKLQldTwWpjdzMBO/LgzgcX4xjxlK10epBV4qPPWgv/Ou8hXMP3vYrvvxEg
         y9TMRQufGV67bWAxNTUQWeMpuP0UO933IQjmG65hKOd608OBMYWn+blpPKIBYOgxA2/A
         q351GaagEaV2bsYtz4vkKLmyX8+0rQbnmnEfl+I/aRYcqrRIG46ZC0wiatA7jvfgkAjH
         sJEINRdGB3WNtxrb0UhCuerbkp3L5KgKanttR15S+eYxk595TEAQNh2bf5pYWcDyTNFS
         Jx7A==
Return-Path: <twoerner@gmail.com>
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b007907a91e573sm453495qkk.130.2024.04.22.06.18.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:19:00 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:18:58 -0400
From: "Trevor Woerner" <twoerner@gmail.com>
Subject: Re: [meta-rockchip][PATCH] wic: add GPT partition names to partitions
Message-ID: <20240422131858.GA12473@localhost>
References: <20240418220431.31286-1-twoerner@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20240418220431.31286-1-twoerner@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

On Thu 2024-04-18 @ 06:04:31 PM, Trevor Woerner wrote:
> A filesystem label (/dev/disk/by-label) is a property of, and stored in, the
> filesystem itself. Partitions that are not destined to hold filesystems are
> not formatted, therefore it is not possible to assign filesystem labels to
> such partitions.
> 
> However, if GPT partitioning is being used, GPT supports the notion of
> assigning labels/names to the partitions which are stored as part of the GPT
> partition table itself (instead of being stored in the filesystem in the
> partition). The naming is a bit confusing (different tools use different
> names) but `wic` calls this "--part-name", `lsblk` calls this "PARTLABEL", and
> `parted` calls this "name".
> 
> In Linux user-space these partition labels are referenced via
> /dev/disk/by-partlabel and provide an excellent way of finding these GPT
> partitions regardless of which backing device is actually being used (e.g.
> mmcblk0, mmcblk1... i.e. emmc, sdcard...).
> 
> An example where this would be handy is for interacting with a stored U-Boot
> environment. Another potential use would be to use one of the unused raw
> partitions to store information such as MAC addresses, serial numbers, etc.
> which could be set/updated "at the factory" as images are flashed.
> 
> Tested with both systemd and sysvinit on both rock-pi-e and rock-pi-s.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  wic/rockchip.wks | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Applied to meta-rockchip, master branch.
