Return-Path: <gmisra@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55A5CD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 10:24:54 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17431.1779877486470154974
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 03:24:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=oH0sweUD;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: gmisra@qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8mXc31176613
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IHFa4SCoepReMUE7zRGoMdaMGU+AGcxtKDq
	432maU0U=; b=oH0sweUD4LSIne1tgT97nOBJ/EYbCvit3S6zNAPmimcoywjnZFg
	/4PMLnFlYa2t4h+zQhFy+vmnX0zeCmpq2cgliW2M300bihEBYqBAIATEfL/kz6RE
	AW71xCcsI0Trh9RvfjcyqnurqpsGZBgerhDRKUaT7ke541CKR1+eE+aIDwKpVYYb
	fRjuMhgfAB+lKkV/yPfY9pkW6H8TpV90dU6iqBZz3P6n9AQnhe1uf1mpNSY9uDFK
	zhj7PgIULXre8grkoBEJQuKyIOr/A2Ob/vyVMwyt1nWZuAp6E4vipgPyeBFdRnAH
	g2r/KGlDAup9yN4/eaIXTtJJzShvq4wDxGw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edndnj2fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:24:44 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RAOfMV008694;
	Wed, 27 May 2026 10:24:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ajka2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:24:41 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64RAOfRD008687
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:24:41 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-gmisra-hyd.qualcomm.com [10.213.99.33])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64RAOf2o008686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 10:24:41 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4467585)
	id CC175214EF; Wed, 27 May 2026 15:54:40 +0530 (+0530)
From: Gargi Misra <gmisra@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Gargi Misra <gmisra@qti.qualcomm.com>,
        Gargi Misra <quic_gmisra@quicinc.com>
Subject: [meta-selinux][PATCH3/3] libvirt_leasesh: Added read and search permission on kernel  sysctls  avc:  denied  { search } for  pid=1393 comm="libvirt_leasesh" name="kernel"  dev="proc" ino=3693 scontext=system_u:system_r:virt_leaseshelper_t:s0  tcontext=system_u:object_r:sysctl_kernel_t:s0 tclass=dir permissive=0  avc: denied  { read } for  pid=1363 comm="libvirt_leasesh" name="cap_last_cap"  dev="proc" ino=13638 scontext=system_u:system_r:virt_leaseshelper_t:s0  tcontext=system_u:object_r:sysctl_kernel_t:s0 tclass=file permissive=0  avc: denied  { open } for  pid=1359 comm="libvirt_leasesh"  path="/proc/sys/kernel/cap_last_cap" dev="proc" ino=2909  scontext=system_u:system_r:virt_leaseshelper_t:s0  tcontext=system_u:object_r:sysctl_kernel_t:s0 tclass=file permissive=0  avc: denied  { getattr } for  pid=1375 comm="libvirt_leasesh" name="/" dev="proc"  ino=1 scontext=system_u:system_r:virt_leaseshelper_t:s0  tcontext=system_u:object_r:proc_t:s0 tclass=filesystem permissive=0
Date: Wed, 27 May 2026 15:54:39 +0530
Message-ID: <20260527102439.1487755-1-gmisra@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=PpSjqQM3 c=1 sm=1 tr=0 ts=6a16c66d cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=-vbZ1Io1qTe7wVCr:21 a=R8wtq3ddXiUA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8 a=KTATZuYoSMOckcxMRwEA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Udb2EsLasdOsHaZnqlVWpxmGHDaoAYh3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEwMCBTYWx0ZWRfXxQguI2tZIMbh
 D4aZ28P+lxniaz6sQ8g4BXBMWuBeftbhwLgtZiPm807o9Hf5ImgmhKWXw0/PiZ+BU7sgF8BFqDJ
 PnZVUBDIv+hgQcp3nlSNE9w+oK5KKbndkHC5iygq+Vwj0L860+5SLxSEZzsyftj/WIdZ82ed0vG
 run8dxz0/PXlEvgjlJJTgOzQq8y5KENKqHT64wMHOL+WHfG2j8fSulc/3p6O6Nwy+zlPg3yoflP
 H5Ma4VFmwYB732DL7leQ595PtK5meZ0exJovIqIvidSQReKYQL4ybQbzGtphvCqOMpSqsNIKfcS
 zS/Vb2xtgkNilDbrYM+PEVx56In4y+9exocM6ZRsBxkyRRZMltb0OGk5bh6QGIxpvu8BZjD1j2a
 1UdBxq74bDANsWnC85w4OcBXkPXcA7hsXVwScnnOoq6S0Oz3V6cVwhOSMupojuSWvlVPCHzdN0+
 S9VZqENkWIcsOFUiv/A==
X-Proofpoint-GUID: Udb2EsLasdOsHaZnqlVWpxmGHDaoAYh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270100
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:24:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4072

Upstream-Status: Backport [ https://github.com/SELinuxProject/refpolicy/pull/1117/changes/a7d4c1333edee3ea6b532979ae6d940360489793 ]

Signed-off-by: Gargi Misra <quic_gmisra@quicinc.com>
---
 ...Added-read-and-search-permission-on-.patch | 41 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 42 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0061-libvirt_leasesh-Added-read-and-search-permission-on-.patch

diff --git a/recipes-security/refpolicy/refpolicy/0061-libvirt_leasesh-Added-read-and-search-permission-on-.patch b/recipes-security/refpolicy/refpolicy/0061-libvirt_leasesh-Added-read-and-search-permission-on-.patch
new file mode 100644
index 0000000..1897335
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0061-libvirt_leasesh-Added-read-and-search-permission-on-.patch
@@ -0,0 +1,41 @@
+From 977bd13b26fd697a1a01560908974f8a803deba3 Mon Sep 17 00:00:00 2001
+From: Gargi Misra <quic_gmisra@quicinc.com>
+Date: Wed, 27 May 2026 14:35:23 +0530
+Subject: [PATCH] libvirt_leasesh: Added read and search permission on kernel
+ sysctls avc:  denied  { search } for  pid=1393 comm="libvirt_leasesh"
+ name="kernel" dev="proc" ino=3693
+ scontext=system_u:system_r:virt_leaseshelper_t:s0
+ tcontext=system_u:object_r:sysctl_kernel_t:s0 tclass=dir permissive=0 avc: 
+ denied  { read } for  pid=1363 comm="libvirt_leasesh" name="cap_last_cap"
+ dev="proc" ino=13638 scontext=system_u:system_r:virt_leaseshelper_t:s0
+ tcontext=system_u:object_r:sysctl_kernel_t:s0 tclass=file permissive=0 avc: 
+ denied  { open } for  pid=1359 comm="libvirt_leasesh"
+ path="/proc/sys/kernel/cap_last_cap" dev="proc" ino=2909
+ scontext=system_u:system_r:virt_leaseshelper_t:s0
+ tcontext=system_u:object_r:sysctl_kernel_t:s0 tclass=file permissive=0 avc: 
+ denied  { getattr } for  pid=1375 comm="libvirt_leasesh" name="/" dev="proc"
+ ino=1 scontext=system_u:system_r:virt_leaseshelper_t:s0
+ tcontext=system_u:object_r:proc_t:s0 tclass=filesystem permissive=0
+
+Upstream-Status: Backport [ https://github.com/SELinuxProject/refpolicy/pull/1117/changes/a7d4c1333edee3ea6b532979ae6d940360489793 ]
+
+Signed-off-by: Gargi Misra <quic_gmisra@quicinc.com>
+---
+ policy/modules/services/virt.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/services/virt.te b/policy/modules/services/virt.te
+index 2241a22b5..0f6dc341e 100644
+--- a/policy/modules/services/virt.te
++++ b/policy/modules/services/virt.te
+@@ -1161,6 +1161,7 @@ manage_files_pattern(virt_leaseshelper_t, virt_runtime_t, virt_runtime_t)
+ files_runtime_filetrans(virt_leaseshelper_t, virt_runtime_t, file)
+ 
+ kernel_dontaudit_read_system_state(virt_leaseshelper_t)
++kernel_read_kernel_sysctls(virt_leaseshelper_t)
+ 
+ # Read /sys/devices/system/node/node*/meminfo
+ dev_list_sysfs(virt_leaseshelper_t)
+-- 
+2.43.0
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 2a2cc78..23aadf6 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -76,6 +76,7 @@ SRC_URI += " \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0059-refpolicy-Addressing-denial-seen-on-alsa.patch \
         file://0060-systemd-coredum-Added-sepolicy-permission-to-read-na.patch \
+        file://0061-libvirt_leasesh-Added-read-and-search-permission-on-.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
-- 
2.43.0


