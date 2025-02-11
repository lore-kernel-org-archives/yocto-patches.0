Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502A5C021A4
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 19:17:57 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web10.1824.1739301471544612538
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 11:17:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dKwGkRgW;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be8f281714so587852785a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 11:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739301470; x=1739906270; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cogTEm5evil3F9jQBcrljmrK/eqtcGmBsYJZWjGFA8g=;
        b=dKwGkRgWePMGp+385qW5b01DMbaL/fWQFxtFd1krSE2vXxrr1aksYj/KH6XC9zQ3xp
         fkm9Y2Eq72T5Wug2grGQHsqtkD+l/o2/FXABTJdtSerw0KbUaXJbzE1dGbeCUUzGLyJr
         IVrgzuYEEV87P/ZQcVhtxFc8hRVxX24Ve7cIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301470; x=1739906270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cogTEm5evil3F9jQBcrljmrK/eqtcGmBsYJZWjGFA8g=;
        b=o8QLusFwGlw3u9EmI0msh3sUvUAucRCEtUByAK/LG50UbL5b6TsTQf7vxyerVhUk7E
         rKM7hyrMVeNLORYMJ89D56ExQLrrEA+2kHtNcPuIkJp1Xrks9iNBSztG36IVUUKo4Wr9
         eq+uajxoCE82Kmo5TMJ2lZGafo2Toin8sNge1IJhLGv0vk0d2ja7c4SriWCY0d9jbxhg
         o/V4iIae7vD0+cA/aa4wKD/K8Ex8tVcesze8fhtVP87pN4vh4eDCzBzhNEzM0LW7mxhw
         iGeJIwYghWDaSdaPHGWW9BqlT+qKHvcjEVdMS68v2EebXyR9Tbkrq/I3gHF1G94vEsK0
         mYIA==
X-Gm-Message-State: AOJu0YxliN6a0F72JNr8l3qRv/lruyA66m72yrA7oGYoc3dL03FES8we
	mWbwGA0mG38Ro+z5X2EDzt6Zh/zXgLsmMfHW78WmNRMu7PHHcGv82Xv/3wQuid08Bx6u8VHK3l9
	t
X-Gm-Gg: ASbGncujELUkjcxSgMOFJyRh6AZtEZeCx8U8yvnUUAnOPhM3T0bM48v6S42/voTE8FC
	f21D242k5BvDNKg/aUf5iBKVlenuAjLJzjklQrjjXyIavAr835rXWGfzmRu40utWK0SAmWVeO+w
	DKlsNOchsaCIGkWcSCqXo3OrktVdE0d+JUpm1Y76JTu6ullLwumZeYtCCiVw2R8jK4fdEgusJdR
	xTyM4Tb80EvPQT03+81BqUBKrBssDT4OfhUgSXMfYfRU4YCfsgPK6oTf7P8yxDzQRy7ROS5HCHV
	2soOHlk+N+0vMqFvBIbzjabqOkYWforivMOFc9Ra3KCifWCd3rDPqp0WMmN+MK2ywqg=
X-Google-Smtp-Source: AGHT+IHo4eN58ajgrZ2ithjrBMev2z1vy0D1xUDx5D2Ad6rTsaEpX144CH6F/vCfTjFAWwXrIdb5yw==
X-Received: by 2002:a05:620a:1a29:b0:7c0:6e8e:2c9a with SMTP id af79cd13be357-7c06fccdda5mr75407685a.41.1739301468825;
        Tue, 11 Feb 2025 11:17:48 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05e374867sm318561085a.111.2025.02.11.11.17.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:17:47 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 07/10] rust: Upgrade 1.80.1->1.81.0
Date: Tue, 11 Feb 2025 14:17:20 -0500
Message-ID: <2c51da6c41614ae1132f1e9e5803fbf97905ab76.1739300779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739300779.git.scott.murray@konsulko.com>
References: <cover.1739300779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 19:17:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1074

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

https://blog.rust-lang.org/2024/09/05/Rust-1.81.0.html

Drop the following backported patches which is addressed
with rust v1.81.0 upgrade.

0001-cargo-do-not-write-host-information-into-compilation.patch
https://github.com/rust-lang/cargo/commit/2db0bab16139d094f689587b73539aae3=
86a1919

hardcodepaths.patch
https://github.com/rust-lang/rust/commit/28503d69ac204ff208d115aea30dc09d6f=
ca8728

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 conf/layer.conf                               |  2 +-
 .../rust/{cargo_1.80.1.bb =3D> cargo_1.81.0.bb} |  0
 ...te-host-information-into-compilation.patch | 51 ------------
 .../rust/files/hardcodepaths.patch            | 46 -----------
 ...epro-issue-fix-with-cc-crate-hashmap.patch | 53 ++++++++++++-
 .../rust/files/zlib-off64_t.patch             | 14 ++--
 ...ibstd-rs_1.80.1.bb =3D> libstd-rs_1.81.0.bb} |  0
 ....80.1.bb =3D> rust-cross-canadian_1.81.0.bb} |  0
 ...ust-llvm_1.80.1.bb =3D> rust-llvm_1.81.0.bb} |  0
 recipes-devtools/rust/rust-snapshot.inc       | 78 +++++++++----------
 recipes-devtools/rust/rust-source.inc         |  4 +-
 .../rust/{rust_1.80.1.bb =3D> rust_1.81.0.bb}   |  0
 12 files changed, 99 insertions(+), 149 deletions(-)
 rename recipes-devtools/rust/{cargo_1.80.1.bb =3D> cargo_1.81.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-cargo-do-not-write-hos=
t-information-into-compilation.patch
 delete mode 100644 recipes-devtools/rust/files/hardcodepaths.patch
 rename recipes-devtools/rust/{libstd-rs_1.80.1.bb =3D> libstd-rs_1.81.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.80.1.bb =3D> rust-cros=
s-canadian_1.81.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.80.1.bb =3D> rust-llvm_1.81.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust_1.80.1.bb =3D> rust_1.81.0.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index f5bf5d5..2d3f5bd 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -13,7 +13,7 @@ LAYERSERIES_COMPAT_lts-rust-mixin =3D "kirkstone"
=20
 LAYERDEPENDS_lts-rust-mixin =3D "core"
=20
-RUSTVERSION ?=3D "1.80%"
+RUSTVERSION ?=3D "1.81%"
=20
 # This is not ideal, but it seems better to mask out the older oe-core
 # recipes completely since they will not work with this layer on top,
diff --git a/recipes-devtools/rust/cargo_1.80.1.bb b/recipes-devtools/rust/=
cargo_1.81.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.80.1.bb
rename to recipes-devtools/rust/cargo_1.81.0.bb
diff --git a/recipes-devtools/rust/files/0001-cargo-do-not-write-host-infor=
mation-into-compilation.patch b/recipes-devtools/rust/files/0001-cargo-do-n=
ot-write-host-information-into-compilation.patch
deleted file mode 100644
index 7579ea0..0000000
--- a/recipes-devtools/rust/files/0001-cargo-do-not-write-host-information-=
into-compilation.patch
+++ /dev/null
@@ -1,51 +0,0 @@
-From 065d7c263091118437465d714d8a29dbb6296921 Mon Sep 17 00:00:00 2001
-From: Alexander Kanavin <alex@linutronix.de>
-Date: Mon, 13 May 2024 14:57:54 +0200
-Subject: [PATCH] cargo: do not write host information into compilation unit
- hashes
-
-This breaks reproducibility in cross-builds where the cross-target
-can be the same, but build hosts are different, as seen with
-"rustc --version -v":
-...
-host: x86_64-unknown-linux-gnu
-
-vs.
-
-host: aarch64-unknown-linux-gnu
-
-This can possibly be improved by only hashing host info if the build
-is a native one (e.g. there's no --target option passed to cargo
-invocation) but I'm not sure how.
-
-Upstream-Status: Inappropriate [reported at https://github.com/rust-lang/c=
argo/issues/13922]
-Signed-off-by: Alexander Kanavin <alex@linutronix.de>
----
- .../src/cargo/core/compiler/context/compilation_files.rs      | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
-
-diff --git a/src/tools/cargo/src/cargo/core/compiler/build_runner/compilat=
ion_files.rs b/src/tools/cargo/src/cargo/core/compiler/build_runner/compila=
tion_files.rs
-index d83dbf10c..b2ad8d9f3 100644
---- a/src/tools/cargo/src/cargo/core/compiler/build_runner/compilation_fil=
es.rs
-+++ b/src/tools/cargo/src/cargo/core/compiler/build_runner/compilation_fil=
es.rs
-@@ -652,7 +652,7 @@ fn hash_rustc_version(bcx: &BuildContext<'_, '_>, hash=
er: &mut StableHasher) {
-     if vers.pre.is_empty() || bcx.gctx.cli_unstable().separate_nightlies {
-         // For stable, keep the artifacts separate. This helps if someone=
 is
-         // testing multiple versions, to avoid recompiles.
--        bcx.rustc().verbose_version.hash(hasher);
-+        //bcx.rustc().verbose_version.hash(hasher);
-         return;
-     }
-     // On "nightly"/"beta"/"dev"/etc, keep each "channel" separate. Don't=
 hash
-@@ -665,7 +665,7 @@ fn hash_rustc_version(bcx: &BuildContext<'_, '_>, hash=
er: &mut StableHasher) {
-     // Keep "host" since some people switch hosts to implicitly change
-     // targets, (like gnu vs musl or gnu vs msvc). In the future, we may =
want
-     // to consider hashing `unit.kind.short_name()` instead.
--    bcx.rustc().host.hash(hasher);
-+    //bcx.rustc().host.hash(hasher);
-     // None of the other lines are important. Currently they are:
-     // binary: rustc  <-- or "rustdoc"
-     // commit-hash: 38114ff16e7856f98b2b4be7ab4cd29b38bed59a
---=20
-2.39.2
-
diff --git a/recipes-devtools/rust/files/hardcodepaths.patch b/recipes-devt=
ools/rust/files/hardcodepaths.patch
deleted file mode 100644
index 6966542..0000000
--- a/recipes-devtools/rust/files/hardcodepaths.patch
+++ /dev/null
@@ -1,46 +0,0 @@
-When building for the target, some build paths end up embedded in the bina=
ries.
-These changes remove that. Further investigation is needed to work out the=
 way
-to resolve these issues properly upstream.
-
-Upstream-Status: Inappropriate [patches need rework]
-Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
-Signed-off-by: Alex Kiernan <alex.kiernan@gmail.com>
-
-diff --git a/compiler/rustc_codegen_llvm/src/context.rs b/compiler/rustc_c=
odegen_llvm/src/context.rs
-index b4b2ab1e1f8a..8bb3e3f0557c 100644
---- a/compiler/rustc_codegen_llvm/src/context.rs
-+++ b/compiler/rustc_codegen_llvm/src/context.rs
-@@ -34,7 +34,6 @@
- use smallvec::SmallVec;
-
- use libc::c_uint;
--use std::borrow::Borrow;
- use std::cell::{Cell, RefCell};
- use std::ffi::CStr;
- use std::str;
-@@ -155,25 +154,6 @@
-         }
-     }
-=20
--    // Ensure the data-layout values hardcoded remain the defaults.
--    {
--        let tm =3D crate::back::write::create_informational_target_machin=
e(tcx.sess);
--        llvm::LLVMRustSetDataLayoutFromTargetMachine(llmod, &tm);
--
--        let llvm_data_layout =3D llvm::LLVMGetDataLayoutStr(llmod);
--        let llvm_data_layout =3D str::from_utf8(CStr::from_ptr(llvm_data_=
layout).to_bytes())
--            .expect("got a non-UTF8 data-layout from LLVM");
--
--        if target_data_layout !=3D llvm_data_layout {
--            tcx.dcx().emit_err(crate::errors::MismatchedDataLayout {
--                rustc_target: sess.opts.target_triple.to_string().as_str(=
),
--                rustc_layout: target_data_layout.as_str(),
--                llvm_target: sess.target.llvm_target.borrow(),
--                llvm_layout: llvm_data_layout,
--            });
--        }
--    }
--
-     let data_layout =3D SmallCStr::new(&target_data_layout);
-     llvm::LLVMSetDataLayout(llmod, data_layout.as_ptr());
-
diff --git a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hash=
map.patch b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashm=
ap.patch
index e3f57e7..e052c32 100644
--- a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
+++ b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
@@ -1,4 +1,4 @@
-rust: reproducibility issue fix with v1.80
+rust: reproducibility issue fix with v1.81
=20
 A few crates are using the updated version of the 'cc' crate and this is c=
ausing the generated object file names containing a unique hashmap id.
 By the following changes same hash values will be genarted even for diffre=
nt build paths.
@@ -49,6 +49,57 @@ Signed-off-by: Harish Sadineni <Harish.Sadineni@windrive=
r.com>
          let obj =3D dst
              .join(format!("{:016x}-{}", hasher.finish(), basename))
              .with_extension("o");
+diff --git a/vendor/cc-1.0.99/src/command_helpers.rs b/vendor/cc-1.0.99/sr=
c/command_helpers.rs
+index fe919a5239..2b1f442019 100644
+--- a/vendor/cc-1.0.99/src/command_helpers.rs
++++ b/vendor/cc-1.0.99/src/command_helpers.rs
+@@ -257,6 +257,7 @@ fn wait_on_child(
+ /// and store them in the output Object.
+ pub(crate) fn objects_from_files(files: &[Arc<Path>], dst: &Path) -> Resu=
lt<Vec<Object>, Error> {
+     let mut objects =3D Vec::with_capacity(files.len());
++    let target_substring =3D ["rustc"];
+     for file in files {
+         let basename =3D file
+             .file_name()
+@@ -277,10 +278,29 @@ pub(crate) fn objects_from_files(files: &[Arc<Path>]=
, dst: &Path) -> Result<Vec<
+             })?
+             .to_string_lossy();
+
++        // Function to find the position of the first occurrence of the t=
arget substring
++        fn find_target_position(s: &str, targets: &[&str]) -> Option<usiz=
e> {
++            let mut pos =3D None;
++            for target in targets {
++                if let Some(index) =3D s.rfind(target) {
++                    //If a target is found and pos is None, set it
++                        if pos.is_none() || index < pos.unwrap() {
++                            pos =3D Some(index);
++                        }
++                }
++            }
++            pos
++        }
++
++        let filtered_dirname =3D if let Some(pos) =3D find_target_positio=
n(&dirname, &target_substring) {
++            dirname[pos..].to_string()  //Keep everything from the target=
 substring onwards
++        }  else {
++            dirname.to_string()  //If target substring is not found, keep=
 the original dirname
++        };
+         // Hash the dirname. This should prevent conflicts if we have mul=
tiple
+         // object files with the same filename in different subfolders.
+         let mut hasher =3D hash_map::DefaultHasher::new();
+-        hasher.write(dirname.to_string().as_bytes());
++        hasher.write(filtered_dirname.as_bytes());
+         let obj =3D dst
+             .join(format!("{:016x}-{}", hasher.finish(), basename))
+             .with_extension("o");
+diff --git a/vendor/cc-1.0.99/.cargo-checksum.json b/vendor/cc-1.0.99/.car=
go-checksum.json
+index b070eeb322..ba768ff86f 100644
+--- a/vendor/cc-1.0.99/.cargo-checksum.json
++++ b/vendor/cc-1.0.99/.cargo-checksum.json
+@@ -1 +1 @@
+-{"files":{"Cargo.toml":"3c555dbe1a698f12b66c8a5748ed52ff26ff7b8ebb12237c1=
a72a1cbe4b9392e","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d059=
d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7b2ba9=
6f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25dac0a759=
8e678e9b601a7d99a791069bddaf180dfe","src/command_helpers.rs":"15afbc35930a5=
a53f00d74a8910cff35caeb5511c26642cffe5630377aced901","src/detect_compiler_f=
amily.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd08abf392f5a29"=
,"src/lib.rs":"92440d3adb5cb6ea05596d9ca860a205d3937dbf0fc959e524bac5f2b748=
c1af","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fee042c16bd65d4=
150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"352a0295c965c68=
4904329d334f3b9889db3a9c3f201701f8db44e4d00e00515","src/parallel/mod.rs":"b=
d9c1334d17d138c281961c690b8d8118a2d6295a7d6cd7296826255436fa063","src/paral=
lel/stderr.rs":"a2d18ba3f2e04deb9047ece9ab7ca5452d9a76b515afbe20a76307e3159=
7f34b","src/target_info.rs":"342be00f6215e161d8163e272a2945bb9f52f171648e15=
e11d46800a73186955","src/tempfile.rs":"47a58e904ac07da6682004b5b615dc83250b=
253a8d3e8ba1b9bcaf6cdf4fd142","src/tool.rs":"e13c439a96d8311ba8d37b9d5522cd=
6997d94261cbb95517c82df70525acaa7f","src/windows/com.rs":"a2800ddb81215fff2=
bf618336f5c4ff8e8bdb746dd18b795873c7304b3f2a5e3","src/windows/find_tools.rs=
":"4c350cddbce1557682b7f40cd917cc4f131ad89ff2e34c23d629014ed8d7203e","src/w=
indows/mod.rs":"42f1ad7fee35a17686b003e6aa520d3d1940d47d2f531d626e9ae0c48ba=
49005","src/windows/registry.rs":"c521b72c825e8095843e73482ffa810ed066ad8bb=
9f86e6db0c5c143c171aba1","src/windows/setup_config.rs":"754439cbab492afd44c=
9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/windows/vs_instances.rs=
":"76e3cee74b5fd38ddaf533bba11fe401667c50dda5f9d064099840893eaa7587","src/w=
indows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cfce253dbf2a678b076147c6cd=
b5db046c","src/windows/windows_sys.rs":"5a440eb39d8a0c176b66177e87531867977=
93bc5d7896292c408fb44c12dfed3"},"package":"96c51067fd44124faa7f870b4b1c9693=
79ad32b2ba805aa959430ceaa384f695"}
+\ No newline at end of file
++{"files":{"Cargo.toml":"3c555dbe1a698f12b66c8a5748ed52ff26ff7b8ebb12237c1=
a72a1cbe4b9392e","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d059=
d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7b2ba9=
6f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25dac0a759=
8e678e9b601a7d99a791069bddaf180dfe","src/command_helpers.rs":"4c4a9ea55a109=
dbeada9e23d4ec963c257a56451b5fd16c7e4e8b97374f1a2ff","src/detect_compiler_f=
amily.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd08abf392f5a29"=
,"src/lib.rs":"92440d3adb5cb6ea05596d9ca860a205d3937dbf0fc959e524bac5f2b748=
c1af","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fee042c16bd65d4=
150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"352a0295c965c68=
4904329d334f3b9889db3a9c3f201701f8db44e4d00e00515","src/parallel/mod.rs":"b=
d9c1334d17d138c281961c690b8d8118a2d6295a7d6cd7296826255436fa063","src/paral=
lel/stderr.rs":"a2d18ba3f2e04deb9047ece9ab7ca5452d9a76b515afbe20a76307e3159=
7f34b","src/target_info.rs":"342be00f6215e161d8163e272a2945bb9f52f171648e15=
e11d46800a73186955","src/tempfile.rs":"47a58e904ac07da6682004b5b615dc83250b=
253a8d3e8ba1b9bcaf6cdf4fd142","src/tool.rs":"e13c439a96d8311ba8d37b9d5522cd=
6997d94261cbb95517c82df70525acaa7f","src/windows/com.rs":"a2800ddb81215fff2=
bf618336f5c4ff8e8bdb746dd18b795873c7304b3f2a5e3","src/windows/find_tools.rs=
":"4c350cddbce1557682b7f40cd917cc4f131ad89ff2e34c23d629014ed8d7203e","src/w=
indows/mod.rs":"42f1ad7fee35a17686b003e6aa520d3d1940d47d2f531d626e9ae0c48ba=
49005","src/windows/registry.rs":"c521b72c825e8095843e73482ffa810ed066ad8bb=
9f86e6db0c5c143c171aba1","src/windows/setup_config.rs":"754439cbab492afd44c=
9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/windows/vs_instances.rs=
":"76e3cee74b5fd38ddaf533bba11fe401667c50dda5f9d064099840893eaa7587","src/w=
indows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cfce253dbf2a678b076147c6cd=
b5db046c","src/windows/windows_sys.rs":"5a440eb39d8a0c176b66177e87531867977=
93bc5d7896292c408fb44c12dfed3"},"package":"96c51067fd44124faa7f870b4b1c9693=
79ad32b2ba805aa959430ceaa384f695"}
 --- a/vendor/cc-1.0.97/.cargo-checksum.json
 +++ b/vendor/cc-1.0.97/.cargo-checksum.json
 @@ -1 +1 @@
diff --git a/recipes-devtools/rust/files/zlib-off64_t.patch b/recipes-devto=
ols/rust/files/zlib-off64_t.patch
index 030c6c2..6fbca66 100644
--- a/recipes-devtools/rust/files/zlib-off64_t.patch
+++ b/recipes-devtools/rust/files/zlib-off64_t.patch
@@ -5,10 +5,9 @@ it needs 64 bit off_t
=20
 Upstream-Status: Submitted [https://github.com/madler/zlib/pull/764]
 Signed-off-by: Khem Raj <raj.khem@gmail.com>
-Index: rustc-1.79.0-src/vendor/libz-sys-1.1.16/src/zlib/gzguts.h
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- rustc-1.79.0-src.orig/vendor/libz-sys-1.1.16/src/zlib/gzguts.h
-+++ rustc-1.79.0-src/vendor/libz-sys-1.1.16/src/zlib/gzguts.h
+diff --git a/vendor/libz-sys-1.1.16/src/zlib/gzguts.h b/vendor/libz-sys-1.=
1.16/src/zlib/gzguts.h
+--- a/vendor/libz-sys-1.1.16/src/zlib/gzguts.h
++++ b/vendor/libz-sys-1.1.16/src/zlib/gzguts.h
 @@ -3,13 +3,6 @@
   * For conditions of distribution and use, see copyright notice in zlib.h
   */
@@ -23,10 +22,9 @@ Index: rustc-1.79.0-src/vendor/libz-sys-1.1.16/src/zlib/=
gzguts.h
=20=20
  #ifdef HAVE_HIDDEN
  #  define ZLIB_INTERNAL __attribute__((visibility ("hidden")))
-Index: rustc-1.79.0-src/vendor/libz-sys-1.1.16/.cargo-checksum.json
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- rustc-1.79.0-src.orig/vendor/libz-sys-1.1.16/.cargo-checksum.json
-+++ rustc-1.79.0-src/vendor/libz-sys-1.1.16/.cargo-checksum.json
+diff --git a/vendor/libz-sys-1.1.16/.cargo-checksum.json b/vendor/libz-sys=
-1.1.16/.cargo-checksum.json
+--- a/vendor/libz-sys-1.1.16/.cargo-checksum.json
++++ b/vendor/libz-sys-1.1.16/.cargo-checksum.json
 @@ -1 +1 @@
 -{"files":{"Cargo.toml":"b4ed89b98aea5ea05fa475a9ba6f824dc6e759ea7a4c358e7=
fcecc7423e44777","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d059=
d3249e0bc93b36de45f759f2","LICENSE-MIT":"34c467b6945a22696d060b8fdd2379d464=
acb3408d4c599d3dc5fe4fa1b4c84f","README-zng.md":"438ab65416835d72c7dd168338=
af3db6f1a3d8ccee455af4e1d75438a781eb71","README.md":"62fa314f90fdc5430c6446=
ddb212b782ad69721cd5363983820261a41b53890e","build.rs":"b139f25e59a8cc78a9f=
ff8bdc25b34f6ba926ddf410bac65bfb7f279f1a92d76","build_zng.rs":"059da8bf3ed5=
f2bfa613874b8f6720643ae948a811fefaff8237e95e0771cbc3","src/lib.rs":"8f9f42e=
8c80e134fa6f5724c677a341689e2e16cbe93a15495a1b4d8bfa90c49","src/smoke.c":"1=
0607c81b73811bfcb9718767312bf97ba2ccf7048ea2f18a2085aa06ad7f91b","src/zlib-=
ng/CMakeLists.txt":"6b7d83767c0fe0b98e2d5321a2c35339e04bf314f6bf650f4716a74=
34a3e164c","src/zlib-ng/FAQ.zlib":"c524f4f86d336b3de71dd6977afddffa9c02fda5=
c26db4dfefae44959e7614a2","src/zlib-ng/INDEX.md":"989545e90d8e9ac149034f762=
ce78ed8976ebf9324326228dea37ca190154609","src/zlib-ng/LICENSE.md":"d3c80be0=
55d94d798eaa786116e84fa0b010bc11420b5d2060d978ea77845436","src/zlib-ng/Make=
file.in":"3c46b870035b795f4e9c365a1688392377dbfef90cbb814294d4d33d3ead1f4e"=
,"src/zlib-ng/PORTING.md":"097591000d86f6265fea6cfcd22635984eb6c9f54e8690ca=
2667cfb92a11919d","src/zlib-ng/README.md":"5e1032d7f44647ce88475872a4fff9bd=
1671e3bedf8bdca43925dd8fde97c8b3","src/zlib-ng/adler32.c":"b96656d1fc0133c4=
4caeb3509d545d0b68580e77157b8c6f0fd6dcf681726ea5","src/zlib-ng/adler32_fold=
.c":"66b32963c96e43c84b53eff737d11186bf165e04a48e9c3328faa5c86ce8128c","src=
/zlib-ng/adler32_fold.h":"c40114c2c742b6410e54b58ea02533fe6e9ae0ca62d3453e5=
d2a1725d33e2be4","src/zlib-ng/adler32_p.h":"fa8b96371128c54ed9c2a0617500673=
8d395d380672b4894c32fece37b8a96a0","src/zlib-ng/arch/arm/Makefile.in":"67e9=
06298f31bf83feeb526c9d09a65c1d39517423ded8f50cfc369f05a1d629","src/zlib-ng/=
arch/arm/acle_intrins.h":"313646b741417269d175b2620c7bd2cf1cb5bfc940c5bb3dd=
600189fce27cd79","src/zlib-ng/arch/arm/adler32_neon.c":"bce2fe7d3a5f663ba28=
94d3c9b13151c5cd4c16bcc1d31ac32a85713ecc20f8c","src/zlib-ng/arch/arm/arm_fe=
atures.c":"dc2fa2e5593f0ff1f837138b99f26d1f805f82f69d2721cc2b2a386b5dac7b1a=
","src/zlib-ng/arch/arm/arm_features.h":"0667e8baaba1edfa60ec6faa5ce35eb35f=
5e91c85633e831f397a9af3c220b9e","src/zlib-ng/arch/arm/chunkset_neon.c":"042=
d3e6f865b5b0bfec8b5196288cce2ec47e9ca2c8a5e075580dd302238e421","src/zlib-ng=
/arch/arm/compare256_neon.c":"7eec4ca0415dec895a461a4d1fcd3068e0d68482d0482=
57022511b3490372ca3","src/zlib-ng/arch/arm/crc32_acle.c":"3fa85db742ee584f3=
787e3d131d92d6196e44f9df5f3034d804abc78cbf81d3f","src/zlib-ng/arch/arm/inse=
rt_string_acle.c":"5ca256a6f796d8bff478671ae5b0d7cfe236b58abffd6a99bb2cac09=
7fe7935b","src/zlib-ng/arch/arm/neon_intrins.h":"22262195cbd668a11953449c9e=
1be3b9b3374469d21f3e73ab34c6ea0dcf275f","src/zlib-ng/arch/arm/slide_hash_ar=
mv6.c":"9abacab94d74e7d8b1d863f20aa97fb5380059f08b91480a14377d3ed2d1f768","=
src/zlib-ng/arch/arm/slide_hash_neon.c":"7c4927c0dc8b28c5fba1efb30273653e71=
172ce051a0341ce2f1d2c0bbfa418c","src/zlib-ng/arch/generic/Makefile.in":"932=
55a212569673a3ce9e7fbaba789b3cd82375e7f6459c22c84bcb7a12097c7","src/zlib-ng=
/arch/generic/chunk_permute_table.h":"3f1e09e697a9b2dff4395aca356e61765c445=
11a9dc653abb6998671afd20ae6","src/zlib-ng/arch/power/Makefile.in":"015cb563=
5da6dbcd54c6bcef5d8958c6ea5369b55797e342a2632b0bf03bc4ab","src/zlib-ng/arch=
/power/adler32_power8.c":"e5a5bfdd9963e8f906e36978f1a655139908740559da2b382=
ddd5f3e2ffe6f56","src/zlib-ng/arch/power/adler32_vmx.c":"841a7e3792d1f68a09=
25969d6f9737cfb2b650b3a82721a88f1e5648f7b0a58a","src/zlib-ng/arch/power/chu=
nkset_power8.c":"569a7dc686a0d80686e516ec8fb7c2331225f706b37ccbf0874e6d822e=
82f806","src/zlib-ng/arch/power/compare256_power9.c":"cfdc33f5e605fd4135142=
3fda0eaf7692f9e9f0083d6c4ac870c6e467d534f48","src/zlib-ng/arch/power/crc32_=
constants.h":"d73e3b9025de9fade7fa3ba2bbf5f56a1499a84c53d8ca7f5e744a0714d85=
99b","src/zlib-ng/arch/power/crc32_power8.c":"add20ee86ff5c28396ee2e7f77d82=
5d7e425b89467331953690c40f40b5dba41","src/zlib-ng/arch/power/fallback_built=
ins.h":"78a8da60bad8ba01278e495482108adabf9e96bdb214e869b61ab1f63f518c9b","=
src/zlib-ng/arch/power/power_features.c":"4dc4c14dfa2d3333c73fad7b1f7a79d3f=
ff68c1d1fd643012faf82bd4114553e","src/zlib-ng/arch/power/power_features.h":=
"c9c47cfcfff347e79f83f56a0677565d40299e03ffbeb918c4ae69518d290ada","src/zli=
b-ng/arch/power/slide_hash_power8.c":"58d93cee1a2cf14f13a8e9e31ba5149fe2b1e=
069846f52ac1f11c42cfcbd49a4","src/zlib-ng/arch/power/slide_hash_vmx.c":"1b6=
297a9616456ba534bc1d93afcb99e36dac357be68aed106bb71dfea621a86","src/zlib-ng=
/arch/power/slide_ppc_tpl.h":"c8900c594591e1aba3188f97c374e5561fe1e96f653c6=
68352b25647e449f4c0","src/zlib-ng/arch/riscv/README.md":"7a3e00ab7fe5a66cf5=
cfe5671e9e8367e6c655a3b72d12de18d840538c506ef0","src/zlib-ng/arch/riscv/adl=
er32_rvv.c":"e2472cf46b376a0ed8b7545a3192d195659353e093772216f0d28ae7d75afb=
1a","src/zlib-ng/arch/riscv/chunkset_rvv.c":"d5b0fd27dcc8d4b3773caae1629001=
4fdbc0011cf62e7f63a4e5d897149b165e","src/zlib-ng/arch/riscv/compare256_rvv.=
c":"4ed8d6b39ef2218c1d474ab586fc19d7e0821445241e5ccd6a75992cb17b3bb7","src/=
zlib-ng/arch/riscv/riscv_features.c":"a117eada0164dd92c06e9804a70fd2f434b8d=
14a6d443f0b3513330fe08c18a3","src/zlib-ng/arch/riscv/riscv_features.h":"269=
53a09f72edb0e66978044d75e054e40d36d2b62244359b5e5e4ab936d2c9c","src/zlib-ng=
/arch/riscv/slide_hash_rvv.c":"87c1a2acf51af38f2d337b482fcb72d080b0897e48ab=
c9753b51d40facd9a1a1","src/zlib-ng/arch/s390/Makefile.in":"8cb582f8e6ccd914=
6f64214a513e546122976c60e782cede19b282bf3b519235","src/zlib-ng/arch/s390/RE=
ADME.md":"0dae0e510935c5f91e00dfe0d57a9b7a82891ff59edbd14b64b54c950327d708"=
,"src/zlib-ng/arch/s390/crc32-vx.c":"c5250cb1df20eadcf0c56ba68e0dd7cf43d936=
f92f245aad2bfb519988f902a1","src/zlib-ng/arch/s390/dfltcc_common.c":"9a701d=
5f973c07e054797ed030851171abaf20a40a4ab2359914c737b0ab9671","src/zlib-ng/ar=
ch/s390/dfltcc_common.h":"1d042b79da6bbcf4e1f5b32ca017bc49fa89129c7a925ea17=
b931de34012ef18","src/zlib-ng/arch/s390/dfltcc_deflate.c":"146569d921d68fd9=
af7b67a74bcf0aa41108a4072564629db7ad6c2dc8a429ef","src/zlib-ng/arch/s390/df=
ltcc_deflate.h":"309d7c9bc4e5de3196ebe61a2e5c17e07bfb66bb8a170562e90e9105e6=
8ab302","src/zlib-ng/arch/s390/dfltcc_detail.h":"6ba837c1522d85df599d5baeb5=
e0076d67355979a9768da9b6a095d65e645d41","src/zlib-ng/arch/s390/dfltcc_infla=
te.c":"b1eb56def7acf39aabb7abea8249a48c4af0dfea7a63ac380e5437d432ff9d9e","s=
rc/zlib-ng/arch/s390/dfltcc_inflate.h":"06dc026f991022a7be73865a554785b31d1=
67261c4006ca6438de7ca31893ceb","src/zlib-ng/arch/s390/s390_features.c":"fd9=
9ba0abc73a37168a5c369a0714e3f35816a792438bcb1e8e60f5dd2983293","src/zlib-ng=
/arch/s390/s390_features.h":"f65396333635e937634dff42a43a8bfa272f53ac88e763=
d52d4c56241b1eaab9","src/zlib-ng/arch/s390/self-hosted-builder/actions-runn=
er.Dockerfile":"5d4c45e9929fd9736640aea294f1d13f346fd52a4f4771073be32abe96a=
da971","src/zlib-ng/arch/s390/self-hosted-builder/actions-runner.service":"=
62a19075adeddb3bee57bbac81c7acadacbf9c288e2b497e36ff7f2b3daa7558","src/zlib=
-ng/arch/s390/self-hosted-builder/fs/usr/bin/actions-runner":"f647e18728ea1=
5fe927ac9f8cba83a5b343654a0e91b5ebe653bae7af7375110","src/zlib-ng/arch/s390=
/self-hosted-builder/fs/usr/bin/entrypoint":"add4ebdc4f06ed15bb1de12a8c9ceb=
370a60baebb0932a1026a75433940ad3df","src/zlib-ng/arch/s390/self-hosted-buil=
der/qemu-user-static.service":"54551049f6181da88700a2a944a72b0af3b8abde876f=
a28e1348deb5eb96c91b","src/zlib-ng/arch/x86/Makefile.in":"ad6e71fe6e42005b6=
5db8454b0ea0a6c9ee91664698c08729c01e6b00d0df933","src/zlib-ng/arch/x86/adle=
r32_avx2.c":"cc0598333eff9110b5e8c0dc38ba543bfdd3ca5a66825f440909ba7a8923fd=
d3","src/zlib-ng/arch/x86/adler32_avx2_p.h":"45e6264edffc737081f55a5b5e85b2=
8d9db0b27b63183ffbb492f8c11bc670a2","src/zlib-ng/arch/x86/adler32_avx512.c"=
:"7a949d8ad2d15709d33872ee97e70a2e0cc2c6c375d7064cbc02b87e70905d1e","src/zl=
ib-ng/arch/x86/adler32_avx512_p.h":"1b4beda11693ac03e4b20e054a765df427f845a=
279bce547b8208d20f5a302bb","src/zlib-ng/arch/x86/adler32_avx512_vnni.c":"9d=
11d2049df211f11a48a91e340e20686763c1eac20463dcd27dd7bfaa159f76","src/zlib-n=
g/arch/x86/adler32_sse42.c":"1d2dc53b05ac75667c6d1c625c8c391e4851b28cff9e97=
ebfdb774767581fff2","src/zlib-ng/arch/x86/adler32_ssse3.c":"7666f99b2e53026=
5cb9848c1047ccc150da0add19b41aa2d7756c617377622c6","src/zlib-ng/arch/x86/ad=
ler32_ssse3_p.h":"5aab2f802ba6bdebc63b411018e5116fe26d38e90adf353646b65af4e=
be7fa40","src/zlib-ng/arch/x86/chunkset_avx2.c":"ac300f37fbc99ab2d3bf47a640=
bdf2d87ad8358ef081eea21c541966830281b3","src/zlib-ng/arch/x86/chunkset_sse2=
.c":"a400a128a84185c945f9ac9303e17c944f2008085d7a4402d279bd59893dc89a","src=
/zlib-ng/arch/x86/chunkset_ssse3.c":"1f69ef9ae20cca1e4fc6924462255b89696853=
87c10694ef1dda28b3098d6f6d","src/zlib-ng/arch/x86/compare256_avx2.c":"2516d=
00faa6939e61dbb0978a9c4c81f9e3a42fd053b2a2241673da7cf4fc781","src/zlib-ng/a=
rch/x86/compare256_sse2.c":"3b983708034f33b5da49f6f5041351a2e66358c76645c55=
2f6e4dc37fb890a80","src/zlib-ng/arch/x86/crc32_fold_pclmulqdq_tpl.h":"1b3b7=
9dabff0bf7ecc3b07356c5aeb6ae1fece0fd70ac7e235aacce3da77ea19","src/zlib-ng/a=
rch/x86/crc32_fold_vpclmulqdq_tpl.h":"7eddba31e3d1b1808fc6df9f96ada03c59952=
961af895d8538f5a8292392b5cc","src/zlib-ng/arch/x86/crc32_pclmulqdq.c":"f247=
408c353bbd0fcafff23fb97aeb4d9a72e0a416effea566183b9b5dbedf7c","src/zlib-ng/=
arch/x86/crc32_pclmulqdq_tpl.h":"5fedffe4b853cabfef09cfcebb501cd53a97c212e4=
70bdfc65c28dc998840e05","src/zlib-ng/arch/x86/crc32_vpclmulqdq.c":"870d06ca=
9fa7b48db4b720d2fd6262094200cf6180fa76a601d17c722bf0e406","src/zlib-ng/arch=
/x86/insert_string_sse42.c":"28a6d418a9563d464414c3880d6053c656aab40c6ebe21=
947cf17687d82e547a","src/zlib-ng/arch/x86/slide_hash_avx2.c":"9740a36bb4dd9=
0f40394344026be9a13f3acb6e85e6b7681c30fd7f7cbf8e28e","src/zlib-ng/arch/x86/=
slide_hash_sse2.c":"fa009305a1c82708638dff25e037067656350303b25f5774489417e=
096c30ecb","src/zlib-ng/arch/x86/x86_features.c":"b755befa09a56ed27d70f2be9=
3b0a72a355fe8b490827b55fce60ab51693c70d","src/zlib-ng/arch/x86/x86_features=
.h":"6429fa7345a9892633c884f7fc26f9558d86c77df9e8589ba9623a27e1d9fd57","src=
/zlib-ng/arch/x86/x86_intrins.h":"707b836360628cb34a0fb7fa675b5e8674d146f55=
b1f60fd739b85aa5dc935cf","src/zlib-ng/chunkset.c":"531f58c77c184b225304888d=
df1930a76beefbe4a7974edf0efeee7b6662520e","src/zlib-ng/chunkset_tpl.h":"991=
9e10e9c2244316e13de41b66dc333d9b0413af6265fa860768eefa39ce033","src/zlib-ng=
/cmake/detect-arch.c":"1af38707fadc192c8e4a28715c896148a0909be821fb443919e1=
91ff2374ffdb","src/zlib-ng/cmake/detect-arch.cmake":"85a2eed469fc7765e51c38=
2f475868a644036f057f5b749d3ef59eec2b4b2748","src/zlib-ng/cmake/detect-cover=
age.cmake":"4664d51152d51282ae50621f4d510ab72cf8978b266c614b7c5361750db6d1a=
9","src/zlib-ng/cmake/detect-install-dirs.cmake":"4c8e72cee23ce9c6db02566a3=
1fc7a78f0beeac6f09c61c2d90a1cff3c083db1","src/zlib-ng/cmake/detect-intrinsi=
cs.cmake":"cfad619b863adf57132434f7b9c36c4f1a0466e5fdb11ac673e703ed5e471cd0=
","src/zlib-ng/cmake/detect-sanitizer.cmake":"a40650743dfd0b56c2afbfadb53e5=
d1470ef48852f2fcdf51084b6485534f87a","src/zlib-ng/cmake/fallback-macros.cma=
ke":"a8c8f70e5483177280cbebf99f929a7cf5ffe2b79fedb79eed570ecafc78effc","src=
/zlib-ng/cmake/toolchain-aarch64.cmake":"46be0bf580a49a528c72005484655afad1=
de3705b39a66a7b0c213b0fa81cee6","src/zlib-ng/cmake/toolchain-arm.cmake":"05=
e38076fd6ffb9785ff9844ccecd26436c9dc4c25b7777b62e5f52e788c3882","src/zlib-n=
g/cmake/toolchain-armhf.cmake":"1a2029163a57415eec9a5dd5f45d3254d349e97b1be=
b5d16876b741717673341","src/zlib-ng/cmake/toolchain-llvm-mingw-aarch64.cmak=
e":"4deffb541ecd21ade019daa2e96e832ead8c2c62b633bedb8688d0e7c7012d33","src/=
zlib-ng/cmake/toolchain-llvm-mingw-armv7.cmake":"3e95adbade93ec162478de3339=
427ed88b12c922f4975c2918977859325f5459","src/zlib-ng/cmake/toolchain-llvm-m=
ingw-i686.cmake":"1064a1ff2bab21489c184c1cc2b07181ebbbcc32e45c13cf8ed6b9ec6=
0560c2e","src/zlib-ng/cmake/toolchain-llvm-mingw-x86_64.cmake":"577d333ad70=
cf27ededc75554428368e84c334cc7b716e18113620f5e7edf305","src/zlib-ng/cmake/t=
oolchain-mingw-i686.cmake":"df9000354b820d3713d1469edc9f94cd095389b0cca8396=
5730b8e64857fdf3f","src/zlib-ng/cmake/toolchain-mingw-x86_64.cmake":"ee316e=
6e3202919da5d497f9e246466fd715fcf079cb5b4afc4774089d1fefad","src/zlib-ng/cm=
ake/toolchain-mips.cmake":"0d0d00b809a30021bb4b9e3ace7371200bb4bfa6509813c8=
29ca0cb569c7af68","src/zlib-ng/cmake/toolchain-mips64.cmake":"f19574aa068ca=
4374b657ce7bd0517b9297c622144814a095e26db05f0a1cd20","src/zlib-ng/cmake/too=
lchain-powerpc.cmake":"9bd6fc58ce5b70603657f2c195c4a5cf52fae96ad63ac7879788=
31c5858f762c","src/zlib-ng/cmake/toolchain-powerpc64-clang.cmake":"aab0b9e0=
f19a281dc99f4dfa5675976c40b5fb7f8139dd2eb0901fdf3cedc952","src/zlib-ng/cmak=
e/toolchain-powerpc64-power9.cmake":"57c789c468e733971c2654faf34f7dfc9dd1e0=
e5bcabbd609dcd01dcbd25c487","src/zlib-ng/cmake/toolchain-powerpc64.cmake":"=
917fc5eef84921d8b38f43c2b4f60870965b4eecc8f018c7b3499e1142c715af","src/zlib=
-ng/cmake/toolchain-powerpc64le-clang.cmake":"47ac4a05b61210a83c7845a5522b9=
1740bc8a7bb897312cc37131f85bae9e1b5","src/zlib-ng/cmake/toolchain-powerpc64=
le-power9.cmake":"b295b61ea248d8ef98d9276fad3db143a6fb80ab738c54bf88cb594d8=
2c70a8d","src/zlib-ng/cmake/toolchain-powerpc64le.cmake":"5b2edd36d62de513d=
b2d32bfbf779979d81ac527b981cc3379a4e933fc5a94d1","src/zlib-ng/cmake/toolcha=
in-riscv.cmake":"d7b4ac4be3651aec2e55788d815141482d4fe92713713fdaba9215dbbb=
c9b88a","src/zlib-ng/cmake/toolchain-s390x.cmake":"cf52cecea7bd2a9d1ff5fd8e=
dcb03c531e3b404bbcd15a15dec2e0e19936f2ac","src/zlib-ng/cmake/toolchain-spar=
c64.cmake":"e543062485d06a7e0fec8135887c5e73363517fa4babc23ef7b780916d75afd=
a","src/zlib-ng/compare256.c":"4890f97239f63dfbbc986ddd05039798752ec0ad530f=
f7d25978deb44f774ad5","src/zlib-ng/compare256_rle.h":"30fca191b0474e1549d3c=
e292bb11ee90dc3dc9fc685932cec3971c1d0e8f652","src/zlib-ng/compress.c":"f7c6=
9a4d2f3b87ff0094115977dde1cd17703cc9856ba19489dd94e0ed16b646","src/zlib-ng/=
configure":"5778b60178bd2cf770fc01c5ce2562e50c1859a0cc67f8b522deb38ae4dbab7=
7","src/zlib-ng/cpu_features.c":"aec359d85d64c2ff88132a123406726bd966e0d56d=
0dc8ce1d5c3f25e1801440","src/zlib-ng/cpu_features.h":"21c43d2a8375e73abea63=
082e08d9279eaf457970d34f877830bb31575498a8d","src/zlib-ng/crc32_braid.c":"8=
a33cffb026b82a027b45e041935836b36b2d075796e5498e33ce64ec0cf93e8","src/zlib-=
ng/crc32_braid_comb.c":"217741d3c1c0018bb12ab22c987804634605f5b7ad6bd243e25=
eb0499c80af5d","src/zlib-ng/crc32_braid_comb_p.h":"6c8035e05d30a6241be55467=
fc59e4d7deda6b618b955a11339ffee08a39c75a","src/zlib-ng/crc32_braid_p.h":"95=
1cbd948664498dd8a56393bc88debdad8b21dcc8e1f16d883c07170e4adb4e","src/zlib-n=
g/crc32_braid_tbl.h":"e22af112e3c1c8bb4065d39fe678eba71dd08893eb06f9414b02f=
4cf5a6f46de","src/zlib-ng/crc32_fold.c":"f6363abbd1e167bc7a6fa8f92e5211f4fa=
3e70d30fa5e10fa6f416f5db372678","src/zlib-ng/crc32_fold.h":"42412c502905757=
9148a2238b0bc882f294f661d2af102bd9213531894302f29","src/zlib-ng/deflate.c":=
"70c72cdbf88987660e787a99658641bce36fff4848f9bf395f3727df9543664b","src/zli=
b-ng/deflate.h":"f45a609710150fb758ca89b36a7f5a029b525fe70f0e3296a4847d7387=
2db2ca","src/zlib-ng/deflate_fast.c":"52648097b16070c156c27d38566720eca08d4=
8e35cd89a80f196f0e77951112a","src/zlib-ng/deflate_huff.c":"923d316676c00f30=
7a7d6a58d77f9364f06607afcc686b464b557ff5478f8b6d","src/zlib-ng/deflate_medi=
um.c":"d3172c1ea0ae1bc2e3b7691b005bbae35e84b7588ef2f5805b9dd0c4ccecbd67","s=
rc/zlib-ng/deflate_p.h":"2eaac98e9232959c730d84a408bed641be817dc3468aeb4270=
62d06b02eb80b4","src/zlib-ng/deflate_quick.c":"3825eb4d22a150f9cdaba93db890=
d95b8d9e9d0f3f10524fb27a9a1289aa4c0f","src/zlib-ng/deflate_rle.c":"5dcc0496=
f74b5ce677ab5a58ea232d0ba653102d2f71cf35daa6069ef88b7af6","src/zlib-ng/defl=
ate_slow.c":"5449816c381138eb07cd54ec7c0c77fb811f4f274c27bf15d26e008de6a9eb=
5c","src/zlib-ng/deflate_stored.c":"89b81c09be2ffd84138940ac6c4e9688f956603=
b45eec6d0d52d579cac3f15e5","src/zlib-ng/doc/algorithm.txt":"0d21a0a4c47e512=
743389628d1385a831a5e5ff716491095a382b923287f4223","src/zlib-ng/doc/crc-doc=
.1.0.pdf":"064f9252d6e2e15ea56c2bd18e160e5c9c84bcd137c11a7af497aaa511ace998=
","src/zlib-ng/doc/crc-pclmulqdq.pdf":"3cf18f738dd0da7e5a28ff999d987bb61ac4=
2cce354bbee1364d06fb3944f7fc","src/zlib-ng/doc/rfc1950.txt":"8f0475a5c98465=
7bf26277f73df9456c9b97f175084f0c1748f1eb1f0b9b10b9","src/zlib-ng/doc/rfc195=
1.txt":"5ebf4b5b7fe1c3a0c0ab9aa3ac8c0f3853a7dc484905e76e03b0b0f301350009","=
src/zlib-ng/doc/rfc1952.txt":"f7c810fd9d719d002d605207a9b880600f71d039b9626=
c5b4b03f2122438dd2d","src/zlib-ng/doc/txtvsbin.txt":"47c273bb22c9773248d380=
549a330e5c262266b1292154b0d3014f731cc73f47","src/zlib-ng/fallback_builtins.=
h":"c02e559d19f351f2f9371ee2042ca6a725d14f17862dff2414fd2ab3d7984875","src/=
zlib-ng/functable.c":"d7ac98c7def281c707796a4317e2dd6754d654bc8d833ae67a77f=
47a7c1dd5bd","src/zlib-ng/functable.h":"64fbabaa8459898d14cb88078676c42fce1=
2a951b4b1d83f9085e104ad407a47","src/zlib-ng/gzguts.h":"d9a4e984bb6c2ebe5c85=
8b37b1c6411af1edc21c3c15d63b6588016b71369b71","src/zlib-ng/gzlib.c":"91011b=
dfaa99bb5e49aece64fdee995207b1ce5a96227990f16f9aea55026c8e","src/zlib-ng/gz=
read.c.in":"3501e5124923207b2603d9695c3bad1815ca2dc8f18b6525bdd5dfea60313ac=
d","src/zlib-ng/gzwrite.c":"9f474aeefaf0150d8871eb9202ebd43a28f18bdf39eaca4=
f35cfb52227e74c63","src/zlib-ng/infback.c":"db99c5b105c34c7c2967bd97e16f976=
217530c22d6545e61cbf657522e24de87","src/zlib-ng/inffast_tpl.h":"51622f34e88=
08798a43412b4fde62ebd58ba012f5452bf2ad9a8001c98539166","src/zlib-ng/inffixe=
d_tbl.h":"a94225335396245e9f0ccb2e9b4b334fe7ee0111ed8e32a26bcd52187f364314"=
,"src/zlib-ng/inflate.c":"2c1bd0f4939c372e49a9ee0ec8a8cdee369d9c6c10124b4e1=
1cd197f44ce3a36","src/zlib-ng/inflate.h":"1750ab33be4461f2e6b8e43bef5da11f3=
db49d5d2a3eacd03d881d33c1df7def","src/zlib-ng/inflate_p.h":"4a31088faf818d2=
615de31b099e8f55ee8463166477d6cb5d6763c913b6acef9","src/zlib-ng/inftrees.c"=
:"206fa4c762203823151dcd3b1a5b389fb40efd4c88aeb2bc302aa1d5cfd6d6d5","src/zl=
ib-ng/inftrees.h":"2ba1beb76d7922fcb37708809e31f62ee366827da80faf09a7e461b4=
39afd291","src/zlib-ng/insert_string.c":"7a9455cbb3ca8fe6e7111471b9f4c0a32f=
b49a6d0ec589b027dc2cb2b65c8dce","src/zlib-ng/insert_string_roll.c":"4d05f19=
591a5c29d2da398e10e9d0b050d738cc8838d8dda4beb1cc7281ede07","src/zlib-ng/ins=
ert_string_tpl.h":"972e69808ce5e74d0c54af4ee447b996b2d0563eb861b90856693037=
ce8cca9f","src/zlib-ng/match_tpl.h":"1e20d0ef73a5826606240f4efd2a8e993d203f=
376017397342b9899b1f919276","src/zlib-ng/slide_hash.c":"74adb34a4a35331db81=
0dbb5d740af10cc1db7d24a89ea387aa2dec956a05b2b","src/zlib-ng/test/CMakeLists=
.txt":"d9c0e5c87fef7b26826f8acc84fb34df0c90cf8804818f93fc12edf91d92d744","s=
rc/zlib-ng/test/CVE-2002-0059/test.gz":"60bf96b8f433bd7e057ce3496aceaccd70e=
c80f596a4aa8bcc7786056705ce66","src/zlib-ng/test/CVE-2004-0797/test.gz":"38=
caae524705f676bde13a8df9fc8c7d2fe105ba6bdbab62a405b0276fd3aa2e","src/zlib-n=
g/test/CVE-2005-1849/test.gz":"e4d5a60617df4b5dd44eda94751ce1eacdb325792bba=
6e3cc4676719a3adf742","src/zlib-ng/test/CVE-2005-2096/test.gz":"8f702d4861a=
a3ec98ac03a59ff26b430939630cb5cd4266d2658d3b836d576f9","src/zlib-ng/test/CV=
E-2018-25032/default.txt":"d7f8278db331c47bd1208bf41e7903cbddee4f7b47c666c4=
0afdd3c96237752e","src/zlib-ng/test/CVE-2018-25032/fixed.txt":"3b27a98edd2f=
3f580033f9add11d3469d7808c969a1128ee00c18ac7a12cef57","src/zlib-ng/test/GH-=
1600/packobj.gz":"372ba8e7aa3bf258e85c793abe1268965765a9f1bc6e2a0e77d3b723a=
4a019a3","src/zlib-ng/test/GH-361/test.txt":"358497d0a7251ea42101dc77b02337=
f46fd89af09643a8288e2a3082e5d24128","src/zlib-ng/test/GH-364/test.bin":"af5=
570f5a1810b7af78caf4bc70a660f0df51e42baf91d4de5b2328de0e83dfc","src/zlib-ng=
/test/GH-382/defneg3.dat":"b22bef6b7392401c9e7b079402c4a4074053d7a914d05040=
0e37fd7af6fe26d5","src/zlib-ng/test/GH-751/test.txt":"b83d833803b7bc3124fb2=
a0034081f0b999ad10c33a8dfa3bfd181dc078ae3ee","src/zlib-ng/test/GH-979/pigz-=
2.6.tar.gz":"2eed7b0d7449d1d70903f2a62cd6005d262eb3a8c9e98687bc8cbb5809db2a=
7d","src/zlib-ng/test/Makefile.in":"2eed5e763754e1f0f0ee1908e2f8080a2fa9e5f=
2770b3fc8d74b9975b4cd2bb5","src/zlib-ng/test/README.md":"6a34f8fc7a0144958c=
c9a0cded46fc38a7e15aba3dfa5bf56d8d86c3fb72d82c","src/zlib-ng/test/abi/ignor=
e":"36e1928ffa34c21c1d2fd783633c9975e1ff282682ba2eca14b61b87650a2e13","src/=
zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-aarch64-unkn=
own-linux-gnu.abi":"e55ef93145cb4ceb2e22562ab5c18a2e26f8330862ed9468df7ada6=
6a47dfe08","src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c128=
1fc-arm-unknown-linux-gnueabi.abi":"d45ec6ff3f41ce11713a39aaad08e4ed9d21a16=
5754a1c5a5e5f123c4daf8241","src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b5=
0e93806c2a18c1281fc-arm-unknown-linux-gnueabihf.abi":"2cef33db7275ba069bfa3=
a929299dcb8f1529f3d0ad344c1e0ef483905e996c7","src/zlib-ng/test/abi/zlib-04f=
42ceca40f73e2978b50e93806c2a18c1281fc-mips-unknown-linux-gnu.abi":"25cf82ce=
8d5afde37456ce22943358e6d5f4dec31c1d1f732a1b07f34d7003f0","src/zlib-ng/test=
/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-mips64-unknown-linux-gnu=
abi64.abi":"59e435fa42a1aacd30d24d184d1ae505392123a8f16eaa0ca55e061ff2c427c=
b","src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-powe=
rpc-unknown-linux-gnu.abi":"5b4c5724c018d4e5820cfd9f94526ae41101fbcfa960ca9=
8efcc06ed33a5b7ed","src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c=
2a18c1281fc-powerpc64-unknown-linux-gnu.abi":"e4d05062bbbace98c02f297585ac6=
9a88e6b4f34122de6a854e5176d6d81ef9d","src/zlib-ng/test/abi/zlib-04f42ceca40=
f73e2978b50e93806c2a18c1281fc-powerpc64le-unknown-linux-gnu.abi":"bc41acbb1=
e207e8dfbf0f4bd628a0d32b94e288d324f924dc353898c3ae3bd37","src/zlib-ng/test/=
abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-x86_64-pc-linux-gnu-m32.a=
bi":"5b79e86fc4f99e7d5c38b08e63ee347f29ed5312ac7dac16459b3d4562c04a50","src=
/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-x86_64-pc-l=
inux-gnu.abi":"568cdd3893cd364fcdfdb1536f394dda4d237a03a0a7fe80938763b73739=
092c","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf8088231=
1-aarch64-unknown-linux-gnu.abi":"af41851f1b97ccb94e534cf3e54985fda0700c94d=
8fa850ec021f4b7d907f480","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc=
983c155e4baf80882311-arm-unknown-linux-gnueabi.abi":"b2197b5aa7145c62c39775=
e7e97ce8de4d00b44f4f2ecded47aec8e725cf4563","src/zlib-ng/test/abi/zlib-ng-e=
4614ebcb9b3e5b108dc983c155e4baf80882311-arm-unknown-linux-gnueabihf.abi":"a=
037a1494a5f724462b6fb34d595b7d1517cdd60af1d890d00fa557394c0d923","src/zlib-=
ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-mips-unknown-l=
inux-gnu.abi":"8cf1dd6da2c8fadb53748687e7cae304cef025f490cd8a9d1970bdff04f1=
3ddd","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf8088231=
1-mips64-unknown-linux-gnuabi64.abi":"38549f6d4efc5a4e60e83dfee03f727b426ed=
969b6e476acf11ab1d5f562eb1d","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b1=
08dc983c155e4baf80882311-powerpc-unknown-linux-gnu.abi":"09e7feffa1d24cf68c=
fd7d0c1a5a80a5d9d5df5bbda383b2a7d5f99f194a06fc","src/zlib-ng/test/abi/zlib-=
ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-powerpc64-unknown-linux-gnu.abi=
":"cb360745c650e62db182932ed37e7648d1fe939caa50eccf7f9068e653ce9a11","src/z=
lib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-powerpc64l=
e-unknown-linux-gnu.abi":"75170876a3b207c383889bac021ae0ff710e2915ad8c6b5f0=
2c38d6e3ef731cd","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e=
4baf80882311-x86_64-pc-linux-gnu-m32.abi":"023ad5584f431bd2985d7231581058c2=
49dcc0544b21fbb678ab04417c5e8103","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b=
3e5b108dc983c155e4baf80882311-x86_64-pc-linux-gnu.abi":"f072336d8a54a31ae4e=
991ecd2e0482b3c8102e0256da5f020112aeb5a9d68d4","src/zlib-ng/test/abicheck.m=
d":"d960023cd80e04b2d4dcec8cdd3315c7292229d45a3301a5dc5213058ba22185","src/=
zlib-ng/test/abicheck.sh":"293af1e5c1e18133d1f27c9e34bdeb0f8b0123cf3c825562=
a11a31e87d2b544e","src/zlib-ng/test/add-subdirectory-project/CMakeLists.txt=
":"0d5d9bcb4aac1e17b5146eb727ca95e4fb91fb098fe567925befd7a88f8cf677","src/z=
lib-ng/test/add-subdirectory-project/main.c":"0f84f056ddc067fa1374bea36c45c=
516b5ce1b4a78e8a381c06cce03320e66dc","src/zlib-ng/test/benchmarks/CMakeList=
s.txt":"3a9207269ce3ceb3b9351c8b68681cb316be79a686ac99becd27df7f0bc69601","=
src/zlib-ng/test/benchmarks/README.md":"f44de30583886085f4a3158040c795284ce=
f19e32c50a80fff54608ab735e5aa","src/zlib-ng/test/benchmarks/benchmark_adler=
32.cc":"d2de7d69b94aa6447804e3d42ed7c889b2d6a5e1d4c9f595a8eff2f919f1716e","=
src/zlib-ng/test/benchmarks/benchmark_adler32_copy.cc":"7c5617b6d014b4f1e0c=
116439fb4a6e0e720b4fcd132c68b8f1f49ea8aa06af9","src/zlib-ng/test/benchmarks=
/benchmark_compare256.cc":"2ffcc22f1fd7df9db92c9d97302e46f83811f5cadf353273=
87ff22f27d09ee22","src/zlib-ng/test/benchmarks/benchmark_compare256_rle.cc"=
:"3631acf6fc6bca5a4028cf58dd25347bbe448e19bd9cae1d4456ae30dfeccf74","src/zl=
ib-ng/test/benchmarks/benchmark_crc32.cc":"cc1c6119ff9bd112999d0cd6ae62b1ab=
d95268d8671cc9ee5abb7f6659496a74","src/zlib-ng/test/benchmarks/benchmark_ma=
in.cc":"67270b2efb97c24af9358220cd642cf0c8ed393d07f61abca31bc0c103b1bab7","=
src/zlib-ng/test/benchmarks/benchmark_png_decode.cc":"e9485de5e722ef1b62131=
a27a98d2cfe668ee8becbd5fc9938972022e07c8d60","src/zlib-ng/test/benchmarks/b=
enchmark_png_encode.cc":"4b2203af2ef58f95773ca6d82569f747f2cfb3c4116334871c=
fb255a0d7741e1","src/zlib-ng/test/benchmarks/benchmark_png_shared.h":"2a02e=
f2aa7b7b60afd5e474ca729498c8e6a7873e968634fd0c43d10d1506ca5","src/zlib-ng/t=
est/benchmarks/benchmark_slidehash.cc":"d239dfced67f85fb2dcea7a6a03b2649a59=
a63948e9e6af8c2bd3653d73f8130","src/zlib-ng/test/cmake/compress-and-verify.=
cmake":"0dd1712183a15dd79bd2501dfacef681a402493d23aa3439a9293c1ec5aca863","=
src/zlib-ng/test/cmake/run-and-compare.cmake":"13d85c12c9d6c7b1b148bd0c5a5b=
4faa6a4b56f3823bf03c4f8d914c9c5949d8","src/zlib-ng/test/cmake/run-and-redir=
ect.cmake":"7f08d18c09aa58113882ec760735a62a1723a5bfcae9f73bd3713a4dbaeab89=
8","src/zlib-ng/test/cmake/test-cves.cmake":"c526d10727275eda6a6e5912a000e5=
f2ee369f904f923001f196b69eae7cf5cb","src/zlib-ng/test/cmake/test-data.cmake=
":"4b4e003f000fe15dc57052faf5637a85c9c7f3a6d07592184b87ea508b6fc0dd","src/z=
lib-ng/test/cmake/test-issues.cmake":"258d8453dcea579d47abbedbe8e7d4f13d004=
8642ea3ab53880245998de4f22b","src/zlib-ng/test/cmake/test-tools.cmake":"d6c=
dc83cf1b5c6c342b461bed6c87d57c2b78bcac3f6b3e357bffba2181d49c8","src/zlib-ng=
/test/data/fireworks.jpg":"93b986ce7d7e361f0d3840f9d531b5f40fb6ca8c14d6d743=
64150e255f126512","src/zlib-ng/test/data/lcet10.txt":"1eb5d7bddb1c3cb68064d=
5b5f7f27814949674b6702564ff7025ced60795a6d9","src/zlib-ng/test/data/paper-1=
00k.pdf":"60f73a051b7ca35bfec44734b2eed7736cb5c0b7f728beb7b97ade6c5e44849b"=
,"src/zlib-ng/test/example.c":"5c2d07af5ecf874823ca73e6ff0d292c5d3c5370104d=
87526169b6f222182dcd","src/zlib-ng/test/fuzz/CMakeLists.txt":"395049b7625f1=
20abee1e118487c55a8bd3288d0974081ecaa8baf33f60e80c8","src/zlib-ng/test/fuzz=
/fuzzer_checksum.c":"68ed79ec1d7fefa548f4d32ab7885479442520cdf53ad59eadfae1=
3e4b15efe0","src/zlib-ng/test/fuzz/fuzzer_compress.c":"3f507a18710fb2a1d87f=
de5cf3affc74b53a689e9d2ce6f887ee64eb778e568b","src/zlib-ng/test/fuzz/fuzzer=
_example_dict.c":"46541ed3ef9bb7378120d47133f18b4194e955e7a84a439647205de68=
e745c08","src/zlib-ng/test/fuzz/fuzzer_example_flush.c":"393e7872825bb1ca36=
6d0d8552b94442511ed4a557db6ece16540b79b7e9cbdf","src/zlib-ng/test/fuzz/fuzz=
er_example_large.c":"e3b91b1ced83dfe538e8ae5262f1756181a7785e8c2ab38ac28814=
56bd562277","src/zlib-ng/test/fuzz/fuzzer_example_small.c":"de9f5dc31824057=
50341a0f44c37bd8ba4f21d993284456ba8e6ce3e36d6b9b3","src/zlib-ng/test/fuzz/f=
uzzer_minigzip.c":"dbc35b317935ba7cd2dfbacc067b5b17534488dc9ac1daa2bb28b67b=
1b850aa3","src/zlib-ng/test/fuzz/standalone_fuzz_target_runner.c":"e6170b74=
4faa68bf2a414e99fc87accf4db2a5e0eb58b17aded5c692ea493604","src/zlib-ng/test=
/gh1235.c":"057934cf585b9998478e3d77ecd0782d941e20ebe50688ef32b961559d6dfe2=
a","src/zlib-ng/test/infcover.c":"82ccdf5b2bb081b9da18c55c0078ff030ae145a49=
43dc90bb85c4cce00e9deb5","src/zlib-ng/test/minideflate.c":"1b2d38cdbcb8e2c3=
99b7dc9db59fe95b19f0c052a79dddf91fcc0733c898d389","src/zlib-ng/test/minigzi=
p.c":"154131d41a881ef3264abb9eb70f7cdc6782718a2164f4f16b63b4e5363ca313","sr=
c/zlib-ng/test/pigz/CMakeLists.txt":"e55880cb8b15839774f2387c07aaf42df680ce=
c0305522ddecbe5f638e5af2d9","src/zlib-ng/test/pkgcheck.sh":"61a6ebf6ef9fe05=
935467b29e25669fc44bb6240ea0ca87e9c066d982032f4b3","src/zlib-ng/test/switch=
levels.c":"1c726e63cbe24fc12c88e9928db5a1515c18364987dfe588daabef4f8b1a321f=
","src/zlib-ng/test/test_adler32.cc":"aeb9533ae9be0f76879100d038980f3731ff4=
c249b4de105f2df6f371a7990a5","src/zlib-ng/test/test_aligned_alloc.cc":"bebd=
d6dba3c7452e7d8557c47b14226209175fb5fe313b176cf752848117536e","src/zlib-ng/=
test/test_compare256.cc":"4362eccf7b473d82778fc4171552f8160b54b6fc6195bf930=
cd0e988dff5a093","src/zlib-ng/test/test_compare256_rle.cc":"8428d8204d0598c=
d1071f3db9176b42fd423e532051cd14fd91e5835a01ba203","src/zlib-ng/test/test_c=
ompress.cc":"32d3bb507a95d56d0441280a04569164d19a8241d85084a9fcf49f51afb82f=
cf","src/zlib-ng/test/test_compress_bound.cc":"21f71385edd73f92f40a9451673b=
db9ea3f82a49e7f4d4bdcc4b74b086320b12","src/zlib-ng/test/test_compress_dual.=
cc":"a76759d3d5c54315a4ee3197109a4517dfae9931eb65ae8cbaffd8a58bb562e9","src=
/zlib-ng/test/test_cpu_features.h":"28bbb2bdf56ee7988d4fdfccf4c6ad584bb8b39=
c4ae80fdab12effcc33c4d8ae","src/zlib-ng/test/test_crc32.cc":"57a428c33f3158=
f1b78840b779dfb46f55a943fb5e7d2c23541b9ca7090d7264","src/zlib-ng/test/test_=
cve-2003-0107.cc":"629f1fe659558c9deb767b3fbbb615539b0458f8b67a405ece924cac=
6bebb531","src/zlib-ng/test/test_deflate_bound.cc":"eecbc494f22282bfd94a254=
5fc142b8fdb5582991c22b6e50fd46c40885ad81e","src/zlib-ng/test/test_deflate_c=
oncurrency.cc":"27a91c74cf9811921bc2424c235e540a18ed63853d37e29814a60ed21f1=
a8654","src/zlib-ng/test/test_deflate_copy.cc":"1a286ba7772bb1a6d06233b075a=
83f3f1814bab2fd7d3757c090f5db25db90f1","src/zlib-ng/test/test_deflate_dict.=
cc":"3395afdc925059faa1b334bf8a497803132f9ca7703d48dff0ab0264f5292f73","src=
/zlib-ng/test/test_deflate_hash_head_0.cc":"2d0b7bb7dcd00a630358e6c3cd79676=
a838efc262794b751b42d030d949e7587","src/zlib-ng/test/test_deflate_header.cc=
":"643763a811a3673a05959eb6dfeffa3ff25dc3672f67dc8a9f1406a31812068f","src/z=
lib-ng/test/test_deflate_params.cc":"7c747362cac9f74b2bb8e8d276539807e8222b=
18db172b81ccbaf96235b8be61","src/zlib-ng/test/test_deflate_pending.cc":"1a0=
e700d3a2863b6087041fef379bd683e882d5932840fbecb3e0b91e74565cf","src/zlib-ng=
/test/test_deflate_prime.cc":"d98d4aee8c240f5bc3b3b83f828917586b846850ed82a=
de6f5f728a4281a1321","src/zlib-ng/test/test_deflate_quick_bi_valid.cc":"970=
6d0bf9d844b21f1655498bf0f9901c7dfc272cdef37f2d1af238c71df611c","src/zlib-ng=
/test/test_deflate_quick_block_open.cc":"7edb512a287542f83ee448fbcafc3d654b=
62a36440b6474e9cae3bb5d36577ab","src/zlib-ng/test/test_deflate_tune.cc":"da=
d52ad7941aca761ff177877a0d60f1b68b3a6d28a8f4bd382005f3c04bad64","src/zlib-n=
g/test/test_dict.cc":"2bb6c32ec0ea76561172e0b5e8c6a7bf4f64efc2b41534b42ec1d=
6c3d0990897","src/zlib-ng/test/test_gzio.cc":"337f711eb6e80e77fd28963c89a64=
6f6528d635036cd0367c398387e0a72cfde","src/zlib-ng/test/test_inflate_adler32=
.cc":"0967f8e72388a8232bcc1436196214ea1a13dd0fbd5e7633e24a9246abc2a950","sr=
c/zlib-ng/test/test_inflate_sync.cc":"fbb1121ea5b5448723c6d6d8692110c7362e6=
833fae22afcd46909d4ecb1289b","src/zlib-ng/test/test_large_buffers.cc":"0c76=
a002071e6280d6e6b380db5e1ada00730b0534722ba5c208cb1e51de0b7b","src/zlib-ng/=
test/test_main.cc":"884dcbfb7207f541ef82bc9fe6f657fbe1918b0917fa3e5eda124ad=
042ce732e","src/zlib-ng/test/test_raw.cc":"0ac0c7c63777d4278a36e087b2060a36=
9be16150d40a6963d3a0d60a7efb1740","src/zlib-ng/test/test_shared.h":"cc6a7f3=
dd115edd5de50da2da266e615464e2d5ae41d102e117b09215889a2c4","src/zlib-ng/tes=
t/test_shared_ng.h":"4570992f5ba61d2cf9e502d3aac163945d5d2f65883ce29f3a0797=
052c779b91","src/zlib-ng/test/test_small_buffers.cc":"680ba24dc58c7dd05e8da=
b2e430a8e0c99b946cbc341a5fb39c4b4b921b6fb33","src/zlib-ng/test/test_small_w=
indow.cc":"0f784eae1977ee62d56f6280b269aa9edc42a5f3d20502c39abcb6cf126ec5ea=
","src/zlib-ng/test/test_version.cc":"8599eca8dd63a96962a5c8ac01a3172d203f9=
065e228867928ed4bce61cf6009","src/zlib-ng/tools/config.sub":"32186cfeb5db62=
c99e1dfbfb07f24c1a50977447b4c26d2907021c74422a70d2","src/zlib-ng/tools/make=
crct.c":"73acdb94f73dfea474927a9e1be33e0f2cb015d97831bc2718106141adbc1d05",=
"src/zlib-ng/tools/makefixed.c":"bffd02540231304f9bcc755b8cb9ae5cfbc4897585=
7bbb4547f1d6acce21ef57","src/zlib-ng/tools/maketrees.c":"48a3e4ee246b1fb061=
d8e643efbd4b80e45f9c3814e21170a5893a9f4ca9619b","src/zlib-ng/trees.c":"310f=
e64c50fb313773c2058c606b1a3cc085b8af7771eba325ad5c9355659100","src/zlib-ng/=
trees.h":"24174f3543b01ee1ef370bbf6d15551a21871cded18b2aadf09a71e7904b6f99"=
,"src/zlib-ng/trees_emit.h":"6c541dcf01eecf393d4eab7800bc558ad524114bb5a8de=
b86f13376fbef88754","src/zlib-ng/trees_tbl.h":"022736ff3362ef3591d1f8fc3b7f=
ede5927c0d25ab0813d7ef8cd95efd6ea242","src/zlib-ng/uncompr.c":"bb03a6ae65e1=
395f3cb2fba1dee63246a1fcd30683fd3348e320e789521055a6","src/zlib-ng/win32/Ma=
kefile.a64":"f1feaed8da22e6e1470689186db22946ccb67019a87edd34e9ed25b438b626=
db","src/zlib-ng/win32/Makefile.arm":"a952ff273854b6b025760ed6c841c450d298c=
da462dae3163f6d7288ad2cf55f","src/zlib-ng/win32/Makefile.msc":"f299f7987ec2=
66ac35d9383f4c7459da02094a10c877a4c471ee2df1ec44caf9","src/zlib-ng/win32/re=
place.vbs":"0ecd6d2f42f4f49d835acbf7b89a79cbdf17fed29d5931eeb3b40da6d313394=
6","src/zlib-ng/win32/zlib-ng.def.in":"0b75299a93ef3af54ab37f1282f254ccf2f6=
35fec9b2691edc3840d851bbc20a","src/zlib-ng/win32/zlib-ng1.rc":"91f28a6930d6=
a376a1057a73ea5613bc13717028c89fdd0b4c8015059295fcd2","src/zlib-ng/win32/zl=
ib.def.in":"ec69c79c2a5612a5c4dc9de08c930c9b251f2455e4bca8781f70c05f7170fb3=
a","src/zlib-ng/win32/zlib1.rc":"5644cee99821019a7d541d5587376236cb5b99e98d=
66c904a25f9b69d1d56062","src/zlib-ng/win32/zlibcompat.def.in":"c4dff5ac2cfe=
629155c7de5b0f139fb1c962fb01addbc032c3cf35110921eb27","src/zlib-ng/zbuild.h=
":"e6f34c26bd82dd7650a664d7b336d1e4c83b871bded79e05602e779ffa69993b","src/z=
lib-ng/zconf-ng.h.in":"83514b2e2858b0d6647159e9aa47fa84bb625ed2ac6117284f51=
4cacc42a993d","src/zlib-ng/zconf.h.in":"6768f84c439683b4a590338a9be40c3bd7a=
9702b25e8e546c705fac08674c3bc","src/zlib-ng/zendian.h":"5be3e2989524198f13b=
68cc083b1502747effe92325edee59e3c4ad93cc3c62f","src/zlib-ng/zlib-ng.h.in":"=
3bafbff2b78a88c1f0de4195a17b8fcd1fb12fcf2d40ffe1970415f6778bf9df","src/zlib=
-ng/zlib-ng.map":"111f656dfdf4da285621a909fecd0532be37f83b49f6e18f357fc8d2a=
22a726f","src/zlib-ng/zlib.h.in":"9f74dd9f3244ac1152639c5ad5dd1995914b7362a=
db1f3890698da377cf26c3f","src/zlib-ng/zlib.map":"f746610758741f042f8025502b=
4c0c04f9bcd48864004cc6e502b99d3754d78f","src/zlib-ng/zlib.pc.cmakein":"a974=
86fcab3f191d807ec04d4487d6a428053ab452b59687ee1f71cf52b02a31","src/zlib-ng/=
zlib.pc.in":"848e017a079b14853df8d19699f4edac2304767ef4eb2cf525a06ceb60d301=
b3","src/zlib-ng/zlib_name_mangling-ng.h.in":"a829fd869339579afe7ce8c1f8a54=
73598c608f3427c3cbbc1800088d6640e7a","src/zlib-ng/zlib_name_mangling.h.empt=
y":"38e51a846d6c2bd6100298c55328dba4437c08fa1dceda4eb2e06ecb1d142058","src/=
zlib-ng/zlib_name_mangling.h.in":"16e9ede4821d873647bf105b12e71245d3b7cb79e=
d318fed0a8ab5aa63b2b4da","src/zlib-ng/zutil.c":"fce8e83d2040be8bc389ec61a8d=
6c7b32c0b3cd208599c01c5a58ef6418de87b","src/zlib-ng/zutil.h":"618641510d899=
36fcbca382dc60aea97b5fe35aa010386df0a8ec3ed1b1602ea","src/zlib-ng/zutil_p.h=
":"6ca034b9d3f6a702b03a71a1f3fd61a0fe6bfb3442156cbdca090adea8eb3f2d","src/z=
lib/CMakeLists.txt":"ab5f3afca6fe38983dc30a28da4877706e3a690a564eda3d4929ff=
f39dab190e","src/zlib/ChangeLog":"f3bc368fd1722570d25411fece6b0e026ab95a9e2=
0ccf39c4395aa41a956a4f0","src/zlib/FAQ":"e18aaaae6d7d8acd15c1f439306ef55437=
2bc39db7e19258836708362a0b7cca","src/zlib/INDEX":"3b4e325d47ae66456d43fcf14=
3ba21ab67a02a4f81be7ef2da480ba30d774266","src/zlib/LICENSE":"845efc77857d48=
5d91fb3e0b884aaa929368c717ae8186b66fe1ed2495753243","src/zlib/Makefile":"ef=
23b08ce01239843f1ded3f373bfc432627a477d62f945cbf63b2ac03db118a","src/zlib/M=
akefile.in":"a6d202a2ac158f8fbd1fa7361e1f2c7adfd1b7b80c1f6515a4203925c2c0f2=
4a","src/zlib/README":"d106dcdb2a0b3087cb3a2380b9f00a0bbadc7eb835cd80408f94=
a2d78d69727d","src/zlib/adler32.c":"9cd1443a24ff2a3053961695bd432035c583473=
86a420d3388232376ebabe211","src/zlib/amiga/Makefile.pup":"a65cb3cd40b1b8ec7=
7e288974dd9dc53d91ed78bbe495e94ccc84ddd423edf1f","src/zlib/amiga/Makefile.s=
as":"0e63cf88b505a1a04327bb666af3a985c5e11835c0c00aed4058c0dcc315d60e","src=
/zlib/compress.c":"86f802c16a965e7a28737e3730b4e576c5ba40981753967e3e30916f=
4dc1b4b1","src/zlib/configure":"f7c0050f218691ee1cae28311144a703bfa3515df90=
3d537d6a5cb4bd3dcd8cd","src/zlib/contrib/README.contrib":"b925ae08d371b33c4=
b5ffd67c707150729a476caf47cfe2eafc002291f23f931","src/zlib/contrib/ada/buff=
er_demo.adb":"469cf566a6965767fee6b987a239ed8cedcc66614940d45a9b434331fbb43=
5ce","src/zlib/contrib/ada/mtest.adb":"41b6f31684770334afdc4375871eb1408542=
f37a823a073556fdbfdb63753160","src/zlib/contrib/ada/read.adb":"fa5b989aef0c=
5715a3fcb15de93985f7f10aeb0a7f5716745c95ed820eb9af9c","src/zlib/contrib/ada=
/readme.txt":"2cb6c99547bf527648342723a2183f503ef64182bc19a506976815725a207=
438","src/zlib/contrib/ada/test.adb":"ad2b2f61e0603044065887849e2cca394cfe3=
7d3ba08d3cd368f670462b9296e","src/zlib/contrib/ada/zlib-streams.adb":"f4598=
8e2bac76eb25a0dc981f46576e7432c35dde1790bbc2b650f0090b7fa72","src/zlib/cont=
rib/ada/zlib-streams.ads":"2dae2309e863a6ea44731773aabac5fd5f5436b6dcfcf53f=
d7e6389556ca8c3c","src/zlib/contrib/ada/zlib-thin.adb":"03d89244ee5ec9771d9=
b5050e586c609f851af551b2e64eb151f1d5be0b63ae9","src/zlib/contrib/ada/zlib-t=
hin.ads":"631ef170bde16c3ca8d412b54a0e519815b80197d208f8f393e6fe017bb0968e"=
,"src/zlib/contrib/ada/zlib.adb":"8168ac962cd775e1f3dc35dc95a038eb370034c9b=
1f8cb1511d4bcd6b297a1f5","src/zlib/contrib/ada/zlib.ads":"9340f4cfaeafca0ef=
ce7a649ef5e9b42a8bcafc5dbdc4abff41f9a19ee08c3cc","src/zlib/contrib/ada/zlib=
.gpr":"859bb69dce38dbe9dca06753cf7ae7bd16d48f4fece8b87582dab8e30681d3de","s=
rc/zlib/contrib/blast/Makefile":"17d5d26c24bf51cad51045a38ffb73cc3539d29e89=
885aa249fcfd45a8659d5c","src/zlib/contrib/blast/README":"baa763ae03d88ef7ec=
e6eb80d9a099b43d0b57639d6d281e1c7c6ca79d81daba","src/zlib/contrib/blast/bla=
st.c":"1ab3e479d342bfc144167b808fb00142264bc50f24a110ca88cc774e351c218e","s=
rc/zlib/contrib/blast/blast.h":"9c1c422b76311d4cb06863ffc056668b6240f3dd998=
bc02e89ee590d482bfdc2","src/zlib/contrib/blast/test.pk":"5f5c262c545574a5c2=
21132d5ef832478d222d70b015341795b3860204140d7c","src/zlib/contrib/blast/tes=
t.txt":"9679b2c98e1283222d0782b25a1c198dc64ba9ebd1addd6dc6f643a45947cda3","=
src/zlib/contrib/delphi/ZLib.pas":"0a3ea9e7e6644df99dda9c275f5a7be7cbaa96f8=
333f0467bd007141496dff17","src/zlib/contrib/delphi/ZLibConst.pas":"84bcc580=
bdf397e570f86f3f5a5b8c7bf537828f30b4b72648b81911f6bf5095","src/zlib/contrib=
/delphi/readme.txt":"f7420ed2de77d4b498eefbbe6402a1d17dc2d411735289c78a265c=
7f10fdaee5","src/zlib/contrib/delphi/zlibd32.mak":"850e91b6c9ea05de61a411cb=
da16fa0f10118cd88bb32c4b7226988776f8d511","src/zlib/contrib/dotzlib/DotZLib=
.build":"b96137097669644ecb9f42cdd3399d1fce9c512788374609303f7e50abf597f0",=
"src/zlib/contrib/dotzlib/DotZLib.chm":"20d0e3edd57f849143255a7f0df1cd59d41=
db464a72c0d5ab42846438a729579","src/zlib/contrib/dotzlib/DotZLib.sln":"a979=
198c5b8d144c1ac8f993bfb6f4085d135aa58ca9dcf63ebabf52b5c695f7","src/zlib/con=
trib/dotzlib/DotZLib/AssemblyInfo.cs":"314afcfb339ea95f5431047b7ab24631b11c=
3532c7ce5dc2094ed0cf80a7c16d","src/zlib/contrib/dotzlib/DotZLib/ChecksumImp=
l.cs":"871fc7b34a095dde13cf4505800d4edc9f40b033d5e840c597ad8ada599d26ed","s=
rc/zlib/contrib/dotzlib/DotZLib/CircularBuffer.cs":"be84c9736fe7bdc2bfae704=
66d8fff582504e928d5b5e110fd758090090c8cb7","src/zlib/contrib/dotzlib/DotZLi=
b/CodecBase.cs":"b373f1f0c08565bf362c41969881a2f25be449eb894a477659231d6d3b=
86c07a","src/zlib/contrib/dotzlib/DotZLib/Deflater.cs":"06ba6696a3c15c53ba5=
fd5a1c2bf50b51f217010228fc1e4c8495ee578f480de","src/zlib/contrib/dotzlib/Do=
tZLib/DotZLib.cs":"9837fe993fd631233cc5e53ff084d86754b97f05ec77c54b0764c270=
6f186134","src/zlib/contrib/dotzlib/DotZLib/DotZLib.csproj":"21606db31dfef6=
410dd438b73f1db68856eacabcce6c0f0411fc4f17e17001f3","src/zlib/contrib/dotzl=
ib/DotZLib/GZipStream.cs":"7c4e8bf7e0b51f04bd3f457bead842aee133388d18ec8e21=
0295899ad2327cbf","src/zlib/contrib/dotzlib/DotZLib/Inflater.cs":"9016ca738=
18f5b6a28791abc3af6da7c4d2773b6a3804f593f6d5737a62b99ad","src/zlib/contrib/=
dotzlib/DotZLib/UnitTests.cs":"3f22cb690bd38fa151a944afa5a1844499fe30df5b41=
0edfd769b7e2a41ddc94","src/zlib/contrib/dotzlib/LICENSE_1_0.txt":"36266a8fd=
073568394cb81cdb2b124f7fdae2c64c1a7ed09db34b4d22efa2951","src/zlib/contrib/=
dotzlib/readme.txt":"bdb18e0114d3b5683749cf08cedbdf6b502e5abd344418b858e339=
839561e66c","src/zlib/contrib/gcc_gvmat64/gvmat64.S":"22ff411b8b1d1b04aeaa8=
418b68245400267dc43c6f44104f6ccd37f0daee89f","src/zlib/contrib/infback9/REA=
DME":"890288f02bb3b1f9cc654b87a07fcea695f90f6b9bd672d25bf6be1da2ec1688","sr=
c/zlib/contrib/infback9/infback9.c":"c236f4e5ef216f5ebc66f95ccbf9d399a19ad3=
838444065308b8d859cb42dc74","src/zlib/contrib/infback9/infback9.h":"c89d926=
607c1afa1830c17f807de368d2f1afe2d1e7df426763f6d4bf5950379","src/zlib/contri=
b/infback9/inffix9.h":"84a2ba4727767c18af6505f0e81d9c814489c8b9ed330a25dad4=
33db72997e43","src/zlib/contrib/infback9/inflate9.h":"32a907676cc36e27d0fdc=
0d99adb83a0b23f20ab61896269216d40fecf08d349","src/zlib/contrib/infback9/inf=
tree9.c":"9e739f5735d3cd77ca1b0d46d2a43371acf2afd64c9c0889e737da369ccd92d0"=
,"src/zlib/contrib/infback9/inftree9.h":"4ecd9db884bf43e33fbd34273c81402902=
2477e1597676129f9c98e09d8cef56","src/zlib/contrib/iostream/test.cpp":"0f3c7=
7e013949eb9c91e6b690ea894e19d97944d6b0885b82806fc3ad99680cf","src/zlib/cont=
rib/iostream/zfstream.cpp":"8ebb9b3d521cc3392953f27658cf1f6dcb763216079f69a=
1518ec5ca0e42a63b","src/zlib/contrib/iostream/zfstream.h":"4369c35e66f63f52=
ca4a5e1759bf720507ccabb8f3f132e2f18e68686c812401","src/zlib/contrib/iostrea=
m2/zstream.h":"d0343e0c57ff58008b6f29643d289c72713aa2d653fe3dcd2e939fc77e7e=
20b6","src/zlib/contrib/iostream2/zstream_test.cpp":"f789df183cc58b78751985=
466380c656308490a9036eb48a7ef79704c3d3f229","src/zlib/contrib/iostream3/REA=
DME":"43ec48ecbd95a8c45db20b107fac73b740bb11595a4737329188f06b713972cc","sr=
c/zlib/contrib/iostream3/TODO":"af5ebc83fb88f69706c8af896733784753dead14768=
7e1c046f410c0997fd88b","src/zlib/contrib/iostream3/test.cc":"8e17fc48dfdbc6=
e268838b8b427491b5843b6d18bc97caa6924de9fad7abe3da","src/zlib/contrib/iostr=
eam3/zfstream.cc":"8cdd67ed0b13c192c11e5ea90e9d5782d6627eb303fbc4aa5ebda253=
1ec00ff8","src/zlib/contrib/iostream3/zfstream.h":"d89587b446f928351565d099=
decd006a06b7a420cb1ff8ee9bb82e4d8c7235dd","src/zlib/contrib/minizip/Makefil=
e":"b95eb8b05baef661a18ca90fa72f43e76f1bc987f9199197fe283e2860060e0a","src/=
zlib/contrib/minizip/Makefile.am":"2313a3480a2c3745fa7ce216829cd0367058907d=
3a0902e5832c66c84a2fdfc6","src/zlib/contrib/minizip/MiniZip64_Changes.txt":=
"c371d1672b1ec23c6fe0c600543e0c96374400b4d434447ff2596f21255079f1","src/zli=
b/contrib/minizip/MiniZip64_info.txt":"122719c32ef1763a5f6ba9c8cdefc1d78a76=
f7156b09e7b6f69b73f968e0dac3","src/zlib/contrib/minizip/configure.ac":"99a4=
8f7b786cf192a778aae2af30836b0d2aaaec6e84c3a89a2edcbe77b46e1a","src/zlib/con=
trib/minizip/crypt.h":"5c978923cff1e80f76baf437eed699d5b4ad1bf515008d669475=
d3dd0d89ef70","src/zlib/contrib/minizip/ioapi.c":"6dff11ded396f5e3147c632a6=
39423e80ced6705bf7bf75d21cda0c571fdf86b","src/zlib/contrib/minizip/ioapi.h"=
:"6d2f2c3520dfc3061ea9128a1afb843f5cfe8d7317adcefe3a45884bc06e06a1","src/zl=
ib/contrib/minizip/iowin32.c":"882383d1ee9df8c5f236411734b51e96f5e29c38496d=
4e531f2beb3d07f682ef","src/zlib/contrib/minizip/iowin32.h":"4feed64c3c5f5cf=
f2d8a0431233766b61d4e06a9f232482cb41272ed1ca487df","src/zlib/contrib/minizi=
p/make_vms.com":"65736d9c4888f2373d3db0a13864d150c5040453f5bc2a5c8784379a7e=
a67590","src/zlib/contrib/minizip/miniunz.c":"c60f2c68be981464ff02dfbe01da2=
a8e66692416bdda2144fc75df3420b4107f","src/zlib/contrib/minizip/miniunzip.1"=
:"66d8684392167091ef0fe01598d6a0daa26e7e448e2df6c3cb257487735b83f7","src/zl=
ib/contrib/minizip/minizip.1":"5404596e8e5587a52f563906119f32ceee30a6d97a96=
6afa5c7afbe4d373e210","src/zlib/contrib/minizip/minizip.c":"6d7d7daffc713ba=
15a9768143471902c5bfd661a19287172f3870bc9ed2d5665","src/zlib/contrib/minizi=
p/minizip.pc.in":"8b6670b42d8e5e519e1cc89db093efc07ba23cb1ddfedd3c93ff2df08=
c3ce8ac","src/zlib/contrib/minizip/mztools.c":"3d6027270a2b6ed5ca19a339d748=
8f682c69798e3977d2278d379b7f14f17b63","src/zlib/contrib/minizip/mztools.h":=
"6f82c52279e8f79165f4446be652e5741a49992ac58632470335aa34c564072a","src/zli=
b/contrib/minizip/unzip.c":"10881ab576f49fe0825a21f77e322ece6ee88d34ed66fb3=
a3ce7a22f4b6cd2d9","src/zlib/contrib/minizip/unzip.h":"2ff9df0b1da7499adc80=
6bc0ec098ef1c7b9d361a8fd5b08a98299a1a4e88399","src/zlib/contrib/minizip/zip=
.c":"213f853d71266ebe8d8335740cfe94b0731009d8fb3f7e6ae01a627398732ec8","src=
/zlib/contrib/minizip/zip.h":"99ad45c0b546b5fd0ee3d0819ff057840a892a3d6dbac=
c85b757a35a43047398","src/zlib/contrib/nuget/nuget.csproj":"a6cf81c9a9b8be6=
6fae032193ac6282a4ceae93c8a25a9245d7eaf477d532471","src/zlib/contrib/nuget/=
nuget.sln":"074a80c6c3898ea4f7935734d81fe81d3c15f5dae5b17806fa7a036b69ad5c3=
3","src/zlib/contrib/pascal/example.pas":"d842d456ecb6ff80e34cee2da31deb207=
2cc69ca837497bea8b8bee203403474","src/zlib/contrib/pascal/readme.txt":"02f9=
97c37991ddae0cb986039f7b4f6fc816b3fd0ffd332cad371d04c12cf1b9","src/zlib/con=
trib/pascal/zlibd32.mak":"850e91b6c9ea05de61a411cbda16fa0f10118cd88bb32c4b7=
226988776f8d511","src/zlib/contrib/pascal/zlibpas.pas":"c5559b148a9dcdd3284=
3e6920b4d2a2b030f7d32979dfd253aeaa9a4ed31770f","src/zlib/contrib/puff/Makef=
ile":"d9d738030464aaae354196c14fd928adf591832fce7d71ac1977c1d8d4923a4b","sr=
c/zlib/contrib/puff/README":"c5b9852fb11e0d6b6e916e5134cf034524d901b9536897=
2133e0381e480eb479","src/zlib/contrib/puff/puff.c":"5b9d75aeb5baf3575415bc6=
ade3f2a02e50b6b971b3f8b4fda2b03543bc6e52f","src/zlib/contrib/puff/puff.h":"=
969b7be2a930db0cdcb19b0e5b29ae6741f5a8f663b6dba6d647e12ec60cfa8e","src/zlib=
/contrib/puff/pufftest.c":"d24e31c1d277d07c268f34e9490050c6b53c68b128da3efb=
b1d05fc5b31004f7","src/zlib/contrib/puff/zeros.raw":"b7b0887089f7af1f6d1e0b=
4c0a1e8eddd10223b23554299455c6c9be71b653a3","src/zlib/contrib/testzlib/test=
zlib.c":"753dbb39c5d2f0fffac0406c1c94fd1da7b0251d679e4d137b0708901dfd61d8",=
"src/zlib/contrib/testzlib/testzlib.txt":"2359bbdc84eb8a04e0f1cd16cd81a2896=
e957f2ad58dab3ca78ef55b7d0dc577","src/zlib/contrib/untgz/Makefile":"8f5ab15=
64813e091cea8f1bb63da32fd80ac763d029277b0cabf50f60aceefe1","src/zlib/contri=
b/untgz/Makefile.msc":"d0f537de11d9e0e36e2a98b3971c537265f4b533b4c487970943=
65ad9ae8388b","src/zlib/contrib/untgz/untgz.c":"f96c1e8529eb10d723b4547aa96=
5741d72a46f2b1d5c9a2c193bd3f5e2c2a45e","src/zlib/contrib/vstudio/readme.txt=
":"ee95a52d9d2a16aceb070a54dd2c45a1f861178351baf8ea03c2f80328691974","src/z=
lib/contrib/vstudio/vc10/miniunz.vcxproj":"dd607d43c64581172c20c22112821924=
dfe862f56b2e5eb8780bdd0714d9527b","src/zlib/contrib/vstudio/vc10/miniunz.vc=
xproj.filters":"4b8466bf00c70b81c31cc903e756e04151fd90fdcbe102f3568a2c8b619=
0ea27","src/zlib/contrib/vstudio/vc10/minizip.vcxproj":"af73f2cf8ae51e65e85=
342faeb40849a2310c97bc77def42b38d7070460a6cf0","src/zlib/contrib/vstudio/vc=
10/minizip.vcxproj.filters":"f2815f9e3386c393d0a351632823b221ef9689da1f422e=
caa561dba2a612fb0a","src/zlib/contrib/vstudio/vc10/testzlib.vcxproj":"c21e6=
4259bf9efe97e1103212e7a6e1b7372b50067b4ba14cfa678e1f491095f","src/zlib/cont=
rib/vstudio/vc10/testzlib.vcxproj.filters":"a7caddbac3ba90b5d482e6d926ef35c=
c40dc3553ed3776ef6b68a528fd5b0631","src/zlib/contrib/vstudio/vc10/testzlibd=
ll.vcxproj":"3f317d8964f17901c3e68bff5deaec10b6ccc50a572235999e809729269298=
4c","src/zlib/contrib/vstudio/vc10/testzlibdll.vcxproj.filters":"29c9535775=
aa76320ee4efd001d41961faf6c58cedd8b29d3986e85f73d2f6fb","src/zlib/contrib/v=
studio/vc10/zlib.rc":"7aa6cfd50ac67821504304eb4a28668b3aaf78f4c792c389d1fb8=
ea23a5d3ef6","src/zlib/contrib/vstudio/vc10/zlibstat.vcxproj":"50402ab8c63f=
746c034d6ce51d9612aff5b6af9aa27790cffa4b7deed4b30eb8","src/zlib/contrib/vst=
udio/vc10/zlibstat.vcxproj.filters":"eeb1de64c252c46b822f73f272127f6f9f0570=
ef22d234e093070ba95a4dde24","src/zlib/contrib/vstudio/vc10/zlibvc.def":"40c=
8e74194874b8c1a288edb9c6fbf32283df77afef7e520790def28a2e5b0d5","src/zlib/co=
ntrib/vstudio/vc10/zlibvc.sln":"e659860f705f31b87ea9139a3cb4ebe1561e120bce4=
95383a54614fc82b49990","src/zlib/contrib/vstudio/vc10/zlibvc.vcxproj":"efad=
8cb150c0e5122f8c700d95c5de659dff92b171917c66bdbd082fff500b58","src/zlib/con=
trib/vstudio/vc10/zlibvc.vcxproj.filters":"c801732b7c7017796add50d2b71a228f=
99f95a46650baad307ff7e8358a2bfb0","src/zlib/contrib/vstudio/vc11/miniunz.vc=
xproj":"746e4c11fb8af4bcd6a9d68ba81ed1dc366a5de3bed56b291ee969ad733a7bb0","=
src/zlib/contrib/vstudio/vc11/minizip.vcxproj":"340617cae9cf4fcb003308021d3=
782ec3639e60d62d79a3aafc0a50bb55b061e","src/zlib/contrib/vstudio/vc11/testz=
lib.vcxproj":"99eadfdf2e41bc036141c174c4d0035d87572ce5795dcc28f39133f818a79=
d08","src/zlib/contrib/vstudio/vc11/testzlibdll.vcxproj":"583bdef522b017682=
9f0d8139ea2a88b9cbc14379d1334f3a863989ed3df9b67","src/zlib/contrib/vstudio/=
vc11/zlib.rc":"7aa6cfd50ac67821504304eb4a28668b3aaf78f4c792c389d1fb8ea23a5d=
3ef6","src/zlib/contrib/vstudio/vc11/zlibstat.vcxproj":"b07f792843d05ac8833=
91075bc3b9625437490d8d40944ad359aa2134a09a3aa","src/zlib/contrib/vstudio/vc=
11/zlibvc.def":"40c8e74194874b8c1a288edb9c6fbf32283df77afef7e520790def28a2e=
5b0d5","src/zlib/contrib/vstudio/vc11/zlibvc.sln":"27389b515997defd080519f9=
5aff87e89fcbe8b26d73c5ebb73c544cfef4d60e","src/zlib/contrib/vstudio/vc11/zl=
ibvc.vcxproj":"d02d014ef957119a6fd0ab243c892b74d1592b117750b95fed21097c8ed9=
22d9","src/zlib/contrib/vstudio/vc12/miniunz.vcxproj":"1494af54570f6e938529=
32956d49a8c25e57b5abc1ac979945605ca9143df9f8","src/zlib/contrib/vstudio/vc1=
2/minizip.vcxproj":"9bf128ed6760ca5f019006f178b1c65f4c7ff122dba8d297b64b0eb=
72feeb120","src/zlib/contrib/vstudio/vc12/testzlib.vcxproj":"be88bc1220c044=
7c2379fdab3ac88055f58a8a788d3e9cec494342187e760eaf","src/zlib/contrib/vstud=
io/vc12/testzlibdll.vcxproj":"93416510256935d79625dc9fd349cfce6968c062d42a1=
38bec404a26b2f92f5e","src/zlib/contrib/vstudio/vc12/zlib.rc":"c0e44b6f99079=
b298e0a11f013e7b1476402a49f19e4d892467abb4aa116f2c8","src/zlib/contrib/vstu=
dio/vc12/zlibstat.vcxproj":"faa229a851c76b77d65bb4742d8369efe566652bb6a1447=
d1e3539f289b5313d","src/zlib/contrib/vstudio/vc12/zlibvc.def":"40c8e7419487=
4b8c1a288edb9c6fbf32283df77afef7e520790def28a2e5b0d5","src/zlib/contrib/vst=
udio/vc12/zlibvc.sln":"162e0faa80a56d89eea71a0b89377708eec2faa0dc72091cc0ab=
b07fbdea49a0","src/zlib/contrib/vstudio/vc12/zlibvc.vcxproj":"8ac8cb2d29b88=
0a738011d29d0511af9b14f321bed90f674109c446f4108d442","src/zlib/contrib/vstu=
dio/vc14/miniunz.vcxproj":"0312511d4a30cea979c4e36edf994a537ed8a9d924f6b5c5=
36cbcd094773c11f","src/zlib/contrib/vstudio/vc14/minizip.vcxproj":"9e7bb7a6=
ac723e4b2db900627c366f9bb93a351381995d9c69a50c0126f64233","src/zlib/contrib=
/vstudio/vc14/testzlib.vcxproj":"88667873d9d61d65016b9501ca925532eb55f56230=
e5911d3e2a01cd8a9fb2a4","src/zlib/contrib/vstudio/vc14/testzlibdll.vcxproj"=
:"69f544898b4275cd3d8e19b8f1f8cb39c1cb98a30cdb033242e4b94c57bfa150","src/zl=
ib/contrib/vstudio/vc14/zlib.rc":"c0e44b6f99079b298e0a11f013e7b1476402a49f1=
9e4d892467abb4aa116f2c8","src/zlib/contrib/vstudio/vc14/zlibstat.vcxproj":"=
5629eb0cc30674a39aa3636f1cdd190393b0dbd4c69a35e36ad85b6340055605","src/zlib=
/contrib/vstudio/vc14/zlibvc.def":"40c8e74194874b8c1a288edb9c6fbf32283df77a=
fef7e520790def28a2e5b0d5","src/zlib/contrib/vstudio/vc14/zlibvc.sln":"47a50=
bbde8ca6336cecd8c0e4b65e515fc46ae84c7b61008ac9864162f777286","src/zlib/cont=
rib/vstudio/vc14/zlibvc.vcxproj":"09f496a2ad3afdd5e3f36b7285440369dcac45596=
56edc00ed7a74c7ec9fa10f","src/zlib/contrib/vstudio/vc17/miniunz.vcxproj":"a=
a70a28fb573e98c0ef68ead2b875765de180e4c6f46c6135806244257fd918f","src/zlib/=
contrib/vstudio/vc17/minizip.vcxproj":"43ab4593b3ea568dc9e6f78a46cbb0118503=
49e9cf3337cfb91dfdc3e623b414","src/zlib/contrib/vstudio/vc17/testzlib.vcxpr=
oj":"e596d1170c68c6c7912070293e74b794f6753afb1a6d42177dc3626fe1b0e0d4","src=
/zlib/contrib/vstudio/vc17/testzlibdll.vcxproj":"c61f1f6e7e0625f283ac4f4e3c=
a76f25773ada0da43c7c72ce003637f9892c3b","src/zlib/contrib/vstudio/vc17/zlib=
.rc":"c0e44b6f99079b298e0a11f013e7b1476402a49f19e4d892467abb4aa116f2c8","sr=
c/zlib/contrib/vstudio/vc17/zlibstat.vcxproj":"331effbbcf295912daff00fb3594=
c2ee300824733897efc5df7d31b2d379a222","src/zlib/contrib/vstudio/vc17/zlibvc=
.def":"1fa9a4d1624675b0181554ddd841d368a9cf39fe931b80737bfa21402f27a7d8","s=
rc/zlib/contrib/vstudio/vc17/zlibvc.sln":"36da58a5377e65f446c95c7e4c04a915c=
aac9873b94d0dab231e9862391bba78","src/zlib/contrib/vstudio/vc17/zlibvc.vcxp=
roj":"f3222e055d4001f9ee04265a72b8f349f92bd27189ce51852c96dde58539c335","sr=
c/zlib/contrib/vstudio/vc9/miniunz.vcproj":"7db9b2ef5ff05d3de4ba633feab10e8=
5d45434c865d520ffa1974421904996f3","src/zlib/contrib/vstudio/vc9/minizip.vc=
proj":"7797a9ad3c0056f3a3cf8fcde7618acd1d151c65d15f841fccd8d9d878ae7bb0","s=
rc/zlib/contrib/vstudio/vc9/testzlib.vcproj":"8df405917800adccee6bad2116022=
c2c82d661b37ea40ea16405fe4dbcb4b69f","src/zlib/contrib/vstudio/vc9/testzlib=
dll.vcproj":"cde6806f5c81d1fc311f9921c17ba56f8e386d097783a6a90875d385837c47=
e7","src/zlib/contrib/vstudio/vc9/zlib.rc":"7aa6cfd50ac67821504304eb4a28668=
b3aaf78f4c792c389d1fb8ea23a5d3ef6","src/zlib/contrib/vstudio/vc9/zlibstat.v=
cproj":"d393d418d827ad9fb9c6516f1a7620371d15e3f5afef8ba60b51e50acc7199e9","=
src/zlib/contrib/vstudio/vc9/zlibvc.def":"40c8e74194874b8c1a288edb9c6fbf322=
83df77afef7e520790def28a2e5b0d5","src/zlib/contrib/vstudio/vc9/zlibvc.sln":=
"26e58d4b2cfcd941c367fb2a18537b3b9f002f2ac1278b700ea1129c50501452","src/zli=
b/contrib/vstudio/vc9/zlibvc.vcproj":"eaca98fcf166738b59fcdbd179dac9f98f985=
c6ba49212b186343a998816f081","src/zlib/crc32.c":"8fd16f0a7714d51c89c2eb37eb=
98ec15e8a4dc57ba343e7b7398b19144039fda","src/zlib/crc32.h":"9a2223575183ac2=
ee8a247f20bf3ac066e8bd0140369556bdbdffc777435749e","src/zlib/deflate.c":"3b=
956337350f94c34987750f785587ef33d9c89ceaebb7c2afb189c956360cbe","src/zlib/d=
eflate.h":"48baf016326d8d5e3e32ac8153cc7e22f854b8e6834830b167b998a7fb1e7989=
","src/zlib/doc/algorithm.txt":"a2581ab546bf053e3e95d191a6accc3b06bbd4f08ad=
2fb888eacbfb9773c1d30","src/zlib/doc/crc-doc.1.0.pdf":"064f9252d6e2e15ea56c=
2bd18e160e5c9c84bcd137c11a7af497aaa511ace998","src/zlib/doc/rfc1950.txt":"8=
f0475a5c984657bf26277f73df9456c9b97f175084f0c1748f1eb1f0b9b10b9","src/zlib/=
doc/rfc1951.txt":"5ebf4b5b7fe1c3a0c0ab9aa3ac8c0f3853a7dc484905e76e03b0b0f30=
1350009","src/zlib/doc/rfc1952.txt":"164ef0897b4cbec63abf1b57f069f3599bd0fb=
7c72c2a4dee21bd7e03ec9af67","src/zlib/doc/txtvsbin.txt":"d1549fb75137f03102=
798f70fd34ff76285e717ddd520dd82274c1c0510eacf0","src/zlib/examples/README.e=
xamples":"1bc1c677bbebe1aa5e85015bb62f0cf3fcdbf95652d30494159bee6166c1854a"=
,"src/zlib/examples/enough.c":"c14a257c60bbe0d65bb54746dd97774a1853ef9e3f78=
db118a27d8bc0d26d738","src/zlib/examples/fitblk.c":"bec64da6fc0c9a2a37a9672=
2e8b88ca09059148e5be5ecbb486bdba5339e228a","src/zlib/examples/gun.c":"3bfd3=
6b06284ba97d6105b8a6a5d18b2b34b75b3a1285f16d018680fb174915f","src/zlib/exam=
ples/gzappend.c":"6de91c8305e37560117bff44136abff72b16b028c0bda0bbac7ea07e4=
988b0ce","src/zlib/examples/gzjoin.c":"90b9d6c39a5fc91cf1cc9b96b025a508a801=
5dc502cd9374c754b44078593f57","src/zlib/examples/gzlog.c":"d9a2f9871e7f1724=
f9f9359fd4851dc0eac7af10d8234bab66327badb33d1a38","src/zlib/examples/gzlog.=
h":"681f280437f867820bf39880e2f4fc641d402879e399ba2e6a31d73feefe8edc","src/=
zlib/examples/gznorm.c":"e5a8f5c3b107f27212f7d5fbfcf072a337a1b4ea32929ae31c=
168997438a5cc0","src/zlib/examples/zlib_how.html":"bada2526c34e9da7c9682a72=
16c0b0d7ac26f49195f98d3ef56f14ae9b438177","src/zlib/examples/zpipe.c":"6814=
0a82582ede938159630bca0fb13a93b4bf1cb2e85b08943c26242cf8f3a6","src/zlib/exa=
mples/zran.c":"f4bc94b710841b8412aee04c42ea522bd1687343d65f0c0d92b4dd5801d0=
3956","src/zlib/examples/zran.h":"913158e13f6177224074cfa9b497438545054ac0d=
54ab13a6ad4182df8d2ee99","src/zlib/gzclose.c":"35ea6e991a63095f797d8c4cc258=
17fac7a7155c2ba7dcdbbf648f7871c7ea40","src/zlib/gzguts.h":"716fa648aca1bb06=
c219d7b97ad4846d8479206143bc39557bfd8283f5783e04","src/zlib/gzlib.c":"042c2=
be8ec67ad525a2812e508de7381c6766dde903acf5ae6ac4fa6b541946d","src/zlib/gzre=
ad.c":"72e481aca07b0b85a9783237b85dc67ff3a4c1d19878d0cec69f58d38634867b","s=
rc/zlib/gzwrite.c":"469b1e58932ea11bdda2a153f6655f7b3c13254240fae157181b49e=
d1bc93b47","src/zlib/infback.c":"62df9a6dd3eef126f1d81d0ad7a534504610dec444=
82b0a472b61c93cbab6554","src/zlib/inffast.c":"e6ef64ce5dc0a4cd5c7ad08ceeb2b=
2a698b8447f6bd156057caeb2edab68c0cb","src/zlib/inffast.h":"05cc5dc9ff1da7b8=
b52a4bd8bda0d8a5c236a2f39efe84b941516ea13857e6c5","src/zlib/inffixed.h":"23=
7ba710f090e432b62ebf963bee8b302867e9691406b2d3f8ee89ee7bfef9b0","src/zlib/i=
nflate.c":"34c998ce0037c0537c04b03b276f680b945f9b2c9d1e01b287605bd6879f7fd2=
","src/zlib/inflate.h":"e8d4a51b07694bf48cb91979c19974cf6a5ab0b8a09d26ec0d1=
4df349230673e","src/zlib/inftrees.c":"5d4f335221d2dc76f17abd2577d92c2d7baf6=
8fa6d7f23373b360830493d1563","src/zlib/inftrees.h":"0a0fcaf2ae2fae57426bdc0=
6637270e9bba974f35202cadbdba479d946e6409d","src/zlib/make_vms.com":"14ed54b=
dd391c1648cedfb69d8a73a26dcc7f1187d59b0f18d944b7665cec85b","src/zlib/msdos/=
Makefile.bor":"292ab363f7ffbc4ae84d37cd9bdffd2dac1003bee52d223a8489844870f2=
0702","src/zlib/msdos/Makefile.dj2":"9208450c2ae6dcbfcc25560b5b9ca763f461e7=
246e37b0552474edf8fa898906","src/zlib/msdos/Makefile.emx":"c749d6ec7f88e8e6=
39d4f03bdbdcbbe9d1c304210be4c4be621ceb22961d3d64","src/zlib/msdos/Makefile.=
msc":"0e021a6f42212415b060e4ad468eb415d0a8c1f343137fb9dff2cb8f9ead3027","sr=
c/zlib/msdos/Makefile.tc":"2ae12ee2a3e62f7c5a0520d0fbe4adee772bc07fe816002b=
07ccb43db3daa76a","src/zlib/nintendods/Makefile":"ea5823efe6830132294eddf2f=
56dbd7db8712244c210bb4968c431b1a91bd066","src/zlib/nintendods/README":"e362=
426c47b39ff6a7d6c75c6660b20abf076cdfa5e1e421716dc629a71aef95","src/zlib/old=
/Makefile.emx":"d811f032272aae50123a889297af3a02fbd60d1e42bbef11466462f627f=
f7b5b","src/zlib/old/Makefile.riscos":"d1a488b160fbfd53272b68a913283a4be08b=
a9d490796b196dddb2ba535b41e0","src/zlib/old/README":"551a0f4d91fe0f827a31cb=
dfbb4a71d1f3dc4d06564d80a3f526b749dd104d11","src/zlib/old/descrip.mms":"8ff=
08c35c056df9c986f23c09cf8936db63ccf12c3c42f7d18a48b36f060cff7","src/zlib/ol=
d/os2/Makefile.os2":"6ad247c00f00ff42fd2d62555e86251cef06e4079378241b5f320c=
227507d51d","src/zlib/old/os2/zlib.def":"ea9c61876d2e20b67ef2d9495991a32798=
eb40d13ede95859a2f4f03b65b9b61","src/zlib/old/visual-basic.txt":"04f39c86a8=
894561498430ca169e9d6ca2c5cc99b43ee923081884065a0b2b1f","src/zlib/os400/REA=
DME400":"96580d63002088615c4b5ea865cdbec234fef0c8471667d2dc66273398123743",=
"src/zlib/os400/bndsrc":"3c36a17975eed5a8d33bc5443b39fead1e68c01393496be9c1=
f4a61444bcb0f6","src/zlib/os400/make.sh":"143394d1e3876c61c29078c0e47310e72=
6e1f5bd42739fe92df9ece65711655f","src/zlib/os400/zlib.inc":"c01ddd22689c281=
066f2bd2e3a020fad4cd50c1e543f17fae963da89a0d69a29","src/zlib/qnx/package.qp=
g":"6c499168c561fc08e2fc41b07fc7a43882a52ede30c1599ed9f6a4035e764225","src/=
zlib/test/example.c":"b7aeca68f7585e29ca6572542e0ecbd9c3c9370035ae15152008b=
3efbd4f84ac","src/zlib/test/infcover.c":"13a0d18d8bca440c4617d88c2236913f53=
eedebc50e469be472edd4280c697e5","src/zlib/test/minigzip.c":"57e4a1b9bb1bdb5=
9ac9e5ac1dc9132183e8740cec2f6b5c5f2476aac08a2375f","src/zlib/treebuild.xml"=
:"7d1cb70609017f6f22079af7569c8d8be2ae51e9524fc173719a487181d60860","src/zl=
ib/trees.c":"f63c68c16c05fcd196050529d1a0e7657960e4136b9987d90a6ac3e58a964b=
0f","src/zlib/trees.h":"bb0a9d3ca88ee00c81adb7c636e73b97085f6ef1b52d6d58edb=
e2b6dc3adeb4d","src/zlib/uncompr.c":"04dca5e31b3b8a17d1806426f66f0c539f4184=
d657e149d40be07070c6227b52","src/zlib/watcom/watcom_f.mak":"7e039b912f9cffa=
a40835281430bb284fa9042b0a0d12f6b34700a06bca6576e","src/zlib/watcom/watcom_=
l.mak":"d11b4064604a034725860e63e3f6d347056372e4b1675b183e20a93533b20cc9","=
src/zlib/win32/DLL_FAQ.txt":"539adcdcea4dcab44d0e788febd217a6f192bc0758dc78=
13cd5f5d8474d9b428","src/zlib/win32/Makefile.bor":"7d73a0d2c3e38b7c610bbc9c=
22f683a4fe1ab9b8b65649a3a8ac4ff7fcc14ba6","src/zlib/win32/Makefile.gcc":"97=
140c30506a8f6b2edb6b3d8a1b6b539d7929d4b957deba9950301090f579bf","src/zlib/w=
in32/Makefile.msc":"235529bd529d4690d5d4b7871fdd0a1f118f2fe18862cbdec5f5ac6=
74c55a60d","src/zlib/win32/README-WIN32.txt":"508bee0ef1a34892281517919970e=
b337e017503671d0fa0f139523b44b4d0eb","src/zlib/win32/VisualC.txt":"9ec0babd=
46eaa012371dee2d3a8a55d9c7130f7895512c3371c737e4a7f6a997","src/zlib/win32/z=
lib.def":"c00693a5c825f8bfbdb68124fd03cb2fa5269338071147bdaa14434aaf3962b9"=
,"src/zlib/win32/zlib1.rc":"54e161029b59e99a4f9cb2281b956f00ecfb1814318ddef=
9c741ff4f832c5c1d","src/zlib/zconf.h":"f5134250a67d57459234b63858f0d9d3ef8d=
cc48e9e1028d3f4fdcf6eae677ae","src/zlib/zconf.h.cmakein":"350fb02462487a3e8=
612c18ad279053996ce0c85ebfece25a959baea9db86562","src/zlib/zconf.h.in":"f51=
34250a67d57459234b63858f0d9d3ef8dcc48e9e1028d3f4fdcf6eae677ae","src/zlib/zl=
ib.3":"5aadb3f129c4c7e29f28bb6c5954dea061df3046d0fe3e134aff2ef4a217b1d6","s=
rc/zlib/zlib.3.pdf":"434e8d80e43ed24ed58a7dad0867a1136035864ad3e5fd4cc2c69e=
0715628c66","src/zlib/zlib.h":"8a5579af72ea4f427ff00a4150f0ccb3fc5c1e4379f7=
26e101133b1ab9fc600c","src/zlib/zlib.map":"e83d883a3f7bb93b3dcfab28f5300a56=
9bc7586ded2e067c0639d0697d13fe1e","src/zlib/zlib.pc.cmakein":"2f1d0b18ce37c=
2af415a469857f02aee2c41a58877aff21d29e9c6db32b55cb7","src/zlib/zlib.pc.in":=
"04c01cc2e1a0ed123518b5855f585c93a24526dd88982c414111ea1fc9f07997","src/zli=
b/zutil.c":"8ced40d8c88588811edd2bdb35b7439983d5e1f8e9e32b8a3b244731f3c317b=
7","src/zlib/zutil.h":"dddb2dc7a1dc339ecf2c8e089b366f08bb731c0839c7110240d1=
7ce731bb4fea"},"package":"5e143b5e666b2695d28f6bca6497720813f699c9602dd7f5c=
ac91008b8ada7f9"}
 \ No newline at end of file
diff --git a/recipes-devtools/rust/libstd-rs_1.80.1.bb b/recipes-devtools/r=
ust/libstd-rs_1.81.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.80.1.bb
rename to recipes-devtools/rust/libstd-rs_1.81.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.80.1.bb b/recipes-=
devtools/rust/rust-cross-canadian_1.81.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.80.1.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.81.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.80.1.bb b/recipes-devtools/r=
ust/rust-llvm_1.81.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.80.1.bb
rename to recipes-devtools/rust/rust-llvm_1.81.0.bb
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rus=
t/rust-snapshot.inc
index 66d777f..4446863 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,56 +4,56 @@
 ## The exact (previous) version that has been used is specified in the sou=
rce tarball.
 ## The version is replicated here.
=20
-SNAPSHOT_VERSION =3D "1.79.0"
+SNAPSHOT_VERSION =3D "1.80.1"
=20
-SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "4ca5e9bd141b0111387ea1aa035=
5f87eb8d0da52fbc616cefa4ecde4997aa65b"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "77803cfff2ea0342f26b59eabe=
c353bc43a1791012aa70855ecfea0fb7ae76ac"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "519abf4757fbd8d7e3bb4e4c=
fdc362ded972c1d95f04675684df2d31e8c0899b"
-SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "9c847b42b81325d25a9240e33bf=
03fa8652f5dd321ae90a9a7a58b46bf124b17"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "a8c4f1ab2f65e7579eb80153fd1=
ca9a0b365ca31ca6ae0ebd34156e0724dfc60"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "3d522172f9797e65c609a640af=
7f4ac331525150c91f93e41798c5578e9523e9"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "8fc4bfc3a5fe64f8530964a5=
ea3bda95e39357eff14d6a8bb24f010ecc912923"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "fc21ca734504c3d0ccaf361f05c=
b491142c365ce8a326f942206b0199c49bbb4"
=20
-SRC_URI[cargo-snapshot-i686.sha256sum] =3D "57bd43f363ebd399a38aa4ac3b137e=
9172706770f8b23479f9dd859c6ae779ab"
-SRC_URI[clippy-snapshot-i686.sha256sum] =3D "1d2612c829d946ca8ce32f2beacfd=
e2c5ebed1fcacb720a58fb8e7786e4c82f2"
-SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "158294f7c424ef75d84046b573f=
225c15d531745cc79d416a18c11aa8253830e"
-SRC_URI[rustc-snapshot-i686.sha256sum] =3D "4695a6eb66252d519510ca0a859803=
fff3a5041f71004404df0ccc9fbf0298d5"
+SRC_URI[cargo-snapshot-i686.sha256sum] =3D "b0f6d95c8a292b1276f30b1bca1419=
7b28297c2fcd51974ef320d05497be3ca3"
+SRC_URI[clippy-snapshot-i686.sha256sum] =3D "a6899744ed734dd3a9f59631a9437=
21bfe67ed6273e60dd67e8636820c1bfffd"
+SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "6547876dcf243aeeeadaa38dbdc=
e02c316b6f83305a5337520e02eaffc90834b"
+SRC_URI[rustc-snapshot-i686.sha256sum] =3D "b40c1437491d0a24756b6baabb14c2=
d4d0def199bc652f16e417addb171ac977"
=20
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "354d498a8e36abe6ebd7bd8=
59c8c7e7f02b029aa1897b9b60a87e9902ebb1079"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "88eab562705d56a246a09f=
2897cbae9e37a66dc3cc2cab52c781cd78024f2b52"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "88730b1b0d9c5252e041=
ed1fc2375d7292dc45132bcc8b6214490c578de240d3"
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "f39a604e1a5a5ba1c7342c9=
d98c9952b5ba252cda4b55cc6ae7bd6fca72f3889"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "843272f7ab9b2f8c24f1747=
249275e0472fb2ede90f3a404e897559ddb898c18"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "e4dba3b66bd8f811c8508f=
d3be1bf136b714018768d9f16a96f601ebd375bcc6"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "68f30f3743b573e205ec=
c1733e1250ffb8d8d81e131c3b2f4a819b7e1e610d62"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "5ae96e69573690aa48ffb9f=
ecc62826ffb5d2fc280d19d1e54ab36ff48e28b68"
=20
-SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "2a55e97ce512c27a012720bb2a0=
cd86554c1d734b5cb91b98f58af167cc0fde1"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "1ae0bbe5835d9461a12f22d509=
787e6c11aac8335c677152a57a04f8d22cf755"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "6aa2f351bc7dccb544781f4f=
ecddb5ef67e05bb310c84e0106d968231384d9f4"
-SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "3b9a8067e97dd269a27fe91be16=
3e046e85b47973f5d512c3368c49d332dacb1"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "a88402d95f2959caaff20037144=
d3109a69ce3310e1dfbb27231dacd50fa2988"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "ae1762dc8fd679d65154d5af95=
00c7539f55ec9d049ab736a910893d382fd6c0"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "88e8144c25ef8347471dd53e=
ea7af62e5b31eadf0788f4a82be7560f5a0be255"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "5f435b48316a719c87fb27f49c0=
b37884cef7dd3ecba76df9db2a4008cc03458"
=20
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "1e2ffcc41a2083be2f4733d53=
4d5ee0e05fc2ace1f21033792a4e2497cbbfbe4"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "0bceeb8dc5b48e5ea9cff67c=
dcf8488fe2afe44d7e75ca04669c7c0c2e02a0df"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "af95929af71494ee3e6988=
ead07204ea05b6f2b729cdb1ffcc26db75e47bf318"
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "2295d50425ed5dfb028560ac0=
f9a611212d8deb43791a1d199419043157ab95e"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "be2707eaa24f34775c98044f9=
2c391a2c6037a2214adab9e83c62903001fb577"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "a422a3b638c42f26ada441d2=
940a44a8c0f1ade9459f86d48a3d8fcc866bc60b"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "cb5ad871a0a7efe7c270cb=
f319d006a84e8f8526acb22ce941f2840fd0e368c2"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "e3257dc0790728498cf2773c3=
ca66d728381cc6d1f403969bd282223bd97aa3d"
=20
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "bec32adad9f2cd1650ed24e=
e82fccf7329c68243cdef7cef1e720ccaea097dab"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "6bb12041b6171e80598c0c=
04eb7e9bd07ab4fb4d654a9289618e3288a4d2f6c8"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "3b5d53d70837d5ec942e=
c41a8da37ed932bbdc1e53f78dc54e218db458701588"
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "3b144840f179114cde30789=
09370bfb6928153d0ae303ac9848622c57cee3578"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "a523cf21d751be597a19830=
136e3479b7f22d3642d95f53f78a11e770d971d28"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "93ce75f4edf2c3b792714d=
33e279c5743d9d3ef841f8f2d8a7e76c9c7d74f952"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "06633b26384cba594424=
ec02acf0d64d4724033a856a2e039a18a518cacf1d3e"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "5f72f8723a2023b0bbd64cf=
c3d10959c4210b68579ad8e174809d17e1e2ead36"
=20
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "83e28f3e02cce4a9d19841bcb=
40ec0c8ad4e9af9fb215c39876028e6e9e6baf1"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "fbc978db4be2e6fdb1dbcb3c=
a00ee54c44dafd08930738f1c6aa7ae249685a34"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "2b8af4060acb10f347c66a=
3477ae92151beba12192590ea40723dcf9b1f7f5b2"
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "1b952b8cd597060ac07bbe99c=
ea382651ca6eee4ac2abe0a90303ccf2278e60e"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "29e996af02293562f6ee79032=
a5414fffbf77e75cb7f0ba89053849986cb6303"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "24465ce5fe8f04d9b54c31a2=
c5bcaba6d702925ac3cdec0af5b954643013db90"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "1fbbe8df7596682466ae2f=
ca534d5f6bae8b3f32577450e2632955268a786a06"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "838d78ef8b9a11751b1dfb2cf=
2abfdc845deca8f0002c11930d54577b433cb93"
=20
-SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "5663e6ea018a13f1c87ac74de2678=
29952ea979fbe5f8ee5c1c3531e25d1749c"
-SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "c00bd892e0f29bbc2514f87c7521=
210ced8c175a41eee0a428e19a6ef157779f"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "d70e710a5138871e8d972f195c=
ed9f7aa639ccef23a87fa03cc527d2b9c3cd36"
-SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "ef4b494fb7356b6e88a69b71378c0=
4ae0f4a3c264adae84c9d4f3a1314eaa2b4"
+SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "0c22278b4e8afa79de0cae798575c=
9ef258e73d0555b18a84efd5d042c69c6e2"
+SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "52c3368de0e01b07f89f74a4b362=
79be1b7d2312b05253c7c9ccb50bc38f263a"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "e732ce690fd63e3c2576bfe83a=
556031c4805c17b35b8a1c1a0ddde5cee31d46"
+SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "0c06439db686645be36390969b503=
996608f25954eab2b7fd9a2915da6c0bd7b"
=20
-SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "07fcadd27b645ad58ff4dae5ef16=
6fd730311bbae8f25f6640fe1bfd2a1f3c3c"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "3fb282ee97626e4f25c4f6faac3=
997859b89f13983dd6fa111e25182dfcb91fa"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "2c914483c0882d44af2e50a18=
1cbd2c953d672d50b31aa669ee2346cade1f108"
-SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "a04cf42022d0a5faf01c31082bfb=
1dde9c38409f0ca6da90a3e40faa03e797ae"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "da9340b3249f08656cd4fe10e47a=
a292c7cd79903870a5863064731a00b5b27e"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "e01d434e952821900f37824c797=
f87ed16db79e54fcbd2f396b2f1b5cb2e3c55"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "b793405538d8b6ec1632779ef=
a8835b07b8987db2008c5c9c809bc4b17dcb121"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "0367f069b49560af5c61810530d4=
721ad13eecfcb48952e67a2c32be903d5043"
=20
-SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "9c38f2cd4c19196fcf113166237=
ab03512bf19ce5a7f13c3bfe0e5cc3317eb44"
+SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "94927cdfa7cad391700b1a77730=
bb17aa364831ff6a6c40ce6500a14c1314647"
=20
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "f7c7a73a8e5640f9d5aca6b2=
6866b4da08cf3d3509ed1c4184309fb868acbff2"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "ee7fa0104b019eec22750ac6=
35e699d21dbb5430fc6982c495533900ec568d5b"
=20
 SRC_URI +=3D " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-s=
napshot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index c21d1d8..342d56c 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -1,17 +1,15 @@
 RUST_VERSION ?=3D "${@d.getVar('PV').split('-')[0]}"
=20
 SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.=
tar.xz;name=3Drust \
-            file://hardcodepaths.patch;patchdir=3D${RUSTSRC} \
             file://zlib-off64_t.patch;patchdir=3D${RUSTSRC} \
             file://rv32-rustix-libc-backend.patch;patchdir=3D${RUSTSRC} \
             file://rv32-cargo-rustix-0.38.28-fix.patch;patchdir=3D${RUSTSR=
C} \
-            file://0001-cargo-do-not-write-host-information-into-compilati=
on.patch;patchdir=3D${RUSTSRC} \
             file://rustdoc-repro-issue-fix-cargo-config-for-codegenunits.p=
atch;patchdir=3D${RUSTSRC} \
             file://rust-oe-selftest.patch;patchdir=3D${RUSTSRC} \
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=3D=
${RUSTSRC} \
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.pa=
tch;patchdir=3D${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] =3D "6ab79b70dc57737a1de378f212fcf8852d67fe6cf272d=
122a15b3ea13be77947"
+SRC_URI[rust.sha256sum] =3D "36217ef7e32f40a180e3d79bd666b4dfdaed49dd38102=
3a5fb765fd12d0092ce"
=20
 RUSTSRC =3D "${WORKDIR}/rustc-${RUST_VERSION}-src"
=20
diff --git a/recipes-devtools/rust/rust_1.80.1.bb b/recipes-devtools/rust/r=
ust_1.81.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.80.1.bb
rename to recipes-devtools/rust/rust_1.81.0.bb
--=20
2.48.1


