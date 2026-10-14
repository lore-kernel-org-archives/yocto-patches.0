Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740D0CC6B2C
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:33 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14667.1791987149217321856
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=OASKb/zC;
 spf=pass (domain: snapchat.com, ip: 209.85.128.51, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so25730085e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987147; x=1792591947; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KXcc+l5ZSuy9bhSFre0Ay7LNkABotU66BOYmRsU5fnM=;
        b=OASKb/zC758q6tAXesmVyMCaymgyQUux7Ax7+gqYwL8nY0U4vTyfdsDt8FQGNWmUgt
         vkR33a+zLkXCMV8izooraI8LnAFT6fV4mJc6Ohu5zAy2XYh/nTOc20qyawgva9tlaVB3
         u3g63pLYMbb7P53e97JPAV90gcWEkeUj7RBuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987147; x=1792591947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KXcc+l5ZSuy9bhSFre0Ay7LNkABotU66BOYmRsU5fnM=;
        b=pAwBVknFRUvJhDAmMCL3vjQJUpR8uYoMik6M3ls57Q3wiG9a+8fxtdVF1cJE/71Cq/
         xqoGwyxDGGcgYTUzTk6TnTq9ji5U4PeyLbU6G7MN+H1SEyEw1xljfxiBwH57xhSq1em2
         eIVaHUN+oB2BzG0yNK6ts5wTc2S/gwVyZCd3AS/SCYL05zOV0JE92aIAz3yLpJ2W3YeV
         i6pvpPt/aA6NADGF7rungLylzx/SFS2aHtpnL3erFvmlMco6IcXPoeBvld2MsQkudKAQ
         Oh+VGdHC7PF/80ZTkDY2kfcU8dTh1QfIIW+nqcxH9RMbmuocJ4PHngIFlbMp2xC38y1v
         5NJA==
X-Gm-Message-State: AFq9FYLS8Y0jqWauvw61+Mzd1+vB3Fpt+NF8rlt1IHePHk2R+CzLb8rR
	CEaqHGodww4CxgCKB7urJTqJpY7lA0f4PaOVi8GAq979V+lhmp2kh8BzNLvv47rZXak6yEOxgTC
	ooPGmhVI=
X-Gm-Gg: AYBFou12C/4ke/9EBEU1X7Me5etHKuAgWSFCiU+u/r7/o1QbnlfxM9yQ4z7ig8rE37P
	NyDVFEcxsWBAxSYw35qNTjk+GZc1DnPRGoO7KHGIcf4Rgwqdmz0zNWPxMHWNtiTd83AS8bbOE+9
	NVUBo9Cd7PJN7xDz046OHHgEx3xq74XTfo96DrondPdfL1cQ0DNt/EQpEFsxJnm8bB40MbaO6Ce
	imqbJSDjlejRWmysG12sMh9WW24uJ9I5O0PQAhmu5WiHnKODPGR3iDtDdwqfytbJwFSNJYDGncj
	XGR3tgN+rDQMZugWfN6nuC7nZg4ig2o3jZedZioc4c5xe61xes4Q8pkBLiBXRhpXSWZHnEP8/uB
	pv4ptPUtPjxSJmOOB6k18L9Vmn0MfFECzh7kHllFtggj92bg9OJqfa1Tn8lxmGgdGX7L2o5l36e
	4T2D6IUHT2F2In46Ga5uWl+mcZh0szZ4Jn9YeKqxdG/NWf4pu+FbAG2rjbTFI1vAsM1iouawHc6
	pRrKBmg0/1fgsYBLl8iH4ZovVNBdijugVGiz5ld8w==
X-Received: by 2002:a05:600c:548c:b0:4a1:a7f8:c11f with SMTP id 5b1f17b1804b1-4a1a7f8c1cfmr122930235e9.9.1791987147330;
        Wed, 14 Oct 2026 07:12:27 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:26 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 03/21] clang: regenerate Darwin SDK fixes patch for the wrynose base
Date: Wed, 14 Oct 2026 16:10:24 +0200
Message-ID: <20261014141209.488034-3-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5007

From: Etienne Cordonnier <ecordonnier@snap.com>

Rebase 0037-Fixes_for_Darwin_SDKs.patch onto the new llvm-project
source tree pulled in by the wrynose layer bump.

AI-Generated: Composer 2.5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../clang/0037-Fixes_for_Darwin_SDKs.patch    | 135 +++++++++---------
 1 file changed, 70 insertions(+), 65 deletions(-)

diff --git a/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch b/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch
index ba2bf9c..c1b551a 100644
--- a/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch
+++ b/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch
@@ -1,83 +1,88 @@
-From cb9b87097803b4444ec9aa52b5054ba88e4da01e Mon Sep 17 00:00:00 2001
-From: Dominik Schnitzer <dominik@snap.com>
-Date: Wed, 27 Apr 2022 11:22:17 +0000
+From a9dce54a18db2f12c6964edf649872ac3b50889a Mon Sep 17 00:00:00 2001
+From: Etienne Cordonnier <ecordonnier@snap.com>
+Date: Fri, 16 Jan 2026 16:11:28 +0100
 Subject: [PATCH] Fixes for Darwin SDKs
 
 Upstream-Status: Inappropriate [OE specific]
 Signed-off-by: Dominik Schnitzer <dominik@snap.com>
-Index: llvm-project-18.1.5.src/clang/lib/Driver/ToolChains/Darwin.cpp
-===================================================================
---- llvm-project-18.1.5.src.orig/clang/lib/Driver/ToolChains/Darwin.cpp
-+++ llvm-project-18.1.5.src/clang/lib/Driver/ToolChains/Darwin.cpp
-@@ -2583,12 +2583,19 @@ void DarwinClang::AddClangCXXStdlibInclu
-     case llvm::Triple::x86:
-     case llvm::Triple::x86_64:
-       IsBaseFound = AddGnuCPlusPlusIncludePaths(DriverArgs, CC1Args, UsrIncludeCxx,
--                                                "4.2.1",
--                                                "i686-apple-darwin10",
--                                                arch == llvm::Triple::x86_64 ? "x86_64" : "");
-+                                                "13.4.0",
-+                                                "x86_64#SDK_VENDOR#-darwin21",
-+                                                "");
-       IsBaseFound |= AddGnuCPlusPlusIncludePaths(DriverArgs, CC1Args, UsrIncludeCxx,
--                                                "4.0.0", "i686-apple-darwin8",
--                                                 "");
-+                                                "13.4.0", "", "");
-+      {
-+          const char *S = ::getenv("YOCTO_SDKPATH");
-+          if (S && (S[0] != '\0')) {
-+              llvm::SmallString<128> Runtime;
-+              llvm::sys::path::append(Runtime, S);
-+              addSystemInclude(DriverArgs, CC1Args, Runtime);
-+          }
-+      }
-       break;
+---
+ clang/lib/Driver/ToolChains/Darwin.cpp | 28 +++++++++++++++++++++-----
+ llvm/cmake/modules/AddLLVM.cmake       |  1 -
+ llvm/cmake/modules/CrossCompile.cmake  |  2 +-
+ 3 files changed, 24 insertions(+), 7 deletions(-)
+
+diff --git a/clang/lib/Driver/ToolChains/Darwin.cpp b/clang/lib/Driver/ToolChains/Darwin.cpp
+index 234683f2f..9aa9e1036 100644
+--- a/clang/lib/Driver/ToolChains/Darwin.cpp
++++ b/clang/lib/Driver/ToolChains/Darwin.cpp
+@@ -2808,10 +2808,18 @@ void DarwinClang::AddGnuCPlusPlusIncludePaths(
+   case llvm::Triple::x86:
+   case llvm::Triple::x86_64:
+     IsBaseFound = AddGnuCPlusPlusIncludePaths(
+-        DriverArgs, CC1Args, UsrIncludeCxx, "4.2.1", "i686-apple-darwin10",
+-        arch == llvm::Triple::x86_64 ? "x86_64" : "");
++        DriverArgs, CC1Args, UsrIncludeCxx, "15.3.0", "x86_64#SDK_VENDOR#-darwin21",
++        "");
+     IsBaseFound |= AddGnuCPlusPlusIncludePaths(
+-        DriverArgs, CC1Args, UsrIncludeCxx, "4.0.0", "i686-apple-darwin8", "");
++        DriverArgs, CC1Args, UsrIncludeCxx, "15.3.0", "", "");
++    {
++        const char *S = ::getenv("YOCTO_SDKPATH");
++        if (S && (S[0] != '\0')) {
++            llvm::SmallString<128> Runtime;
++            llvm::sys::path::append(Runtime, S);
++            addSystemInclude(DriverArgs, CC1Args, Runtime);
++        }
++    }
+     break;
  
-     case llvm::Triple::arm:
-@@ -2605,9 +2612,19 @@
+   case llvm::Triple::arm:
+@@ -2826,8 +2834,18 @@ void DarwinClang::AddGnuCPlusPlusIncludePaths(
  
-     case llvm::Triple::aarch64:
-       IsBaseFound = AddGnuCPlusPlusIncludePaths(DriverArgs, CC1Args, UsrIncludeCxx,
--                                                "4.2.1",
--                                                "arm64-apple-darwin10",
-+                                                "13.4.0",
-+                                                "aarch64#SDK_VENDOR#-darwin21",
-                                                 "");
-+      IsBaseFound |= AddGnuCPlusPlusIncludePaths(DriverArgs, CC1Args, UsrIncludeCxx,
-+                                                "13.4.0", "", "");
-+      {
-+          const char *S = ::getenv("YOCTO_SDKPATH");
-+          if (S && (S[0] != '\0')) {
-+              llvm::SmallString<128> Runtime;
-+              llvm::sys::path::append(Runtime, S);
-+              addSystemInclude(DriverArgs, CC1Args, Runtime);
-+          }
-+      }
-       break;
-     }
+   case llvm::Triple::aarch64:
+     IsBaseFound =
+-        AddGnuCPlusPlusIncludePaths(DriverArgs, CC1Args, UsrIncludeCxx, "4.2.1",
+-                                    "arm64-apple-darwin10", "");
++        AddGnuCPlusPlusIncludePaths(DriverArgs, CC1Args, UsrIncludeCxx, "15.3.0",
++                                    "aarch64#SDK_VENDOR#-darwin21", "");
++    IsBaseFound |=
++        AddGnuCPlusPlusIncludePaths(DriverArgs, CC1Args, UsrIncludeCxx, "15.3.0", "", "");
++    {
++        const char *S = ::getenv("YOCTO_SDKPATH");
++        if (S && (S[0] != '\0')) {
++            llvm::SmallString<128> Runtime;
++            llvm::sys::path::append(Runtime, S);
++            addSystemInclude(DriverArgs, CC1Args, Runtime);
++        }
++    }
+     break;
+   }
  
-Index: llvm-project-18.1.5.src/llvm/cmake/modules/AddLLVM.cmake
-===================================================================
---- llvm-project-18.1.5.src.orig/llvm/cmake/modules/AddLLVM.cmake
-+++ llvm-project-18.1.5.src/llvm/cmake/modules/AddLLVM.cmake
-@@ -2368,7 +2368,6 @@ function(llvm_setup_rpath name)
+diff --git a/llvm/cmake/modules/AddLLVM.cmake b/llvm/cmake/modules/AddLLVM.cmake
+index 1d184b8d6..bb8e34a66 100644
+--- a/llvm/cmake/modules/AddLLVM.cmake
++++ b/llvm/cmake/modules/AddLLVM.cmake
+@@ -2549,7 +2549,6 @@ function(llvm_setup_rpath name)
    endif()
  
    if (APPLE)
 -    set(_install_name_dir INSTALL_NAME_DIR "@rpath")
      set(_install_rpath "@loader_path/../lib${LLVM_LIBDIR_SUFFIX}" ${extra_libdir})
-   elseif(${CMAKE_SYSTEM_NAME} MATCHES "AIX" AND BUILD_SHARED_LIBS)
+   elseif("${CMAKE_SYSTEM_NAME}" MATCHES "AIX" AND BUILD_SHARED_LIBS)
      # $ORIGIN is not interpreted at link time by aix ld.
-Index: llvm-project-18.1.5.src/llvm/cmake/modules/CrossCompile.cmake
-===================================================================
---- llvm-project-18.1.5.src.orig/llvm/cmake/modules/CrossCompile.cmake
-+++ llvm-project-18.1.5.src/llvm/cmake/modules/CrossCompile.cmake
-@@ -72,7 +72,7 @@ function(llvm_create_cross_target projec
+diff --git a/llvm/cmake/modules/CrossCompile.cmake b/llvm/cmake/modules/CrossCompile.cmake
+index 2a69c5133..a6578a763 100644
+--- a/llvm/cmake/modules/CrossCompile.cmake
++++ b/llvm/cmake/modules/CrossCompile.cmake
+@@ -82,7 +82,7 @@ function(llvm_create_cross_target project_name target_name toolchain buildtype)
    endif()
  
    add_custom_command(OUTPUT ${${project_name}_${target_name}_BUILD}/CMakeCache.txt
 -    COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}"
 +    COMMAND ${CMAKE_COMMAND} -E env --unset=LDFLAGS --unset=CFLAGS --unset=CXXFLAGS --unset=CC --unset=LD --unset=CXX ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}"
-         -DCMAKE_MAKE_PROGRAM="${CMAKE_MAKE_PROGRAM}"
-         -DCMAKE_C_COMPILER_LAUNCHER="${CMAKE_C_COMPILER_LAUNCHER}"
-         -DCMAKE_CXX_COMPILER_LAUNCHER="${CMAKE_CXX_COMPILER_LAUNCHER}"
+         "-DCMAKE_MAKE_PROGRAM=${CMAKE_MAKE_PROGRAM}"
+         "-DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}"
+         "-DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}"
+-- 
+2.43.0
+
-- 
2.43.0


