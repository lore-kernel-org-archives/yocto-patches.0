Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDE01099B5F
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:27 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13924.1774405045700778790
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=X3i/7GKE;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P2DEJs3459919
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=x54oqDCImIbXTVy4ZX8xFgEXV2A91Wo8iLJGKMceAtM=; b=X3i/7GKE+58q
	1oFaGGvOctSTSL7S8yp03S10qe5kLDqien45Oi9DAO536fEeGpVosgPLhS9IQ7o3
	e+kKyViIs8ET5odLe8TNAq4aLxDsjZ45RADkjQIMYQzQfcz1k7lslrwJRlsCVWBm
	9fZkGtWqW8FwQeeOcl5dcb5bDCANHA+jVfGYP7jRHXArSa9VTObAoZljpUF94aRV
	zUQxYJ2HoRNNNphuqAtUbxcJr4/EivM5z9WW7xML5kMLtO/v8AnIs47WBTaNFK1N
	mBB3hir6Fz3A8sGxS7G1MmCgaeF3PWGAyKCTt5BtJMf/umFKBlMHGTEge2AUv8Dc
	WNYTm1Kc9w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj84du8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:24 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:22 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:22 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH 2/14] tensorflow-estimator: remove recipe
Date: Wed, 25 Mar 2026 10:17:07 +0800
Message-ID: <20260325021719.1526525-3-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6NJRVO1IfBDjJdnB2VIaP_tsy6z1-C4V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfX2LJ5vIavN3XB
 /75qKxM0+/hn4bCFVl/tBEWF3CLgTzZ9UR/fxMAjTQkxuh1vgEVergvVki+pUAbmMljmfpWFOrc
 64RksYDlGb7KLFJk/IEDX5F33srVd/IddR4sq1m1Rjcm38zp99YmtBYQqtTNuG3b76MGOfwid8b
 2dC+wGv3eHBZWKGnmcdNDcpg9i91KXLbtw7uKQFGKwJS0yFg99ZTj+6ambr9jO8cOW65KdbSqtw
 h6DGygOfcynPLmKViobCdqYBc+Es2QUMMxEO/ocO2OUlLTgIW5UwtD3Vka3sqvKdlgPqFKiZUEm
 1yjB9gEcf5bRq596Alc10i1vLQHIxKHYDMQJ44mbgKkUwTTrFGO6LiREave1/SVUB8aO9igygU+
 YA/t3ArXJlxKQ1zAValxA+sisg+NPS9tTuIn8u0ODLhvXCLQml/HrE/ZbqO4vRoIa0My/zvT9ny
 ekBHWH+lgw/ctMSBfig==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c345b4 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=K--e0_ydhWnr0dFvQTgA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 6NJRVO1IfBDjJdnB2VIaP_tsy6z1-C4V
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
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3538

Due to commit [1], remove Estimator from Tensorflow.

[1] https://github.com/tensorflow/tensorflow/commit/aa35dc27617676322972f2fd482ed43a7a7e1d16

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 .../0001-customize-for-yocto.patch            | 28 ---------
 .../tensorflow/tensorflow-estimator_2.15.0.bb | 57 -------------------
 2 files changed, 85 deletions(-)
 delete mode 100644 recipes-framework/tensorflow/tensorflow-estimator/0001-customize-for-yocto.patch
 delete mode 100644 recipes-framework/tensorflow/tensorflow-estimator_2.15.0.bb

diff --git a/recipes-framework/tensorflow/tensorflow-estimator/0001-customize-for-yocto.patch b/recipes-framework/tensorflow/tensorflow-estimator/0001-customize-for-yocto.patch
deleted file mode 100644
index e9b66d5..0000000
--- a/recipes-framework/tensorflow/tensorflow-estimator/0001-customize-for-yocto.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From a1bcf09a43fc44ad5e04c441ee45cc23d16cf7d2 Mon Sep 17 00:00:00 2001
-From: Hongxu Jia <hongxu.jia@windriver.com>
-Date: Wed, 9 Dec 2020 17:59:01 +0800
-Subject: [PATCH] customize for yocto
-
-Upstream-Status: Inappropriate [oe specific]
-
-Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
----
- tensorflow_estimator/tools/pip_package/build_pip_package.sh | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/tensorflow_estimator/tools/pip_package/build_pip_package.sh b/tensorflow_estimator/tools/pip_package/build_pip_package.sh
-index d4953a6..e08cd8a 100755
---- a/tensorflow_estimator/tools/pip_package/build_pip_package.sh
-+++ b/tensorflow_estimator/tools/pip_package/build_pip_package.sh
-@@ -38,7 +38,7 @@ function prepare_src() {
- 
-   # Verifies all expected files are in pip.
-   # Creates init files in all directory in pip.
--  python tensorflow_estimator/tools/pip_package/create_pip_helper.py --pip-root "${TMPDIR}/tensorflow_estimator/" --bazel-root "./tensorflow_estimator"
-+  nativepython3 tensorflow_estimator/tools/pip_package/create_pip_helper.py --pip-root "${TMPDIR}/tensorflow_estimator/" --bazel-root "./tensorflow_estimator"
- }
- 
- function build_wheel() {
--- 
-2.18.2
-
diff --git a/recipes-framework/tensorflow/tensorflow-estimator_2.15.0.bb b/recipes-framework/tensorflow/tensorflow-estimator_2.15.0.bb
deleted file mode 100644
index dae3ee2..0000000
--- a/recipes-framework/tensorflow/tensorflow-estimator_2.15.0.bb
+++ /dev/null
@@ -1,57 +0,0 @@
-DESCRIPTION = "A high-level TensorFlow API that greatly simplifies machine \
-learning programming."
-LICENSE = "Apache-2.0"
-LIC_FILES_CHKSUM = "file://LICENSE;md5=01e86893010a1b87e69a213faa753ebd"
-
-SRC_URI = "git://github.com/tensorflow/estimator.git;branch=r2.15;protocol=https \
-           file://0001-customize-for-yocto.patch \
-          "
-SRCREV = "b5f91f8e4113396f0a5f090d6a52d676271caf48"
-
-inherit python3native bazel tensorflow_ver
-
-DEPENDS += " \
-    python3-pip-native \
-    python3-wheel-native \
-    python3-six-native \
-    python3-protobuf-native \
-    python3-absl-native \
-    python3-astor-native \
-    python3-gast-native \
-    python3-termcolor-native \
-    python3-wrapt-native \
-    python3-opt-einsum-native \
-    python3-astunparse-native \
-    flatbuffers-native \
-    tensorflow-native \
-    tf-keras-native \
-"
-
-do_compile () {
-    unset CC
-    export TMPDIR="${WORKDIR}"
-    export PYTHON_BIN_PATH="${PYTHON}"
-
-    ${BAZEL} build \
-        --subcommands --explain=${T}/explain.log \
-        --verbose_explanations --verbose_failures \
-        --verbose_failures \
-        --python_path="${PYTHON}" \
-        //tensorflow_estimator/tools/pip_package:build_pip_package
-
-    ${S}/bazel-bin/tensorflow_estimator/tools/pip_package/build_pip_package \
-        ${WORKDIR}/estimator_pip
-}
-
-do_install () {
-    echo "Installing pip package"
-    install -d ${D}${PYTHON_SITEPACKAGES_DIR}
-    ${STAGING_BINDIR_NATIVE}/pip3 install --disable-pip-version-check -v --no-deps \
-        -t ${D}/${PYTHON_SITEPACKAGES_DIR} --no-cache-dir ${WORKDIR}/estimator_pip/*.whl
-
-    rm -rf ${D}/${PYTHON_SITEPACKAGES_DIR}/tensorflow_estimator-${PV}.dist-info
-}
-
-FILES:${PN} += "${libdir}/*"
-
-BBCLASSEXTEND = "native"
-- 
2.34.1


