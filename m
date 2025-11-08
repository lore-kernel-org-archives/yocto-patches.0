Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35B5CCFA13
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:22:50 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13208.1762633367215784149
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:22:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VbCgOcsS;
 spf=pass (domain: gmail.com, ip: 209.85.166.50, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-948614ceac0so121185739f.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762633366; x=1763238166; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YAr1dDBuoRzH8y/SN2dVyhqakzisNbgNG3/uf8/x00=;
        b=VbCgOcsScjCsvhU2mog3JabK0g8VguNceQv1J99/iYcMES7uiHvRd83MHGl5257jEo
         1N5bMBO3cOkQB8vbDaOL2GsNSUq0rf+qpuvQpigIuK7otyO7yVjJ1uJuz40bdXaCAlJM
         kr4uw2MDujKqf1jvEFOStI0TlaYnI2dyQV5T4DcS7VNspWVKUsQE+PbElgLtugANS1I8
         JFjT9u9evslVfM8mWPPg3eedxfk3XokaK0InZtngN5SVsNltFMVRf1bhEb0azGZobNr8
         HtovYHYwXd5tsKAZQfvV2pM3klbuYszkuKZI244so/Wk4fdWrjueLfZG9SLDvYpY/Lxm
         ZuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633366; x=1763238166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YAr1dDBuoRzH8y/SN2dVyhqakzisNbgNG3/uf8/x00=;
        b=r8LYr3VqelKXlRVjRQPDWl8+DokZopp7tfjnsPQYQS339lbEzI5wJcDKqyexzoH80g
         jet3+y0cdl8ZZczIf2fb9y4W0KK6iow1tRxLIvqC4EM0RlJPPX/qPDqvIcSUy7tpOb/V
         L7uNxFEkjN6yOfaDGiDmpfDqbFSdPt1ZGg9MkF4klS+GQrWoTDVNV4Q6R3amL2EuCH50
         Tz/3MqryNq8e/SjyQWM8IPYcUmn4neHDfG3rZVO9uaYWye0MfiQs0vglhIFmXjga9nwg
         MvE6s8PUbqYOdHuXcAlBUoLG43JAAoLqPD0nRGJt++HVToIkKZN1TRyByCA7HX9daAPd
         TN3Q==
X-Gm-Message-State: AOJu0Yx+wVT2ZFCxaH2NDluMEtN+1zFXV+8OlYuzk2gw7SfBPJVZdsZb
	iEKEh4Uqyd7e9DmJ7oVsaOyhNAQP9eqRa3qwnMg90UGRCQcR6VDQWE+N
X-Gm-Gg: ASbGncvFAe5QcArLIxVs66cOK7uJTCqpznLRhUG9sUt+YZCmSyTsHTPtyjKEoQLFWei
	BOf2AVb89jjzaTF1slv421lGIkUfc++Jt1KZlEJpJ5iBWzYsi0rv9YdUU+CeZrU3bl8lQK+6/3R
	uF05mjGrerrHgzvGTrYh7qmR3S6ZU8JQqBUVBo1EyxfQGmBY63sNNLun4BKtAaj71v7gHf98yW6
	TRZ6BjEOFEr07jM+ZYMy6T1tbipXc2r1727imqWI8TXi+FpH3SrFG6S+we52y1OFnG1bmZvc3bj
	iLQfvR3y8MF2XcMvF/BvfiIHYyX0o4zLyPlEIiFaNPp9R4Ui8NGUSt2OK3svd/Rva43Q8EZnHpO
	FrWaJabYQe6wHw5ZhfkOaS1dtq+L13n5ZIb3VyCTt9usT1th1qLLuP1euDzcmnilJrAqBFLXp35
	OTwm9IRFPmbz/XM4PhR05JmTagmytCCuc4bEKTnXagFi51kzVxAEkY5w==
X-Google-Smtp-Source: AGHT+IEgshgHiKvImR7ReznxfJrLzTpcG8e1eXeQA3H3XLGVT/5WENHDWBfYMFU5tHZVigks3erwbA==
X-Received: by 2002:a05:6602:6d03:b0:945:ccad:90b1 with SMTP id ca18e2360f4ac-94895fd1ad5mr518102639f.7.1762633366395;
        Sat, 08 Nov 2025 12:22:46 -0800 (PST)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7468374adsm3217817173.28.2025.11.08.12.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 12:22:45 -0800 (PST)
Message-ID: <b8cdcf84-5fb5-4c1e-b24e-ce784b3e98ca@gmail.com>
Date: Sat, 8 Nov 2025 13:22:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-security][PATCH] suricata: update to 7.0.12
To: Scott Murray <scott.murray@konsulko.com>
Cc: yocto-patches@lists.yoctoproject.org, rybczynska@gmail.com,
 sdoshi@mvista.com
References: <10994238-57a3-4100-ae0e-85ce34e93f25@gmail.com>
 <5ab11d33-891e-e56a-2572-445f68e79fa2@konsulko.com>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
In-Reply-To: <5ab11d33-891e-e56a-2572-445f68e79fa2@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:22:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2460

>> Update libhtp to required version 0.5.52
>>
>> https://suricata.io/2024/02/08/suricata-7-0-3-and-6-0-16-released/
>> CVE-2024-23835
>> CVE-2024-23836
>> CVE-2024-24568
> 
> How attached are you to listing all the CVEs in the commit message?
> I'm definitely going to prune the test information (perhaps put that
> in a cover letter next time), but I'm tempted to omit the CVEs as
> well to shorten the commit message, since they are listed in the
> release note links.
> 
> Thanks,
> 
> Scott
Hi, Scott

Please modify the CVEs and test information as appropriate.

I will keep this in mind for the future.

Thank you!

--
Clayton Casciato

