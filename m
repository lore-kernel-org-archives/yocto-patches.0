Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6806103A99F
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:36:59 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13980.1774406211646365400
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:36:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=oWxPjE+o;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P1aPwr032477
	for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Mar 2026 19:36:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=GcXgpunLjE3SsgbwKaFH
	+XOIu3Cw2We71NayTtB2+eE=; b=oWxPjE+oXhT270MwhmswaXXN7fU8kVgExFN7
	7fs6Rkga0sIwQfe8lcNAQsN9ZI0DTe3UH3GIIUELzbb1q0z8kvABXvDo4AW6Hlx6
	RoGEihAfIJ6kCmiTt12/51d9RQ+E0GKeDVLk/PLRoSDOr5JgfioFMosgXF7jsBgm
	yNxP8KMb44UwCRN2YN+om1sFQDxP8IBJP5DJOzOw0P7Hb5m10+seXlEjFtzxSh8X
	/n+7Ovr8TDkm4KKFPvvx4n54cDNpGV7r8i0/v1025I1kCTFl97pQi6AeqkUPtx7P
	I2eEx/qtw/jrCaaCXHKMemXPSnOFXjY6FTc1VEpEg4VPiUnLQQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1tucv318-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Mar 2026 19:36:51 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:36:50 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:36:50 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH] layer.conf: Update to wrynose
Date: Wed, 25 Mar 2026 10:36:49 +0800
Message-ID: <20260325023649.3225348-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EfoycSfEJsQI4urqez1hLHRRHSJfyE3H
X-Proofpoint-ORIG-GUID: EfoycSfEJsQI4urqez1hLHRRHSJfyE3H
X-Authority-Analysis: v=2.4 cv=deCNHHXe c=1 sm=1 tr=0 ts=69c34a43 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8 a=bNEOkg78zBUIhLwO1dcA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxOCBTYWx0ZWRfX74yHqiKtjgja
 T02FS5X5ho50Us3yVQZshI0Xr2sGMVIr8HFf5xJlB7YiuAJVRnNDE8gXpfOoLnzMM3QJkDuzr0/
 tyTZp243IUBB8Aa13KKGsXJUIO84kIBtR8afmexlXvZSkhim6ftqZtyen9YdDeexVwMVOEXkLCD
 bizUns6WBEpUlYsm08PXOJGKE0gKnDRI6DNo6fBGkpWQQ5Sk+VxxwLrTkPUDO5b0gFC2EfP59tB
 04WoUWVgIaPLkXJ0v5n9UM4kcDmVSvuq5yyXRCwX5bwXKl1xkAzaHTbGhbfBIBKRnNo1fPZbqym
 PyszuZzp+dTvRrsUcnT7xVvyA1N1C/BOv2VKlqnC6+9AfLAsofTZ1+s9WnzHvH68FoS/lLQaPZW
 rFumC2xlbiEuli83dSBpFB/DZy25w0LgF8+hgEydsTsfbEsoAZYMowA8gLSrc4tPw7DdxvdjNce
 ol8mEHIRUVnjsjJdg/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250018
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:36:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3551

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 8ea32c4..c3bd464 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -11,7 +11,7 @@ BBFILE_PRIORITY_meta-tensorflow = "10"
 
 LAYERVERSION_meta-tensorflow = "1"
 
-LAYERSERIES_COMPAT_meta-tensorflow = "whinlatter"
+LAYERSERIES_COMPAT_meta-tensorflow = "wrynose"
 
 LAYERDEPENDS_meta-tensorflow = " \
     core \
-- 
2.34.1


