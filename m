Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376B7CCFA18
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:16:10 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13107.1762632963413140765
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:16:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YLJkpv4d;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b23b6d9f11so183836685a.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762632962; x=1763237762; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+eeDzhpc9BFhMZF46iAh15GgB2qv1clYnik+ho3gzc=;
        b=YLJkpv4dy/N4yW16jE9/B426QNI6KVwB3ey+lyfho+xQN/PvcngaScL/9J2vWaT6gI
         s30Wv0jkWYcpDXVpfjbISUc6nvJbP5x8FOk4Wkr60ilzOUFR7HDvdGYahQIx9NdhEr1B
         oVL1avWH/0uUKB3MrPBxrw1x9pVqoP9Dg4olw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632962; x=1763237762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+eeDzhpc9BFhMZF46iAh15GgB2qv1clYnik+ho3gzc=;
        b=pfmVqPg79f3Pc4M4vPTB42Z1Z7LVeUcLJId0R+uKkVFsEThPnJAJE5fgL5Ux4ogYaZ
         lXm5l9eICi2CaNGWQ1aA9p+ylA3RzcoKcTaCUwvFXwca7FXg1eCKTLfcZsqbO0ANo+aH
         wnrX7yxmJ6s6ojXLqGMY85SR8PXXapQVe9tQEIUsC+le5tT4zSMiDZe8mZltm3KfeR6K
         8/Pi7vpJMFcYX1NzRYJ1O6r9svEv5Q369FF5OX1ykN7vZ7izNCSsFDZoTqW+m/PAXM4r
         L1HQVmhfDQ5ddDM6MddO0jtOH9HIIPCPNgPxjtNeCpMhqdi+aXaF+LoCl9I1GjxBho7Z
         eW1w==
X-Gm-Message-State: AOJu0Yx+J9HPHsFRDvp09Rr/cBVtIoL0n9RJP6VRF9p/Zc+PAstKUIiJ
	JsdbFPy0t+4ze9Jyi5/ZyBteGKxpBLhwbrwHs8FReA+xzKAnfLFMLZA63At6wLDjLxC3ANwEGvk
	3y5gJ
X-Gm-Gg: ASbGncupHhouFTARkjQXZpxY1Ufc7aAb7sdEsK/bA8Kjpxv+Y+zazz3Drr9OdUlQIip
	7c/6hGywdKl9sd6zXzjzbB52wAL2qyhZ7QWn/hDYP+EAKqF901Wj23LbT/xPx1A6PuMHTFTEMe8
	HODxlQZ3OYSbPV81L68gVF/SEfWLh7ge6lftKdc/gEJl/UHgf1XL7LzbZUj0e+xV71yG7Q5BpIv
	wJgnIlm88XK2dNKxrBR46tw5yo9elBfXUAs3xjRF5b6Fecwx3dBWIrIHav6bEBiFBqV7UlxQLY2
	OubhuMleVFbWX5foYjORwoCLQ/CQmyivQP/U5BflQVCaq0g0ULb0cXtQBVC6dhuQfvp3qPkcd+4
	Gyg/LGhu1RkhBN05GTtGLoEFqLgRsNfH2hqK6SIWZBAmt1mq133eeOa8IZ49crHee9ibPNBOT5E
	rkMJs/laS93opqZGXH1xGx75FWgAAElWMQGylcHDK1gaUEf+0r6px1
X-Google-Smtp-Source: AGHT+IH18NO+cQaSDHIuVSZdwy7LkYZfpS39yW59Y1fxckwhOQN2anEg8R0lu3Skphl74MhsOHPKlQ==
X-Received: by 2002:a05:622a:46:b0:4e8:9a7d:90eb with SMTP id d75a77b69052e-4eda4fd2993mr47438141cf.38.1762632961958;
        Sat, 08 Nov 2025 12:16:01 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm20001896d6.53.2025.11.08.12.16.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:16:01 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 00/11] Update to Rust 1.90.0
Date: Sat,  8 Nov 2025 15:15:42 -0500
Message-ID: <cover.1762632742.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:16:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2435

This patch series for the kirkstone/rust mixin layer backports the
recent Rust toolchain changes in oe-core master branch to pull in
the 1.89.0 -> 1.90.0 updates and other fixes.

I intend to push this series to kirkstone/rust by end of day Monday
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

Peter Tatrai (1):
  oeqa/selftest/rust: strip debug symbols from test binaries

Ross Burton (2):
  libstd-rs: remove redundant CARGO_TARGET_DIR
  classes/cargo_common: ensure B is clean

Scott Murray (1):
  cargo-c: Fix compilation

Yash Shinde (2):
  rust: Upgrade 1.89.0 -> 1.90.0
  cargo-c: fix debug symbols containing TMPDIR references

 classes/cargo_common.bbclass                  |   4 +
 classes/rust-target-config.bbclass            |  10 +-
 conf/layer.conf                               |   2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |  13 +-
 recipes-devtools/rust/cargo-c-crates.inc      | 676 +++++++++---------
 ...9.0.bb => cargo-c_0.10.16+cargo-0.91.0.bb} |   8 +-
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
 19 files changed, 538 insertions(+), 511 deletions(-)
 rename recipes-devtools/rust/{cargo-c_0.10.14+cargo-0.89.0.bb => cargo-c_0.10.16+cargo-0.91.0.bb} (64%)
 rename recipes-devtools/rust/{cargo_1.89.0.bb => cargo_1.90.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/backport-fix-test-string-merging.patch
 rename recipes-devtools/rust/{libstd-rs_1.89.0.bb => libstd-rs_1.90.0.bb} (90%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.89.0.bb => rust-cross-canadian_1.90.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.89.0.bb => rust-llvm_1.90.0.bb} (99%)
 rename recipes-devtools/rust/{rust_1.89.0.bb => rust_1.90.0.bb} (100%)

-- 
2.51.0


