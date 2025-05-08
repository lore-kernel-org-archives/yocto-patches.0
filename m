Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B86C3ABC3
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 02:58:40 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.6925.1746673110781451410
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 19:58:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7223240b2b=changqing.li@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5481IqYA027374
	for <yocto-patches@lists.yoctoproject.org>; Thu, 8 May 2025 02:58:30 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46e430mnd4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 08 May 2025 02:58:29 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 7 May 2025 19:58:28 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 7 May 2025 19:58:28 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-dpdk][PATCH 2/2] dpdk-module: Fix lack of whitespace around assignment warning
Date: Thu, 8 May 2025 10:58:26 +0800
Message-ID: <20250508025826.4103308-2-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508025826.4103308-1-changqing.li@windriver.com>
References: <20250508025826.4103308-1-changqing.li@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BajY0qt2 c=1 sm=1 tr=0 ts=681c1dd5 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=880Hzrme4pSuv9t6iRsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: tcoYaOHRvOpqk7lNG-3SRWEfk-W11Vfo
X-Proofpoint-ORIG-GUID: tcoYaOHRvOpqk7lNG-3SRWEfk-W11Vfo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDAyNiBTYWx0ZWRfX/DSNAoHKmOS0 bClijoZkSJ5QVJU9j7a7rxsl1+iMZn7FmZiZfHveHMLYeW6KhYqgUfxYBqJqjTy/lMK/ta5KeC8 NRxos/yzlpH0/PBkBK6Jh4undhEH0fg8Cyat+RUQgCdRkSIpo4y9dDgYvWg/8ZW++VEncvpDpcz
 weWEZhV6tGKjWY19zrCAtuWslIjuIN3u1R97t7gvMMEpUPtsejQwfPjekM3TJNlqcAg6JaUD30F mSFRDeuDtvkGAr7vIz5wTalK+V5GNs+uunBMI/25oVy9OyzCcHxQS0WjCHz1ewR4+tLFAW8XzK7 5NB9VbWPOQ/UfTNgZmFaYiuihFlS7rkChuAShoZwJVk3h7V6waDuSt7CmrFIRZjU8oZXDE0sfac
 z1Hm37KGAC40K5JQT5bUCyswt3VJHa5yressbUaWODlaTG1PFfgQHvKKfUAHjyNcVXOWSj2Z
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_01,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=841
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505080026
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 May 2025 02:58:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1534

From: Changqing Li <changqing.li@windriver.com>

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-extended/dpdk/dpdk-module_22.11.7.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-extended/dpdk/dpdk-module_22.11.7.bb b/recipes-extended/dpdk/dpdk-module_22.11.7.bb
index e8973b1..0ad93e5 100644
--- a/recipes-extended/dpdk/dpdk-module_22.11.7.bb
+++ b/recipes-extended/dpdk/dpdk-module_22.11.7.bb
@@ -22,7 +22,7 @@ COMPATIBLE_HOST:linux-gnux32 = "null"
 export S
 export STAGING_KERNEL_DIR
 export STAGING_INCDIR
-export INSTALL_MOD_DIR="dpdk"
+export INSTALL_MOD_DIR = "dpdk"
 
 do_configure[noexec] = "1"
 
-- 
2.34.1


