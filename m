Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F33CA0EE9
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 17:32:11 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web11.56855.1755451924838974187
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 10:32:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nsUDIBVx;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b109914034so38851421cf.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755451924; x=1756056724; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BiuWnaPF0Wu2M9KAImPf/qerNUBpiG+kaUQFNF3Qhbw=;
        b=nsUDIBVxUfqg10ULK4IhcxdWcmP8DEVgjkB9u0Ugmyu4l2yjVPnUc8vV1CHQX3yEmB
         LUz7H4wIWtxcHl8YGHbFSKnX32ErlskAl82whX7Wtzld/j6/f+sJaXe49tbAEiw63tO/
         Xnf5/vid0UWs0AcFV1Kz7n2B9hyk4+FmTUmsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451924; x=1756056724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiuWnaPF0Wu2M9KAImPf/qerNUBpiG+kaUQFNF3Qhbw=;
        b=B2r/vF7Eh3ED/XS3rDKCxQwHHfuPBLyn1M84DChc1PLQZykYcnWgVKhUwWCmVkXyEC
         Sl7ei9HpeUMJ5NmCaKItwJ6BAyRp4lb6soTaavUOXR1bmKtUBxvnHQEwfiJ3q999RPCz
         EHqiUtyLhFlnKBx1KogpFLeKeQl+XmSkZ5lIsi0XUYYhhOmx1Pm3CBGUB5I/gojrx6/S
         CMF/SbNg+LIPm4EJPNrqjHIHevPp35ifESgXYyXe1fwltMMJA8USiAKjbLMQJTw1dCN+
         zNJ9yzAiTT6g7Su45j5Hg9lozUY3BCWVuDSRAJQVedwhEJFcIMeb4yXKvtbzjPHYcTTr
         Yhvw==
X-Gm-Message-State: AOJu0YyjJGaY41IQ+YUvP2DInxFe2e6tv/Tk15V9a2WkkHOXZWNvDypq
	X4Luogf4bdtmctJXM06fVi7CDgD/fb29rl2zCPlKCIW2MWm/xvjIx/HY4P8+/47w1GRwdRAiKZD
	widuP
X-Gm-Gg: ASbGnct7sAOCngXZDsEHSGZDllJlrk9M9k8o/rhfE5hCvGUF9vRPtNkJAkk4sDBxTNv
	EItPKVsj+Yzmz3gD0qfFGx6jhepx9N3CdXd1q+TjJXst1g6OhDfRAwIrI/6Xnz0oole3+tJ0GQ+
	sIQlOJRXdqdjwwCBuAIXZrOghuNKChVlhh7fJlIu0RI/YoGmt/bwgvcy6F/Lx+aisxmrFXwEreJ
	oi0LQfEsNE84QilhdhOxIiAdBrt2Ut5+8tZ32nUqbABq29CL/b2MDBCBVR594L5YNvcK10QezW5
	GE0ojELgi/eFYi6JC8ZF1Fw9dW41Rc7p0O9UAnlKVdseCPWRG5PanTYJtVDeaJH6wyDQJ+CpkHO
	bOdHz22JDzssx8y9FktWCkH0R+qoHN4svpZEK0l9A0HQPJooUD6DkJ38lRMGe3zQKhxGf83xpcQ
	==
X-Google-Smtp-Source: AGHT+IFuDsXghna3zxe8RnEyYrRqhg3Y89yiAFmhGr5ja0f7LQEtqJLlINIol7jTXpswSfl9NAkoIQ==
X-Received: by 2002:a05:620a:1a8d:b0:7e6:9753:db16 with SMTP id af79cd13be357-7e87df878bbmr1264247685a.14.1755451923593;
        Sun, 17 Aug 2025 10:32:03 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e076811sm450093185a.36.2025.08.17.10.32.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:32:03 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 0/8] Update to Rust 1.88.0
Date: Sun, 17 Aug 2025 13:31:49 -0400
Message-ID: <cover.1755451833.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 17:32:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2012

This patch series for the scarthgap/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.87.0 -> 1.88.0 updates and other fixes.

I intend to push this series to scarthgap/rust within 24 hours
unless a serious showstopper is pointed out.

Changes:

Gyorgy Sarvari (1):
  librsvg: upgrade 2.59.2 -> 2.60.0

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
 recipes-gnome/librsvg/librsvg-crates.inc      | 472 +++++++++--------
 ...ld-do-not-force-disable-gdk-pixbuf-l.patch |  49 ++
 ...r-meson.build-do-not-look-for-gdk-pi.patch |  28 -
 ...ot-force-disable-introspection-and-v.patch |  34 --
 ...append-RUSTFLAGS-to-rustc-executable.patch |  37 ++
 .../{librsvg_2.59.2.bb => librsvg_2.60.0.bb}  |  11 +-
 26 files changed, 1196 insertions(+), 755 deletions(-)
 create mode 100644 recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
 create mode 100644 recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
 rename recipes-devtools/rust/{cargo-c_0.10.13+cargo-0.88.0.bb => cargo-c_0.10.14+cargo-0.89.0.bb} (52%)
 rename recipes-devtools/rust/{cargo_1.87.0.bb => cargo_1.88.0.bb} (100%)
 create mode 100644 recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch
 create mode 100644 recipes-devtools/rust/files/backport-fix-test-string-merging.patch
 rename recipes-devtools/rust/{libstd-rs_1.87.0.bb => libstd-rs_1.88.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.87.0.bb => rust-cross-canadian_1.88.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.87.0.bb => rust-llvm_1.88.0.bb} (99%)
 rename recipes-devtools/rust/{rust_1.87.0.bb => rust_1.88.0.bb} (100%)
 create mode 100644 recipes-gnome/librsvg/librsvg/0001-Revert-meson.build-do-not-force-disable-gdk-pixbuf-l.patch
 delete mode 100644 recipes-gnome/librsvg/librsvg/0001-gdk-pixbuf-loader-meson.build-do-not-look-for-gdk-pi.patch
 delete mode 100644 recipes-gnome/librsvg/librsvg/0001-meson.build-do-not-force-disable-introspection-and-v.patch
 create mode 100644 recipes-gnome/librsvg/librsvg/0001-query-rustc-append-RUSTFLAGS-to-rustc-executable.patch
 rename recipes-gnome/librsvg/{librsvg_2.59.2.bb => librsvg_2.60.0.bb} (90%)

-- 
2.50.1


