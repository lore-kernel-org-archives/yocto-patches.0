Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483EFD1953D
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:55:11 +0000 (UTC)
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36383.1769471705828882113
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:55:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=P1ODBB71;
 spf=pass (domain: konsulko.com, ip: 209.85.222.194, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c52c67f64cso508413285a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471705; x=1770076505; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIDn9xF7KfNrsYap8eV/omQe+DVQKTo78jUgVZDwcsc=;
        b=P1ODBB71/WTzf8MKdhzPKazIRQVHpHZJvgpSN3Lr4ckjn/iLbuA1IsObCkSXoIuUlJ
         o3MIOYUuOCKo/Nbck6Ta2MhaCxRRIAcECnnB5u5kULgARDyWHfGMLDTa+q4VMlrACyjt
         PEyckfgWjzfzy1P1mKYycKJvmjxIYJzqW6Bk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471705; x=1770076505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zIDn9xF7KfNrsYap8eV/omQe+DVQKTo78jUgVZDwcsc=;
        b=up27SZjhxNUm+8mATj+Fyatg47hZyLRAescZtacVZyPP6LkKcNilGwHd/hsk5XTZhY
         9iMFs2NJ4Cfjif13Lrtz+USS05Mf979J68YLjTH5nXKmUMGg3jB8uFwfcHFMgtP/PvF7
         VQjosxPumehJuT/iax51H7HPlIJdtx3EVBP3Y1XUfnQUDXtq/eLir/fRhDh0YaF8Y1if
         CR8NkbTnrvD28V0lQaD4+1mfg0n/p8FCBzu9WL0KwgwfayDv4DJJwD8OsSxPdUOTVz+P
         1pIfoZeIUm3ss9uCikngI01RGzIuEkQkpW/fi81+acMOs2ZWX9HaYulfscx8NZaG7l1I
         TV8A==
X-Gm-Message-State: AOJu0YwmM8jd/CZW3IaicT0Jb5X+9qWYaaSFXsk2C2KDpR54WkCFI/OO
	I+MOonp9tEl51oU2vsS4HhvRUC2BgrAVVSAzAZjhBkzgNW9ABaz1pHwuUwShm9jMYKVVN+d/27M
	6OEAhMmoqDw==
X-Gm-Gg: AZuq6aIOnoca3/FxfO+cVMLHr80QRI3MJ2/MS2piBjWPO5xuobUWKgJHSjHAGJV0Rpk
	hQf+EunahlOE9QWMP+t4p3e6LOJVC86x2DegDJ43v1lIUSPH8QNAdXxLUrnqZs86IT46vD2Bvoz
	QKv8nVntRRU4KRwBOGnR91CL/5GZXXhZQVyuptpGaXgz2depV9E/t4IsIluUsdCxuzVqlYCNF1J
	rfM3ld7l8Aq5HENURhESZ51DDCW5fVMjQikHhmDQQnVpLOavnb+39db00O1MFrNhIkkiK0t0JED
	zS1YIICjBF5RtaBTrk38hrXfAS03BO0Hqh0OP7g8/9JBl4/gckX0jFn/vOmefFRWsVc3GBGijEi
	T+d8gmA7XkQkZkp6gownsVhjQFlzfqILlLiDegN65bDK9vHIrVAkYLoAfv80lm4mIk+fTqY9n1K
	pBeu4R0RHr2lLmvm0E/TOLy+anzw2h2sv54EFcaS/QUqPhfSIB+ya7EhmuQmgbfhSbXu9Bm72MO
	xq4cyHPfqTZf/7uSYHFBBuFcvNNK/FffJALBlk17TqwUC4wsre3K/R38m9r0qg=
X-Received: by 2002:a05:620a:2688:b0:8c5:3574:90a7 with SMTP id af79cd13be357-8c6f968f8ffmr737455485a.80.1769471704336;
        Mon, 26 Jan 2026 15:55:04 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061740885a.15.2026.01.26.15.55.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:55:03 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 04/10] rust: remove passing tests from excluded and ignored list.
Date: Mon, 26 Jan 2026 18:54:50 -0500
Message-ID: <584cd36b17590cbdd5cf4af301b13fcd29642912.1769471543.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769471543.git.scott.murray@konsulko.com>
References: <cover.1769471543.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:55:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3106

From: Yash Shinde <Yash.Shinde@windriver.com>

Remove the ignore tags for passing riscv64 tests and
drop obsolete "tests/codegen-llvm/issues/issue-122805.rs"
from exclude test list.

The test was renamed to "dont-shuffle-bswaps.rs" and passes now:
https://github.com/rust-lang/rust/commit/3580698996f6da6f006477809d7959bffcfd3bf0

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b8fd1345a961cb34f81db4e4ff304ad244ee9a10)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/oeqa/selftest/cases/rust_mixin.py         |   1 -
 .../rust/files/rust-oe-selftest.patch         | 100 ------------------
 2 files changed, 101 deletions(-)

diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/cases/rust_mixin.py
index 3d06200..79e0dae 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -80,7 +80,6 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPTestResultTestCase):
                             'src/tools/tidy',
                             'tests/assembly-llvm/asm/aarch64-outline-atomics.rs',
                             'tests/assembly-llvm/c-variadic-arm.rs',
-                            'tests/codegen-llvm/issues/issue-122805.rs',
                             'tests/codegen-llvm/thread-local.rs',
                             'tests/mir-opt/',
                             'tests/run-make',
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index 7d26d75..b39b326 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -202,106 +202,6 @@ index a05f274136..0e69b4cb98 100644
  fn sparse_inserts() {
      let cache: VecCache<u32, u8, u32> = VecCache::default();
      let end = if cfg!(target_pointer_width = "64") && cfg!(target_os = "linux") {
-diff --git a/tests/assembly-llvm/dwarf-mixed-versions-lto.rs b/tests/assembly-llvm/dwarf-mixed-versions-lto.rs
-index 828328df843..30753c56c76 100644
---- a/tests/assembly-llvm/dwarf-mixed-versions-lto.rs
-+++ b/tests/assembly-llvm/dwarf-mixed-versions-lto.rs
-@@ -8,6 +8,7 @@
- //@ compile-flags: -C lto -g -Cdwarf-version=5
- //@ assembly-output: emit-asm
- //@ no-prefer-dynamic
-+//@ ignore-riscv64
- 
- extern crate dwarf_mixed_versions_lto_aux;
- 
-diff --git a/tests/codegen-llvm/const-vector.rs b/tests/codegen-llvm/const-vector.rs
-index f4307492341..617e31140e9 100644
---- a/tests/codegen-llvm/const-vector.rs
-+++ b/tests/codegen-llvm/const-vector.rs
-@@ -3,6 +3,7 @@
- //@ [OPT0_S390X] only-s390x
- //@ [OPT0] compile-flags: -C no-prepopulate-passes -Copt-level=0
- //@ [OPT0_S390X] compile-flags: -C no-prepopulate-passes -Copt-level=0 -C target-cpu=z13
-+//@ ignore-riscv64
- 
- // This test checks that constants of SIMD type are passed as immediate vectors.
- // We ensure that both vector representations (struct with fields and struct wrapping array) work.
-diff --git a/tests/codegen-llvm/enum/enum-aggregate.rs b/tests/codegen-llvm/enum/enum-aggregate.rs
-index 0161e5f3fa1..773a06fabb4 100644
---- a/tests/codegen-llvm/enum/enum-aggregate.rs
-+++ b/tests/codegen-llvm/enum/enum-aggregate.rs
-@@ -1,6 +1,7 @@
- //@ compile-flags: -Copt-level=0 -Cno-prepopulate-passes
- //@ min-llvm-version: 19
- //@ only-64bit
-+//@ ignore-riscv64
- 
- #![crate_type = "lib"]
- 
-diff --git a/tests/codegen-llvm/enum/enum-match.rs b/tests/codegen-llvm/enum/enum-match.rs
-index 57db44ec74e..1e2507f7c90 100644
---- a/tests/codegen-llvm/enum/enum-match.rs
-+++ b/tests/codegen-llvm/enum/enum-match.rs
-@@ -1,5 +1,6 @@
- //@ compile-flags: -Copt-level=1
- //@ only-64bit
-+//@ ignore-riscv64
- 
- #![crate_type = "lib"]
- #![feature(core_intrinsics)]
-diff --git a/tests/codegen-llvm/enum/enum-transparent-extract.rs b/tests/codegen-llvm/enum/enum-transparent-extract.rs
-index c5efb8d472b..e79b8916fc1 100644
---- a/tests/codegen-llvm/enum/enum-transparent-extract.rs
-+++ b/tests/codegen-llvm/enum/enum-transparent-extract.rs
-@@ -1,5 +1,6 @@
- //@ compile-flags: -Copt-level=0
- //@ only-64bit
-+//@ ignore-riscv64
- 
- #![crate_type = "lib"]
- 
-diff --git a/tests/codegen-llvm/repeat-operand-zero-len.rs b/tests/codegen-llvm/repeat-operand-zero-len.rs
-index b4cec42a07c..d450fead9a4 100644
---- a/tests/codegen-llvm/repeat-operand-zero-len.rs
-+++ b/tests/codegen-llvm/repeat-operand-zero-len.rs
-@@ -1,4 +1,5 @@
- //@ compile-flags: -Copt-level=1 -Cno-prepopulate-passes
-+//@ ignore-riscv64
- 
- // This test is here to hit the `Rvalue::Repeat` case in `codegen_rvalue_operand`.
- // It only applies when the resulting array is a ZST, so the test is written in
-diff --git a/tests/codegen-llvm/simd/extract-insert-dyn.rs b/tests/codegen-llvm/simd/extract-insert-dyn.rs
-index 729f0145314..2b1d1beb86a 100644
---- a/tests/codegen-llvm/simd/extract-insert-dyn.rs
-+++ b/tests/codegen-llvm/simd/extract-insert-dyn.rs
-@@ -1,4 +1,5 @@
- //@compile-flags: -C opt-level=3 -C no-prepopulate-passes
-+//@ ignore-riscv64
- 
- #![feature(
-     core_intrinsics,
-diff --git a/tests/codegen-llvm/transmute-scalar.rs b/tests/codegen-llvm/transmute-scalar.rs
-index ce1b0558b2e..e8fda2cd566 100644
---- a/tests/codegen-llvm/transmute-scalar.rs
-+++ b/tests/codegen-llvm/transmute-scalar.rs
-@@ -1,6 +1,7 @@
- //@ add-core-stubs
- //@ compile-flags: -C opt-level=0 -C no-prepopulate-passes --target=x86_64-unknown-linux-gnu
- //@ needs-llvm-components: x86
-+//@ ignore-riscv64
- 
- #![crate_type = "lib"]
- #![feature(no_core, repr_simd)]
-diff --git a/tests/codegen-llvm/uninhabited-transparent-return-abi.rs b/tests/codegen-llvm/uninhabited-transparent-return-abi.rs
-index face1577c3f..09e0846bad0 100644
---- a/tests/codegen-llvm/uninhabited-transparent-return-abi.rs
-+++ b/tests/codegen-llvm/uninhabited-transparent-return-abi.rs
-@@ -1,4 +1,5 @@
- //@ compile-flags: -Copt-level=3
-+//@ ignore-riscv64
- 
- // See https://github.com/rust-lang/rust/issues/135802
- 
 diff --git a/tests/ui/abi/rust-cold-works-with-rustic-args.rs b/tests/ui/abi/rust-cold-works-with-rustic-args.rs
 index 551485469d3..575db924968 100644
 --- a/tests/ui/abi/rust-cold-works-with-rustic-args.rs
-- 
2.51.0


