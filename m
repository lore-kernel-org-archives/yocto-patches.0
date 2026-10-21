Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11360.1792622691391646615
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Oct 2026 15:44:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id 2A32740CD4;
	Wed, 21 Oct 2026 22:44:50 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TOkptl7CRhyv; Wed, 21 Oct 2026 22:44:50 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-87-159.washdc.fios.verizon.net [100.15.87.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id E99C440C81;
	Wed, 21 Oct 2026 22:44:47 +0000 (UTC)
Received: from gimli.cabin (argonath.cabin [172.31.1.2])
	by mail.denix.org (Postfix) with ESMTP id 05EFF17EF05;
	Wed, 21 Oct 2026 18:44:46 -0400 (EDT)
From: Denys Dmytriyenko <denis@denix.org>
To: yocto-patches@lists.yoctoproject.org
Cc: "Denys Dmytriyenko (TI)" <denys@konsulko.com>,
	Ryan Eatmon <reatmon@ti.com>
Subject: [yocto-autobuilder-helper][PATCH] config.json: build weston image with meta-ti
Date: Wed, 21 Oct 2026 18:44:03 -0400
Message-Id: <20261021224403.17159-1-denis@denix.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 22:44:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5127
Content-Type: text/plain; charset="utf-8"

From: "Denys Dmytriyenko (TI)" <denys@konsulko.com>

Add a build of core-image-weston with meta-ti/meta-ti-bsp for
the j784s4-evm platform in TI K3 SoC family, which exercises
"baremetal" multiconfig build.

Signed-off-by: Denys Dmytriyenko (TI) <denys@konsulko.com>
Cc: Ryan Eatmon <reatmon@ti.com>
---
 config.json | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/config.json b/config.json
index 370ffde..db3a46c 100644
--- a/config.json
+++ b/config.json
@@ -707,6 +707,23 @@
                 "BBTARGETS": "aws-iot-device-sdk-cpp-v2"
             }
         },
+        "meta-ti" : {
+            "NEEDREPOS" : ["bitbake", "meta-arm", "meta-ti"],
+            "ADDLAYER" : [
+                "${BUILDDIR}/../meta-arm/meta-arm-toolchain",
+                "${BUILDDIR}/../meta-arm/meta-arm",
+                "${BUILDDIR}/../meta-ti/meta-ti-bsp"
+            ],
+            "step1": {
+                "shortname": "Build for j784s4-evm",
+                "MACHINE": "j784s4-evm",
+                "extravars" : [
+                    "DISTRO_FEATURES +=3D 'pam'",
+                    "DISTRO_FEATURES_OPTED_OUT +=3D 'x11'"
+                ],
+                "BBTARGETS" : "core-image-weston"
+            }
+        },
        "bringup" : {
             "SSTATEDIR" : ["SSTATE_DIR =3D '${HELPERBUILDDIR}/sstate'"],
             "TEMPLATE" : "bringup"
--=20
2.35.3

