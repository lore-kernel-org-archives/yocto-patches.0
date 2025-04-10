Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA64C369A6
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 13:54:01 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.34726.1744293232790679186
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 06:53:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=AllwwAgw;
 spf=pass (domain: snapchat.com, ip: 209.85.221.51, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1efc457bso480702f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1744293231; x=1744898031; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUYJA6esAlqZQ8CmYwInWFC3cPnuH8V53l/L5EBmGfE=;
        b=AllwwAgw/9vua1jJV6v9XB+FQW2yXZvMUPqlofQDkpayixlitfC/YWphZZgRXJmPS8
         rdCOACtwYNo8mVNuPeToSkDBzMALuf4AXEo7YH/0KwswSik0P+1tG/cbJEogv6hV2y55
         PrFf59dFqJYj8acUzuSIPk8RwILSzsl96ZO0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744293231; x=1744898031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUYJA6esAlqZQ8CmYwInWFC3cPnuH8V53l/L5EBmGfE=;
        b=LqTlb4z308dbhSbICud4BZOqFly9otHRX7lyR/uPKmeSW/NvBiHaIbKewHgx28nG9c
         plWiwKugl5k9L/6Keb9gjN+nn9CH90lZigYWOgrqtBW3QpzlMe0Nhf5Vk4K0GxUpSeF5
         E29Af1DNPM5tOpDS+ik32TPx7Cl3opaT8sQ2wKa1TgsYcIw2NrVbRV9ZgpdoQuUtQFUu
         LDytDX9PdB2M+R+qhYX+BWIk3PVEd8UPk268wn1KFBBxaH8EaOsrGt3PEZbg+eLzJJgT
         eW0YZuGbS+4pW4v1aPfO4uHLTePUIcBn4fhMH8jZmTjRf186rw8XOsFB9fw4IERFnq1Z
         IIfA==
X-Gm-Message-State: AOJu0YxV/4cXEVfDKn1CEdauCTim6HBNB5CTTSK9BZooM+ch3glj1OUs
	+XyKxXE7c3+9LwPuh53lR3LQn23fG0NodIbsXYolHUIF79e66Vm7s6IJSof/Ed0b9ZdKxE3HMj3
	MoyM=
X-Gm-Gg: ASbGncuF+KGORszVx7gnaTgeF9DBtOr73Wtw7cTd1cgSLzt5ZbaDbY4xG5tPfqWQ76C
	ejBQr62NGM+aG1FH8LbXuKirUosUQ99IZVT8b1VuO7nTdmjEc7NfKUrZpnPPcybfx+bL+6+kOW+
	rZlYo0JqV945WdKF+kgQdKTx2W27OfDZDWTuHD4307Wy9P+jFXavHgTlsFzDe+Ok8jILy4dGgaL
	WVTjmoWmgJSumCgu4HVX++AICqK033X2Q1cuM0a06d2ta2Ez3cLtzCkdMeSyMDkCGpPQK6GnjDa
	c3nd+X8OK7+Pq69SPsiUiv2wDFDsFKtJc0sDRmIhxKlSHdi238RtKdhq1K1FXMOm4dLoCMrlEdt
	rzUVWmgdbsVd05Qg/8ik=
X-Google-Smtp-Source: AGHT+IGwU8WKJfRYCHCZb6DE6n9wu37AihVp+yEiOGa3vZWsIwGViSYv37FfNnzZOVpN4HeirQlPZg==
X-Received: by 2002:a5d:648e:0:b0:391:9b2:f48d with SMTP id ffacd0b85a97d-39d8f498900mr2718448f8f.33.1744293230812;
        Thu, 10 Apr 2025 06:53:50 -0700 (PDT)
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5e90sm52354385e9.38.2025.04.10.06.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:53:50 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dominik Schnitzer <dominik@snap.com>,
	Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 2/3] clang: support darwin-arm64
Date: Thu, 10 Apr 2025 15:53:22 +0200
Message-ID: <20250410135336.20372-2-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410135336.20372-1-ecordonnier@snap.com>
References: <20250410135336.20372-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 13:54:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1354

From: Dominik Schnitzer <dominik@snap.com>

Updates 0037-Fixes_for_Darwin_SDKs.patch to support Apple Silicon.

Signed-off-by: Dominik Schnitzer <dominik@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../clang/0037-Fixes_for_Darwin_SDKs.patch    | 60 ++++++++++++-------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch b/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch
index 2071fa3..d5c72a8 100644
--- a/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch
+++ b/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch
@@ -5,17 +5,11 @@ Subject: [PATCH] Fixes for Darwin SDKs
 
 Upstream-Status: Inappropriate [OE specific]
 Signed-off-by: Dominik Schnitzer <dominik@snap.com>
----
- clang/lib/Driver/ToolChains/Darwin.cpp | 17 ++++++++++++-----
- llvm/cmake/modules/AddLLVM.cmake       |  1 -
- llvm/cmake/modules/CrossCompile.cmake  |  2 +-
- 3 files changed, 13 insertions(+), 7 deletions(-)
-
-diff --git a/clang/lib/Driver/ToolChains/Darwin.cpp b/clang/lib/Driver/ToolChains/Darwin.cpp
-index f7da3f187814..0656f5cbad69 100644
---- a/clang/lib/Driver/ToolChains/Darwin.cpp
-+++ b/clang/lib/Driver/ToolChains/Darwin.cpp
-@@ -2299,12 +2299,19 @@ void DarwinClang::AddClangCXXStdlibIncludeArgs(
+Index: llvm-project-18.1.5.src/clang/lib/Driver/ToolChains/Darwin.cpp
+===================================================================
+--- llvm-project-18.1.5.src.orig/clang/lib/Driver/ToolChains/Darwin.cpp
++++ llvm-project-18.1.5.src/clang/lib/Driver/ToolChains/Darwin.cpp
+@@ -2583,12 +2583,19 @@ void DarwinClang::AddClangCXXStdlibInclu
      case llvm::Triple::x86:
      case llvm::Triple::x86_64:
        IsBaseFound = AddGnuCPlusPlusIncludePaths(DriverArgs, CC1Args, UsrIncludeCxx,
@@ -40,11 +34,33 @@ index f7da3f187814..0656f5cbad69 100644
        break;
  
      case llvm::Triple::arm:
-diff --git a/llvm/cmake/modules/AddLLVM.cmake b/llvm/cmake/modules/AddLLVM.cmake
-index d34083fa52ec..477dc1ade3fc 100644
---- a/llvm/cmake/modules/AddLLVM.cmake
-+++ b/llvm/cmake/modules/AddLLVM.cmake
-@@ -2137,7 +2137,6 @@ function(llvm_setup_rpath name)
+@@ -2605,9 +2612,19 @@
+ 
+     case llvm::Triple::aarch64:
+       IsBaseFound = AddGnuCPlusPlusIncludePaths(DriverArgs, CC1Args, UsrIncludeCxx,
+-                                                "4.2.1",
+-                                                "arm64-apple-darwin10",
++                                                "13.3.0",
++                                                "aarch64#SDK_VENDOR#-darwin21",
+                                                 "");
++      IsBaseFound |= AddGnuCPlusPlusIncludePaths(DriverArgs, CC1Args, UsrIncludeCxx,
++                                                "13.3.0", "", "");
++      {
++          const char *S = ::getenv("YOCTO_SDKPATH");
++          if (S && (S[0] != '\0')) {
++              llvm::SmallString<128> Runtime;
++              llvm::sys::path::append(Runtime, S);
++              addSystemInclude(DriverArgs, CC1Args, Runtime);
++          }
++      }
+       break;
+     }
+ 
+Index: llvm-project-18.1.5.src/llvm/cmake/modules/AddLLVM.cmake
+===================================================================
+--- llvm-project-18.1.5.src.orig/llvm/cmake/modules/AddLLVM.cmake
++++ llvm-project-18.1.5.src/llvm/cmake/modules/AddLLVM.cmake
+@@ -2368,7 +2368,6 @@ function(llvm_setup_rpath name)
    endif()
  
    if (APPLE)
@@ -52,12 +68,12 @@ index d34083fa52ec..477dc1ade3fc 100644
      set(_install_rpath "@loader_path/../lib${LLVM_LIBDIR_SUFFIX}" ${extra_libdir})
    elseif(${CMAKE_SYSTEM_NAME} MATCHES "AIX" AND BUILD_SHARED_LIBS)
      # $ORIGIN is not interpreted at link time by aix ld.
-diff --git a/llvm/cmake/modules/CrossCompile.cmake b/llvm/cmake/modules/CrossCompile.cmake
-index 8a441729c943..8e19e4c93d9f 100644
---- a/llvm/cmake/modules/CrossCompile.cmake
-+++ b/llvm/cmake/modules/CrossCompile.cmake
-@@ -68,7 +68,7 @@ function(llvm_create_cross_target project_name target_name toolchain buildtype)
-   endforeach()
+Index: llvm-project-18.1.5.src/llvm/cmake/modules/CrossCompile.cmake
+===================================================================
+--- llvm-project-18.1.5.src.orig/llvm/cmake/modules/CrossCompile.cmake
++++ llvm-project-18.1.5.src/llvm/cmake/modules/CrossCompile.cmake
+@@ -72,7 +72,7 @@ function(llvm_create_cross_target projec
+   endif()
  
    add_custom_command(OUTPUT ${${project_name}_${target_name}_BUILD}/CMakeCache.txt
 -    COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}"
-- 
2.43.0


