Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215E5F0181C
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 09:56:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.63936.1772777690199254284
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Mar 2026 22:14:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=DFzuBsrY;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264aNuM2327507
	for <yocto-patches@lists.yoctoproject.org>; Fri, 6 Mar 2026 06:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Hs2pCWjDkMW2rj5IeNLdWlhMjZAjej8EMvx
	XSPScJBo=; b=DFzuBsrYAXi9oj7ZjmDeYj0PQDIXNSNUTgvn3FE9JruwqIj4Nci
	GZQhraZgXl+t73TJtstB2/DHuB66NgOsZF9pQOh2LDoe5isHCxCI53M8FWHXf8PL
	MR+Ga7COyone3AzODPbI+vgPSjjIzyL/rQr4O7fG8dl8tBN+9OCCgOM4qqS06WBV
	TxWc0qPiYyTdE/7ZHqprOy3ivW3Hv12+q2MIKJ/il4+bO8Ibmf2fpZgKCOOPSqtL
	P+MTN8iFAR9dt8G2No68TlM/w1uUyE3TfN/nX5nQIVU2Rlzc7UE519bynPqbxR4E
	oi5WS+la1Up1a/kpiHGrBlB+i0H2CRBfELQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqg09st39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 06:14:49 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 6266Eki3006150
	for <yocto-patches@lists.yoctoproject.org>; Fri, 6 Mar 2026 06:14:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4cksen24kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 06:14:46 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6266Ej0Q006141
	for <yocto-patches@lists.yoctoproject.org>; Fri, 6 Mar 2026 06:14:45 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com ([10.213.102.143])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6266Ejvs006139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 06:14:45 +0000
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4060212)
	id C45B022B1F; Fri,  6 Mar 2026 11:44:44 +0530 (+0530)
From: "Sasi Kumar Maddineni" <sasikuma@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
Subject: [meta-selinux][PATCH] kmod: add net_admin capability to kmod_t
Date: Fri,  6 Mar 2026 11:44:41 +0530
Message-ID: <20260306061441.3812128-1-sasikuma@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 99USp8fRHlyj8Rw_Y4dsLTl3zR-HbBEd
X-Authority-Analysis: v=2.4 cv=b/u/I9Gx c=1 sm=1 tr=0 ts=69aa70d9 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=5TqsJGdFh5BIxteIstoA:9
X-Proofpoint-GUID: 99USp8fRHlyj8Rw_Y4dsLTl3zR-HbBEd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA1OCBTYWx0ZWRfX3Q3r1LVN4Vdk
 MhkADT+VOtXuu389R3F78Zx7Es0mRLcwBe36fDhlG3q/oDwbuGZuoCuAYWArqNjcMHYVQGcgiML
 EkTiK6vabU81N626KlDppK5SLoPQ/wZeUTkvRaVZf728r3mPxqIdCgg/WtW0clYK6Dd9DFLGOjD
 UEMoRJ0QFMHUW3bgkJhj2xkb2g3FFhXC7D1YbhVKkvmxZNicCbjz8piUOw9HurkuRnDuHYZFgzA
 W40i66XNbNRE1t28nq1sZcXb4gudaftqNE/aDFFo4BW+HPnkCvxPhtQ+fVduEodLkIcS42H3UOj
 YqnqkNdj3sAE0fNw4gq4wigj/hlVpYKjsa/qmQl2pWPm6Kqxum6vQ+V2qgcPA6mdTt74smeDqYL
 bXGQcQeaU/WLfTeaH4cxywYtsHC6xj4oI28pTTG+lm9O4jxk41oiclfPWA7khIDspFxM9bFoB6F
 IMUzbrCmRF43XVSG+vA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060058
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 09:56:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3343

The kmod_t domain attempted network administration operations resulting
in SELinux denials.

Adding net_admin to the capability set resolves the
issue.

Signed-off-by: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
---
 ...d-add-net_admin-capability-to-kmod_t.patch | 34 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  3 +-
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-kmod-add-net_admin-capability-to-kmod_t.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-kmod-add-net_admin-capability-to-kmod_t.patch b/recipes-security/refpolicy/refpolicy/0059-kmod-add-net_admin-capability-to-kmod_t.patch
new file mode 100644
index 0000000..ebc0d98
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-kmod-add-net_admin-capability-to-kmod_t.patch
@@ -0,0 +1,34 @@
+From 89379c0b2430e80d345e6552c8b8b151c12dc24d Mon Sep 17 00:00:00 2001
+From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
+Date: Thu, 26 Feb 2026 11:46:19 +0530
+Subject: [PATCH] kmod: add net_admin capability to kmod_t
+
+The kmod_t domain attempted network administration operations resulting
+in SELinux denials.
+
+Adding net_admin to the capability set resolves the
+issue.
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/89379c0b2430e80d345e6552c8b8b151c12dc24d]
+
+Signed-off-by: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
+---
+ policy/modules/system/modutils.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/system/modutils.te b/policy/modules/system/modutils.te
+index 271cdb1d4..7355255e0 100644
+--- a/policy/modules/system/modutils.te
++++ b/policy/modules/system/modutils.te
+@@ -33,7 +33,7 @@ ifdef(`init_systemd',`
+ # insmod local policy
+ #
+ 
+-allow kmod_t self:capability { dac_override dac_read_search net_raw sys_nice sys_tty_config };
++allow kmod_t self:capability { dac_override dac_read_search net_raw net_admin sys_nice sys_tty_config };
+ allow kmod_t self:process { execmem sigchld sigkill signal signull sigstop };
+ # for the radeon/amdgpu modules
+ dontaudit kmod_t self:capability sys_admin;
+-- 
+2.43.0
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 2e1a929..30c8e46 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,7 +74,8 @@ SRC_URI += " \
         file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
-        "
+        file://0059-kmod-add-net_admin-capability-to-kmod_t.patch \
+       "
 
 S = "${UNPACKDIR}/refpolicy"
 
-- 
2.43.0


