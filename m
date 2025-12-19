Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC37D78777
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 13:43:09 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16944.1766151786047540481
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Dec 2025 05:43:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NXVhSSYZ;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-889a865bc1dso14034486d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 05:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766151784; x=1766756584; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSuAWBXAd9JcW3sVfERE5qqc6c4qEf6pqG9MtBwrtyk=;
        b=NXVhSSYZ0ZSFutd3BeVFrfgszb1L7Tuzgw+Hx0TKOwK2eOgTaP1wguEs9RgqvdRoTb
         RpubABMrUFGFWKwqVfOw316dwIvFiQ4eXc5KmPxMDwJdgwNMxV9XaeDc+dRcbPERyPbt
         1C3Rw9WVQgVPeI7NfgkwLw6A2E/f1S+OzY26RdsltFY0x0gJLcVxYco7geMMCi4g4B/X
         yvc2Lz4HWMyJitoOAvjHY+fJ2nqHPMTfJDDfCSYRMbad01cAkyfGnTyG8jATyb5lBFKb
         gZQDtciXTtJ2RHCGCw8zcxNxt5OcXLtesUvIIBRd5vVbLhYbqhAnkhya9JsC/6ZX5hd8
         FnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766151784; x=1766756584;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hSuAWBXAd9JcW3sVfERE5qqc6c4qEf6pqG9MtBwrtyk=;
        b=KXLRmGxt8MLCsta1mVXbA7o0QS/VNvx3HNC+djaxhFQKQOTAykjNNJUj7WzRpJM8zH
         izbTlm8qqI4nic/MFYiT5ZWJlIhNisUR+zHtAsAUZNzNPaFv3GFaLGq7ElhVcQbMbvfn
         2UCQRr83GR+nwVAet9yVgSbHkOo9ImDaBtkEonW9nmvjf3offV9X3T9YESWDTNm7foXz
         TbXES9fJ1g4Tr9yB5jVeMVdAS8D4xPilTBqiQhKoG8bOfArPTvwwihCnxsrOzxKdA5s+
         kyYXHUb6hPkTlXEnK1gUDagjw8iG6JKovuRg3UKwWI3GnUz64pEQYDVi+4OuPZbWsdeI
         16pA==
X-Gm-Message-State: AOJu0YzbYKCIxJbxdDFAGatB1hWrP3yeTT8Rab/PMpiZRvw6II5UxPKU
	tGtEAnJJH47jCmTRT7ZbM0+nmQVpvtbb3gpKSgOJ8UG1JFtjEVzrGxCWtINPIQ==
X-Gm-Gg: AY/fxX7HPvpbSbMVo4Gkq9iHJZ9Pw/U0WBhQLcuGSxv8qlMl6BSz249fTSp76RI+Cee
	aXQa4ky2QyXT2EbT3LyOj0Kch+dHnRXo5imNA4cVC51+8hKx85mdgF1V13whAPpOpOQVx1h8MfK
	BogDjmbAbXm8s3GN4sBg5kuczLSdOAiX05gcoHr5Q2ZK3weuVon7JMeKSk7uXTFksLB987K+Sas
	7CZSD39hvTLqXhkHGHCxdsQUDS8xPQ/76btNSiimFFAc4clwCK4jg3B+XGisDi/LZbkckJil48a
	UnFVbeCsILTqj+rzbmY5AgyxCU9i2a/LdONhXP1fDUgH88CEq3jY3oeoA2pgNqK7JiV4ZnlA5Li
	aAMh2i1x1LJAxYd35GI0LILwXRs1ffCYc6ScLv31e3b6kztwpc9ytsXsEzFlclG4LrpB99xiJAu
	iuBqep+8nq+5oR3LkQG1espkQE9reKmeHPBEJU1w==
X-Google-Smtp-Source: AGHT+IHSWySpCXQS8L9juwlWRzZof/0OGWqULWOIGY+7Yk3LTt+yFyEH3k9O3MUUT5CaMBLQHJU9Nw==
X-Received: by 2002:a05:6214:498d:b0:888:81ad:16b0 with SMTP id 6a1803df08f44-88d83d65945mr50591926d6.53.1766151784439;
        Fri, 19 Dec 2025 05:43:04 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0971ee182sm180457785a.33.2025.12.19.05.43.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 05:43:03 -0800 (PST)
Date: Fri, 19 Dec 2025 08:43:01 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 2/5] provide kernel *.inc
Message-ID: <20251219134300.GA28429@localhost>
References: <20251219070014.39432-1-twoerner@gmail.com>
 <18828BC83A0901CB.1614991@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18828BC83A0901CB.1614991@lists.yoctoproject.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 13:43:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2832

On Fri 2025-12-19 @ 02:00:11 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> Consolidate the two bbappends for linux-yocto and linux-yocto-dev and
> provide the "guts" of the rockchip additions in an *inc file which could
> be used by other linux kernel recipes outside this layer when a rockchip
> machine is used.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  recipes-kernel/linux/linux-%.bbappend                          | 1 +
>  .../linux/{linux-yocto_%.bbappend => linux-rockchip.inc}       | 0
>  recipes-kernel/linux/linux-yocto-dev.bbappend                  | 3 ---
>  3 files changed, 1 insertion(+), 3 deletions(-)
>  create mode 100644 recipes-kernel/linux/linux-%.bbappend
>  rename recipes-kernel/linux/{linux-yocto_%.bbappend => linux-rockchip.inc} (100%)
>  delete mode 100644 recipes-kernel/linux/linux-yocto-dev.bbappend
> 
> diff --git a/recipes-kernel/linux/linux-%.bbappend b/recipes-kernel/linux/linux-%.bbappend
> new file mode 100644
> index 000000000000..34bf335d0b10
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-%.bbappend

I considered this one for quite a while. I saw it in Bruce's
meta-virtualization and thought it was clever, but now that I've slept
on it, I think it's a bit too aggressive for meta-rockchip.

I think instead of 'linux-%.bbappend' maybe 'linux-yocto%.bbappend'? or
'linux-yocto_%.bbappend' would be better?

> @@ -0,0 +1 @@
> +require linux-rockchip.inc
> diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-rockchip.inc
> similarity index 100%
> rename from recipes-kernel/linux/linux-yocto_%.bbappend
> rename to recipes-kernel/linux/linux-rockchip.inc
> diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
> deleted file mode 100644
> index 81d2b6d693c4..000000000000
> --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -FILESEXTRAPATHS:prepend := "${THISDIR}/linux-rockchip:"
> -
> -SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
> -- 
> 2.50.0.173.g8b6f19ccfc3a
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2824): https://lists.yoctoproject.org/g/yocto-patches/message/2824
> Mute This Topic: https://lists.yoctoproject.org/mt/116856174/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

