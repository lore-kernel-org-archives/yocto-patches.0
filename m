Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4472BC25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 20:39:27 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web11.7089.1716842359648424906
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 13:39:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=zOg3bAxk;
 spf=pass (domain: baylibre.com, ip: 209.85.219.46, mailfrom: tgamblin@baylibre.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ad7a2f8715so1550146d6.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716842359; x=1717447159; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V04DYseIzbYVWwB7MPBm3VTUQUBuEZtixLjCqkFFmT4=;
        b=zOg3bAxkfpyuZeK2jqEzuWQYwSOkEFP+Kfx4x9/oQaYDTjDCYhEGtBDSXKDT6Xs35K
         Xg+ek4SGAPNeiy5AMPo/+cA2wbRTzI1zQqe7KGmeKWNzSSnZgmLK2uyrNWfuXvrIJmAL
         h8zLgHOp0iVABaxOKLoH3l5JBj/AjByXHniQEK3YZ8Eyf0EJM1iysYJtx3iksUPCpMFS
         JmvNLZKJwBgutaBtDIQ6Aum63AVC3DGL0GM4CAKA3vwNRmLD4xv2Jxj8f4CQzlMcih3E
         OKn5/mMtOnvwLN1bky0bg/CURCKPJSUpsIs8+F+B1M0NfpdAdVaP3zFPMAl4yrLb+Q1p
         pX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716842359; x=1717447159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V04DYseIzbYVWwB7MPBm3VTUQUBuEZtixLjCqkFFmT4=;
        b=XAqaR4C3BQxrqgNIVs+oYXDOKPgH1ZX0RX5d18hDu093q/wYKFRl9B8cm5Exh8Eryd
         VuKl5NwujUrsk7NTuDKaQknyS+pBsCb1deihml8cGSEfIoWnKGupR6uCf+xyyER3FYzV
         p/BdtNoz46kjO3Ih/rRfRnxo8tYn+HV3cYZNGITRYO7mWCo6kjZSL1AHMsEKu+1RyudU
         m4ksGDTW8t6DTxSTWh9BpYw/FYkI94uhijIBMCwlNzwqfykjUUb7EinTsGfi4MyTmpQy
         JFQP8Y9mJpS7xEDAzwwj2OK5uwKWtAJ38DUGiCcctXfsuO0/FFy3MT/WPIFL9FNolBQt
         hrxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU15X3pbrar3IeFOUCMtKmbub9WEq2S4MbIEFx3OnMQ0zSetjEQvHvn5LvyB5Jaos3NM9IvkdqYQf8xTafkRX6rH6Q4pRk2bEBPM7R3Lp3EDe/DvyE=
X-Gm-Message-State: AOJu0YwZ3SBWMs+r8xOgvYBE626JLOF/IPafxxZ6S4cP4OWMfc26UlIn
	BEI/vPylQs6lqNM/MXKhKOzLlwgyt/pAKlEErFQRZbJV+g9++25pm6aVaGw0TZ8=
X-Google-Smtp-Source: AGHT+IG6SvMG78FzJc16kDhKnXsCCRQb/CI8lhTDT71BS2pwORBGPw59d4vBPKBxr95E5c1e128+Xg==
X-Received: by 2002:a05:6214:44a1:b0:6ad:7055:afea with SMTP id 6a1803df08f44-6ad7055b2fbmr109564406d6.28.1716842358089;
        Mon, 27 May 2024 13:39:18 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad79ef0835sm17482876d6.104.2024.05.27.13.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 13:39:17 -0700 (PDT)
Message-ID: <c60ac769-d665-4887-ac53-ff9343b10db3@baylibre.com>
Date: Mon, 27 May 2024 16:39:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [auto-upgrade-helper][PATCH] upgrade-helper: fix
 testimage check
To: Alexander Kanavin <alex.kanavin@gmail.com>,
 yocto-patches@lists.yoctoproject.org
References: <20240527203230.1258788-1-tgamblin@baylibre.com>
 <CANNYZj9prGjk=eCwMxnCV41BSWLOFCdjnzAX=0vW8TQ2OGgamA@mail.gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <CANNYZj9prGjk=eCwMxnCV41BSWLOFCdjnzAX=0vW8TQ2OGgamA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 20:39:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/220


On 2024-05-27 4:36 p.m., Alexander Kanavin wrote:
> On Mon, 27 May 2024 at 22:32, Trevor Gamblin via
> lists.yoctoproject.org <tgamblin=baylibre.com@lists.yoctoproject.org>
> wrote:
>> From: Trevor Gamblin <tgamblin@baylibre.com>
> Yay! What did you do? We need to update the yocto docs with a
> bulletproof configuration for git.

I used the --from option with git send-email, but following these 
instructions also seems to work:

https://docs.yoctoproject.org/contributor-guide/submit-changes.html#fixing-your-from-identity

My problem was that I had both my username *and* email address in my 
sendemail.from variable in .gitconfig.

In case anyone else is reading this chain, there was also this thread: 
https://lists.yoctoproject.org/g/docs/topic/105864996

>
> Alex

