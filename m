Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC40C7EE31
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 10:00:36 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.10039.1751018435185572489
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 03:00:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8273c62555=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R5Sh7r031959
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 03:00:34 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47dr14xfu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 03:00:34 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Fri, 27 Jun 2025 03:00:30 -0700
Received: from blr-linux-engg1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 27 Jun 2025 03:00:29 -0700
From: ssambu <soumya.sambu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH v3 1/1]  python3-strict-rfc3339: fix invalid command 'bdist_wheel'
Date: Fri, 27 Jun 2025 15:30:28 +0530
Message-ID: <20250627100028.455764-1-soumya.sambu@windriver.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1ZDNKjiFQTzZX2o4AjVBS_Z8jKWCirJ-
X-Proofpoint-GUID: 1ZDNKjiFQTzZX2o4AjVBS_Z8jKWCirJ-
X-Authority-Analysis: v=2.4 cv=XYKJzJ55 c=1 sm=1 tr=0 ts=685e6bc2 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=KuCMGVAfJcUA:10 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=m__NNN433p-mM7ecbz8A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4MiBTYWx0ZWRfXyaTI7edAaVij /tuIvVlu61aAU56cVa0YiU5A0dZrda4Y6rz82NAWWXuVY4wNdVbfth5VwqWVuSEaHOa81R3R0RW b7GbhlYcEDR2C/9yj/zBxXR2ifmZJ4jN2yZMV+THjTsoEhtV5s/sA8dHwExSN66ZhRLWDX18xwp
 u1RLdfIdlxd31TZl4kMHYRvbMoV/Tvz2uwzlkl43LemG6QZIA3E5yguL2MO7S7FipE+AecZ5uKN +MkIvxSTZC9WpklDGTrPFHKbQn4aLMEcM7Lx2rj0ILhKUze87b+1VUU/aHL3jrunSSNEzLEKVoT 0Wp90f9+4z+r7BoXiYlfbaSSvdiT9862l6yoYqFf3g3BHQlpI/oomLbggKs6e/zF3OEBDUxnOsh
 zOR3FqtC6WG+6tItJ6rex535RdDujndrU+2TxqdgD5DShW6aFRVxQNj5grVt/l8PColohP2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_03,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506270082
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 10:00:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1710

From: Soumya Sambu <soumya.sambu@windriver.com>

With mixins setuptools, python3-strict-rfc3339 fails to compile with error:
    error: invalid command 'bdist_wheel'
    ERROR: 'python3 setup.py bdist_wheel ' execution failed.

Switching setup import from setuptools._distutils.core to setuptools fixed the issue.

Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
---
 ...setup-from-setuptools-instead-of-dis.patch | 26 +++++++++++++++++++
 .../python/python3-strict-rfc3339_%.bbappend  |  4 +++
 2 files changed, 30 insertions(+)
 create mode 100644 dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339/0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch
 create mode 100644 dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339_%.bbappend

diff --git a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339/0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339/0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch
new file mode 100644
index 0000000..11ca34d
--- /dev/null
+++ b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339/0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch
@@ -0,0 +1,26 @@
+From 1d583ecd2d6376252fcced66068a2482fec0dfbf Mon Sep 17 00:00:00 2001
+From: Soumya Sambu <soumya.sambu@windriver.com>
+Date: Wed, 25 Jun 2025 17:26:35 +0530
+Subject: [PATCH] setup.py: import setup from setuptools instead of distutils
+
+Upstream-Status: Inactive-Upstream [lastcommit: 2016-04-24]
+last commit - https://github.com/danielrichman/strict-rfc3339/commit/abbccd3645d0a34dcbaba55436485951a3b3309c
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


