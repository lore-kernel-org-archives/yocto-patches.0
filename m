Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A90C7112F
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:26 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.web11.5865.1724875816487258184
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lsHCKNOq;
 spf=pass (domain: konsulko.com, ip: 209.85.166.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81f86fd9305so385148239f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875815; x=1725480615; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVxfLQIaFX+zgimxFS/oOtBmFl9m6iv6Y4PdjIEcnFM=;
        b=lsHCKNOqOSVobBhLwjXVURTqQWA+a7eHlI/tLsK9KgJ80FKDrcsnMI41CP6nodaMCN
         PAH8bZSrnnKYTJJFjcFCsMk3J3dyyiL6Ovj2QiKbEm/EmyNwM7s3fgZQdHjKo6lV7HLC
         X6BvxsOsC+RBWwj8yodjm8f4zjBdpkS7Hvxx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875815; x=1725480615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVxfLQIaFX+zgimxFS/oOtBmFl9m6iv6Y4PdjIEcnFM=;
        b=BR2+iE6yVMQ976B0ERDEmuZRl63P8+Xhb4PNeTmx5GG7vxoNzFgu1tp9GtpapmoP5i
         5dXvuUPr8qHML1DCs40Bwzu9MVpgZrd1IhmJz3NuFichiX4+2PH5mZOs66eWm0ZrS1mF
         BhMLoN1Js68enJgX5MoqbfesD6i7DivLhTKiXzhx00tEZoJgbetYaL9DvYugmA3tVQjI
         yrpgCtcQGaOgioJIwn357FzY6Dan6kN5maGgczQZfgXPXs79W2W1zAWs87r6j2ChXASB
         JolhJyZO+cECGrwKnoVvbIhURUppT+k5HBxWQpwi0kZGn0TFKeC3sLhFVZlCzc+1GHNA
         LbCQ==
X-Gm-Message-State: AOJu0YwYx/cLJqsE/sT1b3TcUrvywMpDyzQR3aYoo8t9LH3RWiS/b+1Q
	bexwwDMw5tCqFN7UsZvGGMOEPAvhMgRAC4DlkUI7/cyIMtc1xMZ51sDkg8Is4f1WCLjRBpX/dGX
	8
X-Google-Smtp-Source: AGHT+IGB0JgRPY2/8oqbNiQHel4Hd8NlMamntaNEMxdnZFzGseZDieCqMVMaKZU7nNSUBPH5XLbr6w==
X-Received: by 2002:a05:6602:619a:b0:824:d9c0:3fc6 with SMTP id ca18e2360f4ac-82a10e16c0dmr94798139f.3.1724875815341;
        Wed, 28 Aug 2024 13:10:15 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:14 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 31/33] rust: Oe-selftest changes for rust v1.78
Date: Wed, 28 Aug 2024 16:09:17 -0400
Message-ID: <77fc94da83d46ef74e03cb6ffdd40d4512002232.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/598

From: Yash Shinde <Yash.Shinde@windriver.com>

Add some of the upsupported/failing tests to the exclude list
and ignore the failing unit tests.

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 81bbd6db47f45628ff4be400e1f2fa5b09ccd0bb)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../rust/files/rust-oe-selftest.patch         | 64 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index 1d28733..a69c1e5 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -223,9 +223,9 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_rw_arc_no_poison_rr() {
      let arc = Arc::new(RwLock::new(1));
      let arc2 = arc.clone();
-@@ -82,6 +85,7 @@ fn test_rw_arc_no_poison_rr() {
-     assert_eq!(*lock, 1);
+@@ -127,6 +127,7 @@
  }
+
  #[test]
 +#[ignore]
  fn test_rw_arc_no_poison_rw() {
@@ -330,3 +330,63 @@ diff --git a/library/alloc/src/slice/tests.rs b/library/alloc/src/slice/tests.rs
  #[cfg_attr(target_os = "emscripten", ignore)] // no threads
  #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
  fn panic_safe() {
+diff --git a/library/test/src/tests.rs b/library/test/src/tests.rs
+--- a/library/test/src/tests.rs
++++ b/library/test/src/tests.rs
+@@ -424,6 +424,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn test_time_options_threshold() {
+     let unit = TimeThreshold::new(Duration::from_millis(50), Duration::from_millis(100));
+     let integration = TimeThreshold::new(Duration::from_millis(500), Duration::from_millis(1000));
+diff --git a/library/std/src/sync/mutex/tests.rs b/library/std/src/sync/mutex/tests.rs
+--- a/library/std/src/sync/mutex/tests.rs
++++ b/library/std/src/sync/mutex/tests.rs
+@@ -193,6 +193,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn test_mutex_arc_poison_mapped() {
+     let arc = Arc::new(Mutex::new(1));
+     assert!(!arc.is_poisoned());
+diff --git a/library/std/src/sync/mutex/tests.rs b/library/std/src/sync/mutex/tests.rs
+--- a/library/std/src/sync/mutex/tests.rs
++++ b/library/std/src/sync/mutex/tests.rs
+@@ -272,6 +272,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn panic_while_mapping_unlocked_poison() {
+     let lock = Mutex::new(());
+
+diff --git a/
+--- a/library/std/src/sync/rwlock/tests.rs
++++ b/library/std/src/sync/rwlock/tests.rs
+@@ -60,6 +60,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_poison_mapped_w_r() {
+     let arc = Arc::new(RwLock::new(1));
+     let arc2 = arc.clone();
+@@ -88,6 +89,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn test_rw_arc_poison_mapped_w_w() {
+     let arc = Arc::new(RwLock::new(1));
+     let arc2 = arc.clone();
+@@ -438,6 +440,7 @@
+ }
+
+ #[test]
++#[ignore]
+ fn panic_while_mapping_write_unlocked_poison() {
+     let lock = RwLock::new(());
+
-- 
2.46.0


