Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC4EC369A4
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:15 +0000 (UTC)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web11.59621.1744061469312962266
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:31:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Nvm07kW+;
 spf=pass (domain: konsulko.com, ip: 209.85.166.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85e751cffbeso381920239f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061468; x=1744666268; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3h7iM0z3Ljh0sZVxUe3XFryZgif/xUJ1SkWM11vaQSE=;
        b=Nvm07kW+A4RLZmyDKQcioGQstLCH2if0riRsfTGqHijrQbAGuYOCZ/8knZDfRzm65R
         CkSKst+jxtXisSEJPW21pG7AffSbQYIKMkli9aRP55JTG4dFlpBTP4ddWi7I/R5onJma
         4znz3hIUDOL4iMd9WrvcyzWvAG+4+/jE5he5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061468; x=1744666268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3h7iM0z3Ljh0sZVxUe3XFryZgif/xUJ1SkWM11vaQSE=;
        b=o3RyBlaVyQoB6JEDIcH7JZH6FBJY2ZO9Byo9mbFZd01SWg05426RpP6Z9Y23/69z1q
         wQd9MuE7Fn/n5P7WNxOjXD0sl4sIV5soIXRrRKlrbZBJqrmDJUzkUO1CdgYANKo2cBEH
         DtfXizIBWsrWM4K99KwO2oMtVg/+YVpYhROZ/gmrOF1Z2mkAp/YeKTHlE4qyIsIfRzEr
         fpN9HgrJBnRVCf8/27htn8a49hCaYV6FlvLngWX6JZ3FJM6ju9gcymyYYj4iakFyy7L4
         bw5hKDPcnmTYpK2fcPVDeAqfdIeSRrfUtovvYKLNGH2exhO2ffaaOBSOMT8yL7BDhlEg
         Qf2w==
X-Gm-Message-State: AOJu0YyPpKjzgIXTWg4vBo2PGOSeV+cZaPqI5ytUqS02AjMwy9Rld0L/
	jFkI76nz+3H8TOzPaK5k0XQVOkg5uC+KVHPU+2e1ysI3y1P6bmwdLtFavp54mn7K7cx6m6LqxOF
	JwH4=
X-Gm-Gg: ASbGncvzKw13nb+VboHGShfi13w8stbjM0x//FZxJfxt8qqKB4Jsr+LE2GRl4PboPl/
	XtOzTaOvCuphd0OEZG3CFIkN92nfKrLrgL6S4Y1qmU+btI4y11Xarn5Ud22Pa24uu9UHjmjLgPf
	UUnkOY2s6gGZsSpBEE7odowPh7DvShdo50rsbbknBbFvi0VDIa0WU8ki3YHxRJfeGJCA1i5BCCg
	eW93xC1YJpIOncQj7ixf39pyw4Mm+9bxi7tD3J2qveSLcqGGxItgqnnt8BgWuT/PhTYveuFtYH7
	nn2Z9Yu/j0EaW889tKClPie5wPDBHGNvkELlInR5lGDQJfo1oLckNJ77jfpdIPEGfj0JGRORXPy
	hqtBlkkEacSIU0jqzsq2o
X-Google-Smtp-Source: AGHT+IHJi+zbQrB3njMBZOYeKWBiF9o7pwi9gjWONsgsXqBM8UAY6DRTRlsHYK9ETsXBxpVdmgJSEQ==
X-Received: by 2002:a05:6602:1516:b0:85d:115b:bb3f with SMTP id ca18e2360f4ac-8611b40de43mr1595183339f.6.1744061466317;
        Mon, 07 Apr 2025 14:31:06 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.31.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:31:05 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 27/29] rust: Upgrade 1.84.1->1.85.0
Date: Mon,  7 Apr 2025 17:30:16 -0400
Message-ID: <b6e2c06fd45f7796a34b52e5ce57e2110749ca7d.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1329

From: Yash Shinde <Yash.Shinde@windriver.com>

Rust stable version updated to 1.85.0
https://blog.rust-lang.org/2025/02/20/Rust-1.85.0.html

Some of the major updates:

- Update LIC_FILES_CHKSUM in libstd-rs and rust recipes.
License-Update: Unicode license text is updated to Unicode-3.0 License.
https://github.com/rust-lang/rust/commit/6d2a3e9786ec43a0e0af20386e70463282=
96ac86
[RP: Update LICENSE to reference Unicode-3.0]

- Pass '-Zforce-unstable-if-unmarked' to RUSTFLAGS in libstd-rs.bb
Fix: https://github.com/rust-lang/rust/issues/133857#issuecomment-2526341227

- Downgrade bootstrap cc version causing bootstrap to fail on custom target=
s. (Backported from v1.85.1)
Fix: https://github.com/rust-lang/rust/pull/137460/commits/e4ca11f87ffca8c6=
3aa56d45b46e62b6acc58bd7

- Explicitly set float ABI for all ARM 32 bits targets.
Fix: https://github.com/rust-lang/rust/commit/a51fefcaab835b310e2e26005b509=
82d0049d905

- Rust v1.85.0 tarball doesn't ship gcc tree.
Drop "remove_gcc_directory" postfunc which removed it and prevented the blo=
at.
Fix: https://github.com/rust-lang/rust/commit/13c3f9b9498013837782b46120085=
ea19ca75518

Adapted the patch changes with v1.85.0:
  repro-issue-fix-with-cc-crate-hashmap.patch
  revert-link-std-statically-in-rustc_driver-feature.patch
  rust-oe-selftest.patch
  rv32-cargo-rustix-0.38.40-fix.patch

Dropped patches:
  fix-tidy-check-failure.patch since it's merged with v1.85.0.

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 3130069fdebb92f20b962fa8074564a27c3fb6b9)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass     |   5 +
 conf/layer.conf                               |   4 +-
 files/common-licenses/Unicode-3.0             |  39 +++
 .../rust/{cargo_1.84.1.bb =3D> cargo_1.85.0.bb} |   0
 .../rust/files/downgrade-bootstrap-cc.patch   |  41 +++
 .../rust/files/fix-tidy-check-failure.patch   |  19 --
 ...epro-issue-fix-with-cc-crate-hashmap.patch |  60 ++++-
 ...d-statically-in-rustc_driver-feature.patch |   4 +-
 .../rust/files/rust-oe-selftest.patch         |  46 ++--
 .../files/rv32-cargo-rustix-0.38.38-fix.patch | 236 ------------------
 .../files/rv32-cargo-rustix-0.38.40-fix.patch | 236 ++++++++++++++++++
 ...ibstd-rs_1.84.1.bb =3D> libstd-rs_1.85.0.bb} |   4 +-
 ....84.1.bb =3D> rust-cross-canadian_1.85.0.bb} |   0
 ...ust-llvm_1.84.1.bb =3D> rust-llvm_1.85.0.bb} |   0
 recipes-devtools/rust/rust-snapshot.inc       |  81 +++---
 recipes-devtools/rust/rust-source.inc         |  23 +-
 .../rust/{rust_1.84.1.bb =3D> rust_1.85.0.bb}   |   4 +-
 17 files changed, 459 insertions(+), 343 deletions(-)
 create mode 100644 files/common-licenses/Unicode-3.0
 rename recipes-devtools/rust/{cargo_1.84.1.bb =3D> cargo_1.85.0.bb} (100%)
 create mode 100644 recipes-devtools/rust/files/downgrade-bootstrap-cc.patch
 delete mode 100644 recipes-devtools/rust/files/fix-tidy-check-failure.patch
 delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.38-f=
ix.patch
 create mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-f=
ix.patch
 rename recipes-devtools/rust/{libstd-rs_1.84.1.bb =3D> libstd-rs_1.85.0.bb=
} (88%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.84.1.bb =3D> rust-cros=
s-canadian_1.85.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.84.1.bb =3D> rust-llvm_1.85.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust_1.84.1.bb =3D> rust_1.85.0.bb} (99%)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rus=
t-target-config.bbclass
index 67aaa56..c04940c 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -391,6 +391,11 @@ def rust_gen_target(d, thing, wd, arch):
     tspec['cpu'] =3D cpu
     if features !=3D "":
         tspec['features'] =3D features
+    fpu =3D d.getVar('TARGET_FPU')
+    if fpu =3D=3D "soft":
+        tspec['llvm-floatabi'] =3D "soft"
+    elif fpu =3D=3D "hard":
+        tspec['llvm-floatabi'] =3D "hard"
     tspec['dynamic-linking'] =3D True
     tspec['executables'] =3D True
     tspec['linker-is-gnu'] =3D True
diff --git a/conf/layer.conf b/conf/layer.conf
index 3a7b1a6..15975bf 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -13,4 +13,6 @@ LAYERSERIES_COMPAT_scarthgap-rust-mixin =3D "scarthgap"
=20
 LAYERDEPENDS_scarthgap-rust-mixin =3D "core"
=20
-RUSTVERSION ?=3D "1.84.1%"
+LICENSE_PATH +=3D "${LAYERDIR}/files/common-licenses"
+
+RUSTVERSION ?=3D "1.85.0%"
diff --git a/files/common-licenses/Unicode-3.0 b/files/common-licenses/Unic=
ode-3.0
new file mode 100644
index 0000000..11f2842
--- /dev/null
+++ b/files/common-licenses/Unicode-3.0
@@ -0,0 +1,39 @@
+UNICODE LICENSE V3
+
+COPYRIGHT AND PERMISSION NOTICE
+
+Copyright =C2=A9 1991-2023 Unicode, Inc.
+
+NOTICE TO USER: Carefully read the following legal agreement. BY
+DOWNLOADING, INSTALLING, COPYING OR OTHERWISE USING DATA FILES, AND/OR
+SOFTWARE, YOU UNEQUIVOCALLY ACCEPT, AND AGREE TO BE BOUND BY, ALL OF THE
+TERMS AND CONDITIONS OF THIS AGREEMENT. IF YOU DO NOT AGREE, DO NOT
+DOWNLOAD, INSTALL, COPY, DISTRIBUTE OR USE THE DATA FILES OR SOFTWARE.
+
+Permission is hereby granted, free of charge, to any person obtaining a
+copy of data files and any associated documentation (the "Data Files") or
+software and any associated documentation (the "Software") to deal in the
+Data Files or Software without restriction, including without limitation
+the rights to use, copy, modify, merge, publish, distribute, and/or sell
+copies of the Data Files or Software, and to permit persons to whom the
+Data Files or Software are furnished to do so, provided that either (a)
+this copyright and permission notice appear with all copies of the Data
+Files or Software, or (b) this copyright and permission notice appear in
+associated Documentation.
+
+THE DATA FILES AND SOFTWARE ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
+KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF
+THIRD PARTY RIGHTS.
+
+IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS INCLUDED IN THIS NOTICE
+BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES,
+OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
+WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
+ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THE DATA
+FILES OR SOFTWARE.
+
+Except as contained in this notice, the name of a copyright holder shall
+not be used in advertising or otherwise to promote the sale, use or other
+dealings in these Data Files or Software without prior written
+authorization of the copyright holder.
diff --git a/recipes-devtools/rust/cargo_1.84.1.bb b/recipes-devtools/rust/=
cargo_1.85.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.84.1.bb
rename to recipes-devtools/rust/cargo_1.85.0.bb
diff --git a/recipes-devtools/rust/files/downgrade-bootstrap-cc.patch b/rec=
ipes-devtools/rust/files/downgrade-bootstrap-cc.patch
new file mode 100644
index 0000000..3ae6872
--- /dev/null
+++ b/recipes-devtools/rust/files/downgrade-bootstrap-cc.patch
@@ -0,0 +1,41 @@
+Downgrade bootstrap cc version
+
+In rust v1.85.0, the upgraded cc version causes bootstrap
+to fail on custom targets. Downgrading the cc version fixes
+the error. This commit is merged with v1.85.1 and the patch
+can be dropped when upgraded to it.
+
+Upstream-Status: Backport [https://github.com/rust-lang/rust/pull/137460/c=
ommits/e4ca11f87ffca8c63aa56d45b46e62b6acc58bd7]
+
+Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
+diff --git a/src/bootstrap/Cargo.lock b/src/bootstrap/Cargo.lock
+index a47f3af60cb..890e64e2bab 100644
+--- a/src/bootstrap/Cargo.lock
++++ b/src/bootstrap/Cargo.lock
+@@ -88,9 +88,9 @@ dependencies =3D [
+
+ [[package]]
+ name =3D "cc"
+-version =3D "1.2.0"
++version =3D "1.1.22"
+ source =3D "registry+https://github.com/rust-lang/crates.io-index"
+-checksum =3D "1aeb932158bd710538c73702db6945cb68a8fb08c519e6e12706b94263b=
36db8"
++checksum =3D "9540e661f81799159abee814118cc139a2004b3a3aa3ea37724a1b66530=
b90e0"
+ dependencies =3D [
+  "shlex",
+ ]
+diff --git a/src/bootstrap/Cargo.toml b/src/bootstrap/Cargo.toml
+index ed51862390d..2c1d85b01e6 100644
+--- a/src/bootstrap/Cargo.toml
++++ b/src/bootstrap/Cargo.toml
+@@ -37,7 +37,9 @@ test =3D false
+ # Most of the time updating these dependencies requires modifications to =
the
+ # bootstrap codebase(e.g., https://github.com/rust-lang/rust/issues/12456=
5);
+ # otherwise, some targets will fail. That's why these dependencies are ex=
plicitly pinned.
+-cc =3D "=3D1.2.0"
++#
++# Do not upgrade this crate unless https://github.com/rust-lang/cc-rs/iss=
ues/1317 is fixed.
++cc =3D "=3D1.1.22"
+ cmake =3D "=3D0.1.48"
+
+ build_helper =3D { path =3D "../build_helper" }
diff --git a/recipes-devtools/rust/files/fix-tidy-check-failure.patch b/rec=
ipes-devtools/rust/files/fix-tidy-check-failure.patch
deleted file mode 100644
index 54b4ee6..0000000
--- a/recipes-devtools/rust/files/fix-tidy-check-failure.patch
+++ /dev/null
@@ -1,19 +0,0 @@
-fix a comment with uneven number of backticks in rustc_mir_build
-
-Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/8e7734=
978245522cbbd14e53e08e888faf031ded]
-
-Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
----
-diff --git a/compiler/rustc_mir_build/src/build/expr/as_rvalue.rs b/compil=
er/rustc_mir_build/src/build/expr/as_rvalue.rs
-index 3f89e33778..c66af11845 100644
---- a/compiler/rustc_mir_build/src/build/expr/as_rvalue.rs
-+++ b/compiler/rustc_mir_build/src/build/expr/as_rvalue.rs
-@@ -231,7 +231,7 @@ impl<'a, 'tcx> Builder<'a, 'tcx> {
-                             if range.start <=3D range.end { BinOp::BitAnd=
 } else { BinOp::BitOr };
-
-                         let mut comparer =3D |range: u128, bin_op: BinOp|=
 -> Place<'tcx> {
--                            // We can use `ty::TypingEnv::fully_monomorph=
ized()`` here
-+                            // We can use `ty::TypingEnv::fully_monomorph=
ized()` here
-                             // as we only need it to compute the layout o=
f a primitive.
-                             let range_val =3D Const::from_bits(
-                                 this.tcx,
diff --git a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hash=
map.patch b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashm=
ap.patch
index 045728e..911c560 100644
--- a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
+++ b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
@@ -8,6 +8,62 @@ https://github.com/rust-lang/cc-rs/pull/1277
=20
 Upstream-Status: Submitted [https://github.com/rust-lang/cc-rs/pull/1277]
 Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
+diff --git a/vendor/cc-1.2.0/src/command_helpers.rs b/vendor/cc-1.2.0/src/=
command_helpers.rs
+index fe919a5239..2b1f442019 100644
+--- a/vendor/cc-1.2.0/src/command_helpers.rs
++++ b/vendor/cc-1.2.0/src/command_helpers.rs
+@@ -289,6 +289,7 @@
+ /// and store them in the output Object.
+ pub(crate) fn objects_from_files(files: &[Arc<Path>], dst: &Path) -> Resu=
lt<Vec<Object>, Error> {
+     let mut objects =3D Vec::with_capacity(files.len());
++    let target_substring =3D ["rustc"];
+     for file in files {
+         let basename =3D file
+             .file_name()
+@@ -309,6 +310,26 @@
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
++
+         // Hash the dirname. This should prevent conflicts if we have mul=
tiple
+         // object files with the same filename in different subfolders.
+         let mut hasher =3D hash_map::DefaultHasher::new();
+@@ -326,7 +347,7 @@
+             dirname
+         };
+
+-        hasher.write(dirname.as_bytes());
++        hasher.write(filtered_dirname.as_bytes());
+         let obj =3D dst
+             .join(format!("{:016x}-{}", hasher.finish(), basename))
+             .with_extension("o");
+diff --git a/vendor/cc-1.2.0/.cargo-checksum.json b/vendor/cc-1.2.0/.cargo=
-checksum.json
+index b070eeb322..ba768ff86f 100644
+--- a/vendor/cc-1.2.0/.cargo-checksum.json
++++ b/vendor/cc-1.2.0/.cargo-checksum.json
+@@ -1 +1 @@
+-{"files":{"CHANGELOG.md":"fb0a3bcb34301d2578bef86feabe93057068cb1906a7f10=
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
+\ No newline at end of file
++{"files":{"CHANGELOG.md":"fb0a3bcb34301d2578bef86feabe93057068cb1906a7f10=
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
 diff --git a/vendor/cc-1.0.99/src/command_helpers.rs b/vendor/cc-1.0.99/sr=
c/command_helpers.rs
 index fe919a5239..2b1f442019 100644
 --- a/vendor/cc-1.0.99/src/command_helpers.rs
@@ -99,7 +155,7 @@ index b070eeb322..ba768ff86f 100644
 --- a/vendor/cc-1.0.99/.cargo-checksum.json
 +++ b/vendor/cc-1.0.99/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{"Cargo.toml":"3c555dbe1a698f12b66c8a5748ed52ff26ff7b8ebb12237c1=
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
+-{"files":{"Cargo.lock":"1dc698513383b70d5460f3f9668b670bc72ce51ff6be79d13=
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
 diff --git a/vendor/cc-1.1.22/.cargo-checksum.json b/vendor/cc-1.1.22/.car=
go-checksum.json
@@ -107,6 +163,6 @@ index 8c7be07836..473b5ad39c 100644
 --- a/vendor/cc-1.1.22/.cargo-checksum.json
 +++ b/vendor/cc-1.1.22/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{"CHANGELOG.md":"92aeb6dec3e4b55e3951a4d00f6df20edc51545afca124d=
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
+-{"files":{"CHANGELOG.md":"92aeb6dec3e4b55e3951a4d00f6df20edc51545afca124d=
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
 \ No newline at end of file
 +{"files":{"CHANGELOG.md":"92aeb6dec3e4b55e3951a4d00f6df20edc51545afca124d=
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
index 0ba0921..20a49d4 100644
--- a/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_drive=
r-feature.patch
+++ b/recipes-devtools/rust/files/revert-link-std-statically-in-rustc_drive=
r-feature.patch
@@ -40,9 +40,9 @@ index 39fa23766b..51d86b4009 100644
=20
 -use rustc_data_structures::fx::{FxHashMap, FxHashSet};
 +use rustc_data_structures::fx::FxHashMap;
- use rustc_hir::def_id::CrateNum;
+ use rustc_hir::def_id::{CrateNum, LOCAL_CRATE};
+ use rustc_index::IndexVec;
  use rustc_middle::bug;
- use rustc_middle::middle::dependency_format::{Dependencies, DependencyLis=
t, Linkage};
 @@ -161,44 +161,19 @@ fn calculate_type(tcx: TyCtxt<'_>, ty: CrateType) ->=
 DependencyList {
          }
          Linkage::Dynamic | Linkage::IncludedFromDylib =3D> {}
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-d=
evtools/rust/files/rust-oe-selftest.patch
index 7e5854a..2cca850 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -150,26 +150,26 @@ index ac1a804cf9c..7c687982324 100644
  fn oneshot_multi_thread_recv_close_stress() {
      for _ in 0..stress_factor() {
          let (tx, rx) =3D channel::<i32>();
-diff --git a/library/std/src/sync/mutex/tests.rs b/library/std/src/sync/mu=
tex/tests.rs
+diff --git a/library/std/src/sync/poison/mutex/tests.rs b/library/std/src/=
sync/poison/mutex/tests.rs
 index 1786a3c09ff..9dcead7092b 100644
---- a/library/std/src/sync/mutex/tests.rs
-+++ b/library/std/src/sync/mutex/tests.rs
+--- a/library/std/src/sync/poison/mutex/tests.rs
++++ b/library/std/src/sync/poison/mutex/tests.rs
 @@ -82,6 +82,7 @@ fn drop(&mut self) {
  }
=20
  #[test]
 +#[ignore]
  fn test_into_inner_poison() {
-     let m =3D Arc::new(Mutex::new(NonCopy(10)));
-     let m2 =3D m.clone();
+     let m =3D new_poisoned_mutex(NonCopy(10));
+
 @@ -106,6 +107,7 @@ fn test_get_mut() {
  }
=20
  #[test]
 +#[ignore]
  fn test_get_mut_poison() {
-     let m =3D Arc::new(Mutex::new(NonCopy(10)));
-     let m2 =3D m.clone();
+     let mut m =3D new_poisoned_mutex(NonCopy(10));
+
 @@ -146,6 +148,7 @@ fn test_mutex_arc_condvar() {
  }
=20
@@ -194,10 +194,10 @@ index 1786a3c09ff..9dcead7092b 100644
  fn test_mutex_arc_access_in_unwind() {
      let arc =3D Arc::new(Mutex::new(1));
      let arc2 =3D arc.clone();
-diff --git a/library/std/src/sync/rwlock/tests.rs b/library/std/src/sync/r=
wlock/tests.rs
+diff --git a/library/std/src/sync/poison/rwlock/tests.rs b/library/std/src=
/sync/poison/rwlock/tests.rs
 index 1a9d3d3f12f..0a9cfc48806 100644
---- a/library/std/src/sync/rwlock/tests.rs
-+++ b/library/std/src/sync/rwlock/tests.rs
+--- a/library/std/src/sync/poison/rwlock/tests.rs
++++ b/library/std/src/sync/poison/rwlock/tests.rs
 @@ -47,6 +47,7 @@ fn frob() {
  }
=20
@@ -244,16 +244,16 @@ index 1a9d3d3f12f..0a9cfc48806 100644
  #[test]
 +#[ignore]
  fn test_into_inner_poison() {
-     let m =3D Arc::new(RwLock::new(NonCopy(10)));
-     let m2 =3D m.clone();
+     let m =3D new_poisoned_rwlock(NonCopy(10));
+
 @@ -299,6 +305,7 @@ fn test_get_mut() {
  }
=20
  #[test]
 +#[ignore]
  fn test_get_mut_poison() {
-     let m =3D Arc::new(RwLock::new(NonCopy(10)));
-     let m2 =3D m.clone();
+     let mut m =3D new_poisoned_rwlock(NonCopy(10));
+
 diff --git a/library/std/src/sys/pal/unix/process/process_unix/tests.rs b/=
library/std/src/sys/pal/unix/process/process_unix/tests.rs
 index 0a6c6ec19fc..bec257bc630 100644
 --- a/library/std/src/sys/pal/unix/process/process_unix/tests.rs
@@ -329,9 +329,9 @@ diff --git a/library/test/src/tests.rs b/library/test/s=
rc/tests.rs
  fn test_time_options_threshold() {
      let unit =3D TimeThreshold::new(Duration::from_millis(50), Duration::=
from_millis(100));
      let integration =3D TimeThreshold::new(Duration::from_millis(500), Du=
ration::from_millis(1000));
-diff --git a/library/std/src/sync/mutex/tests.rs b/library/std/src/sync/mu=
tex/tests.rs
---- a/library/std/src/sync/mutex/tests.rs
-+++ b/library/std/src/sync/mutex/tests.rs
+diff --git a/library/std/src/sync/poison/mutex/tests.rs b/library/std/src/=
sync/poison/mutex/tests.rs
+--- a/library/std/src/sync/poison/mutex/tests.rs
++++ b/library/std/src/sync/poison/mutex/tests.rs
 @@ -193,6 +193,7 @@
  }
=20
@@ -340,9 +340,9 @@ diff --git a/library/std/src/sync/mutex/tests.rs b/libr=
ary/std/src/sync/mutex/te
  fn test_mutex_arc_poison_mapped() {
      let arc =3D Arc::new(Mutex::new(1));
      assert!(!arc.is_poisoned());
-diff --git a/library/std/src/sync/mutex/tests.rs b/library/std/src/sync/mu=
tex/tests.rs
---- a/library/std/src/sync/mutex/tests.rs
-+++ b/library/std/src/sync/mutex/tests.rs
+diff --git a/library/std/src/sync/poison/mutex/tests.rs b/library/std/src/=
sync/poison/mutex/tests.rs
+--- a/library/std/src/sync/poison/mutex/tests.rs
++++ b/library/std/src/sync/poison/mutex/tests.rs
 @@ -272,6 +272,7 @@
  }
=20
@@ -351,9 +351,9 @@ diff --git a/library/std/src/sync/mutex/tests.rs b/libr=
ary/std/src/sync/mutex/te
  fn panic_while_mapping_unlocked_poison() {
      let lock =3D Mutex::new(());
=20
-diff --git a/library/std/src/sync/rwlock/tests.rs b/library/std/src/sync/r=
wlock/tests.rs
---- a/library/std/src/sync/rwlock/tests.rs
-+++ b/library/std/src/sync/rwlock/tests.rs
+diff --git a/library/std/src/sync/rwlock/tests.rs b/library/std/src/sync/p=
oison/rwlock/tests.rs
+--- a/library/std/src/sync/poison/rwlock/tests.rs
++++ b/library/std/src/sync/poison/rwlock/tests.rs
 @@ -59,6 +59,7 @@ fn test_rw_arc_poison_wr() {
  }
=20
diff --git a/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.38-fix.patc=
h b/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.38-fix.patch
deleted file mode 100644
index d5eae83..0000000
--- a/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.38-fix.patch
+++ /dev/null
@@ -1,236 +0,0 @@
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
-diff --git a/vendor/rustix-0.38.37/src/backend/libc/termios/syscalls.rs b/=
vendor/rustix-0.38.37/src/backend/libc/termios/syscalls.rs
-index a833aea8d1..71b4c6abd7 100644
---- a/vendor/rustix-0.38.37/src/termios/types.rs
-+++ b/vendor/rustix-0.38.37/src/termios/types.rs
-@@ -1209,17 +1209,17 @@
-             Self::VKILL =3D> write!(f, "VKILL"),
-             #[cfg(not(any(
-                 solarish,
--                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
-+                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
-             )))]
-             Self::VEOF =3D> write!(f, "VEOF"),
-             #[cfg(not(any(
-                 solarish,
--                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
-+                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
-             )))]
-             Self::VTIME =3D> write!(f, "VTIME"),
-             #[cfg(not(any(
-                 solarish,
--                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
-+                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
-             )))]
-             Self::VMIN =3D> write!(f, "VMIN"),
-=20
-@@ -1227,12 +1227,12 @@
-             // have the same value as `VEOF` and `VEOL`.
-             #[cfg(any(
-                 solarish,
--                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
-+                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
-             ))]
-             Self::VMIN =3D> write!(f, "VMIN/VEOF"),
-             #[cfg(any(
-                 solarish,
--                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
-+                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
-             ))]
-             Self::VTIME =3D> write!(f, "VTIME/VEOL"),
-=20
-@@ -1250,7 +1250,7 @@
-             Self::VSUSP =3D> write!(f, "VSUSP"),
-             #[cfg(not(any(
-                 solarish,
--                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
-+                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
-             )))]
-             Self::VEOL =3D> write!(f, "VEOL"),
-             #[cfg(not(target_os =3D "haiku"))]
-diff --git a/vendor/rustix-0.38.37/src/fs/ioctl.rs b/vendor/rustix-0.38.37=
/src/fs/ioctl.rs
-index 490f183ff4..d131cfcb51 100644
---- a/vendor/rustix-0.38.37/src/fs/ioctl.rs
-+++ b/vendor/rustix-0.38.37/src/fs/ioctl.rs
-@@ -11,7 +11,7 @@ use {
-
- use bitflags::bitflags;
-
--#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
-+#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
- use crate::fd::{AsRawFd, BorrowedFd};
-
- /// `ioctl(fd, BLKSSZGET)`=E2=80=94Returns the logical block size of a bl=
ock device.
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
-@ -71,10 +71,10 @@ pub fn ext4_ioc_resize_fs<Fd: AsFd>(fd: Fd, blocks: u64=
) -> io::Result<()> {
-     }
- }
-
--#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
-+#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
- struct Ficlone<'a>(BorrowedFd<'a>);
-
--#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
-+#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
- unsafe impl ioctl::Ioctl for Ficlone<'_> {
-     type Output =3D ();
-
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
-diff --git a/vendor/rustix-0.38.37/src/backend/libc/c.rs b/vendor/rustix-0=
.38.37/src/backend/libc/c.rs
-index 02958698c0..27f5eb7c86 100644
---- a/vendor/rustix-0.38.37/src/backend/libc/c.rs
-+++ b/vendor/rustix-0.38.37/src/backend/libc/c.rs
-@@ -6,6 +6,8 @@
- // things below.
- pub(crate) use libc::*;
-
-+use linux_raw_sys::ioctl::FICLONE;
-+
- /// `PROC_SUPER_MAGIC`=E2=80=94The magic number for the procfs filesystem.
- #[cfg(all(linux_kernel, target_env =3D "musl"))]
- pub(crate) const PROC_SUPER_MAGIC: u32 =3D 0x0000_9fa0;
-diff --git a/vendor/rustix-0.38.38/src/termios/types.rs b/vendor/rustix-0.=
38.38/src/termios/types.rs
-index 7b97808a15..6f61e64ab9 100644
---- a/vendor/rustix-0.38.38/src/termios/types.rs
-+++ b/vendor/rustix-0.38.38/src/termios/types.rs
-@@ -1209,17 +1209,17 @@ impl core::fmt::Debug for SpecialCodeIndex {
-             Self::VKILL =3D> write!(f, "VKILL"),
-             #[cfg(not(any(
-                 solarish,
--                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
-+                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
-             )))]
-             Self::VEOF =3D> write!(f, "VEOF"),
-             #[cfg(not(any(
-                 solarish,
--                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
-+                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
-             )))]
-             Self::VTIME =3D> write!(f, "VTIME"),
-             #[cfg(not(any(
-                 solarish,
--                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
-+                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
-             )))]
-             Self::VMIN =3D> write!(f, "VMIN"),
-
-@@ -1227,12 +1227,12 @@ impl core::fmt::Debug for SpecialCodeIndex {
-             // have the same value as `VEOF` and `VEOL`.
-             #[cfg(any(
-                 solarish,
--                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
-+                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
-             ))]
-             Self::VMIN =3D> write!(f, "VMIN/VEOF"),
-             #[cfg(any(
-                 solarish,
--                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
-+                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
-             ))]
-             Self::VTIME =3D> write!(f, "VTIME/VEOL"),
-
-@@ -1250,7 +1250,7 @@ impl core::fmt::Debug for SpecialCodeIndex {
-             Self::VSUSP =3D> write!(f, "VSUSP"),
-             #[cfg(not(any(
-                 solarish,
--                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64"))
-+                all(linux_kernel, any(target_arch =3D "sparc", target_arc=
h =3D "sparc64", target_arch =3D "riscv32"))
-             )))]
-             Self::VEOL =3D> write!(f, "VEOL"),
-             #[cfg(not(target_os =3D "haiku"))]
-diff --git a/vendor/rustix-0.38.38/src/fs/ioctl.rs b/vendor/rustix-0.38.38=
/src/fs/ioctl.rs
-index 718a2a4048..68ae13bea3 100644
---- a/vendor/rustix-0.38.38/src/fs/ioctl.rs
-+++ b/vendor/rustix-0.38.38/src/fs/ioctl.rs
-@@ -11,7 +11,7 @@ use {
-
- use bitflags::bitflags;
-
--#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
-+#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
- use crate::fd::{AsRawFd, BorrowedFd};
-
- /// `ioctl(fd, BLKSSZGET)`=E2=80=94Returns the logical block size of a bl=
ock device.
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
-@@ -71,15 +71,15 @@ pub fn ext4_ioc_resize_fs<Fd: AsFd>(fd: Fd, blocks: u6=
4) -> io::Result<()> {
-     }
- }
-
--#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
-+#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
- struct Ficlone<'a>(BorrowedFd<'a>);
-
--#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
-+#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
- unsafe impl ioctl::Ioctl for Ficlone<'_> {
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
-diff --git a/vendor/rustix-0.38.38/src/backend/libc/c.rs b/vendor/rustix-0=
.38.38/src/backend/libc/c.rs
-index ec140a3272..85c3d1c0c8 100644
---- a/vendor/rustix-0.38.38/src/backend/libc/c.rs
-+++ b/vendor/rustix-0.38.38/src/backend/libc/c.rs
-@@ -6,6 +6,8 @@
- // things below.
- pub(crate) use libc::*;
-
-+use linux_raw_sys::ioctl::FICLONE;
-+
- /// `PROC_SUPER_MAGIC`=E2=80=94The magic number for the procfs filesystem.
- #[cfg(all(linux_kernel, target_env =3D "musl"))]
- pub(crate) const PROC_SUPER_MAGIC: u32 =3D 0x0000_9fa0;
-diff --git a/vendor/rustix-0.38.37/.cargo-checksum.json b/vendor/rustix-0.=
38.37/.cargo-checksum.json
-index 487061f297..42d107a480 100644
---- a/vendor/rustix-0.38.37/.cargo-checksum.json
-+++ b/vendor/rustix-0.38.37/.cargo-checksum.json
-@@ -1 +1 @@
--{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
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
-\ No newline at end of file
-+{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
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
c661667aefe06383cd3e843a34676852d9f5f79f62e48e975171","src/fs/ioctl.rs":"d7=
2bda8c3be1ed20c0e90b8a6d66db5021e97465779ac8dacfbef56c251428bc","src/fs/mak=
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
-diff --git a/vendor/rustix-0.38.38/.cargo-checksum.json b/vendor/rustix-0.=
38.38/.cargo-checksum.json
-index 649a506966..7d30530f1e 100644
---- a/vendor/rustix-0.38.38/.cargo-checksum.json
-+++ b/vendor/rustix-0.38.38/.cargo-checksum.json
-@@ -1 +1 @@
--{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231d2=
fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b0532d=
35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"8eafa99b133ffcf37520a4=
e62aecde1facf20c2577b1e74f2f93918d5d22a40c","LICENSE-APACHE":"a60eea8175145=
31668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2.0_WI=
TH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39ef1f9=
4f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a715d9d2=
b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12ba79e=
4cebb6983a7b6491949750aecc4f2178","README.md":"fbd9eb025cdb6c58d28649f0c913=
2a4e383014f03a8e0edba04a4e36cc45fba0","SECURITY.md":"4d75afb09dd28eb5982e3a=
1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e67273aa0=
a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"6d33904d1a=
456d968fe7433fa496e8db65185900467db85e42fc955a205793e5","src/backend/libc/c=
.rs":"e111414bce945426bbca53cd018e74300d57089a63b546652a62f63f52ba25e2","sr=
c/backend/libc/conv.rs":"e8d55f9cc427d19de13bde83b50ce02faf0afd32121c8adb2a=
2cc9f551a562d6","src/backend/libc/event/epoll.rs":"6b68d0002519ad9894391562=
ca062aa02f696cc0a2a84bbe750891619f5b0c35","src/backend/libc/event/mod.rs":"=
ad30f99f7da0768c18fffac6ec71e658bfed2e44f0634f48c2e0ffe4677ec231","src/back=
end/libc/event/poll_fd.rs":"e8cd06835771505b3c803b17c6097e59cf8743f62b2c46d=
ccbe7afc9a90cfca5","src/backend/libc/event/syscalls.rs":"9f12487a288ceebc54=
997d63aabe1ff07084a7c30c8a6135ea903e25aa1d09ff","src/backend/libc/event/typ=
es.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f13","=
src/backend/libc/event/windows_syscalls.rs":"1b682b13c3fd2601fa7dd10a909467=
a8d9ffebed04f8f6c8bcd7ea8a89769c8c","src/backend/libc/fs/dir.rs":"836273d76=
4eb7c1cf09b5ed20baf20a99d9c9afdf448c9fda50f0927c173cc89","src/backend/libc/=
fs/inotify.rs":"69376ba2e81f98164029888d0cae554ca1702b532b0045dc55e282f1dd5=
2d7bb","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f329ad3=
5bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803011b5=
7da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc/fs/s=
yscalls.rs":"8da556f91f0a29fc5af7c6981f106594c628b564a370213a4c72a12cd03eb1=
68","src/backend/libc/fs/types.rs":"8012d86bcc5d1314d1d181cb81d9fff3855fa01=
ff3731b35e2a0484889f72188","src/backend/libc/io/errno.rs":"32da10e172113352=
87db5165955331d7bfebbab73513e0ef96014385a91aa06b","src/backend/libc/io/mod.=
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
/mod.rs":"ce2f388bdc8dac69ca9d1871ddc7ad01a7471a0de4b7f2bd67c8f11d0878fd87"=
,"src/backend/libc/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287=
b25a5bfe489fa1d07f7cfd7","src/backend/libc/mount/syscalls.rs":"d2d35f7ae989=
bb52722e28cdbd775243c5d7da9eb411e0b2b9632f2aa7c1533e","src/backend/libc/mou=
nt/types.rs":"5c2eaf22e7a29e8e48cb19e40c88d040ba1c891038a611e85571476489dc1=
2cb","src/backend/libc/net/addr.rs":"b9f5af8bfe0762deb346aabe87f8d325045439=
23a246ff97f9828a0bc36b893f","src/backend/libc/net/ext.rs":"cfce41130eb2e3dd=
04271e0aa2c1e2de9866397d7d2a59e917d26b784ea30df5","src/backend/libc/net/mod=
.rs":"562d23225d6dba8f095e3ca41af60dcf6cc40c2cf17bf028f90888f809e86f07","sr=
c/backend/libc/net/msghdr.rs":"6f8aba792b4adef5c5d3d4324a813a67a063a50d1043=
7bb19bf7496666bd6de6","src/backend/libc/net/netdevice.rs":"078bc108540457f0=
e5849c2b8d2f1351c4aaffc910f8c9c9857969477c22065e","src/backend/libc/net/rea=
d_sockaddr.rs":"b094d2cb84b2eee5dd411d21458192c03eea0e420e78149441d7ab88a89=
3281a","src/backend/libc/net/send_recv.rs":"b5714bed2cc6f2ba42bf90d19655b50=
7c2a248e2d05270b1355b6d4cb8e4f9fe","src/backend/libc/net/sockopt.rs":"4595b=
d3b182cdaa7bbefb94556ffd1dfcde81d5e20b298cd907eb7373d7b3b77","src/backend/l=
ibc/net/syscalls.rs":"552eb57bda272f2372e180f927a88dce67fcef46e7c1378d47d59=
5eb2abd578d","src/backend/libc/net/write_sockaddr.rs":"b62e40c9d4a4e70746d8=
64434db140b4b3c1f110a3fd2e7acfbb3f2ccf15d6aa","src/backend/libc/param/auxv.=
rs":"c29b29ad65f66e048debce5293bf84164811264e61b71a28a57225400d3b9529","src=
/backend/libc/param/mod.rs":"5234b8f1bcb886cca6ea003d411d75eaeebe58deedd80e=
3441354bf46ed85d4d","src/backend/libc/pid/mod.rs":"2c6478857a0751625edabd61=
acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/pid/syscalls.rs=
":"49ea679b96c0741d048e82964038f9a931bc3cf3a0b59c7db3df89629b9c49e6","src/b=
ackend/libc/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe=
489fa1d07f7cfd7","src/backend/libc/pipe/syscalls.rs":"7380b533adbc57b5ccd8d=
2d0b74e5968215b00047965fef8bf0a1208d914647f","src/backend/libc/pipe/types.r=
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
ibc/winsock_c.rs":"e150946d35781b462433d8412e0c99eed6214113bb90fbb251bf560b=
3beefa18","src/backend/linux_raw/arch/aarch64.rs":"2a255c9135bc8a321c180f52=
b88eb2b158bc9170cd222149caeae63c24587d44","src/backend/linux_raw/arch/arm.r=
s":"165bccb5883d0136e55d42091183765f83d86e9d37a7cb2cec9ae8af32774db6","src/=
backend/linux_raw/arch/mips.rs":"aca20118a73063e4f2f8e7b261b1266d216e826df2=
a98cad99c53c40b0971af4","src/backend/linux_raw/arch/mips32r6.rs":"a7ebd0886=
e2e0d3b39996778fb665b68738f8a67d67b47e43fdba7e7cabb6d1a","src/backend/linux=
_raw/arch/mips64.rs":"ba947f286522b8034d509887cff8183cca34766aed5d37c91667d=
ba22e2f608a","src/backend/linux_raw/arch/mips64r6.rs":"27de08ce1003a48f1d8b=
84746e724e8766b980e4ddc4febb6e20eb31067fb137","src/backend/linux_raw/arch/m=
od.rs":"ab348ddfbe57c3e3258f02416dd68503eb9f0521a2f52b73e4dc715ab6121f83","=
src/backend/linux_raw/arch/powerpc64.rs":"dfb001f8636a5e46d728900b0804fe6c3=
74e5e18a6f0e76d7d62e0c07da74477","src/backend/linux_raw/arch/riscv64.rs":"4=
1d33242d941030f46077dc2b1bc4c7913fe7630d693a5a7eef966bcf38f9d8b","src/backe=
nd/linux_raw/arch/s390x.rs":"5b30beb99a543c87c77428e488575bf9b6e7f07d790df5=
73e7be38ad5dd314a6","src/backend/linux_raw/arch/thumb.rs":"2fd979ab421248c0=
a4c592bc0cefee63edc26528f469b71b63eaed35356e42e8","src/backend/linux_raw/ar=
ch/x86.rs":"8fba9762bb0e8bb9a71890cdf413441aa52d2bf41690ec0ef01c97ac11759a5=
b","src/backend/linux_raw/arch/x86_64.rs":"e929036a1f3cf93ba538f4523b241605=
cc7b5e61f84ffe6d9d5cdbcb6f73e543","src/backend/linux_raw/c.rs":"7ae5c31185a=
fa5cc82ab2684faf7770c15e4ebd61f104e5c30e3fcafdd450287","src/backend/linux_r=
aw/conv.rs":"f4deb897dac6c99e465db1bf27a9194196e208105f0f00f040c9e56cadd9df=
51","src/backend/linux_raw/event/epoll.rs":"db05715e1bd3b93c6873695c89f04ab=
b97768a57e7e402306f568eba844e407a","src/backend/linux_raw/event/mod.rs":"72=
e46b04637e2d1d2a6b97af616144995399e489d1fe916faf835d72fc8c64cd","src/backen=
d/linux_raw/event/poll_fd.rs":"a5773464e9e30227b4046f029a27d3daf2c7bd0045e5=
4565cf1a8ac2a0d61e81","src/backend/linux_raw/event/syscalls.rs":"5bf5df8fe6=
7e246948a7bb40dd89176052ebf085ed50ca9856a49c3613b56a47","src/backend/linux_=
raw/event/types.rs":"0551b18f982e233a0a06d8a9c3dbb29de0c204dcd64dd6f7e88b6c=
96fa9a9be8","src/backend/linux_raw/fs/dir.rs":"fdf849d058c387551e102bd7fec3=
1e3ca40c18417a1e530cfed1daf3df2c4de3","src/backend/linux_raw/fs/inotify.rs"=
:"e627e8f48e8f4dc2117746117aaa7f151865103be64e446011c72878921e402e","src/ba=
ckend/linux_raw/fs/makedev.rs":"c6b4505c4bcbbc2460e80f3097eb15e2c8ef38d6c6e=
7abd78e39c53c372139e2","src/backend/linux_raw/fs/mod.rs":"3d3a42bbf4d086f80=
6d7d9f6e4b0a49a873dc27f4f03ffca0921f5536acc24e5","src/backend/linux_raw/fs/=
syscalls.rs":"6e2ca8d96be2bf94b38512d184a22d79385a6841419de2590f9e5af33d002=
920","src/backend/linux_raw/fs/types.rs":"6102a5b8207f959edbcc2fc233a6145a2=
65a428c0c4fa195472fe7fe6dc5165d","src/backend/linux_raw/io/errno.rs":"40cf9=
fbaee5c88b8e6293a1eeafa3498f3c0fe402b16a30ae97131795da0b404","src/backend/l=
inux_raw/io/mod.rs":"7ae2324427892cca6f5ab53858d847b165f790a72ec25f3d99fb15=
f0506c9f27","src/backend/linux_raw/io/syscalls.rs":"54ac1395fb4801ef2ec6639=
113a6e23c4b532d84b6495f7166fcd0492cea09f9","src/backend/linux_raw/io/types.=
rs":"d0df5a62248e1ba19af0f89f86da7ba2312d97065c2814ddf6b08a4a0db23bad","src=
/backend/linux_raw/io_uring/mod.rs":"2c6478857a0751625edabd61acb841819bfba1=
093b1faeded15693c805d84952","src/backend/linux_raw/io_uring/syscalls.rs":"7=
e40703cc3a020377a4a23bc8651bdf1d65b8f62e174eafb85d27d246f86c39d","src/backe=
nd/linux_raw/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe4=
89fa1d07f7cfd7","src/backend/linux_raw/mm/syscalls.rs":"c7fc0f49283026b0df4=
7463ed47394634e5664468f36a5eb2a89bf259bbfb67d","src/backend/linux_raw/mm/ty=
pes.rs":"821409c463a31954048075906b3fe5bdb029badf9c9e2689bfff8f6dbf5b0bed",=
"src/backend/linux_raw/mod.rs":"f849feea0a83df69fb9288ecfe07992cbdaee7e55d2=
9b5662043a3fdf00e4700","src/backend/linux_raw/mount/mod.rs":"8aa966faf3853d=
1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/=
mount/syscalls.rs":"8442c82814961f69c488222faabb82c44d2e7227b10faff919cbbd1=
97bb47484","src/backend/linux_raw/mount/types.rs":"9a33214816863fc92846fbc9=
9df6ddf60a3e772b34f4bb3f5e8a40ef489130d3","src/backend/linux_raw/net/addr.r=
s":"7239e4fa8c6872bf978e2f580563c51c72d6ae6f96b77520fc7b9ece62fa0ebe","src/=
backend/linux_raw/net/mod.rs":"5640bbaf4963ac4575b0537173422ed6f6a43f34a8f6=
b656e7257fbbb13e5bcb","src/backend/linux_raw/net/msghdr.rs":"8b18974b81ee78=
af7a5c64733041dddaaa378a46cab8b984bff5b3b4be499751","src/backend/linux_raw/=
net/netdevice.rs":"3cb28bcd762e2df595481b4379a08170f59f99d367aa03424531c19e=
4c5aaf55","src/backend/linux_raw/net/read_sockaddr.rs":"7cb3c8bcc80c5eee860=
2323cd83f36c1784927d9dd0c40ded29af6fb09c57ece","src/backend/linux_raw/net/s=
end_recv.rs":"d4e81c01db50dad1c02e9aa3e0979f8052431a3f64c8864681d9ea52a34ce=
3bf","src/backend/linux_raw/net/sockopt.rs":"95b5054469f3c9ba83ecd30a60e4ad=
b3dc444d36cc1a24ed57fb460626b475fd","src/backend/linux_raw/net/syscalls.rs"=
:"05d96523e459425ddb13ac86ed07467723f4c3bce7204115f94331bc96dbc712","src/ba=
ckend/linux_raw/net/write_sockaddr.rs":"0efa4e17b4008da2cf2aada2d18acfccd31=
a3b49cf8ac5d608e77f3ea6627fec","src/backend/linux_raw/param/auxv.rs":"d9082=
7ecdb2d9c98604bfd80419e533c3c200da4463b17e2bd8ffa0e061cd5c0","src/backend/l=
inux_raw/param/init.rs":"f2275a2324a99be8d804fb3b7fdf86a43c7d428f660280b7e0=
e7d19c357f0200","src/backend/linux_raw/param/libc_auxv.rs":"0a223ad36a33611=
370cdf3c666008fd61d15f2477fd3a5ac2c78972079fb86a9","src/backend/linux_raw/p=
aram/mod.rs":"2e6a1a1c00351b9c88bd615aa923f71d76208df5626dd9bea03067f28f81d=
c31","src/backend/linux_raw/pid/mod.rs":"2c6478857a0751625edabd61acb841819b=
fba1093b1faeded15693c805d84952","src/backend/linux_raw/pid/syscalls.rs":"ee=
f6aa01830ddd510b83f507da2002c03e58318b73744be2c06ebbe33c4f194f","src/backen=
d/linux_raw/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe=
489fa1d07f7cfd7","src/backend/linux_raw/pipe/syscalls.rs":"aebba454edd084bd=
5821243d8fd755cd2a841d5b620e8c9ce9c19a02fc5d00ac","src/backend/linux_raw/pi=
pe/types.rs":"ae643a774e6343df02b9b99b842fba8b742dd9b1f97b5c5b2b504f2840bf3=
fd2","src/backend/linux_raw/prctl/mod.rs":"2c6478857a0751625edabd61acb84181=
9bfba1093b1faeded15693c805d84952","src/backend/linux_raw/prctl/syscalls.rs"=
:"a18b224307e0d27bda9b7b85c75cd6c7ddfe39f5ce52efb7bb0bf0585b757343","src/ba=
ckend/linux_raw/process/cpu_set.rs":"b31889f972676f57e3599375dfcd59dd729759=
77ef345d11c22d51f0d4a6400b","src/backend/linux_raw/process/mod.rs":"fb393c7=
0a9c63ef9a6bf1fb5a2dc94f07d6b0b6987cc5231c15c607015dafd68","src/backend/lin=
ux_raw/process/syscalls.rs":"b9b6d542a39e021ab2b0b2128bdb436c22eb8c52556d18=
5f01c58f1a1d9412ed","src/backend/linux_raw/process/types.rs":"6811ba822bc12=
a1a6336649151b4adb1f5d3365684a31c07f01953ea9547743d","src/backend/linux_raw=
/process/wait.rs":"921aee4b0048746087f52615a98edc2aa0fb4b53d6df44be4533098d=
f55d1b05","src/backend/linux_raw/pty/mod.rs":"2c6478857a0751625edabd61acb84=
1819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/pty/syscalls.rs=
":"ae09c4aecc0ae87b1ca58d82efc58007b9dddaae78460d615f48da19d1cd0f89","src/b=
ackend/linux_raw/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25=
a5bfe489fa1d07f7cfd7","src/backend/linux_raw/rand/syscalls.rs":"317cdaf2436=
23329ee345131054e86a06a0863a9e90c5dba73e1ac3475ba6305","src/backend/linux_r=
aw/rand/types.rs":"a21dbb1ab31eed6b59a57520be5a3c603c36d18ea74e67f7527f4083=
5ba209a3","src/backend/linux_raw/reg.rs":"3e321750d91d77c835abd09b06b5851eb=
f3134d3affb3cce306e38329871bec4","src/backend/linux_raw/runtime/mod.rs":"b2=
cae8cce3822c3c92942f06ea0b68464040dcac33c6f0f7ee392c6269993347","src/backen=
d/linux_raw/runtime/syscalls.rs":"ad0e266f0eec81be6e104d1e02ebf61e149f4f3c2=
4d8f18cc4442adc313f3327","src/backend/linux_raw/runtime/tls.rs":"6316060560=
a112c2e9cd9807cdba6e8c91414113a04a739160929ae9a67bba1f","src/backend/linux_=
raw/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07=
f7cfd7","src/backend/linux_raw/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc=
5d56e12b4d93794540087b3182cbdf3cb9c8db","src/backend/linux_raw/shm/types.rs=
":"8275dba36a8f2c4208f2d23ffef52c5b02d4b10d5450733cb4fc5cdfcd6285ee","src/b=
ackend/linux_raw/system/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b=
25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/system/syscalls.rs":"19a7ab1=
7de906ec237f16a816da036723c1f55f605e8e4a26689343eb4cd76e7","src/backend/lin=
ux_raw/system/types.rs":"1ceab8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9=
e1d4f1447a016e","src/backend/linux_raw/termios/mod.rs":"2c6478857a0751625ed=
abd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/termi=
os/syscalls.rs":"1a42438153f61e72aab7c3c8fdd0c3ab918da0fec58e07bb4242351806=
5374e2","src/backend/linux_raw/thread/futex.rs":"0139394e11006301e98379b7f0=
7604aa10fb436b43acf8f55f1a24f1253f96cc","src/backend/linux_raw/thread/mod.r=
s":"6ad4a4b90b9234e79900b27ebbe8837e3a7a36aec532912e3e253edce5225067","src/=
backend/linux_raw/thread/syscalls.rs":"e2c89bd3cf34a46b5d06de43933284ddd06e=
d07e9c789c726c1afa48f7842a5c","src/backend/linux_raw/time/mod.rs":"672724f5=
5b7b7be6a7452bb1cc2d28b5f0aaa840a2856fe363acce624e1beefc","src/backend/linu=
x_raw/time/syscalls.rs":"7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9806e5=
de9404845312fc","src/backend/linux_raw/time/types.rs":"5f49ee7b201976114c65=
55f0c5a81d3305e18e726e54edc5a5474641f3cdc278","src/backend/linux_raw/ugid/m=
od.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","=
src/backend/linux_raw/ugid/syscalls.rs":"8c86d251db33b399a1d1cbb8e87afe650b=
78db84f444d3251309b7a0480b54f7","src/backend/linux_raw/vdso.rs":"056314f72c=
71d4b041739337ca2098afb7fe070f844327f462c293f43481b75b","src/backend/linux_=
raw/vdso_wrappers.rs":"4fa1fb04d5812c9edf143b3228327475f4021f6cd52c75beb51a=
eab4d1ad983e","src/bitcast.rs":"4d2b3619dac1500bee223e11db0b4a5f75b0fbde650=
94bab157597af71f6b72a","src/buffer.rs":"fbb262d0751546447ee95f1623d3f2eb450=
ff0b4a7e1df29c5a2c9cf205b8820","src/check_types.rs":"e52f710e1cfc12ca13a495=
f2b43c227b293ff295e1ce3ab332935b28a7579872","src/clockid.rs":"bd66d6bdc6b73=
a4668dda5b6f91838b6ed6c4b9503a0798b071ef35c572b711d","src/cstr.rs":"41af2a4=
429fe6c67a8883f8a8f63d66c90df566abda74fd2b03bcef7b9f24218","src/event/epoll=
.rs":"0d051674b9c1b3f118ad65e2b46b4b3cab5551d5dde4e1c40b3af14854a826c7","sr=
c/event/eventfd.rs":"81cbd08f7bdf40a6ce1ca692b63da1dc8ba925282990668d9d68f1=
203e839fa1","src/event/kqueue.rs":"1f381c8afa65d36e3052c476d2e679c3bccb7e3d=
6cc6b95ba53b48abcbe13a81","src/event/mod.rs":"deea3de6e5acbd876a9453c397d7b=
b20b818584ddef8e099729c9f2867432572","src/event/pause.rs":"930219e19ee22772=
9c8f86fe7271721e8797e917d2d7073fa8d7a104bf6189c0","src/event/poll.rs":"4de5=
f12e9cadd64e93e11e7b63248bf657700e6be2d8b40b0e5d5303eb34b4da","src/event/po=
rt.rs":"4e51ff150e5d17cbd44aa64a38b99c15e26eaaf2e350768b5dcacdfde4fa5212","=
src/event/select.rs":"49ca840bfd39202494fed201fd34742c30ae5d3d6c115d27b8c23=
2d2137105e3","src/ffi.rs":"50a14dfe10408f9abc6269b9ee6e7a88d99503d50b373228=
8e85b777915e579e","src/fs/abs.rs":"1c1e65be08da5f7d6e5b8902283855fef0f0a74a=
b227aae991aaf5310d0858f2","src/fs/at.rs":"68de994eb06fa90bf5b5088dc4ae280c6=
ac2222fcf137265d4256ce202869da1","src/fs/constants.rs":"23923e0fce3221bdac3=
71fe2d05028f30a87dba4f9b4a573b69dc2d6d39320b2","src/fs/copy_file_range.rs":=
"d3b644374390d482b2ff749a2459458872b57d0dcf9670368739b7833509a7c2","src/fs/=
cwd.rs":"3400dd3954aa0d806af1960054899447de5e425481edfad539bdd5fd0b9967d8",=
"src/fs/dir.rs":"347a52f4ca9ac6321c52e802e97ec90d1b4c62ec955c8996fc17f8f5ae=
d69966","src/fs/fadvise.rs":"d77f6a7f7f6648e750888719e59f0f8332f11e84442ef7=
2f622bcbd4e19be845","src/fs/fcntl.rs":"6aa6eb0c87fdd915974e425dd4881038c365=
8f05fac0bc005a9b40107474ef1b","src/fs/fcntl_apple.rs":"e2f23f038083621bcdec=
c98d02ce1023508afaecdb2ed0fba5c8b70f955301e5","src/fs/fcopyfile.rs":"ce565f=
61e1fbf2e31086077c2f1d01b6bb3b048915edda87fe9a4a4f5e8ff7e4","src/fs/fd.rs":=
"c9042ae0398dfbf39ec9ea8a0bebc6fa91ff76dc33f5aeb829313996036e4d66","src/fs/=
getpath.rs":"28f6970fc1bbc37bb35c84724b59eac436ea7407a4522e18c2bdacb1fdd2ed=
d9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f97189cea4e5982a0d35b192afeec6340a6=
c6222e0cb","src/fs/inotify.rs":"2e4b9824c323c661667aefe06383cd3e843a3467685=
2d9f5f79f62e48e975171","src/fs/ioctl.rs":"1d17e7be9ef4f9f69358bf474a669f0ee=
b0e8516a3626befc1bf61bee0221d89","src/fs/makedev.rs":"85520b484cb7c15ab71ea=
1c368578ea3b7e484d82f8510db92b6ce9f7ca341ae","src/fs/memfd_create.rs":"55a3=
d611184fe0e664f8e2a68cee359c4a65dfce0147305add139df65c292f01","src/fs/mod.r=
s":"0657052b4ce5934a3f7f95cbb16e06b75b10e4359142959d3d0a0ebe70fdc33a","src/=
fs/mount.rs":"8f6ea2b997dd83c50c90291b9ada3ed77a9ce1ad701c9b0d533b5113b317b=
e5b","src/fs/openat2.rs":"4a95c15dab533a41201b5fa25c8a212956b7571d58cad696b=
daf45af8aef96db","src/fs/raw_dir.rs":"6ad6d3dcdc6ddbb94f152b2584d7335e4b209=
d7219045ab4bdd6bdb2b7400e7c","src/fs/seek_from.rs":"a9efa0feb9ac789cf47667e=
91efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","src/fs/sendfile.rs":"e3b2058741=
cf4b1698f34d84bb37130cf2b72806d522a16fe541e832cde136cb","src/fs/special.rs"=
:"17a0f89f7462171169bbf5aa20a9ec934951fde7016daaed9bb1d12b468baf91","src/fs=
/statx.rs":"2844baac77fdda0d77823402bfbdbe5bf8983e1d3b229d700bf80c0c190f2aa=
5","src/fs/sync.rs":"84f24de0ea53f77bd5c471e097abcbecd19c4843b69607f9be9030=
eb7c9d5aa5","src/fs/xattr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6ca3a4720=
0532ca6e72d44cbe8334","src/io/close.rs":"b4f7c0dd39554463c9692a09c40744081e=
229b729610d7c530e084e92c63e8e5","src/io/dup.rs":"dd33bd405dd8368c2ef8073803=
ed1512cbe2c2d92194f3f38f44e766d2ff6ab3","src/io/errno.rs":"fe056ade492ef5b7=
e20fb9ffbc7e183b7bec6ff300587eb5197deaed5d321fda","src/io/fcntl.rs":"99fa69=
8c6a6c68ecece7e7d14e0a65e1b6e17d360f028e14f8800d42a355b22c","src/io/ioctl.r=
s":"e89a6e670fe1c06521aa2f266fcd7a990391a533995b787cabac223f0926c8c7","src/=
io/is_read_write.rs":"a7d3cc1b8673a94d64926c03984e24a627c24e78f09070a2eb893=
d8005abf9d7","src/io/mod.rs":"0b566bf43b3f8754153f361119f63aa08ff2450e9306e=
b7e35ac3619bfeeae0d","src/io/read_write.rs":"46fd5efcc1205f8195b6d55ad277f7=
1dcc62a2a52301dae03c0e5dbae6d70bd4","src/io_uring.rs":"4d163535b313a1798bea=
10190b8ff5211e8ef72ff822952a002af3b1c4946153","src/ioctl/bsd.rs":"d7d3f6813=
eac0e0f22fb8bcac3d193a22584393c1f7fa233999bd09c4e2059f7","src/ioctl/linux.r=
s":"61f006e31a4e049787415131beb97e548accb17fb6105d7ead5a12df0727077f","src/=
ioctl/mod.rs":"87e502a4de2f5ec029d64f606d3fda3831623f405434306e69f35a6aff5d=
3c04","src/ioctl/patterns.rs":"26116d5b5cd790ed485791e006c97c28590c038050c6=
9c42c752289fa7fcbc65","src/lib.rs":"b45ec754e76e48ae388a75d646a45a4c627fee8=
55b5c4616b80d72906c8daf1d","src/maybe_polyfill/no_std/io/mod.rs":"77889bb5c=
5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/maybe_polyfil=
l/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9cff3a19049d=
88c8c80","src/maybe_polyfill/no_std/net/mod.rs":"1e94d21d455bb1da18a4fccb24=
b3d93ad42698e22dd888b78115d6266c80288a","src/maybe_polyfill/no_std/os/fd/mo=
d.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e80771d507c47","s=
rc/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087cc9afd10269f09a8b41=
25915dc3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_std/os/fd/raw.rs":"=
f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999e7c6943","src/mayb=
e_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2fcc7c825310606b889cc=
8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/windows/io/mod.rs":"5bbc=
c05c83fee5026dd744a994e0458469466d5be39081baa62df07753b92fd2","src/maybe_po=
lyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49328b5637cb3bafb9643=
7f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/os/windows/io/socket=
.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5d2c64808308d65","sr=
c/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231a4e778b5f985b9ae712=
ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/std/mod.rs":"7c16c86=
cc73e226e65ead598e4018238b22000a345040b706bf1e1b3eba115fc","src/mm/madvise.=
rs":"092ff2064b16960369a908aeed70ec38a16fa2a0207f814cdea379e2f2286954","src=
/mm/mmap.rs":"1cc428e40ae77b23718ce821a22806c067fcaa7aabebf57df5cede7b7abb2=
bcc","src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761211a494ca6f89b2367a=
2d2157e340e","src/mm/msync.rs":"0cfb895703b8b7bac47426c8f03499f2aced3f4e1f3=
1008243a1a629e9d44a1d","src/mm/userfaultfd.rs":"8073443bd181ff0b3ba4d0b1ae6=
7370b4864035a0c8b4898cd709dc47c518ae7","src/mount/fsopen.rs":"1c54a02f04ee6=
710e2c5053c73361eecc499c24cd72c7c7c012dc57a4621e382","src/mount/mod.rs":"5f=
0c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d12a7136cb19","src/mount/=
mount_unmount.rs":"fa77675b023180b578b7fc053acb46ae2ed2eb11bb0488871bfd1ed2=
11df73a0","src/mount/types.rs":"601ae3e10b7dc496fed7f3b40a80e81c6edd7bf1318=
9d7be45c3212d4c684c39","src/net/mod.rs":"7899807c9ad9e3fdbfd8b3ce2a1c7053d4=
f46dd7fa76102f620c6042c2d6314f","src/net/netdevice.rs":"1d790ef6e33d30c3167=
ec422a95a711d6df26d69502cb0b4c4889623547d3693","src/net/send_recv/mod.rs":"=
ca923e7affc72bac1c67b3957f55a256dbdcd800c54ae866ebe71fb406ef79a8","src/net/=
send_recv/msg.rs":"7bbd89b593748d4ef63d76f1b47c429c48c2f5f3d4a6bfd9aa37373a=
c26a77a1","src/net/socket.rs":"f6e0c454eadb52a8ead30e04851bfe095d65fd1b83ae=
6419dac2030e69b3f7d5","src/net/socket_addr_any.rs":"88250bf218d3a626e8e04bb=
11d4dd50ddf1422bb28d780c98b80710cf9c30166","src/net/socketpair.rs":"aa9013d=
e19945bfea3f7d2889cc23abd384717b79f38cd5d045dec09c7517658","src/net/sockopt=
.rs":"416485d98afaa1cbc492e0dea06edc2137e2b2e6b15e16c2479dd92ae456c355","sr=
c/net/types.rs":"7b430c33a1bed0ebdb10f997d2c0c0227fe335ccd11d8446d9846627ae=
84a2a9","src/net/wsa.rs":"29856e6d0108be6b719f6ef973c5396e48ddd58ecd0c2db9c=
a3e2e0ba4eccb5b","src/param/auxv.rs":"b57483d3083a4dfad9ceb049fd96d54713b91=
b7f31b8c9a0e40501548da499ac","src/param/init.rs":"a31c0e5cea61a1a999767fe74=
f87c0d59eeb6bce66578b842fe0e0c32be27a55","src/param/mod.rs":"c514216b96d952=
0c9ffc5662c97b24f1f36f56fe1f5f3c9f64175c8b35577288","src/path/arg.rs":"ab5e=
d60c8cbf0484dce25440f027d7d511ea329bbaeaf83d70717f5c7e47b5ac","src/path/dec=
_int.rs":"0c71377fa5137595d6316ee135617ab8e514a2f539d77e15ef3a626d7aa092c9"=
,"src/path/mod.rs":"fbe294749100630467580f5e25b44e7a4f8a4512381cc18acaf1a68=
13afc39cd","src/pid.rs":"f1c486000c5b1311b2d720cee88f089c17ef9a171709673dd0=
6e6f35f4ff98a3","src/pipe.rs":"d5de91e5adb0ef8753e4c1ee5cfdff1f8bd80068af1f=
a3a12239a47da5131832","src/prctl.rs":"19aa584895874ea48b9bbe1bf695b81257b02=
81df64dfdd91e1b4bfa298661b7","src/process/chdir.rs":"93ce4fade85e720883f22e=
8b8a6c0c9b6ec3a07c37f457852b2c53aafeb8ad3e","src/process/chroot.rs":"01191e=
eb86295975874019dc675cb0f8f0ca5f79dd78dc9d1c791a952adb3512","src/process/ex=
it.rs":"f09000df82151d015a39b8cfe7dc28875074ad1bfde326f63be1438cf736d08e","=
src/process/id.rs":"21a487fe2384add719462f7cef500de0e286acf20ec5a6773c748ad=
e08b99aff","src/process/ioctl.rs":"c7f551152d65ac173d9eaa298b964339037b60a7=
b81e8bc316453718417a6be3","src/process/kill.rs":"674d06cf065c8045dbefb6fc64=
37a62b964069599fc03d84e64cc36186b96596","src/process/membarrier.rs":"1c4c39=
b359d1d0e9bbe16352eedfca9278d9ef298ade8ec00e998617bbcbfed8","src/process/mo=
d.rs":"a32691289982f4ffc53fef94fea4e3f375af9af87604fb962e94c54c9d91703b","s=
rc/process/pidfd.rs":"150413a9cc550ffc432b3279a368223fa9577544ef29e45edeff3=
b79ae316cab","src/process/pidfd_getfd.rs":"74c778b872be0b800870e4633606461f=
dc8493b259031e35f8f558768d960cc2","src/process/pivot_root.rs":"aeb2464464ef=
d81ca0b940e3e5e3ed1b09380f3e6ba3200972e0ba100f78badc","src/process/prctl.rs=
":"a34ccda958036f49c5e4a5d654566c2b18d59c4b48b31c91e63877191752712e","src/p=
rocess/priority.rs":"ea78f09e4564943d0083eba19d9933781a5dd70d5723f156eb16ad=
01dd67d89e","src/process/procctl.rs":"27e082d23267ef9a19dcbdd7eb33a1df26eef=
42894202a728bc1d8a3f1ff27e6","src/process/rlimit.rs":"10becde11d8b5d3b50aeb=
21a8fcdf53ec7803bdbbf8d1f4233b8e6c0b85fafb1","src/process/sched.rs":"4f5665=
93f7a6c12873ecb18f21b9806162791b33815c9147065d3c8d812b562c","src/process/sc=
hed_yield.rs":"8f80fef12e528628d19c26d26ecbad61b9644505a872a49f842820aa5201=
8cf8","src/process/umask.rs":"15841f5e178dd032f8b8def8545c9e98b205e6b1ba70b=
f9c07c2c0327a8999c0","src/process/wait.rs":"04d60c43e8ed1ac44e4ddc5ba6e18e5=
edf1c400565ea0e81ff8f1bf71403b7ba","src/procfs.rs":"adfac2c1232ff20c18251b8=
745f6732e3315b1adfe95b9e7297378dbcb290129","src/pty.rs":"5378adbc5b2cbbf84d=
f1c310559e2094e61321905c77e4a0107d634383320b5a","src/rand/getrandom.rs":"a8=
9f45838d22982eb0997bc905031819195701b64aa1c874e646dcb16d6e2a7d","src/rand/m=
od.rs":"e1fb7542f1958fe77673aa628bd92fef1b9addf79ba23df2398d1231cb61c148","=
src/runtime.rs":"58abe84feb409ec5a97df922253d127f032e54d0b44989f2a9dff4852a=
1b7ce0","src/shm.rs":"30b32e302ad2d198de411981f3c7609082bc20f1c0651aa3f3ce2=
beb8f19c6e9","src/signal.rs":"0fcce2e37f69d70cfef1f355355979b269820281a6e63=
bd171ba05e525063e79","src/static_assertions.rs":"504cf66f0d5b8e335be02f9ae8=
b0a355abc98c2c82eec0098bdf0988e662e260","src/stdio.rs":"85e66975a55f91bfb76=
4f848eab34acf1bf6ca7f37b6421043d1e2003ec14805","src/system.rs":"4954f5261bd=
25fd01ba6c97a1a0afa9cad4d768a1c10491d33b3bf2d0bba8371","src/termios/ioctl.r=
s":"aa26694c9be5378ea52e669313e64b25fc034e3863b72281530c42499570fedf","src/=
termios/mod.rs":"b44b7caa60b6f458657ed58a0e0eca41bb4e6d6be4b0f042bbb8ab7056=
cebe4b","src/termios/tc.rs":"bafcc607de993c7e7c4cd6f15a59e7807906e59bf991a5=
a4c67e3b076d07e3f2","src/termios/tty.rs":"0013cc4c31907246b45c4b94ded0171dc=
0d3e6759740f5424831feae700092f7","src/termios/types.rs":"6a69789f7bd4783839=
b18f5e41f2444afc021c5d5f861bd75939ec53308d11af","src/thread/clock.rs":"cc4a=
981b7fc059cc88da709e31381c778d75c22f1b96cad5fa2799a45ecfef5a","src/thread/f=
utex.rs":"b4a182cd4b490dab620c5fc59adfe79845c2e64f624cb8d9096a9375a0597b21"=
,"src/thread/id.rs":"1a9a8b4bfe71dba6aec17760ca9de5a66a80b9c608fa0eeb30fd1b=
c949e511ca","src/thread/libcap.rs":"4c51b7df566d38dd0f85f81ef53279a745a39f0=
f4e1154791fd38438e2ca7db1","src/thread/mod.rs":"d6d9c3340cd9710869813ea9c99=
3669d11620126edc66e5657a9de2a07a5f864","src/thread/prctl.rs":"3826dda31b945=
2b2a8b30158b6babd0b536fe9ea314027863d14c3888c9435ee","src/thread/setns.rs":=
"ddee643bd095104242afc3ddd3ddcbcfd6a4876febf47200a63f9e22996e1dec","src/tim=
e/clock.rs":"7588a33f5279ee683f39ce72a8d0a8dfcc2e25d3dbc29990e6829d7c2df7d9=
9b","src/time/mod.rs":"43afee938c80d124d04d4ba190c03f4d21d1e3bfc154fff30921=
1e4f6eabe940","src/time/timerfd.rs":"f17092b84553741aa2d2b44c6992b5d2c8c96c=
c2c2007fc9a2c6b2064485e53f","src/timespec.rs":"32a4d930cbc0f6dbd23153290db9=
20671cf4ce65a4a127e176f897c1cde42d7d","src/ugid.rs":"6616c6e35b7e43aee5b150=
f1efae7a50711e0947943c9a96833dbe214ad9e85f","src/utils.rs":"ad680ad8564cb7b=
37fc746e0b3f89d389278fe1b294ef343a5c4a37677414065","src/weak.rs":"7e3169bc9=
7e76fc4d52b040391a8df36b06536fc0f81cc6e8e71b951cb1fe54e"},"package":"aa2602=
29e6538e52293eeb577aabd09945a09d6d9cc0fc550ed7529056c2e32a"}
-\ No newline at end of file
-+{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231d2=
fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b0532d=
35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"8eafa99b133ffcf37520a4=
e62aecde1facf20c2577b1e74f2f93918d5d22a40c","LICENSE-APACHE":"a60eea8175145=
31668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2.0_WI=
TH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39ef1f9=
4f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a715d9d2=
b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12ba79e=
4cebb6983a7b6491949750aecc4f2178","README.md":"fbd9eb025cdb6c58d28649f0c913=
2a4e383014f03a8e0edba04a4e36cc45fba0","SECURITY.md":"4d75afb09dd28eb5982e3a=
1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e67273aa0=
a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"6d33904d1a=
456d968fe7433fa496e8db65185900467db85e42fc955a205793e5","src/backend/libc/c=
.rs":"acfbe7965e84e9bba1861924130d1383e9318040adc67e1e14d882bb8ac63562","sr=
c/backend/libc/conv.rs":"e8d55f9cc427d19de13bde83b50ce02faf0afd32121c8adb2a=
2cc9f551a562d6","src/backend/libc/event/epoll.rs":"6b68d0002519ad9894391562=
ca062aa02f696cc0a2a84bbe750891619f5b0c35","src/backend/libc/event/mod.rs":"=
ad30f99f7da0768c18fffac6ec71e658bfed2e44f0634f48c2e0ffe4677ec231","src/back=
end/libc/event/poll_fd.rs":"e8cd06835771505b3c803b17c6097e59cf8743f62b2c46d=
ccbe7afc9a90cfca5","src/backend/libc/event/syscalls.rs":"9f12487a288ceebc54=
997d63aabe1ff07084a7c30c8a6135ea903e25aa1d09ff","src/backend/libc/event/typ=
es.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f13","=
src/backend/libc/event/windows_syscalls.rs":"1b682b13c3fd2601fa7dd10a909467=
a8d9ffebed04f8f6c8bcd7ea8a89769c8c","src/backend/libc/fs/dir.rs":"836273d76=
4eb7c1cf09b5ed20baf20a99d9c9afdf448c9fda50f0927c173cc89","src/backend/libc/=
fs/inotify.rs":"69376ba2e81f98164029888d0cae554ca1702b532b0045dc55e282f1dd5=
2d7bb","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f329ad3=
5bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803011b5=
7da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc/fs/s=
yscalls.rs":"8da556f91f0a29fc5af7c6981f106594c628b564a370213a4c72a12cd03eb1=
68","src/backend/libc/fs/types.rs":"8012d86bcc5d1314d1d181cb81d9fff3855fa01=
ff3731b35e2a0484889f72188","src/backend/libc/io/errno.rs":"32da10e172113352=
87db5165955331d7bfebbab73513e0ef96014385a91aa06b","src/backend/libc/io/mod.=
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
/mod.rs":"ce2f388bdc8dac69ca9d1871ddc7ad01a7471a0de4b7f2bd67c8f11d0878fd87"=
,"src/backend/libc/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287=
b25a5bfe489fa1d07f7cfd7","src/backend/libc/mount/syscalls.rs":"d2d35f7ae989=
bb52722e28cdbd775243c5d7da9eb411e0b2b9632f2aa7c1533e","src/backend/libc/mou=
nt/types.rs":"5c2eaf22e7a29e8e48cb19e40c88d040ba1c891038a611e85571476489dc1=
2cb","src/backend/libc/net/addr.rs":"b9f5af8bfe0762deb346aabe87f8d325045439=
23a246ff97f9828a0bc36b893f","src/backend/libc/net/ext.rs":"cfce41130eb2e3dd=
04271e0aa2c1e2de9866397d7d2a59e917d26b784ea30df5","src/backend/libc/net/mod=
.rs":"562d23225d6dba8f095e3ca41af60dcf6cc40c2cf17bf028f90888f809e86f07","sr=
c/backend/libc/net/msghdr.rs":"6f8aba792b4adef5c5d3d4324a813a67a063a50d1043=
7bb19bf7496666bd6de6","src/backend/libc/net/netdevice.rs":"078bc108540457f0=
e5849c2b8d2f1351c4aaffc910f8c9c9857969477c22065e","src/backend/libc/net/rea=
d_sockaddr.rs":"b094d2cb84b2eee5dd411d21458192c03eea0e420e78149441d7ab88a89=
3281a","src/backend/libc/net/send_recv.rs":"b5714bed2cc6f2ba42bf90d19655b50=
7c2a248e2d05270b1355b6d4cb8e4f9fe","src/backend/libc/net/sockopt.rs":"4595b=
d3b182cdaa7bbefb94556ffd1dfcde81d5e20b298cd907eb7373d7b3b77","src/backend/l=
ibc/net/syscalls.rs":"552eb57bda272f2372e180f927a88dce67fcef46e7c1378d47d59=
5eb2abd578d","src/backend/libc/net/write_sockaddr.rs":"b62e40c9d4a4e70746d8=
64434db140b4b3c1f110a3fd2e7acfbb3f2ccf15d6aa","src/backend/libc/param/auxv.=
rs":"c29b29ad65f66e048debce5293bf84164811264e61b71a28a57225400d3b9529","src=
/backend/libc/param/mod.rs":"5234b8f1bcb886cca6ea003d411d75eaeebe58deedd80e=
3441354bf46ed85d4d","src/backend/libc/pid/mod.rs":"2c6478857a0751625edabd61=
acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/pid/syscalls.rs=
":"49ea679b96c0741d048e82964038f9a931bc3cf3a0b59c7db3df89629b9c49e6","src/b=
ackend/libc/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe=
489fa1d07f7cfd7","src/backend/libc/pipe/syscalls.rs":"7380b533adbc57b5ccd8d=
2d0b74e5968215b00047965fef8bf0a1208d914647f","src/backend/libc/pipe/types.r=
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
ibc/winsock_c.rs":"e150946d35781b462433d8412e0c99eed6214113bb90fbb251bf560b=
3beefa18","src/backend/linux_raw/arch/aarch64.rs":"2a255c9135bc8a321c180f52=
b88eb2b158bc9170cd222149caeae63c24587d44","src/backend/linux_raw/arch/arm.r=
s":"165bccb5883d0136e55d42091183765f83d86e9d37a7cb2cec9ae8af32774db6","src/=
backend/linux_raw/arch/mips.rs":"aca20118a73063e4f2f8e7b261b1266d216e826df2=
a98cad99c53c40b0971af4","src/backend/linux_raw/arch/mips32r6.rs":"a7ebd0886=
e2e0d3b39996778fb665b68738f8a67d67b47e43fdba7e7cabb6d1a","src/backend/linux=
_raw/arch/mips64.rs":"ba947f286522b8034d509887cff8183cca34766aed5d37c91667d=
ba22e2f608a","src/backend/linux_raw/arch/mips64r6.rs":"27de08ce1003a48f1d8b=
84746e724e8766b980e4ddc4febb6e20eb31067fb137","src/backend/linux_raw/arch/m=
od.rs":"ab348ddfbe57c3e3258f02416dd68503eb9f0521a2f52b73e4dc715ab6121f83","=
src/backend/linux_raw/arch/powerpc64.rs":"dfb001f8636a5e46d728900b0804fe6c3=
74e5e18a6f0e76d7d62e0c07da74477","src/backend/linux_raw/arch/riscv64.rs":"4=
1d33242d941030f46077dc2b1bc4c7913fe7630d693a5a7eef966bcf38f9d8b","src/backe=
nd/linux_raw/arch/s390x.rs":"5b30beb99a543c87c77428e488575bf9b6e7f07d790df5=
73e7be38ad5dd314a6","src/backend/linux_raw/arch/thumb.rs":"2fd979ab421248c0=
a4c592bc0cefee63edc26528f469b71b63eaed35356e42e8","src/backend/linux_raw/ar=
ch/x86.rs":"8fba9762bb0e8bb9a71890cdf413441aa52d2bf41690ec0ef01c97ac11759a5=
b","src/backend/linux_raw/arch/x86_64.rs":"e929036a1f3cf93ba538f4523b241605=
cc7b5e61f84ffe6d9d5cdbcb6f73e543","src/backend/linux_raw/c.rs":"7ae5c31185a=
fa5cc82ab2684faf7770c15e4ebd61f104e5c30e3fcafdd450287","src/backend/linux_r=
aw/conv.rs":"f4deb897dac6c99e465db1bf27a9194196e208105f0f00f040c9e56cadd9df=
51","src/backend/linux_raw/event/epoll.rs":"db05715e1bd3b93c6873695c89f04ab=
b97768a57e7e402306f568eba844e407a","src/backend/linux_raw/event/mod.rs":"72=
e46b04637e2d1d2a6b97af616144995399e489d1fe916faf835d72fc8c64cd","src/backen=
d/linux_raw/event/poll_fd.rs":"a5773464e9e30227b4046f029a27d3daf2c7bd0045e5=
4565cf1a8ac2a0d61e81","src/backend/linux_raw/event/syscalls.rs":"5bf5df8fe6=
7e246948a7bb40dd89176052ebf085ed50ca9856a49c3613b56a47","src/backend/linux_=
raw/event/types.rs":"0551b18f982e233a0a06d8a9c3dbb29de0c204dcd64dd6f7e88b6c=
96fa9a9be8","src/backend/linux_raw/fs/dir.rs":"fdf849d058c387551e102bd7fec3=
1e3ca40c18417a1e530cfed1daf3df2c4de3","src/backend/linux_raw/fs/inotify.rs"=
:"e627e8f48e8f4dc2117746117aaa7f151865103be64e446011c72878921e402e","src/ba=
ckend/linux_raw/fs/makedev.rs":"c6b4505c4bcbbc2460e80f3097eb15e2c8ef38d6c6e=
7abd78e39c53c372139e2","src/backend/linux_raw/fs/mod.rs":"3d3a42bbf4d086f80=
6d7d9f6e4b0a49a873dc27f4f03ffca0921f5536acc24e5","src/backend/linux_raw/fs/=
syscalls.rs":"6e2ca8d96be2bf94b38512d184a22d79385a6841419de2590f9e5af33d002=
920","src/backend/linux_raw/fs/types.rs":"6102a5b8207f959edbcc2fc233a6145a2=
65a428c0c4fa195472fe7fe6dc5165d","src/backend/linux_raw/io/errno.rs":"40cf9=
fbaee5c88b8e6293a1eeafa3498f3c0fe402b16a30ae97131795da0b404","src/backend/l=
inux_raw/io/mod.rs":"7ae2324427892cca6f5ab53858d847b165f790a72ec25f3d99fb15=
f0506c9f27","src/backend/linux_raw/io/syscalls.rs":"54ac1395fb4801ef2ec6639=
113a6e23c4b532d84b6495f7166fcd0492cea09f9","src/backend/linux_raw/io/types.=
rs":"d0df5a62248e1ba19af0f89f86da7ba2312d97065c2814ddf6b08a4a0db23bad","src=
/backend/linux_raw/io_uring/mod.rs":"2c6478857a0751625edabd61acb841819bfba1=
093b1faeded15693c805d84952","src/backend/linux_raw/io_uring/syscalls.rs":"7=
e40703cc3a020377a4a23bc8651bdf1d65b8f62e174eafb85d27d246f86c39d","src/backe=
nd/linux_raw/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe4=
89fa1d07f7cfd7","src/backend/linux_raw/mm/syscalls.rs":"c7fc0f49283026b0df4=
7463ed47394634e5664468f36a5eb2a89bf259bbfb67d","src/backend/linux_raw/mm/ty=
pes.rs":"821409c463a31954048075906b3fe5bdb029badf9c9e2689bfff8f6dbf5b0bed",=
"src/backend/linux_raw/mod.rs":"f849feea0a83df69fb9288ecfe07992cbdaee7e55d2=
9b5662043a3fdf00e4700","src/backend/linux_raw/mount/mod.rs":"8aa966faf3853d=
1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/=
mount/syscalls.rs":"8442c82814961f69c488222faabb82c44d2e7227b10faff919cbbd1=
97bb47484","src/backend/linux_raw/mount/types.rs":"9a33214816863fc92846fbc9=
9df6ddf60a3e772b34f4bb3f5e8a40ef489130d3","src/backend/linux_raw/net/addr.r=
s":"7239e4fa8c6872bf978e2f580563c51c72d6ae6f96b77520fc7b9ece62fa0ebe","src/=
backend/linux_raw/net/mod.rs":"5640bbaf4963ac4575b0537173422ed6f6a43f34a8f6=
b656e7257fbbb13e5bcb","src/backend/linux_raw/net/msghdr.rs":"8b18974b81ee78=
af7a5c64733041dddaaa378a46cab8b984bff5b3b4be499751","src/backend/linux_raw/=
net/netdevice.rs":"3cb28bcd762e2df595481b4379a08170f59f99d367aa03424531c19e=
4c5aaf55","src/backend/linux_raw/net/read_sockaddr.rs":"7cb3c8bcc80c5eee860=
2323cd83f36c1784927d9dd0c40ded29af6fb09c57ece","src/backend/linux_raw/net/s=
end_recv.rs":"d4e81c01db50dad1c02e9aa3e0979f8052431a3f64c8864681d9ea52a34ce=
3bf","src/backend/linux_raw/net/sockopt.rs":"95b5054469f3c9ba83ecd30a60e4ad=
b3dc444d36cc1a24ed57fb460626b475fd","src/backend/linux_raw/net/syscalls.rs"=
:"05d96523e459425ddb13ac86ed07467723f4c3bce7204115f94331bc96dbc712","src/ba=
ckend/linux_raw/net/write_sockaddr.rs":"0efa4e17b4008da2cf2aada2d18acfccd31=
a3b49cf8ac5d608e77f3ea6627fec","src/backend/linux_raw/param/auxv.rs":"d9082=
7ecdb2d9c98604bfd80419e533c3c200da4463b17e2bd8ffa0e061cd5c0","src/backend/l=
inux_raw/param/init.rs":"f2275a2324a99be8d804fb3b7fdf86a43c7d428f660280b7e0=
e7d19c357f0200","src/backend/linux_raw/param/libc_auxv.rs":"0a223ad36a33611=
370cdf3c666008fd61d15f2477fd3a5ac2c78972079fb86a9","src/backend/linux_raw/p=
aram/mod.rs":"2e6a1a1c00351b9c88bd615aa923f71d76208df5626dd9bea03067f28f81d=
c31","src/backend/linux_raw/pid/mod.rs":"2c6478857a0751625edabd61acb841819b=
fba1093b1faeded15693c805d84952","src/backend/linux_raw/pid/syscalls.rs":"ee=
f6aa01830ddd510b83f507da2002c03e58318b73744be2c06ebbe33c4f194f","src/backen=
d/linux_raw/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe=
489fa1d07f7cfd7","src/backend/linux_raw/pipe/syscalls.rs":"aebba454edd084bd=
5821243d8fd755cd2a841d5b620e8c9ce9c19a02fc5d00ac","src/backend/linux_raw/pi=
pe/types.rs":"ae643a774e6343df02b9b99b842fba8b742dd9b1f97b5c5b2b504f2840bf3=
fd2","src/backend/linux_raw/prctl/mod.rs":"2c6478857a0751625edabd61acb84181=
9bfba1093b1faeded15693c805d84952","src/backend/linux_raw/prctl/syscalls.rs"=
:"a18b224307e0d27bda9b7b85c75cd6c7ddfe39f5ce52efb7bb0bf0585b757343","src/ba=
ckend/linux_raw/process/cpu_set.rs":"b31889f972676f57e3599375dfcd59dd729759=
77ef345d11c22d51f0d4a6400b","src/backend/linux_raw/process/mod.rs":"fb393c7=
0a9c63ef9a6bf1fb5a2dc94f07d6b0b6987cc5231c15c607015dafd68","src/backend/lin=
ux_raw/process/syscalls.rs":"b9b6d542a39e021ab2b0b2128bdb436c22eb8c52556d18=
5f01c58f1a1d9412ed","src/backend/linux_raw/process/types.rs":"6811ba822bc12=
a1a6336649151b4adb1f5d3365684a31c07f01953ea9547743d","src/backend/linux_raw=
/process/wait.rs":"921aee4b0048746087f52615a98edc2aa0fb4b53d6df44be4533098d=
f55d1b05","src/backend/linux_raw/pty/mod.rs":"2c6478857a0751625edabd61acb84=
1819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/pty/syscalls.rs=
":"ae09c4aecc0ae87b1ca58d82efc58007b9dddaae78460d615f48da19d1cd0f89","src/b=
ackend/linux_raw/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25=
a5bfe489fa1d07f7cfd7","src/backend/linux_raw/rand/syscalls.rs":"317cdaf2436=
23329ee345131054e86a06a0863a9e90c5dba73e1ac3475ba6305","src/backend/linux_r=
aw/rand/types.rs":"a21dbb1ab31eed6b59a57520be5a3c603c36d18ea74e67f7527f4083=
5ba209a3","src/backend/linux_raw/reg.rs":"3e321750d91d77c835abd09b06b5851eb=
f3134d3affb3cce306e38329871bec4","src/backend/linux_raw/runtime/mod.rs":"b2=
cae8cce3822c3c92942f06ea0b68464040dcac33c6f0f7ee392c6269993347","src/backen=
d/linux_raw/runtime/syscalls.rs":"ad0e266f0eec81be6e104d1e02ebf61e149f4f3c2=
4d8f18cc4442adc313f3327","src/backend/linux_raw/runtime/tls.rs":"6316060560=
a112c2e9cd9807cdba6e8c91414113a04a739160929ae9a67bba1f","src/backend/linux_=
raw/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07=
f7cfd7","src/backend/linux_raw/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc=
5d56e12b4d93794540087b3182cbdf3cb9c8db","src/backend/linux_raw/shm/types.rs=
":"8275dba36a8f2c4208f2d23ffef52c5b02d4b10d5450733cb4fc5cdfcd6285ee","src/b=
ackend/linux_raw/system/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b=
25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/system/syscalls.rs":"19a7ab1=
7de906ec237f16a816da036723c1f55f605e8e4a26689343eb4cd76e7","src/backend/lin=
ux_raw/system/types.rs":"1ceab8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9=
e1d4f1447a016e","src/backend/linux_raw/termios/mod.rs":"2c6478857a0751625ed=
abd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/termi=
os/syscalls.rs":"1a42438153f61e72aab7c3c8fdd0c3ab918da0fec58e07bb4242351806=
5374e2","src/backend/linux_raw/thread/futex.rs":"0139394e11006301e98379b7f0=
7604aa10fb436b43acf8f55f1a24f1253f96cc","src/backend/linux_raw/thread/mod.r=
s":"6ad4a4b90b9234e79900b27ebbe8837e3a7a36aec532912e3e253edce5225067","src/=
backend/linux_raw/thread/syscalls.rs":"e2c89bd3cf34a46b5d06de43933284ddd06e=
d07e9c789c726c1afa48f7842a5c","src/backend/linux_raw/time/mod.rs":"672724f5=
5b7b7be6a7452bb1cc2d28b5f0aaa840a2856fe363acce624e1beefc","src/backend/linu=
x_raw/time/syscalls.rs":"7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9806e5=
de9404845312fc","src/backend/linux_raw/time/types.rs":"5f49ee7b201976114c65=
55f0c5a81d3305e18e726e54edc5a5474641f3cdc278","src/backend/linux_raw/ugid/m=
od.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","=
src/backend/linux_raw/ugid/syscalls.rs":"8c86d251db33b399a1d1cbb8e87afe650b=
78db84f444d3251309b7a0480b54f7","src/backend/linux_raw/vdso.rs":"056314f72c=
71d4b041739337ca2098afb7fe070f844327f462c293f43481b75b","src/backend/linux_=
raw/vdso_wrappers.rs":"4fa1fb04d5812c9edf143b3228327475f4021f6cd52c75beb51a=
eab4d1ad983e","src/bitcast.rs":"4d2b3619dac1500bee223e11db0b4a5f75b0fbde650=
94bab157597af71f6b72a","src/buffer.rs":"fbb262d0751546447ee95f1623d3f2eb450=
ff0b4a7e1df29c5a2c9cf205b8820","src/check_types.rs":"e52f710e1cfc12ca13a495=
f2b43c227b293ff295e1ce3ab332935b28a7579872","src/clockid.rs":"bd66d6bdc6b73=
a4668dda5b6f91838b6ed6c4b9503a0798b071ef35c572b711d","src/cstr.rs":"41af2a4=
429fe6c67a8883f8a8f63d66c90df566abda74fd2b03bcef7b9f24218","src/event/epoll=
.rs":"0d051674b9c1b3f118ad65e2b46b4b3cab5551d5dde4e1c40b3af14854a826c7","sr=
c/event/eventfd.rs":"81cbd08f7bdf40a6ce1ca692b63da1dc8ba925282990668d9d68f1=
203e839fa1","src/event/kqueue.rs":"1f381c8afa65d36e3052c476d2e679c3bccb7e3d=
6cc6b95ba53b48abcbe13a81","src/event/mod.rs":"deea3de6e5acbd876a9453c397d7b=
b20b818584ddef8e099729c9f2867432572","src/event/pause.rs":"930219e19ee22772=
9c8f86fe7271721e8797e917d2d7073fa8d7a104bf6189c0","src/event/poll.rs":"4de5=
f12e9cadd64e93e11e7b63248bf657700e6be2d8b40b0e5d5303eb34b4da","src/event/po=
rt.rs":"4e51ff150e5d17cbd44aa64a38b99c15e26eaaf2e350768b5dcacdfde4fa5212","=
src/event/select.rs":"49ca840bfd39202494fed201fd34742c30ae5d3d6c115d27b8c23=
2d2137105e3","src/ffi.rs":"50a14dfe10408f9abc6269b9ee6e7a88d99503d50b373228=
8e85b777915e579e","src/fs/abs.rs":"1c1e65be08da5f7d6e5b8902283855fef0f0a74a=
b227aae991aaf5310d0858f2","src/fs/at.rs":"68de994eb06fa90bf5b5088dc4ae280c6=
ac2222fcf137265d4256ce202869da1","src/fs/constants.rs":"23923e0fce3221bdac3=
71fe2d05028f30a87dba4f9b4a573b69dc2d6d39320b2","src/fs/copy_file_range.rs":=
"d3b644374390d482b2ff749a2459458872b57d0dcf9670368739b7833509a7c2","src/fs/=
cwd.rs":"3400dd3954aa0d806af1960054899447de5e425481edfad539bdd5fd0b9967d8",=
"src/fs/dir.rs":"347a52f4ca9ac6321c52e802e97ec90d1b4c62ec955c8996fc17f8f5ae=
d69966","src/fs/fadvise.rs":"d77f6a7f7f6648e750888719e59f0f8332f11e84442ef7=
2f622bcbd4e19be845","src/fs/fcntl.rs":"6aa6eb0c87fdd915974e425dd4881038c365=
8f05fac0bc005a9b40107474ef1b","src/fs/fcntl_apple.rs":"e2f23f038083621bcdec=
c98d02ce1023508afaecdb2ed0fba5c8b70f955301e5","src/fs/fcopyfile.rs":"ce565f=
61e1fbf2e31086077c2f1d01b6bb3b048915edda87fe9a4a4f5e8ff7e4","src/fs/fd.rs":=
"c9042ae0398dfbf39ec9ea8a0bebc6fa91ff76dc33f5aeb829313996036e4d66","src/fs/=
getpath.rs":"28f6970fc1bbc37bb35c84724b59eac436ea7407a4522e18c2bdacb1fdd2ed=
d9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f97189cea4e5982a0d35b192afeec6340a6=
c6222e0cb","src/fs/inotify.rs":"2e4b9824c323c661667aefe06383cd3e843a3467685=
2d9f5f79f62e48e975171","src/fs/ioctl.rs":"c8c6979fc7b0318796e2d760b86ff0495=
c679869439d9d6a8134c7acd704f4cc","src/fs/makedev.rs":"85520b484cb7c15ab71ea=
1c368578ea3b7e484d82f8510db92b6ce9f7ca341ae","src/fs/memfd_create.rs":"55a3=
d611184fe0e664f8e2a68cee359c4a65dfce0147305add139df65c292f01","src/fs/mod.r=
s":"0657052b4ce5934a3f7f95cbb16e06b75b10e4359142959d3d0a0ebe70fdc33a","src/=
fs/mount.rs":"8f6ea2b997dd83c50c90291b9ada3ed77a9ce1ad701c9b0d533b5113b317b=
e5b","src/fs/openat2.rs":"4a95c15dab533a41201b5fa25c8a212956b7571d58cad696b=
daf45af8aef96db","src/fs/raw_dir.rs":"6ad6d3dcdc6ddbb94f152b2584d7335e4b209=
d7219045ab4bdd6bdb2b7400e7c","src/fs/seek_from.rs":"a9efa0feb9ac789cf47667e=
91efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","src/fs/sendfile.rs":"e3b2058741=
cf4b1698f34d84bb37130cf2b72806d522a16fe541e832cde136cb","src/fs/special.rs"=
:"17a0f89f7462171169bbf5aa20a9ec934951fde7016daaed9bb1d12b468baf91","src/fs=
/statx.rs":"2844baac77fdda0d77823402bfbdbe5bf8983e1d3b229d700bf80c0c190f2aa=
5","src/fs/sync.rs":"84f24de0ea53f77bd5c471e097abcbecd19c4843b69607f9be9030=
eb7c9d5aa5","src/fs/xattr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6ca3a4720=
0532ca6e72d44cbe8334","src/io/close.rs":"b4f7c0dd39554463c9692a09c40744081e=
229b729610d7c530e084e92c63e8e5","src/io/dup.rs":"dd33bd405dd8368c2ef8073803=
ed1512cbe2c2d92194f3f38f44e766d2ff6ab3","src/io/errno.rs":"fe056ade492ef5b7=
e20fb9ffbc7e183b7bec6ff300587eb5197deaed5d321fda","src/io/fcntl.rs":"99fa69=
8c6a6c68ecece7e7d14e0a65e1b6e17d360f028e14f8800d42a355b22c","src/io/ioctl.r=
s":"e89a6e670fe1c06521aa2f266fcd7a990391a533995b787cabac223f0926c8c7","src/=
io/is_read_write.rs":"a7d3cc1b8673a94d64926c03984e24a627c24e78f09070a2eb893=
d8005abf9d7","src/io/mod.rs":"0b566bf43b3f8754153f361119f63aa08ff2450e9306e=
b7e35ac3619bfeeae0d","src/io/read_write.rs":"46fd5efcc1205f8195b6d55ad277f7=
1dcc62a2a52301dae03c0e5dbae6d70bd4","src/io_uring.rs":"4d163535b313a1798bea=
10190b8ff5211e8ef72ff822952a002af3b1c4946153","src/ioctl/bsd.rs":"d7d3f6813=
eac0e0f22fb8bcac3d193a22584393c1f7fa233999bd09c4e2059f7","src/ioctl/linux.r=
s":"61f006e31a4e049787415131beb97e548accb17fb6105d7ead5a12df0727077f","src/=
ioctl/mod.rs":"87e502a4de2f5ec029d64f606d3fda3831623f405434306e69f35a6aff5d=
3c04","src/ioctl/patterns.rs":"26116d5b5cd790ed485791e006c97c28590c038050c6=
9c42c752289fa7fcbc65","src/lib.rs":"b45ec754e76e48ae388a75d646a45a4c627fee8=
55b5c4616b80d72906c8daf1d","src/maybe_polyfill/no_std/io/mod.rs":"77889bb5c=
5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/maybe_polyfil=
l/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9cff3a19049d=
88c8c80","src/maybe_polyfill/no_std/net/mod.rs":"1e94d21d455bb1da18a4fccb24=
b3d93ad42698e22dd888b78115d6266c80288a","src/maybe_polyfill/no_std/os/fd/mo=
d.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e80771d507c47","s=
rc/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087cc9afd10269f09a8b41=
25915dc3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_std/os/fd/raw.rs":"=
f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999e7c6943","src/mayb=
e_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2fcc7c825310606b889cc=
8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/windows/io/mod.rs":"5bbc=
c05c83fee5026dd744a994e0458469466d5be39081baa62df07753b92fd2","src/maybe_po=
lyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49328b5637cb3bafb9643=
7f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/os/windows/io/socket=
.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5d2c64808308d65","sr=
c/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231a4e778b5f985b9ae712=
ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/std/mod.rs":"7c16c86=
cc73e226e65ead598e4018238b22000a345040b706bf1e1b3eba115fc","src/mm/madvise.=
rs":"092ff2064b16960369a908aeed70ec38a16fa2a0207f814cdea379e2f2286954","src=
/mm/mmap.rs":"1cc428e40ae77b23718ce821a22806c067fcaa7aabebf57df5cede7b7abb2=
bcc","src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761211a494ca6f89b2367a=
2d2157e340e","src/mm/msync.rs":"0cfb895703b8b7bac47426c8f03499f2aced3f4e1f3=
1008243a1a629e9d44a1d","src/mm/userfaultfd.rs":"8073443bd181ff0b3ba4d0b1ae6=
7370b4864035a0c8b4898cd709dc47c518ae7","src/mount/fsopen.rs":"1c54a02f04ee6=
710e2c5053c73361eecc499c24cd72c7c7c012dc57a4621e382","src/mount/mod.rs":"5f=
0c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d12a7136cb19","src/mount/=
mount_unmount.rs":"fa77675b023180b578b7fc053acb46ae2ed2eb11bb0488871bfd1ed2=
11df73a0","src/mount/types.rs":"601ae3e10b7dc496fed7f3b40a80e81c6edd7bf1318=
9d7be45c3212d4c684c39","src/net/mod.rs":"7899807c9ad9e3fdbfd8b3ce2a1c7053d4=
f46dd7fa76102f620c6042c2d6314f","src/net/netdevice.rs":"1d790ef6e33d30c3167=
ec422a95a711d6df26d69502cb0b4c4889623547d3693","src/net/send_recv/mod.rs":"=
ca923e7affc72bac1c67b3957f55a256dbdcd800c54ae866ebe71fb406ef79a8","src/net/=
send_recv/msg.rs":"7bbd89b593748d4ef63d76f1b47c429c48c2f5f3d4a6bfd9aa37373a=
c26a77a1","src/net/socket.rs":"f6e0c454eadb52a8ead30e04851bfe095d65fd1b83ae=
6419dac2030e69b3f7d5","src/net/socket_addr_any.rs":"88250bf218d3a626e8e04bb=
11d4dd50ddf1422bb28d780c98b80710cf9c30166","src/net/socketpair.rs":"aa9013d=
e19945bfea3f7d2889cc23abd384717b79f38cd5d045dec09c7517658","src/net/sockopt=
.rs":"416485d98afaa1cbc492e0dea06edc2137e2b2e6b15e16c2479dd92ae456c355","sr=
c/net/types.rs":"7b430c33a1bed0ebdb10f997d2c0c0227fe335ccd11d8446d9846627ae=
84a2a9","src/net/wsa.rs":"29856e6d0108be6b719f6ef973c5396e48ddd58ecd0c2db9c=
a3e2e0ba4eccb5b","src/param/auxv.rs":"b57483d3083a4dfad9ceb049fd96d54713b91=
b7f31b8c9a0e40501548da499ac","src/param/init.rs":"a31c0e5cea61a1a999767fe74=
f87c0d59eeb6bce66578b842fe0e0c32be27a55","src/param/mod.rs":"c514216b96d952=
0c9ffc5662c97b24f1f36f56fe1f5f3c9f64175c8b35577288","src/path/arg.rs":"ab5e=
d60c8cbf0484dce25440f027d7d511ea329bbaeaf83d70717f5c7e47b5ac","src/path/dec=
_int.rs":"0c71377fa5137595d6316ee135617ab8e514a2f539d77e15ef3a626d7aa092c9"=
,"src/path/mod.rs":"fbe294749100630467580f5e25b44e7a4f8a4512381cc18acaf1a68=
13afc39cd","src/pid.rs":"f1c486000c5b1311b2d720cee88f089c17ef9a171709673dd0=
6e6f35f4ff98a3","src/pipe.rs":"d5de91e5adb0ef8753e4c1ee5cfdff1f8bd80068af1f=
a3a12239a47da5131832","src/prctl.rs":"19aa584895874ea48b9bbe1bf695b81257b02=
81df64dfdd91e1b4bfa298661b7","src/process/chdir.rs":"93ce4fade85e720883f22e=
8b8a6c0c9b6ec3a07c37f457852b2c53aafeb8ad3e","src/process/chroot.rs":"01191e=
eb86295975874019dc675cb0f8f0ca5f79dd78dc9d1c791a952adb3512","src/process/ex=
it.rs":"f09000df82151d015a39b8cfe7dc28875074ad1bfde326f63be1438cf736d08e","=
src/process/id.rs":"21a487fe2384add719462f7cef500de0e286acf20ec5a6773c748ad=
e08b99aff","src/process/ioctl.rs":"c7f551152d65ac173d9eaa298b964339037b60a7=
b81e8bc316453718417a6be3","src/process/kill.rs":"674d06cf065c8045dbefb6fc64=
37a62b964069599fc03d84e64cc36186b96596","src/process/membarrier.rs":"1c4c39=
b359d1d0e9bbe16352eedfca9278d9ef298ade8ec00e998617bbcbfed8","src/process/mo=
d.rs":"a32691289982f4ffc53fef94fea4e3f375af9af87604fb962e94c54c9d91703b","s=
rc/process/pidfd.rs":"150413a9cc550ffc432b3279a368223fa9577544ef29e45edeff3=
b79ae316cab","src/process/pidfd_getfd.rs":"74c778b872be0b800870e4633606461f=
dc8493b259031e35f8f558768d960cc2","src/process/pivot_root.rs":"aeb2464464ef=
d81ca0b940e3e5e3ed1b09380f3e6ba3200972e0ba100f78badc","src/process/prctl.rs=
":"a34ccda958036f49c5e4a5d654566c2b18d59c4b48b31c91e63877191752712e","src/p=
rocess/priority.rs":"ea78f09e4564943d0083eba19d9933781a5dd70d5723f156eb16ad=
01dd67d89e","src/process/procctl.rs":"27e082d23267ef9a19dcbdd7eb33a1df26eef=
42894202a728bc1d8a3f1ff27e6","src/process/rlimit.rs":"10becde11d8b5d3b50aeb=
21a8fcdf53ec7803bdbbf8d1f4233b8e6c0b85fafb1","src/process/sched.rs":"4f5665=
93f7a6c12873ecb18f21b9806162791b33815c9147065d3c8d812b562c","src/process/sc=
hed_yield.rs":"8f80fef12e528628d19c26d26ecbad61b9644505a872a49f842820aa5201=
8cf8","src/process/umask.rs":"15841f5e178dd032f8b8def8545c9e98b205e6b1ba70b=
f9c07c2c0327a8999c0","src/process/wait.rs":"04d60c43e8ed1ac44e4ddc5ba6e18e5=
edf1c400565ea0e81ff8f1bf71403b7ba","src/procfs.rs":"adfac2c1232ff20c18251b8=
745f6732e3315b1adfe95b9e7297378dbcb290129","src/pty.rs":"5378adbc5b2cbbf84d=
f1c310559e2094e61321905c77e4a0107d634383320b5a","src/rand/getrandom.rs":"a8=
9f45838d22982eb0997bc905031819195701b64aa1c874e646dcb16d6e2a7d","src/rand/m=
od.rs":"e1fb7542f1958fe77673aa628bd92fef1b9addf79ba23df2398d1231cb61c148","=
src/runtime.rs":"58abe84feb409ec5a97df922253d127f032e54d0b44989f2a9dff4852a=
1b7ce0","src/shm.rs":"30b32e302ad2d198de411981f3c7609082bc20f1c0651aa3f3ce2=
beb8f19c6e9","src/signal.rs":"0fcce2e37f69d70cfef1f355355979b269820281a6e63=
bd171ba05e525063e79","src/static_assertions.rs":"504cf66f0d5b8e335be02f9ae8=
b0a355abc98c2c82eec0098bdf0988e662e260","src/stdio.rs":"85e66975a55f91bfb76=
4f848eab34acf1bf6ca7f37b6421043d1e2003ec14805","src/system.rs":"4954f5261bd=
25fd01ba6c97a1a0afa9cad4d768a1c10491d33b3bf2d0bba8371","src/termios/ioctl.r=
s":"aa26694c9be5378ea52e669313e64b25fc034e3863b72281530c42499570fedf","src/=
termios/mod.rs":"b44b7caa60b6f458657ed58a0e0eca41bb4e6d6be4b0f042bbb8ab7056=
cebe4b","src/termios/tc.rs":"bafcc607de993c7e7c4cd6f15a59e7807906e59bf991a5=
a4c67e3b076d07e3f2","src/termios/tty.rs":"0013cc4c31907246b45c4b94ded0171dc=
0d3e6759740f5424831feae700092f7","src/termios/types.rs":"d4cbd4bae530c2e669=
31f8ad178177cef04ad49567be4abb7046ac7ce926919f","src/thread/clock.rs":"cc4a=
981b7fc059cc88da709e31381c778d75c22f1b96cad5fa2799a45ecfef5a","src/thread/f=
utex.rs":"b4a182cd4b490dab620c5fc59adfe79845c2e64f624cb8d9096a9375a0597b21"=
,"src/thread/id.rs":"1a9a8b4bfe71dba6aec17760ca9de5a66a80b9c608fa0eeb30fd1b=
c949e511ca","src/thread/libcap.rs":"4c51b7df566d38dd0f85f81ef53279a745a39f0=
f4e1154791fd38438e2ca7db1","src/thread/mod.rs":"d6d9c3340cd9710869813ea9c99=
3669d11620126edc66e5657a9de2a07a5f864","src/thread/prctl.rs":"3826dda31b945=
2b2a8b30158b6babd0b536fe9ea314027863d14c3888c9435ee","src/thread/setns.rs":=
"ddee643bd095104242afc3ddd3ddcbcfd6a4876febf47200a63f9e22996e1dec","src/tim=
e/clock.rs":"7588a33f5279ee683f39ce72a8d0a8dfcc2e25d3dbc29990e6829d7c2df7d9=
9b","src/time/mod.rs":"43afee938c80d124d04d4ba190c03f4d21d1e3bfc154fff30921=
1e4f6eabe940","src/time/timerfd.rs":"f17092b84553741aa2d2b44c6992b5d2c8c96c=
c2c2007fc9a2c6b2064485e53f","src/timespec.rs":"32a4d930cbc0f6dbd23153290db9=
20671cf4ce65a4a127e176f897c1cde42d7d","src/ugid.rs":"6616c6e35b7e43aee5b150=
f1efae7a50711e0947943c9a96833dbe214ad9e85f","src/utils.rs":"ad680ad8564cb7b=
37fc746e0b3f89d389278fe1b294ef343a5c4a37677414065","src/weak.rs":"7e3169bc9=
7e76fc4d52b040391a8df36b06536fc0f81cc6e8e71b951cb1fe54e"},"package":"aa2602=
29e6538e52293eeb577aabd09945a09d6d9cc0fc550ed7529056c2e32a"}
diff --git a/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-fix.patc=
h b/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-fix.patch
new file mode 100644
index 0000000..451ab9c
--- /dev/null
+++ b/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-fix.patch
@@ -0,0 +1,236 @@
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
+
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
+
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
+@@ -11,7 +11,7 @@ use {
+
+ use bitflags::bitflags;
+
+-#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
++#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
+ use crate::fd::{AsRawFd, BorrowedFd};
+
+ /// `ioctl(fd, BLKSSZGET)`=E2=80=94Returns the logical block size of a bl=
ock device.
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
+@ -71,10 +71,10 @@ pub fn ext4_ioc_resize_fs<Fd: AsFd>(fd: Fd, blocks: u64=
) -> io::Result<()> {
+     }
+ }
+
+-#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
++#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
+ struct Ficlone<'a>(BorrowedFd<'a>);
+
+-#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
++#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
+ unsafe impl ioctl::Ioctl for Ficlone<'_> {
+     type Output =3D ();
+
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
+diff --git a/vendor/rustix-0.38.40/src/termios/types.rs b/vendor/rustix-0.=
38.40/src/termios/types.rs
+index 7b97808a15..6f61e64ab9 100644
+--- a/vendor/rustix-0.38.40/src/termios/types.rs
++++ b/vendor/rustix-0.38.40/src/termios/types.rs
+@@ -1209,17 +1209,17 @@ impl core::fmt::Debug for SpecialCodeIndex {
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
+
+@@ -1227,12 +1227,12 @@ impl core::fmt::Debug for SpecialCodeIndex {
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
+
+@@ -1250,7 +1250,7 @@ impl core::fmt::Debug for SpecialCodeIndex {
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
+diff --git a/vendor/rustix-0.38.40/src/fs/ioctl.rs b/vendor/rustix-0.38.40=
/src/fs/ioctl.rs
+index 718a2a4048..68ae13bea3 100644
+--- a/vendor/rustix-0.38.40/src/fs/ioctl.rs
++++ b/vendor/rustix-0.38.40/src/fs/ioctl.rs
+@@ -11,7 +11,7 @@ use {
+
+ use bitflags::bitflags;
+
+-#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
++#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
+ use crate::fd::{AsRawFd, BorrowedFd};
+
+ /// `ioctl(fd, BLKSSZGET)`=E2=80=94Returns the logical block size of a bl=
ock device.
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
+@@ -71,15 +71,15 @@ pub fn ext4_ioc_resize_fs<Fd: AsFd>(fd: Fd, blocks: u6=
4) -> io::Result<()> {
+     }
+ }
+
+-#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
++#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
+ struct Ficlone<'a>(BorrowedFd<'a>);
+
+-#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64"))))]
++#[cfg(all(linux_kernel, not(any(target_arch =3D "sparc", target_arch =3D =
"sparc64", target_arch =3D "riscv32"))))]
+ unsafe impl ioctl::Ioctl for Ficlone<'_> {
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
+diff --git a/vendor/rustix-0.38.40/src/backend/libc/c.rs b/vendor/rustix-0=
.38.40/src/backend/libc/c.rs
+index ec140a3272..85c3d1c0c8 100644
+--- a/vendor/rustix-0.38.40/src/backend/libc/c.rs
++++ b/vendor/rustix-0.38.40/src/backend/libc/c.rs
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
35973392af16ffb9596a41d99d202cf3617c9","Cargo.lock":"f1c8eff0bb0360850c0325=
983799479a32464fde1c18dfd30eb04e4bc6a15bae","Cargo.toml":"a362ec65b559b77cc=
803264b97d53ea761c9ee98787012128054d6ad1a3d0c2b","LICENSE-APACHE":"a60eea81=
7514531668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2=
.0_WITH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39=
ef1f94f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a71=
5d9d2b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12=
ba79e4cebb6983a7b6491949750aecc4f2178","README.md":"fbd9eb025cdb6c58d28649f=
0c9132a4e383014f03a8e0edba04a4e36cc45fba0","SECURITY.md":"4d75afb09dd28eb59=
82e3a1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e672=
73aa0a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"adc4b=
c868a30a902f328af6ebd0bfc72868b8e388beb13c6d69d826646931b17","src/backend/l=
ibc/c.rs":"e111414bce945426bbca53cd018e74300d57089a63b546652a62f63f52ba25e2=
","src/backend/libc/conv.rs":"e8d55f9cc427d19de13bde83b50ce02faf0afd32121c8=
adb2a2cc9f551a562d6","src/backend/libc/event/epoll.rs":"6b68d0002519ad98943=
91562ca062aa02f696cc0a2a84bbe750891619f5b0c35","src/backend/libc/event/mod.=
rs":"ad30f99f7da0768c18fffac6ec71e658bfed2e44f0634f48c2e0ffe4677ec231","src=
/backend/libc/event/poll_fd.rs":"e8cd06835771505b3c803b17c6097e59cf8743f62b=
2c46dccbe7afc9a90cfca5","src/backend/libc/event/syscalls.rs":"7ea9d27dfbc5f=
e5f873e9dd1a1059f42327c099b84f543718a612a0512dfbbc9","src/backend/libc/even=
t/types.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f=
13","src/backend/libc/event/windows_syscalls.rs":"ebfac665c6676c4b803134ab8=
806be8aa2e96bdbc7799a19c544cd9069b35787","src/backend/libc/fs/dir.rs":"8362=
73d764eb7c1cf09b5ed20baf20a99d9c9afdf448c9fda50f0927c173cc89","src/backend/=
libc/fs/inotify.rs":"69376ba2e81f98164029888d0cae554ca1702b532b0045dc55e282=
f1dd52d7bb","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f3=
29ad35bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803=
011b57da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc=
/fs/syscalls.rs":"dbce2106ab58e7fcd1aeeb3aa1f361aacdfdda1171a1a0f49aebc4e88=
f2333a7","src/backend/libc/fs/types.rs":"b1ffff2b0a0c56dcb3507431a0100c7050=
5ea7549ac5267752842d7e30500529","src/backend/libc/io/errno.rs":"bd1a92ffc3f=
632ae7292b7006a7c890433a3bee8d67a63c299333850a91e99be","src/backend/libc/io=
/mod.rs":"746647bd864e4ec7717925b6d176cebdb392b7d015070244cc48d92780351dd6"=
,"src/backend/libc/io/syscalls.rs":"91ebf37b8abdecf619c9bc3521b1b4c6795369c=
668753586e1af79d04fb982b0","src/backend/libc/io/types.rs":"2efd39bb3df19a9d=
b5496217284f3d2235ddb354fac81dd71861109a56bede0b","src/backend/libc/io/wind=
ows_syscalls.rs":"24f7abe92406f3f65c1a42a4694c2112142106a341d024ffc2d5905a9=
f289339","src/backend/libc/io_uring/mod.rs":"2c6478857a0751625edabd61acb841=
819bfba1093b1faeded15693c805d84952","src/backend/libc/io_uring/syscalls.rs"=
:"5221a498e6c396d7c4cb60168ce8459ebca7d6720349a426d8083c227c694212","src/ba=
ckend/libc/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489=
fa1d07f7cfd7","src/backend/libc/mm/syscalls.rs":"c04c61ad3d7f3b24d13f89144d=
7fa0a05658cea4763207f9250db4f9362de2fe","src/backend/libc/mm/types.rs":"40b=
7888a1439afae2705e0c724ae0821a51d32ca5740f1ec16ecb6dc1adc883d","src/backend=
/libc/mod.rs":"087d2676df88510b089255053a4865e62c64172723588386fe8244d2f1a6=
81c4","src/backend/libc/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539=
b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/mount/syscalls.rs":"d2d35f7=
ae989bb52722e28cdbd775243c5d7da9eb411e0b2b9632f2aa7c1533e","src/backend/lib=
c/mount/types.rs":"5c2eaf22e7a29e8e48cb19e40c88d040ba1c891038a611e855714764=
89dc12cb","src/backend/libc/net/addr.rs":"920ff7645055ca4e7d4019b9dd4ea1f21=
1b708a62ef5d4049494f8dd3fe8d2aa","src/backend/libc/net/ext.rs":"cfce41130eb=
2e3dd04271e0aa2c1e2de9866397d7d2a59e917d26b784ea30df5","src/backend/libc/ne=
t/mod.rs":"562d23225d6dba8f095e3ca41af60dcf6cc40c2cf17bf028f90888f809e86f07=
","src/backend/libc/net/msghdr.rs":"6f8aba792b4adef5c5d3d4324a813a67a063a50=
d10437bb19bf7496666bd6de6","src/backend/libc/net/netdevice.rs":"078bc108540=
457f0e5849c2b8d2f1351c4aaffc910f8c9c9857969477c22065e","src/backend/libc/ne=
t/read_sockaddr.rs":"b094d2cb84b2eee5dd411d21458192c03eea0e420e78149441d7ab=
88a893281a","src/backend/libc/net/send_recv.rs":"b5714bed2cc6f2ba42bf90d196=
55b507c2a248e2d05270b1355b6d4cb8e4f9fe","src/backend/libc/net/sockopt.rs":"=
0f424615b2982826da6e57e9b0bb38442288152464f67508fa5bd66a6d0c9827","src/back=
end/libc/net/syscalls.rs":"552eb57bda272f2372e180f927a88dce67fcef46e7c1378d=
47d595eb2abd578d","src/backend/libc/net/write_sockaddr.rs":"b62e40c9d4a4e70=
746d864434db140b4b3c1f110a3fd2e7acfbb3f2ccf15d6aa","src/backend/libc/param/=
auxv.rs":"c29b29ad65f66e048debce5293bf84164811264e61b71a28a57225400d3b9529"=
,"src/backend/libc/param/mod.rs":"5234b8f1bcb886cca6ea003d411d75eaeebe58dee=
dd80e3441354bf46ed85d4d","src/backend/libc/pid/mod.rs":"2c6478857a0751625ed=
abd61acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/pid/syscal=
ls.rs":"49ea679b96c0741d048e82964038f9a931bc3cf3a0b59c7db3df89629b9c49e6","=
src/backend/libc/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25=
a5bfe489fa1d07f7cfd7","src/backend/libc/pipe/syscalls.rs":"219c31200f333ce8=
03370bcbfcca529f7635c51b31e4576269faaa6b288cd920","src/backend/libc/pipe/ty=
pes.rs":"f87e43bae418d00fe8b333877acc3b6aab4cf4d123f02ff048a21866486e1404",=
"src/backend/libc/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b=
1faeded15693c805d84952","src/backend/libc/prctl/syscalls.rs":"8a2684f444a75=
55098dce2b92270d81cefdae902716c6e5d59bd7b0657e8a29d","src/backend/libc/proc=
ess/cpu_set.rs":"5fca2b47289a2bb6ba908c910a6d27ac78ac10ea21d3c0c018f72f8816=
c5b9d7","src/backend/libc/process/mod.rs":"806e26da8d1e7afae502987fcd650f4d=
348da147b8a2e74447affdca153e2e97","src/backend/libc/process/syscalls.rs":"b=
4a7d09cf46c65997a28dc5f075e90943b2581b7df99cd66cdd18e87fe96600b","src/backe=
nd/libc/process/types.rs":"fb2caf34b17079aa72c04aed0f9a31d534ea8e8b73a80c75=
8b748bf5e38df52b","src/backend/libc/process/wait.rs":"0cc556aed976b4bbb3965=
f74fd76b8216c755fce25043b7b21ce54afa07c9773","src/backend/libc/pty/mod.rs":=
"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/bac=
kend/libc/pty/syscalls.rs":"566fc9a2cb2e38d7d7ac2405b22c0522369cae4a8f4fe18=
b55123ba94d3d5a95","src/backend/libc/rand/mod.rs":"8aa966faf3853d1a93d0ed91=
f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/rand/syscalls.r=
s":"35ea6b6e0f8a7fb064fd5cb33a3a855cd161a6a00f93d76c861b2a2c66db85e7","src/=
backend/libc/rand/types.rs":"4eb0b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a7=
05ec605b773f63f880","src/backend/libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91=
f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/shm/syscalls.rs=
":"60d797d4e85e08e6330e6b8d80094356ce377e5484952f88ae2a6e49231c268c","src/b=
ackend/libc/shm/types.rs":"0a1ac6bb9c024d94eb4bab7452937b7befcb30c581dc787b=
805011407ba1442d","src/backend/libc/system/mod.rs":"38563ea68829ca5a4b1b069=
5ac8a5c05718e85bdc88a36dc805efdfce45d3909","src/backend/libc/system/syscall=
s.rs":"c18c2942811ea93af3125b58d00a1da05c54e5ff438a3dc44cda53bc9d6fcf03","s=
rc/backend/libc/system/types.rs":"6871e16aee14fe2ae03cea798c3e509ffe44778a9=
c0e5608fd73e2e015876d7e","src/backend/libc/termios/mod.rs":"2c6478857a07516=
25edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/termio=
s/syscalls.rs":"2720e443c118e1c0311dbb3efa4b54637b6e607bb123ccdc0f5d92b5628=
573c2","src/backend/libc/thread/futex.rs":"064463c4a4f6549aec0797d44e44b862=
eb0100efe97aa293b4dad10034cae800","src/backend/libc/thread/mod.rs":"fa71005=
3974d7f16a6c49242ee6c10a3b9e1143452b9daeaed8837302a679fff","src/backend/lib=
c/thread/syscalls.rs":"4cb65db4fe0c7d6016dd0dfefa610b369234b6b9db0c75c0fcb9=
ab8cb25a16ac","src/backend/libc/time/mod.rs":"38563ea68829ca5a4b1b0695ac8a5=
c05718e85bdc88a36dc805efdfce45d3909","src/backend/libc/time/syscalls.rs":"b=
f847e94cc156bdb553755baa88dac240db4dcaf690f303b0f205777c5a9cdfc","src/backe=
nd/libc/time/types.rs":"d0307994ffddd3f21f702d9ae4400750aecccfaf4a01268161d=
c4fd72de5c373","src/backend/libc/ugid/mod.rs":"2c6478857a0751625edabd61acb8=
41819bfba1093b1faeded15693c805d84952","src/backend/libc/ugid/syscalls.rs":"=
8edf91b8790add23902c9f5418da6b0723a371677f29f490e0c8af852f0f1a0c","src/back=
end/libc/winsock_c.rs":"502da2ed3cd6ca99bb7ee08b0b30e25c212632885cec965f981=
6366c6b931ac6","src/backend/linux_raw/arch/aarch64.rs":"2a255c9135bc8a321c1=
80f52b88eb2b158bc9170cd222149caeae63c24587d44","src/backend/linux_raw/arch/=
arm.rs":"165bccb5883d0136e55d42091183765f83d86e9d37a7cb2cec9ae8af32774db6",=
"src/backend/linux_raw/arch/mips.rs":"aca20118a73063e4f2f8e7b261b1266d216e8=
26df2a98cad99c53c40b0971af4","src/backend/linux_raw/arch/mips32r6.rs":"a7eb=
d0886e2e0d3b39996778fb665b68738f8a67d67b47e43fdba7e7cabb6d1a","src/backend/=
linux_raw/arch/mips64.rs":"ba947f286522b8034d509887cff8183cca34766aed5d37c9=
1667dba22e2f608a","src/backend/linux_raw/arch/mips64r6.rs":"27de08ce1003a48=
f1d8b84746e724e8766b980e4ddc4febb6e20eb31067fb137","src/backend/linux_raw/a=
rch/mod.rs":"37eaeea601d39be00d170856a31a8ec6a27b0d3ac22ab3ee642ab0e45dee23=
7d","src/backend/linux_raw/arch/powerpc64.rs":"dfb001f8636a5e46d728900b0804=
fe6c374e5e18a6f0e76d7d62e0c07da74477","src/backend/linux_raw/arch/riscv64.r=
s":"41d33242d941030f46077dc2b1bc4c7913fe7630d693a5a7eef966bcf38f9d8b","src/=
backend/linux_raw/arch/thumb.rs":"2fd979ab421248c0a4c592bc0cefee63edc26528f=
469b71b63eaed35356e42e8","src/backend/linux_raw/arch/x86.rs":"8fba9762bb0e8=
bb9a71890cdf413441aa52d2bf41690ec0ef01c97ac11759a5b","src/backend/linux_raw=
/arch/x86_64.rs":"e929036a1f3cf93ba538f4523b241605cc7b5e61f84ffe6d9d5cdbcb6=
f73e543","src/backend/linux_raw/c.rs":"445e311dc24a176603008d0a7d7714a56482=
1db3179052da797027f8fc7ae4fc","src/backend/linux_raw/conv.rs":"43e62870f91a=
480e10e2485546c95e70e61c72f96306921c796a7094ea404d3c","src/backend/linux_ra=
w/event/epoll.rs":"db05715e1bd3b93c6873695c89f04abb97768a57e7e402306f568eba=
844e407a","src/backend/linux_raw/event/mod.rs":"72e46b04637e2d1d2a6b97af616=
144995399e489d1fe916faf835d72fc8c64cd","src/backend/linux_raw/event/poll_fd=
.rs":"a5773464e9e30227b4046f029a27d3daf2c7bd0045e54565cf1a8ac2a0d61e81","sr=
c/backend/linux_raw/event/syscalls.rs":"5620d7dd5fbcfef550cfa94df7593caffe0=
deccf0f754765751e562edb7d2b2f","src/backend/linux_raw/event/types.rs":"0551=
b18f982e233a0a06d8a9c3dbb29de0c204dcd64dd6f7e88b6c96fa9a9be8","src/backend/=
linux_raw/fs/dir.rs":"fdf849d058c387551e102bd7fec31e3ca40c18417a1e530cfed1d=
af3df2c4de3","src/backend/linux_raw/fs/inotify.rs":"e627e8f48e8f4dc21177461=
17aaa7f151865103be64e446011c72878921e402e","src/backend/linux_raw/fs/makede=
v.rs":"c6b4505c4bcbbc2460e80f3097eb15e2c8ef38d6c6e7abd78e39c53c372139e2","s=
rc/backend/linux_raw/fs/mod.rs":"3d3a42bbf4d086f806d7d9f6e4b0a49a873dc27f4f=
03ffca0921f5536acc24e5","src/backend/linux_raw/fs/syscalls.rs":"6e2ca8d96be=
2bf94b38512d184a22d79385a6841419de2590f9e5af33d002920","src/backend/linux_r=
aw/fs/types.rs":"6102a5b8207f959edbcc2fc233a6145a265a428c0c4fa195472fe7fe6d=
c5165d","src/backend/linux_raw/io/errno.rs":"5d1c95eacf1794be6c2ea83e40b602=
3ae86abc2c83ca16de6c70a2020fb905c6","src/backend/linux_raw/io/mod.rs":"7ae2=
324427892cca6f5ab53858d847b165f790a72ec25f3d99fb15f0506c9f27","src/backend/=
linux_raw/io/syscalls.rs":"54ac1395fb4801ef2ec6639113a6e23c4b532d84b6495f71=
66fcd0492cea09f9","src/backend/linux_raw/io/types.rs":"d0df5a62248e1ba19af0=
f89f86da7ba2312d97065c2814ddf6b08a4a0db23bad","src/backend/linux_raw/io_uri=
ng/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d8495=
2","src/backend/linux_raw/io_uring/syscalls.rs":"7e40703cc3a020377a4a23bc86=
51bdf1d65b8f62e174eafb85d27d246f86c39d","src/backend/linux_raw/mm/mod.rs":"=
8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/back=
end/linux_raw/mm/syscalls.rs":"c7fc0f49283026b0df47463ed47394634e5664468f36=
a5eb2a89bf259bbfb67d","src/backend/linux_raw/mm/types.rs":"821409c463a31954=
048075906b3fe5bdb029badf9c9e2689bfff8f6dbf5b0bed","src/backend/linux_raw/mo=
d.rs":"f849feea0a83df69fb9288ecfe07992cbdaee7e55d29b5662043a3fdf00e4700","s=
rc/backend/linux_raw/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b02=
87b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mount/syscalls.rs":"8442c=
82814961f69c488222faabb82c44d2e7227b10faff919cbbd197bb47484","src/backend/l=
inux_raw/mount/types.rs":"9a33214816863fc92846fbc99df6ddf60a3e772b34f4bb3f5=
e8a40ef489130d3","src/backend/linux_raw/net/addr.rs":"7239e4fa8c6872bf978e2=
f580563c51c72d6ae6f96b77520fc7b9ece62fa0ebe","src/backend/linux_raw/net/mod=
.rs":"5640bbaf4963ac4575b0537173422ed6f6a43f34a8f6b656e7257fbbb13e5bcb","sr=
c/backend/linux_raw/net/msghdr.rs":"8b18974b81ee78af7a5c64733041dddaaa378a4=
6cab8b984bff5b3b4be499751","src/backend/linux_raw/net/netdevice.rs":"3cb28b=
cd762e2df595481b4379a08170f59f99d367aa03424531c19e4c5aaf55","src/backend/li=
nux_raw/net/read_sockaddr.rs":"7cb3c8bcc80c5eee8602323cd83f36c1784927d9dd0c=
40ded29af6fb09c57ece","src/backend/linux_raw/net/send_recv.rs":"d4e81c01db5=
0dad1c02e9aa3e0979f8052431a3f64c8864681d9ea52a34ce3bf","src/backend/linux_r=
aw/net/sockopt.rs":"d7dc73886a6c0671b3bdc4cbe8c49def8dc5416864f9387bc5aee72=
319c5b162","src/backend/linux_raw/net/syscalls.rs":"0138662012ca89e063b3a03=
cf8fe17b97fbeb38a3d18c42938ae047a4a392105","src/backend/linux_raw/net/write=
_sockaddr.rs":"0efa4e17b4008da2cf2aada2d18acfccd31a3b49cf8ac5d608e77f3ea662=
7fec","src/backend/linux_raw/param/auxv.rs":"af132fa16b37a17c43ed5d099b2778=
9d456f3cb92abb81139231bf9407599858","src/backend/linux_raw/param/init.rs":"=
f2275a2324a99be8d804fb3b7fdf86a43c7d428f660280b7e0e7d19c357f0200","src/back=
end/linux_raw/param/libc_auxv.rs":"0a223ad36a33611370cdf3c666008fd61d15f247=
7fd3a5ac2c78972079fb86a9","src/backend/linux_raw/param/mod.rs":"2e6a1a1c003=
51b9c88bd615aa923f71d76208df5626dd9bea03067f28f81dc31","src/backend/linux_r=
aw/pid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d=
84952","src/backend/linux_raw/pid/syscalls.rs":"eef6aa01830ddd510b83f507da2=
002c03e58318b73744be2c06ebbe33c4f194f","src/backend/linux_raw/pipe/mod.rs":=
"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/bac=
kend/linux_raw/pipe/syscalls.rs":"ce1f72fcf0cb7772e6d9bd5791a39aef329ca7f72=
9fd47431a93b950cf0568d8","src/backend/linux_raw/pipe/types.rs":"ae643a774e6=
343df02b9b99b842fba8b742dd9b1f97b5c5b2b504f2840bf3fd2","src/backend/linux_r=
aw/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c80=
5d84952","src/backend/linux_raw/prctl/syscalls.rs":"a18b224307e0d27bda9b7b8=
5c75cd6c7ddfe39f5ce52efb7bb0bf0585b757343","src/backend/linux_raw/process/c=
pu_set.rs":"b31889f972676f57e3599375dfcd59dd72975977ef345d11c22d51f0d4a6400=
b","src/backend/linux_raw/process/mod.rs":"fb393c70a9c63ef9a6bf1fb5a2dc94f0=
7d6b0b6987cc5231c15c607015dafd68","src/backend/linux_raw/process/syscalls.r=
s":"4c7e3e5aad98b63162e110deb1f58b15b46b9c5fe7fd0f579e1c7dc1c3d2df16","src/=
backend/linux_raw/process/types.rs":"6811ba822bc12a1a6336649151b4adb1f5d336=
5684a31c07f01953ea9547743d","src/backend/linux_raw/process/wait.rs":"921aee=
4b0048746087f52615a98edc2aa0fb4b53d6df44be4533098df55d1b05","src/backend/li=
nux_raw/pty/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693=
c805d84952","src/backend/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae87b1ca58d=
82efc58007b9dddaae78460d615f48da19d1cd0f89","src/backend/linux_raw/rand/mod=
.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","sr=
c/backend/linux_raw/rand/syscalls.rs":"317cdaf243623329ee345131054e86a06a08=
63a9e90c5dba73e1ac3475ba6305","src/backend/linux_raw/rand/types.rs":"a21dbb=
1ab31eed6b59a57520be5a3c603c36d18ea74e67f7527f40835ba209a3","src/backend/li=
nux_raw/reg.rs":"6bfb53575494f5de76d5112a7e4eb6d0c266b1af0a275aa33b9bc9e6e7=
a2f41c","src/backend/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92942f06ea0=
b68464040dcac33c6f0f7ee392c6269993347","src/backend/linux_raw/runtime/sysca=
lls.rs":"ec1c43952f8a518ff152cb798ca6a67432030568a9d355532254b68cabd20d2c",=
"src/backend/linux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cdba6e8c914=
14113a04a739160929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":"8aa966fa=
f3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linu=
x_raw/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d93794540087b318=
2cbdf3cb9c8db","src/backend/linux_raw/shm/types.rs":"8275dba36a8f2c4208f2d2=
3ffef52c5b02d4b10d5450733cb4fc5cdfcd6285ee","src/backend/linux_raw/system/m=
od.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","=
src/backend/linux_raw/system/syscalls.rs":"19a7ab17de906ec237f16a816da03672=
3c1f55f605e8e4a26689343eb4cd76e7","src/backend/linux_raw/system/types.rs":"=
1ceab8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e","src/back=
end/linux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1f=
aeded15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":"1a424381=
53f61e72aab7c3c8fdd0c3ab918da0fec58e07bb42423518065374e2","src/backend/linu=
x_raw/thread/futex.rs":"0139394e11006301e98379b7f07604aa10fb436b43acf8f55f1=
a24f1253f96cc","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90b9234e79900b=
27ebbe8837e3a7a36aec532912e3e253edce5225067","src/backend/linux_raw/thread/=
syscalls.rs":"e2c89bd3cf34a46b5d06de43933284ddd06ed07e9c789c726c1afa48f7842=
a5c","src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7452bb1cc2d28b5f=
0aaa840a2856fe363acce624e1beefc","src/backend/linux_raw/time/syscalls.rs":"=
7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de9404845312fc","src/back=
end/linux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a81d3305e18e726e54e=
dc5a5474641f3cdc278","src/backend/linux_raw/ugid/mod.rs":"2c6478857a0751625=
edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/ugi=
d/syscalls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db84f444d3251309b7a0480=
b54f7","src/backend/linux_raw/vdso.rs":"056314f72c71d4b041739337ca2098afb7f=
e070f844327f462c293f43481b75b","src/backend/linux_raw/vdso_wrappers.rs":"96=
9022478cb48b9b81a549853720f76c2c276a746e25d17c0762f76b377a73b0","src/bitcas=
t.rs":"4d2b3619dac1500bee223e11db0b4a5f75b0fbde65094bab157597af71f6b72a","s=
rc/buffer.rs":"e75713877ba12f4a5c9b482df79b219363965d5311809ecf6b6becf1eabb=
5e46","src/check_types.rs":"e52f710e1cfc12ca13a495f2b43c227b293ff295e1ce3ab=
332935b28a7579872","src/clockid.rs":"bd66d6bdc6b73a4668dda5b6f91838b6ed6c4b=
9503a0798b071ef35c572b711d","src/cstr.rs":"41af2a4429fe6c67a8883f8a8f63d66c=
90df566abda74fd2b03bcef7b9f24218","src/event/epoll.rs":"0d051674b9c1b3f118a=
d65e2b46b4b3cab5551d5dde4e1c40b3af14854a826c7","src/event/eventfd.rs":"81cb=
d08f7bdf40a6ce1ca692b63da1dc8ba925282990668d9d68f1203e839fa1","src/event/kq=
ueue.rs":"1f381c8afa65d36e3052c476d2e679c3bccb7e3d6cc6b95ba53b48abcbe13a81"=
,"src/event/mod.rs":"4dd296e8feeb0e29b9b63eeeae6169786f76fdd6138489795a5829=
a189d3ac1a","src/event/pause.rs":"930219e19ee227729c8f86fe7271721e8797e917d=
2d7073fa8d7a104bf6189c0","src/event/poll.rs":"f8da99d1136502040314259ab7700=
570bf40df0ea85b94dcdf6f5d1c4073551d","src/event/port.rs":"4e51ff150e5d17cbd=
44aa64a38b99c15e26eaaf2e350768b5dcacdfde4fa5212","src/ffi.rs":"50a14dfe1040=
8f9abc6269b9ee6e7a88d99503d50b3732288e85b777915e579e","src/fs/abs.rs":"1c1e=
65be08da5f7d6e5b8902283855fef0f0a74ab227aae991aaf5310d0858f2","src/fs/at.rs=
":"b95242387489425714589bc84cf8f3943f3a02f57cc6ab4347c4eaf648b09e5d","src/f=
s/constants.rs":"23923e0fce3221bdac371fe2d05028f30a87dba4f9b4a573b69dc2d6d3=
9320b2","src/fs/copy_file_range.rs":"d3b644374390d482b2ff749a2459458872b57d=
0dcf9670368739b7833509a7c2","src/fs/cwd.rs":"0933a06846a20c12fb12cb556c0313=
3d37349d104e4f2d99379a674d1cf78562","src/fs/dir.rs":"347a52f4ca9ac6321c52e8=
02e97ec90d1b4c62ec955c8996fc17f8f5aed69966","src/fs/fadvise.rs":"d77f6a7f7f=
6648e750888719e59f0f8332f11e84442ef72f622bcbd4e19be845","src/fs/fcntl.rs":"=
6aa6eb0c87fdd915974e425dd4881038c3658f05fac0bc005a9b40107474ef1b","src/fs/f=
cntl_apple.rs":"e2f23f038083621bcdecc98d02ce1023508afaecdb2ed0fba5c8b70f955=
301e5","src/fs/fcopyfile.rs":"ce565f61e1fbf2e31086077c2f1d01b6bb3b048915edd=
a87fe9a4a4f5e8ff7e4","src/fs/fd.rs":"31943a4eef1ee6909d7db48b0d577b44297897=
26d851e7aa4f9af43e87722b6a","src/fs/getpath.rs":"28f6970fc1bbc37bb35c84724b=
59eac436ea7407a4522e18c2bdacb1fdd2edd9","src/fs/id.rs":"1b5c8a8baf9a9bb1f89=
5f97189cea4e5982a0d35b192afeec6340a6c6222e0cb","src/fs/inotify.rs":"2e4b982=
4c323c661667aefe06383cd3e843a34676852d9f5f79f62e48e975171","src/fs/ioctl.rs=
":"1d17e7be9ef4f9f69358bf474a669f0eeb0e8516a3626befc1bf61bee0221d89","src/f=
s/makedev.rs":"85520b484cb7c15ab71ea1c368578ea3b7e484d82f8510db92b6ce9f7ca3=
41ae","src/fs/memfd_create.rs":"a8bf1dced54c7592e71da896021338d5092c1693d12=
cc42e79bac435fab2792b","src/fs/mod.rs":"600a5ddd606d60460ec887dbeb843fdcf1b=
5204ed8d95eb0abbd89f33eae6e66","src/fs/mount.rs":"8f6ea2b997dd83c50c90291b9=
ada3ed77a9ce1ad701c9b0d533b5113b317be5b","src/fs/openat2.rs":"4a95c15dab533=
a41201b5fa25c8a212956b7571d58cad696bdaf45af8aef96db","src/fs/raw_dir.rs":"6=
ad6d3dcdc6ddbb94f152b2584d7335e4b209d7219045ab4bdd6bdb2b7400e7c","src/fs/se=
ek_from.rs":"a9efa0feb9ac789cf47667e91efee2e3f2dcde16cb3b7a928c99da640fa0e0=
d6","src/fs/sendfile.rs":"e3b2058741cf4b1698f34d84bb37130cf2b72806d522a16fe=
541e832cde136cb","src/fs/statx.rs":"2844baac77fdda0d77823402bfbdbe5bf8983e1=
d3b229d700bf80c0c190f2aa5","src/fs/sync.rs":"84f24de0ea53f77bd5c471e097abcb=
ecd19c4843b69607f9be9030eb7c9d5aa5","src/fs/xattr.rs":"5e222adb52caf69d949a=
b3f944fb2a482dd6ca3a47200532ca6e72d44cbe8334","src/io/close.rs":"8348b501ef=
238323a671c1a25bddab8db27a5b40cecf0e7cef87356d593a1b64","src/io/dup.rs":"0b=
1b00b44a8ed2c6b04e1221d28462c4cc0ff281c2be89d90c67ed8c484fc08b","src/io/err=
no.rs":"fe056ade492ef5b7e20fb9ffbc7e183b7bec6ff300587eb5197deaed5d321fda","=
src/io/fcntl.rs":"82fcaf2c817b1bba477bf3dc6c21068de9647ed2f004123632c6d82e4=
cb28b70","src/io/ioctl.rs":"e89a6e670fe1c06521aa2f266fcd7a990391a533995b787=
cabac223f0926c8c7","src/io/is_read_write.rs":"a7d3cc1b8673a94d64926c03984e2=
4a627c24e78f09070a2eb893d8005abf9d7","src/io/mod.rs":"0b566bf43b3f8754153f3=
61119f63aa08ff2450e9306eb7e35ac3619bfeeae0d","src/io/read_write.rs":"ae6b5f=
a883a7925a77ebf1164c1ac56ce97251514de9a6f8b86786f3f60d59be","src/io_uring.r=
s":"72b542dc8372b211563a69970992a7170afc75058163202c3ef4d61fcbc60f59","src/=
ioctl/bsd.rs":"d7d3f6813eac0e0f22fb8bcac3d193a22584393c1f7fa233999bd09c4e20=
59f7","src/ioctl/linux.rs":"61f006e31a4e049787415131beb97e548accb17fb6105d7=
ead5a12df0727077f","src/ioctl/mod.rs":"87e502a4de2f5ec029d64f606d3fda383162=
3f405434306e69f35a6aff5d3c04","src/ioctl/patterns.rs":"bd6e309c8b548dfe04aa=
ffe805972582fb56a0b717c45b45447630bdf9b88433","src/lib.rs":"753a0460cddec22=
11758fa15eff0bdeb5fde04a64f76b079df3c9b68d8809eaf","src/maybe_polyfill/no_s=
td/io/mod.rs":"77889bb5c5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae7=
5747","src/maybe_polyfill/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc956=
67e1d47d958e9cff3a19049d88c8c80","src/maybe_polyfill/no_std/net/mod.rs":"1e=
94d21d455bb1da18a4fccb24b3d93ad42698e22dd888b78115d6266c80288a","src/maybe_=
polyfill/no_std/os/fd/mod.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66e=
c967d95e80771d507c47","src/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf=
28087cc9afd10269f09a8b4125915dc3288b6427c79f5b4c58ab751","src/maybe_polyfil=
l/no_std/os/fd/raw.rs":"f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962=
736999e7c6943","src/maybe_polyfill/no_std/os/mod.rs":"27dab639a765827644005=
d5f2fcc7c825310606b889cc8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/=
windows/io/mod.rs":"5bbcc05c83fee5026dd744a994e0458469466d5be39081baa62df07=
753b92fd2","src/maybe_polyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd9=
38a49328b5637cb3bafb96437f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_=
std/os/windows/io/socket.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2a=
f4dc5d2c64808308d65","src/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f=
8f231a4e778b5f985b9ae712ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyf=
ill/std/mod.rs":"7c16c86cc73e226e65ead598e4018238b22000a345040b706bf1e1b3eb=
a115fc","src/mm/madvise.rs":"e6cfda8ec16ec98cc21255c2cc666e51b4d5858bb85983=
ee92b2b1e5dd35e54f","src/mm/mmap.rs":"7957d672f37f37ffdb2a03a223699ade2f45a=
7adc3aa659d731cd6d4e794ef35","src/mm/mod.rs":"b3a6cb838986d45825b912355cede=
ad761211a494ca6f89b2367a2d2157e340e","src/mm/msync.rs":"1285604c7dbf34cdc16=
d6e9fb03c5d67038867127f12adfcd06e6257d89ae971","src/mm/userfaultfd.rs":"807=
3443bd181ff0b3ba4d0b1ae67370b4864035a0c8b4898cd709dc47c518ae7","src/mount/f=
sopen.rs":"1c54a02f04ee6710e2c5053c73361eecc499c24cd72c7c7c012dc57a4621e382=
","src/mount/mod.rs":"5f0c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d=
12a7136cb19","src/mount/mount_unmount.rs":"fa77675b023180b578b7fc053acb46ae=
2ed2eb11bb0488871bfd1ed211df73a0","src/mount/types.rs":"601ae3e10b7dc496fed=
7f3b40a80e81c6edd7bf13189d7be45c3212d4c684c39","src/net/mod.rs":"7899807c9a=
d9e3fdbfd8b3ce2a1c7053d4f46dd7fa76102f620c6042c2d6314f","src/net/netdevice.=
rs":"1d790ef6e33d30c3167ec422a95a711d6df26d69502cb0b4c4889623547d3693","src=
/net/send_recv/mod.rs":"e888cbda77db981db039060200b458a856c932acc1258001eac=
147b5df9b63bf","src/net/send_recv/msg.rs":"39f7460204af2e71331d07259bc4c9a2=
cc3e9937bba72430a5b85e7054f5a46d","src/net/socket.rs":"151ac4b46f81ca1b2ee9=
8f60f43e4d32d6327eb1bbfed050b0dc0c4241ab3100","src/net/socket_addr_any.rs":=
"88250bf218d3a626e8e04bb11d4dd50ddf1422bb28d780c98b80710cf9c30166","src/net=
/socketpair.rs":"008115435028fa3533739362efab3ff9d8209e49e70040eaa23578711f=
900456","src/net/sockopt.rs":"d6ce0e65912e0d6d450c9dc870d4de7340f6f5308c5b2=
1c7d3d66463b9d0577e","src/net/types.rs":"7b430c33a1bed0ebdb10f997d2c0c0227f=
e335ccd11d8446d9846627ae84a2a9","src/net/wsa.rs":"29856e6d0108be6b719f6ef97=
3c5396e48ddd58ecd0c2db9ca3e2e0ba4eccb5b","src/param/auxv.rs":"b57483d3083a4=
dfad9ceb049fd96d54713b91b7f31b8c9a0e40501548da499ac","src/param/init.rs":"a=
31c0e5cea61a1a999767fe74f87c0d59eeb6bce66578b842fe0e0c32be27a55","src/param=
/mod.rs":"c514216b96d9520c9ffc5662c97b24f1f36f56fe1f5f3c9f64175c8b35577288"=
,"src/path/arg.rs":"ab5ed60c8cbf0484dce25440f027d7d511ea329bbaeaf83d70717f5=
c7e47b5ac","src/path/dec_int.rs":"0c71377fa5137595d6316ee135617ab8e514a2f53=
9d77e15ef3a626d7aa092c9","src/path/mod.rs":"fbe294749100630467580f5e25b44e7=
a4f8a4512381cc18acaf1a6813afc39cd","src/pid.rs":"f1c486000c5b1311b2d720cee8=
8f089c17ef9a171709673dd06e6f35f4ff98a3","src/pipe.rs":"48ff976a2b50f679a0e0=
aa6d7938fb88f56bde6804360bcef259cf5f524d75ff","src/prctl.rs":"19aa584895874=
ea48b9bbe1bf695b81257b0281df64dfdd91e1b4bfa298661b7","src/process/chdir.rs"=
:"7caffd22e586fc448eaf55ca9ec9e41ad462626278f08352623bd1c88a91488a","src/pr=
ocess/chroot.rs":"01191eeb86295975874019dc675cb0f8f0ca5f79dd78dc9d1c791a952=
adb3512","src/process/exit.rs":"f09000df82151d015a39b8cfe7dc28875074ad1bfde=
326f63be1438cf736d08e","src/process/id.rs":"21a487fe2384add719462f7cef500de=
0e286acf20ec5a6773c748ade08b99aff","src/process/ioctl.rs":"c7f551152d65ac17=
3d9eaa298b964339037b60a7b81e8bc316453718417a6be3","src/process/kill.rs":"67=
4d06cf065c8045dbefb6fc6437a62b964069599fc03d84e64cc36186b96596","src/proces=
s/membarrier.rs":"1c4c39b359d1d0e9bbe16352eedfca9278d9ef298ade8ec00e998617b=
bcbfed8","src/process/mod.rs":"a32691289982f4ffc53fef94fea4e3f375af9af87604=
fb962e94c54c9d91703b","src/process/pidfd.rs":"150413a9cc550ffc432b3279a3682=
23fa9577544ef29e45edeff3b79ae316cab","src/process/pidfd_getfd.rs":"74c778b8=
72be0b800870e4633606461fdc8493b259031e35f8f558768d960cc2","src/process/pivo=
t_root.rs":"aeb2464464efd81ca0b940e3e5e3ed1b09380f3e6ba3200972e0ba100f78bad=
c","src/process/prctl.rs":"a34ccda958036f49c5e4a5d654566c2b18d59c4b48b31c91=
e63877191752712e","src/process/priority.rs":"ea78f09e4564943d0083eba19d9933=
781a5dd70d5723f156eb16ad01dd67d89e","src/process/procctl.rs":"3cf13470c19c6=
758a28d7f3bacde1c1e4393ee702742cdfbfa45dce58cebd602","src/process/rlimit.rs=
":"10becde11d8b5d3b50aeb21a8fcdf53ec7803bdbbf8d1f4233b8e6c0b85fafb1","src/p=
rocess/sched.rs":"4f566593f7a6c12873ecb18f21b9806162791b33815c9147065d3c8d8=
12b562c","src/process/sched_yield.rs":"8f80fef12e528628d19c26d26ecbad61b964=
4505a872a49f842820aa52018cf8","src/process/umask.rs":"15841f5e178dd032f8b8d=
ef8545c9e98b205e6b1ba70bf9c07c2c0327a8999c0","src/process/wait.rs":"04d60c4=
3e8ed1ac44e4ddc5ba6e18e5edf1c400565ea0e81ff8f1bf71403b7ba","src/procfs.rs":=
"adfac2c1232ff20c18251b8745f6732e3315b1adfe95b9e7297378dbcb290129","src/pty=
.rs":"3c045b9ce8c24cf380de77f9c5640b6adc1774d6df5c2e5639b965560960ba8d","sr=
c/rand/getrandom.rs":"a89f45838d22982eb0997bc905031819195701b64aa1c874e646d=
cb16d6e2a7d","src/rand/mod.rs":"e1fb7542f1958fe77673aa628bd92fef1b9addf79ba=
23df2398d1231cb61c148","src/runtime.rs":"723558853e479dd33eb5c1448a23fb7ab4=
ce007356d55978a28245b0d8f73668","src/shm.rs":"30b32e302ad2d198de411981f3c76=
09082bc20f1c0651aa3f3ce2beb8f19c6e9","src/signal.rs":"0fcce2e37f69d70cfef1f=
355355979b269820281a6e63bd171ba05e525063e79","src/static_assertions.rs":"50=
4cf66f0d5b8e335be02f9ae8b0a355abc98c2c82eec0098bdf0988e662e260","src/stdio.=
rs":"ffa955a09e16c47ac11f4be9cbfdf07b2b4ffc0cdbc9bf70f0a49dbae2d7a188","src=
/system.rs":"7eae745660ca4a7c4885424af2fc89025ae7e51636ea9c8714f0a9b90d979d=
be","src/termios/ioctl.rs":"aa26694c9be5378ea52e669313e64b25fc034e3863b7228=
1530c42499570fedf","src/termios/mod.rs":"b44b7caa60b6f458657ed58a0e0eca41bb=
4e6d6be4b0f042bbb8ab7056cebe4b","src/termios/tc.rs":"bafcc607de993c7e7c4cd6=
f15a59e7807906e59bf991a5a4c67e3b076d07e3f2","src/termios/tty.rs":"0013cc4c3=
1907246b45c4b94ded0171dc0d3e6759740f5424831feae700092f7","src/termios/types=
.rs":"6a69789f7bd4783839b18f5e41f2444afc021c5d5f861bd75939ec53308d11af","sr=
c/thread/clock.rs":"71f1c545f29e672f242ab017029d20cba98e0546340280354047409=
8ffb04399","src/thread/futex.rs":"cb6d58120194ea869df407761136e4e98cc7d7756=
1547203b74ca1a5dd9e0958","src/thread/id.rs":"1a9a8b4bfe71dba6aec17760ca9de5=
a66a80b9c608fa0eeb30fd1bc949e511ca","src/thread/libcap.rs":"4c51b7df566d38d=
d0f85f81ef53279a745a39f0f4e1154791fd38438e2ca7db1","src/thread/mod.rs":"d6d=
9c3340cd9710869813ea9c993669d11620126edc66e5657a9de2a07a5f864","src/thread/=
prctl.rs":"3826dda31b9452b2a8b30158b6babd0b536fe9ea314027863d14c3888c9435ee=
","src/thread/setns.rs":"ddee643bd095104242afc3ddd3ddcbcfd6a4876febf47200a6=
3f9e22996e1dec","src/time/clock.rs":"7588a33f5279ee683f39ce72a8d0a8dfcc2e25=
d3dbc29990e6829d7c2df7d99b","src/time/mod.rs":"43afee938c80d124d04d4ba190c0=
3f4d21d1e3bfc154fff309211e4f6eabe940","src/time/timerfd.rs":"f17092b8455374=
1aa2d2b44c6992b5d2c8c96cc2c2007fc9a2c6b2064485e53f","src/timespec.rs":"32a4=
d930cbc0f6dbd23153290db920671cf4ce65a4a127e176f897c1cde42d7d","src/ugid.rs"=
:"6616c6e35b7e43aee5b150f1efae7a50711e0947943c9a96833dbe214ad9e85f","src/ut=
ils.rs":"ad680ad8564cb7b37fc746e0b3f89d389278fe1b294ef343a5c4a37677414065",=
"src/weak.rs":"7e3169bc97e76fc4d52b040391a8df36b06536fc0f81cc6e8e71b951cb1f=
e54e"},"package":"8acb788b847c24f28525660c4d7758620a7210875711f79e7f663cc15=
2726811"}
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
c661667aefe06383cd3e843a34676852d9f5f79f62e48e975171","src/fs/ioctl.rs":"d7=
2bda8c3be1ed20c0e90b8a6d66db5021e97465779ac8dacfbef56c251428bc","src/fs/mak=
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
+diff --git a/vendor/rustix-0.38.40/.cargo-checksum.json b/vendor/rustix-0.=
38.40/.cargo-checksum.json
+index 649a506966..7d30530f1e 100644
+--- a/vendor/rustix-0.38.40/.cargo-checksum.json
++++ b/vendor/rustix-0.38.40/.cargo-checksum.json
+@@ -1 +1 @@
+-{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231d2=
fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b0532d=
35973392af16ffb9596a41d99d202cf3617c9","Cargo.lock":"3d1f975c4b771dc29807d5=
e42c2951cf5f5d9fc42ebf7295ab2cc7d57076cba8","Cargo.toml":"24a05853ab82f1405=
7d4f40517cf26e5b3f630b6f96d133275ce18030517d76e","LICENSE-APACHE":"a60eea81=
7514531668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2=
.0_WITH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39=
ef1f94f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a71=
5d9d2b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12=
ba79e4cebb6983a7b6491949750aecc4f2178","README.md":"fbd9eb025cdb6c58d28649f=
0c9132a4e383014f03a8e0edba04a4e36cc45fba0","SECURITY.md":"4d75afb09dd28eb59=
82e3a1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e672=
73aa0a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"7cc60=
a1a80836bff6c4f82dd938049dcec84736100bb81ebe6ac84513b0f4a45","src/backend/l=
ibc/c.rs":"e111414bce945426bbca53cd018e74300d57089a63b546652a62f63f52ba25e2=
","src/backend/libc/conv.rs":"85b9b0e1ed6cff8240c9c462af5a769d5b0537ec94e41=
db51ffbd95b3513ec80","src/backend/libc/event/epoll.rs":"6b68d0002519ad98943=
91562ca062aa02f696cc0a2a84bbe750891619f5b0c35","src/backend/libc/event/mod.=
rs":"554bcf6d614a99c32d021d0a2eb3018705f516120d4e2e52d4376cd835f3f28c","src=
/backend/libc/event/poll_fd.rs":"f187dbb2a2eea2cfff86d2956991fd6b9df3599f91=
a494b5b61e00296bf5ed5c","src/backend/libc/event/syscalls.rs":"fdd3b51a6e3f9=
bbd673e07acffa657b626f826a5853564ffb1b8d735aa05e9d7","src/backend/libc/even=
t/types.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f=
13","src/backend/libc/event/windows_syscalls.rs":"1b682b13c3fd2601fa7dd10a9=
09467a8d9ffebed04f8f6c8bcd7ea8a89769c8c","src/backend/libc/fs/dir.rs":"8362=
73d764eb7c1cf09b5ed20baf20a99d9c9afdf448c9fda50f0927c173cc89","src/backend/=
libc/fs/inotify.rs":"69376ba2e81f98164029888d0cae554ca1702b532b0045dc55e282=
f1dd52d7bb","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f3=
29ad35bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803=
011b57da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc=
/fs/syscalls.rs":"14132f6d90ed66e04b29984b02cc24ef101644f9351e3bcabc521cabe=
19f110b","src/backend/libc/fs/types.rs":"a4300df90596e144d895c8286c2eb00fdb=
446e7001dc5368506ed3da02970fe0","src/backend/libc/io/errno.rs":"32da10e1721=
1335287db5165955331d7bfebbab73513e0ef96014385a91aa06b","src/backend/libc/io=
/mod.rs":"746647bd864e4ec7717925b6d176cebdb392b7d015070244cc48d92780351dd6"=
,"src/backend/libc/io/syscalls.rs":"91ebf37b8abdecf619c9bc3521b1b4c6795369c=
668753586e1af79d04fb982b0","src/backend/libc/io/types.rs":"2efd39bb3df19a9d=
b5496217284f3d2235ddb354fac81dd71861109a56bede0b","src/backend/libc/io/wind=
ows_syscalls.rs":"24f7abe92406f3f65c1a42a4694c2112142106a341d024ffc2d5905a9=
f289339","src/backend/libc/io_uring/mod.rs":"2c6478857a0751625edabd61acb841=
819bfba1093b1faeded15693c805d84952","src/backend/libc/io_uring/syscalls.rs"=
:"5221a498e6c396d7c4cb60168ce8459ebca7d6720349a426d8083c227c694212","src/ba=
ckend/libc/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489=
fa1d07f7cfd7","src/backend/libc/mm/syscalls.rs":"c04c61ad3d7f3b24d13f89144d=
7fa0a05658cea4763207f9250db4f9362de2fe","src/backend/libc/mm/types.rs":"40b=
7888a1439afae2705e0c724ae0821a51d32ca5740f1ec16ecb6dc1adc883d","src/backend=
/libc/mod.rs":"ce2f388bdc8dac69ca9d1871ddc7ad01a7471a0de4b7f2bd67c8f11d0878=
fd87","src/backend/libc/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539=
b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/mount/syscalls.rs":"d2d35f7=
ae989bb52722e28cdbd775243c5d7da9eb411e0b2b9632f2aa7c1533e","src/backend/lib=
c/mount/types.rs":"5c2eaf22e7a29e8e48cb19e40c88d040ba1c891038a611e855714764=
89dc12cb","src/backend/libc/net/addr.rs":"b9f5af8bfe0762deb346aabe87f8d3250=
4543923a246ff97f9828a0bc36b893f","src/backend/libc/net/ext.rs":"cfce41130eb=
2e3dd04271e0aa2c1e2de9866397d7d2a59e917d26b784ea30df5","src/backend/libc/ne=
t/mod.rs":"562d23225d6dba8f095e3ca41af60dcf6cc40c2cf17bf028f90888f809e86f07=
","src/backend/libc/net/msghdr.rs":"6f8aba792b4adef5c5d3d4324a813a67a063a50=
d10437bb19bf7496666bd6de6","src/backend/libc/net/netdevice.rs":"078bc108540=
457f0e5849c2b8d2f1351c4aaffc910f8c9c9857969477c22065e","src/backend/libc/ne=
t/read_sockaddr.rs":"b094d2cb84b2eee5dd411d21458192c03eea0e420e78149441d7ab=
88a893281a","src/backend/libc/net/send_recv.rs":"b5714bed2cc6f2ba42bf90d196=
55b507c2a248e2d05270b1355b6d4cb8e4f9fe","src/backend/libc/net/sockopt.rs":"=
4595bd3b182cdaa7bbefb94556ffd1dfcde81d5e20b298cd907eb7373d7b3b77","src/back=
end/libc/net/syscalls.rs":"552eb57bda272f2372e180f927a88dce67fcef46e7c1378d=
47d595eb2abd578d","src/backend/libc/net/write_sockaddr.rs":"b62e40c9d4a4e70=
746d864434db140b4b3c1f110a3fd2e7acfbb3f2ccf15d6aa","src/backend/libc/param/=
auxv.rs":"c29b29ad65f66e048debce5293bf84164811264e61b71a28a57225400d3b9529"=
,"src/backend/libc/param/mod.rs":"5234b8f1bcb886cca6ea003d411d75eaeebe58dee=
dd80e3441354bf46ed85d4d","src/backend/libc/pid/mod.rs":"2c6478857a0751625ed=
abd61acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/pid/syscal=
ls.rs":"49ea679b96c0741d048e82964038f9a931bc3cf3a0b59c7db3df89629b9c49e6","=
src/backend/libc/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25=
a5bfe489fa1d07f7cfd7","src/backend/libc/pipe/syscalls.rs":"7380b533adbc57b5=
ccd8d2d0b74e5968215b00047965fef8bf0a1208d914647f","src/backend/libc/pipe/ty=
pes.rs":"f87e43bae418d00fe8b333877acc3b6aab4cf4d123f02ff048a21866486e1404",=
"src/backend/libc/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b=
1faeded15693c805d84952","src/backend/libc/prctl/syscalls.rs":"8a2684f444a75=
55098dce2b92270d81cefdae902716c6e5d59bd7b0657e8a29d","src/backend/libc/proc=
ess/cpu_set.rs":"5fca2b47289a2bb6ba908c910a6d27ac78ac10ea21d3c0c018f72f8816=
c5b9d7","src/backend/libc/process/mod.rs":"806e26da8d1e7afae502987fcd650f4d=
348da147b8a2e74447affdca153e2e97","src/backend/libc/process/syscalls.rs":"b=
4a7d09cf46c65997a28dc5f075e90943b2581b7df99cd66cdd18e87fe96600b","src/backe=
nd/libc/process/types.rs":"fb2caf34b17079aa72c04aed0f9a31d534ea8e8b73a80c75=
8b748bf5e38df52b","src/backend/libc/process/wait.rs":"0cc556aed976b4bbb3965=
f74fd76b8216c755fce25043b7b21ce54afa07c9773","src/backend/libc/pty/mod.rs":=
"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/bac=
kend/libc/pty/syscalls.rs":"757cc928b6121cda7517801cb837efbcdfcd4f785b80019=
ba8bf0100d6af1dde","src/backend/libc/rand/mod.rs":"8aa966faf3853d1a93d0ed91=
f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/rand/syscalls.r=
s":"35ea6b6e0f8a7fb064fd5cb33a3a855cd161a6a00f93d76c861b2a2c66db85e7","src/=
backend/libc/rand/types.rs":"4eb0b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a7=
05ec605b773f63f880","src/backend/libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91=
f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/shm/syscalls.rs=
":"60d797d4e85e08e6330e6b8d80094356ce377e5484952f88ae2a6e49231c268c","src/b=
ackend/libc/shm/types.rs":"0a1ac6bb9c024d94eb4bab7452937b7befcb30c581dc787b=
805011407ba1442d","src/backend/libc/system/mod.rs":"38563ea68829ca5a4b1b069=
5ac8a5c05718e85bdc88a36dc805efdfce45d3909","src/backend/libc/system/syscall=
s.rs":"c18c2942811ea93af3125b58d00a1da05c54e5ff438a3dc44cda53bc9d6fcf03","s=
rc/backend/libc/system/types.rs":"6871e16aee14fe2ae03cea798c3e509ffe44778a9=
c0e5608fd73e2e015876d7e","src/backend/libc/termios/mod.rs":"2c6478857a07516=
25edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/termio=
s/syscalls.rs":"2720e443c118e1c0311dbb3efa4b54637b6e607bb123ccdc0f5d92b5628=
573c2","src/backend/libc/thread/futex.rs":"064463c4a4f6549aec0797d44e44b862=
eb0100efe97aa293b4dad10034cae800","src/backend/libc/thread/mod.rs":"fa71005=
3974d7f16a6c49242ee6c10a3b9e1143452b9daeaed8837302a679fff","src/backend/lib=
c/thread/syscalls.rs":"4cb65db4fe0c7d6016dd0dfefa610b369234b6b9db0c75c0fcb9=
ab8cb25a16ac","src/backend/libc/time/mod.rs":"38563ea68829ca5a4b1b0695ac8a5=
c05718e85bdc88a36dc805efdfce45d3909","src/backend/libc/time/syscalls.rs":"b=
f847e94cc156bdb553755baa88dac240db4dcaf690f303b0f205777c5a9cdfc","src/backe=
nd/libc/time/types.rs":"d0307994ffddd3f21f702d9ae4400750aecccfaf4a01268161d=
c4fd72de5c373","src/backend/libc/ugid/mod.rs":"2c6478857a0751625edabd61acb8=
41819bfba1093b1faeded15693c805d84952","src/backend/libc/ugid/syscalls.rs":"=
8edf91b8790add23902c9f5418da6b0723a371677f29f490e0c8af852f0f1a0c","src/back=
end/libc/winsock_c.rs":"e150946d35781b462433d8412e0c99eed6214113bb90fbb251b=
f560b3beefa18","src/backend/linux_raw/arch/aarch64.rs":"2a255c9135bc8a321c1=
80f52b88eb2b158bc9170cd222149caeae63c24587d44","src/backend/linux_raw/arch/=
arm.rs":"165bccb5883d0136e55d42091183765f83d86e9d37a7cb2cec9ae8af32774db6",=
"src/backend/linux_raw/arch/mips.rs":"aca20118a73063e4f2f8e7b261b1266d216e8=
26df2a98cad99c53c40b0971af4","src/backend/linux_raw/arch/mips32r6.rs":"a7eb=
d0886e2e0d3b39996778fb665b68738f8a67d67b47e43fdba7e7cabb6d1a","src/backend/=
linux_raw/arch/mips64.rs":"ba947f286522b8034d509887cff8183cca34766aed5d37c9=
1667dba22e2f608a","src/backend/linux_raw/arch/mips64r6.rs":"27de08ce1003a48=
f1d8b84746e724e8766b980e4ddc4febb6e20eb31067fb137","src/backend/linux_raw/a=
rch/mod.rs":"ab348ddfbe57c3e3258f02416dd68503eb9f0521a2f52b73e4dc715ab6121f=
83","src/backend/linux_raw/arch/powerpc64.rs":"dfb001f8636a5e46d728900b0804=
fe6c374e5e18a6f0e76d7d62e0c07da74477","src/backend/linux_raw/arch/riscv64.r=
s":"41d33242d941030f46077dc2b1bc4c7913fe7630d693a5a7eef966bcf38f9d8b","src/=
backend/linux_raw/arch/s390x.rs":"5b30beb99a543c87c77428e488575bf9b6e7f07d7=
90df573e7be38ad5dd314a6","src/backend/linux_raw/arch/thumb.rs":"2fd979ab421=
248c0a4c592bc0cefee63edc26528f469b71b63eaed35356e42e8","src/backend/linux_r=
aw/arch/x86.rs":"8fba9762bb0e8bb9a71890cdf413441aa52d2bf41690ec0ef01c97ac11=
759a5b","src/backend/linux_raw/arch/x86_64.rs":"e929036a1f3cf93ba538f4523b2=
41605cc7b5e61f84ffe6d9d5cdbcb6f73e543","src/backend/linux_raw/c.rs":"7ae5c3=
1185afa5cc82ab2684faf7770c15e4ebd61f104e5c30e3fcafdd450287","src/backend/li=
nux_raw/conv.rs":"f4deb897dac6c99e465db1bf27a9194196e208105f0f00f040c9e56ca=
dd9df51","src/backend/linux_raw/event/epoll.rs":"db05715e1bd3b93c6873695c89=
f04abb97768a57e7e402306f568eba844e407a","src/backend/linux_raw/event/mod.rs=
":"72e46b04637e2d1d2a6b97af616144995399e489d1fe916faf835d72fc8c64cd","src/b=
ackend/linux_raw/event/poll_fd.rs":"a5773464e9e30227b4046f029a27d3daf2c7bd0=
045e54565cf1a8ac2a0d61e81","src/backend/linux_raw/event/syscalls.rs":"5bf5d=
f8fe67e246948a7bb40dd89176052ebf085ed50ca9856a49c3613b56a47","src/backend/l=
inux_raw/event/types.rs":"0551b18f982e233a0a06d8a9c3dbb29de0c204dcd64dd6f7e=
88b6c96fa9a9be8","src/backend/linux_raw/fs/dir.rs":"fdf849d058c387551e102bd=
7fec31e3ca40c18417a1e530cfed1daf3df2c4de3","src/backend/linux_raw/fs/inotif=
y.rs":"e627e8f48e8f4dc2117746117aaa7f151865103be64e446011c72878921e402e","s=
rc/backend/linux_raw/fs/makedev.rs":"c6b4505c4bcbbc2460e80f3097eb15e2c8ef38=
d6c6e7abd78e39c53c372139e2","src/backend/linux_raw/fs/mod.rs":"3d3a42bbf4d0=
86f806d7d9f6e4b0a49a873dc27f4f03ffca0921f5536acc24e5","src/backend/linux_ra=
w/fs/syscalls.rs":"6e2ca8d96be2bf94b38512d184a22d79385a6841419de2590f9e5af3=
3d002920","src/backend/linux_raw/fs/types.rs":"6102a5b8207f959edbcc2fc233a6=
145a265a428c0c4fa195472fe7fe6dc5165d","src/backend/linux_raw/io/errno.rs":"=
40cf9fbaee5c88b8e6293a1eeafa3498f3c0fe402b16a30ae97131795da0b404","src/back=
end/linux_raw/io/mod.rs":"7ae2324427892cca6f5ab53858d847b165f790a72ec25f3d9=
9fb15f0506c9f27","src/backend/linux_raw/io/syscalls.rs":"54ac1395fb4801ef2e=
c6639113a6e23c4b532d84b6495f7166fcd0492cea09f9","src/backend/linux_raw/io/t=
ypes.rs":"d0df5a62248e1ba19af0f89f86da7ba2312d97065c2814ddf6b08a4a0db23bad"=
,"src/backend/linux_raw/io_uring/mod.rs":"2c6478857a0751625edabd61acb841819=
bfba1093b1faeded15693c805d84952","src/backend/linux_raw/io_uring/syscalls.r=
s":"7e40703cc3a020377a4a23bc8651bdf1d65b8f62e174eafb85d27d246f86c39d","src/=
backend/linux_raw/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a=
5bfe489fa1d07f7cfd7","src/backend/linux_raw/mm/syscalls.rs":"c7fc0f49283026=
b0df47463ed47394634e5664468f36a5eb2a89bf259bbfb67d","src/backend/linux_raw/=
mm/types.rs":"821409c463a31954048075906b3fe5bdb029badf9c9e2689bfff8f6dbf5b0=
bed","src/backend/linux_raw/mod.rs":"f849feea0a83df69fb9288ecfe07992cbdaee7=
e55d29b5662043a3fdf00e4700","src/backend/linux_raw/mount/mod.rs":"8aa966faf=
3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux=
_raw/mount/syscalls.rs":"8442c82814961f69c488222faabb82c44d2e7227b10faff919=
cbbd197bb47484","src/backend/linux_raw/mount/types.rs":"9a33214816863fc9284=
6fbc99df6ddf60a3e772b34f4bb3f5e8a40ef489130d3","src/backend/linux_raw/net/a=
ddr.rs":"7239e4fa8c6872bf978e2f580563c51c72d6ae6f96b77520fc7b9ece62fa0ebe",=
"src/backend/linux_raw/net/mod.rs":"5640bbaf4963ac4575b0537173422ed6f6a43f3=
4a8f6b656e7257fbbb13e5bcb","src/backend/linux_raw/net/msghdr.rs":"8b18974b8=
1ee78af7a5c64733041dddaaa378a46cab8b984bff5b3b4be499751","src/backend/linux=
_raw/net/netdevice.rs":"3cb28bcd762e2df595481b4379a08170f59f99d367aa0342453=
1c19e4c5aaf55","src/backend/linux_raw/net/read_sockaddr.rs":"7cb3c8bcc80c5e=
ee8602323cd83f36c1784927d9dd0c40ded29af6fb09c57ece","src/backend/linux_raw/=
net/send_recv.rs":"d4e81c01db50dad1c02e9aa3e0979f8052431a3f64c8864681d9ea52=
a34ce3bf","src/backend/linux_raw/net/sockopt.rs":"95b5054469f3c9ba83ecd30a6=
0e4adb3dc444d36cc1a24ed57fb460626b475fd","src/backend/linux_raw/net/syscall=
s.rs":"05d96523e459425ddb13ac86ed07467723f4c3bce7204115f94331bc96dbc712","s=
rc/backend/linux_raw/net/write_sockaddr.rs":"0efa4e17b4008da2cf2aada2d18acf=
ccd31a3b49cf8ac5d608e77f3ea6627fec","src/backend/linux_raw/param/auxv.rs":"=
d90827ecdb2d9c98604bfd80419e533c3c200da4463b17e2bd8ffa0e061cd5c0","src/back=
end/linux_raw/param/init.rs":"f2275a2324a99be8d804fb3b7fdf86a43c7d428f66028=
0b7e0e7d19c357f0200","src/backend/linux_raw/param/libc_auxv.rs":"0a223ad36a=
33611370cdf3c666008fd61d15f2477fd3a5ac2c78972079fb86a9","src/backend/linux_=
raw/param/mod.rs":"2e6a1a1c00351b9c88bd615aa923f71d76208df5626dd9bea03067f2=
8f81dc31","src/backend/linux_raw/pid/mod.rs":"2c6478857a0751625edabd61acb84=
1819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/pid/syscalls.rs=
":"eef6aa01830ddd510b83f507da2002c03e58318b73744be2c06ebbe33c4f194f","src/b=
ackend/linux_raw/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25=
a5bfe489fa1d07f7cfd7","src/backend/linux_raw/pipe/syscalls.rs":"aebba454edd=
084bd5821243d8fd755cd2a841d5b620e8c9ce9c19a02fc5d00ac","src/backend/linux_r=
aw/pipe/types.rs":"ae643a774e6343df02b9b99b842fba8b742dd9b1f97b5c5b2b504f28=
40bf3fd2","src/backend/linux_raw/prctl/mod.rs":"2c6478857a0751625edabd61acb=
841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/prctl/syscall=
s.rs":"a18b224307e0d27bda9b7b85c75cd6c7ddfe39f5ce52efb7bb0bf0585b757343","s=
rc/backend/linux_raw/process/cpu_set.rs":"b31889f972676f57e3599375dfcd59dd7=
2975977ef345d11c22d51f0d4a6400b","src/backend/linux_raw/process/mod.rs":"fb=
393c70a9c63ef9a6bf1fb5a2dc94f07d6b0b6987cc5231c15c607015dafd68","src/backen=
d/linux_raw/process/syscalls.rs":"b9b6d542a39e021ab2b0b2128bdb436c22eb8c525=
56d185f01c58f1a1d9412ed","src/backend/linux_raw/process/types.rs":"6811ba82=
2bc12a1a6336649151b4adb1f5d3365684a31c07f01953ea9547743d","src/backend/linu=
x_raw/process/wait.rs":"921aee4b0048746087f52615a98edc2aa0fb4b53d6df44be453=
3098df55d1b05","src/backend/linux_raw/pty/mod.rs":"2c6478857a0751625edabd61=
acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/pty/syscal=
ls.rs":"ae09c4aecc0ae87b1ca58d82efc58007b9dddaae78460d615f48da19d1cd0f89","=
src/backend/linux_raw/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b02=
87b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/rand/syscalls.rs":"317cda=
f243623329ee345131054e86a06a0863a9e90c5dba73e1ac3475ba6305","src/backend/li=
nux_raw/rand/types.rs":"a21dbb1ab31eed6b59a57520be5a3c603c36d18ea74e67f7527=
f40835ba209a3","src/backend/linux_raw/reg.rs":"3e321750d91d77c835abd09b06b5=
851ebf3134d3affb3cce306e38329871bec4","src/backend/linux_raw/runtime/mod.rs=
":"b2cae8cce3822c3c92942f06ea0b68464040dcac33c6f0f7ee392c6269993347","src/b=
ackend/linux_raw/runtime/syscalls.rs":"ad0e266f0eec81be6e104d1e02ebf61e149f=
4f3c24d8f18cc4442adc313f3327","src/backend/linux_raw/runtime/tls.rs":"63160=
60560a112c2e9cd9807cdba6e8c91414113a04a739160929ae9a67bba1f","src/backend/l=
inux_raw/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489f=
a1d07f7cfd7","src/backend/linux_raw/shm/syscalls.rs":"3ebf91610b02de0312e1f=
0f0cc5d56e12b4d93794540087b3182cbdf3cb9c8db","src/backend/linux_raw/shm/typ=
es.rs":"8275dba36a8f2c4208f2d23ffef52c5b02d4b10d5450733cb4fc5cdfcd6285ee","=
src/backend/linux_raw/system/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b=
0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/system/syscalls.rs":"19=
a7ab17de906ec237f16a816da036723c1f55f605e8e4a26689343eb4cd76e7","src/backen=
d/linux_raw/system/types.rs":"1ceab8d738a71043473b26e97fa3fd79d588a86d4774c=
bc9b9e1d4f1447a016e","src/backend/linux_raw/termios/mod.rs":"2c6478857a0751=
625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/=
termios/syscalls.rs":"1a42438153f61e72aab7c3c8fdd0c3ab918da0fec58e07bb42423=
518065374e2","src/backend/linux_raw/thread/futex.rs":"0139394e11006301e9837=
9b7f07604aa10fb436b43acf8f55f1a24f1253f96cc","src/backend/linux_raw/thread/=
mod.rs":"6ad4a4b90b9234e79900b27ebbe8837e3a7a36aec532912e3e253edce5225067",=
"src/backend/linux_raw/thread/syscalls.rs":"e2c89bd3cf34a46b5d06de43933284d=
dd06ed07e9c789c726c1afa48f7842a5c","src/backend/linux_raw/time/mod.rs":"672=
724f55b7b7be6a7452bb1cc2d28b5f0aaa840a2856fe363acce624e1beefc","src/backend=
/linux_raw/time/syscalls.rs":"7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9=
806e5de9404845312fc","src/backend/linux_raw/time/types.rs":"5f49ee7b2019761=
14c6555f0c5a81d3305e18e726e54edc5a5474641f3cdc278","src/backend/linux_raw/u=
gid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d849=
52","src/backend/linux_raw/ugid/syscalls.rs":"8c86d251db33b399a1d1cbb8e87af=
e650b78db84f444d3251309b7a0480b54f7","src/backend/linux_raw/vdso.rs":"05631=
4f72c71d4b041739337ca2098afb7fe070f844327f462c293f43481b75b","src/backend/l=
inux_raw/vdso_wrappers.rs":"4fa1fb04d5812c9edf143b3228327475f4021f6cd52c75b=
eb51aeab4d1ad983e","src/bitcast.rs":"4d2b3619dac1500bee223e11db0b4a5f75b0fb=
de65094bab157597af71f6b72a","src/buffer.rs":"fbb262d0751546447ee95f1623d3f2=
eb450ff0b4a7e1df29c5a2c9cf205b8820","src/check_types.rs":"e52f710e1cfc12ca1=
3a495f2b43c227b293ff295e1ce3ab332935b28a7579872","src/clockid.rs":"bd66d6bd=
c6b73a4668dda5b6f91838b6ed6c4b9503a0798b071ef35c572b711d","src/cstr.rs":"41=
af2a4429fe6c67a8883f8a8f63d66c90df566abda74fd2b03bcef7b9f24218","src/event/=
epoll.rs":"af4c6d3088d8dd73709db595e47b633bb9c358d18078e53cdb0f749258d7b736=
","src/event/eventfd.rs":"81cbd08f7bdf40a6ce1ca692b63da1dc8ba925282990668d9=
d68f1203e839fa1","src/event/kqueue.rs":"1f381c8afa65d36e3052c476d2e679c3bcc=
b7e3d6cc6b95ba53b48abcbe13a81","src/event/mod.rs":"2e84e47c029f96eaf8870030=
a2f57ec68416035cd99fe7c05601ede40057fe78","src/event/pause.rs":"930219e19ee=
227729c8f86fe7271721e8797e917d2d7073fa8d7a104bf6189c0","src/event/poll.rs":=
"4de5f12e9cadd64e93e11e7b63248bf657700e6be2d8b40b0e5d5303eb34b4da","src/eve=
nt/port.rs":"4e51ff150e5d17cbd44aa64a38b99c15e26eaaf2e350768b5dcacdfde4fa52=
12","src/event/select.rs":"49ca840bfd39202494fed201fd34742c30ae5d3d6c115d27=
b8c232d2137105e3","src/ffi.rs":"50a14dfe10408f9abc6269b9ee6e7a88d99503d50b3=
732288e85b777915e579e","src/fs/abs.rs":"1c1e65be08da5f7d6e5b8902283855fef0f=
0a74ab227aae991aaf5310d0858f2","src/fs/at.rs":"68de994eb06fa90bf5b5088dc4ae=
280c6ac2222fcf137265d4256ce202869da1","src/fs/constants.rs":"23923e0fce3221=
bdac371fe2d05028f30a87dba4f9b4a573b69dc2d6d39320b2","src/fs/copy_file_range=
.rs":"d3b644374390d482b2ff749a2459458872b57d0dcf9670368739b7833509a7c2","sr=
c/fs/cwd.rs":"3400dd3954aa0d806af1960054899447de5e425481edfad539bdd5fd0b996=
7d8","src/fs/dir.rs":"347a52f4ca9ac6321c52e802e97ec90d1b4c62ec955c8996fc17f=
8f5aed69966","src/fs/fadvise.rs":"d77f6a7f7f6648e750888719e59f0f8332f11e844=
42ef72f622bcbd4e19be845","src/fs/fcntl.rs":"8ac62c8ecd3abf3778685f1534b5e6a=
0989a20df0c86c227af99ed3643b95d4e","src/fs/fcntl_apple.rs":"e2f23f038083621=
bcdecc98d02ce1023508afaecdb2ed0fba5c8b70f955301e5","src/fs/fcopyfile.rs":"c=
e565f61e1fbf2e31086077c2f1d01b6bb3b048915edda87fe9a4a4f5e8ff7e4","src/fs/fd=
.rs":"c9042ae0398dfbf39ec9ea8a0bebc6fa91ff76dc33f5aeb829313996036e4d66","sr=
c/fs/getpath.rs":"28f6970fc1bbc37bb35c84724b59eac436ea7407a4522e18c2bdacb1f=
dd2edd9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f97189cea4e5982a0d35b192afeec6=
340a6c6222e0cb","src/fs/inotify.rs":"2e4b9824c323c661667aefe06383cd3e843a34=
676852d9f5f79f62e48e975171","src/fs/ioctl.rs":"1d17e7be9ef4f9f69358bf474a66=
9f0eeb0e8516a3626befc1bf61bee0221d89","src/fs/makedev.rs":"85520b484cb7c15a=
b71ea1c368578ea3b7e484d82f8510db92b6ce9f7ca341ae","src/fs/memfd_create.rs":=
"55a3d611184fe0e664f8e2a68cee359c4a65dfce0147305add139df65c292f01","src/fs/=
mod.rs":"0657052b4ce5934a3f7f95cbb16e06b75b10e4359142959d3d0a0ebe70fdc33a",=
"src/fs/mount.rs":"8f6ea2b997dd83c50c90291b9ada3ed77a9ce1ad701c9b0d533b5113=
b317be5b","src/fs/openat2.rs":"4a95c15dab533a41201b5fa25c8a212956b7571d58ca=
d696bdaf45af8aef96db","src/fs/raw_dir.rs":"6ad6d3dcdc6ddbb94f152b2584d7335e=
4b209d7219045ab4bdd6bdb2b7400e7c","src/fs/seek_from.rs":"a9efa0feb9ac789cf4=
7667e91efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","src/fs/sendfile.rs":"e3b20=
58741cf4b1698f34d84bb37130cf2b72806d522a16fe541e832cde136cb","src/fs/specia=
l.rs":"17a0f89f7462171169bbf5aa20a9ec934951fde7016daaed9bb1d12b468baf91","s=
rc/fs/statx.rs":"2844baac77fdda0d77823402bfbdbe5bf8983e1d3b229d700bf80c0c19=
0f2aa5","src/fs/sync.rs":"84f24de0ea53f77bd5c471e097abcbecd19c4843b69607f9b=
e9030eb7c9d5aa5","src/fs/xattr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6ca3=
a47200532ca6e72d44cbe8334","src/io/close.rs":"b4f7c0dd39554463c9692a09c4074=
4081e229b729610d7c530e084e92c63e8e5","src/io/dup.rs":"dd33bd405dd8368c2ef80=
73803ed1512cbe2c2d92194f3f38f44e766d2ff6ab3","src/io/errno.rs":"fe056ade492=
ef5b7e20fb9ffbc7e183b7bec6ff300587eb5197deaed5d321fda","src/io/fcntl.rs":"9=
9fa698c6a6c68ecece7e7d14e0a65e1b6e17d360f028e14f8800d42a355b22c","src/io/io=
ctl.rs":"e89a6e670fe1c06521aa2f266fcd7a990391a533995b787cabac223f0926c8c7",=
"src/io/is_read_write.rs":"a7d3cc1b8673a94d64926c03984e24a627c24e78f09070a2=
eb893d8005abf9d7","src/io/mod.rs":"0b566bf43b3f8754153f361119f63aa08ff2450e=
9306eb7e35ac3619bfeeae0d","src/io/read_write.rs":"46fd5efcc1205f8195b6d55ad=
277f71dcc62a2a52301dae03c0e5dbae6d70bd4","src/io_uring.rs":"4d163535b313a17=
98bea10190b8ff5211e8ef72ff822952a002af3b1c4946153","src/ioctl/bsd.rs":"d7d3=
f6813eac0e0f22fb8bcac3d193a22584393c1f7fa233999bd09c4e2059f7","src/ioctl/li=
nux.rs":"61f006e31a4e049787415131beb97e548accb17fb6105d7ead5a12df0727077f",=
"src/ioctl/mod.rs":"87e502a4de2f5ec029d64f606d3fda3831623f405434306e69f35a6=
aff5d3c04","src/ioctl/patterns.rs":"26116d5b5cd790ed485791e006c97c28590c038=
050c69c42c752289fa7fcbc65","src/lib.rs":"aadf83ff8226d5b94cd465e18927005bc1=
04b0a7a4f7e0f432d5b110be8b4865","src/maybe_polyfill/no_std/io/mod.rs":"7788=
9bb5c5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/maybe_po=
lyfill/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9cff3a1=
9049d88c8c80","src/maybe_polyfill/no_std/net/mod.rs":"1e94d21d455bb1da18a4f=
ccb24b3d93ad42698e22dd888b78115d6266c80288a","src/maybe_polyfill/no_std/os/=
fd/mod.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e80771d507c4=
7","src/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087cc9afd10269f09=
a8b4125915dc3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_std/os/fd/raw.=
rs":"f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999e7c6943","src=
/maybe_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2fcc7c825310606b=
889cc8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/windows/io/mod.rs":=
"5bbcc05c83fee5026dd744a994e0458469466d5be39081baa62df07753b92fd2","src/may=
be_polyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49328b5637cb3baf=
b96437f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/os/windows/io/s=
ocket.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5d2c64808308d65=
","src/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231a4e778b5f985b9=
ae712ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/std/mod.rs":"7c=
16c86cc73e226e65ead598e4018238b22000a345040b706bf1e1b3eba115fc","src/mm/mad=
vise.rs":"092ff2064b16960369a908aeed70ec38a16fa2a0207f814cdea379e2f2286954"=
,"src/mm/mmap.rs":"1cc428e40ae77b23718ce821a22806c067fcaa7aabebf57df5cede7b=
7abb2bcc","src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761211a494ca6f89b=
2367a2d2157e340e","src/mm/msync.rs":"0cfb895703b8b7bac47426c8f03499f2aced3f=
4e1f31008243a1a629e9d44a1d","src/mm/userfaultfd.rs":"8073443bd181ff0b3ba4d0=
b1ae67370b4864035a0c8b4898cd709dc47c518ae7","src/mount/fsopen.rs":"1c54a02f=
04ee6710e2c5053c73361eecc499c24cd72c7c7c012dc57a4621e382","src/mount/mod.rs=
":"5f0c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d12a7136cb19","src/m=
ount/mount_unmount.rs":"fa77675b023180b578b7fc053acb46ae2ed2eb11bb0488871bf=
d1ed211df73a0","src/mount/types.rs":"601ae3e10b7dc496fed7f3b40a80e81c6edd7b=
f13189d7be45c3212d4c684c39","src/net/mod.rs":"7899807c9ad9e3fdbfd8b3ce2a1c7=
053d4f46dd7fa76102f620c6042c2d6314f","src/net/netdevice.rs":"1d790ef6e33d30=
c3167ec422a95a711d6df26d69502cb0b4c4889623547d3693","src/net/send_recv/mod.=
rs":"ca923e7affc72bac1c67b3957f55a256dbdcd800c54ae866ebe71fb406ef79a8","src=
/net/send_recv/msg.rs":"7bbd89b593748d4ef63d76f1b47c429c48c2f5f3d4a6bfd9aa3=
7373ac26a77a1","src/net/socket.rs":"f6e0c454eadb52a8ead30e04851bfe095d65fd1=
b83ae6419dac2030e69b3f7d5","src/net/socket_addr_any.rs":"88250bf218d3a626e8=
e04bb11d4dd50ddf1422bb28d780c98b80710cf9c30166","src/net/socketpair.rs":"aa=
9013de19945bfea3f7d2889cc23abd384717b79f38cd5d045dec09c7517658","src/net/so=
ckopt.rs":"416485d98afaa1cbc492e0dea06edc2137e2b2e6b15e16c2479dd92ae456c355=
","src/net/types.rs":"8f89aa81f880c968bdcc6e2c48d6ae362b650599f3ff8c300c173=
5d52ac1e8df","src/net/wsa.rs":"29856e6d0108be6b719f6ef973c5396e48ddd58ecd0c=
2db9ca3e2e0ba4eccb5b","src/param/auxv.rs":"b57483d3083a4dfad9ceb049fd96d547=
13b91b7f31b8c9a0e40501548da499ac","src/param/init.rs":"a31c0e5cea61a1a99976=
7fe74f87c0d59eeb6bce66578b842fe0e0c32be27a55","src/param/mod.rs":"c514216b9=
6d9520c9ffc5662c97b24f1f36f56fe1f5f3c9f64175c8b35577288","src/path/arg.rs":=
"ab5ed60c8cbf0484dce25440f027d7d511ea329bbaeaf83d70717f5c7e47b5ac","src/pat=
h/dec_int.rs":"0c71377fa5137595d6316ee135617ab8e514a2f539d77e15ef3a626d7aa0=
92c9","src/path/mod.rs":"fbe294749100630467580f5e25b44e7a4f8a4512381cc18aca=
f1a6813afc39cd","src/pid.rs":"f1c486000c5b1311b2d720cee88f089c17ef9a1717096=
73dd06e6f35f4ff98a3","src/pipe.rs":"d5de91e5adb0ef8753e4c1ee5cfdff1f8bd8006=
8af1fa3a12239a47da5131832","src/prctl.rs":"19aa584895874ea48b9bbe1bf695b812=
57b0281df64dfdd91e1b4bfa298661b7","src/process/chdir.rs":"93ce4fade85e72088=
3f22e8b8a6c0c9b6ec3a07c37f457852b2c53aafeb8ad3e","src/process/chroot.rs":"0=
1191eeb86295975874019dc675cb0f8f0ca5f79dd78dc9d1c791a952adb3512","src/proce=
ss/exit.rs":"f09000df82151d015a39b8cfe7dc28875074ad1bfde326f63be1438cf736d0=
8e","src/process/id.rs":"7bf74a510b975b5f7f9a8e5565ad68c0b9e2eac0fd99f1551b=
806bb1a6684905","src/process/ioctl.rs":"c7f551152d65ac173d9eaa298b964339037=
b60a7b81e8bc316453718417a6be3","src/process/kill.rs":"674d06cf065c8045dbefb=
6fc6437a62b964069599fc03d84e64cc36186b96596","src/process/membarrier.rs":"1=
c4c39b359d1d0e9bbe16352eedfca9278d9ef298ade8ec00e998617bbcbfed8","src/proce=
ss/mod.rs":"a32691289982f4ffc53fef94fea4e3f375af9af87604fb962e94c54c9d91703=
b","src/process/pidfd.rs":"150413a9cc550ffc432b3279a368223fa9577544ef29e45e=
deff3b79ae316cab","src/process/pidfd_getfd.rs":"74c778b872be0b800870e463360=
6461fdc8493b259031e35f8f558768d960cc2","src/process/pivot_root.rs":"aeb2464=
464efd81ca0b940e3e5e3ed1b09380f3e6ba3200972e0ba100f78badc","src/process/prc=
tl.rs":"a34ccda958036f49c5e4a5d654566c2b18d59c4b48b31c91e63877191752712e","=
src/process/priority.rs":"ea78f09e4564943d0083eba19d9933781a5dd70d5723f156e=
b16ad01dd67d89e","src/process/procctl.rs":"27e082d23267ef9a19dcbdd7eb33a1df=
26eef42894202a728bc1d8a3f1ff27e6","src/process/rlimit.rs":"10becde11d8b5d3b=
50aeb21a8fcdf53ec7803bdbbf8d1f4233b8e6c0b85fafb1","src/process/sched.rs":"4=
f566593f7a6c12873ecb18f21b9806162791b33815c9147065d3c8d812b562c","src/proce=
ss/sched_yield.rs":"8f80fef12e528628d19c26d26ecbad61b9644505a872a49f842820a=
a52018cf8","src/process/umask.rs":"15841f5e178dd032f8b8def8545c9e98b205e6b1=
ba70bf9c07c2c0327a8999c0","src/process/wait.rs":"04d60c43e8ed1ac44e4ddc5ba6=
e18e5edf1c400565ea0e81ff8f1bf71403b7ba","src/procfs.rs":"adfac2c1232ff20c18=
251b8745f6732e3315b1adfe95b9e7297378dbcb290129","src/pty.rs":"30c68b21fe062=
7780a5ab48977b233bbc645d78566f9da3bf22bb2ac92a63e4a","src/rand/getrandom.rs=
":"a89f45838d22982eb0997bc905031819195701b64aa1c874e646dcb16d6e2a7d","src/r=
and/mod.rs":"e1fb7542f1958fe77673aa628bd92fef1b9addf79ba23df2398d1231cb61c1=
48","src/runtime.rs":"58abe84feb409ec5a97df922253d127f032e54d0b44989f2a9dff=
4852a1b7ce0","src/shm.rs":"30b32e302ad2d198de411981f3c7609082bc20f1c0651aa3=
f3ce2beb8f19c6e9","src/signal.rs":"0fcce2e37f69d70cfef1f355355979b269820281=
a6e63bd171ba05e525063e79","src/static_assertions.rs":"504cf66f0d5b8e335be02=
f9ae8b0a355abc98c2c82eec0098bdf0988e662e260","src/stdio.rs":"85e66975a55f91=
bfb764f848eab34acf1bf6ca7f37b6421043d1e2003ec14805","src/system.rs":"4954f5=
261bd25fd01ba6c97a1a0afa9cad4d768a1c10491d33b3bf2d0bba8371","src/termios/io=
ctl.rs":"aa26694c9be5378ea52e669313e64b25fc034e3863b72281530c42499570fedf",=
"src/termios/mod.rs":"b44b7caa60b6f458657ed58a0e0eca41bb4e6d6be4b0f042bbb8a=
b7056cebe4b","src/termios/tc.rs":"bafcc607de993c7e7c4cd6f15a59e7807906e59bf=
991a5a4c67e3b076d07e3f2","src/termios/tty.rs":"0013cc4c31907246b45c4b94ded0=
171dc0d3e6759740f5424831feae700092f7","src/termios/types.rs":"961e220940079=
586b93d3817ab45a6da9d3f1c318d0bc709213365facb62530e","src/thread/clock.rs":=
"cc4a981b7fc059cc88da709e31381c778d75c22f1b96cad5fa2799a45ecfef5a","src/thr=
ead/futex.rs":"b4a182cd4b490dab620c5fc59adfe79845c2e64f624cb8d9096a9375a059=
7b21","src/thread/id.rs":"1a9a8b4bfe71dba6aec17760ca9de5a66a80b9c608fa0eeb3=
0fd1bc949e511ca","src/thread/libcap.rs":"4c51b7df566d38dd0f85f81ef53279a745=
a39f0f4e1154791fd38438e2ca7db1","src/thread/mod.rs":"d6d9c3340cd9710869813e=
a9c993669d11620126edc66e5657a9de2a07a5f864","src/thread/prctl.rs":"3826dda3=
1b9452b2a8b30158b6babd0b536fe9ea314027863d14c3888c9435ee","src/thread/setns=
.rs":"ddee643bd095104242afc3ddd3ddcbcfd6a4876febf47200a63f9e22996e1dec","sr=
c/time/clock.rs":"7588a33f5279ee683f39ce72a8d0a8dfcc2e25d3dbc29990e6829d7c2=
df7d99b","src/time/mod.rs":"43afee938c80d124d04d4ba190c03f4d21d1e3bfc154fff=
309211e4f6eabe940","src/time/timerfd.rs":"f17092b84553741aa2d2b44c6992b5d2c=
8c96cc2c2007fc9a2c6b2064485e53f","src/timespec.rs":"32a4d930cbc0f6dbd231532=
90db920671cf4ce65a4a127e176f897c1cde42d7d","src/ugid.rs":"6616c6e35b7e43aee=
5b150f1efae7a50711e0947943c9a96833dbe214ad9e85f","src/utils.rs":"ad680ad856=
4cb7b37fc746e0b3f89d389278fe1b294ef343a5c4a37677414065","src/weak.rs":"7e31=
69bc97e76fc4d52b040391a8df36b06536fc0f81cc6e8e71b951cb1fe54e"},"package":"9=
9e4ea3e1cdc4b559b8e5650f9c8e5998e3e5c1343b4eaf034565f32318d63c0"}
+\ No newline at end of file
++{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231d2=
fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b0532d=
35973392af16ffb9596a41d99d202cf3617c9","Cargo.lock":"3d1f975c4b771dc29807d5=
e42c2951cf5f5d9fc42ebf7295ab2cc7d57076cba8","Cargo.toml":"24a05853ab82f1405=
7d4f40517cf26e5b3f630b6f96d133275ce18030517d76e","LICENSE-APACHE":"a60eea81=
7514531668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2=
.0_WITH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39=
ef1f94f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a71=
5d9d2b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12=
ba79e4cebb6983a7b6491949750aecc4f2178","README.md":"fbd9eb025cdb6c58d28649f=
0c9132a4e383014f03a8e0edba04a4e36cc45fba0","SECURITY.md":"4d75afb09dd28eb59=
82e3a1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e672=
73aa0a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"7cc60=
a1a80836bff6c4f82dd938049dcec84736100bb81ebe6ac84513b0f4a45","src/backend/l=
ibc/c.rs":"acfbe7965e84e9bba1861924130d1383e9318040adc67e1e14d882bb8ac63562=
","src/backend/libc/conv.rs":"85b9b0e1ed6cff8240c9c462af5a769d5b0537ec94e41=
db51ffbd95b3513ec80","src/backend/libc/event/epoll.rs":"6b68d0002519ad98943=
91562ca062aa02f696cc0a2a84bbe750891619f5b0c35","src/backend/libc/event/mod.=
rs":"554bcf6d614a99c32d021d0a2eb3018705f516120d4e2e52d4376cd835f3f28c","src=
/backend/libc/event/poll_fd.rs":"f187dbb2a2eea2cfff86d2956991fd6b9df3599f91=
a494b5b61e00296bf5ed5c","src/backend/libc/event/syscalls.rs":"fdd3b51a6e3f9=
bbd673e07acffa657b626f826a5853564ffb1b8d735aa05e9d7","src/backend/libc/even=
t/types.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f=
13","src/backend/libc/event/windows_syscalls.rs":"1b682b13c3fd2601fa7dd10a9=
09467a8d9ffebed04f8f6c8bcd7ea8a89769c8c","src/backend/libc/fs/dir.rs":"8362=
73d764eb7c1cf09b5ed20baf20a99d9c9afdf448c9fda50f0927c173cc89","src/backend/=
libc/fs/inotify.rs":"69376ba2e81f98164029888d0cae554ca1702b532b0045dc55e282=
f1dd52d7bb","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f3=
29ad35bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803=
011b57da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc=
/fs/syscalls.rs":"14132f6d90ed66e04b29984b02cc24ef101644f9351e3bcabc521cabe=
19f110b","src/backend/libc/fs/types.rs":"a4300df90596e144d895c8286c2eb00fdb=
446e7001dc5368506ed3da02970fe0","src/backend/libc/io/errno.rs":"32da10e1721=
1335287db5165955331d7bfebbab73513e0ef96014385a91aa06b","src/backend/libc/io=
/mod.rs":"746647bd864e4ec7717925b6d176cebdb392b7d015070244cc48d92780351dd6"=
,"src/backend/libc/io/syscalls.rs":"91ebf37b8abdecf619c9bc3521b1b4c6795369c=
668753586e1af79d04fb982b0","src/backend/libc/io/types.rs":"2efd39bb3df19a9d=
b5496217284f3d2235ddb354fac81dd71861109a56bede0b","src/backend/libc/io/wind=
ows_syscalls.rs":"24f7abe92406f3f65c1a42a4694c2112142106a341d024ffc2d5905a9=
f289339","src/backend/libc/io_uring/mod.rs":"2c6478857a0751625edabd61acb841=
819bfba1093b1faeded15693c805d84952","src/backend/libc/io_uring/syscalls.rs"=
:"5221a498e6c396d7c4cb60168ce8459ebca7d6720349a426d8083c227c694212","src/ba=
ckend/libc/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489=
fa1d07f7cfd7","src/backend/libc/mm/syscalls.rs":"c04c61ad3d7f3b24d13f89144d=
7fa0a05658cea4763207f9250db4f9362de2fe","src/backend/libc/mm/types.rs":"40b=
7888a1439afae2705e0c724ae0821a51d32ca5740f1ec16ecb6dc1adc883d","src/backend=
/libc/mod.rs":"ce2f388bdc8dac69ca9d1871ddc7ad01a7471a0de4b7f2bd67c8f11d0878=
fd87","src/backend/libc/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539=
b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/mount/syscalls.rs":"d2d35f7=
ae989bb52722e28cdbd775243c5d7da9eb411e0b2b9632f2aa7c1533e","src/backend/lib=
c/mount/types.rs":"5c2eaf22e7a29e8e48cb19e40c88d040ba1c891038a611e855714764=
89dc12cb","src/backend/libc/net/addr.rs":"b9f5af8bfe0762deb346aabe87f8d3250=
4543923a246ff97f9828a0bc36b893f","src/backend/libc/net/ext.rs":"cfce41130eb=
2e3dd04271e0aa2c1e2de9866397d7d2a59e917d26b784ea30df5","src/backend/libc/ne=
t/mod.rs":"562d23225d6dba8f095e3ca41af60dcf6cc40c2cf17bf028f90888f809e86f07=
","src/backend/libc/net/msghdr.rs":"6f8aba792b4adef5c5d3d4324a813a67a063a50=
d10437bb19bf7496666bd6de6","src/backend/libc/net/netdevice.rs":"078bc108540=
457f0e5849c2b8d2f1351c4aaffc910f8c9c9857969477c22065e","src/backend/libc/ne=
t/read_sockaddr.rs":"b094d2cb84b2eee5dd411d21458192c03eea0e420e78149441d7ab=
88a893281a","src/backend/libc/net/send_recv.rs":"b5714bed2cc6f2ba42bf90d196=
55b507c2a248e2d05270b1355b6d4cb8e4f9fe","src/backend/libc/net/sockopt.rs":"=
4595bd3b182cdaa7bbefb94556ffd1dfcde81d5e20b298cd907eb7373d7b3b77","src/back=
end/libc/net/syscalls.rs":"552eb57bda272f2372e180f927a88dce67fcef46e7c1378d=
47d595eb2abd578d","src/backend/libc/net/write_sockaddr.rs":"b62e40c9d4a4e70=
746d864434db140b4b3c1f110a3fd2e7acfbb3f2ccf15d6aa","src/backend/libc/param/=
auxv.rs":"c29b29ad65f66e048debce5293bf84164811264e61b71a28a57225400d3b9529"=
,"src/backend/libc/param/mod.rs":"5234b8f1bcb886cca6ea003d411d75eaeebe58dee=
dd80e3441354bf46ed85d4d","src/backend/libc/pid/mod.rs":"2c6478857a0751625ed=
abd61acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/pid/syscal=
ls.rs":"49ea679b96c0741d048e82964038f9a931bc3cf3a0b59c7db3df89629b9c49e6","=
src/backend/libc/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25=
a5bfe489fa1d07f7cfd7","src/backend/libc/pipe/syscalls.rs":"7380b533adbc57b5=
ccd8d2d0b74e5968215b00047965fef8bf0a1208d914647f","src/backend/libc/pipe/ty=
pes.rs":"f87e43bae418d00fe8b333877acc3b6aab4cf4d123f02ff048a21866486e1404",=
"src/backend/libc/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b=
1faeded15693c805d84952","src/backend/libc/prctl/syscalls.rs":"8a2684f444a75=
55098dce2b92270d81cefdae902716c6e5d59bd7b0657e8a29d","src/backend/libc/proc=
ess/cpu_set.rs":"5fca2b47289a2bb6ba908c910a6d27ac78ac10ea21d3c0c018f72f8816=
c5b9d7","src/backend/libc/process/mod.rs":"806e26da8d1e7afae502987fcd650f4d=
348da147b8a2e74447affdca153e2e97","src/backend/libc/process/syscalls.rs":"b=
4a7d09cf46c65997a28dc5f075e90943b2581b7df99cd66cdd18e87fe96600b","src/backe=
nd/libc/process/types.rs":"fb2caf34b17079aa72c04aed0f9a31d534ea8e8b73a80c75=
8b748bf5e38df52b","src/backend/libc/process/wait.rs":"0cc556aed976b4bbb3965=
f74fd76b8216c755fce25043b7b21ce54afa07c9773","src/backend/libc/pty/mod.rs":=
"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/bac=
kend/libc/pty/syscalls.rs":"757cc928b6121cda7517801cb837efbcdfcd4f785b80019=
ba8bf0100d6af1dde","src/backend/libc/rand/mod.rs":"8aa966faf3853d1a93d0ed91=
f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/rand/syscalls.r=
s":"35ea6b6e0f8a7fb064fd5cb33a3a855cd161a6a00f93d76c861b2a2c66db85e7","src/=
backend/libc/rand/types.rs":"4eb0b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a7=
05ec605b773f63f880","src/backend/libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91=
f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/libc/shm/syscalls.rs=
":"60d797d4e85e08e6330e6b8d80094356ce377e5484952f88ae2a6e49231c268c","src/b=
ackend/libc/shm/types.rs":"0a1ac6bb9c024d94eb4bab7452937b7befcb30c581dc787b=
805011407ba1442d","src/backend/libc/system/mod.rs":"38563ea68829ca5a4b1b069=
5ac8a5c05718e85bdc88a36dc805efdfce45d3909","src/backend/libc/system/syscall=
s.rs":"c18c2942811ea93af3125b58d00a1da05c54e5ff438a3dc44cda53bc9d6fcf03","s=
rc/backend/libc/system/types.rs":"6871e16aee14fe2ae03cea798c3e509ffe44778a9=
c0e5608fd73e2e015876d7e","src/backend/libc/termios/mod.rs":"2c6478857a07516=
25edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/libc/termio=
s/syscalls.rs":"2720e443c118e1c0311dbb3efa4b54637b6e607bb123ccdc0f5d92b5628=
573c2","src/backend/libc/thread/futex.rs":"064463c4a4f6549aec0797d44e44b862=
eb0100efe97aa293b4dad10034cae800","src/backend/libc/thread/mod.rs":"fa71005=
3974d7f16a6c49242ee6c10a3b9e1143452b9daeaed8837302a679fff","src/backend/lib=
c/thread/syscalls.rs":"4cb65db4fe0c7d6016dd0dfefa610b369234b6b9db0c75c0fcb9=
ab8cb25a16ac","src/backend/libc/time/mod.rs":"38563ea68829ca5a4b1b0695ac8a5=
c05718e85bdc88a36dc805efdfce45d3909","src/backend/libc/time/syscalls.rs":"b=
f847e94cc156bdb553755baa88dac240db4dcaf690f303b0f205777c5a9cdfc","src/backe=
nd/libc/time/types.rs":"d0307994ffddd3f21f702d9ae4400750aecccfaf4a01268161d=
c4fd72de5c373","src/backend/libc/ugid/mod.rs":"2c6478857a0751625edabd61acb8=
41819bfba1093b1faeded15693c805d84952","src/backend/libc/ugid/syscalls.rs":"=
8edf91b8790add23902c9f5418da6b0723a371677f29f490e0c8af852f0f1a0c","src/back=
end/libc/winsock_c.rs":"e150946d35781b462433d8412e0c99eed6214113bb90fbb251b=
f560b3beefa18","src/backend/linux_raw/arch/aarch64.rs":"2a255c9135bc8a321c1=
80f52b88eb2b158bc9170cd222149caeae63c24587d44","src/backend/linux_raw/arch/=
arm.rs":"165bccb5883d0136e55d42091183765f83d86e9d37a7cb2cec9ae8af32774db6",=
"src/backend/linux_raw/arch/mips.rs":"aca20118a73063e4f2f8e7b261b1266d216e8=
26df2a98cad99c53c40b0971af4","src/backend/linux_raw/arch/mips32r6.rs":"a7eb=
d0886e2e0d3b39996778fb665b68738f8a67d67b47e43fdba7e7cabb6d1a","src/backend/=
linux_raw/arch/mips64.rs":"ba947f286522b8034d509887cff8183cca34766aed5d37c9=
1667dba22e2f608a","src/backend/linux_raw/arch/mips64r6.rs":"27de08ce1003a48=
f1d8b84746e724e8766b980e4ddc4febb6e20eb31067fb137","src/backend/linux_raw/a=
rch/mod.rs":"ab348ddfbe57c3e3258f02416dd68503eb9f0521a2f52b73e4dc715ab6121f=
83","src/backend/linux_raw/arch/powerpc64.rs":"dfb001f8636a5e46d728900b0804=
fe6c374e5e18a6f0e76d7d62e0c07da74477","src/backend/linux_raw/arch/riscv64.r=
s":"41d33242d941030f46077dc2b1bc4c7913fe7630d693a5a7eef966bcf38f9d8b","src/=
backend/linux_raw/arch/s390x.rs":"5b30beb99a543c87c77428e488575bf9b6e7f07d7=
90df573e7be38ad5dd314a6","src/backend/linux_raw/arch/thumb.rs":"2fd979ab421=
248c0a4c592bc0cefee63edc26528f469b71b63eaed35356e42e8","src/backend/linux_r=
aw/arch/x86.rs":"8fba9762bb0e8bb9a71890cdf413441aa52d2bf41690ec0ef01c97ac11=
759a5b","src/backend/linux_raw/arch/x86_64.rs":"e929036a1f3cf93ba538f4523b2=
41605cc7b5e61f84ffe6d9d5cdbcb6f73e543","src/backend/linux_raw/c.rs":"7ae5c3=
1185afa5cc82ab2684faf7770c15e4ebd61f104e5c30e3fcafdd450287","src/backend/li=
nux_raw/conv.rs":"f4deb897dac6c99e465db1bf27a9194196e208105f0f00f040c9e56ca=
dd9df51","src/backend/linux_raw/event/epoll.rs":"db05715e1bd3b93c6873695c89=
f04abb97768a57e7e402306f568eba844e407a","src/backend/linux_raw/event/mod.rs=
":"72e46b04637e2d1d2a6b97af616144995399e489d1fe916faf835d72fc8c64cd","src/b=
ackend/linux_raw/event/poll_fd.rs":"a5773464e9e30227b4046f029a27d3daf2c7bd0=
045e54565cf1a8ac2a0d61e81","src/backend/linux_raw/event/syscalls.rs":"5bf5d=
f8fe67e246948a7bb40dd89176052ebf085ed50ca9856a49c3613b56a47","src/backend/l=
inux_raw/event/types.rs":"0551b18f982e233a0a06d8a9c3dbb29de0c204dcd64dd6f7e=
88b6c96fa9a9be8","src/backend/linux_raw/fs/dir.rs":"fdf849d058c387551e102bd=
7fec31e3ca40c18417a1e530cfed1daf3df2c4de3","src/backend/linux_raw/fs/inotif=
y.rs":"e627e8f48e8f4dc2117746117aaa7f151865103be64e446011c72878921e402e","s=
rc/backend/linux_raw/fs/makedev.rs":"c6b4505c4bcbbc2460e80f3097eb15e2c8ef38=
d6c6e7abd78e39c53c372139e2","src/backend/linux_raw/fs/mod.rs":"3d3a42bbf4d0=
86f806d7d9f6e4b0a49a873dc27f4f03ffca0921f5536acc24e5","src/backend/linux_ra=
w/fs/syscalls.rs":"6e2ca8d96be2bf94b38512d184a22d79385a6841419de2590f9e5af3=
3d002920","src/backend/linux_raw/fs/types.rs":"6102a5b8207f959edbcc2fc233a6=
145a265a428c0c4fa195472fe7fe6dc5165d","src/backend/linux_raw/io/errno.rs":"=
40cf9fbaee5c88b8e6293a1eeafa3498f3c0fe402b16a30ae97131795da0b404","src/back=
end/linux_raw/io/mod.rs":"7ae2324427892cca6f5ab53858d847b165f790a72ec25f3d9=
9fb15f0506c9f27","src/backend/linux_raw/io/syscalls.rs":"54ac1395fb4801ef2e=
c6639113a6e23c4b532d84b6495f7166fcd0492cea09f9","src/backend/linux_raw/io/t=
ypes.rs":"d0df5a62248e1ba19af0f89f86da7ba2312d97065c2814ddf6b08a4a0db23bad"=
,"src/backend/linux_raw/io_uring/mod.rs":"2c6478857a0751625edabd61acb841819=
bfba1093b1faeded15693c805d84952","src/backend/linux_raw/io_uring/syscalls.r=
s":"7e40703cc3a020377a4a23bc8651bdf1d65b8f62e174eafb85d27d246f86c39d","src/=
backend/linux_raw/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a=
5bfe489fa1d07f7cfd7","src/backend/linux_raw/mm/syscalls.rs":"c7fc0f49283026=
b0df47463ed47394634e5664468f36a5eb2a89bf259bbfb67d","src/backend/linux_raw/=
mm/types.rs":"821409c463a31954048075906b3fe5bdb029badf9c9e2689bfff8f6dbf5b0=
bed","src/backend/linux_raw/mod.rs":"f849feea0a83df69fb9288ecfe07992cbdaee7=
e55d29b5662043a3fdf00e4700","src/backend/linux_raw/mount/mod.rs":"8aa966faf=
3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux=
_raw/mount/syscalls.rs":"8442c82814961f69c488222faabb82c44d2e7227b10faff919=
cbbd197bb47484","src/backend/linux_raw/mount/types.rs":"9a33214816863fc9284=
6fbc99df6ddf60a3e772b34f4bb3f5e8a40ef489130d3","src/backend/linux_raw/net/a=
ddr.rs":"7239e4fa8c6872bf978e2f580563c51c72d6ae6f96b77520fc7b9ece62fa0ebe",=
"src/backend/linux_raw/net/mod.rs":"5640bbaf4963ac4575b0537173422ed6f6a43f3=
4a8f6b656e7257fbbb13e5bcb","src/backend/linux_raw/net/msghdr.rs":"8b18974b8=
1ee78af7a5c64733041dddaaa378a46cab8b984bff5b3b4be499751","src/backend/linux=
_raw/net/netdevice.rs":"3cb28bcd762e2df595481b4379a08170f59f99d367aa0342453=
1c19e4c5aaf55","src/backend/linux_raw/net/read_sockaddr.rs":"7cb3c8bcc80c5e=
ee8602323cd83f36c1784927d9dd0c40ded29af6fb09c57ece","src/backend/linux_raw/=
net/send_recv.rs":"d4e81c01db50dad1c02e9aa3e0979f8052431a3f64c8864681d9ea52=
a34ce3bf","src/backend/linux_raw/net/sockopt.rs":"95b5054469f3c9ba83ecd30a6=
0e4adb3dc444d36cc1a24ed57fb460626b475fd","src/backend/linux_raw/net/syscall=
s.rs":"05d96523e459425ddb13ac86ed07467723f4c3bce7204115f94331bc96dbc712","s=
rc/backend/linux_raw/net/write_sockaddr.rs":"0efa4e17b4008da2cf2aada2d18acf=
ccd31a3b49cf8ac5d608e77f3ea6627fec","src/backend/linux_raw/param/auxv.rs":"=
d90827ecdb2d9c98604bfd80419e533c3c200da4463b17e2bd8ffa0e061cd5c0","src/back=
end/linux_raw/param/init.rs":"f2275a2324a99be8d804fb3b7fdf86a43c7d428f66028=
0b7e0e7d19c357f0200","src/backend/linux_raw/param/libc_auxv.rs":"0a223ad36a=
33611370cdf3c666008fd61d15f2477fd3a5ac2c78972079fb86a9","src/backend/linux_=
raw/param/mod.rs":"2e6a1a1c00351b9c88bd615aa923f71d76208df5626dd9bea03067f2=
8f81dc31","src/backend/linux_raw/pid/mod.rs":"2c6478857a0751625edabd61acb84=
1819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/pid/syscalls.rs=
":"eef6aa01830ddd510b83f507da2002c03e58318b73744be2c06ebbe33c4f194f","src/b=
ackend/linux_raw/pipe/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25=
a5bfe489fa1d07f7cfd7","src/backend/linux_raw/pipe/syscalls.rs":"aebba454edd=
084bd5821243d8fd755cd2a841d5b620e8c9ce9c19a02fc5d00ac","src/backend/linux_r=
aw/pipe/types.rs":"ae643a774e6343df02b9b99b842fba8b742dd9b1f97b5c5b2b504f28=
40bf3fd2","src/backend/linux_raw/prctl/mod.rs":"2c6478857a0751625edabd61acb=
841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/prctl/syscall=
s.rs":"a18b224307e0d27bda9b7b85c75cd6c7ddfe39f5ce52efb7bb0bf0585b757343","s=
rc/backend/linux_raw/process/cpu_set.rs":"b31889f972676f57e3599375dfcd59dd7=
2975977ef345d11c22d51f0d4a6400b","src/backend/linux_raw/process/mod.rs":"fb=
393c70a9c63ef9a6bf1fb5a2dc94f07d6b0b6987cc5231c15c607015dafd68","src/backen=
d/linux_raw/process/syscalls.rs":"b9b6d542a39e021ab2b0b2128bdb436c22eb8c525=
56d185f01c58f1a1d9412ed","src/backend/linux_raw/process/types.rs":"6811ba82=
2bc12a1a6336649151b4adb1f5d3365684a31c07f01953ea9547743d","src/backend/linu=
x_raw/process/wait.rs":"921aee4b0048746087f52615a98edc2aa0fb4b53d6df44be453=
3098df55d1b05","src/backend/linux_raw/pty/mod.rs":"2c6478857a0751625edabd61=
acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/pty/syscal=
ls.rs":"ae09c4aecc0ae87b1ca58d82efc58007b9dddaae78460d615f48da19d1cd0f89","=
src/backend/linux_raw/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b02=
87b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/rand/syscalls.rs":"317cda=
f243623329ee345131054e86a06a0863a9e90c5dba73e1ac3475ba6305","src/backend/li=
nux_raw/rand/types.rs":"a21dbb1ab31eed6b59a57520be5a3c603c36d18ea74e67f7527=
f40835ba209a3","src/backend/linux_raw/reg.rs":"3e321750d91d77c835abd09b06b5=
851ebf3134d3affb3cce306e38329871bec4","src/backend/linux_raw/runtime/mod.rs=
":"b2cae8cce3822c3c92942f06ea0b68464040dcac33c6f0f7ee392c6269993347","src/b=
ackend/linux_raw/runtime/syscalls.rs":"ad0e266f0eec81be6e104d1e02ebf61e149f=
4f3c24d8f18cc4442adc313f3327","src/backend/linux_raw/runtime/tls.rs":"63160=
60560a112c2e9cd9807cdba6e8c91414113a04a739160929ae9a67bba1f","src/backend/l=
inux_raw/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489f=
a1d07f7cfd7","src/backend/linux_raw/shm/syscalls.rs":"3ebf91610b02de0312e1f=
0f0cc5d56e12b4d93794540087b3182cbdf3cb9c8db","src/backend/linux_raw/shm/typ=
es.rs":"8275dba36a8f2c4208f2d23ffef52c5b02d4b10d5450733cb4fc5cdfcd6285ee","=
src/backend/linux_raw/system/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b=
0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/system/syscalls.rs":"19=
a7ab17de906ec237f16a816da036723c1f55f605e8e4a26689343eb4cd76e7","src/backen=
d/linux_raw/system/types.rs":"1ceab8d738a71043473b26e97fa3fd79d588a86d4774c=
bc9b9e1d4f1447a016e","src/backend/linux_raw/termios/mod.rs":"2c6478857a0751=
625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/=
termios/syscalls.rs":"1a42438153f61e72aab7c3c8fdd0c3ab918da0fec58e07bb42423=
518065374e2","src/backend/linux_raw/thread/futex.rs":"0139394e11006301e9837=
9b7f07604aa10fb436b43acf8f55f1a24f1253f96cc","src/backend/linux_raw/thread/=
mod.rs":"6ad4a4b90b9234e79900b27ebbe8837e3a7a36aec532912e3e253edce5225067",=
"src/backend/linux_raw/thread/syscalls.rs":"e2c89bd3cf34a46b5d06de43933284d=
dd06ed07e9c789c726c1afa48f7842a5c","src/backend/linux_raw/time/mod.rs":"672=
724f55b7b7be6a7452bb1cc2d28b5f0aaa840a2856fe363acce624e1beefc","src/backend=
/linux_raw/time/syscalls.rs":"7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9=
806e5de9404845312fc","src/backend/linux_raw/time/types.rs":"5f49ee7b2019761=
14c6555f0c5a81d3305e18e726e54edc5a5474641f3cdc278","src/backend/linux_raw/u=
gid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d849=
52","src/backend/linux_raw/ugid/syscalls.rs":"8c86d251db33b399a1d1cbb8e87af=
e650b78db84f444d3251309b7a0480b54f7","src/backend/linux_raw/vdso.rs":"05631=
4f72c71d4b041739337ca2098afb7fe070f844327f462c293f43481b75b","src/backend/l=
inux_raw/vdso_wrappers.rs":"4fa1fb04d5812c9edf143b3228327475f4021f6cd52c75b=
eb51aeab4d1ad983e","src/bitcast.rs":"4d2b3619dac1500bee223e11db0b4a5f75b0fb=
de65094bab157597af71f6b72a","src/buffer.rs":"fbb262d0751546447ee95f1623d3f2=
eb450ff0b4a7e1df29c5a2c9cf205b8820","src/check_types.rs":"e52f710e1cfc12ca1=
3a495f2b43c227b293ff295e1ce3ab332935b28a7579872","src/clockid.rs":"bd66d6bd=
c6b73a4668dda5b6f91838b6ed6c4b9503a0798b071ef35c572b711d","src/cstr.rs":"41=
af2a4429fe6c67a8883f8a8f63d66c90df566abda74fd2b03bcef7b9f24218","src/event/=
epoll.rs":"af4c6d3088d8dd73709db595e47b633bb9c358d18078e53cdb0f749258d7b736=
","src/event/eventfd.rs":"81cbd08f7bdf40a6ce1ca692b63da1dc8ba925282990668d9=
d68f1203e839fa1","src/event/kqueue.rs":"1f381c8afa65d36e3052c476d2e679c3bcc=
b7e3d6cc6b95ba53b48abcbe13a81","src/event/mod.rs":"2e84e47c029f96eaf8870030=
a2f57ec68416035cd99fe7c05601ede40057fe78","src/event/pause.rs":"930219e19ee=
227729c8f86fe7271721e8797e917d2d7073fa8d7a104bf6189c0","src/event/poll.rs":=
"4de5f12e9cadd64e93e11e7b63248bf657700e6be2d8b40b0e5d5303eb34b4da","src/eve=
nt/port.rs":"4e51ff150e5d17cbd44aa64a38b99c15e26eaaf2e350768b5dcacdfde4fa52=
12","src/event/select.rs":"49ca840bfd39202494fed201fd34742c30ae5d3d6c115d27=
b8c232d2137105e3","src/ffi.rs":"50a14dfe10408f9abc6269b9ee6e7a88d99503d50b3=
732288e85b777915e579e","src/fs/abs.rs":"1c1e65be08da5f7d6e5b8902283855fef0f=
0a74ab227aae991aaf5310d0858f2","src/fs/at.rs":"68de994eb06fa90bf5b5088dc4ae=
280c6ac2222fcf137265d4256ce202869da1","src/fs/constants.rs":"23923e0fce3221=
bdac371fe2d05028f30a87dba4f9b4a573b69dc2d6d39320b2","src/fs/copy_file_range=
.rs":"d3b644374390d482b2ff749a2459458872b57d0dcf9670368739b7833509a7c2","sr=
c/fs/cwd.rs":"3400dd3954aa0d806af1960054899447de5e425481edfad539bdd5fd0b996=
7d8","src/fs/dir.rs":"347a52f4ca9ac6321c52e802e97ec90d1b4c62ec955c8996fc17f=
8f5aed69966","src/fs/fadvise.rs":"d77f6a7f7f6648e750888719e59f0f8332f11e844=
42ef72f622bcbd4e19be845","src/fs/fcntl.rs":"8ac62c8ecd3abf3778685f1534b5e6a=
0989a20df0c86c227af99ed3643b95d4e","src/fs/fcntl_apple.rs":"e2f23f038083621=
bcdecc98d02ce1023508afaecdb2ed0fba5c8b70f955301e5","src/fs/fcopyfile.rs":"c=
e565f61e1fbf2e31086077c2f1d01b6bb3b048915edda87fe9a4a4f5e8ff7e4","src/fs/fd=
.rs":"c9042ae0398dfbf39ec9ea8a0bebc6fa91ff76dc33f5aeb829313996036e4d66","sr=
c/fs/getpath.rs":"28f6970fc1bbc37bb35c84724b59eac436ea7407a4522e18c2bdacb1f=
dd2edd9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f97189cea4e5982a0d35b192afeec6=
340a6c6222e0cb","src/fs/inotify.rs":"2e4b9824c323c661667aefe06383cd3e843a34=
676852d9f5f79f62e48e975171","src/fs/ioctl.rs":"c8c6979fc7b0318796e2d760b86f=
f0495c679869439d9d6a8134c7acd704f4cc","src/fs/makedev.rs":"85520b484cb7c15a=
b71ea1c368578ea3b7e484d82f8510db92b6ce9f7ca341ae","src/fs/memfd_create.rs":=
"55a3d611184fe0e664f8e2a68cee359c4a65dfce0147305add139df65c292f01","src/fs/=
mod.rs":"0657052b4ce5934a3f7f95cbb16e06b75b10e4359142959d3d0a0ebe70fdc33a",=
"src/fs/mount.rs":"8f6ea2b997dd83c50c90291b9ada3ed77a9ce1ad701c9b0d533b5113=
b317be5b","src/fs/openat2.rs":"4a95c15dab533a41201b5fa25c8a212956b7571d58ca=
d696bdaf45af8aef96db","src/fs/raw_dir.rs":"6ad6d3dcdc6ddbb94f152b2584d7335e=
4b209d7219045ab4bdd6bdb2b7400e7c","src/fs/seek_from.rs":"a9efa0feb9ac789cf4=
7667e91efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","src/fs/sendfile.rs":"e3b20=
58741cf4b1698f34d84bb37130cf2b72806d522a16fe541e832cde136cb","src/fs/specia=
l.rs":"17a0f89f7462171169bbf5aa20a9ec934951fde7016daaed9bb1d12b468baf91","s=
rc/fs/statx.rs":"2844baac77fdda0d77823402bfbdbe5bf8983e1d3b229d700bf80c0c19=
0f2aa5","src/fs/sync.rs":"84f24de0ea53f77bd5c471e097abcbecd19c4843b69607f9b=
e9030eb7c9d5aa5","src/fs/xattr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6ca3=
a47200532ca6e72d44cbe8334","src/io/close.rs":"b4f7c0dd39554463c9692a09c4074=
4081e229b729610d7c530e084e92c63e8e5","src/io/dup.rs":"dd33bd405dd8368c2ef80=
73803ed1512cbe2c2d92194f3f38f44e766d2ff6ab3","src/io/errno.rs":"fe056ade492=
ef5b7e20fb9ffbc7e183b7bec6ff300587eb5197deaed5d321fda","src/io/fcntl.rs":"9=
9fa698c6a6c68ecece7e7d14e0a65e1b6e17d360f028e14f8800d42a355b22c","src/io/io=
ctl.rs":"e89a6e670fe1c06521aa2f266fcd7a990391a533995b787cabac223f0926c8c7",=
"src/io/is_read_write.rs":"a7d3cc1b8673a94d64926c03984e24a627c24e78f09070a2=
eb893d8005abf9d7","src/io/mod.rs":"0b566bf43b3f8754153f361119f63aa08ff2450e=
9306eb7e35ac3619bfeeae0d","src/io/read_write.rs":"46fd5efcc1205f8195b6d55ad=
277f71dcc62a2a52301dae03c0e5dbae6d70bd4","src/io_uring.rs":"4d163535b313a17=
98bea10190b8ff5211e8ef72ff822952a002af3b1c4946153","src/ioctl/bsd.rs":"d7d3=
f6813eac0e0f22fb8bcac3d193a22584393c1f7fa233999bd09c4e2059f7","src/ioctl/li=
nux.rs":"61f006e31a4e049787415131beb97e548accb17fb6105d7ead5a12df0727077f",=
"src/ioctl/mod.rs":"87e502a4de2f5ec029d64f606d3fda3831623f405434306e69f35a6=
aff5d3c04","src/ioctl/patterns.rs":"26116d5b5cd790ed485791e006c97c28590c038=
050c69c42c752289fa7fcbc65","src/lib.rs":"aadf83ff8226d5b94cd465e18927005bc1=
04b0a7a4f7e0f432d5b110be8b4865","src/maybe_polyfill/no_std/io/mod.rs":"7788=
9bb5c5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/maybe_po=
lyfill/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9cff3a1=
9049d88c8c80","src/maybe_polyfill/no_std/net/mod.rs":"1e94d21d455bb1da18a4f=
ccb24b3d93ad42698e22dd888b78115d6266c80288a","src/maybe_polyfill/no_std/os/=
fd/mod.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e80771d507c4=
7","src/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087cc9afd10269f09=
a8b4125915dc3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_std/os/fd/raw.=
rs":"f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999e7c6943","src=
/maybe_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2fcc7c825310606b=
889cc8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/windows/io/mod.rs":=
"5bbcc05c83fee5026dd744a994e0458469466d5be39081baa62df07753b92fd2","src/may=
be_polyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49328b5637cb3baf=
b96437f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/os/windows/io/s=
ocket.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5d2c64808308d65=
","src/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231a4e778b5f985b9=
ae712ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/std/mod.rs":"7c=
16c86cc73e226e65ead598e4018238b22000a345040b706bf1e1b3eba115fc","src/mm/mad=
vise.rs":"092ff2064b16960369a908aeed70ec38a16fa2a0207f814cdea379e2f2286954"=
,"src/mm/mmap.rs":"1cc428e40ae77b23718ce821a22806c067fcaa7aabebf57df5cede7b=
7abb2bcc","src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761211a494ca6f89b=
2367a2d2157e340e","src/mm/msync.rs":"0cfb895703b8b7bac47426c8f03499f2aced3f=
4e1f31008243a1a629e9d44a1d","src/mm/userfaultfd.rs":"8073443bd181ff0b3ba4d0=
b1ae67370b4864035a0c8b4898cd709dc47c518ae7","src/mount/fsopen.rs":"1c54a02f=
04ee6710e2c5053c73361eecc499c24cd72c7c7c012dc57a4621e382","src/mount/mod.rs=
":"5f0c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d12a7136cb19","src/m=
ount/mount_unmount.rs":"fa77675b023180b578b7fc053acb46ae2ed2eb11bb0488871bf=
d1ed211df73a0","src/mount/types.rs":"601ae3e10b7dc496fed7f3b40a80e81c6edd7b=
f13189d7be45c3212d4c684c39","src/net/mod.rs":"7899807c9ad9e3fdbfd8b3ce2a1c7=
053d4f46dd7fa76102f620c6042c2d6314f","src/net/netdevice.rs":"1d790ef6e33d30=
c3167ec422a95a711d6df26d69502cb0b4c4889623547d3693","src/net/send_recv/mod.=
rs":"ca923e7affc72bac1c67b3957f55a256dbdcd800c54ae866ebe71fb406ef79a8","src=
/net/send_recv/msg.rs":"7bbd89b593748d4ef63d76f1b47c429c48c2f5f3d4a6bfd9aa3=
7373ac26a77a1","src/net/socket.rs":"f6e0c454eadb52a8ead30e04851bfe095d65fd1=
b83ae6419dac2030e69b3f7d5","src/net/socket_addr_any.rs":"88250bf218d3a626e8=
e04bb11d4dd50ddf1422bb28d780c98b80710cf9c30166","src/net/socketpair.rs":"aa=
9013de19945bfea3f7d2889cc23abd384717b79f38cd5d045dec09c7517658","src/net/so=
ckopt.rs":"416485d98afaa1cbc492e0dea06edc2137e2b2e6b15e16c2479dd92ae456c355=
","src/net/types.rs":"8f89aa81f880c968bdcc6e2c48d6ae362b650599f3ff8c300c173=
5d52ac1e8df","src/net/wsa.rs":"29856e6d0108be6b719f6ef973c5396e48ddd58ecd0c=
2db9ca3e2e0ba4eccb5b","src/param/auxv.rs":"b57483d3083a4dfad9ceb049fd96d547=
13b91b7f31b8c9a0e40501548da499ac","src/param/init.rs":"a31c0e5cea61a1a99976=
7fe74f87c0d59eeb6bce66578b842fe0e0c32be27a55","src/param/mod.rs":"c514216b9=
6d9520c9ffc5662c97b24f1f36f56fe1f5f3c9f64175c8b35577288","src/path/arg.rs":=
"ab5ed60c8cbf0484dce25440f027d7d511ea329bbaeaf83d70717f5c7e47b5ac","src/pat=
h/dec_int.rs":"0c71377fa5137595d6316ee135617ab8e514a2f539d77e15ef3a626d7aa0=
92c9","src/path/mod.rs":"fbe294749100630467580f5e25b44e7a4f8a4512381cc18aca=
f1a6813afc39cd","src/pid.rs":"f1c486000c5b1311b2d720cee88f089c17ef9a1717096=
73dd06e6f35f4ff98a3","src/pipe.rs":"d5de91e5adb0ef8753e4c1ee5cfdff1f8bd8006=
8af1fa3a12239a47da5131832","src/prctl.rs":"19aa584895874ea48b9bbe1bf695b812=
57b0281df64dfdd91e1b4bfa298661b7","src/process/chdir.rs":"93ce4fade85e72088=
3f22e8b8a6c0c9b6ec3a07c37f457852b2c53aafeb8ad3e","src/process/chroot.rs":"0=
1191eeb86295975874019dc675cb0f8f0ca5f79dd78dc9d1c791a952adb3512","src/proce=
ss/exit.rs":"f09000df82151d015a39b8cfe7dc28875074ad1bfde326f63be1438cf736d0=
8e","src/process/id.rs":"7bf74a510b975b5f7f9a8e5565ad68c0b9e2eac0fd99f1551b=
806bb1a6684905","src/process/ioctl.rs":"c7f551152d65ac173d9eaa298b964339037=
b60a7b81e8bc316453718417a6be3","src/process/kill.rs":"674d06cf065c8045dbefb=
6fc6437a62b964069599fc03d84e64cc36186b96596","src/process/membarrier.rs":"1=
c4c39b359d1d0e9bbe16352eedfca9278d9ef298ade8ec00e998617bbcbfed8","src/proce=
ss/mod.rs":"a32691289982f4ffc53fef94fea4e3f375af9af87604fb962e94c54c9d91703=
b","src/process/pidfd.rs":"150413a9cc550ffc432b3279a368223fa9577544ef29e45e=
deff3b79ae316cab","src/process/pidfd_getfd.rs":"74c778b872be0b800870e463360=
6461fdc8493b259031e35f8f558768d960cc2","src/process/pivot_root.rs":"aeb2464=
464efd81ca0b940e3e5e3ed1b09380f3e6ba3200972e0ba100f78badc","src/process/prc=
tl.rs":"a34ccda958036f49c5e4a5d654566c2b18d59c4b48b31c91e63877191752712e","=
src/process/priority.rs":"ea78f09e4564943d0083eba19d9933781a5dd70d5723f156e=
b16ad01dd67d89e","src/process/procctl.rs":"27e082d23267ef9a19dcbdd7eb33a1df=
26eef42894202a728bc1d8a3f1ff27e6","src/process/rlimit.rs":"10becde11d8b5d3b=
50aeb21a8fcdf53ec7803bdbbf8d1f4233b8e6c0b85fafb1","src/process/sched.rs":"4=
f566593f7a6c12873ecb18f21b9806162791b33815c9147065d3c8d812b562c","src/proce=
ss/sched_yield.rs":"8f80fef12e528628d19c26d26ecbad61b9644505a872a49f842820a=
a52018cf8","src/process/umask.rs":"15841f5e178dd032f8b8def8545c9e98b205e6b1=
ba70bf9c07c2c0327a8999c0","src/process/wait.rs":"04d60c43e8ed1ac44e4ddc5ba6=
e18e5edf1c400565ea0e81ff8f1bf71403b7ba","src/procfs.rs":"adfac2c1232ff20c18=
251b8745f6732e3315b1adfe95b9e7297378dbcb290129","src/pty.rs":"30c68b21fe062=
7780a5ab48977b233bbc645d78566f9da3bf22bb2ac92a63e4a","src/rand/getrandom.rs=
":"a89f45838d22982eb0997bc905031819195701b64aa1c874e646dcb16d6e2a7d","src/r=
and/mod.rs":"e1fb7542f1958fe77673aa628bd92fef1b9addf79ba23df2398d1231cb61c1=
48","src/runtime.rs":"58abe84feb409ec5a97df922253d127f032e54d0b44989f2a9dff=
4852a1b7ce0","src/shm.rs":"30b32e302ad2d198de411981f3c7609082bc20f1c0651aa3=
f3ce2beb8f19c6e9","src/signal.rs":"0fcce2e37f69d70cfef1f355355979b269820281=
a6e63bd171ba05e525063e79","src/static_assertions.rs":"504cf66f0d5b8e335be02=
f9ae8b0a355abc98c2c82eec0098bdf0988e662e260","src/stdio.rs":"85e66975a55f91=
bfb764f848eab34acf1bf6ca7f37b6421043d1e2003ec14805","src/system.rs":"4954f5=
261bd25fd01ba6c97a1a0afa9cad4d768a1c10491d33b3bf2d0bba8371","src/termios/io=
ctl.rs":"aa26694c9be5378ea52e669313e64b25fc034e3863b72281530c42499570fedf",=
"src/termios/mod.rs":"b44b7caa60b6f458657ed58a0e0eca41bb4e6d6be4b0f042bbb8a=
b7056cebe4b","src/termios/tc.rs":"bafcc607de993c7e7c4cd6f15a59e7807906e59bf=
991a5a4c67e3b076d07e3f2","src/termios/tty.rs":"0013cc4c31907246b45c4b94ded0=
171dc0d3e6759740f5424831feae700092f7","src/termios/types.rs":"983927fcff70d=
dcbc4ba878bbd413e863805f9f6cc7a0f672add4a99866cdb85","src/thread/clock.rs":=
"cc4a981b7fc059cc88da709e31381c778d75c22f1b96cad5fa2799a45ecfef5a","src/thr=
ead/futex.rs":"b4a182cd4b490dab620c5fc59adfe79845c2e64f624cb8d9096a9375a059=
7b21","src/thread/id.rs":"1a9a8b4bfe71dba6aec17760ca9de5a66a80b9c608fa0eeb3=
0fd1bc949e511ca","src/thread/libcap.rs":"4c51b7df566d38dd0f85f81ef53279a745=
a39f0f4e1154791fd38438e2ca7db1","src/thread/mod.rs":"d6d9c3340cd9710869813e=
a9c993669d11620126edc66e5657a9de2a07a5f864","src/thread/prctl.rs":"3826dda3=
1b9452b2a8b30158b6babd0b536fe9ea314027863d14c3888c9435ee","src/thread/setns=
.rs":"ddee643bd095104242afc3ddd3ddcbcfd6a4876febf47200a63f9e22996e1dec","sr=
c/time/clock.rs":"7588a33f5279ee683f39ce72a8d0a8dfcc2e25d3dbc29990e6829d7c2=
df7d99b","src/time/mod.rs":"43afee938c80d124d04d4ba190c03f4d21d1e3bfc154fff=
309211e4f6eabe940","src/time/timerfd.rs":"f17092b84553741aa2d2b44c6992b5d2c=
8c96cc2c2007fc9a2c6b2064485e53f","src/timespec.rs":"32a4d930cbc0f6dbd231532=
90db920671cf4ce65a4a127e176f897c1cde42d7d","src/ugid.rs":"6616c6e35b7e43aee=
5b150f1efae7a50711e0947943c9a96833dbe214ad9e85f","src/utils.rs":"ad680ad856=
4cb7b37fc746e0b3f89d389278fe1b294ef343a5c4a37677414065","src/weak.rs":"7e31=
69bc97e76fc4d52b040391a8df36b06536fc0f81cc6e8e71b951cb1fe54e"},"package":"9=
9e4ea3e1cdc4b559b8e5650f9c8e5998e3e5c1343b4eaf034565f32318d63c0"}
diff --git a/recipes-devtools/rust/libstd-rs_1.84.1.bb b/recipes-devtools/r=
ust/libstd-rs_1.85.0.bb
similarity index 88%
rename from recipes-devtools/rust/libstd-rs_1.84.1.bb
rename to recipes-devtools/rust/libstd-rs_1.85.0.bb
index 06a2889..1994368 100644
--- a/recipes-devtools/rust/libstd-rs_1.84.1.bb
+++ b/recipes-devtools/rust/libstd-rs_1.85.0.bb
@@ -2,7 +2,7 @@ SUMMARY =3D "Rust standard libaries"
 HOMEPAGE =3D "http://www.rust-lang.org"
 SECTION =3D "devel"
 LICENSE =3D "(MIT | Apache-2.0) & Unicode-TOU"
-LIC_FILES_CHKSUM =3D "file://../../COPYRIGHT;md5=3Dc2cccf560306876da3913d7=
9062a54b9"
+LIC_FILES_CHKSUM =3D "file://../../COPYRIGHT;md5=3D9c0fae516fe8aaea2fb601d=
b4800daf7"
=20
 require rust-source.inc
=20
@@ -24,6 +24,8 @@ DEPENDS:remove:riscv64 =3D "libunwind"
=20
 # Embed bitcode in order to allow compiling both with and without LTO
 RUSTFLAGS +=3D "-Cembed-bitcode=3Dyes"
+# Ensure that user code can't access the dependencies of the standard libr=
ary
+RUSTFLAGS +=3D "-Zforce-unstable-if-unmarked"
 # Needed so cargo can find libbacktrace
 RUSTFLAGS +=3D "-L ${STAGING_LIBDIR} -C link-arg=3D-Wl,-soname,libstd.so"
=20
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.84.1.bb b/recipes-=
devtools/rust/rust-cross-canadian_1.85.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.84.1.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.85.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.84.1.bb b/recipes-devtools/r=
ust/rust-llvm_1.85.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.84.1.bb
rename to recipes-devtools/rust/rust-llvm_1.85.0.bb
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rus=
t/rust-snapshot.inc
index e3c70aa..98358bc 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -1,59 +1,59 @@
 ## This is information on the rust-snapshot (binary) used to build our cur=
rent release.
-## snapshot info is taken from rust/src/stage0.json
+## snapshot info is taken from rust/src/stage0
 ## Rust is self-hosting and bootstraps itself with a pre-built previous ve=
rsion of itself.
 ## The exact (previous) version that has been used is specified in the sou=
rce tarball.
 ## The version is replicated here.
=20
-SNAPSHOT_VERSION =3D "1.83.0"
+SNAPSHOT_VERSION =3D "1.84.0"
=20
-SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "5b96aba48790acfacea60a6643a=
4f30d7edc13e9189ad36b41bbacdad13d49e1"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "08cabe06aa116b78b351ab1ca1=
d7ccf0dc18d97d999f3e0bf228021291314d5d"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "8804f673809c5c3db11ba354=
b5cf9724aed68884771fa32af4b3472127a76028"
-SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "aa5d075f9903682e5171f359948=
717d32911bed8c39e0395042e625652062ea9"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "9f5650aece53e083b933a57e5a8=
e0e2db4479f52ec897d5b6d0f77be6cd50498"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "023f0b6153b23ac0e9686c2a=
b95bc393ee3e295b166bb36de3b4dfb53e3913e0"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "68d4ad239b6d1e810e7b8591636=
dc408cb2c1e89661329fed906febf9c0a9d98"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "6022245416a988b9952f36bf20=
f62de0c2f3337bd150e34439ea6651592ac8ca"
=20
-SRC_URI[cargo-snapshot-i686.sha256sum] =3D "906976544e7f6bac7ee4f54eae56f3=
162fe7dc06744cf84149699be57bd0b4c7"
-SRC_URI[clippy-snapshot-i686.sha256sum] =3D "4fb7ed75796336f4972675225ac4e=
1f2a8ba58ddf350dd51f1d482c7084b0c6f"
-SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "d6763f3ff18fa6da4455058fcb8=
4ef19c2586fca02badab466200d90fa4184d4"
-SRC_URI[rustc-snapshot-i686.sha256sum] =3D "421fba974b062b1b9749792466214e=
563589a05f888673989b0208b1dc66ac43"
+SRC_URI[rustc-snapshot-i686.sha256sum] =3D "f0bc277e8e8c072d20ee91784f919c=
08b34a65ab56b67bcd2bb98a009cdcf97c"
+SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "e710100be26e742733d445722a3=
7227381f1ec2010664ece85489bc598d70456"
+SRC_URI[cargo-snapshot-i686.sha256sum] =3D "3a20231475b75f2f6ad0f7c5de283c=
5706403b41e941d3f1ca6cccfbced214c6"
+SRC_URI[clippy-snapshot-i686.sha256sum] =3D "8b5bdd84b9128abc6d61bc1acb60e=
55eab90e063c7057371b4e6f79aaa1acb9b"
=20
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "c7b537bc2bb4b685eae8050=
3657b89bf59c51303c90ebc042b0fb39b21cf252d"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "895d1f9cacce934f0e72e0=
6df9f4653c48d2df4a2070206a6b8b21908ce07d1f"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "5804d1e989c03620b3be=
df0ce43c98395fcfae1d6923446c31ae5562ee56916e"
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "b3afba9debf0e153f5dc69e=
cb0b020c0d6159002bd3b4b845c6797480c07d50e"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "33ecfb62afce6e30864f07b=
4e3b76ac6d9f603a3626e5228ad0d59a7ee263cc1"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "763b93ca08028a1e63a8=
a3754ac6118b2659022538e5e33675f2d7620488cd57"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "1531b9f3d09983c43f54d7e=
5ced6b452044e82b24609532e8cee345656e5d8a4"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "80719f10010eaf6a26ba7b=
2f8c5c7bce3a78fd838cbbe17c00a4e3e7cd45fe5e"
=20
-SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "05c353dfeaf51e960e5f916e345=
f0f0d0497851428a3faa997a62a8563e63109"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "0e93e1bac1c195d89b9b94a900=
ffa3191228c6c66f5a5bf2f656a1a72fdfa163"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "17978a56a8efef883485201d=
c701ed2ff13530511578da240840f12bdc55cb27"
-SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "f843dadf7f1f0148e78480dfcde=
caa8eef15aa8382576ff41c82799c6233039b"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "ac99e907c9819b61de94a6c12b6=
4256661e5d76c53f3ed25246b46741d1dc973"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "fdbb75060e59ad59273a8ef1=
1fc2ad61837539686df0e8dfe46107e1b15ab90a"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "dedcb36320cfa924e2d21552057=
f88ee8a30c0424802015494c2f6237150ec55"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "de2413ae321d2bccf77c77acb1=
e9775b63eca1993ee1450e65e388f029565a51"
=20
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "889f2cc33c77a34ae962629f0=
469c6138a5d4d6efeb5f383a87443181845a771"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "35be1a0ef924178521044712=
6a18fccb4114fe54776f3e20e21d89c025b05498"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "adcefafca7a7b7ddb220d1=
8e31afdfd4c547f87b1515e45098513b2d468043e7"
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "267089f5c1d7364ccf56f2246=
f37d668d386edcf2154c985a6e51c928e50dde6"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "1f5ff831c9fd97d7d306eb7d9=
9186b9e49f35527144aaabd43f67f04449cd732"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "f2819f8ce1ae41c2c2bcf4=
0fc90d6b1a5d340d3e9558267d464730a797122bf5"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "09d9954bf817404c08a8ac952=
afe1e086ad11fe20d07522a4bde5f26bf7fb5d2"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "a34cde35f254210cbb212c3f=
a85411efaa8e70d600d2c2404b7b319eae9b5be6"
=20
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "7a1b7b1d18f562be446db88=
80fbcc26f4f5581c273a5d547231e8da3d06e3f39"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "7f6a3b6c99a38a0a672265=
2c8b342b16397000f198ff5b8ae5c042336a88db89"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "d39fdf0954e57fa9dd07=
63d58e7897bbb93265ab217e5fef14a11fafe2f706a3"
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "5978f9b3246c71cefb5266e=
56403c1071fed70d71019bd839c4601d7b6f9eac9"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "1f6aa28f848b24d4589277b=
04535ad0258e72b5fa78a4a85ba6d18db95636d69"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "db731e894cce9973ab2b=
41109c9097d0fc6a49c0d45a0d333bd1547d2c7485a1"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "7dc351327de2567cce2a338=
7f110cce1db20c68fc529353c5cdef2eada5dbfd8"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "b53cb58c719b84044de628=
51b6214db8d504f57ad71e81b373d7dea0393146d8"
=20
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "ddfcc41a419f1d1a7637a9729=
32d37e3c5487343f9be3deaeacf06027fbb0567"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "feea5dae4dfb65b608590b5e=
7b5c693da12f8e559e3b1a7b6b19dbae580b0ede"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "6a5467d1f4b8040f19c94c=
a332063cad57581d6cfd1f15543da5a67d4d244f70"
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "3f0c56d778985f69aff3ae58a=
a157025ad807d8b5821b8f98108be6f8a283e21"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "c0eaf824c7789c94901f89579=
2333595fe131e43f097bcf5987301cc1b14c3f0"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "451580f9cdc47eef4efb09=
86b1960a8f9c4fb0959f81b77eb6292e6bcff9fc64"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "3a850b74bdf2c3a5912e9f1ea=
32aaf1c9ac7c5f89c1c0bcf421b961195833992"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "fb8c9d489e10a961f9faa550=
980069738b5f0f68740e34d7b3ee46a262b53af7"
=20
-SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "2044ee69985da536dc1786e949828=
eba88516ee01ad88a4c36d753c471143ccf"
-SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "fdab081200826ba47929030cd7e9=
d82c843122fdd26fc3edff9e52a2d91f68b0"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "d1e1af8622d59c3351046ded96=
af4eeecb3db2f4f7527249eaf1acc917e3f2e8"
-SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "ccf73e94f3f60dfddc26640df95db=
b82939aa572d50cda0aeafaa36b47b28f07"
+SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "7dbc2fc2c04e820f636bfc7409339=
6c55df0296f7ee4f0547bb849d9a9f05fe0"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "5208f45cec5f3600f2cbc11d17=
96bc217f09e9c922689c8e4f0cc3f2b83ebb74"
+SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "bdf944ff5c0b97e8b64093fff8d1f=
63926df86b5e98f91d30c7bd844c6efa20f"
+SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "b02a586369e6edebb0f0608e3964=
72d1867419213fd01ba32f3c847e4c5a3c07"
=20
-SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "de834a4062d9cd200f8e0cdca894=
c0b98afe26f1396d80765df828880a39b98c"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "ef6c05abcfd861ff0bca41d408e=
126dda195dc966ee35abee57645a12d418f5b"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "c88fe6cb22f9d2721f26430b6=
bdd291e562da759e8629e2b4c7eb2c7cad705f2"
-SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "6ec40e0405c8cbed3b786a97d374=
c144b012fc831b7c22b535f8ecb524f495ad"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "a1737d86f80b31a6d48a67267262=
75dc068ecb930c9635b13aa59999486de837"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "770237080b9310d126350c3bd=
70820bd91064c2e96c29ab5f2e002b31b5bd067"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "6c2371488db92a09cd50a1b4045c=
022f3cf2c643285b3b21105ab5f9b64fd6b6"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "1db0212c08e126bf6ee28a0d363=
c5d6859fe357aa9e91d0247059397dbe7e1fd"
=20
-SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "7948ff50f7e83a20deba9d4f551=
70f7e3b0d805e80049f38b19f41580a9d7bb1"
+SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "a877622fbbfa58304c34372d369=
e95db106cc35758ca59053144bf7d86fbf3fc"
=20
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "e8684ba5d337dbb0594cdc8e=
4e8ffa11d7ac8e48b2f294019e042e341fa9a869"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "ecd1662d6cbbb62984ab31ae=
787442f1ab32caf6bc17260d407b3a94b434ad32"
=20
 SRC_URI +=3D " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-s=
napshot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
@@ -62,6 +62,7 @@ SRC_URI +=3D " \
 "
=20
 RUST_DIST_SERVER =3D "https://static.rust-lang.org"
+
 RUST_STD_SNAPSHOT =3D "rust-std-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unk=
nown-linux-gnu"
 RUSTC_SNAPSHOT =3D "rustc-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-l=
inux-gnu"
 CARGO_SNAPSHOT =3D "cargo-${SNAPSHOT_VERSION}-${RUST_BUILD_ARCH}-unknown-l=
inux-gnu"
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index 820cdc1..e070558 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -1,30 +1,19 @@
 RUST_VERSION ?=3D "${@d.getVar('PV').split('-')[0]}"
=20
 SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.=
tar.xz;name=3Drust \
-            file://rv32-cargo-rustix-0.38.38-fix.patch;patchdir=3D${RUSTSR=
C} \
+            file://rv32-cargo-rustix-0.38.40-fix.patch;patchdir=3D${RUSTSR=
C} \
             file://rust-oe-selftest.patch;patchdir=3D${RUSTSRC} \
-	    file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=3D${RUSTS=
RC} \
+            file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=3D=
${RUSTSRC} \
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.pa=
tch;patchdir=3D${RUSTSRC} \
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-ru=
st.patch;patchdir=3D${RUSTSRC} \
-	    file://revert-link-std-statically-in-rustc_driver-feature.patch;patch=
dir=3D${RUSTSRC} \
-	    file://Zdual-proc-macros-additional-check.patch;patchdir=3D${RUSTSRC}=
 \
-	    file://fix-tidy-check-failure.patch;patchdir=3D${RUSTSRC} \
+            file://revert-link-std-statically-in-rustc_driver-feature.patc=
h;patchdir=3D${RUSTSRC} \
+            file://Zdual-proc-macros-additional-check.patch;patchdir=3D${R=
USTSRC} \
+            file://downgrade-bootstrap-cc.patch;patchdir=3D${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] =3D "e23ec747a06ffd3e94155046f40b6664ac152c9ee3c2a=
dfd90353a7ccff24226"
+SRC_URI[rust.sha256sum] =3D "d542c397217b5ba5bac7eb274f5ca62d031f61842c3ba=
4cc5328c709c38ea1e7"
=20
 RUSTSRC =3D "${WORKDIR}/rustc-${RUST_VERSION}-src"
=20
-#After updating to Rust 1.85 we can revert this removal of "src/gcc"
-remove_gcc_directory() {
-    # Ensure the gcc directory exists
-    gcc_dir=3D"${RUSTSRC}/src/gcc"
-    if [ -d "$gcc_dir" ]; then
-        rm -rf "$gcc_dir"
-    fi
-}
-# Add postfunc to the do_unpack task
-do_unpack[postfuncs] +=3D "remove_gcc_directory"
-
 UPSTREAM_CHECK_URI =3D "https://forge.rust-lang.org/infra/other-installati=
on-methods.html"
 UPSTREAM_CHECK_REGEX =3D "rustc-(?P<pver>\d+(\.\d+)+)-src"
=20
diff --git a/recipes-devtools/rust/rust_1.84.1.bb b/recipes-devtools/rust/r=
ust_1.85.0.bb
similarity index 99%
rename from recipes-devtools/rust/rust_1.84.1.bb
rename to recipes-devtools/rust/rust_1.85.0.bb
index dfc9960..16b7ea2 100644
--- a/recipes-devtools/rust/rust_1.84.1.bb
+++ b/recipes-devtools/rust/rust_1.85.0.bb
@@ -1,8 +1,8 @@
 SUMMARY =3D "Rust compiler and runtime libaries"
 HOMEPAGE =3D "http://www.rust-lang.org"
 SECTION =3D "devel"
-LICENSE =3D "(MIT | Apache-2.0) & Unicode-TOU"
-LIC_FILES_CHKSUM =3D "file://COPYRIGHT;md5=3Dc2cccf560306876da3913d79062a5=
4b9"
+LICENSE =3D "(MIT | Apache-2.0) & Unicode-3.0"
+LIC_FILES_CHKSUM =3D "file://COPYRIGHT;md5=3D9c0fae516fe8aaea2fb601db4800d=
af7"
=20
 inherit rust
 inherit cargo_common
--=20
2.49.0


