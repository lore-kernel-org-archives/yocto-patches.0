Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C848CA5FB7
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 17:03:08 +0000 (UTC)
Received: from host.hernesphere.com (host.hernesphere.com [3.13.130.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11221.1768928578013502784
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Jan 2026 09:02:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: qinc.tv, ip: 3.13.130.34, mailfrom: dev@qinc.tv)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
Received: from localhost.localdomain (165-23-88-160-dynamic.midco.net [165.23.88.160])
	by host.hernesphere.com (Postfix) with ESMTPSA id 6255B106C29;
	Tue, 20 Jan 2026 11:02:55 -0600 (CST)
Authentication-Results: host.hernesphere.com;
        spf=pass (sender IP is 165.23.88.160) smtp.mailfrom=dev@qinc.tv smtp.helo=localhost.localdomain
Received-SPF: pass (host.hernesphere.com: connection is authenticated)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
From: "Eric L. Hernes" <dev@qinc.tv>
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <eric@qinc.tv>
Subject: [meta-darwin][PATCH] Patch GCC for aarch64 macOS host build on aarch64 linux host
Date: Tue, 20 Jan 2026 11:02:46 -0600
Message-ID: <20260120170246.94746-1-dev@qinc.tv>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 Jan 2026 17:03:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3034

From: "Eric L. Hernes" <eric@qinc.tv>

The configure script and aarch64.h get a bit confused when building
the darwin cross canadian.  `driver-aarch64.c` gets added which has
more build problems and isn't needed on the cross build.  The
`aarch64.h` file looks for `sysctl/..h` headers when targeting MACHO
binaries , which also do not exist on the linux build machine.

There should be a CPP macro for "linux_build_host" or
similar to use for the system dependent includes and config.  Since we
don't have this, we use (!defined(darwin_macosx_version_min)), which
seems to be "darwin builds only".  It's a bit of a hack, but should be
ok for this deep corner case.

Without this patch, cross builds targeting macOS/arm64 on a Linux
Intel machine work; but linux arm64 does not.  This is maybe a more
common situation. With Apple Intel machines out of production for 5+
years now, Docker on Apple Silicon should be much more common, and
getting more so.

It is possible to configure an Intel Docker image on Apple Silicon
with Rosetta 2, but the builds with native arm64 are significantly
faster.

commit da00745de4531722df9b955892c5835a7c26c03f
Author: Eric L. Hernes <ehernes@portrait.com>
Signed-off-by: Eric L. Hernes <eric@qinc.tv>
Date:   Mon Jan 19 09:54:57 2026 -0600

    additional patch for gcc to build on arm64 build for arm64 host
---
 .../gcc/files/0102-aarch64-on-aarch64.patch   | 30 +++++++++++++++++++
 recipes-devtools/gcc/gcc-source_%.bbappend    |  4 +++
 2 files changed, 34 insertions(+)
 create mode 100644 recipes-devtools/gcc/files/0102-aarch64-on-aarch64.pa=
tch

diff --git a/recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch b/r=
ecipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch
new file mode 100644
index 0000000..fd7ef2c
--- /dev/null
+++ b/recipes-devtools/gcc/files/0102-aarch64-on-aarch64.patch
@@ -0,0 +1,30 @@
+--- gcc-13.4.0/gcc/config.host~	2026-01-08 23:01:47.056268010 +0000
++++ gcc-13.4.0/gcc/config.host	2026-01-08 23:10:07.958588006 +0000
+@@ -102,6 +102,9 @@
+   aarch64*-*-freebsd* | aarch64*-*-linux* | aarch64*-*-fuchsia* |\
+   aarch64*-*-darwin*)
+     case ${target} in
++      *-oesdk-*)
++      # don't add driver-aarch64.o for oesdk cross builds
++      ;;
+       aarch64*-*-*)
+ 	host_extra_gcc_objs=3D"driver-aarch64.o"
+ 	host_xmake_file=3D"${host_xmake_file} aarch64/x-aarch64"
+--- gcc-13.4.0/gcc/config/aarch64/aarch64.h~	2026-01-08 23:01:46.8592680=
10 +0000
++++ gcc-13.4.0/gcc/config/aarch64/aarch64.h	2026-01-08 23:08:14.41723600=
9 +0000
+@@ -1223,7 +1223,14 @@
+=20
+ /* Extra specs when building a native AArch64-hosted compiler.
+    Option rewriting rules based on host system.  */
+-#if defined(__aarch64__)
++
++//
++// XXX-ELH: we don't do this for crosssdk builds,
++// so how do we know that? For now we just pick a symbol that is define=
d in the build
++//
++// g++ -fno-PIE -dM -E  .....  -MT gcc.o -MMD -MP -MF ./.deps/gcc.TPo .=
./../../../../../../work-shared/gcc-13.4.0-r0/gcc-13.4.0/gcc/gcc.cc
++//
++#if defined(__aarch64__) && !defined(darwin_macosx_version_min)
+ extern const char *host_detect_local_cpu (int argc, const char **argv);
+ #define HAVE_LOCAL_CPU_DETECT
+ # define EXTRA_SPEC_FUNCTIONS                                          =
 \
diff --git a/recipes-devtools/gcc/gcc-source_%.bbappend b/recipes-devtool=
s/gcc/gcc-source_%.bbappend
index 73b4843..d1089e5 100644
--- a/recipes-devtools/gcc/gcc-source_%.bbappend
+++ b/recipes-devtools/gcc/gcc-source_%.bbappend
@@ -9,3 +9,7 @@ SRC_URI:append =3D " \
 SRC_URI:append =3D " \
     file://0101-aarch64-Darwin-support-gcc-13-darwin.patch \
 "
+# Patch to allow building aarch64 toolchain for mac on aarch64 linux
+SRC_URI:append =3D " \
+    file://0102-aarch64-on-aarch64.patch \
+"
--=20
2.50.1 (Apple Git-155)


