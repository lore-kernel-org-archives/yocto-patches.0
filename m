Return-Path: <jaihindy@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998C7CD5BAC
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 09:29:47 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32802.1779355782500897146
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 21 May 2026 02:29:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=fIq0aW3k;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: jaihindy@qti.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L9AN0U1731260
	for <yocto-patches@lists.yoctoproject.org>; Thu, 21 May 2026 09:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SZQN/M5MSFQU6CLd1fgV72
	SKiYTJIm0sk9GDmVFyaF0=; b=fIq0aW3kQ2A3EyAtaosXIZChbqAkfXUAC9Ft6+
	G+hmu2ia7jQAynm0osk1Du6ObzI2g++JdbkNSLHmOIyITyzzU0ePFm+solTGbLTk
	K5pyoRqyKLMtzB+/sPLUyvFghUyDSA/9KsAwT9aQFUCTD1ZU14noYS/lWgiK7BlM
	En5frUrzDT+Xwq9JA3FLszSxVcUrop8lloFAqazDKG+x8zrutdKCjFCEuSYryKfT
	Ds/9HWMHq/Dg5vjALuieXchHzD7idY1OODzaBTKWWcL29M8iJCd+Oj0kriNyiXpq
	uAOV4l9TuUcbf0pdLmvI/J3+kqLcHBNa0BiLDJd03/7msJCQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9c7f4p24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 21 May 2026 09:29:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTPS id 64L9Td60004620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 21 May 2026 09:29:39 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 21 May
 2026 02:29:38 -0700
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Subject: [PATCH] refpolicy: init - allow initrc_t ModemManager D-Bus access
Date: Thu, 21 May 2026 14:59:18 +0530
Message-ID: <20260521092918.1192333-1-jaihindy@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a0ed085 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=TDwhO12JHQ7xZ5CLTQsA:9
X-Proofpoint-GUID: HuD6dZVlp_I_VbE9w-tyyc3E2jJyULRf
X-Proofpoint-ORIG-GUID: HuD6dZVlp_I_VbE9w-tyyc3E2jJyULRf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA5MyBTYWx0ZWRfXxzJ9F+Pg54UA
 oIKNLLGt1XffHXg0iph00XlIZhLHXmej2xDqu/Z8TbJ62+ImE72hItBOfHGLB9s0htVMtqW/z+0
 D+T9FObZU/KmzOexITKE2REV+KSzb0K20WooV/Goin4iGBigsJhEqj54REbkrL5qZUlwMHll1tV
 opNhqiGHg7P8c8MTKuviyowr+ABixxcyTV2GumScCmWeJwKMHWpZy9shqvvQlSnMHF2N1vxXqh/
 nalP8VRmxmj6FYsHS2k33Q3MMjVFQUoX6H/FNNrobyUa5grPIKtq388dG+8RNkrL5YYCbkv17AS
 ej/7mYtK+L82Eh7KjLWqaZgA8z+xZvxSrJYP6VCMlN0Oy1eDUAZMagnBQ+IlOLpBNTc1tRmXvk0
 /B/f3HDeZiEV1JrukbUR7b1reh1QfgslOiNCwg4JGPaYhgQE9h1g9yMlSuqc0vI5N+DC3ZTOe0Y
 R1dYkvBg6/9rC1k9jUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210093
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 21 May 2026 09:29:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4003

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

