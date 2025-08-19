Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BCCCA0EEB
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 14:31:14 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web11.16249.1755613869021290539
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 Aug 2025 07:31:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=X8QqOyuh;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b1098f9e9eso75646681cf.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755613868; x=1756218668; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7Pjz/qShN/5/ZUCoesP1VSFquhQTw64aXNTz+gsBvQ=;
        b=X8QqOyuhvmncXb2ZXq/hkEF9HFpsusM4dKArY82bDWET5cMBKuxG3roO2lhAip24tF
         sbraG5gqr4JBWQmBAG2mxTE7ceN5ETFhYA+c95U7rBlytSOOTQuWlw54tbybLwoa0MSL
         AOWQAwPSwZb9cj0VGc6ytivEOzNX+zcx15FPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613868; x=1756218668;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7Pjz/qShN/5/ZUCoesP1VSFquhQTw64aXNTz+gsBvQ=;
        b=HY7aC33jXBR4huZXD84s2ZbNCKI7cB8ZUW8wVvJRdJPrwP4WRve2liYWKBPdlKtw3a
         sjCDFnarJuYoRRXF/YH26pB3rXSqChLuCnO0cqTwCoFnPNgNZYgcVUHQp39RcdCwoku5
         bGcKT2VD1A+v5160Uo8p718vMFAnkrbmsFvoW2pCsGfQ8GN/gmFIhS4pSViQZeg80pDy
         bRWIpfxqO5Jdoc0U/F7sRzLEiaorJ73dFaUJoEqColABLuSqSy/U6eEjup6g03nmOoG0
         /LsAsvJXEuV5XHZbbui7HqYfseW/LBdywyeqRWE1BNJDo3BJ2qgdBGdY7nBNlxdZlEE4
         F5JQ==
X-Gm-Message-State: AOJu0YxBKDtcFVDBrm1QSCSy7RRiqhLtqr/8+L2YpbjUUkWteRgON4Ll
	M16gTT3p6qoziEKQw/rWJYeXogE3EbdPiyUP3iLx5nuJy+0vCTsiQv4NJZemVTC9Z8mX7sHP9Od
	jr3sA
X-Gm-Gg: ASbGncthZhDo0QKYU4JyZo+j/P6Uly4lw2cHB5kO0FquY0xgQGVUhkdxj5WmXUkqpG9
	ujiBW2377BGV4oh6vLI5rsK9S73npNYw/WuqC0+Mu7XZ2vtg9V2mydoQPA4TkBW6t1qhmWF00ON
	wM0HbCTiNZjYpR8XP38WqKEOwIGKUxH3L+OFvOi15kyGI1aTyAREnjvziwGhCUr5ubFUfq1NnEM
	URu8MZ3Bj4OKWYEJhg8hkX1K9zBvYTNTHFhA38i2hGcamIXQpTBrHsZwMBKXpEJ48cWlJdWnb7/
	pPDFCXLdrNMBA22TsSJbTxhEgdGPht06OLIIoMnuvygBuHekYn6r7e03HYybkVkFCwfJsv/5avX
	C9NlVj3NmjhHcO6CWmqd/62F6zP4hTfW/c3GbKDuzdpyf2QLGF5Ms+f5EbkY1Qap2X5s=
X-Google-Smtp-Source: AGHT+IGjVaxjPpAOVJK/KRgdgLKRmtUMJZwXm0gIQboyjpkvLD8hILE8sKYOF73r0q6ldHmLBCB3uA==
X-Received: by 2002:a05:622a:1e91:b0:4b0:6825:30ce with SMTP id d75a77b69052e-4b286e0031bmr32145861cf.54.1755613867538;
        Tue, 19 Aug 2025 07:31:07 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b155b5baf4sm41871581cf.0.2025.08.19.07.31.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:31:07 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:30:58 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 0/7]
 Update to Rust 1.88.0
In-Reply-To: <185C9E195CBCEAC5.8958@lists.yoctoproject.org>
Message-ID: <1e475415-bfcd-c24c-7ebb-301091032a37@konsulko.com>
References: <185C9E195CBCEAC5.8958@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 14:31:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2056

On Sun, 17 Aug 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the kirkstone/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.87.0 -> 1.88.0 updates and other fixes.
>
> I intend to push this series to kirkstone/rust within 24 hours
> unless a serious showstopper is pointed out.

I have gone ahead and merged these changes to kirkstone/rust.

Scott

> Changes:
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
>  20 files changed, 848 insertions(+), 472 deletions(-)
>  create mode 100644 recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
>  create mode 100644 recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
>  rename recipes-devtools/rust/{cargo-c_0.10.13+cargo-0.88.0.bb => cargo-c_0.10.14+cargo-0.89.0.bb} (50%)
>  rename recipes-devtools/rust/{cargo_1.87.0.bb => cargo_1.88.0.bb} (100%)
>  create mode 100644 recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch
>  create mode 100644 recipes-devtools/rust/files/backport-fix-test-string-merging.patch
>  rename recipes-devtools/rust/{libstd-rs_1.87.0.bb => libstd-rs_1.88.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.87.0.bb => rust-cross-canadian_1.88.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.87.0.bb => rust-llvm_1.88.0.bb} (99%)
>  rename recipes-devtools/rust/{rust_1.87.0.bb => rust_1.88.0.bb} (100%)
>
>

