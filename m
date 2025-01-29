Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF57C0218F
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 18:09:18 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web11.19367.1738174154018076637
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jan 2025 10:09:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=E4QTO7xY;
 spf=pass (domain: konsulko.com, ip: 209.85.166.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844e55a981dso193463039f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 10:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1738174153; x=1738778953; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+bM98vhJUP87BWPlZgrW+expkJ/OcRgDfXNMElJwTI=;
        b=E4QTO7xYM9TOT042uZBGGXxNosGz0fn/QMp9+atJlC29ak0Kqu5Q3bQHj5/noyDiyF
         H259oDAGOr9b5TnRbNi9M/fkckWeCIo8WUtGXHInF4xPGhoX/eawJ6eQ39TANYgn7uEB
         k5sAA/8fbvFdkEh2zHi94bca4QbRBs+nUmUG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174153; x=1738778953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+bM98vhJUP87BWPlZgrW+expkJ/OcRgDfXNMElJwTI=;
        b=NExmMvw0l/oCyf1COOxeIs+4AE8UGuxptj3w/q82Kg3Eq6aFqG1Aje1yDbz9N8A++c
         LWKF4Q0v3cqBCAnHyZNkk88gOfrB7Bi3uxFFDhj+J8yeguREEA3dbt31OXWVcVCHZlsa
         CLFLm2F/lrPGfuQnptO499G++rydvZpF4DeeGt1V/tOKcr0NyZ2od7/fHy3bnAcn0dGx
         8k5FonEabiXKTyyExcSibWkRC5qUbvynoFgFyW+F2iTyPzl0QKdId2WV44vTSkToUb6v
         YKVS4mGChdOxhXh30dVaGQmwAhZC26/QDq6kQNV8IZ8gp7ID2h6N//TLqIpk4wqXrukV
         eCGA==
X-Gm-Message-State: AOJu0Yy2nPf2htx5hodzGgs/mlr//zF76oNT5iZP7KJrbdzgFm47fi35
	5y0SCOL9t9d4R0TLG2XZFRQPtKrMd9MxBPmOzrdWFQ9fqpxPT0etq1pisJT14a9lAR5Vs9t2MmU
	x
X-Gm-Gg: ASbGncvzrmoere9PFSmUFPpzawNUMLGPFc6J2119iYED39JJ8nie7IbMGafvL0sDXrw
	OH3VilHWl8ZC8pLLInqIra9reSXSG3IrYA+k8IJbJH6P9phd2LSRjjglq2pxsSjxXvwdslIj7dh
	GxfGyAZJwnuyFUB+CmtCx2muct+CFEDMNvGPJPTCQQ1TrrwuoN0jAWLfjmU3sKCnV2CBldRB0Vw
	dhBKCrXhADsI3E/lWw4XwqY6r35jhRwsMJ5eV23+MBJvkmqD5CUlXV1i6L+iV8YemiAovJMBb5o
	OWwCCqUyxm7gHSTHHSsbTILWXfHnc0/nJspEFTWa9p4XQyDVjZyw7Wj+0KyDWuqmE5o=
X-Google-Smtp-Source: AGHT+IECqLJG1yFITkGS42XJKj/yHELKRX8we8oU5BzD8UqgrVGNA1RB8bRFDzp3uI6VsysgtIUFgg==
X-Received: by 2002:a05:6602:6cce:b0:84a:78ff:1247 with SMTP id ca18e2360f4ac-85427dea2e0mr369659839f.9.1738174152801;
        Wed, 29 Jan 2025 10:09:12 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1da4462asm3903034173.55.2025.01.29.10.09.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:09:12 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 0/9] Update to Rust 1.81.0
Date: Wed, 29 Jan 2025 13:08:51 -0500
Message-ID: <cover.1738173519.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 18:09:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1013

This patch series for the scarthgap/rust mixin layer backports the
various Rust toolchain changes in oe-core master to to pull in the
1.80.0 -> 1.80.1 updates that have landed in the last few months in
oe-core.  At this point the backported selftest (as the "rust_mixin"
module) is passing in my environment.

I intend to push this series to scarthgap/rust within 24 hours
unless a serious showstopper is pointed out.

Changes:

Adrian Freihofer (1):
  rust: increase test timeout again

Alexander Kanavin (4):
  cargo.bbclass: do not install libraries by default
  cargo-c-native: update 0.10.3 -> 0.10.5
  cargo-c: convert to target recipe
  librsvg: update 2.58.2 -> 2.59.2

Deepesh Varatharajan (3):
  rust-target-config: Update the data layout for x86 , ppc , riscv64 ,
    aarch64 and loongaarch64 targets.
  rust: Fix for duplicate libstd.so
  rust: Upgrade 1.80.1->1.81.0

Enrico Scholz (1):
  rust-common: add LDFLAGS to 'build-rust-cc' wrapper

 classes-recipe/cargo.bbclass                  |   8 +-
 classes-recipe/rust-common.bbclass            |   2 +-
 classes-recipe/rust-target-config.bbclass     |  18 +-
 conf/layer.conf                               |   2 +-
 recipes-devtools/rust/cargo-c-crates.inc      | 478 ++++++------
 ...81.0.bb => cargo-c_0.10.5+cargo-0.83.0.bb} |   5 +-
 .../rust/{cargo_1.80.1.bb => cargo_1.81.0.bb} |   0
 ...te-host-information-into-compilation.patch |  51 --
 .../rust/files/hardcodepaths.patch            |  46 --
 ...crease-timeout-in-process-sigpipe-ru.patch |   2 +-
 ...epro-issue-fix-with-cc-crate-hashmap.patch |  53 +-
 .../rust/files/zlib-off64_t.patch             |  14 +-
 ...ibstd-rs_1.80.1.bb => libstd-rs_1.81.0.bb} |   0
 ....80.1.bb => rust-cross-canadian_1.81.0.bb} |   0
 ...ust-llvm_1.80.1.bb => rust-llvm_1.81.0.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       |  78 +-
 recipes-devtools/rust/rust-source.inc         |   4 +-
 .../rust/{rust_1.80.1.bb => rust_1.81.0.bb}   |   2 +
 recipes-gnome/librsvg/librsvg-crates.inc      | 682 +++++++++---------
 ...-rust-target-to-cargo-also-when-not-.patch |  44 --
 ...r-meson.build-do-not-look-for-gdk-pi.patch |  28 +
 ...ot-force-disable-introspection-and-v.patch |  34 +
 .../librsvg/disable-rsvg-loader-test.patch    |  40 -
 .../{librsvg_2.58.2.bb => librsvg_2.59.2.bb}  |  38 +-
 24 files changed, 801 insertions(+), 828 deletions(-)
 rename recipes-devtools/rust/{cargo-c-native_0.10.3+cargo-0.81.0.bb => cargo-c_0.10.5+cargo-0.83.0.bb} (69%)
 rename recipes-devtools/rust/{cargo_1.80.1.bb => cargo_1.81.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-into-compilation.patch
 delete mode 100644 recipes-devtools/rust/files/hardcodepaths.patch
 rename recipes-devtools/rust/{libstd-rs_1.80.1.bb => libstd-rs_1.81.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.80.1.bb => rust-cross-canadian_1.81.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.80.1.bb => rust-llvm_1.81.0.bb} (100%)
 rename recipes-devtools/rust/{rust_1.80.1.bb => rust_1.81.0.bb} (99%)
 delete mode 100644 recipes-gnome/librsvg/librsvg/0001-Makefile.am-pass-rust-target-to-cargo-also-when-not-.patch
 create mode 100644 recipes-gnome/librsvg/librsvg/0001-gdk-pixbuf-loader-meson.build-do-not-look-for-gdk-pi.patch
 create mode 100644 recipes-gnome/librsvg/librsvg/0001-meson.build-do-not-force-disable-introspection-and-v.patch
 delete mode 100644 recipes-gnome/librsvg/librsvg/disable-rsvg-loader-test.patch
 rename recipes-gnome/librsvg/{librsvg_2.58.2.bb => librsvg_2.59.2.bb} (67%)

-- 
2.48.1


