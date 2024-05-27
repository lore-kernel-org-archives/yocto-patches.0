Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DC2C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 05:31:11 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.21434.1716787865783767165
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 May 2024 22:31:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5877813c0a=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R5UEoa010373
	for <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 22:31:05 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ybb909bya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 26 May 2024 22:31:05 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 22:31:04 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 22:31:03 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-aws][PATCH] aws-c-common/aws-iot-device-sdk-cpp-v2-samples-mqtt5-pubsub: WORKDIR -> UNPACKDIR transition
Date: Mon, 27 May 2024 13:31:03 +0800
Message-ID: <20240527053103.3170127-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5-fG1g17qQCqErslbkqhDozd92UFrAiM
X-Proofpoint-GUID: 5-fG1g17qQCqErslbkqhDozd92UFrAiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=994 mlxscore=0 clxscore=1011 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270043
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 05:31:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/207

From: Changqing Li <changqing.li@windriver.com>

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-sdk/aws-c-common/aws-c-common_0.9.19.bb                 | 2 +-
 .../aws-iot-device-sdk-cpp-v2-samples.inc                       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-sdk/aws-c-common/aws-c-common_0.9.19.bb b/recipes-sdk/aws-c-common/aws-c-common_0.9.19.bb
index 33e5e303..fbef04f0 100644
--- a/recipes-sdk/aws-c-common/aws-c-common_0.9.19.bb
+++ b/recipes-sdk/aws-c-common/aws-c-common_0.9.19.bb
@@ -46,7 +46,7 @@ do_install_ptest() {
     find ${D}${PTEST_PATH}/build -name "*.so*" | xargs rm -rf
     find ${D}${PTEST_PATH}/src -name ".git" | xargs rm -rf
 
-    install -m 0755 ${WORKDIR}/ptest_result.py ${D}${PTEST_PATH}/
+    install -m 0755 ${UNPACKDIR}/ptest_result.py ${D}${PTEST_PATH}/
 }
 
 BBCLASSEXTEND = "native nativesdk"
diff --git a/recipes-sdk/aws-iot-device-sdk-cpp-v2/aws-iot-device-sdk-cpp-v2-samples.inc b/recipes-sdk/aws-iot-device-sdk-cpp-v2/aws-iot-device-sdk-cpp-v2-samples.inc
index fd94e756..f90918aa 100644
--- a/recipes-sdk/aws-iot-device-sdk-cpp-v2/aws-iot-device-sdk-cpp-v2-samples.inc
+++ b/recipes-sdk/aws-iot-device-sdk-cpp-v2/aws-iot-device-sdk-cpp-v2-samples.inc
@@ -3,7 +3,7 @@ DESCRIPTION = "The AWS IoT Device SDK for C++ v2 provides MQTT APIs for C++ appl
 HOMEPAGE = "https://github.com/aws/aws-iot-device-sdk-cpp-v2"
 LICENSE = "Apache-2.0"
 
-LIC_FILES_CHKSUM = "file://${WORKDIR}/git/documents/LICENSE;md5=f91e61641e7a96835dea6926a65f4702"
+LIC_FILES_CHKSUM = "file://${S}/../../../documents/LICENSE;md5=f91e61641e7a96835dea6926a65f4702"
 
 DEPENDS += "aws-iot-device-sdk-cpp-v2"
 
-- 
2.25.1


