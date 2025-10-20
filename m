Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A21CCD193
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 11:20:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web10.15577.1760959228565452903
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 04:20:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=gQTAD1DC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KB1Hxn010027
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IobqApfK7qsvi3B0bDPPzT4RXdKaBw/9+Oo
	FFaWkNwQ=; b=gQTAD1DCJMg8rjhzLL/ZY7tBwei+fSpZCg1d6smi8U1btmOKMpB
	64BScDl+8jza8Fg+Ln63t0kY7G32ecg8llP4tb787nOUiAm+UjfONoms7yofWeHd
	C+ZZAyh2dOlefThR5pm+cnIj5pMasOlPB/pm1EOOFuPxhFjBn78iZeitt5nlU/lU
	pFLYrXTEvIk7j+Ark5uh3o7Dekt1oOwobVANM/8WYAOJNkQc/izRlTAwNjwhGEtj
	2mVrOHj1s+AU+SUmQAswDaYdA9fIZy1SIXEaO2ni+TB1+BeYGRHqURgDYinUA7hR
	6fXW+nwOW5NgK/4VWkbf+9qN6PY49LXSJVA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfctk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:20:27 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBHB1F003708
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:20:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 49v3ykv0b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:20:24 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59KBKOU4007091
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:20:24 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 59KBKOQx007089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 11:20:24 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id 244005C6; Mon, 20 Oct 2025 16:50:23 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/v3] refpolicy: Skip HLL module processing for monolithic policy builds
Date: Mon, 20 Oct 2025 16:50:20 +0530
Message-Id: <20251020112020.1386962-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f61afc cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=3sh4xOGHE4pzSJrSiC4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: q1Q8kwcqmM0-kbbe7cp88SvYO7VCORSk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfXwvSsnTFLmYQd
 WHpZ/CZzzSb73Jz25j06+txVHN1kXg+yDkjjzNTXCnyk8/+mwQDIBgfHPSZMfNOlbVUVNu3LaAj
 ifpKQRpIeeH5LP0FN72PEyhAeaIt6OqckmrJzW6Q2IciJBVAwpTS7gERWaKi9yJp88Oc6687etN
 6CJVaxS3GTSQsO0ijC/PgCelWIYoTbxsTHsx/J+BA2fVAx7tT1I6xOWyQ3AGo0uWIW3pSJK0gkA
 rc1DvTvhDkbG3tKxDs7t1xvcGpMdY+1DKS7VoXvL0+2wVYXIBeoHJpHeNXaPPy90Qfj/yvRi2W4
 ydu+9Yk2vHzhC/DSz0ZehMVCx0SYZmIPuwFYQVUWd20EhX9fB/fYMwSZZ+Duz6MnwW8k332x4Xh
 0lWs7RJN9tWkCDEUVr20Gtt6Qzk2Fw==
X-Proofpoint-GUID: q1Q8kwcqmM0-kbbe7cp88SvYO7VCORSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180002
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:20:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2365

Avoid processing and copying high-level language (.pp) modules during do_install
when MONOLITHIC=y is set. This prevents build failures due to missing files in
/usr/share/selinux/targeted, which are not generated in monolithic mode.

Fixes error:
  cp: cannot stat '/usr/share/selinux/targeted/*.*': No such file or directory

base-commit: initscripts: fix incompatibility with read-only-rootfs

Change-Id: I480d0165495d95a27cf87ac3bc2b032a588d4538
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


