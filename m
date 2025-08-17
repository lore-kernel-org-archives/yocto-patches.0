Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A516BCA0EDC
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 17:29:51 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web10.57122.1755451786295727743
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 10:29:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=syLNgAgP;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109c482c8so62275021cf.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755451785; x=1756056585; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cR/la0xoi9V6+Upy9UKSgzIVdop7qy/4y7B3rt4KDkY=;
        b=syLNgAgPcbMwZzlK0/SpWjTjBWWBk/9qVpc3SvOmqY1qtbqb3c/3DWof8oC9gEDmLh
         vau5ZZ09awZYSgfbTa9tSHyEtqw/ZXXxICng+x3cvGXLPvGVrbBB7vixOkCVZVwzsdYK
         xyXDq4bGvccGb8MqoNu6iQEdhk5yN09AgK5VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451785; x=1756056585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cR/la0xoi9V6+Upy9UKSgzIVdop7qy/4y7B3rt4KDkY=;
        b=WGFnDpFy9VOZCa0Z26ouEktwzComiIzXljLwMyJ7eBKB7kwjMVQQS8Brle/QN2n38F
         RyyKgJsAKUcALaf7Nn8oMq11SwI1mMDC1XloUyOZrwk5bPUuxC0gKcDisWJoYsHXTKZg
         WuEeKP14AaI8p3CYvXsVnhoCvNuR+b7kdbs0zdOvPgJRJNt/044gF0bm3D/BxbpMnSOv
         /NxVJiI5im6jyybVuySwfnvZnpsVl5LokiLUZm9hGm7t6mjcoWIsT5uADSGkUnzPs73/
         duJ7QaG8rGrrQ1kzXL5a2z3JBuCDZ+hMfAUC7E78XG3gfyybUscZcdiY68YsH19ZSP8x
         e+pQ==
X-Gm-Message-State: AOJu0YxhZT+jgz6qXWC6GQKsU4oTS2af5ml85eBpPy8EcumkpL1v1DyX
	NhydmN4oW8Awcdyn5A+ehOlRCG4Ra3Kmr4eWb4qX5/fbposOMdhSsHcd43t/W4AENBQ0fVAEmWu
	FJ8CC
X-Gm-Gg: ASbGncsNfmIzGCchgFjNsEOaDPth5Iwwm5I9oMnjzNS/AM6AYJrsXUnoKrd4NcH+354
	3mcR93z31WitwXefJ0Y88Fl15n8b4VXidbw7N7UNndO+K+OiirgvYEGqFXOP+EqGMYwrISnCPNc
	uw1nk3U9UT94AjEs0kJL9MxDEuTAadQ4OSLHeLfr4/T3S65pBQfcISnYMFEotZAGyKyqjCbiiaN
	L4+zoAkUSbG47lgx7OfLqt8tNSkcJIAyYFWJLwVC/apaMt8BXwBbSJAA3MjG5UusX6mS8VGKZlM
	UZ1GqSoonkkjBDtwQdJ2gwOehA64voBGubeXqTq2TfBr+WztdC48g0rndiP7MfGFIQParNV8UJe
	QrUR8kDhqCq4lIWe43Vq4Ef8jN8BIT4NvBhhZ0Jth8NizpQUY4J+ZmPSwV69iIyXjY2yGNcArlQ
	==
X-Google-Smtp-Source: AGHT+IFDf7eJ7qyKe5AO+Bi7WfmtI4orSX/a1NLLRw0gC28WFJWlYXhmbWI/wyTTkGEEoZWacHe9wg==
X-Received: by 2002:ac8:7f88:0:b0:4b0:86b4:2520 with SMTP id d75a77b69052e-4b12a648155mr93602421cf.22.1755451785035;
        Sun, 17 Aug 2025 10:29:45 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc18a0esm39626271cf.9.2025.08.17.10.29.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:29:44 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 0/7] Update to Rust 1.88.0
Date: Sun, 17 Aug 2025 13:29:24 -0400
Message-ID: <cover.1755451486.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 17:29:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2004

This patch series for the kirkstone/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.87.0 -> 1.88.0 updates and other fixes.

I intend to push this series to kirkstone/rust within 24 hours
unless a serious showstopper is pointed out.


Changes:

Jayasurya Maganuru (1):
  rust: Upgrade 1.87.0 -> 1.88.0

Khem Raj (4):
  rust: Update riscv32 patch with the backport
  cargo-c: Upgrade to 0.10.14+cargo-0.89.0
  libstd-rs: Fix build regression on rv32
  cargo-c: Update patches to latest versions

Peter Tatrai (2):
  rust: disable executable-no-mangle-strip test on PowerPC due to linker
    issue
  rust: backport cstring-merging test fix for PowerPC targets

 conf/layer.conf                               |   2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |   2 +
 recipes-devtools/rust/cargo-c-crates.inc      | 498 +++++++++---------
 ...Use-libc-SYS_futex_time64-on-riscv32.patch |  36 ++
 ...Use-libc-SYS_futex_time64-on-riscv32.patch |  51 ++
 ...8.0.bb => cargo-c_0.10.14+cargo-0.89.0.bb} |   7 +-
 .../rust/{cargo_1.87.0.bb => cargo_1.88.0.bb} |   0
 ...l-codes-on-riscv32gc-unknown-linux-g.patch | 375 ++++++++++---
 ...lain-syscalls-as-their-time64-varian.patch |  49 ++
 ...teps-tool.rs-switch-off-lto-for-rust.patch |  18 +-
 .../backport-fix-test-string-merging.patch    |  27 +
 ...epro-issue-fix-with-cc-crate-hashmap.patch | 102 ----
 ...d-statically-in-rustc_driver-feature.patch |   6 +-
 .../rust/files/rust-oe-selftest.patch         |  63 ++-
 ...ibstd-rs_1.87.0.bb => libstd-rs_1.88.0.bb} |   0
 ....87.0.bb => rust-cross-canadian_1.88.0.bb} |   0
 ...ust-llvm_1.87.0.bb => rust-llvm_1.88.0.bb} |   2 +-
 recipes-devtools/rust/rust-snapshot.inc       |  78 +--
 recipes-devtools/rust/rust-source.inc         |   4 +-
 .../rust/{rust_1.87.0.bb => rust_1.88.0.bb}   |   0
 20 files changed, 848 insertions(+), 472 deletions(-)
 create mode 100644 recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
 create mode 100644 recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
 rename recipes-devtools/rust/{cargo-c_0.10.13+cargo-0.88.0.bb => cargo-c_0.10.14+cargo-0.89.0.bb} (50%)
 rename recipes-devtools/rust/{cargo_1.87.0.bb => cargo_1.88.0.bb} (100%)
 create mode 100644 recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch
 create mode 100644 recipes-devtools/rust/files/backport-fix-test-string-merging.patch
 rename recipes-devtools/rust/{libstd-rs_1.87.0.bb => libstd-rs_1.88.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.87.0.bb => rust-cross-canadian_1.88.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.87.0.bb => rust-llvm_1.88.0.bb} (99%)
 rename recipes-devtools/rust/{rust_1.87.0.bb => rust_1.88.0.bb} (100%)

-- 
2.50.1


