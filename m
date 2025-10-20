Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE04CCD193
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 11:18:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.web10.15544.1760959099911342658
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 04:18:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=jvi1IjQ8;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JL3hu6025465
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zvSgExe26k1JXVYfdGwu1QcCrpWUWNs7t9v
	0fxF3k80=; b=jvi1IjQ8xsjSUPQi68CFAGO+nGSOuq9ZtPDatFKvqwWTLiVdLwM
	mA+Nb8qj6zHad7m+ehX5yQNOVejomjbWxMt8KtQ7efKsE/+NlXTYsE75vGTjC2nl
	Rm+SRA1tJT0QpBhKL4pYHuKlOMDHNYf5ovZLAxRQPXanJEzZrQndF50+w7fGIJgq
	J833+hv42FIOO0jSBhKrXTjTCo4XqCrmYx3zrSuPbm/+bqmMaVnQM6ouL5BE3cDW
	TutxTFZbcrYxL1DwD/XrAes+T8etj4y1s6n1g9Et7tUgyak8PKPbvNQ5+Ypm3QKV
	Kzxs+ZSLnHfznLmsviI9WiKkF5x85TqeX6Q==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2yv4gsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:18:18 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBIF6s004984
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:18:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 49v3ykuyu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:18:15 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59KBIFsn004978
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:18:15 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 59KBIFLC004974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 11:18:15 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id 5D1C45C6; Mon, 20 Oct 2025 16:48:14 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/v3] refpolicy: Correct policy version in semanage.conf as per checkpolicy
Date: Mon, 20 Oct 2025 16:48:11 +0530
Message-Id: <20251020111811.1386762-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z51uLChlNbbpGi-D23xHyzmB22GM8DcC
X-Proofpoint-GUID: Z51uLChlNbbpGi-D23xHyzmB22GM8DcC
X-Authority-Analysis: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=68f61a7a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=4dggPbQCJsUf7yP8NJcA:9 a=ZXulRonScM0A:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX6MJXc3KNIXfj
 CMN0E0873vkz/Hq5BB+xIo22voZDSC2uVd8gazeZOi6yr0t2r2JB9wyFF9k40K+nBkL9WtBw5Xc
 4cN647+sC8tKKufYzagntqSzehUCV06JSKf3dtMh0FMTt0TUgmq5lXNrBZ65vPMr+njoZnsztg3
 TDfKlCCGIctIjgMrM5OP8Kj6ilJqomwUtLzkjHFG5RKjW8kh/T2E4QwfLqaYWJnrzRlZA7E6eY8
 WW6vbWDhV8BaNkMEVbTr+6NgjCo54hBOjHSPRnRQ/XRS+ta3CQwLQLY7ApkP0vTcQPOYtvfPF+1
 BE73Z7GBGYKzD/qU4Qa+wIqRWJeoJ3j+bopt4f0oxWvGIJQTvPcyWHFSr1tKfZIzrJBfraNqdrp
 pe7b9aA99kobX+d5E2argN1Pwvmcog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180023
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 11:18:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2363

The code "OUTPUT_POLICY=`${STAGING_BINDIR_NATIVE}/checkpolicy -V | cut -d' ' -f1`"
assigns OUTPUT_POLICY with 35 and policy.35 is getting generated.

So, correcting the policy version in semanage.conf file too.

base-patch: Use selinux tools from recipe-sysroot path

Change-Id: I723f6469f633cc72745f35a68cf568e02fe04049
Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 recipes-security/refpolicy/refpolicy_common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 1234370..cf32723 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -206,7 +206,7 @@ path = ${STAGING_DIR_NATIVE}${sbindir_native}/sefcontext_compile
 args = \$@
 [end]
 
-policy-version = 33
+policy-version = 35
 EOF
 
     # Create policy store and build the policy
-- 
2.34.1


