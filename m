Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC1E7DEF7
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 15:59:19 +0000 (UTC)
Received: from host.hernesphere.com (host.hernesphere.com [3.13.130.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.56358.1770047955838385768
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Feb 2026 07:59:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: qinc.tv, ip: 3.13.130.34, mailfrom: dev@qinc.tv)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
Received: from localhost.localdomain (165-23-88-160-dynamic.midco.net [165.23.88.160])
	by host.hernesphere.com (Postfix) with ESMTPSA id 0CFBA106C2D;
	Mon,  2 Feb 2026 09:59:13 -0600 (CST)
Authentication-Results: host.hernesphere.com;
        spf=pass (sender IP is 165.23.88.160) smtp.mailfrom=dev@qinc.tv smtp.helo=localhost.localdomain
Received-SPF: pass (host.hernesphere.com: connection is authenticated)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
From: "Eric L. Hernes" <dev@qinc.tv>
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Subject: [meta-darwin][PATCH] Fix dylib paths for gdb and lldb
Date: Mon,  2 Feb 2026 09:58:53 -0600
Message-ID: <20260202155852.76192-2-dev@qinc.tv>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Feb 2026 15:59:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3168

The installed path to expat and liblldb are wrong.  This results in
the binaries not running on the macOS host. With gdb, we have

$ ./aarch64-oe-linux-gdb
dyld[...]: Library not loaded: libexpat.1.dylib
  Referenced from: <4F097B37-76EC-308F-8022-448023624AD3> /.../aarch64-oe=
-linux-gdb
  Reason: tried: 'libexpat.1.dylib' (no such file),
  '/System/Volumes/Preboot/Cryptexes/OSlibexpat.1.dylib' (no such
  file), 'libexpat.1.dylib' (no such file), '....'

Running otool shows (some output omitted for clarity):
$ otool -L ./aarch64-oe-linux-gdb
./aarch64-oe-linux-gdb:
	libexpat.1.dylib (compatibility version 12.0.0, current version 12.0.0)
	@loader_path/../../lib/libmpfr.6.dylib (compatibility version 9.0.0, cur=
rent

One fix would be to patch the configure/build/install scripts to have
the proper path to expat.

The macOS tools give us a simpler option to just run
`install_name_tool` to set it correctly.

lldb-dap has a similar problem with `liblldb`.

Signed-off-by: Eric L. Hernes <dev@qinc.tv>
---
 recipes-devtools/clang/clang_%.bbappend            | 4 ++++
 recipes-devtools/gdb/gdb-cross-canadian_%.bbappend | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/recipes-devtools/clang/clang_%.bbappend b/recipes-devtools/c=
lang/clang_%.bbappend
index e55dff6..9aa2c83 100644
--- a/recipes-devtools/clang/clang_%.bbappend
+++ b/recipes-devtools/clang/clang_%.bbappend
@@ -83,4 +83,8 @@ FILES:${PN} +=3D " \
    ${libdir}/LLVMgold.dylib \
 "
=20
+do_compile:append:class-nativesdk:darwin21() {
+    ${SDK_PREFIX}install_name_tool -change liblldb.${PV}.dylib @loader_p=
ath/../lib/liblldb.${PV}.dylib ${B}/bin/lldb-dap
+}
+
 INSANE_SKIP:${PN}:class-nativesdk:darwin21 +=3D " file-rdeps"
diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend b/recipes=
-devtools/gdb/gdb-cross-canadian_%.bbappend
index 3f69019..8d30ffb 100644
--- a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
+++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
@@ -16,4 +16,10 @@ EXTRA_OECONF:remove:darwinsdk =3D "--with-system-readl=
ine"
 # Remove -rpath-link and -rpath
 LDFLAGS:darwinsdk =3D "${BUILDSDK_LDFLAGS}"
=20
-INSANE_SKIP:append:darwin21 =3D " buildpaths"
+do_compile:append:darwinsdk() {
+    ${SDK_PREFIX}install_name_tool -change libexpat.1.dylib @loader_path=
/../../lib/libexpat.1.dylib ${B}/gdb/gdb
+}
+
+DEPENDS:append:darwinsdk =3D " nativesdk-zlib "
+
+INSANE_SKIP:append:darwinsdk =3D " buildpaths"
--=20
2.50.1 (Apple Git-155)


