Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC7CC6B1D
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:43 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14677.1791987161630844934
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Pv+42c7y;
 spf=pass (domain: snapchat.com, ip: 209.85.128.42, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a17baef589so9467745e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987160; x=1792591960; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1vsFZE9naFEvn8csjubrQy0AUReUy/lcCjB4g77oHSg=;
        b=Pv+42c7yhAiDx6sRYk0Ud66rXeh7fmde82ruFrk828S5K9WdctK8dyrwnOHqmwbEIV
         l/Bax77yCTfBTKt3ftjusnb57GIoorOQl9DSvuHa2kQ+KvxaukflL1UWs1oVsfGdRsmq
         bJwieQBcA1fgLLX/g1HPEyxVUyGTEj+47NzPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987160; x=1792591960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1vsFZE9naFEvn8csjubrQy0AUReUy/lcCjB4g77oHSg=;
        b=qEK0zaJ7mrLUuZcAozuqfFCL2mUfZAnpsb2jUJC8z6r6ghVbz4b8IMHvGw/chIh3d8
         xQYLpe45QL0tDLQvBuqKJ5ddevMjTTqw1/uhxHuaXloiw9TUddbF6TauA5nmrFaXDPvf
         43OGPiXa77bQ8Q5AkOSoNAAiDkAIPRXm7ZxRMZ2OTTExBbL5PD0nAK5YKXrzTwJ4cPZF
         dZ2smW9K6ZP0w0cAbXSAl2Prqkm7ogX95q2AwRjo/Fu7B0/jzA6j46HP0v6wbhUAuU+N
         YLUXb2639RS3gP8f9PZ7KamQyMVxMMtLsE/Vx3FKcIvzssgq0iRzCDnyWnvVdlp5MQL7
         KUpg==
X-Gm-Message-State: AFq9FYKx14FY3d3oCyAyaJXpObrO3cKtbM1Kh7/tIeYiMOehckd/zNOs
	UISqIsYD3OZk+u5+MqsISCB0xc9PVS5VU0Yy7Gj2Pc39a4GH1DJMzmG17KGy4CFVxTtnqdScZtt
	D2f09GoY=
X-Gm-Gg: AYBFou3FTilUuAXVLjqapXKXaOLCjCsw0Aj4wJJnYQNalvRa+m3a8SnmX6onDvlFMlQ
	3Of2iZxkQFP+sJtJ5tZ/pcMnukbDaDytxdKSyIIsGPiMtkNBfzyOxzViYRqhMHlopQeXxCRukkj
	/z1UNcjnW6kqMypiR5Q9iiPcCPZZr82l4MpcPNU06jh34TA1qF+vKE8yFGAvxc4ZH+r1sSgtrH9
	9fGPTsDesLFh5GOc1ZEwQl1oWQX95MXC2k3Ezb/k9haHO1PNKf1JllxVR+bDBwc55ozuUHPPudD
	PWyUEsb+i7utylSqJjJ8DIpIHxJgFn0VaC9keRQaLg9Z0sKWVToPo3tR211E7Ue8o28S46a6V2i
	ovjmyg2ENHYyKiuimPxiGYAwLZBX2ZVYOR4NICCJGm2THTopolVhlbeikmWX9/btgg7N62UYaX3
	zpK4Hr5kSWvb7PoeIYGoX449aYs1mJZRmt+QpOL6X2AHFzkQi453plXOQrpQg5xUZWOo5RpQLrV
	1coES09YGLCWVoeNGj0gr+VInLfMWjb3TL+QzBUzg==
X-Received: by 2002:a05:600c:818d:b0:4a1:6c79:fd31 with SMTP id 5b1f17b1804b1-4a18e483231mr307637435e9.12.1791987159662;
        Wed, 14 Oct 2026 07:12:39 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:39 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 15/21] clang/lldb: move LLDB support to its own nativesdk-lldb recipe
Date: Wed, 14 Oct 2026 16:10:36 +0200
Message-ID: <20261014141209.488034-15-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5020

From: Etienne Cordonnier <ecordonnier@snap.com>

The Darwin nativesdk-clang bbappend carried a set of LLDB-specific
EXTRA_OECMAKE flags and a do_compile:append install_name_tool fix for
lldb-dap, but LLDB was never actually attached to clang's own standalone
cmake build (clang/tools/CMakeLists.txt has no lldb hookup, only
clang-tools-extra) - CMake's own "manually-specified variables were not
used by the project" warning listed every one of them as dead. lldb-dap
was never being built at all.

OE-core already ships a standalone lldb_git.bb (BBCLASSEXTEND =
"native nativesdk"). Move the misplaced flags there (as lldb_%.bbappend),
fix its COMPATIBLE_HOST (hardcoded to "-linux", excluding darwin), and
pull nativesdk-lldb into the SDK the same way nativesdk-clang already is.

Build nativesdk-lldb with clang (PREFERRED_TOOLCHAIN_SDK;
TOOLCHAIN:class-nativesdk has no effect as TCOVERRIDE is resolved first),
because lldb's macOS host support is Objective-C++, which the Darwin
cross-GCC can't compile. Use GCC's libstdc++ and libgcc_s instead of the
compiler-rt and libcxx that clang.bbclass adds to BASE_DEFAULT_DEPS, and
drop the nativesdk-python3 dependency that python3targetconfig adds:
Python support is disabled, and nativesdk-python3 doesn't configure for
darwin21.

Tested by building nativesdk-lldb for x86_64-darwin.

AI-Generated: Claude Sonnet 5.5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../nativesdk-packagegroup-sdk-host.bbappend  |  2 +-
 recipes-devtools/clang/clang_%.bbappend       | 23 -----
 recipes-devtools/clang/lldb_%.bbappend        | 91 +++++++++++++++++++
 3 files changed, 92 insertions(+), 24 deletions(-)
 create mode 100644 recipes-devtools/clang/lldb_%.bbappend

diff --git a/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend b/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend
index d1191e7..2ea92b5 100644
--- a/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend
+++ b/recipes-core/packagegroups/nativesdk-packagegroup-sdk-host.bbappend
@@ -5,5 +5,5 @@ RDEPENDS:${PN}:darwin21 = "\
     nativesdk-sdk-provides-dummy \
     "
 
-RDEPENDS:${PN}:darwin21 += "${@bb.utils.contains('CLANGSDK', '1', 'nativesdk-clang', '', d)}"
+RDEPENDS:${PN}:darwin21 += "${@bb.utils.contains('CLANGSDK', '1', 'nativesdk-clang nativesdk-lldb', '', d)}"
 
diff --git a/recipes-devtools/clang/clang_%.bbappend b/recipes-devtools/clang/clang_%.bbappend
index 1947781..91a9226 100644
--- a/recipes-devtools/clang/clang_%.bbappend
+++ b/recipes-devtools/clang/clang_%.bbappend
@@ -58,33 +58,10 @@ EXTRA_OECMAKE:remove:class-nativesdk:darwin21 = "-DPYTHON_EXECUTABLE='${PYTHON}'
 EXTRA_OECMAKE:append:class-nativesdk:darwin21 = " \
     -DCMAKE_FRAMEWORK_PATH='${OSXSDK}/System/Library/Frameworks'\
     -DCLANGD_BUILD_XPC=OFF \
-    -DLLDB_USE_SYSTEM_DEBUGSERVER=ON \
-    -DLLDB_INCLUDE_TESTS=OFF \
-    -DLLDB_ENABLE_PYTHON=OFF \
-    \
-    -DLLDB_ENABLE_LZMA=ON \
-    \
-    -DLLVM_ENABLE_LIBEDIT=ON -DLLDB_ENABLE_LIBEDIT=ON \
-    -DLibEdit_LIBRARIES=${OSXSDK}/usr/lib/libedit.tbd \
-    -DLibEdit_INCLUDE_DIRS=${OSXSDK}/usr/include \
-    \
-    -DCURSES_INCLUDE_DIRS=${OSXSDK}/usr/include \
-    -DCURSES_LIBRARIES=${OSXSDK}/usr/lib/libcurses.tbd \
-    -DPANEL_LIBRARIES=${OSXSDK}/usr/lib/libpanel.tbd \
-    \
-    -DLIBXML2_INCLUDE_DIR=${OSXSDK}/usr/include/libxml2 \
-    -DLIBXML2_LIBRARY=${OSXSDK}/usr/lib/libxml2.tbd \
-    \
-    -DFFI_LIBRARY_PATH=${OSXSDK}/usr/lib/libffi.tbd \
-    -DFFI_INCLUDE_PATH=${OSXSDK}/usr/include \
 "
 
 FILES:${PN} += " \
    ${libdir}/LLVMgold.dylib \
 "
 
-do_compile:append:class-nativesdk:darwin21() {
-    ${SDK_PREFIX}install_name_tool -change liblldb.${PV}.dylib @loader_path/../lib/liblldb.${PV}.dylib ${B}/bin/lldb-dap
-}
-
 INSANE_SKIP:${PN}:class-nativesdk:darwin21 += " file-rdeps"
diff --git a/recipes-devtools/clang/lldb_%.bbappend b/recipes-devtools/clang/lldb_%.bbappend
new file mode 100644
index 0000000..39734d8
--- /dev/null
+++ b/recipes-devtools/clang/lldb_%.bbappend
@@ -0,0 +1,91 @@
+OSXSDK:class-nativesdk:darwin21 = "${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime"
+
+# The base recipe's COMPATIBLE_HOST only matches "-linux" host triples,
+# filtering out this darwin21 SDK build entirely.
+COMPATIBLE_HOST:class-nativesdk:darwin21 = ".*-darwin.*"
+
+# On darwin21 we link against the target OSX SDK's own stub (.tbd) libraries
+# instead of cross-building libedit for the target, mirroring the darwin
+# nativesdk-clang bbappend's own PACKAGECONFIG:remove for "libedit".
+PACKAGECONFIG:remove:class-nativesdk:darwin21 = "libedit"
+
+CFLAGS:append:class-nativesdk:darwin21 = " \
+    -I${OSXSDK}/usr/include \
+    -include TargetConditionals.h \
+"
+CXXFLAGS:append:class-nativesdk:darwin21 = " \
+    -I${OSXSDK}/usr/include \
+    -include TargetConditionals.h \
+    -F${OSXSDK}/System/Library/Frameworks \
+    -F${OSXSDK}/System/Library/Frameworks/CoreServices.framework/Frameworks \
+"
+
+EXTRA_OECMAKE:append:class-nativesdk:darwin21 = " \
+    -DCMAKE_FRAMEWORK_PATH='${OSXSDK}/System/Library/Frameworks' \
+    -DLLDB_USE_SYSTEM_DEBUGSERVER=ON \
+    -DLLDB_INCLUDE_TESTS=OFF \
+    -DLLDB_ENABLE_PYTHON=OFF \
+    \
+    -DLLDB_ENABLE_LZMA=ON \
+    \
+    -DLLVM_ENABLE_LIBEDIT=ON -DLLDB_ENABLE_LIBEDIT=ON \
+    -DLibEdit_LIBRARIES=${OSXSDK}/usr/lib/libedit.tbd \
+    -DLibEdit_INCLUDE_DIRS=${OSXSDK}/usr/include \
+    \
+    -DCURSES_INCLUDE_DIRS=${OSXSDK}/usr/include \
+    -DCURSES_LIBRARIES=${OSXSDK}/usr/lib/libcurses.tbd \
+    -DPANEL_LIBRARIES=${OSXSDK}/usr/lib/libpanel.tbd \
+    \
+    -DLIBXML2_INCLUDE_DIR=${OSXSDK}/usr/include/libxml2 \
+    -DLIBXML2_LIBRARY=${OSXSDK}/usr/lib/libxml2.tbd \
+    \
+    -DFFI_LIBRARY_PATH=${OSXSDK}/usr/lib/libffi.tbd \
+    -DFFI_INCLUDE_PATH=${OSXSDK}/usr/include \
+"
+
+do_compile:append:class-nativesdk:darwin21() {
+    ${SDK_PREFIX}install_name_tool -change liblldb.${PV}.dylib @loader_path/../lib/liblldb.${PV}.dylib ${B}/bin/lldb-dap
+}
+
+# lldb-dap's rewritten @loader_path reference to liblldb.dylib trips the
+# same file-rdeps QA check that nativesdk-clang already skips for darwin21.
+INSANE_SKIP:${PN}:class-nativesdk:darwin21 += " file-rdeps"
+
+# Python support is disabled above (LLDB_ENABLE_PYTHON=OFF), but lldb inherits
+# python3targetconfig, which adds nativesdk-python3 to DEPENDS. That recipe
+# doesn't configure for darwin21 (sw_vers is missing), so drop the dependency.
+EXTRA_PYTHON_DEPENDS:class-nativesdk:darwin21 = ""
+
+# lldb's macOS host support is Objective-C++ (Host.mm etc.), which the Darwin
+# cross-GCC can't compile. Build with the clang-crosssdk compiler instead, with
+# the same toolchain-clang adjustments as the nativesdk-clang bbappend.
+PREFERRED_TOOLCHAIN_SDK = "clang"
+
+COMPILER_RT:class-nativesdk:toolchain-clang:runtime-llvm:darwin21 = ""
+LIBCPLUSPLUS:class-nativesdk:toolchain-clang:darwin21 = " -stdlib=libstdc++"
+
+LDFLAGS:toolchain-clang:class-nativesdk:darwin21 = " \
+    ${BUILDSDK_LDFLAGS} \
+    -lgcc_s \
+"
+LDFLAGS:remove:toolchain-clang:class-nativesdk:x86-64:darwin21 = " -Wl,-dynamic-linker,${base_libdir}/ld-linux-x86-64.so.2"
+LDFLAGS:remove:toolchain-clang:class-nativesdk:aarch64:darwin21 = " -Wl,-dynamic-linker,${base_libdir}/ld-linux-aarch64.so.1"
+
+CFLAGS:append:class-nativesdk:toolchain-clang:darwin21 = " -femulated-tls"
+CXXFLAGS:append:class-nativesdk:toolchain-clang:darwin21 = " -femulated-tls -Wno-elaborated-enum-base"
+
+# clang.bbclass adds compiler-rt and libcxx to BASE_DEFAULT_DEPS, but the
+# nativesdk uses GCC's libgcc_s and libstdc++ (see LDFLAGS/LIBCPLUSPLUS above).
+BASE_DEFAULT_DEPS:remove:class-nativesdk:toolchain-clang:darwin21 = " compiler-rt libcxx"
+
+# clang defaults to libc++, but the nativesdk ships GCC's libstdc++. The Darwin
+# clang driver patch (0037) finds its headers via YOCTO_SDKPATH.
+CXXFLAGS:append:class-nativesdk:toolchain-clang:darwin21 = " -stdlib=libstdc++"
+LDFLAGS:append:class-nativesdk:toolchain-clang:darwin21 = " -stdlib=libstdc++"
+
+do_configure:prepend:class-nativesdk:darwin21() {
+    export YOCTO_SDKPATH="${OSXSDK}/usr/include"
+}
+do_compile:prepend:class-nativesdk:darwin21() {
+    export YOCTO_SDKPATH="${OSXSDK}/usr/include"
+}
-- 
2.43.0


