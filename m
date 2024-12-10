Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577C9E77180
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 16:16:50 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.14285.1733847403250727348
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Dec 2024 08:16:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WySPxRk0;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so7177291a12.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 08:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733847401; x=1734452201; darn=lists.yoctoproject.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwrNMrdbu4Yr1ShNzVQaursTEAFm7iBH3cJCaalCTUM=;
        b=WySPxRk0N3V4jH8LiNKsS6ajojZLEYKdFu4NS9PKZLSsivtA3elPkf9DQeQB+1SL6a
         1EuISXvHCa1vRhNtV0HGVThdEOBz/6s4OENbOzNgLX243H33kH4mTeOIR5FQ5U/vXqQA
         Wton/irYmprTQc8VxrQtPxLEWKae69ZBurxHevfnftO/yEYyUuxsZ3Bo6fpjANNoTKDu
         mjC2Uth1WTcr0iEpzsZP+jTOHBMd5lKQuOvPtFxqU0by5KSb/jPw4wZjxn5gpeWNCJiA
         3RuX0wtdcT9121PlgNaZ4oYL3/+xsbTF68hLRKUFnN4JjBLB4BSnXuRext8YjTGn07HW
         GU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847401; x=1734452201;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TwrNMrdbu4Yr1ShNzVQaursTEAFm7iBH3cJCaalCTUM=;
        b=OBkXeIlPy6Z1n7LSYi72cicUYgUs/elkF3RzENn+S4GE1EK4x/8XKzjpJDMU3dePbX
         yWGgvKkdGWtq/3d2996CUfYhXtXItwvYnJdZC5OAzERJ2auuOiI3UYe0F/Ghi0ZgA9ch
         zxql5TnGKtnMkvtu9rFWSxYL6Rg9pfLcrq9Wo/wqPibOCaGOkNPYW9xTRatfSo+PK3IZ
         E9gZ3hJvpCFE9XEUOAqBBNMPhV9njXC9pWkWAb60oFfR9PWhwUAlComGs6A0h5R/2CS0
         m/OKr9qF9A+N99bL2snJeqC1ORRyOpMoV5IvewokcvtWeBK+Eiep42++htZ8J7YUONOF
         nsKw==
X-Forwarded-Encrypted: i=1; AJvYcCXGQvm8yd6LhsWopKjMTRXhInuUwxRULB9ZMIWrj03UHsXLx7EJGv9b5EYmQbd/CRCXLQ2WAUmUvo8YLVEz@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yx5JjzZs0cXXfcb1Oz5/ilOTikkZ6CYAMnSuRyVjo+rQlNGi3fg
	99KA1uC5UgJkZhBxizqKu0zRUan7wzeXgcH1rY1+PDQL/bu9hFi3
X-Gm-Gg: ASbGncs+HxZQ151Y+9hTbomtkZ3Rt9bAygqUGCK6ixzJ1fDwEhcktzq1O/bXU7lxQWF
	BW8sUo/HVk3+FAmC/Lpl/tCDTdi1HMPl6LMfCODhNs7Gp6L6cQGzcC1Plvl/TDdr9bEycPmQ5VJ
	FRIWHM4oLZfg+MPAIVBo+ZYsacMjVDDvRwzKh3FY8XIGddJRkCyLUwPA4JXRCDsCPr58YA0Jxau
	YMsv7jnY2MlKulMeHV5NvqMLU+eEFsJTeBwj4QZ0JKPj3NCAHAK7dWu9Ns7K7G6jyI=
X-Google-Smtp-Source: AGHT+IFd+85VlKzR9UvDeAMHRA4pKbrssVQIb15cOZ/msn6ZJOdH3mISfjqY8o/hqla+93kLpoM4Kg==
X-Received: by 2002:a05:6402:3906:b0:5cf:924f:9968 with SMTP id 4fb4d7f45d1cf-5d3be661c03mr18030341a12.2.1733847401150;
        Tue, 10 Dec 2024 08:16:41 -0800 (PST)
Received: from [192.168.219.191] ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3bf50397csm6650840a12.79.2024.12.10.08.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 08:16:40 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------Quli0mtbnO660XbEgS3Uwpdl"
Message-ID: <de2a1774-cdad-440b-be04-7eed6207c741@gmail.com>
Date: Tue, 10 Dec 2024 17:16:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] u-boot: Update SRCREV for
 radxa-zero-3
To: Quentin Schulz <quentin.schulz@cherry.de>,
 yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>
References: <20241207162339.10677-1-oleksii.kurochko@gmail.com>
 <4e53cd8a-0607-4816-830b-ae2ed81e5875@cherry.de>
Content-Language: en-US
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
In-Reply-To: <4e53cd8a-0607-4816-830b-ae2ed81e5875@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 16:16:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/882

This is a multi-part message in MIME format.
--------------Quli0mtbnO660XbEgS3Uwpdl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Quentin,

On 12/9/24 4:22 PM, Quentin Schulz wrote:
> Hi Oleksii,
>
> On 12/7/24 5:23 PM, Oleksii Kurochko via lists.yoctoproject.org wrote:
>> [You don't often get email from 
>> oleksii.kurochko=gmail.com@lists.yoctoproject.org. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> During the fetch stage of u-boot for radxa-zero-3, the following 
>> issue occurs:
>>    Unable to find revision 8cdf606e616baa36751f3b4adcfaefc781126c8c 
>> in branch
>>    rk3xxx-2024.07 even from upstream
>>
>> This happens because the hash of the head commit for the 
>> rk3xxx-2024.07 branch
>> is different from the one specified in the recipe.
>> This can be verified by running the following command in
>> <yocto>/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git:
>>    $ git rev-list -n 1 rk3xxx-2024.07
>>      2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead
>>
>> Update the SRCREV to the hash of the current head commit 
>> corresponding to
>> the rk3xxx-2024.07 branch.
>>
>> Fixes: e0b13fe834b5("radxa-zero-3{e|w}: add")
>> Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
>> ---
>>   recipes-bsp/u-boot/u-boot_%.bbappend | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend 
>> b/recipes-bsp/u-boot/u-boot_%.bbappend
>> index c939a48..9432e2b 100644
>> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
>> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
>> @@ -3,8 +3,8 @@ require u-boot-rockchip.inc
>>   FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
>>
>>   SRC_URI:radxa-zero-3 = 
>> "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
>> -SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
>> -SRCREV:radxa-zero-3:rk-u-boot-env = 
>> "8cdf606e616baa36751f3b4adcfaefc781126c8c"
>> +SRCREV:radxa-zero-3 = "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
>> +SRCREV:radxa-zero-3:rk-u-boot-env = 
>> "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
>>
>
> Master poky now has v2024.10 and at a glance it seems the Zero 3E/W is 
> supported, so maybe we could simply ditch those overrides for master 
> branch in meta-rockchip?

This is first time when I started to work with rockchip so I need
some time what is the difference between Kwiboo's u-boot and upstream one.

If there is no any specific patches and the difference is only that some patches haven't been upstreamed then I prefer this approach. Otherwise ...

>
> Other release branches should probably get a fix similar to the one in 
> this patch though. Or ideally just download the patches from that tree 
> and apply them on top of v2024.07 for styhead (we would need a new 
> release branch for that though). Scarthgap has v2024.01 so that's a 
> bit too old to apply patches destined to 2024.07. But we could maybe 
> point to v2024.07 upstream+patches instead of pointing to Jonas 
> (Kwiboo)'s personal git repo.
> What do you think? Trevor, an opinion here?

...  v2024.07 upstream + patches will be the best one option we could have now.

I have the small issue here. At the moment I don't have radxa-zero-3 board so I can check only build. My target is RV1103 SoC for which I want to add support to Yocto. But
I think that I can start in parallel update u-boot recipe for radxa-zero-3 too and then ask someone to test on a board.

Thanks.

~ Oleksii



--------------Quli0mtbnO660XbEgS3Uwpdl
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>Hello Quentin,

</pre>
    <div class="moz-cite-prefix">On 12/9/24 4:22 PM, Quentin Schulz
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:4e53cd8a-0607-4816-830b-ae2ed81e5875@cherry.de">Hi
      Oleksii,
      <br>
      <br>
      On 12/7/24 5:23 PM, Oleksii Kurochko via lists.yoctoproject.org
      wrote:
      <br>
      <blockquote type="cite">[You don't often get email from
        <a class="moz-txt-link-abbreviated" href="mailto:oleksii.kurochko=gmail.com@lists.yoctoproject.org">oleksii.kurochko=gmail.com@lists.yoctoproject.org</a>. Learn why
        this is important at
        <a class="moz-txt-link-freetext" href="https://aka.ms/LearnAboutSenderIdentification">https://aka.ms/LearnAboutSenderIdentification</a> ]
        <br>
        <br>
        During the fetch stage of u-boot for radxa-zero-3, the following
        issue occurs:
        <br>
           Unable to find revision
        8cdf606e616baa36751f3b4adcfaefc781126c8c in branch
        <br>
           rk3xxx-2024.07 even from upstream
        <br>
        <br>
        This happens because the hash of the head commit for the
        rk3xxx-2024.07 branch
        <br>
        is different from the one specified in the recipe.
        <br>
        This can be verified by running the following command in
        <br>
&lt;yocto&gt;/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git:
        <br>
           $ git rev-list -n 1 rk3xxx-2024.07
        <br>
             2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead
        <br>
        <br>
        Update the SRCREV to the hash of the current head commit
        corresponding to
        <br>
        the rk3xxx-2024.07 branch.
        <br>
        <br>
        Fixes: e0b13fe834b5("radxa-zero-3{e|w}: add")
        <br>
        Signed-off-by: Oleksii Kurochko
        <a class="moz-txt-link-rfc2396E" href="mailto:oleksii.kurochko@gmail.com">&lt;oleksii.kurochko@gmail.com&gt;</a>
        <br>
        ---
        <br>
          recipes-bsp/u-boot/u-boot_%.bbappend | 4 ++--
        <br>
          1 file changed, 2 insertions(+), 2 deletions(-)
        <br>
        <br>
        diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend
        b/recipes-bsp/u-boot/u-boot_%.bbappend
        <br>
        index c939a48..9432e2b 100644
        <br>
        --- a/recipes-bsp/u-boot/u-boot_%.bbappend
        <br>
        +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
        <br>
        @@ -3,8 +3,8 @@ require u-boot-rockchip.inc
        <br>
          FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
        <br>
        <br>
          SRC_URI:radxa-zero-3 =
"git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"<br>
        -SRCREV:radxa-zero-3 =
        "8cdf606e616baa36751f3b4adcfaefc781126c8c"
        <br>
        -SRCREV:radxa-zero-3:rk-u-boot-env =
        "8cdf606e616baa36751f3b4adcfaefc781126c8c"
        <br>
        +SRCREV:radxa-zero-3 =
        "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
        <br>
        +SRCREV:radxa-zero-3:rk-u-boot-env =
        "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
        <br>
        <br>
      </blockquote>
      <br>
      Master poky now has v2024.10 and at a glance it seems the Zero
      3E/W is supported, so maybe we could simply ditch those overrides
      for master branch in meta-rockchip?
      <br>
    </blockquote>
    <pre>This is first time when I started to work with rockchip so I need 
some time what is the difference between Kwiboo's u-boot and upstream one. 

</pre>
    <pre>If there is no any specific patches and the difference is only that some patches haven't been upstreamed then I prefer this approach. Otherwise ...
</pre>
    <blockquote type="cite"
      cite="mid:4e53cd8a-0607-4816-830b-ae2ed81e5875@cherry.de">
      <br>
      Other release branches should probably get a fix similar to the
      one in this patch though. Or ideally just download the patches
      from that tree and apply them on top of v2024.07 for styhead (we
      would need a new release branch for that though). Scarthgap has
      v2024.01 so that's a bit too old to apply patches destined to
      2024.07. But we could maybe point to v2024.07 upstream+patches
      instead of pointing to Jonas (Kwiboo)'s personal git repo.
      <br>
    </blockquote>
    <blockquote type="cite"
      cite="mid:4e53cd8a-0607-4816-830b-ae2ed81e5875@cherry.de">What do
      you think? Trevor, an opinion here?
      <br>
    </blockquote>
    <br>
    <pre>...  v2024.07 upstream + patches will be the best one option we could have now.

I have the small issue here. At the moment I don't have radxa-zero-3 board so I can check only build. My target is RV1103 SoC for which I want to add support to Yocto. But
I think that I can start in parallel update u-boot recipe for radxa-zero-3 too and then ask someone to test on a board.

Thanks.

~ Oleksii
</pre>
    <br>
    <br>
  </body>
</html>

--------------Quli0mtbnO660XbEgS3Uwpdl--

