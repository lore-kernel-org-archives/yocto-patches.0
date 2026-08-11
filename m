Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300F8C5AC67
	for <webhook@archiver.kernel.org>; Tue, 11 Aug 2026 13:40:58 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.54283.1786455649115850780
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Aug 2026 06:40:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HqP/upO5;
 spf=pass (domain: konsulko.com, ip: 209.85.218.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15d47266baso324496566b.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Aug 2026 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1786455647; x=1787060447; darn=lists.yoctoproject.org;
        h=content-type:mime-version:message-id:subject:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xYQAf2xekOshwNz0Yae56goi7KPK9txr5NZPzwxFGTw=;
        b=HqP/upO5G5r7k/PLlmnA+nuB43fXclJOnYZ7UYSei+O+JDrcEWRSs8f+jT5FTtyiy1
         SqSkD+3ucN47LO+32q9TxDcxMK9FlH6/KJ2eTgLg9ylw2zJiomq0Z4wBCJNwzeLuAhPe
         lchoyfTrUqFas/piRiT6hiGKOpHZxuSYKF4zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786455647; x=1787060447;
        h=content-type:mime-version:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xYQAf2xekOshwNz0Yae56goi7KPK9txr5NZPzwxFGTw=;
        b=RbtpJjhC2xPVXiYZfiDzXRbXRBljs/wGhWtAG6GwfmBX5cxQnBcvNasGihqKeV5B+v
         RI+58rBYcXSKP5NYiIp6pvUXpaWJhyWaYKhMoqeMHpbXrKSFsEsCZMz7JRhnO55aYnh8
         +mwPSIKnuOGL39V0OjGvM0eQCLka2OiDxNGVuxMSVenR1TDpASaWboUuWFRXwfOWL7Qa
         EmG+jXhoTnVa4T9XvGdsocB/Oh7HNDztzDSZpIJuEiZ9oD6UdWQcnUUimmJKAJVecHNs
         mx14GSjf8Zu5mk/kTm7Nat6NKm3vTEC8ceovXvhVXnbifbMPq0Lb4mmQ9oNlPy/x/SXj
         Mlsg==
X-Forwarded-Encrypted: i=1; AHgh+RrhfMPINS0GiJH0eFQZN7gmC3IPNNfKYOxV9kXyIiuAqC8YGqtRVvSooGI5bR3DEdA+rkiqk6xEkRyEm7vW@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yw20JW2i9lq6yKwYiV0MXvDfnKU7IilemTOHsp6V2dJPcJKqAuU
	MXqSUL/thdj80IoXvEpNCJlluf5ZJLgo74g8CuGYmP41M036tse0FLK1dzFB4CmhiHE1tRnr9F/
	k2Azq
X-Gm-Gg: AR+sD10gvDipNrzM1jTEcQ09JCyUl+TaCDs6pYBV+yB9yOkydrR6Fmed+tHx0GG8L3V
	P9L9k13JsCnIFYmJiVWKvBqb1TQkIqfQ7Wasm4+tSi274igvO+qnvmRf9RORDfpsm//970uUaTG
	6dVOe4KRxh2603X8nZvThHFTcw/WthFlpjFk6LsFwAEQ5pkMENFB+PczyuEwbA5JShPgIUX9BmY
	sLR0S0mqsjuJLlKIzZjo/s7MQX1BLtUaFjwCG1w8lt449ZV/Iqks7a3desdRKrkQBe6zMzYVf9C
	WICndELnFeFVFNAA9A7S+krltSsiWf6PhT7mbMHLD/pdKERqA7RzPpnnneYyPNoDb/9kbXAvvuV
	0VHgIAMPOpSDngwvFUdlG3YKzFgpRy0Jta65Plw6BiXcnpz/SyXqRrljKx+b2+e3/NKwMCH4DQD
	EJLD4y1LYLo+FQRpOGiaoKBtcwZtiYI43It3P2DO2FavlLE41BEO8DU6EjoQOYRceXL+hnCTBc4
	7ZtAxWfnz2AUBUFEvxe+GpK5lCunQbtMqne48sQosxReEpFTKNv4xKmSfXA6M15cRQB/NADuVuF
	7crE5VEQ
X-Received: by 2002:a17:907:1c29:b0:c1c:4a7d:c501 with SMTP id a640c23a62f3a-c20e6001676mr197371866b.1.1786455646835;
        Tue, 11 Aug 2026 06:40:46 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e432072esm55850366b.37.2026.08.11.06.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:40:46 -0700 (PDT)
Date: Tue, 11 Aug 2026 09:40:44 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto@lists.yoctoproject.org, yocto-patches@lists.yoctoproject.org
Subject: wrynose/rust mixin available
Message-ID: <6795b198-0832-a888-7078-83fef412ab20@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Aug 2026 13:40:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4657

I have just pushed my initial release of the wrynose/rust mixin layer
branch to the meta-lts-mixins repository.  Like the previous Rust mixins,
its aim is to backport the current version of Rust in openembedded-core
master branch (currently 1.96.1) for the LTS release.  See below for the
list of backported post-6.0 changes.

Note that as with scarthgap/rust, I am attempting to ensure the selftest
passes, and at present it does for all the platforms in openembedded-core.
Since an existing selftest cannot be overlaid, the backported selftest
needs to be run as "rust_mixin" if you want to try it yourself.
See README.md in the layer for more information on the maintenance
policy.

Scott

--

Changes:

Alex Kiernan (1):
  rust-target-config: armv8a AArch32 Thumb build fixes

Alexander Kanavin (1):
  librsvg: upgrade: 2.62.2 -> 2.62.3

Deepesh Varatharajan (7):
  rust: Upgrade 1.94.1 -> 1.95.0
  rust: Upgrade 1.95.0 -> 1.96.0
  cargo-c: update 0.10.22 -> 0.10.23
  cargo-c: upgrade 0.10.23 -> 0.10.24
  rust: Fix reproducibility with shared source trees
  rust: refactor source handling into a shared work-shared recipe
  rust: Move do_update_snapshot to rust-source

George Refseth (1):
  cargo_common.bbclass: add subdir argument to git dependency to let
    cargo find crate

Jesse Van Gavere (1):
  rust: export CARGO_BUILD_TARGET

Peter Marko (2):
  cargo: set status of CVE-2023-40030
  cargo: set CVE_PRODUCT

Peter Tatrai (2):
  rust: fix codegen test failure on big-endian targets
  rust: backport explicit-tail-calls test skips for unsupported LLVM
    targets

Richard Purdie (2):
  libgit2: upgrade 1.9.2 -> 1.9.4
  libgit: Add nativesdk variant

Ross Burton (26):
  librsvg: remove obsolete .la deletion
  librsvg: consolidate DEPENDS
  librsvg: consolidate PACKAGECONFIG
  librsvg: rewrite cross gdk-pixbuf-query-loaders handling
  librsvg: remove dependency on liberation-fonts
  librsvg: add PACKAGECONFIGs for avif and gdkpixbuf
  librsvg: upgrade 2.61.3 -> 2.62.2
  classes/cargo: fix indentation
  classes/cargo: remove BUILD_MODE, replace with CARGO_PROFILE
  libgit2: remove library paths from installed .cmake
  classes/rust-common: don't export rustlibdir
  cargo: centralise anti-vendoring environment variables
  cargo: add missing build dependencies
  cargo-c: add missing build dependencies
  python3-maturin: add missing build dependencies
  python3-uv-build: add missing build dependencies
  classes/cargo_common: move PKG_CONFIG_ALLOW_CROSS export to
    oe_cargo_fix_env
  classes/rust: remove unused variables
  classes/cargo: move general assignments to cargo_common.bbclass
  classes/cargo: consolidate dependencies
  rust: clean up dependencies
  classes/cargo_c: inherit cargo_common
  classes/cargo-c: remove CARGO_C_BUILD/CARGO_C_INSTALL variables
  classes/cargo-c: pass flags via CARGO_BUILD_FLAGS
  classes/cargo: merge oe_cargo_build into cargo_do_compile
  libgit2: set correct homepage URL

Sundeep KOKKONDA (1):
  rust: Upgrade 1.96.0 -> 1.96.1

Taruntej Kanakamalla (1):
  cargo_c.bbclass: pass --libdir to cargo cinstall

WXbet (1):
  rust-target-config: set MIPS ABI in the target JSON

Wang Mingyu (1):
  libgit2: upgrade 1.9.4 -> 1.9.6

Yash Shinde (1):
  cargo-c: update 0.10.21 -> 0.10.22

 classes-recipe/cargo.bbclass                  |  36 +-
 classes-recipe/cargo_c.bbclass                |  25 +-
 classes-recipe/cargo_common.bbclass           |  68 +-
 classes-recipe/rust-common.bbclass            |   6 +-
 classes-recipe/rust-target-config.bbclass     |  39 +-
 classes-recipe/rust.bbclass                   |  22 -
 conf/layer.conf                               |   6 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |  11 +-
 recipes-devtools/cargo-c/cargo-c-crates.inc   | 953 +++++++++---------
 ...5.0.bb => cargo-c_0.10.24+cargo-0.98.0.bb} |   4 +-
 .../python/python3-maturin_1.12.%.bbappend    |   3 +
 .../python/python3-uv-build_0.10.%.bbappend   |   3 +
 .../rust/{cargo_1.94.1.bb => cargo_1.96.1.bb} |  23 +-
 recipes-devtools/rust/common-source.inc       |  28 +
 .../0001-Adjust-loongarch-assembly-test.patch |  66 --
 ...ix-flaky-assertions-in-oneshot-tests.patch |  72 --
 .../0001-Update-amdgpu-data-layout.patch      |  44 -
 ...001-Update-call-llvm-intrinsics-test.patch |  86 --
 ...teps-tool.rs-switch-off-lto-for-rust.patch |   4 +-
 ...-build-failure-with-unstable-options.patch |  63 ++
 ...xplicit-tail-calls-disable-two-tests.patch |  39 +
 ...lls-ignore-tests-on-unsupported-llvm.patch |  96 ++
 ...ild-script-path-leakage-in-artifacts.patch |  28 +
 .../rust/files/rust-oe-selftest.patch         |  52 +-
 ...ibstd-rs_1.94.1.bb => libstd-rs_1.96.1.bb} |   4 +
 recipes-devtools/rust/rust-cross-canadian.inc |   1 +
 ....94.1.bb => rust-cross-canadian_1.96.1.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       | 104 +-
 recipes-devtools/rust/rust-source.inc         |  16 +-
 recipes-devtools/rust/rust-source_1.96.1.bb   | 128 +++
 .../rust/{rust_1.94.1.bb => rust_1.96.1.bb}   | 116 +--
 recipes-gnome/librsvg/librsvg-crates.inc      | 498 ++++-----
 ...ld-do-not-force-disable-gdk-pixbuf-l.patch |  49 -
 ...append-RUSTFLAGS-to-rustc-executable.patch |   2 +-
 ...e-care-of-deprecated-assert_cmd-Comm.patch |  10 +-
 .../{librsvg_2.61.3.bb => librsvg_2.62.3.bb}  |  29 +-
 ...m-libraries-are-private-link-librari.patch |  42 +
 .../{libgit2_1.9.2.bb => libgit2_1.9.6.bb}    |  16 +-
 38 files changed, 1461 insertions(+), 1331 deletions(-)
 rename recipes-devtools/cargo-c/{cargo-c_0.10.21+cargo-0.95.0.bb => cargo-c_0.10.24+cargo-0.98.0.bb} (82%)
 create mode 100644 recipes-devtools/python/python3-maturin_1.12.%.bbappend
 create mode 100644 recipes-devtools/python/python3-uv-build_0.10.%.bbappend
 rename recipes-devtools/rust/{cargo_1.94.1.bb => cargo_1.96.1.bb} (81%)
 create mode 100644 recipes-devtools/rust/common-source.inc
 delete mode 100644 recipes-devtools/rust/files/0001-Adjust-loongarch-assembly-test.patch
 delete mode 100644 recipes-devtools/rust/files/0001-Fix-flaky-assertions-in-oneshot-tests.patch
 delete mode 100644 recipes-devtools/rust/files/0001-Update-amdgpu-data-layout.patch
 delete mode 100644 recipes-devtools/rust/files/0001-Update-call-llvm-intrinsics-test.patch
 create mode 100644 recipes-devtools/rust/files/0002-Fix-rust-build-failure-with-unstable-options.patch
 create mode 100644 recipes-devtools/rust/files/0003-explicit-tail-calls-disable-two-tests.patch
 create mode 100644 recipes-devtools/rust/files/0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch
 create mode 100644 recipes-devtools/rust/files/0005-remap-OUT_DIR-paths-to-fix-build-script-path-leakage-in-artifacts.patch
 rename recipes-devtools/rust/{libstd-rs_1.94.1.bb => libstd-rs_1.96.1.bb} (92%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.94.1.bb => rust-cross-canadian_1.96.1.bb} (100%)
 create mode 100644 recipes-devtools/rust/rust-source_1.96.1.bb
 rename recipes-devtools/rust/{rust_1.94.1.bb => rust_1.96.1.bb} (77%)
 delete mode 100644 recipes-gnome/librsvg/librsvg/0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch
 rename recipes-gnome/librsvg/{librsvg_2.61.3.bb => librsvg_2.62.3.bb} (79%)
 create mode 100644 recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch
 rename recipes-support/libgit2/{libgit2_1.9.2.bb => libgit2_1.9.6.bb} (55%)

-- 
2.55.0




