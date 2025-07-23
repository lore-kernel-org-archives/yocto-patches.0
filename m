Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D637CC87FCE
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:48 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.web10.22559.1753296044911751169
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AiZhD7VE;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e278d8345aso26416585a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296044; x=1753900844; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgI+ucSd6gQcZP3Nk7iGd0ETmkWE0QXMT5PjZfe4SDk=;
        b=AiZhD7VEMIO9GBzBMIw1k3iMQ+y7yiBCPABAo58rfQ4aFzqpIJWSEWxtNlj65Duw7m
         ihaYZ5UZRDc3wdnOuLdzQwu7fqai0i8wYSyy8rKYxHsrblc350N3Cvtw/5ASKhx3BpTL
         2rgUvjfmBYIoIxEsJfmaK1w1t8j601hQuPxO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296044; x=1753900844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgI+ucSd6gQcZP3Nk7iGd0ETmkWE0QXMT5PjZfe4SDk=;
        b=kzD8DfdpDfKqtT93OkwMgIuaFAuGeyVHXR7H/70KDGzMlynfDW4dlISBLPsW4G07Hp
         CY53X6ISe5jJYIpuGMJJ7Fwjm4JgmlZtI79QVyibKPaefTGUTWLr3Gh9CHKGiTvVIT3E
         CYk80kvfMgRrKIUonNINsoRlWNlfMTYjvZveWRTKhoc7MQ/mwjPUiesLldy0HCJsg04B
         N3WmwOPySL+34J2fGxPbNKEeUrDUKoM1HKa/ovMHj8TKjfiKC8v2HcY/v0O9F9bEhMjA
         xccrUCj71ma2ycmTS9VUcpSeWG2iU9+jzzS7hBXfEqBcKE4GuTGbVaFvWeok2+9rmkvj
         8jIg==
X-Gm-Message-State: AOJu0Yx7OlRiyUaX+y159SGev9NBE1MwNc7FA3JASwyCIhFs+AzH13e9
	lA9dok4xw01b0eDfwx8xKn6XlXECRWNuUzaAkEaF2SzwU1bIlLGwB/mperIuU+Az3gtaZ1tkJ0g
	e8apT
X-Gm-Gg: ASbGncv2pIx2acocrsGRKCOMEBERsA8h1AGyQS+7VYGTg38STPRuYukj1nL0VNnBlhC
	Jb1lMhG0sDNDC+LOahWLxCkQdHMLwlzAFvtMOsLmzVgQBNxGBTwLd8oGW7I/HGpN1ahCCm+f8nR
	WklP47iU9V6ydi55VgqtWPzHB9DHLVAbN6sv1Y99LJkSLZ1yzapR6sNRSO54qw+58QuVCIIxyWN
	ZW7waZg/2UmwBMs2zgVNHQhvgi1LHhk0aZgx5Ll5CfRGyRZaH9NCzO/7QXJG6MZS4nhynnsRqGj
	P3ybc0vSdJzFDYzIP4gtgl9IZnt5BgK/iZxR/JcJxxhlb7BA7aYzZMmjhZgxINvMtfTGzXTZ1r0
	ybY0XRI2fqOiwD5bJe2HxiEQkVLFgJ4FBu8Ns7wjdCkveCU8lSbxv+qAfMhMSAF9MBZgj63E+YA
	==
X-Google-Smtp-Source: AGHT+IEmu5uWrOd28juN320yKpvEbz1WmMcmIoyCx05///0HDw8L6q8GLC8gx3Z/kzBGx3XB1/Z3lA==
X-Received: by 2002:a05:620a:258d:b0:7e6:234e:8e8b with SMTP id af79cd13be357-7e62a17cbd0mr358182185a.39.1753296043079;
        Wed, 23 Jul 2025 11:40:43 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:42 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 11/13] rust: Upgrade 1.86.0 -> 1.87.0
Date: Wed, 23 Jul 2025 14:40:11 -0400
Message-ID: <818e8523d88d6d6a9dbc38398065a79659023366.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753295655.git.scott.murray@konsulko.com>
References: <cover.1753295655.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1838

From: Yash Shinde <Yash.Shinde@windriver.com>

Rust stable version updated to 1.87.0.
https://blog.rust-lang.org/2025/05/15/Rust-1.87.0/

* Update LLVM data-layout for arm64.
  LLVM requires matching data layouts and
  the aarch64 llvm data-layout was updated to to allow using
  32-bit signed/unsigned pointers when building 64-bit targets
  using 270, 271 and 272 address spaces.

  https://github.com/rust-lang/rust/commit/e9853961452b56997cc127b51308879b9cd09482
  https://github.com/llvm/llvm-project/commit/c9f27275c1330a325661bdf14fb3bc444a5e3648

* Rebase existing patches with v1.87.0.

* Two tests from the `ui` and `codegen` modules now fail only on riscv64.
  Enable them on arm32/64 and x86-32/64 targets, while restricting
  them on riscv64 via `only-<target_arch>` tags.

  Test Results Summary:

  +-----------+--------+---------+
  | Machine   | Passed | Ignored |
  +-----------+--------+---------+
  | arm-32    | 28,320 | 901     |
  | arm-64    | 28,400 | 849     |
  | x86-32    | 28,285 | 885     |
  | x86-64    | 28,518 | 676     |
  | riscv-64  | 27,845 | 868     |
  +-----------+--------+---------+

* Backport triagebot.patch to skip tidy linkcheck when triagebot.toml
  is not present. Distribution tarballs won't include triagebot.toml,
  which causes tidy checks to fail.
  This backport ensures tidy checks can still run successfully
  even when the file is missing.

  https://github.com/rust-lang/rust/pull/142666/commits

* During rust installation, some binaries were installed from
  'stage2-tools' built path to '${D}${bindir}'. However, from
  v1.87 the stage2-tools are no longer built by default.
  Update logic to install from `stage1-tools` instead.

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 16ce25e6970b4a50f6433606a0c87d22ec74ea5a)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass     |   2 +-
 conf/layer.conf                               |   2 +-
 .../rust/{cargo_1.86.0.bb => cargo_1.87.0.bb} |   0
 ...teps-tool.rs-switch-off-lto-for-rust.patch |  30 ++--
 ...crease-timeout-in-process-sigpipe-ru.patch |   4 +-
 ...d-statically-in-rustc_driver-feature.patch |  11 +-
 .../rust/files/rust-oe-selftest.patch         | 147 ++++++++++--------
 recipes-devtools/rust/files/triagebot.patch   |  32 ++++
 ...ibstd-rs_1.86.0.bb => libstd-rs_1.87.0.bb} |   0
 ....86.0.bb => rust-cross-canadian_1.87.0.bb} |   0
 ...ust-llvm_1.86.0.bb => rust-llvm_1.87.0.bb} |   4 +-
 recipes-devtools/rust/rust-snapshot.inc       |  78 +++++-----
 recipes-devtools/rust/rust-source.inc         |   3 +-
 .../rust/{rust_1.86.0.bb => rust_1.87.0.bb}   |   4 +-
 14 files changed, 186 insertions(+), 131 deletions(-)
 rename recipes-devtools/rust/{cargo_1.86.0.bb => cargo_1.87.0.bb} (100%)
 create mode 100644 recipes-devtools/rust/files/triagebot.patch
 rename recipes-devtools/rust/{libstd-rs_1.86.0.bb => libstd-rs_1.87.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.86.0.bb => rust-cross-canadian_1.87.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.86.0.bb => rust-llvm_1.87.0.bb} (96%)
 rename recipes-devtools/rust/{rust_1.86.0.bb => rust_1.87.0.bb} (99%)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index c04940c..d4149b3 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -146,7 +146,7 @@ MAX_ATOMIC_WIDTH[armv7-eabi] = "64"
 FEATURES[armv7-eabi] = "+v7,+vfp2,+thumb2"
 
 ## aarch64-unknown-linux-{gnu, musl}
-DATA_LAYOUT[aarch64] = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128-Fn32"
+DATA_LAYOUT[aarch64] = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128-Fn32"
 TARGET_ENDIAN[aarch64] = "little"
 TARGET_POINTER_WIDTH[aarch64] = "64"
 TARGET_C_INT_WIDTH[aarch64] = "32"
diff --git a/conf/layer.conf b/conf/layer.conf
index 00df38e..af35c05 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERDEPENDS_scarthgap-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.86.0%"
+RUSTVERSION ?= "1.87.0%"
diff --git a/recipes-devtools/rust/cargo_1.86.0.bb b/recipes-devtools/rust/cargo_1.87.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.86.0.bb
rename to recipes-devtools/rust/cargo_1.87.0.bb
diff --git a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
index 5e0f591..a7da69d 100644
--- a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
+++ b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
@@ -24,9 +24,9 @@ diff --git a/src/bootstrap/src/core/build_steps/tool.rs b/src/bootstrap/src/core
 index 087df2f8a..00790affb 100644
 --- a/src/bootstrap/src/core/build_steps/tool.rs
 +++ b/src/bootstrap/src/core/build_steps/tool.rs
-@@ -1,14 +1,11 @@
- use std::path::PathBuf;
- use std::{env, fs};
+@@ -15,14 +15,12 @@
+ #[cfg(feature = "tracing")]
+ use tracing::instrument;
  
 -use crate::core::build_steps::compile::is_lto_stage;
  use crate::core::build_steps::toolstate::ToolState;
@@ -36,18 +36,20 @@ index 087df2f8a..00790affb 100644
 -    Builder, Cargo as CargoCommand, RunConfig, ShouldRun, Step, cargo_profile_var,
 -};
 -use crate::core::config::{DebuginfoLevel, RustcLto, TargetSelection};
++
 +use crate::core::builder::{Builder, Cargo as CargoCommand, RunConfig, ShouldRun, Step};
 +use crate::core::config::{DebuginfoLevel, TargetSelection};
  use crate::utils::channel::GitInfo;
  use crate::utils::exec::{BootstrapCommand, command};
  use crate::utils::helpers::{add_dylib_path, exe, t};
-@@ -658,19 +655,7 @@
-             SourceType::InTree,
-             features.as_slice(),
+@@ -148,20 +146,7 @@
+             &self.extra_features,
          );
--
--        // rustdoc is performance sensitive, so apply LTO to it.
--        if is_lto_stage(&build_compiler) {
+ 
+-        if path.ends_with("/rustdoc") &&
+-            // rustdoc is performance sensitive, so apply LTO to it.
+-            is_lto_stage(&self.compiler)
+-        {
 -            let lto = match builder.config.rust_lto {
 -                RustcLto::Off => Some("off"),
 -                RustcLto::Thin => Some("thin"),
@@ -60,14 +62,14 @@ index 087df2f8a..00790affb 100644
 -        }
 +        cargo.rustflag("-Clto=off");
  
-         let _guard = builder.msg_tool(
-             Kind::Build,
+         if !self.allow_features.is_empty() {
+             cargo.allow_features(self.allow_features);
 diff --git a/src/bootstrap/src/core/builder/mod.rs b/src/bootstrap/src/core/builder/mod.rs
 --- a/src/bootstrap/src/core/builder/mod.rs
 +++ b/src/bootstrap/src/core/builder/mod.rs
-@@ -11,7 +11,7 @@
- 
- use clap::ValueEnum;
+@@ -13,7 +13,7 @@
+ #[cfg(feature = "tracing")]
+ use tracing::instrument;
  
 -pub use self::cargo::{Cargo, cargo_profile_var};
 +pub use self::cargo::Cargo;
diff --git a/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch b/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
index bb27ca3..5bd1abf 100644
--- a/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
+++ b/recipes-devtools/rust/files/oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
@@ -22,10 +22,10 @@ index 11f363d62..c12d66016 100644
 +++ b/tests/ui/process/process-sigpipe.rs
 @@ -23,7 +23,7 @@ use std::thread;
  fn main() {
-     // Just in case `yes` doesn't check for EPIPE...
+     // Just in case `yes` or `while-echo` doesn't check for EPIPE...
      thread::spawn(|| {
 -        thread::sleep_ms(5000);
 +        thread::sleep_ms(50000);
          process::exit(1);
      });
-     let output = process::Command::new("sh")
+     // QNX Neutrino does not have `yes`. Therefore, use `while-echo` for `nto`
diff --git a/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch b/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
index 20a49d4..9bbbce0 100644
--- a/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
+++ b/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
@@ -200,11 +200,10 @@ diff --git a/src/bootstrap/src/core/build_steps/compile.rs b/src/bootstrap/src/c
 index 27bbc8bd8f..a6fc4df2eb 100644
 --- a/src/bootstrap/src/core/build_steps/compile.rs
 +++ b/src/bootstrap/src/core/build_steps/compile.rs
-@@ -1940,24 +1940,8 @@ impl Step for Assemble {
-         let src_libdir = builder.sysroot_target_libdir(build_compiler, host);
+@@ -2158,23 +2158,7 @@
          for f in builder.read_dir(&src_libdir) {
              let filename = f.file_name().into_string().unwrap();
--
+ 
 -            let is_proc_macro = proc_macros.contains(&filename);
 -            let is_dylib_or_debug = is_dylib(&f.path()) || is_debug_info(&filename);
 -
@@ -214,8 +213,7 @@ index 27bbc8bd8f..a6fc4df2eb 100644
 -            let can_be_rustc_dynamic_dep = if builder
 -                .link_std_into_rustc_driver(target_compiler.host)
 -                && !target_compiler.host.is_windows()
-+            if (is_dylib(Path::new(&filename)) || is_debug_info(&filename)) && !proc_macros.contains(&filename)
-             {
+-            {
 -                let is_std = filename.starts_with("std-") || filename.starts_with("libstd-");
 -                !is_std
 -            } else {
@@ -223,6 +221,7 @@ index 27bbc8bd8f..a6fc4df2eb 100644
 -            };
 -
 -            if is_dylib_or_debug && can_be_rustc_dynamic_dep && !is_proc_macro {
-                 builder.copy_link(&f.path(), &rustc_libdir.join(&filename));
++            if (is_dylib(Path::new(&filename)) || is_debug_info(&filename)) && !proc_macros.contains(&filename) {
+                 builder.copy_link(&f.path(), &rustc_libdir.join(&filename), FileType::Regular);
              }
          }
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index 49d8507..b7ef806 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -47,61 +47,85 @@ diff --git a/library/std/tests/sync/rwlock.rs b/library/std/tests/sync/rwlock.rs
 index 1a9d3d3f12f..0a9cfc48806 100644
 --- a/library/std/tests/sync/rwlock.rs
 +++ b/library/std/tests/sync/rwlock.rs
-@@ -47,6 +47,7 @@ fn frob() {
- }
-
+@@ -74,6 +74,7 @@
+ 
  #[test]
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
 +#[ignore]
  fn test_rw_arc_poison_wr() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -72,6 +73,7 @@ fn test_rw_arc_poison_mapped_w_r() {
- }
-
+@@ -87,6 +88,7 @@
+ 
+ #[test]
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
++#[ignore]
+ fn test_rw_arc_poison_mapped_w_r() {
+     let arc = Arc::new(RwLock::new(1));
+     let arc2 = arc.clone();
+@@ -101,6 +103,7 @@
+ 
  #[test]
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
 +#[ignore]
  fn test_rw_arc_poison_ww() {
      let arc = Arc::new(RwLock::new(1));
      assert!(!arc.is_poisoned());
-@@ -100,6 +102,7 @@ fn test_rw_arc_poison_mapped_w_w() {
+@@ -115,6 +118,7 @@
  }
-
+ 
+ #[test]
++#[ignore]
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
+ fn test_rw_arc_poison_mapped_w_w() {
+     let arc = Arc::new(RwLock::new(1));
+@@ -131,6 +135,7 @@
+ 
  #[test]
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
 +#[ignore]
  fn test_rw_arc_no_poison_rr() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -127,6 +130,7 @@ fn test_rw_arc_no_poison_mapped_r_r() {
- }
-
+@@ -160,6 +165,7 @@
+ 
  #[test]
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
 +#[ignore]
  fn test_rw_arc_no_poison_rw() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -192,6 +196,7 @@ fn test_rw_arc() {
- }
-
+@@ -227,6 +233,7 @@
+ 
  #[test]
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
 +#[ignore]
  fn test_rw_arc_access_in_unwind() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -275,6 +280,7 @@ fn drop(&mut self) {
- }
-
+@@ -326,6 +333,7 @@
+ 
  #[test]
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
 +#[ignore]
  fn test_into_inner_poison() {
      let m = new_poisoned_rwlock(NonCopy(10));
-
-@@ -299,6 +305,7 @@ fn test_get_mut() {
- }
-
+ 
+@@ -362,6 +370,7 @@
+ 
  #[test]
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
 +#[ignore]
  fn test_get_mut_poison() {
      let mut m = new_poisoned_rwlock(NonCopy(10));
+ 
+@@ -567,6 +576,7 @@
+ 
+ #[test]
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
++#[ignore]
+ fn panic_while_mapping_write_unlocked_poison() {
+     let lock = RwLock::new(());
 
 diff --git a/library/test/src/tests.rs b/library/test/src/tests.rs
 --- a/library/test/src/tests.rs
@@ -117,52 +141,22 @@ diff --git a/library/test/src/tests.rs b/library/test/src/tests.rs
 diff --git a/library/std/tests/sync/mutex.rs b/library/std/tests/sync/mutex.rs
 --- a/library/std/tests/sync/mutex.rs
 +++ b/library/std/tests/sync/mutex.rs
-@@ -193,6 +193,7 @@
- }
-
+@@ -312,6 +312,7 @@
+ 
  #[test]
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
 +#[ignore]
  fn test_mutex_arc_poison_mapped() {
      let arc = Arc::new(Mutex::new(1));
      assert!(!arc.is_poisoned());
-diff --git a/library/std/tests/sync/mutex.rs b/library/std/tests/sync/mutex.rs
---- a/library/std/tests/sync/mutex.rs
-+++ b/library/std/tests/sync/mutex.rs
-@@ -272,6 +272,7 @@
- }
-
+@@ -391,6 +392,7 @@
+ 
  #[test]
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
 +#[ignore]
  fn panic_while_mapping_unlocked_poison() {
      let lock = Mutex::new(());
 
-diff --git a/library/std/src/sync/rwlock/tests.rs b/library/std/tests/sync/rwlock.rs
---- a/library/std/tests/sync/rwlock.rs
-+++ b/library/std/tests/sync/rwlock.rs
-@@ -59,6 +59,7 @@ fn test_rw_arc_poison_wr() {
- }
-
- #[test]
-+#[ignore]
- fn test_rw_arc_poison_mapped_w_r() {
-     let arc = Arc::new(RwLock::new(1));
-     let arc2 = arc.clone();
-@@ -86,6 +87,7 @@ fn test_rw_arc_poison_ww() {
- }
-
- #[test]
-+#[ignore]
- fn test_rw_arc_poison_mapped_w_w() {
-     let arc = Arc::new(RwLock::new(1));
-     let arc2 = arc.clone();
-@@ -431,6 +433,7 @@ fn panic_while_mapping_read_unlocked_no_poison() {
- }
-
- #[test]
-+#[ignore]
- fn panic_while_mapping_write_unlocked_poison() {
-     let lock = RwLock::new(());
-
 diff --git a/library/coretests/benches/num/int_log/mod.rs b/library/coretests/benches/num/int_log/mod.rs
 index 3807cd5d76c..018c5c04456 100644
 --- a/library/coretests/benches/num/int_log/mod.rs
@@ -199,10 +193,10 @@ index 9d4f52a092..d425e5f7b7 100644
  fn thread_current_in_dtor() {
      // Go through one round of TLS destruction first.
      struct Defer;
-diff --git a/library/alloc/tests/sort/tests.rs b/library/alloc/tests/sort/tests.rs
+diff --git a/library/alloctests/tests/sort/tests.rs b/library/alloctests/tests/sort/tests.rs
 index 14e6013f96..b670f27ab4 100644
---- a/library/alloc/tests/sort/tests.rs
-+++ b/library/alloc/tests/sort/tests.rs
+--- a/library/alloctests/tests/sort/tests.rs
++++ b/library/alloctests/tests/sort/tests.rs
 @@ -915,12 +915,14 @@ gen_sort_test_fns_with_default_patterns_3_ty!(
  macro_rules! instantiate_sort_test_inner {
      ($sort_impl:ty, miri_yes, $test_fn_name:ident) => {
@@ -234,10 +228,10 @@ diff --git a/tests/assembly/dwarf-mixed-versions-lto.rs b/tests/assembly/dwarf-m
 index 5b8e5ff4f4a..e558fbd7bd7 100644
 --- a/tests/assembly/dwarf-mixed-versions-lto.rs
 +++ b/tests/assembly/dwarf-mixed-versions-lto.rs
-@@ -1,6 +1,11 @@
- // This test ensures that if LTO occurs between crates with different DWARF versions, we
+@@ -2,6 +2,11 @@
  // will choose the highest DWARF version for the final binary. This matches Clang's behavior.
-
+ // Note: `.2byte` directive is used on MIPS.
+ 
 +//@ only-x86
 +//@ only-x86_64
 +//@ only-arm
@@ -259,3 +253,30 @@ index 0e712bc3a4e..93965d990d0 100644
  //@ revisions: OPT2 OPT3
  //@[OPT2] compile-flags: -Copt-level=2
  //@[OPT3] compile-flags: -C opt-level=3
+diff --git a/tests/codegen/uninhabited-transparent-return-abi.rs b/tests/codegen/uninhabited-transparent-return-abi.rs
+index face1577c3f..d69e5e34a7b 100644
+--- a/tests/codegen/uninhabited-transparent-return-abi.rs
++++ b/tests/codegen/uninhabited-transparent-return-abi.rs
+@@ -1,4 +1,8 @@
+ //@ compile-flags: -Copt-level=3
++//@ only-x86
++//@ only-x86_64
++//@ only-arm
++//@ only-aarch64
+ 
+ // See https://github.com/rust-lang/rust/issues/135802
+
+diff --git a/tests/ui/abi/rust-cold-works-with-rustic-args.rs b/tests/ui/abi/rust-cold-works-with-rustic-args.rs
+index 57027364699..3faa7ea035e 100644
+--- a/tests/ui/abi/rust-cold-works-with-rustic-args.rs
++++ b/tests/ui/abi/rust-cold-works-with-rustic-args.rs
+@@ -1,5 +1,9 @@
+ //@build-pass
+ //@compile-flags: -Clink-dead-code=true --crate-type lib
++//@ only-x86
++//@ only-x86_64
++//@ only-arm
++//@ only-aarch64
+ // We used to not handle all "rustic" ABIs in a (relatively) uniform way,
+ // so we failed to fix up arguments for actually passing through the ABI...
+ #![feature(rust_cold_cc)]
diff --git a/recipes-devtools/rust/files/triagebot.patch b/recipes-devtools/rust/files/triagebot.patch
new file mode 100644
index 0000000..715664d
--- /dev/null
+++ b/recipes-devtools/rust/files/triagebot.patch
@@ -0,0 +1,32 @@
+Skip tidy triagebot linkcheck if triagebot.toml doesn't exist
+
+Distribution tarballs won't include triagebot.toml, which
+causes tidy checks to fail with the following error:
+
+   tidy error: triagebot.toml file not found
+   some tidy checks failed
+
+Drop the triagebot.toml check which is mostly to catch broken
+path filters *within* `triagebot.toml` and not enforce
+the existence of it.
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/pull/142666/commits]
+
+Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
+---
+diff --git a/src/tools/tidy/src/triagebot.rs b/src/tools/tidy/src/triagebot.rs
+--- a/src/tools/tidy/src/triagebot.rs
++++ b/src/tools/tidy/src/triagebot.rs
+@@ -6,8 +6,11 @@
+ 
+ pub fn check(path: &Path, bad: &mut bool) {
+     let triagebot_path = path.join("triagebot.toml");
++
++    // This check is mostly to catch broken path filters *within* `triagebot.toml`, and not enforce
++    // the existence of `triagebot.toml` itself (which is more obvious), as distribution tarballs
++    // will not include non-essential bits like `triagebot.toml`.
+     if !triagebot_path.exists() {
+-        tidy_error!(bad, "triagebot.toml file not found");
+         return;
+     }
+
diff --git a/recipes-devtools/rust/libstd-rs_1.86.0.bb b/recipes-devtools/rust/libstd-rs_1.87.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.86.0.bb
rename to recipes-devtools/rust/libstd-rs_1.87.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.86.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.87.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.86.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.87.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.86.0.bb b/recipes-devtools/rust/rust-llvm_1.87.0.bb
similarity index 96%
rename from recipes-devtools/rust/rust-llvm_1.86.0.bb
rename to recipes-devtools/rust/rust-llvm_1.87.0.bb
index 327e8e6..d70aa35 100644
--- a/recipes-devtools/rust/rust-llvm_1.86.0.bb
+++ b/recipes-devtools/rust/rust-llvm_1.87.0.bb
@@ -2,9 +2,9 @@ SUMMARY = "LLVM compiler framework (packaged with rust)"
 LICENSE ?= "Apache-2.0-with-LLVM-exception"
 HOMEPAGE = "http://www.rust-lang.org"
 
-# check src/llvm-project/cmake/Modules/LLVMVersion.cmake for llvm version in use
+# check src/llvm-project/llvm/CMakeLists.txt for llvm version in use
 #
-LLVM_RELEASE = "19.1.7"
+LLVM_RELEASE = "20.1.1"
 
 require rust-source.inc
 
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rust/rust-snapshot.inc
index 445390f..87b39a2 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,56 +4,56 @@
 ## The exact (previous) version that has been used is specified in the source tarball.
 ## The version is replicated here.
 
-SNAPSHOT_VERSION = "1.85.0"
+SNAPSHOT_VERSION = "1.86.0"
 
-SRC_URI[rustc-snapshot-aarch64.sha256sum] = "e742b768f67303010b002b515f6613c639e69ffcc78cd0857d6fe7989e9880f6"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] = "8af1d793f7820e9ad0ee23247a9123542c3ea23f8857a018651c7788af9bc5b7"
-SRC_URI[cargo-snapshot-aarch64.sha256sum] = "cdebe48b066d512d664c13441e8fae2d0f67106c2080aa44289d98b24192b8bc"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] = "f3b8e769021a6bcee8174ac49a60c367effb6d97af0f2a6c44dc9ea39ff2bda9"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] = "ccece9e59546d2e6ff3fc3b8f4b033aab21631c271eefbe814b3cbace6628c6e"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] = "176129577a5d560bbd94bcd2d24c0228bb495b73219df02556b4e4b4f0815bf7"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] = "37156542b702e8b4ffd1c5c75017632582343e93ca378285cdc92196c85c77e3"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] = "e70edcf560e6b50861618d7045d2b38cae9e2a555f489062570e2e7041563f42"
 
-SRC_URI[rustc-snapshot-i686.sha256sum] = "c5a5751f3cfa027b53fee83d01dec8e555f3622b6993335aed12b1747aa9543c"
-SRC_URI[rust-std-snapshot-i686.sha256sum] = "401571adfe1223d83ed041e5a8c54c1f3afb3010d1d5b0c1fd79e7da1ab0a0de"
-SRC_URI[cargo-snapshot-i686.sha256sum] = "3832027242911ab96fd86128587fc563596a5b10e8e38a073facf61c1ac9668f"
-SRC_URI[clippy-snapshot-i686.sha256sum] = "74ed13a67c6ea0452c0d9e8697c6cfdd8280f983b207187ac93c287f72b65066"
+SRC_URI[rustc-snapshot-i686.sha256sum] = "976f4604d949d722738a9fe95313035226571128396e942b0fc678180be487b0"
+SRC_URI[rust-std-snapshot-i686.sha256sum] = "ce9f0fa4b0760730e26bf315cebe099f0b883436e095c5fc4b94ba20bd9f121a"
+SRC_URI[cargo-snapshot-i686.sha256sum] = "24f20bdc1bb14f4ffbdc2f540488bebc3340437418725c3162215ae03cdad480"
+SRC_URI[clippy-snapshot-i686.sha256sum] = "6788449fa0eceebe4ea8c797bbaf27495dad152087b3085d58dc05cacab0617a"
 
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] = "d43d2119ff25d879b2d280d3e5a03fcd21c57a32d479ad5626500c32432f18c9"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] = "2d05f5e13e7cb3ee6b0ca0dcd13a231a28eeb0faa4d15257a35cf7284149cd6a"
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] = "9aa447eefcd3ba2f9dbab77596c8669849899ab243543fc8f1914089707081ac"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] = "d437b39465343a71ff475a65acb6c03bc0f800861f293f48accf1fa170458432"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] = "970089ad61f8ca82017b59444aee483c1fc005e3f7a6af63cd5f146df8287cce"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] = "2f528377f57fbf81da35e2f08ec7ba50daddabebdce2cc86b6ec909fee157a33"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] = "c3b8ab03b64c824f2ea25db578b5760d44302be3fd1e4a78404c98cba39301f4"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] = "1ab711423497a1d02408a240da28ad366450574dd7f528ffaee80d1d5ed10550"
 
-SRC_URI[rustc-snapshot-powerpc.sha256sum] = "fbe7154abc641d6cacfdc6239ed4701fc7a09b5046c6d1bd209b59e7f2b2d0f0"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] = "ab2d5ac7cd295adaa4d959e8abbf42b372292c95d1a9f18aad64951ad6e2ab2b"
-SRC_URI[cargo-snapshot-powerpc.sha256sum] = "e67c30a72f969c51ad199084b3ce0cdc573a4e21f732b2cc39dafbcb9807a5ce"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] = "497104d49803598cd3801749ac86cb26c88a2bd9c3a8c7bdc18fdf487f4650c0"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] = "21ea61181ba7daa04f61bec6a295ad76ce34bfbd74ad1d679c4548977bd82eb9"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] = "e5ed58a861619bcc89fc3f969174c84fd6ed8a26b5d4b196f06efb868653c1c1"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] = "fd832c269af81dd1ee9f3831991fccdc2c7312e9a9069908510eefe7c313d144"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] = "c94578d31e4145a4169ab5761537a2a0133818278fb62ee76251ef8ef45228c8"
 
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] = "f8e38291ba4241bc28e9c118d7a449ce3601abdeb2076f2f618858679fb3b929"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] = "e9ff89e759125ad2786ad2f6c40e820095720ea00fba66819d15fba79489430a"
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] = "73cf850f6715acbf0029c7e5d4694825f61bd4e193e6413e65a78bcb13df97b7"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] = "29b63f23cd9af95846a246c9cc8349e514c3fb92ec0c840a38155e252d6cc668"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] = "a54bbe16e6a405f137a0dc51fd570140c80077ba769d29d885a60e74cb3196bb"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] = "06538b41a9351c449d215498d4ec2f072f728bd18df8fac7ef8534a0d0f34e27"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] = "4d398cd8da17d1a5f26734b39cb17e791b243ac3570f8da2e5e5580a9dfad578"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] = "0abf31a8cb2762a7a81dbee8a5798e43e11a83326711ce00ad16c5587bcf5e49"
 
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] = "371e40f9d6d82aecb056f70f82868d98ddc1c20510aa7d388442ac8d2d86a6ca"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] = "d0cfda4e18623d17922eb367e44ac9549ab3d5fe1c0bdbe0c2c95754255fa705"
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] = "e1469f4249a7e21f872af487dcd1bd10ce388b5b3679bdab0cb0965e1e30fe47"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] = "d8c590bc2e6fc75800e41516427f5095ba0e15d7633167689499fcf6523dc61a"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] = "7585a20b02b7dd497e393a2e7552a0c6aabb51556fcf7507c6f7ffde530f8c88"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] = "fcf940c0553a04cb9bd85cce524729c2f54b000b554fee95c7aa218d608b7e3d"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] = "8fefd2317023716a018986c4a62558a7b543ccf34e4e6d1104afc66edcae1c9c"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] = "8cc65649396ccad73cecd17b972ab8d4c34837136cf374425be63d697b541469"
 
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] = "2da33044f17a8bc49a1478dc1eb2536df491a44d6e6bb0ec7c86f46877d44e98"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] = "0f5ecfe54859bbe715821f982b1a5396784fdf55605d00ece05d3e57a965ed16"
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] = "c9f28b519799fc2d8089865e30fad04bb5339604d13725365fcd7ad7ee6c1489"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] = "9d21bc180196bccdb301e7e03034d3fd0df14b0c6520da0317bba7b1ce385fe8"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] = "4d1106b576221182f84412f3377a5148eab6950d20e45e4274cd8b58df46f26b"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] = "b28b9c2f183521a204f2899610253c11c86ee4aa903fe66d8410dfaa22c926e6"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] = "7825556908e10a48320cfb2d812851271d7cf549977173e028a0dd23af9d7eac"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] = "c39c53a82fdaaa97413728a4f3f9feb5b31bdf3e3e563c64651bd01713e79166"
 
-SRC_URI[rustc-snapshot-s390x.sha256sum] = "308361737ed522aa77dd8b4ea91b5db244113ada5fa234d3ed008b526d07e2e8"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] = "d25053fbee1a0cb899bac8c8e4968aa35f9c3637e486cb5bb2c79ad43a78f3e7"
-SRC_URI[cargo-snapshot-s390x.sha256sum] = "7e1defd60095c91ded1612194f811ec5f2fc2e83bb914d35594d01fa3c54049d"
-SRC_URI[clippy-snapshot-s390x.sha256sum] = "9780d8c4cfef9d05460b3e540aad142391b2e3994accf8cfc8afb87fefac6cf0"
+SRC_URI[rustc-snapshot-s390x.sha256sum] = "18caf22fbfc4d26c80b39b4c6b1cd5fb42dba3e32d5d3600c22eae6f688d7f4c"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] = "3919f6962d0aefdd2cd75d8dba749ed826936065b64c9a8d54d1d85c2685fd66"
+SRC_URI[cargo-snapshot-s390x.sha256sum] = "1c6eb1be254574881a611a3b8904cdcfe43c79a285875673e59c890dcd5766c2"
+SRC_URI[clippy-snapshot-s390x.sha256sum] = "c87183b52ddb4085ddf2524a775fd255d5fd11ad2fdd6424574f08750a8cf378"
 
-SRC_URI[rustc-snapshot-x86_64.sha256sum] = "7436f13797475082cd87aa65547449e01659d6a810b4cd5f8aedc48bb9f89dfb"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] = "285e105d25ebdf501341238d4c0594ecdda50ec9078f45095f793a736b1f1ac2"
-SRC_URI[cargo-snapshot-x86_64.sha256sum] = "0aff33b57b0e0b102d762a2b53042846c1ca346cff4b7bd96b5c03c9e8e51d81"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] = "0dc3ca1708a6c9eed05d0802364377572b79ff079815b7bcbe8e3991f77c4117"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] = "4438b809ce4a083af31ed17aeeedcc8fc60ccffc0625bef1926620751b6989d7"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] = "67be7184ea388d8ce0feaf7fdea46f1775cfc2970930264343b3089898501d37"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] = "c5c1590f7e9246ad9f4f97cfe26ffa92707b52a769726596a9ef81565ebd908b"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] = "02aaff2c1407d2da8dba19aa4970dd873e311902b120a66cbcdbe51eb8836edf"
 
-SRC_URI[rust-std-snapshot-i586.sha256sum] = "3cb7318da10876de14076549d79410a8441923a92d62b616d8c105f5f5cd831b"
+SRC_URI[rust-std-snapshot-i586.sha256sum] = "f0bddc6dba7d719b8ba131bcd634a8379e00fc825a51c0f17abf424c9cb5c052"
 
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] = "65cd47af46a5b74e61ff6ae4cce8a979ee8670a57b8aa61e732828d1da073f73"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] = "722238ae13e6e101d1b698d2b3a7915d59bb7f485b594e8d833cce8b9460383b"
 
 SRC_URI += " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=rust-std-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index f9c1fcd..ffdf00d 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -9,8 +9,9 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
             file://0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.patch;patchdir=${RUSTSRC} \
             file://0001-Disable-libunwind-cross-architecture-unwinding.patch;patchdir=${RUSTSRC} \
+            file://triagebot.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "d939eada065dc827a9d4dbb55bd48533ad14c16e7f0a42e70147029c82a7707b"
+SRC_URI[rust.sha256sum] = "8623b8651893e8c6aebfa45b6a90645a4f652f7b18189a0992a90d11ac2631f4"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust_1.86.0.bb b/recipes-devtools/rust/rust_1.87.0.bb
similarity index 99%
rename from recipes-devtools/rust/rust_1.86.0.bb
rename to recipes-devtools/rust/rust_1.87.0.bb
index 8cfc2bd..c6ddaed 100644
--- a/recipes-devtools/rust/rust_1.86.0.bb
+++ b/recipes-devtools/rust/rust_1.87.0.bb
@@ -266,7 +266,7 @@ rust_do_install:class-nativesdk() {
 
     install -d ${D}${bindir}
     for i in cargo-clippy clippy-driver rustfmt; do
-        cp build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
+        cp build/${RUST_BUILD_SYS}/stage1-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
         patchelf --set-rpath "\$ORIGIN/../lib" ${D}${bindir}/$i
     done
 
@@ -301,7 +301,7 @@ rust_do_install:class-target() {
 
     install -d ${D}${bindir}
     for i in ${EXTRA_TOOLS}; do
-        cp build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
+        cp build/${RUST_BUILD_SYS}/stage1-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
         patchelf --set-rpath "\$ORIGIN/../lib" ${D}${bindir}/$i
     done
 
-- 
2.50.0


