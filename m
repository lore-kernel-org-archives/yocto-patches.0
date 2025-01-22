Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04735C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 20:59:37 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
 by mx.groups.io with SMTP id smtpd.web10.4891.1737579568070211966
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Jan 2025 12:59:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=iREMshHu;
 spf=pass (domain: konsulko.com, ip: 209.85.166.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a8165cfae8so597805ab.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Jan 2025 12:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1737579567; x=1738184367; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnwgmtVW1e7UP/L57g4daOSFJfV5IgIlopSWotX6U8o=;
        b=iREMshHu9NevSRhU0i9Ue1EQSLmBnlr7bMkpKeM4YOefro/jAeB/2X2+SP6flxMxCd
         Joma0azs5FLUKWRynWN5aw6z4BaJfYMlcF6FhEArjbthHe6HHIPOkuwVrphHDtacHSEj
         9S2s//9kmhEmOBXrz4CZncU0YiFu0QobHHE+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737579567; x=1738184367;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnwgmtVW1e7UP/L57g4daOSFJfV5IgIlopSWotX6U8o=;
        b=EpnD5bK4hrCBPpXYY0qNvkbTKzDA95rixvNwpSjE9Y15DuI9U3PjwGUUXGvJ078b0N
         uJ0lReMbU3YYOIyfgAs1N3X8ZefnyxT6/5iDdJJNq/ePo0ZgKzVwbUEg2HKCNaYvFvMO
         zUwVriLR2PsPWUPIrSufINPVkmgdanbUwKL9p1EOO4aPpyAR5Tu9JUpQai6e+5Jhecj8
         DtiVvkwLX7dM6GZN1Vpc/ATMyPRDxNf+3JZGNFaIbVHNURlcTQrT5JdsHygnLTw+yK0L
         /ClqRt8RboBwDFHv11QvQSbL4fD4GtpaU4QtQkl1roJWKBqLMDbvnV2DOFsA7s6HaZTu
         A+Bg==
X-Gm-Message-State: AOJu0Yx6L0OFkoxohSoR2MVdnLBeuamfvZ86zx4hcT7qSHWjCg3/9CZt
	kwVXvWGA3g2iYn1zX15BJDKCB7dtrY2fC+geg6f7P6FQbedHrKyAt5e9zwa2mC2kVSIPCJISl1R
	J
X-Gm-Gg: ASbGncsz9QehDI+UjcRG1LS9Jl45YnraSSWineltKubukcxRQwn6vcDd5m12yssGzQ2
	8b858EU0rwY9uu2U3ElZ0qFUev+hgIRznwPrfpzFCQZE6DBSKMGGocEC2Xkl3XdeIMONbHidITV
	xsr3azlgNkV2m5CRcc8Lcw9z/2OKQGgWI1+mOy86KjlPCTCVJZDFonD2Umzyr+0NlgXu6dhhuxv
	gyxjZaxToaes1RN0dWPmqUwAtrTkzu20UE4bcctnZU8OWviMew5cyO5ksC9+/cc1qTsuv0kww6s
	HfNBb01TVqLe7Uz3VG7WWkPpHMeM
X-Google-Smtp-Source: AGHT+IECBXGd/GkjX5KriSVLHns87VGk/mlLI2ja4XJdpWyILdzRgfe5AxX6dBYZFgk4j0MUZyppEw==
X-Received: by 2002:a05:6e02:b24:b0:3ce:7ae7:a8bb with SMTP id e9e14a558f8ab-3cf743e9870mr159372495ab.6.1737579567181;
        Wed, 22 Jan 2025 12:59:27 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea7549a1c1sm4371704173.73.2025.01.22.12.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 12:59:26 -0800 (PST)
Date: Wed, 22 Jan 2025 15:59:25 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-lts-mixins][scarthgap/rust][PATCH] rust-cross-canadian:
 use correct ${S}
In-Reply-To: <20250121092252.1123704-1-enrico.scholz@sigma-chemnitz.de>
Message-ID: <5ff6d7ed-be55-be22-817a-7996b7c8f338@konsulko.com>
References: <20250121092252.1123704-1-enrico.scholz@sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Jan 2025 20:59:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1003

On Tue, 21 Jan 2025, Enrico Scholz wrote:

> From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
>
> Porting back the UNPACKDIR changes broke do_install()
>
> | + x86_64-oesdk-linux-gcc .../rust-cross-canadian-arm/1.80.1/rust-cross-canadian-arm-1.80.1/target-rust-ccld.c: No such file or directory
> | compilation terminated.
>
> Set $S to the expected value.

I remember looking at this, and thought I'd addressed it, but seems not,
good catch.  I have merged this and the classes-recipe fix to
scarthgap/rust, as well as re-enabling the one selftest that I had
disabled, as it now passes with the backported rust-target-config.bbclass
actually getting picked up.  I plan to look at backporting 1.81.0
tomorrow.

Thanks,

Scott


>
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> ---
>  recipes-devtools/rust/rust-cross-canadian.inc | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/recipes-devtools/rust/rust-cross-canadian.inc b/recipes-devtools/rust/rust-cross-canadian.inc
> index ea21e8a..af9f2d6 100644
> --- a/recipes-devtools/rust/rust-cross-canadian.inc
> +++ b/recipes-devtools/rust/rust-cross-canadian.inc
> @@ -13,6 +13,7 @@ DEPENDS += "virtual/${SDK_PREFIX}gcc virtual/nativesdk-libc virtual/nativesdk-${
>
>  SRC_URI += "file://target-rust-ccld.c"
>  LIC_FILES_CHKSUM = "file://target-rust-ccld.c;md5=af4e0e29f81a34cffe05aa07c89e93e9;endline=7"
> +S = "${WORKDIR}"
>
>  # Need to use our SDK's sh here, see #14878
>  create_sdk_wrapper () {
>

