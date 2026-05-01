Return-Path: <anton.antonov@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7918CD3423
	for <webhook@archiver.kernel.org>; Fri,  1 May 2026 15:24:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17090.1777649081848222590
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 01 May 2026 08:24:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=V98qg8hL;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: anton.antonov@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C71C72A9A;
	Fri,  1 May 2026 08:24:35 -0700 (PDT)
Received: from acsubuntu.. (unknown [10.57.22.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DD7B3F62B;
	Fri,  1 May 2026 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777649081; bh=V1YmOMC7QeUz0IIJcyIMmgbxqUvsEWyny4MuLHdT5LI=;
	h=From:To:Cc:Subject:Date:From;
	b=V98qg8hLlJzb/fMGzeYeGkqnBj7iJnud1Xmm+q4c/e41wnADe3zZF0V5n1rkgQX5O
	 0ahri8fKNFAQhejP02IcbPPOAGvc+AD8PcTTWKMG7R/uKw8qf9HKvlTWabeR0MdPH1
	 IAjhGveR5r1xIorbaAKUsKUcqSw71xcMRZmvLBgo=
From: Anton Antonov <Anton.Antonov@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Anton Antonov <Anton.Antonov@arm.com>
Subject: [meta-security][meta-parsec][PATCH] Update Parsec service version.
Date: Fri,  1 May 2026 15:24:30 +0000
Message-ID: <20260501152432.1207912-1-Anton.Antonov@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 01 May 2026 15:24:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3896

This update adds compatibility with clang 22.1 in oe-core.

Signed-off-by: Anton Antonov <Anton.Antonov@arm.com>
---
 ...Fix-unnecessary-qualifications-error.patch |  50 -
 .../parsec-service/parsec-service-crates.inc  | 868 ++++++++++--------
 ...rvice_1.4.1.bb =3D> parsec-service_1.5.0.bb} |  12 +-
 3 files changed, 499 insertions(+), 431 deletions(-)
 delete mode 100644 meta-parsec/recipes-parsec/parsec-service/files/0002-=
Fix-unnecessary-qualifications-error.patch
 rename meta-parsec/recipes-parsec/parsec-service/{parsec-service_1.4.1.b=
b =3D> parsec-service_1.5.0.bb} (86%)

diff --git a/meta-parsec/recipes-parsec/parsec-service/files/0002-Fix-unn=
ecessary-qualifications-error.patch b/meta-parsec/recipes-parsec/parsec-s=
ervice/files/0002-Fix-unnecessary-qualifications-error.patch
deleted file mode 100644
index cef6bd8..0000000
--- a/meta-parsec/recipes-parsec/parsec-service/files/0002-Fix-unnecessar=
y-qualifications-error.patch
+++ /dev/null
@@ -1,50 +0,0 @@
-From 86d4d2ca2f1e873a29f9f4d4bba99fedee19a144 Mon Sep 17 00:00:00 2001
-From: Gowtham Suresh Kumar <gowtham.sureshkumar@arm.com>
-Date: Thu, 29 Aug 2024 17:10:06 +0100
-Subject: [PATCH 2/4] Fix unnecessary qualifications error
-
-Signed-off-by: Gowtham Suresh Kumar <gowtham.sureshkumar@arm.com>
-
-Upstream-Status: Backport
-Signed-off-by: Armin Kuster <akuster808@gmail.com>
-
----
- src/front/domain_socket.rs | 9 +++++----
- 1 file changed, 5 insertions(+), 4 deletions(-)
-
-diff --git a/src/front/domain_socket.rs b/src/front/domain_socket.rs
-index 9fb8a0c..a0effa5 100644
---- a/src/front/domain_socket.rs
-+++ b/src/front/domain_socket.rs
-@@ -239,15 +239,16 @@ pub mod peer_credentials {
-     pub mod impl_linux {
-         use super::UCred;
-         use libc::{c_void, getsockopt, socklen_t, ucred, SOL_SOCKET, SO=
_PEERCRED};
-+        use std::io;
-+        use std::mem::size_of;
-         use std::os::unix::io::AsRawFd;
-         use std::os::unix::net::UnixStream;
--        use std::{io, mem};
-=20
-         pub fn peer_cred(socket: &UnixStream) -> io::Result<UCred> {
--            let ucred_size =3D mem::size_of::<ucred>();
-+            let ucred_size =3D size_of::<ucred>();
-=20
-             // Trivial sanity checks.
--            assert!(mem::size_of::<u32>() <=3D mem::size_of::<usize>())=
;
-+            assert!(size_of::<u32>() <=3D size_of::<usize>());
-             assert!(ucred_size <=3D u32::MAX as usize);
-=20
-             let mut ucred_size =3D ucred_size as socklen_t;
-@@ -266,7 +267,7 @@ pub mod peer_credentials {
-                     &mut ucred_size,
-                 );
-=20
--                if ret =3D=3D 0 && ucred_size as usize =3D=3D mem::size=
_of::<ucred>() {
-+                if ret =3D=3D 0 && ucred_size as usize =3D=3D size_of::=
<ucred>() {
-                     Ok(UCred {
-                         uid: ucred.uid,
-                         gid: ucred.gid,
---=20
-2.43.0
-
diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service-cra=
tes.inc b/meta-parsec/recipes-parsec/parsec-service/parsec-service-crates=
.inc
index 2677e3c..c1665c0 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service-crates.inc
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service-crates.inc
@@ -2,487 +2,607 @@
=20
 # from Cargo.lock
 SRC_URI +=3D " \
-    crate://crates.io/ahash/0.8.7 \
-    crate://crates.io/aho-corasick/1.1.2 \
-    crate://crates.io/allocator-api2/0.2.16 \
-    crate://crates.io/anstream/0.3.2 \
-    crate://crates.io/anstyle/1.0.2 \
-    crate://crates.io/anstyle-parse/0.2.1 \
-    crate://crates.io/anstyle-query/1.0.0 \
-    crate://crates.io/anstyle-wincon/1.0.2 \
-    crate://crates.io/anyhow/1.0.75 \
-    crate://crates.io/asn1-rs/0.3.1 \
-    crate://crates.io/asn1-rs-derive/0.1.0 \
+    crate://crates.io/ahash/0.8.12 \
+    crate://crates.io/aho-corasick/1.1.4 \
+    crate://crates.io/allocator-api2/0.2.21 \
+    crate://crates.io/ansi_term/0.12.1 \
+    crate://crates.io/anstream/1.0.0 \
+    crate://crates.io/anstyle/1.0.14 \
+    crate://crates.io/anstyle-parse/1.0.0 \
+    crate://crates.io/anstyle-query/1.1.5 \
+    crate://crates.io/anstyle-wincon/3.0.11 \
+    crate://crates.io/anyhow/1.0.102 \
+    crate://crates.io/asn1-rs/0.5.2 \
+    crate://crates.io/asn1-rs-derive/0.4.0 \
     crate://crates.io/asn1-rs-impl/0.1.0 \
-    crate://crates.io/autocfg/1.1.0 \
+    crate://crates.io/atty/0.2.14 \
+    crate://crates.io/autocfg/1.5.0 \
     crate://crates.io/base64/0.13.1 \
-    crate://crates.io/base64/0.21.4 \
+    crate://crates.io/base64/0.21.7 \
+    crate://crates.io/base64/0.22.1 \
     crate://crates.io/bincode/1.3.3 \
-    crate://crates.io/bindgen/0.57.0 \
-    crate://crates.io/bindgen/0.66.1 \
-    crate://crates.io/bitfield/0.14.0 \
+    crate://crates.io/bindgen/0.59.2 \
+    crate://crates.io/bindgen/0.72.1 \
+    crate://crates.io/bitfield/0.19.4 \
+    crate://crates.io/bitfield-macros/0.19.4 \
     crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/bitflags/2.4.1 \
-    crate://crates.io/bumpalo/3.14.0 \
-    crate://crates.io/bytes/1.5.0 \
-    crate://crates.io/cc/1.0.83 \
-    crate://crates.io/cexpr/0.4.0 \
+    crate://crates.io/bitflags/2.11.1 \
+    crate://crates.io/bumpalo/3.20.2 \
+    crate://crates.io/bytes/1.11.1 \
+    crate://crates.io/cc/1.2.61 \
     crate://crates.io/cexpr/0.6.0 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/clang-sys/1.6.1 \
-    crate://crates.io/clap/4.3.24 \
-    crate://crates.io/clap_builder/4.3.24 \
-    crate://crates.io/clap_derive/4.3.12 \
-    crate://crates.io/clap_lex/0.5.0 \
+    crate://crates.io/cfg-if/1.0.4 \
+    crate://crates.io/clang-sys/1.8.1 \
+    crate://crates.io/clap/2.34.0 \
+    crate://crates.io/clap/4.6.1 \
+    crate://crates.io/clap_builder/4.6.0 \
+    crate://crates.io/clap_derive/4.6.1 \
+    crate://crates.io/clap_lex/1.1.0 \
     crate://crates.io/cmake/0.1.45 \
-    crate://crates.io/colorchoice/1.0.0 \
-    crate://crates.io/const-oid/0.7.1 \
+    crate://crates.io/colorchoice/1.0.5 \
+    crate://crates.io/const-oid/0.9.6 \
     crate://crates.io/cryptoauthlib-sys/0.2.2 \
-    crate://crates.io/cryptoki/0.6.0 \
-    crate://crates.io/cryptoki-sys/0.1.7 \
-    crate://crates.io/data-encoding/2.4.0 \
-    crate://crates.io/der/0.5.1 \
-    crate://crates.io/der-parser/7.0.0 \
+    crate://crates.io/cryptoki/0.12.0 \
+    crate://crates.io/cryptoki-sys/0.5.0 \
+    crate://crates.io/data-encoding/2.11.0 \
+    crate://crates.io/der/0.7.10 \
+    crate://crates.io/der-parser/8.2.0 \
+    crate://crates.io/deranged/0.5.8 \
     crate://crates.io/derivative/2.2.0 \
-    crate://crates.io/displaydoc/0.2.4 \
-    crate://crates.io/either/1.9.0 \
-    crate://crates.io/enumflags2/0.7.8 \
-    crate://crates.io/enumflags2_derive/0.7.8 \
-    crate://crates.io/env_logger/0.10.0 \
-    crate://crates.io/equivalent/1.0.1 \
-    crate://crates.io/errno/0.3.5 \
+    crate://crates.io/displaydoc/0.2.5 \
+    crate://crates.io/either/1.15.0 \
+    crate://crates.io/enumflags2/0.7.12 \
+    crate://crates.io/enumflags2_derive/0.7.12 \
+    crate://crates.io/env_filter/1.0.1 \
+    crate://crates.io/env_logger/0.9.3 \
+    crate://crates.io/env_logger/0.11.10 \
+    crate://crates.io/equivalent/1.0.2 \
+    crate://crates.io/errno/0.3.14 \
     crate://crates.io/fallible-iterator/0.2.0 \
     crate://crates.io/fallible-streaming-iterator/0.1.9 \
-    crate://crates.io/fastrand/2.0.1 \
+    crate://crates.io/fastrand/2.4.1 \
+    crate://crates.io/find-msvc-tools/0.1.9 \
     crate://crates.io/fixedbitset/0.4.2 \
-    crate://crates.io/form_urlencoded/1.2.0 \
-    crate://crates.io/futures/0.3.28 \
-    crate://crates.io/futures-channel/0.3.28 \
-    crate://crates.io/futures-core/0.3.28 \
-    crate://crates.io/futures-executor/0.3.28 \
-    crate://crates.io/futures-io/0.3.28 \
-    crate://crates.io/futures-macro/0.3.28 \
-    crate://crates.io/futures-sink/0.3.28 \
-    crate://crates.io/futures-task/0.3.28 \
-    crate://crates.io/futures-util/0.3.28 \
-    crate://crates.io/generic-array/0.14.7 \
-    crate://crates.io/getrandom/0.2.12 \
-    crate://crates.io/glob/0.3.1 \
-    crate://crates.io/grpcio/0.9.1 \
-    crate://crates.io/grpcio-sys/0.9.1+1.38.0 \
-    crate://crates.io/hashbrown/0.14.1 \
+    crate://crates.io/foldhash/0.1.5 \
+    crate://crates.io/form_urlencoded/1.2.2 \
+    crate://crates.io/futures/0.3.32 \
+    crate://crates.io/futures-channel/0.3.32 \
+    crate://crates.io/futures-core/0.3.32 \
+    crate://crates.io/futures-executor/0.3.32 \
+    crate://crates.io/futures-io/0.3.32 \
+    crate://crates.io/futures-macro/0.3.32 \
+    crate://crates.io/futures-sink/0.3.32 \
+    crate://crates.io/futures-task/0.3.32 \
+    crate://crates.io/futures-util/0.3.32 \
+    crate://crates.io/generic-array/0.14.9 \
+    crate://crates.io/getrandom/0.2.17 \
+    crate://crates.io/getrandom/0.4.2 \
+    crate://crates.io/glob/0.3.3 \
+    crate://crates.io/grpcio/0.12.1 \
+    crate://crates.io/grpcio-sys/0.12.1+1.46.5-patched \
+    crate://crates.io/hashbrown/0.14.5 \
+    crate://crates.io/hashbrown/0.15.5 \
+    crate://crates.io/hashbrown/0.17.0 \
     crate://crates.io/hashlink/0.8.4 \
     crate://crates.io/heck/0.3.3 \
-    crate://crates.io/heck/0.4.1 \
-    crate://crates.io/hermit-abi/0.3.3 \
+    crate://crates.io/heck/0.5.0 \
+    crate://crates.io/hermit-abi/0.1.19 \
+    crate://crates.io/hermit-abi/0.5.2 \
     crate://crates.io/hex/0.4.3 \
-    crate://crates.io/home/0.5.5 \
+    crate://crates.io/home/0.5.11 \
     crate://crates.io/hostname-validator/1.1.1 \
-    crate://crates.io/humantime/2.1.0 \
-    crate://crates.io/idna/0.4.0 \
-    crate://crates.io/indexmap/2.0.2 \
-    crate://crates.io/instant/0.1.12 \
-    crate://crates.io/is-terminal/0.4.9 \
+    crate://crates.io/humantime/2.3.0 \
+    crate://crates.io/icu_collections/2.1.1 \
+    crate://crates.io/icu_locale_core/2.1.1 \
+    crate://crates.io/icu_normalizer/2.1.1 \
+    crate://crates.io/icu_normalizer_data/2.1.1 \
+    crate://crates.io/icu_properties/2.1.2 \
+    crate://crates.io/icu_properties_data/2.1.2 \
+    crate://crates.io/icu_provider/2.1.1 \
+    crate://crates.io/id-arena/2.3.0 \
+    crate://crates.io/idna/1.1.0 \
+    crate://crates.io/idna_adapter/1.2.1 \
+    crate://crates.io/indexmap/2.14.0 \
+    crate://crates.io/is_terminal_polyfill/1.70.2 \
     crate://crates.io/itertools/0.10.5 \
-    crate://crates.io/itoa/1.0.9 \
-    crate://crates.io/js-sys/0.3.64 \
+    crate://crates.io/itertools/0.13.0 \
+    crate://crates.io/itoa/1.0.18 \
+    crate://crates.io/jiff/0.2.24 \
+    crate://crates.io/jiff-static/0.2.24 \
+    crate://crates.io/js-sys/0.3.97 \
     crate://crates.io/jsonwebkey/0.3.5 \
     crate://crates.io/jsonwebtoken/8.3.0 \
-    crate://crates.io/lazy_static/1.4.0 \
+    crate://crates.io/lazy_static/1.5.0 \
     crate://crates.io/lazycell/1.3.0 \
-    crate://crates.io/libc/0.2.149 \
-    crate://crates.io/libloading/0.7.4 \
+    crate://crates.io/leb128fmt/0.1.0 \
+    crate://crates.io/libc/0.2.186 \
+    crate://crates.io/libloading/0.8.9 \
     crate://crates.io/libsqlite3-sys/0.26.0 \
-    crate://crates.io/libz-sys/1.1.12 \
-    crate://crates.io/linux-raw-sys/0.4.10 \
-    crate://crates.io/lock_api/0.4.10 \
-    crate://crates.io/log/0.4.20 \
-    crate://crates.io/mbox/0.6.0 \
-    crate://crates.io/memchr/2.6.4 \
+    crate://crates.io/libz-sys/1.1.28 \
+    crate://crates.io/linux-raw-sys/0.4.15 \
+    crate://crates.io/linux-raw-sys/0.12.1 \
+    crate://crates.io/litemap/0.8.2 \
+    crate://crates.io/lock_api/0.4.14 \
+    crate://crates.io/log/0.4.29 \
+    crate://crates.io/mbox/0.7.1 \
+    crate://crates.io/memchr/2.8.0 \
     crate://crates.io/minimal-lexical/0.2.1 \
     crate://crates.io/multimap/0.8.3 \
-    crate://crates.io/nom/5.1.3 \
     crate://crates.io/nom/7.1.3 \
-    crate://crates.io/num/0.4.1 \
-    crate://crates.io/num-bigint/0.4.4 \
-    crate://crates.io/num-complex/0.4.4 \
-    crate://crates.io/num-derive/0.4.1 \
-    crate://crates.io/num-integer/0.1.45 \
-    crate://crates.io/num-iter/0.1.43 \
-    crate://crates.io/num-rational/0.4.1 \
-    crate://crates.io/num-traits/0.2.17 \
-    crate://crates.io/num_cpus/1.16.0 \
+    crate://crates.io/num/0.4.3 \
+    crate://crates.io/num-bigint/0.4.6 \
+    crate://crates.io/num-complex/0.4.6 \
+    crate://crates.io/num-conv/0.1.0 \
+    crate://crates.io/num-derive/0.4.2 \
+    crate://crates.io/num-integer/0.1.46 \
+    crate://crates.io/num-iter/0.1.45 \
+    crate://crates.io/num-rational/0.4.2 \
+    crate://crates.io/num-traits/0.2.19 \
+    crate://crates.io/num_cpus/1.17.0 \
     crate://crates.io/oid/0.2.1 \
-    crate://crates.io/oid-registry/0.4.0 \
-    crate://crates.io/once_cell/1.18.0 \
-    crate://crates.io/parking_lot/0.11.2 \
-    crate://crates.io/parking_lot_core/0.8.6 \
-    crate://crates.io/parsec-interface/0.29.1 \
-    crate://crates.io/paste/1.0.14 \
+    crate://crates.io/oid-registry/0.6.1 \
+    crate://crates.io/once_cell/1.21.4 \
+    crate://crates.io/once_cell_polyfill/1.70.2 \
+    crate://crates.io/parking_lot/0.12.5 \
+    crate://crates.io/parking_lot_core/0.9.12 \
+    crate://crates.io/parsec-interface/0.30.0 \
     crate://crates.io/peeking_take_while/0.1.2 \
     crate://crates.io/pem/1.1.1 \
-    crate://crates.io/percent-encoding/2.3.0 \
-    crate://crates.io/pest/2.7.4 \
-    crate://crates.io/petgraph/0.6.4 \
-    crate://crates.io/picky-asn1/0.8.0 \
-    crate://crates.io/picky-asn1-der/0.4.1 \
-    crate://crates.io/picky-asn1-x509/0.12.0 \
-    crate://crates.io/pin-project-lite/0.2.13 \
-    crate://crates.io/pin-utils/0.1.0 \
-    crate://crates.io/pkcs8/0.8.0 \
-    crate://crates.io/pkg-config/0.3.27 \
-    crate://crates.io/ppv-lite86/0.2.17 \
-    crate://crates.io/prettyplease/0.2.15 \
-    crate://crates.io/proc-macro2/1.0.69 \
+    crate://crates.io/percent-encoding/2.3.2 \
+    crate://crates.io/petgraph/0.6.5 \
+    crate://crates.io/picky-asn1/0.10.1 \
+    crate://crates.io/picky-asn1-der/0.5.6 \
+    crate://crates.io/picky-asn1-x509/0.15.4 \
+    crate://crates.io/pin-project-lite/0.2.17 \
+    crate://crates.io/pkcs8/0.10.2 \
+    crate://crates.io/pkg-config/0.3.33 \
+    crate://crates.io/portable-atomic/1.13.1 \
+    crate://crates.io/portable-atomic-util/0.2.7 \
+    crate://crates.io/potential_utf/0.1.5 \
+    crate://crates.io/powerfmt/0.2.0 \
+    crate://crates.io/ppv-lite86/0.2.21 \
+    crate://crates.io/prettyplease/0.2.37 \
+    crate://crates.io/proc-macro2/1.0.106 \
     crate://crates.io/prost/0.9.0 \
     crate://crates.io/prost-build/0.9.0 \
     crate://crates.io/prost-derive/0.9.0 \
     crate://crates.io/prost-types/0.9.0 \
     crate://crates.io/protobuf/2.28.0 \
-    crate://crates.io/psa-crypto/0.12.0 \
-    crate://crates.io/psa-crypto-sys/0.12.0 \
-    crate://crates.io/quote/1.0.33 \
-    crate://crates.io/rand/0.8.5 \
+    crate://crates.io/psa-crypto/0.13.0 \
+    crate://crates.io/psa-crypto-sys/0.13.0 \
+    crate://crates.io/quote/1.0.45 \
+    crate://crates.io/r-efi/6.0.0 \
+    crate://crates.io/rand/0.8.6 \
     crate://crates.io/rand_chacha/0.3.1 \
     crate://crates.io/rand_core/0.6.4 \
-    crate://crates.io/redox_syscall/0.2.16 \
-    crate://crates.io/redox_syscall/0.3.5 \
-    crate://crates.io/regex/1.9.6 \
-    crate://crates.io/regex-automata/0.3.9 \
-    crate://crates.io/regex-syntax/0.7.5 \
+    crate://crates.io/redox_syscall/0.5.18 \
+    crate://crates.io/regex/1.12.3 \
+    crate://crates.io/regex-automata/0.4.14 \
+    crate://crates.io/regex-syntax/0.8.10 \
     crate://crates.io/ring/0.16.20 \
     crate://crates.io/rusqlite/0.29.0 \
     crate://crates.io/rust-cryptoauthlib/0.4.5 \
     crate://crates.io/rustc-hash/1.1.0 \
-    crate://crates.io/rustc_version/0.3.3 \
+    crate://crates.io/rustc-hash/2.1.2 \
     crate://crates.io/rusticata-macros/4.1.0 \
-    crate://crates.io/rustix/0.38.21 \
-    crate://crates.io/ryu/1.0.15 \
+    crate://crates.io/rustix/0.38.44 \
+    crate://crates.io/rustix/1.1.4 \
+    crate://crates.io/rustversion/1.0.22 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/scopeguard/1.2.0 \
-    crate://crates.io/sd-notify/0.4.1 \
+    crate://crates.io/sd-notify/0.5.0 \
     crate://crates.io/secrecy/0.8.0 \
-    crate://crates.io/semver/0.11.0 \
-    crate://crates.io/semver-parser/0.10.2 \
-    crate://crates.io/serde/1.0.188 \
-    crate://crates.io/serde_bytes/0.11.12 \
-    crate://crates.io/serde_derive/1.0.188 \
-    crate://crates.io/serde_json/1.0.107 \
-    crate://crates.io/serde_spanned/0.6.3 \
-    crate://crates.io/shlex/0.1.1 \
-    crate://crates.io/shlex/1.2.0 \
-    crate://crates.io/signal-hook/0.3.17 \
-    crate://crates.io/signal-hook-registry/1.4.1 \
-    crate://crates.io/simple_asn1/0.6.2 \
-    crate://crates.io/slab/0.4.9 \
-    crate://crates.io/smallvec/1.11.1 \
-    crate://crates.io/spiffe/0.2.1 \
+    crate://crates.io/secrecy/0.10.3 \
+    crate://crates.io/semver/1.0.28 \
+    crate://crates.io/serde/1.0.228 \
+    crate://crates.io/serde_bytes/0.11.19 \
+    crate://crates.io/serde_core/1.0.228 \
+    crate://crates.io/serde_derive/1.0.228 \
+    crate://crates.io/serde_json/1.0.149 \
+    crate://crates.io/serde_spanned/1.1.1 \
+    crate://crates.io/shlex/1.3.0 \
+    crate://crates.io/signal-hook/0.4.4 \
+    crate://crates.io/signal-hook-registry/1.4.8 \
+    crate://crates.io/simple_asn1/0.6.3 \
+    crate://crates.io/slab/0.4.12 \
+    crate://crates.io/smallvec/1.15.1 \
+    crate://crates.io/spiffe/0.2.2 \
     crate://crates.io/spin/0.5.2 \
-    crate://crates.io/spki/0.5.4 \
-    crate://crates.io/stable_deref_trait/1.2.0 \
-    crate://crates.io/strsim/0.10.0 \
+    crate://crates.io/spki/0.7.3 \
+    crate://crates.io/stable_deref_trait/1.2.1 \
+    crate://crates.io/strsim/0.8.0 \
+    crate://crates.io/strsim/0.11.1 \
     crate://crates.io/strum_macros/0.21.1 \
     crate://crates.io/syn/1.0.109 \
-    crate://crates.io/syn/2.0.38 \
+    crate://crates.io/syn/2.0.117 \
     crate://crates.io/synstructure/0.12.6 \
-    crate://crates.io/target-lexicon/0.12.11 \
-    crate://crates.io/tempfile/3.8.0 \
-    crate://crates.io/termcolor/1.3.0 \
-    crate://crates.io/thiserror/1.0.49 \
-    crate://crates.io/thiserror-impl/1.0.49 \
+    crate://crates.io/synstructure/0.13.2 \
+    crate://crates.io/target-lexicon/0.12.16 \
+    crate://crates.io/tempfile/3.27.0 \
+    crate://crates.io/termcolor/1.4.1 \
+    crate://crates.io/textwrap/0.11.0 \
+    crate://crates.io/thiserror/1.0.69 \
+    crate://crates.io/thiserror/2.0.18 \
+    crate://crates.io/thiserror-impl/1.0.69 \
+    crate://crates.io/thiserror-impl/2.0.18 \
     crate://crates.io/threadpool/1.8.1 \
-    crate://crates.io/time/0.3.23 \
-    crate://crates.io/time-core/0.1.1 \
-    crate://crates.io/time-macros/0.2.10 \
-    crate://crates.io/tinyvec/1.6.0 \
-    crate://crates.io/tinyvec_macros/0.1.1 \
-    crate://crates.io/toml/0.8.2 \
-    crate://crates.io/toml_datetime/0.6.3 \
-    crate://crates.io/toml_edit/0.20.2 \
-    crate://crates.io/tss-esapi/7.5.0 \
-    crate://crates.io/tss-esapi-sys/0.5.0 \
-    crate://crates.io/typenum/1.17.0 \
-    crate://crates.io/ucd-trie/0.1.6 \
-    crate://crates.io/unicode-bidi/0.3.13 \
-    crate://crates.io/unicode-ident/1.0.12 \
-    crate://crates.io/unicode-normalization/0.1.22 \
-    crate://crates.io/unicode-segmentation/1.10.1 \
-    crate://crates.io/unicode-xid/0.2.4 \
+    crate://crates.io/time/0.3.45 \
+    crate://crates.io/time-core/0.1.7 \
+    crate://crates.io/time-macros/0.2.25 \
+    crate://crates.io/tinystr/0.8.3 \
+    crate://crates.io/toml/1.1.2+spec-1.1.0 \
+    crate://crates.io/toml_datetime/1.1.1+spec-1.1.0 \
+    crate://crates.io/toml_parser/1.1.2+spec-1.1.0 \
+    crate://crates.io/toml_writer/1.1.1+spec-1.1.0 \
+    crate://crates.io/tss-esapi/7.7.0 \
+    crate://crates.io/tss-esapi-sys/0.6.0 \
+    crate://crates.io/typenum/1.20.0 \
+    crate://crates.io/unicode-ident/1.0.24 \
+    crate://crates.io/unicode-segmentation/1.13.2 \
+    crate://crates.io/unicode-width/0.1.14 \
+    crate://crates.io/unicode-xid/0.2.6 \
     crate://crates.io/untrusted/0.7.1 \
-    crate://crates.io/url/2.4.1 \
-    crate://crates.io/utf8parse/0.2.1 \
+    crate://crates.io/url/2.5.8 \
+    crate://crates.io/utf16_iter/1.0.5 \
+    crate://crates.io/utf8_iter/1.0.4 \
+    crate://crates.io/utf8parse/0.2.2 \
     crate://crates.io/uuid/0.8.2 \
     crate://crates.io/vcpkg/0.2.15 \
-    crate://crates.io/version_check/0.9.4 \
-    crate://crates.io/walkdir/2.4.0 \
-    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
-    crate://crates.io/wasm-bindgen/0.2.87 \
-    crate://crates.io/wasm-bindgen-backend/0.2.87 \
-    crate://crates.io/wasm-bindgen-macro/0.2.87 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.87 \
-    crate://crates.io/wasm-bindgen-shared/0.2.87 \
-    crate://crates.io/web-sys/0.3.64 \
+    crate://crates.io/vec_map/0.8.2 \
+    crate://crates.io/version_check/0.9.5 \
+    crate://crates.io/walkdir/2.5.0 \
+    crate://crates.io/wasi/0.11.1+wasi-snapshot-preview1 \
+    crate://crates.io/wasip2/1.0.1+wasi-0.2.4 \
+    crate://crates.io/wasip3/0.4.0+wasi-0.3.0-rc-2026-01-06 \
+    crate://crates.io/wasm-bindgen/0.2.120 \
+    crate://crates.io/wasm-bindgen-macro/0.2.120 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.120 \
+    crate://crates.io/wasm-bindgen-shared/0.2.120 \
+    crate://crates.io/wasm-encoder/0.244.0 \
+    crate://crates.io/wasm-metadata/0.244.0 \
+    crate://crates.io/wasmparser/0.244.0 \
+    crate://crates.io/web-sys/0.3.97 \
     crate://crates.io/which/4.4.2 \
     crate://crates.io/winapi/0.3.9 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-util/0.1.6 \
+    crate://crates.io/winapi-util/0.1.11 \
     crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-    crate://crates.io/windows-sys/0.48.0 \
-    crate://crates.io/windows-targets/0.48.5 \
-    crate://crates.io/windows_aarch64_gnullvm/0.48.5 \
-    crate://crates.io/windows_aarch64_msvc/0.48.5 \
-    crate://crates.io/windows_i686_gnu/0.48.5 \
-    crate://crates.io/windows_i686_msvc/0.48.5 \
-    crate://crates.io/windows_x86_64_gnu/0.48.5 \
-    crate://crates.io/windows_x86_64_gnullvm/0.48.5 \
-    crate://crates.io/windows_x86_64_msvc/0.48.5 \
-    crate://crates.io/winnow/0.5.16 \
-    crate://crates.io/x509-parser/0.13.2 \
+    crate://crates.io/windows-link/0.2.1 \
+    crate://crates.io/windows-sys/0.59.0 \
+    crate://crates.io/windows-sys/0.61.2 \
+    crate://crates.io/windows-targets/0.52.6 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
+    crate://crates.io/windows_aarch64_msvc/0.52.6 \
+    crate://crates.io/windows_i686_gnu/0.52.6 \
+    crate://crates.io/windows_i686_gnullvm/0.52.6 \
+    crate://crates.io/windows_i686_msvc/0.52.6 \
+    crate://crates.io/windows_x86_64_gnu/0.52.6 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
+    crate://crates.io/windows_x86_64_msvc/0.52.6 \
+    crate://crates.io/winnow/1.0.2 \
+    crate://crates.io/wit-bindgen/0.46.0 \
+    crate://crates.io/wit-bindgen/0.51.0 \
+    crate://crates.io/wit-bindgen-core/0.51.0 \
+    crate://crates.io/wit-bindgen-rust/0.51.0 \
+    crate://crates.io/wit-bindgen-rust-macro/0.51.0 \
+    crate://crates.io/wit-component/0.244.0 \
+    crate://crates.io/wit-parser/0.244.0 \
+    crate://crates.io/write16/1.0.0 \
+    crate://crates.io/writeable/0.6.3 \
+    crate://crates.io/x509-parser/0.15.1 \
     crate://crates.io/yasna/0.4.0 \
-    crate://crates.io/zerocopy/0.7.32 \
-    crate://crates.io/zerocopy-derive/0.7.32 \
-    crate://crates.io/zeroize/1.6.0 \
-    crate://crates.io/zeroize_derive/1.4.2 \
+    crate://crates.io/yoke/0.8.2 \
+    crate://crates.io/yoke-derive/0.8.2 \
+    crate://crates.io/zerocopy/0.8.48 \
+    crate://crates.io/zerocopy-derive/0.8.48 \
+    crate://crates.io/zerofrom/0.1.7 \
+    crate://crates.io/zerofrom-derive/0.1.7 \
+    crate://crates.io/zeroize/1.8.2 \
+    crate://crates.io/zeroize_derive/1.4.3 \
+    crate://crates.io/zerotrie/0.2.4 \
+    crate://crates.io/zerovec/0.11.6 \
+    crate://crates.io/zerovec-derive/0.11.3 \
+    crate://crates.io/zmij/1.0.21 \
 "
=20
-SRC_URI[ahash-0.8.7.sha256sum] =3D "77c3a9648d43b9cd48db467b3f87fdd6e146=
bcc88ab0180006cef2179fe11d01"
-SRC_URI[aho-corasick-1.1.2.sha256sum] =3D "b2969dcb958b36655471fc61f7e41=
6fa76033bdd4bfed0678d8fee1e2d07a1f0"
-SRC_URI[allocator-api2-0.2.16.sha256sum] =3D "0942ffc6dcaadf03badf6e6a2d=
0228460359d5e34b57ccdc720b7382dfbd5ec5"
-SRC_URI[anstream-0.3.2.sha256sum] =3D "0ca84f3628370c59db74ee214b3263d58=
f9aadd9b4fe7e711fd87dc452b7f163"
-SRC_URI[anstyle-1.0.2.sha256sum] =3D "15c4c2c83f81532e5845a733998b6971fa=
ca23490340a418e9b72a3ec9de12ea"
-SRC_URI[anstyle-parse-0.2.1.sha256sum] =3D "938874ff5980b03a87c5524b3ae5=
b59cf99b1d6bc836848df7bc5ada9643c333"
-SRC_URI[anstyle-query-1.0.0.sha256sum] =3D "5ca11d4be1bab0c8bc8734a9aa7b=
f4ee8316d462a08c6ac5052f888fef5b494b"
-SRC_URI[anstyle-wincon-1.0.2.sha256sum] =3D "c677ab05e09154296dd37acecd4=
6420c17b9713e8366facafa8fc0885167cf4c"
-SRC_URI[anyhow-1.0.75.sha256sum] =3D "a4668cab20f66d8d020e1fbc0ebe472174=
33c1b6c8f2040faf858554e394ace6"
-SRC_URI[asn1-rs-0.3.1.sha256sum] =3D "30ff05a702273012438132f449575dbc80=
4e27b2f3cbe3069aa237d26c98fa33"
-SRC_URI[asn1-rs-derive-0.1.0.sha256sum] =3D "db8b7511298d5b7784b40b092d9=
e9dcd3a627a5707e4b5e507931ab0d44eeebf"
+SRC_URI[ahash-0.8.12.sha256sum] =3D "5a15f179cd60c4584b8a8c596927aadc462=
e27f2ca70c04e0071964a73ba7a75"
+SRC_URI[aho-corasick-1.1.4.sha256sum] =3D "ddd31a130427c27518df266943a53=
08ed92d4b226cc639f5a8f1002816174301"
+SRC_URI[allocator-api2-0.2.21.sha256sum] =3D "683d7910e743518b0e34f1186f=
92494becacb047c7b6bf616c96772180fef923"
+SRC_URI[ansi_term-0.12.1.sha256sum] =3D "d52a9bb7ec0cf484c551830a7ce27bd=
20d67eac647e1befb56b0be4ee39a55d2"
+SRC_URI[anstream-1.0.0.sha256sum] =3D "824a212faf96e9acacdbd09febd34438f=
8f711fb84e09a8916013cd7815ca28d"
+SRC_URI[anstyle-1.0.14.sha256sum] =3D "940b3a0ca603d1eade50a4846a2afffd5=
ef57a9feac2c0e2ec2e14f9ead76000"
+SRC_URI[anstyle-parse-1.0.0.sha256sum] =3D "52ce7f38b242319f7cabaa681305=
5467063ecdc9d355bbb4ce0c68908cd8130e"
+SRC_URI[anstyle-query-1.1.5.sha256sum] =3D "40c48f72fd53cd289104fc64099a=
bca73db4166ad86ea0b4341abe65af83dadc"
+SRC_URI[anstyle-wincon-3.0.11.sha256sum] =3D "291e6a250ff86cd4a820112fb8=
898808a366d8f9f58ce16d1f538353ad55747d"
+SRC_URI[anyhow-1.0.102.sha256sum] =3D "7f202df86484c868dbad7eaa557ef785d=
5c66295e41b460ef922eca0723b842c"
+SRC_URI[asn1-rs-0.5.2.sha256sum] =3D "7f6fd5ddaf0351dff5b8da21b2fb4ff8e0=
8ddd02857f0bf69c47639106c0fff0"
+SRC_URI[asn1-rs-derive-0.4.0.sha256sum] =3D "726535892e8eae7e70657b4c8ea=
93d26b8553afb1ce617caee529ef96d7dee6c"
 SRC_URI[asn1-rs-impl-0.1.0.sha256sum] =3D "2777730b2039ac0f95f093556e61b=
6d26cebed5393ca6f152717777cec3a42ed"
-SRC_URI[autocfg-1.1.0.sha256sum] =3D "d468802bab17cbc0cc575e9b053f41e72a=
a36bfa6b7f55e3529ffa43161b97fa"
+SRC_URI[atty-0.2.14.sha256sum] =3D "d9b39be18770d11421cdb1b9947a45dd3f37=
e93092cbf377614828a319d5fee8"
+SRC_URI[autocfg-1.5.0.sha256sum] =3D "c08606f8c3cbf4ce6ec8e28fb0014a2c08=
6708fe954eaa885384a6165172e7e8"
 SRC_URI[base64-0.13.1.sha256sum] =3D "9e1b586273c5702936fe7b7d6896644d8b=
e71e6314cfe09d3167c95f712589e8"
-SRC_URI[base64-0.21.4.sha256sum] =3D "9ba43ea6f343b788c8764558649e08df62=
f86c6ef251fdaeb1ffd010a9ae50a2"
+SRC_URI[base64-0.21.7.sha256sum] =3D "9d297deb1925b89f2ccc13d7635fa0714f=
12c87adce1c75356b39ca9b7178567"
+SRC_URI[base64-0.22.1.sha256sum] =3D "72b3254f16251a8381aa12e40e3c4d2f01=
99f8c6508fbecb9d91f575e0fbb8c6"
 SRC_URI[bincode-1.3.3.sha256sum] =3D "b1f45e9417d87227c7a56d22e471c62064=
62cba514c7590c09aff4cf6d1ddcad"
-SRC_URI[bindgen-0.57.0.sha256sum] =3D "fd4865004a46a0aafb2a0a5eb19d3c9fc=
46ee5f063a6cfc605c69ac9ecf5263d"
-SRC_URI[bindgen-0.66.1.sha256sum] =3D "f2b84e06fc203107bfbad243f4aba2af8=
64eb7db3b1cf46ea0a023b0b433d2a7"
-SRC_URI[bitfield-0.14.0.sha256sum] =3D "2d7e60934ceec538daadb9d8432424ed=
043a904d8e0243f3c6446bce549a46ac"
+SRC_URI[bindgen-0.59.2.sha256sum] =3D "2bd2a9a458e8f4304c52c43ebb0cfbd52=
0289f8379a52e329a38afda99bf8eb8"
+SRC_URI[bindgen-0.72.1.sha256sum] =3D "993776b509cfb49c750f11b8f07a46fa2=
3e0a1386ffc01fb1e7d343efc387895"
+SRC_URI[bitfield-0.19.4.sha256sum] =3D "21ba6517c6b0f2bf08be60e187ab64b0=
38438f22dd755614d8fe4d4098c46419"
+SRC_URI[bitfield-macros-0.19.4.sha256sum] =3D "f48d6ace212fdf1b45fd6b566=
bb40808415344642b76c3224c07c8df9da81e97"
 SRC_URI[bitflags-1.3.2.sha256sum] =3D "bef38d45163c2f1dde094a7dfd33ccf59=
5c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[bitflags-2.4.1.sha256sum] =3D "327762f6e5a765692301e5bb513e0d9fe=
f63be86bbc14528052b1cd3e6f03e07"
-SRC_URI[bumpalo-3.14.0.sha256sum] =3D "7f30e7476521f6f8af1a1c4c0b8cc94f0=
bee37d91763d0ca2665f299b6cd8aec"
-SRC_URI[bytes-1.5.0.sha256sum] =3D "a2bd12c1caf447e69cd4528f47f94d203fd2=
582878ecb9e9465484c4148a8223"
-SRC_URI[cc-1.0.83.sha256sum] =3D "f1174fb0b6ec23863f8b971027804a42614e34=
7eafb0a95bf0b12cdae21fc4d0"
-SRC_URI[cexpr-0.4.0.sha256sum] =3D "f4aedb84272dbe89af497cf81375129abda4=
fc0a9e7c5d317498c15cc30c0d27"
+SRC_URI[bitflags-2.11.1.sha256sum] =3D "c4512299f36f043ab09a583e57bceb5a=
5aab7a73db1805848e8fef3c9e8c78b3"
+SRC_URI[bumpalo-3.20.2.sha256sum] =3D "5d20789868f4b01b2f2caec9f5c4e0213=
b41e3e5702a50157d699ae31ced2fcb"
+SRC_URI[bytes-1.11.1.sha256sum] =3D "1e748733b7cbc798e1434b6ac524f0c1ff2=
ab456fe201501e6497c8417a4fc33"
+SRC_URI[cc-1.2.61.sha256sum] =3D "d16d90359e986641506914ba71350897565610=
e87ce0ad9e6f28569db3dd5c6d"
 SRC_URI[cexpr-0.6.0.sha256sum] =3D "6fac387a98bb7c37292057cffc56d62ecb62=
9900026402633ae9160df93a8766"
-SRC_URI[cfg-if-1.0.0.sha256sum] =3D "baf1de4339761588bc0619e3cbc0120ee58=
2ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[clang-sys-1.6.1.sha256sum] =3D "c688fc74432808e3eb684cae8830a86b=
e1d66a2bd58e1f248ed0960a590baf6f"
-SRC_URI[clap-4.3.24.sha256sum] =3D "fb690e81c7840c0d7aade59f242ea3b41b9b=
c27bcd5997890e7702ae4b32e487"
-SRC_URI[clap_builder-4.3.24.sha256sum] =3D "5ed2e96bc16d8d740f6f48d663ed=
df4b8a0983e79210fd55479b7bcd0a69860e"
-SRC_URI[clap_derive-4.3.12.sha256sum] =3D "54a9bb5758fc5dfe728d101994168=
1eccaf0cf8a4189b692a0ee2f2ecf90a050"
-SRC_URI[clap_lex-0.5.0.sha256sum] =3D "2da6da31387c7e4ef160ffab6d5e7f00c=
42626fe39aea70a7b0f1773f7dd6c1b"
+SRC_URI[cfg-if-1.0.4.sha256sum] =3D "9330f8b2ff13f34540b44e946ef35111825=
727b38d33286ef986142615121801"
+SRC_URI[clang-sys-1.8.1.sha256sum] =3D "0b023947811758c97c59bf9d1c188fd6=
19ad4718dcaa767947df1cadb14f39f4"
+SRC_URI[clap-2.34.0.sha256sum] =3D "a0610544180c38b88101fecf2dd634b174a6=
2eef6946f84dfc6a7127512b381c"
+SRC_URI[clap-4.6.1.sha256sum] =3D "1ddb117e43bbf7dacf0a4190fef4d345b9bad=
68dfc649cb349e7d17d28428e51"
+SRC_URI[clap_builder-4.6.0.sha256sum] =3D "714a53001bf66416adb0e2ef5ac85=
7140e7dc3a0c48fb28b2f10762fc4b5069f"
+SRC_URI[clap_derive-4.6.1.sha256sum] =3D "f2ce8604710f6733aa641a2b3731ea=
a1e8b3d9973d5e3565da11800813f997a9"
+SRC_URI[clap_lex-1.1.0.sha256sum] =3D "c8d4a3bb8b1e0c1050499d1815f5ab16d=
04f0959b233085fb31653fbfc9d98f9"
 SRC_URI[cmake-0.1.45.sha256sum] =3D "eb6210b637171dfba4cda12e579ac6dc73f=
5165ad56133e5d72ef3131f320855"
-SRC_URI[colorchoice-1.0.0.sha256sum] =3D "acbf1af155f9b9ef647e42cdc158db=
4b64a1b61f743629225fde6f3e0be2a7c7"
-SRC_URI[const-oid-0.7.1.sha256sum] =3D "e4c78c047431fee22c1a7bb92e00ad09=
5a02a983affe4d8a72e2a2c62c1b94f3"
+SRC_URI[colorchoice-1.0.5.sha256sum] =3D "1d07550c9036bf2ae0c684c4297d50=
3f838287c83c53686d05370d0e139ae570"
+SRC_URI[const-oid-0.9.6.sha256sum] =3D "c2459377285ad874054d797f3ccebf98=
4978aa39129f6eafde5cdc8315b612f8"
 SRC_URI[cryptoauthlib-sys-0.2.2.sha256sum] =3D "da232dd4f06ee4600b33a455=
bb17fcc6c2c3a54ee7fd60496d3a73668a6cb6e4"
-SRC_URI[cryptoki-0.6.0.sha256sum] =3D "e08651cefd925cd83d8d1b4f96276c18f=
e5ee148ab8c8a47f462316d36bc01af"
-SRC_URI[cryptoki-sys-0.1.7.sha256sum] =3D "7a978e5e226446ac68eded4f92796=
947130f0d21de1e21bf80298f9f50d917d5"
-SRC_URI[data-encoding-2.4.0.sha256sum] =3D "c2e66c9d817f1720209181c316d2=
8635c050fa304f9c79e47a520882661b7308"
-SRC_URI[der-0.5.1.sha256sum] =3D "6919815d73839e7ad218de758883aae3a257ba=
6759ce7a9992501efbb53d705c"
-SRC_URI[der-parser-7.0.0.sha256sum] =3D "fe398ac75057914d7d07307bf67dc7f=
3f574a26783b4fc7805a20ffa9f506e82"
+SRC_URI[cryptoki-0.12.0.sha256sum] =3D "ff765b99fc49f3116c9a908484486a2b=
92fd73c48da45c3a69716471c6cc56c6"
+SRC_URI[cryptoki-sys-0.5.0.sha256sum] =3D "f1fd850498411e4057f1cba79e6e2=
bc7cbe960544c1046ab46d4685c403a1121"
+SRC_URI[data-encoding-2.11.0.sha256sum] =3D "a4ae5f15dda3c708c0ade84bfee=
31ccab44a3da4f88015ed22f63732abe300c8"
+SRC_URI[der-0.7.10.sha256sum] =3D "e7c1832837b905bbfb5101e07cc24c8deddf5=
2f93225eee6ead5f4d63d53ddcb"
+SRC_URI[der-parser-8.2.0.sha256sum] =3D "dbd676fbbab537128ef0278adb5576c=
f363cff6aa22a7b24effe97347cfab61e"
+SRC_URI[deranged-0.5.8.sha256sum] =3D "7cd812cc2bc1d69d4764bd80df88b4317=
eaef9e773c75226407d9bc0876b211c"
 SRC_URI[derivative-2.2.0.sha256sum] =3D "fcc3dd5e9e9c0b295d6e1e4d811fb6f=
157d5ffd784b8d202fc62eac8035a770b"
-SRC_URI[displaydoc-0.2.4.sha256sum] =3D "487585f4d0c6655fe74905e2504d8ad=
6908e4db67f744eb140876906c2f3175d"
-SRC_URI[either-1.9.0.sha256sum] =3D "a26ae43d7bcc3b814de94796a5e736d4029=
efb0ee900c12e2d54c993ad1a1e07"
-SRC_URI[enumflags2-0.7.8.sha256sum] =3D "5998b4f30320c9d93aed72f63af821b=
fdac50465b75428fce77b48ec482c3939"
-SRC_URI[enumflags2_derive-0.7.8.sha256sum] =3D "f95e2801cd355d4a1a3e3953=
ce6ee5ae9603a5c833455343a8bfe3f44d418246"
-SRC_URI[env_logger-0.10.0.sha256sum] =3D "85cdab6a89accf66733ad5a1693a4d=
cced6aeff64602b634530dd73c1f3ee9f0"
-SRC_URI[equivalent-1.0.1.sha256sum] =3D "5443807d6dff69373d433ab9ef5378a=
d8df50ca6298caf15de6e52e24aaf54d5"
-SRC_URI[errno-0.3.5.sha256sum] =3D "ac3e13f66a2f95e32a39eaa81f6b95d42878=
ca0e1db0c7543723dfe12557e860"
+SRC_URI[displaydoc-0.2.5.sha256sum] =3D "97369cbbc041bc366949bc74d34658d=
6cda5621039731c6310521892a3a20ae0"
+SRC_URI[either-1.15.0.sha256sum] =3D "48c757948c5ede0e46177b7add2e67155f=
70e33c07fea8284df6576da70b3719"
+SRC_URI[enumflags2-0.7.12.sha256sum] =3D "1027f7680c853e056ebcec683615fb=
6fbbc07dbaa13b4d5d9442b146ded4ecef"
+SRC_URI[enumflags2_derive-0.7.12.sha256sum] =3D "67c78a4d8fdf9953a5c9d45=
8f9efe940fd97a0cab0941c075a813ac594733827"
+SRC_URI[env_filter-1.0.1.sha256sum] =3D "32e90c2accc4b07a8456ea0debdc2e7=
587bdd890680d71173a15d4ae604f6eef"
+SRC_URI[env_logger-0.9.3.sha256sum] =3D "a12e6657c4c97ebab115a42dcee7722=
5f7f482cdd841cf7088c657a42e9e00e7"
+SRC_URI[env_logger-0.11.10.sha256sum] =3D "0621c04f2196ac3f488dd583365b9=
c09be011a4ab8b9f37248ffcc8f6198b56a"
+SRC_URI[equivalent-1.0.2.sha256sum] =3D "877a4ace8713b0bcf2a4e7eec82529c=
029f1d0619886d18145fea96c3ffe5c0f"
+SRC_URI[errno-0.3.14.sha256sum] =3D "39cab71617ae0d63f51a36d69f866391735=
b51691dbda63cf6f96d042b63efeb"
 SRC_URI[fallible-iterator-0.2.0.sha256sum] =3D "4443176a9f2c162692bd3d35=
2d745ef9413eec5782a80d8fd6f8a1ac692a07f7"
 SRC_URI[fallible-streaming-iterator-0.1.9.sha256sum] =3D "7360491ce676a3=
6bf9bb3c56c1aa791658183a54d2744120f27285738d90465a"
-SRC_URI[fastrand-2.0.1.sha256sum] =3D "25cbce373ec4653f1a01a31e8a5e5ec0c=
622dc27ff9c4e6606eefef5cbbed4a5"
+SRC_URI[fastrand-2.4.1.sha256sum] =3D "9f1f227452a390804cdb637b74a86990f=
2a7d7ba4b7d5693aac9b4dd6defd8d6"
+SRC_URI[find-msvc-tools-0.1.9.sha256sum] =3D "5baebc0774151f905a1a2cc419=
89300b1e6fbb29aff0ceffa1064fdd3088d582"
 SRC_URI[fixedbitset-0.4.2.sha256sum] =3D "0ce7134b9999ecaf8bcd65542e4367=
36ef32ddca1b3e06094cb6ec5755203b80"
-SRC_URI[form_urlencoded-1.2.0.sha256sum] =3D "a62bc1cf6f830c2ec14a513a9f=
b124d0a213a629668a4186f329db21fe045652"
-SRC_URI[futures-0.3.28.sha256sum] =3D "23342abe12aba583913b2e62f22225ff9=
c950774065e4bfb61a19cd9770fec40"
-SRC_URI[futures-channel-0.3.28.sha256sum] =3D "955518d47e09b25bbebc7a18d=
f10b81f0c766eaf4c4f1cccef2fca5f2a4fb5f2"
-SRC_URI[futures-core-0.3.28.sha256sum] =3D "4bca583b7e26f571124fe5b7561d=
49cb2868d79116cfa0eefce955557c6fee8c"
-SRC_URI[futures-executor-0.3.28.sha256sum] =3D "ccecee823288125bd88b4d7f=
565c9e58e41858e47ab72e8ea2d64e93624386e0"
-SRC_URI[futures-io-0.3.28.sha256sum] =3D "4fff74096e71ed47f8e023204cfd0a=
a1289cd54ae5430a9523be060cdb849964"
-SRC_URI[futures-macro-0.3.28.sha256sum] =3D "89ca545a94061b6365f2c7355b4=
b32bd20df3ff95f02da9329b34ccc3bd6ee72"
-SRC_URI[futures-sink-0.3.28.sha256sum] =3D "f43be4fe21a13b9781a69afa4985=
b0f6ee0e1afab2c6f454a8cf30e2b2237b6e"
-SRC_URI[futures-task-0.3.28.sha256sum] =3D "76d3d132be6c0e6aa1534069c705=
a74a5997a356c0dc2f86a47765e5617c5b65"
-SRC_URI[futures-util-0.3.28.sha256sum] =3D "26b01e40b772d54cf6c6d721c1d1=
abd0647a0106a12ecaa1c186273392a69533"
-SRC_URI[generic-array-0.14.7.sha256sum] =3D "85649ca51fd72272d7821adaf27=
4ad91c288277713d9c18820d8499a7ff69e9a"
-SRC_URI[getrandom-0.2.12.sha256sum] =3D "190092ea657667030ac6a35e305e62f=
c4dd69fd98ac98631e5d3a2b1575a12b5"
-SRC_URI[glob-0.3.1.sha256sum] =3D "d2fabcfbdc87f4758337ca535fb41a6d701b6=
5693ce38287d856d1674551ec9b"
-SRC_URI[grpcio-0.9.1.sha256sum] =3D "24d99e00eed7e0a04ee2705112e7cfdbe1a=
3cc771147f22f016a8cd2d002187b"
-SRC_URI[grpcio-sys-0.9.1+1.38.0.sha256sum] =3D "9447d1a926beeef466606cc4=
5717f80897998b548e7dc622873d453e1ecb4be4"
-SRC_URI[hashbrown-0.14.1.sha256sum] =3D "7dfda62a12f55daeae5015f81b0baea=
145391cb4520f86c248fc615d72640d12"
+SRC_URI[foldhash-0.1.5.sha256sum] =3D "d9c4f5dac5e15c24eb999c26181a6ca40=
b39fe946cbe4c263c7209467bc83af2"
+SRC_URI[form_urlencoded-1.2.2.sha256sum] =3D "cb4cb245038516f5f85277875c=
daa4f7d2c9a0fa0468de06ed190163b1581fcf"
+SRC_URI[futures-0.3.32.sha256sum] =3D "8b147ee9d1f6d097cef9ce628cd2ee622=
88d963e16fb287bd9286455b241382d"
+SRC_URI[futures-channel-0.3.32.sha256sum] =3D "07bbe89c50d7a535e539b8c17=
bc0b49bdb77747034daa8087407d655f3f7cc1d"
+SRC_URI[futures-core-0.3.32.sha256sum] =3D "7e3450815272ef58cec6d564423f=
6e755e25379b217b0bc688e295ba24df6b1d"
+SRC_URI[futures-executor-0.3.32.sha256sum] =3D "baf29c38818342a3b26b5b92=
3639e7b1f4a61fc5e76102d4b1981c6dc7a7579d"
+SRC_URI[futures-io-0.3.32.sha256sum] =3D "cecba35d7ad927e23624b22ad55235=
f2239cfa44fd10428eecbeba6d6a717718"
+SRC_URI[futures-macro-0.3.32.sha256sum] =3D "e835b70203e41293343137df5c0=
664546da5745f82ec9b84d40be8336958447b"
+SRC_URI[futures-sink-0.3.32.sha256sum] =3D "c39754e157331b013978ec91992b=
de1ac089843443c49cbc7f46150b0fad0893"
+SRC_URI[futures-task-0.3.32.sha256sum] =3D "037711b3d59c33004d3856fbdc83=
b99d4ff37a24768fa1be9ce3538a1cde4393"
+SRC_URI[futures-util-0.3.32.sha256sum] =3D "389ca41296e6190b48053de0321d=
02a77f32f8a5d2461dd38762c0593805c6d6"
+SRC_URI[generic-array-0.14.9.sha256sum] =3D "4bb6743198531e02858aeaea539=
8fcc883e71851fcbcb5a2f773e2fb6cb1edf2"
+SRC_URI[getrandom-0.2.17.sha256sum] =3D "ff2abc00be7fca6ebc474524697ae27=
6ad847ad0a6b3faa4bcb027e9a4614ad0"
+SRC_URI[getrandom-0.4.2.sha256sum] =3D "0de51e6874e94e7bf76d726fc5d13ba7=
82deca734ff60d5bb2fb2607c7406555"
+SRC_URI[glob-0.3.3.sha256sum] =3D "0cc23270f6e1808e30a928bdc84dea0b9b413=
6a8bc82338574f23baf47bbd280"
+SRC_URI[grpcio-0.12.1.sha256sum] =3D "609832ca501baeb662dc81932fda9ed83f=
5d058f4b899a807ba222ce696f430a"
+SRC_URI[grpcio-sys-0.12.1+1.46.5-patched.sha256sum] =3D "cf625d1803b6f44=
203f0428ddace847fb4994def5c803fc8a7a2f18fb3daec62"
+SRC_URI[hashbrown-0.14.5.sha256sum] =3D "e5274423e17b7c9fc20b6e7e208532f=
9b19825d82dfd615708b70edd83df41f1"
+SRC_URI[hashbrown-0.15.5.sha256sum] =3D "9229cfe53dfd69f0609a49f65461bd9=
3001ea1ef889cd5529dd176593f5338a1"
+SRC_URI[hashbrown-0.17.0.sha256sum] =3D "4f467dd6dccf739c208452f8014c75c=
18bb8301b050ad1cfb27153803edb0f51"
 SRC_URI[hashlink-0.8.4.sha256sum] =3D "e8094feaf31ff591f651a2664fb9cfd92=
bba7a60ce3197265e9482ebe753c8f7"
 SRC_URI[heck-0.3.3.sha256sum] =3D "6d621efb26863f0e9924c6ac577e8275e5e6b=
77455db64ffa6c65c904e9e132c"
-SRC_URI[heck-0.4.1.sha256sum] =3D "95505c38b4572b2d910cecb0281560f54b440=
a19336cbbcb27bf6ce6adc6f5a8"
-SRC_URI[hermit-abi-0.3.3.sha256sum] =3D "d77f7ec81a6d05a3abb01ab6eb7590f=
6083d08449fe5a1c8b1e620283546ccb7"
+SRC_URI[heck-0.5.0.sha256sum] =3D "2304e00983f87ffb38b55b444b5e3b60a884b=
5d30c0fca7d82fe33449bbe55ea"
+SRC_URI[hermit-abi-0.1.19.sha256sum] =3D "62b467343b94ba476dcb2500d242da=
dbb39557df889310ac77c5d99100aaac33"
+SRC_URI[hermit-abi-0.5.2.sha256sum] =3D "fc0fef456e4baa96da950455cd02c08=
1ca953b141298e41db3fc7e36b1da849c"
 SRC_URI[hex-0.4.3.sha256sum] =3D "7f24254aa9a54b5c858eaee2f5bccdb46aaf0e=
486a595ed5fd8f86ba55232a70"
-SRC_URI[home-0.5.5.sha256sum] =3D "5444c27eef6923071f7ebcc33e3444508466a=
76f7a2b93da00ed6e19f30c1ddb"
+SRC_URI[home-0.5.11.sha256sum] =3D "589533453244b0995c858700322199b2becb=
13b627df2851f64a2775d024abcf"
 SRC_URI[hostname-validator-1.1.1.sha256sum] =3D "f558a64ac9af88b5ba400d9=
9b579451af0d39c6d360980045b91aac966d705e2"
-SRC_URI[humantime-2.1.0.sha256sum] =3D "9a3a5bfb195931eeb336b2a7b4d761da=
ec841b97f947d34394601737a7bba5e4"
-SRC_URI[idna-0.4.0.sha256sum] =3D "7d20d6b07bfbc108882d88ed8e37d39636dcc=
260e15e30c45e6ba089610b917c"
-SRC_URI[indexmap-2.0.2.sha256sum] =3D "8adf3ddd720272c6ea8bf59463c04e0f9=
3d0bbf7c5439b691bca2987e0270897"
-SRC_URI[instant-0.1.12.sha256sum] =3D "7a5bbe824c507c5da5956355e86a746d8=
2e0e1464f65d862cc5e71da70e94b2c"
-SRC_URI[is-terminal-0.4.9.sha256sum] =3D "cb0889898416213fab133e1d33a0e5=
858a48177452750691bde3666d0fdbaf8b"
+SRC_URI[humantime-2.3.0.sha256sum] =3D "135b12329e5e3ce057a9f972339ea52b=
c954fe1e9358ef27f95e89716fbc5424"
+SRC_URI[icu_collections-2.1.1.sha256sum] =3D "4c6b649701667bbe825c3b7e63=
88cb521c23d88644678e83c0c4d0a621a34b43"
+SRC_URI[icu_locale_core-2.1.1.sha256sum] =3D "edba7861004dd3714265b4db54=
a3c390e880ab658fec5f7db895fae2046b5bb6"
+SRC_URI[icu_normalizer-2.1.1.sha256sum] =3D "5f6c8828b67bf8908d82127b205=
4ea1b4427ff0230ee9141c54251934ab1b599"
+SRC_URI[icu_normalizer_data-2.1.1.sha256sum] =3D "7aedcccd01fc5fe81e6b48=
9c15b247b8b0690feb23304303a9e560f37efc560a"
+SRC_URI[icu_properties-2.1.2.sha256sum] =3D "020bfc02fe870ec3a66d93e677c=
cca0562506e5872c650f893269e08615d74ec"
+SRC_URI[icu_properties_data-2.1.2.sha256sum] =3D "616c294cf8d725c6afcd8f=
55abc17c56464ef6211f9ed59cccffe534129c77af"
+SRC_URI[icu_provider-2.1.1.sha256sum] =3D "85962cf0ce02e1e0a629cc34e7ca3=
e373ce20dda4c4d7294bbd0bf1fdb59e614"
+SRC_URI[id-arena-2.3.0.sha256sum] =3D "3d3067d79b975e8844ca9eb072e16b31c=
3c1c36928edf9c6789548c524d0d954"
+SRC_URI[idna-1.1.0.sha256sum] =3D "3b0875f23caa03898994f6ddc501886a45c7d=
3d62d04d2d90788d47be1b1e4de"
+SRC_URI[idna_adapter-1.2.1.sha256sum] =3D "3acae9609540aa318d1bc58845522=
5fb2085b9ed0c4f6bd0d9d5bcd86f1a0344"
+SRC_URI[indexmap-2.14.0.sha256sum] =3D "d466e9454f08e4a911e14806c24e16fb=
a1b4c121d1ea474396f396069cf949d9"
+SRC_URI[is_terminal_polyfill-1.70.2.sha256sum] =3D "a6cb138bb79a146c1bd4=
60005623e142ef0181e3d0219cb493e02f7d08a35695"
 SRC_URI[itertools-0.10.5.sha256sum] =3D "b0fd2260e829bddf4cb6ea802289de2=
f86d6a7a690192fbe91b3f46e0f2c8473"
-SRC_URI[itoa-1.0.9.sha256sum] =3D "af150ab688ff2122fcef229be89cb50dd66af=
9e01a4ff320cc137eecc9bacc38"
-SRC_URI[js-sys-0.3.64.sha256sum] =3D "c5f195fe497f702db0f318b07fdd68edb1=
6955aed830df8363d837542f8f935a"
+SRC_URI[itertools-0.13.0.sha256sum] =3D "413ee7dfc52ee1a4949ceeb7dbc8a33=
f2d6c088194d9f922fb8318faf1f01186"
+SRC_URI[itoa-1.0.18.sha256sum] =3D "8f42a60cbdf9a97f5d2305f08a87dc4e0930=
8d1276d28c869c684d7777685682"
+SRC_URI[jiff-0.2.24.sha256sum] =3D "f00b5dbd620d61dfdcb6007c9c1f6054ebd7=
5319f163d886a9055cec1155073d"
+SRC_URI[jiff-static-0.2.24.sha256sum] =3D "e000de030ff8022ea1da3f466fbb0=
f3a809f5e51ed31f6dd931c35181ad8e6d7"
+SRC_URI[js-sys-0.3.97.sha256sum] =3D "a1840c94c045fbcf8ba2812c95db44499f=
7c64910a912551aaaa541decebcacf"
 SRC_URI[jsonwebkey-0.3.5.sha256sum] =3D "c57c852b14147e2bd58c14fde403988=
64453403ef632b1101db130282ee6e2cc"
 SRC_URI[jsonwebtoken-8.3.0.sha256sum] =3D "6971da4d9c3aa03c3d8f3ff0f4155=
b534aad021292003895a469716b2a230378"
-SRC_URI[lazy_static-1.4.0.sha256sum] =3D "e2abad23fbc42b3700f2f279844dc8=
32adb2b2eb069b2df918f455c4e18cc646"
+SRC_URI[lazy_static-1.5.0.sha256sum] =3D "bbd2bcb4c963f2ddae06a2efc7e9f3=
591312473c50c6685e1f298068316e66fe"
 SRC_URI[lazycell-1.3.0.sha256sum] =3D "830d08ce1d1d941e6b30645f1a0eb5643=
013d835ce3779a5fc208261dbe10f55"
-SRC_URI[libc-0.2.149.sha256sum] =3D "a08173bc88b7955d1b3145aa561539096c4=
21ac8debde8cbc3612ec635fee29b"
-SRC_URI[libloading-0.7.4.sha256sum] =3D "b67380fd3b2fbe7527a606e18729d21=
c6f3951633d0500574c4dc22d2d638b9f"
+SRC_URI[leb128fmt-0.1.0.sha256sum] =3D "09edd9e8b54e49e587e4f6295a7d29c3=
ea94d469cb40ab8ca70b288248a81db2"
+SRC_URI[libc-0.2.186.sha256sum] =3D "68ab91017fe16c622486840e4c83c9a37af=
eff978bd239b5293d61ece587de66"
+SRC_URI[libloading-0.8.9.sha256sum] =3D "d7c4b02199fee7c5d21a5ae7d8cfa79=
a6ef5bb2fc834d6e9058e89c825efdc55"
 SRC_URI[libsqlite3-sys-0.26.0.sha256sum] =3D "afc22eff61b133b115c6e8c74e=
818c628d6d5e7a502afea6f64dee076dd94326"
-SRC_URI[libz-sys-1.1.12.sha256sum] =3D "d97137b25e321a73eef1418d1d5d2eda=
4d77e12813f8e6dead84bc52c5870a7b"
-SRC_URI[linux-raw-sys-0.4.10.sha256sum] =3D "da2479e8c062e40bf0066ffa0bc=
823de0a9368974af99c9f6df941d2c231e03f"
-SRC_URI[lock_api-0.4.10.sha256sum] =3D "c1cc9717a20b1bb222f333e6a92fd32f=
7d8a18ddc5a3191a11af45dcbf4dcd16"
-SRC_URI[log-0.4.20.sha256sum] =3D "b5e6163cb8c49088c2c36f57875e58ccd8c87=
c7427f7fbd50ea6710b2f3f2e8f"
-SRC_URI[mbox-0.6.0.sha256sum] =3D "0f88d5c34d63aad11aa4321ef55ccb064af58=
b3ad8091079ae22bf83e5eb75d6"
-SRC_URI[memchr-2.6.4.sha256sum] =3D "f665ee40bc4a3c5590afb1e9677db74a508=
659dfd71e126420da8274909a0167"
+SRC_URI[libz-sys-1.1.28.sha256sum] =3D "fc3a226e576f50782b3305c5ccf45869=
8f92798987f551c6a02efe8276721e22"
+SRC_URI[linux-raw-sys-0.4.15.sha256sum] =3D "d26c52dbd32dccf2d10cac7725f=
8eae5296885fb5703b261f7d0a0739ec807ab"
+SRC_URI[linux-raw-sys-0.12.1.sha256sum] =3D "32a66949e030da00e8c7d4434b2=
51670a91556f4144941d37452769c25d58a53"
+SRC_URI[litemap-0.8.2.sha256sum] =3D "92daf443525c4cce67b150400bc2316076=
100ce0b3686209eb8cf3c31612e6f0"
+SRC_URI[lock_api-0.4.14.sha256sum] =3D "224399e74b87b5f3557511d98dff8b14=
089b3dadafcab6bb93eab67d3aace965"
+SRC_URI[log-0.4.29.sha256sum] =3D "5e5032e24019045c762d3c0f28f5b6b8bbf38=
563a65908389bf7978758920897"
+SRC_URI[mbox-0.7.1.sha256sum] =3D "26d142aeadbc4e8c679fc6d93fbe7efe1c021=
fa7d80629e615915b519e3bc6de"
+SRC_URI[memchr-2.8.0.sha256sum] =3D "f8ca58f447f06ed17d5fc4043ce1b10dd20=
5e060fb3ce5b979b8ed8e59ff3f79"
 SRC_URI[minimal-lexical-0.2.1.sha256sum] =3D "68354c5c6bd36d73ff3feceb05=
efa59b6acb7626617f4962be322a825e61f79a"
 SRC_URI[multimap-0.8.3.sha256sum] =3D "e5ce46fe64a9d73be07dcbe690a38ce1b=
293be448fd8ce1e6c1b8062c9f72c6a"
-SRC_URI[nom-5.1.3.sha256sum] =3D "08959a387a676302eebf4ddbcbc611da042855=
79f76f88ee0506c63b1a61dd4b"
 SRC_URI[nom-7.1.3.sha256sum] =3D "d273983c5a657a70a3e8f2a01329822f3b8c81=
72b73826411a55751e404a0a4a"
-SRC_URI[num-0.4.1.sha256sum] =3D "b05180d69e3da0e530ba2a1dae5110317e49e3=
b7f3d41be227dc5f92e49ee7af"
-SRC_URI[num-bigint-0.4.4.sha256sum] =3D "608e7659b5c3d7cba262d894801b9ec=
9d00de989e8a82bd4bef91d08da45cdc0"
-SRC_URI[num-complex-0.4.4.sha256sum] =3D "1ba157ca0885411de85d6ca030ba7e=
2a83a28636056c7c699b07c8b6f7383214"
-SRC_URI[num-derive-0.4.1.sha256sum] =3D "cfb77679af88f8b125209d354a20286=
2602672222e7f2313fdd6dc349bad4712"
-SRC_URI[num-integer-0.1.45.sha256sum] =3D "225d3389fb3509a24c93f5c29eb6b=
de2586b98d9f016636dff58d7c6f7569cd9"
-SRC_URI[num-iter-0.1.43.sha256sum] =3D "7d03e6c028c5dc5cac6e2dec0efda81f=
c887605bb3d884578bb6d6bf7514e252"
-SRC_URI[num-rational-0.4.1.sha256sum] =3D "0638a1c9d0a3c0914158145bc76cf=
f373a75a627e6ecbfb71cbe6f453a5a19b0"
-SRC_URI[num-traits-0.2.17.sha256sum] =3D "39e3200413f237f41ab11ad6d161bc=
7239c84dcb631773ccd7de3dfe4b5c267c"
-SRC_URI[num_cpus-1.16.0.sha256sum] =3D "4161fcb6d602d4d2081af7c3a45852d8=
75a03dd337a6bfdd6e06407b61342a43"
+SRC_URI[num-0.4.3.sha256sum] =3D "35bd024e8b2ff75562e5f34e7f4905839deb4b=
22955ef5e73d2fea1b9813cb23"
+SRC_URI[num-bigint-0.4.6.sha256sum] =3D "a5e44f723f1133c9deac646763579fd=
b3ac745e418f2a7af9cd0c431da1f20b9"
+SRC_URI[num-complex-0.4.6.sha256sum] =3D "73f88a1307638156682bada9d76041=
35552957b7818057dcef22705b4d509495"
+SRC_URI[num-conv-0.1.0.sha256sum] =3D "51d515d32fb182ee37cda2ccdcb92950d=
6a3c2893aa280e540671c2cd0f3b1d9"
+SRC_URI[num-derive-0.4.2.sha256sum] =3D "ed3955f1a9c7c0c15e092f9c887db08=
b1fc683305fdf6eb6684f22555355e202"
+SRC_URI[num-integer-0.1.46.sha256sum] =3D "7969661fd2958a5cb096e56c8e1ad=
0444ac2bbcd0061bd28660485a44879858f"
+SRC_URI[num-iter-0.1.45.sha256sum] =3D "1429034a0490724d0075ebb2bc9e875d=
6503c3cf69e235a8941aa757d83ef5bf"
+SRC_URI[num-rational-0.4.2.sha256sum] =3D "f83d14da390562dca69fc84082e73=
e548e1ad308d24accdedd2720017cb37824"
+SRC_URI[num-traits-0.2.19.sha256sum] =3D "071dfc062690e90b734c0b2273ce72=
ad0ffa95f0c74596bc250dcfd960262841"
+SRC_URI[num_cpus-1.17.0.sha256sum] =3D "91df4bbde75afed763b708b7eee1e8e7=
651e02d97f6d5dd763e89367e957b23b"
 SRC_URI[oid-0.2.1.sha256sum] =3D "9c19903c598813dba001b53beeae59bb77ad48=
92c5c1b9b3500ce4293a0d06c2"
-SRC_URI[oid-registry-0.4.0.sha256sum] =3D "38e20717fa0541f39bd146692035c=
37bedfa532b3e5071b35761082407546b2a"
-SRC_URI[once_cell-1.18.0.sha256sum] =3D "dd8b5dd2ae5ed71462c540258bedcb5=
1965123ad7e7ccf4b9a8cafaa4a63576d"
-SRC_URI[parking_lot-0.11.2.sha256sum] =3D "7d17b78036a60663b797adeaee46f=
5c9dfebb86948d1255007a1d6be0271ff99"
-SRC_URI[parking_lot_core-0.8.6.sha256sum] =3D "60a2cfe6f0ad2bfc16aefa463=
b497d5c7a5ecd44a23efa72aa342d90177356dc"
-SRC_URI[parsec-interface-0.29.1.sha256sum] =3D "cc706e09209b30f10baa3570=
9d41b9cc01d4931b21c00679f59db96cd1650add"
-SRC_URI[paste-1.0.14.sha256sum] =3D "de3145af08024dea9fa9914f381a17b8fc6=
034dfb00f3a84013f7ff43f29ed4c"
+SRC_URI[oid-registry-0.6.1.sha256sum] =3D "9bedf36ffb6ba96c2eb7144ef6270=
557b52e54b20c0a8e1eb2ff99a6c6959bff"
+SRC_URI[once_cell-1.21.4.sha256sum] =3D "9f7c3e4beb33f85d45ae3e3a1792185=
706c8e16d043238c593331cc7cd313b50"
+SRC_URI[once_cell_polyfill-1.70.2.sha256sum] =3D "384b8ab6d37215f3c5301a=
95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
+SRC_URI[parking_lot-0.12.5.sha256sum] =3D "93857453250e3077bd71ff98b6a65=
ea6621a19bb0f559a85248955ac12c45a1a"
+SRC_URI[parking_lot_core-0.9.12.sha256sum] =3D "2621685985a2ebf1c516881c=
026032ac7deafcda1a2c9b7850dc81e3dfcb64c1"
+SRC_URI[parsec-interface-0.30.0.sha256sum] =3D "762be858811b1d6f1b015240=
6835a3f588bff2ada832c5dc4022c3ba2f812d3c"
 SRC_URI[peeking_take_while-0.1.2.sha256sum] =3D "19b17cddbe7ec3f8bc80088=
7bab5e717348c95ea2ca0b1bf0837fb964dc67099"
 SRC_URI[pem-1.1.1.sha256sum] =3D "a8835c273a76a90455d7344889b0964598e331=
6e2a79ede8e36f16bdcf2228b8"
-SRC_URI[percent-encoding-2.3.0.sha256sum] =3D "9b2a4787296e9989611394c33=
f193f676704af1686e70b8f8033ab5ba9a35a94"
-SRC_URI[pest-2.7.4.sha256sum] =3D "c022f1e7b65d6a24c0dbbd5fb344c66881bc0=
1f3e5ae74a1c8100f2f985d98a4"
-SRC_URI[petgraph-0.6.4.sha256sum] =3D "e1d3afd2628e69da2be385eb6f2fd57c8=
ac7977ceeff6dc166ff1657b0e386a9"
-SRC_URI[picky-asn1-0.8.0.sha256sum] =3D "295eea0f33c16be21e2a98b908fdd4d=
73c04dd48c8480991b76dbcf0cb58b212"
-SRC_URI[picky-asn1-der-0.4.1.sha256sum] =3D "5df7873a9e36d42dadb393bea5e=
211fe83d793c172afad5fb4ec846ec582793f"
-SRC_URI[picky-asn1-x509-0.12.0.sha256sum] =3D "2c5f20f71a68499ff32310f41=
8a6fad8816eac1a2859ed3f0c5c741389dd6208"
-SRC_URI[pin-project-lite-0.2.13.sha256sum] =3D "8afb450f006bf6385ca15ef4=
5d71d2288452bc3683ce2e2cacc0d18e4be60b58"
-SRC_URI[pin-utils-0.1.0.sha256sum] =3D "8b870d8c151b6f2fb93e84a13146138f=
05d02ed11c7e7c54f8826aaaf7c9f184"
-SRC_URI[pkcs8-0.8.0.sha256sum] =3D "7cabda3fb821068a9a4fab19a683eac3af12=
edf0f34b94a8be53c4972b8149d0"
-SRC_URI[pkg-config-0.3.27.sha256sum] =3D "26072860ba924cbfa98ea39c8c19b4=
dd6a4a25423dbdf219c1eca91aa0cf6964"
-SRC_URI[ppv-lite86-0.2.17.sha256sum] =3D "5b40af805b3121feab8a3c29f04d8a=
d262fa8e0561883e7653e024ae4479e6de"
-SRC_URI[prettyplease-0.2.15.sha256sum] =3D "ae005bd773ab59b4725093fd7df8=
3fd7892f7d8eafb48dbd7de6e024e4215f9d"
-SRC_URI[proc-macro2-1.0.69.sha256sum] =3D "134c189feb4956b20f6f547d2cf72=
7d4c0fe06722b20a0eec87ed445a97f92da"
+SRC_URI[percent-encoding-2.3.2.sha256sum] =3D "9b4f627cb1b25917193a259e4=
9bdad08f671f8d9708acfd5fe0a8c1455d87220"
+SRC_URI[petgraph-0.6.5.sha256sum] =3D "b4c5cc86750666a3ed20bdaf5ca2a0344=
f9c67674cae0515bec2da16fbaa47db"
+SRC_URI[picky-asn1-0.10.1.sha256sum] =3D "2ff038f9360b934342fb3c0a1d6e82=
c438a2624b51c3c6e3e6d7cf252b6f3ee3"
+SRC_URI[picky-asn1-der-0.5.6.sha256sum] =3D "d413165e4bf7f808b9a27cbaba6=
57657a2921f0965db833f488c4d4be96dcd2e"
+SRC_URI[picky-asn1-x509-0.15.4.sha256sum] =3D "859d4117bd1b1dc5646359ee7=
243c50c5000c0920ea2d1fb120335a2f4c684b8"
+SRC_URI[pin-project-lite-0.2.17.sha256sum] =3D "a89322df9ebe1c1578d689c9=
2318e070967d1042b512afbe49518723f4e6d5cd"
+SRC_URI[pkcs8-0.10.2.sha256sum] =3D "f950b2377845cebe5cf8b5165cb3cc1a5e0=
fa5cfa3e1f7f55707d8fd82e0a7b7"
+SRC_URI[pkg-config-0.3.33.sha256sum] =3D "19f132c84eca552bf34cab8ec81f1c=
1dcc229b811638f9d283dceabe58c5569e"
+SRC_URI[portable-atomic-1.13.1.sha256sum] =3D "c33a9471896f1c69cecef8d20=
cbe2f7accd12527ce60845ff44c153bb2a21b49"
+SRC_URI[portable-atomic-util-0.2.7.sha256sum] =3D "c2a106d1259c23fac8e54=
3272398ae0e3c0b8d33c88ed73d0cc71b0f1d902618"
+SRC_URI[potential_utf-0.1.5.sha256sum] =3D "0103b1cef7ec0cf76490e9696655=
04990193874ea05c85ff9bab8b911d0a0564"
+SRC_URI[powerfmt-0.2.0.sha256sum] =3D "439ee305def115ba05938db6eb1644ff9=
4165c5ab5e9420d1c1bcedbba909391"
+SRC_URI[ppv-lite86-0.2.21.sha256sum] =3D "85eae3c4ed2f50dcfe72643da4befc=
30deadb458a9b590d720cde2f2b1e97da9"
+SRC_URI[prettyplease-0.2.37.sha256sum] =3D "479ca8adacdd7ce8f1fb39ce9ecc=
cbfe93a3f1344b3d0d97f20bc0196208f62b"
+SRC_URI[proc-macro2-1.0.106.sha256sum] =3D "8fd00f0bb2e90d81d1044c2b3261=
7f68fcb9fa3bb7640c23e9c748e53fb30934"
 SRC_URI[prost-0.9.0.sha256sum] =3D "444879275cb4fd84958b1a1d5420d15e6fcf=
7c235fe47f053c9c2a80aceb6001"
 SRC_URI[prost-build-0.9.0.sha256sum] =3D "62941722fb675d463659e49c4f3fe1=
fe792ff24fe5bbaa9c08cd3b98a1c354f5"
 SRC_URI[prost-derive-0.9.0.sha256sum] =3D "f9cc1a3263e07e0bf68e96268f376=
65207b49560d98739662cdfaae215c720fe"
 SRC_URI[prost-types-0.9.0.sha256sum] =3D "534b7a0e836e3c482d2693070f982e=
39e7611da9695d4d1f5a4b186b51faef0a"
 SRC_URI[protobuf-2.28.0.sha256sum] =3D "106dd99e98437432fed6519dedecfade=
6a06a73bb7b2a1e019fdd2bee5778d94"
-SRC_URI[psa-crypto-0.12.0.sha256sum] =3D "89c2256e525b9a45ec3bbb3382a43d=
d8809240279e0aab8ea7ee220e9295445b"
-SRC_URI[psa-crypto-sys-0.12.0.sha256sum] =3D "f170cac3a328e1678916b27606=
7ec170a5a51db1b9b8b4c00b44c2839819a963"
-SRC_URI[quote-1.0.33.sha256sum] =3D "5267fca4496028628a95160fc423a33e8b2=
e6af8a5302579e322e4b520293cae"
-SRC_URI[rand-0.8.5.sha256sum] =3D "34af8d1a0e25924bc5b7c43c079c942339d8f=
0a8b57c39049bef581b46327404"
+SRC_URI[psa-crypto-0.13.0.sha256sum] =3D "2affd5dda9530f14b25f44a9ac945b=
c44925c7239561e8869b87ad5c39db0967"
+SRC_URI[psa-crypto-sys-0.13.0.sha256sum] =3D "f507eb19095cece94cafcef49c=
235dd463649e8c629c0b74fcdf9e6e16895feb"
+SRC_URI[quote-1.0.45.sha256sum] =3D "41f2619966050689382d2b44f664f4bc593=
e129785a36d6ee376ddf37259b924"
+SRC_URI[r-efi-6.0.0.sha256sum] =3D "f8dcc9c7d52a811697d2151c701e0d08956f=
92b0e24136cf4cf27b57a6a0d9bf"
+SRC_URI[rand-0.8.6.sha256sum] =3D "5ca0ecfa931c29007047d1bc58e623ab12e55=
90e8c7cc53200d5202b69266d8a"
 SRC_URI[rand_chacha-0.3.1.sha256sum] =3D "e6c10a63a0fa32252be49d21e7709d=
4d4baf8d231c2dbce1eaa8141b9b127d88"
 SRC_URI[rand_core-0.6.4.sha256sum] =3D "ec0be4795e2f6a28069bec0b5ff3e2ac=
9bafc99e6a9a7dc3547996c5c816922c"
-SRC_URI[redox_syscall-0.2.16.sha256sum] =3D "fb5a58c1855b4b6819d59012155=
603f0b22ad30cad752600aadfcb695265519a"
-SRC_URI[redox_syscall-0.3.5.sha256sum] =3D "567664f262709473930a4bf9e51b=
f2ebf3348f2e748ccc50dea20646858f8f29"
-SRC_URI[regex-1.9.6.sha256sum] =3D "ebee201405406dbf528b8b672104ae6d6d63=
e6d118cb10e4d51abbc7b58044ff"
-SRC_URI[regex-automata-0.3.9.sha256sum] =3D "59b23e92ee4318893fa3fe3e6fb=
365258efbfe6ac6ab30f090cdcbb7aa37efa9"
-SRC_URI[regex-syntax-0.7.5.sha256sum] =3D "dbb5fb1acd8a1a18b3dd5be62d254=
85eb770e05afb408a9627d14d451bae12da"
+SRC_URI[redox_syscall-0.5.18.sha256sum] =3D "ed2bf2547551a7053d6fdfafda3=
f938979645c44812fbfcda098faae3f1a362d"
+SRC_URI[regex-1.12.3.sha256sum] =3D "e10754a14b9137dd7b1e3e5b0493cc9171f=
dd105e0ab477f51b72e7f3ac0e276"
+SRC_URI[regex-automata-0.4.14.sha256sum] =3D "6e1dd4122fc1595e8162618945=
476892eefca7b88c52820e74af6262213cae8f"
+SRC_URI[regex-syntax-0.8.10.sha256sum] =3D "dc897dd8d9e8bd1ed8cdad82b596=
6c3e0ecae09fb1907d58efaa013543185d0a"
 SRC_URI[ring-0.16.20.sha256sum] =3D "3053cf52e236a3ed746dfc745aa9cacf1b7=
91d846bdaf412f60a8d7d6e17c8fc"
 SRC_URI[rusqlite-0.29.0.sha256sum] =3D "549b9d036d571d42e6e85d1c1425e2ac=
83491075078ca9a15be021c56b1641f2"
 SRC_URI[rust-cryptoauthlib-0.4.5.sha256sum] =3D "adab07508c090715a5cd3d0=
72f2b8ab60d7e9e04c5af19e1d3d819651b5b25a2"
 SRC_URI[rustc-hash-1.1.0.sha256sum] =3D "08d43f7aa6b08d49f382cde6a798204=
7c3426db949b1424bc4b7ec9ae12c6ce2"
-SRC_URI[rustc_version-0.3.3.sha256sum] =3D "f0dfe2087c51c460008730de8b57=
e6a320782fbfb312e1f4d520e6c6fae155ee"
+SRC_URI[rustc-hash-2.1.2.sha256sum] =3D "94300abf3f1ae2e2b8ffb7b58043de3=
d399c73fa6f4b73826402a5c457614dbe"
 SRC_URI[rusticata-macros-4.1.0.sha256sum] =3D "faf0c4a6ece9950b9abdb62b1=
cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
-SRC_URI[rustix-0.38.21.sha256sum] =3D "2b426b0506e5d50a7d8dafcf2e8147140=
0deb602392c7dd110815afb4eaf02a3"
-SRC_URI[ryu-1.0.15.sha256sum] =3D "1ad4cc8da4ef723ed60bced201181d83791ad=
433213d8c24efffda1eec85d741"
+SRC_URI[rustix-0.38.44.sha256sum] =3D "fdb5bc1ae2baa591800df16c9ca78619b=
f65c0488b41b96ccec5d11220d8c154"
+SRC_URI[rustix-1.1.4.sha256sum] =3D "b6fe4565b9518b83ef4f91bb47ce29620ca=
828bd32cb7e408f0062e9930ba190"
+SRC_URI[rustversion-1.0.22.sha256sum] =3D "b39cdef0fa800fc44525c84ccb54a=
029961a8215f9619753635a9c0d2538d46d"
 SRC_URI[same-file-1.0.6.sha256sum] =3D "93fc1dc3aaa9bfed95e02e6eadabb4ba=
f7e3078b0bd1b4d7b6b0b68378900502"
 SRC_URI[scopeguard-1.2.0.sha256sum] =3D "94143f37725109f92c262ed2cf5e59b=
ce7498c01bcc1502d7b9afe439a4e9f49"
-SRC_URI[sd-notify-0.4.1.sha256sum] =3D "621e3680f3e07db4c9c2c3fb07c6223a=
b2fab2e54bd3c04c3ae037990f428c32"
+SRC_URI[sd-notify-0.5.0.sha256sum] =3D "3e4ef7359e694bfaf1dd27a30f9d760b=
54c00dfae9f19bd0c05a39bc9128fe76"
 SRC_URI[secrecy-0.8.0.sha256sum] =3D "9bd1c54ea06cfd2f6b63219704de0b9b4f=
72dcc2b8fdef820be6cd799780e91e"
-SRC_URI[semver-0.11.0.sha256sum] =3D "f301af10236f6df4160f7c3f04eec6dbc7=
0ace82d23326abad5edee88801c6b6"
-SRC_URI[semver-parser-0.10.2.sha256sum] =3D "00b0bef5b7f9e0df16536d3961c=
fb6e84331c065b4066afb39768d0e319411f7"
-SRC_URI[serde-1.0.188.sha256sum] =3D "cf9e0fcba69a370eed61bcf2b728575f72=
6b50b55cba78064753d708ddc7549e"
-SRC_URI[serde_bytes-0.11.12.sha256sum] =3D "ab33ec92f677585af6d88c65593a=
e2375adde54efdbf16d597f2cbc7a6d368ff"
-SRC_URI[serde_derive-1.0.188.sha256sum] =3D "4eca7ac642d82aa35b60049a6ec=
cb4be6be75e599bd2e9adb5f875a737654af2"
-SRC_URI[serde_json-1.0.107.sha256sum] =3D "6b420ce6e3d8bd882e9b243c6eed3=
5dbc9a6110c9769e74b584e0d68d1f20c65"
-SRC_URI[serde_spanned-0.6.3.sha256sum] =3D "96426c9936fd7a0124915f9185ea=
1d20aa9445cc9821142f0a73bc9207a2e186"
-SRC_URI[shlex-0.1.1.sha256sum] =3D "7fdf1b9db47230893d76faad238fd6097fd6=
d6a9245cd7a4d90dbd639536bbd2"
-SRC_URI[shlex-1.2.0.sha256sum] =3D "a7cee0529a6d40f580e7a5e6c495c8fbfe21=
b7b52795ed4bb5e62cdf92bc6380"
-SRC_URI[signal-hook-0.3.17.sha256sum] =3D "8621587d4798caf8eb44879d42e56=
b9a93ea5dcd315a6487c357130095b62801"
-SRC_URI[signal-hook-registry-1.4.1.sha256sum] =3D "d8229b473baa5980ac72e=
f434c4415e70c4b5e71b423043adb4ba059f89c99a1"
-SRC_URI[simple_asn1-0.6.2.sha256sum] =3D "adc4e5204eb1910f40f9cfa375f6f0=
5b68c3abac4b6fd879c8ff5e7ae8a0a085"
-SRC_URI[slab-0.4.9.sha256sum] =3D "8f92a496fb766b417c996b9c5e57daf2f7ad3=
b0bebe1ccfca4856390e3d3bb67"
-SRC_URI[smallvec-1.11.1.sha256sum] =3D "942b4a808e05215192e39f4ab80813e5=
99068285906cc91aa64f923db842bd5a"
-SRC_URI[spiffe-0.2.1.sha256sum] =3D "f30161ecb25b9acc06eb61d750aaf1c4b3a=
536e22ff19fc2d250976537e93a11"
+SRC_URI[secrecy-0.10.3.sha256sum] =3D "e891af845473308773346dc847b2c23ee=
78fe442e0472ac50e22a18a93d3ae5a"
+SRC_URI[semver-1.0.28.sha256sum] =3D "8a7852d02fc848982e0c167ef163aaff9c=
d91dc640ba85e263cb1ce46fae51cd"
+SRC_URI[serde-1.0.228.sha256sum] =3D "9a8e94ea7f378bd32cbbd37198a4a91436=
180c5bb472411e48b5ec2e2124ae9e"
+SRC_URI[serde_bytes-0.11.19.sha256sum] =3D "a5d440709e79d88e51ac01c4b72f=
c6cb7314017bb7da9eeff678aa94c10e3ea8"
+SRC_URI[serde_core-1.0.228.sha256sum] =3D "41d385c7d4ca58e59fc732af25c39=
83b67ac852c1a25000afe1175de458b67ad"
+SRC_URI[serde_derive-1.0.228.sha256sum] =3D "d540f220d3187173da220f885ab=
66608367b6574e925011a9353e4badda91d79"
+SRC_URI[serde_json-1.0.149.sha256sum] =3D "83fc039473c5595ace860d8c4fafa=
220ff474b3fc6bfdb4293327f1a37e94d86"
+SRC_URI[serde_spanned-1.1.1.sha256sum] =3D "6662b5879511e06e8999a8a235d8=
48113e942c9124f211511b16466ee2995f26"
+SRC_URI[shlex-1.3.0.sha256sum] =3D "0fda2ff0d084019ba4d7c6f371c95d8fd75c=
e3524c3cb8fb653a3023f6323e64"
+SRC_URI[signal-hook-0.4.4.sha256sum] =3D "b2a0c28ca5908dbdbcd52e6fdaa003=
58ab88637f8ab33e1f188dd510eb44b53d"
+SRC_URI[signal-hook-registry-1.4.8.sha256sum] =3D "c4db69cba1110affc0e9f=
7bcd48bbf87b3f4fc7c61fc9155afd4c469eb3d6c1b"
+SRC_URI[simple_asn1-0.6.3.sha256sum] =3D "297f631f50729c8c99b84667867963=
997ec0b50f32b2a7dbcab828ef0541e8bb"
+SRC_URI[slab-0.4.12.sha256sum] =3D "0c790de23124f9ab44544d7ac05d60440adc=
586479ce501c1d6d7da3cd8c9cf5"
+SRC_URI[smallvec-1.15.1.sha256sum] =3D "67b1b7a3b5fe4f1376887184045fcf45=
c69e92af734b7aaddc05fb777b6fbd03"
+SRC_URI[spiffe-0.2.2.sha256sum] =3D "9d8e841864fab2d5f3eebf1f1564658c041=
c9db6604065f0b5ea3185f16b531c"
 SRC_URI[spin-0.5.2.sha256sum] =3D "6e63cff320ae2c57904679ba7cb63280a3dc4=
613885beafb148ee7bf9aa9042d"
-SRC_URI[spki-0.5.4.sha256sum] =3D "44d01ac02a6ccf3e07db148d2be087da624fe=
a0221a16152ed01f0496a6b0a27"
-SRC_URI[stable_deref_trait-1.2.0.sha256sum] =3D "a8f112729512f8e442d81f9=
5a8a7ddf2b7c6b8a1a6f509a95864142b30cab2d3"
-SRC_URI[strsim-0.10.0.sha256sum] =3D "73473c0e59e6d5812c5dfe2a064a644494=
9f089e20eec9a2e5506596494e4623"
+SRC_URI[spki-0.7.3.sha256sum] =3D "d91ed6c858b01f942cd56b37a94b3e0a17982=
90327d1236e4d9cf4eaca44d29d"
+SRC_URI[stable_deref_trait-1.2.1.sha256sum] =3D "6ce2be8dc25455e1f91df71=
bfa12ad37d7af1092ae736f3a6cd0e37bc7810596"
+SRC_URI[strsim-0.8.0.sha256sum] =3D "8ea5119cdb4c55b55d432abb513a0429384=
878c15dde60cc77b1c99de1a95a6a"
+SRC_URI[strsim-0.11.1.sha256sum] =3D "7da8b5736845d9f2fcb837ea5d9e262856=
4b3b043a70948a3f0b778838c5fb4f"
 SRC_URI[strum_macros-0.21.1.sha256sum] =3D "d06aaeeee809dbc59eb4556183dd=
927df67db1540de5be8d3ec0b6636358a5ec"
 SRC_URI[syn-1.0.109.sha256sum] =3D "72b64191b275b66ffe2469e8af2c1cfe3baf=
a67b529ead792a6d0160888b4237"
-SRC_URI[syn-2.0.38.sha256sum] =3D "e96b79aaa137db8f61e26363a0c9b47d8b4ec=
75da28b7d1d614c2303e232408b"
+SRC_URI[syn-2.0.117.sha256sum] =3D "e665b8803e7b1d2a727f4023456bbbbe74da=
67099c585258af0ad9c5013b9b99"
 SRC_URI[synstructure-0.12.6.sha256sum] =3D "f36bdaa60a83aca3921b5259d540=
0cbf5e90fc51931376a9bd4a0eb79aa7210f"
-SRC_URI[target-lexicon-0.12.11.sha256sum] =3D "9d0e916b1148c8e263850e1eb=
cbd046f333e0683c724876bb0da63ea4373dc8a"
-SRC_URI[tempfile-3.8.0.sha256sum] =3D "cb94d2f3cc536af71caac6b6fcebf6586=
0b347e7ce0cc9ebe8f70d3e521054ef"
-SRC_URI[termcolor-1.3.0.sha256sum] =3D "6093bad37da69aab9d123a8091e4be0a=
a4a03e4d601ec641c327398315f62b64"
-SRC_URI[thiserror-1.0.49.sha256sum] =3D "1177e8c6d7ede7afde3585fd2513e61=
1227efd6481bd78d2e82ba1ce16557ed4"
-SRC_URI[thiserror-impl-1.0.49.sha256sum] =3D "10712f02019e9288794769fba9=
5cd6847df9874d49d871d062172f9dd41bc4cc"
+SRC_URI[synstructure-0.13.2.sha256sum] =3D "728a70f3dbaf5bab7f0c4b1ac8d7=
ae5ea60a4b5549c8a5914361c99147a709d2"
+SRC_URI[target-lexicon-0.12.16.sha256sum] =3D "61c41af27dd6d1e27b1b16b48=
9db798443478cef1f06a660c96db617ba5de3b1"
+SRC_URI[tempfile-3.27.0.sha256sum] =3D "32497e9a4c7b38532efcdebeef879707=
aa9f794296a4f0244f6f69e9bc8574bd"
+SRC_URI[termcolor-1.4.1.sha256sum] =3D "06794f8f6c5c898b3275aebefa6b8a1c=
b24cd2c6c79397ab15774837a0bc5755"
+SRC_URI[textwrap-0.11.0.sha256sum] =3D "d326610f408c7a4eb6f51c37c330e496=
b08506c9457c9d34287ecc38809fb060"
+SRC_URI[thiserror-1.0.69.sha256sum] =3D "b6aaf5339b578ea85b50e080feb250a=
3e8ae8cfcdff9a461c9ec2904bc923f52"
+SRC_URI[thiserror-2.0.18.sha256sum] =3D "4288b5bcbc7920c07a1149a35cf9590=
a2aa808e0bc1eafaade0b80947865fbc4"
+SRC_URI[thiserror-impl-1.0.69.sha256sum] =3D "4fee6c4efc90059e10f81e6d42=
c60a18f76588c3d74cb83a0b242a2b6c7504c1"
+SRC_URI[thiserror-impl-2.0.18.sha256sum] =3D "ebc4ee7f67670e9b64d05fa425=
3e753e016c6c95ff35b89b7941d6b856dec1d5"
 SRC_URI[threadpool-1.8.1.sha256sum] =3D "d050e60b33d41c19108b32cea321640=
33a9013fe3b46cbd4457559bfbf77afaa"
-SRC_URI[time-0.3.23.sha256sum] =3D "59e399c068f43a5d116fedaf73b203fa4f9c=
519f17e2b34f63221d3792f81446"
-SRC_URI[time-core-0.1.1.sha256sum] =3D "7300fbefb4dadc1af235a9cef3737cea=
692a9d97e1b9cbcd4ebdae6f8868e6fb"
-SRC_URI[time-macros-0.2.10.sha256sum] =3D "96ba15a897f3c86766b757e5ac722=
1554c6750054d74d5b28844fce5fb36a6c4"
-SRC_URI[tinyvec-1.6.0.sha256sum] =3D "87cc5ceb3875bb20c2890005a4e226a465=
1264a5c75edb2421b52861a0a0cb50"
-SRC_URI[tinyvec_macros-0.1.1.sha256sum] =3D "1f3ccbac311fea05f86f61904b4=
62b55fb3df8837a366dfc601a0161d0532f20"
-SRC_URI[toml-0.8.2.sha256sum] =3D "185d8ab0dfbb35cf1399a6344d8484209c088=
f75f8f68230da55d48d95d43e3d"
-SRC_URI[toml_datetime-0.6.3.sha256sum] =3D "7cda73e2f1397b1262d6dfdcef8a=
afae14d1de7748d66822d3bfeeb6d03e5e4b"
-SRC_URI[toml_edit-0.20.2.sha256sum] =3D "396e4d48bbb2b7554c944bde63101b5=
ae446cff6ec4a24227428f15eb72ef338"
-SRC_URI[tss-esapi-7.5.0.sha256sum] =3D "d36722a0888ff29225d11ea205f10319=
d6cb4d072ef3c91bf3509f7f476d89e3"
-SRC_URI[tss-esapi-sys-0.5.0.sha256sum] =3D "535cd192581c2ec4d5f82e670b1d=
3fbba6a23ccce8c85de387642051d7cad5b5"
-SRC_URI[typenum-1.17.0.sha256sum] =3D "42ff0bf0c66b8238c6f3b578df37d0b78=
48e55df8577b3f74f92a69acceeb825"
-SRC_URI[ucd-trie-0.1.6.sha256sum] =3D "ed646292ffc8188ef8ea4d1e0e0150fb1=
5a5c2e12ad9b8fc191ae7a8a7f3c4b9"
-SRC_URI[unicode-bidi-0.3.13.sha256sum] =3D "92888ba5573ff080736b3648696b=
70cafad7d250551175acbaa4e0385b3e1460"
-SRC_URI[unicode-ident-1.0.12.sha256sum] =3D "3354b9ac3fae1ff6755cb6db536=
83adb661634f67557942dea4facebec0fee4b"
-SRC_URI[unicode-normalization-0.1.22.sha256sum] =3D "5c5713f0fc4b5db668a=
2ac63cdb7bb4469d8c9fed047b1d0292cc7b0ce2ba921"
-SRC_URI[unicode-segmentation-1.10.1.sha256sum] =3D "1dd62409856789511888=
6609431a7c3b8f516e41d30e0643f03d94592a147e36"
-SRC_URI[unicode-xid-0.2.4.sha256sum] =3D "f962df74c8c05a667b5ee8bcf16299=
3134c104e96440b663c8daa176dc772d8c"
+SRC_URI[time-0.3.45.sha256sum] =3D "f9e442fc33d7fdb45aa9bfeb312c095964ab=
df596f7567261062b2a7107aaabd"
+SRC_URI[time-core-0.1.7.sha256sum] =3D "8b36ee98fd31ec7426d599183e8fe269=
32a8dc1fb76ddb6214d05493377d34ca"
+SRC_URI[time-macros-0.2.25.sha256sum] =3D "71e552d1249bf61ac2a52db88179f=
d0673def1e1ad8243a00d9ec9ed71fee3dd"
+SRC_URI[tinystr-0.8.3.sha256sum] =3D "c8323304221c2a851516f22236c5722a72=
eaa19749016521d6dff0824447d96d"
+SRC_URI[toml-1.1.2+spec-1.1.0.sha256sum] =3D "81f3d15e84cbcd896376e67303=
14d59fb5a87f31e4b038454184435cd57defee"
+SRC_URI[toml_datetime-1.1.1+spec-1.1.0.sha256sum] =3D "3165f65f62e28e011=
5a00b2ebdd37eb6f3b641855f9d636d3cd4103767159ad7"
+SRC_URI[toml_parser-1.1.2+spec-1.1.0.sha256sum] =3D "a2abe9b86193656635d=
2411dc43050282ca48aa31c2451210f4202550afb7526"
+SRC_URI[toml_writer-1.1.1+spec-1.1.0.sha256sum] =3D "756daf9b1013ebe47a8=
776667b466417e2d4c5679d441c26230efd9ef78692db"
+SRC_URI[tss-esapi-7.7.0.sha256sum] =3D "3f10b25a84912b894d0e6d68f4a3771c=
923e9c44ddaaed7920cde92ed28aa84e"
+SRC_URI[tss-esapi-sys-0.6.0.sha256sum] =3D "a7f972672926a3d3d18ecc045247=
20e4d20b7d1664a3fb73dbf7d4274196dbd9"
+SRC_URI[typenum-1.20.0.sha256sum] =3D "40ce102ab67701b8526c123c1bab5cbe4=
2d7040ccfd0f64af1a385808d2f43de"
+SRC_URI[unicode-ident-1.0.24.sha256sum] =3D "e6e4313cd5fcd3dad5cafa17970=
2e2b244f760991f45397d14d4ebf38247da75"
+SRC_URI[unicode-segmentation-1.13.2.sha256sum] =3D "9629274872b2bfaf8d66=
f5f15725007f635594914870f65218920345aa11aa8c"
+SRC_URI[unicode-width-0.1.14.sha256sum] =3D "7dd6e30e90baa6f72411720665d=
41d89b9a3d039dc45b8faea1ddd07f617f6af"
+SRC_URI[unicode-xid-0.2.6.sha256sum] =3D "ebc1c04c71510c7f702b52b7c35073=
4c9ff1295c464a03335b00bb84fc54f853"
 SRC_URI[untrusted-0.7.1.sha256sum] =3D "a156c684c91ea7d62626509bce3cb4e1=
d9ed5c4d978f7b4352658f96a4c26b4a"
-SRC_URI[url-2.4.1.sha256sum] =3D "143b538f18257fac9cad154828a57c6bf5157e=
1aa604d4816b5995bf6de87ae5"
-SRC_URI[utf8parse-0.2.1.sha256sum] =3D "711b9620af191e0cdc7468a8d14e709c=
3dcdb115b36f838e601583af800a370a"
+SRC_URI[url-2.5.8.sha256sum] =3D "ff67a8a4397373c3ef660812acab3268222035=
010ab8680ec4215f38ba3d0eed"
+SRC_URI[utf16_iter-1.0.5.sha256sum] =3D "c8232dd3cdaed5356e0f716d285e4b4=
0b932ac434100fe9b7e0e8e935b9e6246"
+SRC_URI[utf8_iter-1.0.4.sha256sum] =3D "b6c140620e7ffbb22c2dee59cafe6084=
a59b5ffc27a8859a5f0d494b5d52b6be"
+SRC_URI[utf8parse-0.2.2.sha256sum] =3D "06abde3611657adf66d383f00b093d7f=
aecc7fa57071cce2578660c9f1010821"
 SRC_URI[uuid-0.8.2.sha256sum] =3D "bc5cf98d8186244414c848017f0e2676b3fcb=
46807f6668a97dfe67359a3c4b7"
 SRC_URI[vcpkg-0.2.15.sha256sum] =3D "accd4ea62f7bb7a82fe23066fb0957d48ef=
677f6eeb8215f372f52e48bb32426"
-SRC_URI[version_check-0.9.4.sha256sum] =3D "49874b5167b65d7193b8aba1567f=
5c7d93d001cafc34600cee003eda787e483f"
-SRC_URI[walkdir-2.4.0.sha256sum] =3D "d71d857dc86794ca4c280d616f7da00d2d=
bfd8cd788846559a6813e6aa4b54ee"
-SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] =3D "9c8d87e72b64a=
3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
-SRC_URI[wasm-bindgen-0.2.87.sha256sum] =3D "7706a72ab36d8cb1f80ffbf0e071=
533974a60d0a308d01a5d0375bf60499a342"
-SRC_URI[wasm-bindgen-backend-0.2.87.sha256sum] =3D "5ef2b6d3c510e9625e5f=
e6f509ab07d66a760f0885d858736483c32ed7809abd"
-SRC_URI[wasm-bindgen-macro-0.2.87.sha256sum] =3D "dee495e55982a3bd48105a=
7b947fd2a9b4a8ae3010041b9e0faab3f9cd028f1d"
-SRC_URI[wasm-bindgen-macro-support-0.2.87.sha256sum] =3D "54681b18a46765=
f095758388f2d0cf16eb8d4169b639ab575a8f5693af210c7b"
-SRC_URI[wasm-bindgen-shared-0.2.87.sha256sum] =3D "ca6ad05a4870b2bf5fe99=
5117d3728437bd27d7cd5f06f13c17443ef369775a1"
-SRC_URI[web-sys-0.3.64.sha256sum] =3D "9b85cbef8c220a6abc02aefd892dfc0fc=
23afb1c6a426316ec33253a3877249b"
+SRC_URI[vec_map-0.8.2.sha256sum] =3D "f1bddf1187be692e79c5ffeab891132dfb=
0f236ed36a43c7ed39f1165ee20191"
+SRC_URI[version_check-0.9.5.sha256sum] =3D "0b928f33d975fc6ad9f86c8f2838=
53ad26bdd5b10b7f1542aa2fa15e2289105a"
+SRC_URI[walkdir-2.5.0.sha256sum] =3D "29790946404f91d9c5d06f9874efddea1d=
c06c5efe94541a7d6863108e3a5e4b"
+SRC_URI[wasi-0.11.1+wasi-snapshot-preview1.sha256sum] =3D "ccf3ec651a847=
eb01de73ccad15eb7d99f80485de043efb2f370cd654f4ea44b"
+SRC_URI[wasip2-1.0.1+wasi-0.2.4.sha256sum] =3D "0562428422c63773dad2c345=
a1882263bbf4d65cf3f42e90921f787ef5ad58e7"
+SRC_URI[wasip3-0.4.0+wasi-0.3.0-rc-2026-01-06.sha256sum] =3D "5428f8bf88=
ea5ddc08faddef2ac4a67e390b88186c703ce6dbd955e1c145aca5"
+SRC_URI[wasm-bindgen-0.2.120.sha256sum] =3D "df52b6d9b87e0c74c9edfa1eb2d=
9bf85e5d63515474513aa50fa181b3c4f5db1"
+SRC_URI[wasm-bindgen-macro-0.2.120.sha256sum] =3D "78b1041f495fb322e64ac=
a85f5756b2172e35cd459376e67f2a6c9dffcedb103"
+SRC_URI[wasm-bindgen-macro-support-0.2.120.sha256sum] =3D "9dcd0ff204169=
88a18ac686d4d4d0f6aae9ebf08a389ff5d29012b05af2a1b41"
+SRC_URI[wasm-bindgen-shared-0.2.120.sha256sum] =3D "49757b3c82ebf16c57d6=
9365a142940b384176c24df52a087fb748e2085359ea"
+SRC_URI[wasm-encoder-0.244.0.sha256sum] =3D "990065f2fe63003fe337b932cfb=
5e3b80e0b4d0f5ff650e6985b1048f62c8319"
+SRC_URI[wasm-metadata-0.244.0.sha256sum] =3D "bb0e353e6a2fbdc176932bbaab=
493762eb1255a7900fe0fea1a2f96c296cc909"
+SRC_URI[wasmparser-0.244.0.sha256sum] =3D "47b807c72e1bac69382b3a6fb3dbe=
8ea4c0ed87ff5629b8685ae6b9a611028fe"
+SRC_URI[web-sys-0.3.97.sha256sum] =3D "2eadbac71025cd7b0834f20d1fe8472e8=
495821b4e9801eb0a60bd1f19827602"
 SRC_URI[which-4.4.2.sha256sum] =3D "87ba24419a2078cd2b0f2ede2691b6c66d8e=
47836da3b6db8265ebad47afbfc7"
 SRC_URI[winapi-0.3.9.sha256sum] =3D "5c839a674fcd7a98952e593242ea400abe9=
3992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] =3D "ac3b87c63620426=
dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-util-0.1.6.sha256sum] =3D "f29e6f9198ba0d26b4c9f07dbe6f9e=
d633e1f3d5b8b414090084349e46a52596"
+SRC_URI[winapi-util-0.1.11.sha256sum] =3D "c2a7b1c03c876122aa43f3020e6c3=
c3ee5c05081c9a00739faf7503aeba10d22"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] =3D "712e227841d05=
7c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-SRC_URI[windows-sys-0.48.0.sha256sum] =3D "677d2418bec65e3338edb076e806b=
c1ec15693c5d0104683f2efe857f61056a9"
-SRC_URI[windows-targets-0.48.5.sha256sum] =3D "9a2fa6e2155d7247be68c0964=
56083145c183cbbbc2764150dda45a87197940c"
-SRC_URI[windows_aarch64_gnullvm-0.48.5.sha256sum] =3D "2b38e32f0abccf998=
7a4e3079dfb67dcd799fb61361e53e2882c3cbaf0d905d8"
-SRC_URI[windows_aarch64_msvc-0.48.5.sha256sum] =3D "dc35310971f3b2dbbf3f=
0690a219f40e2d9afcf64f9ab7cc1be722937c26b4bc"
-SRC_URI[windows_i686_gnu-0.48.5.sha256sum] =3D "a75915e7def60c94dcef7220=
0b9a8e58e5091744960da64ec734a6c6e9b3743e"
-SRC_URI[windows_i686_msvc-0.48.5.sha256sum] =3D "8f55c233f70c4b27f66c523=
580f78f1004e8b5a8b659e05a4eb49d4166cca406"
-SRC_URI[windows_x86_64_gnu-0.48.5.sha256sum] =3D "53d40abd2583d23e4718fd=
df1ebec84dbff8381c07cae67ff7768bbf19c6718e"
-SRC_URI[windows_x86_64_gnullvm-0.48.5.sha256sum] =3D "0b7b52767868a23d5b=
ab768e390dc5f5c55825b6d30b86c844ff2dc7414044cc"
-SRC_URI[windows_x86_64_msvc-0.48.5.sha256sum] =3D "ed94fce61571a4006852b=
7389a063ab983c02eb1bb37b47f8272ce92d06d9538"
-SRC_URI[winnow-0.5.16.sha256sum] =3D "037711d82167854aff2018dfd193aa0fef=
5370f456732f0d5a0c59b0f1b4b907"
-SRC_URI[x509-parser-0.13.2.sha256sum] =3D "9fb9bace5b5589ffead1afb76e43e=
34cff39cd0f3ce7e170ae0c29e53b88eb1c"
+SRC_URI[windows-link-0.2.1.sha256sum] =3D "f0805222e57f7521d6a62e36fa916=
3bc891acd422f971defe97d64e70d0a4fe5"
+SRC_URI[windows-sys-0.59.0.sha256sum] =3D "1e38bc4d79ed67fd075bcc251a1c3=
9b32a1776bbe92e5bef1f0bf1f8c531853b"
+SRC_URI[windows-sys-0.61.2.sha256sum] =3D "ae137229bcbd6cdf0f7b80a31df61=
766145077ddf49416a728b02cb3921ff3fc"
+SRC_URI[windows-targets-0.52.6.sha256sum] =3D "9b724f72796e036ab90c1021d=
4780d4d3d648aca59e491e6b98e725b84e99973"
+SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] =3D "32a4622180e7a0ec0=
44bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
+SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] =3D "09ec2a7bb152e2252b53=
fa7803150007879548bc709c039df7627cabbd05d469"
+SRC_URI[windows_i686_gnu-0.52.6.sha256sum] =3D "8e9b5ad5ab802e97eb8e295a=
c6720e509ee4c243f69d781394014ebfe8bbfa0b"
+SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] =3D "0eee52d38c090b3caa76=
c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
+SRC_URI[windows_i686_msvc-0.52.6.sha256sum] =3D "240948bc05c5e7c6dabba28=
bf89d89ffce3e303022809e73deaefe4f6ec56c66"
+SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] =3D "147a5c80aabfbf0c7d901c=
b5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] =3D "24d5b23dc417412679=
681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] =3D "589f6da84c646204747d1=
270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
+SRC_URI[winnow-1.0.2.sha256sum] =3D "2ee1708bef14716a11bae175f579062d455=
4d95be2c6829f518df847b7b3fdd0"
+SRC_URI[wit-bindgen-0.46.0.sha256sum] =3D "f17a85883d4e6d00e8a97c586de76=
4dabcc06133f7f1d55dce5cdc070ad7fe59"
+SRC_URI[wit-bindgen-0.51.0.sha256sum] =3D "d7249219f66ced02969388cf2bb04=
4a09756a083d0fab1e566056b04d9fbcaa5"
+SRC_URI[wit-bindgen-core-0.51.0.sha256sum] =3D "ea61de684c3ea68cb082b7a8=
8508a8b27fcc8b797d738bfc99a82facf1d752dc"
+SRC_URI[wit-bindgen-rust-0.51.0.sha256sum] =3D "b7c566e0f4b284dd6561c786=
d9cb0142da491f46a9fbed79ea69cdad5db17f21"
+SRC_URI[wit-bindgen-rust-macro-0.51.0.sha256sum] =3D "0c0f9bfd77e6a48ecc=
f51359e3ae77140a7f50b1e2ebfe62422d8afdaffab17a"
+SRC_URI[wit-component-0.244.0.sha256sum] =3D "9d66ea20e9553b30172b5e8319=
94e35fbde2d165325bec84fc43dbf6f4eb9cb2"
+SRC_URI[wit-parser-0.244.0.sha256sum] =3D "ecc8ac4bc1dc3381b7f59c34f00b6=
7e18f910c2c0f50015669dde7def656a736"
+SRC_URI[write16-1.0.0.sha256sum] =3D "d1890f4022759daae28ed4fe62859b1236=
caebfc61ede2f63ed4e695f3f6d936"
+SRC_URI[writeable-0.6.3.sha256sum] =3D "1ffae5123b2d3fc086436f8834ae3ab0=
53a283cfac8fe0a0b8eaae044768a4c4"
+SRC_URI[x509-parser-0.15.1.sha256sum] =3D "7069fba5b66b9193bd2c5d3d4ff12=
b839118f6bcbef5328efafafb5395cf63da"
 SRC_URI[yasna-0.4.0.sha256sum] =3D "e262a29d0e61ccf2b6190d7050d4b237535f=
c76ce4c1210d9caa316f71dffa75"
-SRC_URI[zerocopy-0.7.32.sha256sum] =3D "74d4d3961e53fa4c9a25a8637fc2bfaf=
2595b3d3ae34875568a5cf64787716be"
-SRC_URI[zerocopy-derive-0.7.32.sha256sum] =3D "9ce1b18ccd8e73a9321186f97=
e46f9f04b778851177567b1975109d26a08d2a6"
-SRC_URI[zeroize-1.6.0.sha256sum] =3D "2a0956f1ba7c7909bfb66c2e9e4124ab6f=
6482560f6628b5aaeba39207c9aad9"
-SRC_URI[zeroize_derive-1.4.2.sha256sum] =3D "ce36e65b0d2999d2aafac989fb2=
49189a141aee1f53c612c1f37d72631959f69"
+SRC_URI[yoke-0.8.2.sha256sum] =3D "abe8c5fda708d9ca3df187cae8bfb9ceda00d=
d96231bed36e445a1a48e66f9ca"
+SRC_URI[yoke-derive-0.8.2.sha256sum] =3D "de844c262c8848816172cef550288e=
7dc6c7b7814b4ee56b3e1553f275f1858e"
+SRC_URI[zerocopy-0.8.48.sha256sum] =3D "eed437bf9d6692032087e337407a86f0=
4cd8d6a16a37199ed57949d415bd68e9"
+SRC_URI[zerocopy-derive-0.8.48.sha256sum] =3D "70e3cd084b1788766f53af483=
dd21f93881ff30d7320490ec3ef7526d203bad4"
+SRC_URI[zerofrom-0.1.7.sha256sum] =3D "69faa1f2a1ea75661980b013019ed6687=
ed0e83d069bc1114e2cc74c6c04c4df"
+SRC_URI[zerofrom-derive-0.1.7.sha256sum] =3D "11532158c46691caf0f2593ea8=
358fed6bbf68a0315e80aae9bd41fbade684a1"
+SRC_URI[zeroize-1.8.2.sha256sum] =3D "b97154e67e32c85465826e8bcc1c59429a=
aaf107c1e4a9e53c8d8ccd5eff88d0"
+SRC_URI[zeroize_derive-1.4.3.sha256sum] =3D "85a5b4158499876c763cb03bc4e=
49185d3cccbabb15b33c627f7884f43db852e"
+SRC_URI[zerotrie-0.2.4.sha256sum] =3D "0f9152d31db0792fa83f70fb2f83148ef=
fb5c1f5b8c7686c3459e361d9bc20bf"
+SRC_URI[zerovec-0.11.6.sha256sum] =3D "90f911cbc359ab6af17377d242225f4d7=
5119aec87ea711a880987b18cd7b239"
+SRC_URI[zerovec-derive-0.11.3.sha256sum] =3D "625dc425cab0dca6dc3c331950=
6e6593dcb08a9f387ea3b284dbd52a92c40555"
+SRC_URI[zmij-1.0.21.sha256sum] =3D "b8848ee67ecc8aedbaf3e4122217aff89263=
9231befc6a1b58d29fff4c2cabaa"
diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4=
.1.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
similarity index 86%
rename from meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.=
1.bb
rename to meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.=
bb
index baa02fb..d88f1b2 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
@@ -11,9 +11,8 @@ SRC_URI +=3D "crate://crates.io/parsec-service/${PV} \
             file://parsec_init \
             file://systemd.patch \
             file://parsec-tmpfiles.conf \
-            file://0002-Fix-unnecessary-qualifications-error.patch \
 "
-SRC_URI[parsec-service-1.4.1.sha256sum] =3D "06ad906fb13d6844ad676d4203a=
1096ae4efc87fe1abcea0481c507df56d8c98"
+SRC_URI[parsec-service-1.5.0.sha256sum] =3D "819f1f658a1c62fee1b4986fe33=
232d5dc539b37ae0933981e02737ad7fb570f"
=20
 B =3D "${CARGO_VENDORING_DIRECTORY}/${BP}"
=20
@@ -21,12 +20,12 @@ PACKAGECONFIG ??=3D "PKCS11 MBED-CRYPTO"
 have_TPM =3D "${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'TPM', '',=
 d)}"
 PACKAGECONFIG:append =3D " ${@bb.utils.contains('BBFILE_COLLECTIONS', 't=
pm-layer', '${have_TPM}', '', d)}"
=20
-PACKAGECONFIG[ALL] =3D "-F all-providers -F cryptoki/generate-bindings -=
F tss-esapi/generate-bindings,,tpm2-tss libts,tpm2-tss libtss2-tcti-devic=
e libts"
 PACKAGECONFIG[TPM] =3D "-F tpm-provider -F tss-esapi/generate-bindings,,=
tpm2-tss,tpm2-tss libtss2-tcti-device"
 PACKAGECONFIG[PKCS11] =3D "-F pkcs11-provider -F cryptoki/generate-bindi=
ngs,"
 PACKAGECONFIG[MBED-CRYPTO] =3D "-F mbed-crypto-provider,"
 PACKAGECONFIG[CRYPTOAUTHLIB] =3D "-F cryptoauthlib-provider,"
-PACKAGECONFIG[TS] =3D "-F trusted-service-provider,,libts,libts"
+# Current version of Parsec is not compatible with the current version o=
f Trusted Services
+#PACKAGECONFIG[TS] =3D "-F trusted-service-provider,,libts protobuf-nati=
ve,libts"
=20
 export BINDGEN_EXTRA_CLANG_ARGS
 target =3D "${@d.getVar('TARGET_SYS').replace('-', ' ')}"
@@ -74,9 +73,9 @@ do_install () {
 inherit useradd
 USERADD_PACKAGES =3D "${PN}"
 GROUPADD_PARAM:${PN} =3D "-r parsec"
-USERADD_PARAM:${PN} =3D "-r -g parsec -s /bin/false -d ${localstatedir}/=
lib/parsec parsec"
+USERADD_PARAM:${PN} =3D "-r -g parsec -s /usr/sbin/nologin -d ${localsta=
tedir}/lib/parsec parsec"
 GROUPMEMS_PARAM:${PN} =3D "${@bb.utils.contains('PACKAGECONFIG_CONFARGS'=
, 'tpm-provider', '-a parsec -g tss ;', '', d)}"
-GROUPMEMS_PARAM:${PN} +=3D "${@bb.utils.contains('PACKAGECONFIG_CONFARGS=
', 'trusted-service-provider', '-a parsec -g teeclnt', '', d)}"
+GROUPMEMS_PARAM:${PN} +=3D "${@bb.utils.contains('PACKAGECONFIG_CONFARGS=
', 'trusted-service-provider', '-a parsec -g tee', '', d)}"
=20
 FILES:${PN} +=3D " \
     ${sysconfdir}/parsec/config.toml \
@@ -92,4 +91,3 @@ require parsec-service-crates.inc
 # upstream to fix this.
 # https://github.com/parallaxsecond/parsec/issues/645
 INSANE_SKIP:${PN}-dbg +=3D "buildpaths"
-
--=20
2.43.0


