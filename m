Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94820C87FC5
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:38 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web11.23022.1753296033719130309
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=iOnhW56s;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e32c95775aso26582985a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296032; x=1753900832; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YxwFS1au6bVoSRKJxHCNQnz3LrYKztqXzPEFIIhcEZ4=;
        b=iOnhW56s+q8e5giZqeQmynyTv96mSUyNJZBoV7KzdSH1QUUP5fxlz4+Q8y3Kqq5OCo
         esQZsmJ2gSsGYrLwpmjjaSBIgzJ46YJ/F19ujUS3Npb0aiiUpDeT5VDtdMRNH3/FXzfz
         ZEalVZtR9AdSYRMO/gfKgeq9Tl57xVeJaxXmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296032; x=1753900832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxwFS1au6bVoSRKJxHCNQnz3LrYKztqXzPEFIIhcEZ4=;
        b=suG2P86O4nRRe5lKDxrsmEkUjnyw/RFBBFK9FOs7uY2PWICb0rMMxFjSSn7Bd7otIT
         T7EEK6LtYk6BcnTlWA/suM01G461OSq53O+XKATPWahgojN9C2V4q8t9wAFCYi+fuUuN
         23s05qHtSzO950RpLfKmTVl97TyXZsQ+Kw0Yrobs7nwCh3WCsZnzmnUTSmKYtA0K0Tyk
         QF6ML+0ByXloO62yZ7Ox8r9bmEZNkHchmVPZW4PQRjt5NF430+sS+FNm0ZMZ46nLgmfU
         EZJzhmLOOLaz4RVK5iCnNbewQejDkYoXCLj8GCBY90WESjqoRpnnlndMpbUEvEs3oBQH
         dF1Q==
X-Gm-Message-State: AOJu0Ywb/PAstr1OgguBX1g6Qz6GO3DyUIWezUbuFgP7Bouy54I9zVqk
	4Clq5jqkqkmqHWZFIzspCQLGfGp2CcVpMYnT9FnkUgYoPHZbl9PPFZENSO4KJw9JxexiQKnQO8j
	Ut1sw
X-Gm-Gg: ASbGncvLrfK4OwGKvnQsFmQeY+J3a9ZIWch5yC5yhs954boGRwYn8Y/+/hpxo0KAcbD
	P+im+kvaPSdhBw/RspElv+UoLXuj8nawfwcppya6ipUseWOsta17eY/r4rFI7ut4T6QL6vDI/g3
	igwhohDecolln03VKt+Pp2UsoAkSN4THG7u2Rfulc7TmZ4NdLtgHudAIagdqGy0/mipj9OBGfne
	hymagTT3LOyOjXWcKV2c9+jE3DV0boybRMwvaTp5UB5baaqCU4WIzPGt6blLdCK52l/OB57T1nl
	PrT+5JJGidAcpsDr/Fzt8pI+6m9GwnUu0dIp/pMNYoX7cYsqrVTtE7U48EO+WQILMczIqcFNRGR
	n29P5dwvLP7z18P0eaQfTlZrzNwlA5l5cRPTWK8azVycrBqfWgROfubyvKUq23iwvwPJlx5aurA
	==
X-Google-Smtp-Source: AGHT+IHGyxlRIMxhugLX92K/MG3WroQ3caP3vFJArKXjl9brPh8Xz3RHoad/dapNAlVuvH0sUQTAjQ==
X-Received: by 2002:a05:620a:3bda:b0:7e1:68e3:712d with SMTP id af79cd13be357-7e62a17d08bmr405097485a.31.1753296032222;
        Wed, 23 Jul 2025 11:40:32 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:31 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 00/13] Update to Rust 1.87.0
Date: Wed, 23 Jul 2025 14:40:00 -0400
Message-ID: <cover.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1827

This patch series for the scarthgap/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.85.1 -> 1.87.0 updates.  The backported selftest (as the
"rust_mixin" module) did pass for qemux86-64 with both 1.86.0 and
1.87.0 in my test environment.

I intend to push this series to scarthgap/rust within 24 hours
unless a serious showstopper is pointed out.

Changes:

Deepesh Varatharajan (1):
  rust: re-enable the unit tests that are previously ignored

Ines KCHELFI (1):
  ptest-cargo: fix tests output format for testimage

Khem Raj (2):
  rust: Use patchelf in place of chrpath to edit rpaths
  rust: Disable cross-unwinding support in llvm libunwind

Richard Purdie (1):
  oeqa/selftest/rust: Add exclusion to fix riscv64 builds

Ross Burton (3):
  rust: remove python3-native DEPENDS
  rust: consolidate rust-llvm dependencies
  rust: remove file-native DEPENDS

Scott Murray (1):
  rust: override DEBUG_PREFIX_MAP

Yash Shinde (4):
  rust: Upgrade 1.85.1->1.86.0
  rust: Drop obsolete rust-lld and extended tools dependencies
  rust: Upgrade 1.86.0 -> 1.87.0
  cargo-c-native: Update 0.10.5 -> 0.10.13

 classes-recipe/ptest-cargo.bbclass            |  12 +-
 classes-recipe/rust-target-config.bbclass     |   2 +-
 conf/layer.conf                               |   2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |   3 +-
 recipes-devtools/rust/cargo-c-crates.inc      | 910 ++++++++++--------
 ...l-codes-on-riscv32gc-unknown-linux-g.patch |  38 -
 ...3.0.bb => cargo-c_0.10.13+cargo-0.88.0.bb} |   3 +-
 .../rust/{cargo_1.85.1.bb => cargo_1.87.0.bb} |   0
 ...l-codes-on-riscv32gc-unknown-linux-g.patch |  32 -
 ...bunwind-cross-architecture-unwinding.patch |  46 +
 ...teps-tool.rs-switch-off-lto-for-rust.patch |  64 +-
 .../Zdual-proc-macros-additional-check.patch  |  31 -
 ...crease-timeout-in-process-sigpipe-ru.patch |   4 +-
 ...d-statically-in-rustc_driver-feature.patch |  11 +-
 .../rust/files/rust-oe-selftest.patch         | 254 +++--
 recipes-devtools/rust/files/triagebot.patch   |  32 +
 ...ibstd-rs_1.85.1.bb => libstd-rs_1.87.0.bb} |   2 +-
 ....85.1.bb => rust-cross-canadian_1.87.0.bb} |   0
 ...ust-llvm_1.85.1.bb => rust-llvm_1.87.0.bb} |   2 +-
 recipes-devtools/rust/rust-snapshot.inc       |  78 +-
 recipes-devtools/rust/rust-source.inc         |   5 +-
 recipes-devtools/rust/rust_%.bbappend         |  10 +
 .../rust/{rust_1.85.1.bb => rust_1.87.0.bb}   |  29 +-
 23 files changed, 846 insertions(+), 724 deletions(-)
 delete mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
 rename recipes-devtools/rust/{cargo-c_0.10.5+cargo-0.83.0.bb => cargo-c_0.10.13+cargo-0.88.0.bb} (67%)
 rename recipes-devtools/rust/{cargo_1.85.1.bb => cargo_1.87.0.bb} (100%)
 create mode 100644 recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture-unwinding.patch
 delete mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
 create mode 100644 recipes-devtools/rust/files/triagebot.patch
 rename recipes-devtools/rust/{libstd-rs_1.85.1.bb => libstd-rs_1.87.0.bb} (95%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.85.1.bb => rust-cross-canadian_1.87.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.85.1.bb => rust-llvm_1.87.0.bb} (99%)
 create mode 100644 recipes-devtools/rust/rust_%.bbappend
 rename recipes-devtools/rust/{rust_1.85.1.bb => rust_1.87.0.bb} (94%)

-- 
2.50.0


