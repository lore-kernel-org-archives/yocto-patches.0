Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54F0C71157
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 13:29:56 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.7395.1750253387573228379
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Jun 2025 06:29:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8264e32d1b=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IAmJtK025230
	for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 13:29:46 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 478xa1mmyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 13:29:46 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 18 Jun 2025 06:29:45 -0700
Received: from blr-linux-engg1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Wed, 18 Jun 2025 06:29:43 -0700
From: ssambu <soumya.sambu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 2/2] python3-grpcio: fix unsafe include path error during cross-compilation
Date: Wed, 18 Jun 2025 18:59:37 +0530
Message-ID: <20250618132937.4119240-2-soumya.sambu@windriver.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20250618132937.4119240-1-soumya.sambu@windriver.com>
References: <20250618132937.4119240-1-soumya.sambu@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PuiTbxM3 c=1 sm=1 tr=0 ts=6852bf4a cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=KuCMGVAfJcUA:10 a=6IFa9wvqVegA:10 a=t7CeM3EgAAAA:8 a=NbQ1gYGxhTRCMyXrK64A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: iNJ-V6hSuMWKzJaUBcdBqRlM9keJBzWR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDExNCBTYWx0ZWRfX02hmBKSs2h+H yrk5RyWna5o9e0mIkFB2J7j9sov7o9XYlAJ3l6pbBRVPjfmep02hqKeuL9OedzC5hhgOSKZsGMQ 34iMaccfTNv21BupPPiYtUmQK81+PLegiRVTRuUgk+QFMzMCuwbI8J/o74v7fyrgRLzg96i+Mfa
 0CMEvvJpN/90rd1PD8tTOR9iep2GbllGqNy0WPSuZ8o2pDzv+HI7Ev4WDn0M3MtjnMlbfsWl+o0 JaGIlVa9BFrlXf9/wJyClKOlEM8MmrrXu3zojaKIN7yhpMMmQjX95oPu2rem/Zrt2gS5AgnJCge IcTSKAZawOAe5K4DS8jOotB8voxa6FyaDyU9A4NRTrI+nUvu6WVSiGVtCac5a3sruPRCpWKsKEv
 uytUBlhJtk0/fQ/g7ENA1nH7GtYMkkI2JYaP6uHbOgvVEzNugMamstSzsp4SRiEkLBfQKPza
X-Proofpoint-GUID: iNJ-V6hSuMWKzJaUBcdBqRlM9keJBzWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=955 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506180114
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 13:29:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1660

From: Soumya Sambu <soumya.sambu@windriver.com>

After meta-lts-mixins introduced a newer setuptools, python3-grpcio is failing
to build due to unsafe include path

cc1: error: include location "/usr/include/python3.10" is unsafe for cross-compilation [-Werror=poison-system-directories]

The issue is resolved by explicitly forcing setuptools to use distutils

Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
---
 .../recipes-devtools/python3-grpcio/python3-grpcio_%.bbappend  | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 dynamic-layers/meta-python/recipes-devtools/python3-grpcio/python3-grpcio_%.bbappend

diff --git a/dynamic-layers/meta-python/recipes-devtools/python3-grpcio/python3-grpcio_%.bbappend b/dynamic-layers/meta-python/recipes-devtools/python3-grpcio/python3-grpcio_%.bbappend
new file mode 100644
index 0000000..bd0b910
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-devtools/python3-grpcio/python3-grpcio_%.bbappend
@@ -0,0 +1,3 @@
+do_compile:prepend() {
+    export SETUPTOOLS_USE_DISTUTILS=stdlib
+}
-- 
2.40.0


