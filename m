Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67955CFD2F6
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 14:15:01 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8430.1764684894278692269
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Dec 2025 06:14:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g1fy80Y7;
 spf=pass (domain: gmail.com, ip: 209.85.160.42, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3ec5df386acso3430925fac.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Dec 2025 06:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764684893; x=1765289693; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMG0MFkYQCbDY5hrbUPxAcsJ21m5YOxJZ6RCpUwbGLE=;
        b=g1fy80Y7Q5gCOOGXILd/JBJb1+6rJ11ZZ6NC/qJLfSq+GYJPmbkZjBYWwRQFKRlfcA
         mVwVYgJq49HG8IdB9fr69Ilo3ePWUOpMwkpI2r7VQY+uYSGXrZ5i4BMshuE9o6ZMjven
         QZYEGkFpeubbXq8NThfRzM9dH2JjuibvVdAztCtx6lukuDLavDtVgy+/eBd4H7fzHOyP
         d5VJx00JLwa2twGxrdB7u8KwIbcWY1WUXbG43RxZ6kIfrhGK4EQZAF+cqqX0lpoMnbMB
         IJlUah/fDuMmzUURFOBSWAkaesgZPDmiqZdLRHLTrLPn6Rq6cg5qjPg3qeynNrlToLwl
         Y7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764684893; x=1765289693;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMG0MFkYQCbDY5hrbUPxAcsJ21m5YOxJZ6RCpUwbGLE=;
        b=mMhtOQnlbAWhwits7QHh6WrHFAsc1o0AnX2gPcbd41ZosfMHFAQ0PD6JPXr/5QbmUN
         eXBeZkmT4aGiYcJz6qEcRLsy3lNuDZV26tv7bNZZJZHa+ZhQ962w/UwZtNwl4yPQuzyN
         sMEuR1zRXSML/VJsuCSDsEqMhSsdzepUgHgKT069ku3jKgP9jjg8oge+y8SzUmVplbwL
         +lfVranRymVOE81ULiyMwdzmdpw+iXUtvZItv8458aMJOvrc7UIGWNiCx8qPp8YghGsC
         4f3rCyLRY2fU69Ug7CI23itHu12sx7D1uLyMizCmrHzA7blmRxum/zz6u7f3i2VocjlC
         suPA==
X-Forwarded-Encrypted: i=1; AJvYcCXvNxI7g3Du6/7amq5YcQ3unGKXR9hmsw3r31EnnIrET4g99/Vv4qrOEHJeUNhUlYNB3Z5Je7tBY1A8upQT@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyxRFrLt+WMNPnaL3D0I1+eZWZUdyrOujaHpWFIQuiW4Ny1tgSH
	R4CCZxOEtMrjA+2Au8nS1BRhWp5K3J+MQyNVb+25952a7NxCUgdlFYTL
X-Gm-Gg: ASbGnctabQjbL6ovvo6NPcwTse1faqk7nGpOQagbIwWgzxgu6OCo/zYABQgOcWb1b8I
	iEzqsETvyG4c/WFlvAXS1x6lKJU7khMu/cK5usQldZyLLL6xJZzd/WObfoRcnapdd6x+IaIGKAs
	HLZ5mhHhnrqR/EGilDbRzYs9dJ/QUf5SB5X+EkXWscEZmqhhWLpAC7ZHzwvPzETxRGjzJBNYVXF
	wh1lP1nvR9ZJbdPydTrcjdVsmqmAzX2WIh4NTBSa4Q0an4TWAV9Q+SuUX6w1wFmUmQvjqzwiQHQ
	apfP1VNkm0kJmdsECIdk6p2dOF0tCieRqV7yqOCeEAOHq5PQwUn3z/fjObt++9NlbUZ7DRqs7P9
	oERGn2tugaFAv0KWGKj2mK6eQHICIp+lfELaXa30ehMzYAfjUnYTm4HFGAGkkjsUVyXCyt6VvLm
	eM/wzdflqc9nB1BUSBn4GdhOmvYof2WTrS3S4Lsw1m70O50ZD0yKuZNM3NVB/tOg==
X-Google-Smtp-Source: AGHT+IG7kp5gbBE9Eem4Uh4NYOQXMpbfm38BbQY5E6Gs+hfLbVqFwy1dM6Gq4WK8XM/zm3OQJpAOGw==
X-Received: by 2002:a05:6870:ab8f:b0:3ec:a4ed:cf57 with SMTP id 586e51a60fabf-3ed1fddebf7mr14941982fac.15.1764684893438;
        Tue, 02 Dec 2025 06:14:53 -0800 (PST)
Received: from [172.26.252.3] (75-166-169-44.hlrn.qwest.net. [75.166.169.44])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dca3ad8asm7703645fac.6.2025.12.02.06.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 06:14:53 -0800 (PST)
Message-ID: <87d913cc-61eb-4527-a080-d77877ede9a3@gmail.com>
Date: Tue, 2 Dec 2025 07:14:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][RFC] refpolicy - add "Yocto" distro upstream
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
References: <9fa9f7cb-b82e-4d7e-83af-8027c39590ea@gmail.com>
 <7b3e26c9-b524-4b0f-ac88-5403e256c5d7@gmail.com>
 <24e6a59f-522c-4ef0-a5fd-29af4c160560@windriver.com>
 <7c117fe8-9698-4320-84b6-c53a321f454e@gmail.com>
Content-Language: en-US
In-Reply-To: <7c117fe8-9698-4320-84b6-c53a321f454e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Dec 2025 14:15:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2732

>>
>> On 7/23/25 10:42, Clayton Casciato wrote:
>>> >From the upstream maintainer, Chris PeBenito:
>>> "I'm not opposed to this, as long as meta-selinux maintainers are
>>> willing to maintain/contribute to distro-yocto sections."
>>>
>>> Are the maintainers and wider community open to this?
>>
>> Hi Clayton,
>>
>>
>> Thanks for your work. I have no objection. I think it is a good thing for both upstream and meta-selinux.
>>
> Thank you, Yi!
> 
> I will leave (at least) the first commit to the maintainers to allow for:
> * a decision on the name (e.g. "yocto" or "openembedded")
> * prioritization/timing of this effort
> * use of historical knowledge and potential patch culling
> 
> Clayton Casciato
Hi, Yi

Is this still on your radar?

--
Clayton Casciato

