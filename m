Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB5FC25B7A
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 03:15:40 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.19835.1716779733241035630
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 May 2024 20:15:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5877813c0a=changqing.li@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R2eHCW002935
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 03:15:32 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yb6y5henr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 03:15:32 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 20:15:31 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 20:15:30 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>, <hongxu.jia@windriver.com>,
        <kai.kang@windriver.com>
Subject: [meta-anaconda][PATCH] recipes: WORKDIR -> UNPACKDIR transition
Date: Mon, 27 May 2024 11:15:29 +0800
Message-ID: <20240527031529.3012126-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NLKFaLShV98QVl2-B7s_yvGK4jgXuV1M
X-Proofpoint-GUID: NLKFaLShV98QVl2-B7s_yvGK4jgXuV1M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=979 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405270025
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 03:15:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/205

From: Changqing Li <changqing.li@windriver.com>

* WORKDIR -> UNPACKDIR transition
* Switch away from S = WORKDIR

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-core/systemd/systemd-serialgetty.bbappend     |  2 +-
 .../xorg-xserver/xserver-xf86-config_0.1.bbappend     |  8 ++++----
 recipes-installer/anaconda-init/anaconda-init.bb      | 11 ++++++-----
 .../anaconda/python3-anaconda_39.32.6.bb              |  8 ++++----
 .../initramfs-module-setup-live_1.0.bbappend          |  6 +++---
 recipes-installer/logos/yocto-compat-logos.bb         |  3 ++-
 .../multipath-tools/multipath-tools_%.bbappend        |  2 +-
 7 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/recipes-core/systemd/systemd-serialgetty.bbappend b/recipes-core/systemd/systemd-serialgetty.bbappend
index 0325192..519c1e6 100644
--- a/recipes-core/systemd/systemd-serialgetty.bbappend
+++ b/recipes-core/systemd/systemd-serialgetty.bbappend
@@ -7,7 +7,7 @@ SRC_URI:append:anaconda = " \
 do_install:append:anaconda() {
 	if [ "${INSTALLER_SERIAL}" = "1" ]; then
 		install -d ${D}${sysconfdir}/profile.d
-		install -m 644 ${WORKDIR}/serial-screen-anaconda.sh ${D}${sysconfdir}/profile.d/
+		install -m 644 ${UNPACKDIR}/serial-screen-anaconda.sh ${D}${sysconfdir}/profile.d/
 
 		sed -i -e 's,@ROOT_HOME@,${ROOT_HOME},g' ${D}${systemd_unitdir}/system/serial-getty@.service
 	fi
diff --git a/recipes-graphics/xorg-xserver/xserver-xf86-config_0.1.bbappend b/recipes-graphics/xorg-xserver/xserver-xf86-config_0.1.bbappend
index d62f8cc..788150f 100644
--- a/recipes-graphics/xorg-xserver/xserver-xf86-config_0.1.bbappend
+++ b/recipes-graphics/xorg-xserver/xserver-xf86-config_0.1.bbappend
@@ -1,12 +1,12 @@
 do_install:prepend:qemux86-64:anaconda () {
-    if test -s ${WORKDIR}/xorg.conf; then
-        sed -i 's/Modes *"640x480"/Modes    "1024x768"/g' ${WORKDIR}/xorg.conf
+    if test -s ${S}/xorg.conf; then
+        sed -i 's/Modes *"640x480"/Modes    "1024x768"/g' ${S}/xorg.conf
     fi
 }
 
 do_install:prepend:qemux86:anaconda () {
-    if test -s ${WORKDIR}/xorg.conf; then
-        sed -i 's/Modes *"640x480"/Modes    "1024x768"/g' ${WORKDIR}/xorg.conf
+    if test -s ${S}/xorg.conf; then
+        sed -i 's/Modes *"640x480"/Modes    "1024x768"/g' ${S}/xorg.conf
     fi
 }
 
diff --git a/recipes-installer/anaconda-init/anaconda-init.bb b/recipes-installer/anaconda-init/anaconda-init.bb
index 61e3190..8218767 100644
--- a/recipes-installer/anaconda-init/anaconda-init.bb
+++ b/recipes-installer/anaconda-init/anaconda-init.bb
@@ -9,7 +9,8 @@ SRC_URI = "file://anaconda-init \
            file://Xusername \
            file://COPYING"
 
-S = "${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
 PACKAGE_ARCH = "${MACHINE_ARCH}"
 
@@ -35,7 +36,7 @@ CLEANBROKEN = "1"
 
 do_install() {
     install -d ${D}/${sbindir}
-    install -m 0755 ${WORKDIR}/anaconda-init ${D}${sbindir}/anaconda-init
+    install -m 0755 ${S}/anaconda-init ${D}${sbindir}/anaconda-init
     if [ -n "${EULA_DIR}" ]; then
         sed -i "s#@EULA_DIR@#${EULA_DIR}#g" ${D}${sbindir}/anaconda-init
     else
@@ -47,9 +48,9 @@ do_install() {
     install -d ${D}/${sysconfdir}/init.d
     ln -sf ${sbindir}/anaconda-init ${D}/${sysconfdir}/init.d/anaconda-init
     install -d ${D}${systemd_unitdir}/system
-    install -m 0644 ${WORKDIR}/anaconda-init.service \
-                    ${WORKDIR}/anaconda-init-screen@.service \
-                    ${WORKDIR}/anaconda-init.target \
+    install -m 0644 ${S}/anaconda-init.service \
+                    ${S}/anaconda-init-screen@.service \
+                    ${S}/anaconda-init.target \
                ${D}${systemd_unitdir}/system
 
 
diff --git a/recipes-installer/anaconda/python3-anaconda_39.32.6.bb b/recipes-installer/anaconda/python3-anaconda_39.32.6.bb
index 9c5ef5b..7fcfa9a 100755
--- a/recipes-installer/anaconda/python3-anaconda_39.32.6.bb
+++ b/recipes-installer/anaconda/python3-anaconda_39.32.6.bb
@@ -93,12 +93,12 @@ do_configure:prepend() {
 
 do_install:append() {
     mkdir -p ${D}${datadir}/anaconda/post-scripts
-    install -m 644 ${WORKDIR}/81-edit-sudoers.ks ${D}${datadir}/anaconda/post-scripts
-    install -m 644 ${WORKDIR}/81-systemd-preset-all.ks ${D}${datadir}/anaconda/post-scripts
-    install -m 644 ${WORKDIR}/81-add-env-file-for-sshd.ks ${D}${datadir}/anaconda/post-scripts
+    install -m 644 ${UNPACKDIR}/81-edit-sudoers.ks ${D}${datadir}/anaconda/post-scripts
+    install -m 644 ${UNPACKDIR}/81-systemd-preset-all.ks ${D}${datadir}/anaconda/post-scripts
+    install -m 644 ${UNPACKDIR}/81-add-env-file-for-sshd.ks ${D}${datadir}/anaconda/post-scripts
     install -m 644 ${S}/widgets/src/resources/*.svg ${D}${datadir}/anaconda/pixmaps
     install -m 644 ${S}/widgets/src/resources/*.png ${D}${datadir}/anaconda/pixmaps
-    install -m 644 ${WORKDIR}/fedora.css ${D}${datadir}/anaconda/pixmaps
+    install -m 644 ${UNPACKDIR}/fedora.css ${D}${datadir}/anaconda/pixmaps
 }
 
 python __anonymous () {
diff --git a/recipes-installer/initrdscripts/initramfs-module-setup-live_1.0.bbappend b/recipes-installer/initrdscripts/initramfs-module-setup-live_1.0.bbappend
index 6be120d..0ed97d1 100644
--- a/recipes-installer/initrdscripts/initramfs-module-setup-live_1.0.bbappend
+++ b/recipes-installer/initrdscripts/initramfs-module-setup-live_1.0.bbappend
@@ -7,9 +7,9 @@ SRC_URI:append:anaconda = " \
 "
 
 do_install:append:anaconda() {
-    install -m 0755 ${WORKDIR}/union-fs ${D}/init.d/91-union-fs
-    install -m 0755 ${WORKDIR}/realroot ${D}/init.d/92-realroot
-    install -m 0755 ${WORKDIR}/umountfs ${D}/init.d/93-umountfs
+    install -m 0755 ${UNPACKDIR}/union-fs ${D}/init.d/91-union-fs
+    install -m 0755 ${UNPACKDIR}/realroot ${D}/init.d/92-realroot
+    install -m 0755 ${UNPACKDIR}/umountfs ${D}/init.d/93-umountfs
 }
 
 FILES:${PN}:append:anaconda = " \
diff --git a/recipes-installer/logos/yocto-compat-logos.bb b/recipes-installer/logos/yocto-compat-logos.bb
index c5d1875..c76c835 100644
--- a/recipes-installer/logos/yocto-compat-logos.bb
+++ b/recipes-installer/logos/yocto-compat-logos.bb
@@ -8,7 +8,8 @@ SRC_URI = "file://sidebar-logo.png \
            file://banner_yocto2.png \
            file://COPYING"
 
-S = "${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
 inherit allarch
 
diff --git a/recipes-support/multipath-tools/multipath-tools_%.bbappend b/recipes-support/multipath-tools/multipath-tools_%.bbappend
index 5ce6b3c..9ec4428 100644
--- a/recipes-support/multipath-tools/multipath-tools_%.bbappend
+++ b/recipes-support/multipath-tools/multipath-tools_%.bbappend
@@ -2,7 +2,7 @@ SYSTEMD_AUTO_ENABLE:anaconda = "disable"
 
 do_install:append:anaconda () {
     install -d ${D}${sysconfdir}/multipath
-    install -m 0644 ${WORKDIR}/multipath.conf.example \
+    install -m 0644 ${UNPACKDIR}/multipath.conf.example \
     ${D}${sysconfdir}/multipath.conf
 }
 
-- 
2.25.1


