Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A99EE77180
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 15:45:30 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.13478.1733845526228566950
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Dec 2024 07:45:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lvQ+BjEU;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso2806887a12.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 07:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733845525; x=1734450325; darn=lists.yoctoproject.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFr9wG5DCZ5grPaSuy2t3QQyo1+cex66bB1Y1pzcshA=;
        b=lvQ+BjEUunG3Z/rbJDvFHYzLaqPPc+UVUA8MIh6dfubgsb2hQBJqV8p9oBp+U+wlZA
         9iC07wS8jVIvF1XDw4PRIZmzPdpSJbFf7xDxGRtpZyGON9Zcq/e5z9p/dquX23plLmGl
         aHriiH54cLjSyfyaB+vf7HhAVJT/RtUg9F/5C1ld4BjNBkyzuhPkQ/AKqGTNi9FxTAA0
         0CWWtf7hg2APGiEGLdtb3hYLguC3ooSBQvJCfzkAv5mxviEJwLIbCnXhe9zXpdOMMT+A
         /KZu1/3tZsjhaK85ECTK7qipg+XrFX7r4Xc+YLl/ctkkvzS/Qi+i2UymLcLHEUFLaSLm
         GpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733845525; x=1734450325;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dFr9wG5DCZ5grPaSuy2t3QQyo1+cex66bB1Y1pzcshA=;
        b=GxiX4EzGUWBvClsG8FSPQxTSjE1S+YmZjazEVxhO5viFTgrWry6dwAdvvdu283EIB2
         mnvmz5LaHXnh7w+Qi2tqxxC+rIae1VJvWbMqPI7w8XY5kLYfB6aK0JON5o0jqdI1NcFn
         oFIArIIHFkzR9UTsekmHEysyXhtfaaNxDWXFM3IaOKjRawxHpWw1go4r0pozGXkUwGJe
         q9GoGH1jxP6ehioUoldX079duY2cVbyjGdxLqD2U/taMdPYgQ910w2G8svFxVtUM5Io8
         kGYVU2N/hNH/8TGF2wOq+4vPZYNlwk6I76pvq9anCvYbZaBWTuu4M6BorGb69mqt02yg
         pOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnVl8cyj1RmAzzwLBr0FqHs7MAj5iIkrE8FOTJ9JSWe8RU1FyguI1YsNSROosmc0+ZPhMkxx/NpqWSaEbC@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyM3eClyzDNed8Z1qSzDJzN72WUvqjncNm1ooSVDtwZS//iwJny
	6JhaUFICA1fslw04NNvWfM3RLl1VQq/HAi+s1qLWm+8mz6VmU/Q0
X-Gm-Gg: ASbGncsNEmMYLgeIfiFPQRhhmViauI5Pdl0ixPTyfHX/ogqVqfCE6gscQeWEOzEMb7I
	o81ipmunACETNP3lXdOgr4a25JqWkZyi0SviHSlT2AGbm0pLeux3KzHU+pestiB6qQL4XdRyDyV
	GXByEFMzvN9UZeUY+DwjI3Q5OhSEmjQVBqcwmCkW1gPTUzO06YGNQi7BH0e+N7ZzljeI11xR5IM
	KKEEKZ+KZaW5BQz3SqVX8i9/658jn2ILzL2IyVrjl4qthKGDYmG4dLXiYg6lOg2Ymo=
X-Google-Smtp-Source: AGHT+IF2AdCtgxaSC4WOZtsv4cFm7Gn8T9brFSbxG1FGc9fWM2j5BvJ0bC5eB7yt9M0Mn+cbWDeFYg==
X-Received: by 2002:a05:6402:28b1:b0:5d3:d2d0:12c9 with SMTP id 4fb4d7f45d1cf-5d41e2902b6mr3640149a12.8.1733845524221;
        Tue, 10 Dec 2024 07:45:24 -0800 (PST)
Received: from [192.168.219.191] ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dbf898e7sm5198090a12.16.2024.12.10.07.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 07:45:23 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------0sNoJ0EODvTFd0kFO4u8gsrU"
Message-ID: <4348a4d8-1e8d-437d-b05a-81e7ce6c8210@gmail.com>
Date: Tue, 10 Dec 2024 16:45:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-torvalds-next:
 update SRCREV
To: Quentin Schulz <quentin.schulz@cherry.de>,
 yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>
References: <20241207153154.9125-1-oleksii.kurochko@gmail.com>
 <40544790-d5be-46d9-a420-9a835c1b2c1a@cherry.de>
Content-Language: en-US
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
In-Reply-To: <40544790-d5be-46d9-a420-9a835c1b2c1a@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 15:45:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/881

This is a multi-part message in MIME format.
--------------0sNoJ0EODvTFd0kFO4u8gsrU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Quentin,

On 12/9/24 4:03 PM, Quentin Schulz wrote:
> Hi Oleksii,
>
> On 12/7/24 4:31 PM, Oleksii Kurochko via lists.yoctoproject.org wrote:
>> [You don't often get email from 
>> oleksii.kurochko=gmail.com@lists.yoctoproject.org. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> During the fetch process, the following issue occurs:
>>   Unable to find revision fdadd93817f124fd0ea6ef251d4a1068b7feceba in 
>> branch
>>   even from upstream
>>
>> This issue arises because the tag next-20240904 and the commit hash
>> fdadd93817f124fd0ea6ef251d4a1068b7feceba do not exist. This can be 
>> verified
>> by running the following commands in
>> <yocto>/build/tmp/work-shared/radxa-zero-3e/kernel-source:
>>    $ git tag | grep next-20240904
>>    $ git branch --contains fdadd93817f124fd0ea6ef251d4a1068b7feceba
>>      error: no such commit fdadd93817f124fd0ea6ef251d4a1068b7feceba
>>
>> The head commit of v6.11-rc6 is:
>>    $ git rev-list -n 1 v6.11-rc6
>>      431c1646e1f86b949fa3685efc50b660a364c2b6
>>
>> Update the SRCREV to the head commit corresponding to the hash of 
>> v6.11-rc6.
>>
>> Fixes: 7f91ebf5c17ce ("linux-torvalds-next: bump to next-20240904")
>> Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
>> ---
>>   recipes-kernel/linux/linux-torvalds-next_git.bb | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb 
>> b/recipes-kernel/linux/linux-torvalds-next_git.bb
>> index b961b14..34bb9d7 100644
>> --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
>> +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
>> @@ -18,7 +18,7 @@ SRC_URI = " \
>> file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta 
>> \
>>          "
>>   # this is tag 'next-20240904'
>
> The comment needs updating now :)
>
>> -SRCREV = "fdadd93817f124fd0ea6ef251d4a1068b7feceba"
>> +SRCREV = "431c1646e1f86b949fa3685efc50b660a364c2b6"
>>
>
> OK so I believe this is going to be a forever issue as it seems tags 
> older than three months are removed from linux-next.git. I would 
> recommend to just switch the kernel tree to 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git 
> where the old next tags seem to still exist, c.f. 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/?h=next-20240904&id=fdadd93817f124fd0ea6ef251d4a1068b7feceba

Switching tohttps://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git looks good to me. I will send a new patch version.

Thanks for suggestion.

~ Oleksii


--------------0sNoJ0EODvTFd0kFO4u8gsrU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Quentin,<br>
    </p>
    <div class="moz-cite-prefix">On 12/9/24 4:03 PM, Quentin Schulz
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:40544790-d5be-46d9-a420-9a835c1b2c1a@cherry.de">Hi
      Oleksii,
      <br>
      <br>
      On 12/7/24 4:31 PM, Oleksii Kurochko via lists.yoctoproject.org
      wrote:
      <br>
      <blockquote type="cite">[You don't often get email from
        <a class="moz-txt-link-abbreviated" href="mailto:oleksii.kurochko=gmail.com@lists.yoctoproject.org">oleksii.kurochko=gmail.com@lists.yoctoproject.org</a>. Learn why
        this is important at
        <a class="moz-txt-link-freetext" href="https://aka.ms/LearnAboutSenderIdentification">https://aka.ms/LearnAboutSenderIdentification</a> ]
        <br>
        <br>
        During the fetch process, the following issue occurs:
        <br>
          Unable to find revision
        fdadd93817f124fd0ea6ef251d4a1068b7feceba in branch
        <br>
          even from upstream
        <br>
        <br>
        This issue arises because the tag next-20240904 and the commit
        hash
        <br>
        fdadd93817f124fd0ea6ef251d4a1068b7feceba do not exist. This can
        be verified
        <br>
        by running the following commands in
        <br>
        &lt;yocto&gt;/build/tmp/work-shared/radxa-zero-3e/kernel-source:
        <br>
           $ git tag | grep next-20240904
        <br>
           $ git branch --contains
        fdadd93817f124fd0ea6ef251d4a1068b7feceba
        <br>
             error: no such commit
        fdadd93817f124fd0ea6ef251d4a1068b7feceba
        <br>
        <br>
        The head commit of v6.11-rc6 is:
        <br>
           $ git rev-list -n 1 v6.11-rc6
        <br>
             431c1646e1f86b949fa3685efc50b660a364c2b6
        <br>
        <br>
        Update the SRCREV to the head commit corresponding to the hash
        of v6.11-rc6.
        <br>
        <br>
        Fixes: 7f91ebf5c17ce ("linux-torvalds-next: bump to
        next-20240904")
        <br>
        Signed-off-by: Oleksii Kurochko
        <a class="moz-txt-link-rfc2396E" href="mailto:oleksii.kurochko@gmail.com">&lt;oleksii.kurochko@gmail.com&gt;</a>
        <br>
        ---
        <br>
          recipes-kernel/linux/linux-torvalds-next_git.bb | 2 +-
        <br>
          1 file changed, 1 insertion(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb
        b/recipes-kernel/linux/linux-torvalds-next_git.bb
        <br>
        index b961b14..34bb9d7 100644
        <br>
        --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
        <br>
        +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
        <br>
        @@ -18,7 +18,7 @@ SRC_URI = " \
        <br>
                
<a class="moz-txt-link-freetext" href="file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta">file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta</a>
        \
        <br>
                 "
        <br>
          # this is tag 'next-20240904'
        <br>
      </blockquote>
      <br>
      The comment needs updating now :)
      <br>
      <br>
      <blockquote type="cite">-SRCREV =
        "fdadd93817f124fd0ea6ef251d4a1068b7feceba"
        <br>
        +SRCREV = "431c1646e1f86b949fa3685efc50b660a364c2b6"
        <br>
        <br>
      </blockquote>
      <br>
      OK so I believe this is going to be a forever issue as it seems
      tags older than three months are removed from linux-next.git. I
      would recommend to just switch the kernel tree to
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git">https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git</a>
      where the old next tags seem to still exist, c.f.
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/?h=next-20240904&amp;id=fdadd93817f124fd0ea6ef251d4a1068b7feceba">https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/?h=next-20240904&amp;id=fdadd93817f124fd0ea6ef251d4a1068b7feceba</a><br>
    </blockquote>
    <pre>Switching to <a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git">https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git</a> looks good to me. I will send a new patch version.

Thanks for suggestion.

~ Oleksii
</pre>
    <p><br>
    </p>
  </body>
</html>

--------------0sNoJ0EODvTFd0kFO4u8gsrU--

