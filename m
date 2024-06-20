Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2674EC27C53
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 03:13:28 +0000 (UTC)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
 by mx.groups.io with SMTP id smtpd.web10.39243.1718853197479017263
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Jun 2024 20:13:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=ORIeFEW5;
 spf=pass (domain: fujitsu.com, ip: 139.138.36.223, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718853197; x=1750389197;
  h=from:to:cc:subject:date:message-id;
  bh=FkDv3kLe8S5jYq86U6AB7z9xjqD81bjpqourc/U6mdQ=;
  b=ORIeFEW5LHzQ2YiTrmh7of6wCtCt0+sTZMgnxdhsxgWyHoGuKUmiJmwz
   +qop+L1KUtXpy1zrzr/w2/bFLvCgoQsJYpCOTdUPfQ23ZgG0X0nDwV/Tj
   IC+70BKI9m0OrMb5pWN+Aso+SKVdelddTh+AVSPJzkznPRZUlCdZFfHUB
   t9+ksJrfB4sY7eRC5QlrkilrHZF9TeYlIjmI5apmv/ih+ByCqna08wqQy
   wTr2EvWR4iF4SZF5GRbpQaKi2IgKynMmwc8dqJWndPXYt49sNKWdvr/ur
   V/G+e/XUWk9R6u/B7Md6ASpPixxfR5e/Iv+HBT33NNMx+D+3XYD917mpY
   A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="152614263"
X-IronPort-AV: E=Sophos;i="6.08,251,1712588400"; 
   d="scan'208";a="152614263"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 12:13:14 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 240F6CA27F
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Jun 2024 12:13:12 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 60CC0BDC98
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Jun 2024 12:13:11 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D347AE2B25
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Jun 2024 12:13:10 +0900 (JST)
Received: from vm4860.g01.fujitsu.local (unknown [10.193.128.200])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 2B74C1A0002;
	Thu, 20 Jun 2024 11:13:10 +0800 (CST)
From: wangmy@fujitsu.com
To: yocto-patches@lists.yoctoproject.org
Cc: Wang Mingyu <wangmy@fujitsu.com>
Subject: [oe] [meta-java] [PATCH] recipes: Start WORKDIR -> UNPACKDIR transition
Date: Thu, 20 Jun 2024 11:12:54 +0800
Message-Id: <1718853174-32301-1-git-send-email-wangmy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28464.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28464.004
X-TMASE-Result: 10--11.187300-10.000000
X-TMASE-MatchedRID: t3rvxuFr4chAJjQFQUSfYfLeH1FBnhK0CZa9cSpBObnAuQ0xDMaXkH4q
	tYI9sRE/VA2jMht1uVzvBBHhCihMri5AMgfDcBcMs0T0PE+KHuVoF4uAn4kYJ1CedixYXzOrY87
	NwWBxSvjMsgcjNXJTZIK0hPmT524+5VtV90uxxtfPmvnL2ai5IKqqvWsAC6cQeGHkpR2WBaJRdU
	hI1NLdtONJFL7Gc6BHntw3k1sjPaeel3N+gDvB5+9VsdrlGzy3xMZq+YajS9b7s8CQBJM67pegO
	xWL1ibsSQGPZ9M/BiOAMuqetGVetiKODC+qnmrBFpbjU3dJHnX6C0ePs7A07fyjtizU0rhj7GZH
	qbd8/0LRmlQucheeDmKcFNibNE1k1SBXGo5R6wo=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Jun 2024 03:13:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/359

From: Wang Mingyu <wangmy@fujitsu.com>

Replace references of WORKDIR with UNPACKDIR where it makes sense to do so in preparation for changing the default value of UNPACKDIR.

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
---
 recipes-core/ant/ant-native_1.8.1.bb                  | 4 ++--
 recipes-core/antlr/antlr_2.7.7.bb                     | 4 ++--
 recipes-core/cup/cup_0.10k.bb                         | 6 +++---
 recipes-core/ecj/ecj-bootstrap-native.bb              | 2 +-
 recipes-core/ecj/ecj-initial-native.bb                | 2 +-
 recipes-core/ecj/libecj-bootstrap.inc                 | 2 +-
 recipes-core/icedtea/icedtea7-native.inc              | 8 ++++----
 recipes-core/jakarta-libs/avalon-framework-api_4.3.bb | 2 +-
 recipes-core/jikes/jikes-initial-native.bb            | 2 +-
 recipes-core/jlex/jlex_1.2.6.bb                       | 4 ++--
 recipes-core/junit/junit4_4.3.1.bb                    | 2 +-
 recipes-core/rhino/rhino_1.7r4.bb                     | 4 ++--
 12 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/recipes-core/ant/ant-native_1.8.1.bb b/recipes-core/ant/ant-native_1.8.1.bb
index 8814039..d44e663 100644
--- a/recipes-core/ant/ant-native_1.8.1.bb
+++ b/recipes-core/ant/ant-native_1.8.1.bb
@@ -54,12 +54,12 @@ do_compile() {
 
   oe_makeclasspath cp -s ecj-bootstrap jsch bsf xalan2 xercesImpl resolver gnumail gnujaf bcel regexp log4j1.2 antlr oro junit jdepend commons-net commons-logging
   cp=${STAGING_DATADIR_JAVA_NATIVE}/ant.jar:${STAGING_DATADIR}/classpath/tools.zip:$cp
-  sed -i -e"s|@JAR_FILE@|$cp|" ${WORKDIR}/ant
+  sed -i -e"s|@JAR_FILE@|$cp|" ${UNPACKDIR}/ant
 }
 
 do_install:append() {
 	install -d ${D}${bindir}
-	install -m 0755 ${WORKDIR}/ant ${D}${bindir}
+	install -m 0755 ${UNPACKDIR}/ant ${D}${bindir}
 }
 
 SRC_URI[md5sum] = "9e5960bd586d9425c46199cdd20a6fbc"
diff --git a/recipes-core/antlr/antlr_2.7.7.bb b/recipes-core/antlr/antlr_2.7.7.bb
index d744201..c585ca4 100644
--- a/recipes-core/antlr/antlr_2.7.7.bb
+++ b/recipes-core/antlr/antlr_2.7.7.bb
@@ -10,7 +10,7 @@ SRC_URI:append:class-native = " file://runantlr"
 inherit java-library
 
 do_configure:class-native() {
-    sed -i -e"s|@JAR_FILE@|${STAGING_DATADIR_JAVA_NATIVE}/antlr.jar|" ${WORKDIR}/runantlr
+    sed -i -e"s|@JAR_FILE@|${STAGING_DATADIR_JAVA_NATIVE}/antlr.jar|" ${UNPACKDIR}/runantlr
 }
 
 do_compile() {
@@ -23,7 +23,7 @@ do_compile() {
 
 do_install:class-native() {
     install -d ${D}${bindir}
-    install -m 0755 ${WORKDIR}/runantlr ${D}${bindir}/
+    install -m 0755 ${UNPACKDIR}/runantlr ${D}${bindir}/
 }
 
 SRC_URI[md5sum] = "01cc9a2a454dd33dcd8c856ec89af090"
diff --git a/recipes-core/cup/cup_0.10k.bb b/recipes-core/cup/cup_0.10k.bb
index ce81453..ac69ff4 100644
--- a/recipes-core/cup/cup_0.10k.bb
+++ b/recipes-core/cup/cup_0.10k.bb
@@ -1,7 +1,7 @@
 SUMMARY = "Lexical analyzer generator for Java"
 AUTHOR = "Elliot Berk, A. Appel, C. Scott Ananian"
 LICENSE = "CUP"
-LIC_FILES_CHKSUM = "file://${WORKDIR}/LICENSE;md5=2c9db91c00f38e52cfc8e67bafaa7c33"
+LIC_FILES_CHKSUM = "file://${UNPACKDIR}/LICENSE;md5=2c9db91c00f38e52cfc8e67bafaa7c33"
 
 
 RDEPENDS:${PN} = "java2-runtime"
@@ -21,7 +21,7 @@ do_configure() {
 		-e "s|OE_STAGING_BINDIR|${bindir}|" \
 		-e "s|OE_STAGING_DATADIR_JAVA|${data_java}|" \
 		-e "s|OE_CUP_JAR|${BP}.jar|" \
-		${WORKDIR}/cup
+		${UNPACKDIR}/cup
 }
 
 do_compile() {
@@ -34,7 +34,7 @@ do_compile() {
 
 do_install:append() {
 	install -d ${D}${bindir}
-	install -m 0755 ${WORKDIR}/cup ${D}${bindir}
+	install -m 0755 ${UNPACKDIR}/cup ${D}${bindir}
 }
 
 PACKAGES = "${PN}"
diff --git a/recipes-core/ecj/ecj-bootstrap-native.bb b/recipes-core/ecj/ecj-bootstrap-native.bb
index 874bd99..bf229ca 100644
--- a/recipes-core/ecj/ecj-bootstrap-native.bb
+++ b/recipes-core/ecj/ecj-bootstrap-native.bb
@@ -18,7 +18,7 @@ PROVIDES = "virtual/javac-native"
 
 SRC_URI = "file://ecj.in"
 
-S = "${WORKDIR}"
+S = "${UNPACKDIR}"
 
 JAR = "ecj-bootstrap.jar"
 
diff --git a/recipes-core/ecj/ecj-initial-native.bb b/recipes-core/ecj/ecj-initial-native.bb
index d75b7a0..115f4a0 100644
--- a/recipes-core/ecj/ecj-initial-native.bb
+++ b/recipes-core/ecj/ecj-initial-native.bb
@@ -12,7 +12,7 @@ DEPENDS = "libecj-bootstrap-native"
 
 SRC_URI = "file://ecj-initial.in"
 
-S = "${WORKDIR}"
+S = "${UNPACKDIR}"
 
 inherit native
 
diff --git a/recipes-core/ecj/libecj-bootstrap.inc b/recipes-core/ecj/libecj-bootstrap.inc
index 2f3cc97..25edbad 100644
--- a/recipes-core/ecj/libecj-bootstrap.inc
+++ b/recipes-core/ecj/libecj-bootstrap.inc
@@ -11,7 +11,7 @@ INC_PR = "r5"
 
 inherit java native
 
-S = "${WORKDIR}"
+S = "${UNPACKDIR}"
 
 JAR = "ecj-bootstrap-${PV}.jar"
 
diff --git a/recipes-core/icedtea/icedtea7-native.inc b/recipes-core/icedtea/icedtea7-native.inc
index d6f8fd7..8bd404f 100644
--- a/recipes-core/icedtea/icedtea7-native.inc
+++ b/recipes-core/icedtea/icedtea7-native.inc
@@ -105,7 +105,7 @@ do_configure:prepend() {
 
 	# Automatically copy everything that starts with "icedtea" and ends with
 	# ".patch" into the patches directory.
-	find ${WORKDIR} -maxdepth 1 -name "icedtea*.patch" -exec cp {} ${S}/patches \;
+	find ${UNPACKDIR} -maxdepth 1 -name "icedtea*.patch" -exec cp {} ${S}/patches \;
 
 	# Prepare JDK-like directory with Classpath' files which we can treat as a
 	# SYSTEM_GCJ_DIR afterwards.
@@ -154,9 +154,9 @@ do_configure:append() {
 	${POST_CONFIGURE_CLEAN_X11}
 	oe_runmake patch-boot
 
-	patch -p1 < ${WORKDIR}/jaxws_fix_NullPointerException.patch
-	patch -p1 < ${WORKDIR}/sigsegv.patch
-	patch -p1 < ${WORKDIR}/vframeArray_Fix_sigsegv.patch
+	patch -p1 < ${UNPACKDIR}/jaxws_fix_NullPointerException.patch
+	patch -p1 < ${UNPACKDIR}/sigsegv.patch
+	patch -p1 < ${UNPACKDIR}/vframeArray_Fix_sigsegv.patch
 }
 
 EXTRA_OEMAKE = ' \
diff --git a/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb b/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb
index 081cfe7..b03251f 100644
--- a/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb
+++ b/recipes-core/jakarta-libs/avalon-framework-api_4.3.bb
@@ -15,7 +15,7 @@ do_compile() {
   mkdir -p build
 
 	#	Allow reaching method definitions from logkit (stupid cyclic dependency).
-	srcpath=src/java:${WORKDIR}/logkit-1.2.2-dev/src/java
+	srcpath=src/java:${UNPACKDIR}/logkit-1.2.2-dev/src/java
 
   javac -encoding ISO-8859-1 -sourcepath $srcpath -d build `find src/java -name "*.java"`
 
diff --git a/recipes-core/jikes/jikes-initial-native.bb b/recipes-core/jikes/jikes-initial-native.bb
index 063525d..e9f5819 100644
--- a/recipes-core/jikes/jikes-initial-native.bb
+++ b/recipes-core/jikes/jikes-initial-native.bb
@@ -3,7 +3,7 @@ LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
 DEPENDS = "jikes-native classpath-initial-native"
 
-S = "${WORKDIR}"
+S = "${UNPACKDIR}"
 
 inherit native
 
diff --git a/recipes-core/jlex/jlex_1.2.6.bb b/recipes-core/jlex/jlex_1.2.6.bb
index 48ec357..8b2f14c 100644
--- a/recipes-core/jlex/jlex_1.2.6.bb
+++ b/recipes-core/jlex/jlex_1.2.6.bb
@@ -16,14 +16,14 @@ SRC_URI = "http://www.cs.princeton.edu/~appel/modern/java/JLex/Archive/${PV}/Mai
            file://jlex \
           "
 
-S = "${WORKDIR}"
+S = "${UNPACKDIR}"
 
 do_configure() {
   sed -i \
     -e "s|OE_STAGING_BINDIR|${bindir}|" \
     -e "s|OE_STAGING_DATADIR_JAVA|${datadir_java}|" \
     -e "s|OE_JLEX_JAR|${BP}.jar|" \
-    ${WORKDIR}/jlex
+    ${UNPACKDIR}/jlex
 }
 
 do_compile() {
diff --git a/recipes-core/junit/junit4_4.3.1.bb b/recipes-core/junit/junit4_4.3.1.bb
index b2cd4d9..97e8f1b 100644
--- a/recipes-core/junit/junit4_4.3.1.bb
+++ b/recipes-core/junit/junit4_4.3.1.bb
@@ -6,7 +6,7 @@ HOMEPAGE = "http://www.junit.org"
 
 SRC_URI = "http://downloads.sourceforge.net/junit/junit-${PV}-src.jar"
 
-S = "${WORKDIR}"
+S = "${UNPACKDIR}"
 
 inherit java-library
 
diff --git a/recipes-core/rhino/rhino_1.7r4.bb b/recipes-core/rhino/rhino_1.7r4.bb
index d645e8a..30b228d 100644
--- a/recipes-core/rhino/rhino_1.7r4.bb
+++ b/recipes-core/rhino/rhino_1.7r4.bb
@@ -43,6 +43,6 @@ do_compile() {
 do_install:append() {
 	install -d ${D}${bindir}
 
-	install -m 0755 ${WORKDIR}/rhino ${D}${bindir}
-	install -m 0755 ${WORKDIR}/rhino-jsc ${D}${bindir}
+	install -m 0755 ${UNPACKDIR}/rhino ${D}${bindir}
+	install -m 0755 ${UNPACKDIR}/rhino-jsc ${D}${bindir}
 }
-- 
2.34.1


