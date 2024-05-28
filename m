Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E081C25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 05:44:10 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.15450.1716875048823474950
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 22:44:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5878445e50=changqing.li@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44S50lHT004357
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 22:44:08 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ybfgga8uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 22:44:08 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 22:44:07 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 22:44:07 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH] recipes: WORKDIR -> UNPACKDIR transition
Date: Tue, 28 May 2024 13:44:06 +0800
Message-ID: <20240528054406.4031866-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nKSGoBr2EPGlBhl8d4KB76ajSIeOCnJc
X-Proofpoint-ORIG-GUID: nKSGoBr2EPGlBhl8d4KB76ajSIeOCnJc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_03,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=736 priorityscore=1501 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280040
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 05:44:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/230

From: Changqing Li <changqing.li@windriver.com>

* WORKDIR -> UNPACKDIR transition
* Switch away from S = WORKDIR

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 .../recipes-security/sssd/sssd_2.9.2.bb       |  2 +-
 .../recipes-core/systemd/systemd_%.bbappend   |  2 +-
 .../tpm2-abrmd/tpm2-abrmd_3.0.0.bb            |  4 +--
 .../initrdscripts/initramfs-framework.inc     |  2 +-
 recipes-ids/samhain/samhain-server.bb         |  4 +--
 recipes-ids/samhain/samhain.inc               | 14 ++++-----
 recipes-mac/smack/mmap-smack-test_1.0.bb      |  4 ++-
 recipes-mac/smack/smack-test_1.0.bb           |  3 +-
 recipes-mac/smack/tcp-smack-test_1.0.bb       |  3 +-
 recipes-mac/smack/udp-smack-test_1.0.bb       |  3 +-
 .../ecryptfs-utils/ecryptfs-utils_111.bb      |  2 +-
 recipes-security/libmhash/libmhash_0.9.9.9.bb |  4 +--
 .../redhat-security/redhat-security_1.0.bb    | 29 ++++++++++---------
 13 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index d61471c..c53ec58 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -91,7 +91,7 @@ do_install () {
     install -d ${D}/${PYTHON_SITEPACKAGES_DIR}
     mv ${D}/${BPN}  ${D}/${PYTHON_SITEPACKAGES_DIR}
 
-    install -m 600 ${WORKDIR}/${BPN}.conf ${D}/${sysconfdir}/${BPN}
+    install -m 600 ${UNPACKDIR}/${BPN}.conf ${D}/${sysconfdir}/${BPN}
 
     # /var/log/sssd needs to be created in runtime. Use rmdir to catch if
     # upstream stops creating /var/log/sssd, or adds something else in
diff --git a/meta-integrity/recipes-core/systemd/systemd_%.bbappend b/meta-integrity/recipes-core/systemd/systemd_%.bbappend
index 57b3684..f140f02 100644
--- a/meta-integrity/recipes-core/systemd/systemd_%.bbappend
+++ b/meta-integrity/recipes-core/systemd/systemd_%.bbappend
@@ -8,6 +8,6 @@ SRC_URI += " \
 do_install:append () {
     for i in machine-id-commit random-seed; do
         install -d ${D}/${systemd_system_unitdir}/systemd-$i.service.d
-        install -m 0644 ${WORKDIR}/$i-sync.conf ${D}/${systemd_system_unitdir}/systemd-$i.service.d
+        install -m 0644 ${UNPACKDIR}/$i-sync.conf ${D}/${systemd_system_unitdir}/systemd-$i.service.d
     done
 }
diff --git a/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb b/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
index ea2433c..24fd5b5 100644
--- a/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
@@ -40,10 +40,10 @@ PACKAGECONFIG[systemd] = "--with-systemdsystemunitdir=${systemd_system_unitdir},
 
 do_install:append() {
     install -d "${D}${sysconfdir}/init.d"
-    install -m 0755 "${WORKDIR}/tpm2-abrmd-init.sh" "${D}${sysconfdir}/init.d/tpm2-abrmd"
+    install -m 0755 "${UNPACKDIR}/tpm2-abrmd-init.sh" "${D}${sysconfdir}/init.d/tpm2-abrmd"
 
     install -d "${D}${sysconfdir}/default"
-    install -m 0644 "${WORKDIR}/tpm2-abrmd.default" "${D}${sysconfdir}/default/tpm2-abrmd"
+    install -m 0644 "${UNPACKDIR}/tpm2-abrmd.default" "${D}${sysconfdir}/default/tpm2-abrmd"
 }
 
 FILES:${PN} += "${libdir}/systemd/system-preset \
diff --git a/recipes-core/initrdscripts/initramfs-framework.inc b/recipes-core/initrdscripts/initramfs-framework.inc
index 1a724d6..aa04348 100644
--- a/recipes-core/initrdscripts/initramfs-framework.inc
+++ b/recipes-core/initrdscripts/initramfs-framework.inc
@@ -6,7 +6,7 @@ SRC_URI:append = "\
 
 do_install:append() {
     # dm-verity
-    install ${WORKDIR}/dmverity ${D}/init.d/80-dmverity
+    install ${S}/dmverity ${D}/init.d/80-dmverity
 }
 
 PACKAGES:append = " initramfs-module-dmverity"
diff --git a/recipes-ids/samhain/samhain-server.bb b/recipes-ids/samhain/samhain-server.bb
index 8bae2d2..030ec2b 100644
--- a/recipes-ids/samhain/samhain-server.bb
+++ b/recipes-ids/samhain/samhain-server.bb
@@ -16,11 +16,11 @@ TARGET_CC_ARCH += "${LDFLAGS}"
 do_install:append() {
     if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
         install -d ${D}${sysconfdir}/tmpfiles.d
-        install -m 0644 ${WORKDIR}/samhain-server-volatiles.conf \
+        install -m 0644 ${UNPACKDIR}/samhain-server-volatiles.conf \
             ${D}${sysconfdir}/tmpfiles.d/samhain-server.conf
     else
         install -d ${D}${sysconfdir}/default/volatiles
-        install -m 0644 ${WORKDIR}/samhain-server-volatiles \
+        install -m 0644 ${UNPACKDIR}/samhain-server-volatiles \
             ${D}${sysconfdir}/default/volatiles/samhain-server
     fi
 
diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
index f5bea1d..61ec0da 100644
--- a/recipes-ids/samhain/samhain.inc
+++ b/recipes-ids/samhain/samhain.inc
@@ -64,8 +64,8 @@ EXTRA_OEMAKE:append:aarch64 = " CPPFLAGS+=-DCONFIG_ARCH_AARCH64=1"
 EXTRA_OEMAKE:append:mips64 = " CPPFLAGS+=-DCONFIG_ARCH_MIPS64=1"
 
 do_unpack_samhain() {
-    cd ${WORKDIR}
-    tar -xzvf samhain-${PV}.tar.gz
+    cd ${UNPACKDIR}
+    tar -xzvf samhain-${PV}.tar.gz -C ${WORKDIR}
 }
 
 python do_unpack:append() {
@@ -129,19 +129,19 @@ do_compile:prepend:libc-musl () {
 do_install:append () {
 	oe_runmake install DESTDIR='${D}' INSTALL=install-boot
 
-	install -D -m 755 ${WORKDIR}/${INITSCRIPT_NAME}.init \
+	install -D -m 755 ${UNPACKDIR}/${INITSCRIPT_NAME}.init \
 		${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}
 
-	install -D -m 755 ${WORKDIR}/${INITSCRIPT_NAME}.default \
+	install -D -m 755 ${UNPACKDIR}/${INITSCRIPT_NAME}.default \
 		${D}${sysconfdir}/default/${INITSCRIPT_NAME}
 
 	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
 		if [ "${SAMHAIN_MODE}" = "no" ]; then
-		    install -D -m 0644 ${WORKDIR}/samhain.service ${D}/${systemd_system_unitdir}/samhain.service
+		    install -D -m 0644 ${UNPACKDIR}/samhain.service ${D}/${systemd_system_unitdir}/samhain.service
 		else
-		    install -D -m 0644 ${WORKDIR}/samhain.service ${D}/${systemd_system_unitdir}/${BPN}.service
+		    install -D -m 0644 ${UNPACKDIR}/samhain.service ${D}/${systemd_system_unitdir}/${BPN}.service
 		fi
-		install -D -m 0755 ${WORKDIR}/${BPN}.init ${D}/${libexecdir}/${BPN}
+		install -D -m 0755 ${UNPACKDIR}/${BPN}.init ${D}/${libexecdir}/${BPN}
 		sed -i -e 's,@LIBDIR@,${libexecdir},' \
 		       -e 's,@SAMHAIN_HELPER@,${BPN},' \
 		       -e 's,@MODE_NAME@,${MODE_NAME},' \
diff --git a/recipes-mac/smack/mmap-smack-test_1.0.bb b/recipes-mac/smack/mmap-smack-test_1.0.bb
index 9d11509..b11fbf3 100644
--- a/recipes-mac/smack/mmap-smack-test_1.0.bb
+++ b/recipes-mac/smack/mmap-smack-test_1.0.bb
@@ -5,7 +5,9 @@ LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda
 
 SRC_URI = "file://mmap.c" 
 
-S = "${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
+
 do_compile() {
     ${CC} mmap.c ${LDFLAGS} -o mmap_test
 }
diff --git a/recipes-mac/smack/smack-test_1.0.bb b/recipes-mac/smack/smack-test_1.0.bb
index 3ab57c6..cb5327a 100644
--- a/recipes-mac/smack/smack-test_1.0.bb
+++ b/recipes-mac/smack/smack-test_1.0.bb
@@ -10,7 +10,8 @@ SRC_URI = " \
            file://test_smack_onlycap.sh \
 " 
 
-S = "${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
 inherit features_check
 
diff --git a/recipes-mac/smack/tcp-smack-test_1.0.bb b/recipes-mac/smack/tcp-smack-test_1.0.bb
index d2b3f6b..020d4b4 100644
--- a/recipes-mac/smack/tcp-smack-test_1.0.bb
+++ b/recipes-mac/smack/tcp-smack-test_1.0.bb
@@ -8,7 +8,8 @@ SRC_URI = "file://tcp_server.c \
            file://test_smack_tcp_sockets.sh \
 " 
 
-S = "${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
 do_compile() {
     ${CC} tcp_client.c ${LDFLAGS} -o tcp_client
diff --git a/recipes-mac/smack/udp-smack-test_1.0.bb b/recipes-mac/smack/udp-smack-test_1.0.bb
index 9193f89..edef801 100644
--- a/recipes-mac/smack/udp-smack-test_1.0.bb
+++ b/recipes-mac/smack/udp-smack-test_1.0.bb
@@ -7,8 +7,9 @@ SRC_URI = "file://udp_server.c \
            file://udp_client.c \
            file://test_smack_udp_sockets.sh \
 " 
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
-S = "${WORKDIR}"
 do_compile() {
     ${CC} udp_client.c ${LDFLAGS} -o udp_client
     ${CC} udp_server.c ${LDFLAGS} -o udp_server
diff --git a/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb b/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb
index 00e8997..83d37d6 100644
--- a/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb
+++ b/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb
@@ -62,7 +62,7 @@ do_install:append() {
            -e 's:-L${STAGING_LIBDIR}::' ${D}/${libdir}/pkgconfig/libecryptfs.pc
     sed -i -e "s: ${base_sbindir}/cryptsetup: ${sbindir}/cryptsetup:" ${D}${bindir}/ecryptfs-setup-swap
     if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
-        install -D -m 0644 ${WORKDIR}/ecryptfs.service ${D}${systemd_system_unitdir}/ecryptfs.service
+        install -D -m 0644 ${UNPACKDIR}/ecryptfs.service ${D}${systemd_system_unitdir}/ecryptfs.service
     fi
 }
 
diff --git a/recipes-security/libmhash/libmhash_0.9.9.9.bb b/recipes-security/libmhash/libmhash_0.9.9.9.bb
index 49139d2..f725a26 100644
--- a/recipes-security/libmhash/libmhash_0.9.9.9.bb
+++ b/recipes-security/libmhash/libmhash_0.9.9.9.bb
@@ -31,8 +31,8 @@ do_install:append() {
 
 do_compile_ptest() {
     if [ ! -d ${S}/demo ]; then mkdir ${S}/demo; fi
-    cp ${WORKDIR}/Makefile.test ${S}/demo/Makefile
-    cp ${WORKDIR}/mhash.c ${S}/demo/
+    cp ${UNPACKDIR}/Makefile.test ${S}/demo/Makefile
+    cp ${UNPACKDIR}/mhash.c ${S}/demo/
     make -C ${S}/demo CFLAGS="${CFLAGS} -I${S}/include/" LDFLAGS="${LDFLAGS} -L${S}/lib/.libs"
 }
 
diff --git a/recipes-security/redhat-security/redhat-security_1.0.bb b/recipes-security/redhat-security/redhat-security_1.0.bb
index c47688f..1f0ba6c 100644
--- a/recipes-security/redhat-security/redhat-security_1.0.bb
+++ b/recipes-security/redhat-security/redhat-security_1.0.bb
@@ -18,23 +18,24 @@ SRC_URI = "file://find-chroot-py.sh \
            file://selinux-check-devices.sh \
            file://selinux-ls-unconfined.sh"
 
-S = "${WORKDIR}"
+S = "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
 
 do_install() {
 	install -d ${D}${bindir}
-	install -m 0755 ${WORKDIR}/find-chroot-py.sh    ${D}${bindir}
-	install -m 0755 ${WORKDIR}/find-chroot.sh    ${D}${bindir}
-	install -m 0755 ${WORKDIR}/find-elf4tmp.sh    ${D}${bindir}
-	install -m 0755 ${WORKDIR}/find-execstack.sh    ${D}${bindir}
-	install -m 0755 ${WORKDIR}/find-hidden-exec.sh    ${D}${bindir}
-	install -m 0755 ${WORKDIR}/find-nodrop-groups.sh    ${D}${bindir}
-	install -m 0755 ${WORKDIR}/find-sh4errors.sh    ${D}${bindir}
-	install -m 0755 ${WORKDIR}/find-sh4tmp.sh    ${D}${bindir}
-	install -m 0755 ${WORKDIR}/lib-bin-check.sh    ${D}${bindir}
-	install -m 0755 ${WORKDIR}/rpm-chksec.sh    ${D}${bindir}
-	install -m 0755 ${WORKDIR}/rpm-drop-groups.sh    ${D}${bindir}
-	install -m 0755 ${WORKDIR}/selinux-check-devices.sh    ${D}${bindir}
-	install -m 0755 ${WORKDIR}/selinux-ls-unconfined.sh    ${D}${bindir}
+	install -m 0755 ${S}/find-chroot-py.sh    ${D}${bindir}
+	install -m 0755 ${S}/find-chroot.sh    ${D}${bindir}
+	install -m 0755 ${S}/find-elf4tmp.sh    ${D}${bindir}
+	install -m 0755 ${S}/find-execstack.sh    ${D}${bindir}
+	install -m 0755 ${S}/find-hidden-exec.sh    ${D}${bindir}
+	install -m 0755 ${S}/find-nodrop-groups.sh    ${D}${bindir}
+	install -m 0755 ${S}/find-sh4errors.sh    ${D}${bindir}
+	install -m 0755 ${S}/find-sh4tmp.sh    ${D}${bindir}
+	install -m 0755 ${S}/lib-bin-check.sh    ${D}${bindir}
+	install -m 0755 ${S}/rpm-chksec.sh    ${D}${bindir}
+	install -m 0755 ${S}/rpm-drop-groups.sh    ${D}${bindir}
+	install -m 0755 ${S}/selinux-check-devices.sh    ${D}${bindir}
+	install -m 0755 ${S}/selinux-ls-unconfined.sh    ${D}${bindir}
 }
 
 RDEPENDS:${PN} = "file libcap-ng procps findutils"
-- 
2.25.1


