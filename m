Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A24D35685
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 06:37:00 +0000 (UTC)
Received: from host.hernesphere.com (host.hernesphere.com [3.13.130.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7461.1769582213097423820
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 22:36:53 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: qinc.tv, ip: 3.13.130.34, mailfrom: dev@qinc.tv)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
Received: from localhost.localdomain (unknown [50.216.236.226])
	by host.hernesphere.com (Postfix) with ESMTPSA id A9809106C68;
	Wed, 28 Jan 2026 00:36:50 -0600 (CST)
Authentication-Results: host.hernesphere.com;
        spf=pass (sender IP is 50.216.236.226) smtp.mailfrom=dev@qinc.tv smtp.helo=localhost.localdomain
Received-SPF: pass (host.hernesphere.com: connection is authenticated)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
From: "Eric L. Hernes" <dev@qinc.tv>
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Subject: [meta-darwin][PATCH 1/3] add hfsprogs recipe
Date: Tue, 27 Jan 2026 22:36:46 -0800
Message-ID: <20260128063648.1422-1-dev@qinc.tv>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 06:37:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3125

hfsprogs is used to create the dmg image file for macOS

Signed-off-by: Eric L. Hernes <dev@qinc.tv>
---
 recipes-support/hfsprogs/hfsprogs_git.bb | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 recipes-support/hfsprogs/hfsprogs_git.bb

diff --git a/recipes-support/hfsprogs/hfsprogs_git.bb b/recipes-support/h=
fsprogs/hfsprogs_git.bb
new file mode 100644
index 0000000..17ac0d7
--- /dev/null
+++ b/recipes-support/hfsprogs/hfsprogs_git.bb
@@ -0,0 +1,35 @@
+SUMMARY =3D "HFS+ filesystem utilities for Linux"
+DESCRIPTION =3D "Apple's HFS+ filesystem utilities (mkfs.hfsplus, fsck.h=
fsplus) \
+adapted to work on Linux systems. Based on Apple's diskdev-cmds source c=
ode."
+HOMEPAGE =3D "https://github.com/Artoria2e5/hfsprogs"
+
+LICENSE =3D "APSL-2.0"
+LIC_FILES_CHKSUM =3D "file://README.md;md5=3Dea27fd14a7e575753270cc5527d=
29023"
+
+SRCREV =3D "47e4944b2abc57f5d8456ab399671a06031bbfb5"
+SRC_URI =3D "git://github.com/elhernes/hfsprogs.git;branch=3Dmaster;prot=
ocol=3Dhttps"
+
+S =3D "${WORKDIR}/git"
+
+DEPENDS =3D "openssl libbsd"
+
+EXTRA_OEMAKE =3D "-f Makefile.lnx"
+
+CFLAGS +=3D "-DDEBUG_BUILD=3D0 -D_FILE_OFFSET_BITS=3D64 -DLINUX=3D1 -DBS=
D=3D1 -I${S}/include"
+
+do_compile() {
+    oe_runmake ${EXTRA_OEMAKE}
+}
+
+do_install() {
+    install -d ${D}${sbindir}
+    install -d ${D}${mandir}/man8
+
+    install -m 0755 ${S}/newfs_hfs.tproj/newfs_hfs ${D}${sbindir}/mkfs.h=
fsplus
+    install -m 0755 ${S}/fsck_hfs.tproj/fsck_hfs ${D}${sbindir}/fsck.hfs=
plus
+
+    install -m 0644 ${S}/newfs_hfs.tproj/newfs_hfs.8 ${D}${mandir}/man8/=
mkfs.hfsplus.8
+    install -m 0644 ${S}/fsck_hfs.tproj/fsck_hfs.8 ${D}${mandir}/man8/fs=
ck.hfsplus.8
+}
+
+BBCLASSEXTEND =3D "native"
--=20
2.50.1 (Apple Git-155)


