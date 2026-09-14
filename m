Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C1AC88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 23:00:51 +0000 (UTC)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10973.1789426845102015347
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 16:00:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=eDrPhUli;
 spf=pass (domain: konsulko.com, ip: 74.125.228.140, mailfrom: scott.murray@konsulko.com)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663c2so389269166b.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 16:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789426843; x=1790031643; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dt39EZU6g/LvBHa+gYXRoV8+A49AxullaB2Etjwo640=;
        b=eDrPhUliLHpAYOH2zRecYUnKl5WBgVDdERf3jArS+CExJdOT4RhxDmTGU72/JH2NhK
         ZSn11xsdHUHFcznwDHmvnubVIhuxMBNwzqLWbzs82+l6vT00a4n7na4o3ZD8Uz3/zwzo
         BFqjxL+SZoZWOD0j7lWk3h9GyV4kcNLAGPWWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426843; x=1790031643;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dt39EZU6g/LvBHa+gYXRoV8+A49AxullaB2Etjwo640=;
        b=ZHpdNlJzdGacb24pQLv1qbeKYJ5IZB4jZB8CNw6FMTdM2z0QbJ9cBPQqJMYMJk0nB2
         xUgTiU+9UIyBRLO8p6sUeb6flhzketMJN0UFe9L94Oxr+OkbluR3z/T3+w8L/Qyr44Wi
         +Sv56uryRnLWwjtrrf46CYDa64P31LyXkp2+esBn2r0uD93k/MuA9+lkGl2swbQsFdHg
         748FyhF19vBfoQGn5GJEEkkhC5nMDdeizK7g+MpWl2u4e8MmDuMcRw4q1XSDR1P4mR4o
         8h/5Y5Y2bGAITEsiDNdgBgjIBOTqXg2B8rGRzFL9PygvS4dIKtlAmU9SWr5A0MEUptw4
         c+mw==
X-Gm-Message-State: AFuF++l7fDuj/M14tcu/H6aihPKAEiLUQMwlyfIMVIgZv550YMylrZxV
	FP/Ft9rd6GYI55zC5PN6ua20CZ2MimBa/lA/JguGbOZyWY9UMCqChALd+d2vYSoF7FICXcDGcVK
	/bP1E
X-Gm-Gg: AYBFou0sS/bBUXyKL5KOFJ+Kod1Lz0AWJufpqXwnOVsc2TJ5seE54cOdB8YDaFVJS4T
	MFbqpcJvS/OjESTa5PXw/Iz6qa40uhsl87/U45V0QA5OrjaD6e8az3jpeQcge1djBzTHzgBmxXT
	TGQQbF4yMqxZGl71iUGOX+vyPKB0y09B25q5RA7+dlrSIza4VeysKnTQKQyLt80izraOSoWI+1C
	IWm26GlNjCbxJTZxYyWvqgcFue7oThOOFqr5WE5vfC29Yc6ap+7MPaGhSiJ+wi4wz9CzFBRuOAY
	gpycg77htwzDLDoGynizEVHijZ0jN9sDjVHdOXFXrp2OZMMFuo+zN9wsBEyO/oFAPhX1chM/udD
	6oMP8kaxqUHli31aoMYJMFWTM5sQDhUn3cLLmGA8AU/UUdOMnrcQlkx9/beqJxu/XAM069zqpef
	yfSe9Xi2sShC+S8zDub5+vnj8tB3iL1LPPft54bTd1gbgAB3+pimFTYQsTicnUPljc1K0YMC6sE
	n7pWB9uYNKynsJEwDUhZU7yYkmRPLmKniVNmw7Da/oKuNIryb++ZuLSmUYZhF5I/7Eu5AX4NVUe
	RzcJOAyFFm+D5IORpLc=
X-Received: by 2002:a17:907:728d:b0:c20:9447:bd5e with SMTP id a640c23a62f3a-c29b84d72b1mr602169166b.9.1789426842977;
        Mon, 14 Sep 2026 16:00:42 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966103984sm494798466b.52.2026.09.14.16.00.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 16:00:42 -0700 (PDT)
Date: Mon, 14 Sep 2026 19:00:39 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][wrynose/rust][PATCH 00/11]
 Update to 1.98.1
In-Reply-To: <18D45D782498E64F.1538347@lists.yoctoproject.org>
Message-ID: <76b4e0f8-437a-862e-c0b1-0ee191b69620@konsulko.com>
References: <18D45D782498E64F.1538347@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 23:00:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4844

On Fri, 11 Sep 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the wrynose/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.96.1 -> 1.97.1 -> 1.98.0 -> 1.98.1 updates and other fixes.
>
> Note that the clang reproducibility fix included as part of the
> 1.97.1 upgrade has not been included due to the number of bbappends
> it would entail, and the potential to incur maintenance hassles down
> the road.  I plan to try submitting it as a separate backport for
> oe-core wrynose branch when I have the time to crank through the
> required testing.
>
> I intend to merge this series to wrynose/rust by end of day Monday
> (September 14, EST) unless an issue is pointed out.

These changes have now been merged to wrynose/rust.

Scott


> Changes:
>
> Deepesh Varatharajan (4):
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
> Richard Purdie (1):
>   libgit2: upgrade 1.9.6 -> 1.9.7
>
> Ross Burton (2):
>   classes/ptest-cargo: use oe.path.join instead of os.path.join
>   classes/ptest-cargo: add explanatory comment
>
> Sunil Dora (1):
>   rust: Do not pass the removed x86 amx-tf32 feature to LLVM 23
>
> Yash Shinde (1):
>   cargo-c: upgrade 0.10.24 -> 0.10.25
>
>  classes-recipe/ptest-cargo.bbclass            |   8 +-
>  classes-recipe/rust-target-config.bbclass     |   5 +
>  conf/layer.conf                               |   4 +-
>  lib/oeqa/selftest/cases/rust_mixin.py         |   4 +-
>  recipes-devtools/cargo-c/cargo-c-crates.inc   | 561 ++++++++-------
>  ...8.0.bb => cargo-c_0.10.25+cargo-0.99.0.bb} |   2 +-
>  .../rust/{cargo_1.96.1.bb => cargo_1.98.1.bb} |   0
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch |   9 +-
>  ...lain-syscalls-as-their-time64-varian.patch |  81 ---
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |   6 +-
>  ...ip-StdarchVerify-when-remote-testing.patch |  30 +
>  ...xplicit-tail-calls-disable-two-tests.patch |  39 --
>  ...ommits-from-rust-Fix-selftest-llvm23.patch | 661 ++++++++++++++++++
>  ...lls-ignore-tests-on-unsupported-llvm.patch |  96 ---
>  ...ild-script-path-leakage-in-artifacts.patch |  28 -
>  ...llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch |  38 +
>  ...epro-issue-fix-with-cc-crate-hashmap.patch |   5 +-
>  .../rust/files/rust-oe-selftest.patch         |  24 +-
>  ...ibstd-rs_1.96.1.bb => libstd-rs_1.98.1.bb} |   0
>  ....96.1.bb => rust-cross-canadian_1.98.1.bb} |   0
>  recipes-devtools/rust/rust-snapshot.inc       | 104 +--
>  recipes-devtools/rust/rust-source.inc         |   9 +-
>  ...source_1.96.1.bb => rust-source_1.98.1.bb} |   0
>  .../rust/{rust_1.96.1.bb => rust_1.98.1.bb}   |  11 +-
>  ...m-libraries-are-private-link-librari.patch |   4 +-
>  .../{libgit2_1.9.6.bb => libgit2_1.9.7.bb}    |   2 +-
>  26 files changed, 1109 insertions(+), 622 deletions(-)
>  rename recipes-devtools/cargo-c/{cargo-c_0.10.24+cargo-0.98.0.bb => cargo-c_0.10.25+cargo-0.99.0.bb} (87%)
>  rename recipes-devtools/rust/{cargo_1.96.1.bb => cargo_1.98.1.bb} (100%)
>  delete mode 100644 recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch
>  create mode 100644 recipes-devtools/rust/files/0003-bootstrap-skip-StdarchVerify-when-remote-testing.patch
>  delete mode 100644 recipes-devtools/rust/files/0003-explicit-tail-calls-disable-two-tests.patch
>  create mode 100644 recipes-devtools/rust/files/0004-Backport-commits-from-rust-Fix-selftest-llvm23.patch
>  delete mode 100644 recipes-devtools/rust/files/0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch
>  delete mode 100644 recipes-devtools/rust/files/0005-remap-OUT_DIR-paths-to-fix-build-script-path-leakage-in-artifacts.patch
>  create mode 100644 recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
>  rename recipes-devtools/rust/{libstd-rs_1.96.1.bb => libstd-rs_1.98.1.bb} (100%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.96.1.bb => rust-cross-canadian_1.98.1.bb} (100%)
>  rename recipes-devtools/rust/{rust-source_1.96.1.bb => rust-source_1.98.1.bb} (100%)
>  rename recipes-devtools/rust/{rust_1.96.1.bb => rust_1.98.1.bb} (95%)
>  rename recipes-support/libgit2/{libgit2_1.9.6.bb => libgit2_1.9.7.bb} (92%)
>
>

