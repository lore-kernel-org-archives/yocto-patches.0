Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10834E7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 15:16:03 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web11.37043.1734275757089235687
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 07:15:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WQi5yY3I;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30227c56b11so32807151fa.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 07:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734275754; x=1734880554; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bmr3fmuSWla0u0D8qi83vCnrbXeZaxb0NJ6pLG3KqJQ=;
        b=WQi5yY3IQPqgcXlgVt9dTJFX4AcI1HjliYiiDiM5zji3ZxBebKE9l4guC1CeaFxtYT
         5Ksv7CmobI6ohoOPmImwT6aFMzyCIDspGt3LxCfIkhHIFRU77dSmjP5MDr18l9culIGR
         VnsOq4r9bKcSS18XWOIQqzEMYXR2n33gPPMDGMK181mTLXE0XE00N8SJTtKahOERKztJ
         7pktZp62amZlc2sWpjRv7CAWZWuZc02lggy7KWwgRYQJ9TEk7Hag7Soh0iJLduYGI7bL
         MydEK600U3/WlI4wFFnPDQIL6InJImuHs4M47vaL3Smf/qqugy2u3MF0NKCdlkXmHlu4
         VSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734275754; x=1734880554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmr3fmuSWla0u0D8qi83vCnrbXeZaxb0NJ6pLG3KqJQ=;
        b=ZxD2pwvAfLF7qlIPVWOpprI8dHwl5r4BUPFSS51QY/7crvVOYLJGaaBtILphh1fXo4
         yjWgEBWOXtGdptTip0k4l7/3ltvVOPivo5nqB02IF59wESJg71f65mMtzvW6G6kEDSqL
         AJb9Uh504pyUwpnuowxOToSRQwj2yekXnBf5c7IO+/FOmcvzNksEp/Kxt2t6WIdYlOgL
         TWqCAdz7LwR1G3qzkKxiMJn6m1Fa/61NnuJTCFtDqKd57nTSgdE1rod88kEObxpVCPQa
         aBRFz/sSRksmW8MWsK/5kvUr5Dx+nlYWLhDM1D3i2NYzz7ILeJcTnDXckjrm/h50Y2Gz
         YMIA==
X-Gm-Message-State: AOJu0YyM7/52zoQm2RhdVfP5skMYLm3Co01+yx7avUL5WSe5tVyGbGtP
	M3Rb+VaTKrZFH98x33FRjHeF/+chBWlkVa+VE9jxmz7h3d249QtyZErZkon0
X-Gm-Gg: ASbGnctgUYqdobwrrL1D9XM4Rptl95Q+zCifPAJid+Nosi0Ti3CuNrU0wQo4sC6+dDN
	ecTX+i2GYdUJhATfPeXJlLaiV+VPuBTlJKwsNNh/hja8SVKVJ1F3PYtXj85PabqMYrcWPqhmSDC
	FIni470XQzeok1Pn/QQP45eS2HJ/tiL6Bc95PMlZlFNdACeQbQoPhDduLNqwVFN5NAAjfRDNa8J
	itR/ShfbMUBLxq3wdf54jVPoThppyIZ7QW8TDOXRwVeP3d7LiZHwovNvTTOewt4NyTsQw==
X-Google-Smtp-Source: AGHT+IHJXkgMUqXYl9HAKVCuvdNYR3NdMB5KM9HkVSDFd+gngROyqBvzYBeba5p3AqFTtmC4JnFQ2w==
X-Received: by 2002:a05:651c:2108:b0:2ff:c3a2:f408 with SMTP id 38308e7fff4ca-3025443fd13mr28275201fa.12.1734275754237;
        Sun, 15 Dec 2024 07:15:54 -0800 (PST)
Received: from [192.168.219.191] ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3034401d551sm6110631fa.18.2024.12.15.07.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 07:15:53 -0800 (PST)
Message-ID: <e704a2e3-0f7c-4565-8a25-837f98fdab74@gmail.com>
Date: Sun, 15 Dec 2024 16:15:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 2/3] u-boot: use upstream for
 radxa-zero-3{e|w}
To: yocto-patches@lists.yoctoproject.org, Trevor Woerner <twoerner@gmail.com>
References: <20241212195718.25203-1-twoerner@gmail.com>
 <20241212195718.25203-2-twoerner@gmail.com>
 <7a0bed0a-d85a-42ae-8756-77df1be8efcd@gmail.com>
 <181161B988FC6012.23577@lists.yoctoproject.org>
Content-Language: en-US
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
In-Reply-To: <181161B988FC6012.23577@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 15:16:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/911


On 12/15/24 3:59 PM, Oleksii Kurochko via lists.yoctoproject.org wrote:
>
> On 12/15/24 3:49 PM, Oleksii Kurochko wrote:
>> Hi Trevor,
>>
>> On 12/12/24 8:57 PM, Trevor Woerner wrote:
>>> Upstream U-Boot 2024.10 (the latest release supported by Yocto) has 
>>> support
>>> for radxa-zero-3{e|w}. Therefore switch away from the fork where the 
>>> initial
>>> U-Boot development for this board had been added.
>>>
>>> Reported-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
>>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>>> ---
>>>   recipes-bsp/u-boot/u-boot_%.bbappend | 4 ----
>>>   1 file changed, 4 deletions(-)
>>>
>>> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend 
>>> b/recipes-bsp/u-boot/u-boot_%.bbappend
>>> index 06ba6d54de8e..08e1730b5d3d 100644
>>> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
>>> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
>>> @@ -2,10 +2,6 @@ require u-boot-rockchip.inc
>>>     FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
>>>   -SRC_URI:radxa-zero-3 = 
>>> "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
>>> -SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
>>> -SRCREV:radxa-zero-3:rk-u-boot-env = 
>>> "8cdf606e616baa36751f3b4adcfaefc781126c8c"
>>> -
>>>   SRC_URI:append:rk-u-boot-env = " 
>>> file://rockchip-enable-environment-mmc.cfg"
>>>     DEPENDS:append:rk3308 = " u-boot-tools-native"
>> I have a compilation issue after applying of this patch series:
>>     | scripts/kconfig/conf 
>> --defconfig=arch/../configs/radxa-zero-3-rk3566_defconfig Kconfig
>>     | ***
>>     | *** Can't find default configuration 
>> "arch/../configs/radxa-zero-3-rk3566_defconfig"!
>>     | ***
>>     | make[2]: *** 
>> [/home/ok/Projects/yocto/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git/scripts/kconfig/Makefile:96: 
>> radxa-zero-3-rk3566_defconfig] Error 1
>>
>>
>> And it seems like there is not defconfig for radxa-zero-3 at all:
>>
>> ok@fedora:~/Projects/yocto/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git/configs$ 
>> ls -la radxa-
>>     radxa-cm3-io-rk3566_defconfig  radxa-e25-rk3568_defconfig 
>> radxa-zero2_defconfig          radxa-zero_defconfig
>
> But it is present in the master:
>
> https://source.denx.de/u-boot/u-boot/-/blob/master/configs/radxa-zero-3-rk3566_defconfig?ref_type=heads 
>
>
> And It seems we need or cherry-pick the patch ( 5d199ad9a6b("board: 
> rockchip: Add Radxa ZERO 3W/3E") ) or switch to newer tag:
>    git tag --contains 5d199ad9a6b
>    v2024.10
>    v2024.10-rc3
>    v2024.10-rc4
>    v2024.10-rc5
>    v2024.10-rc6
>    v2025.01-rc1
>    v2025.01-rc2
>    v2025.01-rc3
>    v2025.01-rc4

Sorry for flooding but I think it is needed to note that it is needed 
for scarthgap branch.

~ Oleksii

>
> ~ Oleksii
>
>
>>
>>
>> Should I apply something else except the current patch series?
>>
>>
>> Best regards,
>>
>>  Oleksii
>>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#909): 
> https://lists.yoctoproject.org/g/yocto-patches/message/909
> Mute This Topic: https://lists.yoctoproject.org/mt/110086429/7609514
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: 
> https://lists.yoctoproject.org/g/yocto-patches/leave/13794076/7609514/1776480132/xyzzy 
> [oleksii.kurochko@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

