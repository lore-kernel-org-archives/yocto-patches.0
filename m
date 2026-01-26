Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EDBD19535
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:55:11 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35784.1769471701013913547
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:55:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=q63w7lcx;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c52e25e644so548864785a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471700; x=1770076500; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VXwVxiY4j/KwJN7SrF8e2mQWY3GnBAhMTyrgF3xuGNc=;
        b=q63w7lcxxMe8t27R2H6H+LdxXb6IzPvK2DWFgpovFwH1rs6Lr6yh6IJl9QFVw00em9
         PKUQt2qyLb067qwX878QVhH9AZrFR85vytXjCJxWHo90L1y4qtHJTtZYh3SvjK5BQyVz
         PVjJuC4g1ceodmCCpBe26JwspS2GQzq8gtGGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471700; x=1770076500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXwVxiY4j/KwJN7SrF8e2mQWY3GnBAhMTyrgF3xuGNc=;
        b=mxGSaORU69bSoWFaGXjK586LPXY7wsW4E+NN3nhPFhrn1RonXuuMB0wmCchIi7xGhD
         zpzJcxZNZYF7LauDjTrlEHc26TvZg/lYxJxOjCmi8q/3ND8LBol1FZbbjNXkGw+3e6G0
         QhTkULrWYIPf8w+tsPDcoH/SDOAn8BEee4Exe33LSU1VFc4h5lk0sgXzdb7D7msi0fIm
         tBnMeUF4x3BB1DAefSyitL4aFqN6pFPn7TckI76r7i/aAZ/XOs2WKskSj6k9+slKiDLn
         BgxUi7HLqmxJ1k9+SiNntJSVnsgZqWjFBj92hnNRAh5AX4yMny11rjqYaS+iFVd7Jsh6
         suLA==
X-Gm-Message-State: AOJu0Yx4Z42nUYbA7X7Q5LtO31aa1yKBBSSIOyxufpDzzcKzuo0s5F+b
	VF1xd7d+u6TJ0L9esfpXqu7p/3gxZBiAAxVj6b6nkBS2NzDK1qtXq1QlGpmtp5z/qqp9n4ojjcI
	OGsAJ//Q=
X-Gm-Gg: AZuq6aJUVs2vLW/PP1uGq0dZitkxygyDUUgxjFSKbPD2dsHZrWn/oWDddJcMPCAUKp6
	ckKBu5fUfGwOcCUVEEPsOSErTAznDXkjp30w1leUQDkSADjiUUxySxMLqPBXvsixmvfwztoA9SW
	DsYketC+RvU8GLjaQS6YD2xpTR/RAKKEMeHDH+HytI0YsbgpWNUep8Q8po7m6Y3Whpz5mJ/dKUZ
	De3O9z6KJO7Ir4jVIG+aMXu+qfjIe6IwaB43jnsKIuSe2c8WFwmvL6OQF/H1rZS6cJ7mi4xDei0
	lfTDIFFIrlsRFnSl8OJ5mEvIfj8lOLyNwJd4TYc91OuXlc9Ebl5oVMHVyA2aJyK+A+tHEV4t19J
	N1ujF4yotaI4SxWX2aJjBhs8FKdt6mt9zr7kJldE11CF18mBeCLjfF+47i8CiT0ezUxuPYOh9g6
	inuF5bSALB5U+s53hvGBmhmYr+PWrsm+5Q7JmC+R3yOkw3KsdQCfWK80JA3l7ac87m2TPb28E/7
	HZSgO2BHvXr3UAEZQUM8yipRteaDO6BaQokSCtDB5E0WS67PLRA
X-Received: by 2002:a05:620a:7084:b0:8c5:2ef1:7d4e with SMTP id af79cd13be357-8c6f9662015mr778342485a.73.1769471699754;
        Mon, 26 Jan 2026 15:54:59 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061740885a.15.2026.01.26.15.54.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:54:59 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 00/10] Update to Rust 1.92.0
Date: Mon, 26 Jan 2026 18:54:46 -0500
Message-ID: <cover.1769471543.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:55:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3102

This patch series for the kirkstone/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.90.0 -> 1.91.0 -> 1.91.1 -> 1.92.0 updates and other fixes.

I intend to push this series to kirkstone/rust by end of day tomorrow
(January 26, EST) unless a serious showstopper is pointed out.

Changes:

Alexander Kanavin (2):
  rust-target-config.bbclass: add RUST_TARGET_ABI to sstate signature
    exclusions
  rust-target-config.bbclass: apply signature exclusions only to
    native/nativesdk

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

 classes/rust-target-config.bbclass            |   9 +-
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
 16 files changed, 435 insertions(+), 620 deletions(-)
 delete mode 100644 recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
 rename recipes-devtools/rust/{cargo-c_0.10.16+cargo-0.91.0.bb => cargo-c_0.10.19+cargo-0.93.0.bb} (72%)
 rename recipes-devtools/rust/{cargo_1.90.0.bb => cargo_1.92.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.patch
 rename recipes-devtools/rust/{libstd-rs_1.90.0.bb => libstd-rs_1.92.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.90.0.bb => rust-cross-canadian_1.92.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.90.0.bb => rust-llvm_1.92.0.bb} (99%)
 rename recipes-devtools/rust/{rust_1.90.0.bb => rust_1.92.0.bb} (99%)

-- 
2.51.0


