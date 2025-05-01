Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50EFC3ABAA
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:51 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web11.4646.1746132050103543621
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rdWHe5u1;
 spf=pass (domain: konsulko.com, ip: 209.85.219.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so31402466d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132049; x=1746736849; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LkLXRCGFSErUPzfmY30qggr2N4Lds8BSaXqlE4DwQQ=;
        b=rdWHe5u17pnOwEbnnnCmpW1yNANSLC4XEMOgBgqXNGsx665Cqz6xCAQrP8mD9eGa2L
         n48Vy4KKwjwNVQ4bkMqMuO11niFUgcT2S9slAV4drJEH6rthCC4Mz7+vjo3P2qBrlp6A
         WK3hgPlpAdMBZzIx+BJCE1OH2u8MMKQmLc8DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132049; x=1746736849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LkLXRCGFSErUPzfmY30qggr2N4Lds8BSaXqlE4DwQQ=;
        b=D0JihC6o2bmE/o5VlJvqDZBSLuqeV6/tpMxB+ffEllEB1cqv9tmKmgf1qbbdz4c/TF
         IiHS2KFyEYBgZxWF+oTd2zI/XruLkf9aI8Pm1N+BkfF9i5tjdDn7ApQx8tphalZpOdYR
         IGElzHTEiDlaM6L8hO5+4zKiWGgSLoPoPNhkTAyM2ph108Z3w1XaDmvijVeYZf/pv2El
         290W5ejybz+V1S3y8N/L6QX5FE4jR6Q7XDkK21bZn7wWPudvkJnzEvG4AzaVT8A0UGGL
         aMBueZxQqyzqOGVib39CaTQB5LxP6YLhDIoFV/Ad3mUrR0q5HKj1wq+Sf9RFqK4Quh57
         JnMQ==
X-Gm-Message-State: AOJu0YzGORTm33G8Chr5+i+lJ6iWFes+eiku+ariuwFxDhy7a4sxywaN
	mRfefSjZGLPv8UwNLt26EGnbTs38SYPY5fLrIq6QRQ+9Z3OzXckZ3sTSUF6YXuPdLtBySiFLTB8
	d
X-Gm-Gg: ASbGncuVQ8yQJ7o/okL43rYI7xD9uSkaNSds1w8PuJSXB905hdzL/IsENplFemDleDN
	WrkAz+yyQ+o1RMxqz9ZdfKKWUqfdWp8JGPIsTpIvN3HAvi0ertqaNwnYyhHBp4IF5LZEVdA8RUc
	YcoRSXhCYS2BxmVtFxTuPs03uEq9TaR4uAzjs6KtXAL7vBejRa137kgWgrfpYzQwarktmUoaVHL
	TNaWvXy26kBgA358fW5BMT+8cTFq2sZH9HN8CCzttRqpNGmAdEWxZXjdLxVjzGxPa/j4+6mghoM
	xntHv0Vtaa9S61qVvmY33C0AxIxwyiUE5oCriVsvYsB8hRUXZsWWeGmtrcDtrgt2R+e0zziKaOV
	aDFdREWzqtQHA0OKU
X-Google-Smtp-Source: AGHT+IEsQGstUFEQMU+Ln8iIe1xcqN4Qdpy/driEpvesg4iJAvgviZ0+zda5hQAnCTxER8tZt+ercw==
X-Received: by 2002:a05:6214:528a:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6f5155fdbc6mr10245756d6.15.1746132048775;
        Thu, 01 May 2025 13:40:48 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 14/38] rust-llvm: Fix build break found with clang
Date: Thu,  1 May 2025 16:39:50 -0400
Message-ID: <57c6703e609b197ab3a8cd531f89d9ef0c2d4cdf.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1441

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


