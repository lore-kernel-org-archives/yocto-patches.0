Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C395C55175
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4590.1785497608856926971
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BGkbIW/G;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e6391b114so64206685a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497608; x=1786102408; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hs/N5qMHyTZ4iSBUzN+Ar+b1o9duXTExN0dvWIvTJO4=;
        b=BGkbIW/GXfS+QX+u4HLwjhhTpHyWJpqtSz473joAIulOiFhCY+JB74fwiFvcvEeA8Q
         B53bpU33TucfF3xH3wj5HSaHnms2goa+k30gIDrZF936hyO0eolt6oQGG29sXswRGHyQ
         4KduWxbxZPC90izdWfk/OKeFm7q3l0CW4yZhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497608; x=1786102408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Hs/N5qMHyTZ4iSBUzN+Ar+b1o9duXTExN0dvWIvTJO4=;
        b=O1gW+wepbFhaK0108K5VWI4yT8+7Js5GVPMDrD9kwrYkS7Bc1w9v0VfNMwrI80d5P3
         fNOZ3tsDlbHCwUMErVNKVnQarFEj+tEXIeSZPhEVh6cvjNqGqNe8qDyEZwQGdyCC8vKN
         zIZSrdx1GSdaxCONKJUHbmsJRRA5SVP80zKrsv2iz5X3crQP8K3exP+59yeeo7lmmkUZ
         hzLM0WTIpi6e6/V3LEEqwEP4P/lu5nTj78g0aEQc6BbsTT7+IZMYvYBYVTbrfAZwOG37
         T+ke525JpJy6h5JVtuBDv98ku5BFGmszSi17kUoQe/Wc1zDHN0DSV6opy+oAcFr7l3GZ
         FkYg==
X-Gm-Message-State: AOJu0YxJTvSu8sdUULtsWJQILrTWagwJ+bb0fzsWHn4lRmkc5Df1zMwy
	CUXKEgowt9eOg1Bii6AOzFun8O6bS9+yLYHpnzETB9p1/LbRoEsUJ1tH6BH68UhCkKJ65CLoCqs
	WfBmu
X-Gm-Gg: AR+sD11b/GxvHXOm54FoZDbaSau8RZQ+qccgn5wfjHUeMYecmd5y5lfMlBLlIDa7U7w
	hd3d0SbcZ19YR38u8rUo73FVL5KBMp+phz8CKg9T3Aerc/JVFXAdT+OfGF0vJ8M57sh02TezlRh
	is6MpaW/qsWNOpsUnc6eitAMmfI82kfcAn1/U5EVee43SJ8vtycvN4VobHC2BQVcKso0gUpz40Y
	2vcqaUP4PiZ8TKVi2hiwz+IFSulFbji8lofNh/pZL5U9VpLjwUIUAt+ZImP/8VK6fEKBVwKHKet
	Yhw6u6p0BJwYh05Q4scGFHNU7nbGxb7OZkMUan/SKGZc2i6MxcktMiKH/bzca8WxN3YM7DnZadd
	XD2HY+LA+1aG/sjM6wofR3HpSAlf44241dZVhAitwc6mTu+os7ZTPOphA8Byzs2KlVdhfYnfOH6
	bec9rp4qyJV7F1QNEo0fpCBqZGkluAHkfAA6NaWUCaZ060WkZ93y7tPGzVo0BSYKi/PWSwVBrSf
	f9LM2iQrlbG4ipzw5XQMsWUrlW5qnYJkvPqRYQ+n9G6GKO4gEvibQJup40DbmdYmp5nDfFNSiOk
	dMLdq12qSE+1y0Zxif9qfxLEUkmW1DL4lB7x
X-Received: by 2002:a05:620a:f04:b0:92e:dddc:6588 with SMTP id af79cd13be357-9349687e8dbmr212200385a.42.1785497607578;
        Fri, 31 Jul 2026 04:33:27 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:27 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 13/35] rust: Fix loongarch unit test with llvm-22
Date: Fri, 31 Jul 2026 07:32:43 -0400
Message-ID: <e5f61549b7cd76649485a270c13763a98da8b217.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4589

From: Khem Raj <khem.raj@oss.qualcomm.com>

Adjust loongarch assembly test
This generates different code on loongarch32r now.

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
(adapted from oe-core commit ae70829cd01e48e50a88ef1857039c3dd162933e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../0001-Adjust-loongarch-assembly-test.patch | 66 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0001-Adjust-loongarch-assembly-test.patch

diff --git a/recipes-devtools/rust/files/0001-Adjust-loongarch-assembly-test.patch b/recipes-devtools/rust/files/0001-Adjust-loongarch-assembly-test.patch
new file mode 100644
index 0000000..67c649e
--- /dev/null
+++ b/recipes-devtools/rust/files/0001-Adjust-loongarch-assembly-test.patch
@@ -0,0 +1,66 @@
+From e015fc820db5d7fe2495c09b1fdd5e2092ed3cd1 Mon Sep 17 00:00:00 2001
+From: Nikita Popov <npopov@redhat.com>
+Date: Tue, 27 Jan 2026 12:03:48 +0100
+Subject: [PATCH] Adjust loongarch assembly test
+
+This generates different code on loongarch32r now.
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/e015fc820db5d7fe2495c09b1fdd5e2092ed3cd1]
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+---
+ tests/assembly-llvm/asm/loongarch-type.rs | 27 +++++++++++++++++------
+ 1 file changed, 20 insertions(+), 7 deletions(-)
+
+diff --git a/tests/assembly-llvm/asm/loongarch-type.rs b/tests/assembly-llvm/asm/loongarch-type.rs
+index e0a7940f89a..5efad583a39 100644
+--- a/tests/assembly-llvm/asm/loongarch-type.rs
++++ b/tests/assembly-llvm/asm/loongarch-type.rs
+@@ -1,10 +1,14 @@
+ //@ add-minicore
+-//@ revisions: loongarch32 loongarch64
++//@ revisions: loongarch32s loongarch32r loongarch64
+
+ //@ assembly-output: emit-asm
+
+-//@[loongarch32] compile-flags: --target loongarch32-unknown-none
+-//@[loongarch32] needs-llvm-components: loongarch
++//@[loongarch32s] compile-flags: --target loongarch32-unknown-none -Ctarget-feature=+32s
++//@[loongarch32s] needs-llvm-components: loongarch
++
++//@[loongarch32r] compile-flags: --target loongarch32-unknown-none
++//@[loongarch32r] needs-llvm-components: loongarch
++//@[loongarch32r] min-llvm-version: 22
+
+ //@[loongarch64] compile-flags: --target loongarch64-unknown-none
+ //@[loongarch64] needs-llvm-components: loongarch
+@@ -28,8 +32,12 @@
+
+ // CHECK-LABEL: sym_fn:
+ // CHECK: #APP
+-// CHECK: pcalau12i $t0, %got_pc_hi20(extern_func)
+-// CHECK: ld.{{[wd]}} $t0, $t0, %got_pc_lo12(extern_func)
++// loongarch64: pcalau12i $t0, %got_pc_hi20(extern_func)
++// loongarch64: ld.d $t0, $t0, %got_pc_lo12(extern_func)
++// loongarch32s: pcalau12i $t0, %got_pc_hi20(extern_func)
++// loongarch32s: ld.w $t0, $t0, %got_pc_lo12(extern_func)
++// loongarch32r: pcaddu12i $t0, %got_pcadd_hi20(extern_func)
++// loongarch32r: ld.w $t0, $t0, %got_pcadd_lo12(.Lpcadd_hi0)
+ // CHECK: #NO_APP
+ #[no_mangle]
+ pub unsafe fn sym_fn() {
+@@ -38,8 +46,13 @@ pub unsafe fn sym_fn() {
+
+ // CHECK-LABEL: sym_static:
+ // CHECK: #APP
+-// CHECK: pcalau12i $t0, %got_pc_hi20(extern_static)
+-// CHECK: ld.{{[wd]}} $t0, $t0, %got_pc_lo12(extern_static)
++// loongarch64: pcalau12i $t0, %got_pc_hi20(extern_static)
++// loongarch64: ld.d $t0, $t0, %got_pc_lo12(extern_static)
++// loongarch32s: pcalau12i $t0, %got_pc_hi20(extern_static)
++// loongarch32s: ld.w $t0, $t0, %got_pc_lo12(extern_static)
++// loongarch32r: pcaddu12i $t0, %got_pcadd_hi20(extern_static)
++// loongarch32r: ld.w $t0, $t0, %got_pcadd_lo12(.Lpcadd_hi1)
++
+ // CHECK: #NO_APP
+ #[no_mangle]
+ pub unsafe fn sym_static() {
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index c3e2ca7..843f837 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -9,6 +9,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-Update-call-llvm-intrinsics-test.patch;patchdir=${RUSTSRC} \
             file://0001-Fix-flaky-assertions-in-oneshot-tests.patch;patchdir=${RUSTSRC} \
             file://0001-Update-amdgpu-data-layout.patch;patchdir=${RUSTSRC} \
+            file://0001-Adjust-loongarch-assembly-test.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "0b53ae34f5c0c3612cfe1de139f9167a018cd5737bc2205664fd69ba9b25f600"
 
-- 
2.55.0


