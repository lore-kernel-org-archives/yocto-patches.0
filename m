Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24351C3601E
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 13:48:01 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.34582.1744292872394049582
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 06:47:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Ea1bp4lU;
 spf=pass (domain: snapchat.com, ip: 209.85.128.54, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso6393415e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1744292870; x=1744897670; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXE0Q9aZlUgWB9zUIF3Ro5/pEAZjYJ5Vz4/jpIXoU+w=;
        b=Ea1bp4lUzf7ARxxdDXmzxiqK6LyzJUvjh1MJso3WXynKU2P49i9VbgapLtqyLq4XLh
         WfOqRuo3Nxh36fgqL2zFr7dR4yIJH9C+IsxMEz7qhe3GJCxc5fZS7gQQuIOtE/4Pu7p2
         hNSXY/dcseRUkX2UQOdKUPvTvdEdncn1mi1vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292870; x=1744897670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXE0Q9aZlUgWB9zUIF3Ro5/pEAZjYJ5Vz4/jpIXoU+w=;
        b=wKaZlOzjab3c8zH7m94nOVdxOt4b7PDOkTkrqaW2nQW4bmtngdFwCI4LWIsl4Esjrj
         BQl0ArnwdWRSE0Q7qCnD9MUkVMJlmkKQZEOX9tR+5oOGUMhTL2M3b57unm2bJ8WTJ6lj
         8gdUjs2dCuW6qGGd0krG/2oPtgs3OgGLE/742R5jmwiWhUifZGWlbVjIl45KAJsOv962
         irrHIv7ruQTXpSgH4RjFYbl611qP4OIkhBaPSBL1kAAIK2ZpCDDd8wFpEYp+n3XtANpB
         iceZLhR/+tCISZlVpVvLA34IOfsZs6zq4Qq3S8x1kGD6g8LAl9G3zAGDm2fJoMhKZRR/
         LsIw==
X-Gm-Message-State: AOJu0YzhXRdPgM4buhsxh4VDC95DeYUsBCiFbSvEO0AE/ScTbGWASLBz
	KtO0AoKtNruu2OtZ3euwVM050gL7esgM2Ppg1sVwjmSa7GGPiehS7hXEYX+xEhPAxBp/ZvO1vbx
	3X9Y=
X-Gm-Gg: ASbGncufIHNOpERLBkye6Q/rMHzR6P+ecmCqXgMAzRlPLug0yt4uMDkRSWEY7l7WLEp
	vwiBc+bWEOHOmweRi/HwTnEQZl6SF4SJwey4r8P2DYOjQXHW4sSjNE7ZTxKusXVHzdDQDGDDnTR
	09VThpwZvvEZgRZ3IdRtKYiOcmfcmL92x5DD965hmCGZx6go6OBlMgFtlyCOtV2Eq8NIGiwAzg3
	lrNeiJ60a1v/iZ2duxQF09NrIUPfUunQKLhnStxNQan9M3Z0TFYoicmaaaQnAu2jaMgyLYD9+yw
	2jaWntuOE7hCgrGrOg78msIJPV23P29uUDItjWXLXDI7pQaYINF5k6+oe74RQG0ayCXhkNZ0Wj/
	ZtM2lwia9o1kYZJ2yD4uF0CxGPnVNvA==
X-Google-Smtp-Source: AGHT+IEo/cFW6HBTNipyYk41deZkWS2zhAKzPqpRqlMiEv6kRZs8JtIBXHHHwkLcIQtPTlkut2sXaw==
X-Received: by 2002:a5d:5982:0:b0:399:7f2b:8531 with SMTP id ffacd0b85a97d-39d8f4e714cmr2385728f8f.38.1744292870014;
        Thu, 10 Apr 2025 06:47:50 -0700 (PDT)
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89378daasm4886996f8f.38.2025.04.10.06.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:47:49 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dominik Schnitzer <dominik@snap.com>,
	Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 2/4] libtapi: update to 1300.6.5
Date: Thu, 10 Apr 2025 15:45:08 +0200
Message-ID: <20250410134510.17001-2-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410134510.17001-1-ecordonnier@snap.com>
References: <20250410134510.17001-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 13:48:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1349

From: Dominik Schnitzer <dominik@snap.com>

Signed-off-by: Dominik Schnitzer <dominik@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 ...tive_git.bb => libtapi-native_1300.6.5.bb} | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)
 rename recipes-devtools/libtapi/{libtapi-native_git.bb => libtapi-native_1300.6.5.bb} (67%)

diff --git a/recipes-devtools/libtapi/libtapi-native_git.bb b/recipes-devtools/libtapi/libtapi-native_1300.6.5.bb
similarity index 67%
rename from recipes-devtools/libtapi/libtapi-native_git.bb
rename to recipes-devtools/libtapi/libtapi-native_1300.6.5.bb
index 3c09387..e60363d 100644
--- a/recipes-devtools/libtapi/libtapi-native_git.bb
+++ b/recipes-devtools/libtapi/libtapi-native_1300.6.5.bb
@@ -1,8 +1,7 @@
 # Copyright (C) 2020 Dominik Schnitzer <dominik@snap.com>
 # Released under the MIT license (see COPYING.MIT for the terms)
 
-TAPI_REPOSITORY="1100.0.11"
-TAPI_VERSION="11.0.0"
+TAPI_VERSION="1300.6.5"
 
 SUMMARY = "Apple libtapi for tdb support"
 HOMEPAGE = "https://github.com/tpoechtrager/apple-libtapi"
@@ -11,39 +10,44 @@ LIC_FILES_CHKSUM = "file://${WORKDIR}/git/LICENSE.APPLE-LIBTAPI.txt;md5=ecd05d65
 
 SECTION = "devel"
 
-SRCREV = "b7b5bdbfda9e8062d405b48da3b811afad98ae76"
+SRCREV = "aa37c11ad1a817248c9d1578ac99e133875b4eb5"
 SRC_URI = "git://github.com/tpoechtrager/apple-libtapi.git;nobranch=1;protocol=https"
 
 PACKAGES = "${PN}-dbg ${PN} ${PN}-dev"
 
-OECMAKE_GENERATOR = "Unix Makefiles"
-
 inherit cmake native
 
 S = "${WORKDIR}/git/src/llvm"
 B = "${WORKDIR}/build"
 
-DEPENDS += "clang-native libcxx-native"
+DEPENDS += " \
+    clang-native \
+    libcxx-native \
+"
 
 TOOLCHAIN:class-native = "clang"
 COMPILER_RT:class-native = "-rtlib=libgcc --unwindlib=libgcc"
 LIBCPLUSPLUS:class-native = "-stdlib=libc++ -lc++abi"
 
-CXXFLAGS:append = " -I${WORKDIR}/git/src/llvm/projects/clang/include -I${B}/projects/clang/include"
+CXXFLAGS += " \
+    -I${WORKDIR}/git/src/llvm/projects/clang/include \
+    -I${B}/projects/clang/include \
+"
 
 EXTRA_OECMAKE:append = " \
  -DLLVM_INCLUDE_TESTS=OFF \
- -DTAPI_REPOSITORY_STRING=${TAPI_REPOSITORY} \
+ -DLLVM_ENABLE_PROJECTS='tapi;clang' \
+ -DTAPI_REPOSITORY_STRING=${TAPI_VERSION} \
  -DTAPI_FULL_VERSION=${TAPI_VERSION} \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
 "
 
 do_compile() {
     cd ${B}
-    make -j clangBasic
-    make -j libtapi
+    ninja clangBasic
+    ninja libtapi
 }
 
 do_install() {
-    DESTDIR='${D}' make install-libtapi install-tapi-headers
+    DESTDIR='${D}' ninja install-libtapi install-tapi-headers
 }
-- 
2.43.0


