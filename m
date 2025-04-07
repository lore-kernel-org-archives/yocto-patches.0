Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B82C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:30:44 +0000 (UTC)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
 by mx.groups.io with SMTP id smtpd.web10.60111.1744061438368329277
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=SGQiUoWa;
 spf=pass (domain: konsulko.com, ip: 209.85.166.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8613f456960so41172439f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061437; x=1744666237; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HSWKsn3Zki8sQmB6GhNa9m4bCVEkJLNDdnAbL0uesNY=;
        b=SGQiUoWacGbuhrf3Wk8J3IIM6BPBg08f68rKu7hEqbtfyFMvXYlxePzMoSGuM6QhJB
         +6y3OlGqyEpUjJdDV2IgDJ9gd6Lo/br5tBwzJh1ynqjVmcbcnBOm0Q2W4t69Njx7G4pt
         DvX/hnLupoGcFHMXetzqsXA5OXuZS5yvOnb2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061437; x=1744666237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSWKsn3Zki8sQmB6GhNa9m4bCVEkJLNDdnAbL0uesNY=;
        b=OL3G6CrIW1/JeMJYdDMqn+0Y9Ncy0iVQSMwujQ1zmnFU86TyGdt0bpjuH7xAtOH/0G
         64jghUqZL3yeRbbYeUBBd3iSfiyz9AWvG4m++vK5cA9Q6VFVnBsWnQkP0vRcElQ8SZuX
         hvMidK5frqX02KTt8qak4ID/yEOmhu/1e6UTF9IKZwaIgnlw9C49QtMfbzbVtN9ztKnv
         KqkCbM5dbc4A4ELbS22RmxJotIqTBL9LTTn4vYVNg20/jelK8gBXtO1OR9CEvdijctqC
         BywJ0/gXyc3tvJDJm1PlfX42/XSTMVejD+teA/RDigcfxsSnsOdEXAahwrHw4bYOmpS+
         x63w==
X-Gm-Message-State: AOJu0Yxahk/93brPQUmYL7BFsO6SDGwXKt9m+UUnf3FsuOovcoRoZwoZ
	M8LVLU5goVm9WDbocrAXOMcoCSLSF5QCtg+oRRCi2BUHX/BkL0K88+2UCM/T8zwiIRDKOJfSUO+
	dhSc=
X-Gm-Gg: ASbGncvvCoxj1+70yxo8g4n2UMgvK0SGTAt6skW3oCOJ4mt5z2KyvvqhnXhujv7HK7Y
	rWv9KMSvwJkcjI+WwlTBT51GBsBPlcQCVfVxlbV1isbwUYlQrEwLsqmOcXPeeMQBFQb/sfJofzZ
	Bv28HIkbo9nnIZpo1plAdfeeFDU245kpH3euSoWUlyWkDgPm4XxAYS+8LLgQA9n8zTPR6RsW11n
	A+U3KkRiLLXILWihJw0/Je428sqf+7rgTfv8JLWYsAofROrxDUlKP1/nYHhEEugP6FSeu+qSmH8
	vFxpePOXSFH+zZ8omnLe4kv70FQ/chWWE5LOy0Rp5vt4RZWBn+fFJZKjzNZUkr6ttV3Ygr7vfkS
	bbErqH0mb9KHO5VZTnYCt
X-Google-Smtp-Source: AGHT+IGfCMapBW0B6mL2QqY+25iYCXFk1F4bjXESatmeXHe3Rcjo4LcMa3cp8uvMtrICLOflnPjNmg==
X-Received: by 2002:a05:6602:4009:b0:85e:201e:3e35 with SMTP id ca18e2360f4ac-8611c2a4dc8mr1587765039f.3.1744061437269;
        Mon, 07 Apr 2025 14:30:37 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:36 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 00/29] Update to Rust 1.85.1
Date: Mon,  7 Apr 2025 17:29:49 -0400
Message-ID: <cover.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:30:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1300

This patch series for the scarthgap/rust mixin layer backports the
various Rust toolchain changes in oe-core master to to pull in the
1.81.0 -> 1.85.1 updates that have landed in the last couple of months
in oe-core.  At this point the backported selftest (as the "rust_mixin"
module) is passing in my environment except on qemuriscv64, which
is currently also failing on oe-core master based on my testing.

I intend to push this series to scarthgap/rust within 24 hours
unless a serious showstopper is pointed out.

Changes:

Alexander Kanavin (1):
  rust: restore parallel builds, disable lto only for rustdoc

Deepesh Varatharajan (11):
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

Enrico Scholz (1):
  cargo_common: use 'config.toml' instead of plain 'config'

Harish Sadineni (2):
  rust: fix for rust multilib sdk configuration
  rust: remove redundant cargo config file

Igor Opaniuk (1):
  rust/README-rust.md: fix markdown style issues

Jean-Pierre Geslin (1):
  cargo: pass PACKAGECONFIG_CONFARGS to cargo build

Khem Raj (1):
  rust-llvm: Fix build break found with clang

Martin Jansa (1):
  cargo.bbclass: show PACKAGECONFIG_CONFARGS in bbnote

Pedro Ferreira (1):
  rust-common.bbclass: soft assignment for RUSTLIB path

Richard Purdie (5):
  meta/meta-selftest: Fix variable assignment whitespace
  recipes: Drop ld-is-gold support
  rust-source: Fix remove_gcc_directory
  rust-llvm: Compile llvm to use dynamic libraries
  rust-llvm: Disable libedit

Sean Nyekjaer (1):
  rust-cross-canadian: set CC_<triple> for nativesdk

Yash Shinde (3):
  rust: Update "do_update_snapshot" task for rust-snapshot.inc
  rust: Upgrade 1.84.1->1.85.0
  rust: Upgrade 1.85.0->1.85.1

 classes-recipe/cargo.bbclass                  |   6 +-
 classes-recipe/cargo_common.bbclass           |  20 +-
 classes-recipe/rust-common.bbclass            |   2 +-
 classes-recipe/rust-target-config.bbclass     |   5 +
 classes-recipe/rust.bbclass                   |   8 +-
 conf/layer.conf                               |   4 +-
 files/common-licenses/Unicode-3.0             |  39 +++
 lib/oeqa/selftest/cases/rust_mixin.py         |   2 +
 recipes-devtools/rust/README-rust.md          |  24 +-
 .../rust/{cargo_1.81.0.bb => cargo_1.85.1.bb} |  13 +
 ...teps-tool.rs-switch-off-lto-for-rust.patch |  46 ++++
 .../Zdual-proc-macros-additional-check.patch  |  31 +++
 ...epro-issue-fix-with-cc-crate-hashmap.patch |  90 +++++--
 ...d-statically-in-rustc_driver-feature.patch | 228 +++++++++++++++++
 .../rust/files/rust-oe-selftest.patch         | 152 ++++++++---
 ...ue-fix-cargo-config-for-codegenunits.patch |  26 --
 .../files/rv32-cargo-rustix-0.38.28-fix.patch |  70 ------
 .../files/rv32-cargo-rustix-0.38.40-fix.patch | 236 ++++++++++++++++++
 .../rust/files/rv32-rustix-libc-backend.patch |  33 ---
 .../rust/files/zlib-off64_t.patch             |  31 ---
 ...ibstd-rs_1.81.0.bb => libstd-rs_1.85.1.bb} |   9 +-
 recipes-devtools/rust/rust-cross-canadian.inc |  24 +-
 ....81.0.bb => rust-cross-canadian_1.85.1.bb} |   0
 ...ust-llvm_1.81.0.bb => rust-llvm_1.85.1.bb} |   8 +-
 recipes-devtools/rust/rust-snapshot.inc       |  81 +++---
 recipes-devtools/rust/rust-source.inc         |  10 +-
 .../rust/{rust_1.81.0.bb => rust_1.85.1.bb}   |  76 ++++--
 27 files changed, 931 insertions(+), 343 deletions(-)
 create mode 100644 files/common-licenses/Unicode-3.0
 rename recipes-devtools/rust/{cargo_1.81.0.bb => cargo_1.85.1.bb} (87%)
 create mode 100644 recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
 create mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
 create mode 100644 recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
 delete mode 100644 recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch
 delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.28-fix.patch
 create mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-fix.patch
 delete mode 100644 recipes-devtools/rust/files/rv32-rustix-libc-backend.patch
 delete mode 100644 recipes-devtools/rust/files/zlib-off64_t.patch
 rename recipes-devtools/rust/{libstd-rs_1.81.0.bb => libstd-rs_1.85.1.bb} (79%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.81.0.bb => rust-cross-canadian_1.85.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.81.0.bb => rust-llvm_1.85.1.bb} (93%)
 rename recipes-devtools/rust/{rust_1.81.0.bb => rust_1.85.1.bb} (81%)

-- 
2.49.0


