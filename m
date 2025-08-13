Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAD5CA0EE0
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 08:00:20 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.95465.1755072011787532717
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Aug 2025 01:00:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H4nYwRYp;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: skandigraun@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61867b0238bso1418494a12.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 13 Aug 2025 01:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755072010; x=1755676810; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=esuOVLqZ5Gg6LvnyzqTVx2+TXJ6a1uMV8k4F+XNCels=;
        b=H4nYwRYpUlwQmmRsnGfr2UHAjxS8EjtUdvm3la1Ngk7YtJ9pIQ7GqHqTGR1tRSaHTP
         6Kt4Qi+6flwHeH6Ns0B4+/o8sRjenzljnJ6X5C5cNJqaU4MYxVljiXiA4sCDFaYaQNeR
         z983+MTzJepR/n2C5idMmpHOB0HnBlnndaPiPLc5plLheQz18TmSAfgcD4Zr+wZ7+Aia
         Agi5gCxqnBI6YaF9esi4jLOnKurrs0s+BHozh6n5dwWeSR8Fv7oG8mMHiUmUXjYFvZGS
         moKp4w6s6nfNBqJcpr1BVBOGPP8Dqy5JGYupCZz4BkKt8Wa22dDs305uKjViFec7nWYS
         6D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755072010; x=1755676810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=esuOVLqZ5Gg6LvnyzqTVx2+TXJ6a1uMV8k4F+XNCels=;
        b=xIR3sWjsvjtrWQSML8o5zG2WNS3o7s51OqzePDjMbjegEPshmJUxc6a5awpX/Ql+ID
         FUadgrH5CsllBBGxkckRu4KXPHi/gKH3v/BaJIlOfm9BkdJakxNDQiioD0dfsSIGsImu
         Kr6DgCE6o/1XUJBIpT9XU9THBbWMwwlw5hYIgjauBWU4hGG+Qfjh49iOm3LF8dn8mtIh
         Dd1lfikaubuo7vMKVfD4wA4KT/G2mmLFqVVuf27bPSEHSJm82ydUbuvL2nU0dvXj2Qxb
         UY0WfLsY4WhJM11b41khLgKy8fKQUBetSBwBmB0vFzd+p1sgcl0qWUYJBQw+8tnP19Eo
         ru+g==
X-Gm-Message-State: AOJu0Yz9yQlxhIkDNFimDkE7WlTsZitQ7UwcPW5EHzjhQ5NFYzxyWbsG
	Isb9eMDMT2taT0ochXbEmJDbkubJwutWgFa403uW9kyDUpxuDfpnoHSbas7tlg==
X-Gm-Gg: ASbGncunsDp6AU3yhYLHxNMq8xnLqUjj5S1kjje1g26/zUIPiRDHrHDY7/gBatnJk9f
	P/Tfv55J/DsL05IBXVKwMdfx/oJ4HGeMgJi7kMYFbxBwQK+YE8Ju+raZjnya4DIn38m2Y8jAzhW
	1TBjoNTM9wksH+9fmwXcDuy/uRcKjJXMI86k/4ITLA7kQGeUcnpZ3TdXbJf4qI8b4TZjHi9HivQ
	kInJSoK0q+TGhSpl5Vb7N6zMggEJi1VUBmWpRK/2q2pF+/HNnyDj2htI+xYmbExXw/Z6shHp92j
	GEqwTmU0orvM6mgWQ0xG9LD5Mj5d2EpwL5GhmHMm1mXXmASuQMMlUFjdLV8nCa9IT0sGiJ8imZ9
	I+GqCDuCIvf2Gx1TF18rcglKOW+FbQg==
X-Google-Smtp-Source: AGHT+IGfYrPOw3ayFR8RLQH4JzErQmrxEjlkU1XisB16opdSuI8BNwHizYJqIrtcxVVJzVH7tXBFHg==
X-Received: by 2002:a05:6402:34c9:b0:618:4c02:bac with SMTP id 4fb4d7f45d1cf-6186bfe58f9mr1594181a12.23.1755072009829;
        Wed, 13 Aug 2025 01:00:09 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615cc38aee5sm19752080a12.3.2025.08.13.01.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 01:00:09 -0700 (PDT)
Message-ID: <43b396bc-986d-4244-a6dd-61437de53cac@gmail.com>
Date: Wed, 13 Aug 2025 10:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][PATCH 1/2] layer.conf: Update to
 whinlatter release series
To: yocto-patches@lists.yoctoproject.org, chee.yang.lee@intel.com
References: <20250813063904.3141303-1-chee.yang.lee@intel.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250813063904.3141303-1-chee.yang.lee@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Aug 2025 08:00:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1981


On 8/13/25 08:39, Lee Chee Yang via lists.yoctoproject.org wrote:
> From: Lee Chee Yang <chee.yang.lee@intel.com>
>
> Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
> ---
>  meta-zephyr-bsp/conf/layer.conf  | 2 +-
>  meta-zephyr-core/conf/layer.conf | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/meta-zephyr-bsp/conf/layer.conf b/meta-zephyr-bsp/conf/layer.conf
> index 60a0a80..52d9938 100644
> --- a/meta-zephyr-bsp/conf/layer.conf
> +++ b/meta-zephyr-bsp/conf/layer.conf
> @@ -15,4 +15,4 @@ LAYERVERSION_zephyrbsp = "1"
>  
>  LAYERDEPENDS_zephyrbsp = "zephyrcore core meta-python"
>  
> -LAYERSERIES_COMPAT_zephyrbsp = "scarthgap styhead walnascar"
> +LAYERSERIES_COMPAT_zephyrbsp = "scarthgap whinlatter"
> diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
> index 3482c6f..11a5bbd 100644
> --- a/meta-zephyr-core/conf/layer.conf
> +++ b/meta-zephyr-core/conf/layer.conf
> @@ -15,7 +15,7 @@ LAYERVERSION_zephyrcore = "1"
>  
>  LAYERDEPENDS_zephyrcore = "core meta-python"
>  
> -LAYERSERIES_COMPAT_zephyrcore = "scarthgap styhead walnascar"
> +LAYERSERIES_COMPAT_zephyrcore = "scarthgap whinlatter"

The second patch in this series (S/UNPACKDIR fix) makes the core layer
incompatible with Scarthgap, should be Whinlatter only.

>  
>  PYTHON3_NATIVE_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON3_DIR}/site-packages"
>  


