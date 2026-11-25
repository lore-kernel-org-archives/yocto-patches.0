Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3052.1795645884225211200
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gjvMhdG5;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53644ab1f7bso56516881cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645883; x=1796250683; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/vAfqa5iQmgN4yOlI3ann4an+CSVfZUNl/IQJITA4rY=;
        b=gjvMhdG52+6G0OMwSVmZdvDK3mBo+t3Oo/q2EDOFKeK17wGZ0osZjVswWdDTJeC6h/
         3KWObj4vVN9pwp6gwuEUTKcSv2JIc7Q5Pe9vlhrJfPj4tzWx9G0F4vH6Bpw+jKw/jRDB
         avs1f0PuMIXvv1jnnkE+zxmOlE6IKzUPleMVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645883; x=1796250683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/vAfqa5iQmgN4yOlI3ann4an+CSVfZUNl/IQJITA4rY=;
        b=keKUePOF98oP37lxFn7j09IZJNCJ42+pX83e7AHcRbNNdoyApjwQdkPduxX46cQMxV
         PkCBn21nSTzSo3tj1PYv60CoW8uvsAClC2KsHkA+7m5aGggo8ZjjkuYW0gGSfTgiAjwV
         er9xphd66J+u0QO1jpKqlKPi6gPyjga4k00nYhkiHZfNO9uMcINAhZdEFaezl8+uNm2V
         5Bhli54OLVJIDgeajruco2fwaoSzfH1Mg4BzQZkXxOz14Yyb2u5xZ1+uf95TIHMB/6Jz
         HIZot0OOx7y+y+ukQAu8FmL1jSs1PtdrVokDbyH1Qd7QWHb5cf1E3AhGNIxLF+FugF4v
         jHtA==
X-Gm-Message-State: APuU4Z/fhca8B5MCplZrbIZpnTPGAFKd/kJi/eEN0F5AFOgRJ8gPKOMz
	LN5KdaA81axwkLZ9YNcZ1q3pZX3R7e9zb50969dQqAnpg8s1ExLL7/XFmCAGWUXkyCOZIAyTycz
	LjbcV
X-Gm-Gg: AZFdTZfryFwRka/U+tdmv83udME2MkcyDjlN/dc39g55ewglN19S3RxP03RrCuCi+t+
	V33wk05S7I5i7ISZ9qaIzn0yQGNRdtUiYLQjM1AUN5fUhljCOm6dST2incruXZlea18NSxteM29
	JCVG8fxmIYts0E5/9b7KsiGd3/E6Ntw3Jzgho5EdZWg74QclbSQ3d+bIGVw1nj7DGvSWH43Z6e1
	nmq7kOfCe98OfdYrTnb2fgKyYTK6x0NS1qawvv3MWElNBnrwv+jSsA2ip/esKUWIhu5jIAXbyP2
	DWstloIp4G+uIAIIVOBbDSLPEn6xCkzi8y0CraiaDmOnq73V3nbTGkk0C8KADxYEUKiigXTIhR4
	5dI1MBFBDDO/gVVx/kf/Hk6nLYEL1rlPrvQsg7h8Ienb0NgqgU/kuZ1ljNP6oqjDE6ushDfLDrK
	N7VA6kpLrUh7JCw8olqQqmd1FixP032fNuBmUn2fvg9j7EovARwFP2o7OpjhVmUMJ7FWZv/WqLe
	YAb2sJodUTs8b0PFAmZt44ga5H/6bRwMHNPxZRhVJ2m99ykrPvoSEmtPHkSwAea5VoBBRm1M9Aa
	PMsJU2tA7xu8UMW88+QHG84TUSypbFRCSZpYvMPuxCaCi0Wn3iTaUg/n2D7YrHpKbutYJrDL3O1
	vnX6ku3u+ujstKoQpxWNXKzCJq6N7bHZ4sWQFV+jQVeP7KkRuoX9uRPBF5tR/6wKxlw==
X-Received: by 2002:ac8:5d09:0:b0:55d:31e1:fe1c with SMTP id d75a77b69052e-55d76aad15amr369731201cf.63.1795645882692;
        Wed, 25 Nov 2026 14:31:22 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.22
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:22 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 00/19] Update to 1.99.1
Date: Wed, 25 Nov 2026 17:30:51 -0500
Message-ID: <cover.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5519
Content-Type: text/plain; charset="utf-8"

This patch series for the scarthgap/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.98.1 -> 1.99.0 -> 1.99.1 updates and other fixes.

I intend to merge this series to scarthgap/rust by end of day tomorrow
(November 26, EST) unless an issue is pointed out.

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
 ...ust-llvm_1.98.1.bb => rust-llvm_1.99.1.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       | 104 +-
 recipes-devtools/rust/rust-source.inc         |   9 +-
 ...source_1.98.1.bb => rust-source_1.99.1.bb} |   0
 .../rust/{rust_1.98.1.bb => rust_1.99.1.bb}   |   2 -
 recipes-gnome/librsvg/librsvg-crates.inc      | 924 +++++++++---------
 ...append-RUSTFLAGS-to-rustc-executable.patch |   2 +-
 ...e-care-of-deprecated-assert_cmd-Comm.patch |   2 +-
 .../{librsvg_2.62.3.bb => librsvg_2.63.4.bb}  |   2 +-
 29 files changed, 934 insertions(+), 1735 deletions(-)
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
 rename recipes-devtools/rust/{rust-llvm_1.98.1.bb => rust-llvm_1.99.1.bb} (100%)
 rename recipes-devtools/rust/{rust-source_1.98.1.bb => rust-source_1.99.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.98.1.bb => rust_1.99.1.bb} (99%)
 rename recipes-gnome/librsvg/{librsvg_2.62.3.bb => librsvg_2.63.4.bb} (98%)

-- 
2.56.1

