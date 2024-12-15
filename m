Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6D3E7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 14:50:02 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.36585.1734274198989875274
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 06:49:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=f+1GZ/KA;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e3778bffdso3518257e87.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 06:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734274197; x=1734878997; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dy5pEl4pFS+e64RgNOh8iLOxes/GA1/FjZTrsuFNyvI=;
        b=f+1GZ/KA5jPYghROj8eUrWdAtWZLl80wGTTV5kvWVlGT7BqAk0eJPSxdyKJa36eEjf
         K4O5sD/r2OAwBBJLbpjGCd3HgsWOWsqGczYwAiWz/XXBZLSwWcKcek9/gTXXN/r7fBKU
         d+6T1X7Z4McTevshcMgIbGYH4qexVWrBeQML3/GRVqAE7C1ODCF9Bgkqt0wgizgRoYab
         Wu0I097Fx8O1egnkRiUkHEpgvKLXVmz1IyZhqsT5CuRtLsF1C8gVxWbRtimHE/bV8qNi
         1ahxH5uhoL0p9MllGYe6N2ppwvCFuxou7WVJaefwannLAUtMPTxq45qy3vMrfTzRaal4
         vbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734274197; x=1734878997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dy5pEl4pFS+e64RgNOh8iLOxes/GA1/FjZTrsuFNyvI=;
        b=KyoizCjUhicrN9KPXCnyZkBXWjqTZWWRyOnc0k374GU8f1E9m61vvurWrQl/TXQudy
         B05+E8U/wZig430aYlr8FsxORnX3JvUVR2mYTHyjMcg39iu09sSsG4Jt63X6IeJ12jst
         gXq7xGej7o/J9Gw4QpR0h+P5/LA9pwDFXmy9NF9S8FxH+KB3R0eEFFs0WU4l6Dv9dUwq
         1z+ymPGMDaPJqpY47S61z9dUFoRe4S238VnWg34u6H8ew2S1nN0SItVHGGAxOuptuWfh
         P1rvjxBeW2+nIguzJY0kbOg3POkecnqtR7IAXBgUuIE3JDVdDNUCBCOSHEm0xRhKfug9
         43bA==
X-Forwarded-Encrypted: i=1; AJvYcCWaakKBO1H2eHEkLJjQ3A1Mop2p7KC19iFEcUmRIeMEGiv4SfaPjpLFilt+q5C+gnNRnX9EOQlISgxm/HzC@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzrJEiwYp3bRJpXQ1cwiBvIPfRMgl6B/OzzTNaWJFZCFwrrv4De
	i9xgSs5kl5SRjbkkWZWcA0y4GIwDdBveKk2m3iYMaB81VTsfOwlU
X-Gm-Gg: ASbGnctKPOynJeFcWxSu4uDhyFtcvsW8rR1tHCx9ay+hE05lDMF/pQkpAoyPzFGp+kC
	0Xbd6JqHsZlHpHSemn6hn/IjrGdoB4kQ3uTzKUL4c4RB4eNNyZ9NQAfgHfckG2wugXfBgz9gDIT
	d9+mR0mup5WZYtFko+oI9pTZc962CA98hY1CyHnivwT2deerzRXCTzBvQxVw8cadJH0+FH9BGos
	1Jcsk4vnT/kB9uUOv8Ej3klmV9sOYQmfuRc2OQyQ6hVcc9Vf88ATUF6daWNjZ0r69F2+w==
X-Google-Smtp-Source: AGHT+IEFG/0EENEr6AhRm+FENA3u/fKpocihpyRTPdPz/YOtl2TrmstE95mXzHg1oW8QzhI2mcJMvA==
X-Received: by 2002:a05:6512:10c7:b0:53e:349c:45c0 with SMTP id 2adb3069b0e04-54099b69dc2mr2402194e87.56.1734274196796;
        Sun, 15 Dec 2024 06:49:56 -0800 (PST)
Received: from [192.168.219.191] ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c136cesm535143e87.183.2024.12.15.06.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 06:49:56 -0800 (PST)
Message-ID: <7a0bed0a-d85a-42ae-8756-77df1be8efcd@gmail.com>
Date: Sun, 15 Dec 2024 15:49:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] u-boot: use upstream for radxa-zero-3{e|w}
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20241212195718.25203-1-twoerner@gmail.com>
 <20241212195718.25203-2-twoerner@gmail.com>
Content-Language: en-US
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
In-Reply-To: <20241212195718.25203-2-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 14:50:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/908

Hi Trevor,

On 12/12/24 8:57 PM, Trevor Woerner wrote:
> Upstream U-Boot 2024.10 (the latest release supported by Yocto) has support
> for radxa-zero-3{e|w}. Therefore switch away from the fork where the initial
> U-Boot development for this board had been added.
>
> Reported-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   recipes-bsp/u-boot/u-boot_%.bbappend | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> index 06ba6d54de8e..08e1730b5d3d 100644
> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> @@ -2,10 +2,6 @@ require u-boot-rockchip.inc
>   
>   FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
>   
> -SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
> -SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> -SRCREV:radxa-zero-3:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> -
>   SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
>   
>   DEPENDS:append:rk3308 = " u-boot-tools-native"
I have a compilation issue after applying of this patch series:
     | scripts/kconfig/conf 
--defconfig=arch/../configs/radxa-zero-3-rk3566_defconfig Kconfig
     | ***
     | *** Can't find default configuration 
"arch/../configs/radxa-zero-3-rk3566_defconfig"!
     | ***
     | make[2]: *** 
[/home/ok/Projects/yocto/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git/scripts/kconfig/Makefile:96: 
radxa-zero-3-rk3566_defconfig] Error 1


And it seems like there is not defconfig for radxa-zero-3 at all:

ok@fedora:~/Projects/yocto/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git/configs$ 
ls -la radxa-
     radxa-cm3-io-rk3566_defconfig  radxa-e25-rk3568_defconfig 
radxa-zero2_defconfig          radxa-zero_defconfig


Should I apply something else except the current patch series?


Best regards,

  Oleksii


