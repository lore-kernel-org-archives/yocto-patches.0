Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7564.1794462313647265640
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 21:45:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Pe/4lrf3;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: wenwfu@qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC53iV43476750
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 05:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=w5nxlKJiL3G
	/MxiY9D/GJroAcQunNG9WftnEsjYEhYE=; b=Pe/4lrf3x+skkqklJ5V6kzIVfwK
	TbRL02XorUmBD3UASNx655KXVR2HrMHjbagFxk4M/rInjju6h2cYlAE3XfpEPvOL
	EZclAonxVeusl4ChKITMmMWOdujyRJYvhbGxc1wKoR8/TWXC/DR8qjCrDA4pOsmc
	/fBK3RlP1tMwHbSLgcndP6qiH61hAaSfhh1TeTD701MkUBKWD6URPmDSK2gBW5H7
	UaXAgAvTRbd6bks1LTYAj4CRM7wcYZnEAY6l6CAnL7qzLc8eFO4wX+C9N6x5xJ8A
	JIlqrtMeirQM0Fiv6EM/QJmnaTOEgQVPQr/pJWMGsSHMTk8g0JE38BZnPzA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yug3tx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 05:45:12 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC5jAB53927615;
	Thu, 12 Nov 2026 05:45:10 GMT
Received: from perf-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AC5jAAl3927608
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 05:45:10 +0000 (GMT)
Received: by perf-sh02-lnx.ap.qualcomm.com (Postfix, from userid 3975139)
	id B842DAC9; Thu, 12 Nov 2026 13:45:09 +0800 (CST)
From: Wenwen Fu <wenwfu@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Wenwen Fu <wenwfu@qti.qualcomm.com>
Subject: [meta-selinux][PATCH v3] refpolicy: upgrade to 20261109+git
Date: Thu, 12 Nov 2026 13:45:08 +0800
Message-ID: <19810872a41f8dd6ac59dae1aa8e722866cea603.1794462087.git.wenwfu@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4a8dcdf93c4a51793e95ba1e2ffa9ef1f12a37c4.1794453367.git.wenwfu@qti.qualcomm.com>
References: <4a8dcdf93c4a51793e95ba1e2ffa9ef1f12a37c4.1794453367.git.wenwfu@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: tjaaqKYbF_z4uH5evy48BCcWf-3d6rZH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyMiBTYWx0ZWRfXxeem++TmnXWE
 AzWEWp4y3t5LIkvkzX3mq4+GwOjyR53a/OeQbL/M8ZESa4FqB6553Sgxt5g3IyTcPuDYLiLupQd
 DbISR6TuMUZNjLVjGnci3xgE/cvn1s0=
X-Proofpoint-ORIG-GUID: tjaaqKYbF_z4uH5evy48BCcWf-3d6rZH
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af55268 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=Idlj6A5Ow_XTwSuAyV4A:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyMiBTYWx0ZWRfX/qZZtK05b8Im
 iPDJ0XcWW6YFENHit0H/+hX1wtbejIwaXh2WfLGE+jjEUUmLPIOLH9cW0FhpD3rU+0D2GKOd7/B
 KtP9z6VvlWwM35NAVkCV77P75Ak7NGIFKwvhHmY3jHdReuNcqqbhElAI0/qNdDlYBypLuPmU/KS
 81PgXpaWPPqrnEl7a5PUjt2ckPCmibORMo1lCKxUsaZVW04PrkCRjhhTqasVDe9WFAgwDCYAXrZ
 tELgaR0cynXp6mRypxUbYceB2mkkXRwZg4T7T484Bp69fXkHlVXZvDDcBrmhMGvZh2S3jeQLE8N
 iT+okohBOj11W/Uwi2LURl+O+P8jHxDcGyFz1appgu9PUIV7qRxN4PzZxvRZvd+SXA0O9TvMUAv
 Gkh8zJoRt033wwrtW7u40MJliD/Gy9q/86Gh70XD96/oslLhKaB0y8RMtwzpMlC0m+58VyIjlpt
 G48m3u1Mc7BpS37t7vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120022
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 05:45:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5314
Content-Type: text/plain; charset="utf-8"

* 6072cfa851a3 unconfined: allow perf event access for unconfined
domains

Assisted-by: Codex:GPT-6
Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
---
 recipes-security/refpolicy/refpolicy_git.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index dbc8cc8..de0bb56 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -1,8 +1,8 @@
-PV = "2.20260922+git"
+PV = "2.20261109+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "acf41c52116fef3a9dcd8f1f39b133e0372fce7c"
+SRCREV_refpolicy = "8f247dafb92bd12cbfb53a11ff58be17a88df86a"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.43.0

