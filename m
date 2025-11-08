Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EF6CCFA1A
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:20:00 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13169.1762633194767863771
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:19:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=n/+OktxE;
 spf=pass (domain: konsulko.com, ip: 209.85.219.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-880570bdef8so20162086d6.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762633193; x=1763237993; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6eqYdAj2FfeNL3B+XX5WV19xDR8ZtgktSXyrXRocaU=;
        b=n/+OktxEg6yaMJuqqVAtEtSCFl4Q0oDBntZtE4vlrrw5APnq1MA1TkLKEMPxYPqPZm
         XJ45R4/NvSJQSyvLNAO3NBHL4KJlvhGJ3Fpt/r/bYHZU9Ur8B/7vlMlvYvGZzH5UPyV3
         5/o8woxypWTD7GoG8hRJoB/Lf7DjAEESmV4NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762633193; x=1763237993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6eqYdAj2FfeNL3B+XX5WV19xDR8ZtgktSXyrXRocaU=;
        b=bCzi7ud+RXP4sJeaeuFAQlGYaLZbOXXPH9bly9MaQtkmZFPT29kHTJcF5P91YWiUG8
         rw5WkFcVcrsN6plYjUkB16fQ9jWmc4WcIj7M2xDByJI/lUFScWP3awjWY2FCpM2qc/Lj
         Lrq1KWU6K7jWWrBZlpiNwT+lRZ0qjcxzE9D9yBX5edfDN4Vh0iwC1tWKL5LHNOoRruzP
         Ccszf7lfqYKb7L42AtFqsb0qk4IXCu8hGpCyy4ktA2kpBzWyVoeTlU/U8IACprqfGrjG
         1s3DEPamVJpBYmj63kszKH3ErJLKRbXv2LlsRSCY+F6zqJr7NN4VjSB2L+uoth9g/w1r
         wnTA==
X-Gm-Message-State: AOJu0YxUlQu6eQlWQvB2nkEV8Z77fIA3j4WKsBRIc2gU0wZC+hPLrviE
	rBTmXrNN/WuIJBEJBAssmL8Huwgw4CYB5krykUc/MqP234WdapDqlXXpNTElnqO1mYpKmOqXdPy
	9uXpK
X-Gm-Gg: ASbGncvGjXRYfKq2GZz4+epKH84H/k1Wj2UQCycEDzWKrsuvbNqw34yPFvEXgKZbv3h
	b+6Cl/ItXKx+97tJqAWxXHvCigVuDksEcbsvyX8auQ7M02lEMk2w3sybaJaCC2mUagDqJ/cmYYl
	g4N309DqQ39gFCRwzFuC24pTxVlhk/s3d13js20dWqyHShU2XXXgGOzWSoWoeVL9+Y+t+0Q/j8q
	WuJOR+KKDxDutdS48iks3Ep8nqT70kKWv9k90jJCF0hcbt8JYXCYo56VevcmStc8fmRYYVj8IOU
	sqa3xKRnNrBEykPBuAoOTIvXmm6PhndVxhEYFDHig/T4lU/1H0B/JsdfJv+GQXbbiUxYGg0CepA
	bCGqNhVlHOVfwTLIbloDb1Xlzu04z9ybCJs7c5i0mgum7luozrEAFULwIy1kwN05+a5GXFa+wlW
	22oNPKfAb2pSWx1bE4tusvO4YH69EyLxNkVCv85Y4gNq5H/gbQRmohRsHsP2RbodM=
X-Google-Smtp-Source: AGHT+IG2Mrdm4nh90YsW0COsEfInaxlfyFrqnhZ9YHsrl+kiyxnu9WhmL7DCI8XMl/IXkVxdshc3+Q==
X-Received: by 2002:a05:6214:29cf:b0:70f:a4b0:1eb8 with SMTP id 6a1803df08f44-882385be7c9mr46084976d6.13.1762633193429;
        Sat, 08 Nov 2025 12:19:53 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba36d4sm19786856d6.58.2025.11.08.12.19.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:19:53 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 00/11] Update to Rust 1.90.0
Date: Sat,  8 Nov 2025 15:19:35 -0500
Message-ID: <cover.1762633051.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:20:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2447

This patch series for the scarthgap/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.89.0 -> 1.90.0 updates and other fixes.

I intend to push this series to scarthgap/rust by end of day Monday
(EST) unless a serious showstopper is pointed out.

Changes:

Alexander Kanavin (1):
  cargo-c: update 0.10.14 -> 0.10.15

Deepesh Varatharajan (4):
  rust-target-config: Update the data layout for ppc64 targets.
  cargo-c: update 0.10.15 -> 0.10.16
  rust-target-config: PPC64 targets require explicit ABI selection to
    avoid build failures with rustc.
  rust-target-config: Fix ABI override for powerpc64le target

Gyorgy Sarvari (1):
  librsvg: add ptest support

Peter Tatrai (1):
  oeqa/selftest/rust: strip debug symbols from test binaries

Ross Burton (2):
  libstd-rs: remove redundant CARGO_TARGET_DIR
  classes/cargo_common: ensure B is clean

Yash Shinde (2):
  rust: Upgrade 1.89.0 -> 1.90.0
  cargo-c: fix debug symbols containing TMPDIR references

 classes-recipe/cargo_common.bbclass           |   4 +
 classes-recipe/rust-target-config.bbclass     |  10 +-
 conf/layer.conf                               |   2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |  13 +-
 recipes-devtools/rust/cargo-c-crates.inc      | 676 +++++++++---------
 ...9.0.bb => cargo-c_0.10.16+cargo-0.91.0.bb} |   4 +-
 .../rust/{cargo_1.89.0.bb => cargo_1.90.0.bb} |   0
 ...l-codes-on-riscv32gc-unknown-linux-g.patch |   8 +-
 ...lain-syscalls-as-their-time64-varian.patch |   8 +-
 ...teps-tool.rs-switch-off-lto-for-rust.patch |  12 +-
 .../backport-fix-test-string-merging.patch    |  27 -
 ...epro-issue-fix-with-cc-crate-hashmap.patch |   4 +-
 .../rust/files/rust-oe-selftest.patch         | 189 +++--
 ...ibstd-rs_1.89.0.bb => libstd-rs_1.90.0.bb} |   5 +-
 ....89.0.bb => rust-cross-canadian_1.90.0.bb} |   0
 ...ust-llvm_1.89.0.bb => rust-llvm_1.90.0.bb} |   2 +-
 recipes-devtools/rust/rust-snapshot.inc       |  78 +-
 recipes-devtools/rust/rust-source.inc         |   3 +-
 .../rust/{rust_1.89.0.bb => rust_1.90.0.bb}   |   0
 recipes-gnome/librsvg/librsvg/run-ptest       |  17 +
 recipes-gnome/librsvg/librsvg_2.61.0.bb       |  32 +-
 21 files changed, 582 insertions(+), 512 deletions(-)
 rename recipes-devtools/rust/{cargo-c_0.10.14+cargo-0.89.0.bb => cargo-c_0.10.16+cargo-0.91.0.bb} (80%)
 rename recipes-devtools/rust/{cargo_1.89.0.bb => cargo_1.90.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/backport-fix-test-string-merging.patch
 rename recipes-devtools/rust/{libstd-rs_1.89.0.bb => libstd-rs_1.90.0.bb} (90%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.89.0.bb => rust-cross-canadian_1.90.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.89.0.bb => rust-llvm_1.90.0.bb} (99%)
 rename recipes-devtools/rust/{rust_1.89.0.bb => rust_1.90.0.bb} (100%)
 create mode 100644 recipes-gnome/librsvg/librsvg/run-ptest

-- 
2.51.0


