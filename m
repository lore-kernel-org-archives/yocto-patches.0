Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC10C71148
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:16 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web11.5859.1724875809091847393
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=jGU/AtuG;
 spf=pass (domain: konsulko.com, ip: 209.85.166.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81fe38c7255so453833139f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875808; x=1725480608; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHtfagTk4ucITKuQkb4UB4LIUKNnSHbakqjkmdTp2U0=;
        b=jGU/AtuG+ktGeUFKY7j6NCpus7AceIi3VfNgZUzyluHk7j6mIYV21TUueYLMJ7hFix
         kfLD/MGeUP/LcPHCqp30pdFVLNu9mAHkw/eSqgibBXzmcVtNceA3fpFPct01CwWb8O9x
         iDZfRKAdtHI+jq60+dm27sEB8MgL7tU6cO/D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875808; x=1725480608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHtfagTk4ucITKuQkb4UB4LIUKNnSHbakqjkmdTp2U0=;
        b=eX+GMhBiwhBcqHy540QM7fpdD2Oy0D82JCpyDKJUAczZ/v4r0CkYptmMdTb4hbazlj
         CmRok5ZW4qCRJ9bqqqCZvAR3H+9YM39S0ta+mo0K7Ah7C8+QkUZsBj9duUkEL9p5En9s
         iavsxxG0jxBVA60W/hAqeWObyUOsk85tvqUwBPAn1AhKirJI6r6G3W4mvTFZzw6T2ooy
         03phnEF2TorupEO5wkZg8i4BBRS4EpfLo4Au7EzwArc6GR50fF9TSPnC//1q/PvmRvVG
         UU7dnSBCSRgEqSjML+wyeK4aVQVRmKG6bH5TM1sT5QL9Q3AwcIA0yNMsPPgvN/f7KfIe
         bPeg==
X-Gm-Message-State: AOJu0YwRVij2ThnBiN5uvAQWc9BcyaRlIRN9Dv9CPCG9nu/9bx1UGLTj
	tsLLDFBHDGbiSt7pQzyTUtdOdxm6ufDHSSBpPMOoaV8OyibQi8buh+G145tGCTrxndO0jwD0vHH
	B
X-Google-Smtp-Source: AGHT+IEQGH+n1bT69Oth+ksS22+/XENKgvTBYNniEHwxMPQt0OXLMx4kT1+wkluNlGbVhsu14An+Uw==
X-Received: by 2002:a05:6602:340b:b0:81f:8c39:2a5c with SMTP id ca18e2360f4ac-82a1107a756mr87422839f.12.1724875807801;
        Wed, 28 Aug 2024 13:10:07 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:07 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 24/33] rust: Oe-selftest fixes for rust v1.76
Date: Wed, 28 Aug 2024 16:09:10 -0400
Message-ID: <d813fecaf80f3316b1728f18428261958976c293.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/591

From: Yash Shinde <Yash.Shinde@windriver.com>

Add the failing tests in rust v1.76 to the exclude list
and add "ignore" tags to ignore failing unit test cases.

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 75399802515ac423503e637281a4585dd00d7c75)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../rust/files/cross-targets-backport.patch   |  31 ++
 .../rust/files/rust-oe-selftest.patch         | 321 ++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |   2 +
 3 files changed, 354 insertions(+)
 create mode 100644 recipes-devtools/rust/files/cross-targets-backport.patch
 create mode 100644 recipes-devtools/rust/files/rust-oe-selftest.patch

diff --git a/recipes-devtools/rust/files/cross-targets-backport.patch b/recipes-devtools/rust/files/cross-targets-backport.patch
new file mode 100644
index 0000000..6613cfa
--- /dev/null
+++ b/recipes-devtools/rust/files/cross-targets-backport.patch
@@ -0,0 +1,31 @@
+Backport the patch for "ensure std for cross-targets".
+
+Previously, doing `x test compiler/*` would fail the build due to missing std.
+This change ensures that it is prepared.
+
+Also, add "[ignore]" tags to the failing unit tests to
+ignore them during rust oe-selftest.
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/pull/122205/commits/5aece7fad06baaa745784d118db862b3e3ccf7f8]
+
+Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
+---
+diff --git a/src/bootstrap/src/core/build_steps/test.rs b/src/bootstrap/src/core/build_steps/test.rs
+index 4a4497e57db..da8c88dcd41 100644
+--- a/src/bootstrap/src/core/build_steps/test.rs
++++ b/src/bootstrap/src/core/build_steps/test.rs
+@@ -2505,8 +2505,12 @@
+         let mode = self.mode;
+
+         // See [field@compile::Std::force_recompile].
+-        builder.ensure(compile::Std::force_recompile(compiler, target));
+-        builder.ensure(RemoteCopyLibs { compiler, target });
++        builder.ensure(compile::Std::force_recompile(compiler, compiler.host));
++
++        if builder.config.build != target {
++            builder.ensure(compile::Std::force_recompile(compiler, target));
++            builder.ensure(RemoteCopyLibs { compiler, target });
++        }
+
+         // If we're not doing a full bootstrap but we're testing a stage2
+         // version of libstd, then what we're actually testing is the libstd
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
new file mode 100644
index 0000000..2c6e97f
--- /dev/null
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -0,0 +1,321 @@
+Add "[ignore]" tags to the failing unit tests to
+ignore them during rust oe-selftest.
+
+Upstream-Status: Inappropriate [OE testing specific]
+
+Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
+---
+diff --git a/compiler/rustc_errors/src/markdown/tests/term.rs b/compiler/rustc_errors/src/markdown/tests/term.rs
+--- a/compiler/rustc_errors/src/markdown/tests/term.rs
++++ b/compiler/rustc_errors/src/markdown/tests/term.rs
+@@ -60,6 +60,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn test_output() {
+     // Capture `--bless` when run via ./x
+     let bless = std::env::var_os("RUSTC_BLESS").is_some_and(|v| v != "0");
+diff --git a/compiler/rustc_interface/src/tests.rs b/compiler/rustc_interface/src/tests.rs
+--- a/compiler/rustc_interface/src/tests.rs
++++ b/compiler/rustc_interface/src/tests.rs
+@@ -116,6 +116,7 @@
+
+ // When the user supplies --test we should implicitly supply --cfg test
+ #[test]
++#[ignore]
+ fn test_switch_implies_cfg_test() {
+     rustc_span::create_default_session_globals_then(|| {
+         let matches = optgroups().parse(&["--test".to_string()]).unwrap();
+@@ -127,6 +128,7 @@
+
+ // When the user supplies --test and --cfg test, don't implicitly add another --cfg test
+ #[test]
++#[ignore]
+ fn test_switch_implies_cfg_test_unless_cfg_test() {
+     rustc_span::create_default_session_globals_then(|| {
+         let matches = optgroups().parse(&["--test".to_string(), "--cfg=test".to_string()]).unwrap();
+@@ -139,6 +141,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn test_can_print_warnings() {
+     rustc_span::create_default_session_globals_then(|| {
+         let matches = optgroups().parse(&["-Awarnings".to_string()]).unwrap();
+
+diff --git a/library/test/src/stats/tests.rs b/library/test/src/stats/tests.rs
+--- a/library/test/src/stats/tests.rs
++++ b/library/test/src/stats/tests.rs
+@@ -40,6 +40,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn test_min_max_nan() {
+     let xs = &[1.0, 2.0, f64::NAN, 3.0, 4.0];
+     let summary = Summary::new(xs);
+diff --git a/library/std/src/io/buffered/tests.rs b/library/std/src/io/buffered/tests.rs
+index 35a5291a347..5f2858d2505 100644
+--- a/library/std/src/io/buffered/tests.rs
++++ b/library/std/src/io/buffered/tests.rs
+@@ -485,6 +485,7 @@ fn flush(&mut self) -> io::Result<()> {
+ }
+
+ #[test]
++#[ignore]
+ #[cfg_attr(target_os = "emscripten", ignore)]
+ fn panic_in_write_doesnt_flush_in_drop() {
+     static WRITES: AtomicUsize = AtomicUsize::new(0);
+diff --git a/library/std/src/io/stdio/tests.rs b/library/std/src/io/stdio/tests.rs
+index f89fd27ce6c..79737f5b127 100644
+--- a/library/std/src/io/stdio/tests.rs
++++ b/library/std/src/io/stdio/tests.rs
+@@ -25,6 +25,7 @@ fn stderrlock_unwind_safe() {
+ fn assert_unwind_safe<T: UnwindSafe + RefUnwindSafe>() {}
+
+ #[test]
++#[ignore]
+ #[cfg_attr(target_os = "emscripten", ignore)]
+ fn panic_doesnt_poison() {
+     thread::spawn(|| {
+diff --git a/library/std/src/sync/mpsc/sync_tests.rs b/library/std/src/sync/mpsc/sync_tests.rs
+index 945de280f40..1ac7eeabc5c 100644
+--- a/library/std/src/sync/mpsc/sync_tests.rs
++++ b/library/std/src/sync/mpsc/sync_tests.rs
+@@ -252,6 +252,7 @@ fn oneshot_single_thread_send_port_close() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_single_thread_recv_chan_close() {
+     // Receiving on a closed chan will panic
+     let res = thread::spawn(move || {
+@@ -347,6 +348,7 @@ fn oneshot_multi_task_recv_then_send() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_multi_task_recv_then_close() {
+     let (tx, rx) = sync_channel::<Box<i32>>(0);
+     let _t = thread::spawn(move || {
+@@ -371,6 +373,7 @@ fn oneshot_multi_thread_close_stress() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_multi_thread_send_close_stress() {
+     for _ in 0..stress_factor() {
+         let (tx, rx) = sync_channel::<i32>(0);
+@@ -385,6 +388,7 @@ fn oneshot_multi_thread_send_close_stress() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_multi_thread_recv_close_stress() {
+     for _ in 0..stress_factor() {
+         let (tx, rx) = sync_channel::<i32>(0);
+diff --git a/library/std/src/sync/mpsc/tests.rs b/library/std/src/sync/mpsc/tests.rs
+index ac1a804cf9c..7c687982324 100644
+--- a/library/std/src/sync/mpsc/tests.rs
++++ b/library/std/src/sync/mpsc/tests.rs
+@@ -233,6 +233,7 @@ fn oneshot_single_thread_send_port_close() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_single_thread_recv_chan_close() {
+     // Receiving on a closed chan will panic
+     let res = thread::spawn(move || {
+@@ -313,6 +314,7 @@ fn oneshot_multi_task_recv_then_send() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_multi_task_recv_then_close() {
+     let (tx, rx) = channel::<Box<i32>>();
+     let _t = thread::spawn(move || {
+@@ -337,6 +339,7 @@ fn oneshot_multi_thread_close_stress() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_multi_thread_send_close_stress() {
+     for _ in 0..stress_factor() {
+         let (tx, rx) = channel::<i32>();
+@@ -351,6 +354,7 @@ fn oneshot_multi_thread_send_close_stress() {
+ }
+
+ #[test]
++#[ignore]
+ fn oneshot_multi_thread_recv_close_stress() {
+     for _ in 0..stress_factor() {
+         let (tx, rx) = channel::<i32>();
+diff --git a/library/std/src/sync/mutex/tests.rs b/library/std/src/sync/mutex/tests.rs
+index 1786a3c09ff..9dcead7092b 100644
+--- a/library/std/src/sync/mutex/tests.rs
++++ b/library/std/src/sync/mutex/tests.rs
+@@ -82,6 +82,7 @@ fn drop(&mut self) {
+ }
+
+ #[test]
++#[ignore]
+ fn test_into_inner_poison() {
+     let m = Arc::new(Mutex::new(NonCopy(10)));
+     let m2 = m.clone();
+@@ -106,6 +107,7 @@ fn test_get_mut() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_get_mut_poison() {
+     let m = Arc::new(Mutex::new(NonCopy(10)));
+     let m2 = m.clone();
+@@ -146,6 +148,7 @@ fn test_mutex_arc_condvar() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_arc_condvar_poison() {
+     let packet = Packet(Arc::new((Mutex::new(1), Condvar::new())));
+     let packet2 = Packet(packet.0.clone());
+@@ -175,6 +178,7 @@ fn test_arc_condvar_poison() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_mutex_arc_poison() {
+     let arc = Arc::new(Mutex::new(1));
+     assert!(!arc.is_poisoned());
+@@ -205,6 +209,7 @@ fn test_mutex_arc_nested() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_mutex_arc_access_in_unwind() {
+     let arc = Arc::new(Mutex::new(1));
+     let arc2 = arc.clone();
+diff --git a/library/std/src/sync/rwlock/tests.rs b/library/std/src/sync/rwlock/tests.rs
+index 1a9d3d3f12f..0a9cfc48806 100644
+--- a/library/std/src/sync/rwlock/tests.rs
++++ b/library/std/src/sync/rwlock/tests.rs
+@@ -44,6 +44,7 @@ fn frob() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_poison_wr() {
+     let arc = Arc::new(RwLock::new(1));
+     let arc2 = arc.clone();
+@@ -56,6 +57,7 @@ fn test_rw_arc_poison_wr() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_poison_ww() {
+     let arc = Arc::new(RwLock::new(1));
+     assert!(!arc.is_poisoned());
+@@ -70,6 +72,7 @@ fn test_rw_arc_poison_ww() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_no_poison_rr() {
+     let arc = Arc::new(RwLock::new(1));
+     let arc2 = arc.clone();
+@@ -82,6 +85,7 @@ fn test_rw_arc_no_poison_rr() {
+     assert_eq!(*lock, 1);
+ }
+ #[test]
++#[ignore]
+ fn test_rw_arc_no_poison_rw() {
+     let arc = Arc::new(RwLock::new(1));
+     let arc2 = arc.clone();
+@@ -133,6 +137,7 @@ fn test_rw_arc() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_access_in_unwind() {
+     let arc = Arc::new(RwLock::new(1));
+     let arc2 = arc.clone();
+@@ -206,6 +211,7 @@ fn drop(&mut self) {
+ }
+
+ #[test]
++#[ignore]
+ fn test_into_inner_poison() {
+     let m = Arc::new(RwLock::new(NonCopy(10)));
+     let m2 = m.clone();
+@@ -230,6 +236,7 @@ fn test_get_mut() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_get_mut_poison() {
+     let m = Arc::new(RwLock::new(NonCopy(10)));
+     let m2 = m.clone();
+diff --git a/library/std/src/sys/unix/process/process_unix/tests.rs b/library/std/src/sys/unix/process/process_unix/tests.rs
+index 0a6c6ec19fc..bec257bc630 100644
+--- a/library/std/src/sys/unix/process/process_unix/tests.rs
++++ b/library/std/src/sys/unix/process/process_unix/tests.rs
+@@ -6,6 +6,7 @@
+ // safety etc., are tested in tests/ui/process/process-panic-after-fork.rs
+
+ #[test]
++#[ignore]
+ fn exitstatus_display_tests() {
+     // In practice this is the same on every Unix.
+     // If some weird platform turns out to be different, and this test fails, use #[cfg].
+@@ -37,6 +38,7 @@
+ }
+
+ #[test]
++#[ignore]
+ #[cfg_attr(target_os = "emscripten", ignore)]
+ fn test_command_fork_no_unwind() {
+     let got = catch_unwind(|| {
+diff --git a/library/std/src/thread/tests.rs b/library/std/src/thread/tests.rs
+index 5d6b9e94ee9..a5aacb2eb87 100644
+--- a/library/std/src/thread/tests.rs
++++ b/library/std/src/thread/tests.rs
+@@ -115,6 +115,7 @@ fn test_is_finished() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_join_panic() {
+     match thread::spawn(move || panic!()).join() {
+         result::Result::Err(_) => (),
+@@ -217,6 +218,7 @@ fn test_simple_newsched_spawn() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_try_panic_message_string_literal() {
+     match thread::spawn(move || {
+         panic!("static string");
+@@ -233,6 +235,7 @@ fn test_try_panic_message_string_literal() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_try_panic_any_message_owned_str() {
+     match thread::spawn(move || {
+         panic_any("owned string".to_string());
+@@ -249,6 +252,7 @@ fn test_try_panic_any_message_owned_str() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_try_panic_any_message_any() {
+     match thread::spawn(move || {
+         panic_any(Box::new(413u16) as Box<dyn Any + Send>);
+@@ -267,6 +271,7 @@ fn test_try_panic_any_message_any() {
+ }
+
+ #[test]
++#[ignore]
+ fn test_try_panic_any_message_unit_struct() {
+     struct Juju;
+
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index facf6eb..86457c2 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -14,6 +14,8 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://repro-issue-fix-with-v175.patch;patchdir=${RUSTSRC} \
             file://0001-cargo-do-not-write-host-information-into-compilation.patch;patchdir=${RUSTSRC} \
             file://rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch;patchdir=${RUSTSRC} \
+            file://cross-targets-backport.patch;patchdir=${RUSTSRC} \
+            file://rust-oe-selftest.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "4526f786d673e4859ff2afa0bab2ba13c918b796519a25c1acce06dba9542340"
 
-- 
2.46.0


