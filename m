Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72582C3ABB2
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:12 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web10.4604.1746132067240491288
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:41:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IDTxkwt2;
 spf=pass (domain: konsulko.com, ip: 209.85.219.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so17211426d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132066; x=1746736866; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yER5b46NeFu/BL4/5zWCp+Tm+xZPWNM3cDvCAaMGopY=;
        b=IDTxkwt2vJJQP7U4+kMpYRHu4/nBXyx0D3QRUNoFU941gqYX49N86XYjtu7VuMJHi5
         7tb2Ch9RcLzKIC+Il3dvOUwucPeWfVrF7o4MaqWioZ0hUdXVEJFdv7nRuWM/9E9QqZ1Y
         8VC0cIMOVbHirNDRey8DzOODgMquSqYaqTWaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132066; x=1746736866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yER5b46NeFu/BL4/5zWCp+Tm+xZPWNM3cDvCAaMGopY=;
        b=SMMO55wVC5VviH1UQFJYcDDgjRyy8RAgPOWBoeuWqjhzcydwujbmPFWGAxXwfwfWYR
         lxIg8YWsyIGbdvq7Gm8//TCpBdCmctK0nITzM2mo3U6M0z3E8itphrUup2WrhOiKXEOL
         Rwz4FL1goxZJkZ6tI/0vxQCzMAFjb2RIXSTRro1wPG/suoq+4Kyr6VDryR4Uozj+hNC3
         QZ8VBjzDEaUzje5cCe6+5hU839z2ero6CzrPjWlEOC7H10/FEAWYB1WVaKqj5sWlPagR
         n7K5QzA4ZEw4cqemJkKcOWTGVMQE86awOfTS4WEO0ARvFrg7yLs4VxqgkFQwSFkpsapX
         h/SA==
X-Gm-Message-State: AOJu0Yw3RZ32oltGqLk7rBkw3+2kDWQb3NHBpYaq5XjzCggW+HfRPyBQ
	QN1PXno48eInUKIg3X7+KZAkGtvzx6EaaZUzQPjEqr2v3peVyNOBgiH+5MeMj1jnVE35uhSqSL7
	+
X-Gm-Gg: ASbGnctg/IUZBYGkumkwqTpFD1JvlgIkO+lnJOZ2+h5H+EIEpP71EohTtVi6UPDJWV4
	V0/ChaM0AApJQKRSNSy4Wa3aNtbJq+rOpkRHkYg3Gwq9LRJlvezFc5u4ZzXxFO965KmtiRRTwjD
	5CIappUVizGMJUL/QuDlFPKb5QgAk8BDPPkpxjM2tE6gqnWi+eVj2QAIkJ2iLqVm/2TWwnK3X0K
	yF+82sk9pGFRosA2D9PUKD4o3mGiGHqDvRFR8ck5wVOYV3InPK3Gsu2oat8UpaRKqjDRK5XU3Ap
	GzfFgBvlklYjAWgSlcG4rCQ0LVBb8nMvd2yuMOtNHqsvnriHLri9VhPpjvdQWYPnuh14kaon6uV
	7jjFxAvGHKH/aAPShyHY11suB4/c=
X-Google-Smtp-Source: AGHT+IGZhvpuBMweEFlSO40LMeeH7zdkMcsGfRaMbX2dOqSVAQ2rxqoeJNsn/2xOhAzc4nP/RIZQzw==
X-Received: by 2002:ad4:4ea5:0:b0:6f0:e2d4:226c with SMTP id 6a1803df08f44-6f515632f25mr8912186d6.41.1746132065845;
        Thu, 01 May 2025 13:41:05 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.41.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:41:05 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 31/38] rust-llvm: Disable libedit
Date: Thu,  1 May 2025 16:40:07 -0400
Message-ID: <7a817df6a8c39aacedd01fdb8013bd2c61664ebc.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1457

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This option currently floats and is leading to non-deterministic builds. It
is used for commandline option tab completion which we don't need in our
builds in general, let alone internally within rust's llvm.

This should fix autobuilder deterministic build issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit c31859be39c68f215576ba73b8a3d66c8ea590d3)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-llvm_1.85.1.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-devtools/rust/rust-llvm_1.85.1.bb b/recipes-devtools/rust/rust-llvm_1.85.1.bb
index 566348c..12d7b2f 100644
--- a/recipes-devtools/rust/rust-llvm_1.85.1.bb
+++ b/recipes-devtools/rust/rust-llvm_1.85.1.bb
@@ -42,6 +42,7 @@ EXTRA_OECMAKE = " \
     -DLLVM_ENABLE_ZSTD=OFF \
     -DLLVM_ENABLE_LIBXML2=OFF \
     -DLLVM_ENABLE_FFI=OFF \
+    -DLLVM_ENABLE_LIBEDIT=OFF \
     -DLLVM_INSTALL_UTILS=ON \
     -DLLVM_BUILD_EXAMPLES=OFF \
     -DLLVM_BUILD_LLVM_DYLIB=ON \
-- 
2.49.0


