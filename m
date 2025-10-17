Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8718FCCD184
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 04:32:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.web11.8450.1760675544800912823
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 21:32:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=lzdv2rfp;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLRdm022235
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Uu7fPW8vHRdM/SBl7OyF7g7LyFWJC8Hb74k
	fXRnXKrA=; b=lzdv2rfpPc+P8xNXf1ynWHjFRszmnwvvlc2LwTycmIFNaVxfr5W
	kYX7tH6T7AhGumAKKDcErC6hiYp3B2wTCPxztaJlvJhL7Yzdrx4LE0IECRLPBAkO
	daWidwNeMK3NKlAx6Jw6xvhi9+br87nuqf1Mx+ruv4zztZKAh1TvUQ5PGJZMpnPS
	tC2ZkMne2U3ud2hBefTANdP6lRfsAApC1R1HLmCqKQ1qmsZv4EioMBI7KM5iSeo8
	eHjw1gz5qSKn3K8S6lwVaKMlq2RwNlUXt7Z7N/mx0jHnhi7qOpZSGSQEFwWiW8jO
	VDQR4rqrOoSTOu6JiSytuIoOvkiF3p+EAXg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrtfs5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:32:23 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H4WJw3025205
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:32:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 49qgan0ume-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:32:19 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59H4WJF3025200
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:32:19 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 59H4WJ8r025199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 04:32:19 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id 01BBD5C7; Fri, 17 Oct 2025 10:02:17 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH] refpolicy_common: Correct policy version in semanage.conf as per checkpolicy
Date: Fri, 17 Oct 2025 10:02:16 +0530
Message-Id: <20251017043216.3323445-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M1_JTfHju3HFzPpFrTSVS3kkpqeTWcOt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX47W41nJkSgGr
 IUQi4ar4WxbxM0qmfr8qoB2nO15pVZqzifKQZzT6pM/HJVhU5HCglszBwqElnsvc5YzYbwVUeMb
 yBNPEind0Oy7bI452caKpz9DCQge3sHbLWWJ2v5vdutHoGkAwurkqWF7iB5MIYY6Ouxf5eyxd+i
 KELKslju/zTGd/9ol93rquuzur7Ju252m6fUSEQojCoPAxsm3NzkMbWvJKLblK7Mja4zAkhQ1Og
 zqZzfUj6h2/TlH47mrsl9/WfwlKUpjvgkgj0MDH9JcFDZu5Gb3pAqCMZRLtb06uwDm5RJZExpPG
 wwf8ToPGXDl/jQ2C8Q4q7kUW+rTcMGkq5Lir+80OiZcsuxWGNNX9SlsA1MaWBB+LAzvgLK8xAgy
 vc0JCOhmnl4BQRf6vsyFJ9O2GlITuA==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f1c6d7 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=4dggPbQCJsUf7yP8NJcA:9 a=ZXulRonScM0A:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: M1_JTfHju3HFzPpFrTSVS3kkpqeTWcOt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 04:32:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2344

The code "OUTPUT_POLICY=`${STAGING_BINDIR_NATIVE}/checkpolicy -V | cut -d' ' -f1`"
assigns OUTPUT_POLICY with 35 and policy.35 is getting generated.

So, correcting the policy version in semanage.conf file too.

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


