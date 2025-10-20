Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEC6CCD193
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:30:24 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web10.12457.1760945419936540984
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 00:30:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=gl7s3VBw;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JLGwdP024364
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=R71ltd4Kz7VJHZ7qflP8NHhpYjhzTAMef9l
	xlhAd0wk=; b=gl7s3VBwvrk3RrEjUZn9EIzCluDApeDEXPr2CR9So/q3DrqVeLb
	yWNdypH9vQnR8UYpMizFGbW8K87jC3+RCd2eVsH8Vu5MFGDTz23uPX4eTTFxB181
	FqDP6gafMyDzwZJ0IKQJhPDFqOrTR7zjGUJ37eaSMniXaaAvkqq2Cpcr1DKmHDXP
	fyDDvxe4I+dH94K+x5KtPQARtOyrTILuzFs+bPj/fziUSFe9gKURIZHKfM3ajF+B
	wISXatOWkf+/X5MKnfg0zWVRxzSfidUYuFnhI81XwzQMVrlMoW3w3ljUn/+4QJ5m
	TFfIMFg/eJOuZLnRDLcaayZ1Lc1/4/kC5tg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfc7a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:30:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59K7UGqr017422
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:30:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 49v3ykq66q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:30:15 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59K7UFGI017417
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:30:15 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 59K7UFoI017416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 07:30:15 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id AE0535C6; Mon, 20 Oct 2025 13:00:14 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH] refpolicy: Skip HLL module processing for monolithic policy builds
Date: Mon, 20 Oct 2025 13:00:12 +0530
Message-Id: <20251020073012.1255387-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f5e50b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=N_kUeKDYNsvIcx_cwUsA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _Ss4QFuaMRF_raKlZioHGz_vMhKcA-NG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfX/gqaAEP9Spx2
 PZrwt09dYzszva8bhib8ToXOGSEmE4lPkufnv01mcaAZr+ughpweZKhPeGdvs0is/dZy7duMZmL
 abc8pyy2ZbIxQkbHiof23zXGzxxFsinzLEZdZpSeOV5SaiRlwhq2WLXZzuMgC31SzEcUXzx65I2
 lRAkDbSNPzVmH4v+lA2VgCsMhCptEQje0IXF4rxw11r+7RgvrhGKgDOSyS95HCJyXBJ43lxPZWh
 A17bnxa9hgTnKmWvNaT8JxDvMmjyPhJx3cRN9KWy1ib3ckRinmM25L/Mu8ReFI0BsUG3xWEgwQb
 FdtibHjmxZNvBNKIW1IywrBRsAMQHNCGGK1ma/4S8g+N5m74NhZpX+fvmxA919LFuX1QEXz85Hf
 6d+kyQrxPupuw34cIHePsGclBlRUIw==
X-Proofpoint-GUID: _Ss4QFuaMRF_raKlZioHGz_vMhKcA-NG
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
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:30:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2356

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


