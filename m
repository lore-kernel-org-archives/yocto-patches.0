Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DD1C87FCE
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:38 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web11.23025.1753296036662892603
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ej6kib4B;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e346ab52e9so24790885a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296035; x=1753900835; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmGJcPkyotvF91l+TYaFICa5FE2r9kk9/3hDOrgLK00=;
        b=ej6kib4BRee6NBeBr9wcBY/sDddyZQaEtAlsUuLTAW0TP46CCFTq5tOnqxTkmqnICq
         1BfzsVIxgK9XiB8KLoCZ2spYU8He9QY1u59n96a4gGQGV63EhAqOig0JX2ywwL+VloUr
         Uke9CsnEpstaDr91VD+PTuN3Lf+7P26SrPmoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296035; x=1753900835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmGJcPkyotvF91l+TYaFICa5FE2r9kk9/3hDOrgLK00=;
        b=CjeHNVE8naX2Xm3gBxNRkCkHm+Yjx6iH5nj2RjsGG72vxw3/Ufm2deYNBNdlsqPLlH
         /jEDNxhb1woci1Ggs3fTAPr0KjVQ8d7Ev7DtJ5UruPkfsV42RA5KuHFQVqtRDz0/XMNL
         ew7dI+OJ9q/EDBRHc0+CJel+8SGO8geuA7cozBlUngaOO9Taci4a6XKeVaOs16jXIywN
         xfzA0kWS54ilnTrJ9lMykFgqgjYGCofITpO2P7uWgKQV2R//0vu6nX+Bwntoonhqvr04
         ofilM52gh5HZ6JJSpfwlmQcsVtxRWuspo08hHktqamBh3qWqglBvFNVIbGY2I+Vb4rUC
         AL9w==
X-Gm-Message-State: AOJu0YzMmUZ1pshLm4jP2t6EMj7uQ3Ka71nLG3MTj8ssPBpI+LiN8/bD
	qyw1FVcLzoSfh4AIGKBdeC2aVceVLLV1xNvwgLTSzj4eG7hH4RISMHHZjLDse4ImNl+awJt1pS6
	WkWI4
X-Gm-Gg: ASbGncuLpFjC/l+LrNAzPIHGRCGAZ5ydsxZTlZesFaSi9BF/bJ6ObFHaeftkWN7LB9G
	4zcrfJDh5Mbb1U0Fj/yyKm5Dej8+4q+9RhTLpUC2FP2Pe8D1tweVWzEEcVIylgsqk6ZTzgb1c9/
	pNheflygcIWK52owAq8DgEnK27wfet9Mcg/BfuafOKCYOut8rbnui7yMm29bZQFIe4TMXO9kg41
	vTx/su0vHUOv2SLyTJ8ocwxJptGOiBCx31oeNjyjSpcpRoJ4P4k5f8B0MzMqguwv0IpHWN+e3lZ
	Ic5fgkWkF/6egmMHp+S0uSTJjTUfow7Nou+zAteye05PxXjBT1wEikbPpLH3fGCGtVjwiBG7WUq
	0MQibbvrtWuNJiNHWlkSuGS3jO5Ih3sr/DvS2iOvB/pRwIfnNUzDV5NRRFYmFRfatXy+RY5KkRA
	==
X-Google-Smtp-Source: AGHT+IFAayCwI1zJN7V7PIDD2EpO9xqWcnNakpdT7zhDDSHzPYsDi9hAvrFsL6bNJkjqu1CM+p5AbA==
X-Received: by 2002:a05:620a:3796:b0:7e0:6012:f18f with SMTP id af79cd13be357-7e62a1f994bmr403663985a.49.1753296035164;
        Wed, 23 Jul 2025 11:40:35 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:34 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 04/13] rust: Use patchelf in place of chrpath to edit rpaths
Date: Wed, 23 Jul 2025 14:40:04 -0400
Message-ID: <2436410281ff76dc6c50fb56ace129ef9d841666.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753295655.git.scott.murray@konsulko.com>
References: <cover.1753295655.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1831

From: Khem Raj <raj.khem@gmail.com>

chrpath has limitations e.g. the original rpath in ELF have to bigger in size
than the one being edited into it by chrpath, some toolchains do not use RPATH
but emit the RUNPATHs into ELF files and chrpath is not able to handle the
runpaths, this is the case with mips and pp32 build of rust, especially
when using clang compiler to build them.

patchelf can do more:

Modify RUNPATH entries
Add RPATH/RUNPATH where none existed
Set longer paths than the original
Convert between RPATH and RUNPATH

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 22b903f6620455e142e836412d3f7f6a4f03bea7)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_1.85.1.bb | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/recipes-devtools/rust/rust_1.85.1.bb b/recipes-devtools/rust/rust_1.85.1.bb
index 16b7ea2..fddd9a6 100644
--- a/recipes-devtools/rust/rust_1.85.1.bb
+++ b/recipes-devtools/rust/rust_1.85.1.bb
@@ -64,7 +64,7 @@ do_rust_setup_snapshot () {
     # are used internally by rust and result in symbol mismatches if we don't
     if [ ! -z "${UNINATIVE_LOADER}" -a -e "${UNINATIVE_LOADER}" ]; then
         for bin in cargo rustc rustdoc; do
-            patchelf-uninative ${WORKDIR}/rust-snapshot/bin/$bin --set-interpreter ${UNINATIVE_LOADER}
+            patchelf ${WORKDIR}/rust-snapshot/bin/$bin --set-interpreter ${UNINATIVE_LOADER}
         done
     fi
 }
@@ -72,6 +72,7 @@ addtask rust_setup_snapshot after do_unpack before do_configure
 addtask do_test_compile after do_configure do_rust_gen_targets
 do_rust_setup_snapshot[dirs] += "${WORKDIR}/rust-snapshot"
 do_rust_setup_snapshot[vardepsexclude] += "UNINATIVE_LOADER"
+do_rust_setup_snapshot[depends] += "patchelf-native:do_populate_sysroot"
 
 RUSTC_BOOTSTRAP = "${STAGING_BINDIR_NATIVE}/rustc"
 CARGO_BOOTSTRAP = "${STAGING_BINDIR_NATIVE}/cargo"
@@ -207,9 +208,9 @@ rust_runx () {
         mkdir -p `dirname ${RUST_ALTERNATE_EXE_PATH}`
         cp ${RUST_ALTERNATE_EXE_PATH_NATIVE} ${RUST_ALTERNATE_EXE_PATH}
         if [ -e ${STAGING_LIBDIR_NATIVE}/libc++.so.1 ]; then
-            chrpath -r \$ORIGIN/../../../../../`basename ${STAGING_DIR_NATIVE}`${libdir_native} ${RUST_ALTERNATE_EXE_PATH}
+            patchelf --set-rpath \$ORIGIN/../../../../../`basename ${STAGING_DIR_NATIVE}`${libdir_native} ${RUST_ALTERNATE_EXE_PATH}
         else
-            chrpath -d ${RUST_ALTERNATE_EXE_PATH}
+            patchelf --remove-rpath ${RUST_ALTERNATE_EXE_PATH}
         fi
     fi
 
@@ -266,7 +267,7 @@ rust_do_install:class-nativesdk() {
     install -d ${D}${bindir}
     for i in cargo-clippy clippy-driver rustfmt; do
         cp build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
-        chrpath -r "\$ORIGIN/../lib" ${D}${bindir}/$i
+        patchelf --set-rpath "\$ORIGIN/../lib" ${D}${bindir}/$i
     done
 
     chown root:root ${D}/ -R
@@ -301,7 +302,7 @@ rust_do_install:class-target() {
     install -d ${D}${bindir}
     for i in ${EXTRA_TOOLS}; do
         cp build/${RUST_BUILD_SYS}/stage2-tools/${RUST_HOST_SYS}/release/$i ${D}${bindir}
-        chrpath -r "\$ORIGIN/../lib" ${D}${bindir}/$i
+        patchelf --set-rpath "\$ORIGIN/../lib" ${D}${bindir}/$i
     done
 
     install -d ${D}${libdir}/rustlib/${RUST_HOST_SYS}
-- 
2.50.0


