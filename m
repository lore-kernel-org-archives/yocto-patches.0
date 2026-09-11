Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E39C88E53
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:15:29 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48491.1789157722361748678
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:15:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=s6T7ix6h;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-530d93a18ecso11209671cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157721; x=1789762521; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nGUWIGWrULT0n5DGTAQB9yFfNSwx0S6O+1oEUhe9hNk=;
        b=s6T7ix6hJrthQA1o31koe1iawpvylXOgY99kCnJMI0yoputERG4hSjgziaDuaQC8ea
         DecxGU2c66WwYO9PXPOUH/ywOpEU4YvVcdCWPGbXv6RGjeVc6IvRLvDUitwTLREQ33ZE
         j5qKaB4CkoWzHqfddDsu4KUvXjaGbQLToZ0OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157721; x=1789762521;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nGUWIGWrULT0n5DGTAQB9yFfNSwx0S6O+1oEUhe9hNk=;
        b=Lnyqwb3L+P9mOOaR7tXPEXF0SvJsGbL6clBnG6V5WLn4xmhGunyOfql6piyqZyTc9K
         X2Ym8+ryRRxBomOGaKdgR+cexval8R1g4dEzBA3CeHc7VF+NWUCrclP1r17NQJngAlho
         hFeMG+bGr5g220F67yKOtYvaItcF4Y5Mz1KBIANzbkX8bTqTemzDr++Vf1p+BmUIUGt0
         kSJze5yH+B7vGmV1LEoyREKJxM9UtpBgYyTbN6ta1bS+sIuDqkxMOh0bqC20X7IXD+zW
         h0CWEXx5H4nGla+NNllxjQ784wgoQTc+SDaGm6NiCVxLHsuneXGrxM+a1LE/+/CIbhKp
         Mw6Q==
X-Gm-Message-State: AFuF++nS5n9QR3QyBLDTRRuNU/snE5Qk4MhMi4FN44yGuiRzsCZFMqtU
	b08bITV/aYshQ6sJd78FmibbxQJqY+U5UOK59s9AIeHd+nhpE30i2MeB/QX/C13GFfFiwAjrij3
	BDGHw
X-Gm-Gg: AYBFou1BPlCKLifcMuaJD4/HjQAOVbyE2dFVQZaPQzWDUD4XBzP5/igJpd62kgkuC97
	S308YLYECYDChcImur+cp83J0vvV0mswUJ7N1B3uxFok5QI3a6XR0Z89mwur7WgdDY1NP2u/uBh
	GZ2ADXwWMrZ9WryKjXzieW6Pj2ZOiB5uIFR0/yR8NHlJM1tg6LuhYNVtw/BdkGV/ESCpK8hwA82
	q4eJp7cUHSR+b0PLGmv/Es1hRuBXrIiUFfFo4ImfkHYrT2G6rYjvRKsTFK8I9mT6BIB3hqCbdMy
	VW96taHh9MZ7Htv2m3Bke8ghvGqmkgFlXaARsS556JZVTeqEPq4tqoFjEG/LlAKrNUmoHSoQzIs
	vVczJO8p++75Lg7ffz1DvZxMkVCTwn9ZjxpTLQPw/7qIojePsNE2PYdkWCeSVaJ9ZrDTAi1cfc0
	DAf3DCVvjo8yWzhIr37KPQeMGpszwRwH39xPKWf3Sc6VYZFdhyqyCKjbMa8AlTJLqX1USSxFWk0
	R8+qL/qTi+k3wNmoFBpz3JnTJAfwGi+6+cu7aPZznHVia82vIQYGXglUs15grbhg8iB074s/KvW
	kI2ZbMfgn3WrBR+CAB/iO43lUtwFsr5nLO7UeJ1Fy3h8DXo=
X-Received: by 2002:a05:622a:1341:b0:530:dae4:81d with SMTP id d75a77b69052e-530dae4376amr43531521cf.27.1789157721131;
        Fri, 11 Sep 2026 13:15:21 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b699bsm28930706d6.37.2026.09.11.13.15.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:15:20 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 00/11] Update to 1.98.1
Date: Fri, 11 Sep 2026 16:15:04 -0400
Message-ID: <cover.1789155804.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:15:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4804

This patch series for the wrynose/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.96.1 -> 1.97.1 -> 1.98.0 -> 1.98.1 updates and other fixes.

Note that the clang reproducibility fix included as part of the
1.97.1 upgrade has not been included due to the number of bbappends
it would entail, and the potential to incur maintenance hassles down
the road.  I plan to try submitting it as a separate backport for
oe-core wrynose branch when I have the time to crank through the
required testing.

I intend to merge this series to wrynose/rust by end of day Monday
(September 14, EST) unless an issue is pointed out.

Scott


Changes:

Deepesh Varatharajan (4):
  rust: Upgrade 1.96.1 -> 1.97.1
  rust: Upgrade 1.97.1 -> 1.98.0
  rust: Fix build and oe-selftest failures with LLVM 23
  rust: Upgrade 1.98.0 -> 1.98.1

Jaipaul Cheernam (1):
  classes-recipe: fix trailing whitespace

Markus Volk (1):
  rust: patch uninative loader into snapshot's self-contained lld

Richard Purdie (1):
  libgit2: upgrade 1.9.6 -> 1.9.7

Ross Burton (2):
  classes/ptest-cargo: use oe.path.join instead of os.path.join
  classes/ptest-cargo: add explanatory comment

Sunil Dora (1):
  rust: Do not pass the removed x86 amx-tf32 feature to LLVM 23

Yash Shinde (1):
  cargo-c: upgrade 0.10.24 -> 0.10.25

 classes-recipe/ptest-cargo.bbclass            |   8 +-
 classes-recipe/rust-target-config.bbclass     |   5 +
 conf/layer.conf                               |   4 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |   4 +-
 recipes-devtools/cargo-c/cargo-c-crates.inc   | 561 ++++++++-------
 ...8.0.bb => cargo-c_0.10.25+cargo-0.99.0.bb} |   2 +-
 .../rust/{cargo_1.96.1.bb => cargo_1.98.1.bb} |   0
 ...l-codes-on-riscv32gc-unknown-linux-g.patch |   9 +-
 ...lain-syscalls-as-their-time64-varian.patch |  81 ---
 ...teps-tool.rs-switch-off-lto-for-rust.patch |   6 +-
 ...ip-StdarchVerify-when-remote-testing.patch |  30 +
 ...xplicit-tail-calls-disable-two-tests.patch |  39 --
 ...ommits-from-rust-Fix-selftest-llvm23.patch | 661 ++++++++++++++++++
 ...lls-ignore-tests-on-unsupported-llvm.patch |  96 ---
 ...ild-script-path-leakage-in-artifacts.patch |  28 -
 ...llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch |  38 +
 ...epro-issue-fix-with-cc-crate-hashmap.patch |   5 +-
 .../rust/files/rust-oe-selftest.patch         |  24 +-
 ...ibstd-rs_1.96.1.bb => libstd-rs_1.98.1.bb} |   0
 ....96.1.bb => rust-cross-canadian_1.98.1.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       | 104 +--
 recipes-devtools/rust/rust-source.inc         |   9 +-
 ...source_1.96.1.bb => rust-source_1.98.1.bb} |   0
 .../rust/{rust_1.96.1.bb => rust_1.98.1.bb}   |  11 +-
 ...m-libraries-are-private-link-librari.patch |   4 +-
 .../{libgit2_1.9.6.bb => libgit2_1.9.7.bb}    |   2 +-
 26 files changed, 1109 insertions(+), 622 deletions(-)
 rename recipes-devtools/cargo-c/{cargo-c_0.10.24+cargo-0.98.0.bb => cargo-c_0.10.25+cargo-0.99.0.bb} (87%)
 rename recipes-devtools/rust/{cargo_1.96.1.bb => cargo_1.98.1.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch
 create mode 100644 recipes-devtools/rust/files/0003-bootstrap-skip-StdarchVerify-when-remote-testing.patch
 delete mode 100644 recipes-devtools/rust/files/0003-explicit-tail-calls-disable-two-tests.patch
 create mode 100644 recipes-devtools/rust/files/0004-Backport-commits-from-rust-Fix-selftest-llvm23.patch
 delete mode 100644 recipes-devtools/rust/files/0004-explicit-tail-calls-ignore-tests-on-unsupported-llvm.patch
 delete mode 100644 recipes-devtools/rust/files/0005-remap-OUT_DIR-paths-to-fix-build-script-path-leakage-in-artifacts.patch
 create mode 100644 recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
 rename recipes-devtools/rust/{libstd-rs_1.96.1.bb => libstd-rs_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.96.1.bb => rust-cross-canadian_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{rust-source_1.96.1.bb => rust-source_1.98.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.96.1.bb => rust_1.98.1.bb} (95%)
 rename recipes-support/libgit2/{libgit2_1.9.6.bb => libgit2_1.9.7.bb} (92%)

-- 
2.55.0


