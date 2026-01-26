Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114E0D1953E
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:51:41 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35703.1769471492513077397
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:51:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Daejhc9c;
 spf=pass (domain: konsulko.com, ip: 209.85.222.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c6d8751c88so547116985a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471491; x=1770076291; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aW91sfcq/LI+MnxYSKyQVHK/xwK48/Fu1mWBQIYFoHw=;
        b=Daejhc9cqX9ojn7hR2cpYn2E60Bbgw3W4izZwomY5ziuVcnkM7Fnebj0p8We5kT62r
         v1MhJfO/GgOtWiFqHJPxC18/Og4fYFSBIy4qiypbRx3hH5Lf9eHHWJ6xtJgD5Z+T6/3Z
         q1FsUQJwHS8URhFBcpQpb9o401mouSSrc0TSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471491; x=1770076291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aW91sfcq/LI+MnxYSKyQVHK/xwK48/Fu1mWBQIYFoHw=;
        b=k1GSt4WsQaAPKDogldZ9xQ/MSJDpGKjEffnV+vHg4+hZe3Xyg7K8JXgYQqnkU0Qt2G
         U9TbRap9dek3jYnaBEaXOIPg/KqqNYULd+xRVm5T3K/Tl0N9aTVVBW0rpqtgFfGGrIHB
         oAsZd+5tZVLqvOn+x9zycYJgA1D0s0MvGFrEIuYUr961mkGbqif67upxD/plJcNFEygR
         xfcuyJU2mxctrADdWKn42goQz9IhHytNG4D3xhZYZuntPLovygUwcDa7H21N65f4AUMk
         8ih6mnPSNgQ/43KPeQR1kJF//BXj3tgEVZxOi/K7D4H8lIZhacTMd5labs68kvLnNhqI
         w9sQ==
X-Gm-Message-State: AOJu0YysCeBH39FFH/TRC8MJwxl70jknf7VgWpMCs2Tc9cUEhlJU3MT7
	uNk/poZgosniyJ/XobNhDcEYiSjN5Q0VDu0x9GkOfmraNA9UvQnr5eoSDo3W/kUppw+wkvG3qPx
	Eair6x7o=
X-Gm-Gg: AZuq6aIof05J+c3Su6LgE7zbSon0Q/S+7TRHsugbMMYQfemd8WaLuEbnZoButGvo4EJ
	6h3yTkR5IE+IYktZfgIAGYPjS2j4MqmqnAk9xJKkeMqt5Nppz5nqIpXZM7h8/195OUbxxeiWK3v
	PgarK5L+9NV4K5uWwl1rOVTFnKCuK62zdXMIHepbc9O1ibKrwnpEjkmQgNcP4EOHO7kTJc5HvMq
	HFzqk0OupGQg9YC5XYGFpWMSLiGHpFCVYvY9FNgfetuBpOBPHPlW4ZDuYUrSM3txN9m4TIRznsj
	Xf0afUi1pDxgcK+2Ktix9y1z6S4PQFKeCYUlfhj5kMY9FFxK+NWdj3f3GnKHkhwQFCDkG20rABT
	o0Raqz0H0kbk1PkE0mlcl20pObqHWY3rb3xzIv9+EpTSMQVHXzs6LHYFK1HIbO7aoMWr5QdFF3I
	7vLxtVVpPEOKdhaB0KdVT86kyLsAPw3kn+bbDXD2+aCR0nXHTrAkDVzfh9mvuca0ri79GDp1q4a
	TMwmdzePBYN+k+h1iWE4sUSgKZtOkKtCGhUhQgOPJ/DuUBJfToh
X-Received: by 2002:a05:620a:17a8:b0:8c6:e223:3ee9 with SMTP id af79cd13be357-8c6f9643034mr695255385a.54.1769471490743;
        Mon, 26 Jan 2026 15:51:30 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061293885a.15.2026.01.26.15.51.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:51:30 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 03/11] rust: Upgrade 1.90.0 -> 1.91.0
Date: Mon, 26 Jan 2026 18:51:07 -0500
Message-ID: <0520c44ca3fb0976ab4e0ea383923367e02dd9de.1769470900.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769470900.git.scott.murray@konsulko.com>
References: <cover.1769470900.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:51:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3093

From: Yash Shinde <Yash.Shinde@windriver.com>

https://blog.rust-lang.org/2025/10/30/Rust-1.91.0/

* Recent updates to rustc now require 'target_pointer_width'
  to be specified as an integer.
  Cast it to 'int' in rust target configuration to resolve the
  type consistency error.
  https://github.com/rust-lang/rust/pull/144443

* The "remote-test-server" bin is now generated in stage2-tools-bin dir
  rather than stage1. Update the test suite and recipe accordingly.

* Rebase existing patches with v1.91.0.

* Drop merged patches with rust v1.91.0.
  - 0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.patch
    https://github.com/llvm/llvm-project/pull/138077/commits/bcc31a9384d2df1c0f27ef140e1f0f9ee493034f

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 90a2922d5134e4d252a4f6da6935f58d3d024e54)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass     |  2 +-
 conf/layer.conf                               |  2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |  2 +-
 .../rust/{cargo_1.90.0.bb => cargo_1.91.0.bb} |  0
 ...-gcs-instead-of-gcs-target-attribute.patch | 66 ----------------
 ...teps-tool.rs-switch-off-lto-for-rust.patch | 20 ++---
 .../rust/files/rust-oe-selftest.patch         | 59 +++++---------
 ...ibstd-rs_1.90.0.bb => libstd-rs_1.91.0.bb} |  0
 ....90.0.bb => rust-cross-canadian_1.91.0.bb} |  0
 ...ust-llvm_1.90.0.bb => rust-llvm_1.91.0.bb} |  2 +-
 recipes-devtools/rust/rust-snapshot.inc       | 78 +++++++++----------
 recipes-devtools/rust/rust-source.inc         |  3 +-
 .../rust/{rust_1.90.0.bb => rust_1.91.0.bb}   |  4 +-
 13 files changed, 75 insertions(+), 163 deletions(-)
 rename recipes-devtools/rust/{cargo_1.90.0.bb => cargo_1.91.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.patch
 rename recipes-devtools/rust/{libstd-rs_1.90.0.bb => libstd-rs_1.91.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.90.0.bb => rust-cross-canadian_1.91.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.90.0.bb => rust-llvm_1.91.0.bb} (99%)
 rename recipes-devtools/rust/{rust_1.90.0.bb => rust_1.91.0.bb} (99%)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index b5d0d18..1f3b071 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -368,7 +368,7 @@ def rust_gen_target(d, thing, wd, arch):
     if tspec['data-layout'] is None:
         bb.fatal("No rust target defined for %s" % arch_abi)
     tspec['max-atomic-width'] = int(d.getVarFlag('MAX_ATOMIC_WIDTH', arch_abi))
-    tspec['target-pointer-width'] = d.getVarFlag('TARGET_POINTER_WIDTH', arch_abi)
+    tspec['target-pointer-width'] = int(d.getVarFlag('TARGET_POINTER_WIDTH', arch_abi))
     tspec['target-c-int-width'] = int(d.getVarFlag('TARGET_C_INT_WIDTH', arch_abi))
     tspec['target-endian'] = d.getVarFlag('TARGET_ENDIAN', arch_abi)
     tspec['arch'] = arch_to_rust_target_arch(rust_arch)
diff --git a/conf/layer.conf b/conf/layer.conf
index 8c5dc72..3fac513 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERDEPENDS_scarthgap-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.90.0%"
+RUSTVERSION ?= "1.91.0%"
diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/cases/rust_mixin.py
index 50684ca..3d06200 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -109,7 +109,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
             # Copy remote-test-server to image through scp
             host_sys = get_bb_var("RUST_BUILD_SYS", "rust")
             ssh = SSHControl(ip=qemu.ip, logfile=qemu.sshlog, user="root")
-            ssh.copy_to(builddir + "/build/" + host_sys + "/stage1-tools-bin/remote-test-server","~/")
+            ssh.copy_to(builddir + "/build/" + host_sys + "/stage2-tools-bin/remote-test-server","~/")
             # Execute remote-test-server on image through background ssh
             command = '~/remote-test-server --bind 0.0.0.0:12345 -v'
             sshrun=subprocess.Popen(("ssh", '-o',  'UserKnownHostsFile=/dev/null', '-o',  'StrictHostKeyChecking=no', '-f', "root@%s" % qemu.ip, command), shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
diff --git a/recipes-devtools/rust/cargo_1.90.0.bb b/recipes-devtools/rust/cargo_1.91.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.90.0.bb
rename to recipes-devtools/rust/cargo_1.91.0.bb
diff --git a/recipes-devtools/rust/files/0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.patch b/recipes-devtools/rust/files/0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.patch
deleted file mode 100644
index a704671..0000000
--- a/recipes-devtools/rust/files/0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.patch
+++ /dev/null
@@ -1,66 +0,0 @@
-From e4f4094de8ddcbe6d5ff1cdf782d2b89e0563903 Mon Sep 17 00:00:00 2001
-From: Khem Raj <raj.khem@gmail.com>
-Date: Wed, 30 Apr 2025 19:51:19 -0700
-Subject: [PATCH] libunwind: Use +gcs instead of gcs target attribute
-
-__attribute__((target("gcs"))) does not work with gcc
-
-GCC-15 has added gcs intrinsics [1] but the syntax for enabling it is
-slightly different. This syntax works with clang too.
-
-With gcc15 compiler libunwind's check for this macros is succeeding and it
-ends up enabling 'gcs' by using function attribute, this works with clang
-but not with gcc but '+gcs' works with both
-
-We can see this in rust compiler bootstrap for aarch64/musl when system
-uses gcc15, it ends up with these errors
-
-Building libunwind.a for aarch64-poky-linux-musl
-cargo:warning=/mnt/b/yoe/master/sources/poky/build/tmp/work/cortexa57-poky-linux-musl/rust/1.85.1/rustc-1.85.1-src/src/llvm-project/libunwind/src/UnwindLevel1.c:191:1: error: arch extension 'gcs' should be prefixed by '+'
-cargo:warning=  191 | unwind_phase2(unw_context_t *uc, unw_cursor_t *cursor, _Unwind_Exception *exception_object) {
-cargo:warning=      | ^~~~~~~~~~~~~
-cargo:warning=/mnt/b/yoe/master/sources/poky/build/tmp/work/cortexa57-poky-linux-musl/rust/1.85.1/rustc-1.85.1-src/src/llvm-project/libunwind/src/UnwindLevel1.c:337:22: error: arch extension 'gcs' should be prefixed by '+'
-cargo:warning=  337 |                      _Unwind_Stop_Fn stop, void *stop_parameter) {
-cargo:warning=      |                      ^~~~~~~~~~~~~~~
-
-[1] https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=5a6af707f0af
-
-Upstream-Status: Submitted [https://github.com/llvm/llvm-project/pull/138077]
-
-Signed-off-by: Khem Raj <raj.khem@gmail.com>
----
- src/llvm-project/libunwind/src/UnwindLevel1.c | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
-
---- a/src/llvm-project/libunwind/src/UnwindLevel1.c
-+++ b/src/llvm-project/libunwind/src/UnwindLevel1.c
-@@ -185,7 +185,7 @@ extern int __unw_step_stage2(unw_cursor_
- 
- #if defined(_LIBUNWIND_USE_GCS)
- // Enable the GCS target feature to permit gcspop instructions to be used.
--__attribute__((target("gcs")))
-+__attribute__((target("+gcs")))
- #endif
- static _Unwind_Reason_Code
- unwind_phase2(unw_context_t *uc, unw_cursor_t *cursor, _Unwind_Exception *exception_object) {
-@@ -329,7 +329,7 @@ unwind_phase2(unw_context_t *uc, unw_cur
- 
- #if defined(_LIBUNWIND_USE_GCS)
- // Enable the GCS target feature to permit gcspop instructions to be used.
--__attribute__((target("gcs")))
-+__attribute__((target("+gcs")))
- #endif
- static _Unwind_Reason_Code
- unwind_phase2_forced(unw_context_t *uc, unw_cursor_t *cursor,
---- a/src/llvm-project/libunwind/src/cet_unwind.h
-+++ b/src/llvm-project/libunwind/src/cet_unwind.h
-@@ -42,7 +42,8 @@
- #include <arm_acle.h>
- 
- // We can only use GCS if arm_acle.h defines the GCS intrinsics.
--#ifdef _CHKFEAT_GCS
-+// Enable gcs with clang for now, gcc does not build unwindlevel1.c correctly
-+#if defined(_CHKFEAT_GCS) && defined(__clang__)
- #define _LIBUNWIND_USE_GCS 1
- #endif
- 
diff --git a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
index 7f25ba9..a8232b9 100644
--- a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
+++ b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
@@ -24,9 +24,9 @@ diff --git a/src/bootstrap/src/core/build_steps/tool.rs b/src/bootstrap/src/core
 index 087df2f8a..00790affb 100644
 --- a/src/bootstrap/src/core/build_steps/tool.rs
 +++ b/src/bootstrap/src/core/build_steps/tool.rs
-@@ -16,14 +16,12 @@ use std::{env, fs};
- #[cfg(feature = "tracing")]
- use tracing::instrument;
+@@ -13,14 +13,12 @@ use std::ffi::OsStr;
+ use std::path::PathBuf;
+ use std::{env, fs};
 
 -use crate::core::build_steps::compile::is_lto_stage;
  use crate::core::build_steps::toolstate::ToolState;
@@ -41,14 +41,16 @@ index 087df2f8a..00790affb 100644
 +use crate::core::config::{DebuginfoLevel, TargetSelection};
  use crate::utils::exec::{BootstrapCommand, command};
  use crate::utils::helpers::{add_dylib_path, exe, t};
- use crate::{Compiler, FileType, Kind, Mode, gha};
-@@ -160,20 +158,7 @@ impl Step for ToolBuild {
+ use crate::{Compiler, FileType, Kind, Mode};
+@@ -121,22 +119,7 @@ impl Step for ToolBuild {
              cargo.env("RUSTC_WRAPPER", ccache);
          }
 
--        // Rustc tools (miri, clippy, cargo, rustfmt, rust-analyzer)
+-        // RustcPrivate tools (miri, clippy, rustfmt, rust-analyzer) and cargo
 -        // could use the additional optimizations.
--        if self.mode == Mode::ToolRustc && is_lto_stage(&self.build_compiler) {
+-        if is_lto_stage(&self.build_compiler)
+-            && (self.mode == Mode::ToolRustcPrivate || self.path == "src/tools/cargo")
+-        {
 -            let lto = match builder.config.rust_lto {
 -                RustcLto::Off => Some("off"),
 -                RustcLto::Thin => Some("thin"),
@@ -67,7 +69,7 @@ index 087df2f8a..00790affb 100644
 diff --git a/src/bootstrap/src/core/builder/mod.rs b/src/bootstrap/src/core/builder/mod.rs
 --- a/src/bootstrap/src/core/builder/mod.rs
 +++ b/src/bootstrap/src/core/builder/mod.rs
-@@ -13,7 +13,7 @@
+@@ -13,7 +13,7 @@ use clap::ValueEnum;
  #[cfg(feature = "tracing")]
  use tracing::instrument;
  
@@ -75,4 +77,4 @@ diff --git a/src/bootstrap/src/core/builder/mod.rs b/src/bootstrap/src/core/buil
 +pub use self::cargo::Cargo;
  pub use crate::Compiler;
  use crate::core::build_steps::compile::{Std, StdLink};
- use crate::core::build_steps::{
+ use crate::core::build_steps::tool::RustcPrivateCompilers;
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index fe683e9..7d26d75 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -10,7 +10,7 @@ Signed-off-by: Peter Tatrai <Peter.Tatrai@siemens.com>
 diff --git a/compiler/rustc_errors/src/markdown/tests/term.rs b/compiler/rustc_errors/src/markdown/tests/term.rs
 --- a/compiler/rustc_errors/src/markdown/tests/term.rs
 +++ b/compiler/rustc_errors/src/markdown/tests/term.rs
-@@ -61,6 +61,7 @@ fn test_wrapping_write() {
+@@ -62,6 +62,7 @@ fn test_wrapping_write() {
  }
 
  #[test]
@@ -21,7 +21,7 @@ diff --git a/compiler/rustc_errors/src/markdown/tests/term.rs b/compiler/rustc_e
 diff --git a/compiler/rustc_interface/src/tests.rs b/compiler/rustc_interface/src/tests.rs
 --- a/compiler/rustc_interface/src/tests.rs
 +++ b/compiler/rustc_interface/src/tests.rs
-@@ -137,6 +137,7 @@ fn assert_non_crate_hash_different(x: &Options, y: &Options) {
+@@ -147,6 +147,7 @@ fn assert_non_crate_hash_different(x: &Options, y: &Options) {
 
  // When the user supplies --test we should implicitly supply --cfg test
  #[test]
@@ -29,7 +29,7 @@ diff --git a/compiler/rustc_interface/src/tests.rs b/compiler/rustc_interface/sr
  fn test_switch_implies_cfg_test() {
      sess_and_cfg(&["--test"], |_sess, cfg| {
          assert!(cfg.contains(&(sym::test, None)));
-@@ -145,6 +146,7 @@ fn test_switch_implies_cfg_test() {
+@@ -155,6 +156,7 @@ fn test_switch_implies_cfg_test() {
 
  // When the user supplies --test and --cfg test, don't implicitly add another --cfg test
  #[test]
@@ -37,7 +37,7 @@ diff --git a/compiler/rustc_interface/src/tests.rs b/compiler/rustc_interface/sr
  fn test_switch_implies_cfg_test_unless_cfg_test() {
      sess_and_cfg(&["--test", "--cfg=test"], |_sess, cfg| {
          let mut test_items = cfg.iter().filter(|&&(name, _)| name == sym::test);
-@@ -154,6 +156,7 @@ fn test_switch_implies_cfg_test_unless_cfg_test() {
+@@ -164,6 +166,7 @@ fn test_switch_implies_cfg_test_unless_cfg_test() {
  }
 
  #[test]
@@ -49,7 +49,7 @@ diff --git a/library/std/tests/sync/rwlock.rs b/library/std/tests/sync/rwlock.rs
 index 1a9d3d3f12f..0a9cfc48806 100644
 --- a/library/std/tests/sync/rwlock.rs
 +++ b/library/std/tests/sync/rwlock.rs
-@@ -74,6 +74,7 @@
+@@ -605,6 +605,7 @@
  
  #[test]
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
@@ -57,7 +57,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_rw_arc_poison_wr() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -87,6 +88,7 @@
+@@ -618,6 +619,7 @@
  
  #[test]
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
@@ -65,7 +65,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_rw_arc_poison_mapped_w_r() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -101,6 +103,7 @@
+@@ -632,6 +634,7 @@
  
  #[test]
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
@@ -73,7 +73,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_rw_arc_poison_ww() {
      let arc = Arc::new(RwLock::new(1));
      assert!(!arc.is_poisoned());
-@@ -115,6 +118,7 @@
+@@ -646,6 +649,7 @@
  }
  
  #[test]
@@ -81,7 +81,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
  fn test_rw_arc_poison_mapped_w_w() {
      let arc = Arc::new(RwLock::new(1));
-@@ -131,6 +135,7 @@
+@@ -662,6 +666,7 @@
  
  #[test]
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
@@ -89,7 +89,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_rw_arc_no_poison_rr() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -160,6 +165,7 @@
+@@ -691,6 +696,7 @@
  
  #[test]
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
@@ -97,38 +97,14 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_rw_arc_no_poison_rw() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -227,6 +233,7 @@
- 
- #[test]
- #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
-+#[ignore]
- fn test_rw_arc_access_in_unwind() {
-     let arc = Arc::new(RwLock::new(1));
-     let arc2 = arc.clone();
-@@ -326,6 +333,7 @@
- 
- #[test]
- #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
-+#[ignore]
- fn test_into_inner_poison() {
-     let m = new_poisoned_rwlock(NonCopy(10));
- 
-@@ -362,6 +370,7 @@
- 
- #[test]
- #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
-+#[ignore]
- fn test_get_mut_poison() {
-     let mut m = new_poisoned_rwlock(NonCopy(10));
- 
-@@ -571,6 +571,7 @@
+@@ -794,6 +800,7 @@
  
  #[test]
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
 +#[ignore]
  fn panic_while_mapping_write_unlocked_poison() {
      let lock = RwLock::new(());
-
+ 
 diff --git a/library/test/src/tests.rs b/library/test/src/tests.rs
 --- a/library/test/src/tests.rs
 +++ b/library/test/src/tests.rs
@@ -143,7 +119,7 @@ diff --git a/library/test/src/tests.rs b/library/test/src/tests.rs
 diff --git a/library/std/tests/sync/mutex.rs b/library/std/tests/sync/mutex.rs
 --- a/library/std/tests/sync/mutex.rs
 +++ b/library/std/tests/sync/mutex.rs
-@@ -312,6 +312,7 @@
+@@ -472,6 +472,7 @@
  
  #[test]
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
@@ -151,7 +127,7 @@ diff --git a/library/std/tests/sync/mutex.rs b/library/std/tests/sync/mutex.rs
  fn test_mutex_arc_poison_mapped() {
      let arc = Arc::new(Mutex::new(1));
      assert!(!arc.is_poisoned());
-@@ -391,6 +392,7 @@
+@@ -388,6 +389,7 @@
  
  #[test]
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
@@ -308,13 +284,14 @@ diff --git a/tests/codegen-llvm/transmute-scalar.rs b/tests/codegen-llvm/transmu
 index ce1b0558b2e..e8fda2cd566 100644
 --- a/tests/codegen-llvm/transmute-scalar.rs
 +++ b/tests/codegen-llvm/transmute-scalar.rs
-@@ -1,5 +1,6 @@
+@@ -1,6 +1,7 @@
  //@ add-core-stubs
- //@ compile-flags: -C opt-level=0 -C no-prepopulate-passes
+ //@ compile-flags: -C opt-level=0 -C no-prepopulate-passes --target=x86_64-unknown-linux-gnu
+ //@ needs-llvm-components: x86
 +//@ ignore-riscv64
  
  #![crate_type = "lib"]
- #![feature(no_core, repr_simd, arm_target_feature, mips_target_feature, s390x_target_feature)]
+ #![feature(no_core, repr_simd)]
 diff --git a/tests/codegen-llvm/uninhabited-transparent-return-abi.rs b/tests/codegen-llvm/uninhabited-transparent-return-abi.rs
 index face1577c3f..09e0846bad0 100644
 --- a/tests/codegen-llvm/uninhabited-transparent-return-abi.rs
diff --git a/recipes-devtools/rust/libstd-rs_1.90.0.bb b/recipes-devtools/rust/libstd-rs_1.91.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.90.0.bb
rename to recipes-devtools/rust/libstd-rs_1.91.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.90.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.91.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.90.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.91.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.90.0.bb b/recipes-devtools/rust/rust-llvm_1.91.0.bb
similarity index 99%
rename from recipes-devtools/rust/rust-llvm_1.90.0.bb
rename to recipes-devtools/rust/rust-llvm_1.91.0.bb
index 42d4031..b060cd5 100644
--- a/recipes-devtools/rust/rust-llvm_1.90.0.bb
+++ b/recipes-devtools/rust/rust-llvm_1.91.0.bb
@@ -4,7 +4,7 @@ HOMEPAGE = "http://www.rust-lang.org"
 
 # check src/llvm-project/llvm/CMakeLists.txt for llvm version in use
 #
-LLVM_RELEASE = "20.1.8"
+LLVM_RELEASE = "21.1.2"
 
 require rust-source.inc
 
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rust/rust-snapshot.inc
index 6a8802c..c6f9031 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,56 +4,56 @@
 ## The exact (previous) version that has been used is specified in the source tarball.
 ## The version is replicated here.
 
-SNAPSHOT_VERSION = "1.89.0"
+SNAPSHOT_VERSION = "1.90.0"
 
-SRC_URI[rustc-snapshot-aarch64.sha256sum] = "16ed8d8c7628a481c8501e7cd1022a123269b297bdedbb7f211f37a15e937e0e"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] = "abea0955dded88c68d731524ab9d29b162fae23bf5805b9f1dec063cba37c2aa"
-SRC_URI[cargo-snapshot-aarch64.sha256sum] = "f9df3ee6d55a2387459b843477743fa386c3c0f126bd0be01691ee49309681b8"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] = "46512c61e217e613dc4d329fda8c6dde0d0ea94c4ae59c1ca2af9cf480458ff0"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] = "4e1a9987a11d7d91f0d5afbf5333feb62f44172e4a31f33ce7246549003217f2"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] = "4952abb7d9d3ed7cea4f7ea44dcb23dc67631fae4ac44a5f059b90a4b5e9223f"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] = "bd8d1da6fe88ea7e29338f24277c22156267447adbfc47d690467ad32d02c2a7"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] = "1a7f969c5712c17d960d6fba8235b33f264a9484b369dc388766a540f1ba464f"
 
-SRC_URI[rustc-snapshot-i686.sha256sum] = "a5ca58ab1b419ddbf5e4ea9b206a3d1feb0cfc4e0879a96c2c2f809ee9ca00b0"
-SRC_URI[rust-std-snapshot-i686.sha256sum] = "853605815e8267baf8fdc6e4594514d2e0afb46fb29f478ebec871a3424430f3"
-SRC_URI[cargo-snapshot-i686.sha256sum] = "1b3edcf590af9b9abdfa95f34b90a4258560627464a2a25d4e4503bb5834e291"
-SRC_URI[clippy-snapshot-i686.sha256sum] = "2c47960ee78d804ce679b06c9c759e777ac7f39cae48bd8ffaf7ff706f951520"
+SRC_URI[rustc-snapshot-i686.sha256sum] = "3b33cef77f9a57d592beb5117d933134bc76258006e6d4f9aed2969d20c75742"
+SRC_URI[rust-std-snapshot-i686.sha256sum] = "dc4bffa768326e0cc47d6b129bcb891af6e7b7bf09ec92bca45e49420b9837bd"
+SRC_URI[cargo-snapshot-i686.sha256sum] = "c1e9b24bbfa95550b5dba9de2045a4c906bea108625781758692b2a407428391"
+SRC_URI[clippy-snapshot-i686.sha256sum] = "3e902971ef6b44ccb804af73aba5dc8c6199ed09a76f178b0eed6f53f7f56eab"
 
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] = "c090c2ab6b54a8d84129de4ef53bd4df35358191092d3217bf6fa99c20c860c6"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] = "2c5aa2cad944499c5b64947dcfeb12f3d5c91ced330a0982e000f22ec3dea27f"
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] = "d22678ae984535464cd9aff3515e9ec5145ecb8db489ef4cce5c697e0538b500"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] = "0392c4fc97dc72b0d7d518129428c928b887e63b47f3d931fab7e54e2332ca9c"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] = "aca7ee7f0d98e34dafa367cef9c35626d37cf8334f356498aa2bda2fc02206b3"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] = "cb779575cec151223c3c144bc9ca957530fa510e36b32bc9f35bbb1b7dde9e2f"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] = "6ae37dc8eb3ff4655053a39d5f973613a82a8a8e2fff42c423ca33d8cf19e6c1"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] = "847b3d4bd3d2be23bafbb90cd2ed5e1bf1aacb2e7152e7d2f99bee1078aa0eaa"
 
-SRC_URI[rustc-snapshot-powerpc.sha256sum] = "08de18310e7750796261b45d5faccc31ff94ff64148bb5d9fa65e9727a432010"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] = "a03b3c3facf4701b6c7e8f379f2aac445a582227b881e3268dee3752a84a89eb"
-SRC_URI[cargo-snapshot-powerpc.sha256sum] = "ebdb0c8c9fad2d07dc702c9bfaee5dd140f6b0f9493bdd0c0d33f1449b7d97c2"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] = "f93cb4327943f30b3da8e671eab6a78cdc3110c6612ad2a5eeaa9d8597fbd452"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] = "c5d898ca92063d634011525557f2acabc65d4ea268022e7005f99b6ba917357b"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] = "756d1bbd66ebb0d4d575b650a8a94d52546f6892bd2f864410411f6027ed879f"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] = "5b160a2bf0e6f470b83c5988db5b6f02b6d65d3d97a9b965acbfe940b4143b34"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] = "42ac7480dcac12a843803f5ee398d2a42389359178774cab20c66eda4f6927a5"
 
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] = "6c66c8a3d698bb338d20453c88d768e87a5af8970af4f4082d18dec26c10da2c"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] = "29338a9b067fe1adfd4d5ad681577c2333b3ca266a631822f23fad0984dcca39"
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] = "f23184532c1e2eef6df49358fdfb867e99e84db7c814ce667744a36bc2fd8d37"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] = "695228193ff41ac32ec562140294d87b1988311dfe685acc72b725429e2651d9"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] = "7adbc3c317a73b7d504e171d65a2b0e93953e3e572dab99acabe91140101f81d"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] = "16daac5dc6994c03ab3b8c4e6e5e52c41f5fc5846acea08f4fdf0759cc273aa2"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] = "fdf90d22476c88d5b9cf8a3ac0937d0b9c6b7dafbf6b3afde369c2f5b8faec88"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] = "071e06a50d5b2975905bb2d6211f2d2372ab0dbd50b7b0097168cb64e77a4bb0"
 
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] = "14b7a8b7b3951a59a765804e1dd2ad454d3412000e7166ad8f2f621e29a88941"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] = "40123b87f0b909376d7f0bd291553b7e10aa637dd710f4bc698bcdcd0b08d21b"
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] = "764eb5f54c2b0779f9e84c6fb0763e45316d5a51fbd187b56f9f6d7a646272d4"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] = "682d112649355a637a871347d41317e361eb555bbfd4a4e48b26b0978449184b"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] = "e87b8eb926a65211a99f6712ff376c5950b4b11c67ed7f92019da27a34ae7085"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] = "eac29f92ccd335c51553c362c7a6d3de2eb7071b5ae3839470e351a6a3ebdb77"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] = "f029151dfeed6570b8b347e04a5bb7dcb9c59d8e5454c535c05bb5069c216354"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] = "12d19dbec34c5a35cd285fe74dcd0226563c0b25be5d041479744060e9374c98"
 
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] = "2a2a00288faa8a55b16a3135c979bbd9c823f1e9ff376ea452ef0700ccc20d48"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] = "ee83276bb2d456116517638b8ff379c24ceffe1c0e381103739cb1db8e4c20da"
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] = "ec9a8f609f23b196d09e6537dbaec7c6fd947e3b8266406c6654b2c112530de2"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] = "6bba0817c70b4dfae08238beb38003c623404d26b9ec00a297d08c9bf81c6d76"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] = "11ae522969c6b18ad4b5a1ae229473de59406af7ab2e831acb43ee247a16b58d"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] = "675dc5556d9d879101d2401b693fcf79edac8f00a49249e2e0f19cecd172ce51"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] = "8a09de014f7cec749b338c6636d190a1b73fd377bab6a223eb715d3c76c49e79"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] = "02338e25b3d2b61d9dbee7bee4c9ed148f18e2d010c6297ffd36df98042f41a2"
 
-SRC_URI[rustc-snapshot-s390x.sha256sum] = "b2b811644d26d10195be0272b81bd28ed55aa998300c52b0d3b74bb40c162c42"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] = "2a7ed11535aac5b298a21799292ad8393b14a16acbac6358416406a0d2639746"
-SRC_URI[cargo-snapshot-s390x.sha256sum] = "92534c38ffe3a6b17964f37ca812c5d00f079011acb060ec036945d2f568a772"
-SRC_URI[clippy-snapshot-s390x.sha256sum] = "a4a050854353325c1710440a5f727e4280f1758fad5c0da6ba336ed57156fb48"
+SRC_URI[rustc-snapshot-s390x.sha256sum] = "274daef5a69c8812411248a4afea4f58a096c978dffba6b1198da8e3b5a02de7"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] = "e3e7e3dbc65616eebc69e642d9042363ec38d7f50393ef816cc5238ec475f3f5"
+SRC_URI[cargo-snapshot-s390x.sha256sum] = "468ace270ee4edac0a10185ea876ea555e41bacc0137ff08985d2155fe8cc777"
+SRC_URI[clippy-snapshot-s390x.sha256sum] = "bb0a9483a36fdbdab08b433613b374c036779d247a8d508e31265193c3759a8d"
 
-SRC_URI[rustc-snapshot-x86_64.sha256sum] = "b42c254e1349df86bd40bc28fdf386172a1a46f2eeabe3c7a08a75cf1fb60e27"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] = "2719470dcd78b3f97d78b978c8f85a1a58d84ff11b62558294621c01bca34d49"
-SRC_URI[cargo-snapshot-x86_64.sha256sum] = "99fc10be2aeedf2c23a484f217bfa76458494495a0eee33e280d3616bb08282d"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] = "c6c362c6cd74567022e9ba0c16f6676f8c2b73d955adcf1f6f4c51cf15e57ce8"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] = "48c2a42de9e92fcae8c24568f5fe40d5734696a6f80e83cc6d46eef1a78f13c9"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] = "663f4ab7945b392d5e5294dec1b050a66820a20e86f084ec37eeb0f2f7ff5569"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] = "9853db03d68578a30972e2755c89c66aec035fec641cf8f3a7117c81eec2578d"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] = "5b6466419693a05365827378145014a37ae74fb2948fab390d5210a524792ed8"
 
-SRC_URI[rust-std-snapshot-i586.sha256sum] = "7909e4bff0a971286958f2a88c3bbf231d6ba4ac1add0b2aa3669adb9f869836"
+SRC_URI[rust-std-snapshot-i586.sha256sum] = "46eab5c41bf9160a31a53560ff5fc43308c0998cde952533e76fadef66799553"
 
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] = "a23126912b494dc2fcad495f78f920e43c2b1f06159e45477664aa37c03d80fa"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] = "c204ecb424090cc6c0100cef3013f8636d29f288db99c037578aee7d2672a711"
 
 SRC_URI += " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=rust-std-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 895e9a8..0378f3c 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -7,10 +7,9 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=${RUSTSRC} \
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
             file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
-            file://0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.patch;patchdir=${RUSTSRC} \
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "6bfeaddd90ffda2f063492b092bfed925c4b8c701579baf4b1316e021470daac"
+SRC_URI[rust.sha256sum] = "9b94161dba3aa32192e0e75f7891912d98095ffb86087b07a05af35a0265a938"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust_1.90.0.bb b/recipes-devtools/rust/rust_1.91.0.bb
similarity index 99%
rename from recipes-devtools/rust/rust_1.90.0.bb
rename to recipes-devtools/rust/rust_1.91.0.bb
index c6ddaed..8cfc2bd 100644
--- a/recipes-devtools/rust/rust_1.90.0.bb
+++ b/recipes-devtools/rust/rust_1.91.0.bb
@@ -266,7 +266,7 @@ rust_do_install:class-nativesdk() {
 
     install -d ${D}${bindir}
     for i in cargo-clippy clippy-driver rustfmt; do
-        cp build/${RUST_BUILD_SYS}/stage1-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
+        cp build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
         patchelf --set-rpath "\$ORIGIN/../lib" ${D}${bindir}/$i
     done
 
@@ -301,7 +301,7 @@ rust_do_install:class-target() {
 
     install -d ${D}${bindir}
     for i in ${EXTRA_TOOLS}; do
-        cp build/${RUST_BUILD_SYS}/stage1-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
+        cp build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
         patchelf --set-rpath "\$ORIGIN/../lib" ${D}${bindir}/$i
     done
 
-- 
2.51.0


