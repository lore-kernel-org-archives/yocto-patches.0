Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAF6E77178
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 17:10:04 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web10.17094.1733418602795497272
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Dec 2024 09:10:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OskfvtPX;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4667cd408a6so19016141cf.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Dec 2024 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418601; x=1734023401; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGu/0pgnMlLGoP6+aplFcjU01xl3JrZjy5NjvlZJ1c4=;
        b=OskfvtPXLm4su/LKGstAQqyeEo1UWRtuHWW3IqBJE3/f3ke1ULwQFk8+vEXEMiBOXN
         zOWYfK7YmVqfaFRALB4P7/OqESkGv7sFhhvgPS4owAG6iFInPqy0C/SYzo7gc8XHnFBZ
         o5lnsW8t+Kli0PDClllKUEJ6fCwNgG7q5KrNjNiV0PEZG+b0yv86PNZeT+Mg4EPpenjU
         vV4idljGjWWvM28FZxbLj66VwwrTO2/LdujfRi3t4BWaIAyPkIjbMMpTayfV6UmY0fIc
         QFIBeaVoYORFY6B0NK5+AytWjpzT8/Az42BkzMwlx0gvIX15QKQSbPScWSQvILXcmA7L
         c2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418601; x=1734023401;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGu/0pgnMlLGoP6+aplFcjU01xl3JrZjy5NjvlZJ1c4=;
        b=PvC8oSCxxEIWbX8EP/oEreJ2CS5CAOGeohA1GaARJq1nq0qUJeWVnHFnRldcce2lDn
         MTjMCRbdtY1eqf5beEKxl2QfQWcudf8WU2XYC7oXcq4lSamsGxeqmhK4wQR8Op8o6sk5
         xq1FZx1uGZGXHFo9IwAt9EbQbJxO6nzLLqOh+hkn6YSlmDbPIEdgQw2tKIf9o0kWSHZ0
         ++EOF5cNbrybE/CtBsNe4JsUivJN6CKVDaS/SUGYabInST4DCfOhMmIjP8lMp56RWC6S
         6fM8mhxpqYsc69u8JuSYPsbGYQXl4nfEG+C5x0cWlz2MIGnanEN+JCXoBJQ6t1nnjWpF
         k+Qw==
X-Gm-Message-State: AOJu0YzgKmpfh/H1tExcKACKf6+7yQVMwYt/Wqv4iO266KvXRB13NhKg
	6HnXEQtsg4R1bJyVrBZsVwbSxLpjC9bkR6FBrGK1TDKsSYI6DCwMWpIfLg==
X-Gm-Gg: ASbGncsPulnqa6gh7DFgpBj0IoRQ+2kv0Tnlj9bAlZ8dchbH8cHTrKG2V6hlGo/pX1S
	HkzNvcEN2xh/S84YzlN+bopeOULYEQOuYgn9TRUjcoedKdAj+32tdKXMFaw6qQHoKWLt4zfynQE
	gZzY6+w7SczN5B3AJdfaOy5939w7S4Jg1tjinRnfbVXzp1tG+4Z6xsmH5Wtz+VNKcKRE3LAjA3E
	wnmyF0NIW+JJWshxWfPR6xcvymzMiBQ0r2eFwyKsLQuU+Bq/jSKe4j2PrkKJFotpoy4b9wBpa4R
	bg==
X-Google-Smtp-Source: AGHT+IFMgXCCtRkjMXCBqV4ZHAdHJq+KMkXhsc5AmMUN3xeTXG5ux7flec2Z5lidDQSEqIjmQBu1pg==
X-Received: by 2002:a05:622a:590:b0:460:dc96:27bd with SMTP id d75a77b69052e-4672797e983mr67132401cf.14.1733418601074;
        Thu, 05 Dec 2024 09:10:01 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4672978f448sm9768031cf.66.2024.12.05.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:10:00 -0800 (PST)
Date: Thu, 5 Dec 2024 12:09:57 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2 0/2] bsp: rkbin: bump to
 latest commit in master
Message-ID: <20241205170956.GA13285@localhost>
References: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Dec 2024 17:10:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/862

On Thu 2024-11-28 @ 04:58:48 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> We've been hit by random RCU stalls, system hangs or resets on some (not
> all) of our RK3588-based products running some old BL31/DDR init
> binaries.
> 
> Upgrading to latest commit in master branch seems to mitigate those
> issues, so let's do that.
> 
> Only build tested.

If I wanted to test on boards without having to yank the SDcard and re-image,
I would only need to update the idbloader.img in /dev/disk/by-partlabel/ ?

> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Changes in v2:
> - use version and filename variables instead of using glob pattern for
>   path matching the DDR init binaries,
> - Link to v1: https://lore.kernel.org/r/20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de
> 
> ---
> Quentin Schulz (2):
>       bsp: rkbin: rkbin-ddr: use version and file variables for path matching
>       bsp: rkbin: bump to latest commit in master branch
> 
>  README                                      | 15 +++++++++++++++
>  recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 20 ++++++++++++++++----
>  recipes-bsp/rkbin/rockchip-rkbin.inc        |  4 ++--
>  3 files changed, 33 insertions(+), 6 deletions(-)
> ---
> base-commit: 3a8be31581651ced6c27f5bad1333064e513a8f0
> change-id: 20241127-rkbin-bump-4cdfb23aa49f
> 
> Best regards,
> -- 
> Quentin Schulz <quentin.schulz@cherry.de>
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#857): https://lists.yoctoproject.org/g/yocto-patches/message/857
> Mute This Topic: https://lists.yoctoproject.org/mt/109823578/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

