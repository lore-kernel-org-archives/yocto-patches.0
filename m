Return-Path: <jaihindy@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D7DCD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 09:00:27 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16019.1779872422323761536
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 02:00:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=p7fuGGqf;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.168.131, mailfrom: jaihindy@qti.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8mYeq051188
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 09:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SZQN/M5MSFQU6CLd1fgV72
	SKiYTJIm0sk9GDmVFyaF0=; b=p7fuGGqfVjhSZmKx4wzSQ/LUAvGDvaDnC5gJUB
	lJAno5JgBdjV9Hpd50ISkFZDPRTKYxPRMlluj6Xhb76swsJyESmLWBKxvuq3zh3j
	uwT/7fAO0oGr4aJWHTo/ijSdclnGPjSla97ZCbTyJuVNMxtQ73zF00Iwc/IVfrhB
	Wkdu2lZ1FagUrcyAKaEhfxnZTdAunGUOpMiIi1B1KHn3xrDbNm8iwPvm2drtUwOn
	fospxcXbK1rqDlzmcL7hVGpO6K/PVRNMIMjLDD8KMUnGU5a8+T1nMiAeumPz4sCz
	mw3QwQnbSmu7qLZYXdWKs4UVD9QNgaU3ZnU/fnO0mtvWDZyw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edg5parsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 09:00:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTPS id 64R90LbR008063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 09:00:21 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 27 May
 2026 02:00:19 -0700
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Subject: [meta-selinux][PATCH/V2] refpolicy: init - allow initrc_t ModemManager D-Bus access
Date: Wed, 27 May 2026 14:29:13 +0530
Message-ID: <20260527085913.924238-1-jaihindy@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: 7YpcVcAIUsWndov9hA-bCdSd6pquuPFo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA4NSBTYWx0ZWRfX7ZzF9bUi/ZVm
 RhPzNay+Sfjo87iZN8tTqa1yv2H5yK2MqE6FycrmOiHBJ4dQjwHOxduHDsogCsgOs3xxI0g3amM
 lhMCXAs5J+73/PnHdLtQAeQnWQnycBDmumIGcPR7Wljr6mshea8gHSODNKxvQaCbLcdRb68Sfsl
 aWkNJ0/ny1jHAvDkhaA/1a40qoumVnaZRbkgT9RefBfITyc0UVKKz5zpbCjLyJ1yZVtrVi8KSkj
 zTeCNUrBBeV1B58k8TyxcZeyMcVWmBSAa8G3icWNqDQIB89jXKp3RkQbEteUKMv6qR7TTQMLrrW
 CohZZUG3jtn8C9wJO2GROHfFA05z0b2tGpp2y+QJQO6NVZ297ilkSFYHbY8vf5B+8uEpqjHQt5b
 iI7Z5fmiorpRdgPqk8AACPkbE9LtNCFlZMc1yOfRrCgbsM8hEhCeZyem77tprj1gdBtd7h2Amek
 zG4ZP98QJoeGJRsmZuA==
X-Authority-Analysis: v=2.4 cv=I95Vgtgg c=1 sm=1 tr=0 ts=6a16b2a5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=TDwhO12JHQ7xZ5CLTQsA:9
X-Proofpoint-GUID: 7YpcVcAIUsWndov9hA-bCdSd6pquuPFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270085
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 09:00:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4068

Backport upstream change to fix wireplumber interaction with
ModemManager via D-Bus.

Upstream-Status: Backport [5684dae89f8d69717a17664193d3686fdf57fb6b]

Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
---
 ...ystem-init-allow-ModemManager-to-sen.patch | 35 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 36 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-policy-modules-system-init-allow-ModemManager-to-sen.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-init-allow-ModemManager-to-sen.patch b/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-init-allow-ModemManager-to-sen.patch
new file mode 100644
index 0000000..9ae1d8c
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-init-allow-ModemManager-to-sen.patch
@@ -0,0 +1,35 @@
+From 11a838ec4c51c62b265f653e4aedf22ed032d2ce Mon Sep 17 00:00:00 2001
+From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
+Date: Thu, 21 May 2026 08:47:33 +0000
+Subject: [PATCH] policy/modules/system/init: allow ModemManager to send DBus
+ messages to  initrc_t.
+
+Add modemmanager_dbus_chat(initrc_t) to permit wireplumber
+to communicate with ModemManager over D-Bus.
+
+Upstream-Status: Backport [5684dae89f8d69717a17664193d3686fdf57fb6b]
+
+Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
+---
+ policy/modules/system/init.te | 5 +++++
+ 1 file changed, 5 insertions(+)
+
+diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
+index 15bffd9cf..491f04c48 100644
+--- a/policy/modules/system/init.te
++++ b/policy/modules/system/init.te
+@@ -1334,6 +1334,11 @@ optional_policy(`
+ 		networkmanager_dbus_chat(initrc_t)
+ 	')
+ 
++	optional_policy(`
++		# Needed by wireplumber to interact with ModemManager over D-Bus
++		modemmanager_dbus_chat(initrc_t)
++	')
++
+ 	optional_policy(`
+ 		policykit_dbus_chat(initrc_t)
+ 	')
+-- 
+2.43.0
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 014714c..6f528d5 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI += " \
         file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0059-policy-modules-system-init-allow-ModemManager-to-sen.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"

