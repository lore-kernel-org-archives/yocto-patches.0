Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E99C83F17
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:19:09 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web10.23403.1753298341735156352
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:19:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QtFuqe/V;
 spf=pass (domain: konsulko.com, ip: 209.85.219.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fad3400ea3so1959296d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753298341; x=1753903141; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFP/YIuX2k7XMbD+x1vNxAoxI9qfKZj25vyUC8lgvVE=;
        b=QtFuqe/Votvt5pvxs8Pat5IX15MH/3SklJRsUm7rnoQLIMGRllWuZR+RzLO537SgX2
         taEc1q3EHhpTORI2JBdPirtlt+GnSmA89Lmn98Nf2ASSjB9RuJy08sBrWZ3j1cQ3/5j5
         HzaJSioj4EDQmfcN+75jmEOOaVqMnZJjIDyYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753298341; x=1753903141;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFP/YIuX2k7XMbD+x1vNxAoxI9qfKZj25vyUC8lgvVE=;
        b=A865SfrWz5NI84sIZf5NPbOsSQaCwzHN5xURj/Tyk0D1tUBYHFD2CA2cDETobgeRq7
         vTmhukBVur/+pwmC0rMefsJxhPB+gZc1jr5kdAD1r7+Gv+ojQXd5LZX4cjmSgbtqw2VF
         sZQaonLg8mSTKQyoaG1XwAOomLfErwswD6SJRsyFuL1JJ0JH+dc/6v2mF5G8ZzXkcOdK
         AzUx6tkxnDMSuh068lhHYylWNs7porqPbC/hlQ5jOmtFfwDidrmxvOtOhsEJHBIMtRdv
         qZfqEnM0qFZP8kClszb+4LbnU0csS9PrczkYEzL3rd0OeyS/Ea4skJ9HSiecThvv7Hwd
         pJLQ==
X-Gm-Message-State: AOJu0YxH9JHIrIZ1PNz66ig+IA7b1SXxYcYrwL7ILzOpZhrAlll0NwWg
	rQNgwYmuWDu/phpbuajRsZA0ZsYeRktv5gUyd3F3+w//YlWgcVU0znB++UGg1b9IP85EYXLWF+u
	PgCwy
X-Gm-Gg: ASbGnctSYQJyKECT4boe80vNgyH/CZFAmAYxNr6UxiMtGw421JCbxu5yIgEyGQGWeWs
	/I6MQ7myH9XtQKbAj7eU1oJ9K14E/ahUdPZ0ZC2E+8KTeAkxPGBINoCBBcnPVkANMpWSbxbhB0M
	pPD4h5Q8aU/4LpqDjlaYKSVtnpsggTQqq/uKaVTJQalVluOg6MEf10GJPeYXDXxDShFY9t0HaKq
	HTN+FoYEK84IPeDvOfvQcdMPl6wUvaLEQzY1lByWKn28ghva85jd0hof8001LXWTvS59TUULR8q
	q1udLgwFHJQpegzkNOln6loHxEgaTpApz3mTMNuuBUJNU5r3c26Pn1iWtzhMSvlCZjX12FgcDVf
	lNtr16QxMjraUjdx/0kQhqQIAtcXotSXzfORlQtT+1IhmvlnWDwlon2TC
X-Google-Smtp-Source: AGHT+IHZT0yXyddR7OqhDEfs2ULevQC+oeELQIawyLUaFeb2m6Wue29Bnr2plfFdqMcN/U1y8suNbA==
X-Received: by 2002:a05:6214:528e:b0:6fa:8c15:75c1 with SMTP id 6a1803df08f44-7070058d077mr55088266d6.2.1753298340609;
        Wed, 23 Jul 2025 12:19:00 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070fb35710sm216926d6.29.2025.07.23.12.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:19:00 -0700 (PDT)
Date: Wed, 23 Jul 2025 15:18:59 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: soumya.sambu@windriver.com
cc: yocto-patches@lists.yoctoproject.org, randy.macleod@windriver.com
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/2]
 python3-awscrt: fix unsafe include path error during cross-compilation
In-Reply-To: <20250618132937.4119240-1-soumya.sambu@windriver.com>
Message-ID: <0474554e-aa75-a6bc-244c-931a4ffa8b61@konsulko.com>
References: <20250618132937.4119240-1-soumya.sambu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:19:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1856

On Wed, 18 Jun 2025, Soumya via lists.yoctoproject.org wrote:

> From: Soumya Sambu <soumya.sambu@windriver.com>
>
> After meta-lts-mixins introduced a newer setuptools, python3-awscrt is failing
> to build due to unsafe include path
>
> cc1: error: include location "/usr/include/python3.10" is unsafe for cross-compilation [-Werror=poison-system-directories]
>
> The issue is resolved by explicitly forcing setuptools to use distutils
>
> Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>

I tested building python3-awscrt and python-grpcio without these fixes,
and they built fine for me (iirc, even with Rust 1.85.1, but definitely
with the 1.86/1.87 updates I just posted).  Can you perhaps try to
reproduce the failures with them and python3-strict-rfc3339 again to see
if they still happen for you, and if so please provide specific setup
information for reproduction (i.e. build host and specific layers and
commits used)?  Also, please see my comments about the mozjs-* dynamic
layer bbappends in my kirkstone/rust update cover letter, they are
issues there that need investigation.

Thanks,

Scott


> ---
>  conf/layer.conf                                                | 3 ++-
>  .../iot-cloud/recipes-aws/python/python3-awscrt_%.bbappend     | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>  create mode 100644 dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%.bbappend
>
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 4fe4ec4..280393d 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -28,7 +28,8 @@ BBMASK:append = " meta/recipes-devtools/python/python3-setuptools-rust-native_%"
>
>  BBFILES_DYNAMIC += " \
>      meta-python:${LAYERDIR}/dynamic-layers/meta-python/recipes-*/*/*.bbappend \
> -    openembedded-layer:${LAYERDIR}/dynamic-layers/openembedded-layer/recipes-*/*/*.bbappend"
> +    openembedded-layer:${LAYERDIR}/dynamic-layers/openembedded-layer/recipes-*/*/*.bbappend \
> +    iot-cloud:${LAYERDIR}/dynamic-layers/iot-cloud/recipes-*/*/*.bbappend"
>
>  # These are in bitbake.conf in langdale and up, adding them here to make
>  # using the layer more turn-key seems reasonable.
> diff --git a/dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%.bbappend b/dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%.bbappend
> new file mode 100644
> index 0000000..bd0b910
> --- /dev/null
> +++ b/dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%.bbappend
> @@ -0,0 +1,3 @@
> +do_compile:prepend() {
> +    export SETUPTOOLS_USE_DISTUTILS=stdlib
> +}
>

