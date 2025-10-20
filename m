Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BA6CCD193
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 09:57:16 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.web11.14594.1760954226280496408
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 02:57:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=Tn6IoCnJ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JLLa2m023239
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fcpE24L+x97PPGMPPyXL7CjHkA4FCu1VpcU
	A72DdIlw=; b=Tn6IoCnJbZBCKCu+BcDsP6/18fxfqFsUjKyoNthVk6FU3FvbnOF
	pQ+B1+EFKxKk2VDKujurNjo5tsm35huYF8CDYX1cdVYqRivGAQPMVi6rzSK0JwIu
	ziOtUoNTQUq3Y6qbSC6q5tR37tXUeq6F4CmWG9bZT3QHBV+g8EKfsP6Mmlsvhs/R
	VLdr5gmMbCQNshhxeBAKx+8TwTU07JvphWP+AaoXA4f2ceelRSIB9SnQsaP4+Gm9
	TrigAoG3QglM33FXa9VDvv0PomIdhJcwcHatLASVroNGKTX9jCZbPxXnT+EcqH+m
	ZxntxnCRDRVw+z2pdhZk31F7WOY3uiDZjzw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27hvehr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:57:05 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59K9v1ti023837
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:57:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 49v3ykqp8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:57:01 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59K9v1ZA023832
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:57:01 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 59K9v1qP023831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 09:57:01 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id 590755C8; Mon, 20 Oct 2025 15:27:00 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/v2] refpolicy: Use selinux tools from recipe-sysroot path
Date: Mon, 20 Oct 2025 15:26:57 +0530
Message-Id: <20251020095657.1341020-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX8LCOx3Gi5jcm
 9RGaqFYPSFgItNf11hgX/KTSLSlRMc5ZkbWIdxmdVblWZIDtH0kRiudN+5TKQXZVjeYrHd40uy8
 KsHzDW1ic7vp0F7665uiry2IkAtrgobeRiWX/jjEc6b3O2EM+ZO0xuqlWLBcpqb6TmJqPud12DC
 KMbkOGny/J79YYRGsUucnF08TTerRgsdl2eGUuMfs1SIG0UCKYnbE4tQzL1XDFPnEEWU9v/dP3q
 NHP9YAo9HjeKnvwUGEFByO9ww2jNSp/Og3oCSzb3jQgc7mjbUBm4HfgeMk6q5LFBy43nejaaQlc
 hzILhkYoLoF/A5caEGkWgwOev4mEiTy24HbtkL23P2oEEAOknc6wTDc3xxGxNl0ZmAup+oIETa9
 C5Q0zO/T4bYBTM6hV2Go+hwNhurzPQ==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f60771 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=owfOQfebTelCMGAwzRwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _P3j2-NS75jjgWP7q4eq9qU9XCbxbh2v
X-Proofpoint-ORIG-GUID: _P3j2-NS75jjgWP7q4eq9qU9XCbxbh2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:57:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2359

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

base-commit:36b815d771d950d71c8d4c33418cb96dad8225da

Change-Id: I1b8e3113ac1546b00f6d6b68631017bc78ac7f08
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


