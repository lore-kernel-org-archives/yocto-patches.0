Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04067E7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 14:59:43 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web10.36901.1734274780584680132
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 06:59:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Rj8dYdsD;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54024aa9febso3218444e87.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 06:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734274779; x=1734879579; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJ2Bvl7D98WlPt9k5pxi5Yo8FD1Ea1rH676Li6IqRWo=;
        b=Rj8dYdsDi5++GSrymUy95TP+P1s8PxEGmIU1o/qWq3OT59OvNOPfRTFsL7Xr4JoTog
         s0ZOJf/jLi3F/tpVMnZVhWGbfANyJgnSWWNH+Sq98Le7wZx73YglQhGhd4QM39wgdzIC
         NVKnYiQR/FzvKSMwqfY7keJt+k8T+8agxXN1OHvAvaDaD95QIo0hX2jx+nTz00zVCN1J
         HofJZLRpZ4ITTq75yQ05O+oIJXhsFmTibb3Lxa01Q3I31i3GmkdMqck22pVooYQqtOiD
         rzwsAdl5VjN/P2O7dSSRuH7iGY6fJT4m9sJZgzW5Vjnn/Bk6vH5TAOy5f7Xjqsq4XxUT
         rfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734274779; x=1734879579;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ2Bvl7D98WlPt9k5pxi5Yo8FD1Ea1rH676Li6IqRWo=;
        b=ePdz2ilBMfSY2lM1ezZ2oeQRYYJpJ1xq9I+vpniiejqRYm2/7NL07Qlfmn4NtsPtiQ
         XXMYLMFmMwTx6BrViUhw5sWmyzEu7egNcK7g4Q2qJhoRr+d6WSWOCvJ771bwLXfGvg67
         f+LyJbCxgXz5HPMCFL8XN4t42IoCaVJPdYmE5dGuN6+NtGWI4Sz/IHA0pyJMgGZBvVWG
         T9oj1TUiG5mLkPisNPc/tltMqmzWxSe7rvCyCFb/2sFRC+z24u2x3OVwb0M8hoNc/FoO
         qYMVQ+KUYk/8oL7GIHi+xOoOnm0pMnW61SpFTEz6YSNKnhNd4S1Huot+T5dH/bqoM9C7
         CqCw==
X-Forwarded-Encrypted: i=1; AJvYcCWzpu7foW+T+sWzkFcaREPK4lGomTVtfwlAb5tvFabFLAw66LtRSR5yOkoswJz4u4JVWdlPtTGQ9j3+uhLM@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxGQDFkQitaQyqofHUrN5mPqA3fFapkNqlCnKpOoyd6d5USu9pX
	2YL31zNfx28FARxJwiUoQV1gBm/5DsV72oqvAecl7Wn2hLnbB4cqvYwKKL6U
X-Gm-Gg: ASbGnctEvWX2HOx/ueG4skQ3GTp2ChcpvoA6jNRUDtt/8slYi1wwwM/T38OU4SJirmT
	SJOZGNLw4zOPvIAaBPaZXaIvtgQB0lAbZvUh4aRH9S37FbBKPfok1yYz6jzZd9yMwfxhfYrmi/j
	BSnR58i4EqR1LRWlllGe18BhJEMmTtOPj6cTvqi4QisX7Gq7avVk9MVCpcijZW9hsfsj9lX/k9+
	zCsgnVlnnDIBALTfu8elXnyfPzjh5OjtvAr4iyr6vDJhIdKvGqMTvVU42MZv24r89w65w==
X-Google-Smtp-Source: AGHT+IH/MjdooTKM11FD8a7rfmTqLAdge35I8xyPyGh3oS5JAxgqx+YigaVufpLb0vhw0p8ErQ3sig==
X-Received: by 2002:a05:6512:3c8f:b0:540:2542:6081 with SMTP id 2adb3069b0e04-54090556ce3mr2297803e87.23.1734274778403;
        Sun, 15 Dec 2024 06:59:38 -0800 (PST)
Received: from [192.168.219.191] ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13d74sm523075e87.211.2024.12.15.06.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 06:59:38 -0800 (PST)
Message-ID: <a5018ab5-b43b-409c-b901-76b12df110fa@gmail.com>
Date: Sun, 15 Dec 2024 15:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] u-boot: use upstream for radxa-zero-3{e|w}
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20241212195718.25203-1-twoerner@gmail.com>
 <20241212195718.25203-2-twoerner@gmail.com>
 <7a0bed0a-d85a-42ae-8756-77df1be8efcd@gmail.com>
Content-Language: en-US
In-Reply-To: <7a0bed0a-d85a-42ae-8756-77df1be8efcd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 14:59:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/909


On 12/15/24 3:49 PM, Oleksii Kurochko wrote:
> Hi Trevor,
>
> On 12/12/24 8:57 PM, Trevor Woerner wrote:
>> Upstream U-Boot 2024.10 (the latest release supported by Yocto) has 
>> support
>> for radxa-zero-3{e|w}. Therefore switch away from the fork where the 
>> initial
>> U-Boot development for this board had been added.
>>
>> Reported-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>> ---
>>   recipes-bsp/u-boot/u-boot_%.bbappend | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend 
>> b/recipes-bsp/u-boot/u-boot_%.bbappend
>> index 06ba6d54de8e..08e1730b5d3d 100644
>> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
>> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
>> @@ -2,10 +2,6 @@ require u-boot-rockchip.inc
>>     FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
>>   -SRC_URI:radxa-zero-3 = 
>> "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
>> -SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
>> -SRCREV:radxa-zero-3:rk-u-boot-env = 
>> "8cdf606e616baa36751f3b4adcfaefc781126c8c"
>> -
>>   SRC_URI:append:rk-u-boot-env = " 
>> file://rockchip-enable-environment-mmc.cfg"
>>     DEPENDS:append:rk3308 = " u-boot-tools-native"
> I have a compilation issue after applying of this patch series:
>     | scripts/kconfig/conf 
> --defconfig=arch/../configs/radxa-zero-3-rk3566_defconfig Kconfig
>     | ***
>     | *** Can't find default configuration 
> "arch/../configs/radxa-zero-3-rk3566_defconfig"!
>     | ***
>     | make[2]: *** 
> [/home/ok/Projects/yocto/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git/scripts/kconfig/Makefile:96: 
> radxa-zero-3-rk3566_defconfig] Error 1
>
>
> And it seems like there is not defconfig for radxa-zero-3 at all:
>
> ok@fedora:~/Projects/yocto/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git/configs$ 
> ls -la radxa-
>     radxa-cm3-io-rk3566_defconfig  radxa-e25-rk3568_defconfig 
> radxa-zero2_defconfig          radxa-zero_defconfig

But it is present in the master:

https://source.denx.de/u-boot/u-boot/-/blob/master/configs/radxa-zero-3-rk3566_defconfig?ref_type=heads

And It seems we need or cherry-pick the patch ( 5d199ad9a6b("board: 
rockchip: Add Radxa ZERO 3W/3E") ) or switch to newer tag:
    git tag --contains 5d199ad9a6b
    v2024.10
    v2024.10-rc3
    v2024.10-rc4
    v2024.10-rc5
    v2024.10-rc6
    v2025.01-rc1
    v2025.01-rc2
    v2025.01-rc3
    v2025.01-rc4

~ Oleksii


>
>
> Should I apply something else except the current patch series?
>
>
> Best regards,
>
>  Oleksii
>

