Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC14E66886
	for <webhook@archiver.kernel.org>; Sun, 21 Dec 2025 04:04:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.54095.1766289852349193831
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 20 Dec 2025 20:04:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=maAyPfPB;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BKKuqqi1043346
	for <yocto-patches@lists.yoctoproject.org>; Sun, 21 Dec 2025 04:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9JuSg8iAaJGYQS8CUnuwClh+WkW3z6j0VEs
	m/7MY950=; b=maAyPfPBWcqIo9dIz6MPPILj9pa2WpnWbfRlosr8GVGWOD/SKke
	u267gvfr0XPQi262VjqNXAzzZYtkkpz2bV/i204rAuUrbC1batVPoGENjqSzyq2Z
	6+gNZ6I6ongayWGKXNpAoQ14g9UmCio+hMkOMja66VO7F3rvmN++xujeqOUDVbPr
	s+8q1dKNFLyQQvbWxVLvUYDXEIZLB5VEeESTcz+kX7MEIXjonjGFcG7WTnxIIxSU
	3xFifhAvjX8B/FRziNXiF23vEfYUzbHNR3MaoJr/cn1G+7v1Qf2C30i3KICHIvOW
	lyMkaZMGrrhK5bwpGvZNogonv9ijS0lEkbQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mux1qjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 21 Dec 2025 04:04:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BL3xuBP006817
	for <yocto-patches@lists.yoctoproject.org>; Sun, 21 Dec 2025 04:04:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4b5mvkrfbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 21 Dec 2025 04:04:07 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BL4479Y011120
	for <yocto-patches@lists.yoctoproject.org>; Sun, 21 Dec 2025 04:04:07 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com ([10.213.102.143])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5BL447BP011118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Dec 2025 04:04:07 +0000
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4060212)
	id 93A5821D15; Sun, 21 Dec 2025 09:34:06 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/V5] refpolicy: Add support to configure policy store root
Date: Sun, 21 Dec 2025 09:34:04 +0530
Message-ID: <20251221040404.845441-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CqRCDgOwBKbSJIwndrppITAVhU3cx59g
X-Authority-Analysis: v=2.4 cv=EvnfbCcA c=1 sm=1 tr=0 ts=694771bb cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=oCwQqg7PNz2VNpKvC5cA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: CqRCDgOwBKbSJIwndrppITAVhU3cx59g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDAzMyBTYWx0ZWRfX7lTABUUvW0Gl
 6DXz9dv3MmR7ABFjwM1kXbgHzI/vj1mFUdOdHU5+P69Q7QzjRtXBQvK7GMtNSPMsbdzptqq8qDF
 jqYrpxLwSeE0u97QMK0rMRYQNpFrlSBBFVGLLcKCupWNTj8cKOxLFkJVw/XgWmVijHrG3ZdRVVT
 irJoOTGCFALonSt6MKvuuf81cFcHVVSZvFkNQy4TjDlq3bpyMq3bBklYZlsFI43G27y/xjGGZd4
 AhRAE5I8l7N+6H+Ju6/eiKwMtGl7CoPLh+ZkGeNIGEt1b72YM+B40vS2kJNfSuIZ5gptN1k4c/Q
 Po7/nK27M9k22XM5+cGGT/YpoZ4lIENfB4NI7qzhRYXhVMFhm1UHhDHs2ijXiJjb1RJlknUJr81
 kUDEYeOvM337wKSC9CZhF6QoyO1trarkIafEe+mKv7LVRCeCkdPJEkAwS1ZJ4zgDWJmt9mhBFUb
 I8j64S1b/rZBTsPK+7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_01,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512210033
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 21 Dec 2025 04:04:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2843

By default, policy modules(*.pp) are stored in /var directory.
Features like: ostree remove files in folders like /var
variable data directory while build time.

Added support for custom policy store. We can now configure
path to custom policy store to variable `POLICY_STORE_ROOT`.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 .../refpolicy/refpolicy_common.inc            |  9 ++++++---
 recipes-security/selinux/libsemanage_3.9.bb   | 20 ++++++++++++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

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
index 2425a2e..99adde4 100644
--- a/recipes-security/selinux/libsemanage_3.9.bb
+++ b/recipes-security/selinux/libsemanage_3.9.bb
@@ -32,6 +32,8 @@ FILES:${PN}-python = "${PYTHON_SITEPACKAGES_DIR}/* \
 FILES:${PN}-dbg += "${PYTHON_SITEPACKAGES_DIR}/.debug/*"
 FILES:${PN} += "${libexecdir}"
 
+POLICY_STORE_ROOT ?= "${localstatedir}/lib/selinux/"
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


