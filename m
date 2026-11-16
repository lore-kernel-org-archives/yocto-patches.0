Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6299.1794870774340480243
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:12:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=U3jpSLtQ;
 spf=pass (domain: konsulko.com, ip: 209.85.217.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so1244126137.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870773; x=1795475573; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sSDOEwypwn/QdGja4nsz2hB8GDbUg3hLyiCk3WuuUdo=;
        b=U3jpSLtQ2ZjOTz7LwO7yYBYyLOxvfSsWBfMdSj/eWFi5kFdpyR6Qx6pvoIdMXJpvIo
         Ud+0GoEpRCRv751wuLkV5+HulK2nF0nr9zVrvYXjrj7QV+IfNzzLhKxNZhQwN3cTy7K/
         CnjuU21KZhUdOWwQCq1ztD4Fuol1HtEOHwBFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870773; x=1795475573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sSDOEwypwn/QdGja4nsz2hB8GDbUg3hLyiCk3WuuUdo=;
        b=e1hwM7l74M54ymxSbA316/0r1CN7ACwceXJhEZnOc0xnSDnq6D2luYdvC2sv3gfURG
         F5M6dpbWGnj+8XpDYHHSDsiG4mJF85aIYnWVgxmNh/TNLhQ31sTOQsnwztVIbLMm5s0l
         H9uwPNOS/6EtB3XKLNOZWsppHk4dgDV1kYFngp3t8UCJj7L2/p8V9Ll8XK6ajISBWxW8
         7yGI4CkYZxMVeiy0UbKN+fyJ5t3b8QVxSy2EIMejegmu00lSjRyN1OojEp8HPCZ2haDL
         FujVM5XwuXm64mTyGq5DKGl/ZUy725nTY3+/L/lXPziG2YnlP4+TGvhRHSHX+Fmp5cne
         pDxA==
X-Gm-Message-State: APuU4Z8dZTRQ3hJtnAxtCjm2nnbQeHKMlf1iv+i5JsUJ0YxqrTGKVTUe
	bsIXgPwf0rrFcYBdDhBS+IiKRDjluaN2nnYelj5Acv7CeJJGfNPpe/aSR2KGBDtVMDJfXHSec6b
	Vt0GUwzY=
X-Gm-Gg: AYBFou00RUpUi0vbHGgFh2Cs/zAm4wgmk7u5/LofHk5HtXKTXz/sFbmAmdsTm1YrCmr
	4tMpjGXqdolbA5+D3l7BGT4FG5hunE9av2ealvRvQYrw5624iukvNTL+P/EBT3hxro6uVTmeyJG
	hbh6V34aJE9p6I+8Usrz5+Oo+wm8gOChJ/3oGsZ2enr6aqlmz63P3juBBSBtIdxZIf5AXbHvA9O
	3esGRsX+lXoLKEELGmffdgcq06XmoKPHiQk4D/e/0aPGGY5p13+Jea7oxfM3U1hj6TEHc+feJ2e
	60rHIAHYXf2Wx8q1Ho0AF6Gz0xdkUA5OW4iqciFmnNPNhx4RrEnGPMVJm3yWYSv1Kp/l3zqiLM4
	OewJb6lrpe3HDg+rA2LrFk0okX6XzPJlws3Fw8bmwlfoa8ghdMv8dUZnmz3MieQ+3UJN8HnSSdb
	5YPVLjmgwOY/LciHK2fRfHu0ZKfDjxb+4QeBBWAWemdtI2y9PdMiXGr7Z7mzgqq0BgHNhBnB2ru
	ZFb1ueJ8hFqYkvjvpAtmP5l9CjXX+x98ziuaBJx0RfM3xjTw2SZm5bbHHa9hrvOazLOBb14tR2L
	pIZnbZHQfExdmPKOz4cLHu8+L2MHrgGPB0ATKHVsMbFP6mNoAoqELX/cEeDTSoX+tk71mtIxaYT
	pU+THKJqCObTnG/eYf3fSf8i+LME/ZL2E0uL+dgzO5E2l68NvWk2lHEVlpuqdBlTGhA==
X-Received: by 2002:a05:6102:508a:b0:7a6:85d6:8ae0 with SMTP id ada2fe7eead31-7d64d474d7cmr3576483137.1.1794870772746;
        Mon, 16 Nov 2026 15:12:52 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.12.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:12:52 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 00/19] Update to 1.99.1
Date: Mon, 16 Nov 2026 18:12:21 -0500
Message-ID: <cover.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5439
Content-Type: text/plain; charset="utf-8"

This patch series for the wrynose/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.98.1 -> 1.99.0 -> 1.99.1 updates and other fixes.

I intend to merge this series to wrynose/rust by end of day tomorrow
(November 17, EST) unless an issue is pointed out.

Scott


Changes:

Ankur Tyagi (1):
  librsvg: upgrade 2.63.2 -> 2.63.3

Deepesh Varatharajan (1):
  cargo-c: upgrade 0.10.25 -> 0.10.26

Harish Sadineni (1):
  rust-cross-canadian: install target-specific env scripts and fix
    rustlib lookup

Hemanth Kumar M D (2):
  rust: Upgrade 1.98.1 -> 1.99.0
  rust-target-config: fix invalid +v5 LLVM feature for armv5

Jaipaul Cheernam (1):
  librsvg: upgrade 2.63.3 -> 2.63.4

Khem Raj (1):
  rust-common: Use 64-bit time_t libc layouts for riscv32 musl

Markus Volk (1):
  cargo_common: map the cargo vendoring directory for the C compiler

Peter Tatrai (1):
  rust: add secure-plt to generated powerpc targets

Richard Purdie (1):
  librsvg: upgrade 2.63.0 -> 2.63.2

Ross Burton (2):
  librsvg: upgrade 2.62.3 -> 2.63.0
  classes/cargo_c: use CARGO_C_BUILD_FLAGS for cargo-c flags

Sowmya Sathram (1):
  rust: Upgrade 1.99.0 -> 1.99.1

Sunil Dora (5):
  rust: drop the cc object-name reproducibility patch
  rust: hash cc object names relative to their source roots
  rust: keep the build host triple out of cargo unit metadata
  rust: backport deterministic DocLinkResMap serialisation
  rust: sort hygiene data before it is encoded

Vasileios Anagnostopoulos (1):
  ptest-cargo: align test and application build environments

 classes-recipe/cargo_c.bbclass                |   6 +-
 classes-recipe/cargo_common.bbclass           |   5 +
 classes-recipe/ptest-cargo.bbclass            |  35 +-
 classes-recipe/rust-common.bbclass            |   3 +
 classes-recipe/rust-target-config.bbclass     |   6 +-
 conf/layer.conf                               |   4 +-
 recipes-devtools/cargo-c/cargo-c-crates.inc   | 332 +++----
 ....0.bb => cargo-c_0.10.26+cargo-0.100.0.bb} |   2 +-
 .../rust/{cargo_1.98.1.bb => cargo_1.99.1.bb} |   0
 ...l-codes-on-riscv32gc-unknown-linux-g.patch | 219 -----
 ...teps-tool.rs-switch-off-lto-for-rust.patch |  51 +-
 ...ommits-from-rust-Fix-selftest-llvm23.patch | 661 -------------
 ...-host-triple-from-unit-metadata-hash.patch |  62 ++
 ...hygiene-encoding-order-deterministic.patch |  59 ++
 ...llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch |  38 -
 ...ject-names-relative-to-source-roots.patch} | 118 +--
 .../rust/files/rust-oe-selftest.patch         |  14 +-
 ...ibstd-rs_1.98.1.bb => libstd-rs_1.99.1.bb} |   0
 recipes-devtools/rust/rust-cross-canadian.inc |   9 +-
 ....98.1.bb => rust-cross-canadian_1.99.1.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       | 104 +-
 recipes-devtools/rust/rust-source.inc         |   9 +-
 ...source_1.98.1.bb => rust-source_1.99.1.bb} |   0
 .../rust/{rust_1.98.1.bb => rust_1.99.1.bb}   |   2 -
 recipes-gnome/librsvg/librsvg-crates.inc      | 924 +++++++++---------
 ...append-RUSTFLAGS-to-rustc-executable.patch |   2 +-
 ...e-care-of-deprecated-assert_cmd-Comm.patch |   2 +-
 .../{librsvg_2.62.3.bb => librsvg_2.63.4.bb}  |   2 +-
 28 files changed, 934 insertions(+), 1735 deletions(-)
 rename recipes-devtools/cargo-c/{cargo-c_0.10.25+cargo-0.99.0.bb => cargo-c_0.10.26+cargo-0.100.0.bb} (87%)
 rename recipes-devtools/rust/{cargo_1.98.1.bb => cargo_1.99.1.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
 delete mode 100644 recipes-devtools/rust/files/0004-Backport-commits-from-rust-Fix-selftest-llvm23.patch
 create mode 100644 recipes-devtools/rust/files/0004-cargo-omit-host-triple-from-unit-metadata-hash.patch
 create mode 100644 recipes-devtools/rust/files/0005-rustc-span-make-hygiene-encoding-order-deterministic.patch
 delete mode 100644 recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
 rename recipes-devtools/rust/files/{repro-issue-fix-with-cc-crate-hashmap.patch => cc-hash-object-names-relative-to-source-roots.patch} (68%)
 rename recipes-devtools/rust/{libstd-rs_1.98.1.bb => libstd-rs_1.99.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.98.1.bb => rust-cross-canadian_1.99.1.bb} (100%)
 rename recipes-devtools/rust/{rust-source_1.98.1.bb => rust-source_1.99.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.98.1.bb => rust_1.99.1.bb} (99%)
 rename recipes-gnome/librsvg/{librsvg_2.62.3.bb => librsvg_2.63.4.bb} (98%)

-- 
2.56.0

