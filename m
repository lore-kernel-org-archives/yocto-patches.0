Return-Path: <haiqing.bai@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAF0ED7B92
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 09:22:18 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14698.1776158531135789841
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Apr 2026 02:22:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=LqwMqkg3;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85643c0fe9=haiqing.bai@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DNiTfw1269595
	for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 09:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=4uBd4qjLjvjKGFCw3KtI
	ywCuhF0AkAsCh96iahbABao=; b=LqwMqkg3imdF3FUGFRTrzrkbgknTUqZ/lfy/
	CcdmaTbIDfR2R5irqd4IDz88U2j+l8SBnSk2+L4zC3QzEKjxpJLLWFJw2spTTjP0
	xUxpXGX5OakykysxlnEKcTo3o9Bix7ErhWg7+4SRgkZtU/uUMs5etTfrFqSVrwSQ
	p4R7hvzxsfa+JMIBzPtiIvdG5ARjWMUhKKZRd/lCZC7VuZpwnnLGHEwbBdpASI83
	QsUfGs0tUY1OEuiMAA4KKn3ZjtCXdYfcMaLm69SqUX/1sAR3eI0vRYAf69KPqtyI
	2oH5o8JdEgXaaJ1z1CPJjC7DKTrHfkl5KJDY8EoclLfpyHmUFw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dh877gh89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 09:22:09 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 14 Apr 2026 02:22:08 -0700
Received: from pek-lpggp2.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 14 Apr 2026 02:22:08 -0700
From: <haiqing.bai@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH] isic: fix RDEPNEDS typo
Date: Tue, 14 Apr 2026 17:22:07 +0800
Message-ID: <20260414092207.1915814-1-haiqing.bai@windriver.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2tZGiN_-xQLL9vXw19_zDU8YlmjaRyls
X-Authority-Analysis: v=2.4 cv=ZtHd7d7G c=1 sm=1 tr=0 ts=69de0741 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=nftxCnANBx9OJ7JKsVYA:9
 a=ZXulRonScM0A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 2tZGiN_-xQLL9vXw19_zDU8YlmjaRyls
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA4NyBTYWx0ZWRfX4Nwf0rkyiHiv
 pB/MM9utSoLiAHXD39Y4Z9KcZGuWKcwLFF34H10z3NZmmmAIZceX7EZcGWbvh++MOyOaLNyNrVr
 gXy86NXFnrD2KjSzBv0axd7Ziww9sWKnQM+AsDd2pyfjrmA8PYKWN2g+OGPliyEDznGuXPGGw9u
 GiJX26Tq9mg7vCaHcgIuE5d7aEsNoGhyOnlKC6ohSJ4UodVrwOirEPCSVEj9z/7hvJSRF6eqp8Q
 V4Vhu7pA3kdp1uDeemnLoMyPIZtmcZrxg0sm432f5mX/m6Nojn+YqT8yRJlg0hHLsIec8pGOckD
 Flc95j2fP+wDddHRwk30/m3svo1UIsObt/ljD1x1x/9HVPMscKXabNCDSO86YJlpFHucPZzSOfv
 L+ipzPE0g8NWpPch6kJOU+fcSGKxXuGDaYwzhbq8xQumu5wn0tnBIV4GuA1wAwVSDZU36g9Cmpo
 qDv+ZkbjrEdHAhd1GVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140087
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 09:22:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3701

From: Haiqing Bai <haiqing.bai@windriver.com>

Fix typo: RDEPNEDS -> RDEPENDS

Signed-off-by: Haiqing Bai <haiqing.bai@windriver.com>
---
 recipes-security/isic/isic_0.07.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/isic/isic_0.07.bb b/recipes-security/isic/isic_0.07.bb
index 8e0f5ce..ac637b8 100644
--- a/recipes-security/isic/isic_0.07.bb
+++ b/recipes-security/isic/isic_0.07.bb
@@ -31,4 +31,4 @@ do_configure () {
     oe_runconf
 }
 
-RDEPNEDS += "libnet"
+RDEPENDS += "libnet"
-- 
2.43.0


