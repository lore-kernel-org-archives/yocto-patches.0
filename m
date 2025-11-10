Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA779CCF9E3
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 22:48:03 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3855.1762814882965270775
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Nov 2025 14:48:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sSLS64E0;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b22319db92so25271985a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 14:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762814882; x=1763419682; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tNjam2qqtTUVKsbHIEQvLmQDNHiAm9V1Y+ypmC/LXGg=;
        b=sSLS64E0fgs6yFvmGhFutxH9jQirKJ97aAiexKuLSB9d5Nd1bgc602tzQ8yH6WZ2z3
         po66CETBwjBxyTVTfXCNwSiy0C45GMhmrW9VOF8vLpS7/khbzeCHgwYVrtucr3jukD2H
         Ryhabr21z2/JzRHL+GO5y/VDdG0KbgNHswvpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762814882; x=1763419682;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNjam2qqtTUVKsbHIEQvLmQDNHiAm9V1Y+ypmC/LXGg=;
        b=p9MtdnGwRjJqBhpJZRqaDfBgavj93qjVbCf5uKYIbF0A590rWl6qvpUhKgNzI8kG7j
         1ojhX5lmHtgO4sFsd40iUVzyT0P5h/ehU/8BLn0ofAr3tO1LD46Hl2oJkCLLUwgtpyDC
         Zl2Id9k+BlopSI53QWggOfzvz30N2NO226XdIifCmEPz9uZb4c8G/+eGJsci21Z0aD+u
         QiLX0gcd4rJ33ANfooOMtcrRfe7cTJh5FqQ+52tyEvh6muAlBBDO0snOcr2AN9Ivio5B
         Jr1+5ZxQ+RkocfGHZtpcZoc49rL2aEx4v0HnlzpJISo1a+onUKvR2gPKWVhYwAyxXJu/
         /OlA==
X-Gm-Message-State: AOJu0YwInBoiVUOV4p1G/Ybr0lck7Z/TI79Wx7PdaMPteTilMJP1eOtK
	+Onk8y3g5nCzUBLtqXLU2Q0sPUWl219esm5GSadgbM6DVt1eohXIdxMrmbVXAMf85geULAgT/vZ
	jD8Mi
X-Gm-Gg: ASbGncv8TmqvOkTFuwSRhtrgvKbzLRgMrH6zCIPSJMh2594BTa4EIUYBuJvY8C6x3/5
	kgnOPIcHuhTivFKFsHdbRGKJuq2PxdH5rP/4pihxkVFMw1jpiuCoBX0uf+ruqAcGCKviyzk4A0N
	srgBWxKnpWBdnqSPFlT0VRLkWPs/dL37YGV3ilLLz0nUcxTh0Dd+drHJWyVkf7IaNsqFrf00uSj
	RJvcj/45tG8JdAdPwCyrC8CDjtW0CkLaiALWyIDN9ETDRA/TBBhplwsGT8o8WX1IIDA7hu9gBuh
	qNYfqbnVTtLuw8s7S6uxLZ/ponspHxDpycIWPLOtszZ/OI7m7FoYOukr6saG5nXOKErLrtuma69
	EgeVD3YhcwE3QBs52hOWxZ8v7yNg5lJpYma+zBBXFQhqAjPOOluLZzULLNKRqZwgiPOyTrjxpGl
	AreeNSEexT1BIsAtzwcEJCfsWmPu+4Z7bAk2k=
X-Google-Smtp-Source: AGHT+IG0WzlVxLgv4rrswJRWFTDcCKtho3NeoJrBsk5ubE4rAY0hoT32cvw3hvc5zAmXwU5lXHI0og==
X-Received: by 2002:a05:620a:2993:b0:8b2:6462:ec1e with SMTP id af79cd13be357-8b28898e07dmr166278585a.13.1762814881471;
        Mon, 10 Nov 2025 14:48:01 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b240ee9ec3sm929912185a.35.2025.11.10.14.48.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:48:01 -0800 (PST)
Date: Mon, 10 Nov 2025 17:48:00 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 00/11]
 Update to Rust 1.90.0
In-Reply-To: <187621577A4E407E.568378@lists.yoctoproject.org>
Message-ID: <68694a66-0029-b921-7dac-b8e2cd22fb18@konsulko.com>
References: <187621577A4E407E.568378@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 22:48:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2478

On Sat, 8 Nov 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the kirkstone/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.89.0 -> 1.90.0 updates and other fixes.
>
> I intend to push this series to kirkstone/rust by end of day Monday
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
> Peter Tatrai (1):
>   oeqa/selftest/rust: strip debug symbols from test binaries
>
> Ross Burton (2):
>   libstd-rs: remove redundant CARGO_TARGET_DIR
>   classes/cargo_common: ensure B is clean
>
> Scott Murray (1):
>   cargo-c: Fix compilation
>
> Yash Shinde (2):
>   rust: Upgrade 1.89.0 -> 1.90.0
>   cargo-c: fix debug symbols containing TMPDIR references
>
>  classes/cargo_common.bbclass                  |   4 +
>  classes/rust-target-config.bbclass            |  10 +-
>  conf/layer.conf                               |   2 +-
>  lib/oeqa/selftest/cases/rust_mixin.py         |  13 +-
>  recipes-devtools/rust/cargo-c-crates.inc      | 676 +++++++++---------
>  ...9.0.bb => cargo-c_0.10.16+cargo-0.91.0.bb} |   8 +-
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
>  19 files changed, 538 insertions(+), 511 deletions(-)
>  rename recipes-devtools/rust/{cargo-c_0.10.14+cargo-0.89.0.bb => cargo-c_0.10.16+cargo-0.91.0.bb} (64%)
>  rename recipes-devtools/rust/{cargo_1.89.0.bb => cargo_1.90.0.bb} (100%)
>  delete mode 100644 recipes-devtools/rust/files/backport-fix-test-string-merging.patch
>  rename recipes-devtools/rust/{libstd-rs_1.89.0.bb => libstd-rs_1.90.0.bb} (90%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.89.0.bb => rust-cross-canadian_1.90.0.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.89.0.bb => rust-llvm_1.90.0.bb} (99%)
>  rename recipes-devtools/rust/{rust_1.89.0.bb => rust_1.90.0.bb} (100%)
>
>

