Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C323CCD184
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 03:25:51 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web10.3013.1761017143740203651
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 20:25:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=kmm4PRCC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL0pMl004435
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zRenR0bGD0sMNsMkf36kDYUCRKSo6fg6Thu
	qX1ls+NM=; b=kmm4PRCCqxWd8M6b2neIaMAJ7p8EVjh8iYQ66DOVZaERBmTLCmT
	wmAHr93s8VmW32RsBht3zy9ikH9WJAPFtKV7S/JevGFkYaSAc6xsVO7t2QfxX4MP
	rejzF4ByikJMI57Hj986VSncd+A9yTJYIc9S2vV1apZx1jHYfCgxFFgs5UhMB8XF
	ofTu2LtYJaLa0S6qJqSU09aTEBnqqK3CFDfDHDA4nr07GVA1Y8rAB9mC4LKdwn7R
	wbHcx7xuI4P++wc6LzyGM4ZxTMTXAcXvd1r6uRfDiroeMIhFu3+NotFOSpI3xzU7
	AaRZKSgrz/EEZZWw20iXbAQSDe0e1rTkn9w==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfex19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:25:42 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L3PKiT024745
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:25:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 49v3ym28gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:25:39 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59L3Pdfa025253
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:25:39 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 59L3PdY0025251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 03:25:39 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id E91B95C7; Tue, 21 Oct 2025 08:55:37 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/v4] refpolicy: Skip HLL module processing for monolithic policy builds
Date: Tue, 21 Oct 2025 08:55:35 +0530
Message-Id: <20251021032535.1774852-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6_-3j2GW-TaAms4j4R2-vKKTzMF76iFk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX7m4LjgptvTET
 a07Xr7hGsp6f/LufaB43Rd5k8EEdbqMRR/Om0GIZPGN1PkTHNG5nHKFfpkBjKy8mHRJn35oyks6
 jpd211/Jkfc/8001kWwTfBbi0h/essBaUM8zIR6RhZ+Z3/bJykRCLkzjLPJDrnfq4iCtusw+QgY
 uj1aE4VhJzVGKa86O47PKztd8Tc/u6xysF9mAj1PJLd6KhbdTYrj+eOAUuxJG38JlsURy/mcShm
 4qqntkFftgCWjOfA6sz1/3+yvxS6vCQb5wZCeeCnnWdOaqsi45urOPzIFIdQCrRRcwwdN7uzsR2
 07+Evx9r2s4XP8d4Ob6Doxxmaq/kiv6NSjdZUPS/OdLamQRIN7K/OyAU8xtarqQnsjQZEh9JE9z
 LisHZyWnNmL0jQv6guftutoTm1JLMg==
X-Proofpoint-GUID: 6_-3j2GW-TaAms4j4R2-vKKTzMF76iFk
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f6fd37 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=-GXbN_eFVOTTTk9U-jAA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:25:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2371

Avoid processing and copying high-level language (.pp) modules during do_install
when MONOLITHIC=y is set. This prevents build failures due to missing files in
/usr/share/selinux/targeted, which are not generated in monolithic mode.

Fixes error:
  cp: cannot stat '/usr/share/selinux/targeted/*.*': No such file or directory

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 .../refpolicy/refpolicy-minimum_git.bb        | 32 +++++++++---------
 .../refpolicy/refpolicy_common.inc            | 33 ++++++++++---------
 2 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy-minimum_git.bb b/recipes-security/refpolicy/refpolicy-minimum_git.bb
index 8e44bfc..5a0ed6f 100644
--- a/recipes-security/refpolicy/refpolicy-minimum_git.bb
+++ b/recipes-security/refpolicy/refpolicy-minimum_git.bb
@@ -78,20 +78,22 @@ prepare_policy_store() {
     HLL_TYPE=$(echo ${POL_SRC}/base.* | awk -F . '{if (NF>1) {print $NF}}')
     HLL_BIN=${STAGING_DIR_NATIVE}${prefix}/libexec/selinux/hll/${HLL_TYPE}
 
-    for i in base ${POLICY_MODULES_MIN}; do
-        MOD_FILE=${POL_SRC}/${i}.${HLL_TYPE}
-        MOD_DIR=${POL_ACTIVE_MODS}/${i}
-        mkdir -p ${MOD_DIR}
-        echo -n "${HLL_TYPE}" > ${MOD_DIR}/lang_ext
+    if [ "${POLICY_MONOLITHIC}" != "y" ]; then
+        for i in base ${POLICY_MODULES_MIN}; do
+            MOD_FILE=${POL_SRC}/${i}.${HLL_TYPE}
+            MOD_DIR=${POL_ACTIVE_MODS}/${i}
+            mkdir -p ${MOD_DIR}
+            echo -n "${HLL_TYPE}" > ${MOD_DIR}/lang_ext
 
-        if ! bzip2 -t ${MOD_FILE} >/dev/null 2>&1; then
-            ${HLL_BIN} ${MOD_FILE} | bzip2 --stdout > ${MOD_DIR}/cil
-            bzip2 -f ${MOD_FILE} && mv -f ${MOD_FILE}.bz2 ${MOD_FILE}
-        else
-            bunzip2 --stdout ${MOD_FILE} | \
-                ${HLL_BIN} | \
-                bzip2 --stdout > ${MOD_DIR}/cil
-        fi
-        cp ${MOD_FILE} ${MOD_DIR}/hll
-    done
+            if ! bzip2 -t ${MOD_FILE} >/dev/null 2>&1; then
+                ${HLL_BIN} ${MOD_FILE} | bzip2 --stdout > ${MOD_DIR}/cil
+                bzip2 -f ${MOD_FILE} && mv -f ${MOD_FILE}.bz2 ${MOD_FILE}
+            else
+                bunzip2 --stdout ${MOD_FILE} | \
+                    ${HLL_BIN} | \
+                    bzip2 --stdout > ${MOD_DIR}/cil
+            fi
+            cp ${MOD_FILE} ${MOD_DIR}/hll
+        done
+    fi
 }
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index fd41f8a..27aac44 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -173,22 +173,23 @@ prepare_policy_store() {
     # Get hll type from suffix on base policy module
     HLL_TYPE=$(echo ${POL_SRC}/base.* | awk -F . '{if (NF>1) {print $NF}}')
     HLL_BIN=${STAGING_DIR_NATIVE}${prefix}/libexec/selinux/hll/${HLL_TYPE}
-
-    for i in ${POL_SRC}/*.${HLL_TYPE}; do
-        MOD_NAME=$(basename $i | sed "s/\.${HLL_TYPE}$//")
-        MOD_DIR=${POL_ACTIVE_MODS}/${MOD_NAME}
-        mkdir -p ${MOD_DIR}
-        echo -n "${HLL_TYPE}" > ${MOD_DIR}/lang_ext
-        if ! bzip2 -t $i >/dev/null 2>&1; then
-            ${HLL_BIN} $i | bzip2 --stdout > ${MOD_DIR}/cil
-            bzip2 -f $i && mv -f $i.bz2 $i
-        else
-            bunzip2 --stdout $i | \
-                ${HLL_BIN} | \
-                bzip2 --stdout > ${MOD_DIR}/cil
-        fi
-        cp $i ${MOD_DIR}/hll
-    done
+    if [ "${POLICY_MONOLITHIC}" != "y" ]; then
+        for i in ${POL_SRC}/*.${HLL_TYPE}; do
+            MOD_NAME=$(basename $i | sed "s/\.${HLL_TYPE}$//")
+            MOD_DIR=${POL_ACTIVE_MODS}/${MOD_NAME}
+            mkdir -p ${MOD_DIR}
+            echo -n "${HLL_TYPE}" > ${MOD_DIR}/lang_ext
+            if ! bzip2 -t $i >/dev/null 2>&1; then
+                ${HLL_BIN} $i | bzip2 --stdout > ${MOD_DIR}/cil
+                bzip2 -f $i && mv -f $i.bz2 $i
+            else
+                bunzip2 --stdout $i | \
+                    ${HLL_BIN} | \
+                    bzip2 --stdout > ${MOD_DIR}/cil
+            fi
+            cp $i ${MOD_DIR}/hll
+        done
+    fi
 }
 
 rebuild_policy() {
-- 
2.34.1


