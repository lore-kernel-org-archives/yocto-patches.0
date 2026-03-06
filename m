Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9DDF01821
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 09:56:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.64094.1772778527733604890
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Mar 2026 22:28:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=dBE0aZBB;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264afgo2328038
	for <yocto-patches@lists.yoctoproject.org>; Fri, 6 Mar 2026 06:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=41+XZVSU5gTfNW16m70iRqt0r1yYSBKwftL
	Uqk1fvx8=; b=dBE0aZBBtp+4JWbUXiLgHEXTgwzCPRYcO5ONpM4KPBoI1xsUXzy
	6wQuKOghj5j0KeCex7jaNWCbKDFeg2qSohOJ6VqoHNAJtQQIfEdb9k65ZlkKMwrO
	6JljajmDa5dNZGKmtC2p/lhg1kvCKPzkjYBIUAgxUB7rImBPT/ZSCCu7UU8vRuEw
	kGQQ23z7mTT5E0ViPjwb4Llw0rJbMG1IN5sYF7cZZ2hb36ZwNRpeEa4pjczKZaZ0
	XV8IplP7eeWw5GcD1eu6TH2fVBIsDqLhBYrwSx2X0oeNGq1ChSdjCnokTuMb25sS
	Ihd+KJ5nVDkMo3mWmOROso+rA5rxdTY1jsw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqg09sun7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 06:28:46 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 6266ShvG014714
	for <yocto-patches@lists.yoctoproject.org>; Fri, 6 Mar 2026 06:28:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4cksen9g7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 06:28:43 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6266ShjO014708
	for <yocto-patches@lists.yoctoproject.org>; Fri, 6 Mar 2026 06:28:43 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com ([10.213.102.143])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6266SgNo014707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 06:28:43 +0000
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4060212)
	id 3CCEB22B1F; Fri,  6 Mar 2026 11:58:42 +0530 (+0530)
From: "Sasi Kumar Maddineni" <sasikuma@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
Subject: [meta-selinux][PATCH/V2] kmod: add net_admin capability to kmod_t
Date: Fri,  6 Mar 2026 11:58:40 +0530
Message-ID: <20260306062840.3814265-1-sasikuma@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fo3XsVUSdcWWgHWBDS2vi7hrRlQUamXB
X-Authority-Analysis: v=2.4 cv=b/u/I9Gx c=1 sm=1 tr=0 ts=69aa741f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=5TqsJGdFh5BIxteIstoA:9
X-Proofpoint-GUID: Fo3XsVUSdcWWgHWBDS2vi7hrRlQUamXB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA2MCBTYWx0ZWRfXw5IWI5ocBE7U
 A+WbOUZ5Gh+xoFpgJZDTuSNRRV7dkB2nwahZD8dCDGZkwUTCa6G/KrBfOZxCAUqQHRZrZUxb2P+
 oOv7Q/NUpa1F8V7w39YQb/Wan7bAl6aD6/iJ6JNPKRoK6AKTiLWHeiLzwoQDyQc721oS4pCXu5y
 jTR0VRZrA7QMFQbilDMSbONtCKDtmZXxhriLvkJW7A5JloXLqidA1bjt3Q1PFb4Vkl5xCPVjv7y
 Lr0HsRTPMINWF6EI/OQkOVoZGcCOfkvA6ThII92hAqmUCfB6iSMDfPwxAx9GO0F/KgnIHSzJBwJ
 F8bbADfpyPrQMp0LK2tk4wVCogwm1RDUwsCOj38h67DnyhiP4E/FVSKantr44ceGJAhfaP8NkpE
 bFrBcyObSrvts61CqPr1on/yKcplcDIea7vP5mB0IlE1iWufmMTAO3XwMjD08miX2CdBvnbgFbE
 L0XbAZ2VxN813h18/rA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060060
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 09:56:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3344

The kmod_t domain attempted network administration operations resulting
in SELinux denials.

Adding net_admin to the capability set resolves the
issue.

Signed-off-by: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
---
 ...d-add-net_admin-capability-to-kmod_t.patch | 34 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  3 +-
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 recipes-security/refpolicy/refpolicy/0060-kmod-add-net_admin-capability-to-kmod_t.patch

diff --git a/recipes-security/refpolicy/refpolicy/0060-kmod-add-net_admin-capability-to-kmod_t.patch b/recipes-security/refpolicy/refpolicy/0060-kmod-add-net_admin-capability-to-kmod_t.patch
new file mode 100644
index 0000000..ebc0d98
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0060-kmod-add-net_admin-capability-to-kmod_t.patch
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
index 2e1a929..3bd43cb 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,7 +74,8 @@ SRC_URI += " \
         file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
-        "
+        file://0060-kmod-add-net_admin-capability-to-kmod_t.patch \
+       "
 
 S = "${UNPACKDIR}/refpolicy"
 
-- 
2.43.0


