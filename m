Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328EDC3ABC9
	for <webhook@archiver.kernel.org>; Sat, 10 May 2025 15:53:59 +0000 (UTC)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
 by mx.groups.io with SMTP id smtpd.web10.13297.1746892429793946293
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 10 May 2025 08:53:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WkZysjMF;
 spf=pass (domain: gmail.com, ip: 209.85.166.173, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3da74959554so9140915ab.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 10 May 2025 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746892429; x=1747497229; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gpDHuapInU5Ub4WROPIdxhZns0LPtBrnB4G8bapz6zg=;
        b=WkZysjMF9S2xdVuW882pL4vcDQNPA6mYnEz1Cq0vw7p7vZK47OSOVTh34GUly54epy
         qrm0YizZsUcyprBmje3gpbi215XX8V/q72+BwaV2qHf7vl6NuCee3spbOdyX4eQ8Ox83
         znEtQ4ZkZMhC4UnM4lZJLUW3Z6ion4npOM/CkzmSqdT0CTpO+LcyIN5mom55Wn4xL+BP
         iClpfnwPimeMEZ5ha8WxaBQMYgq0l1mAQ+FlhNkRGEccTaVfm80Twaso0jtVCEj5ha7/
         4NrYo/lp/iI4JAYOYXIPI+/IgGxZQZ+BU021lfthSM7BaZUlBY4XzarukjPN8G+RIrO8
         gWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746892429; x=1747497229;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpDHuapInU5Ub4WROPIdxhZns0LPtBrnB4G8bapz6zg=;
        b=eFoMPjXhv6QaWcpXoWRIcy+Oe1ihP3Qv9zuuIsOtwcPEJFNNMDGi8iemEEjddnrQhO
         rJe1fSgF1/dF119ufwVFgKNhFPhKKE32ifoQZa3bg6zlsNyZmRzkN+9OGuQkAxxdSZbK
         lvcldkkUEoPb4NsSjocCl72SWoyhFrs//nuJmDJvtB96tVSctd5Co8KurV2WBLqF2vrS
         HC7Ety7EK16Bro0GOv5KDUWLjkiKZdd8ZG9ngaXBj5mTcyEEmz9UvTqFm8ES1716cm25
         T6rVhs9yzWWKAN6LlNLIUk96gtnZqLSPeHIg0QOt17gp9HsqPgM//qy2QSaTSHWBImxw
         NA8w==
X-Gm-Message-State: AOJu0YyFrw65U8OcQyFOVRlHugPRkO4AkklPRh9A/TNvH0CiPIpX/oXi
	zeIW7U13Qg51siSXjqM62sXX13QLjkqIDSHWRK8Nug6fDNYPNXcZZqA6dA==
X-Gm-Gg: ASbGnctti75jswQVbDG4ow9qXe9BLFvvykYH0fVVlN4D1MFZf16FL8mr2ew/HYD/43g
	+74uW6VkfnweYVhbMwYOHek58eJQBoFu1FMeXOyvSQ5fWP1zXq9POktO2aiohSPr9n+RILbvB3S
	LutYyOCFAksQold4sgiTfFnAW9C4BhApTtHHZSyzIhnkiV4m4Dz+tzUTUpxAbKFKkkJ2pWG1nFo
	jI8wDmsOa5atlYsAHjQsiclOcNn1BNGLt9WwyXOr0Zec5IDBQ+DU+KRhYu100QPhRl7piC1E1M9
	E4uqovhqa0AJXQyXB1ICyyvRLS1AnmZo4SIPhJ6XzxxjQkWvlutNPAshcEPWFFM4w+hMApMKNzj
	5j+c0AesW1v7+/a5DLlSrcMFArj31
X-Google-Smtp-Source: AGHT+IGLz6DXLTqZFp9Fq30HpYWKR0QOI1bf37P3S2viRgM8y5D32uCRvVu58eziTaTTYftvSApsqA==
X-Received: by 2002:a05:6e02:1a68:b0:3d0:2fcb:e7f with SMTP id e9e14a558f8ab-3da7e163832mr97772005ab.0.1746892428947;
        Sat, 10 May 2025 08:53:48 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa22525266sm823985173.65.2025.05.10.08.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 08:53:48 -0700 (PDT)
Message-ID: <17faa9aa-cb15-4241-84d5-6b990fa90488@gmail.com>
Date: Sat, 10 May 2025 09:53:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-security][PATCH] smack: Use new CVE_STATUS variable
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
To: yocto-patches@lists.yoctoproject.org, akuster808@gmail.com
Cc: sekine.shigeki@fujitsu.com
References: <b61a1919-a65d-4674-8604-69ebf661cc8a@gmail.com>
 <8b387520-36f6-4215-9dd0-ad7e4481da3c@gmail.com>
Content-Language: en-US
In-Reply-To: <8b387520-36f6-4215-9dd0-ad7e4481da3c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 10 May 2025 15:53:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1542

Hello!

Was there any feedback?

--
Clayton Casciato

