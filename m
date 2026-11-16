Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6313.1794870786732562428
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:13:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TIyyC7ev;
 spf=pass (domain: konsulko.com, ip: 209.85.221.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so242929e0c.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870786; x=1795475586; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QjxB+tMj1nO8rbCL9vFsUTBIto/hopsJXhMdFjT4Ui4=;
        b=TIyyC7evFBzokG44PgvS19Ur4XvPE6tMtxgUagNSeraXYeDFh4r8/GkCusAMgUySHU
         jfbcw2avspzQ0zviFyZxripHHrGW2FSCKGiWOOZqd2H6gs7sHVajN5DhXIHZd/Od8UTM
         EU3ci0Dc+3fTbUx+v2DLyU7Y9OThd+2NDRjIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870786; x=1795475586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QjxB+tMj1nO8rbCL9vFsUTBIto/hopsJXhMdFjT4Ui4=;
        b=QB4VCkRxXTDJIkPjdrgNxsV53adATBv6DfaZLEf2dNi+TCPo7I+ztX97MNXP6r0S/k
         V56jns/mY4mUL75q8hDlJboTBGwYDscSiGewmmIXiwby45F3aH+7uZCOQAALJWMCTT8a
         VimH4CHNv8YshaKFXddbN4OsRSFW1PJ9dd/xYB5Q4PGPXsMGQJDjQLXP3s1pbv3FufxD
         3n3zJ/OVzp/hdvygfYjZHmdG7f5c89ytk4eQ9YlZIyXAxYc37kJoaogkaY1tJT9Av2vW
         J6E/Pr0+laKGqP1Xk/ScwQS+kXXtFYUN4xtdO8mZ4hAIA78+lYO7QpeQb8iWuUQu9ZFp
         WyTg==
X-Gm-Message-State: APuU4Z/Tk9kFXOzRC2ECKtfcRxH7f0jp+EjiYdEc4Bs7/6TZq5zKHHtr
	UZ4k3FphZc3GqEFL96jEcE0vKKSJ2aMiOz2/sXsPXMg6pLZf31Yatt0vDrZtj4DriDunqwBdLlM
	8MqLAn6A=
X-Gm-Gg: AYBFou066lc8+1c0LD/VCV/SjUYK6SoDJWd9stzpxlEN/LpS5db9+95NFM76zUB/jvY
	Oa59FOpy3mrFFshp59KBbJO5cx2OWkjQvYyw1khNYOhabpmwCrRzWOlXorUdP1/x7VKMGdQG25O
	jANgbC7XUi7ONQwbYNW2oJpH1zdZH9R3gvvXabTS2GGU7k9eN0DHHk4a8alMHNYVtRN6Q5sLUdN
	9r1BBiKFX/9+FlhJ0tE2OjzURHS7qTM2vZcIUN0tg45JAR8YR+MAaWyPWd2jnIZUsiUV+N92tCs
	g39ZpHUoAA93kUT583dTNqy4vrsSgt0GuDwSjTJ4mZuaSPWpJKB6FfDwyCMnQlbBxSMfExYrM36
	dp8fOhh2kMsu9rEyMLnwwQYEnMkaZEHL4UTdWCwhqqB87m5IXCFgGuMtwdsU7/zMpS0D3Ic0AOW
	mQDJld+J/uQjxNZOibEShT5p6ExHMRx73IWpF134j154yKoMq3wEpNmOxAuW+IEeyhMPw9TS08p
	WEhns6UdBWC1UwV5Dqw/gZwchPmlZvGA5TAHFHJrpVyXpvNhLbHOYdzIvlevsto8uMI2klmULb7
	Zq8Mj7NJXNG4ujqIeA4G+F7hwXLXHNemrwNmbuvwl2PS9SRdpR0LJwwYPTzWt35Vqe0oLFdC5dd
	9szPaQZTph9BEb4v0vO8gVXGNGTZWBij7AWR/HJbBj2vKCCW5Vbt+29saK0dRVkQ6wA==
X-Received: by 2002:a05:6122:3c50:b0:5ed:fbbd:7ee3 with SMTP id 71dfb90a1353d-5ee5b627028mr283540e0c.2.1794870785344;
        Mon, 16 Nov 2026 15:13:05 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.13.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:13:05 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 16/19] rust: Upgrade 1.99.0 -> 1.99.1
Date: Mon, 16 Nov 2026 18:12:37 -0500
Message-ID: <3af3dcb799adb63a11e9511b4ce3830fca9298ad.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5454
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
 recipes-devtools/rust/rust-source.inc         |  7 ++--
 ...source_1.99.0.bb => rust-source_1.99.1.bb} |  0
 .../rust/{rust_1.99.0.bb => rust_1.99.1.bb}   |  0
 10 files changed, 5 insertions(+), 44 deletions(-)
 rename recipes-devtools/rust/{cargo_1.99.0.bb => cargo_1.99.1.bb} (100%)
 rename recipes-devtools/rust/files/{0007-cargo-omit-host-triple-from-unit-metadata-hash.patch => 0004-cargo-omit-host-triple-from-unit-metadata-hash.patch} (100%)
 rename recipes-devtools/rust/files/{0009-rustc-span-make-hygiene-encoding-order-deterministic.patch => 0005-rustc-span-make-hygiene-encoding-order-deterministic.patch} (100%)
 delete mode 100644 recipes-devtools/rust/files/0005-rustc_codegen_llvm-Do-not-pass-amx-tf32-to-LLVM-23.patch
 rename recipes-devtools/rust/{libstd-rs_1.99.0.bb => libstd-rs_1.99.1.bb} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.99.0.bb => rust-cross-canadian_1.99.1.bb} (100%)
 rename recipes-devtools/rust/{rust-source_1.99.0.bb => rust-source_1.99.1.bb} (100%)
 rename recipes-devtools/rust/{rust_1.99.0.bb => rust_1.99.1.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 20e9365..b563428 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -13,8 +13,8 @@ LAYERSERIES_COMPAT_wrynose-rust-mixin = "wrynose"
 
 LAYERDEPENDS_wrynose-rust-mixin = "core"
 
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
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index d9c00e9..b384a0c 100644
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
2.56.0

