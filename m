Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7335C3ABB2
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:51 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.web11.4643.1746132048061753926
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GbCdOJaY;
 spf=pass (domain: konsulko.com, ip: 209.85.160.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4769aef457bso19937551cf.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132046; x=1746736846; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKoBxXgIJKZKfGQNhdKOYXSOJ9MVsLUMJyAPJQEmoqs=;
        b=GbCdOJaYY7oTLlmOib+vRRd+KFpeJncmxaaGxXmbsdQjI9sa/Veh1VJYBIghQK4aMc
         Y1LEqqWn4kcr7SrBHmdxxqP4+bvnI0Ojs3FCErER56VsgeT7jLfn5PijsEUbgcbkQjuq
         /MEaE7J0SDBkMDSvUruB3X2xEWI8G0caeqSjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132046; x=1746736846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKoBxXgIJKZKfGQNhdKOYXSOJ9MVsLUMJyAPJQEmoqs=;
        b=FIqWJkK/X+hs70RAhB7SXx9o94nlmaGnSWwgN06U7fMVEjk5Nb3pLoKpm3CcpKfFA0
         U95Qzdg5506jKLHcNgdwfnWFiF5aO5yxGTBkyxz5LPejwZ6EwLc/ZB9bQfzDRLZXh9vp
         BMho1YBbpERFg4ba2QCOaDp7Kz6SVXhlRVIAsDTa2pwPoRftdxGqzOREzOHizoca0Taz
         n7zDFqv2jLHmtxZx4kjYp178VLFw3Px0s/d4XbacsZm3pcuir8VuCbdD3e1SRv+PC0Jn
         EVNczBp5Qb/T0tN+hMVloXYiOgBEIOq9TLDCcoht3hBA7tIlCJEUlEnYeGZbqOuXGRNh
         ORyg==
X-Gm-Message-State: AOJu0YyuE3DEGEgYIwcilMfi7O4IFoJBOLbavSyL4nXHrrcI9l9mK3sC
	qaKDOosA40L08+wQ/QkEkrNcQ8KZ9uR0zQuPrYNaB9c3cTz/Z2iIGkfaVNONV+8snETW9WPqGFf
	m
X-Gm-Gg: ASbGnctsoBYTGVeLOaM5beXoWTCbMT6NEu11l5s01HNsX5mSsq7PSnRQix+jGIA/VnL
	1S98+O2+9JgIPouTujCk2u0hhd3V2OcnjAMF6+5a7eaSfo1YqfVw8gV+Ekrq957JPha+EO1ZKSG
	bkZR4x9AhJdwc50UOccsUw8RitstxL7WgKjnV+PKrysQcvA+mTwjlRlJjoVcUS+IDxKGgcaoRsv
	u6cNjP+bRMibhIxqNyun8UfO9eqR8z1nNbWNcGvjLNt2CRSx16a3c9TKkr834rNmiPzKyPkoIna
	Ggdf0U/LGZygrc1IpMUQtVRdxe6hqjQjo2k2ga2zZnhiDlswcp9v/ZeoKcxISwHJJs6Nf02LuiS
	1MdoRThtrpX4JayK0
X-Google-Smtp-Source: AGHT+IHWMUMcvjoj9Mwbu06YSDNFKvuWcYcs/xKVjsuVNfnnYCb5UqEElRqrS9cJXfWQ+8wMv44rug==
X-Received: by 2002:a05:622a:420e:b0:48b:4d30:fced with SMTP id d75a77b69052e-48c2e474827mr6193621cf.0.1746132046279;
        Thu, 01 May 2025 13:40:46 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:45 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 11/38] rust: oe-selftest issue fix with v1.82
Date: Thu,  1 May 2025 16:39:47 -0400
Message-ID: <b4ae5796e2308a2f5d479ef5edd4c211deb723af.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1437

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

A new feature "Link std statically in rustc_driver" was introduced
in rust_1.82 [https://github.com/rust-lang/rust/pull/122362],and
which is causing the below failure in oe-selftest.

Running unittests src/main.rs (build/x86_64-unknown-linux-gnu/stage1-rustc/
x86_64-poky-linux-gnu/release/deps/rustc_main-92223b15c9f2d827)
uploaded ".../build/x86_64-unknown-linux-gnu/stage1-rustc/x86_64-poky-linux-gnu/
release/deps/rustc_main-92223b15c9f2d827", waiting for result
/tmp/work/test4056/rustc_main-92223b15c9f2d827: error while loading shared
libraries: librustc_driver-fb0866b1cd913c20.so: cannot open shared object file: No
such file or directory

The rustc_main binary depends on the librustc_driver-*.so file. However,
this file has not been copied to QEMU. If we manually copy the file into
QEMU and export the LD_LIBRARY_PATH, the issue does not occur. Issue
reprorted to upstream and reverted the buggy code as a workaround.

Upstream-Status: Inappropriate [reported at https://github.com/rust-lang/rust/issues/136237]

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 977bd1a10771a6588e596e1bbfd49e9af659aa4a)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...d-statically-in-rustc_driver-feature.patch | 199 ++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |   1 +
 2 files changed, 200 insertions(+)
 create mode 100644 recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch

diff --git a/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch b/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
new file mode 100644
index 0000000..257883e
--- /dev/null
+++ b/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_driver-feature.patch
@@ -0,0 +1,199 @@
+rust: oe-selftest issue fix with v1.82
+
+A new feature "Link std statically in rustc_driver" was introduced 
+in rust_1.82 [https://github.com/rust-lang/rust/pull/122362],and 
+which is causing the below failure in oe-selftest.
+
+Running unittests src/main.rs (build/x86_64-unknown-linux-gnu/stage1-rustc/
+x86_64-poky-linux-gnu/release/deps/rustc_main-92223b15c9f2d827)
+uploaded ".../build/x86_64-unknown-linux-gnu/stage1-rustc/x86_64-poky-linux-gnu/
+release/deps/rustc_main-92223b15c9f2d827", waiting for result
+/tmp/work/test4056/rustc_main-92223b15c9f2d827: error while loading shared 
+libraries: librustc_driver-fb0866b1cd913c20.so: cannot open shared object file: No 
+such file or directory
+
+The rustc_main binary depends on the librustc_driver-*.so file. However, 
+this file has not been copied to QEMU. If we manually copy the file into 
+QEMU and export the LD_LIBRARY_PATH, the issue does not occur. Issue 
+reprorted to upstream and reverted the buggy code as a workaround.
+
+Upstream-Status: Inappropriate [reported at https://github.com/rust-lang/rust/issues/136237]
+
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
+diff --git a/compiler/rustc/src/main.rs b/compiler/rustc/src/main.rs
+index e9a7397557..29766fc9d8 100644
+--- a/compiler/rustc/src/main.rs
++++ b/compiler/rustc/src/main.rs
+@@ -1,6 +1,3 @@
+-// We need this feature as it changes `dylib` linking behavior and allows us to link to `rustc_driver`.
+-#![feature(rustc_private)]
+-
+ // A note about jemalloc: rustc uses jemalloc when built for CI and
+ // distribution. The obvious way to do this is with the `#[global_allocator]`
+ // mechanism. However, for complicated reasons (see
+diff --git a/compiler/rustc_metadata/src/dependency_format.rs b/compiler/rustc_metadata/src/dependency_format.rs
+index 39fa23766b..51d86b4009 100644
+--- a/compiler/rustc_metadata/src/dependency_format.rs
++++ b/compiler/rustc_metadata/src/dependency_format.rs
+@@ -51,7 +51,7 @@
+ //! Additionally, the algorithm is geared towards finding *any* solution rather
+ //! than finding a number of solutions (there are normally quite a few).
+
+-use rustc_data_structures::fx::{FxHashMap, FxHashSet};
++use rustc_data_structures::fx::FxHashMap;
+ use rustc_hir::def_id::CrateNum;
+ use rustc_middle::bug;
+ use rustc_middle::middle::dependency_format::{Dependencies, DependencyList, Linkage};
+@@ -162,43 +162,18 @@ fn calculate_type(tcx: TyCtxt<'_>, ty: CrateType) -> DependencyList {
+         Linkage::Dynamic | Linkage::IncludedFromDylib => {}
+     }
+
+-    let all_dylibs = || {
+-        tcx.crates(()).iter().filter(|&&cnum| {
+-            !tcx.dep_kind(cnum).macros_only() && tcx.used_crate_source(cnum).dylib.is_some()
+-        })
+-    };
+-
+-    let mut upstream_in_dylibs = FxHashSet::default();
+-
+-    if tcx.features().rustc_private {
+-        // We need this to prevent users of `rustc_driver` from linking dynamically to `std`
+-        // which does not work as `std` is also statically linked into `rustc_driver`.
+-
+-        // Find all libraries statically linked to upstream dylibs.
+-        for &cnum in all_dylibs() {
+-            let deps = tcx.dylib_dependency_formats(cnum);
+-            for &(depnum, style) in deps.iter() {
+-                if let RequireStatic = style {
+-                    upstream_in_dylibs.insert(depnum);
+-                }
+-            }
+-        }
+-    }
+-
+     let mut formats = FxHashMap::default();
+
+     // Sweep all crates for found dylibs. Add all dylibs, as well as their
+     // dependencies, ensuring there are no conflicts. The only valid case for a
+     // dependency to be relied upon twice is for both cases to rely on a dylib.
+-    for &cnum in all_dylibs() {
+-        if upstream_in_dylibs.contains(&cnum) {
+-            info!("skipping dylib: {}", tcx.crate_name(cnum));
+-            // If this dylib is also available statically linked to another dylib
+-            // we try to use that instead.
++    for &cnum in tcx.crates(()).iter() {
++        if tcx.dep_kind(cnum).macros_only() {
+             continue;
+         }
+-
+         let name = tcx.crate_name(cnum);
++        let src = tcx.used_crate_source(cnum);
++        if src.dylib.is_some() {
+         info!("adding dylib: {}", name);
+         add_library(tcx, cnum, RequireDynamic, &mut formats, &mut unavailable_as_static);
+         let deps = tcx.dylib_dependency_formats(cnum);
+@@ -207,6 +182,7 @@ fn calculate_type(tcx: TyCtxt<'_>, ty: CrateType) -> DependencyList {
+             add_library(tcx, depnum, style, &mut formats, &mut unavailable_as_static);
+         }
+     }
++    }
+
+     // Collect what we've got so far in the return vector.
+     let last_crate = tcx.crates(()).len();
+diff --git a/src/bootstrap/src/bin/rustc.rs b/src/bootstrap/src/bin/rustc.rs
+index d04e2fbeb7..011c289d93 100644
+--- a/src/bootstrap/src/bin/rustc.rs
++++ b/src/bootstrap/src/bin/rustc.rs
+@@ -89,25 +89,6 @@ fn main() {
+         rustc_real
+     };
+
+-    // Get the name of the crate we're compiling, if any.
+-    let crate_name = parse_value_from_args(&orig_args, "--crate-name");
+-
+-    // When statically linking `std` into `rustc_driver`, remove `-C prefer-dynamic`
+-    if env::var("RUSTC_LINK_STD_INTO_RUSTC_DRIVER").unwrap() == "1"
+-        && crate_name == Some("rustc_driver")
+-        && stage != "0"
+-    {
+-        if let Some(pos) = args.iter().enumerate().position(|(i, a)| {
+-            a == "-C" && args.get(i + 1).map(|a| a == "prefer-dynamic").unwrap_or(false)
+-        }) {
+-            args.remove(pos);
+-            args.remove(pos);
+-        }
+-        if let Some(pos) = args.iter().position(|a| a == "-Cprefer-dynamic") {
+-            args.remove(pos);
+-        }
+-    }
+-
+     let mut cmd = match env::var_os("RUSTC_WRAPPER_REAL") {
+         Some(wrapper) if !wrapper.is_empty() => {
+             let mut cmd = Command::new(wrapper);
+@@ -118,6 +99,9 @@ fn main() {
+     };
+     cmd.args(&args).env(dylib_path_var(), env::join_paths(&dylib_path).unwrap());
+
++    // Get the name of the crate we're compiling, if any.
++    let crate_name = parse_value_from_args(&orig_args, "--crate-name");
++
+     if let Some(crate_name) = crate_name {
+         if let Some(target) = env::var_os("RUSTC_TIME") {
+             if target == "all"
+diff --git a/src/bootstrap/src/core/builder.rs b/src/bootstrap/src/core/builder.rs
+index ff0d1f3a72..b2c9602e57 100644
+--- a/src/bootstrap/src/core/builder.rs
++++ b/src/bootstrap/src/core/builder.rs
+@@ -2153,7 +2153,7 @@ impl<'a> Builder<'a> {
+         // When we build Rust dylibs they're all intended for intermediate
+         // usage, so make sure we pass the -Cprefer-dynamic flag instead of
+         // linking all deps statically into the dylib.
+-        if matches!(mode, Mode::Std) {
++        if matches!(mode, Mode::Std | Mode::Rustc) {
+             rustflags.arg("-Cprefer-dynamic");
+         }
+         if matches!(mode, Mode::Rustc) && !self.link_std_into_rustc_driver(target) {
+diff --git a/src/tools/clippy/src/main.rs b/src/tools/clippy/src/main.rs
+index c9853e53f3..c9af2138a7 100644
+--- a/src/tools/clippy/src/main.rs
++++ b/src/tools/clippy/src/main.rs
+@@ -1,6 +1,3 @@
+-// We need this feature as it changes `dylib` linking behavior and allows us to link to
+-// `rustc_driver`.
+-#![feature(rustc_private)]
+ // warn on lints, that are included in `rust-lang/rust`s bootstrap
+ #![warn(rust_2018_idioms, unused_lifetimes)]
+
+diff --git a/src/tools/clippy/tests/compile-test.rs b/src/tools/clippy/tests/compile-test.rs
+index 9754254cdd..dd95cc71cd 100644
+--- a/src/tools/clippy/tests/compile-test.rs
++++ b/src/tools/clippy/tests/compile-test.rs
+@@ -1,4 +1,4 @@
+-#![feature(rustc_private, let_chains)]
++#![feature(let_chains)]
+ #![warn(rust_2018_idioms, unused_lifetimes)]
+ #![allow(unused_extern_crates)]
+
+diff --git a/src/tools/rustdoc/main.rs b/src/tools/rustdoc/main.rs
+index d4099cafe5..5b499a1fa1 100644
+--- a/src/tools/rustdoc/main.rs
++++ b/src/tools/rustdoc/main.rs
+@@ -1,6 +1,3 @@
+-// We need this feature as it changes `dylib` linking behavior and allows us to link to `rustc_driver`.
+-#![feature(rustc_private)]
+-
+ fn main() {
+     rustdoc::main()
+ }
+diff --git a/src/tools/rustfmt/src/git-rustfmt/main.rs b/src/tools/rustfmt/src/git-rustfmt/main.rs
+index b8b0432aa9..b5bd71e015 100644
+--- a/src/tools/rustfmt/src/git-rustfmt/main.rs
++++ b/src/tools/rustfmt/src/git-rustfmt/main.rs
+@@ -1,7 +1,3 @@
+-// We need this feature as it changes `dylib` linking behavior and allows us to link to
+-// `rustc_driver`.
+-#![feature(rustc_private)]
+-
+ use std::env;
+ use std::io::stdout;
+ use std::path::{Path, PathBuf};
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 73af030..9987aed 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -7,6 +7,7 @@ SRC_URI += "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.xz;n
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=${RUSTSRC} \
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch;patchdir=${RUSTSRC} \
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch;patchdir=${RUSTSRC} \
+	    file://revert-link-std-statically-in-rustc_driver-feature.patch;patchdir=${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] = "1276a0bb8fa12288ba6fa96597d28b40e74c44257c051d3bc02c2b049bb38210"
 
-- 
2.49.0


