Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCD4CD6E52
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 13:07:19 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23341.1763039234430146167
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 05:07:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Hd6R0mmu;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: skandigraun@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47778704516so4003585e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 05:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763039233; x=1763644033; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=re0PdZk5mRzUUW/d6BaxsYF3nElSdn2zAIG9B4kgxXs=;
        b=Hd6R0mmuKbDEu9ReNP/gJ5eB482ls9c8T0dWfpsbDOS8GSxDOx4q+VHo6or60AqF4Y
         FJ9ptH3Z3u/uNRzXXAiytjwYA1hbcG9iRCsPBKCQa54OBVKHlNqD5Ld6OhXiaTxwi6YP
         M3gSGfBjn6jxtb4tFogghlqctKqGixRFxT33QU11w3+ogvAKWlUcTQN98n6FQZpK7kma
         +6yv5U9hgjC3WM4Ovr5fSGGQVHeQunAv6/erW6JhnIDX8Qu6Psp474q6p+ZbNbrVKik9
         po/LKo4e4FJyqV31cx1YjRfgQgePSQC5gA65yLw40rxdi2QMLE+B6N3tIlMhcyGVBfhV
         WNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763039233; x=1763644033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=re0PdZk5mRzUUW/d6BaxsYF3nElSdn2zAIG9B4kgxXs=;
        b=W+Au/bJM/vgNlnnB7UlIllXX72RGVrWVJ38vN6PwKg+aggxGZrkF3PtKNi7HgiSiR/
         NH+AKgWlWPnXZKYWTgyrcHa6K88pWrrcTL7TsRsZI8ddn/7M7X12uQTigwgtUdLmNO15
         /q+HgeO6CM48DllUuTzoC+2Uoz/9UNvB2lWNdim1x/UZyjnpyNGy1p9lt9uCInHPr2xH
         701tkS+yWvpsVoVeRcpAdB3pB97aM7D+JjIZEoyWy5xw3LOw4uZzGCUrnFVM+5KFuu12
         zy0kGDMpFyom6PeM3uXT0+XItU9dvpEYI/ztL+vRpwyKhJvEePt/awPcLnlfcJ/Pnvri
         5BzQ==
X-Gm-Message-State: AOJu0Yxx9xhenZ43L2AB0jbneQe8I4lppY7xLR2om21FSKEA+V8KKxFy
	K8wassdhVKf/KI8TrU/9/9GD+93fQQQ78p4Yg9Tzi06EyjXfyyxHmeU/5fvhRDbX
X-Gm-Gg: ASbGncsfeznkCIhl6+9+tFa2hJvvswH1tbPpcjJz6BJL37SCpFcax/9xWkvSsllaRYZ
	Ow/1ktQHJ+SQ/6626uVPagdrhzJLDBI+WwSZfCQGcyskhatXJrzJFKcIwuyimJlKhd66xXiOQDX
	XON+l1Lw1MywpNP3+P3GWWX44X5iGyvZpwUZK4K3l58G9sRFDE0AM3As6vNPL27qo06cJZH2qz0
	5f+MFFGQPnJNzK+zYt3zxw53H2gP/3l+5+pdGKEJyVgMcoRoafoOwq78bYPO1qIfrKU/ZJJUMJS
	rP2KuHwMFvGZ/F3/WWdRV+gfKJ0Dvx2xCk2Rx5mG5cMszEFer9rJU4LRPTokLUGrOeoltwSYgA5
	SkyNGceAYW/fnFA34TuNi3VKK+G4Fny0DI6Oe63tsm1oYlMObgpX/o0yVxB/zGKecB1GRIJ5KKd
	mrCnoqCQlU
X-Google-Smtp-Source: AGHT+IHBXeBTl8jsPqSCgJLouReRQn2W4OH/GMip+Z0DhvJoZyiRpCWSDKEuNHsbHMGuJpCwaufEbw==
X-Received: by 2002:a05:600c:354d:b0:475:daba:d03c with SMTP id 5b1f17b1804b1-4778704cc36mr57795355e9.13.1763039232630;
        Thu, 13 Nov 2025 05:07:12 -0800 (PST)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm3802110f8f.10.2025.11.13.05.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:07:12 -0800 (PST)
Message-ID: <15ecd02f-cd2a-41de-9cf8-53ef1ca2da5e@gmail.com>
Date: Thu, 13 Nov 2025 14:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/go][RFC PATCH 33/34]
 readme: update to markdown format
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com, jose.quaresma@foundries.io
References: <20251113125712.18914-1-peter.marko@siemens.com>
 <20251113125712.18914-34-peter.marko@siemens.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20251113125712.18914-34-peter.marko@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 13:07:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2540

On 11/13/25 13:57, Peter Marko via lists.yoctoproject.org wrote:
> Changes are inspired by scarthgap/rust README.md file.
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  README    | 15 ---------------
>  README.md | 43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 15 deletions(-)
>  delete mode 100644 README
>  create mode 100644 README.md
>
> diff --git a/README b/README
> deleted file mode 100644
> index 9e270f2..0000000
> --- a/README
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -"Mixin" layer for adding latest Go toolchain versions into the Yocto Project LTS.
> -
> -At the time Kirkstone was released in April 2024, Go 1.22 was the latest version
> -and officially Kirkstone supports only that. This thin special-purpose mixin
> -layer is meant to address this issue by backporting Go recipes from the master
> -branch of openembedded-core.
> -
> -The patches can be backport from openembedded-core with:
> -
> - git -C ../openembedded-core format-patch --stdout -1 origin/master meta/recipes-devtools/go | \
> - git am --signoff -p4 --directory=recipes-devtools/go
> -
> -Maintainers:
> -Jose Quaresma <jose.quaresma@foundries.io>
> -Peter Marko <peter.marko@siemens.com>
> diff --git a/README.md b/README.md
> new file mode 100644
> index 0000000..e316fc6
> --- /dev/null
> +++ b/README.md
> @@ -0,0 +1,43 @@
> +meta-mixins-lts - scarthgap/go
> +==============================
> +
> +"Mixin" layer for adding latest Go toolchain versions into the Yocto Project LTS.
> +
> +At the time Kirkstone was released in April 2024, Go 1.22 was the latest version
> +and officially Kirkstone supports only that. This thin special-purpose mixin
> +layer is meant to address this issue by backporting Go recipes from the master
> +branch of openembedded-core.

The above paragraph refers to Kirkstone instead of Scarthgap

> +
> +Dependencies
> +------------
> +
> +This layer depends on:
> +
> +- URI: git://github.com/openembedded/openembedded-core.git  
> +  layers: meta  
> +  branch: scarthgap
> +
> +Contributing
> +------------
> +
> +The patches can be backported from openembedded-core with:
> +
> + git -C ../openembedded-core format-patch --stdout -1 origin/master meta/recipes-devtools/go | \
> + git am --signoff -p4 --directory=recipes-devtools/go
> +
> +The yocto-patches mailinglist (yocto-patches@lists.yoctoproject.org) is used
> +for questions, comments and patch review. It is subscriber only, so please
> +register before posting.
> +
> +Send pull requests to yocto-patches@lists.yoctoproject.org with
> +'[meta-lts-mixins][scarthgap/rust]' in the subject.

rust -> go

> +
> +When sending single patches, please use something like:
> +git send-email -M -1 --to=yocto-patches@lists.yoctoproject.org --subject-prefix='meta-lts-mixins][scarthgap/go][PATCH'
> +
> +Maintenance
> +-----------
> +
> +Layer maintainers:
> +* Jose Quaresma <jose.quaresma@foundries.io>
> +* Peter Marko <peter.marko@siemens.com>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2539): https://lists.yoctoproject.org/g/yocto-patches/message/2539
> Mute This Topic: https://lists.yoctoproject.org/mt/116273426/6084445
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14038302/6084445/1344600526/xyzzy [skandigraun@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>


