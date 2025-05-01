Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C18C369DC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 22:16:14 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web10.6715.1746137766243509346
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 15:16:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nwC229Q5;
 spf=pass (domain: konsulko.com, ip: 209.85.219.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8f94c2698so8963766d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 15:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746137765; x=1746742565; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+n/jI5C3O5f6mnbC8LXviTxW039ZYf4pH5mQ5n7J9I=;
        b=nwC229Q5Qi3Cv1X81Bdch0m1lKQIeZTrsywj9TaFcjmt5ZJY5SKrN37mn8sI3kits2
         gyc8gGlRHSn4abaD4ZC3PXRnzSvFbUK4Y3VdioCKciZwnkUaFKq268lkzajXXiqFUsXl
         +DEOiff4yT7udTuYpg40/vMTdxe8NmTNkBZGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137765; x=1746742565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+n/jI5C3O5f6mnbC8LXviTxW039ZYf4pH5mQ5n7J9I=;
        b=Dw4CmqgTfB2cw1Wd2rpYx7PixrW0KBgxz8kijYtsFBimIcNPnBHRACk2E0TPNK0fPR
         gRXYvA24G3LpsPzfZ40eO2pX7OpdQk7z9F76qLhbnATADwht5oV56RDrpacelcFVNIFs
         chN5CiiegMO389Dw297YUlEv57mYNzHYOwKOQmF2aoEWGjHfohbO9WdCh73pcg91E66f
         QHv1s2jdfeYrEuWJ4FVn710BaDELvPfFUm9jbZdru0y0qxaB4ALOzcpeVsu58AwXXPKm
         UJUIUGMVV2pUAPR4nOKkZb7ohbllTQ9xweK6fiu3e0epX5wBdA7q8nDqihRcDC8TWseS
         O4UQ==
X-Gm-Message-State: AOJu0Yw5C8LqMdUqlonFn1EMGLFYw8PZu30PgcShTL7i3PoFhUv7DWmv
	oF7JcC10doo+b+BPfS2yFQoaEh7olNrvKuzHulLZ2EI10MRqsOhr9LJQgO3TqTNapUKNwL4AjAe
	G
X-Gm-Gg: ASbGnctjEG/RKHOmZ1dnbz6lYtVprftgpDVl5BqgxzOwoQGdQTSOihegA+o7cAKP813
	r2CE7Detdd6uoZLhO8pMoOP0W9opPA9vBUitbEJR6oN6/XhTgQTdSJVjTqcWIJ0UZ56nvSIj6N1
	lY5j2pSWvm6HvXHt0mds5ZVh7PT6UORb4WcyM5FPtukpIpZlG03uksy1F2kAZlp/6/lwZE9n15B
	yv2BMvKRSNJeK8ph8cRZBRdjymvdR29DJ473yrXIrJrFxu1SW05ODBwLEte4t0YlpHkMrvSa5Wn
	NKCaRB9s5jazU1QRCIL51JgeErfRhXW8drbDcZJ1umLSlfnPPs86MIdWjXpgNknd+2AtqQqvBJ4
	L+PRE64A7snwGd2jg
X-Google-Smtp-Source: AGHT+IHdJd7GuvajLrMU3KQT5Y/Wuz9vvdQnbOQVp55Vd/+uKqCWLNwv6rMR4pwniXIJ8Bonbl2OHA==
X-Received: by 2002:a05:6214:130f:b0:6ea:d393:962b with SMTP id 6a1803df08f44-6f515485b86mr14213776d6.22.1746137765005;
        Thu, 01 May 2025 15:16:05 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c3329sm9975366d6.28.2025.05.01.15.16.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:16:04 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 5/7] rust: re-enable the unit tests that are ignored
Date: Thu,  1 May 2025 18:15:41 -0400
Message-ID: <434e4c4a85751faf4f6f6942e76b5fce048d2c6f.1746137462.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746137462.git.scott.murray@konsulko.com>
References: <cover.1746137462.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 22:16:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1471

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Some unit tests were previously marked as ignored due to failures in earlier
versions of Rust. With the upgrade to Rust 1.85.1, these tests are now passing
consistently. They've been re-enabled and verified to run successfully on the
latest version.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 775108f131412122beb2b844dc5e2a4d47ce3b89)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../rust/files/rust-oe-selftest.patch         | 95 -------------------
 1 file changed, 95 deletions(-)

diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index 2cca850..4a8760a 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -43,77 +43,6 @@ diff --git a/compiler/rustc_interface/src/tests.rs b/compiler/rustc_interface/sr
  fn test_can_print_warnings() {
      sess_and_cfg(&["-Awarnings"], |sess, _cfg| {
          assert!(!sess.dcx().can_emit_warnings());
-diff --git a/library/test/src/stats/tests.rs b/library/test/src/stats/tests.rs
---- a/library/test/src/stats/tests.rs
-+++ b/library/test/src/stats/tests.rs
-@@ -40,6 +40,7 @@
- }
-
- #[test]
-+#[ignore]
- fn test_min_max_nan() {
-     let xs = &[1.0, 2.0, f64::NAN, 3.0, 4.0];
-     let summary = Summary::new(xs);
-diff --git a/library/std/src/io/buffered/tests.rs b/library/std/src/io/buffered/tests.rs
-index 35a5291a347..5f2858d2505 100644
---- a/library/std/src/io/buffered/tests.rs
-+++ b/library/std/src/io/buffered/tests.rs
-@@ -488,6 +488,7 @@ fn flush(&mut self) -> io::Result<()> {
- }
-
- #[test]
-+#[ignore]
- #[cfg_attr(any(target_os = "emscripten", target_os = "wasi"), ignore)] // no threads
- fn panic_in_write_doesnt_flush_in_drop() {
-     static WRITES: AtomicUsize = AtomicUsize::new(0);
-diff --git a/library/std/src/io/stdio/tests.rs b/library/std/src/io/stdio/tests.rs
-index f89fd27ce6c..79737f5b127 100644
---- a/library/std/src/io/stdio/tests.rs
-+++ b/library/std/src/io/stdio/tests.rs
-@@ -25,6 +25,7 @@ fn stderrlock_unwind_safe() {
- fn assert_unwind_safe<T: UnwindSafe + RefUnwindSafe>() {}
-
- #[test]
-+#[ignore]
- #[cfg_attr(any(target_os = "emscripten", target_os = "wasi"), ignore)] // no threads
- fn panic_doesnt_poison() {
-     thread::spawn(|| {
-diff --git a/library/std/src/sync/mpsc/sync_tests.rs b/library/std/src/sync/mpsc/sync_tests.rs
-index 945de280f40..1ac7eeabc5c 100644
---- a/library/std/src/sync/mpsc/sync_tests.rs
-+++ b/library/std/src/sync/mpsc/sync_tests.rs
-@@ -252,6 +252,7 @@ fn oneshot_single_thread_send_port_close() {
- }
-
- #[test]
-+#[ignore]
- fn oneshot_single_thread_recv_chan_close() {
-     // Receiving on a closed chan will panic
-     let res = thread::spawn(move || {
-@@ -347,6 +348,7 @@ fn oneshot_multi_task_recv_then_send() {
- }
-
- #[test]
-+#[ignore]
- fn oneshot_multi_task_recv_then_close() {
-     let (tx, rx) = sync_channel::<Box<i32>>(0);
-     let _t = thread::spawn(move || {
-@@ -371,6 +373,7 @@ fn oneshot_multi_thread_close_stress() {
- }
-
- #[test]
-+#[ignore]
- fn oneshot_multi_thread_send_close_stress() {
-     for _ in 0..stress_factor() {
-         let (tx, rx) = sync_channel::<i32>(0);
-@@ -385,6 +388,7 @@ fn oneshot_multi_thread_send_close_stress() {
- }
-
- #[test]
-+#[ignore]
- fn oneshot_multi_thread_recv_close_stress() {
-     for _ in 0..stress_factor() {
-         let (tx, rx) = sync_channel::<i32>(0);
 diff --git a/library/std/src/sync/mpsc/tests.rs b/library/std/src/sync/mpsc/tests.rs
 index ac1a804cf9c..7c687982324 100644
 --- a/library/std/src/sync/mpsc/tests.rs
@@ -402,14 +331,6 @@ index 160af8a65d..686f4607bb 100644
  fn smoke() {
      let value = 12u32;
      let reference = &value;
-@@ -28,6 +29,7 @@ fn smoke() {
- }
-
- #[test]
-+#[ignore]
- fn stable_hash_hashes_as_tuple() {
-     let hash_packed = {
-         let mut hasher = StableHasher::new();
 diff --git a/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs b/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs
 index 4d342c72cc..9a77f92616 100644
 --- a/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs
@@ -422,22 +343,6 @@ index 4d342c72cc..9a77f92616 100644
  fn smoke() {
      let value = 12u32;
      let reference = &value;
-@@ -28,6 +29,7 @@ fn smoke() {
- }
-
- #[test]
-+#[ignore]
- fn boxed() {
-     let value = 12u32;
-     let boxed = Box::new(value);
-@@ -52,6 +54,7 @@ fn boxed() {
- }
-
- #[test]
-+#[ignore]
- fn arclones() {
-     let value = 12u32;
-     let arc = Arc::new(value);
 diff --git a/library/std/src/thread/local/tests.rs b/library/std/src/thread/local/tests.rs
 index 9d4f52a092..d425e5f7b7 100644
 --- a/library/std/src/thread/local/tests.rs
-- 
2.49.0


