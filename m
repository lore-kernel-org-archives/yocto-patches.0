Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D37DD79773
	for <webhook@archiver.kernel.org>; Sat, 31 Jan 2026 14:07:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7539.1769768957512878015
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 Jan 2026 02:29:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@qualcomm.com header.s=qcppdkim1 header.b=RX4/rHm/;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.168.131, mailfrom: gyenugul@qti.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U4bTpa1485353
	for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 10:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Fjq4w3SvKw8LQyrqKyFGPz
	WHRxjrqHO/ZhrPXE+PRIY=; b=RX4/rHm/9egYQlPIwZBx14fn6G1NsS3eLBXKDI
	hqcPwOO+irW0LoSMveNkeU0g5VytHmNVIkyq2e38qb64R2l2ssUBjsYXELT8FjaE
	zTco58fBuwKd7nu2XxUxxyIAVfQkGWvnFYqqxpZM7SnKu6/F7h9YmXO9zfLwK3PL
	GvbuPXy65mMhL+LT+UYAPFiV734iVRIjRuw1M8sYQ4nBZVH6QL7JZESKthwAgHdH
	LtYZnoCUViYrzqHjus5YKFqO6ORO/lIADlhC+QI4w9Ak2IRVclOPhoFQKGD2CzV/
	rBK/C2/vaoKNMxc3fKT8Ta90WOiHMkL7JovETA63AlmF/a8g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0nsf90cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 10:29:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 60UATGtM013874
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 10:29:16 GMT
Received: from hu-gyenugul-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 30 Jan 2026 02:29:14 -0800
From: "Ganga Bhavani Yenugula" <gyenugul@qti.qualcomm.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
Subject: [meta-selinux][PATCH] pd-mapper: Introduce SELinux domain for pd-mapper
Date: Fri, 30 Jan 2026 15:58:53 +0530
Message-ID: <20260130102853.2437991-1-gyenugul@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WbuD0kIRqoGIgerdepCm0sA1j4soq5uj
X-Authority-Analysis: v=2.4 cv=EvjfbCcA c=1 sm=1 tr=0 ts=697c87fc cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=3yM-Fun2whKcO63rMjIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WbuD0kIRqoGIgerdepCm0sA1j4soq5uj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA4NCBTYWx0ZWRfXzHLBZiBGvMWy
 3bXOa8WR978a1VMNlwOACrz4eucPsUxNxIg5iZERB/2DBoWnQUEZwWkt+JcOKGxBRrQKCaZuwAR
 wQpCUnU5UccTRRfs+vujZKm5w3WFku2PN6RPzEU73KFeVqON6b4JjDZqNUEBRl/WpruhhqTjxOW
 /wQV+EnTO21cWXHlFz6BH/74u1d2W+u21CGgo9SEkfVohid0A4ygSYTfDl16D8wKVWu3S0mpquh
 ehb7JVghVsgojyeDhMQ0Sw3Uy0AQwJKRw3LCVdYBKzSAWsRB/Yh0wAaaOry+6qtFk8AFcWlCs/H
 hSmymyK45UHZCXn91Qi/q9tLHnwKrS/q9H0KEA66+Vgqv2G+6dXK6VetnsvoqvpQpHH4pdfiQXb
 hKU20Rw21KjiTM/XOx5Sy51mGJ6JGse3qGnp9LUSqHmPbNQQyxB9JQTUUZkhCi7yir4N5FMqOsM
 MvOE7EmXMjzon1z34Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300084
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0031df01.pphosted.com id 60U4bTpa1485353
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 14:07:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3154

From: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>

Define a dedicated domain (`pd_mapper_t`) to confine pd-mapper service, e=
nsuring
it operates in a restricted environment isolated from other init processe=
s.

Grant the necessary permissions to resolve AVC denials observed during
the transition to enforcing mode:

 - Filesystem: Authorize read access to `/sys`.
 - Socket: Allow creation and basic use of qipcrtr_socket

Signed-off-by: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
---
 ...troduce-SELinux-domain-for-pd-mapper.patch | 73 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0057-pd-mapper-I=
ntroduce-SELinux-domain-for-pd-mapper.patch

diff --git a/recipes-security/refpolicy/refpolicy/0057-pd-mapper-Introduc=
e-SELinux-domain-for-pd-mapper.patch b/recipes-security/refpolicy/refpoli=
cy/0057-pd-mapper-Introduce-SELinux-domain-for-pd-mapper.patch
new file mode 100644
index 0000000..ec89ca9
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0057-pd-mapper-Introduce-SELin=
ux-domain-for-pd-mapper.patch
@@ -0,0 +1,73 @@
+From 29630f1034ebaaccdf10366f23616367ae138f1e Mon Sep 17 00:00:00 2001
+From: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
+Date: Thu, 22 Jan 2026 16:14:50 +0530
+Subject: [PATCH] pd-mapper: Introduce SELinux domain for pd-mapper
+
+Define a dedicated domain (`pd_mapper_t`) to confine pd-mapper service, =
ensuring
+it operates in a restricted environment isolated from other init process=
es.
+
+Grant the necessary permissions to resolve AVC denials observed during
+the transition to enforcing mode:
+
+ - Filesystem: Authorize read access to `/sys`.
+ - Socket: Allow creation and basic use of qipcrtr_socket
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/p=
ull/1070/changes/c8aef7c55e8768378c6adeda7e8edfaeecb9fa28]
+
+Signed-off-by: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
+---
+ policy/modules/services/pd_mapper.fc |  1 +
+ policy/modules/services/pd_mapper.if | 10 ++++++++++
+ policy/modules/services/pd_mapper.te | 15 +++++++++++++++
+ 3 files changed, 26 insertions(+)
+ create mode 100644 policy/modules/services/pd_mapper.fc
+ create mode 100644 policy/modules/services/pd_mapper.if
+ create mode 100644 policy/modules/services/pd_mapper.te
+
+diff --git a/policy/modules/services/pd_mapper.fc b/policy/modules/servi=
ces/pd_mapper.fc
+new file mode 100644
+index 000000000..3d83d46b1
+--- /dev/null
++++ b/policy/modules/services/pd_mapper.fc
+@@ -0,0 +1 @@
++/usr/bin/pd-mapper      --      gen_context(system_u:object_r:pd_mapper=
_exec_t,s0)
+diff --git a/policy/modules/services/pd_mapper.if b/policy/modules/servi=
ces/pd_mapper.if
+new file mode 100644
+index 000000000..34da5143f
+--- /dev/null
++++ b/policy/modules/services/pd_mapper.if
+@@ -0,0 +1,10 @@
++## <summary>pd-mapper</summary>
++#
++## <desc>
++## Qualcomm=E2=80=99s pd=E2=80=91mapper service is the userspace Protec=
tion Domain mapper
++## that enables applications to access remote processors
++## (Wi=E2=80=91Fi, modem, sensors, etc.)
++## on Qualcomm SoCs via the QRTR protocol.
++##
++## https://github.com/linux-msm/pd-mapper
++## </desc>
+diff --git a/policy/modules/services/pd_mapper.te b/policy/modules/servi=
ces/pd_mapper.te
+new file mode 100644
+index 000000000..34a8d6bcc
+--- /dev/null
++++ b/policy/modules/services/pd_mapper.te
+@@ -0,0 +1,15 @@
++policy_module(pd_mapper)
++
++########################################
++#
++# Declarations
++#
++
++type pd_mapper_t;
++type pd_mapper_exec_t;
++init_daemon_domain(pd_mapper_t, pd_mapper_exec_t)
++
++allow pd_mapper_t self:qipcrtr_socket connected_socket_perms;
++
++# Read /sys/devices/platform/soc@0/2a300000.remoteproc/remoteproc/remot=
eproc2/firmware
++dev_read_sysfs(pd_mapper_t)
+--=20
+2.34.1
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-se=
curity/refpolicy/refpolicy_common.inc
index 59dfecd..9d74c85 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -72,6 +72,7 @@ SRC_URI +=3D " \
         file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd=
.patch \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr=
.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t=
.patch \
+        file://0057-pd-mapper-Introduce-SELinux-domain-for-pd-mapper.pat=
ch \
         "
=20
 S =3D "${UNPACKDIR}/refpolicy"
--=20
2.34.1


