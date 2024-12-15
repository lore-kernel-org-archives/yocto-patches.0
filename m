Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F31E7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 17:30:33 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web10.39456.1734283832538695810
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 09:30:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=C+gCqCrQ;
 spf=pass (domain: gmail.com, ip: 209.85.167.51, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53df6322ea7so4735279e87.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 09:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734283830; x=1734888630; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tnUvcWBMknpceoSWfRqnP8t3E5R+DabIlibmP/pbOb4=;
        b=C+gCqCrQLZRe2hYVJbYtMqPCTcEXZ7KBEhdfGxxj5sLjc5km3nncRxmNV+pRiojgls
         bE+h++ju5U85EVkVR/BGNpjF2QqhlyyWG6Tiu+oR1CcFK+yE0bz4cP5zwvFzePW/nPQy
         i4jgTCw+4LxnV8MW9SxYvTJD4xPzkRS9/Kn/H/Er4YfJETw75vun95BFtuFgq6/k9iTB
         EoIXKS9osSDSJca/84mws8zymt7STj+DWhWU35ZznLKoavVN+1rM6AQlKjz1qng3ee27
         JA33byV2ns1vX3d2yf3ZReY9cLpCt0leZfsEeEjKvxDZOUP760xGFSNFNuu3mDZVDBsC
         yTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734283830; x=1734888630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnUvcWBMknpceoSWfRqnP8t3E5R+DabIlibmP/pbOb4=;
        b=v+5mOlr2DMGFN6ueGQnWL0EnQBY/B1IgZhozQLZbwcc7XJlx15qIhixUqhu5GiQiaO
         ccZdIX5ygBUiaRckRbtHsc3g8hZhj8AX7nB59WmSJgg260ZxYwesyZiOUGbr9t+91h9R
         u5nngh5Tu/hgXtER8R4dAQ/Kc7uo4RULsJWP9A8xpoNYy2FCa/nkxhr4/vIUlTzHZfnB
         8hBasU8nHA7h6n2wONVTpT/ESC78wSRZyF2SdEBA/6L3kaR1VqLKVgR4ZmkxDcTQ8Fpn
         IV4mB+UJFb5ECEI9pHbBFoP7w+JnFZ22Etbyalwo/d1iTq8Td4kzvRWUpuziRbSizzop
         k08Q==
X-Gm-Message-State: AOJu0YyB3FH7COtyAh0y/VEK9/dMto9ALfhN1cCxVOOvb56dm4QKiaWv
	HrTaNrvkbBf30LSO5OPuUgKH7juuNoaHTmkM4YYMyzVzszUMjuj3qifcQ/ON
X-Gm-Gg: ASbGncvKLZxKmsqkem0sRTW359mvRHRUOzSkubxK8ev63RO6bF8gWnlBgtzxZiJXrAn
	5yEqfmIos6Q2v3FBy6W8PGym5PcBeb7ed0m7fY5hypuE/umqo+WFNXuiGZK7+pHaUxV8KJYjo62
	QD7FAlqEVAOADmpAWFaZQVOJniTUVQIfllMMeWNgm6ATBkxL11cs3cEBsi4b+6Ebd2mF4orXMSq
	tFaaAQOPelVO91lNur4zsJQsIkGDH+joLltplyN5GPQtmEk9S6vTTzDw4hDt7D1LT+RXA==
X-Google-Smtp-Source: AGHT+IGyqa4amiESx1yWXIGP8ohvHCQ6X1+5znm1YpKvBXFyohfzDF3FsIjmUWnO4ITHUpgTDdXTjQ==
X-Received: by 2002:a05:6512:1255:b0:53e:94f8:bb30 with SMTP id 2adb3069b0e04-5409055bffdmr3029983e87.24.1734283829990;
        Sun, 15 Dec 2024 09:30:29 -0800 (PST)
Received: from [192.168.219.191] ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c16890sm561357e87.225.2024.12.15.09.30.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 09:30:29 -0800 (PST)
Message-ID: <3ea781c3-5764-46e0-b989-8b6d1f2cae59@gmail.com>
Date: Sun, 15 Dec 2024 18:30:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 3/3] radxa-zero-3: switch to yocto-dev
 kernel
To: yocto-patches@lists.yoctoproject.org
References: <20241212195718.25203-1-twoerner@gmail.com>
 <20241212195718.25203-3-twoerner@gmail.com>
 <ef1b59d8-a018-44fc-8f0c-e58db58380d9@gmail.com>
 <20241215161056.GA2613@localhost>
Content-Language: en-US
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
In-Reply-To: <20241215161056.GA2613@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 17:30:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/916


On 12/15/24 5:10 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Is this also a styhead-specific issue?

Yes, it is a styhead-specific issue with master there is no such issue.

~ Oleksii


>
> On Sun 2024-12-15 @ 04:10:51 PM, Oleksii Kurochko wrote:
>> Hello Trevor,
>>
>> On 12/12/24 8:57 PM, Trevor Woerner wrote:
>>> The radxa-zero-3{e|w} devices are not supported in the current yocto kernel,
>>> but they are supported in the yocto-dev kernel. Switch to yocto-dev until
>>> support is available in the yocto kernel.
>>>
>>> Reported-by: Oleksii Kurochko<oleksii.kurochko@gmail.com>
>>> Signed-off-by: Trevor Woerner<twoerner@gmail.com>
>>> ---
>>>    conf/machine/include/radxa-zero-3.inc         |  2 +-
>>>    ...xt_%.bbappend => linux-yocto-dev.bbappend} |  0
>>>    .../linux/linux-torvalds-next_git.bb          | 25 -------------------
>>>    recipes-kernel/linux/linux-yocto-dev.bbappend |  2 ++
>>>    4 files changed, 3 insertions(+), 26 deletions(-)
>>>    rename dynamic-layers/rk-rauc-demo/recipes-kernel/linux/{linux-torvalds-next_%.bbappend => linux-yocto-dev.bbappend} (100%)
>>>    delete mode 100644 recipes-kernel/linux/linux-torvalds-next_git.bb
>>>
>>> diff --git a/conf/machine/include/radxa-zero-3.inc b/conf/machine/include/radxa-zero-3.inc
>>> index 1c6f972c1e31..b351afae8c0f 100644
>>> --- a/conf/machine/include/radxa-zero-3.inc
>>> +++ b/conf/machine/include/radxa-zero-3.inc
>>> @@ -2,7 +2,7 @@ MACHINEOVERRIDES =. "radxa-zero-3:"
>>>    require conf/machine/include/rk3566.inc
>>> -PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
>>> +PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-dev"
>>>    MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
>>>    UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
>>> diff --git a/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-yocto-dev.bbappend
>>> similarity index 100%
>>> rename from dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend
>>> rename to dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-yocto-dev.bbappend
>>> diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
>>> deleted file mode 100644
>>> index b961b1408f09..000000000000
>>> --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
>>> +++ /dev/null
>>> @@ -1,25 +0,0 @@
>>> -FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto-dev:"
>>> -
>>> -DESCRIPTION = "Linux Kernel"
>>> -SECTION = "kernel"
>>> -LICENSE = "GPL-2.0-only"
>>> -LIC_FILES_CHKSUM ="file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
>>> -
>>> -ERROR_QA:remove = "buildpaths"
>>> -DEFAULT_PREFERENCE = "-1"
>>> -COMPATIBLE_MACHINE = "^$"
>>> -COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
>>> -
>>> -LINUX_VERSION = "6.11-rc6"
>>> -KERNEL_VERSION_SANITY_SKIP = "1"
>>> -PV = "${LINUX_VERSION}+git${SRCPV}"
>>> -SRC_URI = " \
>>> -	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1 \
>>> -	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
>>> -	"
>>> -# this is tag 'next-20240904'
>>> -SRCREV = "fdadd93817f124fd0ea6ef251d4a1068b7feceba"
>>> -
>>> -inherit kernel
>>> -inherit kernel-yocto
>>> -require recipes-kernel/linux/linux-yocto.inc
>>> diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
>>> index b6a63d7b7b29..f738d1357d6c 100644
>>> --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
>>> +++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
>>> @@ -1,5 +1,7 @@
>>>    FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
>>>    COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
>>> +COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
>>>       SRC_URI:append:orangepi-5-plus =" file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
>>> +SRC_URI:append:radxa-zero-3 = "file://rockchip-kmeta;ty
>> After applying of this patch series I see the following compilation issue
>> for kernel:
>>      | ERROR: modpost: vmlinux: local symbol 'security_path_rmdir' was
>> exported
>>      | make[2]: *** [/home/ok/Projects/yocto/build/tmp/work-shared/radxa-zero-3e/kernel-source/scripts/Makefile.modpost:145:
>> vmlinux.symvers] Error 1
>>      | make[1]: *** [/home/ok/Projects/yocto/build/tmp/work-shared/radxa-zero-3e/kernel-source/Makefile:1871:
>> modpost] Error 2
>>
>>      | make: *** [/home/ok/Projects/yocto/build/tmp/work-shared/radxa-zero-3e/kernel-source/Makefile:240:
>> __sub-make] Error 2
>>
>>
>> Should I apply something except the patches from these patch series?
>> Otherwise I think we should disable some security things ( as a workaround
>> ):
>>
>> CONFIG_SECURITYFS=n CONFIG_SECURITY_NETWORK=y CONFIG_SECURITY_NETWORK_XFRM=n
>> CONFIG_SECURITY_PATH=y CONFIG_SECURITY_LANDLOCK=y
>>
>> Best regards,
>>
>>   Oleksii
>>
>>
>>> pe=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#913): https://lists.yoctoproject.org/g/yocto-patches/message/913
> Mute This Topic: https://lists.yoctoproject.org/mt/110086430/7609514
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13794076/7609514/1776480132/xyzzy [oleksii.kurochko@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

