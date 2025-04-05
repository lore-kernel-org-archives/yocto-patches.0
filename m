Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D941DC36010
	for <webhook@archiver.kernel.org>; Sat,  5 Apr 2025 05:03:21 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.1159.1743829397103382420
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Apr 2025 22:03:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GMR2BC0d;
 spf=pass (domain: gmail.com, ip: 209.85.210.180, mailfrom: raj.khem@gmail.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736aaeed234so2289165b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Apr 2025 22:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743829396; x=1744434196; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6B+0rjHWS3Hs5VfB+kN6W+4hbqSdTWjUNw7eeSXdUo=;
        b=GMR2BC0d/5iQnlFyESFHMb5rHFcTh8D8mHASUbz/eIw+GjeDebkWlHEiZiNCVdp9mo
         L139axQx889nIdtIrhsqEvSs7DSXFTJyrCdVknEUHZrZIxpzm1JE5TVrFLBURqmBdl0g
         dd3SItHnojzf/Ak0cgOmtf8gsMyHxEZWRCHLNJPZ7YvT/LgB9aT1jxa8tYsCF3tov8w6
         dZY8Uu+1HB3zmSkUh0T6qIC7Sy5RZ3UZy4f7JuawKZ8w4HSOoDhty6ybuETV9jZWn0Vf
         X2/0RpAz5++RiVoVk8vS15uLW9JlpVv80uhJWM2ITaGJ719A2VcAo74KqEnYnop8yiGa
         AoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743829396; x=1744434196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6B+0rjHWS3Hs5VfB+kN6W+4hbqSdTWjUNw7eeSXdUo=;
        b=Wq7FU5UfiCpoa0MSKEwG/DpAJvrfQ73Smus7mJRXxWSmHcWbBQcPVWlAKp37rbSy4L
         QJfIIGsZm7S9iFKdyYNNo3SrXvgP9tob0BbAsKBZk85AqwaC46iU/V1wvzeqK6s9Uz0y
         TMr93Ehoe4C9FES/blBYsICxFm4o4GNq9/y3HK1RXBXJeXIkABGOgrbtcHk+dqYTQQFH
         07vm3WEnffwFoSmSZqy/Uc+ux4vurJlhA37yd+m8CJVam8k/6X5XaugVpry0nA/07VW7
         jc6+8dQffxQ0VbC6/1eCVfRmvLWaZE+KPcHDkPY2uADU2OljKg8+rS3mQnocR4gzzzzI
         PgWQ==
X-Gm-Message-State: AOJu0YwONY/+4FsGjaeJQYFaWD7z+Vz5kbcCJ9B6VH45XFRblvjZz+u+
	P0EY/LYv0Or3xC3Kl7j+oTh7/yeFat6LEFaqNhUHAbHNhylN3Du+Axnj1shZ
X-Gm-Gg: ASbGncsRsQXdE2ZUpXuqdSNkzbDd2AiQ3RVXYrGyptb4mYGho0p3T3gnjKq+zhZ9zwX
	0xBA1wf1TrQkI/AJubipHR6mfhwC2tou7KOXGRKeqf/0c0FkB+SR2aSAUd/gKL1KRiDFtrTnk6C
	cIcSJ8O6jFhgOoz06CnIypTEm3p6Sp7oXarIf+4NsnurV2dSekSk3gTF1xhmDN0YSi7tNNG+Qcw
	0AccX4h2WVLu50aOdLHScG04uE5kGWl4DrmRT7BbNMq0LqEuIQ63tihf9gwSB0bvqESh1spwJBr
	4NfzoupDeR8rO4+RWr953uQyUxKp1uM7zgbvlsVhnU3MWs1LK/MnOOaBMehXdpQHxucDgte0b4f
	/7WjoWp36OXvOV9V6iNfIwjOslfP83CF0
X-Google-Smtp-Source: AGHT+IEFilpXoK2S8M9wWZzqqKOhj8v3eZNg7G+O6Ruvr7F5xV00tSbYbIwDGpVPi+4GoWVJuhxGqQ==
X-Received: by 2002:a05:6a00:3009:b0:736:4abf:2961 with SMTP id d2e1a72fcca58-739e7120132mr6233857b3a.17.1743829395950;
        Fri, 04 Apr 2025 22:03:15 -0700 (PDT)
Received: from ?IPV6:2601:646:8201:fd20:ec3d:c567:e156:a268? ([2601:646:8201:fd20:ec3d:c567:e156:a268])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee2b3sm4376980b3a.46.2025.04.04.22.03.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 22:03:15 -0700 (PDT)
Message-ID: <d8508244-5fac-4264-8b10-e65ffb6db329@gmail.com>
Date: Fri, 4 Apr 2025 22:03:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][PATCH] zephyr-core/zephyr-kernel:
 specify newlib capability with cross-compile toolchain
To: yocto-patches@lists.yoctoproject.org
References: <PH0PR10MB700766691D9D809FDAB3B7BEF3A92@PH0PR10MB7007.namprd10.prod.outlook.com>
Content-Language: en-US
From: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <PH0PR10MB700766691D9D809FDAB3B7BEF3A92@PH0PR10MB7007.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 05 Apr 2025 05:03:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1284

On 4/4/25 12:09 PM, Nicholas Lowell via lists.yoctoproject.org wrote:
> Zephyr upstream reconfigurations now require either the CMake variable
> TOOLCHAIN_HAS_NEWLIB or Kconfig NEWLIB_LIBC_SUPPORTED in order to build
> with FULL_LIBC_SUPPORTED and NEWLIB.
> 
> This cross-compile toolchain does indeed have full newlib support available
> so we need to now specify that so it can be used.
> 
> Signed-off-by: Nicholas Lowell <Nicholas.Lowell@lexmark.com>
> ---
>   .../zephyr-kernel/zephyr-toolchain-cross-compile.inc             | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-cross-compile.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-cross-compile.inc
> index 2f1ea37..f26683e 100644
> --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-cross-compile.inc
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-cross-compile.inc
> @@ -6,6 +6,7 @@ SYSROOT_DIR="${STAGING_DIR_TARGET}"
>   EXTRA_OECMAKE:append = " \
>       -DCROSS_COMPILE=${CROSS_COMPILE} \
>       -DSYSROOT_DIR=${SYSROOT_DIR} \
> +    -DTOOLCHAIN_HAS_NEWLIB=ON \

Even if we do have full C library, should this be part of kconfig ? or a 
packageconfig that is left for user to select ? does it impact the size 
of final ELF file if this selection is enabled via CMake

>       "
> 
>   OE_TERMINAL_EXPORTS += "CROSS_COMPILE"
> --
> 2.43.0
> 
> Lexmark Confidential
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1283): https://lists.yoctoproject.org/g/yocto-patches/message/1283
> Mute This Topic: https://lists.yoctoproject.org/mt/112090624/1997914
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1997914/645821814/xyzzy [raj.khem@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 


-- 
-Khem

