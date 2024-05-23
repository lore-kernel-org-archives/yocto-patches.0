Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6666C25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 20:29:15 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.1096.1716496146776861651
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 13:29:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ex19ehQj;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ab9ce74bddso1084436d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716496145; x=1717100945; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fi1723j7E8q2z3hqmCZTOvMHgvpvpiz3UWko61aYdXo=;
        b=Ex19ehQjDidX4YFq9fv0Mq+jiErmnas3tu5Su7LUTETB/CrUTGqjzHR2wadElKRy+I
         asMlRJjO8rH6q0pqVcKRyGsH2/CZ5M7ROvXoYDrwDSInu4RQlDhI4LjZ9hAIImKFAKIK
         Irp1AASPj720/rEaviccJpEi7LnaRZ3SPXbRqM4x4iiYoTSNwcnHQM0r5J2p88gPxBtA
         STCQWPQANrGZIrrT05aNw1O3eZyozy7zYH/l4nAmFA9bWEGRsfMZ7kA34X++3ousqckN
         YlclqgVD1SmpXsgMdxfWzgQar/npyQZlm+YvuTHdneHI4eL+qWjMlyPPDihq/35+CGnU
         coaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716496145; x=1717100945;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fi1723j7E8q2z3hqmCZTOvMHgvpvpiz3UWko61aYdXo=;
        b=GbWcOgjHLnjUS3TuUwe8J6DrAX/BTW1zfi/f0TdnWWuTkKhs6Rg5ZbvQPYEAPDLmGc
         vHsz6A1eViLE3HxbTUAiP49XkSZbPc5x7CVcVqxqEZu15+u2ExoVEAJ+wR2tN3H+ncE8
         GpcAIKRy3teHyYSDtU1oXRGbwJIegqM/LSEWY0kBP4iV6yTPDavLbzoW273pi4vPl1m2
         X70KPPj4i042m5mzTFp7DWeNmgthJSUyrFj+O7bQyYPVoYb5AzjJCtziau31wM0VNrKP
         Ff6L3X7QYVPRJ2aleWCdU+8+pMQbjJ0YLX7HTwRt25CV6QY5Cxm6x81TBeD1txmvauL2
         uoBg==
X-Gm-Message-State: AOJu0YyXxpBgtCDcRkgxJfb+cBPjpcGVypCeDn2RQo8od6qDN8NGeTre
	2GGAF6Ry6TjrSqA7s8BMaKKwRl74QK6947s1jlu4FsoKD7ejDHJDx5AIfQ==
X-Google-Smtp-Source: AGHT+IF+Sd0+hKwWvVSgoh3GE6lydLFev0ZhXnJxxTA19xCHD1qaA5TISE9Y4gpxczYcFOpGlxY4kQ==
X-Received: by 2002:a05:6214:3986:b0:6ab:70c9:6253 with SMTP id 6a1803df08f44-6abbbc97979mr1697636d6.1.1716496144970;
        Thu, 23 May 2024 13:29:04 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac17ddb6b1sm110226d6.132.2024.05.23.13.29.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 13:29:04 -0700 (PDT)
Date: Thu, 23 May 2024 16:29:02 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 1/4] rename root partition
Message-ID: <20240523202902.GA26177@localhost>
References: <20240522230808.14409-1-twoerner@gmail.com>
 <b34f9407-1c1e-4502-b76a-ea4e839a2f3a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b34f9407-1c1e-4502-b76a-ea4e839a2f3a@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 20:29:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/183

On Thu 2024-05-23 @ 09:52:21 AM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 5/23/24 1:08 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Rename the root partition to "rootfsA" in the off-chance the user may someday
> > be interested in implementing some sort of whole-partition update mechanism.
> > 
> 
> But... wouldn't they need to write their own wks file for it anyway since
> they would need to add an additional partition?

Not necessarily. If you look at the example I give (patch 4/4) I'm not
touching the wic file at all; all the repartitioning is done via systemd's
`repart` mechanism. This has many advantages!

wic isn't "target device" aware, so if you flash it to a 16GB device versus a
32GB one, you have to design your wic to satisfy the smallest one otherwise
the bmaptool'ing/dd'ing will fail if your user uses a small device. If you
target a small device and your user uses a large device then they've wasted
space. You either have to hard-code the sizes in wic, which means you have to
make assumptions, or let wic do its "i'm going to take your filesystem and add
X%"

Secondly, if you add multiple copies of your root filesystem in your wic
layout, then when you bmaptool/dd your image, you're wasting time duplicating
the root filesystem a 2nd, 3rd, 4th... time, none of which you'll ever use. If
you have 2 exact copies of your root filesystem on your drive, you're never
going to reboot into the other partition as-is, you'll update the other
partition, then try booting into it. So adding additional root partitions via
wic increases the image size, increases the flashing time, and it's all
wasted.

So solving the multiple partition problem via wic isn't a great solution.

Using systemd+repart is perfect because it allows your image size to be as
small as possible (since it only has the one root partition in the image,
and it is the normal "size of partition + X%" size), but still have all the
additional partitions once you're up and running. The existing root partition
will be expanded, and additional ones added. And the user can specify their
sizes as a percentage of the total, so they're not needlessly small on larger
devices, or require a minimum size. There is a cost the first time you boot
while systemd does all the repartitioning, but that's only paid the one time.
In theory you could change your partitioning scheme by redefining the repart
configuration files, but it may be anyone's guess if any specific change might
actually work.

> Basically, I'm not sure we need to half-support those use-cases :)

The one and only root partition could be named anything... rootfsA is as good
a name as any ;-)

> Otherwise, looks good to me.
> 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   conf/machine/include/rockchip-extlinux.inc | 2 +-
> >   wic/rockchip.wks                           | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/conf/machine/include/rockchip-extlinux.inc b/conf/machine/include/rockchip-extlinux.inc
> > index ca33f4c7f42a..ab46b76d33a1 100644
> > --- a/conf/machine/include/rockchip-extlinux.inc
> > +++ b/conf/machine/include/rockchip-extlinux.inc
> > @@ -12,7 +12,7 @@
> >   NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split('/')[1]}"
> >   UBOOT_EXTLINUX ?= "1"
> > -UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=root"
> > +UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=rootfsA"
> >   UBOOT_EXTLINUX_FDTDIR ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"
> >   UBOOT_EXTLINUX_FDT ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '${NONFITDT}', d)}"
> >   UBOOT_EXTLINUX_CONSOLE ?= "earlycon console=tty1 console=${RK_CONSOLE_DEVICE},${RK_CONSOLE_BAUD}n8"
> > diff --git a/wic/rockchip.wks b/wic/rockchip.wks
> > index bc65f73b0cf3..e1d74d9983ab 100644
> > --- a/wic/rockchip.wks
> > +++ b/wic/rockchip.wks
> > @@ -26,6 +26,6 @@ part uboot_env --offset 8128s  --fixed-size 32K   --fstype=none --part-name uboo
> >   part reserved2 --offset 8192s  --fixed-size 4096K --fstype=none --part-name reserved2
> >   part loader2   --offset 16384s --fixed-size 4096K --fstype=none --part-name loader2   --source rawcopy --sourceparams="file=u-boot.${UBOOT_SUFFIX}"
> >   part atf       --offset 24576s --fixed-size 4096K --fstype=none --part-name atf
> > -part /         --label root    --active           --fstype=ext4 --part-name root      --source rootfs
> > +part /         --label rootfsA --active           --fstype=ext4 --part-name rootfsA   --source rootfs
> >   bootloader --ptable gpt
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#172): https://lists.yoctoproject.org/g/yocto-patches/message/172
> Mute This Topic: https://lists.yoctoproject.org/mt/106253213/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

