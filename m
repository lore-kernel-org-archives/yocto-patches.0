Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7347C25B75
	for <webhook@archiver.kernel.org>; Sun, 26 May 2024 13:29:16 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.web11.6543.1716730151457020017
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 May 2024 06:29:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BEGMSIkc;
 spf=pass (domain: gmail.com, ip: 209.85.128.181, mailfrom: twoerner@gmail.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-627f3265898so45038837b3.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716730150; x=1717334950; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciUY0hBOmBuvzsO1yflwQwcSC8Y5qWzgWqNT8jod9b4=;
        b=BEGMSIkc2R9gCG+GSAQfw30kaR5TNiKKCWen5fSSloQEJD1jaKf6a2BVumTRwhiovP
         sXtpnaDG4NscKu00tYwDve3PkR8T43oH6g9/hycmoqhjwBRKt5ofVtEDF5Vilya2eYrS
         K2/SfVqs0UuLFEoaWvw3d+iISfgpR1hQCPa46gVqEGKYKqGSSSdDK1jlSO1f/hCBly+c
         QlI+TXDRTUsEM9rsC03jI6Whun3ucCSS5sC9fHgfr6FXo0fwJLnBoF/dLgqUYtezzfHV
         1e3/y8rS96+BEm+5R4xzuotGTbaSbYJhlLtjvTIms+1ufjnSEWyXdioQg/1kcqqdPjSL
         GRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716730150; x=1717334950;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciUY0hBOmBuvzsO1yflwQwcSC8Y5qWzgWqNT8jod9b4=;
        b=PcSQ0MaMCFydbrukr+DkCFL/9bKj1YaaMMBIxZhxwYg/o53rFSjcJJc5OhNIhhB2dH
         wCU6XGUC5K/YkausijX8/hTl4MR+uMYQTlOSNzsYukZQ7kVP/RuZ1ygngtelir4D8LNL
         3+m7g84A0QbuR1VKH7cdxGFiYZ0UkI0XQxCUFal8Y/SWxWjYi4Z8Y5JwX9e+ejz+hTQb
         xtTSacHcVvfLWBFvepiKxaXqVUFM5QP/FI7Lt+Cb1smCeph5jNZKnRZLK3IIwu1MeLz1
         CeMMtX3shRx5w/7blPbMRiusnvxALd1yxqVLSIa8YgrHoB0xCH5f472WiBS8/3lAYAdg
         eT5A==
X-Gm-Message-State: AOJu0YxpcfR4Nczk36a5mbjuhyvuWz4IbbWZrIxnm/C0EQf/osXW/GDt
	dv55Za3VnuA5XgMYFu0TQJgc9X2uvs3Y01ja8EUGBGxuOWT+yvRkmDnuNA==
X-Google-Smtp-Source: AGHT+IFdzai8q3wSfXyQx0+lxhhqzkF8pBBOmNa/rZ0/EUUIe08ImhpNDsecum31jx+6ICdz8ijRCQ==
X-Received: by 2002:a0d:ea04:0:b0:61b:3356:c59f with SMTP id 00721157ae682-62a08ec4c9fmr62301687b3.35.1716730148550;
        Sun, 26 May 2024 06:29:08 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcc0c04sm226984385a.44.2024.05.26.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 06:29:07 -0700 (PDT)
Date: Sun, 26 May 2024 09:29:06 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 3/3] u-boot: remove
 upstreamed dependency
Message-ID: <20240526132906.GC12513@localhost>
References: <20240524023724.20109-1-twoerner@gmail.com>
 <17D24C42F9948747.24662@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17D24C42F9948747.24662@lists.yoctoproject.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 13:29:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/201

On Thu 2024-05-23 @ 10:37:24 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> The dependency on pyelftools is now in upstream oe-core making this one
> redundant.
> 
> oe-core: 70eca6a5ccf4 ("u-boot: add missing dependency on pyelftools-native")
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> v2 changes:
> - add a git fixes-style link pointing to the upstream oe-core commit mentioned
>   in the commit message
> - added Reviewed-by tag
> ---
>  recipes-bsp/u-boot/u-boot_%.bbappend | 2 --
>  1 file changed, 2 deletions(-)

Applied to meta-rockchip, master branch.

