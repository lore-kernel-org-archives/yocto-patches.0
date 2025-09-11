Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248DFCAC587
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 19:19:14 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web11.6181.1757618351962688843
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Sep 2025 12:19:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=psX71TXt;
 spf=pass (domain: konsulko.com, ip: 209.85.160.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b34a3a6f64so10865651cf.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Sep 2025 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757618351; x=1758223151; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dibTbABo2tiB3SWDfLA6oic4Y5r5mBVDhY6Ozj7wwUY=;
        b=psX71TXtV8BgA7rnxoclRQ0cYKzH+9R2/q2GFwN2gbSZosfK/SUOj6QTwGvyyIC83A
         aka1FfbLpctjydGfRgyeBVRsTBa+zNOWDinZ2NnizJtSa4YIP5dIRJH3j1FpeWc02usX
         qdAM2Q7zHo+/7nsPyhmFZGNuyptiouoryokII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618351; x=1758223151;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dibTbABo2tiB3SWDfLA6oic4Y5r5mBVDhY6Ozj7wwUY=;
        b=HZfnivx8JbDMK1dx8JGMV6BFa7Uhv63m41gkTLtGPNCcGD4NLcQfeDlRzUvjxl1Rnz
         mSQx5jjOJ3ON5gVS6EFoMJhcTYL+pkfljf+cJktdbFt+5IrUhPMf8EDYn2SOuB3jZrTe
         PF8C7s9Qaggx/iD7iZREgo40c/b6Or3LCSqvWybD1+DtJf3fNFV8pXUHFLyWFSp17g5U
         vSvtJGvjfzc2hQBFZ3r2KG7beEfjYKnvHhWhnZmIjQPU108W1gUEUYDlinUFRmgoFbJ7
         e9u43aXvLOP4v1/UofMdIZ5DVgfs906fLBCpl6lRb9fQtotwE/YGMgtJw023O+d1m/xc
         FvzA==
X-Gm-Message-State: AOJu0YzqEXA2Alotl1u9ZUDjTKNBVMklET0b+50KObtDZGuj4GUP9HAC
	ebnnCZVEJ2pk0IcZqIBBwBCtMWk5n1dI+ZaeOMuq8fFTQMprpJGlnFXKZwEwcQit3GKF4Hjq6ux
	KQar3
X-Gm-Gg: ASbGncuMWXnulgnhDML7KH+4rf9t/B2+r0DvhXoTSW/lhIfYIFcS4CrJUjv60/VXX2G
	VCgyCiistAeA9avibsJNwVhiybUa7rVv9omCHU+jUXAGpn2fExNqO7yCj7rWaVXAnIRtPUENCID
	lsFY17+viUlUI4MNiqpK1gnENXBp2nAU6hAe0ruhq8a2MBYZxS5F/yhZPdMbF3xy/eT63sAB7lH
	JtwlKX2duvk6Ga4RQtWSSYALKT4QJStUmcuX3pxCIyYRaOh7fUcMPFKmWTfYWwMR1iyHXVNDKy1
	jy9r1xPUxEWkNFxPluWtNQRzYturX1EbWQidTtJWzjQwWXW5DnMcsPdglL/jcyD+5hdhml/tKbG
	5TayVgUWfdqlSKuU2Ch27PralnedseI2mjEKy40+goe3CkMsZLyiKgBaoeg==
X-Google-Smtp-Source: AGHT+IFUEE3MKEu26cZAMvi0yHHVUTfZ/AVzYdLr3vqB3riodZ/kw6elLyoET+1HWCSEbbMW0qehsg==
X-Received: by 2002:ac8:7f0d:0:b0:4b5:e6a7:304a with SMTP id d75a77b69052e-4b77d08b354mr4884221cf.22.1757618350721;
        Thu, 11 Sep 2025 12:19:10 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab685sm14242561cf.26.2025.09.11.12.19.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:19:10 -0700 (PDT)
Date: Thu, 11 Sep 2025 15:19:08 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 0/9]
 Update to Rust 1.89.0
In-Reply-To: <1863B1D802442106.2720@lists.yoctoproject.org>
Message-ID: <ef229416-9790-06ed-2001-e805bc70f375@konsulko.com>
References: <1863B1D802442106.2720@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Sep 2025 19:19:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2182

On Tue, 9 Sep 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the scarthgap/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.88.0 -> 1.89.0 updates and other fixes.
>
> I intend to push this series to scarthgap/rust within 24 hours
> unless a serious showstopper is pointed out.

These have now been merged to scarthgap/rust, sorry for the delay.

Scott


> Changes:
>
> Gyorgy Sarvari (2):
>   ptest-cargo.bbclass: sort binaries for reproducibility
>   rust-target-config.bbclass: move target generation before do_configure
>
> Jayasurya Maganuru (1):
>   rust: Upgrade 1.88.0 -> 1.89.0
>
> Liu Yiding (1):
>   librsvg: upgrade 2.60.0 -> 2.61.0
>
> Ovidiu Panait (1):
>   rust-target-config: fix nativesdk-libstd-rs build with baremetal
>
> Per x Johansson (1):
>   rust-target-config: Add has-thread-local option
>
> Peter Marko (2):
>   recipes: cleanup CVE_STATUS which are resolved now
>   rust: handle softfp fpu
>
> Yoann Congal (1):
>   ptest-cargo: move run-ptest rc variable initialisation
>
>  classes-recipe/ptest-cargo.bbclass            |   4 +-
>  classes-recipe/rust-target-config.bbclass     |   8 +-
>  conf/layer.conf                               |   2 +-
>  lib/oeqa/selftest/cases/rust_mixin.py         |   3 +-
>  .../rust/{cargo_1.88.0.bb => cargo_1.89.0.bb} |   0
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch | 101 ---
>  ...bunwind-cross-architecture-unwinding.patch |  46 --
>  ...lain-syscalls-as-their-time64-varian.patch |  32 +
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |   8 +-
>  ...d-statically-in-rustc_driver-feature.patch |  14 +-
>  .../rust/files/rust-oe-selftest.patch         |  13 -
>  recipes-devtools/rust/files/triagebot.patch   |  32 -
>  ...ibstd-rs_1.88.0.bb => libstd-rs_1.89.0.bb} |   0
>  ....88.0.bb => rust-cross-canadian_1.89.0.bb} |   0
>  ...ust-llvm_1.88.0.bb => rust-llvm_1.89.0.bb} |   0
>  recipes-devtools/rust/rust-snapshot.inc       |  78 +-
>  recipes-devtools/rust/rust-source.inc         |   7 +-
>  .../rust/{rust_1.88.0.bb => rust_1.89.0.bb}   |   0
>  recipes-gnome/librsvg/librsvg-crates.inc      | 778 ++++++++++--------
>  ...ld-do-not-force-disable-gdk-pixbuf-l.patch |   4 +-
>  ...append-RUSTFLAGS-to-rustc-executable.patch |   4 +-
>  .../{librsvg_2.60.0.bb => librsvg_2.61.0.bb}  |   2 +-
>  22 files changed, 526 insertions(+), 610 deletions(-)
>  rename recipes-devtools/rust/{cargo_1.88.0.bb => cargo_1.89.0.bb} (100%)
>  delete mode 100644 recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture-unwinding.patch
>  delete mode 100644 recipes-devtools/rust/files/triagebot.patch
>  rename recipes-devtools/rust/{libstd-rs_1.88.0.bb => libstd-rs_1.89.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.88.0.bb => rust-cross-canadian_1.89.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.88.0.bb => rust-llvm_1.89.0.bb} (100%)
>  rename recipes-devtools/rust/{rust_1.88.0.bb => rust_1.89.0.bb} (100%)
>  rename recipes-gnome/librsvg/{librsvg_2.60.0.bb => librsvg_2.61.0.bb} (97%)
>
>

