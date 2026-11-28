Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9104.1795882552714146511
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:15:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=RWIy7e/t;
 spf=pass (domain: konsulko.com, ip: 209.85.219.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-92123f02faeso95936956d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795882552; x=1796487352; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bGp8zSmTHK+MCOrcISxiYUgeCN4ULRCUu6Z7WysuypQ=;
        b=RWIy7e/t9HfX1xrp0+bBqUDL15IZZF5Meo6yMO1UQeITvKDZgUSBNrs9UJgM6cBIFH
         c4yHQE1tmsEIujjkLYC7DFTlgYJLBDMkDyrWLkuFDG1gOuw05uWsdssX4rI2WlHy7jqf
         EIAaeMq9WNFPj/tk6O1tqkgOOIIDSP12KyZcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795882552; x=1796487352;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bGp8zSmTHK+MCOrcISxiYUgeCN4ULRCUu6Z7WysuypQ=;
        b=uIe8FkfZ4M51M/SCerBCyw8IwAtKs+b4xqrXIA2LpHR+PFAbZoRnxASgqpVxG8WT8q
         LzVJU5UDg1QBUdZNFsfyuHEPqDNXhMkw1oe4dh/EeSswqGPxWQWSVHS2q+curWBoxBcQ
         +drKiFEHQo7zqBdIdrv1lt5Zah18WGritGl2SEYz1fwq9VRKWuZgPN/ImeGm2KyKT9nh
         TrFsL+sP2SLIlVNWs8gODoQYtIZczx8WO+Nc8nucJmPk3sudO5xXgY5c4CqJhnyGGOvC
         cgYqWRMHhsYpn3Am+MqqAd2W+BcabgRzDZEb1EtNeCxXWfxsIYbeemoqi3dmvYiJgiUQ
         VEHw==
X-Gm-Message-State: APuU4Z+89lOgQq3fzb+WmWTITJJV3a2ShgNsnqxd/i0NV4L7ppDcU/7D
	ak3AG8Bzf4evACKKvHfiHmf3Di94GCL9PsxVHh5kT/MDo8amLY7pzZzlc5msupmAK7E/m0QA53j
	9cn8l
X-Gm-Gg: AZFdTZdTBbR7eAsXDtut2xRgdvSPvFxqQYq/c3rkVXokmE4zxZ3ntIb9/u5TXcNPrWy
	elbOLxgExmkp9S0LcD0hdZMqXIndr7AIQpMI+vMvZ7MeTzm/k/8Tegn7P2N5/YaiQqANspcYpX9
	0fOfHp9rVQE3VsUqQsKhh1A/DBTOT7h/7EQP7nH9Ei3CWkvvhEmTblJyf48f462uFvCZE8hHLw5
	bNqMIFvYtcOL9cXmT7dqB1lmO8pl47s1o48WJtH3mfP8atDxUBYo7JBwBA+E8UYzD8xd/YNdksZ
	QNGN8qqjc4RoRIYiaokWH9vDdi854xC+lby7weVqACkYKepffmAx66BQmn1gknsRoUL4rUOA9wd
	FT4vSZBAyi56Z/qA7lPHI0GpPl/dmFduNThSW4pDksvORhH4/aUnkb0cofN7BXW4H+FpmSaHRnh
	mXvJXIPMWlJjrS31RinNn/4Kai5k/E8QZiGRxk7E0xuu/ytRUjVEpnqfjZJsZ1P4dQALV0PENjc
	9Kl5a0L1sBN68OB3nMVbNr5hO7kir2c9ofmPJJDgEmpu8o9+PmZG2RPW2y+5vKe94XQWSkOyxoM
	hdtgrLx0y7CqkevIwKW0mjnW6slGBmID3yNg8DeeO97vyTb8Xti5wAZObjAOJSTasPZkauphAfz
	ECTam5Asp8PtB1G8n706ObF81rqzTdbWBRuuNZbH6TLoWqy6nv/h7cCUY
X-Received: by 2002:a05:6214:4287:b0:921:907b:ea0a with SMTP id 6a1803df08f44-921907bf270mr153443446d6.28.1795882551247;
        Sat, 28 Nov 2026 08:15:51 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9217fd18b2asm90107056d6.21.2026.11.28.08.15.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:15:50 -0800 (PST)
Date: Sat, 28 Nov 2026 11:15:50 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/19]
 Update to 1.99.1
In-Reply-To: <18EB6A6B0F1A16D2.1929676@lists.yoctoproject.org>
Message-ID: <0e175e2f-d1a0-3375-30b9-a98c71ebc856@konsulko.com>
References: <18EB6A6B0F1A16D2.1929676@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:15:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5558

On Wed, 25 Nov 2026, Scott Murray via yocto-patches wrote:

> This patch series for the scarthgap/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.98.1 -> 1.99.0 -> 1.99.1 updates and other fixes.
>
> I intend to merge this series to scarthgap/rust by end of day tomorrow
> (November 26, EST) unless an issue is pointed out.

My apologies, I got head down on something and forgot to merge these,
they have now been merged to scarthgap/rust.

Scott


> Changes:
>
> Ankur Tyagi (1):
>   librsvg: upgrade 2.63.2 -> 2.63.3
>
> Deepesh Varatharajan (1):
>   cargo-c: upgrade 0.10.25 -> 0.10.26
>
> Harish Sadineni (1):
>   rust-cross-canadian: install target-specific env scripts and fix
>     rustlib lookup
>
> Hemanth Kumar M D (2):
>   rust: Upgrade 1.98.1 -> 1.99.0
>   rust-target-config: fix invalid +v5 LLVM feature for armv5
>
> Jaipaul Cheernam (1):
>   librsvg: upgrade 2.63.3 -> 2.63.4
>
> Khem Raj (1):
>   rust-common: Use 64-bit time_t libc layouts for riscv32 musl
>
> Markus Volk (1):
>   cargo_common: map the cargo vendoring directory for the C compiler
>
> Peter Tatrai (1):
>   rust: add secure-plt to generated powerpc targets
>
> Richard Purdie (1):
>   librsvg: upgrade 2.63.0 -> 2.63.2
>
> Ross Burton (2):
>   librsvg: upgrade 2.62.3 -> 2.63.0
>   classes/cargo_c: use CARGO_C_BUILD_FLAGS for cargo-c flags
>
> Sowmya Sathram (1):
>   rust: Upgrade 1.99.0 -> 1.99.1
>
> Sunil Dora (5):
>   rust: drop the cc object-name reproducibility patch
>   rust: hash cc object names relative to their source roots
>   rust: keep the build host triple out of cargo unit metadata
>   rust: backport deterministic DocLinkResMap serialisation
>   rust: sort hygiene data before it is encoded
>
> Vasileios Anagnostopoulos (1):
>   ptest-cargo: align test and application build environments
>
>  classes-recipe/cargo_c.bbclass                |   6 +-
>  classes-recipe/cargo_common.bbclass           |   5 +
>  classes-recipe/ptest-cargo.bbclass            |  35 +-
>  classes-recipe/rust-common.bbclass            |   3 +
>  classes-recipe/rust-target-config.bbclass     |   6 +-
>  conf/layer.conf                               |   4 +-
>  recipes-devtools/cargo-c/cargo-c-crates.inc   | 332 +++----
>  ....0.bb => cargo-c_0.10.26+cargo-0.100.0.bb} |   2 +-
>  .../rust/{cargo_1.98.1.bb => cargo_1.99.1.bb} |   0
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch | 219 -----
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |  51 +-
>  ...ommits-from-rust-Fix-selftest-llvm23.patch | 661 -------------
>  ...-host-triple-from-unit-metadata-hash.patch |  62 ++
>  ...hygiene-encoding-order-deterministic.patch |  59 ++
>  ...llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch |  38 -
>  ...ject-names-relative-to-source-roots.patch} | 118 +--
>  .../rust/files/rust-oe-selftest.patch         |  14 +-
>  ...ibstd-rs_1.98.1.bb => libstd-rs_1.99.1.bb} |   0
>  recipes-devtools/rust/rust-cross-canadian.inc |   9 +-
>  ....98.1.bb => rust-cross-canadian_1.99.1.bb} |   0
>  ...ust-llvm_1.98.1.bb => rust-llvm_1.99.1.bb} |   0
>  recipes-devtools/rust/rust-snapshot.inc       | 104 +-
>  recipes-devtools/rust/rust-source.inc         |   9 +-
>  ...source_1.98.1.bb => rust-source_1.99.1.bb} |   0
>  .../rust/{rust_1.98.1.bb => rust_1.99.1.bb}   |   2 -
>  recipes-gnome/librsvg/librsvg-crates.inc      | 924 +++++++++---------
>  ...append-RUSTFLAGS-to-rustc-executable.patch |   2 +-
>  ...e-care-of-deprecated-assert_cmd-Comm.patch |   2 +-
>  .../{librsvg_2.62.3.bb => librsvg_2.63.4.bb}  |   2 +-
>  29 files changed, 934 insertions(+), 1735 deletions(-)
>  rename recipes-devtools/cargo-c/{cargo-c_0.10.25+cargo-0.99.0.bb => cargo-c_0.10.26+cargo-0.100.0.bb} (87%)
>  rename recipes-devtools/rust/{cargo_1.98.1.bb => cargo_1.99.1.bb} (100%)
>  delete mode 100644 recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
>  delete mode 100644 recipes-devtools/rust/files/0004-Backport-commits-from-rust-Fix-selftest-llvm23.patch
>  create mode 100644 recipes-devtools/rust/files/0004-cargo-omit-host-triple-from-unit-metadata-hash.patch
>  create mode 100644 recipes-devtools/rust/files/0005-rustc-span-make-hygiene-encoding-order-deterministic.patch
>  delete mode 100644 recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
>  rename recipes-devtools/rust/files/{repro-issue-fix-with-cc-crate-hashmap.patch => cc-hash-object-names-relative-to-source-roots.patch} (68%)
>  rename recipes-devtools/rust/{libstd-rs_1.98.1.bb => libstd-rs_1.99.1.bb} (100%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.98.1.bb => rust-cross-canadian_1.99.1.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.98.1.bb => rust-llvm_1.99.1.bb} (100%)
>  rename recipes-devtools/rust/{rust-source_1.98.1.bb => rust-source_1.99.1.bb} (100%)
>  rename recipes-devtools/rust/{rust_1.98.1.bb => rust_1.99.1.bb} (99%)
>  rename recipes-gnome/librsvg/{librsvg_2.62.3.bb => librsvg_2.63.4.bb} (98%)
>
>
