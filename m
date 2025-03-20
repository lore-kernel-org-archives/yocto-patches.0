Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F60C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 19:23:14 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.3592.1742498587536987441
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Mar 2025 12:23:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AQJbNm2e;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: skandigraun@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf3d64849dso210532366b.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742498586; x=1743103386; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ollW+L+eanQwDQpxHwBwNrx8ujqmsQGhvVxYfHk9klo=;
        b=AQJbNm2eS4kNE0MzgNcuat4+bZ79gKWDf8HgPYdQVIoJHgzsQI5IqZ1mHCJPdQ2crL
         gL+cdCIsnk27Vhp2LDEo43qE93Sxp4pEhYlHH0dCBRPeEDmvYIfyryxAzYomK0fKB0QL
         cdmjvAYu7Rieob5lfGQk4NwljZqRL7LY3UuZXLNLBcuZpzW/JKt9UV9eUvXUa10r2Km5
         EDjcJxtmtz8brSJoWoGcGDYZI7ewlx4ChndS3cwONImofO49nKUYt2vurXwqY7Coeiit
         uA2k4goLtfu+ZfUvjNw80ayoCQT7a5HpcFgNdmo891KkC2M8mHFwglvRMDPFqtR+k+Po
         1ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742498586; x=1743103386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ollW+L+eanQwDQpxHwBwNrx8ujqmsQGhvVxYfHk9klo=;
        b=br0Zi+qzQvD9KKcCmeecUQ5+2NzCtZs9AFCdfU0i5pYEM94jYf1+272GH5Rq84ryJo
         kwdrceTDD1jbaEc80o118/o9uzfAt8jl+I4HK0V5jRqKhLSpIqMuRQJOqy4xfl+uB+N9
         ehakHV+iifwU9E2OO7OQwqQh4sszOOMsSJidRI0Is32G8mrgawBjkhD+Z9qD3utKIxOY
         HELprDI/IHKD5tGi7SJ8PmVgnU1GsdizBgPmbu8kM9/DzjE8VpEQHfoAkN7mrIHoNMkU
         x0MFSRMPN1s6ANhKt8PKyWYL/qUBO9rApoFj8I4NscJmFzdXvLjaHpaGVq/catJb3tWm
         pVDg==
X-Gm-Message-State: AOJu0YwKH4e9k7fwuwWZvyXjuHsBbdoehmO1/ZKDm2G+jVK6lVfGRQlf
	vGs8Ceac3JN+vDSU8o3qGUHg/MB2vIquQH0vqAfZf6z+7Y/XgCaayusv8A==
X-Gm-Gg: ASbGncs+D8q1gRExc3EndREr/zyTKplb6wM5FW7ZeLZzMVUaWtTs8DzVWTf/xsFax+E
	ZFNfwoVT9dKzNTjES8AAWhVfYcSQWw2ndWgpLELwY+mNWJYo2jPeGvCRfjISEUHACubfN6lsTk8
	q1pH/C6P5ciwbfqzjwVPBAsFIy4i8WZyzk/QTfGvEY8QfIc4DJhVpc7wEJYFpBiG/RK+IQyj1Dr
	ouG1Vu2KB6gJDg8MAmqcpjuZMREtTnrpEGtWj3hD93Dp0C/f43mV4gzC4vSFlBsyAN5x8cIJR2c
	u14f3Wz14/oClBkE4haV85ERFN+U5xAAhc6ZbZhaORh6BhXpmw==
X-Google-Smtp-Source: AGHT+IGiRKC2EksLEIsfJNQyN/d7y+YtOcZ30FrmozjUwthN8gx50w27hM6WmoiQgl/HDderJ7HIZA==
X-Received: by 2002:a17:907:72c5:b0:ac3:2368:9a12 with SMTP id a640c23a62f3a-ac3f24f6d46mr31342366b.27.1742498585448;
        Thu, 20 Mar 2025 12:23:05 -0700 (PDT)
Received: from [192.168.1.2] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd24f6esm24250666b.154.2025.03.20.12.23.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 12:23:05 -0700 (PDT)
Message-ID: <f9b09bf2-9e71-445c-93b9-8fe486a2d71f@gmail.com>
Date: Thu, 20 Mar 2025 20:23:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
To: yocto-patches@lists.yoctoproject.org
References: <20250318032001.2031160-1-soumya.sambu@windriver.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250318032001.2031160-1-soumya.sambu@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 19:23:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1236

I think these files should be in dynamic-layers folder, as rust-mixin
depends only on oe-core. Otherwise it will complain about dangling
bbappends if meta-oe and/or meta-python layers are not present.

Maybe meta-oe would be an even better place for these  bbappends, also
in dynamic-layers folders, depending on this mixin layer. (Though that
part is just an idea)

On 3/18/25 04:20, Soumya via lists.yoctoproject.org wrote:
> From: Soumya Sambu <soumya.sambu@windriver.com>
> 
> The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=${HOST_SYS} and
> --target=${TARGET_SYS} respectively, which leads to an error when using Rust from meta-lts-mixins:
> 
> error: Error loading target specification: Could not find specification for target "x86_64-poky-linux".
> 
> Updated target configuration to resolve this.
> 
> Additionally, `mozjs-78` encountered "linker 'cc' not found" error. This was fixed by explicitly
> defining the linker for Rust.
> 
> Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
> ---
>  recipes-devtools/rust/rust_1.81.0.bb       |  3 +++
>  recipes-extended/mozjs/mozjs-78_%.bbappend | 14 ++++++++++++++
>  recipes-extended/mozjs/mozjs-91_%.bbappend | 13 +++++++++++++
>  3 files changed, 30 insertions(+)
>  create mode 100644 recipes-extended/mozjs/mozjs-78_%.bbappend
>  create mode 100644 recipes-extended/mozjs/mozjs-91_%.bbappend
> 
> diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust/rust_1.81.0.bb
> index cc00053..2d91d68 100644
> --- a/recipes-devtools/rust/rust_1.81.0.bb
> +++ b/recipes-devtools/rust/rust_1.81.0.bb
> @@ -146,6 +146,9 @@ python do_configure() {
>      # harness are debuggable just from logfiles
>      config.set("rust", "verbose-tests", e(True))
>  
> +    # Override default linker cc.
> +    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD}")))
> +
>      # [build]
>      config.add_section("build")
>      config.set("build", "submodules", e(False))
> diff --git a/recipes-extended/mozjs/mozjs-78_%.bbappend b/recipes-extended/mozjs/mozjs-78_%.bbappend
> new file mode 100644
> index 0000000..8e8c24a
> --- /dev/null
> +++ b/recipes-extended/mozjs/mozjs-78_%.bbappend
> @@ -0,0 +1,14 @@
> +EXTRA_OECONF = " \
> +    --target=${RUST_TARGET_SYS} \
> +    --host=${BUILD_SYS} \
> +    --prefix=${prefix} \
> +    --libdir=${libdir} \
> +    --x-includes=${STAGING_INCDIR} \
> +    --x-libraries=${STAGING_LIBDIR} \
> +    --without-system-icu \
> +    --disable-tests --disable-strip --disable-optimize \
> +    --disable-jemalloc \
> +    --with-system-icu \
> +    ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', "--enable-gold", '--disable-gold', d)} \
> +    ${JIT} \
> +"
> diff --git a/recipes-extended/mozjs/mozjs-91_%.bbappend b/recipes-extended/mozjs/mozjs-91_%.bbappend
> new file mode 100644
> index 0000000..c0214b0
> --- /dev/null
> +++ b/recipes-extended/mozjs/mozjs-91_%.bbappend
> @@ -0,0 +1,13 @@
> +do_configure() {
> +        cd ${B}
> +        python3 ${S}/configure.py \
> +        --enable-project=js \
> +        --target=${RUST_HOST_SYS} \
> +        --host=${BUILD_SYS} \
> +        --prefix=${prefix} \
> +        --libdir=${libdir} \
> +        --disable-jemalloc \
> +        --disable-strip \
> +        ${JIT} \
> +        ${ICU}
> +}


