Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35CFC54F54
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:23 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4582.1785497603072756959
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=azUTK5GV;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-930c0f9c1b1so48465485a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497602; x=1786102402; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jm0giMoXFPigZJpPFP5H1SwqCbf/1pEO/iNFKJREhss=;
        b=azUTK5GVHYjxumJvnPtC3FmHyd47RhFRYUdLx7YATFcc5fLhDakLsvAtn/wj4+JlKZ
         HBJBU/LvK+4C/knWhuKg474vhx5Nvg5/T3LGLWlIC0X2nrM7OIjfob7HbRFXHQEKpQrE
         ofj29wIibmH3OwSVz5D88R99IFyevRODXc0KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497602; x=1786102402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jm0giMoXFPigZJpPFP5H1SwqCbf/1pEO/iNFKJREhss=;
        b=TClk3lcZq/Kvu1qBpvF+Q5FMftNcemPJiiuJvddNyRoHUWBddYEn1q93hEL0gjizjU
         6lbG1rRMBJ9B6KUsID9syEOR4oedohS7wcVhRkRToI+OdO/4WI9LgwjCO8Vkv0B79RHa
         Fzb+OE3puLiaR0KgIkWKLwTLZE4Llb/l1HBpbpsihEL4JDUCtJ+gFn+qMK9jc15am2TR
         PvJVGWWLL/V6IC4ZL3q2/Ep2dmYDVvms2qP4dFUMLmTQH6Sp7jHhwyOLwcrvLkmmLnW/
         kfUPeRkxxsoAQdQ9mV78phwfhwtB8wktRSKSPVjkwh3opm5JKx7HTB5Zu8siGvUm6ZLB
         KITw==
X-Gm-Message-State: AOJu0Yzw6PT/pClLodHx0rkBrgP1R/Ue0y4aiWv6yKR1kSZm7VUSMwJg
	FlKkZYCFwE968hRQmjNjxa41ZNOARzJ0JbSWrlZt+CeDcRjrTaV89X+Yuwleo782JEufXLiFUo+
	mCTBA
X-Gm-Gg: AR+sD10pgEjeUseZzcUToyBOS3/WTn2m0WFU2hh2dNIyi+TRhIEb92nP+S//ithZhqG
	4RHvGml4skEGUbv207eb4l1PFJWt0nZAnZh+Ph9oNvYglomwnZqgz3tWW7/6ZP3R80lzo8D2Gvn
	TSB9xdeSQCLUkU+9HNe+kVJbTehWzmm5sLiUDjOPvx9CFx3RDbzGM6AQUHbdrpjtYhQfYBOs5g+
	Vz4/6MZhBQJlrfj9IdCsJheJEVAMAflZCJAg6FX8rmz+dM1415pYnWaYEzRH8w2cYNybjevc7S9
	xj4SrN6lkG3nBjXS0EHwAH7oFf0d7PVedqA/1/A2lipJIljsi22ndblCE7B7XWzjYPtToyvUGzH
	WmBVd0222odrGfULZnRmWheTiKOkBmVUHxogA4GuPLuK3LnBNaDHm3u1QNX368gCJCaOye/U1su
	gM2nCB06e9jKxzI+Iw51fglSO33JYRQi7cMleavOmJOvQfQP6JBWDvQRvwbKc+Lx67D3MynNDXW
	9tdSqKnjfPDQpJZpsM+crdx3FEgpz4CHuWOWhFEMNSpYljk/zK8L9uaYhBMUsRxP80KNLvnuqIK
	BMWg695AxXzu0K3ySfLBkfaY1Q==
X-Received: by 2002:a05:620a:a417:10b0:92e:8a84:7041 with SMTP id af79cd13be357-93496591e29mr171546685a.8.1785497601609;
        Fri, 31 Jul 2026 04:33:21 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:21 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 05/35] rust: Upgrade 1.93.0 -> 1.94.0
Date: Fri, 31 Jul 2026 07:32:35 -0400
Message-ID: <fd9a224b92141ac93c8781c99e598cde6edb167d.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4581

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

https://blog.rust-lang.org/2026/03/05/Rust-1.94.0/

Rust Changes:
https://github.com/rust-lang/rust/releases/tag/1.94.0

Cargo Changes:
https://doc.rust-lang.org/nightly/cargo/CHANGELOG.html#cargo-194-2026-03-05

Rebased patch:
rust-oe-selftest.patch

Backported patch:
0001-Update-call-llvm-intrinsics-test.patch
To fix riscv64 oe-selftest failure with 1.94.0

Test results:

rust v1.94.0
+-------------+---------+---------+
| Machine     | Passed  | Skipped |
+-------------+---------+---------+
| qemux86-64  |  21910  |   659   |
| qemux86     |  21657  |   912   |
| qemuarm64   |  21722  |   847   |
| qemuarm     |  21638  |   931   |
| qemuriscv64 |  21684  |   885   |
+-------------+---------+---------+

Test results difference (1.94.0 - 1.93.0):

+-------------+--------+---------+
| Machine     | Passed | Skipped |
+-------------+--------+---------+
| qemux86-64  |  +221  |   +13   |
| qemux86     |  +218  |   +16   |
| qemuarm64   |  +227  |   +7    |
| qemuarm     |  +217  |   +17   |
| qemuriscv64 |  +218  |   +16   |
+-------------+--------+---------+

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 766657738a1463c0a6b632bd82b6d8fcb300062d)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |   2 +-
 .../rust/{cargo_1.93.0.bb => cargo_1.94.0.bb} |   0
 ...001-Update-call-llvm-intrinsics-test.patch |  86 +++++++++++++++
 .../rust/files/rust-oe-selftest.patch         |  54 +++++-----
 ...ibstd-rs_1.93.0.bb => libstd-rs_1.94.0.bb} |   0
 ....93.0.bb => rust-cross-canadian_1.94.0.bb} |   0
 ...ust-llvm_1.93.0.bb => rust-llvm_1.94.0.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       | 102 +++++++++---------
 recipes-devtools/rust/rust-source.inc         |   3 +-
 recipes-devtools/rust/rust-source.inc.orig    |  17 ---
 .../rust/{rust_1.93.0.bb => rust_1.94.0.bb}   |   0
 11 files changed, 168 insertions(+), 96 deletions(-)
 rename recipes-devtools/rust/{cargo_1.93.0.bb => cargo_1.94.0.bb} (100%)
 create mode 100644 recipes-devtools/rust/files/0001-Update-call-llvm-intrinsics-test.patch
 rename recipes-devtools/rust/{libstd-rs_1.93.0.bb => libstd-rs_1.94.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.93.0.bb => rust-cross-canadian_1.94.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.93.0.bb => rust-llvm_1.94.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/rust-source.inc.orig
 rename recipes-devtools/rust/{rust_1.93.0.bb => rust_1.94.0.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 6c01a40..2e59aff 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERDEPENDS_scarthgap-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.93.0%"
+RUSTVERSION ?= "1.94.0%"
diff --git a/recipes-devtools/rust/cargo_1.93.0.bb b/recipes-devtools/rust/cargo_1.94.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.93.0.bb
rename to recipes-devtools/rust/cargo_1.94.0.bb
diff --git a/recipes-devtools/rust/files/0001-Update-call-llvm-intrinsics-test.patch b/recipes-devtools/rust/files/0001-Update-call-llvm-intrinsics-test.patch
new file mode 100644
index 0000000..9fa91c0
--- /dev/null
+++ b/recipes-devtools/rust/files/0001-Update-call-llvm-intrinsics-test.patch
@@ -0,0 +1,86 @@
+From 1d678f6b0859ea25c2abc22eb4104a025a5737e4 Mon Sep 17 00:00:00 2001
+From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
+Date: Mon, 2 Mar 2026 04:22:23 -0800
+Subject: [PATCH] Update call-llvm-intrinsics test for Rust 1.94.0 IR and
+ multi-target CI
+
+Rust 1.94 now passes constants directly to llvm.sqrt.f32 instead of
+storing/loading via the stack.
+
+- Updated the FileCheck pattern to match the new IR:
+    // CHECK: call float @llvm.sqrt.f32(float 4.000000e+00)
+  The test intent is unchanged: it still ensures the intrinsic is
+  emitted as a 'call' (not 'invoke').
+
+- Removed unnecessary local variables and Drop usage to work in
+  `#![no_core]` mode with minicore.
+
+- Added required crate attributes:
+    #![feature(no_core, lang_items)]
+    #![no_std]
+    #![no_core]
+
+- Replaced `//@ only-riscv64` (host-based execution) with explicit
+  revisions for:
+      riscv32gc-unknown-linux-gnu
+      riscv64gc-unknown-linux-gnu
+  This ensures deterministic multi-target coverage in CI without
+  relying on the host architecture.
+
+- Added `//@ needs-llvm-components: riscv` and
+  `//@ min-llvm-version: 21` for CI compatibility.
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/pull/153285]
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
+---
+ .../riscv-abi/call-llvm-intrinsics.rs         | 26 +++++++++----------
+ 1 file changed, 13 insertions(+), 13 deletions(-)
+
+diff --git a/tests/codegen-llvm/riscv-abi/call-llvm-intrinsics.rs b/tests/codegen-llvm/riscv-abi/call-llvm-intrinsics.rs
+index e72a649a530..fb520d38df3 100644
+--- a/tests/codegen-llvm/riscv-abi/call-llvm-intrinsics.rs
++++ b/tests/codegen-llvm/riscv-abi/call-llvm-intrinsics.rs
+@@ -1,17 +1,20 @@
++//@ add-minicore
+ //@ compile-flags: -C no-prepopulate-passes
+-
+-//@ only-riscv64
++//@ revisions: riscv32gc riscv64gc
++//@ [riscv32gc] compile-flags: --target riscv32gc-unknown-linux-gnu
++//@ [riscv32gc] needs-llvm-components: riscv
++//@ [riscv64gc] compile-flags: --target riscv64gc-unknown-linux-gnu
++//@ [riscv64gc] needs-llvm-components: riscv
++//@ min-llvm-version: 21
+
+ #![feature(link_llvm_intrinsics)]
++#![feature(no_core, lang_items)]
++#![no_std]
++#![no_core]
+ #![crate_type = "lib"]
+
+-struct A;
+-
+-impl Drop for A {
+-    fn drop(&mut self) {
+-        println!("A");
+-    }
+-}
++extern crate minicore;
++use minicore::*;
+
+ extern "C" {
+     #[link_name = "llvm.sqrt.f32"]
+@@ -19,12 +22,9 @@ fn drop(&mut self) {
+ }
+
+ pub fn do_call() {
+-    let _a = A;
+-
+     unsafe {
+         // Ensure that we `call` LLVM intrinsics instead of trying to `invoke` them
+-        // CHECK: store float 4.000000e+00, ptr %{{.}}, align 4
+-        // CHECK: call float @llvm.sqrt.f32(float %{{.}}
++        // CHECK: call float @llvm.sqrt.f32(float 4.000000e+00)
+         sqrt(4.0);
+     }
+ }
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index dc4ed9d..e96598f 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -10,7 +10,7 @@ Signed-off-by: Peter Tatrai <Peter.Tatrai@siemens.com>
 diff --git a/compiler/rustc_errors/src/markdown/tests/term.rs b/compiler/rustc_errors/src/markdown/tests/term.rs
 --- a/compiler/rustc_errors/src/markdown/tests/term.rs
 +++ b/compiler/rustc_errors/src/markdown/tests/term.rs
-@@ -62,6 +62,7 @@ fn test_wrapping_write() {
+@@ -60,6 +60,7 @@ fn test_wrapping_write() {
  }
 
  #[test]
@@ -119,7 +119,7 @@ diff --git a/library/test/src/tests.rs b/library/test/src/tests.rs
 diff --git a/library/std/tests/sync/mutex.rs b/library/std/tests/sync/mutex.rs
 --- a/library/std/tests/sync/mutex.rs
 +++ b/library/std/tests/sync/mutex.rs
-@@ -472,6 +472,7 @@
+@@ -440,6 +440,7 @@
  
  #[test]
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
@@ -127,7 +127,7 @@ diff --git a/library/std/tests/sync/mutex.rs b/library/std/tests/sync/mutex.rs
  fn test_mutex_arc_poison_mapped() {
      let arc = Arc::new(Mutex::new(1));
      assert!(!arc.is_poisoned());
-@@ -388,6 +389,7 @@
+@@ -457,6 +458,7 @@
  
  #[test]
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
@@ -230,30 +230,30 @@ diff --git a/library/std_detect/src/detect/os/linux/aarch64/tests.rs b/library/s
 index a3562f2fd93..d4e52ed91be 100644
 --- a/library/std_detect/src/detect/os/linux/aarch64/tests.rs
 +++ b/library/std_detect/src/detect/os/linux/aarch64/tests.rs
-@@ -27,6 +27,7 @@ fn baseline_hwcaps() -> AtHwcap {
-     }
- 
-     #[test]
-+    #[ignore]
-     fn linux_empty_hwcap2_aarch64() {
-         let file = concat!(
-             env!("CARGO_MANIFEST_DIR"),
-@@ -39,6 +40,7 @@ fn linux_empty_hwcap2_aarch64() {
-         assert_eq!(AtHwcap::from(v), baseline_hwcaps());
-     }
-     #[test]
-+    #[ignore]
-     fn linux_no_hwcap2_aarch64() {
-         let file = concat!(
-             env!("CARGO_MANIFEST_DIR"),
-@@ -51,6 +53,7 @@ fn linux_no_hwcap2_aarch64() {
-         assert_eq!(AtHwcap::from(v), baseline_hwcaps());
-     }
-     #[test]
-+    #[ignore]
-     fn linux_hwcap2_aarch64() {
-         let file =
-             concat!(env!("CARGO_MANIFEST_DIR"), "/src/detect/test_data/linux-hwcap2-aarch64.auxv");
+@@ -23,6 +23,7 @@ fn baseline_hwcaps() -> AtHwcap {
+ }
+
+ #[test]
++#[ignore]
+ fn linux_empty_hwcap2_aarch64() {
+     let file = concat!(
+         env!("CARGO_MANIFEST_DIR"),
+@@ -35,6 +36,7 @@ fn linux_empty_hwcap2_aarch64() {
+     assert_eq!(AtHwcap::from(v), baseline_hwcaps());
+ }
+ #[test]
++#[ignore]
+ fn linux_no_hwcap2_aarch64() {
+     let file =
+         concat!(env!("CARGO_MANIFEST_DIR"), "/src/detect/test_data/linux-no-hwcap2-aarch64.auxv");
+@@ -45,6 +47,7 @@ fn linux_no_hwcap2_aarch64() {
+     assert_eq!(AtHwcap::from(v), baseline_hwcaps());
+ }
+ #[test]
++#[ignore]
+ fn linux_hwcap2_aarch64() {
+     let file =
+         concat!(env!("CARGO_MANIFEST_DIR"), "/src/detect/test_data/linux-hwcap2-aarch64.auxv");
 diff --git a/tests/ui/no_std/simple-runs.rs b/tests/ui/no_std/simple-runs.rs
 index af44dfe..e6674e5 100644
 --- a/tests/ui/no_std/simple-runs.rs
diff --git a/recipes-devtools/rust/libstd-rs_1.93.0.bb b/recipes-devtools/rust/libstd-rs_1.94.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.93.0.bb
rename to recipes-devtools/rust/libstd-rs_1.94.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.93.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.94.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.93.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.94.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.93.0.bb b/recipes-devtools/rust/rust-llvm_1.94.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.93.0.bb
rename to recipes-devtools/rust/rust-llvm_1.94.0.bb
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rust/rust-snapshot.inc
index 7a0049c..cd4cce3 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,56 +4,58 @@
 ## The exact (previous) version that has been used is specified in the source tarball.
 ## The version is replicated here.
 
-SNAPSHOT_VERSION = "1.92.0"
-
-SRC_URI[rustc-snapshot-aarch64.sha256sum] = "7c8706fad4c038b5eacab0092e15db54d2b365d5f3323ca046fe987f814e7826"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] = "ce2ab42c09d633b0a8b4b65a297c700ae0fad47aae890f75894782f95be7e36d"
-SRC_URI[cargo-snapshot-aarch64.sha256sum] = "cb2ce6be6411b986e25c71ad8a813f9dfbe3461738136fd684e3644f8dd75df4"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] = "333ab38c673b589468b8293b525e5704fb52515d9d516ee28d3d34dd5a63d3c3"
-
-SRC_URI[rustc-snapshot-i686.sha256sum] = "c1c920cd59e255e5dcf844af22b80483fe4b04ff04f143be6da69314bd6733f8"
-SRC_URI[rust-std-snapshot-i686.sha256sum] = "abc840631a4462a4c8ec61341110ff653ab2ef86ef3b10f84489d00cc8a9310d"
-SRC_URI[cargo-snapshot-i686.sha256sum] = "63001bbde1c036fae9ad624807bfb18117c7e7cb4a04de81adc4acc7e8580c07"
-SRC_URI[clippy-snapshot-i686.sha256sum] = "f21090ddb01503ab7e326ff8b1ab44121611121e83572aa2dba2c5ceffe12d22"
-
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] = "6207ea209b332c01437fe742c2ef2bc914c88b6d4f9a23a43bc01ad924f6e4a8"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] = "62e2568ebf6f1addc750a8c32dd1fa4fef8d27679cbac33b837afeb54f204819"
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] = "32f4b393f1471d7d50c9a50512f02116187b3ea6a885c26ff2d74f87fa72baa8"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] = "70783e0b31682938db53b78f87c948acfe589e3ece5dee6ae6aa5b667a384f3c"
-
-SRC_URI[rustc-snapshot-powerpc.sha256sum] = "961cb6b8c2b5e969ad8eb0256fee43b88608b27310d946a7df3c9e9577139cae"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] = "c3e809a324b00eb53096c58df38645bb496c6560de334dfe04ed0b77c0605aaa"
-SRC_URI[cargo-snapshot-powerpc.sha256sum] = "1249c64f95d8187b3a89cf8429329bdbc98f53a9fc538e898c95c487e3234d90"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] = "93ed9fdd6fc2655c7789ed096d57a47178532b6bda1ec4480adca7920563e934"
-
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] = "357dd4745f978080d35dbb6192ecfea331abbb93d88be7d70407856b30722a40"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] = "2ce706afa4a46b6773340854de877fc63618a40e351298a4e3da8eb482619863"
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] = "e94a8f97c3143158e285b4f8ade1fae844961caca30c0eeed44f6c14da484f05"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] = "7912584254f455b90ed6ce6089c4efded33bb753d1bf948286ef2f4f782d2f30"
-
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] = "f48a214ff6fa36a77de8a0a2ee009be8aa48ba1533792450aca5edac29497606"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] = "eba59766c2d9805c0a1fc82fd723acbb36569e1bec1088c037bba84d965f70ba"
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] = "49dd01f5d10e3f368181223db0fbf7dc191161f7d80a295de4909bf87e53da58"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] = "873047278043e6506f5c98b8f633a9b96dc49ff83869a86a151fe5b1b9455044"
-
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] = "729f4c074ccda30bff493fa94f255bcfcec1be594fecd8a4d0f57da845121c64"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] = "8ee20dcf3b1063fa6069b3ce85e1fcf42794dfa783263314865cb53fff42d9e4"
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] = "e8708d0a929ad15941ecde368e8a156911927a805b492afafc737124b6aa55d4"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] = "bdedabeedd48080e6ef70376c52338fbb45ff80d1fbb12a81aa2d8cabbb706c8"
-
-SRC_URI[rustc-snapshot-s390x.sha256sum] = "6a8cf614a74f7469c70d32b378f0163633e6bbe19624b248b758501c5bcdfe84"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] = "ebf944dc95015498d322504a54e4f9cdb28590f7790aa3a9eb86d6cf4b6c93ff"
-SRC_URI[cargo-snapshot-s390x.sha256sum] = "a290edf359a5632dfda3b2325a309d9edeb58c97de97e3cc67274335b58adf05"
-SRC_URI[clippy-snapshot-s390x.sha256sum] = "41aa44f1cf37cac87b83e450eb19148c539ff266bb40dc146207ad5b9e1e1acc"
-
-SRC_URI[rustc-snapshot-x86_64.sha256sum] = "78b2dd9c6b1fcd2621fa81c611cf5e2d6950690775038b585c64f364422886e0"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] = "5f106805ed86ebf8df287039e53a45cf974391ef4d088c2760776b05b8e48b5d"
-SRC_URI[cargo-snapshot-x86_64.sha256sum] = "e5e12be2c7126a7036c8adf573078a28b92611f5767cc9bd0a6f7c83081df103"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] = "2c1bf6e7da8ec50feba03fe188fc9a744ba59e2c6ece7970c13e201d08defa9a"
-
-SRC_URI[rust-std-snapshot-i586.sha256sum] = "8b984b31ffca1f27d32ee77ec2cc4c2ab59e72beab67bfce13bbd926dbea8715"
-
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] = "d85afb14120c3c7367338a565a920db653dccd4bc5062398791d7b62b89fd1fd"
+SNAPSHOT_VERSION = "1.93.0"
+
+SRC_URI[rustc-snapshot-aarch64.sha256sum] = "1a9045695892ec08d8e9751bf7cf7db71fe27a6202dd12ce13aca48d0602dbde"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] = "84e82ff52c39c64dfd0e1c2d58fd3d5309d1d2502378131544c0d486b44af20a"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] = "5998940b8b97286bb67facb1a85535eeb3d4d7a61e36a85e386e5c0c5cfe5266"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] = "872ae6d68d625946d281b91d928332e6b74f6ab269b6af842338df4338805a60"
+
+SRC_URI[rustc-snapshot-i686.sha256sum] = "72038681a14fe632e2b550392b83dadf40325c472dabecfff40a9efdc2d8e201"
+SRC_URI[rust-std-snapshot-i686.sha256sum] = "b8b7020a61418b95c1ea26badaf8db6979778e28dbadddc81fb5010fe27c935b"
+SRC_URI[cargo-snapshot-i686.sha256sum] = "2c6fb5893b4abcdf6af9dc3c4f60abc072318b0cb13f2bd969585910b7ba048b"
+SRC_URI[clippy-snapshot-i686.sha256sum] = "e8f6b16356548e2dbad3d380c07cd7b3654b49c513a15a2ceb9d17a49ac0aa04"
+
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] = "d5762adb6e1dec7e6af4a7347cde45c12fec3f0ceba8a05aff6ef00390105739"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] = "4c5e2e8fcc43aced123283e3c8c99771c99750b5c7ecdf95a45258f5e26618b2"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] = "cf1af58dad1098c1f56d3df11f884b8d87b0db30ef038d1527872b7cdd7c9785"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] = "41f588aefa9e8bcdb4969afc14d18b19b4bd524defc026aca8c0275c19d183ac"
+
+SRC_URI[rustc-snapshot-powerpc.sha256sum] = "b31f5408c198756b57f0491961cf6dc84bfd96ff1c73627798015f27ecea6ef5"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] = "e851c0fa3e726ce3f7139c5803198a1aa9723594394734ac9e373c93d92e5ea3"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] = "f8472c773385820a9c8fe375f766b6918bb659eb2d517db72eff86a44c59546d"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] = "9f48807b761998db304ade11573742f52dcd61bf62f3e339eb9975ec33feab65"
+
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] = "b483c5324966b7138fb3f6180f7e4a2e9a5162179a83e58bb52d1ee5036009ee"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] = "f729bb7d95705e12a92eb072e494b93d8822ca40aa4802ca780b0cf33b56d401"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] = "662a9d454073c178c052bbb001f7440ded82134185c7c656ba8fc37468799383"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] = "2242d23c8472b4d7efe6e2e538157f0b25d9ac99f6362b2cd534ba5030b2a71f"
+
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] = "fa0705079ee9eeaeee2e4f12a3ffb35ccc3d4334cccd3eb3106a3f59b96e88aa"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] = "d209ac698a69ca9b9035adb97a0ed8e60a08db52960198c3e03b9ee714c1a46b"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] = "a587e9dab9385ea0651dd45a6cb6101d6028ccf578a3e1140ce083fe9419921a"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] = "283b76a665927a7737dbf422d3a3459eb85e873a49f6a2de8cc0ab5a5c3a8350"
+
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] = "804b19ccf61e8aec4c0c6d3f115961982b155d96925eb34b651aa7f6493a2e8b"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] = "b769fb6c9f3e0419a6bd0b7b79f9191bbd7a48a9f243b23eb7d135711aa6de1b"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] = "1f0fc840db26c426b26ce8a943b887756e9552974a39248ad0166960fa169f62"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] = "1c8bbbd36200f525949a2a3b1446ddc863b99bdc2552b818919fd64cc27b64d2"
+
+SRC_URI[rustc-snapshot-s390x.sha256sum] = "756c25d32d6539a7485a278216f3058c1571fd503c638e1179b74a68611dd1a4"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] = "41a65db45a288eb3eedb187b366f132d5b3615767de7ce994b123b342ac7a848"
+SRC_URI[cargo-snapshot-s390x.sha256sum] = "7d0281d26142bf124c0393a99e73b7b8ae6cb579cb7ebe50f696da6922d2129a"
+SRC_URI[clippy-snapshot-s390x.sha256sum] = "1cf85452916d4f5696d93e45849a99aba23884a3bd3d886d0179a1b2cf7d2858"
+
+SRC_URI[rustc-snapshot-x86_64.sha256sum] = "00c6e6740ea6a795e33568cd7514855d58408a1180cd820284a7bbf7c46af715"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] = "a849a418d0f27e69573e41763c395e924a0b98c16fcdc55599c1c79c27c1c777"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] = "c23de3ae709ff33eed5e4ae59d1f9bcd75fa4dbaa9fb92f7b06bfb534b8db880"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] = "793108977514b15c0f45ade28ae35c58b05370cb0f22e89bd98fdfa61eabf55d"
+
+SRC_URI[rust-std-snapshot-i586.sha256sum] = "03534ebbd698f7580cfb08798a7451e86bd9ec46327f4b41ccf2c2f8f1998438"
+
+SRC_URI[rust-std-snapshot-riscv64a23.sha256sum] = "2a625e37c5b943c6c63dad7f52187572d1a65854e3950a8fa26e593f8231d711"
+
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] = "360f0a4eb41c3cd3792dbe756c0c5b5a36a5b41e3771b8a12d5bbc97bf51fdd3"
 
 SRC_URI += " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=rust-std-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index c5e5f6e..e0a6190 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -8,8 +8,9 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
             file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
+            file://0001-Update-call-llvm-intrinsics-test.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "e30d898272c587a22f77679f03c5e8192b5645c7c9ccc3407ad1106761507cea"
+SRC_URI[rust.sha256sum] = "0b53ae34f5c0c3612cfe1de139f9167a018cd5737bc2205664fd69ba9b25f600"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust-source.inc.orig b/recipes-devtools/rust/rust-source.inc.orig
deleted file mode 100644
index 6a9b922..0000000
--- a/recipes-devtools/rust/rust-source.inc.orig
+++ /dev/null
@@ -1,17 +0,0 @@
-RUST_VERSION ?= "${@d.getVar('PV').split('-')[0]}"
-
-SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;name=rust \
-            file://0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch;patchdir=${RUSTSRC} \
-            file://rust-oe-selftest.patch;patchdir=${RUSTSRC} \
-            file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=${RUSTSRC} \
-            file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=${RUSTSRC} \
-            file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
-            file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
-            file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
-"
-SRC_URI[rust.sha256sum] = "ebee170bfe4c4dfc59521a101de651e5534f4dae889756a5c97ca9ea40d0c307"
-
-RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
-
-UPSTREAM_CHECK_URI = "https://forge.rust-lang.org/infra/other-installation-methods.html"
-UPSTREAM_CHECK_REGEX = "rustc-(?P<pver>\d+(\.\d+)+)-src"
diff --git a/recipes-devtools/rust/rust_1.93.0.bb b/recipes-devtools/rust/rust_1.94.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.93.0.bb
rename to recipes-devtools/rust/rust_1.94.0.bb
-- 
2.55.0


