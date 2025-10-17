Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7997ACCD184
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 04:24:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web11.8381.1760675081077899830
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 21:24:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=F8RlNlMm;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLMel006161
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=R71ltd4Kz7VJHZ7qflP8NHhpYjhzTAMef9l
	xlhAd0wk=; b=F8RlNlMm+yeehgjTox11KFmKxvILs4QDx9V/zdJRDviG3bfADXm
	8obCVsA2GZG11a+vyvQJ0WiGgA+irfUeerQBQTIER4wSzc5ikl0qddbCw1QTgn/t
	MeXKTiJCw8hKnwPfZkLRUq2TG5ljzmOQggcmQzPreKPDgzZUYQEyvp1oOqY13IJn
	xLBrM2rV+VkayEDyFxFTNZmWgWrTJk5PMemNCMCLr9clHlCurS17VdaH86qDApOA
	mjzNjsbiHvSgoBUMQieeww5d8abOJ4VO7YBba9rvCUHFFDbCumLbXyvi/IlIhoNl
	CjvmZ/Nx3ONDVmpCDdkUrCjhRramF1YTnkw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mww4p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:24:40 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H4OboV005967
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:24:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 49qgammfvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:24:37 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59H4OaQr005962
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:24:36 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 59H4Oana005960
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 04:24:36 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id A72235C4; Fri, 17 Oct 2025 09:54:35 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH] refpolicy_common: Skip HLL module processing for monolithic policy builds
Date: Fri, 17 Oct 2025 09:54:19 +0530
Message-Id: <20251017042419.3307354-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfXysOdTBIW8clO
 cIX0+Fnm+fWXWpkq5ntQR1LqCq1gkj5syvZvU9/muoyruQmzhbNBGnR0y1HAEMlO+z8ShuVzdyV
 MtC10gV+UtOJCUepJYg4mY+e6jXNBvaXO5D4ED5UV8z75KEL1G/huAS7aBZptBNq0ioz5FtyqUP
 98sCg98KQ1sDJU3d6mDd1FLBX/k1pcFnidfZPkKqCWbEc2EJp2Dh0ZgdibXPemX8yKcIU+cfiCc
 mOWoU90W/30yF2Ng9ZmXZUghbEU47dw+4MTgK7ZzX6ypBUvreNomtzjxezGyNMkHBNM+4uiVG5i
 dYj/TmZu8Ks50InzHvSPYGPFZYXQ79Q6NBgW65uy74jQ45Dj2pI3Ts1jwWygxCDmOZdQpXfw9dl
 HNwQwm2ocnAVebtYxWKJnCvx/328JA==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68f1c508 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=N_kUeKDYNsvIcx_cwUsA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: M6XcvX7R0i8morFjZNMpTUqxeU8e5vYz
X-Proofpoint-ORIG-GUID: M6XcvX7R0i8morFjZNMpTUqxeU8e5vYz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:24:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2342

Avoid processing and copying high-level language (.pp) modules during do_install
when MONOLITHIC=y is set. This prevents build failures due to missing files in
/usr/share/selinux/targeted, which are not generated in monolithic mode.

Fixes error:
  cp: cannot stat '/usr/share/selinux/targeted/*.*': No such file or directory

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 .../refpolicy/refpolicy_common.inc            | 33 ++++++++++---------
 1 file changed, 17 insertions(+), 16 deletions(-)

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


