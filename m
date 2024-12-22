Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9364E77188
	for <webhook@archiver.kernel.org>; Sun, 22 Dec 2024 17:27:28 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web10.28249.1734888439076640298
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 22 Dec 2024 09:27:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y5ALTraj;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef4b6719d1so28458887b3.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 22 Dec 2024 09:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734888438; x=1735493238; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AO3+2FUZnmz27CwySljQUtIb/ej/N8/3ASHvV7ZroTw=;
        b=Y5ALTrajXGb1/JEBlH9FW03ZcMDIc3PNmCWbT5N4VIbcdWiaSIAJ9FtRetO/1zckRi
         lKK3egQ7lNGS9V6rEva9ADsT+FwGxD1k13o5oVJHZgnzxyPEnlgLg7M5lKVLSwqdabp8
         iX5+Vd3ewOLAR0XVYOvjAiOTRboO9EOxprgdBedxSJ/uMDwxgzIu/R92DbYOUXnmOHNA
         3Jjd0xV+dphQKOPW2fGPnqNCkv0rae4AfQUMV4LaQG0xmJQTKJ3NDSioabDTpJCR9dDK
         N/cq8ljSYzU2WENCozvsUByUE+HVcbYMDsA3tpczVTJ+Cj9TfDonsmpH1pJY3Sm5db6M
         UZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734888438; x=1735493238;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AO3+2FUZnmz27CwySljQUtIb/ej/N8/3ASHvV7ZroTw=;
        b=fl+gx1BG6D1YYX9s47L+aH8kyahBIaHV2j6ZVSc0S4SGk8hjCUEdXX2tvehyh5SOw7
         j/jri5S4xp87Ftf7BNKzQ1YOCzMZ6N70nWoO+TuTjZRJTZBpVWbx7DowpaiqhUQuDNrt
         i66VB+430ZTBR+lwO0QoCkw9yKbxDP17HBLDbD/XbNQtu88N33sgEqd7gnDTP/5aBJCR
         pwGzqxZKIjN/Q3jPN5bzWQ9eJuaNOqYQOlwpLScSOGtol62u5n+P/SsLoeC3hblbp3ba
         M09Pm6yPdN7t44I1oZZ7fG0FychCmsgq+b+lipGRLzrfp4ylyo5kVtgGQRZvlZhFeqLH
         ljbw==
X-Gm-Message-State: AOJu0YzFDT19XKQpjRfjaQUV9lGOEdA0RJnf8LSnkAMfotZE1Ga1ZsuE
	X3m70uMpmScQaTnAENakr50a8GAJXR3kTDF6pi5FkoIwMfrBgbJ2
X-Gm-Gg: ASbGnctGzDiKPrBOY4N97HKg7fn7i3aNAeZh5bdNmTMxvpdhPxZz34HGG088Jnj8SnA
	QBkRnSH56TWb3TIu5SY3VYC7s4qDuTNKf44b+UqxjmU4eaSFgL5MZ9+LgJmdWt0g2qAO+CiXg5A
	O5qSWMAxYaUtHJrscchGdP3g5yit8YoSY1RK6INRRhbeC4Br7HotLeqNmk6rvHJ9W9+GoGQZU/n
	OO7Q1TOAiLMHVSRqIXv09HzwlE4qU8KZq+clz6G7Fn52BigsW3qN8VIRhn9oxqMyUHWImT8labu
	cJoASanlITffW5+0krE5IBBOKNfcqXCo
X-Google-Smtp-Source: AGHT+IHLzeUtBX+OkbCVZ4hmxYsnjXNmAnp7vyoemSxXoNirnodtPQ+QFxfCWyqyhwJBG61C78yjfg==
X-Received: by 2002:a05:690c:389:b0:6ef:7d1e:bffd with SMTP id 00721157ae682-6f3f8238c34mr68669027b3.37.1734888438241;
        Sun, 22 Dec 2024 09:27:18 -0800 (PST)
Received: from ?IPV6:2600:1700:45dd:7000:5d02:58f4:f953:6650? ([2600:1700:45dd:7000:5d02:58f4:f953:6650])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e77ed619sm19608767b3.86.2024.12.22.09.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 09:27:17 -0800 (PST)
Message-ID: <af740159-d332-48fa-aafd-916abca7f127@gmail.com>
Date: Sun, 22 Dec 2024 12:27:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH 03/18] chkrootkit: change
 download from Ubuntu to Debian
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: yocto-patches@lists.yoctoproject.org
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
 <20241220140441.271395-4-mikko.rapeli@linaro.org>
Content-Language: en-US
From: akuster808 <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; keydata=
 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
 ApZ86eOP
In-Reply-To: <20241220140441.271395-4-mikko.rapeli@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 22 Dec 2024 17:27:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/959


Hello Mikko,

An pkg update was posted two days ago allowing ubuntu  still to be used.
This will be used for the older branch.

thanks,
armin

On 12/20/24 9:04 AM, Mikko Rapeli via lists.yoctoproject.org wrote:
> Ubuntu server doesn't have the file anymore but Debian has.
>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>   recipes-scanners/rootkits/chkrootkit_0.57.bb | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/recipes-scanners/rootkits/chkrootkit_0.57.bb b/recipes-scanners/rootkits/chkrootkit_0.57.bb
> index d35f5f6..c71b45c 100644
> --- a/recipes-scanners/rootkits/chkrootkit_0.57.bb
> +++ b/recipes-scanners/rootkits/chkrootkit_0.57.bb
> @@ -5,7 +5,7 @@ SECTION = "security"
>   LICENSE = "BSD-2-Clause"
>   LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=fdbe53788f7081c63387d8087273f5ff"
>   
> -SRC_URI = "http://archive.ubuntu.com/ubuntu/pool/universe/c/${BPN}/${BPN}_${PV}.orig.tar.gz \
> +SRC_URI = "https://ftp.debian.org/debian/pool/main/c/${BPN}/${BPN}_${PV}.orig.tar.gz \
>              file://musl_fix.patch"
>   SRC_URI[sha256sum] = "06d1faee151aa3e3c0f91ac807ca92e60b75ed1c18268ccef2c45117156d253c"
>   


