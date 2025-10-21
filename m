Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD7FCCD184
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 03:27:01 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.web11.3024.1761017218676514099
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 20:26:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=FdRdJc1M;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL0ucM029853
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7GJKpDYltVEbz/aknG2Bb1BXyME1qDimeHN
	S39glEd0=; b=FdRdJc1M3sA6hxEXPyLCRCkYPoxvafBU7Wb//tsBPoF91YU9Z+E
	sJhJM1I/vSHGrraerJPUoE/vieU3HmVzF0tS3Cubdx/C4EgpXFwFjcytNalf4wmo
	c+YkL5E2gakpaSokNajjlLIWYWIu1F2efxjuNLGc2DECUg6rh/Iudip+NW7u0b68
	iuyMLgyPO8jtrwgE5Sy1m3ncHQanIrbpEcUHTsN747lVZyMcbwRD0liiEGsIU6JB
	QuNqYuaY5ViP0UYpLM7eGcw+fmCKO7F5QWejZuRAIbPlH61YUZ+WqVyP7wVRGjZn
	ifw4KlIUlxeCSTPSO5rpoqa9gSXD6tSh6zA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gdxypr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:26:57 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L3PKiU024745
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:26:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 49v3ym28q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:26:54 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59L3QsL0026269
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:26:54 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 59L3QrnH026261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 03:26:54 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id B0F60577; Tue, 21 Oct 2025 08:56:52 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/v4] refpolicy: Use selinux tools from recipe-sysroot path
Date: Tue, 21 Oct 2025 08:56:51 +0530
Message-Id: <20251021032651.1788894-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX+RVNtEveOLZB
 4vPJZueQm4WM5HH0ax2lZlE3KsGpAexBqGjw93x80/f6iXkvYLct0DTqV9f8/MHzUtFY29fvqAQ
 gFnWNiBgZDeit53UpLYqkLQBsyakOe7nMihxY2LQ9sclBRmsItqAmcOpiBYkFUOal+WkCYIoUjL
 U+7blSPVm+SpWtCHdHovEWnPo84WZVNuldGRFBRoQeba8O0ixKDsBKzMlGqF1l3CCMLwhPeexkf
 O3AkoA9zqrZIj2GSI2g9FlmuWKjfhxZjFR1Q8CBhfEjuhaterUzXx5PPySaLbQ73EyZkxMGB1zg
 PJOsZifEI9YI6vyc07LMJTGG+oGOaGhohvNLfOZSC2CFjBMnq15poXmUvD/c5oIcFS8nWNLunWZ
 jawauKX62SpUDH6KeIjGPkr8WRK0vg==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f6fd81 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=owfOQfebTelCMGAwzRwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: R_eejpznj7ozedc2ry0-2Qt5ZySvTTiK
X-Proofpoint-ORIG-GUID: R_eejpznj7ozedc2ry0-2Qt5ZySvTTiK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:27:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2372

The following code snippet from refpolicy shows that the host machine's
/sbin, /usr/bin, /usr/sbin paths were configured to use selinux tools,
instead from yocto build recipe-sysroot paths.

refpolicy/Makefile:47:BINDIR ?= /usr/bin
refpolicy/Makefile:48:SBINDIR ?= /usr/sbin
refpolicy/Makefile:63:tc_usrbindir := $(BINDIR)
refpolicy/Makefile:64:tc_usrsbindir := $(SBINDIR)
refpolicy/Makefile:65:tc_sbindir := /sbin

Fix: Configured 'tc_usrsbindir' and 'tc_sbindir' with yocto build
recipe-sysroot paths. 'tc_usrbindir' already configured as
per recipe-sysroot paths.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 recipes-security/refpolicy/refpolicy_common.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 27aac44..1234370 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -130,6 +130,8 @@ EXTRA_OEMAKE = "NAME=${POLICY_NAME} \
     MLS_CATS=${POLICY_MLS_CATS} \
     MCS_CATS=${POLICY_MCS_CATS}"
 
+EXTRA_OEMAKE += "tc_usrsbindir=${STAGING_SBINDIR_NATIVE}"
+EXTRA_OEMAKE += "tc_sbindir=${STAGING_DIR_NATIVE}${base_sbindir_native}"
 EXTRA_OEMAKE += "tc_usrbindir=${STAGING_BINDIR_NATIVE}"
 EXTRA_OEMAKE += "OUTPUT_POLICY=`${STAGING_BINDIR_NATIVE}/checkpolicy -V | cut -d' ' -f1`"
 EXTRA_OEMAKE += "CC='${BUILD_CC}' CFLAGS='${BUILD_CFLAGS}' PYTHON='${PYTHON}'"
-- 
2.34.1


