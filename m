Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEA4C0219E
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 19:17:47 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.web10.1816.1739301460975348896
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 11:17:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dyGLLWHL;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c05b91245fso160952385a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 11:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739301460; x=1739906260; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+yF0zlRKvGTjmlseNINleP+ZSPgNcu9NEwOT/aJdTU=;
        b=dyGLLWHLPVSTcROQlK1YrdcIAxiRYOWIdnu1gP63g6uE15XbR+i78797L6Yu8cWa4+
         jzRxBAGPLkAKEyI/LA/iqqIoy3GOrP8eWvNjpiweRtkusqNglBrLDrWnkNtc1/GLYy4s
         YzPNC2NVDz6g751ImR0AFCGyXglneIfevIC3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301460; x=1739906260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+yF0zlRKvGTjmlseNINleP+ZSPgNcu9NEwOT/aJdTU=;
        b=GLuFzooaA2HdJGpffI5HG3XguLn/bp3cak2efM5mtT5oIrde8OOh+W0jkGJq8SYdAF
         IsA1Vjv3zMm+6iOOQkqagrOh9RFQUT6NHV2s2sSkFjC5UYZY/zkO7sH0ABdqj5A8Iypw
         gqcwYy+SpYynnW1ifH7xLEgriCbfTpIjNsWLeegxCX/YqqVBcgV5i6++Fq/2NGNpg+ZS
         LbXMrsr3+6UseKpIiuwh4WgxDgEgK4/26O7Z1gPG3bOPq6aeBYJ6/x7G/QCst95Qg/++
         PiMjm5VHpVfHyYQXsaF7ImMpa7NPoNGmzdd/SSL6zYJX1sLpTihI5gYFM+3ipcNus8EI
         fOIQ==
X-Gm-Message-State: AOJu0YzLWy83jPdee6Qn4LdD9cjDwdebVx5HibybsQzZ/s9RmASDevGe
	yjWXfycE2yWrENp7ZbljOUXNnsKvpI4cm9I1cxsqSAwojIb+XcgP1FNFBm7tJb71q1hcs86VVXR
	r
X-Gm-Gg: ASbGnctXbAvdt0fR0rOkkIJ6SYuhlFDDMmUkgyo9YoNZzzlaKqkruM5At0cbSAR9xGm
	7LhPedSMlg8sygCctL3NDN/X6QR1XbPdjXf8ZTs22qknoyJqpVe2/hsCDgsTAcBDuTSRzgZsNhg
	BR8EpTz6LNO24dII/G9Ozf9cQ42+cDbdc2daNZqodHiltQQAHm1jnZZkjzXQ2Ajr5Wf1sAA+8DF
	cIaSjkgsLEHOzn5REegVw3vy17Sf8Ig/WwwdM7njFKdbpfo6tkpsKmM+tOfmshafHEZwEvVVyEX
	NEmViDD9Nj3mbhG04ZgtBGj8D9kmEeP8PwLlceOH0N+OgjIU994S5Fk5aQznv9HHhOI=
X-Google-Smtp-Source: AGHT+IFjiEUztRz8V3oCOde6BIyXl5wkkzn1hHXactvoL9rFKwLw3Mk1gblDyADMSodg0pZ9VMCCCg==
X-Received: by 2002:a05:620a:390f:b0:7c0:56ba:559 with SMTP id af79cd13be357-7c06fce2e60mr57518985a.47.1739301459558;
        Tue, 11 Feb 2025 11:17:39 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05e374867sm318561085a.111.2025.02.11.11.17.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:17:38 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 00/10] Update to Rust 1.81.0
Date: Tue, 11 Feb 2025 14:17:13 -0500
Message-ID: <cover.1739300779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 19:17:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1066

This patch series for the kirkstone/rust mixin layer backports the
various Rust toolchain changes in oe-core master to to pull in the
1.80.0 -> 1.80.1 updates that have landed in the last few months in
oe-core.  There are a couple of notable policy changes coming with
this set:

- Since librsvg 2.59.x is not buildable on kirksone due to its
  meson 1.2.0 requirement, I am for now freezing librsvg to the
  latest (and likely last) 2.58.x release, 2.58.5.  If that stops
  building with newer versions of Rust, this will be re-evaluated.
- I had included a backport of cargo-c since it is required for
  librsvg 2.59.x, and have decided to keep it even though that
  librsvg bump has been dropped.  The reasoning for this is to
  simplify future backporting, and to provide some consistency
  with the availabile version.

I intend to push this series to kirkstone/rust within 24 hours
unless a serious showstopper is pointed out.

Changes:

Adrian Freihofer (1):
  rust: increase test timeout again

Alexander Kanavin (3):
  cargo.bbclass: do not install libraries by default
  cargo-c-native: update 0.10.3 -> 0.10.5
  cargo-c: convert to target recipe

Deepesh Varatharajan (3):
  rust-target-config: Update the data layout for x86 , ppc , riscv64 ,
    aarch64 and loongaarch64 targets.
  rust: Fix for duplicate libstd.so
  rust: Upgrade 1.80.1->1.81.0

Enrico Scholz (1):
  rust-common: add LDFLAGS to 'build-rust-cc' wrapper

Scott Murray (2):
  Add cargo-c backport
  librsvg: upgrade to 2.58.5

 README.md                                     |   4 +
 classes/cargo.bbclass                         |   8 +-
 classes/cargo_c.bbclass                       |  41 ++
 classes/rust-common.bbclass                   |   2 +-
 classes/rust-target-config.bbclass            |  18 +-
 conf/layer.conf                               |   2 +-
 recipes-devtools/rust/cargo-c-crates.inc      | 682 ++++++++++++++++++
 .../rust/cargo-c_0.10.5+cargo-0.83.0.bb       |  17 +
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
 recipes-gnome/librsvg/librsvg-crates.inc      |  10 +-
 .../{librsvg_2.58.2.bb => librsvg_2.58.5.bb}  |   2 +-
 22 files changed, 866 insertions(+), 170 deletions(-)
 create mode 100644 classes/cargo_c.bbclass
 create mode 100644 recipes-devtools/rust/cargo-c-crates.inc
 create mode 100644 recipes-devtools/rust/cargo-c_0.10.5+cargo-0.83.0.bb
 rename recipes-devtools/rust/{cargo_1.80.1.bb => cargo_1.81.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-into-compilation.patch
 delete mode 100644 recipes-devtools/rust/files/hardcodepaths.patch
 rename recipes-devtools/rust/{libstd-rs_1.80.1.bb => libstd-rs_1.81.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.80.1.bb => rust-cross-canadian_1.81.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.80.1.bb => rust-llvm_1.81.0.bb} (100%)
 rename recipes-devtools/rust/{rust_1.80.1.bb => rust_1.81.0.bb} (99%)
 rename recipes-gnome/librsvg/{librsvg_2.58.2.bb => librsvg_2.58.5.bb} (96%)

-- 
2.48.1


