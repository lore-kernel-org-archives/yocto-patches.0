Return-Path: <mustela@erminea.space>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59288CCFA13
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 21:51:51 +0000 (UTC)
Received: from erminea.space (erminea.space [51.250.125.203])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14606.1762638707553355827
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 13:51:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: erminea.space, ip: 51.250.125.203, mailfrom: mustela@erminea.space)
Received: from [192.168.50.71] (unknown [37.204.49.201])
	by erminea.space (Postfix) with ESMTPSA id 2DC95CB7;
	Sun, 09 Nov 2025 00:51:45 +0300 (MSK)
Message-ID: <1e83a199-94b5-45f8-b2ae-0707ae2a6876@erminea.space>
Date: Sun, 9 Nov 2025 00:51:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH v2] rk3288: use u-boot.img
 as bootloader image
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@cherry.de>,
 yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com
References: <20251104141935.2011578-1-mustela@erminea.space>
 <19df06a3-d582-4b25-8d51-9116018277e3@cherry.de>
From: Peter Shkenev <mustela@erminea.space>
In-Reply-To: <19df06a3-d582-4b25-8d51-9116018277e3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 21:51:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2461

Hello,

On 11/5/25 13:27, Quentin Schulz wrote:
> Hi Peter,
>
> On 11/4/25 3:19 PM, Peter Shkenev via lists.yoctoproject.org wrote:
>> [You don't often get email from 
>> mustela=erminea.space@lists.yoctoproject.org. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Currently, u-boot.bin is used for supported rk3288-based boards. But, as
>> U-Boot for those boards gets built without OP-TEE, u-boot.bin is a raw
>> image, and, since raw images support for those boards is disabled as
>> well, u-boot will fail to boot.
>>
>
> I assume you meant CONFIG_SPL_RAW_IMAGE_SUPPORT may not be enabled in 
> which case u-boot.bin cannot be loaded?
>
> The mention of OP-TEE here is quite confusing as it's not the direct 
> reason why u-boot.bin is a raw image. It always is a raw image for 
> Rockchip as far as I could tell. You may not be able to boot it if 
> SPL_RAW_IMAGE_SUPPORT=n.
>
> u-boot.img can be either a FIT image (if CONFIG_SPL_LOAD_FIT is 
> enabled), or a raw image if it isn't (c.f. Makefile 
> MKIMAGEFLAGS_u-boot.img being different when that symbol is enabled).
>
Somewhy I was under expression that with OP-TEE u-boot.bin would be a 
raw image. Sorry!

(Side note, upstream OP-TEE does not seem to support RK3288).

>> Fix this by using u-boot.img for supported rk3288 boards, which is a FIT
>> image.
>>
>
> It is a FIT image only if CONFIG_SPL_LOAD_FIT is enabled, otherwise 
> it's a raw image. Which means it's an ideal value regardless of the 
> state of the SPL_LOAD_FIT symbol.
>
> We should also add a comment in the rk3288.inc file stating that if 
> one wants to use OP-TEE, one needs to set UBOOT_SUFFIX to itb instead, 
> and have SPL_OPTEE_IMAGE and SPL_FIT selected in the defconfig in 
> order for this to work.

You have mentioned it in v1 patch discussion, and I have forgot to add 
it. Sorry again!

>
> The change itself is fine, I would just like the commit log to be 
> reworded to be less confusing (and ideally a comment added in rk3288 
> hinting that it may need to be changed to itb if one wants to use 
> OP-TEE).

Will send v3 patch with fixes soon.

>
> Cheers,
> Quentin

---

Best regards,

Peter


