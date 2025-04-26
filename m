Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F5BC369D3
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 08:50:18 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.16505.1745702061876701895
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 26 Apr 2025 14:14:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DJdeEsSA;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: fntoth@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso603287066b.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 26 Apr 2025 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745702060; x=1746306860; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/g596vltwaCoSw+sTqzMibfAA+MXJKiI4V8Bwn1tG4=;
        b=DJdeEsSA1qVSog46y2YBkJKmyH4Kt0jvoxfezEWrRZv19hDwXpOnlYb4ilTAcS+4HY
         OY0G8ja4j9Y9iNK6mXeJog5gToC7nThJ510ou+ibPo9F8hAMpeXHjEag+BGAz0GR7wdJ
         o3DOVSm4nCDKoPqvH0QWDA74pPC5R//+jCVCfJWZ5Krtk52uaQIXCoNRn1HM04WId7eG
         98xPkOaqjjzuziQXV4FETrQ3i+OP1ZruXDrW/mr0/QVbE61aDBgyhT9Q6HkaNzxLgr8X
         0hWSiYVb08Yay3/lvrWyvQ2ShRfKa0RkUaBS5F6uKzUrYZ3yFvb8zV6uyp4erXrRN8B9
         MGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745702060; x=1746306860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/g596vltwaCoSw+sTqzMibfAA+MXJKiI4V8Bwn1tG4=;
        b=knBsnpQ+17UDW0V1PSs7Jt3tp3RIKgRIOTCR15QS0b2j8ZRau2ryNg+DGjkxW5dxfV
         8lMSL62q3rfT4ZBkD6c3aD452xQP5Ox8e4uIybPAo4HiYtWuGv3n+2ZrIQasd7Wfwcs0
         3h5v6+0HqolReP99XktOkkaLddwGbih2DGkMWm5vBDpCNHa4sV6+NyjXdf9L/AMz6z73
         Kz7fda6IonW6QZdHB56upEIVhF8Y7kg/ajzyoGemVj7v5EBIBpi48RZi5kpdv/16QFx4
         ml++TIMXP7WZik+64VvKvEx5BfXgbbXtiIvfjZ29Zo3sRrQMtwVkBPuRgW20OjsblJEC
         ihQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9TwWme5hRCDm5C8u6UiBVppqaHeW42RjxNNmHGXcPxyLIgTA4AwcwKHO30DzyzTApNV1xoyGBmlJtWd7G@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyLFBc7NCAHC948Eziqn7w1urlyixdsablTe5SDZmr5sH6yJp5m
	rCZLEVZV8GYnVMRw9GWnqYXAjVJQlm9KEgzwU1u4QicrnSCXQ1TS
X-Gm-Gg: ASbGncv4HRR381sK331I6kaeJd5/gkyxdXo/J9FBBVlHAZQ9igACQwCEZz1TK5mMfyE
	6i+o3Jnneauau4koHkCpe6qEKCY6lhxLAoVEhuDIi9VL+gcrtJHH4YzNa0i/1tYhMJpxbi3Ohv9
	bTCo/0ssLNmwjpRZJzlJ/B/+wc/XdfRl5Rt1YjbzQL++FJzItyJhhRCVWodsWEu87l/fFXLBI/r
	uO8x9k4jXaTraTXR7Orl7O40DOe4rOlAVzEtR0c6q1n4fcMCcns7dBrR/iq7dLpjzPGUeQ17Z9e
	EdjQHJ3wHwCDlD4vYZg3QAVEDcU1tgfHsa+cmLm27YA7hjXkL5rXPJiRQptQBcOBrk9LIiQV875
	V4nt72MhSpPnNMoy8sHK7KZhGcJoTO7PtzBfCcWVLNJpgPXZO2UsJnKx3KA==
X-Google-Smtp-Source: AGHT+IGO86tymsIPsTAgegXMGa5PpyC7IlV+WV2yt+EegZZ9tEVwjkTlPvlnyJE00UJGaYIbEvvoeA==
X-Received: by 2002:a17:907:7da1:b0:aca:c924:c14 with SMTP id a640c23a62f3a-ace73a45cbfmr602479166b.17.1745702060076;
        Sat, 26 Apr 2025 14:14:20 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:b4b9:d84:88d0:f6eb? (2a02-a466-68ed-1-b4b9-d84-88d0-f6eb.fixed6.kpn.net. [2a02:a466:68ed:1:b4b9:d84:88d0:f6eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41cb35sm341081066b.31.2025.04.26.14.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 14:14:19 -0700 (PDT)
Message-ID: <727bd608-5ccd-4a2a-901e-2f86389c7d68@gmail.com>
Date: Sat, 26 Apr 2025 23:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][PATCH v2 2/2] nftw, ftw: add tests
To: Mark Hatle <mark.hatle@kernel.crashing.org>,
 yocto-patches@lists.yoctoproject.org, Gyorgy Sarvari <skandigraun@gmail.com>
References: <20250407191414.2992785-1-skandigraun@gmail.com>
 <18341F33308F8E0B.31078@lists.yoctoproject.org>
 <b4499a40-ff59-4d17-9dc4-00a7221c4e19@gmail.com>
 <1bd5bd95-8387-4f76-8018-389738f3f910@kernel.crashing.org>
From: "Ferry Toth" <fntoth@gmail.com>
In-Reply-To: <1bd5bd95-8387-4f76-8018-389738f3f910@kernel.crashing.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 08:50:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1404

Hi Mark,

Op 08-04-2025 om 18:06 schreef Mark Hatle:
> 
> 
> On 4/8/25 9:33 AM, Gyorgy Sarvari via lists.yoctoproject.org wrote:
>> On 4/7/25 21:14, Gyorgy Sarvari via lists.yoctoproject.org wrote:
>>> +#if !defined(__USE_LARGEFILE64) && FTW_NAME == ftw64
>>> +return 0
>>> +#endif
>> If nothing else, at the very least a semicolon is missing in this short
>> path when the call is not available (and in its nftw64 pair). Will keep
>> it in mind to fix - won't submit a v3 only with this on my own.
> 
> Thanks, I'll add this to my local merge for review and testing.

Tested-by: Ferry Toth <fntoth@gmail.com>

This is an import patch for walnascar and master. The reason is that 
walnascar already (even though it is not released) has btrfs-tools 6.13 
which will not generate bootable images without this patch.

Also, scarthgap has btrfs-tools 6.7.1 which creates an image with errors 
(2000 in my case, or maybe it stops counting). Luckily that image boots.

But scarthgap being LTS imho should have a backported btrfs-tools and 
because of that also pseudo with this patch or similar.

I tested this on Intel Edison scarthgap with this patch in a bbappend 
(and the other pseudo patches refreshed and git formatted).

> --Mark
> 
>>
>> 
>>
> 


