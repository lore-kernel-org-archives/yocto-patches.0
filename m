Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728A3CCD193
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:27:34 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.web10.12427.1760945244984634530
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 00:27:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=MPVP5e8Z;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JMs095012725
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Uu7fPW8vHRdM/SBl7OyF7g7LyFWJC8Hb74k
	fXRnXKrA=; b=MPVP5e8ZrrFtWMaFO0NjUioFB4Kl92jVe98zw+ase5eZWpxG3kb
	6FBHD6MIb+jga9rKEyuCALrlRmT6SyEzz/3454917J2iYydQ13EoRMu1ha6WMue5
	H1awihS1GjdWXUJdx4gcjfVGng7tAXPa+NMJ1XwnOeZ3yQvZKa3p8LfeQORNxKpy
	1SrJR64zfXCNA7d04s1QIaBX4RJd0nAp0MWDCof90EUZCbTjeoZbYQ1zxI9AuXKa
	qS08Aq47TtH27m6WWhbWuOpNSOGzh6t+g53A0OiNFHwX9Zl72RCIhXOXOBM1GKCq
	mOAot8/isXjf+m+yyGOnWyJv1OHX90PWjtA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3983w52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:27:23 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59K7RKZO015220
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:27:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 49v3ykq5xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:27:20 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59K7RKNB015214
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:27:20 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 59K7RKXb015213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 07:27:20 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id 159815C6; Mon, 20 Oct 2025 12:57:19 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH] refpolicy: Correct policy version in semanage.conf
Date: Mon, 20 Oct 2025 12:57:16 +0530
Message-Id: <20251020072716.1253704-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=KcvfcAYD c=1 sm=1 tr=0 ts=68f5e45b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=4dggPbQCJsUf7yP8NJcA:9 a=ZXulRonScM0A:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNSBTYWx0ZWRfXwWNJEdmtyiYK
 ztuqq75liyiaDTw496IfYMo/vLkxktyGyCHfW54uZrwdHdMZvgcUvUN+OzxuSexAgaQRPwzzY8p
 rEXDOMdnsUN4fkssJxDWxKsCGwapdRVGbBZVcdlGhFBQviOXQCzU/WtY7PnHl16PEiBmiHnUMtC
 0uBSLn2i30TY4S2Hr3czDbOH+AMuX7GT04KqPxYqVlhSL6dqeeQnvFsCdnZrV+7jZqCTihEaZBP
 wRdwlqqfssmUau96IO/oCC322bzTmb6iW95pBu2Zio7KcO0WG+gLFWYvZk4XAKUp1DlMg0rOa7t
 CjQfffI2yvpMgAqx2Xe6Zxq2KLq5lI18GwBPgkH4Uh1x56htpovTOyCp6Wl4bcTyUm/1mOXoBVw
 mNdwvGWX9oYrQwj3LNTHzTDqd6VOoQ==
X-Proofpoint-GUID: rvqm5LgANsBXXKRgcZzNrw5sKwEExOgq
X-Proofpoint-ORIG-GUID: rvqm5LgANsBXXKRgcZzNrw5sKwEExOgq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180025
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:27:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2354

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


