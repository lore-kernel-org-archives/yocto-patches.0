Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28B3D1953A
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:51:40 +0000 (UTC)
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35704.1769471493083431197
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:51:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DEDENvov;
 spf=pass (domain: konsulko.com, ip: 209.85.219.65, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8947404b367so63381916d6.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471492; x=1770076292; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIDn9xF7KfNrsYap8eV/omQe+DVQKTo78jUgVZDwcsc=;
        b=DEDENvovzPoe8QLmZs8LuVjZj4/1ZhDoaouXIGqMjRRMZl7XT4H0ngZfdDTWSqG7i3
         TdjaS/tFmbsXLYQRYO0IXr6X6VK0X4dEjSEqSWT/z2d6VuRGaSba1BdaqIYBUxkn0eSZ
         P1CJT6kkEQDxCpQ6ktJNSbU+yH52nXGivRHOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471492; x=1770076292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zIDn9xF7KfNrsYap8eV/omQe+DVQKTo78jUgVZDwcsc=;
        b=ZyEnMCindZPhaGdkJjZz2c6ivu2ypkPuL134+P6it8QM2rfYmQdYrjPuVVGrPnQVWH
         XGxjvxM6HJ6DyTbNNiUy8ZuKl5Wm0FZD5iwpAJ1AgjOBX3SIlp6JWOCEvP6JEoHXxJ+Z
         Tk4oZT/SWz4MvmK5C7yRLcpWh9afaOm+qFtpPUTVXseUcrPWV/6MD+pnzdOcR82o5gHF
         IpjzbsRwmSvslYHfsr/VVdeDeVRbHWlxyyWKhp1iaenSyEmS4inwALtjF/7+c0BRZfdo
         KaLy7Z4+k67mScpuwR6hdOerhEgyOkdtZk9YvPPmWfLAvAFhz9XuwqIIF/cMi+P52Ij2
         A4dw==
X-Gm-Message-State: AOJu0YzNfFA53GzBFbTn7zQwoobUcHZoBR9GPknPejPx54p9JRavFY24
	HIwU5FySMbvNYAsxUfM/WpEKrkTVs+T43vLxXOdyyO5e775bzSazLwphQuiOlHRkhUTL/S04O+L
	0XFY3g/EeNw==
X-Gm-Gg: AZuq6aLCRE2+p8StL6SLGBm4XaJvEylsfwkHFjK8asA4mQ2M0K9W8WESrnZ/04oqgN2
	Gy4WkxCyhEf5b+V9jyOkncbh79cfMEgkycPhJujjAUaLLmCCts/oC8eYMXPkwlGXfPtP2l5ft/N
	LOG3HMl4ViJSYNPxBOLO7azWcmNbu/dma9KEGJibSFi98yDWtguJWbQJdC4gkNff3xxkjruQNjI
	0oabLw4dp1IxYXgerxzMoYXFw2VYD1EMA3QPnSajy8OmOo/K85VDhe47AHxG4V8Ni7zNIstlo3o
	lW5xsdacNq4YH8cWLSRuSKhwIOV2fcfXmiDUujBxj1UgxQ/o7JODrRmD5tC8yRtnyGfoBkTLJaY
	0kYLaU01cv2u4wT13nVfn6vGXdSgcebH3CLGxv2dSKkU6KrCZkk7ORahHkytcTZvfU++NJaPCvn
	sVDgk3p+aI/KfiszPSnOKe0o0S8Prlus1MIIujhG00L5540zJFCaMsp2jAKUzfWqBJjIWugAtv0
	58Vgv2W4fI+HDF79LRetxjKLW2iFGdb7FarDxqi6m9yhUqbDgjO
X-Received: by 2002:a05:620a:1708:b0:8b2:ec1e:fe24 with SMTP id af79cd13be357-8c6f963bc66mr756578985a.42.1769471491740;
        Mon, 26 Jan 2026 15:51:31 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061293885a.15.2026.01.26.15.51.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:51:31 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 04/11] rust: remove passing tests from excluded and ignored list.
Date: Mon, 26 Jan 2026 18:51:08 -0500
Message-ID: <120e5b11e3426439885a75a0384e05b6db623dcd.1769470900.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769470900.git.scott.murray@konsulko.com>
References: <cover.1769470900.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:51:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3094

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


