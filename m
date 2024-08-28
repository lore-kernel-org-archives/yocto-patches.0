Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5F4C7113C
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:16 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web11.5861.1724875812599587963
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GfWOxoc8;
 spf=pass (domain: konsulko.com, ip: 209.85.166.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-829e86cb467so143521439f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875811; x=1725480611; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taynlbyG1oCTj+dFV/VMilspsYLzCduqZwA/JCA/+ts=;
        b=GfWOxoc87ynArSSVkdxpK+rvowWMzUYX2OAaHxuyDbmxL9oXpw55wS0854RLpRDd9k
         b2pLcP7+gAFKMVTKLqDJaMGvbAWLZ9FuC3pZYNWyCeKRNreFdHGPli5skkl3p8qZt9XA
         pRs0d0V263dZHUeJFlvM0uz9s4CB6GtXzVTP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875811; x=1725480611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taynlbyG1oCTj+dFV/VMilspsYLzCduqZwA/JCA/+ts=;
        b=PPlD95b7r8FIKPdKbIfHfr4h1CXaExT0P6Q39Pl7e8jeZgMYm3xLAOoGLddtToZhqO
         IuYx0Vq6DKda7wRKZ4yPDjxDMdch7WRM8Xqg6p+8rLU6N7gzwQtBB0d5bKjB9JivtKp2
         RJ775Ov6ciNKAfwhT9oxIu+wfLHJUfeydODwtiMkNeFjwvwVCpx4G1JzJFaYlMfdvSRR
         G/crm/n0FnwslQbPaQm458xfsEvCn4fBVICE+700r3u8vwyL0I5utbfwtRAKdG8k3SXo
         XUj+MtlBy5La3DqKjUvX1Zsay2hR3nr0ib+G0vovVMHovcsggQXKs29esvLTuAmZgEZi
         Vk9g==
X-Gm-Message-State: AOJu0YzyVySuaMTgI9h3chfsMx/cNIfODOlx+erRP9/2AZQvQQricorn
	fvmCQKoK0AutTw/PomHAFEqVnswJGP65Lm6aL8Ucl/6q8DpxjhfU/O7H2D+jZPI09l540D84XBa
	+
X-Google-Smtp-Source: AGHT+IEfXlbzN3l4b0vHNOGiUPHO9ozhgIygJflXkzGYxf8qGU1G9nwYzoZPs3IGkTuEbiswYmbXaA==
X-Received: by 2002:a05:6602:619a:b0:822:6d2a:e52d with SMTP id ca18e2360f4ac-82a1100dcf4mr86895339f.1.1724875811341;
        Wed, 28 Aug 2024 13:10:11 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:10 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 27/33] rust: Oe-selftest changes for rust v1.77
Date: Wed, 28 Aug 2024 16:09:13 -0400
Message-ID: <bd3f4cf8333b602e179e979e5ee7e7a1a979802f.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/593

From: Yash Shinde <Yash.Shinde@windriver.com>

    Update the file paths for v1.77 and fix the dead code error as follows:

    Compiling coverage-dump v0.1.0 (/home/poky/build-st/tmp/work/core2-64-poky-linux/rust/1.77.0/rustc-1.77.0-src/src/tools/coverage-dump)
    error: field `0` is never read
       --> src/tools/coverage-dump/src/covfun.rs:222:15
        |
    222 |     Expansion(u32),
        |     --------- ^^^
        |     |
        |     field in this variant
        |
        = note: `-D dead-code` implied by `-D warnings`
        = help: to override `-D warnings` add `#[allow(dead_code)]`
    help: consider changing the field to be of unit type to suppress this warning while preserving the field numbering, or remove the field
        |
    222 |     Expansion(()),
        |               ~~

    error: could not compile `coverage-dump` (bin "coverage-dump") due to 1 previous error

    Only the required change is backported here to run the build without any errors.
    Other changes are merged with the commit in v1.78.

    Reference: https://github.com/rust-lang/rust/commit/9a5034a20ed8b055dc615271f9d9cf27f9e494f0#diff-d4ecc6273352a2a8ebd02c45233d9bff7c6694f20b67ddad0614af7a89c06748

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 072df9d3d8792a6f0250cc5e37545f04e6a046ec)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../rust/files/deadcode-backport.patch        | 39 +++++++++++++++++++
 .../rust/files/rust-oe-selftest.patch         | 17 ++++++--
 recipes-devtools/rust/rust-source.inc         |  1 +
 3 files changed, 54 insertions(+), 3 deletions(-)
 create mode 100644 recipes-devtools/rust/files/deadcode-backport.patch

diff --git a/recipes-devtools/rust/files/deadcode-backport.patch b/recipes-devtools/rust/files/deadcode-backport.patch
new file mode 100644
index 0000000..9ab229e
--- /dev/null
+++ b/recipes-devtools/rust/files/deadcode-backport.patch
@@ -0,0 +1,39 @@
+Fix the dead code error as follows:
+
+    Compiling coverage-dump v0.1.0 (/home/poky/build-st/tmp/work/core2-64-poky-linux/rust/1.77.0/rustc-1.77.0-src/src/tools/coverage-dump)
+    error: field `0` is never read
+       --> src/tools/coverage-dump/src/covfun.rs:222:15
+        |
+    222 |     Expansion(u32),
+        |     --------- ^^^
+        |     |
+        |     field in this variant
+        |
+        = note: `-D dead-code` implied by `-D warnings`
+        = help: to override `-D warnings` add `#[allow(dead_code)]`
+    help: consider changing the field to be of unit type to suppress this warning while preserving the field numbering, or remove the field
+        |
+    222 |     Expansion(()),
+        |               ~~
+
+    error: could not compile `coverage-dump` (bin "coverage-dump") due to 1 previous error
+
+Only the required change is backported here to run the build without any errors.
+Other changes are merged with the commit in v1.78.
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/9a5034a20ed8b055dc615271f9d9cf27f9e494f0#diff-d4ecc6273352a2a8ebd02c45233d9bff7c6694f20b67ddad0614af7a89c06748]
+
+Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
+---
+diff --git a/src/tools/coverage-dump/src/covfun.rs b/src/tools/coverage-dump/src/covfun.rs
+--- a/src/tools/coverage-dump/src/covfun.rs
++++ b/src/tools/coverage-dump/src/covfun.rs
+@@ -219,7 +219,7 @@
+ enum MappingKind {
+     Code(CovTerm),
+     Gap(CovTerm),
+-    Expansion(u32),
++    Expansion(#[allow(dead_code)] u32),
+     Skip,
+     // Using raw identifiers here makes the dump output a little bit nicer
+     // (via the derived Debug), at the expense of making this tool's source
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index 2c6e97f..1d28733 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -255,10 +255,10 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_get_mut_poison() {
      let m = Arc::new(RwLock::new(NonCopy(10)));
      let m2 = m.clone();
-diff --git a/library/std/src/sys/unix/process/process_unix/tests.rs b/library/std/src/sys/unix/process/process_unix/tests.rs
+diff --git a/library/std/src/sys/pal/unix/process/process_unix/tests.rs b/library/std/src/sys/pal/unix/process/process_unix/tests.rs
 index 0a6c6ec19fc..bec257bc630 100644
---- a/library/std/src/sys/unix/process/process_unix/tests.rs
-+++ b/library/std/src/sys/unix/process/process_unix/tests.rs
+--- a/library/std/src/sys/pal/unix/process/process_unix/tests.rs
++++ b/library/std/src/sys/pal/unix/process/process_unix/tests.rs
 @@ -6,6 +6,7 @@
  // safety etc., are tested in tests/ui/process/process-panic-after-fork.rs
 
@@ -319,3 +319,14 @@ index 5d6b9e94ee9..a5aacb2eb87 100644
  fn test_try_panic_any_message_unit_struct() {
      struct Juju;
 
+diff --git a/library/alloc/src/slice/tests.rs b/library/alloc/src/slice/tests.rs
+--- a/library/alloc/src/slice/tests.rs
++++ b/library/alloc/src/slice/tests.rs
+@@ -186,6 +186,7 @@
+ std::thread_local!(static SILENCE_PANIC: Cell<bool> = Cell::new(false));
+
+ #[test]
++#[ignore]
+ #[cfg_attr(target_os = "emscripten", ignore)] // no threads
+ #[cfg_attr(not(panic = "unwind"), ignore = "test requires unwinding support")]
+ fn panic_safe() {
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index dff95ec..328c5b2 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -11,6 +11,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-cargo-do-not-write-host-information-into-compilation.patch;patchdir=${RUSTSRC} \
             file://rustdoc-repro-issue-fix-cargo-config-for-codegenunits.patch;patchdir=${RUSTSRC} \
             file://cross-targets-backport.patch;patchdir=${RUSTSRC} \
+            file://deadcode-backport.patch;patchdir=${RUSTSRC} \
             file://rust-oe-selftest.patch;patchdir=${RUSTSRC} \
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=${RUSTSRC} \
 "
-- 
2.46.0


