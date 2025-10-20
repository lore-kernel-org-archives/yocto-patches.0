Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E4ECCD199
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 11:17:16 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.web10.15531.1760959036196622523
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 04:17:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=hiC2BAzr;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JNESpL010739
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ysCd/EYvmHAZiD7f+Ur7FaGx9s1UUimeDyI
	HJ4RuyxU=; b=hiC2BAzrijanhVmlt2WT+wRI/pr6f6hS6QCZe13OAddjTxeBjNz
	Mev+0TDQC9sEIFOGRNRL9QQH8OEYuWG1qUByYqBKzKDFVz56Kulv4DRRfmx4uKV/
	0s4Zc/eioIgCbd6N+mJA0jzRy/mhyAMBAmoTwMnryCEIIVxokMQVCLWlYmdPZZET
	lAOGZVX82VDiE6rzMblIxfBU5xLUcyytmDAGfftzjSyj1wtPaY2rqQyYKl9DubX/
	ZXb79b57Mw8vm8cV+l2vLcBakHcF8HB72m4frJwYWUeOYluUdQ3lP2yR3JRJQ/y/
	T7h/GvgXL8bNwYxwJmqNhp9f7P/MHe8/OtA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w7vmmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:17:15 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBHB2T003703
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:17:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 49v3ykuyk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:17:11 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59KBHBHm003697
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:17:11 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 59KBHAUL003695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 11:17:11 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id D718C5C6; Mon, 20 Oct 2025 16:47:09 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/v3] refpolicy: Remove build path reference from file_contexts.homedirs
Date: Mon, 20 Oct 2025 16:47:07 +0530
Message-Id: <20251020111707.1386674-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX/nupKtK4nA4c
 PuZI3U5Po0+LRtzfPIzR1816L+igw1r9YtQtFuKwbf8dQntpekPRbGrVqYfaioR55e04wUXdDeB
 9/mtdC0fMfZlmWNhhU+VdIv0rc1h+kfFEOFZ7vsKsWJD8pM9EIe3NfzWmJ8DvB9oT+g3c+hVf8U
 c0VSnh1f+IfZjG+OOj6KO6UerWtEonHkimbQ9qrpmBQMjdqtslPlhh2IGjxUS7pKBlcgCGXWpim
 f737RUxyB6OvJilc4oP9qXrqfzHn1+u/bUXAC0FjoRjsalrfpnc78aQxRsqsWNeUB7MsSb+NcIY
 bWrSPJpaIVvDsPfuKVi987yfIxYyvZNR6mOGpthK/P9cpvWrZxUaUmKn73YEcF5ijvV36B1CWpM
 2in+i+Yyc8Kzpy2u+0TGZHWwtx3dCg==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f61a3b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=KBILEq-dR_ycPv6JiZsA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Va1EhkPJwrHbQJjQuTsYb4R5MYRXKL19
X-Proofpoint-ORIG-GUID: Va1EhkPJwrHbQJjQuTsYb4R5MYRXKL19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:17:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2362

filecontexts.homedirs is getting populated with reference to
TMPDIR path and yocto's QA check is flagging it.

To avoid this, removing the line that contains TMPDIR path
from filecontexts.homedirs.

base-patch: Correct policy version in semanage.conf as per
checkpolicy

Change-Id: I842cfd8d2f6ca5f92da37dc96c1e896386401c24
Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 recipes-security/refpolicy/refpolicy_common.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index cf32723..e09f73e 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -260,6 +260,7 @@ do_install() {
 do_install:append() {
     # While building policies on target, Makefile will be searched from SELINUX_DEVEL_PATH
     echo "SELINUX_DEVEL_PATH=${datadir}/selinux/${POLICY_NAME}/include" > ${D}${sysconfdir}/selinux/sepolgen.conf
+    sed -i -e 's|${D}||' ${D}${sysconfdir}/selinux/${POLICY_NAME}/contexts/files/file_contexts.homedirs
 }
 
 sysroot_stage_all:append() {
-- 
2.34.1


