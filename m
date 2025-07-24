Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E794BC87FC5
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 18:13:58 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.746.1753380832258995899
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 11:13:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lYOj/FHT;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fac7147cb8so17192926d6.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753380831; x=1753985631; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YelPEhf7Fqg91E0inzXxXjtDJhD6ofz224ieNXHuQ3Q=;
        b=lYOj/FHT4+QMeJ0MJMIkCG+OTn2cmmzWwUzkirojgzkCPcZ6YvEQNTvIb1TGxvgQlD
         GoC4eycxEIQ+s5oYk9TCi4w6h5SnY7E3jrmzagaYRp2fR8zLRWCFu3lftMj0NHaUWIC3
         Y5vwwPRY9uYFsD4R2qrqp3MxijVC0HOOm6qLOILoRqq/UFpsyXbrlJg+Jf0RStxiorS+
         608AJRHPPogwnw2p0IXlCBtavw3QWY+/PuccrRQqB8X0us6bPlsVuE44Y4ck6z9+adWh
         qPs3c6eXl3Gs3P2ZUi7Z2fggC29dmtxSNGzz94CCfCgVUFGzaKGWL6W3mut1siVXU5D/
         1X/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753380831; x=1753985631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YelPEhf7Fqg91E0inzXxXjtDJhD6ofz224ieNXHuQ3Q=;
        b=IC/CihsGpR/SwkrfQsBN4QapIBtIoAOJEYHxjP6kpoF/y2t0ukJVJSz+GIlJAs/+BO
         gR6iVLsYikAnJ6joAyscILzZQE4SCiCDgpONqa3uMy35+SGwbxJ+q/mHad13xBkz3oPF
         +vFNv9OrUGpgn1kqEL7KOQupoFs6p6k2zS3e1qRjnANj5/6/Yz0sW6RaFtlduq8qZ36R
         xuXeZQXX+Ncl0zqqVRFq062Ws8jngRkwGwa5LFH1YQ88Gk28Zt6WbDcWaOgK6EsZ3qf+
         xmtg8EFy7KOE1s9JjOZYDPDpUA+TnNOBhXdM07BcW3bB0LytPCX04LNqUlbdk+c2XNuj
         VfPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUtxr1pGraPdvQj4SsHC0JfpeKXFfFC/eX5YfJuNTOL/I6Fhh7PP58004nwaLLLAiSo2+wFkcQuL1sc6pH@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yzhp7FDhbRNG4Apyt5etSi2BxLw8jRrk+qtc9TDMSJzYN4VqLXx
	iDZzJLaDxEr6RgHXuX2Vii9LlZTFQY72Zaqa+n3rEPdqFfiXkA7FDldM
X-Gm-Gg: ASbGncuvsGiGqGwbmTLMf++a03GcqjWxeqvhCceLRr2IVr2m9pHqt3Bz2xuzBf2NlhF
	MzSXLRnzJOd/poXUfHO7Ex11ppZR9BZqBsf4SCteQ0odzFrBc5MUW6Z/ZEN+RlHNo5kbtLpSh7F
	fplAi4fsN+FLavc1Tn1dq8idPkyC+fV6TcMpnQTL5sifuELVyKP7Z/P2sHIZ0uggA1JGoDutmvp
	L058k+OI0h0WC/3O3K4nNW5HJWRMWdHQKiD50fJUCxIlWoG7yPOaq2pOClQcRbYTJPXeacCTWLJ
	4w8oyOut2w4m1eJOTDjoEeu6aqfilQTJ7ZE2S8dndAqmCzUD5LMSc5fnMk7qUvaQXhRdlspHpb1
	BgYMt8drkv+busYosp0/LW8DKSmM+VywqTXLXOtKt/V9Y+x9Kt372DHqcy/cUrvvEa1s=
X-Google-Smtp-Source: AGHT+IHPe6/DLkJJhsNW3GO2CUxNn6TOj0MYvz6dhg7RXk2gl8YgKgpOHqY8vO54jiGX7vOVsTUxYw==
X-Received: by 2002:a05:6214:300f:b0:704:7fd7:c06b with SMTP id 6a1803df08f44-7070032872dmr111153866d6.0.1753380831325;
        Thu, 24 Jul 2025 11:13:51 -0700 (PDT)
Received: from [172.26.252.3] (70-59-40-14.hlrn.qwest.net. [70.59.40.14])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7071a3ab443sm3746816d6.10.2025.07.24.11.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 11:13:51 -0700 (PDT)
Message-ID: <7c117fe8-9698-4320-84b6-c53a321f454e@gmail.com>
Date: Thu, 24 Jul 2025 12:13:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][RFC] refpolicy - add "Yocto" distro upstream
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
References: <9fa9f7cb-b82e-4d7e-83af-8027c39590ea@gmail.com>
 <7b3e26c9-b524-4b0f-ac88-5403e256c5d7@gmail.com>
 <24e6a59f-522c-4ef0-a5fd-29af4c160560@windriver.com>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
In-Reply-To: <24e6a59f-522c-4ef0-a5fd-29af4c160560@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 18:13:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1870

> 
> On 7/23/25 10:42, Clayton Casciato wrote:
>> >From the upstream maintainer, Chris PeBenito:
>> "I'm not opposed to this, as long as meta-selinux maintainers are
>> willing to maintain/contribute to distro-yocto sections."
>>
>> Are the maintainers and wider community open to this?
> 
> Hi Clayton,
> 
> 
> Thanks for your work. I have no objection. I think it is a good thing for both upstream and meta-selinux.
> 
Thank you, Yi!

I will leave (at least) the first commit to the maintainers to allow for:
* a decision on the name (e.g. "yocto" or "openembedded")
* prioritization/timing of this effort
* use of historical knowledge and potential patch culling

Clayton Casciato

