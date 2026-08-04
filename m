Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4151FC55822
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 21:19:48 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27067.1785878385050874102
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Aug 2026 14:19:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=L8CgUPFU;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e55b62640so20574385a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785878384; x=1786483184; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ly671CnyY4j2lluVRKolKQ4db1kss52xXjQYc8wRoe8=;
        b=L8CgUPFUIgUMA8cM/U0pg2zhPMi2M6CSpt/fJ2shOeRafrOfJ9bcNEtIOGBdZjxp2d
         tSiHmhfpCMx3YEnFUPGg94oMQ4CWXyN4UE4GdbJPgJ5e+9dJi1VeO+tCLTawllJJa+z8
         xyxBijnISl7HYUN6F2qYfPvJhQpWgRZC7xLBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878384; x=1786483184;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ly671CnyY4j2lluVRKolKQ4db1kss52xXjQYc8wRoe8=;
        b=WBAEU35zyHdkvB5ZAsVmF5sUId4PXLu1TEBSPOMYPaM2KTd/9KMT+UWx4Og4icJIol
         +q2Vl1B6njAngRt9BlwlkigxXqoqKHdpvG48SkZvI5QxTxsSWQjQOShj4Ab67Oa8wkLs
         ZfKAtf+QFmtGsUz2P5jS+qxwq/9tjQivSa4/pnrmzcAuogJRIjL4lr0jC14pg2pbTw1n
         Ca0OCdqRQAhiW6r6Nw7+MrV1OoWKzHRKn+S0T4OcLR5teXeYMMNvCFOb4w26rlF2H4y5
         OzGfu2St5fwvlB5f+ZO11M/pN0oDim4n9L72ZpxK2Nkprg/QT1s6dgEsXGzoLrMOcGF7
         /Qcw==
X-Gm-Message-State: AOJu0YzUP0Epv83aLRRIwua3IJ5nUet86VqpipHEFcJ5U1JQBPbelJSv
	jce8sP/29lDm0kaDgF5E3zRcPcEBzeVtKA7Svm4OTvCbBchJnEi/HbZpd3z5luatkqaGO4T9END
	iXZMN
X-Gm-Gg: AR+sD12RF5z92SFzfPzhOB++lKCO2643L1JEs4xLFxulivcNgLrmSktC/JKNpqEA7fE
	2fyL/220s6fyV4NefmOpbUW82Twy6nKZ3v/uqnQwo5VXVpDMPbo6Ga9z1le8TdUhZ/cvI5V6v3E
	DayvHqDB+ZGfWMSFPYcz8f6wfROYXDm8s/XU2QQmOutlvLgAFE/I7sZJmA1Yyr5mUbSqzMTxG/P
	e5SZwsOfKnGCn3rXJAKDeGEmw2sPAxTaAHRKArFo71044GNYY1D+O7Qv3YW1qpqLuuI2wkzRfkp
	mNWo2PF8faFA/1c1WcSqh+dYqrJ+eCugPtR9p1uwRrBNudTS1QgrLQr04x54+rMFOzSLxDFxwDD
	xUWiYnxi+7wCLWRbbyK5jur3gnxlHPP71PQa3XUV2I4xvODxcjEzdF6crf6ZsM7uZukQSaA1SAo
	yu7pnYmBiDVd+VCjSwCYy+XccKN9XTl4nHpHlSIfgdg6xyYUt3FKZb2kGWY9lEObpPbD5iQ7FY1
	y+1VMg2Bvy9bAt5pyxMC+vU6/v72RQ3lRxvZYMmHD1+s2QCNEI15kUnhVzfKEoOL6npWwFAdwAa
	ENpUdXCG
X-Received: by 2002:a05:620a:2616:b0:92e:4927:1ff9 with SMTP id af79cd13be357-936491302dcmr157468485a.40.1785878382672;
        Tue, 04 Aug 2026 14:19:42 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a58d498sm18199685a.39.2026.08.04.14.19.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:19:42 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:19:26 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/35]
 Update to 1.96.1
In-Reply-To: <18C75C9B3F4EC7FF.1793795@lists.yoctoproject.org>
Message-ID: <57b8baa1-9c24-b9b1-fcc7-5f4ff8172fdf@konsulko.com>
References: <18C75C9B3F4EC7FF.1793795@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 21:19:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4625

On Fri, 31 Jul 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series for the scarthgap/rust mixin layer backports the
> recent Rust toolchain changes in oe-core master branch to pull in
> the 1.92.0 -> 1.96.1 updates and other fixes.  Note that due to
> scarthgap not having the later clang integration some changes
> related to an issue with sstate reuse across hosts with different
> toolchains ([YOCTO #16058]) are not really viable to backport with
> this mixin.  I have not confirmed whether the issue exists with the
> rust-llvm toolchain used to build Rust in scarthgap, if you do
> encounter a similar issue while using the mixin, please let me know.
>
> I intend to merge this series to scarthgap/rust by end of day Tuesday
> (August 4, EST) unless a serious showstopper is pointed out.

These have now been merged to scarthgap/rust.

Scott


> Changes:
>
> Alex Kiernan (1):
>   rust-target-config: armv8a AArch32 Thumb build fixes
>
> Alexander Kanavin (1):
>   librsvg: upgrade: 2.62.2 -> 2.62.3
>
> Changqing Li (1):
>   librsvg: move symlink file for ptest in package librsvg-ptest
>
> Deepesh Varatharajan (9):
>   cargo-c: update 0.10.19 -> 0.10.20
>   rust: Upgrade 1.93.0 -> 1.94.0
>   cargo-c: Move recipe out of rust directory
>   rust: Drop revert-link-std-statically-in-rustc_driver-feature.patch
>   rust: Drop oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
>   rust: Fix flaky assertions in oneshot tests
>   rust: Upgrade 1.94.0 -> 1.94.1
>   rust: Upgrade 1.94.1 -> 1.95.0
>   rust: Upgrade 1.95.0 -> 1.96.0
>
> George Refseth (1):
>   cargo_common.bbclass: add subdir argument to git dependency to let
>     cargo find crate
>
> Harish Sadineni (1):
>   rust: install Rust library sources for 'make rustavailable' support
>
> Hemanth Kumar M D (1):
>   rust: Upgrade 1.92.0 -> 1.93.0
>
> Jesse Van Gavere (1):
>   rust: export CARGO_BUILD_TARGET
>
> Khem Raj (2):
>   rust: Fix build with llvm-22
>   rust: Fix loongarch unit test with llvm-22
>
> Martin Schwan (2):
>   cargo-update-recipe-crates: Don't fail for partially empty Cargo.lock
>   cargo-update-recipe-crates: Properly close target file after writing
>
> Peter Marko (2):
>   cargo: set status of CVE-2023-40030
>   cargo: set CVE_PRODUCT
>
> Peter Tatrai (2):
>   rust: fix codegen test failure on big-endian targets
>   rust: backport explicit-tail-calls test skips for unsupported LLVM
>     targets
>
> Ross Burton (9):
>   librsvg: remove obsolete .la deletion
>   librsvg: consolidate DEPENDS
>   librsvg: consolidate PACKAGECONFIG
>   librsvg: rewrite cross gdk-pixbuf-query-loaders handling
>   librsvg: remove dependency on liberation-fonts
>   librsvg: add PACKAGECONFIGs for avif and gdkpixbuf
>   librsvg: upgrade 2.61.3 -> 2.62.2
>   classes/cargo: fix indentation
>   classes/cargo: remove BUILD_MODE, replace with CARGO_PROFILE
>
> Sundeep KOKKONDA (1):
>   rust: Upgrade 1.96.0 -> 1.96.1
>
> Taruntej Kanakamalla (1):
>   cargo_c.bbclass: pass --libdir to cargo cinstall
>
>  .../cargo-update-recipe-crates.bbclass        |  19 +-
>  classes-recipe/cargo.bbclass                  |  22 +-
>  classes-recipe/cargo_c.bbclass                |   1 +
>  classes-recipe/cargo_common.bbclass           |   3 +
>  classes-recipe/rust-target-config.bbclass     |  34 +-
>  conf/layer.conf                               |   2 +-
>  lib/oeqa/selftest/cases/rust_mixin.py         |   3 +-
>  .../{rust => cargo-c}/cargo-c-crates.inc      | 434 +++++++--------
>  ...Use-libc-SYS_futex_time64-on-riscv32.patch |   0
>  .../cargo-c_0.10.20+cargo-0.94.0.bb}          |   2 +-
>  .../rust/{cargo_1.92.0.bb => cargo_1.96.1.bb} |   4 +
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |   4 +-
>  ...-build-failure-with-unstable-options.patch |  63 +++
>  ...xplicit-tail-calls-disable-two-tests.patch |  39 ++
>  ...lls-ignore-tests-on-unsupported-llvm.patch |  96 ++++
>  ...crease-timeout-in-process-sigpipe-ru.patch |  31 --
>  ...d-statically-in-rustc_driver-feature.patch | 229 --------
>  .../rust/files/rust-oe-selftest.patch         | 115 ++--
>  ...ibstd-rs_1.92.0.bb => libstd-rs_1.96.1.bb} |   0
>  recipes-devtools/rust/rust-cross-canadian.inc |   1 +
>  ....92.0.bb => rust-cross-canadian_1.96.1.bb} |   0
>  ...-llvm-allow-env-override-of-exe-path.patch |   8 +-
>  ...ust-llvm_1.92.0.bb => rust-llvm_1.96.1.bb} |   0
>  recipes-devtools/rust/rust-snapshot.inc       | 102 ++--
>  recipes-devtools/rust/rust-source.inc         |   7 +-
>  .../rust/{rust_1.92.0.bb => rust_1.96.1.bb}   |  19 +-
>  recipes-gnome/librsvg/librsvg-crates.inc      | 498 +++++++++---------
>  ...ld-do-not-force-disable-gdk-pixbuf-l.patch |  49 --
>  ...append-RUSTFLAGS-to-rustc-executable.patch |   2 +-
>  ...e-care-of-deprecated-assert_cmd-Comm.patch |  10 +-
>  .../{librsvg_2.61.3.bb => librsvg_2.62.3.bb}  |  30 +-
>  31 files changed, 912 insertions(+), 915 deletions(-)
>  rename recipes-devtools/{rust => cargo-c}/cargo-c-crates.inc (72%)
>  rename recipes-devtools/{rust => cargo-c}/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch (100%)
>  rename recipes-devtools/{rust/cargo-c_0.10.19+cargo-0.93.0.bb => cargo-c/cargo-c_0.10.20+cargo-0.94.0.bb} (87%)
>  rename recipes-devtools/rust/{cargo_1.92.0.bb => cargo_1.96.1.bb} (97%)
>  create mode 100644 recipes-devtools/rust/files/0002-Fix-rust-build-failure-with-unstable-options.patch
>  create mode 100644 recipes-devtools/rust/files/0003-explicit-tail-calls-disable-two-tests.patch
>  create mode 100644 recipes-devtools/rust/files/0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch
>  delete mode 100644 recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
>  delete mode 100644 recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
>  rename recipes-devtools/rust/{libstd-rs_1.92.0.bb => libstd-rs_1.96.1.bb} (100%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.92.0.bb => rust-cross-canadian_1.96.1.bb} (100%)
>  rename recipes-devtools/rust/{rust-llvm_1.92.0.bb => rust-llvm_1.96.1.bb} (100%)
>  rename recipes-devtools/rust/{rust_1.92.0.bb => rust_1.96.1.bb} (95%)
>  delete mode 100644 recipes-gnome/librsvg/librsvg/0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch
>  rename recipes-gnome/librsvg/{librsvg_2.61.3.bb => librsvg_2.62.3.bb} (79%)
>
>

