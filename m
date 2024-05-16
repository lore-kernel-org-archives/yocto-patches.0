Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3CEC25B79
	for <webhook@archiver.kernel.org>; Thu, 16 May 2024 09:25:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.8412.1715848989961571917
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 May 2024 01:43:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: gowtham.sureshkumar@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEEE6DA7;
	Thu, 16 May 2024 01:43:33 -0700 (PDT)
Received: from e126345.arm.com (unknown [10.57.65.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E8813F7A6;
	Thu, 16 May 2024 01:43:08 -0700 (PDT)
From: "Gowtham Suresh Kumar" <gowtham.sureshkumar@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Gowtham Suresh Kumar <gowtham.sureshkumar@arm.com>
Subject: [meta-parsec][master,scarthgap][PATCH] meta-parsec: Update parsec-service to 1.4.1
Date: Thu, 16 May 2024 09:42:28 +0100
Message-Id: <20240516084228.2056637-1-gowtham.sureshkumar@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 May 2024 09:25:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/159

Signed-off-by: Gowtham Suresh Kumar <gowtham.sureshkumar@arm.com>
---
 .../parsec-service/parsec-service-crates.inc  | 78 +++++++++++--------
 ...rvice_1.3.0.bb =3D> parsec-service_1.4.1.bb} |  2 +-
 2 files changed, 47 insertions(+), 33 deletions(-)
 rename meta-parsec/recipes-parsec/parsec-service/{parsec-service_1.3.0.b=
b =3D> parsec-service_1.4.1.bb} (97%)

diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service-cra=
tes.inc b/meta-parsec/recipes-parsec/parsec-service/parsec-service-crates=
.inc
index bf2c7d4..2677e3c 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service-crates.inc
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service-crates.inc
@@ -2,9 +2,14 @@
=20
 # from Cargo.lock
 SRC_URI +=3D " \
-    crate://crates.io/ahash/0.8.3 \
+    crate://crates.io/ahash/0.8.7 \
     crate://crates.io/aho-corasick/1.1.2 \
     crate://crates.io/allocator-api2/0.2.16 \
+    crate://crates.io/anstream/0.3.2 \
+    crate://crates.io/anstyle/1.0.2 \
+    crate://crates.io/anstyle-parse/0.2.1 \
+    crate://crates.io/anstyle-query/1.0.0 \
+    crate://crates.io/anstyle-wincon/1.0.2 \
     crate://crates.io/anyhow/1.0.75 \
     crate://crates.io/asn1-rs/0.3.1 \
     crate://crates.io/asn1-rs-derive/0.1.0 \
@@ -17,7 +22,7 @@ SRC_URI +=3D " \
     crate://crates.io/bindgen/0.66.1 \
     crate://crates.io/bitfield/0.14.0 \
     crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/bitflags/2.4.0 \
+    crate://crates.io/bitflags/2.4.1 \
     crate://crates.io/bumpalo/3.14.0 \
     crate://crates.io/bytes/1.5.0 \
     crate://crates.io/cc/1.0.83 \
@@ -25,8 +30,12 @@ SRC_URI +=3D " \
     crate://crates.io/cexpr/0.6.0 \
     crate://crates.io/cfg-if/1.0.0 \
     crate://crates.io/clang-sys/1.6.1 \
-    crate://crates.io/clap/2.34.0 \
+    crate://crates.io/clap/4.3.24 \
+    crate://crates.io/clap_builder/4.3.24 \
+    crate://crates.io/clap_derive/4.3.12 \
+    crate://crates.io/clap_lex/0.5.0 \
     crate://crates.io/cmake/0.1.45 \
+    crate://crates.io/colorchoice/1.0.0 \
     crate://crates.io/const-oid/0.7.1 \
     crate://crates.io/cryptoauthlib-sys/0.2.2 \
     crate://crates.io/cryptoki/0.6.0 \
@@ -34,7 +43,6 @@ SRC_URI +=3D " \
     crate://crates.io/data-encoding/2.4.0 \
     crate://crates.io/der/0.5.1 \
     crate://crates.io/der-parser/7.0.0 \
-    crate://crates.io/deranged/0.3.8 \
     crate://crates.io/derivative/2.2.0 \
     crate://crates.io/displaydoc/0.2.4 \
     crate://crates.io/either/1.9.0 \
@@ -58,13 +66,14 @@ SRC_URI +=3D " \
     crate://crates.io/futures-task/0.3.28 \
     crate://crates.io/futures-util/0.3.28 \
     crate://crates.io/generic-array/0.14.7 \
-    crate://crates.io/getrandom/0.2.10 \
+    crate://crates.io/getrandom/0.2.12 \
     crate://crates.io/glob/0.3.1 \
     crate://crates.io/grpcio/0.9.1 \
     crate://crates.io/grpcio-sys/0.9.1+1.38.0 \
     crate://crates.io/hashbrown/0.14.1 \
     crate://crates.io/hashlink/0.8.4 \
     crate://crates.io/heck/0.3.3 \
+    crate://crates.io/heck/0.4.1 \
     crate://crates.io/hermit-abi/0.3.3 \
     crate://crates.io/hex/0.4.3 \
     crate://crates.io/home/0.5.5 \
@@ -124,8 +133,6 @@ SRC_URI +=3D " \
     crate://crates.io/pkg-config/0.3.27 \
     crate://crates.io/ppv-lite86/0.2.17 \
     crate://crates.io/prettyplease/0.2.15 \
-    crate://crates.io/proc-macro-error/1.0.4 \
-    crate://crates.io/proc-macro-error-attr/1.0.4 \
     crate://crates.io/proc-macro2/1.0.69 \
     crate://crates.io/prost/0.9.0 \
     crate://crates.io/prost-build/0.9.0 \
@@ -149,7 +156,7 @@ SRC_URI +=3D " \
     crate://crates.io/rustc-hash/1.1.0 \
     crate://crates.io/rustc_version/0.3.3 \
     crate://crates.io/rusticata-macros/4.1.0 \
-    crate://crates.io/rustix/0.38.18 \
+    crate://crates.io/rustix/0.38.21 \
     crate://crates.io/ryu/1.0.15 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/scopeguard/1.2.0 \
@@ -173,8 +180,7 @@ SRC_URI +=3D " \
     crate://crates.io/spin/0.5.2 \
     crate://crates.io/spki/0.5.4 \
     crate://crates.io/stable_deref_trait/1.2.0 \
-    crate://crates.io/structopt/0.3.26 \
-    crate://crates.io/structopt-derive/0.4.18 \
+    crate://crates.io/strsim/0.10.0 \
     crate://crates.io/strum_macros/0.21.1 \
     crate://crates.io/syn/1.0.109 \
     crate://crates.io/syn/2.0.38 \
@@ -182,19 +188,18 @@ SRC_URI +=3D " \
     crate://crates.io/target-lexicon/0.12.11 \
     crate://crates.io/tempfile/3.8.0 \
     crate://crates.io/termcolor/1.3.0 \
-    crate://crates.io/textwrap/0.11.0 \
     crate://crates.io/thiserror/1.0.49 \
     crate://crates.io/thiserror-impl/1.0.49 \
     crate://crates.io/threadpool/1.8.1 \
-    crate://crates.io/time/0.3.29 \
-    crate://crates.io/time-core/0.1.2 \
-    crate://crates.io/time-macros/0.2.15 \
+    crate://crates.io/time/0.3.23 \
+    crate://crates.io/time-core/0.1.1 \
+    crate://crates.io/time-macros/0.2.10 \
     crate://crates.io/tinyvec/1.6.0 \
     crate://crates.io/tinyvec_macros/0.1.1 \
     crate://crates.io/toml/0.8.2 \
     crate://crates.io/toml_datetime/0.6.3 \
     crate://crates.io/toml_edit/0.20.2 \
-    crate://crates.io/tss-esapi/7.4.0 \
+    crate://crates.io/tss-esapi/7.5.0 \
     crate://crates.io/tss-esapi-sys/0.5.0 \
     crate://crates.io/typenum/1.17.0 \
     crate://crates.io/ucd-trie/0.1.6 \
@@ -202,10 +207,10 @@ SRC_URI +=3D " \
     crate://crates.io/unicode-ident/1.0.12 \
     crate://crates.io/unicode-normalization/0.1.22 \
     crate://crates.io/unicode-segmentation/1.10.1 \
-    crate://crates.io/unicode-width/0.1.11 \
     crate://crates.io/unicode-xid/0.2.4 \
     crate://crates.io/untrusted/0.7.1 \
     crate://crates.io/url/2.4.1 \
+    crate://crates.io/utf8parse/0.2.1 \
     crate://crates.io/uuid/0.8.2 \
     crate://crates.io/vcpkg/0.2.15 \
     crate://crates.io/version_check/0.9.4 \
@@ -234,13 +239,20 @@ SRC_URI +=3D " \
     crate://crates.io/winnow/0.5.16 \
     crate://crates.io/x509-parser/0.13.2 \
     crate://crates.io/yasna/0.4.0 \
+    crate://crates.io/zerocopy/0.7.32 \
+    crate://crates.io/zerocopy-derive/0.7.32 \
     crate://crates.io/zeroize/1.6.0 \
     crate://crates.io/zeroize_derive/1.4.2 \
 "
=20
-SRC_URI[ahash-0.8.3.sha256sum] =3D "2c99f64d1e06488f620f932677e24bc6e289=
7582980441ae90a671415bd7ec2f"
+SRC_URI[ahash-0.8.7.sha256sum] =3D "77c3a9648d43b9cd48db467b3f87fdd6e146=
bcc88ab0180006cef2179fe11d01"
 SRC_URI[aho-corasick-1.1.2.sha256sum] =3D "b2969dcb958b36655471fc61f7e41=
6fa76033bdd4bfed0678d8fee1e2d07a1f0"
 SRC_URI[allocator-api2-0.2.16.sha256sum] =3D "0942ffc6dcaadf03badf6e6a2d=
0228460359d5e34b57ccdc720b7382dfbd5ec5"
+SRC_URI[anstream-0.3.2.sha256sum] =3D "0ca84f3628370c59db74ee214b3263d58=
f9aadd9b4fe7e711fd87dc452b7f163"
+SRC_URI[anstyle-1.0.2.sha256sum] =3D "15c4c2c83f81532e5845a733998b6971fa=
ca23490340a418e9b72a3ec9de12ea"
+SRC_URI[anstyle-parse-0.2.1.sha256sum] =3D "938874ff5980b03a87c5524b3ae5=
b59cf99b1d6bc836848df7bc5ada9643c333"
+SRC_URI[anstyle-query-1.0.0.sha256sum] =3D "5ca11d4be1bab0c8bc8734a9aa7b=
f4ee8316d462a08c6ac5052f888fef5b494b"
+SRC_URI[anstyle-wincon-1.0.2.sha256sum] =3D "c677ab05e09154296dd37acecd4=
6420c17b9713e8366facafa8fc0885167cf4c"
 SRC_URI[anyhow-1.0.75.sha256sum] =3D "a4668cab20f66d8d020e1fbc0ebe472174=
33c1b6c8f2040faf858554e394ace6"
 SRC_URI[asn1-rs-0.3.1.sha256sum] =3D "30ff05a702273012438132f449575dbc80=
4e27b2f3cbe3069aa237d26c98fa33"
 SRC_URI[asn1-rs-derive-0.1.0.sha256sum] =3D "db8b7511298d5b7784b40b092d9=
e9dcd3a627a5707e4b5e507931ab0d44eeebf"
@@ -253,7 +265,7 @@ SRC_URI[bindgen-0.57.0.sha256sum] =3D "fd4865004a46a0=
aafb2a0a5eb19d3c9fc46ee5f063a
 SRC_URI[bindgen-0.66.1.sha256sum] =3D "f2b84e06fc203107bfbad243f4aba2af8=
64eb7db3b1cf46ea0a023b0b433d2a7"
 SRC_URI[bitfield-0.14.0.sha256sum] =3D "2d7e60934ceec538daadb9d8432424ed=
043a904d8e0243f3c6446bce549a46ac"
 SRC_URI[bitflags-1.3.2.sha256sum] =3D "bef38d45163c2f1dde094a7dfd33ccf59=
5c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[bitflags-2.4.0.sha256sum] =3D "b4682ae6287fcf752ecaabbfcc7b6f9b7=
2aa33933dc23a554d853aea8eea8635"
+SRC_URI[bitflags-2.4.1.sha256sum] =3D "327762f6e5a765692301e5bb513e0d9fe=
f63be86bbc14528052b1cd3e6f03e07"
 SRC_URI[bumpalo-3.14.0.sha256sum] =3D "7f30e7476521f6f8af1a1c4c0b8cc94f0=
bee37d91763d0ca2665f299b6cd8aec"
 SRC_URI[bytes-1.5.0.sha256sum] =3D "a2bd12c1caf447e69cd4528f47f94d203fd2=
582878ecb9e9465484c4148a8223"
 SRC_URI[cc-1.0.83.sha256sum] =3D "f1174fb0b6ec23863f8b971027804a42614e34=
7eafb0a95bf0b12cdae21fc4d0"
@@ -261,8 +273,12 @@ SRC_URI[cexpr-0.4.0.sha256sum] =3D "f4aedb84272dbe89=
af497cf81375129abda4fc0a9e7c5d
 SRC_URI[cexpr-0.6.0.sha256sum] =3D "6fac387a98bb7c37292057cffc56d62ecb62=
9900026402633ae9160df93a8766"
 SRC_URI[cfg-if-1.0.0.sha256sum] =3D "baf1de4339761588bc0619e3cbc0120ee58=
2ebb74b53b4efbf79117bd2da40fd"
 SRC_URI[clang-sys-1.6.1.sha256sum] =3D "c688fc74432808e3eb684cae8830a86b=
e1d66a2bd58e1f248ed0960a590baf6f"
-SRC_URI[clap-2.34.0.sha256sum] =3D "a0610544180c38b88101fecf2dd634b174a6=
2eef6946f84dfc6a7127512b381c"
+SRC_URI[clap-4.3.24.sha256sum] =3D "fb690e81c7840c0d7aade59f242ea3b41b9b=
c27bcd5997890e7702ae4b32e487"
+SRC_URI[clap_builder-4.3.24.sha256sum] =3D "5ed2e96bc16d8d740f6f48d663ed=
df4b8a0983e79210fd55479b7bcd0a69860e"
+SRC_URI[clap_derive-4.3.12.sha256sum] =3D "54a9bb5758fc5dfe728d101994168=
1eccaf0cf8a4189b692a0ee2f2ecf90a050"
+SRC_URI[clap_lex-0.5.0.sha256sum] =3D "2da6da31387c7e4ef160ffab6d5e7f00c=
42626fe39aea70a7b0f1773f7dd6c1b"
 SRC_URI[cmake-0.1.45.sha256sum] =3D "eb6210b637171dfba4cda12e579ac6dc73f=
5165ad56133e5d72ef3131f320855"
+SRC_URI[colorchoice-1.0.0.sha256sum] =3D "acbf1af155f9b9ef647e42cdc158db=
4b64a1b61f743629225fde6f3e0be2a7c7"
 SRC_URI[const-oid-0.7.1.sha256sum] =3D "e4c78c047431fee22c1a7bb92e00ad09=
5a02a983affe4d8a72e2a2c62c1b94f3"
 SRC_URI[cryptoauthlib-sys-0.2.2.sha256sum] =3D "da232dd4f06ee4600b33a455=
bb17fcc6c2c3a54ee7fd60496d3a73668a6cb6e4"
 SRC_URI[cryptoki-0.6.0.sha256sum] =3D "e08651cefd925cd83d8d1b4f96276c18f=
e5ee148ab8c8a47f462316d36bc01af"
@@ -270,7 +286,6 @@ SRC_URI[cryptoki-sys-0.1.7.sha256sum] =3D "7a978e5e22=
6446ac68eded4f92796947130f0d2
 SRC_URI[data-encoding-2.4.0.sha256sum] =3D "c2e66c9d817f1720209181c316d2=
8635c050fa304f9c79e47a520882661b7308"
 SRC_URI[der-0.5.1.sha256sum] =3D "6919815d73839e7ad218de758883aae3a257ba=
6759ce7a9992501efbb53d705c"
 SRC_URI[der-parser-7.0.0.sha256sum] =3D "fe398ac75057914d7d07307bf67dc7f=
3f574a26783b4fc7805a20ffa9f506e82"
-SRC_URI[deranged-0.3.8.sha256sum] =3D "f2696e8a945f658fd14dc3b87242e6b80=
cd0f36ff04ea560fa39082368847946"
 SRC_URI[derivative-2.2.0.sha256sum] =3D "fcc3dd5e9e9c0b295d6e1e4d811fb6f=
157d5ffd784b8d202fc62eac8035a770b"
 SRC_URI[displaydoc-0.2.4.sha256sum] =3D "487585f4d0c6655fe74905e2504d8ad=
6908e4db67f744eb140876906c2f3175d"
 SRC_URI[either-1.9.0.sha256sum] =3D "a26ae43d7bcc3b814de94796a5e736d4029=
efb0ee900c12e2d54c993ad1a1e07"
@@ -294,13 +309,14 @@ SRC_URI[futures-sink-0.3.28.sha256sum] =3D "f43be4f=
e21a13b9781a69afa4985b0f6ee0e1a
 SRC_URI[futures-task-0.3.28.sha256sum] =3D "76d3d132be6c0e6aa1534069c705=
a74a5997a356c0dc2f86a47765e5617c5b65"
 SRC_URI[futures-util-0.3.28.sha256sum] =3D "26b01e40b772d54cf6c6d721c1d1=
abd0647a0106a12ecaa1c186273392a69533"
 SRC_URI[generic-array-0.14.7.sha256sum] =3D "85649ca51fd72272d7821adaf27=
4ad91c288277713d9c18820d8499a7ff69e9a"
-SRC_URI[getrandom-0.2.10.sha256sum] =3D "be4136b2a15dd319360be1c07d99335=
17ccf0be8f16bf62a3bee4f0d618df427"
+SRC_URI[getrandom-0.2.12.sha256sum] =3D "190092ea657667030ac6a35e305e62f=
c4dd69fd98ac98631e5d3a2b1575a12b5"
 SRC_URI[glob-0.3.1.sha256sum] =3D "d2fabcfbdc87f4758337ca535fb41a6d701b6=
5693ce38287d856d1674551ec9b"
 SRC_URI[grpcio-0.9.1.sha256sum] =3D "24d99e00eed7e0a04ee2705112e7cfdbe1a=
3cc771147f22f016a8cd2d002187b"
 SRC_URI[grpcio-sys-0.9.1+1.38.0.sha256sum] =3D "9447d1a926beeef466606cc4=
5717f80897998b548e7dc622873d453e1ecb4be4"
 SRC_URI[hashbrown-0.14.1.sha256sum] =3D "7dfda62a12f55daeae5015f81b0baea=
145391cb4520f86c248fc615d72640d12"
 SRC_URI[hashlink-0.8.4.sha256sum] =3D "e8094feaf31ff591f651a2664fb9cfd92=
bba7a60ce3197265e9482ebe753c8f7"
 SRC_URI[heck-0.3.3.sha256sum] =3D "6d621efb26863f0e9924c6ac577e8275e5e6b=
77455db64ffa6c65c904e9e132c"
+SRC_URI[heck-0.4.1.sha256sum] =3D "95505c38b4572b2d910cecb0281560f54b440=
a19336cbbcb27bf6ce6adc6f5a8"
 SRC_URI[hermit-abi-0.3.3.sha256sum] =3D "d77f7ec81a6d05a3abb01ab6eb7590f=
6083d08449fe5a1c8b1e620283546ccb7"
 SRC_URI[hex-0.4.3.sha256sum] =3D "7f24254aa9a54b5c858eaee2f5bccdb46aaf0e=
486a595ed5fd8f86ba55232a70"
 SRC_URI[home-0.5.5.sha256sum] =3D "5444c27eef6923071f7ebcc33e3444508466a=
76f7a2b93da00ed6e19f30c1ddb"
@@ -360,8 +376,6 @@ SRC_URI[pkcs8-0.8.0.sha256sum] =3D "7cabda3fb821068a9=
a4fab19a683eac3af12edf0f34b94
 SRC_URI[pkg-config-0.3.27.sha256sum] =3D "26072860ba924cbfa98ea39c8c19b4=
dd6a4a25423dbdf219c1eca91aa0cf6964"
 SRC_URI[ppv-lite86-0.2.17.sha256sum] =3D "5b40af805b3121feab8a3c29f04d8a=
d262fa8e0561883e7653e024ae4479e6de"
 SRC_URI[prettyplease-0.2.15.sha256sum] =3D "ae005bd773ab59b4725093fd7df8=
3fd7892f7d8eafb48dbd7de6e024e4215f9d"
-SRC_URI[proc-macro-error-1.0.4.sha256sum] =3D "da25490ff9892aab3fcf7c36f=
08cfb902dd3e71ca0f9f9517bea02a73a5ce38c"
-SRC_URI[proc-macro-error-attr-1.0.4.sha256sum] =3D "a1be40180e52ecc98ad8=
0b184934baf3d0d29f979574e439af5a55274b35f869"
 SRC_URI[proc-macro2-1.0.69.sha256sum] =3D "134c189feb4956b20f6f547d2cf72=
7d4c0fe06722b20a0eec87ed445a97f92da"
 SRC_URI[prost-0.9.0.sha256sum] =3D "444879275cb4fd84958b1a1d5420d15e6fcf=
7c235fe47f053c9c2a80aceb6001"
 SRC_URI[prost-build-0.9.0.sha256sum] =3D "62941722fb675d463659e49c4f3fe1=
fe792ff24fe5bbaa9c08cd3b98a1c354f5"
@@ -385,7 +399,7 @@ SRC_URI[rust-cryptoauthlib-0.4.5.sha256sum] =3D "adab=
07508c090715a5cd3d072f2b8ab60
 SRC_URI[rustc-hash-1.1.0.sha256sum] =3D "08d43f7aa6b08d49f382cde6a798204=
7c3426db949b1424bc4b7ec9ae12c6ce2"
 SRC_URI[rustc_version-0.3.3.sha256sum] =3D "f0dfe2087c51c460008730de8b57=
e6a320782fbfb312e1f4d520e6c6fae155ee"
 SRC_URI[rusticata-macros-4.1.0.sha256sum] =3D "faf0c4a6ece9950b9abdb62b1=
cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
-SRC_URI[rustix-0.38.18.sha256sum] =3D "5a74ee2d7c2581cd139b42447d7d9389b=
889bdaad3a73f1ebb16f2a3237bb19c"
+SRC_URI[rustix-0.38.21.sha256sum] =3D "2b426b0506e5d50a7d8dafcf2e8147140=
0deb602392c7dd110815afb4eaf02a3"
 SRC_URI[ryu-1.0.15.sha256sum] =3D "1ad4cc8da4ef723ed60bced201181d83791ad=
433213d8c24efffda1eec85d741"
 SRC_URI[same-file-1.0.6.sha256sum] =3D "93fc1dc3aaa9bfed95e02e6eadabb4ba=
f7e3078b0bd1b4d7b6b0b68378900502"
 SRC_URI[scopeguard-1.2.0.sha256sum] =3D "94143f37725109f92c262ed2cf5e59b=
ce7498c01bcc1502d7b9afe439a4e9f49"
@@ -409,8 +423,7 @@ SRC_URI[spiffe-0.2.1.sha256sum] =3D "f30161ecb25b9acc=
06eb61d750aaf1c4b3a536e22ff19
 SRC_URI[spin-0.5.2.sha256sum] =3D "6e63cff320ae2c57904679ba7cb63280a3dc4=
613885beafb148ee7bf9aa9042d"
 SRC_URI[spki-0.5.4.sha256sum] =3D "44d01ac02a6ccf3e07db148d2be087da624fe=
a0221a16152ed01f0496a6b0a27"
 SRC_URI[stable_deref_trait-1.2.0.sha256sum] =3D "a8f112729512f8e442d81f9=
5a8a7ddf2b7c6b8a1a6f509a95864142b30cab2d3"
-SRC_URI[structopt-0.3.26.sha256sum] =3D "0c6b5c64445ba8094a6ab0c3cd2ad32=
3e07171012d9c98b0b15651daf1787a10"
-SRC_URI[structopt-derive-0.4.18.sha256sum] =3D "dcb5ae327f9cc13b68763b57=
49770cb9e048a99bd9dfdfa58d0cf05d5f64afe0"
+SRC_URI[strsim-0.10.0.sha256sum] =3D "73473c0e59e6d5812c5dfe2a064a644494=
9f089e20eec9a2e5506596494e4623"
 SRC_URI[strum_macros-0.21.1.sha256sum] =3D "d06aaeeee809dbc59eb4556183dd=
927df67db1540de5be8d3ec0b6636358a5ec"
 SRC_URI[syn-1.0.109.sha256sum] =3D "72b64191b275b66ffe2469e8af2c1cfe3baf=
a67b529ead792a6d0160888b4237"
 SRC_URI[syn-2.0.38.sha256sum] =3D "e96b79aaa137db8f61e26363a0c9b47d8b4ec=
75da28b7d1d614c2303e232408b"
@@ -418,19 +431,18 @@ SRC_URI[synstructure-0.12.6.sha256sum] =3D "f36bdaa=
60a83aca3921b5259d5400cbf5e90fc
 SRC_URI[target-lexicon-0.12.11.sha256sum] =3D "9d0e916b1148c8e263850e1eb=
cbd046f333e0683c724876bb0da63ea4373dc8a"
 SRC_URI[tempfile-3.8.0.sha256sum] =3D "cb94d2f3cc536af71caac6b6fcebf6586=
0b347e7ce0cc9ebe8f70d3e521054ef"
 SRC_URI[termcolor-1.3.0.sha256sum] =3D "6093bad37da69aab9d123a8091e4be0a=
a4a03e4d601ec641c327398315f62b64"
-SRC_URI[textwrap-0.11.0.sha256sum] =3D "d326610f408c7a4eb6f51c37c330e496=
b08506c9457c9d34287ecc38809fb060"
 SRC_URI[thiserror-1.0.49.sha256sum] =3D "1177e8c6d7ede7afde3585fd2513e61=
1227efd6481bd78d2e82ba1ce16557ed4"
 SRC_URI[thiserror-impl-1.0.49.sha256sum] =3D "10712f02019e9288794769fba9=
5cd6847df9874d49d871d062172f9dd41bc4cc"
 SRC_URI[threadpool-1.8.1.sha256sum] =3D "d050e60b33d41c19108b32cea321640=
33a9013fe3b46cbd4457559bfbf77afaa"
-SRC_URI[time-0.3.29.sha256sum] =3D "426f806f4089c493dcac0d24c29c01e2c38b=
af8e30f1b716ee37e83d200b18fe"
-SRC_URI[time-core-0.1.2.sha256sum] =3D "ef927ca75afb808a4d64dd374f00a2ad=
f8d0fcff8e7b184af886c3c87ec4a3f3"
-SRC_URI[time-macros-0.2.15.sha256sum] =3D "4ad70d68dba9e1f8aceda7aa67119=
65dfec1cac869f311a51bd08b3a2ccbce20"
+SRC_URI[time-0.3.23.sha256sum] =3D "59e399c068f43a5d116fedaf73b203fa4f9c=
519f17e2b34f63221d3792f81446"
+SRC_URI[time-core-0.1.1.sha256sum] =3D "7300fbefb4dadc1af235a9cef3737cea=
692a9d97e1b9cbcd4ebdae6f8868e6fb"
+SRC_URI[time-macros-0.2.10.sha256sum] =3D "96ba15a897f3c86766b757e5ac722=
1554c6750054d74d5b28844fce5fb36a6c4"
 SRC_URI[tinyvec-1.6.0.sha256sum] =3D "87cc5ceb3875bb20c2890005a4e226a465=
1264a5c75edb2421b52861a0a0cb50"
 SRC_URI[tinyvec_macros-0.1.1.sha256sum] =3D "1f3ccbac311fea05f86f61904b4=
62b55fb3df8837a366dfc601a0161d0532f20"
 SRC_URI[toml-0.8.2.sha256sum] =3D "185d8ab0dfbb35cf1399a6344d8484209c088=
f75f8f68230da55d48d95d43e3d"
 SRC_URI[toml_datetime-0.6.3.sha256sum] =3D "7cda73e2f1397b1262d6dfdcef8a=
afae14d1de7748d66822d3bfeeb6d03e5e4b"
 SRC_URI[toml_edit-0.20.2.sha256sum] =3D "396e4d48bbb2b7554c944bde63101b5=
ae446cff6ec4a24227428f15eb72ef338"
-SRC_URI[tss-esapi-7.4.0.sha256sum] =3D "de234df360c349f78ecd33f0816ab384=
2db635732212b5cfad67f2638336864e"
+SRC_URI[tss-esapi-7.5.0.sha256sum] =3D "d36722a0888ff29225d11ea205f10319=
d6cb4d072ef3c91bf3509f7f476d89e3"
 SRC_URI[tss-esapi-sys-0.5.0.sha256sum] =3D "535cd192581c2ec4d5f82e670b1d=
3fbba6a23ccce8c85de387642051d7cad5b5"
 SRC_URI[typenum-1.17.0.sha256sum] =3D "42ff0bf0c66b8238c6f3b578df37d0b78=
48e55df8577b3f74f92a69acceeb825"
 SRC_URI[ucd-trie-0.1.6.sha256sum] =3D "ed646292ffc8188ef8ea4d1e0e0150fb1=
5a5c2e12ad9b8fc191ae7a8a7f3c4b9"
@@ -438,10 +450,10 @@ SRC_URI[unicode-bidi-0.3.13.sha256sum] =3D "92888ba=
5573ff080736b3648696b70cafad7d2
 SRC_URI[unicode-ident-1.0.12.sha256sum] =3D "3354b9ac3fae1ff6755cb6db536=
83adb661634f67557942dea4facebec0fee4b"
 SRC_URI[unicode-normalization-0.1.22.sha256sum] =3D "5c5713f0fc4b5db668a=
2ac63cdb7bb4469d8c9fed047b1d0292cc7b0ce2ba921"
 SRC_URI[unicode-segmentation-1.10.1.sha256sum] =3D "1dd62409856789511888=
6609431a7c3b8f516e41d30e0643f03d94592a147e36"
-SRC_URI[unicode-width-0.1.11.sha256sum] =3D "e51733f11c9c4f72aa0c1600082=
46859e340b00807569a0da0e7a1079b27ba85"
 SRC_URI[unicode-xid-0.2.4.sha256sum] =3D "f962df74c8c05a667b5ee8bcf16299=
3134c104e96440b663c8daa176dc772d8c"
 SRC_URI[untrusted-0.7.1.sha256sum] =3D "a156c684c91ea7d62626509bce3cb4e1=
d9ed5c4d978f7b4352658f96a4c26b4a"
 SRC_URI[url-2.4.1.sha256sum] =3D "143b538f18257fac9cad154828a57c6bf5157e=
1aa604d4816b5995bf6de87ae5"
+SRC_URI[utf8parse-0.2.1.sha256sum] =3D "711b9620af191e0cdc7468a8d14e709c=
3dcdb115b36f838e601583af800a370a"
 SRC_URI[uuid-0.8.2.sha256sum] =3D "bc5cf98d8186244414c848017f0e2676b3fcb=
46807f6668a97dfe67359a3c4b7"
 SRC_URI[vcpkg-0.2.15.sha256sum] =3D "accd4ea62f7bb7a82fe23066fb0957d48ef=
677f6eeb8215f372f52e48bb32426"
 SRC_URI[version_check-0.9.4.sha256sum] =3D "49874b5167b65d7193b8aba1567f=
5c7d93d001cafc34600cee003eda787e483f"
@@ -470,5 +482,7 @@ SRC_URI[windows_x86_64_msvc-0.48.5.sha256sum] =3D "ed=
94fce61571a4006852b7389a063ab
 SRC_URI[winnow-0.5.16.sha256sum] =3D "037711d82167854aff2018dfd193aa0fef=
5370f456732f0d5a0c59b0f1b4b907"
 SRC_URI[x509-parser-0.13.2.sha256sum] =3D "9fb9bace5b5589ffead1afb76e43e=
34cff39cd0f3ce7e170ae0c29e53b88eb1c"
 SRC_URI[yasna-0.4.0.sha256sum] =3D "e262a29d0e61ccf2b6190d7050d4b237535f=
c76ce4c1210d9caa316f71dffa75"
+SRC_URI[zerocopy-0.7.32.sha256sum] =3D "74d4d3961e53fa4c9a25a8637fc2bfaf=
2595b3d3ae34875568a5cf64787716be"
+SRC_URI[zerocopy-derive-0.7.32.sha256sum] =3D "9ce1b18ccd8e73a9321186f97=
e46f9f04b778851177567b1975109d26a08d2a6"
 SRC_URI[zeroize-1.6.0.sha256sum] =3D "2a0956f1ba7c7909bfb66c2e9e4124ab6f=
6482560f6628b5aaeba39207c9aad9"
 SRC_URI[zeroize_derive-1.4.2.sha256sum] =3D "ce36e65b0d2999d2aafac989fb2=
49189a141aee1f53c612c1f37d72631959f69"
diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.3=
.0.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
similarity index 97%
rename from meta-parsec/recipes-parsec/parsec-service/parsec-service_1.3.=
0.bb
rename to meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.=
bb
index 477988e..2d55c24 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.3.0.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
@@ -12,7 +12,7 @@ SRC_URI +=3D "crate://crates.io/parsec-service/${PV} \
             file://systemd.patch \
             file://parsec-tmpfiles.conf \
 "
-SRC_URI[parsec-service-1.3.0.sha256sum] =3D "6e171f6394f900e0356947fb7ee=
42f825fba7ad8cada44b520b4bec5f1c853c8"
+SRC_URI[parsec-service-1.4.1.sha256sum] =3D "06ad906fb13d6844ad676d4203a=
1096ae4efc87fe1abcea0481c507df56d8c98"
=20
 B =3D "${CARGO_VENDORING_DIRECTORY}/${BP}"
=20
--=20
2.25.1


