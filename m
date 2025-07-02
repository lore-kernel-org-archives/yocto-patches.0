Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDE1C83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 08:24:12 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.18637.1751444649575894888
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 02 Jul 2025 01:24:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PfGHOuH6;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: skandigraun@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso8049135a12.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 02 Jul 2025 01:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751444648; x=1752049448; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WucfbkBYgWHseojMtvfrry0czfRYoB1YANscruG26ro=;
        b=PfGHOuH6D5w95uAhV1+2Mal51n6qzpV0HKxiUrP7lJZBwlUg9+sL3dhmyobeR+k+wW
         TTO8OTsPMItTvym7lIfODzTPtZAmhfzV+pp+A8ldrVuRCVSXWqt9tFZg8l1pQG5KRkq1
         PAvbYNPWzc9kl+2L6BfAMNWxIpVcG9GU89p1cSlfbtA5OSwvw7KEY2tC0BIJEYmAfBQ2
         MDCID1H3UnkVsgrsBTwE9sFCW8ZZG4hXc3BBJpZvq62eH0ZRNecMIvhCTPwT5HbqYqeJ
         vT0lIJz4lX0NWG4ZQouU1cQx03wi0eW9/R0vIqML5NmvXIlD9JAJUFTZ0KrHdZX83ItL
         HkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751444648; x=1752049448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WucfbkBYgWHseojMtvfrry0czfRYoB1YANscruG26ro=;
        b=WVcuWOEysj8SQR5qB7RsKmBfwUR7gNiP2TKXTLF3GiQf0KONMVzLq19fh7IJBU66Iu
         Ud3WNXtVgv2tTkNve0zrJPU83z964Wa04ESkJKqNxhVHFR9tSyFIvCIGo3HQWKhSC4iO
         2cG+fN0KVh20oQpD3Cfh/pjS0P+jj9Cl/AFN9yVbaxZWJ1R6orBo2rwniETvgcXHc3Gk
         yhOG+oDQh4PTtI4+/S5OQ/XuO4eTFtWcZcdR//tb4pXwx01wQhR9gyPmnDizVPs4qVwB
         wgW1azONgEK2CqmmXSpjoCZrI4aRi5DNOdpfYsdB3Yrbsg//Rn6Pqy8DAlmZdWTbG2ai
         NM9w==
X-Gm-Message-State: AOJu0YzTJqP8Qy6VCmEnbpEvVCcKJcvSpENJXDD9lP3OeU1FfeKxWgqU
	gaC2/ocplRSpZ/vGdGdGpqgzHnlAn3Q49/mMNu9/NsXg62HukG/LWY8g7IyfhltO
X-Gm-Gg: ASbGncs/CSyXgF0z6fBTb1IT83pWj6S04X50L6Z/NdC4CY8EzyS4MnOMvaB4Hh1oheo
	Oi2X8+6IvhPyWJeaqy7DERyVUDqPdD7w1YTGrBF6gdD1hD9ryg61UY2hn2ITuS6t65JQpnludlj
	5cgU7ZZ+Mk3/LBCoEfd29fVKRrWJp2M7Hn+OGEB/7G2DcZHwMeN6GVdE58JdLMfie2u2OQmY8fV
	aYYwV7yO3FkC92HkpZteJ1SW9vAAGAwV/SUEK6eWsVExEehYzOeL7MY1y4EDkoMsUs7jEfLv+t6
	FisLAVlbnaPTFcVczgepNsW1fDiuCXS0jexBwp6BXvO7aOWxvnocS+WvbGvF9xUGVwWv5gV/ybZ
	4ICEV
X-Google-Smtp-Source: AGHT+IG/tDijwFp8sKp4HJM8VBAUp9Zk6hX+AWbst0qOiFjwWcNEud9+RKNawHy1d+QH46TpcH4FKw==
X-Received: by 2002:a17:907:60d4:b0:ae1:1a30:6682 with SMTP id a640c23a62f3a-ae3c2ae34d7mr197423066b.18.1751444647358;
        Wed, 02 Jul 2025 01:24:07 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3b13222a9sm270456766b.19.2025.07.02.01.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 01:24:04 -0700 (PDT)
Message-ID: <12b9c28d-4432-46bb-ac7f-5edda2b481c4@gmail.com>
Date: Wed, 2 Jul 2025 10:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH 1/2] layer: drop styhead,
 add whinlatter
To: yocto-patches@lists.yoctoproject.org
Cc: maxj.fnst@fujitsu.com, Liu Yiding <liuyd.fnst@fujitsu.com>
References: <20250701100013.826-1-liuyd.fnst@fujitsu.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250701100013.826-1-liuyd.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 02 Jul 2025 08:24:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1733

On 7/1/25 12:00, Yiding Liu (Fujitsu) via lists.yoctoproject.org wrote:
> fix the issue:
> ERROR: Layer security is not compatible with the core layer which only supports these series: whinlatter (layer is compatible with styhead walnascar)
>
> Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
> ---
>  conf/layer.conf                | 2 +-
>  meta-hardening/conf/layer.conf | 2 +-
>  meta-integrity/conf/layer.conf | 2 +-
>  meta-parsec/conf/layer.conf    | 2 +-
>  meta-tpm/conf/layer.conf       | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 84d40a1..7c8e403 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
>  BBFILE_PATTERN_security = "^${LAYERDIR}/"
>  BBFILE_PRIORITY_security = "8"
>  
> -LAYERSERIES_COMPAT_security = "styhead walnascar"
> +LAYERSERIES_COMPAT_security = "whinlatter walnascar"

I'm not sure if this combination is valid, in case the layer fetches any
source from git - I believe it can be compatible with whinlatter, or
with others.


