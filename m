Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96670CC6B2D
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:33 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14671.1791987152500044137
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=LWOBMTu2;
 spf=pass (domain: snapchat.com, ip: 209.85.128.53, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so9352025e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987151; x=1792591951; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppozSKgOMH6aUP/vwDUiPR92XKcVpGL3FXSjVIyHBKc=;
        b=LWOBMTu2ORtStM3slk0JlBsGcLbGDyyvhyx7r+0H+MzkNig/Zy+eyz8+Qy2oE7h3eO
         BIv0URUCtzTsW/V50Dj1mxeZn7uEKm9bSAqtdkeGLYjS1nX3tKIcM1SWWiQpX9t7FZmU
         kNIJ6pgt4FpzFizfcgCp4DM2LjXo5iPlyBtbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987151; x=1792591951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppozSKgOMH6aUP/vwDUiPR92XKcVpGL3FXSjVIyHBKc=;
        b=134mNG5y7ejMHVht6qGmIDWKFtpKN5sCAE+u5TZQvcVahs5ciKcxl8yMOEV8pJKL1B
         TBcxckKNYZ0MVKyAw+AoC5N24BfOd1ACIVMPUmrfzTFl3uDzHjV9uLBdKwXpM7kg8F07
         uUBOgZzHJ1IBbQwbjl3+O6FJmafAqj21qQ2itZOHhhSz0PL5MebxLfpk1ItNKUIfiOeq
         3Qo4B00NZ+QUiSLm1tUmR9BwPUZgIGawWGcip/bg0NhvRTr1dH/Y1UgvxGnW2k6WiNAX
         /7SR1daS6xr5xex6bci1It5+MZ/Mfgz1zfnIM+pnvVbCKpMrqrvFUOrrySZlHAzamZSY
         E2FQ==
X-Gm-Message-State: AFq9FYK5cjvYgfm+SEjqxnUVedWvZm3Q+1xdl/48Hy/n7poRhEFGMigM
	NOOKCE1+LMAwTj/OGjc/VAr3B3e9Wvd7rrkdoDGrq+6xxvMHBKgdVexDFffuOdOrce4Pl26VNzk
	3hPL+UvA=
X-Gm-Gg: AYBFou0dWiVdb/lpg8g5stEGy/DhOBF9ZJ8eBvFA1Tug7ezfakFpKUHSwK83bR5JtMF
	pLZY0S3vUr8511E3t0nGsyZYkdI7NscZaB844rgOCMBvowt3zfhuitnimWRhxf1yCRzgtrhOibz
	DddYik016kEoVwYrpAD7I4ZdXKluWdCzkxUczEMAtPqhetL3RgKXo8/sk8kMP7DBpLyS65vynnG
	2dp0DePAwwXNYbRDem4e8lFvGzh0HIf9uk3HhVYphU0oAhQjvFGfBCslPl6dTbQJMxbM2qUbpoG
	1RFHLVfLfkwFjkyuce21hYC/YyP7ZkKmr4K/bzZ+QoE0rp6c0LxknokOXKEE/3TfoAWKSg1HC8x
	YC/rRtg1CL7bqYko8VMnpHGWUbIBcW0wTQv0KLz0v/GsoFs9JSt5QQb/Qmy7R9vF4soHaYML5M0
	4AC4JRR8cjdsNHGYkrDctiJdMj7eeDwSbGZzOzlrELpwOZG2rxqJCZNalfUNLTb0XDAD4T66Wb8
	dn7m8+ndu+32O670GBrhWbydjOUt4/VxCeRj0pRXQ==
X-Received: by 2002:a05:600c:8106:b0:4a0:c02:938c with SMTP id 5b1f17b1804b1-4a18e4d683dmr309873225e9.25.1791987150627;
        Wed, 14 Oct 2026 07:12:30 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:29 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 06/21] darwin recipes: fix S/WORKDIR/destsuffix breakage from git-fetcher UNPACKDIR relocation
Date: Wed, 14 Oct 2026 16:10:27 +0200
Message-ID: <20261014141209.488034-6-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5010

From: Etienne Cordonnier <ecordonnier@snap.com>

Two related upstream bitbake.conf changes broke several Darwin
recipes' S assignments:

- The git fetcher's checkout destination moved from ${WORKDIR}/git to
  ${UNPACKDIR}/${destsuffix or BP}, and oe-core's do_qa_unpack now
  fatally rejects any S literally containing "${WORKDIR}"/"git" or
  matching the old default. Drop the now-redundant/forbidden
  S = "${WORKDIR}/git" assignments (cctools-port-crosssdk,
  libdispatch-native, libtapi-native, xar, bomutils, hfsprogs,
  libdmg-hfsplus) and update any LIC_FILES_CHKSUM/CXXFLAGS/B that
  hardcoded the old path to use ${S}/${UNPACKDIR} instead. Also drop
  B = "${WORKDIR}/build" overrides exactly duplicating the
  autotools/cmake class default.

- Two recipes' real unpack destination still diverges from the new
  default (${UNPACKDIR}/${BP}):
    - nativesdk-osx-runtime explicitly overrode destsuffix to the
      now-banned literal "git" (and has a subpath, which would
      otherwise pick a different default destsuffix). Renamed the
      destsuffix to "osx-sdk" and pointed S there explicitly, and
      fixed LIC_FILES_CHKSUM's local LICENSE path, which never
      resolved to WORKDIR either.
    - libtapi-native has a single git fetch with no subpath/destsuffix
      override, so its default destsuffix (${BP}) already matches the
      new S default - no override needed. Fixed S/LIC_FILES_CHKSUM to
      point at the existing ${BP}-named checkout dir instead of
      introducing an unnecessary explicit destsuffix.

AI-Generated: Claude Sonnet 5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../cctools-port/cctools-port-crosssdk_1010.6.bb           | 3 ---
 recipes-devtools/libdispatch/libdispatch-native_git.bb     | 6 +-----
 recipes-devtools/libtapi/libtapi-native_1300.6.5.bb        | 7 +++----
 recipes-devtools/osx-runtime/nativesdk-osx-runtime_14.5.bb | 6 +++---
 recipes-devtools/xar/xar_git.bb                            | 5 +----
 recipes-support/bomutils/bomutils_git.bb                   | 5 ++---
 recipes-support/hfsprogs/hfsprogs_git.bb                   | 2 --
 recipes-support/libdmg-hfsplus/libdmg-hfsplus_git.bb       | 4 +---
 8 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb b/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb
index 4d2625a..0053585 100644
--- a/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb
+++ b/recipes-devtools/cctools-port/cctools-port-crosssdk_1010.6.bb
@@ -36,9 +36,6 @@ EXTRA_OECONF:append = " \
     --with-libtapi=${STAGING_DIR_NATIVE}/usr \
 "
 
-S = "${WORKDIR}/git"
-B = "${WORKDIR}/build"
-
 AUTOTOOLS_SCRIPT_PATH = "${S}/cctools"
 
 do_configure:prepend() {
diff --git a/recipes-devtools/libdispatch/libdispatch-native_git.bb b/recipes-devtools/libdispatch/libdispatch-native_git.bb
index 07f3c78..c7dadd0 100644
--- a/recipes-devtools/libdispatch/libdispatch-native_git.bb
+++ b/recipes-devtools/libdispatch/libdispatch-native_git.bb
@@ -4,7 +4,7 @@
 SUMMARY = "Apple Grand Central Dispatch (libdispatch)"
 HOMEPAGE = "https://github.com/tpoechtrager/apple-libdispatch"
 LICENSE = "Apache-2.0"
-LIC_FILES_CHKSUM = "file://${WORKDIR}/git/LICENSE;md5=1cd73afe3fb82e8d5c899b9d926451d0"
+LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=1cd73afe3fb82e8d5c899b9d926451d0"
 
 SECTION = "devel"
 
@@ -13,10 +13,6 @@ SRC_URI = "git://github.com/swiftlang/swift-corelibs-libdispatch.git;nobranch=1;
 
 inherit cmake native
 
-S = "${WORKDIR}/git"
-B = "${WORKDIR}/build"
-
-
 DEPENDS += " \
     clang-native \
     libcxx-native \
diff --git a/recipes-devtools/libtapi/libtapi-native_1300.6.5.bb b/recipes-devtools/libtapi/libtapi-native_1300.6.5.bb
index 66fd29d..5442f39 100644
--- a/recipes-devtools/libtapi/libtapi-native_1300.6.5.bb
+++ b/recipes-devtools/libtapi/libtapi-native_1300.6.5.bb
@@ -6,7 +6,7 @@ TAPI_VERSION = "1300.6.5"
 SUMMARY = "Apple libtapi for tdb support"
 HOMEPAGE = "https://github.com/tpoechtrager/apple-libtapi"
 LICENSE = "NCSA"
-LIC_FILES_CHKSUM = "file://${WORKDIR}/git/LICENSE.APPLE-LIBTAPI.txt;md5=ecd05d65aa93d096452d196dcd233f1e"
+LIC_FILES_CHKSUM = "file://${UNPACKDIR}/${BP}/LICENSE.APPLE-LIBTAPI.txt;md5=ecd05d65aa93d096452d196dcd233f1e"
 
 SECTION = "devel"
 
@@ -17,8 +17,7 @@ PACKAGES = "${PN}-dbg ${PN} ${PN}-dev"
 
 inherit cmake native
 
-S = "${WORKDIR}/git/src/llvm"
-B = "${WORKDIR}/build"
+S = "${UNPACKDIR}/${BP}/src/llvm"
 
 DEPENDS += " \
     clang-native \
@@ -30,7 +29,7 @@ COMPILER_RT:class-native = "-rtlib=libgcc --unwindlib=libgcc"
 LIBCPLUSPLUS:class-native = "-stdlib=libc++ -lc++abi"
 
 CXXFLAGS += " \
-    -I${WORKDIR}/git/src/llvm/projects/clang/include \
+    -I${S}/projects/clang/include \
     -I${B}/projects/clang/include \
 "
 
diff --git a/recipes-devtools/osx-runtime/nativesdk-osx-runtime_14.5.bb b/recipes-devtools/osx-runtime/nativesdk-osx-runtime_14.5.bb
index a7421cf..06865d8 100644
--- a/recipes-devtools/osx-runtime/nativesdk-osx-runtime_14.5.bb
+++ b/recipes-devtools/osx-runtime/nativesdk-osx-runtime_14.5.bb
@@ -3,7 +3,7 @@ LICENSE = "Proprietary"
 
 COMPATIBLE_HOST = ".*-darwin.*"
 
-OSX_SDK ?= "git://github.com/alexey-lysiuk/macos-sdk.git;nobranch=1;protocol=https;subpath=MacOSX14.5.sdk;destsuffix=git"
+OSX_SDK ?= "git://github.com/alexey-lysiuk/macos-sdk.git;nobranch=1;protocol=https;subpath=MacOSX14.5.sdk;destsuffix=osx-sdk"
 SRCREV = "69ddec41e6224afebd5f19bb24764305ac3e828a"
 
 SRC_URI = " \
@@ -12,11 +12,11 @@ SRC_URI = " \
     file://LICENSE \
 "
 
-LIC_FILES_CHKSUM = "file://${WORKDIR}/LICENSE;md5=03fe683ef28b9ddfe7f658a0f4b3b80e"
+LIC_FILES_CHKSUM = "file://${UNPACKDIR}/LICENSE;md5=03fe683ef28b9ddfe7f658a0f4b3b80e"
 
 PR = "1"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/osx-sdk"
 
 inherit nativesdk
 
diff --git a/recipes-devtools/xar/xar_git.bb b/recipes-devtools/xar/xar_git.bb
index 19930b5..9941920 100644
--- a/recipes-devtools/xar/xar_git.bb
+++ b/recipes-devtools/xar/xar_git.bb
@@ -11,15 +11,12 @@ SRC_URI = " \
 
 inherit autotools pkgconfig
 
-LIC_FILES_CHKSUM = "file://${WORKDIR}/git/xar/LICENSE;md5=64becc7b238f5b2d599c009ab19c2c27"
+LIC_FILES_CHKSUM = "file://${S}/xar/LICENSE;md5=64becc7b238f5b2d599c009ab19c2c27"
 
 DEPENDS = "libxml2"
 
 BBCLASSEXTEND = "native"
 
-S = "${WORKDIR}/git"
-B = "${WORKDIR}/build"
-
 do_configure() {
     ${S}/xar/configure --enable-autogen --prefix=${STAGING_EXECPREFIXDIR}
 }
diff --git a/recipes-support/bomutils/bomutils_git.bb b/recipes-support/bomutils/bomutils_git.bb
index 4c76f26..5d29675 100644
--- a/recipes-support/bomutils/bomutils_git.bb
+++ b/recipes-support/bomutils/bomutils_git.bb
@@ -7,12 +7,11 @@ SRC_URI = " \
     git://github.com/elhernes/bomutils.git;branch=master;protocol=https \
 "
 
-LIC_FILES_CHKSUM = "file://${WORKDIR}/git/LICENSE;md5=55d923cdeef7e46b4d6415cb173b345a"
+LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=55d923cdeef7e46b4d6415cb173b345a"
 
 BBCLASSEXTEND = "native"
 
-S = "${WORKDIR}/git"
-B = "${WORKDIR}/git/build"
+B = "${S}/build"
 
 do_compile() {
     make -C ${S}
diff --git a/recipes-support/hfsprogs/hfsprogs_git.bb b/recipes-support/hfsprogs/hfsprogs_git.bb
index 550888d..5572435 100644
--- a/recipes-support/hfsprogs/hfsprogs_git.bb
+++ b/recipes-support/hfsprogs/hfsprogs_git.bb
@@ -9,8 +9,6 @@ LIC_FILES_CHKSUM = "file://README.md;md5=ea27fd14a7e575753270cc5527d29023"
 SRCREV = "064b7fece00d069f206fd2d4a9a4493dd2777d9f"
 SRC_URI = "git://github.com/elhernes/hfsprogs.git;branch=master;protocol=https"
 
-S = "${WORKDIR}/git"
-
 DEPENDS = "openssl libbsd"
 
 inherit cmake native
diff --git a/recipes-support/libdmg-hfsplus/libdmg-hfsplus_git.bb b/recipes-support/libdmg-hfsplus/libdmg-hfsplus_git.bb
index 98ff652..1ee9fff 100644
--- a/recipes-support/libdmg-hfsplus/libdmg-hfsplus_git.bb
+++ b/recipes-support/libdmg-hfsplus/libdmg-hfsplus_git.bb
@@ -7,9 +7,7 @@ LICENSE = "GPL-3.0-only"
 SRC_URI = "git://github.com/elhernes/libdmg-hfsplus.git;branch=master;protocol=https"
 SRCREV = "3c3ce87a7e2f036f771f81147f9e125a2bb207f1"
 
-LIC_FILES_CHKSUM = "file://${WORKDIR}/git/LICENSE;md5=d32239bcb673463ab874e80d47fae504"
-
-S = "${WORKDIR}/git"
+LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=d32239bcb673463ab874e80d47fae504"
 
 inherit cmake
 
-- 
2.43.0


