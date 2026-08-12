Return-Path: <rchiluka@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE44C5B56A
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 06:01:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1801.1786514455447613653
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Aug 2026 23:00:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=kga42r6B;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: rchiluka@qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C5i1KD1678044;
	Wed, 12 Aug 2026 06:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bk6ZL71quaCH/7d/Z0UtOMurTTlY+gs0cnj
	sq/svV2g=; b=kga42r6BqP/UmYXkaem3OhtBZnNpW9Y4l31xmkDCcS1spJf8Wwq
	z4nc7BZw8vWKorGzMH+EsGCDZg8MIWslPcDKxyjqKnfT5o5YvxBHOPU2/qPrQdCh
	2XewaD99AIxJuPEwx6ZkMdiv6+7yYqA0zWzj+hRahPsqSca0DqrdNIeqNYDmH2qm
	C2MP4DpBne+xYjjgSrW8zvpXjWinVWBUgf02F4egEFEUn+EmvCdBJRULR0klEjQt
	Z6zHsckukMru8GgBcDDhtgtnhXdkgdJT2UqMOoiv1MOlEaBEt/YpLuUpF6NDmYfX
	mFCxyfFMtcJrpEfa8xXy9cd3bFzR61fVznQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hfw0ax9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 06:00:53 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C60ot9013463;
	Wed, 12 Aug 2026 06:00:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4g0bs2dtdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 06:00:50 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67C60osp013458;
	Wed, 12 Aug 2026 06:00:50 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-rchiluka-hyd.qualcomm.com [10.147.245.147])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 67C60oA6013456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 06:00:50 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4746761)
	id 6A54364F; Wed, 12 Aug 2026 11:30:49 +0530 (+0530)
From: Chiluka Rohith <rchiluka@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com, yi.zhao@windriver.com,
        rchiluka@qti.qualcomm.com
Subject: [meta-selinux][PATCH] refpolicy_common: strip POLICY_CUSTOM_BUILDOPT before passing to make
Date: Wed, 12 Aug 2026 11:30:45 +0530
Message-Id: <20260812060045.244559-1-rchiluka@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0NSBTYWx0ZWRfX8InHNeskfnc9
 LCVMTnrCAFwNGfozJbt/AKMcOUJhQe4+KaArBcrrF3dR9DRQhrPLR3hCwynq5IBkSPG1Vw6kjTk
 vKo3BqRjKTm8c5lk3txqC4yoRWQ0TxQ=
X-Proofpoint-GUID: Gob3lZHWbork4I9yg5ByIfAmRwisnaKG
X-Authority-Analysis: v=2.4 cv=fpDsol4f c=1 sm=1 tr=0 ts=6a7c0c16 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=u4Ef-fn88yQwT9K9ZQ0A:9
X-Proofpoint-ORIG-GUID: Gob3lZHWbork4I9yg5ByIfAmRwisnaKG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0NSBTYWx0ZWRfX30kP1kCTNZDf
 0fjJknJkOqhnCFj0ga+4ybHmvBAHGpTBD1SVv8rVo/7pHpKPYsS3tyOrBhSxclbcKEUtcrr6eF/
 Y4LufCO2K9Asp+SiMx7WEcuHY9y2+TPLryCqStXxlD+gcYb9tiaiDRrsHQSaUAv3Q+q63VxaPfw
 hKVryvFHaq7hTxcw67pq74bff8hvy6ONFg1TSsuxiefk8wR3+mtJ8an5HlOs3MO392zSqmcNja9
 m3KCyQ7eRWxB/6moZCZI5YDPoHf8MTkTsnhrxMqd9hCeA49JKiF8UqE2I7TLzD/CJrbhE5XDGuz
 OKCOvtRDmvCJEE2yjazZjjnyU8VAqgeIow3GTJqzGcWA4g30Bt4quOHbv8iTYCMIxityOKbORqS
 mO04pkUBkJYlVRTgQMOQcHIKzKDWcTgMYXDnlUatR6x0eQyb1OZSuA6PzlDk8Hwulozlxcg1zJW
 PMWOAf5FS7XzbbzQNkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120045
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Aug 2026 06:01:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4658

POLICY_CUSTOM_BUILDOPT is passed directly to the refpolicy make command
as CUSTOM_BUILDOPT. When layers use ':append' to extend this variable
(e.g. POLICY_CUSTOM_BUILDOPT:append:distro = " option"), BitBake
introduces a leading space. Passing that raw value to make causes:

  make: *** No rule to make target 'option'.  Stop.

Signed-off-by: Chiluka Rohith <rchiluka@qti.qualcomm.com>
---
 recipes-security/refpolicy/refpolicy_common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 014714c..1566591 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -126,7 +126,7 @@ EXTRA_OEMAKE = "NAME=${POLICY_NAME} \
     DIRECT_INITRC=${POLICY_DIRECT_INITRC} \
     SYSTEMD=${POLICY_SYSTEMD} \
     MONOLITHIC=${POLICY_MONOLITHIC} \
-    CUSTOM_BUILDOPT=${POLICY_CUSTOM_BUILDOPT} \
+    CUSTOM_BUILDOPT=${@d.getVar('POLICY_CUSTOM_BUILDOPT').strip()} \
     QUIET=${POLICY_QUIET} \
     MLS_SENS=${POLICY_MLS_SENS} \
     MLS_CATS=${POLICY_MLS_CATS} \
-- 
2.34.1

