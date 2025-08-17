Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2554CA0EE4
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 17:29:51 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web11.56799.1755451790722722753
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 10:29:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=s6wpg35d;
 spf=pass (domain: konsulko.com, ip: 209.85.160.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b10957f506so45509681cf.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755451789; x=1756056589; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5iH/0KqM2LQj39RjAEoZNHzyn508YxSjlFDlyG4Le8=;
        b=s6wpg35droFgEvC5HoXOFykV04x8NVYaj27BNtZLpSStmfh+LU9M/gj9+A8WQY5JOW
         j4gibIj5JHWPmjPrJiZgjZ6ZKgofA1JLlccNqgsgUS4q6nnlBFY8cMYsOw82FJpGmssK
         1voXa52pMRxAfMRk7z5Jg8nQ7yq3r5oDqWYaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451789; x=1756056589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5iH/0KqM2LQj39RjAEoZNHzyn508YxSjlFDlyG4Le8=;
        b=ZIu6l+1FstR+ff6TU78roH7XZ5dAAlHP6pj3wGH9ub2qvH21KgZvuGO2XlSCNb+Xjz
         X4tCH8bpdwuY9vMucBTajATMNnllyZvVftdDpSVgA+GeEtjU6lZRh2OtmlwtQykky8s6
         yfVvt1duWvfiiK4Hkq9AJcT07xcgmi7FyLQ1h47dahfvb4XsInzxoTV6LhmXRmy6z3zc
         4KdpeJzZc7nHc2iWX/+I0Q3Qgv1IB5SBUbFlRwFVnTk3Q2iAJPs22Nqnr/8336wFZYGa
         UCHSIhxSpo+r9CIoDFFA7867AAiiXuixVdlQ43xmBU0dr9a/LzqsbO4WC9geizW5UdCR
         oRjg==
X-Gm-Message-State: AOJu0YzZmPnT6CGRcQ9KI0gY09C0Q0H/RO3lLTkksJB5LzbeohV5tX2D
	GE68NKSIHZAf7iRBA0lkdESEeOpbzy7JDCF6kukOAilUgrkUcvn4tOmQXu7V5R4PmPm4+tfeCBL
	pZx3n
X-Gm-Gg: ASbGncvA5elUtTKWG/sVPccfyq9mtuC7gsekU4ukXBQfAkq99sIE91XJ3vdOP6FP8R2
	4OSSPKOwp9ciAnHPdQLSI293BZEXlCbcjt5q3aDDtx4ziSEUKycT14k7nlD3SkGwivd+3EyI4Bm
	EamUjY5w/09fgbIh8KmVXacPhrqSGchIoJ2hGFlvsqyd9wFtFmKgYqwqoNNLs6qWZklA2xXgTW3
	xR8elxnfRqGKysPMlqnhPNSHRBuQp2YWBnSYhoeDKjEQyXzHGgka5aOF66NQoJVCrkvWbcDO0US
	rYjJIrtN1DXGnZwFqPOiIVlScnij3KJxLFxrfEFUofJbGHawxxsuaWvU/Htre41T6ojIHRuyxkI
	X8Ze6emv45aVWYN3iq0z7qfTGLAMr/zSjKK4+Qixi8pY11Ed2pwuUJywF92KwTBp3KG/fj3s6kw
	==
X-Google-Smtp-Source: AGHT+IEJwOxtdPk47fwsVhabXdgRsvj6rzEOORbBDiuDqGTEDzjEPvSfcXtIwgstPdKU8lZRsPp5vA==
X-Received: by 2002:ac8:5fc4:0:b0:4a7:7c8e:1d5 with SMTP id d75a77b69052e-4b11d2dc588mr119004831cf.17.1755451789362;
        Sun, 17 Aug 2025 10:29:49 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc18a0esm39626271cf.9.2025.08.17.10.29.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:29:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 5/7] cargo-c: Update patches to latest versions
Date: Sun, 17 Aug 2025 13:29:29 -0400
Message-ID: <55c27644f5e0d09bb9329a24e7cd946ff6a4b01a.1755451486.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755451486.git.scott.murray@konsulko.com>
References: <cover.1755451486.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 17:29:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2009

From: Khem Raj <raj.khem@gmail.com>

getrandom patch is accepted upstream with minor changes
parking_lot patch has addressed upstream feedback

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 9f0f41d8e3fe00df37d926d99fb490614b51dde7)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...Use-libc-SYS_futex_time64-on-riscv32.patch | 69 +++++++------------
 ...Use-libc-SYS_futex_time64-on-riscv32.patch | 65 +++++++----------
 2 files changed, 51 insertions(+), 83 deletions(-)

diff --git a/recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch b/recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
index dc7130f..638832c 100644
--- a/recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
+++ b/recipes-devtools/rust/cargo-c/0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch
@@ -1,53 +1,36 @@
 From 71c356a07fbbf1530cfc87960e975f93bc9007e8 Mon Sep 17 00:00:00 2001
 From: Khem Raj <raj.khem@gmail.com>
 Date: Tue, 22 Jul 2025 09:46:03 -0700
-Subject: [PATCH] Use libc::SYS_futex_time64 on riscv32
+Subject: [PATCH] Use getrandom syscall on riscv32/riscv64 linux
 
-On RISC-V 32-bit (riscv32), the SYS_futex system call is
-often handled indirectly due to the use of a 64-bit time_t
-type. Specifically, while SYS_futex is not directly defined,
-a related syscall like SYS_futex_time64 can be used,
+Minimum kernel needed on RISCV is fairly new (4.15+) so we are sure
+to have getrandom syscall, on glibc there is mimimal ABI kernel to denote
+it but musl does not have any other way to indicate it, so add it
+as a condition here to choose getrandom backend for rv32/rv64 on linux
+when using musl.
 
-Upstream-Status: Submitted [https://github.com/rust-random/getrandom/pull/698]
+Upstream-Status: Backport [https://github.com/rust-random/getrandom/pull/699]
 Signed-off-by: Khem Raj <raj.khem@gmail.com>
 ---
  src/backends/use_file.rs | 17 +++++++++++++++++
  1 file changed, 17 insertions(+)
 
-diff --git a/src/backends/use_file.rs b/src/backends/use_file.rs
-index 7b48d43..baa0c66 100644
---- a/src/backends/use_file.rs
-+++ b/src/backends/use_file.rs
-@@ -158,7 +158,18 @@ mod sync {
-     pub(super) fn wait() {
-         let op = libc::FUTEX_WAIT | libc::FUTEX_PRIVATE_FLAG;
-         let timeout_ptr = core::ptr::null::<libc::timespec>();
-+        #[cfg(not(target_arch = "riscv32"))]
-         let ret = unsafe { libc::syscall(libc::SYS_futex, &FD, op, FD_ONGOING_INIT, timeout_ptr) };
-+        #[cfg(target_arch = "riscv32")]
-+        let ret = unsafe {
-+            libc::syscall(
-+                libc::SYS_futex_time64,
-+                &FD,
-+                op,
-+                FD_ONGOING_INIT,
-+                timeout_ptr,
-+            )
-+        };
-         // FUTEX_WAIT should return either 0 or EAGAIN error
-         debug_assert!({
-             match ret {
-@@ -172,7 +183,13 @@ mod sync {
-     /// Wake up all threads which wait for value of atomic `FD` to change.
-     pub(super) fn wake() {
-         let op = libc::FUTEX_WAKE | libc::FUTEX_PRIVATE_FLAG;
-+
-+        #[cfg(not(target_arch = "riscv32"))]
-         let ret = unsafe { libc::syscall(libc::SYS_futex, &FD, op, libc::INT_MAX) };
-+
-+        #[cfg(target_arch = "riscv32")]
-+        let ret = unsafe { libc::syscall(libc::SYS_futex_time64, &FD, op, libc::INT_MAX) };
-+
-         debug_assert!(ret >= 0);
-     }
- 
+--- a/src/backends.rs
++++ b/src/backends.rs
+@@ -93,7 +93,15 @@ cfg_if! {
+                 // Minimum supported Linux kernel version for MUSL targets
+                 // is not specified explicitly (as of Rust 1.77) and they
+                 // are used in practice to target pre-3.17 kernels.
+-                target_env = "musl",
++                all(
++                    target_env = "musl",
++                    not(
++                        any(
++                            target_arch = "riscv64",
++                            target_arch = "riscv32",
++                        ),
++                    ),
++                ),
+             ),
+         )
+     ))] {
diff --git a/recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch b/recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
index 37f21af..9e84ca3 100644
--- a/recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
+++ b/recipes-devtools/rust/cargo-c/0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch
@@ -1,66 +1,51 @@
-From 78d4c37e9c5b60ea2368627c2fc297dfc46bec2a Mon Sep 17 00:00:00 2001
+From 7ebddca7070742bbb9cce471a93d699ad70ee371 Mon Sep 17 00:00:00 2001
 From: Khem Raj <raj.khem@gmail.com>
 Date: Tue, 22 Jul 2025 10:15:06 -0700
-Subject: [PATCH] Use libc::SYS_futex_time64 on riscv32
+Subject: [PATCH] Use libc::SYS_futex_time64 on riscv32/musl
 
 On RISC-V 32-bit (riscv32), the SYS_futex system call is
 often handled indirectly due to the use of a 64-bit time_t
 type. Specifically, while SYS_futex is not directly defined,
-a related syscall like SYS_futex_time64 can be used,
+a related syscall like SYS_futex_time64 can be used on target
+e.g. riscv32
 
 Upstream-Status: Submitted [https://github.com/Amanieu/parking_lot/pull/485]
 Signed-off-by: Khem Raj <raj.khem@gmail.com>
 ---
- src/thread_parker/linux.rs | 19 +++++++++++++++++++
- 1 file changed, 19 insertions(+)
+ src/thread_parker/linux.rs | 13 +++++++++++--
+ 1 file changed, 11 insertions(+), 2 deletions(-)
 
 diff --git a/src/thread_parker/linux.rs b/src/thread_parker/linux.rs
-index 92601f6..3695624 100644
+index 92601f6..0952db4 100644
 --- a/src/thread_parker/linux.rs
 +++ b/src/thread_parker/linux.rs
-@@ -108,6 +108,7 @@ impl ThreadParker {
+@@ -108,9 +108,13 @@ impl ThreadParker {
              .as_ref()
              .map(|ts_ref| ts_ref as *const _)
              .unwrap_or(ptr::null());
-+        #[cfg(not(target_arch = "riscv32"))]
++        #[cfg(not(all(target_arch = "riscv32", target_env = "musl")))]
++        let futex_num = libc::SYS_futex;
++        #[cfg(all(target_arch = "riscv32", target_env = "musl",))]
++        let futex_num = libc::SYS_futex_time64;
          let r = unsafe {
              libc::syscall(
-                 libc::SYS_futex,
-@@ -117,6 +118,16 @@ impl ThreadParker {
-                 ts_ptr,
-             )
-         };
-+        #[cfg(target_arch = "riscv32")]
-+        let r = unsafe {
-+            libc::syscall(
-+                libc::SYS_futex_time64,
-+                &self.futex,
-+                libc::FUTEX_WAIT | libc::FUTEX_PRIVATE_FLAG,
-+                1,
-+                ts_ptr,
-+            )
-+        };
-         debug_assert!(r == 0 || r == -1);
-         if r == -1 {
-             debug_assert!(
-@@ -137,12 +148,20 @@ impl super::UnparkHandleT for UnparkHandle {
+-                libc::SYS_futex,
++                futex_num,
+                 &self.futex,
+                 libc::FUTEX_WAIT | libc::FUTEX_PRIVATE_FLAG,
+                 1,
+@@ -137,8 +141,13 @@ impl super::UnparkHandleT for UnparkHandle {
      unsafe fn unpark(self) {
          // The thread data may have been freed at this point, but it doesn't
          // matter since the syscall will just return EFAULT in that case.
-+        #[cfg(not(target_arch = "riscv32"))]
++        #[cfg(not(all(target_arch = "riscv32", target_env = "musl",)))]
++        let futex_num = libc::SYS_futex;
++        #[cfg(all(target_arch = "riscv32", target_env = "musl",))]
++        let futex_num = libc::SYS_futex_time64;
++
          let r = libc::syscall(
-             libc::SYS_futex,
+-            libc::SYS_futex,
++            futex_num,
              self.futex,
              libc::FUTEX_WAKE | libc::FUTEX_PRIVATE_FLAG,
              1,
-         );
-+        #[cfg(target_arch = "riscv32")]
-+        let r = libc::syscall(
-+            libc::SYS_futex_time64,
-+            self.futex,
-+            libc::FUTEX_WAKE | libc::FUTEX_PRIVATE_FLAG,
-+            1,
-+        );
-         debug_assert!(r == 0 || r == 1 || r == -1);
-         if r == -1 {
-             debug_assert_eq!(errno(), libc::EFAULT);
-- 
2.50.1


