Return-Path: <gmisra@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F31CD5BD5
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 10:21:44 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17389.1779877295219799539
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 03:21:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=ELVj+LDN;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: gmisra@qualcomm.com)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RA6mY61149704
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=cerLIVt3UeoY1razZYncND9kcjbbVv9dzTL
	mAns2jz8=; b=ELVj+LDNJlygcR8TkCXsrJo8PsSxix0XnKmDKNjThcoMDQNooOp
	jKFDP9tCot2fgHKvQjSg3b1YZQ5zXFwlLTuOEgO59RYPxrXxX3FKp2kdsyRGXLvZ
	2Po8l0E3K0kAZVT8eCLYmPIiIxdWywxRoTb5ujSdYVdOvz0dVe0kvI0H5oZbNjOL
	7wuEk0KeB5EPOiNK9J61ee2cTWaBs+PrzmXq0zHPr/2Kq8pX9WpCLUzUT+3SJ5xL
	RSG4rnbOAn7B9AjuU02wPjn4jfruOP9JzbN8I6Q/3sQDx+BjtqQq6sXtJG1n+NB/
	g2IEUOOIOQ4+mSraHJHIbaDlRpi3mQgFaVA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edxjsg1hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:21:34 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RALVPr005067;
	Wed, 27 May 2026 10:21:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ajk95w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:21:31 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64RALVG7005061
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:21:31 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-gmisra-hyd.qualcomm.com [10.213.99.33])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64RALUSx005059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 10:21:31 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4467585)
	id 480D0214EF; Wed, 27 May 2026 15:51:30 +0530 (+0530)
From: Gargi Misra <gmisra@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Gargi Misra <gmisra@qti.qualcomm.com>
Subject: [meta-selinux][PATCH2/3] Subject: [PATCH] systemd-coredum: Added sepolicy permission to read namespace  file type=AVC msg=audit(1776766842.302:2875): avc:  denied  { read open } for   pid=6273 comm="systemd-coredum" path="pid:[4026531836]" dev="nsfs"  ino=4026531836 scontext=system_u:system_r:systemd_coredump_t:s0  tcontext=system_u:object_r:nsfs_t:s0 tclass=file permissive=0
Date: Wed, 27 May 2026 15:51:28 +0530
Message-ID: <20260527102128.1485793-1-gmisra@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=C4PZDwP+ c=1 sm=1 tr=0 ts=6a16c5ae cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Mv50RoFS4YoA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=CJ4_2vi5urt8MGC88WwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEwMCBTYWx0ZWRfX86gIf58bS2Lq
 6pV1Sv+yghHkA++GODVxlUhepcnI6Ps4oOL8KVChhPGdGJ+Q+Z+sz2S/cOxd958/zP7LtrIr6rT
 Vs3KQcsv8tTzWeoQiYQ3Vuuj/VdfIheW8Vxl9YvPClpxvqOQ71pEpGphDoQ8KJLICk+Nl7inAtJ
 nWW8JO5i6WoGHv+dqA9o2kRU75Itq7b7jePxGwHa5GW8CcPi3N7qGWVtSwHGWdkkiPWy/NWwbFC
 9UZqymeM5X7ZfCdRjrYatK329BhY0KVlUCWTLvZT6DfHtlfrOpmJomy755J0WJFm5iXBMp/UUzN
 sNFQEw35xyPqPX4irxCDSOoYYDS5z0IXY1khbIBxDYTUWg+XSrKHzyH8gOqQH6QCo8Nx5Ld9drg
 o+Ub5AtMM5E/bSS4Z9ZBirGPhGqtBdBMwpA5rYpJf4mKU+IgjMaD0u29xfl9+1buRkIxNZn9eoS
 Ms/wVceXAJoqGes0+6w==
X-Proofpoint-ORIG-GUID: S0jjtPkGu7L28IXp4_G9dPpkBrQObGHu
X-Proofpoint-GUID: S0jjtPkGu7L28IXp4_G9dPpkBrQObGHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270100
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:21:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4070

Upstream-Status: Backport [ https://github.com/SELinuxProject/refpolicy/pull/1117/changes/75079752d1fb3cd8a394a4c470ec9b1144cec1bd ]

Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
---
 ...Added-sepolicy-permission-to-read-na.patch | 31 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0060-systemd-coredum-Added-sepolicy-permission-to-read-na.patch

diff --git a/recipes-security/refpolicy/refpolicy/0060-systemd-coredum-Added-sepolicy-permission-to-read-na.patch b/recipes-security/refpolicy/refpolicy/0060-systemd-coredum-Added-sepolicy-permission-to-read-na.patch
new file mode 100644
index 0000000..2ef8f67
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0060-systemd-coredum-Added-sepolicy-permission-to-read-na.patch
@@ -0,0 +1,31 @@
+From 099c11e67498afaf28f424ca908ba44dd0c11c3d Mon Sep 17 00:00:00 2001
+From: Gargi Misra <quic_gmisra@quicinc.com>
+Date: Wed, 27 May 2026 13:50:46 +0530
+Subject: [PATCH] systemd-coredum: Added sepolicy permission to read namespace
+ file type=AVC msg=audit(1776766842.302:2875): avc:  denied  { read open } for
+  pid=6273 comm="systemd-coredum" path="pid:[4026531836]" dev="nsfs"
+ ino=4026531836 scontext=system_u:system_r:systemd_coredump_t:s0
+ tcontext=system_u:object_r:nsfs_t:s0 tclass=file permissive=0
+
+Upstream-Status: Backport [ https://github.com/SELinuxProject/refpolicy/pull/1117/changes/75079752d1fb3cd8a394a4c470ec9b1144cec1bd ]
+
+Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
+---
+ policy/modules/system/systemd.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
+index a18a584f4..1120e719a 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -574,6 +574,7 @@ fs_getattr_all_fs(systemd_coredump_t)
+ fs_getattr_nsfs_files(systemd_coredump_t)
+ fs_list_cgroup_dirs(systemd_coredump_t)
+ fs_search_tmpfs(systemd_coredump_t)
++fs_read_nsfs_files(systemd_coredump_t)
+ 
+ init_list_var_lib_dirs(systemd_coredump_t)
+ init_read_state(systemd_coredump_t)
+-- 
+2.43.0
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index c43ff03..2a2cc78 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -75,6 +75,7 @@ SRC_URI += " \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0059-refpolicy-Addressing-denial-seen-on-alsa.patch \
+        file://0060-systemd-coredum-Added-sepolicy-permission-to-read-na.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
-- 
2.43.0


