Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DFBC55172
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:23 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4576.1785497598792109600
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZouV7YZD;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e5c92c389so42166185a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497598; x=1786102398; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PfOrdQQToWLE1fMbit773GtS4NyUQoamJQDHGurbAmw=;
        b=ZouV7YZDdD8420Guof3Wa+A62F7R7NX/9xnRjGAEaU+xvcrf4gO96mGy50NYBG82tO
         GNi7aAzDFJgZmWg/eecWbEQ6tLQj38Ffk4bSHN0h82b3y4ep7E1lW48+NZpJXdx5hk56
         KfZMRNxP+BOJKaWiMkwau00q80RjAZrQ9+ZJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497598; x=1786102398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PfOrdQQToWLE1fMbit773GtS4NyUQoamJQDHGurbAmw=;
        b=g3gqgKPk1OvO5sZBWcASoLPCkZqaDhGXCqvWdbsKIT0nReZOh3wgQg5mIgT9Hn+Ewn
         Q0yutJoxXtEdZnkpyOFdR8PcriB4xy6QJV8TWBJqpz5hlhYEm/B4d8qo+rXp/VKs/RMq
         gm4bI3g1A02EziB++9uXDI24Tar+YO0DTFTPHaJKMLZmO17lWHkFPWrPKLkkrr9A37oO
         eS317zLNrcXS1g87TP7MCoPkZm2gl1frAcx1/qyRRT3HNtbshu/ApPNY0WW+BnehDrzC
         5kpVg/bcC8+WWSydgLp+iamPBpHOsZz6pZ71FzN+o2ct7wYgNjlKZlV8B1HB0imU35Uq
         CBvA==
X-Gm-Message-State: AOJu0YwLIZSCQf4RT2AeYFsY2Jm4LZ78s7aocqi6Ui0gvgmLIyBJC7im
	vHveacazOTz4UAZB3D8PUs5iXgMILbI2Nm67ZV5NilIOhGQLk4O76ZSEX/QsRQYaI8cwEVepkcp
	hnXNX
X-Gm-Gg: AR+sD11/tnOAxToi3PasUtl+XRN4yqmKKplAtbtjQHEJG/Xy3PwCK/VfeAifUGW0BOR
	U89dLFzQYS5f08RSscQQjvNgOZ252SeTRWaUmQjZxHTIJ3tf4ISAiOWYesR4/g0nBYzDtcBgbHp
	P0tKHLxpzqfrA9yt0C3f952q0WOp+cjhRUaaY1P6YiUTkHw7mR/+sq8n/GJmWbSlHVT/sbhC58d
	uuVLRRZi1UbV6ltctDPVs0NUOQmF1kvP9F9Y5FpUtzW6NiUrK3y5fx9F+KsKnJgpupArc+o3/ld
	yKHmYazSV2dR16ockSnqnj9POtbjm8OVGuP7uAbxyFpn3LIJ7gYvO+zUb1DVac4P/2/WKuFZhtw
	Q3AzLmQl3OhFHvxqgNji4QtB4dEQbvWaTzMKbVm0xMm1gk+P1reNd5h+MBZpAfXDuANsTGd45J7
	N/xRd6JlYK+I1QJmPjKMF+fowxPOKeTWRqJ6jwug98tfQYOlFG/ZdMU+oPyiAndQ/AcVj35d3eu
	Grqik1opqqloPYoti6K++/h5HcN7gjRCkY3wUPFJGkFDC0o7zmcQetUEcd4SqTPIqs6AKJjTMZx
	ooHMFOMMAjaYsUT/pWqW7+yhXQ==
X-Received: by 2002:a05:620a:2243:10b0:92e:5c0b:a6a0 with SMTP id af79cd13be357-934965aa059mr173655985a.26.1785497597354;
        Fri, 31 Jul 2026 04:33:17 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:17 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 00/35] Update to 1.96.1
Date: Fri, 31 Jul 2026 07:32:30 -0400
Message-ID: <cover.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4576

This patch series for the scarthgap/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.92.0 -> 1.96.1 updates and other fixes.  Note that due to
scarthgap not having the later clang integration some changes
related to an issue with sstate reuse across hosts with different
toolchains ([YOCTO #16058]) are not really viable to backport with
this mixin.  I have not confirmed whether the issue exists with the
rust-llvm toolchain used to build Rust in scarthgap, if you do
encounter a similar issue while using the mixin, please let me know.

I intend to merge this series to scarthgap/rust by end of day Tuesday
(August 4, EST) unless a serious showstopper is pointed out.

Scott


Changes:

Alex Kiernan (1):
  rust-target-config: armv8a AArch32 Thumb build fixes

Alexander Kanavin (1):
  librsvg: upgrade: 2.62.2 -> 2.62.3

Changqing Li (1):
  librsvg: move symlink file for ptest in package librsvg-ptest

Deepesh Varatharajan (9):
  cargo-c: update 0.10.19 -> 0.10.20
  rust: Upgrade 1.93.0 -> 1.94.0
  cargo-c: Move recipe out of rust directory
  rust: Drop revert-link-std-statically-in-rustc_driver-feature.patch
  rust: Drop oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
  rust: Fix flaky assertions in oneshot tests
  rust: Upgrade 1.94.0 -> 1.94.1
  rust: Upgrade 1.94.1 -> 1.95.0
  rust: Upgrade 1.95.0 -> 1.96.0

George Refseth (1):
  cargo_common.bbclass: add subdir argument to git dependency to let
    cargo find crate

Harish Sadineni (1):
  rust: install Rust library sources for 'make rustavailable' support

Hemanth Kumar M D (1):
  rust: Upgrade 1.92.0 -> 1.93.0

Jesse Van Gavere (1):
  rust: export CARGO_BUILD_TARGET

Khem Raj (2):
  rust: Fix build with llvm-22
  rust: Fix loongarch unit test with llvm-22

Martin Schwan (2):
  cargo-update-recipe-crates: Don't fail for partially empty Cargo.lock
  cargo-update-recipe-crates: Properly close target file after writing

Peter Marko (2):
  cargo: set status of CVE-2023-40030
  cargo: set CVE_PRODUCT

Peter Tatrai (2):
  rust: fix codegen test failure on big-endian targets
  rust: backport explicit-tail-calls test skips for unsupported LLVM
    targets

Ross Burton (9):
  librsvg: remove obsolete .la deletion
  librsvg: consolidate DEPENDS
  librsvg: consolidate PACKAGECONFIG
  librsvg: rewrite cross gdk-pixbuf-query-loaders handling
  librsvg: remove dependency on liberation-fonts
  librsvg: add PACKAGECONFIGs for avif and gdkpixbuf
  librsvg: upgrade 2.61.3 -> 2.62.2
  classes/cargo: fix indentation
  classes/cargo: remove BUILD_MODE, replace with CARGO_PROFILE

Sundeep KOKKONDA (1):
  rust: Upgrade 1.96.0 -> 1.96.1

Taruntej Kanakamalla (1):
  cargo_c.bbclass: pass --libdir to cargo cinstall

 .../cargo-update-recipe-crates.bbclass        |  19 +-
 classes-recipe/cargo.bbclass                  |  22 +-
 classes-recipe/cargo_c.bbclass                |   1 +
 classes-recipe/cargo_common.bbclass           |   3 +
 classes-recipe/rust-target-config.bbclass     |  34 +-
 conf/layer.conf                               |   2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |   3 +-
 .../{rust => cargo-c}/cargo-c-crates.inc      | 434 +++++++--------
 ...Use-libc-SYS_futex_time64-on-riscv32.patch |   0
 .../cargo-c_0.10.20+cargo-0.94.0.bb}          |   2 +-
 .../rust/{cargo_1.92.0.bb => cargo_1.96.1.bb} |   4 +
 ...teps-tool.rs-switch-off-lto-for-rust.patch |   4 +-
 ...-build-failure-with-unstable-options.patch |  63 +++
 ...xplicit-tail-calls-disable-two-tests.patch |  39 ++
 ...lls-ignore-tests-on-unsupported-llvm.patch |  96 ++++
 ...crease-timeout-in-process-sigpipe-ru.patch |  31 --
 ...d-statically-in-rustc_driver-feature.patch | 229 --------
 .../rust/files/rust-oe-selftest.patch         | 115 ++--
 ...ibstd-rs_1.92.0.bb => libstd-rs_1.96.1.bb} |   0
 recipes-devtools/rust/rust-cross-canadian.inc |   1 +
 ....92.0.bb => rust-cross-canadian_1.96.1.bb} |   0
 ...-llvm-allow-env-override-of-exe-path.patch |   8 +-
 ...ust-llvm_1.92.0.bb => rust-llvm_1.96.1.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       | 102 ++--
 recipes-devtools/rust/rust-source.inc         |   7 +-
 .../rust/{rust_1.92.0.bb => rust_1.96.1.bb}   |  19 +-
 recipes-gnome/librsvg/librsvg-crates.inc      | 498 +++++++++---------
 ...ld-do-not-force-disable-gdk-pixbuf-l.patch |  49 --
 ...append-RUSTFLAGS-to-rustc-executable.patch |   2 +-
 ...e-care-of-deprecated-assert_cmd-Comm.patch |  10 +-
 .../{librsvg_2.61.3.bb => librsvg_2.62.3.bb}  |  30 +-
 31 files changed, 912 insertions(+), 915 deletions(-)
 rename recipes-devtools/{rust => cargo-c}/cargo-c-crates.inc (72%)
 rename recipes-devtools/{rust => cargo-c}/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch (100%)
 rename recipes-devtools/{rust/cargo-c_0.10.19+cargo-0.93.0.bb => cargo-c/cargo-c_0.10.20+cargo-0.94.0.bb} (87%)
 rename recipes-devtools/rust/{cargo_1.92.0.bb => cargo_1.96.1.bb} (97%)
 create mode 100644 recipes-devtools/rust/files/0002-Fix-rust-build-failure-with-unstable-options.patch
 create mode 100644 recipes-devtools/rust/files/0003-explicit-tail-calls-disable-two-tests.patch
 create mode 100644 recipes-devtools/rust/files/0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch
 delete mode 100644 recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
 delete mode 100644 recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
 rename recipes-devtools/rust/{libstd-rs_1.92.0.bb => libstd-rs_1.96.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.92.0.bb => rust-cross-canadian_1.96.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.92.0.bb => rust-llvm_1.96.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.92.0.bb => rust_1.96.1.bb} (95%)
 delete mode 100644 recipes-gnome/librsvg/librsvg/0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch
 rename recipes-gnome/librsvg/{librsvg_2.61.3.bb => librsvg_2.62.3.bb} (79%)

-- 
2.55.0


