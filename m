Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCC3C3ABA3
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:02 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web11.4650.1746132053195347048
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=m83Y8O3C;
 spf=pass (domain: konsulko.com, ip: 209.85.219.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso23983246d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132052; x=1746736852; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNnGeV5Ke/Jmb2GQwbYvfJahB0naQ7xhQ/Otd1PbKJI=;
        b=m83Y8O3CPUW07OAH0LUIlnsxSplsZX1oX8Hpa0V1oy+yVSp3gpPqGKTAScTEP/rdVI
         1Y7sYZtRklWZlzcZJRD/YeCBBdZxOL0CCkHl0PncHWzPhcnG6rQIJMY1rptLoJqxOLn9
         W6o1C0Sp3Ri+8dJpW9dAER6Ndva+LEriC56xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132052; x=1746736852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNnGeV5Ke/Jmb2GQwbYvfJahB0naQ7xhQ/Otd1PbKJI=;
        b=L/aJHb1auv1mHwfemhT2ft5qzVKc6qaRez5FMN8nqjPUJ4TnueBpX6iKPdjIXashwR
         OSB2RtpWEfXGZjbXN/773pvEyK3FbBhkBfr69PBvlC8cUHs3a5jr5V7HVxzgpmFS45Pg
         c1uPWLywUD6o5hxWUsgEHDWPHrsOT80TpWVbL16EZ66+m5qM8/0nsgCCldQlY7WEFkeu
         v5hEgwnTiBNgdt7wRthjq0VEr5ZQql3iT0nsEqYjMhYgy1hzF7rf37aCrACWDTEajfyi
         3cHWflC2RDF9siBW3Q/wXtTJG97L7CC5v/RYdehhiK8mxUj7azZtJ/rjoCOdZNijKW77
         crHg==
X-Gm-Message-State: AOJu0YwgZVuXvOwlIZ0DdY0vESQl7yBWX6WRy2xHvUg1QE8cIA96LEW8
	sRLGdsCehPAS9V95LKs4Hzr4AYNVfchzeCrJVvGSOSW3N1kBlwJwEmotFySfNGFc/FR8QVC1TH4
	3
X-Gm-Gg: ASbGncvl7vBjSAR8zEGHIe7AI4lxgscRhuQeuqAfBCbs1kFBS+HVt9WI1Xu0VFlv2Sk
	7RLqz47dQWkg0iW0SZ1K+NsL4PSJRt34fFhZWDyE7mJxEeL534o5Ou4Vqz/BVk02NIxE47Cwc5q
	vXBYBmeLPmqIpDginmH1jELJGg9mk6voPOwXfI0lRxY9n5j91EUwJoQbH8Wbq4bSiOPEXHOF5Lc
	uaRt5KuH9YOBUnD4qBrNyn5b5aUw0OwNzBMmgN3k5FWAjREsTUDDjReuUTd6zmo8T+sTIa6JwCj
	csrUCC2AxO5tSNn9y6z8zr242fkf0sTRKeJ/azEMXzKQ0ftsFjh0Jxu8QmlMHIHb3vfcA1KaCq/
	3pZj5V+f1BiqBbwgS
X-Google-Smtp-Source: AGHT+IEKy4zIOPg+xDTyL99Diy00W4QV9RU4CVrBl0KT2kdEJ+Uer6VK3NPb6PfhMXbFyxqkM63aJA==
X-Received: by 2002:ad4:5ba2:0:b0:6e8:f470:2b11 with SMTP id 6a1803df08f44-6f51538e0aamr13140946d6.23.1746132050192;
        Thu, 01 May 2025 13:40:50 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:49 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 15/38] rust: Upgrade 1.82.0->1.83.0
Date: Thu,  1 May 2025 16:39:51 -0400
Message-ID: <b74a9cd5dc0cb974365f1f55cc068397859ea982.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1444

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Rust stable version updated to 1.83.0.
https://blog.rust-lang.org/2024/11/28/Rust-1.83.0.html

Renamed and modified the below patch to adapt the new version.
rv32-cargo-rustix-0.38.34-fix.patch->rv32-cargo-rustix-0.38.37-fix.patch

Modified the below patches to adapt the new version.
repro-issue-fix-with-cc-crate-hashmap.patch
revert-link-std-statically-in-rustc_driver-feature.patch

Dropped: zlib-off64_t.patch
https://github.com/madler/zlib/commit/a566e156b3fa07b566ddbf6801b517a9dba04=
fa3kq

Because of the following commit ,
https://github.com/rust-lang/rust/commit/68034f837a39387e49fc7d7c5b088f5372=
a1127e
when we enable lib32, getting build failure because there is a check for ta=
rget
support for "-Zdual-proc-macros" flag not functioning properly when lib32 is
enabled in the build environment. So for now reverting this commit and bring
back the previous behavior, where the "-Zdual-proc-macros" flag is always
added for building proc macros, regardless of the target architecture's sup=
port.
This would bypass the check introduced in the patch, allowing the build to
proceed without error, even when building for a 64-bit architecture with li=
b32 enabled.

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 40d8dafdf556d7ce79c12a6de872193be9a0928a)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |   2 +-
 .../rust/{cargo_1.82.0.bb =3D> cargo_1.83.0.bb} |   0
 ...epro-issue-fix-with-cc-crate-hashmap.patch |  97 +++++------------
 ...t-Zdual-proc-macros-additional-check.patch |  43 ++++++++
 ...d-statically-in-rustc_driver-feature.patch |  37 ++++++-
 .../rust/files/rust-oe-selftest.patch         |  15 +--
 .../files/rv32-cargo-rustix-0.38.34-fix.patch |  78 -------------
 .../files/rv32-cargo-rustix-0.38.37-fix.patch | 103 ++++++++++++++++++
 .../rust/files/zlib-off64_t.patch             |  33 ------
 ...ibstd-rs_1.82.0.bb =3D> libstd-rs_1.83.0.bb} |   0
 ....82.0.bb =3D> rust-cross-canadian_1.83.0.bb} |   0
 ...ust-llvm_1.82.0.bb =3D> rust-llvm_1.83.0.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       |  76 ++++++-------
 recipes-devtools/rust/rust-source.inc         |   8 +-
 .../rust/{rust_1.82.0.bb =3D> rust_1.83.0.bb}   |   0
 15 files changed, 249 insertions(+), 243 deletions(-)
 rename recipes-devtools/rust/{cargo_1.82.0.bb =3D> cargo_1.83.0.bb} (100%)
 create mode 100644 recipes-devtools/rust/files/revert-Zdual-proc-macros-ad=
ditional-check.patch
 delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.34-f=
ix.patch
 create mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.37-f=
ix.patch
 delete mode 100644 recipes-devtools/rust/files/zlib-off64_t.patch
 rename recipes-devtools/rust/{libstd-rs_1.82.0.bb =3D> libstd-rs_1.83.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.82.0.bb =3D> rust-cros=
s-canadian_1.83.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.82.0.bb =3D> rust-llvm_1.83.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust_1.82.0.bb =3D> rust_1.83.0.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index aa2f45f..696ac90 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -13,7 +13,7 @@ LAYERSERIES_COMPAT_lts-rust-mixin =3D "kirkstone"
=20
 LAYERDEPENDS_lts-rust-mixin =3D "core"
=20
-RUSTVERSION ?=3D "1.82%"
+RUSTVERSION ?=3D "1.83%"
=20
 # This is not ideal, but it seems better to mask out the older oe-core
 # recipes completely since they will not work with this layer on top,
diff --git a/recipes-devtools/rust/cargo_1.82.0.bb b/recipes-devtools/rust/=
cargo_1.83.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.82.0.bb
rename to recipes-devtools/rust/cargo_1.83.0.bb
diff --git a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hash=
map.patch b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashm=
ap.patch
index baca486..f47a02c 100644
--- a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
+++ b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
@@ -1,4 +1,4 @@
-rust: reproducibility issue fix with v1.82
+rust: reproducibility issue fix with v1.83
=20
 A few crates are using the updated version of the 'cc' crate and this is c=
ausing the generated object file names containing a unique hashmap id.
 By the following changes same hash values will be genarted even for diffre=
nt build paths.
@@ -8,47 +8,6 @@ https://github.com/rust-lang/cc-rs/pull/1277
=20
 Upstream-Status: Submitted [https://github.com/rust-lang/cc-rs/pull/1277]
 Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
---- a/vendor/cc-1.0.97/src/command_helpers.rs
-+++ b/vendor/cc-1.0.97/src/command_helpers.rs
-@@ -257,6 +257,7 @@
- /// and store them in the output Object.
- pub(crate) fn objects_from_files(files: &[Arc<Path>], dst: &Path) -> Resu=
lt<Vec<Object>, Error> {
-     let mut objects =3D Vec::with_capacity(files.len());
-+    let target_substring =3D ["rustc"];
-     for file in files {
-         let basename =3D file
-             .file_name()
-@@ -277,10 +278,29 @@
-             })?
-             .to_string_lossy();
-
-+        // Function to find the position of the first occurrence of the t=
arget substring
-+        fn find_target_position(s: &str, targets: &[&str]) -> Option<usiz=
e> {
-+            let mut pos =3D None;
-+            for target in targets {
-+                if let Some(index) =3D s.rfind(target) {
-+                     //If a target is found and pos is None, set it
-+                         if pos.is_none() || index < pos.unwrap() {
-+                             pos =3D Some(index);
-+                         }
-+                }
-+            }
-+            pos
-+        }
-+
-+        let filtered_dirname =3D if let Some(pos) =3D find_target_positio=
n(&dirname, &target_substring) {
-+            dirname[pos..].to_string()  //Keep everything from the target=
 substring onwards
-+        }  else {
-+            dirname.to_string()  //If target substring is not found, keep=
 the original dirname
-+        };
-         // Hash the dirname. This should prevent conflicts if we have mul=
tiple
-         // object files with the same filename in different subfolders.
-         let mut hasher =3D hash_map::DefaultHasher::new();
--        hasher.write(dirname.to_string().as_bytes());
-+        hasher.write(filtered_dirname.as_bytes());
-         let obj =3D dst
-             .join(format!("{:016x}-{}", hasher.finish(), basename))
-             .with_extension("o");
 diff --git a/vendor/cc-1.0.99/src/command_helpers.rs b/vendor/cc-1.0.99/sr=
c/command_helpers.rs
 index fe919a5239..2b1f442019 100644
 --- a/vendor/cc-1.0.99/src/command_helpers.rs
@@ -92,11 +51,11 @@ index fe919a5239..2b1f442019 100644
          let obj =3D dst
              .join(format!("{:016x}-{}", hasher.finish(), basename))
              .with_extension("o");
-diff --git a/vendor/cc-1.0.105/src/command_helpers.rs b/vendor/cc-1.0.105/=
src/command_helpers.rs
-index 2fce90a9da..584e386edd 100644
---- a/vendor/cc-1.0.105/src/command_helpers.rs
-+++ b/vendor/cc-1.0.105/src/command_helpers.rs
-@@ -259,6 +259,7 @@ fn wait_on_child(
+diff --git a/vendor/cc-1.1.22/src/command_helpers.rs b/vendor/cc-1.1.22/sr=
c/command_helpers.rs
+index 07dfb80412..e01b62fa39 100644
+--- a/vendor/cc-1.1.22/src/command_helpers.rs
++++ b/vendor/cc-1.1.22/src/command_helpers.rs
+@@ -285,6 +285,7 @@ fn wait_on_child(
  /// and store them in the output Object.
  pub(crate) fn objects_from_files(files: &[Arc<Path>], dst: &Path) -> Resu=
lt<Vec<Object>, Error> {
      let mut objects =3D Vec::with_capacity(files.len());
@@ -104,7 +63,7 @@ index 2fce90a9da..584e386edd 100644
      for file in files {
          let basename =3D file
              .file_name()
-@@ -279,10 +280,29 @@ pub(crate) fn objects_from_files(files: &[Arc<Path>]=
, dst: &Path) -> Result<Vec<
+@@ -305,10 +306,29 @@ pub(crate) fn objects_from_files(files: &[Arc<Path>]=
, dst: &Path) -> Result<Vec<
              })?
              .to_string_lossy();
=20
@@ -135,11 +94,11 @@ index 2fce90a9da..584e386edd 100644
          let obj =3D dst
              .join(format!("{:016x}-{}", hasher.finish(), basename))
              .with_extension("o");
-diff --git a/vendor/cc-1.1.6/src/command_helpers.rs b/vendor/cc-1.1.6/src/=
command_helpers.rs
-index 910d068242..2b85a66729 100644
---- a/vendor/cc-1.1.6/src/command_helpers.rs
-+++ b/vendor/cc-1.1.6/src/command_helpers.rs
-@@ -282,6 +282,7 @@ fn wait_on_child(
+diff --git a/vendor/cc-1.1.23/src/command_helpers.rs b/vendor/cc-1.1.23/sr=
c/command_helpers.rs
+index 07dfb80412..e01b62fa39 100644
+--- a/vendor/cc-1.1.23/src/command_helpers.rs
++++ b/vendor/cc-1.1.23/src/command_helpers.rs
+@@ -285,6 +285,7 @@ fn wait_on_child(
  /// and store them in the output Object.
  pub(crate) fn objects_from_files(files: &[Arc<Path>], dst: &Path) -> Resu=
lt<Vec<Object>, Error> {
      let mut objects =3D Vec::with_capacity(files.len());
@@ -147,7 +106,7 @@ index 910d068242..2b85a66729 100644
      for file in files {
          let basename =3D file
              .file_name()
-@@ -302,10 +303,29 @@ pub(crate) fn objects_from_files(files: &[Arc<Path>]=
, dst: &Path) -> Result<Vec<
+@@ -305,10 +306,29 @@ pub(crate) fn objects_from_files(files: &[Arc<Path>]=
, dst: &Path) -> Result<Vec<
              })?
              .to_string_lossy();
=20
@@ -186,25 +145,19 @@ index b070eeb322..ba768ff86f 100644
 -{"files":{"Cargo.toml":"3c555dbe1a698f12b66c8a5748ed52ff26ff7b8ebb12237c1=
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
 \ No newline at end of file
 +{"files":{"Cargo.toml":"3c555dbe1a698f12b66c8a5748ed52ff26ff7b8ebb12237c1=
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
---- a/vendor/cc-1.0.97/.cargo-checksum.json
-+++ b/vendor/cc-1.0.97/.cargo-checksum.json
-@@ -1 +1 @@
--{"files":{"Cargo.toml":"5c15212a19ab7432d834b92cc7f6af9461c860fbaf2a756cd=
a9b6f40d7b0e845","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d059=
d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7b2ba9=
6f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25dac0a759=
8e678e9b601a7d99a791069bddaf180dfe","src/command_helpers.rs":"15afbc35930a5=
a53f00d74a8910cff35caeb5511c26642cffe5630377aced901","src/detect_compiler_f=
amily.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd08abf392f5a29"=
,"src/lib.rs":"d805931c886be881ed685c3f75b104e96068c4a7e51f48c9a304b3fdebcf=
dcda","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fee042c16bd65d4=
150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"352a0295c965c68=
4904329d334f3b9889db3a9c3f201701f8db44e4d00e00515","src/parallel/mod.rs":"b=
d9c1334d17d138c281961c690b8d8118a2d6295a7d6cd7296826255436fa063","src/paral=
lel/stderr.rs":"a2d18ba3f2e04deb9047ece9ab7ca5452d9a76b515afbe20a76307e3159=
7f34b","src/target_info.rs":"342be00f6215e161d8163e272a2945bb9f52f171648e15=
e11d46800a73186955","src/tempfile.rs":"47a58e904ac07da6682004b5b615dc83250b=
253a8d3e8ba1b9bcaf6cdf4fd142","src/tool.rs":"b48a7a0efbeb24dc4ccdb4326583ef=
074e69c670330681a5be9d5c19492e5f96","src/windows/com.rs":"be1564756c9f3ef13=
98eafeed7b54ba610caba28e8f6258d28a997737ebf9535","src/windows/find_tools.rs=
":"06aaf9d6247f407cb6077c68d0c9469f64a098eda2222059e7400588e7e05f6a","src/w=
indows/mod.rs":"42f1ad7fee35a17686b003e6aa520d3d1940d47d2f531d626e9ae0c48ba=
49005","src/windows/registry.rs":"c521b72c825e8095843e73482ffa810ed066ad8bb=
9f86e6db0c5c143c171aba1","src/windows/setup_config.rs":"754439cbab492afd44c=
9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/windows/vs_instances.rs=
":"76e3cee74b5fd38ddaf533bba11fe401667c50dda5f9d064099840893eaa7587","src/w=
indows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cfce253dbf2a678b076147c6cd=
b5db046c","src/windows/windows_sys.rs":"5a440eb39d8a0c176b66177e87531867977=
93bc5d7896292c408fb44c12dfed3"},"package":"099a5357d84c4c61eb35fc8eafa9a79a=
902c2f76911e5747ced4e032edd8d9b4"}
-\ No newline at end of file
-+{"files":{"Cargo.toml":"5c15212a19ab7432d834b92cc7f6af9461c860fbaf2a756cd=
a9b6f40d7b0e845","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d059=
d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7b2ba9=
6f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25dac0a759=
8e678e9b601a7d99a791069bddaf180dfe","src/command_helpers.rs":"c2a9981b1c9f5=
430ac2a41f2953064f2383e4064feb281dc76915e4972d52226","src/detect_compiler_f=
amily.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd08abf392f5a29"=
,"src/lib.rs":"d805931c886be881ed685c3f75b104e96068c4a7e51f48c9a304b3fdebcf=
dcda","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fee042c16bd65d4=
150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"352a0295c965c68=
4904329d334f3b9889db3a9c3f201701f8db44e4d00e00515","src/parallel/mod.rs":"b=
d9c1334d17d138c281961c690b8d8118a2d6295a7d6cd7296826255436fa063","src/paral=
lel/stderr.rs":"a2d18ba3f2e04deb9047ece9ab7ca5452d9a76b515afbe20a76307e3159=
7f34b","src/target_info.rs":"342be00f6215e161d8163e272a2945bb9f52f171648e15=
e11d46800a73186955","src/tempfile.rs":"47a58e904ac07da6682004b5b615dc83250b=
253a8d3e8ba1b9bcaf6cdf4fd142","src/tool.rs":"b48a7a0efbeb24dc4ccdb4326583ef=
074e69c670330681a5be9d5c19492e5f96","src/windows/com.rs":"be1564756c9f3ef13=
98eafeed7b54ba610caba28e8f6258d28a997737ebf9535","src/windows/find_tools.rs=
":"06aaf9d6247f407cb6077c68d0c9469f64a098eda2222059e7400588e7e05f6a","src/w=
indows/mod.rs":"42f1ad7fee35a17686b003e6aa520d3d1940d47d2f531d626e9ae0c48ba=
49005","src/windows/registry.rs":"c521b72c825e8095843e73482ffa810ed066ad8bb=
9f86e6db0c5c143c171aba1","src/windows/setup_config.rs":"754439cbab492afd44c=
9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/windows/vs_instances.rs=
":"76e3cee74b5fd38ddaf533bba11fe401667c50dda5f9d064099840893eaa7587","src/w=
indows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cfce253dbf2a678b076147c6cd=
b5db046c","src/windows/windows_sys.rs":"5a440eb39d8a0c176b66177e87531867977=
93bc5d7896292c408fb44c12dfed3"},"package":"099a5357d84c4c61eb35fc8eafa9a79a=
902c2f76911e5747ced4e032edd8d9b4"}
-diff --git a/vendor/cc-1.0.105/.cargo-checksum.json b/vendor/cc-1.0.105/.c=
argo-checksum.json
-index f1ddc06886..880d637ada 100644
---- a/vendor/cc-1.0.105/.cargo-checksum.json
-+++ b/vendor/cc-1.0.105/.cargo-checksum.json
+diff --git a/vendor/cc-1.1.22/.cargo-checksum.json b/vendor/cc-1.1.22/.car=
go-checksum.json
+index 8c7be07836..473b5ad39c 100644
+--- a/vendor/cc-1.1.22/.cargo-checksum.json
++++ b/vendor/cc-1.1.22/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{"CHANGELOG.md":"b6200e753550c2285fd78f5d3d8198d3e67ee01e8504f21=
a4f2ad0c0574d8f19","Cargo.toml":"5f3c7c1de2fa554e02714ae57f7ef0be696c5dda3c=
71f197d2574abf92fd82a7","LICENSE-APACHE":"a60eea817514531668d7e00765731449f=
e14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2=
d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25d=
ac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"2a564c2c1e9a9c46e=
2b667d0b9574e2fda233e3c26dffbcd55373d052f042905","src/command_helpers.rs":"=
7c09d713b9a7ad45ad4fc431206681819465b871e7408573b311e300b1e9e21c","src/dete=
ct_compiler_family.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd0=
8abf392f5a29","src/lib.rs":"3213e05f797701c9da797509512991e18a40455b1d94785=
31640f90d1f13134e","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fe=
e042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"8e=
f38688fdf867606a32500078094e0bb22fb2aec9ae11a392593bbfc101ed4f","src/parall=
el/mod.rs":"bd9c1334d17d138c281961c690b8d8118a2d6295a7d6cd7296826255436fa06=
3","src/parallel/stderr.rs":"a2d18ba3f2e04deb9047ece9ab7ca5452d9a76b515afbe=
20a76307e31597f34b","src/target_info.rs":"342be00f6215e161d8163e272a2945bb9=
f52f171648e15e11d46800a73186955","src/tempfile.rs":"b12a0821586ab3945fe4ff5=
74cd76699c3694a103dbf1b5764fd1fbcbbd7c37e","src/tool.rs":"24291f79784a99060=
2e2244ccf965127088e43bd58745a3829d0d06dddd588b6","src/utilities.rs":"a13bb0=
a351fcef72823485b1b5dc4f514c533fa4feac95deb66ed9e5fbfe7b53","src/windows/co=
m.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd18b795873c7304b3f2a5e3","s=
rc/windows/find_tools.rs":"8eb56f4af6cc40b943e25dba9f26d1629c0c464b2839a6c5=
aa8d3f0b973a649c","src/windows/mod.rs":"34cfa201cfbcac7ccaa3ea5295d3e420043=
9af3cc5c6433baf81502596040a89","src/windows/registry.rs":"c521b72c825e80958=
43e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/windows/setup_config.=
rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src=
/windows/vs_instances.rs":"946527cf8fd32c3472f6a2884dcdec290763101097334c74=
78f9c24c3950db6b","src/windows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cf=
ce253dbf2a678b076147c6cdb5db046c","src/windows/windows_sys.rs":"e2714c8307b=
fa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e34b8","src/windows/windows=
_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d094b7bec217264ba2e6e2c49d1c=
cee"},"package":"5208975e568d83b6b05cc0a063c8e7e9acc2b43bee6da15616a5b73e10=
9d7437"}
+-{"files":{"CHANGELOG.md":"92aeb6dec3e4b55e3951a4d00f6df20edc51545afca124d=
983454f7c05e37357","Cargo.toml":"1352b0476c28b89568e740579130ab017ad0f4b546=
083cf03ff61827d45361f3","LICENSE-APACHE":"a60eea817514531668d7e00765731449f=
e14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2=
d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25d=
ac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"aa7850db4350883c8=
f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb1d","src/command_helpers.rs":"=
0b54800fe5c89cd102a5f872fe1a843c1a58e026bc4bbc611e207914b8c84dda","src/dete=
ct_compiler_family.c":"97ca4b021495611e828becea6187add37414186a16dfedd26c29=
47cbce6e8b2f","src/lib.rs":"c80c94e82937980f711500cd3289842ab4bc42bcc4efd9f=
ebf64729e27410ecc","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fe=
e042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"f4=
ed0a03d89a42bfd5527133d12b267af519b745f3f2b997ed293df15a2641b8","src/parall=
el/mod.rs":"55fb4c2d15e66677b2ed5ffa6d65ea161bcf1a1e1dc7910ee3bde06f2f67ab1=
4","src/parallel/once_lock.rs":"d13e4cb82d6bca3297ca8671d83a40dd5affd7ac891=
91d733dd451867181bb02","src/parallel/stderr.rs":"74384d41198740a6fce0877f14=
4262db09fb091225fa8fbfa771314bb11487c6","src/target_info.rs":"f939a570c99d8=
97fdd37cd491a4ee0657e2c7480ec71acbd9cbee48732d4bfbc","src/tempfile.rs":"eba=
fb5b0e5d08b0706916ed911d4245240e60c3e2d0c9a1630c520842988a2b3","src/tool.rs=
":"2e6550062e021f2b394388172bbb01e86fe6a94d2395bcb3c85a9e86690da1a9","src/u=
tilities.rs":"a13bb0a351fcef72823485b1b5dc4f514c533fa4feac95deb66ed9e5fbfe7=
b53","src/windows/com.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd18b795=
873c7304b3f2a5e3","src/windows/find_tools.rs":"dd6b2450909cd8334a2aa2ce856b=
cc72a9654d92422267d6345d5fabfcbf57c5","src/windows/mod.rs":"34cfa201cfbcac7=
ccaa3ea5295d3e4200439af3cc5c6433baf81502596040a89","src/windows/registry.rs=
":"c521b72c825e8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/w=
indows/setup_config.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df=
13c0e996dbbec8","src/windows/vs_instances.rs":"946527cf8fd32c3472f6a2884dcd=
ec290763101097334c7478f9c24c3950db6b","src/windows/winapi.rs":"250d51c1826d=
1a2329e9889dd9f058cfce253dbf2a678b076147c6cdb5db046c","src/windows/windows_=
sys.rs":"e2714c8307bfa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e34b8",=
"src/windows/windows_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d094b7be=
c217264ba2e6e2c49d1ccee"},"package":"9540e661f81799159abee814118cc139a2004b=
3a3aa3ea37724a1b66530b90e0"}
 \ No newline at end of file
-+{"files":{"CHANGELOG.md":"b6200e753550c2285fd78f5d3d8198d3e67ee01e8504f21=
a4f2ad0c0574d8f19","Cargo.toml":"5f3c7c1de2fa554e02714ae57f7ef0be696c5dda3c=
71f197d2574abf92fd82a7","LICENSE-APACHE":"a60eea817514531668d7e00765731449f=
e14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2=
d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25d=
ac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"2a564c2c1e9a9c46e=
2b667d0b9574e2fda233e3c26dffbcd55373d052f042905","src/command_helpers.rs":"=
7b60816a28486743beec6658f43cdf348d87613193b008f6bcd7a19eb6e24407","src/dete=
ct_compiler_family.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd0=
8abf392f5a29","src/lib.rs":"3213e05f797701c9da797509512991e18a40455b1d94785=
31640f90d1f13134e","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fe=
e042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"8e=
f38688fdf867606a32500078094e0bb22fb2aec9ae11a392593bbfc101ed4f","src/parall=
el/mod.rs":"bd9c1334d17d138c281961c690b8d8118a2d6295a7d6cd7296826255436fa06=
3","src/parallel/stderr.rs":"a2d18ba3f2e04deb9047ece9ab7ca5452d9a76b515afbe=
20a76307e31597f34b","src/target_info.rs":"342be00f6215e161d8163e272a2945bb9=
f52f171648e15e11d46800a73186955","src/tempfile.rs":"b12a0821586ab3945fe4ff5=
74cd76699c3694a103dbf1b5764fd1fbcbbd7c37e","src/tool.rs":"24291f79784a99060=
2e2244ccf965127088e43bd58745a3829d0d06dddd588b6","src/utilities.rs":"a13bb0=
a351fcef72823485b1b5dc4f514c533fa4feac95deb66ed9e5fbfe7b53","src/windows/co=
m.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd18b795873c7304b3f2a5e3","s=
rc/windows/find_tools.rs":"8eb56f4af6cc40b943e25dba9f26d1629c0c464b2839a6c5=
aa8d3f0b973a649c","src/windows/mod.rs":"34cfa201cfbcac7ccaa3ea5295d3e420043=
9af3cc5c6433baf81502596040a89","src/windows/registry.rs":"c521b72c825e80958=
43e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/windows/setup_config.=
rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src=
/windows/vs_instances.rs":"946527cf8fd32c3472f6a2884dcdec290763101097334c74=
78f9c24c3950db6b","src/windows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cf=
ce253dbf2a678b076147c6cdb5db046c","src/windows/windows_sys.rs":"e2714c8307b=
fa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e34b8","src/windows/windows=
_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d094b7bec217264ba2e6e2c49d1c=
cee"},"package":"5208975e568d83b6b05cc0a063c8e7e9acc2b43bee6da15616a5b73e10=
9d7437"}
-diff --git a/vendor/cc-1.1.6/.cargo-checksum.json b/vendor/cc-1.1.6/.cargo=
-checksum.json
-index c8814c0183..7a7af5d2e7 100644
---- a/vendor/cc-1.1.6/.cargo-checksum.json
-+++ b/vendor/cc-1.1.6/.cargo-checksum.json
++{"files":{"CHANGELOG.md":"92aeb6dec3e4b55e3951a4d00f6df20edc51545afca124d=
983454f7c05e37357","Cargo.toml":"1352b0476c28b89568e740579130ab017ad0f4b546=
083cf03ff61827d45361f3","LICENSE-APACHE":"a60eea817514531668d7e00765731449f=
e14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2=
d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25d=
ac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"aa7850db4350883c8=
f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb1d","src/command_helpers.rs":"=
a2ee7ae686b9cb186bebfdd597438251536bcaa9815699c95eab349385b4b949","src/dete=
ct_compiler_family.c":"97ca4b021495611e828becea6187add37414186a16dfedd26c29=
47cbce6e8b2f","src/lib.rs":"c80c94e82937980f711500cd3289842ab4bc42bcc4efd9f=
ebf64729e27410ecc","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fe=
e042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"f4=
ed0a03d89a42bfd5527133d12b267af519b745f3f2b997ed293df15a2641b8","src/parall=
el/mod.rs":"55fb4c2d15e66677b2ed5ffa6d65ea161bcf1a1e1dc7910ee3bde06f2f67ab1=
4","src/parallel/once_lock.rs":"d13e4cb82d6bca3297ca8671d83a40dd5affd7ac891=
91d733dd451867181bb02","src/parallel/stderr.rs":"74384d41198740a6fce0877f14=
4262db09fb091225fa8fbfa771314bb11487c6","src/target_info.rs":"f939a570c99d8=
97fdd37cd491a4ee0657e2c7480ec71acbd9cbee48732d4bfbc","src/tempfile.rs":"eba=
fb5b0e5d08b0706916ed911d4245240e60c3e2d0c9a1630c520842988a2b3","src/tool.rs=
":"2e6550062e021f2b394388172bbb01e86fe6a94d2395bcb3c85a9e86690da1a9","src/u=
tilities.rs":"a13bb0a351fcef72823485b1b5dc4f514c533fa4feac95deb66ed9e5fbfe7=
b53","src/windows/com.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd18b795=
873c7304b3f2a5e3","src/windows/find_tools.rs":"dd6b2450909cd8334a2aa2ce856b=
cc72a9654d92422267d6345d5fabfcbf57c5","src/windows/mod.rs":"34cfa201cfbcac7=
ccaa3ea5295d3e4200439af3cc5c6433baf81502596040a89","src/windows/registry.rs=
":"c521b72c825e8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/w=
indows/setup_config.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df=
13c0e996dbbec8","src/windows/vs_instances.rs":"946527cf8fd32c3472f6a2884dcd=
ec290763101097334c7478f9c24c3950db6b","src/windows/winapi.rs":"250d51c1826d=
1a2329e9889dd9f058cfce253dbf2a678b076147c6cdb5db046c","src/windows/windows_=
sys.rs":"e2714c8307bfa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e34b8",=
"src/windows/windows_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d094b7be=
c217264ba2e6e2c49d1ccee"},"package":"9540e661f81799159abee814118cc139a2004b=
3a3aa3ea37724a1b66530b90e0"}
+diff --git a/vendor/cc-1.1.23/.cargo-checksum.json b/vendor/cc-1.1.23/.car=
go-checksum.json
+index d834145136..a10eecf785 100644
+--- a/vendor/cc-1.1.23/.cargo-checksum.json
++++ b/vendor/cc-1.1.23/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{"CHANGELOG.md":"27c152bba5a9e4aa5f8075f618fec105590804ba75dd458=
1bb54cdcf3d719e91","Cargo.toml":"a772649c4058df65a5977d7c2d37afdbb7bcf68f3b=
47428acef6502158c0f1c4","LICENSE-APACHE":"a60eea817514531668d7e00765731449f=
e14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2=
d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25d=
ac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"aa7850db4350883c8=
f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb1d","src/command_helpers.rs":"=
5b765fc5bf3ff7367aa6acf67be465bdc776b22c090d3bbfe11816bd023c7a18","src/dete=
ct_compiler_family.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd0=
8abf392f5a29","src/lib.rs":"2f6d061032899f2e60e3932041c353d327ba6f27c7eb747=
fd37f8d18a750e6a0","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fe=
e042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"f4=
ed0a03d89a42bfd5527133d12b267af519b745f3f2b997ed293df15a2641b8","src/parall=
el/mod.rs":"55fb4c2d15e66677b2ed5ffa6d65ea161bcf1a1e1dc7910ee3bde06f2f67ab1=
4","src/parallel/once_lock.rs":"d13e4cb82d6bca3297ca8671d83a40dd5affd7ac891=
91d733dd451867181bb02","src/parallel/stderr.rs":"74384d41198740a6fce0877f14=
4262db09fb091225fa8fbfa771314bb11487c6","src/target_info.rs":"342be00f6215e=
161d8163e272a2945bb9f52f171648e15e11d46800a73186955","src/tempfile.rs":"eba=
fb5b0e5d08b0706916ed911d4245240e60c3e2d0c9a1630c520842988a2b3","src/tool.rs=
":"f5d8d343be6db681605ad5e9adab9f10c19b9d772af241da285ddbe54740486d","src/u=
tilities.rs":"a13bb0a351fcef72823485b1b5dc4f514c533fa4feac95deb66ed9e5fbfe7=
b53","src/windows/com.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd18b795=
873c7304b3f2a5e3","src/windows/find_tools.rs":"a03cd94d7a36deb0e4490d9ce070=
624a0e79f082cdfc4c32f52a8cbe557fd0b5","src/windows/mod.rs":"34cfa201cfbcac7=
ccaa3ea5295d3e4200439af3cc5c6433baf81502596040a89","src/windows/registry.rs=
":"c521b72c825e8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/w=
indows/setup_config.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df=
13c0e996dbbec8","src/windows/vs_instances.rs":"946527cf8fd32c3472f6a2884dcd=
ec290763101097334c7478f9c24c3950db6b","src/windows/winapi.rs":"250d51c1826d=
1a2329e9889dd9f058cfce253dbf2a678b076147c6cdb5db046c","src/windows/windows_=
sys.rs":"e2714c8307bfa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e34b8",=
"src/windows/windows_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d094b7be=
c217264ba2e6e2c49d1ccee"},"package":"2aba8f4e9906c7ce3c73463f62a7f0c65183ad=
a1a2d47e397cc8810827f9694f"}
+-{"files":{"CHANGELOG.md":"c0125e3e52f1af277dd92935d84992fcff829ecd11a4bad=
6ac75bced3c68623b","Cargo.toml":"1b08a0bb920345c02a78f49be0a091ac426dbfe1bf=
a4b853da0c177acda36582","LICENSE-APACHE":"a60eea817514531668d7e00765731449f=
e14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2=
d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25d=
ac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"aa7850db4350883c8=
f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb1d","src/command_helpers.rs":"=
0b54800fe5c89cd102a5f872fe1a843c1a58e026bc4bbc611e207914b8c84dda","src/dete=
ct_compiler_family.c":"97ca4b021495611e828becea6187add37414186a16dfedd26c29=
47cbce6e8b2f","src/lib.rs":"41f2bc5d9c29a842688dfdbea60241d0efa49229d1cf654=
06225782f54866d19","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fe=
e042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"f4=
ed0a03d89a42bfd5527133d12b267af519b745f3f2b997ed293df15a2641b8","src/parall=
el/mod.rs":"55fb4c2d15e66677b2ed5ffa6d65ea161bcf1a1e1dc7910ee3bde06f2f67ab1=
4","src/parallel/once_lock.rs":"d13e4cb82d6bca3297ca8671d83a40dd5affd7ac891=
91d733dd451867181bb02","src/parallel/stderr.rs":"74384d41198740a6fce0877f14=
4262db09fb091225fa8fbfa771314bb11487c6","src/target_info.rs":"f939a570c99d8=
97fdd37cd491a4ee0657e2c7480ec71acbd9cbee48732d4bfbc","src/tempfile.rs":"eba=
fb5b0e5d08b0706916ed911d4245240e60c3e2d0c9a1630c520842988a2b3","src/tool.rs=
":"2e6550062e021f2b394388172bbb01e86fe6a94d2395bcb3c85a9e86690da1a9","src/u=
tilities.rs":"a13bb0a351fcef72823485b1b5dc4f514c533fa4feac95deb66ed9e5fbfe7=
b53","src/windows/com.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd18b795=
873c7304b3f2a5e3","src/windows/find_tools.rs":"dd6b2450909cd8334a2aa2ce856b=
cc72a9654d92422267d6345d5fabfcbf57c5","src/windows/mod.rs":"34cfa201cfbcac7=
ccaa3ea5295d3e4200439af3cc5c6433baf81502596040a89","src/windows/registry.rs=
":"c521b72c825e8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/w=
indows/setup_config.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df=
13c0e996dbbec8","src/windows/vs_instances.rs":"946527cf8fd32c3472f6a2884dcd=
ec290763101097334c7478f9c24c3950db6b","src/windows/winapi.rs":"250d51c1826d=
1a2329e9889dd9f058cfce253dbf2a678b076147c6cdb5db046c","src/windows/windows_=
sys.rs":"e2714c8307bfa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e34b8",=
"src/windows/windows_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d094b7be=
c217264ba2e6e2c49d1ccee"},"package":"3bbb537bb4a30b90362caddba8f360c0a56bc1=
3d3a5570028e7197204cb54a17"}
 \ No newline at end of file
-+{"files":{"CHANGELOG.md":"27c152bba5a9e4aa5f8075f618fec105590804ba75dd458=
1bb54cdcf3d719e91","Cargo.toml":"a772649c4058df65a5977d7c2d37afdbb7bcf68f3b=
47428acef6502158c0f1c4","LICENSE-APACHE":"a60eea817514531668d7e00765731449f=
e14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2=
d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25d=
ac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"aa7850db4350883c8=
f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb1d","src/command_helpers.rs":"=
36e27f089f0e9276bb9a5ebe9b5c4706c560106ffa5652b1e08e8285816910c3","src/dete=
ct_compiler_family.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd0=
8abf392f5a29","src/lib.rs":"2f6d061032899f2e60e3932041c353d327ba6f27c7eb747=
fd37f8d18a750e6a0","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fe=
e042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"f4=
ed0a03d89a42bfd5527133d12b267af519b745f3f2b997ed293df15a2641b8","src/parall=
el/mod.rs":"55fb4c2d15e66677b2ed5ffa6d65ea161bcf1a1e1dc7910ee3bde06f2f67ab1=
4","src/parallel/once_lock.rs":"d13e4cb82d6bca3297ca8671d83a40dd5affd7ac891=
91d733dd451867181bb02","src/parallel/stderr.rs":"74384d41198740a6fce0877f14=
4262db09fb091225fa8fbfa771314bb11487c6","src/target_info.rs":"342be00f6215e=
161d8163e272a2945bb9f52f171648e15e11d46800a73186955","src/tempfile.rs":"eba=
fb5b0e5d08b0706916ed911d4245240e60c3e2d0c9a1630c520842988a2b3","src/tool.rs=
":"f5d8d343be6db681605ad5e9adab9f10c19b9d772af241da285ddbe54740486d","src/u=
tilities.rs":"a13bb0a351fcef72823485b1b5dc4f514c533fa4feac95deb66ed9e5fbfe7=
b53","src/windows/com.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd18b795=
873c7304b3f2a5e3","src/windows/find_tools.rs":"a03cd94d7a36deb0e4490d9ce070=
624a0e79f082cdfc4c32f52a8cbe557fd0b5","src/windows/mod.rs":"34cfa201cfbcac7=
ccaa3ea5295d3e4200439af3cc5c6433baf81502596040a89","src/windows/registry.rs=
":"c521b72c825e8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/w=
indows/setup_config.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df=
13c0e996dbbec8","src/windows/vs_instances.rs":"946527cf8fd32c3472f6a2884dcd=
ec290763101097334c7478f9c24c3950db6b","src/windows/winapi.rs":"250d51c1826d=
1a2329e9889dd9f058cfce253dbf2a678b076147c6cdb5db046c","src/windows/windows_=
sys.rs":"e2714c8307bfa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e34b8",=
"src/windows/windows_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d094b7be=
c217264ba2e6e2c49d1ccee"},"package":"2aba8f4e9906c7ce3c73463f62a7f0c65183ad=
a1a2d47e397cc8810827f9694f"}
++{"files":{"CHANGELOG.md":"c0125e3e52f1af277dd92935d84992fcff829ecd11a4bad=
6ac75bced3c68623b","Cargo.toml":"1b08a0bb920345c02a78f49be0a091ac426dbfe1bf=
a4b853da0c177acda36582","LICENSE-APACHE":"a60eea817514531668d7e00765731449f=
e14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2=
d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25d=
ac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"aa7850db4350883c8=
f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb1d","src/command_helpers.rs":"=
a2ee7ae686b9cb186bebfdd597438251536bcaa9815699c95eab349385b4b949","src/dete=
ct_compiler_family.c":"97ca4b021495611e828becea6187add37414186a16dfedd26c29=
47cbce6e8b2f","src/lib.rs":"41f2bc5d9c29a842688dfdbea60241d0efa49229d1cf654=
06225782f54866d19","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fe=
e042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"f4=
ed0a03d89a42bfd5527133d12b267af519b745f3f2b997ed293df15a2641b8","src/parall=
el/mod.rs":"55fb4c2d15e66677b2ed5ffa6d65ea161bcf1a1e1dc7910ee3bde06f2f67ab1=
4","src/parallel/once_lock.rs":"d13e4cb82d6bca3297ca8671d83a40dd5affd7ac891=
91d733dd451867181bb02","src/parallel/stderr.rs":"74384d41198740a6fce0877f14=
4262db09fb091225fa8fbfa771314bb11487c6","src/target_info.rs":"f939a570c99d8=
97fdd37cd491a4ee0657e2c7480ec71acbd9cbee48732d4bfbc","src/tempfile.rs":"eba=
fb5b0e5d08b0706916ed911d4245240e60c3e2d0c9a1630c520842988a2b3","src/tool.rs=
":"2e6550062e021f2b394388172bbb01e86fe6a94d2395bcb3c85a9e86690da1a9","src/u=
tilities.rs":"a13bb0a351fcef72823485b1b5dc4f514c533fa4feac95deb66ed9e5fbfe7=
b53","src/windows/com.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd18b795=
873c7304b3f2a5e3","src/windows/find_tools.rs":"dd6b2450909cd8334a2aa2ce856b=
cc72a9654d92422267d6345d5fabfcbf57c5","src/windows/mod.rs":"34cfa201cfbcac7=
ccaa3ea5295d3e4200439af3cc5c6433baf81502596040a89","src/windows/registry.rs=
":"c521b72c825e8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/w=
indows/setup_config.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df=
13c0e996dbbec8","src/windows/vs_instances.rs":"946527cf8fd32c3472f6a2884dcd=
ec290763101097334c7478f9c24c3950db6b","src/windows/winapi.rs":"250d51c1826d=
1a2329e9889dd9f058cfce253dbf2a678b076147c6cdb5db046c","src/windows/windows_=
sys.rs":"e2714c8307bfa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e34b8",=
"src/windows/windows_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d094b7be=
c217264ba2e6e2c49d1ccee"},"package":"3bbb537bb4a30b90362caddba8f360c0a56bc1=
3d3a5570028e7197204cb54a17"}
diff --git a/recipes-devtools/rust/files/revert-Zdual-proc-macros-additiona=
l-check.patch b/recipes-devtools/rust/files/revert-Zdual-proc-macros-additi=
onal-check.patch
new file mode 100644
index 0000000..58e77e4
--- /dev/null
+++ b/recipes-devtools/rust/files/revert-Zdual-proc-macros-additional-check=
.patch
@@ -0,0 +1,43 @@
+rust: Fix build failure for v1.83 when lib32 enabled
+
+Because of the following commit ,
+https://github.com/rust-lang/rust/commit/68034f837a39387e49fc7d7c5b088f537=
2a1127e
+when we enable lib32, getting build failure because there is a check for t=
arget
+support for "-Zdual-proc-macros" flag not functioning properly when lib32 =
is
+enabled in the build environment. So for now reverting this commit and bri=
ng
+back the previous behavior, where the "-Zdual-proc-macros" flag is always
+added for building proc macros, regardless of the target architecture's su=
pport.
+This would bypass the check introduced in the patch, allowing the build to
+proceed without error, even when building for a 64-bit architecture with l=
ib32 enabled.
+
+Upstream-Status: Pending
+
+Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
+diff --git a/src/bootstrap/src/core/builder.rs b/src/bootstrap/src/core/bu=
ilder.rs
+index 9ac0b0a01f..b1374042fb 100644
+--- a/src/bootstrap/src/core/builder.rs
++++ b/src/bootstrap/src/core/builder.rs
+@@ -1701,21 +1701,8 @@ impl<'a> Builder<'a> {
+                 // Build proc macros both for the host and the target unl=
ess proc-macros are not
+                 // supported by the target.
+                 if target !=3D compiler.host && cmd_kind !=3D Kind::Check=
 {
+-                    let error =3D command(self.rustc(compiler))
+-                        .arg("--target")
+-                        .arg(target.rustc_target_arg())
+-                        .arg("--print=3Dfile-names")
+-                        .arg("--crate-type=3Dproc-macro")
+-                        .arg("-")
+-                        .run_capture(self)
+-                        .stderr();
+-                    let not_supported =3D error
+-                        .lines()
+-                        .any(|line| line.contains("unsupported crate type=
 `proc-macro`"));
+-                    if !not_supported {
+-                        cargo.arg("-Zdual-proc-macros");
+-                        rustflags.arg("-Zdual-proc-macros");
+-                    }
++                    cargo.arg("-Zdual-proc-macros");
++                    rustflags.arg("-Zdual-proc-macros");
+                 }
+             }
+         }
diff --git a/recipes-devtools/rust/files/revert-link-std-statically-in-rust=
c_driver-feature.patch b/recipes-devtools/rust/files/revert-link-std-static=
ally-in-rustc_driver-feature.patch
index 257883e..407d701 100644
--- a/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_drive=
r-feature.patch
+++ b/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_drive=
r-feature.patch
@@ -104,7 +104,7 @@ diff --git a/src/bootstrap/src/bin/rustc.rs b/src/boots=
trap/src/bin/rustc.rs
 index d04e2fbeb7..011c289d93 100644
 --- a/src/bootstrap/src/bin/rustc.rs
 +++ b/src/bootstrap/src/bin/rustc.rs
-@@ -89,25 +89,6 @@ fn main() {
+@@ -89,24 +89,6 @@ fn main() {
          rustc_real
      };
=20
@@ -114,7 +114,6 @@ index d04e2fbeb7..011c289d93 100644
 -    // When statically linking `std` into `rustc_driver`, remove `-C pref=
er-dynamic`
 -    if env::var("RUSTC_LINK_STD_INTO_RUSTC_DRIVER").unwrap() =3D=3D "1"
 -        && crate_name =3D=3D Some("rustc_driver")
--        && stage !=3D "0"
 -    {
 -        if let Some(pos) =3D args.iter().enumerate().position(|(i, a)| {
 -            a =3D=3D "-C" && args.get(i + 1).map(|a| a =3D=3D "prefer-dyn=
amic").unwrap_or(false)
@@ -130,7 +129,7 @@ index d04e2fbeb7..011c289d93 100644
      let mut cmd =3D match env::var_os("RUSTC_WRAPPER_REAL") {
          Some(wrapper) if !wrapper.is_empty() =3D> {
              let mut cmd =3D Command::new(wrapper);
-@@ -118,6 +99,9 @@ fn main() {
+@@ -117,6 +99,9 @@ fn main() {
      };
      cmd.args(&args).env(dylib_path_var(), env::join_paths(&dylib_path).un=
wrap());
=20
@@ -144,7 +143,7 @@ diff --git a/src/bootstrap/src/core/builder.rs b/src/bo=
otstrap/src/core/builder.
 index ff0d1f3a72..b2c9602e57 100644
 --- a/src/bootstrap/src/core/builder.rs
 +++ b/src/bootstrap/src/core/builder.rs
-@@ -2153,7 +2153,7 @@ impl<'a> Builder<'a> {
+@@ -2201,7 +2201,7 @@ impl<'a> Builder<'a> {
          // When we build Rust dylibs they're all intended for intermediate
          // usage, so make sure we pass the -Cprefer-dynamic flag instead =
of
          // linking all deps statically into the dylib.
@@ -197,3 +196,33 @@ index b8b0432aa9..b5bd71e015 100644
  use std::env;
  use std::io::stdout;
  use std::path::{Path, PathBuf};
+diff --git a/src/bootstrap/src/core/build_steps/compile.rs b/src/bootstrap=
/src/core/build_steps/compile.rs
+index 27bbc8bd8f..a6fc4df2eb 100644
+--- a/src/bootstrap/src/core/build_steps/compile.rs
++++ b/src/bootstrap/src/core/build_steps/compile.rs
+@@ -1934,24 +1934,8 @@ impl Step for Assemble {
+         let src_libdir =3D builder.sysroot_libdir(build_compiler, host);
+         for f in builder.read_dir(&src_libdir) {
+             let filename =3D f.file_name().into_string().unwrap();
+-
+-            let is_proc_macro =3D proc_macros.contains(&filename);
+-            let is_dylib_or_debug =3D is_dylib(&filename) || is_debug_inf=
o(&filename);
+-
+-            // If we link statically to stdlib, do not copy the libstd dy=
namic library file
+-            // FIXME: Also do this for Windows once incremental post-opti=
mization stage0 tests
+-            // work without std.dll (see https://github.com/rust-lang/rus=
t/pull/131188).
+-            let can_be_rustc_dynamic_dep =3D if builder
+-                .link_std_into_rustc_driver(target_compiler.host)
+-                && !target_compiler.host.is_windows()
++            if (is_dylib(&filename) || is_debug_info(&filename)) && !proc=
_macros.contains(&filename)
+             {
+-                let is_std =3D filename.starts_with("std-") || filename.s=
tarts_with("libstd-");
+-                !is_std
+-            } else {
+-                true
+-            };
+-
+-            if is_dylib_or_debug && can_be_rustc_dynamic_dep && !is_proc_=
macro {
+                 builder.copy_link(&f.path(), &rustc_libdir.join(&filename=
));
+             }
+         }
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-d=
evtools/rust/files/rust-oe-selftest.patch
index 0e952ef..b2bfed0 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -63,7 +63,7 @@ index 35a5291a347..5f2858d2505 100644
=20
  #[test]
 +#[ignore]
- #[cfg_attr(target_os =3D "emscripten", ignore)]
+ #[cfg_attr(any(target_os =3D "emscripten", target_os =3D "wasi"), ignore)=
] // no threads
  fn panic_in_write_doesnt_flush_in_drop() {
      static WRITES: AtomicUsize =3D AtomicUsize::new(0);
 diff --git a/library/std/src/io/stdio/tests.rs b/library/std/src/io/stdio/=
tests.rs
@@ -75,7 +75,7 @@ index f89fd27ce6c..79737f5b127 100644
=20
  #[test]
 +#[ignore]
- #[cfg_attr(target_os =3D "emscripten", ignore)]
+ #[cfg_attr(any(target_os =3D "emscripten", target_os =3D "wasi"), ignore)=
] // no threads
  fn panic_doesnt_poison() {
      thread::spawn(|| {
 diff --git a/library/std/src/sync/mpsc/sync_tests.rs b/library/std/src/syn=
c/mpsc/sync_tests.rs
@@ -318,17 +318,6 @@ index 5d6b9e94ee9..a5aacb2eb87 100644
  fn test_try_panic_any_message_unit_struct() {
      struct Juju;
=20
-diff --git a/library/alloc/src/slice/tests.rs b/library/alloc/src/slice/te=
sts.rs
---- a/library/alloc/src/slice/tests.rs
-+++ b/library/alloc/src/slice/tests.rs
-@@ -186,6 +186,7 @@
- std::thread_local!(static SILENCE_PANIC: Cell<bool> =3D Cell::new(false));
-
- #[test]
-+#[ignore]
- #[cfg_attr(target_os =3D "emscripten", ignore)] // no threads
- #[cfg_attr(not(panic =3D "unwind"), ignore =3D "test requires unwinding s=
upport")]
- fn panic_safe() {
 diff --git a/library/test/src/tests.rs b/library/test/src/tests.rs
 --- a/library/test/src/tests.rs
 +++ b/library/test/src/tests.rs
diff --git a/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.34-fix.patc=
h b/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.34-fix.patch
deleted file mode 100644
index f364267..0000000
--- a/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.34-fix.patch
+++ /dev/null
@@ -1,78 +0,0 @@
-Fix cargo build on riscv32
-
-riscv32 support is added to latest rustix already
-therefore this patch is limited to rustix-0.38.19
-once cargo/rust moves beyond rustix-0.38.19 as dependency
-we can remove this patch
-
-Upstream-Status: Inappropriate [Specific to rustix-0.38.19]
-
-Signed-off-by: Khem Raj <raj.khem@gmail.com>
-
-diff --git a/vendor/rustix-0.38.34/src/backend/libc/termios/syscalls.rs b/=
vendor/rustix-0.38.34/src/backend/libc/termios/syscalls.rs
-index a833aea8d1..71b4c6abd7 100644
---- a/vendor/rustix-0.38.34/src/backend/libc/termios/syscalls.rs
-+++ b/vendor/rustix-0.38.34/src/backend/libc/termios/syscalls.rs
-@@ -147,7 +147,7 @@ pub(crate) fn tcsetattr(
-         use crate::utils::default_array;
-         use linux_raw_sys::general::{termios2, BOTHER, CBAUD, IBSHIFT};
-
--        #[cfg(not(any(target_arch =3D "sparc", target_arch =3D "sparc64")=
))]
-+        #[cfg(not(any(target_arch =3D "sparc", target_arch =3D "sparc64",=
 target_arch =3D "riscv32")))]
-         use linux_raw_sys::ioctl::{TCSETS, TCSETS2};
-
-         // linux-raw-sys' ioctl-generation script for sparc isn't working=
 yet,
-@@ -156,6 +156,10 @@ pub(crate) fn tcsetattr(
-         const TCSETS: u32 =3D 0x8024_5409;
-         #[cfg(any(target_arch =3D "sparc", target_arch =3D "sparc64"))]
-         const TCSETS2: u32 =3D 0x802c_540d;
-+        #[cfg(any(target_arch =3D "riscv32"))]
-+        const TCSETS: u32 =3D 0x5402;
-+        #[cfg(any(target_arch =3D "riscv32"))]
-+        const TCSETS2: u32 =3D 0x402C542B;
-
-         // Translate from `optional_actions` into an ioctl request code. =
On
-         // MIPS, `optional_actions` already has `TCGETS` added to it.
-diff --git a/vendor/rustix-0.38.34/src/fs/ioctl.rs b/vendor/rustix-0.38.34=
/src/fs/ioctl.rs
-index 490f183ff4..d131cfcb51 100644
---- a/vendor/rustix-0.38.34/src/fs/ioctl.rs
-+++ b/vendor/rustix-0.38.34/src/fs/ioctl.rs
-@@ -50,7 +50,7 @@ pub fn ioctl_blkpbszget<Fd: AsFd>(fd: Fd) -> io::Result<=
u32> {
- ///  - [Linux]
- ///
- /// [Linux]: https://man7.org/linux/man-pages/man2/ioctl_ficlone.2.html
--#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
-+#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
- #[inline]
- #[doc(alias =3D "FICLONE")]
- pub fn ioctl_ficlone<Fd: AsFd, SrcFd: AsFd>(fd: Fd, src_fd: SrcFd) -> io:=
:Result<()> {
-@@ -79,7 +79,7 @@ unsafe impl ioctl::Ioctl for Ficlone<'_> {
-     type Output =3D ();
-
-     const IS_MUTATING: bool =3D false;
--    const OPCODE: ioctl::Opcode =3D ioctl::Opcode::old(c::FICLONE as ioct=
l::RawOpcode);
-+    const OPCODE: ioctl::Opcode =3D ioctl::Opcode::old(linux_raw_sys::ioc=
tl::FICLONE as ioctl::RawOpcode);
-
-     fn as_ptr(&mut self) -> *mut c::c_void {
-         self.0.as_raw_fd() as *mut c::c_void
-diff --git a/vendor/rustix-0.38.34/src/backend/libc/c.rs b/vendor/rustix-0=
.38.34/src/backend/libc/c.rs
-index 02958698c0..27f5eb7c86 100644
---- a/vendor/rustix-0.38.34/src/backend/libc/c.rs
-+++ b/vendor/rustix-0.38.34/src/backend/libc/c.rs
-@@ -6,6 +6,8 @@
- // things below.
- pub(crate) use libc::*;
-
-+use linux_raw_sys::ioctl::FICLONE;
-+
- /// `PROC_SUPER_MAGIC`=E2=80=94The magic number for the procfs filesystem.
- #[cfg(all(linux_kernel, target_env =3D "musl"))]
- pub(crate) const PROC_SUPER_MAGIC: u32 =3D 0x0000_9fa0;
-diff --git a/vendor/rustix-0.38.34/.cargo-checksum.json b/vendor/rustix-0.=
38.34/.cargo-checksum.json
-index 487061f297..42d107a480 100644
---- a/vendor/rustix-0.38.34/.cargo-checksum.json
-+++ b/vendor/rustix-0.38.34/.cargo-checksum.json
-@@ -1 +1 @@
--{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231d2=
fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b0532d=
35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"42d204101e647da4dde122=
0b6653dfa647b07a58143b5db4f893a32c871f696c","LICENSE-APACHE":"a60eea8175145=
31668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2.0_WI=
TH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39ef1f9=
4f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a715d9d2=
b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12ba79e=
4cebb6983a7b6491949750aecc4f2178","README.md":"cec45686b62cb75ef2f0c851939b=
7ddcb64678c27c18c7bca18d6f5cde2446d3","SECURITY.md":"4d75afb09dd28eb5982e3a=
1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e67273aa0=
a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"ca1a2e173b=
669f8e13b4e830f3b20530996fe2d60f22f2609ced1a7032affd0f","src/backend/libc/c=
.rs":"9c040c6f914607580d84fddc62fd6fd03cf14976085000116a603404dbc433d0","sr=
c/backend/libc/conv.rs":"a254fa84164286ee6be64f49b5bd5f7e2fd503ebd5ca9076da=
d4c2507a351dc2","src/backend/libc/event/epoll.rs":"93d3eb9e0e397afc3c44797b=
315ce92ff8b22f2372812b19cec9e063c55032c3","src/backend/libc/event/mod.rs":"=
ad30f99f7da0768c18fffac6ec71e658bfed2e44f0634f48c2e0ffe4677ec231","src/back=
end/libc/event/poll_fd.rs":"286268c0e94bc1716a61835ef3c6324e8f3feb96ae2491a=
d5ed919300e80070e","src/backend/libc/event/syscalls.rs":"f91bbe7d222987c89a=
2647817f6819dd536cbc4a685dfb794f403543c32df777","src/backend/libc/event/typ=
es.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f13","=
src/backend/libc/event/windows_syscalls.rs":"ebfac665c6676c4b803134ab8806be=
8aa2e96bdbc7799a19c544cd9069b35787","src/backend/libc/fs/dir.rs":"3c43768f9=
e56cb4297594c05d91a52be20029dd2b3e0b91f6b1a13f31e595fe2","src/backend/libc/=
fs/inotify.rs":"a027a718db8bf6ff9a778c2cfa706850b466240b0a2296d72b9834c0096=
968e8","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f329ad3=
5bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803011b5=
7da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc/fs/s=
yscalls.rs":"89cdd809e0cd89fb4f85e2ba0716ecf857ccb66db69a7fc40a5e0a25b15b39=
d3","src/backend/libc/fs/types.rs":"cae37a0a3099b8e400a48927c60c15efe0d05d2=
e71f78577742f8f7cede62dfd","src/backend/libc/io/errno.rs":"bac592ece7b44692=
237a350ff4905bfad30fa042d1e8126e5229e02913fb1c9d","src/backend/libc/io/mod.=
rs":"746647bd864e4ec7717925b6d176cebdb392b7d015070244cc48d92780351dd6","src=
/backend/libc/io/syscalls.rs":"c93a7867fc13eecc953c6335fd79c37d4d1734d3a06e=
13e5d7e08bd985c66326","src/backend/libc/io/types.rs":"2efd39bb3df19a9db5496=
217284f3d2235ddb354fac81dd71861109a56bede0b","src/backend/libc/io/windows_s=
yscalls.rs":"fab3fa099aa89cea56a6edc651dd37750e581534f4f45b04a7e425f130b084=
68","src/backend/libc/io_uring/mod.rs":"2c6478857a0751625edabd61acb841819bf=
ba1093b1faeded15693c805d84952","src/backend/libc/io_uring/syscalls.rs":"5af=
8146d5971c833e6fd657f652c618b31f854e1b0811864fba9b658cb633e19","src/backend=
/libc/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/mm/syscalls.rs":"c04c61ad3d7f3b24d13f89144d7fa0a=
05658cea4763207f9250db4f9362de2fe","src/backend/libc/mm/types.rs":"55478e17=
3b7d82e2c85934fc0dda79c29f46a305228df78f1e90c68ac9d3cfec","src/backend/libc=
/mod.rs":"087d2676df88510b089255053a4865e62c64172723588386fe8244d2f1a681c4"=
,"src/backend/libc/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287=
b25a5bfe489fa1d07f7cfd7","src/backend/libc/mount/syscalls.rs":"d2d35f7ae989=
bb52722e28cdbd775243c5d7da9eb411e0b2b9632f2aa7c1533e","src/backend/libc/mou=
nt/types.rs":"bf1d541daa248aa023bf18aec7645f2f8c402ac4aa1df2f55b8a784057c2e=
113","src/backend/libc/net/addr.rs":"9bdc2febb20785bc26a820eaba52cb546c67c7=
9cb547f08105087cd0f79d5861","src/backend/libc/net/ext.rs":"0dd64877abe1ba86=
b47a2ab34340e3f6cc7b53b22d0bb5e237daf6a82edd46b0","src/backend/libc/net/mod=
.rs":"562d23225d6dba8f095e3ca41af60dcf6cc40c2cf17bf028f90888f809e86f07","sr=
c/backend/libc/net/msghdr.rs":"6f8aba792b4adef5c5d3d4324a813a67a063a50d1043=
7bb19bf7496666bd6de6","src/backend/libc/net/netdevice.rs":"c6c3cd11b0181a74=
243705438fbf0fedeb02d4201ff3ad9f45a084fbd57a9c21","src/backend/libc/net/rea=
d_sockaddr.rs":"61fc1c744b376d57a18d78d8f7ab469236c614f5fa7aeaf37a636e6a967=
b9066","src/backend/libc/net/send_recv.rs":"1450ca958431a5bf3a85cdeef88b387=
f30d5c1215de2c56d164ccda38f21b36c","src/backend/libc/net/sockopt.rs":"d53d5=
2f1c55f522c1d0de5e446df3017757b08270c0a0b593a583fd6c56b0876","src/backend/l=
ibc/net/syscalls.rs":"1412f9deed57ac0909b0b1c3ac3e5fb7d5c31ab356212c9131e33=
378c342d2a5","src/backend/libc/net/write_sockaddr.rs":"bee221d0a1fedf4ddcff=
045faa2702c1f1e68b4d6c3f2f7b079d888e0ef9da56","src/backend/libc/param/auxv.=
rs":"1877fd1dac415b58a4ae824ef9abd8b49756f613f6915820223f2c586fb4d254","src=
/backend/libc/param/mod.rs":"5234b8f1bcb886cca6ea003d411d75eaeebe58deedd80e=
3441354bf46ed85d4d","src/backend/libc/pid/mod.rs":"2c6478857a0751625edabd61=
acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/pid/syscalls.rs=
":"49ea679b96c0741d048e82964038f9a931bc3cf3a0b59c7db3df89629b9c49e6","src/b=
ackend/libc/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe=
489fa1d07f7cfd7","src/backend/libc/pipe/syscalls.rs":"8affde100f6a9dfc762b7=
9d1e48be5c1039be414f8ef7d5a6acaba882a68d259","src/backend/libc/pipe/types.r=
s":"9826013bc5fa18acdcbf09c650b96ce301a18ec009139ebaf79162669b1fc2c8","src/=
backend/libc/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faed=
ed15693c805d84952","src/backend/libc/prctl/syscalls.rs":"8a2684f444a7555098=
dce2b92270d81cefdae902716c6e5d59bd7b0657e8a29d","src/backend/libc/process/c=
pu_set.rs":"5fca2b47289a2bb6ba908c910a6d27ac78ac10ea21d3c0c018f72f8816c5b9d=
7","src/backend/libc/process/mod.rs":"806e26da8d1e7afae502987fcd650f4d348da=
147b8a2e74447affdca153e2e97","src/backend/libc/process/syscalls.rs":"f08a76=
a5f32e40a69c99261eeabb405a58476ef9e85ae142f2fce19679a42ec4","src/backend/li=
bc/process/types.rs":"fb2caf34b17079aa72c04aed0f9a31d534ea8e8b73a80c758b748=
bf5e38df52b","src/backend/libc/process/wait.rs":"0cc556aed976b4bbb3965f74fd=
76b8216c755fce25043b7b21ce54afa07c9773","src/backend/libc/pty/mod.rs":"2c64=
78857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/=
libc/pty/syscalls.rs":"566fc9a2cb2e38d7d7ac2405b22c0522369cae4a8f4fe18b5512=
3ba94d3d5a95","src/backend/libc/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f=
4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/rand/syscalls.rs":"3=
5ea6b6e0f8a7fb064fd5cb33a3a855cd161a6a00f93d76c861b2a2c66db85e7","src/backe=
nd/libc/rand/types.rs":"4eb0b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a705ec6=
05b773f63f880","src/backend/libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f=
4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/shm/syscalls.rs":"60=
d797d4e85e08e6330e6b8d80094356ce377e5484952f88ae2a6e49231c268c","src/backen=
d/libc/shm/types.rs":"2206eac8ee74951b995e1e80f10bf235cc6b04e0a099f4adefce5=
46378838233","src/backend/libc/system/mod.rs":"38563ea68829ca5a4b1b0695ac8a=
5c05718e85bdc88a36dc805efdfce45d3909","src/backend/libc/system/syscalls.rs"=
:"c18c2942811ea93af3125b58d00a1da05c54e5ff438a3dc44cda53bc9d6fcf03","src/ba=
ckend/libc/system/types.rs":"6871e16aee14fe2ae03cea798c3e509ffe44778a9c0e56=
08fd73e2e015876d7e","src/backend/libc/termios/mod.rs":"2c6478857a0751625eda=
bd61acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/termios/sys=
calls.rs":"f377dfbf501fbc3cdbc9e190dd650c8141c00c1593b8c62901ecf346a0c1a7c5=
","src/backend/libc/thread/futex.rs":"b666828653b12634bbd7fd709acf69641b648=
ec40962a1d4f904c5db14d2eff5","src/backend/libc/thread/mod.rs":"fa710053974d=
7f16a6c49242ee6c10a3b9e1143452b9daeaed8837302a679fff","src/backend/libc/thr=
ead/syscalls.rs":"435392788b133b83eaf73913a3adee5b244b471df316dec02469832cf=
dc71160","src/backend/libc/time/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c0571=
8e85bdc88a36dc805efdfce45d3909","src/backend/libc/time/syscalls.rs":"bf847e=
94cc156bdb553755baa88dac240db4dcaf690f303b0f205777c5a9cdfc","src/backend/li=
bc/time/types.rs":"d0307994ffddd3f21f702d9ae4400750aecccfaf4a01268161dc4fd7=
2de5c373","src/backend/libc/ugid/mod.rs":"2c6478857a0751625edabd61acb841819=
bfba1093b1faeded15693c805d84952","src/backend/libc/ugid/syscalls.rs":"8edf9=
1b8790add23902c9f5418da6b0723a371677f29f490e0c8af852f0f1a0c","src/backend/l=
ibc/winsock_c.rs":"502da2ed3cd6ca99bb7ee08b0b30e25c212632885cec965f9816366c=
6b931ac6","src/backend/linux_raw/arch/aarch64.rs":"2a255c9135bc8a321c180f52=
b88eb2b158bc9170cd222149caeae63c24587d44","src/backend/linux_raw/arch/arm.r=
s":"165bccb5883d0136e55d42091183765f83d86e9d37a7cb2cec9ae8af32774db6","src/=
backend/linux_raw/arch/mips.rs":"24af364aa93fd4b9917639d473336490a143f0d172=
3b09f388e72d534160ee51","src/backend/linux_raw/arch/mips32r6.rs":"e436a2ade=
34f2f7c58b8924462b07a2499dfc951e1e1318d51759444fb8b658e","src/backend/linux=
_raw/arch/mips64.rs":"897da9ddc877963ad59464d7f81dc59df8a7e91251e6adea14cfd=
946e2740a1c","src/backend/linux_raw/arch/mips64r6.rs":"3c08aea13c1139fb0dfb=
e74ca3d0147f007c3aa2eda641afb82c46f6aa4f6cd1","src/backend/linux_raw/arch/m=
od.rs":"37eaeea601d39be00d170856a31a8ec6a27b0d3ac22ab3ee642ab0e45dee237d","=
src/backend/linux_raw/arch/powerpc64.rs":"dfb001f8636a5e46d728900b0804fe6c3=
74e5e18a6f0e76d7d62e0c07da74477","src/backend/linux_raw/arch/riscv64.rs":"4=
1d33242d941030f46077dc2b1bc4c7913fe7630d693a5a7eef966bcf38f9d8b","src/backe=
nd/linux_raw/arch/thumb.rs":"2fd979ab421248c0a4c592bc0cefee63edc26528f469b7=
1b63eaed35356e42e8","src/backend/linux_raw/arch/x86.rs":"fc72f595ec75768aee=
248d405f4958a7ba1db65ac9fe54b277cd003eab33316e","src/backend/linux_raw/arch=
/x86_64.rs":"e929036a1f3cf93ba538f4523b241605cc7b5e61f84ffe6d9d5cdbcb6f73e5=
43","src/backend/linux_raw/c.rs":"db66abe9b91ce0f16dd71762744013046f29542a4=
6a577454c9ff063e9cb649c","src/backend/linux_raw/conv.rs":"48a261b8dd6182ce8=
76690cd4946d00c3697bcf7c3d89a46e3a3d6f50d39c2db","src/backend/linux_raw/eve=
nt/epoll.rs":"a102c2d8d7d5d07a5d846f30672153269d1762d1d846be1786b22fcf095e8=
721","src/backend/linux_raw/event/mod.rs":"72e46b04637e2d1d2a6b97af61614499=
5399e489d1fe916faf835d72fc8c64cd","src/backend/linux_raw/event/poll_fd.rs":=
"a5773464e9e30227b4046f029a27d3daf2c7bd0045e54565cf1a8ac2a0d61e81","src/bac=
kend/linux_raw/event/syscalls.rs":"44460b0045bb9d9f48b0baeb009a6b150a2902f9=
b733e8f6c5a36726b8db2d41","src/backend/linux_raw/event/types.rs":"0551b18f9=
82e233a0a06d8a9c3dbb29de0c204dcd64dd6f7e88b6c96fa9a9be8","src/backend/linux=
_raw/fs/dir.rs":"3107b07276f171a5837bd37a9c1e05151ca21d59ae2b85afd2c6e59e72=
1cdcf2","src/backend/linux_raw/fs/inotify.rs":"713ec3b85f281efca19bc4f495b7=
537e745fbf1d8c26592c80ceec6fd2ab59b5","src/backend/linux_raw/fs/makedev.rs"=
:"c6b4505c4bcbbc2460e80f3097eb15e2c8ef38d6c6e7abd78e39c53c372139e2","src/ba=
ckend/linux_raw/fs/mod.rs":"3d3a42bbf4d086f806d7d9f6e4b0a49a873dc27f4f03ffc=
a0921f5536acc24e5","src/backend/linux_raw/fs/syscalls.rs":"5f34547e8d57b69a=
ac600edf27893381d98c6d127a969d7b241bd9220137c649","src/backend/linux_raw/fs=
/types.rs":"4ee495127d88d3826f0277d2e62bb0e7553fe5e6693a153c48f2b74ba593cf3=
6","src/backend/linux_raw/io/errno.rs":"befa94275b30e8262718e8c9e9662b08526=
ec55779861dab4e2e499daa3e097d","src/backend/linux_raw/io/mod.rs":"7ae232442=
7892cca6f5ab53858d847b165f790a72ec25f3d99fb15f0506c9f27","src/backend/linux=
_raw/io/syscalls.rs":"568e16751191c14bb37f7883b17cb577dc97e09d615d17849c0e7=
e10e3898f1b","src/backend/linux_raw/io/types.rs":"d0df5a62248e1ba19af0f89f8=
6da7ba2312d97065c2814ddf6b08a4a0db23bad","src/backend/linux_raw/io_uring/mo=
d.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","s=
rc/backend/linux_raw/io_uring/syscalls.rs":"0f7c9cb7ccddf5687e4b9e5b2355887=
1a452a29ac6095a0184a06c47b9b18eb6","src/backend/linux_raw/mm/mod.rs":"8aa96=
6faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/l=
inux_raw/mm/syscalls.rs":"4e469542c88ea15853d5022e7e1d4b8fc291265ca314766d6=
0d9395dad927e19","src/backend/linux_raw/mm/types.rs":"b5bf9bf775d3771e79aa2=
34788fa3d1f25009f3f51cd59c72efc4f5e2c7bd790","src/backend/linux_raw/mod.rs"=
:"86f7c3b1d57e57a9e5b5dcc8ee24ded5054a917069bd9824f47952b10bca2221","src/ba=
ckend/linux_raw/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25=
a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mount/syscalls.rs":"8442c82814=
961f69c488222faabb82c44d2e7227b10faff919cbbd197bb47484","src/backend/linux_=
raw/mount/types.rs":"bf3dff5aad1cec9d998496230469958c836b76643f0ad17b0ea29b=
957357bcca","src/backend/linux_raw/net/addr.rs":"161ff30891526e309b1cf9514e=
9113227c6901c5c1bb346cb8fc3a53e43aa410","src/backend/linux_raw/net/mod.rs":=
"5640bbaf4963ac4575b0537173422ed6f6a43f34a8f6b656e7257fbbb13e5bcb","src/bac=
kend/linux_raw/net/msghdr.rs":"8b18974b81ee78af7a5c64733041dddaaa378a46cab8=
b984bff5b3b4be499751","src/backend/linux_raw/net/netdevice.rs":"a0354e44ae2=
f8402576b55470e48446dd655d77a69f27f814a298ab3e3a1afac","src/backend/linux_r=
aw/net/read_sockaddr.rs":"7cb3c8bcc80c5eee8602323cd83f36c1784927d9dd0c40ded=
29af6fb09c57ece","src/backend/linux_raw/net/send_recv.rs":"6d5d2aec61a3c1b4=
a5fef1a8a487dc8e163da8988d1237541ed008baa01128cc","src/backend/linux_raw/ne=
t/sockopt.rs":"2b42cd181772ea78d1b5b64d03fd2939a5e1a0c49b84c943c9fe8707b647=
7344","src/backend/linux_raw/net/syscalls.rs":"0138662012ca89e063b3a03cf8fe=
17b97fbeb38a3d18c42938ae047a4a392105","src/backend/linux_raw/net/write_sock=
addr.rs":"0efa4e17b4008da2cf2aada2d18acfccd31a3b49cf8ac5d608e77f3ea6627fec"=
,"src/backend/linux_raw/param/auxv.rs":"c9a582a02b4c87e26f6d5026c78e0c3a3ec=
8a025079cd3023e474d974b29268c","src/backend/linux_raw/param/init.rs":"f2275=
a2324a99be8d804fb3b7fdf86a43c7d428f660280b7e0e7d19c357f0200","src/backend/l=
inux_raw/param/libc_auxv.rs":"9a7b4ba75a18cc384df1b7edc5525f76c147bb84fb67d=
3730ba2c5ae64ebdff3","src/backend/linux_raw/param/mod.rs":"2e6a1a1c00351b9c=
88bd615aa923f71d76208df5626dd9bea03067f28f81dc31","src/backend/linux_raw/pi=
d/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952=
","src/backend/linux_raw/pid/syscalls.rs":"eef6aa01830ddd510b83f507da2002c0=
3e58318b73744be2c06ebbe33c4f194f","src/backend/linux_raw/pipe/mod.rs":"8aa9=
66faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/=
linux_raw/pipe/syscalls.rs":"366c730fc3e991bddb9f5a15b8c3917a8e6ace6d1d5a91=
13b2749e476faf6f83","src/backend/linux_raw/pipe/types.rs":"cf53bcdcde5d0ee1=
5e0e3566ceaad39fda44e69ed6f94a99fadd9be9b8be09cf","src/backend/linux_raw/pr=
ctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d849=
52","src/backend/linux_raw/prctl/syscalls.rs":"a18b224307e0d27bda9b7b85c75c=
d6c7ddfe39f5ce52efb7bb0bf0585b757343","src/backend/linux_raw/process/cpu_se=
t.rs":"b31889f972676f57e3599375dfcd59dd72975977ef345d11c22d51f0d4a6400b","s=
rc/backend/linux_raw/process/mod.rs":"fb393c70a9c63ef9a6bf1fb5a2dc94f07d6b0=
b6987cc5231c15c607015dafd68","src/backend/linux_raw/process/syscalls.rs":"0=
7c14d796a65d3958a9199dae00c8b864fda70e26b67815aff20edd20a985f2f","src/backe=
nd/linux_raw/process/types.rs":"6811ba822bc12a1a6336649151b4adb1f5d3365684a=
31c07f01953ea9547743d","src/backend/linux_raw/process/wait.rs":"921aee4b004=
8746087f52615a98edc2aa0fb4b53d6df44be4533098df55d1b05","src/backend/linux_r=
aw/pty/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d=
84952","src/backend/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae87b1ca58d82efc=
58007b9dddaae78460d615f48da19d1cd0f89","src/backend/linux_raw/rand/mod.rs":=
"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/bac=
kend/linux_raw/rand/syscalls.rs":"317cdaf243623329ee345131054e86a06a0863a9e=
90c5dba73e1ac3475ba6305","src/backend/linux_raw/rand/types.rs":"a21dbb1ab31=
eed6b59a57520be5a3c603c36d18ea74e67f7527f40835ba209a3","src/backend/linux_r=
aw/reg.rs":"6bfb53575494f5de76d5112a7e4eb6d0c266b1af0a275aa33b9bc9e6e7a2f41=
c","src/backend/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92942f06ea0b6846=
4040dcac33c6f0f7ee392c6269993347","src/backend/linux_raw/runtime/syscalls.r=
s":"dc7df0416919d1eef7e4919fc38836e2081903db286330d59b0119cc292155df","src/=
backend/linux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cdba6e8c91414113=
a04a739160929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":"8aa966faf3853=
d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw=
/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d93794540087b3182cbdf=
3cb9c8db","src/backend/linux_raw/shm/types.rs":"b831b474aba7eb97167c9289f52=
57776a72b39134b44e67a0ecfcef2394dcd47","src/backend/linux_raw/system/mod.rs=
":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/b=
ackend/linux_raw/system/syscalls.rs":"19a7ab17de906ec237f16a816da036723c1f5=
5f605e8e4a26689343eb4cd76e7","src/backend/linux_raw/system/types.rs":"1ceab=
8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e","src/backend/l=
inux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded=
15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":"25a0341ded465=
7a3a5389250c24b3310642785d386bc51f31696f98f4f1e770f","src/backend/linux_raw=
/thread/futex.rs":"0aa0f9f5be6a79de81e82c9f11f1bf8831f682a4b2f6cb29669e1591=
636f084e","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90b9234e79900b27ebb=
e8837e3a7a36aec532912e3e253edce5225067","src/backend/linux_raw/thread/sysca=
lls.rs":"9bc9a7360b6b8711b82bc6eff58dbcfc1d936f6e2cdf828084ed56036ade76d7",=
"src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7452bb1cc2d28b5f0aaa8=
40a2856fe363acce624e1beefc","src/backend/linux_raw/time/syscalls.rs":"7dc69=
75bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de9404845312fc","src/backend/l=
inux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a81d3305e18e726e54edc5a5=
474641f3cdc278","src/backend/linux_raw/ugid/mod.rs":"2c6478857a0751625edabd=
61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/ugid/sys=
calls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db84f444d3251309b7a0480b54f7=
","src/backend/linux_raw/vdso.rs":"056314f72c71d4b041739337ca2098afb7fe070f=
844327f462c293f43481b75b","src/backend/linux_raw/vdso_wrappers.rs":"0e01221=
cbc6f0a489e89b0cf2fa376c3826ead8491ee8510476b75e90784f39a","src/bitcast.rs"=
:"e21c87c292c781b27256c6f5dcf9fd52dd69ed6e21016cbd67ac31a8219ebf8e","src/bu=
ffer.rs":"8211a52e4fdd6ad74dcaddb885db25fa616898f988fc79b43af24b89c32d8421"=
,"src/check_types.rs":"e52f710e1cfc12ca13a495f2b43c227b293ff295e1ce3ab33293=
5b28a7579872","src/clockid.rs":"bd443c60868586c1a3114afacc95193de1d8cb99b7c=
9d710e0b3835596c74a24","src/cstr.rs":"41af2a4429fe6c67a8883f8a8f63d66c90df5=
66abda74fd2b03bcef7b9f24218","src/event/eventfd.rs":"81cbd08f7bdf40a6ce1ca6=
92b63da1dc8ba925282990668d9d68f1203e839fa1","src/event/kqueue.rs":"2f776485=
e16fe57639ad7454886e0ae761880b122976141ac05b4b2e7d82183a","src/event/mod.rs=
":"77f6c7051f70d4d5873787cf744e05b64519ba61d8da42298aeed27a906031f2","src/e=
vent/pause.rs":"cac3317286478565298a40788c1ce13c1b71543078a6f09655419de3250=
22f6f","src/event/poll.rs":"899bbee8e565110b2581594e7aa5067a426f859f0a41493=
5e2ce3a9732b6152a","src/event/port.rs":"4e51ff150e5d17cbd44aa64a38b99c15e26=
eaaf2e350768b5dcacdfde4fa5212","src/ffi.rs":"c2b8b38c02d72749aceb715c496726=
caba1f1fa989ad3856d0103a2fafed89ed","src/fs/abs.rs":"b671489378e14b708c784c=
4a673e6645741a869c7d1dd1918e28e1eb1a138829","src/fs/at.rs":"13f50b86575443d=
b8b881ce525ce2c5d2f377e528c33258729f0c06037de9499","src/fs/constants.rs":"2=
3923e0fce3221bdac371fe2d05028f30a87dba4f9b4a573b69dc2d6d39320b2","src/fs/co=
py_file_range.rs":"d3b644374390d482b2ff749a2459458872b57d0dcf9670368739b783=
3509a7c2","src/fs/cwd.rs":"9f429a79ace6e17455634da09216ee0ad3d067a4541518b3=
193ae6a8d9ff1e26","src/fs/dir.rs":"347a52f4ca9ac6321c52e802e97ec90d1b4c62ec=
955c8996fc17f8f5aed69966","src/fs/fadvise.rs":"1220e2cf5cf58fc7cc950d487380=
50a052c504f745ca67130daa6410e248230a","src/fs/fcntl.rs":"1d1ee1e0bc962779e1=
cc1b8b76f39c820746240557daa9e14b47b1799120dc39","src/fs/fcntl_apple.rs":"e2=
f23f038083621bcdecc98d02ce1023508afaecdb2ed0fba5c8b70f955301e5","src/fs/fco=
pyfile.rs":"ce565f61e1fbf2e31086077c2f1d01b6bb3b048915edda87fe9a4a4f5e8ff7e=
4","src/fs/fd.rs":"9b3ac2000bc00349cc224b0cf1d77515298d9ed99f75373d2a0cc709=
ef120d46","src/fs/getpath.rs":"28f6970fc1bbc37bb35c84724b59eac436ea7407a452=
2e18c2bdacb1fdd2edd9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f97189cea4e5982a0=
d35b192afeec6340a6c6222e0cb","src/fs/ioctl.rs":"c7c2db229daf7c9f0109fe7f45f=
05fa9a6a472950a2ad408c71514e6cb7c9d7b","src/fs/makedev.rs":"85520b484cb7c15=
ab71ea1c368578ea3b7e484d82f8510db92b6ce9f7ca341ae","src/fs/memfd_create.rs"=
:"a8bf1dced54c7592e71da896021338d5092c1693d12cc42e79bac435fab2792b","src/fs=
/mod.rs":"b1e92f119ce8acbcc55597f5512727622bcd12d6d0ce9fdb2d9b1cfaa9e42a64"=
,"src/fs/mount.rs":"8f6ea2b997dd83c50c90291b9ada3ed77a9ce1ad701c9b0d533b511=
3b317be5b","src/fs/openat2.rs":"4a95c15dab533a41201b5fa25c8a212956b7571d58c=
ad696bdaf45af8aef96db","src/fs/raw_dir.rs":"18ad797876d6230c38d4cacbed081c4=
028e03ace477d0520d9b226b40de942f0","src/fs/seek_from.rs":"a9efa0feb9ac789cf=
47667e91efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","src/fs/sendfile.rs":"e3b2=
058741cf4b1698f34d84bb37130cf2b72806d522a16fe541e832cde136cb","src/fs/statx=
.rs":"613480f0f3277790281b4cfe866ce72e4efdadca691969f6ae5e3ba6fc33a84a","sr=
c/fs/sync.rs":"a3b23543834281f347b0f873bd38154d31d404871188ac08f2b20b919623=
4cfd","src/fs/xattr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6ca3a47200532ca=
6e72d44cbe8334","src/io/close.rs":"2ddae17a2c9dc05fb2cefa134815699c2b3af2ee=
f8026407b8d009cb3ceae6b8","src/io/dup.rs":"335e76f8ad5aa021e654f61e043058e9=
64c2f9914c4785fc09bf6f49f4975290","src/io/errno.rs":"58a4d20ba0924e4d514e3c=
876fbe08982f1623187642ae14780815e65989c8c8","src/io/fcntl.rs":"41c1b370be55=
aaa68144dcc8a67b2d53504a5e6d8ee1bffabac2cc64c66a4043","src/io/ioctl.rs":"af=
4e736b6739cb1ff0477c1b818eeac789258863b79d12e441a08be99d49fb77","src/io/is_=
read_write.rs":"1bfb9ee5d58e0b29b44af12fe2668c7bccc841358698dcde47f1519ff9b=
b73b4","src/io/mod.rs":"75f1d0646be1d4c7c08b5887d8119b0103be8c25c43ccd4e0e9=
7015508c0bb8f","src/io/read_write.rs":"f36488a87a35c37c004f5111e76aad3cf6c2=
c793f41f78f2daba7a84ecae9079","src/io_uring.rs":"b08662af4b1b205ef644ca7517=
688957cf54cab3fc693f6205165550a330a5cc","src/ioctl/bsd.rs":"32ba3399a0fe3f6=
8bb458baafc2a21af9bff655865c7ea70990b7e98a26d3907","src/ioctl/linux.rs":"96=
df90bbc926783f387e8fe1656841d4c7a857fd4e9f41f95492f7dcece33074","src/ioctl/=
mod.rs":"ebb1e0865bed1b98917d4824082caf1445559a0a19f588094db90f46c224f780",=
"src/ioctl/patterns.rs":"bd6e309c8b548dfe04aaffe805972582fb56a0b717c45b4544=
7630bdf9b88433","src/lib.rs":"55f4fe027ab6e638b4613893dffc27a0c20b0bea6f185=
b76f401f34a480b78f9","src/maybe_polyfill/no_std/io/mod.rs":"77889bb5c5a4f2e=
50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/maybe_polyfill/no_s=
td/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9cff3a19049d88c8c8=
0","src/maybe_polyfill/no_std/net/mod.rs":"1e94d21d455bb1da18a4fccb24b3d93a=
d42698e22dd888b78115d6266c80288a","src/maybe_polyfill/no_std/os/fd/mod.rs":=
"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e80771d507c47","src/may=
be_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087cc9afd10269f09a8b4125915d=
c3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_std/os/fd/raw.rs":"f3648c=
7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999e7c6943","src/maybe_poly=
fill/no_std/os/mod.rs":"27dab639a765827644005d5f2fcc7c825310606b889cc8dd83f=
54c9528350dc0","src/maybe_polyfill/no_std/os/windows/io/mod.rs":"5bbcc05c83=
fee5026dd744a994e0458469466d5be39081baa62df07753b92fd2","src/maybe_polyfill=
/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49328b5637cb3bafb96437f2f9f=
269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/os/windows/io/socket.rs":"=
c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5d2c64808308d65","src/mayb=
e_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231a4e778b5f985b9ae712ece5e1=
a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/std/mod.rs":"7c16c86cc73e2=
26e65ead598e4018238b22000a345040b706bf1e1b3eba115fc","src/mm/madvise.rs":"6=
9481cd3354dbffe6cd93b234448e59de6d0fe6440bcf8b12f951f37745bc1dc","src/mm/mm=
ap.rs":"3b0abe64a6a606ea41b06acfc1079bcde1542c17475951e5ed900b86c3e5988d","=
src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761211a494ca6f89b2367a2d2157=
e340e","src/mm/msync.rs":"a9092be024ecbfa9c14edb935404513498b0da2ac6c99fc31=
fe4e58196a95f02","src/mm/userfaultfd.rs":"8073443bd181ff0b3ba4d0b1ae67370b4=
864035a0c8b4898cd709dc47c518ae7","src/mount/fsopen.rs":"1c54a02f04ee6710e2c=
5053c73361eecc499c24cd72c7c7c012dc57a4621e382","src/mount/mod.rs":"5f0c9df4=
727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d12a7136cb19","src/mount/mount_=
unmount.rs":"3805b63d4415d5838bdae34c6f6d50017d09b0d837de141961e66c7fb94dcc=
0a","src/mount/types.rs":"601ae3e10b7dc496fed7f3b40a80e81c6edd7bf13189d7be4=
5c3212d4c684c39","src/net/mod.rs":"7899807c9ad9e3fdbfd8b3ce2a1c7053d4f46dd7=
fa76102f620c6042c2d6314f","src/net/netdevice.rs":"e617af6949ff494de8747f472=
8973eb3564e25a2057b3150a5f609f4ea619784","src/net/send_recv/mod.rs":"b00743=
069268f2671570f76a4ff08b5487a344e5a6a12e62d40c2be5c25ac22d","src/net/send_r=
ecv/msg.rs":"c8ecb0e45df2c6cf655f13025ea7880214e5c085cd9dcbfdfa912f5420a6f3=
a3","src/net/socket.rs":"c1865fee7c354a9cc810853844a86c5ab4ab93dcec5e6de2d7=
6993550b412ce4","src/net/socket_addr_any.rs":"b5fe6f012c67d70e0e4885b9e5d6e=
463c282e12330a0579ea98bdf8fedbccd60","src/net/socketpair.rs":"56f4885c31d26=
64cd16e18a9a88792a4912fedd953cec36dba67e8581fd57921","src/net/sockopt.rs":"=
21d269c34992643d403d50e3071b646cd9ed05dc9bdc53fe2f795bb5df43fa60","src/net/=
types.rs":"bd3ee0cdb102e8cd1f2e0434639084b599a10561fc7f2aaa226d44bf892cef63=
","src/net/wsa.rs":"29856e6d0108be6b719f6ef973c5396e48ddd58ecd0c2db9ca3e2e0=
ba4eccb5b","src/param/auxv.rs":"8655993d7d480f340d8fa3efeb35135e0107510f6c3=
cfb160a9f6dc00ef577aa","src/param/init.rs":"a31c0e5cea61a1a999767fe74f87c0d=
59eeb6bce66578b842fe0e0c32be27a55","src/param/mod.rs":"c514216b96d9520c9ffc=
5662c97b24f1f36f56fe1f5f3c9f64175c8b35577288","src/path/arg.rs":"c0f0a7c2fe=
37192cf6f7b35ae0e17620b863b31e55efb7b2d9f31b5def56a749","src/path/dec_int.r=
s":"8ff8e14442c46f8e7a9b80d73973619b4271549b9defd538479bf8c2d93aa72e","src/=
path/mod.rs":"8355324af7eaa91dce30fc4ebdd161691f9d8bf7a61bde1dde27a1bcca153=
69b","src/pid.rs":"f1c486000c5b1311b2d720cee88f089c17ef9a171709673dd06e6f35=
f4ff98a3","src/pipe.rs":"9f269090dd0588dc8d3feba4f4a78b61891bce91d3c9b64cdb=
ad9251b06a9e11","src/prctl.rs":"19aa584895874ea48b9bbe1bf695b81257b0281df64=
dfdd91e1b4bfa298661b7","src/process/chdir.rs":"911216459aa429fe9f125f1357d6=
900b43b0007835b85c719875d00f79a74664","src/process/chroot.rs":"2b5f6124eb19=
f26ad2705174f7ad50cdc0a5d15abd59ffcf55421228d82130b4","src/process/exit.rs"=
:"48de66e5504a00cb375d8f415ce63b6225a3f5204268d40726a7d0fbba43f587","src/pr=
ocess/id.rs":"e0a26da426962dd5898fbc05700083a68399d5b669fd5f4afaac7b282e017=
8fd","src/process/ioctl.rs":"23ad0285671e8d7ca71a63c50655dbf732ccea8af11d75=
4a0558e0236db37e76","src/process/kill.rs":"96d5ce432c19cf2b600d5248c681c117=
abf53ae94bbfca7e75ac533a40e3968e","src/process/membarrier.rs":"1c4c39b359d1=
d0e9bbe16352eedfca9278d9ef298ade8ec00e998617bbcbfed8","src/process/mod.rs":=
"4fda62909afcb081281bd9a8eaf770dc3dfc2111013231ae23b0a1e101582f48","src/pro=
cess/pidfd.rs":"150413a9cc550ffc432b3279a368223fa9577544ef29e45edeff3b79ae3=
16cab","src/process/pidfd_getfd.rs":"74c778b872be0b800870e4633606461fdc8493=
b259031e35f8f558768d960cc2","src/process/prctl.rs":"0130d05362a17a9282f3391=
189095e1f4f51fb56d7a5205906a0011842df4576","src/process/priority.rs":"f1354=
82e71ea8aa0daf92b9f238051178a4c904070fa8409622f94155df3c544","src/process/p=
rocctl.rs":"75e9f7e5c66e6563aff133ff99b3a35c80a9f0a616d318a93a65be39ebc191e=
a","src/process/rlimit.rs":"10b79de3ced0e64059a94c879742d46a35a6176c776d8ee=
d75031d5e6340283d","src/process/sched.rs":"6c976daf5b5a30aa9a33456d23a46f6f=
4d257642963eb142b55e13a53aec4c56","src/process/sched_yield.rs":"6565faa3928=
b66ddc74a65e893e15edfa4b9be4f7e5f5f68527501a7f6bc3350","src/process/umask.r=
s":"1a0f31a842303c978e3f05ec191e2b5e96104c09c6596473b42b1fac34898a50","src/=
process/wait.rs":"f9c73dde2a66dfbe448501f039396dd26c5d678e4f8cb61c1f78014b7=
b49fcd3","src/procfs.rs":"4d4812a8db6897dabc33269ff59bf6d7192a65be977e87961=
3704e29a8b73505","src/pty.rs":"652c412e7280d0344b3f9bfe376c106a7f1b42b898b7=
af344e6e72da268e2bf0","src/rand/getrandom.rs":"0a5320eaf5dd4c6d9b1252c41ca2=
86b40a9ce813eb469c89dba41e6258612740","src/rand/mod.rs":"e1fb7542f1958fe776=
73aa628bd92fef1b9addf79ba23df2398d1231cb61c148","src/runtime.rs":"958cdf156=
7c5758c73c197fc36d1feffb414a22a76a7a287afc84f330f2d2279","src/shm.rs":"b96f=
e8a05ee5d4536464a8843a776d43a938abaf22c772fc35b5373d95644a8d","src/signal.r=
s":"a294b49d487dafaa42e534f8b1d93e87bec135087676b2ba2ef865cf2fccdaf2","src/=
static_assertions.rs":"504cf66f0d5b8e335be02f9ae8b0a355abc98c2c82eec0098bdf=
0988e662e260","src/stdio.rs":"6f78cbc0d102eff9354fa1fdfd1b63a45ea159d0a9ac5=
d25ecf703383b847b55","src/system.rs":"e048eccf6f60ff49fa3312e7a01a9f641787c=
195c4db745f1f5a2f2c443d7e91","src/termios/ioctl.rs":"a1ac967f7811a482f8bb53=
847c37c8359f518cd26da9df7b816ba678a0139623","src/termios/mod.rs":"b44b7caa6=
0b6f458657ed58a0e0eca41bb4e6d6be4b0f042bbb8ab7056cebe4b","src/termios/tc.rs=
":"9af4eb264bf23bc0b0ad1707fcca687020b20f0775a28209b237fbb72089d991","src/t=
ermios/tty.rs":"35a5fc2d26501e0e6dde1a755eeccf7b4f3b4702c5bac30e0953220808e=
f7034","src/termios/types.rs":"b5671eedf541754c54f680002bafed1adbabce172d09=
d7c4d31fdf9313ca18c8","src/thread/clock.rs":"83681fa00d5efa15c5b7cba10015a0=
c99d855c4ac78714e3989d91c999e5ba80","src/thread/futex.rs":"985f9a0dce1e2a48=
92ae7f26bd1bf119ceae3f9fa6b4707e166624fc1cee76d4","src/thread/id.rs":"bc4cf=
152388962303ea835b97acd64e499ecd15f94eaf6f133ff5a1a582377ba","src/thread/li=
bcap.rs":"4c51b7df566d38dd0f85f81ef53279a745a39f0f4e1154791fd38438e2ca7db1"=
,"src/thread/mod.rs":"09b19f25ed1aa65f6605ed7deccc4bd945e3ae872a60275787f44=
944a73edf3f","src/thread/prctl.rs":"ebc89b731eb8fd1a8f82a50dbba849061476a45=
37bba8702b29db657d5287ffa","src/thread/setns.rs":"ea9142b1f3a5b3f329683be18=
5f960c50e5c1636149e91fbf59e88a897fc607d","src/time/clock.rs":"e59a29f1bed8c=
31c3d5b6fad60f2d4fa6cab8dd8e86148bb3693a5e3a1ce735f","src/time/mod.rs":"43a=
fee938c80d124d04d4ba190c03f4d21d1e3bfc154fff309211e4f6eabe940","src/time/ti=
merfd.rs":"f17092b84553741aa2d2b44c6992b5d2c8c96cc2c2007fc9a2c6b2064485e53f=
","src/timespec.rs":"32a4d930cbc0f6dbd23153290db920671cf4ce65a4a127e176f897=
c1cde42d7d","src/ugid.rs":"6616c6e35b7e43aee5b150f1efae7a50711e0947943c9a96=
833dbe214ad9e85f","src/utils.rs":"9ae76f8a41d6cc350cdd58c9084b5c3a5a708eeec=
d769783debdbcbaef442182","src/weak.rs":"7e3169bc97e76fc4d52b040391a8df36b06=
536fc0f81cc6e8e71b951cb1fe54e"},"package":"70dc5ec042f7a43c4a73241207cecc98=
73a06d45debb38b329f8541d85c2730f"}
-\ No newline at end of file
-+{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231d2=
fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b0532d=
35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"42d204101e647da4dde122=
0b6653dfa647b07a58143b5db4f893a32c871f696c","LICENSE-APACHE":"a60eea8175145=
31668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2.0_WI=
TH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39ef1f9=
4f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a715d9d2=
b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12ba79e=
4cebb6983a7b6491949750aecc4f2178","README.md":"cec45686b62cb75ef2f0c851939b=
7ddcb64678c27c18c7bca18d6f5cde2446d3","SECURITY.md":"4d75afb09dd28eb5982e3a=
1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e67273aa0=
a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"ca1a2e173b=
669f8e13b4e830f3b20530996fe2d60f22f2609ced1a7032affd0f","src/backend/libc/c=
.rs":"c436b6a72ccb6de941ba66c563accaf1a1db887d4aac20ec9fad45006dfc07d1","sr=
c/backend/libc/conv.rs":"a254fa84164286ee6be64f49b5bd5f7e2fd503ebd5ca9076da=
d4c2507a351dc2","src/backend/libc/event/epoll.rs":"93d3eb9e0e397afc3c44797b=
315ce92ff8b22f2372812b19cec9e063c55032c3","src/backend/libc/event/mod.rs":"=
ad30f99f7da0768c18fffac6ec71e658bfed2e44f0634f48c2e0ffe4677ec231","src/back=
end/libc/event/poll_fd.rs":"286268c0e94bc1716a61835ef3c6324e8f3feb96ae2491a=
d5ed919300e80070e","src/backend/libc/event/syscalls.rs":"f91bbe7d222987c89a=
2647817f6819dd536cbc4a685dfb794f403543c32df777","src/backend/libc/event/typ=
es.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f13","=
src/backend/libc/event/windows_syscalls.rs":"ebfac665c6676c4b803134ab8806be=
8aa2e96bdbc7799a19c544cd9069b35787","src/backend/libc/fs/dir.rs":"3c43768f9=
e56cb4297594c05d91a52be20029dd2b3e0b91f6b1a13f31e595fe2","src/backend/libc/=
fs/inotify.rs":"a027a718db8bf6ff9a778c2cfa706850b466240b0a2296d72b9834c0096=
968e8","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f329ad3=
5bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803011b5=
7da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc/fs/s=
yscalls.rs":"89cdd809e0cd89fb4f85e2ba0716ecf857ccb66db69a7fc40a5e0a25b15b39=
d3","src/backend/libc/fs/types.rs":"cae37a0a3099b8e400a48927c60c15efe0d05d2=
e71f78577742f8f7cede62dfd","src/backend/libc/io/errno.rs":"bac592ece7b44692=
237a350ff4905bfad30fa042d1e8126e5229e02913fb1c9d","src/backend/libc/io/mod.=
rs":"746647bd864e4ec7717925b6d176cebdb392b7d015070244cc48d92780351dd6","src=
/backend/libc/io/syscalls.rs":"c93a7867fc13eecc953c6335fd79c37d4d1734d3a06e=
13e5d7e08bd985c66326","src/backend/libc/io/types.rs":"2efd39bb3df19a9db5496=
217284f3d2235ddb354fac81dd71861109a56bede0b","src/backend/libc/io/windows_s=
yscalls.rs":"fab3fa099aa89cea56a6edc651dd37750e581534f4f45b04a7e425f130b084=
68","src/backend/libc/io_uring/mod.rs":"2c6478857a0751625edabd61acb841819bf=
ba1093b1faeded15693c805d84952","src/backend/libc/io_uring/syscalls.rs":"5af=
8146d5971c833e6fd657f652c618b31f854e1b0811864fba9b658cb633e19","src/backend=
/libc/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/mm/syscalls.rs":"c04c61ad3d7f3b24d13f89144d7fa0a=
05658cea4763207f9250db4f9362de2fe","src/backend/libc/mm/types.rs":"55478e17=
3b7d82e2c85934fc0dda79c29f46a305228df78f1e90c68ac9d3cfec","src/backend/libc=
/mod.rs":"087d2676df88510b089255053a4865e62c64172723588386fe8244d2f1a681c4"=
,"src/backend/libc/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287=
b25a5bfe489fa1d07f7cfd7","src/backend/libc/mount/syscalls.rs":"d2d35f7ae989=
bb52722e28cdbd775243c5d7da9eb411e0b2b9632f2aa7c1533e","src/backend/libc/mou=
nt/types.rs":"bf1d541daa248aa023bf18aec7645f2f8c402ac4aa1df2f55b8a784057c2e=
113","src/backend/libc/net/addr.rs":"9bdc2febb20785bc26a820eaba52cb546c67c7=
9cb547f08105087cd0f79d5861","src/backend/libc/net/ext.rs":"0dd64877abe1ba86=
b47a2ab34340e3f6cc7b53b22d0bb5e237daf6a82edd46b0","src/backend/libc/net/mod=
.rs":"562d23225d6dba8f095e3ca41af60dcf6cc40c2cf17bf028f90888f809e86f07","sr=
c/backend/libc/net/msghdr.rs":"6f8aba792b4adef5c5d3d4324a813a67a063a50d1043=
7bb19bf7496666bd6de6","src/backend/libc/net/netdevice.rs":"c6c3cd11b0181a74=
243705438fbf0fedeb02d4201ff3ad9f45a084fbd57a9c21","src/backend/libc/net/rea=
d_sockaddr.rs":"61fc1c744b376d57a18d78d8f7ab469236c614f5fa7aeaf37a636e6a967=
b9066","src/backend/libc/net/send_recv.rs":"1450ca958431a5bf3a85cdeef88b387=
f30d5c1215de2c56d164ccda38f21b36c","src/backend/libc/net/sockopt.rs":"d53d5=
2f1c55f522c1d0de5e446df3017757b08270c0a0b593a583fd6c56b0876","src/backend/l=
ibc/net/syscalls.rs":"1412f9deed57ac0909b0b1c3ac3e5fb7d5c31ab356212c9131e33=
378c342d2a5","src/backend/libc/net/write_sockaddr.rs":"bee221d0a1fedf4ddcff=
045faa2702c1f1e68b4d6c3f2f7b079d888e0ef9da56","src/backend/libc/param/auxv.=
rs":"1877fd1dac415b58a4ae824ef9abd8b49756f613f6915820223f2c586fb4d254","src=
/backend/libc/param/mod.rs":"5234b8f1bcb886cca6ea003d411d75eaeebe58deedd80e=
3441354bf46ed85d4d","src/backend/libc/pid/mod.rs":"2c6478857a0751625edabd61=
acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/pid/syscalls.rs=
":"49ea679b96c0741d048e82964038f9a931bc3cf3a0b59c7db3df89629b9c49e6","src/b=
ackend/libc/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe=
489fa1d07f7cfd7","src/backend/libc/pipe/syscalls.rs":"8affde100f6a9dfc762b7=
9d1e48be5c1039be414f8ef7d5a6acaba882a68d259","src/backend/libc/pipe/types.r=
s":"9826013bc5fa18acdcbf09c650b96ce301a18ec009139ebaf79162669b1fc2c8","src/=
backend/libc/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faed=
ed15693c805d84952","src/backend/libc/prctl/syscalls.rs":"8a2684f444a7555098=
dce2b92270d81cefdae902716c6e5d59bd7b0657e8a29d","src/backend/libc/process/c=
pu_set.rs":"5fca2b47289a2bb6ba908c910a6d27ac78ac10ea21d3c0c018f72f8816c5b9d=
7","src/backend/libc/process/mod.rs":"806e26da8d1e7afae502987fcd650f4d348da=
147b8a2e74447affdca153e2e97","src/backend/libc/process/syscalls.rs":"f08a76=
a5f32e40a69c99261eeabb405a58476ef9e85ae142f2fce19679a42ec4","src/backend/li=
bc/process/types.rs":"fb2caf34b17079aa72c04aed0f9a31d534ea8e8b73a80c758b748=
bf5e38df52b","src/backend/libc/process/wait.rs":"0cc556aed976b4bbb3965f74fd=
76b8216c755fce25043b7b21ce54afa07c9773","src/backend/libc/pty/mod.rs":"2c64=
78857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/=
libc/pty/syscalls.rs":"566fc9a2cb2e38d7d7ac2405b22c0522369cae4a8f4fe18b5512=
3ba94d3d5a95","src/backend/libc/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f=
4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/rand/syscalls.rs":"3=
5ea6b6e0f8a7fb064fd5cb33a3a855cd161a6a00f93d76c861b2a2c66db85e7","src/backe=
nd/libc/rand/types.rs":"4eb0b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a705ec6=
05b773f63f880","src/backend/libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f=
4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/shm/syscalls.rs":"60=
d797d4e85e08e6330e6b8d80094356ce377e5484952f88ae2a6e49231c268c","src/backen=
d/libc/shm/types.rs":"2206eac8ee74951b995e1e80f10bf235cc6b04e0a099f4adefce5=
46378838233","src/backend/libc/system/mod.rs":"38563ea68829ca5a4b1b0695ac8a=
5c05718e85bdc88a36dc805efdfce45d3909","src/backend/libc/system/syscalls.rs"=
:"c18c2942811ea93af3125b58d00a1da05c54e5ff438a3dc44cda53bc9d6fcf03","src/ba=
ckend/libc/system/types.rs":"6871e16aee14fe2ae03cea798c3e509ffe44778a9c0e56=
08fd73e2e015876d7e","src/backend/libc/termios/mod.rs":"2c6478857a0751625eda=
bd61acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/termios/sys=
calls.rs":"3149bd6254589a39d03904de21257e92fcd8d2754167f917d45b0d74d410174c=
","src/backend/libc/thread/futex.rs":"b666828653b12634bbd7fd709acf69641b648=
ec40962a1d4f904c5db14d2eff5","src/backend/libc/thread/mod.rs":"fa710053974d=
7f16a6c49242ee6c10a3b9e1143452b9daeaed8837302a679fff","src/backend/libc/thr=
ead/syscalls.rs":"435392788b133b83eaf73913a3adee5b244b471df316dec02469832cf=
dc71160","src/backend/libc/time/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c0571=
8e85bdc88a36dc805efdfce45d3909","src/backend/libc/time/syscalls.rs":"bf847e=
94cc156bdb553755baa88dac240db4dcaf690f303b0f205777c5a9cdfc","src/backend/li=
bc/time/types.rs":"d0307994ffddd3f21f702d9ae4400750aecccfaf4a01268161dc4fd7=
2de5c373","src/backend/libc/ugid/mod.rs":"2c6478857a0751625edabd61acb841819=
bfba1093b1faeded15693c805d84952","src/backend/libc/ugid/syscalls.rs":"8edf9=
1b8790add23902c9f5418da6b0723a371677f29f490e0c8af852f0f1a0c","src/backend/l=
ibc/winsock_c.rs":"502da2ed3cd6ca99bb7ee08b0b30e25c212632885cec965f9816366c=
6b931ac6","src/backend/linux_raw/arch/aarch64.rs":"2a255c9135bc8a321c180f52=
b88eb2b158bc9170cd222149caeae63c24587d44","src/backend/linux_raw/arch/arm.r=
s":"165bccb5883d0136e55d42091183765f83d86e9d37a7cb2cec9ae8af32774db6","src/=
backend/linux_raw/arch/mips.rs":"24af364aa93fd4b9917639d473336490a143f0d172=
3b09f388e72d534160ee51","src/backend/linux_raw/arch/mips32r6.rs":"e436a2ade=
34f2f7c58b8924462b07a2499dfc951e1e1318d51759444fb8b658e","src/backend/linux=
_raw/arch/mips64.rs":"897da9ddc877963ad59464d7f81dc59df8a7e91251e6adea14cfd=
946e2740a1c","src/backend/linux_raw/arch/mips64r6.rs":"3c08aea13c1139fb0dfb=
e74ca3d0147f007c3aa2eda641afb82c46f6aa4f6cd1","src/backend/linux_raw/arch/m=
od.rs":"37eaeea601d39be00d170856a31a8ec6a27b0d3ac22ab3ee642ab0e45dee237d","=
src/backend/linux_raw/arch/powerpc64.rs":"dfb001f8636a5e46d728900b0804fe6c3=
74e5e18a6f0e76d7d62e0c07da74477","src/backend/linux_raw/arch/riscv64.rs":"4=
1d33242d941030f46077dc2b1bc4c7913fe7630d693a5a7eef966bcf38f9d8b","src/backe=
nd/linux_raw/arch/thumb.rs":"2fd979ab421248c0a4c592bc0cefee63edc26528f469b7=
1b63eaed35356e42e8","src/backend/linux_raw/arch/x86.rs":"fc72f595ec75768aee=
248d405f4958a7ba1db65ac9fe54b277cd003eab33316e","src/backend/linux_raw/arch=
/x86_64.rs":"e929036a1f3cf93ba538f4523b241605cc7b5e61f84ffe6d9d5cdbcb6f73e5=
43","src/backend/linux_raw/c.rs":"db66abe9b91ce0f16dd71762744013046f29542a4=
6a577454c9ff063e9cb649c","src/backend/linux_raw/conv.rs":"48a261b8dd6182ce8=
76690cd4946d00c3697bcf7c3d89a46e3a3d6f50d39c2db","src/backend/linux_raw/eve=
nt/epoll.rs":"a102c2d8d7d5d07a5d846f30672153269d1762d1d846be1786b22fcf095e8=
721","src/backend/linux_raw/event/mod.rs":"72e46b04637e2d1d2a6b97af61614499=
5399e489d1fe916faf835d72fc8c64cd","src/backend/linux_raw/event/poll_fd.rs":=
"a5773464e9e30227b4046f029a27d3daf2c7bd0045e54565cf1a8ac2a0d61e81","src/bac=
kend/linux_raw/event/syscalls.rs":"44460b0045bb9d9f48b0baeb009a6b150a2902f9=
b733e8f6c5a36726b8db2d41","src/backend/linux_raw/event/types.rs":"0551b18f9=
82e233a0a06d8a9c3dbb29de0c204dcd64dd6f7e88b6c96fa9a9be8","src/backend/linux=
_raw/fs/dir.rs":"3107b07276f171a5837bd37a9c1e05151ca21d59ae2b85afd2c6e59e72=
1cdcf2","src/backend/linux_raw/fs/inotify.rs":"713ec3b85f281efca19bc4f495b7=
537e745fbf1d8c26592c80ceec6fd2ab59b5","src/backend/linux_raw/fs/makedev.rs"=
:"c6b4505c4bcbbc2460e80f3097eb15e2c8ef38d6c6e7abd78e39c53c372139e2","src/ba=
ckend/linux_raw/fs/mod.rs":"3d3a42bbf4d086f806d7d9f6e4b0a49a873dc27f4f03ffc=
a0921f5536acc24e5","src/backend/linux_raw/fs/syscalls.rs":"5f34547e8d57b69a=
ac600edf27893381d98c6d127a969d7b241bd9220137c649","src/backend/linux_raw/fs=
/types.rs":"4ee495127d88d3826f0277d2e62bb0e7553fe5e6693a153c48f2b74ba593cf3=
6","src/backend/linux_raw/io/errno.rs":"befa94275b30e8262718e8c9e9662b08526=
ec55779861dab4e2e499daa3e097d","src/backend/linux_raw/io/mod.rs":"7ae232442=
7892cca6f5ab53858d847b165f790a72ec25f3d99fb15f0506c9f27","src/backend/linux=
_raw/io/syscalls.rs":"568e16751191c14bb37f7883b17cb577dc97e09d615d17849c0e7=
e10e3898f1b","src/backend/linux_raw/io/types.rs":"d0df5a62248e1ba19af0f89f8=
6da7ba2312d97065c2814ddf6b08a4a0db23bad","src/backend/linux_raw/io_uring/mo=
d.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","s=
rc/backend/linux_raw/io_uring/syscalls.rs":"0f7c9cb7ccddf5687e4b9e5b2355887=
1a452a29ac6095a0184a06c47b9b18eb6","src/backend/linux_raw/mm/mod.rs":"8aa96=
6faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/l=
inux_raw/mm/syscalls.rs":"4e469542c88ea15853d5022e7e1d4b8fc291265ca314766d6=
0d9395dad927e19","src/backend/linux_raw/mm/types.rs":"b5bf9bf775d3771e79aa2=
34788fa3d1f25009f3f51cd59c72efc4f5e2c7bd790","src/backend/linux_raw/mod.rs"=
:"86f7c3b1d57e57a9e5b5dcc8ee24ded5054a917069bd9824f47952b10bca2221","src/ba=
ckend/linux_raw/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25=
a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mount/syscalls.rs":"8442c82814=
961f69c488222faabb82c44d2e7227b10faff919cbbd197bb47484","src/backend/linux_=
raw/mount/types.rs":"bf3dff5aad1cec9d998496230469958c836b76643f0ad17b0ea29b=
957357bcca","src/backend/linux_raw/net/addr.rs":"161ff30891526e309b1cf9514e=
9113227c6901c5c1bb346cb8fc3a53e43aa410","src/backend/linux_raw/net/mod.rs":=
"5640bbaf4963ac4575b0537173422ed6f6a43f34a8f6b656e7257fbbb13e5bcb","src/bac=
kend/linux_raw/net/msghdr.rs":"8b18974b81ee78af7a5c64733041dddaaa378a46cab8=
b984bff5b3b4be499751","src/backend/linux_raw/net/netdevice.rs":"a0354e44ae2=
f8402576b55470e48446dd655d77a69f27f814a298ab3e3a1afac","src/backend/linux_r=
aw/net/read_sockaddr.rs":"7cb3c8bcc80c5eee8602323cd83f36c1784927d9dd0c40ded=
29af6fb09c57ece","src/backend/linux_raw/net/send_recv.rs":"6d5d2aec61a3c1b4=
a5fef1a8a487dc8e163da8988d1237541ed008baa01128cc","src/backend/linux_raw/ne=
t/sockopt.rs":"2b42cd181772ea78d1b5b64d03fd2939a5e1a0c49b84c943c9fe8707b647=
7344","src/backend/linux_raw/net/syscalls.rs":"0138662012ca89e063b3a03cf8fe=
17b97fbeb38a3d18c42938ae047a4a392105","src/backend/linux_raw/net/write_sock=
addr.rs":"0efa4e17b4008da2cf2aada2d18acfccd31a3b49cf8ac5d608e77f3ea6627fec"=
,"src/backend/linux_raw/param/auxv.rs":"c9a582a02b4c87e26f6d5026c78e0c3a3ec=
8a025079cd3023e474d974b29268c","src/backend/linux_raw/param/init.rs":"f2275=
a2324a99be8d804fb3b7fdf86a43c7d428f660280b7e0e7d19c357f0200","src/backend/l=
inux_raw/param/libc_auxv.rs":"9a7b4ba75a18cc384df1b7edc5525f76c147bb84fb67d=
3730ba2c5ae64ebdff3","src/backend/linux_raw/param/mod.rs":"2e6a1a1c00351b9c=
88bd615aa923f71d76208df5626dd9bea03067f28f81dc31","src/backend/linux_raw/pi=
d/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952=
","src/backend/linux_raw/pid/syscalls.rs":"eef6aa01830ddd510b83f507da2002c0=
3e58318b73744be2c06ebbe33c4f194f","src/backend/linux_raw/pipe/mod.rs":"8aa9=
66faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/=
linux_raw/pipe/syscalls.rs":"366c730fc3e991bddb9f5a15b8c3917a8e6ace6d1d5a91=
13b2749e476faf6f83","src/backend/linux_raw/pipe/types.rs":"cf53bcdcde5d0ee1=
5e0e3566ceaad39fda44e69ed6f94a99fadd9be9b8be09cf","src/backend/linux_raw/pr=
ctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d849=
52","src/backend/linux_raw/prctl/syscalls.rs":"a18b224307e0d27bda9b7b85c75c=
d6c7ddfe39f5ce52efb7bb0bf0585b757343","src/backend/linux_raw/process/cpu_se=
t.rs":"b31889f972676f57e3599375dfcd59dd72975977ef345d11c22d51f0d4a6400b","s=
rc/backend/linux_raw/process/mod.rs":"fb393c70a9c63ef9a6bf1fb5a2dc94f07d6b0=
b6987cc5231c15c607015dafd68","src/backend/linux_raw/process/syscalls.rs":"0=
7c14d796a65d3958a9199dae00c8b864fda70e26b67815aff20edd20a985f2f","src/backe=
nd/linux_raw/process/types.rs":"6811ba822bc12a1a6336649151b4adb1f5d3365684a=
31c07f01953ea9547743d","src/backend/linux_raw/process/wait.rs":"921aee4b004=
8746087f52615a98edc2aa0fb4b53d6df44be4533098df55d1b05","src/backend/linux_r=
aw/pty/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d=
84952","src/backend/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae87b1ca58d82efc=
58007b9dddaae78460d615f48da19d1cd0f89","src/backend/linux_raw/rand/mod.rs":=
"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/bac=
kend/linux_raw/rand/syscalls.rs":"317cdaf243623329ee345131054e86a06a0863a9e=
90c5dba73e1ac3475ba6305","src/backend/linux_raw/rand/types.rs":"a21dbb1ab31=
eed6b59a57520be5a3c603c36d18ea74e67f7527f40835ba209a3","src/backend/linux_r=
aw/reg.rs":"6bfb53575494f5de76d5112a7e4eb6d0c266b1af0a275aa33b9bc9e6e7a2f41=
c","src/backend/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92942f06ea0b6846=
4040dcac33c6f0f7ee392c6269993347","src/backend/linux_raw/runtime/syscalls.r=
s":"dc7df0416919d1eef7e4919fc38836e2081903db286330d59b0119cc292155df","src/=
backend/linux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cdba6e8c91414113=
a04a739160929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":"8aa966faf3853=
d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw=
/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d93794540087b3182cbdf=
3cb9c8db","src/backend/linux_raw/shm/types.rs":"b831b474aba7eb97167c9289f52=
57776a72b39134b44e67a0ecfcef2394dcd47","src/backend/linux_raw/system/mod.rs=
":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/b=
ackend/linux_raw/system/syscalls.rs":"19a7ab17de906ec237f16a816da036723c1f5=
5f605e8e4a26689343eb4cd76e7","src/backend/linux_raw/system/types.rs":"1ceab=
8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e","src/backend/l=
inux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded=
15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":"25a0341ded465=
7a3a5389250c24b3310642785d386bc51f31696f98f4f1e770f","src/backend/linux_raw=
/thread/futex.rs":"0aa0f9f5be6a79de81e82c9f11f1bf8831f682a4b2f6cb29669e1591=
636f084e","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90b9234e79900b27ebb=
e8837e3a7a36aec532912e3e253edce5225067","src/backend/linux_raw/thread/sysca=
lls.rs":"9bc9a7360b6b8711b82bc6eff58dbcfc1d936f6e2cdf828084ed56036ade76d7",=
"src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7452bb1cc2d28b5f0aaa8=
40a2856fe363acce624e1beefc","src/backend/linux_raw/time/syscalls.rs":"7dc69=
75bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de9404845312fc","src/backend/l=
inux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a81d3305e18e726e54edc5a5=
474641f3cdc278","src/backend/linux_raw/ugid/mod.rs":"2c6478857a0751625edabd=
61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/ugid/sys=
calls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db84f444d3251309b7a0480b54f7=
","src/backend/linux_raw/vdso.rs":"056314f72c71d4b041739337ca2098afb7fe070f=
844327f462c293f43481b75b","src/backend/linux_raw/vdso_wrappers.rs":"0e01221=
cbc6f0a489e89b0cf2fa376c3826ead8491ee8510476b75e90784f39a","src/bitcast.rs"=
:"e21c87c292c781b27256c6f5dcf9fd52dd69ed6e21016cbd67ac31a8219ebf8e","src/bu=
ffer.rs":"8211a52e4fdd6ad74dcaddb885db25fa616898f988fc79b43af24b89c32d8421"=
,"src/check_types.rs":"e52f710e1cfc12ca13a495f2b43c227b293ff295e1ce3ab33293=
5b28a7579872","src/clockid.rs":"bd443c60868586c1a3114afacc95193de1d8cb99b7c=
9d710e0b3835596c74a24","src/cstr.rs":"41af2a4429fe6c67a8883f8a8f63d66c90df5=
66abda74fd2b03bcef7b9f24218","src/event/eventfd.rs":"81cbd08f7bdf40a6ce1ca6=
92b63da1dc8ba925282990668d9d68f1203e839fa1","src/event/kqueue.rs":"2f776485=
e16fe57639ad7454886e0ae761880b122976141ac05b4b2e7d82183a","src/event/mod.rs=
":"77f6c7051f70d4d5873787cf744e05b64519ba61d8da42298aeed27a906031f2","src/e=
vent/pause.rs":"cac3317286478565298a40788c1ce13c1b71543078a6f09655419de3250=
22f6f","src/event/poll.rs":"899bbee8e565110b2581594e7aa5067a426f859f0a41493=
5e2ce3a9732b6152a","src/event/port.rs":"4e51ff150e5d17cbd44aa64a38b99c15e26=
eaaf2e350768b5dcacdfde4fa5212","src/ffi.rs":"c2b8b38c02d72749aceb715c496726=
caba1f1fa989ad3856d0103a2fafed89ed","src/fs/abs.rs":"b671489378e14b708c784c=
4a673e6645741a869c7d1dd1918e28e1eb1a138829","src/fs/at.rs":"13f50b86575443d=
b8b881ce525ce2c5d2f377e528c33258729f0c06037de9499","src/fs/constants.rs":"2=
3923e0fce3221bdac371fe2d05028f30a87dba4f9b4a573b69dc2d6d39320b2","src/fs/co=
py_file_range.rs":"d3b644374390d482b2ff749a2459458872b57d0dcf9670368739b783=
3509a7c2","src/fs/cwd.rs":"9f429a79ace6e17455634da09216ee0ad3d067a4541518b3=
193ae6a8d9ff1e26","src/fs/dir.rs":"347a52f4ca9ac6321c52e802e97ec90d1b4c62ec=
955c8996fc17f8f5aed69966","src/fs/fadvise.rs":"1220e2cf5cf58fc7cc950d487380=
50a052c504f745ca67130daa6410e248230a","src/fs/fcntl.rs":"1d1ee1e0bc962779e1=
cc1b8b76f39c820746240557daa9e14b47b1799120dc39","src/fs/fcntl_apple.rs":"e2=
f23f038083621bcdecc98d02ce1023508afaecdb2ed0fba5c8b70f955301e5","src/fs/fco=
pyfile.rs":"ce565f61e1fbf2e31086077c2f1d01b6bb3b048915edda87fe9a4a4f5e8ff7e=
4","src/fs/fd.rs":"9b3ac2000bc00349cc224b0cf1d77515298d9ed99f75373d2a0cc709=
ef120d46","src/fs/getpath.rs":"28f6970fc1bbc37bb35c84724b59eac436ea7407a452=
2e18c2bdacb1fdd2edd9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f97189cea4e5982a0=
d35b192afeec6340a6c6222e0cb","src/fs/ioctl.rs":"3fb433c912ecf07e787d396951c=
20f174e8d76bd7b2432236547cc75cfb9f30f","src/fs/makedev.rs":"85520b484cb7c15=
ab71ea1c368578ea3b7e484d82f8510db92b6ce9f7ca341ae","src/fs/memfd_create.rs"=
:"a8bf1dced54c7592e71da896021338d5092c1693d12cc42e79bac435fab2792b","src/fs=
/mod.rs":"b1e92f119ce8acbcc55597f5512727622bcd12d6d0ce9fdb2d9b1cfaa9e42a64"=
,"src/fs/mount.rs":"8f6ea2b997dd83c50c90291b9ada3ed77a9ce1ad701c9b0d533b511=
3b317be5b","src/fs/openat2.rs":"4a95c15dab533a41201b5fa25c8a212956b7571d58c=
ad696bdaf45af8aef96db","src/fs/raw_dir.rs":"18ad797876d6230c38d4cacbed081c4=
028e03ace477d0520d9b226b40de942f0","src/fs/seek_from.rs":"a9efa0feb9ac789cf=
47667e91efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","src/fs/sendfile.rs":"e3b2=
058741cf4b1698f34d84bb37130cf2b72806d522a16fe541e832cde136cb","src/fs/statx=
.rs":"613480f0f3277790281b4cfe866ce72e4efdadca691969f6ae5e3ba6fc33a84a","sr=
c/fs/sync.rs":"a3b23543834281f347b0f873bd38154d31d404871188ac08f2b20b919623=
4cfd","src/fs/xattr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6ca3a47200532ca=
6e72d44cbe8334","src/io/close.rs":"2ddae17a2c9dc05fb2cefa134815699c2b3af2ee=
f8026407b8d009cb3ceae6b8","src/io/dup.rs":"335e76f8ad5aa021e654f61e043058e9=
64c2f9914c4785fc09bf6f49f4975290","src/io/errno.rs":"58a4d20ba0924e4d514e3c=
876fbe08982f1623187642ae14780815e65989c8c8","src/io/fcntl.rs":"41c1b370be55=
aaa68144dcc8a67b2d53504a5e6d8ee1bffabac2cc64c66a4043","src/io/ioctl.rs":"af=
4e736b6739cb1ff0477c1b818eeac789258863b79d12e441a08be99d49fb77","src/io/is_=
read_write.rs":"1bfb9ee5d58e0b29b44af12fe2668c7bccc841358698dcde47f1519ff9b=
b73b4","src/io/mod.rs":"75f1d0646be1d4c7c08b5887d8119b0103be8c25c43ccd4e0e9=
7015508c0bb8f","src/io/read_write.rs":"f36488a87a35c37c004f5111e76aad3cf6c2=
c793f41f78f2daba7a84ecae9079","src/io_uring.rs":"b08662af4b1b205ef644ca7517=
688957cf54cab3fc693f6205165550a330a5cc","src/ioctl/bsd.rs":"32ba3399a0fe3f6=
8bb458baafc2a21af9bff655865c7ea70990b7e98a26d3907","src/ioctl/linux.rs":"96=
df90bbc926783f387e8fe1656841d4c7a857fd4e9f41f95492f7dcece33074","src/ioctl/=
mod.rs":"ebb1e0865bed1b98917d4824082caf1445559a0a19f588094db90f46c224f780",=
"src/ioctl/patterns.rs":"bd6e309c8b548dfe04aaffe805972582fb56a0b717c45b4544=
7630bdf9b88433","src/lib.rs":"55f4fe027ab6e638b4613893dffc27a0c20b0bea6f185=
b76f401f34a480b78f9","src/maybe_polyfill/no_std/io/mod.rs":"77889bb5c5a4f2e=
50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/maybe_polyfill/no_s=
td/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9cff3a19049d88c8c8=
0","src/maybe_polyfill/no_std/net/mod.rs":"1e94d21d455bb1da18a4fccb24b3d93a=
d42698e22dd888b78115d6266c80288a","src/maybe_polyfill/no_std/os/fd/mod.rs":=
"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e80771d507c47","src/may=
be_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087cc9afd10269f09a8b4125915d=
c3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_std/os/fd/raw.rs":"f3648c=
7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999e7c6943","src/maybe_poly=
fill/no_std/os/mod.rs":"27dab639a765827644005d5f2fcc7c825310606b889cc8dd83f=
54c9528350dc0","src/maybe_polyfill/no_std/os/windows/io/mod.rs":"5bbcc05c83=
fee5026dd744a994e0458469466d5be39081baa62df07753b92fd2","src/maybe_polyfill=
/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49328b5637cb3bafb96437f2f9f=
269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/os/windows/io/socket.rs":"=
c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5d2c64808308d65","src/mayb=
e_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231a4e778b5f985b9ae712ece5e1=
a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/std/mod.rs":"7c16c86cc73e2=
26e65ead598e4018238b22000a345040b706bf1e1b3eba115fc","src/mm/madvise.rs":"6=
9481cd3354dbffe6cd93b234448e59de6d0fe6440bcf8b12f951f37745bc1dc","src/mm/mm=
ap.rs":"3b0abe64a6a606ea41b06acfc1079bcde1542c17475951e5ed900b86c3e5988d","=
src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761211a494ca6f89b2367a2d2157=
e340e","src/mm/msync.rs":"a9092be024ecbfa9c14edb935404513498b0da2ac6c99fc31=
fe4e58196a95f02","src/mm/userfaultfd.rs":"8073443bd181ff0b3ba4d0b1ae67370b4=
864035a0c8b4898cd709dc47c518ae7","src/mount/fsopen.rs":"1c54a02f04ee6710e2c=
5053c73361eecc499c24cd72c7c7c012dc57a4621e382","src/mount/mod.rs":"5f0c9df4=
727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d12a7136cb19","src/mount/mount_=
unmount.rs":"3805b63d4415d5838bdae34c6f6d50017d09b0d837de141961e66c7fb94dcc=
0a","src/mount/types.rs":"601ae3e10b7dc496fed7f3b40a80e81c6edd7bf13189d7be4=
5c3212d4c684c39","src/net/mod.rs":"7899807c9ad9e3fdbfd8b3ce2a1c7053d4f46dd7=
fa76102f620c6042c2d6314f","src/net/netdevice.rs":"e617af6949ff494de8747f472=
8973eb3564e25a2057b3150a5f609f4ea619784","src/net/send_recv/mod.rs":"b00743=
069268f2671570f76a4ff08b5487a344e5a6a12e62d40c2be5c25ac22d","src/net/send_r=
ecv/msg.rs":"c8ecb0e45df2c6cf655f13025ea7880214e5c085cd9dcbfdfa912f5420a6f3=
a3","src/net/socket.rs":"c1865fee7c354a9cc810853844a86c5ab4ab93dcec5e6de2d7=
6993550b412ce4","src/net/socket_addr_any.rs":"b5fe6f012c67d70e0e4885b9e5d6e=
463c282e12330a0579ea98bdf8fedbccd60","src/net/socketpair.rs":"56f4885c31d26=
64cd16e18a9a88792a4912fedd953cec36dba67e8581fd57921","src/net/sockopt.rs":"=
21d269c34992643d403d50e3071b646cd9ed05dc9bdc53fe2f795bb5df43fa60","src/net/=
types.rs":"bd3ee0cdb102e8cd1f2e0434639084b599a10561fc7f2aaa226d44bf892cef63=
","src/net/wsa.rs":"29856e6d0108be6b719f6ef973c5396e48ddd58ecd0c2db9ca3e2e0=
ba4eccb5b","src/param/auxv.rs":"8655993d7d480f340d8fa3efeb35135e0107510f6c3=
cfb160a9f6dc00ef577aa","src/param/init.rs":"a31c0e5cea61a1a999767fe74f87c0d=
59eeb6bce66578b842fe0e0c32be27a55","src/param/mod.rs":"c514216b96d9520c9ffc=
5662c97b24f1f36f56fe1f5f3c9f64175c8b35577288","src/path/arg.rs":"c0f0a7c2fe=
37192cf6f7b35ae0e17620b863b31e55efb7b2d9f31b5def56a749","src/path/dec_int.r=
s":"8ff8e14442c46f8e7a9b80d73973619b4271549b9defd538479bf8c2d93aa72e","src/=
path/mod.rs":"8355324af7eaa91dce30fc4ebdd161691f9d8bf7a61bde1dde27a1bcca153=
69b","src/pid.rs":"f1c486000c5b1311b2d720cee88f089c17ef9a171709673dd06e6f35=
f4ff98a3","src/pipe.rs":"9f269090dd0588dc8d3feba4f4a78b61891bce91d3c9b64cdb=
ad9251b06a9e11","src/prctl.rs":"19aa584895874ea48b9bbe1bf695b81257b0281df64=
dfdd91e1b4bfa298661b7","src/process/chdir.rs":"911216459aa429fe9f125f1357d6=
900b43b0007835b85c719875d00f79a74664","src/process/chroot.rs":"2b5f6124eb19=
f26ad2705174f7ad50cdc0a5d15abd59ffcf55421228d82130b4","src/process/exit.rs"=
:"48de66e5504a00cb375d8f415ce63b6225a3f5204268d40726a7d0fbba43f587","src/pr=
ocess/id.rs":"e0a26da426962dd5898fbc05700083a68399d5b669fd5f4afaac7b282e017=
8fd","src/process/ioctl.rs":"23ad0285671e8d7ca71a63c50655dbf732ccea8af11d75=
4a0558e0236db37e76","src/process/kill.rs":"96d5ce432c19cf2b600d5248c681c117=
abf53ae94bbfca7e75ac533a40e3968e","src/process/membarrier.rs":"1c4c39b359d1=
d0e9bbe16352eedfca9278d9ef298ade8ec00e998617bbcbfed8","src/process/mod.rs":=
"4fda62909afcb081281bd9a8eaf770dc3dfc2111013231ae23b0a1e101582f48","src/pro=
cess/pidfd.rs":"150413a9cc550ffc432b3279a368223fa9577544ef29e45edeff3b79ae3=
16cab","src/process/pidfd_getfd.rs":"74c778b872be0b800870e4633606461fdc8493=
b259031e35f8f558768d960cc2","src/process/prctl.rs":"0130d05362a17a9282f3391=
189095e1f4f51fb56d7a5205906a0011842df4576","src/process/priority.rs":"f1354=
82e71ea8aa0daf92b9f238051178a4c904070fa8409622f94155df3c544","src/process/p=
rocctl.rs":"75e9f7e5c66e6563aff133ff99b3a35c80a9f0a616d318a93a65be39ebc191e=
a","src/process/rlimit.rs":"10b79de3ced0e64059a94c879742d46a35a6176c776d8ee=
d75031d5e6340283d","src/process/sched.rs":"6c976daf5b5a30aa9a33456d23a46f6f=
4d257642963eb142b55e13a53aec4c56","src/process/sched_yield.rs":"6565faa3928=
b66ddc74a65e893e15edfa4b9be4f7e5f5f68527501a7f6bc3350","src/process/umask.r=
s":"1a0f31a842303c978e3f05ec191e2b5e96104c09c6596473b42b1fac34898a50","src/=
process/wait.rs":"f9c73dde2a66dfbe448501f039396dd26c5d678e4f8cb61c1f78014b7=
b49fcd3","src/procfs.rs":"4d4812a8db6897dabc33269ff59bf6d7192a65be977e87961=
3704e29a8b73505","src/pty.rs":"652c412e7280d0344b3f9bfe376c106a7f1b42b898b7=
af344e6e72da268e2bf0","src/rand/getrandom.rs":"0a5320eaf5dd4c6d9b1252c41ca2=
86b40a9ce813eb469c89dba41e6258612740","src/rand/mod.rs":"e1fb7542f1958fe776=
73aa628bd92fef1b9addf79ba23df2398d1231cb61c148","src/runtime.rs":"958cdf156=
7c5758c73c197fc36d1feffb414a22a76a7a287afc84f330f2d2279","src/shm.rs":"b96f=
e8a05ee5d4536464a8843a776d43a938abaf22c772fc35b5373d95644a8d","src/signal.r=
s":"a294b49d487dafaa42e534f8b1d93e87bec135087676b2ba2ef865cf2fccdaf2","src/=
static_assertions.rs":"504cf66f0d5b8e335be02f9ae8b0a355abc98c2c82eec0098bdf=
0988e662e260","src/stdio.rs":"6f78cbc0d102eff9354fa1fdfd1b63a45ea159d0a9ac5=
d25ecf703383b847b55","src/system.rs":"e048eccf6f60ff49fa3312e7a01a9f641787c=
195c4db745f1f5a2f2c443d7e91","src/termios/ioctl.rs":"a1ac967f7811a482f8bb53=
847c37c8359f518cd26da9df7b816ba678a0139623","src/termios/mod.rs":"b44b7caa6=
0b6f458657ed58a0e0eca41bb4e6d6be4b0f042bbb8ab7056cebe4b","src/termios/tc.rs=
":"9af4eb264bf23bc0b0ad1707fcca687020b20f0775a28209b237fbb72089d991","src/t=
ermios/tty.rs":"35a5fc2d26501e0e6dde1a755eeccf7b4f3b4702c5bac30e0953220808e=
f7034","src/termios/types.rs":"b5671eedf541754c54f680002bafed1adbabce172d09=
d7c4d31fdf9313ca18c8","src/thread/clock.rs":"83681fa00d5efa15c5b7cba10015a0=
c99d855c4ac78714e3989d91c999e5ba80","src/thread/futex.rs":"985f9a0dce1e2a48=
92ae7f26bd1bf119ceae3f9fa6b4707e166624fc1cee76d4","src/thread/id.rs":"bc4cf=
152388962303ea835b97acd64e499ecd15f94eaf6f133ff5a1a582377ba","src/thread/li=
bcap.rs":"4c51b7df566d38dd0f85f81ef53279a745a39f0f4e1154791fd38438e2ca7db1"=
,"src/thread/mod.rs":"09b19f25ed1aa65f6605ed7deccc4bd945e3ae872a60275787f44=
944a73edf3f","src/thread/prctl.rs":"ebc89b731eb8fd1a8f82a50dbba849061476a45=
37bba8702b29db657d5287ffa","src/thread/setns.rs":"ea9142b1f3a5b3f329683be18=
5f960c50e5c1636149e91fbf59e88a897fc607d","src/time/clock.rs":"e59a29f1bed8c=
31c3d5b6fad60f2d4fa6cab8dd8e86148bb3693a5e3a1ce735f","src/time/mod.rs":"43a=
fee938c80d124d04d4ba190c03f4d21d1e3bfc154fff309211e4f6eabe940","src/time/ti=
merfd.rs":"f17092b84553741aa2d2b44c6992b5d2c8c96cc2c2007fc9a2c6b2064485e53f=
","src/timespec.rs":"32a4d930cbc0f6dbd23153290db920671cf4ce65a4a127e176f897=
c1cde42d7d","src/ugid.rs":"6616c6e35b7e43aee5b150f1efae7a50711e0947943c9a96=
833dbe214ad9e85f","src/utils.rs":"9ae76f8a41d6cc350cdd58c9084b5c3a5a708eeec=
d769783debdbcbaef442182","src/weak.rs":"7e3169bc97e76fc4d52b040391a8df36b06=
536fc0f81cc6e8e71b951cb1fe54e"},"package":"70dc5ec042f7a43c4a73241207cecc98=
73a06d45debb38b329f8541d85c2730f"}
diff --git a/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.37-fix.patc=
h b/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.37-fix.patch
new file mode 100644
index 0000000..c9e5e83
--- /dev/null
+++ b/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.37-fix.patch
@@ -0,0 +1,103 @@
+Fix cargo build on riscv32
+
+riscv32 support is added to latest rustix already
+therefore this patch is limited to rustix-0.38.19
+once cargo/rust moves beyond rustix-0.38.19 as dependency
+we can remove this patch
+
+Upstream-Status: Inappropriate [Specific to rustix-0.38.19]
+
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+
+diff --git a/vendor/rustix-0.38.37/src/backend/libc/termios/syscalls.rs b/=
vendor/rustix-0.38.37/src/backend/libc/termios/syscalls.rs
+index a833aea8d1..71b4c6abd7 100644
+--- a/vendor/rustix-0.38.37/src/termios/types.rs
++++ b/vendor/rustix-0.38.37/src/termios/types.rs
+@@ -1209,17 +1209,17 @@
+             Self::VKILL =3D> write!(f, "VKILL"),
+             #[cfg(not(any(
+                 solarish,
+-                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
++                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
+             )))]
+             Self::VEOF =3D> write!(f, "VEOF"),
+             #[cfg(not(any(
+                 solarish,
+-                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
++                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
+             )))]
+             Self::VTIME =3D> write!(f, "VTIME"),
+             #[cfg(not(any(
+                 solarish,
+-                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
++                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
+             )))]
+             Self::VMIN =3D> write!(f, "VMIN"),
+=20
+@@ -1227,12 +1227,12 @@
+             // have the same value as `VEOF` and `VEOL`.
+             #[cfg(any(
+                 solarish,
+-                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
++                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
+             ))]
+             Self::VMIN =3D> write!(f, "VMIN/VEOF"),
+             #[cfg(any(
+                 solarish,
+-                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
++                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
+             ))]
+             Self::VTIME =3D> write!(f, "VTIME/VEOL"),
+=20
+@@ -1250,7 +1250,7 @@
+             Self::VSUSP =3D> write!(f, "VSUSP"),
+             #[cfg(not(any(
+                 solarish,
+-                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
++                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
+             )))]
+             Self::VEOL =3D> write!(f, "VEOL"),
+             #[cfg(not(target_os =3D "haiku"))]
+diff --git a/vendor/rustix-0.38.37/src/fs/ioctl.rs b/vendor/rustix-0.38.37=
/src/fs/ioctl.rs
+index 490f183ff4..d131cfcb51 100644
+--- a/vendor/rustix-0.38.37/src/fs/ioctl.rs
++++ b/vendor/rustix-0.38.37/src/fs/ioctl.rs
+@@ -50,7 +50,7 @@ pub fn ioctl_blkpbszget<Fd: AsFd>(fd: Fd) -> io::Result<=
u32> {
+ ///  - [Linux]
+ ///
+ /// [Linux]: https://man7.org/linux/man-pages/man2/ioctl_ficlone.2.html
+-#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
++#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
+ #[inline]
+ #[doc(alias =3D "FICLONE")]
+ pub fn ioctl_ficlone<Fd: AsFd, SrcFd: AsFd>(fd: Fd, src_fd: SrcFd) -> io:=
:Result<()> {
+@@ -79,7 +79,7 @@ unsafe impl ioctl::Ioctl for Ficlone<'_> {
+     type Output =3D ();
+
+     const IS_MUTATING: bool =3D false;
+-    const OPCODE: ioctl::Opcode =3D ioctl::Opcode::old(c::FICLONE as ioct=
l::RawOpcode);
++    const OPCODE: ioctl::Opcode =3D ioctl::Opcode::old(linux_raw_sys::ioc=
tl::FICLONE as ioctl::RawOpcode);
+
+     fn as_ptr(&mut self) -> *mut c::c_void {
+         self.0.as_raw_fd() as *mut c::c_void
+diff --git a/vendor/rustix-0.38.37/src/backend/libc/c.rs b/vendor/rustix-0=
.38.37/src/backend/libc/c.rs
+index 02958698c0..27f5eb7c86 100644
+--- a/vendor/rustix-0.38.37/src/backend/libc/c.rs
++++ b/vendor/rustix-0.38.37/src/backend/libc/c.rs
+@@ -6,6 +6,8 @@
+ // things below.
+ pub(crate) use libc::*;
+
++use linux_raw_sys::ioctl::FICLONE;
++
+ /// `PROC_SUPER_MAGIC`=E2=80=94The magic number for the procfs filesystem.
+ #[cfg(all(linux_kernel, target_env =3D "musl"))]
+ pub(crate) const PROC_SUPER_MAGIC: u32 =3D 0x0000_9fa0;
+diff --git a/vendor/rustix-0.38.37/.cargo-checksum.json b/vendor/rustix-0.=
38.37/.cargo-checksum.json
+index 487061f297..42d107a480 100644
+--- a/vendor/rustix-0.38.37/.cargo-checksum.json
++++ b/vendor/rustix-0.38.37/.cargo-checksum.json
+@@ -1 +1 @@
+-{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231d2=
fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b0532d=
35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"a362ec65b559b77cc80326=
4b97d53ea761c9ee98787012128054d6ad1a3d0c2b","LICENSE-APACHE":"a60eea8175145=
31668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2.0_WI=
TH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39ef1f9=
4f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a715d9d2=
b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12ba79e=
4cebb6983a7b6491949750aecc4f2178","README.md":"fbd9eb025cdb6c58d28649f0c913=
2a4e383014f03a8e0edba04a4e36cc45fba0","SECURITY.md":"4d75afb09dd28eb5982e3a=
1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e67273aa0=
a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"adc4bc868a=
30a902f328af6ebd0bfc72868b8e388beb13c6d69d826646931b17","src/backend/libc/c=
.rs":"e111414bce945426bbca53cd018e74300d57089a63b546652a62f63f52ba25e2","sr=
c/backend/libc/conv.rs":"e8d55f9cc427d19de13bde83b50ce02faf0afd32121c8adb2a=
2cc9f551a562d6","src/backend/libc/event/epoll.rs":"6b68d0002519ad9894391562=
ca062aa02f696cc0a2a84bbe750891619f5b0c35","src/backend/libc/event/mod.rs":"=
ad30f99f7da0768c18fffac6ec71e658bfed2e44f0634f48c2e0ffe4677ec231","src/back=
end/libc/event/poll_fd.rs":"e8cd06835771505b3c803b17c6097e59cf8743f62b2c46d=
ccbe7afc9a90cfca5","src/backend/libc/event/syscalls.rs":"7ea9d27dfbc5fe5f87=
3e9dd1a1059f42327c099b84f543718a612a0512dfbbc9","src/backend/libc/event/typ=
es.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f13","=
src/backend/libc/event/windows_syscalls.rs":"ebfac665c6676c4b803134ab8806be=
8aa2e96bdbc7799a19c544cd9069b35787","src/backend/libc/fs/dir.rs":"836273d76=
4eb7c1cf09b5ed20baf20a99d9c9afdf448c9fda50f0927c173cc89","src/backend/libc/=
fs/inotify.rs":"69376ba2e81f98164029888d0cae554ca1702b532b0045dc55e282f1dd5=
2d7bb","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f329ad3=
5bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803011b5=
7da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc/fs/s=
yscalls.rs":"dbce2106ab58e7fcd1aeeb3aa1f361aacdfdda1171a1a0f49aebc4e88f2333=
a7","src/backend/libc/fs/types.rs":"b1ffff2b0a0c56dcb3507431a0100c70505ea75=
49ac5267752842d7e30500529","src/backend/libc/io/errno.rs":"bd1a92ffc3f632ae=
7292b7006a7c890433a3bee8d67a63c299333850a91e99be","src/backend/libc/io/mod.=
rs":"746647bd864e4ec7717925b6d176cebdb392b7d015070244cc48d92780351dd6","src=
/backend/libc/io/syscalls.rs":"91ebf37b8abdecf619c9bc3521b1b4c6795369c66875=
3586e1af79d04fb982b0","src/backend/libc/io/types.rs":"2efd39bb3df19a9db5496=
217284f3d2235ddb354fac81dd71861109a56bede0b","src/backend/libc/io/windows_s=
yscalls.rs":"24f7abe92406f3f65c1a42a4694c2112142106a341d024ffc2d5905a9f2893=
39","src/backend/libc/io_uring/mod.rs":"2c6478857a0751625edabd61acb841819bf=
ba1093b1faeded15693c805d84952","src/backend/libc/io_uring/syscalls.rs":"522=
1a498e6c396d7c4cb60168ce8459ebca7d6720349a426d8083c227c694212","src/backend=
/libc/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/mm/syscalls.rs":"c04c61ad3d7f3b24d13f89144d7fa0a=
05658cea4763207f9250db4f9362de2fe","src/backend/libc/mm/types.rs":"40b7888a=
1439afae2705e0c724ae0821a51d32ca5740f1ec16ecb6dc1adc883d","src/backend/libc=
/mod.rs":"087d2676df88510b089255053a4865e62c64172723588386fe8244d2f1a681c4"=
,"src/backend/libc/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287=
b25a5bfe489fa1d07f7cfd7","src/backend/libc/mount/syscalls.rs":"d2d35f7ae989=
bb52722e28cdbd775243c5d7da9eb411e0b2b9632f2aa7c1533e","src/backend/libc/mou=
nt/types.rs":"5c2eaf22e7a29e8e48cb19e40c88d040ba1c891038a611e85571476489dc1=
2cb","src/backend/libc/net/addr.rs":"920ff7645055ca4e7d4019b9dd4ea1f211b708=
a62ef5d4049494f8dd3fe8d2aa","src/backend/libc/net/ext.rs":"cfce41130eb2e3dd=
04271e0aa2c1e2de9866397d7d2a59e917d26b784ea30df5","src/backend/libc/net/mod=
.rs":"562d23225d6dba8f095e3ca41af60dcf6cc40c2cf17bf028f90888f809e86f07","sr=
c/backend/libc/net/msghdr.rs":"6f8aba792b4adef5c5d3d4324a813a67a063a50d1043=
7bb19bf7496666bd6de6","src/backend/libc/net/netdevice.rs":"078bc108540457f0=
e5849c2b8d2f1351c4aaffc910f8c9c9857969477c22065e","src/backend/libc/net/rea=
d_sockaddr.rs":"b094d2cb84b2eee5dd411d21458192c03eea0e420e78149441d7ab88a89=
3281a","src/backend/libc/net/send_recv.rs":"b5714bed2cc6f2ba42bf90d19655b50=
7c2a248e2d05270b1355b6d4cb8e4f9fe","src/backend/libc/net/sockopt.rs":"0f424=
615b2982826da6e57e9b0bb38442288152464f67508fa5bd66a6d0c9827","src/backend/l=
ibc/net/syscalls.rs":"552eb57bda272f2372e180f927a88dce67fcef46e7c1378d47d59=
5eb2abd578d","src/backend/libc/net/write_sockaddr.rs":"b62e40c9d4a4e70746d8=
64434db140b4b3c1f110a3fd2e7acfbb3f2ccf15d6aa","src/backend/libc/param/auxv.=
rs":"c29b29ad65f66e048debce5293bf84164811264e61b71a28a57225400d3b9529","src=
/backend/libc/param/mod.rs":"5234b8f1bcb886cca6ea003d411d75eaeebe58deedd80e=
3441354bf46ed85d4d","src/backend/libc/pid/mod.rs":"2c6478857a0751625edabd61=
acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/pid/syscalls.rs=
":"49ea679b96c0741d048e82964038f9a931bc3cf3a0b59c7db3df89629b9c49e6","src/b=
ackend/libc/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe=
489fa1d07f7cfd7","src/backend/libc/pipe/syscalls.rs":"219c31200f333ce803370=
bcbfcca529f7635c51b31e4576269faaa6b288cd920","src/backend/libc/pipe/types.r=
s":"f87e43bae418d00fe8b333877acc3b6aab4cf4d123f02ff048a21866486e1404","src/=
backend/libc/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faed=
ed15693c805d84952","src/backend/libc/prctl/syscalls.rs":"8a2684f444a7555098=
dce2b92270d81cefdae902716c6e5d59bd7b0657e8a29d","src/backend/libc/process/c=
pu_set.rs":"5fca2b47289a2bb6ba908c910a6d27ac78ac10ea21d3c0c018f72f8816c5b9d=
7","src/backend/libc/process/mod.rs":"806e26da8d1e7afae502987fcd650f4d348da=
147b8a2e74447affdca153e2e97","src/backend/libc/process/syscalls.rs":"b4a7d0=
9cf46c65997a28dc5f075e90943b2581b7df99cd66cdd18e87fe96600b","src/backend/li=
bc/process/types.rs":"fb2caf34b17079aa72c04aed0f9a31d534ea8e8b73a80c758b748=
bf5e38df52b","src/backend/libc/process/wait.rs":"0cc556aed976b4bbb3965f74fd=
76b8216c755fce25043b7b21ce54afa07c9773","src/backend/libc/pty/mod.rs":"2c64=
78857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/=
libc/pty/syscalls.rs":"566fc9a2cb2e38d7d7ac2405b22c0522369cae4a8f4fe18b5512=
3ba94d3d5a95","src/backend/libc/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f=
4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/rand/syscalls.rs":"3=
5ea6b6e0f8a7fb064fd5cb33a3a855cd161a6a00f93d76c861b2a2c66db85e7","src/backe=
nd/libc/rand/types.rs":"4eb0b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a705ec6=
05b773f63f880","src/backend/libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f=
4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/shm/syscalls.rs":"60=
d797d4e85e08e6330e6b8d80094356ce377e5484952f88ae2a6e49231c268c","src/backen=
d/libc/shm/types.rs":"0a1ac6bb9c024d94eb4bab7452937b7befcb30c581dc787b80501=
1407ba1442d","src/backend/libc/system/mod.rs":"38563ea68829ca5a4b1b0695ac8a=
5c05718e85bdc88a36dc805efdfce45d3909","src/backend/libc/system/syscalls.rs"=
:"c18c2942811ea93af3125b58d00a1da05c54e5ff438a3dc44cda53bc9d6fcf03","src/ba=
ckend/libc/system/types.rs":"6871e16aee14fe2ae03cea798c3e509ffe44778a9c0e56=
08fd73e2e015876d7e","src/backend/libc/termios/mod.rs":"2c6478857a0751625eda=
bd61acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/termios/sys=
calls.rs":"2720e443c118e1c0311dbb3efa4b54637b6e607bb123ccdc0f5d92b5628573c2=
","src/backend/libc/thread/futex.rs":"064463c4a4f6549aec0797d44e44b862eb010=
0efe97aa293b4dad10034cae800","src/backend/libc/thread/mod.rs":"fa710053974d=
7f16a6c49242ee6c10a3b9e1143452b9daeaed8837302a679fff","src/backend/libc/thr=
ead/syscalls.rs":"4cb65db4fe0c7d6016dd0dfefa610b369234b6b9db0c75c0fcb9ab8cb=
25a16ac","src/backend/libc/time/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c0571=
8e85bdc88a36dc805efdfce45d3909","src/backend/libc/time/syscalls.rs":"bf847e=
94cc156bdb553755baa88dac240db4dcaf690f303b0f205777c5a9cdfc","src/backend/li=
bc/time/types.rs":"d0307994ffddd3f21f702d9ae4400750aecccfaf4a01268161dc4fd7=
2de5c373","src/backend/libc/ugid/mod.rs":"2c6478857a0751625edabd61acb841819=
bfba1093b1faeded15693c805d84952","src/backend/libc/ugid/syscalls.rs":"8edf9=
1b8790add23902c9f5418da6b0723a371677f29f490e0c8af852f0f1a0c","src/backend/l=
ibc/winsock_c.rs":"502da2ed3cd6ca99bb7ee08b0b30e25c212632885cec965f9816366c=
6b931ac6","src/backend/linux_raw/arch/aarch64.rs":"2a255c9135bc8a321c180f52=
b88eb2b158bc9170cd222149caeae63c24587d44","src/backend/linux_raw/arch/arm.r=
s":"165bccb5883d0136e55d42091183765f83d86e9d37a7cb2cec9ae8af32774db6","src/=
backend/linux_raw/arch/mips.rs":"aca20118a73063e4f2f8e7b261b1266d216e826df2=
a98cad99c53c40b0971af4","src/backend/linux_raw/arch/mips32r6.rs":"a7ebd0886=
e2e0d3b39996778fb665b68738f8a67d67b47e43fdba7e7cabb6d1a","src/backend/linux=
_raw/arch/mips64.rs":"ba947f286522b8034d509887cff8183cca34766aed5d37c91667d=
ba22e2f608a","src/backend/linux_raw/arch/mips64r6.rs":"27de08ce1003a48f1d8b=
84746e724e8766b980e4ddc4febb6e20eb31067fb137","src/backend/linux_raw/arch/m=
od.rs":"37eaeea601d39be00d170856a31a8ec6a27b0d3ac22ab3ee642ab0e45dee237d","=
src/backend/linux_raw/arch/powerpc64.rs":"dfb001f8636a5e46d728900b0804fe6c3=
74e5e18a6f0e76d7d62e0c07da74477","src/backend/linux_raw/arch/riscv64.rs":"4=
1d33242d941030f46077dc2b1bc4c7913fe7630d693a5a7eef966bcf38f9d8b","src/backe=
nd/linux_raw/arch/thumb.rs":"2fd979ab421248c0a4c592bc0cefee63edc26528f469b7=
1b63eaed35356e42e8","src/backend/linux_raw/arch/x86.rs":"8fba9762bb0e8bb9a7=
1890cdf413441aa52d2bf41690ec0ef01c97ac11759a5b","src/backend/linux_raw/arch=
/x86_64.rs":"e929036a1f3cf93ba538f4523b241605cc7b5e61f84ffe6d9d5cdbcb6f73e5=
43","src/backend/linux_raw/c.rs":"445e311dc24a176603008d0a7d7714a564821db31=
79052da797027f8fc7ae4fc","src/backend/linux_raw/conv.rs":"43e62870f91a480e1=
0e2485546c95e70e61c72f96306921c796a7094ea404d3c","src/backend/linux_raw/eve=
nt/epoll.rs":"db05715e1bd3b93c6873695c89f04abb97768a57e7e402306f568eba844e4=
07a","src/backend/linux_raw/event/mod.rs":"72e46b04637e2d1d2a6b97af61614499=
5399e489d1fe916faf835d72fc8c64cd","src/backend/linux_raw/event/poll_fd.rs":=
"a5773464e9e30227b4046f029a27d3daf2c7bd0045e54565cf1a8ac2a0d61e81","src/bac=
kend/linux_raw/event/syscalls.rs":"5620d7dd5fbcfef550cfa94df7593caffe0deccf=
0f754765751e562edb7d2b2f","src/backend/linux_raw/event/types.rs":"0551b18f9=
82e233a0a06d8a9c3dbb29de0c204dcd64dd6f7e88b6c96fa9a9be8","src/backend/linux=
_raw/fs/dir.rs":"fdf849d058c387551e102bd7fec31e3ca40c18417a1e530cfed1daf3df=
2c4de3","src/backend/linux_raw/fs/inotify.rs":"e627e8f48e8f4dc2117746117aaa=
7f151865103be64e446011c72878921e402e","src/backend/linux_raw/fs/makedev.rs"=
:"c6b4505c4bcbbc2460e80f3097eb15e2c8ef38d6c6e7abd78e39c53c372139e2","src/ba=
ckend/linux_raw/fs/mod.rs":"3d3a42bbf4d086f806d7d9f6e4b0a49a873dc27f4f03ffc=
a0921f5536acc24e5","src/backend/linux_raw/fs/syscalls.rs":"6e2ca8d96be2bf94=
b38512d184a22d79385a6841419de2590f9e5af33d002920","src/backend/linux_raw/fs=
/types.rs":"6102a5b8207f959edbcc2fc233a6145a265a428c0c4fa195472fe7fe6dc5165=
d","src/backend/linux_raw/io/errno.rs":"5d1c95eacf1794be6c2ea83e40b6023ae86=
abc2c83ca16de6c70a2020fb905c6","src/backend/linux_raw/io/mod.rs":"7ae232442=
7892cca6f5ab53858d847b165f790a72ec25f3d99fb15f0506c9f27","src/backend/linux=
_raw/io/syscalls.rs":"54ac1395fb4801ef2ec6639113a6e23c4b532d84b6495f7166fcd=
0492cea09f9","src/backend/linux_raw/io/types.rs":"d0df5a62248e1ba19af0f89f8=
6da7ba2312d97065c2814ddf6b08a4a0db23bad","src/backend/linux_raw/io_uring/mo=
d.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","s=
rc/backend/linux_raw/io_uring/syscalls.rs":"7e40703cc3a020377a4a23bc8651bdf=
1d65b8f62e174eafb85d27d246f86c39d","src/backend/linux_raw/mm/mod.rs":"8aa96=
6faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/l=
inux_raw/mm/syscalls.rs":"c7fc0f49283026b0df47463ed47394634e5664468f36a5eb2=
a89bf259bbfb67d","src/backend/linux_raw/mm/types.rs":"821409c463a3195404807=
5906b3fe5bdb029badf9c9e2689bfff8f6dbf5b0bed","src/backend/linux_raw/mod.rs"=
:"f849feea0a83df69fb9288ecfe07992cbdaee7e55d29b5662043a3fdf00e4700","src/ba=
ckend/linux_raw/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25=
a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mount/syscalls.rs":"8442c82814=
961f69c488222faabb82c44d2e7227b10faff919cbbd197bb47484","src/backend/linux_=
raw/mount/types.rs":"9a33214816863fc92846fbc99df6ddf60a3e772b34f4bb3f5e8a40=
ef489130d3","src/backend/linux_raw/net/addr.rs":"7239e4fa8c6872bf978e2f5805=
63c51c72d6ae6f96b77520fc7b9ece62fa0ebe","src/backend/linux_raw/net/mod.rs":=
"5640bbaf4963ac4575b0537173422ed6f6a43f34a8f6b656e7257fbbb13e5bcb","src/bac=
kend/linux_raw/net/msghdr.rs":"8b18974b81ee78af7a5c64733041dddaaa378a46cab8=
b984bff5b3b4be499751","src/backend/linux_raw/net/netdevice.rs":"3cb28bcd762=
e2df595481b4379a08170f59f99d367aa03424531c19e4c5aaf55","src/backend/linux_r=
aw/net/read_sockaddr.rs":"7cb3c8bcc80c5eee8602323cd83f36c1784927d9dd0c40ded=
29af6fb09c57ece","src/backend/linux_raw/net/send_recv.rs":"d4e81c01db50dad1=
c02e9aa3e0979f8052431a3f64c8864681d9ea52a34ce3bf","src/backend/linux_raw/ne=
t/sockopt.rs":"d7dc73886a6c0671b3bdc4cbe8c49def8dc5416864f9387bc5aee72319c5=
b162","src/backend/linux_raw/net/syscalls.rs":"0138662012ca89e063b3a03cf8fe=
17b97fbeb38a3d18c42938ae047a4a392105","src/backend/linux_raw/net/write_sock=
addr.rs":"0efa4e17b4008da2cf2aada2d18acfccd31a3b49cf8ac5d608e77f3ea6627fec"=
,"src/backend/linux_raw/param/auxv.rs":"af132fa16b37a17c43ed5d099b27789d456=
f3cb92abb81139231bf9407599858","src/backend/linux_raw/param/init.rs":"f2275=
a2324a99be8d804fb3b7fdf86a43c7d428f660280b7e0e7d19c357f0200","src/backend/l=
inux_raw/param/libc_auxv.rs":"0a223ad36a33611370cdf3c666008fd61d15f2477fd3a=
5ac2c78972079fb86a9","src/backend/linux_raw/param/mod.rs":"2e6a1a1c00351b9c=
88bd615aa923f71d76208df5626dd9bea03067f28f81dc31","src/backend/linux_raw/pi=
d/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952=
","src/backend/linux_raw/pid/syscalls.rs":"eef6aa01830ddd510b83f507da2002c0=
3e58318b73744be2c06ebbe33c4f194f","src/backend/linux_raw/pipe/mod.rs":"8aa9=
66faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/=
linux_raw/pipe/syscalls.rs":"ce1f72fcf0cb7772e6d9bd5791a39aef329ca7f729fd47=
431a93b950cf0568d8","src/backend/linux_raw/pipe/types.rs":"ae643a774e6343df=
02b9b99b842fba8b742dd9b1f97b5c5b2b504f2840bf3fd2","src/backend/linux_raw/pr=
ctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d849=
52","src/backend/linux_raw/prctl/syscalls.rs":"a18b224307e0d27bda9b7b85c75c=
d6c7ddfe39f5ce52efb7bb0bf0585b757343","src/backend/linux_raw/process/cpu_se=
t.rs":"b31889f972676f57e3599375dfcd59dd72975977ef345d11c22d51f0d4a6400b","s=
rc/backend/linux_raw/process/mod.rs":"fb393c70a9c63ef9a6bf1fb5a2dc94f07d6b0=
b6987cc5231c15c607015dafd68","src/backend/linux_raw/process/syscalls.rs":"4=
c7e3e5aad98b63162e110deb1f58b15b46b9c5fe7fd0f579e1c7dc1c3d2df16","src/backe=
nd/linux_raw/process/types.rs":"6811ba822bc12a1a6336649151b4adb1f5d3365684a=
31c07f01953ea9547743d","src/backend/linux_raw/process/wait.rs":"921aee4b004=
8746087f52615a98edc2aa0fb4b53d6df44be4533098df55d1b05","src/backend/linux_r=
aw/pty/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d=
84952","src/backend/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae87b1ca58d82efc=
58007b9dddaae78460d615f48da19d1cd0f89","src/backend/linux_raw/rand/mod.rs":=
"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/bac=
kend/linux_raw/rand/syscalls.rs":"317cdaf243623329ee345131054e86a06a0863a9e=
90c5dba73e1ac3475ba6305","src/backend/linux_raw/rand/types.rs":"a21dbb1ab31=
eed6b59a57520be5a3c603c36d18ea74e67f7527f40835ba209a3","src/backend/linux_r=
aw/reg.rs":"6bfb53575494f5de76d5112a7e4eb6d0c266b1af0a275aa33b9bc9e6e7a2f41=
c","src/backend/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92942f06ea0b6846=
4040dcac33c6f0f7ee392c6269993347","src/backend/linux_raw/runtime/syscalls.r=
s":"ec1c43952f8a518ff152cb798ca6a67432030568a9d355532254b68cabd20d2c","src/=
backend/linux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cdba6e8c91414113=
a04a739160929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":"8aa966faf3853=
d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw=
/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d93794540087b3182cbdf=
3cb9c8db","src/backend/linux_raw/shm/types.rs":"8275dba36a8f2c4208f2d23ffef=
52c5b02d4b10d5450733cb4fc5cdfcd6285ee","src/backend/linux_raw/system/mod.rs=
":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/b=
ackend/linux_raw/system/syscalls.rs":"19a7ab17de906ec237f16a816da036723c1f5=
5f605e8e4a26689343eb4cd76e7","src/backend/linux_raw/system/types.rs":"1ceab=
8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e","src/backend/l=
inux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded=
15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":"1a42438153f61=
e72aab7c3c8fdd0c3ab918da0fec58e07bb42423518065374e2","src/backend/linux_raw=
/thread/futex.rs":"0139394e11006301e98379b7f07604aa10fb436b43acf8f55f1a24f1=
253f96cc","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90b9234e79900b27ebb=
e8837e3a7a36aec532912e3e253edce5225067","src/backend/linux_raw/thread/sysca=
lls.rs":"e2c89bd3cf34a46b5d06de43933284ddd06ed07e9c789c726c1afa48f7842a5c",=
"src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7452bb1cc2d28b5f0aaa8=
40a2856fe363acce624e1beefc","src/backend/linux_raw/time/syscalls.rs":"7dc69=
75bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de9404845312fc","src/backend/l=
inux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a81d3305e18e726e54edc5a5=
474641f3cdc278","src/backend/linux_raw/ugid/mod.rs":"2c6478857a0751625edabd=
61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/ugid/sys=
calls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db84f444d3251309b7a0480b54f7=
","src/backend/linux_raw/vdso.rs":"056314f72c71d4b041739337ca2098afb7fe070f=
844327f462c293f43481b75b","src/backend/linux_raw/vdso_wrappers.rs":"9690224=
78cb48b9b81a549853720f76c2c276a746e25d17c0762f76b377a73b0","src/bitcast.rs"=
:"4d2b3619dac1500bee223e11db0b4a5f75b0fbde65094bab157597af71f6b72a","src/bu=
ffer.rs":"e75713877ba12f4a5c9b482df79b219363965d5311809ecf6b6becf1eabb5e46"=
,"src/check_types.rs":"e52f710e1cfc12ca13a495f2b43c227b293ff295e1ce3ab33293=
5b28a7579872","src/clockid.rs":"bd66d6bdc6b73a4668dda5b6f91838b6ed6c4b9503a=
0798b071ef35c572b711d","src/cstr.rs":"41af2a4429fe6c67a8883f8a8f63d66c90df5=
66abda74fd2b03bcef7b9f24218","src/event/epoll.rs":"0d051674b9c1b3f118ad65e2=
b46b4b3cab5551d5dde4e1c40b3af14854a826c7","src/event/eventfd.rs":"81cbd08f7=
bdf40a6ce1ca692b63da1dc8ba925282990668d9d68f1203e839fa1","src/event/kqueue.=
rs":"1f381c8afa65d36e3052c476d2e679c3bccb7e3d6cc6b95ba53b48abcbe13a81","src=
/event/mod.rs":"4dd296e8feeb0e29b9b63eeeae6169786f76fdd6138489795a5829a189d=
3ac1a","src/event/pause.rs":"930219e19ee227729c8f86fe7271721e8797e917d2d707=
3fa8d7a104bf6189c0","src/event/poll.rs":"f8da99d1136502040314259ab7700570bf=
40df0ea85b94dcdf6f5d1c4073551d","src/event/port.rs":"4e51ff150e5d17cbd44aa6=
4a38b99c15e26eaaf2e350768b5dcacdfde4fa5212","src/ffi.rs":"50a14dfe10408f9ab=
c6269b9ee6e7a88d99503d50b3732288e85b777915e579e","src/fs/abs.rs":"1c1e65be0=
8da5f7d6e5b8902283855fef0f0a74ab227aae991aaf5310d0858f2","src/fs/at.rs":"b9=
5242387489425714589bc84cf8f3943f3a02f57cc6ab4347c4eaf648b09e5d","src/fs/con=
stants.rs":"23923e0fce3221bdac371fe2d05028f30a87dba4f9b4a573b69dc2d6d39320b=
2","src/fs/copy_file_range.rs":"d3b644374390d482b2ff749a2459458872b57d0dcf9=
670368739b7833509a7c2","src/fs/cwd.rs":"0933a06846a20c12fb12cb556c03133d373=
49d104e4f2d99379a674d1cf78562","src/fs/dir.rs":"347a52f4ca9ac6321c52e802e97=
ec90d1b4c62ec955c8996fc17f8f5aed69966","src/fs/fadvise.rs":"d77f6a7f7f6648e=
750888719e59f0f8332f11e84442ef72f622bcbd4e19be845","src/fs/fcntl.rs":"6aa6e=
b0c87fdd915974e425dd4881038c3658f05fac0bc005a9b40107474ef1b","src/fs/fcntl_=
apple.rs":"e2f23f038083621bcdecc98d02ce1023508afaecdb2ed0fba5c8b70f955301e5=
","src/fs/fcopyfile.rs":"ce565f61e1fbf2e31086077c2f1d01b6bb3b048915edda87fe=
9a4a4f5e8ff7e4","src/fs/fd.rs":"31943a4eef1ee6909d7db48b0d577b4429789726d85=
1e7aa4f9af43e87722b6a","src/fs/getpath.rs":"28f6970fc1bbc37bb35c84724b59eac=
436ea7407a4522e18c2bdacb1fdd2edd9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f971=
89cea4e5982a0d35b192afeec6340a6c6222e0cb","src/fs/inotify.rs":"2e4b9824c323=
c661667aefe06383cd3e843a34676852d9f5f79f62e48e975171","src/fs/ioctl.rs":"1d=
17e7be9ef4f9f69358bf474a669f0eeb0e8516a3626befc1bf61bee0221d89","src/fs/mak=
edev.rs":"85520b484cb7c15ab71ea1c368578ea3b7e484d82f8510db92b6ce9f7ca341ae"=
,"src/fs/memfd_create.rs":"a8bf1dced54c7592e71da896021338d5092c1693d12cc42e=
79bac435fab2792b","src/fs/mod.rs":"600a5ddd606d60460ec887dbeb843fdcf1b5204e=
d8d95eb0abbd89f33eae6e66","src/fs/mount.rs":"8f6ea2b997dd83c50c90291b9ada3e=
d77a9ce1ad701c9b0d533b5113b317be5b","src/fs/openat2.rs":"4a95c15dab533a4120=
1b5fa25c8a212956b7571d58cad696bdaf45af8aef96db","src/fs/raw_dir.rs":"6ad6d3=
dcdc6ddbb94f152b2584d7335e4b209d7219045ab4bdd6bdb2b7400e7c","src/fs/seek_fr=
om.rs":"a9efa0feb9ac789cf47667e91efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","=
src/fs/sendfile.rs":"e3b2058741cf4b1698f34d84bb37130cf2b72806d522a16fe541e8=
32cde136cb","src/fs/statx.rs":"2844baac77fdda0d77823402bfbdbe5bf8983e1d3b22=
9d700bf80c0c190f2aa5","src/fs/sync.rs":"84f24de0ea53f77bd5c471e097abcbecd19=
c4843b69607f9be9030eb7c9d5aa5","src/fs/xattr.rs":"5e222adb52caf69d949ab3f94=
4fb2a482dd6ca3a47200532ca6e72d44cbe8334","src/io/close.rs":"8348b501ef23832=
3a671c1a25bddab8db27a5b40cecf0e7cef87356d593a1b64","src/io/dup.rs":"0b1b00b=
44a8ed2c6b04e1221d28462c4cc0ff281c2be89d90c67ed8c484fc08b","src/io/errno.rs=
":"fe056ade492ef5b7e20fb9ffbc7e183b7bec6ff300587eb5197deaed5d321fda","src/i=
o/fcntl.rs":"82fcaf2c817b1bba477bf3dc6c21068de9647ed2f004123632c6d82e4cb28b=
70","src/io/ioctl.rs":"e89a6e670fe1c06521aa2f266fcd7a990391a533995b787cabac=
223f0926c8c7","src/io/is_read_write.rs":"a7d3cc1b8673a94d64926c03984e24a627=
c24e78f09070a2eb893d8005abf9d7","src/io/mod.rs":"0b566bf43b3f8754153f361119=
f63aa08ff2450e9306eb7e35ac3619bfeeae0d","src/io/read_write.rs":"ae6b5fa883a=
7925a77ebf1164c1ac56ce97251514de9a6f8b86786f3f60d59be","src/io_uring.rs":"7=
2b542dc8372b211563a69970992a7170afc75058163202c3ef4d61fcbc60f59","src/ioctl=
/bsd.rs":"d7d3f6813eac0e0f22fb8bcac3d193a22584393c1f7fa233999bd09c4e2059f7"=
,"src/ioctl/linux.rs":"61f006e31a4e049787415131beb97e548accb17fb6105d7ead5a=
12df0727077f","src/ioctl/mod.rs":"87e502a4de2f5ec029d64f606d3fda3831623f405=
434306e69f35a6aff5d3c04","src/ioctl/patterns.rs":"bd6e309c8b548dfe04aaffe80=
5972582fb56a0b717c45b45447630bdf9b88433","src/lib.rs":"753a0460cddec2211758=
fa15eff0bdeb5fde04a64f76b079df3c9b68d8809eaf","src/maybe_polyfill/no_std/io=
/mod.rs":"77889bb5c5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747"=
,"src/maybe_polyfill/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d=
47d958e9cff3a19049d88c8c80","src/maybe_polyfill/no_std/net/mod.rs":"1e94d21=
d455bb1da18a4fccb24b3d93ad42698e22dd888b78115d6266c80288a","src/maybe_polyf=
ill/no_std/os/fd/mod.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d=
95e80771d507c47","src/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087=
cc9afd10269f09a8b4125915dc3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_=
std/os/fd/raw.rs":"f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b2596273699=
9e7c6943","src/maybe_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2f=
cc7c825310606b889cc8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/windo=
ws/io/mod.rs":"5bbcc05c83fee5026dd744a994e0458469466d5be39081baa62df07753b9=
2fd2","src/maybe_polyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49=
328b5637cb3bafb96437f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/o=
s/windows/io/socket.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5=
d2c64808308d65","src/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231=
a4e778b5f985b9ae712ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/s=
td/mod.rs":"7c16c86cc73e226e65ead598e4018238b22000a345040b706bf1e1b3eba115f=
c","src/mm/madvise.rs":"e6cfda8ec16ec98cc21255c2cc666e51b4d5858bb85983ee92b=
2b1e5dd35e54f","src/mm/mmap.rs":"7957d672f37f37ffdb2a03a223699ade2f45a7adc3=
aa659d731cd6d4e794ef35","src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761=
211a494ca6f89b2367a2d2157e340e","src/mm/msync.rs":"1285604c7dbf34cdc16d6e9f=
b03c5d67038867127f12adfcd06e6257d89ae971","src/mm/userfaultfd.rs":"8073443b=
d181ff0b3ba4d0b1ae67370b4864035a0c8b4898cd709dc47c518ae7","src/mount/fsopen=
.rs":"1c54a02f04ee6710e2c5053c73361eecc499c24cd72c7c7c012dc57a4621e382","sr=
c/mount/mod.rs":"5f0c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d12a71=
36cb19","src/mount/mount_unmount.rs":"fa77675b023180b578b7fc053acb46ae2ed2e=
b11bb0488871bfd1ed211df73a0","src/mount/types.rs":"601ae3e10b7dc496fed7f3b4=
0a80e81c6edd7bf13189d7be45c3212d4c684c39","src/net/mod.rs":"7899807c9ad9e3f=
dbfd8b3ce2a1c7053d4f46dd7fa76102f620c6042c2d6314f","src/net/netdevice.rs":"=
1d790ef6e33d30c3167ec422a95a711d6df26d69502cb0b4c4889623547d3693","src/net/=
send_recv/mod.rs":"e888cbda77db981db039060200b458a856c932acc1258001eac147b5=
df9b63bf","src/net/send_recv/msg.rs":"39f7460204af2e71331d07259bc4c9a2cc3e9=
937bba72430a5b85e7054f5a46d","src/net/socket.rs":"151ac4b46f81ca1b2ee98f60f=
43e4d32d6327eb1bbfed050b0dc0c4241ab3100","src/net/socket_addr_any.rs":"8825=
0bf218d3a626e8e04bb11d4dd50ddf1422bb28d780c98b80710cf9c30166","src/net/sock=
etpair.rs":"008115435028fa3533739362efab3ff9d8209e49e70040eaa23578711f90045=
6","src/net/sockopt.rs":"d6ce0e65912e0d6d450c9dc870d4de7340f6f5308c5b21c7d3=
d66463b9d0577e","src/net/types.rs":"7b430c33a1bed0ebdb10f997d2c0c0227fe335c=
cd11d8446d9846627ae84a2a9","src/net/wsa.rs":"29856e6d0108be6b719f6ef973c539=
6e48ddd58ecd0c2db9ca3e2e0ba4eccb5b","src/param/auxv.rs":"b57483d3083a4dfad9=
ceb049fd96d54713b91b7f31b8c9a0e40501548da499ac","src/param/init.rs":"a31c0e=
5cea61a1a999767fe74f87c0d59eeb6bce66578b842fe0e0c32be27a55","src/param/mod.=
rs":"c514216b96d9520c9ffc5662c97b24f1f36f56fe1f5f3c9f64175c8b35577288","src=
/path/arg.rs":"ab5ed60c8cbf0484dce25440f027d7d511ea329bbaeaf83d70717f5c7e47=
b5ac","src/path/dec_int.rs":"0c71377fa5137595d6316ee135617ab8e514a2f539d77e=
15ef3a626d7aa092c9","src/path/mod.rs":"fbe294749100630467580f5e25b44e7a4f8a=
4512381cc18acaf1a6813afc39cd","src/pid.rs":"f1c486000c5b1311b2d720cee88f089=
c17ef9a171709673dd06e6f35f4ff98a3","src/pipe.rs":"48ff976a2b50f679a0e0aa6d7=
938fb88f56bde6804360bcef259cf5f524d75ff","src/prctl.rs":"19aa584895874ea48b=
9bbe1bf695b81257b0281df64dfdd91e1b4bfa298661b7","src/process/chdir.rs":"7ca=
ffd22e586fc448eaf55ca9ec9e41ad462626278f08352623bd1c88a91488a","src/process=
/chroot.rs":"01191eeb86295975874019dc675cb0f8f0ca5f79dd78dc9d1c791a952adb35=
12","src/process/exit.rs":"f09000df82151d015a39b8cfe7dc28875074ad1bfde326f6=
3be1438cf736d08e","src/process/id.rs":"21a487fe2384add719462f7cef500de0e286=
acf20ec5a6773c748ade08b99aff","src/process/ioctl.rs":"c7f551152d65ac173d9ea=
a298b964339037b60a7b81e8bc316453718417a6be3","src/process/kill.rs":"674d06c=
f065c8045dbefb6fc6437a62b964069599fc03d84e64cc36186b96596","src/process/mem=
barrier.rs":"1c4c39b359d1d0e9bbe16352eedfca9278d9ef298ade8ec00e998617bbcbfe=
d8","src/process/mod.rs":"a32691289982f4ffc53fef94fea4e3f375af9af87604fb962=
e94c54c9d91703b","src/process/pidfd.rs":"150413a9cc550ffc432b3279a368223fa9=
577544ef29e45edeff3b79ae316cab","src/process/pidfd_getfd.rs":"74c778b872be0=
b800870e4633606461fdc8493b259031e35f8f558768d960cc2","src/process/pivot_roo=
t.rs":"aeb2464464efd81ca0b940e3e5e3ed1b09380f3e6ba3200972e0ba100f78badc","s=
rc/process/prctl.rs":"a34ccda958036f49c5e4a5d654566c2b18d59c4b48b31c91e6387=
7191752712e","src/process/priority.rs":"ea78f09e4564943d0083eba19d9933781a5=
dd70d5723f156eb16ad01dd67d89e","src/process/procctl.rs":"3cf13470c19c6758a2=
8d7f3bacde1c1e4393ee702742cdfbfa45dce58cebd602","src/process/rlimit.rs":"10=
becde11d8b5d3b50aeb21a8fcdf53ec7803bdbbf8d1f4233b8e6c0b85fafb1","src/proces=
s/sched.rs":"4f566593f7a6c12873ecb18f21b9806162791b33815c9147065d3c8d812b56=
2c","src/process/sched_yield.rs":"8f80fef12e528628d19c26d26ecbad61b9644505a=
872a49f842820aa52018cf8","src/process/umask.rs":"15841f5e178dd032f8b8def854=
5c9e98b205e6b1ba70bf9c07c2c0327a8999c0","src/process/wait.rs":"04d60c43e8ed=
1ac44e4ddc5ba6e18e5edf1c400565ea0e81ff8f1bf71403b7ba","src/procfs.rs":"adfa=
c2c1232ff20c18251b8745f6732e3315b1adfe95b9e7297378dbcb290129","src/pty.rs":=
"3c045b9ce8c24cf380de77f9c5640b6adc1774d6df5c2e5639b965560960ba8d","src/ran=
d/getrandom.rs":"a89f45838d22982eb0997bc905031819195701b64aa1c874e646dcb16d=
6e2a7d","src/rand/mod.rs":"e1fb7542f1958fe77673aa628bd92fef1b9addf79ba23df2=
398d1231cb61c148","src/runtime.rs":"723558853e479dd33eb5c1448a23fb7ab4ce007=
356d55978a28245b0d8f73668","src/shm.rs":"30b32e302ad2d198de411981f3c7609082=
bc20f1c0651aa3f3ce2beb8f19c6e9","src/signal.rs":"0fcce2e37f69d70cfef1f35535=
5979b269820281a6e63bd171ba05e525063e79","src/static_assertions.rs":"504cf66=
f0d5b8e335be02f9ae8b0a355abc98c2c82eec0098bdf0988e662e260","src/stdio.rs":"=
ffa955a09e16c47ac11f4be9cbfdf07b2b4ffc0cdbc9bf70f0a49dbae2d7a188","src/syst=
em.rs":"7eae745660ca4a7c4885424af2fc89025ae7e51636ea9c8714f0a9b90d979dbe","=
src/termios/ioctl.rs":"aa26694c9be5378ea52e669313e64b25fc034e3863b72281530c=
42499570fedf","src/termios/mod.rs":"b44b7caa60b6f458657ed58a0e0eca41bb4e6d6=
be4b0f042bbb8ab7056cebe4b","src/termios/tc.rs":"bafcc607de993c7e7c4cd6f15a5=
9e7807906e59bf991a5a4c67e3b076d07e3f2","src/termios/tty.rs":"0013cc4c319072=
46b45c4b94ded0171dc0d3e6759740f5424831feae700092f7","src/termios/types.rs":=
"6a69789f7bd4783839b18f5e41f2444afc021c5d5f861bd75939ec53308d11af","src/thr=
ead/clock.rs":"71f1c545f29e672f242ab017029d20cba98e05463402803540474098ffb0=
4399","src/thread/futex.rs":"cb6d58120194ea869df407761136e4e98cc7d775615472=
03b74ca1a5dd9e0958","src/thread/id.rs":"1a9a8b4bfe71dba6aec17760ca9de5a66a8=
0b9c608fa0eeb30fd1bc949e511ca","src/thread/libcap.rs":"4c51b7df566d38dd0f85=
f81ef53279a745a39f0f4e1154791fd38438e2ca7db1","src/thread/mod.rs":"d6d9c334=
0cd9710869813ea9c993669d11620126edc66e5657a9de2a07a5f864","src/thread/prctl=
.rs":"3826dda31b9452b2a8b30158b6babd0b536fe9ea314027863d14c3888c9435ee","sr=
c/thread/setns.rs":"ddee643bd095104242afc3ddd3ddcbcfd6a4876febf47200a63f9e2=
2996e1dec","src/time/clock.rs":"7588a33f5279ee683f39ce72a8d0a8dfcc2e25d3dbc=
29990e6829d7c2df7d99b","src/time/mod.rs":"43afee938c80d124d04d4ba190c03f4d2=
1d1e3bfc154fff309211e4f6eabe940","src/time/timerfd.rs":"f17092b84553741aa2d=
2b44c6992b5d2c8c96cc2c2007fc9a2c6b2064485e53f","src/timespec.rs":"32a4d930c=
bc0f6dbd23153290db920671cf4ce65a4a127e176f897c1cde42d7d","src/ugid.rs":"661=
6c6e35b7e43aee5b150f1efae7a50711e0947943c9a96833dbe214ad9e85f","src/utils.r=
s":"ad680ad8564cb7b37fc746e0b3f89d389278fe1b294ef343a5c4a37677414065","src/=
weak.rs":"7e3169bc97e76fc4d52b040391a8df36b06536fc0f81cc6e8e71b951cb1fe54e"=
},"package":"8acb788b847c24f28525660c4d7758620a7210875711f79e7f663cc1527268=
11"}
+\ No newline at end of file
++{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231d2=
fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b0532d=
35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"a362ec65b559b77cc80326=
4b97d53ea761c9ee98787012128054d6ad1a3d0c2b","LICENSE-APACHE":"a60eea8175145=
31668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2.0_WI=
TH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39ef1f9=
4f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a715d9d2=
b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12ba79e=
4cebb6983a7b6491949750aecc4f2178","README.md":"fbd9eb025cdb6c58d28649f0c913=
2a4e383014f03a8e0edba04a4e36cc45fba0","SECURITY.md":"4d75afb09dd28eb5982e3a=
1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e67273aa0=
a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"adc4bc868a=
30a902f328af6ebd0bfc72868b8e388beb13c6d69d826646931b17","src/backend/libc/c=
.rs":"acfbe7965e84e9bba1861924130d1383e9318040adc67e1e14d882bb8ac63562","sr=
c/backend/libc/conv.rs":"e8d55f9cc427d19de13bde83b50ce02faf0afd32121c8adb2a=
2cc9f551a562d6","src/backend/libc/event/epoll.rs":"6b68d0002519ad9894391562=
ca062aa02f696cc0a2a84bbe750891619f5b0c35","src/backend/libc/event/mod.rs":"=
ad30f99f7da0768c18fffac6ec71e658bfed2e44f0634f48c2e0ffe4677ec231","src/back=
end/libc/event/poll_fd.rs":"e8cd06835771505b3c803b17c6097e59cf8743f62b2c46d=
ccbe7afc9a90cfca5","src/backend/libc/event/syscalls.rs":"7ea9d27dfbc5fe5f87=
3e9dd1a1059f42327c099b84f543718a612a0512dfbbc9","src/backend/libc/event/typ=
es.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f13","=
src/backend/libc/event/windows_syscalls.rs":"ebfac665c6676c4b803134ab8806be=
8aa2e96bdbc7799a19c544cd9069b35787","src/backend/libc/fs/dir.rs":"836273d76=
4eb7c1cf09b5ed20baf20a99d9c9afdf448c9fda50f0927c173cc89","src/backend/libc/=
fs/inotify.rs":"69376ba2e81f98164029888d0cae554ca1702b532b0045dc55e282f1dd5=
2d7bb","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f329ad3=
5bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803011b5=
7da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc/fs/s=
yscalls.rs":"dbce2106ab58e7fcd1aeeb3aa1f361aacdfdda1171a1a0f49aebc4e88f2333=
a7","src/backend/libc/fs/types.rs":"b1ffff2b0a0c56dcb3507431a0100c70505ea75=
49ac5267752842d7e30500529","src/backend/libc/io/errno.rs":"bd1a92ffc3f632ae=
7292b7006a7c890433a3bee8d67a63c299333850a91e99be","src/backend/libc/io/mod.=
rs":"746647bd864e4ec7717925b6d176cebdb392b7d015070244cc48d92780351dd6","src=
/backend/libc/io/syscalls.rs":"91ebf37b8abdecf619c9bc3521b1b4c6795369c66875=
3586e1af79d04fb982b0","src/backend/libc/io/types.rs":"2efd39bb3df19a9db5496=
217284f3d2235ddb354fac81dd71861109a56bede0b","src/backend/libc/io/windows_s=
yscalls.rs":"24f7abe92406f3f65c1a42a4694c2112142106a341d024ffc2d5905a9f2893=
39","src/backend/libc/io_uring/mod.rs":"2c6478857a0751625edabd61acb841819bf=
ba1093b1faeded15693c805d84952","src/backend/libc/io_uring/syscalls.rs":"522=
1a498e6c396d7c4cb60168ce8459ebca7d6720349a426d8083c227c694212","src/backend=
/libc/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/mm/syscalls.rs":"c04c61ad3d7f3b24d13f89144d7fa0a=
05658cea4763207f9250db4f9362de2fe","src/backend/libc/mm/types.rs":"40b7888a=
1439afae2705e0c724ae0821a51d32ca5740f1ec16ecb6dc1adc883d","src/backend/libc=
/mod.rs":"087d2676df88510b089255053a4865e62c64172723588386fe8244d2f1a681c4"=
,"src/backend/libc/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287=
b25a5bfe489fa1d07f7cfd7","src/backend/libc/mount/syscalls.rs":"d2d35f7ae989=
bb52722e28cdbd775243c5d7da9eb411e0b2b9632f2aa7c1533e","src/backend/libc/mou=
nt/types.rs":"5c2eaf22e7a29e8e48cb19e40c88d040ba1c891038a611e85571476489dc1=
2cb","src/backend/libc/net/addr.rs":"920ff7645055ca4e7d4019b9dd4ea1f211b708=
a62ef5d4049494f8dd3fe8d2aa","src/backend/libc/net/ext.rs":"cfce41130eb2e3dd=
04271e0aa2c1e2de9866397d7d2a59e917d26b784ea30df5","src/backend/libc/net/mod=
.rs":"562d23225d6dba8f095e3ca41af60dcf6cc40c2cf17bf028f90888f809e86f07","sr=
c/backend/libc/net/msghdr.rs":"6f8aba792b4adef5c5d3d4324a813a67a063a50d1043=
7bb19bf7496666bd6de6","src/backend/libc/net/netdevice.rs":"078bc108540457f0=
e5849c2b8d2f1351c4aaffc910f8c9c9857969477c22065e","src/backend/libc/net/rea=
d_sockaddr.rs":"b094d2cb84b2eee5dd411d21458192c03eea0e420e78149441d7ab88a89=
3281a","src/backend/libc/net/send_recv.rs":"b5714bed2cc6f2ba42bf90d19655b50=
7c2a248e2d05270b1355b6d4cb8e4f9fe","src/backend/libc/net/sockopt.rs":"0f424=
615b2982826da6e57e9b0bb38442288152464f67508fa5bd66a6d0c9827","src/backend/l=
ibc/net/syscalls.rs":"552eb57bda272f2372e180f927a88dce67fcef46e7c1378d47d59=
5eb2abd578d","src/backend/libc/net/write_sockaddr.rs":"b62e40c9d4a4e70746d8=
64434db140b4b3c1f110a3fd2e7acfbb3f2ccf15d6aa","src/backend/libc/param/auxv.=
rs":"c29b29ad65f66e048debce5293bf84164811264e61b71a28a57225400d3b9529","src=
/backend/libc/param/mod.rs":"5234b8f1bcb886cca6ea003d411d75eaeebe58deedd80e=
3441354bf46ed85d4d","src/backend/libc/pid/mod.rs":"2c6478857a0751625edabd61=
acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/pid/syscalls.rs=
":"49ea679b96c0741d048e82964038f9a931bc3cf3a0b59c7db3df89629b9c49e6","src/b=
ackend/libc/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe=
489fa1d07f7cfd7","src/backend/libc/pipe/syscalls.rs":"219c31200f333ce803370=
bcbfcca529f7635c51b31e4576269faaa6b288cd920","src/backend/libc/pipe/types.r=
s":"f87e43bae418d00fe8b333877acc3b6aab4cf4d123f02ff048a21866486e1404","src/=
backend/libc/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faed=
ed15693c805d84952","src/backend/libc/prctl/syscalls.rs":"8a2684f444a7555098=
dce2b92270d81cefdae902716c6e5d59bd7b0657e8a29d","src/backend/libc/process/c=
pu_set.rs":"5fca2b47289a2bb6ba908c910a6d27ac78ac10ea21d3c0c018f72f8816c5b9d=
7","src/backend/libc/process/mod.rs":"806e26da8d1e7afae502987fcd650f4d348da=
147b8a2e74447affdca153e2e97","src/backend/libc/process/syscalls.rs":"b4a7d0=
9cf46c65997a28dc5f075e90943b2581b7df99cd66cdd18e87fe96600b","src/backend/li=
bc/process/types.rs":"fb2caf34b17079aa72c04aed0f9a31d534ea8e8b73a80c758b748=
bf5e38df52b","src/backend/libc/process/wait.rs":"0cc556aed976b4bbb3965f74fd=
76b8216c755fce25043b7b21ce54afa07c9773","src/backend/libc/pty/mod.rs":"2c64=
78857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/=
libc/pty/syscalls.rs":"566fc9a2cb2e38d7d7ac2405b22c0522369cae4a8f4fe18b5512=
3ba94d3d5a95","src/backend/libc/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f=
4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/rand/syscalls.rs":"3=
5ea6b6e0f8a7fb064fd5cb33a3a855cd161a6a00f93d76c861b2a2c66db85e7","src/backe=
nd/libc/rand/types.rs":"4eb0b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a705ec6=
05b773f63f880","src/backend/libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f=
4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/shm/syscalls.rs":"60=
d797d4e85e08e6330e6b8d80094356ce377e5484952f88ae2a6e49231c268c","src/backen=
d/libc/shm/types.rs":"0a1ac6bb9c024d94eb4bab7452937b7befcb30c581dc787b80501=
1407ba1442d","src/backend/libc/system/mod.rs":"38563ea68829ca5a4b1b0695ac8a=
5c05718e85bdc88a36dc805efdfce45d3909","src/backend/libc/system/syscalls.rs"=
:"c18c2942811ea93af3125b58d00a1da05c54e5ff438a3dc44cda53bc9d6fcf03","src/ba=
ckend/libc/system/types.rs":"6871e16aee14fe2ae03cea798c3e509ffe44778a9c0e56=
08fd73e2e015876d7e","src/backend/libc/termios/mod.rs":"2c6478857a0751625eda=
bd61acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/termios/sys=
calls.rs":"2720e443c118e1c0311dbb3efa4b54637b6e607bb123ccdc0f5d92b5628573c2=
","src/backend/libc/thread/futex.rs":"064463c4a4f6549aec0797d44e44b862eb010=
0efe97aa293b4dad10034cae800","src/backend/libc/thread/mod.rs":"fa710053974d=
7f16a6c49242ee6c10a3b9e1143452b9daeaed8837302a679fff","src/backend/libc/thr=
ead/syscalls.rs":"4cb65db4fe0c7d6016dd0dfefa610b369234b6b9db0c75c0fcb9ab8cb=
25a16ac","src/backend/libc/time/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c0571=
8e85bdc88a36dc805efdfce45d3909","src/backend/libc/time/syscalls.rs":"bf847e=
94cc156bdb553755baa88dac240db4dcaf690f303b0f205777c5a9cdfc","src/backend/li=
bc/time/types.rs":"d0307994ffddd3f21f702d9ae4400750aecccfaf4a01268161dc4fd7=
2de5c373","src/backend/libc/ugid/mod.rs":"2c6478857a0751625edabd61acb841819=
bfba1093b1faeded15693c805d84952","src/backend/libc/ugid/syscalls.rs":"8edf9=
1b8790add23902c9f5418da6b0723a371677f29f490e0c8af852f0f1a0c","src/backend/l=
ibc/winsock_c.rs":"502da2ed3cd6ca99bb7ee08b0b30e25c212632885cec965f9816366c=
6b931ac6","src/backend/linux_raw/arch/aarch64.rs":"2a255c9135bc8a321c180f52=
b88eb2b158bc9170cd222149caeae63c24587d44","src/backend/linux_raw/arch/arm.r=
s":"165bccb5883d0136e55d42091183765f83d86e9d37a7cb2cec9ae8af32774db6","src/=
backend/linux_raw/arch/mips.rs":"aca20118a73063e4f2f8e7b261b1266d216e826df2=
a98cad99c53c40b0971af4","src/backend/linux_raw/arch/mips32r6.rs":"a7ebd0886=
e2e0d3b39996778fb665b68738f8a67d67b47e43fdba7e7cabb6d1a","src/backend/linux=
_raw/arch/mips64.rs":"ba947f286522b8034d509887cff8183cca34766aed5d37c91667d=
ba22e2f608a","src/backend/linux_raw/arch/mips64r6.rs":"27de08ce1003a48f1d8b=
84746e724e8766b980e4ddc4febb6e20eb31067fb137","src/backend/linux_raw/arch/m=
od.rs":"37eaeea601d39be00d170856a31a8ec6a27b0d3ac22ab3ee642ab0e45dee237d","=
src/backend/linux_raw/arch/powerpc64.rs":"dfb001f8636a5e46d728900b0804fe6c3=
74e5e18a6f0e76d7d62e0c07da74477","src/backend/linux_raw/arch/riscv64.rs":"4=
1d33242d941030f46077dc2b1bc4c7913fe7630d693a5a7eef966bcf38f9d8b","src/backe=
nd/linux_raw/arch/thumb.rs":"2fd979ab421248c0a4c592bc0cefee63edc26528f469b7=
1b63eaed35356e42e8","src/backend/linux_raw/arch/x86.rs":"8fba9762bb0e8bb9a7=
1890cdf413441aa52d2bf41690ec0ef01c97ac11759a5b","src/backend/linux_raw/arch=
/x86_64.rs":"e929036a1f3cf93ba538f4523b241605cc7b5e61f84ffe6d9d5cdbcb6f73e5=
43","src/backend/linux_raw/c.rs":"445e311dc24a176603008d0a7d7714a564821db31=
79052da797027f8fc7ae4fc","src/backend/linux_raw/conv.rs":"43e62870f91a480e1=
0e2485546c95e70e61c72f96306921c796a7094ea404d3c","src/backend/linux_raw/eve=
nt/epoll.rs":"db05715e1bd3b93c6873695c89f04abb97768a57e7e402306f568eba844e4=
07a","src/backend/linux_raw/event/mod.rs":"72e46b04637e2d1d2a6b97af61614499=
5399e489d1fe916faf835d72fc8c64cd","src/backend/linux_raw/event/poll_fd.rs":=
"a5773464e9e30227b4046f029a27d3daf2c7bd0045e54565cf1a8ac2a0d61e81","src/bac=
kend/linux_raw/event/syscalls.rs":"5620d7dd5fbcfef550cfa94df7593caffe0deccf=
0f754765751e562edb7d2b2f","src/backend/linux_raw/event/types.rs":"0551b18f9=
82e233a0a06d8a9c3dbb29de0c204dcd64dd6f7e88b6c96fa9a9be8","src/backend/linux=
_raw/fs/dir.rs":"fdf849d058c387551e102bd7fec31e3ca40c18417a1e530cfed1daf3df=
2c4de3","src/backend/linux_raw/fs/inotify.rs":"e627e8f48e8f4dc2117746117aaa=
7f151865103be64e446011c72878921e402e","src/backend/linux_raw/fs/makedev.rs"=
:"c6b4505c4bcbbc2460e80f3097eb15e2c8ef38d6c6e7abd78e39c53c372139e2","src/ba=
ckend/linux_raw/fs/mod.rs":"3d3a42bbf4d086f806d7d9f6e4b0a49a873dc27f4f03ffc=
a0921f5536acc24e5","src/backend/linux_raw/fs/syscalls.rs":"6e2ca8d96be2bf94=
b38512d184a22d79385a6841419de2590f9e5af33d002920","src/backend/linux_raw/fs=
/types.rs":"6102a5b8207f959edbcc2fc233a6145a265a428c0c4fa195472fe7fe6dc5165=
d","src/backend/linux_raw/io/errno.rs":"5d1c95eacf1794be6c2ea83e40b6023ae86=
abc2c83ca16de6c70a2020fb905c6","src/backend/linux_raw/io/mod.rs":"7ae232442=
7892cca6f5ab53858d847b165f790a72ec25f3d99fb15f0506c9f27","src/backend/linux=
_raw/io/syscalls.rs":"54ac1395fb4801ef2ec6639113a6e23c4b532d84b6495f7166fcd=
0492cea09f9","src/backend/linux_raw/io/types.rs":"d0df5a62248e1ba19af0f89f8=
6da7ba2312d97065c2814ddf6b08a4a0db23bad","src/backend/linux_raw/io_uring/mo=
d.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","s=
rc/backend/linux_raw/io_uring/syscalls.rs":"7e40703cc3a020377a4a23bc8651bdf=
1d65b8f62e174eafb85d27d246f86c39d","src/backend/linux_raw/mm/mod.rs":"8aa96=
6faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/l=
inux_raw/mm/syscalls.rs":"c7fc0f49283026b0df47463ed47394634e5664468f36a5eb2=
a89bf259bbfb67d","src/backend/linux_raw/mm/types.rs":"821409c463a3195404807=
5906b3fe5bdb029badf9c9e2689bfff8f6dbf5b0bed","src/backend/linux_raw/mod.rs"=
:"f849feea0a83df69fb9288ecfe07992cbdaee7e55d29b5662043a3fdf00e4700","src/ba=
ckend/linux_raw/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25=
a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mount/syscalls.rs":"8442c82814=
961f69c488222faabb82c44d2e7227b10faff919cbbd197bb47484","src/backend/linux_=
raw/mount/types.rs":"9a33214816863fc92846fbc99df6ddf60a3e772b34f4bb3f5e8a40=
ef489130d3","src/backend/linux_raw/net/addr.rs":"7239e4fa8c6872bf978e2f5805=
63c51c72d6ae6f96b77520fc7b9ece62fa0ebe","src/backend/linux_raw/net/mod.rs":=
"5640bbaf4963ac4575b0537173422ed6f6a43f34a8f6b656e7257fbbb13e5bcb","src/bac=
kend/linux_raw/net/msghdr.rs":"8b18974b81ee78af7a5c64733041dddaaa378a46cab8=
b984bff5b3b4be499751","src/backend/linux_raw/net/netdevice.rs":"3cb28bcd762=
e2df595481b4379a08170f59f99d367aa03424531c19e4c5aaf55","src/backend/linux_r=
aw/net/read_sockaddr.rs":"7cb3c8bcc80c5eee8602323cd83f36c1784927d9dd0c40ded=
29af6fb09c57ece","src/backend/linux_raw/net/send_recv.rs":"d4e81c01db50dad1=
c02e9aa3e0979f8052431a3f64c8864681d9ea52a34ce3bf","src/backend/linux_raw/ne=
t/sockopt.rs":"d7dc73886a6c0671b3bdc4cbe8c49def8dc5416864f9387bc5aee72319c5=
b162","src/backend/linux_raw/net/syscalls.rs":"0138662012ca89e063b3a03cf8fe=
17b97fbeb38a3d18c42938ae047a4a392105","src/backend/linux_raw/net/write_sock=
addr.rs":"0efa4e17b4008da2cf2aada2d18acfccd31a3b49cf8ac5d608e77f3ea6627fec"=
,"src/backend/linux_raw/param/auxv.rs":"af132fa16b37a17c43ed5d099b27789d456=
f3cb92abb81139231bf9407599858","src/backend/linux_raw/param/init.rs":"f2275=
a2324a99be8d804fb3b7fdf86a43c7d428f660280b7e0e7d19c357f0200","src/backend/l=
inux_raw/param/libc_auxv.rs":"0a223ad36a33611370cdf3c666008fd61d15f2477fd3a=
5ac2c78972079fb86a9","src/backend/linux_raw/param/mod.rs":"2e6a1a1c00351b9c=
88bd615aa923f71d76208df5626dd9bea03067f28f81dc31","src/backend/linux_raw/pi=
d/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952=
","src/backend/linux_raw/pid/syscalls.rs":"eef6aa01830ddd510b83f507da2002c0=
3e58318b73744be2c06ebbe33c4f194f","src/backend/linux_raw/pipe/mod.rs":"8aa9=
66faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/=
linux_raw/pipe/syscalls.rs":"ce1f72fcf0cb7772e6d9bd5791a39aef329ca7f729fd47=
431a93b950cf0568d8","src/backend/linux_raw/pipe/types.rs":"ae643a774e6343df=
02b9b99b842fba8b742dd9b1f97b5c5b2b504f2840bf3fd2","src/backend/linux_raw/pr=
ctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d849=
52","src/backend/linux_raw/prctl/syscalls.rs":"a18b224307e0d27bda9b7b85c75c=
d6c7ddfe39f5ce52efb7bb0bf0585b757343","src/backend/linux_raw/process/cpu_se=
t.rs":"b31889f972676f57e3599375dfcd59dd72975977ef345d11c22d51f0d4a6400b","s=
rc/backend/linux_raw/process/mod.rs":"fb393c70a9c63ef9a6bf1fb5a2dc94f07d6b0=
b6987cc5231c15c607015dafd68","src/backend/linux_raw/process/syscalls.rs":"4=
c7e3e5aad98b63162e110deb1f58b15b46b9c5fe7fd0f579e1c7dc1c3d2df16","src/backe=
nd/linux_raw/process/types.rs":"6811ba822bc12a1a6336649151b4adb1f5d3365684a=
31c07f01953ea9547743d","src/backend/linux_raw/process/wait.rs":"921aee4b004=
8746087f52615a98edc2aa0fb4b53d6df44be4533098df55d1b05","src/backend/linux_r=
aw/pty/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d=
84952","src/backend/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae87b1ca58d82efc=
58007b9dddaae78460d615f48da19d1cd0f89","src/backend/linux_raw/rand/mod.rs":=
"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/bac=
kend/linux_raw/rand/syscalls.rs":"317cdaf243623329ee345131054e86a06a0863a9e=
90c5dba73e1ac3475ba6305","src/backend/linux_raw/rand/types.rs":"a21dbb1ab31=
eed6b59a57520be5a3c603c36d18ea74e67f7527f40835ba209a3","src/backend/linux_r=
aw/reg.rs":"6bfb53575494f5de76d5112a7e4eb6d0c266b1af0a275aa33b9bc9e6e7a2f41=
c","src/backend/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92942f06ea0b6846=
4040dcac33c6f0f7ee392c6269993347","src/backend/linux_raw/runtime/syscalls.r=
s":"ec1c43952f8a518ff152cb798ca6a67432030568a9d355532254b68cabd20d2c","src/=
backend/linux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cdba6e8c91414113=
a04a739160929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":"8aa966faf3853=
d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw=
/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d93794540087b3182cbdf=
3cb9c8db","src/backend/linux_raw/shm/types.rs":"8275dba36a8f2c4208f2d23ffef=
52c5b02d4b10d5450733cb4fc5cdfcd6285ee","src/backend/linux_raw/system/mod.rs=
":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/b=
ackend/linux_raw/system/syscalls.rs":"19a7ab17de906ec237f16a816da036723c1f5=
5f605e8e4a26689343eb4cd76e7","src/backend/linux_raw/system/types.rs":"1ceab=
8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e","src/backend/l=
inux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded=
15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":"1a42438153f61=
e72aab7c3c8fdd0c3ab918da0fec58e07bb42423518065374e2","src/backend/linux_raw=
/thread/futex.rs":"0139394e11006301e98379b7f07604aa10fb436b43acf8f55f1a24f1=
253f96cc","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90b9234e79900b27ebb=
e8837e3a7a36aec532912e3e253edce5225067","src/backend/linux_raw/thread/sysca=
lls.rs":"e2c89bd3cf34a46b5d06de43933284ddd06ed07e9c789c726c1afa48f7842a5c",=
"src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7452bb1cc2d28b5f0aaa8=
40a2856fe363acce624e1beefc","src/backend/linux_raw/time/syscalls.rs":"7dc69=
75bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de9404845312fc","src/backend/l=
inux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a81d3305e18e726e54edc5a5=
474641f3cdc278","src/backend/linux_raw/ugid/mod.rs":"2c6478857a0751625edabd=
61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/ugid/sys=
calls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db84f444d3251309b7a0480b54f7=
","src/backend/linux_raw/vdso.rs":"056314f72c71d4b041739337ca2098afb7fe070f=
844327f462c293f43481b75b","src/backend/linux_raw/vdso_wrappers.rs":"9690224=
78cb48b9b81a549853720f76c2c276a746e25d17c0762f76b377a73b0","src/bitcast.rs"=
:"4d2b3619dac1500bee223e11db0b4a5f75b0fbde65094bab157597af71f6b72a","src/bu=
ffer.rs":"e75713877ba12f4a5c9b482df79b219363965d5311809ecf6b6becf1eabb5e46"=
,"src/check_types.rs":"e52f710e1cfc12ca13a495f2b43c227b293ff295e1ce3ab33293=
5b28a7579872","src/clockid.rs":"bd66d6bdc6b73a4668dda5b6f91838b6ed6c4b9503a=
0798b071ef35c572b711d","src/cstr.rs":"41af2a4429fe6c67a8883f8a8f63d66c90df5=
66abda74fd2b03bcef7b9f24218","src/event/epoll.rs":"0d051674b9c1b3f118ad65e2=
b46b4b3cab5551d5dde4e1c40b3af14854a826c7","src/event/eventfd.rs":"81cbd08f7=
bdf40a6ce1ca692b63da1dc8ba925282990668d9d68f1203e839fa1","src/event/kqueue.=
rs":"1f381c8afa65d36e3052c476d2e679c3bccb7e3d6cc6b95ba53b48abcbe13a81","src=
/event/mod.rs":"4dd296e8feeb0e29b9b63eeeae6169786f76fdd6138489795a5829a189d=
3ac1a","src/event/pause.rs":"930219e19ee227729c8f86fe7271721e8797e917d2d707=
3fa8d7a104bf6189c0","src/event/poll.rs":"f8da99d1136502040314259ab7700570bf=
40df0ea85b94dcdf6f5d1c4073551d","src/event/port.rs":"4e51ff150e5d17cbd44aa6=
4a38b99c15e26eaaf2e350768b5dcacdfde4fa5212","src/ffi.rs":"50a14dfe10408f9ab=
c6269b9ee6e7a88d99503d50b3732288e85b777915e579e","src/fs/abs.rs":"1c1e65be0=
8da5f7d6e5b8902283855fef0f0a74ab227aae991aaf5310d0858f2","src/fs/at.rs":"b9=
5242387489425714589bc84cf8f3943f3a02f57cc6ab4347c4eaf648b09e5d","src/fs/con=
stants.rs":"23923e0fce3221bdac371fe2d05028f30a87dba4f9b4a573b69dc2d6d39320b=
2","src/fs/copy_file_range.rs":"d3b644374390d482b2ff749a2459458872b57d0dcf9=
670368739b7833509a7c2","src/fs/cwd.rs":"0933a06846a20c12fb12cb556c03133d373=
49d104e4f2d99379a674d1cf78562","src/fs/dir.rs":"347a52f4ca9ac6321c52e802e97=
ec90d1b4c62ec955c8996fc17f8f5aed69966","src/fs/fadvise.rs":"d77f6a7f7f6648e=
750888719e59f0f8332f11e84442ef72f622bcbd4e19be845","src/fs/fcntl.rs":"6aa6e=
b0c87fdd915974e425dd4881038c3658f05fac0bc005a9b40107474ef1b","src/fs/fcntl_=
apple.rs":"e2f23f038083621bcdecc98d02ce1023508afaecdb2ed0fba5c8b70f955301e5=
","src/fs/fcopyfile.rs":"ce565f61e1fbf2e31086077c2f1d01b6bb3b048915edda87fe=
9a4a4f5e8ff7e4","src/fs/fd.rs":"31943a4eef1ee6909d7db48b0d577b4429789726d85=
1e7aa4f9af43e87722b6a","src/fs/getpath.rs":"28f6970fc1bbc37bb35c84724b59eac=
436ea7407a4522e18c2bdacb1fdd2edd9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f971=
89cea4e5982a0d35b192afeec6340a6c6222e0cb","src/fs/inotify.rs":"2e4b9824c323=
c661667aefe06383cd3e843a34676852d9f5f79f62e48e975171","src/fs/ioctl.rs":"d4=
94f9347556c34ea600d130db096c792f34d7e095c72e94f31964d18c8e02a4","src/fs/mak=
edev.rs":"85520b484cb7c15ab71ea1c368578ea3b7e484d82f8510db92b6ce9f7ca341ae"=
,"src/fs/memfd_create.rs":"a8bf1dced54c7592e71da896021338d5092c1693d12cc42e=
79bac435fab2792b","src/fs/mod.rs":"600a5ddd606d60460ec887dbeb843fdcf1b5204e=
d8d95eb0abbd89f33eae6e66","src/fs/mount.rs":"8f6ea2b997dd83c50c90291b9ada3e=
d77a9ce1ad701c9b0d533b5113b317be5b","src/fs/openat2.rs":"4a95c15dab533a4120=
1b5fa25c8a212956b7571d58cad696bdaf45af8aef96db","src/fs/raw_dir.rs":"6ad6d3=
dcdc6ddbb94f152b2584d7335e4b209d7219045ab4bdd6bdb2b7400e7c","src/fs/seek_fr=
om.rs":"a9efa0feb9ac789cf47667e91efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","=
src/fs/sendfile.rs":"e3b2058741cf4b1698f34d84bb37130cf2b72806d522a16fe541e8=
32cde136cb","src/fs/statx.rs":"2844baac77fdda0d77823402bfbdbe5bf8983e1d3b22=
9d700bf80c0c190f2aa5","src/fs/sync.rs":"84f24de0ea53f77bd5c471e097abcbecd19=
c4843b69607f9be9030eb7c9d5aa5","src/fs/xattr.rs":"5e222adb52caf69d949ab3f94=
4fb2a482dd6ca3a47200532ca6e72d44cbe8334","src/io/close.rs":"8348b501ef23832=
3a671c1a25bddab8db27a5b40cecf0e7cef87356d593a1b64","src/io/dup.rs":"0b1b00b=
44a8ed2c6b04e1221d28462c4cc0ff281c2be89d90c67ed8c484fc08b","src/io/errno.rs=
":"fe056ade492ef5b7e20fb9ffbc7e183b7bec6ff300587eb5197deaed5d321fda","src/i=
o/fcntl.rs":"82fcaf2c817b1bba477bf3dc6c21068de9647ed2f004123632c6d82e4cb28b=
70","src/io/ioctl.rs":"e89a6e670fe1c06521aa2f266fcd7a990391a533995b787cabac=
223f0926c8c7","src/io/is_read_write.rs":"a7d3cc1b8673a94d64926c03984e24a627=
c24e78f09070a2eb893d8005abf9d7","src/io/mod.rs":"0b566bf43b3f8754153f361119=
f63aa08ff2450e9306eb7e35ac3619bfeeae0d","src/io/read_write.rs":"ae6b5fa883a=
7925a77ebf1164c1ac56ce97251514de9a6f8b86786f3f60d59be","src/io_uring.rs":"7=
2b542dc8372b211563a69970992a7170afc75058163202c3ef4d61fcbc60f59","src/ioctl=
/bsd.rs":"d7d3f6813eac0e0f22fb8bcac3d193a22584393c1f7fa233999bd09c4e2059f7"=
,"src/ioctl/linux.rs":"61f006e31a4e049787415131beb97e548accb17fb6105d7ead5a=
12df0727077f","src/ioctl/mod.rs":"87e502a4de2f5ec029d64f606d3fda3831623f405=
434306e69f35a6aff5d3c04","src/ioctl/patterns.rs":"bd6e309c8b548dfe04aaffe80=
5972582fb56a0b717c45b45447630bdf9b88433","src/lib.rs":"753a0460cddec2211758=
fa15eff0bdeb5fde04a64f76b079df3c9b68d8809eaf","src/maybe_polyfill/no_std/io=
/mod.rs":"77889bb5c5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747"=
,"src/maybe_polyfill/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d=
47d958e9cff3a19049d88c8c80","src/maybe_polyfill/no_std/net/mod.rs":"1e94d21=
d455bb1da18a4fccb24b3d93ad42698e22dd888b78115d6266c80288a","src/maybe_polyf=
ill/no_std/os/fd/mod.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d=
95e80771d507c47","src/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087=
cc9afd10269f09a8b4125915dc3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_=
std/os/fd/raw.rs":"f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b2596273699=
9e7c6943","src/maybe_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2f=
cc7c825310606b889cc8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/windo=
ws/io/mod.rs":"5bbcc05c83fee5026dd744a994e0458469466d5be39081baa62df07753b9=
2fd2","src/maybe_polyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49=
328b5637cb3bafb96437f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/o=
s/windows/io/socket.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5=
d2c64808308d65","src/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231=
a4e778b5f985b9ae712ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/s=
td/mod.rs":"7c16c86cc73e226e65ead598e4018238b22000a345040b706bf1e1b3eba115f=
c","src/mm/madvise.rs":"e6cfda8ec16ec98cc21255c2cc666e51b4d5858bb85983ee92b=
2b1e5dd35e54f","src/mm/mmap.rs":"7957d672f37f37ffdb2a03a223699ade2f45a7adc3=
aa659d731cd6d4e794ef35","src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761=
211a494ca6f89b2367a2d2157e340e","src/mm/msync.rs":"1285604c7dbf34cdc16d6e9f=
b03c5d67038867127f12adfcd06e6257d89ae971","src/mm/userfaultfd.rs":"8073443b=
d181ff0b3ba4d0b1ae67370b4864035a0c8b4898cd709dc47c518ae7","src/mount/fsopen=
.rs":"1c54a02f04ee6710e2c5053c73361eecc499c24cd72c7c7c012dc57a4621e382","sr=
c/mount/mod.rs":"5f0c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d12a71=
36cb19","src/mount/mount_unmount.rs":"fa77675b023180b578b7fc053acb46ae2ed2e=
b11bb0488871bfd1ed211df73a0","src/mount/types.rs":"601ae3e10b7dc496fed7f3b4=
0a80e81c6edd7bf13189d7be45c3212d4c684c39","src/net/mod.rs":"7899807c9ad9e3f=
dbfd8b3ce2a1c7053d4f46dd7fa76102f620c6042c2d6314f","src/net/netdevice.rs":"=
1d790ef6e33d30c3167ec422a95a711d6df26d69502cb0b4c4889623547d3693","src/net/=
send_recv/mod.rs":"e888cbda77db981db039060200b458a856c932acc1258001eac147b5=
df9b63bf","src/net/send_recv/msg.rs":"39f7460204af2e71331d07259bc4c9a2cc3e9=
937bba72430a5b85e7054f5a46d","src/net/socket.rs":"151ac4b46f81ca1b2ee98f60f=
43e4d32d6327eb1bbfed050b0dc0c4241ab3100","src/net/socket_addr_any.rs":"8825=
0bf218d3a626e8e04bb11d4dd50ddf1422bb28d780c98b80710cf9c30166","src/net/sock=
etpair.rs":"008115435028fa3533739362efab3ff9d8209e49e70040eaa23578711f90045=
6","src/net/sockopt.rs":"d6ce0e65912e0d6d450c9dc870d4de7340f6f5308c5b21c7d3=
d66463b9d0577e","src/net/types.rs":"7b430c33a1bed0ebdb10f997d2c0c0227fe335c=
cd11d8446d9846627ae84a2a9","src/net/wsa.rs":"29856e6d0108be6b719f6ef973c539=
6e48ddd58ecd0c2db9ca3e2e0ba4eccb5b","src/param/auxv.rs":"b57483d3083a4dfad9=
ceb049fd96d54713b91b7f31b8c9a0e40501548da499ac","src/param/init.rs":"a31c0e=
5cea61a1a999767fe74f87c0d59eeb6bce66578b842fe0e0c32be27a55","src/param/mod.=
rs":"c514216b96d9520c9ffc5662c97b24f1f36f56fe1f5f3c9f64175c8b35577288","src=
/path/arg.rs":"ab5ed60c8cbf0484dce25440f027d7d511ea329bbaeaf83d70717f5c7e47=
b5ac","src/path/dec_int.rs":"0c71377fa5137595d6316ee135617ab8e514a2f539d77e=
15ef3a626d7aa092c9","src/path/mod.rs":"fbe294749100630467580f5e25b44e7a4f8a=
4512381cc18acaf1a6813afc39cd","src/pid.rs":"f1c486000c5b1311b2d720cee88f089=
c17ef9a171709673dd06e6f35f4ff98a3","src/pipe.rs":"48ff976a2b50f679a0e0aa6d7=
938fb88f56bde6804360bcef259cf5f524d75ff","src/prctl.rs":"19aa584895874ea48b=
9bbe1bf695b81257b0281df64dfdd91e1b4bfa298661b7","src/process/chdir.rs":"7ca=
ffd22e586fc448eaf55ca9ec9e41ad462626278f08352623bd1c88a91488a","src/process=
/chroot.rs":"01191eeb86295975874019dc675cb0f8f0ca5f79dd78dc9d1c791a952adb35=
12","src/process/exit.rs":"f09000df82151d015a39b8cfe7dc28875074ad1bfde326f6=
3be1438cf736d08e","src/process/id.rs":"21a487fe2384add719462f7cef500de0e286=
acf20ec5a6773c748ade08b99aff","src/process/ioctl.rs":"c7f551152d65ac173d9ea=
a298b964339037b60a7b81e8bc316453718417a6be3","src/process/kill.rs":"674d06c=
f065c8045dbefb6fc6437a62b964069599fc03d84e64cc36186b96596","src/process/mem=
barrier.rs":"1c4c39b359d1d0e9bbe16352eedfca9278d9ef298ade8ec00e998617bbcbfe=
d8","src/process/mod.rs":"a32691289982f4ffc53fef94fea4e3f375af9af87604fb962=
e94c54c9d91703b","src/process/pidfd.rs":"150413a9cc550ffc432b3279a368223fa9=
577544ef29e45edeff3b79ae316cab","src/process/pidfd_getfd.rs":"74c778b872be0=
b800870e4633606461fdc8493b259031e35f8f558768d960cc2","src/process/pivot_roo=
t.rs":"aeb2464464efd81ca0b940e3e5e3ed1b09380f3e6ba3200972e0ba100f78badc","s=
rc/process/prctl.rs":"a34ccda958036f49c5e4a5d654566c2b18d59c4b48b31c91e6387=
7191752712e","src/process/priority.rs":"ea78f09e4564943d0083eba19d9933781a5=
dd70d5723f156eb16ad01dd67d89e","src/process/procctl.rs":"3cf13470c19c6758a2=
8d7f3bacde1c1e4393ee702742cdfbfa45dce58cebd602","src/process/rlimit.rs":"10=
becde11d8b5d3b50aeb21a8fcdf53ec7803bdbbf8d1f4233b8e6c0b85fafb1","src/proces=
s/sched.rs":"4f566593f7a6c12873ecb18f21b9806162791b33815c9147065d3c8d812b56=
2c","src/process/sched_yield.rs":"8f80fef12e528628d19c26d26ecbad61b9644505a=
872a49f842820aa52018cf8","src/process/umask.rs":"15841f5e178dd032f8b8def854=
5c9e98b205e6b1ba70bf9c07c2c0327a8999c0","src/process/wait.rs":"04d60c43e8ed=
1ac44e4ddc5ba6e18e5edf1c400565ea0e81ff8f1bf71403b7ba","src/procfs.rs":"adfa=
c2c1232ff20c18251b8745f6732e3315b1adfe95b9e7297378dbcb290129","src/pty.rs":=
"3c045b9ce8c24cf380de77f9c5640b6adc1774d6df5c2e5639b965560960ba8d","src/ran=
d/getrandom.rs":"a89f45838d22982eb0997bc905031819195701b64aa1c874e646dcb16d=
6e2a7d","src/rand/mod.rs":"e1fb7542f1958fe77673aa628bd92fef1b9addf79ba23df2=
398d1231cb61c148","src/runtime.rs":"723558853e479dd33eb5c1448a23fb7ab4ce007=
356d55978a28245b0d8f73668","src/shm.rs":"30b32e302ad2d198de411981f3c7609082=
bc20f1c0651aa3f3ce2beb8f19c6e9","src/signal.rs":"0fcce2e37f69d70cfef1f35535=
5979b269820281a6e63bd171ba05e525063e79","src/static_assertions.rs":"504cf66=
f0d5b8e335be02f9ae8b0a355abc98c2c82eec0098bdf0988e662e260","src/stdio.rs":"=
ffa955a09e16c47ac11f4be9cbfdf07b2b4ffc0cdbc9bf70f0a49dbae2d7a188","src/syst=
em.rs":"7eae745660ca4a7c4885424af2fc89025ae7e51636ea9c8714f0a9b90d979dbe","=
src/termios/ioctl.rs":"aa26694c9be5378ea52e669313e64b25fc034e3863b72281530c=
42499570fedf","src/termios/mod.rs":"b44b7caa60b6f458657ed58a0e0eca41bb4e6d6=
be4b0f042bbb8ab7056cebe4b","src/termios/tc.rs":"bafcc607de993c7e7c4cd6f15a5=
9e7807906e59bf991a5a4c67e3b076d07e3f2","src/termios/tty.rs":"0013cc4c319072=
46b45c4b94ded0171dc0d3e6759740f5424831feae700092f7","src/termios/types.rs":=
"d4cbd4bae530c2e66931f8ad178177cef04ad49567be4abb7046ac7ce926919f","src/thr=
ead/clock.rs":"71f1c545f29e672f242ab017029d20cba98e05463402803540474098ffb0=
4399","src/thread/futex.rs":"cb6d58120194ea869df407761136e4e98cc7d775615472=
03b74ca1a5dd9e0958","src/thread/id.rs":"1a9a8b4bfe71dba6aec17760ca9de5a66a8=
0b9c608fa0eeb30fd1bc949e511ca","src/thread/libcap.rs":"4c51b7df566d38dd0f85=
f81ef53279a745a39f0f4e1154791fd38438e2ca7db1","src/thread/mod.rs":"d6d9c334=
0cd9710869813ea9c993669d11620126edc66e5657a9de2a07a5f864","src/thread/prctl=
.rs":"3826dda31b9452b2a8b30158b6babd0b536fe9ea314027863d14c3888c9435ee","sr=
c/thread/setns.rs":"ddee643bd095104242afc3ddd3ddcbcfd6a4876febf47200a63f9e2=
2996e1dec","src/time/clock.rs":"7588a33f5279ee683f39ce72a8d0a8dfcc2e25d3dbc=
29990e6829d7c2df7d99b","src/time/mod.rs":"43afee938c80d124d04d4ba190c03f4d2=
1d1e3bfc154fff309211e4f6eabe940","src/time/timerfd.rs":"f17092b84553741aa2d=
2b44c6992b5d2c8c96cc2c2007fc9a2c6b2064485e53f","src/timespec.rs":"32a4d930c=
bc0f6dbd23153290db920671cf4ce65a4a127e176f897c1cde42d7d","src/ugid.rs":"661=
6c6e35b7e43aee5b150f1efae7a50711e0947943c9a96833dbe214ad9e85f","src/utils.r=
s":"ad680ad8564cb7b37fc746e0b3f89d389278fe1b294ef343a5c4a37677414065","src/=
weak.rs":"7e3169bc97e76fc4d52b040391a8df36b06536fc0f81cc6e8e71b951cb1fe54e"=
},"package":"8acb788b847c24f28525660c4d7758620a7210875711f79e7f663cc1527268=
11"}
diff --git a/recipes-devtools/rust/files/zlib-off64_t.patch b/recipes-devto=
ols/rust/files/zlib-off64_t.patch
deleted file mode 100644
index d3c7703..0000000
--- a/recipes-devtools/rust/files/zlib-off64_t.patch
+++ /dev/null
@@ -1,33 +0,0 @@
-Do not undefine _FILE_OFFSET_BITS when
-_LARGEFILE64_SOURCE is defined. This ends up
-causing 64bit time_t to fail the build because
-it needs 64 bit off_t
-
-Upstream-Status: Submitted [https://github.com/madler/zlib/pull/764]
-Signed-off-by: Khem Raj <raj.khem@gmail.com>
-diff --git a/vendor/libz-sys-1.1.18/src/zlib/gzguts.h b/vendor/libz-sys-1.=
1.18/src/zlib/gzguts.h
-index eba72085bb..31242f9f80 100644
---- a/vendor/libz-sys-1.1.18/src/zlib/gzguts.h
-+++ b/vendor/libz-sys-1.1.18/src/zlib/gzguts.h
-@@ -3,13 +3,6 @@
-  * For conditions of distribution and use, see copyright notice in zlib.h
-  */
-
--#ifdef _LARGEFILE64_SOURCE
--#  ifndef _LARGEFILE_SOURCE
--#    define _LARGEFILE_SOURCE 1
--#  endif
--#  undef _FILE_OFFSET_BITS
--#  undef _TIME_BITS
--#endif
-
- #ifdef HAVE_HIDDEN
- #  define ZLIB_INTERNAL __attribute__((visibility ("hidden")))
-diff --git a/vendor/libz-sys-1.1.18/.cargo-checksum.json b/vendor/libz-sys=
-1.1.18/.cargo-checksum.json
-index 97ce9d4c90..115bcf97ad 100644
---- a/vendor/libz-sys-1.1.18/.cargo-checksum.json
-+++ b/vendor/libz-sys-1.1.18/.cargo-checksum.json
-@@ -1 +1 @@
--{"files":{"Cargo.toml":"32a7c9ac508dc33ad03b44010f7cd1bb3592fd069e9e0b9ca=
ffd909ff2795184","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d059=
d3249e0bc93b36de45f759f2","LICENSE-MIT":"34c467b6945a22696d060b8fdd2379d464=
acb3408d4c599d3dc5fe4fa1b4c84f","README.md":"3607fa398947cdc3cfba6cc985fd81=
91fcbf2699d89d3a36e3500eb27a0ca17e","build.rs":"1b370eba51513d53e37b50f9582=
a9ee4d85a83ce2b5f51ebe09f5ae489954e31","src/lib.rs":"8f9f42e8c80e134fa6f572=
4c677a341689e2e16cbe93a15495a1b4d8bfa90c49","src/smoke.c":"10607c81b73811bf=
cb9718767312bf97ba2ccf7048ea2f18a2085aa06ad7f91b","src/zlib-ng/CMakeLists.t=
xt":"6b7d83767c0fe0b98e2d5321a2c35339e04bf314f6bf650f4716a7434a3e164c","src=
/zlib-ng/LICENSE.md":"d3c80be055d94d798eaa786116e84fa0b010bc11420b5d2060d97=
8ea77845436","src/zlib-ng/adler32.c":"b96656d1fc0133c44caeb3509d545d0b68580=
e77157b8c6f0fd6dcf681726ea5","src/zlib-ng/adler32_fold.c":"66b32963c96e43c8=
4b53eff737d11186bf165e04a48e9c3328faa5c86ce8128c","src/zlib-ng/adler32_fold=
.h":"c40114c2c742b6410e54b58ea02533fe6e9ae0ca62d3453e5d2a1725d33e2be4","src=
/zlib-ng/adler32_p.h":"fa8b96371128c54ed9c2a06175006738d395d380672b4894c32f=
ece37b8a96a0","src/zlib-ng/arch/arm/acle_intrins.h":"313646b741417269d175b2=
620c7bd2cf1cb5bfc940c5bb3dd600189fce27cd79","src/zlib-ng/arch/arm/adler32_n=
eon.c":"bce2fe7d3a5f663ba2894d3c9b13151c5cd4c16bcc1d31ac32a85713ecc20f8c","=
src/zlib-ng/arch/arm/arm_features.c":"dc2fa2e5593f0ff1f837138b99f26d1f805f8=
2f69d2721cc2b2a386b5dac7b1a","src/zlib-ng/arch/arm/arm_features.h":"0667e8b=
aaba1edfa60ec6faa5ce35eb35f5e91c85633e831f397a9af3c220b9e","src/zlib-ng/arc=
h/arm/chunkset_neon.c":"042d3e6f865b5b0bfec8b5196288cce2ec47e9ca2c8a5e07558=
0dd302238e421","src/zlib-ng/arch/arm/compare256_neon.c":"7eec4ca0415dec895a=
461a4d1fcd3068e0d68482d048257022511b3490372ca3","src/zlib-ng/arch/arm/crc32=
_acle.c":"3fa85db742ee584f3787e3d131d92d6196e44f9df5f3034d804abc78cbf81d3f"=
,"src/zlib-ng/arch/arm/insert_string_acle.c":"5ca256a6f796d8bff478671ae5b0d=
7cfe236b58abffd6a99bb2cac097fe7935b","src/zlib-ng/arch/arm/neon_intrins.h":=
"22262195cbd668a11953449c9e1be3b9b3374469d21f3e73ab34c6ea0dcf275f","src/zli=
b-ng/arch/arm/slide_hash_armv6.c":"9abacab94d74e7d8b1d863f20aa97fb5380059f0=
8b91480a14377d3ed2d1f768","src/zlib-ng/arch/arm/slide_hash_neon.c":"7c4927c=
0dc8b28c5fba1efb30273653e71172ce051a0341ce2f1d2c0bbfa418c","src/zlib-ng/arc=
h/generic/chunk_permute_table.h":"3f1e09e697a9b2dff4395aca356e61765c44511a9=
dc653abb6998671afd20ae6","src/zlib-ng/arch/power/adler32_power8.c":"e5a5bfd=
d9963e8f906e36978f1a655139908740559da2b382ddd5f3e2ffe6f56","src/zlib-ng/arc=
h/power/adler32_vmx.c":"841a7e3792d1f68a0925969d6f9737cfb2b650b3a82721a88f1=
e5648f7b0a58a","src/zlib-ng/arch/power/chunkset_power8.c":"569a7dc686a0d806=
86e516ec8fb7c2331225f706b37ccbf0874e6d822e82f806","src/zlib-ng/arch/power/c=
ompare256_power9.c":"cfdc33f5e605fd41351423fda0eaf7692f9e9f0083d6c4ac870c6e=
467d534f48","src/zlib-ng/arch/power/crc32_constants.h":"d73e3b9025de9fade7f=
a3ba2bbf5f56a1499a84c53d8ca7f5e744a0714d8599b","src/zlib-ng/arch/power/crc3=
2_power8.c":"add20ee86ff5c28396ee2e7f77d825d7e425b89467331953690c40f40b5dba=
41","src/zlib-ng/arch/power/fallback_builtins.h":"78a8da60bad8ba01278e49548=
2108adabf9e96bdb214e869b61ab1f63f518c9b","src/zlib-ng/arch/power/power_feat=
ures.c":"4dc4c14dfa2d3333c73fad7b1f7a79d3fff68c1d1fd643012faf82bd4114553e",=
"src/zlib-ng/arch/power/power_features.h":"c9c47cfcfff347e79f83f56a0677565d=
40299e03ffbeb918c4ae69518d290ada","src/zlib-ng/arch/power/slide_hash_power8=
.c":"58d93cee1a2cf14f13a8e9e31ba5149fe2b1e069846f52ac1f11c42cfcbd49a4","src=
/zlib-ng/arch/power/slide_hash_vmx.c":"1b6297a9616456ba534bc1d93afcb99e36da=
c357be68aed106bb71dfea621a86","src/zlib-ng/arch/power/slide_ppc_tpl.h":"c89=
00c594591e1aba3188f97c374e5561fe1e96f653c668352b25647e449f4c0","src/zlib-ng=
/arch/riscv/adler32_rvv.c":"e2472cf46b376a0ed8b7545a3192d195659353e09377221=
6f0d28ae7d75afb1a","src/zlib-ng/arch/riscv/chunkset_rvv.c":"d5b0fd27dcc8d4b=
3773caae16290014fdbc0011cf62e7f63a4e5d897149b165e","src/zlib-ng/arch/riscv/=
compare256_rvv.c":"4ed8d6b39ef2218c1d474ab586fc19d7e0821445241e5ccd6a75992c=
b17b3bb7","src/zlib-ng/arch/riscv/riscv_features.c":"a117eada0164dd92c06e98=
04a70fd2f434b8d14a6d443f0b3513330fe08c18a3","src/zlib-ng/arch/riscv/riscv_f=
eatures.h":"26953a09f72edb0e66978044d75e054e40d36d2b62244359b5e5e4ab936d2c9=
c","src/zlib-ng/arch/riscv/slide_hash_rvv.c":"87c1a2acf51af38f2d337b482fcb7=
2d080b0897e48abc9753b51d40facd9a1a1","src/zlib-ng/arch/x86/adler32_avx2.c":=
"cc0598333eff9110b5e8c0dc38ba543bfdd3ca5a66825f440909ba7a8923fdd3","src/zli=
b-ng/arch/x86/adler32_avx2_p.h":"45e6264edffc737081f55a5b5e85b28d9db0b27b63=
183ffbb492f8c11bc670a2","src/zlib-ng/arch/x86/adler32_avx512.c":"7a949d8ad2=
d15709d33872ee97e70a2e0cc2c6c375d7064cbc02b87e70905d1e","src/zlib-ng/arch/x=
86/adler32_avx512_p.h":"1b4beda11693ac03e4b20e054a765df427f845a279bce547b82=
08d20f5a302bb","src/zlib-ng/arch/x86/adler32_avx512_vnni.c":"9d11d2049df211=
f11a48a91e340e20686763c1eac20463dcd27dd7bfaa159f76","src/zlib-ng/arch/x86/a=
dler32_sse42.c":"1d2dc53b05ac75667c6d1c625c8c391e4851b28cff9e97ebfdb7747675=
81fff2","src/zlib-ng/arch/x86/adler32_ssse3.c":"7666f99b2e530265cb9848c1047=
ccc150da0add19b41aa2d7756c617377622c6","src/zlib-ng/arch/x86/adler32_ssse3_=
p.h":"5aab2f802ba6bdebc63b411018e5116fe26d38e90adf353646b65af4ebe7fa40","sr=
c/zlib-ng/arch/x86/chunkset_avx2.c":"ac300f37fbc99ab2d3bf47a640bdf2d87ad835=
8ef081eea21c541966830281b3","src/zlib-ng/arch/x86/chunkset_sse2.c":"a400a12=
8a84185c945f9ac9303e17c944f2008085d7a4402d279bd59893dc89a","src/zlib-ng/arc=
h/x86/chunkset_ssse3.c":"1f69ef9ae20cca1e4fc6924462255b8969685387c10694ef1d=
da28b3098d6f6d","src/zlib-ng/arch/x86/compare256_avx2.c":"2516d00faa6939e61=
dbb0978a9c4c81f9e3a42fd053b2a2241673da7cf4fc781","src/zlib-ng/arch/x86/comp=
are256_sse2.c":"3b983708034f33b5da49f6f5041351a2e66358c76645c552f6e4dc37fb8=
90a80","src/zlib-ng/arch/x86/crc32_fold_pclmulqdq_tpl.h":"1b3b79dabff0bf7ec=
c3b07356c5aeb6ae1fece0fd70ac7e235aacce3da77ea19","src/zlib-ng/arch/x86/crc3=
2_fold_vpclmulqdq_tpl.h":"7eddba31e3d1b1808fc6df9f96ada03c59952961af895d853=
8f5a8292392b5cc","src/zlib-ng/arch/x86/crc32_pclmulqdq.c":"f247408c353bbd0f=
cafff23fb97aeb4d9a72e0a416effea566183b9b5dbedf7c","src/zlib-ng/arch/x86/crc=
32_pclmulqdq_tpl.h":"5fedffe4b853cabfef09cfcebb501cd53a97c212e470bdfc65c28d=
c998840e05","src/zlib-ng/arch/x86/crc32_vpclmulqdq.c":"870d06ca9fa7b48db4b7=
20d2fd6262094200cf6180fa76a601d17c722bf0e406","src/zlib-ng/arch/x86/insert_=
string_sse42.c":"28a6d418a9563d464414c3880d6053c656aab40c6ebe21947cf17687d8=
2e547a","src/zlib-ng/arch/x86/slide_hash_avx2.c":"9740a36bb4dd90f4039434402=
6be9a13f3acb6e85e6b7681c30fd7f7cbf8e28e","src/zlib-ng/arch/x86/slide_hash_s=
se2.c":"fa009305a1c82708638dff25e037067656350303b25f5774489417e096c30ecb","=
src/zlib-ng/arch/x86/x86_features.c":"b755befa09a56ed27d70f2be93b0a72a355fe=
8b490827b55fce60ab51693c70d","src/zlib-ng/arch/x86/x86_features.h":"6429fa7=
345a9892633c884f7fc26f9558d86c77df9e8589ba9623a27e1d9fd57","src/zlib-ng/arc=
h/x86/x86_intrins.h":"707b836360628cb34a0fb7fa675b5e8674d146f55b1f60fd739b8=
5aa5dc935cf","src/zlib-ng/chunkset.c":"531f58c77c184b225304888ddf1930a76bee=
fbe4a7974edf0efeee7b6662520e","src/zlib-ng/chunkset_tpl.h":"9919e10e9c22443=
16e13de41b66dc333d9b0413af6265fa860768eefa39ce033","src/zlib-ng/cmake/detec=
t-arch.c":"1af38707fadc192c8e4a28715c896148a0909be821fb443919e191ff2374ffdb=
","src/zlib-ng/cmake/detect-arch.cmake":"85a2eed469fc7765e51c382f475868a644=
036f057f5b749d3ef59eec2b4b2748","src/zlib-ng/cmake/detect-coverage.cmake":"=
4664d51152d51282ae50621f4d510ab72cf8978b266c614b7c5361750db6d1a9","src/zlib=
-ng/cmake/detect-install-dirs.cmake":"4c8e72cee23ce9c6db02566a31fc7a78f0bee=
ac6f09c61c2d90a1cff3c083db1","src/zlib-ng/cmake/detect-intrinsics.cmake":"c=
fad619b863adf57132434f7b9c36c4f1a0466e5fdb11ac673e703ed5e471cd0","src/zlib-=
ng/cmake/detect-sanitizer.cmake":"a40650743dfd0b56c2afbfadb53e5d1470ef48852=
f2fcdf51084b6485534f87a","src/zlib-ng/cmake/fallback-macros.cmake":"a8c8f70=
e5483177280cbebf99f929a7cf5ffe2b79fedb79eed570ecafc78effc","src/zlib-ng/cma=
ke/toolchain-aarch64.cmake":"46be0bf580a49a528c72005484655afad1de3705b39a66=
a7b0c213b0fa81cee6","src/zlib-ng/cmake/toolchain-arm.cmake":"05e38076fd6ffb=
9785ff9844ccecd26436c9dc4c25b7777b62e5f52e788c3882","src/zlib-ng/cmake/tool=
chain-armhf.cmake":"1a2029163a57415eec9a5dd5f45d3254d349e97b1beb5d16876b741=
717673341","src/zlib-ng/cmake/toolchain-llvm-mingw-aarch64.cmake":"4deffb54=
1ecd21ade019daa2e96e832ead8c2c62b633bedb8688d0e7c7012d33","src/zlib-ng/cmak=
e/toolchain-llvm-mingw-armv7.cmake":"3e95adbade93ec162478de3339427ed88b12c9=
22f4975c2918977859325f5459","src/zlib-ng/cmake/toolchain-llvm-mingw-i686.cm=
ake":"1064a1ff2bab21489c184c1cc2b07181ebbbcc32e45c13cf8ed6b9ec60560c2e","sr=
c/zlib-ng/cmake/toolchain-llvm-mingw-x86_64.cmake":"577d333ad70cf27ededc755=
54428368e84c334cc7b716e18113620f5e7edf305","src/zlib-ng/cmake/toolchain-min=
gw-i686.cmake":"df9000354b820d3713d1469edc9f94cd095389b0cca83965730b8e64857=
fdf3f","src/zlib-ng/cmake/toolchain-mingw-x86_64.cmake":"ee316e6e3202919da5=
d497f9e246466fd715fcf079cb5b4afc4774089d1fefad","src/zlib-ng/cmake/toolchai=
n-mips.cmake":"0d0d00b809a30021bb4b9e3ace7371200bb4bfa6509813c829ca0cb569c7=
af68","src/zlib-ng/cmake/toolchain-mips64.cmake":"f19574aa068ca4374b657ce7b=
d0517b9297c622144814a095e26db05f0a1cd20","src/zlib-ng/cmake/toolchain-power=
pc.cmake":"9bd6fc58ce5b70603657f2c195c4a5cf52fae96ad63ac787978831c5858f762c=
","src/zlib-ng/cmake/toolchain-powerpc64-clang.cmake":"aab0b9e0f19a281dc99f=
4dfa5675976c40b5fb7f8139dd2eb0901fdf3cedc952","src/zlib-ng/cmake/toolchain-=
powerpc64-power9.cmake":"57c789c468e733971c2654faf34f7dfc9dd1e0e5bcabbd609d=
cd01dcbd25c487","src/zlib-ng/cmake/toolchain-powerpc64.cmake":"917fc5eef849=
21d8b38f43c2b4f60870965b4eecc8f018c7b3499e1142c715af","src/zlib-ng/cmake/to=
olchain-powerpc64le-clang.cmake":"47ac4a05b61210a83c7845a5522b91740bc8a7bb8=
97312cc37131f85bae9e1b5","src/zlib-ng/cmake/toolchain-powerpc64le-power9.cm=
ake":"b295b61ea248d8ef98d9276fad3db143a6fb80ab738c54bf88cb594d82c70a8d","sr=
c/zlib-ng/cmake/toolchain-powerpc64le.cmake":"5b2edd36d62de513db2d32bfbf779=
979d81ac527b981cc3379a4e933fc5a94d1","src/zlib-ng/cmake/toolchain-riscv.cma=
ke":"d7b4ac4be3651aec2e55788d815141482d4fe92713713fdaba9215dbbbc9b88a","src=
/zlib-ng/cmake/toolchain-s390x.cmake":"cf52cecea7bd2a9d1ff5fd8edcb03c531e3b=
404bbcd15a15dec2e0e19936f2ac","src/zlib-ng/cmake/toolchain-sparc64.cmake":"=
e543062485d06a7e0fec8135887c5e73363517fa4babc23ef7b780916d75afda","src/zlib=
-ng/compare256.c":"4890f97239f63dfbbc986ddd05039798752ec0ad530ff7d25978deb4=
4f774ad5","src/zlib-ng/compare256_rle.h":"30fca191b0474e1549d3ce292bb11ee90=
dc3dc9fc685932cec3971c1d0e8f652","src/zlib-ng/compress.c":"f7c69a4d2f3b87ff=
0094115977dde1cd17703cc9856ba19489dd94e0ed16b646","src/zlib-ng/cpu_features=
.c":"aec359d85d64c2ff88132a123406726bd966e0d56d0dc8ce1d5c3f25e1801440","src=
/zlib-ng/cpu_features.h":"21c43d2a8375e73abea63082e08d9279eaf457970d34f8778=
30bb31575498a8d","src/zlib-ng/crc32_braid.c":"8a33cffb026b82a027b45e0419358=
36b36b2d075796e5498e33ce64ec0cf93e8","src/zlib-ng/crc32_braid_comb.c":"2177=
41d3c1c0018bb12ab22c987804634605f5b7ad6bd243e25eb0499c80af5d","src/zlib-ng/=
crc32_braid_comb_p.h":"6c8035e05d30a6241be55467fc59e4d7deda6b618b955a11339f=
fee08a39c75a","src/zlib-ng/crc32_braid_p.h":"951cbd948664498dd8a56393bc88de=
bdad8b21dcc8e1f16d883c07170e4adb4e","src/zlib-ng/crc32_braid_tbl.h":"e22af1=
12e3c1c8bb4065d39fe678eba71dd08893eb06f9414b02f4cf5a6f46de","src/zlib-ng/cr=
c32_fold.c":"f6363abbd1e167bc7a6fa8f92e5211f4fa3e70d30fa5e10fa6f416f5db3726=
78","src/zlib-ng/crc32_fold.h":"42412c5029057579148a2238b0bc882f294f661d2af=
102bd9213531894302f29","src/zlib-ng/deflate.c":"70c72cdbf88987660e787a99658=
641bce36fff4848f9bf395f3727df9543664b","src/zlib-ng/deflate.h":"f45a6097101=
50fb758ca89b36a7f5a029b525fe70f0e3296a4847d73872db2ca","src/zlib-ng/deflate=
_fast.c":"52648097b16070c156c27d38566720eca08d48e35cd89a80f196f0e77951112a"=
,"src/zlib-ng/deflate_huff.c":"923d316676c00f307a7d6a58d77f9364f06607afcc68=
6b464b557ff5478f8b6d","src/zlib-ng/deflate_medium.c":"d3172c1ea0ae1bc2e3b76=
91b005bbae35e84b7588ef2f5805b9dd0c4ccecbd67","src/zlib-ng/deflate_p.h":"2ea=
ac98e9232959c730d84a408bed641be817dc3468aeb427062d06b02eb80b4","src/zlib-ng=
/deflate_quick.c":"3825eb4d22a150f9cdaba93db890d95b8d9e9d0f3f10524fb27a9a12=
89aa4c0f","src/zlib-ng/deflate_rle.c":"5dcc0496f74b5ce677ab5a58ea232d0ba653=
102d2f71cf35daa6069ef88b7af6","src/zlib-ng/deflate_slow.c":"5449816c381138e=
b07cd54ec7c0c77fb811f4f274c27bf15d26e008de6a9eb5c","src/zlib-ng/deflate_sto=
red.c":"89b81c09be2ffd84138940ac6c4e9688f956603b45eec6d0d52d579cac3f15e5","=
src/zlib-ng/fallback_builtins.h":"c02e559d19f351f2f9371ee2042ca6a725d14f178=
62dff2414fd2ab3d7984875","src/zlib-ng/functable.c":"d7ac98c7def281c707796a4=
317e2dd6754d654bc8d833ae67a77f47a7c1dd5bd","src/zlib-ng/functable.h":"64fba=
baa8459898d14cb88078676c42fce12a951b4b1d83f9085e104ad407a47","src/zlib-ng/g=
zguts.h":"d9a4e984bb6c2ebe5c858b37b1c6411af1edc21c3c15d63b6588016b71369b71"=
,"src/zlib-ng/gzlib.c":"91011bdfaa99bb5e49aece64fdee995207b1ce5a96227990f16=
f9aea55026c8e","src/zlib-ng/gzread.c.in":"3501e5124923207b2603d9695c3bad181=
5ca2dc8f18b6525bdd5dfea60313acd","src/zlib-ng/gzwrite.c":"9f474aeefaf0150d8=
871eb9202ebd43a28f18bdf39eaca4f35cfb52227e74c63","src/zlib-ng/infback.c":"d=
b99c5b105c34c7c2967bd97e16f976217530c22d6545e61cbf657522e24de87","src/zlib-=
ng/inffast_tpl.h":"51622f34e8808798a43412b4fde62ebd58ba012f5452bf2ad9a8001c=
98539166","src/zlib-ng/inffixed_tbl.h":"a94225335396245e9f0ccb2e9b4b334fe7e=
e0111ed8e32a26bcd52187f364314","src/zlib-ng/inflate.c":"2c1bd0f4939c372e49a=
9ee0ec8a8cdee369d9c6c10124b4e11cd197f44ce3a36","src/zlib-ng/inflate.h":"175=
0ab33be4461f2e6b8e43bef5da11f3db49d5d2a3eacd03d881d33c1df7def","src/zlib-ng=
/inflate_p.h":"4a31088faf818d2615de31b099e8f55ee8463166477d6cb5d6763c913b6a=
cef9","src/zlib-ng/inftrees.c":"206fa4c762203823151dcd3b1a5b389fb40efd4c88a=
eb2bc302aa1d5cfd6d6d5","src/zlib-ng/inftrees.h":"2ba1beb76d7922fcb37708809e=
31f62ee366827da80faf09a7e461b439afd291","src/zlib-ng/insert_string.c":"7a94=
55cbb3ca8fe6e7111471b9f4c0a32fb49a6d0ec589b027dc2cb2b65c8dce","src/zlib-ng/=
insert_string_roll.c":"4d05f19591a5c29d2da398e10e9d0b050d738cc8838d8dda4beb=
1cc7281ede07","src/zlib-ng/insert_string_tpl.h":"972e69808ce5e74d0c54af4ee4=
47b996b2d0563eb861b90856693037ce8cca9f","src/zlib-ng/match_tpl.h":"1e20d0ef=
73a5826606240f4efd2a8e993d203f376017397342b9899b1f919276","src/zlib-ng/slid=
e_hash.c":"74adb34a4a35331db810dbb5d740af10cc1db7d24a89ea387aa2dec956a05b2b=
","src/zlib-ng/trees.c":"310fe64c50fb313773c2058c606b1a3cc085b8af7771eba325=
ad5c9355659100","src/zlib-ng/trees.h":"24174f3543b01ee1ef370bbf6d15551a2187=
1cded18b2aadf09a71e7904b6f99","src/zlib-ng/trees_emit.h":"6c541dcf01eecf393=
d4eab7800bc558ad524114bb5a8deb86f13376fbef88754","src/zlib-ng/trees_tbl.h":=
"022736ff3362ef3591d1f8fc3b7fede5927c0d25ab0813d7ef8cd95efd6ea242","src/zli=
b-ng/uncompr.c":"bb03a6ae65e1395f3cb2fba1dee63246a1fcd30683fd3348e320e78952=
1055a6","src/zlib-ng/zbuild.h":"e6f34c26bd82dd7650a664d7b336d1e4c83b871bded=
79e05602e779ffa69993b","src/zlib-ng/zconf-ng.h.in":"83514b2e2858b0d6647159e=
9aa47fa84bb625ed2ac6117284f514cacc42a993d","src/zlib-ng/zconf.h.in":"6768f8=
4c439683b4a590338a9be40c3bd7a9702b25e8e546c705fac08674c3bc","src/zlib-ng/ze=
ndian.h":"5be3e2989524198f13b68cc083b1502747effe92325edee59e3c4ad93cc3c62f"=
,"src/zlib-ng/zlib-ng.h.in":"3bafbff2b78a88c1f0de4195a17b8fcd1fb12fcf2d40ff=
e1970415f6778bf9df","src/zlib-ng/zlib.h.in":"9f74dd9f3244ac1152639c5ad5dd19=
95914b7362adb1f3890698da377cf26c3f","src/zlib-ng/zlib.pc.cmakein":"a97486fc=
ab3f191d807ec04d4487d6a428053ab452b59687ee1f71cf52b02a31","src/zlib-ng/zlib=
.pc.in":"848e017a079b14853df8d19699f4edac2304767ef4eb2cf525a06ceb60d301b3",=
"src/zlib-ng/zlib_name_mangling-ng.h.in":"a829fd869339579afe7ce8c1f8a547359=
8c608f3427c3cbbc1800088d6640e7a","src/zlib-ng/zlib_name_mangling.h.empty":"=
38e51a846d6c2bd6100298c55328dba4437c08fa1dceda4eb2e06ecb1d142058","src/zlib=
-ng/zlib_name_mangling.h.in":"16e9ede4821d873647bf105b12e71245d3b7cb79ed318=
fed0a8ab5aa63b2b4da","src/zlib-ng/zutil.c":"fce8e83d2040be8bc389ec61a8d6c7b=
32c0b3cd208599c01c5a58ef6418de87b","src/zlib-ng/zutil.h":"618641510d89936fc=
bca382dc60aea97b5fe35aa010386df0a8ec3ed1b1602ea","src/zlib-ng/zutil_p.h":"6=
ca034b9d3f6a702b03a71a1f3fd61a0fe6bfb3442156cbdca090adea8eb3f2d","src/zlib/=
LICENSE":"845efc77857d485d91fb3e0b884aaa929368c717ae8186b66fe1ed2495753243"=
,"src/zlib/adler32.c":"9cd1443a24ff2a3053961695bd432035c58347386a420d338823=
2376ebabe211","src/zlib/compress.c":"86f802c16a965e7a28737e3730b4e576c5ba40=
981753967e3e30916f4dc1b4b1","src/zlib/contrib/dotzlib/LICENSE_1_0.txt":"362=
66a8fd073568394cb81cdb2b124f7fdae2c64c1a7ed09db34b4d22efa2951","src/zlib/cr=
c32.c":"8fd16f0a7714d51c89c2eb37eb98ec15e8a4dc57ba343e7b7398b19144039fda","=
src/zlib/crc32.h":"9a2223575183ac2ee8a247f20bf3ac066e8bd0140369556bdbdffc77=
7435749e","src/zlib/deflate.c":"3b956337350f94c34987750f785587ef33d9c89ceae=
bb7c2afb189c956360cbe","src/zlib/deflate.h":"48baf016326d8d5e3e32ac8153cc7e=
22f854b8e6834830b167b998a7fb1e7989","src/zlib/gzclose.c":"35ea6e991a63095f7=
97d8c4cc25817fac7a7155c2ba7dcdbbf648f7871c7ea40","src/zlib/gzguts.h":"716fa=
648aca1bb06c219d7b97ad4846d8479206143bc39557bfd8283f5783e04","src/zlib/gzli=
b.c":"042c2be8ec67ad525a2812e508de7381c6766dde903acf5ae6ac4fa6b541946d","sr=
c/zlib/gzread.c":"72e481aca07b0b85a9783237b85dc67ff3a4c1d19878d0cec69f58d38=
634867b","src/zlib/gzwrite.c":"469b1e58932ea11bdda2a153f6655f7b3c13254240fa=
e157181b49ed1bc93b47","src/zlib/infback.c":"62df9a6dd3eef126f1d81d0ad7a5345=
04610dec44482b0a472b61c93cbab6554","src/zlib/inffast.c":"e6ef64ce5dc0a4cd5c=
7ad08ceeb2b2a698b8447f6bd156057caeb2edab68c0cb","src/zlib/inffast.h":"05cc5=
dc9ff1da7b8b52a4bd8bda0d8a5c236a2f39efe84b941516ea13857e6c5","src/zlib/inff=
ixed.h":"237ba710f090e432b62ebf963bee8b302867e9691406b2d3f8ee89ee7bfef9b0",=
"src/zlib/inflate.c":"34c998ce0037c0537c04b03b276f680b945f9b2c9d1e01b287605=
bd6879f7fd2","src/zlib/inflate.h":"e8d4a51b07694bf48cb91979c19974cf6a5ab0b8=
a09d26ec0d14df349230673e","src/zlib/inftrees.c":"5d4f335221d2dc76f17abd2577=
d92c2d7baf68fa6d7f23373b360830493d1563","src/zlib/inftrees.h":"0a0fcaf2ae2f=
ae57426bdc06637270e9bba974f35202cadbdba479d946e6409d","src/zlib/trees.c":"f=
63c68c16c05fcd196050529d1a0e7657960e4136b9987d90a6ac3e58a964b0f","src/zlib/=
trees.h":"bb0a9d3ca88ee00c81adb7c636e73b97085f6ef1b52d6d58edbe2b6dc3adeb4d"=
,"src/zlib/uncompr.c":"04dca5e31b3b8a17d1806426f66f0c539f4184d657e149d40be0=
7070c6227b52","src/zlib/zconf.h":"f5134250a67d57459234b63858f0d9d3ef8dcc48e=
9e1028d3f4fdcf6eae677ae","src/zlib/zlib.h":"8a5579af72ea4f427ff00a4150f0ccb=
3fc5c1e4379f726e101133b1ab9fc600c","src/zlib/zlib.pc.in":"04c01cc2e1a0ed123=
518b5855f585c93a24526dd88982c414111ea1fc9f07997","src/zlib/zutil.c":"8ced40=
d8c88588811edd2bdb35b7439983d5e1f8e9e32b8a3b244731f3c317b7","src/zlib/zutil=
.h":"dddb2dc7a1dc339ecf2c8e089b366f08bb731c0839c7110240d17ce731bb4fea","zng=
/cc.rs":"3b17502d700e8853261b37f720be2176dfac726df1ee7300ef79b757c6f443a7",=
"zng/cmake.rs":"059da8bf3ed5f2bfa613874b8f6720643ae948a811fefaff8237e95e077=
1cbc3"},"package":"c15da26e5af7e25c90b37a2d75cdbf940cf4a55316de9d84c679c9b8=
bfabf82e"}
-\ No newline at end of file
-+{"files":{"Cargo.toml":"32a7c9ac508dc33ad03b44010f7cd1bb3592fd069e9e0b9ca=
ffd909ff2795184","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d059=
d3249e0bc93b36de45f759f2","LICENSE-MIT":"34c467b6945a22696d060b8fdd2379d464=
acb3408d4c599d3dc5fe4fa1b4c84f","README.md":"3607fa398947cdc3cfba6cc985fd81=
91fcbf2699d89d3a36e3500eb27a0ca17e","build.rs":"1b370eba51513d53e37b50f9582=
a9ee4d85a83ce2b5f51ebe09f5ae489954e31","src/lib.rs":"8f9f42e8c80e134fa6f572=
4c677a341689e2e16cbe93a15495a1b4d8bfa90c49","src/smoke.c":"10607c81b73811bf=
cb9718767312bf97ba2ccf7048ea2f18a2085aa06ad7f91b","src/zlib-ng/CMakeLists.t=
xt":"6b7d83767c0fe0b98e2d5321a2c35339e04bf314f6bf650f4716a7434a3e164c","src=
/zlib-ng/LICENSE.md":"d3c80be055d94d798eaa786116e84fa0b010bc11420b5d2060d97=
8ea77845436","src/zlib-ng/adler32.c":"b96656d1fc0133c44caeb3509d545d0b68580=
e77157b8c6f0fd6dcf681726ea5","src/zlib-ng/adler32_fold.c":"66b32963c96e43c8=
4b53eff737d11186bf165e04a48e9c3328faa5c86ce8128c","src/zlib-ng/adler32_fold=
.h":"c40114c2c742b6410e54b58ea02533fe6e9ae0ca62d3453e5d2a1725d33e2be4","src=
/zlib-ng/adler32_p.h":"fa8b96371128c54ed9c2a06175006738d395d380672b4894c32f=
ece37b8a96a0","src/zlib-ng/arch/arm/acle_intrins.h":"313646b741417269d175b2=
620c7bd2cf1cb5bfc940c5bb3dd600189fce27cd79","src/zlib-ng/arch/arm/adler32_n=
eon.c":"bce2fe7d3a5f663ba2894d3c9b13151c5cd4c16bcc1d31ac32a85713ecc20f8c","=
src/zlib-ng/arch/arm/arm_features.c":"dc2fa2e5593f0ff1f837138b99f26d1f805f8=
2f69d2721cc2b2a386b5dac7b1a","src/zlib-ng/arch/arm/arm_features.h":"0667e8b=
aaba1edfa60ec6faa5ce35eb35f5e91c85633e831f397a9af3c220b9e","src/zlib-ng/arc=
h/arm/chunkset_neon.c":"042d3e6f865b5b0bfec8b5196288cce2ec47e9ca2c8a5e07558=
0dd302238e421","src/zlib-ng/arch/arm/compare256_neon.c":"7eec4ca0415dec895a=
461a4d1fcd3068e0d68482d048257022511b3490372ca3","src/zlib-ng/arch/arm/crc32=
_acle.c":"3fa85db742ee584f3787e3d131d92d6196e44f9df5f3034d804abc78cbf81d3f"=
,"src/zlib-ng/arch/arm/insert_string_acle.c":"5ca256a6f796d8bff478671ae5b0d=
7cfe236b58abffd6a99bb2cac097fe7935b","src/zlib-ng/arch/arm/neon_intrins.h":=
"22262195cbd668a11953449c9e1be3b9b3374469d21f3e73ab34c6ea0dcf275f","src/zli=
b-ng/arch/arm/slide_hash_armv6.c":"9abacab94d74e7d8b1d863f20aa97fb5380059f0=
8b91480a14377d3ed2d1f768","src/zlib-ng/arch/arm/slide_hash_neon.c":"7c4927c=
0dc8b28c5fba1efb30273653e71172ce051a0341ce2f1d2c0bbfa418c","src/zlib-ng/arc=
h/generic/chunk_permute_table.h":"3f1e09e697a9b2dff4395aca356e61765c44511a9=
dc653abb6998671afd20ae6","src/zlib-ng/arch/power/adler32_power8.c":"e5a5bfd=
d9963e8f906e36978f1a655139908740559da2b382ddd5f3e2ffe6f56","src/zlib-ng/arc=
h/power/adler32_vmx.c":"841a7e3792d1f68a0925969d6f9737cfb2b650b3a82721a88f1=
e5648f7b0a58a","src/zlib-ng/arch/power/chunkset_power8.c":"569a7dc686a0d806=
86e516ec8fb7c2331225f706b37ccbf0874e6d822e82f806","src/zlib-ng/arch/power/c=
ompare256_power9.c":"cfdc33f5e605fd41351423fda0eaf7692f9e9f0083d6c4ac870c6e=
467d534f48","src/zlib-ng/arch/power/crc32_constants.h":"d73e3b9025de9fade7f=
a3ba2bbf5f56a1499a84c53d8ca7f5e744a0714d8599b","src/zlib-ng/arch/power/crc3=
2_power8.c":"add20ee86ff5c28396ee2e7f77d825d7e425b89467331953690c40f40b5dba=
41","src/zlib-ng/arch/power/fallback_builtins.h":"78a8da60bad8ba01278e49548=
2108adabf9e96bdb214e869b61ab1f63f518c9b","src/zlib-ng/arch/power/power_feat=
ures.c":"4dc4c14dfa2d3333c73fad7b1f7a79d3fff68c1d1fd643012faf82bd4114553e",=
"src/zlib-ng/arch/power/power_features.h":"c9c47cfcfff347e79f83f56a0677565d=
40299e03ffbeb918c4ae69518d290ada","src/zlib-ng/arch/power/slide_hash_power8=
.c":"58d93cee1a2cf14f13a8e9e31ba5149fe2b1e069846f52ac1f11c42cfcbd49a4","src=
/zlib-ng/arch/power/slide_hash_vmx.c":"1b6297a9616456ba534bc1d93afcb99e36da=
c357be68aed106bb71dfea621a86","src/zlib-ng/arch/power/slide_ppc_tpl.h":"c89=
00c594591e1aba3188f97c374e5561fe1e96f653c668352b25647e449f4c0","src/zlib-ng=
/arch/riscv/adler32_rvv.c":"e2472cf46b376a0ed8b7545a3192d195659353e09377221=
6f0d28ae7d75afb1a","src/zlib-ng/arch/riscv/chunkset_rvv.c":"d5b0fd27dcc8d4b=
3773caae16290014fdbc0011cf62e7f63a4e5d897149b165e","src/zlib-ng/arch/riscv/=
compare256_rvv.c":"4ed8d6b39ef2218c1d474ab586fc19d7e0821445241e5ccd6a75992c=
b17b3bb7","src/zlib-ng/arch/riscv/riscv_features.c":"a117eada0164dd92c06e98=
04a70fd2f434b8d14a6d443f0b3513330fe08c18a3","src/zlib-ng/arch/riscv/riscv_f=
eatures.h":"26953a09f72edb0e66978044d75e054e40d36d2b62244359b5e5e4ab936d2c9=
c","src/zlib-ng/arch/riscv/slide_hash_rvv.c":"87c1a2acf51af38f2d337b482fcb7=
2d080b0897e48abc9753b51d40facd9a1a1","src/zlib-ng/arch/x86/adler32_avx2.c":=
"cc0598333eff9110b5e8c0dc38ba543bfdd3ca5a66825f440909ba7a8923fdd3","src/zli=
b-ng/arch/x86/adler32_avx2_p.h":"45e6264edffc737081f55a5b5e85b28d9db0b27b63=
183ffbb492f8c11bc670a2","src/zlib-ng/arch/x86/adler32_avx512.c":"7a949d8ad2=
d15709d33872ee97e70a2e0cc2c6c375d7064cbc02b87e70905d1e","src/zlib-ng/arch/x=
86/adler32_avx512_p.h":"1b4beda11693ac03e4b20e054a765df427f845a279bce547b82=
08d20f5a302bb","src/zlib-ng/arch/x86/adler32_avx512_vnni.c":"9d11d2049df211=
f11a48a91e340e20686763c1eac20463dcd27dd7bfaa159f76","src/zlib-ng/arch/x86/a=
dler32_sse42.c":"1d2dc53b05ac75667c6d1c625c8c391e4851b28cff9e97ebfdb7747675=
81fff2","src/zlib-ng/arch/x86/adler32_ssse3.c":"7666f99b2e530265cb9848c1047=
ccc150da0add19b41aa2d7756c617377622c6","src/zlib-ng/arch/x86/adler32_ssse3_=
p.h":"5aab2f802ba6bdebc63b411018e5116fe26d38e90adf353646b65af4ebe7fa40","sr=
c/zlib-ng/arch/x86/chunkset_avx2.c":"ac300f37fbc99ab2d3bf47a640bdf2d87ad835=
8ef081eea21c541966830281b3","src/zlib-ng/arch/x86/chunkset_sse2.c":"a400a12=
8a84185c945f9ac9303e17c944f2008085d7a4402d279bd59893dc89a","src/zlib-ng/arc=
h/x86/chunkset_ssse3.c":"1f69ef9ae20cca1e4fc6924462255b8969685387c10694ef1d=
da28b3098d6f6d","src/zlib-ng/arch/x86/compare256_avx2.c":"2516d00faa6939e61=
dbb0978a9c4c81f9e3a42fd053b2a2241673da7cf4fc781","src/zlib-ng/arch/x86/comp=
are256_sse2.c":"3b983708034f33b5da49f6f5041351a2e66358c76645c552f6e4dc37fb8=
90a80","src/zlib-ng/arch/x86/crc32_fold_pclmulqdq_tpl.h":"1b3b79dabff0bf7ec=
c3b07356c5aeb6ae1fece0fd70ac7e235aacce3da77ea19","src/zlib-ng/arch/x86/crc3=
2_fold_vpclmulqdq_tpl.h":"7eddba31e3d1b1808fc6df9f96ada03c59952961af895d853=
8f5a8292392b5cc","src/zlib-ng/arch/x86/crc32_pclmulqdq.c":"f247408c353bbd0f=
cafff23fb97aeb4d9a72e0a416effea566183b9b5dbedf7c","src/zlib-ng/arch/x86/crc=
32_pclmulqdq_tpl.h":"5fedffe4b853cabfef09cfcebb501cd53a97c212e470bdfc65c28d=
c998840e05","src/zlib-ng/arch/x86/crc32_vpclmulqdq.c":"870d06ca9fa7b48db4b7=
20d2fd6262094200cf6180fa76a601d17c722bf0e406","src/zlib-ng/arch/x86/insert_=
string_sse42.c":"28a6d418a9563d464414c3880d6053c656aab40c6ebe21947cf17687d8=
2e547a","src/zlib-ng/arch/x86/slide_hash_avx2.c":"9740a36bb4dd90f4039434402=
6be9a13f3acb6e85e6b7681c30fd7f7cbf8e28e","src/zlib-ng/arch/x86/slide_hash_s=
se2.c":"fa009305a1c82708638dff25e037067656350303b25f5774489417e096c30ecb","=
src/zlib-ng/arch/x86/x86_features.c":"b755befa09a56ed27d70f2be93b0a72a355fe=
8b490827b55fce60ab51693c70d","src/zlib-ng/arch/x86/x86_features.h":"6429fa7=
345a9892633c884f7fc26f9558d86c77df9e8589ba9623a27e1d9fd57","src/zlib-ng/arc=
h/x86/x86_intrins.h":"707b836360628cb34a0fb7fa675b5e8674d146f55b1f60fd739b8=
5aa5dc935cf","src/zlib-ng/chunkset.c":"531f58c77c184b225304888ddf1930a76bee=
fbe4a7974edf0efeee7b6662520e","src/zlib-ng/chunkset_tpl.h":"9919e10e9c22443=
16e13de41b66dc333d9b0413af6265fa860768eefa39ce033","src/zlib-ng/cmake/detec=
t-arch.c":"1af38707fadc192c8e4a28715c896148a0909be821fb443919e191ff2374ffdb=
","src/zlib-ng/cmake/detect-arch.cmake":"85a2eed469fc7765e51c382f475868a644=
036f057f5b749d3ef59eec2b4b2748","src/zlib-ng/cmake/detect-coverage.cmake":"=
4664d51152d51282ae50621f4d510ab72cf8978b266c614b7c5361750db6d1a9","src/zlib=
-ng/cmake/detect-install-dirs.cmake":"4c8e72cee23ce9c6db02566a31fc7a78f0bee=
ac6f09c61c2d90a1cff3c083db1","src/zlib-ng/cmake/detect-intrinsics.cmake":"c=
fad619b863adf57132434f7b9c36c4f1a0466e5fdb11ac673e703ed5e471cd0","src/zlib-=
ng/cmake/detect-sanitizer.cmake":"a40650743dfd0b56c2afbfadb53e5d1470ef48852=
f2fcdf51084b6485534f87a","src/zlib-ng/cmake/fallback-macros.cmake":"a8c8f70=
e5483177280cbebf99f929a7cf5ffe2b79fedb79eed570ecafc78effc","src/zlib-ng/cma=
ke/toolchain-aarch64.cmake":"46be0bf580a49a528c72005484655afad1de3705b39a66=
a7b0c213b0fa81cee6","src/zlib-ng/cmake/toolchain-arm.cmake":"05e38076fd6ffb=
9785ff9844ccecd26436c9dc4c25b7777b62e5f52e788c3882","src/zlib-ng/cmake/tool=
chain-armhf.cmake":"1a2029163a57415eec9a5dd5f45d3254d349e97b1beb5d16876b741=
717673341","src/zlib-ng/cmake/toolchain-llvm-mingw-aarch64.cmake":"4deffb54=
1ecd21ade019daa2e96e832ead8c2c62b633bedb8688d0e7c7012d33","src/zlib-ng/cmak=
e/toolchain-llvm-mingw-armv7.cmake":"3e95adbade93ec162478de3339427ed88b12c9=
22f4975c2918977859325f5459","src/zlib-ng/cmake/toolchain-llvm-mingw-i686.cm=
ake":"1064a1ff2bab21489c184c1cc2b07181ebbbcc32e45c13cf8ed6b9ec60560c2e","sr=
c/zlib-ng/cmake/toolchain-llvm-mingw-x86_64.cmake":"577d333ad70cf27ededc755=
54428368e84c334cc7b716e18113620f5e7edf305","src/zlib-ng/cmake/toolchain-min=
gw-i686.cmake":"df9000354b820d3713d1469edc9f94cd095389b0cca83965730b8e64857=
fdf3f","src/zlib-ng/cmake/toolchain-mingw-x86_64.cmake":"ee316e6e3202919da5=
d497f9e246466fd715fcf079cb5b4afc4774089d1fefad","src/zlib-ng/cmake/toolchai=
n-mips.cmake":"0d0d00b809a30021bb4b9e3ace7371200bb4bfa6509813c829ca0cb569c7=
af68","src/zlib-ng/cmake/toolchain-mips64.cmake":"f19574aa068ca4374b657ce7b=
d0517b9297c622144814a095e26db05f0a1cd20","src/zlib-ng/cmake/toolchain-power=
pc.cmake":"9bd6fc58ce5b70603657f2c195c4a5cf52fae96ad63ac787978831c5858f762c=
","src/zlib-ng/cmake/toolchain-powerpc64-clang.cmake":"aab0b9e0f19a281dc99f=
4dfa5675976c40b5fb7f8139dd2eb0901fdf3cedc952","src/zlib-ng/cmake/toolchain-=
powerpc64-power9.cmake":"57c789c468e733971c2654faf34f7dfc9dd1e0e5bcabbd609d=
cd01dcbd25c487","src/zlib-ng/cmake/toolchain-powerpc64.cmake":"917fc5eef849=
21d8b38f43c2b4f60870965b4eecc8f018c7b3499e1142c715af","src/zlib-ng/cmake/to=
olchain-powerpc64le-clang.cmake":"47ac4a05b61210a83c7845a5522b91740bc8a7bb8=
97312cc37131f85bae9e1b5","src/zlib-ng/cmake/toolchain-powerpc64le-power9.cm=
ake":"b295b61ea248d8ef98d9276fad3db143a6fb80ab738c54bf88cb594d82c70a8d","sr=
c/zlib-ng/cmake/toolchain-powerpc64le.cmake":"5b2edd36d62de513db2d32bfbf779=
979d81ac527b981cc3379a4e933fc5a94d1","src/zlib-ng/cmake/toolchain-riscv.cma=
ke":"d7b4ac4be3651aec2e55788d815141482d4fe92713713fdaba9215dbbbc9b88a","src=
/zlib-ng/cmake/toolchain-s390x.cmake":"cf52cecea7bd2a9d1ff5fd8edcb03c531e3b=
404bbcd15a15dec2e0e19936f2ac","src/zlib-ng/cmake/toolchain-sparc64.cmake":"=
e543062485d06a7e0fec8135887c5e73363517fa4babc23ef7b780916d75afda","src/zlib=
-ng/compare256.c":"4890f97239f63dfbbc986ddd05039798752ec0ad530ff7d25978deb4=
4f774ad5","src/zlib-ng/compare256_rle.h":"30fca191b0474e1549d3ce292bb11ee90=
dc3dc9fc685932cec3971c1d0e8f652","src/zlib-ng/compress.c":"f7c69a4d2f3b87ff=
0094115977dde1cd17703cc9856ba19489dd94e0ed16b646","src/zlib-ng/cpu_features=
.c":"aec359d85d64c2ff88132a123406726bd966e0d56d0dc8ce1d5c3f25e1801440","src=
/zlib-ng/cpu_features.h":"21c43d2a8375e73abea63082e08d9279eaf457970d34f8778=
30bb31575498a8d","src/zlib-ng/crc32_braid.c":"8a33cffb026b82a027b45e0419358=
36b36b2d075796e5498e33ce64ec0cf93e8","src/zlib-ng/crc32_braid_comb.c":"2177=
41d3c1c0018bb12ab22c987804634605f5b7ad6bd243e25eb0499c80af5d","src/zlib-ng/=
crc32_braid_comb_p.h":"6c8035e05d30a6241be55467fc59e4d7deda6b618b955a11339f=
fee08a39c75a","src/zlib-ng/crc32_braid_p.h":"951cbd948664498dd8a56393bc88de=
bdad8b21dcc8e1f16d883c07170e4adb4e","src/zlib-ng/crc32_braid_tbl.h":"e22af1=
12e3c1c8bb4065d39fe678eba71dd08893eb06f9414b02f4cf5a6f46de","src/zlib-ng/cr=
c32_fold.c":"f6363abbd1e167bc7a6fa8f92e5211f4fa3e70d30fa5e10fa6f416f5db3726=
78","src/zlib-ng/crc32_fold.h":"42412c5029057579148a2238b0bc882f294f661d2af=
102bd9213531894302f29","src/zlib-ng/deflate.c":"70c72cdbf88987660e787a99658=
641bce36fff4848f9bf395f3727df9543664b","src/zlib-ng/deflate.h":"f45a6097101=
50fb758ca89b36a7f5a029b525fe70f0e3296a4847d73872db2ca","src/zlib-ng/deflate=
_fast.c":"52648097b16070c156c27d38566720eca08d48e35cd89a80f196f0e77951112a"=
,"src/zlib-ng/deflate_huff.c":"923d316676c00f307a7d6a58d77f9364f06607afcc68=
6b464b557ff5478f8b6d","src/zlib-ng/deflate_medium.c":"d3172c1ea0ae1bc2e3b76=
91b005bbae35e84b7588ef2f5805b9dd0c4ccecbd67","src/zlib-ng/deflate_p.h":"2ea=
ac98e9232959c730d84a408bed641be817dc3468aeb427062d06b02eb80b4","src/zlib-ng=
/deflate_quick.c":"3825eb4d22a150f9cdaba93db890d95b8d9e9d0f3f10524fb27a9a12=
89aa4c0f","src/zlib-ng/deflate_rle.c":"5dcc0496f74b5ce677ab5a58ea232d0ba653=
102d2f71cf35daa6069ef88b7af6","src/zlib-ng/deflate_slow.c":"5449816c381138e=
b07cd54ec7c0c77fb811f4f274c27bf15d26e008de6a9eb5c","src/zlib-ng/deflate_sto=
red.c":"89b81c09be2ffd84138940ac6c4e9688f956603b45eec6d0d52d579cac3f15e5","=
src/zlib-ng/fallback_builtins.h":"c02e559d19f351f2f9371ee2042ca6a725d14f178=
62dff2414fd2ab3d7984875","src/zlib-ng/functable.c":"d7ac98c7def281c707796a4=
317e2dd6754d654bc8d833ae67a77f47a7c1dd5bd","src/zlib-ng/functable.h":"64fba=
baa8459898d14cb88078676c42fce12a951b4b1d83f9085e104ad407a47","src/zlib-ng/g=
zguts.h":"d9a4e984bb6c2ebe5c858b37b1c6411af1edc21c3c15d63b6588016b71369b71"=
,"src/zlib-ng/gzlib.c":"91011bdfaa99bb5e49aece64fdee995207b1ce5a96227990f16=
f9aea55026c8e","src/zlib-ng/gzread.c.in":"3501e5124923207b2603d9695c3bad181=
5ca2dc8f18b6525bdd5dfea60313acd","src/zlib-ng/gzwrite.c":"9f474aeefaf0150d8=
871eb9202ebd43a28f18bdf39eaca4f35cfb52227e74c63","src/zlib-ng/infback.c":"d=
b99c5b105c34c7c2967bd97e16f976217530c22d6545e61cbf657522e24de87","src/zlib-=
ng/inffast_tpl.h":"51622f34e8808798a43412b4fde62ebd58ba012f5452bf2ad9a8001c=
98539166","src/zlib-ng/inffixed_tbl.h":"a94225335396245e9f0ccb2e9b4b334fe7e=
e0111ed8e32a26bcd52187f364314","src/zlib-ng/inflate.c":"2c1bd0f4939c372e49a=
9ee0ec8a8cdee369d9c6c10124b4e11cd197f44ce3a36","src/zlib-ng/inflate.h":"175=
0ab33be4461f2e6b8e43bef5da11f3db49d5d2a3eacd03d881d33c1df7def","src/zlib-ng=
/inflate_p.h":"4a31088faf818d2615de31b099e8f55ee8463166477d6cb5d6763c913b6a=
cef9","src/zlib-ng/inftrees.c":"206fa4c762203823151dcd3b1a5b389fb40efd4c88a=
eb2bc302aa1d5cfd6d6d5","src/zlib-ng/inftrees.h":"2ba1beb76d7922fcb37708809e=
31f62ee366827da80faf09a7e461b439afd291","src/zlib-ng/insert_string.c":"7a94=
55cbb3ca8fe6e7111471b9f4c0a32fb49a6d0ec589b027dc2cb2b65c8dce","src/zlib-ng/=
insert_string_roll.c":"4d05f19591a5c29d2da398e10e9d0b050d738cc8838d8dda4beb=
1cc7281ede07","src/zlib-ng/insert_string_tpl.h":"972e69808ce5e74d0c54af4ee4=
47b996b2d0563eb861b90856693037ce8cca9f","src/zlib-ng/match_tpl.h":"1e20d0ef=
73a5826606240f4efd2a8e993d203f376017397342b9899b1f919276","src/zlib-ng/slid=
e_hash.c":"74adb34a4a35331db810dbb5d740af10cc1db7d24a89ea387aa2dec956a05b2b=
","src/zlib-ng/trees.c":"310fe64c50fb313773c2058c606b1a3cc085b8af7771eba325=
ad5c9355659100","src/zlib-ng/trees.h":"24174f3543b01ee1ef370bbf6d15551a2187=
1cded18b2aadf09a71e7904b6f99","src/zlib-ng/trees_emit.h":"6c541dcf01eecf393=
d4eab7800bc558ad524114bb5a8deb86f13376fbef88754","src/zlib-ng/trees_tbl.h":=
"022736ff3362ef3591d1f8fc3b7fede5927c0d25ab0813d7ef8cd95efd6ea242","src/zli=
b-ng/uncompr.c":"bb03a6ae65e1395f3cb2fba1dee63246a1fcd30683fd3348e320e78952=
1055a6","src/zlib-ng/zbuild.h":"e6f34c26bd82dd7650a664d7b336d1e4c83b871bded=
79e05602e779ffa69993b","src/zlib-ng/zconf-ng.h.in":"83514b2e2858b0d6647159e=
9aa47fa84bb625ed2ac6117284f514cacc42a993d","src/zlib-ng/zconf.h.in":"6768f8=
4c439683b4a590338a9be40c3bd7a9702b25e8e546c705fac08674c3bc","src/zlib-ng/ze=
ndian.h":"5be3e2989524198f13b68cc083b1502747effe92325edee59e3c4ad93cc3c62f"=
,"src/zlib-ng/zlib-ng.h.in":"3bafbff2b78a88c1f0de4195a17b8fcd1fb12fcf2d40ff=
e1970415f6778bf9df","src/zlib-ng/zlib.h.in":"9f74dd9f3244ac1152639c5ad5dd19=
95914b7362adb1f3890698da377cf26c3f","src/zlib-ng/zlib.pc.cmakein":"a97486fc=
ab3f191d807ec04d4487d6a428053ab452b59687ee1f71cf52b02a31","src/zlib-ng/zlib=
.pc.in":"848e017a079b14853df8d19699f4edac2304767ef4eb2cf525a06ceb60d301b3",=
"src/zlib-ng/zlib_name_mangling-ng.h.in":"a829fd869339579afe7ce8c1f8a547359=
8c608f3427c3cbbc1800088d6640e7a","src/zlib-ng/zlib_name_mangling.h.empty":"=
38e51a846d6c2bd6100298c55328dba4437c08fa1dceda4eb2e06ecb1d142058","src/zlib=
-ng/zlib_name_mangling.h.in":"16e9ede4821d873647bf105b12e71245d3b7cb79ed318=
fed0a8ab5aa63b2b4da","src/zlib-ng/zutil.c":"fce8e83d2040be8bc389ec61a8d6c7b=
32c0b3cd208599c01c5a58ef6418de87b","src/zlib-ng/zutil.h":"618641510d89936fc=
bca382dc60aea97b5fe35aa010386df0a8ec3ed1b1602ea","src/zlib-ng/zutil_p.h":"6=
ca034b9d3f6a702b03a71a1f3fd61a0fe6bfb3442156cbdca090adea8eb3f2d","src/zlib/=
LICENSE":"845efc77857d485d91fb3e0b884aaa929368c717ae8186b66fe1ed2495753243"=
,"src/zlib/adler32.c":"9cd1443a24ff2a3053961695bd432035c58347386a420d338823=
2376ebabe211","src/zlib/compress.c":"86f802c16a965e7a28737e3730b4e576c5ba40=
981753967e3e30916f4dc1b4b1","src/zlib/contrib/dotzlib/LICENSE_1_0.txt":"362=
66a8fd073568394cb81cdb2b124f7fdae2c64c1a7ed09db34b4d22efa2951","src/zlib/cr=
c32.c":"8fd16f0a7714d51c89c2eb37eb98ec15e8a4dc57ba343e7b7398b19144039fda","=
src/zlib/crc32.h":"9a2223575183ac2ee8a247f20bf3ac066e8bd0140369556bdbdffc77=
7435749e","src/zlib/deflate.c":"3b956337350f94c34987750f785587ef33d9c89ceae=
bb7c2afb189c956360cbe","src/zlib/deflate.h":"48baf016326d8d5e3e32ac8153cc7e=
22f854b8e6834830b167b998a7fb1e7989","src/zlib/gzclose.c":"35ea6e991a63095f7=
97d8c4cc25817fac7a7155c2ba7dcdbbf648f7871c7ea40","src/zlib/gzguts.h":"231ce=
0588532fd17249c4d40fde1b923c3fe4e6b372b4817c931256df1dbcdf7","src/zlib/gzli=
b.c":"042c2be8ec67ad525a2812e508de7381c6766dde903acf5ae6ac4fa6b541946d","sr=
c/zlib/gzread.c":"72e481aca07b0b85a9783237b85dc67ff3a4c1d19878d0cec69f58d38=
634867b","src/zlib/gzwrite.c":"469b1e58932ea11bdda2a153f6655f7b3c13254240fa=
e157181b49ed1bc93b47","src/zlib/infback.c":"62df9a6dd3eef126f1d81d0ad7a5345=
04610dec44482b0a472b61c93cbab6554","src/zlib/inffast.c":"e6ef64ce5dc0a4cd5c=
7ad08ceeb2b2a698b8447f6bd156057caeb2edab68c0cb","src/zlib/inffast.h":"05cc5=
dc9ff1da7b8b52a4bd8bda0d8a5c236a2f39efe84b941516ea13857e6c5","src/zlib/inff=
ixed.h":"237ba710f090e432b62ebf963bee8b302867e9691406b2d3f8ee89ee7bfef9b0",=
"src/zlib/inflate.c":"34c998ce0037c0537c04b03b276f680b945f9b2c9d1e01b287605=
bd6879f7fd2","src/zlib/inflate.h":"e8d4a51b07694bf48cb91979c19974cf6a5ab0b8=
a09d26ec0d14df349230673e","src/zlib/inftrees.c":"5d4f335221d2dc76f17abd2577=
d92c2d7baf68fa6d7f23373b360830493d1563","src/zlib/inftrees.h":"0a0fcaf2ae2f=
ae57426bdc06637270e9bba974f35202cadbdba479d946e6409d","src/zlib/trees.c":"f=
63c68c16c05fcd196050529d1a0e7657960e4136b9987d90a6ac3e58a964b0f","src/zlib/=
trees.h":"bb0a9d3ca88ee00c81adb7c636e73b97085f6ef1b52d6d58edbe2b6dc3adeb4d"=
,"src/zlib/uncompr.c":"04dca5e31b3b8a17d1806426f66f0c539f4184d657e149d40be0=
7070c6227b52","src/zlib/zconf.h":"f5134250a67d57459234b63858f0d9d3ef8dcc48e=
9e1028d3f4fdcf6eae677ae","src/zlib/zlib.h":"8a5579af72ea4f427ff00a4150f0ccb=
3fc5c1e4379f726e101133b1ab9fc600c","src/zlib/zlib.pc.in":"04c01cc2e1a0ed123=
518b5855f585c93a24526dd88982c414111ea1fc9f07997","src/zlib/zutil.c":"8ced40=
d8c88588811edd2bdb35b7439983d5e1f8e9e32b8a3b244731f3c317b7","src/zlib/zutil=
.h":"dddb2dc7a1dc339ecf2c8e089b366f08bb731c0839c7110240d17ce731bb4fea","zng=
/cc.rs":"3b17502d700e8853261b37f720be2176dfac726df1ee7300ef79b757c6f443a7",=
"zng/cmake.rs":"059da8bf3ed5f2bfa613874b8f6720643ae948a811fefaff8237e95e077=
1cbc3"},"package":"c15da26e5af7e25c90b37a2d75cdbf940cf4a55316de9d84c679c9b8=
bfabf82e"}
diff --git a/recipes-devtools/rust/libstd-rs_1.82.0.bb b/recipes-devtools/r=
ust/libstd-rs_1.83.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.82.0.bb
rename to recipes-devtools/rust/libstd-rs_1.83.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.82.0.bb b/recipes-=
devtools/rust/rust-cross-canadian_1.83.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.82.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.83.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.82.0.bb b/recipes-devtools/r=
ust/rust-llvm_1.83.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.82.0.bb
rename to recipes-devtools/rust/rust-llvm_1.83.0.bb
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rus=
t/rust-snapshot.inc
index fdbe41a..a06b6fc 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,56 +4,56 @@
 ## The exact (previous) version that has been used is specified in the sou=
rce tarball.
 ## The version is replicated here.
=20
-SNAPSHOT_VERSION =3D "1.81.0"
+SNAPSHOT_VERSION =3D "1.82.0"
=20
-SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "76f8927e4923c26c51b60ef99a2=
9f3609843b3a2730f0bdf2ea6958626f11b11"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "30a00260510403199d1cb91976=
9b0a2e76eead15c352fc992bc193d795a2b2ff"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "85567f037cee338f8ec8f9b6=
287a7f200d221658a996cba254abc91606ece6f4"
-SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "301f651f38f8c52ebaad0ac7eb2=
11a5ea25c3b690686d1c265febeee62d2c6fc"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "05c0d904a82cddb8a00b0bbdd27=
6ad7e24dea62a7b6c380413ab1e5a4ed70a56"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "1e01808028b67a49f57925ea72=
b8a2155fbec346cd694d951577c63312ba9217"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "1359ac1f3a123ae5da0ee9e4=
7b98bb9e799578eefd9f347ff9bafd57a1d74a7f"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "2958e667202819f6ba1ea88a2a3=
6d7b6a49aad7e460b79ebbb5cf9221b96f599"
=20
-SRC_URI[cargo-snapshot-i686.sha256sum] =3D "44f74fbf64dd2627310e796cfcbde7=
5c42c3435e93e880f1291c0e975b42c1f5"
-SRC_URI[clippy-snapshot-i686.sha256sum] =3D "3d5cdbe24fd0cefe46bfa513dbf56=
631bef38d04bae1cfbebaa407c33430fecb"
-SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "4ed9085460e444de9dee2460801=
26f5e73062802b99aaff620d2aa827f60d972"
-SRC_URI[rustc-snapshot-i686.sha256sum] =3D "8039f645445f99c0e293397b53a669=
6481b7d58166198605aca0eaa998f4f11f"
+SRC_URI[cargo-snapshot-i686.sha256sum] =3D "1cf5bae93e9724f50f1a20a752f058=
70565e0ce83baa157aad632aa162fd97d5"
+SRC_URI[clippy-snapshot-i686.sha256sum] =3D "a4c20f20c8e53747e00948f90d743=
80ae890c1836a067d504eca540c6a60157f"
+SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "c7ebb02b6ca349999b3b7dce768=
efaca5e0d9060f55397523e11a64cd10a9405"
+SRC_URI[rustc-snapshot-i686.sha256sum] =3D "92bab38ce88b7738fb62a1bccf496b=
1b2975fe984cc4fc506903a03ed37e1e4a"
=20
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "d3a66e30a323fc20acd3b85=
f9a184b962a84ac9debf59c313d30c0146448cbb1"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "81044ebd81783b013cdc20=
7a7304dc59baa7c1782a6f070ecfa1a6671844e26c"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "37f89523e04b960ba34c=
0cd145c4a78751961b6007ad4ae6d8b92389c488d696"
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "90eb5646497f1cf566121b7=
26b0598f76acf38ce9423b0889b4ad71dffb59aa1"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "01709e6d5b16e972e6c5e82=
6a36331c645766ecda8f0aa48559f20c0d1129f44"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "ddbd18682a7fa0794d3bf1=
59ba5cc5aee8c7bd6860d2edd8c9f4591753b5f05c"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "8cc1399b0460b3bc4b72=
95165dcdcee310fd643dc29569e1786944650f2a3700"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "2bdbf08c8c7d3a4dc8bdddd=
bc4cf2cdec5a3d0f4a42e19183a14bed24d8d580c"
=20
-SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "3ffb73eaf288ebe02c06737c533=
98cbcf7f9e15bd53d6ec3f85be1364aff16ea"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "c6583a26dc5fda266c75b7bf2e=
5f6c1c9d5452f2dc3044bf99f43e59e14fead9"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "3b3473de46f7ea268130d8c7=
2140dacab9118b2e8611fc0e23ed99091f25eb45"
-SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "8da65f141f7b8c53d5802fc6171=
1cccf28b0512a5f766809cbe882c6f8ec3011"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "7c11f69eb52c6e26cd8a33daeae=
7d630b6af49de30c1af16f4e998ca25a48bfd"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "a33f459a5cc13573e4ed73bd56=
67bba4bdf658e30b629f36a221eb5249d4acc6"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "827989a42526206199025f76=
4d08d7cd319fee58bf2e08dcaf75df9ead6f094e"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "0d93e17a06cd284bdc0a97df647=
33f4b2f9f8c3cd9163935d85812ebc8520d2f"
=20
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "687c665259646f859e6ef9b3b=
8baf49c2759e19a20aa029251130495fe5bb07d"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "ad77d9511489a7a95580d8c4=
062e7eddc509d5bdec590a074c7378f2e7f36b00"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "94d828f3cbd848f15ec72e904=
bccd904a7fac0cd88d6afecfc472e48da032cb2"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "c849be4677f42dc9439ac245=
8ca3964b69a2d6621e57f979151e7b59de22d895"
 SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "665f3c0a8752f8e5d973cf=
9b94e5c1be94954178ca8378a318b6e21e7a7b370c"
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "c4e0968c6a16916a339a2dea9=
063d14f3847cee65534b525d2838b827e7dad18"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "8795c642f94d15c81420a8eff=
77efbbac553869a00c627a1e3f881c542388b4a"
=20
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "813d2dcd603a1ad65a5de77=
515f4c94fdae301a1e1e8afcc2541076eebaba848"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "e35815af6cb90d70fd4730=
020ae48d4145487ff9b8c264caef5224c843d85744"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "5ba237cfbd18806bf77f=
be8bc31b14a17f3d14acb30a022955cf047eb8d41056"
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "734f407345b05617d62a30d=
96d8305b51b7cf7de3b1bdc160449726ea8f51ae0"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "ce5918e9c1a41b9e9a1b3e1=
5f6525ddc01df06d9cea63d574dc59e8a401c1b67"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "a633c961cc9225c5ec1af6=
f153e33fd103057c9ebc66eb80f388687f34215fbf"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "4954a44305622b8f68ca=
088138b9a69432e350336da1a415a282ce148beb340d"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "0b22b37e51dd1dab6cc80a0=
2968873ecb5f886fe1a65cd47131e3d10be48a23b"
=20
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "4f41aeca96e6de516ad2150a9=
8136948527907690301fef4f127676f165e159e"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "65a65485972507cb5e89e640=
56b4602489bae76cff4a9c152e69d91365ff7433"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "9882cda0a5547405e64357=
a4964d525f46d1395f85b7e7b6e69cbd4dbcd46ec3"
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "05d16740639cc87d258fad152=
d2a0f7e74dc571b5216ae6260d645a2f4f09c84"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "4779732566542099491c35a9f=
4342361bb8366e76c7d37ade0b5b7ae6f470df3"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "1399034c20e3037288cd6593=
59e0a9eeb1d8a125488bbea28bbe146792a18d1a"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "5649f9b4e107d6c5f72fb7=
f82cfe15370b80b8d983670602e02e0b615bc6dc88"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "225726a3fedeb6cf136d5af50=
3fb6853a0ce3c735fd972d40d678d734e65f5e8"
=20
-SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "11291e98730186479854a304fccf5=
86824e16f90b4e4cee6c9e17deaab04352a"
-SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "38b9003148a5222a0fb117cae494=
bf2a05227e6eff877e26b233433809f81e01"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "5549622876714df21235aa6d26=
731f31c37a7e1629a3f6c5262dbb0b1f10038c"
-SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "6ea458b49aa9edc26f021cc48e622=
3d1cc05b1bf092312ada978e66037fa63e2"
+SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "55d95ce07117430b92d1153e5b1ff=
40222687bd344872260e0a19ecf7b4c28a2"
+SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "9c8c4b9d3a39383aa043a9a53447=
8bd2ab6adf7a2a48c1d4d29864974f23005f"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "454b83668b57bdef28fc49aca8=
fd4c38e395b49011e653afdf3f9bb2dae8aa63"
+SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "bd46920849468c4ab78c53b21c962=
e538b1e8a9f38c736a9e52d790c75d55c45"
=20
-SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "c50ee4b1ae8695461930e36d5465=
dddb7c7a0e0f0aa6cbd60de120b17c38b841"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "c545ea0f2901eb1cd6527213501=
47df11744afbb97eb117d89b1f313e9920ffb"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "6ddf80f254e8eea9956308ba8=
9fd68e1ac7885853df9239b07bbc9f047b7562f"
-SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "988a4e4cdecebe4f4a0c52ec4ade=
5a5bfc58d6958969f5b1e8aac033bda2613e"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "97aeae783874a932c4500f4d3647=
3297945edf6294d63871784217d608718e70"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "ea4fbf6fbd3686d4f6e2a77953e=
2d42a86ea31e49a5f79ec038762c413b15577"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "2eca3d36f7928f877c334909f=
35fe202fbcecce109ccf3b439284c2cb7849594"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "90b61494f5ccfd4d1ca9a5ce4a0a=
f49a253ca435c701d9c44e3e44b5faf70cb8"
=20
-SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "91ebf62a1f95047b93d4a4fec28=
0fb4897cc7921633fd55f5c5a3aeb2b140bd6"
+SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "f56585c55664898c7484f4b7bd1=
39770c99d7b4da6e56e4016f71cb053b1aee2"
=20
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "194a3c04a2390b1e07fdb114=
eb2c48e962219f0a1b710e2120a9806963a2520b"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "87db52d782131a8817b76f65=
eefcae2c24a49b2a6f19ed9bd4699167305c22aa"
=20
 SRC_URI +=3D " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-s=
napshot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index 9987aed..dea744f 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -1,15 +1,15 @@
 RUST_VERSION ?=3D "${@d.getVar('PV').split('-')[0]}"
=20
 SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.=
tar.xz;name=3Drust \
-            file://zlib-off64_t.patch;patchdir=3D${RUSTSRC} \
-            file://rv32-cargo-rustix-0.38.34-fix.patch;patchdir=3D${RUSTSR=
C} \
+            file://rv32-cargo-rustix-0.38.37-fix.patch;patchdir=3D${RUSTSR=
C} \
             file://rust-oe-selftest.patch;patchdir=3D${RUSTSRC} \
-            file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=3D=
${RUSTSRC} \
+	    file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=3D${RUSTS=
RC} \
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.pa=
tch;patchdir=3D${RUSTSRC} \
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-ru=
st.patch;patchdir=3D${RUSTSRC} \
 	    file://revert-link-std-statically-in-rustc_driver-feature.patch;patch=
dir=3D${RUSTSRC} \
+	    file://revert-Zdual-proc-macros-additional-check.patch;patchdir=3D${R=
USTSRC} \
 "
-SRC_URI[rust.sha256sum] =3D "1276a0bb8fa12288ba6fa96597d28b40e74c44257c051=
d3bc02c2b049bb38210"
+SRC_URI[rust.sha256sum] =3D "7b11d4242dab0921a7d54758ad3fe805153c979c14462=
5fecde11735760f97df"
=20
 RUSTSRC =3D "${WORKDIR}/rustc-${RUST_VERSION}-src"
=20
diff --git a/recipes-devtools/rust/rust_1.82.0.bb b/recipes-devtools/rust/r=
ust_1.83.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.82.0.bb
rename to recipes-devtools/rust/rust_1.83.0.bb
--=20
2.49.0


