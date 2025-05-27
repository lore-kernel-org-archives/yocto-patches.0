Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E95C54F30
	for <webhook@archiver.kernel.org>; Tue, 27 May 2025 13:24:39 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.51740.1748352274169894808
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 May 2025 06:24:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=XuHuLWU+;
 spf=pass (domain: snapchat.com, ip: 209.85.221.47, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4c9024117so2598364f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 27 May 2025 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1748352272; x=1748957072; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Z9SXCEYQvOsKM7/Xqu9Zi46F446/ZFQqfCI4M8ut0Q=;
        b=XuHuLWU+TaU9qV/QS4sgq8rlvWmc+mSXquaTXW+Zpet+GT+oKJInPu3C2QCjDzqO4c
         yjGjnPamgibzsk/E2pCxwcRJs0y6r/dt4FYBvmYD2Fpk/FvbRxCm7wSC2LfgPet3sEQ/
         MnnBys80gPk5YSjYHbYWSFegNnX/L5UvMFe48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352272; x=1748957072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z9SXCEYQvOsKM7/Xqu9Zi46F446/ZFQqfCI4M8ut0Q=;
        b=JvMS35HGy/+Kg4nK8oLLMj8GlVMTYl+mU7QMu13gRBDcO+B45pIlaFLSF0Mmjw7ReW
         cmVNo2BeM8T+b3kSE//9cnKdyOSk4xtkJ1Vvxv2VrL433QviHt6s3ao6qM+Br14YDrhG
         DYG8A6H6SvYd6LM2gdO7nIntYyvlsnU8JqczKLdQR2zkHeZqvT21ZNbfYkNuKxrKzZVh
         51+5oy+u4zxv4dRDUbcwyoA318s0lQ9SSi5lQN/OdDePdaoBF0ljNZjIRzoXtPQv3IHa
         /FtuCgHrR0NEEptljgTXqsdEZyEOeiL/IjVHk0zhwd2XkonVgzJV4jrQWPTk9hVIpjpa
         /+/w==
X-Gm-Message-State: AOJu0YygUZxTdjlrUMpX2c6p/X1cwtRWnghd1TWGMUWw0PlAxiLc6NQs
	Xvt5WXjiU3nE91lDpJ4vate6tH8gFI8b3VJmkeLz8D3J8RYdOI9lE8G8WzhWE+y2T24jYrpZdsn
	OTnhCXLw=
X-Gm-Gg: ASbGnctwiE3SWj2tgz09/wjc2qwlgU9rajmCoxO8J8cRmEl4hTt3ZIT/8xwkpdvA12O
	s06eilebKn5s4PtZmqZkI3HhIRgJInTViFy/XHJnqS1EMqX42+d32nctaveNXWhStOUY45jSxoo
	tGrdfWUjDff35u2tnKo4nGvgWS0g3zeSiUmdzv2fIYsPdpH68kELZwQl56kcwmVmEN80kjic2hY
	3zi7hKpi1ectv3wkrDyPsLmGcE36yJiw6aqHqax+wwoeGQUZEQ8TM7NyC8MgXLWGxybCK8GpV6Q
	s6utLBpCpoXDzO7dOaLTYFpUpTz2q3/DG5gXV/Bi8Dg917YOhTHmQ1qvKN/BqjWbqlGQ8w1c2H0
	=
X-Google-Smtp-Source: AGHT+IHw1Ioqxx+tRyL2Z32GbGQJM9iKTw8imCW43REXAslM58QyiYuUZBvjAnCLPrElyz16rESs7A==
X-Received: by 2002:a05:6000:4008:b0:3a3:6478:e08 with SMTP id ffacd0b85a97d-3a4e5ebbae8mr670931f8f.23.1748352271864;
        Tue, 27 May 2025 06:24:31 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d437f961sm7843506f8f.17.2025.05.27.06.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:24:31 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dominik Schnitzer <dominik@snap.com>,
	Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 2/2] arm64-darwin: use require to reduce duplication
Date: Tue, 27 May 2025 15:24:15 +0200
Message-ID: <20250527132415.2160472-2-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527132415.2160472-1-ecordonnier@snap.com>
References: <20250527132415.2160472-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 27 May 2025 13:24:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1581

From: Dominik Schnitzer <dominik@snap.com>

Signed-off-by: Dominik Schnitzer <dominik@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 conf/machine-sdk/arm64-darwin.conf  | 39 +----------------------------
 conf/machine-sdk/darwin-common.inc  | 37 +++++++++++++++++++++++++++
 conf/machine-sdk/x86_64-darwin.conf | 39 +----------------------------
 3 files changed, 39 insertions(+), 76 deletions(-)
 create mode 100644 conf/machine-sdk/darwin-common.inc

diff --git a/conf/machine-sdk/arm64-darwin.conf b/conf/machine-sdk/arm64-darwin.conf
index 1843f64..d91a78f 100644
--- a/conf/machine-sdk/arm64-darwin.conf
+++ b/conf/machine-sdk/arm64-darwin.conf
@@ -1,40 +1,3 @@
 SDK_ARCH = "aarch64"
-SDK_OS = "darwin21"
 
-SOLIBS:darwin21 = ".dylib"
-SOLIBSDEV:darwin21 = ".dylibbroken"
-
-PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-for-gcc = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-initial = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/${SDK_PREFIX}binutils = "cctools-port-crosssdk"
-PREFERRED_PROVIDER_virtual/nativesdk-libc = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/nativesdk-libintl = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/nativesdk-libiconv = "nativesdk-osx-runtime"
-
-SDKUSE_NLS = "no"
-SDKIMAGE_LINGUAS = ""
-SDK_DEPENDS:remove = "nativesdk-glibc-locale nativesdk-qemuwrapper-cross"
-
-SDKPKGSUFFIX = "nativesdk-darwin"
-
-OSX_TOOLCHAIN_OPTIONS = " \
-    -mmacosx-version-min=12.3 \
-    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/usr/lib \
-    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime/usr/lib \
-    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime/usr/lib/system \
-"
-
-TOOLCHAIN_OPTIONS:append:darwin21 = " \
-    ${OSX_TOOLCHAIN_OPTIONS}"
-TOOLCHAIN_OPTIONS:append:class-cross-canadian = " \
-    ${OSX_TOOLCHAIN_OPTIONS}"
-
-# Remove -rpath-link
-BUILDSDK_LDFLAGS = " \
-    -L${STAGING_LIBDIR} \
-    -Wl,-rpath,${libdir} \
-    -L${STAGING_DIR_HOST}${base_libdir} \
-    -Wl,-rpath,${base_libdir} \
-"
-
-MACHINEOVERRIDES .= ":darwinsdk"
+require darwin-common.inc
diff --git a/conf/machine-sdk/darwin-common.inc b/conf/machine-sdk/darwin-common.inc
new file mode 100644
index 0000000..cec76a5
--- /dev/null
+++ b/conf/machine-sdk/darwin-common.inc
@@ -0,0 +1,37 @@
+SDK_OS = "darwin21"
+
+SOLIBS:darwin21 = ".dylib"
+SOLIBSDEV:darwin21 = ".dylibbroken"
+
+PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-for-gcc = "nativesdk-osx-runtime"
+PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-initial = "nativesdk-osx-runtime"
+PREFERRED_PROVIDER_virtual/${SDK_PREFIX}binutils = "cctools-port-crosssdk"
+PREFERRED_PROVIDER_virtual/nativesdk-libc = "nativesdk-osx-runtime"
+PREFERRED_PROVIDER_virtual/nativesdk-libintl = "nativesdk-osx-runtime"
+PREFERRED_PROVIDER_virtual/nativesdk-libiconv = "nativesdk-osx-runtime"
+
+SDKUSE_NLS = "no"
+SDKIMAGE_LINGUAS = ""
+SDK_DEPENDS:remove = "nativesdk-glibc-locale nativesdk-qemuwrapper-cross"
+
+SDKPKGSUFFIX = "nativesdk-darwin"
+
+OSX_TOOLCHAIN_OPTIONS = " \
+    -mmacosx-version-min=12.3 \
+    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/usr/lib \
+    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime/usr/lib \
+    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime/usr/lib/system \
+"
+
+TOOLCHAIN_OPTIONS:append:darwin21 = " \
+    ${OSX_TOOLCHAIN_OPTIONS}"
+TOOLCHAIN_OPTIONS:append:class-cross-canadian = " \
+    ${OSX_TOOLCHAIN_OPTIONS}"
+
+# Remove -rpath-link
+BUILDSDK_LDFLAGS = " \
+    -L${STAGING_LIBDIR} \
+    -Wl,-rpath,${libdir} \
+"
+
+MACHINEOVERRIDES .= ":darwinsdk"
diff --git a/conf/machine-sdk/x86_64-darwin.conf b/conf/machine-sdk/x86_64-darwin.conf
index 89f3e0a..199cab7 100644
--- a/conf/machine-sdk/x86_64-darwin.conf
+++ b/conf/machine-sdk/x86_64-darwin.conf
@@ -1,40 +1,3 @@
 SDK_ARCH = "x86_64"
-SDK_OS = "darwin21"
 
-SOLIBS:darwin21 = ".dylib"
-SOLIBSDEV:darwin21 = ".dylibbroken"
-
-PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-for-gcc = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/nativesdk-${SDK_PREFIX}libc-initial = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/${SDK_PREFIX}binutils = "cctools-port-crosssdk"
-PREFERRED_PROVIDER_virtual/nativesdk-libc = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/nativesdk-libintl = "nativesdk-osx-runtime"
-PREFERRED_PROVIDER_virtual/nativesdk-libiconv = "nativesdk-osx-runtime"
-
-SDKUSE_NLS = "no"
-SDKIMAGE_LINGUAS = ""
-SDK_DEPENDS:remove = "nativesdk-glibc-locale nativesdk-qemuwrapper-cross"
-
-SDKPKGSUFFIX = "nativesdk-darwin"
-
-OSX_TOOLCHAIN_OPTIONS = " \
-    -mmacosx-version-min=12.3 \
-    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/usr/lib \
-    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime/usr/lib \
-    -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime/usr/lib/system \
-"
-
-TOOLCHAIN_OPTIONS:append:darwin21 = " \
-    ${OSX_TOOLCHAIN_OPTIONS}"
-TOOLCHAIN_OPTIONS:append:class-cross-canadian = " \
-    ${OSX_TOOLCHAIN_OPTIONS}"
-
-# Remove -rpath-link
-BUILDSDK_LDFLAGS = " \
-    -L${STAGING_LIBDIR} \
-    -Wl,-rpath,${libdir} \
-    -L${STAGING_DIR_HOST}${base_libdir} \
-    -Wl,-rpath,${base_libdir} \
-"
-
-MACHINEOVERRIDES .= ":darwinsdk"
+require darwin-common.inc
-- 
2.43.0


