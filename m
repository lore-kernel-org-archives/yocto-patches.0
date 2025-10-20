Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896D3CCD193
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 11:19:16 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web10.15559.1760959155580656294
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 04:19:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=MPpJg/mR;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JNstNW007555
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jwjFVrxz11JhX3H6rBv34e/bCCWMHMm00a6
	E5V7Abvw=; b=MPpJg/mR+plKBqygmBiRx6dlI+fiIsvrH2P/yu7YjwxqAQiRtaH
	0yV+o2XHwVZlT8Ard2B69W/tIpjKG6nyJvThVy4g/Py/8Jx6QPoBYadtuttWPmu/
	gWObc9ldv03qVmB2i7AWcz8KNmzL6Vfz/8/zjEJNhaEO/pCbPotoqRiSTmJaB3QW
	jhn4MzqvkjsDgy9D669HxZNRkccjAhNZ563rWVlqBNXyLEsMFDW3SXAycyfevoI7
	khTbtnGoW6nkzzkZqlJXecDLJ5qAskJrUys5WMMdfmO8vxiIXjlri79duXHc7f0P
	7BzGWzmJebZ/vIQOG/IdYsdyMOQh0mSDewQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfctgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:19:14 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBJBDs005314
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:19:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 49v3ykv01a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:19:11 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59KBJBYQ005306
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:19:11 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 59KBJBM5005303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 11:19:11 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id 2D8955C6; Mon, 20 Oct 2025 16:49:10 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/v3] refpolicy: Use selinux tools from recipe-sysroot path
Date: Mon, 20 Oct 2025 16:49:07 +0530
Message-Id: <20251020111907.1386845-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f61ab2 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=owfOQfebTelCMGAwzRwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: yagw4ob2bLDr8zZEQys7B8USUoMbZA7W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfX1t1E6SQVLdF1
 bOfIxyvDjJm5udme7iLmCQWR8D5mpvhZLxZ5MCP1AxI7hLuDwuIhjdxvw+g0qeWEZGVBmrTAmLx
 8/dly9pfaYeboJREMkOTwkPyeaINXJG7/QVSvNNXuiVI1pUyYN6BtXOLUL/mya3QrN+1YPFk4t8
 D437JyB4jnf75LXaeiFKNzvxl6K+Lf2MD5LBwCOtaV8GdDZBRpu+pS8Sn78eaC/zuCQccCUDthJ
 lfY5ijC0BoA7LO2LywVBm3JVw+ioGsI/0z4VsJMUS08OEACZ6jqwqgcz+rzBQomgo57t8IU4hAJ
 IYRY3eVDxcEzsnEKLzJSqRaQy3zD9yaIMxpIsQqr+9VRBUrvwv8iz0BTtV5mlufI4nELkd2udJk
 WEYYV89wcvFkB+q29YGYnBxdu/jmwA==
X-Proofpoint-GUID: yagw4ob2bLDr8zZEQys7B8USUoMbZA7W
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
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:19:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2364

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

base-patch: Skip HLL module processing for monolithic policy builds

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


