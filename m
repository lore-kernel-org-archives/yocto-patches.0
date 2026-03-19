Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AD4108E1ED
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 11:24:07 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8708.1773919444251167392
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Mar 2026 04:24:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Ea0bwGIi;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cfc2d1fdbfso18315585a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 04:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1773919443; x=1774524243; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOFWrvCvnB9Y8VsfKxKQwsrs7bDzFiGYFzVzgCO8E6U=;
        b=Ea0bwGIilD+wRTE6gGXfqLGFqhmwWkB2fFtX4tT6Yx0YBXPG/MqYONGa59xhJ709Xz
         bSbDzkyH/J5816j9PIz8Z7exIv5rxJZQtzXTlYrpzDpMOtyis14nIhc9wXPPfHRSehlY
         TwStufPKrdS4ffUY2eQdbceLLvbqxl5auyXkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919443; x=1774524243;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOFWrvCvnB9Y8VsfKxKQwsrs7bDzFiGYFzVzgCO8E6U=;
        b=Va9WU0yaiPSOjABDXbEvY955nlcpPP0d7fu8ZFlh01ww6osu4KHjiWjOs/nPKcWjTX
         5U4K91NwCZ4ygeplG7egCbcI4ODdBcVAIbxGWFG7SFhJNQ/wajYCVFWXfnsDoA/mt64s
         M+RPbX82oXtG3gc4cSLy+HVSVYlOXtEamZjplVDnTBgAaAkQbYYStKXMOo/blE/YHg5S
         0kXONRtTtkSTdvu5LuGNIZhiNkLEHAAKRZ+1YJkPJM2/6BEephCIrMSZhb7Dxy9dnQhG
         GPxT07UHMf0v92hs9q2BKER0smR780anhkZInys22GYt/0uDQ75JGjfCS16gp079muWr
         VYSg==
X-Gm-Message-State: AOJu0YwaUB6meujzaby7TpN3PkZEt6qScCmiTtheOwbIspbQgY7ytkdr
	lpRvCXnYWNrjIcpn9JAt7iOnWs+iEXiJh8NHNPoYe4fMGLI02ag7FO1LOsvKVkuWMcKlT/QEuCx
	IE8U4
X-Gm-Gg: ATEYQzyDLlLC4J7N31h2o1LkrADKX2ybNVqIoHcwwCDHscipGCrcj7GQdlHE0UbU187
	Wq+YtRwTDbOjy75JACWslpchdb5YCZcR30u7OY+457v69pUKou1zzP70MHdOXAmDO9s+oi7WOM0
	7+5jRokxmEZONqA0quHsFSzEZDE8npUufogNlLZlMnYFjuWm7gVFQ7TGZq6rKnahr9wyPUwI67c
	azo79HWXYs9bTzyBqVPns4A8ryW0lWlJEkZVZOsQGbKGCoIFll4aFCE4Lqu4wslugTOyJaV4psa
	194fKLXFHfKqtp/454kZJvT/ENGieMiEzArXe1484s9UGg3RjojgGMyjRL7YUKQct1J8oQYBC5a
	TP6QUVs3pT6+FOdFBCwDzreMcQFUQPLy8vZ7TXHD9tPCepdUSg6gjJDksOP/UhurnRJ5CU+SfzO
	bJ/URgNKObqZ3mR9et1vtOdCuwYetioJc4ATlfnivyQviXaLi+vd9W4mtal0F4YEpruo/5x+nPC
	M9P+WuYoOoOW87tcKSogwFBge9zmqibDDEDtYG3zonNj3Czr7RdiNDHLA==
X-Received: by 2002:a05:620a:4490:b0:8ca:105a:298e with SMTP id af79cd13be357-8cfad3b6dc0mr930677085a.63.1773919442830;
        Thu, 19 Mar 2026 04:24:02 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfad167ee1sm444257585a.28.2026.03.19.04.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:24:02 -0700 (PDT)
Date: Thu, 19 Mar 2026 07:24:01 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Martin Jansa <martin.jansa@gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH] layer.conf: Update to
 wrynose release series
In-Reply-To: <20260318074110.111350-1-martin.jansa@gmail.com>
Message-ID: <e6a0b47d-5216-0dda-b8eb-c0c027ff2833@konsulko.com>
References: <20260318074110.111350-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 11:24:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3522

On Wed, 18 Mar 2026, Martin Jansa via lists.yoctoproject.org wrote:

> From: Martin Jansa <martin.jansa@gmail.com>
>
> Changed in:
> https://git.openembedded.org/openembedded-core/commit/?id=cd1179544d74026c99a4938824146cec4f5acfca
>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>

I had started on this yesterday, but sanity testing was blocked by
meta-openembedded not having updated.  I have some personal travel
the next few days (about to board a flight), but I'll push it out
this evening.

Scott


> ---
>  conf/layer.conf                | 2 +-
>  meta-hardening/conf/layer.conf | 2 +-
>  meta-integrity/conf/layer.conf | 2 +-
>  meta-parsec/conf/layer.conf    | 2 +-
>  meta-tpm/conf/layer.conf       | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 7a86054..e08a58a 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
>  BBFILE_PATTERN_security = "^${LAYERDIR}/"
>  BBFILE_PRIORITY_security = "8"
>
> -LAYERSERIES_COMPAT_security = "whinlatter"
> +LAYERSERIES_COMPAT_security = "whinlatter wrynose"
>
>  LAYERDEPENDS_security = "core openembedded-layer"
>
> diff --git a/meta-hardening/conf/layer.conf b/meta-hardening/conf/layer.conf
> index 367d3d7..dcc4fa8 100644
> --- a/meta-hardening/conf/layer.conf
> +++ b/meta-hardening/conf/layer.conf
> @@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "harden-layer"
>  BBFILE_PATTERN_harden-layer = "^${LAYERDIR}/"
>  BBFILE_PRIORITY_harden-layer = "6"
>
> -LAYERSERIES_COMPAT_harden-layer = "whinlatter"
> +LAYERSERIES_COMPAT_harden-layer = "whinlatter wrynose"
>
>  LAYERDEPENDS_harden-layer = "core openembedded-layer"
>
> diff --git a/meta-integrity/conf/layer.conf b/meta-integrity/conf/layer.conf
> index 23d6848..f907385 100644
> --- a/meta-integrity/conf/layer.conf
> +++ b/meta-integrity/conf/layer.conf
> @@ -20,7 +20,7 @@ INTEGRITY_BASE := '${LAYERDIR}'
>  # interactive shell is enough.
>  OE_TERMINAL_EXPORTS += "INTEGRITY_BASE"
>
> -LAYERSERIES_COMPAT_integrity = "whinlatter"
> +LAYERSERIES_COMPAT_integrity = "whinlatter wrynose"
>  # ima-evm-utils depends on keyutils from meta-oe
>  LAYERDEPENDS_integrity = "core openembedded-layer"
>
> diff --git a/meta-parsec/conf/layer.conf b/meta-parsec/conf/layer.conf
> index 39d1265..79acc89 100644
> --- a/meta-parsec/conf/layer.conf
> +++ b/meta-parsec/conf/layer.conf
> @@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "parsec-layer"
>  BBFILE_PATTERN_parsec-layer = "^${LAYERDIR}/"
>  BBFILE_PRIORITY_parsec-layer = "5"
>
> -LAYERSERIES_COMPAT_parsec-layer = "whinlatter walnascar scarthgap"
> +LAYERSERIES_COMPAT_parsec-layer = "whinlatter wrynose walnascar scarthgap"
>
>  LAYERDEPENDS_parsec-layer = "core"
>  BBLAYERS_LAYERINDEX_NAME_parsec-layer = "meta-parsec"
> diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
> index 582fe1e..94ca4c6 100644
> --- a/meta-tpm/conf/layer.conf
> +++ b/meta-tpm/conf/layer.conf
> @@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "tpm-layer"
>  BBFILE_PATTERN_tpm-layer = "^${LAYERDIR}/"
>  BBFILE_PRIORITY_tpm-layer = "6"
>
> -LAYERSERIES_COMPAT_tpm-layer = "whinlatter"
> +LAYERSERIES_COMPAT_tpm-layer = "whinlatter wrynose"
>
>  LAYERDEPENDS_tpm-layer = " \
>      core \
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3504): https://lists.yoctoproject.org/g/yocto-patches/message/3504
> Mute This Topic: https://lists.yoctoproject.org/mt/118379316/2167468
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13170805/2167468/856840347/xyzzy [scott.murray@konsulko.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

