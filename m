Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3BACA0EEB
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 14:31:54 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web11.16258.1755613907580895570
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 Aug 2025 07:31:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gX65zHIJ;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109c5ac7bso55049581cf.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755613906; x=1756218706; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgLrtjOHqPtxjz0oGu4n9tqUES7ajwJuBgMWDEQv95E=;
        b=gX65zHIJlNReUQFPOmfmF8XrYwJyubPPt/KKDVhtcGOCSUqQRUqJCvcH1AAwNwEpd9
         08xcfsQ4iFJSB0b7NboLFcsHBSOa5kJVHo9m4xvzcoeXSHvuTQiMgFmqC4bh8BzxW3He
         Ym+2oPJg/UR/LJP8cejF0HUHoSJfzs0NfuB68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613906; x=1756218706;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgLrtjOHqPtxjz0oGu4n9tqUES7ajwJuBgMWDEQv95E=;
        b=ejJOxmeNp7wdr4xc+qk8sqoeVZ2ua881BS9qxU+azj+1VfOOfUOvZqrZBkqRKS2i1T
         Pm/WEqcko/e6QCRMLNCsicN2rb0E8VE2pJNDdopYai0496mXdjb8Swn1eC/wwstqpJiv
         Tjg3c2dBPZhKakc2MGjueH5O4RehUVclIMxrDR1erDkIFTP1G6rHFn+qnKP3aplibedt
         DgS1krOdDdGKZhgSCa+FpMbGbD5dG/DnuwEwlEhvGiF4LInlfVylrSub8omRvNfVUqpJ
         UvQXM4tMoXrLd3YKgF+HGfI+iWMbvzo4OJOYa6yipgv4F3BMmyf3MqMAV4BXs1ikt4bg
         VX/A==
X-Gm-Message-State: AOJu0YyDr9BlO64cysA3hSiyjO+wJkQ/obABQpACCwBPy5oMkIy2aHcR
	OAt1xANp8dyd0Ah54pUO3EestQodasZOO8xdRlua2dHrS3p5Bt8HVoBi4IY0HxOc8EfO+97/qwc
	U2Lo/
X-Gm-Gg: ASbGncuQv7a6B1TWZWpqzun0qxAGhh5Xe8mztxlfjL1LPqkgNxw/R5W7KfuMX8Rr5RD
	SNVVHT3AAj5IVdOh2sxUmSUAmZCTNiwPbwE8mZ1hYJcmaP3SsUnMkWFYU2jvAHG/LDf47O/+CH9
	ASmkc/6GHWU/+3ly/5a0jByrXpr4TEdJsSaTampDXQoKsczGZzusPmHw0SP43chVKgChmPXkHaP
	1JBS8QHMfqkqH9TnEYYGAsI5RHoNzSi40N79bJ65ifYpxdErPqKrr8srEADc10H+XY78NuFDfai
	t6YcrpUhthtJt8WmoBXXcbKRekFYGXBS+h1M5W1lXpBrAYQ6HCT78MRWPjZiS9mHjzXuZMMYkFW
	kw199ZRexqE4/urUiwp40/NrAU7YUD3ND7fDLUHzzG16oZgWJT9cwxQLN
X-Google-Smtp-Source: AGHT+IFapDSDCQ45EF1tL7rMS8lrokZOyWlNLMBf85p75uEWZjyT0+qQ3EfNr0PTtEUmWpm/r8rqCw==
X-Received: by 2002:a05:622a:59c4:b0:4b0:638f:79ef with SMTP id d75a77b69052e-4b286e216b0mr26921101cf.35.1755613906271;
        Tue, 19 Aug 2025 07:31:46 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc851d9sm68677311cf.24.2025.08.19.07.31.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:31:45 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:31:45 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 0/8]
 Update to Rust 1.88.0
In-Reply-To: <185C9E399CF5B378.30607@lists.yoctoproject.org>
Message-ID: <233f26f0-0172-6ebc-a27f-4ea5a98596fa@konsulko.com>
References: <185C9E399CF5B378.30607@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 14:31:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2057

On Sun, 17 Aug 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the scarthgap/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.87.0 -> 1.88.0 updates and other fixes.
>
> I intend to push this series to scarthgap/rust within 24 hours
> unless a serious showstopper is pointed out.

I have gone ahead and merged these changes to scarthgap/rust.

Scott

> Changes:
>
> Gyorgy Sarvari (1):
>   librsvg: upgrade 2.59.2 -> 2.60.0
>
> Jayasurya Maganuru (1):
>   rust: Upgrade 1.87.0 -> 1.88.0
>
> Khem Raj (4):
>   rust: Update riscv32 patch with the backport
>   cargo-c: Upgrade to 0.10.14+cargo-0.89.0
>   libstd-rs: Fix build regression on rv32
>   cargo-c: Update patches to latest versions
>
> Peter Tatrai (2):
>   rust: disable executable-no-mangle-strip test on PowerPC due to linker
>     issue
>   rust: backport cstring-merging test fix for PowerPC targets
>
>  conf/layer.conf                               |   2 +-
>  lib/oeqa/selftest/cases/rust_mixin.py         |   2 +
>  recipes-devtools/rust/cargo-c-crates.inc      | 498 +++++++++---------
>  ...Use-libc-SYS_futex_time64-on-riscv32.patch |  36 ++
>  ...Use-libc-SYS_futex_time64-on-riscv32.patch |  51 ++
>  ...8.0.bb => cargo-c_0.10.14+cargo-0.89.0.bb} |   7 +-
>  .../rust/{cargo_1.87.0.bb => cargo_1.88.0.bb} |   0
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch | 375 ++++++++++---
>  ...lain-syscalls-as-their-time64-varian.patch |  49 ++
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |  18 +-
>  .../backport-fix-test-string-merging.patch    |  27 +
>  ...epro-issue-fix-with-cc-crate-hashmap.patch | 102 ----
>  ...d-statically-in-rustc_driver-feature.patch |   6 +-
>  .../rust/files/rust-oe-selftest.patch         |  63 ++-
>  ...ibstd-rs_1.87.0.bb => libstd-rs_1.88.0.bb} |   0
>  ....87.0.bb => rust-cross-canadian_1.88.0.bb} |   0
>  ...ust-llvm_1.87.0.bb => rust-llvm_1.88.0.bb} |   2 +-
>  recipes-devtools/rust/rust-snapshot.inc       |  78 +--
>  recipes-devtools/rust/rust-source.inc         |   4 +-
>  .../rust/{rust_1.87.0.bb => rust_1.88.0.bb}   |   0
>  recipes-gnome/librsvg/librsvg-crates.inc      | 472 +++++++++--------
>  ...ld-do-not-force-disable-gdk-pixbuf-l.patch |  49 ++
>  ...r-meson.build-do-not-look-for-gdk-pi.patch |  28 -
>  ...ot-force-disable-introspection-and-v.patch |  34 --
>  ...append-RUSTFLAGS-to-rustc-executable.patch |  37 ++
>  .../{librsvg_2.59.2.bb => librsvg_2.60.0.bb}  |  11 +-
>  26 files changed, 1196 insertions(+), 755 deletions(-)
>  create mode 100644 recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
>  create mode 100644 recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
>  rename recipes-devtools/rust/{cargo-c_0.10.13+cargo-0.88.0.bb => cargo-c_0.10.14+cargo-0.89.0.bb} (52%)
>  rename recipes-devtools/rust/{cargo_1.87.0.bb => cargo_1.88.0.bb} (100%)
>  create mode 100644 recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch
>  create mode 100644 recipes-devtools/rust/files/backport-fix-test-string-merging.patch
>  rename recipes-devtools/rust/{libstd-rs_1.87.0.bb => libstd-rs_1.88.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.87.0.bb => rust-cross-canadian_1.88.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.87.0.bb => rust-llvm_1.88.0.bb} (99%)
>  rename recipes-devtools/rust/{rust_1.87.0.bb => rust_1.88.0.bb} (100%)
>  create mode 100644 recipes-gnome/librsvg/librsvg/0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch
>  delete mode 100644 recipes-gnome/librsvg/librsvg/0001-gdk-pixbuf-loader-meson.build-do-not-look-for-gdk-pi.patch
>  delete mode 100644 recipes-gnome/librsvg/librsvg/0001-meson.build-do-not-force-disable-introspection-and-v.patch
>  create mode 100644 recipes-gnome/librsvg/librsvg/0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch
>  rename recipes-gnome/librsvg/{librsvg_2.59.2.bb => librsvg_2.60.0.bb} (90%)
>
>

