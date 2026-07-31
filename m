Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4427C55180
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4594.1785497611851346326
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WxUhvE6z;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-934944f2d22so32000285a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497611; x=1786102411; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SXA2eFDtjlOj1e/qmi78bnnlF8+akuQFB4fiJqSYlxE=;
        b=WxUhvE6zZ+tUnbccgn8N66ziz+eCcYHuQwHJfr7GHDa7WX7ZuW4+LufpVm6USK27S2
         hXnXx6pTSpgsO/Xc407JGrE8QtLBnfN+OpuXQSRGwTr0d2rx/24NaJA4bFSu8fqOInNR
         LPbM3pBITtWgjhXYPWVkrNhgCXEYBqTjGPwD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497611; x=1786102411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SXA2eFDtjlOj1e/qmi78bnnlF8+akuQFB4fiJqSYlxE=;
        b=XKINO6NHQDlkJduP8EipZ7H0O4PjjUc3T39qYKlPM9wa8rgUBt9igeSQUK8EnVoEkx
         V9mZEFZDBSXBWz1GJ1u4qOyGHBSeMoeLm86NVCTnOSdWsHftrEZ/Rrj0vGpWWKIhrfJ7
         zn4dFp6SGM4QDN1ZuQ6NYwWC4RbsQrD3nnIjJCiR3VGnEdI3UZ5uv/jh3ujwlNOIUc3n
         HNKnesrZmvv8Vs1Xr2wrijsBlLhI1TwPW9IaoZDhKJoEvcLQhXLOcvRZlFADQkSuRF87
         bGNAcxNIg7Mw/lLJlCPkZt4JXpaQHI8WyIRIC663sKnOWB8FHEV2qabq42pxfhZ7oq7a
         EpeQ==
X-Gm-Message-State: AOJu0YzXIaXBWtS4K165K2nLEI75AaJz5syyjMINtCayVypTxXMRcpRs
	yt5l5CHiZYUAMuyHYxI00suk+7Ob2pbRyp77ZmjZ/SGmNhDApO6GU0W/ImJIpMXd1febjtBFLF9
	AKV0Q
X-Gm-Gg: AR+sD124LI6kOHDamoBEPdQ9MHdIM4wtGmlGNxyfG706lUKRpoJW155CgIfW4yWHOTL
	kjIH10NJNsYFV3wiR1LXWd1JZM9u21QcZPjaH73a953OdDY56nN4ZsN7ZlNpPTjIEhV08viUjSK
	le0957tJTBW4UVco0BX+2ukum0oDyVNTQVyOwumDJrSR0ATI4X97kzbSGhcZhIwntx9qwSsnRu+
	VQ/cbB+c81uveTMez0VTt/A03NjvQcizqy9cNjFC3ewpkT8Z70duWrnnQzXJdujCmAJ1XCtw7Yj
	vCaxxkCUG3Kfk+tWNeuHHS4wb+BB/fFV7Uo/ha5W0LnvaS9UGeVLqXkZVTN013rYaZli6B5sgLx
	zRi8oxi+aWO8GStv1NehVe0f3MSkDVsIh4uk3HM6r73ihBZLyfqIcND2FVs0pjMovBdp2SltzJ1
	zRLNf51nTraz9NgJliTgptN7Ktc+XWES5gWqBj5BMvnIGKCvtIWTBTipI+/ZwhZwI2ay5zypbQm
	4vIi9EApBYzIfhhAvfQ68ora4i+aMd1ffTZC9RQygIjmNvsfN26Ot0ahhglKHw55LwiCtdSJVkX
	UyAtsb69y4B//KRizGzrSQ8qVA==
X-Received: by 2002:a05:620a:245:b0:92e:59b0:df08 with SMTP id af79cd13be357-9349ba7297cmr95343185a.3.1785497610537;
        Fri, 31 Jul 2026 04:33:30 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:30 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 17/35] rust: fix codegen test failure on big-endian targets
Date: Fri, 31 Jul 2026 07:32:47 -0400
Message-ID: <4722ce0cc00f65fb0d0b510269b39242c194b479.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4593

From: Peter Tatrai <peter.tatrai.ext@siemens.com>

The test tests/codegen-llvm/issues/multiple-option-or-permutations.rs
uses FileCheck to verify LLVM IR for Option::or operations on slices.
The CHECK-NEXT directives assumed a little-endian memory layout where
the Option discriminant is the low byte, emitting a simple:

  trunc i16 %0 to i1

On big-endian targets (e.g. powerpc), the discriminant resides in the
high byte, so LLVM first emits an lshr before the trunc, causing the
test to fail.

Backport upstream fix from rust-lang/rust#151780 which introduces
BIG/LITTLE revisions with the only-endian-big / ignore-endian-big
directives (also backported via directive_names.rs change) to handle
both layouts correctly.

Fixes: rust-lang/rust#151718
Upstream-Status: Backport [https://github.com/rust-lang/rust/pull/151780]

Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit 1efb76b9698d025e9d8b3de2039e6a422b5f4bee)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...ion-or-permutations-test-for-big-end.patch | 121 ++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |   1 +
 2 files changed, 122 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0001-Fix-multiple-option-or-permutations-test-for-big-end.patch

diff --git a/recipes-devtools/rust/files/0001-Fix-multiple-option-or-permutations-test-for-big-end.patch b/recipes-devtools/rust/files/0001-Fix-multiple-option-or-permutations-test-for-big-end.patch
new file mode 100644
index 0000000..a36089c
--- /dev/null
+++ b/recipes-devtools/rust/files/0001-Fix-multiple-option-or-permutations-test-for-big-end.patch
@@ -0,0 +1,121 @@
+From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
+From: Ryan Ward <rwardd@users.noreply.github.com>
+Date: Tue, 28 Jan 2026 12:21:35 +0000
+Subject: [PATCH] Fix multiple-option-or-permutations test for big-endian
+ targets
+
+The FileCheck tests for Option::or on slices assumed little-endian
+layout. On big-endian targets (e.g. powerpc), the Option discriminant
+resides in the high byte, so LLVM emits an lshr before the trunc.
+
+Add only-endian-big directive support and use BIG/LITTLE revisions to
+cover both cases.
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/pull/151780]
+Signed-off-by: Ryan Ward <rwardd@users.noreply.github.com>
+Signed-off-by: Peter Tatrai <peter.tatrai.ext@siemens.com>
+---
+ .../compiletest/src/directives/directive_names.rs     |  1 +
+ .../issues/multiple-option-or-permutations.rs         | 47 ++++++++++++++++--
+ 2 files changed, 44 insertions(+), 4 deletions(-)
+
+diff --git a/src/tools/compiletest/src/directives/directive_names.rs b/src/tools/compiletest/src/directives/directive_names.rs
+index 9813ac7ff500d..334b2dda343a5 100644
+--- a/src/tools/compiletest/src/directives/directive_names.rs
++++ b/src/tools/compiletest/src/directives/directive_names.rs
+@@ -218,6 +218,7 @@ pub(crate) const KNOWN_DIRECTIVE_NAMES: &[&str] = &[
+     "only-eabihf",
+     "only-elf",
+     "only-emscripten",
++    "only-endian-big",
+     "only-gnu",
+     "only-i686-pc-windows-gnu",
+     "only-i686-pc-windows-msvc",
+diff --git a/tests/codegen-llvm/issues/multiple-option-or-permutations.rs b/tests/codegen-llvm/issues/multiple-option-or-permutations.rs
+index 9ec4ec8eeb159..8756d45eaa03e 100644
+--- a/tests/codegen-llvm/issues/multiple-option-or-permutations.rs
++++ b/tests/codegen-llvm/issues/multiple-option-or-permutations.rs
+@@ -1,4 +1,7 @@
+ // Tests output of multiple permutations of `Option::or`
++//@ revisions: LITTLE BIG
++//@ [BIG] only-endian-big
++//@ [LITTLE] ignore-endian-big
+ //@ compile-flags: -Copt-level=3 -Zmerge-functions=disabled
+ 
+ #![crate_type = "lib"]
+@@ -70,8 +73,16 @@ pub fn if_some_u8(opta: Option<u8>, optb: Option<u8>) -> Option<u8> {
+ #[no_mangle]
+ pub fn or_match_slice_u8(opta: Option<[u8; 1]>, optb: Option<[u8; 1]>) -> Option<[u8; 1]> {
+     // CHECK: start:
+-    // CHECK-NEXT: [[SOME_A:%.+]] = trunc i16 %0 to i1
+-    // CHECK-NEXT: [[R:%.+]] = select i1 [[SOME_A]], i16 %0, i16 %1
++    // LITTLE-NEXT: [[SOME_A:%.+]] = trunc i16 %0 to i1
++    // LITTLE-NEXT: [[R:%.+]] = select i1 [[SOME_A]], i16 %0, i16 %1
++    // BIG-NEXT: [[OPT_A:%.+]] = lshr i16 %0, 8
++    // BIG-NEXT: [[SOME_A:%.+]] = trunc i16 [[OPT_A]] to i1
++    // BIG-NEXT: [[OPT_B:%.+]] = lshr i16 %1, 8
++    // BIG-NEXT: [[A_OR_B:%.+]] = select i1 [[SOME_A]], i16 [[OPT_A]], i16 [[OPT_B]]
++    // BIG-NEXT: [[AGGREGATE:%.+]] = select i1 [[SOME_A]], i16 %0, i16 %1
++    // BIG-NEXT: [[R_LOWER:%.+]] = and i16 [[AGGREGATE]], 255
++    // BIG-NEXT: [[R_UPPER:%.+]] = shl nuw i16 [[A_OR_B]], 8
++    // BIG-NEXT: [[R:%.+]] = or disjoint i16 [[R_UPPER]], [[R_LOWER]]
+     // CHECK: ret i16 [[R]]
+     match opta {
+         Some(x) => Some(x),
+@@ -84,8 +95,16 @@ pub fn or_match_slice_u8(opta: Option<[u8; 1]>, optb: Option<[u8; 1]>) -> Option<[u8; 1]> {
+ #[no_mangle]
+ pub fn or_match_slice_alt_u8(opta: Option<[u8; 1]>, optb: Option<[u8; 1]>) -> Option<[u8; 1]> {
+     // CHECK: start:
+-    // CHECK-NEXT: [[SOME_A:%.+]] = trunc i16 %0 to i1
+-    // CHECK-NEXT: [[R:%.+]] = select i1 [[SOME_A]], i16 %0, i16 %1
++    // LITTLE-NEXT: [[SOME_A:%.+]] = trunc i16 %0 to i1
++    // LITTLE-NEXT: [[R:%.+]] = select i1 [[SOME_A]], i16 %0, i16 %1
++    // BIG-NEXT: [[OPT_A:%.+]] = lshr i16 %0, 8
++    // BIG-NEXT: [[SOME_A:%.+]] = trunc i16 [[OPT_A]] to i1
++    // BIG-NEXT: [[OPT_B:%.+]] = lshr i16 %1, 8
++    // BIG-NEXT: [[A_OR_B:%.+]] = select i1 [[SOME_A]], i16 [[OPT_A]], i16 [[OPT_B]]
++    // BIG-NEXT: [[AGGREGATE:%.+]] = select i1 [[SOME_A]], i16 %0, i16 %1
++    // BIG-NEXT: [[R_LOWER:%.+]] = and i16 [[AGGREGATE]], 255
++    // BIG-NEXT: [[R_UPPER:%.+]] = shl nuw i16 [[A_OR_B]], 8
++    // BIG-NEXT: [[R:%.+]] = or disjoint i16 [[R_UPPER]], [[R_LOWER]]
+     // CHECK: ret i16 [[R]]
+     match opta {
+         Some(_) => opta,
+@@ -98,8 +117,16 @@ pub fn or_match_slice_alt_u8(opta: Option<[u8; 1]>, optb: Option<[u8; 1]>) -> Option<[u8; 1]> {
+ #[no_mangle]
+ pub fn option_or_slice_u8(opta: Option<[u8; 1]>, optb: Option<[u8; 1]>) -> Option<[u8; 1]> {
+     // CHECK: start:
+-    // CHECK-NEXT: [[SOME_A:%.+]] = trunc i16 %0 to i1
+-    // CHECK-NEXT: [[R:%.+]] = select i1 [[SOME_A]], i16 %0, i16 %1
++    // LITTLE-NEXT: [[SOME_A:%.+]] = trunc i16 %0 to i1
++    // LITTLE-NEXT: [[R:%.+]] = select i1 [[SOME_A]], i16 %0, i16 %1
++    // BIG-NEXT: [[OPT_A:%.+]] = lshr i16 %0, 8
++    // BIG-NEXT: [[SOME_A:%.+]] = trunc i16 [[OPT_A]] to i1
++    // BIG-NEXT: [[OPT_B:%.+]] = lshr i16 %1, 8
++    // BIG-NEXT: [[A_OR_B:%.+]] = select i1 [[SOME_A]], i16 [[OPT_A]], i16 [[OPT_B]]
++    // BIG-NEXT: [[AGGREGATE:%.+]] = select i1 [[SOME_A]], i16 %0, i16 %1
++    // BIG-NEXT: [[R_LOWER:%.+]] = and i16 [[AGGREGATE]], 255
++    // BIG-NEXT: [[R_UPPER:%.+]] = shl nuw i16 [[A_OR_B]], 8
++    // BIG-NEXT: [[R:%.+]] = or disjoint i16 [[R_UPPER]], [[R_LOWER]]
+     // CHECK: ret i16 [[R]]
+     opta.or(optb)
+ }
+@@ -109,8 +136,16 @@ pub fn option_or_slice_u8(opta: Option<[u8; 1]>, optb: Option<[u8; 1]>) -> Option<[u8; 1]> {
+ #[no_mangle]
+ pub fn if_some_slice_u8(opta: Option<[u8; 1]>, optb: Option<[u8; 1]>) -> Option<[u8; 1]> {
+     // CHECK: start:
+-    // CHECK-NEXT: [[SOME_A:%.+]] = trunc i16 %0 to i1
+-    // CHECK-NEXT: [[R:%.+]] = select i1 [[SOME_A]], i16 %0, i16 %1
++    // LITTLE-NEXT: [[SOME_A:%.+]] = trunc i16 %0 to i1
++    // LITTLE-NEXT: [[R:%.+]] = select i1 [[SOME_A]], i16 %0, i16 %1
++    // BIG-NEXT: [[OPT_A:%.+]] = lshr i16 %0, 8
++    // BIG-NEXT: [[SOME_A:%.+]] = trunc i16 [[OPT_A]] to i1
++    // BIG-NEXT: [[OPT_B:%.+]] = lshr i16 %1, 8
++    // BIG-NEXT: [[A_OR_B:%.+]] = select i1 [[SOME_A]], i16 [[OPT_A]], i16 [[OPT_B]]
++    // BIG-NEXT: [[AGGREGATE:%.+]] = select i1 [[SOME_A]], i16 %0, i16 %1
++    // BIG-NEXT: [[R_LOWER:%.+]] = and i16 [[AGGREGATE]], 255
++    // BIG-NEXT: [[R_UPPER:%.+]] = shl nuw i16 [[A_OR_B]], 8
++    // BIG-NEXT: [[R:%.+]] = or disjoint i16 [[R_UPPER]], [[R_LOWER]]
+     // CHECK: ret i16 [[R]]
+     if opta.is_some() { opta } else { optb }
+ }
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 19acf5f..49dd20a 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -10,6 +10,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-Fix-flaky-assertions-in-oneshot-tests.patch;patchdir=${RUSTSRC} \
             file://0001-Update-amdgpu-data-layout.patch;patchdir=${RUSTSRC} \
             file://0001-Adjust-loongarch-assembly-test.patch;patchdir=${RUSTSRC} \
+            file://0001-Fix-multiple-option-or-permutations-test-for-big-end.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "174fce10ce012317ca995810296d8af199318838180b03d68a853e0f02d4b571"
 
-- 
2.55.0


