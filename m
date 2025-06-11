Return-Path: <samuli.piippo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D319C61CE7
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 10:09:47 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web11.4184.1749636577691059240
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Jun 2025 03:09:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g5dmYfht;
 spf=pass (domain: gmail.com, ip: 209.85.208.169, mailfrom: samuli.piippo@gmail.com)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32addf54a01so52754891fa.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Jun 2025 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749636575; x=1750241375; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq83WhFLGzHuCVUrgarRIKZtnk0mAqC2VAeJxiYFNSA=;
        b=g5dmYfhtFS5CBA3p78TkPWi8zclkvuErbzlkjGF31JDtFGV1gR6CCXLHePTFBiKMzs
         7arylr1VkNgyt3OQFI/d2jfF8jnYK9wLY2rCengAoZCRmDdGd6S/yH1NyXSjH3ZoDUcd
         tEr1I9aSWFLM2SbonMiYqKl4/v0SvdORmlWS7TQmZO60r4HNmrD6t9xji8fCyXS9AMQS
         8f/hlvCg5BBYaoErHPbyK2y0jaJatIYQki8uq3nzQdYk5H/ZkaKoKnc6FPKYzu3726eg
         t4dTvdf3ukBj5ZTHcEZSVIXPjt//MxynZjXjaRUe/JCy2ddLnnnf55b6s1d3Ga/neAZj
         wNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749636575; x=1750241375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq83WhFLGzHuCVUrgarRIKZtnk0mAqC2VAeJxiYFNSA=;
        b=R5+7ArVDvCOGynQkVpsg+RTzIkEWizcM2GUPV2eKZBTo5UdPcLbF6+1+ictkXsT8Oi
         thNyH5P5yiMoT2fJMahaI7bJUnTM43YyPbyDDpVKJVQT6sFWrvJThU+f/wC81wQ2Fy4h
         xJ5hQ668xaJYww1qhEQWQaXuimDCdwL42ITcGoUnQ2J/XhIEa7qGXKohC5kUz23G57pO
         I3hiVmAdxjWvl/tYkB/b00+9HkS9dId7Yo1ydD1uxODwFmj7i9MSzT2EkSCDKLZN10E4
         ot5yYxeTJ7/uGLY0zW5pIGkFMSPZfRPUMLvh5XyKI1VsInDYQEYm1wr+BSV+KP6GhuQo
         aWpA==
X-Gm-Message-State: AOJu0YyUak2dFD1kpGoHs8iHoqDR3OrMdXyRanY3caHx+Gbl/Z6nWndY
	4SpDqdxzLs6YcS5LGiMDtZoABj86niE8jRGShkxVwQvsvxJCQ5Y2MEef+6KiGw==
X-Gm-Gg: ASbGncu560GPmDDaELUkEcmb4Ri1ndxuExejm/Ixgk1jdfheMl/MvdduJ/X/3WoWewF
	KDsaMQzDBT3BbYDda0b0uyKtX+TjrbZAWqHIr3Pbq5J/bz+zfdpO8NB/8IX2y8v67ky5L5fffMb
	dQEbf3H3HrRVFlk65iK6WQygPggEJf+oJyCVUtQyooL6p2tKGWSwWDUgVgN9PJE09M1uYJa1s2M
	FyIUTmFD4mBeazIVj0ec+VgqXu+3PY+FwYZfqePbSexvLACjDzsvM0IIRDA9AsfcM87TlEhY8h1
	Qbtg7Tm+aeuOBOFhMvTli/bj1UBw712lIFsdkLFeEyYxOlQL6fv4DZVkQCIoMTZNnFN1RtY=
X-Google-Smtp-Source: AGHT+IFpr2liKX10huMpl4hA188f+DNXYrCF7AJWpKn/sp1V8wY+EOwgPz5vBopWjGdmCkstgCO0Ew==
X-Received: by 2002:a05:651c:1a0c:b0:32a:6a85:f298 with SMTP id 38308e7fff4ca-32b21dde5camr7959081fa.32.1749636575099;
        Wed, 11 Jun 2025 03:09:35 -0700 (PDT)
Received: from dcbuildsrv.ci.qt.io ([192.89.120.62])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ae1b34761sm17392741fa.26.2025.06.11.03.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:09:34 -0700 (PDT)
From: Samuli Piippo <samuli.piippo@gmail.com>
X-Google-Original-From: Samuli Piippo <samuli.piippo@qt.io>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH 1/2] Fix up openembedded bbappends
Date: Wed, 11 Jun 2025 10:09:18 +0000
Message-ID: <20250611100919.1067444-1-samuli.piippo@qt.io>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Jun 2025 10:09:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1630

Due to typo in the folder name, the bbappends in dynamic-layers for
meta-openembedded were never actually used. Update all bbappends
to work against latest recipes and patch protobuf to work with GCC 15.

Signed-off-by: Samuli Piippo <samuli.piippo@qt.io>
---
 .../abseil-cpp/abseil-cpp_%.bbappend          |  0
 .../recipes-devtools/grpc/grpc_%.bbappend     |  1 +
 .../protobuf-c/protobuf-c_%.bbappend          |  0
 .../0001-Disable-musttail-for-mingw.patch     | 43 +++++++++++++++++++
 .../protobuf/protobuf_%.bbappend              |  4 ++
 .../recipes-support/c-ares/c-ares_%.bbappend  |  1 +
 .../recipes-support/re2/re2_%.bbappend}       |  0
 .../protobuf/protobuf_%.bbappend              |  1 -
 .../recipes-support/c-ares/c-ares_%.bbappend  |  2 -
 .../recipes-support/re2/re2_%.bbappend        |  2 -
 10 files changed, 49 insertions(+), 5 deletions(-)
 rename dynamic-layers/{openembedded-layers => openembedded-layer}/recipes-devtools/abseil-cpp/abseil-cpp_%.bbappend (100%)
 create mode 100644 dynamic-layers/openembedded-layer/recipes-devtools/grpc/grpc_%.bbappend
 rename dynamic-layers/{openembedded-layers => openembedded-layer}/recipes-devtools/protobuf-c/protobuf-c_%.bbappend (100%)
 create mode 100644 dynamic-layers/openembedded-layer/recipes-devtools/protobuf/protobuf/0001-Disable-musttail-for-mingw.patch
 create mode 100644 dynamic-layers/openembedded-layer/recipes-devtools/protobuf/protobuf_%.bbappend
 create mode 100644 dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend
 rename dynamic-layers/{openembedded-layers/recipes-devtools/grpc/grpc_%.bbappend => openembedded-layer/recipes-support/re2/re2_%.bbappend} (100%)
 delete mode 100644 dynamic-layers/openembedded-layers/recipes-devtools/protobuf/protobuf_%.bbappend
 delete mode 100644 dynamic-layers/openembedded-layers/recipes-support/c-ares/c-ares_%.bbappend
 delete mode 100644 dynamic-layers/openembedded-layers/recipes-support/re2/re2_%.bbappend

diff --git a/dynamic-layers/openembedded-layers/recipes-devtools/abseil-cpp/abseil-cpp_%.bbappend b/dynamic-layers/openembedded-layer/recipes-devtools/abseil-cpp/abseil-cpp_%.bbappend
similarity index 100%
rename from dynamic-layers/openembedded-layers/recipes-devtools/abseil-cpp/abseil-cpp_%.bbappend
rename to dynamic-layers/openembedded-layer/recipes-devtools/abseil-cpp/abseil-cpp_%.bbappend
diff --git a/dynamic-layers/openembedded-layer/recipes-devtools/grpc/grpc_%.bbappend b/dynamic-layers/openembedded-layer/recipes-devtools/grpc/grpc_%.bbappend
new file mode 100644
index 0000000..b73a8ea
--- /dev/null
+++ b/dynamic-layers/openembedded-layer/recipes-devtools/grpc/grpc_%.bbappend
@@ -0,0 +1 @@
+EXTRA_OECMAKE:remove:mingw32 = "-DBUILD_SHARED_LIBS=ON"
diff --git a/dynamic-layers/openembedded-layers/recipes-devtools/protobuf-c/protobuf-c_%.bbappend b/dynamic-layers/openembedded-layer/recipes-devtools/protobuf-c/protobuf-c_%.bbappend
similarity index 100%
rename from dynamic-layers/openembedded-layers/recipes-devtools/protobuf-c/protobuf-c_%.bbappend
rename to dynamic-layers/openembedded-layer/recipes-devtools/protobuf-c/protobuf-c_%.bbappend
diff --git a/dynamic-layers/openembedded-layer/recipes-devtools/protobuf/protobuf/0001-Disable-musttail-for-mingw.patch b/dynamic-layers/openembedded-layer/recipes-devtools/protobuf/protobuf/0001-Disable-musttail-for-mingw.patch
new file mode 100644
index 0000000..0cd734a
--- /dev/null
+++ b/dynamic-layers/openembedded-layer/recipes-devtools/protobuf/protobuf/0001-Disable-musttail-for-mingw.patch
@@ -0,0 +1,43 @@
+From 321bfa7806f709ef6ab42a1c23aa1a44773ef5c2 Mon Sep 17 00:00:00 2001
+From: Samuli Piippo <samuli.piippo@qt.io>
+Date: Wed, 4 Jun 2025 07:07:42 +0000
+Subject: [PATCH] Disable musttail for mingw
+
+Workaround for GCC 15 build issue with mingw:
+
+In static member function 'static const char* google::protobuf::internal::TcParser::MiniParse(google::protobuf::MessageLite*, const char*, google::protobuf::internal::ParseContext*, google::protobuf::internal::TcFieldData, const google:
+:protobuf::internal::TcParseTableBase*, uint64_t) [with bool export_called_function = false]',
+    inlined from 'static const char* google::protobuf::internal::TcParser::MiniParse(google::protobuf::MessageLite*, const char*, google::protobuf::internal::ParseContext*, google::protobuf::internal::TcFieldData, const google::protobuf
+::internal::TcParseTableBase*, uint64_t)' at src/google/protobuf/generated_message_tctable_lite.cc:323:44:
+src/google/protobuf/generated_message_tctable_lite.cc:256:37: error: cannot tail-call: callee required more stack slots than the caller
+  256 |     PROTOBUF_MUSTTAIL return table->fallback(PROTOBUF_TC_PARAM_PASS);
+      |                              ~~~~~~~^~~~~~~~
+src/google/protobuf/generated_message_tctable_lite.cc:318:36: error: cannot tail-call: callee required more stack slots than the caller
+  318 |   PROTOBUF_MUSTTAIL return parse_fn(PROTOBUF_TC_PARAM_PASS);
+      |                            ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
+
+https://github.com/protocolbuffers/protobuf/issues/21625
+
+Upstream-Status: Pending
+---
+ src/google/protobuf/port_def.inc | 3 ++-
+ 1 file changed, 2 insertions(+), 1 deletion(-)
+
+diff --git a/src/google/protobuf/port_def.inc b/src/google/protobuf/port_def.inc
+index 56f995e45e..bc7a01e534 100644
+--- a/src/google/protobuf/port_def.inc
++++ b/src/google/protobuf/port_def.inc
+@@ -228,11 +228,12 @@ static_assert(PROTOBUF_ABSL_MIN(20230125, 3),
+ #endif
+ #if ABSL_HAVE_CPP_ATTRIBUTE(clang::musttail) && !defined(__arm__) &&  \
+     !defined(_ARCH_PPC) && !defined(__wasm__) &&                      \
+-    !(defined(_MSC_VER) && defined(_M_IX86)) && !defined(__i386__)
++    !(defined(_MSC_VER) && defined(_M_IX86)) && !defined(__i386__) && !defined(__MINGW32__)
+ // Compilation fails on ARM32: b/195943306
+ // Compilation fails on powerpc64le: b/187985113
+ // Compilation fails on X86 Windows:
+ // https://github.com/llvm/llvm-project/issues/53271
++// Compilation fails on MINGW: https://github.com/protocolbuffers/protobuf/issues/21625
+ #define PROTOBUF_MUSTTAIL [[clang::musttail]]
+ #define PROTOBUF_TAILCALL true
+ #else
diff --git a/dynamic-layers/openembedded-layer/recipes-devtools/protobuf/protobuf_%.bbappend b/dynamic-layers/openembedded-layer/recipes-devtools/protobuf/protobuf_%.bbappend
new file mode 100644
index 0000000..d80d3ce
--- /dev/null
+++ b/dynamic-layers/openembedded-layer/recipes-devtools/protobuf/protobuf_%.bbappend
@@ -0,0 +1,4 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
+SRC_URI:append:mingw32 = " file://0001-Disable-musttail-for-mingw.patch"
+
+EXTRA_OECMAKE:remove:mingw32 = "-Dprotobuf_BUILD_SHARED_LIBS=ON"
diff --git a/dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend b/dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend
new file mode 100644
index 0000000..94cd077
--- /dev/null
+++ b/dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend
@@ -0,0 +1 @@
+EXTRA_OECMAKE:append:mingw32 = " -DCARES_SHARED=OFF"
diff --git a/dynamic-layers/openembedded-layers/recipes-devtools/grpc/grpc_%.bbappend b/dynamic-layers/openembedded-layer/recipes-support/re2/re2_%.bbappend
similarity index 100%
rename from dynamic-layers/openembedded-layers/recipes-devtools/grpc/grpc_%.bbappend
rename to dynamic-layers/openembedded-layer/recipes-support/re2/re2_%.bbappend
diff --git a/dynamic-layers/openembedded-layers/recipes-devtools/protobuf/protobuf_%.bbappend b/dynamic-layers/openembedded-layers/recipes-devtools/protobuf/protobuf_%.bbappend
deleted file mode 100644
index d350e38..0000000
--- a/dynamic-layers/openembedded-layers/recipes-devtools/protobuf/protobuf_%.bbappend
+++ /dev/null
@@ -1 +0,0 @@
-EXTRA_OECONF:append:mingw32 = " --disable-shared"
diff --git a/dynamic-layers/openembedded-layers/recipes-support/c-ares/c-ares_%.bbappend b/dynamic-layers/openembedded-layers/recipes-support/c-ares/c-ares_%.bbappend
deleted file mode 100644
index 8ef58f9..0000000
--- a/dynamic-layers/openembedded-layers/recipes-support/c-ares/c-ares_%.bbappend
+++ /dev/null
@@ -1,2 +0,0 @@
-EXTRA_OECMAKE:append:mingw32 = "-DCARES_SHARED=OFF"
-EXTRA_OECMAKE:append:mingw32 = "-DCARES_STATIC=ON"
diff --git a/dynamic-layers/openembedded-layers/recipes-support/re2/re2_%.bbappend b/dynamic-layers/openembedded-layers/recipes-support/re2/re2_%.bbappend
deleted file mode 100644
index 16bb5a0..0000000
--- a/dynamic-layers/openembedded-layers/recipes-support/re2/re2_%.bbappend
+++ /dev/null
@@ -1,2 +0,0 @@
-EXTRA_OECMAKE:remove:mingw32 = "-DBUILD_SHARED_LIBS=ON"
-EXTRA_OECMAKE:append:mingw32 = "-DBUILD_SHARED_LIBS=OFF"
-- 
2.43.0


