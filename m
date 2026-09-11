Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14E2C88E53
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:13:48 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48509.1789157619930247841
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=C42ADkKS;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530de452c33so3285631cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157619; x=1789762419; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZBPbsL5omivgDSBqTEpfN2D3yvwI/hu0QXciPLt3zM=;
        b=C42ADkKSCLMtnczk/KNwM3wfqGuKBBX8tri4g0SY1l/lGk5vxMVyVBKkIYTH1llMyG
         k1tcNOh8ztgVJoCycpGzFH49CDDEAUtH5HJSVJLGbvUy8sgz9lkx44QjY7MnMowFuA8B
         4DVtFkM/jNoZNbJ7fLQOEtAypLTkIbo+YyJnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157619; x=1789762419;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZBPbsL5omivgDSBqTEpfN2D3yvwI/hu0QXciPLt3zM=;
        b=SVz0l29286mamdB9kxA1GJ3l01Gr09FRajpvSzsE8RULpxk3aQW9vm0klwWZ7xjMMc
         w9MrD0ILiE6J7PWIN/ijvty9VgbeLOYIYYoRNvmmqzOtirN0pmPnKwA0EjXN7P4G3lGk
         pvsdzXRGU0UeL2hWuOi9rrlOE0yS/wnPcmguh5DnqPyK3ZQlb2aMd7uUhU7+IInlPxf6
         4CXQ9x4aNzvL0+h5jOHEkbFk/fwoyNBX9w/b0C6zYaUtCEJ2fUsfisCY13vLk1nUIBQW
         KvYSo/6qf1L90qQAuLnBDyX//TUW9Rl2ne3egB+L+ulRkkbz2TX3gSbbSxnUO/wDGqnm
         ENBg==
X-Gm-Message-State: AFuF++kWioe6+3mchV3Welco1Di/uik+iMJpKsknLVaDxPwmd0y+NrIQ
	xlIxWgsbHJnYQbMtD0YjxpRSGnnt4n0IOyZCNU60yjQ8V56rg81FCFaAg3kQXnLRYKLFKfQoyjy
	5ipk9
X-Gm-Gg: AYBFou3ngtsFS/JwBBVwoIor5YiU6QXUVMX74Z3P4KV5DGpdaz9JGviTFfuxWm5TGCu
	J7T/l38koYnF9Iz06bDzVYiYPmIKgI5V6OGQuL8vEzlR6rU4JZaEjCjINjfhzky36qTdV7hkKZq
	JwN1vv4E7MYgm5PIyN2g11Z/OKcgSFOPgikFavZrVPOl2WRlI+4rSTYBq5eU7zPwQ7Hq0+nK2nC
	wO/lx2Q2b53mlPF3vdIsL5x5h1T9xlk7wr9C9VZcd0cKR7gMEEraGEKxcAknnbv2dIKmZYcdCTi
	ZFxSdCAzoCGyxAMU9xvnQFAwY/pARqIru+ahUeyBElmDt5wCyqa0gbLQwP2ieuM8+hh8W2i2Vem
	loZCexRmBLHSiqN6KUawK9+PbIikXHp/1IiW2auhrmlqSLKY4SrmDP1LQ3VGP8JTh4JMFKHMhSe
	+HfIISFdaWKNqgvoBQxYyA1MvPnwKV08hJS8QkKjN0utwF2XthGK4QA+VKSNUd5wSZ2CUfGLo+v
	N0RBZMA+53Q7s2iQF+7cPzgfZuhPdNYbJ4hEJl2UC/UxBfWKggrgNoMe5pSeSukTyj5UKutAyfy
	GE1oxMffj+2vR145tddv1xDOSSHHCF58oyA=
X-Received: by 2002:a05:622a:453:b0:530:b2e2:903a with SMTP id d75a77b69052e-530c87c5f70mr86781111cf.58.1789157618326;
        Fri, 11 Sep 2026 13:13:38 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:37 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 00/37] Update to 1.98.1
Date: Fri, 11 Sep 2026 16:12:46 -0400
Message-ID: <cover.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:13:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4766

This patch series for the scarthgap/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.96.1 -> 1.97.1 -> 1.98.0 -> 1.98.1 updates and other fixes.

Note that the cargo-c updates at the start of the series are to
recover for my originally missing the move of the cargo-c recipe out
of recipes-devtools/rust, which I noticed after posting the last patch
series.  This does mean there are now some out of order commits
compared to master branch, but I think things should be back on track
now.

I intend to merge this series to scarthgap/rust by end of day Monday
(September 14, EST) unless an issue is pointed out.

Scott


Changes:

Deepesh Varatharajan (10):
  cargo-c: update 0.10.20 -> 0.10.21
  cargo-c: update 0.10.22 -> 0.10.23
  cargo-c: upgrade 0.10.23 -> 0.10.24
  rust: Fix reproducibility with shared source trees
  rust: refactor source handling into a shared work-shared recipe
  rust: Move do_update_snapshot to rust-source
  rust: Upgrade 1.96.1 -> 1.97.1
  rust: Upgrade 1.97.1 -> 1.98.0
  rust: Fix build and oe-selftest failures with LLVM 23
  rust: Upgrade 1.98.0 -> 1.98.1

Jaipaul Cheernam (1):
  classes-recipe: fix trailing whitespace

Markus Volk (1):
  rust: patch uninative loader into snapshot's self-contained lld

Richard Purdie (2):
  libgit: Add nativesdk variant
  libgit2: upgrade 1.9.6 -> 1.9.7

Ross Burton (17):
  libgit2: remove library paths from installed .cmake
  classes/rust-common: don't export rustlibdir
  cargo: centralise anti-vendoring environment variables
  cargo: add missing build dependencies
  cargo-c: add missing build dependencies
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
  classes/ptest-cargo: use oe.path.join instead of os.path.join
  classes/ptest-cargo: add explanatory comment

Scott Murray (1):
  libgit2: backport libgit2 1.9.4

Sunil Dora (1):
  rust: Do not pass the removed x86 amx-tf32 feature to LLVM 23

WXbet (1):
  rust-target-config: set MIPS ABI in the target JSON

Wang Mingyu (1):
  libgit2: upgrade 1.9.4 -> 1.9.6

Yash Shinde (2):
  cargo-c: update 0.10.21 -> 0.10.22
  cargo-c: upgrade 0.10.24 -> 0.10.25

 classes-recipe/cargo.bbclass                  |   44 +-
 classes-recipe/cargo_c.bbclass                |   26 +-
 classes-recipe/cargo_common.bbclass           |   65 +-
 classes-recipe/ptest-cargo.bbclass            |    8 +-
 classes-recipe/rust-common.bbclass            |    6 +-
 classes-recipe/rust-target-config.bbclass     |   12 +
 classes-recipe/rust.bbclass                   |   22 -
 conf/layer.conf                               |    6 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |   13 +-
 recipes-devtools/cargo-c/cargo-c-crates.inc   | 1054 +++++++++--------
 ...4.0.bb => cargo-c_0.10.25+cargo-0.99.0.bb} |    4 +-
 .../rust/{cargo_1.96.1.bb => cargo_1.98.1.bb} |   21 +-
 recipes-devtools/rust/common-source.inc       |   28 +
 ...l-codes-on-riscv32gc-unknown-linux-g.patch |    9 +-
 ...lain-syscalls-as-their-time64-varian.patch |   81 --
 ...teps-tool.rs-switch-off-lto-for-rust.patch |    6 +-
 ...ip-StdarchVerify-when-remote-testing.patch |   30 +
 ...xplicit-tail-calls-disable-two-tests.patch |   39 -
 ...ommits-from-rust-Fix-selftest-llvm23.patch |  661 +++++++++++
 ...lls-ignore-tests-on-unsupported-llvm.patch |   96 --
 ...llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch |   38 +
 ...epro-issue-fix-with-cc-crate-hashmap.patch |    5 +-
 .../rust/files/rust-oe-selftest.patch         |   24 +-
 ...ibstd-rs_1.96.1.bb => libstd-rs_1.98.1.bb} |    4 +
 ....96.1.bb => rust-cross-canadian_1.98.1.bb} |    0
 ...ust-llvm_1.96.1.bb => rust-llvm_1.98.1.bb} |    1 +
 recipes-devtools/rust/rust-snapshot.inc       |  104 +-
 recipes-devtools/rust/rust-source.inc         |   14 +-
 recipes-devtools/rust/rust-source_1.98.1.bb   |  128 ++
 .../rust/{rust_1.96.1.bb => rust_1.98.1.bb}   |  129 +-
 ...m-libraries-are-private-link-librari.patch |   40 +
 recipes-support/libgit2/libgit2_1.9.7.bb      |   23 +
 32 files changed, 1732 insertions(+), 1009 deletions(-)
 rename recipes-devtools/cargo-c/{cargo-c_0.10.20+cargo-0.94.0.bb => cargo-c_0.10.25+cargo-0.99.0.bb} (82%)
 rename recipes-devtools/rust/{cargo_1.96.1.bb => cargo_1.98.1.bb} (78%)
 create mode 100644 recipes-devtools/rust/common-source.inc
 delete mode 100644 recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch
 create mode 100644 recipes-devtools/rust/files/0003-bootstrap-skip-StdarchVerify-when-remote-testing.patch
 delete mode 100644 recipes-devtools/rust/files/0003-explicit-tail-calls-disable-two-tests.patch
 create mode 100644 recipes-devtools/rust/files/0004-Backport-commits-from-rust-Fix-selftest-llvm23.patch
 delete mode 100644 recipes-devtools/rust/files/0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch
 create mode 100644 recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
 rename recipes-devtools/rust/{libstd-rs_1.96.1.bb => libstd-rs_1.98.1.bb} (92%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.96.1.bb => rust-cross-canadian_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.96.1.bb => rust-llvm_1.98.1.bb} (99%)
 create mode 100644 recipes-devtools/rust/rust-source_1.98.1.bb
 rename recipes-devtools/rust/{rust_1.96.1.bb => rust_1.98.1.bb} (74%)
 create mode 100644 recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch
 create mode 100644 recipes-support/libgit2/libgit2_1.9.7.bb

-- 
2.55.0


