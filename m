Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98561C25B74
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 02:54:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.13831.1716864860498122099
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 19:54:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5878445e50=changqing.li@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44S2dTAQ022310
	for <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 02:54:19 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yb6y5jfgw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 02:54:19 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 19:54:19 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 19:54:18 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-raspberrypi][PATCH 6/7] vc-graphics.inc: WORKDIR -> UNPACKDIR transition
Date: Tue, 28 May 2024 10:54:11 +0800
Message-ID: <20240528025412.2417168-6-changqing.li@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528025412.2417168-1-changqing.li@windriver.com>
References: <20240528025412.2417168-1-changqing.li@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Z9eaLXPFl0xuwwrVhZK_d4hJ3iWKFDm-
X-Proofpoint-GUID: Z9eaLXPFl0xuwwrVhZK_d4hJ3iWKFDm-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405280021
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 02:54:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/228

From: Changqing Li <changqing.li@windriver.com>

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-graphics/vc-graphics/vc-graphics.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-graphics/vc-graphics/vc-graphics.inc b/recipes-graphics/vc-graphics/vc-graphics.inc
index e5e8f53..fd37080 100644
--- a/recipes-graphics/vc-graphics/vc-graphics.inc
+++ b/recipes-graphics/vc-graphics/vc-graphics.inc
@@ -33,10 +33,10 @@ do_install () {
   cp -R include/* ${D}${includedir}
 
   install -d ${D}${libdir}/pkgconfig
-  install -m 0644 ${WORKDIR}/egl.pc ${D}${libdir}/pkgconfig/
+  install -m 0644 ${UNPACKDIR}/egl.pc ${D}${libdir}/pkgconfig/
 
   install -d ${D}/${sysconfdir}/init.d
-  install -m 0755 ${WORKDIR}/vchiq.sh ${D}${sysconfdir}/init.d/
+  install -m 0755 ${UNPACKDIR}/vchiq.sh ${D}${sysconfdir}/init.d/
 }
 
 # These are proprietary binaries generated elsewhere so don't check ldflags
-- 
2.25.1


