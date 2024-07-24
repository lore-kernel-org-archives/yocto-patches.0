Return-Path: <jpuhlman@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07452C3DA63
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 22:35:43 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web10.23404.1721860537667054751
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jul 2024 15:35:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=aqMIOhJJ;
 spf=pass (domain: mvista.com, ip: 209.85.210.177, mailfrom: jpuhlman@mvista.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso257249b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 15:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1721860535; x=1722465335; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/kt9i3ThVWeHCeHY9wdYB9lQnCHB6U5F2Vy7daY8R/E=;
        b=aqMIOhJJH06d0pDNvYZy8mcDO3UFLVk67lQtXPPRL9TuPKe6uFjRKof01XTcA3oCqK
         GbSfPXi/LTdmu8EZ4kTYrKYsCkuR2yHeOOIyvQAcwQxIxuxWOxn4AvsP6mw+vkei6cTM
         NB0s3C+Jp6jUsLqnpJzPBHQSCVV7PeEzwq/iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721860535; x=1722465335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kt9i3ThVWeHCeHY9wdYB9lQnCHB6U5F2Vy7daY8R/E=;
        b=UscCe02WOHpP/H0AEo9R2rZLs+pVqxoqEzEuCx4/7Q6cgkibWnssDw3R60Fv7Gznz1
         fktnzkXRSTAr6XIiMULq+hDFqlV5UNIyXA18+DlXkE0xbkMvgWlwEBns1WaatPmxm/o1
         A9i7pOCmVrHP8htfrXHs3AKzbrnq0vM5cxxV50bmcFvUlctJaHC4g98KR5uX6XlPQp86
         dGB3Gp66UfZiH6ESJ+XFoetFY3ROHRY1hedcKGV37iEE5rpXVWPUQlffywDgX35yk7ol
         X0bP2/Vdzt1h/5U/TuvV7y6wVxYEO3OzylqC2XN+prbaTjcPlkJ4cLB7cIn1h4UWIc7U
         8cZQ==
X-Gm-Message-State: AOJu0Yz+x/d4nzGCA7n2n2yBBDaov1EJXwDHgUQdqgHklaEBU1j+WJek
	QdsY5aQHuVBeVj9vbcq8mD31lu/ijBfWW+FhdOjcsePz5RUs/XnUi2Yg9slvVzLoVkF9cmcF3On
	X
X-Google-Smtp-Source: AGHT+IFVvjSasAOzN91vaOukJIeoV4oS2Jqasg7ojviLsgD9o1k2tvYWDsw9RYPexL5162qL7pUGOg==
X-Received: by 2002:a05:6a00:4616:b0:706:65f6:3ab9 with SMTP id d2e1a72fcca58-70eaa90a183mr1063148b3a.20.1721860535236;
        Wed, 24 Jul 2024 15:35:35 -0700 (PDT)
Received: from [192.168.1.9] (99-14-97-149.lightspeed.frokca.sbcglobal.net. [99.14.97.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead712f1asm67521b3a.61.2024.07.24.15.35.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 15:35:34 -0700 (PDT)
Message-ID: <da18e2d9-48a1-45ca-b5bc-5b96304b2816@mvista.com>
Date: Wed, 24 Jul 2024 15:35:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-cgl][PATCH] pacemaker: remove remote
 resource agent from pacemaker-remote
To: yocto-patches@lists.yoctoproject.org
References: <20240723155945.1705212-1-mathieu.dupre@savoirfairelinux.com>
Content-Language: en-US
From: Jeremy Puhlman <jpuhlman@mvista.com>
In-Reply-To: <20240723155945.1705212-1-mathieu.dupre@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 22:35:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/454

Merged.
Mathieu you need to fix your sendemail.from. I fixed it, but
the yocto git server rejects the list default from line.

Thanks!

On 7/23/2024 8:59 AM, Mathieu Dupré via lists.yoctoproject.org wrote:
> The remote resource agent should be packaged with the other ocf files
> in the pacemaker package. This file is not used by pacemaker-remote but
> by pacemaker to connect to the remote.
>
> Signed-off-by: Mathieu Dupré <mathieu.dupre@savoirfairelinux.com>
> ---
>   meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb b/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
> index c3fdff3..49d741e 100644
> --- a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
> +++ b/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
> @@ -111,7 +111,6 @@ FILES:${PN}-cluster-libs = "${libdir}/libcrmcluster.so.*"
>   RDEPENDS:${PN}-cluster-libs += "libqb"
>   FILES:${PN}-remote = "${sysconfdir}/init.d/pacemaker_remote \
>                         ${sbindir}/pacemaker_remoted \
> -                      ${libdir}/ocf/resource.d/pacemaker/remote \
>                        "
>   RDEPENDS:${PN}-remote += "libqb bash"
>   FILES:${PN} += " ${datadir}/snmp                             \

-- 
Jeremy Puhlman
jpuhlman@mvista.com


