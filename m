Return-Path: <gmisra@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B792CD5BDE
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 08:37:05 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15771.1779871017795776100
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 01:36:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=F/aCiH2G;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: gmisra@qualcomm.com)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8Y4Vf941494
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bMjfOP4rHddIIUeBjJ+/X5k2fVuvM8V+N8C
	fAY2g3kg=; b=F/aCiH2GKmVmldFx6BSSuMOlblovKONfbPw6WaNeZvndP7K0tvH
	xjZQrWsztpXfM3yW3v20vUGpeUQaupmxeZkpxpY5j2Bws3dX2qg9Hh/iZKNnpYGW
	GIS3hlBRfa+MpECwFyG5NFosjW4SJ1LiLXTsVkIpN5Aq1uokXkIqQScSXjVEsi4y
	aI23r5eKQFTa2H/Oy/dRnBfCGaVNhIXzDIwVk5n7HMYJkTRTx7XPoi8bEfWmvk0+
	YchtNNzFlKmXGhSc6b6kuLWgiwO5+kHcctsDBkZAaseQ2wWnBOhgCUIYLBJ1XD3D
	9H537DTRnG6jRj0FmRi3J5X5qI6DXQL0CYg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edeff38wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:36:56 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R8ariD002271;
	Wed, 27 May 2026 08:36:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4eb5akcutj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:36:53 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64R8arD3002263
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:36:53 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-gmisra-hyd.qualcomm.com [10.213.99.33])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64R8arYY002260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 08:36:53 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4467585)
	id 610CD21427; Wed, 27 May 2026 14:06:52 +0530 (+0530)
From: Gargi Misra <gmisra@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Gargi Misra <gmisra@qti.qualcomm.com>
Subject: [meta-selinux][PATCH2/3] systemd-coredum: Added sepolicy permission to read namespace file type=AVC msg=audit(1776766842.302:2875): avc:  denied  { read open } for  pid=6273 comm="systemd-coredum" path="pid:[4026531836]" dev="nsfs" ino=4026531836 scontext=system_u:system_r:systemd_coredump_t:s0 tcontext=system_u:object_r:nsfs_t:s0 tclass=file permissive=0
Date: Wed, 27 May 2026 14:06:50 +0530
Message-ID: <20260527083650.1120804-1-gmisra@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=ONEXGyaB c=1 sm=1 tr=0 ts=6a16ad29 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=7dOfVs_F7VIA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=CJ4_2vi5urt8MGC88WwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: oaW5UheKZpQuqDOXkl10gdeMbP3uc_nL
X-Proofpoint-GUID: oaW5UheKZpQuqDOXkl10gdeMbP3uc_nL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA4MSBTYWx0ZWRfX9SaxtYmt3eBV
 RQxxxT3qi/MsPo7qQRUZ/VWyNFJlL+TYQYebVATMtXCz8U96DIR3Ttgn0w5qgz/YFWKr6A2zlyl
 eM3wQ2deSjUzTUWxptyB46zYgodC0t/WyvvNms7YKnN2ZNfAmJxzhtJhj7tbKkkxE1SeQEirSg+
 UOf47SOdxMp964T84RN086zCQPJtDrNcVbLXwuSIDlvBcCGAILts92LPXht+gxIpjR1+YmfmFSl
 RJdJXRKy60E0WeRvVVucXIxMsJF4YDuKsXT1IO4CjclaGC5YwdvmmB/EHdO0zkmJlELz2waJYTp
 OHXBi/n+o1FTF3aaOpKHhTsQv1+aKEG7u0CLkhNvIQqhTRy40QJOYVeQPZQf++U3e3cP6Ce7IF1
 +clBynh550AaScbIJ9WtMcjWl57HM8rpLYQvhkmCh5v9+BTMxlaGOdGD/g3Yk6H2hmuuo5loIZT
 YbOKp7qDH/Kf5sKlsog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270081
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:37:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4066

Upstream-Status; Merged [ https://github.com/SELinuxProject/refpolicy/pull/1117/changes/75079752d1fb3cd8a394a4c470ec9b1144cec1bd ]

Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
---
 ...Added-sepolicy-permission-to-read-na.patch | 29 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 30 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0060-systemd-coredum-Added-sepolicy-permission-to-read-na.patch

diff --git a/recipes-security/refpolicy/refpolicy/0060-systemd-coredum-Added-sepolicy-permission-to-read-na.patch b/recipes-security/refpolicy/refpolicy/0060-systemd-coredum-Added-sepolicy-permission-to-read-na.patch
new file mode 100644
index 0000000..aa6fdc0
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0060-systemd-coredum-Added-sepolicy-permission-to-read-na.patch
@@ -0,0 +1,29 @@
+From 099c11e67498afaf28f424ca908ba44dd0c11c3d Mon Sep 17 00:00:00 2001
+From: Gargi Misra <quic_gmisra@quicinc.com>
+Date: Wed, 27 May 2026 13:50:46 +0530
+Subject: [PATCH] systemd-coredum: Added sepolicy permission to read namespace
+ file type=AVC msg=audit(1776766842.302:2875): avc:  denied  { read open } for
+  pid=6273 comm="systemd-coredum" path="pid:[4026531836]" dev="nsfs"
+ ino=4026531836 scontext=system_u:system_r:systemd_coredump_t:s0
+ tcontext=system_u:object_r:nsfs_t:s0 tclass=file permissive=0
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


