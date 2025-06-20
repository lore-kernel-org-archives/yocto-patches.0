Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FC4C7115D
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 12:10:57 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.6306.1750421455996570153
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Jun 2025 05:10:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kDkvXVme;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: skandigraun@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso2809041a12.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750421454; x=1751026254; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xsLxdRbsZePdnXWGgn9l43GESGFtaZB3KNqbgB8H54M=;
        b=kDkvXVmekcYOacAmgYK4QXsRKA9jyszM81zp684LVe6NC4Xd/YnDQ8VUGUazfHt7uC
         dlYNgznH5+cOpP62hAr/vpuiH/czwwoMunCzQ5W9fRFXXqd0uVW8kFH5CVI1g3BW4pFX
         VDNfdXnq17PNglzs8jeg23ApbWutU4Y6djzvTptlrS7hb1vpAXA4POjd4rKnfhyYvUrd
         gYNWVgipt/jvhuC/qE5iQhk2jNbvx+aX7sreHC65vbpD/cSPqURevxwnB0YsKPp9B6H6
         a5v2iiogqePjFXP5CtIANbo6zRIrLkKsG4S6xS82woN1CvxeuTb9vh/AeCMy0qGPhNiG
         yXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750421454; x=1751026254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsLxdRbsZePdnXWGgn9l43GESGFtaZB3KNqbgB8H54M=;
        b=m19Pt9TMN6QJRV7njPk8ZT8atY3KjLr5No9Ayul279gH4TjnJ4g8eQd3di25FqP8bD
         OSXxehzIZ8N/bbN21ZQpRF7yvS/4nUx6IpA6ldhaQc/uBk1wBKwYmqYN9MLp0D/v9Xgy
         ccFbA1Q8G+xDiwr6DBmq1MWkD6hY9Q2OQ7Cvp6O9+ur4hh835wszFhjBOBgvis9kNHWj
         2Cf6Vr4zQ3d69kDMu/DrnI1Uqg89qNwgmv/A0+qS0QQ/Ke/3vBzLPVu6i8VZykQsOmGd
         Og3BBsZ40FWqeNlNKB4TsXnAadUKtJFXVJIDWwNzjTaiESgcsvk3l5c4u6ahLaVFzQl6
         KEhQ==
X-Gm-Message-State: AOJu0YwPMNhyn/bybTyNl0K49Ku58LYM+GA/R9w2i5AZLp/YW8vV7Tam
	GVe2BymG8P96AUPG56RLEG4tRLuW1ZOWI+kDMmS+lBPDpkcqOS5VxlWvXRUqoeGk
X-Gm-Gg: ASbGncvVZuqt46cva3iWM7xQJrjJbEFyN2HzdyTeLQTebkEI2miuPs7hhQ9u3ZNyQ1j
	QPmKJDuQiyW8g4wu3I2doYkz6VzWR22n0ebPF0olhx9ShHmyNxx50Hc+05DzkSw8AVWjnivTTVP
	Vd/pzph1q6mj4v3z71UbgHzSPiYL/Ubq3Cj1biWkxjsIqnL2b34J8KT7Guja4/GW4lM+HN53eKH
	zOqYGboUQapEGU6Wa4AiaGHOgHBbGiFiKaJRLRGT24uODa6pe6G3trkSlcAL95EiSSiR3zeDZiV
	jltotSuf+EeX29ZJ+8L6kq0enMmTiGmbw+PNAhBd5r6P/7JfAEpCIXnOA57+TEV2LVV/iw==
X-Google-Smtp-Source: AGHT+IFhtEu1rpDGJVdWIwxSnS3ZaNwuZ8SMSX4Ap/XGPfmX/B6RWUAlA0rIxUEiaT9DwF0Tx9kelQ==
X-Received: by 2002:a05:6402:2746:b0:602:3e3:dada with SMTP id 4fb4d7f45d1cf-60a1d18eb87mr2119364a12.25.1750421454241;
        Fri, 20 Jun 2025 05:10:54 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a18504ef4sm1344925a12.15.2025.06.20.05.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 05:10:53 -0700 (PDT)
Message-ID: <466956ae-7eee-4f2b-9912-28686d756338@gmail.com>
Date: Fri, 20 Jun 2025 14:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-mingw] [PATCH 2/2] layer.conf: Update to
 whinlatter release series
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
References: <20250620120810.2480232-1-richard.purdie@linuxfoundation.org>
 <20250620120810.2480232-2-richard.purdie@linuxfoundation.org>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250620120810.2480232-2-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 12:10:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1672

On 6/20/25 14:08, Richard Purdie via lists.yoctoproject.org wrote:
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  conf/layer.conf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 9fb0473..0a00dd3 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -16,5 +16,5 @@ addpylib ${LAYERDIR}/lib oeqa
>  
>  LAYERDEPENDS_meta-mingw = "core"
>  
> -LAYERSERIES_COMPAT_meta-mingw = "walnascar"
> +LAYERSERIES_COMPAT_meta-mingw = "whimlatter"
>
Typo: whiMlatter

