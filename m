Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63FEC3ABCC
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 15:18:30 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web10.104604.1747235909875817155
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 May 2025 08:18:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=jj2mP3kn;
 spf=pass (domain: konsulko.com, ip: 209.85.160.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476b4c9faa2so98203401cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 May 2025 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1747235909; x=1747840709; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=482Kxgo2hMYlIJQq8xjH8mlqgZ74w5rmIv7Rop2x0Xg=;
        b=jj2mP3kn5TO3MhEXvF+b3BwUEbukk2UESvFDLi8rdqXKIbmJGEOjpyEwBDBz3eoUlx
         RssV2dZ2vPkebaOto5HIjzQYajq5OYYvVO88QHuUEB049aUbCbW0SCg9RsGGyOJEAZ/n
         cinEUNwC/2BzbFbLvcJVBKJZjz7InHmc2Ja3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747235909; x=1747840709;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=482Kxgo2hMYlIJQq8xjH8mlqgZ74w5rmIv7Rop2x0Xg=;
        b=iCxrH7dlg3Vu+GcF2FZdfdwblM4lyMxzSIZwjBksqlpj9IYl+uE+cAuhHWgOvMDknO
         CX//DTucPVa8rk5lRSMVBP5lJrkWq62IsVJLf6WSG/fnCj20mAa+1ssI/7D9biLvmvvs
         aZ2BdDihWlpShLmf6l29hL2g5XAHhQOC7bGi417iJ6ETVZ2xmSDJBuAgPgWiL4670rBn
         ZpYOGE4GFVuQrE8irWIdmUMtbZuk8pmt5umpDYiJbbStSj1pRx8jDNEmcuDJZe93Vqtb
         YBeE8MGBVG1J0sX9Mo5aPS0GyDA2TezVNWG/5gNPdz+K9ao59FmppdGb+OasoGXMMVh8
         K3Og==
X-Forwarded-Encrypted: i=1; AJvYcCUHManHDwu+Nfc4AmWBl7djYjv64ONWEjvvrk8LZbdGXCzdVUq1OD9Hz42RuubDhTsNCVgSULEe+i4UXGIO@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yy2OJ+c9TAna6jiqZtCIDS84c1DudyRCxUftaiVU+u81CW/mr9M
	mJhJUKdAgpgiVIJAFMKqaokUenML/m2dnvzyfY47uV5n5DBElrDXJypEqtfjGHw=
X-Gm-Gg: ASbGncu9yHzvffv5byQfVr84hLAgxS6T6mFDnjyR6BZKBZevSg5lEHsfV8myYKW9yeG
	7ew6SpOQcPsRbMvZWTUOQF2OAxMqOrJQS0PchAqysPiVN+A1bAZy38ii7TxwVqWrSy/Rd+Z6vZs
	Covb1dC3PHDeGWCkBDh8mmVauygCu5ymPQcNvmV+DEJexJREZFD3R6GnIOjc1pApipNt3ecNZ83
	XLKkVhfyZKW4n0D0XdvXOBpDDrWEOyBWExMAks6fiJH8fhy/3jLyabaUolHDQQSxgaighf5uoFz
	hjPGx3NbTQd4r1FE84zKOSXrVHhxC/7AbXORpsGWX3MCTC2RnG54YeYIvIpdQmJzmIBRYh+QoMD
	SBCVwgrVdoQ==
X-Google-Smtp-Source: AGHT+IGnYDC6WfxWxzrwNK6Wg6+3Q/jxweQPoLqcad41Xq28bvwnaY4VXF5j5eyhBX4ItNph+YrBlQ==
X-Received: by 2002:a05:622a:4a14:b0:494:7e91:eb4d with SMTP id d75a77b69052e-49495cf12ccmr60859081cf.51.1747235908684;
        Wed, 14 May 2025 08:18:28 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4945248e5basm80661761cf.32.2025.05.14.08.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 08:18:28 -0700 (PDT)
Date: Wed, 14 May 2025 11:18:10 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Sambu, Soumya" <Soumya.Sambu@windriver.com>
cc: "MacLeod, Randy" <Randy.MacLeod@windriver.com>, 
    "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH v2 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
In-Reply-To: <CY8PR11MB7921D1FEED911BA634CD53728191A@CY8PR11MB7921.namprd11.prod.outlook.com>
Message-ID: <1b7ac862-bdba-8517-610b-d9ee17930901@konsulko.com>
References: <183D29E6670EA629.16348@lists.yoctoproject.org> <CY8PR11MB7921D1FEED911BA634CD53728191A@CY8PR11MB7921.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 May 2025 15:18:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1556

On Wed, 14 May 2025, Sambu, Soumya wrote:

> Hi Scott,
>
> I have revised this patch according to the latest guidelines. Could you please let me know if any further work is needed?
>
> Regards,
> Soumya

Sorry for the delay, I have given it a quick test and merged it to
kirkstone/rust just now.

Scott


> ________________________________
> From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org> on behalf of Soumya via lists.yoctoproject.org <soumya.sambu=windriver.com@lists.yoctoproject.org>
> Sent: Wednesday, May 7, 2025 11:41 AM
> To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org>
> Cc: MacLeod, Randy <Randy.MacLeod@windriver.com>
> Subject: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH v2 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
>
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
>  README.md                                          |  2 +-
>  conf/layer.conf                                    |  4 ++++
>  .../recipes-devtools/rust/rust_1.85.1.bbappend     |  7 +++++++
>  .../recipes-extended/mozjs/mozjs-78_%.bbappend     | 14 ++++++++++++++
>  .../recipes-extended/mozjs/mozjs-91_%.bbappend     | 13 +++++++++++++
>  5 files changed, 39 insertions(+), 1 deletion(-)
>  create mode 100644 dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappend
>  create mode 100644 dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend
>  create mode 100644 dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend
>
> diff --git a/README.md b/README.md
> index 482f0cd..f05accf 100644
> --- a/README.md
> +++ b/README.md
> @@ -132,4 +132,4 @@ Layer maintainers:
>  Scott Murray <scott.murray@konsulko.com>
>
>  Dynamic layer support maintainers:
> -TBD
> +Soumya Sambu <soumya.sambu@windriver.com>
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 281eeca..4fe4ec4 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -26,6 +26,10 @@ BBMASK:append = " meta/recipes-devtools/cargo/ meta/recipes-devtools/rust/ meta/
>  # the newer BBCLASSEXTEND version that we carry.
>  BBMASK:append = " meta/recipes-devtools/python/python3-setuptools-rust-native_%"
>
> +BBFILES_DYNAMIC += " \
> +    meta-python:${LAYERDIR}/dynamic-layers/meta-python/recipes-*/*/*.bbappend \
> +    openembedded-layer:${LAYERDIR}/dynamic-layers/openembedded-layer/recipes-*/*/*.bbappend"
> +
>  # These are in bitbake.conf in langdale and up, adding them here to make
>  # using the layer more turn-key seems reasonable.
>  BB_BASEHASH_IGNORE_VARS:append = " RUST_BUILD_SYS RUST_HOST_SYS RUST_TARGET_SYS"
> diff --git a/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappend b/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappend
> new file mode 100644
> index 0000000..9b09f9e
> --- /dev/null
> +++ b/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappend
> @@ -0,0 +1,7 @@
> +python do_configure:append() {
> +    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD}")))
> +
> +    with open("config.toml", "w") as f:
> +        f.write("change-id = 116881\n\n")
> +        config.write(f)
> +}
> diff --git a/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend
> new file mode 100644
> index 0000000..8e8c24a
> --- /dev/null
> +++ b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend
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
> diff --git a/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend b/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend
> new file mode 100644
> index 0000000..c0214b0
> --- /dev/null
> +++ b/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend
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
> --
> 2.40.0
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1521): https://lists.yoctoproject.org/g/yocto-patches/message/1521
> Mute This Topic: https://lists.yoctoproject.org/mt/112663754/7320427
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14043740/7320427/1891404428/xyzzy [soumya.sambu@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>
> pLK@tY:ATbOf1"dW
>

