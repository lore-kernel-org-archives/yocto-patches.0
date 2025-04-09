Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42E3C36002
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 16:52:34 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web10.13907.1744217548661256036
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Apr 2025 09:52:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Pi5WO9OH;
 spf=pass (domain: konsulko.com, ip: 209.85.166.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85dac9729c3so457123439f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Apr 2025 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744217547; x=1744822347; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fp+cXlDCORJV6jBlWBfM9pPl12X6E4aGVRgMhFdChkU=;
        b=Pi5WO9OHjw/LoGpKTnO2fD22Ra8BEGXe2Ln9W3wCftmuVHuqX1stV/7Uhx8/iT88+z
         RTLEMPpobTincBlMLbiKiBKv+wMZjOkJBtp92+EDPg/fizECdYWlpZMaYnYV6vOjzS1G
         XNNiZSr0G767mxHohMkcr2vRc1QQsJRt6t95k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744217547; x=1744822347;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp+cXlDCORJV6jBlWBfM9pPl12X6E4aGVRgMhFdChkU=;
        b=UAV1CUQAO15LmPvDOme0jvQ6ZRJLwJMYT6ZSvh4LeYcY86XiN7qm5R96yGQUgzpk9Z
         dyUuoRPTBL3yTb/3u6KxQI1072yymVN3cIQydEaIVJphqCOPdN1cKEGW8z+MRBVpRck1
         t+FqB1rKwR27JSuJdCOdd4Ys4JdXS6pJfCtrFmL5Z1rdmiIXCvpB1pxJmKsefA4kCeu2
         n2G27umFLG79y4+SclOvklhbPTlLivDSuYcNw+ghZtfuabrLI+x1uP9L9xVXIm0i8xjI
         ZGwaHjvsT5bL65eOM4kLP+3Yf9sCNGFW2ejSqvxAGY8gsWxPFhqrDRWVH6ppXWfFCgw9
         99vQ==
X-Gm-Message-State: AOJu0Ywbo0x2XAfuldieLiu0H1nrhz/wQwgFgA4yku36UooWTbBc8ZM2
	9Oar/Jz99neR/DVqkDXyP/uzbPxc/0/GN/R5DfpPTBRNwz8UXwL0hX1dsrzVyacUHCPdnuV0Z3+
	T
X-Gm-Gg: ASbGncvgY83ZSVsabIv0leYRcCIlCIatmo/ulbYj47t/rdl1hq9bzTiCfldBzPN3lhL
	8JE29kWcwEAM+1SytTIB4qdMMmqe4R47G2UjtiZnb2g1zzgdLkScYbV8kgkm2i0XiwnepsZPXup
	PjVw9SspfofHPtzxhIlBbq4eD5+oPfInHXzfwNUmr2JEIXiIDS4Dk3d8M4PY/x3DF25Hexx6fdO
	a6bfqlkQ+BkBk/bWQaMnvQUhFAZCjw0LYPev9qv3YZFVH8AkT8bnnm0ojaJiiwPrtKeAhPgPfSS
	UDUaNPVOwUM6IzcnMHzo+Yu8yQVaNzOSfOVkcddamXvYthakD4KcUP67spAXghokHfnhDSul+xI
	=
X-Google-Smtp-Source: AGHT+IFXpl3EahE4/0RYlQEAjFjVDDCz8Msiw1HcFJ48k5PW9Xiaf6LxMDcD7evD8nTa/WKAMRwtUw==
X-Received: by 2002:a05:6602:400d:b0:85b:482b:8530 with SMTP id ca18e2360f4ac-861611821a4mr396604939f.2.1744217547435;
        Wed, 09 Apr 2025 09:52:27 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505d3b6d6sm320673173.59.2025.04.09.09.52.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:52:26 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:52:26 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/29]
 Update to Rust 1.85.1
In-Reply-To: <183426A352357996.31078@lists.yoctoproject.org>
Message-ID: <1b86e176-1f8b-f9ec-cab6-d633f7e6cfa2@konsulko.com>
References: <183426A352357996.31078@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Apr 2025 16:52:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1342

On Mon, 7 Apr 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the scarthgap/rust mixin layer backports the
> various Rust toolchain changes in oe-core master to to pull in the
> 1.81.0 -> 1.85.1 updates that have landed in the last couple of months
> in oe-core.  At this point the backported selftest (as the "rust_mixin"
> module) is passing in my environment except on qemuriscv64, which
> is currently also failing on oe-core master based on my testing.
>
> I intend to push this series to scarthgap/rust within 24 hours
> unless a serious showstopper is pointed out.

Oops, forgot about this last night, these have now been merged.  My thanks
for the reviews / test reports on this go around, it was helpful.

Cheers,

Scott


> Changes:
>
> Alexander Kanavin (1):
>   rust: restore parallel builds, disable lto only for rustdoc
>
> Deepesh Varatharajan (11):
>   rust: Upgrade 1.81.0->1.82.0
>   rust: oe-selftest issue fix with v1.82
>   rust: Oe-selftest changes for rust v1.82.0
>   rust: Upgrade 1.82.0->1.83.0
>   rust: Fix build break because of download-ci-llvm
>   rust: Oe-selftest changes for rust v1.83.0
>   rust: Fix bloat issue in recent rust updates
>   rust: Fix build break because of "download-rustc" and "llvm-tools"
>   rust: Upgrade 1.83.0->1.84.1
>   rust: Fix build failure when multilibs are enabled
>   rust: Oe-selftest changes for rust v1.84.1
>
> Enrico Scholz (1):
>   cargo_common: use 'config.toml' instead of plain 'config'
>
> Harish Sadineni (2):
>   rust: fix for rust multilib sdk configuration
>   rust: remove redundant cargo config file
>
> Igor Opaniuk (1):
>   rust/README-rust.md: fix markdown style issues
>
> Jean-Pierre Geslin (1):
>   cargo: pass PACKAGECONFIG_CONFARGS to cargo build
>
> Khem Raj (1):
>   rust-llvm: Fix build break found with clang
>
> Martin Jansa (1):
>   cargo.bbclass: show PACKAGECONFIG_CONFARGS in bbnote
>
> Pedro Ferreira (1):
>   rust-common.bbclass: soft assignment for RUSTLIB path
>
> Richard Purdie (5):
>   meta/meta-selftest: Fix variable assignment whitespace
>   recipes: Drop ld-is-gold support
>   rust-source: Fix remove_gcc_directory
>   rust-llvm: Compile llvm to use dynamic libraries
>   rust-llvm: Disable libedit
>
> Sean Nyekjaer (1):
>   rust-cross-canadian: set CC_<triple> for nativesdk
>
> Yash Shinde (3):
>   rust: Update "do_update_snapshot" task for rust-snapshot.inc
>   rust: Upgrade 1.84.1->1.85.0
>   rust: Upgrade 1.85.0->1.85.1
>
>  classes-recipe/cargo.bbclass                  |   6 +-
>  classes-recipe/cargo_common.bbclass           |  20 +-
>  classes-recipe/rust-common.bbclass            |   2 +-
>  classes-recipe/rust-target-config.bbclass     |   5 +
>  classes-recipe/rust.bbclass                   |   8 +-
>  conf/layer.conf                               |   4 +-
>  files/common-licenses/Unicode-3.0             |  39 +++
>  lib/oeqa/selftest/cases/rust_mixin.py         |   2 +
>  recipes-devtools/rust/README-rust.md          |  24 +-
>  .../rust/{cargo_1.81.0.bb => cargo_1.85.1.bb} |  13 +
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |  46 ++++
>  .../Zdual-proc-macros-additional-check.patch  |  31 +++
>  ...epro-issue-fix-with-cc-crate-hashmap.patch |  90 +++++--
>  ...d-statically-in-rustc_driver-feature.patch | 228 +++++++++++++++++
>  .../rust/files/rust-oe-selftest.patch         | 152 ++++++++---
>  ...ue-fix-cargo-config-for-codegenunits.patch |  26 --
>  .../files/rv32-cargo-rustix-0.38.28-fix.patch |  70 ------
>  .../files/rv32-cargo-rustix-0.38.40-fix.patch | 236 ++++++++++++++++++
>  .../rust/files/rv32-rustix-libc-backend.patch |  33 ---
>  .../rust/files/zlib-off64_t.patch             |  31 ---
>  ...ibstd-rs_1.81.0.bb => libstd-rs_1.85.1.bb} |   9 +-
>  recipes-devtools/rust/rust-cross-canadian.inc |  24 +-
>  ....81.0.bb => rust-cross-canadian_1.85.1.bb} |   0
>  ...ust-llvm_1.81.0.bb => rust-llvm_1.85.1.bb} |   8 +-
>  recipes-devtools/rust/rust-snapshot.inc       |  81 +++---
>  recipes-devtools/rust/rust-source.inc         |  10 +-
>  .../rust/{rust_1.81.0.bb => rust_1.85.1.bb}   |  76 ++++--
>  27 files changed, 931 insertions(+), 343 deletions(-)
>  create mode 100644 files/common-licenses/Unicode-3.0
>  rename recipes-devtools/rust/{cargo_1.81.0.bb => cargo_1.85.1.bb} (87%)
>  create mode 100644 recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
>  create mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
>  create mode 100644 recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
>  delete mode 100644 recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch
>  delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.28-fix.patch
>  create mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-fix.patch
>  delete mode 100644 recipes-devtools/rust/files/rv32-rustix-libc-backend.patch
>  delete mode 100644 recipes-devtools/rust/files/zlib-off64_t.patch
>  rename recipes-devtools/rust/{libstd-rs_1.81.0.bb => libstd-rs_1.85.1.bb} (79%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.81.0.bb => rust-cross-canadian_1.85.1.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.81.0.bb => rust-llvm_1.85.1.bb} (93%)
>  rename recipes-devtools/rust/{rust_1.81.0.bb => rust_1.85.1.bb} (81%)
>
>

