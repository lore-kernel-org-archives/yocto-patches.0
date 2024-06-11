Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F039C27C75
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 14:57:07 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web10.11825.1718117821433339316
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 07:57:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q1/Mx5EP;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-795a4fde8bfso64502185a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718117820; x=1718722620; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWBox+bokAaV4EOHVIh9UWIdVBg9xGLhmf86qwoVw94=;
        b=Q1/Mx5EPaMFbrUWHIWdmSSRGVvLyrKb/3UTF6ts2PP62F+RFgtjI47MZKoyOjJxyu8
         SSodYObVdQxn44jFcwlEEFjkrnSRjQtMJg1M6SpZgvYWyFZ7dv6jr9mwaQYJiKQrp23t
         vkq1ECX60DSAGlWnxL9LEpXi+B8734kCCLO2JY05peJltqyfu94g91MtgVKmzcw+DNpn
         fFDiIy8rTrA+RavldJCwyP+HysV7JL/o2r5GK22bbkdqMS93I7y2St34H9EncNrw/ycP
         bADvWB3SfCpIXXJpl0s8H8TukP4ETA0btkb7tMXLnu5LEkvp9qGKZncCWpNjWMBbOOfx
         kMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718117820; x=1718722620;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWBox+bokAaV4EOHVIh9UWIdVBg9xGLhmf86qwoVw94=;
        b=jsES0unAEq7z4LkPtphVc5v/KvMkc6sySwABqBeHtNo+jqnbgf7Ga2pyIoYB+0XhHi
         sZO52ICUIxHMg5G231K+6ouXxtmaLyW237xSlduzNGykcXCoa8fS0xGdHQDoPQ7DHEDn
         QygfPROW3qBQzBlqD/WLdEL4kMCiu7HLvB8G/s6t+r0TklBi0LRQerq9tc8vxOqyhxXs
         kfyIiqIy0NAVG/sEv15zhEAhIokPGrapgBlezEwx91XDdwqwYU5r7BqVafcVoJca8BfJ
         QSV1f6DDXoSh45uwNrNN0pnq3fp8Ie0ZMWOCINPwyBqtc5TbApGmy5mXKwsTDrfjTGmF
         8eTg==
X-Gm-Message-State: AOJu0YyHnXL6IgmEwajQZttUILvyaQZNb058utrgDtuZKyjlBL2J/Nqs
	pjKZzY0zE2CRME+mGXH6hQP/5UlAu5zB4LiZPDm64fR8eILGYHWR1TZ1Ag==
X-Google-Smtp-Source: AGHT+IEd7TM1bMbRAgycemu4X2jI+QbBI5c86Cc3dfgVBT3wOnwFjGQyE1q5hzXAMs0XUU4DxDBvcw==
X-Received: by 2002:a05:6214:5902:b0:6b0:86a7:cd36 with SMTP id 6a1803df08f44-6b086a7ce68mr44569236d6.35.1718117819466;
        Tue, 11 Jun 2024 07:56:59 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b0860ffaafsm15016806d6.39.2024.06.11.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 07:56:58 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:56:56 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: bruce.ashfield@gmail.com
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-yocto-dev: fix build
Message-ID: <20240611145656.GA7654@localhost>
References: <20240611140607.2719-1-twoerner@gmail.com>
 <7c50adeb-c82b-4a7d-b663-8f73a63ae5b3@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c50adeb-c82b-4a7d-b663-8f73a63ae5b3@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 14:57:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/302

On Tue 2024-06-11 @ 04:29:35 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/11/24 4:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> > The linux-yocto-dev build was failing with:
> > 	| ERROR: modpost: vmlinux: local symbol 'security_path_rmdir' was exported
> > 
> > Disabling some filesystem-related security options fixes the build.
> > 
> 
> Is this the case for every board, including non-Rockchip ones?

This builds fine with qemuarm64, for example. Comparing the .config from the
qemuarm64 build vs the rockchip build is what led me to the patch that I've
presented. The qemuarm64 build doesn't try to build the file that causes the
error since its .config doesn't ask it to. We're using the in-kernel
defconfig for the rockchip build so:
1) it's strange nobody else has seen/fixed this
2) why doesn't the qemuarm64 build use the in-kernel defconfig (or if it does,
why are these options not set in its .config)?

> Is Bruce aware of those issues? Shouldn't this rather be fixed in oe-core
> instead?

I guess I could give him a poke.

> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   recipes-kernel/linux/linux-yocto-dev.bbappend                | 1 +
> >   .../linux/linux-yocto-dev/disable-some-fs-security.cfg       | 5 +++++
> >   2 files changed, 6 insertions(+)
> >   create mode 100644 recipes-kernel/linux/linux-yocto-dev/disable-some-fs-security.cfg
> > 
> > diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
> > index b6a63d7b7b29..94bf737c63bd 100644
> > --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
> > +++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
> > @@ -2,4 +2,5 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
> >   COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
> > +SRC_URI:append = " file://disable-some-fs-security.cfg"
> 
> If it is Rockchip-specific, I would suggest using SRC_URI:append:rockchip
> here, to make sure we do not modify other machines from other layers
> whenever meta-rockchip is included?

Oh right, thanks. I don't think of that use-case often enough.

