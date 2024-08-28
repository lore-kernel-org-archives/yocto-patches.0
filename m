Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08817C6FD36
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:09:55 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web11.5839.1724875789152925660
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XQLcKbA7;
 spf=pass (domain: konsulko.com, ip: 209.85.166.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-81f861f369aso32924839f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875788; x=1725480588; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JRcoZdnACpgGbY4yHtLv4CYJXENmo1UNVF2OsGKEoGo=;
        b=XQLcKbA7uFdfhtZA2li7fYbIjVNxL+G8XyNkBVLM2YD2iBGYHGjbJTYDK7EUiaZu2o
         Q7kPlHUqXwK67xRSHLlZTLLRo8V6y8U42uxUxH2SA+Diyx7LJ3oibOCkq4kt7JONaNOJ
         nkEjVw6r+OC2I7hNhsngs0YwqXSRzcpZ36wUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875788; x=1725480588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRcoZdnACpgGbY4yHtLv4CYJXENmo1UNVF2OsGKEoGo=;
        b=fwL2X5yuaQdPJi1knqLHoN2kGB3T44g7rJO50vzbN8k/w+szWAGcF6nzuiC2v/358g
         aGCcV8Ohi3Ne+Z5wUQYiDBi9xYfgD8obYMEgNTPiQnTcak+ljmOAlqgF53DfBDZJPTLi
         SkJ5SL/uOjHBShxi6p/1qpI9vVjBqjO/M9V8307eHm68nYqc5bXUqsWKFMrAAZCdkIRD
         OhmMa1kJ/juXK83LTyGOFJXtd/djAZEs4TUl93QNH+7AjAu597JO40dZot+hh2PJSlar
         QKr+ietw0gaQb7hATKcpjTiP4niaTT64w4xc/XtT2jZcPrmNTL2iz7eEuYP0bv05Y+dQ
         lkJw==
X-Gm-Message-State: AOJu0Yy8U9n63vDFxkx2vApDz9pNTc3sT7mk5x8d2Wp2VM5BJx/jc2Qk
	tptY9XVooa6O4wO93tD/62pbWC3IYTjaRa3HGn4dxyXWCsjOKjrVzrc3mLYIJDqDKLyeAmg1MPC
	X
X-Google-Smtp-Source: AGHT+IFEbXeZv1G7e7N7OsN6kjTizIuoHhFQ+iy/O1i4YCjV+RJ2ITWNNyi20xb27d5Bqv//XZObBA==
X-Received: by 2002:a92:cd88:0:b0:39d:6377:7c02 with SMTP id e9e14a558f8ab-39f38aee5e6mr2768015ab.4.1724875787727;
        Wed, 28 Aug 2024 13:09:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 00/33] Update to Rust 1.78.0
Date: Wed, 28 Aug 2024 16:08:46 -0400
Message-ID: <cover.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:09:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/567

This patch series for the kirkstone/rust mixin layer backports the
various Rust toolchain changes in oe-core master to get through the
1.75.0 -> 1.76.0 -> 1.77.0 -> 1.78.0 updates that have landed in
the last few months in oe-core.  As the updated README.md mentions,
not all of those interim versions have been tested at this time,
so you will want to do some validation testing (which you likely
should be doing, anyways) if you want to point at e.g. 1.76.0.
I intend to push this series to kirkstone/rust within 48 hours
unless a serious showstopper is pointed out.

Once the dust has settled on the update to 1.79.0 in oe-core, I
should have that out relatively quickly as a follow-up to this
series.

Changes:

Alex Kiernan (2):
  packagegroup-rust-sdk-target: Add Rust SDK target packagegroup
  packagegroup-rust-sdk-target: Add cargo

Alexander Kanavin (6):
  librsvg: upgrade 2.56.3 -> 2.57.1
  rust: correctly link rust-snapshot into build/stage0
  rust: add reproducibility patch to eliminate host leakage
  rust: use rust-snapshot binaries only in rust-native
  rust: build the default set of tools
  devtool/upgrade: rename RECIPE_UPDATE_EXTRA_TASKS ->
    RECIPE_UPGRADE_EXTRA_TASKS

Chris Spencer (1):
  cargo_common.bbclass: Support git repos with submodules

Harish Sadineni (1):
  rust: set CVE_STATUS for CVE-2024-24576

Peter Marko (2):
  cargo: remove True option to getVar calls
  libstd-rs,rust-cross-canadian: set CVE_PRODUCT to rust

Ross Burton (2):
  librsvg: don't try to run target code at build time
  librsvg: upgrade to 2.57.3

Scott Murray (3):
  Add ptest-cargo.bbclass
  Add cairo backport
  Rework and update README

Sundeep KOKKONDA (2):
  rust: reproducibility issue fix with v1.75
  rust: rustdoc reproducibility issue fix

Tim Orling (1):
  cargo-update-recipe-crates: add RECIPE_UPDATE_EXTRA_TASKS

Tronje Krabbe (1):
  rust-target-config: Update data layouts for 32-bit arm targets

Wang Mingyu (2):
  librsvg: upgrade 2.57.3 -> 2.58.1
  librsvg: upgrade 2.58.1 -> 2.58.2

Willy Tu (1):
  rust-target-config: fix feature for vfpv4f16

Yash Shinde (9):
  rust: Oe-selftest fixes for rust v1.76
  rust: Upgrade 1.75.0->1.76.0
  rust: reproducibility issue fix with v1.76
  rust: Oe-selftest changes for rust v1.77
  rust: Upgrade 1.76.0->1.77.0
  rust: Upgrade 1.77.0->1.77.1
  rust: Upgrade 1.77.1->1.77.2
  rust: Oe-selftest changes for rust v1.78
  rust: Upgrade 1.77.2->1.78.0

 README                                        |   40 -
 README.md                                     |   88 +
 classes/cargo-update-recipe-crates.bbclass    |    2 +
 classes/cargo_common.bbclass                  |    6 +-
 classes/ptest-cargo.bbclass                   |  138 ++
 classes/rust-target-config.bbclass            |    7 +-
 conf/layer.conf                               |    2 +-
 .../packagegroup-rust-sdk-target.bb           |   14 +
 .../rust/{cargo_1.75.0.bb => cargo_1.78.0.bb} |    0
 ...endored-sources-when-remapping-paths.patch |   46 -
 ...e-absolute-paths-to-OUT_DIR-as-relat.patch |   67 -
 ...te-host-information-into-compilation.patch |   51 +
 recipes-devtools/rust/files/cargo-path.patch  |   37 -
 .../rust/files/cross-targets-backport.patch   |   31 +
 .../rust/files/custom-target-cfg.patch        |   90 -
 .../rust/files/hardcodepaths.patch            |   49 +-
 ...epro-issue-fix-with-cc-crate-hashmap.patch |  114 ++
 .../files/repro-issue-fix-with-v175.patch     |   23 -
 .../rust/files/rust-oe-selftest.patch         |  392 +++++
 .../rust/files/rustc-bootstrap.patch          |   21 -
 ...ue-fix-cargo-config-for-codegenunits.patch |   26 +
 .../files/rv32-cargo-rustix-0.38.19-fix.patch |   70 -
 .../files/rv32-cargo-rustix-0.38.28-fix.patch |   70 +
 .../rust/files/rv32-missing-syscalls.patch    | 1503 ----------------
 .../rust/files/rv32-rustix-libc-backend.patch |    5 +-
 .../rust/files/target-build-value.patch       |   26 -
 .../rust/files/zlib-off64_t.patch             |   27 +-
 ...ibstd-rs_1.75.0.bb => libstd-rs_1.78.0.bb} |    2 +
 recipes-devtools/rust/rust-cross-canadian.inc |    1 +
 ....75.0.bb => rust-cross-canadian_1.78.0.bb} |    0
 ...ust-llvm_1.75.0.bb => rust-llvm_1.78.0.bb} |    0
 recipes-devtools/rust/rust-snapshot.inc       |   69 +-
 recipes-devtools/rust/rust-source.inc         |   19 +-
 .../rust/{rust_1.75.0.bb => rust_1.78.0.bb}   |   22 +-
 recipes-gnome/librsvg/librsvg-crates.inc      |  778 ++++-----
 .../librsvg/0001-Add-riscv32-support.patch    | 1511 -----------------
 ...-rust-target-to-cargo-also-when-not-.patch |   13 +-
 .../librsvg/disable-rsvg-loader-test.patch    |   40 +
 .../{librsvg_2.56.3.bb => librsvg_2.58.2.bb}  |    7 +-
 ...tmap_surface-bsc1036789-CVE-2017-7475.diff |   22 +
 recipes-graphics/cairo/cairo_1.18.0.bb        |   86 +
 41 files changed, 1561 insertions(+), 3954 deletions(-)
 delete mode 100644 README
 create mode 100644 README.md
 create mode 100644 classes/ptest-cargo.bbclass
 create mode 100644 recipes-core/packagegroups/packagegroup-rust-sdk-target.bb
 rename recipes-devtools/rust/{cargo_1.75.0.bb => cargo_1.78.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-Handle-vendored-sources-when-remapping-paths.patch
 delete mode 100644 recipes-devtools/rust/files/0001-Revert-Map-source-absolute-paths-to-OUT_DIR-as-relat.patch
 create mode 100644 recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-into-compilation.patch
 delete mode 100644 recipes-devtools/rust/files/cargo-path.patch
 create mode 100644 recipes-devtools/rust/files/cross-targets-backport.patch
 delete mode 100644 recipes-devtools/rust/files/custom-target-cfg.patch
 create mode 100644 recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.patch
 delete mode 100644 recipes-devtools/rust/files/repro-issue-fix-with-v175.patch
 create mode 100644 recipes-devtools/rust/files/rust-oe-selftest.patch
 delete mode 100644 recipes-devtools/rust/files/rustc-bootstrap.patch
 create mode 100644 recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch
 delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.19-fix.patch
 create mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.28-fix.patch
 delete mode 100644 recipes-devtools/rust/files/rv32-missing-syscalls.patch
 delete mode 100644 recipes-devtools/rust/files/target-build-value.patch
 rename recipes-devtools/rust/{libstd-rs_1.75.0.bb => libstd-rs_1.78.0.bb} (98%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.75.0.bb => rust-cross-canadian_1.78.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.75.0.bb => rust-llvm_1.78.0.bb} (100%)
 rename recipes-devtools/rust/{rust_1.75.0.bb => rust_1.78.0.bb} (94%)
 delete mode 100644 recipes-gnome/librsvg/librsvg/0001-Add-riscv32-support.patch
 create mode 100644 recipes-gnome/librsvg/librsvg/disable-rsvg-loader-test.patch
 rename recipes-gnome/librsvg/{librsvg_2.56.3.bb => librsvg_2.58.2.bb} (91%)
 create mode 100644 recipes-graphics/cairo/cairo/cairo-get_bitmap_surface-bsc1036789-CVE-2017-7475.diff
 create mode 100644 recipes-graphics/cairo/cairo_1.18.0.bb

-- 
2.46.0


