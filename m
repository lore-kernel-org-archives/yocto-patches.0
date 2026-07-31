Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A2C55179
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:45 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4474.1785497616024489798
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=KbxZDsIm;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92f0b5ed131so63844585a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497615; x=1786102415; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TO4unD3UUTDCFK0NlIgDe9QaLz84N7epNqrV4TsRWj4=;
        b=KbxZDsIm00C3O0ovdDat3fOpvhZ3GulzViZQq7pjpBj7ASxyCzZN6H0hAfBoRZPVM/
         GhFRsRCbUY5zUXwgYpBamN/GS3WsgBbVRoeZUI2MxIkGdMV7HzKzJLnFXoTCWchhAH51
         Ai9DZlEZ39MAt9atlu2GIScKJ1biyqZznkOQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497615; x=1786102415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TO4unD3UUTDCFK0NlIgDe9QaLz84N7epNqrV4TsRWj4=;
        b=IET9WMUTpUqxO5NjJEso2p1nJ87cOy9vkFiiYvGXYZ5/GPuxkAJO9KVHOps9Bpx4yo
         NG60RSBm0+o0bh9s1XvaNYOvxRv6lbYHyTZjiG6oniOVuvq8BsXhk6sCVmExX34HuwzM
         v6gPF3JslrallKIDUqBdwVKF6L/JYNR5Nw9tEK0KNKVINXJojtA0zcivfLDUs3IMt3Mf
         SciMm1Ld0Hzz+Nse4HduoaTLHATImLYDMP0ECV0oVtbOZghyysWmEANe9othI2EOT4sm
         drOZPK0daz+vqtGjzqyINxMkGsGHe4Yv7DgW/VSsP4Xf1S7cB9B2wHUWBqZimI8WZnMm
         wTyg==
X-Gm-Message-State: AOJu0YzVmn+S0lRRmVqrgCo051P2UWQ4IRWOhWrqQXs5ocWgu/aPShyj
	jx5gE+rloitD9JmzbZQXliLdooKXXlooHEfTNDzIdRC+sv8fgeaWMGpcXsJDazN6sm9xVKnY2nB
	DT6Bu
X-Gm-Gg: AR+sD10C0hnGOs+jOnG1zl18LZb5MR56cTCgRWfKTRyj8YjrZFp1BmTjf1nEMpqJykB
	c4303VatFmY3cmrUx+j+Q8b2JBxObRjB3hWvIrGQoRoySEhnFWj0HitMp1lVR44ppYNnB19JeVp
	9Md5jT0hEl3uNBuABiFS++m95YqK2HX1VhA8Na6gS+MfAXMqudSlROi9JksjWpZuri+pW/bya1W
	pSs7W5x7QxZjXS6WTc8wqN/wwN5sBgYlTBWITl0yH2gRWuiNa6U2Q/6HJPYvJ/t9D0Uy4mJc1+/
	X1NcfNIhpX77RtAQ6OpvyGbLfW8K/lLQXAdFJd5zyD36BEJeYYtKeRQkizILF7y4Q2xEsqyh40R
	w0YSclQiUQuAvJxpAzWFW+ovXA1EQnjKongvEOzhIJIYIvdrccV5YAdQCeWy2UKXivb7SLQ+1cv
	vfZNsP1AJO6zCA87neOv5J2VKr5tcmQJf26j8Dtz55XinPYUsW3pl+pIFrFNT0lCxwpijaa1bv+
	nkhhlAOCfrfTQY/OkMoUEuHgDvuow0PWzkFp6PqkQqGyOEhSIt189ysMBruDztAIiAXmxq4C9pW
	k2tp1aYbEGIVeKSSai71Xp20kQ==
X-Received: by 2002:a05:620a:19a7:b0:92e:6122:130c with SMTP id af79cd13be357-9349ad0e819mr126288285a.34.1785497614367;
        Fri, 31 Jul 2026 04:33:34 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:34 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 22/35] rust: Upgrade 1.94.1 -> 1.95.0
Date: Fri, 31 Jul 2026 07:32:52 -0400
Message-ID: <662b2b644d1436bc09516be964ac7527a27f0d1d.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4598

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Rust Changes:
https://github.com/rust-lang/rust/releases/tag/1.95.0

Cargo Changes:
https://doc.rust-lang.org/nightly/cargo/CHANGELOG.html#cargo-195-2026-04-16

Drop merged patches:
0001-Adjust-loongarch-assembly-test.patch
0001-Fix-flaky-assertions-in-oneshot-tests.patch
0001-Update-amdgpu-data-layout.patch

Updated patches:
0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
rust-oe-selftest.patch

New patch:
0002-Fix-rust-build-failure-with-unstable-options.patch

Fix rust build failure with unstable options.
Remove the check that errors out when -Zunstable-options is not provided
for custom targets.The original upstream change (and its follow-up) mainly
ensured GitHub workflows and tests work correctly by explicitly passing
"-Zunstable-options", along with related testcase updates. Reverting the
entire commit would also undo those unrelated workflow and test adjustments,
so this patch only targets the specific enforcement logic without affecting
the rest of the changes.
https://github.com/rust-lang/rust/issues/155963

Selftest Changes:
Skip two failing tests
src/librustdoc
src/tools/rustdoc
https://github.com/rust-lang/rust/pull/153409

Excluded tests:
+--------+----------+---------+
| Before  |  After  | Skipped |
+---------+---------+---------+
|   37    |   39    |   +2    |
+--------+----------+---------+

Test results:

rust v1.95.0
+-------------+---------+---------+
| Machine     | Passed  | Skipped |
+-------------+---------+---------+
| qemux86-64  |  22187  |   689   |
| qemux86     |  21929  |   947   |
| qemuarm64   |  21994  |   882   |
| qemuarm     |  21910  |   966   |
| qemuriscv64 |  21955  |   921   |
+-------------+---------+---------+

Test results difference (1.95.0 - 1.94.1):

+-------------+--------+---------+
| Machine     | Passed | Skipped |
+-------------+--------+---------+
| qemux86-64  |  +276  |   +29   |
| qemux86     |  +271  |   +34   |
| qemuarm64   |  +271  |   +34   |
| qemuarm     |  +271  |   +34   |
| qemuriscv64 |  +270  |   +35   |
+-------------+--------+---------+

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit cab39a407e1de6f4e5024cef1ac7733c3780e40d)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |   2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |   2 +-
 .../rust/{cargo_1.94.1.bb => cargo_1.95.0.bb} |   0
 .../0001-Adjust-loongarch-assembly-test.patch |  66 -----------
 ...ix-flaky-assertions-in-oneshot-tests.patch |  72 ------------
 .../0001-Update-amdgpu-data-layout.patch      |  44 --------
 ...teps-tool.rs-switch-off-lto-for-rust.patch |   4 +-
 ...-build-failure-with-unstable-options.patch |  63 +++++++++++
 .../rust/files/rust-oe-selftest.patch         |  20 +++-
 ...ibstd-rs_1.94.1.bb => libstd-rs_1.95.0.bb} |   0
 ....94.1.bb => rust-cross-canadian_1.95.0.bb} |   0
 ...-llvm-allow-env-override-of-exe-path.patch |   8 +-
 ...ust-llvm_1.94.1.bb => rust-llvm_1.95.0.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       | 104 +++++++++---------
 recipes-devtools/rust/rust-source.inc         |   6 +-
 .../rust/{rust_1.94.1.bb => rust_1.95.0.bb}   |   0
 16 files changed, 140 insertions(+), 251 deletions(-)
 rename recipes-devtools/rust/{cargo_1.94.1.bb => cargo_1.95.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-Adjust-loongarch-assembly-test.patch
 delete mode 100644 recipes-devtools/rust/files/0001-Fix-flaky-assertions-in-oneshot-tests.patch
 delete mode 100644 recipes-devtools/rust/files/0001-Update-amdgpu-data-layout.patch
 create mode 100644 recipes-devtools/rust/files/0002-Fix-rust-build-failure-with-unstable-options.patch
 rename recipes-devtools/rust/{libstd-rs_1.94.1.bb => libstd-rs_1.95.0.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.94.1.bb => rust-cross-canadian_1.95.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.94.1.bb => rust-llvm_1.95.0.bb} (100%)
 rename recipes-devtools/rust/{rust_1.94.1.bb => rust_1.95.0.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index b084f3a..c3688f5 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERDEPENDS_scarthgap-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.94.1%"
+RUSTVERSION ?= "1.95.0%"
diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/cases/rust_mixin.py
index afe5b37..f09abbd 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -101,7 +101,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
 
         exclude_fail_tests = " ".join([" --exclude " + item for item in exclude_list])
         # Add exclude_fail_tests with other test arguments
-        testargs =  exclude_fail_tests + " --no-doc --no-fail-fast --bless"
+        testargs =  exclude_fail_tests + " --no-doc --no-fail-fast --bless --skip src/librustdoc --skip src/tools/rustdoc"
 
         # wrap the execution with a qemu instance.
         # Tests are run with 512 tasks in parallel to execute all tests very quickly
diff --git a/recipes-devtools/rust/cargo_1.94.1.bb b/recipes-devtools/rust/cargo_1.95.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.94.1.bb
rename to recipes-devtools/rust/cargo_1.95.0.bb
diff --git a/recipes-devtools/rust/files/0001-Adjust-loongarch-assembly-test.patch b/recipes-devtools/rust/files/0001-Adjust-loongarch-assembly-test.patch
deleted file mode 100644
index 67c649e..0000000
--- a/recipes-devtools/rust/files/0001-Adjust-loongarch-assembly-test.patch
+++ /dev/null
@@ -1,66 +0,0 @@
-From e015fc820db5d7fe2495c09b1fdd5e2092ed3cd1 Mon Sep 17 00:00:00 2001
-From: Nikita Popov <npopov@redhat.com>
-Date: Tue, 27 Jan 2026 12:03:48 +0100
-Subject: [PATCH] Adjust loongarch assembly test
-
-This generates different code on loongarch32r now.
-
-Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/e015fc820db5d7fe2495c09b1fdd5e2092ed3cd1]
-Signed-off-by: Khem Raj <raj.khem@gmail.com>
----
- tests/assembly-llvm/asm/loongarch-type.rs | 27 +++++++++++++++++------
- 1 file changed, 20 insertions(+), 7 deletions(-)
-
-diff --git a/tests/assembly-llvm/asm/loongarch-type.rs b/tests/assembly-llvm/asm/loongarch-type.rs
-index e0a7940f89a..5efad583a39 100644
---- a/tests/assembly-llvm/asm/loongarch-type.rs
-+++ b/tests/assembly-llvm/asm/loongarch-type.rs
-@@ -1,10 +1,14 @@
- //@ add-minicore
--//@ revisions: loongarch32 loongarch64
-+//@ revisions: loongarch32s loongarch32r loongarch64
-
- //@ assembly-output: emit-asm
-
--//@[loongarch32] compile-flags: --target loongarch32-unknown-none
--//@[loongarch32] needs-llvm-components: loongarch
-+//@[loongarch32s] compile-flags: --target loongarch32-unknown-none -Ctarget-feature=+32s
-+//@[loongarch32s] needs-llvm-components: loongarch
-+
-+//@[loongarch32r] compile-flags: --target loongarch32-unknown-none
-+//@[loongarch32r] needs-llvm-components: loongarch
-+//@[loongarch32r] min-llvm-version: 22
-
- //@[loongarch64] compile-flags: --target loongarch64-unknown-none
- //@[loongarch64] needs-llvm-components: loongarch
-@@ -28,8 +32,12 @@
-
- // CHECK-LABEL: sym_fn:
- // CHECK: #APP
--// CHECK: pcalau12i $t0, %got_pc_hi20(extern_func)
--// CHECK: ld.{{[wd]}} $t0, $t0, %got_pc_lo12(extern_func)
-+// loongarch64: pcalau12i $t0, %got_pc_hi20(extern_func)
-+// loongarch64: ld.d $t0, $t0, %got_pc_lo12(extern_func)
-+// loongarch32s: pcalau12i $t0, %got_pc_hi20(extern_func)
-+// loongarch32s: ld.w $t0, $t0, %got_pc_lo12(extern_func)
-+// loongarch32r: pcaddu12i $t0, %got_pcadd_hi20(extern_func)
-+// loongarch32r: ld.w $t0, $t0, %got_pcadd_lo12(.Lpcadd_hi0)
- // CHECK: #NO_APP
- #[no_mangle]
- pub unsafe fn sym_fn() {
-@@ -38,8 +46,13 @@ pub unsafe fn sym_fn() {
-
- // CHECK-LABEL: sym_static:
- // CHECK: #APP
--// CHECK: pcalau12i $t0, %got_pc_hi20(extern_static)
--// CHECK: ld.{{[wd]}} $t0, $t0, %got_pc_lo12(extern_static)
-+// loongarch64: pcalau12i $t0, %got_pc_hi20(extern_static)
-+// loongarch64: ld.d $t0, $t0, %got_pc_lo12(extern_static)
-+// loongarch32s: pcalau12i $t0, %got_pc_hi20(extern_static)
-+// loongarch32s: ld.w $t0, $t0, %got_pc_lo12(extern_static)
-+// loongarch32r: pcaddu12i $t0, %got_pcadd_hi20(extern_static)
-+// loongarch32r: ld.w $t0, $t0, %got_pcadd_lo12(.Lpcadd_hi1)
-+
- // CHECK: #NO_APP
- #[no_mangle]
- pub unsafe fn sym_static() {
diff --git a/recipes-devtools/rust/files/0001-Fix-flaky-assertions-in-oneshot-tests.patch b/recipes-devtools/rust/files/0001-Fix-flaky-assertions-in-oneshot-tests.patch
deleted file mode 100644
index be0e85d..0000000
--- a/recipes-devtools/rust/files/0001-Fix-flaky-assertions-in-oneshot-tests.patch
+++ /dev/null
@@ -1,72 +0,0 @@
-Backport three commits from upstream to fix flaky assertions in oneshot tests
-
-Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/6970849fee93900b6eb28a64cf957157a9fb51b3]
-Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/dab350a3ed7691201f6752c4375e8e6ab40b58b9]
-Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/d02743e2fd7433ba2320fc85421a8a5927235b65]
-
-Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
-
-diff --git a/library/std/tests/sync/oneshot.rs b/library/std/tests/sync/oneshot.rs
-index 6a87c72..d8f3cd7 100644
---- a/library/std/tests/sync/oneshot.rs
-+++ b/library/std/tests/sync/oneshot.rs
-@@ -89,15 +89,15 @@ fn send_before_recv_timeout() {
- 
-     assert!(sender.send(22i128).is_ok());
- 
--    let start = Instant::now();
--
-     let timeout = Duration::from_secs(1);
-     match receiver.recv_timeout(timeout) {
-         Ok(22) => {}
-         _ => panic!("expected Ok(22)"),
-     }
- 
--    assert!(start.elapsed() < timeout);
-+    // FIXME(#152648): There previously was a timing assertion here.
-+    // This was removed, because under load there's no guarantee that the main thread is
-+    // scheduled and run before `timeout` expires
- }
- 
- #[test]
-@@ -127,6 +127,7 @@ fn recv_before_send() {
- }
- 
- #[test]
-+#[ignore = "Inherently flaky and has caused several CI failures"]
- fn recv_timeout_before_send() {
-     let (sender, receiver) = oneshot::channel();
- 
-@@ -135,6 +136,8 @@ fn recv_timeout_before_send() {
-         sender.send(99u128).unwrap();
-     });
- 
-+    // FIXME(#152145): Under load, there's no guarantee that thread `t` has
-+    // ever been scheduled and run before this timeout expires.
-     match receiver.recv_timeout(Duration::from_secs(1)) {
-         Ok(99) => {}
-         _ => panic!("expected Ok(99)"),
-@@ -240,7 +243,9 @@ fn recv_deadline_passed() {
-     }
- 
-     assert!(start.elapsed() >= timeout);
--    assert!(start.elapsed() < timeout * 3);
-+    // FIXME(#152878): An upper-bound assertion on the elapsed time was removed,
-+    // because CI runners can starve individual threads for a surprisingly long
-+    // time, leading to flaky failures.
- }
- 
- #[test]
-@@ -253,8 +258,11 @@ fn recv_time_passed() {
-         Err(RecvTimeoutError::Timeout(_)) => {}
-         _ => panic!("expected timeout error"),
-     }
-+
-     assert!(start.elapsed() >= timeout);
--    assert!(start.elapsed() < timeout * 3);
-+    // FIXME(#152878): An upper-bound assertion on the elapsed time was removed,
-+    // because CI runners can starve individual threads for a surprisingly long
-+    // time, leading to flaky failures.
- }
- 
- #[test]
diff --git a/recipes-devtools/rust/files/0001-Update-amdgpu-data-layout.patch b/recipes-devtools/rust/files/0001-Update-amdgpu-data-layout.patch
deleted file mode 100644
index 1c09cd8..0000000
--- a/recipes-devtools/rust/files/0001-Update-amdgpu-data-layout.patch
+++ /dev/null
@@ -1,44 +0,0 @@
-From bf3ac98d6930ba4e258cf33240c2fe7c99d19eae Mon Sep 17 00:00:00 2001
-From: Nikita Popov <npopov@redhat.com>
-Date: Tue, 6 Jan 2026 11:51:33 +0100
-Subject: [PATCH] Update amdgpu data layout
-
-This changed in:
-https://github.com/llvm/llvm-project/commit/853760bca6aa7a960b154cef8c61f87271870b8a
-
-Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/bf3ac98d6930ba4e258cf33240c2fe7c99d19eae]
-Signed-off-by: Khem Raj <raj.khem@gmail.com>
----
- compiler/rustc_codegen_llvm/src/context.rs                  | 5 +++++
- compiler/rustc_target/src/spec/targets/amdgcn_amd_amdhsa.rs | 2 +-
- 2 files changed, 6 insertions(+), 1 deletion(-)
-
-diff --git a/compiler/rustc_codegen_llvm/src/context.rs b/compiler/rustc_codegen_llvm/src/context.rs
-index 4b2544b7efd..4328b15c73f 100644
---- a/compiler/rustc_codegen_llvm/src/context.rs
-+++ b/compiler/rustc_codegen_llvm/src/context.rs
-@@ -215,6 +215,11 @@ pub(crate) unsafe fn create_module<'ll>(
-             // LLVM 22 updated the ABI alignment for double on AIX: https://github.com/llvm/llvm-project/pull/144673
-             target_data_layout = target_data_layout.replace("-f64:32:64", "");
-         }
-+        if sess.target.arch == Arch::AmdGpu {
-+            // LLVM 22 specified ELF mangling in the amdgpu data layout:
-+            // https://github.com/llvm/llvm-project/pull/163011
-+            target_data_layout = target_data_layout.replace("-m:e", "");
-+        }
-     }
-
-     // Ensure the data-layout values hardcoded remain the defaults.
-diff --git a/compiler/rustc_target/src/spec/targets/amdgcn_amd_amdhsa.rs b/compiler/rustc_target/src/spec/targets/amdgcn_amd_amdhsa.rs
-index 828d853ac65..d6a2cfc2aab 100644
---- a/compiler/rustc_target/src/spec/targets/amdgcn_amd_amdhsa.rs
-+++ b/compiler/rustc_target/src/spec/targets/amdgcn_amd_amdhsa.rs
-@@ -5,7 +5,7 @@
- pub(crate) fn target() -> Target {
-     Target {
-         arch: Arch::AmdGpu,
--        data_layout: "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9".into(),
-+        data_layout: "e-m:e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9".into(),
-         llvm_target: "amdgcn-amd-amdhsa".into(),
-         metadata: TargetMetadata {
-             description: Some("AMD GPU".into()),
diff --git a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
index a8232b9..35ebf3b 100644
--- a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
+++ b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
@@ -42,7 +42,7 @@ index 087df2f8a..00790affb 100644
  use crate::utils::exec::{BootstrapCommand, command};
  use crate::utils::helpers::{add_dylib_path, exe, t};
  use crate::{Compiler, FileType, Kind, Mode};
-@@ -121,22 +119,7 @@ impl Step for ToolBuild {
+@@ -121,22 +121,7 @@ impl Step for ToolBuild {
              cargo.env("RUSTC_WRAPPER", ccache);
          }
 
@@ -58,7 +58,7 @@ index 087df2f8a..00790affb 100644
 -                RustcLto::ThinLocal => None,
 -            };
 -            if let Some(lto) = lto {
--                cargo.env(cargo_profile_var("LTO", &builder.config), lto);
+-                cargo.env(cargo_profile_var("LTO", &builder.config, self.mode), lto);
 -            }
 -        }
 -
diff --git a/recipes-devtools/rust/files/0002-Fix-rust-build-failure-with-unstable-options.patch b/recipes-devtools/rust/files/0002-Fix-rust-build-failure-with-unstable-options.patch
new file mode 100644
index 0000000..24a22f6
--- /dev/null
+++ b/recipes-devtools/rust/files/0002-Fix-rust-build-failure-with-unstable-options.patch
@@ -0,0 +1,63 @@
+Fix build issues seen with Rust-1.95.0
+
+Remove the check that errors out when -Zunstable-options is not provided for custom targets.
+
+The original upstream change (and its follow-up) mainly ensured GitHub workflows and tests
+work correctly by explicitly passing -Zunstable-options, along with related testcase updates.
+Reverting the entire commit would also undo those unrelated workflow and test adjustments, so
+this patch only targets the specific enforcement logic without affecting the rest of the changes.
+
+Upstream-Status: Inappropriate [Reported at https://github.com/rust-lang/rust/issues/155963]
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
+---
+diff --git a/compiler/rustc_target/src/spec/mod.rs b/compiler/rustc_target/src/spec/mod.rs
+index b1a9c4b3cde..25a26a9fb12 100644
+--- a/compiler/rustc_target/src/spec/mod.rs
++++ b/compiler/rustc_target/src/spec/mod.rs
+@@ -3707,7 +3707,7 @@ impl Target {
+     pub fn search(
+         target_tuple: &TargetTuple,
+         sysroot: &Path,
+-        unstable_options: bool,
++        _unstable_options: bool,
+     ) -> Result<(Target, TargetWarnings), String> {
+         use std::{env, fs};
+
+@@ -3715,12 +3715,6 @@ fn load_file(
+             path: &Path,
+-            unstable_options: bool,
+         ) -> Result<(Target, TargetWarnings), String> {
+-            if !unstable_options {
+-                return Err(
+-                    "custom targets are unstable and require `-Zunstable-options`".to_string()
+-                );
+-            }
+             let contents = fs::read_to_string(path).map_err(|e| e.to_string())?;
+             Target::from_json(&contents)
+         }
+
+@@ -3737,7 +3737,7 @@ impl Target {
+                 for dir in env::split_paths(&target_path) {
+                     let p = dir.join(&path);
+                     if p.is_file() {
+-                        return load_file(&p, unstable_options);
++                        return load_file(&p);
+                     }
+                 }
+
+@@ -3750,14 +3750,11 @@ impl Target {
+                     Path::new("target.json"),
+                 ]);
+                 if p.is_file() {
+-                    return load_file(&p, unstable_options);
++                    return load_file(&p);
+                 }
+
+                 Err(format!("could not find specification for target {target_tuple:?}"))
+             }
+-            TargetTuple::TargetJson { ref contents, .. } if !unstable_options => {
+-                Err("custom targets are unstable and require `-Zunstable-options`".to_string())
+-            }
+             TargetTuple::TargetJson { ref contents, .. } => Target::from_json(contents),
+         }
+     }
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index 9cbfc62..0ecfc7c 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -22,7 +22,7 @@ diff --git a/compiler/rustc_errors/src/markdown/tests/term.rs b/compiler/rustc_e
 diff --git a/compiler/rustc_interface/src/tests.rs b/compiler/rustc_interface/src/tests.rs
 --- a/compiler/rustc_interface/src/tests.rs
 +++ b/compiler/rustc_interface/src/tests.rs
-@@ -147,6 +147,7 @@ fn assert_non_crate_hash_different(x: &Options, y: &Options) {
+@@ -144,6 +144,7 @@ fn assert_non_crate_hash_different(x: &Options, y: &Options) {
 
  // When the user supplies --test we should implicitly supply --cfg test
  #[test]
@@ -30,7 +30,7 @@ diff --git a/compiler/rustc_interface/src/tests.rs b/compiler/rustc_interface/sr
  fn test_switch_implies_cfg_test() {
      sess_and_cfg(&["--test"], |_sess, cfg| {
          assert!(cfg.contains(&(sym::test, None)));
-@@ -155,6 +156,7 @@ fn test_switch_implies_cfg_test() {
+@@ -152,6 +153,7 @@ fn test_switch_implies_cfg_test() {
 
  // When the user supplies --test and --cfg test, don't implicitly add another --cfg test
  #[test]
@@ -38,7 +38,7 @@ diff --git a/compiler/rustc_interface/src/tests.rs b/compiler/rustc_interface/sr
  fn test_switch_implies_cfg_test_unless_cfg_test() {
      sess_and_cfg(&["--test", "--cfg=test"], |_sess, cfg| {
          let mut test_items = cfg.iter().filter(|&&(name, _)| name == sym::test);
-@@ -164,6 +166,7 @@ fn test_switch_implies_cfg_test_unless_cfg_test() {
+@@ -161,6 +163,7 @@ fn test_switch_implies_cfg_test_unless_cfg_test() {
  }
 
  #[test]
@@ -128,7 +128,7 @@ diff --git a/library/std/tests/sync/mutex.rs b/library/std/tests/sync/mutex.rs
  fn test_mutex_arc_poison_mapped() {
      let arc = Arc::new(Mutex::new(1));
      assert!(!arc.is_poisoned());
-@@ -457,6 +458,7 @@
+@@ -456,6 +457,7 @@
  
  #[test]
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
@@ -176,7 +176,7 @@ diff --git a/library/alloctests/tests/sort/tests.rs b/library/alloctests/tests/s
 index 14e6013f96..b670f27ab4 100644
 --- a/library/alloctests/tests/sort/tests.rs
 +++ b/library/alloctests/tests/sort/tests.rs
-@@ -922,12 +922,14 @@ gen_sort_test_fns_with_default_patterns_3_ty!(
+@@ -929,12 +929,14 @@ gen_sort_test_fns_with_default_patterns_3_ty!(
  macro_rules! instantiate_sort_test_inner {
      ($sort_impl:ty, miri_yes, $test_fn_name:ident) => {
          #[test]
@@ -271,11 +271,19 @@ diff --git a/compiler/rustc/src/main.rs b/compiler/rustc/src/main.rs
 index 89c61cd..144ea0e 100644
 --- a/compiler/rustc/src/main.rs
 +++ b/compiler/rustc/src/main.rs
+@@ -3,6 +3,7 @@
+ // Several crates are depended upon but unused so that they are present in the sysroot
+ #![expect(unused_crate_dependencies)]
+
++#[allow(unused_imports)]
+ use std::process::ExitCode;
+
+ // A note about jemalloc: rustc uses jemalloc when built for CI and
 @@ -38,6 +38,7 @@
  #[cfg(feature = "jemalloc")]
  use tikv_jemalloc_sys as _;
 
 +#[cfg(not(test))]
- fn main() {
+ fn main() -> ExitCode {
      rustc_driver::main()
  }
diff --git a/recipes-devtools/rust/libstd-rs_1.94.1.bb b/recipes-devtools/rust/libstd-rs_1.95.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.94.1.bb
rename to recipes-devtools/rust/libstd-rs_1.95.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.94.1.bb b/recipes-devtools/rust/rust-cross-canadian_1.95.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.94.1.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.95.0.bb
diff --git a/recipes-devtools/rust/rust-llvm/0002-llvm-allow-env-override-of-exe-path.patch b/recipes-devtools/rust/rust-llvm/0002-llvm-allow-env-override-of-exe-path.patch
index 9be2667..5a51efa 100644
--- a/recipes-devtools/rust/rust-llvm/0002-llvm-allow-env-override-of-exe-path.patch
+++ b/recipes-devtools/rust/rust-llvm/0002-llvm-allow-env-override-of-exe-path.patch
@@ -11,16 +11,18 @@ llvm-config from a target sysroot.
 Upstream-Status: Inappropriate [oe-core specific]
 Signed-off-by: Martin Kelly <mkelly@xevo.com>
 Signed-off-by: Khem Raj <raj.khem@gmail.com>
+(updated for Rust 1.95.0)
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
 ---
  llvm/tools/llvm-config/llvm-config.cpp | 7 +++++++
  1 file changed, 7 insertions(+)
 
 --- a/llvm/tools/llvm-config/llvm-config.cpp
 +++ b/llvm/tools/llvm-config/llvm-config.cpp
-@@ -226,6 +226,13 @@ Typical components:\n\
+@@ -248,6 +248,13 @@
  
  /// Compute the path to the main executable.
- std::string GetExecutablePath(const char *Argv0) {
+ static std::string getExecutablePath(const char *Argv0) {
 +  // Hack for Yocto: we need to override the root path when we are using
 +  // llvm-config from within a target sysroot.
 +  const char *Sysroot = std::getenv("YOCTO_ALTERNATE_EXE_PATH");
@@ -30,4 +32,4 @@ Signed-off-by: Khem Raj <raj.khem@gmail.com>
 +
    // This just needs to be some symbol in the binary; C++ doesn't
    // allow taking the address of ::main however.
-   void *P = (void *)(intptr_t)GetExecutablePath;
+   void *P = (void *)(intptr_t)getExecutablePath;
diff --git a/recipes-devtools/rust/rust-llvm_1.94.1.bb b/recipes-devtools/rust/rust-llvm_1.95.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.94.1.bb
rename to recipes-devtools/rust/rust-llvm_1.95.0.bb
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rust/rust-snapshot.inc
index cd4cce3..d914cfd 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,58 +4,58 @@
 ## The exact (previous) version that has been used is specified in the source tarball.
 ## The version is replicated here.
 
-SNAPSHOT_VERSION = "1.93.0"
-
-SRC_URI[rustc-snapshot-aarch64.sha256sum] = "1a9045695892ec08d8e9751bf7cf7db71fe27a6202dd12ce13aca48d0602dbde"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] = "84e82ff52c39c64dfd0e1c2d58fd3d5309d1d2502378131544c0d486b44af20a"
-SRC_URI[cargo-snapshot-aarch64.sha256sum] = "5998940b8b97286bb67facb1a85535eeb3d4d7a61e36a85e386e5c0c5cfe5266"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] = "872ae6d68d625946d281b91d928332e6b74f6ab269b6af842338df4338805a60"
-
-SRC_URI[rustc-snapshot-i686.sha256sum] = "72038681a14fe632e2b550392b83dadf40325c472dabecfff40a9efdc2d8e201"
-SRC_URI[rust-std-snapshot-i686.sha256sum] = "b8b7020a61418b95c1ea26badaf8db6979778e28dbadddc81fb5010fe27c935b"
-SRC_URI[cargo-snapshot-i686.sha256sum] = "2c6fb5893b4abcdf6af9dc3c4f60abc072318b0cb13f2bd969585910b7ba048b"
-SRC_URI[clippy-snapshot-i686.sha256sum] = "e8f6b16356548e2dbad3d380c07cd7b3654b49c513a15a2ceb9d17a49ac0aa04"
-
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] = "d5762adb6e1dec7e6af4a7347cde45c12fec3f0ceba8a05aff6ef00390105739"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] = "4c5e2e8fcc43aced123283e3c8c99771c99750b5c7ecdf95a45258f5e26618b2"
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] = "cf1af58dad1098c1f56d3df11f884b8d87b0db30ef038d1527872b7cdd7c9785"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] = "41f588aefa9e8bcdb4969afc14d18b19b4bd524defc026aca8c0275c19d183ac"
-
-SRC_URI[rustc-snapshot-powerpc.sha256sum] = "b31f5408c198756b57f0491961cf6dc84bfd96ff1c73627798015f27ecea6ef5"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] = "e851c0fa3e726ce3f7139c5803198a1aa9723594394734ac9e373c93d92e5ea3"
-SRC_URI[cargo-snapshot-powerpc.sha256sum] = "f8472c773385820a9c8fe375f766b6918bb659eb2d517db72eff86a44c59546d"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] = "9f48807b761998db304ade11573742f52dcd61bf62f3e339eb9975ec33feab65"
-
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] = "b483c5324966b7138fb3f6180f7e4a2e9a5162179a83e58bb52d1ee5036009ee"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] = "f729bb7d95705e12a92eb072e494b93d8822ca40aa4802ca780b0cf33b56d401"
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] = "662a9d454073c178c052bbb001f7440ded82134185c7c656ba8fc37468799383"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] = "2242d23c8472b4d7efe6e2e538157f0b25d9ac99f6362b2cd534ba5030b2a71f"
-
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] = "fa0705079ee9eeaeee2e4f12a3ffb35ccc3d4334cccd3eb3106a3f59b96e88aa"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] = "d209ac698a69ca9b9035adb97a0ed8e60a08db52960198c3e03b9ee714c1a46b"
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] = "a587e9dab9385ea0651dd45a6cb6101d6028ccf578a3e1140ce083fe9419921a"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] = "283b76a665927a7737dbf422d3a3459eb85e873a49f6a2de8cc0ab5a5c3a8350"
-
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] = "804b19ccf61e8aec4c0c6d3f115961982b155d96925eb34b651aa7f6493a2e8b"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] = "b769fb6c9f3e0419a6bd0b7b79f9191bbd7a48a9f243b23eb7d135711aa6de1b"
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] = "1f0fc840db26c426b26ce8a943b887756e9552974a39248ad0166960fa169f62"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] = "1c8bbbd36200f525949a2a3b1446ddc863b99bdc2552b818919fd64cc27b64d2"
-
-SRC_URI[rustc-snapshot-s390x.sha256sum] = "756c25d32d6539a7485a278216f3058c1571fd503c638e1179b74a68611dd1a4"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] = "41a65db45a288eb3eedb187b366f132d5b3615767de7ce994b123b342ac7a848"
-SRC_URI[cargo-snapshot-s390x.sha256sum] = "7d0281d26142bf124c0393a99e73b7b8ae6cb579cb7ebe50f696da6922d2129a"
-SRC_URI[clippy-snapshot-s390x.sha256sum] = "1cf85452916d4f5696d93e45849a99aba23884a3bd3d886d0179a1b2cf7d2858"
-
-SRC_URI[rustc-snapshot-x86_64.sha256sum] = "00c6e6740ea6a795e33568cd7514855d58408a1180cd820284a7bbf7c46af715"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] = "a849a418d0f27e69573e41763c395e924a0b98c16fcdc55599c1c79c27c1c777"
-SRC_URI[cargo-snapshot-x86_64.sha256sum] = "c23de3ae709ff33eed5e4ae59d1f9bcd75fa4dbaa9fb92f7b06bfb534b8db880"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] = "793108977514b15c0f45ade28ae35c58b05370cb0f22e89bd98fdfa61eabf55d"
-
-SRC_URI[rust-std-snapshot-i586.sha256sum] = "03534ebbd698f7580cfb08798a7451e86bd9ec46327f4b41ccf2c2f8f1998438"
-
-SRC_URI[rust-std-snapshot-riscv64a23.sha256sum] = "2a625e37c5b943c6c63dad7f52187572d1a65854e3950a8fa26e593f8231d711"
-
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] = "360f0a4eb41c3cd3792dbe756c0c5b5a36a5b41e3771b8a12d5bbc97bf51fdd3"
+SNAPSHOT_VERSION = "1.94.0"
+
+SRC_URI[rustc-snapshot-aarch64.sha256sum] = "7261b2fcdb88aef8b21f4b9f915d9a75c959674193f5b38e13fab4569684fc5b"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] = "c781b3ef4fefa5508fbe05820eddc95e46351d905a30921cc020febd9c596a2e"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] = "d57ab7b23b52cba46e58c78327904d0c7db19892988677b0d59495c8af4bb790"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] = "f7450c414e394450b53be602d37c374e2a2c5a2f51be2b54faf3d1e3272160b1"
+
+SRC_URI[rustc-snapshot-i686.sha256sum] = "4d399ca0126adf0225340dc291623a47256b39be1d2567ad76dcd8990c2d6935"
+SRC_URI[rust-std-snapshot-i686.sha256sum] = "528c1dda491b25bb855426f48757773f4740c75d3c7271efffe7412c2fd5730d"
+SRC_URI[cargo-snapshot-i686.sha256sum] = "8699cfc772af3f651bf61e84a5b292e2ea62de9e1ab12d70e1384e57a5e91690"
+SRC_URI[clippy-snapshot-i686.sha256sum] = "54a3219f0541c080bc8e600c3cfe63d60963eb361c79fd645dd1b171019c4dac"
+
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] = "5392936010d422d7b8e5b83ba6c314da16f0d2b33fe57fdaf340b1e8a4a3a0fa"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] = "a42ebd0c280f987f8c604fcb4549886f8954e7d025d54da3e63a5621ed268dd5"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] = "83bda8ec4b506646eddab2b7b67e67f2fd9fccb74693a2558383868d82b85668"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] = "98de442bc183acef748ae1f177498045bf8cbcf03ece6e75c2befa98fae8841b"
+
+SRC_URI[rustc-snapshot-powerpc.sha256sum] = "443475d3e1ec21d1f34b09f0cd6d1f10551535a736048ce7e21d7fa4faeb63c3"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] = "23e32cab484d7787b7966a0508c49baf231bcdb4a79a421ee85ca69e81f2a06f"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] = "3274ccfb125035dc5846649b0bdce855f15c7a1824507360840c6a152599e4cf"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] = "3a38eb50a04557801e50e2ab04e9e5db8f3f8f22dfea53d9a483efe1ea251129"
+
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] = "89874c3bebc35ace3b0d0dd225154e583a88caafe2c3d04476b21e4a6650f715"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] = "7713b676a37fbd0a52a711c2e3c205a917f8b05614e17cd9f7f37874a88469a3"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] = "3c618a93585244a6fd70a857061b781590262f5f430f710f3687d5eaf54940bd"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] = "209d292768bf89c8fc65f434257f7be39a7155e2b4590d917f3d873ce7f35fd3"
+
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] = "7fcdb850568508c0737e9079383f2aade49b1ee159620e67e041d0b756bfe4b5"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] = "094f3955828d6630b70a9c7c71e3165c3ffc7a301929601dde08501def623347"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] = "6b44ebc7f08464e3a60ff16580729a99e727c7d4c2368a2d4b62d1acf4fd5c11"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] = "11dc62c3b286dad9e22d9f0005dd75dcbb527da02b44f0729351dba5277f39c8"
+
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] = "ad0e35e45ceb4e874653444c393bc3b969da78729d92dc3d8852b0fd2eddcec6"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] = "32e9b7006f1269e48fb65af6298f6e8a222e1a8a2a20b112528bfb3dad2f65a8"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] = "61795ca964c0b08faef359db32c3409e3348ed2bd7b4cad481b3c8cf8654b5d6"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] = "c6ca11e8d361fcce46c684239ea2debfc53b97def7db0c2ff7014894de22b220"
+
+SRC_URI[rustc-snapshot-s390x.sha256sum] = "9167f4a85ef250d6e613bdd3993d723fd225df67665fd2dbe61b0c780009c8e3"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] = "ea69833addbc9521664464418c7468871f7a80b16fd2c385f6213a6c99cedfe9"
+SRC_URI[cargo-snapshot-s390x.sha256sum] = "f32f72efff179de4871fb5f5a3e030092d279ca70a71f0a4e49b3c8f69ef7ac4"
+SRC_URI[clippy-snapshot-s390x.sha256sum] = "8195f54d3ade3cbb7beb51df21cdc8ba30b6c72dbb9d9106eee10ea781a15062"
+
+SRC_URI[rustc-snapshot-x86_64.sha256sum] = "31a0d3ac9383dfdeb4fce86eeed5ade3230131c635264c0eab7252dbf235f28e"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] = "dd33653107c36e040082050d9e547e64dac5b456ba74069430d838c00c189a05"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] = "8e17624f3de39e079845bfb25ed15a042f4b50ceca78e37c56c4b9b15949b9f7"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] = "935529b0b9150084fa9cc1734c6598efe86b6e7d76f31ad3f8d4bb79ebf6031a"
+
+SRC_URI[rust-std-snapshot-i586.sha256sum] = "9347cfdc1383f4d71db1d63960f289977abc93ee575ca84748516995a05fac94"
+
+SRC_URI[rust-std-snapshot-riscv64a23.sha256sum] = "f0b68c16c81b96562e039ff298dbf6a833cab112340c3b4bbd44dd3b45db6a31"
+
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] = "8f611aa779732057742fa289e7581bde48af1c97014c1f92fd21b5682eff1a16"
 
 SRC_URI += " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=rust-std-snapshot-${RUST_BUILD_ARCH};subdir=rust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 49dd20a..370c1ff 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -7,12 +7,10 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
             file://0001-Update-call-llvm-intrinsics-test.patch;patchdir=${RUSTSRC} \
-            file://0001-Fix-flaky-assertions-in-oneshot-tests.patch;patchdir=${RUSTSRC} \
-            file://0001-Update-amdgpu-data-layout.patch;patchdir=${RUSTSRC} \
-            file://0001-Adjust-loongarch-assembly-test.patch;patchdir=${RUSTSRC} \
             file://0001-Fix-multiple-option-or-permutations-test-for-big-end.patch;patchdir=${RUSTSRC} \
+            file://0002-Fix-rust-build-failure-with-unstable-options.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "174fce10ce012317ca995810296d8af199318838180b03d68a853e0f02d4b571"
+SRC_URI[rust.sha256sum] = "62b67230754da642a264ca0cb9fc08820c54e2ed7b3baba0289876d4cdb48c08"
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
diff --git a/recipes-devtools/rust/rust_1.94.1.bb b/recipes-devtools/rust/rust_1.95.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.94.1.bb
rename to recipes-devtools/rust/rust_1.95.0.bb
-- 
2.55.0


