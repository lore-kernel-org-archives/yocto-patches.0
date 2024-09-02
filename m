Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FACCD13CF
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 06:40:47 +0000 (UTC)
Received: from TWMBX01.aspeed.com (TWMBX01.aspeed.com [211.20.114.72])
 by mx.groups.io with SMTP id smtpd.web11.31133.1725249630289595922
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 01 Sep 2024 21:00:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: aspeedtech.com, ip: 211.20.114.72, mailfrom: jamin_lin@aspeedtech.com)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 2 Sep
 2024 12:00:28 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 2 Sep 2024 12:00:28 +0800
From: "Jamin Lin" <jamin_lin@aspeedtech.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <troy_lee@aspeedtech.com>, <jamin_lin@aspeedtech.com>,
	<jaminlin1207@gmail.com>, <vince_chang@aspeedtech.com>
Subject: [meta-zephyr][PATCH v1 2/2] zephyr-kernel: support to deploy users customize image
Date: Mon, 2 Sep 2024 12:00:27 +0800
Message-ID: <20240902040027.1197998-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902040027.1197998-1-jamin_lin@aspeedtech.com>
References: <20240902040027.1197998-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Sep 2024 06:40:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/603

In the previous design, it only deployed zephyr.elf,
zephyr.bin and zephyr.efi.
If users want to deploy their customize images, they should update do_insta=
ll task.
Add to check "ZEPHYR_MAKE_OUTPUT" to deploy users customize images and zeph=
yr images.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 .../zephyr-kernel/zephyr-image.inc            | 21 +++++++------------
 .../zephyr-kernel/zephyr-kernel-common.inc    |  8 ++++---
 .../zephyr-kernel/zephyr-openamp-rsc-table.bb |  8 ++++---
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc=
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
index d6ee21f..c747095 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
@@ -6,24 +6,19 @@ OECMAKE_SOURCEPATH =3D "${ZEPHYR_SRC_DIR}"
=20
 do_install() {
     install -d ${D}/firmware
-
-    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT} ${D}/firmware/${PN}.elf
-
-    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
-    then
-      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ${D}/firmware/${PN}=
.bin
-    fi
-
-    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
-    then
-      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ${D}/firmware/${PN}=
.efi
-    fi
+  =20
+    for output in ${ZEPHYR_MAKE_OUTPUT}; do
+        if [ -f ${B}/zephyr/${output} ];
+        then
+          install -D ${B}/zephyr/${output} ${D}/firmware/
+        fi
+    done
 }
 FILES:${PN} =3D "/firmware"
 INSANE_SKIP +=3D "ldflags buildpaths"
 SYSROOT_DIRS +=3D "/firmware"
=20
 do_deploy() {
-    cp ${D}/firmware/${PN}.* ${DEPLOYDIR}/
+    cp ${D}/firmware/* ${DEPLOYDIR}/
 }
 addtask deploy after do_install
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-co=
mmon.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-comm=
on.inc
index ba70a29..8a1638d 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
@@ -10,9 +10,11 @@ IMAGE_NO_MANIFEST =3D "1"
 ZEPHYR_TOOLCHAIN_VARIANT ?=3D "cross-compile"
 require zephyr-toolchain-${ZEPHYR_TOOLCHAIN_VARIANT}.inc
=20
-ZEPHYR_MAKE_OUTPUT =3D "zephyr.elf"
-ZEPHYR_MAKE_BIN_OUTPUT =3D "zephyr.bin"
-ZEPHYR_MAKE_EFI_OUTPUT =3D "zephyr.efi"
+ZEPHYR_MAKE_OUTPUT ?=3D "\
+    zephyr.elf \
+    zephyr.bin \
+    zephyr.efi \
+    "
=20
 EXTRA_OECMAKE =3D "\
     -DZEPHYR_BASE=3D${ZEPHYR_BASE} \
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-r=
sc-table.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-=
rsc-table.bb
index 5e51c23..8a95b14 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rsc-tabl=
e.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rsc-tabl=
e.bb
@@ -1,9 +1,11 @@
 include zephyr-sample.inc
=20
=20
-ZEPHYR_MAKE_OUTPUT =3D "zephyr_openamp_rsc_table.elf"
-ZEPHYR_MAKE_BIN_OUTPUT =3D "zephyr_openamp_rsc_table.bin"
-ZEPHYR_MAKE_EFI_OUTPUT =3D "zephyr_openamp_rsc_table.efi"
+ZEPHYR_MAKE_OUTPUT ?=3D " \
+    zephyr_openamp_rsc_table.elf \
+    zephyr_openamp_rsc_table.bin \
+    zephyr_openamp_rsc_table.efi \
+    "
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/subsys/ipc/openamp_rsc_table"
=20
--=20
2.25.1


