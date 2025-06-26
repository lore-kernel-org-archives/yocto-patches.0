Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DB8C7115B
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 05:46:00 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.1760.1750916755431840937
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 22:45:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8272e65e7e=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q5dllx013196
	for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 05:45:54 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47dhy2n81p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 05:45:54 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Wed, 25 Jun 2025 22:45:48 -0700
Received: from blr-linux-engg1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Wed, 25 Jun 2025 22:45:47 -0700
From: ssambu <soumya.sambu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 1/1] python3-strict-rfc3339: fix invalid command 'bdist_wheel'
Date: Thu, 26 Jun 2025 11:15:45 +0530
Message-ID: <20250626054545.1237276-1-soumya.sambu@windriver.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA0NCBTYWx0ZWRfX4RZFCKbc0mix Z0D8Qx3IK5QijLcS24Q96443A4DUqcH1CsN2gzLbhyJs8eAedj3KgHYnHwCZPhlnP6PINLj9zZs aAovyM+WPgX03kUqJh401cZtG64Xhu+qYDtUJgMiY1OkxGlftYTlsJtiJ6aF3tUS7AO6fhUCTKl
 zcxJh6WFYXkwyWVGqohrDq7WAhMR12j7JDUuCblHw800zbukWynvOBO3d7F5XXltA+cd1vUv1Ld 36P1PO1tHDvlviQrIYa/Pn3ja2ILaOwCmKlJao7+CUOS+j+sAl9MUcLF2mKgthQATwgy9/TWllB emehXfObPafj55ZZErU9zcbBSBG8N8rgphWFyK77NIRRbQlC/YhZ+Vf0p3dmiC7HYEWFPiHR82I
 7w+FT1+CHyFy02hT0TqPJsGg3vncGMNZBJkhhgLDCbx42zUOhNLDsa1brczsAUvI93c7ZLuI
X-Authority-Analysis: v=2.4 cv=Qblmvtbv c=1 sm=1 tr=0 ts=685cde92 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=KuCMGVAfJcUA:10 a=6IFa9wvqVegA:10 a=t7CeM3EgAAAA:8 a=m__NNN433p-mM7ecbz8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: OrvpeIq3EYDqsxqSXOmBbG2KnjkzKxN3
X-Proofpoint-GUID: OrvpeIq3EYDqsxqSXOmBbG2KnjkzKxN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_02,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=971 mlxscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506260044
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 05:46:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1697

From: Soumya Sambu <soumya.sambu@windriver.com>

With mixins setuptools, python3-strict-rfc3339 fails to compile with error:
    error: invalid command 'bdist_wheel'
    ERROR: 'python3 setup.py bdist_wheel ' execution failed.

Switching setup import from setuptools._distutils.core to setuptools fixed the issue.

Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
---
 ...setup-from-setuptools-instead-of-dis.patch | 23 +++++++++++++++++++
 .../python/python3-strict-rfc3339_%.bbappend  |  4 ++++
 2 files changed, 27 insertions(+)
 create mode 100644 dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339/0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch
 create mode 100644 dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339_%.bbappend

diff --git a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339/0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339/0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch
new file mode 100644
index 0000000..e424380
--- /dev/null
+++ b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339/0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch
@@ -0,0 +1,23 @@
+From 1d583ecd2d6376252fcced66068a2482fec0dfbf Mon Sep 17 00:00:00 2001
+From: Soumya Sambu <soumya.sambu@windriver.com>
+Date: Wed, 25 Jun 2025 17:26:35 +0530
+Subject: [PATCH] setup.py: import setup from setuptools instead of distutils
+
+Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
+---
+ setup.py | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/setup.py b/setup.py
+index a49fb8e..5279707 100644
+--- a/setup.py
++++ b/setup.py
+@@ -1,5 +1,5 @@
+ import os.path
+-from setuptools._distutils.core import setup
++from setuptools import setup
+
+ readme_file = os.path.join(os.path.dirname(__file__), 'README.md')
+ readme = open(readme_file).read()
+--
+2.40.0
diff --git a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339_%.bbappend b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339_%.bbappend
new file mode 100644
index 0000000..d694d20
--- /dev/null
+++ b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339_%.bbappend
@@ -0,0 +1,4 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
+
+SRC_URI += "\
+            file://0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch"
-- 
2.40.0


