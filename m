Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88550C3ABB0
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:12 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web11.4670.1746132068428668583
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:41:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NnE5XOSV;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8fc176825so13118566d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132067; x=1746736867; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pd453CkenvedzFQkRFuNe8U+1BbMXgrG12N3E8/KSbg=;
        b=NnE5XOSVREZncfkn0crfQJ2DHP7R/ZNlo22wvMEc5XE1ceBCvDI6i4AMkVzfX0Akj1
         mW1E6l95qRP5FCGW9VHmc0gZsrKHdF/EAOetzejZjyabJ1GkLP6FgJyl9KJiSC1yYYFf
         gcaxmA+/IT9SFPl93xBOwm5TtIUx0g59QIwrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132067; x=1746736867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd453CkenvedzFQkRFuNe8U+1BbMXgrG12N3E8/KSbg=;
        b=CB0zsFzRaUL0+M2OeQF9nVnG1NBUdblcazImUcDnKosxbwmMqy7tiGqaWWMcbr878b
         xMG8OSj3BAmRbwmCk2YljHsku0j6g1RDjdx/cBpKAiZIHGpgcvkP7QD3yZRwr8ZAO0oD
         YGvSbktqYeGZDCyGQOUv19L/5IxY1D+TbtEefqQkR0HdSpN4Mqo3+fJi8SUAy9fKVVC3
         P6G64Ngq3DP3cDtdBirc8HyFJFCChtO8RCyaftJbQtpd1n+QtmUTAlZ8ffp1Gs5++B3q
         9VVgeZ3ljzp8ElufFLSodmfamLIzzYCbZRmqNqMgAlXYvH0jAEjSzoHkw2hwUt8c3VpA
         HRqQ==
X-Gm-Message-State: AOJu0YyWh+IWuOa8jCpjbRL+OOSZrspCYlNOaWwfdaoKqCylu0z/WaFg
	8+qk3XZ4/3klqeU6ec5ipZ1lM6681EXsqESiEQ/+OGGHBJVPyvKYGxLLr5fE9lXHCJUGz09AZR/
	N
X-Gm-Gg: ASbGncue57rJJyTxxlJdkdo4Y4JtCAwKwuzQPQ1wEXCVQK/wXygffYYzEkfsZxipTP/
	rjTuUuv6vrhwXU2r+JyRVHU80lZ2223iFo7vjghJ7Rn7+eOV+Wp67s5B7DIk/DmEzECFvsX0i/m
	HNbAD3wFN7aDhZkRHRfPpd1iO8r9sQZ7RBbxY7dUM8FidvTDJPp/TGrn5VwW5AdzVPOHBL3I46w
	0J5YGm6NLe3gKNHKFo9VFAz49SG5wY5pceNOzycDSsrRRT/gqQ84qXhx6A2Dt+edM9vHUbKt+yo
	aUv3gtgEnN9hoikzChLVB7XYDX4NReseXqYPTDigmCJ9U8UIwgJUVk4aABiblN8bcM+TQvTzMW7
	+yAGLS7xQ/XbgABTI9/R5icO15cE=
X-Google-Smtp-Source: AGHT+IFvzgqwrdSg6VYWq0FNLNPb2WIalQKvCZWwr6oE3zTuuGuaM9cqvK8UqNceQLJhQukE1zZV6w==
X-Received: by 2002:a05:6214:b6e:b0:6f4:d60d:dd29 with SMTP id 6a1803df08f44-6f5157301d3mr10128786d6.5.1746132067026;
        Thu, 01 May 2025 13:41:07 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.41.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:41:06 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 32/38] rust-llvm: Disable benchmarks by cmake options
Date: Thu,  1 May 2025 16:40:08 -0400
Message-ID: <b2bd685273b30405be13e82517b50f1625efba09.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1459

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


