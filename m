Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B290AC36002
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 00:04:16 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web11.54600.1742861053400715674
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Mar 2025 17:04:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=H3hV89bQ;
 spf=pass (domain: konsulko.com, ip: 209.85.166.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-855bd88ee2cso128814439f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Mar 2025 17:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1742861052; x=1743465852; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5trrRx6tYj1ViUzAbmVqQ9E/9UuYF6dJSxscAujA9w=;
        b=H3hV89bQ6uvKU3ocQ9t8NaoZxJIkSaulH7KsnyZkxQ5ACJWT/o9+dh+0HLu4GDF6YD
         NDr+wDyKxPkU1KeFlmzHULZvIKCfmi7cViWQOfkJ1n1u1UL2/KPy31Lg1JuynIOh3pMO
         qY5bra0dudO13GYzlNLKJ/IZ+DrrHR2d2VM5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742861052; x=1743465852;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5trrRx6tYj1ViUzAbmVqQ9E/9UuYF6dJSxscAujA9w=;
        b=cVubJSmNI0WrvFXuF1ZlKQHubVTo0N11MKrpusGahlz/rt1x/OJRPqUlEl26IWN9A3
         52jxeFE7y83yr4jqqOESCYbvr4kC3IM0rk5Jl0OPklxo1VRCzewH/Rf5KfnSxBGL7Frr
         qcFC2wGqXxPZPz3jfZHhxHeQojkXLdhvz9Nij+tZAVVwawV4MWQp/SHwvxxwi44Xw9PX
         AS7r4yUerifBGS999Wc5/XzjljRcZz4SEo4wWxXy9XFmnA4+AXEONj2NjVkW91mVbPhH
         OSS+dcKGQ9jIR4c0EDe2+bJgLWJkT29Q6xbV22r8ydiB4j1Vzz2cFZVL9oCO3nKImttS
         iBoQ==
X-Gm-Message-State: AOJu0YwO9lFcQAWs/zPbD8CYnXdXYNVP7Na/mtijk59Hr0SXYOwPjltl
	AzR7U7OdRUmj1X7+K9aDxEwjzIdItMLYBMWwlGSiHv5ZK+rwljAop96t63kD9swuClV8LTw1yr+
	5
X-Gm-Gg: ASbGncuU0b2wSZWZwz+JMr4boIS4e6TgnDTCPSchX836WVJ9wsSLezMiqLhYFRnRe5b
	r9z+u2NbqLtQHwt0WtavuVvEBmoyVaHaIHd91+zNTD1NgdHZzvCDjVgLO9iykQ8nEKpEljEmHNk
	9N026RqeteZ7T7Zx15reDNsDvGF1bjLlUpRpkPCWwmCWqQ9AKWF+laVLqIyweTpIUaCaXb1Ss1C
	LiFg3k6SWkwZ+NHPHXGmiK/xV1mi3w0TXGIdZ5RTinRdaK/qlDTjr9vsM9+dx9HI7Q2zfR4+a+i
	XV+xPuasqSbgwL+IWE2V2wru9OiBdYfjoDNe+pbVosDJ1VxZcAPqBurxlx6TYTk/a1Z2Hesb1Ad
	GFCU=
X-Google-Smtp-Source: AGHT+IFA8C6uXcQ7ElscboNCj9OZK9R8u0VFJWLiiJEhYUpNA699TXcUpO+G76XVtH3oSKZ48Yq3Xg==
X-Received: by 2002:a05:6602:4088:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-85e2cb417c3mr1726084239f.14.1742861052142;
        Mon, 24 Mar 2025 17:04:12 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbe80a2fsm2050890173.84.2025.03.24.17.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:04:11 -0700 (PDT)
Date: Mon, 24 Mar 2025 20:04:10 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: soumya.sambu@windriver.com
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
In-Reply-To: <20250318032001.2031160-1-soumya.sambu@windriver.com>
Message-ID: <d8e7feba-e083-300f-a82f-c483162da8e0@konsulko.com>
References: <20250318032001.2031160-1-soumya.sambu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Mar 2025 00:04:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1247

On Tue, 18 Mar 2025, Soumya via lists.yoctoproject.org wrote:

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

I'm not planning to take this, since carrying bbappends for recipes
outside of oe-core is outside of what I had planned to support with
the mixin.  If I take it, I will be signing up to test building those
recipes on every Rust update for at least the next year, and it would
somewhat open the door for people advocating doing the same for
scarthgap/rust, which has 3 more years to go.

Scott


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
>

