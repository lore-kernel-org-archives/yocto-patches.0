Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2ACCCD199
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 07:24:14 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.web11.12644.1760945052770117333
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 00:24:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=CRSmSPZQ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JNxN43001615
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=HbWb2OBHL/PLFwA7o0Z+dP2Vmghv/mZq+mZ
	W0Z0+YP8=; b=CRSmSPZQPLPlP3qRpvtbTJnNiWG7WbXPr5OlwJh/wiMqal19uUe
	3If+g0yJk3iELkt3g+VW+vqNvIlY/BpO+iDY7wgfiYaAzGHM17rZK8LJFja1+qbn
	zxSYjijBTDb/owk1wi6r5nhyQhZ71CLzjxfrTXaYECrCZgx+7hzIa/eDrigySvG3
	AfrPZRj+iarayiQzyl6oT2mgnlAEndxa71Ejcfh/etAlHr40oaq2GunwNh6tsVKF
	Fb2SZbpCxcg1B/5KsYB891VgxZR5FQ0PnQpdcG9dt+V1pbIsYISMgfSBKNnA1YWX
	GAWOMhqDOR6Pv5hjwryuDCY2iOnFrO7zj/w==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gduy8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:24:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59K7O8xZ011267
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:24:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 49v3ykq5r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:24:08 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59K7O73w011262
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:24:07 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 59K7O73K011261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 07:24:07 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id 7B82E5C7; Mon, 20 Oct 2025 12:54:06 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH] refpolicy: Remove build path reference from file_contexts.homedirs
Date: Mon, 20 Oct 2025 12:54:03 +0530
Message-Id: <20251020072403.1237419-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX4pAb7+vXKyV8
 hQ2BJ4gQMgWwHxGpVSjVvN5xkVW2IDK7PJtv73bgOCYcFmlqaV35DkVg0NFRNDCCXZqNUxO/fi5
 SttjjFQfKNw+RHJUGB/Lwthn8nogVpTCTE5FNi7XpGhsAjIoY4s2RgJBiHlXpTJXsmRRYD3etrv
 1stzMbL4zyaoIQPZ+zfQBCsMxTSXjTc3FhhcaPG6FbNf4Evad6Na1oATiuduXmJLYo09JNRsIVH
 6MDNNcFrnw1BY7GV4zjzFXgUPKwbv8+hqcrDNHspiplKGCNwjIDu5hhVHDKQPi2lqh1gqh0YUib
 9OEEDVkT6a7z1a2B01SCEx7bfxltCif+HCz0BDI8+ihUl3oiDZZIH/C3AQbCQb1/dFz+V098Uos
 MNiTrF5p8F0eHctStHLg8qgSuY5jEA==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f5e39b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=-Axzdxy3En8sPjE_xngA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JPPm6vTElWdTfKl0uNsu6pO0qXVCurK3
X-Proofpoint-ORIG-GUID: JPPm6vTElWdTfKl0uNsu6pO0qXVCurK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 07:24:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2353

The heading() function in genhomedircon.py included a comment referencing the
absolute path to the local.users file, which resides under TMPDIR during Yocto
builds. This caused the package QA check 'buildpaths' to fail due to the presence
of build-time paths in the final packaged output.

Reference:
The below commented lines are in filecontexts.homedirs file as a header,
which contains TMPDIR path. So, do_package_qa is flagging this issue in
case of MONOLITHIC design.

To resolve this, the line generating the comment with the full path was removed,
preventing unnecessary QA errors and ensuring cleaner policy files.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 ...move-build-path-reference-from-gener.patch | 36 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  3 +-
 2 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 recipes-security/refpolicy/refpolicy/0057-genhomedircon-remove-build-path-reference-from-gener.patch

diff --git a/recipes-security/refpolicy/refpolicy/0057-genhomedircon-remove-build-path-reference-from-gener.patch b/recipes-security/refpolicy/refpolicy/0057-genhomedircon-remove-build-path-reference-from-gener.patch
new file mode 100644
index 0000000..af9bba3
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0057-genhomedircon-remove-build-path-reference-from-gener.patch
@@ -0,0 +1,36 @@
+From f584d80dc13f63119af53618350fd8262f17fe63 Mon Sep 17 00:00:00 2001
+From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
+Date: Fri, 17 Oct 2025 11:51:15 +0530
+Subject: [PATCH] genhomedircon: remove build path reference from generated
+ file_context.homedirs header
+
+The heading() function in genhomedircon.py included a comment referencing the
+absolute path to the local.users file, which resides under TMPDIR during Yocto
+builds. This caused the package QA check 'buildpaths' to fail due to the presence
+of build-time paths in the final packaged output.
+
+To resolve this, the line generating the comment with the full path was removed,
+preventing unnecessary QA errors and ensuring cleaner policy files.
+
+Upstream-Status: Pending
+
+Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
+---
+ support/genhomedircon.py | 1 -
+ 1 file changed, 1 deletion(-)
+
+diff --git a/support/genhomedircon.py b/support/genhomedircon.py
+index b865a07c8..e7685545f 100644
+--- a/support/genhomedircon.py
++++ b/support/genhomedircon.py
+@@ -157,7 +157,6 @@ class selinuxConfig:
+ 
+ 	def heading(self):
+ 		ret = "\n#\n#\n# User-specific file contexts, generated via %s\n" % sys.argv[0]
+-		ret += "# edit %s to change file_context\n#\n#\n" % self.getUsersFile()
+ 		return ret
+ 
+ 	def getUsers(self):
+-- 
+2.34.1
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index cf32723..aa782ca 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -72,7 +72,8 @@ SRC_URI += " \
         file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
-        "
+        file://0057-genhomedircon-remove-build-path-reference-from-gener.patch \
+	"
 
 S = "${UNPACKDIR}/refpolicy"
 
-- 
2.34.1


