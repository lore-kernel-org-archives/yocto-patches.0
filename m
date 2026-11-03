Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11143.1793712404803506568
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Nov 2026 05:26:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=Gtu1qfWk;
 spf=pass (domain: gmail.com, ip: 209.85.160.43, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4a6fb4040cfso1316619fac.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 05:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793712404; x=1794317204; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5RqoTqCNjNMiVvyYHSN046iDqSgvGngoS1EKboJfo2E=;
        b=Gtu1qfWkDoNG1xBWvJTKxlAihNdJvshsKBg9iYgHP/tMJ0AS4AbyhMb7LHUw9YIyWz
         1rsKx+jXtgKKUmGoDGJBTmjA7Cw5Hu2SufR9jc9kjAvhYAWnX9T1EcuSFzbPL9il9OFw
         snA5V5Zaknd8AVcFMugW3TjSUgD7YivyccY9StdGhGDyd9f+M5ThT2GqwHQ7qlFW/UPI
         K1Vf0dZ01QcmFIy+BKY3HI4pD0e0noXMOoO2vmCgsoEbBACPWmWQY/FXI1CoAtrvQ5TH
         goStknfHdPs7h1hKN7QMlpnGrT6TmS8drSKLbTV4wTzdIbD6fEhlAwMg82n8hliEL/61
         +F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793712404; x=1794317204;
        h=content-transfer-encoding:content-type:in-reply-to:cc
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5RqoTqCNjNMiVvyYHSN046iDqSgvGngoS1EKboJfo2E=;
        b=z9Z41sGKUZOVKlucevlDwa42jGcui+GLKQNk3CAGXcGRUmptBCGAoS6SGDII8KG+Wy
         4En6r0xnn5GwRYNvQt31M7aFtq4dkc5hUEtYJCHxmhhWOA7f/qtnZdSd6C9FWYYlq+KV
         9RhPzjrwKBVo3mE8a9ip+sUhjDh1jmIuidxTIvaKtusag86zt0dcon3iTFD2yNOluFrR
         DCEI9ge83VAK0nLq7Nq7bZ0hLsaLIBCuJ0LPWKjtjTQvsKcgWoMuoaYHSzqhKadQKQoH
         tEDZokg4kSsVm/5mgpQl0tUN4td3B82Ty8+USD5Cb3cJbkDWIdqG+Zvdi53QLdTAXKTN
         Ewew==
X-Forwarded-Encrypted: i=1; AKwUvBxdh3/nlFmLZxbDAG3GbRiyqJh/u//rYYWPTe+tsJjgRNjTe6u4ivnUmUrVgx9uxH21rVN+k9NOhnuKyVcP@lists.yoctoproject.org
X-Gm-Message-State: APuU4Z/iBi6cILKpnQVsSVlXpRWJale5fOXvPuFu5WFMa0C3jATz03T1
	5mYKD/RsPIXyA1OBbHW62or3kO8IIq6WbjSS37jMG3fVOEYXJ0f7RqPy
X-Gm-Gg: AYBFou1fWU/dSDMLRgMLiVco5c77U0rI1DdH98oe8Xf8BYx9yIyKQjRSkn8Plvw9cQg
	Y4J+Od538U1J9VBsmoYO0IfexHqaGrRRRukKsGGBCuSFtdbIM5dkBgLaAUoeKXHnUJKM3SljdUp
	wbyIcaBUwyNPC8e+QRKtEwI1yZNBOvC9UzfDCD9ErNLg1rxgUVTblQ9GKdncC+2igCW3L9Ru3pF
	26JUH+4Ust6EHg8o9gY9Y2lthbNsS8PF8HtGvUseI1oSnVb/3iKcsMSoJ62pqGprW7wJ9Tvk/Gw
	1a9N7s6upB03dOtvBZMOsdv/5JX400sdy631n6RJV+gGPx1x8icTKcabJW6FVrGH+wCH5139jXx
	xyOQMZUs0RiyU5odRdtNIf1/Rsx08wlS6xxUCvmCWmU6pfOTaV9svphQyE+6NXbxeaWa8GxN3c4
	3q6d+6yH+2kTQoznFve5/Hf1ZDAGOjvYAO6cf8cIvnZ3fZcAi67ajaY8TznFIwuZi2opuhScIrV
	ZVtymhEgeoROOA8ur6lB0XZf/5iAin+Xqc7+aIYAXjru/bERBqyYPFZrcdWgY7i4Ua0VrFg3HXG
	Ttc6eUmND+53O9JenASwUnuB6PvxbyRYIJiW6sb6KFW72x5HH29y
X-Received: by 2002:a05:6870:6b09:b0:49e:1c69:1f57 with SMTP id 586e51a60fabf-4a90771ad90mr8363337fac.41.1793712403875;
        Tue, 03 Nov 2026 05:26:43 -0800 (PST)
Return-Path: <majortomtosourcecontrol@gmail.com>
Received: from [172.26.252.72] ([73.229.151.109])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921a53b59sm8956522fac.14.2026.11.03.05.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:26:43 -0800 (PST)
Message-ID: <7933a8f6-337d-40f7-9e07-c5ff8a1f5739@gmail.com>
Date: Tue, 3 Nov 2026 06:26:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][RFC] refpolicy - add "Yocto" distro upstream
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
To: chenqi_hycx@cetc.com.cn
References: <9fa9f7cb-b82e-4d7e-83af-8027c39590ea@gmail.com>
 <7b3e26c9-b524-4b0f-ac88-5403e256c5d7@gmail.com>
 <24e6a59f-522c-4ef0-a5fd-29af4c160560@windriver.com>
 <7c117fe8-9698-4320-84b6-c53a321f454e@gmail.com>
 <87d913cc-61eb-4527-a080-d77877ede9a3@gmail.com>
Content-Language: en-US
Cc: joe.macdonald@siemens.com, Yi Zhao <yi.zhao@windriver.com>,
 yocto-patches@lists.yoctoproject.org
In-Reply-To: <87d913cc-61eb-4527-a080-d77877ede9a3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 13:26:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5220

>>>
>>> On 7/23/25 10:42, Clayton Casciato wrote:
>>>> >From the upstream maintainer, Chris PeBenito:
>>>> "I'm not opposed to this, as long as meta-selinux maintainers are
>>>> willing to maintain/contribute to distro-yocto sections."
>>>>
>>>> Are the maintainers and wider community open to this?
>>>
>>> Hi Clayton,
>>>
>>>
>>> Thanks for your work. I have no objection. I think it is a good thing for both upstream and meta-selinux.
>>>
>> Thank you, Yi!
>>
>> I will leave (at least) the first commit to the maintainers to allow for:
>> * a decision on the name (e.g. "yocto" or "openembedded")
>> * prioritization/timing of this effort
>> * use of historical knowledge and potential patch culling
>>
>> Clayton Casciato
> Hi, Yi
> 
> Is this still on your radar?
> 
> --
> Clayton Casciato

Thank you for taking on the maintainer role, Qi!

There is an open opportunity to upstream meta-selinux's RefPolicy patches [1].

[1] https://lists.yoctoproject.org/g/yocto-patches/topic/113634417
