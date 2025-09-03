Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6274CA1009
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 14:14:42 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web11.13673.1756908876628531269
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Sep 2025 07:14:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kO1NBZsv;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b3289ed834so40280261cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 03 Sep 2025 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756908875; x=1757513675; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lf4st3+yidvefatG3XN4JH/TTLXTadzogwc3lGfW0SQ=;
        b=kO1NBZsv0NVTBM8LPG2kHkQaiYMY6cAUsJxcVJR7nqwfvCZDNWP5HKsXVQah7h4RKy
         YS63iLNEHTVqsRwIeitsxbS9kgMe+XmUBBetkhKcVsD5Cx403SNINorm1YDCoB0DU0j9
         YH9j8wVXvlMxe288+O2uAd8zZoqKlT8NGPnU4ox0LSPC/J2pIM7NSr9+fAI/vdyQ9ZXt
         WuHPbL4a1c0V4mVW7iq/Afs9CY+phZ6XAN7S8E43OhsZb6MAgZfQ/Gi7BU1nhuPybvEa
         j5+sA5SUiE6FWLZF8EFzkhJk8NIS+kEX7CBIFs3M4kDu0U9GuUyVHRI5jzNHna0UDfVe
         x26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908875; x=1757513675;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lf4st3+yidvefatG3XN4JH/TTLXTadzogwc3lGfW0SQ=;
        b=YnPLqCdENv/gfdpJHu5ZXjI5coWCHd/Himn9hN/KdaWivEdhZS4lEpVNE61ukDkxgT
         1jjFz8e8vkqiCiPaWt09AohnBmZmVrFqZiF4vPBt/sa4hTgU5Xx8+LQSZ5F3ibd1BrfL
         IJemeFMCyaODBppqyiFiR535cjFzt3/+ApbKbke6WwdQgzGhiJVqNYf91Ad0BQZ+3dpp
         CKEUMjnuuhFCkCAY7A/oPnZGep/HkacSZgeHZ+vcnM9P5SzqBanx/Bp8wJSKPE+p18VG
         el/xw17wp9KSNdjnuM0apH/s5MF3TNla1EU81muitSalEJbMtJzEpIWmnl8xiMng7I/a
         JTqQ==
X-Gm-Message-State: AOJu0YxRop4nmTUtWFm/9Ckv51raA+HY28mFY988fyrzHUt2OrgolJwZ
	upkSD5hQwwWtebiiJLLCHwls77XVdhrhKcoycGK1+J0g+dfNRQxsOrto/zFuFQ==
X-Gm-Gg: ASbGnctCPHNd9aCYQT5fiWewkcdhLsbNJfICM7YHsJZayhL3TPsIg59GNcQ2zN7XcMA
	IM+iCZVoPuPtgcP7Nusa5Ix3g0r/+hf5EKU4i89SOBMRfOhkXScv6lc5CeQrf4trZNUNZp6gTjJ
	/N5kWpzXLHkcWT61pHTinf1IHz2KAms1s94wQV13EhPYoUtsAAF1qkakvfmp9n3o++S27uS9lE2
	hxj2OPL6q6LXQs1CYvFGv8Setmwg51GceNxX3bus164TcQDWumePhDb9zG7EmxaIO8XFqfvyTrA
	B26HQgD6Rp2pNUbsV7rnNIqhJW4aOAXogoM6TerV0BiSFfF5GyXvE/hynPA5G6lPmngejsqb9xM
	97xz5yC+eXFKA18+Ckq7Hm9KQ2H8Ac6UHUWVxwjbgKeQ3UMh649jeYMbcKvTe
X-Google-Smtp-Source: AGHT+IFBMkOzcsCahqpErM0MjwX7TdN2YMha+k6MI/Po0AF4m/dBQbhJ/jsDqEfHwt65/ITzDGOeDQ==
X-Received: by 2002:a05:620a:19a7:b0:7f9:ec3f:b047 with SMTP id af79cd13be357-7ff26eab6cfmr1653052785a.2.1756908874776;
        Wed, 03 Sep 2025 07:14:34 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f658302sm11929841cf.15.2025.09.03.07.14.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:14:34 -0700 (PDT)
Date: Wed, 3 Sep 2025 10:14:32 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH] xf86-input-mouse: drop
Message-ID: <20250903141432.GA17386@localhost>
References: <20250903140251.39966-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903140251.39966-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Sep 2025 14:14:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2122

On Wed 2025-09-03 @ 10:02:51 AM, Trevor Woerner wrote:
> oe-core has dropped this recipe, therefore drop it here too.
> 
> Link: oe-core: 7c86172b7353 ("xf86-input-vmmouse, xf86-input-mouse: drop recipes")
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  conf/machine/include/rockchip-defaults.inc | 1 -
>  1 file changed, 1 deletion(-)

Applied to meta-rockchip, master branch.

