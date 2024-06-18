Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9BDC27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 12:20:43 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web11.84720.1718713235445290347
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Jun 2024 05:20:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E8fhRpFj;
 spf=pass (domain: gmail.com, ip: 209.85.222.178, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79a3f1d007fso253966985a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718713233; x=1719318033; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yg3bFma1S42H1vWXAnVjofBELYfgHw1QTXuPLYtMqFs=;
        b=E8fhRpFjqeTUPkgCnZn5EgNalS01fGeVFCt6RRhQOcbNQdJ0U9s2lDROMtTOwBUAZd
         RFBd5Q38bMZzs3RGTzquIYITuldPMWvl1zjc+tlGaIs5A6qFa0i6V4zm+rbmOq7isx9D
         aFUcGzNI7RAHeqMkI3URLEdL3psZ6Pqf7kdzjMDBR6E9OTi8yr8JCF4+X5WPcHHC7Ivo
         e/BnoBC5iUHi57HwaPXwZtak7KQo5K3R2w+qAc/4FODfE1LRKmJNGilZumRglihf976S
         LTKLRdejLLgXTuDAh/3ZdBZi1biCpfgNOMUzQFfPeZnVCXh9TLEdscSVUT8YvrnYnQEY
         fo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718713233; x=1719318033;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yg3bFma1S42H1vWXAnVjofBELYfgHw1QTXuPLYtMqFs=;
        b=fy00efo56X3TUMj5ThMXb4jYl+Qn5iI98ApjZAVOvl5Uqn9VU/YR7cQPb6DV38hEh2
         7pzRFb9zIwUApplwuzB8oj2qy9UNjcadWmxuB3tHUOaHQZk27AGA5mYPiV8xU8GLoKW6
         YOOh5eFEXugyq3UBYQ0L3bNkhF2nCNNpKh62Vq072CksSWrRMEeWHe8M0ATGvW/ATc/y
         x8iwvXuhAQqwu7UR9cq+UnsOVVyeY74VklDJcFF4mWYYh9tjWaMAF8GUt+NKkLc7yi+2
         YnAPQty//FmXrFl5j9Y0/WekFqdTuibbLb5adYwBPLRYfy1yks6l3QDrHWnbpULWRj2z
         TmoA==
X-Gm-Message-State: AOJu0YyhAtsNSRGqhF6UnQ5RRyXEaVkLVIBjIM93NUTL7YHn+QJnjSAo
	MF9LE2jAQLdUvYhzxr0h5BXpU8swS2KZb7dyO8At0ZBtRdDyjeHZML6YGA==
X-Google-Smtp-Source: AGHT+IEnNRan9tI6l2T3hXKpuqZqtDvSdVDIMLujtSMJvCmJn9EwnIOil3jEho75OWAifklnQAPgbg==
X-Received: by 2002:a05:620a:4144:b0:798:1dd6:b6f6 with SMTP id af79cd13be357-798d26a9228mr1522519685a.76.1718713233434;
        Tue, 18 Jun 2024 05:20:33 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79a39572796sm317864985a.25.2024.06.18.05.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 05:20:32 -0700 (PDT)
Date: Tue, 18 Jun 2024 08:20:31 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: mbober1@gmail.com
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] mesa: build panfrost for
 RK3566 boards
Message-ID: <20240618122031.GA11578@localhost>
References: <20240617200024.389206-1-mbober1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617200024.389206-1-mbober1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 12:20:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/340

On Mon 2024-06-17 @ 08:00:24 PM, Marcin Bober via lists.yoctoproject.org wrote:
> The RK356x SoC family (of which we currently only support RK3568) has a
> Bifrost GPU that is supported by open-source Panfrost Linux kernel and
> Mesa drivers, therefore let's build mesa with Panfrost support for
> RK3566.
> 
> Signed-off-by: Marcin Bober <mbober1@gmail.com>
> ---
>  recipes-graphics/mesa/mesa_%.bbappend | 1 +
>  1 file changed, 1 insertion(+)

Applied to meta-rockchip, and sorted numerically, master branch. Thanks!

Thanks for the patch Marcin! The git repository originally rejected your patch
because the Author email address was strange so I had to adjust that as well.
In the patch it is:

	Marcin Bober via lists.yoctoproject.org <mbober1=gmail.com@lists.yoctoproject.org>

So I adjusted it to your actual email address. Perhaps you have a
misconfiguration in the [user] section of your git configuration?

