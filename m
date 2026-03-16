Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C3F46440
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 09:47:30 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46967.1773653792339919344
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 02:36:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=LxRWlsve;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.168.131, mailfrom: jaihindy@qti.qualcomm.com)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64hpo1724726
	for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 09:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TOFAGUdinMuqK/qmNga01H
	s2aKGLrJbRR1pCu1EqGoc=; b=LxRWlsveRonQ8uN6ZuPP0YfRqFZrwpoUUiS18C
	C1JML2WUU06c4TLFAL/uzCqeL1nBirBwV4LHKI/imYuW94NdJtr75vr6OGu6PtZF
	XDMfGs6xfY+T8nTSM4QbNhjGnMSAjqqr+JNejsRHyGbSXXgYxCuwWOxyI+W2wfTj
	+aHAYAi//mV06eGvc9iHnOW7JxHrW6el1iQBc0G8aRdqCm839SFVL9PuYszzQd5D
	Dh9PaQd1eOvRZxGn2/YrhyAlmJbk9cR/GRppuH0bDS1rwAMpdZTZzEpL4mUsv2KW
	VggSmXul/I7B0TdGvJGaBa/5d0/bqBeY3kC2r7YHq4Uui4xQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0udmxvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 09:36:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 62G9aVW6012813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 09:36:31 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 02:36:29 -0700
From: "Jaihind Yadav" <jaihindy@qti.qualcomm.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Subject: [meta-selinux][PATCH] refpolicy: backport systemd user runtime userdb fix
Date: Mon, 16 Mar 2026 15:06:19 +0530
Message-ID: <20260316093619.3748852-1-jaihindy@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=BJ2+bVQG c=1 sm=1 tr=0 ts=69b7cf1f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=nvOdHxuAUMFyEE8N2rIA:9
X-Proofpoint-GUID: vyYpT-6HHy1eLzS_4QIB8BAWZT_5GaqH
X-Proofpoint-ORIG-GUID: vyYpT-6HHy1eLzS_4QIB8BAWZT_5GaqH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3MyBTYWx0ZWRfX3zhQpsfViFUi
 RHIK0AvVevVHAcj9E6xtGviZ4coqkWTBUSiod+8E9eCWsZrN7vVIrQA3PP8KaSLNewhSht4UdaB
 aBISccZ2QScCflv2zplEJQhaUBYJJBVLusKzVT8tMcOOyy+PzScnh7Qk5Tf88tDvr/pP7mNg9M5
 mJ9DxLOqYGxQhnBrPRz0AWVLqWK68tBY1+WCroYuY2Eg1QlBzCI5dJDGclVEy+GYhcWAvjmFMMU
 9xFfxhOOj4LCU0+5GVzuHXAddVhmOwgIV0Z9QzlquTcsNAl2gUvUdq7pdL81VSo3KT9Lm5iY+jq
 VCv3r3zzp3DhGENv2bt2R5c9Lw2UGWn8jcT+cmBe4ERphmwlcHXWTBMHAKALNk5BK3oL5OboXcy
 2lT//76VMUd8dpDpe+1QgTAkxve9fj7S0p65UZv5gtYhJSV20PPuZ9Yd2wkJOeFadRM9pm92MMz
 hqdLs6eNhPWzjf0w/xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160073
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 09:47:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3470

Backport upstream refpolicy change that switches systemd user runtime
client to use systemd_stream_connect_userdb().

This fixes AVC denials for connectto and sock_file write on
io.systemd.Multiplexer when systemd-userdbd is enabled.

Upstream-Commit: b3060023318b474d0112fbe70cdbbf6dbb1f37ab
Link: https://github.com/SELinuxProject/refpolicy/pull/1092

Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
---
 ...d-fix-user-runtime-userdb-connection.patch | 34 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 35 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-policy-modules-systemd-fix-user-runtime-userdb-connection.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-policy-modules-systemd-fix-user-runtime-userdb-connection.patch b/recipes-security/refpolicy/refpolicy/0059-policy-modules-systemd-fix-user-runtime-userdb-connection.patch
new file mode 100644
index 0000000..0b15d9b
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-policy-modules-systemd-fix-user-runtime-userdb-connection.patch
@@ -0,0 +1,34 @@
+From b3060023318b474d0112fbe70cdbbf6dbb1f37ab Mon Sep 17 00:00:00 2001
+From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
+Date: Thu, 5 Mar 2026 11:59:31 +0530
+Subject: [PATCH] systemd: use systemd_stream_connect_userdb() for user runtime
+ client
+
+Replace a direct stream_connect_pattern() usage with the existing
+systemd_stream_connect_userdb() interface. This allows systemd user
+runtime helper to connect to systemd-userdbd and access the related
+runtime socket/link objects under /run/systemd/userdb.
+
+Fixes AVCs for connectto and sock_file write on io.systemd.Multiplexer.
+
+Upstream-Status: Backport [b3060023318b474d0112fbe70cdbbf6dbb1f37ab]
+Link: https://github.com/SELinuxProject/refpolicy/pull/1092
+
+Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
+---
+ policy/modules/system/systemd.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
+index 4c81584706..d8a62eb882 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -2443,7 +2443,7 @@ allow systemd_user_runtime_dir_t systemd_user_runtime_notify_t:sock_file delete_
+ 
+ allow systemd_user_runtime_dir_t systemd_userdbd_runtime_t:dir list_dir_perms;
+ 
+-stream_connect_pattern(systemd_user_runtime_dir_t, systemd_userdbd_runtime_t, systemd_userdbd_runtime_t, systemd_userdbd_t)
++systemd_stream_connect_userdb(systemd_user_runtime_dir_t)
+ 
+ files_read_etc_files(systemd_user_runtime_dir_t)
+ # read /etc/machine-id
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 2e1a929..998be7c 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI += " \
         file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0059-policy-modules-systemd-fix-user-runtime-userdb-connection.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"

