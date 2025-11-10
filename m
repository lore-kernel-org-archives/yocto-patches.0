Return-Path: <hemant.jadhav@emerson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B63ACCF9E3
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 21:44:53 +0000 (UTC)
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2581.1762811090297184723
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Nov 2025 13:44:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@emerson.com header.s=email header.b=Ukb0BheA;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: emerson.com, ip: 148.163.142.35, mailfrom: prvs=04098c52d2=hemant.jadhav@emerson.com)
Received: from pps.filterd (m0484883.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAL38KK019806
	for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 21:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=email; bh=nYWtZ/ZYw42gF0kWUi8+luC36K
	03uoqPumXxECNnDjs=; b=Ukb0BheAj6o3hCE+PeK888u2lpuxrnBK0J4WlxDxDZ
	oTVt8IsvwBpcVjGYRbTxWQ8MxmmRDX1qPkP7YTeSYgjCcu3Knozf3gBDY+Mt8jg8
	5fXQ0YTdBF7hxNuGHtN02g+Vs13HcNcJosvW7iC8HvO9jC2rHA+QgX1UTFMYeMS8
	FUObHosTl7ykZ4aRaeFckqneaAPQOplc1BNfEaTm988OYlj1/MunlE7PDYutwl0K
	oQzpNthU47mNmDF+wyKUu5+uaOgAz0mhAZCSowmAN0bCcLscH+NDVSW0w6xZ7wtD
	tMdmsMjuDzEAPm3AU70PuFxalyYzJhQ7FRHYT6WpDKuQ==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 4abewvchy6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 21:44:49 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 10 Nov 2025 15:44:47 -0600
Received: from hjadhav-Virtual-Machine.mshome.net (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 10 Nov 2025 15:44:47
 -0600
From: Hemant Jadhav <hemant.jadhav@emerson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Hemant Jadhav <hemant.jadhav@emerson.com>
Subject: [meta-security][PATCH v2 1/2] clamav: Add ClamAV 1.4.3 recipe with enhanced security and Rust support
Date: Mon, 10 Nov 2025 15:44:34 -0600
Message-ID: <20251110214435.69522-1-hemant.jadhav@emerson.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5NyBTYWx0ZWRfX3Be2A/d575K/ P2r496lC5jkW/SgfXwFQ2wWxhqGduj9o3CVg2stt4vKJs58EBOsJ9Mv+2qAlvAlfheYSJIMPj9p nM72wjBZK9mSU5TAeaRyCGV/0yOX8ofieHXWuXxcpBDN8gTKxZ2YOkgBAYO4R6dcU02GaFGxrAN
 fqFc7xpUGZk2EDyOPgowRF8a1fC/QegnfT+QLo3C4iT9oDHhe8wdPHUAgG2lZTp/clU28eKJUeI 9RuTAuQ4bpGvr9QmfQvlfGU4JAondkPt4AfQW+H+AN8S+ls9MJndKvF7cy8lla4d3g9mVn6Z8/C AQcpo6wE4dg+43ady0Jlyxs4rKSsWl/bajiUZwDyrzh2jmOcpnh7gx9jfHzz/mejhYvmf4gRYif
 Ew1XsTaMSA8PneGO14eZ+ikl+MrVUQ==
X-Proofpoint-GUID: jTsgTuQ-Su9Xe8NNXYTawbIVk-pV_Z3f
X-Proofpoint-ORIG-GUID: jTsgTuQ-Su9Xe8NNXYTawbIVk-pV_Z3f
X-Authority-Analysis: v=2.4 cv=TY+bdBQh c=1 sm=1 tr=0 ts=69125cd1 cx=c_pps a=cVKeW2pxJVqlUTLH3Z+MUA==:117 a=cVKeW2pxJVqlUTLH3Z+MUA==:17 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=tPundid6AAAA:8 a=geDs06hvAAAA:8 a=NEAV23lmAAAA:8 a=kF9r1W5OH557fpoJvrAA:9
 a=aPicV9olnlo_TREvANR5:22 a=7yvi0DHx91fDKfvzWsLo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2510240000 definitions=main-2511100097
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 21:44:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2476

Add modern ClamAV 1.4.3 recipe with comprehensive improvements over
the legacy 0.104.4 version.

Major changes in 1.4.3:
- Upgraded core engine with improved threat detection capabilities
- Added Rust components requiring cross-compilation support
- Updated CMake build system replacing legacy autotools
- Modernized library dependencies (LLVM, JSON-C, PCre2)
- Added comprehensive license compliance for multi-component package
- Enhanced cross-compilation support for all target architectures

The recipe leverages cargo_common class for automatic Rust toolchain
configuration, eliminating manual Cargo setup. File paths use UNPACKDIR
for compatibility with master branch.

- Implemented CMake cache variables for cross-compilation
- Updated all license checksums for compliance
- Added Rust toolchain integration with automatic environment setup

Security rationale:
- ClamAV 0.104.4 reached end-of-life and is no longer maintained
- Upstream strongly recommends migration to 1.4.x for security updates

Signed-off-by: Hemant Jadhav <hemant.jadhav@emerson.com>
---
v2: Address review comments:
- Remove S variable (auto-detected in master branch)
- Use cargo_common instead of rust-common (handles config.toml automatically)
- Remove manual Cargo configuration in do_configure:prepend()
- Change ${WORKDIR} to ${UNPACKDIR} for file path references
---
 recipes-scanners/clamav/clamav_1.4.3.bb       | 182 ++++++++++++++++++
 recipes-scanners/clamav/files/tmpfiles.clamav |   1 +
 .../clamav/files/volatiles.03_clamav          |   1 +
 3 files changed, 184 insertions(+)
 create mode 100644 recipes-scanners/clamav/clamav_1.4.3.bb

diff --git a/recipes-scanners/clamav/clamav_1.4.3.bb b/recipes-scanners/clamav/clamav_1.4.3.bb
new file mode 100644
index 0000000..469ef28
--- /dev/null
+++ b/recipes-scanners/clamav/clamav_1.4.3.bb
@@ -0,0 +1,182 @@
+SUMMARY = "ClamAV anti-virus utilities and scanner tools"
+DESCRIPTION = "ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats."
+HOMEPAGE = "http://www.clamav.net/index.html"
+SECTION = "security"
+LICENSE = "GPL-2.0-only & LGPL-2.1-only & BSD-2-Clause & Zlib & Apache-2.0-with-LLVM-exception"
+LIC_FILES_CHKSUM = "file://COPYING.txt;md5=2c0b5770a62017a3121c69bb9f680b0c \
+                    file://COPYING/COPYING.LGPL;md5=2d5025d4aa3495befef8f17206a5b0a1 \
+                    file://COPYING/COPYING.bzip2;md5=ae8d555c34b656ff864ea9437a10d3a0 \
+                    file://COPYING/COPYING.zlib;md5=3648a0b9713ab246e11536055165a41a \
+                    file://COPYING/COPYING.llvm;md5=c82fc668ef1809acdd0684811df93bfc \
+                    file://COPYING/COPYING.unrar;md5=6a741ba21afc8b71aeaee3b5f86a8111 \
+                    file://COPYING/COPYING.file;md5=e63a61022c36cff2fdfbf02dd51674bd \
+                    file://COPYING/COPYING.curl;md5=be5d9e1419c4363f4b32037a2d3b7ffa \
+                    "
+
+DEPENDS = "glibc llvm libtool db openssl zlib curl libxml2 bison pcre2 json-c libcheck rust-native cargo-native libmspack"
+
+SRC_URI = "git://github.com/Cisco-Talos/clamav;branch=rel/1.4;protocol=https \
+           file://clamd.conf \
+           file://freshclam.conf \
+           file://volatiles.03_clamav \
+           file://tmpfiles.clamav \
+           "
+
+# ClamAV version 1.4.3
+SRCREV = "d8b053865fd5995f7af98bfbcd98c9a5644bfe2b"
+S = "${WORKDIR}/git"
+
+COMPATIBLE_HOST:libc-musl:class-target = "null"
+
+LEAD_SONAME = "libclamav.so"
+SO_VER = "12.0.0"
+BINCONFIG = "${bindir}/clamav-config"
+
+inherit cmake chrpath pkgconfig useradd systemd multilib_header multilib_script cargo_common
+
+
+UPSTREAM_CHECK_COMMITS = "1"
+
+CLAMAV_USER ?= "clamav"
+CLAMAV_GROUP ?= "clamav"
+
+PACKAGECONFIG ?= "clamonacc \
+                  ${@bb.utils.contains("DISTRO_FEATURES", "systemd", "systemd", "", d)}"
+PACKAGECONFIG[milter] = "-DENABLE_MILTER=ON ,-DENABLE_MILTER=OFF, curl, curl"
+PACKAGECONFIG[clamonacc] = "-DENABLE_CLAMONACC=ON ,-DENABLE_CLAMONACC=OFF,"
+PACKAGECONFIG[unrar] = "-DENABLE_UNRAR=ON ,-DENABLE_UNRAR=OFF,"
+PACKAGECONFIG[freshclamdnsfix] = "-DENABLE_FRESHCLAM_DNS_FIX=ON ,-DENABLE_FRESHCLAM_DNS_FIX=OFF,"
+PACKAGECONFIG[systemd] = "-DENABLE_SYSTEMD=ON -DSYSTEMD_UNIT_DIR=${systemd_system_unitdir}, -DENABLE_SYSTEMD=OFF, systemd"
+
+EXTRA_OECMAKE = "-DCMAKE_BUILD_TYPE=Release -DOPTIMIZE=ON -DENABLE_JSON_SHARED=OFF \
+                 -DCLAMAV_GROUP=${CLAMAV_GROUP} -DCLAMAV_USER=${CLAMAV_USER} \
+                 -DENABLE_TESTS=OFF -DBUILD_SHARED_LIBS=ON \
+                 -DDO_NOT_SET_RPATH=ON \
+                 -DCMAKE_INSTALL_PREFIX=${prefix} \
+                 -DCMAKE_INSTALL_SYSCONFDIR=${sysconfdir} \
+                 -DCMAKE_INSTALL_FULL_SYSCONFDIR=${sysconfdir} \
+                 -DSYSCONFDIR=${sysconfdir} \
+                 -DHAVE_SIGNED_RIGHT_SHIFT=1 \
+                 -DHAVE_UNAME_SYSCALL=1 \
+                 -DHAVE_FD_PASSING=1 \
+                 -Dtest_run_result=0 \
+                 -Dtest_run_result__TRYRUN_OUTPUT='' \
+                 -DCMAKE_C_FLAGS='${CFLAGS} -Wno-error=format-truncation -Wno-error=unused-function' \
+                 "
+
+MULTILIB_SCRIPTS = "${PN}-dev:${bindir}/clamav-config"
+
+do_install:append() {
+    install -d ${D}/${sysconfdir}
+    install -d ${D}/${localstatedir}/lib/clamav
+    install -d ${D}${sysconfdir}/clamav ${D}${sysconfdir}/default/volatiles
+
+    install -m 644 ${UNPACKDIR}/clamd.conf ${D}${sysconfdir}
+    install -m 644 ${UNPACKDIR}/freshclam.conf ${D}${sysconfdir}
+    install -m 0644 ${UNPACKDIR}/volatiles.03_clamav  ${D}${sysconfdir}/default/volatiles/03_clamav
+    
+    if [ -d ${D}${prefix}/etc ]; then
+        cp -r ${D}${prefix}/etc/* ${D}${sysconfdir}/ 2>/dev/null || true
+        rm -rf ${D}${prefix}/etc
+    fi
+    
+    sed -i -e 's#${STAGING_DIR_HOST}##g' ${D}${libdir}/pkgconfig/libclamav.pc
+    rm ${D}/${libdir}/libclamav.so
+    if [ "${INSTALL_CLAMAV_CVD}" = "1" ]; then
+        install -m 666 ${S}/clamav_db/* ${D}/${localstatedir}/lib/clamav/.
+    fi
+
+    rm ${D}/${libdir}/libfreshclam.so
+
+    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)};then
+        install -d ${D}${sysconfdir}/tmpfiles.d
+        install -m 0644 ${UNPACKDIR}/tmpfiles.clamav ${D}${sysconfdir}/tmpfiles.d/clamav.conf
+    fi
+    oe_multilib_header clamav-types.h
+}
+
+pkg_postinst:${PN} () {
+    if [ -z "$D" ]; then
+        if command -v systemd-tmpfiles >/dev/null; then
+            systemd-tmpfiles --create ${sysconfdir}/tmpfiles.d/clamav.conf
+        elif [ -e ${sysconfdir}/init.d/populate-volatile.sh ]; then
+            ${sysconfdir}/init.d/populate-volatile.sh update
+        fi
+    fi
+}
+
+PACKAGES += "${PN}-daemon ${PN}-clamdscan ${PN}-freshclam ${PN}-libclamav ${PN}-libclammspack"
+
+FILES:${PN} = "${bindir}/clambc ${bindir}/clamscan ${bindir}/clamsubmit ${sbindir}/clamonacc \
+               ${bindir}/*sigtool ${mandir}/man1/clambc* ${mandir}/man1/clamscan* \
+               ${mandir}/man1/sigtool* ${mandir}/man1/clambsubmit* \
+               ${docdir}/clamav/*"
+
+FILES:${PN}-clamdscan = "${bindir}/clamdscan \
+                         ${docdir}/clamdscan/* \
+                         ${mandir}/man1/clamdscan* \
+                         "
+
+FILES:${PN}-daemon = "${bindir}/clamconf ${bindir}/clamdtop ${sbindir}/clamd \
+                      ${mandir}/man1/clamconf* ${mandir}/man1/clamdtop* \
+                      ${mandir}/man5/clamd* ${mandir}/man8/clamd* \
+                      ${sysconfdir}/clamd.conf* \
+                      ${systemd_system_unitdir}/clamav-daemon/* \
+                      ${docdir}/clamav-daemon/* ${sysconfdir}/clamav-daemon \
+                      ${sysconfdir}/logcheck/ignore.d.server/clamav-daemon \
+                      ${systemd_system_unitdir}/clamav-daemon.service \
+                      ${systemd_system_unitdir}/clamav-clamonacc.service \
+                      "
+
+FILES:${PN}-freshclam = "${bindir}/freshclam \
+                         ${sysconfdir}/freshclam.conf* \
+                         ${sysconfdir}/clamav ${sysconfdir}/default/volatiles \
+                         ${sysconfdir}/tmpfiles.d/*.conf \
+                         ${localstatedir}/lib/clamav \
+                         ${docdir}/${PN}-freshclam ${mandir}/man1/freshclam.* \
+                         ${mandir}/man5/freshclam.conf.* \
+                         ${systemd_system_unitdir}/clamav-freshclam.service"
+
+FILES:${PN}-libclamav = "${libdir}/libclamav.so* \
+                         ${libdir}/libfreshclam.so* ${docdir}/libclamav/* \
+                         "
+
+FILES:${PN}-libclammspack = "${libdir}/libclammspack.so* \
+                             ${libdir}/libmspack.so* \
+                             "
+
+FILES:${PN}-dev = "${bindir}/clamav-config ${libdir}/*.la \
+                   ${libdir}/pkgconfig/*.pc \
+                   ${mandir}/man1/clamav-config.* \
+                   ${includedir}/*.h ${docdir}/libclamav*"
+
+FILES:${PN}-staticdev = "${libdir}/*.a"
+
+FILES:${PN}-doc = "${mandir}/man/* \
+                   ${datadir}/man/* \
+                   ${docdir}/* \
+                   "
+
+RDEPENDS:${PN} = "openssl ncurses-libncurses libxml2 libbz2 ncurses-libtinfo curl libpcre2 clamav-libclamav"
+RDEPENDS:${PN}-daemon = "clamav clamav-freshclam"
+RDEPENDS:${PN}-freshclam = "clamav"
+RDEPENDS:${PN}-libclamav = "clamav-libclammspack"
+
+RRECOMMENDS:${PN} = "clamav-freshclam"
+
+RPROVIDES:${PN} += "${PN}-systemd"
+RREPLACES:${PN} += "${PN}-systemd"  
+RCONFLICTS:${PN} += "${PN}-systemd"
+
+SYSTEMD_PACKAGES = "${PN}-daemon ${PN}-freshclam"
+SYSTEMD_SERVICE:${PN}-daemon = "clamav-daemon.service"
+SYSTEMD_SERVICE:${PN}-freshclam = "clamav-freshclam.service"
+
+USERADD_PACKAGES = "${PN}-freshclam"
+GROUPADD_PARAM:${PN}-freshclam = "--system ${CLAMAV_GROUP}"
+USERADD_PARAM:${PN}-freshclam = "--system -g ${CLAMAV_GROUP} --home-dir \
+                                 ${localstatedir}/lib/${BPN} \
+                                 --no-create-home --shell /sbin/nologin ${CLAMAV_USER}"
+
+INSANE_SKIP:${PN}-libclamav += "dev-so"
+INSANE_SKIP:${PN}-libclammspack += "dev-so"
diff --git a/recipes-scanners/clamav/files/tmpfiles.clamav b/recipes-scanners/clamav/files/tmpfiles.clamav
index fd5adfe..8e0849e 100644
--- a/recipes-scanners/clamav/files/tmpfiles.clamav
+++ b/recipes-scanners/clamav/files/tmpfiles.clamav
@@ -1,3 +1,4 @@
 #Type Path        Mode UID  GID  Age Argument
+d /var/lib/clamav 0755 clamav clamav -
 d /var/log/clamav 0755 clamav clamav -
 f /var/log/clamav/freshclam.log 0644 clamav clamav -
diff --git a/recipes-scanners/clamav/files/volatiles.03_clamav b/recipes-scanners/clamav/files/volatiles.03_clamav
index ee2153c..0561c4d 100644
--- a/recipes-scanners/clamav/files/volatiles.03_clamav
+++ b/recipes-scanners/clamav/files/volatiles.03_clamav
@@ -1,3 +1,4 @@
 # <type> <owner> <group> <mode> <path> <linksource>
+d clamav clamav 0755 /var/lib/clamav none
 d clamav clamav 0755 /var/log/clamav none
 f clamav clamav 0655 /var/log/clamav/freshclam.log none
-- 
2.43.0


