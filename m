Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29267C87FCA
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:05:59 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web11.23586.1753297554639529173
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:05:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QInEPamX;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e050bd078cso23427785a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753297553; x=1753902353; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ed2UxxKbSyzBfR92ZIo2xA5H3wZ+uWPPJS3FCrvPl0=;
        b=QInEPamX/A+Gx/dyfv1vwz1FrcYEnqGkKyn3C2xIyauVtPkQnDXEHOxja5PP/5GQ9V
         p1tPi7UUmLJeqpLplKAm7Nb6q/QttuGcZnKTj7jsd+glArdVImHItzAx+I8FSKhj+YzM
         BPeG+p8bkE1lm8oKtR5Wls2FfQ4yjbLRfUDns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297553; x=1753902353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ed2UxxKbSyzBfR92ZIo2xA5H3wZ+uWPPJS3FCrvPl0=;
        b=CkO5guxKm/zfFtmlWhsay+Jnwg5PYHuttBX55qwPCwR58MWVMjNbuRYbwonwxVyfJ1
         /WIjOHSU7MuKyW0Y1W0+lTc9Nli72Jca2xmcIyvPppRXclqysrZ47ejWLTjIYsOiyui/
         xykljJvh6GbrDlGFQ8OO6ZbzkwsS/9jG0eJKaThrF3KkN8xw8C9NcRHfnf8t1Bh0TxAa
         R1ClvLIKIOpRGOszMnIswjbgAN77XnPemqb4fW5hpWX4TVaK7kTDY5ZL910TEHWP1VFt
         Z4s3SmKXFsDw6KujiRq8uvYgoYPG16pWo+IlyQs1QG7G35BD1nrjuW5rASe3zFAOWVqb
         8QZg==
X-Gm-Message-State: AOJu0YxZxb7/Uyk5DvD8Hu1Er/fZnr+rq4LLDbubzFoiVbxq2WQ+kZaX
	fX6XVhwH/xI7CHeI3y3Eopij5BIzB1AU/2UMNObRWWz3o7hWY0sisnBj0Ab80cUMtEpfH1MgkxX
	rvCb3
X-Gm-Gg: ASbGncuE2Pdhm3s1+bg8lDiNV2sITfYAcO9Od4Ner5W5i+C5PxNeLkIL71ZFv7TVL4i
	rs+vMRHLtD+MuslMiK2zizsd11l+rXqkr3R/UU+E8VPrhpuH831Fa1X1Q4VEFJarilS+JHNO4lG
	8X463k5CnLPjGTY6gckPBQniuj40tNEKxXISc3bnbhQvsV30LI5gJTvoMpa/jiybHeNYvvH2CQ+
	s2nl2W2HgxzoUUFILPTC2KiJkUY2h1nKOkeCTYqrb/tAy6HvZUNJsYqLhdZwjiVNWYMvWXc8SLK
	DKAPUoVS0kwc9/UN03456j222Z1JLqYhYb/ALtSN2CGGHJJkuYLLuYOepWIl4mFXcRxInlAzRle
	9eTIlKv8OMlvhxZbpPAg0McTQZZINLfqQBI7JZmS4AanBmhuwnrhB5iK8/RY0XFZdfv+w3dkeHg
	==
X-Google-Smtp-Source: AGHT+IFttuj4+sQagsghwgbpuL8OH0o8ttFcS8RyEqdJW4Ygadusw0iXG8HaASGSLJLV0uf+4YFqzg==
X-Received: by 2002:a05:620a:14a2:b0:7e6:2a65:8710 with SMTP id af79cd13be357-7e62a658f3cmr409480785a.11.1753297553461;
        Wed, 23 Jul 2025 12:05:53 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm703576085a.84.2025.07.23.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:05:53 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: soumya.sambu@windriver.com
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 08/13] rust: Disable cross-unwinding support in llvm libunwind
Date: Wed, 23 Jul 2025 15:05:27 -0400
Message-ID: <eb7f33df49b43cf641d91b904d89aed883e3869a.1753296167.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753296167.git.scott.murray@konsulko.com>
References: <cover.1753296167.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:05:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1849

From: Khem Raj <raj.khem@gmail.com>

This is default in LLVM but rust does not use cmake to build itself
so it needs to replicate the behavior

Fixes rust build with clang/musl for aarch64

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit f05d42d11e56cbbda6034bd7f773dc690b68bdbd)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...bunwind-cross-architecture-unwinding.patch | 46 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 47 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture-unwinding.patch

diff --git a/recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture-unwinding.patch b/recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture-unwinding.patch
new file mode 100644
index 0000000..4a28203
--- /dev/null
+++ b/recipes-devtools/rust/files/0001-Disable-libunwind-cross-architecture-unwinding.patch
@@ -0,0 +1,46 @@
+From 56b669cd7adcc413bb1e64c3d2d7c347a82ae35a Mon Sep 17 00:00:00 2001
+From: Khem Raj <raj.khem@gmail.com>
+Date: Wed, 21 May 2025 18:47:09 -0700
+Subject: [PATCH] Disable libunwind cross-architecture unwinding
+
+Building with _LIBUNWIND_IS_NATIVE_ONLY disables code for cross-architecture unwinding
+it is disabled by default in LLVM [1], replicate the cmake behavior in bootstrap process
+
+It also enables some additional code that handles PAC-specific unwind info
+it helps compiling with the -mbranch-protection=pac or -mbranch-protection=standard flags
+
+This fixes build with clang/musl on aarch64
+
+[1] https://github.com/llvm/llvm-project/commit/85624c5de3e831ffa01fdc2d159e3d69c30de08d
+
+Upstream-Status: Submitted [https://github.com/rust-lang/rust/pull/141375]
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+---
+ src/bootstrap/src/core/build_steps/llvm.rs | 3 +--
+ 1 file changed, 1 insertion(+), 2 deletions(-)
+
+diff --git a/src/bootstrap/src/core/build_steps/llvm.rs b/src/bootstrap/src/core/build_steps/llvm.rs
+index a3788197471..5e4a1c7d9f0 100644
+--- a/src/bootstrap/src/core/build_steps/llvm.rs
++++ b/src/bootstrap/src/core/build_steps/llvm.rs
+@@ -1430,6 +1430,7 @@ fn run(self, builder: &Builder<'_>) -> Self::Output {
+             cfg.flag("-funwind-tables");
+             cfg.flag("-fvisibility=hidden");
+             cfg.define("_LIBUNWIND_DISABLE_VISIBILITY_ANNOTATIONS", None);
++            cfg.define("_LIBUNWIND_IS_NATIVE_ONLY", "1");
+             cfg.include(root.join("include"));
+             cfg.cargo_metadata(false);
+             cfg.out_dir(&out_dir);
+@@ -1447,12 +1448,10 @@ fn run(self, builder: &Builder<'_>) -> Self::Output {
+                 cfg.define("__NO_STRING_INLINES", None);
+                 cfg.define("__NO_MATH_INLINES", None);
+                 cfg.define("_LIBUNWIND_IS_BAREMETAL", None);
+-                cfg.define("__LIBUNWIND_IS_NATIVE_ONLY", None);
+                 cfg.define("NDEBUG", None);
+             }
+             if self.target.is_windows() {
+                 cfg.define("_LIBUNWIND_HIDE_SYMBOLS", "1");
+-                cfg.define("_LIBUNWIND_IS_NATIVE_ONLY", "1");
+             }
+         }
+ 
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 177de53..5fb11b5 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -9,6 +9,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
             file://Zdual-proc-macros-additional-check.patch;patchdir=${RUSTSRC} \
             file://0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.patch;patchdir=${RUSTSRC} \
+            file://0001-Disable-libunwind-cross-architecture-unwinding.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "b1fbf809efe9f036939401e142631c201a53bcf43ec1696bd9f5290ba236a266"
 
-- 
2.50.0


