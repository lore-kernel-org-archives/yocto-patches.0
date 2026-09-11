Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49087C88E5A
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:15:42 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48575.1789157732292817805
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:15:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=emToZni/;
 spf=pass (domain: konsulko.com, ip: 209.85.219.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91053c27a91so12899756d6.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157731; x=1789762531; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h2ImcwKSf+5yMn37h+OUk4/aEJ7rKvY+k6d3Q64HeHw=;
        b=emToZni/QW539xSw/7kf6spt19msg8ElcpamKCAbDT3nAg9b1HlxOOJqzeZe/tE5Ut
         QJWWB6CsVOSWNu4/OqVRR9xrxnUqAl3llRFMVOXhygY7j6KgglZxu1l/fP6/IV3TCaX2
         0dnWIPBmSzW40oOxLVRbxF5yWqSKLxThvAE0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157731; x=1789762531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=h2ImcwKSf+5yMn37h+OUk4/aEJ7rKvY+k6d3Q64HeHw=;
        b=YE2Zmbt5mHjFAzHYsoMC3L95LRl+HdS9WQFB9a9R426jo+AOXIm6qCHpvogAjyX6Ye
         LwH8Ni0VrRWTTD+nokYPdHqKWlEqEN2D3EdOYEA5ShKvVKMDTWO66wXtKloApZxzVkZ5
         NVDYE9hKB4LkEIFo1y0dcWUxNOVVHEbTuWW9hanR8mrItco0BdmppDqh3sDyFewHMA1Z
         tpmm7+astE5KhEYeMZMnLsfyTXvPMVTTE/3t1j0vykQh3SfsLqV3RIOa/JXrfsM4Pqfn
         RDnJb5vWp3Q/BeSy+iZefMxj0CU7NwqQpraKgMFMXnYfwNlmbpPGfYMME4C0iCWdkrBo
         ch3Q==
X-Gm-Message-State: AFuF++mSuSjFCydnq2g6H0TEb31RVOYZY/ZdqkqUBuN5N+jC6AuVK7OO
	XIu/kl4OYhCV/6XV6oaqzUg9kwtZL7RqQWmePghKQ/KVKpD9yd3vPc1++oXQ6ZEcOwNlK+DDvMt
	+GSKS
X-Gm-Gg: AYBFou0HhTmGF1NlC30fjZMf89eGMUlDMH5D1jsAWihFKIMsapuSJF2J8XlNd//EMVg
	6NphTDiMx627v0TXiETJCNuFdMbWgDkhsVj4UycSdXIRhdkl3k7Y+GRO1Hzekht4TsnfBHTKqjH
	69YZJD1guyKZp5bX2To7RQ1voZbsfaGRvapk2nOEaX3LJaJp52lMSjI5/88oocRlpWOPdcQHHb5
	zhDNnJkgNOj+Zd6hEioagjBdYdTJpY47hdCo5c+LrouaHCpZ6EaqYcGdax9qJ3u6YHYxqs5PtjN
	HcPN+8Xa9k1PE6/6FKHyCaNbSLidXMwJNvR7YRjwUs2bHXG/e5x57TXZNsHuW/YfSk1XtauUGgZ
	cWrYzssOkduA4t4ZeipUvKsEEuNIA/CvRGaFRamhcxgIzmvQh3QHkNqQCGUl4H6btXRoFdRLJMT
	BbwIXpeIZJ4jaLpE1aAmAO2MgBNkpwDhEaH9gccTCKHXRzRaf6EZI1ztbNu0ls7tSCJ7oO19ZPZ
	XqxXTzi4ZNWOREKCXjtS7ipozP7Hk/srBTAH+mzUG/FDeGICaUL/vw8qWf73bKWPIpV7djCLuLl
	QQrHsapOf98nmHl0Rq29PYak8T3827vo4xE=
X-Received: by 2002:ac8:7d50:0:b0:51c:15bb:b4f2 with SMTP id d75a77b69052e-530c857f043mr84427971cf.27.1789157730872;
        Fri, 11 Sep 2026 13:15:30 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b699bsm28930706d6.37.2026.09.11.13.15.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:15:30 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 10/11] rust: Do not pass the removed x86 amx-tf32 feature to LLVM 23
Date: Fri, 11 Sep 2026 16:15:14 -0400
Message-ID: <d36c99e88795cf5fadc30fea49a43f2971fcfebe.1789155804.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789155804.git.scott.murray@konsulko.com>
References: <cover.1789155804.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:15:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4813

From: Sunil Dora <sunilkumar.dora@windriver.com>

LLVM 23 removed the x86 amx-tf32 subtarget feature, so a rustc built
against LLVM 23 aborts at startup with

  "+amx-tf32" is not a recognized feature for this target

Gate the feature out of to_llvm_features for LLVM >= 23. rust dropped
the feature entirely after 1.98
(https://github.com/rust-lang/rust/pull/159310), but backporting that
would change stable rust behaviour, while a version guard keeps this
rust working against older LLVM majors too.

Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 99548382539f2e9b7fb9ba182f9e0f6707d4f360)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch | 38 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 39 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch

diff --git a/recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch b/recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
new file mode 100644
index 0000000..99fcd33
--- /dev/null
+++ b/recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
@@ -0,0 +1,38 @@
+From: Sunil Dora <sunilkumar.dora@windriver.com>
+Date: Wed, 26 Aug 2026 16:30:00 +0530
+Subject: [PATCH] rustc_codegen_llvm: do not pass amx-tf32 to LLVM 23
+
+LLVM 23 removed the x86 amx-tf32 subtarget feature
+(https://github.com/llvm/llvm-project/pull/207673). rust 1.98 still
+lists it in the x86 table in rustc_target, so a rustc built against
+LLVM 23 aborts at startup with
+
+  '+amx-tf32' is not a recognized feature for this target
+
+Skip the feature in to_llvm_features when the LLVM in use is 23 or
+newer, in the same style the surrounding code already uses for
+avx10.1/avx10.2 on older LLVM majors. amx-tf32 is the only x86
+feature LLVM 23 removed; the rest of the table still matches X86.td.
+
+rust dropped the feature outright after 1.98
+(https://github.com/rust-lang/rust/pull/159310), which requires
+LLVM 23 or newer unconditionally. This recipe builds against whatever
+LLVM major the layer provides, so the version guard is kept instead.
+
+Upstream-Status: Inappropriate [rust dropped the feature after 1.98 via https://github.com/rust-lang/rust/pull/159310; this guard only exists to build 1.98 against more than one LLVM major]
+Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
+---
+ compiler/rustc_codegen_llvm/src/llvm_util.rs | 2 ++
+ 1 file changed, 2 insertions(+)
+
+--- a/compiler/rustc_codegen_llvm/src/llvm_util.rs
++++ b/compiler/rustc_codegen_llvm/src/llvm_util.rs
+@@ -286,6 +286,8 @@
+                     s,
+                     smallvec![TargetFeatureFoldStrength::EnableOnly("evex512")],
+                 )),
++                // AMX-TF32 was removed from LLVM 23
++                "amx-tf32" if major >= 23 => None,
+                 "avx10.1" if major < 22 => Some(LLVMFeature::new("avx10.1-512")),
+                 "avx10.2" if major < 22 => Some(LLVMFeature::new("avx10.2-512")),
+                 "apxf" => Some(LLVMFeature::with_dependencies(
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index d87271b..f40f165 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -8,6 +8,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0002-Fix-rust-build-failure-with-unstable-options.patch;patchdir=${RUSTSRC} \
             file://0003-bootstrap-skip-StdarchVerify-when-remote-testing.patch;patchdir=${RUSTSRC} \
             file://0004-Backport-commits-from-rust-Fix-selftest-llvm23.patch;patchdir=${RUSTSRC} \
+            file://0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "271fa73d8174f53d713c46a8310da7bf7cfdcfb8b7cfd1c2b74b84a83ae9fb1e"
 
-- 
2.55.0


