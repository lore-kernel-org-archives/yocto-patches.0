Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C60BE7719A
	for <webhook@archiver.kernel.org>; Sat, 11 Jan 2025 15:41:57 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web10.17576.1736610113483389098
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 11 Jan 2025 07:41:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hC+eZZ9P;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6fc3e9e4aso261180285a.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 11 Jan 2025 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736610111; x=1737214911; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCnU58KMqfxbdIuskMaPKrTERzh5TA4JVqhzPQiOIbg=;
        b=hC+eZZ9Psh1pG+gRmVRAlVhaRSqslhTEyWfo++8+D56rFCYlj3sqP7mfr/NNIuemZJ
         yyoOnbgpb0U82aBaYGxP/hQWQGSzSIKR9o9JqXqis5OkIVpHylfyWNRIjfd9kTjXLhjY
         G4/M4liVUnss6GSVIqptHhGsmUYqhY5y+aJsvKrqvy+6bE4kHuzymVHS+kZGlf2rljkj
         r9NCyXpsCuE/fpAF9SMMQD1KDj8S7mKwiAA7wWAi6jJ3bQYM0cc7upXTwJm50rlVXQ9X
         4O9iZALRKxVZPA1Tj9E6ebtpN4koyZ9Ddpz4nK55nVsbwx5Vfg5bH6MSFnfyhwmcM7yv
         51Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736610111; x=1737214911;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCnU58KMqfxbdIuskMaPKrTERzh5TA4JVqhzPQiOIbg=;
        b=jFq+kQpssKsUa32mJXcMQ+HL9etfNiyHn0LCMXGv0Q4we/mrPAESUvik0RO9hqsP8Y
         uRagn/0r+TuZUdRYIR9iOLURg8B460JR/1abz3vFcnjB1Vnv98FxEV6Hn/ez6NGZlfMs
         BZruZpobs6Qu2NZDy7jrdec+EZPqZZm69sQz944s33BVT4yS71Kxko2j4eWqgPEECgxM
         XNGZmQLr+/EDjhAkJyKFFRRB9mJzFgcZEAnKzsCh9kJZ5ccatImXdZ9F2unAV8H1+MJz
         2xqY9b0hQlP3kL+YudBMx0fFQe21JLp+JM2RFcbANHFe0Bv4/d7XE0ObqMtX8zCTmPAK
         3wIQ==
X-Gm-Message-State: AOJu0YwE8liuMqN8agjQd8QCz+66Vfau+z5tJLB2mu0MJedldP94RNaw
	/hLD4MbQlzlCrEPUEs8Nx3E6VZsI8ThZ51To0ozVfMM5UZokteiPHYaWciL1
X-Gm-Gg: ASbGncvpbdHoalPyHV1ISdAQQXqyUzt72FYHcpXhJF/jOCd6MDEJn8OPyuOfNP9FadI
	j10fe2PKaFMN3AiJNrP0G1VJ0YVZFlbVQRgjXwI6IEeVa/bvMDVXc6U73Xj1lhgSN2Q5kWP4gvd
	ztFAWDpAS6yhwEthLjvkIUGSN3RFNKA4s0IalkLlUCvfvhszZuwCp8fZdZHMWmfBLmpO6eebmqp
	k5v19dwvKptQ5PR32C1dP91V6r2indzRSfWV20g68ZgbB7FF5OBOiIZsV16gKgAM0f0yszkLGQN
	Mg8+vSQw
X-Google-Smtp-Source: AGHT+IHQvY+H6e0TwgY/7tP3nDbcUqf0T1LgCOPahTUv6Rx3v1jM3O/Hbpa0DZTIxCNmmJG1D+PiDw==
X-Received: by 2002:a05:620a:40d2:b0:7b6:cb84:8135 with SMTP id af79cd13be357-7bcd9758b24mr2553311385a.48.1736610110880;
        Sat, 11 Jan 2025 07:41:50 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade885b0sm21085016d6.95.2025.01.11.07.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 07:41:49 -0800 (PST)
Date: Sat, 11 Jan 2025 10:41:47 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH] bsp: trusted-firmware-a:
 remove already merged patch
Message-ID: <20250111154147.GA28637@localhost>
References: <20241217-tf-a-2-12-v1-1-3c9073a3f773@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241217-tf-a-2-12-v1-1-3c9073a3f773@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 11 Jan 2025 15:41:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/980

On Tue 2024-12-17 @ 04:20:18 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> 2.12.0 already has this patch, see 52cdebbcc5d1 ("fix(rockchip): fix
> "unexpected token" error with clang"), so let's remove it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Prepare for 2.12.0 upgrade, when
> https://lore.kernel.org/yocto-meta-arm/20241217-tf-a-2-12-v1-1-cca762965260@cherry.de/
> is merged. meta-rockchip will then break building because it'll try to
> apply an already-applied patch.
> 
> ONLY TO BE APPLIED AFTER
> https://lore.kernel.org/yocto-meta-arm/20241217-tf-a-2-12-v1-1-cca762965260@cherry.de/
> IS MERGED!!!!
> ---
>  ...ros.S-Use-compatible-.asciz-asm-directive.patch | 31 ----------------------
>  .../trusted-firmware-a_%.bbappend                  |  1 -
>  2 files changed, 32 deletions(-)

Applied to meta-rockchip, master branch. Thanks!

