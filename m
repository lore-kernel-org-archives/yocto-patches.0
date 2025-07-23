Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DDDC83F17
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:48 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web11.23029.1753296039658970063
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BGnE1IXd;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e3142e58cfso15667685a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296038; x=1753900838; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUeY60VfH6rcDFS8UC7/COh/iit6opmV5yoVR5y0Nt0=;
        b=BGnE1IXdsgZiIzkHxNr4X9RWUaZSzxkphQfvKjnqxRDQ2u8YGPhqDFvk8Cxf87ToiC
         vEi4A46ZEpLGZtejQ47GMkBopHF8NuCQsC5RNfE0agAIMEi3q8BL0+10GXr2rm5vbH/v
         2RtwAQDeYXwkL7VfHj05SgzvfqoVgfE9NYv7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296038; x=1753900838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUeY60VfH6rcDFS8UC7/COh/iit6opmV5yoVR5y0Nt0=;
        b=vhrvwDu2zv8ffMVOCFTsyU/86zyks1XaxOqGWyfcOtzVW+mtT/I0s3eDy2Xh3f8p49
         +fFD1KfFX2W0jUrKaZrpfGlsYuJLp78l2PxUYYrh+N7YTu7CFW1/uVBjy9aoOdM8e6Kk
         kziFQzpuWhR3IWz2EnjSIFxCLpKyaMB3yBCZowTDKweAu1zXwAqaMwLQhSVxZzt+SXqY
         yZ4iCKw3Kx8+TUOVZ1uQj4CDvVXrpGJRqyLFlDdvn4wYMLaMM9NhTqrVdStHayI5zbNL
         oOnQJygB4M1r7I18kX8ZD0TzGA8oV9hmkkanWWCE5uwxVvJGpSH3q+l78pcE25TGfjye
         UDIw==
X-Gm-Message-State: AOJu0YywzeP35PK9EOvoUvVpCe/A1KLdtLzqnEuUoUKCKfmwSFu75bpV
	RsqUMqDWI/PUX89WOP9Vxg/363zKYB5JS2zOAnMqEKMuqCw5AY2iFg8Ayx325MvUxw6pT3qDgDF
	8mt9a
X-Gm-Gg: ASbGncvigJXyR7lYDbiX//XPXqcuQ4rJ/zyIt/bu9jxdMoOTIGdfCuDwFAhb0H716yd
	J3BMwJPkO7c1rX5399hqHOj3v9SfWzxBxWDYye4fes7YsQVONbh10sdwMxe5IalJSAcxWHQrUYC
	+bZmidx70nGajeLnPCIuz4HNAMzaWg+YMm3itK2U7975e64tcqjUZWWhVE8rqDHDLY4+fL69UMQ
	NPPb2eV6MpuaqGqk0Q7R7/dGR/uwcaah0C7qUZkH+NIkkmQw3V9uzBqGETAdGYBYX/zUDhWURaF
	aLcwO/RBteGCAUh/rMFE8M69kqHLmDSFR89Pjb04BMvyHPcqR5bGmAy0qwWpY30Lv57Sfltc6gs
	L5XF6tw2fokTT2lB5ORofO2qPbQyalWQWetlBHspjKtI/tvzzqmlJJ+3kM33PhzaztSsjK/b0sK
	xWGMYd+rcc
X-Google-Smtp-Source: AGHT+IHRkL2gglB2XcQnMUbbT2yZLh4ATGs9Ccsf7m4UBvcATnjCBlbrbbCbsEkzfuWNbl6CCF3KjQ==
X-Received: by 2002:a05:620a:371e:b0:7e3:49b5:d53a with SMTP id af79cd13be357-7e62a097fe9mr539523185a.11.1753296038357;
        Wed, 23 Jul 2025 11:40:38 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:37 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 08/13] rust: Disable cross-unwinding support in llvm libunwind
Date: Wed, 23 Jul 2025 14:40:08 -0400
Message-ID: <736bf97b2beb32c941588391ab2f54f8a96f0307.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753295655.git.scott.murray@konsulko.com>
References: <cover.1753295655.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1835

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
index 82d28cf..6cb08b7 100644
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


