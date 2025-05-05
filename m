Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A24CC3ABAA
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 18:35:49 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web10.57927.1746470144500182263
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 11:35:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FdpuiitP;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7cadc92771dso294346685a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746470143; x=1747074943; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bG2Jl4i3gl4AIK73NVXAo/it41OzkkO9gBPcirt/5/M=;
        b=FdpuiitPsaWqTRNcruKdeFXmVIQPZ6w/R1q9yGLxwz8njUB117BcgzfYXO2PJIok70
         pMlFAudPX6pZeLngY2ciOXcz7qDg+qczorW7nTg4oRbLL7yQ5AvqePWDYj0kKKfEuxqh
         lnTRXDGHihEti5sFCWtC3K3UK23Dd2Inhaqkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746470143; x=1747074943;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bG2Jl4i3gl4AIK73NVXAo/it41OzkkO9gBPcirt/5/M=;
        b=HxBPQyrLxGM0pceWTwqLIUCy+OOAJ1vveKxdh5K1SzlJ7g5rlB4lKQ11kewgciJeGK
         PvMspsfR1bspb1zEnhSsk9WwSCd80npVmAJVz1CfwMfu0sc7RAd5+MsdBoRX+s/O3GmD
         qzKAom9ih2LTuAD5du0b8a+dd7u7bGzbyjRaPvKmZSxLNrkv5FphY9YA6UOCGCmc53i6
         pclFaJAJTL9edm4uvwjO9BU4ZUvDrCpnxbQOFTqkAKoTBT4hGjNF35MOrN8GSi3SuHS7
         0pbQO3KT4QcehQz97TPbymi7dIUnK9IMUpnWys+yL9z1f36MD8lEfnCHnnkLMaaIOeft
         WCoA==
X-Gm-Message-State: AOJu0YxuyfJ1GA89GLHXfw0v52utanpcV9jT/5UoiHA7pK9BjTwjk+6R
	fQ7Mp5HZUwJQYhn5XmzruB+t3DmnX0WNtUUYU7f5LVbfIOMJ9km2f6ftC4tWFylVTfH3hixKQM3
	m
X-Gm-Gg: ASbGncuFXycYQVcAD9fsZsB0yvnn5jVRQNeHSX0rzJtRo6qQlCg7UZhqHv674A725yE
	ENfYSE536vd/hVOB6jYDfDJv+hfClIv1tLlNhn0XEQfoZcIO7LFiGFQkTWCFzNTLAv+yqeWPWDs
	yH5jaApcBUbcKh94euyymoHVR9BkP1KHSfUKHTcWdS9xvXxRan28C6sEsxnJxGxfXTUAYrWpPLj
	6D8y2i+ldBWV1fBmbBmlwD1k7gdjLBPOGTqyVOQsIWTWKZkfycs/d4T40uzNjI5qi+a/mJL2pxM
	0nZF+4SVi+/59IkrOVFmlNVzB0AHxS9Rz1Zlj7vxPkXHYK0Q8uTGQZDLCaGHag7/0SiGDlXq+ao
	=
X-Google-Smtp-Source: AGHT+IF88CTcDQI3rIQiSadWvBjflO4id2yQCVEZM2axIZUB0+DwTNPMlwxxqZ/5kbQXttPfAjTsiw==
X-Received: by 2002:a05:620a:6086:b0:7c7:5387:c754 with SMTP id af79cd13be357-7caf1119e0dmr2407785a.24.1746470142681;
        Mon, 05 May 2025 11:35:42 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad242b5c4sm602487585a.72.2025.05.05.11.35.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:35:41 -0700 (PDT)
Date: Mon, 5 May 2025 14:35:40 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 00/38]
 Update to Rust 1.85.1
In-Reply-To: <183B81D633F2878F.4763@lists.yoctoproject.org>
Message-ID: <04e8df0e-167f-1a58-86fd-145924e3e526@konsulko.com>
References: <183B81D633F2878F.4763@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 18:35:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1515

On Thu, 1 May 2025, Scott Murray via lists.yoctoproject.org wrote:

> After more of a delay than I would like, here is the patch series to
> backport the various Rust toolchain changes for the 1.81.0 -> 1.85.1
> updates that have landed in oe-core master branch in the last several
> months.
>
> The likely most impactful change for users is that in order to fix being
> able to build python3-cryptography with Rust >= 1.83, I have had to
> backport newer versions of python3-setuptools-rust, and more importantly,
> python3-setuptools.  Extracting the required fixes in setuptools-rust
> seems potentially possible, but untangling the change history in it got
> to the point where I lost confidence in not accidentally breaking some
> behavior relied upon by downstream users.  As such, using the tested
> version from scarthgap branch seems a better solution for now.
> That said, if you are a heavy Python module user, there may be some
> potential for breakage due to the unexpected setuptools upgrade.  I have
> not seen issues in my testing with oe-core recipes, but have not yet tried
> a world build of all of meta-python.
>
> I have also included a README.me update to document my requirements /
> guidelines for submissions of bbappends in dynamic layers.  They are
> for the most part what I posted a few weeks back.
>
> I intend to push this series to kirkstone/rust in about 48 hours
> unless a serious showstopper is pointed out.

Sorry for the delay, I have now pushed this to kirkstone/rust, along with
backporting these handful of newer commits to catch up:

83ce817 rust: Fix build with GCC-15 on aarch64/musl
aad06c9 ptest-cargo: fix incorrect FAIL count when multiple tests are run
98dd739 ptest-cargo: refactor run-ptest generation to remove redundancy
398374c ptest-cargo: handle packageconfig arguments

Hopefully this addresses the ptest-cargo issue that Peter Marko pointed
out.  Please let me know if you see any issues.

Scott

> Changes:
>
> Alexander Kanavin (1):
>   rust: restore parallel builds, disable lto only for rustdoc
>
> Deepesh Varatharajan (13):
>   rust: Upgrade 1.81.0->1.82.0
>   rust: oe-selftest issue fix with v1.82
>   rust: Oe-selftest changes for rust v1.82.0
>   rust: Upgrade 1.82.0->1.83.0
>   rust: Fix build break because of download-ci-llvm
>   rust: Oe-selftest changes for rust v1.83.0
>   rust: Fix bloat issue in recent rust updates
>   rust: Fix build break because of "download-rustc" and "llvm-tools"
>   rust: Upgrade 1.83.0->1.84.1
>   rust: Fix build failure when multilibs are enabled
>   rust: Oe-selftest changes for rust v1.84.1
>   rust: re-enable the unit tests that are ignored
>   rust: re-enable the unit tests that are ignored
>
> Enrico Scholz (1):
>   cargo_common: use 'config.toml' instead of plain 'config'
>
> Harish Sadineni (2):
>   rust: fix for rust multilib sdk configuration
>   rust: remove redundant cargo config file
>
> Igor Opaniuk (1):
>   rust/README-rust.md: fix markdown style issues
>
> Jean-Pierre Geslin (1):
>   cargo: pass PACKAGECONFIG_CONFARGS to cargo build
>
> Khem Raj (3):
>   rust-llvm: Fix build break found with clang
>   rust-llvm: Disable benchmarks by cmake options
>   cargo-c,rust: Fix build on risv32
>
> Martin Jansa (1):
>   cargo.bbclass: show PACKAGECONFIG_CONFARGS in bbnote
>
> Pedro Ferreira (1):
>   rust-common.bbclass: soft assignment for RUSTLIB path
>
> Peter Kjellerstedt (1):
>   libstd-rs: Correct the license to use Unicode-3.0
>
> Richard Purdie (5):
>   meta/meta-selftest: Fix variable assignment whitespace
>   recipes: Drop ld-is-gold support
>   rust-source: Fix remove_gcc_directory
>   rust-llvm: Compile llvm to use dynamic libraries
>   rust-llvm: Disable libedit
>
> Scott Murray (3):
>   Add selftest backport to ease maintenance
>   Backport newer Python setuptools-rust and setuptools
>   Update README.md wrt dynamic layer submissions
>
> Sean Nyekjaer (1):
>   rust-cross-canadian: set CC_<triple> for nativesdk
>
> Yash Shinde (3):
>   rust: Update "do_update_snapshot" task for rust-snapshot.inc
>   rust: Upgrade 1.84.1->1.85.0
>   rust: Upgrade 1.85.0->1.85.1
>
> Yoann Congal (1):
>   cargo-c: Update patch Upstream-Status
>
>  README.md                                     |  49 ++-
>  classes/cargo.bbclass                         |   6 +-
>  classes/cargo_common.bbclass                  |  20 +-
>  classes/rust-common.bbclass                   |   2 +-
>  classes/rust-target-config.bbclass            |   5 +
>  classes/rust.bbclass                          |   8 +-
>  conf/layer.conf                               |   8 +-
>  files/common-licenses/Unicode-3.0             |  39 +++
>  lib/oeqa/selftest/cases/rust_mixin.py         | 134 ++++++++
>  meta/lib/oeqa/selftest/cases/rust.py          |  85 -----
>  .../packagegroup-rust-cross-canadian.bb       |   2 +-
>  .../python/python3-setuptools-rust_1.9.0.bb   |  35 ++
>  .../python3-setuptools-scm_6.4.2.bbappend     |   2 +
>  ...nfig.py-make-it-possible-to-substite.patch |  58 ++++
>  ...ly-do-not-fetch-code-by-easy_install.patch |  31 ++
>  .../python3-setuptools/CVE-2024-6345.patch    | 312 ++++++++++++++++++
>  .../python/python3-setuptools_69.1.1.bb       |  58 ++++
>  recipes-devtools/rust/README-rust.md          |  24 +-
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch |  38 +++
>  .../rust/cargo-c_0.10.5+cargo-0.83.0.bb       |   1 +
>  .../rust/{cargo_1.81.0.bb => cargo_1.85.1.bb} |  13 +
>  ...l-codes-on-riscv32gc-unknown-linux-g.patch | 112 +++++++
>  ...teps-tool.rs-switch-off-lto-for-rust.patch |  46 +++
>  .../Zdual-proc-macros-additional-check.patch  |  31 ++
>  ...epro-issue-fix-with-cc-crate-hashmap.patch |  90 ++++-
>  ...d-statically-in-rustc_driver-feature.patch | 228 +++++++++++++
>  .../rust/files/rust-oe-selftest.patch         | 279 +++++-----------
>  ...ue-fix-cargo-config-for-codegenunits.patch |  26 --
>  .../files/rv32-cargo-rustix-0.38.28-fix.patch |  70 ----
>  .../rust/files/rv32-rustix-libc-backend.patch |  33 --
>  .../rust/files/zlib-off64_t.patch             |  31 --
>  ...ibstd-rs_1.81.0.bb => libstd-rs_1.85.1.bb} |  11 +-
>  recipes-devtools/rust/rust-cross-canadian.inc |  24 +-
>  ....81.0.bb => rust-cross-canadian_1.85.1.bb} |   0
>  .../0003-llvm-fix-include-benchmarks.patch    |  25 --
>  ...ust-llvm_1.81.0.bb => rust-llvm_1.85.1.bb} |   8 +-
>  recipes-devtools/rust/rust-snapshot.inc       |  81 ++---
>  recipes-devtools/rust/rust-source.inc         |  10 +-
>  .../rust/{rust_1.81.0.bb => rust_1.85.1.bb}   |  76 +++--
>  39 files changed, 1492 insertions(+), 619 deletions(-)
>  create mode 100644 files/common-licenses/Unicode-3.0
>  create mode 100644 lib/oeqa/selftest/cases/rust_mixin.py
>  delete mode 100644 meta/lib/oeqa/selftest/cases/rust.py
>  create mode 100644 recipes-devtools/python/python3-setuptools-rust_1.9.0.bb
>  create mode 100644 recipes-devtools/python/python3-setuptools-scm_6.4.2.bbappend
>  create mode 100644 recipes-devtools/python/python3-setuptools/0001-_distutils-sysconfig.py-make-it-possible-to-substite.patch
>  create mode 100644 recipes-devtools/python/python3-setuptools/0001-conditionally-do-not-fetch-code-by-easy_install.patch
>  create mode 100644 recipes-devtools/python/python3-setuptools/CVE-2024-6345.patch
>  create mode 100644 recipes-devtools/python/python3-setuptools_69.1.1.bb
>  create mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
>  rename recipes-devtools/rust/{cargo_1.81.0.bb => cargo_1.85.1.bb} (87%)
>  create mode 100644 recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
>  create mode 100644 recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
>  create mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
>  create mode 100644 recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
>  delete mode 100644 recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch
>  delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.28-fix.patch
>  delete mode 100644 recipes-devtools/rust/files/rv32-rustix-libc-backend.patch
>  delete mode 100644 recipes-devtools/rust/files/zlib-off64_t.patch
>  rename recipes-devtools/rust/{libstd-rs_1.81.0.bb => libstd-rs_1.85.1.bb} (76%)
>  rename recipes-devtools/rust/{rust-cross-canadian_1.81.0.bb => rust-cross-canadian_1.85.1.bb} (100%)
>  delete mode 100644 recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch
>  rename recipes-devtools/rust/{rust-llvm_1.81.0.bb => rust-llvm_1.85.1.bb} (94%)
>  rename recipes-devtools/rust/{rust_1.81.0.bb => rust_1.85.1.bb} (81%)
>
>

