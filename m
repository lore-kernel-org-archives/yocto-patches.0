Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A9EC3DA64
	for <webhook@archiver.kernel.org>; Sun, 28 Jul 2024 17:01:17 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.web11.38423.1722186077038433452
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Jul 2024 10:01:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LnSWS/Td;
 spf=pass (domain: gmail.com, ip: 209.85.128.178, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-661369ff30aso10864177b3.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jul 2024 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722186076; x=1722790876; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0e/TF6kQUQuOgwnOrFNRZ9XXXmV9cA0pQvnVt2ALATM=;
        b=LnSWS/TdXYNAg72RikR+TmvhAOzj07C3K/0A9aVEH7pZZ8FQUPhPjPNSqnwpB/P3Kl
         ZYZqxllNI40bDxw4hD5blcAbmq2/LjQm8hVElmjZ98liCjG9r4wvm58cDGaHhpDIS6pd
         DrM4C1iuzUYCtX12iR99GJkpWUuRxUQWwH7bwUOaD/OFSzOtbopQTfccE5yXwElKRW8v
         IGTBmKEjfAEtGrkBkkZEQZG8IX5spG02PUecxGxub1YYZmhh4n2JtJdVbhfpuNU7unoS
         uF7uDZ2qA+LE3Gyyg/nNssiRKWFkDJ1jwLCRukoB5anDEuJ8EP8qaa+S2H1EvV2go5OY
         pvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722186076; x=1722790876;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e/TF6kQUQuOgwnOrFNRZ9XXXmV9cA0pQvnVt2ALATM=;
        b=bSYSKwYjMhjUdVt/CvwigwdvIN5wZ2lj4NiiP86uNykElKPuoQ976+9+A4AbWg2uAD
         R54Udi19AkNJsBS076J2uGwow3dHB778ajzWtZ9BKgc48iKOhlkvb0l58py1uP7dMzMW
         9+R0TKVUjH4nv7Ie5lErfQynlfMbqNciF0iSXSANEU1D+l7R7ri2YUT4l1XjXc/gwGNz
         Kn8cbH5lbn/jR7GBAgRJYVKSlMdY2hlVQw1CuWGvtj5jsAz1CM0Z9RLK199zj3ONFa/4
         OKEUq+gSAHoJLjuWuULmJUxGpocWcavciAnBs4gubSu33Z4JtMolpjTXGVU9p5BPTNGu
         4d3Q==
X-Gm-Message-State: AOJu0YwQh0EDsXO3saDJsFIPuF6yhkCVcyydRjjc8litW1QHr7gWc5xI
	r9pOCNBYNHqRvSYkIb1ZqlRCPcaEWl3D41Al9KQp6z3S38MpofUbLokTlg==
X-Google-Smtp-Source: AGHT+IGObpdesD29kVnFO3GYQTbNSYe0Ic0gq1EaZUBxLCqvwtV1bw4igx9Ri+QD2gbiSYOrjqu0Nw==
X-Received: by 2002:a81:5c08:0:b0:62f:f535:f38 with SMTP id 00721157ae682-67a053e0c85mr65969497b3.8.1722186075960;
        Sun, 28 Jul 2024 10:01:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:45dd:7000:30bb:405a:cac7:4461? ([2600:1700:45dd:7000:30bb:405a:cac7:4461])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd8edbsm17151767b3.4.2024.07.28.10.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 10:01:15 -0700 (PDT)
Message-ID: <ae98ea6b-f9eb-4f78-9f9d-f5f196d884ff@gmail.com>
Date: Sun, 28 Jul 2024 13:01:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH 01/17] bastille: UNPACKDIR
 fixes
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
Content-Language: en-US
From: akuster808 <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; keydata=
 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
 ApZ86eOP
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jul 2024 17:01:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/480

Mikko,

Is this series different then the one I posted a few days earlier?

- armin

On 7/25/24 5:01 AM, Mikko Rapeli via lists.yoctoproject.org wrote:
> New poky version uses UNPACKDIR instead of WORKDIR
>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>   .../recipes-security/bastille/bastille_3.2.1.bb      | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
> index f2ef335..7074f68 100644
> --- a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
> +++ b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
> @@ -83,11 +83,11 @@ do_install () {
>   	install -m 0644 Bastille/AccountSecurity.pm    ${D}${libdir}/Bastille
>   	install -m 0644 Bastille/Apache.pm    ${D}${libdir}/Bastille
>   	install -m 0644 Bastille/API.pm    ${D}${libdir}/Bastille
> -	install -m 0644 ${WORKDIR}/AccountPermission.pm    ${D}${libdir}/Bastille/API
> -	install -m 0644 ${WORKDIR}/FileContent.pm    ${D}${libdir}/Bastille/API
> -	install -m 0644 ${WORKDIR}/HPSpecific.pm    ${D}${libdir}/Bastille/API
> -	install -m 0644 ${WORKDIR}/ServiceAdmin.pm    ${D}${libdir}/Bastille/API
> -	install -m 0644 ${WORKDIR}/Miscellaneous.pm    ${D}${libdir}/Bastille/API
> +	install -m 0644 ${UNPACKDIR}/AccountPermission.pm    ${D}${libdir}/Bastille/API
> +	install -m 0644 ${UNPACKDIR}/FileContent.pm    ${D}${libdir}/Bastille/API
> +	install -m 0644 ${UNPACKDIR}/HPSpecific.pm    ${D}${libdir}/Bastille/API
> +	install -m 0644 ${UNPACKDIR}/ServiceAdmin.pm    ${D}${libdir}/Bastille/API
> +	install -m 0644 ${UNPACKDIR}/Miscellaneous.pm    ${D}${libdir}/Bastille/API
>   	install -m 0644 Bastille/BootSecurity.pm    ${D}${libdir}/Bastille
>   	install -m 0644 Bastille/ConfigureMiscPAM.pm    ${D}${libdir}/Bastille
>   	install -m 0644 Bastille/DisableUserTools.pm    ${D}${libdir}/Bastille
> @@ -138,7 +138,7 @@ do_install () {
>   	install -m 0644 OSMap/OSX.bastille    ${D}${datadir}/Bastille/OSMap
>   	install -m 0644 OSMap/OSX.system    ${D}${datadir}/Bastille/OSMap
>   
> -	install -m 0644 ${WORKDIR}/config ${D}${sysconfdir}/Bastille/config
> +	install -m 0644 ${UNPACKDIR}/config ${D}${sysconfdir}/Bastille/config
>   
>   	for file in `cat Modules.txt` ; do
>   		install -m 0644 Questions/$file.txt ${D}${datadir}/Bastille/Questions


