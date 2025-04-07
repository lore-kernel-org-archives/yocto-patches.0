Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5147EC36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:30:54 +0000 (UTC)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
 by mx.groups.io with SMTP id smtpd.web11.59603.1744061452068434215
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bvzGUc8e;
 spf=pass (domain: konsulko.com, ip: 209.85.166.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d57143ee39so39253505ab.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061451; x=1744666251; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LkLXRCGFSErUPzfmY30qggr2N4Lds8BSaXqlE4DwQQ=;
        b=bvzGUc8eVztHCcukPCtCKfq8v8V5I36hZ0ukvrBFjFs+RvNJ8dU4M9CTT9Mpd00O7q
         xny32HhmQxhXYMQfh08Pefv+6uQ9MBNOCACuUY7PP/0J4/Fyg2gi9+6/uBe/C59esbwU
         7YBvYnZ8f+H7nMiCkKibjwu3JNH7glJGNLVmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061451; x=1744666251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LkLXRCGFSErUPzfmY30qggr2N4Lds8BSaXqlE4DwQQ=;
        b=F4ZIy2AslPlgiN4AjAgRNSa7bDjwvVh4F7aAva7PGP+1Ej4KxoTnxvWf7Ic7qDgjGF
         Kc9ABrkNK8uyZaR12NxUvUN+na2S8mPOuIAwSC+suxJmLiMSeOHgnBY6bzv2owd2qcQh
         D5VWFoCaCpYYgFosHOhQ0jCHs7xk9w2v42M0dU/g0JHdHn4lHtM+WvnYKhklK1f+LRhp
         HcX+yUUdrJdIHaDkQ0U7HXAnK9a8TXMbmsnBNRC69/b1Y0Jez15bj8j+VSDnEAadn/IY
         bdc/ELEZTzypyLiXLZwj6JT5K6SoFi4padaMG2uxjjWqhg1ZR0y+rSC3Jy6aUr13ptto
         Ib+w==
X-Gm-Message-State: AOJu0YwxEE6eSXkl+Hk7zvky9bHHGSaF7giBngqwHJs6TDsV162nzk0s
	duttQZvmOafjy3aOxccFeDuqvFnSNRO6BBXAIHpPY5JA7Qg3pisb4CuXKKZagxcJHjeUT/u5Vns
	Wbec=
X-Gm-Gg: ASbGnctS2ndn1eCDgOjmtNvrArKhlBWI13TBBqCN7VY9jZ3PS8znTdQYaIMZs3qHZsm
	vCwMtF9kYbXMbJMzxW4Ggtq8hKTvbZnzinlt5i/YuFh+c2bFBWBzhyqX+oMNSH/g6IE7dcXS/Gf
	Pirs+/8/Mw5v/RUJJy6RDr3XwEFK6vYRsrlLFpGKwrjCW3sOe+eAVGrQTFxJqa/CmpExR/lxs5A
	XcohNLp5t+xCGP5St/M8jNnGItZSAV5MEvyOBoMXFMTtnT361JaiYbNI9ntuVqqsVEgIRIkVsnG
	tDUQs1oKzeyk1IhNnceFL6HwxNXdy3OMMCclqLYIO0rJk8pbvUpW0RSyXUh70yebXyUa4fWcHYU
	1MC0dydiWrcyt7mVaYxhs
X-Google-Smtp-Source: AGHT+IF67hby8n/WABl1JKrZmg4wEAesNyhGLUdW1KVzee+2mi8BzkA5Q5MZ52tjsQ1GC/+ceLVb2g==
X-Received: by 2002:a05:6e02:2701:b0:3d4:2409:ce6 with SMTP id e9e14a558f8ab-3d6e3ee1a2cmr128320255ab.5.1744061450979;
        Mon, 07 Apr 2025 14:30:50 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:50 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 13/29] rust-llvm: Fix build break found with clang
Date: Mon,  7 Apr 2025 17:30:02 -0400
Message-ID: <f3c5abf3fbb5da4d0682011ecf2f330e9e85c668.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:30:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1313

From: Khem Raj <raj.khem@gmail.com>

call and callee have mismatched types, this patch fixes it

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Randy MacLeod <Randy.MacLeod@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 88e5970998fb4c72844056be19e3a9f77de3f4d6)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../0001-NFC-fix-build-failure-100993.patch   | 30 +++++++++++++++++++
 recipes-devtools/rust/rust-llvm_1.82.0.bb     |  4 ++-
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 recipes-devtools/rust/rust-llvm/0001-NFC-fix-build-failure-100993.patch

diff --git a/recipes-devtools/rust/rust-llvm/0001-NFC-fix-build-failure-100993.patch b/recipes-devtools/rust/rust-llvm/0001-NFC-fix-build-failure-100993.patch
new file mode 100644
index 0000000..ed26de7
--- /dev/null
+++ b/recipes-devtools/rust/rust-llvm/0001-NFC-fix-build-failure-100993.patch
@@ -0,0 +1,30 @@
+From 40b4fd7a3e81d32b29364a1b15337bcf817659c0 Mon Sep 17 00:00:00 2001
+From: Chen Zheng <czhengsz@cn.ibm.com>
+Date: Tue, 30 Jul 2024 09:02:07 +0800
+Subject: [PATCH] [NFC] fix build failure (#100993)
+
+Fix the build failure caused by
+https://github.com/llvm/llvm-project/pull/94944
+
+Fixes https://github.com/llvm/llvm-project/issues/100296
+Upstream-Status: Backport [https://github.com/llvm/llvm-project/commit/40b4fd7a3e81d32b29364a1b15337bcf817659c0]
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+---
+ llvm/lib/Analysis/ConstantFolding.cpp | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/llvm/lib/Analysis/ConstantFolding.cpp b/llvm/lib/Analysis/ConstantFolding.cpp
+index 85ee231675d0..084647b1d9d9 100644
+--- a/llvm/lib/Analysis/ConstantFolding.cpp
++++ b/llvm/lib/Analysis/ConstantFolding.cpp
+@@ -1782,8 +1782,8 @@ Constant *ConstantFoldFP(double (*NativeFP)(double), const APFloat &V,
+ }
+ 
+ #if defined(HAS_IEE754_FLOAT128) && defined(HAS_LOGF128)
+-Constant *ConstantFoldFP128(long double (*NativeFP)(long double),
+-                            const APFloat &V, Type *Ty) {
++Constant *ConstantFoldFP128(float128 (*NativeFP)(float128), const APFloat &V,
++                            Type *Ty) {
+   llvm_fenv_clearexcept();
+   float128 Result = NativeFP(V.convertToQuad());
+   if (llvm_fenv_testexcept()) {
diff --git a/recipes-devtools/rust/rust-llvm_1.82.0.bb b/recipes-devtools/rust/rust-llvm_1.82.0.bb
index 509b507..17d49be 100644
--- a/recipes-devtools/rust/rust-llvm_1.82.0.bb
+++ b/recipes-devtools/rust/rust-llvm_1.82.0.bb
@@ -10,7 +10,9 @@ require rust-source.inc
 
 SRC_URI += "file://0002-llvm-allow-env-override-of-exe-path.patch;striplevel=2 \
             file://0001-AsmMatcherEmitter-sort-ClassInfo-lists-by-name-as-we.patch;striplevel=2 \
-	    file://0003-llvm-fix-include-benchmarks.patch;striplevel=2"
+            file://0003-llvm-fix-include-benchmarks.patch;striplevel=2 \
+            file://0001-NFC-fix-build-failure-100993.patch;striplevel=2 \
+           "
 
 S = "${RUSTSRC}/src/llvm-project/llvm"
 
-- 
2.49.0


