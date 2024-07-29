Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ED3C3DA7E
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 13:26:08 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web10.55976.1722259558886132126
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jul 2024 06:25:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iFsapkE8;
 spf=pass (domain: gmail.com, ip: 209.85.128.177, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66ca5e8cc51so21853097b3.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259558; x=1722864358; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6ufou/q0G64eq2o+jCm9p+1UBRgE5NfksYf1qVDJ0Xg=;
        b=iFsapkE8x3c/q2fqa6bEROu9UmyyWyIMAXth5/1KmUig9u5m/SayHDPyTrezCxIIqP
         0OxlxUadkb7lCj8Dkyzc5U8FGZ1Uw7GCgj30OcPkIHt7Iv040Ja5IbFA9MmcTumU1M+S
         MYOA4K49TP98E2qv1ZpE+nzwsoiL/cXHSGrKBpZ2om5uJ3/gLIpTIOD5Ek4gY9MH5gwo
         p6j8iiZGF09s42iCzHQK69N+cb22ibnFAbq2TRSADp4bH0GpEMOpXDHCaysmMvagx2ax
         cEHcFlhA1Sh3vjOGAQ61UV85A0rZzPXapapOWi57K1Jhb6UpkgjSmlqGb8hbxa/R0cmg
         OmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259558; x=1722864358;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ufou/q0G64eq2o+jCm9p+1UBRgE5NfksYf1qVDJ0Xg=;
        b=MMN7g1LG3+wJZOBMVbuq8pRo871JYssQ0CXvFTc9P+xXV6QqWAg+gtvWqnsboiLo2Q
         +fO8pP00XMQtX0lq6lCSQFMpcdZCSdwRuZB2Tm/8GF4o3D3ksdkBNvndIlNOjwidzCCN
         h32B88LnQ/j9gTkxJu1GdpkvmGN9p2YoTWFAe4M7rA84Kja7L//KIMlO3FIiFP2kLDIu
         My6lOiFUXL2OVJvgKeAvmZ4qwoYinABxPJywp7edZ0KFwMX7ZENnt0R4XNyzfuJ7Rytx
         GdnMHPIFtUY97ywSFWrZRKkIM6RQJgJBZzGN2SRUyVf/2ziuk9jHy1k1BIn+MOa4aVtm
         lyvg==
X-Gm-Message-State: AOJu0YzPGS6oJr0fqYJe4HFus7/HoL4WGupZPHHpOoCC60PzxC6CpfF7
	VFcIZwjy9FvIMqvMfnXR4MHlj3kYfTzsGVphmZEtSt95GuvwcOqZCaG6SA==
X-Google-Smtp-Source: AGHT+IFGHW3ZQl9UT7wlzjuf8kJ/m9JjXY0pz3Y7WI4eU5uSe0Klt3G3H7poDzbzdxkbXfvAXLFRlQ==
X-Received: by 2002:a05:690c:6d08:b0:66a:8ce9:b1c7 with SMTP id 00721157ae682-67a0a136022mr103940477b3.37.1722259557767;
        Mon, 29 Jul 2024 06:25:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:45dd:7000:47bc:453d:d517:b47? ([2600:1700:45dd:7000:47bc:453d:d517:b47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd904esm20563347b3.3.2024.07.29.06.25.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 06:25:57 -0700 (PDT)
Message-ID: <3a17cf20-190e-4e02-97f1-53f85d8f1677@gmail.com>
Date: Mon, 29 Jul 2024 09:25:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] basille: convert
 WORKDIR->UNPACKDIR
To: yocto-patches@lists.yoctoproject.org
References: <17E6AA6DB0346950.683@lists.yoctoproject.org>
Content-Language: en-US
From: akuster808 <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; keydata=
 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
 ApZ86eOP
In-Reply-To: <17E6AA6DB0346950.683@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 13:26:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/493

ignore this.. not enough coffee this morning

On 7/29/24 7:08 AM, Armin Kuster via lists.yoctoproject.org wrote:
> Signed-off-by: Armin Kuster <akuster808@gmail.com>
> ---
>   .../recipes-security/bastille/bastille_3.2.1.bb    | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
> index f2ef335..b95ec2d 100644
> --- a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
> +++ b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
> @@ -35,7 +35,7 @@ SRC_URI = "http://sourceforge.net/projects/bastille-linux/files/bastille-linux/3
>   SRC_URI[md5sum] = "df803f7e38085aa5da79f85d0539f91b"
>   SRC_URI[sha256sum] = "0ea25191b1dc1c8f91e1b6f8cb5436a3aa1e57418809ef902293448efed5021a"
>   
> -S = "${WORKDIR}/Bastille"
> +S = "${UNPACKDIR}/Bastille"
>   
>   do_install () {
>   	install -d ${D}${sbindir}
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


