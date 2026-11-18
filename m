Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14059.1795012957653944153
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Nov 2026 06:42:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=yl3SDEdI;
 spf=pass (domain: gmail.com, ip: 209.85.161.54, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6aa9606ddadso731368eaf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 06:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795012957; x=1795617757; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=szd9WzX4uAh/p/neM2kFcJr0IneS5xEJYWZO3uYdG0E=;
        b=yl3SDEdIwY4Mgq4BFHxQOflyd20PXBuS/fPppL1C4OeD7/0GewisAHvWGjGWUAHQpi
         mplosq++WVBp/+rWUARlh4u0hDGDh/j7DLAXMLJa2PjJWQOBEXaUp+Jnl8OCjFjGUy10
         1v8ah4t9sBhjRFV7yg1Wfvhuz4wmBmL27SkFmho+PCyb5XIVay8z0xYbAo64N8B9bnnj
         ESGLtkWpAotnfDJpp4lNxKAAdPv0058rqtlzBoqH6nMzX41/0Xq9fYBVHZ6+/aBB7BDe
         pbe0FJmKSShTMa3nhYEIS3b+6wcqPr0aIqTuItukf4qot+hwuW7T/OVS7Xao5X+xMioX
         X5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012957; x=1795617757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szd9WzX4uAh/p/neM2kFcJr0IneS5xEJYWZO3uYdG0E=;
        b=oNz26lvMBhYTl4KNio94u2fjCxUUKCmOkjN2ECqsOWP0F+PkVXVPu1BDtCE1+tM/g9
         8oxFH9yZZ3nfpU10SyHjaGUGWC6ZBZ/9cN+mnCnYJrSb7TBb6Y0zoeWfIITYuQncwShE
         yejgbHCDvVXpcfpz/CTrTH+ADaYFiMiMsSsYDASyjkkdMZ3I2F9sSkIS2aIvANN6Pn50
         XF20ffmKaMjgL9PbslwdK8c7GFDBsWc1IIhbqPKyP+xe2y5MboLLWcNNeSjOZ1AC22fh
         J5tVhXRQzDT33OPAx3W6iLee67pDQb8BDTuTz9t499JESAELVaUeeH5QS6GKmhpW4RL5
         6GQg==
X-Gm-Message-State: APuU4Z96fyI47d6P+Bu4k6kpEvmh/POCRtXowRd13Au14e9w+dCqNudN
	LzqYz03NsffSYgaZZrSo9l4zSYqkOatQ92wjKYdG6mIBuGhNTmSFYdC35ESAow==
X-Gm-Gg: AYBFou1XK7kQDT7kjG0IRWbHswDhjwX8fZ+DrpusuQ/gw2sHdXuBRsJp35zHy9Imy+I
	N6W+vO62mR5blrJx/xADP0TNv3+35oQtoAXrADYjSp7/Yc0tUl4dZQUrjodwRSgtiadVxcLg0/N
	opkA8f8cWpJYx+ZrjochahS/vew5RoKbfllQOrJxnNQDbVSLlvgWHT0VXmARHoDxWAve+PQUxSL
	rudnFS8pbipuPMmeA1afK0l51bYjiTafDFnJjZMo7uxwK3NQgneIvuDQoIzua1+rmFcjAPWqPEC
	9SgyCo2zpbscF/j+N2boTuwUAITcVKJiaPJRqqeGDOZzoSPaLBdv5MW0P4F/Skpfosk3W90OaAi
	gMDRiPSjHSs8MP+GBNRzkey5U/Hv0FgOqjDIMoe0awtAtw9dmYirwrWu+DGmscGFHBxtVa+VNyk
	zCMbHwPC09hRBBTiCMDHbrf4e9D2VewtgdyoQeMQzKQpPQNehoeqZ0Kudb27iWrPM78ekSbDHoZ
	RAzTL0pWYyfqC5a1FXD63BOmiuMou/mMKTdv/+KRWewW1ZEOcwi5ehd43VwBqo2sUjF+dzr3TBO
	1ROMaZc0Kq64XnZOhuSiFIlFj+dZrBztLxPBM5vaqpbUJNgvGCBqCg==
X-Received: by 2002:a05:6820:5703:10b0:716:c032:d480 with SMTP id 006d021491bc7-71b1853a5f7mr1449988eaf.19.1795012956772;
        Wed, 18 Nov 2026 06:42:36 -0800 (PST)
Return-Path: <majortomtosourcecontrol@gmail.com>
Received: from [172.26.252.72] ([73.229.151.109])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b194a7555sm1789623eaf.7.2026.11.18.06.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 06:42:36 -0800 (PST)
Message-ID: <9b4a7daa-7e40-4c91-b5b5-f747d5871523@gmail.com>
Date: Wed, 18 Nov 2026 07:42:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 6/6] refpolicy-targeted: allow
 ssh_sysadm_login by default
To: yocto-patches@lists.yoctoproject.org, Chen Qi <chenqi_hycx@cetc.com.cn>
Cc: chen_q07@163.com
References: <20261116025714.2558951-1-chenqi_hycx@cetc.com.cn>
 <75e87558-98fa-42a4-83b6-efd9eff0ad1d@gmail.com>
 <954eae3a-f2ab-46e9-9952-5cd29bdc4c2a@cetc.com.cn>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
In-Reply-To: <954eae3a-f2ab-46e9-9952-5cd29bdc4c2a@cetc.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 14:42:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5474

> Thanks for your review. I'll fix these typos in V2. 

Of course!

>>
>>> @
>>> This is because Yocto's targeted policy is making users land in
>>> unconfined_u selinux user by default, and unconfined_u is treated
>>> as privileged user, thus being forbidden by default as the default
>>> value of ssh_sysadm_login is false.
>> A Yocto mechanism could be added to map users; I do this in a private
>> layer.
>@
> I currently don't like refpolicy-targeted using a patch to change the user mapping: https://git.yoctoproject.org/meta-selinux/tree/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch

I agree - 0002 should be revised/removed; I have a local patch for this.

For other readers: https://danwalsh.livejournal.com/66587.html

>@
> I guess there might be some better way but I haven't got time to look into that further.
>@
> Do you want to fix this refpolicy-targeted with your user mapping mechanism? I think that would be a very good change for meta-selinux.

My current mapping mechanism is not ideal: changing seusers statically.

I am actively working on doing this properly using Yocto variables, but 
it is a full user definition (beyond a narrow SELinux scope).

I will try to find the time (and approval) to adapt it. 

>@
>>> @
>>> Change to enable ssh_sysadm_login for targeted thus minimal by
>>> default.
>>> @
>> I don't think ssh_sysadm_login should be enabled by default, given:
>> * RefPolicy upstream doesn't do so (secure by default)
>> * Yocto generally doesn't do so [1] 
>>
>> What are your thoughts on adding a configuration fragment instead,
>> similar to [1]?
>@
> Good idea. My main focus is to make testimage work for the refpolicy-targeted so that it can also be tested automatically. Looks like this is a similar use case with 'root-login-with-empty-password'.
>@
> I'll use this approach in V2. 

Super!
Thank you for improving testing!
