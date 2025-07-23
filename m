Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E05DC87FC5
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:05:49 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.web10.23085.1753297545530443202
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:05:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=d/OjVZki;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e169ac6009so30224885a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753297544; x=1753902344; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PLo8rZ7RTswrAfPJcmwHkV2sPC2wb7hsrFIs0ua35Fo=;
        b=d/OjVZki43MOruK0Y71gmrXN/KvaKPKRD/e+9ha10B8oc/KG0QYym8l7FWQbl2HaN9
         hvUvg2OJUtEILkvsIG5/D7pbUrLRiPiOkEGKtGEeO/khgSpHTRZ06aXM4TVPFqbUGSew
         0aEuE9el/YsgI9HQB35s7YYMSHwAlIHXuSOUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297544; x=1753902344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLo8rZ7RTswrAfPJcmwHkV2sPC2wb7hsrFIs0ua35Fo=;
        b=sRIKtoKMLQY1n22eBIvsN2Hu+Hvmz8tjKqzlgxChbJm+Lept/VozrDbLtI/WvP32wj
         006Mngxx60fzMxI0vRMoJK7NyvOOpD7tbTyvWxp/blUtDufTMGEpxtK82YVRl79kRKoR
         ySpNh3iegU7+T4sNsclYDjcCHmLKBvf07KlxBvy0ZoBB9NpvzEHleaat3N/+dDUggFbs
         1qjHVH5txwOP/5bgxZsGNXw8gNv4Yue8dNcgn8kBKEwHohdNQCkSbCGSWso2/k+O248L
         49+m7pp4qkDXgAMT8QfLg4khoU6+xktOdKl6TSuwTg0S+8eAmj5oy8LlwIpL7PunJasc
         lSPw==
X-Gm-Message-State: AOJu0YxR3q/seX9gtZsVIcD+RMz29trKX7K69STSnmbp3i2Jrs+mK3P2
	rFnWD1yaKnpDTlgI7VsHGKGYHqLklskr22vIMA3Zo6H8vfN9Fco2gB0QZpNi9J81LuJKwcd4VmS
	G0eGI
X-Gm-Gg: ASbGncuHFygGxDoCp+LtnYhGRlwmDOBquYgsuPVZPSOV8x05DqtWatuiqLKi1GNvzjb
	ynou0BDUJ2ooy/PAC85BQwVhUO3aHM6Bp5YgiFJz1+5dD/7ZmKfCtn/6fEcJTCMVyizmDH5WyrM
	GsOjt0Erugpl20Eq3X8SHL0O6ESeBpw0PpfkWjM7kSueXEuw5kgB+cyoYkDGfjmyld2l8Sj8n0o
	93oV+02GG3KDNjYywgcHmvkmwQjQwcwC7v1nkF/z7Rb8Q3v0PI6d5TW7K7ymt5dtf3avTFCnnZh
	fiZzpmdzrZ4QSDKb4hdHUovB119WRAccX9W6GDqGW2XqoZpNSbuGoDvuR55rpKxCoQ2lSAUaJbN
	jzMC74zFFQnF1VfzwBtYTqBlzLgP8IhV7pPUxaHjOV9mBILWSZOjPtD5KIPTtp4lmBaBpefmBhg
	==
X-Google-Smtp-Source: AGHT+IGj0aJBFtsK2KC2TJX1ofzliCBB5l5Uv1EzIVXbkZ4JF5ojSdtBKP8S1GbDImkhLBPUoG8WAQ==
X-Received: by 2002:a05:620a:1da1:b0:7d4:4aa6:a509 with SMTP id af79cd13be357-7e62a1949a0mr496998585a.48.1753297540893;
        Wed, 23 Jul 2025 12:05:40 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm703576085a.84.2025.07.23.12.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:05:40 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: soumya.sambu@windriver.com
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 00/13] Update to Rust 1.87.0
Date: Wed, 23 Jul 2025 15:05:19 -0400
Message-ID: <cover.1753296167.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:05:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1841

This patch series for the kirkstone/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.85.1 -> 1.87.0 updates.  In addition to my usual smoke test
of building librsvg and python-cryptography, etc., I did some
experiments with the backported selftest this go around, and to my
surprise all tests but one (a simd one) pass in my test environment.
When I get some time, I plan to go through the selftest change history
to see if that test can be ignored with the older kirkstone toolchain
or not (I believe it was being ignored at one point, but need to
double-check).  If you happen to have a strong desire to see the
selftest working usefully with kirkstone/rust, assistance would be
appreciated.

With respect to the mozjs-* support via the dynamic-layers applied
bbappends, I have renamed the rust bbappend that's in there so it
won't break parsing, but from the looks of it the underlying issue
needs to be reinvestigated, as its use of RUST_BUILD_CCLD is now
incorrect AFAICT (results in a path into WORKDIR that is not usable).
As well, mozjs-91 builds fine for me without that bbappend, so I
suspect it likely will be better if it is replaced with a more
contained mozjs-78 tweak done with a bbappend to its recipe.
That will also make testing less painful as it will not affect
sstate the way a rust bbappend does...

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
  Make dynamic layer rust bbappend version generic

Yash Shinde (4):
  rust: Upgrade 1.85.1->1.86.0
  rust: Drop obsolete rust-lld and extended tools dependencies
  rust: Upgrade 1.86.0 -> 1.87.0
  cargo-c-native: Update 0.10.5 -> 0.10.13

 classes/ptest-cargo.bbclass                   |  12 +-
 classes/rust-target-config.bbclass            |   2 +-
 conf/layer.conf                               |   2 +-
 .../{rust_1.85.1.bbappend => rust_%.bbappend} |   0
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
 .../rust/{rust_1.85.1.bb => rust_1.87.0.bb}   |  29 +-
 23 files changed, 836 insertions(+), 724 deletions(-)
 rename dynamic-layers/meta-python/recipes-devtools/rust/{rust_1.85.1.bbappend => rust_%.bbappend} (100%)
 delete mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
 rename recipes-devtools/rust/{cargo-c_0.10.5+cargo-0.83.0.bb => cargo-c_0.10.13+cargo-0.88.0.bb} (64%)
 rename recipes-devtools/rust/{cargo_1.85.1.bb => cargo_1.87.0.bb} (100%)
 create mode 100644 recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture-unwinding.patch
 delete mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
 create mode 100644 recipes-devtools/rust/files/triagebot.patch
 rename recipes-devtools/rust/{libstd-rs_1.85.1.bb => libstd-rs_1.87.0.bb} (95%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.85.1.bb => rust-cross-canadian_1.87.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.85.1.bb => rust-llvm_1.87.0.bb} (99%)
 rename recipes-devtools/rust/{rust_1.85.1.bb => rust_1.87.0.bb} (94%)

-- 
2.50.0


