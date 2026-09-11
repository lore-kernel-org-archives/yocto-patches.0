Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E78C88E5D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:19 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48543.1789157654202864881
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sPkgNhCg;
 spf=pass (domain: konsulko.com, ip: 209.85.160.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52fa9c055b5so27618681cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157653; x=1789762453; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2/DhZvBGW/i5UamTrcXMUqeayAT2SO6AFHJCcZjYxlc=;
        b=sPkgNhCg2mFt5Lhyfqzy8Nv2aV/iYzVAsgTupR6s2oxgKh6gLqfkDHoRU2Of40nTQQ
         xyNAUs1dYFOVz9xtQ5KaGfG0Yi41Nk+MBNCiwBI96BTUNTm9qNHNU95mQ5vOk+lpwmgs
         Gk5/Fj0ecH13N4fggvhEKvCksHx6NhOD1Bkqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157653; x=1789762453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2/DhZvBGW/i5UamTrcXMUqeayAT2SO6AFHJCcZjYxlc=;
        b=P+Lz5R8BMDiOj3YosfPRhJQI1WGFOpIKfOHy0iWJcRUEG9QKACJrgbc+WqV8FNqcsR
         X7fEoRz/GU77mzcdXlscbQuBLUpSmPUTlDwmtuOyRdMG/CBMFH8ZUZvHXYE+adOTT49W
         L5hEL+QCQV5V70V2lQCy8QCGScrldWvQAKChMU2H0z3gzvqEaun/jzIZMOPAAnpjn1uw
         8PoIb/w90+BhMt/ZXCVc1HGbVbr0CoMp+LYeJmz+u+K8iSmdkvROjQ01yBVbzhucUAu3
         clVGuMyosV/4+1mvs57t9eAEZ4v+OGgnbYbo6fVCh1IJwh3E3pRbAF5tyHM+1SgJbzcI
         ++rg==
X-Gm-Message-State: AFuF++kCQoRhpA/3bdDIBbV3ebbvdEzRPp0x3jP8zp8efimVEmYQDU3k
	W4U3wKGD37zsnBGjlr3iohC2eeEO7ODEU13jcVqGZYqlFeMoqSnRNSHekj1tCJluyGkypX3IXa1
	gOodz
X-Gm-Gg: AYBFou1qoCEkqrK5uAUWSjNXfDo4PoAR7HmaiXTIW2gfCKrNZPhSn/3x2oVabD1NyBi
	GdFjsQVUd/1F41VwKyXkulnnQ/19/llMf1cYZRNiZ7WIo0QQfOqFOTYTdEGG7PuBV39J9o8e33g
	dDlejXDpb+gGc6fg3kFRMaWdOF+8VfAX3KDreYD5MifY3bHegHGJ1IfvKOZEXWvc47gMKM+TYBH
	3AM7Y21ZoBSTNcNLiZD9Ux+jO4/H1PQA7R+4Drp3+jiC46hCHBls8VvvchqfqBnrIkXm1Tvp7ML
	87wRVw7EVfshWBIC+X5Qv5YfuIVtqkk1WzqZTtesk96q+SAmQqHpGN7El4lOtmd2tZN3wNHSoTK
	NgXvVU60beI34IRZcFilBc3ZOoxbaT4SnsHqpfsNAFqbMFxQOPb7JaFpjDAWb1Ebqj61UH0Dynx
	ZFs+41HTVw9TrXFolsjh7aZoMAh/5fOypGRobCZZF+7eCcvOwTXnXEIvgFZ6FlsB7ExoL65igQC
	1Vdle/RWeIBRLndGGPmHH1MWS2blOXo7rekdUaESJJH2AVk5YUeoh38nZdKGdzPk3Dm4YztHwyj
	/+yBj6LWQVtcJ3pGXIwNEu4m0FaFagwgIqQ=
X-Received: by 2002:ac8:598a:0:b0:530:4773:1140 with SMTP id d75a77b69052e-530b3639755mr134898261cf.30.1789157652603;
        Fri, 11 Sep 2026 13:14:12 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.14.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:14:12 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 36/37] rust: Do not pass the removed x86 amx-tf32 feature to LLVM 23
Date: Fri, 11 Sep 2026 16:13:22 -0400
Message-ID: <5849f6861b6300ffb3e339a189e331b2bb358eef.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4801

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
index 5470396..4ef2ada 100644
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


