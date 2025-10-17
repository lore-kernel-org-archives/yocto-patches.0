Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8226CCCD19E
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 04:30:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.web10.8399.1760675404560261000
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 21:30:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=U4ifkc8F;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLQCL001991
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7GJKpDYltVEbz/aknG2Bb1BXyME1qDimeHN
	S39glEd0=; b=U4ifkc8Fpx7rmLDtiMygq7k/F36IWa/4RaLCBmvXbEi62fztG3D
	PWv5YrUMlHPPiPLKctw5ffNp7TT//hC8CJDEqf32rMtmJ87x3KJAiTeMS3Z2gXnG
	Z6ytYL0NYLgvpZIUob70l81RW8CuqJVn3nigELsdvK9aUgOJGsrw+wRBNoHIV+rc
	dFl0KfNn7NhvhY1ZH+OemU/Ej6eoJQbiDiW1ZWOBPKxCnM21Y1G9hA5TabWifFHb
	Sg70DN19gkop4dTIvAwg0ajc6MiawSdoOkL/ik2Bd+GieR5iRiH5A58u2D6rHiOc
	8IjImrmWYkC62rmqitSw1khFXQMy6bz3b2g==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8jusj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:30:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H4U0tV012255
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:30:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 49qgammgbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:30:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59H4U0q5012249
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:30:00 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 59H4Txj8012248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 04:30:00 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id 01C215C7; Fri, 17 Oct 2025 09:59:58 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH] refpolicy_common: use selinux tools from recipe-sysroot-native
Date: Fri, 17 Oct 2025 09:59:53 +0530
Message-Id: <20251017042953.3323046-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0TKgNgG_E0OdkR2m-HtCW3u-zVX0tPcF
X-Proofpoint-ORIG-GUID: 0TKgNgG_E0OdkR2m-HtCW3u-zVX0tPcF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfXwj1NT7/PaLTq
 dEOHEdJpCA/j6LxsodSZgRQJ0CBf6Y/ydBZtr3ZfOTcQSpqonfrgJ4Mz8+jbwx8iOG5Tf7m2NMa
 UXvRgOr2rB7VrR6+cA7Qp15MtnZs25hAQPXWdNRF2J7ZvFX/age/iVs5MZfOB9eBg9C9slQMjGp
 WUW2TZfwr2+0mvFW67gXDXCDqbK/wlKWQofzzx8uS6fVFdToLASTTpGRDNqM+IhjXC1OMV732XM
 1cEXIF9N1MZ/B+IjbnephRFqUhRsmwv7v21w8VDjznAniUgPi+RQv4XOSCP9BGzT+gQYAogpeop
 BFIyRMWLtaukxbgQLOL8yJ9pODICnLOCtuBxBxcgWJuhxPkscilb2AsK1V34RZSYC4A/zz9R3Q4
 OUGNJOPeN+Diow0u6CXxLh35eeNLtw==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f1c64b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=owfOQfebTelCMGAwzRwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:30:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2343

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


