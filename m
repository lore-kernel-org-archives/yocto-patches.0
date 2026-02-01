Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD65E7C710
	for <webhook@archiver.kernel.org>; Sun,  1 Feb 2026 04:32:02 +0000 (UTC)
Received: from host.hernesphere.com (host.hernesphere.com [3.13.130.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24025.1769920313982666873
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Jan 2026 20:31:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: qinc.tv, ip: 3.13.130.34, mailfrom: dev@qinc.tv)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
Received: from localhost.localdomain (165-23-88-160-dynamic.midco.net [165.23.88.160])
	by host.hernesphere.com (Postfix) with ESMTPSA id DEFFB106C83;
	Sat, 31 Jan 2026 22:31:51 -0600 (CST)
Authentication-Results: host.hernesphere.com;
        spf=pass (sender IP is 165.23.88.160) smtp.mailfrom=dev@qinc.tv smtp.helo=localhost.localdomain
Received-SPF: pass (host.hernesphere.com: connection is authenticated)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
From: "Eric L. Hernes" <dev@qinc.tv>
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Subject: [meta-darwin][PATCH] add hfsprogs (for mkfs.hfsplus)
Date: Sat, 31 Jan 2026 22:31:33 -0600
Message-ID: <20260201043133.20872-1-dev@qinc.tv>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 01 Feb 2026 04:32:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3163

mkfs.hfsplus is used to create the .dmg with hfsplus filesystem image
---
 recipes-support/hfsprogs/hfsprogs_git.bb | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 recipes-support/hfsprogs/hfsprogs_git.bb

diff --git a/recipes-support/hfsprogs/hfsprogs_git.bb b/recipes-support/h=
fsprogs/hfsprogs_git.bb
new file mode 100644
index 0000000..9dfdfbc
--- /dev/null
+++ b/recipes-support/hfsprogs/hfsprogs_git.bb
@@ -0,0 +1,18 @@
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
+SRCREV =3D "064b7fece00d069f206fd2d4a9a4493dd2777d9f"
+SRC_URI =3D "git://github.com/elhernes/hfsprogs.git;branch=3Dmaster;prot=
ocol=3Dhttps"
+
+S =3D "${WORKDIR}/git"
+
+DEPENDS =3D "openssl libbsd"
+
+inherit cmake native
+
+BBCLASSEXTEND +=3D "native"
--=20
2.50.1 (Apple Git-155)


