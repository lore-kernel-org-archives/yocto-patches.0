Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3161.1795645897175106331
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XUInAbYn;
 spf=pass (domain: konsulko.com, ip: 209.85.160.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-55d3563e50eso43647541cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645896; x=1796250696; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q+26tjtjpA8dCyha2liVQ9/jFAOzm4+NHXQlMqzztVo=;
        b=XUInAbYnLedhV3RztkxQTRWPHjmeOBget0sCnTy0XL8gnulUbWHTjA5Qaxe6bGoDAq
         36/AY1ebyX4W8/YEhbzrKUThCJVVmi4VyZc2OseBffMHDwEIuVSTzfaNiJ2chVxOgrzC
         kDfsKNMTp/WNQpJvTn96USQCSAUgyAgDKgzXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645896; x=1796250696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Q+26tjtjpA8dCyha2liVQ9/jFAOzm4+NHXQlMqzztVo=;
        b=Pdrjnw8I96sLqIFi+z0EKs8qLTXWsAl1lLqO44WUk+54J/lNWrcMwJplF++JZIJ7tB
         P1NAZ5g3OXzSPnsNz2QCnHBRcwt/uqdKb8yKnC+ztdXyQVQulfIWvVBsdlVyQRqWg+Et
         NqLQ7vHqhUUEywZZl60VjxZ/Uz1IKdj/2rczduK+ij7EqS/5jezIchtHHBn5ruTtuIvW
         U2noZrnS8fOiONmlMSAM+p6tm1QcdrZvtMr3LpppQiIWHSxLR0jonHIG6USbL1QLwM3W
         G/+No5x106rkEZDOQSgL5JVGyLLLTqn3z3C1RPPbAPw7IBgVNMMcP9axuJ9x8orZnX+x
         QjJQ==
X-Gm-Message-State: APuU4Z8q9ScVkjcE5CfCL+SPipBddqMQwwNbBxkpTB4X/Claee7tzLib
	Uzu81M5ASlw/4vJuR0C2z1Qc5PWfhQCs3n9F3lL5ql1tby683wHTNUc3oUBiuT2TEJ2xVVe6wVc
	/73Mf
X-Gm-Gg: AZFdTZcVCdbok/oovhiL9gmZ3XkY8mOhDb8VYyN7nPkCp/Yn1nwGKr38EE2W3ORw0gF
	kSAb/sD7vZXmvkrlDP+qX0a0F6aR3nscDQRh740J192pjn7Ac/JZ6NNhm2pahtcTXZyA52PMocg
	/oCoWECRegBK92hgL6LJhlq08ZqsIznnf99j3hk3nRcMUY0QBNCtdZesXe39Ou0EYonInb9lfQM
	3piIEZUjopiWQKgsDf2JdsODTUW4mEGWTSesmA9V9qClUtM47rCwrCzwXxDxc84QT6xLCc8ZD8Y
	FqTaLY+kwY8x6WNK20XFEyMu+QATiOGWqoWT7RpyQsBkPFDaekkApfzz+pomg656q+R3X3mZQnO
	p3Tocccbb43+8hoXdFwuCFXul1vDIKvbWOeLWT9Y1SJlFkaTrlMQ6liwIqtxdMs14r7A5u2qYEg
	OUZx7Q0yvdCa/4F8EgB2phLKhFo1ykeozJzyQBV8vES/YcvMw8dYLk6Ns31hwOLI5C3rmrFEIi0
	+i3BQ8SfP44T/f/Ogda+Y+eqqzfzBA1AdhFLtSNv4cItiRBxMw0JPcnIPzAS/nknn4VBlr7r/Bx
	CjVbY/8/Z42UblBLGbS50wTo6l0kw1fJSGKGRBAKwiyYWkFBqV2EOrAMMITL2nID+Xi9qSnPA3r
	gNEn6mKwgmlgQXeD/ckOYmKHMFTWNpbTWmVJiE1HzPLJ9cUNVLhUb0in1Irk22du0gg==
X-Received: by 2002:a05:622a:4819:b0:535:a5f8:a5bf with SMTP id d75a77b69052e-55d76abb5acmr348239531cf.63.1795645895504;
        Wed, 25 Nov 2026 14:31:35 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:35 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 16/19] rust: Upgrade 1.99.0 -> 1.99.1
Date: Wed, 25 Nov 2026 17:31:07 -0500
Message-ID: <fd7109e54381eefa5180d7e4ef29a481e4d20996.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5535
Content-Type: text/plain; charset="utf-8"

From: Sowmya Sathram <sowmyasathram12@gmail.com>

https://github.com/rust-lang/rust/releases/tag/1.99.1

Rust 1.99.1 fixes the following issues:
- Fixes missing wcslen symbol on UEFI and embedded targets.
- Fixes miscompilation of FFI bool return values on x86_64.
- Fixes rust-lld library loading on macOS by adding an rpath for libLLVM.

Drop merged patches:
0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch

Test results:

rust v1.99.1
+-------------+---------+---------+
| Machine     | Passed  | Skipped |
+-------------+---------+---------+
| qemux86-64  |  23691  |  1022   |
| qemux86     |  23428  |  1285   |
| qemuarm     |  23408  |  1305   |
| qemuarm64   |  23522  |  1191   |
| qemuriscv64 |  23464  |  1249   |
+-------------+---------+---------+

Test results difference (1.99.1 - 1.99.0):

+-------------+--------+---------+
| Machine     | Passed | Skipped |
+-------------+--------+---------+
| qemux86-64  |   +1   |    0    |
| qemux86     |   +1   |    0    |
| qemuarm64   |   +1   |    0    |
| qemuarm     |   +1   |    0    |
| qemuriscv64 |   +1   |    0    |
+-------------+--------+---------+

Signed-off-by: Sowmya Sathram <sowmyasathram12@gmail.com>
Signed-off-by: Hemanth Kumar M D <Hemanth.KumarMD@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit c0f869b8958dd04703c63d1e8fc580127449b103)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |  4 +-
 .../rust/{cargo_1.99.0.bb => cargo_1.99.1.bb} |  0
 ...host-triple-from-unit-metadata-hash.patch} |  0
 ...ygiene-encoding-order-deterministic.patch} |  0
 ...llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch | 38 -------------------
 ...ibstd-rs_1.99.0.bb => libstd-rs_1.99.1.bb} |  0
 ....99.0.bb => rust-cross-canadian_1.99.1.bb} |  0
 ...ust-llvm_1.99.0.bb => rust-llvm_1.99.1.bb} |  0
 recipes-devtools/rust/rust-source.inc         |  7 ++--
 ...source_1.99.0.bb => rust-source_1.99.1.bb} |  0
 .../rust/{rust_1.99.0.bb => rust_1.99.1.bb}   |  0
 11 files changed, 5 insertions(+), 44 deletions(-)
 rename recipes-devtools/rust/{cargo_1.99.0.bb => cargo_1.99.1.bb} (100%)
 rename recipes-devtools/rust/files/{0007-cargo-omit-host-triple-from-unit-metadata-hash.patch => 0004-cargo-omit-host-triple-from-unit-metadata-hash.patch} (100%)
 rename recipes-devtools/rust/files/{0009-rustc-span-make-hygiene-encoding-order-deterministic.patch => 0005-rustc-span-make-hygiene-encoding-order-deterministic.patch} (100%)
 delete mode 100644 recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
 rename recipes-devtools/rust/{libstd-rs_1.99.0.bb => libstd-rs_1.99.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.99.0.bb => rust-cross-canadian_1.99.1.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.99.0.bb => rust-llvm_1.99.1.bb} (100%)
 rename recipes-devtools/rust/{rust-source_1.99.0.bb => rust-source_1.99.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.99.0.bb => rust_1.99.1.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index ea42f4c..f310d56 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,8 +15,8 @@ LAYERDEPENDS_scarthgap-rust-mixin = "core"
 
 LICENSE_PATH += "${LAYERDIR}/files/common-licenses"
 
-RUSTVERSION ?= "1.99.0%"
+RUSTVERSION ?= "1.99.1%"
 
 # For lack of a better place to put this since it needs to be visible
 # globally, carry it here.
-RECIPE_MAINTAINER:pn-rust-source-1.99.0 = "Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>"
+RECIPE_MAINTAINER:pn-rust-source-1.99.1 = "Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>"
diff --git a/recipes-devtools/rust/cargo_1.99.0.bb b/recipes-devtools/rust/cargo_1.99.1.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.99.0.bb
rename to recipes-devtools/rust/cargo_1.99.1.bb
diff --git a/recipes-devtools/rust/files/0007-cargo-omit-host-triple-from-unit-metadata-hash.patch b/recipes-devtools/rust/files/0004-cargo-omit-host-triple-from-unit-metadata-hash.patch
similarity index 100%
rename from recipes-devtools/rust/files/0007-cargo-omit-host-triple-from-unit-metadata-hash.patch
rename to recipes-devtools/rust/files/0004-cargo-omit-host-triple-from-unit-metadata-hash.patch
diff --git a/recipes-devtools/rust/files/0009-rustc-span-make-hygiene-encoding-order-deterministic.patch b/recipes-devtools/rust/files/0005-rustc-span-make-hygiene-encoding-order-deterministic.patch
similarity index 100%
rename from recipes-devtools/rust/files/0009-rustc-span-make-hygiene-encoding-order-deterministic.patch
rename to recipes-devtools/rust/files/0005-rustc-span-make-hygiene-encoding-order-deterministic.patch
diff --git a/recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch b/recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
deleted file mode 100644
index 99fcd33..0000000
--- a/recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
+++ /dev/null
@@ -1,38 +0,0 @@
-From: Sunil Dora <sunilkumar.dora@windriver.com>
-Date: Wed, 26 Aug 2026 16:30:00 +0530
-Subject: [PATCH] rustc_codegen_llvm: do not pass amx-tf32 to LLVM 23
-
-LLVM 23 removed the x86 amx-tf32 subtarget feature
-(https://github.com/llvm/llvm-project/pull/207673). rust 1.98 still
-lists it in the x86 table in rustc_target, so a rustc built against
-LLVM 23 aborts at startup with
-
-  '+amx-tf32' is not a recognized feature for this target
-
-Skip the feature in to_llvm_features when the LLVM in use is 23 or
-newer, in the same style the surrounding code already uses for
-avx10.1/avx10.2 on older LLVM majors. amx-tf32 is the only x86
-feature LLVM 23 removed; the rest of the table still matches X86.td.
-
-rust dropped the feature outright after 1.98
-(https://github.com/rust-lang/rust/pull/159310), which requires
-LLVM 23 or newer unconditionally. This recipe builds against whatever
-LLVM major the layer provides, so the version guard is kept instead.
-
-Upstream-Status: Inappropriate [rust dropped the feature after 1.98 via https://github.com/rust-lang/rust/pull/159310; this guard only exists to build 1.98 against more than one LLVM major]
-Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
----
- compiler/rustc_codegen_llvm/src/llvm_util.rs | 2 ++
- 1 file changed, 2 insertions(+)
-
---- a/compiler/rustc_codegen_llvm/src/llvm_util.rs
-+++ b/compiler/rustc_codegen_llvm/src/llvm_util.rs
-@@ -286,6 +286,8 @@
-                     s,
-                     smallvec![TargetFeatureFoldStrength::EnableOnly("evex512")],
-                 )),
-+                // AMX-TF32 was removed from LLVM 23
-+                "amx-tf32" if major >= 23 => None,
-                 "avx10.1" if major < 22 => Some(LLVMFeature::new("avx10.1-512")),
-                 "avx10.2" if major < 22 => Some(LLVMFeature::new("avx10.2-512")),
-                 "apxf" => Some(LLVMFeature::with_dependencies(
diff --git a/recipes-devtools/rust/libstd-rs_1.99.0.bb b/recipes-devtools/rust/libstd-rs_1.99.1.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.99.0.bb
rename to recipes-devtools/rust/libstd-rs_1.99.1.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.99.0.bb b/recipes-devtools/rust/rust-cross-canadian_1.99.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.99.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.99.1.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.99.0.bb b/recipes-devtools/rust/rust-llvm_1.99.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.99.0.bb
rename to recipes-devtools/rust/rust-llvm_1.99.1.bb
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 061edaf..7859573 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -6,11 +6,10 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
             file://0002-Fix-rust-build-failure-with-unstable-options.patch;patchdir=${RUSTSRC} \
             file://0003-bootstrap-skip-StdarchVerify-when-remote-testing.patch;patchdir=${RUSTSRC} \
-            file://0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch;patchdir=${RUSTSRC} \
-            file://0007-cargo-omit-host-triple-from-unit-metadata-hash.patch;patchdir=${RUSTSRC} \
-            file://0009-rustc-span-make-hygiene-encoding-order-deterministic.patch;patchdir=${RUSTSRC} \
+            file://0004-cargo-omit-host-triple-from-unit-metadata-hash.patch;patchdir=${RUSTSRC} \
+            file://0005-rustc-span-make-hygiene-encoding-order-deterministic.patch;patchdir=${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] = "cc41916a8c84f5d9ec4f55561b44e39f43b647b133f8a6f51be9ea13c83f7036"
+SRC_URI[rust.sha256sum] = "6451598a99e77f07571960f6b21d577399d3a30f33e80cbd2e3a4aae6535d265"
 
 # Point UNPACKDIR into the work-shared location so rust-source.bb and all
 # consumers (via S/RUSTSRC) reference a single shared source tree.
diff --git a/recipes-devtools/rust/rust-source_1.99.0.bb b/recipes-devtools/rust/rust-source_1.99.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust-source_1.99.0.bb
rename to recipes-devtools/rust/rust-source_1.99.1.bb
diff --git a/recipes-devtools/rust/rust_1.99.0.bb b/recipes-devtools/rust/rust_1.99.1.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.99.0.bb
rename to recipes-devtools/rust/rust_1.99.1.bb
-- 
2.56.1

