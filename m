Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D564D35683
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 06:37:00 +0000 (UTC)
Received: from host.hernesphere.com (host.hernesphere.com [3.13.130.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7462.1769582216146833095
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 22:36:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: qinc.tv, ip: 3.13.130.34, mailfrom: dev@qinc.tv)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
Received: from localhost.localdomain (unknown [50.216.236.226])
	by host.hernesphere.com (Postfix) with ESMTPSA id 037D1106C68;
	Wed, 28 Jan 2026 00:36:53 -0600 (CST)
Authentication-Results: host.hernesphere.com;
        spf=pass (sender IP is 50.216.236.226) smtp.mailfrom=dev@qinc.tv smtp.helo=localhost.localdomain
Received-SPF: pass (host.hernesphere.com: connection is authenticated)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
From: "Eric L. Hernes" <dev@qinc.tv>
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Subject: [meta-darwin][PATCH 2/3] add recipe for libdmg-hfsplus
Date: Tue, 27 Jan 2026 22:36:47 -0800
Message-ID: <20260128063648.1422-2-dev@qinc.tv>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260128063648.1422-1-dev@qinc.tv>
References: <20260128063648.1422-1-dev@qinc.tv>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 06:37:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3126

libdmg-hfsplus contains the `hfsplus` program which copies files from
the filesystem to the .dmg image

Signed-off-by: Eric L. Hernes <dev@qinc.tv>
---
 .../libdmg-hfsplus/libdmg-hfsplus_git.bb         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 recipes-support/libdmg-hfsplus/libdmg-hfsplus_git.bb

diff --git a/recipes-support/libdmg-hfsplus/libdmg-hfsplus_git.bb b/recip=
es-support/libdmg-hfsplus/libdmg-hfsplus_git.bb
new file mode 100644
index 0000000..77ac88e
--- /dev/null
+++ b/recipes-support/libdmg-hfsplus/libdmg-hfsplus_git.bb
@@ -0,0 +1,16 @@
+SUMMARY =3D "Utilities for manipulating macOS dmg files"
+DESCRIPTION =3D "This is a set of utilities for manipulating macOS dmg a=
nd hfs files"
+HOMEPAGE =3D "https://github.com/elhernes/libdmg-hfsplus"
+
+LICENSE =3D "GPL-3.0-only"
+
+SRC_URI =3D "git://github.com/elhernes/libdmg-hfsplus.git;branch=3Dmaste=
r;protocol=3Dhttps"
+SRCREV =3D "3c3ce87a7e2f036f771f81147f9e125a2bb207f1"
+
+LIC_FILES_CHKSUM =3D "file://${WORKDIR}/git/LICENSE;md5=3Dd32239bcb67346=
3ab874e80d47fae504"
+
+S =3D "${WORKDIR}/git"
+
+inherit cmake
+
+BBCLASSEXTEND =3D "native"
--=20
2.50.1 (Apple Git-155)


