Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A597ED59D99
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 11:33:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46345.1765798412448811657
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Dec 2025 03:33:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=er7Vi8yX;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFANsP0594424
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 11:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=S5Lmr6oy5s0KT2NMvEp6REBYBbkIauSUJaf
	LNFv0Oq4=; b=er7Vi8yXhYGm3hdqbc7R5vHPD0ZySEakBAiGO08KAJbjJpI1tvq
	m2FmZaRpikRIZzTm0nzTMTV0pdFNaCMZmi6yKm/fb5yBiCxQmY/iSY9V6fA2OPCT
	yK30zQqKeyF4qC7+KHUQ2mo/lLZtLpjuhzWC1s2kJsA/Pv5/wbAxp0EHXYOOwK5v
	hnrBvWgfBx39Bl5ON15ne67q8G0mf3J+Kp38+qTIhT+Tit+MpBm3yYKJTAOCYYfJ
	Oqf3mdqELfuRrSrk7Ycp3s0F7MVZ6E/vA8Gu9ZEMC0hnypQr3P7DmztbCDoj2V9N
	xb1BFO5jJ8m3XccxkZO0N8se/gvhaq6JA0A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b11dscc16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 11:33:31 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFBXRn7031613
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 11:33:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4b117kx6ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 11:33:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFBXRdc031608
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 11:33:27 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com ([10.213.102.143])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 5BFBXQag031607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 11:33:27 +0000
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4060212)
	id 13651222C4; Mon, 15 Dec 2025 17:03:26 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH] libsemanage: Update policy version in semanage.conf
Date: Mon, 15 Dec 2025 17:03:21 +0530
Message-ID: <20251215113321.3987394-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6jpk1hfey4gl7XVCf7O_ejCoMaK5iYPd
X-Proofpoint-ORIG-GUID: 6jpk1hfey4gl7XVCf7O_ejCoMaK5iYPd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA5OSBTYWx0ZWRfX+PkzbKgQf64j
 NdzRe6crsD9hI/lfNcSEo5+9wlzjyFaugk2INd3mle1pwIh8erGt7kwqwvr5I22r7qz05sPyc+b
 8koz5oIlxw++nWwCz1QjDA0DIuIcCkmFkwbktK/vXttBvuqGHPub28CF14W0n2yvYd+syn6ItpR
 ythzVfeqPVnkB4ehj+e4cWpzgAQlvKjG5+vsLg80l13kDOraLuuxySqiviGbjxCwmMylbQEqT8X
 fVBIX06N+LnucqA8/emaKvnvC7sE4r4aEuQWG0veKwRtl5gsDvTg+b8NPJgVQviGybhXO2SsWc/
 Aog8PIjFzHQV3iupq8Rnsk6AhPmsIOyLBeNJinjAGPDGo3t3c//NGz8rZQyRe6yirJg5jZ2LBtn
 yZqNUPTr45lESBslmIaFssyXZT1VFQ==
X-Authority-Analysis: v=2.4 cv=cfLfb3DM c=1 sm=1 tr=0 ts=693ff20b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=efrCyo2GrwLWaV0AP3kA:9 a=ZXulRonScM0A:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512150099
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 11:33:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2786

Currently semanage.conf file is being updated with
policy version 33.

Update semanage.conf file with policy version 35.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 recipes-security/selinux/libsemanage_3.9.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/selinux/libsemanage_3.9.bb b/recipes-security/selinux/libsemanage_3.9.bb
index 4d2568d..2425a2e 100644
--- a/recipes-security/selinux/libsemanage_3.9.bb
+++ b/recipes-security/selinux/libsemanage_3.9.bb
@@ -47,7 +47,7 @@ do_install:append() {
         PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}'
 
     # Update "policy-version" for semanage.conf
-    sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 33/' \
+    sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 35/' \
         ${D}/etc/selinux/semanage.conf
 }
 
-- 
2.43.0


