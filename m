Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3056.1795645887848215059
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YNy+ocRn;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53634b8328eso59840441cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645887; x=1796250687; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RBj8VM9ehhKC1a9Ar2fZLWUveyrxDQ3J/EUmLQUvMc8=;
        b=YNy+ocRnvIiAAg8wE8MJN7EFb1ZoTx0EM8Nqw4/jDMBpBNrFNQ2qj4JeyCUOfzfqey
         aM7vFgYCK6h9/aN2DMUhnQEhOxih2TMrHL+TXMZrjEBf6p1IgNf4GZDt5pqai/y6zE+3
         jmxRQzTx1y0ve9klr7XcuTbvfCv2xFC8Uz3ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645887; x=1796250687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RBj8VM9ehhKC1a9Ar2fZLWUveyrxDQ3J/EUmLQUvMc8=;
        b=qn8bxDTPvlnUqwGW9mwjbKpTY8yhqpu8aTFD/fuuxRklFwgV0op1+skV9p1WJY1Ttk
         UQ+0bSk9ZZOOPmlwSvGr1RXDsvCJ6REipMgv4r5StIEG6d5ayBm2cjg0/mV6MLtpbE3P
         t3QRiutgdAliEixyod8Ohd3HmEJ1ApgnsV1Fn4xB8VBSuisd8iKKTo60tuFViLCUHaPo
         xm9Tu2syuBbDh4UtnJk5FBk9YKa4LiFTB97qu8AHd/9WR9AWp/+eu17TkjGKcoxI67tQ
         FIfG5Sl1dcXugA+AZzOXOyIhq1NxO4nu9mmPyAW7/9a7YxJmB2uFy3ZzTyKo5+xyWwQ8
         08cw==
X-Gm-Message-State: APuU4Z9RqOJUhBg9ZvVW8/eXpdJJWCoqontmTkyQipJrtCGSkSJHvbuY
	3t84ohE+myq2LFq0COZUOTigObJanlKv1usgAuBX8/zsPOd+dLAfsyGJC96fhRosGzBBF69EtpN
	W/Dhu
X-Gm-Gg: AZFdTZf2E+26i7yYVg5XfXjuaHRIXXfVGh9U/cNgdVIl/1iEhypO7w6MiVWEIq3hGks
	wHse+slTiAfvaxCnFO8vb+m5PWV+PouUGMiHD9Y2Jz419e/NJoTFd5fsxmZDCj4VN0dU5ZykboF
	GgZBiQhhaCb3YneR3/Cv956kwhH3BExqOga+vDTwpqDS6AA+UJC2ZK4x3ZKkFAMmlUSWD8Cwtph
	9OuOy7mf65PDbv26CWiawg5gwNjXj/n27BkR1Ms+jwHELZVBh07nn/0MLIlBLeB0Kf7Z6iW3cz9
	wB9jjEq3S2H5gafgjdmFa9w6nbl+Tm/SSdC9TDmc2X5X3Uwh1lJQ5kCzslNGeY8v0TKvlc+GFzH
	JZOXYoLAtBeObwJ3+f1J/uJAv+8pMV5EDtNPUpKZPTsVPXMx3sjavLotj4mGX0tMZs7sciauKOn
	zSMdlyelncYB+koA8lrdr7Uy1YX3uFc9YT6Lj1yNcUGYPSdAwifA/Q6nEOkOB/DY2dQtlmGGyU4
	AylT3149VJ+pd5k7Wrp4ipbWoK/eu+slO7A37ikcY+mAeFCCn5XIXckUH+jrXlUc2s2YkpVCLrc
	DGpbjsTG5A+u4aw3Z6TqSgILkcl6a7e88IpeTXd/Qsud/w7x2VQ0g0Q8CT/nzpz0hrQWEra4DWM
	5rMKRoXgccR59Za5PCIYgByOF7eH3+jduU5TLs/zJedgpVsW8C59EBO6EGaWBW9myXakouD3+5g
	EaSgbzr4YVY0o=
X-Received: by 2002:ac8:5a0a:0:b0:537:83ea:f96d with SMTP id d75a77b69052e-55d7693bbecmr373673991cf.8.1795645886486;
        Wed, 25 Nov 2026 14:31:26 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:26 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 05/19] rust: hash cc object names relative to their source roots
Date: Wed, 25 Nov 2026 17:30:56 -0500
Message-ID: <4faa9e35b7ab98b8e88f826930b276f7bbc0d2b3.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5524
Content-Type: text/plain; charset="utf-8"

From: Sunil Dora <sunilkumar.dora@windriver.com>

compiler-builtins compiles two sets of sources with cc: the
outline-atomics files it generates into OUT_DIR and the compiler-rt
intrinsics it reads from RUST_COMPILER_RT_ROOT. cc hashes the absolute
source directory into each object file name, so the names change with
the build location.

The added patch strips OUT_DIR or RUST_COMPILER_RT_ROOT before hashing,
falling back to CARGO_MANIFEST_DIR. It replaces
repro-issue-fix-with-cc-crate-hashmap.patch and covers both sets of
sources.

[YOCTO #16376]

Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit d55a54f1ccdd2223db8afea9b60cd3fcef6a70c6)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...bject-names-relative-to-source-roots.patch | 73 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 recipes-devtools/rust/files/cc-hash-object-names-relati=
ve-to-source-roots.patch

diff --git a/recipes-devtools/rust/files/cc-hash-object-names-relative-to-s=
ource-roots.patch b/recipes-devtools/rust/files/cc-hash-object-names-relati=
ve-to-source-roots.patch
new file mode 100644
index 0000000..c128bd7
--- /dev/null
+++ b/recipes-devtools/rust/files/cc-hash-object-names-relative-to-source-r=
oots.patch
@@ -0,0 +1,73 @@
+From afb2b50f588cc02042f50aadbd1c28f19bbcd586 Mon Sep 17 00:00:00 2001
+From: Sunil Dora <sunilkumar.dora@windriver.com>
+Date: Tue, 15 Sep 2026 17:05:37 +0530
+Subject: [PATCH] cc: hash object names relative to the root the source came
+ from
+
+compiler-builtins builds two sets of objects with the cc crate: the
+outline-atomics sources (lse_*.S) it generates into OUT_DIR, and the
+compiler-rt C intrinsics it reads from RUST_COMPILER_RT_ROOT. cc hashes the
+absolute source directory into each object file name, so the names change
+with the build location and the shipped rlib is not reproducible.
+
+Strip OUT_DIR or RUST_COMPILER_RT_ROOT before hashing, falling back to
+CARGO_MANIFEST_DIR as upstream already did.
+
+The OUT_DIR part is generic and is merged upstream as rust-lang/cc-rs
+commit fe27e7b6262, in a slightly different shape: the upstream tree
+moved on from the cc 1.2.0 that rust vendors, so the change here keeps
+the form that fits these sources. RUST_COMPILER_RT_ROOT is set by
+rust's own build system, so that part stays local to this patch.
+
+Upstream-Status: Backport [https://github.com/rust-lang/cc-rs/commit/fe27e=
7b62629daddccf1bdc9e9a447a37de2cd06]
+
+Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
+---
+ vendor/cc-1.2.0/.cargo-checksum.json   |  2 +-
+ vendor/cc-1.2.0/src/command_helpers.rs | 18 +++++++++++++++---
+ 2 files changed, 16 insertions(+), 4 deletions(-)
+
+diff --git a/vendor/cc-1.2.0/.cargo-checksum.json b/vendor/cc-1.2.0/.cargo=
-checksum.json
+index 470ecbb..2ff8a08 100644
+--- a/vendor/cc-1.2.0/.cargo-checksum.json
++++ b/vendor/cc-1.2.0/.cargo-checksum.json
+@@ -1 +1 @@
+-{"$comment":"This file only protects against accidental modifications. It=
 is not a security mechanism and does not protect against malicious changes=
.","files":{".cargo_vcs_info.json":"d6e26674a9d7de87dab83262a14f2377988a1e0=
87e4b514f3983f8dd141ea813","CHANGELOG.md":"fb0a3bcb34301d2578bef86feabe9305=
7068cb1906a7f10b584f58ff6123e8c6","Cargo.lock":"b661254fadca74408d53742755b=
371f7ae29e501e851aeae13bcd14a51883321","Cargo.toml":"50debe1b2fc050e8b305bd=
d514509d98cdbc59e96e5f10888df4b6fca19d3a75","Cargo.toml.orig":"0aff9dc74ddb=
e3bfe89ad9698212a6a18d6124b9593780aad25e277d28e9a71f","LICENSE-APACHE":"a60=
eea817514531668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-MIT=
":"378f5840b258e2779c39418f3f2d7b2ba96f1c7917dd6be0713f88305dbda397","READM=
E.md":"f1ddbede208a5b78333a25dac0a7598e678e9b601a7d99a791069bddaf180dfe","c=
lippy.toml":"aa7850db4350883c8f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb=
1d","src/command_helpers.rs":"b766a70e39b8ea7bb57afd288bcac205a23f6a26ac561=
9cb1d5b10f70c5dfdea","src/detect_compiler_family.c":"97ca4b021495611e828bec=
ea6187add37414186a16dfedd26c2947cbce6e8b2f","src/lib.rs":"221ba9475100303b5=
c694b2a02e5353452ee08a29e4e4d4d67ea8fcbd87605df","src/parallel/async_execut=
or.rs":"4ce24435fff6b6555b43fee042c16bd65d4150d0346567f246b9190d85b45983","=
src/parallel/job_token.rs":"018a01cb00182270bbcb68e31e7a7c5c621a95f086e4c68=
cfa2bf557ac24e5f2","src/parallel/mod.rs":"bd9c1334d17d138c281961c690b8d8118=
a2d6295a7d6cd7296826255436fa063","src/parallel/stderr.rs":"74384d41198740a6=
fce0877f144262db09fb091225fa8fbfa771314bb11487c6","src/target.rs":"7313240d=
b078ad85c1209a42a5fa96c3692b5d6e5093c7f366a1b99677247109","src/target/apple=
.rs":"6afbecac9f66aa72db55694413532f80b2753f28466a6213d1aa901a03c78bcd","sr=
c/target/generated.rs":"af067e1c291e895ddb591f92534eed0c48977cdb2b58f823942=
3e07c6de31cd3","src/target/llvm.rs":"e1db4a7fb8b905ee9853781f2fcc64a9d3b481=
54e4c8b6cb12f5373c5935da6e","src/target/parser.rs":"4f2129a24273d62bf8ab339=
098e7f758e4e42b0df369dd2b0eb1b20726be91f8","src/tempfile.rs":"ebafb5b0e5d08=
b0706916ed911d4245240e60c3e2d0c9a1630c520842988a2b3","src/tool.rs":"2e65500=
62e021f2b394388172bbb01e86fe6a94d2395bcb3c85a9e86690da1a9","src/utilities.r=
s":"52b30b24a1c31cdefb105309ee5220cfc9fca76eaf4e6d6509c3e19f431448fe","src/=
windows/com.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd18b795873c7304b3=
f2a5e3","src/windows/find_tools.rs":"0ff410bd71f08ee88e99609c15be5f1bc16ad7=
bd07a83918d13a70c8465642e2","src/windows/mod.rs":"34cfa201cfbcac7ccaa3ea529=
5d3e4200439af3cc5c6433baf81502596040a89","src/windows/registry.rs":"c521b72=
c825e8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/windows/set=
up_config.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996db=
bec8","src/windows/vs_instances.rs":"946527cf8fd32c3472f6a2884dcdec29076310=
1097334c7478f9c24c3950db6b","src/windows/winapi.rs":"250d51c1826d1a2329e988=
9dd9f058cfce253dbf2a678b076147c6cdb5db046c","src/windows/windows_sys.rs":"e=
2714c8307bfa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e34b8","src/windo=
ws/windows_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d094b7bec217264ba2=
e6e2c49d1ccee"},"package":"1aeb932158bd710538c73702db6945cb68a8fb08c519e6e1=
2706b94263b36db8"}
+\ No newline at end of file
++{"$comment":"This file only protects against accidental modifications. It=
 is not a security mechanism and does not protect against malicious changes=
.","files":{".cargo_vcs_info.json":"d6e26674a9d7de87dab83262a14f2377988a1e0=
87e4b514f3983f8dd141ea813","CHANGELOG.md":"fb0a3bcb34301d2578bef86feabe9305=
7068cb1906a7f10b584f58ff6123e8c6","Cargo.lock":"b661254fadca74408d53742755b=
371f7ae29e501e851aeae13bcd14a51883321","Cargo.toml":"50debe1b2fc050e8b305bd=
d514509d98cdbc59e96e5f10888df4b6fca19d3a75","Cargo.toml.orig":"0aff9dc74ddb=
e3bfe89ad9698212a6a18d6124b9593780aad25e277d28e9a71f","LICENSE-APACHE":"a60=
eea817514531668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-MIT=
":"378f5840b258e2779c39418f3f2d7b2ba96f1c7917dd6be0713f88305dbda397","READM=
E.md":"f1ddbede208a5b78333a25dac0a7598e678e9b601a7d99a791069bddaf180dfe","c=
lippy.toml":"aa7850db4350883c8f373bd0d6b4d19bf3b75f13c1c238e24368c109cb52fb=
1d","src/command_helpers.rs":"010873ba1ab0ea4b7e3b5eac72aed5f50e535d42cb94d=
a943d2aa3d74904aa0f","src/detect_compiler_family.c":"97ca4b021495611e828bec=
ea6187add37414186a16dfedd26c2947cbce6e8b2f","src/lib.rs":"221ba9475100303b5=
c694b2a02e5353452ee08a29e4e4d4d67ea8fcbd87605df","src/parallel/async_execut=
or.rs":"4ce24435fff6b6555b43fee042c16bd65d4150d0346567f246b9190d85b45983","=
src/parallel/job_token.rs":"018a01cb00182270bbcb68e31e7a7c5c621a95f086e4c68=
cfa2bf557ac24e5f2","src/parallel/mod.rs":"bd9c1334d17d138c281961c690b8d8118=
a2d6295a7d6cd7296826255436fa063","src/parallel/stderr.rs":"74384d41198740a6=
fce0877f144262db09fb091225fa8fbfa771314bb11487c6","src/target.rs":"7313240d=
b078ad85c1209a42a5fa96c3692b5d6e5093c7f366a1b99677247109","src/target/apple=
.rs":"6afbecac9f66aa72db55694413532f80b2753f28466a6213d1aa901a03c78bcd","sr=
c/target/generated.rs":"af067e1c291e895ddb591f92534eed0c48977cdb2b58f823942=
3e07c6de31cd3","src/target/llvm.rs":"e1db4a7fb8b905ee9853781f2fcc64a9d3b481=
54e4c8b6cb12f5373c5935da6e","src/target/parser.rs":"4f2129a24273d62bf8ab339=
098e7f758e4e42b0df369dd2b0eb1b20726be91f8","src/tempfile.rs":"ebafb5b0e5d08=
b0706916ed911d4245240e60c3e2d0c9a1630c520842988a2b3","src/tool.rs":"2e65500=
62e021f2b394388172bbb01e86fe6a94d2395bcb3c85a9e86690da1a9","src/utilities.r=
s":"52b30b24a1c31cdefb105309ee5220cfc9fca76eaf4e6d6509c3e19f431448fe","src/=
windows/com.rs":"a2800ddb81215fff2bf618336f5c4ff8e8bdb746dd18b795873c7304b3=
f2a5e3","src/windows/find_tools.rs":"0ff410bd71f08ee88e99609c15be5f1bc16ad7=
bd07a83918d13a70c8465642e2","src/windows/mod.rs":"34cfa201cfbcac7ccaa3ea529=
5d3e4200439af3cc5c6433baf81502596040a89","src/windows/registry.rs":"c521b72=
c825e8095843e73482ffa810ed066ad8bb9f86e6db0c5c143c171aba1","src/windows/set=
up_config.rs":"754439cbab492afd44c9755abcbec1a41c9b2c358131cee2df13c0e996db=
bec8","src/windows/vs_instances.rs":"946527cf8fd32c3472f6a2884dcdec29076310=
1097334c7478f9c24c3950db6b","src/windows/winapi.rs":"250d51c1826d1a2329e988=
9dd9f058cfce253dbf2a678b076147c6cdb5db046c","src/windows/windows_sys.rs":"e=
2714c8307bfa083b9745eb0e46cadd7f98d7b88abf45a7637172019324e34b8","src/windo=
ws/windows_targets.rs":"5b4648ebc22b028caca9f4b4bf8881fe2d094b7bec217264ba2=
e6e2c49d1ccee"},"package":"1aeb932158bd710538c73702db6945cb68a8fb08c519e6e1=
2706b94263b36db8"}
+\ No newline at end of file
+diff --git a/vendor/cc-1.2.0/src/command_helpers.rs b/vendor/cc-1.2.0/src/=
command_helpers.rs
+index adedab2..c911306 100644
+--- a/vendor/cc-1.2.0/src/command_helpers.rs
++++ b/vendor/cc-1.2.0/src/command_helpers.rs
+@@ -315,13 +315,25 @@ pub(crate) fn objects_from_files(files: &[Arc<Path>]=
, dst: &Path) -> Result<Vec<
+=20
+         // Make the dirname relative (if possible) to avoid full system p=
aths influencing the sha
+         // and making the output system-dependent
++        // compiler-builtins generates sources into OUT_DIR and reads the=
 compiler-rt
++        // intrinsics from RUST_COMPILER_RT_ROOT, so try those before the=
 manifest dir
+         //
+         // NOTE: Here we allow using std::env::var (instead of Build::get=
env) because
+         // CARGO_* variables always trigger a rebuild when changed
+         #[allow(clippy::disallowed_methods)]
+-        let dirname =3D if let Some(root) =3D std::env::var_os("CARGO_MAN=
IFEST_DIR") {
+-            let root =3D root.to_string_lossy();
+-            Cow::Borrowed(dirname.strip_prefix(&*root).unwrap_or(&dirname=
))
++        let strip_root =3D |var: &str| {
++            std::env::var_os(var).and_then(|root| {
++                dirname
++                    .strip_prefix(&*root.to_string_lossy())
++                    .map(str::to_owned)
++            })
++        };
++        let dirname =3D if let Some(rel) =3D strip_root("OUT_DIR") {
++            Cow::Owned(rel)
++        } else if let Some(rel) =3D strip_root("RUST_COMPILER_RT_ROOT") {
++            Cow::Owned(rel)
++        } else if let Some(rel) =3D strip_root("CARGO_MANIFEST_DIR") {
++            Cow::Owned(rel)
+         } else {
+             dirname
+         };
+--=20
+2.43.0
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index 24382ef..99ae2d9 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -3,6 +3,7 @@ RUST_VERSION ?=3D "${@d.getVar('PV').split('-')[0]}"
 SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.=
tar.xz;name=3Drust \
             file://0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux=
-g.patch;patchdir=3D${RUSTSRC} \
             file://rust-oe-selftest.patch;patchdir=3D${RUSTSRC} \
+            file://cc-hash-object-names-relative-to-source-roots.patch;pat=
chdir=3D${RUSTSRC} \
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-ru=
st.patch;patchdir=3D${RUSTSRC} \
             file://0002-Fix-rust-build-failure-with-unstable-options.patch=
;patchdir=3D${RUSTSRC} \
             file://0003-bootstrap-skip-StdarchVerify-when-remote-testing.p=
atch;patchdir=3D${RUSTSRC} \
--=20
2.56.1

