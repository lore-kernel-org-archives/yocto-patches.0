Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19907C369AB
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 08:38:43 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.10537.1745483916089339536
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Apr 2025 01:38:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=62098bb84e=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O4rpvC026996
	for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Apr 2025 08:38:35 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jh61yxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Apr 2025 08:38:34 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 24 Apr 2025 01:38:33 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 24 Apr 2025 01:38:33 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH] python3-yamlpath: Add python3-json to RDEPENDS
Date: Thu, 24 Apr 2025 16:38:32 +0800
Message-ID: <20250424083832.1352716-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zTrZ1VxUalXh61F0hfA9VlYV-vIxRrEX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1NiBTYWx0ZWRfX50BGU0jO+999 oju6P/LpINroAE3+kH2y293WER/W6mHwc7GBhc0wQQUFYKcsUt8Reijfeqy0jHbYYQ9iPQ8GnnT TW2d7fXQEotRyn0FwBacGmb7gFUv/iDZyc28KLjxpWLkV0XLkwaQHAVjh9Reh1NCisAJUOxqpsP
 +my9XRsJZ4XFPI8zUEYb7OrBRmnuhrMPzkaicfIibrGrHV16sdD81niNYIrJracwfaPB3bMt4lZ DGrUx/PtaLIieabmVNUEJTF9cBPEpkBPE4lYXjwHkRGAI//fbZoRDxT1+2t1zlG95o6UeghOA1V 0a2bRiv1t7sacHJjIeytRXclFzxqf2JJvld/9tI15g/ola2RpRO4KS7RHczY2+r3kGx5VFIglgh
 YtikK0LQeZJo5FrR/vS6b2szUJfCPYj2GefgkPLp9ajs0tH8gpifmUfWTXYkGRbfwy/L495g
X-Authority-Analysis: v=2.4 cv=Lu+Symdc c=1 sm=1 tr=0 ts=6809f88a cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=XR8D0OoHHMoA:10 a=t7CeM3EgAAAA:8 a=_XXegROKa_Psz-OiT2cA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: zTrZ1VxUalXh61F0hfA9VlYV-vIxRrEX
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=953 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504240056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Apr 2025 08:38:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1400

From: Changqing Li <changqing.li@windriver.com>

* Some sources like merger/merger.py import json, so add
python3-json to RDEPENDS

* Fix following warning
has a lack of whitespace around the assignment: 'DESCRIPTION=xxx'

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 .../recipes-devtools/python/python3-yamlpath_3.8.2.bb          | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.2.bb b/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.2.bb
index e2d95ae..5d9258b 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.2.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath_3.8.2.bb
@@ -1,4 +1,4 @@
-DESCRIPTION="YAML Path and Command-Line Tools"
+DESCRIPTION = "YAML Path and Command-Line Tools"
 LICENSE = "ISC"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=5abda174c5040dd12ed2b225e3a096f0"
 
@@ -15,4 +15,5 @@ RDEPENDS:${PN} += "\
    python3-datetime \
    python3-ruamel-yaml \
    python3-dateutil \
+   python3-json \
 "
-- 
2.34.1


