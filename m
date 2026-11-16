Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6304.1794870777221809418
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:12:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WXoKThPQ;
 spf=pass (domain: konsulko.com, ip: 209.85.217.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7cc013095d4so1216838137.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870776; x=1795475576; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QBSmrYrywSHp19+BqnT6iYz46kJFX8dY1XDU3ZZI2Fs=;
        b=WXoKThPQrpq+cGqLje8LTO5xZkbwPJNWa2YTQjY7FEZn8O4bIjS4NIl855L1zvmM0y
         5jffD3TlKPFi07ejcynv+gjZOoDkHJTMj2+wEg71bAjZCSYYgH05W+zNZ25cdTmIX2pw
         +HbL21byJV39GmEnKsVyo2MVWERpIPQYiIi8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870776; x=1795475576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QBSmrYrywSHp19+BqnT6iYz46kJFX8dY1XDU3ZZI2Fs=;
        b=iErmFyn5FMVF2rBj5g5Ao9OHonXFy/T6IGQU1SzOjZHW4r7e1itgtQ/tgW71LC+TLK
         24s48MNPbTii3y/EQdzJ6JMG62pIDSAWkfZHgH2qkXIbUAedU1BaMzOtY2mpI45knwy7
         VPZA3DF+TrZG0rtSXDHhMTsKJ4+mKAcgYrbuBsG5i7WOH9Zs+X+lB/haz1HuCxDM7nh9
         6ZVCiDkqb9QF+9stkogkR5ZuFCh8HWGNKJ+z2SuhAWkZ3+wdRYEj52hsml/4/p35OvHC
         kEVm2oeITr+FSjS8HdVe/zJskRVYYH0yda9J1ZNndWOg0raK6DEX/slAkxXy+3oAxhHu
         ddtA==
X-Gm-Message-State: APuU4Z9daBhYTVbh17V8hNVEJntWr/CLhU/VQUHBeHpr0D2t6myRciFz
	FGpJb2qK+14RXMDrgqTDN2cUsJwuq2pD/iRb275+IBpANYImDWvJVmzrOsbYN/pw97LNxoBKkrW
	QkfPofuI=
X-Gm-Gg: AYBFou0G7VGV/j3UfBqMnuGS7kNSLFoJccJC1S289z6ZjRuTau3Hh0aIPtD1qB2Cb9F
	uaK5xH2CKaqHf9UdrZBwiF1Q4US3baK1aNwZkf0n2TyCGH/akTC0/c5OVpZce44HhpiR9WOtiAe
	dc7o0JujjDUydoPPNYpmVjKjpfZAmwfSxqMjziTiZZ3ZAwwmUlqm+bjrKsQHylC/JRIKjdS96g/
	TLge5DRrwyRwaP5mnrzT9bd/Ha9lgGBHBgHM7Lnf6Si4jYzXhW3QP7O9HPeeiy4Q+gPowzgmd53
	FZIl4Ca/cYqW02/KQM/DJfsL7j2Bd6ZKtboM+tp96mXKiakokHDGPkfKAEKYphTi1PH/bvdac0e
	zf1feDShshLrDqxq7JxxuVZZarQW0FTQU5f7fxFmxnlpuGi1YK2rg8cnZs0ZsW8sSwRGbzuc6hw
	+G79pxJKZ4o22RK3ReQiP3Zsf8d2lt6PzCN9VFiqkvHRNHg06u40DZheBt9ZAKwb8on68XwPl/m
	oTXYpFFuRiPqmNMT3qJKFfu7ysnJRZKXYJ2Qcv32CQevVRFEt89zsMT6xWwSDCXtJ1uWrn3HKYN
	4374RBfuxD2BX31+eJSoLowkQkySBPJPllmcQGMpREWSYZrRiDOuceveDQxdJxkQ6NoMjgpjMRD
	Z0FGsbu215L2hZOSuYvxmjXQUg1ptwiFA9sVl/i64mROJeaLR/FwTXj/zpOyMWsGE1Q==
X-Received: by 2002:a05:6102:2922:b0:7a7:198a:c2c6 with SMTP id ada2fe7eead31-7d64db3c827mr3531185137.36.1794870775686;
        Mon, 16 Nov 2026 15:12:55 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.12.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:12:55 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 04/19] rust: drop the cc object-name reproducibility patch
Date: Mon, 16 Nov 2026 18:12:25 -0500
Message-ID: <21ba7fe16b7cf8ceaca95537a799a9b2932b80a3.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5443
Content-Type: text/plain; charset="utf-8"

From: Sunil Dora <sunilkumar.dora@windriver.com>

This patch trims the source directory at the string "rustc" before cc
hashes it into the object file names. After the shared source rework the
build no longer runs under rustc-*-src, so the sources that
compiler-builtins generates into OUT_DIR are not trimmed and the build
path ends up in their names.

Replaced by cc-hash-object-names-relative-to-source-roots.patch.

[YOCTO #16376]

Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit cc8168e229561bf0bbd4226bed13e76f9ebbb5d3)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...epro-issue-fix-with-cc-crate-hashmap.patch | 67 -------------------
 recipes-devtools/rust/rust-source.inc         |  1 -
 2 files changed, 68 deletions(-)
 delete mode 100644 recipes-devtools/rust/files/repro-issue-fix-with-cc-cra=
te-hashmap.patch

diff --git a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hash=
map.patch b/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashm=
ap.patch
deleted file mode 100644
index efb379a..0000000
--- a/recipes-devtools/rust/files/repro-issue-fix-with-cc-crate-hashmap.pat=
ch
+++ /dev/null
@@ -1,67 +0,0 @@
-rust: reproducibility issue fix with v1.84
-
-A few crates are using the updated version of the 'cc' crate and this is c=
ausing the generated object file names containing a unique hashmap id.
-By the following changes same hash values will be genarted even for diffre=
nt build paths.
-
-Below are the links for detailed bug description & discusssion with upstre=
am rust.
-https://github.com/rust-lang/cc-rs/pull/1277
-
-Upstream-Status: Submitted [https://github.com/rust-lang/cc-rs/pull/1277]
-Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
-Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
-diff --git a/vendor/cc-1.2.0/src/command_helpers.rs b/vendor/cc-1.2.0/src/=
command_helpers.rs
-index fe919a5239..2b1f442019 100644
---- a/vendor/cc-1.2.0/src/command_helpers.rs
-+++ b/vendor/cc-1.2.0/src/command_helpers.rs
-@@ -289,6 +289,7 @@
- /// and store them in the output Object.
- pub(crate) fn objects_from_files(files: &[Arc<Path>], dst: &Path) -> Resu=
lt<Vec<Object>, Error> {
-     let mut objects =3D Vec::with_capacity(files.len());
-+    let target_substring =3D ["rustc"];
-     for file in files {
-         let basename =3D file
-             .file_name()
-@@ -309,6 +310,26 @@
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
-+
-         // Hash the dirname. This should prevent conflicts if we have mul=
tiple
-         // object files with the same filename in different subfolders.
-         let mut hasher =3D hash_map::DefaultHasher::new();
-@@ -326,7 +347,7 @@
-             dirname
-         };
-
--        hasher.write(dirname.as_bytes());
-+        hasher.write(filtered_dirname.as_bytes());
-         let obj =3D dst
-             .join(format!("{:016x}-{}", hasher.finish(), basename))
-             .with_extension("o");
-diff --git a/vendor/cc-1.2.0/.cargo-checksum.json b/vendor/cc-1.2.0/.cargo=
-checksum.json
-index b070eeb322..ba768ff86f 100644
---- a/vendor/cc-1.2.0/.cargo-checksum.json
-+++ b/vendor/cc-1.2.0/.cargo-checksum.json
-@@ -1 +1 @@
--{"$comment":"This file only protects against accidental modifications. It=
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
-\ No newline at end of file
-+{"$comment":"This file only protects against accidental modifications. It=
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
1d","src/command_helpers.rs":"174101852b2633a2478cef20d063fb9c2f1b092eac479=
13a6e708c85663b8404","src/detect_compiler_family.c":"97ca4b021495611e828bec=
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
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index 019e258..28c6d0b 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -3,7 +3,6 @@ RUST_VERSION ?=3D "${@d.getVar('PV').split('-')[0]}"
 SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.=
tar.xz;name=3Drust \
             file://0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux=
-g.patch;patchdir=3D${RUSTSRC} \
             file://rust-oe-selftest.patch;patchdir=3D${RUSTSRC} \
-            file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=3D=
${RUSTSRC} \
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-ru=
st.patch;patchdir=3D${RUSTSRC} \
             file://0002-Fix-rust-build-failure-with-unstable-options.patch=
;patchdir=3D${RUSTSRC} \
             file://0003-bootstrap-skip-StdarchVerify-when-remote-testing.p=
atch;patchdir=3D${RUSTSRC} \
--=20
2.56.0

