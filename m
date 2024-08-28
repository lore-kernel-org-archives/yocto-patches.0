Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BFAC7112B
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:16 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.5864.1724875815902242622
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Qy+P6+an;
 spf=pass (domain: konsulko.com, ip: 209.85.166.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8278b0ba494so221738939f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875815; x=1725480615; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTo+URs/iC/AobCyeB47YtyEboojE8dAgpZKiZT/lHY=;
        b=Qy+P6+ankV/oWU4n7JhOEZeHhXkAsI28KjpxPa7eu4i7p6p6Zpla1AHlE0jIv37xhS
         AOXrHYlDdjxgsktQtgZ9UVV4HqfHia0+Q3PGhoiPrKJ4BR78OOxI2kMEuE1H2xAxIh6I
         58hhzoh/wIn23Vs9ak6MQEczx7FMEQe+qk6Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875815; x=1725480615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTo+URs/iC/AobCyeB47YtyEboojE8dAgpZKiZT/lHY=;
        b=ODIMvvEI0hHYEvctPRDkyh6MKxCdGFCXZwn1iNK6D5Me+4pYRjsFyjywcT+VKwTwz9
         5H7PqbJn33YLQ/4YkwPetfWrln5LgiHqvyR4k8DedEWRcMdbOKY3YSfpquDWmr7+IBPn
         H8nq+S9neXUjMX43mLxKSylCkC3Y7TQ/Ncx831WkCM3Aq/CR0NH9ibR0wPoCyCU2MFJR
         MK69jT3dIBqzOEhThZHo2CQpL3jTw5SYcj4ha8ITeuclVu/5SLUYlPT472cvfm4+M2BH
         87w71m3HdcOhWiQmTFKxkDNNsJ0GU54HhFwyGmdZCU6OJ5klFVqwk4+cOZBuxG7VctNW
         Na3w==
X-Gm-Message-State: AOJu0Yz5KE7wOWkr1/TOzmaAl4WO2fMytZXk5KB+KEivNFpQtGWVUkyg
	AIhFhT5g+qs5Q5y3P13S6QV3qMxBliSs1/0Hpz832mjQuScXpO/mOchNajnqoMLuBlbwWBMn7D9
	O
X-Google-Smtp-Source: AGHT+IH2OUX5qL/1uIeWoEvyfSWVQ6ap1ZiEr0ygYAtTUFUukeICmVbr7nKnvlUcPjivJMVggZcPmQ==
X-Received: by 2002:a05:6602:276a:b0:822:431a:6454 with SMTP id ca18e2360f4ac-82a1102bba2mr84034639f.8.1724875812983;
        Wed, 28 Aug 2024 13:10:12 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:12 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 28/33] rust: Upgrade 1.76.0->1.77.0
Date: Wed, 28 Aug 2024 16:09:14 -0400
Message-ID: <079454368a69eb73eefa4719d457047af5408cd7.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/597

From: Yash Shinde <Yash.Shinde@windriver.com>

    * Drop backported patch 0001-Handle-vendored-sources-when-remapping-pat=
hs.patch
    as it's merged with rust v1.77.0.

     https://blog.rust-lang.org/2024/03/21/Rust-1.77.0.html

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 8b6b224fc116150c0af658473eecd05b742de7b1)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |  2 +-
 .../rust/{cargo_1.76.0.bb =3D> cargo_1.77.0.bb} |  0
 ...endored-sources-when-remapping-paths.patch | 46 -------------
 .../rust/files/hardcodepaths.patch            | 49 +++++--------
 .../rust/files/rv32-rustix-libc-backend.patch |  5 +-
 .../rust/files/zlib-off64_t.patch             | 12 ++--
 ...ibstd-rs_1.76.0.bb =3D> libstd-rs_1.77.0.bb} |  0
 ....76.0.bb =3D> rust-cross-canadian_1.77.0.bb} |  0
 ...ust-llvm_1.76.0.bb =3D> rust-llvm_1.77.0.bb} |  0
 recipes-devtools/rust/rust-snapshot.inc       | 69 +++++++++++--------
 recipes-devtools/rust/rust-source.inc         |  3 +-
 .../rust/{rust_1.76.0.bb =3D> rust_1.77.0.bb}   |  0
 12 files changed, 68 insertions(+), 118 deletions(-)
 rename recipes-devtools/rust/{cargo_1.76.0.bb =3D> cargo_1.77.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/0001-Handle-vendored-source=
s-when-remapping-paths.patch
 rename recipes-devtools/rust/{libstd-rs_1.76.0.bb =3D> libstd-rs_1.77.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.76.0.bb =3D> rust-cros=
s-canadian_1.77.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.76.0.bb =3D> rust-llvm_1.77.0.bb=
} (100%)
 rename recipes-devtools/rust/{rust_1.76.0.bb =3D> rust_1.77.0.bb} (100%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 5dd727a..fee6ba1 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -13,7 +13,7 @@ LAYERSERIES_COMPAT_lts-rust-mixin =3D "kirkstone"
=20
 LAYERDEPENDS_lts-rust-mixin =3D "core"
=20
-RUSTVERSION ?=3D "1.76%"
+RUSTVERSION ?=3D "1.77%"
=20
 # This is not ideal, but it seems better to mask out the older oe-core
 # recipes completely since they will not work with this layer on top,
diff --git a/recipes-devtools/rust/cargo_1.76.0.bb b/recipes-devtools/rust/=
cargo_1.77.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.76.0.bb
rename to recipes-devtools/rust/cargo_1.77.0.bb
diff --git a/recipes-devtools/rust/files/0001-Handle-vendored-sources-when-=
remapping-paths.patch b/recipes-devtools/rust/files/0001-Handle-vendored-so=
urces-when-remapping-paths.patch
deleted file mode 100644
index a46ee14..0000000
--- a/recipes-devtools/rust/files/0001-Handle-vendored-sources-when-remappi=
ng-paths.patch
+++ /dev/null
@@ -1,46 +0,0 @@
-From 5e37ea7cb9d99d91f2c5ac6edf19ff777f95bb88 Mon Sep 17 00:00:00 2001
-From: Arlo Siemsen <arsiem@microsoft.com>
-Date: Thu, 4 Jan 2024 11:40:56 -0600
-Subject: [PATCH] Handle vendored sources when remapping paths
-
-Upstream-Status: Submitted [https://github.com/rust-lang/rust/pull/119582]
-Signed-off-by: Alex Kiernan <alex.kiernan@gmail.com>
----
- src/bootstrap/src/core/builder.rs | 19 ++++++++++++-------
- 1 file changed, 12 insertions(+), 7 deletions(-)
-
-diff --git a/src/bootstrap/src/core/builder.rs b/src/bootstrap/src/core/bu=
ilder.rs
-index cd276674dee6..48fdb2c7f7b7 100644
---- a/src/bootstrap/src/core/builder.rs
-+++ b/src/bootstrap/src/core/builder.rs
-@@ -1789,15 +1789,20 @@ pub fn cargo(
-         }
-=20
-         if self.config.rust_remap_debuginfo {
--            // FIXME: handle vendored sources
--            let registry_src =3D t!(home::cargo_home()).join("registry").=
join("src");
-             let mut env_var =3D OsString::new();
--            for entry in t!(std::fs::read_dir(registry_src)) {
--                if !env_var.is_empty() {
--                    env_var.push("\t");
--                }
--                env_var.push(t!(entry).path());
-+            if self.config.vendor {
-+                let vendor =3D self.build.src.join("vendor");
-+                env_var.push(vendor);
-                 env_var.push("=3D/rust/deps");
-+            } else {
-+                let registry_src =3D t!(home::cargo_home()).join("registr=
y").join("src");
-+                for entry in t!(std::fs::read_dir(registry_src)) {
-+                    if !env_var.is_empty() {
-+                        env_var.push("\t");
-+                    }
-+                    env_var.push(t!(entry).path());
-+                    env_var.push("=3D/rust/deps");
-+                }
-             }
-             cargo.env("RUSTC_CARGO_REGISTRY_SRC_TO_REMAP", env_var);
-         }
---=20
-2.39.0
-
diff --git a/recipes-devtools/rust/files/hardcodepaths.patch b/recipes-devt=
ools/rust/files/hardcodepaths.patch
index a043095..6966542 100644
--- a/recipes-devtools/rust/files/hardcodepaths.patch
+++ b/recipes-devtools/rust/files/hardcodepaths.patch
@@ -10,13 +10,20 @@ diff --git a/compiler/rustc_codegen_llvm/src/context.rs=
 b/compiler/rustc_codegen
 index b4b2ab1e1f8a..8bb3e3f0557c 100644
 --- a/compiler/rustc_codegen_llvm/src/context.rs
 +++ b/compiler/rustc_codegen_llvm/src/context.rs
-@@ -158,46 +158,6 @@ pub unsafe fn create_module<'ll>(
+@@ -34,7 +34,6 @@
+ use smallvec::SmallVec;
+
+ use libc::c_uint;
+-use std::borrow::Borrow;
+ use std::cell::{Cell, RefCell};
+ use std::ffi::CStr;
+ use std::str;
+@@ -155,25 +154,6 @@
          }
      }
=20=20
 -    // Ensure the data-layout values hardcoded remain the defaults.
--    if sess.target.is_builtin {
--        // tm is disposed by its drop impl
+-    {
 -        let tm =3D crate::back::write::create_informational_target_machin=
e(tcx.sess);
 -        llvm::LLVMRustSetDataLayoutFromTargetMachine(llmod, &tm);
 -
@@ -24,36 +31,16 @@ index b4b2ab1e1f8a..8bb3e3f0557c 100644
 -        let llvm_data_layout =3D str::from_utf8(CStr::from_ptr(llvm_data_=
layout).to_bytes())
 -            .expect("got a non-UTF8 data-layout from LLVM");
 -
--        // Unfortunately LLVM target specs change over time, and right no=
w we
--        // don't have proper support to work with any more than one
--        // `data_layout` than the one that is in the rust-lang/rust repo.=
 If
--        // this compiler is configured against a custom LLVM, we may have=
 a
--        // differing data layout, even though we should update our own to=
 use
--        // that one.
--        //
--        // As an interim hack, if CFG_LLVM_ROOT is not an empty string th=
en we
--        // disable this check entirely as we may be configured with somet=
hing
--        // that has a different target layout.
--        //
--        // Unsure if this will actually cause breakage when rustc is conf=
igured
--        // as such.
--        //
--        // FIXME(#34960)
--        let cfg_llvm_root =3D option_env!("CFG_LLVM_ROOT").unwrap_or("");
--        let custom_llvm_used =3D !cfg_llvm_root.trim().is_empty();
--
--        if !custom_llvm_used && target_data_layout !=3D llvm_data_layout {
--            bug!(
--                "data-layout for target `{rustc_target}`, `{rustc_layout}=
`, \
--                  differs from LLVM target's `{llvm_target}` default layo=
ut, `{llvm_layout}`",
--                rustc_target =3D sess.opts.target_triple,
--                rustc_layout =3D target_data_layout,
--                llvm_target =3D sess.target.llvm_target,
--                llvm_layout =3D llvm_data_layout
--            );
+-        if target_data_layout !=3D llvm_data_layout {
+-            tcx.dcx().emit_err(crate::errors::MismatchedDataLayout {
+-                rustc_target: sess.opts.target_triple.to_string().as_str(=
),
+-                rustc_layout: target_data_layout.as_str(),
+-                llvm_target: sess.target.llvm_target.borrow(),
+-                llvm_layout: llvm_data_layout,
+-            });
 -        }
 -    }
 -
      let data_layout =3D SmallCStr::new(&target_data_layout);
      llvm::LLVMSetDataLayout(llmod, data_layout.as_ptr());
-=20
+
diff --git a/recipes-devtools/rust/files/rv32-rustix-libc-backend.patch b/r=
ecipes-devtools/rust/files/rv32-rustix-libc-backend.patch
index 0efab56..e6e8fac 100644
--- a/recipes-devtools/rust/files/rv32-rustix-libc-backend.patch
+++ b/recipes-devtools/rust/files/rv32-rustix-libc-backend.patch
@@ -16,9 +16,10 @@ Signed-off-by: Khem Raj <raj.khem@gmail.com>
 --- a/vendor/rustix/.cargo-checksum.json
 +++ b/vendor/rustix/.cargo-checksum.json
 @@ -1 +1 @@
--{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231d2=
fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b0532d=
35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"1b9147c312c90f34e2cd30=
9fe687860dff2bb490e3424c938c788bd4b75e8bce","LICENSE-APACHE":"a60eea8175145=
31668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2.0_WI=
TH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39ef1f9=
4f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a715d9d2=
b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12ba79e=
4cebb6983a7b6491949750aecc4f2178","README.md":"fce34da91981eafa61d376be05f2=
f8d9619b2c0eb4795913f57a4eb37be9009e","SECURITY.md":"4d75afb09dd28eb5982e3a=
1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e67273aa0=
a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"5f93559819=
ca7fe233f01579d51ff5b58cb6e96ef9e7817a3358a9b410d5bbf6","src/backend/libc/c=
.rs":"985d441769f1f5d8ed36bce0517504e9a72aaed2ae8bc53235c45382dbe4d198","sr=
c/backend/libc/conv.rs":"b66d080db3a4c2756fe722462b543982bf88e5bc8071b9dc98=
d28ec2aee3dbfc","src/backend/libc/event/epoll.rs":"151fea9151a5a8f17d4d1390=
53b38cffae30701a69ad507f71e666c3dfbca869","src/backend/libc/event/mod.rs":"=
7f8547c599b8263eb791890bbe4a0b22fe2676d007ffdcc3e07b2e48d1c994db","src/back=
end/libc/event/poll_fd.rs":"280303b4be61600fa2e25fe59f10dc4e7010942286f6fb7=
cca93954ab63e01d9","src/backend/libc/event/syscalls.rs":"f91bbe7d222987c89a=
2647817f6819dd536cbc4a685dfb794f403543c32df777","src/backend/libc/event/typ=
es.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f13","=
src/backend/libc/event/windows_syscalls.rs":"ebfac665c6676c4b803134ab8806be=
8aa2e96bdbc7799a19c544cd9069b35787","src/backend/libc/fs/dir.rs":"9dff590f8=
1fa0bbbc37444c58ebf8fd4f5693bae4453ad6bfafd751c74b091b8","src/backend/libc/=
fs/inotify.rs":"a027a718db8bf6ff9a778c2cfa706850b466240b0a2296d72b9834c0096=
968e8","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f329ad3=
5bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803011b5=
7da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc/fs/s=
yscalls.rs":"56a9e8367d3b41b04f1795a12cf5099d5812ab654901168d30545c8e1cba1d=
ce","src/backend/libc/fs/types.rs":"ca25c8271e1fd2ff6c28082884ca112fd5e0523=
b2aa3cd289cd9a399c962a172","src/backend/libc/io/errno.rs":"d33978855c2e0e97=
d5e1f7a04ab10894f9f2c3e329e949f259a757f89942074e","src/backend/libc/io/mod.=
rs":"746647bd864e4ec7717925b6d176cebdb392b7d015070244cc48d92780351dd6","src=
/backend/libc/io/syscalls.rs":"cbd9e9db566597de0a709247c8ba3bd1e6ce266a128d=
639273353c706f0592b7","src/backend/libc/io/types.rs":"2efd39bb3df19a9db5496=
217284f3d2235ddb354fac81dd71861109a56bede0b","src/backend/libc/io/windows_s=
yscalls.rs":"fab3fa099aa89cea56a6edc651dd37750e581534f4f45b04a7e425f130b084=
68","src/backend/libc/io_uring/mod.rs":"2c6478857a0751625edabd61acb841819bf=
ba1093b1faeded15693c805d84952","src/backend/libc/io_uring/syscalls.rs":"5af=
8146d5971c833e6fd657f652c618b31f854e1b0811864fba9b658cb633e19","src/backend=
/libc/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/mm/syscalls.rs":"c04c61ad3d7f3b24d13f89144d7fa0a=
05658cea4763207f9250db4f9362de2fe","src/backend/libc/mm/types.rs":"55478e17=
3b7d82e2c85934fc0dda79c29f46a305228df78f1e90c68ac9d3cfec","src/backend/libc=
/mod.rs":"778083f85aaca00aa5c8ec36b541e0e8a3e693660a6acf4722b4508f015c278c"=
,"src/backend/libc/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287=
b25a5bfe489fa1d07f7cfd7","src/backend/libc/mount/syscalls.rs":"1bc87501a078=
616d0190d2e85de55f3f968b8cb79d49bd9eb839a350eed26089","src/backend/libc/mou=
nt/types.rs":"7e663362dc31c70d966ea9aaf035d3b1cb2f5928546b608243e16e4fcaf50=
857","src/backend/libc/net/addr.rs":"9bdc2febb20785bc26a820eaba52cb546c67c7=
9cb547f08105087cd0f79d5861","src/backend/libc/net/ext.rs":"0dd64877abe1ba86=
b47a2ab34340e3f6cc7b53b22d0bb5e237daf6a82edd46b0","src/backend/libc/net/mod=
.rs":"5f0bd80a6575aba4a714443ca99af76ad15b053f1f8029aa1d9c7fa10e6d9242","sr=
c/backend/libc/net/msghdr.rs":"64825203c09cb60ac4e869cd27a44697f1efe53455c4=
1684279d50d8f0a96701","src/backend/libc/net/read_sockaddr.rs":"b1a72b7bd56c=
d152ed0731f571e4d9411b2974f860fc045319dc74b5b077e569","src/backend/libc/net=
/send_recv.rs":"1450ca958431a5bf3a85cdeef88b387f30d5c1215de2c56d164ccda38f2=
1b36c","src/backend/libc/net/sockopt.rs":"178a6622bab25bf1813d6c17151f48d82=
0e238db8cbd05be3aae563902d6c53e","src/backend/libc/net/syscalls.rs":"654b82=
0d4d1240be1c6a1c56a2cd00d4743bcdf92527054d1000fa1b7ce4594f","src/backend/li=
bc/net/write_sockaddr.rs":"6f06f6cf6089fbc43f93f4f3830468735c92277595769867=
cb6c89e1fe1c299a","src/backend/libc/param/auxv.rs":"fc9476c85482b1d44190289=
224ccf40c96fbf3a2fe3d8554ddb42acb2e97a8ae","src/backend/libc/param/mod.rs":=
"5234b8f1bcb886cca6ea003d411d75eaeebe58deedd80e3441354bf46ed85d4d","src/bac=
kend/libc/pid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded156=
93c805d84952","src/backend/libc/pid/syscalls.rs":"49ea679b96c0741d048e82964=
038f9a931bc3cf3a0b59c7db3df89629b9c49e6","src/backend/libc/pipe/mod.rs":"8a=
a966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backen=
d/libc/pipe/syscalls.rs":"8affde100f6a9dfc762b79d1e48be5c1039be414f8ef7d5a6=
acaba882a68d259","src/backend/libc/pipe/types.rs":"9f5d0e7b83afe932ea2c4cc8=
7a52e21ad180e1986bf8342d83b8c4a977ca3bdb","src/backend/libc/prctl/mod.rs":"=
2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/back=
end/libc/prctl/syscalls.rs":"8a2684f444a7555098dce2b92270d81cefdae902716c6e=
5d59bd7b0657e8a29d","src/backend/libc/process/cpu_set.rs":"b3d36b01b53b0b6c=
61a20ed8a69d48eccdd90cc17f82f2926ef1e844f002d0b7","src/backend/libc/process=
/mod.rs":"806e26da8d1e7afae502987fcd650f4d348da147b8a2e74447affdca153e2e97"=
,"src/backend/libc/process/syscalls.rs":"9d7028bc55c5dd1fa742c13ea0904fbf95=
094232e7ba2871fa758a93838666de","src/backend/libc/process/types.rs":"fb2caf=
34b17079aa72c04aed0f9a31d534ea8e8b73a80c758b748bf5e38df52b","src/backend/li=
bc/process/wait.rs":"0cc556aed976b4bbb3965f74fd76b8216c755fce25043b7b21ce54=
afa07c9773","src/backend/libc/pty/mod.rs":"2c6478857a0751625edabd61acb84181=
9bfba1093b1faeded15693c805d84952","src/backend/libc/pty/syscalls.rs":"699a4=
c325fc590b8b5dabfe5a9ff386809be14dd24bf35aa6ef581b2bd75457b","src/backend/l=
ibc/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/rand/syscalls.rs":"78c7201e6bcb75e9cab9486d18788=
61319f865de2b2c46437be68690bd17bf13","src/backend/libc/rand/types.rs":"4eb0=
b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a705ec605b773f63f880","src/backend/=
libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/shm/syscalls.rs":"60d797d4e85e08e6330e6b8d800943=
56ce377e5484952f88ae2a6e49231c268c","src/backend/libc/shm/types.rs":"2206ea=
c8ee74951b995e1e80f10bf235cc6b04e0a099f4adefce546378838233","src/backend/li=
bc/system/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c05718e85bdc88a36dc805efdfc=
e45d3909","src/backend/libc/system/syscalls.rs":"abe1093f3495668d8576ae5507=
3c74976cffb04d2e1bc20583d7ec12ac848b06","src/backend/libc/system/types.rs":=
"6871e16aee14fe2ae03cea798c3e509ffe44778a9c0e5608fd73e2e015876d7e","src/bac=
kend/libc/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faede=
d15693c805d84952","src/backend/libc/termios/syscalls.rs":"f377dfbf501fbc3cd=
bc9e190dd650c8141c00c1593b8c62901ecf346a0c1a7c5","src/backend/libc/thread/f=
utex.rs":"b666828653b12634bbd7fd709acf69641b648ec40962a1d4f904c5db14d2eff5"=
,"src/backend/libc/thread/mod.rs":"fa710053974d7f16a6c49242ee6c10a3b9e11434=
52b9daeaed8837302a679fff","src/backend/libc/thread/syscalls.rs":"c8e84ad232=
ec1317be989529c24e204c51bb4e1e0212de2c1937b00bc92e5483","src/backend/libc/t=
ime/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c05718e85bdc88a36dc805efdfce45d39=
09","src/backend/libc/time/syscalls.rs":"f82e0725c5af8a52e61ee83aad2c77694f=
2f7a72ac1e6eb284109a70ac6edc38","src/backend/libc/time/types.rs":"d0307994f=
fddd3f21f702d9ae4400750aecccfaf4a01268161dc4fd72de5c373","src/backend/libc/=
ugid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84=
952","src/backend/libc/ugid/syscalls.rs":"8edf91b8790add23902c9f5418da6b072=
3a371677f29f490e0c8af852f0f1a0c","src/backend/libc/winsock_c.rs":"3bf3884fd=
250eca806ffdf96da68e29c133a697810b78b333ea449e523e58562","src/backend/linux=
_raw/arch/aarch64.rs":"2a255c9135bc8a321c180f52b88eb2b158bc9170cd222149caea=
e63c24587d44","src/backend/linux_raw/arch/arm.rs":"165bccb5883d0136e55d4209=
1183765f83d86e9d37a7cb2cec9ae8af32774db6","src/backend/linux_raw/arch/mips.=
rs":"24af364aa93fd4b9917639d473336490a143f0d1723b09f388e72d534160ee51","src=
/backend/linux_raw/arch/mips32r6.rs":"e436a2ade34f2f7c58b8924462b07a2499dfc=
951e1e1318d51759444fb8b658e","src/backend/linux_raw/arch/mips64.rs":"897da9=
ddc877963ad59464d7f81dc59df8a7e91251e6adea14cfd946e2740a1c","src/backend/li=
nux_raw/arch/mips64r6.rs":"3c08aea13c1139fb0dfbe74ca3d0147f007c3aa2eda641af=
b82c46f6aa4f6cd1","src/backend/linux_raw/arch/mod.rs":"37eaeea601d39be00d17=
0856a31a8ec6a27b0d3ac22ab3ee642ab0e45dee237d","src/backend/linux_raw/arch/p=
owerpc64.rs":"dfb001f8636a5e46d728900b0804fe6c374e5e18a6f0e76d7d62e0c07da74=
477","src/backend/linux_raw/arch/riscv64.rs":"41d33242d941030f46077dc2b1bc4=
c7913fe7630d693a5a7eef966bcf38f9d8b","src/backend/linux_raw/arch/thumb.rs":=
"2fd979ab421248c0a4c592bc0cefee63edc26528f469b71b63eaed35356e42e8","src/bac=
kend/linux_raw/arch/x86.rs":"fc72f595ec75768aee248d405f4958a7ba1db65ac9fe54=
b277cd003eab33316e","src/backend/linux_raw/arch/x86_64.rs":"e929036a1f3cf93=
ba538f4523b241605cc7b5e61f84ffe6d9d5cdbcb6f73e543","src/backend/linux_raw/c=
.rs":"5669c25110b62dbb8a79bbceb167732693b2ff7cc82dd78cc68c1c7f3aeec6af","sr=
c/backend/linux_raw/conv.rs":"017ef1ef5044c99acf124db022c134b946c68b4c0150e=
61c7615947e9ce088f0","src/backend/linux_raw/event/epoll.rs":"81add72e957733=
b4233d3e712c0fb05f233f97d8cd96e1b886b27b9d0a8b90a0","src/backend/linux_raw/=
event/mod.rs":"72e46b04637e2d1d2a6b97af616144995399e489d1fe916faf835d72fc8c=
64cd","src/backend/linux_raw/event/poll_fd.rs":"a5773464e9e30227b4046f029a2=
7d3daf2c7bd0045e54565cf1a8ac2a0d61e81","src/backend/linux_raw/event/syscall=
s.rs":"44460b0045bb9d9f48b0baeb009a6b150a2902f9b733e8f6c5a36726b8db2d41","s=
rc/backend/linux_raw/event/types.rs":"0551b18f982e233a0a06d8a9c3dbb29de0c20=
4dcd64dd6f7e88b6c96fa9a9be8","src/backend/linux_raw/fs/dir.rs":"8fe8f139e97=
20208ece606af3bd8097e87e54ea9ce155f228530c8f6acd03992","src/backend/linux_r=
aw/fs/inotify.rs":"9fc5edea36e347041a39e583cb473dd84af40c63fff3dfbb85a1a97d=
2833d8e5","src/backend/linux_raw/fs/makedev.rs":"c6b4505c4bcbbc2460e80f3097=
eb15e2c8ef38d6c6e7abd78e39c53c372139e2","src/backend/linux_raw/fs/mod.rs":"=
3d3a42bbf4d086f806d7d9f6e4b0a49a873dc27f4f03ffca0921f5536acc24e5","src/back=
end/linux_raw/fs/syscalls.rs":"53011d928f6ff77cf505d31744cc41d7d460127c1592=
6006a2859c9e1ae0ffb3","src/backend/linux_raw/fs/types.rs":"0127ab3059d75a89=
6cdda83b3b2005923636273c62664e342f97bb3b3867f34b","src/backend/linux_raw/io=
/errno.rs":"4b010bdc37ab8d8f551529540af011c728d2e9fac1fb897fc9fd0c844dad7fe=
e","src/backend/linux_raw/io/mod.rs":"7ae2324427892cca6f5ab53858d847b165f79=
0a72ec25f3d99fb15f0506c9f27","src/backend/linux_raw/io/syscalls.rs":"831ce4=
24f0032e6891d46503e972313fd7a46f15cb2fbb1f87e40fb05a018e9a","src/backend/li=
nux_raw/io/types.rs":"d0df5a62248e1ba19af0f89f86da7ba2312d97065c2814ddf6b08=
a4a0db23bad","src/backend/linux_raw/io_uring/mod.rs":"2c6478857a0751625edab=
d61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/io_urin=
g/syscalls.rs":"0f7c9cb7ccddf5687e4b9e5b23558871a452a29ac6095a0184a06c47b9b=
18eb6","src/backend/linux_raw/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53=
539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mm/syscalls.rs":"4e=
469542c88ea15853d5022e7e1d4b8fc291265ca314766d60d9395dad927e19","src/backen=
d/linux_raw/mm/types.rs":"b5bf9bf775d3771e79aa234788fa3d1f25009f3f51cd59c72=
efc4f5e2c7bd790","src/backend/linux_raw/mod.rs":"86f7c3b1d57e57a9e5b5dcc8ee=
24ded5054a917069bd9824f47952b10bca2221","src/backend/linux_raw/mount/mod.rs=
":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/b=
ackend/linux_raw/mount/syscalls.rs":"3947261b5d46b9737f02dc5352c3a3a35c63c4=
61fd75bcd8ae6619dfc0bfb54d","src/backend/linux_raw/mount/types.rs":"eacf5fa=
1e8142f8e10023aeca9fd44f28dd0ca4255069378a129b88ccdba7fbc","src/backend/lin=
ux_raw/net/addr.rs":"fbb6c071a8ebc2c557c7013d36d4b540c1ff6ed63103d0a8abcacd=
8977fbf5c8","src/backend/linux_raw/net/mod.rs":"904b2ccd4228ebcda25db0223b9=
2fb03e4042bcc7b0a202f19410a8a5ff517a5","src/backend/linux_raw/net/msghdr.rs=
":"a88e8395dd5a25c103dc2172d4e7013e5104a6d70091ad78efd286ebc8284acf","src/b=
ackend/linux_raw/net/read_sockaddr.rs":"4ab5d470f03f19a928327603e1d55de8b9e=
21cbe4bfc6ed65d856803092b1c90","src/backend/linux_raw/net/send_recv.rs":"6d=
5d2aec61a3c1b4a5fef1a8a487dc8e163da8988d1237541ed008baa01128cc","src/backen=
d/linux_raw/net/sockopt.rs":"2ea8625ecd68a799c14ed48dec2f3e01f085222b6cc36f=
4916b20143e08ae575","src/backend/linux_raw/net/syscalls.rs":"b231754af1c94f=
61d206839b45f51516e0210761bbbcc1ef68c1fe6fc8a1bbbb","src/backend/linux_raw/=
net/write_sockaddr.rs":"a9374256cb47b3f4d5fec308986a109ce51a521abab31590df1=
f66c04c07d437","src/backend/linux_raw/param/auxv.rs":"ee59d2a618a8c63151681=
4b53655830eeb7ae33cda847d1be382419ba3cdb559","src/backend/linux_raw/param/i=
nit.rs":"6b1297dd9d02d9cf0be19a263d1e0cd084a5fbe723aa3bce2eee5f55e850bde0",=
"src/backend/linux_raw/param/libc_auxv.rs":"d7d2c46feba6d383d17d9d25293ab40=
e39dfefb23533844ee7abaa917923e2b5","src/backend/linux_raw/param/mod.rs":"2e=
6a1a1c00351b9c88bd615aa923f71d76208df5626dd9bea03067f28f81dc31","src/backen=
d/linux_raw/pid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded1=
5693c805d84952","src/backend/linux_raw/pid/syscalls.rs":"eef6aa01830ddd510b=
83f507da2002c03e58318b73744be2c06ebbe33c4f194f","src/backend/linux_raw/pipe=
/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7"=
,"src/backend/linux_raw/pipe/syscalls.rs":"366c730fc3e991bddb9f5a15b8c3917a=
8e6ace6d1d5a9113b2749e476faf6f83","src/backend/linux_raw/pipe/types.rs":"26=
3f6c5621968ed2d33671cca5bdb59eef2882668d9543c2ddbbf6346308e0ff","src/backen=
d/linux_raw/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faede=
d15693c805d84952","src/backend/linux_raw/prctl/syscalls.rs":"a18b224307e0d2=
7bda9b7b85c75cd6c7ddfe39f5ce52efb7bb0bf0585b757343","src/backend/linux_raw/=
process/cpu_set.rs":"dfdcbdf35aff6a3e08e7d38193bf18c12ca8aa64eb0dc417667be8=
2dcc0f7c55","src/backend/linux_raw/process/mod.rs":"fb393c70a9c63ef9a6bf1fb=
5a2dc94f07d6b0b6987cc5231c15c607015dafd68","src/backend/linux_raw/process/s=
yscalls.rs":"2699fcffdbc3e5f7ef598bed5a1ea33fcd161f8e9b2f57b320c31da290b4fe=
e1","src/backend/linux_raw/process/types.rs":"6811ba822bc12a1a6336649151b4a=
db1f5d3365684a31c07f01953ea9547743d","src/backend/linux_raw/process/wait.rs=
":"921aee4b0048746087f52615a98edc2aa0fb4b53d6df44be4533098df55d1b05","src/b=
ackend/linux_raw/pty/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1fa=
eded15693c805d84952","src/backend/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae=
87b1ca58d82efc58007b9dddaae78460d615f48da19d1cd0f89","src/backend/linux_raw=
/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7=
cfd7","src/backend/linux_raw/rand/syscalls.rs":"a84f70251672e92f253838bf05e=
989434f67373233e88d21d8835cbb792b1fe3","src/backend/linux_raw/rand/types.rs=
":"a21dbb1ab31eed6b59a57520be5a3c603c36d18ea74e67f7527f40835ba209a3","src/b=
ackend/linux_raw/reg.rs":"def5f88730bd625b2298c86559b5a378fce4bf6ce22520474=
0ba087e034abce6","src/backend/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92=
942f06ea0b68464040dcac33c6f0f7ee392c6269993347","src/backend/linux_raw/runt=
ime/syscalls.rs":"5ad72d57b1258be6f6265be971cf3cd4c5746902f4167069774dcce41=
f33cefb","src/backend/linux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cd=
ba6e8c91414113a04a739160929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":=
"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/bac=
kend/linux_raw/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d937945=
40087b3182cbdf3cb9c8db","src/backend/linux_raw/shm/types.rs":"b831b474aba7e=
b97167c9289f5257776a72b39134b44e67a0ecfcef2394dcd47","src/backend/linux_raw=
/system/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07=
f7cfd7","src/backend/linux_raw/system/syscalls.rs":"2af6c2672a6528b404b52f5=
01d9803a63e9f47886d3b5d2d2dc5a71cefa7327a","src/backend/linux_raw/system/ty=
pes.rs":"1ceab8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e",=
"src/backend/linux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bf=
ba1093b1faeded15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":=
"25a0341ded4657a3a5389250c24b3310642785d386bc51f31696f98f4f1e770f","src/bac=
kend/linux_raw/thread/futex.rs":"0aa0f9f5be6a79de81e82c9f11f1bf8831f682a4b2=
f6cb29669e1591636f084e","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90b92=
34e79900b27ebbe8837e3a7a36aec532912e3e253edce5225067","src/backend/linux_ra=
w/thread/syscalls.rs":"0e3dca63be7322e1e9c58456b28eb8548abb9f08b4436b87b139=
e891c01c446d","src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7452bb1=
cc2d28b5f0aaa840a2856fe363acce624e1beefc","src/backend/linux_raw/time/sysca=
lls.rs":"7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de9404845312fc",=
"src/backend/linux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a81d3305e1=
8e726e54edc5a5474641f3cdc278","src/backend/linux_raw/ugid/mod.rs":"2c647885=
7a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linu=
x_raw/ugid/syscalls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db84f444d32513=
09b7a0480b54f7","src/backend/linux_raw/vdso.rs":"056314f72c71d4b041739337ca=
2098afb7fe070f844327f462c293f43481b75b","src/backend/linux_raw/vdso_wrapper=
s.rs":"0e01221cbc6f0a489e89b0cf2fa376c3826ead8491ee8510476b75e90784f39a","s=
rc/bitcast.rs":"e21c87c292c781b27256c6f5dcf9fd52dd69ed6e21016cbd67ac31a8219=
ebf8e","src/check_types.rs":"e52f710e1cfc12ca13a495f2b43c227b293ff295e1ce3a=
b332935b28a7579872","src/clockid.rs":"7237847231f9d2bd070606262a25de6351de6=
66f95065972967a5f2aae6fef0e","src/cstr.rs":"41af2a4429fe6c67a8883f8a8f63d66=
c90df566abda74fd2b03bcef7b9f24218","src/event/eventfd.rs":"81cbd08f7bdf40a6=
ce1ca692b63da1dc8ba925282990668d9d68f1203e839fa1","src/event/kqueue.rs":"22=
2842df22e66f41d93dacd3cba933810d9313d5ca9959fddabedda9c4312bf2","src/event/=
mod.rs":"7f82a5734d4ba2791054d154273cab48d1cce5ca47d680d44a1b71b96eee932c",=
"src/event/pause.rs":"cac3317286478565298a40788c1ce13c1b71543078a6f09655419=
de325022f6f","src/event/poll.rs":"0ee583dbd457a573a82a06c04a2a24bd2c76e751d=
27a435507d55338e2871327","src/event/port.rs":"4e51ff150e5d17cbd44aa64a38b99=
c15e26eaaf2e350768b5dcacdfde4fa5212","src/ffi.rs":"c2b8b38c02d72749aceb715c=
496726caba1f1fa989ad3856d0103a2fafed89ed","src/fs/abs.rs":"99ecd74dd3447d16=
f142651c74397daca53aa5a21e7daf632937b0860ed63a84","src/fs/at.rs":"e2e017e48=
139101c882df6697f9e4842aed3dbd372c448249c61fd9486163183","src/fs/constants.=
rs":"23923e0fce3221bdac371fe2d05028f30a87dba4f9b4a573b69dc2d6d39320b2","src=
/fs/copy_file_range.rs":"d3b644374390d482b2ff749a2459458872b57d0dcf96703687=
39b7833509a7c2","src/fs/cwd.rs":"9f429a79ace6e17455634da09216ee0ad3d067a454=
1518b3193ae6a8d9ff1e26","src/fs/dir.rs":"347a52f4ca9ac6321c52e802e97ec90d1b=
4c62ec955c8996fc17f8f5aed69966","src/fs/fadvise.rs":"1220e2cf5cf58fc7cc950d=
48738050a052c504f745ca67130daa6410e248230a","src/fs/fcntl.rs":"1d1ee1e0bc96=
2779e1cc1b8b76f39c820746240557daa9e14b47b1799120dc39","src/fs/fcntl_apple.r=
s":"e2f23f038083621bcdecc98d02ce1023508afaecdb2ed0fba5c8b70f955301e5","src/=
fs/fcopyfile.rs":"ce565f61e1fbf2e31086077c2f1d01b6bb3b048915edda87fe9a4a4f5=
e8ff7e4","src/fs/fd.rs":"fe53f211e91352d522ac4f3b553a9366506458e2158295a93c=
5e746618f7a5fe","src/fs/getpath.rs":"28f6970fc1bbc37bb35c84724b59eac436ea74=
07a4522e18c2bdacb1fdd2edd9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f97189cea4e=
5982a0d35b192afeec6340a6c6222e0cb","src/fs/ioctl.rs":"e798eb41bbc201c375bc2=
95ad2928c2467b45b4fbbff3c82236dccbc0d6391a5","src/fs/makedev.rs":"85520b484=
cb7c15ab71ea1c368578ea3b7e484d82f8510db92b6ce9f7ca341ae","src/fs/memfd_crea=
te.rs":"a8bf1dced54c7592e71da896021338d5092c1693d12cc42e79bac435fab2792b","=
src/fs/mod.rs":"2192ea7f6f81a18d892d3526df00c43d83669f1a1734957ba94cf826998=
0792e","src/fs/mount.rs":"8f6ea2b997dd83c50c90291b9ada3ed77a9ce1ad701c9b0d5=
33b5113b317be5b","src/fs/openat2.rs":"4a95c15dab533a41201b5fa25c8a212956b75=
71d58cad696bdaf45af8aef96db","src/fs/raw_dir.rs":"18ad797876d6230c38d4cacbe=
d081c4028e03ace477d0520d9b226b40de942f0","src/fs/seek_from.rs":"a9efa0feb9a=
c789cf47667e91efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","src/fs/sendfile.rs"=
:"e3b2058741cf4b1698f34d84bb37130cf2b72806d522a16fe541e832cde136cb","src/fs=
/statx.rs":"f925be3d9a179a903549b3ac18038d004f4f2021e46dad4aa2757907aebefec=
a","src/fs/sync.rs":"a3b23543834281f347b0f873bd38154d31d404871188ac08f2b20b=
9196234cfd","src/fs/xattr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6ca3a4720=
0532ca6e72d44cbe8334","src/io/close.rs":"0aa3cd05a8fed8e5244f97b8b6c2e7f65e=
d93a4e5435c6329852bb3da7514440","src/io/dup.rs":"bbebf4633120e21c7c49ecb935=
76cffa7e908f8089deb260f8d97426b469a0d4","src/io/errno.rs":"58a4d20ba0924e4d=
514e3c876fbe08982f1623187642ae14780815e65989c8c8","src/io/fcntl.rs":"41c1b3=
70be55aaa68144dcc8a67b2d53504a5e6d8ee1bffabac2cc64c66a4043","src/io/ioctl.r=
s":"3dffbda413fd380f1580e2e75c531a5f4a0487417ea1c235c23fe46b70e46bd9","src/=
io/is_read_write.rs":"1bfb9ee5d58e0b29b44af12fe2668c7bccc841358698dcde47f15=
19ff9bb73b4","src/io/mod.rs":"75f1d0646be1d4c7c08b5887d8119b0103be8c25c43cc=
d4e0e97015508c0bb8f","src/io/read_write.rs":"77b8058769dc0bf5a88d73acd7ce70=
af1a89c549b00b790e281dc20364bcb6af","src/io_uring.rs":"4e641c9aaeba14890e4a=
354ad8b1fda8fe617923b4d3d685da22721d66a14bdf","src/ioctl/bsd.rs":"32ba3399a=
0fe3f68bb458baafc2a21af9bff655865c7ea70990b7e98a26d3907","src/ioctl/linux.r=
s":"96df90bbc926783f387e8fe1656841d4c7a857fd4e9f41f95492f7dcece33074","src/=
ioctl/mod.rs":"8a5ce2e81feb7c2748df6b69ecf14b07ed1459d961f1eaa8f429face912f=
908c","src/ioctl/patterns.rs":"bd6e309c8b548dfe04aaffe805972582fb56a0b717c4=
5b45447630bdf9b88433","src/lib.rs":"2d9ddb2ab94fd1649932b4e8cb490026078c0b4=
3b513489f3067d279747f4a35","src/maybe_polyfill/no_std/io/mod.rs":"77889bb5c=
5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/maybe_polyfil=
l/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9cff3a19049d=
88c8c80","src/maybe_polyfill/no_std/net/ip_addr.rs":"046327ee244f758f2bc31d=
3be305d8cd0dfd8342aac1add8259e999b4b46c4a7","src/maybe_polyfill/no_std/net/=
mod.rs":"486555be5c56cf3e049e65a1ea73aa60839c6f6ca667833e88ee4f360f9606dd",=
"src/maybe_polyfill/no_std/net/socket_addr.rs":"bfeb32d32c176cde76323abcffe=
bfc47e9898fb8d7ce3668c602dc8451086a2d","src/maybe_polyfill/no_std/os/fd/mod=
.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e80771d507c47","sr=
c/maybe_polyfill/no_std/os/fd/owned.rs":"ab86ffa2693a04f3085770faf395f95e53=
03001711be8b19c44a47a0ac574091","src/maybe_polyfill/no_std/os/fd/raw.rs":"f=
3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999e7c6943","src/maybe=
_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2fcc7c825310606b889cc8=
dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/windows/io/mod.rs":"5bbcc=
05c83fee5026dd744a994e0458469466d5be39081baa62df07753b92fd2","src/maybe_pol=
yfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49328b5637cb3bafb96437=
f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/os/windows/io/socket.=
rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5d2c64808308d65","src=
/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231a4e778b5f985b9ae712e=
ce5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/std/mod.rs":"7c16c86c=
c73e226e65ead598e4018238b22000a345040b706bf1e1b3eba115fc","src/mm/madvise.r=
s":"69481cd3354dbffe6cd93b234448e59de6d0fe6440bcf8b12f951f37745bc1dc","src/=
mm/mmap.rs":"3b0abe64a6a606ea41b06acfc1079bcde1542c17475951e5ed900b86c3e598=
8d","src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761211a494ca6f89b2367a2=
d2157e340e","src/mm/msync.rs":"a9092be024ecbfa9c14edb935404513498b0da2ac6c9=
9fc31fe4e58196a95f02","src/mm/userfaultfd.rs":"8073443bd181ff0b3ba4d0b1ae67=
370b4864035a0c8b4898cd709dc47c518ae7","src/mount/fsopen.rs":"160e384e9175fd=
98669cda1cf3590bb195c2ba7e1c724e9ea06e692595e58ba1","src/mount/mod.rs":"5f0=
c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d12a7136cb19","src/mount/m=
ount_unmount.rs":"8ad11675e5d762d33fbefbed06a6a9f9e52a9b689bd06662446152614=
321ab77","src/mount/types.rs":"601ae3e10b7dc496fed7f3b40a80e81c6edd7bf13189=
d7be45c3212d4c684c39","src/net/mod.rs":"a6bc55f9e086caf46a7c00783498d73a328=
a66f2a991f1ec65d5f13931377b0f","src/net/send_recv/mod.rs":"7b77a70c0ad2601b=
5da30e8b202e34c6bfc9e10df4ce2b1a35b111522ae123a3","src/net/send_recv/msg.rs=
":"5e889662c076db5aa5041a75302aec04eb471c41570ffeb22b1a6c0760a3716a","src/n=
et/socket.rs":"1296706d964d110be7cd46b61a0a06dabf382a2377907ba41badfe94807c=
b50f","src/net/socket_addr_any.rs":"a9af81e967a91b45e51aec4f46a068fade7035c=
5d19dfaf05bfdcd3b3c32e9bf","src/net/socketpair.rs":"56f4885c31d2664cd16e18a=
9a88792a4912fedd953cec36dba67e8581fd57921","src/net/sockopt.rs":"4f00ff76d3=
cd3fd2e915f51eba59827fb60885d6b0c6d37b32ca4306cb8fe836","src/net/types.rs":=
"d1186106a0a7dab578a9d7f36021ba4c77a50585ad155bd531ebb8553dff3366","src/net=
/wsa.rs":"6e546b42f50a851fc833c57cda76cfb347203ed4b0dea574a3d325bf5a2ebf80"=
,"src/param/auxv.rs":"8602af47a39bb340d319807bdecdb9be8b467101a9ed96061277b=
90234801913","src/param/init.rs":"a31c0e5cea61a1a999767fe74f87c0d59eeb6bce6=
6578b842fe0e0c32be27a55","src/param/mod.rs":"25b10acd5b1da8faa6f5204e6b0379=
b38bfab667916e886cca64bea01a42dec2","src/path/arg.rs":"d87117157ec21f61a5e5=
0b2779b4284fd13dd7db11b20a6bc9e475d0e4a25357","src/path/dec_int.rs":"8ff8e1=
4442c46f8e7a9b80d73973619b4271549b9defd538479bf8c2d93aa72e","src/path/mod.r=
s":"6b1b949c94bcc47e0f08a3f8e8db5b61ff497d0dfd3e0655f51c01d3e4b7dfd6","src/=
pid.rs":"f1c486000c5b1311b2d720cee88f089c17ef9a171709673dd06e6f35f4ff98a3",=
"src/pipe.rs":"9f269090dd0588dc8d3feba4f4a78b61891bce91d3c9b64cdbad9251b06a=
9e11","src/prctl.rs":"19aa584895874ea48b9bbe1bf695b81257b0281df64dfdd91e1b4=
bfa298661b7","src/process/chdir.rs":"911216459aa429fe9f125f1357d6900b43b000=
7835b85c719875d00f79a74664","src/process/chroot.rs":"2b5f6124eb19f26ad27051=
74f7ad50cdc0a5d15abd59ffcf55421228d82130b4","src/process/exit.rs":"48de66e5=
504a00cb375d8f415ce63b6225a3f5204268d40726a7d0fbba43f587","src/process/id.r=
s":"e4733f9e8e4b5f50e98ef7a23802e126f1f14ece8b3d7ae7446c6a66affc6bc1","src/=
process/ioctl.rs":"23ad0285671e8d7ca71a63c50655dbf732ccea8af11d754a0558e023=
6db37e76","src/process/kill.rs":"96d5ce432c19cf2b600d5248c681c117abf53ae94b=
bfca7e75ac533a40e3968e","src/process/membarrier.rs":"1c4c39b359d1d0e9bbe163=
52eedfca9278d9ef298ade8ec00e998617bbcbfed8","src/process/mod.rs":"4fda62909=
afcb081281bd9a8eaf770dc3dfc2111013231ae23b0a1e101582f48","src/process/pidfd=
.rs":"39de2dc7919eeeb53a5980622616140327671cd7e36bcf597aee1749df3a5b5b","sr=
c/process/pidfd_getfd.rs":"1faace75bdbcda57a296806dcfa5487811f8d11dad9e6199=
c98df72feae66724","src/process/prctl.rs":"0130d05362a17a9282f3391189095e1f4=
f51fb56d7a5205906a0011842df4576","src/process/priority.rs":"f135482e71ea8aa=
0daf92b9f238051178a4c904070fa8409622f94155df3c544","src/process/procctl.rs"=
:"430ec397782772d5a028903c2813d3e11f7e577af144b9effd9c42629ac8d3d2","src/pr=
ocess/rlimit.rs":"10b79de3ced0e64059a94c879742d46a35a6176c776d8eed75031d5e6=
340283d","src/process/sched.rs":"ea2acde244159ff3b07038a99f365c07661e7f57c6=
e998af110ce937e9145d0b","src/process/sched_yield.rs":"6565faa3928b66ddc74a6=
5e893e15edfa4b9be4f7e5f5f68527501a7f6bc3350","src/process/umask.rs":"1a0f31=
a842303c978e3f05ec191e2b5e96104c09c6596473b42b1fac34898a50","src/process/wa=
it.rs":"f9c73dde2a66dfbe448501f039396dd26c5d678e4f8cb61c1f78014b7b49fcd3","=
src/procfs.rs":"194678c863ae682143fcefb47601ae3d0b269a48eb9f43cae7f9d7e13f6=
87920","src/pty.rs":"652c412e7280d0344b3f9bfe376c106a7f1b42b898b7af344e6e72=
da268e2bf0","src/rand/getrandom.rs":"1c8166a02a74f5593bb4673ef907524df04cbc=
1568020a5ab2ff7f4aa1283f8b","src/rand/mod.rs":"cab59332aadd9b679f5b22cbb222=
d48ee028af5eb9fd4a4d43922da659b895d7","src/runtime.rs":"39e5b1449bd94b7e89a=
78a1a6e2ea857bcb26e1f2a5e225c0951c7abc4e15d90","src/shm.rs":"b96fe8a05ee5d4=
536464a8843a776d43a938abaf22c772fc35b5373d95644a8d","src/signal.rs":"a294b4=
9d487dafaa42e534f8b1d93e87bec135087676b2ba2ef865cf2fccdaf2","src/static_ass=
ertions.rs":"504cf66f0d5b8e335be02f9ae8b0a355abc98c2c82eec0098bdf0988e662e2=
60","src/stdio.rs":"a5de2d7d9c3c5a901f88b6acf4754687c958a2f3a93c7945c2b8fcb=
948d468af","src/system.rs":"4d7d1eff18094ec85a8ead70a7ccbe8ef78fd7f5705b7df=
e3fa52541e9494887","src/termios/ioctl.rs":"a1ac967f7811a482f8bb53847c37c835=
9f518cd26da9df7b816ba678a0139623","src/termios/mod.rs":"b44b7caa60b6f458657=
ed58a0e0eca41bb4e6d6be4b0f042bbb8ab7056cebe4b","src/termios/tc.rs":"5a56f25=
2dcde4a841fae47a7a6f7890d81f61385c7b512143ece9389652004ae","src/termios/tty=
.rs":"35a5fc2d26501e0e6dde1a755eeccf7b4f3b4702c5bac30e0953220808ef7034","sr=
c/termios/types.rs":"38167a38fb83e84f2845f86b373ecaaa3ebf6c2f91dccd07c10539=
201d6f5070","src/thread/clock.rs":"f49eb7271eb3e6831d9b0c3a01bfddbe4bd69dee=
237bbaa059884de452b29e79","src/thread/futex.rs":"985f9a0dce1e2a4892ae7f26bd=
1bf119ceae3f9fa6b4707e166624fc1cee76d4","src/thread/id.rs":"ad72db4fea9fccb=
728310bbfd01ef8c00f6cc60fa2a750f6349646a134f7009b","src/thread/libcap.rs":"=
4c51b7df566d38dd0f85f81ef53279a745a39f0f4e1154791fd38438e2ca7db1","src/thre=
ad/mod.rs":"98634ece0b882f123ad887017692f2a4d94a23a1dec278ed660b3497cac5cce=
b","src/thread/prctl.rs":"ebc89b731eb8fd1a8f82a50dbba849061476a4537bba8702b=
29db657d5287ffa","src/thread/setns.rs":"ea9142b1f3a5b3f329683be185f960c50e5=
c1636149e91fbf59e88a897fc607d","src/time/clock.rs":"e59a29f1bed8c31c3d5b6fa=
d60f2d4fa6cab8dd8e86148bb3693a5e3a1ce735f","src/time/mod.rs":"43afee938c80d=
124d04d4ba190c03f4d21d1e3bfc154fff309211e4f6eabe940","src/time/timerfd.rs":=
"f17092b84553741aa2d2b44c6992b5d2c8c96cc2c2007fc9a2c6b2064485e53f","src/tim=
espec.rs":"32a4d930cbc0f6dbd23153290db920671cf4ce65a4a127e176f897c1cde42d7d=
","src/ugid.rs":"6616c6e35b7e43aee5b150f1efae7a50711e0947943c9a96833dbe214a=
d9e85f","src/utils.rs":"9ae76f8a41d6cc350cdd58c9084b5c3a5a708eeecd769783deb=
dbcbaef442182","src/weak.rs":"c7cf03bf2aeba494b1999ab32183fa8c603ab72e254c0=
e312a67f168877e410d"},"package":"9470c4bf8246c8daf25f9598dca807fb6510347b1e=
1cfa55749113850c79d88a"}
+-{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231d2=
fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b0532d=
35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"9dc4e968d6cfe719f1548d=
4ba7f6ccb74eea14beb7f175784b2e58bd29c38df1","LICENSE-APACHE":"a60eea8175145=
31668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2.0_WI=
TH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39ef1f9=
4f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a715d9d2=
b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12ba79e=
4cebb6983a7b6491949750aecc4f2178","README.md":"cec45686b62cb75ef2f0c851939b=
7ddcb64678c27c18c7bca18d6f5cde2446d3","SECURITY.md":"4d75afb09dd28eb5982e3a=
1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e67273aa0=
a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"5f93559819=
ca7fe233f01579d51ff5b58cb6e96ef9e7817a3358a9b410d5bbf6","src/backend/libc/c=
.rs":"985d441769f1f5d8ed36bce0517504e9a72aaed2ae8bc53235c45382dbe4d198","sr=
c/backend/libc/conv.rs":"b66d080db3a4c2756fe722462b543982bf88e5bc8071b9dc98=
d28ec2aee3dbfc","src/backend/libc/event/epoll.rs":"151fea9151a5a8f17d4d1390=
53b38cffae30701a69ad507f71e666c3dfbca869","src/backend/libc/event/mod.rs":"=
7f8547c599b8263eb791890bbe4a0b22fe2676d007ffdcc3e07b2e48d1c994db","src/back=
end/libc/event/poll_fd.rs":"280303b4be61600fa2e25fe59f10dc4e7010942286f6fb7=
cca93954ab63e01d9","src/backend/libc/event/syscalls.rs":"f91bbe7d222987c89a=
2647817f6819dd536cbc4a685dfb794f403543c32df777","src/backend/libc/event/typ=
es.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f13","=
src/backend/libc/event/windows_syscalls.rs":"ebfac665c6676c4b803134ab8806be=
8aa2e96bdbc7799a19c544cd9069b35787","src/backend/libc/fs/dir.rs":"9dff590f8=
1fa0bbbc37444c58ebf8fd4f5693bae4453ad6bfafd751c74b091b8","src/backend/libc/=
fs/inotify.rs":"a027a718db8bf6ff9a778c2cfa706850b466240b0a2296d72b9834c0096=
968e8","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f329ad3=
5bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803011b5=
7da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc/fs/s=
yscalls.rs":"f2d24c7b287a1e9a424331b60f5c599c7588ee4f150fb19bf3e04ba9d83d9d=
f1","src/backend/libc/fs/types.rs":"70995151d71b5ed10099e6b047cc491e1cc1d5f=
9964d5a863c5c35908f07df26","src/backend/libc/io/errno.rs":"50de984709793775=
59520ddc35b9777c761248b9083d93d86ff4f101f80c724d","src/backend/libc/io/mod.=
rs":"746647bd864e4ec7717925b6d176cebdb392b7d015070244cc48d92780351dd6","src=
/backend/libc/io/syscalls.rs":"d77032e4d7ec41e441e06181461ffc519d7c6e6dfc72=
0244a55399f0f870bb16","src/backend/libc/io/types.rs":"2efd39bb3df19a9db5496=
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
.rs":"5f0bd80a6575aba4a714443ca99af76ad15b053f1f8029aa1d9c7fa10e6d9242","sr=
c/backend/libc/net/msghdr.rs":"64825203c09cb60ac4e869cd27a44697f1efe53455c4=
1684279d50d8f0a96701","src/backend/libc/net/read_sockaddr.rs":"b1a72b7bd56c=
d152ed0731f571e4d9411b2974f860fc045319dc74b5b077e569","src/backend/libc/net=
/send_recv.rs":"1450ca958431a5bf3a85cdeef88b387f30d5c1215de2c56d164ccda38f2=
1b36c","src/backend/libc/net/sockopt.rs":"178a6622bab25bf1813d6c17151f48d82=
0e238db8cbd05be3aae563902d6c53e","src/backend/libc/net/syscalls.rs":"3d24b9=
ada485aacaa87a41d7ebe13fecddac7465bf1f04e52016da041b71bade","src/backend/li=
bc/net/write_sockaddr.rs":"6f06f6cf6089fbc43f93f4f3830468735c92277595769867=
cb6c89e1fe1c299a","src/backend/libc/param/auxv.rs":"fc9476c85482b1d44190289=
224ccf40c96fbf3a2fe3d8554ddb42acb2e97a8ae","src/backend/libc/param/mod.rs":=
"5234b8f1bcb886cca6ea003d411d75eaeebe58deedd80e3441354bf46ed85d4d","src/bac=
kend/libc/pid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded156=
93c805d84952","src/backend/libc/pid/syscalls.rs":"49ea679b96c0741d048e82964=
038f9a931bc3cf3a0b59c7db3df89629b9c49e6","src/backend/libc/pipe/mod.rs":"8a=
a966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backen=
d/libc/pipe/syscalls.rs":"8affde100f6a9dfc762b79d1e48be5c1039be414f8ef7d5a6=
acaba882a68d259","src/backend/libc/pipe/types.rs":"9826013bc5fa18acdcbf09c6=
50b96ce301a18ec009139ebaf79162669b1fc2c8","src/backend/libc/prctl/mod.rs":"=
2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/back=
end/libc/prctl/syscalls.rs":"8a2684f444a7555098dce2b92270d81cefdae902716c6e=
5d59bd7b0657e8a29d","src/backend/libc/process/cpu_set.rs":"b3d36b01b53b0b6c=
61a20ed8a69d48eccdd90cc17f82f2926ef1e844f002d0b7","src/backend/libc/process=
/mod.rs":"806e26da8d1e7afae502987fcd650f4d348da147b8a2e74447affdca153e2e97"=
,"src/backend/libc/process/syscalls.rs":"9d7028bc55c5dd1fa742c13ea0904fbf95=
094232e7ba2871fa758a93838666de","src/backend/libc/process/types.rs":"fb2caf=
34b17079aa72c04aed0f9a31d534ea8e8b73a80c758b748bf5e38df52b","src/backend/li=
bc/process/wait.rs":"0cc556aed976b4bbb3965f74fd76b8216c755fce25043b7b21ce54=
afa07c9773","src/backend/libc/pty/mod.rs":"2c6478857a0751625edabd61acb84181=
9bfba1093b1faeded15693c805d84952","src/backend/libc/pty/syscalls.rs":"566fc=
9a2cb2e38d7d7ac2405b22c0522369cae4a8f4fe18b55123ba94d3d5a95","src/backend/l=
ibc/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/rand/syscalls.rs":"35ea6b6e0f8a7fb064fd5cb33a3a8=
55cd161a6a00f93d76c861b2a2c66db85e7","src/backend/libc/rand/types.rs":"4eb0=
b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a705ec605b773f63f880","src/backend/=
libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/shm/syscalls.rs":"60d797d4e85e08e6330e6b8d800943=
56ce377e5484952f88ae2a6e49231c268c","src/backend/libc/shm/types.rs":"2206ea=
c8ee74951b995e1e80f10bf235cc6b04e0a099f4adefce546378838233","src/backend/li=
bc/system/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c05718e85bdc88a36dc805efdfc=
e45d3909","src/backend/libc/system/syscalls.rs":"abe1093f3495668d8576ae5507=
3c74976cffb04d2e1bc20583d7ec12ac848b06","src/backend/libc/system/types.rs":=
"6871e16aee14fe2ae03cea798c3e509ffe44778a9c0e5608fd73e2e015876d7e","src/bac=
kend/libc/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faede=
d15693c805d84952","src/backend/libc/termios/syscalls.rs":"f377dfbf501fbc3cd=
bc9e190dd650c8141c00c1593b8c62901ecf346a0c1a7c5","src/backend/libc/thread/f=
utex.rs":"b666828653b12634bbd7fd709acf69641b648ec40962a1d4f904c5db14d2eff5"=
,"src/backend/libc/thread/mod.rs":"fa710053974d7f16a6c49242ee6c10a3b9e11434=
52b9daeaed8837302a679fff","src/backend/libc/thread/syscalls.rs":"c8e84ad232=
ec1317be989529c24e204c51bb4e1e0212de2c1937b00bc92e5483","src/backend/libc/t=
ime/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c05718e85bdc88a36dc805efdfce45d39=
09","src/backend/libc/time/syscalls.rs":"f82e0725c5af8a52e61ee83aad2c77694f=
2f7a72ac1e6eb284109a70ac6edc38","src/backend/libc/time/types.rs":"d0307994f=
fddd3f21f702d9ae4400750aecccfaf4a01268161dc4fd72de5c373","src/backend/libc/=
ugid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84=
952","src/backend/libc/ugid/syscalls.rs":"8edf91b8790add23902c9f5418da6b072=
3a371677f29f490e0c8af852f0f1a0c","src/backend/libc/winsock_c.rs":"502da2ed3=
cd6ca99bb7ee08b0b30e25c212632885cec965f9816366c6b931ac6","src/backend/linux=
_raw/arch/aarch64.rs":"2a255c9135bc8a321c180f52b88eb2b158bc9170cd222149caea=
e63c24587d44","src/backend/linux_raw/arch/arm.rs":"165bccb5883d0136e55d4209=
1183765f83d86e9d37a7cb2cec9ae8af32774db6","src/backend/linux_raw/arch/mips.=
rs":"24af364aa93fd4b9917639d473336490a143f0d1723b09f388e72d534160ee51","src=
/backend/linux_raw/arch/mips32r6.rs":"e436a2ade34f2f7c58b8924462b07a2499dfc=
951e1e1318d51759444fb8b658e","src/backend/linux_raw/arch/mips64.rs":"897da9=
ddc877963ad59464d7f81dc59df8a7e91251e6adea14cfd946e2740a1c","src/backend/li=
nux_raw/arch/mips64r6.rs":"3c08aea13c1139fb0dfbe74ca3d0147f007c3aa2eda641af=
b82c46f6aa4f6cd1","src/backend/linux_raw/arch/mod.rs":"37eaeea601d39be00d17=
0856a31a8ec6a27b0d3ac22ab3ee642ab0e45dee237d","src/backend/linux_raw/arch/p=
owerpc64.rs":"dfb001f8636a5e46d728900b0804fe6c374e5e18a6f0e76d7d62e0c07da74=
477","src/backend/linux_raw/arch/riscv64.rs":"41d33242d941030f46077dc2b1bc4=
c7913fe7630d693a5a7eef966bcf38f9d8b","src/backend/linux_raw/arch/thumb.rs":=
"2fd979ab421248c0a4c592bc0cefee63edc26528f469b71b63eaed35356e42e8","src/bac=
kend/linux_raw/arch/x86.rs":"fc72f595ec75768aee248d405f4958a7ba1db65ac9fe54=
b277cd003eab33316e","src/backend/linux_raw/arch/x86_64.rs":"e929036a1f3cf93=
ba538f4523b241605cc7b5e61f84ffe6d9d5cdbcb6f73e543","src/backend/linux_raw/c=
.rs":"5669c25110b62dbb8a79bbceb167732693b2ff7cc82dd78cc68c1c7f3aeec6af","sr=
c/backend/linux_raw/conv.rs":"017ef1ef5044c99acf124db022c134b946c68b4c0150e=
61c7615947e9ce088f0","src/backend/linux_raw/event/epoll.rs":"a102c2d8d7d5d0=
7a5d846f30672153269d1762d1d846be1786b22fcf095e8721","src/backend/linux_raw/=
event/mod.rs":"72e46b04637e2d1d2a6b97af616144995399e489d1fe916faf835d72fc8c=
64cd","src/backend/linux_raw/event/poll_fd.rs":"a5773464e9e30227b4046f029a2=
7d3daf2c7bd0045e54565cf1a8ac2a0d61e81","src/backend/linux_raw/event/syscall=
s.rs":"44460b0045bb9d9f48b0baeb009a6b150a2902f9b733e8f6c5a36726b8db2d41","s=
rc/backend/linux_raw/event/types.rs":"0551b18f982e233a0a06d8a9c3dbb29de0c20=
4dcd64dd6f7e88b6c96fa9a9be8","src/backend/linux_raw/fs/dir.rs":"8fe8f139e97=
20208ece606af3bd8097e87e54ea9ce155f228530c8f6acd03992","src/backend/linux_r=
aw/fs/inotify.rs":"713ec3b85f281efca19bc4f495b7537e745fbf1d8c26592c80ceec6f=
d2ab59b5","src/backend/linux_raw/fs/makedev.rs":"c6b4505c4bcbbc2460e80f3097=
eb15e2c8ef38d6c6e7abd78e39c53c372139e2","src/backend/linux_raw/fs/mod.rs":"=
3d3a42bbf4d086f806d7d9f6e4b0a49a873dc27f4f03ffca0921f5536acc24e5","src/back=
end/linux_raw/fs/syscalls.rs":"799630cb4322a3a88558f2f2dd678fdf5bbbd7704098=
b27b2da51705ee050ab1","src/backend/linux_raw/fs/types.rs":"a2b1bb81b9b50e91=
27885b4facb4c26b42e9e7b1374ff38f203bc36b54c41091","src/backend/linux_raw/io=
/errno.rs":"6464c776312d478d9a7aae0e66f624ecbec5e56f1c33713a5f11f2ed5000ba9=
e","src/backend/linux_raw/io/mod.rs":"7ae2324427892cca6f5ab53858d847b165f79=
0a72ec25f3d99fb15f0506c9f27","src/backend/linux_raw/io/syscalls.rs":"568e16=
751191c14bb37f7883b17cb577dc97e09d615d17849c0e7e10e3898f1b","src/backend/li=
nux_raw/io/types.rs":"d0df5a62248e1ba19af0f89f86da7ba2312d97065c2814ddf6b08=
a4a0db23bad","src/backend/linux_raw/io_uring/mod.rs":"2c6478857a0751625edab=
d61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/io_urin=
g/syscalls.rs":"0f7c9cb7ccddf5687e4b9e5b23558871a452a29ac6095a0184a06c47b9b=
18eb6","src/backend/linux_raw/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53=
539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mm/syscalls.rs":"4e=
469542c88ea15853d5022e7e1d4b8fc291265ca314766d60d9395dad927e19","src/backen=
d/linux_raw/mm/types.rs":"b5bf9bf775d3771e79aa234788fa3d1f25009f3f51cd59c72=
efc4f5e2c7bd790","src/backend/linux_raw/mod.rs":"86f7c3b1d57e57a9e5b5dcc8ee=
24ded5054a917069bd9824f47952b10bca2221","src/backend/linux_raw/mount/mod.rs=
":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/b=
ackend/linux_raw/mount/syscalls.rs":"8442c82814961f69c488222faabb82c44d2e72=
27b10faff919cbbd197bb47484","src/backend/linux_raw/mount/types.rs":"bf3dff5=
aad1cec9d998496230469958c836b76643f0ad17b0ea29b957357bcca","src/backend/lin=
ux_raw/net/addr.rs":"920373911f43deff1a5e54b9d01a8712e6971734f7eba7932dc813=
b9a30771d6","src/backend/linux_raw/net/mod.rs":"904b2ccd4228ebcda25db0223b9=
2fb03e4042bcc7b0a202f19410a8a5ff517a5","src/backend/linux_raw/net/msghdr.rs=
":"a88e8395dd5a25c103dc2172d4e7013e5104a6d70091ad78efd286ebc8284acf","src/b=
ackend/linux_raw/net/read_sockaddr.rs":"3aac93a52053b0ffba7097b4738c3c78aaf=
0e35884a3451df0628a772b1907eb","src/backend/linux_raw/net/send_recv.rs":"6d=
5d2aec61a3c1b4a5fef1a8a487dc8e163da8988d1237541ed008baa01128cc","src/backen=
d/linux_raw/net/sockopt.rs":"2ea8625ecd68a799c14ed48dec2f3e01f085222b6cc36f=
4916b20143e08ae575","src/backend/linux_raw/net/syscalls.rs":"5347eefe5bd389=
2c9e3d6f91a04b9dd215180b1e148ed2ab7ff20bafbe1617ae","src/backend/linux_raw/=
net/write_sockaddr.rs":"a9374256cb47b3f4d5fec308986a109ce51a521abab31590df1=
f66c04c07d437","src/backend/linux_raw/param/auxv.rs":"ee59d2a618a8c63151681=
4b53655830eeb7ae33cda847d1be382419ba3cdb559","src/backend/linux_raw/param/i=
nit.rs":"6b1297dd9d02d9cf0be19a263d1e0cd084a5fbe723aa3bce2eee5f55e850bde0",=
"src/backend/linux_raw/param/libc_auxv.rs":"d7d2c46feba6d383d17d9d25293ab40=
e39dfefb23533844ee7abaa917923e2b5","src/backend/linux_raw/param/mod.rs":"2e=
6a1a1c00351b9c88bd615aa923f71d76208df5626dd9bea03067f28f81dc31","src/backen=
d/linux_raw/pid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded1=
5693c805d84952","src/backend/linux_raw/pid/syscalls.rs":"eef6aa01830ddd510b=
83f507da2002c03e58318b73744be2c06ebbe33c4f194f","src/backend/linux_raw/pipe=
/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7"=
,"src/backend/linux_raw/pipe/syscalls.rs":"366c730fc3e991bddb9f5a15b8c3917a=
8e6ace6d1d5a9113b2749e476faf6f83","src/backend/linux_raw/pipe/types.rs":"cf=
53bcdcde5d0ee15e0e3566ceaad39fda44e69ed6f94a99fadd9be9b8be09cf","src/backen=
d/linux_raw/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faede=
d15693c805d84952","src/backend/linux_raw/prctl/syscalls.rs":"a18b224307e0d2=
7bda9b7b85c75cd6c7ddfe39f5ce52efb7bb0bf0585b757343","src/backend/linux_raw/=
process/cpu_set.rs":"dfdcbdf35aff6a3e08e7d38193bf18c12ca8aa64eb0dc417667be8=
2dcc0f7c55","src/backend/linux_raw/process/mod.rs":"fb393c70a9c63ef9a6bf1fb=
5a2dc94f07d6b0b6987cc5231c15c607015dafd68","src/backend/linux_raw/process/s=
yscalls.rs":"be1427f2ab11ce35b2746b48351c5a0aff2b71ad2b6471a2876f88cb80c0b7=
f7","src/backend/linux_raw/process/types.rs":"6811ba822bc12a1a6336649151b4a=
db1f5d3365684a31c07f01953ea9547743d","src/backend/linux_raw/process/wait.rs=
":"921aee4b0048746087f52615a98edc2aa0fb4b53d6df44be4533098df55d1b05","src/b=
ackend/linux_raw/pty/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1fa=
eded15693c805d84952","src/backend/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae=
87b1ca58d82efc58007b9dddaae78460d615f48da19d1cd0f89","src/backend/linux_raw=
/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7=
cfd7","src/backend/linux_raw/rand/syscalls.rs":"317cdaf243623329ee345131054=
e86a06a0863a9e90c5dba73e1ac3475ba6305","src/backend/linux_raw/rand/types.rs=
":"a21dbb1ab31eed6b59a57520be5a3c603c36d18ea74e67f7527f40835ba209a3","src/b=
ackend/linux_raw/reg.rs":"def5f88730bd625b2298c86559b5a378fce4bf6ce22520474=
0ba087e034abce6","src/backend/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92=
942f06ea0b68464040dcac33c6f0f7ee392c6269993347","src/backend/linux_raw/runt=
ime/syscalls.rs":"dc7df0416919d1eef7e4919fc38836e2081903db286330d59b0119cc2=
92155df","src/backend/linux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cd=
ba6e8c91414113a04a739160929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":=
"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/bac=
kend/linux_raw/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d937945=
40087b3182cbdf3cb9c8db","src/backend/linux_raw/shm/types.rs":"b831b474aba7e=
b97167c9289f5257776a72b39134b44e67a0ecfcef2394dcd47","src/backend/linux_raw=
/system/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07=
f7cfd7","src/backend/linux_raw/system/syscalls.rs":"2af6c2672a6528b404b52f5=
01d9803a63e9f47886d3b5d2d2dc5a71cefa7327a","src/backend/linux_raw/system/ty=
pes.rs":"1ceab8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e",=
"src/backend/linux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bf=
ba1093b1faeded15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":=
"25a0341ded4657a3a5389250c24b3310642785d386bc51f31696f98f4f1e770f","src/bac=
kend/linux_raw/thread/futex.rs":"0aa0f9f5be6a79de81e82c9f11f1bf8831f682a4b2=
f6cb29669e1591636f084e","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90b92=
34e79900b27ebbe8837e3a7a36aec532912e3e253edce5225067","src/backend/linux_ra=
w/thread/syscalls.rs":"0e3dca63be7322e1e9c58456b28eb8548abb9f08b4436b87b139=
e891c01c446d","src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7452bb1=
cc2d28b5f0aaa840a2856fe363acce624e1beefc","src/backend/linux_raw/time/sysca=
lls.rs":"7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de9404845312fc",=
"src/backend/linux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a81d3305e1=
8e726e54edc5a5474641f3cdc278","src/backend/linux_raw/ugid/mod.rs":"2c647885=
7a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linu=
x_raw/ugid/syscalls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db84f444d32513=
09b7a0480b54f7","src/backend/linux_raw/vdso.rs":"056314f72c71d4b041739337ca=
2098afb7fe070f844327f462c293f43481b75b","src/backend/linux_raw/vdso_wrapper=
s.rs":"0e01221cbc6f0a489e89b0cf2fa376c3826ead8491ee8510476b75e90784f39a","s=
rc/bitcast.rs":"e21c87c292c781b27256c6f5dcf9fd52dd69ed6e21016cbd67ac31a8219=
ebf8e","src/buffer.rs":"8211a52e4fdd6ad74dcaddb885db25fa616898f988fc79b43af=
24b89c32d8421","src/check_types.rs":"e52f710e1cfc12ca13a495f2b43c227b293ff2=
95e1ce3ab332935b28a7579872","src/clockid.rs":"7237847231f9d2bd070606262a25d=
e6351de666f95065972967a5f2aae6fef0e","src/cstr.rs":"41af2a4429fe6c67a8883f8=
a8f63d66c90df566abda74fd2b03bcef7b9f24218","src/event/eventfd.rs":"81cbd08f=
7bdf40a6ce1ca692b63da1dc8ba925282990668d9d68f1203e839fa1","src/event/kqueue=
.rs":"2f776485e16fe57639ad7454886e0ae761880b122976141ac05b4b2e7d82183a","sr=
c/event/mod.rs":"7f82a5734d4ba2791054d154273cab48d1cce5ca47d680d44a1b71b96e=
ee932c","src/event/pause.rs":"cac3317286478565298a40788c1ce13c1b71543078a6f=
09655419de325022f6f","src/event/poll.rs":"899bbee8e565110b2581594e7aa5067a4=
26f859f0a414935e2ce3a9732b6152a","src/event/port.rs":"4e51ff150e5d17cbd44aa=
64a38b99c15e26eaaf2e350768b5dcacdfde4fa5212","src/ffi.rs":"c2b8b38c02d72749=
aceb715c496726caba1f1fa989ad3856d0103a2fafed89ed","src/fs/abs.rs":"99ecd74d=
d3447d16f142651c74397daca53aa5a21e7daf632937b0860ed63a84","src/fs/at.rs":"e=
2e017e48139101c882df6697f9e4842aed3dbd372c448249c61fd9486163183","src/fs/co=
nstants.rs":"23923e0fce3221bdac371fe2d05028f30a87dba4f9b4a573b69dc2d6d39320=
b2","src/fs/copy_file_range.rs":"d3b644374390d482b2ff749a2459458872b57d0dcf=
9670368739b7833509a7c2","src/fs/cwd.rs":"9f429a79ace6e17455634da09216ee0ad3=
d067a4541518b3193ae6a8d9ff1e26","src/fs/dir.rs":"347a52f4ca9ac6321c52e802e9=
7ec90d1b4c62ec955c8996fc17f8f5aed69966","src/fs/fadvise.rs":"1220e2cf5cf58f=
c7cc950d48738050a052c504f745ca67130daa6410e248230a","src/fs/fcntl.rs":"1d1e=
e1e0bc962779e1cc1b8b76f39c820746240557daa9e14b47b1799120dc39","src/fs/fcntl=
_apple.rs":"e2f23f038083621bcdecc98d02ce1023508afaecdb2ed0fba5c8b70f955301e=
5","src/fs/fcopyfile.rs":"ce565f61e1fbf2e31086077c2f1d01b6bb3b048915edda87f=
e9a4a4f5e8ff7e4","src/fs/fd.rs":"fe53f211e91352d522ac4f3b553a9366506458e215=
8295a93c5e746618f7a5fe","src/fs/getpath.rs":"28f6970fc1bbc37bb35c84724b59ea=
c436ea7407a4522e18c2bdacb1fdd2edd9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f97=
189cea4e5982a0d35b192afeec6340a6c6222e0cb","src/fs/ioctl.rs":"e798eb41bbc20=
1c375bc295ad2928c2467b45b4fbbff3c82236dccbc0d6391a5","src/fs/makedev.rs":"8=
5520b484cb7c15ab71ea1c368578ea3b7e484d82f8510db92b6ce9f7ca341ae","src/fs/me=
mfd_create.rs":"a8bf1dced54c7592e71da896021338d5092c1693d12cc42e79bac435fab=
2792b","src/fs/mod.rs":"e92dc5dc03b93181256dfdfd059739a4147323507aa1df3a3a9=
ed46a8816414b","src/fs/mount.rs":"8f6ea2b997dd83c50c90291b9ada3ed77a9ce1ad7=
01c9b0d533b5113b317be5b","src/fs/openat2.rs":"4a95c15dab533a41201b5fa25c8a2=
12956b7571d58cad696bdaf45af8aef96db","src/fs/raw_dir.rs":"18ad797876d6230c3=
8d4cacbed081c4028e03ace477d0520d9b226b40de942f0","src/fs/seek_from.rs":"a9e=
fa0feb9ac789cf47667e91efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","src/fs/send=
file.rs":"e3b2058741cf4b1698f34d84bb37130cf2b72806d522a16fe541e832cde136cb"=
,"src/fs/statx.rs":"f925be3d9a179a903549b3ac18038d004f4f2021e46dad4aa275790=
7aebefeca","src/fs/sync.rs":"a3b23543834281f347b0f873bd38154d31d404871188ac=
08f2b20b9196234cfd","src/fs/xattr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6=
ca3a47200532ca6e72d44cbe8334","src/io/close.rs":"2ddae17a2c9dc05fb2cefa1348=
15699c2b3af2eef8026407b8d009cb3ceae6b8","src/io/dup.rs":"bbebf4633120e21c7c=
49ecb93576cffa7e908f8089deb260f8d97426b469a0d4","src/io/errno.rs":"58a4d20b=
a0924e4d514e3c876fbe08982f1623187642ae14780815e65989c8c8","src/io/fcntl.rs"=
:"41c1b370be55aaa68144dcc8a67b2d53504a5e6d8ee1bffabac2cc64c66a4043","src/io=
/ioctl.rs":"0979246359dc2e53c84a4e1aa72044373682154656adafac6103c2ff753d9c8=
d","src/io/is_read_write.rs":"1bfb9ee5d58e0b29b44af12fe2668c7bccc841358698d=
cde47f1519ff9bb73b4","src/io/mod.rs":"75f1d0646be1d4c7c08b5887d8119b0103be8=
c25c43ccd4e0e97015508c0bb8f","src/io/read_write.rs":"bda0a708d86066686fd55a=
19a89818357a6a2ea9072e3853820314aea957868b","src/io_uring.rs":"4e641c9aaeba=
14890e4a354ad8b1fda8fe617923b4d3d685da22721d66a14bdf","src/ioctl/bsd.rs":"3=
2ba3399a0fe3f68bb458baafc2a21af9bff655865c7ea70990b7e98a26d3907","src/ioctl=
/linux.rs":"96df90bbc926783f387e8fe1656841d4c7a857fd4e9f41f95492f7dcece3307=
4","src/ioctl/mod.rs":"300dd73c0632ff322afc9a267f7be2a497e4681b73a3775b57cf=
f9eb500522a5","src/ioctl/patterns.rs":"bd6e309c8b548dfe04aaffe805972582fb56=
a0b717c45b45447630bdf9b88433","src/lib.rs":"55f4fe027ab6e638b4613893dffc27a=
0c20b0bea6f185b76f401f34a480b78f9","src/maybe_polyfill/no_std/io/mod.rs":"7=
7889bb5c5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/maybe=
_polyfill/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9cff=
3a19049d88c8c80","src/maybe_polyfill/no_std/net/ip_addr.rs":"046327ee244f75=
8f2bc31d3be305d8cd0dfd8342aac1add8259e999b4b46c4a7","src/maybe_polyfill/no_=
std/net/mod.rs":"486555be5c56cf3e049e65a1ea73aa60839c6f6ca667833e88ee4f360f=
9606dd","src/maybe_polyfill/no_std/net/socket_addr.rs":"bfeb32d32c176cde763=
23abcffebfc47e9898fb8d7ce3668c602dc8451086a2d","src/maybe_polyfill/no_std/o=
s/fd/mod.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e80771d507=
c47","src/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087cc9afd10269f=
09a8b4125915dc3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_std/os/fd/ra=
w.rs":"f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999e7c6943","s=
rc/maybe_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2fcc7c82531060=
6b889cc8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/windows/io/mod.rs=
":"5bbcc05c83fee5026dd744a994e0458469466d5be39081baa62df07753b92fd2","src/m=
aybe_polyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49328b5637cb3b=
afb96437f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/os/windows/io=
/socket.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5d2c64808308d=
65","src/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231a4e778b5f985=
b9ae712ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/std/mod.rs":"=
7c16c86cc73e226e65ead598e4018238b22000a345040b706bf1e1b3eba115fc","src/mm/m=
advise.rs":"69481cd3354dbffe6cd93b234448e59de6d0fe6440bcf8b12f951f37745bc1d=
c","src/mm/mmap.rs":"3b0abe64a6a606ea41b06acfc1079bcde1542c17475951e5ed900b=
86c3e5988d","src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761211a494ca6f8=
9b2367a2d2157e340e","src/mm/msync.rs":"a9092be024ecbfa9c14edb935404513498b0=
da2ac6c99fc31fe4e58196a95f02","src/mm/userfaultfd.rs":"8073443bd181ff0b3ba4=
d0b1ae67370b4864035a0c8b4898cd709dc47c518ae7","src/mount/fsopen.rs":"1c54a0=
2f04ee6710e2c5053c73361eecc499c24cd72c7c7c012dc57a4621e382","src/mount/mod.=
rs":"5f0c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d12a7136cb19","src=
/mount/mount_unmount.rs":"8ad11675e5d762d33fbefbed06a6a9f9e52a9b689bd066624=
46152614321ab77","src/mount/types.rs":"601ae3e10b7dc496fed7f3b40a80e81c6edd=
7bf13189d7be45c3212d4c684c39","src/net/mod.rs":"a6bc55f9e086caf46a7c0078349=
8d73a328a66f2a991f1ec65d5f13931377b0f","src/net/send_recv/mod.rs":"b4794b54=
dc0f09d99bcbc8fd2cb94f5fb03b39c5f99c1e8ef4a5c42dd49a56ea","src/net/send_rec=
v/msg.rs":"5e889662c076db5aa5041a75302aec04eb471c41570ffeb22b1a6c0760a3716a=
","src/net/socket.rs":"623de263730ed4dfe5085382f8f27c4953e40570813ab05f5771=
f790a3f1d544","src/net/socket_addr_any.rs":"a9af81e967a91b45e51aec4f46a068f=
ade7035c5d19dfaf05bfdcd3b3c32e9bf","src/net/socketpair.rs":"56f4885c31d2664=
cd16e18a9a88792a4912fedd953cec36dba67e8581fd57921","src/net/sockopt.rs":"5c=
778b3d392079858b76d3738ed7117f0136c3eda4b49345ae44457ad3403c1a","src/net/ty=
pes.rs":"d1186106a0a7dab578a9d7f36021ba4c77a50585ad155bd531ebb8553dff3366",=
"src/net/wsa.rs":"29856e6d0108be6b719f6ef973c5396e48ddd58ecd0c2db9ca3e2e0ba=
4eccb5b","src/param/auxv.rs":"8602af47a39bb340d319807bdecdb9be8b467101a9ed9=
6061277b90234801913","src/param/init.rs":"a31c0e5cea61a1a999767fe74f87c0d59=
eeb6bce66578b842fe0e0c32be27a55","src/param/mod.rs":"c514216b96d9520c9ffc56=
62c97b24f1f36f56fe1f5f3c9f64175c8b35577288","src/path/arg.rs":"1cbee317403a=
5d2281a4dea663cee03c9a968042f06d55145b8c5521513d393e","src/path/dec_int.rs"=
:"8ff8e14442c46f8e7a9b80d73973619b4271549b9defd538479bf8c2d93aa72e","src/pa=
th/mod.rs":"6b1b949c94bcc47e0f08a3f8e8db5b61ff497d0dfd3e0655f51c01d3e4b7dfd=
6","src/pid.rs":"f1c486000c5b1311b2d720cee88f089c17ef9a171709673dd06e6f35f4=
ff98a3","src/pipe.rs":"9f269090dd0588dc8d3feba4f4a78b61891bce91d3c9b64cdbad=
9251b06a9e11","src/prctl.rs":"19aa584895874ea48b9bbe1bf695b81257b0281df64df=
dd91e1b4bfa298661b7","src/process/chdir.rs":"911216459aa429fe9f125f1357d690=
0b43b0007835b85c719875d00f79a74664","src/process/chroot.rs":"2b5f6124eb19f2=
6ad2705174f7ad50cdc0a5d15abd59ffcf55421228d82130b4","src/process/exit.rs":"=
48de66e5504a00cb375d8f415ce63b6225a3f5204268d40726a7d0fbba43f587","src/proc=
ess/id.rs":"e4733f9e8e4b5f50e98ef7a23802e126f1f14ece8b3d7ae7446c6a66affc6bc=
1","src/process/ioctl.rs":"23ad0285671e8d7ca71a63c50655dbf732ccea8af11d754a=
0558e0236db37e76","src/process/kill.rs":"96d5ce432c19cf2b600d5248c681c117ab=
f53ae94bbfca7e75ac533a40e3968e","src/process/membarrier.rs":"1c4c39b359d1d0=
e9bbe16352eedfca9278d9ef298ade8ec00e998617bbcbfed8","src/process/mod.rs":"4=
fda62909afcb081281bd9a8eaf770dc3dfc2111013231ae23b0a1e101582f48","src/proce=
ss/pidfd.rs":"39de2dc7919eeeb53a5980622616140327671cd7e36bcf597aee1749df3a5=
b5b","src/process/pidfd_getfd.rs":"1faace75bdbcda57a296806dcfa5487811f8d11d=
ad9e6199c98df72feae66724","src/process/prctl.rs":"0130d05362a17a9282f339118=
9095e1f4f51fb56d7a5205906a0011842df4576","src/process/priority.rs":"f135482=
e71ea8aa0daf92b9f238051178a4c904070fa8409622f94155df3c544","src/process/pro=
cctl.rs":"75e9f7e5c66e6563aff133ff99b3a35c80a9f0a616d318a93a65be39ebc191ea"=
,"src/process/rlimit.rs":"10b79de3ced0e64059a94c879742d46a35a6176c776d8eed7=
5031d5e6340283d","src/process/sched.rs":"ea2acde244159ff3b07038a99f365c0766=
1e7f57c6e998af110ce937e9145d0b","src/process/sched_yield.rs":"6565faa3928b6=
6ddc74a65e893e15edfa4b9be4f7e5f5f68527501a7f6bc3350","src/process/umask.rs"=
:"1a0f31a842303c978e3f05ec191e2b5e96104c09c6596473b42b1fac34898a50","src/pr=
ocess/wait.rs":"f9c73dde2a66dfbe448501f039396dd26c5d678e4f8cb61c1f78014b7b4=
9fcd3","src/procfs.rs":"194678c863ae682143fcefb47601ae3d0b269a48eb9f43cae7f=
9d7e13f687920","src/pty.rs":"652c412e7280d0344b3f9bfe376c106a7f1b42b898b7af=
344e6e72da268e2bf0","src/rand/getrandom.rs":"0a5320eaf5dd4c6d9b1252c41ca286=
b40a9ce813eb469c89dba41e6258612740","src/rand/mod.rs":"e1fb7542f1958fe77673=
aa628bd92fef1b9addf79ba23df2398d1231cb61c148","src/runtime.rs":"958cdf1567c=
5758c73c197fc36d1feffb414a22a76a7a287afc84f330f2d2279","src/shm.rs":"b96fe8=
a05ee5d4536464a8843a776d43a938abaf22c772fc35b5373d95644a8d","src/signal.rs"=
:"a294b49d487dafaa42e534f8b1d93e87bec135087676b2ba2ef865cf2fccdaf2","src/st=
atic_assertions.rs":"504cf66f0d5b8e335be02f9ae8b0a355abc98c2c82eec0098bdf09=
88e662e260","src/stdio.rs":"a5de2d7d9c3c5a901f88b6acf4754687c958a2f3a93c794=
5c2b8fcb948d468af","src/system.rs":"4d7d1eff18094ec85a8ead70a7ccbe8ef78fd7f=
5705b7dfe3fa52541e9494887","src/termios/ioctl.rs":"a1ac967f7811a482f8bb5384=
7c37c8359f518cd26da9df7b816ba678a0139623","src/termios/mod.rs":"b44b7caa60b=
6f458657ed58a0e0eca41bb4e6d6be4b0f042bbb8ab7056cebe4b","src/termios/tc.rs":=
"5a56f252dcde4a841fae47a7a6f7890d81f61385c7b512143ece9389652004ae","src/ter=
mios/tty.rs":"35a5fc2d26501e0e6dde1a755eeccf7b4f3b4702c5bac30e0953220808ef7=
034","src/termios/types.rs":"b5671eedf541754c54f680002bafed1adbabce172d09d7=
c4d31fdf9313ca18c8","src/thread/clock.rs":"f49eb7271eb3e6831d9b0c3a01bfddbe=
4bd69dee237bbaa059884de452b29e79","src/thread/futex.rs":"985f9a0dce1e2a4892=
ae7f26bd1bf119ceae3f9fa6b4707e166624fc1cee76d4","src/thread/id.rs":"ad72db4=
fea9fccb728310bbfd01ef8c00f6cc60fa2a750f6349646a134f7009b","src/thread/libc=
ap.rs":"4c51b7df566d38dd0f85f81ef53279a745a39f0f4e1154791fd38438e2ca7db1","=
src/thread/mod.rs":"98634ece0b882f123ad887017692f2a4d94a23a1dec278ed660b349=
7cac5cceb","src/thread/prctl.rs":"ebc89b731eb8fd1a8f82a50dbba849061476a4537=
bba8702b29db657d5287ffa","src/thread/setns.rs":"ea9142b1f3a5b3f329683be185f=
960c50e5c1636149e91fbf59e88a897fc607d","src/time/clock.rs":"e59a29f1bed8c31=
c3d5b6fad60f2d4fa6cab8dd8e86148bb3693a5e3a1ce735f","src/time/mod.rs":"43afe=
e938c80d124d04d4ba190c03f4d21d1e3bfc154fff309211e4f6eabe940","src/time/time=
rfd.rs":"f17092b84553741aa2d2b44c6992b5d2c8c96cc2c2007fc9a2c6b2064485e53f",=
"src/timespec.rs":"32a4d930cbc0f6dbd23153290db920671cf4ce65a4a127e176f897c1=
cde42d7d","src/ugid.rs":"6616c6e35b7e43aee5b150f1efae7a50711e0947943c9a9683=
3dbe214ad9e85f","src/utils.rs":"9ae76f8a41d6cc350cdd58c9084b5c3a5a708eeecd7=
69783debdbcbaef442182","src/weak.rs":"c7cf03bf2aeba494b1999ab32183fa8c603ab=
72e254c0e312a67f168877e410d"},"package":"72e572a5e8ca657d7366229cdde4bd14c4=
eb5499a9573d4d366fe1b599daa316"}
+\ No newline at end of file
++{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231d2=
fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b0532d=
35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"9dc4e968d6cfe719f1548d=
4ba7f6ccb74eea14beb7f175784b2e58bd29c38df1","LICENSE-APACHE":"a60eea8175145=
31668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2.0_WI=
TH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39ef1f9=
4f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a715d9d2=
b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12ba79e=
4cebb6983a7b6491949750aecc4f2178","README.md":"cec45686b62cb75ef2f0c851939b=
7ddcb64678c27c18c7bca18d6f5cde2446d3","SECURITY.md":"4d75afb09dd28eb5982e3a=
1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e67273aa0=
a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"5f93559819=
ca7fe233f01579d51ff5b58cb6e96ef9e7817a3358a9b410d5bbf6","src/backend/libc/c=
.rs":"a0827e017f2bd4a406af521a862ba7783542dd2ebf2d29ec8a62f9e0b991102c","sr=
c/backend/libc/conv.rs":"b66d080db3a4c2756fe722462b543982bf88e5bc8071b9dc98=
d28ec2aee3dbfc","src/backend/libc/event/epoll.rs":"151fea9151a5a8f17d4d1390=
53b38cffae30701a69ad507f71e666c3dfbca869","src/backend/libc/event/mod.rs":"=
7f8547c599b8263eb791890bbe4a0b22fe2676d007ffdcc3e07b2e48d1c994db","src/back=
end/libc/event/poll_fd.rs":"280303b4be61600fa2e25fe59f10dc4e7010942286f6fb7=
cca93954ab63e01d9","src/backend/libc/event/syscalls.rs":"f91bbe7d222987c89a=
2647817f6819dd536cbc4a685dfb794f403543c32df777","src/backend/libc/event/typ=
es.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f13","=
src/backend/libc/event/windows_syscalls.rs":"ebfac665c6676c4b803134ab8806be=
8aa2e96bdbc7799a19c544cd9069b35787","src/backend/libc/fs/dir.rs":"9dff590f8=
1fa0bbbc37444c58ebf8fd4f5693bae4453ad6bfafd751c74b091b8","src/backend/libc/=
fs/inotify.rs":"a027a718db8bf6ff9a778c2cfa706850b466240b0a2296d72b9834c0096=
968e8","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f329ad3=
5bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803011b5=
7da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc/fs/s=
yscalls.rs":"f2d24c7b287a1e9a424331b60f5c599c7588ee4f150fb19bf3e04ba9d83d9d=
f1","src/backend/libc/fs/types.rs":"70995151d71b5ed10099e6b047cc491e1cc1d5f=
9964d5a863c5c35908f07df26","src/backend/libc/io/errno.rs":"50de984709793775=
59520ddc35b9777c761248b9083d93d86ff4f101f80c724d","src/backend/libc/io/mod.=
rs":"746647bd864e4ec7717925b6d176cebdb392b7d015070244cc48d92780351dd6","src=
/backend/libc/io/syscalls.rs":"d77032e4d7ec41e441e06181461ffc519d7c6e6dfc72=
0244a55399f0f870bb16","src/backend/libc/io/types.rs":"2efd39bb3df19a9db5496=
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
.rs":"5f0bd80a6575aba4a714443ca99af76ad15b053f1f8029aa1d9c7fa10e6d9242","sr=
c/backend/libc/net/msghdr.rs":"64825203c09cb60ac4e869cd27a44697f1efe53455c4=
1684279d50d8f0a96701","src/backend/libc/net/read_sockaddr.rs":"b1a72b7bd56c=
d152ed0731f571e4d9411b2974f860fc045319dc74b5b077e569","src/backend/libc/net=
/send_recv.rs":"1450ca958431a5bf3a85cdeef88b387f30d5c1215de2c56d164ccda38f2=
1b36c","src/backend/libc/net/sockopt.rs":"178a6622bab25bf1813d6c17151f48d82=
0e238db8cbd05be3aae563902d6c53e","src/backend/libc/net/syscalls.rs":"3d24b9=
ada485aacaa87a41d7ebe13fecddac7465bf1f04e52016da041b71bade","src/backend/li=
bc/net/write_sockaddr.rs":"6f06f6cf6089fbc43f93f4f3830468735c92277595769867=
cb6c89e1fe1c299a","src/backend/libc/param/auxv.rs":"fc9476c85482b1d44190289=
224ccf40c96fbf3a2fe3d8554ddb42acb2e97a8ae","src/backend/libc/param/mod.rs":=
"5234b8f1bcb886cca6ea003d411d75eaeebe58deedd80e3441354bf46ed85d4d","src/bac=
kend/libc/pid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded156=
93c805d84952","src/backend/libc/pid/syscalls.rs":"49ea679b96c0741d048e82964=
038f9a931bc3cf3a0b59c7db3df89629b9c49e6","src/backend/libc/pipe/mod.rs":"8a=
a966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backen=
d/libc/pipe/syscalls.rs":"8affde100f6a9dfc762b79d1e48be5c1039be414f8ef7d5a6=
acaba882a68d259","src/backend/libc/pipe/types.rs":"9826013bc5fa18acdcbf09c6=
50b96ce301a18ec009139ebaf79162669b1fc2c8","src/backend/libc/prctl/mod.rs":"=
2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/back=
end/libc/prctl/syscalls.rs":"8a2684f444a7555098dce2b92270d81cefdae902716c6e=
5d59bd7b0657e8a29d","src/backend/libc/process/cpu_set.rs":"b3d36b01b53b0b6c=
61a20ed8a69d48eccdd90cc17f82f2926ef1e844f002d0b7","src/backend/libc/process=
/mod.rs":"806e26da8d1e7afae502987fcd650f4d348da147b8a2e74447affdca153e2e97"=
,"src/backend/libc/process/syscalls.rs":"9d7028bc55c5dd1fa742c13ea0904fbf95=
094232e7ba2871fa758a93838666de","src/backend/libc/process/types.rs":"fb2caf=
34b17079aa72c04aed0f9a31d534ea8e8b73a80c758b748bf5e38df52b","src/backend/li=
bc/process/wait.rs":"0cc556aed976b4bbb3965f74fd76b8216c755fce25043b7b21ce54=
afa07c9773","src/backend/libc/pty/mod.rs":"2c6478857a0751625edabd61acb84181=
9bfba1093b1faeded15693c805d84952","src/backend/libc/pty/syscalls.rs":"566fc=
9a2cb2e38d7d7ac2405b22c0522369cae4a8f4fe18b55123ba94d3d5a95","src/backend/l=
ibc/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/rand/syscalls.rs":"35ea6b6e0f8a7fb064fd5cb33a3a8=
55cd161a6a00f93d76c861b2a2c66db85e7","src/backend/libc/rand/types.rs":"4eb0=
b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a705ec605b773f63f880","src/backend/=
libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/shm/syscalls.rs":"60d797d4e85e08e6330e6b8d800943=
56ce377e5484952f88ae2a6e49231c268c","src/backend/libc/shm/types.rs":"2206ea=
c8ee74951b995e1e80f10bf235cc6b04e0a099f4adefce546378838233","src/backend/li=
bc/system/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c05718e85bdc88a36dc805efdfc=
e45d3909","src/backend/libc/system/syscalls.rs":"abe1093f3495668d8576ae5507=
3c74976cffb04d2e1bc20583d7ec12ac848b06","src/backend/libc/system/types.rs":=
"6871e16aee14fe2ae03cea798c3e509ffe44778a9c0e5608fd73e2e015876d7e","src/bac=
kend/libc/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faede=
d15693c805d84952","src/backend/libc/termios/syscalls.rs":"f377dfbf501fbc3cd=
bc9e190dd650c8141c00c1593b8c62901ecf346a0c1a7c5","src/backend/libc/thread/f=
utex.rs":"b666828653b12634bbd7fd709acf69641b648ec40962a1d4f904c5db14d2eff5"=
,"src/backend/libc/thread/mod.rs":"fa710053974d7f16a6c49242ee6c10a3b9e11434=
52b9daeaed8837302a679fff","src/backend/libc/thread/syscalls.rs":"c8e84ad232=
ec1317be989529c24e204c51bb4e1e0212de2c1937b00bc92e5483","src/backend/libc/t=
ime/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c05718e85bdc88a36dc805efdfce45d39=
09","src/backend/libc/time/syscalls.rs":"f82e0725c5af8a52e61ee83aad2c77694f=
2f7a72ac1e6eb284109a70ac6edc38","src/backend/libc/time/types.rs":"d0307994f=
fddd3f21f702d9ae4400750aecccfaf4a01268161dc4fd72de5c373","src/backend/libc/=
ugid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84=
952","src/backend/libc/ugid/syscalls.rs":"8edf91b8790add23902c9f5418da6b072=
3a371677f29f490e0c8af852f0f1a0c","src/backend/libc/winsock_c.rs":"502da2ed3=
cd6ca99bb7ee08b0b30e25c212632885cec965f9816366c6b931ac6","src/backend/linux=
_raw/arch/aarch64.rs":"2a255c9135bc8a321c180f52b88eb2b158bc9170cd222149caea=
e63c24587d44","src/backend/linux_raw/arch/arm.rs":"165bccb5883d0136e55d4209=
1183765f83d86e9d37a7cb2cec9ae8af32774db6","src/backend/linux_raw/arch/mips.=
rs":"24af364aa93fd4b9917639d473336490a143f0d1723b09f388e72d534160ee51","src=
/backend/linux_raw/arch/mips32r6.rs":"e436a2ade34f2f7c58b8924462b07a2499dfc=
951e1e1318d51759444fb8b658e","src/backend/linux_raw/arch/mips64.rs":"897da9=
ddc877963ad59464d7f81dc59df8a7e91251e6adea14cfd946e2740a1c","src/backend/li=
nux_raw/arch/mips64r6.rs":"3c08aea13c1139fb0dfbe74ca3d0147f007c3aa2eda641af=
b82c46f6aa4f6cd1","src/backend/linux_raw/arch/mod.rs":"37eaeea601d39be00d17=
0856a31a8ec6a27b0d3ac22ab3ee642ab0e45dee237d","src/backend/linux_raw/arch/p=
owerpc64.rs":"dfb001f8636a5e46d728900b0804fe6c374e5e18a6f0e76d7d62e0c07da74=
477","src/backend/linux_raw/arch/riscv64.rs":"41d33242d941030f46077dc2b1bc4=
c7913fe7630d693a5a7eef966bcf38f9d8b","src/backend/linux_raw/arch/thumb.rs":=
"2fd979ab421248c0a4c592bc0cefee63edc26528f469b71b63eaed35356e42e8","src/bac=
kend/linux_raw/arch/x86.rs":"fc72f595ec75768aee248d405f4958a7ba1db65ac9fe54=
b277cd003eab33316e","src/backend/linux_raw/arch/x86_64.rs":"e929036a1f3cf93=
ba538f4523b241605cc7b5e61f84ffe6d9d5cdbcb6f73e543","src/backend/linux_raw/c=
.rs":"5669c25110b62dbb8a79bbceb167732693b2ff7cc82dd78cc68c1c7f3aeec6af","sr=
c/backend/linux_raw/conv.rs":"017ef1ef5044c99acf124db022c134b946c68b4c0150e=
61c7615947e9ce088f0","src/backend/linux_raw/event/epoll.rs":"a102c2d8d7d5d0=
7a5d846f30672153269d1762d1d846be1786b22fcf095e8721","src/backend/linux_raw/=
event/mod.rs":"72e46b04637e2d1d2a6b97af616144995399e489d1fe916faf835d72fc8c=
64cd","src/backend/linux_raw/event/poll_fd.rs":"a5773464e9e30227b4046f029a2=
7d3daf2c7bd0045e54565cf1a8ac2a0d61e81","src/backend/linux_raw/event/syscall=
s.rs":"44460b0045bb9d9f48b0baeb009a6b150a2902f9b733e8f6c5a36726b8db2d41","s=
rc/backend/linux_raw/event/types.rs":"0551b18f982e233a0a06d8a9c3dbb29de0c20=
4dcd64dd6f7e88b6c96fa9a9be8","src/backend/linux_raw/fs/dir.rs":"8fe8f139e97=
20208ece606af3bd8097e87e54ea9ce155f228530c8f6acd03992","src/backend/linux_r=
aw/fs/inotify.rs":"713ec3b85f281efca19bc4f495b7537e745fbf1d8c26592c80ceec6f=
d2ab59b5","src/backend/linux_raw/fs/makedev.rs":"c6b4505c4bcbbc2460e80f3097=
eb15e2c8ef38d6c6e7abd78e39c53c372139e2","src/backend/linux_raw/fs/mod.rs":"=
3d3a42bbf4d086f806d7d9f6e4b0a49a873dc27f4f03ffca0921f5536acc24e5","src/back=
end/linux_raw/fs/syscalls.rs":"799630cb4322a3a88558f2f2dd678fdf5bbbd7704098=
b27b2da51705ee050ab1","src/backend/linux_raw/fs/types.rs":"a2b1bb81b9b50e91=
27885b4facb4c26b42e9e7b1374ff38f203bc36b54c41091","src/backend/linux_raw/io=
/errno.rs":"6464c776312d478d9a7aae0e66f624ecbec5e56f1c33713a5f11f2ed5000ba9=
e","src/backend/linux_raw/io/mod.rs":"7ae2324427892cca6f5ab53858d847b165f79=
0a72ec25f3d99fb15f0506c9f27","src/backend/linux_raw/io/syscalls.rs":"568e16=
751191c14bb37f7883b17cb577dc97e09d615d17849c0e7e10e3898f1b","src/backend/li=
nux_raw/io/types.rs":"d0df5a62248e1ba19af0f89f86da7ba2312d97065c2814ddf6b08=
a4a0db23bad","src/backend/linux_raw/io_uring/mod.rs":"2c6478857a0751625edab=
d61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/io_urin=
g/syscalls.rs":"0f7c9cb7ccddf5687e4b9e5b23558871a452a29ac6095a0184a06c47b9b=
18eb6","src/backend/linux_raw/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53=
539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mm/syscalls.rs":"4e=
469542c88ea15853d5022e7e1d4b8fc291265ca314766d60d9395dad927e19","src/backen=
d/linux_raw/mm/types.rs":"b5bf9bf775d3771e79aa234788fa3d1f25009f3f51cd59c72=
efc4f5e2c7bd790","src/backend/linux_raw/mod.rs":"86f7c3b1d57e57a9e5b5dcc8ee=
24ded5054a917069bd9824f47952b10bca2221","src/backend/linux_raw/mount/mod.rs=
":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/b=
ackend/linux_raw/mount/syscalls.rs":"8442c82814961f69c488222faabb82c44d2e72=
27b10faff919cbbd197bb47484","src/backend/linux_raw/mount/types.rs":"bf3dff5=
aad1cec9d998496230469958c836b76643f0ad17b0ea29b957357bcca","src/backend/lin=
ux_raw/net/addr.rs":"920373911f43deff1a5e54b9d01a8712e6971734f7eba7932dc813=
b9a30771d6","src/backend/linux_raw/net/mod.rs":"904b2ccd4228ebcda25db0223b9=
2fb03e4042bcc7b0a202f19410a8a5ff517a5","src/backend/linux_raw/net/msghdr.rs=
":"a88e8395dd5a25c103dc2172d4e7013e5104a6d70091ad78efd286ebc8284acf","src/b=
ackend/linux_raw/net/read_sockaddr.rs":"3aac93a52053b0ffba7097b4738c3c78aaf=
0e35884a3451df0628a772b1907eb","src/backend/linux_raw/net/send_recv.rs":"6d=
5d2aec61a3c1b4a5fef1a8a487dc8e163da8988d1237541ed008baa01128cc","src/backen=
d/linux_raw/net/sockopt.rs":"2ea8625ecd68a799c14ed48dec2f3e01f085222b6cc36f=
4916b20143e08ae575","src/backend/linux_raw/net/syscalls.rs":"5347eefe5bd389=
2c9e3d6f91a04b9dd215180b1e148ed2ab7ff20bafbe1617ae","src/backend/linux_raw/=
net/write_sockaddr.rs":"a9374256cb47b3f4d5fec308986a109ce51a521abab31590df1=
f66c04c07d437","src/backend/linux_raw/param/auxv.rs":"ee59d2a618a8c63151681=
4b53655830eeb7ae33cda847d1be382419ba3cdb559","src/backend/linux_raw/param/i=
nit.rs":"6b1297dd9d02d9cf0be19a263d1e0cd084a5fbe723aa3bce2eee5f55e850bde0",=
"src/backend/linux_raw/param/libc_auxv.rs":"d7d2c46feba6d383d17d9d25293ab40=
e39dfefb23533844ee7abaa917923e2b5","src/backend/linux_raw/param/mod.rs":"2e=
6a1a1c00351b9c88bd615aa923f71d76208df5626dd9bea03067f28f81dc31","src/backen=
d/linux_raw/pid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded1=
5693c805d84952","src/backend/linux_raw/pid/syscalls.rs":"eef6aa01830ddd510b=
83f507da2002c03e58318b73744be2c06ebbe33c4f194f","src/backend/linux_raw/pipe=
/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7"=
,"src/backend/linux_raw/pipe/syscalls.rs":"366c730fc3e991bddb9f5a15b8c3917a=
8e6ace6d1d5a9113b2749e476faf6f83","src/backend/linux_raw/pipe/types.rs":"cf=
53bcdcde5d0ee15e0e3566ceaad39fda44e69ed6f94a99fadd9be9b8be09cf","src/backen=
d/linux_raw/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faede=
d15693c805d84952","src/backend/linux_raw/prctl/syscalls.rs":"a18b224307e0d2=
7bda9b7b85c75cd6c7ddfe39f5ce52efb7bb0bf0585b757343","src/backend/linux_raw/=
process/cpu_set.rs":"dfdcbdf35aff6a3e08e7d38193bf18c12ca8aa64eb0dc417667be8=
2dcc0f7c55","src/backend/linux_raw/process/mod.rs":"fb393c70a9c63ef9a6bf1fb=
5a2dc94f07d6b0b6987cc5231c15c607015dafd68","src/backend/linux_raw/process/s=
yscalls.rs":"be1427f2ab11ce35b2746b48351c5a0aff2b71ad2b6471a2876f88cb80c0b7=
f7","src/backend/linux_raw/process/types.rs":"6811ba822bc12a1a6336649151b4a=
db1f5d3365684a31c07f01953ea9547743d","src/backend/linux_raw/process/wait.rs=
":"921aee4b0048746087f52615a98edc2aa0fb4b53d6df44be4533098df55d1b05","src/b=
ackend/linux_raw/pty/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1fa=
eded15693c805d84952","src/backend/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae=
87b1ca58d82efc58007b9dddaae78460d615f48da19d1cd0f89","src/backend/linux_raw=
/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7=
cfd7","src/backend/linux_raw/rand/syscalls.rs":"317cdaf243623329ee345131054=
e86a06a0863a9e90c5dba73e1ac3475ba6305","src/backend/linux_raw/rand/types.rs=
":"a21dbb1ab31eed6b59a57520be5a3c603c36d18ea74e67f7527f40835ba209a3","src/b=
ackend/linux_raw/reg.rs":"def5f88730bd625b2298c86559b5a378fce4bf6ce22520474=
0ba087e034abce6","src/backend/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92=
942f06ea0b68464040dcac33c6f0f7ee392c6269993347","src/backend/linux_raw/runt=
ime/syscalls.rs":"dc7df0416919d1eef7e4919fc38836e2081903db286330d59b0119cc2=
92155df","src/backend/linux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cd=
ba6e8c91414113a04a739160929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":=
"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/bac=
kend/linux_raw/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d937945=
40087b3182cbdf3cb9c8db","src/backend/linux_raw/shm/types.rs":"b831b474aba7e=
b97167c9289f5257776a72b39134b44e67a0ecfcef2394dcd47","src/backend/linux_raw=
/system/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07=
f7cfd7","src/backend/linux_raw/system/syscalls.rs":"2af6c2672a6528b404b52f5=
01d9803a63e9f47886d3b5d2d2dc5a71cefa7327a","src/backend/linux_raw/system/ty=
pes.rs":"1ceab8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e",=
"src/backend/linux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bf=
ba1093b1faeded15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":=
"25a0341ded4657a3a5389250c24b3310642785d386bc51f31696f98f4f1e770f","src/bac=
kend/linux_raw/thread/futex.rs":"0aa0f9f5be6a79de81e82c9f11f1bf8831f682a4b2=
f6cb29669e1591636f084e","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90b92=
34e79900b27ebbe8837e3a7a36aec532912e3e253edce5225067","src/backend/linux_ra=
w/thread/syscalls.rs":"0e3dca63be7322e1e9c58456b28eb8548abb9f08b4436b87b139=
e891c01c446d","src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7452bb1=
cc2d28b5f0aaa840a2856fe363acce624e1beefc","src/backend/linux_raw/time/sysca=
lls.rs":"7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de9404845312fc",=
"src/backend/linux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a81d3305e1=
8e726e54edc5a5474641f3cdc278","src/backend/linux_raw/ugid/mod.rs":"2c647885=
7a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linu=
x_raw/ugid/syscalls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db84f444d32513=
09b7a0480b54f7","src/backend/linux_raw/vdso.rs":"056314f72c71d4b041739337ca=
2098afb7fe070f844327f462c293f43481b75b","src/backend/linux_raw/vdso_wrapper=
s.rs":"0e01221cbc6f0a489e89b0cf2fa376c3826ead8491ee8510476b75e90784f39a","s=
rc/bitcast.rs":"e21c87c292c781b27256c6f5dcf9fd52dd69ed6e21016cbd67ac31a8219=
ebf8e","src/buffer.rs":"8211a52e4fdd6ad74dcaddb885db25fa616898f988fc79b43af=
24b89c32d8421","src/check_types.rs":"e52f710e1cfc12ca13a495f2b43c227b293ff2=
95e1ce3ab332935b28a7579872","src/clockid.rs":"7237847231f9d2bd070606262a25d=
e6351de666f95065972967a5f2aae6fef0e","src/cstr.rs":"41af2a4429fe6c67a8883f8=
a8f63d66c90df566abda74fd2b03bcef7b9f24218","src/event/eventfd.rs":"81cbd08f=
7bdf40a6ce1ca692b63da1dc8ba925282990668d9d68f1203e839fa1","src/event/kqueue=
.rs":"2f776485e16fe57639ad7454886e0ae761880b122976141ac05b4b2e7d82183a","sr=
c/event/mod.rs":"7f82a5734d4ba2791054d154273cab48d1cce5ca47d680d44a1b71b96e=
ee932c","src/event/pause.rs":"cac3317286478565298a40788c1ce13c1b71543078a6f=
09655419de325022f6f","src/event/poll.rs":"899bbee8e565110b2581594e7aa5067a4=
26f859f0a414935e2ce3a9732b6152a","src/event/port.rs":"4e51ff150e5d17cbd44aa=
64a38b99c15e26eaaf2e350768b5dcacdfde4fa5212","src/ffi.rs":"c2b8b38c02d72749=
aceb715c496726caba1f1fa989ad3856d0103a2fafed89ed","src/fs/abs.rs":"99ecd74d=
d3447d16f142651c74397daca53aa5a21e7daf632937b0860ed63a84","src/fs/at.rs":"e=
2e017e48139101c882df6697f9e4842aed3dbd372c448249c61fd9486163183","src/fs/co=
nstants.rs":"23923e0fce3221bdac371fe2d05028f30a87dba4f9b4a573b69dc2d6d39320=
b2","src/fs/copy_file_range.rs":"d3b644374390d482b2ff749a2459458872b57d0dcf=
9670368739b7833509a7c2","src/fs/cwd.rs":"9f429a79ace6e17455634da09216ee0ad3=
d067a4541518b3193ae6a8d9ff1e26","src/fs/dir.rs":"347a52f4ca9ac6321c52e802e9=
7ec90d1b4c62ec955c8996fc17f8f5aed69966","src/fs/fadvise.rs":"1220e2cf5cf58f=
c7cc950d48738050a052c504f745ca67130daa6410e248230a","src/fs/fcntl.rs":"1d1e=
e1e0bc962779e1cc1b8b76f39c820746240557daa9e14b47b1799120dc39","src/fs/fcntl=
_apple.rs":"e2f23f038083621bcdecc98d02ce1023508afaecdb2ed0fba5c8b70f955301e=
5","src/fs/fcopyfile.rs":"ce565f61e1fbf2e31086077c2f1d01b6bb3b048915edda87f=
e9a4a4f5e8ff7e4","src/fs/fd.rs":"fe53f211e91352d522ac4f3b553a9366506458e215=
8295a93c5e746618f7a5fe","src/fs/getpath.rs":"28f6970fc1bbc37bb35c84724b59ea=
c436ea7407a4522e18c2bdacb1fdd2edd9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f97=
189cea4e5982a0d35b192afeec6340a6c6222e0cb","src/fs/ioctl.rs":"18b44e1708c71=
60c3bb7efaf27eefb6d11671f91d5008144fc74695d75a226c6","src/fs/makedev.rs":"8=
5520b484cb7c15ab71ea1c368578ea3b7e484d82f8510db92b6ce9f7ca341ae","src/fs/me=
mfd_create.rs":"a8bf1dced54c7592e71da896021338d5092c1693d12cc42e79bac435fab=
2792b","src/fs/mod.rs":"e92dc5dc03b93181256dfdfd059739a4147323507aa1df3a3a9=
ed46a8816414b","src/fs/mount.rs":"8f6ea2b997dd83c50c90291b9ada3ed77a9ce1ad7=
01c9b0d533b5113b317be5b","src/fs/openat2.rs":"4a95c15dab533a41201b5fa25c8a2=
12956b7571d58cad696bdaf45af8aef96db","src/fs/raw_dir.rs":"18ad797876d6230c3=
8d4cacbed081c4028e03ace477d0520d9b226b40de942f0","src/fs/seek_from.rs":"a9e=
fa0feb9ac789cf47667e91efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","src/fs/send=
file.rs":"e3b2058741cf4b1698f34d84bb37130cf2b72806d522a16fe541e832cde136cb"=
,"src/fs/statx.rs":"f925be3d9a179a903549b3ac18038d004f4f2021e46dad4aa275790=
7aebefeca","src/fs/sync.rs":"a3b23543834281f347b0f873bd38154d31d404871188ac=
08f2b20b9196234cfd","src/fs/xattr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6=
ca3a47200532ca6e72d44cbe8334","src/io/close.rs":"2ddae17a2c9dc05fb2cefa1348=
15699c2b3af2eef8026407b8d009cb3ceae6b8","src/io/dup.rs":"bbebf4633120e21c7c=
49ecb93576cffa7e908f8089deb260f8d97426b469a0d4","src/io/errno.rs":"58a4d20b=
a0924e4d514e3c876fbe08982f1623187642ae14780815e65989c8c8","src/io/fcntl.rs"=
:"41c1b370be55aaa68144dcc8a67b2d53504a5e6d8ee1bffabac2cc64c66a4043","src/io=
/ioctl.rs":"0979246359dc2e53c84a4e1aa72044373682154656adafac6103c2ff753d9c8=
d","src/io/is_read_write.rs":"1bfb9ee5d58e0b29b44af12fe2668c7bccc841358698d=
cde47f1519ff9bb73b4","src/io/mod.rs":"75f1d0646be1d4c7c08b5887d8119b0103be8=
c25c43ccd4e0e97015508c0bb8f","src/io/read_write.rs":"bda0a708d86066686fd55a=
19a89818357a6a2ea9072e3853820314aea957868b","src/io_uring.rs":"4e641c9aaeba=
14890e4a354ad8b1fda8fe617923b4d3d685da22721d66a14bdf","src/ioctl/bsd.rs":"3=
2ba3399a0fe3f68bb458baafc2a21af9bff655865c7ea70990b7e98a26d3907","src/ioctl=
/linux.rs":"96df90bbc926783f387e8fe1656841d4c7a857fd4e9f41f95492f7dcece3307=
4","src/ioctl/mod.rs":"300dd73c0632ff322afc9a267f7be2a497e4681b73a3775b57cf=
f9eb500522a5","src/ioctl/patterns.rs":"bd6e309c8b548dfe04aaffe805972582fb56=
a0b717c45b45447630bdf9b88433","src/lib.rs":"55f4fe027ab6e638b4613893dffc27a=
0c20b0bea6f185b76f401f34a480b78f9","src/maybe_polyfill/no_std/io/mod.rs":"7=
7889bb5c5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/maybe=
_polyfill/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9cff=
3a19049d88c8c80","src/maybe_polyfill/no_std/net/ip_addr.rs":"046327ee244f75=
8f2bc31d3be305d8cd0dfd8342aac1add8259e999b4b46c4a7","src/maybe_polyfill/no_=
std/net/mod.rs":"486555be5c56cf3e049e65a1ea73aa60839c6f6ca667833e88ee4f360f=
9606dd","src/maybe_polyfill/no_std/net/socket_addr.rs":"bfeb32d32c176cde763=
23abcffebfc47e9898fb8d7ce3668c602dc8451086a2d","src/maybe_polyfill/no_std/o=
s/fd/mod.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e80771d507=
c47","src/maybe_polyfill/no_std/os/fd/owned.rs":"d82bfeadf28087cc9afd10269f=
09a8b4125915dc3288b6427c79f5b4c58ab751","src/maybe_polyfill/no_std/os/fd/ra=
w.rs":"f3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999e7c6943","s=
rc/maybe_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2fcc7c82531060=
6b889cc8dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/windows/io/mod.rs=
":"5bbcc05c83fee5026dd744a994e0458469466d5be39081baa62df07753b92fd2","src/m=
aybe_polyfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49328b5637cb3b=
afb96437f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/os/windows/io=
/socket.rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5d2c64808308d=
65","src/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231a4e778b5f985=
b9ae712ece5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/std/mod.rs":"=
7c16c86cc73e226e65ead598e4018238b22000a345040b706bf1e1b3eba115fc","src/mm/m=
advise.rs":"69481cd3354dbffe6cd93b234448e59de6d0fe6440bcf8b12f951f37745bc1d=
c","src/mm/mmap.rs":"3b0abe64a6a606ea41b06acfc1079bcde1542c17475951e5ed900b=
86c3e5988d","src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761211a494ca6f8=
9b2367a2d2157e340e","src/mm/msync.rs":"a9092be024ecbfa9c14edb935404513498b0=
da2ac6c99fc31fe4e58196a95f02","src/mm/userfaultfd.rs":"8073443bd181ff0b3ba4=
d0b1ae67370b4864035a0c8b4898cd709dc47c518ae7","src/mount/fsopen.rs":"1c54a0=
2f04ee6710e2c5053c73361eecc499c24cd72c7c7c012dc57a4621e382","src/mount/mod.=
rs":"5f0c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d12a7136cb19","src=
/mount/mount_unmount.rs":"8ad11675e5d762d33fbefbed06a6a9f9e52a9b689bd066624=
46152614321ab77","src/mount/types.rs":"601ae3e10b7dc496fed7f3b40a80e81c6edd=
7bf13189d7be45c3212d4c684c39","src/net/mod.rs":"a6bc55f9e086caf46a7c0078349=
8d73a328a66f2a991f1ec65d5f13931377b0f","src/net/send_recv/mod.rs":"b4794b54=
dc0f09d99bcbc8fd2cb94f5fb03b39c5f99c1e8ef4a5c42dd49a56ea","src/net/send_rec=
v/msg.rs":"5e889662c076db5aa5041a75302aec04eb471c41570ffeb22b1a6c0760a3716a=
","src/net/socket.rs":"623de263730ed4dfe5085382f8f27c4953e40570813ab05f5771=
f790a3f1d544","src/net/socket_addr_any.rs":"a9af81e967a91b45e51aec4f46a068f=
ade7035c5d19dfaf05bfdcd3b3c32e9bf","src/net/socketpair.rs":"56f4885c31d2664=
cd16e18a9a88792a4912fedd953cec36dba67e8581fd57921","src/net/sockopt.rs":"5c=
778b3d392079858b76d3738ed7117f0136c3eda4b49345ae44457ad3403c1a","src/net/ty=
pes.rs":"d1186106a0a7dab578a9d7f36021ba4c77a50585ad155bd531ebb8553dff3366",=
"src/net/wsa.rs":"29856e6d0108be6b719f6ef973c5396e48ddd58ecd0c2db9ca3e2e0ba=
4eccb5b","src/param/auxv.rs":"8602af47a39bb340d319807bdecdb9be8b467101a9ed9=
6061277b90234801913","src/param/init.rs":"a31c0e5cea61a1a999767fe74f87c0d59=
eeb6bce66578b842fe0e0c32be27a55","src/param/mod.rs":"c514216b96d9520c9ffc56=
62c97b24f1f36f56fe1f5f3c9f64175c8b35577288","src/path/arg.rs":"1cbee317403a=
5d2281a4dea663cee03c9a968042f06d55145b8c5521513d393e","src/path/dec_int.rs"=
:"8ff8e14442c46f8e7a9b80d73973619b4271549b9defd538479bf8c2d93aa72e","src/pa=
th/mod.rs":"6b1b949c94bcc47e0f08a3f8e8db5b61ff497d0dfd3e0655f51c01d3e4b7dfd=
6","src/pid.rs":"f1c486000c5b1311b2d720cee88f089c17ef9a171709673dd06e6f35f4=
ff98a3","src/pipe.rs":"9f269090dd0588dc8d3feba4f4a78b61891bce91d3c9b64cdbad=
9251b06a9e11","src/prctl.rs":"19aa584895874ea48b9bbe1bf695b81257b0281df64df=
dd91e1b4bfa298661b7","src/process/chdir.rs":"911216459aa429fe9f125f1357d690=
0b43b0007835b85c719875d00f79a74664","src/process/chroot.rs":"2b5f6124eb19f2=
6ad2705174f7ad50cdc0a5d15abd59ffcf55421228d82130b4","src/process/exit.rs":"=
48de66e5504a00cb375d8f415ce63b6225a3f5204268d40726a7d0fbba43f587","src/proc=
ess/id.rs":"e4733f9e8e4b5f50e98ef7a23802e126f1f14ece8b3d7ae7446c6a66affc6bc=
1","src/process/ioctl.rs":"23ad0285671e8d7ca71a63c50655dbf732ccea8af11d754a=
0558e0236db37e76","src/process/kill.rs":"96d5ce432c19cf2b600d5248c681c117ab=
f53ae94bbfca7e75ac533a40e3968e","src/process/membarrier.rs":"1c4c39b359d1d0=
e9bbe16352eedfca9278d9ef298ade8ec00e998617bbcbfed8","src/process/mod.rs":"4=
fda62909afcb081281bd9a8eaf770dc3dfc2111013231ae23b0a1e101582f48","src/proce=
ss/pidfd.rs":"39de2dc7919eeeb53a5980622616140327671cd7e36bcf597aee1749df3a5=
b5b","src/process/pidfd_getfd.rs":"1faace75bdbcda57a296806dcfa5487811f8d11d=
ad9e6199c98df72feae66724","src/process/prctl.rs":"0130d05362a17a9282f339118=
9095e1f4f51fb56d7a5205906a0011842df4576","src/process/priority.rs":"f135482=
e71ea8aa0daf92b9f238051178a4c904070fa8409622f94155df3c544","src/process/pro=
cctl.rs":"75e9f7e5c66e6563aff133ff99b3a35c80a9f0a616d318a93a65be39ebc191ea"=
,"src/process/rlimit.rs":"10b79de3ced0e64059a94c879742d46a35a6176c776d8eed7=
5031d5e6340283d","src/process/sched.rs":"ea2acde244159ff3b07038a99f365c0766=
1e7f57c6e998af110ce937e9145d0b","src/process/sched_yield.rs":"6565faa3928b6=
6ddc74a65e893e15edfa4b9be4f7e5f5f68527501a7f6bc3350","src/process/umask.rs"=
:"1a0f31a842303c978e3f05ec191e2b5e96104c09c6596473b42b1fac34898a50","src/pr=
ocess/wait.rs":"f9c73dde2a66dfbe448501f039396dd26c5d678e4f8cb61c1f78014b7b4=
9fcd3","src/procfs.rs":"194678c863ae682143fcefb47601ae3d0b269a48eb9f43cae7f=
9d7e13f687920","src/pty.rs":"652c412e7280d0344b3f9bfe376c106a7f1b42b898b7af=
344e6e72da268e2bf0","src/rand/getrandom.rs":"0a5320eaf5dd4c6d9b1252c41ca286=
b40a9ce813eb469c89dba41e6258612740","src/rand/mod.rs":"e1fb7542f1958fe77673=
aa628bd92fef1b9addf79ba23df2398d1231cb61c148","src/runtime.rs":"958cdf1567c=
5758c73c197fc36d1feffb414a22a76a7a287afc84f330f2d2279","src/shm.rs":"b96fe8=
a05ee5d4536464a8843a776d43a938abaf22c772fc35b5373d95644a8d","src/signal.rs"=
:"a294b49d487dafaa42e534f8b1d93e87bec135087676b2ba2ef865cf2fccdaf2","src/st=
atic_assertions.rs":"504cf66f0d5b8e335be02f9ae8b0a355abc98c2c82eec0098bdf09=
88e662e260","src/stdio.rs":"a5de2d7d9c3c5a901f88b6acf4754687c958a2f3a93c794=
5c2b8fcb948d468af","src/system.rs":"4d7d1eff18094ec85a8ead70a7ccbe8ef78fd7f=
5705b7dfe3fa52541e9494887","src/termios/ioctl.rs":"a1ac967f7811a482f8bb5384=
7c37c8359f518cd26da9df7b816ba678a0139623","src/termios/mod.rs":"b44b7caa60b=
6f458657ed58a0e0eca41bb4e6d6be4b0f042bbb8ab7056cebe4b","src/termios/tc.rs":=
"5a56f252dcde4a841fae47a7a6f7890d81f61385c7b512143ece9389652004ae","src/ter=
mios/tty.rs":"35a5fc2d26501e0e6dde1a755eeccf7b4f3b4702c5bac30e0953220808ef7=
034","src/termios/types.rs":"b5671eedf541754c54f680002bafed1adbabce172d09d7=
c4d31fdf9313ca18c8","src/thread/clock.rs":"f49eb7271eb3e6831d9b0c3a01bfddbe=
4bd69dee237bbaa059884de452b29e79","src/thread/futex.rs":"985f9a0dce1e2a4892=
ae7f26bd1bf119ceae3f9fa6b4707e166624fc1cee76d4","src/thread/id.rs":"ad72db4=
fea9fccb728310bbfd01ef8c00f6cc60fa2a750f6349646a134f7009b","src/thread/libc=
ap.rs":"4c51b7df566d38dd0f85f81ef53279a745a39f0f4e1154791fd38438e2ca7db1","=
src/thread/mod.rs":"98634ece0b882f123ad887017692f2a4d94a23a1dec278ed660b349=
7cac5cceb","src/thread/prctl.rs":"ebc89b731eb8fd1a8f82a50dbba849061476a4537=
bba8702b29db657d5287ffa","src/thread/setns.rs":"ea9142b1f3a5b3f329683be185f=
960c50e5c1636149e91fbf59e88a897fc607d","src/time/clock.rs":"e59a29f1bed8c31=
c3d5b6fad60f2d4fa6cab8dd8e86148bb3693a5e3a1ce735f","src/time/mod.rs":"43afe=
e938c80d124d04d4ba190c03f4d21d1e3bfc154fff309211e4f6eabe940","src/time/time=
rfd.rs":"f17092b84553741aa2d2b44c6992b5d2c8c96cc2c2007fc9a2c6b2064485e53f",=
"src/timespec.rs":"32a4d930cbc0f6dbd23153290db920671cf4ce65a4a127e176f897c1=
cde42d7d","src/ugid.rs":"6616c6e35b7e43aee5b150f1efae7a50711e0947943c9a9683=
3dbe214ad9e85f","src/utils.rs":"9ae76f8a41d6cc350cdd58c9084b5c3a5a708eeecd7=
69783debdbcbaef442182","src/weak.rs":"c7cf03bf2aeba494b1999ab32183fa8c603ab=
72e254c0e312a67f168877e410d"},"package":"72e572a5e8ca657d7366229cdde4bd14c4=
eb5499a9573d4d366fe1b599daa316"}
 \ No newline at end of file
-+{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
e3db1432ec667f63a7ffc44","CONTRIBUTING.md":"3fd57de5c678db1c972da676a8231d2=
fde9820695ef1f0d53f1e55a3e81d9de0","COPYRIGHT":"377c2e7c53250cc5905c0b0532d=
35973392af16ffb9596a41d99d202cf3617c9","Cargo.toml":"1b9147c312c90f34e2cd30=
9fe687860dff2bb490e3424c938c788bd4b75e8bce","LICENSE-APACHE":"a60eea8175145=
31668d7e00765731449fe14d059d3249e0bc93b36de45f759f2","LICENSE-Apache-2.0_WI=
TH_LLVM-exception":"268872b9816f90fd8e85db5a28d33f8150ebb8dd016653fb39ef1f9=
4f2686bc5","LICENSE-MIT":"23f18e03dc49df91622fe2a76176497404e46ced8a715d9d2=
b67a7446571cca3","ORG_CODE_OF_CONDUCT.md":"a62b69bf86e605ee1bcbb2f0a12ba79e=
4cebb6983a7b6491949750aecc4f2178","README.md":"fce34da91981eafa61d376be05f2=
f8d9619b2c0eb4795913f57a4eb37be9009e","SECURITY.md":"4d75afb09dd28eb5982e3a=
1f768ee398d90204669ceef3240a16b31dcf04148a","benches/mod.rs":"e260e67273aa0=
a37cffdc5cd451699335b8ee656c17275a0d0f2b4563c6018ca","build.rs":"5f93559819=
ca7fe233f01579d51ff5b58cb6e96ef9e7817a3358a9b410d5bbf6","src/backend/libc/c=
.rs":"a0827e017f2bd4a406af521a862ba7783542dd2ebf2d29ec8a62f9e0b991102c","sr=
c/backend/libc/conv.rs":"b66d080db3a4c2756fe722462b543982bf88e5bc8071b9dc98=
d28ec2aee3dbfc","src/backend/libc/event/epoll.rs":"151fea9151a5a8f17d4d1390=
53b38cffae30701a69ad507f71e666c3dfbca869","src/backend/libc/event/mod.rs":"=
7f8547c599b8263eb791890bbe4a0b22fe2676d007ffdcc3e07b2e48d1c994db","src/back=
end/libc/event/poll_fd.rs":"280303b4be61600fa2e25fe59f10dc4e7010942286f6fb7=
cca93954ab63e01d9","src/backend/libc/event/syscalls.rs":"f91bbe7d222987c89a=
2647817f6819dd536cbc4a685dfb794f403543c32df777","src/backend/libc/event/typ=
es.rs":"b966e0a3a018ca2ce507371be900fc73b2814cca450b784583207ad2df473f13","=
src/backend/libc/event/windows_syscalls.rs":"ebfac665c6676c4b803134ab8806be=
8aa2e96bdbc7799a19c544cd9069b35787","src/backend/libc/fs/dir.rs":"9dff590f8=
1fa0bbbc37444c58ebf8fd4f5693bae4453ad6bfafd751c74b091b8","src/backend/libc/=
fs/inotify.rs":"a027a718db8bf6ff9a778c2cfa706850b466240b0a2296d72b9834c0096=
968e8","src/backend/libc/fs/makedev.rs":"89c679a0ef18dd41b3c6223bce0f329ad3=
5bf6cadbf16e47b33fad3f312ba4a6","src/backend/libc/fs/mod.rs":"3d28b803011b5=
7da6315bb747daf0117218687c0cc610358f5dafddf0b7d44d3","src/backend/libc/fs/s=
yscalls.rs":"56a9e8367d3b41b04f1795a12cf5099d5812ab654901168d30545c8e1cba1d=
ce","src/backend/libc/fs/types.rs":"ca25c8271e1fd2ff6c28082884ca112fd5e0523=
b2aa3cd289cd9a399c962a172","src/backend/libc/io/errno.rs":"d33978855c2e0e97=
d5e1f7a04ab10894f9f2c3e329e949f259a757f89942074e","src/backend/libc/io/mod.=
rs":"746647bd864e4ec7717925b6d176cebdb392b7d015070244cc48d92780351dd6","src=
/backend/libc/io/syscalls.rs":"cbd9e9db566597de0a709247c8ba3bd1e6ce266a128d=
639273353c706f0592b7","src/backend/libc/io/types.rs":"2efd39bb3df19a9db5496=
217284f3d2235ddb354fac81dd71861109a56bede0b","src/backend/libc/io/windows_s=
yscalls.rs":"fab3fa099aa89cea56a6edc651dd37750e581534f4f45b04a7e425f130b084=
68","src/backend/libc/io_uring/mod.rs":"2c6478857a0751625edabd61acb841819bf=
ba1093b1faeded15693c805d84952","src/backend/libc/io_uring/syscalls.rs":"5af=
8146d5971c833e6fd657f652c618b31f854e1b0811864fba9b658cb633e19","src/backend=
/libc/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/mm/syscalls.rs":"c04c61ad3d7f3b24d13f89144d7fa0a=
05658cea4763207f9250db4f9362de2fe","src/backend/libc/mm/types.rs":"55478e17=
3b7d82e2c85934fc0dda79c29f46a305228df78f1e90c68ac9d3cfec","src/backend/libc=
/mod.rs":"778083f85aaca00aa5c8ec36b541e0e8a3e693660a6acf4722b4508f015c278c"=
,"src/backend/libc/mount/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287=
b25a5bfe489fa1d07f7cfd7","src/backend/libc/mount/syscalls.rs":"1bc87501a078=
616d0190d2e85de55f3f968b8cb79d49bd9eb839a350eed26089","src/backend/libc/mou=
nt/types.rs":"7e663362dc31c70d966ea9aaf035d3b1cb2f5928546b608243e16e4fcaf50=
857","src/backend/libc/net/addr.rs":"9bdc2febb20785bc26a820eaba52cb546c67c7=
9cb547f08105087cd0f79d5861","src/backend/libc/net/ext.rs":"0dd64877abe1ba86=
b47a2ab34340e3f6cc7b53b22d0bb5e237daf6a82edd46b0","src/backend/libc/net/mod=
.rs":"5f0bd80a6575aba4a714443ca99af76ad15b053f1f8029aa1d9c7fa10e6d9242","sr=
c/backend/libc/net/msghdr.rs":"64825203c09cb60ac4e869cd27a44697f1efe53455c4=
1684279d50d8f0a96701","src/backend/libc/net/read_sockaddr.rs":"b1a72b7bd56c=
d152ed0731f571e4d9411b2974f860fc045319dc74b5b077e569","src/backend/libc/net=
/send_recv.rs":"1450ca958431a5bf3a85cdeef88b387f30d5c1215de2c56d164ccda38f2=
1b36c","src/backend/libc/net/sockopt.rs":"178a6622bab25bf1813d6c17151f48d82=
0e238db8cbd05be3aae563902d6c53e","src/backend/libc/net/syscalls.rs":"654b82=
0d4d1240be1c6a1c56a2cd00d4743bcdf92527054d1000fa1b7ce4594f","src/backend/li=
bc/net/write_sockaddr.rs":"6f06f6cf6089fbc43f93f4f3830468735c92277595769867=
cb6c89e1fe1c299a","src/backend/libc/param/auxv.rs":"fc9476c85482b1d44190289=
224ccf40c96fbf3a2fe3d8554ddb42acb2e97a8ae","src/backend/libc/param/mod.rs":=
"5234b8f1bcb886cca6ea003d411d75eaeebe58deedd80e3441354bf46ed85d4d","src/bac=
kend/libc/pid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded156=
93c805d84952","src/backend/libc/pid/syscalls.rs":"49ea679b96c0741d048e82964=
038f9a931bc3cf3a0b59c7db3df89629b9c49e6","src/backend/libc/pipe/mod.rs":"8a=
a966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/backen=
d/libc/pipe/syscalls.rs":"8affde100f6a9dfc762b79d1e48be5c1039be414f8ef7d5a6=
acaba882a68d259","src/backend/libc/pipe/types.rs":"9f5d0e7b83afe932ea2c4cc8=
7a52e21ad180e1986bf8342d83b8c4a977ca3bdb","src/backend/libc/prctl/mod.rs":"=
2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/back=
end/libc/prctl/syscalls.rs":"8a2684f444a7555098dce2b92270d81cefdae902716c6e=
5d59bd7b0657e8a29d","src/backend/libc/process/cpu_set.rs":"b3d36b01b53b0b6c=
61a20ed8a69d48eccdd90cc17f82f2926ef1e844f002d0b7","src/backend/libc/process=
/mod.rs":"806e26da8d1e7afae502987fcd650f4d348da147b8a2e74447affdca153e2e97"=
,"src/backend/libc/process/syscalls.rs":"9d7028bc55c5dd1fa742c13ea0904fbf95=
094232e7ba2871fa758a93838666de","src/backend/libc/process/types.rs":"fb2caf=
34b17079aa72c04aed0f9a31d534ea8e8b73a80c758b748bf5e38df52b","src/backend/li=
bc/process/wait.rs":"0cc556aed976b4bbb3965f74fd76b8216c755fce25043b7b21ce54=
afa07c9773","src/backend/libc/pty/mod.rs":"2c6478857a0751625edabd61acb84181=
9bfba1093b1faeded15693c805d84952","src/backend/libc/pty/syscalls.rs":"699a4=
c325fc590b8b5dabfe5a9ff386809be14dd24bf35aa6ef581b2bd75457b","src/backend/l=
ibc/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/rand/syscalls.rs":"78c7201e6bcb75e9cab9486d18788=
61319f865de2b2c46437be68690bd17bf13","src/backend/libc/rand/types.rs":"4eb0=
b4cdd0a9b089d1c9f6a25ad1ca97be28a38b7b07a705ec605b773f63f880","src/backend/=
libc/shm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d0=
7f7cfd7","src/backend/libc/shm/syscalls.rs":"60d797d4e85e08e6330e6b8d800943=
56ce377e5484952f88ae2a6e49231c268c","src/backend/libc/shm/types.rs":"2206ea=
c8ee74951b995e1e80f10bf235cc6b04e0a099f4adefce546378838233","src/backend/li=
bc/system/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c05718e85bdc88a36dc805efdfc=
e45d3909","src/backend/libc/system/syscalls.rs":"abe1093f3495668d8576ae5507=
3c74976cffb04d2e1bc20583d7ec12ac848b06","src/backend/libc/system/types.rs":=
"6871e16aee14fe2ae03cea798c3e509ffe44778a9c0e5608fd73e2e015876d7e","src/bac=
kend/libc/termios/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faede=
d15693c805d84952","src/backend/libc/termios/syscalls.rs":"f377dfbf501fbc3cd=
bc9e190dd650c8141c00c1593b8c62901ecf346a0c1a7c5","src/backend/libc/thread/f=
utex.rs":"b666828653b12634bbd7fd709acf69641b648ec40962a1d4f904c5db14d2eff5"=
,"src/backend/libc/thread/mod.rs":"fa710053974d7f16a6c49242ee6c10a3b9e11434=
52b9daeaed8837302a679fff","src/backend/libc/thread/syscalls.rs":"c8e84ad232=
ec1317be989529c24e204c51bb4e1e0212de2c1937b00bc92e5483","src/backend/libc/t=
ime/mod.rs":"38563ea68829ca5a4b1b0695ac8a5c05718e85bdc88a36dc805efdfce45d39=
09","src/backend/libc/time/syscalls.rs":"f82e0725c5af8a52e61ee83aad2c77694f=
2f7a72ac1e6eb284109a70ac6edc38","src/backend/libc/time/types.rs":"d0307994f=
fddd3f21f702d9ae4400750aecccfaf4a01268161dc4fd72de5c373","src/backend/libc/=
ugid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded15693c805d84=
952","src/backend/libc/ugid/syscalls.rs":"8edf91b8790add23902c9f5418da6b072=
3a371677f29f490e0c8af852f0f1a0c","src/backend/libc/winsock_c.rs":"3bf3884fd=
250eca806ffdf96da68e29c133a697810b78b333ea449e523e58562","src/backend/linux=
_raw/arch/aarch64.rs":"2a255c9135bc8a321c180f52b88eb2b158bc9170cd222149caea=
e63c24587d44","src/backend/linux_raw/arch/arm.rs":"165bccb5883d0136e55d4209=
1183765f83d86e9d37a7cb2cec9ae8af32774db6","src/backend/linux_raw/arch/mips.=
rs":"24af364aa93fd4b9917639d473336490a143f0d1723b09f388e72d534160ee51","src=
/backend/linux_raw/arch/mips32r6.rs":"e436a2ade34f2f7c58b8924462b07a2499dfc=
951e1e1318d51759444fb8b658e","src/backend/linux_raw/arch/mips64.rs":"897da9=
ddc877963ad59464d7f81dc59df8a7e91251e6adea14cfd946e2740a1c","src/backend/li=
nux_raw/arch/mips64r6.rs":"3c08aea13c1139fb0dfbe74ca3d0147f007c3aa2eda641af=
b82c46f6aa4f6cd1","src/backend/linux_raw/arch/mod.rs":"37eaeea601d39be00d17=
0856a31a8ec6a27b0d3ac22ab3ee642ab0e45dee237d","src/backend/linux_raw/arch/p=
owerpc64.rs":"dfb001f8636a5e46d728900b0804fe6c374e5e18a6f0e76d7d62e0c07da74=
477","src/backend/linux_raw/arch/riscv64.rs":"41d33242d941030f46077dc2b1bc4=
c7913fe7630d693a5a7eef966bcf38f9d8b","src/backend/linux_raw/arch/thumb.rs":=
"2fd979ab421248c0a4c592bc0cefee63edc26528f469b71b63eaed35356e42e8","src/bac=
kend/linux_raw/arch/x86.rs":"fc72f595ec75768aee248d405f4958a7ba1db65ac9fe54=
b277cd003eab33316e","src/backend/linux_raw/arch/x86_64.rs":"e929036a1f3cf93=
ba538f4523b241605cc7b5e61f84ffe6d9d5cdbcb6f73e543","src/backend/linux_raw/c=
.rs":"5669c25110b62dbb8a79bbceb167732693b2ff7cc82dd78cc68c1c7f3aeec6af","sr=
c/backend/linux_raw/conv.rs":"017ef1ef5044c99acf124db022c134b946c68b4c0150e=
61c7615947e9ce088f0","src/backend/linux_raw/event/epoll.rs":"81add72e957733=
b4233d3e712c0fb05f233f97d8cd96e1b886b27b9d0a8b90a0","src/backend/linux_raw/=
event/mod.rs":"72e46b04637e2d1d2a6b97af616144995399e489d1fe916faf835d72fc8c=
64cd","src/backend/linux_raw/event/poll_fd.rs":"a5773464e9e30227b4046f029a2=
7d3daf2c7bd0045e54565cf1a8ac2a0d61e81","src/backend/linux_raw/event/syscall=
s.rs":"44460b0045bb9d9f48b0baeb009a6b150a2902f9b733e8f6c5a36726b8db2d41","s=
rc/backend/linux_raw/event/types.rs":"0551b18f982e233a0a06d8a9c3dbb29de0c20=
4dcd64dd6f7e88b6c96fa9a9be8","src/backend/linux_raw/fs/dir.rs":"8fe8f139e97=
20208ece606af3bd8097e87e54ea9ce155f228530c8f6acd03992","src/backend/linux_r=
aw/fs/inotify.rs":"9fc5edea36e347041a39e583cb473dd84af40c63fff3dfbb85a1a97d=
2833d8e5","src/backend/linux_raw/fs/makedev.rs":"c6b4505c4bcbbc2460e80f3097=
eb15e2c8ef38d6c6e7abd78e39c53c372139e2","src/backend/linux_raw/fs/mod.rs":"=
3d3a42bbf4d086f806d7d9f6e4b0a49a873dc27f4f03ffca0921f5536acc24e5","src/back=
end/linux_raw/fs/syscalls.rs":"53011d928f6ff77cf505d31744cc41d7d460127c1592=
6006a2859c9e1ae0ffb3","src/backend/linux_raw/fs/types.rs":"0127ab3059d75a89=
6cdda83b3b2005923636273c62664e342f97bb3b3867f34b","src/backend/linux_raw/io=
/errno.rs":"4b010bdc37ab8d8f551529540af011c728d2e9fac1fb897fc9fd0c844dad7fe=
e","src/backend/linux_raw/io/mod.rs":"7ae2324427892cca6f5ab53858d847b165f79=
0a72ec25f3d99fb15f0506c9f27","src/backend/linux_raw/io/syscalls.rs":"831ce4=
24f0032e6891d46503e972313fd7a46f15cb2fbb1f87e40fb05a018e9a","src/backend/li=
nux_raw/io/types.rs":"d0df5a62248e1ba19af0f89f86da7ba2312d97065c2814ddf6b08=
a4a0db23bad","src/backend/linux_raw/io_uring/mod.rs":"2c6478857a0751625edab=
d61acb841819bfba1093b1faeded15693c805d84952","src/backend/linux_raw/io_urin=
g/syscalls.rs":"0f7c9cb7ccddf5687e4b9e5b23558871a452a29ac6095a0184a06c47b9b=
18eb6","src/backend/linux_raw/mm/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53=
539b0287b25a5bfe489fa1d07f7cfd7","src/backend/linux_raw/mm/syscalls.rs":"4e=
469542c88ea15853d5022e7e1d4b8fc291265ca314766d60d9395dad927e19","src/backen=
d/linux_raw/mm/types.rs":"b5bf9bf775d3771e79aa234788fa3d1f25009f3f51cd59c72=
efc4f5e2c7bd790","src/backend/linux_raw/mod.rs":"86f7c3b1d57e57a9e5b5dcc8ee=
24ded5054a917069bd9824f47952b10bca2221","src/backend/linux_raw/mount/mod.rs=
":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/b=
ackend/linux_raw/mount/syscalls.rs":"3947261b5d46b9737f02dc5352c3a3a35c63c4=
61fd75bcd8ae6619dfc0bfb54d","src/backend/linux_raw/mount/types.rs":"eacf5fa=
1e8142f8e10023aeca9fd44f28dd0ca4255069378a129b88ccdba7fbc","src/backend/lin=
ux_raw/net/addr.rs":"fbb6c071a8ebc2c557c7013d36d4b540c1ff6ed63103d0a8abcacd=
8977fbf5c8","src/backend/linux_raw/net/mod.rs":"904b2ccd4228ebcda25db0223b9=
2fb03e4042bcc7b0a202f19410a8a5ff517a5","src/backend/linux_raw/net/msghdr.rs=
":"a88e8395dd5a25c103dc2172d4e7013e5104a6d70091ad78efd286ebc8284acf","src/b=
ackend/linux_raw/net/read_sockaddr.rs":"4ab5d470f03f19a928327603e1d55de8b9e=
21cbe4bfc6ed65d856803092b1c90","src/backend/linux_raw/net/send_recv.rs":"6d=
5d2aec61a3c1b4a5fef1a8a487dc8e163da8988d1237541ed008baa01128cc","src/backen=
d/linux_raw/net/sockopt.rs":"2ea8625ecd68a799c14ed48dec2f3e01f085222b6cc36f=
4916b20143e08ae575","src/backend/linux_raw/net/syscalls.rs":"b231754af1c94f=
61d206839b45f51516e0210761bbbcc1ef68c1fe6fc8a1bbbb","src/backend/linux_raw/=
net/write_sockaddr.rs":"a9374256cb47b3f4d5fec308986a109ce51a521abab31590df1=
f66c04c07d437","src/backend/linux_raw/param/auxv.rs":"ee59d2a618a8c63151681=
4b53655830eeb7ae33cda847d1be382419ba3cdb559","src/backend/linux_raw/param/i=
nit.rs":"6b1297dd9d02d9cf0be19a263d1e0cd084a5fbe723aa3bce2eee5f55e850bde0",=
"src/backend/linux_raw/param/libc_auxv.rs":"d7d2c46feba6d383d17d9d25293ab40=
e39dfefb23533844ee7abaa917923e2b5","src/backend/linux_raw/param/mod.rs":"2e=
6a1a1c00351b9c88bd615aa923f71d76208df5626dd9bea03067f28f81dc31","src/backen=
d/linux_raw/pid/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faeded1=
5693c805d84952","src/backend/linux_raw/pid/syscalls.rs":"eef6aa01830ddd510b=
83f507da2002c03e58318b73744be2c06ebbe33c4f194f","src/backend/linux_raw/pipe=
/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7"=
,"src/backend/linux_raw/pipe/syscalls.rs":"366c730fc3e991bddb9f5a15b8c3917a=
8e6ace6d1d5a9113b2749e476faf6f83","src/backend/linux_raw/pipe/types.rs":"26=
3f6c5621968ed2d33671cca5bdb59eef2882668d9543c2ddbbf6346308e0ff","src/backen=
d/linux_raw/prctl/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1faede=
d15693c805d84952","src/backend/linux_raw/prctl/syscalls.rs":"a18b224307e0d2=
7bda9b7b85c75cd6c7ddfe39f5ce52efb7bb0bf0585b757343","src/backend/linux_raw/=
process/cpu_set.rs":"dfdcbdf35aff6a3e08e7d38193bf18c12ca8aa64eb0dc417667be8=
2dcc0f7c55","src/backend/linux_raw/process/mod.rs":"fb393c70a9c63ef9a6bf1fb=
5a2dc94f07d6b0b6987cc5231c15c607015dafd68","src/backend/linux_raw/process/s=
yscalls.rs":"2699fcffdbc3e5f7ef598bed5a1ea33fcd161f8e9b2f57b320c31da290b4fe=
e1","src/backend/linux_raw/process/types.rs":"6811ba822bc12a1a6336649151b4a=
db1f5d3365684a31c07f01953ea9547743d","src/backend/linux_raw/process/wait.rs=
":"921aee4b0048746087f52615a98edc2aa0fb4b53d6df44be4533098df55d1b05","src/b=
ackend/linux_raw/pty/mod.rs":"2c6478857a0751625edabd61acb841819bfba1093b1fa=
eded15693c805d84952","src/backend/linux_raw/pty/syscalls.rs":"ae09c4aecc0ae=
87b1ca58d82efc58007b9dddaae78460d615f48da19d1cd0f89","src/backend/linux_raw=
/rand/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7=
cfd7","src/backend/linux_raw/rand/syscalls.rs":"a84f70251672e92f253838bf05e=
989434f67373233e88d21d8835cbb792b1fe3","src/backend/linux_raw/rand/types.rs=
":"a21dbb1ab31eed6b59a57520be5a3c603c36d18ea74e67f7527f40835ba209a3","src/b=
ackend/linux_raw/reg.rs":"def5f88730bd625b2298c86559b5a378fce4bf6ce22520474=
0ba087e034abce6","src/backend/linux_raw/runtime/mod.rs":"b2cae8cce3822c3c92=
942f06ea0b68464040dcac33c6f0f7ee392c6269993347","src/backend/linux_raw/runt=
ime/syscalls.rs":"5ad72d57b1258be6f6265be971cf3cd4c5746902f4167069774dcce41=
f33cefb","src/backend/linux_raw/runtime/tls.rs":"6316060560a112c2e9cd9807cd=
ba6e8c91414113a04a739160929ae9a67bba1f","src/backend/linux_raw/shm/mod.rs":=
"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07f7cfd7","src/bac=
kend/linux_raw/shm/syscalls.rs":"3ebf91610b02de0312e1f0f0cc5d56e12b4d937945=
40087b3182cbdf3cb9c8db","src/backend/linux_raw/shm/types.rs":"b831b474aba7e=
b97167c9289f5257776a72b39134b44e67a0ecfcef2394dcd47","src/backend/linux_raw=
/system/mod.rs":"8aa966faf3853d1a93d0ed91f7e5f4a53539b0287b25a5bfe489fa1d07=
f7cfd7","src/backend/linux_raw/system/syscalls.rs":"2af6c2672a6528b404b52f5=
01d9803a63e9f47886d3b5d2d2dc5a71cefa7327a","src/backend/linux_raw/system/ty=
pes.rs":"1ceab8d738a71043473b26e97fa3fd79d588a86d4774cbc9b9e1d4f1447a016e",=
"src/backend/linux_raw/termios/mod.rs":"2c6478857a0751625edabd61acb841819bf=
ba1093b1faeded15693c805d84952","src/backend/linux_raw/termios/syscalls.rs":=
"25a0341ded4657a3a5389250c24b3310642785d386bc51f31696f98f4f1e770f","src/bac=
kend/linux_raw/thread/futex.rs":"0aa0f9f5be6a79de81e82c9f11f1bf8831f682a4b2=
f6cb29669e1591636f084e","src/backend/linux_raw/thread/mod.rs":"6ad4a4b90b92=
34e79900b27ebbe8837e3a7a36aec532912e3e253edce5225067","src/backend/linux_ra=
w/thread/syscalls.rs":"0e3dca63be7322e1e9c58456b28eb8548abb9f08b4436b87b139=
e891c01c446d","src/backend/linux_raw/time/mod.rs":"672724f55b7b7be6a7452bb1=
cc2d28b5f0aaa840a2856fe363acce624e1beefc","src/backend/linux_raw/time/sysca=
lls.rs":"7dc6975bdc30e8fa02f3408b934957e65ebbca281c8c9806e5de9404845312fc",=
"src/backend/linux_raw/time/types.rs":"5f49ee7b201976114c6555f0c5a81d3305e1=
8e726e54edc5a5474641f3cdc278","src/backend/linux_raw/ugid/mod.rs":"2c647885=
7a0751625edabd61acb841819bfba1093b1faeded15693c805d84952","src/backend/linu=
x_raw/ugid/syscalls.rs":"8c86d251db33b399a1d1cbb8e87afe650b78db84f444d32513=
09b7a0480b54f7","src/backend/linux_raw/vdso.rs":"056314f72c71d4b041739337ca=
2098afb7fe070f844327f462c293f43481b75b","src/backend/linux_raw/vdso_wrapper=
s.rs":"0e01221cbc6f0a489e89b0cf2fa376c3826ead8491ee8510476b75e90784f39a","s=
rc/bitcast.rs":"e21c87c292c781b27256c6f5dcf9fd52dd69ed6e21016cbd67ac31a8219=
ebf8e","src/check_types.rs":"e52f710e1cfc12ca13a495f2b43c227b293ff295e1ce3a=
b332935b28a7579872","src/clockid.rs":"7237847231f9d2bd070606262a25de6351de6=
66f95065972967a5f2aae6fef0e","src/cstr.rs":"41af2a4429fe6c67a8883f8a8f63d66=
c90df566abda74fd2b03bcef7b9f24218","src/event/eventfd.rs":"81cbd08f7bdf40a6=
ce1ca692b63da1dc8ba925282990668d9d68f1203e839fa1","src/event/kqueue.rs":"22=
2842df22e66f41d93dacd3cba933810d9313d5ca9959fddabedda9c4312bf2","src/event/=
mod.rs":"7f82a5734d4ba2791054d154273cab48d1cce5ca47d680d44a1b71b96eee932c",=
"src/event/pause.rs":"cac3317286478565298a40788c1ce13c1b71543078a6f09655419=
de325022f6f","src/event/poll.rs":"0ee583dbd457a573a82a06c04a2a24bd2c76e751d=
27a435507d55338e2871327","src/event/port.rs":"4e51ff150e5d17cbd44aa64a38b99=
c15e26eaaf2e350768b5dcacdfde4fa5212","src/ffi.rs":"c2b8b38c02d72749aceb715c=
496726caba1f1fa989ad3856d0103a2fafed89ed","src/fs/abs.rs":"99ecd74dd3447d16=
f142651c74397daca53aa5a21e7daf632937b0860ed63a84","src/fs/at.rs":"e2e017e48=
139101c882df6697f9e4842aed3dbd372c448249c61fd9486163183","src/fs/constants.=
rs":"23923e0fce3221bdac371fe2d05028f30a87dba4f9b4a573b69dc2d6d39320b2","src=
/fs/copy_file_range.rs":"d3b644374390d482b2ff749a2459458872b57d0dcf96703687=
39b7833509a7c2","src/fs/cwd.rs":"9f429a79ace6e17455634da09216ee0ad3d067a454=
1518b3193ae6a8d9ff1e26","src/fs/dir.rs":"347a52f4ca9ac6321c52e802e97ec90d1b=
4c62ec955c8996fc17f8f5aed69966","src/fs/fadvise.rs":"1220e2cf5cf58fc7cc950d=
48738050a052c504f745ca67130daa6410e248230a","src/fs/fcntl.rs":"1d1ee1e0bc96=
2779e1cc1b8b76f39c820746240557daa9e14b47b1799120dc39","src/fs/fcntl_apple.r=
s":"e2f23f038083621bcdecc98d02ce1023508afaecdb2ed0fba5c8b70f955301e5","src/=
fs/fcopyfile.rs":"ce565f61e1fbf2e31086077c2f1d01b6bb3b048915edda87fe9a4a4f5=
e8ff7e4","src/fs/fd.rs":"fe53f211e91352d522ac4f3b553a9366506458e2158295a93c=
5e746618f7a5fe","src/fs/getpath.rs":"28f6970fc1bbc37bb35c84724b59eac436ea74=
07a4522e18c2bdacb1fdd2edd9","src/fs/id.rs":"1b5c8a8baf9a9bb1f895f97189cea4e=
5982a0d35b192afeec6340a6c6222e0cb","src/fs/ioctl.rs":"18b44e1708c7160c3bb7e=
faf27eefb6d11671f91d5008144fc74695d75a226c6","src/fs/makedev.rs":"85520b484=
cb7c15ab71ea1c368578ea3b7e484d82f8510db92b6ce9f7ca341ae","src/fs/memfd_crea=
te.rs":"a8bf1dced54c7592e71da896021338d5092c1693d12cc42e79bac435fab2792b","=
src/fs/mod.rs":"2192ea7f6f81a18d892d3526df00c43d83669f1a1734957ba94cf826998=
0792e","src/fs/mount.rs":"8f6ea2b997dd83c50c90291b9ada3ed77a9ce1ad701c9b0d5=
33b5113b317be5b","src/fs/openat2.rs":"4a95c15dab533a41201b5fa25c8a212956b75=
71d58cad696bdaf45af8aef96db","src/fs/raw_dir.rs":"18ad797876d6230c38d4cacbe=
d081c4028e03ace477d0520d9b226b40de942f0","src/fs/seek_from.rs":"a9efa0feb9a=
c789cf47667e91efee2e3f2dcde16cb3b7a928c99da640fa0e0d6","src/fs/sendfile.rs"=
:"e3b2058741cf4b1698f34d84bb37130cf2b72806d522a16fe541e832cde136cb","src/fs=
/statx.rs":"f925be3d9a179a903549b3ac18038d004f4f2021e46dad4aa2757907aebefec=
a","src/fs/sync.rs":"a3b23543834281f347b0f873bd38154d31d404871188ac08f2b20b=
9196234cfd","src/fs/xattr.rs":"5e222adb52caf69d949ab3f944fb2a482dd6ca3a4720=
0532ca6e72d44cbe8334","src/io/close.rs":"0aa3cd05a8fed8e5244f97b8b6c2e7f65e=
d93a4e5435c6329852bb3da7514440","src/io/dup.rs":"bbebf4633120e21c7c49ecb935=
76cffa7e908f8089deb260f8d97426b469a0d4","src/io/errno.rs":"58a4d20ba0924e4d=
514e3c876fbe08982f1623187642ae14780815e65989c8c8","src/io/fcntl.rs":"41c1b3=
70be55aaa68144dcc8a67b2d53504a5e6d8ee1bffabac2cc64c66a4043","src/io/ioctl.r=
s":"3dffbda413fd380f1580e2e75c531a5f4a0487417ea1c235c23fe46b70e46bd9","src/=
io/is_read_write.rs":"1bfb9ee5d58e0b29b44af12fe2668c7bccc841358698dcde47f15=
19ff9bb73b4","src/io/mod.rs":"75f1d0646be1d4c7c08b5887d8119b0103be8c25c43cc=
d4e0e97015508c0bb8f","src/io/read_write.rs":"77b8058769dc0bf5a88d73acd7ce70=
af1a89c549b00b790e281dc20364bcb6af","src/io_uring.rs":"4e641c9aaeba14890e4a=
354ad8b1fda8fe617923b4d3d685da22721d66a14bdf","src/ioctl/bsd.rs":"32ba3399a=
0fe3f68bb458baafc2a21af9bff655865c7ea70990b7e98a26d3907","src/ioctl/linux.r=
s":"96df90bbc926783f387e8fe1656841d4c7a857fd4e9f41f95492f7dcece33074","src/=
ioctl/mod.rs":"8a5ce2e81feb7c2748df6b69ecf14b07ed1459d961f1eaa8f429face912f=
908c","src/ioctl/patterns.rs":"bd6e309c8b548dfe04aaffe805972582fb56a0b717c4=
5b45447630bdf9b88433","src/lib.rs":"2d9ddb2ab94fd1649932b4e8cb490026078c0b4=
3b513489f3067d279747f4a35","src/maybe_polyfill/no_std/io/mod.rs":"77889bb5c=
5a4f2e50e38379cdaa5d0fef4b0cafc3da056735df01f6deae75747","src/maybe_polyfil=
l/no_std/mod.rs":"ec94a4aab4bc475785e469d10fd6bc95667e1d47d958e9cff3a19049d=
88c8c80","src/maybe_polyfill/no_std/net/ip_addr.rs":"046327ee244f758f2bc31d=
3be305d8cd0dfd8342aac1add8259e999b4b46c4a7","src/maybe_polyfill/no_std/net/=
mod.rs":"486555be5c56cf3e049e65a1ea73aa60839c6f6ca667833e88ee4f360f9606dd",=
"src/maybe_polyfill/no_std/net/socket_addr.rs":"bfeb32d32c176cde76323abcffe=
bfc47e9898fb8d7ce3668c602dc8451086a2d","src/maybe_polyfill/no_std/os/fd/mod=
.rs":"27ef0afbcb0695cbb15101070f417eb51e0ef85ae66ec967d95e80771d507c47","sr=
c/maybe_polyfill/no_std/os/fd/owned.rs":"ab86ffa2693a04f3085770faf395f95e53=
03001711be8b19c44a47a0ac574091","src/maybe_polyfill/no_std/os/fd/raw.rs":"f=
3648c7bd4a6ff94bd823ed9e0d99d398e02f24875cf9b25962736999e7c6943","src/maybe=
_polyfill/no_std/os/mod.rs":"27dab639a765827644005d5f2fcc7c825310606b889cc8=
dd83f54c9528350dc0","src/maybe_polyfill/no_std/os/windows/io/mod.rs":"5bbcc=
05c83fee5026dd744a994e0458469466d5be39081baa62df07753b92fd2","src/maybe_pol=
yfill/no_std/os/windows/io/raw.rs":"4c32609a489dd938a49328b5637cb3bafb96437=
f2f9f269ab66d7d3cb90247f6","src/maybe_polyfill/no_std/os/windows/io/socket.=
rs":"c658f42f24eff44a661f2adfd24a11af80fe9897f3e2af4dc5d2c64808308d65","src=
/maybe_polyfill/no_std/os/windows/mod.rs":"fdb416f8f231a4e778b5f985b9ae712e=
ce5e1a1402963ad1a5f6a8b9843795f4","src/maybe_polyfill/std/mod.rs":"7c16c86c=
c73e226e65ead598e4018238b22000a345040b706bf1e1b3eba115fc","src/mm/madvise.r=
s":"69481cd3354dbffe6cd93b234448e59de6d0fe6440bcf8b12f951f37745bc1dc","src/=
mm/mmap.rs":"3b0abe64a6a606ea41b06acfc1079bcde1542c17475951e5ed900b86c3e598=
8d","src/mm/mod.rs":"b3a6cb838986d45825b912355cedead761211a494ca6f89b2367a2=
d2157e340e","src/mm/msync.rs":"a9092be024ecbfa9c14edb935404513498b0da2ac6c9=
9fc31fe4e58196a95f02","src/mm/userfaultfd.rs":"8073443bd181ff0b3ba4d0b1ae67=
370b4864035a0c8b4898cd709dc47c518ae7","src/mount/fsopen.rs":"160e384e9175fd=
98669cda1cf3590bb195c2ba7e1c724e9ea06e692595e58ba1","src/mount/mod.rs":"5f0=
c9df4727592695deb1cd63ae1de021b03dcd9d0d1b68e1f34d12a7136cb19","src/mount/m=
ount_unmount.rs":"8ad11675e5d762d33fbefbed06a6a9f9e52a9b689bd06662446152614=
321ab77","src/mount/types.rs":"601ae3e10b7dc496fed7f3b40a80e81c6edd7bf13189=
d7be45c3212d4c684c39","src/net/mod.rs":"a6bc55f9e086caf46a7c00783498d73a328=
a66f2a991f1ec65d5f13931377b0f","src/net/send_recv/mod.rs":"7b77a70c0ad2601b=
5da30e8b202e34c6bfc9e10df4ce2b1a35b111522ae123a3","src/net/send_recv/msg.rs=
":"5e889662c076db5aa5041a75302aec04eb471c41570ffeb22b1a6c0760a3716a","src/n=
et/socket.rs":"1296706d964d110be7cd46b61a0a06dabf382a2377907ba41badfe94807c=
b50f","src/net/socket_addr_any.rs":"a9af81e967a91b45e51aec4f46a068fade7035c=
5d19dfaf05bfdcd3b3c32e9bf","src/net/socketpair.rs":"56f4885c31d2664cd16e18a=
9a88792a4912fedd953cec36dba67e8581fd57921","src/net/sockopt.rs":"4f00ff76d3=
cd3fd2e915f51eba59827fb60885d6b0c6d37b32ca4306cb8fe836","src/net/types.rs":=
"d1186106a0a7dab578a9d7f36021ba4c77a50585ad155bd531ebb8553dff3366","src/net=
/wsa.rs":"6e546b42f50a851fc833c57cda76cfb347203ed4b0dea574a3d325bf5a2ebf80"=
,"src/param/auxv.rs":"8602af47a39bb340d319807bdecdb9be8b467101a9ed96061277b=
90234801913","src/param/init.rs":"a31c0e5cea61a1a999767fe74f87c0d59eeb6bce6=
6578b842fe0e0c32be27a55","src/param/mod.rs":"25b10acd5b1da8faa6f5204e6b0379=
b38bfab667916e886cca64bea01a42dec2","src/path/arg.rs":"d87117157ec21f61a5e5=
0b2779b4284fd13dd7db11b20a6bc9e475d0e4a25357","src/path/dec_int.rs":"8ff8e1=
4442c46f8e7a9b80d73973619b4271549b9defd538479bf8c2d93aa72e","src/path/mod.r=
s":"6b1b949c94bcc47e0f08a3f8e8db5b61ff497d0dfd3e0655f51c01d3e4b7dfd6","src/=
pid.rs":"f1c486000c5b1311b2d720cee88f089c17ef9a171709673dd06e6f35f4ff98a3",=
"src/pipe.rs":"9f269090dd0588dc8d3feba4f4a78b61891bce91d3c9b64cdbad9251b06a=
9e11","src/prctl.rs":"19aa584895874ea48b9bbe1bf695b81257b0281df64dfdd91e1b4=
bfa298661b7","src/process/chdir.rs":"911216459aa429fe9f125f1357d6900b43b000=
7835b85c719875d00f79a74664","src/process/chroot.rs":"2b5f6124eb19f26ad27051=
74f7ad50cdc0a5d15abd59ffcf55421228d82130b4","src/process/exit.rs":"48de66e5=
504a00cb375d8f415ce63b6225a3f5204268d40726a7d0fbba43f587","src/process/id.r=
s":"e4733f9e8e4b5f50e98ef7a23802e126f1f14ece8b3d7ae7446c6a66affc6bc1","src/=
process/ioctl.rs":"23ad0285671e8d7ca71a63c50655dbf732ccea8af11d754a0558e023=
6db37e76","src/process/kill.rs":"96d5ce432c19cf2b600d5248c681c117abf53ae94b=
bfca7e75ac533a40e3968e","src/process/membarrier.rs":"1c4c39b359d1d0e9bbe163=
52eedfca9278d9ef298ade8ec00e998617bbcbfed8","src/process/mod.rs":"4fda62909=
afcb081281bd9a8eaf770dc3dfc2111013231ae23b0a1e101582f48","src/process/pidfd=
.rs":"39de2dc7919eeeb53a5980622616140327671cd7e36bcf597aee1749df3a5b5b","sr=
c/process/pidfd_getfd.rs":"1faace75bdbcda57a296806dcfa5487811f8d11dad9e6199=
c98df72feae66724","src/process/prctl.rs":"0130d05362a17a9282f3391189095e1f4=
f51fb56d7a5205906a0011842df4576","src/process/priority.rs":"f135482e71ea8aa=
0daf92b9f238051178a4c904070fa8409622f94155df3c544","src/process/procctl.rs"=
:"430ec397782772d5a028903c2813d3e11f7e577af144b9effd9c42629ac8d3d2","src/pr=
ocess/rlimit.rs":"10b79de3ced0e64059a94c879742d46a35a6176c776d8eed75031d5e6=
340283d","src/process/sched.rs":"ea2acde244159ff3b07038a99f365c07661e7f57c6=
e998af110ce937e9145d0b","src/process/sched_yield.rs":"6565faa3928b66ddc74a6=
5e893e15edfa4b9be4f7e5f5f68527501a7f6bc3350","src/process/umask.rs":"1a0f31=
a842303c978e3f05ec191e2b5e96104c09c6596473b42b1fac34898a50","src/process/wa=
it.rs":"f9c73dde2a66dfbe448501f039396dd26c5d678e4f8cb61c1f78014b7b49fcd3","=
src/procfs.rs":"194678c863ae682143fcefb47601ae3d0b269a48eb9f43cae7f9d7e13f6=
87920","src/pty.rs":"652c412e7280d0344b3f9bfe376c106a7f1b42b898b7af344e6e72=
da268e2bf0","src/rand/getrandom.rs":"1c8166a02a74f5593bb4673ef907524df04cbc=
1568020a5ab2ff7f4aa1283f8b","src/rand/mod.rs":"cab59332aadd9b679f5b22cbb222=
d48ee028af5eb9fd4a4d43922da659b895d7","src/runtime.rs":"39e5b1449bd94b7e89a=
78a1a6e2ea857bcb26e1f2a5e225c0951c7abc4e15d90","src/shm.rs":"b96fe8a05ee5d4=
536464a8843a776d43a938abaf22c772fc35b5373d95644a8d","src/signal.rs":"a294b4=
9d487dafaa42e534f8b1d93e87bec135087676b2ba2ef865cf2fccdaf2","src/static_ass=
ertions.rs":"504cf66f0d5b8e335be02f9ae8b0a355abc98c2c82eec0098bdf0988e662e2=
60","src/stdio.rs":"a5de2d7d9c3c5a901f88b6acf4754687c958a2f3a93c7945c2b8fcb=
948d468af","src/system.rs":"4d7d1eff18094ec85a8ead70a7ccbe8ef78fd7f5705b7df=
e3fa52541e9494887","src/termios/ioctl.rs":"a1ac967f7811a482f8bb53847c37c835=
9f518cd26da9df7b816ba678a0139623","src/termios/mod.rs":"b44b7caa60b6f458657=
ed58a0e0eca41bb4e6d6be4b0f042bbb8ab7056cebe4b","src/termios/tc.rs":"5a56f25=
2dcde4a841fae47a7a6f7890d81f61385c7b512143ece9389652004ae","src/termios/tty=
.rs":"35a5fc2d26501e0e6dde1a755eeccf7b4f3b4702c5bac30e0953220808ef7034","sr=
c/termios/types.rs":"38167a38fb83e84f2845f86b373ecaaa3ebf6c2f91dccd07c10539=
201d6f5070","src/thread/clock.rs":"f49eb7271eb3e6831d9b0c3a01bfddbe4bd69dee=
237bbaa059884de452b29e79","src/thread/futex.rs":"985f9a0dce1e2a4892ae7f26bd=
1bf119ceae3f9fa6b4707e166624fc1cee76d4","src/thread/id.rs":"ad72db4fea9fccb=
728310bbfd01ef8c00f6cc60fa2a750f6349646a134f7009b","src/thread/libcap.rs":"=
4c51b7df566d38dd0f85f81ef53279a745a39f0f4e1154791fd38438e2ca7db1","src/thre=
ad/mod.rs":"98634ece0b882f123ad887017692f2a4d94a23a1dec278ed660b3497cac5cce=
b","src/thread/prctl.rs":"ebc89b731eb8fd1a8f82a50dbba849061476a4537bba8702b=
29db657d5287ffa","src/thread/setns.rs":"ea9142b1f3a5b3f329683be185f960c50e5=
c1636149e91fbf59e88a897fc607d","src/time/clock.rs":"e59a29f1bed8c31c3d5b6fa=
d60f2d4fa6cab8dd8e86148bb3693a5e3a1ce735f","src/time/mod.rs":"43afee938c80d=
124d04d4ba190c03f4d21d1e3bfc154fff309211e4f6eabe940","src/time/timerfd.rs":=
"f17092b84553741aa2d2b44c6992b5d2c8c96cc2c2007fc9a2c6b2064485e53f","src/tim=
espec.rs":"32a4d930cbc0f6dbd23153290db920671cf4ce65a4a127e176f897c1cde42d7d=
","src/ugid.rs":"6616c6e35b7e43aee5b150f1efae7a50711e0947943c9a96833dbe214a=
d9e85f","src/utils.rs":"9ae76f8a41d6cc350cdd58c9084b5c3a5a708eeecd769783deb=
dbcbaef442182","src/weak.rs":"c7cf03bf2aeba494b1999ab32183fa8c603ab72e254c0=
e312a67f168877e410d"},"package":"9470c4bf8246c8daf25f9598dca807fb6510347b1e=
1cfa55749113850c79d88a"}
 --- a/vendor/rustix/src/fs/ioctl.rs
 +++ b/vendor/rustix/src/fs/ioctl.rs
 @@ -77,7 +77,7 @@ unsafe impl ioctl::Ioctl for Ficlone<'_>
diff --git a/recipes-devtools/rust/files/zlib-off64_t.patch b/recipes-devto=
ols/rust/files/zlib-off64_t.patch
index 07d1c65..172981f 100644
--- a/recipes-devtools/rust/files/zlib-off64_t.patch
+++ b/recipes-devtools/rust/files/zlib-off64_t.patch
@@ -5,10 +5,10 @@ it needs 64 bit off_t
=20
 Upstream-Status: Submitted [https://github.com/madler/zlib/pull/764]
 Signed-off-by: Khem Raj <raj.khem@gmail.com>
-Index: rustc-1.76.0-src/vendor/libz-sys/src/zlib/gzguts.h
+Index: rustc-1.77.0-src/vendor/libz-sys/src/zlib/gzguts.h
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- rustc-1.76.0-src.orig/vendor/libz-sys/src/zlib/gzguts.h
-+++ rustc-1.76.0-src/vendor/libz-sys/src/zlib/gzguts.h
+--- rustc-1.77.0-src.orig/vendor/libz-sys/src/zlib/gzguts.h
++++ rustc-1.77.0-src/vendor/libz-sys/src/zlib/gzguts.h
 @@ -3,15 +3,6 @@
   * For conditions of distribution and use, see copyright notice in zlib.h
   */
@@ -25,10 +25,10 @@ Index: rustc-1.76.0-src/vendor/libz-sys/src/zlib/gzguts=
.h
  #ifdef HAVE_HIDDEN
  #  define ZLIB_INTERNAL __attribute__((visibility ("hidden")))
  #else
-Index: rustc-1.76.0-src/vendor/libz-sys/.cargo-checksum.json
+Index: rustc-1.77.0-src/vendor/libz-sys/.cargo-checksum.json
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---- rustc-1.76.0-src.orig/vendor/libz-sys/.cargo-checksum.json
-+++ rustc-1.76.0-src/vendor/libz-sys/.cargo-checksum.json
+--- rustc-1.77.0-src.orig/vendor/libz-sys/.cargo-checksum.json
++++ rustc-1.77.0-src/vendor/libz-sys/.cargo-checksum.json
 @@ -1 +1 @@
 -{"files":{"Cargo.toml":"51dbfac535d3cb6c0369634495b89c5614863a72beb0cfe57=
1711e4c8e01471d","LICENSE-APACHE":"a60eea817514531668d7e00765731449fe14d059=
d3249e0bc93b36de45f759f2","LICENSE-MIT":"34c467b6945a22696d060b8fdd2379d464=
acb3408d4c599d3dc5fe4fa1b4c84f","README-zng.md":"ef6cc5a0c9d661cb231c13bbfe=
0754cab634c6747f5932de980323b6ea2c3833","README.md":"5c4f2d88726998c4b0f61e=
b599562327247fb778c975919d36907d2b5b9332db","build.rs":"bb0c3d8d5c7c01b735d=
737c9e11a6574c053bce18b5742679e985282ad896bef","build_zng.rs":"059da8bf3ed5=
f2bfa613874b8f6720643ae948a811fefaff8237e95e0771cbc3","src/lib.rs":"8f9f42e=
8c80e134fa6f5724c677a341689e2e16cbe93a15495a1b4d8bfa90c49","src/smoke.c":"1=
0607c81b73811bfcb9718767312bf97ba2ccf7048ea2f18a2085aa06ad7f91b","src/zlib-=
ng/CMakeLists.txt":"6f1e6fc8607a11cc5928013c773d77fa3c56be7cd8f7a18db60c884=
0d662f9b7","src/zlib-ng/FAQ.zlib":"c524f4f86d336b3de71dd6977afddffa9c02fda5=
c26db4dfefae44959e7614a2","src/zlib-ng/INDEX.md":"989545e90d8e9ac149034f762=
ce78ed8976ebf9324326228dea37ca190154609","src/zlib-ng/LICENSE.md":"d3c80be0=
55d94d798eaa786116e84fa0b010bc11420b5d2060d978ea77845436","src/zlib-ng/Make=
file.in":"082db1c1c2245fd88a0c23c81936ccaa5a7322cd4c34bdeaf20ee828bd80413d"=
,"src/zlib-ng/PORTING.md":"097591000d86f6265fea6cfcd22635984eb6c9f54e8690ca=
2667cfb92a11919d","src/zlib-ng/README.md":"21c8b379c1c4ac3087fce72e18a011cb=
9bc0a5cfade79ed4600c2f48d3555af6","src/zlib-ng/adler32.c":"b96656d1fc0133c4=
4caeb3509d545d0b68580e77157b8c6f0fd6dcf681726ea5","src/zlib-ng/adler32_fold=
.c":"66b32963c96e43c84b53eff737d11186bf165e04a48e9c3328faa5c86ce8128c","src=
/zlib-ng/adler32_fold.h":"c40114c2c742b6410e54b58ea02533fe6e9ae0ca62d3453e5=
d2a1725d33e2be4","src/zlib-ng/adler32_p.h":"fa8b96371128c54ed9c2a0617500673=
8d395d380672b4894c32fece37b8a96a0","src/zlib-ng/arch/arm/Makefile.in":"c653=
a8388d3b8ade0e3f93b252c4514d05408edc6e75314845c7b044776088e9","src/zlib-ng/=
arch/arm/adler32_neon.c":"bce2fe7d3a5f663ba2894d3c9b13151c5cd4c16bcc1d31ac3=
2a85713ecc20f8c","src/zlib-ng/arch/arm/arm_features.c":"3693173e8c3cd2c86ab=
bab3b4c5d1e1ca1633197a05d2959061419a4395e4c2f","src/zlib-ng/arch/arm/arm_fe=
atures.h":"874fc56f6eb7e7276fb906df70e973a00a887251301075e152d963c495908daf=
","src/zlib-ng/arch/arm/chunkset_neon.c":"e31826f00558086cd74b01f04a327c393=
73e06beeeebc1edf1698761822abf70","src/zlib-ng/arch/arm/compare256_neon.c":"=
7eec4ca0415dec895a461a4d1fcd3068e0d68482d048257022511b3490372ca3","src/zlib=
-ng/arch/arm/crc32_acle.c":"640805d2e38d05c3baff85fa1a8b252a3e803acd95fedc0=
7b3e506e41536ab13","src/zlib-ng/arch/arm/insert_string_acle.c":"d57af9c4db6=
e4dae55288f86a2c19388c402ec2a16e7ded28775ae6b4e55352e","src/zlib-ng/arch/ar=
m/neon_intrins.h":"0d7fe53fd751ef1b1d79899749dc4b223c7e29c3995bccfb0909f17a=
63248b8f","src/zlib-ng/arch/arm/slide_hash_neon.c":"7c4927c0dc8b28c5fba1efb=
30273653e71172ce051a0341ce2f1d2c0bbfa418c","src/zlib-ng/arch/generic/Makefi=
le.in":"93255a212569673a3ce9e7fbaba789b3cd82375e7f6459c22c84bcb7a12097c7","=
src/zlib-ng/arch/generic/chunk_permute_table.h":"3f1e09e697a9b2dff4395aca35=
6e61765c44511a9dc653abb6998671afd20ae6","src/zlib-ng/arch/power/Makefile.in=
":"015cb5635da6dbcd54c6bcef5d8958c6ea5369b55797e342a2632b0bf03bc4ab","src/z=
lib-ng/arch/power/adler32_power8.c":"e5a5bfdd9963e8f906e36978f1a65513990874=
0559da2b382ddd5f3e2ffe6f56","src/zlib-ng/arch/power/adler32_vmx.c":"841a7e3=
792d1f68a0925969d6f9737cfb2b650b3a82721a88f1e5648f7b0a58a","src/zlib-ng/arc=
h/power/chunkset_power8.c":"569a7dc686a0d80686e516ec8fb7c2331225f706b37ccbf=
0874e6d822e82f806","src/zlib-ng/arch/power/compare256_power9.c":"cfdc33f5e6=
05fd41351423fda0eaf7692f9e9f0083d6c4ac870c6e467d534f48","src/zlib-ng/arch/p=
ower/crc32_constants.h":"d73e3b9025de9fade7fa3ba2bbf5f56a1499a84c53d8ca7f5e=
744a0714d8599b","src/zlib-ng/arch/power/crc32_power8.c":"add20ee86ff5c28396=
ee2e7f77d825d7e425b89467331953690c40f40b5dba41","src/zlib-ng/arch/power/fal=
lback_builtins.h":"78a8da60bad8ba01278e495482108adabf9e96bdb214e869b61ab1f6=
3f518c9b","src/zlib-ng/arch/power/power_features.c":"4dc4c14dfa2d3333c73fad=
7b1f7a79d3fff68c1d1fd643012faf82bd4114553e","src/zlib-ng/arch/power/power_f=
eatures.h":"c9c47cfcfff347e79f83f56a0677565d40299e03ffbeb918c4ae69518d290ad=
a","src/zlib-ng/arch/power/slide_hash_power8.c":"58d93cee1a2cf14f13a8e9e31b=
a5149fe2b1e069846f52ac1f11c42cfcbd49a4","src/zlib-ng/arch/power/slide_hash_=
vmx.c":"1b6297a9616456ba534bc1d93afcb99e36dac357be68aed106bb71dfea621a86","=
src/zlib-ng/arch/power/slide_ppc_tpl.h":"c8900c594591e1aba3188f97c374e5561f=
e1e96f653c668352b25647e449f4c0","src/zlib-ng/arch/riscv/README.md":"989b422=
6896c0b040edf4c4a108b9aea872b8df9823a78eda37b1f911fc920bf","src/zlib-ng/arc=
h/riscv/compare256_rvv.c":"7fd32e27e201efc8db2b2b3e7a24ffb5d6505a15c84e6dae=
e793a8f4a7580425","src/zlib-ng/arch/riscv/riscv_features.c":"a3379c7a8b2911=
b90659ca937429a692e5f1cade31be7504e2ba05eab1f234da","src/zlib-ng/arch/riscv=
/riscv_features.h":"03ee5f318b90da36a945df675ea383e3b02a0eb7ef38677582d6ca1=
8f3fe0cdf","src/zlib-ng/arch/riscv/slide_hash_rvv.c":"87c1a2acf51af38f2d337=
b482fcb72d080b0897e48abc9753b51d40facd9a1a1","src/zlib-ng/arch/s390/Makefil=
e.in":"8cb582f8e6ccd9146f64214a513e546122976c60e782cede19b282bf3b519235","s=
rc/zlib-ng/arch/s390/README.md":"0dae0e510935c5f91e00dfe0d57a9b7a82891ff59e=
dbd14b64b54c950327d708","src/zlib-ng/arch/s390/crc32-vx.c":"c5250cb1df20ead=
cf0c56ba68e0dd7cf43d936f92f245aad2bfb519988f902a1","src/zlib-ng/arch/s390/d=
fltcc_common.c":"9a701d5f973c07e054797ed030851171abaf20a40a4ab2359914c737b0=
ab9671","src/zlib-ng/arch/s390/dfltcc_common.h":"1d042b79da6bbcf4e1f5b32ca0=
17bc49fa89129c7a925ea17b931de34012ef18","src/zlib-ng/arch/s390/dfltcc_defla=
te.c":"146569d921d68fd9af7b67a74bcf0aa41108a4072564629db7ad6c2dc8a429ef","s=
rc/zlib-ng/arch/s390/dfltcc_deflate.h":"309d7c9bc4e5de3196ebe61a2e5c17e07bf=
b66bb8a170562e90e9105e68ab302","src/zlib-ng/arch/s390/dfltcc_detail.h":"c78=
dfcf54d21133097b2e2dbcf6821034089b5e1c5598b4a529101f0a8ccad5c","src/zlib-ng=
/arch/s390/dfltcc_inflate.c":"b1eb56def7acf39aabb7abea8249a48c4af0dfea7a63a=
c380e5437d432ff9d9e","src/zlib-ng/arch/s390/dfltcc_inflate.h":"06dc026f9910=
22a7be73865a554785b31d167261c4006ca6438de7ca31893ceb","src/zlib-ng/arch/s39=
0/s390_features.c":"fd99ba0abc73a37168a5c369a0714e3f35816a792438bcb1e8e60f5=
dd2983293","src/zlib-ng/arch/s390/s390_features.h":"f65396333635e937634dff4=
2a43a8bfa272f53ac88e763d52d4c56241b1eaab9","src/zlib-ng/arch/s390/self-host=
ed-builder/actions-runner.Dockerfile":"5d4c45e9929fd9736640aea294f1d13f346f=
d52a4f4771073be32abe96ada971","src/zlib-ng/arch/s390/self-hosted-builder/ac=
tions-runner.service":"62a19075adeddb3bee57bbac81c7acadacbf9c288e2b497e36ff=
7f2b3daa7558","src/zlib-ng/arch/s390/self-hosted-builder/fs/usr/bin/actions=
-runner":"f647e18728ea15fe927ac9f8cba83a5b343654a0e91b5ebe653bae7af7375110"=
,"src/zlib-ng/arch/s390/self-hosted-builder/fs/usr/bin/entrypoint":"add4ebd=
c4f06ed15bb1de12a8c9ceb370a60baebb0932a1026a75433940ad3df","src/zlib-ng/arc=
h/s390/self-hosted-builder/qemu-user-static.service":"54551049f6181da88700a=
2a944a72b0af3b8abde876fa28e1348deb5eb96c91b","src/zlib-ng/arch/x86/Makefile=
.in":"ad6e71fe6e42005b65db8454b0ea0a6c9ee91664698c08729c01e6b00d0df933","sr=
c/zlib-ng/arch/x86/adler32_avx2.c":"e30ed4f1cce2d9dd6ebfcca1a67d5a7d64a5c59=
bcb0649690991a3c174780a38","src/zlib-ng/arch/x86/adler32_avx2_p.h":"45e6264=
edffc737081f55a5b5e85b28d9db0b27b63183ffbb492f8c11bc670a2","src/zlib-ng/arc=
h/x86/adler32_avx2_tpl.h":"3e58991fd1dc329b4d8d4cbf6159cbe592acf78f365d0f71=
c3ebe937840754b2","src/zlib-ng/arch/x86/adler32_avx512.c":"3dbae3d7679d4018=
0d25f30e0743dd189a2ef5e485a52ba7da70e2dc65e3a963","src/zlib-ng/arch/x86/adl=
er32_avx512_p.h":"1b4beda11693ac03e4b20e054a765df427f845a279bce547b8208d20f=
5a302bb","src/zlib-ng/arch/x86/adler32_avx512_tpl.h":"8ebfedeecda8efb9036b8=
4e411701ae8e97ddd32f50484a7249981374ee5aba2","src/zlib-ng/arch/x86/adler32_=
avx512_vnni.c":"45dcd7247076decd983909bd10451fc0a2709f576fae5748e6d26c0a4c0=
d2db8","src/zlib-ng/arch/x86/adler32_sse42.c":"1d2dc53b05ac75667c6d1c625c8c=
391e4851b28cff9e97ebfdb774767581fff2","src/zlib-ng/arch/x86/adler32_ssse3.c=
":"821799e1489b20343584f5476b23c587d4f3f2e2cfebaf75239276084c613339","src/z=
lib-ng/arch/x86/adler32_ssse3_p.h":"5aab2f802ba6bdebc63b411018e5116fe26d38e=
90adf353646b65af4ebe7fa40","src/zlib-ng/arch/x86/chunkset_avx2.c":"64acbfd9=
716e4c9d0864262eee000d3f5eada073a21124d0856b2c4efe60da44","src/zlib-ng/arch=
/x86/chunkset_sse2.c":"a400a128a84185c945f9ac9303e17c944f2008085d7a4402d279=
bd59893dc89a","src/zlib-ng/arch/x86/chunkset_ssse3.c":"e44ccb9fd6ef4b49a429=
431c735aa89a85bb92471629c11e6f18c2978ef12a36","src/zlib-ng/arch/x86/compare=
256_avx2.c":"2516d00faa6939e61dbb0978a9c4c81f9e3a42fd053b2a2241673da7cf4fc7=
81","src/zlib-ng/arch/x86/compare256_sse2.c":"3b983708034f33b5da49f6f504135=
1a2e66358c76645c552f6e4dc37fb890a80","src/zlib-ng/arch/x86/crc32_fold_pclmu=
lqdq_tpl.h":"1b3b79dabff0bf7ecc3b07356c5aeb6ae1fece0fd70ac7e235aacce3da77ea=
19","src/zlib-ng/arch/x86/crc32_fold_vpclmulqdq_tpl.h":"7eddba31e3d1b1808fc=
6df9f96ada03c59952961af895d8538f5a8292392b5cc","src/zlib-ng/arch/x86/crc32_=
pclmulqdq.c":"f247408c353bbd0fcafff23fb97aeb4d9a72e0a416effea566183b9b5dbed=
f7c","src/zlib-ng/arch/x86/crc32_pclmulqdq_tpl.h":"db8ceda87e46bb3dbe6f0eb1=
b27f8c2b1fcfabac4208701aa0e567161a7963bf","src/zlib-ng/arch/x86/crc32_vpclm=
ulqdq.c":"870d06ca9fa7b48db4b720d2fd6262094200cf6180fa76a601d17c722bf0e406"=
,"src/zlib-ng/arch/x86/insert_string_sse42.c":"6c43b53a2a83c4b7f7e0b6ef0c92=
8e1d668bfb902ad5c9f71d53d137e8506b43","src/zlib-ng/arch/x86/slide_hash_avx2=
.c":"9740a36bb4dd90f40394344026be9a13f3acb6e85e6b7681c30fd7f7cbf8e28e","src=
/zlib-ng/arch/x86/slide_hash_sse2.c":"fa009305a1c82708638dff25e037067656350=
303b25f5774489417e096c30ecb","src/zlib-ng/arch/x86/x86_features.c":"8ffb6d5=
d8c02ae9a571b0b865d302768498d0763fb69cae73d4da0d359551395","src/zlib-ng/arc=
h/x86/x86_features.h":"6429fa7345a9892633c884f7fc26f9558d86c77df9e8589ba962=
3a27e1d9fd57","src/zlib-ng/chunkset.c":"531f58c77c184b225304888ddf1930a76be=
efbe4a7974edf0efeee7b6662520e","src/zlib-ng/chunkset_tpl.h":"9919e10e9c2244=
316e13de41b66dc333d9b0413af6265fa860768eefa39ce033","src/zlib-ng/cmake/dete=
ct-arch.c":"7e716c56b3681979e182993b35f9b85d5f01bd332b4e3eb5abf652641ae62c5=
a","src/zlib-ng/cmake/detect-arch.cmake":"dad643682b1fca96f53626bde612c6ee9=
dc0ad098abf6f2778710948fac02a55","src/zlib-ng/cmake/detect-coverage.cmake":=
"4664d51152d51282ae50621f4d510ab72cf8978b266c614b7c5361750db6d1a9","src/zli=
b-ng/cmake/detect-install-dirs.cmake":"4c8e72cee23ce9c6db02566a31fc7a78f0be=
eac6f09c61c2d90a1cff3c083db1","src/zlib-ng/cmake/detect-intrinsics.cmake":"=
4bb5f94ffb33e6e50c5c12fe4327bbc7a9310ce96403d1a6fbb3565ffcb8d4e5","src/zlib=
-ng/cmake/detect-sanitizer.cmake":"a40650743dfd0b56c2afbfadb53e5d1470ef4885=
2f2fcdf51084b6485534f87a","src/zlib-ng/cmake/fallback-macros.cmake":"a8c8f7=
0e5483177280cbebf99f929a7cf5ffe2b79fedb79eed570ecafc78effc","src/zlib-ng/cm=
ake/toolchain-aarch64.cmake":"46be0bf580a49a528c72005484655afad1de3705b39a6=
6a7b0c213b0fa81cee6","src/zlib-ng/cmake/toolchain-arm.cmake":"05e38076fd6ff=
b9785ff9844ccecd26436c9dc4c25b7777b62e5f52e788c3882","src/zlib-ng/cmake/too=
lchain-armhf.cmake":"1a2029163a57415eec9a5dd5f45d3254d349e97b1beb5d16876b74=
1717673341","src/zlib-ng/cmake/toolchain-mingw-i686.cmake":"df9000354b820d3=
713d1469edc9f94cd095389b0cca83965730b8e64857fdf3f","src/zlib-ng/cmake/toolc=
hain-mingw-x86_64.cmake":"ee316e6e3202919da5d497f9e246466fd715fcf079cb5b4af=
c4774089d1fefad","src/zlib-ng/cmake/toolchain-mips.cmake":"0d0d00b809a30021=
bb4b9e3ace7371200bb4bfa6509813c829ca0cb569c7af68","src/zlib-ng/cmake/toolch=
ain-mips64.cmake":"f19574aa068ca4374b657ce7bd0517b9297c622144814a095e26db05=
f0a1cd20","src/zlib-ng/cmake/toolchain-powerpc.cmake":"9bd6fc58ce5b70603657=
f2c195c4a5cf52fae96ad63ac787978831c5858f762c","src/zlib-ng/cmake/toolchain-=
powerpc64-clang.cmake":"aab0b9e0f19a281dc99f4dfa5675976c40b5fb7f8139dd2eb09=
01fdf3cedc952","src/zlib-ng/cmake/toolchain-powerpc64-power9.cmake":"57c789=
c468e733971c2654faf34f7dfc9dd1e0e5bcabbd609dcd01dcbd25c487","src/zlib-ng/cm=
ake/toolchain-powerpc64.cmake":"917fc5eef84921d8b38f43c2b4f60870965b4eecc8f=
018c7b3499e1142c715af","src/zlib-ng/cmake/toolchain-powerpc64le-clang.cmake=
":"47ac4a05b61210a83c7845a5522b91740bc8a7bb897312cc37131f85bae9e1b5","src/z=
lib-ng/cmake/toolchain-powerpc64le-power9.cmake":"b295b61ea248d8ef98d9276fa=
d3db143a6fb80ab738c54bf88cb594d82c70a8d","src/zlib-ng/cmake/toolchain-power=
pc64le.cmake":"5b2edd36d62de513db2d32bfbf779979d81ac527b981cc3379a4e933fc5a=
94d1","src/zlib-ng/cmake/toolchain-riscv.cmake":"d7b4ac4be3651aec2e55788d81=
5141482d4fe92713713fdaba9215dbbbc9b88a","src/zlib-ng/cmake/toolchain-s390x.=
cmake":"cf52cecea7bd2a9d1ff5fd8edcb03c531e3b404bbcd15a15dec2e0e19936f2ac","=
src/zlib-ng/cmake/toolchain-sparc64.cmake":"e543062485d06a7e0fec8135887c5e7=
3363517fa4babc23ef7b780916d75afda","src/zlib-ng/compare256.c":"4890f97239f6=
3dfbbc986ddd05039798752ec0ad530ff7d25978deb44f774ad5","src/zlib-ng/compare2=
56_rle.h":"30fca191b0474e1549d3ce292bb11ee90dc3dc9fc685932cec3971c1d0e8f652=
","src/zlib-ng/compress.c":"f7c69a4d2f3b87ff0094115977dde1cd17703cc9856ba19=
489dd94e0ed16b646","src/zlib-ng/configure":"52ab63f965b0af1529e3606e632ff04=
0b8f24bca3240a5b3d0640567f681cb8f","src/zlib-ng/cpu_features.c":"aec359d85d=
64c2ff88132a123406726bd966e0d56d0dc8ce1d5c3f25e1801440","src/zlib-ng/cpu_fe=
atures.h":"ebb9ceb1f43fa75edd6050d649b6a66e9ec4d14bdee1b9d63dbe84df57ff853e=
","src/zlib-ng/crc32_braid.c":"8a33cffb026b82a027b45e041935836b36b2d075796e=
5498e33ce64ec0cf93e8","src/zlib-ng/crc32_braid_comb.c":"217741d3c1c0018bb12=
ab22c987804634605f5b7ad6bd243e25eb0499c80af5d","src/zlib-ng/crc32_braid_com=
b_p.h":"6c8035e05d30a6241be55467fc59e4d7deda6b618b955a11339ffee08a39c75a","=
src/zlib-ng/crc32_braid_p.h":"951cbd948664498dd8a56393bc88debdad8b21dcc8e1f=
16d883c07170e4adb4e","src/zlib-ng/crc32_braid_tbl.h":"e22af112e3c1c8bb4065d=
39fe678eba71dd08893eb06f9414b02f4cf5a6f46de","src/zlib-ng/crc32_fold.c":"f6=
363abbd1e167bc7a6fa8f92e5211f4fa3e70d30fa5e10fa6f416f5db372678","src/zlib-n=
g/crc32_fold.h":"42412c5029057579148a2238b0bc882f294f661d2af102bd9213531894=
302f29","src/zlib-ng/deflate.c":"6afbaf9a03abea62eb03169d5e09cea64372339bbb=
cfe63b97243097513d06fb","src/zlib-ng/deflate.h":"552a9da96d0cc5b50180e24259=
7e1effc3ab4c2c994d19e854339d47e951049d","src/zlib-ng/deflate_fast.c":"52648=
097b16070c156c27d38566720eca08d48e35cd89a80f196f0e77951112a","src/zlib-ng/d=
eflate_huff.c":"923d316676c00f307a7d6a58d77f9364f06607afcc686b464b557ff5478=
f8b6d","src/zlib-ng/deflate_medium.c":"d3172c1ea0ae1bc2e3b7691b005bbae35e84=
b7588ef2f5805b9dd0c4ccecbd67","src/zlib-ng/deflate_p.h":"2eaac98e9232959c73=
0d84a408bed641be817dc3468aeb427062d06b02eb80b4","src/zlib-ng/deflate_quick.=
c":"3825eb4d22a150f9cdaba93db890d95b8d9e9d0f3f10524fb27a9a1289aa4c0f","src/=
zlib-ng/deflate_rle.c":"5dcc0496f74b5ce677ab5a58ea232d0ba653102d2f71cf35daa=
6069ef88b7af6","src/zlib-ng/deflate_slow.c":"5449816c381138eb07cd54ec7c0c77=
fb811f4f274c27bf15d26e008de6a9eb5c","src/zlib-ng/deflate_stored.c":"89b81c0=
9be2ffd84138940ac6c4e9688f956603b45eec6d0d52d579cac3f15e5","src/zlib-ng/doc=
/algorithm.txt":"0d21a0a4c47e512743389628d1385a831a5e5ff716491095a382b92328=
7f4223","src/zlib-ng/doc/crc-doc.1.0.pdf":"064f9252d6e2e15ea56c2bd18e160e5c=
9c84bcd137c11a7af497aaa511ace998","src/zlib-ng/doc/crc-pclmulqdq.pdf":"3cf1=
8f738dd0da7e5a28ff999d987bb61ac42cce354bbee1364d06fb3944f7fc","src/zlib-ng/=
doc/rfc1950.txt":"8f0475a5c984657bf26277f73df9456c9b97f175084f0c1748f1eb1f0=
b9b10b9","src/zlib-ng/doc/rfc1951.txt":"5ebf4b5b7fe1c3a0c0ab9aa3ac8c0f3853a=
7dc484905e76e03b0b0f301350009","src/zlib-ng/doc/rfc1952.txt":"f7c810fd9d719=
d002d605207a9b880600f71d039b9626c5b4b03f2122438dd2d","src/zlib-ng/doc/txtvs=
bin.txt":"47c273bb22c9773248d380549a330e5c262266b1292154b0d3014f731cc73f47"=
,"src/zlib-ng/fallback_builtins.h":"236c86c080c4641cd547227b6e429d5f20dbec5=
1d4f0c286d9b96f5abfd760c7","src/zlib-ng/functable.c":"66f8297c181705a26688b=
8505c939e1c7cbc85aec15babf1ea778e4ed2c966c9","src/zlib-ng/functable.h":"032=
1e45c3fd9680086937ec4bbb7e1469c714cd483d1f86c2536869ab6220e74","src/zlib-ng=
/gzguts.h":"43247dd3af08b7d6dcb68972f277e0ed9170e80700dc3aeef0c3865cfbf5ccd=
5","src/zlib-ng/gzlib.c":"084a1c493ecc20e5162c66f9ad22415647f3bdd3aa7df5b83=
87e6a01b3a4db3b","src/zlib-ng/gzread.c.in":"b87e746d09375a0bf619288c63dba14=
2ea2af0fb8e72f3fb8bdab34c33d66203","src/zlib-ng/gzwrite.c":"9f474aeefaf0150=
d8871eb9202ebd43a28f18bdf39eaca4f35cfb52227e74c63","src/zlib-ng/infback.c":=
"db99c5b105c34c7c2967bd97e16f976217530c22d6545e61cbf657522e24de87","src/zli=
b-ng/inffast_tpl.h":"51622f34e8808798a43412b4fde62ebd58ba012f5452bf2ad9a800=
1c98539166","src/zlib-ng/inffixed_tbl.h":"a94225335396245e9f0ccb2e9b4b334fe=
7ee0111ed8e32a26bcd52187f364314","src/zlib-ng/inflate.c":"a81a70836d34bf577=
b27e297d0da94453599d82830de856eef1d95d01e8679a5","src/zlib-ng/inflate.h":"1=
750ab33be4461f2e6b8e43bef5da11f3db49d5d2a3eacd03d881d33c1df7def","src/zlib-=
ng/inflate_p.h":"4a31088faf818d2615de31b099e8f55ee8463166477d6cb5d6763c913b=
6acef9","src/zlib-ng/inftrees.c":"03f4272dfde3f3241209b298113a1a95349a60984=
6741ff3c03a28c2aecbeddd","src/zlib-ng/inftrees.h":"4adfd2acaff7aed9ad3dbc0a=
d0dd01d2a333e0acc2927d904bc0c8f4fa00f45c","src/zlib-ng/insert_string.c":"7a=
9455cbb3ca8fe6e7111471b9f4c0a32fb49a6d0ec589b027dc2cb2b65c8dce","src/zlib-n=
g/insert_string_roll.c":"4d05f19591a5c29d2da398e10e9d0b050d738cc8838d8dda4b=
eb1cc7281ede07","src/zlib-ng/insert_string_tpl.h":"f3900618c011aceed09b5624=
7ce6aa00d541c137c86c79b3620bb0a9d0e73d26","src/zlib-ng/match_tpl.h":"1e20d0=
ef73a5826606240f4efd2a8e993d203f376017397342b9899b1f919276","src/zlib-ng/sl=
ide_hash.c":"74adb34a4a35331db810dbb5d740af10cc1db7d24a89ea387aa2dec956a05b=
2b","src/zlib-ng/test/CMakeLists.txt":"7a57442ce2c352eec025ffb4287501714c2c=
cd7596847d1f17c0c9957695565c","src/zlib-ng/test/CVE-2002-0059/test.gz":"60b=
f96b8f433bd7e057ce3496aceaccd70ec80f596a4aa8bcc7786056705ce66","src/zlib-ng=
/test/CVE-2004-0797/test.gz":"38caae524705f676bde13a8df9fc8c7d2fe105ba6bdba=
b62a405b0276fd3aa2e","src/zlib-ng/test/CVE-2005-1849/test.gz":"e4d5a60617df=
4b5dd44eda94751ce1eacdb325792bba6e3cc4676719a3adf742","src/zlib-ng/test/CVE=
-2005-2096/test.gz":"8f702d4861aa3ec98ac03a59ff26b430939630cb5cd4266d2658d3=
b836d576f9","src/zlib-ng/test/CVE-2018-25032/default.txt":"d7f8278db331c47b=
d1208bf41e7903cbddee4f7b47c666c40afdd3c96237752e","src/zlib-ng/test/CVE-201=
8-25032/fixed.txt":"3b27a98edd2f3f580033f9add11d3469d7808c969a1128ee00c18ac=
7a12cef57","src/zlib-ng/test/GH-361/test.txt":"358497d0a7251ea42101dc77b023=
37f46fd89af09643a8288e2a3082e5d24128","src/zlib-ng/test/GH-364/test.bin":"a=
f5570f5a1810b7af78caf4bc70a660f0df51e42baf91d4de5b2328de0e83dfc","src/zlib-=
ng/test/GH-382/defneg3.dat":"b22bef6b7392401c9e7b079402c4a4074053d7a914d050=
400e37fd7af6fe26d5","src/zlib-ng/test/GH-751/test.txt":"b83d833803b7bc3124f=
b2a0034081f0b999ad10c33a8dfa3bfd181dc078ae3ee","src/zlib-ng/test/GH-979/pig=
z-2.6.tar.gz":"2eed7b0d7449d1d70903f2a62cd6005d262eb3a8c9e98687bc8cbb5809db=
2a7d","src/zlib-ng/test/Makefile.in":"2eed5e763754e1f0f0ee1908e2f8080a2fa9e=
5f2770b3fc8d74b9975b4cd2bb5","src/zlib-ng/test/README.md":"6a34f8fc7a014495=
8cc9a0cded46fc38a7e15aba3dfa5bf56d8d86c3fb72d82c","src/zlib-ng/test/abi/ign=
ore":"36e1928ffa34c21c1d2fd783633c9975e1ff282682ba2eca14b61b87650a2e13","sr=
c/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-aarch64-un=
known-linux-gnu.abi":"e55ef93145cb4ceb2e22562ab5c18a2e26f8330862ed9468df7ad=
a66a47dfe08","src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1=
281fc-arm-unknown-linux-gnueabi.abi":"d45ec6ff3f41ce11713a39aaad08e4ed9d21a=
165754a1c5a5e5f123c4daf8241","src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978=
b50e93806c2a18c1281fc-arm-unknown-linux-gnueabihf.abi":"2cef33db7275ba069bf=
a3a929299dcb8f1529f3d0ad344c1e0ef483905e996c7","src/zlib-ng/test/abi/zlib-0=
4f42ceca40f73e2978b50e93806c2a18c1281fc-mips-unknown-linux-gnu.abi":"25cf82=
ce8d5afde37456ce22943358e6d5f4dec31c1d1f732a1b07f34d7003f0","src/zlib-ng/te=
st/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-mips64-unknown-linux-g=
nuabi64.abi":"59e435fa42a1aacd30d24d184d1ae505392123a8f16eaa0ca55e061ff2c42=
7cb","src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-po=
werpc-unknown-linux-gnu.abi":"5b4c5724c018d4e5820cfd9f94526ae41101fbcfa960c=
a98efcc06ed33a5b7ed","src/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e9380=
6c2a18c1281fc-powerpc64-unknown-linux-gnu.abi":"e4d05062bbbace98c02f297585a=
c69a88e6b4f34122de6a854e5176d6d81ef9d","src/zlib-ng/test/abi/zlib-04f42ceca=
40f73e2978b50e93806c2a18c1281fc-powerpc64le-unknown-linux-gnu.abi":"bc41acb=
b1e207e8dfbf0f4bd628a0d32b94e288d324f924dc353898c3ae3bd37","src/zlib-ng/tes=
t/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-x86_64-pc-linux-gnu-m32=
.abi":"5b79e86fc4f99e7d5c38b08e63ee347f29ed5312ac7dac16459b3d4562c04a50","s=
rc/zlib-ng/test/abi/zlib-04f42ceca40f73e2978b50e93806c2a18c1281fc-x86_64-pc=
-linux-gnu.abi":"568cdd3893cd364fcdfdb1536f394dda4d237a03a0a7fe80938763b737=
39092c","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882=
311-aarch64-unknown-linux-gnu.abi":"af41851f1b97ccb94e534cf3e54985fda0700c9=
4d8fa850ec021f4b7d907f480","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108=
dc983c155e4baf80882311-arm-unknown-linux-gnueabi.abi":"b2197b5aa7145c62c397=
75e7e97ce8de4d00b44f4f2ecded47aec8e725cf4563","src/zlib-ng/test/abi/zlib-ng=
-e4614ebcb9b3e5b108dc983c155e4baf80882311-arm-unknown-linux-gnueabihf.abi":=
"a037a1494a5f724462b6fb34d595b7d1517cdd60af1d890d00fa557394c0d923","src/zli=
b-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-mips-unknown=
-linux-gnu.abi":"8cf1dd6da2c8fadb53748687e7cae304cef025f490cd8a9d1970bdff04=
f13ddd","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882=
311-mips64-unknown-linux-gnuabi64.abi":"38549f6d4efc5a4e60e83dfee03f727b426=
ed969b6e476acf11ab1d5f562eb1d","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5=
b108dc983c155e4baf80882311-powerpc-unknown-linux-gnu.abi":"09e7feffa1d24cf6=
8cfd7d0c1a5a80a5d9d5df5bbda383b2a7d5f99f194a06fc","src/zlib-ng/test/abi/zli=
b-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-powerpc64-unknown-linux-gnu.a=
bi":"cb360745c650e62db182932ed37e7648d1fe939caa50eccf7f9068e653ce9a11","src=
/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c155e4baf80882311-powerpc6=
4le-unknown-linux-gnu.abi":"75170876a3b207c383889bac021ae0ff710e2915ad8c6b5=
f02c38d6e3ef731cd","src/zlib-ng/test/abi/zlib-ng-e4614ebcb9b3e5b108dc983c15=
5e4baf80882311-x86_64-pc-linux-gnu-m32.abi":"023ad5584f431bd2985d7231581058=
c249dcc0544b21fbb678ab04417c5e8103","src/zlib-ng/test/abi/zlib-ng-e4614ebcb=
9b3e5b108dc983c155e4baf80882311-x86_64-pc-linux-gnu.abi":"f072336d8a54a31ae=
4e991ecd2e0482b3c8102e0256da5f020112aeb5a9d68d4","src/zlib-ng/test/abicheck=
.md":"d960023cd80e04b2d4dcec8cdd3315c7292229d45a3301a5dc5213058ba22185","sr=
c/zlib-ng/test/abicheck.sh":"293af1e5c1e18133d1f27c9e34bdeb0f8b0123cf3c8255=
62a11a31e87d2b544e","src/zlib-ng/test/add-subdirectory-project/CMakeLists.t=
xt":"0d5d9bcb4aac1e17b5146eb727ca95e4fb91fb098fe567925befd7a88f8cf677","src=
/zlib-ng/test/add-subdirectory-project/main.c":"0f84f056ddc067fa1374bea36c4=
5c516b5ce1b4a78e8a381c06cce03320e66dc","src/zlib-ng/test/benchmarks/CMakeLi=
sts.txt":"036e052e1f7606e20db16a5829e8b5c4edee97e33013aa39b23a75ec59e407ab"=
,"src/zlib-ng/test/benchmarks/README.md":"2976b327e44b0066ae197b15bc0201f4e=
43375019718714f05acf50f9245f9da","src/zlib-ng/test/benchmarks/benchmark_adl=
er32.cc":"432f1339440958d67271bda0ddb6c819847481b515f245341a8383efb9393c2b"=
,"src/zlib-ng/test/benchmarks/benchmark_adler32_copy.cc":"d9d5108fd7b5c3424=
925e168ebd73ed6b4462a8fbd790c55d8e398a03f20d617","src/zlib-ng/test/benchmar=
ks/benchmark_compare256.cc":"2ffcc22f1fd7df9db92c9d97302e46f83811f5cadf3532=
7387ff22f27d09ee22","src/zlib-ng/test/benchmarks/benchmark_compare256_rle.c=
c":"b53004928c7334522e68eac2c96ae68369a1385249ccc81031fae6705d832692","src/=
zlib-ng/test/benchmarks/benchmark_crc32.cc":"d03c1570ad6009994eebb794187117=
2fad11a3e04fb3f37fa78fe7e0879438e4","src/zlib-ng/test/benchmarks/benchmark_=
main.cc":"67270b2efb97c24af9358220cd642cf0c8ed393d07f61abca31bc0c103b1bab7"=
,"src/zlib-ng/test/benchmarks/benchmark_png_decode.cc":"e9485de5e722ef1b621=
31a27a98d2cfe668ee8becbd5fc9938972022e07c8d60","src/zlib-ng/test/benchmarks=
/benchmark_png_encode.cc":"4b2203af2ef58f95773ca6d82569f747f2cfb3c411633487=
1cfb255a0d7741e1","src/zlib-ng/test/benchmarks/benchmark_png_shared.h":"234=
27ba4e9865ee362990c22a1aa88e868a1ac1f4024892c6b6c2a3102566a93","src/zlib-ng=
/test/benchmarks/benchmark_slidehash.cc":"1be2a35ff5a8a597714c1327aab0a989a=
562a8a4d9e7983168979e8f46b30e2e","src/zlib-ng/test/cmake/compress-and-verif=
y.cmake":"205e6a3486e8cfe485cd0f41c16cf6f471a59040ccf5eab41f1e48c9549dfe12"=
,"src/zlib-ng/test/cmake/run-and-compare.cmake":"13d85c12c9d6c7b1b148bd0c5a=
5b4faa6a4b56f3823bf03c4f8d914c9c5949d8","src/zlib-ng/test/cmake/run-and-red=
irect.cmake":"7f08d18c09aa58113882ec760735a62a1723a5bfcae9f73bd3713a4dbaeab=
898","src/zlib-ng/test/cmake/test-cves.cmake":"c526d10727275eda6a6e5912a000=
e5f2ee369f904f923001f196b69eae7cf5cb","src/zlib-ng/test/cmake/test-data.cma=
ke":"4b4e003f000fe15dc57052faf5637a85c9c7f3a6d07592184b87ea508b6fc0dd","src=
/zlib-ng/test/cmake/test-issues.cmake":"ebb2b3a53dfd74f346de0caea9378505d7a=
242d60a926337fd1dd7e65882aeb0","src/zlib-ng/test/cmake/test-tools.cmake":"d=
6cdc83cf1b5c6c342b461bed6c87d57c2b78bcac3f6b3e357bffba2181d49c8","src/zlib-=
ng/test/data/fireworks.jpg":"93b986ce7d7e361f0d3840f9d531b5f40fb6ca8c14d6d7=
4364150e255f126512","src/zlib-ng/test/data/lcet10.txt":"1eb5d7bddb1c3cb6806=
4d5b5f7f27814949674b6702564ff7025ced60795a6d9","src/zlib-ng/test/data/paper=
-100k.pdf":"60f73a051b7ca35bfec44734b2eed7736cb5c0b7f728beb7b97ade6c5e44849=
b","src/zlib-ng/test/example.c":"3a460c6f8039a26140b421fa6cad31f2ee09630962=
5dedbb111235bf61a02808","src/zlib-ng/test/fuzz/CMakeLists.txt":"395049b7625=
f120abee1e118487c55a8bd3288d0974081ecaa8baf33f60e80c8","src/zlib-ng/test/fu=
zz/fuzzer_checksum.c":"68ed79ec1d7fefa548f4d32ab7885479442520cdf53ad59eadfa=
e13e4b15efe0","src/zlib-ng/test/fuzz/fuzzer_compress.c":"3f507a18710fb2a1d8=
7fde5cf3affc74b53a689e9d2ce6f887ee64eb778e568b","src/zlib-ng/test/fuzz/fuzz=
er_example_dict.c":"46541ed3ef9bb7378120d47133f18b4194e955e7a84a439647205de=
68e745c08","src/zlib-ng/test/fuzz/fuzzer_example_flush.c":"393e7872825bb1ca=
366d0d8552b94442511ed4a557db6ece16540b79b7e9cbdf","src/zlib-ng/test/fuzz/fu=
zzer_example_large.c":"e3b91b1ced83dfe538e8ae5262f1756181a7785e8c2ab38ac288=
1456bd562277","src/zlib-ng/test/fuzz/fuzzer_example_small.c":"de9f5dc318240=
5750341a0f44c37bd8ba4f21d993284456ba8e6ce3e36d6b9b3","src/zlib-ng/test/fuzz=
/fuzzer_minigzip.c":"a02628aa452d9eb0ea42bf3c01b005a6569da50c832b78f90a1dec=
425bf3c677","src/zlib-ng/test/fuzz/standalone_fuzz_target_runner.c":"e6170b=
744faa68bf2a414e99fc87accf4db2a5e0eb58b17aded5c692ea493604","src/zlib-ng/te=
st/gh1235.c":"057934cf585b9998478e3d77ecd0782d941e20ebe50688ef32b961559d6df=
e2a","src/zlib-ng/test/infcover.c":"82ccdf5b2bb081b9da18c55c0078ff030ae145a=
4943dc90bb85c4cce00e9deb5","src/zlib-ng/test/minideflate.c":"51e9e60459ae5a=
a973d83436d016fc34788394814ade021f0168914cc9aa9822","src/zlib-ng/test/minig=
zip.c":"e736921e8ff1547547d20075eac724c74a47a186bc78faf2764f91cf49b2830e","=
src/zlib-ng/test/pigz/CMakeLists.txt":"e55880cb8b15839774f2387c07aaf42df680=
cec0305522ddecbe5f638e5af2d9","src/zlib-ng/test/pkgcheck.sh":"9e9895da9f79d=
20a1351b12969d0ed0dd63f1a0a82ae5509feab4f1b03fec894","src/zlib-ng/test/swit=
chlevels.c":"f4c482766b2e85ebdfe74ab488b16a4e807d5894dce2cfc5a0501c347db211=
fe","src/zlib-ng/test/test_adler32.cc":"d1a21f1eb2a3d8ed136d07fe4a0a8923d94=
f5a9b4fdd5c4fc80813f506b6c26c","src/zlib-ng/test/test_aligned_alloc.cc":"be=
bdd6dba3c7452e7d8557c47b14226209175fb5fe313b176cf752848117536e","src/zlib-n=
g/test/test_compare256.cc":"4362eccf7b473d82778fc4171552f8160b54b6fc6195bf9=
30cd0e988dff5a093","src/zlib-ng/test/test_compare256_rle.cc":"8428d8204d059=
8cd1071f3db9176b42fd423e532051cd14fd91e5835a01ba203","src/zlib-ng/test/test=
_compress.cc":"32d3bb507a95d56d0441280a04569164d19a8241d85084a9fcf49f51afb8=
2fcf","src/zlib-ng/test/test_compress_bound.cc":"21f71385edd73f92f40a945167=
3bdb9ea3f82a49e7f4d4bdcc4b74b086320b12","src/zlib-ng/test/test_compress_dua=
l.cc":"a76759d3d5c54315a4ee3197109a4517dfae9931eb65ae8cbaffd8a58bb562e9","s=
rc/zlib-ng/test/test_cpu_features.h":"28bbb2bdf56ee7988d4fdfccf4c6ad584bb8b=
39c4ae80fdab12effcc33c4d8ae","src/zlib-ng/test/test_crc32.cc":"57a428c33f31=
58f1b78840b779dfb46f55a943fb5e7d2c23541b9ca7090d7264","src/zlib-ng/test/tes=
t_cve-2003-0107.cc":"629f1fe659558c9deb767b3fbbb615539b0458f8b67a405ece924c=
ac6bebb531","src/zlib-ng/test/test_deflate_bound.cc":"eecbc494f22282bfd94a2=
545fc142b8fdb5582991c22b6e50fd46c40885ad81e","src/zlib-ng/test/test_deflate=
_concurrency.cc":"27a91c74cf9811921bc2424c235e540a18ed63853d37e29814a60ed21=
f1a8654","src/zlib-ng/test/test_deflate_copy.cc":"1a286ba7772bb1a6d06233b07=
5a83f3f1814bab2fd7d3757c090f5db25db90f1","src/zlib-ng/test/test_deflate_dic=
t.cc":"3395afdc925059faa1b334bf8a497803132f9ca7703d48dff0ab0264f5292f73","s=
rc/zlib-ng/test/test_deflate_hash_head_0.cc":"2d0b7bb7dcd00a630358e6c3cd796=
76a838efc262794b751b42d030d949e7587","src/zlib-ng/test/test_deflate_header.=
cc":"643763a811a3673a05959eb6dfeffa3ff25dc3672f67dc8a9f1406a31812068f","src=
/zlib-ng/test/test_deflate_params.cc":"7c747362cac9f74b2bb8e8d276539807e822=
2b18db172b81ccbaf96235b8be61","src/zlib-ng/test/test_deflate_pending.cc":"1=
a0e700d3a2863b6087041fef379bd683e882d5932840fbecb3e0b91e74565cf","src/zlib-=
ng/test/test_deflate_prime.cc":"d98d4aee8c240f5bc3b3b83f828917586b846850ed8=
2ade6f5f728a4281a1321","src/zlib-ng/test/test_deflate_quick_bi_valid.cc":"9=
706d0bf9d844b21f1655498bf0f9901c7dfc272cdef37f2d1af238c71df611c","src/zlib-=
ng/test/test_deflate_quick_block_open.cc":"7edb512a287542f83ee448fbcafc3d65=
4b62a36440b6474e9cae3bb5d36577ab","src/zlib-ng/test/test_deflate_tune.cc":"=
dad52ad7941aca761ff177877a0d60f1b68b3a6d28a8f4bd382005f3c04bad64","src/zlib=
-ng/test/test_dict.cc":"2bb6c32ec0ea76561172e0b5e8c6a7bf4f64efc2b41534b42ec=
1d6c3d0990897","src/zlib-ng/test/test_gzio.cc":"337f711eb6e80e77fd28963c89a=
646f6528d635036cd0367c398387e0a72cfde","src/zlib-ng/test/test_inflate_adler=
32.cc":"0967f8e72388a8232bcc1436196214ea1a13dd0fbd5e7633e24a9246abc2a950","=
src/zlib-ng/test/test_inflate_sync.cc":"fbb1121ea5b5448723c6d6d8692110c7362=
e6833fae22afcd46909d4ecb1289b","src/zlib-ng/test/test_large_buffers.cc":"0c=
76a002071e6280d6e6b380db5e1ada00730b0534722ba5c208cb1e51de0b7b","src/zlib-n=
g/test/test_main.cc":"884dcbfb7207f541ef82bc9fe6f657fbe1918b0917fa3e5eda124=
ad042ce732e","src/zlib-ng/test/test_raw.cc":"0ac0c7c63777d4278a36e087b2060a=
369be16150d40a6963d3a0d60a7efb1740","src/zlib-ng/test/test_shared.h":"cc6a7=
f3dd115edd5de50da2da266e615464e2d5ae41d102e117b09215889a2c4","src/zlib-ng/t=
est/test_shared_ng.h":"4570992f5ba61d2cf9e502d3aac163945d5d2f65883ce29f3a07=
97052c779b91","src/zlib-ng/test/test_small_buffers.cc":"680ba24dc58c7dd05e8=
dab2e430a8e0c99b946cbc341a5fb39c4b4b921b6fb33","src/zlib-ng/test/test_small=
_window.cc":"0f784eae1977ee62d56f6280b269aa9edc42a5f3d20502c39abcb6cf126ec5=
ea","src/zlib-ng/test/test_version.cc":"8599eca8dd63a96962a5c8ac01a3172d203=
f9065e228867928ed4bce61cf6009","src/zlib-ng/tools/config.sub":"32186cfeb5db=
62c99e1dfbfb07f24c1a50977447b4c26d2907021c74422a70d2","src/zlib-ng/tools/ma=
kecrct.c":"73acdb94f73dfea474927a9e1be33e0f2cb015d97831bc2718106141adbc1d05=
","src/zlib-ng/tools/makefixed.c":"bffd02540231304f9bcc755b8cb9ae5cfbc48975=
857bbb4547f1d6acce21ef57","src/zlib-ng/tools/maketrees.c":"48a3e4ee246b1fb0=
61d8e643efbd4b80e45f9c3814e21170a5893a9f4ca9619b","src/zlib-ng/trees.c":"31=
0fe64c50fb313773c2058c606b1a3cc085b8af7771eba325ad5c9355659100","src/zlib-n=
g/trees.h":"24174f3543b01ee1ef370bbf6d15551a21871cded18b2aadf09a71e7904b6f9=
9","src/zlib-ng/trees_emit.h":"6c541dcf01eecf393d4eab7800bc558ad524114bb5a8=
deb86f13376fbef88754","src/zlib-ng/trees_tbl.h":"022736ff3362ef3591d1f8fc3b=
7fede5927c0d25ab0813d7ef8cd95efd6ea242","src/zlib-ng/uncompr.c":"bb03a6ae65=
e1395f3cb2fba1dee63246a1fcd30683fd3348e320e789521055a6","src/zlib-ng/win32/=
Makefile.a64":"f1feaed8da22e6e1470689186db22946ccb67019a87edd34e9ed25b438b6=
26db","src/zlib-ng/win32/Makefile.arm":"f75a8e7b78015aa838e48e86d0d0d55d935=
c0a36e1e0256246cced34caffab8d","src/zlib-ng/win32/Makefile.msc":"f726cc1db2=
fe6a4568753a198a86692c4aa8ef87aa0c86f57f7bd9b75484695e","src/zlib-ng/win32/=
replace.vbs":"0ecd6d2f42f4f49d835acbf7b89a79cbdf17fed29d5931eeb3b40da6d3133=
946","src/zlib-ng/win32/zlib-ng.def.in":"0b75299a93ef3af54ab37f1282f254ccf2=
f635fec9b2691edc3840d851bbc20a","src/zlib-ng/win32/zlib-ng1.rc":"91f28a6930=
d6a376a1057a73ea5613bc13717028c89fdd0b4c8015059295fcd2","src/zlib-ng/win32/=
zlib.def.in":"ec69c79c2a5612a5c4dc9de08c930c9b251f2455e4bca8781f70c05f7170f=
b3a","src/zlib-ng/win32/zlib1.rc":"5644cee99821019a7d541d5587376236cb5b99e9=
8d66c904a25f9b69d1d56062","src/zlib-ng/win32/zlibcompat.def.in":"c4dff5ac2c=
fe629155c7de5b0f139fb1c962fb01addbc032c3cf35110921eb27","src/zlib-ng/zbuild=
.h":"523ebffafd2f37cbf4f80ec3ec709feea241278baa933ccc80678f0ae5e0d9ea","src=
/zlib-ng/zconf-ng.h.in":"83514b2e2858b0d6647159e9aa47fa84bb625ed2ac6117284f=
514cacc42a993d","src/zlib-ng/zconf.h.in":"4ad5ca48f48a012e5749d5921ec906f86=
aa4ce129632fc79a3d7fa3e653f9e19","src/zlib-ng/zendian.h":"4d1f643a78a105934=
1371bb0d0573a673d47757a1aa60ccdac3ff6c79311b33d","src/zlib-ng/zlib-ng.h.in"=
:"e658eb903b8800a1050c0bb5387d49748facfc54231658f8f3117fc3ddeaa53e","src/zl=
ib-ng/zlib-ng.map":"111f656dfdf4da285621a909fecd0532be37f83b49f6e18f357fc8d=
2a22a726f","src/zlib-ng/zlib.h.in":"0d1da55dc1e6c9c7bd97803ec26c92c87fffd54=
1f9915ccb83306e489bdfcef4","src/zlib-ng/zlib.map":"f746610758741f042f802550=
2b4c0c04f9bcd48864004cc6e502b99d3754d78f","src/zlib-ng/zlib.pc.cmakein":"4e=
25f45fe7522c3f444a27dbc68ca595447ee4f73be6d0fdcf7abccac67cda09","src/zlib-n=
g/zlib.pc.in":"e7964018e5293e5221573c129e73b379499dd5aa8b9739db1782fdfa24bb=
dff7","src/zlib-ng/zlib_name_mangling-ng.h.in":"a829fd869339579afe7ce8c1f8a=
5473598c608f3427c3cbbc1800088d6640e7a","src/zlib-ng/zlib_name_mangling.h.em=
pty":"38e51a846d6c2bd6100298c55328dba4437c08fa1dceda4eb2e06ecb1d142058","sr=
c/zlib-ng/zlib_name_mangling.h.in":"16e9ede4821d873647bf105b12e71245d3b7cb7=
9ed318fed0a8ab5aa63b2b4da","src/zlib-ng/zutil.c":"6d28356969e01e463da9a6974=
400542a2a74c019b48baed6d152416e37aea4dc","src/zlib-ng/zutil.h":"618641510d8=
9936fcbca382dc60aea97b5fe35aa010386df0a8ec3ed1b1602ea","src/zlib-ng/zutil_p=
.h":"6ca034b9d3f6a702b03a71a1f3fd61a0fe6bfb3442156cbdca090adea8eb3f2d","src=
/zlib/CMakeLists.txt":"b87275731cc3ebdfea144187875cea204f555c343279c0f35f2d=
46d661bfe34a","src/zlib/ChangeLog":"4c9f1a65b9b4be8bf164a97775ef50e4db4e02e=
a8c9933fdbe629a640691375e","src/zlib/FAQ":"1e8a0078be0ff1b60d57561a9e4a8cad=
72892318a8831946cba1abd30d65521c","src/zlib/INDEX":"3b4e325d47ae66456d43fcf=
143ba21ab67a02a4f81be7ef2da480ba30d774266","src/zlib/Makefile":"ef23b08ce01=
239843f1ded3f373bfc432627a477d62f945cbf63b2ac03db118a","src/zlib/Makefile.i=
n":"5021b2bac4164f48b17c91c8a2e3c225be7ad31d8bfab1bbaadd90370afe9991","src/=
zlib/README":"7960b6b1cc63e619abb77acaea5427159605afee8c8b362664f4effc7d7f7=
d15","src/zlib/adler32.c":"d7f1b6e44fee20ab41cef1d650776a039a2348935eb96bcb=
d294a4096139be3a","src/zlib/amiga/Makefile.pup":"a65cb3cd40b1b8ec77e288974d=
d9dc53d91ed78bbe495e94ccc84ddd423edf1f","src/zlib/amiga/Makefile.sas":"0e63=
cf88b505a1a04327bb666af3a985c5e11835c0c00aed4058c0dcc315d60e","src/zlib/com=
press.c":"5c11e1fc22e219cb986f6fa9e4ba939315227e84aef042737d38ec668b89b6d2"=
,"src/zlib/configure":"86b38f27f31d2fec76d9355872550dc63cb3949774473fd6313c=
5a3fd1def0e2","src/zlib/contrib/README.contrib":"ca39b78bd7ad84f1df7b0da907=
70c5b3fa4c8e2c75d132e9222812fac8839630","src/zlib/contrib/ada/buffer_demo.a=
db":"469cf566a6965767fee6b987a239ed8cedcc66614940d45a9b434331fbb435ce","src=
/zlib/contrib/ada/mtest.adb":"41b6f31684770334afdc4375871eb1408542f37a823a0=
73556fdbfdb63753160","src/zlib/contrib/ada/read.adb":"fa5b989aef0c5715a3fcb=
15de93985f7f10aeb0a7f5716745c95ed820eb9af9c","src/zlib/contrib/ada/readme.t=
xt":"8fe9e5303f2e8e8b746c78250e74b7c4aeb7ce6212fdce751fc3a0ce56a47fe2","src=
/zlib/contrib/ada/test.adb":"5e3abe79b387e09a9a42bd0543105e228f39a335240cff=
c33d71f0ba66ff2511","src/zlib/contrib/ada/zlib-streams.adb":"f45988e2bac76e=
b25a0dc981f46576e7432c35dde1790bbc2b650f0090b7fa72","src/zlib/contrib/ada/z=
lib-streams.ads":"969e8edb0611810fb52159dcb7c40228f4e5da810a7a3576b778116a9=
3038c6b","src/zlib/contrib/ada/zlib-thin.adb":"03d89244ee5ec9771d9b5050e586=
c609f851af551b2e64eb151f1d5be0b63ae9","src/zlib/contrib/ada/zlib-thin.ads":=
"631ef170bde16c3ca8d412b54a0e519815b80197d208f8f393e6fe017bb0968e","src/zli=
b/contrib/ada/zlib.adb":"c9ca5dc34fbcdf06e2dc777b7e9dcd0ba31085b772b440eb0e=
12421323ab672c","src/zlib/contrib/ada/zlib.ads":"02634bec0d5e4c69d8d2859124=
380074a57de8d8bd928398379bfacc514236d2","src/zlib/contrib/ada/zlib.gpr":"85=
9bb69dce38dbe9dca06753cf7ae7bd16d48f4fece8b87582dab8e30681d3de","src/zlib/c=
ontrib/amd64/amd64-match.S":"166007f7e9adb58fe8b83d85bbfe823f5e05858ba1d06e=
df637b78886caa2c69","src/zlib/contrib/asm686/README.686":"c21cc7147c956ecae=
17dd084cb41a206b086216fa521012871fb07fafd203c6d","src/zlib/contrib/asm686/m=
atch.S":"873799062495629f21cd3f779ea4b927add7aae0144e32d3594d9ce70185e99d",=
"src/zlib/contrib/blast/Makefile":"17d5d26c24bf51cad51045a38ffb73cc3539d29e=
89885aa249fcfd45a8659d5c","src/zlib/contrib/blast/README":"baa763ae03d88ef7=
ece6eb80d9a099b43d0b57639d6d281e1c7c6ca79d81daba","src/zlib/contrib/blast/b=
last.c":"1ab3e479d342bfc144167b808fb00142264bc50f24a110ca88cc774e351c218e",=
"src/zlib/contrib/blast/blast.h":"4d4e3e6f893316f0be77bfd642c857a77f1fa2925=
acb5df9753e543d35aa3a6a","src/zlib/contrib/blast/test.pk":"5f5c262c545574a5=
c221132d5ef832478d222d70b015341795b3860204140d7c","src/zlib/contrib/blast/t=
est.txt":"9679b2c98e1283222d0782b25a1c198dc64ba9ebd1addd6dc6f643a45947cda3"=
,"src/zlib/contrib/delphi/ZLib.pas":"1b20e173443a68c189cdaa4795620fb1ac165d=
9e61a27a1ed2cf690f13530d6f","src/zlib/contrib/delphi/ZLibConst.pas":"84bcc5=
80bdf397e570f86f3f5a5b8c7bf537828f30b4b72648b81911f6bf5095","src/zlib/contr=
ib/delphi/readme.txt":"f7420ed2de77d4b498eefbbe6402a1d17dc2d411735289c78a26=
5c7f10fdaee5","src/zlib/contrib/delphi/zlibd32.mak":"850e91b6c9ea05de61a411=
cbda16fa0f10118cd88bb32c4b7226988776f8d511","src/zlib/contrib/dotzlib/DotZL=
ib.build":"b96137097669644ecb9f42cdd3399d1fce9c512788374609303f7e50abf597f0=
","src/zlib/contrib/dotzlib/DotZLib.chm":"20d0e3edd57f849143255a7f0df1cd59d=
41db464a72c0d5ab42846438a729579","src/zlib/contrib/dotzlib/DotZLib.sln":"a9=
79198c5b8d144c1ac8f993bfb6f4085d135aa58ca9dcf63ebabf52b5c695f7","src/zlib/c=
ontrib/dotzlib/DotZLib/AssemblyInfo.cs":"314afcfb339ea95f5431047b7ab24631b1=
1c3532c7ce5dc2094ed0cf80a7c16d","src/zlib/contrib/dotzlib/DotZLib/ChecksumI=
mpl.cs":"e7c047a2c3bcf88d3d002ee3d2d05af414acf53cb4451efacc0f2e95a474ea0f",=
"src/zlib/contrib/dotzlib/DotZLib/CircularBuffer.cs":"be84c9736fe7bdc2bfae7=
0466d8fff582504e928d5b5e110fd758090090c8cb7","src/zlib/contrib/dotzlib/DotZ=
Lib/CodecBase.cs":"259bdda1b7d6052134e631fa24bfd9dca6e2362563496c8b85257b56=
c848908c","src/zlib/contrib/dotzlib/DotZLib/Deflater.cs":"06ba6696a3c15c53b=
a5fd5a1c2bf50b51f217010228fc1e4c8495ee578f480de","src/zlib/contrib/dotzlib/=
DotZLib/DotZLib.cs":"9837fe993fd631233cc5e53ff084d86754b97f05ec77c54b0764c2=
706f186134","src/zlib/contrib/dotzlib/DotZLib/DotZLib.csproj":"21606db31dfe=
f6410dd438b73f1db68856eacabcce6c0f0411fc4f17e17001f3","src/zlib/contrib/dot=
zlib/DotZLib/GZipStream.cs":"8d1de9755c77046b4ac71340a0a54434ebf4fd11b085c4=
4454d7663a9b4df1c5","src/zlib/contrib/dotzlib/DotZLib/Inflater.cs":"9016ca7=
3818f5b6a28791abc3af6da7c4d2773b6a3804f593f6d5737a62b99ad","src/zlib/contri=
b/dotzlib/DotZLib/UnitTests.cs":"ad66ac08de34d253e9615b96a745f3dfeda93f4a97=
8d65d5d3ddb9d0d9b3e099","src/zlib/contrib/dotzlib/LICENSE_1_0.txt":"36266a8=
fd073568394cb81cdb2b124f7fdae2c64c1a7ed09db34b4d22efa2951","src/zlib/contri=
b/dotzlib/readme.txt":"d04972a91b1563fb4b7acab4b9ff2b84e57368953cc0596d5f5e=
a17d97315fd0","src/zlib/contrib/gcc_gvmat64/gvmat64.S":"22ff411b8b1d1b04aea=
a8418b68245400267dc43c6f44104f6ccd37f0daee89f","src/zlib/contrib/infback9/R=
EADME":"890288f02bb3b1f9cc654b87a07fcea695f90f6b9bd672d25bf6be1da2ec1688","=
src/zlib/contrib/infback9/infback9.c":"0a715c85a1ce3bb8b5a18d60941ffabc0186=
a886bcc66ba2ee0c4115a8e274e9","src/zlib/contrib/infback9/infback9.h":"dda23=
02f28157fe43a6143f84802af1740393572c2766559593996fd7a5a3245","src/zlib/cont=
rib/infback9/inffix9.h":"84a2ba4727767c18af6505f0e81d9c814489c8b9ed330a25da=
d433db72997e43","src/zlib/contrib/infback9/inflate9.h":"32a907676cc36e27d0f=
dc0d99adb83a0b23f20ab61896269216d40fecf08d349","src/zlib/contrib/infback9/i=
nftree9.c":"0c7f10396703b230c504207fe1595a2f2f8ba9c43158c4bd79d5b22ca36e04e=
0","src/zlib/contrib/infback9/inftree9.h":"8ae61d52e50d2dbdb0378548ecc54fcd=
88f108c8b6fc30562a3ebec1ca6a599e","src/zlib/contrib/inflate86/inffas86.c":"=
6f266f3c7e0faca653256d0189c0f00d7dc0b062d02e25df4e1202e49369595c","src/zlib=
/contrib/inflate86/inffast.S":"70777bd21526680005fc34f086d108af49e2668ad86d=
1749e8e8100a81bfb288","src/zlib/contrib/iostream/test.cpp":"0f3c77e013949eb=
9c91e6b690ea894e19d97944d6b0885b82806fc3ad99680cf","src/zlib/contrib/iostre=
am/zfstream.cpp":"8ebb9b3d521cc3392953f27658cf1f6dcb763216079f69a1518ec5ca0=
e42a63b","src/zlib/contrib/iostream/zfstream.h":"4369c35e66f63f52ca4a5e1759=
bf720507ccabb8f3f132e2f18e68686c812401","src/zlib/contrib/iostream2/zstream=
.h":"d0343e0c57ff58008b6f29643d289c72713aa2d653fe3dcd2e939fc77e7e20b6","src=
/zlib/contrib/iostream2/zstream_test.cpp":"f789df183cc58b78751985466380c656=
308490a9036eb48a7ef79704c3d3f229","src/zlib/contrib/iostream3/README":"43ec=
48ecbd95a8c45db20b107fac73b740bb11595a4737329188f06b713972cc","src/zlib/con=
trib/iostream3/TODO":"af5ebc83fb88f69706c8af896733784753dead147687e1c046f41=
0c0997fd88b","src/zlib/contrib/iostream3/test.cc":"8e17fc48dfdbc6e268838b8b=
427491b5843b6d18bc97caa6924de9fad7abe3da","src/zlib/contrib/iostream3/zfstr=
eam.cc":"8cdd67ed0b13c192c11e5ea90e9d5782d6627eb303fbc4aa5ebda2531ec00ff8",=
"src/zlib/contrib/iostream3/zfstream.h":"1bd74778fac45ee090dfc0f182a23e8a84=
9152deb630606884b2635987b357b1","src/zlib/contrib/masmx64/bld_ml64.bat":"1c=
0561908a07ebdff271b12ed757241e1813d3db0f3551501b2595c23f0833aa","src/zlib/c=
ontrib/masmx64/gvmat64.asm":"390c1e6d63cb615b5ba042842738953f9cdc688b2fe35a=
aca981fd3fae213f3f","src/zlib/contrib/masmx64/inffas8664.c":"f6c585e43e6e52=
4107566b1f10104949d0ef902159ac8203e1d98e50d4bedd62","src/zlib/contrib/masmx=
64/inffasx64.asm":"8448d0041fe6e8f4188fe5916181a1b274c6d35d75cfb28da60cf4f1=
edde44ec","src/zlib/contrib/masmx64/readme.txt":"9bb66b5028100855683853f12d=
a0be479c7bccf74365fdbf37da2542edff9927","src/zlib/contrib/masmx86/bld_ml32.=
bat":"b0b05b62715d4a81a7db5b7ca4a372d109ec95634c9d3bef9e0041ff52de22fc","sr=
c/zlib/contrib/masmx86/inffas32.asm":"78d2cc88f8ed0e32ef960efc987c257bc1688=
afe7d031a8ba18761e95a6a7c3f","src/zlib/contrib/masmx86/match686.asm":"9e9be=
a3b5517b089da7d39caded07982746a33f94f0907ca7e8afefed7be36b6","src/zlib/cont=
rib/masmx86/readme.txt":"1f29a04e0227b74e20ba1b7c764b3ca5bf596dd2c06e89bc19=
a05fb8f9689778","src/zlib/contrib/minizip/Makefile":"087034de3dc0223b29e64b=
b3a4fc3eda7b948e93d2a9ff154aecf9fed2a1eb5b","src/zlib/contrib/minizip/Makef=
ile.am":"2313a3480a2c3745fa7ce216829cd0367058907d3a0902e5832c66c84a2fdfc6",=
"src/zlib/contrib/minizip/MiniZip64_Changes.txt":"302c62b328647f5472fb77552=
49a83459be7f8ffb1fae07e8ba318fce8f4126c","src/zlib/contrib/minizip/MiniZip6=
4_info.txt":"122719c32ef1763a5f6ba9c8cdefc1d78a76f7156b09e7b6f69b73f968e0da=
c3","src/zlib/contrib/minizip/configure.ac":"35330dc0c6188127afd339829d91b1=
9739d23bf3b7301bfb04f775a6fcbbdad7","src/zlib/contrib/minizip/crypt.h":"8e8=
72b60255b8447da99885c7159c2e1f1bb8143523bdbe71784e60f98bfd67b","src/zlib/co=
ntrib/minizip/ioapi.c":"66b39c27042f6ad12cc12efb0c82cdf100c6640b5fa959b8b86=
6e252966113a9","src/zlib/contrib/minizip/ioapi.h":"8655408534b78dc0889a45f9=
359fc6d2d5c8e8d8443b81ede596f954c720ef48","src/zlib/contrib/minizip/iowin32=
.c":"2c05bc374d3d847c6a9f29eac9d674abba7659d1e91e34e172248fcb5c274d51","src=
/zlib/contrib/minizip/iowin32.h":"586f22b9c3c64da253ce2b518e0fad61f19a7b47b=
289fc704cc9708242294c49","src/zlib/contrib/minizip/make_vms.com":"65736d9c4=
888f2373d3db0a13864d150c5040453f5bc2a5c8784379a7ea67590","src/zlib/contrib/=
minizip/miniunz.c":"ced49f20c62536a8ffb270b35cfa4994a1dcdce45f8cf059b941c94=
ca0022666","src/zlib/contrib/minizip/miniunzip.1":"66d8684392167091ef0fe015=
98d6a0daa26e7e448e2df6c3cb257487735b83f7","src/zlib/contrib/minizip/minizip=
.1":"5404596e8e5587a52f563906119f32ceee30a6d97a966afa5c7afbe4d373e210","src=
/zlib/contrib/minizip/minizip.c":"fdfcf83979ef2324c1455d369e8add8678c804939=
d412ce53f8b024578ceabad","src/zlib/contrib/minizip/minizip.pc.in":"8b6670b4=
2d8e5e519e1cc89db093efc07ba23cb1ddfedd3c93ff2df08c3ce8ac","src/zlib/contrib=
/minizip/mztools.c":"cd887c4af6d20823bd15f24008b10acf01969b4165d7848656bde8=
43a92428d7","src/zlib/contrib/minizip/mztools.h":"6f82c52279e8f79165f4446be=
652e5741a49992ac58632470335aa34c564072a","src/zlib/contrib/minizip/unzip.c"=
:"497adf676b1cae2a7afa834e4aba86383f7b697f5fdd03a8179ea9024a431cf9","src/zl=
ib/contrib/minizip/unzip.h":"d8dc58fc0121b6a4b98f3028205bb253f956b1ddf791e9=
ced3cf44892502a01f","src/zlib/contrib/minizip/zip.c":"00f403cb7810578b4b268=
7dd55fb132c850c3630fba2f3704a8ab896fcc8209a","src/zlib/contrib/minizip/zip.=
h":"96163fc140e4bf08752e014d20a1eac3f5adcdc408366f6d79c1895f2599cf08","src/=
zlib/contrib/pascal/example.pas":"d842d456ecb6ff80e34cee2da31deb2072cc69ca8=
37497bea8b8bee203403474","src/zlib/contrib/pascal/readme.txt":"02f997c37991=
ddae0cb986039f7b4f6fc816b3fd0ffd332cad371d04c12cf1b9","src/zlib/contrib/pas=
cal/zlibd32.mak":"850e91b6c9ea05de61a411cbda16fa0f10118cd88bb32c4b722698877=
6f8d511","src/zlib/contrib/pascal/zlibpas.pas":"28b90aeeb3da8d1f6a98ab9f5f1=
603d08aba5bfabc50827d3f15e661268a51cf","src/zlib/contrib/puff/Makefile":"d9=
d738030464aaae354196c14fd928adf591832fce7d71ac1977c1d8d4923a4b","src/zlib/c=
ontrib/puff/README":"aceca4bc1bce7d9445b8bc9b6640c672d95708185f6070d3a3baae=
7a9d102caf","src/zlib/contrib/puff/puff.c":"6d0eef92e115a42e570b79d8b07a04a=
f5ccbd6b3f3fbca9cbc61c49db9c9df43","src/zlib/contrib/puff/puff.h":"969b7be2=
a930db0cdcb19b0e5b29ae6741f5a8f663b6dba6d647e12ec60cfa8e","src/zlib/contrib=
/puff/pufftest.c":"8ee0da78a1221a3c2036e22eed06c2faa27a671a46565a60e10111d4=
ee9c30ee","src/zlib/contrib/puff/zeros.raw":"b7b0887089f7af1f6d1e0b4c0a1e8e=
ddd10223b23554299455c6c9be71b653a3","src/zlib/contrib/testzlib/testzlib.c":=
"c6c37b35c6ecc9986a9041f86d879cc37a9e4d8315af9d725071eb3b2cade0c5","src/zli=
b/contrib/testzlib/testzlib.txt":"2359bbdc84eb8a04e0f1cd16cd81a2896e957f2ad=
58dab3ca78ef55b7d0dc577","src/zlib/contrib/untgz/Makefile":"8f5ab1564813e09=
1cea8f1bb63da32fd80ac763d029277b0cabf50f60aceefe1","src/zlib/contrib/untgz/=
Makefile.msc":"d0f537de11d9e0e36e2a98b3971c537265f4b533b4c48797094365ad9ae8=
388b","src/zlib/contrib/untgz/untgz.c":"9a12d774301d252dcd38bba07ac369319da=
4c04c4fef8a50fcbf40aebf29c2a1","src/zlib/contrib/vstudio/readme.txt":"2a9ca=
40b68274f4d37649dfab9e5e867a000883592b4ab8fdaec8425a63052c3","src/zlib/cont=
rib/vstudio/vc10/miniunz.vcxproj":"dd607d43c64581172c20c22112821924dfe862f5=
6b2e5eb8780bdd0714d9527b","src/zlib/contrib/vstudio/vc10/miniunz.vcxproj.fi=
lters":"c3db9f97952683e688ad83c13bb94c816ac3e6b5f277fdea545b0650c125aa6d","=
src/zlib/contrib/vstudio/vc10/minizip.vcxproj":"af73f2cf8ae51e65e85342faeb4=
0849a2310c97bc77def42b38d7070460a6cf0","src/zlib/contrib/vstudio/vc10/miniz=
ip.vcxproj.filters":"83db58d87f5d7ca84b6087aa1f62b15cbc296194c8cf76e47a271f=
9077b4f3bd","src/zlib/contrib/vstudio/vc10/testzlib.vcxproj":"1525ed0893db5=
6db44ec68675c8da3c229dc7867166dfc0428816783d16ad43b","src/zlib/contrib/vstu=
dio/vc10/testzlib.vcxproj.filters":"d7e04ffa467d417dfa3c0f1c64234cadc848821=
01bbae483f0a0f5d3d6b566a7","src/zlib/contrib/vstudio/vc10/testzlibdll.vcxpr=
oj":"3f317d8964f17901c3e68bff5deaec10b6ccc50a572235999e8097292692984c","src=
/zlib/contrib/vstudio/vc10/testzlibdll.vcxproj.filters":"682a485f0184aabba9=
4e12e1b284499195f37c176d43ecee0484f31e4d636f6f","src/zlib/contrib/vstudio/v=
c10/zlib.rc":"e8b581eb16930e0213d37143a5f17868839b22c758b23981a29484e17093c=
494","src/zlib/contrib/vstudio/vc10/zlibstat.vcxproj":"2a38222d6c034d7e0b84=
3c3f0540dc6c53dd48f942ae29f31620ca0327248c8e","src/zlib/contrib/vstudio/vc1=
0/zlibstat.vcxproj.filters":"d9a2c381e51e4d6f027f3517db7db81656e43cec02ed9a=
bf267a0fde6f360180","src/zlib/contrib/vstudio/vc10/zlibvc.def":"0124fea28bf=
ee49c8a19dad0ed5a49277d451018b4affda5a389e64ad15f44d7","src/zlib/contrib/vs=
tudio/vc10/zlibvc.sln":"e659860f705f31b87ea9139a3cb4ebe1561e120bce495383a54=
614fc82b49990","src/zlib/contrib/vstudio/vc10/zlibvc.vcxproj":"3108badf710e=
2f4a64eab4e7deae6642fb68cc0d94018e537149f1761e215133","src/zlib/contrib/vst=
udio/vc10/zlibvc.vcxproj.filters":"58404ba7703c68025bec64b8a17ff1fc7f3a35d1=
5d17ae3bcc4fa753f1348425","src/zlib/contrib/vstudio/vc11/miniunz.vcxproj":"=
746e4c11fb8af4bcd6a9d68ba81ed1dc366a5de3bed56b291ee969ad733a7bb0","src/zlib=
/contrib/vstudio/vc11/minizip.vcxproj":"340617cae9cf4fcb003308021d3782ec363=
9e60d62d79a3aafc0a50bb55b061e","src/zlib/contrib/vstudio/vc11/testzlib.vcxp=
roj":"589eec6ef6d818564ead938a629fda50abb6cbf8054b9f66ea780765c1a1b3db","sr=
c/zlib/contrib/vstudio/vc11/testzlibdll.vcxproj":"583bdef522b0176829f0d8139=
ea2a88b9cbc14379d1334f3a863989ed3df9b67","src/zlib/contrib/vstudio/vc11/zli=
b.rc":"e8b581eb16930e0213d37143a5f17868839b22c758b23981a29484e17093c494","s=
rc/zlib/contrib/vstudio/vc11/zlibstat.vcxproj":"51aa752698d96df065a9ece02e2=
93492f681b59a8077f036a5a60367dc621e87","src/zlib/contrib/vstudio/vc11/zlibv=
c.def":"0124fea28bfee49c8a19dad0ed5a49277d451018b4affda5a389e64ad15f44d7","=
src/zlib/contrib/vstudio/vc11/zlibvc.sln":"27389b515997defd080519f95aff87e8=
9fcbe8b26d73c5ebb73c544cfef4d60e","src/zlib/contrib/vstudio/vc11/zlibvc.vcx=
proj":"c3dd05e56159aba411475b83656275872524cb3c2fd24d690397d8b634e7e0ed","s=
rc/zlib/contrib/vstudio/vc12/miniunz.vcxproj":"1494af54570f6e93852932956d49=
a8c25e57b5abc1ac979945605ca9143df9f8","src/zlib/contrib/vstudio/vc12/minizi=
p.vcxproj":"9bf128ed6760ca5f019006f178b1c65f4c7ff122dba8d297b64b0eb72feeb12=
0","src/zlib/contrib/vstudio/vc12/testzlib.vcxproj":"367a06caa399bd09f6b9cb=
60706820943dd6a6cf05794275baaf421da9c2a0b7","src/zlib/contrib/vstudio/vc12/=
testzlibdll.vcxproj":"93416510256935d79625dc9fd349cfce6968c062d42a138bec404=
a26b2f92f5e","src/zlib/contrib/vstudio/vc12/zlib.rc":"92d5d3a4938a635039593=
4153416a7eb74353cdfb2321f45b9ee0b9b16257f39","src/zlib/contrib/vstudio/vc12=
/zlibstat.vcxproj":"744ff6ac0d4e2dcdf74c7d33b979fbfd2b18550947eb99bfd46dc6a=
73eb1c68d","src/zlib/contrib/vstudio/vc12/zlibvc.def":"0124fea28bfee49c8a19=
dad0ed5a49277d451018b4affda5a389e64ad15f44d7","src/zlib/contrib/vstudio/vc1=
2/zlibvc.sln":"162e0faa80a56d89eea71a0b89377708eec2faa0dc72091cc0abb07fbdea=
49a0","src/zlib/contrib/vstudio/vc12/zlibvc.vcxproj":"754671c59d8996a846241=
af76082cc8be1aa5fc079eff530d91a9ab15a0bee5b","src/zlib/contrib/vstudio/vc14=
/miniunz.vcxproj":"0312511d4a30cea979c4e36edf994a537ed8a9d924f6b5c536cbcd09=
4773c11f","src/zlib/contrib/vstudio/vc14/minizip.vcxproj":"9e7bb7a6ac723e4b=
2db900627c366f9bb93a351381995d9c69a50c0126f64233","src/zlib/contrib/vstudio=
/vc14/testzlib.vcxproj":"c3a9369670af4ebea13d036b452be7418591fbb4c03a675699=
facac5d8dff5d0","src/zlib/contrib/vstudio/vc14/testzlibdll.vcxproj":"69f544=
898b4275cd3d8e19b8f1f8cb39c1cb98a30cdb033242e4b94c57bfa150","src/zlib/contr=
ib/vstudio/vc14/zlib.rc":"92d5d3a4938a6350395934153416a7eb74353cdfb2321f45b=
9ee0b9b16257f39","src/zlib/contrib/vstudio/vc14/zlibstat.vcxproj":"9c7c096b=
47e7875412c98525efcd16db62e094215f0011b9cd739a33ab35d48c","src/zlib/contrib=
/vstudio/vc14/zlibvc.def":"0124fea28bfee49c8a19dad0ed5a49277d451018b4affda5=
a389e64ad15f44d7","src/zlib/contrib/vstudio/vc14/zlibvc.sln":"47a50bbde8ca6=
336cecd8c0e4b65e515fc46ae84c7b61008ac9864162f777286","src/zlib/contrib/vstu=
dio/vc14/zlibvc.vcxproj":"71fb6ef3b079bfdf4182af17e74c3361ead757467edfc591d=
9cbe303ccc47b52","src/zlib/contrib/vstudio/vc9/miniunz.vcproj":"b2b53bd9e70=
4bfbe769b863acdc2a3368692ca149c4b4ed2a0761b0cd16c6726","src/zlib/contrib/vs=
tudio/vc9/minizip.vcproj":"80a701fb41a61871ce1d25f6b03e571edb6c3abf0aa45375=
554b6fac52115eb6","src/zlib/contrib/vstudio/vc9/testzlib.vcproj":"05fc5a876=
82b17690d199f424f57f6ad7767b8dabb29a1039bfcb88bca1b302f","src/zlib/contrib/=
vstudio/vc9/testzlibdll.vcproj":"25c1cc5319f1c4b7dbdb595c3cfd6ec3ba217818b0=
3b7055ef5ef440b575a43d","src/zlib/contrib/vstudio/vc9/zlib.rc":"e8b581eb169=
30e0213d37143a5f17868839b22c758b23981a29484e17093c494","src/zlib/contrib/vs=
tudio/vc9/zlibstat.vcproj":"e8653eea37f3bef097eec2caa55e1f698c3c74c959689bc=
4e97568e88d2bbc60","src/zlib/contrib/vstudio/vc9/zlibvc.def":"0124fea28bfee=
49c8a19dad0ed5a49277d451018b4affda5a389e64ad15f44d7","src/zlib/contrib/vstu=
dio/vc9/zlibvc.sln":"26e58d4b2cfcd941c367fb2a18537b3b9f002f2ac1278b700ea112=
9c50501452","src/zlib/contrib/vstudio/vc9/zlibvc.vcproj":"86aa6e33db104c0a0=
ed4a9f21f0db8572cc7755170217aef18219fdd74b75e9d","src/zlib/crc32.c":"a04af2=
73e83ecc351bf3794974ab2098d8d960df4044b7b44734c41443ee26d0","src/zlib/crc32=
.h":"407af59d0abfea84a6507c603eb29809411797f98249614fe76a661def783ce1","src=
/zlib/deflate.c":"11fd6b0328b65c4ad4b5c204d892a97a9083628a7e77dc47836c8e0c7=
99f8da0","src/zlib/deflate.h":"0ca7fb0cf1dd63001c6e9e4ff93c8dbff2fe521199be=
51a4dda38a11b44919f6","src/zlib/doc/algorithm.txt":"992590931e982c0765286c2=
d83f6e9ff0a95aabb08e28c30c52bae3e8c4bd5ad","src/zlib/doc/rfc1950.txt":"8f04=
75a5c984657bf26277f73df9456c9b97f175084f0c1748f1eb1f0b9b10b9","src/zlib/doc=
/rfc1951.txt":"5ebf4b5b7fe1c3a0c0ab9aa3ac8c0f3853a7dc484905e76e03b0b0f30135=
0009","src/zlib/doc/rfc1952.txt":"164ef0897b4cbec63abf1b57f069f3599bd0fb7c7=
2c2a4dee21bd7e03ec9af67","src/zlib/doc/txtvsbin.txt":"47c273bb22c9773248d38=
0549a330e5c262266b1292154b0d3014f731cc73f47","src/zlib/examples/README.exam=
ples":"402d72eb69c2e03a25034f4b3c02b110f0f67149ecfa4fa0e4b2bf0ceb49a8b3","s=
rc/zlib/examples/enough.c":"704e273f65b62c5d2eb06d5bb10c4ccffba56544aa477f0=
e3957e2296c501b78","src/zlib/examples/fitblk.c":"950769163c41aff897ee41746a=
8685d9aa41073b1307f42da19dabe9d3fc8b85","src/zlib/examples/gun.c":"d60ca6eb=
0a3e62ee7fb4a1ab69e8d1525ff06b06ce46889cbdfc13fb8f7534c2","src/zlib/example=
s/gzappend.c":"4182d38bf97ffbdf1110df7f65c0e8fab0b28b1ea36ebba8621c14e8e76f=
1caa","src/zlib/examples/gzjoin.c":"90b9d6c39a5fc91cf1cc9b96b025a508a8015dc=
502cd9374c754b44078593f57","src/zlib/examples/gzlog.c":"433d34b71b4e769ece1=
cceb8bd7d902d2c0a24ccd7550ab1856a5ba87f84f835","src/zlib/examples/gzlog.h":=
"309556e2d7d39250924946b78e2cce0ac927857d6e1a02cab64e438f533c20c3","src/zli=
b/examples/zlib_how.html":"80fb647be8450bd7a07d8495244e1f061dfbdbdb53172ca2=
4e7ffff8ace9c72f","src/zlib/examples/zpipe.c":"68140a82582ede938159630bca0f=
b13a93b4bf1cb2e85b08943c26242cf8f3a6","src/zlib/examples/zran.c":"840ebeb05=
8cd0ca9e92dcb1db665932462a4695fc649b34e865b8d1ad7c5bf77","src/zlib/gzclose.=
c":"94446cf8cde67c30e64d0a335b0c941fd3fbad2e77f30180d12e61f9c2a5a6b8","src/=
zlib/gzguts.h":"1ef4741cf10441feeca5c8dde2b6c754f0cbd96fcae697d54a604757289=
a5e9b","src/zlib/gzlib.c":"5daf11e44149e0aba2956d35f73f04f35dca99c3dfa43f5a=
d43ec20b336e4a1b","src/zlib/gzread.c":"6f928512cb1792cfeab31a51ff0b211814d2=
e455bc75290eb31079dc1e5ad2ec","src/zlib/gzwrite.c":"ba3b7b7ad2ff7ef0c19319b=
8408c333491a4cd495da55d0b156bc73d9ddb4df4","src/zlib/infback.c":"abe44873b5=
af2ea68ea1d281d915b2800f1832f846d2c05442a4711adbe6f269","src/zlib/inffast.c=
":"4d496ab2a3d29df5fadc3dbff6067e039806aaceae6cfcd09ea77d46c2b848fd","src/z=
lib/inffast.h":"7d8c1c873ce9bc346ad6005bb9d75cce5c6352aaf7395385be216a9452a=
34908","src/zlib/inffixed.h":"237ba710f090e432b62ebf963bee8b302867e9691406b=
2d3f8ee89ee7bfef9b0","src/zlib/inflate.c":"8b6c599c3563c14c447c47db0d7dc9a1=
6e8c246a078ec95a169ddcebaaebd811","src/zlib/inflate.h":"8ec9ac297790276f7e4=
6a961d4c6f9f944fb1dec92401339ec2666973cc5983c","src/zlib/inftrees.c":"1960c=
a67384376f65b6ce8c08fdb501f8eb33923e11ef5f61a855708c6cb0a8a","src/zlib/inft=
rees.h":"c510b36402784b1f898be3b049b923469aa92701de2d9195aed19f6b65c0dce2",=
"src/zlib/make_vms.com":"3064eb153a7684115f1494364f80759bc5a2c227799fdf08df=
7b9e6e50884720","src/zlib/msdos/Makefile.bor":"292ab363f7ffbc4ae84d37cd9bdf=
fd2dac1003bee52d223a8489844870f20702","src/zlib/msdos/Makefile.dj2":"920845=
0c2ae6dcbfcc25560b5b9ca763f461e7246e37b0552474edf8fa898906","src/zlib/msdos=
/Makefile.emx":"c749d6ec7f88e8e639d4f03bdbdcbbe9d1c304210be4c4be621ceb22961=
d3d64","src/zlib/msdos/Makefile.msc":"0e021a6f42212415b060e4ad468eb415d0a8c=
1f343137fb9dff2cb8f9ead3027","src/zlib/msdos/Makefile.tc":"2ae12ee2a3e62f7c=
5a0520d0fbe4adee772bc07fe816002b07ccb43db3daa76a","src/zlib/nintendods/Make=
file":"ea5823efe6830132294eddf2f56dbd7db8712244c210bb4968c431b1a91bd066","s=
rc/zlib/nintendods/README":"e362426c47b39ff6a7d6c75c6660b20abf076cdfa5e1e42=
1716dc629a71aef95","src/zlib/old/Makefile.emx":"d811f032272aae50123a889297a=
f3a02fbd60d1e42bbef11466462f627ff7b5b","src/zlib/old/Makefile.riscos":"d1a4=
88b160fbfd53272b68a913283a4be08ba9d490796b196dddb2ba535b41e0","src/zlib/old=
/README":"551a0f4d91fe0f827a31cbdfbb4a71d1f3dc4d06564d80a3f526b749dd104d11"=
,"src/zlib/old/descrip.mms":"8ff08c35c056df9c986f23c09cf8936db63ccf12c3c42f=
7d18a48b36f060cff7","src/zlib/old/os2/Makefile.os2":"6ad247c00f00ff42fd2d62=
555e86251cef06e4079378241b5f320c227507d51d","src/zlib/old/os2/zlib.def":"ea=
9c61876d2e20b67ef2d9495991a32798eb40d13ede95859a2f4f03b65b9b61","src/zlib/o=
ld/visual-basic.txt":"1727650acbde9a9e6aec9438896377e46a12699cca5d46c5399ce=
f524dedc614","src/zlib/os400/README400":"6f95a1beb0fbf943a3312eaa3dd2c279f1=
cef93062bebbff63dd37ac9e2aa8d6","src/zlib/os400/bndsrc":"cfe00b1528d5c27813=
cd6b1ad7aa34b493fd63d615623fb21fd1a7bf99d2255e","src/zlib/os400/make.sh":"1=
43394d1e3876c61c29078c0e47310e726e1f5bd42739fe92df9ece65711655f","src/zlib/=
os400/zlib.inc":"c501c522185ba1f0506caf90d72f1088b34b2addc169471e949e443ab6=
5e8a75","src/zlib/qnx/package.qpg":"90b5c8364d9dc5ef67405b352c19710ebad2905=
f3f20b9e56ded74661f96743b","src/zlib/test/example.c":"520799662a8286725540d=
6d5a356efe6f595618e5fe2e591972491d719bd99aa","src/zlib/test/infcover.c":"f6=
54f3fcc74b33bd95cda63d13fe0ce589bcfe965544e0c17ee597d75efbd090","src/zlib/t=
est/minigzip.c":"91089b21e692797bb6208b2b45eeb90f5f1f1e4f6b67b99dea5676f51b=
811193","src/zlib/treebuild.xml":"d816c764c8ec2d5b2ebfa7f053f747097926c13fc=
e7fa8628c5d14c991411421","src/zlib/trees.c":"f2a5f949ea70dde7c23a54c793aeed=
630a03df4bb72417cd3aa008000c44699b","src/zlib/trees.h":"bb0a9d3ca88ee00c81a=
db7c636e73b97085f6ef1b52d6d58edbe2b6dc3adeb4d","src/zlib/uncompr.c":"31922a=
a982ee12fd28d1ce5fe6a94a3f07c2a941c821b566a881ca21845cdfaf","src/zlib/watco=
m/watcom_f.mak":"7e039b912f9cffaa40835281430bb284fa9042b0a0d12f6b34700a06bc=
a6576e","src/zlib/watcom/watcom_l.mak":"d11b4064604a034725860e63e3f6d347056=
372e4b1675b183e20a93533b20cc9","src/zlib/win32/DLL_FAQ.txt":"9e00778319381e=
6275691dd3a89410c99065b8c0c5db96473abe8c859cbdefd8","src/zlib/win32/Makefil=
e.bor":"e878fed2313417db085fea621c110889f6a32233b5b6db46e3c4e824c1d0ed6b","=
src/zlib/win32/Makefile.gcc":"ea8feddce7b9707253b9bf86623cf7ebe5294d7aea2b3=
b0b1b1c1b8cfd73009d","src/zlib/win32/Makefile.msc":"7c495d63c5afea1d77d162a=
41b73bab89cee952c12e4647e9684a7ac79bfc3f5","src/zlib/win32/README-WIN32.txt=
":"b71f1f4e4760812c3a11b2bae6f40d1066741a90e6646010a32ce50a0e348cde","src/z=
lib/win32/VisualC.txt":"9ec0babd46eaa012371dee2d3a8a55d9c7130f7895512c3371c=
737e4a7f6a997","src/zlib/win32/zlib.def":"24fa6dd00f3f4c0d14507a03ddbfa4270=
7a04e3901bb9ff6f90096037a75185a","src/zlib/win32/zlib1.rc":"8fc5f2b5abee40a=
d66e6d6cfc9f926c2f446e13a7c9ee7df8bf58a266d8cade5","src/zlib/zconf.h":"9c00=
87f31cd45fe4bfa0ca79b51df2c69d67c44f2fbb2223d7cf9ab8d971c360","src/zlib/zco=
nf.h.cmakein":"d740b750e9c98e6a4b4529cc2a857a3fa8001514b1ce91e0e1d9d293652b=
f388","src/zlib/zconf.h.in":"9c0087f31cd45fe4bfa0ca79b51df2c69d67c44f2fbb22=
23d7cf9ab8d971c360","src/zlib/zlib.3":"5abef003e545566e5599e5ab2e7528e978be=
59d54546b19d763d062f7a69bac7","src/zlib/zlib.3.pdf":"7f0f633641d782e360eff9=
fe831716c5767faf1000e38382a8a8c65b0b67f374","src/zlib/zlib.h":"4ddc82b4af93=
1ab55f44d977bde81bfbc4151b5dcdccc03142831a301b5ec3c8","src/zlib/zlib.map":"=
7eb1070ba6bf12e6895e5da06b84a92af683827587afaa72bdd45e80b9d8e4e9","src/zlib=
/zlib.pc.cmakein":"2f1d0b18ce37c2af415a469857f02aee2c41a58877aff21d29e9c6db=
32b55cb7","src/zlib/zlib.pc.in":"04c01cc2e1a0ed123518b5855f585c93a24526dd88=
982c414111ea1fc9f07997","src/zlib/zlib2ansi":"d316e3e79054f5f9fe921d35f4bbf=
4bf0a37b859d29d2b34ae4d7d92afc3e55c","src/zlib/zutil.c":"f7fdc9ef326a2683eb=
33c794face54e83c751ec17f3d1ba581847a62af36ddcd","src/zlib/zutil.h":"9a63f66=
90fac1620aa3cecee5752af618806da438a256b4a047fbcd289cac159"},"package":"d971=
37b25e321a73eef1418d1d5d2eda4d77e12813f8e6dead84bc52c5870a7b"}
 \ No newline at end of file
diff --git a/recipes-devtools/rust/libstd-rs_1.76.0.bb b/recipes-devtools/r=
ust/libstd-rs_1.77.0.bb
similarity index 100%
rename from recipes-devtools/rust/libstd-rs_1.76.0.bb
rename to recipes-devtools/rust/libstd-rs_1.77.0.bb
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.76.0.bb b/recipes-=
devtools/rust/rust-cross-canadian_1.77.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.76.0.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.77.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.76.0.bb b/recipes-devtools/r=
ust/rust-llvm_1.77.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-llvm_1.76.0.bb
rename to recipes-devtools/rust/rust-llvm_1.77.0.bb
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rus=
t/rust-snapshot.inc
index 07d4af8..c9517b6 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,47 +4,56 @@
 ## The exact (previous) version that has been used is specified in the sou=
rce tarball.
 ## The version is replicated here.
=20
-SNAPSHOT_VERSION =3D "1.75.0"
+SNAPSHOT_VERSION =3D "1.76.0"
=20
-SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "cf367bccbc97ba86b4cf8a0141c=
9c270523e38f865dc7220b3cfdd79b67200ed"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "2ea0dc380ac1fced245bafad=
afd0da50167a4a416b6011e3d73ba3e657a71d15"
-SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "b1d7bb8b0420b71585cf9c4eb5f=
d1e986fd83edc2d393510b54a9b20272386a3"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "d0c54d824e64b7313a974409541=
ca3a157b3ed7299865786bd0c440b0e073091"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "4d9d8e392b03965b01591f16b2=
33e91d48a597e731e0cd04dc495512dd4775e2"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "c0c579d9321da855109a2b6c=
7d7c9e01549db37e8490f058cfdc0012bef394cd"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "a299b5053d2771c24e3d5787caa=
0317ea729618700acacf2eeb95e345a92529c"
=20
-SRC_URI[cargo-snapshot-i686.sha256sum] =3D "ab652e4755def10f37c245245643d6=
0f56cb28a7dcd2defb8a1d560eafbf08f1"
-SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "42c0aba08ddcad191c84adcb5b6=
479b4599b9e4656e4e2b6d3ed5b46fa4a04fb"
-SRC_URI[rustc-snapshot-i686.sha256sum] =3D "a39aed533c63b4da6c0d9f30e76d72=
90ed5b3be2e66bde43d02764d7b50d382f"
+SRC_URI[cargo-snapshot-i686.sha256sum] =3D "ffa9b2b65a3bd6298ffd5a2defd6ac=
5fa42d1a0dcefdea50b92ddf8d162db19c"
+SRC_URI[clippy-snapshot-i686.sha256sum] =3D "a6eb9271424ac326ef7609b1c2113=
916e42801ca271348708ff032490b66ac50"
+SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "78fb0859beb4f18af7227af3f09=
f0218169ca38c7751865e40d78d697ca190fc"
+SRC_URI[rustc-snapshot-i686.sha256sum] =3D "e52ff92c605284b049e88912343a0f=
1c9c4cef7cc4a501d4e8f1ab9e4d9b1d7e"
=20
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "e4e4b38375a2fa0697b80ef=
6d7b0f8a4505836baded47b755ad751fbe605354b"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "fede876247ca3977a001=
cfca9038851eb99dd38063fc2bec439e75e25453242d"
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "36a6507eb6c5fc6d3884579=
e908ab7865436a1705e42677bcb5d1d75e5bee8d7"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "ff5ece4942139dac43bae14=
293602cce5bb87c700fa051eb5a6cd7b08eebeafc"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "ed8abd72fbbd9320573752=
eee465559743b94832007b3beda9b7ecbee596bf61"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "0b96bc12af2d2477e7e6=
b22befbf37b759e56035414d8aa85975e3050c88dae5"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "59c8ec9441a73223873bf56=
1f0c36719b130788a03e8e04955e3b79625a8d68c"
=20
-SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "c758265f0fe5a5c36fccd9f67a2=
97c3274a795e67530aa8c09d376840d6184af"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "eb56d591650773c7ce00f32f=
de1adcb878b4010167f348ea167d492fba8628d0"
-SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "49a6adcc8d26a38a77048b13b46=
f83581ee33262627099ea4f6d0d8eacaf889c"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "b5c2e394fb300b480d9e15d519d=
ba6dd40a20fda91117dc3ede721af1bac8645"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "1227f8989ae609afe0d7710602=
62e113ead080ac863bd5c7f89a6b491d5b7025"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "773189b5fc9c2252801dd10d=
a23dfd54577f25fcaf8f4077b4d5bc2169079653"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "00b27ff304d5af9663778a6f6dd=
70a85a98fe8db877054bb4080206372faf571"
=20
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "409c9f596e9f88da78587edff=
1633c319ac0ac14ea622f26d30d16ec1f92e1c9"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "776ea8d200f65cacdb619e=
ecae319511ec2ab398321c8d976c846b9dc44b87d5"
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "6888a22227037aa3015a21959=
05acdea420e51f0909cf6653b30765938ea5745"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "dcf7e9e0b247f56759528db60=
1eec76ff9c471457acd84c4c47e42b35ad2edd2"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "903e30eeefd11d923412e2dd=
fb695126d80d5101afd1838e61d7cdca4acdad04"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "312699dea45a90f4f80bba=
87e12c410378b39c819bd089b1219101f101b49833"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "ab397f7ea75b18b5c5e01b878=
772f1c91f102a09b46c60dae5110318cb17c677"
=20
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "6b293abc4cafba101c714b3=
7dc369cd229e04151efad626896b811165019bb95"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "22286818e4f0f13f7120=
82e7a740aceb32e28ab3f568d6ed0e9e06b4972b30f5"
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "5268dd59f78f946d2dba8ad=
362ba8c724432422c6f497a69f6dbad240e4497d0"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "c3b249f7db0fe6db2e6a52a=
b183cdec544ccf7fa22c27cddb039e389da85b8f7"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "49ed5e82d833b91a943163=
183f5c4cfccae92dca9b2758a846dc9f084e0a5651"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "939fe0ffe27b4cbec4e8=
f43a69e795460f507b3b57753e2644546d9d57fe7a39"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "51ad28e1e646c6659110ecc=
8189fc519916e9317c50a05d20e4555e919751edb"
=20
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "13937d19fc5fa531c1def3a52=
6695be94aeb34e7f8653fc6e5acd782bcc6267d"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "35db7870fbe27308c2a9ba=
d0371cd05af2fd2975e00b7f5a5bb305798960a9cb"
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "4dbed202d8d11eb1fb29204bf=
9d8358e8da85791e990ec1dd576f75701b33abb"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "2799a565834247d67b7e84dda=
209a662aaa6fd16bbb7d46d78882de3a56b7df0"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "ea678064035f634c877bd3cc=
2559beb82bee10b5e2cddc2e3e37baea0ce4b472"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "ecbf009619d6704f0a8384=
252b41d11851dadbf0d9809ec80d77765d029883a4"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "f0661f1ae574947c6762b8ffd=
756de7e9199ff4790f1fcb9c994a3b49684a9a0"
=20
-SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "720cabf7e03d91bf080cb15d5ebb8=
fb56eae1938b7ab763f82aa46a997d1ddb7"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "810be45b498c4ce1ba9181702a=
2534c5a35e52fbab547d94b62f70e28388748d"
-SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "ce4faea55ee9a5032ad6eca5f1b0b=
e3d572d6fc0146366c0c984831322b6e3a3"
+SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "3697dab26ed0bc98f8d536d81f717=
6e5162dfc3629507d942b7c7d4e7b1db928"
+SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "657521dcc91256cd023fe2c3c29d=
12d402f0a905dbd3713eddd5670c3fe36bb6"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "e5eedfb57fe7f93c77ea91df39=
1607ffe553349169c1b60b5d8ad040a7fd639b"
+SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "c59a8246e5bd960b5875d8ab4e66b=
e9d9adf376b61e99dee32a3e3e66f8197e6"
=20
-SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "6ac164e7da969a1d524f747f2279=
2e9aa08bc7446f058314445a4f3c1d31a6bd"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "136b132199f7bbda2aa0bbff6=
d1e6ae7d5fca2994a2f2a432a5e99de224b6314"
-SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "2824ba4045acdddfa436da4f0bb7=
2807b64a089aa2e7c9a66ca1a3a571114ce7"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "30ec0ad9fca443ec12c544f9ce44=
8dacdde411a45b9042961938b650e918ccfb"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "0ba679a46d2b1f4e336acfbd892=
f50c800ba090ddc8de37fde679f9a6241ba7b"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "e41150b52d923a3bbe166c4ec=
c5719f56576274b0d034d764768aee279ae2063"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "9fadfcf71bc6a0ddfd026b962416=
3faf1c5689dd4a1f7cc1f857167ade4aa6eb"
=20
-SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "7bdc6cd915a47e116ca78e07fe8=
d5d8acb6217e2aa6187806f782d81853a39b3"
+SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "d456e1b697ce63e327df4494547=
8a276938bbd293bc564ff4ff075603e7f521d"
=20
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "6943fda4f3958f28883cc5fb=
9f455611cc42f4d228841984b8a2a0123e7b65a7"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "9a192c3a41d15f812346f5a3=
6c4503937cbeffc8f05856a6747f6c880dbd8729"
=20
 SRC_URI +=3D " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-s=
napshot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index 328c5b2..27d74fe 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -6,7 +6,6 @@ SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${RUS=
T_VERSION}-src.tar.xz;n
             file://0001-Revert-Map-source-absolute-paths-to-OUT_DIR-as-rel=
at.patch;patchdir=3D${RUSTSRC} \
             file://rv32-rustix-libc-backend.patch;patchdir=3D${RUSTSRC} \
             file://rv32-cargo-rustix-0.38.19-fix.patch;patchdir=3D${RUSTSR=
C} \
-            file://0001-Handle-vendored-sources-when-remapping-paths.patch=
;patchdir=3D${RUSTSRC} \
             file://repro-issue-fix-with-v175.patch;patchdir=3D${RUSTSRC} \
             file://0001-cargo-do-not-write-host-information-into-compilati=
on.patch;patchdir=3D${RUSTSRC} \
             file://rustdoc-repro-issue-fix-cargo-config-for-codegenunits.p=
atch;patchdir=3D${RUSTSRC} \
@@ -15,7 +14,7 @@ SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${R=
UST_VERSION}-src.tar.xz;n
             file://rust-oe-selftest.patch;patchdir=3D${RUSTSRC} \
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=3D=
${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] =3D "805482b436442a6786d270cacbab8f00529e06141b27b=
7fb01909b97ce4f3464"
+SRC_URI[rust.sha256sum] =3D "66126989782cbf77fa3aff121bbb108429f2d46fe1932=
8c3de231553de711b90"
=20
 RUSTSRC =3D "${WORKDIR}/rustc-${RUST_VERSION}-src"
=20
diff --git a/recipes-devtools/rust/rust_1.76.0.bb b/recipes-devtools/rust/r=
ust_1.77.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust_1.76.0.bb
rename to recipes-devtools/rust/rust_1.77.0.bb
--=20
2.46.0


