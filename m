Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F615C83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 06:44:40 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.14949.1752821075855211084
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 17 Jul 2025 23:44:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9294d581cf=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56I5pRV12519206
	for <yocto-patches@lists.yoctoproject.org>; Thu, 17 Jul 2025 23:44:35 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47ybu3r87m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 17 Jul 2025 23:44:35 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 17 Jul 2025 23:44:34 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Thu, 17 Jul 2025 23:44:34 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-raspberrypi][PATCH] udev-rules-rpi: explicitly set PV
Date: Thu, 17 Jul 2025 23:44:36 -0700
Message-ID: <20250718064436.276922-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -yj7p4XnNwvLMdYZZg1Wev9JRzDlgTsY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDAwMiBTYWx0ZWRfX8u4pc5HzIFRy
 5kdqFfLn5FAuzLWMqYyTINEZb7qT4ggFx2/5agxTLjmfRPoi4yphf0XyQioSiFnCfkqLj+EmOBR
 sIeBv7DVmv3oRBzwCkuupI1G7z5LNUyEPvbDspxBWb0Npqy2+Wob904jFwfRlJtHrazeZm+TR7Y
 HhqrEKsklkcvx4dDTqC87412x+N7vmH7vUXHG3as1/gIWPOttBn+FVBRCclgihm4MODlgjkJ4WT
 VgtnoZ4WN1/7+ojKnlXTpCuKt/08Fv69Ulx4vwxTIofugzNIC3aCCPTAOXiYWAlPFRHlxtTSUUk
 nl6kBmNoO2KrKny1TJ0DSABfPBN2+ifTTtSu5axm+EFDfzt/neGrziP5Mupu5NF2rRzVDl+ATsW
 qnncmWwU
X-Authority-Analysis: v=2.4 cv=MYVsu4/f c=1 sm=1 tr=0 ts=6879ed53 cx=c_pps
 a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17
 a=Wb1JkmetP80A:10 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=t0O0ImGy9pfMJje_gWMA:9
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: -yj7p4XnNwvLMdYZZg1Wev9JRzDlgTsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507180002
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 06:44:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1808

Due to commit [udev-rules-rpi: Use 99-com.rules directly from upstream][1],
explicitly set PV for recipe other than using default 1.0

[1] https://git.yoctoproject.org/meta-raspberrypi/commit/?id=492cb5a5d974035667b892515edfb909edc6c953

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 recipes-core/udev/udev-rules-rpi.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/udev/udev-rules-rpi.bb b/recipes-core/udev/udev-rules-rpi.bb
index fa9344a..14607c3 100644
--- a/recipes-core/udev/udev-rules-rpi.bb
+++ b/recipes-core/udev/udev-rules-rpi.bb
@@ -7,6 +7,7 @@ SRC_URI = " \
 	file://can.rules \
 	"
 SRCREV = "5ce3ef2b7f377c23fea440ca9df0e30f3f8447cf"
+PV = "20230510"
 
 INHIBIT_DEFAULT_DEPS = "1"
 
-- 
2.49.0


