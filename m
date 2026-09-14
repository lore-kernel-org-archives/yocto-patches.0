Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D1DC88E75
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 23:01:21 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10992.1789426877827967568
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 16:01:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JzN2GW/4;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ad20d4so322309885a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789426877; x=1790031677; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3jEYTet7asLHYyR6zxEm9Mp77qvuDDAHROYaqWLEu14=;
        b=JzN2GW/4JSpGfDOOYrdwnde0fXM3vplYF7DnAP/wKEgMeAa9RQBIIX0GJJma5B9fGx
         cpeDjWRZKkBAr+yiY6ghE7uminT1b0amAuymjn7SExd1nVlxtjGmxZQmbMTF3ePAFFTM
         kLNfl/I3rPeJGr6JuHXLGBJQ2+u2etq52Nfqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426877; x=1790031677;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3jEYTet7asLHYyR6zxEm9Mp77qvuDDAHROYaqWLEu14=;
        b=gI/CCDEEf9XZNFs0d+tCW5/71JjaNkpgS5kGUNsqB/kr8SbT/BhjLL3LtKmG3LPcmV
         65DpPiE8sMStJw4baTlQ5g3iab5Dz2OG6ACfntI9m8MuPZFaW1Io3X9u0FZSXjoqqaPD
         sS/H1uP8qBNNdtO5Rj/aplscbvWo9wwTFb2oPpcg1Gw3XkthD7R1Ip9b4ZP4q4QGm9MB
         6zFjrGkRXJUZfHy4+y7+5H95fI3SexT8DBjMQoAFszmnJNM2g/jRSV3sUAyYOF3TyDps
         GNTHjjROdpuVwX7+I8Hbb7NBFqhM2SqvyCfp0GLjrVtswjnqAvjRi/VWqjSUjcBsSvQp
         DDuQ==
X-Gm-Message-State: AFuF++l6EKr2jogddMZg1uXSd03XUKmA5zi/5vT6SSl//ag/Q01/8QzA
	Y0GBTtsqiIU0XQam6VNnREU5YH2+yd045smGjOJSiz5tS6YafIu8zLO7iGzG/5gFQSnvkwF7Y6t
	SiX7j
X-Gm-Gg: AYBFou1SgXzKtFvAeCbR6E9xO/V8zzHXJnQCCcuAYjr3btQc1BV9ABVNPrBSmSzmBAh
	711aNRaLRZtgaJ711HOGj9KVj3dCSGIU0ri8IGioj0JIfTMQb66JzuVpN06HO1Qn2U3KhspOJ12
	BfXdN/YrQjV5eDMsBqxq3vtTv5e4avxGOuH4fEXvm84MO9i5dOjkCfB2Kg4w98ngB5EvpTch8jj
	D5qbsbTKmCDfiVXQT9qVL6CmKl6+EN1nl8d6SUT4D2IVtFjlxnQUXVGfugoB86N74ymihoZwHZN
	lUvZIkoiaZqW7nPShM+564BUxzz+L5Q4lNSrSBAO6C0XRQvb/63nLsZ1d47tWPtdHdWA8tUy1oB
	8sKZD2Kk5ZjwGAQ1VKkE5fQ6fMx27sm2URgp+A1TAWRZFNfz7aGdamixlpF8rPPhrA7fJZfLk66
	GSQO646TF1ndej6njRwtMmRaWNiIVG1T3Hco/eBTSVouaL+wwj3tvgs5QsWSEpnc2VkxVVP3tGA
	ku4QjAX3YRC2TqaZGm1SPzRV5rViQC9gZdhz6IZHAUzm2FoxApg7x0+SqY93k6FaQYAZVQxbKla
	kz4ywnhB9xT5APyYkQ==
X-Received: by 2002:a05:620a:269d:b0:939:112:d526 with SMTP id af79cd13be357-93a2987129fmr652062085a.18.1789426876176;
        Mon, 14 Sep 2026 16:01:16 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a35745ca6sm64242985a.20.2026.09.14.16.01.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 16:01:15 -0700 (PDT)
Date: Mon, 14 Sep 2026 19:01:14 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/37]
 Update to 1.98.1
In-Reply-To: <18D45D6052588A81.1538347@lists.yoctoproject.org>
Message-ID: <d5104018-8ac6-464a-7854-2b090bc12948@konsulko.com>
References: <18D45D6052588A81.1538347@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 23:01:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4845

On Fri, 11 Sep 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the scarthgap/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.96.1 -> 1.97.1 -> 1.98.0 -> 1.98.1 updates and other fixes.
>
> Note that the cargo-c updates at the start of the series are to
> recover for my originally missing the move of the cargo-c recipe out
> of recipes-devtools/rust, which I noticed after posting the last patch
> series.  This does mean there are now some out of order commits
> compared to master branch, but I think things should be back on track
> now.
>
> I intend to merge this series to scarthgap/rust by end of day Monday
> (September 14, EST) unless an issue is pointed out.

These changes have now been merged to scarthgap/rust.

Scott


> Changes:
>
> Deepesh Varatharajan (10):
>   cargo-c: update 0.10.20 -> 0.10.21
>   cargo-c: update 0.10.22 -> 0.10.23
>   cargo-c: upgrade 0.10.23 -> 0.10.24
>   rust: Fix reproducibility with shared source trees
>   rust: refactor source handling into a shared work-shared recipe
>   rust: Move do_update_snapshot to rust-source
>   rust: Upgrade 1.96.1 -> 1.97.1
>   rust: Upgrade 1.97.1 -> 1.98.0
>   rust: Fix build and oe-selftest failures with LLVM 23
>   rust: Upgrade 1.98.0 -> 1.98.1
>
> Jaipaul Cheernam (1):
>   classes-recipe: fix trailing whitespace
>
> Markus Volk (1):
>   rust: patch uninative loader into snapshot's self-contained lld
>
> Richard Purdie (2):
>   libgit: Add nativesdk variant
>   libgit2: upgrade 1.9.6 -> 1.9.7
>
> Ross Burton (17):
>   libgit2: remove library paths from installed .cmake
>   classes/rust-common: don't export rustlibdir
>   cargo: centralise anti-vendoring environment variables
>   cargo: add missing build dependencies
>   cargo-c: add missing build dependencies
>   classes/cargo_common: move PKG_CONFIG_ALLOW_CROSS export to
>     oe_cargo_fix_env
>   classes/rust: remove unused variables
>   classes/cargo: move general assignments to cargo_common.bbclass
>   classes/cargo: consolidate dependencies
>   rust: clean up dependencies
>   classes/cargo_c: inherit cargo_common
>   classes/cargo-c: remove CARGO_C_BUILD/CARGO_C_INSTALL variables
>   classes/cargo-c: pass flags via CARGO_BUILD_FLAGS
>   classes/cargo: merge oe_cargo_build into cargo_do_compile
>   libgit2: set correct homepage URL
>   classes/ptest-cargo: use oe.path.join instead of os.path.join
>   classes/ptest-cargo: add explanatory comment
>
> Scott Murray (1):
>   libgit2: backport libgit2 1.9.4
>
> Sunil Dora (1):
>   rust: Do not pass the removed x86 amx-tf32 feature to LLVM 23
>
> WXbet (1):
>   rust-target-config: set MIPS ABI in the target JSON
>
> Wang Mingyu (1):
>   libgit2: upgrade 1.9.4 -> 1.9.6
>
> Yash Shinde (2):
>   cargo-c: update 0.10.21 -> 0.10.22
>   cargo-c: upgrade 0.10.24 -> 0.10.25
>
>  classes-recipe/cargo.bbclass                  |   44 +-
>  classes-recipe/cargo_c.bbclass                |   26 +-
>  classes-recipe/cargo_common.bbclass           |   65 +-
>  classes-recipe/ptest-cargo.bbclass            |    8 +-
>  classes-recipe/rust-common.bbclass            |    6 +-
>  classes-recipe/rust-target-config.bbclass     |   12 +
>  classes-recipe/rust.bbclass                   |   22 -
>  conf/layer.conf                               |    6 +-
>  lib/oeqa/selftest/cases/rust_mixin.py         |   13 +-
>  recipes-devtools/cargo-c/cargo-c-crates.inc   | 1054 +++++++++--------
>  ...4.0.bb => cargo-c_0.10.25+cargo-0.99.0.bb} |    4 +-
>  .../rust/{cargo_1.96.1.bb => cargo_1.98.1.bb} |   21 +-
>  recipes-devtools/rust/common-source.inc       |   28 +
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch |    9 +-
>  ...lain-syscalls-as-their-time64-varian.patch |   81 --
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |    6 +-
>  ...ip-StdarchVerify-when-remote-testing.patch |   30 +
>  ...xplicit-tail-calls-disable-two-tests.patch |   39 -
>  ...ommits-from-rust-Fix-selftest-llvm23.patch |  661 +++++++++++
>  ...lls-ignore-tests-on-unsupported-llvm.patch |   96 --
>  ...llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch |   38 +
>  ...epro-issue-fix-with-cc-crate-hashmap.patch |    5 +-
>  .../rust/files/rust-oe-selftest.patch         |   24 +-
>  ...ibstd-rs_1.96.1.bb => libstd-rs_1.98.1.bb} |    4 +
>  ....96.1.bb => rust-cross-canadian_1.98.1.bb} |    0
>  ...ust-llvm_1.96.1.bb => rust-llvm_1.98.1.bb} |    1 +
>  recipes-devtools/rust/rust-snapshot.inc       |  104 +-
>  recipes-devtools/rust/rust-source.inc         |   14 +-
>  recipes-devtools/rust/rust-source_1.98.1.bb   |  128 ++
>  .../rust/{rust_1.96.1.bb => rust_1.98.1.bb}   |  129 +-
>  ...m-libraries-are-private-link-librari.patch |   40 +
>  recipes-support/libgit2/libgit2_1.9.7.bb      |   23 +
>  32 files changed, 1732 insertions(+), 1009 deletions(-)
>  rename recipes-devtools/cargo-c/{cargo-c_0.10.20+cargo-0.94.0.bb => cargo-c_0.10.25+cargo-0.99.0.bb} (82%)
>  rename recipes-devtools/rust/{cargo_1.96.1.bb => cargo_1.98.1.bb} (78%)
>  create mode 100644 recipes-devtools/rust/common-source.inc
>  delete mode 100644 recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch
>  create mode 100644 recipes-devtools/rust/files/0003-bootstrap-skip-StdarchVerify-when-remote-testing.patch
>  delete mode 100644 recipes-devtools/rust/files/0003-explicit-tail-calls-disable-two-tests.patch
>  create mode 100644 recipes-devtools/rust/files/0004-Backport-commits-from-rust-Fix-selftest-llvm23.patch
>  delete mode 100644 recipes-devtools/rust/files/0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch
>  create mode 100644 recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
>  rename recipes-devtools/rust/{libstd-rs_1.96.1.bb => libstd-rs_1.98.1.bb} (92%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.96.1.bb => rust-cross-canadian_1.98.1.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.96.1.bb => rust-llvm_1.98.1.bb} (99%)
>  create mode 100644 recipes-devtools/rust/rust-source_1.98.1.bb
>  rename recipes-devtools/rust/{rust_1.96.1.bb => rust_1.98.1.bb} (74%)
>  create mode 100644 recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch
>  create mode 100644 recipes-support/libgit2/libgit2_1.9.7.bb
>
>

