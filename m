Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A32E77180
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 09:21:59 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web11.16036.1733995312522436785
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Dec 2024 01:21:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eQm72i+Q;
 spf=pass (domain: gmail.com, ip: 209.85.208.171, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-300392cc4caso3508371fa.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Dec 2024 01:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733995310; x=1734600110; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Im4MtcDj3tt2N7cPiQTgtu5bFowKXlwi+3VMPVXwmk8=;
        b=eQm72i+Q9CWCzMKfBbFANyBbqw+IgbvB7P+T0P+5etYpJ2uGoVhTx0Kbn9Vu9/jNMp
         LuAdCXSSGMpYu5hti6MGfZXq2umhhkZOAeBvOSvqchq9x6Qn0q6GpN75q5V2WVYQE+bm
         vZU85Bw3MY6onZ2prDfktcc9jXxKpjwjig3YZn34g368P5ukpVPCKFyXoa+S2GlJ/Cir
         cvBbTROSbJrQz7EJXF6QNEYKnZvCJt+AIMi5VZDGKl/mq+2W6bPUDjqFCfUxO+hoc1bu
         i3VnYjPocEG49Ic4CmNk6IDYlh6O+YgYFGP/0XjP6S5LSGxaD5Fpr0i484eL2/7XmU9a
         AUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733995310; x=1734600110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Im4MtcDj3tt2N7cPiQTgtu5bFowKXlwi+3VMPVXwmk8=;
        b=vvlCghYruidliZi8c+EkcrtQI+xdRUSJ94+qxdGtlptuhvMQy4HO0y5lNr073d/bLh
         5wOlN2hU+gnzwhNXHT/WdCOoK2K+LR2nA0QtMKmDtAJfuTv8mLDYHdBusaPcYPD4NMtJ
         rwIsSZH1TbQZSKDBKPUwr86BhM9VyeSpmSp6WlW7oB9soFZ2fALOyw2K1GTPI8xaPO2k
         dd7pkG49UZ+hpR1Z4CiqixaBZVpqX5XLm8nPexOxO9bYJowVSClrmVMaRRSeCR4XeBNo
         XWrfAfZUbC7YGLAkDsdmo45IFYzXC+N4YwLCxgGwdhxjk6EN3SVCF7ek+PEQy8sEMuSw
         7Dlw==
X-Forwarded-Encrypted: i=1; AJvYcCWD3mz48mEm4Jtlmq2lV3GwB0d+fQvRCf/3CqJ/Hu/3VQ11xfkozm434bkHq5gSCLKetkYCjgWnWU95mzRa@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwvTjpelHS3+iY/JgBOKBi62hzYwgbIfO1RYAa1ikQJJhTTTlHb
	2VfYqHRYT8k1kbzTeZ7MwAOEmGag0CS7rBZA7OvZPy3YMv96zPSQ
X-Gm-Gg: ASbGnctGhw/6casgBR4VoqqsuiV4M96zkfR/S/ZvZvOFKUpBtPdfdXp8HuN2aG+qbQi
	p943ad3W5jv5kZ0ypYJJocmv0aoxq5/2OM6ViitIxfe1zVd2t/AAohF983sO7R4M+mcPkesLnhY
	aSk1YHNEwPSCRfexGeB29R0fOJmbPkyuY7GV9dOvVq4TaG0SivtVM99Nwj1sEvxxgdqTR+YtZsh
	CrPWjqOghrZxOF5mfLSEdIHyjkPn/W2UcohZPqYyMLwlwRL1eo4+e8b7ieOnUBkiX375w==
X-Google-Smtp-Source: AGHT+IHHlEGifr3xddVO55ezHHqcXZIx7EZCIf/6g/ryJH27sZu4zCXGCbFymjqjaKRdP9BWVKAngw==
X-Received: by 2002:a05:651c:1503:b0:302:3355:f756 with SMTP id 38308e7fff4ca-30249e9df19mr7590821fa.35.1733995310065;
        Thu, 12 Dec 2024 01:21:50 -0800 (PST)
Received: from [192.168.219.191] ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-300398d55e6sm17254501fa.107.2024.12.12.01.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:21:49 -0800 (PST)
Message-ID: <b7b4200d-7771-43af-9bc5-9e2ea5dd2ce3@gmail.com>
Date: Thu, 12 Dec 2024 10:21:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] u-boot: Update SRCREV for
 radxa-zero-3
To: Quentin Schulz <quentin.schulz@cherry.de>,
 yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>
References: <20241207162339.10677-1-oleksii.kurochko@gmail.com>
 <4e53cd8a-0607-4816-830b-ae2ed81e5875@cherry.de>
 <de2a1774-cdad-440b-be04-7eed6207c741@gmail.com>
 <94a3c953-0c60-4d28-a496-51f94ec6c501@cherry.de>
 <ff3ea231-b311-4058-ae7c-484b6d2d6feb@gmail.com>
 <9a6b9edc-b8a3-466f-9f20-391544773555@cherry.de>
Content-Language: en-US
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
In-Reply-To: <9a6b9edc-b8a3-466f-9f20-391544773555@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Dec 2024 09:21:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/887

Hi Quentin,

On 12/11/24 10:25 AM, Quentin Schulz wrote:
> Hi Oleksii,
>
> On 12/10/24 8:03 PM, Oleksii Kurochko wrote:
>>
>> On 12/10/24 5:37 PM, Quentin Schulz wrote:
>>> Hi Oleksii,
>>>
>>> On 12/10/24 5:16 PM, Oleksii Kurochko wrote:
>>>> Hello Quentin,
>>>>
>>>> On 12/9/24 4:22 PM, Quentin Schulz wrote:
>>>>> Hi Oleksii,
>>>>>
>>>>> On 12/7/24 5:23 PM, Oleksii Kurochko via lists.yoctoproject.org 
>>>>> wrote:
> [...]
>>>
>>> I would recommend getting familiar with compiling and flashing the 
>>> kernel and U-Boot manually on your RV1103 device before trying to 
>>> compile them within Yocto, especially if there are patches to write 
>>> for both to be able to boot upstream. For downstream (vendor kernel 
>>> for example), that's a different topic :)
>>
>> I started to play with their build system ( https://github.com/ 
>> LuckfoxTECH/luckfox-pico/blob/main/project/build.sh ) but I am not 
>> really like it ( at least, sometimes I have to build several times to 
>> get finally compiled something ) and it is the reason why I decided 
>> to start Yocto port.
>>
>
> 3000 lines of shell script, what could go wrong.

Yes, I was surprised about that too... And it was one of the reason why 
I decided to switch to Yocto and add support for Yocto instead of using 
this script.


>
>> My first step is to come up with recipes which repeat the way how 
>> they are building U-boot and kernel ( based on the source code 
>> available in their SDK ) as I am not understand at the moment how big 
>> difference is with upstream. Does it make sense to do in that way?
>>
>
> I would still recommend to build the kernel and U-boot and whatever 
> else this monstrosity builds that you need, outside of any build 
> system. It'll help you figure out what is necessary to get your source 
> to build AND be functional. Which will help you writing recipes as 
> clean as possible.
>
> Building with Yocto (or any build system) may introduce unnecessary 
> friction when developing low-level BSP code.
>
>> And only after that start to look at how to optimize everything and 
>> make it looks closer to upstream.
>>
>
> Not sure what you mean by "optimize everything".
>
> For what it's worth, Rockchip's U-Boot vendor tree is absolute garbage 
> and I'm a strong believer that it's a waste of time to try to support 
> your board or fix broken stuff. It is usually not TOO difficult to add 
> support for a new SoC even porting most from Rockchip's vendor tree. 
> You can have a look at the support for the RK3576 on the U-Boot 
> mailing list for example, that should give you some idea of the amount 
> of work to do and which files to pick.
>
> But if you have some U-Boot that can already boot a Linux kernel, then 
> maybe start with that instead, baby steps.
>
> The kernel is an old Rockchip's vendor kernel based on 5.10. I believe 
> even Rockchip doesn't maintain that anymore (they switched to 6.1 a 
> year ago).
>
> U-Boot is 2017.09, from Rockchip's vendor tree as well.
>
> I would highly recommend getting rid of this downstream U-Boot as soon 
> as possible. It actually took me more time to support our board on 
> Rockchip's U-Boot than upstream for our RK3588 Jaguar and it was only 
> half working.
>
> The faster you can get yourself out of Rockchip assumptions about 
> storage medium partitioning, naming, etc... the better off you'll be.


Thanks for recommendations! I will try to follow them.

~ Oleksii

