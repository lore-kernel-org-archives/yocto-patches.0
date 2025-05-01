Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D94C3ABB2
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 22:16:14 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.6716.1746137767166756424
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 15:16:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DEIOzUxA;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso28082366d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746137766; x=1746742566; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11J57WJF9pHru0vPtMabVyiPFirX+FHDEUG6K7rfQrM=;
        b=DEIOzUxAjyl2sjdSvY+J3RpLBAFwpBnslFtzuX2FTXChFLZSi9lC9hkQsw95u973jk
         7OfXyNJy8EHt/UWyrkTZrhEgHCSj7uzVeVn0H1hYkItk/bc/hzp1+7m+JSlgViNJFcTX
         TLZkSm9lfOIL4iSOgxNGvR+/riMbLSVHOVwZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137766; x=1746742566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11J57WJF9pHru0vPtMabVyiPFirX+FHDEUG6K7rfQrM=;
        b=ajxnDlXw5KXguIRUTNKn3KYSF30OiO7EBTw/qI53LTHmhjg7AKUg2wv5jTSPXeXGD3
         gS0D52/1cwrb7+vZ1+hNungg/sdEZIFQH8MuNocm2Cc9ai50JKflpFYdaYEI8aNrmJ0e
         N4+1IV82uUo8qoEEidD7URMKYpqHTefSqhkhYAuvDthh4w8pLSXS58Q0zp9vlSJaAk9M
         NEsnk9L+y14BozcZiGTVmdFamCR+TI/t7OXDbpBvtqFlhzUKxsw8CM+8VKi6a445kEN2
         XQqFV46/VqhBG/p65kk3Vr5wASgrx6cTicchdlZL4ajcQIxD0bHiKkBIY8iQoqhWXtY2
         lClg==
X-Gm-Message-State: AOJu0YxQkeQtKAqbpsyLj5MVwit8qtQJ7iLS6puGpVkwn+sP8dU9yNFw
	/gnucWSFdKNnokfn5dGVLvDSlIRizFgjMHcjcu/OneqeyLs94HU67RHDXDoWetL6X+/12xzlNvT
	w
X-Gm-Gg: ASbGnctdUcPdPE2unitablGQkFToXo+q9QG3aAKZ1HCLMTqsSuOtqjXZQ4r+/m8PDmb
	Cr9wIMXmBcXShrTZgRVy8Mrytq0SEpg04dHJMTRvH4Enq3NLLscVEPBP0fhkQK+TVNSDnQjrIKb
	iOhasp2NJITT/C+VYur1JukYm0img/zvkzKdpqC98e747IBU6zITizzypcnKwKGNMZ4i3ks9LUi
	i69m+FYJn+jyQkMEPSPNhzOhuoptFO0TC9qHDivT4cjh30f/iUGw9R+tdH9SV6Fh0hQUWVeFumZ
	MjkH14kOLx6dZ4OarfKou4fPjMJXNjPSFravaOsGJ80S+6LOHb6J7myVl8fN0LTp+gK6rHatIBX
	ZMwibfiAjG2tDJAx1
X-Google-Smtp-Source: AGHT+IHwkJx1X9Zf9YvZKZH4JCvoR50GHcSAdNPZzJ/UX2kyPSdwyHSobRBkIuNSthyqTGqgUGJlUA==
X-Received: by 2002:ad4:5946:0:b0:6f2:c7b0:3b16 with SMTP id 6a1803df08f44-6f515256eaamr14998016d6.6.1746137765927;
        Thu, 01 May 2025 15:16:05 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c3329sm9975366d6.28.2025.05.01.15.16.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:16:05 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 6/7] rust: re-enable the unit tests that are ignored
Date: Thu,  1 May 2025 18:15:42 -0400
Message-ID: <90d82a12ab5949cf262ac66a58d47370fd65e45f.1746137462.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746137462.git.scott.murray@konsulko.com>
References: <cover.1746137462.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 22:16:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1472

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Some unit tests were previously marked as ignored due to failures in earlier
versions of Rust. With the upgrade to Rust 1.85.1, these tests are now passing
consistently. They've been re-enabled and verified to run successfully on the
latest version.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 65c207fb034848f9ef0de8cf8725c5eded363aca)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../rust/files/rust-oe-selftest.patch         | 100 ------------------
 1 file changed, 100 deletions(-)

diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index 4a8760a..909bc97 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -43,86 +43,6 @@ diff --git a/compiler/rustc_interface/src/tests.rs b/compiler/rustc_interface/sr
  fn test_can_print_warnings() {
      sess_and_cfg(&["-Awarnings"], |sess, _cfg| {
          assert!(!sess.dcx().can_emit_warnings());
-diff --git a/library/std/src/sync/mpsc/tests.rs b/library/std/src/sync/mpsc/tests.rs
-index ac1a804cf9c..7c687982324 100644
---- a/library/std/src/sync/mpsc/tests.rs
-+++ b/library/std/src/sync/mpsc/tests.rs
-@@ -233,6 +233,7 @@ fn oneshot_single_thread_send_port_close() {
- }
-
- #[test]
-+#[ignore]
- fn oneshot_single_thread_recv_chan_close() {
-     // Receiving on a closed chan will panic
-     let res = thread::spawn(move || {
-@@ -313,6 +314,7 @@ fn oneshot_multi_task_recv_then_send() {
- }
-
- #[test]
-+#[ignore]
- fn oneshot_multi_task_recv_then_close() {
-     let (tx, rx) = channel::<Box<i32>>();
-     let _t = thread::spawn(move || {
-@@ -337,6 +339,7 @@ fn oneshot_multi_thread_close_stress() {
- }
-
- #[test]
-+#[ignore]
- fn oneshot_multi_thread_send_close_stress() {
-     for _ in 0..stress_factor() {
-         let (tx, rx) = channel::<i32>();
-@@ -351,6 +354,7 @@ fn oneshot_multi_thread_send_close_stress() {
- }
-
- #[test]
-+#[ignore]
- fn oneshot_multi_thread_recv_close_stress() {
-     for _ in 0..stress_factor() {
-         let (tx, rx) = channel::<i32>();
-diff --git a/library/std/src/sync/poison/mutex/tests.rs b/library/std/src/sync/poison/mutex/tests.rs
-index 1786a3c09ff..9dcead7092b 100644
---- a/library/std/src/sync/poison/mutex/tests.rs
-+++ b/library/std/src/sync/poison/mutex/tests.rs
-@@ -82,6 +82,7 @@ fn drop(&mut self) {
- }
-
- #[test]
-+#[ignore]
- fn test_into_inner_poison() {
-     let m = new_poisoned_mutex(NonCopy(10));
-
-@@ -106,6 +107,7 @@ fn test_get_mut() {
- }
-
- #[test]
-+#[ignore]
- fn test_get_mut_poison() {
-     let mut m = new_poisoned_mutex(NonCopy(10));
-
-@@ -146,6 +148,7 @@ fn test_mutex_arc_condvar() {
- }
-
- #[test]
-+#[ignore]
- fn test_arc_condvar_poison() {
-     let packet = Packet(Arc::new((Mutex::new(1), Condvar::new())));
-     let packet2 = Packet(packet.0.clone());
-@@ -175,6 +178,7 @@ fn test_arc_condvar_poison() {
- }
-
- #[test]
-+#[ignore]
- fn test_mutex_arc_poison() {
-     let arc = Arc::new(Mutex::new(1));
-     assert!(!arc.is_poisoned());
-@@ -220,6 +220,7 @@ fn test_mutex_arc_nested() {
- }
-
- #[test]
-+#[ignore]
- fn test_mutex_arc_access_in_unwind() {
-     let arc = Arc::new(Mutex::new(1));
-     let arc2 = arc.clone();
 diff --git a/library/std/src/sync/poison/rwlock/tests.rs b/library/std/src/sync/poison/rwlock/tests.rs
 index 1a9d3d3f12f..0a9cfc48806 100644
 --- a/library/std/src/sync/poison/rwlock/tests.rs
@@ -183,26 +103,6 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_get_mut_poison() {
      let mut m = new_poisoned_rwlock(NonCopy(10));
 
-diff --git a/library/std/src/sys/pal/unix/process/process_unix/tests.rs b/library/std/src/sys/pal/unix/process/process_unix/tests.rs
-index 0a6c6ec19fc..bec257bc630 100644
---- a/library/std/src/sys/pal/unix/process/process_unix/tests.rs
-+++ b/library/std/src/sys/pal/unix/process/process_unix/tests.rs
-@@ -6,6 +6,7 @@
- // safety etc., are tested in tests/ui/process/process-panic-after-fork.rs
-
- #[test]
-+#[ignore]
- fn exitstatus_display_tests() {
-     // In practice this is the same on every Unix.
-     // If some weird platform turns out to be different, and this test fails, use #[cfg].
-@@ -37,6 +38,7 @@
- }
-
- #[test]
-+#[ignore]
- #[cfg_attr(target_os = "emscripten", ignore)]
- fn test_command_fork_no_unwind() {
-     let got = catch_unwind(|| {
 diff --git a/library/std/src/thread/tests.rs b/library/std/src/thread/tests.rs
 index 5d6b9e94ee9..a5aacb2eb87 100644
 --- a/library/std/src/thread/tests.rs
-- 
2.49.0


