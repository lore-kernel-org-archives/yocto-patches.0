Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EFFC88E60
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:13:51 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48443.1789157624910561447
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Zs554psH;
 spf=pass (domain: konsulko.com, ip: 209.85.160.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-530e1034617so4667861cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157624; x=1789762424; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+NGw6ND4db7sxkAnJxrVKGp+eJuIF6DqeoaTn6q1LCI=;
        b=Zs554psHMqYBe+l1hff4jgACxTJmIQ+9S0IWIpjtvZ0yr1AeVBNxXBWDVwTgHr9Z7Y
         IKZI7BNjGfyG7bVk2BLEXluCqlIYeUiDYXw4geZe0WMuxEwYBCxIXTgJUVCDLL9aeNqj
         t4L3wXhLLo3bYVo16Jd6IRVoxqZcTrTgeWnMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157624; x=1789762424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+NGw6ND4db7sxkAnJxrVKGp+eJuIF6DqeoaTn6q1LCI=;
        b=l+vX0d1GzxNQkDiOoWB5V4R4AkBktYb7msxVBTubMUbfIlKDQ3Z60/xt0qmhO+e8PQ
         QNAS1aSzXy0LcN1WCUxrzKBNf2S3mIpBIydYPkZSESsJjG/hajAn5rZE8TFHasFX+4ox
         Fbjz2sV97iTUwo1jetQRZlYbTlKufICU2Z98oPA/57r5ktrn/hf/vRWtpuFQUwB7q3we
         K5oIbXuIdCMWke7Tri90MPqRH9vT7MHPBwrgiDqqEP2tqjhbr9A9Fg6W/Qmi8qLZUJra
         9vfT6Ff9E2pmq7rixRIbCRTlBIDJpSUYSlGdgegXZT7oj+FUY5vevtwmfw6QjthQdKpi
         SnPw==
X-Gm-Message-State: AFuF++mX6fw3bB7eIeWommnSEyTlVe6v7T2ftOYY7v22WBEIGQzLFDLH
	DR5KOpJI4wkWkxFTa7ls71y8sTPrALdpR0KqG3ZBgoIXGOLKk7ktZ+OWsVYpoFdXONOq3a8XjNs
	E8dyp
X-Gm-Gg: AYBFou0S0YugSRB3p2UNPiQgKiEdk9yPWfWkGCFB3D4R7chwvKZ2zeo5+sb1NXvZ8zT
	fLmBzXRlzdj9ydZfssgIzql+ENppUq3H9s8K3TjPdtubOu5Qke07uNlG45dI6a4+94OXeMgDCq7
	+v7I1xXKIj+ldgYwmatFVwQM0NPZ2GBpPdULAAzP31OihJAdt4AwKy+DG7nuMQj3aeX/wXzm6XO
	SN7zWzzOV1mZ+Y69bkGUOWCW7mcEU0TVMBVvTtaN8QC4Cg1+1fCF04X4FYptRFk7ixp9i2MbsTM
	sNdr3vgLLkRkdUptzq4AyS3gyJOTaizuUZsCOXVYAUHPhbyKLpchp31soG3DSxd4eS9rULMrGk5
	xSZhMSVj9bZTat6pk7U0Q88lcMDWiBYpyT7VDqWrrdhkncFqtCMQok3u3S2kE0naHMwT602aPrG
	sXTw0rxmSMyIgsDXPrK6sLQEC8c3787y8ZuQKpM2j9PjrcX119vRVy5h8+0H/sVwj0swkP75l14
	T/HqJpyl/3Sx++CF1RPvR7TU6ep/moYXEDRAtxjZgP0SizeJ/9AvI9rQtJvuaTZfwNrjdgoi7pH
	IxotV0gdPCvLU8lA3La9h9v6PoQbUjFFM6k=
X-Received: by 2002:a05:622a:229d:b0:530:42e4:f000 with SMTP id d75a77b69052e-530c87728e6mr91850861cf.45.1789157623756;
        Fri, 11 Sep 2026 13:13:43 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:43 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 06/37] libgit2: remove library paths from installed .cmake
Date: Fri, 11 Sep 2026 16:12:52 -0400
Message-ID: <d5ea2655dbad997ed24f71c12ea4d7cd36833496.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:13:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4771

From: Ross Burton <ross.burton@arm.com>

The libgit2 cmake rules generate a .cmake file that tells people linking
to libgit2 how to link.  This includes the complete path to each of the
libraries that libgit2 links, such as /path/to/sysroot/usr/lib/libssl.so.

The build paths were previously removed with a quick sed, but this breaks
builds where those target paths exist on the build host as they get used
verbatim.

However, all of this linkage is redundant as the library directly links
to these libraries.  Mark the linkage as private, so the references do
not appear in the .cmake files.

[ YOCTO #16373 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit a3d381bd80bcb73097dc68c46c725f3122dca49b)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...m-libraries-are-private-link-librari.patch | 42 +++++++++++++++++++
 recipes-support/libgit2/libgit2_1.9.4.bb      |  8 ++--
 2 files changed, 45 insertions(+), 5 deletions(-)
 create mode 100644 recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch

diff --git a/recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch b/recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch
new file mode 100644
index 0000000..267770a
--- /dev/null
+++ b/recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch
@@ -0,0 +1,42 @@
+From 5670d3eed82f0d64766158809bf3d0c7c631b0ea Mon Sep 17 00:00:00 2001
+From: Ross Burton <ross.burton@arm.com>
+Date: Thu, 23 Jul 2026 17:35:23 +0100
+Subject: [PATCH] cmake: mark system libraries are private link libraries
+
+When generating libgit2Targets.cmake, mark the system libraries that
+libgit2.so links to as private, as the don't not need to be seen by
+applications that link to libgit2.
+
+This stops the generated file from containing absolute paths to the
+libraries, which both leaks build information and means the build output
+is not relocatable:
+
+set_target_properties(libgit2::libgit2package PROPERTIES
+  INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
+  INTERFACE_LINK_LIBRARIES "/PATH/TO/SYSROOT/usr/lib/libssl.so;/PATH/TO/SYSROOT/usr/lib/libcrypto.so;/PATH/TO/SYSROOT/usr/lib/libpcre2-8.so;/PATH/TO/SYSROOT/usr/lib/libz.so;rt"
+)
+
+Making the linkage private removes the INTERFACE_LINK_LIBRARIES line,
+and applications linking to libgit2 still succeed.
+
+Upstream-Status: Submitted [https://github.com/libgit2/libgit2/pull/7324]
+Signed-off-by: Ross Burton <ross.burton@arm.com>
+---
+ src/libgit2/CMakeLists.txt | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/src/libgit2/CMakeLists.txt b/src/libgit2/CMakeLists.txt
+index 8045ddef9..fafdb09ec 100644
+--- a/src/libgit2/CMakeLists.txt
++++ b/src/libgit2/CMakeLists.txt
+@@ -65,7 +65,7 @@ if (NOT BUILD_SHARED_LIBS AND XCODE_VERSION)
+ endif()
+ 
+ add_library(libgit2package ${SRC_RC} ${LIBGIT2_OBJECTS})
+-target_link_libraries(libgit2package ${LIBGIT2_SYSTEM_LIBS})
++target_link_libraries(libgit2package PRIVATE ${LIBGIT2_SYSTEM_LIBS})
+ target_include_directories(libgit2package SYSTEM PRIVATE ${LIBGIT2_INCLUDES})
+ target_include_directories(libgit2package INTERFACE $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
+ 
+-- 
+2.43.0
diff --git a/recipes-support/libgit2/libgit2_1.9.4.bb b/recipes-support/libgit2/libgit2_1.9.4.bb
index dbd60aa..900e078 100644
--- a/recipes-support/libgit2/libgit2_1.9.4.bb
+++ b/recipes-support/libgit2/libgit2_1.9.4.bb
@@ -5,7 +5,9 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=8eacfdc17c8f4d219e131a073973b97d"
 
 DEPENDS = "curl openssl zlib libssh2 libgcrypt libpcre2"
 
-SRC_URI = "git://github.com/libgit2/libgit2.git;branch=maint/v1.9;protocol=https"
+SRC_URI = "git://github.com/libgit2/libgit2.git;branch=maint/v1.9;protocol=https \
+           file://0001-cmake-mark-system-libraries-are-private-link-librari.patch"
+
 SRCREV = "f7164261c9bc0a7e0ebf767c584e5192810a8b24"
 
 S = "${WORKDIR}/git"
@@ -19,7 +21,3 @@ EXTRA_OECMAKE = "\
 "
 
 BBCLASSEXTEND = "native"
-
-do_install:append() {
-    sed -i -e 's,${RECIPE_SYSROOT},,g' ${D}${libdir}/cmake/libgit2/libgit2Targets.cmake
-}
-- 
2.55.0


