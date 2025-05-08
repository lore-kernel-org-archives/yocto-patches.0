Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1635C3ABC0
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 02:47:39 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.6712.1746672454259957014
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 19:47:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7223240b2b=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5482DGif014533
	for <yocto-patches@lists.yoctoproject.org>; Wed, 7 May 2025 19:47:33 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46dee3d8rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 19:47:33 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 7 May 2025 19:47:33 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 7 May 2025 19:47:32 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-anaconda][PATCH] core-image-anaconda: Fix lack of whitespace around assignment warning
Date: Thu, 8 May 2025 10:47:31 +0800
Message-ID: <20250508024731.4030772-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NIL1lGdVLMAo-mcsuTW0XyytadFXKOPm
X-Authority-Analysis: v=2.4 cv=Pd3/hjhd c=1 sm=1 tr=0 ts=681c1b45 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=880Hzrme4pSuv9t6iRsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: NIL1lGdVLMAo-mcsuTW0XyytadFXKOPm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDAyNSBTYWx0ZWRfX8/a0c7K54ITf avVUlhLlUOjrRQsq3Eub924UcIwcWOwJJ5wwOHgOi1Qz01f6juIZ0MldYoP79M0dARwEeLPojJQ Ud+kFHQ5tfH1SdWclSkZQL23O2wTfryVkB+TB4lL31n9XN2e1lVfvBz3RMu/84r+ykJ/SOtOSCv
 RrsJ6oR0IffPfEzmn/oXJ+B4O1c+Zsodqi7pyEVlF0vKp8OUPv5FUkx6Zk0FxvkYYt8DHjCp7rq rBXjJrNkpDrMBa4CPr1lGs1dze6gzLHIgw4Wmdqoa1Ll07QM4IS+NWBeIS2f10o8sUvyPUNakBK BUEHRC/e8b5FFh/tF0xchDYNkEDNs0jODD21Z9XcjCCfY3JZYYK5s7o4gMnFze80WP8FANp+ZtD
 LPZ2s5rcDznKc2Mibjnq3ngF5PVjMAEtD2UmUEhJEVx79aDeoFrXW24HfYgkPI6E4qotCfm8
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_01,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 mlxlogscore=775 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505080025
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 May 2025 02:47:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1532

From: Changqing Li <changqing.li@windriver.com>

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-installer/images/core-image-anaconda.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-installer/images/core-image-anaconda.bb b/recipes-installer/images/core-image-anaconda.bb
index 68c3bbd..399cbf7 100644
--- a/recipes-installer/images/core-image-anaconda.bb
+++ b/recipes-installer/images/core-image-anaconda.bb
@@ -29,6 +29,6 @@ IMAGE_LINGUAS = "en-us en-gb"
 IMAGE_FSTYPES:remove = "live wic wic.bmap"
 IMAGE_FSTYPES:append = " iso"
 
-IMAGE_ROOTFS_EXTRA_SPACE =" + 102400"
+IMAGE_ROOTFS_EXTRA_SPACE = " + 102400"
 
 inherit core-image anaconda_image
-- 
2.34.1


