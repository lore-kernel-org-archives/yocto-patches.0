Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB929CCF9E3
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 22:48:23 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3860.1762814901719806835
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Nov 2025 14:48:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=oDKHhaax;
 spf=pass (domain: konsulko.com, ip: 209.85.160.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109c6b9fcso27961591cf.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 14:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762814900; x=1763419700; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZyJLFJNzy8Ewd9AGgoFdGMvcmd5DBIRGKsVrPOG2qo=;
        b=oDKHhaax6eA1/+2jTPQ4J9DzdCt642BhXV3gVu8h64+42jXKj9TCpcGViwQjax7wNy
         3n7jOOEzC03m/EbNW5KCtTSgdTRZ7vjieRyntyZrHbYoW2TQJf6WY+zsMkpzf+1e2HzT
         bM0JORSdR8VfTXygBlrwoJ8ecGZd9FYUIIo5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762814900; x=1763419700;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZyJLFJNzy8Ewd9AGgoFdGMvcmd5DBIRGKsVrPOG2qo=;
        b=v3/dzhL9K0SS2qXtEbw3v5Iz+OJKBJMQkAcMgoSyaZHAAdaPA7Hz873QqOn3g3LqKs
         j1nAxycC+fnp8MHqOUGLFXCULb8MkEwN5y9/zJw0KuO9XLcR26n4BpzNZhOVeR4/OAWB
         HpgH0Usyl36FP18ICLXpEj36WaWVYivYrgF/WrnIogm4qBo/y7+PI+bIQ6X0tYjx9nXi
         wJCb8cZjk6UJg2lfbmPBh0WE2FeHPuD3du49nYwbQJurM/BNlnPUwNs+5frotlDol61t
         RuNVbTWY9hB8pHWmAo4yGmVk8CwZ2L5O6dUS5v5a6RhNgLO6yIThHfiICkRQqJdLUMC2
         UcHQ==
X-Gm-Message-State: AOJu0YyjQQ02cFGzbNIPe0yGABsEhCwdf8ol0TRn0mK/eILZ3dVnDVvW
	+Qf89To6x+LgyR4dCsJ/jEg3c0RwDPbvazkpFei3tHmezx8GDfz/ZqABkYSLjKxT8X68jamQNrr
	Iiw3Z
X-Gm-Gg: ASbGncuDuuy/4+wXtcKe0FVwCTBcrlyoMW4ta3D3zhl71iUYC1TBzEQw7mFQdocaxCZ
	Ao/kyiPyOxslLVi9hxenqafmg8zG/oSdPXa+CTr0n9YHlcpfTxrKWMiH0Kb6oA3gsZLWFkLNeQ+
	6YBgchKTO80DNob9Id9jSdfvrRDwK5kEk1rZBxSooUodNOoO2GYczOlAQtL/R2m1qRfGTaAtJkq
	Ga3zhdTy0Nn0d2tz/TquLAeKuS5+QVN3/dT19MlmOGbcew6CCaUmq0CmQSXfHhYQIb23EK/25x+
	MJBVSRvLDobYXDharVEtlHJtZQ+x7O8tAYOzulIXP5QY9XLConNnaULSVqwgXOtmNZXzpFcRrbd
	jHMcdEILaxtlke5A9U/eK96MbNg8UVfJyxejhpwnGJxUYf0f9cPEOUj6TZmF4gWMQm/7YJE2eRR
	n9MVCFQvfhmGRtFqr7MuJzfsLZblqv8j1F+gJszTvxVtjrlw==
X-Google-Smtp-Source: AGHT+IEXzbNo7J3DDFxYIN+uN5qSBHAS2WdzoGKyOELxt9D7gz1L18niSQwuV8t4TaotNqzZsJUKgA==
X-Received: by 2002:a05:622a:1311:b0:4eb:a327:58d4 with SMTP id d75a77b69052e-4eda4e8ca9dmr128042321cf.7.1762814900349;
        Mon, 10 Nov 2025 14:48:20 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda5785f89sm56095011cf.23.2025.11.10.14.48.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:48:20 -0800 (PST)
Date: Mon, 10 Nov 2025 17:48:19 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/11]
 Update to Rust 1.90.0
In-Reply-To: <1876218D503ACFD2.660630@lists.yoctoproject.org>
Message-ID: <1b3eb01b-6769-3de5-15f5-c7e217c3fb5a@konsulko.com>
References: <1876218D503ACFD2.660630@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 22:48:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2479

On Sat, 8 Nov 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the scarthgap/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.89.0 -> 1.90.0 updates and other fixes.
>
> I intend to push this series to scarthgap/rust by end of day Monday
> (EST) unless a serious showstopper is pointed out.

These have now been merged.

Scott


> Changes:
>
> Alexander Kanavin (1):
>   cargo-c: update 0.10.14 -> 0.10.15
>
> Deepesh Varatharajan (4):
>   rust-target-config: Update the data layout for ppc64 targets.
>   cargo-c: update 0.10.15 -> 0.10.16
>   rust-target-config: PPC64 targets require explicit ABI selection to
>     avoid build failures with rustc.
>   rust-target-config: Fix ABI override for powerpc64le target
>
> Gyorgy Sarvari (1):
>   librsvg: add ptest support
>
> Peter Tatrai (1):
>   oeqa/selftest/rust: strip debug symbols from test binaries
>
> Ross Burton (2):
>   libstd-rs: remove redundant CARGO_TARGET_DIR
>   classes/cargo_common: ensure B is clean
>
> Yash Shinde (2):
>   rust: Upgrade 1.89.0 -> 1.90.0
>   cargo-c: fix debug symbols containing TMPDIR references
>
>  classes-recipe/cargo_common.bbclass           |   4 +
>  classes-recipe/rust-target-config.bbclass     |  10 +-
>  conf/layer.conf                               |   2 +-
>  lib/oeqa/selftest/cases/rust_mixin.py         |  13 +-
>  recipes-devtools/rust/cargo-c-crates.inc      | 676 +++++++++---------
>  ...9.0.bb => cargo-c_0.10.16+cargo-0.91.0.bb} |   4 +-
>  .../rust/{cargo_1.89.0.bb => cargo_1.90.0.bb} |   0
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch |   8 +-
>  ...lain-syscalls-as-their-time64-varian.patch |   8 +-
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |  12 +-
>  .../backport-fix-test-string-merging.patch    |  27 -
>  ...epro-issue-fix-with-cc-crate-hashmap.patch |   4 +-
>  .../rust/files/rust-oe-selftest.patch         | 189 +++--
>  ...ibstd-rs_1.89.0.bb => libstd-rs_1.90.0.bb} |   5 +-
>  ....89.0.bb => rust-cross-canadian_1.90.0.bb} |   0
>  ...ust-llvm_1.89.0.bb => rust-llvm_1.90.0.bb} |   2 +-
>  recipes-devtools/rust/rust-snapshot.inc       |  78 +-
>  recipes-devtools/rust/rust-source.inc         |   3 +-
>  .../rust/{rust_1.89.0.bb => rust_1.90.0.bb}   |   0
>  recipes-gnome/librsvg/librsvg/run-ptest       |  17 +
>  recipes-gnome/librsvg/librsvg_2.61.0.bb       |  32 +-
>  21 files changed, 582 insertions(+), 512 deletions(-)
>  rename recipes-devtools/rust/{cargo-c_0.10.14+cargo-0.89.0.bb => cargo-c_0.10.16+cargo-0.91.0.bb} (80%)
>  rename recipes-devtools/rust/{cargo_1.89.0.bb => cargo_1.90.0.bb} (100%)
>  delete mode 100644 recipes-devtools/rust/files/backport-fix-test-string-merging.patch
>  rename recipes-devtools/rust/{libstd-rs_1.89.0.bb => libstd-rs_1.90.0.bb} (90%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.89.0.bb => rust-cross-canadian_1.90.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.89.0.bb => rust-llvm_1.90.0.bb} (99%)
>  rename recipes-devtools/rust/{rust_1.89.0.bb => rust_1.90.0.bb} (100%)
>  create mode 100644 recipes-gnome/librsvg/librsvg/run-ptest
>
>

