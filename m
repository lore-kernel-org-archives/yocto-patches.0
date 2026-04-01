Return-Path: <amanna@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD810D35149
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 06:47:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7004.1775026024325270571
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 31 Mar 2026 23:47:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=AKJZqGyF;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: amanna@qti.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6314H5Ha1579948
	for <yocto-patches@lists.yoctoproject.org>; Wed, 1 Apr 2026 06:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OMxO3rSKWxBT0UtW+I3nGy
	Xla1OGMscVuZ4i9u7p5Xk=; b=AKJZqGyF57h/+2jAqAR9RplBNSskgwrx18w8C7
	3tU7ZjPRdPjZH90Vy38aZJN75zfJP3sPalFmAf1nnd38UenX8O2+qg0uLNkqiDTQ
	FBSgYQINDUDN3ELoiBfCKGeqLikIRP5WpyRkrCXKdVWfXTzvQB5RvBnOQ5bDndL2
	51DEzR9N3lR6NGXbaOpvnn120YrR1mErr5068dbejfrPCWAgJQUGd0F64xHDizjR
	Ave11DNe4/QLIV5D9wclFE3PuulK+fE/16gFJcLQNo3vte8e3e0XT95e4kAvmfbx
	mj/fjcP7uxCFIqZpni2oO3XYd1hrr2bvaIDevS2sxFOvWSsg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2t6ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 06:47:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTPS id 6316l22n006409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 1 Apr 2026 06:47:02 GMT
Received: from hu-amanna-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 31 Mar 2026 23:47:00 -0700
From: Abhilasha Manna <amanna@qti.qualcomm.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Abhilasha Manna <amanna@qti.qualcomm.com>
Subject: [meta-selinux][PATCH] refpolicy: backport fix from upstream (PR#1096)
Date: Wed, 1 Apr 2026 12:16:25 +0530
Message-ID: <20260401064624.2548716-2-amanna@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69ccbf67 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=9Ho48WRPCDnwLr7njrAA:9
X-Proofpoint-ORIG-GUID: ARwnvvyFd53lmunj9nBcfQX9gD5q1y1G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA1OCBTYWx0ZWRfX3CBnaRFqL7sV
 D9rsLRyoq3aqNMJdafHj/G4dp90f5bk5z8kLSyxJVvoggGtePAUwfaNDWrp6f0MxOeoV+pSrvDn
 q4PDHqdcWsgYLLG8S4qkQr+ZGI0W6CnVcCaXP8gduvHzIkE4T00VfWukFJ4sofkcbAUJclhUoPt
 Z2WRkB2wke1zx5wC+vZ9l1NRcu9jMbYvv14P3wUe10Nz5gItAwNOBcPLZo5U/Zn8OJs6T8fUjrd
 oSLQ5Tp5k0n7i5JucUn/xc7PiaeVK1ohsrZ+LcDifo/MBHZ1/Dl+1NDEeNCRhlNofQrCY65mPge
 fZDfxyiyxPxuuEWunCZzwyzabXU2CcnRzNcnczQAYFG8AoGIhSgPGkhzzH29+OyAg8n9kfdrLWS
 wfFsWfLCdsPgUWjel6ZVpwszEXhHVqDey/eY5zgExaCc0GsDIolAgRxoohGFQepUsX+knfgwr1U
 fShIvjaArSf0+3UAiAA==
X-Proofpoint-GUID: ARwnvvyFd53lmunj9nBcfQX9gD5q1y1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010058
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 06:47:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3594

Backport upstream SELinux refpolicy change from:

   https://github.com/SELinuxProject/refpolicy/pull/1096/changes/2aad2d57fa7e6873d3e59e6bc2848623713e46f0

This change is required to keep meta-selinux in sync with
upstream refpolicy and to fix issues observed when building
or running SELinux-enabled images.

No functional changes beyond the upstream fix.

Signed-off-by: Abhilasha Manna <amanna@qti.qualcomm.com>
---
 .../refpolicy/refpolicy-targeted_git.bb       |   1 +
 ...l_read_transparent_hugepage_sysfs-in.patch | 103 ++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0079-kernel-add-kernel_read_transparent_hugepage_sysfs-in.patch

diff --git a/recipes-security/refpolicy/refpolicy-targeted_git.bb b/recipes-security/refpolicy/refpolicy-targeted_git.bb
index de81d46..9d23e84 100644
--- a/recipes-security/refpolicy/refpolicy-targeted_git.bb
+++ b/recipes-security/refpolicy/refpolicy-targeted_git.bb
@@ -14,4 +14,5 @@ include refpolicy_${PV}.inc
 
 SRC_URI += " \
         file://0001-refpolicy-targeted-make-unconfined_u-the-default-sel.patch \
+		file://0079-kernel-add-kernel_read_transparent_hugepage_sysfs-in.patch \
         "
diff --git a/recipes-security/refpolicy/refpolicy/0079-kernel-add-kernel_read_transparent_hugepage_sysfs-in.patch b/recipes-security/refpolicy/refpolicy/0079-kernel-add-kernel_read_transparent_hugepage_sysfs-in.patch
new file mode 100644
index 0000000..463fc17
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0079-kernel-add-kernel_read_transparent_hugepage_sysfs-in.patch
@@ -0,0 +1,103 @@
+From fbf9e9a5c3086b53f46f9f07378af5466d7a6ee9 Mon Sep 17 00:00:00 2001
+From: Abhilasha Manna <amanna@qti.qualcomm.com>
+Date: Wed, 25 Mar 2026 14:49:46 +0530
+Subject: [PATCH] kernel: add kernel_read_transparent_hugepage_sysfs interface
+
+Add a new interface kernel_read_transparent_hugepage_sysfs() to allow
+specific domains to read sysfs files under the transparent hugepage
+path (/sys/kernel/mm/transparent_hugepage).
+
+Introduce sysfs_transparent_hugepage_t as a dedicated type for the
+transparent hugepage sysfs path, replacing the use of the generic
+sysfs_t.
+
+Upstream-Status: Inappropriate [meta-qcom specific]
+
+Signed-off-by: Abhilasha Manna <amanna@qti.qualcomm.com>
+---
+ policy/modules/kernel/domain.te |  3 +++
+ policy/modules/kernel/kernel.if | 37 +++++++++++++++++++++++++++++++++
+ policy/modules/kernel/kernel.te |  8 +++++++
+ 3 files changed, 48 insertions(+)
+
+diff --git a/policy/modules/kernel/domain.te b/policy/modules/kernel/domain.te
+index 0f38015b6..7c7fe8f32 100644
+--- a/policy/modules/kernel/domain.te
++++ b/policy/modules/kernel/domain.te
+@@ -120,6 +120,9 @@ allow domain self:lockdown { confidentiality integrity };
+ # glibc get_nprocs requires read access to /sys/devices/system/cpu/online
+ dev_read_cpu_online(domain)
+ 
++# read and search access to sys/kernel/mm/transparent_hugepage
++kernel_read_transparent_hugepage_sysfs(domain)
++
+ # Use trusted objects in /dev
+ dev_rw_null(domain)
+ dev_rw_zero(domain)
+diff --git a/policy/modules/kernel/kernel.if b/policy/modules/kernel/kernel.if
+index 01a06eb37..84d76dc3a 100644
+--- a/policy/modules/kernel/kernel.if
++++ b/policy/modules/kernel/kernel.if
+@@ -4108,3 +4108,40 @@ interface(`kernel_ib_manage_subnet_unlabeled_endports',`
+ 
+ 	allow $1 unlabeled_t:infiniband_endport manage_subnet;
+ ')
++
++########################################
++## <summary>
++##      Search the transparent hugepage sysfs directory.
++## </summary>
++## <param name="domain">
++##      <summary>
++##      Domain allowed access.
++##      </summary>
++## </param>
++#
++interface(`kernel_search_transparent_hugepage_sysfs',`
++        gen_require(`
++                type sysfs_transparent_hugepage_t;
++        ')
++
++        allow $1 sysfs_transparent_hugepage_t:dir search;
++')
++
++########################################
++## <summary>
++##      Read transparent hugepage sysfs files.
++## </summary>
++## <param name="domain">
++##      <summary>
++##      Domain allowed access.
++##      </summary>
++## </param>
++#
++interface(`kernel_read_transparent_hugepage_sysfs',`
++        gen_require(`
++                type sysfs_transparent_hugepage_t;
++        ')
++
++        allow $1 sysfs_transparent_hugepage_t:file read_file_perms;
++        kernel_search_transparent_hugepage_sysfs($1)
++')
+diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
+index 26578a26d..57aa13fb0 100644
+--- a/policy/modules/kernel/kernel.te
++++ b/policy/modules/kernel/kernel.te
+@@ -69,6 +69,14 @@ type kvmfs_t;
+ fs_type(kvmfs_t)
+ genfscon kvmfs / gen_context(system_u:object_r:kvmfs_t,s0)
+ 
++#
++#transparent_hugepage
++#
++
++type sysfs_transparent_hugepage_t;
++files_type(sysfs_transparent_hugepage_t)
++genfscon sysfs /kernel/mm/transparent_hugepage gen_context(system_u:object_r:sysfs_transparent_hugepage_t,s0)
++
+ #
+ # Procfs types
+ #
+-- 
+2.43.0
+
-- 
2.43.0


