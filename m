Return-Path: <gmisra@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F52CD5BDE
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 08:33:25 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15592.1779870801126074007
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 01:33:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=BdKoln9D;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: gmisra@qualcomm.com)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8GDmU504975
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/q/6FcF6bTzCureajfbLJ6cJXrPOJEtBZ8k
	FqbzqB68=; b=BdKoln9DiclMCEfV4GTfObZrWVOSohjVcQ33GNnw4hAFiwKNnB0
	bX31XjX2KVvt4v19By4/FFsWXO+iKNapOPr4MADseXrqbkAMZk2cUX+iUBLd25tE
	sSyLmZYl8tJOK9UfgsJmBrXCuNozjfu0CkSn9Et8rTX2l1h0rgep6DUtDv/ungJv
	16xlY0Jd2xTyWoHpnQb2tmNAZK1wxdABPNjU9+txcQg5AC83K9rDrKk9LBCJBbJp
	ohll07DYvqUxprTMDvWLlExBlkJAd90DYBJquOscmStlz6li8wtbOC6yniorW3Bx
	IEn0R2XkAuoBvJ9psZ+FoOcxnPTQO/siVgQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edentk4hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:33:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R8XGgV032522;
	Wed, 27 May 2026 08:33:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ajjbda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:33:16 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64R8XGNF032517
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:33:16 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-gmisra-hyd.qualcomm.com [10.213.99.33])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64R8XFs5032515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 08:33:16 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4467585)
	id 17D6921427; Wed, 27 May 2026 14:03:15 +0530 (+0530)
From: Gargi Misra <gmisra@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Gargi Misra <gmisra@qti.qualcomm.com>
Subject: [meta-selinux][PATCH1/3] refpolicy: Addressing denial seen on alsa to allow write on event dev node
Date: Wed, 27 May 2026 14:02:56 +0530
Message-ID: <20260527083256.1119333-1-gmisra@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=Ja+Ma0KV c=1 sm=1 tr=0 ts=6a16ac4f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=RZau8XZcO4KK9KFBaN4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NpdxCYoW1GDaFgaKv7VyI0Pr3DQThVin
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA4MSBTYWx0ZWRfX0WXHw760zJfj
 kf0lC365a+vSyDj/3a3eiruR1eFmlNEkuBF8KdsoICJdsV+OWAZf2TtFYR5iEGNmjK0pWY8Lp8h
 jatwkNHNoB/qD9xItYqJJomaaYshedpXi0WbE9b4yVxeSgqkC3/zb4/HHr3FGprOzmVDrAiAqD6
 xbS4PaYT1b4Fq8FotpFyMOOyLDeXgXiV81PCc9P5Gfvgo6c34uhYIpUXhxHbx4yc6pyUn1y+z09
 Tb4Vd6icHEeF0RGJ2/6wGNObSmSHgrfqKj6b9lF4dadHRKJLx/Pq2euc2vmm4jtF4HpWBwClZys
 Ob5KkyD+o1sbEsjn6ReC4AZfmlGD0E/eTj0ziJQXnyPgrroVri+skuClSdLEmdg9sqX0VenC9k1
 Lr5eXWvkVIcxxmhtKXQtSfBjHtuyD9uUPXBPTAz2rLeRaF4N+klxSNIyr7eGIGdbfNvGTTueoSQ
 hSnw9aPD6O4Ueth5KTw==
X-Proofpoint-GUID: NpdxCYoW1GDaFgaKv7VyI0Pr3DQThVin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270081
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 08:33:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4065

avc:  denied  { write } for  pid=792 comm="alsactl" name="controlC0" dev="devtmpfs" ino=1613 scontext=system_u:system_r:alsa_t:s0 tcontext=system_u:object_r:event_device_t:s0 tclass=chr_file permissive=0

Upstream-status: Merged [ https://github.com/SELinuxProject/refpolicy/pull/1117/changes/e0fd56a58954dc234b1a4d5ca30d4e80f84edd31 ]

Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
---
 ...olicy-Addressing-denial-seen-on-alsa.patch | 28 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 29 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-refpolicy-Addressing-denial-seen-on-alsa.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-refpolicy-Addressing-denial-seen-on-alsa.patch b/recipes-security/refpolicy/refpolicy/0059-refpolicy-Addressing-denial-seen-on-alsa.patch
new file mode 100644
index 0000000..bef8fc1
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-refpolicy-Addressing-denial-seen-on-alsa.patch
@@ -0,0 +1,28 @@
+From 38b0116d8504a9c4cc7d9d322fe83ac689a295f6 Mon Sep 17 00:00:00 2001
+From: Gargi Misra <quic_gmisra@quicinc.com>
+Date: Wed, 27 May 2026 13:49:35 +0530
+Subject: [PATCH] refpolicy: Addressing denial seen on alsa to allow write on
+ event dev node
+
+avc:  denied  { write } for  pid=792 comm="alsactl" name="controlC0" dev="devtmpfs" ino=1613 scontext=system_u:system_r:alsa_t:s0 tcontext=system_u:object_r:event_device_t:s0 tclass=chr_file permissive=0
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


