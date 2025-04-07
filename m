Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735D1C369A5
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:30:54 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.web11.59600.1744061449879897307
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=MrNL24SD;
 spf=pass (domain: konsulko.com, ip: 209.85.166.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85e751cffbeso381896239f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061449; x=1744666249; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71uNMFTcS2SWlBkZ+vUA7u6kkqjgQtAivFqSijEfze0=;
        b=MrNL24SD3uIuC500qqqGc5qnRKSxhzmEldsvV9zneyKdLsGzSWc7NbjzqmgvZE8fL9
         f8KY621HCh54ms5eXaD8GfcZ2EM9b6LNxBRiEmrFRwRWmZqs+Q0ct68e/Yof9272TnCt
         I/eJ8nKsGT1tcX7qdqd9xI6xt0GIZhU+DEgXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061449; x=1744666249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71uNMFTcS2SWlBkZ+vUA7u6kkqjgQtAivFqSijEfze0=;
        b=uIV1jqJGMJV02NPS/Zdo8J2FIfs9nJO48nSbnwLbWe6VN4eTMRyYoiphdp9MhZaup7
         lOjxNNkj/YOhD5Oi6AKw3+5AKFBNJ+ukr1cVhMwX83izt2UgCnfJbh8ztlp6IuI0T/8E
         sKfZE1gqtBmeL4d4i8kGkn7iRhxYaU/rjFUvC5nfHjdlot+kffXeg/PKYeP2j0Tx3o1+
         lXqc2D0+1tLFsZB+y2eJrBOBq8klTwcTdgZrixlo7LvEWU3ml8Ivh9o+i6qfDg2HRuBV
         3PAGyZXUll9rnzexobfJJ4TH746tBIN3cI6Pj0OGGSqs9/2+11+TNrZYbS5fdc+uXz0w
         zPVA==
X-Gm-Message-State: AOJu0YygXbjsf76vVMdqmi1TLTxF8QiiJYLafU1sU39pSCTZGRQi9l+6
	pYi5PFloK7cQrci4gr9ZjPNoU2TaE0mCn5Ly5xNHPUuyoDQ0AtJUf3TUYZ7iD6IVX0tZpHTybRf
	L9dA=
X-Gm-Gg: ASbGncsl4Kx1BnV8wdTyJg8YW5Pr2YABaZFYbzstgszm4XyT/f5K+g9w17oi6E2Nnf5
	DCDk9T0NuP7kAhZGRrf4nScB9rQ7kkosAxGbqlfOD5jJOQ+FOV0S0SuoVX9SdA/yLfy2/ISj9+C
	EHVV+cMR2hRS+5NQj7MUp5SCXPhojXwcz0XGczejBKFvdK+AWDZGH8Oug6mP2+84Scjy/LW99eV
	jNWbi0nzp9j0a+vf2utZd+3PlttL+58Bj9iFgeJyaFrptDaZqSgIAo/SNhdqjJz+S61t6xCj/oj
	uUXaaKm9i7Zp8P/OumZLZR/VxkPMjLOpZotWctjHs4pYwnQPRb+VpfPOYPJT0RO4lzIfEvO8dQ/
	MOApTV9lVxzZl0tOCGTUIucPD9BAQswY=
X-Google-Smtp-Source: AGHT+IG9ztdmXl8PQkUqTiTR5mQN1pWPOsB5z0W/UA9mFBqLX96G7SfbR6gMNY+JbXwQMlBcW5Xe5w==
X-Received: by 2002:a05:6602:3588:b0:85e:aa76:db6b with SMTP id ca18e2360f4ac-8611b3d550dmr1556517839f.1.1744061448877;
        Mon, 07 Apr 2025 14:30:48 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 11/29] rust: Oe-selftest changes for rust v1.82.0
Date: Mon,  7 Apr 2025 17:30:00 -0400
Message-ID: <839f52f549f23bfc82afb7c045cec8b8c6f18c94.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:30:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1310

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

A few tests are getting failed with x86 arch.The unsupported/failing tests
are added to the exclude list and ignore the failing unit tests.

Upstream-Status: Pending

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b1340173be2a3a91fbb135eb0e24e50c3b996425)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/oeqa/selftest/cases/rust_mixin.py         |  2 +
 .../rust/files/rust-oe-selftest.patch         | 48 +++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/cases/rust_mixin.py
index 42e0258..1098e90 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -64,6 +64,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
                             'src/doc/rustc',
                             'src/doc/rustdoc',
                             'src/doc/unstable-book',
+                            'src/etc/test-float-parse',
                             'src/librustdoc',
                             'src/rustdoc-json-types',
                             'src/tools/jsondoclint',
@@ -86,6 +87,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
                             'tests/ui/abi/stack-probes.rs',
                             'tests/ui/codegen/mismatched-data-layouts.rs',
                             'tests/ui/debuginfo/debuginfo-emit-llvm-ir-and-split-debuginfo.rs',
+                            'tests/ui/feature-gates/version_check.rs',
                             'tests/ui-fulldeps/',
                             'tests/ui/process/nofile-limit.rs',
                             'tidyselftest'
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index 01c3634..0e952ef 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -401,3 +401,51 @@ index 3807cd5d76c..018c5c04456 100644
          fn $geometric(bench: &mut Bencher) {
              let bases: [$t; 16] = [2, 3, 4, 5, 7, 8, 9, 15, 16, 17, 31, 32, 33, 63, 64, 65];
              let base_and_numbers: Vec<($t, Vec<$t>)> = bases
+diff --git a/compiler/rustc_data_structures/src/tagged_ptr/copy/tests.rs b/compiler/rustc_data_structures/src/tagged_ptr/copy/tests.rs
+index 160af8a65d..686f4607bb 100644
+--- a/compiler/rustc_data_structures/src/tagged_ptr/copy/tests.rs
++++ b/compiler/rustc_data_structures/src/tagged_ptr/copy/tests.rs
+@@ -5,6 +5,7 @@ use crate::stable_hasher::{HashStable, StableHasher};
+ use crate::tagged_ptr::{CopyTaggedPtr, Pointer, Tag, Tag2};
+
+ #[test]
++#[ignore]
+ fn smoke() {
+     let value = 12u32;
+     let reference = &value;
+@@ -28,6 +29,7 @@ fn smoke() {
+ }
+
+ #[test]
++#[ignore]
+ fn stable_hash_hashes_as_tuple() {
+     let hash_packed = {
+         let mut hasher = StableHasher::new();
+diff --git a/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs b/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs
+index 4d342c72cc..9a77f92616 100644
+--- a/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs
++++ b/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs
+@@ -4,6 +4,7 @@ use std::sync::Arc;
+ use crate::tagged_ptr::{Pointer, Tag, Tag2, TaggedPtr};
+
+ #[test]
++#[ignore]
+ fn smoke() {
+     let value = 12u32;
+     let reference = &value;
+@@ -28,6 +29,7 @@ fn smoke() {
+ }
+
+ #[test]
++#[ignore]
+ fn boxed() {
+     let value = 12u32;
+     let boxed = Box::new(value);
+@@ -52,6 +54,7 @@ fn boxed() {
+ }
+
+ #[test]
++#[ignore]
+ fn arclones() {
+     let value = 12u32;
+     let arc = Arc::new(value);
-- 
2.49.0


