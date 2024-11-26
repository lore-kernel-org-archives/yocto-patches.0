Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEBDD6554A
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 18:12:24 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web11.53409.1732644738913973793
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 Nov 2024 10:12:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HZOxoXPB;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d846307673so21372786d6.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 10:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732644738; x=1733249538; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DqR7EZhF4VUFtlTUc2wWcjS9PTMr4GNqRcBD1fT4LE=;
        b=HZOxoXPB/VKn9f+euKgKFL29XltnYZmpJV0FtbxtZlYesoCRlrBbFNLcbNgNPbsCdk
         kqnsyySo9D3Iv77Z/fca7qZZSpsU6WQVpqMMmJ6utqHpXiE2WPR9dltRmqeAyhDtYU7I
         p5IaqxJmZ2jA6I/uA6Cz6sZ88DzxWhueBS3p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644738; x=1733249538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DqR7EZhF4VUFtlTUc2wWcjS9PTMr4GNqRcBD1fT4LE=;
        b=L9oVjk8vdKBi2DnQJIt6fOVyAFokNyuX9kj5M972DjcFuEu03gdbveiBdlqr0FWfjJ
         4g+44xe8KtK8MSw7ya+7OKtviYjyf70n1iEU07NFJ4kpnarZ3K69MhltU1a3UvWtbJhI
         VK1rXIyoA1Y/Koqb+LlWjfR6naOjzU47O2A/0o/+LC24uZHEE88tk9hWMdxbTreyh9B1
         6eqnwHeQlv2RzfHmpWHsZR4ReEcwOyDn96RQ45Cqh2XNcMr9UuUje3APtPlgaCaCZX3s
         jYkVwH5pcPxaiRuEnSZHfMgclmWmYifdqeaHJAbNwxPTEHvpfRQoDxoXK2WutJjUjOSm
         v3Hg==
X-Gm-Message-State: AOJu0YzIacgjXP5JoFJaYbVv2ps/Jk7inZJQrvSSAmoeOwdo0DBjOLyV
	d711oiZkztW/Y3JOAlq3c9mFlnejyZ8Iz+AubQ3QGgCsn5KdlUSoAE7yoabBqZpnSf654WrcYxW
	D
X-Gm-Gg: ASbGncs1h5525rhqGbb+ugP0lOAbbQ7W/aQTC3FnCFIuImk4LKEepl1yEO/kHgWOxip
	SYGxxCysTnExV+GmcB4uYfe8IM/iCAtysDWWq2V0FPBh8qWEgZU3LeKCLA08PLNJ+Ea7Y5gNC1B
	cXOKaVmAd7AwbDf6it4oxcEDB/buWnPoNSSsv0H3ZUUZeIDyLoLrCqbc3N5W92OsM9YwQXrlJeA
	MhlsuY29uCprTekmRaU7uCMgSlBOv2nzugkFal34tj5Dc9q/lHVAM9XHpIG9037ZX4dLWNFKxVj
	QNAjjXO+uPh7r37rzKURWokTXw==
X-Google-Smtp-Source: AGHT+IGqAtYZ3TH6LRSOaH+73J1+we2u1yWrlKqpDmHyRKf35OnE4BXvR0JlPRbF368TUk56D2Q+iA==
X-Received: by 2002:a05:6214:19c8:b0:6d3:496e:82a0 with SMTP id 6a1803df08f44-6d864d0619bmr537926d6.1.1732644737161;
        Tue, 26 Nov 2024 10:12:17 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a83ea2sm58171276d6.22.2024.11.26.10.12.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:12:16 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 6/9] rust: Upgrade 1.79.0->1.80.0
Date: Tue, 26 Nov 2024 13:11:37 -0500
Message-ID: <20241126181152.407253-7-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126181152.407253-1-scott.murray@konsulko.com>
References: <20241126181152.407253-1-scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 18:12:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/839

From: Harish Sadineni <Harish.Sadineni@windriver.com>

Update the patch files with rust v1.80.0.

The patch repro-issue-fix-with-cc-crate-hashmap.patch addresses the rust
 reprouciblity issue by correcting the way hash values are generated for
 different build paths.

https://blog.rust-lang.org/2024/07/25/Rust-1.80.0.html

Signed-off-by: Sunil Dora <SunilKumar.Dora@windriver.com>
Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit d68449da0df795abe3233383a82d0b6b7908d736)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |   2 +-
 .../rust/{cargo_1.79.0.bb =3D> cargo_1.80.0.bb} |   0
 ...epro-issue-fix-with-cc-crate-hashmap.patch | 199 ++++--------------
 ...ibstd-rs_1.79.0.bb =3D> libstd-rs_1.80.0.bb} |   0
 ....79.0.bb =3D> rust-cross-canadian_1.80.0.bb} |   0
 ...ust-llvm_1.79.0.bb =3D> rust-llvm_1.80.0.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       |  78 +++----
 recipes-devtools/rust/rust-source.inc         |   2 +-
 .../rust/{rust_1.79.0.bb =3D> rust_1.80.0.bb}   |   0
 9 files changed, 86 insertions(+), 195 deletions(-)
 rename recipes-devtools/rust/{cargo_1.79.0.bb =3D> cargo_1.80.0.bb} (100%)
 rename recipes-devtools/rust/{libstd-rs_1.79.0.bb =3D> libstd-rs_1.80.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.79.0.bb =3D> rust-cros=
s-canadian_1.80.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.79.0.bb =3D> rust-llvm_1.80.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust_1.79.0.bb =3D> rust_1.80.0.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index c0bec43..f5bf5d5 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -13,7 +13,7 @@ LAYERSERIES_COMPAT_lts-rust-mixin =3D "kirkstone"
=20
 LAYERDEPENDS_lts-rust-mixin =3D "core"
=20
-RUSTVERSION ?=3D "1.79%"
+RUSTVERSION ?=3D "1.80%"
=20
 # This is not ideal, but it seems better to mask out the older oe-core
 # recipes completely since they will not work with this layer on top,
diff --git a/recipes-devtools/rust/cargo_1.79.0.bb b/recipes-devtools/rust/=
cargo_1.80.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.79.0.bb
rename to recipes-devtools/rust/cargo_1.80.0.bb
diff --git a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hash=
map.patch b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashm=
ap.patch
index 164f2eb..e3f57e7 100644
--- a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
+++ b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
@@ -1,166 +1,57 @@
-rust: reproducibility issue fix with v1.79
+rust: reproducibility issue fix with v1.80
=20
 A few crates are using the updated version of the 'cc' crate and this is c=
ausing the generated object file names containing a unique hashmap id.
-The hashmap addition to generated files is reverted here.
+By the following changes same hash values will be genarted even for diffre=
nt build paths.
=20
 Below are the links for detailed bug description & discusssion with upstre=
am rust.
-https://github.com/rust-lang/cc-rs/issues/1117
+https://github.com/rust-lang/cc-rs/pull/1277
=20
-Upstream-Status: Inappropriate [https://github.com/rust-lang/cc-rs/issues/=
1117]
+Upstream-Status: Submitted [https://github.com/rust-lang/cc-rs/pull/1277]
 Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
---- a/vendor/cc-1.0.79/src/lib.rs
-+++ b/vendor/cc-1.0.79/src/lib.rs
-@@ -56,12 +56,11 @@
- #![allow(deprecated)]
- #![deny(missing_docs)]
-=20
--use std::collections::{hash_map, HashMap};
-+use std::collections::HashMap;
- use std::env;
- use std::ffi::{OsStr, OsString};
- use std::fmt::{self, Display, Formatter};
- use std::fs;
--use std::hash::Hasher;
- use std::io::{self, BufRead, BufReader, Read, Write};
- use std::path::{Component, Path, PathBuf};
- use std::process::{Child, Command, Stdio};
-@@ -1037,24 +1036,7 @@
-=20
-         let mut objects =3D Vec::new();
-         for file in self.files.iter() {
--            let obj =3D if file.has_root() {
--                // If `file` is an absolute path, prefix the `basename`
--                // with the `dirname`'s hash to ensure name uniqueness.
--                let basename =3D file
--                    .file_name()
--                    .ok_or_else(|| Error::new(ErrorKind::InvalidArgument,=
 "file_name() failure"))?
--                    .to_string_lossy();
--                let dirname =3D file
--                    .parent()
--                    .ok_or_else(|| Error::new(ErrorKind::InvalidArgument,=
 "parent() failure"))?
--                    .to_string_lossy();
--                let mut hasher =3D hash_map::DefaultHasher::new();
--                hasher.write(dirname.to_string().as_bytes());
--                dst.join(format!("{:016x}-{}", hasher.finish(), basename))
--                    .with_extension("o")
--            } else {
--                dst.join(file).with_extension("o")
--            };
-+            let obj =3D dst.join(file).with_extension("o");
-             let obj =3D if !obj.starts_with(&dst) {
-                 dst.join(obj.file_name().ok_or_else(|| {
-                     Error::new(ErrorKind::IOError, "Getting object file d=
etails failed.")
---- a/vendor/cc-1.0.79/.cargo-checksum.json
-+++ b/vendor/cc-1.0.79/.cargo-checksum.json
-@@ -1 +1 @@
--{"files":{"Cargo.lock":"dddb9c49058d411a098e98dc1c06e3bc89f859a2080d96c11=
b11aec67394bb8c","Cargo.toml":"1953a8bc4b98e351fe75917c151b1e08a46531d562ae=
bba25a90add4aadecac2","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe1=
4d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7=
b2ba96f1c7917dd6be0713f88305dbda397","README.md":"58af5106352aafa62175a90f8=
a5f25fa114028bf909220dc0735d79745999ec1","src/bin/gcc-shim.rs":"36dc4e44742=
8e73c548cc7106ca1e8f282c098463b014e13a729a44445de4880","src/com.rs":"29d0de=
e08a656ab1a4cc3e5fe24542e0fab5c1373cbc9b05059f7572cf9b8313","src/lib.rs":"1=
7a4659710aa290c4ed9c23063c7b202c5bcf2a84de33aa1f01fc6fded69a1f8","src/regis=
try.rs":"98ae2b71781acc49297e5544fa0cf059f735636f8f1338edef8dbf7232443945",=
"src/setup_config.rs":"72deaf1927c0b713fd5c2b2d5b8f0ea3a303a00fda1579427895=
cac26a94122d","src/vs_instances.rs":"2d3f8278a803b0e7052f4eeb1979b29f963dd0=
143f4458e2cb5f33c4e5f0963b","src/winapi.rs":"e128e95b2d39ae7a02f54a7e25d33c=
488c14759b9f1a50a449e10545856950c3","src/windows_registry.rs":"1f973f804b4b=
451e48ff6d98ce660355772f164dfdf79a6ae514645c7c764005","tests/cc_env.rs":"e0=
2b3b0824ad039b47e4462c5ef6dbe6c824c28e7953af94a0f28f7b5158042e","tests/cfla=
gs.rs":"57f06eb5ce1557e5b4a032d0c4673e18fbe6f8d26c1deb153126e368b96b41b3","=
tests/cxxflags.rs":"c2c6c6d8a0d7146616fa1caed26876ee7bc9fcfffd525eb4743593c=
ade5f3371","tests/support/mod.rs":"a3c8d116973bb16066bf6ec4de5143183f97de7a=
ad085d85f8118a2eaac3e1e0","tests/test.rs":"61fb35ae6dd5cf506ada000bdd82c92e=
9f8eac9cc053b63e83d3f897436fbf8f"},"package":"50d30906286121d95be3d479533b4=
58f87493b30a4b5f79a607db8f5d11aa91f"}
-\ No newline at end of file
-+{"files":{"Cargo.lock":"dddb9c49058d411a098e98dc1c06e3bc89f859a2080d96c11=
b11aec67394bb8c","Cargo.toml":"1953a8bc4b98e351fe75917c151b1e08a46531d562ae=
bba25a90add4aadecac2","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe1=
4d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7=
b2ba96f1c7917dd6be0713f88305dbda397","README.md":"58af5106352aafa62175a90f8=
a5f25fa114028bf909220dc0735d79745999ec1","src/bin/gcc-shim.rs":"36dc4e44742=
8e73c548cc7106ca1e8f282c098463b014e13a729a44445de4880","src/com.rs":"29d0de=
e08a656ab1a4cc3e5fe24542e0fab5c1373cbc9b05059f7572cf9b8313","src/lib.rs":"d=
fb36b17362e9a5b266cb19a229d982e8c0bba784b1e99769f690692b0cd5c4e","src/regis=
try.rs":"98ae2b71781acc49297e5544fa0cf059f735636f8f1338edef8dbf7232443945",=
"src/setup_config.rs":"72deaf1927c0b713fd5c2b2d5b8f0ea3a303a00fda1579427895=
cac26a94122d","src/vs_instances.rs":"2d3f8278a803b0e7052f4eeb1979b29f963dd0=
143f4458e2cb5f33c4e5f0963b","src/winapi.rs":"e128e95b2d39ae7a02f54a7e25d33c=
488c14759b9f1a50a449e10545856950c3","src/windows_registry.rs":"1f973f804b4b=
451e48ff6d98ce660355772f164dfdf79a6ae514645c7c764005","tests/cc_env.rs":"e0=
2b3b0824ad039b47e4462c5ef6dbe6c824c28e7953af94a0f28f7b5158042e","tests/cfla=
gs.rs":"57f06eb5ce1557e5b4a032d0c4673e18fbe6f8d26c1deb153126e368b96b41b3","=
tests/cxxflags.rs":"c2c6c6d8a0d7146616fa1caed26876ee7bc9fcfffd525eb4743593c=
ade5f3371","tests/support/mod.rs":"a3c8d116973bb16066bf6ec4de5143183f97de7a=
ad085d85f8118a2eaac3e1e0","tests/test.rs":"61fb35ae6dd5cf506ada000bdd82c92e=
9f8eac9cc053b63e83d3f897436fbf8f"},"package":"50d30906286121d95be3d479533b4=
58f87493b30a4b5f79a607db8f5d11aa91f"}
---- a/vendor/cc-1.0.90/src/command_helpers.rs
-+++ b/vendor/cc-1.0.90/src/command_helpers.rs
-@@ -1,11 +1,9 @@
- //! Miscellaneous helpers for running commands
-=20
- use std::{
--    collections::hash_map,
-     ffi::OsString,
-     fmt::Display,
-     fs,
--    hash::Hasher,
-     io::{self, Read, Write},
-     path::Path,
-     process::{Child, ChildStderr, Command, Stdio},
-@@ -254,32 +252,7 @@
+--- a/vendor/cc-1.0.97/src/command_helpers.rs
++++ b/vendor/cc-1.0.97/src/command_helpers.rs
+@@ -257,6 +257,7 @@
+ /// and store them in the output Object.
  pub(crate) fn objects_from_files(files: &[Arc<Path>], dst: &Path) -> Resu=
lt<Vec<Object>, Error> {
      let mut objects =3D Vec::with_capacity(files.len());
++    let target_substring =3D ["rustc"];
      for file in files {
--        let basename =3D file
--            .file_name()
--            .ok_or_else(|| {
--                Error::new(
--                    ErrorKind::InvalidArgument,
--                    "No file_name for object file path!",
--                )
--            })?
--            .to_string_lossy();
--        let dirname =3D file
--            .parent()
--            .ok_or_else(|| {
--                Error::new(
--                    ErrorKind::InvalidArgument,
--                    "No parent for object file path!",
--                )
--            })?
--            .to_string_lossy();
--
--        // Hash the dirname. This should prevent conflicts if we have mul=
tiple
--        // object files with the same filename in different subfolders.
--        let mut hasher =3D hash_map::DefaultHasher::new();
--        hasher.write(dirname.to_string().as_bytes());
--        let obj =3D dst
--            .join(format!("{:016x}-{}", hasher.finish(), basename))
--            .with_extension("o");
-+        let obj =3D dst.join(file).with_extension("o");
-=20
-         match obj.parent() {
-             Some(s) =3D> fs::create_dir_all(s)?,
---- a/vendor/cc-1.0.90/.cargo-checksum.json=20
-+++ b/vendor/cc-1.0.90/.cargo-checksum.json
-@@ -1 +1 @@
--{"files":{"Cargo.toml":"ad60f12609a272a3d052258f9521807fd627181125e84dd98=
8ddb2b2e7dfedf6","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d059=
d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7b2ba9=
6f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25dac0a759=
8e678e9b601a7d99a791069bddaf180dfe","src/command_helpers.rs":"3ef95bdcd79a4=
3406fdab275d8a8f45ba787876399b54df34068955ec0109e69","src/lib.rs":"71e55cf1=
8e32dab3b9feae2add4ff57932a10084cc5aad4680c12eb3a91ed124","src/parallel/asy=
nc_executor.rs":"4ce24435fff6b6555b43fee042c16bd65d4150d0346567f246b9190d85=
b45983","src/parallel/job_token.rs":"0676c3177b5be9d7ede483bf4bd45c5ca0f551=
1073e4d1c9f181a0bc83db05dc","src/parallel/mod.rs":"aaffed5ad3dc0d28641533ab=
0d6f522bf34a059d4b1a239dc4d217cb5d58e232","src/parallel/stderr.rs":"a2d18ba=
3f2e04deb9047ece9ab7ca5452d9a76b515afbe20a76307e31597f34b","src/tool.rs":"1=
72cfcbecd7c6a363ea841a48a10a75b0a01e83b83c0691107c601598b68dedf","src/windo=
ws/com.rs":"be1564756c9f3ef1398eafeed7b54ba610caba28e8f6258d28a997737ebf953=
5","src/windows/find_tools.rs":"f6f391294511c376c3ce10ac2fd29967fe6f21d256d=
9575d8733c1c7cb1befde","src/windows/mod.rs":"42f1ad7fee35a17686b003e6aa520d=
3d1940d47d2f531d626e9ae0c48ba49005","src/windows/registry.rs":"c521b72c825e=
8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/windows/setup_co=
nfig.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8"=
,"src/windows/vs_instances.rs":"76e3cee74b5fd38ddaf533bba11fe401667c50dda5f=
9d064099840893eaa7587","src/windows/winapi.rs":"250d51c1826d1a2329e9889dd9f=
058cfce253dbf2a678b076147c6cdb5db046c","src/windows/windows_sys.rs":"f6b90b=
87f23e446284bde86749b53858c0d37b8a43515ed8d0e90b1ac8cf7771"},"package":"8cd=
6604a82acf3039f1144f54b8eb34e91ffba622051189e71b781822d5ee1f5"}
-\ No newline at end of file
-+{"files":{"Cargo.toml":"ad60f12609a272a3d052258f9521807fd627181125e84dd98=
8ddb2b2e7dfedf6","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d059=
d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7b2ba9=
6f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25dac0a759=
8e678e9b601a7d99a791069bddaf180dfe","src/command_helpers.rs":"0977a08e49a78=
e4065858e650a7e92151806e247b542b87cbbeee96a9177153c","src/lib.rs":"71e55cf1=
8e32dab3b9feae2add4ff57932a10084cc5aad4680c12eb3a91ed124","src/parallel/asy=
nc_executor.rs":"4ce24435fff6b6555b43fee042c16bd65d4150d0346567f246b9190d85=
b45983","src/parallel/job_token.rs":"0676c3177b5be9d7ede483bf4bd45c5ca0f551=
1073e4d1c9f181a0bc83db05dc","src/parallel/mod.rs":"aaffed5ad3dc0d28641533ab=
0d6f522bf34a059d4b1a239dc4d217cb5d58e232","src/parallel/stderr.rs":"a2d18ba=
3f2e04deb9047ece9ab7ca5452d9a76b515afbe20a76307e31597f34b","src/tool.rs":"1=
72cfcbecd7c6a363ea841a48a10a75b0a01e83b83c0691107c601598b68dedf","src/windo=
ws/com.rs":"be1564756c9f3ef1398eafeed7b54ba610caba28e8f6258d28a997737ebf953=
5","src/windows/find_tools.rs":"f6f391294511c376c3ce10ac2fd29967fe6f21d256d=
9575d8733c1c7cb1befde","src/windows/mod.rs":"42f1ad7fee35a17686b003e6aa520d=
3d1940d47d2f531d626e9ae0c48ba49005","src/windows/registry.rs":"c521b72c825e=
8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/windows/setup_co=
nfig.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8"=
,"src/windows/vs_instances.rs":"76e3cee74b5fd38ddaf533bba11fe401667c50dda5f=
9d064099840893eaa7587","src/windows/winapi.rs":"250d51c1826d1a2329e9889dd9f=
058cfce253dbf2a678b076147c6cdb5db046c","src/windows/windows_sys.rs":"f6b90b=
87f23e446284bde86749b53858c0d37b8a43515ed8d0e90b1ac8cf7771"},"package":"8cd=
6604a82acf3039f1144f54b8eb34e91ffba622051189e71b781822d5ee1f5"}
---- a/vendor/cc-1.0.92/src/command_helpers.rs
-+++ b/vendor/cc-1.0.92/src/command_helpers.rs
-@@ -1,11 +1,9 @@
- //! Miscellaneous helpers for running commands
-=20
- use std::{
--    collections::hash_map,
-     ffi::OsString,
-     fmt::Display,
-     fs,
--    hash::Hasher,
-     io::{self, Read, Write},
-     path::Path,
-     process::{Child, ChildStderr, Command, Stdio},
-@@ -258,32 +256,7 @@
- pub(crate) fn objects_from_files(files: &[Arc<Path>], dst: &Path) -> Resu=
lt<Vec<Object>, Error> {
-     let mut objects =3D Vec::with_capacity(files.len());
-     for file in files {
--        let basename =3D file
--            .file_name()
--            .ok_or_else(|| {
--                Error::new(
--                    ErrorKind::InvalidArgument,
--                    "No file_name for object file path!",
--                )
--            })?
--            .to_string_lossy();
--        let dirname =3D file
--            .parent()
--            .ok_or_else(|| {
--                Error::new(
--                    ErrorKind::InvalidArgument,
--                    "No parent for object file path!",
--                )
--            })?
--            .to_string_lossy();
--
--        // Hash the dirname. This should prevent conflicts if we have mul=
tiple
--        // object files with the same filename in different subfolders.
--        let mut hasher =3D hash_map::DefaultHasher::new();
+         let basename =3D file
+             .file_name()
+@@ -277,10 +278,29 @@
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
++                     //If a target is found and pos is None, set it
++                         if pos.is_none() || index < pos.unwrap() {
++                             pos =3D Some(index);
++                         }
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
 -        hasher.write(dirname.to_string().as_bytes());
--        let obj =3D dst
--            .join(format!("{:016x}-{}", hasher.finish(), basename))
--            .with_extension("o");
-+        let obj =3D dst.join(file).with_extension("o");
-=20
-         match obj.parent() {
-             Some(s) =3D> fs::create_dir_all(s)?,
---- a/vendor/cc-1.0.92/.cargo-checksum.json=20
-+++ b/vendor/cc-1.0.92/.cargo-checksum.json=20
++        hasher.write(filtered_dirname.as_bytes());
+         let obj =3D dst
+             .join(format!("{:016x}-{}", hasher.finish(), basename))
+             .with_extension("o");
+--- a/vendor/cc-1.0.97/.cargo-checksum.json
++++ b/vendor/cc-1.0.97/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{"Cargo.toml":"3874a391e743987dfdb8719b2fedf6ea9bfd83d13a465b0c1=
4cf25251f639799","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d059=
d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7b2ba9=
6f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25dac0a759=
8e678e9b601a7d99a791069bddaf180dfe","src/command_helpers.rs":"15afbc35930a5=
a53f00d74a8910cff35caeb5511c26642cffe5630377aced901","src/detect_compiler_f=
amily.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd08abf392f5a29"=
,"src/lib.rs":"4b65bc0145f64942ed8f480ab93068e85620968d28de200f06553160dec5=
975e","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fee042c16bd65d4=
150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"0676c3177b5be9d=
7ede483bf4bd45c5ca0f5511073e4d1c9f181a0bc83db05dc","src/parallel/mod.rs":"a=
affed5ad3dc0d28641533ab0d6f522bf34a059d4b1a239dc4d217cb5d58e232","src/paral=
lel/stderr.rs":"a2d18ba3f2e04deb9047ece9ab7ca5452d9a76b515afbe20a76307e3159=
7f34b","src/target_info.rs":"3e6cf011d4fe52065db2716277661342eb8ab9f2516fda=
4c551d0dc0fe0d9c87","src/tempfile.rs":"47a58e904ac07da6682004b5b615dc83250b=
253a8d3e8ba1b9bcaf6cdf4fd142","src/tool.rs":"b48a7a0efbeb24dc4ccdb4326583ef=
074e69c670330681a5be9d5c19492e5f96","src/windows/com.rs":"be1564756c9f3ef13=
98eafeed7b54ba610caba28e8f6258d28a997737ebf9535","src/windows/find_tools.rs=
":"dcaa6224a0b00298c1421ade505cec31268ee6c477d982a08ed0a3433681c3f6","src/w=
indows/mod.rs":"42f1ad7fee35a17686b003e6aa520d3d1940d47d2f531d626e9ae0c48ba=
49005","src/windows/registry.rs":"c521b72c825e8095843e73482ffa810ed066ad8bb=
9f86e6db0c5c143c171aba1","src/windows/setup_config.rs":"754439cbab492afd44c=
9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/windows/vs_instances.rs=
":"76e3cee74b5fd38ddaf533bba11fe401667c50dda5f9d064099840893eaa7587","src/w=
indows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cfce253dbf2a678b076147c6cd=
b5db046c","src/windows/windows_sys.rs":"5a440eb39d8a0c176b66177e87531867977=
93bc5d7896292c408fb44c12dfed3"},"package":"2678b2e3449475e95b0aa6f9b506a28e=
61b3dc8996592b983695e8ebb58a8b41"}
+-{"files":{"Cargo.toml":"5c15212a19ab7432d834b92cc7f6af9461c860fbaf2a756cd=
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
 \ No newline at end of file
-+{"files":{"Cargo.toml":"3874a391e743987dfdb8719b2fedf6ea9bfd83d13a465b0c1=
4cf25251f639799","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d059=
d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7b2ba9=
6f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25dac0a759=
8e678e9b601a7d99a791069bddaf180dfe","src/command_helpers.rs":"edff7d8ad5d6f=
7064ea1ec9ec816f055f87cbe0cd8d505687a67fd544ad7eb11","src/detect_compiler_f=
amily.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd08abf392f5a29"=
,"src/lib.rs":"4b65bc0145f64942ed8f480ab93068e85620968d28de200f06553160dec5=
975e","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fee042c16bd65d4=
150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"0676c3177b5be9d=
7ede483bf4bd45c5ca0f5511073e4d1c9f181a0bc83db05dc","src/parallel/mod.rs":"a=
affed5ad3dc0d28641533ab0d6f522bf34a059d4b1a239dc4d217cb5d58e232","src/paral=
lel/stderr.rs":"a2d18ba3f2e04deb9047ece9ab7ca5452d9a76b515afbe20a76307e3159=
7f34b","src/target_info.rs":"3e6cf011d4fe52065db2716277661342eb8ab9f2516fda=
4c551d0dc0fe0d9c87","src/tempfile.rs":"47a58e904ac07da6682004b5b615dc83250b=
253a8d3e8ba1b9bcaf6cdf4fd142","src/tool.rs":"b48a7a0efbeb24dc4ccdb4326583ef=
074e69c670330681a5be9d5c19492e5f96","src/windows/com.rs":"be1564756c9f3ef13=
98eafeed7b54ba610caba28e8f6258d28a997737ebf9535","src/windows/find_tools.rs=
":"dcaa6224a0b00298c1421ade505cec31268ee6c477d982a08ed0a3433681c3f6","src/w=
indows/mod.rs":"42f1ad7fee35a17686b003e6aa520d3d1940d47d2f531d626e9ae0c48ba=
49005","src/windows/registry.rs":"c521b72c825e8095843e73482ffa810ed066ad8bb=
9f86e6db0c5c143c171aba1","src/windows/setup_config.rs":"754439cbab492afd44c=
9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/windows/vs_instances.rs=
":"76e3cee74b5fd38ddaf533bba11fe401667c50dda5f9d064099840893eaa7587","src/w=
indows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cfce253dbf2a678b076147c6cd=
b5db046c","src/windows/windows_sys.rs":"5a440eb39d8a0c176b66177e87531867977=
93bc5d7896292c408fb44c12dfed3"},"package":"2678b2e3449475e95b0aa6f9b506a28e=
61b3dc8996592b983695e8ebb58a8b41"}
++{"files":{"Cargo.toml":"5c15212a19ab7432d834b92cc7f6af9461c860fbaf2a756cd=
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
diff --git a/recipes-devtools/rust/libstd-rs_1.79.0.bb b/recipes-devtools/r=
ust/libstd-rs_1.80.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.79.0.bb
rename to recipes-devtools/rust/libstd-rs_1.80.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.79.0.bb b/recipes-=
devtools/rust/rust-cross-canadian_1.80.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.79.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.80.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.79.0.bb b/recipes-devtools/r=
ust/rust-llvm_1.80.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.79.0.bb
rename to recipes-devtools/rust/rust-llvm_1.80.0.bb
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rus=
t/rust-snapshot.inc
index e183303..66d777f 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,56 +4,56 @@
 ## The exact (previous) version that has been used is specified in the sou=
rce tarball.
 ## The version is replicated here.
=20
-SNAPSHOT_VERSION =3D "1.78.0"
+SNAPSHOT_VERSION =3D "1.79.0"
=20
-SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "5173f84a07d4cc6b19f27eda746=
4999c5886232ce8e54bf61b06617635d43fb9"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "086367aa83ea8c30ce41fb6c09=
7ae6ebdc92363fb1ce8ee9f01d44cafa625f61"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "66cf114dcd8056a596bf169f=
824ff95ff1837bc065daaafdbcaa02ce92903304"
-SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "e0450bef5537e6b0bb82872e9f8=
37c3b3f6397cc8eba6f53211481c82426e1ce"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "4ca5e9bd141b0111387ea1aa035=
5f87eb8d0da52fbc616cefa4ecde4997aa65b"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "77803cfff2ea0342f26b59eabe=
c353bc43a1791012aa70855ecfea0fb7ae76ac"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "519abf4757fbd8d7e3bb4e4c=
fdc362ded972c1d95f04675684df2d31e8c0899b"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "9c847b42b81325d25a9240e33bf=
03fa8652f5dd321ae90a9a7a58b46bf124b17"
=20
-SRC_URI[cargo-snapshot-i686.sha256sum] =3D "472230d0a04c6a2db80671549cb970=
176299817883dafbffb15c993f5aeaa909"
-SRC_URI[clippy-snapshot-i686.sha256sum] =3D "1abc63d39850194580c22f998ff14=
aade2601f7cfc2465cf68828dcfc9d5536d"
-SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "9e5e02311853354c1540e1b4da6=
c1686616cea9d3a233c033023f36d950977c0"
-SRC_URI[rustc-snapshot-i686.sha256sum] =3D "8ba9c213e5daaf08a13c5787a4ea0d=
7ae8d1e7004126de2b8dc6a6dcd798becd"
+SRC_URI[cargo-snapshot-i686.sha256sum] =3D "57bd43f363ebd399a38aa4ac3b137e=
9172706770f8b23479f9dd859c6ae779ab"
+SRC_URI[clippy-snapshot-i686.sha256sum] =3D "1d2612c829d946ca8ce32f2beacfd=
e2c5ebed1fcacb720a58fb8e7786e4c82f2"
+SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "158294f7c424ef75d84046b573f=
225c15d531745cc79d416a18c11aa8253830e"
+SRC_URI[rustc-snapshot-i686.sha256sum] =3D "4695a6eb66252d519510ca0a859803=
fff3a5041f71004404df0ccc9fbf0298d5"
=20
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "fabe8c461fb87eff8bdf784=
5fca7051c5dc6e46da4dc6b3023c90efc7d7bd918"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "d9366b69bd41673bccd761=
7c2f3fe6a1cdd478fda407c7d9fda0021e33deb825"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "9f5dc7bfd8602a594157=
d04c480fb74804a3cdd9b77f46202e289a546af7c846"
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "9f19f781cdfa51f5e8b5406=
02a6a07d45ab5f2e063a86af6177625ecf9d79358"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "354d498a8e36abe6ebd7bd8=
59c8c7e7f02b029aa1897b9b60a87e9902ebb1079"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "88eab562705d56a246a09f=
2897cbae9e37a66dc3cc2cab52c781cd78024f2b52"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "88730b1b0d9c5252e041=
ed1fc2375d7292dc45132bcc8b6214490c578de240d3"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "f39a604e1a5a5ba1c7342c9=
d98c9952b5ba252cda4b55cc6ae7bd6fca72f3889"
=20
-SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "3d73d16f1b7c4aaf53e6d9ac6d0=
4586c60698b0c2c793c55585b0234f75d247d"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "f9b0d7ac6bdd26b678201d068f=
8777df5fdc7f524602f73eff54c7e8a5844892"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "4ac9958386c4225b14f8e628=
1dd64a2b00d5db32c5b336fac137c7c729df25a0"
-SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "33bbd45416ce00f2e21073ebcef=
8668575a3955189c85a13172bf5f5750e00ef"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "2a55e97ce512c27a012720bb2a0=
cd86554c1d734b5cb91b98f58af167cc0fde1"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "1ae0bbe5835d9461a12f22d509=
787e6c11aac8335c677152a57a04f8d22cf755"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "6aa2f351bc7dccb544781f4f=
ecddb5ef67e05bb310c84e0106d968231384d9f4"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "3b9a8067e97dd269a27fe91be16=
3e046e85b47973f5d512c3368c49d332dacb1"
=20
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "271e121aa1324d37d2bd65021=
7256a792ed387af4b14df0b2757ba22dab50ee5"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "53294b52155bb320570dd125=
e58b07ee3a0cb35e47a33716b3561d1751ccc538"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "303e3533e72099d4f0a1d5=
c2f31c68ef93b3a3ef8af5d36773eac394f920fb22"
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "338299628336aa97e6d2f30b5=
d3c4beaf78038f1e1347a378cbbf80d02a461ea"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "1e2ffcc41a2083be2f4733d53=
4d5ee0e05fc2ace1f21033792a4e2497cbbfbe4"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "0bceeb8dc5b48e5ea9cff67c=
dcf8488fe2afe44d7e75ca04669c7c0c2e02a0df"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "af95929af71494ee3e6988=
ead07204ea05b6f2b729cdb1ffcc26db75e47bf318"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "2295d50425ed5dfb028560ac0=
f9a611212d8deb43791a1d199419043157ab95e"
=20
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "b58d7e61fb36295ebd0a092=
42e292c7bc4fa24fc189aa285b6e266263f356316"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "5b2b621b79a7635d5670bc=
17d992f6a0bff0e153b6629fdd501a08cf0df7b126"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "117a01afab9d4c6e39bc=
32b57f8a4b9ad8d693869dde0c52fa51a6ec05eaab8b"
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "45ba3091f9f17abfb01d0c0=
3c87e8de33f0a210aefbdb007905dbf6cfba8590d"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "bec32adad9f2cd1650ed24e=
e82fccf7329c68243cdef7cef1e720ccaea097dab"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "6bb12041b6171e80598c0c=
04eb7e9bd07ab4fb4d654a9289618e3288a4d2f6c8"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "3b5d53d70837d5ec942e=
c41a8da37ed932bbdc1e53f78dc54e218db458701588"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "3b144840f179114cde30789=
09370bfb6928153d0ae303ac9848622c57cee3578"
=20
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "fc3fda5412f2b1a53c6a3fe6c=
0a98864d50eac8c63e9b38383085abad6487e3b"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "44745c59092bc449b0338ab6=
788eb0b2a6d5ad382224fe1ba1017931ebb6e6dc"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "e5d0e1e532f4ca4656d971=
c4301e87cbcd571daeffd7830b1d02055f95bdaca6"
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "6925c93e4b5b21e37b27aed77=
23cdd6da317eec3f06f86fb0e5be868f58ea052"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "83e28f3e02cce4a9d19841bcb=
40ec0c8ad4e9af9fb215c39876028e6e9e6baf1"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "fbc978db4be2e6fdb1dbcb3c=
a00ee54c44dafd08930738f1c6aa7ae249685a34"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "2b8af4060acb10f347c66a=
3477ae92151beba12192590ea40723dcf9b1f7f5b2"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "1b952b8cd597060ac07bbe99c=
ea382651ca6eee4ac2abe0a90303ccf2278e60e"
=20
-SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "59da021df10c62786d33bc6b186a7=
d1114f788bebcd09f0dd323032fad2f7f5d"
-SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "1a5542ac30cbcfb15512aba2d53b=
30dd8835058514085067bbcf7c938c05b79e"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "aee53a0a04fb44c95b9aa6217c=
5483113e1f67fa595dea6fdcbbbd72826e729b"
-SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "1f458a0b3b947d78d50c67b16bb68=
e8528cb71d52a7021c3b1652b5f9004c40b"
+SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "5663e6ea018a13f1c87ac74de2678=
29952ea979fbe5f8ee5c1c3531e25d1749c"
+SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "c00bd892e0f29bbc2514f87c7521=
210ced8c175a41eee0a428e19a6ef157779f"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "d70e710a5138871e8d972f195c=
ed9f7aa639ccef23a87fa03cc527d2b9c3cd36"
+SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "ef4b494fb7356b6e88a69b71378c0=
4ae0f4a3c264adae84c9d4f3a1314eaa2b4"
=20
-SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "f8aacf7a101eb10dc000b8bf26de=
90a9d0ce678d02ccf70430ed20dd31ecec6b"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "b15184ba6078dd7976f06239a25=
8313a96de2677b37e4c560779cf7f261c3ee5"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "95aece42a336f237c5bac5c5d=
9aca051b7f0bd3e6a64fb3c5828e6d0d3af2e8c"
-SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "3994971e5923716d54e4b574ce23=
8f04c4e20cda03990670f7cc3f87d36e5499"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "07fcadd27b645ad58ff4dae5ef16=
6fd730311bbae8f25f6640fe1bfd2a1f3c3c"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "3fb282ee97626e4f25c4f6faac3=
997859b89f13983dd6fa111e25182dfcb91fa"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "2c914483c0882d44af2e50a18=
1cbd2c953d672d50b31aa669ee2346cade1f108"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "a04cf42022d0a5faf01c31082bfb=
1dde9c38409f0ca6da90a3e40faa03e797ae"
=20
-SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "c119866af24c91108d34267e248=
86ad90fd8784edfdfd0d36c64013b06974f71"
+SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "9c38f2cd4c19196fcf113166237=
ab03512bf19ce5a7f13c3bfe0e5cc3317eb44"
=20
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "7e158a16f733844975e65090=
b07706596401719bd3f5aca44da9f98fb3c11b04"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "f7c7a73a8e5640f9d5aca6b2=
6866b4da08cf3d3509ed1c4184309fb868acbff2"
=20
 SRC_URI +=3D " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-s=
napshot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index f0681c8..0cd329f 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -11,7 +11,7 @@ SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${R=
UST_VERSION}-src.tar.xz;n
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=3D=
${RUSTSRC} \
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.pa=
tch;patchdir=3D${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] =3D "ab826e84b8d48ec6eda3370065034dea8c006f6a946d7=
8a9ba12bcb50e6d3c7a"
+SRC_URI[rust.sha256sum] =3D "0b9ca1e2e45b8a5f0b58db140af0dc92f8311faeb0ad8=
83c5b71a72c02dc6e80"
=20
 RUSTSRC =3D "${WORKDIR}/rustc-${RUST_VERSION}-src"
=20
diff --git a/recipes-devtools/rust/rust_1.79.0.bb b/recipes-devtools/rust/r=
ust_1.80.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.79.0.bb
rename to recipes-devtools/rust/rust_1.80.0.bb
--=20
2.47.0


