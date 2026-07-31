Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FF3C55180
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:45 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4480.1785497624839040358
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PcjPtDzh;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e50a650a0so43710285a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497624; x=1786102424; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ItScaWHYi+MRO26g6l04XyElSnuUZoc3i81gqB31sm4=;
        b=PcjPtDzh6SSQ5ZzLoRRlFcRL2z6Foj+s/z+YXhbJXJo8lkabpVRx+GjP9zJSsdcRwh
         9XNaNfTGs5Mu7KOrlIx0bEH9Obtb6gJAAi+fP6vD7yc3fxPOqbBIUt/INiXO1s6SK7yw
         tQI6Jn4bLQiBBEyVUYcLNrfMjwaJOIcwqVbA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497624; x=1786102424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ItScaWHYi+MRO26g6l04XyElSnuUZoc3i81gqB31sm4=;
        b=fejYFNXaVU2n6agtwgdw1yx2XgKYa9Bp57Jmq9T9gowaWhp2P8LxkDWFdYl2jK4zyJ
         9qdDBoP85rDoXUDCtqfwIViJxRCj0BsmDzZholjIROmdAh4hSeAdNmOs32fpVImFQDCx
         sT5AiSNAM7ZWl7oOFlqDU6OSrVXbmBAAVSBXITSVaQmWCLJewpOIW+CkOeJd9xkZSd3H
         3jur8mShJcZptrecNvRuxqmAhaAEZxys1PvtkNnPE2HJ4aFDXE0Xkc5G3TdZGrtNrBYS
         9AEuh+n9E+xi+CuJcZIhRfA4okHTktVfVCTe1YopMddBzpXwaYcdpv8I0Lnm9+ZFU3TL
         /0cQ==
X-Gm-Message-State: AOJu0YwtzV/eYll9m5MkuulWDOBcgloPki+VFw0Omr8mcbC4tVUVyJ1h
	BLKmk3HBkjyLlWW6MiJKnm3a9t+/ybmc43oqNhzUb+eB3euwXWQfhbC8Xu+3OGdxF4qyafcsYE/
	VNpMO
X-Gm-Gg: AR+sD11LaLSpsrXgNRiuEHSG/zJzL5JSmrSqla0FWpiBcgZhQIxKbb7YDWcF9cHw1az
	0x5yHa8hCxHuBbMdVFoWpHeMF+oLSkueCdfgTu+as07LiR9q2zQYVWVMeCc9lLwmEbmM6HH6vzX
	zFbQGzbNamAHoo1/RnBYKQK+dhHt9HyuinH++w1lEf1YXPifEfPz+uN58t8UYaxpOVI/+MpxUdV
	qQ/AwHmhuP6nd/hX9GRru96oZ+ZzjTEZtqfvW06Bog1gnNZvuEGMpltJ3xFInfwItg1+1T5aP1m
	5MN1AvAqOZ/XC/sMfLsmma4Pp5sir2HYOl4kgiu4oS85sVShI1CHoYDKP52GUIXg+YKATLz5aIi
	G08oEbHFvE8aqZ/uIGzBM+OnVY4mOVM5T8NjdIpMpqvD9oyIjuVHlARLLKYFt1mcR+NS+L3niIi
	wPOlk3+KsjvK4Lv9Yqpp1IxZ1KS5PMXo6GM+H26au3aXrFkySmPqxxnb709ypctdVEhEogRzT+u
	ft/M5u5bZ7txxMj/Q9fwXjXKy9X54NuVx8DIS/hw4AJPbbIrqszIpbVqgO8pvtDaULdKyYLEPtC
	XeIDDtCyRGCveBlWfeeTVqBxAQ==
X-Received: by 2002:a05:620a:4382:b0:930:fad2:fd with SMTP id af79cd13be357-9349ba3cce7mr125872385a.17.1785497623485;
        Fri, 31 Jul 2026 04:33:43 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:42 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 31/35] rust-target-config: armv8a AArch32 Thumb build fixes
Date: Fri, 31 Jul 2026 07:33:01 -0400
Message-ID: <d83c562441b7d892efee721c260ee7651d553ea0.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4607

From: Alex Kiernan <alexk@a-squared-projects.uk>

llvm_features_from_tune() calls target_is_armv7() to gate both the +v7
LLVM feature and the +thumb2 feature. target_is_armv7() (in
rust-common.bbclass) only recognises armv7a/armv7r/armv7m/armv7ve -- it
returns False for armv8a.  As a result an ARMv8-A AArch32 Thumb build
gets "+neon,+thumb-mode" in the target JSON but neither "+v8" nor
"+thumb2".

LLVM's ParseARMTriple() returns "" for "arm-..." triples
(ARM::parseArch("arm") = INVALID), leaving HasV4TOps unset in the
MCSubtargetInfo used for module-level inline asm parsing.  The ARM ASM
parser's hasThumb() then returns false and ".thumb" directives in
compiler_builtins naked-function trampolines (__aeabi_uldivmod etc.)
are rejected.

This produces two failures when building libstd-rs / compiler_builtins:

  1. core: "LLVM ERROR: Cannot select: br" in core::fmt::num -- LLVM ARM
     ISel patterns for Thumb-2 unconditional branches (t2B) are gated on
     HasV8Ops as well as IsThumb2; without +v8 the pattern never fires.

  2. compiler_builtins: "target does not support Thumb mode" on .thumb
     directives in naked-function trampolines (__aeabi_uldivmod etc.) --
     two separate paths both require +thumb2: HasV4TOps in the
     MCSubtargetInfo (set transitively via ParseARMTriple) and
     FeatureThumb2 in the code-gen ARMSubtarget.

The natural fix would be to change RUST_TARGET_SYS to "armv8a-...", but
"armv8a" is not a recognised Rust target architecture so the triple is
not valid there.  Instead rust_sys_to_llvm_target() rewrites only the
JSON llvm-target field, leaving RUST_TARGET_SYS and rust-common.bbclass
unchanged.

- Add +v8 to llvm_features_from_tune for armv8a AArch32.

- Add +thumb2 to llvm_features_from_tune for armv8a AArch32 Thumb.

- Extend rust_sys_to_llvm_target() to accept the datastore and rewrite
  the "arm-..." triple to "armv8a-..." for armv8a AArch32 targets, so
  the JSON llvm-target field uses "armv8a-..." while RUST_TARGET_SYS
  keeps "arm-...".  ParseARMTriple then adds "+armv8-a" to the
  MCSubtargetInfo, transitively setting HasV4TOps and making hasThumb()
  return true.

The TARGET_ARCH == 'arm' guard is required because AArch64 tunes also
carry armv8a in TUNE_FEATURES (via arch-armv8a.inc) but must not be
affected.

AI-Generated: Claude Code (Claude Opus 4.8)
Signed-off-by: Alex Kiernan <alex.kiernan@gmail.com>
Signed-off-by: Alex Kiernan <alexk@a-squared-projects.uk>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 1808270d6cbfc7b21e911c9dc1fda3e78379701b)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index f10e8b6..33280ed 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -19,6 +19,8 @@ def llvm_features_from_tune(d):
     mach_overrides = d.getVar('MACHINEOVERRIDES')
     mach_overrides = frozenset(mach_overrides.split(':'))
 
+    target_arch = d.getVar('TARGET_ARCH')
+
     if 'vfpv4' in feat:
         f.append("+vfp4")
     elif 'vfpv4d16' in feat:
@@ -46,6 +48,9 @@ def llvm_features_from_tune(d):
     if target_is_armv7(d):
         f.append('+v7')
 
+    if 'armv8a' in feat and target_arch == 'arm':
+        f.append('+v8')
+
     if ('armv6' in mach_overrides) or ('armv6' in feat):
         f.append("+v6")
     if 'armv5te' in feat:
@@ -63,7 +68,8 @@ def llvm_features_from_tune(d):
 
     if 'thumb' in feat:
         if d.getVar('ARM_THUMB_OPT') == "thumb":
-            if target_is_armv7(d):
+            if target_is_armv7(d) or \
+                    ('armv8a' in feat and target_arch == 'arm'):
                 f.append('+thumb2')
             f.append("+thumb-mode")
 
@@ -281,7 +287,16 @@ def arch_to_rust_target_arch(arch):
         return arch
 
 # Convert a rust target string to a llvm-compatible triplet
-def rust_sys_to_llvm_target(sys):
+def rust_sys_to_llvm_target(sys, d):
+    # For AArch32 ARMv8-A, RUST_TARGET_SYS stays "arm-..." because "armv8a" is not a
+    # valid Rust target architecture. Rewrite llvm-target to "armv8a-..." here so
+    # ParseARMTriple adds "+armv8-a" and transitively sets HasV4TOps in the
+    # MCSubtargetInfo used for module-level inline asm parsing, making hasThumb()
+    # return true for .thumb directives.
+    if sys.startswith('arm-') and \
+            'armv8a' in (d.getVar('TUNE_FEATURES') or '').split() and \
+            d.getVar('TARGET_ARCH') == 'arm':
+        return 'armv8a-' + sys[4:]
     if sys.startswith('riscv32gc-'):
         return sys.replace('riscv32gc-', 'riscv32-', 1)
     if sys.startswith('riscv64gc-'):
@@ -365,7 +380,7 @@ def rust_gen_target(d, thing, wd, arch):
 
     # build tspec
     tspec = {}
-    tspec['llvm-target'] = rust_sys_to_llvm_target(rustsys)
+    tspec['llvm-target'] = rust_sys_to_llvm_target(rustsys, d)
     tspec['data-layout'] = d.getVarFlag('DATA_LAYOUT', arch_abi)
     if tspec['data-layout'] is None:
         bb.fatal("No rust target defined for %s" % arch_abi)
-- 
2.55.0


