Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2109CFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 10:51:25 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16050.1764240682862716487
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 02:51:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=APUvJJTU;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARA3Zqu848490
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 10:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vs8oUXv8st3+HUbl/ZQkAChtdJoD4HHGkRE
	yxXQ7u0Q=; b=APUvJJTUyk51k+uI28kP5FVFPNd+Lae9q82SGS/hHb2633zWOmN
	Uj6c3PO5f376ca5o9FfNv+II7RvoRKl0zcaADGL5SDjcqHO+rpZuWhssTYBR4D/4
	LBsnd9zpJ+trqhqLeLgj4RMzUJHg65WrVicPQzTdg1eIKSXYkWc/Clq3/f60c79X
	OiKc/JhfbwuVEGefEl8m57S9LixKYdX4kdY1yN19iW52uWb0oedpEz28yVXBDTQG
	Y6lHVXVCngvuLoll0QpnX8aaKUi0Rh/85lkZeKJKmr9yn8T93YhIisP4mI7Ozrpv
	e7xln3EZUU5eM2rBPbwDZCwggjCihTS0WOw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apmjd84ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 10:51:22 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARApImf013860
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 10:51:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4anw4td17s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 10:51:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ARApIEL013854
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 10:51:18 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com ([10.213.102.143])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 5ARApIt0013846
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 10:51:18 +0000
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4060212)
	id 9838C22C5B; Thu, 27 Nov 2025 16:21:17 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>,
        Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH] selinux-image: Preserve SELinux contexts in tarballs
Date: Thu, 27 Nov 2025 16:21:15 +0530
Message-ID: <20251127105115.1117972-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FyYgwXjo016k8OVyOCOsndaJVEsfmyIH
X-Proofpoint-ORIG-GUID: FyYgwXjo016k8OVyOCOsndaJVEsfmyIH
X-Authority-Analysis: v=2.4 cv=OPcqHCaB c=1 sm=1 tr=0 ts=69282d2a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=5qLIeR6mRl4NnFiFA20A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA4MCBTYWx0ZWRfXzXzTolpjNaXe
 Au5zek0Zsk0Mc62PDld5nLYk1MyEcR83TZ1XzYbUePcFtgSMHb4QkoVAd8HoLZWwIeMQXSOIWWc
 PkjmIh/AQ6p/DQ+71TxY/KCWHj9WaiZ8lYR7ci+he4f8vnsvNXYZi+FPDOWI0F1Cz1oAZEkZu96
 5VzddzsSQV95xh6xvvDO0maZMwRSse5uDOX6SIl1aO1mw5ZxWb+A+2lj+xR+LIZGdfqFNAiXd32
 pallbr4W0hOLPmqTslOOHgwiU75pDL7+T7G6giw1XVDDO6ncp1hP1gal3/wh275NZ+qaycV0+6L
 /jOsjdMEjVTlKaO45qifKpKgWkTBmXJEUkD51wE1E9DItIygYsdtvPYyeVaREpXo2CjAlAg+Zl2
 g0gUSeFyEoPzx7Lv8mp6urIc9Bqfuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270080
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 10:51:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2717

From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>

Tarball images were created without SELinux context information,
causing loss of security labels during extraction while working with
features like:ostree. This breaks SELinux policy enforcement and requires
relabeling after deployment, adding runtime overhead.

Append "--selinux" to IMAGE_CMD_TAR to include SELinux file contexts
when generating tarball images. This ensures security labels are
preserved across image creation and deployment.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 classes/selinux-image.bbclass | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/classes/selinux-image.bbclass b/classes/selinux-image.bbclass
index b4f9321..852db5f 100644
--- a/classes/selinux-image.bbclass
+++ b/classes/selinux-image.bbclass
@@ -26,4 +26,6 @@ python selinux_setlabels_handler() {
 addhandler selinux_setlabels_handler
 selinux_setlabels_handler[eventmask] = "bb.event.RecipePreFinalise"
 
+IMAGE_CMD_TAR:append = " --selinux"
+
 inherit core-image
-- 
2.43.0


