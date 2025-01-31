Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F778C0218D
	for <webhook@archiver.kernel.org>; Fri, 31 Jan 2025 10:05:40 +0000 (UTC)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
 by mx.groups.io with SMTP id smtpd.web10.16231.1738317933085038819
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jan 2025 02:05:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qHwIoz7s;
 spf=pass (domain: konsulko.com, ip: 209.85.166.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ce7c4115e8so9065515ab.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jan 2025 02:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1738317932; x=1738922732; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHRkl9ShfnT0aOafkLchS5mNQYUG0/YaTrytc+/85cI=;
        b=qHwIoz7sJzybOGNP6mEoc6HJ3U9amw7xeejVWKJRgB1VerLOCX3qDmncV9EUR+/10I
         ToWDoJKVac73kBa79HlOvlPkd7qwBwKBv/wKNq/Amz54XccQu6z5H1ucyvsgLOVNO6lo
         1ju26TU/No45Jibvb5BDWP+8+FsUw7uzJRz/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738317932; x=1738922732;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHRkl9ShfnT0aOafkLchS5mNQYUG0/YaTrytc+/85cI=;
        b=k83AZk2npMeoM2GeW1uJxCtJmiziSQEx5wLzzwca6mhiXGa7cO4HeLHqHtnO5q3q5p
         vP2I4tlLbZ2mvLN2HDSPUeg3jW9f3A0igQaAQ9OaVHtj1Y4D5YGLS8A947gr4bZHhMIF
         j0sDouGs8DkQQahq1vmb2eDm1TRNJmq+Qq6zQqqAPlXz+5421dnRCvwazs4xZTUgA84w
         8pzO2nEMI/q56qg80NiEiq5M7nmzsIl1cxHX96Z5hJ6T1Tnr+ualNjz46Zh3FSpGTckg
         MS/XLSCqw+BIc2jeF+BRKjAeXQkNwyEUpq5xoZAynsrQLv61bFr/UmelmJX2Gy7YXu+N
         cPkQ==
X-Gm-Message-State: AOJu0YykjvZsc9IaxcBmFdsniCH2V9gyyQFihiVThkU/XSHPTu+KJqVF
	V8bm4Cepjp4BhYoLU3ay+1hI5P0/DLHDXAF0bSKGiQkTYJsD+I0Vga0rBR+tpqlh5FtXVN9UUvo
	XeSE=
X-Gm-Gg: ASbGncvsQT8HYbO5bsvUFS9olxYsq2jBWZcZvp18UwXkd60bIaZWu2Q9TulVcYk1E/L
	fR6UVK+AIsrWYtvO+jWdu4Le/KNTKXO/cRaeLmrRsEbNYOaXEjsJ5APgjKyKhptCM12w2V+pDJp
	XYGCW17nVsbug6wAL4ClaeSEpS76rB7ZBDAsncHvM41z6X5TfTta81e9ALlz05sv315ctZX99Qf
	PsgV3Z0ZGBMK0Uozsg3ebOdtOd5GlikP7J6vtPlD49WXMzX4RJOmbYpPHqUf1lCzjffWq9kUv40
	z1t7zLQcOlhsYp2LmkdnvJEQxWwnd+dRSiKlhT8rJ/VMnz4W3g==
X-Google-Smtp-Source: AGHT+IG9ixGTLH78bFWHoD0KsSGBVKYv3i007UT9NHomQLhThjCcZvUBZo6JFtFcyuBEcvYx942BUA==
X-Received: by 2002:a05:6e02:1886:b0:3a9:cc7f:2bc5 with SMTP id e9e14a558f8ab-3d012a09256mr25172605ab.3.1738317931550;
        Fri, 31 Jan 2025 02:05:31 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec745b4978sm748103173.40.2025.01.31.02.05.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 02:05:30 -0800 (PST)
Date: Fri, 31 Jan 2025 05:05:29 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 0/9]
 Update to Rust 1.81.0
In-Reply-To: <181F3C2F1CCF81C3.31881@lists.yoctoproject.org>
Message-ID: <f78f06e0-5784-8d86-b92c-4c1879200bd5@konsulko.com>
References: <181F3C2F1CCF81C3.31881@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jan 2025 10:05:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1025

On Wed, 29 Jan 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the scarthgap/rust mixin layer backports the
> various Rust toolchain changes in oe-core master to to pull in the
> 1.80.0 -> 1.80.1 updates that have landed in the last few months in
> oe-core.  At this point the backported selftest (as the "rust_mixin"
> module) is passing in my environment.
>
> I intend to push this series to scarthgap/rust within 24 hours
> unless a serious showstopper is pointed out.

I have gone ahead and merged these changes to scarthgap/rust.

Scott

> Changes:
>
> Adrian Freihofer (1):
>   rust: increase test timeout again
>
> Alexander Kanavin (4):
>   cargo.bbclass: do not install libraries by default
>   cargo-c-native: update 0.10.3 -> 0.10.5
>   cargo-c: convert to target recipe
>   librsvg: update 2.58.2 -> 2.59.2
>
> Deepesh Varatharajan (3):
>   rust-target-config: Update the data layout for x86 , ppc , riscv64 ,
>     aarch64 and loongaarch64 targets.
>   rust: Fix for duplicate libstd.so
>   rust: Upgrade 1.80.1->1.81.0
>
> Enrico Scholz (1):
>   rust-common: add LDFLAGS to 'build-rust-cc' wrapper
>
>  classes-recipe/cargo.bbclass                  |   8 +-
>  classes-recipe/rust-common.bbclass            |   2 +-
>  classes-recipe/rust-target-config.bbclass     |  18 +-
>  conf/layer.conf                               |   2 +-
>  recipes-devtools/rust/cargo-c-crates.inc      | 478 ++++++------
>  ...81.0.bb => cargo-c_0.10.5+cargo-0.83.0.bb} |   5 +-
>  .../rust/{cargo_1.80.1.bb => cargo_1.81.0.bb} |   0
>  ...te-host-information-into-compilation.patch |  51 --
>  .../rust/files/hardcodepaths.patch            |  46 --
>  ...crease-timeout-in-process-sigpipe-ru.patch |   2 +-
>  ...epro-issue-fix-with-cc-crate-hashmap.patch |  53 +-
>  .../rust/files/zlib-off64_t.patch             |  14 +-
>  ...ibstd-rs_1.80.1.bb => libstd-rs_1.81.0.bb} |   0
>  ....80.1.bb => rust-cross-canadian_1.81.0.bb} |   0
>  ...ust-llvm_1.80.1.bb => rust-llvm_1.81.0.bb} |   0
>  recipes-devtools/rust/rust-snapshot.inc       |  78 +-
>  recipes-devtools/rust/rust-source.inc         |   4 +-
>  .../rust/{rust_1.80.1.bb => rust_1.81.0.bb}   |   2 +
>  recipes-gnome/librsvg/librsvg-crates.inc      | 682 +++++++++---------
>  ...-rust-target-to-cargo-also-when-not-.patch |  44 --
>  ...r-meson.build-do-not-look-for-gdk-pi.patch |  28 +
>  ...ot-force-disable-introspection-and-v.patch |  34 +
>  .../librsvg/disable-rsvg-loader-test.patch    |  40 -
>  .../{librsvg_2.58.2.bb => librsvg_2.59.2.bb}  |  38 +-
>  24 files changed, 801 insertions(+), 828 deletions(-)
>  rename recipes-devtools/rust/{cargo-c-native_0.10.3+cargo-0.81.0.bb => cargo-c_0.10.5+cargo-0.83.0.bb} (69%)
>  rename recipes-devtools/rust/{cargo_1.80.1.bb => cargo_1.81.0.bb} (100%)
>  delete mode 100644 recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-into-compilation.patch
>  delete mode 100644 recipes-devtools/rust/files/hardcodepaths.patch
>  rename recipes-devtools/rust/{libstd-rs_1.80.1.bb => libstd-rs_1.81.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.80.1.bb => rust-cross-canadian_1.81.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.80.1.bb => rust-llvm_1.81.0.bb} (100%)
>  rename recipes-devtools/rust/{rust_1.80.1.bb => rust_1.81.0.bb} (99%)
>  delete mode 100644 recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch
>  create mode 100644 recipes-gnome/librsvg/librsvg/0001-gdk-pixbuf-loader-meson.build-do-not-look-for-gdk-pi.patch
>  create mode 100644 recipes-gnome/librsvg/librsvg/0001-meson.build-do-not-force-disable-introspection-and-v.patch
>  delete mode 100644 recipes-gnome/librsvg/librsvg/disable-rsvg-loader-test.patch
>  rename recipes-gnome/librsvg/{librsvg_2.58.2.bb => librsvg_2.59.2.bb} (67%)
>
>

