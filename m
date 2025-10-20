Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DE3CCD199
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 09:59:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web11.14624.1760954392695027378
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 02:59:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=GeSESKnF;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JLv7b3021064
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mG6TjuZ7EpjRnBkn8vR6/pK1XPDLMluVBzo
	AqxgId6g=; b=GeSESKnFMmXrPW5MGV73BzcQATTJbf3QG8zYN1DkAsCFRlR42ve
	4lyduzLGaiXVbQNCFbtaJLkbG+NWaQELAqicXWnXYfuTtdS6ibNl2J+2rrc12KUe
	BhaA1p4TrbHXqHYX18luBFf2qmWGozMyLdp699YE5jfl3bJA+OtPzhFKa1fUUqYI
	lyQ4s1c7fJvP7RhxWi58CqmqMRh6T7oXMRKfXWRk6ptpg3PdJu7R0kxHGUL6bF+q
	hY8TrJw3Tvkyp6v9LNtSzHHVmj1tkaH/yZWJuVA0cKG/x4D7hbAOjxeAhzyomJ69
	dvQRe/ie6mEjfSsqo/udEHwDEUUSxET77RQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w20f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:59:51 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59K9xmwM026707
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:59:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 49v3ykqpcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:59:48 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59K9xmw4026702
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:59:48 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 59K9xmlH026701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 09:59:48 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id F01055C8; Mon, 20 Oct 2025 15:29:46 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/v2] refpolicy: Correct policy version in semanage.conf as per checkpolicy
Date: Mon, 20 Oct 2025 15:29:44 +0530
Message-Id: <20251020095944.1342658-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uoDnnDfP8-jf2QhUdQYh81gWjiY_Wjab
X-Proofpoint-GUID: uoDnnDfP8-jf2QhUdQYh81gWjiY_Wjab
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX+rAoISM8VE3B
 iOvWhk+Y9NblWOuFFhAmfMDy397blaqwLKp2TJoh1Xo9DOpudi7RzSbdGQwOr3uT1RzZK/rEmdX
 5UzBeNLWLyU6XThee8ymfMn3B0/uuTLjXmR0XUi9/vuh4J+ZgvJjr3LrN8upHQg+oqLhrQUlbFM
 mDqiIUJQNLV1uCF5c0Nh2HyKPg7LULZ3lzfExzz2nTliKjnLryi4S5oyQuQUvJryEir9UOEcaEf
 103Q1dWcv1Yd33y5mChDtgixM+/ycVcGsb5hUUhBPkEqdJ2G5m3qCVrnjJsUj1k5zmkRkjOWHhf
 w8SO48ysiH4xfWpGwbHP9QCmhYbWilkDVPFjA+Glhyqhg2tWHdBDfvQk45pUOJ1r+ObYIHo+Yt0
 vL4054fTY5F25I32+xbWURPlHTG4bA==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f60818 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=4dggPbQCJsUf7yP8NJcA:9 a=ZXulRonScM0A:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:59:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2360

The code "OUTPUT_POLICY=`${STAGING_BINDIR_NATIVE}/checkpolicy -V | cut -d' ' -f1`"
assigns OUTPUT_POLICY with 35 and policy.35 is getting generated.

So, correcting the policy version in semanage.conf file too.

base-commit: b646cb84cb63c6c6d75ad88704755d6126f26fcf

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


