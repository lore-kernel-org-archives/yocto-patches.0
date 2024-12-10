Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560F7E7717F
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 19:03:46 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web11.1582.1733857415978523962
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Dec 2024 11:03:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HfM5dq0w;
 spf=pass (domain: gmail.com, ip: 209.85.208.169, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so60479911fa.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 11:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857414; x=1734462214; darn=lists.yoctoproject.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfUrv9uz5DTZ2NsfLMHOs1ohFeNO+qo2kN/vmA0fZIc=;
        b=HfM5dq0wUOtTFh+b2wrZeuuRseH3PNIhcEYeCHnmP+VCon0ohaByZCcCt3FT47Xtx5
         7aVurkCYr9Ji8Kk8pKgOt4fINzSfNcAqjy0jFqRKdL906tf+15ee1jhhsFHh29j+Pqz1
         ZuHm30yhI/v+FvEn8a88LOlY54DH6t42fbdLgr+4UaPE1BmnJaHCuKQOvLYzyM4v1wbz
         mfMdT+hUgvk6AdcmVsuMoHqu+GkdZGA1bGrd+tzH20RDms+y96If/ucLmqAheBaBcGp/
         Giui8u3icyYQphOiN1pkzFc4wRTrskVxPeCAEXOnnZ65LhOI9p6R7hti6Yh7KqX+rg7y
         J7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857414; x=1734462214;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xfUrv9uz5DTZ2NsfLMHOs1ohFeNO+qo2kN/vmA0fZIc=;
        b=MZwqXlC1SQL7/SgXPsOiIQgSeU+3tE/S/kqBm84N7tghyDIy4ChZBg99ufOXYTqDPG
         /n4DrAMPiNKztQgzlt3Bmzoa+YPV5HwbfVpVEcSmKEYHcH7sFiDy1XMfW13tfskrUPXW
         t6UV1yt359c1D0kYV7zsxk7hrt/hroXaa63bB1td9bTP+IfXfpXJX4uxVk4XOarBgF4/
         caiPceuK5ppTv62sodMWZTJC60swtdsgyEjn59fZkOfyf06hzW+WSOfNXo0iUxpceif9
         zlVV1Ryp6Ff9zORvtUzw5qCmZGFBh42MXgiF0D7czHs/nZDBc/34pbk8d8O6b17q0qbI
         p31g==
X-Forwarded-Encrypted: i=1; AJvYcCUMlxJHhwTevYWW6JlEc2H53i34/fe3+We5EB2wDeg+rC/KSaknjUAXR3uP9vdNqzyTrTLPHHizjU0zLTZ/@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyCThMQlpt6Vzh02c6Agk329Kess9g5VLMghd/YAonoujwwm5hZ
	vKOy1BUe1JTG7WadHsDDqD4Q2+H7Ks/ASZmySmN4dnQK1NYZTEBr
X-Gm-Gg: ASbGncuenMVtbNik7HG1nM0yF4IhtcoG6utE1WxF1pg+8Gj8EQ9X9iNFzX9hmjTWgCB
	S78ASqUM/UDFYTTD/It6nt8KJrfF1E7W5XszzsZIJ0p9tSTz21QsYA5Eyp4aozefPBNxfLFRoEf
	bd4n8zkFaCNz2NQzGpM8s7hwbDTnh7FzCjtoCcnzCscQHgQtEQabBkVY8+ei0UnnfYBUWj+HM/B
	5D/8Cj2Nnwp1hUswvloC618TkOx+7wcNLok0TJOTrlYrY7Dzr8QowHOiqrokqmU9qM=
X-Google-Smtp-Source: AGHT+IHOIDl0zu20d+oXFyd/J3UGa1z4D4VUc4TXLjyYb3/9962rqtr61AHULLyBlg7ueqi6E5tKow==
X-Received: by 2002:a05:6512:2209:b0:53e:36ca:6578 with SMTP id 2adb3069b0e04-53e36ca66e1mr7455497e87.43.1733857413359;
        Tue, 10 Dec 2024 11:03:33 -0800 (PST)
Received: from [192.168.219.191] ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401a5360bcsm1001337e87.174.2024.12.10.11.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:03:33 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------plt1Hxu4l5CoqP5bahO6t0OY"
Message-ID: <ff3ea231-b311-4058-ae7c-484b6d2d6feb@gmail.com>
Date: Tue, 10 Dec 2024 20:03:32 +0100
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
Content-Language: en-US
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
In-Reply-To: <94a3c953-0c60-4d28-a496-51f94ec6c501@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 19:03:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/884

This is a multi-part message in MIME format.
--------------plt1Hxu4l5CoqP5bahO6t0OY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/10/24 5:37 PM, Quentin Schulz wrote:
> Hi Oleksii,
>
> On 12/10/24 5:16 PM, Oleksii Kurochko wrote:
>> Hello Quentin,
>>
>> On 12/9/24 4:22 PM, Quentin Schulz wrote:
>>> Hi Oleksii,
>>>
>>> On 12/7/24 5:23 PM, Oleksii Kurochko via lists.yoctoproject.org wrote:
>>>> [You don't often get email from 
>>>> oleksii.kurochko=gmail.com@lists.yoctoproject.org. Learn why this 
>>>> is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> During the fetch stage of u-boot for radxa-zero-3, the following 
>>>> issue occurs:
>>>>    Unable to find revision 8cdf606e616baa36751f3b4adcfaefc781126c8c 
>>>> in branch
>>>>    rk3xxx-2024.07 even from upstream
>>>>
>>>> This happens because the hash of the head commit for the 
>>>> rk3xxx-2024.07 branch
>>>> is different from the one specified in the recipe.
>>>> This can be verified by running the following command in
>>>> <yocto>/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git:
>>>>    $ git rev-list -n 1 rk3xxx-2024.07
>>>>      2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead
>>>>
>>>> Update the SRCREV to the hash of the current head commit 
>>>> corresponding to
>>>> the rk3xxx-2024.07 branch.
>>>>
>>>> Fixes: e0b13fe834b5("radxa-zero-3{e|w}: add")
>>>> Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
>>>> ---
>>>>   recipes-bsp/u-boot/u-boot_%.bbappend | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u- 
>>>> boot/u-boot_%.bbappend
>>>> index c939a48..9432e2b 100644
>>>> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
>>>> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
>>>> @@ -3,8 +3,8 @@ require u-boot-rockchip.inc
>>>>   FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
>>>>
>>>>   SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot- 
>>>> rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
>>>> -SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
>>>> -SRCREV:radxa-zero-3:rk-u-boot-env = 
>>>> "8cdf606e616baa36751f3b4adcfaefc781126c8c"
>>>> +SRCREV:radxa-zero-3 = "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
>>>> +SRCREV:radxa-zero-3:rk-u-boot-env = 
>>>> "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
>>>>
>>>
>>> Master poky now has v2024.10 and at a glance it seems the Zero 3E/W 
>>> is supported, so maybe we could simply ditch those overrides for 
>>> master branch in meta-rockchip?
>>
>> This is first time when I started to work with rockchip so I need
>> some time what is the difference between Kwiboo's u-boot and upstream 
>> one.
>>
>
> Welcome to the community then :)

Thanks!

>
> https://github.com/Kwiboo/u-boot-rockchip/commits/rk3xxx-2024.07/ 
> about ~30 patches on top of upstream 2024.07.
>
> Kwiboo is known for upstreaming his work so it's a good idea to check 
> upstream every now and then. I don't think Kwiboo is guaranteeing his 
> branches won't be rebased (and if he did, it has already happened here 
> :) ).
>
> Another option is to ask Trevor or someone else to have a git repo 
> with commit 8cdf606e616baa36751f3b4adcfaefc781126c8c hosted somewhere 
> publicly and point at there while they guarantee they will never 
> delete, remove or rebase the branch or repo.
>
>> If there is no any specific patches and the difference is only that 
>> some patches haven't been upstreamed then I prefer this approach. 
>> Otherwise ...
>>
>
> I would personally just build upstream and see what's broken there (if 
> there's something broken).

Agree, it should the best one option ( considering that Zero 3E/W is 
present there ).


>
>>>
>>> Other release branches should probably get a fix similar to the one 
>>> in this patch though. Or ideally just download the patches from that 
>>> tree and apply them on top of v2024.07 for styhead (we would need a 
>>> new release branch for that though). Scarthgap has v2024.01 so 
>>> that's a bit too old to apply patches destined to 2024.07. But we 
>>> could maybe point to v2024.07 upstream+patches instead of pointing 
>>> to Jonas (Kwiboo)'s personal git repo.
>>> What do you think? Trevor, an opinion here?
>>
>> ...  v2024.07 upstream + patches will be the best one option we could 
>> have now.
>>
>> I have the small issue here. At the moment I don't have radxa-zero-3 
>> board so I can check only build. My target is RV1103 SoC for which I 
>> want to add support to Yocto. But
>> I think that I can start in parallel update u-boot recipe for radxa- 
>> zero-3 too and then ask someone to test on a board.
>
> It would be nice if Trevor still has in his DL_DIR in his build bots 
> the archive for the commit that isn't reachable anymore. Then he can 
> generate the patches on top of v2024.07 and it'll essentially be the 
> exact same code as here and even guaranteed to not disappear.
>
> Then you don't need to be able to boot it if it's essentially the same 
> patches on the same base.
>
> There doesn't seem to be support for RV1103 in the kernel right now 
> and since we use the kernel device tree in U-Boot, there's probably 
> going to be some work there. Do you know how similar RV1103 to RV1108 
> and RV1109 maybe? 
> https://lore.kernel.org/linux-rockchip/a5d4f421-5120-4421-944e-d39d67e482bb@linumiz.com/ 
> seems like someone is creating some board on that SoC as well, maybe 
> there'll be patches at some point?

At the moment, I don't know the specific difference but I am expecting 
that it should not be too big.


>
> I would recommend getting familiar with compiling and flashing the 
> kernel and U-Boot manually on your RV1103 device before trying to 
> compile them within Yocto, especially if there are patches to write 
> for both to be able to boot upstream. For downstream (vendor kernel 
> for example), that's a different topic :)

I started to play with their build system ( 
https://github.com/LuckfoxTECH/luckfox-pico/blob/main/project/build.sh ) 
but I am not really like it ( at least, sometimes I have to build 
several times to get finally compiled something ) and it is the reason 
why I decided to start Yocto port.

My first step is to come up with recipes which repeat the way how they 
are building U-boot and kernel ( based on the source code available in 
their SDK ) as I am not understand at the moment how big difference is 
with upstream. Does it make sense to do in that way?

And only after that start to look at how to optimize everything and make 
it looks closer to upstream.


~ Oleksii

--------------plt1Hxu4l5CoqP5bahO6t0OY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/10/24 5:37 PM, Quentin Schulz
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:94a3c953-0c60-4d28-a496-51f94ec6c501@cherry.de">Hi
      Oleksii,
      <br>
      <br>
      On 12/10/24 5:16 PM, Oleksii Kurochko wrote:
      <br>
      <blockquote type="cite">Hello Quentin,
        <br>
        <br>
        On 12/9/24 4:22 PM, Quentin Schulz wrote:
        <br>
        <blockquote type="cite">Hi Oleksii,
          <br>
          <br>
          On 12/7/24 5:23 PM, Oleksii Kurochko via
          lists.yoctoproject.org wrote:
          <br>
          <blockquote type="cite">[You don't often get email from
            <a class="moz-txt-link-abbreviated" href="mailto:oleksii.kurochko=gmail.com@lists.yoctoproject.org">oleksii.kurochko=gmail.com@lists.yoctoproject.org</a>. Learn why
            this is important at
            <a class="moz-txt-link-freetext" href="https://aka.ms/LearnAboutSenderIdentification">https://aka.ms/LearnAboutSenderIdentification</a> ]
            <br>
            <br>
            During the fetch stage of u-boot for radxa-zero-3, the
            following issue occurs:
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
            b/recipes-bsp/u- boot/u-boot_%.bbappend
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
              SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-
            rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
            <br>
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
          3E/W is supported, so maybe we could simply ditch those
          overrides for master branch in meta-rockchip?
          <br>
        </blockquote>
        <br>
        This is first time when I started to work with rockchip so I
        need
        <br>
        some time what is the difference between Kwiboo's u-boot and
        upstream one.
        <br>
        <br>
      </blockquote>
      <br>
      <pre>Welcome to the community then :)
</pre>
    </blockquote>
    <pre>Thanks!</pre>
    <blockquote type="cite"
      cite="mid:94a3c953-0c60-4d28-a496-51f94ec6c501@cherry.de">
      <br>
      <a class="moz-txt-link-freetext" href="https://github.com/Kwiboo/u-boot-rockchip/commits/rk3xxx-2024.07/">https://github.com/Kwiboo/u-boot-rockchip/commits/rk3xxx-2024.07/</a>
      about ~30 patches on top of upstream 2024.07.
      <br>
      <br>
      Kwiboo is known for upstreaming his work so it's a good idea to
      check upstream every now and then. I don't think Kwiboo is
      guaranteeing his branches won't be rebased (and if he did, it has
      already happened here :) ).
      <br>
      <br>
      Another option is to ask Trevor or someone else to have a git repo
      with commit 8cdf606e616baa36751f3b4adcfaefc781126c8c hosted
      somewhere publicly and point at there while they guarantee they
      will never delete, remove or rebase the branch or repo.
      <br>
      <br>
      <blockquote type="cite">If there is no any specific patches and
        the difference is only that some patches haven't been upstreamed
        then I prefer this approach. Otherwise ...
        <br>
        <br>
      </blockquote>
      <br>
      I would personally just build upstream and see what's broken there
      (if there's something broken).
      <br>
    </blockquote>
    <p>Agree, it should the best one option ( considering that Zero 3E/W
      is present there ). <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:94a3c953-0c60-4d28-a496-51f94ec6c501@cherry.de">
      <br>
      <blockquote type="cite">
        <blockquote type="cite">
          <br>
          Other release branches should probably get a fix similar to
          the one in this patch though. Or ideally just download the
          patches from that tree and apply them on top of v2024.07 for
          styhead (we would need a new release branch for that though).
          Scarthgap has v2024.01 so that's a bit too old to apply
          patches destined to 2024.07. But we could maybe point to
          v2024.07 upstream+patches instead of pointing to Jonas
          (Kwiboo)'s personal git repo.
          <br>
          What do you think? Trevor, an opinion here?
          <br>
        </blockquote>
        <br>
        ...  v2024.07 upstream + patches will be the best one option we
        could have now.
        <br>
        <br>
        I have the small issue here. At the moment I don't have
        radxa-zero-3 board so I can check only build. My target is
        RV1103 SoC for which I want to add support to Yocto. But
        <br>
        I think that I can start in parallel update u-boot recipe for
        radxa- zero-3 too and then ask someone to test on a board.
        <br>
      </blockquote>
      <br>
      It would be nice if Trevor still has in his DL_DIR in his build
      bots the archive for the commit that isn't reachable anymore. Then
      he can generate the patches on top of v2024.07 and it'll
      essentially be the exact same code as here and even guaranteed to
      not disappear.
      <br>
      <br>
      Then you don't need to be able to boot it if it's essentially the
      same patches on the same base.
      <br>
      <br>
      There doesn't seem to be support for RV1103 in the kernel right
      now and since we use the kernel device tree in U-Boot, there's
      probably going to be some work there. Do you know how similar
      RV1103 to RV1108 and RV1109 maybe?
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/linux-rockchip/a5d4f421-5120-4421-944e-d39d67e482bb@linumiz.com/">https://lore.kernel.org/linux-rockchip/a5d4f421-5120-4421-944e-d39d67e482bb@linumiz.com/</a>
      seems like someone is creating some board on that SoC as well,
      maybe there'll be patches at some point?
      <br>
    </blockquote>
    <p>At the moment, I don't know the specific difference but I am
      expecting that it should not be too big.</p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:94a3c953-0c60-4d28-a496-51f94ec6c501@cherry.de">
      <br>
      I would recommend getting familiar with compiling and flashing the
      kernel and U-Boot manually on your RV1103 device before trying to
      compile them within Yocto, especially if there are patches to
      write for both to be able to boot upstream. For downstream (vendor
      kernel for example), that's a different topic :)
      <br>
    </blockquote>
    <p>I started to play with their build system (
      <a class="moz-txt-link-freetext" href="https://github.com/LuckfoxTECH/luckfox-pico/blob/main/project/build.sh">https://github.com/LuckfoxTECH/luckfox-pico/blob/main/project/build.sh</a>
      ) but I am not really like it ( at least, sometimes I have to
      build several times to get finally compiled something ) and it is
      the reason why I decided to start Yocto port.</p>
    <p>My first step is to come up with recipes which repeat the way how
      they are building U-boot and kernel ( based on the source code
      available in their SDK ) as I am not understand at the moment how
      big difference is with upstream. Does it make sense to do in that
      way?<br>
    </p>
    <p>And only after that start to look at how to optimize everything
      and make it looks closer to upstream.</p>
    <p><br>
    </p>
    <p>~ Oleksii<br>
    </p>
  </body>
</html>

--------------plt1Hxu4l5CoqP5bahO6t0OY--

