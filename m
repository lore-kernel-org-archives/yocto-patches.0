Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601BCC369A6
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:30:54 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web10.60115.1744061445481655168
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Y00IkjVt;
 spf=pass (domain: konsulko.com, ip: 209.85.166.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86135ac9542so62159439f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061444; x=1744666244; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0yc7XOJS6722zgi00Ckap/tFDV6QTSLUQaZkhrddGA=;
        b=Y00IkjVtQQDuUoNZSIEoRyGkJFgv8h5NYyA4qz5FtNsgiy+CN17+PmCrn5l/naizzH
         KCq3NC2DW6l+tHyFFZQsMNng24M+CuybpZXD5mK9fcMyUk+a07xLLz2m6mfJ+VJKTAOj
         Yyo1y4fyhMw+9LAfJJh5ByuvOgtFMH46nu4W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061444; x=1744666244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0yc7XOJS6722zgi00Ckap/tFDV6QTSLUQaZkhrddGA=;
        b=qlm1Av1KMMUrEqpDxvW6DN1Rp7VvMNvgkJriYpr2Mmsb0av+VPu3uxtTpvcdG757TS
         1cns2ZaJoTWns747zemflYb7fW5we9GBpWldpcMTiKf6AtpmOf8Cr/K2qdwAnqTRAp17
         R1i6BGGZtQ5hs1haKxuRZUV/6/Tnix+opOjeuHBLsV/1s1c+wP1VLfZta2jjApeZLkFv
         oECy7q4XryK/m4JpwS9iAuWOdaiWaituX90+Y+DBuGBj71sXnJxRmyNzdxgrcmgP7faL
         XMFbjl/arGyHFfRIbJMsz7S5EsOmaWdSI9DIjjR2i0IINjtL9xTYc1pbIHylulxtifKy
         AVIQ==
X-Gm-Message-State: AOJu0Yx2qKlAEPk4eyVO4sI753NFHG5SFpBnSAdESRbGzmXXozZLPtOb
	zFDlK6kDiGyiiONsvtNB9lpx4se/CwSO3UbDTWDk9d0VswQnD1mlbcEFd6ruQS9jg3xEbjhVZSl
	D2TM=
X-Gm-Gg: ASbGnctaXVTdl0WZnIm5CYLosJ+okBcUpEVBoKIwnZsxjPMAd6BNuuw8ZKw76yO4x3K
	UoeigJy94tf9RH5BuZMiZt9eAY3oFIWzDwLwU/VOXm241cjdbZxL4XrtLLQ3q3a9Ogd/6KM5eRu
	t1E9w/hec/doZC1qURW/6wvCA6jbHhwELmP+T8JgWimpFJSmGeooD+fnHkclxZ2rhWliL6Np6B/
	eI8X7e21l2R2S/qS90EkXiXGFB/5q2KR/7wwBmkarxFttqDFz0nXNxGx5BLmzsSyhOZDc0I3QmB
	M60KPtL1l5y/XVrhqRYPtckXHWfkYP4UNB/MtpESma7H/A/Ks54zx/0DxGN4ney/DTgsFIklUEa
	qxYb2jEI9cm8+dYF6PCW8
X-Google-Smtp-Source: AGHT+IGaYZrT5CGoD2yeBOyVcc3pmd1nVrgbNuDN0Rh+JDhwzV3+TDEcM+MnXvi6wQMk5chRbYDJRA==
X-Received: by 2002:a05:6602:a016:b0:85b:5c9a:a9ce with SMTP id ca18e2360f4ac-86152b25bb7mr127311939f.6.1744061444312;
        Mon, 07 Apr 2025 14:30:44 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:43 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 07/29] rust: restore parallel builds, disable lto only for rustdoc
Date: Mon,  7 Apr 2025 17:29:56 -0400
Message-ID: <446947d171450de68070201a5da3559f72d7aa31.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:30:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1307

From: Alexander Kanavin <alex@linutronix.de>

The original reproducibility fix was problematic for a couple reasons:

- disabling both lto and parallel builds had an unfortunate effect of nearly
doubling rust-native and rust build times (which are slow to begin with).
Disabling lto hurts runtime performance too.

- both of these things were done for the *entire build*, while the only
problematic item is the librustdoc crate.

- lto=off option in config.toml has an effect only on building rustc
(the compiler itself), and doesn't help with rustdoc reproducibility.
Actual fix is the codegen-units setting, which indirectly disables
lto via giving llvm only one unit to work with at a time.

After some digging, here's a more targeted fix for the problem.

Why librustdoc is non-reproducible, but not anything else
remains a mystery, hidden deep in rust-llvm's lto optimization code.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit a1977407a88a2004c3a6d2dba1d5bfe1aa1664b2)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...teps-tool.rs-switch-off-lto-for-rust.patch | 46 +++++++++++++++++++
 ...ue-fix-cargo-config-for-codegenunits.patch | 26 -----------
 recipes-devtools/rust/rust-source.inc         |  2 +-
 recipes-devtools/rust/rust_1.81.0.bb          |  1 -
 4 files changed, 47 insertions(+), 28 deletions(-)
 create mode 100644 recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
 delete mode 100644 recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch

diff --git a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
new file mode 100644
index 0000000..e63cfb0
--- /dev/null
+++ b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
@@ -0,0 +1,46 @@
+From ce68809d41291f671b440abce41f8f71c95428aa Mon Sep 17 00:00:00 2001
+From: Alexander Kanavin <alex@linutronix.de>
+Date: Mon, 3 Feb 2025 20:06:46 +0100
+Subject: [PATCH] src/core/build_steps/tool.rs: switch off lto for rustdoc
+
+For reasons currently unknown, librustdoc binary ends up with
+non-reproducible .llvm.<number> suffixes in its symbols - but
+not any other binary.
+
+Disabling lto avoids creating these suffixes. More info about the option:
+https://doc.rust-lang.org/rustc/codegen-options/index.html#lto
+
+As seen below, there's a comment in the source tree saying not to tweak the options
+but this only creates a mix of lto and non-lto optimized binary objects from
+various crates, which should be safe to mix.
+
+Upstream-Status: Inappropriate [reported at https://github.com/rust-lang/rust/issues/134589]
+Signed-off-by: Alexander Kanavin <alex@linutronix.de>
+---
+ src/bootstrap/src/core/build_steps/tool.rs | 3 ++-
+ 1 file changed, 2 insertions(+), 1 deletion(-)
+
+diff --git a/src/bootstrap/src/core/build_steps/tool.rs b/src/bootstrap/src/core/build_steps/tool.rs
+index 087df2f8a..00790affb 100644
+--- a/src/bootstrap/src/core/build_steps/tool.rs
++++ b/src/bootstrap/src/core/build_steps/tool.rs
+@@ -635,7 +635,7 @@ impl Step for Rustdoc {
+         }
+ 
+         // NOTE: Never modify the rustflags here, it breaks the build cache for other tools!
+-        let cargo = prepare_tool_cargo(
++        let mut cargo = prepare_tool_cargo(
+             builder,
+             build_compiler,
+             Mode::ToolRustc,
+@@ -645,6 +645,7 @@ impl Step for Rustdoc {
+             SourceType::InTree,
+             features.as_slice(),
+         );
++        cargo.rustflag("-Clto=off");
+ 
+         let _guard = builder.msg_tool(
+             Kind::Build,
+-- 
+2.39.5
+
diff --git a/recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch b/recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch
deleted file mode 100644
index 0aab877..0000000
--- a/recipes-devtools/rust/files/rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch
+++ /dev/null
@@ -1,26 +0,0 @@
-rust: rustdoc reproducibility issue fix
-
-rust: rustdoc reproducibility issue fix
-
-The 'codegen-units' option split the crate into multiple compilation units for parallel compilation. Currently, this split is causing the rustdoc to generate differnt binary between the builds.
-To fix this the codegen-units & the lto options are disabled.
-
-More info about options:
-https://doc.rust-lang.org/cargo/reference/profiles.html#codegen-units
-https://doc.rust-lang.org/rustc/codegen-options/index.html#lto
-
-Upstream-Status: Inappropriate [oe specific]
-
-Signed-off-by: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>
----
---- a/.cargo/config.toml
-+++ b/.cargo/config.toml
-@@ -3,3 +3,7 @@
-
- [source.vendored-sources]
- directory = "vendor"
-+
-+[profile.release]
-+codegen-units = 1
-+
-
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 8484c94..8335593 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -4,10 +4,10 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://zlib-off64_t.patch;patchdir=${RUSTSRC} \
             file://rv32-rustix-libc-backend.patch;patchdir=${RUSTSRC} \
             file://rv32-cargo-rustix-0.38.28-fix.patch;patchdir=${RUSTSRC} \
-            file://rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch;patchdir=${RUSTSRC} \
             file://rust-oe-selftest.patch;patchdir=${RUSTSRC} \
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=${RUSTSRC} \
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=${RUSTSRC} \
+            file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "36217ef7e32f40a180e3d79bd666b4dfdaed49dd381023a5fb765fd12d0092ce"
 
diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust/rust_1.81.0.bb
index 782c37f..8cb4558 100644
--- a/recipes-devtools/rust/rust_1.81.0.bb
+++ b/recipes-devtools/rust/rust_1.81.0.bb
@@ -136,7 +136,6 @@ python do_configure() {
     config.add_section("rust")
     config.set("rust", "rpath", e(True))
     config.set("rust", "remap-debuginfo", e(True))
-    config.set("rust", "lto", "\"off\"")
     config.set("rust", "channel", e(d.expand("${RUST_CHANNEL}")))
 
     # Whether or not to optimize the compiler and standard library
-- 
2.49.0


