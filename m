Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEECF5140E
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 06:38:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63998.1772779096393521840
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Mar 2026 22:38:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=ehLbKQ2Z;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264aOS62327756
	for <yocto-patches@lists.yoctoproject.org>; Fri, 6 Mar 2026 06:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=LnuI4W3rJ8G3kJysyaNQNjNZTiGXV2HEQnd
	+iYSKz+s=; b=ehLbKQ2ZlD5QccLUmpj6tY5PycnpWA43FVHgE0PdpfuaWLClBm/
	/yYBk0kjI0TmZEeaHuXMSJvUuiN1j0ASVFjmiZtx7l6ooyr5UQ7n4d63wnwPLsyb
	uwxjOrzqZi8tejSNgrTacneuzkoZWxKJ/+nQ3UWgiIT/0pVJiJI8pyy9iYznVjhM
	FnoWPAgLu0P6Su5m2PAGWVcO8AQhUjBWcEsGSsWlK+cJ/gMRb8bzSAebCKMXlxiz
	nOyZhSTy/70Y7I9AtW0NJTmO3lkgRc7WC2rMKy1Z2ZtogQHpuy7EaASeEsprhVIL
	coCiwTOfitrTtS2E1OOQ88pIalAgDWO/mnQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqg09svnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 06:38:15 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 6266cCkX031708
	for <yocto-patches@lists.yoctoproject.org>; Fri, 6 Mar 2026 06:38:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4cksen29fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 06:38:12 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6266cCeI031700
	for <yocto-patches@lists.yoctoproject.org>; Fri, 6 Mar 2026 06:38:12 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com ([10.213.102.143])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6266cCAa031699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 06:38:12 +0000
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4060212)
	id 6CCD022AA4; Fri,  6 Mar 2026 12:08:11 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>,
        Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH] kmod: add net_admin capability to kmod_t
Date: Fri,  6 Mar 2026 12:08:10 +0530
Message-ID: <20260306063810.3838975-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mHEsxXWpZmCfS9zXgLAqD4XQXK6zyZ2E
X-Authority-Analysis: v=2.4 cv=b/u/I9Gx c=1 sm=1 tr=0 ts=69aa7657 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=5TqsJGdFh5BIxteIstoA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mHEsxXWpZmCfS9zXgLAqD4XQXK6zyZ2E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA2MSBTYWx0ZWRfXwbdD5T1z8+hu
 dvCh0VeUGhiuhOTf5p2rLWTf/SALvWxd+vbNP6ZhPjXia119oLc0bHn9MhLSw+GI83lKygwnxl9
 qgGu6gcBgyJeE120mAyhZCWO5YKc7Wj1TR8w3nHUSaKIWYvHJo+x7vpCThuFvK3o/YSg1KbNyCl
 Cyp7/gMmLE04+Q74ZgmawkOlE8mkzIwGnKe17MwKbb31ijKxxIPb0yOoHv4lYIkOTag+eeTO7q1
 xkDu3QACJ3gaCLl5essjU/EsJQlv7UCJYvAv1rVWtopYpPo4RyxYFOtgPdBhi+mqMl/YaHFSJnh
 FYvGMd5MBtBL2f0KvQRToydmXlJMgfcEVWt/JXcxH25yak4IVgPds6rG8GJ7pIhffCa//IHJmgb
 y8cnL53Dxl5L+EN4pNdYwOlS6ud3Vv6yHtNauXFXA+TGxmq4gFjbUxlAseySIGmqddg6/jGxhhc
 9BtJm5UNWGF8ia/YvUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060061
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 06:38:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3341

From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>

The kmod_t domain attempted network administration operations resulting
in SELinux denials.

Adding net_admin to the capability set resolves the
issue.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
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


