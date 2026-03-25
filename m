Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D578C103A98E
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:38 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13925.1774405047751874579
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=VTedAEf7;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O4s75e1271651
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=wF6WYMRkZXsCvE09Hdn6Pqv1u8nlkANbku3XhBi5j8Y=; b=VTedAEf7fNhH
	HJCpl0Qm/E9VAg/Z/RhM0HVhpAevaJETz6YHKzl/esEYHYgJfcZ2c5e+MpV0p/v8
	t//W0Bd1KFdVpQlJNLTKExDJDhBYtqopOZxcpjyhRpHe8CmK6eo0bMPgJ1/lsMKj
	TMh6qzn+DvYXJ4qK56LqH/kjRYGynvFVUpP9qR7lyNX0KmRaleyGnZ+xHAt3dJwO
	8JbBmvQ0udrbMewHgtkTf8W6MuDCQR98zNGSOK5p+amxlXa/lkn0hbGzqnKr8gWP
	zxodsaEs7KAqe4e0piYm3EVe3WfkYgbeTM1eXEnFMguUUEEMt4+sN8qxQxasaVvD
	0sBXRaUntQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj84duf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:26 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:25 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:25 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH 5/14] python3-mldtypes: 0.5.1 -> 0.5.4
Date: Wed, 25 Mar 2026 10:17:10 +0800
Message-ID: <20260325021719.1526525-6-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -aJAao2ikpIwaba0Ce6KxC3C_JWMVDKo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfX+l5JDkCBHo+s
 7K6D5qyaTU9AexEkKwqerTPaYN4C4FikdwGnXpxq28Oquqkrda4FzlGuGMAtWjP9WDONO6vs3Jm
 Ot+vIzmsKC9A4hI0/4q5oi5WRnz4pp6cta7hFEmlzkI6+FjYjcucrciMoDPZTa7o2ni95npHvW0
 h+M/ex7avClVskTkKJpIg9UDE1on6xIrd2L7o5CTIBJuOmMEoh9VhHeMDay1P7dVp1SfzTeVtSn
 ECVz4aMlk0wn4Q1mOnRv3PfqioFiGqbIdWFBhUsVZW+2fIANCXeXaFLNc5dXeyWAbbpvYI9KkT3
 KJtBeCQdZcGbJBZHq0noJkFxTiZksfSlDluTx7YcJIZQbkUr6vuv2fTFnlYrDcDZo1ZXiLmsNPA
 DJs4pgWXtopkVwzO8YGwajoK1KrryzKifFddFzZxEZqSy+/jCENh5+6LJ6cE9/Tkss5PKIbSCWa
 GM6w0WEWqopD/S97VRg==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c345b6 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=NEAV23lmAAAA:8 a=HbzeB9StAAAA:8 a=CckQENj0AAAA:8
 a=t7CeM3EgAAAA:8 a=A4dEprmB_3ZYHXtV3MoA:9 a=i9oqPCtDvve8OcjLCTCP:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: -aJAao2ikpIwaba0Ce6KxC3C_JWMVDKo
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
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3541

Remove obsolete patch
- 0001-fix-setuptools-missing.patch

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 .../0001-fix-setuptools-missing.patch         | 30 -------------------
 ...pes_0.5.1.bb => python3-mldtypes_0.5.4.bb} |  9 ++----
 2 files changed, 3 insertions(+), 36 deletions(-)
 delete mode 100644 recipes-devtools/python/python3-mldtypes/0001-fix-setuptools-missing.patch
 rename recipes-devtools/python/{python3-mldtypes_0.5.1.bb => python3-mldtypes_0.5.4.bb} (60%)

diff --git a/recipes-devtools/python/python3-mldtypes/0001-fix-setuptools-missing.patch b/recipes-devtools/python/python3-mldtypes/0001-fix-setuptools-missing.patch
deleted file mode 100644
index 612f6af..0000000
--- a/recipes-devtools/python/python3-mldtypes/0001-fix-setuptools-missing.patch
+++ /dev/null
@@ -1,30 +0,0 @@
-From 1d24be92b58f2a72fc8e53b5a7e09b4dbcca0795 Mon Sep 17 00:00:00 2001
-From: Hongxu Jia <hongxu.jia@windriver.com>
-Date: Fri, 21 Mar 2025 20:49:35 -0700
-Subject: [PATCH] fix setuptools missing
-
-|ERROR Missing dependencies:
-|    setuptools~=75.7.0
-
-Upstream-Status: Inappropriate [oe specific]
-
-Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
----
- pyproject.toml | 1 -
- 1 file changed, 1 deletion(-)
-
-diff --git a/pyproject.toml b/pyproject.toml
-index c040eb3..881a99b 100644
---- a/pyproject.toml
-+++ b/pyproject.toml
-@@ -52,7 +52,6 @@ requires = [
-     # We build against the most recent supported NumPy 2.0 release;
-     # see https://github.com/numpy/numpy/issues/27265
-     "numpy~=2.0",
--    "setuptools~=75.7.0",
- ]
- build-backend = "setuptools.build_meta"
- 
--- 
-2.25.1
-
diff --git a/recipes-devtools/python/python3-mldtypes_0.5.1.bb b/recipes-devtools/python/python3-mldtypes_0.5.4.bb
similarity index 60%
rename from recipes-devtools/python/python3-mldtypes_0.5.1.bb
rename to recipes-devtools/python/python3-mldtypes_0.5.4.bb
index 9a72066..f7d5777 100644
--- a/recipes-devtools/python/python3-mldtypes_0.5.1.bb
+++ b/recipes-devtools/python/python3-mldtypes_0.5.4.bb
@@ -4,16 +4,13 @@ SECTION = "devel/python"
 LICENSE = "Apache-2.0"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
 
-SRC_URI[sha256sum] = "ac5b58559bb84a95848ed6984eb8013249f90b6bab62aa5acbad876e256002c9"
+SRC_URI[sha256sum] = "8ab06a50fb9bf9666dd0fe5dfb4676fa2b0ac0f31ecff72a6c3af8e22c063453"
 
 inherit pypi python_setuptools_build_meta
 
-SRCNAME ?= "ml_dtypes"
-PYPI_SRC_URI = "https://files.pythonhosted.org/packages/32/49/6e67c334872d2c114df3020e579f3718c333198f8312290e09ec0216703a/${SRCNAME}-${PV}.tar.gz"
-SRC_URI += "file://0001-fix-setuptools-missing.patch"
-S = "${UNPACKDIR}/${SRCNAME}-${PV}"
+PYPI_PACKAGE = "ml_dtypes"
 
-UPSTREAM_CHECK_PYPI_PACKAGE = "ml_dtypes"
+UPSTREAM_CHECK_PYPI_PACKAGE = "${PYPI_PACKAGE}"
 UPSTREAM_CHECK_URI = "https://pypi.org/simple/${UPSTREAM_CHECK_PYPI_PACKAGE}/"
 
 DEPENDS = " \
-- 
2.34.1


