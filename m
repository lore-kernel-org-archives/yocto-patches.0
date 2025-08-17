Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3407CA0EE9
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 17:29:51 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web11.56796.1755451789618290259
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 10:29:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XemseKUD;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b109a95f09so25776011cf.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755451788; x=1756056588; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9acS+GjZHww5vI6LAPcLE/9u/tPLOhOr3eC6KT+RAs=;
        b=XemseKUDeSEJE/Vqh+3Kwi2mUvtkVVDEjzWULaV7u+h01KFLG49hVfJQQE9wwCiCxL
         uIzWvTpr+5x28HWVPXg2R2R8PqIB5/TQC+ubVyiXIJxsDwAjSn1LSspEicUzR9UqVJw6
         E1fspSS/txNRU2uXbHE7AWh+4EbgZCBoXNBsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451788; x=1756056588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9acS+GjZHww5vI6LAPcLE/9u/tPLOhOr3eC6KT+RAs=;
        b=AJCeU7yj+PE7XKZitVMNJnkkX4wZshyE30G5qU88YcojXR543xulAkSYexBq0rPFEZ
         GWnj1FX9S2h6kUzUAYwchvuTmoCjgm7TId9gsunduCC/djZNMsLGphZbxFwxU4UxTtN0
         G8DmEDNfXmwKCtCWDHe+qtji32Sk6U9g/4LK/IkdLDYQRy6pYKRJyrZ/I7/iz6VYHQ15
         dBaFoT5wphXgq60DIJqCeTL0iDl4VpvZEZYoea2uOK3Ud6tocg3wyuefeIJ4MUslxYM1
         7s5r8TymzME55XVue0ZKBNdbecjD7mcKHBsDhxBkEkHjoAPSWdel8Ho5thZjyyKMcGDH
         DNPw==
X-Gm-Message-State: AOJu0Yxut1ymlf5jCShFymK2KR4EPLSVijNhihqk7/8GehsCRLOexBN7
	/r4q2405Gm8/cvhRAm2+GF9wg3508LeuIo3U+1gXharkLY6ANRl5rrQMGThF9B6+9KgcZXawBKR
	M2xOf
X-Gm-Gg: ASbGncsDrVtmWRb4q7rVksOJNEWHbw8C408tQVvj3lsSGpX5qOsVDjQV/DQU4Z+vw7j
	Etovgun+bEAm2867LfibYX0qxrCKad94Z9dSr8ntUAwyGUFzpUQ/+nkJPx1M5tDDglgpQbWxvPa
	2X+FSwo9AUZtjvKKEriZuOdkEDLYQTiTzE9hSFGsEyU1NVtg8fy7Tz1ecubt5XdUBnnS0xflyu4
	kCfwEq3ErXiwlxebNwrLONHi93Q8/0tkvhRUl61bs2aNJfJ28hcv+DdaD8d/K8hlm3BpggdYjAE
	YzYnNSQls/yd1v4bIdGBrKfCSIfdCvCRy7uXIREe0lCANE3C9KQY+GboGrARP9Eq0eN0ai+kpGh
	raVJqc+/c7pG95ofqxKebGv/oh8VfoSQsqaIeuZyAs7aJ+KskMjDcYgPEdAoKZDIotPHzjcP2Oq
	11vymajEgz
X-Google-Smtp-Source: AGHT+IEsjxYOSBXm29Cit4onml6Ks7MuMft9NNISy6FWbz6VWCdFWgvGfR6j6i2cbMwZT0g7d0ILAQ==
X-Received: by 2002:a05:622a:1308:b0:4b1:1793:6beb with SMTP id d75a77b69052e-4b11e23d356mr111047501cf.34.1755451787715;
        Sun, 17 Aug 2025 10:29:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc18a0esm39626271cf.9.2025.08.17.10.29.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:29:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 3/7] rust: Upgrade 1.87.0 -> 1.88.0
Date: Sun, 17 Aug 2025 13:29:27 -0400
Message-ID: <121efa41e09d2e3a9d5096b5ff151f4f420b23b2.1755451486.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755451486.git.scott.murray@konsulko.com>
References: <cover.1755451486.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 17:29:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2006

From: Jayasurya Maganuru <Maganuru.Jayasurya@windriver.com>

Rust stable version updated to 1.88.0.
https://blog.rust-lang.org/2025/06/26/Rust-1.88.0/

* Rebase existing patches with v1.88.0

* Exclude tidy and coverage-dump from OE self-tests due to test failures
  Although the build completes successfully, OE self-tests fail:
  tools/coverage-dump panics during test execution.
  tools/tidy fails due to a mismatched GCC submodule commit.
  These tests are excluded to allow successful OE self-test runs.

* Two tests from the`codegen` modules now fail only on riscv64.
  Enable them on arm32/64 and x86-32/64 targets, while restricting
  them on riscv64 via `only-<target_arch>` tags.

  Bugzilla link - https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15944

  Test Results Summary:
  +-----------+--------+---------+
  | Machine   | Passed | Ignored |
  +-----------+--------+---------+
  | arm-32    | 28,664 | 1,451   |
  | arm-64    | 28,748 | 1,396   |
  | x86-32    | 28,657 | 1,432   |
  | x86-64    | 28,904 | 1,213   |
  | riscv-64  | 28,722 | 1,421   |
  +-----------+--------+---------+

Signed-off-by: Jayasurya Maganuru <Maganuru.Jayasurya@windriver.com>
Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 5afc9bdbabfdbcb784ceb637926111e6c7648f41)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |   2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |   2 +
 .../rust/{cargo_1.87.0.bb =3D> cargo_1.88.0.bb} |   0
 ...teps-tool.rs-switch-off-lto-for-rust.patch |  18 ++--
 ...epro-issue-fix-with-cc-crate-hashmap.patch | 102 ------------------
 ...d-statically-in-rustc_driver-feature.patch |   6 +-
 .../rust/files/rust-oe-selftest.patch         |  48 +++++++--
 ...ibstd-rs_1.87.0.bb =3D> libstd-rs_1.88.0.bb} |   0
 ....87.0.bb =3D> rust-cross-canadian_1.88.0.bb} |   0
 ...ust-llvm_1.87.0.bb =3D> rust-llvm_1.88.0.bb} |   2 +-
 recipes-devtools/rust/rust-snapshot.inc       |  78 +++++++-------
 recipes-devtools/rust/rust-source.inc         |   2 +-
 .../rust/{rust_1.87.0.bb =3D> rust_1.88.0.bb}   |   0
 13 files changed, 94 insertions(+), 166 deletions(-)
 rename recipes-devtools/rust/{cargo_1.87.0.bb =3D> cargo_1.88.0.bb} (100%)
 rename recipes-devtools/rust/{libstd-rs_1.87.0.bb =3D> libstd-rs_1.88.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.87.0.bb =3D> rust-cros=
s-canadian_1.88.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.87.0.bb =3D> rust-llvm_1.88.0.bb=
} (99%)
 rename recipes-devtools/rust/{rust_1.87.0.bb =3D> rust_1.88.0.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index a5ee815..92899f9 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,7 +15,7 @@ LAYERDEPENDS_lts-rust-mixin =3D "core"
=20
 LICENSE_PATH +=3D "${LAYERDIR}/files/common-licenses"
=20
-RUSTVERSION ?=3D "1.87.0%"
+RUSTVERSION ?=3D "1.88.0%"
=20
 # This is not ideal, but it seems better to mask out the older oe-core
 # recipes completely since they will not work with this layer on top,
diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/case=
s/rust_mixin.py
index d99a58d..922aa67 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -67,6 +67,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPT=
estResultTestCase):
                             'src/etc/test-float-parse',
                             'src/librustdoc',
                             'src/rustdoc-json-types',
+                            'src/tools/coverage-dump',
                             'src/tools/jsondoclint',
                             'src/tools/lint-docs',
                             'src/tools/replace-version-placeholder',
@@ -74,6 +75,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OEPT=
estResultTestCase):
                             'src/tools/rustdoc-themes',
                             'src/tools/rust-installer',
                             'src/tools/suggest-tests',
+                            'src/tools/tidy',
                             'tests/assembly/asm/aarch64-outline-atomics.rs=
',
                             'tests/codegen/issues/issue-122805.rs',
                             'tests/codegen/thread-local.rs',
diff --git a/recipes-devtools/rust/cargo_1.87.0.bb b/recipes-devtools/rust/=
cargo_1.88.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.87.0.bb
rename to recipes-devtools/rust/cargo_1.88.0.bb
diff --git a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-=
switch-off-lto-for-rust.patch b/recipes-devtools/rust/files/0001-src-core-b=
uild_steps-tool.rs-switch-off-lto-for-rust.patch
index a7da69d..1ff43d1 100644
--- a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-=
off-lto-for-rust.patch
+++ b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-=
off-lto-for-rust.patch
@@ -24,10 +24,10 @@ diff --git a/src/bootstrap/src/core/build_steps/tool.rs=
 b/src/bootstrap/src/core
 index 087df2f8a..00790affb 100644
 --- a/src/bootstrap/src/core/build_steps/tool.rs
 +++ b/src/bootstrap/src/core/build_steps/tool.rs
-@@ -15,14 +15,12 @@
+@@ -15,14 +15,12 @@ use std::{env, fs};
  #[cfg(feature =3D "tracing")]
  use tracing::instrument;
-=20
+
 -use crate::core::build_steps::compile::is_lto_stage;
  use crate::core::build_steps::toolstate::ToolState;
  use crate::core::build_steps::{compile, llvm};
@@ -42,14 +42,13 @@ index 087df2f8a..00790affb 100644
  use crate::utils::channel::GitInfo;
  use crate::utils::exec::{BootstrapCommand, command};
  use crate::utils::helpers::{add_dylib_path, exe, t};
-@@ -148,20 +146,7 @@
+@@ -148,20 +146,7 @@ impl Step for ToolBuild {
              &self.extra_features,
          );
-=20
--        if path.ends_with("/rustdoc") &&
--            // rustdoc is performance sensitive, so apply LTO to it.
--            is_lto_stage(&self.compiler)
--        {
+
+-        // Rustc tools (miri, clippy, cargo, rustfmt, rust-analyzer)
+-        // could use the additional optimizations.
+-        if self.mode =3D=3D Mode::ToolRustc && is_lto_stage(&self.compile=
r) {
 -            let lto =3D match builder.config.rust_lto {
 -                RustcLto::Off =3D> Some("off"),
 -                RustcLto::Thin =3D> Some("thin"),
@@ -60,10 +59,11 @@ index 087df2f8a..00790affb 100644
 -                cargo.env(cargo_profile_var("LTO", &builder.config), lto);
 -            }
 -        }
+-
 +        cargo.rustflag("-Clto=3Doff");
-=20
          if !self.allow_features.is_empty() {
              cargo.allow_features(self.allow_features);
+         }
 diff --git a/src/bootstrap/src/core/builder/mod.rs b/src/bootstrap/src/cor=
e/builder/mod.rs
 --- a/src/bootstrap/src/core/builder/mod.rs
 +++ b/src/bootstrap/src/core/builder/mod.rs
diff --git a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hash=
map.patch b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashm=
ap.patch
index 911c560..53b1290 100644
--- a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
+++ b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
@@ -64,105 +64,3 @@ index b070eeb322..ba768ff86f 100644
 -{"files":{"CHANGELOG.md":"fb0a3bcb34301d2578bef86feabe93057068cb1906a7f10=
b584f58ff6123e8c6","Cargo.lock":"b661254fadca74408d53742755b371f7ae29e501e8=
51aeae13bcd14a51883321","Cargo.toml":"50debe1b2fc050e8b305bdd514509d98cdbc5=
9e96e5f10888df4b6fca19d3a75","LICENSE-APACHE":"a60eea817514531668d7e0076573=
1449fe14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c3941=
8f3f2d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b7833=
3a25dac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"aa7850db4350=
883c8f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb1d","src/command_helpers.=
rs":"b766a70e39b8ea7bb57afd288bcac205a23f6a26ac5619cb1d5b10f70c5dfdea","src=
/detect_compiler_family.c":"97ca4b021495611e828becea6187add37414186a16dfedd=
26c2947cbce6e8b2f","src/lib.rs":"221ba9475100303b5c694b2a02e5353452ee08a29e=
4e4d4d67ea8fcbd87605df","src/parallel/async_executor.rs":"4ce24435fff6b6555=
b43fee042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs=
":"018a01cb00182270bbcb68e31e7a7c5c621a95f086e4c68cfa2bf557ac24e5f2","src/p=
arallel/mod.rs":"bd9c1334d17d138c281961c690b8d8118a2d6295a7d6cd729682625543=
6fa063","src/parallel/stderr.rs":"74384d41198740a6fce0877f144262db09fb09122=
5fa8fbfa771314bb11487c6","src/target.rs":"7313240db078ad85c1209a42a5fa96c36=
92b5d6e5093c7f366a1b99677247109","src/target/apple.rs":"6afbecac9f66aa72db5=
5694413532f80b2753f28466a6213d1aa901a03c78bcd","src/target/generated.rs":"a=
f067e1c291e895ddb591f92534eed0c48977cdb2b58f8239423e07c6de31cd3","src/targe=
t/llvm.rs":"e1db4a7fb8b905ee9853781f2fcc64a9d3b48154e4c8b6cb12f5373c5935da6=
e","src/target/parser.rs":"4f2129a24273d62bf8ab339098e7f758e4e42b0df369dd2b=
0eb1b20726be91f8","src/tempfile.rs":"ebafb5b0e5d08b0706916ed911d4245240e60c=
3e2d0c9a1630c520842988a2b3","src/tool.rs":"2e6550062e021f2b394388172bbb01e8=
6fe6a94d2395bcb3c85a9e86690da1a9","src/utilities.rs":"52b30b24a1c31cdefb105=
309ee5220cfc9fca76eaf4e6d6509c3e19f431448fe","src/windows/com.rs":"a2800ddb=
81215fff2bf618336f5c4ff8e8bdb746dd18b795873c7304b3f2a5e3","src/windows/find=
_tools.rs":"0ff410bd71f08ee88e99609c15be5f1bc16ad7bd07a83918d13a70c8465642e=
2","src/windows/mod.rs":"34cfa201cfbcac7ccaa3ea5295d3e4200439af3cc5c6433baf=
81502596040a89","src/windows/registry.rs":"c521b72c825e8095843e73482ffa810e=
d066ad8bb9f86e6db0c5c143c171aba1","src/windows/setup_config.rs":"754439cbab=
492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/windows/vs_ins=
tances.rs":"946527cf8fd32c3472f6a2884dcdec290763101097334c7478f9c24c3950db6=
b","src/windows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cfce253dbf2a678b0=
76147c6cdb5db046c","src/windows/windows_sys.rs":"e2714c8307bfa083b9745eb0e4=
6cadd7f98d7b88abf45a7637172019324e34b8","src/windows/windows_targets.rs":"5=
b4648ebc22b028caca9f4b4bf8881fe2d094b7bec217264ba2e6e2c49d1ccee"},"package"=
:"1aeb932158bd710538c73702db6945cb68a8fb08c519e6e12706b94263b36db8"}
 \ No newline at end of file
 +{"files":{"CHANGELOG.md":"fb0a3bcb34301d2578bef86feabe93057068cb1906a7f10=
b584f58ff6123e8c6","Cargo.lock":"b661254fadca74408d53742755b371f7ae29e501e8=
51aeae13bcd14a51883321","Cargo.toml":"50debe1b2fc050e8b305bdd514509d98cdbc5=
9e96e5f10888df4b6fca19d3a75","LICENSE-APACHE":"a60eea817514531668d7e0076573=
1449fe14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c3941=
8f3f2d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b7833=
3a25dac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"aa7850db4350=
883c8f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb1d","src/command_helpers.=
rs":"174101852b2633a2478cef20d063fb9c2f1b092eac47913a6e708c85663b8404","src=
/detect_compiler_family.c":"97ca4b021495611e828becea6187add37414186a16dfedd=
26c2947cbce6e8b2f","src/lib.rs":"221ba9475100303b5c694b2a02e5353452ee08a29e=
4e4d4d67ea8fcbd87605df","src/parallel/async_executor.rs":"4ce24435fff6b6555=
b43fee042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs=
":"018a01cb00182270bbcb68e31e7a7c5c621a95f086e4c68cfa2bf557ac24e5f2","src/p=
arallel/mod.rs":"bd9c1334d17d138c281961c690b8d8118a2d6295a7d6cd729682625543=
6fa063","src/parallel/stderr.rs":"74384d41198740a6fce0877f144262db09fb09122=
5fa8fbfa771314bb11487c6","src/target.rs":"7313240db078ad85c1209a42a5fa96c36=
92b5d6e5093c7f366a1b99677247109","src/target/apple.rs":"6afbecac9f66aa72db5=
5694413532f80b2753f28466a6213d1aa901a03c78bcd","src/target/generated.rs":"a=
f067e1c291e895ddb591f92534eed0c48977cdb2b58f8239423e07c6de31cd3","src/targe=
t/llvm.rs":"e1db4a7fb8b905ee9853781f2fcc64a9d3b48154e4c8b6cb12f5373c5935da6=
e","src/target/parser.rs":"4f2129a24273d62bf8ab339098e7f758e4e42b0df369dd2b=
0eb1b20726be91f8","src/tempfile.rs":"ebafb5b0e5d08b0706916ed911d4245240e60c=
3e2d0c9a1630c520842988a2b3","src/tool.rs":"2e6550062e021f2b394388172bbb01e8=
6fe6a94d2395bcb3c85a9e86690da1a9","src/utilities.rs":"52b30b24a1c31cdefb105=
309ee5220cfc9fca76eaf4e6d6509c3e19f431448fe","src/windows/com.rs":"a2800ddb=
81215fff2bf618336f5c4ff8e8bdb746dd18b795873c7304b3f2a5e3","src/windows/find=
_tools.rs":"0ff410bd71f08ee88e99609c15be5f1bc16ad7bd07a83918d13a70c8465642e=
2","src/windows/mod.rs":"34cfa201cfbcac7ccaa3ea5295d3e4200439af3cc5c6433baf=
81502596040a89","src/windows/registry.rs":"c521b72c825e8095843e73482ffa810e=
d066ad8bb9f86e6db0c5c143c171aba1","src/windows/setup_config.rs":"754439cbab=
492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/windows/vs_ins=
tances.rs":"946527cf8fd32c3472f6a2884dcdec290763101097334c7478f9c24c3950db6=
b","src/windows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cfce253dbf2a678b0=
76147c6cdb5db046c","src/windows/windows_sys.rs":"e2714c8307bfa083b9745eb0e4=
6cadd7f98d7b88abf45a7637172019324e34b8","src/windows/windows_targets.rs":"5=
b4648ebc22b028caca9f4b4bf8881fe2d094b7bec217264ba2e6e2c49d1ccee"},"package"=
:"1aeb932158bd710538c73702db6945cb68a8fb08c519e6e12706b94263b36db8"}
-diff --git a/vendor/cc-1.0.99/src/command_helpers.rs b/vendor/cc-1.0.99/sr=
c/command_helpers.rs
-index fe919a5239..2b1f442019 100644
---- a/vendor/cc-1.0.99/src/command_helpers.rs
-+++ b/vendor/cc-1.0.99/src/command_helpers.rs
-@@ -257,6 +257,7 @@ fn wait_on_child(
- /// and store them in the output Object.
- pub(crate) fn objects_from_files(files: &[Arc<Path>], dst: &Path) -> Resu=
lt<Vec<Object>, Error> {
-     let mut objects =3D Vec::with_capacity(files.len());
-+    let target_substring =3D ["rustc"];
-     for file in files {
-         let basename =3D file
-             .file_name()
-@@ -277,10 +278,29 @@ pub(crate) fn objects_from_files(files: &[Arc<Path>]=
, dst: &Path) -> Result<Vec<
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
-+                    //If a target is found and pos is None, set it
-+                        if pos.is_none() || index < pos.unwrap() {
-+                            pos =3D Some(index);
-+                        }
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
-diff --git a/vendor/cc-1.1.22/src/command_helpers.rs b/vendor/cc-1.1.22/sr=
c/command_helpers.rs
-index 07dfb80412..e01b62fa39 100644
---- a/vendor/cc-1.1.22/src/command_helpers.rs
-+++ b/vendor/cc-1.1.22/src/command_helpers.rs
-@@ -285,6 +285,7 @@ fn wait_on_child(
- /// and store them in the output Object.
- pub(crate) fn objects_from_files(files: &[Arc<Path>], dst: &Path) -> Resu=
lt<Vec<Object>, Error> {
-     let mut objects =3D Vec::with_capacity(files.len());
-+    let target_substring =3D ["rustc"];
-     for file in files {
-         let basename =3D file
-             .file_name()
-@@ -305,10 +306,29 @@ pub(crate) fn objects_from_files(files: &[Arc<Path>]=
, dst: &Path) -> Result<Vec<
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
-+                    //If a target is found and pos is None, set it
-+                        if pos.is_none() || index < pos.unwrap() {
-+                            pos =3D Some(index);
-+                        }
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
-diff --git a/vendor/cc-1.0.99/.cargo-checksum.json b/vendor/cc-1.0.99/.car=
go-checksum.json
-index b070eeb322..ba768ff86f 100644
---- a/vendor/cc-1.0.99/.cargo-checksum.json
-+++ b/vendor/cc-1.0.99/.cargo-checksum.json
-@@ -1 +1 @@
--{"files":{"Cargo.lock":"1dc698513383b70d5460f3f9668b670bc72ce51ff6be79d13=
9acb515b39d35da","Cargo.toml":"3c555dbe1a698f12b66c8a5748ed52ff26ff7b8ebb12=
237c1a72a1cbe4b9392e","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe1=
4d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c39418f3f2d7=
b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b78333a25dac=
0a7598e678e9b601a7d99a791069bddaf180dfe","src/command_helpers.rs":"15afbc35=
930a5a53f00d74a8910cff35caeb5511c26642cffe5630377aced901","src/detect_compi=
ler_family.c":"72903b91d7a28f49b39e7d730f4c9c4bb39fb901948fa1279cd08abf392f=
5a29","src/lib.rs":"92440d3adb5cb6ea05596d9ca860a205d3937dbf0fc959e524bac5f=
2b748c1af","src/parallel/async_executor.rs":"4ce24435fff6b6555b43fee042c16b=
d65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs":"352a0295c9=
65c684904329d334f3b9889db3a9c3f201701f8db44e4d00e00515","src/parallel/mod.r=
s":"bd9c1334d17d138c281961c690b8d8118a2d6295a7d6cd7296826255436fa063","src/=
parallel/stderr.rs":"a2d18ba3f2e04deb9047ece9ab7ca5452d9a76b515afbe20a76307=
e31597f34b","src/target_info.rs":"342be00f6215e161d8163e272a2945bb9f52f1716=
48e15e11d46800a73186955","src/tempfile.rs":"47a58e904ac07da6682004b5b615dc8=
3250b253a8d3e8ba1b9bcaf6cdf4fd142","src/tool.rs":"e13c439a96d8311ba8d37b9d5=
522cd6997d94261cbb95517c82df70525acaa7f","src/windows/com.rs":"a2800ddb8121=
5fff2bf618336f5c4ff8e8bdb746dd18b795873c7304b3f2a5e3","src/windows/find_too=
ls.rs":"4c350cddbce1557682b7f40cd917cc4f131ad89ff2e34c23d629014ed8d7203e","=
src/windows/mod.rs":"42f1ad7fee35a17686b003e6aa520d3d1940d47d2f531d626e9ae0=
c48ba49005","src/windows/registry.rs":"c521b72c825e8095843e73482ffa810ed066=
ad8bb9f86e6db0c5c143c171aba1","src/windows/setup_config.rs":"754439cbab492a=
fd44c9755abcbec1a41c9b2c358131cee2df13c0e996dbbec8","src/windows/vs_instanc=
es.rs":"76e3cee74b5fd38ddaf533bba11fe401667c50dda5f9d064099840893eaa7587","=
src/windows/winapi.rs":"250d51c1826d1a2329e9889dd9f058cfce253dbf2a678b07614=
7c6cdb5db046c","src/windows/windows_sys.rs":"5a440eb39d8a0c176b66177e875318=
6797793bc5d7896292c408fb44c12dfed3"},"package":"96c51067fd44124faa7f870b4b1=
c969379ad32b2ba805aa959430ceaa384f695"}
-\ No newline at end of file
-+{"files":{"Cargo.toml":"3c555dbe1a698f12b66c8a5748ed52ff26ff7b8ebb12237c1=
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
-diff --git a/vendor/cc-1.1.22/.cargo-checksum.json b/vendor/cc-1.1.22/.car=
go-checksum.json
-index 8c7be07836..473b5ad39c 100644
---- a/vendor/cc-1.1.22/.cargo-checksum.json
-+++ b/vendor/cc-1.1.22/.cargo-checksum.json
-@@ -1 +1 @@
--{"files":{"CHANGELOG.md":"92aeb6dec3e4b55e3951a4d00f6df20edc51545afca124d=
983454f7c05e37357","Cargo.lock":"565d86121026a1cade3014777f9a32c97dc76b8435=
10f2c709cff3562ff04e1c","Cargo.toml":"1352b0476c28b89568e740579130ab017ad0f=
4b546083cf03ff61827d45361f3","LICENSE-APACHE":"a60eea817514531668d7e0076573=
1449fe14d059d3249e0bc93b36de45f759f2","LICENSE-MIT":"378f5840b258e2779c3941=
8f3f2d7b2ba96f1c7917dd6be0713f88305dbda397","README.md":"f1ddbede208a5b7833=
3a25dac0a7598e678e9b601a7d99a791069bddaf180dfe","clippy.toml":"aa7850db4350=
883c8f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb1d","src/command_helpers.=
rs":"0b54800fe5c89cd102a5f872fe1a843c1a58e026bc4bbc611e207914b8c84dda","src=
/detect_compiler_family.c":"97ca4b021495611e828becea6187add37414186a16dfedd=
26c2947cbce6e8b2f","src/lib.rs":"c80c94e82937980f711500cd3289842ab4bc42bcc4=
efd9febf64729e27410ecc","src/parallel/async_executor.rs":"4ce24435fff6b6555=
b43fee042c16bd65d4150d0346567f246b9190d85b45983","src/parallel/job_token.rs=
":"f4ed0a03d89a42bfd5527133d12b267af519b745f3f2b997ed293df15a2641b8","src/p=
arallel/mod.rs":"55fb4c2d15e66677b2ed5ffa6d65ea161bcf1a1e1dc7910ee3bde06f2f=
67ab14","src/parallel/once_lock.rs":"d13e4cb82d6bca3297ca8671d83a40dd5affd7=
ac89191d733dd451867181bb02","src/parallel/stderr.rs":"74384d41198740a6fce08=
77f144262db09fb091225fa8fbfa771314bb11487c6","src/target_info.rs":"f939a570=
c99d897fdd37cd491a4ee0657e2c7480ec71acbd9cbee48732d4bfbc","src/tempfile.rs"=
:"ebafb5b0e5d08b0706916ed911d4245240e60c3e2d0c9a1630c520842988a2b3","src/to=
ol.rs":"2e6550062e021f2b394388172bbb01e86fe6a94d2395bcb3c85a9e86690da1a9","=
src/utilities.rs":"a13bb0a351fcef72823485b1b5dc4f514c533fa4feac95deb66ed9e5=
fbfe7b53","src/windows/com.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd1=
8b795873c7304b3f2a5e3","src/windows/find_tools.rs":"dd6b2450909cd8334a2aa2c=
e856bcc72a9654d92422267d6345d5fabfcbf57c5","src/windows/mod.rs":"34cfa201cf=
bcac7ccaa3ea5295d3e4200439af3cc5c6433baf81502596040a89","src/windows/regist=
ry.rs":"c521b72c825e8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","=
src/windows/setup_config.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131c=
ee2df13c0e996dbbec8","src/windows/vs_instances.rs":"946527cf8fd32c3472f6a28=
84dcdec290763101097334c7478f9c24c3950db6b","src/windows/winapi.rs":"250d51c=
1826d1a2329e9889dd9f058cfce253dbf2a678b076147c6cdb5db046c","src/windows/win=
dows_sys.rs":"e2714c8307bfa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e3=
4b8","src/windows/windows_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d09=
4b7bec217264ba2e6e2c49d1ccee"},"package":"9540e661f81799159abee814118cc139a=
2004b3a3aa3ea37724a1b66530b90e0"}
-\ No newline at end of file
-+{"files":{"CHANGELOG.md":"92aeb6dec3e4b55e3951a4d00f6df20edc51545afca124d=
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
diff --git a/recipes-devtools/rust/files/revert-link-std-statically-in-rust=
c_driver-feature.patch b/recipes-devtools/rust/files/revert-link-std-static=
ally-in-rustc_driver-feature.patch
index 9bbbce0..3f92014 100644
--- a/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_drive=
r-feature.patch
+++ b/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_drive=
r-feature.patch
@@ -43,14 +43,16 @@ index 39fa23766b..51d86b4009 100644
  use rustc_hir::def_id::{CrateNum, LOCAL_CRATE};
  use rustc_index::IndexVec;
  use rustc_middle::bug;
-@@ -161,44 +161,19 @@ fn calculate_type(tcx: TyCtxt<'_>, ty: CrateType) ->=
 DependencyList {
+@@ -159,46 +159,19 @@ fn calculate_type(tcx: TyCtxt<'_>, ty: CrateType) ->=
 DependencyList {
          }
          Linkage::Dynamic | Linkage::IncludedFromDylib =3D> {}
      }
 -
 -    let all_dylibs =3D || {
 -        tcx.crates(()).iter().filter(|&&cnum| {
--            !tcx.dep_kind(cnum).macros_only() && tcx.used_crate_source(cn=
um).dylib.is_some()
+-            !tcx.dep_kind(cnum).macros_only()
+-                && (tcx.used_crate_source(cnum).dylib.is_some()
+-                    || tcx.used_crate_source(cnum).sdylib_interface.is_so=
me())
 -        })
 -    };
 -
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-d=
evtools/rust/files/rust-oe-selftest.patch
index b7ef806..547807f 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -119,7 +119,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  fn test_get_mut_poison() {
      let mut m =3D new_poisoned_rwlock(NonCopy(10));
=20=20
-@@ -567,6 +576,7 @@
+@@ -571,6 +571,7 @@
=20=20
  #[test]
  #[cfg_attr(not(panic =3D "unwind"), ignore =3D "test requires unwinding s=
upport")]
@@ -130,7 +130,7 @@ index 1a9d3d3f12f..0a9cfc48806 100644
 diff --git a/library/test/src/tests.rs b/library/test/src/tests.rs
 --- a/library/test/src/tests.rs
 +++ b/library/test/src/tests.rs
-@@ -424,6 +424,7 @@
+@@ -414,6 +414,7 @@
  }
=20
  #[test]
@@ -173,7 +173,7 @@ diff --git a/compiler/rustc_data_structures/src/tagged_=
ptr/tests.rs b/compiler/r
 index 160af8a65d..686f4607bb 100644
 --- a/compiler/rustc_data_structures/src/tagged_ptr/tests.rs
 +++ b/compiler/rustc_data_structures/src/tagged_ptr/tests.rs
-@@ -5,6 +5,7 @@ use crate::stable_hasher::{HashStable, StableHasher};
+@@ -39,6 +39,7 @@ use crate::stable_hasher::{HashStable, StableHasher};
  }
=20
  #[test]
@@ -185,19 +185,19 @@ diff --git a/library/std/tests/thread_local/tests.rs =
b/library/std/tests/thread_
 index 9d4f52a092..d425e5f7b7 100644
 --- a/library/std/tests/thread_local/tests.rs
 +++ b/library/std/tests/thread_local/tests.rs
-@@ -346,6 +346,7 @@ fn join_orders_after_tls_destructors() {
-
- // Test that thread::current is still available in TLS destructors.
+@@ -363,6 +363,7 @@ fn join_orders_after_tls_destructors() {
+ // ** musl: https://github.com/kraj/musl/blob/1880359b54ff7dd9f5016002bfd=
ae4b136007dde/src/thread/pthread_key_create.c#L87
+ #[cfg(target_thread_local)]
  #[test]
 +#[ignore]
  fn thread_current_in_dtor() {
-     // Go through one round of TLS destruction first.
-     struct Defer;
+     use std::thread::Builder;
+
 diff --git a/library/alloctests/tests/sort/tests.rs b/library/alloctests/t=
ests/sort/tests.rs
 index 14e6013f96..b670f27ab4 100644
 --- a/library/alloctests/tests/sort/tests.rs
 +++ b/library/alloctests/tests/sort/tests.rs
-@@ -915,12 +915,14 @@ gen_sort_test_fns_with_default_patterns_3_ty!(
+@@ -922,12 +922,14 @@ gen_sort_test_fns_with_default_patterns_3_ty!(
  macro_rules! instantiate_sort_test_inner {
      ($sort_impl:ty, miri_yes, $test_fn_name:ident) =3D> {
          #[test]
@@ -239,7 +239,7 @@ index 5b8e5ff4f4a..e558fbd7bd7 100644
 +
  //@ only-linux
  //@ aux-build:dwarf-mixed-versions-lto-aux.rs
- //@ compile-flags: -C lto -g -Zdwarf-version=3D5
+ //@ compile-flags: -C lto -g -Cdwarf-version=3D5
 diff --git a/tests/codegen/dont-shuffle-bswaps.rs b/tests/codegen/dont-shu=
ffle-bswaps.rs
 index 0e712bc3a4e..93965d990d0 100644
 --- a/tests/codegen/dont-shuffle-bswaps.rs
@@ -250,7 +250,7 @@ index 0e712bc3a4e..93965d990d0 100644
 +//@ only-arm
 +//@ only-aarch64
 +
- //@ revisions: OPT2 OPT3
+ //@ revisions: OPT2 OPT3 OPT3_S390X
  //@[OPT2] compile-flags: -Copt-level=3D2
  //@[OPT3] compile-flags: -C opt-level=3D3
 diff --git a/tests/codegen/uninhabited-transparent-return-abi.rs b/tests/c=
odegen/uninhabited-transparent-return-abi.rs
@@ -280,3 +280,29 @@ index 57027364699..3faa7ea035e 100644
  // We used to not handle all "rustic" ABIs in a (relatively) uniform way,
  // so we failed to fix up arguments for actually passing through the ABI.=
..
  #![feature(rust_cold_cc)]
+diff --git a/tests/codegen/simd/extract-insert-dyn.rs b/tests/codegen/simd=
/extract-insert-dyn.rs
+index 729f0145314..1b21356518e 100644
+--- a/tests/codegen/simd/extract-insert-dyn.rs
++++ b/tests/codegen/simd/extract-insert-dyn.rs
+@@ -1,3 +1,8 @@
++//@ only-x86
++//@ only-x86_64
++//@ only-arm
++//@ only-aarch64
++
+ //@compile-flags: -C opt-level=3D3 -C no-prepopulate-passes
+
+ #![feature(
+diff --git a/tests/codegen/const-vector.rs b/tests/codegen/const-vector.rs
+index 42921442e03..af0edc2ee92 100644
+--- a/tests/codegen/const-vector.rs
++++ b/tests/codegen/const-vector.rs
+@@ -1,3 +1,8 @@
++//@ only-x86
++//@ only-x86_64
++//@ only-arm
++//@ only-aarch64
++
+ //@ revisions: OPT0 OPT0_S390X
+ //@ [OPT0] ignore-s390x
+ //@ [OPT0_S390X] only-s390x
diff --git a/recipes-devtools/rust/libstd-rs_1.87.0.bb b/recipes-devtools/r=
ust/libstd-rs_1.88.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.87.0.bb
rename to recipes-devtools/rust/libstd-rs_1.88.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.87.0.bb b/recipes-=
devtools/rust/rust-cross-canadian_1.88.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.87.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.88.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.87.0.bb b/recipes-devtools/r=
ust/rust-llvm_1.88.0.bb
similarity index 99%
rename from recipes-devtools/rust/rust-llvm_1.87.0.bb
rename to recipes-devtools/rust/rust-llvm_1.88.0.bb
index d70aa35..5ecc34a 100644
--- a/recipes-devtools/rust/rust-llvm_1.87.0.bb
+++ b/recipes-devtools/rust/rust-llvm_1.88.0.bb
@@ -4,7 +4,7 @@ HOMEPAGE =3D "http://www.rust-lang.org"
=20
 # check src/llvm-project/llvm/CMakeLists.txt for llvm version in use
 #
-LLVM_RELEASE =3D "20.1.1"
+LLVM_RELEASE =3D "20.1.5"
=20
 require rust-source.inc
=20
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rus=
t/rust-snapshot.inc
index 87b39a2..76ec809 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,56 +4,56 @@
 ## The exact (previous) version that has been used is specified in the sou=
rce tarball.
 ## The version is replicated here.
=20
-SNAPSHOT_VERSION =3D "1.86.0"
+SNAPSHOT_VERSION =3D "1.87.0"
=20
-SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "ccece9e59546d2e6ff3fc3b8f4b=
033aab21631c271eefbe814b3cbace6628c6e"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "176129577a5d560bbd94bcd2=
d24c0228bb495b73219df02556b4e4b4f0815bf7"
-SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "37156542b702e8b4ffd1c5c7501=
7632582343e93ca378285cdc92196c85c77e3"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "e70edcf560e6b50861618d7045=
d2b38cae9e2a555f489062570e2e7041563f42"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "93c59a880632aa1c69e3ffaa183=
0b5b19c08341ae2cd364bf4e6d13901facfed"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "80fab79c1f57b7cd89a1e637=
9b2196a208352403aa7bd7f674341a172ac0697f"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "51e237e7f383840a404a5be7214=
91a8ca4671bf9c14e62566ecadccfcc6e4291"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "38b5bb919b5e256cc8bed5b69e=
ecca577677ccb404fdd7bc3a9f2f79bede1a50"
=20
-SRC_URI[rustc-snapshot-i686.sha256sum] =3D "976f4604d949d722738a9fe9531303=
5226571128396e942b0fc678180be487b0"
-SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "ce9f0fa4b0760730e26bf315ceb=
e099f0b883436e095c5fc4b94ba20bd9f121a"
-SRC_URI[cargo-snapshot-i686.sha256sum] =3D "24f20bdc1bb14f4ffbdc2f540488be=
bc3340437418725c3162215ae03cdad480"
-SRC_URI[clippy-snapshot-i686.sha256sum] =3D "6788449fa0eceebe4ea8c797bbaf2=
7495dad152087b3085d58dc05cacab0617a"
+SRC_URI[rustc-snapshot-i686.sha256sum] =3D "e59bb135589f8ca062e63ec244f61a=
4226fa348de5221fa96e9350f3e28a5fd1"
+SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "df2bcaa75c9bfec12b4d0b43112=
c90647383865871cd0ea19f4af16b8942ac9f"
+SRC_URI[cargo-snapshot-i686.sha256sum] =3D "840baaa8d99087b4fbb67c57cf0687=
f53b51f387b0c44ea206d5c6262114c9ed"
+SRC_URI[clippy-snapshot-i686.sha256sum] =3D "fbaf630b50109512573152d667977=
60933a1aa44e4ab2056c39e2e5ef457ffd9"
=20
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "970089ad61f8ca82017b594=
44aee483c1fc005e3f7a6af63cd5f146df8287cce"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "2f528377f57fbf81da35=
e2f08ec7ba50daddabebdce2cc86b6ec909fee157a33"
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "c3b8ab03b64c824f2ea25db=
578b5760d44302be3fd1e4a78404c98cba39301f4"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "1ab711423497a1d02408a2=
40da28ad366450574dd7f528ffaee80d1d5ed10550"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "21f2e20d2dab04683f24771=
a4a1ba81500bf2d876b3f8e134b6f39ba88cafc33"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "333cf7f4328c13e2ea0d=
05fa87ee0509d63c57bab570b685c891fe6113e6d36a"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "ae613f51e848f09e2e2b079=
b0036f07beee965a3a15f80b39ec1f791c72c6a8f"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "7825d8bc9ab68f2015a1b4=
32b26aad9f208b6293369a67887d2a2f8b5cabfb01"
=20
-SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "21ea61181ba7daa04f61bec6a29=
5ad76ce34bfbd74ad1d679c4548977bd82eb9"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "e5ed58a861619bcc89fc3f96=
9174c84fd6ed8a26b5d4b196f06efb868653c1c1"
-SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "fd832c269af81dd1ee9f3831991=
fccdc2c7312e9a9069908510eefe7c313d144"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "c94578d31e4145a4169ab57615=
37a2a0133818278fb62ee76251ef8ef45228c8"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "a650e3d8701c5916893845f5cea=
e1eb0bf9714ac608ef304976a9ee2ace16caf"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "df327566871a7595efc393e8=
fec9cd529615d4296727a228625cffd67a322126"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "b6ffefdf0c1bc00880aae0a2a4f=
c038e1412b7df364c8f601b63ca3589ef9e76"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "53307af7138bf26b8cd5da2057=
c2642830969b4482560c9fb1c229d984d8abdb"
=20
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "a54bbe16e6a405f137a0dc51f=
d570140c80077ba769d29d885a60e74cb3196bb"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "06538b41a9351c449d2154=
98d4ec2f072f728bd18df8fac7ef8534a0d0f34e27"
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "4d398cd8da17d1a5f26734b39=
cb17e791b243ac3570f8da2e5e5580a9dfad578"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "0abf31a8cb2762a7a81dbee8=
a5798e43e11a83326711ce00ad16c5587bcf5e49"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "96c0a3d1a6f1c3d9ac677187a=
f6837e1b0fb782a270762741d02b5c299c62d77"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "4a69e1a021ddd0c645fe7b=
ee229a4db306c08a6f4976dc5eaf64bf95a810f7c2"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "c3992ae2b799941acd2956197=
8115315ccc31fae851d23c7ac93c716b7b10ad7"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "7f968106335bb20b944ad0ff=
988ebe918b62a923d8f5fcfe8a998583ea22cebd"
=20
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "7585a20b02b7dd497e393a2=
e7552a0c6aabb51556fcf7507c6f7ffde530f8c88"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "fcf940c0553a04cb9bd8=
5cce524729c2f54b000b554fee95c7aa218d608b7e3d"
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "8fefd2317023716a018986c=
4a62558a7b543ccf34e4e6d1104afc66edcae1c9c"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "8cc65649396ccad73cecd1=
7b972ab8d4c34837136cf374425be63d697b541469"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "b861d2ccaa379261d7a0533=
1b25971687a9d90efbab14c58829b78abe3add2e6"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "73ed9c6ef539095cdca4=
e41b789b4e47effce6f796be73542f86cb9d5855a9ea"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "2b9ef59c3c1818d6712ea4e=
c8af53720a0c2017ace80a15c287f05768ac04e0a"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "1dd6d1622f4e8fe33af90f=
4fca7851757fe2856248c36d79fdef38abc81f98b2"
=20
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "4d1106b576221182f84412f33=
77a5148eab6950d20e45e4274cd8b58df46f26b"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "b28b9c2f183521a204f289=
9610253c11c86ee4aa903fe66d8410dfaa22c926e6"
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "7825556908e10a48320cfb2d8=
12851271d7cf549977173e028a0dd23af9d7eac"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "c39c53a82fdaaa97413728a4=
f3f9feb5b31bdf3e3e563c64651bd01713e79166"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "45708d5767ecd589ec852068d=
c0e0afb27427e7e9e03b4586f2cb75673f885b6"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "71f3a9dee3955255cd25ea=
4b15fe664284ac89591bc920667b9e47ff37f330fd"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "ced9e08041d4d246115933665=
37f3f14db63cede6a4d65c1297853b72c7b72d9"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "8d3665a04ecf3191196998f7=
aeb94cd6cdafba9200345387d854101629f94fe6"
=20
-SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "18caf22fbfc4d26c80b39b4c6b1cd=
5fb42dba3e32d5d3600c22eae6f688d7f4c"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "3919f6962d0aefdd2cd75d8dba=
749ed826936065b64c9a8d54d1d85c2685fd66"
-SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "1c6eb1be254574881a611a3b8904c=
dcfe43c79a285875673e59c890dcd5766c2"
-SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "c87183b52ddb4085ddf2524a775f=
d255d5fd11ad2fdd6424574f08750a8cf378"
+SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "4b961ed0731f0f4f3c1270c165519=
8a01269e6e4ca129bf1b975114e3bde511e"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "9fb2a2ceb9671ab74ccceb61c5=
763c591eb1be21584b944ad7e5458edab171c9"
+SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "73402a5585c32bdc80ace0070cec6=
95768395fcc85efa0843ca42a453034a953"
+SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "bab8cff53f93466c77d2f17b0071=
32c77cf782314bfc6c3d897dc0fc1e4e6375"
=20
-SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "4438b809ce4a083af31ed17aeeed=
cc8fc60ccffc0625bef1926620751b6989d7"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "67be7184ea388d8ce0feaf7fd=
ea46f1775cfc2970930264343b3089898501d37"
-SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "c5c1590f7e9246ad9f4f97cfe26f=
fa92707b52a769726596a9ef81565ebd908b"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "02aaff2c1407d2da8dba19aa497=
0dd873e311902b120a66cbcdbe51eb8836edf"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "e8395c5c5756253b76107055e093=
ffbc4431af7b30aeebe72ce2684b9cb53973"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "1b57253bd32b8b292c965b3a2=
d992a266763158494cab8555584c09360b90f77"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "469d5dc479835adadd728bc3587f=
8abf1941b3dd71f9865abd3e0783ae662555"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "9d440eef6811112a000acf96a06=
2df7bcbc013fa4f8e00a7f9a4f57ef90637a1"
=20
-SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "f0bddc6dba7d719b8ba131bcd63=
4a8379e00fc825a51c0f17abf424c9cb5c052"
+SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "fc656140b5810a1bfa3b80456e4=
16a0381dd68c565fc67fd23f945f8df80254b"
=20
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "722238ae13e6e101d1b698d2=
b3a7915d59bb7f485b594e8d833cce8b9460383b"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "2a7f654b1c31cb60b4841bf0=
a041a2fcdec9baecf8bb0f9ae1d1743862073907"
=20
 SRC_URI +=3D " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-s=
napshot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index 38d261e..cc8e47b 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -11,7 +11,7 @@ SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${R=
UST_VERSION}-src.tar.xz;n
             file://0001-Disable-libunwind-cross-architecture-unwinding.pat=
ch;patchdir=3D${RUSTSRC} \
             file://triagebot.patch;patchdir=3D${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] =3D "8623b8651893e8c6aebfa45b6a90645a4f652f7b18189=
a0992a90d11ac2631f4"
+SRC_URI[rust.sha256sum] =3D "0c1dcbb4f762513d021e1a282c0ac58c0a423642b3a6b=
f581cafb5414df4193e"
=20
 RUSTSRC =3D "${WORKDIR}/rustc-${RUST_VERSION}-src"
=20
diff --git a/recipes-devtools/rust/rust_1.87.0.bb b/recipes-devtools/rust/r=
ust_1.88.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.87.0.bb
rename to recipes-devtools/rust/rust_1.88.0.bb
--=20
2.50.1


