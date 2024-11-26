Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4934FD65541
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 18:12:14 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web11.53405.1732644732324330759
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 Nov 2024 10:12:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kmGALNpK;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b673cb2708so86857485a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 10:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732644731; x=1733249531; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ll2ZbWIHol9/Lma3VUpqaw4do3nlNcjBx2HmtAa90jo=;
        b=kmGALNpKBk9fxBr4uRi1Awhe4gmLPZY/Thvsx02MEPnCDxdUbkEriDeVUQ/kf+2LbM
         3K7vgMwQrV5HlJhPWnzBFYYHwLRaxNK8UOrNF0t3pq8yvBaX39ulLnmCyZnDe1uxDmzn
         j0yei7qCiKPgByfMGoENv9XrbONI9XK7IlTG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644731; x=1733249531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll2ZbWIHol9/Lma3VUpqaw4do3nlNcjBx2HmtAa90jo=;
        b=U49ahkDgjjo+aPoeFAzRgEB9uKTZbhbPp/D78Bxg5eDRgfmvW3CWwvlHpSMx6XP0JH
         XiMJPqovETZMSS1Mdtfbw4RavnNFPgQ8luYM89aFopIugvZSmrwAYPQATL8x9/B14Z+Y
         Gyh33zeZNxGSQtdc0FcMCFZ7D11fX0NtAj/iFpEqzeJgn97TWcK4aCqODju+sgOBIVRt
         +TGvH9NxF4ZxsoGniB+gc3+LqHNvpe8WGPHZBKE76yX9R9nM0IoTCCk2+F8e2QZ+Htnt
         BNQRYPoso7zHsTy4FlUIcY3+yUEb9eGP413Ey39uh9y/epFHykVMK1V4KGLEOeXUhC8n
         agHw==
X-Gm-Message-State: AOJu0YyW0i0yx3wjR6bT+aSQCSq7I8iVjCitmuLNRrwc/iIdzrXwTtl4
	xU28x+wY4AhZBh1N9b6Y2CwB0jSPHE0LPG/KNmazMkf21jIeEtFYEG2GNXQa3IA7kYPpbBxgQZM
	l
X-Gm-Gg: ASbGncsVPJh6ImdEd8bYKY2CyE+bjqznZlWrmML7hZKmWAzrchRxqjmpxZtuaS1a8bj
	01E5Xs1xN0fIoEf3jzHAoDdcC2uK/4e0USvQ6eqNqrfmd2DNCNw7gAbDyntZbH8djKo0fdWWwv4
	v8MFT2V3GZIZuzOyVCY+CJaWMib8OX0MF7cSksqBkpHq9s6jqd+ADA/LCpIqrZxeuvHxH59JDW9
	t28oedrVDQwmoKP1bMNXhF6UG24QUtjl+zAt1QivgQQaFGkoRux1lU7npkwEzqQ3nzSH9JRFL15
	jVe4rXpno+jIKvazdixHDiC0NA==
X-Google-Smtp-Source: AGHT+IEOdU0s6dVoTaTTCpYTam0SM9fCC9iOrrm2pJ7JVF0Lm8cNk2hjgitAKJO1gKeaxqg/mYmY0Q==
X-Received: by 2002:a05:620a:2447:b0:7b6:5bf3:29ef with SMTP id af79cd13be357-7b67c484be0mr32968285a.51.1732644730715;
        Tue, 26 Nov 2024 10:12:10 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a83ea2sm58171276d6.22.2024.11.26.10.12.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:12:10 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 1/9] rust: Oe-selftest changes for rust v1.79
Date: Tue, 26 Nov 2024 13:11:32 -0500
Message-ID: <20241126181152.407253-2-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126181152.407253-1-scott.murray@konsulko.com>
References: <20241126181152.407253-1-scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 18:12:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/834

From: Yash Shinde <Yash.Shinde@windriver.com>

* Sort the exclude list in alphabetical order.

* Add some of the upsupported/failing tests to the exclude list
  and ignore the failing unit tests.

* Remove duplicated tests from the exclude list.

* Testing summary
    Target                PASS                    SKIPPED

    ARM                   17241                    599
    ARM64                 17279                    561
    MIPS64                17228                    612
    PPC                   17194                    629
    X86                   17257                    583
    X86-64                17416                    424

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 61ec0f0f78d9db4c3fc02365713d5fd77b78a7ea)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../rust/files/rust-oe-selftest.patch         | 69 +++++++++++--------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index a69c1e5..01c3634 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -8,7 +8,7 @@ Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
 diff --git a/compiler/rustc_errors/src/markdown/tests/term.rs b/compiler/rustc_errors/src/markdown/tests/term.rs
 --- a/compiler/rustc_errors/src/markdown/tests/term.rs
 +++ b/compiler/rustc_errors/src/markdown/tests/term.rs
-@@ -60,6 +60,7 @@
+@@ -61,6 +61,7 @@ fn test_wrapping_write() {
  }
 
  #[test]
@@ -19,31 +19,30 @@ diff --git a/compiler/rustc_errors/src/markdown/tests/term.rs b/compiler/rustc_e
 diff --git a/compiler/rustc_interface/src/tests.rs b/compiler/rustc_interface/src/tests.rs
 --- a/compiler/rustc_interface/src/tests.rs
 +++ b/compiler/rustc_interface/src/tests.rs
-@@ -116,6 +116,7 @@
+@@ -137,6 +137,7 @@ fn assert_non_crate_hash_different(x: &Options, y: &Options) {
 
  // When the user supplies --test we should implicitly supply --cfg test
  #[test]
 +#[ignore]
  fn test_switch_implies_cfg_test() {
-     rustc_span::create_default_session_globals_then(|| {
-         let matches = optgroups().parse(&["--test".to_string()]).unwrap();
-@@ -127,6 +128,7 @@
+     sess_and_cfg(&["--test"], |_sess, cfg| {
+         assert!(cfg.contains(&(sym::test, None)));
+@@ -145,6 +146,7 @@ fn test_switch_implies_cfg_test() {
 
  // When the user supplies --test and --cfg test, don't implicitly add another --cfg test
  #[test]
 +#[ignore]
  fn test_switch_implies_cfg_test_unless_cfg_test() {
-     rustc_span::create_default_session_globals_then(|| {
-         let matches = optgroups().parse(&["--test".to_string(), "--cfg=test".to_string()]).unwrap();
-@@ -139,6 +141,7 @@
+     sess_and_cfg(&["--test", "--cfg=test"], |_sess, cfg| {
+         let mut test_items = cfg.iter().filter(|&&(name, _)| name == sym::test);
+@@ -154,6 +156,7 @@ fn test_switch_implies_cfg_test_unless_cfg_test() {
  }
 
  #[test]
 +#[ignore]
  fn test_can_print_warnings() {
-     rustc_span::create_default_session_globals_then(|| {
-         let matches = optgroups().parse(&["-Awarnings".to_string()]).unwrap();
-
+     sess_and_cfg(&["-Awarnings"], |sess, _cfg| {
+         assert!(!sess.dcx().can_emit_warnings());
 diff --git a/library/test/src/stats/tests.rs b/library/test/src/stats/tests.rs
 --- a/library/test/src/stats/tests.rs
 +++ b/library/test/src/stats/tests.rs
@@ -59,7 +58,7 @@ diff --git a/library/std/src/io/buffered/tests.rs b/library/std/src/io/buffered/
 index 35a5291a347..5f2858d2505 100644
 --- a/library/std/src/io/buffered/tests.rs
 +++ b/library/std/src/io/buffered/tests.rs
-@@ -485,6 +485,7 @@ fn flush(&mut self) -> io::Result<()> {
+@@ -488,6 +488,7 @@ fn flush(&mut self) -> io::Result<()> {
  }
 
  #[test]
@@ -187,7 +186,7 @@ index 1786a3c09ff..9dcead7092b 100644
  fn test_mutex_arc_poison() {
      let arc = Arc::new(Mutex::new(1));
      assert!(!arc.is_poisoned());
-@@ -205,6 +209,7 @@ fn test_mutex_arc_nested() {
+@@ -220,6 +220,7 @@ fn test_mutex_arc_nested() {
  }
 
  #[test]
@@ -199,7 +198,7 @@ diff --git a/library/std/src/sync/rwlock/tests.rs b/library/std/src/sync/rwlock/
 index 1a9d3d3f12f..0a9cfc48806 100644
 --- a/library/std/src/sync/rwlock/tests.rs
 +++ b/library/std/src/sync/rwlock/tests.rs
-@@ -44,6 +44,7 @@ fn frob() {
+@@ -47,6 +47,7 @@ fn frob() {
  }
 
  #[test]
@@ -207,7 +206,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_rw_arc_poison_wr() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -56,6 +57,7 @@ fn test_rw_arc_poison_wr() {
+@@ -72,6 +73,7 @@ fn test_rw_arc_poison_mapped_w_r() {
  }
 
  #[test]
@@ -215,7 +214,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_rw_arc_poison_ww() {
      let arc = Arc::new(RwLock::new(1));
      assert!(!arc.is_poisoned());
-@@ -70,6 +72,7 @@ fn test_rw_arc_poison_ww() {
+@@ -100,6 +102,7 @@ fn test_rw_arc_poison_mapped_w_w() {
  }
 
  #[test]
@@ -223,7 +222,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_rw_arc_no_poison_rr() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -127,6 +127,7 @@
+@@ -127,6 +130,7 @@ fn test_rw_arc_no_poison_mapped_r_r() {
  }
 
  #[test]
@@ -231,7 +230,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_rw_arc_no_poison_rw() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -133,6 +137,7 @@ fn test_rw_arc() {
+@@ -192,6 +196,7 @@ fn test_rw_arc() {
  }
 
  #[test]
@@ -239,7 +238,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_rw_arc_access_in_unwind() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -206,6 +211,7 @@ fn drop(&mut self) {
+@@ -275,6 +280,7 @@ fn drop(&mut self) {
  }
 
  #[test]
@@ -247,7 +246,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_into_inner_poison() {
      let m = Arc::new(RwLock::new(NonCopy(10)));
      let m2 = m.clone();
-@@ -230,6 +236,7 @@ fn test_get_mut() {
+@@ -299,6 +305,7 @@ fn test_get_mut() {
  }
 
  #[test]
@@ -279,7 +278,7 @@ diff --git a/library/std/src/thread/tests.rs b/library/std/src/thread/tests.rs
 index 5d6b9e94ee9..a5aacb2eb87 100644
 --- a/library/std/src/thread/tests.rs
 +++ b/library/std/src/thread/tests.rs
-@@ -115,6 +115,7 @@ fn test_is_finished() {
+@@ -116,6 +116,7 @@ fn test_is_finished() {
  }
 
  #[test]
@@ -287,7 +286,7 @@ index 5d6b9e94ee9..a5aacb2eb87 100644
  fn test_join_panic() {
      match thread::spawn(move || panic!()).join() {
          result::Result::Err(_) => (),
-@@ -217,6 +218,7 @@ fn test_simple_newsched_spawn() {
+@@ -218,6 +219,7 @@ fn test_simple_newsched_spawn() {
  }
 
  #[test]
@@ -295,7 +294,7 @@ index 5d6b9e94ee9..a5aacb2eb87 100644
  fn test_try_panic_message_string_literal() {
      match thread::spawn(move || {
          panic!("static string");
-@@ -233,6 +235,7 @@ fn test_try_panic_message_string_literal() {
+@@ -234,6 +236,7 @@ fn test_try_panic_message_string_literal() {
  }
 
  #[test]
@@ -303,7 +302,7 @@ index 5d6b9e94ee9..a5aacb2eb87 100644
  fn test_try_panic_any_message_owned_str() {
      match thread::spawn(move || {
          panic_any("owned string".to_string());
-@@ -249,6 +252,7 @@ fn test_try_panic_any_message_owned_str() {
+@@ -250,6 +253,7 @@ fn test_try_panic_any_message_owned_str() {
  }
 
  #[test]
@@ -311,7 +310,7 @@ index 5d6b9e94ee9..a5aacb2eb87 100644
  fn test_try_panic_any_message_any() {
      match thread::spawn(move || {
          panic_any(Box::new(413u16) as Box<dyn Any + Send>);
-@@ -267,6 +271,7 @@ fn test_try_panic_any_message_any() {
+@@ -268,6 +272,7 @@ fn test_try_panic_any_message_any() {
  }
 
  #[test]
@@ -363,10 +362,10 @@ diff --git a/library/std/src/sync/mutex/tests.rs b/library/std/src/sync/mutex/te
  fn panic_while_mapping_unlocked_poison() {
      let lock = Mutex::new(());
 
-diff --git a/
+diff --git a/library/std/src/sync/rwlock/tests.rs b/library/std/src/sync/rwlock/tests.rs
 --- a/library/std/src/sync/rwlock/tests.rs
 +++ b/library/std/src/sync/rwlock/tests.rs
-@@ -60,6 +60,7 @@
+@@ -59,6 +59,7 @@ fn test_rw_arc_poison_wr() {
  }
 
  #[test]
@@ -374,7 +373,7 @@ diff --git a/
  fn test_rw_arc_poison_mapped_w_r() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -88,6 +89,7 @@
+@@ -86,6 +87,7 @@ fn test_rw_arc_poison_ww() {
  }
 
  #[test]
@@ -382,7 +381,7 @@ diff --git a/
  fn test_rw_arc_poison_mapped_w_w() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -438,6 +440,7 @@
+@@ -431,6 +433,7 @@ fn panic_while_mapping_read_unlocked_no_poison() {
  }
 
  #[test]
@@ -390,3 +389,15 @@ diff --git a/
  fn panic_while_mapping_write_unlocked_poison() {
      let lock = RwLock::new(());
 
+diff --git a/library/core/benches/num/int_log/mod.rs b/library/core/benches/num/int_log/mod.rs
+index 3807cd5d76c..018c5c04456 100644
+--- a/library/core/benches/num/int_log/mod.rs
++++ b/library/core/benches/num/int_log/mod.rs
+@@ -98,6 +98,7 @@ fn $random_small(bench: &mut Bencher) {
+         }
+
+         #[bench]
++        #[ignore]
+         fn $geometric(bench: &mut Bencher) {
+             let bases: [$t; 16] = [2, 3, 4, 5, 7, 8, 9, 15, 16, 17, 31, 32, 33, 63, 64, 65];
+             let base_and_numbers: Vec<($t, Vec<$t>)> = bases
-- 
2.47.0


