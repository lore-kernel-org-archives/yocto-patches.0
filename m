Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58791D35683
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 06:37:10 +0000 (UTC)
Received: from host.hernesphere.com (host.hernesphere.com [3.13.130.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7464.1769582220157986477
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 22:37:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: qinc.tv, ip: 3.13.130.34, mailfrom: dev@qinc.tv)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
Received: from localhost.localdomain (unknown [50.216.236.226])
	by host.hernesphere.com (Postfix) with ESMTPSA id F0F9E106C69;
	Wed, 28 Jan 2026 00:36:57 -0600 (CST)
Authentication-Results: host.hernesphere.com;
        spf=pass (sender IP is 50.216.236.226) smtp.mailfrom=dev@qinc.tv smtp.helo=localhost.localdomain
Received-SPF: pass (host.hernesphere.com: connection is authenticated)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
From: "Eric L. Hernes" <dev@qinc.tv>
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Subject: [meta-darwin][PATCH 3/3] add bomutils recipe
Date: Tue, 27 Jan 2026 22:36:48 -0800
Message-ID: <20260128063648.1422-3-dev@qinc.tv>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260128063648.1422-1-dev@qinc.tv>
References: <20260128063648.1422-1-dev@qinc.tv>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 06:37:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3127

bomutils is used to build the bill of materials files for macOS .pkg inst=
allers

Signed-off-by: Eric L. Hernes <dev@qinc.tv>
---
 recipes-support/bomutils/bomutils_git.bb | 34 ++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 recipes-support/bomutils/bomutils_git.bb

diff --git a/recipes-support/bomutils/bomutils_git.bb b/recipes-support/b=
omutils/bomutils_git.bb
new file mode 100644
index 0000000..04e6dbd
--- /dev/null
+++ b/recipes-support/bomutils/bomutils_git.bb
@@ -0,0 +1,34 @@
+SUMMARY =3D "Bill Of Materials Utils"
+HOMEPAGE =3D "https://github.com/hogliux/bomutils"
+LICENSE =3D "GPL-2.0-only"
+
+SRCREV =3D "f62b59c659b1e57788661dadf87765e226824f67"
+SRC_URI =3D " \
+    git://github.com/elhernes/bomutils.git;branch=3Dmaster;protocol=3Dht=
tps \
+"
+
+LIC_FILES_CHKSUM =3D "file://${WORKDIR}/git/LICENSE;md5=3D55d923cdeef7e4=
6b4d6415cb173b345a"
+
+BBCLASSEXTEND =3D "native"
+
+S =3D "${WORKDIR}/git"
+B =3D "${WORKDIR}/git/build"
+
+do_compile() {
+    make -C ${S}
+}
+
+do_install() {
+    install -d ${D}${bindir}
+    install -d ${D}${mandir}/man1
+
+    install -m 0755 ${B}/bin/ls4mkbom ${D}${bindir}
+    install -m 0755 ${B}/bin/dumpbom ${D}${bindir}
+    install -m 0755 ${B}/bin/lsbom ${D}${bindir}
+    install -m 0755 ${B}/bin/mkbom ${D}${bindir}
+
+    install -m 0444 ${B}/man/ls4mkbom.1.gz ${D}${mandir}/man1
+    install -m 0444 ${B}/man/dumpbom.1.gz ${D}${mandir}/man1
+    install -m 0444 ${B}/man/lsbom.1.gz ${D}${mandir}/man1
+    install -m 0444 ${B}/man/mkbom.1.gz ${D}${mandir}/man1
+}
--=20
2.50.1 (Apple Git-155)


