Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F1FE7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 20:30:04 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.web11.42477.1734294600743338407
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 12:30:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Df+vLNi1;
 spf=pass (domain: gmail.com, ip: 209.85.128.181, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6eff5f99de4so37748797b3.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 12:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734294600; x=1734899400; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5IYFlQd1kwhpW9vKA720HbWmvXnUXSpOfyf6PaNVv6U=;
        b=Df+vLNi1x3GdFzE2kzYs96dIhNM+lGvpnOjgOfVV7WD30fUYvB7gv9vWWb6/SmLi5C
         zLj+kpJOkPGUN16jXFRGIOuuyzQUcoxpjXbDtBOHAfkK2iE0EjB3Z91pDKkmGYOvnIgc
         LQ9nDLJUuvC38FRH5rGvY1VA3OvC0K7cg8Ulz7qaUyAAMHE+26OMis0dvIPmCha5cMCu
         K7Nog9tZLXZ3ptpJOqB6U+scbk9sCHi062qkuDE0vLCd/R9m7t4hm6bSfv/LDsEqTwci
         QjVUaMp79DF/WaPDDt2BuFbz0L+RrTmEk6t65TjXdJynNaYbmDpvBP2LpYuFiTHJ29Yp
         k+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734294600; x=1734899400;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IYFlQd1kwhpW9vKA720HbWmvXnUXSpOfyf6PaNVv6U=;
        b=RieNpJdzN6w5eu/+nHvEh40G/LruOOBEdWLEnLUN/5Nnq4hI10hr6gXjdBONHr7ifU
         mKn4lSLZmGAqXTtI7R/GkFMMqoShweNSWholcZ9wMXLsK1SulXnfgNnzUOzMs4L1KgCi
         pdf7OIE6IslpY8SM5ga3X4pTBCTAfGd1pIA369uQC2cdf/Azjoi8AGBRmxk0MEx0OcZ2
         Qvxro0eof08g4PKMSXHxFkRYcDhvY0ZTKYEFMkLo7I59AKJ0fNF3E/kxpWYl3OIJdKNi
         kJ40RyQwrAdLfwiOyREgrctpCtmkoAw3BIiZ61WHiCwoK6c8w8clN2/y5FX8s5NOGE6s
         IqRw==
X-Gm-Message-State: AOJu0YxacAo/fhKuoNEPgDTXlm1qwOoN3ih5lj8UO+dQINBBWuJHxd3p
	LkkoKSWTKN/blqKbHHFaIx07Z3lXfoXonr1Ep9eYTf7fe2qplv+N
X-Gm-Gg: ASbGncviqRQD3cF+jEkzlOiP1+KAPpk3RkDa1NSY96SMyZv22AQrQy/oFwldSO7u40d
	VG6fSTOyUBjfTl4DC0wgiiZe5zgLAtJ814T0Ujt7KBoRuhXqqb/NwcI2FMjjbpUtlTd0+MAmM93
	UfqsGGqXxLFYLC2clA1NmepnOyKS+enPfoOp0OzyqpSmujsVEQ3OLRmVeyWX75eICXhmyAtSmo9
	Y+dgtkgnm2eGmw5RDWOMpOLNb5WSkGoxAuBtJO6/474S0OogCLFNYpDTkf4Tk89arRkk6c23Van
	WPIIXTqj8fctvphTd5rEH4HDJH7sPg==
X-Google-Smtp-Source: AGHT+IFZYu2U/1qIMyXX94H4TCYJ4jERhL2+w7BXdlcYF75Prq4MCbjogYmOFWHWMaeoHPDYvSQzWQ==
X-Received: by 2002:a05:690c:8:b0:6ef:4a57:fc89 with SMTP id 00721157ae682-6f279b14117mr77516647b3.19.1734294600003;
        Sun, 15 Dec 2024 12:30:00 -0800 (PST)
Received: from ?IPV6:2600:1700:45dd:7000:a906:ba5:bc1d:da36? ([2600:1700:45dd:7000:a906:ba5:bc1d:da36])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f289033fd9sm10253407b3.66.2024.12.15.12.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 12:29:59 -0800 (PST)
Message-ID: <3d8f5af7-ec61-4de6-8479-f65e52a49e33@gmail.com>
Date: Sun, 15 Dec 2024 15:29:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH 2/2] drop: debug-tweaks
 from ci
To: Mikko Rapeli <mikko.rapeli@linaro.org>
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
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 20:30:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/919




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

I think the harden.conf will use:

EXTRA_IMAGE_FEATURES:remove = "allow-empty-password empty-root-password 
allow-root-login"

- armin

>       PACKAGE_CLASSES = "package_ipk"
>   
>       DISTRO_FEATURES:append = " security pam apparmor smack ima tpm tpm2"
>
>
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


