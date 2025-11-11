Return-Path: <hemant.jadhav@emerson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E49CCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 14:49:29 +0000 (UTC)
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19097.1762872561161204731
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Nov 2025 06:49:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@emerson.com header.s=email header.b=mb2cz6KL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: emerson.com, ip: 148.163.142.35, mailfrom: prvs=0410c5221f=hemant.jadhav@emerson.com)
Received: from pps.filterd (m0484884.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB7DbhJ027209
	for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 14:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=email; bh=NH0D
	RQd3cM9kXu9/bTfmhwCQ1EyOR2rnzTpwsXXcMvM=; b=mb2cz6KLfhMrN8l+/Gtj
	6sDOAUv2yump3I/8dPyTuaJv8HWY/sNLO0u2iHrU+sDmzhTanDvBzL91yPEsLl5c
	aqK5t4X0gNumQnmryQQSw/0CxpR95LCN+q01Mh7EtA2XJzdYPMCiNv6uNfjkx6YH
	C/z/nrykVbnyOPfF4df+WqWhD7oNIzaWWwFdqPEnMHP29jrOwS/bSVFp4GpTB0OV
	KmEjHR7nJ50rm6a9pBHqTDvKbVJAIwzGCFXyZsHM8Qv7QxXN4nGr+Pi0JzIVycQB
	SBw1KdceDEpa2TtJoVN8PL5xQexwwejfkEB076NWJcdk/ckjU9qe84qU6JemXahf
	3g==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 4abewkjsdd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 14:49:20 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 11 Nov 2025 08:49:18 -0600
Received: from hjadhav-Virtual-Machine.mshome.net (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 11 Nov 2025 08:49:18
 -0600
From: Hemant Jadhav <hemant.jadhav@emerson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Hemant Jadhav <hemant.jadhav@emerson.com>
Subject: [meta-security][PATCH v3 2/2] clamav: Remove obsolete 0.104.4 recipe and patches
Date: Tue, 11 Nov 2025 08:48:57 -0600
Message-ID: <20251111144857.80186-2-hemant.jadhav@emerson.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111144857.80186-1-hemant.jadhav@emerson.com>
References: <20251111144857.80186-1-hemant.jadhav@emerson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kq_jhs9b-hDLdF02oRrv0yMEaaxHnbg_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5NyBTYWx0ZWRfXwJ/OXF6IlLzc D0pPMa1QGGq1SoyV7VLbHnbnfd8ALYnsbJBEh3NHo3pNPkG5mDolCIig6wZuq4p5lj27Fl9W/ch kA1MZlYNNFIoAEWOaLvzOaI2QLJBKw5sKsnnLCOfe7Tpso4eBVpgT2GaGgiPGR/AV7LSUIS5GKb
 F6CKCjQitBl+m9tk4TCr9Lhd5CP9+2qLBTX3TvmdUajtpRGyonxnjZbGlxmUhXSu/FaL0Kre9yP cwWJQVhawEt2piTHwiZFYpW5jnSr1M1g9cr4aRiKrEbOeIkD3ZRMyPHpOtTiIt8TH87xCt7Kwv+ Qp2J4bDmhKaog6swpfgAHoAM61bo4DkbPX1Dx4amuOE1RQF/UsEffmmAJ9mkoUlN6efg51pHvTV
 lEbx+OBgX0J9gKFohxg1qTJSI4XlrQ==
X-Authority-Analysis: v=2.4 cv=SPVPlevH c=1 sm=1 tr=0 ts=69134cf0 cx=c_pps a=cVKeW2pxJVqlUTLH3Z+MUA==:117 a=cVKeW2pxJVqlUTLH3Z+MUA==:17 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=tPundid6AAAA:8 a=geDs06hvAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
 a=2UrD4va2YF_85ptEFQwA:9 a=aPicV9olnlo_TREvANR5:22 a=7yvi0DHx91fDKfvzWsLo:22
X-Proofpoint-GUID: kq_jhs9b-hDLdF02oRrv0yMEaaxHnbg_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2510240000 definitions=main-2511100097
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 14:49:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2486

Remove end-of-life ClamAV 0.104.4 recipe and associated patches as it
has been superseded by the 1.4.3 version with improved security and
modern build system support.

Signed-off-by: Hemant Jadhav <hemant.jadhav@emerson.com>
---
 recipes-scanners/clamav/clamav_0.104.4.bb     | 156 ------------------
 .../clamav/files/headers_fixup.patch          |  58 -------
 .../clamav/files/oe_cmake_fixup.patch         |  39 -----
 3 files changed, 253 deletions(-)
 delete mode 100644 recipes-scanners/clamav/clamav_0.104.4.bb
 delete mode 100644 recipes-scanners/clamav/files/headers_fixup.patch
 delete mode 100644 recipes-scanners/clamav/files/oe_cmake_fixup.patch

diff --git a/recipes-scanners/clamav/clamav_0.104.4.bb b/recipes-scanners/clamav/clamav_0.104.4.bb
deleted file mode 100644
index 7b81fd0..0000000
--- a/recipes-scanners/clamav/clamav_0.104.4.bb
+++ /dev/null
@@ -1,156 +0,0 @@
-SUMMARY = "ClamAV anti-virus utility for Unix - command-line interface"
-DESCRIPTION = "ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats."
-HOMEPAGE = "http://www.clamav.net/index.html"
-SECTION = "security"
-LICENSE = "LGPL-2.1-only"
-
-DEPENDS = "glibc llvm libtool db openssl zlib curl libxml2 bison pcre2 json-c libcheck"
- 
-COMPATIBLE_HOST:libc-musl:class-target = "null"
-
-LIC_FILES_CHKSUM = "file://COPYING.txt;beginline=2;endline=3;md5=f7029fbbc5898b273d5902896f7bbe17"
-
-# July 30th, 2022
-SRCREV = "563ba93052f3b7b46fb8725a65ee6299a9c332cf"
-
-SRC_URI = "git://github.com/Cisco-Talos/clamav;branch=rel/0.104;protocol=https \
-    file://clamd.conf \
-    file://freshclam.conf \
-    file://volatiles.03_clamav \
-    file://tmpfiles.clamav \
-    file://headers_fixup.patch \
-    file://oe_cmake_fixup.patch \
-"
-
-LEAD_SONAME = "libclamav.so"
-SO_VER = "9.6.0"
-
-BINCONFIG = "${bindir}/clamav-config"
-
-inherit cmake chrpath pkgconfig useradd systemd multilib_header multilib_script
-
-UPSTREAM_CHECK_COMMITS = "1"
-
-CLAMAV_UID ?= "clamav"
-CLAMAV_GID ?= "clamav"
-
-MULTILIB_SCRIPTS = "${PN}-dev:${bindir}/clamav-config"
-
-EXTRA_OECMAKE = " -DCMAKE_BUILD_TYPE=Release -DOPTIMIZE=ON -DENABLE_JSON_SHARED=OFF \
-                  -DCLAMAV_GROUP=${CLAMAV_GID} -DCLAMAV_USER=${CLAMAV_UID} \ 
-                  -DENABLE_TESTS=OFF -DBUILD_SHARED_LIBS=ON \
-                  -DDISABLE_MPOOL=ON -DENABLE_FRESHCLAM_DNS_FIX=ON \
-                   "
-
-PACKAGECONFIG ?= "  clamonacc \
-                 ${@bb.utils.contains("DISTRO_FEATURES", "systemd", "systemd", "", d)}"
-
-PACKAGECONFIG[milter] = "-DENABLE_MILTER=ON ,-DENABLE_MILTER=OFF, curl, curl"
-PACKAGECONFIG[clamonacc] = "-DENABLE_CLAMONACC=ON ,-DENABLE_CLAMONACC=OFF,"
-PACKAGECONFIG[unrar] = "-DENABLE_UNRAR=ON ,-DENABLE_UNRAR=OFF,"
-PACKAGECONFIG[systemd] = "-DENABLE_SYSTEMD=ON -DSYSTEMD_UNIT_DIR=${systemd_system_unitdir}, -DENABLE_SYSTEMD=OFF, systemd"
-
-export OECMAKE_C_FLAGS += " -I${STAGING_INCDIR} -L ${RECIPE_SYSROOT}${nonarch_libdir} -L${STAGING_LIBDIR} -lpthread" 
-
-do_install:append () {
-    install -d ${D}/${sysconfdir}
-    install -d -o ${PN} -g ${CLAMAV_GID} ${D}/${localstatedir}/lib/clamav
-    install -d ${D}${sysconfdir}/clamav ${D}${sysconfdir}/default/volatiles
-
-    install -m 644 ${UNPACKDIR}/clamd.conf ${D}/${prefix}/${sysconfdir}
-    install -m 644 ${UNPACKDIR}/freshclam.conf ${D}/${prefix}/${sysconfdir}
-    install -m 0644 ${UNPACKDIR}/volatiles.03_clamav  ${D}${sysconfdir}/default/volatiles/03_clamav
-    sed -i -e 's#${STAGING_DIR_HOST}##g' ${D}${libdir}/pkgconfig/libclamav.pc
-    rm ${D}/${libdir}/libclamav.so
-    if [ "${INSTALL_CLAMAV_CVD}" = "1" ]; then
-        install -m 666 ${S}/clamav_db/* ${D}/${localstatedir}/lib/clamav/.
-    fi
-
-    rm ${D}/${libdir}/libfreshclam.so
-
-    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)};then
-        install -d ${D}${sysconfdir}/tmpfiles.d
-        install -m 0644 ${UNPACKDIR}/tmpfiles.clamav ${D}${sysconfdir}/tmpfiles.d/clamav.conf
-    fi
-    oe_multilib_header clamav-types.h
-}
-
-pkg_postinst:${PN} () {
-    if [ -z "$D" ]; then
-        if command -v systemd-tmpfiles >/dev/null; then
-            systemd-tmpfiles --create ${sysconfdir}/tmpfiles.d/clamav.conf
-        elif [ -e ${sysconfdir}/init.d/populate-volatile.sh ]; then
-            ${sysconfdir}/init.d/populate-volatile.sh update
-        fi
-    fi
-}
-
-PACKAGES += "${PN}-daemon ${PN}-clamdscan ${PN}-freshclam ${PN}-libclamav"
-
-FILES:${PN} = "${bindir}/clambc ${bindir}/clamscan ${bindir}/clamsubmit ${sbindir}/clamonacc \
-                ${bindir}/*sigtool ${mandir}/man1/clambc* ${mandir}/man1/clamscan* \
-                ${mandir}/man1/sigtool* ${mandir}/man1/clambsubmit*  \
-                ${docdir}/clamav/*"
-
-FILES:${PN}-clamdscan = " ${bindir}/clamdscan \
-                        ${docdir}/clamdscan/* \
-                        ${mandir}/man1/clamdscan* \
-                        "
-
-FILES:${PN}-daemon = "${bindir}/clamconf ${bindir}/clamdtop ${sbindir}/clamd \
-                        ${mandir}/man1/clamconf* ${mandir}/man1/clamdtop* \
-                        ${mandir}/man5/clamd*  ${mandir}/man8/clamd* \
-                        ${sysconfdir}/clamd.conf* \
-                        /usr/etc/clamd.conf* \
-                        ${systemd_system_unitdir}/clamav-daemon/* \
-                        ${docdir}/clamav-daemon/*  ${sysconfdir}/clamav-daemon \
-                        ${sysconfdir}/logcheck/ignore.d.server/clamav-daemon \
-                        ${systemd_system_unitdir}/clamav-daemon.service \
-                        ${systemd_system_unitdir}/clamav-clamonacc.service \
-                        "
-
-FILES:${PN}-freshclam = "${bindir}/freshclam \
-                        ${sysconfdir}/freshclam.conf*  \
-                        /usr/etc/freshclam.conf*  \
-                        ${sysconfdir}/clamav ${sysconfdir}/default/volatiles \
-                        ${sysconfdir}/tmpfiles.d/*.conf \
-                        ${localstatedir}/lib/clamav \
-                        ${docdir}/${PN}-freshclam ${mandir}/man1/freshclam.* \
-                        ${mandir}/man5/freshclam.conf.* \
-                        ${systemd_system_unitdir}/clamav-freshclam.service"
-
-FILES:${PN}-dev = " ${bindir}/clamav-config ${libdir}/*.la \
-                    ${libdir}/pkgconfig/*.pc \
-                    ${mandir}/man1/clamav-config.* \
-                    ${includedir}/*.h ${docdir}/libclamav* \
-                    ${libdir}/libmspack.so"
-
-FILES:${PN}-staticdev = "${libdir}/*.a"
-
-FILES:${PN}-libclamav = "${libdir}/libclamav.so* ${libdir}/libclammspack.so* \
-                         ${libdir}/libfreshclam.so* ${docdir}/libclamav/* \
-                         ${libdir}/libmspack* "
-
-FILES:${PN}-doc = "${mandir}/man/* \
-                   ${datadir}/man/* \
-                   ${docdir}/* "
-
-USERADD_PACKAGES = "${PN}-freshclam "
-GROUPADD_PARAM:${PN}-freshclam = "--system ${CLAMAV_UID}"
-USERADD_PARAM:${PN}-freshclam = "--system -g ${CLAMAV_GID} --home-dir  \
-    ${localstatedir}/lib/${BPN} \
-    --no-create-home  --shell /sbin/nologin ${PN}"
-
-RPROVIDES:${PN} += "${PN}-systemd"
-RREPLACES:${PN} += "${PN}-systemd"
-RCONFLICTS:${PN} += "${PN}-systemd"
-SYSTEMD_PACKAGES  = "${PN}-daemon ${PN}-freshclam"
-SYSTEMD_SERVICE:${PN}-daemon = "clamav-daemon.service"
-SYSTEMD_SERVICE:${PN}-freshclam = "clamav-freshclam.service"
-
-INSANE_SKIP:${PN}-libclamav  += "dev-so"
-
-RDEPENDS:${PN} = "openssl ncurses-libncurses libxml2 libbz2 ncurses-libtinfo curl libpcre2 clamav-libclamav"
-RRECOMMENDS:${PN} = "clamav-freshclam"
-RDEPENDS:${PN}-freshclam = "clamav"
-RDEPENDS:${PN}-daemon = "clamav clamav-freshclam"
diff --git a/recipes-scanners/clamav/files/headers_fixup.patch b/recipes-scanners/clamav/files/headers_fixup.patch
deleted file mode 100644
index 369aa58..0000000
--- a/recipes-scanners/clamav/files/headers_fixup.patch
+++ /dev/null
@@ -1,58 +0,0 @@
-Fixes checks not needed do to glibc 2.33
-
-Upstream-Status: Pending
-Signed-off-by: Armin Kuster <akuster808@gmail.com>
-
-Index: git/CMakeLists.txt
-===================================================================
---- git.orig/CMakeLists.txt
-+++ git/CMakeLists.txt
-@@ -443,8 +443,6 @@ check_include_file("stdlib.h"
- check_include_file("string.h"           HAVE_STRING_H)
- check_include_file("strings.h"          HAVE_STRINGS_H)
- check_include_file("sys/cdefs.h"        HAVE_SYS_CDEFS_H)
--check_include_file("sys/dl.h"           HAVE_SYS_DL_H)
--check_include_file("sys/fileio.h"       HAVE_SYS_FILIO_H)
- check_include_file("sys/mman.h"         HAVE_SYS_MMAN_H)
- check_include_file("sys/param.h"        HAVE_SYS_PARAM_H)
- check_include_file("sys/queue.h"        HAVE_SYS_QUEUE_H)
-@@ -479,8 +477,6 @@ endif()
- 
- # int-types variants
- check_include_file("inttypes.h"         HAVE_INTTYPES_H)
--check_include_file("sys/inttypes.h"     HAVE_SYS_INTTYPES_H)
--check_include_file("sys/int_types.h"    HAVE_SYS_INT_TYPES_H)
- check_include_file("stdint.h"           HAVE_STDINT_H)
- 
- # this hack required to silence warnings on systems with inttypes.h
-@@ -608,17 +604,11 @@ check_type_size("time_t"  SIZEOF_TIME_T)
- # Checks for library functions.
- include(CheckSymbolExists)
- check_symbol_exists(_Exit           "stdlib.h"      HAVE__EXIT)
--check_symbol_exists(accept4         "sys/types.h"   HAVE_ACCEPT4)
- check_symbol_exists(snprintf        "stdio.h"       HAVE_SNPRINTF)
--check_symbol_exists(stat64          "sys/stat.h"    HAVE_STAT64)
--check_symbol_exists(strcasestr      "string.h"      HAVE_STRCASESTR)
- check_symbol_exists(strerror_r      "string.h"      HAVE_STRERROR_R)
--check_symbol_exists(strlcat         "string.h"      HAVE_STRLCAT)
--check_symbol_exists(strlcpy         "string.h"      HAVE_STRLCPY)
- check_symbol_exists(strndup         "string.h"      HAVE_STRNDUP)
- check_symbol_exists(strnlen         "string.h"      HAVE_STRNLEN)
--check_symbol_exists(strnstr         "string.h"      HAVE_STRNSTR)
--check_symbol_exists(sysctlbyname    "sysctl.h"      HAVE_SYSCTLBYNAME)
-+check_symbol_exists(strcasecmp      "string.h"      HAVE_STRNCMP)
- check_symbol_exists(timegm          "time.h"        HAVE_TIMEGM)
- check_symbol_exists(vsnprintf       "stdio.h"       HAVE_VSNPRINTF)
- 
-@@ -632,10 +622,9 @@ else()
-     check_symbol_exists(fseeko          "stdio.h"       HAVE_FSEEKO)
-     check_symbol_exists(getaddrinfo     "netdb.h"       HAVE_GETADDRINFO)
-     check_symbol_exists(getpagesize     "unistd.h"      HAVE_GETPAGESIZE)
--    check_symbol_exists(mkstemp         "unistd.h"      HAVE_MKSTEMP)
-     check_symbol_exists(poll            "poll.h"        HAVE_POLL)
--    check_symbol_exists(setgroups       "unistd.h"      HAVE_SETGROUPS)
-     check_symbol_exists(setsid          "unistd.h"      HAVE_SETSID)
-+    set(HAVE_SYSCONF_SC_PAGESIZE 1)
- endif()
- 
- include(CheckSymbolExists)
diff --git a/recipes-scanners/clamav/files/oe_cmake_fixup.patch b/recipes-scanners/clamav/files/oe_cmake_fixup.patch
deleted file mode 100644
index c9c88b9..0000000
--- a/recipes-scanners/clamav/files/oe_cmake_fixup.patch
+++ /dev/null
@@ -1,39 +0,0 @@
-Issue with rpath including /usr/lib and crosscompile checkes causing oe configure to fail
-
-Use oe's cmake rpath framework and exclude some of the cmake checks that fail in our env
-
-Upstream-Status: Inappropriate [configuration]
-Singed-off-by: Armin Kuster <akuster808@gmail.com>
-
-Index: git/CMakeLists.txt
-===================================================================
---- git.orig/CMakeLists.txt
-+++ git/CMakeLists.txt
-@@ -162,12 +162,6 @@ endif()
- 
- include(GNUInstallDirs)
- 
--if(CMAKE_INSTALL_FULL_LIBDIR)
--    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_FULL_LIBDIR}")
--else()
--    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
--endif()
--
- if(C_LINUX)
-     if(CMAKE_COMPILER_IS_GNUCXX)
-         # Set _GNU_SOURCE for O_LARGEFILE, O_CLOEXEC, O_DIRECTORY, O_NOFOLLOW, etc flags on older systems
-@@ -581,14 +575,8 @@ include(TestInline)
- include(CheckFileOffsetBits)
- # Determine how to pack structs on this platform.
- include(CheckStructPacking)
--# Check for signed right shift implementation.
--include(CheckSignedRightShift)
- # Check if systtem fts implementation available
- include(CheckFTS)
--# Check if uname(2) follows POSIX standard.
--include(CheckUnamePosix)
--# Check support for file descriptor passing
--include(CheckFDPassing)
- 
- # Check if big-endian
- include(TestBigEndian)
-- 
2.43.0


