Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F07C369DC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 22:16:04 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.web10.6711.1746137761584675752
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 15:16:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GJlItTbH;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c9677cd6d7so171914685a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 15:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746137760; x=1746742560; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pd453CkenvedzFQkRFuNe8U+1BbMXgrG12N3E8/KSbg=;
        b=GJlItTbHTZ//H2XK1PAaOOMbEVyOeNLzTLfU/IiXfZ7yvipqRAPRFdtdujXcSasliA
         kuuOsdwlc9FV7/PvUgXouI+Fth/m+g2s62g/BI1c9HR+9dBpjaLxZTOPxj4+h8BNVPTy
         0otDqmK1cKTUQ3gYu6I8/fREuT4hyViXpVxlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137760; x=1746742560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd453CkenvedzFQkRFuNe8U+1BbMXgrG12N3E8/KSbg=;
        b=sdDsgIc5HfBfT8kQQjNi41zpVHvWjv2MDmnsN+KgvoWyQuV5OHunGEGQ6CYk0YOt9X
         oYa3O04gJ2ITsr1m4swFmJnY3MyeLXEDEdnYIujz3zy86DRzODvFy4Y6/mL6/6uoV8c/
         Zyunc4/SSSry+ETOoqW2OVsM6o2N0fHJX1dZT41fRbNW/MOLQVF/slolOtBP8Zt5X1MU
         K7Ra7j9cLh6VqZXSLYbqxELlepHAe6/cWf56wwCllNaO1TFPecT8PjcZX+geDi4wiTQe
         3gSfiNk+2koluMUqKs8Vj+PEhHdVuczQsO9u+R/Q3DrtAEhgsG24w/FebfwZvW8VTJja
         9zuw==
X-Gm-Message-State: AOJu0YwjZ56pUQmkPHYFAwjYqcuBvt84CShSvWxfvCsh7T6pIRPtVfWv
	U4JvrVOMd2wMB/5/ni6GZGS0KwfstSA1+yu8RE23EhxeGHl2XaZXmijIcO/g/rYfl2i6CN3UwUJ
	W
X-Gm-Gg: ASbGncuaFdA4sD9u6wiccKF27VaslrcMQ1wwjCHH32zDfHHzZp4mzStGiksF2FHIdi8
	9T/OLXOAE5Yl77f4Umz0aRjh1JCDUe9D3pQICUWCEMHvPqnm5RgZX+8wg1BimvqJePly6KTNL6c
	LamtbBYCaM2iBqij9UT4HKn5Z1/QANEdPAWm+oQl9rM2MbDTC+WoXVH+bctPeLjGMPcFmLFmQ2V
	4Zd/c5xZdc3ZOT5Qw1KxZJYwjwnxY25oGqsdCmRyXhFfPPC1pk51TwyMt00CmzDZBGg5xeErvsb
	XMeNsvw+dduIr4ECxRL8S1skTwflffpg/m6KiYoG8GLicc94KjoK4pTTxzvIyTBA16wSnVlsaUY
	6SK3iDWrXqUVCQS3q
X-Google-Smtp-Source: AGHT+IGM7osNBPPBAwRuN+uxWqkyQrCoAyAB8puohLv/i25Jwb2IJK+danj24X1D7Ro6UDOsYs2pFQ==
X-Received: by 2002:a05:620a:2892:b0:7c5:6ef2:275d with SMTP id af79cd13be357-7cad5ba8617mr138732385a.52.1746137760124;
        Thu, 01 May 2025 15:16:00 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c3329sm9975366d6.28.2025.05.01.15.15.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:15:59 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 1/7] rust-llvm: Disable benchmarks by cmake options
Date: Thu,  1 May 2025 18:15:37 -0400
Message-ID: <efb8896e2492512bd4c4471cf9bedfd8c1a294cc.1746137462.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746137462.git.scott.murray@konsulko.com>
References: <cover.1746137462.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 22:16:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1467

From: Khem Raj <raj.khem@gmail.com>

Drop patch to exclusively disable it in code
It seems to be fixed upstream [1]

[1] https://github.com/rust-lang/cmake-rs/pull/158

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 60b4b0808a3b961917ed8abe16b9f7df2a311952)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../0003-llvm-fix-include-benchmarks.patch    | 25 -------------------
 recipes-devtools/rust/rust-llvm_1.85.1.bb     |  2 +-
 2 files changed, 1 insertion(+), 26 deletions(-)
 delete mode 100644 recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch

diff --git a/recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch b/recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch
deleted file mode 100644
index ff31c0b..0000000
--- a/recipes-devtools/rust/rust-llvm/0003-llvm-fix-include-benchmarks.patch
+++ /dev/null
@@ -1,25 +0,0 @@
-Subject: LLVM_INCLUDE_BENCHMARKS with llvm 14.0.1 failing to build
-
-https://github.com/llvm/llvm-project/issues/54941
-
-The LLVM_INCLUDE_BENCHMARKS is turned OFF to fix the build error as
-per the discussions in the above link. We will work on the issue and
-replace the workaround with actual fix once committed in LLVM.
-
-Please refer the following link for more discussions on the issue:-
-https://github.com/rust-lang/rust/issues/96054
-
-Upstream-Status: Pending
-Signed-off-by: Pgowda <pgowda.cve@gmail.com>
-
---- a/llvm/CMakeLists.txt	2022-04-22 00:45:30.543445478 -0700
-+++ b/llvm/CMakeLists.txt	2022-04-22 00:45:42.095232974 -0700
-@@ -615,7 +615,7 @@ option(LLVM_INCLUDE_GO_TESTS "Include th
- 
- option(LLVM_BUILD_BENCHMARKS "Add LLVM benchmark targets to the list of default
- targets. If OFF, benchmarks still could be built using Benchmarks target." OFF)
--option(LLVM_INCLUDE_BENCHMARKS "Generate benchmark targets. If OFF, benchmarks can't be built." ON)
-+option(LLVM_INCLUDE_BENCHMARKS "Generate benchmark targets. If OFF, benchmarks can't be built." OFF)
- 
- option (LLVM_BUILD_DOCS "Build the llvm documentation." OFF)
- option (LLVM_INCLUDE_DOCS "Generate build targets for llvm documentation." ON)
diff --git a/recipes-devtools/rust/rust-llvm_1.85.1.bb b/recipes-devtools/rust/rust-llvm_1.85.1.bb
index 12d7b2f..2ba37f0 100644
--- a/recipes-devtools/rust/rust-llvm_1.85.1.bb
+++ b/recipes-devtools/rust/rust-llvm_1.85.1.bb
@@ -10,7 +10,6 @@ require rust-source.inc
 
 SRC_URI += "file://0002-llvm-allow-env-override-of-exe-path.patch;striplevel=2 \
             file://0001-AsmMatcherEmitter-sort-ClassInfo-lists-by-name-as-we.patch;striplevel=2 \
-            file://0003-llvm-fix-include-benchmarks.patch;striplevel=2 \
            "
 
 S = "${RUSTSRC}/src/llvm-project/llvm"
@@ -50,6 +49,7 @@ EXTRA_OECMAKE = " \
     -DLLVM_INCLUDE_EXAMPLES=OFF \
     -DLLVM_BUILD_TESTS=OFF \
     -DLLVM_INCLUDE_TESTS=OFF \
+    -DLLVM_INCLUDE_BENCHMARKS=OFF \
     -DLLVM_TARGET_ARCH=${TARGET_ARCH} \
     -DCMAKE_INSTALL_PREFIX:PATH=${libdir}/llvm-rust \
 "
-- 
2.49.0


