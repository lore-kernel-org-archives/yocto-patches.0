Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C77103A993
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:39 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13682.1774405048275858755
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=rUsxMDPT;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O4s75f1271651
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=STnJ4pN7NN405pgpwvYC356AeZEqwK+XdoJ0k8UNg4Q=; b=rUsxMDPTMMmY
	Bqj/EP6depNc5XFfLv8n7IuTOzLhQ/GzHxW1RUycWI+BQmPQD4D++kGR0bsg122G
	HOnuZHhvojZuNF+G2z1eLfy/Q99d9Lz/+2H2vK4PEzDcu6BEksxqlDNn1obgA3uM
	molzLw0ly4ApgDQYohPXh3Q42ObCml6r0fG/DfiZzF07uiM5+6uyuHNjaHnu8nsi
	6WKmsmLonKSWzoBUco82dGN6/R2n4Sk/uL08rjQHClwFl2inTJbFHiNA4f7llac3
	xrZF0wmGjFwcEvSDMwBopDXH0vsx0fvJYB1tAx3AtS9komtDD+gCp+DWYl3+vGoU
	FKA0fvfECQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj84duf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:27 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:26 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:26 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH 6/14] python3-opt-einsum: 3.3.0 -> 3.4.0
Date: Wed, 25 Mar 2026 10:17:11 +0800
Message-ID: <20260325021719.1526525-7-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VWWx7OT1Yv5wi2rlpuhihgrTqphVBX_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfXyFoa4g3k00N4
 2pQt16HFdSIeYeHoRCkvbY1Ov//DFZ201FiTA3a/LKltVd2NKrrZenvpg4P2oRD/M9WxuOOjKg8
 1e6tTdpGjYSfdlUfUpHLD6Ip5hYmCe9PRzmqzg1JpCGNqMwKGpLI4StmNfjMnGklDcRo9LtiZig
 qlPYwvqtFGR4hyalEODmEfLHeAkfsAqmqt6L7lHJUlrUGy4dERx0LbWl5VqXmkiznMXz3wSzR91
 urHhghUWvJyMa/IbYDBznRqpMQL1coERv8FdzybmXU3XX3PoXALAcOneZcWXWA4QUO9FjahuWvS
 XfrAf37re8LO6FZbfabbC5deYACGH1YbeNZTQ/vPjan0d5e7MqviZBGvpib4YtupCKDRQx5bqJf
 HbMSYDwhaQifRpnk/8g56Jv00Q1C5wwn3JZYlWIa2Xh6f3Lso1uman7snoK8v8/JOfTF7/fMyUg
 r/yqU2vhAoPPg/Jtiig==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c345b7 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=NEAV23lmAAAA:8 a=HbzeB9StAAAA:8 a=t7CeM3EgAAAA:8
 a=Oflld34ugPiCVbQMrNgA:9 a=i9oqPCtDvve8OcjLCTCP:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: VWWx7OT1Yv5wi2rlpuhihgrTqphVBX_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250015
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3542

Swtich to python_hatchling

Remove obsolete patch
- 0001-Use-ConfigParser-instead-of-SafeConfigParser.patch

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 ...igParser-instead-of-SafeConfigParser.patch | 36 -------------------
 ...m_3.3.0.bb => python3-opt-einsum_3.4.0.bb} | 18 +++++-----
 2 files changed, 8 insertions(+), 46 deletions(-)
 delete mode 100644 recipes-devtools/python/python3-opt-einsum/0001-Use-ConfigParser-instead-of-SafeConfigParser.patch
 rename recipes-devtools/python/{python3-opt-einsum_3.3.0.bb => python3-opt-einsum_3.4.0.bb} (35%)

diff --git a/recipes-devtools/python/python3-opt-einsum/0001-Use-ConfigParser-instead-of-SafeConfigParser.patch b/recipes-devtools/python/python3-opt-einsum/0001-Use-ConfigParser-instead-of-SafeConfigParser.patch
deleted file mode 100644
index 93e3bd8..0000000
--- a/recipes-devtools/python/python3-opt-einsum/0001-Use-ConfigParser-instead-of-SafeConfigParser.patch
+++ /dev/null
@@ -1,36 +0,0 @@
-From 0beacf96923bbb2dd1939a9c59398a38ce7a11b1 Mon Sep 17 00:00:00 2001
-From: Hongxu Jia <hongxu.jia@windriver.com>
-Date: Thu, 17 Nov 2022 17:04:54 -0800
-Subject: [PATCH] Use ConfigParser instead of SafeConfigParser
-
-The SafeConfigParser class will be renamed to ConfigParser in Python
-3.12 [1]. This alias will be removed in future versions.So we can use
-ConfigParser directly instead.
-
-[1] https://github.com/python/cpython/issues/89336
-
-Upstream-Status: Submitted [https://github.com/dgasmith/opt_einsum/pull/208]
-Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
----
- versioneer.py | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
-
-diff --git a/versioneer.py b/versioneer.py
-index d3db643..6d732af 100644
---- a/versioneer.py
-+++ b/versioneer.py
-@@ -339,9 +339,9 @@ def get_config_from_root(root):
-     # configparser.NoOptionError (if it lacks "VCS="). See the docstring at
-     # the top of versioneer.py for instructions on writing your setup.cfg .
-     setup_cfg = os.path.join(root, "setup.cfg")
--    parser = configparser.SafeConfigParser()
-+    parser = configparser.ConfigParser()
-     with open(setup_cfg, "r") as f:
--        parser.readfp(f)
-+        parser.read_file(f)
-     VCS = parser.get("versioneer", "VCS")  # mandatory
- 
-     def get(parser, name):
--- 
-2.37.1
-
diff --git a/recipes-devtools/python/python3-opt-einsum_3.3.0.bb b/recipes-devtools/python/python3-opt-einsum_3.4.0.bb
similarity index 35%
rename from recipes-devtools/python/python3-opt-einsum_3.3.0.bb
rename to recipes-devtools/python/python3-opt-einsum_3.4.0.bb
index ea9b29e..2c4aba9 100644
--- a/recipes-devtools/python/python3-opt-einsum_3.3.0.bb
+++ b/recipes-devtools/python/python3-opt-einsum_3.4.0.bb
@@ -4,19 +4,17 @@ SECTION = "devel/python"
 LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=5ab423c88cf3e69553decf93419f53ac"
 
-SRC_URI[md5sum] = "acf0a3997aab84b4e9a854296cc34971"
-SRC_URI[sha256sum] = "59f6475f77bbc37dcf7cd748519c0ec60722e91e63ca114e68821c0c54a46549"
+SRC_URI[sha256sum] = "96ca72f1b886d148241348783498194c577fa30a8faac108586b14f1ba4473ac"
 
-inherit pypi setuptools3
+inherit pypi python_hatchling
 
-SRCNAME = "opt_einsum"
-PYPI_SRC_URI = "https://files.pythonhosted.org/packages/source/o/${PYPI_PACKAGE}/${SRCNAME}-${PV}.tar.gz"
-SRC_URI += " \
-    file://0001-Use-ConfigParser-instead-of-SafeConfigParser.patch \
-"
+PYPI_PACKAGE = "opt_einsum"
 
-UPSTREAM_CHECK_PYPI_PACKAGE = "opt_einsum"
+DEPENDS += " \
+    python3-hatch-vcs-native \
+    python3-hatch-fancy-pypi-readme-native \
+"
 
-S = "${UNPACKDIR}/${SRCNAME}-${PV}"
+UPSTREAM_CHECK_PYPI_PACKAGE = "${PYPI_PACKAGE}"
 
 BBCLASSEXTEND = "native"
-- 
2.34.1


