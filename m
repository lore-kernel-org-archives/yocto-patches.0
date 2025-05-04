Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6241C369DC
	for <webhook@archiver.kernel.org>; Sun,  4 May 2025 13:02:48 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web10.28114.1746363759411049138
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 04 May 2025 06:02:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aYfcBit8;
 spf=pass (domain: gmail.com, ip: 209.85.218.52, mailfrom: skandigraun@gmail.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac339f53df9so748059466b.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 04 May 2025 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746363758; x=1746968558; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xk8a7katg074E6GFOgVW7gs7smX7ft6GOR1AlF1+aLI=;
        b=aYfcBit8bsw3r1lobvgLKBHX6DDUijUtvfnpJ22rhug7NIVAbVovoIUTtHRYRZwlJW
         WzLKU60ZnrCwa9DyIGxSfdzjrvsh54vPFXhbbuBb1pjFwLyHjx+CNQn09XW/+9Gom2Jk
         KqRPktW0PsoBZ0zIxQDSNea+D5dYxikqRihH64tdzkeMMA8TBfOpLYESZ+4Sn9Yypd0n
         f6UcVrSTr3vJyHJeLw2WWyQBYxu1Gy6q/pqvQbJ93mzCRyd+jF2H8duGjkSIQkJjZOKn
         /AFAdsFdf5iX0KgVgkkru/yE/1cofMQ8LVop5g+OhC+3mWgt7nojV/7uvY8zVCs6QVB9
         y+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746363758; x=1746968558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xk8a7katg074E6GFOgVW7gs7smX7ft6GOR1AlF1+aLI=;
        b=quGbTbkOJZwtjq/NYB8yMJS397GXYohiBiiA66ecK45bwJzQHTf6BIMW24Uq50Up1K
         K1S4pVfV73jnfLSEW3ZZk3YTrzuy08MZ66YJbcAlG7iiJKJrR+vVwPF+fOvm0iUrb+yB
         w9+Wocvv2DS73iWPNdsjKLMJ3cw11+6EoIGvn5k9+smsjfaHgJBQlU0fqkEue392RtcW
         M/C+4hcw2+TFHqUYlvtuXlXawiNNQX0fAqLXGCwUBlEhmnH3m+8QGz506/Lfn184/03O
         RO0+X5egixrWpTSv852NkwxIAnsYQ5ascvuPvH9YdX5oZ2TvAE+lmF1jlABY5e9E9QA/
         ityQ==
X-Gm-Message-State: AOJu0Yw/vN/Uz/yF8jDx4T5AWJq8oSozfGkecAmyb4//z8y+2Qd37VK8
	j+X0TN5nLKG95EJfc8uiJxeNOXJnvQe4A4P7ixTLEQJlkNrrYQ6TYW6FQw==
X-Gm-Gg: ASbGnctiiUmR+GwTfblSBE0EUbPSaSQEAnJc2o4Vaourgj31EQ/pwbb2jmoQ1y0n7m/
	2H9PImBRyJgcVC/hdPtA+RHhh8S6Zm/CjTRihaFVv+bGMmK/z42sByQc6xTkAlx0Z+XNuIzYF4W
	e42unIBBjYfDFSJKyL+arc1oFdcA/orgyUZvnsw2KUjUDvwJBopQCwmM1NAXp8sZpxyQLTwzYvg
	IAnyyOvAh6EEQgONQ0wWp2iNEfPdlhyueNXZgw83j/25ToGvWWyx0LS9gc7yjo9Z+HO1OpC+uEi
	IeWkYmDpexB4fHhsHnXIkXyoC1pKJ2AVAmkHcq/mnj4wGxF0
X-Google-Smtp-Source: AGHT+IFoxaAnPUHK10uHemS9icjy2156VQOvNwUVICciscKGDyBJNG+p8tBzv3d7JpcOdLCKSxje7Q==
X-Received: by 2002:a17:907:d1c:b0:acb:b267:436b with SMTP id a640c23a62f3a-ad1a496cf52mr339258366b.25.1746363757600;
        Sun, 04 May 2025 06:02:37 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a3cf1sm330474866b.68.2025.05.04.06.02.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 06:02:37 -0700 (PDT)
Message-ID: <c0f7f65f-de10-477a-b5b3-4c820711e6a8@gmail.com>
Date: Sun, 4 May 2025 15:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH v4] ftw, nftw, ftw64, nftw64: add
 tests
To: yocto-patches@lists.yoctoproject.org
References: <183C546FDCCF2C10.22941@lists.yoctoproject.org>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <183C546FDCCF2C10.22941@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 04 May 2025 13:02:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1486

I have executed this on ext4 and btrfs @ EndeavourOS successfully - but
please let me know if it still crashes and burns for you in some novel way.

