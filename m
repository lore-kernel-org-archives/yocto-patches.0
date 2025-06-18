Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512AAC7115A
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 15:36:44 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web11.1980.1750261000631306062
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Jun 2025 08:36:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=eU7QQv8E;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a6f0bcdf45so86133411cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1750260999; x=1750865799; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3m6J1PtN3kBuefZ9UthgDaLdR2vL7GJ/h9tzG3UW8iY=;
        b=eU7QQv8EIZxde+906PAt/QGSD5t7CyD8cQ/3n/mxi9eF2p/Bq1T7yZxs74mu6tOkx4
         lY116pY5B3nDsxwyYiTAF+5xRlsG5l/pSSDtRSQDtZOCxLe2x4NPpzIDksvV8yAKETJX
         VmbrMWdVK0dOtQNbweLZw6mj4qC+pfoS1GjR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750260999; x=1750865799;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3m6J1PtN3kBuefZ9UthgDaLdR2vL7GJ/h9tzG3UW8iY=;
        b=D3TfXNvWdhZjUvlNWsi67SlA8NxtNuWg/t8RgCcyyI8bwT2BRWjspMTLEpukQ7e7fY
         MEqgZSyG2AfXJkqiCsBFVyiyaByNNsTiFShhk6jcXuY2MyRGia4N7GPv+iU0JYgBWjlG
         ksao63NrNePStFxyh/OKkEza1fw6UKFJmIjAPzZ+es1q1m0NQSJqVgm/eLeug0vOg1Ay
         Q3sdEpC252foR8u//anWLWrSF/Ry68yatOKH+Vl+JN8Zy7NlA++HkgkbeLKGG1GBX/Pz
         f1GGX1ulfe8Ix1BbC50q2vrgLz/WsTlQQpb6SEL64iVXAX+pgJObYKX5GansTv9D7fiR
         foIg==
X-Gm-Message-State: AOJu0Yz0yxu3ZNqRDBWwmW7yPpPXcDedBlt7rDzPwQKSYBG7WevgZHNt
	kc3EdRtsWeo/4XsSzBe34mQhn5lHmmMz7OR2YcKFdnLMw/LSFZLPTrDmWRSbkzg2H9L8cUNu8M2
	Le4Nk
X-Gm-Gg: ASbGnct/2j6vhMacn+uvgvM8oMS0Ql8WLHyCRWauRtqxsMrqJkmndSdCI9A/2PTueRz
	wp1K6FIhAs/XZv0KkniDJqke+/iwXu5RUmXbSmwDooepCYkAxA+2ZqLjsDNj9MEPuqYZhKp+Wzf
	j+kXnP2faob+/n85CfOKSQngqTVbT/vWMULjHHHrY8gsKCzOEjkMU1IdUqlYcUU/5AEHYCcYLta
	Ulbv1jMyavKf2b4rDnmzfbQ04Wqd69Htgx15D/w9e/AQAxVIFEVLLeaFseUisGPHPbo03dRyQuJ
	UWEiGxzctw0JVsPcMArpqqFa4V9SKNmRL1IjJcZcVuarqAGh3FjY+Ca6e60RHtugELSAnmDHrc4
	Hi0LS47bNieE9MqfM3Thn
X-Google-Smtp-Source: AGHT+IG8aL/VJ19R/6arkBabj+jmYel611A4QC3dY/Zmnw8RsYxsftCao7uO9yZtrfE2z6/D0zmMAQ==
X-Received: by 2002:a05:6214:1249:b0:6fa:c617:23f0 with SMTP id 6a1803df08f44-6fb477d99abmr305863046d6.27.1750260999169;
        Wed, 18 Jun 2025 08:36:39 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dc8223sm782482885a.7.2025.06.18.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:36:38 -0700 (PDT)
Date: Wed, 18 Jun 2025 11:36:37 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: soumya.sambu@windriver.com
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/2]
 python3-awscrt: fix unsafe include path error during cross-compilation
In-Reply-To: <20250618132937.4119240-1-soumya.sambu@windriver.com>
Message-ID: <52f8d600-3328-5ce3-c577-ec9ca4c84ef8@konsulko.com>
References: <20250618132937.4119240-1-soumya.sambu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 15:36:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1662

On Wed, 18 Jun 2025, Soumya via lists.yoctoproject.org wrote:

> From: Soumya Sambu <soumya.sambu@windriver.com>
>
> After meta-lts-mixins introduced a newer setuptools, python3-awscrt is failing
> to build due to unsafe include path
>
> cc1: error: include location "/usr/include/python3.10" is unsafe for cross-compilation [-Werror=poison-system-directories]
>
> The issue is resolved by explicitly forcing setuptools to use distutils

Can you elaborate a bit further, I can see that forcing the non-vendored
distutils (i.e. OE's copy) would have an effect, but if the default
setuptools behavior is broken with respect to leaking that include path,
I'd kind of expect wider spread breakage.  As well, things seem to be
working on scarthgap with python3-grpcio, and that's where the setuptools
backport is from...

Thanks,

Scott

