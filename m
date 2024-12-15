Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E42E7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 20:21:04 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
 by mx.groups.io with SMTP id smtpd.web11.42296.1734294055039216133
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 12:20:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=j4wvO8B/;
 spf=pass (domain: gmail.com, ip: 209.85.219.175, mailfrom: akuster808@gmail.com)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3990bbe22cso2436052276.1;
        Sun, 15 Dec 2024 12:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734294054; x=1734898854; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wjyJhlGoxqeSkCnunwnBJXvICiaw0KFADyoPgf0DQy4=;
        b=j4wvO8B/5tXzBLBvJQYOIRX+lbCZjznF4FXdMzvgeL/aWtwK3IAzGfNeE11+xi+0oM
         354g5JWKukVArRAOegJaOUQR2vvOx4I4CQWWHNI2I6ZpGPsI4J1D92Obs3I1N8oD2ezj
         fIZnXqV2uW9YkBCbpXnh2EsGI//raPFwaw9D9CGnyMEUz0nKZvlNBbLYC2QXjOtPx3wZ
         wzVqNnEPgoFL/SEfabd2B/aMUhPnmePs2ZgSY7Ev/peyK7QRuCa06/qJ7NV/uIDR6ija
         irkUM51P7nprBqJvqF7ZBxnHntn9l4kCegLbLlIzBxvHGtDeHMeO69ar9zSrdx4WCpdw
         5DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734294054; x=1734898854;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjyJhlGoxqeSkCnunwnBJXvICiaw0KFADyoPgf0DQy4=;
        b=rcVqA6rAKOZo3hH8nxlc8PyfyMrt+lbpGNu2C9kC/bFdJjkWTqdX+yvAyq5+mDhasl
         jk4yKD/WtkrmHc9/rgaBqK//aipLRdiOLz83hlqccswB2clnapvTHUyFnm9zkZ+Ztmc3
         GezyNcclBTpkUK3mXVQYj6n/SjWHYI96tBGYEhgFthW50wc9kPlTy1HZmJJFJoBYBzqZ
         +jR7jQklUK2clMofYvjNXttBVoKwxhOuumfmgFirRmAZGV1FplTrSE7k9jH7YRDRiTM3
         rxg6mfSlB6ewn9W+aWHV2LQdTV5vNivWpf/l2UoxrSD+HdJo1G4hJyr3AxBcOYJdGBIJ
         q8lA==
X-Gm-Message-State: AOJu0YxIuJzixqz6ZD+V9TFo9Kw/HNF8XSzZl9TijDcjxvPHEb5kGZNw
	i83/vBGtOSzQ24+gIBUh5xr1IIXm0oSDYaeZb90x27wcvbFxYemShv+QGjgV
X-Gm-Gg: ASbGncskW4/0a/atJX6VWNHuz9/jMPUy/i0ljARI/Cbo2pirz8OKmZGNJk5B803jYu3
	AbXNs+dkszGedOhywiVETzcHFdb4I1bnFLHryDcpWPxbruFGQW2j4uINtkTOjEmuZR46LJZddd0
	zGw3EwetSjXIpDb9dzdZ8IgKWMs/022OsNMrUrunc9SEq4WS4YPPSOoGbSW3kafhRhzsxHKD2dv
	YupWGdrzbF5rTlkjZaTp10TxTiPSSseC836oyhjYancUCD5los4cArQx29+L5B6dSNUcpDP1ls/
	js/l2ynSvtvpzOS9qNLk0XZh1VJvtw==
X-Google-Smtp-Source: AGHT+IE+bghqY4FrX7Nd61ygzuFs4fITdVn4vGw4RYnYwhr2olZEOPnShU0IeFmJOcwv/Xk9U6jyVA==
X-Received: by 2002:a05:6902:1587:b0:e4d:d319:ba6 with SMTP id 3f1490d57ef6-e4dd3190cc0mr1083850276.39.1734294054002;
        Sun, 15 Dec 2024 12:20:54 -0800 (PST)
Received: from ?IPV6:2600:1700:45dd:7000:a906:ba5:bc1d:da36? ([2600:1700:45dd:7000:a906:ba5:bc1d:da36])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e478478dc4dsm934867276.35.2024.12.15.12.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 12:20:53 -0800 (PST)
Message-ID: <d8ec15f4-67f6-4c79-a6b1-97caafd2065c@gmail.com>
Date: Sun, 15 Dec 2024 15:20:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH 2/2] drop: debug-tweaks
 from ci
To: mikko.rapeli=linaro.org@lists.yoctoproject.org
References: <20241208175318.833015-1-akuster808@gmail.com>
 <20241208175318.833015-2-akuster808@gmail.com> <Z1ahwRtEYmWRsJ5H@nuoska>
Content-Language: en-US
Cc: yocto-patches@lists.yoctoproject.org
From: akuster808 <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; keydata=
 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
 ApZ86eOP
In-Reply-To: <Z1ahwRtEYmWRsJ5H@nuoska>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 20:21:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/918




On 12/9/24 2:52 AM, Mikko Rapeli via lists.yoctoproject.org wrote:
> Hi,
>
> On Sun, Dec 08, 2024 at 12:53:18PM -0500, Armin Kuster via lists.yoctoproject.org wrote:
>> Signed-off-by: Armin Kuster <akuster808@gmail.com>
>> ---
>>   kas/kas-security-base.yml | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
>> index fa7915c..bdd74b1 100644
>> --- a/kas/kas-security-base.yml
>> +++ b/kas/kas-security-base.yml
>> @@ -43,7 +43,6 @@ local_conf_header:
>>       BB_TASK_IONICE_LEVEL = '2.7'
>>       BB_TASK_IONICE_LEVEL_task-testimage = '2.1'
>>       TEST_QEMUBOOT_TIMEOUT = "1500"
>> -    EXTRA_IMAGE_FEATURES ?= "debug-tweaks"
> For testing purposes this is needed:
>
> --- a/kas/kas-security-base.yml
> +++ b/kas/kas-security-base.yml
> @@ -43,7 +43,7 @@ local_conf_header:
>       BB_TASK_IONICE_LEVEL = '2.7'
>       BB_TASK_IONICE_LEVEL_task-testimage = '2.1'
>       TEST_QEMUBOOT_TIMEOUT = "1500"
> -    EXTRA_IMAGE_FEATURES ?= "debug-tweaks"
> +    EXTRA_IMAGE_FEATURES += "allow-empty-password empty-root-password allow-root-login"
>       PACKAGE_CLASSES = "package_ipk"
>   
>       DISTRO_FEATURES:append = " security pam apparmor smack ima tpm tpm2"

That looks correct.

> Or is this to be replaced by something else?
>
> I'm trying come up with a set of patches which pass some of the runtime tests again.
>
> Cheers,
>
> -Mikko
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#871): https://lists.yoctoproject.org/g/yocto-patches/message/871
> Mute This Topic: https://lists.yoctoproject.org/mt/109992719/3616698
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13197873/3616698/1325074317/xyzzy [akuster808@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>


