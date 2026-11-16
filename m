Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30125.1794841877669075152
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 07:11:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=ViyuZFBH;
 spf=pass (domain: gmail.com, ip: 209.85.161.43, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-70b875f6f13so3797519eaf.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 07:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794841877; x=1795446677; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2EJJwIUj6tJdGMBRlr7L9y1wW0NcVB5Tuk5qLq81/U=;
        b=ViyuZFBHz52ntwzsgv8B6tMV61gXaRfzg/USfij8j3DRbmI6Uq/pdV7vlOjZ+Zh7LM
         kfDHFDTllJsdsKo8vQgYECe1DYez+5ECk6SNfofTq9Kse60L17ihx8loJIahVjc65cyo
         83MHtPwLqdKLPSYj1rnY3ljJhFb9XVZfAPouPLSin0d74e1x9BYEYH5fMZLdMJGQQFjU
         85eYrBFBbyb0cmpl792xYldbdJkiwwRFf2bdnQdOzQp76tqDBlT3F/gAVLXxGMTfh2z4
         Qo7oaVf2VxKR50ut109NlOdYj0F79xqlqHawIJBL1KFiEYZ4Dq2ED4Ccf86d8qOEZAk6
         xRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794841877; x=1795446677;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O2EJJwIUj6tJdGMBRlr7L9y1wW0NcVB5Tuk5qLq81/U=;
        b=brNcP9xmTcjxWyDYPD0hPnr2j+Vok6owUgxOYK81uXlwOrY/FLeAO5+s1NKbZlBak7
         xkojXe/iLZidv/VdazgOC21I0S6NsXN2qZ5vktGKiY/NRrCk/8ZL0zwkF2/2GysHtpRW
         Z3QY2vA/UnsQunNieN+mPsUpOY/qlX28Y7CWmKiZTRc30oHkVykdPvFEdPiosIN59m92
         3CnUdd/gs7rpHPOpif2qreK6A3YLxFq9+thRVnTY7VVA3VFyZYzwOtvu7kuLH0OyKQIC
         UfIQpK8bSyP7KbXuRYsKFLE2hAZxgUkxYcB2M3Ypp+RVy9zBAaOCYslOQGBNdbSVMNff
         csLg==
X-Forwarded-Encrypted: i=1; AL+hErExo66VVGz8x9xi/PhukUO/IDNvVzVekk36PbEO4DziFij6zrG3NYQsgF5RzQqV5RqX83an4sKXts9Q9F5N@lists.yoctoproject.org
X-Gm-Message-State: APuU4Z9/02JRGs+1zh3W0Sp31hup5TlxYHgfvP2RsnsSg0RWwrrsXg4P
	ngA+LlNB1WewVuS7HHVblxGzFFW0vMqZ3hXenNRHJWfvVJfYoBQJIJkL
X-Gm-Gg: AYBFou3fhsZQLtYvC2tyf1+LsOpxizlECzNE1XPvnpMifehjv16Zahu+dGsacgsgPEf
	ghWICtps+OVbCdb40mDJH6XR1b3DKm7gl2iwAsQcD+1uPIMbTFm6f4/gJhvhVr4r5DRiEM38tb2
	0RopRoJr4Zpwae3KTMeoEyLJ5n4v78OK7YCC6rinWDmR987Wk8xMAiyDvBJo2t8rCV7+AtaV+EG
	DPfBk4r7gir3eYgQAAc9cXS++nkwjC7gb2Z+gymbOkHV+qinUADmEA+S6VxGLXDYB/HepE34PUY
	wU5wTxGLs0waQVebv5TprCIG5o9dARA7/X+uxCRnSNfd9yycA4uGFHFO4FdiyIrJcu/T+XZ2bFF
	dsEEFo4cRFkzK1uiHYPPO5beVdCixCSuOjFnlWIwUCfWn2p+fyQn5cVZ44pJSYO8+LpqmQhVCsI
	jBzYC4PckNSchHGiY2ZDK04mz2ze6dOHrl48QFTCdpQPrBzM8TEuAojdm29JatXCdJYocCZr71L
	m8ivumyxp4uY2Sqm5rfi4gQeeYswuDVB4esNOyKgMCS0GmhDXRelNmT9bCHe1S+/Me+l/jv5pTZ
	IHw64F12GEG2zrL5RvN4pVjK+S/TBhwaGvGng2G3VZX68FUK88P0
X-Received: by 2002:a05:6820:3382:20b0:700:52ae:7e48 with SMTP id 006d021491bc7-71ab507b913mr5079519eaf.47.1794841876754;
        Mon, 16 Nov 2026 07:11:16 -0800 (PST)
Return-Path: <majortomtosourcecontrol@gmail.com>
Received: from [172.26.252.72] ([73.229.151.109])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab4335912sm8630316eaf.13.2026.11.16.07.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 07:11:15 -0800 (PST)
Message-ID: <ac2f592c-a707-4bad-ac36-3f003ba449a5@gmail.com>
Date: Mon, 16 Nov 2026 08:11:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 3/6] refpolicy_common: ensure we start
 from a clean state in do_compile
To: Chen Qi <chenqi_hycx@cetc.com.cn>, yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
References: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
 <20261116025620.2558594-4-chenqi_hycx@cetc.com.cn>
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
In-Reply-To: <20261116025620.2558594-4-chenqi_hycx@cetc.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:11:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5408

Hi, Qi

>@
> The `bare` make target is to "delete all remaining generated files,
> including modules.conf, and booleans.conf."[1]
>@
> If we don't do 'make bare' at the start of do_compile, legacy build
> artifacts such as booleans.conf, generated_definitions.conf, etc.
> will remain there, making the building results unexpected.

This may be the correct thing to do but would likely break my current
workflow.

In a private layer, I keep a "booleans.conf" that I apply via 
do_configure:prepend.

Thanks!

Clayton Casciato
