Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E2BC55179
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4584.1785497604453695733
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JstAiwP2;
 spf=pass (domain: konsulko.com, ip: 209.85.219.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f186025973so9486686d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497603; x=1786102403; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=doGzdYaMnTl7iZOPn+UYm2anM+wIWkaHucjzQ5FpQ3A=;
        b=JstAiwP2oLXElTc8diQNPv9NQqw/CqbLIupJrcj7cXC29ZevRpgckwMEg0xaG48BXC
         ArI5AExYvqfipOWcE3a2BQJKtHY/ozT8vY3IFTyVR4vty4rN/9mvUwXcvo3rOLSf1Fcy
         D70Sr/Iln786RvvV52fIiqazzT5N8bQLZTb/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497603; x=1786102403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=doGzdYaMnTl7iZOPn+UYm2anM+wIWkaHucjzQ5FpQ3A=;
        b=IuhS0Xqoyd6P69f0g50SJahEM9URmG+pc2aQUj5MG8NTsotVU+KUH1EpEjiPy0DJXQ
         sQ7L/aAMKVoYCp7W7xdo+a+oQ0wLPA0JjYmZ3Qx1CKDTB6fTjVPf0/llemrJBMammbEX
         4KvPWyEGuDC38jaY32pEal/iONsJWooY1qZEGYtPSu4rvP2K4PokNkOulz5hsiOhmNWg
         D6FpdS06lke5QnDpieVfi9ms5uG58tu7ckBzjBpE2n6mtJmAmd7DqonnsLM4ieittJj9
         SZI6FKkmPnkWD9M8ExVL4HIz9k1dZDnXmKB2Bt0/31Lc7qNCag64fwaDtmbPnSRqQUqk
         dRKg==
X-Gm-Message-State: AOJu0YxnKaLT9whpxtoVFAqEcRM9tOTLo7ymZb2lBtl9oCAL+ufmtNlx
	aWa5sR3x0jWmxusJ9zhmZgZhcNy5+2lNep0as2FaCHiCgaqEzmjliQWOnTxcZsXpbuVMhlzRthT
	IkF8r
X-Gm-Gg: AR+sD13nyEDdv9f6CjtcMp9VPmvM4mDbpXZDzSz9nXVPnDDweA9ivDfFFHWNoxy7Sjb
	jEoVECPapFq4jK5rA2LoDsEMuI7djPrDS64dblUwE89KxXZkb5471K9ZsT9sFDg6xP2FK7xYxWV
	Oz4a/k/UkyP1tkXVW52o3RrJK6JyKWyYmsjM+ulyyQ8Q/lQf6AGMMXW+77tbp1bV9t8XuL0XiVi
	S8ud8927RSWFwl/0N3ZsAWO8YvX7a2sIe1fFTlV55hXUqZbkOuOI1pgIxv0/E/MQfvrkiOVxSz7
	oZZcEffxXYGrq7UR0Dow0ufiNsHS7QK2MXBBhKM7KfH1R3ipR18Z6jvuIAlucgqM+BqfhAWA10T
	GU38psSc6KvY+M218YUNkpLedVkhNq7hD/1JtFEoRJuCz9jqkBg4286KsnatU997OsGswUeEd+p
	yT2HnEkntdxd5k0LFYpj8GiE7hQKWFdLPrvu1+yFn1MUp1abm6ERh31n34MDJ0SJH1LeepLm3dH
	OM+pD1KJM8Ibxp2y0a+MBEtajfCnGhmAm4ljmej1JXUYJanrvHqRSJvO1oHVN+IORZilxs47ji3
	j8xaM8K4gFq6e5AHr6uzJDisoR/tP0ogjIYc
X-Received: by 2002:a05:620a:440a:b0:92e:fc45:3472 with SMTP id af79cd13be357-9349ab4837dmr148135485a.29.1785497603063;
        Fri, 31 Jul 2026 04:33:23 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.22
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:22 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 07/35] rust: Drop revert-link-std-statically-in-rustc_driver-feature.patch
Date: Fri, 31 Jul 2026 07:32:37 -0400
Message-ID: <030e8a021fa14697d084b22e6d1189ab26a23a67.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4583

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Starting from Rust 1.82, std is statically linked with rustc_driver.so.
This change affected the runtime dependencies of the rustc_main test
binary, causing tests to fail in QEMU because librustc_driver*.so is
not shipped and cannot be found.

After discussing with upstream, the patch is removed, and the test is
skipped using #[cfg(not(test))]. The rustc_main function does not include
any test code,so this safely restores the feature without impacting tests.

Upstream Discussion:
https://github.com/rust-lang/rust/pull/153409

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b0ea86d95b921ef2c585faf97b1a0cc14c7f1489)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...d-statically-in-rustc_driver-feature.patch | 229 ------------------
 .../rust/files/rust-oe-selftest.patch         |  13 +
 recipes-devtools/rust/rust-source.inc         |   1 -
 3 files changed, 13 insertions(+), 230 deletions(-)
 delete mode 100644 recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch

diff --git a/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch b/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
deleted file mode 100644
index 9d345bc..0000000
--- a/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
+++ /dev/null
@@ -1,229 +0,0 @@
-rust: oe-selftest issue fix with v1.82
-
-A new feature "Link std statically in rustc_driver" was introduced 
-in rust_1.82 [https://github.com/rust-lang/rust/pull/122362],and 
-which is causing the below failure in oe-selftest.
-
-Running unittests src/main.rs (build/x86_64-unknown-linux-gnu/stage1-rustc/
-x86_64-poky-linux-gnu/release/deps/rustc_main-92223b15c9f2d827)
-uploaded ".../build/x86_64-unknown-linux-gnu/stage1-rustc/x86_64-poky-linux-gnu/
-release/deps/rustc_main-92223b15c9f2d827", waiting for result
-/tmp/work/test4056/rustc_main-92223b15c9f2d827: error while loading shared 
-libraries: librustc_driver-fb0866b1cd913c20.so: cannot open shared object file: No 
-such file or directory
-
-The rustc_main binary depends on the librustc_driver-*.so file. However, 
-this file has not been copied to QEMU. If we manually copy the file into 
-QEMU and export the LD_LIBRARY_PATH, the issue does not occur. Issue 
-reprorted to upstream and reverted the buggy code as a workaround.
-
-Upstream-Status: Inappropriate [reported at https://github.com/rust-lang/rust/issues/136237]
-
-Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
-diff --git a/compiler/rustc/src/main.rs b/compiler/rustc/src/main.rs
-index e9a7397557..29766fc9d8 100644
---- a/compiler/rustc/src/main.rs
-+++ b/compiler/rustc/src/main.rs
-@@ -1,5 +1,3 @@
--// We need this feature as it changes `dylib` linking behavior and allows us to link to `rustc_driver`.
--#![feature(rustc_private)]
- // Several crates are depended upon but unused so that they are present in the sysroot
- #![expect(unused_crate_dependencies)]
-
-diff --git a/compiler/rustc_metadata/src/dependency_format.rs b/compiler/rustc_metadata/src/dependency_format.rs
-index 39fa23766b..51d86b4009 100644
---- a/compiler/rustc_metadata/src/dependency_format.rs
-+++ b/compiler/rustc_metadata/src/dependency_format.rs
-@@ -51,7 +51,7 @@
- //! Additionally, the algorithm is geared towards finding *any* solution rather
- //! than finding a number of solutions (there are normally quite a few).
-
--use rustc_data_structures::fx::{FxHashMap, FxHashSet};
-+use rustc_data_structures::fx::FxHashMap;
- use rustc_hir::def_id::{CrateNum, LOCAL_CRATE};
- use rustc_index::IndexVec;
- use rustc_middle::bug;
-@@ -159,46 +159,19 @@ fn calculate_type(tcx: TyCtxt<'_>, ty: CrateType) -> DependencyList {
-         }
-         Linkage::Dynamic | Linkage::IncludedFromDylib => {}
-     }
--
--    let all_dylibs = || {
--        tcx.crates(()).iter().filter(|&&cnum| {
--            !tcx.dep_kind(cnum).macros_only()
--                && (tcx.used_crate_source(cnum).dylib.is_some()
--                    || tcx.used_crate_source(cnum).sdylib_interface.is_some())
--        })
--    };
--
--    let mut upstream_in_dylibs = FxHashSet::default();
--
--    if tcx.features().rustc_private() {
--        // We need this to prevent users of `rustc_driver` from linking dynamically to `std`
--        // which does not work as `std` is also statically linked into `rustc_driver`.
--
--        // Find all libraries statically linked to upstream dylibs.
--        for &cnum in all_dylibs() {
--            let deps = tcx.dylib_dependency_formats(cnum);
--            for &(depnum, style) in deps.iter() {
--                if let RequireStatic = style {
--                    upstream_in_dylibs.insert(depnum);
--                }
--            }
--        }
--    }
--
-     let mut formats = FxHashMap::default();
-
-     // Sweep all crates for found dylibs. Add all dylibs, as well as their
-     // dependencies, ensuring there are no conflicts. The only valid case for a
-     // dependency to be relied upon twice is for both cases to rely on a dylib.
--    for &cnum in all_dylibs() {
--        if upstream_in_dylibs.contains(&cnum) {
--            info!("skipping dylib: {}", tcx.crate_name(cnum));
--            // If this dylib is also available statically linked to another dylib
--            // we try to use that instead.
-+    for &cnum in tcx.crates(()).iter() {
-+        if tcx.dep_kind(cnum).macros_only() {
-             continue;
-         }
-
-         let name = tcx.crate_name(cnum);
-+        let src = tcx.used_crate_source(cnum);
-+        if src.dylib.is_some() {
-         info!("adding dylib: {}", name);
-         add_library(tcx, cnum, RequireDynamic, &mut formats, &mut unavailable_as_static);
-         let deps = tcx.dylib_dependency_formats(cnum);
-@@ -207,6 +182,7 @@ fn calculate_type(tcx: TyCtxt<'_>, ty: CrateType) -> DependencyList {
-             add_library(tcx, depnum, style, &mut formats, &mut unavailable_as_static);
-         }
-     }
-+    }
-
-     // Collect what we've got so far in the return vector.
-     let last_crate = tcx.crates(()).len();
-diff --git a/src/bootstrap/src/bin/rustc.rs b/src/bootstrap/src/bin/rustc.rs
-index d04e2fbeb7..011c289d93 100644
---- a/src/bootstrap/src/bin/rustc.rs
-+++ b/src/bootstrap/src/bin/rustc.rs
-@@ -92,24 +92,6 @@ fn main() {
-         rustc_real
-     };
-
--    // Get the name of the crate we're compiling, if any.
--    let crate_name = parse_value_from_args(&orig_args, "--crate-name");
--
--    // When statically linking `std` into `rustc_driver`, remove `-C prefer-dynamic`
--    if env::var("RUSTC_LINK_STD_INTO_RUSTC_DRIVER").unwrap() == "1"
--        && crate_name == Some("rustc_driver")
--    {
--        if let Some(pos) = args.iter().enumerate().position(|(i, a)| {
--            a == "-C" && args.get(i + 1).map(|a| a == "prefer-dynamic").unwrap_or(false)
--        }) {
--            args.remove(pos);
--            args.remove(pos);
--        }
--        if let Some(pos) = args.iter().position(|a| a == "-Cprefer-dynamic") {
--            args.remove(pos);
--        }
--    }
--
-     let mut cmd = match env::var_os("RUSTC_WRAPPER_REAL") {
-         Some(wrapper) if !wrapper.is_empty() => {
-             let mut cmd = Command::new(wrapper);
-@@ -120,6 +102,9 @@ fn main() {
-     };
-     cmd.args(&args).env(dylib_path_var(), env::join_paths(&dylib_path).unwrap());
-
-+    // Get the name of the crate we're compiling, if any.
-+    let crate_name = parse_value_from_args(&orig_args, "--crate-name");
-+
-     if let Some(crate_name) = crate_name
-         && let Some(target) = env::var_os("RUSTC_TIME")
-         && (target == "all"
-diff --git a/src/bootstrap/src/core/builder/cargo.rs b/src/bootstrap/src/core/builder/cargo.rs
-index 0688a1d689..066e6bf53f 100644
---- a/src/bootstrap/src/core/builder/cargo.rs
-+++ b/src/bootstrap/src/core/builder/cargo.rs
-@@ -1146,7 +1146,7 @@ impl Builder<'_> {
-         // When we build Rust dylibs they're all intended for intermediate
-         // usage, so make sure we pass the -Cprefer-dynamic flag instead of
-         // linking all deps statically into the dylib.
--        if matches!(mode, Mode::Std) {
-+        if matches!(mode, Mode::Std | Mode::Rustc) {
-             rustflags.arg("-Cprefer-dynamic");
-         }
-         if matches!(mode, Mode::Rustc) && !self.link_std_into_rustc_driver(target) {
-diff --git a/src/tools/clippy/src/main.rs b/src/tools/clippy/src/main.rs
-index c9853e53f3..c9af2138a7 100644
---- a/src/tools/clippy/src/main.rs
-+++ b/src/tools/clippy/src/main.rs
-@@ -1,6 +1,3 @@
--// We need this feature as it changes `dylib` linking behavior and allows us to link to
--// `rustc_driver`.
--#![feature(rustc_private)]
- // warn on lints, that are included in `rust-lang/rust`s bootstrap
- #![warn(rust_2018_idioms, unused_lifetimes)]
-
-diff --git a/src/tools/clippy/tests/compile-test.rs b/src/tools/clippy/tests/compile-test.rs
-index 9754254cdd..dd95cc71cd 100644
---- a/src/tools/clippy/tests/compile-test.rs
-+++ b/src/tools/clippy/tests/compile-test.rs
-@@ -1,4 +1,4 @@
--#![feature(rustc_private)]
-+// warn on lints, that are included in `rust-lang/rust`s bootstrap
- #![warn(rust_2018_idioms, unused_lifetimes)]
- #![allow(unused_extern_crates)]
-
-diff --git a/src/tools/rustdoc/main.rs b/src/tools/rustdoc/main.rs
-index d4099cafe5..5b499a1fa1 100644
---- a/src/tools/rustdoc/main.rs
-+++ b/src/tools/rustdoc/main.rs
-@@ -1,6 +1,3 @@
--// We need this feature as it changes `dylib` linking behavior and allows us to link to `rustc_driver`.
--#![feature(rustc_private)]
--
- fn main() {
-     rustdoc::main()
- }
-diff --git a/src/tools/rustfmt/src/git-rustfmt/main.rs b/src/tools/rustfmt/src/git-rustfmt/main.rs
-index b8b0432aa9..b5bd71e015 100644
---- a/src/tools/rustfmt/src/git-rustfmt/main.rs
-+++ b/src/tools/rustfmt/src/git-rustfmt/main.rs
-@@ -1,7 +1,3 @@
--// We need this feature as it changes `dylib` linking behavior and allows us to link to
--// `rustc_driver`.
--#![feature(rustc_private)]
--
- use std::env;
- use std::io::stdout;
- use std::path::{Path, PathBuf};
-diff --git a/src/bootstrap/src/core/build_steps/compile.rs b/src/bootstrap/src/core/build_steps/compile.rs
-index 27bbc8bd8f..a6fc4df2eb 100644
---- a/src/bootstrap/src/core/build_steps/compile.rs
-+++ b/src/bootstrap/src/core/build_steps/compile.rs
-@@ -2158,23 +2158,7 @@
-         for f in builder.read_dir(&src_libdir) {
-             let filename = f.file_name().into_string().unwrap();
- 
--            let is_proc_macro = proc_macros.contains(&filename);
--            let is_dylib_or_debug = is_dylib(&f.path()) || is_debug_info(&filename);
--
--            // If we link statically to stdlib, do not copy the libstd dynamic library file
--            // FIXME: Also do this for Windows once incremental post-optimization stage0 tests
--            // work without std.dll (see https://github.com/rust-lang/rust/pull/131188).
--            let can_be_rustc_dynamic_dep = if builder
--                .link_std_into_rustc_driver(target_compiler.host)
--                && !target_compiler.host.is_windows()
--            {
--                let is_std = filename.starts_with("std-") || filename.starts_with("libstd-");
--                !is_std
--            } else {
--                true
--            };
--
--            if is_dylib_or_debug && can_be_rustc_dynamic_dep && !is_proc_macro {
-+            if (is_dylib(Path::new(&filename)) || is_debug_info(&filename)) && !proc_macros.contains(&filename) {
-                 builder.copy_link(&f.path(), &rustc_libdir.join(&filename), FileType::Regular);
-             }
-         }
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-devtools/rust/files/rust-oe-selftest.patch
index e96598f..9cbfc62 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -6,6 +6,7 @@ Upstream-Status: Inappropriate [OE testing specific]
 Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
 # added executable-no-mangle-strip.rs ignore
 Signed-off-by: Peter Tatrai <Peter.Tatrai@siemens.com>
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
 ---
 diff --git a/compiler/rustc_errors/src/markdown/tests/term.rs b/compiler/rustc_errors/src/markdown/tests/term.rs
 --- a/compiler/rustc_errors/src/markdown/tests/term.rs
@@ -266,3 +267,15 @@ index af44dfe..e6674e5 100644
  //@ ignore-wasm different `main` convention
  
  #![feature(lang_items)]
+diff --git a/compiler/rustc/src/main.rs b/compiler/rustc/src/main.rs
+index 89c61cd..144ea0e 100644
+--- a/compiler/rustc/src/main.rs
++++ b/compiler/rustc/src/main.rs
+@@ -38,6 +38,7 @@
+ #[cfg(feature = "jemalloc")]
+ use tikv_jemalloc_sys as _;
+
++#[cfg(not(test))]
+ fn main() {
+     rustc_driver::main()
+ }
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index e0a6190..a5423d0 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -6,7 +6,6 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=${RUSTSRC} \
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=${RUSTSRC} \
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
-            file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
             file://0001-riscv32-Define-plain-syscalls-as-their-time64-varian.patch;patchdir=${RUSTSRC} \
             file://0001-Update-call-llvm-intrinsics-test.patch;patchdir=${RUSTSRC} \
 "
-- 
2.55.0


