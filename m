Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B478DD5B16F
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 13:48:25 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48981.1765806505074369013
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Dec 2025 05:48:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=EVs7DwQf;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFANpLW675863
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 13:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TzHRd4wjTxOVM9N/oFIhf+Qo6/h+9dZ1Rda
	xYAc9oQg=; b=EVs7DwQfdQGaPTuajsrR2Rb/i61QdpJtILEdaCgCPh6oFLIEr/W
	hOXq9fyFgWt9SSoI2guqcWv0Q1nnIjZSup1EPeoT2ILkkfeYSdceSE9emPqSzpo8
	Vx3sLvyAqXQaOOoQoTq6fwKgzjyOAjnSqfLddEIZzbRRHKOU3/IJCYQheLlCFaQ5
	jTQb/nimIwYZsvbZnimk8HrecmeXHZ2cnk/CiDv3oGShL/muO8+Fk8yH1mv5HwEJ
	Uf2Ccze3KmXlBLOt5Q4KflQmGVm60Mq2yfecPZIkxDOOXQqyIneyMAk68TR7EsYf
	KzwgoYe5/EcOnsNKJYQGn3pNZIH3bb1BFQg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b11cymqn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 13:48:23 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFDmJG2009985
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 13:48:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4b117ky4ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 13:48:19 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFDmJpS009979
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 13:48:19 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com ([10.213.102.143])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 5BFDmJgI009978
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 13:48:19 +0000
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4060212)
	id 0FFEF21CC0; Mon, 15 Dec 2025 19:18:19 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH] refpolicy: Add support for custom policy store
Date: Mon, 15 Dec 2025 19:18:16 +0530
Message-ID: <20251215134816.1605079-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDExOCBTYWx0ZWRfX9aoDORVfvtnt
 McLiu5iie+5xRuLXiyxECNWf3ss9mqZjK7YaLljnyubdAZoYKuhdSbvkiJk572XPct5oX1qn5dA
 dpMbq7sYc1LRi9WBe6DVhG/AkZrglATvyjM1+dRdmJroeOGhial8g7j9UBU2u7TZvnv6DFftlVg
 RB6ievDE1k2cR7LFa4yO5XH103aVKSPkjXUjj6rLtRlhpisErQiMoG4iYnnM6GXGFHGzm8OIg1X
 zGe9N97846YpT5CwRYc/r6F2YnpB07GkKB3M2SVtRsrZgB2ZdbBxDXduXhJopzprsy1uzuyCHyo
 56P84AQ6gtEoMVM+t73bPYOgHG0+m08lnN1/KtxH57dZ/ppKtCYnlzeu8GGKnYQIQYbeXQMMmsj
 hdBKGgKKP9LHCIfMxgnMR7300GMz1A==
X-Proofpoint-GUID: wn8qvAZGPg-FLg75mU9cPULGafldI2Bs
X-Authority-Analysis: v=2.4 cv=Afq83nXG c=1 sm=1 tr=0 ts=694011a7 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=oCwQqg7PNz2VNpKvC5cA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: wn8qvAZGPg-FLg75mU9cPULGafldI2Bs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_03,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512150118
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 13:48:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2787

By default, policy modules(*.pp) are stored in /var directory.
Features like: ostree remove files in folders like /var
variable data directory while build time.

Added support for custom policy store. We can now configure
path to custom policy store to variable `POLICY_CUSTOM_STORE`.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 .../refpolicy/refpolicy_common.inc            |  9 ++++++---
 recipes-security/selinux/libsemanage_3.9.bb   | 20 ++++++++++++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 964906b..ea3ca31 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -77,10 +77,12 @@ SRC_URI += " \
 S = "${UNPACKDIR}/refpolicy"
 
 CONFFILES:${PN} = "${sysconfdir}/selinux/config"
+#POLICY_CUSTOM_STORE ?= "${localstatedir}/lib/selinux/"
+POLICY_CUSTOM_STORE ?= "${sysconfdir}/selinux/policy-store"
 FILES:${PN} += " \
     ${sysconfdir}/selinux/${POLICY_NAME}/ \
     ${datadir}/selinux/${POLICY_NAME}/*.pp \
-    ${localstatedir}/lib/selinux/${POLICY_NAME}/ \
+    ${POLICY_CUSTOM_STORE}/${POLICY_NAME}/ \
     "
 FILES:${PN}-dev =+ " \
     ${datadir}/selinux/${POLICY_NAME}/include/ \
@@ -165,7 +167,7 @@ prepare_policy_store() {
     oe_runmake 'DESTDIR=${D}' 'prefix=${D}${prefix}' install
     POL_PRIORITY=100
     POL_SRC=${D}${datadir}/selinux/${POLICY_NAME}
-    POL_STORE=${D}${localstatedir}/lib/selinux/${POLICY_NAME}
+    POL_STORE=${D}${POLICY_CUSTOM_STORE}/${POLICY_NAME}
     POL_ACTIVE_MODS=${POL_STORE}/active/modules/${POL_PRIORITY}
 
     # Prepare to create policy store
@@ -207,13 +209,14 @@ args = \$@
 [end]
 
 policy-version = 35
+store-root = "${POLICY_CUSTOM_STORE}"
 EOF
 
     # Create policy store and build the policy
     semodule -p ${D} -s ${POLICY_NAME} -n -B
     rm -f ${D}${sysconfdir}/selinux/semanage.conf
     # No need to leave final dir created by semanage laying around
-    rm -rf ${D}${localstatedir}/lib/selinux/final
+    rm -rf ${D}${POLICY_CUSTOM_STORE}/final
 }
 
 install_misc_files() {
diff --git a/recipes-security/selinux/libsemanage_3.9.bb b/recipes-security/selinux/libsemanage_3.9.bb
index 2425a2e..98ff73d 100644
--- a/recipes-security/selinux/libsemanage_3.9.bb
+++ b/recipes-security/selinux/libsemanage_3.9.bb
@@ -32,6 +32,8 @@ FILES:${PN}-python = "${PYTHON_SITEPACKAGES_DIR}/* \
 FILES:${PN}-dbg += "${PYTHON_SITEPACKAGES_DIR}/.debug/*"
 FILES:${PN} += "${libexecdir}"
 
+POLICY_CUSTOM_STORE ?= "${localstatedir}/lib/selinux/"
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
+            sed -i "s|^store-root=.*$|store-root=${POLICY_CUSTOM_STORE}|" "${conf_file}"
+        else
+            printf 'store-root=%s\n' "${POLICY_CUSTOM_STORE}" >> "${conf_file}"
+        fi
+    fi
+
 }
 
 BBCLASSEXTEND = "native"
-- 
2.43.0


