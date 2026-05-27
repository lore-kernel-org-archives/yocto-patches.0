Return-Path: <gmisra@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B07CD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 10:19:34 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17242.1779877165978728438
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 03:19:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=BWZmIc1a;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: gmisra@qualcomm.com)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8mT882152271
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lvrP+cyCtpM/rf3MNgssa2G1vAL6jacvA08
	tStaI4J8=; b=BWZmIc1aEkJ28E+nfV6JOriJ2dcqjkqG4wVPwMMUxjXMeAHWRps
	ef3Dtf8IAowRNv9hwvULfEPtQOZdnpJxOpSqIE1SIIdDdQvf9f0kSLtMcO8dWQmD
	3ItrgdgLkEYFSpI+A+vKJEeEKpaxfJVkPqzVPxH2i1zPnryEALXk6aXbMCV/rgVg
	GfHcKvqq0Rx1gqcDRL/es6H/OyELKxUvXCoPp5cK3KVkPUTieR6MXeAcQtz7/+Bj
	sYXin5g6I7xBUIi+lNVw50nevOSHGt5waIta/8kRNaRtqRAu6POrp7bNSyOfWat/
	8SHVrZi+RiVSET7vTbuwncBdyCBCIkySx0Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edu6rgxfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:19:25 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RAJMpU003008;
	Wed, 27 May 2026 10:19:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ajk8ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:19:22 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64RAJLsR003002
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:19:21 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-gmisra-hyd.qualcomm.com [10.213.99.33])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64RAJLan003001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 10:19:21 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4467585)
	id 3A8A8214EF; Wed, 27 May 2026 15:49:21 +0530 (+0530)
From: Gargi Misra <gmisra@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Gargi Misra <gmisra@qti.qualcomm.com>
Subject: [meta-selinux][PATCH1/3] refpolicy: Addressing denial seen on alsa to allow write on  event dev node
Date: Wed, 27 May 2026 15:49:03 +0530
Message-ID: <20260527101903.1480413-2-gmisra@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=MoJiLWae c=1 sm=1 tr=0 ts=6a16c52d cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=RZau8XZcO4KK9KFBaN4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA5OSBTYWx0ZWRfX8VlQlfrKgpQB
 gxmEZXz/F8+97zg7R1MbLPoetAgtKF8/xeEX1sg27odb2bHrhA7R1WSfA+By2ihkaiBCOzCAFVc
 xiOlzI3tiqsAPvIwOOyxlaGlpoKTBOMLlv2zfUTZFVWkk1KKGDMMmbv5G1HwlLUn6ic/pGrjic2
 XgFBP5xvK9yrHWBZ/vq6fRG/ndu6FwWzP0P2coKBUgvFCA8g/sKhuGQNijgGBlobwk+O+7OGbn/
 ja2Jmnp8bI4WexHIxoRwSbION2MR0nk0iF/zVa0tR4sLVjLK5UcMJAifAUGVliSLIQYt+BMtXee
 PPFKXg+h8OICZrVPUI2qFV7NcWkMpFDimXgrdbCA2krS+D4e1IvV+vPPnLoGGf4nuJ+ocO/EgHs
 PbT6yminlZefdrOlgHcOidkfZBqsQzSCK8b5g/oavQGPNPNcsV0Tu5zc20Rv74yUr7cjAM/BO1B
 9F+33P3wG4n/pYqJqJQ==
X-Proofpoint-GUID: MF8IlgzSbtN9_icshMlyLgIikspCosHz
X-Proofpoint-ORIG-GUID: MF8IlgzSbtN9_icshMlyLgIikspCosHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270099
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:19:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4069

avc:  denied  { write } for  pid=792 comm="alsactl" name="controlC0" dev="devtmpfs" ino=1613 scontext=system_u:system_r:alsa_t:s0 tcontext=system_u:object_r:event_device_t:s0 tclass=chr_file permissive=0

Upstream-Status: Backport [ https://github.com/SELinuxProject/refpolicy/pull/1117/changes/e0fd56a58954dc234b1a4d5ca30d4e80f84edd31 ]

Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
---
 ...olicy-Addressing-denial-seen-on-alsa.patch | 30 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-refpolicy-Addressing-denial-seen-on-alsa.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-refpolicy-Addressing-denial-seen-on-alsa.patch b/recipes-security/refpolicy/refpolicy/0059-refpolicy-Addressing-denial-seen-on-alsa.patch
new file mode 100644
index 0000000..04ca51e
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-refpolicy-Addressing-denial-seen-on-alsa.patch
@@ -0,0 +1,30 @@
+From 38b0116d8504a9c4cc7d9d322fe83ac689a295f6 Mon Sep 17 00:00:00 2001
+From: Gargi Misra <quic_gmisra@quicinc.com>
+Date: Wed, 27 May 2026 13:49:35 +0530
+Subject: [PATCH] refpolicy: Addressing denial seen on alsa to allow write on
+ event dev node
+
+avc:  denied  { write } for  pid=792 comm="alsactl" name="controlC0" dev="devtmpfs" ino=1613 scontext=system_u:system_r:alsa_t:s0 tcontext=system_u:object_r:event_device_t:s0 tclass=chr_file permissive=0
+
+Upstream-Status: Backport [ https://github.com/SELinuxProject/refpolicy/pull/1117/changes/e0fd56a58954dc234b1a4d5ca30d4e80f84edd31 ]
+
+Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
+---
+ policy/modules/admin/alsa.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/admin/alsa.te b/policy/modules/admin/alsa.te
+index 37d04a9e5..fd967cb82 100644
+--- a/policy/modules/admin/alsa.te
++++ b/policy/modules/admin/alsa.te
+@@ -87,6 +87,7 @@ dev_read_sound(alsa_t)
+ dev_read_sysfs(alsa_t)
+ dev_read_urand(alsa_t)
+ dev_write_sound(alsa_t)
++dev_rw_input_dev(alsa_t)
+ 
+ files_read_usr_files(alsa_t)
+ files_search_var_lib(alsa_t)
+-- 
+2.43.0
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 014714c..c43ff03 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI += " \
         file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0059-refpolicy-Addressing-denial-seen-on-alsa.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
-- 
2.43.0


