Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1391CAC583
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:44:19 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web11.2979.1757443454757823634
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:44:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=EvsLHO/l;
 spf=pass (domain: konsulko.com, ip: 209.85.160.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b5f6ae99c3so35060321cf.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443453; x=1758048253; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VeBSAjHLg+p+fpj4tg8hV/kY54e7NrlmOkr6CBw9/Q=;
        b=EvsLHO/lDv63/Gv71574TyHVqBy1Y9KBU6gLQ5EcP1Cw+8AJGGN7jENpnhwm6OXKJ4
         CqdVp9JD7oK4NRWmGI5JC9axWPO2Hm/tsKddJUeVq3yt2ADY0cX5inPxuKkCzUCHr47c
         oBzftTxVauddrWp109SVp8azpcZqZJEDA6blw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443453; x=1758048253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VeBSAjHLg+p+fpj4tg8hV/kY54e7NrlmOkr6CBw9/Q=;
        b=FxE+Y9r1ebW5PuXHv6sGAIidBMiVV7OCXa0tEsk4PDMZ/GnjnyzX0SysN9Gy9ZSbxw
         3hrrxrvJwHGr5ayLwzhQOsG43Pk7GobuQjRb9y/iiHQaCeUDopbrOYQAGe9X/uyyh34T
         0bUS/Wuuo0/6K6xhf5QTYe4ZEzifT/h0WwrKPpDmZl+I789CV6aQMT/x0v3d1VzN5cFn
         i7vZ2Y4p8hLwBxOzN8H/LGmaeGafPnYG+SqTKM9a51k+l8JzDS7heWP71sGy9bUoNmaM
         S6RZ0tQYha0Bmzcd+9A+QUFgnu3u/xk/XOTCuHhfPsvmDjhAs2ikBVpJKID4TkS4aizh
         Nx5A==
X-Gm-Message-State: AOJu0YzrEKtpgxa8hC8f/3J6SEHnwLwYvGKkmndbl9Wk+P9+9rw+57HM
	NryFeHzAlN8eRvmhLjvlKWcKBZb8+ObZlRwPdTBGHPp+OS9g8vqn7P3Dm+QxxiyTHsclrhFFC+a
	r3EHk
X-Gm-Gg: ASbGncuLDRgoA6xPyc8U+kDB/i9P26oBqMDdvwYuga0nNX/RHhn94PhSbai80IX56c4
	YS6xM7ciBVJBfCnYUlklhWiylc2Oh8TuyDTOgSYvpSTrIQWTKfs3mCGeGC4K8UMCt/woBnSlQM/
	qrHcKfOq9j5C4WczLdUCus9Uxt9PmwLR0Z/cYiCbUVsytV0fHjThP7Z/FkRvStq/cEgSXBwkkTf
	V/3xi32eOoFbTcgNcQHna/FR0692gUAwxwqaJgjdgirLQNzQDgPLIajwgAaFfL1sOALNmW8tgk/
	SOHlVpghb8CVroLHlcBzYPWUeAoDpkCmjmTvubGAaExm7L6wK3xcAQekiM79RsVCuUe5N6WcVJn
	MD/I2/HTMcUoS9FxWyLHtXQ1dpvjuw7fiOY81AC+Rd2tt2aDWpOJpeBdFydyIUzlBl10PKPXish
	W8M6conVC2
X-Google-Smtp-Source: AGHT+IH611U4g7TuTGfBx+ybWf4yVHlFYqHxlPIhKaWAFmv5jY1RZAKQLB7bbpo35qj5cL7BaePIVw==
X-Received: by 2002:ac8:7d50:0:b0:4b0:8092:9912 with SMTP id d75a77b69052e-4b5f83941f3mr155311331cf.19.1757443453482;
        Tue, 09 Sep 2025 11:44:13 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5f715c0bsm160164985a.61.2025.09.09.11.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:44:13 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Soumya Sambu <Soumya.Sambu@windriver.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 0/9] Update to Rust 1.89.0
Date: Tue,  9 Sep 2025 14:43:53 -0400
Message-ID: <cover.1757441699.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:44:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2157

This patch series for the kirkstone/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.88.0 -> 1.89.0 updates and other fixes.  I have also dropped
the contributed dynamic layers bbappends since they have issues
and Wind River have stated they're no longer using the mixin.

I intend to push this series to kirkstone/rust within 24 hours
unless a serious showstopper is pointed out.

Changes:

Gyorgy Sarvari (2):
  ptest-cargo.bbclass: sort binaries for reproducibility
  rust-target-config.bbclass: move target generation before do_configure

Jayasurya Maganuru (1):
  rust: Upgrade 1.88.0 -> 1.89.0

Ovidiu Panait (1):
  rust-target-config: fix nativesdk-libstd-rs build with baremetal

Per x Johansson (1):
  rust-target-config: Add has-thread-local option

Peter Marko (2):
  recipes: cleanup CVE_STATUS which are resolved now
  rust: handle softfp fpu

Scott Murray (1):
  Remove dynamic layer bbappends

Yoann Congal (1):
  ptest-cargo: move run-ptest rc variable initialisation

 README.md                                     |   2 +-
 classes/ptest-cargo.bbclass                   |   4 +-
 classes/rust-target-config.bbclass            |   8 +-
 conf/layer.conf                               |   2 +-
 .../recipes-devtools/rust/rust_%.bbappend     |   7 --
 .../mozjs/mozjs-78_%.bbappend                 |  14 ---
 .../mozjs/mozjs-91_%.bbappend                 |  13 ---
 lib/oeqa/selftest/cases/rust_mixin.py         |   3 +-
 .../rust/{cargo_1.88.0.bb => cargo_1.89.0.bb} |   0
 ...l-codes-on-riscv32gc-unknown-linux-g.patch | 101 ------------------
 ...bunwind-cross-architecture-unwinding.patch |  46 --------
 ...lain-syscalls-as-their-time64-varian.patch |  32 ++++++
 ...teps-tool.rs-switch-off-lto-for-rust.patch |   8 +-
 ...d-statically-in-rustc_driver-feature.patch |  14 +--
 .../rust/files/rust-oe-selftest.patch         |  13 ---
 recipes-devtools/rust/files/triagebot.patch   |  32 ------
 ...ibstd-rs_1.88.0.bb => libstd-rs_1.89.0.bb} |   0
 ....88.0.bb => rust-cross-canadian_1.89.0.bb} |   0
 ...ust-llvm_1.88.0.bb => rust-llvm_1.89.0.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       |  78 +++++++-------
 recipes-devtools/rust/rust-source.inc         |  10 +-
 .../rust/{rust_1.88.0.bb => rust_1.89.0.bb}   |   0
 22 files changed, 94 insertions(+), 293 deletions(-)
 delete mode 100644 dynamic-layers/meta-python/recipes-devtools/rust/rust_%.bbappend
 delete mode 100644 dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend
 delete mode 100644 dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.bbappend
 rename recipes-devtools/rust/{cargo_1.88.0.bb => cargo_1.89.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture-unwinding.patch
 delete mode 100644 recipes-devtools/rust/files/triagebot.patch
 rename recipes-devtools/rust/{libstd-rs_1.88.0.bb => libstd-rs_1.89.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.88.0.bb => rust-cross-canadian_1.89.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.88.0.bb => rust-llvm_1.89.0.bb} (100%)
 rename recipes-devtools/rust/{rust_1.88.0.bb => rust_1.89.0.bb} (100%)

-- 
2.50.1


