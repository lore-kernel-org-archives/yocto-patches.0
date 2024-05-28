Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C073CC25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 06:36:00 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.15915.1716878156582620259
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 23:35:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5878445e50=changqing.li@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44S4T3mO007649
	for <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 06:35:55 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yb6y5jm15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 06:35:55 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 23:35:54 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 23:35:53 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-selinux][PATCH] recipes: WORKDIR -> UNPACKDIR transition
Date: Tue, 28 May 2024 14:35:53 +0800
Message-ID: <20240528063553.1985348-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: x0sE6HteTR2Xa5bEY5B3W_tchAFh6tKp
X-Proofpoint-GUID: x0sE6HteTR2Xa5bEY5B3W_tchAFh6tKp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_03,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=986 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405280047
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 06:36:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/234

From: Changqing Li <changqing.li@windriver.com>

* WORKDIR -> UNPACKDIR transition
* Switch away from S = WORKDIR

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-security/refpolicy/refpolicy_common.inc     |  6 +++---
 recipes-security/selinux-scripts/selinux-initsh.inc | 12 +++++++-----
 recipes-security/selinux/policycoreutils_3.6.bb     |  4 ++--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 6ea1fc2..000fb3c 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -214,12 +214,12 @@ EOF
 }
 
 install_misc_files() {
-    cat ${WORKDIR}/customizable_types >> \
+    cat ${UNPACKDIR}/customizable_types >> \
         ${D}${sysconfdir}/selinux/${POLICY_NAME}/contexts/customizable_types
 
     # Install setrans.conf for mls/mcs policy
-    if [ -f ${WORKDIR}/setrans-${POLICY_TYPE}.conf ]; then
-        install -m 0644 ${WORKDIR}/setrans-${POLICY_TYPE}.conf \
+    if [ -f ${UNPACKDIR}/setrans-${POLICY_TYPE}.conf ]; then
+        install -m 0644 ${UNPACKDIR}/setrans-${POLICY_TYPE}.conf \
             ${D}${sysconfdir}/selinux/${POLICY_NAME}/setrans.conf
     fi
 
diff --git a/recipes-security/selinux-scripts/selinux-initsh.inc b/recipes-security/selinux-scripts/selinux-initsh.inc
index f6a3d85..efe7e88 100644
--- a/recipes-security/selinux-scripts/selinux-initsh.inc
+++ b/recipes-security/selinux-scripts/selinux-initsh.inc
@@ -1,4 +1,6 @@
-S ?= "${WORKDIR}"
+S ?= "${WORKDIR}/sources"
+UNPACKDIR = "${S}"
+
 SECTION ?= "base"
 
 # Default is for script name to be the same as the recipe name.
@@ -21,17 +23,17 @@ FILES:${PN} += "/.autorelabel"
 
 do_install () {
 	install -d ${D}${sysconfdir}/init.d/
-	install -m 0755 ${WORKDIR}/${SELINUX_SCRIPT_SRC}.sh ${D}${sysconfdir}/init.d/${SELINUX_SCRIPT_DST}
+	install -m 0755 ${S}/${SELINUX_SCRIPT_SRC}.sh ${D}${sysconfdir}/init.d/${SELINUX_SCRIPT_DST}
 	# Insert the relabelling code which is only needed with sysvinit
-	sed -i -e '/HERE/r ${WORKDIR}/${SELINUX_SCRIPT_SRC}.sh.sysvinit' \
+	sed -i -e '/HERE/r ${S}/${SELINUX_SCRIPT_SRC}.sh.sysvinit' \
 	       -e '/.*HERE$/d' -e '/.*Contents.*sysvinit/d' \
 	       ${D}${sysconfdir}/init.d/${SELINUX_SCRIPT_DST}
 
     if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
         install -d ${D}${systemd_unitdir}/system
-        install -m 0644 ${WORKDIR}/${SELINUX_SCRIPT_SRC}.service ${D}${systemd_unitdir}/system
+        install -m 0644 ${S}/${SELINUX_SCRIPT_SRC}.service ${D}${systemd_unitdir}/system
         install -d ${D}${bindir}
-        install -m 0755 ${WORKDIR}/${SELINUX_SCRIPT_SRC}.sh ${D}${bindir}
+        install -m 0755 ${S}/${SELINUX_SCRIPT_SRC}.sh ${D}${bindir}
         sed -i -e '/.*HERE$/d' ${D}${bindir}/${SELINUX_SCRIPT_SRC}.sh
     fi
 }
diff --git a/recipes-security/selinux/policycoreutils_3.6.bb b/recipes-security/selinux/policycoreutils_3.6.bb
index c106ee7..2871de0 100644
--- a/recipes-security/selinux/policycoreutils_3.6.bb
+++ b/recipes-security/selinux/policycoreutils_3.6.bb
@@ -166,9 +166,9 @@ do_install:class-native() {
 }
 
 do_install:append:class-target() {
-    if [ -e ${WORKDIR}/pam.d ]; then
+    if [ -e ${UNPACKDIR}/pam.d ]; then
         install -d ${D}${sysconfdir}/pam.d/
-        install -m 0644 ${WORKDIR}/pam.d/* ${D}${sysconfdir}/pam.d/
+        install -m 0644 ${UNPACKDIR}/pam.d/* ${D}${sysconfdir}/pam.d/
     fi
 
     # /var/lib/selinux is involved by seobject.py:
-- 
2.25.1


