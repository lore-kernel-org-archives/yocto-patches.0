Return-Path: <hemant.jadhav@emerson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AB5CCFA1A
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 04:06:41 +0000 (UTC)
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40271.1762747593571860094
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 09 Nov 2025 20:06:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@emerson.com header.s=email header.b=dhacMnm1;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: emerson.com, ip: 148.163.142.35, mailfrom: prvs=04098c52d2=hemant.jadhav@emerson.com)
Received: from pps.filterd (m0484884.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9KUOEg027040
	for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 04:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=email; bh=j/ugDxelKG7ZrOTUUIsSqCmtpX
	gWFAYFr93gvVeipJY=; b=dhacMnm1WeHI7tbWQO7M6q9LoAJdoZOGY0JV0sTJqK
	/qg0H2ePIAsRjeL42bHLvRyn1mXarnLbkFNqcmNfTs8/IPA5WcbwQARSaSDGcwZk
	2op4d29kODENBSncNNvNB2uh2PaS1ZDW6KP39qttM/5N+lxvQKg/Zm95WzwFIo5k
	YGXfLC7F+99+xlKzBGM68GW4BPCVn6EpwdXYJz42RbLJIV6D0npcjylJAhTwVhpE
	kbJLmieQLrJmW10PhFMBey5ilGtSfxLdiCbBfRQfqrd2FkNEHdLo9e6srJklQjTf
	wCp9VmCOBH/bnOPfhkAKjqDfJ6QcGcyYc69lvg7RCCwA==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 4aajh4bwb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 04:06:32 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 9 Nov 2025 22:06:31 -0600
Received: from hjadhav-Virtual-Machine.mshome.net (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Sun, 9 Nov 2025 22:06:31 -0600
From: Hemant Jadhav <hemant.jadhav@emerson.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH 1/2] clamav: Add ClamAV 1.4.3 recipe with enhanced security and Rust support
Date: Sun, 9 Nov 2025 22:06:30 -0600
Message-ID: <20251110040631.34843-1-hemant.jadhav@emerson.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TLdIilla c=1 sm=1 tr=0 ts=691164c8 cx=c_pps a=VUOoxcgKHUMpfFMIT0tLvw==:117 a=VUOoxcgKHUMpfFMIT0tLvw==:17 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=tPundid6AAAA:8 a=geDs06hvAAAA:8 a=NEAV23lmAAAA:8 a=kF9r1W5OH557fpoJvrAA:9
 a=aPicV9olnlo_TREvANR5:22 a=7yvi0DHx91fDKfvzWsLo:22
X-Proofpoint-ORIG-GUID: S_yWwdzDJ3H92O-DEZHf17IV7r9vmekc
X-Proofpoint-GUID: S_yWwdzDJ3H92O-DEZHf17IV7r9vmekc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDAyMiBTYWx0ZWRfXyhrkuD2NGmKQ 8QDEpJmHLwo6PMdDYkfWGO4rYOuj04NUlrk6UIw12qQS1TnLXP9gH6/dLkBgi+8stjUq5rMbOq1 3QMIrcK2Gh9mxg7n4IDXyz433jiBcAzbkaJUqtqrF3dU5KS1Vid/pG1alvBNxW1+Y/ln27HR8PZ
 39UaigJgB2SQoXFRsNcVO9ky7ALqRxtV3x++6716APO72GmWEZdbWDI0j9dzdQy1Em162v5ZAPS SNYo2HzSaNG5W1d9GfulAt4aYiulyh+iynfr5cKdFTSuolkhEaNSt0ce5gpc08vtLm7oKs8q4md YtZMLBX+Ks5MUMsqCvhFd8UZduzDB5jZgFe/aB8lSfzoWFzTTVZErQqShvf6LYeEtKq/DQjaZLk
 l3dE673YbW3DGBbzguxnHO/eX0EByA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511090022
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 04:06:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2466

Add modern ClamAV 1.4.3 recipe with comprehensive improvements over
the legacy 0.104.4 version.

Major changes in 1.4.3:
- Upgraded core engine with improved threat detection capabilities
- Added Rust components requiring cross-compilation support
- Updated CMake build system replacing legacy autotools
- Modernized library dependencies (LLVM, JSON-C, PCre2)
- Added comprehensive license compliance for multi-component package
- Enhanced cross-compilation support for all target architectures

The recipe includes dynamic Cargo configuration using Yocto variables
    to support cross-compilation to any target architecture supported by
    the build system, replacing hardcoded architecture assumptions.

- Implemented CMake cache variables for cross-compilation
- Updated all license checksums for compliance
- Added Rust toolchain integration with proper environment setup

Security rationale:
- ClamAV 0.104.4 reached end-of-life and is no longer maintained
- Upstream strongly recommends migration to 1.4.x for security updates

Signed-off-by: Hemant Jadhav <hemant.jadhav@emerson.com>
---
 recipes-scanners/clamav/clamav_1.4.3.bb       | 203 ++++++++++++++++++
 recipes-scanners/clamav/files/tmpfiles.clamav |   1 +
 .../clamav/files/volatiles.03_clamav          |   1 +
 3 files changed, 205 insertions(+)
 create mode 100644 recipes-scanners/clamav/clamav_1.4.3.bb

diff --git a/recipes-scanners/clamav/clamav_1.4.3.bb b/recipes-scanners/clamav/clamav_1.4.3.bb
new file mode 100644
index 0000000..a19eb41
--- /dev/null
+++ b/recipes-scanners/clamav/clamav_1.4.3.bb
@@ -0,0 +1,203 @@
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
+inherit cmake chrpath pkgconfig useradd systemd multilib_header multilib_script rust-common
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
+# Rust Cross-Compilation Configuration for Yocto
+export CARGO_TARGET_DIR = "${WORKDIR}/cargo_target"
+
+MULTILIB_SCRIPTS = "${PN}-dev:${bindir}/clamav-config"
+
+# Create Cargo configuration for cross-compilation
+do_configure:prepend() {
+    mkdir -p ${WORKDIR}/.cargo
+    
+    cat > ${WORKDIR}/.cargo/config.toml << EOF
+[build]
+target = "${RUST_TARGET_SYS}"
+
+[target.${RUST_TARGET_SYS}]
+linker = "${RUST_TARGET_CC}"
+
+[target.${RUST_BUILD_SYS}]
+linker = "${RUST_BUILD_CC}"
+EOF
+    
+    export CARGO_TARGET_DIR="${WORKDIR}/cargo_target"
+}
+
+do_install:append() {
+    install -d ${D}/${sysconfdir}
+    install -d ${D}/${localstatedir}/lib/clamav
+    install -d ${D}${sysconfdir}/clamav ${D}${sysconfdir}/default/volatiles
+
+    install -m 644 ${WORKDIR}/clamd.conf ${D}${sysconfdir}
+    install -m 644 ${WORKDIR}/freshclam.conf ${D}${sysconfdir}
+    install -m 0644 ${WORKDIR}/volatiles.03_clamav  ${D}${sysconfdir}/default/volatiles/03_clamav
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
+        install -m 0644 ${WORKDIR}/tmpfiles.clamav ${D}${sysconfdir}/tmpfiles.d/clamav.conf
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


