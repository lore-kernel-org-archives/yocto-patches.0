Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F63CC7115B
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 05:51:40 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.1819.1750917096568869869
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 22:51:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8272e65e7e=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q2JU6m019364
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 22:51:36 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47dv8mmxj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 22:51:35 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 25 Jun 2025 22:51:32 -0700
Received: from blr-linux-engg1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Wed, 25 Jun 2025 22:51:30 -0700
From: ssambu <soumya.sambu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH v2 1/1]  python3-strict-rfc3339: fix invalid command 'bdist_wheel'
Date: Thu, 26 Jun 2025 11:21:29 +0530
Message-ID: <20250626055129.2457115-1-soumya.sambu@windriver.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA0NCBTYWx0ZWRfX4OaGJVHHA5Wn V50H6xqAEFK11Ffsxr0kZfQlNRjNR3S65JVcPeXGHLNVk+2FS/mR/fD4DhWPz4/5IlFG1op8c26 RRpTsZ/x7jKIdwSpCEn0GOnnjoFlPZp1IR4k0oV8ZGOaSc6+ie4ECVFPn+zheZuSUPyDpo5ONlg
 Y9z9bokOzIOp8h7QP8noVPLAkNMk3p5lW1JZoGZc5num8t8YR9Myp0bluyDGJj4h3vb+PGeBlTM c+QDKhbGJB43SAyJleD22QBKdNFdRChMDqcuozVlhk8qeDGP87Ehulf4N4kAhUMThzimm6qH49x x74sXiE2WaxB0GoBN2OEZEijrBTwO54NZjY6ScI5GdLLTHz5lI7SYaM20kfuekqzzyJu/BXwPMw
 lro7ZJ9jxd5GWBQPDLBUbP0mdE0VL7aUZ5qYQE1a4dTFAJyK3BVFc9Hw8ocO7B6kNMF2eIXe
X-Authority-Analysis: v=2.4 cv=MeNsu4/f c=1 sm=1 tr=0 ts=685cdfe7 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=KuCMGVAfJcUA:10 a=6IFa9wvqVegA:10 a=t7CeM3EgAAAA:8 a=m__NNN433p-mM7ecbz8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 6TCC__1pqmJ6v_p9NN7a0GIbbSqnoDZC
X-Proofpoint-ORIG-GUID: 6TCC__1pqmJ6v_p9NN7a0GIbbSqnoDZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_02,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506260044
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 05:51:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1698

From: Soumya Sambu <soumya.sambu@windriver.com>

With mixins setuptools, python3-strict-rfc3339 fails to compile with error:
    error: invalid command 'bdist_wheel'
    ERROR: 'python3 setup.py bdist_wheel ' execution failed.

Switching setup import from setuptools._distutils.core to setuptools fixed the issue.

Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
---
 ...setup-from-setuptools-instead-of-dis.patch | 25 +++++++++++++++++++
 .../python/python3-strict-rfc3339_%.bbappend  |  4 +++
 2 files changed, 29 insertions(+)
 create mode 100644 dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339/0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch
 create mode 100644 dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339_%.bbappend

diff --git a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339/0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339/0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch
new file mode 100644
index 0000000..b0dc119
--- /dev/null
+++ b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-strict-rfc3339/0001-setup.py-import-setup-from-setuptools-instead-of-dis.patch
@@ -0,0 +1,25 @@
+From 1d583ecd2d6376252fcced66068a2482fec0dfbf Mon Sep 17 00:00:00 2001
+From: Soumya Sambu <soumya.sambu@windriver.com>
+Date: Wed, 25 Jun 2025 17:26:35 +0530
+Subject: [PATCH] setup.py: import setup from setuptools instead of distutils
+
+Upstream-Status: Pending [upstream appears unmaintained]
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


