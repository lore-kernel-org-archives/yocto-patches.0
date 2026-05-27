Return-Path: <gmisra@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92858CD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 08:40:15 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15667.1779871207921652027
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 01:40:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Di6I1o7Q;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: gmisra@qualcomm.com)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8XXks2249350
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XGdJzWAz9ge+d2Qqw5x8s7NQ/Xc3Vurjgog
	oofTpDwE=; b=Di6I1o7Qq9zQ1s2XhLb/KeobjG08cnjGrNlzfigaN5mUq4K6v72
	/iDUdGwa+6f6HM70OIaGweouUiF43QAmXj3qDUdojT7k6X/mwUnrDVR1lfXhSYfG
	9gejmqtqDA8F9TsNDyW54LyUGHvCHp5N05ajB+hzwrYrLdxt/jIN3hj5BplE64r/
	lchwxs1oEp5Q/qhsvF6On024b8SrjrrFycZJIOj7+PSnz+N+HoudxRdmtZxWqTpQ
	mPobE5QXPreyYvCMU34cdJTir+wjlc1iydcw5b4dSUvgN4/OS2MNaXuJzFGYbZYi
	gw04FfdajjjoE94SD/qKxN3GqjLKRuaPBVg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edtvcrkdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:40:07 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R8e3rp009078;
	Wed, 27 May 2026 08:40:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ajjdak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:40:03 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64R8e3RY009067
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:40:03 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-gmisra-hyd.qualcomm.com [10.213.99.33])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64R8e3gF009059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 08:40:03 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4467585)
	id 0B35221427; Wed, 27 May 2026 14:10:03 +0530 (+0530)
From: Gargi Misra <gmisra@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Gargi Misra <gmisra@qti.qualcomm.com>
Subject: [meta-selinux][PATCH3/3] libvirt_leasesh: Added read and search permission on kernel sysctls avc:  denied  { search } for  pid=1393 comm="libvirt_leasesh" name="kernel" dev="proc" ino=3693 scontext=system_u:system_r:virt_leaseshelper_t:s0 tcontext=system_u:object_r:sysctl_kernel_t:s0 tclass=dir permissive=0 avc:  denied  { read } for  pid=1363 comm="libvirt_leasesh" name="cap_last_cap" dev="proc" ino=13638 scontext=system_u:system_r:virt_leaseshelper_t:s0 tcontext=system_u:object_r:sysctl_kernel_t:s0 tclass=file permissive=0 avc:  denied  { open } for  pid=1359 comm="libvirt_leasesh" path="/proc/sys/kernel/cap_last_cap" dev="proc" ino=2909 scontext=system_u:system_r:virt_leaseshelper_t:s0 tcontext=system_u:object_r:sysctl_kernel_t:s0 tclass=file permissive=0 avc:  denied  { getattr } for  pid=1375 comm="libvirt_leasesh" name="/" dev="proc" ino=1 scontext=system_u:system_r:virt_leaseshelper_t:s0 tcontext=system_u:object_r:proc_t:s0 tclass=filesystem permissive=0
Date: Wed, 27 May 2026 14:10:02 +0530
Message-ID: <20260527084002.1125102-1-gmisra@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: JJeG4HMw4VqyD_AM2GHhTV84AksyofqD
X-Authority-Analysis: v=2.4 cv=CY84Irrl c=1 sm=1 tr=0 ts=6a16ade7 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=-vbZ1Io1qTe7wVCr:21 a=R8wtq3ddXiUA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=KTATZuYoSMOckcxMRwEA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA4MSBTYWx0ZWRfXz4HDbauteBhB
 uh+6MSl7bNDZVJ8HRPbjgKJ0uRD5ePg3sps9EGelMK8QPykbYWtiwlf1KOvo+pMMiomnAZ/8hX0
 Cvfh2eTrF+KiyvR1W/ARQKipQdhGOmAU4e8Q7kX3VEOL54354QinHcI3JdwdBy+zQAobS3+ABLv
 vnxpK9oLaoqsdE5oK2DG5s91T71etbygqidF5fLLWtiU3ujb9o37Hd0fdLnJDyMeHHeffaaMvYW
 ejbLhJNm4StEO9JoIJ5fr/qJELhDW0gUDWhWyYViwXbZYjzm0eph2J1Hyw05ow4sZTeiNGMnS/1
 XF+q6Ih8/6Dw0FYVYuFsXlF+RJweamNta53UlE5ibI3lgLSw3/4PI1J13mauSRf8Yw+A/aaOstH
 sVqduQ2//BRxjoM1C9QxIrdlcnQM3UqNkSzZbq/ivPj9YG+0D4oVYrnKGcGjXdlGWcyZN0dTp1z
 taUykg3b4NYXEz2slHQ==
X-Proofpoint-ORIG-GUID: JJeG4HMw4VqyD_AM2GHhTV84AksyofqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270081
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:40:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4067

Upstream-Status: Merged [ https://github.com/SELinuxProject/refpolicy/pull/1117/changes/a7d4c1333edee3ea6b532979ae6d940360489793 ]

Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
---
 ...Added-read-and-search-permission-on-.patch | 39 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 40 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0061-libvirt_leasesh-Added-read-and-search-permission-on-.patch

diff --git a/recipes-security/refpolicy/refpolicy/0061-libvirt_leasesh-Added-read-and-search-permission-on-.patch b/recipes-security/refpolicy/refpolicy/0061-libvirt_leasesh-Added-read-and-search-permission-on-.patch
new file mode 100644
index 0000000..0aaf5be
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0061-libvirt_leasesh-Added-read-and-search-permission-on-.patch
@@ -0,0 +1,39 @@
+From c6007734e59828abcbb5c03e09dbe2facff07b4d Mon Sep 17 00:00:00 2001
+From: Gargi Misra <quic_gmisra@quicinc.com>
+Date: Wed, 27 May 2026 13:51:58 +0530
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
+Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
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


