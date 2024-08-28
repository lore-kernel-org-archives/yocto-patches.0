Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909EEC71147
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:16 +0000 (UTC)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
 by mx.groups.io with SMTP id smtpd.web11.5860.1724875811564576608
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hzPgTLcw;
 spf=pass (domain: konsulko.com, ip: 209.85.166.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39d2ac2a9d9so23668455ab.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875810; x=1725480610; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8r7VhQpicTiZRqa5wT5r7fV9RdbFEG19uWfa8EeoSE=;
        b=hzPgTLcwVhZcrMxg5eDBMwOjXx0g0Xs7XhYBOwU6yir+PN1gpzRQLbBxMlJXiYcATl
         Ow+A4aESKVWmiJzB+s7RST+0imxaZhDy9YjOc3HLg4Aqx3OoylwAkYHbxVBto3SFsrma
         yRZncQGSK5kQWQ5FWWzOn+qe1jeYSbUCKY9NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875810; x=1725480610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8r7VhQpicTiZRqa5wT5r7fV9RdbFEG19uWfa8EeoSE=;
        b=ocOSI5zj4hORccUeyLuJqOtxYdLLmB/ivZQLzf8KGvhNFcFkPDq9H3DXKyVg+eHJ13
         mFqPRkvIcmtav0zahzHno0tSC4ks4pX6mAEiYF5LsQxZfod2zFLlXYuUni67MsjR40xF
         zR4RwGLA8nyEDYy6tm9Jenw97rXQuUeH9YtCrt/QwGTtpA3Ah/6qarhvifOg3amZxjVS
         qOnbem6c8ugwsL7ldarLGsIKFe80Yu/lCY/vkvXLGGpclAl9KyuByaH9w8Xy5STPJyoI
         5ZmIcwdKUaByn4eePFWudJ3P9cweopHa3KLJLnmYUkycj7vA5MbwpnAEtFZBPiy/8HbF
         x6yw==
X-Gm-Message-State: AOJu0YwTwzl64EShqriIlxFxzKeWEyAyfuDltTyx3VTLspQrzjBnw3qp
	szZVZAgtmv0y2Orsoqu5ZH4C6YzvREldM6i5ThQu9Fx7ghdV9I/r/Wq1Q+0ytB7Z86fCHmCxrrk
	n
X-Google-Smtp-Source: AGHT+IFy8pXJFFrYDRUnyyXwZfAx7piCt4QwoT+H2J42HnYzNQqjvBA7D1NpeEh4i6VCnD9e5tNHZg==
X-Received: by 2002:a05:6e02:1521:b0:398:39f:8b4d with SMTP id e9e14a558f8ab-39f378ed514mr10601325ab.5.1724875810464;
        Wed, 28 Aug 2024 13:10:10 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:10 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 26/33] rust: reproducibility issue fix with v1.76
Date: Wed, 28 Aug 2024 16:09:12 -0400
Message-ID: <4dd533209e7913e1c35628e8146176e9a06b4440.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/592

From: Yash Shinde <Yash.Shinde@windriver.com>

A few crates are using the updated version of the 'cc' crate and
this is causing the generated object file names containing a unique hashmap=
 id.
The hashmap addition to generated files is reverted here.

Signed-off-by: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>
Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 25fed23ea9dcd1e7f0c11a1e3a988a33d5676c0b)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...epro-issue-fix-with-cc-crate-hashmap.patch | 59 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 60 insertions(+)
 create mode 100644 recipes-devtools/rust/files/repro-issue-fix-with-cc-cra=
te-hashmap.patch

diff --git a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hash=
map.patch b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashm=
ap.patch
new file mode 100644
index 0000000..26775ef
--- /dev/null
+++ b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
@@ -0,0 +1,59 @@
+rust: reproducibility issue fix with v1.76
+
+A few crates are using the updated version of the 'cc' crate and this is c=
ausing the generated object file names containing a unique hashmap id.
+The hashmap addition to generated files is reverted here.
+
+
+Upstream-Status: Inappropriate [https://github.com/rust-lang/cc-rs/issues/=
1117]
+Signed-off-by: Sundeep KOKKONDA <sundeep.kokkonda@windriver.com>
+---
+--- a/vendor/cc-1.0.79/src/lib.rs
++++ b/vendor/cc-1.0.79/src/lib.rs
+@@ -56,12 +56,11 @@
+ #![allow(deprecated)]
+ #![deny(missing_docs)]
+=20
+-use std::collections::{hash_map, HashMap};
++use std::collections::HashMap;
+ use std::env;
+ use std::ffi::{OsStr, OsString};
+ use std::fmt::{self, Display, Formatter};
+ use std::fs;
+-use std::hash::Hasher;
+ use std::io::{self, BufRead, BufReader, Read, Write};
+ use std::path::{Component, Path, PathBuf};
+ use std::process::{Child, Command, Stdio};
+@@ -1037,24 +1036,7 @@
+=20
+         let mut objects =3D Vec::new();
+         for file in self.files.iter() {
+-            let obj =3D if file.has_root() {
+-                // If `file` is an absolute path, prefix the `basename`
+-                // with the `dirname`'s hash to ensure name uniqueness.
+-                let basename =3D file
+-                    .file_name()
+-                    .ok_or_else(|| Error::new(ErrorKind::InvalidArgument,=
 "file_name() failure"))?
+-                    .to_string_lossy();
+-                let dirname =3D file
+-                    .parent()
+-                    .ok_or_else(|| Error::new(ErrorKind::InvalidArgument,=
 "parent() failure"))?
+-                    .to_string_lossy();
+-                let mut hasher =3D hash_map::DefaultHasher::new();
+-                hasher.write(dirname.to_string().as_bytes());
+-                dst.join(format!("{:016x}-{}", hasher.finish(), basename))
+-                    .with_extension("o")
+-            } else {
+-                dst.join(file).with_extension("o")
+-            };
++            let obj =3D dst.join(file).with_extension("o");
+             let obj =3D if !obj.starts_with(&dst) {
+                 dst.join(obj.file_name().ok_or_else(|| {
+                     Error::new(ErrorKind::IOError, "Getting object file d=
etails failed.")
+Index: rustc-1.77.0-src/vendor/cc-1.0.79/.cargo-checksum.json
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--- a/vendor/cc-1.0.79/.cargo-checksum.json
++++ b/vendor/cc-1.0.79/.cargo-checksum.json
+@@ -1 +1 @@
+-{"files":{"Cargo.lock":"dddb9c49058d411a098e98dc1c06e3bc89f859a2080d96c11=
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
+\ No newline at end of file
++{"files":{"Cargo.lock":"dddb9c49058d411a098e98dc1c06e3bc89f859a2080d96c11=
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
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index 50d9466..dff95ec 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -12,6 +12,7 @@ SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${R=
UST_VERSION}-src.tar.xz;n
             file://rustdoc-repro-issue-fix-cargo-config-for-codegenunits.p=
atch;patchdir=3D${RUSTSRC} \
             file://cross-targets-backport.patch;patchdir=3D${RUSTSRC} \
             file://rust-oe-selftest.patch;patchdir=3D${RUSTSRC} \
+            file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=3D=
${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] =3D "805482b436442a6786d270cacbab8f00529e06141b27b=
7fb01909b97ce4f3464"
=20
--=20
2.46.0


