Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C45FC3ABBF
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 18:48:05 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.web11.3722.1746643679501603162
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 11:47:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=meCdsRgR;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4766cb762b6so2963411cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746643678; x=1747248478; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRZ1E1FuIc0FBJoBySdbZ3zSpfu3uDGJTPKVFCW6Fwo=;
        b=meCdsRgRS/tApjMSyzTsUP9+VIRxOnLxv5Z9FfZ2qW9GJslsl4venGKYU3GvmbYJxD
         jeNGo2HlDRjCjw9Vq4EhmuOCoI6n1V1AgukXmPrxsH+iO2i8q4TiTuh4swGgLsnuqK/v
         /Ve3vmGF6ySY2wtH2NjP1MFpdD+CBUFecKUTxHQp5T4iyX7RZs+wxV2kcm6y0pbL1Pip
         /qpa6Z71IGPouuTFe8Or7tKUgpckv7HzjGFKPpz6K83/L5OOIu876oGe7yEZbLhjUmvz
         n6bKKKq183zJnxfw9yvJaEmvD1DFx4xtxu/Zf0owE2Tbz+DWicP8n1qYkf4Q+ZEdKBEE
         RmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746643678; x=1747248478;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRZ1E1FuIc0FBJoBySdbZ3zSpfu3uDGJTPKVFCW6Fwo=;
        b=s4qF7vftNy5x3eJL2nuA2kCSAaCvwYwUPv19DYTCIDsvhxs8pCCnZvKWK4LJmYaDRb
         tgQtlmNP03qmSFIvqN02htb4ezfabWtAfJgzSh/aqgjiUAPe50JnAnaaS9b+W0B0MPgU
         YTevoSn2BMunUbz3yRJWT7jCZFkYYGKw7GaZTC4tUMl83b7FzSSEeIsd+SUA4mek7YAr
         gpU3xQC0wktOWOPB6mymnT+5xTkqbtEwifZ68wIsCD13iFVjAVi5KHVNXhH5m+qv+rrS
         FC5Bv96Ta8XAezT6Or+MJetlwyOXKvLDjPlrXVvQ3XdfFOzt+IVRXI98HSQ8LRXCOFHw
         T1aw==
X-Gm-Message-State: AOJu0YzzuziMRkfiQ51BPKkPLIKlY7NrXA9J8aiRZOxrenS6xkcKbb6J
	A+BNC619vgaAO5v49nRqBPdniwifsdmYctbfk8Ltzc++qUD7xsB3
X-Gm-Gg: ASbGncvaNk3dn1BbzG5JCHZGcwXknYDW+NgXIJmCPkIeHUrUEQxqDXOsZl8z/fvlgbd
	CuWeOGJK5+PIBAbR4envnq/S7HxjfG7TJ9eip4qqw90s+mCvQhipncB4DCGdDvwKshFNDxvuOr0
	CxgR0oxo3Vqsz9snQDZ0fSDU9ljpiC9VlDFBld9fdJYuPJIyHlY1qTHXivLrEIphqodoO6Rmy3m
	paSQSKnlS29QBMDd2zOGKqvi58BTmJxyDndlEYwP03YV8qKG6pWdflCcXpiPA9rJrBQpRcDB7JQ
	LlMlzbYgumcCBGol/egausOFsKP6oCRCAovdWwMwpmOGBrSS0//2ylnVbgcQ469ROZJWh5pdSJp
	IHv4=
X-Google-Smtp-Source: AGHT+IFwfZtqACl0YCnWmNqITeYaGr831cIaRw8TAgjPb9hRTvpu59sxW20PjyNszTS+WZipe94Pcg==
X-Received: by 2002:a05:622a:1a8b:b0:48d:2fa6:3876 with SMTP id d75a77b69052e-4944924ec4emr9640781cf.8.1746643678364;
        Wed, 07 May 2025 11:47:58 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49223457c57sm17678661cf.70.2025.05.07.11.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 11:47:57 -0700 (PDT)
Date: Wed, 7 May 2025 14:47:55 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: yocto-patches@lists.yoctoproject.org,
	Sathishkumar Duraisamy <sathishkumar.d.cbe@gmail.com>,
	Khem Raj <raj.khem@gmail.com>,
	Max Krummenacher <max.krummenacher@toradex.com>
Subject: Re: [meta-security][PATCH v2] systemd: disable linker GCS warning on
 aarch64
Message-ID: <20250507184755.GA21647@localhost>
References: <20250507150247.1408201-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507150247.1408201-1-mikko.rapeli@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 18:48:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1531

On Wed 2025-05-07 @ 06:02:47 PM, Mikko Rapeli wrote:
> openssl asm code is missing GCS branch protections and
> linker throws a warning which currently fails the build.
> Ignore the warning for now since some branch protection
> is still applied and only GCS is missing. Works around:

This only solves the problem for one specific use-case (i.e. when someone is
using meta-security) but leaves build issues for everyone else.

A patch that solves the root cause of the issue (in systemd) would be better.

> 
> .../recipe-sysroot/usr/lib/libcrypto.so: warning: GCS is required by -z gcs, but this shared library lacks the necessary property note. The dynamic loader might not enable GCS or refuse to load the program unless all the shared library dependencies have the GCS marking.
> collect2: error: ld returned 1 exit status
> 
> Cc: Sathishkumar Duraisamy <sathishkumar.d.cbe@gmail.com>
> Cc: Khem Raj <raj.khem@gmail.com>
> Cc: Max Krummenacher <max.krummenacher@toradex.com>
> Cc: Trevor Woerner <twoerner@gmail.com>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>  meta-tpm/recipes-core/systemd/systemd_%.bbappend | 3 +++
>  1 file changed, 3 insertions(+)
> 
> v2: switched from meson.build patching to LDFLAGS since that works
>     as suggested by Khem Raj and tested correctly by Trevor Woerner,
>     tested on genericarm64 machine with swtpm on qemu
> 
> v1: https://lists.yoctoproject.org/g/yocto-patches/message/1524
> 
> diff --git a/meta-tpm/recipes-core/systemd/systemd_%.bbappend b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
> index c53b1e8..deb9164 100644
> --- a/meta-tpm/recipes-core/systemd/systemd_%.bbappend
> +++ b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
> @@ -1,3 +1,6 @@
> +# workaround to GCS branch protection warning treated as error from openssl/libcrypto
> +LDFLAGS:append:aarch64 = " ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', '-Wl,-z,gcs-report-dynamic=none', '', d)}"
> +
>  PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'tpm2', '', d)}"
>  
>  # for encrypted filesystems
> -- 
> 2.43.0
> 

