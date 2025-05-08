Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C48C3ABC0
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 02:58:40 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.6924.1746673110446694727
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 19:58:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7223240b2b=changqing.li@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5481IqY9027374
	for <yocto-patches@lists.yoctoproject.org>; Thu, 8 May 2025 02:58:29 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46e430mnd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 08 May 2025 02:58:29 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 7 May 2025 19:58:27 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 7 May 2025 19:58:27 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-dpdk][PATCH 1/2] dpdk: fix deprecate warning
Date: Thu, 8 May 2025 10:58:25 +0800
Message-ID: <20250508025826.4103308-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BajY0qt2 c=1 sm=1 tr=0 ts=681c1dd5 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=0YxdbdRtogARtLBcabsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 3J777z7QcgOSVMn8qbD7iwsNbFoFlHdW
X-Proofpoint-ORIG-GUID: 3J777z7QcgOSVMn8qbD7iwsNbFoFlHdW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDAyNiBTYWx0ZWRfX642CS2Di9E1R KNVxx4DKKeZalbfIoNiHmm2B/o5lthtjzZBHNEfBpPepyrQeMOTmsGAuu7WIQrFroV7KpBeC8kz qCN2sGix4jrzOqaEh/sIkjrxGPbxRyb0CKk7wJFpU5Yt6VXp2n0B9ypmxCD/RyG/ghES74v0UV1
 lu7H/4dmd0ox6wV58FJCYsSzq9JWgFViq1fjGX+AczIWYsYSnyxbI3BfzlK5gbYaF4iOXWuUOu9 ykohiO27Y8/zsfLBX8qlu3wzr8DgWDTy2CWKSXeAJp4ARntMEkEPRXKHiMz1JhkjQrGWiMhePzb ryZLZOL+Hw3vV0tdEWu/vUGsHifdGNqCHkPncaDCMkIjcY/HRzGFaCtvoZVNrT9tYZi7zl0/JS4
 7J8UvwpDiLA1+nmdhFp/R30FWbsqpXSc2rCEcxgg+f4mzO01oApI7vYJOM83ViYwsEKYT1s/
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_01,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=738
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505080026
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 May 2025 02:58:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1533

From: Changqing Li <changqing.li@windriver.com>

WARNING: ... CVE_CHECK_IGNORE is deprecated in favor of CVE_STATUS

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-extended/dpdk/dpdk_22.11.7.bb | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/recipes-extended/dpdk/dpdk_22.11.7.bb b/recipes-extended/dpdk/dpdk_22.11.7.bb
index 32e6a18..e8f159d 100644
--- a/recipes-extended/dpdk/dpdk_22.11.7.bb
+++ b/recipes-extended/dpdk/dpdk_22.11.7.bb
@@ -9,14 +9,8 @@ BRANCH = "22.11"
 SRCREV = "077a7044cc5b2533410f691c8db6fb4f6667b1ca"
 S = "${WORKDIR}/git"
 
-# CVE-2021-3839 has been fixed by commit 4c40d30d2b in 21.11.1
-# NVD database is incomplete
-# CVE-2022-0669 has been fixed by commit 6cb68162e4 in 21.11.1
-# NVD database is incomplete
-CVE_CHECK_IGNORE += "\
-    CVE-2021-3839 \
-    CVE-2022-0669 \
-"
+CVE_STATUS[CVE-2021-3839] = "fixed-version: this CVE is fixed since 21.11.1"
+CVE_STATUS[CVE-2022-0669] = "fixed-version: this CVE is fixed since 21.11.1"
 
 # kernel module is provide by dpdk-module recipe, so disable here
 EXTRA_OEMESON = " -Denable_kmods=false \
-- 
2.34.1


