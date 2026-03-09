Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9E7F3C24D
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 23:13:10 +0000 (UTC)
Received: from host.hernesphere.com (host.hernesphere.com [3.13.130.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28177.1773097982368487146
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Mar 2026 16:13:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: qinc.tv, ip: 3.13.130.34, mailfrom: dev@qinc.tv)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
Received: from localhost.localdomain (165-23-88-160-dynamic.midco.net [165.23.88.160])
	by host.hernesphere.com (Postfix) with ESMTPSA id 8E3F8FDD89;
	Mon,  9 Mar 2026 18:13:00 -0500 (CDT)
Authentication-Results: host.hernesphere.com;
        spf=pass (sender IP is 165.23.88.160) smtp.mailfrom=dev@qinc.tv smtp.helo=localhost.localdomain
Received-SPF: pass (host.hernesphere.com: connection is authenticated)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
From: "Eric L. Hernes" <dev@qinc.tv>
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Subject: [PATCH 2/2] convert libdispatch to native-only recipe
Date: Mon,  9 Mar 2026 18:12:51 -0500
Message-ID: <20260309231251.99347-3-dev@qinc.tv>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309231251.99347-1-dev@qinc.tv>
References: <20260309231251.99347-1-dev@qinc.tv>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 23:13:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3390

Signed-off-by: Eric L. Hernes <dev@qinc.tv>
---
 .../{libdispatch_git.bb =3D> libdispatch-native_git.bb}        | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
 rename recipes-devtools/libdispatch/{libdispatch_git.bb =3D> libdispatch=
-native_git.bb} (94%)

diff --git a/recipes-devtools/libdispatch/libdispatch_git.bb b/recipes-de=
vtools/libdispatch/libdispatch-native_git.bb
similarity index 94%
rename from recipes-devtools/libdispatch/libdispatch_git.bb
rename to recipes-devtools/libdispatch/libdispatch-native_git.bb
index 05b309d..07f3c78 100644
--- a/recipes-devtools/libdispatch/libdispatch_git.bb
+++ b/recipes-devtools/libdispatch/libdispatch-native_git.bb
@@ -11,13 +11,12 @@ SECTION =3D "devel"
 SRCREV =3D "e85f6a0d5c9ea1f32f5013c3fa34e4fc146cd0eb"
 SRC_URI =3D "git://github.com/swiftlang/swift-corelibs-libdispatch.git;n=
obranch=3D1;protocol=3Dhttps"
=20
-inherit cmake
-
-BBCLASSEXTEND =3D "native"
+inherit cmake native
=20
 S =3D "${WORKDIR}/git"
 B =3D "${WORKDIR}/build"
=20
+
 DEPENDS +=3D " \
     clang-native \
     libcxx-native \
--=20
2.50.1 (Apple Git-155)


