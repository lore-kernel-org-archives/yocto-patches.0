Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1CAC369DC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:41 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web11.4639.1746132037251332666
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YxBsLnnK;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ed0cc5eca4so28954266d6.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132036; x=1746736836; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bAUJeK+qCc1kZE6d7MufW9oOvelgkC1j65rO1FcfQ18=;
        b=YxBsLnnK1/Sa+AkYJs6PXAkftRVhs0Cf8jCfRhCy1FnemdKSnSI0favlyl3s4dRWr+
         ea/W47SWOc8omtjwOS8U4EwELdcHN4RI2pvf9s7TgQRUUUgFPJxuF79bz/1wCHd2vATy
         jnwSc3rJchbxWae4bviO8YvLVp5TqqqZTD8yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132036; x=1746736836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAUJeK+qCc1kZE6d7MufW9oOvelgkC1j65rO1FcfQ18=;
        b=QGNbjXu5hLVAPdDoy3BsN2/yQN3eG1Am64A1NcB8lGh4pTTlx/mr2ciGvFvIBfWuPU
         VQihbY9hdPreIq6MGN/PSZpbmeFLIhdv74R8E5H+xLQgWVNNZ5KUEszx0oVAsCl9M0cY
         Ng7Tt7wcF+EUDRu1cstY22AJtY2M8qWNc1ZRzdLkp6MT163tokGoOLaYVZufHJGaTW0Y
         jcZTJEW95Bv3L/1etulOFcmPYLrI5lOUqC8LDRPDQT8FsBHflb2ImsaanHXFvlLlkd3o
         kgIRkXvhUkvXLVYN1ilF5UgPlYVlCxj8drkFdmgnqXlDocellcWme3JF9T8E//QRrwf5
         WIoQ==
X-Gm-Message-State: AOJu0YyTr4qhY8wXUGh8OjR+GvPAkQT0CfguLD2Ks6En3uN1n2F1TUIg
	qTQFLypHew62uWI8Ztr7VBfqpJ9ePd5oXXM4vT7aOEO+X5UhRJmcqANiriRlfRpZcER7F/D8glK
	2
X-Gm-Gg: ASbGncsaBcgVWNkx1jA2z/YFp2Ai1rqboJV9P0HoqmjkM7nANUnaaxOVMpHczEDOrF1
	QX9lg+i+8ySF9Ejn/F93OlkBqHFGCCtj24Ynv+8T5Iq+2/+OSpKqoHctadFm4+EY2oZtriYivcg
	/fM7d2oOwX064+mxJFoOSfC08yCDH2DKruehdunIi1bsqQDCB5h13Z7yhlZT6IEJwatp5OLtkTP
	xt7lJ8JJxuhLVAYjpc79ZrqHsz80NfQX5izu/yp6q2QlRe3p4LjBXKKROFq6WzwWA9rXeuJlcc0
	gNWTv5CAEBURAAKPHL5zGAwRYrNcBfMNfp0t7cHeaAq1J/2XsE3fPnXnRde4AP45tJsyTCVbeus
	cXrwljeTnCbcum2tw
X-Google-Smtp-Source: AGHT+IEVpMHVwtaJ0JrnI2GHqeSWLvRjiX+1LHdb6JK/ucrR+8gXBirjgq6cbOts7X9PMQ9yHdWwUA==
X-Received: by 2002:a05:6214:528a:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6f5155fdbc6mr10234796d6.15.1746132035651;
        Thu, 01 May 2025 13:40:35 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:34 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 00/38] Update to Rust 1.85.1
Date: Thu,  1 May 2025 16:39:36 -0400
Message-ID: <cover.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1427

After more of a delay than I would like, here is the patch series to
backport the various Rust toolchain changes for the 1.81.0 -> 1.85.1
updates that have landed in oe-core master branch in the last several
months.

The likely most impactful change for users is that in order to fix being
able to build python3-cryptography with Rust >= 1.83, I have had to
backport newer versions of python3-setuptools-rust, and more importantly,
python3-setuptools.  Extracting the required fixes in setuptools-rust
seems potentially possible, but untangling the change history in it got
to the point where I lost confidence in not accidentally breaking some
behavior relied upon by downstream users.  As such, using the tested
version from scarthgap branch seems a better solution for now.
That said, if you are a heavy Python module user, there may be some
potential for breakage due to the unexpected setuptools upgrade.  I have
not seen issues in my testing with oe-core recipes, but have not yet tried
a world build of all of meta-python.

I have also included a README.me update to document my requirements /
guidelines for submissions of bbappends in dynamic layers.  They are
for the most part what I posted a few weeks back.

I intend to push this series to kirkstone/rust in about 48 hours
unless a serious showstopper is pointed out.

Changes:

Alexander Kanavin (1):
  rust: restore parallel builds, disable lto only for rustdoc

Deepesh Varatharajan (13):
  rust: Upgrade 1.81.0->1.82.0
  rust: oe-selftest issue fix with v1.82
  rust: Oe-selftest changes for rust v1.82.0
  rust: Upgrade 1.82.0->1.83.0
  rust: Fix build break because of download-ci-llvm
  rust: Oe-selftest changes for rust v1.83.0
  rust: Fix bloat issue in recent rust updates
  rust: Fix build break because of "download-rustc" and "llvm-tools"
  rust: Upgrade 1.83.0->1.84.1
  rust: Fix build failure when multilibs are enabled
  rust: Oe-selftest changes for rust v1.84.1
  rust: re-enable the unit tests that are ignored
  rust: re-enable the unit tests that are ignored

Enrico Scholz (1):
  cargo_common: use 'config.toml' instead of plain 'config'

Harish Sadineni (2):
  rust: fix for rust multilib sdk configuration
  rust: remove redundant cargo config file

Igor Opaniuk (1):
  rust/README-rust.md: fix markdown style issues

Jean-Pierre Geslin (1):
  cargo: pass PACKAGECONFIG_CONFARGS to cargo build

Khem Raj (3):
  rust-llvm: Fix build break found with clang
  rust-llvm: Disable benchmarks by cmake options
  cargo-c,rust: Fix build on risv32

Martin Jansa (1):
  cargo.bbclass: show PACKAGECONFIG_CONFARGS in bbnote

Pedro Ferreira (1):
  rust-common.bbclass: soft assignment for RUSTLIB path

Peter Kjellerstedt (1):
  libstd-rs: Correct the license to use Unicode-3.0

Richard Purdie (5):
  meta/meta-selftest: Fix variable assignment whitespace
  recipes: Drop ld-is-gold support
  rust-source: Fix remove_gcc_directory
  rust-llvm: Compile llvm to use dynamic libraries
  rust-llvm: Disable libedit

Scott Murray (3):
  Add selftest backport to ease maintenance
  Backport newer Python setuptools-rust and setuptools
  Update README.md wrt dynamic layer submissions

Sean Nyekjaer (1):
  rust-cross-canadian: set CC_<triple> for nativesdk

Yash Shinde (3):
  rust: Update "do_update_snapshot" task for rust-snapshot.inc
  rust: Upgrade 1.84.1->1.85.0
  rust: Upgrade 1.85.0->1.85.1

Yoann Congal (1):
  cargo-c: Update patch Upstream-Status

 README.md                                     |  49 ++-
 classes/cargo.bbclass                         |   6 +-
 classes/cargo_common.bbclass                  |  20 +-
 classes/rust-common.bbclass                   |   2 +-
 classes/rust-target-config.bbclass            |   5 +
 classes/rust.bbclass                          |   8 +-
 conf/layer.conf                               |   8 +-
 files/common-licenses/Unicode-3.0             |  39 +++
 lib/oeqa/selftest/cases/rust_mixin.py         | 134 ++++++++
 meta/lib/oeqa/selftest/cases/rust.py          |  85 -----
 .../packagegroup-rust-cross-canadian.bb       |   2 +-
 .../python/python3-setuptools-rust_1.9.0.bb   |  35 ++
 .../python3-setuptools-scm_6.4.2.bbappend     |   2 +
 ...nfig.py-make-it-possible-to-substite.patch |  58 ++++
 ...ly-do-not-fetch-code-by-easy_install.patch |  31 ++
 .../python3-setuptools/CVE-2024-6345.patch    | 312 ++++++++++++++++++
 .../python/python3-setuptools_69.1.1.bb       |  58 ++++
 recipes-devtools/rust/README-rust.md          |  24 +-
 ...l-codes-on-riscv32gc-unknown-linux-g.patch |  38 +++
 .../rust/cargo-c_0.10.5+cargo-0.83.0.bb       |   1 +
 .../rust/{cargo_1.81.0.bb => cargo_1.85.1.bb} |  13 +
 ...l-codes-on-riscv32gc-unknown-linux-g.patch | 112 +++++++
 ...teps-tool.rs-switch-off-lto-for-rust.patch |  46 +++
 .../Zdual-proc-macros-additional-check.patch  |  31 ++
 ...epro-issue-fix-with-cc-crate-hashmap.patch |  90 ++++-
 ...d-statically-in-rustc_driver-feature.patch | 228 +++++++++++++
 .../rust/files/rust-oe-selftest.patch         | 279 +++++-----------
 ...ue-fix-cargo-config-for-codegenunits.patch |  26 --
 .../files/rv32-cargo-rustix-0.38.28-fix.patch |  70 ----
 .../rust/files/rv32-rustix-libc-backend.patch |  33 --
 .../rust/files/zlib-off64_t.patch             |  31 --
 ...ibstd-rs_1.81.0.bb => libstd-rs_1.85.1.bb} |  11 +-
 recipes-devtools/rust/rust-cross-canadian.inc |  24 +-
 ....81.0.bb => rust-cross-canadian_1.85.1.bb} |   0
 .../0003-llvm-fix-include-benchmarks.patch    |  25 --
 ...ust-llvm_1.81.0.bb => rust-llvm_1.85.1.bb} |   8 +-
 recipes-devtools/rust/rust-snapshot.inc       |  81 ++---
 recipes-devtools/rust/rust-source.inc         |  10 +-
 .../rust/{rust_1.81.0.bb => rust_1.85.1.bb}   |  76 +++--
 39 files changed, 1492 insertions(+), 619 deletions(-)
 create mode 100644 files/common-licenses/Unicode-3.0
 create mode 100644 lib/oeqa/selftest/cases/rust_mixin.py
 delete mode 100644 meta/lib/oeqa/selftest/cases/rust.py
 create mode 100644 recipes-devtools/python/python3-setuptools-rust_1.9.0.bb
 create mode 100644 recipes-devtools/python/python3-setuptools-scm_6.4.2.bbappend
 create mode 100644 recipes-devtools/python/python3-setuptools/0001-_distutils-sysconfig.py-make-it-possible-to-substite.patch
 create mode 100644 recipes-devtools/python/python3-setuptools/0001-conditionally-do-not-fetch-code-by-easy_install.patch
 create mode 100644 recipes-devtools/python/python3-setuptools/CVE-2024-6345.patch
 create mode 100644 recipes-devtools/python/python3-setuptools_69.1.1.bb
 create mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
 rename recipes-devtools/rust/{cargo_1.81.0.bb => cargo_1.85.1.bb} (87%)
 create mode 100644 recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
 create mode 100644 recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
 create mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
 create mode 100644 recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
 delete mode 100644 recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch
 delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.28-fix.patch
 delete mode 100644 recipes-devtools/rust/files/rv32-rustix-libc-backend.patch
 delete mode 100644 recipes-devtools/rust/files/zlib-off64_t.patch
 rename recipes-devtools/rust/{libstd-rs_1.81.0.bb => libstd-rs_1.85.1.bb} (76%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.81.0.bb => rust-cross-canadian_1.85.1.bb} (100%)
 delete mode 100644 recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch
 rename recipes-devtools/rust/{rust-llvm_1.81.0.bb => rust-llvm_1.85.1.bb} (94%)
 rename recipes-devtools/rust/{rust_1.81.0.bb => rust_1.85.1.bb} (81%)

-- 
2.49.0


