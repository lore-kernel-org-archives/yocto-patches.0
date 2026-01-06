Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9549CD0435
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 04:20:25 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83476.1767673220849173539
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Jan 2026 20:20:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=B7gpB3vu;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6063Q0vY3213732
	for <yocto-patches@lists.yoctoproject.org>; Tue, 6 Jan 2026 04:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1VG8H9W6dCeTPVhJLtKZx0CM/+O/dbZngh4
	qyVp6yRw=; b=B7gpB3vuj+vPiujwKyPs16hIBQeCAYU8m4CAUj2uSflj1jtfAB8
	JgAxdQqOF85jwL7mixUtLkbZ84+TYW1A/3gASfjXjzpzeyHQGwcei82XROOn5KuC
	iPrUVtgeigB9wbky10SP7P5rsFbxTbqPzTw/uMrhxg1rLNZWI5GIouSA/mll+9Ga
	/rDQMDqDcL9eAgw+ivbYZYyBKBNmVuE/akYUMmGkA9H2Iz1sMPxA47JCMFmvDHv1
	KNy0k6JImq+N4k/5FAF34Eq6OYaAXWx59UyTNoYnP2cq5OnA3MhCCUP0vrxz/I5f
	nVphnG5EBqQLWsoKdDJwV5yjPYpgpNPFDfA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgpnd8q4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 04:20:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 6064KFvs030587
	for <yocto-patches@lists.yoctoproject.org>; Tue, 6 Jan 2026 04:20:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4bev6m1nhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 04:20:15 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6064KF6s030579
	for <yocto-patches@lists.yoctoproject.org>; Tue, 6 Jan 2026 04:20:15 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com ([10.213.102.143])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6064KFDr030577
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 04:20:15 +0000
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4060212)
	id 60E5921CBF; Tue,  6 Jan 2026 09:50:14 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/V7] refpolicy: Add support to configure policy store root
Date: Tue,  6 Jan 2026 09:50:12 +0530
Message-ID: <20260106042012.1240290-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LQBIXlIyHC0qSh0_U1U9TrKADkRQks7C
X-Proofpoint-GUID: LQBIXlIyHC0qSh0_U1U9TrKADkRQks7C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAzMyBTYWx0ZWRfXzpoUc6gHbkie
 J/9AKXkwpAfaYMwXEWAGSg8tFgIKJOiADtAAYmSYFnGHA8/R+hcBGI28yT6nUMLoU9d+VnLurga
 EyuDPftyzligHhdDlpRsgoUh8prYKp2SJqVsAheqYvRvIrMaPBjj2ij8vt6SIgWg1S4O5QtES+u
 2GFJLPaoFw7u+yzhc9gzP8BKcfYTtDOTAQ+vSC0bGxTRaGNXyJeKM62cr5T3w3o98/YSrg3UHpY
 jLTFlL8tvuX3fVpoqls3MQau/yyDChFnnM7X3pNXGviC1niOrjEv9dwI1L2rP5iwmJmYnn2Rhxc
 O3sbk5KqhHV7RZ/yPz9t4VLKZv6FZVGP5/ImE8rr0YUnJ710mkMenAHy3/I94pxTn8xjEwL0tL9
 S3sjEC264Kq4jgeUVtp+NKRN0EFB3JmOciv4lhnbha++snjeaRDjQmtZj5PPquTn+fgVhu6cuIr
 0NdAwBcTz5I0PYtlxgg==
X-Authority-Analysis: v=2.4 cv=Jpz8bc4C c=1 sm=1 tr=0 ts=695c8d83 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=I8g-lVKgVl53kmlvlZgA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060033
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 04:20:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2900

By default, policy modules(*.pp) are stored in /var directory.
Features like: ostree remove files in folders like /var
variable data directory while build time.

Added support for custom policy store. We can now configure
path to custom policy store to variable `POLICY_STORE_ROOT`.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 .../refpolicy/refpolicy-minimum_git.bb        |  2 +-
 .../refpolicy/refpolicy_common.inc            |  9 ++++++---
 recipes-security/selinux/libsemanage_3.9.bb   | 20 ++++++++++++++++---
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy-minimum_git.bb b/recipes-security/refpolicy/refpolicy-minimum_git.bb
index 5a0ed6f..011c153 100644
--- a/recipes-security/refpolicy/refpolicy-minimum_git.bb
+++ b/recipes-security/refpolicy/refpolicy-minimum_git.bb
@@ -67,7 +67,7 @@ prepare_policy_store() {
     oe_runmake 'DESTDIR=${D}' 'prefix=${D}${prefix}' install
     POL_PRIORITY=100
     POL_SRC=${D}${datadir}/selinux/${POLICY_NAME}
-    POL_STORE=${D}${localstatedir}/lib/selinux/${POLICY_NAME}
+    POL_STORE=${D}${POLICY_STORE_ROOT}/${POLICY_NAME}
     POL_ACTIVE_MODS=${POL_STORE}/active/modules/${POL_PRIORITY}
 
     # Prepare to create policy store
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 964906b..59dfecd 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -77,10 +77,12 @@ SRC_URI += " \
 S = "${UNPACKDIR}/refpolicy"
 
 CONFFILES:${PN} = "${sysconfdir}/selinux/config"
+
+POLICY_STORE_ROOT ?= "${localstatedir}/lib/selinux"
 FILES:${PN} += " \
     ${sysconfdir}/selinux/${POLICY_NAME}/ \
     ${datadir}/selinux/${POLICY_NAME}/*.pp \
-    ${localstatedir}/lib/selinux/${POLICY_NAME}/ \
+    ${POLICY_STORE_ROOT}/${POLICY_NAME}/ \
     "
 FILES:${PN}-dev =+ " \
     ${datadir}/selinux/${POLICY_NAME}/include/ \
@@ -165,7 +167,7 @@ prepare_policy_store() {
     oe_runmake 'DESTDIR=${D}' 'prefix=${D}${prefix}' install
     POL_PRIORITY=100
     POL_SRC=${D}${datadir}/selinux/${POLICY_NAME}
-    POL_STORE=${D}${localstatedir}/lib/selinux/${POLICY_NAME}
+    POL_STORE=${D}${POLICY_STORE_ROOT}/${POLICY_NAME}
     POL_ACTIVE_MODS=${POL_STORE}/active/modules/${POL_PRIORITY}
 
     # Prepare to create policy store
@@ -207,13 +209,14 @@ args = \$@
 [end]
 
 policy-version = 35
+store-root = "${POLICY_STORE_ROOT}"
 EOF
 
     # Create policy store and build the policy
     semodule -p ${D} -s ${POLICY_NAME} -n -B
     rm -f ${D}${sysconfdir}/selinux/semanage.conf
     # No need to leave final dir created by semanage laying around
-    rm -rf ${D}${localstatedir}/lib/selinux/final
+    rm -rf ${D}${POLICY_STORE_ROOT}/final
 }
 
 install_misc_files() {
diff --git a/recipes-security/selinux/libsemanage_3.9.bb b/recipes-security/selinux/libsemanage_3.9.bb
index 2425a2e..1279cce 100644
--- a/recipes-security/selinux/libsemanage_3.9.bb
+++ b/recipes-security/selinux/libsemanage_3.9.bb
@@ -32,6 +32,8 @@ FILES:${PN}-python = "${PYTHON_SITEPACKAGES_DIR}/* \
 FILES:${PN}-dbg += "${PYTHON_SITEPACKAGES_DIR}/.debug/*"
 FILES:${PN} += "${libexecdir}"
 
+POLICY_STORE_ROOT ?= "${localstatedir}/lib/selinux"
+
 do_compile:append() {
     oe_runmake pywrap \
         PYLIBVER='python${PYTHON_BASEVERSION}' \
@@ -46,9 +48,21 @@ do_install:append() {
         PYLIBVER='python${PYTHON_BASEVERSION}' \
         PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}'
 
-    # Update "policy-version" for semanage.conf
-    sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 35/' \
-        ${D}/etc/selinux/semanage.conf
+    conf_file="${D}/etc/selinux/semanage.conf"
+
+    if [ -f "${conf_file}" ]; then
+        # Update "policy-version" for semanage.conf
+        sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 35/' \
+            ${D}/etc/selinux/semanage.conf
+
+        # Update "store-root" for semanage.conf
+        if grep -q '^store-root=' "${conf_file}"; then
+            sed -i "s|^store-root=.*$|store-root=${POLICY_STORE_ROOT}|" "${conf_file}"
+        else
+            printf 'store-root=%s\n' "${POLICY_STORE_ROOT}" >> "${conf_file}"
+        fi
+    fi
+
 }
 
 BBCLASSEXTEND = "native"
-- 
2.43.0


