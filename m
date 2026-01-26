Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B35D19525
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:51:30 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36291.1769471488959850472
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:51:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ndCHvfNd;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c5265d06c3so669753285a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471488; x=1770076288; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1kli5mrQGF8VMpF0LMF4YOY81gv8NuhWloWtNdmbeVM=;
        b=ndCHvfNdO6HxWv11RSkTe3D/NhO+uEEM7/8WX7SRCgXvtrbiKVEUJz4pnmCIdytsi4
         Si6poJ18KOeqKFrJDrUCWe7Ico2qWdW+XrrTZqNGj5iS9ayh8+t3mWGgkfmZ0dPOIJPJ
         UFv+KWW7wL1Hihd7Wl/XLHOxsHfbp66rHya4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471488; x=1770076288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kli5mrQGF8VMpF0LMF4YOY81gv8NuhWloWtNdmbeVM=;
        b=kySIrz5+pOgT+ku70MkuPDF6vdVyYTcpWHP/S8Zs4k7NeIImXw2fG7bCY/J8dKoELx
         NUOyVzazCcqv8Lf/gBmKGcOalEn/BtJgT/haq15vxftMeOmCEU8PI4gUUT/jd2du68bn
         D51NdeqXEQJmBkyBUhQimsb8/UpjNzzx7/NWKuvUtp5F8ql08AGegzuA5okHWamGAy0W
         BCOKnRAn6E22oAE+cHO4ivYqdFk/mWyHeXieTDO438HLrGDtmrdcbdyqpa0wQFrH5139
         cymQWVcicXctLdGm4gFLKlEd9+uQZT6rBZLdPhSwhwYlH2t7UZi0exI+KqJ6qXUUbmfJ
         oTPw==
X-Gm-Message-State: AOJu0Yy2Zx7vpAqDr47aDfrUFBSNDK8Cl3vddtAa3jtmadQRvf5YDa43
	oUGtt312Auk8g+gIoc8owU8dcPXQLByZPQRHJoLc7uGQ74XDlSO6m2gom8pxujAAYgcGnfydeTu
	wX6ZnsBk=
X-Gm-Gg: AZuq6aJ1M4/7Lol4JKwsXJUaeSaBQP/HQNBDD+lIX3K/955LN6fFPih1lyPE/ui9ZBj
	XMeNPJ0VCg8vVPFvs7Tjp34/VExhqAD9pL2yUOH8gj/ZhpYmTLwfLAD5RfH9X9SHGcK3VEOTX3O
	BL1ZgZddnaZiYH17w4p5XmOZB0XlXJknM7vSLvgAK6rkuk+IgCPtDd2pvtQV14qCCSmog3ANauc
	Gb6ENEvUKij3bbdDfQfmCfYWgKboAhymwpapp3eTPHoM5DeyBddQaQnwVu9XVG8pNNf/vIN4nGi
	qHZ5256UnA6IAilqM5OgYbJ9yyVQ5oXKtAHKtrslLCn3hHCCsthGIIItTiZOhkfWa8AECyNe9LJ
	k8OhQE2a5AO5SQCdRGDsqGUl9rTRJiqLxtEOVD2XGX5m7/j1tWetOF1hvCEIcwW47uFiC6k0hre
	4R8aoa+b5oNlrF5I8ZLI6H0tZrisfwZXcbrP3QsarEwkXdYAgdQg0X6YbTjpAeyCa3ofmcpmY71
	8+ErNqgaPwbgZeZ63sKdTWe+O2mclFRSmYbO2e5IhC4XSh0+auX
X-Received: by 2002:a05:620a:2907:b0:8c6:a5c8:fb39 with SMTP id af79cd13be357-8c6f97bdf83mr676749085a.1.1769471487427;
        Mon, 26 Jan 2026 15:51:27 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061293885a.15.2026.01.26.15.51.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:51:26 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 00/11] Update to Rust 1.92.0
Date: Mon, 26 Jan 2026 18:51:04 -0500
Message-ID: <cover.1769470900.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:51:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3090

This patch series for the scarthgap/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.90.0 -> 1.91.0 -> 1.91.1 -> 1.92.0 updates and other fixes.

I intend to push this series to scarthgap/rust by end of day tomorrow
(January 26, EST) unless a serious showstopper is pointed out.

Changes:

Alexander Kanavin (3):
  rust-target-config.bbclass: add RUST_TARGET_ABI to sstate signature
    exclusions
  rust-target-config.bbclass: apply signature exclusions only to
    native/nativesdk
  librsvg: upgrade 2.61.0 -> 2.61.3

Deepesh Varatharajan (2):
  cargo-c: update 0.10.16 -> 0.10.18
  cargo-c: update 0.10.18 -> 0.10.19

Hemanth Kumar M D (2):
  rust: Upgrade 1.91.1 -> 1.92.0
  rust: enable default uwtable and ignore arm no_std test

Yash Shinde (4):
  oeqa/selftest/rust: Exclude tier-check and fix openssl-sys build error
  rust: Upgrade 1.90.0 -> 1.91.0
  rust: remove passing tests from excluded and ignored list.
  rust: Upgrade 1.91.0 -> 1.91.1

 classes-recipe/rust-target-config.bbclass     |   9 +-
 conf/layer.conf                               |   2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |   9 +-
 recipes-devtools/rust/cargo-c-crates.inc      | 658 +++++++++---------
 ...Use-libc-SYS_futex_time64-on-riscv32.patch |  36 -
 ...1.0.bb => cargo-c_0.10.19+cargo-0.93.0.bb} |   5 +-
 .../rust/{cargo_1.90.0.bb => cargo_1.92.0.bb} |   0
 ...-gcs-instead-of-gcs-target-attribute.patch |  66 --
 ...teps-tool.rs-switch-off-lto-for-rust.patch |  20 +-
 .../rust/files/rust-oe-selftest.patch         | 163 +----
 ...ibstd-rs_1.90.0.bb => libstd-rs_1.92.0.bb} |   0
 ....90.0.bb => rust-cross-canadian_1.92.0.bb} |   0
 ...ust-llvm_1.90.0.bb => rust-llvm_1.92.0.bb} |   2 +-
 recipes-devtools/rust/rust-snapshot.inc       |  78 +--
 recipes-devtools/rust/rust-source.inc         |   3 +-
 .../rust/{rust_1.90.0.bb => rust_1.92.0.bb}   |   4 +-
 recipes-gnome/librsvg/librsvg-crates.inc      | 624 ++++++++---------
 ...ld-do-not-force-disable-gdk-pixbuf-l.patch |   2 +-
 ...append-RUSTFLAGS-to-rustc-executable.patch |   2 +-
 ...e-care-of-deprecated-assert_cmd-Comm.patch |  42 ++
 .../{librsvg_2.61.0.bb => librsvg_2.61.3.bb}  |   4 +-
 21 files changed, 790 insertions(+), 939 deletions(-)
 delete mode 100644 recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
 rename recipes-devtools/rust/{cargo-c_0.10.16+cargo-0.91.0.bb => cargo-c_0.10.19+cargo-0.93.0.bb} (70%)
 rename recipes-devtools/rust/{cargo_1.90.0.bb => cargo_1.92.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.patch
 rename recipes-devtools/rust/{libstd-rs_1.90.0.bb => libstd-rs_1.92.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.90.0.bb => rust-cross-canadian_1.92.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.90.0.bb => rust-llvm_1.92.0.bb} (99%)
 rename recipes-devtools/rust/{rust_1.90.0.bb => rust_1.92.0.bb} (99%)
 create mode 100644 recipes-gnome/librsvg/librsvg/0001-tests-revert-Take-care-of-deprecated-assert_cmd-Comm.patch
 rename recipes-gnome/librsvg/{librsvg_2.61.0.bb => librsvg_2.61.3.bb} (95%)

-- 
2.51.0


