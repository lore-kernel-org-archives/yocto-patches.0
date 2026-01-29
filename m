Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FC2D358EC
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 09:35:45 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10981.1769675740598995132
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Jan 2026 00:35:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@qualcomm.com header.s=qcppdkim1 header.b=HHdyAbsL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: gyenugul@qti.qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T2omK61521286
	for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 08:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UEFMFS3Fv0X2RsoTCft/0u
	atsrMLpS5xXBte9XlaCCs=; b=HHdyAbsLZDDHL5JuZJ4Ft7IYePh1EeZuuVt3KS
	LKsBD+dIqrAyo8wmJuOUSEyUy7rvC5XDGvALPl63G3f4K8WYxw7xf73ylHfD5INy
	b4Gw5mBDunDh79kJ/hWi5l02Vj70GOKLUpch4CSDwhA+ZXTmYB8t0rFptWH+v2xs
	VjIBio77k1zu8SciGt7TiAkjmKAKrrl5sEJi0bZZcUiSav8ROFII7R2PWTbcJk76
	YEBpY6aJulO7ngcYJKb6KQ8tXs6rMs2tvF3vGx1gLFVyl7m9GpHe7YttgE0dXtXU
	cmf3ElSl1J/lu2SfUdLHvqvFej6g3NkuEDcOV5qsBUQyYjHg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byjxhugpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 08:35:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 60T8ZckV013763
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 08:35:38 GMT
Received: from hyd-e160-a01-2-02.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 00:35:37 -0800
From: "Ganga Bhavani Yenugula" <gyenugul@qti.qualcomm.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
Subject: [PATCH] pd-mapper: Introduce SELinux domain for pd-mapper
Date: Thu, 29 Jan 2026 14:05:16 +0530
Message-ID: <20260129083517.647116-1-gyenugul@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 87k2SCiHCWeNax_pRpyjbbKUdkW2lJu8
X-Proofpoint-GUID: 87k2SCiHCWeNax_pRpyjbbKUdkW2lJu8
X-Authority-Analysis: v=2.4 cv=b9G/I9Gx c=1 sm=1 tr=0 ts=697b1bdb cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=KY-vJS-pLNiqLzBXIH4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA1MSBTYWx0ZWRfX+kja8hfWh4/u
 1f10R8jhnIsZisGQ4rCDdSHAoKYezCOnlQkwqwh/15zfCkgzuZGl9Yy11i+3E6s7Ld3GZwjUuqT
 fOSdESOaxNytrg0NNJEBvq8g5iFb9oxzT/Zu7a9W20IXzHS88FGQuICdGN+rG+BCao6pKAzSvYs
 dnJdDbd3c5NjIMJ/pPxrkeARb9GpeAvKtMk8qopyTwv2T+ZWZnqU0Uu55i67LvY6UGCBvESHn8o
 B4T+hKLgCCCjHlOQ+hyqpSfpa3HDrD2WaaZ50PRt13ZjfrCJ7molB2m8DNZpb7FRoWYCVkN7dpi
 kKvfvI0Z9lBr0QGlGs8eyJWedfMcT3ZKGZ8qKCnD2+FqVm0JGHZKYGMigdz9dkxGgBH0SE+J41/
 8mEQ4+JDjAdlJFlaaV+gc5mIJfyCMn2b86dSzuwggbIjSoMZ40fsP3+XSfROdQiiLIx0rt+fKBQ
 I2H6HEcoCSCIV2chdcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_01,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290051
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0031df01.pphosted.com id 60T2omK61521286
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 09:35:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3141

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

Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/pu=
ll/1070/changes/c8aef7c55e8768378c6adeda7e8edfaeecb9fa28]

---
 policy/modules/services/pd_mapper.fc |  1 +
 policy/modules/services/pd_mapper.if | 10 ++++++++++
 policy/modules/services/pd_mapper.te | 15 +++++++++++++++
 3 files changed, 26 insertions(+)
 create mode 100644 policy/modules/services/pd_mapper.fc
 create mode 100644 policy/modules/services/pd_mapper.if
 create mode 100644 policy/modules/services/pd_mapper.te

diff --git a/policy/modules/services/pd_mapper.fc b/policy/modules/servic=
es/pd_mapper.fc
new file mode 100644
index 000000000..3d83d46b1
--- /dev/null
+++ b/policy/modules/services/pd_mapper.fc
@@ -0,0 +1 @@
+/usr/bin/pd-mapper      --      gen_context(system_u:object_r:pd_mapper_=
exec_t,s0)
diff --git a/policy/modules/services/pd_mapper.if b/policy/modules/servic=
es/pd_mapper.if
new file mode 100644
index 000000000..34da5143f
--- /dev/null
+++ b/policy/modules/services/pd_mapper.if
@@ -0,0 +1,10 @@
+## <summary>pd-mapper</summary>
+#
+## <desc>
+## Qualcomm=E2=80=99s pd=E2=80=91mapper service is the userspace Protect=
ion Domain mapper
+## that enables applications to access remote processors
+## (Wi=E2=80=91Fi, modem, sensors, etc.)
+## on Qualcomm SoCs via the QRTR protocol.
+##
+## https://github.com/linux-msm/pd-mapper
+## </desc>
diff --git a/policy/modules/services/pd_mapper.te b/policy/modules/servic=
es/pd_mapper.te
new file mode 100644
index 000000000..34a8d6bcc
--- /dev/null
+++ b/policy/modules/services/pd_mapper.te
@@ -0,0 +1,15 @@
+policy_module(pd_mapper)
+
+########################################
+#
+# Declarations
+#
+
+type pd_mapper_t;
+type pd_mapper_exec_t;
+init_daemon_domain(pd_mapper_t, pd_mapper_exec_t)
+
+allow pd_mapper_t self:qipcrtr_socket connected_socket_perms;
+
+# Read /sys/devices/platform/soc@0/2a300000.remoteproc/remoteproc/remote=
proc2/firmware
+dev_read_sysfs(pd_mapper_t)
--=20
2.34.1


