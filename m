Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D00C3ABB6
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:12 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web11.4674.1746132071692625586
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:41:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kBcjI74d;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so21501056d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132070; x=1746736870; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZr9gMmtY8BWKzWsdJt67xr+3N/amp+mOBLgeX3rm+U=;
        b=kBcjI74d/HEVTl91Cukc7xNXE5p2oZA6U+VVTQ0zUI4BOONZxj0mZKoyXcZwkilbq4
         Zzr6IDkqnuz0BZD4rXnCgAQYEvUv8bLxy47UZqJJywr8AXGxqxZh37PtL7SZDc3MO+fM
         ZhpEjd/saaW3WxCuAMSCXA8omz7CLkcUSd3Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132070; x=1746736870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZr9gMmtY8BWKzWsdJt67xr+3N/amp+mOBLgeX3rm+U=;
        b=CGHK9cdta7oizFnYhrC7MEiEU/zlgKp/Z+y5YdPlno1qDMycGFxrQKRoX++FwhHLd4
         zVoLCmSgUQMBIU83oJl7Qo5kKf0HOErGQBW0x34utzvCTeMbqx3YXrvGPf4mz0VkBHSj
         OXSY92CNxi6TE8Y1vptc0xt8Iz138XbGlk2fdR3KYqQMWBaXyO9mN4JvweCstd1ID0qG
         hyBRs2cugMBRGbkF4cEgLVtxHZa/nxzo9+s0O/8BB4RhsKZZ8uLq57oBfBJPf9GovwcU
         BE1SfYOrMYUrjLFBuOBitB5bz3g9/LtXe7izM++niuAGTp2LloaemiMvToOiZSbkWE+B
         oC8A==
X-Gm-Message-State: AOJu0YxIwZgfVSbeBMDMKZeXhIQvJKTX4oez3g3XRaIhfynE1hrs/5m2
	3OD5AkmLBQYoTNHc6kIkzWh90IMGeXU/uC0d0JUVHEm+I7JrwUrmD9zDlthOuBi/PuGWPkS9eWc
	5
X-Gm-Gg: ASbGncv0ZccRU93AnYkNNVWsLNERJ9ybeKO4TLRiW7GA3ZxEdRSpsAoGQStQQokONCN
	f1OvyW8wFJIm8Mh0N4v3KW5EPw4WtTinVSXgbyxBC3REOjG+J9tzCpSfsYqQXN9yqOK8tO3sy6y
	keaJc/eq/PQf6/HsPZFvLs86pm1+iaihpEM+Es1Wwtd9hgko0pXWyL3QB/1uT7QG86FnuRQAtwU
	/PEYiYB1Tjk4I+IFUZQlEcYMAZvn8aajYY1HmuuTwd8rp3IaJWY6Tfnm8IKhfdKSl8JaXTOTRAY
	6BNA3SlbGFvl/+rRRVwlxaXbImOYe+A/zFumJCFrMwArG29+9N1FeImcYRGJqn1V6P9H482GjIJ
	BhtbTIrfugRW923u3
X-Google-Smtp-Source: AGHT+IFVx/H3P0AzmZtrq5aKNVK8IxUapTYxXlEEpv0J90qx4XQGc++SiQLElCoBwwH1k+Q4KJvp8A==
X-Received: by 2002:a05:6214:226c:b0:6f2:b551:a63 with SMTP id 6a1803df08f44-6f515254070mr10435116d6.3.1746132068484;
        Thu, 01 May 2025 13:41:08 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.41.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:41:07 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 33/38] cargo-c,rust: Fix build on risv32
Date: Thu,  1 May 2025 16:40:09 -0400
Message-ID: <bd697990df7f47f9fec21afe51a5a6bdffe779fa.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1462

From: Khem Raj <raj.khem@gmail.com>

Apply fix in libc that are needed for rustix-0.38 to build.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit c21fd6f1c0b6a9df9950c541025f24e342b7a118)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...l-codes-on-riscv32gc-unknown-linux-g.patch |  38 +++
 .../rust/cargo-c_0.10.5+cargo-0.83.0.bb       |   1 +
 ...l-codes-on-riscv32gc-unknown-linux-g.patch | 112 +++++++++
 .../files/rv32-cargo-rustix-0.38.40-fix.patch | 236 ------------------
 recipes-devtools/rust/rust-source.inc         |   2 +-
 5 files changed, 152 insertions(+), 237 deletions(-)
 create mode 100644 recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-co=
des-on-riscv32gc-unknown-linux-g.patch
 create mode 100644 recipes-devtools/rust/files/0001-Define-more-ioctl-code=
s-on-riscv32gc-unknown-linux-g.patch
 delete mode 100644 recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-f=
ix.patch

diff --git a/recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-=
riscv32gc-unknown-linux-g.patch b/recipes-devtools/rust/cargo-c/0001-Define=
-more-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
new file mode 100644
index 0000000..3b99361
--- /dev/null
+++ b/recipes-devtools/rust/cargo-c/0001-Define-more-ioctl-codes-on-riscv32=
gc-unknown-linux-g.patch
@@ -0,0 +1,38 @@
+From 3665e73b2f087370f8058c12911996b109d8e93a Mon Sep 17 00:00:00 2001
+From: Dan Gohman <dev@sunfishcode.online>
+Date: Sun, 6 Apr 2025 05:22:49 -0700
+Subject: [PATCH] Define more ioctl codes on riscv32gc-unknown-linux-gnu
+
+Define ioctl codes including `FICLONE` and `FS_IOC32_GETVERSION` on
+riscv32gc-unknown-linux-gnu.
+
+Upstream-Status: Submitted [https://github.com/rust-lang/libc/pull/4382]
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+---
+ src/unix/linux_like/linux/arch/generic/mod.rs | 6 +++++-
+ 1 file changed, 5 insertions(+), 1 deletion(-)
+
+diff --git a/src/unix/linux_like/linux/arch/generic/mod.rs b/src/unix/linu=
x_like/linux/arch/generic/mod.rs
+index 2f437e1..fdac4bb 100644
+--- a/src/unix/linux_like/linux/arch/generic/mod.rs
++++ b/src/unix/linux_like/linux/arch/generic/mod.rs
+@@ -114,6 +114,7 @@ cfg_if! {
+                  target_arch =3D "x86_64",
+                  target_arch =3D "arm",
+                  target_arch =3D "aarch64",
++                 target_arch =3D "riscv32",
+                  target_arch =3D "riscv64",
+                  target_arch =3D "s390x",
+                  target_arch =3D "csky",
+@@ -218,7 +219,10 @@ cfg_if! {
+     // where S stands for size (int, long, struct...)
+     // where T stands for type ('f','v','X'...)
+     // where N stands for NR (NumbeR)
+-    if #[cfg(any(target_arch =3D "x86", target_arch =3D "arm", target_arc=
h =3D "csky"))] {
++    if #[cfg(any(target_arch =3D "x86",
++                 target_arch =3D "arm",
++                 target_arch =3D "csky",
++                 target_arch =3D "riscv32"))] {
+         pub const FS_IOC_GETFLAGS: ::Ioctl =3D 0x80046601;
+         pub const FS_IOC_SETFLAGS: ::Ioctl =3D 0x40046602;
+         pub const FS_IOC_GETVERSION: ::Ioctl =3D 0x80047601;
diff --git a/recipes-devtools/rust/cargo-c_0.10.5+cargo-0.83.0.bb b/recipes=
-devtools/rust/cargo-c_0.10.5+cargo-0.83.0.bb
index ff5cc1f..b1b7804 100644
--- a/recipes-devtools/rust/cargo-c_0.10.5+cargo-0.83.0.bb
+++ b/recipes-devtools/rust/cargo-c_0.10.5+cargo-0.83.0.bb
@@ -6,6 +6,7 @@ LIC_FILES_CHKSUM =3D " \
 "
=20
 SRC_URI =3D "crate://crates.io/cargo-c/${PV}"
+SRC_URI +=3D "file://0001-Define-more-ioctl-codes-on-riscv32gc-unknown-lin=
ux-g.patch;patchdir=3D${CARGO_VENDORING_DIRECTORY}/libc-0.2.161"
 SRC_URI[cargo-c.sha256sum] =3D "5bfa9ba93806384d940e71dafbc185316e0a6a4756=
1b33b7105fcf67f99df70a"
=20
 inherit cargo cargo-update-recipe-crates pkgconfig
diff --git a/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-ri=
scv32gc-unknown-linux-g.patch b/recipes-devtools/rust/files/0001-Define-mor=
e-ioctl-codes-on-riscv32gc-unknown-linux-g.patch
new file mode 100644
index 0000000..b3a95f2
--- /dev/null
+++ b/recipes-devtools/rust/files/0001-Define-more-ioctl-codes-on-riscv32gc=
-unknown-linux-g.patch
@@ -0,0 +1,112 @@
+From d98ea9082af39ed003be8f1d96f7315de663e89f Mon Sep 17 00:00:00 2001
+From: Khem Raj <raj.khem@gmail.com>
+Date: Sun, 6 Apr 2025 08:29:28 -0700
+Subject: [PATCH] Define more ioctl codes on riscv32gc-unknown-linux-gnu
+
+Define ioctl codes including `FICLONE` and `FS_IOC32_GETVERSION` on
+riscv32gc-unknown-linux-gnu.
+
+Upstream-Status: Submitted [https://github.com/rust-lang/libc/pull/4382]
+
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+---
+ vendor/libc-0.2.158/.cargo-checksum.json                    | 2 +-
+ .../src/unix/linux_like/linux/arch/generic/mod.rs           | 6 +++++-
+ vendor/libc-0.2.167/.cargo-checksum.json                    | 2 +-
+ .../src/unix/linux_like/linux/arch/generic/mod.rs           | 4 +++-
+ vendor/libc-0.2.169/.cargo-checksum.json                    | 2 +-
+ .../src/unix/linux_like/linux/arch/generic/mod.rs           | 4 +++-
+ 6 files changed, 14 insertions(+), 6 deletions(-)
+
+diff --git a/vendor/libc-0.2.158/.cargo-checksum.json b/vendor/libc-0.2.15=
8/.cargo-checksum.json
+index 636165bc0..dc86fd0db 100644
+--- a/vendor/libc-0.2.158/.cargo-checksum.json
++++ b/vendor/libc-0.2.158/.cargo-checksum.json
+@@ -1 +1 @@
+-{"files":{"CHANGELOG.md":"96fb278d188e87842fe2701f91e0f757665b44dc2e549ac=
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
+\ No newline at end of file
++{"files":{"CHANGELOG.md":"96fb278d188e87842fe2701f91e0f757665b44dc2e549ac=
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
+diff --git a/vendor/libc-0.2.158/src/unix/linux_like/linux/arch/generic/mo=
d.rs b/vendor/libc-0.2.158/src/unix/linux_like/linux/arch/generic/mod.rs
+index 2f437e16d..db1f1e70f 100644
+--- a/vendor/libc-0.2.158/src/unix/linux_like/linux/arch/generic/mod.rs
++++ b/vendor/libc-0.2.158/src/unix/linux_like/linux/arch/generic/mod.rs
+@@ -114,6 +114,7 @@ cfg_if! {
+                  target_arch =3D "x86_64",
+                  target_arch =3D "arm",
+                  target_arch =3D "aarch64",
++                 target_arch =3D "riscv32",
+                  target_arch =3D "riscv64",
+                  target_arch =3D "s390x",
+                  target_arch =3D "csky",
+@@ -218,7 +219,10 @@ cfg_if! {
+     // where S stands for size (int, long, struct...)
+     // where T stands for type ('f','v','X'...)
+     // where N stands for NR (NumbeR)
+-    if #[cfg(any(target_arch =3D "x86", target_arch =3D "arm", target_arc=
h =3D "csky"))] {
++    if #[cfg(any(target_arch =3D "x86",
++                 target_arch =3D "arm",
++                 target_arch =3D "riscv32",
++                 target_arch =3D "csky"))] {
+         pub const FS_IOC_GETFLAGS: ::Ioctl =3D 0x80046601;
+         pub const FS_IOC_SETFLAGS: ::Ioctl =3D 0x40046602;
+         pub const FS_IOC_GETVERSION: ::Ioctl =3D 0x80047601;
+diff --git a/vendor/libc-0.2.167/.cargo-checksum.json b/vendor/libc-0.2.16=
7/.cargo-checksum.json
+index 7ea5d4122..def87f4ef 100644
+--- a/vendor/libc-0.2.167/.cargo-checksum.json
++++ b/vendor/libc-0.2.167/.cargo-checksum.json
+@@ -1 +1 @@
+-{"files":{"CHANGELOG.md":"ab0bd175d8a317894835d3bea1e1d78780adb818705bd77=
e230d6972c2ed3633","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.toml":"0912337103f997c684c700d066b62181=
c7f7b9a23e4e12faaf5c1a2b54a78757","LICENSE-APACHE":"62c7a1e35f56406896d7aa7=
ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56=
a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"38061c8bb600c=
2e01b48b662288cb11f38c0ec27bbe6d496e7f0acb1016991c4","build.rs":"bcbe11dc71=
1029460fcc4f7fd8e38c487006ad0860007915ae6718bd90fb891a","rustfmt.toml":"e93=
21ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fixed_w=
idth_ints.rs":"10eb30cf48390768f0167e1fa46ae99461968a05e93bd96aff721f54550a=
e66c","src/fuchsia/aarch64.rs":"d430586295c7eb022eb8202f7b18e483a9dd0e7de18=
57f7963453792c7161def","src/fuchsia/mod.rs":"f452b1cc842cc92c6c7676376adba8=
3c1f5ccc2460e80626099ec520ba23a48b","src/fuchsia/riscv64.rs":"7efd6cbcbd2cb=
25d6380f6df69ad91cf62efd55fb9cb7cb85884c490b601743e","src/fuchsia/x86_64.rs=
":"e63daa4085c6f6ab35d9711df6d7e027247a8b3b2a6dc47fcb2b21e1f4820a2f","src/h=
ermit.rs":"35c1e248f2b3608017f696a79d4a114c889176c9d281a1544916360c62be2301=
","src/lib.rs":"a8cd1626f2dd03c25242ce82856d04625ef0c3910de6ea2df729408831e=
eda38","src/macros.rs":"cb65803b265ba63ffe37375ae08703ab0b8b90972ed22da3cf7=
812eef421a6cd","src/psp.rs":"dcf53184a1ab06d18aa34431ca42644c5646fe78d05a53=
678ef9529607ba3ea7","src/sgx.rs":"f0f1a9fa864cd3dc94c4b3ce73f88e67f11453f63=
d8b4d52823de2ccbba7eb49","src/solid/aarch64.rs":"a726e47f324adf73a4a0b67a2c=
183408d0cad105ae66acf36db37a42ab7f8707","src/solid/arm.rs":"e39a4f74ebbef3b=
97b8c95758ad741123d84ed3eb48d9cf4f1f4872097fc27fe","src/solid/mod.rs":"0111=
6b18b9be6791fdf4ff572d12154b64dfa43a18afc33940ea676e1884bdbb","src/switch.r=
s":"bb0ce1331c61a28caea7bd201e399d1e1127f303dcc7747b4f07f63d188ea49c","src/=
teeos/mod.rs":"7e0a8b550f1109c8247136cabb69308bd0ed2838f00ce0c99a695a3ef9af=
ca22","src/trusty.rs":"2e829bfdaefbba31b907ee5ef577ebc9e8f2e2fee2cde2a4e608=
d5219a435390","src/unix/aix/mod.rs":"4fc9eb4d97b2496aff094754cf6417713b49ca=
8fea63f29c2bdadd5336cd842b","src/unix/aix/powerpc64.rs":"666146ac9e4cb01c49=
ba046ef470d93499d91c0948d86fdce65fcd6cff6ece14","src/unix/bsd/apple/b32/mod=
.rs":"9f20c77e86b812ff09d8193a48fe4f3afd6dae8a43d5a0d78b8592971cc3726e","sr=
c/unix/bsd/apple/b64/aarch64/mod.rs":"1ebe9f1a1e07318813da7e2a78195937533c2=
2b51a23a4527b9404c948318f86","src/unix/bsd/apple/b64/mod.rs":"164e734befe87=
fa6e2d79fb856ce314282bd219ea4f2f357c6446dca6d2de359","src/unix/bsd/apple/b6=
4/x86_64/mod.rs":"e03794fdeaaf4a86c7b12f41e490a7538c12d4a77743a5448237f73d5=
a8593f4","src/unix/bsd/apple/mod.rs":"c9f17938a9733a426e02f4c0951eec9987d23=
1f9dac925d342fca049e548b17c","src/unix/bsd/freebsdlike/dragonfly/errno.rs":=
"07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/uni=
x/bsd/freebsdlike/dragonfly/mod.rs":"f130937ac556080c77d7d1f011f2d2c964b65e=
b633bf6b7f1251a045670b9ec8","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"=
aea276451dca89f086d014b66e2e83e1eb948ab8dfbf920170c1b8338c9777c3","src/unix=
/bsd/freebsdlike/freebsd/arm.rs":"f70c76405a72754db37dff7de3fd586a19e1512b4=
7f452493b430f295d7264af","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs=
":"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/u=
nix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14a=
fae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd11/mod.rs":"400f18465ef118e202ac9b1b9db47b1333fc17eb5841709082f2d1d5a51=
79391","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"fb999d55cf4f340=
3ac934dff1fc70c666087de234d7a91321bcfb5009bbafc6f","src/unix/bsd/freebsdlik=
e/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfa=
a14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":=
"e6f3430838d94dd17e359419f5de7d28a6b3adb8fcab7727d24e034bc6ed5d1e","src/uni=
x/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fc=
e28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fr=
eebsd14/mod.rs":"7d23d7d6b779265bca9c53c8b3e50b4dadb33f3911000ce88c8e09c9f0=
b60eab","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e10=
9dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebs=
dlike/freebsd/freebsd15/mod.rs":"45921502545212949a756d0edad2d861a5c6bc1925=
a4c13c8afc057ce6b4d8fe","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.=
rs":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src=
/unix/bsd/freebsdlike/freebsd/mod.rs":"10c26d1f6c09f797578980e0310978023ff1=
4e4c05977a5748d9c7d65006cc12","src/unix/bsd/freebsdlike/freebsd/powerpc.rs"=
:"36912b999e0571adccc06d9ebbd237e537a95c36ddb97d67a81e940ab28b36e7","src/un=
ix/bsd/freebsdlike/freebsd/powerpc64.rs":"c1c13a3e7633ab6e84929ac3bfac96a67=
779e6cdac157d64b5b9f7c2b32b1691","src/unix/bsd/freebsdlike/freebsd/riscv64.=
rs":"b6bbfb556ed35c3897a98efffbafd5a07854dce1786643ffc1aaaa5a4e7dbe1e","src=
/unix/bsd/freebsdlike/freebsd/x86.rs":"8102bc641970bec32d4f2b93c8ba0e9c0432=
f84cef1442e3bf5438c3ba9c6c4d","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.=
rs":"fab655006e7b0eded6e5a6db0b0cb1efd3dee9205b9a02f315c06093100883a1","src=
/unix/bsd/freebsdlike/mod.rs":"31adfff1db7bed60fa8044b37ef40fbabb929b055670=
cefe3bac88782de879f8","src/unix/bsd/mod.rs":"a776f9bf11ab5245bcddc37bde002f=
28f84ff8f0d919d2dbc37055b3a679d86b","src/unix/bsd/netbsdlike/mod.rs":"d089e=
ef37c5888f59479c4961415b247470a662cd14a1ec65d1f3ebcd304cf31","src/unix/bsd/=
netbsdlike/netbsd/aarch64.rs":"1b526d8c7053d129548202faf3505033152d9c0a6682=
cefe2e8ae23a2a40b289","src/unix/bsd/netbsdlike/netbsd/arm.rs":"47abd680ddb4=
879648cac3d462e0daa7e980b5e6be7ba346f5f494ccdebee6e8","src/unix/bsd/netbsdl=
ike/netbsd/mips.rs":"8420d476126ca2740ff2cbd1e85d0a31334e2c68dd0a70d3ac3e3d=
802b5b5782","src/unix/bsd/netbsdlike/netbsd/mod.rs":"742d6c0607ee20c81a2184=
a6378dc2d9c18f7180a0dc93aa91f830a0d1a06878","src/unix/bsd/netbsdlike/netbsd=
/powerpc.rs":"42f66be7650e95398a3687886db5053e55c77dc04eb139315bebf9668b2be=
d68","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"81664f910e884d70f0a758c42=
a17cc242db4811ce9dda1257fbd66b291cf0d52","src/unix/bsd/netbsdlike/netbsd/sp=
arc64.rs":"78985b140b0337f6bb951f9db68e0db0b5a0a8131ac5c4426a342ed002e27a82=
","src/unix/bsd/netbsdlike/netbsd/x86.rs":"dda4e401f03084a87762fb68c4839987=
56a07b7c5d4b86348fc3f79380024fb7","src/unix/bsd/netbsdlike/netbsd/x86_64.rs=
":"b60e896c10ba86a59b13a189fe2e6b94265244fa4b2bc3f89a46065e7d469dea","src/u=
nix/bsd/netbsdlike/openbsd/aarch64.rs":"91b6ac97e6411261cf5206ab1951a4e4e1f=
1cc9ca26217d7144f000f8f7c8580","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f8=
c975d4b94a8b8d11dcc5224db628997003a8d289f12fb12b398e9445c2f122","src/unix/b=
sd/netbsdlike/openbsd/mips64.rs":"8532a189ae10c7d668d9d4065da8b05d124e09bd3=
9442c9f74a7f231c43eca48","src/unix/bsd/netbsdlike/openbsd/mod.rs":"2e6e0e94=
ae9dd802692bc7258deaf14a4f1b6544bc2dfa853ae753e7e4f27afb","src/unix/bsd/net=
bsdlike/openbsd/powerpc.rs":"f8c975d4b94a8b8d11dcc5224db628997003a8d289f12f=
b12b398e9445c2f122","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"d53f6cc=
d830b8bbe94c9be8a92a719105ed29846d6a11ce6c972fa7ff142a001","src/unix/bsd/ne=
tbsdlike/openbsd/riscv64.rs":"21a90502854e1aab413700edc41bd7922bc6e0fc3d724=
0aa57f258bb4546fa9c","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"d04fd287=
afbaa2c5df9d48c94e8374a532a3ba491b424ddf018270c7312f4085","src/unix/bsd/net=
bsdlike/openbsd/x86.rs":"ebe65020c0d457af0458f549b8c44099a8c274d734bfa6c336=
2f0b6423fa3c7a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"2aec823a0800d2=
8fe546d35e98ae1dc671aa253663f9923d147548233def260a","src/unix/haiku/b32.rs"=
:"c56aa69ed87dded0d297d44a9177577b1d2d4a79ed176e6768c7fc4dab90bfb4","src/un=
ix/haiku/b64.rs":"d44daef26b89e75d58ac0204a169a66ba5fbc13fc40948f67f19700e6=
033a07e","src/unix/haiku/mod.rs":"2589765aa89ad146cf0cb942fe371340293f97a5a=
aecd2dfc0ac0f563eac86f3","src/unix/haiku/native.rs":"8dbd270e9e1d6409952709=
a5a37383bda2660008b745aa01adc02172a20bf939","src/unix/haiku/x86_64.rs":"8d8=
ef6b462bc32b3270440526f35c8dec572b502355c27ad451e64a816c4a176","src/unix/hu=
rd/b32.rs":"3e79bb09b66d8a1d3b7589a4b2b2076e57bd7b51b747f5219f24d3bd2019ad6=
a","src/unix/hurd/b64.rs":"f61f0263a71f39a5130ac749bb0f146e5b95e7b054f49291=
97366f28e8c22815","src/unix/hurd/mod.rs":"37fe6e548eac4add081e157524d22de97=
6dec369104a14da1e3b20a4396d45ec","src/unix/linux_like/android/b32/arm.rs":"=
75c57d6c70f74f44b00b803975d4e81e444189ea28c4f34dea8c0570fc947076","src/unix=
/linux_like/android/b32/mod.rs":"a94d3e03741ea30082411f0f858dd302b9a8b7b8a8=
f0d8325ecaf2f7ca70312e","src/unix/linux_like/android/b32/x86/mod.rs":"27fb7=
96a7b202997ad83c2c23268cbbea3fa77cb8dfae8712501d4e5c9c9a5cf","src/unix/linu=
x_like/android/b64/aarch64/mod.rs":"03a71c8e142e098486dbe6674158317bc2f90a3=
e27132d3e9549aee8f5e3b1d0","src/unix/linux_like/android/b64/mod.rs":"186edd=
e6293b874c5ae96e10be760f38a967907fa9049bcaf8335aff51b3c6d1","src/unix/linux=
_like/android/b64/riscv64/mod.rs":"504de667a5e03f1a0e1cf4bcfc78bbdc1569037e=
039fafe00edda18cf7388365","src/unix/linux_like/android/b64/x86_64/mod.rs":"=
dd3f5db929900147f0d52bd23d4cd88886cd04148db99f6961d244106e06bcfb","src/unix=
/linux_like/android/mod.rs":"120f0df52ded5fd7d499f2254583e2bedd02adaaf27eb3=
409fe2a505a3a76198","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf1=
6525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/=
emscripten/mod.rs":"358a82517c559c46906b751217eea5f918d793f8bf84c3451d472b2=
ed9a1cf77","src/unix/linux_like/linux/arch/generic/mod.rs":"695b717593cbd25=
4bf8250521a261d87a39824333f35a50b7c75f252eae5a7d6","src/unix/linux_like/lin=
ux/arch/mips/mod.rs":"abcb98291a77d26f0c0792f1ee87763538559f1f9d7fcbf4e8e64=
01b4442515b","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f1=
24ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arc=
h/powerpc/mod.rs":"92c19d5f1ede9389f9044faf8f4f16fc5408b6fb04bbaa67c9bb1f69=
e32123e0","src/unix/linux_like/linux/arch/sparc/mod.rs":"dfd07a3a6d8b175678=
b180ff9903e0d5d529c8112d01bd135f53fce742f433a6","src/unix/linux_like/linux/=
gnu/b32/arm/mod.rs":"7ed85493e121e05d0d52a6751e744451548a390139a5ae947499fb=
fcff1910be","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"5fa98a93b92ae3=
336a0f6a279c0cd6a95c79ccb86443848fc96ddc1026279696","src/unix/linux_like/li=
nux/gnu/b32/m68k/mod.rs":"c5717f5e2266a40144c236e05475ffb2d964c01d956745f29=
678b69170dd1a1f","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"5a19abd74=
01743cad8e6e03ddee15686bbaf7d1bd5b2710e8c2eb97224ed54f0","src/unix/linux_li=
ke/linux/gnu/b32/mod.rs":"a9033d128bc441cd970caa4f912d0f842ac169b573e3dfa55=
39b763609e87d70","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"ee6e9a1184=
8747e0a480407ba7379befef6e2abaffc91ef7906a84e585cd2440","src/unix/linux_lik=
e/linux/gnu/b32/riscv32/mod.rs":"e576a35240eff5e1d6bca073a78f57fe8190a723c4=
7c81bea287ddbd4bba7237","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"5=
e2e2d605ca74af943e539c8c1ba410715461870b314973c444eba0fee3039cd","src/unix/=
linux_like/linux/gnu/b32/x86/mod.rs":"4869c3fa80b115803adc0a5b77754077035fa=
e36edea27c3abe1504e73f0e516","src/unix/linux_like/linux/gnu/b64/aarch64/ilp=
32.rs":"47cc25f28c4bea16c00cd6023c84d09bdc8056217f35744dfdfe27c7f2ea0ca5","=
src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"39593a2f8fd78fccbbd9827=
34c0feb9d15cb3a6a9a6b029bb972ce5b89c78420","src/unix/linux_like/linux/gnu/b=
64/aarch64/mod.rs":"24f9ec2670ec41ae3c108c0c412b39daef9faf315e0d7c3a53f1ef0=
5dcd6e027","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"c0b4c6c2=
52104151390dfc521ffd63e739da709dffbb5cb71a3aba6e270b6fc2","src/unix/linux_l=
ike/linux/gnu/b64/mips64/mod.rs":"dd6aeee535eb66b1286365119b7976dffee6216f6=
653a981963b1cc288fa7516","src/unix/linux_like/linux/gnu/b64/mod.rs":"66b8a9=
81ff02176331f2402806e6ffd7d1a301fe23f285dd4e5dd2d9ed70ea1b","src/unix/linux=
_like/linux/gnu/b64/powerpc64/mod.rs":"450ad230da45da6ab33b4806db8ff24f6b1c=
a9b400fa2c5fb9187189a8545347","src/unix/linux_like/linux/gnu/b64/riscv64/mo=
d.rs":"597c804422b1ea028f998d6c7ed61a9c54ae708b87456544597ab4f7a26a2579","s=
rc/unix/linux_like/linux/gnu/b64/s390x.rs":"bcac1400cad0226c7b8b8300d6cbab3=
00cd98922545c88b1968206442501aaaf","src/unix/linux_like/linux/gnu/b64/sparc=
64/mod.rs":"006ce42969449eb5bb8cdd7c03422be2a436717b152b3982d267ed437be4d5e=
4","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"bf75505d274e3185694c2=
d5a28fecbeff276faad5cb79c7ec2122ce024b8782f","src/unix/linux_like/linux/gnu=
/b64/x86_64/not_x32.rs":"fdb2d3b26336297d34c452633afc705bcaf9c1b4e4fda359f6=
95c4f708d81f17","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"54c1ac9b=
d8d9fe13eeb9b27a92baf715c9d77af1229262fce93362da72f11fe5","src/unix/linux_l=
ike/linux/gnu/mod.rs":"a9356a442dc62dcfb6a6a586afea9fa47fd223f33cbd17f09a1d=
caa243c5cc0a","src/unix/linux_like/linux/mod.rs":"0ad7afb4c32fe6c69882fbde2=
d7782338a30d652657a18c55f83392264bf4ed5","src/unix/linux_like/linux/musl/b3=
2/arm/mod.rs":"64d2f81625dd6691ea81bc64a4a3ed88d41b125a7cd00ed347875b795d6a=
4905","src/unix/linux_like/linux/musl/b32/hexagon.rs":"b0247dd57999a4ddbbd7=
247a471255181e22458825c61b5464fafd36a31a8545","src/unix/linux_like/linux/mu=
sl/b32/mips/mod.rs":"b962ea54c35281131aaa990bf59949d54f24f9583c7191a7efc9c3=
84d6159cfa","src/unix/linux_like/linux/musl/b32/mod.rs":"b9adac558a356cbadd=
b821588645590a7a11d22c1f11f6d2cc636c177f2e28e9","src/unix/linux_like/linux/=
musl/b32/powerpc.rs":"95295bd0e58668a204799a1b5f1a0f636c67be28a959e10ee1ab9=
2631b53c82f","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"738bc36f9=
a0f312cc2336cac38ecd5390a9d91b53da51d26afd2542449b54e7b","src/unix/linux_li=
ke/linux/musl/b32/x86/mod.rs":"0f6e1c0d5e7d650832da95cf7dce85dff82845876e53=
b6587154e546b09d3efc","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"=
8e718cec34d53079e9c841084cb2eca7942a0a66139360a833a0e2ebf0bfe95a","src/unix=
/linux_like/linux/musl/b64/loongarch64/mod.rs":"a825259bb56e78a62f559dccfd1=
c35e686d8d15f781ce78f83c5266cc398fe82","src/unix/linux_like/linux/musl/b64/=
mips64.rs":"be1c8bd1f406d3fb1873075cf613ec17b545200ef514423a12190d6dbc42016=
c","src/unix/linux_like/linux/musl/b64/mod.rs":"db84391acba3ed3c9462ba899f0=
f1a88747bdb5207658343ba699505bc7d4f8c","src/unix/linux_like/linux/musl/b64/=
powerpc64.rs":"eb4d57a7201ffbfc8090bc8f97a62e1642a09d224cd70d4556d3c18cf63a=
c802","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"a14269927d846288=
dadc72a12ff2182274cc0522abe48802b5e9e4563402b73b","src/unix/linux_like/linu=
x/musl/b64/s390x.rs":"67d922c392d53c3928798d9725d3f4336a967d1ef20c5088e498c=
f331af17fd1","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"9e958fbdb3=
cb6c3b48d2413a73961db7259fc34863f4c2f67afa2a17b7b1af05","src/unix/linux_lik=
e/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e789d8d3=
e76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"c7ee52da16396aea3a3=
9573ae9a0ba071500d0e966a53b938793a5ef8b3bb25c","src/unix/linux_like/linux/u=
clibc/arm/mod.rs":"1b0ce2d0d4467cc32a1dd5e5c62f0d57fc1963354ae223bdc636b8d6=
d5d6fea3","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"73d70042db=
5148d5a789880100879541563fa1de8bf5feb792341b4270244968","src/unix/linux_lik=
e/linux/uclibc/mips/mips64/mod.rs":"0a6c13d1873d3f165171a69433bb9b2df1c9151=
cc1085735613791e603865a06","src/unix/linux_like/linux/uclibc/mips/mod.rs":"=
ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","src/unix=
/linux_like/linux/uclibc/mod.rs":"1cc653e9ad8524408c9023cbd7245b53b81c105ee=
3b341cb3e98c435196d191e","src/unix/linux_like/linux/uclibc/x86_64/l4re.rs":=
"076ad477f0786a2e4944cc0550a4492b21d4b65d094006947ec40e0c7ee5365d","src/uni=
x/linux_like/linux/uclibc/x86_64/mod.rs":"889f06553111d8bdcf6a0aff344d1c232=
0ec6c067a612b46441f9e817853b5c0","src/unix/linux_like/linux/uclibc/x86_64/o=
ther.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4093def"=
,"src/unix/linux_like/mod.rs":"979205c66cd960da2506e3115a4950a8fe24ce963fdb=
a3d5d05b9e19d8f077ea","src/unix/mod.rs":"eb23bc25b5e03276cf7c174386f5cbeeff=
f1fd13a43a311d45a375a1fbf3a296","src/unix/newlib/aarch64/mod.rs":"e08ba9d6a=
c7f8b381f8699b3604cf460a5fcd5b8e68e139bba4f29bfba4781a4","src/unix/newlib/a=
rm/mod.rs":"ddea29e7ce40756f2af4c9792d5cefdd0c634401aaeb146dc686f1f125e3bac=
8","src/unix/newlib/espidf/mod.rs":"d8f90d04b485eb31092ecaeb7fca3a27e8456c7=
bb8116074febb9e00ac5c96a8","src/unix/newlib/generic.rs":"182e584f14e0984934=
130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/horizon/mo=
d.rs":"a484d84f56fd5b49fed83d6d8a5e8ec5647f0bfa3d30b496a7fa6fe5e546a980","s=
rc/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7f55a797=
ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs":"1a161a27493adb2c3b47d60eeb=
c8ac57b2f0ef0111abdcd5b4d55d11c36d37e5","src/unix/newlib/rtems/mod.rs":"239=
c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/unix/ne=
wlib/vita/mod.rs":"fcf4400037d9a59d1c2d2cbab874f12c3b09fa968ffcaeb53315f673=
02c8f29d","src/unix/nto/aarch64.rs":"91d0448f932d0cf6af4f11e4f8c9d68a78100e=
d561e560665983359b7b943075","src/unix/nto/mod.rs":"01938d623e161fb8e20e28d8=
6977403023bb1645c83cec2ffef3632d7ec29750","src/unix/nto/neutrino.rs":"039ab=
7b1ed702d515f3e06d7f3536709704715a49905024b6c520696a65086f9","src/unix/nto/=
x86_64.rs":"c8efb0f67811e440d798786911f51160c9d3d1c20fb3ca633b5e80ec05dff3c=
a","src/unix/nuttx/mod.rs":"f1f5529c96b2a3e6f1600a5bdcfea4dfb859b5e116de436=
ea24f9965df5c64f5","src/unix/redox/mod.rs":"5c0ba01e67bcdf076057dea7f893e14=
f8ee84b8b2b1a372d39f4d000ff4fc93c","src/unix/solarish/compat.rs":"c02a88918=
852b7a9c60e45a34f7b003901000380f5c1b2832b8bd79f84936c8b","src/unix/solarish=
/illumos.rs":"cc7104f002a5379f981c59a779ef4afad00c874e0be21dda339901cd5eea4=
af1","src/unix/solarish/mod.rs":"2b6c62850c168e7200955ba1f52464fa03c329df7a=
4e77a30054544280308dc1","src/unix/solarish/solaris.rs":"51b6bf12427319c9af9=
db4e1b2a984a4d75f994adcd4139f2fc878c9b92f6e1d","src/unix/solarish/x86.rs":"=
44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","src/unix=
/solarish/x86_64.rs":"768bfd0e1f4b2ac3fbbf1e2d8239ef58f21726540b9de5c72a9b1=
cd534ab0ea1","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e8cd328f=
13187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"98f0afdc51=
1cd02557e506c21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/arm.rs=
":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e88","src/v=
xworks/mod.rs":"6d111d4dc3b6201fd2c45b247d0592e9403ee4b65a481afda727f742222=
3f9a9","src/vxworks/powerpc.rs":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b=
8ef7084777cb181d788e88","src/vxworks/powerpc64.rs":"98f0afdc511cd02557e506c=
21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/riscv32.rs":"552f00=
7f38317620b23889cb7c49d1d115841252439060122f52f434fbc6e5ba","src/vxworks/ri=
scv64.rs":"018d92be3ad628a129eff9f2f5dfbc0883d8b8e5f2fa917b900a7f98ed6b514a=
","src/vxworks/x86.rs":"552f007f38317620b23889cb7c49d1d115841252439060122f5=
2f434fbc6e5ba","src/vxworks/x86_64.rs":"018d92be3ad628a129eff9f2f5dfbc0883d=
8b8e5f2fa917b900a7f98ed6b514a","src/wasi/mod.rs":"f7b39137ce2c005367016a00e=
00f0affdce627d9165681c9dc9280534720640b","src/wasi/p2.rs":"feecc0485eabd2c3=
2bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/mod.rs":=
"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","src/win=
dows/mod.rs":"282daeacf420e36c5ba2f8129d045104e1172b29a9035e73c10739836a8af=
440","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9f47b5c4=
113a1a87fae8e64549c00","src/xous.rs":"17b571c988119fe3f71dbcccfe722de5c772a=
bc3ca20dc4b09b58780980b78e9","tests/const_fn.rs":"8ac3171d7bced3576a4e93f48=
570b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"09d6582e104315a817dff9=
7f75133544b2e094ee22447d2acf4a74e189ba06fc"}
+\ No newline at end of file
++{"files":{"CHANGELOG.md":"ab0bd175d8a317894835d3bea1e1d78780adb818705bd77=
e230d6972c2ed3633","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.toml":"0912337103f997c684c700d066b62181=
c7f7b9a23e4e12faaf5c1a2b54a78757","LICENSE-APACHE":"62c7a1e35f56406896d7aa7=
ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56=
a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"38061c8bb600c=
2e01b48b662288cb11f38c0ec27bbe6d496e7f0acb1016991c4","build.rs":"bcbe11dc71=
1029460fcc4f7fd8e38c487006ad0860007915ae6718bd90fb891a","rustfmt.toml":"e93=
21ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fixed_w=
idth_ints.rs":"10eb30cf48390768f0167e1fa46ae99461968a05e93bd96aff721f54550a=
e66c","src/fuchsia/aarch64.rs":"d430586295c7eb022eb8202f7b18e483a9dd0e7de18=
57f7963453792c7161def","src/fuchsia/mod.rs":"f452b1cc842cc92c6c7676376adba8=
3c1f5ccc2460e80626099ec520ba23a48b","src/fuchsia/riscv64.rs":"7efd6cbcbd2cb=
25d6380f6df69ad91cf62efd55fb9cb7cb85884c490b601743e","src/fuchsia/x86_64.rs=
":"e63daa4085c6f6ab35d9711df6d7e027247a8b3b2a6dc47fcb2b21e1f4820a2f","src/h=
ermit.rs":"35c1e248f2b3608017f696a79d4a114c889176c9d281a1544916360c62be2301=
","src/lib.rs":"a8cd1626f2dd03c25242ce82856d04625ef0c3910de6ea2df729408831e=
eda38","src/macros.rs":"cb65803b265ba63ffe37375ae08703ab0b8b90972ed22da3cf7=
812eef421a6cd","src/psp.rs":"dcf53184a1ab06d18aa34431ca42644c5646fe78d05a53=
678ef9529607ba3ea7","src/sgx.rs":"f0f1a9fa864cd3dc94c4b3ce73f88e67f11453f63=
d8b4d52823de2ccbba7eb49","src/solid/aarch64.rs":"a726e47f324adf73a4a0b67a2c=
183408d0cad105ae66acf36db37a42ab7f8707","src/solid/arm.rs":"e39a4f74ebbef3b=
97b8c95758ad741123d84ed3eb48d9cf4f1f4872097fc27fe","src/solid/mod.rs":"0111=
6b18b9be6791fdf4ff572d12154b64dfa43a18afc33940ea676e1884bdbb","src/switch.r=
s":"bb0ce1331c61a28caea7bd201e399d1e1127f303dcc7747b4f07f63d188ea49c","src/=
teeos/mod.rs":"7e0a8b550f1109c8247136cabb69308bd0ed2838f00ce0c99a695a3ef9af=
ca22","src/trusty.rs":"2e829bfdaefbba31b907ee5ef577ebc9e8f2e2fee2cde2a4e608=
d5219a435390","src/unix/aix/mod.rs":"4fc9eb4d97b2496aff094754cf6417713b49ca=
8fea63f29c2bdadd5336cd842b","src/unix/aix/powerpc64.rs":"666146ac9e4cb01c49=
ba046ef470d93499d91c0948d86fdce65fcd6cff6ece14","src/unix/bsd/apple/b32/mod=
.rs":"9f20c77e86b812ff09d8193a48fe4f3afd6dae8a43d5a0d78b8592971cc3726e","sr=
c/unix/bsd/apple/b64/aarch64/mod.rs":"1ebe9f1a1e07318813da7e2a78195937533c2=
2b51a23a4527b9404c948318f86","src/unix/bsd/apple/b64/mod.rs":"164e734befe87=
fa6e2d79fb856ce314282bd219ea4f2f357c6446dca6d2de359","src/unix/bsd/apple/b6=
4/x86_64/mod.rs":"e03794fdeaaf4a86c7b12f41e490a7538c12d4a77743a5448237f73d5=
a8593f4","src/unix/bsd/apple/mod.rs":"c9f17938a9733a426e02f4c0951eec9987d23=
1f9dac925d342fca049e548b17c","src/unix/bsd/freebsdlike/dragonfly/errno.rs":=
"07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/uni=
x/bsd/freebsdlike/dragonfly/mod.rs":"f130937ac556080c77d7d1f011f2d2c964b65e=
b633bf6b7f1251a045670b9ec8","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"=
aea276451dca89f086d014b66e2e83e1eb948ab8dfbf920170c1b8338c9777c3","src/unix=
/bsd/freebsdlike/freebsd/arm.rs":"f70c76405a72754db37dff7de3fd586a19e1512b4=
7f452493b430f295d7264af","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs=
":"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/u=
nix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14a=
fae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd11/mod.rs":"400f18465ef118e202ac9b1b9db47b1333fc17eb5841709082f2d1d5a51=
79391","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"fb999d55cf4f340=
3ac934dff1fc70c666087de234d7a91321bcfb5009bbafc6f","src/unix/bsd/freebsdlik=
e/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfa=
a14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":=
"e6f3430838d94dd17e359419f5de7d28a6b3adb8fcab7727d24e034bc6ed5d1e","src/uni=
x/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fc=
e28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fr=
eebsd14/mod.rs":"7d23d7d6b779265bca9c53c8b3e50b4dadb33f3911000ce88c8e09c9f0=
b60eab","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e10=
9dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebs=
dlike/freebsd/freebsd15/mod.rs":"45921502545212949a756d0edad2d861a5c6bc1925=
a4c13c8afc057ce6b4d8fe","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.=
rs":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src=
/unix/bsd/freebsdlike/freebsd/mod.rs":"10c26d1f6c09f797578980e0310978023ff1=
4e4c05977a5748d9c7d65006cc12","src/unix/bsd/freebsdlike/freebsd/powerpc.rs"=
:"36912b999e0571adccc06d9ebbd237e537a95c36ddb97d67a81e940ab28b36e7","src/un=
ix/bsd/freebsdlike/freebsd/powerpc64.rs":"c1c13a3e7633ab6e84929ac3bfac96a67=
779e6cdac157d64b5b9f7c2b32b1691","src/unix/bsd/freebsdlike/freebsd/riscv64.=
rs":"b6bbfb556ed35c3897a98efffbafd5a07854dce1786643ffc1aaaa5a4e7dbe1e","src=
/unix/bsd/freebsdlike/freebsd/x86.rs":"8102bc641970bec32d4f2b93c8ba0e9c0432=
f84cef1442e3bf5438c3ba9c6c4d","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.=
rs":"fab655006e7b0eded6e5a6db0b0cb1efd3dee9205b9a02f315c06093100883a1","src=
/unix/bsd/freebsdlike/mod.rs":"31adfff1db7bed60fa8044b37ef40fbabb929b055670=
cefe3bac88782de879f8","src/unix/bsd/mod.rs":"a776f9bf11ab5245bcddc37bde002f=
28f84ff8f0d919d2dbc37055b3a679d86b","src/unix/bsd/netbsdlike/mod.rs":"d089e=
ef37c5888f59479c4961415b247470a662cd14a1ec65d1f3ebcd304cf31","src/unix/bsd/=
netbsdlike/netbsd/aarch64.rs":"1b526d8c7053d129548202faf3505033152d9c0a6682=
cefe2e8ae23a2a40b289","src/unix/bsd/netbsdlike/netbsd/arm.rs":"47abd680ddb4=
879648cac3d462e0daa7e980b5e6be7ba346f5f494ccdebee6e8","src/unix/bsd/netbsdl=
ike/netbsd/mips.rs":"8420d476126ca2740ff2cbd1e85d0a31334e2c68dd0a70d3ac3e3d=
802b5b5782","src/unix/bsd/netbsdlike/netbsd/mod.rs":"742d6c0607ee20c81a2184=
a6378dc2d9c18f7180a0dc93aa91f830a0d1a06878","src/unix/bsd/netbsdlike/netbsd=
/powerpc.rs":"42f66be7650e95398a3687886db5053e55c77dc04eb139315bebf9668b2be=
d68","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"81664f910e884d70f0a758c42=
a17cc242db4811ce9dda1257fbd66b291cf0d52","src/unix/bsd/netbsdlike/netbsd/sp=
arc64.rs":"78985b140b0337f6bb951f9db68e0db0b5a0a8131ac5c4426a342ed002e27a82=
","src/unix/bsd/netbsdlike/netbsd/x86.rs":"dda4e401f03084a87762fb68c4839987=
56a07b7c5d4b86348fc3f79380024fb7","src/unix/bsd/netbsdlike/netbsd/x86_64.rs=
":"b60e896c10ba86a59b13a189fe2e6b94265244fa4b2bc3f89a46065e7d469dea","src/u=
nix/bsd/netbsdlike/openbsd/aarch64.rs":"91b6ac97e6411261cf5206ab1951a4e4e1f=
1cc9ca26217d7144f000f8f7c8580","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f8=
c975d4b94a8b8d11dcc5224db628997003a8d289f12fb12b398e9445c2f122","src/unix/b=
sd/netbsdlike/openbsd/mips64.rs":"8532a189ae10c7d668d9d4065da8b05d124e09bd3=
9442c9f74a7f231c43eca48","src/unix/bsd/netbsdlike/openbsd/mod.rs":"2e6e0e94=
ae9dd802692bc7258deaf14a4f1b6544bc2dfa853ae753e7e4f27afb","src/unix/bsd/net=
bsdlike/openbsd/powerpc.rs":"f8c975d4b94a8b8d11dcc5224db628997003a8d289f12f=
b12b398e9445c2f122","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"d53f6cc=
d830b8bbe94c9be8a92a719105ed29846d6a11ce6c972fa7ff142a001","src/unix/bsd/ne=
tbsdlike/openbsd/riscv64.rs":"21a90502854e1aab413700edc41bd7922bc6e0fc3d724=
0aa57f258bb4546fa9c","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"d04fd287=
afbaa2c5df9d48c94e8374a532a3ba491b424ddf018270c7312f4085","src/unix/bsd/net=
bsdlike/openbsd/x86.rs":"ebe65020c0d457af0458f549b8c44099a8c274d734bfa6c336=
2f0b6423fa3c7a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"2aec823a0800d2=
8fe546d35e98ae1dc671aa253663f9923d147548233def260a","src/unix/haiku/b32.rs"=
:"c56aa69ed87dded0d297d44a9177577b1d2d4a79ed176e6768c7fc4dab90bfb4","src/un=
ix/haiku/b64.rs":"d44daef26b89e75d58ac0204a169a66ba5fbc13fc40948f67f19700e6=
033a07e","src/unix/haiku/mod.rs":"2589765aa89ad146cf0cb942fe371340293f97a5a=
aecd2dfc0ac0f563eac86f3","src/unix/haiku/native.rs":"8dbd270e9e1d6409952709=
a5a37383bda2660008b745aa01adc02172a20bf939","src/unix/haiku/x86_64.rs":"8d8=
ef6b462bc32b3270440526f35c8dec572b502355c27ad451e64a816c4a176","src/unix/hu=
rd/b32.rs":"3e79bb09b66d8a1d3b7589a4b2b2076e57bd7b51b747f5219f24d3bd2019ad6=
a","src/unix/hurd/b64.rs":"f61f0263a71f39a5130ac749bb0f146e5b95e7b054f49291=
97366f28e8c22815","src/unix/hurd/mod.rs":"37fe6e548eac4add081e157524d22de97=
6dec369104a14da1e3b20a4396d45ec","src/unix/linux_like/android/b32/arm.rs":"=
75c57d6c70f74f44b00b803975d4e81e444189ea28c4f34dea8c0570fc947076","src/unix=
/linux_like/android/b32/mod.rs":"a94d3e03741ea30082411f0f858dd302b9a8b7b8a8=
f0d8325ecaf2f7ca70312e","src/unix/linux_like/android/b32/x86/mod.rs":"27fb7=
96a7b202997ad83c2c23268cbbea3fa77cb8dfae8712501d4e5c9c9a5cf","src/unix/linu=
x_like/android/b64/aarch64/mod.rs":"03a71c8e142e098486dbe6674158317bc2f90a3=
e27132d3e9549aee8f5e3b1d0","src/unix/linux_like/android/b64/mod.rs":"186edd=
e6293b874c5ae96e10be760f38a967907fa9049bcaf8335aff51b3c6d1","src/unix/linux=
_like/android/b64/riscv64/mod.rs":"504de667a5e03f1a0e1cf4bcfc78bbdc1569037e=
039fafe00edda18cf7388365","src/unix/linux_like/android/b64/x86_64/mod.rs":"=
dd3f5db929900147f0d52bd23d4cd88886cd04148db99f6961d244106e06bcfb","src/unix=
/linux_like/android/mod.rs":"120f0df52ded5fd7d499f2254583e2bedd02adaaf27eb3=
409fe2a505a3a76198","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf1=
6525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/=
emscripten/mod.rs":"358a82517c559c46906b751217eea5f918d793f8bf84c3451d472b2=
ed9a1cf77","src/unix/linux_like/linux/arch/generic/mod.rs":"74e073817b49261=
c7b9b194c6a7b2cb94adb7a66ee0449bfa4af169d2acbae47","src/unix/linux_like/lin=
ux/arch/mips/mod.rs":"abcb98291a77d26f0c0792f1ee87763538559f1f9d7fcbf4e8e64=
01b4442515b","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f1=
24ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arc=
h/powerpc/mod.rs":"92c19d5f1ede9389f9044faf8f4f16fc5408b6fb04bbaa67c9bb1f69=
e32123e0","src/unix/linux_like/linux/arch/sparc/mod.rs":"dfd07a3a6d8b175678=
b180ff9903e0d5d529c8112d01bd135f53fce742f433a6","src/unix/linux_like/linux/=
gnu/b32/arm/mod.rs":"7ed85493e121e05d0d52a6751e744451548a390139a5ae947499fb=
fcff1910be","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"5fa98a93b92ae3=
336a0f6a279c0cd6a95c79ccb86443848fc96ddc1026279696","src/unix/linux_like/li=
nux/gnu/b32/m68k/mod.rs":"c5717f5e2266a40144c236e05475ffb2d964c01d956745f29=
678b69170dd1a1f","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"5a19abd74=
01743cad8e6e03ddee15686bbaf7d1bd5b2710e8c2eb97224ed54f0","src/unix/linux_li=
ke/linux/gnu/b32/mod.rs":"a9033d128bc441cd970caa4f912d0f842ac169b573e3dfa55=
39b763609e87d70","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"ee6e9a1184=
8747e0a480407ba7379befef6e2abaffc91ef7906a84e585cd2440","src/unix/linux_lik=
e/linux/gnu/b32/riscv32/mod.rs":"e576a35240eff5e1d6bca073a78f57fe8190a723c4=
7c81bea287ddbd4bba7237","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"5=
e2e2d605ca74af943e539c8c1ba410715461870b314973c444eba0fee3039cd","src/unix/=
linux_like/linux/gnu/b32/x86/mod.rs":"4869c3fa80b115803adc0a5b77754077035fa=
e36edea27c3abe1504e73f0e516","src/unix/linux_like/linux/gnu/b64/aarch64/ilp=
32.rs":"47cc25f28c4bea16c00cd6023c84d09bdc8056217f35744dfdfe27c7f2ea0ca5","=
src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"39593a2f8fd78fccbbd9827=
34c0feb9d15cb3a6a9a6b029bb972ce5b89c78420","src/unix/linux_like/linux/gnu/b=
64/aarch64/mod.rs":"24f9ec2670ec41ae3c108c0c412b39daef9faf315e0d7c3a53f1ef0=
5dcd6e027","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"c0b4c6c2=
52104151390dfc521ffd63e739da709dffbb5cb71a3aba6e270b6fc2","src/unix/linux_l=
ike/linux/gnu/b64/mips64/mod.rs":"dd6aeee535eb66b1286365119b7976dffee6216f6=
653a981963b1cc288fa7516","src/unix/linux_like/linux/gnu/b64/mod.rs":"66b8a9=
81ff02176331f2402806e6ffd7d1a301fe23f285dd4e5dd2d9ed70ea1b","src/unix/linux=
_like/linux/gnu/b64/powerpc64/mod.rs":"450ad230da45da6ab33b4806db8ff24f6b1c=
a9b400fa2c5fb9187189a8545347","src/unix/linux_like/linux/gnu/b64/riscv64/mo=
d.rs":"597c804422b1ea028f998d6c7ed61a9c54ae708b87456544597ab4f7a26a2579","s=
rc/unix/linux_like/linux/gnu/b64/s390x.rs":"bcac1400cad0226c7b8b8300d6cbab3=
00cd98922545c88b1968206442501aaaf","src/unix/linux_like/linux/gnu/b64/sparc=
64/mod.rs":"006ce42969449eb5bb8cdd7c03422be2a436717b152b3982d267ed437be4d5e=
4","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"bf75505d274e3185694c2=
d5a28fecbeff276faad5cb79c7ec2122ce024b8782f","src/unix/linux_like/linux/gnu=
/b64/x86_64/not_x32.rs":"fdb2d3b26336297d34c452633afc705bcaf9c1b4e4fda359f6=
95c4f708d81f17","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"54c1ac9b=
d8d9fe13eeb9b27a92baf715c9d77af1229262fce93362da72f11fe5","src/unix/linux_l=
ike/linux/gnu/mod.rs":"a9356a442dc62dcfb6a6a586afea9fa47fd223f33cbd17f09a1d=
caa243c5cc0a","src/unix/linux_like/linux/mod.rs":"0ad7afb4c32fe6c69882fbde2=
d7782338a30d652657a18c55f83392264bf4ed5","src/unix/linux_like/linux/musl/b3=
2/arm/mod.rs":"64d2f81625dd6691ea81bc64a4a3ed88d41b125a7cd00ed347875b795d6a=
4905","src/unix/linux_like/linux/musl/b32/hexagon.rs":"b0247dd57999a4ddbbd7=
247a471255181e22458825c61b5464fafd36a31a8545","src/unix/linux_like/linux/mu=
sl/b32/mips/mod.rs":"b962ea54c35281131aaa990bf59949d54f24f9583c7191a7efc9c3=
84d6159cfa","src/unix/linux_like/linux/musl/b32/mod.rs":"b9adac558a356cbadd=
b821588645590a7a11d22c1f11f6d2cc636c177f2e28e9","src/unix/linux_like/linux/=
musl/b32/powerpc.rs":"95295bd0e58668a204799a1b5f1a0f636c67be28a959e10ee1ab9=
2631b53c82f","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"738bc36f9=
a0f312cc2336cac38ecd5390a9d91b53da51d26afd2542449b54e7b","src/unix/linux_li=
ke/linux/musl/b32/x86/mod.rs":"0f6e1c0d5e7d650832da95cf7dce85dff82845876e53=
b6587154e546b09d3efc","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"=
8e718cec34d53079e9c841084cb2eca7942a0a66139360a833a0e2ebf0bfe95a","src/unix=
/linux_like/linux/musl/b64/loongarch64/mod.rs":"a825259bb56e78a62f559dccfd1=
c35e686d8d15f781ce78f83c5266cc398fe82","src/unix/linux_like/linux/musl/b64/=
mips64.rs":"be1c8bd1f406d3fb1873075cf613ec17b545200ef514423a12190d6dbc42016=
c","src/unix/linux_like/linux/musl/b64/mod.rs":"db84391acba3ed3c9462ba899f0=
f1a88747bdb5207658343ba699505bc7d4f8c","src/unix/linux_like/linux/musl/b64/=
powerpc64.rs":"eb4d57a7201ffbfc8090bc8f97a62e1642a09d224cd70d4556d3c18cf63a=
c802","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"a14269927d846288=
dadc72a12ff2182274cc0522abe48802b5e9e4563402b73b","src/unix/linux_like/linu=
x/musl/b64/s390x.rs":"67d922c392d53c3928798d9725d3f4336a967d1ef20c5088e498c=
f331af17fd1","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"9e958fbdb3=
cb6c3b48d2413a73961db7259fc34863f4c2f67afa2a17b7b1af05","src/unix/linux_lik=
e/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e789d8d3=
e76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"c7ee52da16396aea3a3=
9573ae9a0ba071500d0e966a53b938793a5ef8b3bb25c","src/unix/linux_like/linux/u=
clibc/arm/mod.rs":"1b0ce2d0d4467cc32a1dd5e5c62f0d57fc1963354ae223bdc636b8d6=
d5d6fea3","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"73d70042db=
5148d5a789880100879541563fa1de8bf5feb792341b4270244968","src/unix/linux_lik=
e/linux/uclibc/mips/mips64/mod.rs":"0a6c13d1873d3f165171a69433bb9b2df1c9151=
cc1085735613791e603865a06","src/unix/linux_like/linux/uclibc/mips/mod.rs":"=
ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","src/unix=
/linux_like/linux/uclibc/mod.rs":"1cc653e9ad8524408c9023cbd7245b53b81c105ee=
3b341cb3e98c435196d191e","src/unix/linux_like/linux/uclibc/x86_64/l4re.rs":=
"076ad477f0786a2e4944cc0550a4492b21d4b65d094006947ec40e0c7ee5365d","src/uni=
x/linux_like/linux/uclibc/x86_64/mod.rs":"889f06553111d8bdcf6a0aff344d1c232=
0ec6c067a612b46441f9e817853b5c0","src/unix/linux_like/linux/uclibc/x86_64/o=
ther.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4093def"=
,"src/unix/linux_like/mod.rs":"979205c66cd960da2506e3115a4950a8fe24ce963fdb=
a3d5d05b9e19d8f077ea","src/unix/mod.rs":"eb23bc25b5e03276cf7c174386f5cbeeff=
f1fd13a43a311d45a375a1fbf3a296","src/unix/newlib/aarch64/mod.rs":"e08ba9d6a=
c7f8b381f8699b3604cf460a5fcd5b8e68e139bba4f29bfba4781a4","src/unix/newlib/a=
rm/mod.rs":"ddea29e7ce40756f2af4c9792d5cefdd0c634401aaeb146dc686f1f125e3bac=
8","src/unix/newlib/espidf/mod.rs":"d8f90d04b485eb31092ecaeb7fca3a27e8456c7=
bb8116074febb9e00ac5c96a8","src/unix/newlib/generic.rs":"182e584f14e0984934=
130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/horizon/mo=
d.rs":"a484d84f56fd5b49fed83d6d8a5e8ec5647f0bfa3d30b496a7fa6fe5e546a980","s=
rc/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7f55a797=
ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs":"1a161a27493adb2c3b47d60eeb=
c8ac57b2f0ef0111abdcd5b4d55d11c36d37e5","src/unix/newlib/rtems/mod.rs":"239=
c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/unix/ne=
wlib/vita/mod.rs":"fcf4400037d9a59d1c2d2cbab874f12c3b09fa968ffcaeb53315f673=
02c8f29d","src/unix/nto/aarch64.rs":"91d0448f932d0cf6af4f11e4f8c9d68a78100e=
d561e560665983359b7b943075","src/unix/nto/mod.rs":"01938d623e161fb8e20e28d8=
6977403023bb1645c83cec2ffef3632d7ec29750","src/unix/nto/neutrino.rs":"039ab=
7b1ed702d515f3e06d7f3536709704715a49905024b6c520696a65086f9","src/unix/nto/=
x86_64.rs":"c8efb0f67811e440d798786911f51160c9d3d1c20fb3ca633b5e80ec05dff3c=
a","src/unix/nuttx/mod.rs":"f1f5529c96b2a3e6f1600a5bdcfea4dfb859b5e116de436=
ea24f9965df5c64f5","src/unix/redox/mod.rs":"5c0ba01e67bcdf076057dea7f893e14=
f8ee84b8b2b1a372d39f4d000ff4fc93c","src/unix/solarish/compat.rs":"c02a88918=
852b7a9c60e45a34f7b003901000380f5c1b2832b8bd79f84936c8b","src/unix/solarish=
/illumos.rs":"cc7104f002a5379f981c59a779ef4afad00c874e0be21dda339901cd5eea4=
af1","src/unix/solarish/mod.rs":"2b6c62850c168e7200955ba1f52464fa03c329df7a=
4e77a30054544280308dc1","src/unix/solarish/solaris.rs":"51b6bf12427319c9af9=
db4e1b2a984a4d75f994adcd4139f2fc878c9b92f6e1d","src/unix/solarish/x86.rs":"=
44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","src/unix=
/solarish/x86_64.rs":"768bfd0e1f4b2ac3fbbf1e2d8239ef58f21726540b9de5c72a9b1=
cd534ab0ea1","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e8cd328f=
13187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"98f0afdc51=
1cd02557e506c21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/arm.rs=
":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e88","src/v=
xworks/mod.rs":"6d111d4dc3b6201fd2c45b247d0592e9403ee4b65a481afda727f742222=
3f9a9","src/vxworks/powerpc.rs":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b=
8ef7084777cb181d788e88","src/vxworks/powerpc64.rs":"98f0afdc511cd02557e506c=
21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/riscv32.rs":"552f00=
7f38317620b23889cb7c49d1d115841252439060122f52f434fbc6e5ba","src/vxworks/ri=
scv64.rs":"018d92be3ad628a129eff9f2f5dfbc0883d8b8e5f2fa917b900a7f98ed6b514a=
","src/vxworks/x86.rs":"552f007f38317620b23889cb7c49d1d115841252439060122f5=
2f434fbc6e5ba","src/vxworks/x86_64.rs":"018d92be3ad628a129eff9f2f5dfbc0883d=
8b8e5f2fa917b900a7f98ed6b514a","src/wasi/mod.rs":"f7b39137ce2c005367016a00e=
00f0affdce627d9165681c9dc9280534720640b","src/wasi/p2.rs":"feecc0485eabd2c3=
2bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/mod.rs":=
"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","src/win=
dows/mod.rs":"282daeacf420e36c5ba2f8129d045104e1172b29a9035e73c10739836a8af=
440","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9f47b5c4=
113a1a87fae8e64549c00","src/xous.rs":"17b571c988119fe3f71dbcccfe722de5c772a=
bc3ca20dc4b09b58780980b78e9","tests/const_fn.rs":"8ac3171d7bced3576a4e93f48=
570b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"09d6582e104315a817dff9=
7f75133544b2e094ee22447d2acf4a74e189ba06fc"}
+diff --git a/vendor/libc-0.2.167/src/unix/linux_like/linux/arch/generic/mo=
d.rs b/vendor/libc-0.2.167/src/unix/linux_like/linux/arch/generic/mod.rs
+index 10953fe78..e9fd7fcce 100644
+--- a/vendor/libc-0.2.167/src/unix/linux_like/linux/arch/generic/mod.rs
++++ b/vendor/libc-0.2.167/src/unix/linux_like/linux/arch/generic/mod.rs
+@@ -122,6 +122,7 @@ cfg_if! {
+         target_arch =3D "x86_64",
+         target_arch =3D "arm",
+         target_arch =3D "aarch64",
++        target_arch =3D "riscv32",
+         target_arch =3D "riscv64",
+         target_arch =3D "s390x",
+         target_arch =3D "csky",
+@@ -258,7 +259,8 @@ cfg_if! {
+     if #[cfg(any(
+         target_arch =3D "x86",
+         target_arch =3D "arm",
+-        target_arch =3D "csky"
++        target_arch =3D "csky",
++        target_arch =3D "riscv32"
+     ))] {
+         pub const FS_IOC_GETFLAGS: Ioctl =3D 0x80046601;
+         pub const FS_IOC_SETFLAGS: Ioctl =3D 0x40046602;
+diff --git a/vendor/libc-0.2.169/.cargo-checksum.json b/vendor/libc-0.2.16=
9/.cargo-checksum.json
+index 073f360a5..1e9c85b18 100644
+--- a/vendor/libc-0.2.169/.cargo-checksum.json
++++ b/vendor/libc-0.2.169/.cargo-checksum.json
+@@ -1 +1 @@
+-{"files":{"CHANGELOG.md":"e48a795c934b4fbb91a59757a32b13c82c2dc9b71d6fc49=
da9bef3b8d85f5454","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.toml":"647ea80df57c844de63e49629b9e13d0=
2e8dfdcb0e1ec3b301002e3ca5e6d461","LICENSE-APACHE":"62c7a1e35f56406896d7aa7=
ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56=
a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"38061c8bb600c=
2e01b48b662288cb11f38c0ec27bbe6d496e7f0acb1016991c4","build.rs":"bcbe11dc71=
1029460fcc4f7fd8e38c487006ad0860007915ae6718bd90fb891a","rustfmt.toml":"e93=
21ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fixed_w=
idth_ints.rs":"10eb30cf48390768f0167e1fa46ae99461968a05e93bd96aff721f54550a=
e66c","src/fuchsia/aarch64.rs":"d430586295c7eb022eb8202f7b18e483a9dd0e7de18=
57f7963453792c7161def","src/fuchsia/mod.rs":"2556b215558fc76d8337a8dac4d3ec=
8124aa442cc4676bcb2a85e248b23fb62b","src/fuchsia/riscv64.rs":"7efd6cbcbd2cb=
25d6380f6df69ad91cf62efd55fb9cb7cb85884c490b601743e","src/fuchsia/x86_64.rs=
":"e63daa4085c6f6ab35d9711df6d7e027247a8b3b2a6dc47fcb2b21e1f4820a2f","src/h=
ermit.rs":"6d1d40c1473a73aae2d3a470fa623ea92a196a65468acd9373b20dc6dcbd5d31=
","src/lib.rs":"1171567598056a99dbce2ef1e5b61a6410d6ba1333cca113d50f7529668=
8a565","src/macros.rs":"ce06d8677464669530a141269dea2cf4debb24ab3f53eb136f9=
33bcf553a4fe3","src/psp.rs":"dcf53184a1ab06d18aa34431ca42644c5646fe78d05a53=
678ef9529607ba3ea7","src/sgx.rs":"f0f1a9fa864cd3dc94c4b3ce73f88e67f11453f63=
d8b4d52823de2ccbba7eb49","src/solid/aarch64.rs":"98f0afdc511cd02557e506c21f=
ed6737585490a1dce7a9d4941d08c437762b99","src/solid/arm.rs":"acb7968ce99fe3f=
4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e88","src/solid/mod.rs":"0111=
6b18b9be6791fdf4ff572d12154b64dfa43a18afc33940ea676e1884bdbb","src/switch.r=
s":"bb0ce1331c61a28caea7bd201e399d1e1127f303dcc7747b4f07f63d188ea49c","src/=
teeos/mod.rs":"174e10b1e3cd37122b557a9e9f75205f1858a31cb62cbb83582da2661228=
babe","src/trusty.rs":"f4c8e60896f93759eea4fa5a146dd98dd21d818a4e54df391b14=
513a402212c2","src/unix/aix/mod.rs":"31dd168d5d06cc60bf1b1b6bb0665640fb082f=
f7b1f2e13c22a888fa8bdb1945","src/unix/aix/powerpc64.rs":"caf11cb47a1ac1c031=
6f72050f6fd82dbcbbc6258a9b51ff5a9842f2825e63d7","src/unix/bsd/apple/b32/mod=
.rs":"9f20c77e86b812ff09d8193a48fe4f3afd6dae8a43d5a0d78b8592971cc3726e","sr=
c/unix/bsd/apple/b64/aarch64/mod.rs":"1ebe9f1a1e07318813da7e2a78195937533c2=
2b51a23a4527b9404c948318f86","src/unix/bsd/apple/b64/mod.rs":"164e734befe87=
fa6e2d79fb856ce314282bd219ea4f2f357c6446dca6d2de359","src/unix/bsd/apple/b6=
4/x86_64/mod.rs":"e03794fdeaaf4a86c7b12f41e490a7538c12d4a77743a5448237f73d5=
a8593f4","src/unix/bsd/apple/mod.rs":"1ad08f5ca6becd37bab20bae5f3153a8fc882=
4e9123ec77237d37b64f133741a","src/unix/bsd/freebsdlike/dragonfly/errno.rs":=
"07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/uni=
x/bsd/freebsdlike/dragonfly/mod.rs":"f130937ac556080c77d7d1f011f2d2c964b65e=
b633bf6b7f1251a045670b9ec8","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"=
aea276451dca89f086d014b66e2e83e1eb948ab8dfbf920170c1b8338c9777c3","src/unix=
/bsd/freebsdlike/freebsd/arm.rs":"f70c76405a72754db37dff7de3fd586a19e1512b4=
7f452493b430f295d7264af","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs=
":"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/u=
nix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14a=
fae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd11/mod.rs":"400f18465ef118e202ac9b1b9db47b1333fc17eb5841709082f2d1d5a51=
79391","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"fb999d55cf4f340=
3ac934dff1fc70c666087de234d7a91321bcfb5009bbafc6f","src/unix/bsd/freebsdlik=
e/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfa=
a14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":=
"e6f3430838d94dd17e359419f5de7d28a6b3adb8fcab7727d24e034bc6ed5d1e","src/uni=
x/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fc=
e28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fr=
eebsd14/mod.rs":"7d23d7d6b779265bca9c53c8b3e50b4dadb33f3911000ce88c8e09c9f0=
b60eab","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e10=
9dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebs=
dlike/freebsd/freebsd15/mod.rs":"45921502545212949a756d0edad2d861a5c6bc1925=
a4c13c8afc057ce6b4d8fe","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.=
rs":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src=
/unix/bsd/freebsdlike/freebsd/mod.rs":"46d8ca655e0363676dfb9bcda60bc8f39f0f=
17b1d52eb9b5228dc912955ebcfc","src/unix/bsd/freebsdlike/freebsd/powerpc.rs"=
:"36912b999e0571adccc06d9ebbd237e537a95c36ddb97d67a81e940ab28b36e7","src/un=
ix/bsd/freebsdlike/freebsd/powerpc64.rs":"c1c13a3e7633ab6e84929ac3bfac96a67=
779e6cdac157d64b5b9f7c2b32b1691","src/unix/bsd/freebsdlike/freebsd/riscv64.=
rs":"b6bbfb556ed35c3897a98efffbafd5a07854dce1786643ffc1aaaa5a4e7dbe1e","src=
/unix/bsd/freebsdlike/freebsd/x86.rs":"8102bc641970bec32d4f2b93c8ba0e9c0432=
f84cef1442e3bf5438c3ba9c6c4d","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.=
rs":"9ef5040678d489522ce44633643c23921a462ada95e93e7688344f72e92b3e9e","src=
/unix/bsd/freebsdlike/mod.rs":"31adfff1db7bed60fa8044b37ef40fbabb929b055670=
cefe3bac88782de879f8","src/unix/bsd/mod.rs":"a776f9bf11ab5245bcddc37bde002f=
28f84ff8f0d919d2dbc37055b3a679d86b","src/unix/bsd/netbsdlike/mod.rs":"d089e=
ef37c5888f59479c4961415b247470a662cd14a1ec65d1f3ebcd304cf31","src/unix/bsd/=
netbsdlike/netbsd/aarch64.rs":"3b0dcde4999ed05d93b3415731a1f1218ae8ef6f963e=
7391ae266957c31878cb","src/unix/bsd/netbsdlike/netbsd/arm.rs":"47abd680ddb4=
879648cac3d462e0daa7e980b5e6be7ba346f5f494ccdebee6e8","src/unix/bsd/netbsdl=
ike/netbsd/mips.rs":"8420d476126ca2740ff2cbd1e85d0a31334e2c68dd0a70d3ac3e3d=
802b5b5782","src/unix/bsd/netbsdlike/netbsd/mod.rs":"dc216609dfc6b2835e26f8=
c3e70f4c7c65425933eef04538de603f51e9429ec5","src/unix/bsd/netbsdlike/netbsd=
/powerpc.rs":"42f66be7650e95398a3687886db5053e55c77dc04eb139315bebf9668b2be=
d68","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"0b1936bad97b3a272c2d323d3=
435f6860fc355abe7603ca7ed8c4166cac75cc5","src/unix/bsd/netbsdlike/netbsd/sp=
arc64.rs":"78985b140b0337f6bb951f9db68e0db0b5a0a8131ac5c4426a342ed002e27a82=
","src/unix/bsd/netbsdlike/netbsd/x86.rs":"dda4e401f03084a87762fb68c4839987=
56a07b7c5d4b86348fc3f79380024fb7","src/unix/bsd/netbsdlike/netbsd/x86_64.rs=
":"b60e896c10ba86a59b13a189fe2e6b94265244fa4b2bc3f89a46065e7d469dea","src/u=
nix/bsd/netbsdlike/openbsd/aarch64.rs":"91b6ac97e6411261cf5206ab1951a4e4e1f=
1cc9ca26217d7144f000f8f7c8580","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f8=
c975d4b94a8b8d11dcc5224db628997003a8d289f12fb12b398e9445c2f122","src/unix/b=
sd/netbsdlike/openbsd/mips64.rs":"8532a189ae10c7d668d9d4065da8b05d124e09bd3=
9442c9f74a7f231c43eca48","src/unix/bsd/netbsdlike/openbsd/mod.rs":"1e631105=
744b4509e528baa14bcdc0738d474941d85827a6def7d00f20f8a308","src/unix/bsd/net=
bsdlike/openbsd/powerpc.rs":"f8c975d4b94a8b8d11dcc5224db628997003a8d289f12f=
b12b398e9445c2f122","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"d53f6cc=
d830b8bbe94c9be8a92a719105ed29846d6a11ce6c972fa7ff142a001","src/unix/bsd/ne=
tbsdlike/openbsd/riscv64.rs":"21a90502854e1aab413700edc41bd7922bc6e0fc3d724=
0aa57f258bb4546fa9c","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"d04fd287=
afbaa2c5df9d48c94e8374a532a3ba491b424ddf018270c7312f4085","src/unix/bsd/net=
bsdlike/openbsd/x86.rs":"ebe65020c0d457af0458f549b8c44099a8c274d734bfa6c336=
2f0b6423fa3c7a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"2aec823a0800d2=
8fe546d35e98ae1dc671aa253663f9923d147548233def260a","src/unix/haiku/b32.rs"=
:"c56aa69ed87dded0d297d44a9177577b1d2d4a79ed176e6768c7fc4dab90bfb4","src/un=
ix/haiku/b64.rs":"d44daef26b89e75d58ac0204a169a66ba5fbc13fc40948f67f19700e6=
033a07e","src/unix/haiku/mod.rs":"2589765aa89ad146cf0cb942fe371340293f97a5a=
aecd2dfc0ac0f563eac86f3","src/unix/haiku/native.rs":"fafc7daab134d37ed26037=
3f9c3a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku/x86_64.rs":"8d8=
ef6b462bc32b3270440526f35c8dec572b502355c27ad451e64a816c4a176","src/unix/hu=
rd/b32.rs":"3e79bb09b66d8a1d3b7589a4b2b2076e57bd7b51b747f5219f24d3bd2019ad6=
a","src/unix/hurd/b64.rs":"f61f0263a71f39a5130ac749bb0f146e5b95e7b054f49291=
97366f28e8c22815","src/unix/hurd/mod.rs":"37fe6e548eac4add081e157524d22de97=
6dec369104a14da1e3b20a4396d45ec","src/unix/linux_like/android/b32/arm.rs":"=
b51bc534e9b5d31544207e4b0b9cadef023b41085cfa07dae33d46771775a22a","src/unix=
/linux_like/android/b32/mod.rs":"a94d3e03741ea30082411f0f858dd302b9a8b7b8a8=
f0d8325ecaf2f7ca70312e","src/unix/linux_like/android/b32/x86/mod.rs":"1ea74=
c06e3f9b1a0b52ba0fc8ed6527e68813bfe9fe931698af5554a4b2ee3c6","src/unix/linu=
x_like/android/b64/aarch64/mod.rs":"03a71c8e142e098486dbe6674158317bc2f90a3=
e27132d3e9549aee8f5e3b1d0","src/unix/linux_like/android/b64/mod.rs":"186edd=
e6293b874c5ae96e10be760f38a967907fa9049bcaf8335aff51b3c6d1","src/unix/linux=
_like/android/b64/riscv64/mod.rs":"ad47fa7c4dcdaa6593291b5c923c8769aed10517=
0d1e71fe8443229aeb9e2430","src/unix/linux_like/android/b64/x86_64/mod.rs":"=
393fd4940dc44bddf3153fffc000cf1fbfe61313195879aafafd849b0b20bccf","src/unix=
/linux_like/android/mod.rs":"d300e2f5c65f8e59dcf792a2c56817c25a09db604f5ca0=
0ef45f6477c4a5d02b","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf1=
6525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/=
emscripten/mod.rs":"358a82517c559c46906b751217eea5f918d793f8bf84c3451d472b2=
ed9a1cf77","src/unix/linux_like/linux/arch/generic/mod.rs":"695b717593cbd25=
4bf8250521a261d87a39824333f35a50b7c75f252eae5a7d6","src/unix/linux_like/lin=
ux/arch/mips/mod.rs":"abcb98291a77d26f0c0792f1ee87763538559f1f9d7fcbf4e8e64=
01b4442515b","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f1=
24ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arc=
h/powerpc/mod.rs":"92c19d5f1ede9389f9044faf8f4f16fc5408b6fb04bbaa67c9bb1f69=
e32123e0","src/unix/linux_like/linux/arch/sparc/mod.rs":"dfd07a3a6d8b175678=
b180ff9903e0d5d529c8112d01bd135f53fce742f433a6","src/unix/linux_like/linux/=
gnu/b32/arm/mod.rs":"7ed85493e121e05d0d52a6751e744451548a390139a5ae947499fb=
fcff1910be","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"5fa98a93b92ae3=
336a0f6a279c0cd6a95c79ccb86443848fc96ddc1026279696","src/unix/linux_like/li=
nux/gnu/b32/m68k/mod.rs":"c5717f5e2266a40144c236e05475ffb2d964c01d956745f29=
678b69170dd1a1f","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"5a19abd74=
01743cad8e6e03ddee15686bbaf7d1bd5b2710e8c2eb97224ed54f0","src/unix/linux_li=
ke/linux/gnu/b32/mod.rs":"a9033d128bc441cd970caa4f912d0f842ac169b573e3dfa55=
39b763609e87d70","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"ee6e9a1184=
8747e0a480407ba7379befef6e2abaffc91ef7906a84e585cd2440","src/unix/linux_lik=
e/linux/gnu/b32/riscv32/mod.rs":"94d467ab2bacb907c039a099b81aa1ab6e79fadbc1=
fbc2a35f1efb092c725906","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"5=
e2e2d605ca74af943e539c8c1ba410715461870b314973c444eba0fee3039cd","src/unix/=
linux_like/linux/gnu/b32/x86/mod.rs":"4869c3fa80b115803adc0a5b77754077035fa=
e36edea27c3abe1504e73f0e516","src/unix/linux_like/linux/gnu/b64/aarch64/ilp=
32.rs":"47cc25f28c4bea16c00cd6023c84d09bdc8056217f35744dfdfe27c7f2ea0ca5","=
src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"39593a2f8fd78fccbbd9827=
34c0feb9d15cb3a6a9a6b029bb972ce5b89c78420","src/unix/linux_like/linux/gnu/b=
64/aarch64/mod.rs":"24f9ec2670ec41ae3c108c0c412b39daef9faf315e0d7c3a53f1ef0=
5dcd6e027","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"c0b4c6c2=
52104151390dfc521ffd63e739da709dffbb5cb71a3aba6e270b6fc2","src/unix/linux_l=
ike/linux/gnu/b64/mips64/mod.rs":"dd6aeee535eb66b1286365119b7976dffee6216f6=
653a981963b1cc288fa7516","src/unix/linux_like/linux/gnu/b64/mod.rs":"66b8a9=
81ff02176331f2402806e6ffd7d1a301fe23f285dd4e5dd2d9ed70ea1b","src/unix/linux=
_like/linux/gnu/b64/powerpc64/mod.rs":"450ad230da45da6ab33b4806db8ff24f6b1c=
a9b400fa2c5fb9187189a8545347","src/unix/linux_like/linux/gnu/b64/riscv64/mo=
d.rs":"fb3086756cc7aa87c8a8f2e59ea481968314e6abd3649f472dc55db8a542e032","s=
rc/unix/linux_like/linux/gnu/b64/s390x.rs":"bcac1400cad0226c7b8b8300d6cbab3=
00cd98922545c88b1968206442501aaaf","src/unix/linux_like/linux/gnu/b64/sparc=
64/mod.rs":"006ce42969449eb5bb8cdd7c03422be2a436717b152b3982d267ed437be4d5e=
4","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"bf75505d274e3185694c2=
d5a28fecbeff276faad5cb79c7ec2122ce024b8782f","src/unix/linux_like/linux/gnu=
/b64/x86_64/not_x32.rs":"fdb2d3b26336297d34c452633afc705bcaf9c1b4e4fda359f6=
95c4f708d81f17","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"54c1ac9b=
d8d9fe13eeb9b27a92baf715c9d77af1229262fce93362da72f11fe5","src/unix/linux_l=
ike/linux/gnu/mod.rs":"850352f680643c600aaf68f7b6d0b1cf3f382a251cd2b6bb3c82=
cf3a65038c68","src/unix/linux_like/linux/mod.rs":"7ff1fc95cc66e398ff467c92f=
b0a642dd6076caf32ae52daec9316f66c6b68cf","src/unix/linux_like/linux/musl/b3=
2/arm/mod.rs":"64d2f81625dd6691ea81bc64a4a3ed88d41b125a7cd00ed347875b795d6a=
4905","src/unix/linux_like/linux/musl/b32/hexagon.rs":"b0247dd57999a4ddbbd7=
247a471255181e22458825c61b5464fafd36a31a8545","src/unix/linux_like/linux/mu=
sl/b32/mips/mod.rs":"b962ea54c35281131aaa990bf59949d54f24f9583c7191a7efc9c3=
84d6159cfa","src/unix/linux_like/linux/musl/b32/mod.rs":"b9adac558a356cbadd=
b821588645590a7a11d22c1f11f6d2cc636c177f2e28e9","src/unix/linux_like/linux/=
musl/b32/powerpc.rs":"95295bd0e58668a204799a1b5f1a0f636c67be28a959e10ee1ab9=
2631b53c82f","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"738bc36f9=
a0f312cc2336cac38ecd5390a9d91b53da51d26afd2542449b54e7b","src/unix/linux_li=
ke/linux/musl/b32/x86/mod.rs":"0f6e1c0d5e7d650832da95cf7dce85dff82845876e53=
b6587154e546b09d3efc","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"=
8e718cec34d53079e9c841084cb2eca7942a0a66139360a833a0e2ebf0bfe95a","src/unix=
/linux_like/linux/musl/b64/loongarch64/mod.rs":"a825259bb56e78a62f559dccfd1=
c35e686d8d15f781ce78f83c5266cc398fe82","src/unix/linux_like/linux/musl/b64/=
mips64.rs":"be1c8bd1f406d3fb1873075cf613ec17b545200ef514423a12190d6dbc42016=
c","src/unix/linux_like/linux/musl/b64/mod.rs":"db84391acba3ed3c9462ba899f0=
f1a88747bdb5207658343ba699505bc7d4f8c","src/unix/linux_like/linux/musl/b64/=
powerpc64.rs":"eb4d57a7201ffbfc8090bc8f97a62e1642a09d224cd70d4556d3c18cf63a=
c802","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"11b166d0b63ed6eb=
0f24820a0b9ccef9f68eb28e1bc57011ea701d57df63ed34","src/unix/linux_like/linu=
x/musl/b64/s390x.rs":"67d922c392d53c3928798d9725d3f4336a967d1ef20c5088e498c=
f331af17fd1","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"9e958fbdb3=
cb6c3b48d2413a73961db7259fc34863f4c2f67afa2a17b7b1af05","src/unix/linux_lik=
e/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e789d8d3=
e76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"c7ee52da16396aea3a3=
9573ae9a0ba071500d0e966a53b938793a5ef8b3bb25c","src/unix/linux_like/linux/u=
clibc/arm/mod.rs":"1b0ce2d0d4467cc32a1dd5e5c62f0d57fc1963354ae223bdc636b8d6=
d5d6fea3","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"73d70042db=
5148d5a789880100879541563fa1de8bf5feb792341b4270244968","src/unix/linux_lik=
e/linux/uclibc/mips/mips64/mod.rs":"0a6c13d1873d3f165171a69433bb9b2df1c9151=
cc1085735613791e603865a06","src/unix/linux_like/linux/uclibc/mips/mod.rs":"=
ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","src/unix=
/linux_like/linux/uclibc/mod.rs":"1cc653e9ad8524408c9023cbd7245b53b81c105ee=
3b341cb3e98c435196d191e","src/unix/linux_like/linux/uclibc/x86_64/l4re.rs":=
"076ad477f0786a2e4944cc0550a4492b21d4b65d094006947ec40e0c7ee5365d","src/uni=
x/linux_like/linux/uclibc/x86_64/mod.rs":"cd37c37e03e399bb33723f984bebdcac5=
4445d9841a0d57dcce83615add4d1d4","src/unix/linux_like/linux/uclibc/x86_64/o=
ther.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4093def"=
,"src/unix/linux_like/mod.rs":"979205c66cd960da2506e3115a4950a8fe24ce963fdb=
a3d5d05b9e19d8f077ea","src/unix/mod.rs":"d20b3b093cf2f1437bc5c18794a8e5bc29=
6277daae6d0149aeac9b87860bb962","src/unix/newlib/aarch64/mod.rs":"e08ba9d6a=
c7f8b381f8699b3604cf460a5fcd5b8e68e139bba4f29bfba4781a4","src/unix/newlib/a=
rm/mod.rs":"ddea29e7ce40756f2af4c9792d5cefdd0c634401aaeb146dc686f1f125e3bac=
8","src/unix/newlib/espidf/mod.rs":"f7e4ac40806d5aa2d941b3864acbc50dccebe25=
05f48f7997abaf6e8551c655e","src/unix/newlib/generic.rs":"182e584f14e0984934=
130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/horizon/mo=
d.rs":"a484d84f56fd5b49fed83d6d8a5e8ec5647f0bfa3d30b496a7fa6fe5e546a980","s=
rc/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7f55a797=
ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs":"1a161a27493adb2c3b47d60eeb=
c8ac57b2f0ef0111abdcd5b4d55d11c36d37e5","src/unix/newlib/rtems/mod.rs":"239=
c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/unix/ne=
wlib/vita/mod.rs":"927c36282a453a110e83786a5b9c31893411940d2e9b5d1ba6449cc4=
fec686ff","src/unix/nto/aarch64.rs":"91d0448f932d0cf6af4f11e4f8c9d68a78100e=
d561e560665983359b7b943075","src/unix/nto/mod.rs":"01938d623e161fb8e20e28d8=
6977403023bb1645c83cec2ffef3632d7ec29750","src/unix/nto/neutrino.rs":"039ab=
7b1ed702d515f3e06d7f3536709704715a49905024b6c520696a65086f9","src/unix/nto/=
x86_64.rs":"3fdcc6f28787476df78cae8e166b2b7408373a5bafc32e68e7d79febe4e5c88=
7","src/unix/nuttx/mod.rs":"e4c2625c04bfb3b54171208af68201d897c2e0b62f6d24a=
f6470669ffa1b6425","src/unix/redox/mod.rs":"5f57cadca20a39430d9837824134023=
332b1cb6af1e8c66fa2dd9c4255439d52","src/unix/solarish/compat.rs":"c02a88918=
852b7a9c60e45a34f7b003901000380f5c1b2832b8bd79f84936c8b","src/unix/solarish=
/illumos.rs":"cc7104f002a5379f981c59a779ef4afad00c874e0be21dda339901cd5eea4=
af1","src/unix/solarish/mod.rs":"b5dae853ebfc3355b155f8c20f3a481517bce27e16=
4e304f56dfff172e313098","src/unix/solarish/solaris.rs":"3a37167395881640117=
a37728ca848d1dbeb4286912025d86c57608e0ddc823f","src/unix/solarish/x86.rs":"=
44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","src/unix=
/solarish/x86_64.rs":"1601309baae50ccfd51b5d188668e6ac5dabc4e8d2ffde1035929=
22ec15295ef","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e8cd328f=
13187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"98f0afdc51=
1cd02557e506c21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/arm.rs=
":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e88","src/v=
xworks/mod.rs":"d02d216bf652e4a1d21f01e8455beae20db30981d5d630f7b6fc113fff7=
98a1b","src/vxworks/powerpc.rs":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b=
8ef7084777cb181d788e88","src/vxworks/powerpc64.rs":"98f0afdc511cd02557e506c=
21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/riscv32.rs":"2f018c=
db5b6e9a2c0d3a2a34d9a6c095d8469272ca8f137e4336140962be3177","src/vxworks/ri=
scv64.rs":"16bff4f1c4eb73df0a66a16718716340a3b541bf94aa3318065d9c627e4e3069=
","src/vxworks/x86.rs":"552f007f38317620b23889cb7c49d1d115841252439060122f5=
2f434fbc6e5ba","src/vxworks/x86_64.rs":"018d92be3ad628a129eff9f2f5dfbc0883d=
8b8e5f2fa917b900a7f98ed6b514a","src/wasi/mod.rs":"f7b39137ce2c005367016a00e=
00f0affdce627d9165681c9dc9280534720640b","src/wasi/p2.rs":"feecc0485eabd2c3=
2bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/mod.rs":=
"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","src/win=
dows/mod.rs":"282daeacf420e36c5ba2f8129d045104e1172b29a9035e73c10739836a8af=
440","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9f47b5c4=
113a1a87fae8e64549c00","src/xous.rs":"17b571c988119fe3f71dbcccfe722de5c772a=
bc3ca20dc4b09b58780980b78e9","tests/const_fn.rs":"8ac3171d7bced3576a4e93f48=
570b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"b5aba8db14291edd000dfc=
c4d620c7ebfb122c613afb886ca8803fa4e128a20a"}
+\ No newline at end of file
++{"files":{"CHANGELOG.md":"e48a795c934b4fbb91a59757a32b13c82c2dc9b71d6fc49=
da9bef3b8d85f5454","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.toml":"647ea80df57c844de63e49629b9e13d0=
2e8dfdcb0e1ec3b301002e3ca5e6d461","LICENSE-APACHE":"62c7a1e35f56406896d7aa7=
ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca256f56=
a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"38061c8bb600c=
2e01b48b662288cb11f38c0ec27bbe6d496e7f0acb1016991c4","build.rs":"bcbe11dc71=
1029460fcc4f7fd8e38c487006ad0860007915ae6718bd90fb891a","rustfmt.toml":"e93=
21ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fixed_w=
idth_ints.rs":"10eb30cf48390768f0167e1fa46ae99461968a05e93bd96aff721f54550a=
e66c","src/fuchsia/aarch64.rs":"d430586295c7eb022eb8202f7b18e483a9dd0e7de18=
57f7963453792c7161def","src/fuchsia/mod.rs":"2556b215558fc76d8337a8dac4d3ec=
8124aa442cc4676bcb2a85e248b23fb62b","src/fuchsia/riscv64.rs":"7efd6cbcbd2cb=
25d6380f6df69ad91cf62efd55fb9cb7cb85884c490b601743e","src/fuchsia/x86_64.rs=
":"e63daa4085c6f6ab35d9711df6d7e027247a8b3b2a6dc47fcb2b21e1f4820a2f","src/h=
ermit.rs":"6d1d40c1473a73aae2d3a470fa623ea92a196a65468acd9373b20dc6dcbd5d31=
","src/lib.rs":"1171567598056a99dbce2ef1e5b61a6410d6ba1333cca113d50f7529668=
8a565","src/macros.rs":"ce06d8677464669530a141269dea2cf4debb24ab3f53eb136f9=
33bcf553a4fe3","src/psp.rs":"dcf53184a1ab06d18aa34431ca42644c5646fe78d05a53=
678ef9529607ba3ea7","src/sgx.rs":"f0f1a9fa864cd3dc94c4b3ce73f88e67f11453f63=
d8b4d52823de2ccbba7eb49","src/solid/aarch64.rs":"98f0afdc511cd02557e506c21f=
ed6737585490a1dce7a9d4941d08c437762b99","src/solid/arm.rs":"acb7968ce99fe3f=
4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e88","src/solid/mod.rs":"0111=
6b18b9be6791fdf4ff572d12154b64dfa43a18afc33940ea676e1884bdbb","src/switch.r=
s":"bb0ce1331c61a28caea7bd201e399d1e1127f303dcc7747b4f07f63d188ea49c","src/=
teeos/mod.rs":"174e10b1e3cd37122b557a9e9f75205f1858a31cb62cbb83582da2661228=
babe","src/trusty.rs":"f4c8e60896f93759eea4fa5a146dd98dd21d818a4e54df391b14=
513a402212c2","src/unix/aix/mod.rs":"31dd168d5d06cc60bf1b1b6bb0665640fb082f=
f7b1f2e13c22a888fa8bdb1945","src/unix/aix/powerpc64.rs":"caf11cb47a1ac1c031=
6f72050f6fd82dbcbbc6258a9b51ff5a9842f2825e63d7","src/unix/bsd/apple/b32/mod=
.rs":"9f20c77e86b812ff09d8193a48fe4f3afd6dae8a43d5a0d78b8592971cc3726e","sr=
c/unix/bsd/apple/b64/aarch64/mod.rs":"1ebe9f1a1e07318813da7e2a78195937533c2=
2b51a23a4527b9404c948318f86","src/unix/bsd/apple/b64/mod.rs":"164e734befe87=
fa6e2d79fb856ce314282bd219ea4f2f357c6446dca6d2de359","src/unix/bsd/apple/b6=
4/x86_64/mod.rs":"e03794fdeaaf4a86c7b12f41e490a7538c12d4a77743a5448237f73d5=
a8593f4","src/unix/bsd/apple/mod.rs":"1ad08f5ca6becd37bab20bae5f3153a8fc882=
4e9123ec77237d37b64f133741a","src/unix/bsd/freebsdlike/dragonfly/errno.rs":=
"07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/uni=
x/bsd/freebsdlike/dragonfly/mod.rs":"f130937ac556080c77d7d1f011f2d2c964b65e=
b633bf6b7f1251a045670b9ec8","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"=
aea276451dca89f086d014b66e2e83e1eb948ab8dfbf920170c1b8338c9777c3","src/unix=
/bsd/freebsdlike/freebsd/arm.rs":"f70c76405a72754db37dff7de3fd586a19e1512b4=
7f452493b430f295d7264af","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs=
":"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/u=
nix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14a=
fae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd11/mod.rs":"400f18465ef118e202ac9b1b9db47b1333fc17eb5841709082f2d1d5a51=
79391","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"fb999d55cf4f340=
3ac934dff1fc70c666087de234d7a91321bcfb5009bbafc6f","src/unix/bsd/freebsdlik=
e/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfa=
a14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":=
"e6f3430838d94dd17e359419f5de7d28a6b3adb8fcab7727d24e034bc6ed5d1e","src/uni=
x/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fc=
e28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fr=
eebsd14/mod.rs":"7d23d7d6b779265bca9c53c8b3e50b4dadb33f3911000ce88c8e09c9f0=
b60eab","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e10=
9dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebs=
dlike/freebsd/freebsd15/mod.rs":"45921502545212949a756d0edad2d861a5c6bc1925=
a4c13c8afc057ce6b4d8fe","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.=
rs":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src=
/unix/bsd/freebsdlike/freebsd/mod.rs":"46d8ca655e0363676dfb9bcda60bc8f39f0f=
17b1d52eb9b5228dc912955ebcfc","src/unix/bsd/freebsdlike/freebsd/powerpc.rs"=
:"36912b999e0571adccc06d9ebbd237e537a95c36ddb97d67a81e940ab28b36e7","src/un=
ix/bsd/freebsdlike/freebsd/powerpc64.rs":"c1c13a3e7633ab6e84929ac3bfac96a67=
779e6cdac157d64b5b9f7c2b32b1691","src/unix/bsd/freebsdlike/freebsd/riscv64.=
rs":"b6bbfb556ed35c3897a98efffbafd5a07854dce1786643ffc1aaaa5a4e7dbe1e","src=
/unix/bsd/freebsdlike/freebsd/x86.rs":"8102bc641970bec32d4f2b93c8ba0e9c0432=
f84cef1442e3bf5438c3ba9c6c4d","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.=
rs":"9ef5040678d489522ce44633643c23921a462ada95e93e7688344f72e92b3e9e","src=
/unix/bsd/freebsdlike/mod.rs":"31adfff1db7bed60fa8044b37ef40fbabb929b055670=
cefe3bac88782de879f8","src/unix/bsd/mod.rs":"a776f9bf11ab5245bcddc37bde002f=
28f84ff8f0d919d2dbc37055b3a679d86b","src/unix/bsd/netbsdlike/mod.rs":"d089e=
ef37c5888f59479c4961415b247470a662cd14a1ec65d1f3ebcd304cf31","src/unix/bsd/=
netbsdlike/netbsd/aarch64.rs":"3b0dcde4999ed05d93b3415731a1f1218ae8ef6f963e=
7391ae266957c31878cb","src/unix/bsd/netbsdlike/netbsd/arm.rs":"47abd680ddb4=
879648cac3d462e0daa7e980b5e6be7ba346f5f494ccdebee6e8","src/unix/bsd/netbsdl=
ike/netbsd/mips.rs":"8420d476126ca2740ff2cbd1e85d0a31334e2c68dd0a70d3ac3e3d=
802b5b5782","src/unix/bsd/netbsdlike/netbsd/mod.rs":"dc216609dfc6b2835e26f8=
c3e70f4c7c65425933eef04538de603f51e9429ec5","src/unix/bsd/netbsdlike/netbsd=
/powerpc.rs":"42f66be7650e95398a3687886db5053e55c77dc04eb139315bebf9668b2be=
d68","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"0b1936bad97b3a272c2d323d3=
435f6860fc355abe7603ca7ed8c4166cac75cc5","src/unix/bsd/netbsdlike/netbsd/sp=
arc64.rs":"78985b140b0337f6bb951f9db68e0db0b5a0a8131ac5c4426a342ed002e27a82=
","src/unix/bsd/netbsdlike/netbsd/x86.rs":"dda4e401f03084a87762fb68c4839987=
56a07b7c5d4b86348fc3f79380024fb7","src/unix/bsd/netbsdlike/netbsd/x86_64.rs=
":"b60e896c10ba86a59b13a189fe2e6b94265244fa4b2bc3f89a46065e7d469dea","src/u=
nix/bsd/netbsdlike/openbsd/aarch64.rs":"91b6ac97e6411261cf5206ab1951a4e4e1f=
1cc9ca26217d7144f000f8f7c8580","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f8=
c975d4b94a8b8d11dcc5224db628997003a8d289f12fb12b398e9445c2f122","src/unix/b=
sd/netbsdlike/openbsd/mips64.rs":"8532a189ae10c7d668d9d4065da8b05d124e09bd3=
9442c9f74a7f231c43eca48","src/unix/bsd/netbsdlike/openbsd/mod.rs":"1e631105=
744b4509e528baa14bcdc0738d474941d85827a6def7d00f20f8a308","src/unix/bsd/net=
bsdlike/openbsd/powerpc.rs":"f8c975d4b94a8b8d11dcc5224db628997003a8d289f12f=
b12b398e9445c2f122","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"d53f6cc=
d830b8bbe94c9be8a92a719105ed29846d6a11ce6c972fa7ff142a001","src/unix/bsd/ne=
tbsdlike/openbsd/riscv64.rs":"21a90502854e1aab413700edc41bd7922bc6e0fc3d724=
0aa57f258bb4546fa9c","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"d04fd287=
afbaa2c5df9d48c94e8374a532a3ba491b424ddf018270c7312f4085","src/unix/bsd/net=
bsdlike/openbsd/x86.rs":"ebe65020c0d457af0458f549b8c44099a8c274d734bfa6c336=
2f0b6423fa3c7a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"2aec823a0800d2=
8fe546d35e98ae1dc671aa253663f9923d147548233def260a","src/unix/haiku/b32.rs"=
:"c56aa69ed87dded0d297d44a9177577b1d2d4a79ed176e6768c7fc4dab90bfb4","src/un=
ix/haiku/b64.rs":"d44daef26b89e75d58ac0204a169a66ba5fbc13fc40948f67f19700e6=
033a07e","src/unix/haiku/mod.rs":"2589765aa89ad146cf0cb942fe371340293f97a5a=
aecd2dfc0ac0f563eac86f3","src/unix/haiku/native.rs":"fafc7daab134d37ed26037=
3f9c3a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku/x86_64.rs":"8d8=
ef6b462bc32b3270440526f35c8dec572b502355c27ad451e64a816c4a176","src/unix/hu=
rd/b32.rs":"3e79bb09b66d8a1d3b7589a4b2b2076e57bd7b51b747f5219f24d3bd2019ad6=
a","src/unix/hurd/b64.rs":"f61f0263a71f39a5130ac749bb0f146e5b95e7b054f49291=
97366f28e8c22815","src/unix/hurd/mod.rs":"37fe6e548eac4add081e157524d22de97=
6dec369104a14da1e3b20a4396d45ec","src/unix/linux_like/android/b32/arm.rs":"=
b51bc534e9b5d31544207e4b0b9cadef023b41085cfa07dae33d46771775a22a","src/unix=
/linux_like/android/b32/mod.rs":"a94d3e03741ea30082411f0f858dd302b9a8b7b8a8=
f0d8325ecaf2f7ca70312e","src/unix/linux_like/android/b32/x86/mod.rs":"1ea74=
c06e3f9b1a0b52ba0fc8ed6527e68813bfe9fe931698af5554a4b2ee3c6","src/unix/linu=
x_like/android/b64/aarch64/mod.rs":"03a71c8e142e098486dbe6674158317bc2f90a3=
e27132d3e9549aee8f5e3b1d0","src/unix/linux_like/android/b64/mod.rs":"186edd=
e6293b874c5ae96e10be760f38a967907fa9049bcaf8335aff51b3c6d1","src/unix/linux=
_like/android/b64/riscv64/mod.rs":"ad47fa7c4dcdaa6593291b5c923c8769aed10517=
0d1e71fe8443229aeb9e2430","src/unix/linux_like/android/b64/x86_64/mod.rs":"=
393fd4940dc44bddf3153fffc000cf1fbfe61313195879aafafd849b0b20bccf","src/unix=
/linux_like/android/mod.rs":"d300e2f5c65f8e59dcf792a2c56817c25a09db604f5ca0=
0ef45f6477c4a5d02b","src/unix/linux_like/emscripten/lfs64.rs":"3a1d1779bcf1=
6525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/unix/linux_like/=
emscripten/mod.rs":"358a82517c559c46906b751217eea5f918d793f8bf84c3451d472b2=
ed9a1cf77","src/unix/linux_like/linux/arch/generic/mod.rs":"74e073817b49261=
c7b9b194c6a7b2cb94adb7a66ee0449bfa4af169d2acbae47","src/unix/linux_like/lin=
ux/arch/mips/mod.rs":"abcb98291a77d26f0c0792f1ee87763538559f1f9d7fcbf4e8e64=
01b4442515b","src/unix/linux_like/linux/arch/mod.rs":"8bc5898b03760a95dd4f1=
24ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linux_like/linux/arc=
h/powerpc/mod.rs":"92c19d5f1ede9389f9044faf8f4f16fc5408b6fb04bbaa67c9bb1f69=
e32123e0","src/unix/linux_like/linux/arch/sparc/mod.rs":"dfd07a3a6d8b175678=
b180ff9903e0d5d529c8112d01bd135f53fce742f433a6","src/unix/linux_like/linux/=
gnu/b32/arm/mod.rs":"7ed85493e121e05d0d52a6751e744451548a390139a5ae947499fb=
fcff1910be","src/unix/linux_like/linux/gnu/b32/csky/mod.rs":"5fa98a93b92ae3=
336a0f6a279c0cd6a95c79ccb86443848fc96ddc1026279696","src/unix/linux_like/li=
nux/gnu/b32/m68k/mod.rs":"c5717f5e2266a40144c236e05475ffb2d964c01d956745f29=
678b69170dd1a1f","src/unix/linux_like/linux/gnu/b32/mips/mod.rs":"5a19abd74=
01743cad8e6e03ddee15686bbaf7d1bd5b2710e8c2eb97224ed54f0","src/unix/linux_li=
ke/linux/gnu/b32/mod.rs":"a9033d128bc441cd970caa4f912d0f842ac169b573e3dfa55=
39b763609e87d70","src/unix/linux_like/linux/gnu/b32/powerpc.rs":"ee6e9a1184=
8747e0a480407ba7379befef6e2abaffc91ef7906a84e585cd2440","src/unix/linux_lik=
e/linux/gnu/b32/riscv32/mod.rs":"94d467ab2bacb907c039a099b81aa1ab6e79fadbc1=
fbc2a35f1efb092c725906","src/unix/linux_like/linux/gnu/b32/sparc/mod.rs":"5=
e2e2d605ca74af943e539c8c1ba410715461870b314973c444eba0fee3039cd","src/unix/=
linux_like/linux/gnu/b32/x86/mod.rs":"4869c3fa80b115803adc0a5b77754077035fa=
e36edea27c3abe1504e73f0e516","src/unix/linux_like/linux/gnu/b64/aarch64/ilp=
32.rs":"47cc25f28c4bea16c00cd6023c84d09bdc8056217f35744dfdfe27c7f2ea0ca5","=
src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"39593a2f8fd78fccbbd9827=
34c0feb9d15cb3a6a9a6b029bb972ce5b89c78420","src/unix/linux_like/linux/gnu/b=
64/aarch64/mod.rs":"24f9ec2670ec41ae3c108c0c412b39daef9faf315e0d7c3a53f1ef0=
5dcd6e027","src/unix/linux_like/linux/gnu/b64/loongarch64/mod.rs":"c0b4c6c2=
52104151390dfc521ffd63e739da709dffbb5cb71a3aba6e270b6fc2","src/unix/linux_l=
ike/linux/gnu/b64/mips64/mod.rs":"dd6aeee535eb66b1286365119b7976dffee6216f6=
653a981963b1cc288fa7516","src/unix/linux_like/linux/gnu/b64/mod.rs":"66b8a9=
81ff02176331f2402806e6ffd7d1a301fe23f285dd4e5dd2d9ed70ea1b","src/unix/linux=
_like/linux/gnu/b64/powerpc64/mod.rs":"450ad230da45da6ab33b4806db8ff24f6b1c=
a9b400fa2c5fb9187189a8545347","src/unix/linux_like/linux/gnu/b64/riscv64/mo=
d.rs":"fb3086756cc7aa87c8a8f2e59ea481968314e6abd3649f472dc55db8a542e032","s=
rc/unix/linux_like/linux/gnu/b64/s390x.rs":"bcac1400cad0226c7b8b8300d6cbab3=
00cd98922545c88b1968206442501aaaf","src/unix/linux_like/linux/gnu/b64/sparc=
64/mod.rs":"006ce42969449eb5bb8cdd7c03422be2a436717b152b3982d267ed437be4d5e=
4","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"bf75505d274e3185694c2=
d5a28fecbeff276faad5cb79c7ec2122ce024b8782f","src/unix/linux_like/linux/gnu=
/b64/x86_64/not_x32.rs":"fdb2d3b26336297d34c452633afc705bcaf9c1b4e4fda359f6=
95c4f708d81f17","src/unix/linux_like/linux/gnu/b64/x86_64/x32.rs":"54c1ac9b=
d8d9fe13eeb9b27a92baf715c9d77af1229262fce93362da72f11fe5","src/unix/linux_l=
ike/linux/gnu/mod.rs":"850352f680643c600aaf68f7b6d0b1cf3f382a251cd2b6bb3c82=
cf3a65038c68","src/unix/linux_like/linux/mod.rs":"7ff1fc95cc66e398ff467c92f=
b0a642dd6076caf32ae52daec9316f66c6b68cf","src/unix/linux_like/linux/musl/b3=
2/arm/mod.rs":"64d2f81625dd6691ea81bc64a4a3ed88d41b125a7cd00ed347875b795d6a=
4905","src/unix/linux_like/linux/musl/b32/hexagon.rs":"b0247dd57999a4ddbbd7=
247a471255181e22458825c61b5464fafd36a31a8545","src/unix/linux_like/linux/mu=
sl/b32/mips/mod.rs":"b962ea54c35281131aaa990bf59949d54f24f9583c7191a7efc9c3=
84d6159cfa","src/unix/linux_like/linux/musl/b32/mod.rs":"b9adac558a356cbadd=
b821588645590a7a11d22c1f11f6d2cc636c177f2e28e9","src/unix/linux_like/linux/=
musl/b32/powerpc.rs":"95295bd0e58668a204799a1b5f1a0f636c67be28a959e10ee1ab9=
2631b53c82f","src/unix/linux_like/linux/musl/b32/riscv32/mod.rs":"738bc36f9=
a0f312cc2336cac38ecd5390a9d91b53da51d26afd2542449b54e7b","src/unix/linux_li=
ke/linux/musl/b32/x86/mod.rs":"0f6e1c0d5e7d650832da95cf7dce85dff82845876e53=
b6587154e546b09d3efc","src/unix/linux_like/linux/musl/b64/aarch64/mod.rs":"=
8e718cec34d53079e9c841084cb2eca7942a0a66139360a833a0e2ebf0bfe95a","src/unix=
/linux_like/linux/musl/b64/loongarch64/mod.rs":"a825259bb56e78a62f559dccfd1=
c35e686d8d15f781ce78f83c5266cc398fe82","src/unix/linux_like/linux/musl/b64/=
mips64.rs":"be1c8bd1f406d3fb1873075cf613ec17b545200ef514423a12190d6dbc42016=
c","src/unix/linux_like/linux/musl/b64/mod.rs":"db84391acba3ed3c9462ba899f0=
f1a88747bdb5207658343ba699505bc7d4f8c","src/unix/linux_like/linux/musl/b64/=
powerpc64.rs":"eb4d57a7201ffbfc8090bc8f97a62e1642a09d224cd70d4556d3c18cf63a=
c802","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"11b166d0b63ed6eb=
0f24820a0b9ccef9f68eb28e1bc57011ea701d57df63ed34","src/unix/linux_like/linu=
x/musl/b64/s390x.rs":"67d922c392d53c3928798d9725d3f4336a967d1ef20c5088e498c=
f331af17fd1","src/unix/linux_like/linux/musl/b64/x86_64/mod.rs":"9e958fbdb3=
cb6c3b48d2413a73961db7259fc34863f4c2f67afa2a17b7b1af05","src/unix/linux_lik=
e/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2d02946f84ae83e8f5cb0e789d8d3=
e76c1923a5d31","src/unix/linux_like/linux/musl/mod.rs":"c7ee52da16396aea3a3=
9573ae9a0ba071500d0e966a53b938793a5ef8b3bb25c","src/unix/linux_like/linux/u=
clibc/arm/mod.rs":"1b0ce2d0d4467cc32a1dd5e5c62f0d57fc1963354ae223bdc636b8d6=
d5d6fea3","src/unix/linux_like/linux/uclibc/mips/mips32/mod.rs":"73d70042db=
5148d5a789880100879541563fa1de8bf5feb792341b4270244968","src/unix/linux_lik=
e/linux/uclibc/mips/mips64/mod.rs":"0a6c13d1873d3f165171a69433bb9b2df1c9151=
cc1085735613791e603865a06","src/unix/linux_like/linux/uclibc/mips/mod.rs":"=
ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4cbd5c07e976513dcea","src/unix=
/linux_like/linux/uclibc/mod.rs":"1cc653e9ad8524408c9023cbd7245b53b81c105ee=
3b341cb3e98c435196d191e","src/unix/linux_like/linux/uclibc/x86_64/l4re.rs":=
"076ad477f0786a2e4944cc0550a4492b21d4b65d094006947ec40e0c7ee5365d","src/uni=
x/linux_like/linux/uclibc/x86_64/mod.rs":"cd37c37e03e399bb33723f984bebdcac5=
4445d9841a0d57dcce83615add4d1d4","src/unix/linux_like/linux/uclibc/x86_64/o=
ther.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf3da0619436169c12cadc4093def"=
,"src/unix/linux_like/mod.rs":"979205c66cd960da2506e3115a4950a8fe24ce963fdb=
a3d5d05b9e19d8f077ea","src/unix/mod.rs":"d20b3b093cf2f1437bc5c18794a8e5bc29=
6277daae6d0149aeac9b87860bb962","src/unix/newlib/aarch64/mod.rs":"e08ba9d6a=
c7f8b381f8699b3604cf460a5fcd5b8e68e139bba4f29bfba4781a4","src/unix/newlib/a=
rm/mod.rs":"ddea29e7ce40756f2af4c9792d5cefdd0c634401aaeb146dc686f1f125e3bac=
8","src/unix/newlib/espidf/mod.rs":"f7e4ac40806d5aa2d941b3864acbc50dccebe25=
05f48f7997abaf6e8551c655e","src/unix/newlib/generic.rs":"182e584f14e0984934=
130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd","src/unix/newlib/horizon/mo=
d.rs":"a484d84f56fd5b49fed83d6d8a5e8ec5647f0bfa3d30b496a7fa6fe5e546a980","s=
rc/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b49bf5ebe1335f3b12146f7f55a797=
ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs":"1a161a27493adb2c3b47d60eeb=
c8ac57b2f0ef0111abdcd5b4d55d11c36d37e5","src/unix/newlib/rtems/mod.rs":"239=
c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4a22b861f82713a","src/unix/ne=
wlib/vita/mod.rs":"927c36282a453a110e83786a5b9c31893411940d2e9b5d1ba6449cc4=
fec686ff","src/unix/nto/aarch64.rs":"91d0448f932d0cf6af4f11e4f8c9d68a78100e=
d561e560665983359b7b943075","src/unix/nto/mod.rs":"01938d623e161fb8e20e28d8=
6977403023bb1645c83cec2ffef3632d7ec29750","src/unix/nto/neutrino.rs":"039ab=
7b1ed702d515f3e06d7f3536709704715a49905024b6c520696a65086f9","src/unix/nto/=
x86_64.rs":"3fdcc6f28787476df78cae8e166b2b7408373a5bafc32e68e7d79febe4e5c88=
7","src/unix/nuttx/mod.rs":"e4c2625c04bfb3b54171208af68201d897c2e0b62f6d24a=
f6470669ffa1b6425","src/unix/redox/mod.rs":"5f57cadca20a39430d9837824134023=
332b1cb6af1e8c66fa2dd9c4255439d52","src/unix/solarish/compat.rs":"c02a88918=
852b7a9c60e45a34f7b003901000380f5c1b2832b8bd79f84936c8b","src/unix/solarish=
/illumos.rs":"cc7104f002a5379f981c59a779ef4afad00c874e0be21dda339901cd5eea4=
af1","src/unix/solarish/mod.rs":"b5dae853ebfc3355b155f8c20f3a481517bce27e16=
4e304f56dfff172e313098","src/unix/solarish/solaris.rs":"3a37167395881640117=
a37728ca848d1dbeb4286912025d86c57608e0ddc823f","src/unix/solarish/x86.rs":"=
44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515b9820c9421cff7427","src/unix=
/solarish/x86_64.rs":"1601309baae50ccfd51b5d188668e6ac5dabc4e8d2ffde1035929=
22ec15295ef","src/unix/solarish/x86_common.rs":"4ae02d88622f7f080f5e8cd328f=
13187edbc5e124fb3e05e4cf212597f6cce48","src/vxworks/aarch64.rs":"98f0afdc51=
1cd02557e506c21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/arm.rs=
":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b8ef7084777cb181d788e88","src/v=
xworks/mod.rs":"d02d216bf652e4a1d21f01e8455beae20db30981d5d630f7b6fc113fff7=
98a1b","src/vxworks/powerpc.rs":"acb7968ce99fe3f4abdf39d98f8133d21a4fba435b=
8ef7084777cb181d788e88","src/vxworks/powerpc64.rs":"98f0afdc511cd02557e506c=
21fed6737585490a1dce7a9d4941d08c437762b99","src/vxworks/riscv32.rs":"2f018c=
db5b6e9a2c0d3a2a34d9a6c095d8469272ca8f137e4336140962be3177","src/vxworks/ri=
scv64.rs":"16bff4f1c4eb73df0a66a16718716340a3b541bf94aa3318065d9c627e4e3069=
","src/vxworks/x86.rs":"552f007f38317620b23889cb7c49d1d115841252439060122f5=
2f434fbc6e5ba","src/vxworks/x86_64.rs":"018d92be3ad628a129eff9f2f5dfbc0883d=
8b8e5f2fa917b900a7f98ed6b514a","src/wasi/mod.rs":"f7b39137ce2c005367016a00e=
00f0affdce627d9165681c9dc9280534720640b","src/wasi/p2.rs":"feecc0485eabd2c3=
2bc5d800df6ad1b9b4d282741342fb08792f2635204e1e08","src/windows/gnu/mod.rs":=
"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb39f6514c28dffd8ac9f","src/win=
dows/mod.rs":"282daeacf420e36c5ba2f8129d045104e1172b29a9035e73c10739836a8af=
440","src/windows/msvc/mod.rs":"7bc0f1e7e73815296cd6b63b2700e12624e9f47b5c4=
113a1a87fae8e64549c00","src/xous.rs":"17b571c988119fe3f71dbcccfe722de5c772a=
bc3ca20dc4b09b58780980b78e9","tests/const_fn.rs":"8ac3171d7bced3576a4e93f48=
570b3e00c553d7510ab85a7473ae3b716a812dc"},"package":"b5aba8db14291edd000dfc=
c4d620c7ebfb122c613afb886ca8803fa4e128a20a"}
+diff --git a/vendor/libc-0.2.169/src/unix/linux_like/linux/arch/generic/mo=
d.rs b/vendor/libc-0.2.169/src/unix/linux_like/linux/arch/generic/mod.rs
+index 10953fe78..e9fd7fcce 100644
+--- a/vendor/libc-0.2.169/src/unix/linux_like/linux/arch/generic/mod.rs
++++ b/vendor/libc-0.2.169/src/unix/linux_like/linux/arch/generic/mod.rs
+@@ -122,6 +122,7 @@ cfg_if! {
+         target_arch =3D "x86_64",
+         target_arch =3D "arm",
+         target_arch =3D "aarch64",
++        target_arch =3D "riscv32",
+         target_arch =3D "riscv64",
+         target_arch =3D "s390x",
+         target_arch =3D "csky",
+@@ -258,7 +259,8 @@ cfg_if! {
+     if #[cfg(any(
+         target_arch =3D "x86",
+         target_arch =3D "arm",
+-        target_arch =3D "csky"
++        target_arch =3D "csky",
++        target_arch =3D "riscv32"
+     ))] {
+         pub const FS_IOC_GETFLAGS: Ioctl =3D 0x80046601;
+         pub const FS_IOC_SETFLAGS: Ioctl =3D 0x40046602;
diff --git a/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-fix.patc=
h b/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-fix.patch
deleted file mode 100644
index 451ab9c..0000000
--- a/recipes-devtools/rust/files/rv32-cargo-rustix-0.38.40-fix.patch
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
-
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
-
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
-diff --git a/vendor/rustix-0.38.40/src/termios/types.rs b/vendor/rustix-0.=
38.40/src/termios/types.rs
-index 7b97808a15..6f61e64ab9 100644
---- a/vendor/rustix-0.38.40/src/termios/types.rs
-+++ b/vendor/rustix-0.38.40/src/termios/types.rs
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
-diff --git a/vendor/rustix-0.38.40/src/fs/ioctl.rs b/vendor/rustix-0.38.40=
/src/fs/ioctl.rs
-index 718a2a4048..68ae13bea3 100644
---- a/vendor/rustix-0.38.40/src/fs/ioctl.rs
-+++ b/vendor/rustix-0.38.40/src/fs/ioctl.rs
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
-diff --git a/vendor/rustix-0.38.40/src/backend/libc/c.rs b/vendor/rustix-0=
.38.40/src/backend/libc/c.rs
-index ec140a3272..85c3d1c0c8 100644
---- a/vendor/rustix-0.38.40/src/backend/libc/c.rs
-+++ b/vendor/rustix-0.38.40/src/backend/libc/c.rs
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
-diff --git a/vendor/rustix-0.38.40/.cargo-checksum.json b/vendor/rustix-0.=
38.40/.cargo-checksum.json
-index 649a506966..7d30530f1e 100644
---- a/vendor/rustix-0.38.40/.cargo-checksum.json
-+++ b/vendor/rustix-0.38.40/.cargo-checksum.json
-@@ -1 +1 @@
--{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
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
-\ No newline at end of file
-+{"files":{"CODE_OF_CONDUCT.md":"f210602311e3f74b32f46237fd55f4ce36d798e85=
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
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index 86e1ede..ce01f9a 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -1,7 +1,7 @@
 RUST_VERSION ?=3D "${@d.getVar('PV').split('-')[0]}"
=20
 SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.=
tar.xz;name=3Drust \
-            file://rv32-cargo-rustix-0.38.40-fix.patch;patchdir=3D${RUSTSR=
C} \
+            file://0001-Define-more-ioctl-codes-on-riscv32gc-unknown-linux=
-g.patch;patchdir=3D${RUSTSRC} \
             file://rust-oe-selftest.patch;patchdir=3D${RUSTSRC} \
             file://repro-issue-fix-with-cc-crate-hashmap.patch;patchdir=3D=
${RUSTSRC} \
             file://oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.pa=
tch;patchdir=3D${RUSTSRC} \
--=20
2.49.0


