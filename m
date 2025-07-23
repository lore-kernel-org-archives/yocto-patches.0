Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9368C87FCF
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:48 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.web10.22558.1753296044031661158
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=jVX2NB+j;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7dfd667e539so20690885a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296043; x=1753900843; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DQVCovCoNKUeSralIUGS56JDWqcN5px+H6bF2q7bic=;
        b=jVX2NB+jVlSX+Rj8TzmXR6MnOxFKU+InSR4d2h838d4O2yDgVxrxQ8U7EWNYkziZ14
         oDg9m48kKd9b/qrHaxsex9jR+nZUlPRF30jgd0N6OtYeaZP52t/tNon2vEQebZrCpLpG
         a7smzLV54Gei5K+VBjenoCZVm4kezuHSnPG64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296043; x=1753900843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DQVCovCoNKUeSralIUGS56JDWqcN5px+H6bF2q7bic=;
        b=c8vUxZknYIqFgFOffJKZ7BnJw7kpBN3uBFDHn17DF+GLjLVRhAwmhCKpSeowkDn8U8
         1TZvoNJdQHwy5kL6Mvl2s+yZaK+cC82si0lVA1dQscIyfdairkwiue50TxJnh5mqo/Mc
         MUCLiymHoksQwzJiLbZtmK/efOCbyTmI7T+FpXdn4EREBA5w0aE+OADzHjd/e0+fxC6j
         z5tkQC0EGr0cEAGcfABlPG714XwN563ZYfb/o4y+SrJvdRKxJuWK6QTRoziarZexP4+j
         08S3ufHYcFCryJc6HGiE656NgEpXNIOTGWKTpHtxtcGLNe4c3EHlqjxQ+2FSeKqQGrN/
         4Y+w==
X-Gm-Message-State: AOJu0YzXzkNLwwSzvtKXpWfgxf5WmRclENFsBRq0T4AZaXSCheGUqUJa
	+7NjqQ1t+xN9AYqs4hqtoaGcirl2kYTwhJQE0AZqow61G4q40n6dy8U3DM3Wi4UBMa+W9E7hSxi
	/lJB7
X-Gm-Gg: ASbGncs9/RUpWtSQ3AbbxyvCpKW/llwtHCB07+WXbQjPzJTTNiQodlC+EOi2a2gscGz
	pgsNRiK23DjdbQLMCDP44xa4W/Au+yUjsOx5a7YOz+JY4IrREKH9num8wyicAW9w9hOAwa/kIMp
	vcKBSi6ojwL+ofnu7UUY6ptaY1s02ywz1P2I3JzbYqhydopsyxfIVSSpO7MVnpBcI9e2nWlvvXY
	C9knr1DD1vOJDHr1U1xogl5/lxR2iUjcTHuK6CziApsERauCqxBOIZ8XubCzPLPFm98TXvctplh
	FbMVjZQcIk5b5XgmJwICSlXlypjCaLMmDgFIyd++i9V4Has384yovcl1Joxy6M/iOWESZ4CCH74
	KM4wiIGjAc2MAZISh3tZptTNCw+gc0PP/xliChIwwZUlcEnYpAmjHNFq6VjC9rg83jSE6qFh/Xn
	5dajPwb2gn
X-Google-Smtp-Source: AGHT+IHnb540/F2Drw2B6tM2mBZit9/YXI0kiRWyJjBbTloP81Uo0WnG6UlCtyZu0bzERaDsC0Sa5w==
X-Received: by 2002:a37:de12:0:b0:7e1:b6e4:bb6a with SMTP id af79cd13be357-7e62a0e632cmr435721485a.21.1753296039480;
        Wed, 23 Jul 2025 11:40:39 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:38 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 09/13] rust: Upgrade 1.85.1->1.86.0
Date: Wed, 23 Jul 2025 14:40:09 -0400
Message-ID: <0c8e1bd6e8aeb7f377da1b5c28a93467307bb798.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753295655.git.scott.murray@konsulko.com>
References: <cover.1753295655.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1837

From: Yash Shinde <Yash.Shinde@windriver.com>

Rust stable version updated to 1.86.0.
https://blog.rust-lang.org/2025/04/03/Rust-1.86.0.html

* Add pkgconfig-native and openssl to resolve openssl-sys crate
dependency on pkg-config. As per rust document this is a required dependenc=
y.

Fixes:
| error: failed to run custom build command for `openssl-sys v0.9.106`
| Could not find openssl via pkg-config:
|   The pkg-config command could not be found.
|
|   Most likely, you need to install a pkg-config package for your OS.
|   Try `apt install pkg-config`, or `yum install pkg-config`,
|   or `pkg install pkg-config`, or `apk add pkgconfig` depending on your d=
istribution

https://crates.io/crates/openssl-sys/0.9.108/dependencies
https://github.com/rust-lang/rust/blob/master/INSTALL.md#dependencies

* Add Ninja as a dependency for building Rust to prevent bootstrap
  build regression.

Fixes:
| Building LLD for x86_64-unknown-linux-gnu
|
| Couldn't find required command: ninja (or ninja-build)
|
| You should install ninja as described at
| <https://github.com/ninja-build/ninja/wiki/Pre-built-Ninja-packages>,
| or set `ninja =3D false` in the `[llvm]` section of `config.toml`.
| Alternatively, set `download-ci-llvm =3D true` in that `[llvm]` section
| to download LLVM rather than building it.

* Add bash to DEPENDS to resolve missing dependency for subtree-sync.sh
Fixes:
ERROR: rust-1.86.0-r0 do_package_qa: QA Issue: /usr/lib/rustlib/src/rust/li=
brary/portable-simd/subtree-sync.sh
contained in package rust requires /bin/bash, but no providers found in RDE=
PENDS:rust? [file-rdeps]

* Add do_install:append() task to remove cargo bin from rust native builds.
This resolves the following conflict:

Fixes:
ERROR: libstd-rs-1.86.0-r0 do_prepare_recipe_sysroot: The file /usr/bin/car=
go is
installed by both rust-native and cargo-native, aborting

* Update Unicode-3.0 license checksums.
License-Update: Copyright and license files to distributions are updated.

https://github.com/rust-lang/rust/commit/f9c16997dc016a3ef1456f56df2ab564a1=
c48cb2
  It adds copyright and license files (including HTML versions) to distribu=
tions,
  aligns with license compliance tools like reuse, and ensures all required
  license texts are properly included and formatted.

* Disable building of extended Rust tools to reduce build time and filesyst=
em usage.
  Update config.toml to disable building of extended Rust tools that are no=
t required.
  This helps minimize unnecessary build time and filesystem usage.

* The "remote-test-server" bin is now generated in stage2-tools-bin dir
  rather than stage1. Update the test suite accordingly.

* Fix do_package QA issue by packing missing zsh files and directories:

Fixes:
do_package: QA Issue: rust: Files/directories were installed but not shippe=
d in any package:
/usr/share/zsh
/usr/share/zsh/site-functions
/usr/share/zsh/site-functions/_cargo
Please set FILES such that these items are packaged. Alternatively if they =
are unneeded,
avoid installing them or delete them within do_install

* From v1.86.0, a "self-contained" LLD is built as part of rust
 bootstrap build. This results in additional build time and
 installations. Disable rust-lld in config.toml to prevent it.

 References: https://github.com/rust-lang/rust/pull/135001
             https://github.com/rust-lang/rust/commit/8744b44e6bde053f7656a=
3c727c968177ee8e4b6

* Drop Zdual-proc-macros-additional-check.patch patch
 since it's merged with v1.86.0
 https://github.com/rust-lang/rust/commit/139d6ba054a1a4cc5fe64981ad46fd554=
7bd4916

* LTO config is applied to rustdoc from v1.86.0.
 Rebase 0001-src-core-build_steps-tool.rs-switch-off-lto-for-rust.patch
 which disables it to avoid suffixes in binaries causing non-reproducibilit=
y.
 https://github.com/rust-lang/rust/commit/1fe351b

* Restrict tests using "//@only <target_arch>" to avoid failures on riscv64,
  which is now part of default AB testing. Since riscv64 is Tier 2
  with no automated testing, some tests may fail. This approach ensures tes=
ts continue
  running on supported architectures while skipping them on riscv64.
  https://doc.rust-lang.org/rustc/platform-support.html#tier-2-with-host-to=
ols

Signed-off-by: Yash Shinde <Yash.Shinde@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit c064ef18343a956aea397d36d2e7665d6c8afd7d)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf                               |  2 +-
 lib/oeqa/selftest/cases/rust_mixin.py         |  2 +-
 .../rust/{cargo_1.85.1.bb =3D> cargo_1.86.0.bb} |  0
 ...l-codes-on-riscv32gc-unknown-linux-g.patch | 32 -------
 ...teps-tool.rs-switch-off-lto-for-rust.patch | 54 +++++++++---
 .../Zdual-proc-macros-additional-check.patch  | 31 -------
 .../rust/files/rust-oe-selftest.patch         | 85 +++++++++++--------
 ...ibstd-rs_1.85.1.bb =3D> libstd-rs_1.86.0.bb} |  2 +-
 ....85.1.bb =3D> rust-cross-canadian_1.86.0.bb} |  0
 ...ust-llvm_1.85.1.bb =3D> rust-llvm_1.86.0.bb} |  4 +-
 recipes-devtools/rust/rust-snapshot.inc       | 78 ++++++++---------
 recipes-devtools/rust/rust-source.inc         |  3 +-
 .../rust/{rust_1.85.1.bb =3D> rust_1.86.0.bb}   | 18 +++-
 13 files changed, 152 insertions(+), 159 deletions(-)
 rename recipes-devtools/rust/{cargo_1.85.1.bb =3D> cargo_1.86.0.bb} (100%)
 delete mode 100644 recipes-devtools/rust/files/Zdual-proc-macros-additiona=
l-check.patch
 rename recipes-devtools/rust/{libstd-rs_1.85.1.bb =3D> libstd-rs_1.86.0.bb=
} (95%)
 rename recipes-devtools/rust/{rust-cross-canadian_1.85.1.bb =3D> rust-cros=
s-canadian_1.86.0.bb} (100%)
 rename recipes-devtools/rust/{rust-llvm_1.85.1.bb =3D> rust-llvm_1.86.0.bb=
} (96%)
 rename recipes-devtools/rust/{rust_1.85.1.bb =3D> rust_1.86.0.bb} (96%)

diff --git a/conf/layer.conf b/conf/layer.conf
index 7db9965..00df38e 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERDEPENDS_scarthgap-rust-mixin =3D "core"
=20
 LICENSE_PATH +=3D "${LAYERDIR}/files/common-licenses"
=20
-RUSTVERSION ?=3D "1.85.1%"
+RUSTVERSION ?=3D "1.86.0%"
diff --git a/lib/oeqa/selftest/cases/rust_mixin.py b/lib/oeqa/selftest/case=
s/rust_mixin.py
index 806ddf6..d99a58d 100644
--- a/lib/oeqa/selftest/cases/rust_mixin.py
+++ b/lib/oeqa/selftest/cases/rust_mixin.py
@@ -104,7 +104,7 @@ class RustSelfTestSystemEmulated(OESelftestTestCase, OE=
PTestResultTestCase):
             # Copy remote-test-server to image through scp
             host_sys =3D get_bb_var("RUST_BUILD_SYS", "rust")
             ssh =3D SSHControl(ip=3Dqemu.ip, logfile=3Dqemu.sshlog, user=
=3D"root")
-            ssh.copy_to(builddir + "/build/" + host_sys + "/stage1-tools-b=
in/remote-test-server","~/")
+            ssh.copy_to(builddir + "/build/" + host_sys + "/stage2-tools-b=
in/remote-test-server","~/")
             # Execute remote-test-server on image through background ssh
             command =3D '~/remote-test-server --bind 0.0.0.0:12345 -v'
             sshrun=3Dsubprocess.Popen(("ssh", '-o',  'UserKnownHostsFile=
=3D/dev/null', '-o',  'StrictHostKeyChecking=3Dno', '-f', "root@%s" % qemu.=
ip, command), shell=3DFalse, stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.=
PIPE)
diff --git a/recipes-devtools/rust/cargo_1.85.1.bb b/recipes-devtools/rust/=
cargo_1.86.0.bb
similarity index 100%
rename from recipes-devtools/rust/cargo_1.85.1.bb
rename to recipes-devtools/rust/cargo_1.86.0.bb
diff --git a/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-ri=
scv32gc-unknown-linux-g.patch b/recipes-devtools/rust/files/0001-Define-mor=
e-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
index b3a95f2..82edd71 100644
--- a/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc=
-unknown-linux-g.patch
+++ b/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc=
-unknown-linux-g.patch
@@ -18,38 +18,6 @@ Signed-off-by: Khem Raj <raj.khem@gmail.com>
  .../src/unix/linux_like/linux/arch/generic/mod.rs           | 4 +++-
  6 files changed, 14 insertions(+), 6 deletions(-)
=20
-diff --git a/vendor/libc-0.2.158/.cargo-checksum.json b/vendor/libc-0.2.15=
8/.cargo-checksum.json
-index 636165bc0..dc86fd0db 100644
---- a/vendor/libc-0.2.158/.cargo-checksum.json
-+++ b/vendor/libc-0.2.158/.cargo-checksum.json
-@@ -1 +1 @@
--{"files":{"CHANGELOG.md":"96fb278d188e87842fe2701f91e0f757665b44dc2e549ac=
cb6ed1ed6eeb67602","CONTRIBUTING.md":"a93fcda0a76e1975fcfb0aa2ba00c9b1864f9=
ae6062704a294d81a3688898e10","Cargo.toml":"2196e21d3fd56b3019e235720a32b4e3=
c8ada82c08cb01c06c695752201396df","LICENSE-APACHE":"62c7a1e35f56406896d7aa7=
ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56=
a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"4da2919bb509f=
3f06163778478494f780ca6627cb79ccab5d2c828c8d88dc133","build.rs":"54387230fe=
d8d16f1169a845e92a1c1a5d9227559acbf3bfa383c7901b2d1be8","rustfmt.toml":"eaa=
2ea84fc1ba0359b77680804903e07bb38d257ab11986b95b158e460f787b2","src/fixed_w=
idth_ints.rs":"7f986e5f5e68d25ef04d386fd2f640e8be8f15427a8d4a458ea01d26b8dc=
a0ca","src/fuchsia/aarch64.rs":"893fcec48142d273063ffd814dca33fbec92205fd39=
ada97075f85201d803996","src/fuchsia/align.rs":"ae1cf8f011a99737eabeb14ffff7=
68e60f13b13363d7646744dbb0f443dab3d6","src/fuchsia/mod.rs":"a8e3ff551e5ff42=
47ab1faa1b7ca1e042046a619198e8b30fe183c6ef8485d65","src/fuchsia/no_align.rs=
":"303f3f1b255e0088b5715094353cf00476131d8e94e6aebb3f469557771c8b8a","src/f=
uchsia/riscv64.rs":"617cd75e79e0e20f664db764a4dc2a396d9fd11a4d95371acd91ed4=
811293b11","src/fuchsia/x86_64.rs":"93a3632b5cf67d2a6bcb7dc0a558605252d5fe6=
89e0f38d8aa2ec5852255ac87","src/hermit.rs":"ad1e8685edf3f3a7c141ccc0e82d44b=
7feb13e81f2f59ed6aeb6e4964524637c","src/lib.rs":"7f57f05b3d9e1e14a666aabbd9=
42cf5959e778966981e604087774d56eb059c8","src/macros.rs":"5f985b3de7b18833f8=
66bf832b8ffb0430f0f70aa9a468b6a2c855c1bf9d33e4","src/psp.rs":"0a7d5121a8cc2=
903009f586c00e4ae2d6126d24eb90531dafaba6f59823aa6b2","src/sgx.rs":"16a95cde=
fc81c5ee00d8353a60db363c4cc3e0f75abcd5d0144723f2a306ed1b","src/solid/aarch6=
4.rs":"a726e47f324adf73a4a0b67a2c183408d0cad105ae66acf36db37a42ab7f8707","s=
rc/solid/arm.rs":"e39a4f74ebbef3b97b8c95758ad741123d84ed3eb48d9cf4f1f487209=
7fc27fe","src/solid/mod.rs":"5f4151dca5132e4b4e4c23ab9737e12856dddbdc0ca3f7=
dbc004328ef3c8acde","src/switch.rs":"9da3dd39b3de45a7928789926e8572d00e1e11=
a39e6f7289a1349aadce90edba","src/teeos/mod.rs":"ecf8922923fb7541ef7b0813cdc=
5418b75be56247c4dbdbb7dca58a076f25b97","src/unix/aix/mod.rs":"91de34bf8237e=
4998e10f9274471d14fb9a31ac6f2ef6e44689066b8e280b3d3","src/unix/aix/powerpc6=
4.rs":"cf374d81139d45f9d77c6a764f640bfbf7e0a5903689652c8296f8e10d55169b","s=
rc/unix/align.rs":"2cdc7c826ef7ae61f5171c5ae8c445a743d86f1a7f2d9d7e4ceeec56=
d6874f65","src/unix/bsd/apple/b32/align.rs":"ec833a747866fe19ca2d9b4d3c9ff0=
385faba5edf4bd0d15fa68884c40b0e26c","src/unix/bsd/apple/b32/mod.rs":"2546ad=
3eb6aecb95f916648bc63264117c92b4b4859532b34cb011e4c75a5a72","src/unix/bsd/a=
pple/b64/aarch64/align.rs":"2eaf0f561a32bdcbf4e0477c8895d5e7bcb5cdebd5fef7b=
4df2ca8e38e144d94","src/unix/bsd/apple/b64/aarch64/mod.rs":"44c217a4f263afe=
7a97435de9323d20a96c37836f899ca0925306d4b7e073c27","src/unix/bsd/apple/b64/=
align.rs":"ec833a747866fe19ca2d9b4d3c9ff0385faba5edf4bd0d15fa68884c40b0e26c=
","src/unix/bsd/apple/b64/mod.rs":"f5e278a1af7fb358891d1c9be4eb7e815aaca0c5=
cb738d0c3604ba2208a856f7","src/unix/bsd/apple/b64/x86_64/align.rs":"ec833a7=
47866fe19ca2d9b4d3c9ff0385faba5edf4bd0d15fa68884c40b0e26c","src/unix/bsd/ap=
ple/b64/x86_64/mod.rs":"8c87c5855038aae5d433c8f5eb3b29b0a175879a0245342b3bf=
d83bdf4cfd936","src/unix/bsd/apple/long_array.rs":"3cf1f19b812e6d093c819dc6=
5ce55b13491963e0780eda0d0bd1577603e81948","src/unix/bsd/apple/mod.rs":"4846=
98da7c1083a46ae1a389486a8c2d75e3e6ecb4f80ded69b6c0dd2d1a92a0","src/unix/bsd=
/freebsdlike/dragonfly/errno.rs":"8295b8bb0dfd38d2cdb4d9192cdeeb534cc6c3b20=
8170e64615fa3e0edb3e578","src/unix/bsd/freebsdlike/dragonfly/mod.rs":"2777f=
94909a798df1b8030fb86d02e2118d0ac3e49e9a542df54a569ca5ae2f9","src/unix/bsd/=
freebsdlike/freebsd/aarch64.rs":"6c8e216385f53a4bf5f171749b57602fc34a4e4b16=
0a44ca31c058cb0c8a2126","src/unix/bsd/freebsdlike/freebsd/arm.rs":"59d6a670=
eea562fb87686e243e0a84603d29a2028a3d4b3f99ccc01bd04d2f47","src/unix/bsd/fre=
ebsdlike/freebsd/freebsd11/b64.rs":"9808d152c1196aa647f1b0f0cf84dac8c930da7=
d7f897a44975545e3d9d17681","src/unix/bsd/freebsdlike/freebsd/freebsd11/mod.=
rs":"e243ae0e89623d4fa9f85afe14369cc5fd5f2028ea715773dbec722ba80dac1f","src=
/unix/bsd/freebsdlike/freebsd/freebsd12/b64.rs":"61cbe45f8499bedb168106b686=
d4f8239472f25c7553b069eec2afe197ff2df6","src/unix/bsd/freebsdlike/freebsd/f=
reebsd12/mod.rs":"bef9fae288a4f29e941ea369be1cd20b170040e60665a4d49a4a9e790=
09b72d8","src/unix/bsd/freebsdlike/freebsd/freebsd12/x86_64.rs":"2df36a7f12=
2f6d6e5753cfb4d22e915cc80f6bc91c0161b3daae55a481bfd052","src/unix/bsd/freeb=
sdlike/freebsd/freebsd13/b64.rs":"61cbe45f8499bedb168106b686d4f8239472f25c7=
553b069eec2afe197ff2df6","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs=
":"88be47524b28b6635ccb1e85ea511bf17337be0af7e9baa740c341ac9e83a6f7","src/u=
nix/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"2df36a7f122f6d6e5753cfb4d=
22e915cc80f6bc91c0161b3daae55a481bfd052","src/unix/bsd/freebsdlike/freebsd/=
freebsd14/b64.rs":"61cbe45f8499bedb168106b686d4f8239472f25c7553b069eec2afe1=
97ff2df6","src/unix/bsd/freebsdlike/freebsd/freebsd14/mod.rs":"6ddc6abf6d5c=
caea0d8cccf521e8ca6457efcad3086af4155628d5d06d672346","src/unix/bsd/freebsd=
like/freebsd/freebsd14/x86_64.rs":"e7b5863e222d6cc416b6b0fbe71690fad909e899=
b4c4ae810bbca117e4fcb650","src/unix/bsd/freebsdlike/freebsd/freebsd15/b64.r=
s":"61cbe45f8499bedb168106b686d4f8239472f25c7553b069eec2afe197ff2df6","src/=
unix/bsd/freebsdlike/freebsd/freebsd15/mod.rs":"93115c1a9faa43ebf58b7dee358=
2aed5a54291b284764e370e7f649b2e6a9565","src/unix/bsd/freebsdlike/freebsd/fr=
eebsd15/x86_64.rs":"e7b5863e222d6cc416b6b0fbe71690fad909e899b4c4ae810bbca11=
7e4fcb650","src/unix/bsd/freebsdlike/freebsd/mod.rs":"08e39a42392936857fd0c=
1c6b01788f5630fe8ff7f78b062490509c5dd816a42","src/unix/bsd/freebsdlike/free=
bsd/powerpc.rs":"9ca3f82f88974e6db5569f2d76a5a3749b248a31747a6c0da5820492bd=
feca42","src/unix/bsd/freebsdlike/freebsd/powerpc64.rs":"2dae3ecc87eac3b116=
57aa98915def55fc4b5c0de11fe26aae23329a54628a9a","src/unix/bsd/freebsdlike/f=
reebsd/riscv64.rs":"fa4bed4c58cad24ba3395941c7fa6b11e089551a04714f9561078e4=
00f5b2b62","src/unix/bsd/freebsdlike/freebsd/x86.rs":"2837fed0ffee0ec443ecd=
b743b7142bcb4d6ba2de87e05459fb4498789d47200","src/unix/bsd/freebsdlike/free=
bsd/x86_64/align.rs":"0e1f69a88fca1c32874b1daf5db3d446fefbe518dca497f096cc9=
168c39dde70","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.rs":"e4d76219bec0=
621db07dec37de9be1a9b7fb38daa10ffc1a6adbdbc34e163435","src/unix/bsd/freebsd=
like/mod.rs":"c846f30eaffc7c1a21b4acd3df75cd17bb3d4f11401c9a9770924e4e6d847=
995","src/unix/bsd/mod.rs":"37765749481f7d0dec8681d8c9d0735e6021094b4ef4a2d=
9aab5643d7a4232e1","src/unix/bsd/netbsdlike/mod.rs":"ea60540aa4edd4e4313674=
9d5df497b1dc072b9912b6030dd1ab794a6d1c3c3c","src/unix/bsd/netbsdlike/netbsd=
/aarch64.rs":"057ee877db7193ba0dc10801b9a6563ac6dbdb78376d6851a84cb12b30841=
759","src/unix/bsd/netbsdlike/netbsd/arm.rs":"949b55e4dee1c8c511f4f061a6a57=
ac876a6c0eabfaf5cc20e9ab40d8f41b2e0","src/unix/bsd/netbsdlike/netbsd/mips.r=
s":"88be18ac43ba224c77e78e4179b6761debc5e6c30a258fac56263809c7af4fbc","src/=
unix/bsd/netbsdlike/netbsd/mod.rs":"ab09cea2897ecd27fc7e35822dac23d6dcd53f8=
577c771db3ee8b015e8d82001","src/unix/bsd/netbsdlike/netbsd/powerpc.rs":"ee7=
ff5d89d0ed22f531237b5059aa669df93a3b5c489fa641465ace8d405bf41","src/unix/bs=
d/netbsdlike/netbsd/riscv64.rs":"1cbe2e5ed681cb1054b699da37daaf6c714267df7d=
332c90fc2a589b11579625","src/unix/bsd/netbsdlike/netbsd/sparc64.rs":"9489f4=
b3e4566f43bb12dfb92238960613dac7f6a45cc13068a8d152b902d7d9","src/unix/bsd/n=
etbsdlike/netbsd/x86.rs":"20692320e36bfe028d1a34d16fe12ca77aa909cb02bda1673=
76f98f1a09aefe7","src/unix/bsd/netbsdlike/netbsd/x86_64.rs":"532b76199d6c71=
ff996eade9f906c55a72c9aff489595d25a21e21878cfd740b","src/unix/bsd/netbsdlik=
e/openbsd/aarch64.rs":"dd91931d373b7ecaf6e2de25adadee10d16fa9b12c2cbacdff3e=
b291e1ba36af","src/unix/bsd/netbsdlike/openbsd/arm.rs":"01580d261bc6447bb32=
7a0d982181b7bdabfa066cee65a30373d3ced729ad307","src/unix/bsd/netbsdlike/ope=
nbsd/mips64.rs":"8532a189ae10c7d668d9d4065da8b05d124e09bd39442c9f74a7f231c4=
3eca48","src/unix/bsd/netbsdlike/openbsd/mod.rs":"7b93b5b24b3c72a79b2de19b4=
7ac2f56b29d87e9fc8f4c721a63d1e87ec83fcc","src/unix/bsd/netbsdlike/openbsd/p=
owerpc.rs":"01580d261bc6447bb327a0d982181b7bdabfa066cee65a30373d3ced729ad30=
7","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"1dd5449dd1fd3d51e30ffdee=
aece91d0aaf05c710e0ac699fecc5461cfa2c28e","src/unix/bsd/netbsdlike/openbsd/=
riscv64.rs":"1fe3332dc705a13e6242219970f5449d6d7a73e2e6c8537ab8e421d8a6f2e3=
ff","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"d04fd287afbaa2c5df9d48c94=
e8374a532a3ba491b424ddf018270c7312f4085","src/unix/bsd/netbsdlike/openbsd/x=
86.rs":"6f7f5c4fde2a2259eb547890cbd86570cea04ef85347d7569e94e679448bec87","=
src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"d31db31630289c85af3339dbe357998=
a21ca584cbae31607448fe2cf7675a4e1","src/unix/haiku/b32.rs":"a2efdbf7158a6da=
341e1db9176b0ab193ba88b449616239ed95dced11f54d87b","src/unix/haiku/b64.rs":=
"ff8115367d3d7d354f792d6176dfaaa26353f57056197b563bf4681f91ff7985","src/uni=
x/haiku/mod.rs":"b75976d84bdf4a3a226336bb06ec231d552240f302bb5da48ead692fd7=
2758f9","src/unix/haiku/native.rs":"2b1f88c043777a915bb7218aa05a3647a0e0481=
ebff55a99e351c45dea2be8de","src/unix/haiku/x86_64.rs":"3ec3aeeb7ed208b8916f=
3e32d42bfd085ff5e16936a1a35d9a52789f043b7237","src/unix/hurd/align.rs":"03c=
79b2cd8270ebd0cf93cb475a8f1ff85b28175ea0de007ede17cad94a89b03","src/unix/hu=
rd/b32.rs":"2ba90ed973f90366c36a6387833a3df42abfee9622d4a0352635937d4a89eaf=
4","src/unix/hurd/b64.rs":"d919b4aec9b3080ad24c125c57b2c8b2e483d72045f1554c=
429d14560355846f","src/unix/hurd/mod.rs":"23ebadfdb9a92d7fb9e32b6a7c95669ce=
979ba7407b924869f40a59d2807d052","src/unix/hurd/no_align.rs":"03c79b2cd8270=
ebd0cf93cb475a8f1ff85b28175ea0de007ede17cad94a89b03","src/unix/linux_like/a=
ndroid/b32/arm.rs":"ce582de7e983a33d3bfad13075c53aac9016cee35f06ad8653ee907=
2c3ec2564","src/unix/linux_like/android/b32/mod.rs":"7c173e0375119bf06a3081=
652faede95e5bcd6858e7576b7533d037978737c8f","src/unix/linux_like/android/b3=
2/x86/align.rs":"812914e4241df82e32b12375ca3374615dc3a4bdd4cf31f0423c581532=
0c0dab","src/unix/linux_like/android/b32/x86/mod.rs":"e6d107efbcd37b5b85dfa=
18f683300cbf768ffa0237997a9fa52b184a53323ac","src/unix/linux_like/android/b=
64/aarch64/align.rs":"2179c3b1608fa4bf68840482bfc2b2fa3ee2faf6fcae3770f9e50=
5cddca35c7b","src/unix/linux_like/android/b64/aarch64/int128.rs":"1735f6f5c=
56770d20dd426442f09724d9b2052b46a7cd82f23f3288a4a7276de","src/unix/linux_li=
ke/android/b64/aarch64/mod.rs":"873af67c4a9757ead56bc797d04efcecd311ecbf008=
4ebdd198fb690463ef299","src/unix/linux_like/android/b64/mod.rs":"7b8efbd61a=
b965c93bacfab78108ff8eed38af07b119099020dc41a9d0901559","src/unix/linux_lik=
e/android/b64/riscv64/align.rs":"0bf138f84e5327d8339bcd4adf071a6832b516445e=
597552c82bbd881095e3a8","src/unix/linux_like/android/b64/riscv64/mod.rs":"1=
9d4bf2237c47127eba9144e0b82e995bc079315e719179a91813b0ae7b0e49d","src/unix/=
linux_like/android/b64/x86_64/align.rs":"7169d07a9fd4716f7512719aec9fda5d8b=
ed306dc0720ffc1b21696c9951e3c6","src/unix/linux_like/android/b64/x86_64/mod=
.rs":"4ec2de11a9b65c4325b7b991f0b99a414975e0e61ba8668caca5d921e9b314d1","sr=
c/unix/linux_like/android/mod.rs":"384275dc1d3559a9f83559b6c903758a9dc4c4b3=
d13db48d23ed4fdc3c0ff8da","src/unix/linux_like/emscripten/align.rs":"86c95c=
bed7a7161b1f23ee06843e7b0e2340ad92b2cb86fe2a8ef3e0e8c36216","src/unix/linux=
_like/emscripten/lfs64.rs":"3776af30a758d765a88920ec4fde442ab89040da13d3b36=
25c7fbcb8a958559f","src/unix/linux_like/emscripten/mod.rs":"70d4591730a731e=
e32788a9d8d2de379592844ec36b7d1723514179605587713","src/unix/linux_like/ems=
cripten/no_align.rs":"0128e4aa721a9902754828b61b5ec7d8a86619983ed1e0544a85d=
35b1051fad6","src/unix/linux_like/linux/align.rs":"bc5abcd38e2320171e0981e7=
73c9c5fe3e0d5a66fdff049228f6a1acad80ef8b","src/unix/linux_like/linux/arch/g=
eneric/mod.rs":"3ab533349696d24505adb6bb9183d73fd5e3b17e2f90dd21478af2a47b4=
d6fa8","src/unix/linux_like/linux/arch/mips/mod.rs":"ca3db0e3ae852abf18f358=
8e40d5d64707fcc1829e08ddc5da1080e1a92c8851","src/unix/linux_like/linux/arch=
/mod.rs":"5bd5361f8a6ab4e18bbba6da9f92c164ae252b15a0ed10064812544aa1fdf198"=
,"src/unix/linux_like/linux/arch/powerpc/mod.rs":"0bc2d2667a00eca81f4abeb6d=
613a90848a947f51224103f83268928b8197629","src/unix/linux_like/linux/arch/sp=
arc/mod.rs":"5e6777863e74a9e2aa9dc487f1059783dd211babc2b32d6bf676f311e49c55=
d6","src/unix/linux_like/linux/gnu/align.rs":"e4a3c27fe20a57b8d612c34cb05bc=
70646edb5cec7251957315afa53a7b9f936","src/unix/linux_like/linux/gnu/b32/arm=
/align.rs":"6ec0eb3ee93f7ae99fd714b4deabfb5e97fbcefd8c26f5a45fb8e7150899cde=
b","src/unix/linux_like/linux/gnu/b32/arm/mod.rs":"f68ec59b6407f9d4e326f3e7=
1a41ec21f19ecfc703edf9a93e496f661fed5506","src/unix/linux_like/linux/gnu/b3=
2/csky/align.rs":"3fed009dc9af3cc81be7087da9d2d7d1f39845e4497e290259c5cdbae=
25f039d","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"8729b68e433e94c21=
28e51a7db4fd555938e4be4dc64584c352b24a20d9c8e91","src/unix/linux_like/linux=
/gnu/b32/m68k/align.rs":"8faa92f77a9232c035418d45331774e64a9a841d99c9179157=
0a203bf2b45bcb","src/unix/linux_like/linux/gnu/b32/m68k/mod.rs":"80956d3fef=
163ecf248828a6f38782dd8ae856d86b1bb5aac2de36032dbd8ea0","src/unix/linux_lik=
e/linux/gnu/b32/mips/align.rs":"429fb5e005cb7143602d430098b6ebfb7d360685b19=
4f333dfd587472ae954ee","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"96e=
22350d5d132d917c743d6560464500652c67b52c3d0e8474494487df3365d","src/unix/li=
nux_like/linux/gnu/b32/mod.rs":"b56625dd20dd48a8699034d349ef089c540c0ddcbf8=
a3481d598d101f8b40b78","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"20fc=
3cc4fe1ef6617b63b61b897f782ceb9c2842fc718f504a1840537229bf47","src/unix/lin=
ux_like/linux/gnu/b32/riscv32/align.rs":"d321491612be8d5c61b6ec2dc0111beb3a=
22e58803f99cd37543efe86621b119","src/unix/linux_like/linux/gnu/b32/riscv32/=
mod.rs":"887288a0a1cfff319d0e15edcdc4fcb31fd643ff41715ec5244c8f2413624169",=
"src/unix/linux_like/linux/gnu/b32/sparc/align.rs":"21adbed27df73e2d1ed934a=
af733a643003d7baf2bde9c48ea440895bcca6d41","src/unix/linux_like/linux/gnu/b=
32/sparc/mod.rs":"cc4342b949e4d796f304acd9dfe3f721a1c2f37fec16b42d3bb27dc94=
723af37","src/unix/linux_like/linux/gnu/b32/x86/align.rs":"e4bafdc4a519a792=
2a81b37a62bbfd1177a2f620890eef8f1fbc47162e9eb413","src/unix/linux_like/linu=
x/gnu/b32/x86/mod.rs":"06d4db4ee8352f62a0a5ead0c4d6ea0a78feff522f19b9bc5772=
f6dd920ffd80","src/unix/linux_like/linux/gnu/b64/aarch64/align.rs":"fdf1c72=
375a2167699157e0dd825422690bb6719f7bc69515a2e5846d0431d7c","src/unix/linux_=
like/linux/gnu/b64/aarch64/fallback.rs":"832e7487249c1c0bb6e9911ce3f7d32ca2=
2378e42392ab83c56915cbc59d8be3","src/unix/linux_like/linux/gnu/b64/aarch64/=
ilp32.rs":"bf4611b737813deef6787babf6c01698605f3b75482269b8546318667bc68e29=
","src/unix/linux_like/linux/gnu/b64/aarch64/int128.rs":"1735f6f5c56770d20d=
d426442f09724d9b2052b46a7cd82f23f3288a4a7276de","src/unix/linux_like/linux/=
gnu/b64/aarch64/lp64.rs":"11a950697fdda0258c6e37c6b13993348c8de4134105ed4fa=
a79358e53175072","src/unix/linux_like/linux/gnu/b64/aarch64/mod.rs":"820261=
4484da36c388d2ffdd2554c56bb4f9db8e5bd621f8c36114cdcfeec644","src/unix/linux=
_like/linux/gnu/b64/loongarch64/align.rs":"060aa33cc737966c691aab8511c5c572=
9e551458ce18d0e284e0d45f39beeb60","src/unix/linux_like/linux/gnu/b64/loonga=
rch64/mod.rs":"10f025edecebc6e0ed8fdae4736ebe7564189741d5b910433f07c21fc12a=
94d8","src/unix/linux_like/linux/gnu/b64/mips64/align.rs":"7169d07a9fd4716f=
7512719aec9fda5d8bed306dc0720ffc1b21696c9951e3c6","src/unix/linux_like/linu=
x/gnu/b64/mips64/mod.rs":"73532be4b5775acf9524c77feeefe1f6d1936ceffef908d01=
dd2586986520f2d","src/unix/linux_like/linux/gnu/b64/mod.rs":"6a160ef25439c4=
fecdb0e3bd0b818742263c791364da874d4febd3aa644ec8e2","src/unix/linux_like/li=
nux/gnu/b64/powerpc64/align.rs":"e29c4868bbecfa4a6cd8a2ad06193f3bbc78a468cc=
1dc9df83f002f1268130d9","src/unix/linux_like/linux/gnu/b64/powerpc64/mod.rs=
":"a90c2641616c620e9d1fea87695ce046e14f9da2282bb93f761eeb4077c74741","src/u=
nix/linux_like/linux/gnu/b64/riscv64/align.rs":"fe7e3c928d0367c37eb65268659=
1801c3694a3558ebbbeb5c22be692265d07f2","src/unix/linux_like/linux/gnu/b64/r=
iscv64/mod.rs":"dec86883731f7b8419bff35b125b40eefc927090c1510f6daf931726f79=
65c0b","src/unix/linux_like/linux/gnu/b64/s390x.rs":"1ea9e39432ce6bf68779d3=
3546dacd7d39477a9f8fc3da4f4f339e4538cb74c3","src/unix/linux_like/linux/gnu/=
b64/sparc64/align.rs":"e29c4868bbecfa4a6cd8a2ad06193f3bbc78a468cc1dc9df83f0=
02f1268130d9","src/unix/linux_like/linux/gnu/b64/sparc64/mod.rs":"bed381c44=
cec2a5b50125f7e548ab487d4c829006c971d152a611b7141760052","src/unix/linux_li=
ke/linux/gnu/b64/x86_64/align.rs":"62e822478356db4a73b6bbd1b36d825b893939ab=
4b308ec11b0578bcc4b49769","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs"=
:"332846e4a5920d7e6b05df0448a2333c5dd00fb27cb33654648f507ee89dbec5","src/un=
ix/linux_like/linux/gnu/b64/x86_64/not_x32.rs":"38f74ce15d9662ce4818815a2b8=
7be1618d5e45f190f7e4db84ff3285b4421fb","src/unix/linux_like/linux/gnu/b64/x=
86_64/x32.rs":"b20218a11364a6dec87f96d6c0d8b19e660697ab09ad5ee0e9b3a9dafeda=
aebb","src/unix/linux_like/linux/gnu/mod.rs":"8d11f66db9993e9a89c86fec3b732=
d9c0ec4ee42d9570d4e3389c075021dd29f","src/unix/linux_like/linux/gnu/no_alig=
n.rs":"9cd223135de75315840ff9c3fd5441ba1cb632b96b5c85a76f8316c86653db25","s=
rc/unix/linux_like/linux/mod.rs":"da8c17828415fc1db81fb547fe20b7421774a3bdd=
3e79053cc127a3031e59302","src/unix/linux_like/linux/musl/b32/arm/align.rs":=
"3e8ac052c1043764776b54c93ba4260e061df998631737a897d9d47d54f7b80c","src/uni=
x/linux_like/linux/musl/b32/arm/mod.rs":"af10147d7c3661751750a58ffad089d5d1=
8d180cd18303c653aef126c07ccd91","src/unix/linux_like/linux/musl/b32/hexagon=
.rs":"d079cab42529f7dab699334d43168c74ff4aa0282f11040a8b7d274b65767a7a","sr=
c/unix/linux_like/linux/musl/b32/mips/align.rs":"429fb5e005cb7143602d430098=
b6ebfb7d360685b194f333dfd587472ae954ee","src/unix/linux_like/linux/musl/b32=
/mips/mod.rs":"e44043766f7cd26de7ffa4232654afb6feb03e58dbd5890717970887bd00=
3151","src/unix/linux_like/linux/musl/b32/mod.rs":"31677597fd9544c4b1ec1477=
628288f6273fabbc06e38f33da862ad55f019ce1","src/unix/linux_like/linux/musl/b=
32/powerpc.rs":"3dae56a4e7789bcc5314e419fea5e4b2495367b4f1a49d1c9477c60225d=
65eef","src/unix/linux_like/linux/musl/b32/riscv32/align.rs":"efd2accf33b87=
de7c7547903359a5da896edc33cd6c719552c7474b60d4a5d48","src/unix/linux_like/l=
inux/musl/b32/riscv32/mod.rs":"3ee845d272f91a1908d5f421d7c353e1f14681bbdfef=
64410e408f4c14365a91","src/unix/linux_like/linux/musl/b32/x86/align.rs":"08=
e77fbd7435d7dec2ff56932433bece3f02e47ce810f89004a275a86d39cbe1","src/unix/l=
inux_like/linux/musl/b32/x86/mod.rs":"f2b53ae0034c833244b7cdb8c670349bf8272=
a03abf04152eba65cf62810484d","src/unix/linux_like/linux/musl/b64/aarch64/al=
ign.rs":"6ba32725d24d7d8e6aa111f3b57aafa318f83b606abe96561329151829821133",=
"src/unix/linux_like/linux/musl/b64/aarch64/int128.rs":"1735f6f5c56770d20dd=
426442f09724d9b2052b46a7cd82f23f3288a4a7276de","src/unix/linux_like/linux/m=
usl/b64/aarch64/mod.rs":"45ce6897afcc960267bb7505702b639daf94dc69428a213bf1=
aefd367ca32adc","src/unix/linux_like/linux/musl/b64/loongarch64/align.rs":"=
060aa33cc737966c691aab8511c5c5729e551458ce18d0e284e0d45f39beeb60","src/unix=
/linux_like/linux/musl/b64/loongarch64/mod.rs":"3d9ef92e682a1789544a2bd20ca=
d5a5623db9d7d9f5d0a3692bb0230af034165","src/unix/linux_like/linux/musl/b64/=
mips64.rs":"a968ef9c54fa22293085f318c8472c1754482df92cc500568dc33bd807d71ea=
6","src/unix/linux_like/linux/musl/b64/mod.rs":"20ceaf90a03c24a2eb154a5dffb=
fc9a538348404db5b554a3d8126021ba45509","src/unix/linux_like/linux/musl/b64/=
powerpc64.rs":"140e579800a67315f4cb8a42b22aa8157eae34ffe626e77e421b43c53c23=
b34d","src/unix/linux_like/linux/musl/b64/riscv64/align.rs":"fe7e3c928d0367=
c37eb652686591801c3694a3558ebbbeb5c22be692265d07f2","src/unix/linux_like/li=
nux/musl/b64/riscv64/mod.rs":"c5944526d7e19cd43e9d14d119a1d98f8780db7ecbcc7=
9e69d7b9348e596b520","src/unix/linux_like/linux/musl/b64/s390x.rs":"8557b34=
77ca8cefef7fce764a3c25441929a54e50ead4091f6f7823c427cd728","src/unix/linux_=
like/linux/musl/b64/x86_64/align.rs":"77309276ad7a42cbe59ca381f23590b7a143a=
ded05555b34a5b307b808cbca6e","src/unix/linux_like/linux/musl/b64/x86_64/mod=
.rs":"a91c4f18027c9958037f78ae48f6352d23cb4e6f2995b2cc8de7dce0e5759470","sr=
c/unix/linux_like/linux/musl/lfs64.rs":"3e4fb381f3a0756520bde0f1692d4fa45e4=
ae8133bf7d7c64b0e3fdd512f235f","src/unix/linux_like/linux/musl/mod.rs":"94d=
d7eb5064230637ccd135383c7d30f8d3f7874c22771b24b529e58de421731","src/unix/li=
nux_like/linux/no_align.rs":"62cdca0e011937aaf09a51ca86d9f0ee0fdb05f61ec3c0=
58e6a5d5fa6357d784","src/unix/linux_like/linux/non_exhaustive.rs":"181a05bf=
94fdb911db83ce793b993bd6548a4115b306a7ef3c10f745a8fea3e9","src/unix/linux_l=
ike/linux/uclibc/align.rs":"9ed16138d8e439bd90930845a65eafa7ebd67366e6bf633=
936d44014f6e4c959","src/unix/linux_like/linux/uclibc/arm/align.rs":"e4a3c27=
fe20a57b8d612c34cb05bc70646edb5cec7251957315afa53a7b9f936","src/unix/linux_=
like/linux/uclibc/arm/mod.rs":"50288ff9e411ab0966da24838f2c2a5618021bc19c42=
2a04f577b2979ef4081e","src/unix/linux_like/linux/uclibc/arm/no_align.rs":"9=
cd223135de75315840ff9c3fd5441ba1cb632b96b5c85a76f8316c86653db25","src/unix/=
linux_like/linux/uclibc/mips/mips32/align.rs":"e4a3c27fe20a57b8d612c34cb05b=
c70646edb5cec7251957315afa53a7b9f936","src/unix/linux_like/linux/uclibc/mip=
s/mips32/mod.rs":"d0c4434e2bf813372c418a8f516c706cdccc9f7be2f0921b2207b0afd=
b66fe81","src/unix/linux_like/linux/uclibc/mips/mips32/no_align.rs":"9cd223=
135de75315840ff9c3fd5441ba1cb632b96b5c85a76f8316c86653db25","src/unix/linux=
_like/linux/uclibc/mips/mips64/align.rs":"a7bdcb18a37a2d91e64d5fad83ea3edc7=
8f5412adb28f77ab077dbb26dd08b2d","src/unix/linux_like/linux/uclibc/mips/mip=
s64/mod.rs":"3f38ee6a4690b9d7594be20d216467a34d955f7653c2c8ce1e6147daeb53f1=
e0","src/unix/linux_like/linux/uclibc/mips/mips64/no_align.rs":"4a18e387569=
8c85229599225ac3401a2a40da87e77b2ad4ef47c6fcd5a24ed30","src/unix/linux_like=
/linux/uclibc/mips/mod.rs":"a048fce1c2d9b1ad57305642e8ad05ca0f0c7e4753267a2=
e2d6b4fee5db3b072","src/unix/linux_like/linux/uclibc/mod.rs":"6efae7ed906bc=
5773dcce43ba1045cf93df5f8dac41f194d8cddc0579f14c015","src/unix/linux_like/l=
inux/uclibc/no_align.rs":"3f28637046524618adaa1012e26cb7ffe94b9396e6b518ccc=
dc69d59f274d709","src/unix/linux_like/linux/uclibc/x86_64/l4re.rs":"8485b91=
82b7c67f7344fab377e7cc2a72afefd9ab63837c860514abba9728d76","src/unix/linux_=
like/linux/uclibc/x86_64/mod.rs":"e7197f0f68ece174c8ae42b2b9115893abfcdbe44=
a1a6ed98fb3cbd7bfe087e8","src/unix/linux_like/linux/uclibc/x86_64/other.rs"=
:"42c3f71e58cabba373f6a55a623f3c31b85049eb64824c09c2b082b3b2d6a0a8","src/un=
ix/linux_like/mod.rs":"863f628cbaa864911ffebc58e9fb788b6c6a9651955fc401ac1f=
40f20eb62505","src/unix/mod.rs":"5f851ce1756443b9219edd11b6cc2abfb4031a22a6=
496bb5d4d6090f97779f8a","src/unix/newlib/aarch64/mod.rs":"964c096288da836b5=
3c0c71d7f3a97048d177da220a69314c5ce93ba330d72af","src/unix/newlib/align.rs"=
:"28aaf87fafbc6b312622719d472d8cf65f9e5467d15339df5f73e66d8502b28a","src/un=
ix/newlib/arm/mod.rs":"cf754f8b1197489fca01e881a4b4b146e814998e4b365f116fa1=
a102c00e6a4e","src/unix/newlib/espidf/mod.rs":"689e29a9fff5a263e5ab8410d0a8=
919f77fa64aa12f4d71f71085a6f07f19f67","src/unix/newlib/generic.rs":"5f0b5d0=
7ddb5a5d60580f9561fdb05e9218d9751d4068c4aadad2ba6b950aabf","src/unix/newlib=
/horizon/mod.rs":"3a521d22bf932fc01c1d26d1f9bff20f11b1855b03c8236a8eb18310f=
6cab5a8","src/unix/newlib/mod.rs":"e5d5faf27a6336b9f1c02b8726427801d906a14d=
ae766852b4e85c1a92df06c8","src/unix/newlib/no_align.rs":"e0743b2179495a9514=
bc3a4d1781e492878c4ec834ee0085d0891dd1712e82fb","src/unix/newlib/powerpc/mo=
d.rs":"cc9e188711b9bf614323ad6c48e0d2e1a1ecc5d3bc64961ba451f29c6c22d2d8","s=
rc/unix/newlib/vita/mod.rs":"ff1caf74bb0696fe15d60dbac598db4520cd538aa0f598=
9713d97d008eee6ad8","src/unix/no_align.rs":"c06e95373b9088266e0b14bba0954ee=
f95f93fb2b01d951855e382d22de78e53","src/unix/nto/aarch64.rs":"4709c9afdc8d5=
83be876598e7c238499ee3e8da5bd2baa614d9c7dd414851555","src/unix/nto/mod.rs":=
"5eb045c352114f5d744d098acaf9e47a9223f6fccd43f36b9a3ba79b29af0eee","src/uni=
x/nto/neutrino.rs":"799bff4ab01a6424db6c5a2b76aa5679826d41495f9d13c63485bf1=
3bc80026b","src/unix/nto/x86_64.rs":"a3e18e93c2999da1cd7a6f748a4b60c07aefb7=
3d8ea2aafec19a84cfb040bc8e","src/unix/redox/mod.rs":"e75a319975472fe9e08732=
44fb07c5d2004672b7a4cf7a3cb01532d6d394cb8a","src/unix/solarish/compat.rs":"=
00f1ee3faec9da69204e42f025f6735dd13d894071a154425dcc43ecbdd06e7f","src/unix=
/solarish/illumos.rs":"26171da367221de1e456f1236250b5831a770d6f109ed12b0ebe=
4d508e490194","src/unix/solarish/mod.rs":"c0c5dfc406d728666010cdc2fe21b0df4=
0547ed20dd7ad0eab65906e103b6d4b","src/unix/solarish/solaris.rs":"41b350a89d=
df01cd12a10f93640f92be53be0b0d976021cdc08da17bf3e72edf","src/unix/solarish/=
x86.rs":"e86e806df0caed72765040eaa2f3c883198d1aa91508540adf9b7008c77f522e",=
"src/unix/solarish/x86_64.rs":"ec2b01f194eb8a6a27133c57681da195a949e03098f3=
ea1e847227a9c09ef5fc","src/unix/solarish/x86_common.rs":"ac869d9c3c95645c22=
460468391eb1982023c3a8e02b9e06a72e3aef3d5f1eac","src/vxworks/aarch64.rs":"9=
8f0afdc511cd02557e506c21fed6737585490a1dce7a9d4941d08c437762b99","src/vxwor=
ks/arm.rs":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e8=
8","src/vxworks/mod.rs":"ccdb6a6e0c12011705a15dadc04b26882e6090db4403af4d15=
cad9330ef96370","src/vxworks/powerpc.rs":"acb7968ce99fe3f4abdf39d98f8133d21=
a4fba435b8ef7084777cb181d788e88","src/vxworks/powerpc64.rs":"98f0afdc511cd0=
2557e506c21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/x86.rs":"5=
52f007f38317620b23889cb7c49d1d115841252439060122f52f434fbc6e5ba","src/vxwor=
ks/x86_64.rs":"018d92be3ad628a129eff9f2f5dfbc0883d8b8e5f2fa917b900a7f98ed6b=
514a","src/wasi.rs":"51e38bb98547c40d0822d31975c976cd6e0784463d90d170109c87=
bf324395d3","src/windows/gnu/align.rs":"b2c13ec1b9f3b39a75c452c80c951dff9d0=
215e31d77e883b4502afb31794647","src/windows/gnu/mod.rs":"3c8c7edb7cdf5d0c44=
af936db2a94869585c69dfabeef30571b4f4e38375767a","src/windows/mod.rs":"9fdc5=
e1c62c441abef7bc62a7343efb2041edc24db9ac0efc0f74df55b69e249","src/windows/m=
svc/mod.rs":"c068271e00fca6b62bc4bf44bcf142cfc38caeded9b6c4e01d1ceef3ccf986=
f4","src/xous.rs":"eb0675f25ba01f73072d2b70907fb8abb1148facefe5a20756c49250=
f3d65fae","tests/const_fn.rs":"cb75a1f0864f926aebe79118fc34d51a0d1ade2c20a3=
94e7774c7e545f21f1f4"},"package":"d8adc4bb1803a324070e64a98ae98f38934d91957=
a99cfb3a43dcbc01bc56439"}
-\ No newline at end of file
-+{"files":{"CHANGELOG.md":"96fb278d188e87842fe2701f91e0f757665b44dc2e549ac=
cb6ed1ed6eeb67602","CONTRIBUTING.md":"a93fcda0a76e1975fcfb0aa2ba00c9b1864f9=
ae6062704a294d81a3688898e10","Cargo.toml":"2196e21d3fd56b3019e235720a32b4e3=
c8ada82c08cb01c06c695752201396df","LICENSE-APACHE":"62c7a1e35f56406896d7aa7=
ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56=
a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"4da2919bb509f=
3f06163778478494f780ca6627cb79ccab5d2c828c8d88dc133","build.rs":"54387230fe=
d8d16f1169a845e92a1c1a5d9227559acbf3bfa383c7901b2d1be8","rustfmt.toml":"eaa=
2ea84fc1ba0359b77680804903e07bb38d257ab11986b95b158e460f787b2","src/fixed_w=
idth_ints.rs":"7f986e5f5e68d25ef04d386fd2f640e8be8f15427a8d4a458ea01d26b8dc=
a0ca","src/fuchsia/aarch64.rs":"893fcec48142d273063ffd814dca33fbec92205fd39=
ada97075f85201d803996","src/fuchsia/align.rs":"ae1cf8f011a99737eabeb14ffff7=
68e60f13b13363d7646744dbb0f443dab3d6","src/fuchsia/mod.rs":"a8e3ff551e5ff42=
47ab1faa1b7ca1e042046a619198e8b30fe183c6ef8485d65","src/fuchsia/no_align.rs=
":"303f3f1b255e0088b5715094353cf00476131d8e94e6aebb3f469557771c8b8a","src/f=
uchsia/riscv64.rs":"617cd75e79e0e20f664db764a4dc2a396d9fd11a4d95371acd91ed4=
811293b11","src/fuchsia/x86_64.rs":"93a3632b5cf67d2a6bcb7dc0a558605252d5fe6=
89e0f38d8aa2ec5852255ac87","src/hermit.rs":"ad1e8685edf3f3a7c141ccc0e82d44b=
7feb13e81f2f59ed6aeb6e4964524637c","src/lib.rs":"7f57f05b3d9e1e14a666aabbd9=
42cf5959e778966981e604087774d56eb059c8","src/macros.rs":"5f985b3de7b18833f8=
66bf832b8ffb0430f0f70aa9a468b6a2c855c1bf9d33e4","src/psp.rs":"0a7d5121a8cc2=
903009f586c00e4ae2d6126d24eb90531dafaba6f59823aa6b2","src/sgx.rs":"16a95cde=
fc81c5ee00d8353a60db363c4cc3e0f75abcd5d0144723f2a306ed1b","src/solid/aarch6=
4.rs":"a726e47f324adf73a4a0b67a2c183408d0cad105ae66acf36db37a42ab7f8707","s=
rc/solid/arm.rs":"e39a4f74ebbef3b97b8c95758ad741123d84ed3eb48d9cf4f1f487209=
7fc27fe","src/solid/mod.rs":"5f4151dca5132e4b4e4c23ab9737e12856dddbdc0ca3f7=
dbc004328ef3c8acde","src/switch.rs":"9da3dd39b3de45a7928789926e8572d00e1e11=
a39e6f7289a1349aadce90edba","src/teeos/mod.rs":"ecf8922923fb7541ef7b0813cdc=
5418b75be56247c4dbdbb7dca58a076f25b97","src/unix/aix/mod.rs":"91de34bf8237e=
4998e10f9274471d14fb9a31ac6f2ef6e44689066b8e280b3d3","src/unix/aix/powerpc6=
4.rs":"cf374d81139d45f9d77c6a764f640bfbf7e0a5903689652c8296f8e10d55169b","s=
rc/unix/align.rs":"2cdc7c826ef7ae61f5171c5ae8c445a743d86f1a7f2d9d7e4ceeec56=
d6874f65","src/unix/bsd/apple/b32/align.rs":"ec833a747866fe19ca2d9b4d3c9ff0=
385faba5edf4bd0d15fa68884c40b0e26c","src/unix/bsd/apple/b32/mod.rs":"2546ad=
3eb6aecb95f916648bc63264117c92b4b4859532b34cb011e4c75a5a72","src/unix/bsd/a=
pple/b64/aarch64/align.rs":"2eaf0f561a32bdcbf4e0477c8895d5e7bcb5cdebd5fef7b=
4df2ca8e38e144d94","src/unix/bsd/apple/b64/aarch64/mod.rs":"44c217a4f263afe=
7a97435de9323d20a96c37836f899ca0925306d4b7e073c27","src/unix/bsd/apple/b64/=
align.rs":"ec833a747866fe19ca2d9b4d3c9ff0385faba5edf4bd0d15fa68884c40b0e26c=
","src/unix/bsd/apple/b64/mod.rs":"f5e278a1af7fb358891d1c9be4eb7e815aaca0c5=
cb738d0c3604ba2208a856f7","src/unix/bsd/apple/b64/x86_64/align.rs":"ec833a7=
47866fe19ca2d9b4d3c9ff0385faba5edf4bd0d15fa68884c40b0e26c","src/unix/bsd/ap=
ple/b64/x86_64/mod.rs":"8c87c5855038aae5d433c8f5eb3b29b0a175879a0245342b3bf=
d83bdf4cfd936","src/unix/bsd/apple/long_array.rs":"3cf1f19b812e6d093c819dc6=
5ce55b13491963e0780eda0d0bd1577603e81948","src/unix/bsd/apple/mod.rs":"4846=
98da7c1083a46ae1a389486a8c2d75e3e6ecb4f80ded69b6c0dd2d1a92a0","src/unix/bsd=
/freebsdlike/dragonfly/errno.rs":"8295b8bb0dfd38d2cdb4d9192cdeeb534cc6c3b20=
8170e64615fa3e0edb3e578","src/unix/bsd/freebsdlike/dragonfly/mod.rs":"2777f=
94909a798df1b8030fb86d02e2118d0ac3e49e9a542df54a569ca5ae2f9","src/unix/bsd/=
freebsdlike/freebsd/aarch64.rs":"6c8e216385f53a4bf5f171749b57602fc34a4e4b16=
0a44ca31c058cb0c8a2126","src/unix/bsd/freebsdlike/freebsd/arm.rs":"59d6a670=
eea562fb87686e243e0a84603d29a2028a3d4b3f99ccc01bd04d2f47","src/unix/bsd/fre=
ebsdlike/freebsd/freebsd11/b64.rs":"9808d152c1196aa647f1b0f0cf84dac8c930da7=
d7f897a44975545e3d9d17681","src/unix/bsd/freebsdlike/freebsd/freebsd11/mod.=
rs":"e243ae0e89623d4fa9f85afe14369cc5fd5f2028ea715773dbec722ba80dac1f","src=
/unix/bsd/freebsdlike/freebsd/freebsd12/b64.rs":"61cbe45f8499bedb168106b686=
d4f8239472f25c7553b069eec2afe197ff2df6","src/unix/bsd/freebsdlike/freebsd/f=
reebsd12/mod.rs":"bef9fae288a4f29e941ea369be1cd20b170040e60665a4d49a4a9e790=
09b72d8","src/unix/bsd/freebsdlike/freebsd/freebsd12/x86_64.rs":"2df36a7f12=
2f6d6e5753cfb4d22e915cc80f6bc91c0161b3daae55a481bfd052","src/unix/bsd/freeb=
sdlike/freebsd/freebsd13/b64.rs":"61cbe45f8499bedb168106b686d4f8239472f25c7=
553b069eec2afe197ff2df6","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs=
":"88be47524b28b6635ccb1e85ea511bf17337be0af7e9baa740c341ac9e83a6f7","src/u=
nix/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"2df36a7f122f6d6e5753cfb4d=
22e915cc80f6bc91c0161b3daae55a481bfd052","src/unix/bsd/freebsdlike/freebsd/=
freebsd14/b64.rs":"61cbe45f8499bedb168106b686d4f8239472f25c7553b069eec2afe1=
97ff2df6","src/unix/bsd/freebsdlike/freebsd/freebsd14/mod.rs":"6ddc6abf6d5c=
caea0d8cccf521e8ca6457efcad3086af4155628d5d06d672346","src/unix/bsd/freebsd=
like/freebsd/freebsd14/x86_64.rs":"e7b5863e222d6cc416b6b0fbe71690fad909e899=
b4c4ae810bbca117e4fcb650","src/unix/bsd/freebsdlike/freebsd/freebsd15/b64.r=
s":"61cbe45f8499bedb168106b686d4f8239472f25c7553b069eec2afe197ff2df6","src/=
unix/bsd/freebsdlike/freebsd/freebsd15/mod.rs":"93115c1a9faa43ebf58b7dee358=
2aed5a54291b284764e370e7f649b2e6a9565","src/unix/bsd/freebsdlike/freebsd/fr=
eebsd15/x86_64.rs":"e7b5863e222d6cc416b6b0fbe71690fad909e899b4c4ae810bbca11=
7e4fcb650","src/unix/bsd/freebsdlike/freebsd/mod.rs":"08e39a42392936857fd0c=
1c6b01788f5630fe8ff7f78b062490509c5dd816a42","src/unix/bsd/freebsdlike/free=
bsd/powerpc.rs":"9ca3f82f88974e6db5569f2d76a5a3749b248a31747a6c0da5820492bd=
feca42","src/unix/bsd/freebsdlike/freebsd/powerpc64.rs":"2dae3ecc87eac3b116=
57aa98915def55fc4b5c0de11fe26aae23329a54628a9a","src/unix/bsd/freebsdlike/f=
reebsd/riscv64.rs":"fa4bed4c58cad24ba3395941c7fa6b11e089551a04714f9561078e4=
00f5b2b62","src/unix/bsd/freebsdlike/freebsd/x86.rs":"2837fed0ffee0ec443ecd=
b743b7142bcb4d6ba2de87e05459fb4498789d47200","src/unix/bsd/freebsdlike/free=
bsd/x86_64/align.rs":"0e1f69a88fca1c32874b1daf5db3d446fefbe518dca497f096cc9=
168c39dde70","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.rs":"e4d76219bec0=
621db07dec37de9be1a9b7fb38daa10ffc1a6adbdbc34e163435","src/unix/bsd/freebsd=
like/mod.rs":"c846f30eaffc7c1a21b4acd3df75cd17bb3d4f11401c9a9770924e4e6d847=
995","src/unix/bsd/mod.rs":"37765749481f7d0dec8681d8c9d0735e6021094b4ef4a2d=
9aab5643d7a4232e1","src/unix/bsd/netbsdlike/mod.rs":"ea60540aa4edd4e4313674=
9d5df497b1dc072b9912b6030dd1ab794a6d1c3c3c","src/unix/bsd/netbsdlike/netbsd=
/aarch64.rs":"057ee877db7193ba0dc10801b9a6563ac6dbdb78376d6851a84cb12b30841=
759","src/unix/bsd/netbsdlike/netbsd/arm.rs":"949b55e4dee1c8c511f4f061a6a57=
ac876a6c0eabfaf5cc20e9ab40d8f41b2e0","src/unix/bsd/netbsdlike/netbsd/mips.r=
s":"88be18ac43ba224c77e78e4179b6761debc5e6c30a258fac56263809c7af4fbc","src/=
unix/bsd/netbsdlike/netbsd/mod.rs":"ab09cea2897ecd27fc7e35822dac23d6dcd53f8=
577c771db3ee8b015e8d82001","src/unix/bsd/netbsdlike/netbsd/powerpc.rs":"ee7=
ff5d89d0ed22f531237b5059aa669df93a3b5c489fa641465ace8d405bf41","src/unix/bs=
d/netbsdlike/netbsd/riscv64.rs":"1cbe2e5ed681cb1054b699da37daaf6c714267df7d=
332c90fc2a589b11579625","src/unix/bsd/netbsdlike/netbsd/sparc64.rs":"9489f4=
b3e4566f43bb12dfb92238960613dac7f6a45cc13068a8d152b902d7d9","src/unix/bsd/n=
etbsdlike/netbsd/x86.rs":"20692320e36bfe028d1a34d16fe12ca77aa909cb02bda1673=
76f98f1a09aefe7","src/unix/bsd/netbsdlike/netbsd/x86_64.rs":"532b76199d6c71=
ff996eade9f906c55a72c9aff489595d25a21e21878cfd740b","src/unix/bsd/netbsdlik=
e/openbsd/aarch64.rs":"dd91931d373b7ecaf6e2de25adadee10d16fa9b12c2cbacdff3e=
b291e1ba36af","src/unix/bsd/netbsdlike/openbsd/arm.rs":"01580d261bc6447bb32=
7a0d982181b7bdabfa066cee65a30373d3ced729ad307","src/unix/bsd/netbsdlike/ope=
nbsd/mips64.rs":"8532a189ae10c7d668d9d4065da8b05d124e09bd39442c9f74a7f231c4=
3eca48","src/unix/bsd/netbsdlike/openbsd/mod.rs":"7b93b5b24b3c72a79b2de19b4=
7ac2f56b29d87e9fc8f4c721a63d1e87ec83fcc","src/unix/bsd/netbsdlike/openbsd/p=
owerpc.rs":"01580d261bc6447bb327a0d982181b7bdabfa066cee65a30373d3ced729ad30=
7","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"1dd5449dd1fd3d51e30ffdee=
aece91d0aaf05c710e0ac699fecc5461cfa2c28e","src/unix/bsd/netbsdlike/openbsd/=
riscv64.rs":"1fe3332dc705a13e6242219970f5449d6d7a73e2e6c8537ab8e421d8a6f2e3=
ff","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"d04fd287afbaa2c5df9d48c94=
e8374a532a3ba491b424ddf018270c7312f4085","src/unix/bsd/netbsdlike/openbsd/x=
86.rs":"6f7f5c4fde2a2259eb547890cbd86570cea04ef85347d7569e94e679448bec87","=
src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"d31db31630289c85af3339dbe357998=
a21ca584cbae31607448fe2cf7675a4e1","src/unix/haiku/b32.rs":"a2efdbf7158a6da=
341e1db9176b0ab193ba88b449616239ed95dced11f54d87b","src/unix/haiku/b64.rs":=
"ff8115367d3d7d354f792d6176dfaaa26353f57056197b563bf4681f91ff7985","src/uni=
x/haiku/mod.rs":"b75976d84bdf4a3a226336bb06ec231d552240f302bb5da48ead692fd7=
2758f9","src/unix/haiku/native.rs":"2b1f88c043777a915bb7218aa05a3647a0e0481=
ebff55a99e351c45dea2be8de","src/unix/haiku/x86_64.rs":"3ec3aeeb7ed208b8916f=
3e32d42bfd085ff5e16936a1a35d9a52789f043b7237","src/unix/hurd/align.rs":"03c=
79b2cd8270ebd0cf93cb475a8f1ff85b28175ea0de007ede17cad94a89b03","src/unix/hu=
rd/b32.rs":"2ba90ed973f90366c36a6387833a3df42abfee9622d4a0352635937d4a89eaf=
4","src/unix/hurd/b64.rs":"d919b4aec9b3080ad24c125c57b2c8b2e483d72045f1554c=
429d14560355846f","src/unix/hurd/mod.rs":"23ebadfdb9a92d7fb9e32b6a7c95669ce=
979ba7407b924869f40a59d2807d052","src/unix/hurd/no_align.rs":"03c79b2cd8270=
ebd0cf93cb475a8f1ff85b28175ea0de007ede17cad94a89b03","src/unix/linux_like/a=
ndroid/b32/arm.rs":"ce582de7e983a33d3bfad13075c53aac9016cee35f06ad8653ee907=
2c3ec2564","src/unix/linux_like/android/b32/mod.rs":"7c173e0375119bf06a3081=
652faede95e5bcd6858e7576b7533d037978737c8f","src/unix/linux_like/android/b3=
2/x86/align.rs":"812914e4241df82e32b12375ca3374615dc3a4bdd4cf31f0423c581532=
0c0dab","src/unix/linux_like/android/b32/x86/mod.rs":"e6d107efbcd37b5b85dfa=
18f683300cbf768ffa0237997a9fa52b184a53323ac","src/unix/linux_like/android/b=
64/aarch64/align.rs":"2179c3b1608fa4bf68840482bfc2b2fa3ee2faf6fcae3770f9e50=
5cddca35c7b","src/unix/linux_like/android/b64/aarch64/int128.rs":"1735f6f5c=
56770d20dd426442f09724d9b2052b46a7cd82f23f3288a4a7276de","src/unix/linux_li=
ke/android/b64/aarch64/mod.rs":"873af67c4a9757ead56bc797d04efcecd311ecbf008=
4ebdd198fb690463ef299","src/unix/linux_like/android/b64/mod.rs":"7b8efbd61a=
b965c93bacfab78108ff8eed38af07b119099020dc41a9d0901559","src/unix/linux_lik=
e/android/b64/riscv64/align.rs":"0bf138f84e5327d8339bcd4adf071a6832b516445e=
597552c82bbd881095e3a8","src/unix/linux_like/android/b64/riscv64/mod.rs":"1=
9d4bf2237c47127eba9144e0b82e995bc079315e719179a91813b0ae7b0e49d","src/unix/=
linux_like/android/b64/x86_64/align.rs":"7169d07a9fd4716f7512719aec9fda5d8b=
ed306dc0720ffc1b21696c9951e3c6","src/unix/linux_like/android/b64/x86_64/mod=
.rs":"4ec2de11a9b65c4325b7b991f0b99a414975e0e61ba8668caca5d921e9b314d1","sr=
c/unix/linux_like/android/mod.rs":"384275dc1d3559a9f83559b6c903758a9dc4c4b3=
d13db48d23ed4fdc3c0ff8da","src/unix/linux_like/emscripten/align.rs":"86c95c=
bed7a7161b1f23ee06843e7b0e2340ad92b2cb86fe2a8ef3e0e8c36216","src/unix/linux=
_like/emscripten/lfs64.rs":"3776af30a758d765a88920ec4fde442ab89040da13d3b36=
25c7fbcb8a958559f","src/unix/linux_like/emscripten/mod.rs":"70d4591730a731e=
e32788a9d8d2de379592844ec36b7d1723514179605587713","src/unix/linux_like/ems=
cripten/no_align.rs":"0128e4aa721a9902754828b61b5ec7d8a86619983ed1e0544a85d=
35b1051fad6","src/unix/linux_like/linux/align.rs":"bc5abcd38e2320171e0981e7=
73c9c5fe3e0d5a66fdff049228f6a1acad80ef8b","src/unix/linux_like/linux/arch/g=
eneric/mod.rs":"10577c664dbdd5d1410e53e3872435ad595758bd1deb410b1bce7825cd1=
50178","src/unix/linux_like/linux/arch/mips/mod.rs":"ca3db0e3ae852abf18f358=
8e40d5d64707fcc1829e08ddc5da1080e1a92c8851","src/unix/linux_like/linux/arch=
/mod.rs":"5bd5361f8a6ab4e18bbba6da9f92c164ae252b15a0ed10064812544aa1fdf198"=
,"src/unix/linux_like/linux/arch/powerpc/mod.rs":"0bc2d2667a00eca81f4abeb6d=
613a90848a947f51224103f83268928b8197629","src/unix/linux_like/linux/arch/sp=
arc/mod.rs":"5e6777863e74a9e2aa9dc487f1059783dd211babc2b32d6bf676f311e49c55=
d6","src/unix/linux_like/linux/gnu/align.rs":"e4a3c27fe20a57b8d612c34cb05bc=
70646edb5cec7251957315afa53a7b9f936","src/unix/linux_like/linux/gnu/b32/arm=
/align.rs":"6ec0eb3ee93f7ae99fd714b4deabfb5e97fbcefd8c26f5a45fb8e7150899cde=
b","src/unix/linux_like/linux/gnu/b32/arm/mod.rs":"f68ec59b6407f9d4e326f3e7=
1a41ec21f19ecfc703edf9a93e496f661fed5506","src/unix/linux_like/linux/gnu/b3=
2/csky/align.rs":"3fed009dc9af3cc81be7087da9d2d7d1f39845e4497e290259c5cdbae=
25f039d","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"8729b68e433e94c21=
28e51a7db4fd555938e4be4dc64584c352b24a20d9c8e91","src/unix/linux_like/linux=
/gnu/b32/m68k/align.rs":"8faa92f77a9232c035418d45331774e64a9a841d99c9179157=
0a203bf2b45bcb","src/unix/linux_like/linux/gnu/b32/m68k/mod.rs":"80956d3fef=
163ecf248828a6f38782dd8ae856d86b1bb5aac2de36032dbd8ea0","src/unix/linux_lik=
e/linux/gnu/b32/mips/align.rs":"429fb5e005cb7143602d430098b6ebfb7d360685b19=
4f333dfd587472ae954ee","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"96e=
22350d5d132d917c743d6560464500652c67b52c3d0e8474494487df3365d","src/unix/li=
nux_like/linux/gnu/b32/mod.rs":"b56625dd20dd48a8699034d349ef089c540c0ddcbf8=
a3481d598d101f8b40b78","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"20fc=
3cc4fe1ef6617b63b61b897f782ceb9c2842fc718f504a1840537229bf47","src/unix/lin=
ux_like/linux/gnu/b32/riscv32/align.rs":"d321491612be8d5c61b6ec2dc0111beb3a=
22e58803f99cd37543efe86621b119","src/unix/linux_like/linux/gnu/b32/riscv32/=
mod.rs":"887288a0a1cfff319d0e15edcdc4fcb31fd643ff41715ec5244c8f2413624169",=
"src/unix/linux_like/linux/gnu/b32/sparc/align.rs":"21adbed27df73e2d1ed934a=
af733a643003d7baf2bde9c48ea440895bcca6d41","src/unix/linux_like/linux/gnu/b=
32/sparc/mod.rs":"cc4342b949e4d796f304acd9dfe3f721a1c2f37fec16b42d3bb27dc94=
723af37","src/unix/linux_like/linux/gnu/b32/x86/align.rs":"e4bafdc4a519a792=
2a81b37a62bbfd1177a2f620890eef8f1fbc47162e9eb413","src/unix/linux_like/linu=
x/gnu/b32/x86/mod.rs":"06d4db4ee8352f62a0a5ead0c4d6ea0a78feff522f19b9bc5772=
f6dd920ffd80","src/unix/linux_like/linux/gnu/b64/aarch64/align.rs":"fdf1c72=
375a2167699157e0dd825422690bb6719f7bc69515a2e5846d0431d7c","src/unix/linux_=
like/linux/gnu/b64/aarch64/fallback.rs":"832e7487249c1c0bb6e9911ce3f7d32ca2=
2378e42392ab83c56915cbc59d8be3","src/unix/linux_like/linux/gnu/b64/aarch64/=
ilp32.rs":"bf4611b737813deef6787babf6c01698605f3b75482269b8546318667bc68e29=
","src/unix/linux_like/linux/gnu/b64/aarch64/int128.rs":"1735f6f5c56770d20d=
d426442f09724d9b2052b46a7cd82f23f3288a4a7276de","src/unix/linux_like/linux/=
gnu/b64/aarch64/lp64.rs":"11a950697fdda0258c6e37c6b13993348c8de4134105ed4fa=
a79358e53175072","src/unix/linux_like/linux/gnu/b64/aarch64/mod.rs":"820261=
4484da36c388d2ffdd2554c56bb4f9db8e5bd621f8c36114cdcfeec644","src/unix/linux=
_like/linux/gnu/b64/loongarch64/align.rs":"060aa33cc737966c691aab8511c5c572=
9e551458ce18d0e284e0d45f39beeb60","src/unix/linux_like/linux/gnu/b64/loonga=
rch64/mod.rs":"10f025edecebc6e0ed8fdae4736ebe7564189741d5b910433f07c21fc12a=
94d8","src/unix/linux_like/linux/gnu/b64/mips64/align.rs":"7169d07a9fd4716f=
7512719aec9fda5d8bed306dc0720ffc1b21696c9951e3c6","src/unix/linux_like/linu=
x/gnu/b64/mips64/mod.rs":"73532be4b5775acf9524c77feeefe1f6d1936ceffef908d01=
dd2586986520f2d","src/unix/linux_like/linux/gnu/b64/mod.rs":"6a160ef25439c4=
fecdb0e3bd0b818742263c791364da874d4febd3aa644ec8e2","src/unix/linux_like/li=
nux/gnu/b64/powerpc64/align.rs":"e29c4868bbecfa4a6cd8a2ad06193f3bbc78a468cc=
1dc9df83f002f1268130d9","src/unix/linux_like/linux/gnu/b64/powerpc64/mod.rs=
":"a90c2641616c620e9d1fea87695ce046e14f9da2282bb93f761eeb4077c74741","src/u=
nix/linux_like/linux/gnu/b64/riscv64/align.rs":"fe7e3c928d0367c37eb65268659=
1801c3694a3558ebbbeb5c22be692265d07f2","src/unix/linux_like/linux/gnu/b64/r=
iscv64/mod.rs":"dec86883731f7b8419bff35b125b40eefc927090c1510f6daf931726f79=
65c0b","src/unix/linux_like/linux/gnu/b64/s390x.rs":"1ea9e39432ce6bf68779d3=
3546dacd7d39477a9f8fc3da4f4f339e4538cb74c3","src/unix/linux_like/linux/gnu/=
b64/sparc64/align.rs":"e29c4868bbecfa4a6cd8a2ad06193f3bbc78a468cc1dc9df83f0=
02f1268130d9","src/unix/linux_like/linux/gnu/b64/sparc64/mod.rs":"bed381c44=
cec2a5b50125f7e548ab487d4c829006c971d152a611b7141760052","src/unix/linux_li=
ke/linux/gnu/b64/x86_64/align.rs":"62e822478356db4a73b6bbd1b36d825b893939ab=
4b308ec11b0578bcc4b49769","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs"=
:"332846e4a5920d7e6b05df0448a2333c5dd00fb27cb33654648f507ee89dbec5","src/un=
ix/linux_like/linux/gnu/b64/x86_64/not_x32.rs":"38f74ce15d9662ce4818815a2b8=
7be1618d5e45f190f7e4db84ff3285b4421fb","src/unix/linux_like/linux/gnu/b64/x=
86_64/x32.rs":"b20218a11364a6dec87f96d6c0d8b19e660697ab09ad5ee0e9b3a9dafeda=
aebb","src/unix/linux_like/linux/gnu/mod.rs":"8d11f66db9993e9a89c86fec3b732=
d9c0ec4ee42d9570d4e3389c075021dd29f","src/unix/linux_like/linux/gnu/no_alig=
n.rs":"9cd223135de75315840ff9c3fd5441ba1cb632b96b5c85a76f8316c86653db25","s=
rc/unix/linux_like/linux/mod.rs":"da8c17828415fc1db81fb547fe20b7421774a3bdd=
3e79053cc127a3031e59302","src/unix/linux_like/linux/musl/b32/arm/align.rs":=
"3e8ac052c1043764776b54c93ba4260e061df998631737a897d9d47d54f7b80c","src/uni=
x/linux_like/linux/musl/b32/arm/mod.rs":"af10147d7c3661751750a58ffad089d5d1=
8d180cd18303c653aef126c07ccd91","src/unix/linux_like/linux/musl/b32/hexagon=
.rs":"d079cab42529f7dab699334d43168c74ff4aa0282f11040a8b7d274b65767a7a","sr=
c/unix/linux_like/linux/musl/b32/mips/align.rs":"429fb5e005cb7143602d430098=
b6ebfb7d360685b194f333dfd587472ae954ee","src/unix/linux_like/linux/musl/b32=
/mips/mod.rs":"e44043766f7cd26de7ffa4232654afb6feb03e58dbd5890717970887bd00=
3151","src/unix/linux_like/linux/musl/b32/mod.rs":"31677597fd9544c4b1ec1477=
628288f6273fabbc06e38f33da862ad55f019ce1","src/unix/linux_like/linux/musl/b=
32/powerpc.rs":"3dae56a4e7789bcc5314e419fea5e4b2495367b4f1a49d1c9477c60225d=
65eef","src/unix/linux_like/linux/musl/b32/riscv32/align.rs":"efd2accf33b87=
de7c7547903359a5da896edc33cd6c719552c7474b60d4a5d48","src/unix/linux_like/l=
inux/musl/b32/riscv32/mod.rs":"3ee845d272f91a1908d5f421d7c353e1f14681bbdfef=
64410e408f4c14365a91","src/unix/linux_like/linux/musl/b32/x86/align.rs":"08=
e77fbd7435d7dec2ff56932433bece3f02e47ce810f89004a275a86d39cbe1","src/unix/l=
inux_like/linux/musl/b32/x86/mod.rs":"f2b53ae0034c833244b7cdb8c670349bf8272=
a03abf04152eba65cf62810484d","src/unix/linux_like/linux/musl/b64/aarch64/al=
ign.rs":"6ba32725d24d7d8e6aa111f3b57aafa318f83b606abe96561329151829821133",=
"src/unix/linux_like/linux/musl/b64/aarch64/int128.rs":"1735f6f5c56770d20dd=
426442f09724d9b2052b46a7cd82f23f3288a4a7276de","src/unix/linux_like/linux/m=
usl/b64/aarch64/mod.rs":"45ce6897afcc960267bb7505702b639daf94dc69428a213bf1=
aefd367ca32adc","src/unix/linux_like/linux/musl/b64/loongarch64/align.rs":"=
060aa33cc737966c691aab8511c5c5729e551458ce18d0e284e0d45f39beeb60","src/unix=
/linux_like/linux/musl/b64/loongarch64/mod.rs":"3d9ef92e682a1789544a2bd20ca=
d5a5623db9d7d9f5d0a3692bb0230af034165","src/unix/linux_like/linux/musl/b64/=
mips64.rs":"a968ef9c54fa22293085f318c8472c1754482df92cc500568dc33bd807d71ea=
6","src/unix/linux_like/linux/musl/b64/mod.rs":"20ceaf90a03c24a2eb154a5dffb=
fc9a538348404db5b554a3d8126021ba45509","src/unix/linux_like/linux/musl/b64/=
powerpc64.rs":"140e579800a67315f4cb8a42b22aa8157eae34ffe626e77e421b43c53c23=
b34d","src/unix/linux_like/linux/musl/b64/riscv64/align.rs":"fe7e3c928d0367=
c37eb652686591801c3694a3558ebbbeb5c22be692265d07f2","src/unix/linux_like/li=
nux/musl/b64/riscv64/mod.rs":"c5944526d7e19cd43e9d14d119a1d98f8780db7ecbcc7=
9e69d7b9348e596b520","src/unix/linux_like/linux/musl/b64/s390x.rs":"8557b34=
77ca8cefef7fce764a3c25441929a54e50ead4091f6f7823c427cd728","src/unix/linux_=
like/linux/musl/b64/x86_64/align.rs":"77309276ad7a42cbe59ca381f23590b7a143a=
ded05555b34a5b307b808cbca6e","src/unix/linux_like/linux/musl/b64/x86_64/mod=
.rs":"a91c4f18027c9958037f78ae48f6352d23cb4e6f2995b2cc8de7dce0e5759470","sr=
c/unix/linux_like/linux/musl/lfs64.rs":"3e4fb381f3a0756520bde0f1692d4fa45e4=
ae8133bf7d7c64b0e3fdd512f235f","src/unix/linux_like/linux/musl/mod.rs":"94d=
d7eb5064230637ccd135383c7d30f8d3f7874c22771b24b529e58de421731","src/unix/li=
nux_like/linux/no_align.rs":"62cdca0e011937aaf09a51ca86d9f0ee0fdb05f61ec3c0=
58e6a5d5fa6357d784","src/unix/linux_like/linux/non_exhaustive.rs":"181a05bf=
94fdb911db83ce793b993bd6548a4115b306a7ef3c10f745a8fea3e9","src/unix/linux_l=
ike/linux/uclibc/align.rs":"9ed16138d8e439bd90930845a65eafa7ebd67366e6bf633=
936d44014f6e4c959","src/unix/linux_like/linux/uclibc/arm/align.rs":"e4a3c27=
fe20a57b8d612c34cb05bc70646edb5cec7251957315afa53a7b9f936","src/unix/linux_=
like/linux/uclibc/arm/mod.rs":"50288ff9e411ab0966da24838f2c2a5618021bc19c42=
2a04f577b2979ef4081e","src/unix/linux_like/linux/uclibc/arm/no_align.rs":"9=
cd223135de75315840ff9c3fd5441ba1cb632b96b5c85a76f8316c86653db25","src/unix/=
linux_like/linux/uclibc/mips/mips32/align.rs":"e4a3c27fe20a57b8d612c34cb05b=
c70646edb5cec7251957315afa53a7b9f936","src/unix/linux_like/linux/uclibc/mip=
s/mips32/mod.rs":"d0c4434e2bf813372c418a8f516c706cdccc9f7be2f0921b2207b0afd=
b66fe81","src/unix/linux_like/linux/uclibc/mips/mips32/no_align.rs":"9cd223=
135de75315840ff9c3fd5441ba1cb632b96b5c85a76f8316c86653db25","src/unix/linux=
_like/linux/uclibc/mips/mips64/align.rs":"a7bdcb18a37a2d91e64d5fad83ea3edc7=
8f5412adb28f77ab077dbb26dd08b2d","src/unix/linux_like/linux/uclibc/mips/mip=
s64/mod.rs":"3f38ee6a4690b9d7594be20d216467a34d955f7653c2c8ce1e6147daeb53f1=
e0","src/unix/linux_like/linux/uclibc/mips/mips64/no_align.rs":"4a18e387569=
8c85229599225ac3401a2a40da87e77b2ad4ef47c6fcd5a24ed30","src/unix/linux_like=
/linux/uclibc/mips/mod.rs":"a048fce1c2d9b1ad57305642e8ad05ca0f0c7e4753267a2=
e2d6b4fee5db3b072","src/unix/linux_like/linux/uclibc/mod.rs":"6efae7ed906bc=
5773dcce43ba1045cf93df5f8dac41f194d8cddc0579f14c015","src/unix/linux_like/l=
inux/uclibc/no_align.rs":"3f28637046524618adaa1012e26cb7ffe94b9396e6b518ccc=
dc69d59f274d709","src/unix/linux_like/linux/uclibc/x86_64/l4re.rs":"8485b91=
82b7c67f7344fab377e7cc2a72afefd9ab63837c860514abba9728d76","src/unix/linux_=
like/linux/uclibc/x86_64/mod.rs":"e7197f0f68ece174c8ae42b2b9115893abfcdbe44=
a1a6ed98fb3cbd7bfe087e8","src/unix/linux_like/linux/uclibc/x86_64/other.rs"=
:"42c3f71e58cabba373f6a55a623f3c31b85049eb64824c09c2b082b3b2d6a0a8","src/un=
ix/linux_like/mod.rs":"863f628cbaa864911ffebc58e9fb788b6c6a9651955fc401ac1f=
40f20eb62505","src/unix/mod.rs":"5f851ce1756443b9219edd11b6cc2abfb4031a22a6=
496bb5d4d6090f97779f8a","src/unix/newlib/aarch64/mod.rs":"964c096288da836b5=
3c0c71d7f3a97048d177da220a69314c5ce93ba330d72af","src/unix/newlib/align.rs"=
:"28aaf87fafbc6b312622719d472d8cf65f9e5467d15339df5f73e66d8502b28a","src/un=
ix/newlib/arm/mod.rs":"cf754f8b1197489fca01e881a4b4b146e814998e4b365f116fa1=
a102c00e6a4e","src/unix/newlib/espidf/mod.rs":"689e29a9fff5a263e5ab8410d0a8=
919f77fa64aa12f4d71f71085a6f07f19f67","src/unix/newlib/generic.rs":"5f0b5d0=
7ddb5a5d60580f9561fdb05e9218d9751d4068c4aadad2ba6b950aabf","src/unix/newlib=
/horizon/mod.rs":"3a521d22bf932fc01c1d26d1f9bff20f11b1855b03c8236a8eb18310f=
6cab5a8","src/unix/newlib/mod.rs":"e5d5faf27a6336b9f1c02b8726427801d906a14d=
ae766852b4e85c1a92df06c8","src/unix/newlib/no_align.rs":"e0743b2179495a9514=
bc3a4d1781e492878c4ec834ee0085d0891dd1712e82fb","src/unix/newlib/powerpc/mo=
d.rs":"cc9e188711b9bf614323ad6c48e0d2e1a1ecc5d3bc64961ba451f29c6c22d2d8","s=
rc/unix/newlib/vita/mod.rs":"ff1caf74bb0696fe15d60dbac598db4520cd538aa0f598=
9713d97d008eee6ad8","src/unix/no_align.rs":"c06e95373b9088266e0b14bba0954ee=
f95f93fb2b01d951855e382d22de78e53","src/unix/nto/aarch64.rs":"4709c9afdc8d5=
83be876598e7c238499ee3e8da5bd2baa614d9c7dd414851555","src/unix/nto/mod.rs":=
"5eb045c352114f5d744d098acaf9e47a9223f6fccd43f36b9a3ba79b29af0eee","src/uni=
x/nto/neutrino.rs":"799bff4ab01a6424db6c5a2b76aa5679826d41495f9d13c63485bf1=
3bc80026b","src/unix/nto/x86_64.rs":"a3e18e93c2999da1cd7a6f748a4b60c07aefb7=
3d8ea2aafec19a84cfb040bc8e","src/unix/redox/mod.rs":"e75a319975472fe9e08732=
44fb07c5d2004672b7a4cf7a3cb01532d6d394cb8a","src/unix/solarish/compat.rs":"=
00f1ee3faec9da69204e42f025f6735dd13d894071a154425dcc43ecbdd06e7f","src/unix=
/solarish/illumos.rs":"26171da367221de1e456f1236250b5831a770d6f109ed12b0ebe=
4d508e490194","src/unix/solarish/mod.rs":"c0c5dfc406d728666010cdc2fe21b0df4=
0547ed20dd7ad0eab65906e103b6d4b","src/unix/solarish/solaris.rs":"41b350a89d=
df01cd12a10f93640f92be53be0b0d976021cdc08da17bf3e72edf","src/unix/solarish/=
x86.rs":"e86e806df0caed72765040eaa2f3c883198d1aa91508540adf9b7008c77f522e",=
"src/unix/solarish/x86_64.rs":"ec2b01f194eb8a6a27133c57681da195a949e03098f3=
ea1e847227a9c09ef5fc","src/unix/solarish/x86_common.rs":"ac869d9c3c95645c22=
460468391eb1982023c3a8e02b9e06a72e3aef3d5f1eac","src/vxworks/aarch64.rs":"9=
8f0afdc511cd02557e506c21fed6737585490a1dce7a9d4941d08c437762b99","src/vxwor=
ks/arm.rs":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e8=
8","src/vxworks/mod.rs":"ccdb6a6e0c12011705a15dadc04b26882e6090db4403af4d15=
cad9330ef96370","src/vxworks/powerpc.rs":"acb7968ce99fe3f4abdf39d98f8133d21=
a4fba435b8ef7084777cb181d788e88","src/vxworks/powerpc64.rs":"98f0afdc511cd0=
2557e506c21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/x86.rs":"5=
52f007f38317620b23889cb7c49d1d115841252439060122f52f434fbc6e5ba","src/vxwor=
ks/x86_64.rs":"018d92be3ad628a129eff9f2f5dfbc0883d8b8e5f2fa917b900a7f98ed6b=
514a","src/wasi.rs":"51e38bb98547c40d0822d31975c976cd6e0784463d90d170109c87=
bf324395d3","src/windows/gnu/align.rs":"b2c13ec1b9f3b39a75c452c80c951dff9d0=
215e31d77e883b4502afb31794647","src/windows/gnu/mod.rs":"3c8c7edb7cdf5d0c44=
af936db2a94869585c69dfabeef30571b4f4e38375767a","src/windows/mod.rs":"9fdc5=
e1c62c441abef7bc62a7343efb2041edc24db9ac0efc0f74df55b69e249","src/windows/m=
svc/mod.rs":"c068271e00fca6b62bc4bf44bcf142cfc38caeded9b6c4e01d1ceef3ccf986=
f4","src/xous.rs":"eb0675f25ba01f73072d2b70907fb8abb1148facefe5a20756c49250=
f3d65fae","tests/const_fn.rs":"cb75a1f0864f926aebe79118fc34d51a0d1ade2c20a3=
94e7774c7e545f21f1f4"},"package":"d8adc4bb1803a324070e64a98ae98f38934d91957=
a99cfb3a43dcbc01bc56439"}
-diff --git a/vendor/libc-0.2.158/src/unix/linux_like/linux/arch/generic/mo=
d.rs b/vendor/libc-0.2.158/src/unix/linux_like/linux/arch/generic/mod.rs
-index 2f437e16d..db1f1e70f 100644
---- a/vendor/libc-0.2.158/src/unix/linux_like/linux/arch/generic/mod.rs
-+++ b/vendor/libc-0.2.158/src/unix/linux_like/linux/arch/generic/mod.rs
-@@ -114,6 +114,7 @@ cfg_if! {
-                  target_arch =3D "x86_64",
-                  target_arch =3D "arm",
-                  target_arch =3D "aarch64",
-+                 target_arch =3D "riscv32",
-                  target_arch =3D "riscv64",
-                  target_arch =3D "s390x",
-                  target_arch =3D "csky",
-@@ -218,7 +219,10 @@ cfg_if! {
-     // where S stands for size (int, long, struct...)
-     // where T stands for type ('f','v','X'...)
-     // where N stands for NR (NumbeR)
--    if #[cfg(any(target_arch =3D "x86", target_arch =3D "arm", target_arc=
h =3D "csky"))] {
-+    if #[cfg(any(target_arch =3D "x86",
-+                 target_arch =3D "arm",
-+                 target_arch =3D "riscv32",
-+                 target_arch =3D "csky"))] {
-         pub const FS_IOC_GETFLAGS: ::Ioctl =3D 0x80046601;
-         pub const FS_IOC_SETFLAGS: ::Ioctl =3D 0x40046602;
-         pub const FS_IOC_GETVERSION: ::Ioctl =3D 0x80047601;
 diff --git a/vendor/libc-0.2.167/.cargo-checksum.json b/vendor/libc-0.2.16=
7/.cargo-checksum.json
 index 7ea5d4122..def87f4ef 100644
 --- a/vendor/libc-0.2.167/.cargo-checksum.json
diff --git a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-=
switch-off-lto-for-rust.patch b/recipes-devtools/rust/files/0001-src-core-b=
uild_steps-tool.rs-switch-off-lto-for-rust.patch
index e63cfb0..5e0f591 100644
--- a/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-=
off-lto-for-rust.patch
+++ b/recipes-devtools/rust/files/0001-src-core-build_steps-tool.rs-switch-=
off-lto-for-rust.patch
@@ -24,23 +24,53 @@ diff --git a/src/bootstrap/src/core/build_steps/tool.rs=
 b/src/bootstrap/src/core
 index 087df2f8a..00790affb 100644
 --- a/src/bootstrap/src/core/build_steps/tool.rs
 +++ b/src/bootstrap/src/core/build_steps/tool.rs
-@@ -635,7 +635,7 @@ impl Step for Rustdoc {
-         }
+@@ -1,14 +1,11 @@
+ use std::path::PathBuf;
+ use std::{env, fs};
=20=20
-         // NOTE: Never modify the rustflags here, it breaks the build cac=
he for other tools!
--        let cargo =3D prepare_tool_cargo(
-+        let mut cargo =3D prepare_tool_cargo(
-             builder,
-             build_compiler,
-             Mode::ToolRustc,
-@@ -645,6 +645,7 @@ impl Step for Rustdoc {
+-use crate::core::build_steps::compile::is_lto_stage;
+ use crate::core::build_steps::toolstate::ToolState;
+ use crate::core::build_steps::{compile, llvm};
+ use crate::core::builder;
+-use crate::core::builder::{
+-    Builder, Cargo as CargoCommand, RunConfig, ShouldRun, Step, cargo_pro=
file_var,
+-};
+-use crate::core::config::{DebuginfoLevel, RustcLto, TargetSelection};
++use crate::core::builder::{Builder, Cargo as CargoCommand, RunConfig, Sho=
uldRun, Step};
++use crate::core::config::{DebuginfoLevel, TargetSelection};
+ use crate::utils::channel::GitInfo;
+ use crate::utils::exec::{BootstrapCommand, command};
+ use crate::utils::helpers::{add_dylib_path, exe, t};
+@@ -658,19 +655,7 @@
              SourceType::InTree,
              features.as_slice(),
          );
+-
+-        // rustdoc is performance sensitive, so apply LTO to it.
+-        if is_lto_stage(&build_compiler) {
+-            let lto =3D match builder.config.rust_lto {
+-                RustcLto::Off =3D> Some("off"),
+-                RustcLto::Thin =3D> Some("thin"),
+-                RustcLto::Fat =3D> Some("fat"),
+-                RustcLto::ThinLocal =3D> None,
+-            };
+-            if let Some(lto) =3D lto {
+-                cargo.env(cargo_profile_var("LTO", &builder.config), lto);
+-            }
+-        }
 +        cargo.rustflag("-Clto=3Doff");
=20=20
          let _guard =3D builder.msg_tool(
              Kind::Build,
---=20
-2.39.5
-
+diff --git a/src/bootstrap/src/core/builder/mod.rs b/src/bootstrap/src/cor=
e/builder/mod.rs
+--- a/src/bootstrap/src/core/builder/mod.rs
++++ b/src/bootstrap/src/core/builder/mod.rs
+@@ -11,7 +11,7 @@
+=20
+ use clap::ValueEnum;
+=20
+-pub use self::cargo::{Cargo, cargo_profile_var};
++pub use self::cargo::Cargo;
+ pub use crate::Compiler;
+ use crate::core::build_steps::{
+     check, clean, clippy, compile, dist, doc, gcc, install, llvm, run, se=
tup, test, tool, vendor,
diff --git a/recipes-devtools/rust/files/Zdual-proc-macros-additional-check=
.patch b/recipes-devtools/rust/files/Zdual-proc-macros-additional-check.pat=
ch
deleted file mode 100644
index 6bb1738..0000000
--- a/recipes-devtools/rust/files/Zdual-proc-macros-additional-check.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-Fix bootstrap failure when multilibs are enabled.
-
-Upstream-Status: Backport [https://github.com/rust-lang/rust/commit/139d6b=
a054a1a4cc5fe64981ad46fd5547bd4916]
-
-Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
----
-diff --git a/src/bootstrap/src/core/builder/cargo.rs b/src/bootstrap/src/c=
ore/builder/cargo.rs
-index 066e6bf53f..a2f6fac4b1 100644
---- a/src/bootstrap/src/core/builder/cargo.rs
-+++ b/src/bootstrap/src/core/builder/cargo.rs
-@@ -646,7 +646,10 @@ impl Builder<'_> {
-                 // Build proc macros both for the host and the target unl=
ess proc-macros are not
-                 // supported by the target.
-                 if target !=3D compiler.host && cmd_kind !=3D Kind::Check=
 {
--                    let error =3D command(self.rustc(compiler))
-+                    let mut rustc_cmd =3D command(self.rustc(compiler));
-+                    self.add_rustc_lib_path(compiler, &mut rustc_cmd);
-+
-+                    let error =3D rustc_cmd
-                         .arg("--target")
-                         .arg(target.rustc_target_arg())
-                         .arg("--print=3Dfile-names")
-@@ -654,6 +657,7 @@ impl Builder<'_> {
-                         .arg("-")
-                         .run_capture(self)
-                         .stderr();
-+
-                     let not_supported =3D error
-                         .lines()
-                         .any(|line| line.contains("unsupported crate type=
 `proc-macro`"));
-
diff --git a/recipes-devtools/rust/files/rust-oe-selftest.patch b/recipes-d=
evtools/rust/files/rust-oe-selftest.patch
index 048fc3f..49d8507 100644
--- a/recipes-devtools/rust/files/rust-oe-selftest.patch
+++ b/recipes-devtools/rust/files/rust-oe-selftest.patch
@@ -43,10 +43,10 @@ diff --git a/compiler/rustc_interface/src/tests.rs b/co=
mpiler/rustc_interface/sr
  fn test_can_print_warnings() {
      sess_and_cfg(&["-Awarnings"], |sess, _cfg| {
          assert!(!sess.dcx().can_emit_warnings());
-diff --git a/library/std/src/sync/poison/rwlock/tests.rs b/library/std/src=
/sync/poison/rwlock/tests.rs
+diff --git a/library/std/tests/sync/rwlock.rs b/library/std/tests/sync/rwl=
ock.rs
 index 1a9d3d3f12f..0a9cfc48806 100644
---- a/library/std/src/sync/poison/rwlock/tests.rs
-+++ b/library/std/src/sync/poison/rwlock/tests.rs
+--- a/library/std/tests/sync/rwlock.rs
++++ b/library/std/tests/sync/rwlock.rs
 @@ -47,6 +47,7 @@ fn frob() {
  }
=20
@@ -114,9 +114,9 @@ diff --git a/library/test/src/tests.rs b/library/test/s=
rc/tests.rs
  fn test_time_options_threshold() {
      let unit =3D TimeThreshold::new(Duration::from_millis(50), Duration::=
from_millis(100));
      let integration =3D TimeThreshold::new(Duration::from_millis(500), Du=
ration::from_millis(1000));
-diff --git a/library/std/src/sync/poison/mutex/tests.rs b/library/std/src/=
sync/poison/mutex/tests.rs
---- a/library/std/src/sync/poison/mutex/tests.rs
-+++ b/library/std/src/sync/poison/mutex/tests.rs
+diff --git a/library/std/tests/sync/mutex.rs b/library/std/tests/sync/mute=
x.rs
+--- a/library/std/tests/sync/mutex.rs
++++ b/library/std/tests/sync/mutex.rs
 @@ -193,6 +193,7 @@
  }
=20
@@ -125,9 +125,9 @@ diff --git a/library/std/src/sync/poison/mutex/tests.rs=
 b/library/std/src/sync/p
  fn test_mutex_arc_poison_mapped() {
      let arc =3D Arc::new(Mutex::new(1));
      assert!(!arc.is_poisoned());
-diff --git a/library/std/src/sync/poison/mutex/tests.rs b/library/std/src/=
sync/poison/mutex/tests.rs
---- a/library/std/src/sync/poison/mutex/tests.rs
-+++ b/library/std/src/sync/poison/mutex/tests.rs
+diff --git a/library/std/tests/sync/mutex.rs b/library/std/tests/sync/mute=
x.rs
+--- a/library/std/tests/sync/mutex.rs
++++ b/library/std/tests/sync/mutex.rs
 @@ -272,6 +272,7 @@
  }
=20
@@ -136,9 +136,9 @@ diff --git a/library/std/src/sync/poison/mutex/tests.rs=
 b/library/std/src/sync/p
  fn panic_while_mapping_unlocked_poison() {
      let lock =3D Mutex::new(());
=20
-diff --git a/library/std/src/sync/rwlock/tests.rs b/library/std/src/sync/p=
oison/rwlock/tests.rs
---- a/library/std/src/sync/poison/rwlock/tests.rs
-+++ b/library/std/src/sync/poison/rwlock/tests.rs
+diff --git a/library/std/src/sync/rwlock/tests.rs b/library/std/tests/sync=
/rwlock.rs
+--- a/library/std/tests/sync/rwlock.rs
++++ b/library/std/tests/sync/rwlock.rs
 @@ -59,6 +59,7 @@ fn test_rw_arc_poison_wr() {
  }
=20
@@ -163,10 +163,10 @@ diff --git a/library/std/src/sync/rwlock/tests.rs b/l=
ibrary/std/src/sync/poison/
  fn panic_while_mapping_write_unlocked_poison() {
      let lock =3D RwLock::new(());
=20
-diff --git a/library/core/benches/num/int_log/mod.rs b/library/core/benche=
s/num/int_log/mod.rs
+diff --git a/library/coretests/benches/num/int_log/mod.rs b/library/corete=
sts/benches/num/int_log/mod.rs
 index 3807cd5d76c..018c5c04456 100644
---- a/library/core/benches/num/int_log/mod.rs
-+++ b/library/core/benches/num/int_log/mod.rs
+--- a/library/coretests/benches/num/int_log/mod.rs
++++ b/library/coretests/benches/num/int_log/mod.rs
 @@ -98,6 +98,7 @@ fn $random_small(bench: &mut Bencher) {
          }
=20
@@ -175,34 +175,22 @@ index 3807cd5d76c..018c5c04456 100644
          fn $geometric(bench: &mut Bencher) {
              let bases: [$t; 16] =3D [2, 3, 4, 5, 7, 8, 9, 15, 16, 17, 31,=
 32, 33, 63, 64, 65];
              let base_and_numbers: Vec<($t, Vec<$t>)> =3D bases
-diff --git a/compiler/rustc_data_structures/src/tagged_ptr/copy/tests.rs b=
/compiler/rustc_data_structures/src/tagged_ptr/copy/tests.rs
+diff --git a/compiler/rustc_data_structures/src/tagged_ptr/tests.rs b/comp=
iler/rustc_data_structures/src/tagged_ptr/tests.rs
 index 160af8a65d..686f4607bb 100644
---- a/compiler/rustc_data_structures/src/tagged_ptr/copy/tests.rs
-+++ b/compiler/rustc_data_structures/src/tagged_ptr/copy/tests.rs
+--- a/compiler/rustc_data_structures/src/tagged_ptr/tests.rs
++++ b/compiler/rustc_data_structures/src/tagged_ptr/tests.rs
 @@ -5,6 +5,7 @@ use crate::stable_hasher::{HashStable, StableHasher};
- use crate::tagged_ptr::{CopyTaggedPtr, Pointer, Tag, Tag2};
-
- #[test]
-+#[ignore]
- fn smoke() {
-     let value =3D 12u32;
-     let reference =3D &value;
-diff --git a/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs b=
/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs
-index 4d342c72cc..9a77f92616 100644
---- a/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs
-+++ b/compiler/rustc_data_structures/src/tagged_ptr/drop/tests.rs
-@@ -4,6 +4,7 @@ use std::sync::Arc;
- use crate::tagged_ptr::{Pointer, Tag, Tag2, TaggedPtr};
+ }
=20
  #[test]
 +#[ignore]
  fn smoke() {
      let value =3D 12u32;
      let reference =3D &value;
-diff --git a/library/std/src/thread/local/tests.rs b/library/std/src/threa=
d/local/tests.rs
+diff --git a/library/std/tests/thread_local/tests.rs b/library/std/tests/t=
hread_local/tests.rs
 index 9d4f52a092..d425e5f7b7 100644
---- a/library/std/src/thread/local/tests.rs
-+++ b/library/std/src/thread/local/tests.rs
+--- a/library/std/tests/thread_local/tests.rs
++++ b/library/std/tests/thread_local/tests.rs
 @@ -346,6 +346,7 @@ fn join_orders_after_tls_destructors() {
=20
  // Test that thread::current is still available in TLS destructors.
@@ -242,3 +230,32 @@ index a05f274136..0e69b4cb98 100644
  fn sparse_inserts() {
      let cache: VecCache<u32, u8, u32> =3D VecCache::default();
      let end =3D if cfg!(target_pointer_width =3D "64") && cfg!(target_os =
=3D "linux") {
+diff --git a/tests/assembly/dwarf-mixed-versions-lto.rs b/tests/assembly/d=
warf-mixed-versions-lto.rs
+index 5b8e5ff4f4a..e558fbd7bd7 100644
+--- a/tests/assembly/dwarf-mixed-versions-lto.rs
++++ b/tests/assembly/dwarf-mixed-versions-lto.rs
+@@ -1,6 +1,11 @@
+ // This test ensures that if LTO occurs between crates with different DWA=
RF versions, we
+ // will choose the highest DWARF version for the final binary. This match=
es Clang's behavior.
+
++//@ only-x86
++//@ only-x86_64
++//@ only-arm
++//@ only-aarch64
++
+ //@ only-linux
+ //@ aux-build:dwarf-mixed-versions-lto-aux.rs
+ //@ compile-flags: -C lto -g -Zdwarf-version=3D5
+diff --git a/tests/codegen/dont-shuffle-bswaps.rs b/tests/codegen/dont-shu=
ffle-bswaps.rs
+index 0e712bc3a4e..93965d990d0 100644
+--- a/tests/codegen/dont-shuffle-bswaps.rs
++++ b/tests/codegen/dont-shuffle-bswaps.rs
+@@ -1,3 +1,8 @@
++//@ only-x86
++//@ only-x86_64
++//@ only-arm
++//@ only-aarch64
++
+ //@ revisions: OPT2 OPT3
+ //@[OPT2] compile-flags: -Copt-level=3D2
+ //@[OPT3] compile-flags: -C opt-level=3D3
diff --git a/recipes-devtools/rust/libstd-rs_1.85.1.bb b/recipes-devtools/r=
ust/libstd-rs_1.86.0.bb
similarity index 95%
rename from recipes-devtools/rust/libstd-rs_1.85.1.bb
rename to recipes-devtools/rust/libstd-rs_1.86.0.bb
index 00802f0..b39ec0a 100644
--- a/recipes-devtools/rust/libstd-rs_1.85.1.bb
+++ b/recipes-devtools/rust/libstd-rs_1.86.0.bb
@@ -2,7 +2,7 @@ SUMMARY =3D "Rust standard libaries"
 HOMEPAGE =3D "http://www.rust-lang.org"
 SECTION =3D "devel"
 LICENSE =3D "(MIT | Apache-2.0) & Unicode-3.0"
-LIC_FILES_CHKSUM =3D "file://../../COPYRIGHT;md5=3D9c0fae516fe8aaea2fb601d=
b4800daf7"
+LIC_FILES_CHKSUM =3D "file://../../COPYRIGHT;md5=3D11a3899825f4376896e438c=
8c753f8dc"
=20
 require rust-source.inc
=20
diff --git a/recipes-devtools/rust/rust-cross-canadian_1.85.1.bb b/recipes-=
devtools/rust/rust-cross-canadian_1.86.0.bb
similarity index 100%
rename from recipes-devtools/rust/rust-cross-canadian_1.85.1.bb
rename to recipes-devtools/rust/rust-cross-canadian_1.86.0.bb
diff --git a/recipes-devtools/rust/rust-llvm_1.85.1.bb b/recipes-devtools/r=
ust/rust-llvm_1.86.0.bb
similarity index 96%
rename from recipes-devtools/rust/rust-llvm_1.85.1.bb
rename to recipes-devtools/rust/rust-llvm_1.86.0.bb
index 2ba37f0..327e8e6 100644
--- a/recipes-devtools/rust/rust-llvm_1.85.1.bb
+++ b/recipes-devtools/rust/rust-llvm_1.86.0.bb
@@ -2,9 +2,9 @@ SUMMARY =3D "LLVM compiler framework (packaged with rust)"
 LICENSE ?=3D "Apache-2.0-with-LLVM-exception"
 HOMEPAGE =3D "http://www.rust-lang.org"
=20
-# check src/llvm-project/llvm/CMakeLists.txt for llvm version in use
+# check src/llvm-project/cmake/Modules/LLVMVersion.cmake for llvm version =
in use
 #
-LLVM_RELEASE =3D "19.1.5"
+LLVM_RELEASE =3D "19.1.7"
=20
 require rust-source.inc
=20
diff --git a/recipes-devtools/rust/rust-snapshot.inc b/recipes-devtools/rus=
t/rust-snapshot.inc
index 98358bc..445390f 100644
--- a/recipes-devtools/rust/rust-snapshot.inc
+++ b/recipes-devtools/rust/rust-snapshot.inc
@@ -4,56 +4,56 @@
 ## The exact (previous) version that has been used is specified in the sou=
rce tarball.
 ## The version is replicated here.
=20
-SNAPSHOT_VERSION =3D "1.84.0"
+SNAPSHOT_VERSION =3D "1.85.0"
=20
-SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "9f5650aece53e083b933a57e5a8=
e0e2db4479f52ec897d5b6d0f77be6cd50498"
-SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "023f0b6153b23ac0e9686c2a=
b95bc393ee3e295b166bb36de3b4dfb53e3913e0"
-SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "68d4ad239b6d1e810e7b8591636=
dc408cb2c1e89661329fed906febf9c0a9d98"
-SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "6022245416a988b9952f36bf20=
f62de0c2f3337bd150e34439ea6651592ac8ca"
+SRC_URI[rustc-snapshot-aarch64.sha256sum] =3D "e742b768f67303010b002b515f6=
613c639e69ffcc78cd0857d6fe7989e9880f6"
+SRC_URI[rust-std-snapshot-aarch64.sha256sum] =3D "8af1d793f7820e9ad0ee2324=
7a9123542c3ea23f8857a018651c7788af9bc5b7"
+SRC_URI[cargo-snapshot-aarch64.sha256sum] =3D "cdebe48b066d512d664c13441e8=
fae2d0f67106c2080aa44289d98b24192b8bc"
+SRC_URI[clippy-snapshot-aarch64.sha256sum] =3D "f3b8e769021a6bcee8174ac49a=
60c367effb6d97af0f2a6c44dc9ea39ff2bda9"
=20
-SRC_URI[rustc-snapshot-i686.sha256sum] =3D "f0bc277e8e8c072d20ee91784f919c=
08b34a65ab56b67bcd2bb98a009cdcf97c"
-SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "e710100be26e742733d445722a3=
7227381f1ec2010664ece85489bc598d70456"
-SRC_URI[cargo-snapshot-i686.sha256sum] =3D "3a20231475b75f2f6ad0f7c5de283c=
5706403b41e941d3f1ca6cccfbced214c6"
-SRC_URI[clippy-snapshot-i686.sha256sum] =3D "8b5bdd84b9128abc6d61bc1acb60e=
55eab90e063c7057371b4e6f79aaa1acb9b"
+SRC_URI[rustc-snapshot-i686.sha256sum] =3D "c5a5751f3cfa027b53fee83d01dec8=
e555f3622b6993335aed12b1747aa9543c"
+SRC_URI[rust-std-snapshot-i686.sha256sum] =3D "401571adfe1223d83ed041e5a8c=
54c1f3afb3010d1d5b0c1fd79e7da1ab0a0de"
+SRC_URI[cargo-snapshot-i686.sha256sum] =3D "3832027242911ab96fd86128587fc5=
63596a5b10e8e38a073facf61c1ac9668f"
+SRC_URI[clippy-snapshot-i686.sha256sum] =3D "74ed13a67c6ea0452c0d9e8697c6c=
fdd8280f983b207187ac93c287f72b65066"
=20
-SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "33ecfb62afce6e30864f07b=
4e3b76ac6d9f603a3626e5228ad0d59a7ee263cc1"
-SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "763b93ca08028a1e63a8=
a3754ac6118b2659022538e5e33675f2d7620488cd57"
-SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "1531b9f3d09983c43f54d7e=
5ced6b452044e82b24609532e8cee345656e5d8a4"
-SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "80719f10010eaf6a26ba7b=
2f8c5c7bce3a78fd838cbbe17c00a4e3e7cd45fe5e"
+SRC_URI[rustc-snapshot-loongarch64.sha256sum] =3D "d43d2119ff25d879b2d280d=
3e5a03fcd21c57a32d479ad5626500c32432f18c9"
+SRC_URI[rust-std-snapshot-loongarch64.sha256sum] =3D "2d05f5e13e7cb3ee6b0c=
a0dcd13a231a28eeb0faa4d15257a35cf7284149cd6a"
+SRC_URI[cargo-snapshot-loongarch64.sha256sum] =3D "9aa447eefcd3ba2f9dbab77=
596c8669849899ab243543fc8f1914089707081ac"
+SRC_URI[clippy-snapshot-loongarch64.sha256sum] =3D "d437b39465343a71ff475a=
65acb6c03bc0f800861f293f48accf1fa170458432"
=20
-SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "ac99e907c9819b61de94a6c12b6=
4256661e5d76c53f3ed25246b46741d1dc973"
-SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "fdbb75060e59ad59273a8ef1=
1fc2ad61837539686df0e8dfe46107e1b15ab90a"
-SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "dedcb36320cfa924e2d21552057=
f88ee8a30c0424802015494c2f6237150ec55"
-SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "de2413ae321d2bccf77c77acb1=
e9775b63eca1993ee1450e65e388f029565a51"
+SRC_URI[rustc-snapshot-powerpc.sha256sum] =3D "fbe7154abc641d6cacfdc6239ed=
4701fc7a09b5046c6d1bd209b59e7f2b2d0f0"
+SRC_URI[rust-std-snapshot-powerpc.sha256sum] =3D "ab2d5ac7cd295adaa4d959e8=
abbf42b372292c95d1a9f18aad64951ad6e2ab2b"
+SRC_URI[cargo-snapshot-powerpc.sha256sum] =3D "e67c30a72f969c51ad199084b3c=
e0cdc573a4e21f732b2cc39dafbcb9807a5ce"
+SRC_URI[clippy-snapshot-powerpc.sha256sum] =3D "497104d49803598cd3801749ac=
86cb26c88a2bd9c3a8c7bdc18fdf487f4650c0"
=20
-SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "1f5ff831c9fd97d7d306eb7d9=
9186b9e49f35527144aaabd43f67f04449cd732"
-SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "f2819f8ce1ae41c2c2bcf4=
0fc90d6b1a5d340d3e9558267d464730a797122bf5"
-SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "09d9954bf817404c08a8ac952=
afe1e086ad11fe20d07522a4bde5f26bf7fb5d2"
-SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "a34cde35f254210cbb212c3f=
a85411efaa8e70d600d2c2404b7b319eae9b5be6"
+SRC_URI[rustc-snapshot-powerpc64.sha256sum] =3D "f8e38291ba4241bc28e9c118d=
7a449ce3601abdeb2076f2f618858679fb3b929"
+SRC_URI[rust-std-snapshot-powerpc64.sha256sum] =3D "e9ff89e759125ad2786ad2=
f6c40e820095720ea00fba66819d15fba79489430a"
+SRC_URI[cargo-snapshot-powerpc64.sha256sum] =3D "73cf850f6715acbf0029c7e5d=
4694825f61bd4e193e6413e65a78bcb13df97b7"
+SRC_URI[clippy-snapshot-powerpc64.sha256sum] =3D "29b63f23cd9af95846a246c9=
cc8349e514c3fb92ec0c840a38155e252d6cc668"
=20
-SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "1f6aa28f848b24d4589277b=
04535ad0258e72b5fa78a4a85ba6d18db95636d69"
-SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "db731e894cce9973ab2b=
41109c9097d0fc6a49c0d45a0d333bd1547d2c7485a1"
-SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "7dc351327de2567cce2a338=
7f110cce1db20c68fc529353c5cdef2eada5dbfd8"
-SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "b53cb58c719b84044de628=
51b6214db8d504f57ad71e81b373d7dea0393146d8"
+SRC_URI[rustc-snapshot-powerpc64le.sha256sum] =3D "371e40f9d6d82aecb056f70=
f82868d98ddc1c20510aa7d388442ac8d2d86a6ca"
+SRC_URI[rust-std-snapshot-powerpc64le.sha256sum] =3D "d0cfda4e18623d17922e=
b367e44ac9549ab3d5fe1c0bdbe0c2c95754255fa705"
+SRC_URI[cargo-snapshot-powerpc64le.sha256sum] =3D "e1469f4249a7e21f872af48=
7dcd1bd10ce388b5b3679bdab0cb0965e1e30fe47"
+SRC_URI[clippy-snapshot-powerpc64le.sha256sum] =3D "d8c590bc2e6fc75800e415=
16427f5095ba0e15d7633167689499fcf6523dc61a"
=20
-SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "c0eaf824c7789c94901f89579=
2333595fe131e43f097bcf5987301cc1b14c3f0"
-SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "451580f9cdc47eef4efb09=
86b1960a8f9c4fb0959f81b77eb6292e6bcff9fc64"
-SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "3a850b74bdf2c3a5912e9f1ea=
32aaf1c9ac7c5f89c1c0bcf421b961195833992"
-SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "fb8c9d489e10a961f9faa550=
980069738b5f0f68740e34d7b3ee46a262b53af7"
+SRC_URI[rustc-snapshot-riscv64gc.sha256sum] =3D "2da33044f17a8bc49a1478dc1=
eb2536df491a44d6e6bb0ec7c86f46877d44e98"
+SRC_URI[rust-std-snapshot-riscv64gc.sha256sum] =3D "0f5ecfe54859bbe715821f=
982b1a5396784fdf55605d00ece05d3e57a965ed16"
+SRC_URI[cargo-snapshot-riscv64gc.sha256sum] =3D "c9f28b519799fc2d8089865e3=
0fad04bb5339604d13725365fcd7ad7ee6c1489"
+SRC_URI[clippy-snapshot-riscv64gc.sha256sum] =3D "9d21bc180196bccdb301e7e0=
3034d3fd0df14b0c6520da0317bba7b1ce385fe8"
=20
-SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "7dbc2fc2c04e820f636bfc7409339=
6c55df0296f7ee4f0547bb849d9a9f05fe0"
-SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "5208f45cec5f3600f2cbc11d17=
96bc217f09e9c922689c8e4f0cc3f2b83ebb74"
-SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "bdf944ff5c0b97e8b64093fff8d1f=
63926df86b5e98f91d30c7bd844c6efa20f"
-SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "b02a586369e6edebb0f0608e3964=
72d1867419213fd01ba32f3c847e4c5a3c07"
+SRC_URI[rustc-snapshot-s390x.sha256sum] =3D "308361737ed522aa77dd8b4ea91b5=
db244113ada5fa234d3ed008b526d07e2e8"
+SRC_URI[rust-std-snapshot-s390x.sha256sum] =3D "d25053fbee1a0cb899bac8c8e4=
968aa35f9c3637e486cb5bb2c79ad43a78f3e7"
+SRC_URI[cargo-snapshot-s390x.sha256sum] =3D "7e1defd60095c91ded1612194f811=
ec5f2fc2e83bb914d35594d01fa3c54049d"
+SRC_URI[clippy-snapshot-s390x.sha256sum] =3D "9780d8c4cfef9d05460b3e540aad=
142391b2e3994accf8cfc8afb87fefac6cf0"
=20
-SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "a1737d86f80b31a6d48a67267262=
75dc068ecb930c9635b13aa59999486de837"
-SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "770237080b9310d126350c3bd=
70820bd91064c2e96c29ab5f2e002b31b5bd067"
-SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "6c2371488db92a09cd50a1b4045c=
022f3cf2c643285b3b21105ab5f9b64fd6b6"
-SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "1db0212c08e126bf6ee28a0d363=
c5d6859fe357aa9e91d0247059397dbe7e1fd"
+SRC_URI[rustc-snapshot-x86_64.sha256sum] =3D "7436f13797475082cd87aa655474=
49e01659d6a810b4cd5f8aedc48bb9f89dfb"
+SRC_URI[rust-std-snapshot-x86_64.sha256sum] =3D "285e105d25ebdf501341238d4=
c0594ecdda50ec9078f45095f793a736b1f1ac2"
+SRC_URI[cargo-snapshot-x86_64.sha256sum] =3D "0aff33b57b0e0b102d762a2b5304=
2846c1ca346cff4b7bd96b5c03c9e8e51d81"
+SRC_URI[clippy-snapshot-x86_64.sha256sum] =3D "0dc3ca1708a6c9eed05d0802364=
377572b79ff079815b7bcbe8e3991f77c4117"
=20
-SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "a877622fbbfa58304c34372d369=
e95db106cc35758ca59053144bf7d86fbf3fc"
+SRC_URI[rust-std-snapshot-i586.sha256sum] =3D "3cb7318da10876de14076549d79=
410a8441923a92d62b616d8c105f5f5cd831b"
=20
-SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "ecd1662d6cbbb62984ab31ae=
787442f1ab32caf6bc17260d407b3a94b434ad32"
+SRC_URI[rust-std-snapshot-sparc64.sha256sum] =3D "65cd47af46a5b74e61ff6ae4=
cce8a979ee8670a57b8aa61e732828d1da073f73"
=20
 SRC_URI +=3D " \
     ${RUST_DIST_SERVER}/dist/${RUST_STD_SNAPSHOT}.tar.xz;name=3Drust-std-s=
napshot-${RUST_BUILD_ARCH};subdir=3Drust-snapshot-components \
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index 6cb08b7..f9c1fcd 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -7,11 +7,10 @@ SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${R=
UST_VERSION}-src.tar.xz;n
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.pa=
tch;patchdir=3D${RUSTSRC} \
             file://0001-src-core-build_steps-tool.rs-switch-off-lto-for-ru=
st.patch;patchdir=3D${RUSTSRC} \
             file://revert-link-std-statically-in-rustc_driver-feature.patc=
h;patchdir=3D${RUSTSRC} \
-            file://Zdual-proc-macros-additional-check.patch;patchdir=3D${R=
USTSRC} \
             file://0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.=
patch;patchdir=3D${RUSTSRC} \
             file://0001-Disable-libunwind-cross-architecture-unwinding.pat=
ch;patchdir=3D${RUSTSRC} \
 "
-SRC_URI[rust.sha256sum] =3D "b1fbf809efe9f036939401e142631c201a53bcf43ec16=
96bd9f5290ba236a266"
+SRC_URI[rust.sha256sum] =3D "d939eada065dc827a9d4dbb55bd48533ad14c16e7f0a4=
2e70147029c82a7707b"
=20
 RUSTSRC =3D "${WORKDIR}/rustc-${RUST_VERSION}-src"
=20
diff --git a/recipes-devtools/rust/rust_1.85.1.bb b/recipes-devtools/rust/r=
ust_1.86.0.bb
similarity index 96%
rename from recipes-devtools/rust/rust_1.85.1.bb
rename to recipes-devtools/rust/rust_1.86.0.bb
index d968aff..6f6d7e5 100644
--- a/recipes-devtools/rust/rust_1.85.1.bb
+++ b/recipes-devtools/rust/rust_1.86.0.bb
@@ -2,18 +2,18 @@ SUMMARY =3D "Rust compiler and runtime libaries"
 HOMEPAGE =3D "http://www.rust-lang.org"
 SECTION =3D "devel"
 LICENSE =3D "(MIT | Apache-2.0) & Unicode-3.0"
-LIC_FILES_CHKSUM =3D "file://COPYRIGHT;md5=3D9c0fae516fe8aaea2fb601db4800d=
af7"
+LIC_FILES_CHKSUM =3D "file://COPYRIGHT;md5=3D11a3899825f4376896e438c8c753f=
8dc"
=20
 inherit rust
 inherit cargo_common
=20
-DEPENDS +=3D "rust-llvm"
+DEPENDS +=3D "rust-llvm pkgconfig-native openssl ninja-native"
 # native rust uses cargo/rustc from binary snapshots to bootstrap
 # but everything else should use our native builds
 DEPENDS:append:class-target =3D " cargo-native rust-native"
 DEPENDS:append:class-nativesdk =3D " cargo-native rust-native"
=20
-RDEPENDS:${PN}:append:class-target =3D " gcc g++ binutils"
+RDEPENDS:${PN}:append:class-target =3D " gcc g++ binutils bash"
=20
 # Otherwise we'll depend on what we provide
 INHIBIT_DEFAULT_RUST_DEPS:class-native =3D "1"
@@ -135,6 +135,8 @@ python do_configure() {
     config.set("rust", "remap-debuginfo", e(True))
     config.set("rust", "download-rustc", e(False))
     config.set("rust", "llvm-tools", e(False))
+    config.set("rust", "lld", e(False))
+    config.set("rust", "use-lld", e(False))
     config.set("rust", "channel", e(d.expand("${RUST_CHANNEL}")))
=20
     # Whether or not to optimize the compiler and standard library
@@ -155,6 +157,8 @@ python do_configure() {
     cargo =3D d.getVar('CARGO_BOOTSTRAP')
     config.set("build", "cargo", e(cargo))
=20
+    config.set("build", "extended", e(False))
+
     config.set("build", "vendor", e(True))
=20
     config.set("build", "target", e([d.getVar("RUST_TARGET_SYS")]))
@@ -233,10 +237,12 @@ do_test_compile () {
=20
 ALLOW_EMPTY:${PN} =3D "1"
=20
-PACKAGES =3D+ "${PN}-rustdoc ${PN}-tools-clippy ${PN}-tools-rustfmt"
+PACKAGES =3D+ "${PN}-rustdoc ${PN}-tools-clippy ${PN}-tools-rustfmt ${PN}-=
zsh-completion"
 FILES:${PN}-rustdoc =3D "${bindir}/rustdoc"
 FILES:${PN}-tools-clippy =3D "${bindir}/cargo-clippy ${bindir}/clippy-driv=
er"
 FILES:${PN}-tools-rustfmt =3D "${bindir}/rustfmt"
+FILES:${PN}-zsh-completion =3D "${datadir}/zsh"
+
 RDEPENDS:${PN}-rustdoc =3D "${PN}"
 RDEPENDS:${PN}-tools-clippy =3D "${PN}"
 RDEPENDS:${PN}-tools-rustfmt =3D "${PN}"
@@ -252,6 +258,10 @@ rust_do_install() {
     rust_runx install
 }
=20
+rust_do_install:append:class-native () {
+    rm -f ${D}${bindir}/cargo
+}
+
 rust_do_install:class-nativesdk() {
     export PSEUDO_UNLOAD=3D1
     rust_runx install
--=20
2.50.0


