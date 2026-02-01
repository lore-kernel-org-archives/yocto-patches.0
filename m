Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93FBE7C70F
	for <webhook@archiver.kernel.org>; Sun,  1 Feb 2026 04:28:22 +0000 (UTC)
Received: from host.hernesphere.com (host.hernesphere.com [3.13.130.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23945.1769920099900555233
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Jan 2026 20:28:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: qinc.tv, ip: 3.13.130.34, mailfrom: dev@qinc.tv)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
Received: from localhost.localdomain (165-23-88-160-dynamic.midco.net [165.23.88.160])
	by host.hernesphere.com (Postfix) with ESMTPSA id 3F9D2106C83;
	Sat, 31 Jan 2026 22:28:17 -0600 (CST)
Authentication-Results: host.hernesphere.com;
        spf=pass (sender IP is 165.23.88.160) smtp.mailfrom=dev@qinc.tv smtp.helo=localhost.localdomain
Received-SPF: pass (host.hernesphere.com: connection is authenticated)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
From: "Eric L. Hernes" <dev@qinc.tv>
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Subject: [meta-darwin][PATCH] fix dylib paths with install_name_tool
Date: Sat, 31 Jan 2026 22:27:55 -0600
Message-ID: <20260201042755.18458-1-dev@qinc.tv>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 01 Feb 2026 04:28:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3162

Signed-off-by: Eric L. Hernes <dev@qinc.tv>
---
 recipes-devtools/clang/clang_%.bbappend            | 4 ++++
 recipes-devtools/gdb/gdb-cross-canadian_%.bbappend | 9 ++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/recipes-devtools/clang/clang_%.bbappend b/recipes-devtools/c=
lang/clang_%.bbappend
index e55dff6..6c0a757 100644
--- a/recipes-devtools/clang/clang_%.bbappend
+++ b/recipes-devtools/clang/clang_%.bbappend
@@ -83,4 +83,8 @@ FILES:${PN} +=3D " \
    ${libdir}/LLVMgold.dylib \
 "
=20
+do_compile:append:class-nativesdk:darwin21() {
+    ${SDK_PREFIX}install_name_tool -change liblldb.18.1.6.dylib @loader_=
path/../lib/liblldb.18.1.6.dylib ${B}/bin/lldb-dap
+}
+
 INSANE_SKIP:${PN}:class-nativesdk:darwin21 +=3D " file-rdeps"
diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend b/recipes=
-devtools/gdb/gdb-cross-canadian_%.bbappend
index 3f69019..5fa29a7 100644
--- a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
+++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
@@ -16,4 +16,11 @@ EXTRA_OECONF:remove:darwinsdk =3D "--with-system-readl=
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
+
--=20
2.50.1 (Apple Git-155)


