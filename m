Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287F6C2BD09
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:14:25 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web11.17346.1719832455221246740
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jul 2024 04:14:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NzNKOLpA;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6439f6cf79dso20731627b3.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 04:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719832454; x=1720437254; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dZwqR9oBoiWnvbCDaQkYylyfTfwrUk9MFWfTTBx95Xc=;
        b=NzNKOLpAtYbcIqAagUS7+u3MGHVawLZFYxEi7Ev5N7TTOYpryE8ekSa7iyvn0mA3JV
         0IDFuF+yo0Ps4w3lQ0g8UwgzlvG/f2S7mLVM2gIru8tIxf1SqentkZhLQT6r99yyuuC5
         kO8ufwuuWamwkEQTUINEBTYcFOtWWOUSZPAmOWiYFp+jnO/U1yJw5Yrwq/Eo0OnL93I0
         AbyAW1qtqIWxwLQ1ZLBBXf/17MW/8vyVfNhO9IqZ9cLb1heoQV1pLB6JNVYGh+jW0hk/
         wtja5qAJKwvGcMnJ6WwDdk9LVMfz8Tnynwk8oCg65elJ/XUAbSb/z578TZgLoPZtkhOS
         fcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719832454; x=1720437254;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZwqR9oBoiWnvbCDaQkYylyfTfwrUk9MFWfTTBx95Xc=;
        b=fI6Ny8dlBXC86E1pczLwLjNUlbocd/XS6tYTwhvpoBUoVP3smfahjj2NZANI+RG7kW
         mIpwwXMxCjBuGDvbeEzszvNnMnjkaBctGkNcbKGbKcKICu8LanJXjTdibry0DIn+WWGE
         hrztu9l8IXpbeKstoY1znpXnfy6K54zeNyJrYzXJ7QqmsPlcna3aX7INNTXnnJeGBy26
         +Y3mDtPTE6FTcm2N9ftyFgsaIZ2WnNzn0Zo65zbqYj1Nn8I1kFjfVBj6P1Joukzg3O4b
         pyAvYXGXFR7fV9h/cQ3T/S8j8Bk8jYRt/d8/4PSmzdGA3AtdUlpSowNgkFuJhaUzjXkr
         RJaw==
X-Gm-Message-State: AOJu0YxiX/m2yKa1W5Wch9VtucD/z+SKArszIJXrLnsDNRA3wTHWiPW3
	plfW/YlyPRpcJDJNmSbHcowaoOrMsZ7c4fWYv+ojjaWTX+k9NoXvPALxCA==
X-Google-Smtp-Source: AGHT+IEOC2XCRpy5iAeTmdnxG5EfkPDz6v6qB7Y5eyAKWypfG0SVBYYs3fPtDJl58uqTbSKoGbiy+A==
X-Received: by 2002:a81:fe04:0:b0:630:de2f:79b3 with SMTP id 00721157ae682-64c71cd90d7mr50956917b3.25.1719832454195;
        Mon, 01 Jul 2024 04:14:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:45dd:7000:978e:d840:6c32:150a? ([2600:1700:45dd:7000:978e:d840:6c32:150a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9c40907csm13216807b3.139.2024.07.01.04.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 04:14:13 -0700 (PDT)
Message-ID: <d3296a3e-38f9-4ffc-bd16-4952e15e3b87@gmail.com>
Date: Mon, 1 Jul 2024 07:14:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security,kirkstone][PATCH 1/5] sssd: fix
 missing python3.X-config script
To: yocto-patches@lists.yoctoproject.org
Cc: gael.portay+yocto@gmail.com, =?UTF-8?Q?Ga=C3=ABl_PORTAY?=
 <gael.portay@rtone.fr>
References: <20240626133913.790145-1-gael.portay@rtone.fr>
 <20240626133913.790145-2-gael.portay@rtone.fr>
Content-Language: en-US
From: akuster808 <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; keydata=
 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
 ApZ86eOP
In-Reply-To: <20240626133913.790145-2-gael.portay@rtone.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 11:14:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/397



On 6/26/24 9:39 AM, "Gaël PORTAY via lists.yoctoproject.org wrote:
> The configure script checks for the utility python3.X-config to be in
> $PATH; that script is shipped by the package python3-native.
>
> The recipe does not depend on the package python3-native which causes
> the task do_configure to fail.
>
> The recipe inherits from the bbclass python3-dir that does not install
> the required script to the sysroot. The bbclass python3native inherits
> from (the already inherited bbclass) python3-dir and it adds the missing
> dependency to python3-native.\

Does this apply to master?

- armin
>
> This fixes the configure error by "upgrading" the inherit bbclass from
> python3-dir to python3-native.
>
> Fixes:
>
> 	| checking for python3.10-config... no
> 	| configure: error:
> 	| The program python3.10-config was not found in search path.
> 	| Please ensure that it is installed and its directory is included in the search
> 	| path. If you want to build sssd without python3 bindings then specify
> 	| --without-python3-bindings when running configure.
> 	| NOTE: The following config.log files may provide further information.
>
> Signed-off-by: Gaël PORTAY <gael.portay@rtone.fr>
> ---
>   recipes-security/sssd/sssd_2.5.2.bb | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sssd/sssd_2.5.2.bb
> index c07559c..fe82452 100644
> --- a/recipes-security/sssd/sssd_2.5.2.bb
> +++ b/recipes-security/sssd/sssd_2.5.2.bb
> @@ -33,7 +33,7 @@ CVE_CHECK_IGNORE += "\
>       CVE-2018-16838 \
>   "
>   
> -inherit autotools pkgconfig gettext python3-dir features_check systemd
> +inherit autotools pkgconfig gettext python3native features_check systemd
>   
>   REQUIRED_DISTRO_FEATURES = "pam"
>   


